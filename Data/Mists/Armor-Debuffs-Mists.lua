local _, ns = ...

--[[
    The armor debuffs the Armor Debuffs tool waits on, and what each one needs
    before it counts as up.

    The ids are the ones the combat log reports on SPELL_AURA_APPLIED, which is
    usually the casting spell but is not always: Righteous Defense is cast as
    31789 and lands as 31790, and Torment's 11776 and 11777 are effect ids
    rather than castable ranks. Every entry below is a plain self-applied
    debuff, where the two match.

    satisfies is what a component contributes, and it is why Sunder and Expose
    Armor share a value: five Sunders OR one Expose Armor is the same answer to
    the same question, and a group with a rogue should not be told its armor is
    still up.

    requiresClass is the gate that keeps an optional component from stalling the
    report forever. Waiting on Faerie Fire in a group with no druid would mean the
    line never prints, so the wait only applies when somebody could actually cast
    it. The player still has to ask for it with the matching setting.

    Devastate is deliberately absent. It applies the same debuff, but it is a
    Wrath ability and this list is matched against the combat log by id; add its
    ids to the Wrath folder's copy when Wrath is worth supporting.
]]
-- TODO: Add SQL Query
ns.ARMOR_DEBUFFS = {
	{
		key = "sunder",
		satisfies = "ARMOR",
		stacks = 5,
		ids = { 7386, 7405, 8380, 11596, 11597, 25225 },
	},
	{
		key = "expose",
		satisfies = "ARMOR",
		stacks = 1,
		ids = { 8647, 8649, 8650, 11197, 11198, 26866 },
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
		ids = { 770, 778, 9749, 9907, 26993, 16857, 17390, 17391, 17392, 27011 },
	},
	{
		key = "recklessness",
		satisfies = "RECKLESSNESS",
		stacks = 1,
		requiresClass = "WARLOCK",
		setting = "includeRecklessness",
		ids = { 704, 7658, 7659, 11717, 27226 },
	},
}
