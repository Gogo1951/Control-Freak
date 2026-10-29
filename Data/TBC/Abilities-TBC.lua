local _, ns = ...

-- { class, category, detection, isAoe, kindChoice, renamed, triggers }, -- Ability Name
ns.ABILITIES = {
	-- DRUID
	{
		class = "DRUID",
		category = "TAUNT",
		detection = "AURA",
		isAoe = false,
		triggers = { 6795 },
	}, -- Growl
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
	}, -- Turn Undead. Rank 3 (10326) is Turn Evil on this client
	{
		class = "PALADIN",
		category = "TAUNT",
		detection = "AURA",
		isAoe = true,
		kindChoice = true,
		triggers = { 31790, 31789 },
	}, -- Righteous Defense. Cast on a friendly, it pulls up to three mobs attacking them, each taking the 3-second "Taunted" aura 31790 with the paladin as its source. 31789 is the cast itself, which lands no aura, so under AURA detection it never fires; it is listed last only so the row's name, icon and tooltip are the castable spell's
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

	    Wrath's two ranks (48065, 48066) are absent, and so is the whole entry
	    from the Wrath folder and every later one: the mechanic it warns about
	    is gone there.

	    The entry is absent from the Discovery folder too, and this is a
	    judgement call rather than a fact about the ids. The Strength of Soul rune (passive 415739) makes a shielded
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
		triggers = { 17, 592, 600, 3747, 6065, 6066, 10898, 10899, 10900, 10901, 25217, 25218 },
	}, -- Power Word: Shield

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
		triggers = { 355 },
	}, -- Taunt
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
		triggers = { 2649, 14916, 14917, 14918, 14919, 14920, 14921, 27047 },
	}, -- Growl
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
	}, -- Torment. 11776 and 11777 share its name but are not castable ranks
	{
		class = "WARLOCK",
		category = "PET_TAUNT",
		detection = "CAST",
		isAoe = false,
		triggers = { 33698, 33699, 33700 },
	}, -- Anguish

	-- ITEMS

	-- triggers are the spells each item's Use casts, which is all the combat log reports.
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
	{
		class = "ITEM",
		category = "FEAR",
		detection = "CAST",
		isAoe = true,
		triggers = { 35474 },
	}, -- Drums of Panic
	{
		class = "ITEM",
		category = "FEAR",
		detection = "CAST",
		isAoe = true,
		triggers = { 351357 },
	}, -- Greater Drums of Panic
}

--[[
How We Got the Data

Last Validated
	2026-10-28, TBC Anniversary 2.5.6.70577

Notes
	- Every ability Control Freak watches on TBC Anniversary, one row per checkbox in the options panel, grouped by class, with the pets' taunts and the items last.
	- class is the bucket the options panel files the row under; ITEM is its own bucket.
	- category is TAUNT, FEAR, NOVA, SHIELD or PET_TAUNT, and ns.CATEGORY_FEATURE in Features/Ability-Index.lua maps each to the tab that owns its alert.
	- detection is how a success is recognised. AURA means the ability lands an aura on its target, so success is that aura applying and a resist produces exactly one failure line. It is usually a debuff; Power Word: Shield's is a buff on a friendly target. CAST means the cast itself is the success: the ability lands nothing to observe, or it is an AOE taunt or AOE fear, which reports every press whatever it hits (a maintainer decision). Pet taunts are CAST: Growl, Torment, Suffering and Anguish apply no debuff, and watching for an aura would leave the whole feature silent.
	- isAoe means the ability hits more than one target. It picks the alert section that reports it and suppresses failure lines, since an AoE taunt fires one miss per immune mob, which is noise rather than information.
	- kindChoice, taunts only, marks a taunt that takes a few mobs rather than one or a whole pack, so the Taunts tab lets the player report it as Single Target or AOE, with isAoe as the default. Every other taunt's dropdown is locked on its isAoe. It needs AURA detection: a cast names one target at most, where an aura lands on each mob the taunt took. Righteous Defense is the one row that sets it.
	- renamed marks an ability whose ranks answer to more than one name on this client, so Validate Data reports a differing name as RENAMED rather than as the typo signal NAME MISMATCH. Set it only for a verified rename, never to quiet a surprise. A rename stays one row, and the panel shows whichever name the client gives the highest rank the character has. Turn Undead is the one row that sets it: its third rank (10326) is named Turn Evil on this client.
	- triggers lists every rank and variant the one checkbox covers, in rank order, and only ids this client knows: an id Validate Data reports NOT ON CLIENT leaves the folder. Unchecking the row ignores every id listed, so levelling preserves the choice.
	- The items behind the ITEM rows, and every other item worth auditing, live in Data/TBC/Items-TBC.lua, whose spell field names the trigger each one casts.
	- Drums of Panic and Greater Drums of Panic are leatherworking drums whose Use fears every enemy nearby, so they sit on the Fears tab as AOE fears beside Flash Bomb. Both are crafted (recipes 35538 and 351770). The other items whose Use carries a fear or taunt aura are left out: spell books, drinks and Cowardly Flight Potion fear the player themselves, and Devilsaur Barb (22432) is a quest item.
	- Quest tools whose Use only puts threat on a quest's own mob are left out too: the Taming Rods and Taming Totems, Morbent's Bane, Torch of Flame, the Alterac Valley collar and muzzle, and Glowing Crystal Prison. No equipped item procs a fear or taunt on an enemy.
	- Items have no category of their own. An ITEM row takes the category of what its Use does, so the target dummies are AOE taunts and Flash Bomb and the drums are AOE fears.
	- Anguish is the felguard's Torment: one rank per pet level, its only effect is threat on one target, and its description says it taunts. The pet family test is a spell on a pet's skill line whose only effect is threat on enemies. Intimidation (a stun), Scorpid Poison (a poison) and Warp (a blink) carry threat beside other effects and are left out, and Cower and Soothing Kiss carry only threat but lower it.
	- The three paladin bubbles are parked, listed in the comment under the PALADIN rows with what bringing them back would take.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/SpellName?build=2.5.6.70577
	https://wago.tools/db2/Spell?build=2.5.6.70577
	https://wago.tools/db2/SpellEffect?build=2.5.6.70577
	https://wago.tools/db2/SpellLevels?build=2.5.6.70006
	https://wago.tools/db2/SkillLineAbility?build=2.5.6.70577
	https://wago.tools/db2/SkillLine?build=2.5.6.70577
	https://wago.tools/db2/ItemEffect?build=2.5.6.70577
	https://wago.tools/db2/ItemSparse?build=2.5.6.70577
	https://wago.tools/db2/SpellClassOptions?build=2.5.6.69795
	https://wago.tools/db2/SpellCooldowns?build=2.5.6.69795

QuestieDB
	None.
]]
