local _, ns = ...

--------------------------------------------------------------------------------
-- Ability Lookup
--------------------------------------------------------------------------------

--[[
    The flavors column in Data/Abilities.lua decides what this client tracks, so
    an entry marked "-" here is never registered and can never fire -- which is
    the only defence against Blizzard reusing an id for a different ability on
    another flavor, since the id still resolves and no existence check can tell.

    Everything else is registered. A trigger this client's spell data does not
    know is inert: it can never appear in this client's combat log, so ranks from
    other flavors cost nothing.

    The panel draws a row only for an entry with at least one trigger the client
    knows, which is what keeps TBC abilities off an Era panel. Name and icon come
    from the highest such trigger, so the label matches the tooltip and both read
    for the character looking at them -- and a renamed ability (Turn Undead became
    Turn Evil) shows whichever name this client uses.
]]
local ABILITY_MAP = {}
local ABILITY_GROUPS = {}

--[[
    Built on PLAYER_LOGIN rather than at file scope, because the flavor it reads
    is not answerable this early: Season of Discovery is told apart from Era by
    asking whether engraving is enabled, and that answer needs the character to be
    in. Core calls this before it registers the options panels, and the combat log
    is not hooked until later, so nothing reads either table before it runs.
]]
function ns.BuildAbilityIndex()
	wipe(ABILITY_MAP)
	wipe(ABILITY_GROUPS)

	local flavor = ns.GetFlavorIndex()

	for _, entry in ipairs(ns.ABILITIES) do
		if entry.flavors[flavor] ~= "-" then
			local group = {
				class = entry.class,
				category = entry.category,
				isAoe = entry.isAoe,
				ids = entry.triggers,
				knownIds = {},
			}

			for _, spellId in ipairs(entry.triggers) do
				ABILITY_MAP[spellId] = entry
				local name, icon = ns.GetSpellNameAndIcon(spellId)
				if name then
					group.knownIds[#group.knownIds + 1] = spellId
					group.maxRankId = spellId
					group.name, group.icon = name, icon
				end
			end

			if group.maxRankId then
				ABILITY_GROUPS[#ABILITY_GROUPS + 1] = group
			end
		end
	end
end

--[[
    Wiped and refilled rather than replaced, so a file-scope alias taken at load
    stays pointed at the live table.
]]
ns.ABILITY_MAP = ABILITY_MAP
ns.ABILITY_GROUPS = ABILITY_GROUPS

--------------------------------------------------------------------------------
-- Category to Feature
--------------------------------------------------------------------------------

--[[
    An ability's category names the ability; the feature it maps to names the
    tab that owns the alert. Two of them land on the "somebody is doing something
    wrong" tabs, Bad Priests and Bad Pets.
]]
ns.CATEGORY_FEATURE = {
	TAUNT = "taunts",
	FEAR = "fears",
	PET_TAUNT = "badPets",
	SHIELD = "badPriests",
	NOVA = "tankingTools",
}
