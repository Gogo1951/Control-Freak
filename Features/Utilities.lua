local _, ns = ...

local L = ns.L

local bit_band = bit.band
local string_find = string.find
local string_gsub = string.gsub

--------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------

local COLORS = {}
for key, hex in pairs(ns.PALETTE) do
	COLORS[key] = "|cff" .. hex
end

function ns.GetColor(key)
	return COLORS[key] or COLORS.TEXT
end

local CLASS_COLORS = {}
for class, hex in pairs(ns.CLASS_COLORS) do
	CLASS_COLORS[class] = "|cff" .. hex
end

-- A plain find rather than a substring compare: it runs on every combat-log line
-- and sub() would allocate a six-character string each time to throw away.
function ns.IsPlayerGUID(guid)
	return type(guid) == "string" and string_find(guid, "Player", 1, true) == 1
end

--[[
    The guid answers first, and the class token is the fallback for a name that
    has no player guid behind it. A pet's guid carries no class, so a pet is
    colored by the class of the ability it cast: a Growl is a hunter's, a Torment
    a warlock's.
]]
function ns.GetClassColor(guid, class)
	if ns.IsPlayerGUID(guid) then
		local _, guidClass = GetPlayerInfoByGUID(guid)
		local color = guidClass and CLASS_COLORS[guidClass]
		if color then
			return color
		end
	end
	return (class and CLASS_COLORS[class]) or COLORS.MUTED
end

--------------------------------------------------------------------------------
-- Spell API Shims
--------------------------------------------------------------------------------

-- Picked by availability, never by result: a call that legitimately returns nil
-- must not fall through to the other namespace.
local HAS_C_SPELL_LINK = C_Spell and C_Spell.GetSpellLink and true or false
local HAS_C_SPELL_INFO = C_Spell and C_Spell.GetSpellInfo and true or false

--[[
    Era hands back a bare spell name where a link belongs, so an alert prints
    plain text where a clickable spell should be. The API is still chosen by
    availability rather than by result; what is tested here is the SHAPE of the
    answer, and a name is not a link. Rebuild it from the id instead of shipping
    the name.
]]
local function AsSpellLink(answer, spellId)
	if type(answer) == "string" and answer:find("|Hspell:", 1, true) then
		return answer
	end
	local name = (type(answer) == "string" and answer ~= "") and answer or ns.GetSpellNameAndIcon(spellId)
	if not name then
		return nil
	end
	return "|cff" .. ns.SPELL_LINK_COLOR .. "|Hspell:" .. spellId .. ":0|h[" .. name .. "]|h|r"
end

function ns.GetSpellLink(spellId)
	if HAS_C_SPELL_LINK then
		return AsSpellLink(C_Spell.GetSpellLink(spellId), spellId)
	end
	return AsSpellLink(GetSpellLink(spellId), spellId)
end

function ns.GetSpellNameAndIcon(spellId)
	if HAS_C_SPELL_INFO then
		local info = C_Spell.GetSpellInfo(spellId)
		if not info then
			return nil
		end
		return info.name, info.iconID
	end
	local name, _, icon = GetSpellInfo(spellId)
	return name, icon
end

--[[
    The combat log hands us a name alongside the id, so an id this client has
    never cached still renders as readable text rather than a nil.

    A zero id is treated as no id at all. Era reports the interrupted spell of a
    SPELL_INTERRUPT as 0, and printing that raw put a literal "[0]" in the alert
    where the spell name belongs.
]]
function ns.GetSpellDisplay(spellId, fallbackName)
	local known = spellId and spellId ~= 0
	if known then
		local link = ns.GetSpellLink(spellId)
		if link then
			return link
		end
	end
	local name = (known and ns.GetSpellNameAndIcon(spellId)) or fallbackName
	if name and name ~= "" then
		return "[" .. name .. "]"
	end
	return L["UNKNOWN_SPELL"]
end

--------------------------------------------------------------------------------
-- Game Flavor
--------------------------------------------------------------------------------

--[[
    Which column of Data/Abilities.lua's flavors list this client reads.

    Season of Discovery shares Era's WOW_PROJECT_ID, so the project alone cannot
    separate them and engraving is the probe that can. Resolved on first call and
    kept: no event changes the answer mid-session.

    The first caller is ns.BuildAbilityIndex on PLAYER_LOGIN, deliberately not
    file scope -- engraving does not answer until the character is in, and the SoD
    column carries taunts no other flavor has (Tease, Demonic Howl, the taunting
    Earth Shock). Resolving too early would read Era and lose all of them.

    Anything past Wrath reads the Wrath column rather than failing closed.
]]
local FLAVOR_ERA, FLAVOR_SOD, FLAVOR_TBC, FLAVOR_WRATH = 1, 2, 3, 4

local function IsSeasonOfDiscovery()
	if not C_Engraving or not C_Engraving.IsEngravingEnabled then
		return false
	end
	local ok, enabled = pcall(C_Engraving.IsEngravingEnabled)
	return ok and enabled == true
end

local flavorIndex

function ns.GetFlavorIndex()
	if not flavorIndex then
		if WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
			flavorIndex = FLAVOR_TBC
		elseif WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
			flavorIndex = IsSeasonOfDiscovery() and FLAVOR_SOD or FLAVOR_ERA
		else
			flavorIndex = FLAVOR_WRATH
		end
	end
	return flavorIndex
end

function ns.GetFlavorName()
	return ns.FLAVOR_NAMES[ns.GetFlavorIndex()] or "?"
end

--------------------------------------------------------------------------------
-- Raid Icons
--------------------------------------------------------------------------------

local RAID_ICON_INDEX = {
	[COMBATLOG_OBJECT_RAIDTARGET1] = 1,
	[COMBATLOG_OBJECT_RAIDTARGET2] = 2,
	[COMBATLOG_OBJECT_RAIDTARGET3] = 3,
	[COMBATLOG_OBJECT_RAIDTARGET4] = 4,
	[COMBATLOG_OBJECT_RAIDTARGET5] = 5,
	[COMBATLOG_OBJECT_RAIDTARGET6] = 6,
	[COMBATLOG_OBJECT_RAIDTARGET7] = 7,
	[COMBATLOG_OBJECT_RAIDTARGET8] = 8,
}

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

function ns.GetRaidIconIndex(destRaidFlags)
	if not destRaidFlags then
		return nil
	end
	return RAID_ICON_INDEX[bit_band(destRaidFlags, COMBATLOG_OBJECT_RAIDTARGET_MASK)]
end

function ns.GetRaidIconTexture(index)
	return index and RAID_ICON_TEXTURES[index] or ""
end

function ns.GetRaidIconToken(index)
	return index and RAID_ICON_TOKENS[index] or ""
end

--------------------------------------------------------------------------------
-- Names
--------------------------------------------------------------------------------

function ns.ShortName(name)
	if not name then
		return L["UNKNOWN_SOURCE"]
	end
	return Ambiguate(name, "short")
end

--------------------------------------------------------------------------------
-- Combat Log Flags
--------------------------------------------------------------------------------

-- Affiliation runs MINE (1), PARTY (2), RAID (4), OUTSIDER (8), so anything
-- below OUTSIDER is us or someone grouped with us. Reading the flags beats
-- UnitInParty/UnitInRaid: no API call, and it is correct for pets too.
function ns.IsGroupSource(sourceFlags)
	if not sourceFlags then
		return false
	end
	return bit_band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MASK) < COMBATLOG_OBJECT_AFFILIATION_OUTSIDER
end

function ns.IsPetSource(sourceFlags)
	if not sourceFlags then
		return false
	end
	if bit_band(sourceFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0 then
		return true
	end
	return bit_band(sourceFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0
end

-- Whether a cast is the player's own, which is what the two announce toggles
-- split on. MINE covers the player and the player's own pet -- that is exactly
-- what the log's MINE affiliation means -- so the pet case needs no handling.
function ns.IsMineSource(sourceFlags)
	if not sourceFlags then
		return false
	end
	return bit_band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MASK) == COMBATLOG_OBJECT_AFFILIATION_MINE
end

--------------------------------------------------------------------------------
-- Group Lookups
--------------------------------------------------------------------------------

-- The owner's pet is addressed as "partypetN" / "raidpetN", never "partyNpet".
function ns.FindPetOwner(petGUID)
	if not petGUID then
		return nil
	end

	if UnitGUID("pet") == petGUID then
		return "player", GetUnitName("player", true), UnitGUID("player")
	end

	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			if UnitGUID("raidpet" .. i) == petGUID then
				local unit = "raid" .. i
				return unit, GetUnitName(unit, true), UnitGUID(unit)
			end
		end
	elseif IsInGroup() then
		for i = 1, 4 do
			if UnitGUID("partypet" .. i) == petGUID then
				local unit = "party" .. i
				return unit, GetUnitName(unit, true), UnitGUID(unit)
			end
		end
	end

	return nil
end

--[[
    A unit counts as a tank two ways, because the game offers two: the raid's
    Main Tank assignment, and the TANK role a player picks in the group finder.
    Either one is the player saying "I am tanking this", so both count.

    Main Assist is deliberately not one of them. It marks the kill-order lead,
    which is a different job.

    UnitGroupRolesAssigned is guarded by availability rather than by result, so a
    client without the group finder falls back to the assignment alone instead of
    erroring.
]]
local HAS_ROLES = type(UnitGroupRolesAssigned) == "function"

function ns.IsUnitTank(unit)
	if GetPartyAssignment("MAINTANK", unit) then
		return true
	end
	if HAS_ROLES and UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	return false
end

function ns.IsPlayerTank()
	return ns.IsUnitTank("player")
end

--[[
    Whether anybody in the group is of this class, the player included.

    Deliberately NOT filtered on alive or connected, unlike ns.GroupHasTank. That
    one asks "is somebody tanking right now", a question about this instant; this
    one asks "could this debuff ever land", and a druid who is dead at the moment
    the tank pulls is still the reason to wait for Faerie Fire.
]]
function ns.GroupHasClass(class)
	if select(2, UnitClass("player")) == class then
		return true
	end

	local unitPrefix, count
	if IsInRaid() then
		unitPrefix, count = "raid", GetNumGroupMembers()
	elseif IsInGroup() then
		unitPrefix, count = "party", 4
	else
		return false
	end

	for index = 1, count do
		local unit = unitPrefix .. index
		if UnitExists(unit) and select(2, UnitClass(unit)) == class then
			return true
		end
	end

	return false
end

--[[
    Whether anybody is tanking for this group right now: a Main Tank assignment or
    the group finder's TANK role, connected, and alive.

    Alive is the load-bearing word. A dead tank is the moment a pet holding a mob
    is doing the group a favor, so a feature gated on this has to go quiet then
    rather than scold whoever picked the mob up.

    Answered once per frame and reused. It walks the raid with several API calls
    per member, and a busy combat-log frame asks it repeatedly for an answer that
    cannot change between two lines sharing a timestamp.
]]
local groupHasTankFrame, groupHasTankAnswer

function ns.GroupHasTank()
	local now = GetTime()
	if groupHasTankFrame == now then
		return groupHasTankAnswer
	end

	local answer = false
	if ns.IsUnitTank("player") and not UnitIsDeadOrGhost("player") then
		answer = true
	else
		local unitPrefix, count
		if IsInRaid() then
			unitPrefix, count = "raid", GetNumGroupMembers()
		elseif IsInGroup() then
			unitPrefix, count = "party", 4
		end

		if unitPrefix then
			for index = 1, count do
				local unit = unitPrefix .. index
				if ns.IsUnitTank(unit) and UnitIsConnected(unit) and not UnitIsDeadOrGhost(unit) then
					answer = true
					break
				end
			end
		end
	end

	groupHasTankFrame, groupHasTankAnswer = now, answer
	return answer
end

function ns.FindTankUnit(guid)
	if not guid then
		return nil
	end

	if UnitGUID("player") == guid then
		return ns.IsUnitTank("player") and "player" or nil
	end

	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local unit = "raid" .. i
			if UnitGUID(unit) == guid then
				return ns.IsUnitTank(unit) and unit or nil
			end
		end
	elseif IsInGroup() then
		for i = 1, 4 do
			local unit = "party" .. i
			if UnitGUID(unit) == guid then
				return ns.IsUnitTank(unit) and unit or nil
			end
		end
	end

	return nil
end

--------------------------------------------------------------------------------
-- Cooldowns
--------------------------------------------------------------------------------

--[[
    A value a profile stored that its list no longer offers -- because the list was
    edited between versions -- resolves to the default rather than staying
    something the player can neither see nor choose again.

    Read by the options dropdown AND by the code that acts on the value, so the
    two can never disagree: without it, trimming 15 seconds off the cooldown ladder
    would leave an old profile showing a blank dropdown while still waiting 15.
]]
function ns.ResolveChoice(value, ladder, default)
	for _, seconds in ipairs(ladder) do
		if value == seconds then
			return value
		end
	end
	return default
end

--------------------------------------------------------------------------------
-- Enemy Lookups
--------------------------------------------------------------------------------

--[[
    The combat log names a mob with a guid and nothing else -- no level, no
    classification, no elite bit -- so "Only Against Bosses & Elites" has to find a
    unit token pointing at the same mob and read it from there.

    Candidates are ordered by how likely they are to be the mob in question. Your
    own target leads, because a single-target taunt needs one and the taunt just
    landed; then the frames a fight puts up, then every name plate on screen, and
    last the group's own targets -- the taunter's target IS the mob they taunted,
    which is what answers for somebody else's taunt across the room.

    focus and boss1-5 do not exist on every client. UnitGUID answers nil for a
    unit token the client does not have, so an absent frame costs one nil compare
    rather than needing a capability probe.
]]
local ENEMY_UNIT_CANDIDATES = {
	"target",
	"focus",
	"mouseover",
	"boss1",
	"boss2",
	"boss3",
	"boss4",
	"boss5",
}

local function FindEnemyUnit(guid)
	for _, unit in ipairs(ENEMY_UNIT_CANDIDATES) do
		if UnitGUID(unit) == guid then
			return unit
		end
	end

	if C_NamePlate and C_NamePlate.GetNamePlates then
		for _, plate in ipairs(C_NamePlate.GetNamePlates()) do
			local unit = plate.namePlateUnitToken
			if unit and UnitGUID(unit) == guid then
				return unit
			end
		end
	end

	local unitPrefix, count
	if IsInRaid() then
		unitPrefix, count = "raid", GetNumGroupMembers()
	elseif IsInGroup() then
		unitPrefix, count = "party", 4
	else
		return nil
	end

	for index = 1, count do
		local unit = unitPrefix .. index .. "target"
		if UnitGUID(unit) == guid then
			return unit
		end
	end

	return nil
end

--[[
    Three tiers count, and between them they are what "worth the attention" means:
    a raid boss (worldboss classification), a "??" mob (level -1, which reads as a
    skull in game and is above the player by definition), and any elite ABOVE the
    player's own level -- which is what brings dungeon bosses in, so a player gets
    the habit in a five-man before they ever take it into a raid.

    Strictly above, not at-or-above, and the difference is the whole filter. A
    level 60 clearing a level 60 dungeon meets elite TRASH at 58-60 and elite
    BOSSES at 61-63; at-or-above would let every trash pack through and leave the
    filter reporting the exact thing it exists to suppress.

    THREE answers, not two. nil means the question could not be asked -- no unit
    token pointed at the mob, or the guid is a player's because the ability was cast
    on a group member -- and ns:Alert treats that as a pass. Failing closed would
    trade a little trash noise for silently swallowing the one boss taunt the filter
    was turned on for, which is the worse of the two.

    The answer is kept per guid because a mob's level and classification never
    change. Emptied whole when it fills, the way the enemy-target cache is: what it
    costs is one lookup again, and a raid night is a lot of corpses.
]]
local ELITE_CLASSIFICATIONS = { elite = true, rareelite = true }
local BOSS_CACHE_LIMIT = 500

local bossByGUID = {}
local bossCacheCount = 0

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(bossByGUID)
	bossCacheCount = 0
end

function ns.IsBossEnemy(guid)
	if not guid then
		return nil
	end

	-- An ability cast on a group member (Righteous Defense) hands us a player
	-- rather than the mob. Unanswerable, which ns:Alert lets through.
	if ns.IsPlayerGUID(guid) then
		return nil
	end

	local cached = bossByGUID[guid]
	if cached ~= nil then
		return cached
	end

	local unit = FindEnemyUnit(guid)
	if not unit then
		return nil
	end

	local classification = UnitClassification(unit)
	local level = UnitLevel(unit)

	local answer = false
	if classification == "worldboss" or level == -1 then
		answer = true
	elseif ELITE_CLASSIFICATIONS[classification] and level > UnitLevel("player") then
		answer = true
	end

	if bossCacheCount >= BOSS_CACHE_LIMIT then
		wipe(bossByGUID)
		bossCacheCount = 0
	end
	bossByGUID[guid] = answer
	bossCacheCount = bossCacheCount + 1

	return answer
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
