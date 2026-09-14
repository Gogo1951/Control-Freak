local ADDON_NAME, ns = ...

local L = ns.L
local GetColor = ns.GetColor

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

local string_byte = string.byte
local string_format = string.format
local string_gsub = string.gsub
local string_sub = string.sub
local unpack = unpack

--------------------------------------------------------------------------------
-- Sound Registration
--------------------------------------------------------------------------------

--[[
    Every entry is a file this add-on ships, so the path is built the same way for
    all of them.
]]
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

--[[
    Alerts brand as a suffix so the body's own raid-icon mark reads as the only
    target in the line.
]]
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
-- Raid Icons
--------------------------------------------------------------------------------

--[[
    Both renderings, built from ns.RAID_ICONS so the paths live in one place.
    The texture escape is what a LOCAL PRINT uses, so the player sees the actual
    mark. Its size argument is 0, which sizes the icon to the line height rather
    than forcing a pixel count. The {rtN} token is for SENT chat only: texture
    escapes do not survive SendChatMessage, and the client renders the token into
    the mark on the receiving end.
]]
local RAID_ICON_TEXTURES = {}
local RAID_ICON_TOKENS = {}
for index, texture in ipairs(ns.RAID_ICONS) do
	RAID_ICON_TEXTURES[index] = "|T" .. texture .. ":0|t"
	RAID_ICON_TOKENS[index] = "{rt" .. index .. "}"
end

function ns.GetRaidIconTexture(index)
	return index and RAID_ICON_TEXTURES[index] or ""
end

function ns.GetRaidIconToken(index)
	return index and RAID_ICON_TOKENS[index] or ""
end

--------------------------------------------------------------------------------
-- Chat Formatting
--------------------------------------------------------------------------------

--[[
    Texture escapes never survive SendChatMessage, so a sent body swaps its
    raid-icon texture for the {rtN} token, which the receiving client renders as
    the mark.

    Colors are left alone, and that is load-bearing. A spell link is
    |cff...|Hspell:id:0|h[Name]|h|r, one escape sequence: strip the color wrapper
    and what is left is a malformed link, which the client refuses to send. It
    drops the whole message with no error, so the alert simply never arrives.
    Never strip pipes here, wholesale or by escape.
]]
function ns.StripChatFormatting(text)
	if not text then
		return nil
	end
	return (string_gsub(text, "|T[Ii]nterface[\\/]TargetingFrame[\\/]UI%-RaidTargetingIcon_(%d)[^|]*|t", "{rt%1}"))
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

		--[[
		    The index test is the escape straddling the limit: a two-byte escape
		    read at the limit lands one past it, and that is not a length to cut to.
		]]
		if depth == 0 and index - 1 <= limit then
			--[[
			    A continuation byte at the cut means the character carries on past
			    it, so the boundary is further along.
			]]
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

--[[
    An alert's arguments arrive as parts so one locale format renders twice: rich
    for the local print, plain for chat. A part that is not a table passes through.
]]
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

--[[
    Where this event's line goes. A section keeps one row for the player's own
    casts and one for everybody else's (ns.ALERT_OUTPUTS); the event picks its
    row by the combat log's affiliation bit, and the row's output says print or
    announce -- one line, one place, never both. A row that is switched off
    answers neither.
]]
local function ResolveOutputs(settings, sourceFlags, rowKey)
	--[[
	    rowKey names the row outright, for a section whose pair does not split on
	    whose cast it was. Incapacitated is the only one: the game reports the
	    player's own losses of control and nobody else's, so affiliation would
	    pick the same row every time, and what its two rows actually separate is
	    a short effect from a long one.
	]]
	local row = rowKey and settings[rowKey] or (ns.IsMineSource(sourceFlags) and settings.mine or settings.others)
	if not row or not row.enabled then
		return false, false
	end
	local output = ns.ResolveChoice(row.output, ns.ALERT_OUTPUTS, ns.ALERT_OUTPUT_DEFAULT)
	return output == "PRINT", output == "ANNOUNCE"
end

--[[
    Whether the mob is worth this section's attention. A section carries a rung
    of ns.TARGET_RUNGS and the mob has to sit on it or above.

    The mark is tested FIRST and answers on its own, because it OVERRIDES the
    rung rather than narrowing alongside it: a raid mark is the group saying
    which mob matters, so a marked target counts whatever the ladder is set to.
    Testing it first is also what makes it cheap -- the combat log carries the
    mark on every line, so a marked mob is answered by one nil check where the
    rung may walk every name plate on screen.

    A mob that cannot be classified passes: ns.GetEnemyTier answers nil when
    nothing on screen pointed at it, and going quiet on an unanswerable question
    would swallow the boss taunt the filter was turned on for. So the test is
    against nil by name, never a falsy check.

    A section whose line names no mob -- AOE Taunts, Fears, Novas -- carries
    neither key and passes both tests. Nothing to filter is a pass.
]]
local function PassesTargetFilter(settings, destGUID, raidIconIndex)
	if settings.alwaysWhenMarked and raidIconIndex then
		return true
	end

	if not settings.against then
		return true
	end
	local threshold = ns.TARGET_TIER[settings.against] or ns.TARGET_TIER[ns.TARGET_RUNG_DEFAULT]
	if threshold <= ns.TARGET_TIER.ALL then
		return true
	end
	local tier = ns.GetEnemyTier(destGUID)
	return tier == nil or tier >= threshold
end

--[[
    Everything a section decides before it knows whose row a line belongs to:
    the section's own switch, that the cast came from the player's group, and
    the target filters. A whisper is not one of the alert's outputs, so the
    features that send one ask this directly rather than reading the rows, and
    ask it BEFORE their cooldown, so an event the filters drop neither whispers
    nor uses the cooldown up.

    The group test is guaranteed here rather than remembered. Every dispatch in
    Features/Combat-Log.lua also bails early on an outsider, which saves the
    work; this one makes sure a dispatch missing that early test still cannot
    announce a mob's cast as a group member's.

    A group member's PET counts as the group. The combat log's MINE and PARTY
    affiliation cover it, and a Felhunter's Spell Lock is a real interrupt --
    the Bad Pets tab exists precisely because pets act on their own.
]]
function ns:PassesAlertGates(settings, sourceFlags, destGUID, raidIconIndex)
	if not settings or not settings.enabled then
		return false
	end
	if not ns.IsGroupSource(sourceFlags) then
		return false
	end
	return PassesTargetFilter(settings, destGUID, raidIconIndex)
end

--[[
    Not a hot path: the combat-log filter has already matched a tracked ability
    from a group member and cleared the dedupe, so the render buffers are built
    per call rather than shared. A shared buffer would be one nested alert away
    from rendering the wrong line.

    sourceFlags, destGUID and raidIconIndex are the three things every caller
    already holds and the gates here need: the affiliation bits say whose cast
    it was, the guid is what the target filter resolves to a unit, and the index
    is the raid mark on the mob, which the mark override reads. A caller
    whose alert has no enemy target -- a bad shield lands on a friendly tank --
    passes nil for both, and the rung filter lets it through rather than testing
    a player's classification.
]]
function ns:Alert(settings, formatKey, parts, sourceFlags, destGUID, raidIconIndex, rowKey)
	if not ns:PassesAlertGates(settings, sourceFlags, destGUID, raidIconIndex) then
		return
	end

	--[[
	    The gates above have already run the target filter, and ns.GetEnemyTier
	    keeps its answer per mob, so which of the two runs first costs nothing.
	]]
	local doPrint, doAnnounce = ResolveOutputs(settings, sourceFlags, rowKey)

	--[[
	    Group chat only. The client silently drops an add-on's SAY or YELL
	    outside a dungeon or raid, so those are not on offer. A battleground or
	    arena is skipped too: its chat is a crowd of strangers rather than the
	    group these alerts are for. With no group chat to go to, an announced
	    line goes nowhere at all.
	]]
	local channel
	if doAnnounce then
		local _, instanceType = IsInInstance()
		if instanceType ~= "pvp" and instanceType ~= "arena" then
			channel = ns:GetGroupChatChannel()
		end
		doAnnounce = channel ~= nil
	end

	--[[
	    Past this point the line is going somewhere the player reads, their own
	    window or group chat, so the sound always has a line to explain it. A
	    sound with no line to explain it is exactly the noise this add-on exists
	    to cut.
	]]
	if not doPrint and not doAnnounce then
		return
	end

	if settings.sound then
		ns:PlayAlertSound(settings.soundName)
	end

	local count = #parts

	if doPrint then
		local rendered = {}
		for index = 1, count do
			rendered[index] = RenderPart(parts[index], true)
		end
		ns:PrintAlert(string_format(L[formatKey], unpack(rendered, 1, count)))
	end

	if doAnnounce then
		local rendered = {}
		for index = 1, count do
			rendered[index] = RenderPart(parts[index], false)
		end
		ns:Announce(channel, nil, formatKey, unpack(rendered, 1, count))
	end
end

--[[
    The print-only half of the above, for a line that has no business in group
    chat at all. Tank Deaths' class log is the one caller: a watch list somebody
    keeps for themselves, so its rows draw no destination dropdown, and there is
    nothing here for ResolveOutputs to resolve.

    No alert gates either. Those answer "was this cast ours, is the mob worth
    mentioning, is it marked" -- and a death has no caster and no mob. The
    feature's scope gates are asked by the handler, the way Incapacitated's are.

    No sound, because the log is the half of that tab that stays quiet on
    purpose. The tank death beside it goes through ns:Alert and brings its own.
]]
function ns:PrintLine(formatKey, parts)
	local count = #parts
	local rendered = {}
	for index = 1, count do
		rendered[index] = RenderPart(parts[index], true)
	end
	ns:PrintAlert(string_format(L[formatKey], unpack(rendered, 1, count)))
end
