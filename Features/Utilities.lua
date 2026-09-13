local _, ns = ...

local L = ns.L

local bit_band = bit.band
local string_find = string.find

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

--[[
    A plain find rather than a substring compare: it runs on every combat-log line
    and sub() would allocate a six-character string each time to throw away.
]]
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

--[[
    Picked by availability, never by result: a call that legitimately returns nil
    must not fall through to the other namespace.
]]
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

--[[
    Affiliation runs MINE (1), PARTY (2), RAID (4), OUTSIDER (8), so anything
    below OUTSIDER is us or someone grouped with us. Reading the flags beats
    UnitInParty/UnitInRaid: no API call, and it is correct for pets too.
]]
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

--[[
    Whether a cast is the player's own, which is what picks between a section's
    My and Others' rows. MINE covers the player and the player's own pet -- that
    is exactly what the log's MINE affiliation means -- so the pet case needs no
    handling.
]]
function ns.IsMineSource(sourceFlags)
	if not sourceFlags then
		return false
	end
	return bit_band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MASK) == COMBATLOG_OBJECT_AFFILIATION_MINE
end

--------------------------------------------------------------------------------
-- Group Lookups
--------------------------------------------------------------------------------

-- Built once: a group walk on a combat path indexes these rather than allocating a token per member.
local UNIT_TOKENS = { raid = {}, party = {}, raidpet = {}, partypet = {}, raidTarget = {}, partyTarget = {} }
for index = 1, 40 do
	UNIT_TOKENS.raid[index] = "raid" .. index
	UNIT_TOKENS.raidpet[index] = "raidpet" .. index
	UNIT_TOKENS.raidTarget[index] = "raid" .. index .. "target"
end
for index = 1, 4 do
	UNIT_TOKENS.party[index] = "party" .. index
	UNIT_TOKENS.partypet[index] = "partypet" .. index
	UNIT_TOKENS.partyTarget[index] = "party" .. index .. "target"
end
ns.UNIT_TOKENS = UNIT_TOKENS

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
    The healer half of the same question, and it is thinner than the tank half on
    purpose: there is no raid assignment for healing the way MAINTANK exists for
    tanking, so the group finder's role is the only signal there is. A player who
    never sets one is not a healer as far as this add-on can tell, so a tab
    narrowed to healers stays quiet for them.
]]
function ns.IsPlayerHealer()
	return ns.IsUnitHealer("player")
end

-- The per-unit form, kept as the pair to ns.IsUnitTank.
function ns.IsUnitHealer(unit)
	return HAS_ROLES and UnitGroupRolesAssigned(unit) == "HEALER"
end

--[[
    The group unit token for a GUID, or nil if that GUID is not somebody in the
    group. Players only: the raid and party tokens are walked and the pet ones
    are not, so a dying pet answers nil rather than resolving to its owner.

    "player" is checked first and without a walk, since it is the one GUID that
    is always in the group and the loops below never contain it -- raid1..N do
    include the player in a raid, but a five-man's party1..4 do not.
]]
function ns.FindGroupUnit(guid)
	if not guid then
		return nil
	end

	if UnitGUID("player") == guid then
		return "player"
	end

	local tokens, count
	if IsInRaid() then
		tokens, count = UNIT_TOKENS.raid, GetNumGroupMembers()
	elseif IsInGroup() then
		tokens, count = UNIT_TOKENS.party, 4
	else
		return nil
	end

	for index = 1, count do
		local unit = tokens[index]
		if UnitGUID(unit) == guid then
			return unit
		end
	end

	return nil
end

--[[
    A class's name in the player's own language, from the client rather than from
    the locale files: the client already ships all eleven, and a translation of
    our own could disagree with the tooltip a player is reading beside it. Falls
    back to the token so a client missing the table shows WARRIOR rather than
    nothing.

    The Tank Deaths panel sorts its class rows on this, which is what makes that
    list alphabetical in every language instead of only in English.
]]
function ns.ClassName(class)
	return LOCALIZED_CLASS_NAMES_MALE and LOCALIZED_CLASS_NAMES_MALE[class] or class
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
		local tokens, count
		if IsInRaid() then
			tokens, count = UNIT_TOKENS.raid, GetNumGroupMembers()
		elseif IsInGroup() then
			tokens, count = UNIT_TOKENS.party, 4
		end

		if tokens then
			for index = 1, count do
				local unit = tokens[index]
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

--[[
    The unit token for a GUID, but only if that unit is tanking. The walk itself
    is ns.FindGroupUnit's, so the two cannot disagree about who counts as being
    in the group.
]]
function ns.FindTankUnit(guid)
	local unit = ns.FindGroupUnit(guid)
	if unit and ns.IsUnitTank(unit) then
		return unit
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
