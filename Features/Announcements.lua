local ADDON_NAME, ns = ...

local L = ns.L
local GetColor = ns.GetColor

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

local string_byte = string.byte
local string_format = string.format
local string_sub = string.sub
local unpack = unpack

--------------------------------------------------------------------------------
-- Sound Registration
--------------------------------------------------------------------------------

-- Every entry is a file this add-on ships, so the path is built the same way for
-- all of them.
for _, row in ipairs(ns.SOUNDS) do
	local name, file = row[1], row[2]
	LibSharedMedia:Register("sound", name, "Interface\\AddOns\\" .. ADDON_NAME .. "\\Includes\\Sounds\\" .. file)
end

function ns:PlayAlertSound(soundName)
	if not soundName or soundName == "" or soundName == ns.SOUND_NONE then
		return
	end
	local file = LibSharedMedia:Fetch("sound", soundName, true)
	if file then
		PlaySoundFile(file, "Master")
	end
end

--------------------------------------------------------------------------------
-- Player Prints
--------------------------------------------------------------------------------

-- Format: |cff[INFO]Control Freak|r |cff[SEPARATOR]//|r |cff[TEXT]Message|r
function ns:PrintMessage(message)
	print(
		GetColor("INFO")
			.. L["ADDON_TITLE"]
			.. "|r "
			.. GetColor("SEPARATOR")
			.. "//"
			.. "|r "
			.. GetColor("TEXT")
			.. message
			.. "|r"
	)
end

-- Alerts brand as a suffix so the body's own raid-icon mark reads as the only
-- target in the line.
function ns:PrintAlert(body)
	print(body .. " " .. GetColor("SEPARATOR") .. "//" .. "|r " .. GetColor("INFO") .. L["ADDON_TITLE"] .. "|r")
end

function ns:PrintWelcome()
	if not ns.db.profile.showWelcome then
		return
	end
	ns:PrintMessage(string_format(L["CHAT_LOADED"], ns.Version))
end

--------------------------------------------------------------------------------
-- Sent Messages
--------------------------------------------------------------------------------

function ns:GetGroupChatChannel()
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
		return "INSTANCE_CHAT"
	end
	if IsInRaid() then
		return "RAID"
	end
	if IsInGroup() then
		return "PARTY"
	end
	return nil
end

function ns:BuildAnnounceMessage(formatKey, ...)
	local template = L[formatKey]
	if not template then
		return nil
	end
	local body = ns.StripChatFormatting(string_format(template, ...))
	return body .. " // " .. L["ADDON_TITLE"]
end

--[[
    A byte cut is not a safe cut, and both ways of getting it wrong are silent.
    The client refuses a message holding a broken escape and drops it with no
    error, so a cut landing inside a spell link loses the whole alert rather than
    its tail; a cut inside a multi-byte character leaves a mangled letter, which
    every locale but English hits first.

    So the length is walked rather than measured: one pass counts how many
    escapes are open, and the answer is the last point where none of them was and
    no character was half written. The counter is one number for all three kinds
    because they nest -- a spell link is |cff...|Hspell:id:0|h[Name]|h|r, which
    only returns to zero at its very end.
]]
local ESCAPE_DEPTH = {
	["|"] = 0, -- an escaped pipe, complete in itself
	c = 1,
	r = -1,
	H = 2, -- two |h close a link
	h = -1,
	T = 1,
	t = -1,
}

local function SafeCutLength(text, limit)
	if #text <= limit then
		return #text
	end

	local depth = 0
	local safe = 0
	local index = 1

	while index <= limit do
		if string_byte(text, index) == 124 then -- "|"
			local delta = ESCAPE_DEPTH[string_sub(text, index + 1, index + 1)]
			if delta then
				depth = depth + delta
				if depth < 0 then
					depth = 0
				end
			end
			index = index + 2
		else
			index = index + 1
		end

		-- The index test is the escape straddling the limit: a two-byte escape
		-- read at the limit lands one past it, and that is not a length to cut to.
		if depth == 0 and index - 1 <= limit then
			-- A continuation byte at the cut means the character carries on past
			-- it, so the boundary is further along.
			local nextByte = string_byte(text, index)
			if not nextByte or nextByte < 128 or nextByte > 191 then
				safe = index - 1
			end
		end
	end

	return safe
end

function ns:Announce(channel, target, formatKey, ...)
	if not channel then
		return
	end
	local message = ns:BuildAnnounceMessage(formatKey, ...)
	if not message then
		return
	end
	if #message > ns.CHAT_MESSAGE_MAX_LENGTH then
		-- Drop the brand before cutting the body: the body is the information.
		message = ns.StripChatFormatting(string_format(L[formatKey], ...))
		if #message > ns.CHAT_MESSAGE_MAX_LENGTH then
			local length = SafeCutLength(message, ns.CHAT_MESSAGE_MAX_LENGTH)
			if length <= 0 then
				return
			end
			message = string_sub(message, 1, length)
		end
	end
	SendChatMessage(message, channel, nil, target)
end

--------------------------------------------------------------------------------
-- Alerts
--------------------------------------------------------------------------------

-- An alert's arguments arrive as parts so one locale format renders twice: rich
-- for the local print, plain for chat. A part that is not a table passes through.
function ns.PlayerPart(name, guid, class)
	return { kind = "player", name = name, guid = guid, class = class }
end

function ns.SpellPart(spellId, spellName)
	return { kind = "spell", spellId = spellId, spellName = spellName }
end

function ns.TargetPart(name, raidIconIndex)
	return { kind = "target", name = name, raidIconIndex = raidIconIndex }
end

local function RenderPart(part, rich)
	if type(part) ~= "table" then
		return part
	end

	if part.kind == "player" then
		local name = ns.ShortName(part.name)
		if rich then
			return ns.GetClassColor(part.guid, part.class) .. name .. "|r"
		end
		return name
	end

	if part.kind == "spell" then
		return ns.GetSpellDisplay(part.spellId, part.spellName)
	end

	if part.kind == "target" then
		local name = part.name or L["UNKNOWN_TARGET"]
		local icon = rich and ns.GetRaidIconTexture(part.raidIconIndex) or ns.GetRaidIconToken(part.raidIconIndex)
		if icon == "" then
			return name
		end
		return icon .. " " .. name
	end

	return tostring(part)
end

-- A missing scope means ALL: a block that draws no selector covers everybody, and
-- so does a profile written before the setting existed.
local function PassesScope(scope, sourceFlags)
	return scope ~= "MINE" or ns.IsMineSource(sourceFlags)
end

--[[
    Not a hot path: the combat-log filter has already matched a tracked ability
    from a group member and cleared the dedupe, so the render buffers are built
    per call rather than shared. A shared buffer would be one nested alert away
    from rendering the wrong line.

    sourceFlags and destGUID are the two things every caller already holds and the
    gates here need: the affiliation bits say whose cast it was, and the guid is
    what the boss filter resolves to a unit. A caller whose alert has no enemy
    target -- the bubble annoyance lands on a friendly tank -- passes nil, and the
    filter lets it through rather than testing a player's classification.
]]
function ns:Alert(settings, formatKey, parts, sourceFlags, destGUID)
	if not settings or not settings.enabled then
		return
	end

	--[[
	    The add-on reports what the PLAYER'S GROUP does and nothing else, and this
	    is where that is guaranteed rather than remembered. Every dispatch in
	    Features/Combat-Log.lua also bails early on an outsider, which saves the
	    work; this one exists because SPELL_INTERRUPT once did not, and a mob
	    kicking the player's heal was announced to the raid as though a group member
	    had done something useful.

	    A group member's PET counts as the group. The combat log's MINE and PARTY
	    affiliation cover it, and a Felhunter's Spell Lock is a real interrupt --
	    the Bad Pet tab exists precisely because pets act on their own.
	]]
	if not ns.IsGroupSource(sourceFlags) then
		return
	end

	-- Explicitly false, never falsy: ns.IsBossEnemy answers nil when nothing on
	-- screen pointed at the mob, and going quiet on an unanswerable question would
	-- swallow the boss taunt this filter was turned on for.
	if settings.bossOnly and ns.IsBossEnemy(destGUID) == false then
		return
	end

	--[[
	    The two outputs carry their own scope, so a player can watch the whole
	    group and narrate only themselves -- which is the setup the defaults ship.

	    The SOUND follows the print scope rather than carrying a third one. Print
	    and sound are both the player's own window, and a sound with no line to
	    explain it is exactly the noise this add-on exists to cut.
	]]
	local seen = PassesScope(settings.printScope, sourceFlags)

	if settings.sound and seen then
		ns:PlayAlertSound(settings.soundName)
	end

	local count = #parts

	if settings.print and seen then
		local rendered = {}
		for index = 1, count do
			rendered[index] = RenderPart(parts[index], true)
		end
		ns:PrintAlert(string_format(L[formatKey], unpack(rendered, 1, count)))
	end

	if settings.announce and PassesScope(settings.announceScope, sourceFlags) then
		-- Group chat only. The client silently drops an add-on's SAY or YELL
		-- outside a dungeon or raid, so those are not on offer.
		local channel = ns:GetGroupChatChannel()
		if channel then
			local rendered = {}
			for index = 1, count do
				rendered[index] = RenderPart(parts[index], false)
			end
			ns:Announce(channel, nil, formatKey, unpack(rendered, 1, count))
		end
	end
end
