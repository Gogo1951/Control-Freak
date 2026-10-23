local _, ns = ...

--[[
    Peer Pressure's cooldowns on this flavor, in the row shape Abilities-Mainline.lua
    uses. A row fires when another player of YOUR class in your group casts it.

    One entry == one checkbox on the Peer Pressure tab's Tracked Abilities page.
    Every row is category COOLDOWN, detection CAST, isAoe false; shipsOff starts
    its checkbox unticked. The name at the end of each row is for people: the
    panel takes names, icons and tooltips from the game.
]]
ns.PEER_PRESSURE_ABILITIES = {
	-- DEATHKNIGHT
	{
		class = "DEATHKNIGHT",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 42650 },
	}, -- Army of the Dead
	{
		class = "DEATHKNIGHT",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 48743 },
	}, -- Death Pact
	{
		class = "DEATHKNIGHT",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 47568 },
	}, -- Empower Rune Weapon
	{
		class = "DEATHKNIGHT",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 48792 },
	}, -- Icebound Fortitude
	{
		class = "DEATHKNIGHT",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 49039 },
	}, -- Lichborne
	{
		class = "DEATHKNIGHT",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 61999 },
	}, -- Raise Ally
	{
		class = "DEATHKNIGHT",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 49016 },
	}, -- Unholy Frenzy

	-- DRUID
	{
		class = "DRUID",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 50334 },
	}, -- Berserk
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
	{
		class = "DRUID",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 61336 },
	}, -- Survival Instincts

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
		triggers = { 55342 },
	}, -- Mirror Image
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
		triggers = { 31821 },
	}, -- Aura Mastery
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
		triggers = { 64205 },
	}, -- Divine Sacrifice
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 642, 1020, 63148 },
	}, -- Divine Shield
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 1022, 5599, 10278 },
	}, -- Hand of Protection
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 6940, 20729, 27147, 27148 },
	}, -- Hand of Sacrifice
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 1038 },
	}, -- Hand of Salvation (Wrath; same id is Blessing of Salvation before)
	{
		class = "PALADIN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 633, 2800, 10310, 27154, 48788 },
	}, -- Lay on Hands

	-- PRIEST
	{
		class = "PRIEST",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 13908, 19236, 19238, 19240, 19241, 19242, 19243, 25437, 48172, 48173 },
	}, -- Desperate Prayer
	{
		class = "PRIEST",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 47585 },
	}, -- Dispersion
	{
		class = "PRIEST",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 64843 },
	}, -- Divine Hymn
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
		triggers = { 47788 },
	}, -- Guardian Spirit
	{
		class = "PRIEST",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 64901 },
	}, -- Hymn of Hope
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
		triggers = { 51690 },
	}, -- Killing Spree
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
		triggers = { 57934 },
	}, -- Tricks of the Trade
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
	{
		class = "SHAMAN",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 55198 },
	}, -- Tidal Force

	-- WARLOCK
	{
		class = "WARLOCK",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 18708 },
	}, -- Fel Domination
	{
		class = "WARLOCK",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 47241 },
	}, -- Metamorphosis

	-- WARRIOR
	{
		class = "WARRIOR",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		triggers = { 12292 },
	}, -- Death Wish (Wrath id; same id is Sweeping Strikes before)
	{
		class = "WARRIOR",
		category = "COOLDOWN",
		detection = "CAST",
		isAoe = false,
		shipsOff = true,
		triggers = { 55694 },
	}, -- Enraged Regeneration
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
