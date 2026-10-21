local _, ns = ...

-- [key] = spellId, -- Spell Name
ns.SAMPLE_SPELL_IDS = {
	TAUNT = 355, -- Taunt
	CHALLENGING_SHOUT = 1161, -- Challenging Shout
	PUMMEL = 6552, -- Pummel
	SHADOW_BOLT = 686, -- Shadow Bolt
	PSYCHIC_SCREAM = 8122, -- Psychic Scream
	FEAR = 5782, -- Fear
	POWER_WORD_SHIELD = 17, -- Power Word: Shield
	GROWL = 2649, -- Growl
	SUNDER_ARMOR = 7386, -- Sunder Armor
	FROST_NOVA = 122, -- Frost Nova
}

--[[
How We Got the Data

Last Validated
	2026-10-20, TBC Anniversary 2.5.6.70006

Notes
	- The spells the options panel's Example lines name, one per line that needs a spell, so the client supplies each name in the player's own language.
	- Each id is the spell's first rank: an Example line shows a name, and every rank shares it.
	- ns.SampleSpell in Options/Options-Alert-Section.lua reads these; nothing in a fight does.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/SpellName?build=2.5.6.69795

QuestieDB
	None.
]]
