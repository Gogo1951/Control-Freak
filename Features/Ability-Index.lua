local _, ns = ...

--------------------------------------------------------------------------------
-- Ability Lookup
--------------------------------------------------------------------------------

--[[
    Every entry in the loaded flavor folder is registered. An ability that does
    not exist on this flavor is simply absent from its folder, which is the only
    defence against Blizzard reusing an id for a different ability on another
    flavor, since the id still resolves and no existence check can tell. A
    trigger this client's spell data does not know is inert: it can never appear
    in this client's combat log, so ranks from other flavors cost nothing.

    The panel draws a row only for an entry with at least one trigger the client
    knows. Name and icon come from the highest such trigger, so the label matches the tooltip and both read
    for the character looking at them -- and a renamed ability (Turn Undead became
    Turn Evil) shows whichever name this client uses.
]]
local ABILITY_MAP = {}
local ABILITY_GROUPS = {}

--[[
    Peer Pressure's cooldowns live in a file of their own,
    Data/{Game}/Peer-Pressure-Abilities-{Game}.lua, but in the same row shape,
    so they are indexed, drawn and ignored exactly like every other row. Their
    category sends them to their own tab.
]]
local ABILITY_LISTS = { "ABILITIES", "PEER_PRESSURE_ABILITIES" }

local function IndexEntry(entry)
	local group = {
		entry = entry,
		class = entry.class,
		category = entry.category,
	}

	for _, spellId in ipairs(entry.triggers) do
		ABILITY_MAP[spellId] = entry
		local name, icon = ns.GetSpellNameAndIcon(spellId)
		if name then
			group.maxRankId = spellId
			group.name, group.icon = name, icon
		end
	end

	if group.maxRankId then
		ABILITY_GROUPS[#ABILITY_GROUPS + 1] = group
	end
end

--[[
    Core calls this on PLAYER_LOGIN, before it registers the options panels that
    draw its rows, and the combat log is not hooked until later, so nothing reads
    either table before it runs.
]]
function ns.BuildAbilityIndex()
	wipe(ABILITY_MAP)
	wipe(ABILITY_GROUPS)

	for _, listName in ipairs(ABILITY_LISTS) do
		for _, entry in ipairs(ns[listName]) do
			IndexEntry(entry)
		end
	end
end

--[[
    Wiped and refilled rather than replaced, so a file-scope alias taken at load
    stays pointed at the live table.
]]
ns.ABILITY_MAP = ABILITY_MAP
ns.ABILITY_GROUPS = ABILITY_GROUPS

--[[
    A row is ignored when any of its triggers is, which is the one rule both the
    panel's checkbox and the combat log read. Asking per spell id instead lets
    the two disagree as soon as a row gains a trigger: an old profile carries the
    ids the row had when it was unticked, and the new one would still fire.

    A row whose data says shipsOff starts unticked, and the player ticks it by
    storing false against its ids rather than clearing them, so the profile
    stays a diff against the data either way. An untick still wins over a tick,
    for the same reason a row gaining a trigger must not wake up.
]]
function ns.IsAbilityIgnored(entry)
	local ignored = ns.db.profile.ignoredSpells
	local ticked = false
	for _, spellId in ipairs(entry.triggers) do
		local value = ignored[spellId]
		if value then
			return true
		end
		if value == false then
			ticked = true
		end
	end
	return entry.shipsOff == true and not ticked
end

--[[
    The panel's checkbox writes through here. Only a pick that differs from the
    data is stored, so ticking a row that ships ticked clears its ids, and
    ticking one that ships unticked marks them false.
]]
function ns.SetAbilityTracked(entry, tracked)
	local ignored = ns.db.profile.ignoredSpells
	for _, spellId in ipairs(entry.triggers) do
		if not tracked then
			ignored[spellId] = true
		elseif entry.shipsOff then
			ignored[spellId] = false
		else
			ignored[spellId] = nil
		end
	end
end

--------------------------------------------------------------------------------
-- Taunt Kind
--------------------------------------------------------------------------------

ns.TAUNT_KINDS = { "SINGLE", "AOE" }

--[[
    A taunt counts as Single Target or AOE by its isAoe in this flavor's
    Data/{Game}/Abilities-{Game}.lua. That decides which alert section reports it, whether it names a mob, and
    whether its misses are reported.

    Almost every taunt is locked: it takes one mob or everything around it, and
    there is nothing to choose. Only an entry marked kindChoice -- a taunt that
    takes a few mobs, which is Righteous Defense -- reads the player's pick on
    the Taunts tab.
]]
function ns.IsTauntKindLocked(entry)
	return not entry.kindChoice
end

function ns.GetTauntKind(entry)
	if not ns.IsTauntKindLocked(entry) then
		local kind = ns.db.profile.tauntKinds[entry.triggers[1]]
		if kind == "SINGLE" or kind == "AOE" then
			return kind
		end
	end
	return entry.isAoe and "AOE" or "SINGLE"
end

function ns.IsAoeTaunt(entry)
	return ns.GetTauntKind(entry) == "AOE"
end

--------------------------------------------------------------------------------
-- Category to Feature
--------------------------------------------------------------------------------

--[[
    An ability's category names the ability; the feature it maps to names the
    tab that owns the alert. Two of them land on the "somebody is doing something
    wrong" tabs, Bad Priests and Bad Pets. COOLDOWN is the only category whose
    rows come from a file of their own (ABILITY_LISTS above).
]]
ns.CATEGORY_FEATURE = {
	TAUNT = "taunts",
	FEAR = "fears",
	PET_TAUNT = "badPets",
	SHIELD = "badPriests",
	NOVA = "tankingTools",
	COOLDOWN = "peerPressure",
}
