local _, ns = ...

--[[
    Every ability Control Freak watches, across every flavor, in one array.

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
                    CAST  lands nothing to observe, so the cast itself is success.
                          Pet taunts are CAST: on these clients Growl, Torment and
                          Suffering apply no debuff, and watching for an aura
                          leaves the whole feature silent.
      isAoe       hits more than one target. Drives which alert section reports it,
                  and suppresses failure lines: an AoE taunt fires one miss per
                  immune mob, which is noise rather than information.
      flavors     { Era, SoD, TBC, Wrath }
                    1   exists on this flavor: tracked, and drawn as a checkbox
                        the player can untick
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
-- TODO: Add SQL Query
ns.ABILITIES = {
	-- DRUID
	{
		class = "DRUID",
		category = "TAUNT",
		detection = "AURA",
		isAoe = false,
		flavors = { 1, 1, 1, 1 },
		triggers = { 6795, 1218506 },
	}, -- Growl. 1218506 is Season of Discovery's own copy, same level and the same bear form requirement
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
		flavors = { "-", 1, "-", 1 },
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
		detection = "AURA",
		isAoe = true,
		flavors = { 1, 1, 1, 1 },
		triggers = { 8122, 8124, 10888, 10890 },
	}, -- Psychic Scream
	--[[
	    VERIFIED: the absorb aura is applied by the castable rank itself -- Effect
	    #1 on every rank is Apply Aura: Absorb Damage, with no triggered spell in
	    the chain -- so the id the combat log reports on SPELL_AURA_APPLIED is the
	    id in this list. Confirmed against a captured combat log and against two
	    shipping absorb-tracking libraries keyed on exactly these ids.

	    Weakened Soul (6788) is deliberately absent. The priest applies it to the
	    same target in the same instant as its OWN SPELL_AURA_APPLIED line, so
	    listing it here would report every shield twice.

	    DECOYS, all named "Power Word: Shield" and none of them a castable rank.
	    Never add one, and never harvest these ids by name:
	      10902  the trainer's Learn Spell trigger. No mana cost, 100 yd range.
	      27607  a duplicate rank 10 with no training cost and no priest skill
	             line. Present on Era and TBC both.
	      20697  an NPC self-shield absorbing 5000, no rank, no class requirement.
	      20706  "Power Word: Shield 500", an NPC spell wearing a rank 7 label.

	    Wrath's two ranks (48065, 48066) are left off: the flavors column below
	    turns the whole entry off there, so listing them would only add rows the
	    Validate Data report flags as absent on this client.

	    SoD is "-" rather than 1, and this is a judgement call rather than a fact
	    about the ids. The Strength of Soul rune (passive 415739) makes a shielded
	    target generate rage from absorbed damage anyway, which turns the whole
	    premise off for that priest -- and no add-on can read another player's
	    runes, so the warning would accuse healers who are playing correctly.
	    Silence is the safer error there.
	]]
	{
		class = "PRIEST",
		category = "SHIELD",
		detection = "AURA",
		isAoe = false,
		flavors = { 1, "-", 1, "-" },
		triggers = { 17, 592, 600, 3747, 6065, 6066, 10898, 10899, 10900, 10901, 25217, 25218 },
	}, -- Power Word: Shield. Ranks 1-10 are Era, 11-12 (25217, 25218) are TBC

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
		detection = "AURA",
		isAoe = false,
		flavors = { "-", 1, "-", "-" },
		renamed = true,
		triggers = { 403828, 433672, 442226, 442233, 1219475 },
	}, -- Menace, the single-target taunt the Metamorphosis rune puts in place of Fear, and the partner to Demonic Howl below. Phase 2 shipped it as Loathing (433672) -- same class, same icon, same two effects -- and the name went back to Menace afterwards, which is what renamed is for
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
		triggers = { 355, 473701, 1219541 },
	}, -- Taunt. 473701 and 1219541 are Season of Discovery's own copies; 1219541 keeps the Defensive Stance requirement, 473701 drops it
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
		triggers = { 2649, 14916, 14917, 14918, 14919, 14920, 14921, 27047, 409372 },
	}, -- Growl. 409372 is Season of Discovery's own copy, the one the Beast Mastery rune grants, and the only Growl on this list that taunts rather than just holding threat
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
