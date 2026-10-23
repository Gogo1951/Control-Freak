local _, ns = ...

-- { class, category, detection, isAoe, shipsOff, triggers }, -- Cooldown Name
ns.PEER_PRESSURE_ABILITIES = {
	-- DRUID
	{
		class = "DRUID",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 22842, 22895, 22896, 26999 },
	}, -- Frenzied Regeneration
	{
		class = "DRUID",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 29166 },
	}, -- Innervate

	-- HUNTER
	{
		class = "HUNTER",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 19574 },
	}, -- Bestial Wrath
	{
		class = "HUNTER",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 34477 },
	}, -- Misdirection
	{
		class = "HUNTER",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 3045 },
	}, -- Rapid Fire
	{
		class = "HUNTER",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 23989 },
	}, -- Readiness

	-- MAGE
	{
		class = "MAGE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 12042 },
	}, -- Arcane Power
	{
		class = "MAGE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 11958 },
	}, -- Cold Snap (TBC/Wrath id; same id is Ice Block on Era)
	{
		class = "MAGE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 29977, 11129 },
	}, -- Combustion
	{
		class = "MAGE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 12051 },
	}, -- Evocation
	{
		class = "MAGE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 45438, 27619 },
	}, -- Ice Block (TBC/Wrath ids)
	{
		class = "MAGE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 12472 },
	}, -- Icy Veins (TBC/Wrath; same id is Cold Snap on Era)
	{
		class = "MAGE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 12043 },
	}, -- Presence of Mind

	-- PALADIN
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 31884 },
	}, -- Avenging Wrath
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 20216 },
	}, -- Divine Favor
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 31842 },
	}, -- Divine Illumination
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 19752 },
	}, -- Divine Intervention
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 642, 1020 },
	}, -- Divine Shield
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 1022, 5599, 10278 },
	}, -- Blessing of Protection
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 6940, 20729, 27147, 27148 },
	}, -- Blessing of Sacrifice
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 633, 2800, 10310, 27154 },
	}, -- Lay on Hands

	-- PRIEST
	{
		class = "PRIEST",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 13908, 19236, 19238, 19240, 19241, 19242, 19243, 25437 },
	}, -- Desperate Prayer
	{
		class = "PRIEST",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 6346 },
	}, -- Fear Ward
	{
		class = "PRIEST",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 33206 },
	}, -- Pain Suppression
	{
		class = "PRIEST",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 10060 },
	}, -- Power Infusion

	-- ROGUE
	{
		class = "ROGUE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 13750 },
	}, -- Adrenaline Rush
	{
		class = "ROGUE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 13877 },
	}, -- Blade Flurry
	{
		class = "ROGUE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 14177 },
	}, -- Cold Blood
	{
		class = "ROGUE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 5277, 26669 },
	}, -- Evasion
	{
		class = "ROGUE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 14185 },
	}, -- Preparation
	{
		class = "ROGUE",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 1856, 1857, 27617, 26889, 44290 },
	}, -- Vanish

	-- SHAMAN
	{
		class = "SHAMAN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 2825 },
	}, -- Bloodlust
	{
		class = "SHAMAN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 16166 },
	}, -- Elemental Mastery
	{
		class = "SHAMAN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 32182 },
	}, -- Heroism

	-- WARLOCK
	{
		class = "WARLOCK",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 18708 },
	}, -- Fel Domination

	-- WARRIOR
	{
		class = "WARRIOR",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 12292 },
	}, -- Death Wish
	{
		class = "WARRIOR",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 12975 },
	}, -- Last Stand
	{
		class = "WARRIOR",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 1719 },
	}, -- Recklessness
	{
		class = "WARRIOR",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 20230 },
	}, -- Retaliation
	{
		class = "WARRIOR",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 871 },
	}, -- Shield Wall
}

--[[
How We Got the Data

Last Validated
	2026-10-19, TBC Anniversary 2.5.6.70006

Notes
	- The class cooldowns the Peer Pressure tab reports when another player of your class in your group uses one, or when you do while the My Cooldowns row is on. Hand-picked, not queried. They moved here from Thanks for the Buff in October 2026.
	- One row is one checkbox on the Peer Pressure tab's Tracked Abilities page. The name after each row is for people; the panel takes names, icons and tooltips from the game.
	- class is the caster's class token, and the bucket the panel files the row under. A row fires only when it matches your class.
	- category is always COOLDOWN, which ns.CATEGORY_FEATURE in Features/Ability-Index.lua maps to the Peer Pressure tab. detection is always CAST and isAoe always false: the cast itself is the news, and the line names no mob.
	- shipsOff starts the checkbox unticked. A player's own tick or untick is never overwritten (ns.IsAbilityIgnored in Features/Ability-Index.lua).
	- triggers lists every rank or variant the one checkbox covers. An id this client's spell data does not know is never drawn and never appears in its combat log.
	- No id here may also sit in Abilities-TBC.lua: ns.ABILITY_MAP holds one row per id, so a shared id would answer to only one tab.
	- Several mage IDs mean different spells on Classic Era: on this client 11958 is Cold Snap and 12472 is Icy Veins, while on Era 11958 is Ice Block and 12472 is Cold Snap. Ice Block here is 45438 and 27619.
	- On this client 12328 is Sweeping Strikes and Death Wish is 12292, while on Classic Era 12328 is Death Wish.
	- Aura Mastery is left out because it's a passive talent on this client, and Death Knight cooldowns because Death Knights don't exist here.
	- The file is self-contained: edit rows here without touching any other file.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/SpellName?build=2.5.6.69795
	https://wago.tools/db2/SkillLineAbility?build=2.5.6.69795
	https://wago.tools/db2/SpellName?build=2.5.6.70006
	https://wago.tools/db2/SkillLineAbility?build=2.5.6.70006
	https://wago.tools/db2/SpellLevels?build=2.5.6.70006
	https://wago.tools/db2/SkillLine?build=2.5.6.70006
	https://wago.tools/db2/SpellEffect?build=2.5.6.70006
	https://wago.tools/db2/Talent?build=2.5.6.70006

QuestieDB
	None.
]]
