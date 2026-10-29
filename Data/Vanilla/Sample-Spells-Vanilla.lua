local _, ns = ...

if ns.IS_DISCOVERY then
	return
end

-- [key] = spellId, -- Spell Name
ns.SAMPLE_SPELL_IDS = {
	SHADOW_BOLT = 686, -- Shadow Bolt
	PSYCHIC_SCREAM = 8122, -- Psychic Scream
	FEAR = 5782, -- Fear
	POWER_WORD_SHIELD = 17, -- Power Word: Shield
	GROWL = 2649, -- Growl
	FROST_NOVA = 122, -- Frost Nova

	-- The player's own taunt, by class
	TAUNT_DRUID = 6795, -- Growl
	TAUNT_WARRIOR = 355, -- Taunt

	-- The player's own AOE taunt, by class
	AOE_TAUNT_DRUID = 5209, -- Challenging Roar
	AOE_TAUNT_SHAMAN = 5730, -- Stoneclaw Totem
	AOE_TAUNT_WARRIOR = 1161, -- Challenging Shout

	-- The player's own interrupt, by class
	INTERRUPT_MAGE = 2139, -- Counterspell
	INTERRUPT_PRIEST = 15487, -- Silence
	INTERRUPT_ROGUE = 1766, -- Kick
	INTERRUPT_SHAMAN = 8042, -- Earth Shock
	INTERRUPT_WARRIOR = 6552, -- Pummel

	-- The player's own opening ability, by class
	OPENER_DRUID = 6807, -- Maul
	OPENER_HUNTER = 3044, -- Arcane Shot
	OPENER_MAGE = 116, -- Frostbolt
	OPENER_PALADIN = 20271, -- Judgement
	OPENER_PRIEST = 585, -- Smite
	OPENER_ROGUE = 1752, -- Sinister Strike
	OPENER_SHAMAN = 8042, -- Earth Shock
	OPENER_WARLOCK = 686, -- Shadow Bolt
	OPENER_WARRIOR = 7386, -- Sunder Armor
}

--[[
How We Got the Data

Last Validated
	2026-10-28, Classic Era 1.15.9.70576

Notes
	- The spells the options panel's Example lines name, one per line that needs a spell, so the client supplies each name in the player's own language.
	- Each id is the spell's first rank: an Example line shows a name, and every rank shares it.
	- ns.SampleSpell in Options/Options-Alert-Section.lua reads these; nothing in a fight does.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/SpellName?build=1.15.9.70576

QuestieDB
	None.
]]
