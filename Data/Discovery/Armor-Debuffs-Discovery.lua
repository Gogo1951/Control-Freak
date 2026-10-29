local _, ns = ...

if not ns.IS_DISCOVERY then
	return
end

-- { key, satisfies, stacks, requiresClass, setting, renamed, ids }
ns.ARMOR_DEBUFFS = {
	{
		key = "sunder",
		satisfies = "ARMOR",
		stacks = 5,
		ids = { 7386, 7405, 8380, 11596, 11597 },
	},
	{
		key = "expose",
		satisfies = "ARMOR",
		stacks = 1,
		ids = { 8647, 8649, 8650, 11197, 11198 },
	},
	{
		key = "faerieFire",
		satisfies = "FAERIE_FIRE",
		stacks = 1,
		requiresClass = "DRUID",
		setting = "includeFaerieFire",
		--[[
		    Two names by design, so Validate Data reads a differing name as RENAMED
		    rather than as the typo signal NAME MISMATCH.
		]]
		renamed = true,
		-- Balance ranks first, then the feral ones. Either satisfies it.
		ids = { 770, 778, 9749, 9907, 16857, 17390, 17391, 17392 },
	},
	{
		key = "recklessness",
		satisfies = "RECKLESSNESS",
		stacks = 1,
		requiresClass = "WARLOCK",
		setting = "includeRecklessness",
		ids = { 704, 7658, 7659, 11717 },
	},
}

--[[
How We Got the Data

Last Validated
	2026-10-28, Season of Discovery 1.15.9.70576

Notes
	- The debuffs the Armor Debuffs tool (Features/Tanking-Tools-Armor.lua) waits on before it reports a target's armor as down, and what each one needs before it counts.
	- ids are the ones the combat log reports on SPELL_AURA_APPLIED. That is usually the casting spell but not always (Righteous Defense is cast as 31789 and lands as 31790); every row here is a plain self-applied debuff, where the two match.
	- satisfies is what a row contributes, and it is why Sunder Armor and Expose Armor share a value: five Sunders or one Expose Armor is the same answer to the same question, and a group with a rogue should not be told its armor is still up.
	- stacks is how many applications count as up: five for Sunder Armor, one for the rest.
	- requiresClass keeps an optional row from stalling the report forever. Waiting on Faerie Fire in a group with no druid would mean the line never prints, so the wait applies only when somebody could cast it, and only once the player has turned on the row's setting, the Tanking Tools option named by setting.
	- renamed marks Faerie Fire, whose feral ranks are named Faerie Fire (Feral), so Validate Data reads the differing name as RENAMED rather than as the typo signal NAME MISMATCH. Either form satisfies it.
	- Devastate is deliberately absent. It applies the same debuff, but it is a Wrath ability and this list is matched against the combat log by id.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/SpellName?build=1.15.9.70576
	https://wago.tools/db2/Spell?build=1.15.9.70576
	https://wago.tools/db2/SpellEffect?build=1.15.9.70576
	https://wago.tools/db2/SpellClassOptions?build=1.15.9.70003
	https://wago.tools/db2/SkillLineAbility?build=1.15.9.70576
]]
