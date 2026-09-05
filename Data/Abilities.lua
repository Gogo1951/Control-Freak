local _, ns = ...

--[[
    -- TODO: Add SQL Query
]]

--[[
    Every ability Control Freak watches, across every flavor, in one array.

    One entry == one checkbox in the options panel. StyLua owns the formatting;
    find an entry by the trailing "-- Name" comment on its closing brace, then
    tune its digits.

      class       class bucket for the options panel. ITEM is its own bucket.
      category    TAUNT | FEAR | NOVA | BUBBLE | PET_TAUNT. Features/Combat-Log
                  maps each to the feature that owns it.
      detection   how a success is recognised.
                    AURA  lands a debuff on its target, so success is the aura
                          applying and a resist produces exactly one failure line.
                    CAST  lands nothing to observe, so the cast itself is success.
                          Pet taunts are CAST: on these clients Growl, Torment and
                          Suffering apply no debuff, and watching for an aura
                          leaves the whole feature silent.
      isAoe       hits more than one target. Drives which alert section reports it,
                  and suppresses failure lines: an AoE taunt fires one miss per
                  immune mob, which is noise rather than information.
      flavors     { Era, SoD, TBC, Wrath }
                    1   exists on this flavor, tracked, checkbox on by default
                    0   exists, tracked, checkbox off by default
                    "-" does not exist on this flavor: never registered, no
                        checkbox, can never fire
                  Anything past Wrath reads the Wrath column. "-" exists because
                  Blizzard reuses spell ids across flavors for entirely different
                  abilities, which no existence check can detect -- the data has
                  to say so.
      renamed     optional. The ability answers to more than one name across the
                  ranks or flavors it spans, so Validate Data reports a differing
                  name as RENAMED rather than as the typo signal NAME MISMATCH.
                  Set it only for a verified rename, never to quiet a surprise.
      triggers    every rank and variant this one checkbox covers, in rank order.
                  An id the running client does not know is simply inert, so ranks
                  from other flavors cost nothing and stay listed. Unchecking the
                  row ignores all of them, the ones this client cannot see
                  included, so levelling or changing flavor preserves the choice.

    A rename across flavors is one entry, not two: Turn Undead became Turn Evil,
    so both ids ride the same row and the panel shows whichever name the client
    gives the highest rank the character has.
]]
ns.ABILITIES = {
	-- DRUID
	{
		class = "DRUID",
		category = "TAUNT",
		detection = "AURA",
		isAoe = false,
		flavors = { 1, 1, 1, 1 },
		triggers = { 6795 },
	}, -- Growl
	{
		class = "DRUID",
		category = "TAUNT",
		detection = "AURA",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 5209 },
	}, -- Challenging Roar

	-- HUNTER
	{
		class = "HUNTER",
		category = "TAUNT",
		detection = "CAST",
		isAoe = false,
		flavors = { 1, 1, 1, 1 },
		triggers = { 20736, 14274, 15629, 15630, 15631, 15632, 27020 },
	}, -- Distracting Shot
	{
		class = "HUNTER",
		category = "FEAR",
		detection = "AURA",
		isAoe = false,
		flavors = { 1, 1, 1, 1 },
		triggers = { 1513, 14326, 14327 },
	}, -- Scare Beast

	-- MAGE
	{
		class = "MAGE",
		category = "NOVA",
		detection = "CAST",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 122, 865, 6131, 10230, 27088 },
	}, -- Frost Nova

	-- PALADIN
	{
		class = "PALADIN",
		category = "FEAR",
		detection = "AURA",
		isAoe = false,
		flavors = { 1, 1, 1, 1 },
		renamed = true,
		triggers = { 2878, 5627, 10326 },
	}, -- Turn Undead on Era; rank 3 is Turn Evil from TBC on, and is the only rank Wrath keeps
	{
		class = "PALADIN",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		flavors = { "-", "-", 1, 1 },
		triggers = { 31789 },
	}, -- Righteous Defense; cast on a friendly, so the taunt lands via 31790 on the mobs
	{
		class = "PALADIN",
		category = "TAUNT",
		detection = "AURA",
		isAoe = false,
		flavors = { "-", "-", "-", 1 },
		triggers = { 62124 },
	}, -- Hand of Reckoning, the Wrath single-target paladin taunt
	--[[
	    PARKED: the three paladin bubbles were the whole BUBBLE category, and they
	    come back with the Bubble Warnings section on the Tanking Tools tab. With no
	    entry carrying the category, nothing registers and ns:HandleBubble is
	    unreachable, so the machinery behind it -- the Main-Tank and
	    health-threshold checks in Features/Tanking-Tools-Bubble.lua, the
	    SPELL_AURA_APPLIED-only rule in Features/Combat-Log.lua,
	    ns.BUBBLE_HEALTH_THRESHOLD, the ANNOYANCE_BUBBLE string, and BUBBLE in the
	    Tanking Tools panel's category set -- is dormant rather than gone. Restoring
	    them is pasting these three rows back:

	      Divine Shield          AURA  { 642, 1020 }
	      Blessing of Protection AURA  { 1022, 5599, 10278 }  Hand of Protection from Wrath on
	      Divine Protection      AURA  { 498, 5573 }

	    all { 1, 1, 1, 1 }, isAoe false, class PALADIN, category BUBBLE.
	]]

	-- PRIEST
	{
		class = "PRIEST",
		category = "FEAR",
		detection = "AURA",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 8122, 8124, 10888, 10890 },
	}, -- Psychic Scream

	-- ROGUE
	{
		class = "ROGUE",
		category = "TAUNT",
		detection = "CAST",
		isAoe = false,
		flavors = { "-", 1, "-", "-" },
		triggers = { 410412, 1219355 },
	}, -- Tease, which the Just a Flesh Wound rune puts in place of Feint

	-- SHAMAN
	{
		class = "SHAMAN",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 5730, 6390, 6391, 6392, 10427, 10428, 25525 },
	}, -- Stoneclaw Totem
	{
		class = "SHAMAN",
		category = "TAUNT",
		detection = "CAST",
		isAoe = false,
		flavors = { "-", 1, "-", "-" },
		triggers = {
			408681,
			408683,
			408685,
			408687,
			408688,
			408689,
			408690,
			1220744,
			1220746,
			1220747,
			1220748,
			1220749,
			1220750,
			1220751,
		},
	}, -- Earth Shock under the Way of Earth rune. Its own ids, two seasons of them; never the plain Earth Shock ranks, which do not taunt

	-- WARLOCK
	{
		class = "WARLOCK",
		category = "FEAR",
		detection = "AURA",
		isAoe = false,
		flavors = { 1, 1, 1, 1 },
		triggers = { 6789, 17925, 17926, 27223 },
	}, -- Death Coil
	{
		class = "WARLOCK",
		category = "FEAR",
		detection = "AURA",
		isAoe = false,
		flavors = { 1, 1, 1, 1 },
		triggers = { 5782, 6213, 6215 },
	}, -- Fear
	{
		class = "WARLOCK",
		category = "FEAR",
		detection = "AURA",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 5484, 17928 },
	}, -- Howl of Terror
	{
		class = "WARLOCK",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		flavors = { "-", 1, "-", "-" },
		triggers = { 412789 },
	}, -- Demonic Howl, the AoE taunt the Metamorphosis rune grants

	-- WARRIOR
	{
		class = "WARRIOR",
		category = "TAUNT",
		detection = "AURA",
		isAoe = false,
		flavors = { 1, 1, 1, 1 },
		triggers = { 355 },
	}, -- Taunt
	{
		class = "WARRIOR",
		category = "TAUNT",
		detection = "AURA",
		isAoe = false,
		flavors = { 1, 1, 1, 1 },
		triggers = { 694, 7400, 7402, 20559, 20560, 25266 },
	}, -- Mocking Blow
	{
		class = "WARRIOR",
		category = "TAUNT",
		detection = "AURA",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 1161 },
	}, -- Challenging Shout
	{
		class = "WARRIOR",
		category = "FEAR",
		detection = "AURA",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 5246 },
	}, -- Intimidating Shout

	-- PETS
	{
		class = "HUNTER",
		category = "PET_TAUNT",
		detection = "CAST",
		isAoe = false,
		flavors = { 1, 1, 1, 1 },
		triggers = { 2649, 14916, 14917, 14918, 14919, 14920, 14921, 27047 },
	}, -- Growl
	{
		class = "WARLOCK",
		category = "PET_TAUNT",
		detection = "CAST",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 17735, 17750, 17751, 17752, 27271, 33701 },
	}, -- Suffering
	{
		class = "WARLOCK",
		category = "PET_TAUNT",
		detection = "CAST",
		isAoe = false,
		flavors = { 1, 1, 1, 1 },
		triggers = { 3716, 7809, 7810, 7811, 11774, 11775, 27270 },
	}, -- Torment. Era stops at rank 6 (11775); 11776 and 11777 are the effect ids, not castable ranks

	-- ITEMS
	-- These are the summon spells the item's Use casts, not the item ids.
	{
		class = "ITEM",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 4071 },
	}, -- Target Dummy
	{
		class = "ITEM",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 4072 },
	}, -- Advanced Target Dummy
	{
		class = "ITEM",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 19805 },
	}, -- Masterwork Target Dummy
	{
		class = "ITEM",
		category = "FEAR",
		detection = "CAST",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 5134 },
	}, -- Flash Bomb
}
