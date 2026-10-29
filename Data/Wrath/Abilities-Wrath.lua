local _, ns = ...

--[[
    Every ability Control Freak watches on this flavor, in one array. Each
    flavor folder holds its own copy, so a row here is live on this client.

    One entry == one checkbox in the options panel. StyLua owns the formatting;
    find an entry by the trailing "-- Name" comment on its closing brace, then
    tune its digits.

      class       class bucket for the options panel. ITEM is its own bucket.
      category    TAUNT | FEAR | NOVA | SHIELD | PET_TAUNT. Features/Combat-Log
                  maps each to the feature that owns it.
      detection   how a success is recognised.
                    AURA  lands an aura on its target, so success is that aura
                          applying and a resist produces exactly one failure
                          line. Usually a debuff; Power Word: Shield is the one
                          entry where it is a buff on a friendly target.
                    CAST  the cast itself is success: the ability lands nothing
                          to observe, or it is an AOE taunt or AOE fear, which
                          reports every press whatever it hits.
                          Pet taunts are CAST: on these clients Growl, Torment and
                          Suffering apply no debuff, and watching for an aura
                          leaves the whole feature silent.
      isAoe       hits more than one target. Drives which alert section reports it,
                  and suppresses failure lines: an AoE taunt fires one miss per
                  immune mob, which is noise rather than information.
      kindChoice  optional, taunts only. The taunt takes a few mobs rather than
                  one or a whole pack, so the Taunts tab lets the player report
                  it as Single Target or AOE, with isAoe as the default. Every
                  other taunt's dropdown is locked on its isAoe. Needs AURA
                  detection: a CAST names one target at most, where an aura
                  lands on each mob the taunt took.
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
-- TODO: Add SQL Query
ns.ABILITIES = {
	-- DRUID
	{
		class = "DRUID",
		category = "TAUNT",
		detection = "AURA",
		isAoe = false,
		triggers = { 6795, 1218506 },
	}, -- Growl. 1218506 is Season of Discovery's own copy, same level and the same bear form requirement
	{
		class = "DRUID",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		triggers = { 5209 },
	}, -- Challenging Roar

	-- HUNTER
	{
		class = "HUNTER",
		category = "TAUNT",
		detection = "CAST",
		isAoe = false,
		triggers = { 20736, 14274, 15629, 15630, 15631, 15632, 27020 },
	}, -- Distracting Shot
	{
		class = "HUNTER",
		category = "FEAR",
		detection = "AURA",
		isAoe = false,
		triggers = { 1513, 14326, 14327 },
	}, -- Scare Beast

	-- MAGE
	{
		class = "MAGE",
		category = "NOVA",
		detection = "CAST",
		isAoe = true,
		triggers = { 122, 865, 6131, 10230, 27088 },
	}, -- Frost Nova

	-- PALADIN
	{
		class = "PALADIN",
		category = "FEAR",
		detection = "AURA",
		isAoe = false,
		renamed = true,
		triggers = { 2878, 5627, 10326 },
	}, -- Turn Undead on Era; rank 3 is Turn Evil from TBC on, and is the only rank Wrath keeps
	{
		class = "PALADIN",
		category = "TAUNT",
		detection = "AURA",
		isAoe = true,
		kindChoice = true,
		triggers = { 31790, 31789 },
	}, -- Righteous Defense. Cast on a friendly, it pulls up to three mobs attacking them, each taking the 3-second "Taunted" aura 31790 with the paladin as its source. 31789 is the cast itself, which lands no aura, so under AURA detection it never fires; it is listed last only so the row's name, icon and tooltip are the castable spell's
	{
		class = "PALADIN",
		category = "TAUNT",
		detection = "AURA",
		isAoe = false,
		triggers = { 62124, 407631, 1219206 },
	}, -- Hand of Reckoning, the single-target paladin taunt. Wrath trains it; Season of Discovery grants it from a glove rune, which is why the two SoD copies carry a Righteous Fury rider the Wrath one has no trace of. Its rune spells are not ranks and are deliberately absent: 409911 is the "Gain the Hand of Reckoning ability" passive, 410001 the engraving itself, 407774 a stub with no text at all
	--[[
	    PARKED: the three paladin bubbles. A bubble on a tank drops every mob on
	    them, which lands the whole pull on whoever is second on threat -- a
	    different problem from the rage denial the SHIELD category reports, so
	    they want a section of their own rather than a place in that one.

	    Nothing of theirs is left standing: the machinery that used to be held
	    for them was taken over by Bad Shields, so bringing them back means a new
	    category, a handler, defaults, copy and a panel section, not just pasting
	    these three rows back:

	      Divine Shield          AURA  { 642, 1020 }
	      Blessing of Protection AURA  { 1022, 5599, 10278 }  Hand of Protection from Wrath on
	      Divine Protection      AURA  { 498, 5573 }

	    all { 1, 1, 1, 1 }, isAoe false, class PALADIN, and a category of their own.
	]]

	-- PRIEST
	{
		class = "PRIEST",
		category = "FEAR",
		detection = "CAST",
		isAoe = true,
		triggers = { 8122, 8124, 10888, 10890 },
	}, -- Psychic Scream

	-- SHAMAN
	{
		class = "SHAMAN",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		triggers = { 5730, 6390, 6391, 6392, 10427, 10428, 25525 },
	}, -- Stoneclaw Totem

	-- WARLOCK
	{
		class = "WARLOCK",
		category = "FEAR",
		detection = "AURA",
		isAoe = false,
		triggers = { 6789, 17925, 17926, 27223 },
	}, -- Death Coil
	{
		class = "WARLOCK",
		category = "FEAR",
		detection = "AURA",
		isAoe = false,
		triggers = { 5782, 6213, 6215 },
	}, -- Fear
	{
		class = "WARLOCK",
		category = "FEAR",
		detection = "CAST",
		isAoe = true,
		triggers = { 5484, 17928 },
	}, -- Howl of Terror

	-- WARRIOR
	{
		class = "WARRIOR",
		category = "TAUNT",
		detection = "AURA",
		isAoe = false,
		triggers = { 355, 473701, 1219541 },
	}, -- Taunt. 473701 and 1219541 are Season of Discovery's own copies; 1219541 keeps the Defensive Stance requirement, 473701 drops it
	{
		class = "WARRIOR",
		category = "TAUNT",
		detection = "AURA",
		isAoe = false,
		triggers = { 694, 7400, 7402, 20559, 20560, 25266 },
	}, -- Mocking Blow
	{
		class = "WARRIOR",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		triggers = { 1161 },
	}, -- Challenging Shout
	{
		class = "WARRIOR",
		category = "FEAR",
		detection = "CAST",
		isAoe = true,
		triggers = { 5246 },
	}, -- Intimidating Shout

	-- PETS
	{
		class = "HUNTER",
		category = "PET_TAUNT",
		detection = "CAST",
		isAoe = false,
		triggers = { 2649, 14916, 14917, 14918, 14919, 14920, 14921, 27047, 409372 },
	}, -- Growl. 409372 is Season of Discovery's own copy, the one the Beast Mastery rune grants, and the only Growl on this list that taunts rather than just holding threat
	{
		class = "WARLOCK",
		category = "PET_TAUNT",
		detection = "CAST",
		isAoe = true,
		triggers = { 17735, 17750, 17751, 17752, 27271, 33701 },
	}, -- Suffering
	{
		class = "WARLOCK",
		category = "PET_TAUNT",
		detection = "CAST",
		isAoe = false,
		triggers = { 3716, 7809, 7810, 7811, 11774, 11775, 27270 },
	}, -- Torment. Era stops at rank 6 (11775); 11776 and 11777 are the effect ids, not castable ranks

	-- ITEMS

	-- These are the summon spells the item's Use casts, not the item ids.
	{
		class = "ITEM",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		triggers = { 4071 },
	}, -- Target Dummy
	{
		class = "ITEM",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		triggers = { 4072 },
	}, -- Advanced Target Dummy
	{
		class = "ITEM",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		triggers = { 19805 },
	}, -- Masterwork Target Dummy
	{
		class = "ITEM",
		category = "FEAR",
		detection = "CAST",
		isAoe = true,
		triggers = { 5134 },
	}, -- Flash Bomb
}
