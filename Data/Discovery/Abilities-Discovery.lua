local _, ns = ...

if not ns.IS_DISCOVERY then
	return
end

-- { class, category, detection, isAoe, kindChoice, renamed, triggers }, -- Ability Name
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
		detection = "AURA",
		isAoe = true,
		triggers = { 5209 },
	}, -- Challenging Roar

	-- HUNTER
	{
		class = "HUNTER",
		category = "TAUNT",
		detection = "CAST",
		isAoe = false,
		triggers = { 20736, 14274, 15629, 15630, 15631, 15632 },
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
		triggers = { 122, 865, 6131, 10230 },
	}, -- Frost Nova

	-- PALADIN
	{
		class = "PALADIN",
		category = "FEAR",
		detection = "AURA",
		isAoe = false,
		triggers = { 2878, 5627, 10326 },
	}, -- Turn Undead
	{
		class = "PALADIN",
		category = "TAUNT",
		detection = "AURA",
		isAoe = false,
		triggers = { 407631, 1219206 },
	}, -- Hand of Reckoning, the single-target paladin taunt a glove rune grants, which is why both copies carry a Righteous Fury rider. Its rune spells are not ranks and are deliberately absent: 409911 is the "Gain the Hand of Reckoning ability" passive, 410001 the engraving itself, 407774 a stub with no text at all
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
		triggers = { 8122, 8124, 10888, 10890 },
	}, -- Psychic Scream

	-- ROGUE
	{
		class = "ROGUE",
		category = "TAUNT",
		detection = "CAST",
		isAoe = false,
		triggers = { 410412, 1219355 },
	}, -- Tease, which the Just a Flesh Wound rune puts in place of Feint

	-- SHAMAN
	{
		class = "SHAMAN",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		triggers = { 5730, 6390, 6391, 6392, 10427, 10428 },
	}, -- Stoneclaw Totem
	{
		class = "SHAMAN",
		category = "TAUNT",
		detection = "CAST",
		isAoe = false,
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
		triggers = { 6789, 17925, 17926 },
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
		detection = "AURA",
		isAoe = true,
		triggers = { 5484, 17928 },
	}, -- Howl of Terror
	{
		class = "WARLOCK",
		category = "TAUNT",
		detection = "AURA",
		isAoe = false,
		renamed = true,
		triggers = { 403828, 433672, 442226, 442233, 1219475 },
	}, -- Menace, the single-target taunt the Metamorphosis rune puts in place of Fear, and the partner to Demonic Howl below. Phase 2 shipped it as Loathing (433672) -- same class, same icon, same two effects -- and the name went back to Menace afterwards, which is what renamed is for
	{
		class = "WARLOCK",
		category = "TAUNT",
		detection = "CAST",
		isAoe = true,
		triggers = { 412789 },
	}, -- Demonic Howl, the AoE taunt the Metamorphosis rune grants

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
		triggers = { 694, 7400, 7402, 20559, 20560 },
	}, -- Mocking Blow
	{
		class = "WARRIOR",
		category = "TAUNT",
		detection = "AURA",
		isAoe = true,
		triggers = { 1161 },
	}, -- Challenging Shout
	{
		class = "WARRIOR",
		category = "FEAR",
		detection = "AURA",
		isAoe = true,
		triggers = { 5246 },
	}, -- Intimidating Shout

	-- PETS
	{
		class = "HUNTER",
		category = "PET_TAUNT",
		detection = "CAST",
		isAoe = false,
		triggers = { 2649, 14916, 14917, 14918, 14919, 14920, 14921, 409372 },
	}, -- Growl. 409372 is Season of Discovery's own copy, the one the Beast Mastery rune grants, and the only Growl on this list that taunts rather than just holding threat
	{
		class = "WARLOCK",
		category = "PET_TAUNT",
		detection = "CAST",
		isAoe = true,
		triggers = { 17735, 17750, 17751, 17752 },
	}, -- Suffering
	{
		class = "WARLOCK",
		category = "PET_TAUNT",
		detection = "CAST",
		isAoe = false,
		triggers = { 3716, 7809, 7810, 7811, 11774, 11775 },
	}, -- Torment. This client stops at rank 6 (11775); 11776 and 11777 share its name but are not castable ranks
	{
		class = "WARLOCK",
		category = "PET_TAUNT",
		detection = "CAST",
		isAoe = false,
		triggers = { 427742 },
	}, -- Anguish

	-- ITEMS

	-- triggers are what the combat log reports for each item: the spell its Use casts, or the fear its proc lands.
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
		detection = "AURA",
		isAoe = false,
		triggers = { 21330 },
	}, -- Corrupted Fear
}

--[[
How We Got the Data

Last Validated
	2026-10-20, Season of Discovery 1.15.9.70003

Notes
	- Every ability Control Freak watches on Season of Discovery, one row per checkbox in the options panel, grouped by class, with the pets' taunts and the items last.
	- class is the bucket the options panel files the row under; ITEM is its own bucket.
	- category is TAUNT, FEAR, NOVA, SHIELD or PET_TAUNT, and ns.CATEGORY_FEATURE in Features/Ability-Index.lua maps each to the tab that owns its alert.
	- detection is how a success is recognised. AURA means the ability lands an aura on its target, so success is that aura applying and a resist produces exactly one failure line. CAST means it lands nothing to observe, so the cast itself is the success. Pet taunts are CAST: Growl, Torment, Suffering and Anguish apply no debuff, and watching for an aura would leave the whole feature silent.
	- isAoe means the ability hits more than one target. It picks the alert section that reports it and suppresses failure lines, since an AoE taunt fires one miss per immune mob, which is noise rather than information.
	- kindChoice, taunts only, marks a taunt that takes a few mobs rather than one or a whole pack, so the Taunts tab lets the player report it as Single Target or AOE, with isAoe as the default. Every other taunt's dropdown is locked on its isAoe. It needs AURA detection: a cast names one target at most, where an aura lands on each mob the taunt took. No row on this client sets it.
	- renamed marks an ability whose ranks answer to more than one name on this client, so Validate Data reports a differing name as RENAMED rather than as the typo signal NAME MISMATCH. Set it only for a verified rename, never to quiet a surprise. A rename stays one row, and the panel shows whichever name the client gives the highest rank the character has. Menace is the one row that sets it: Phase 2 shipped it as Loathing (433672), and both ride the same row.
	- triggers lists every rank and variant the one checkbox covers, in rank order, and only ids this client knows: an id Validate Data reports NOT ON CLIENT leaves the folder. Unchecking the row ignores every id listed, so levelling preserves the choice.
	- The items behind the ITEM rows, and every other item worth auditing, live in Data/Discovery/Items-Discovery.lua, whose spell field names the trigger each one casts.
	- Corrupted Fear is the proc on Ring of the Dreaded Mist and both Dreadblades of the Destructor: when the wearer is struck, it can fear the attacker for 2 seconds. Its row is AURA and lists 21330, the fear it lands on the attacker, because the equip spells (27780, 462229) never reach the combat log. It is the one ITEM row that is not a Use.
	- The other items whose Use carries a fear or taunt aura are left out: spell books, drinks and Cowardly Flight Potion fear the player themselves, and Devilsaur Barb (22432) is a quest item.
	- Items have no category of their own. An ITEM row takes the category of what it does, so the target dummies are AOE taunts and Flash Bomb an AOE fear.
	- Anguish (427742) is the felguard's taunt, the pet the Summon Felguard rune brings: one rank, its only effect is threat on one target, and its description says it taunts. The pet family test is a spell on a pet's skill line whose only effect is threat on enemies. Cower and Soothing Kiss carry only threat too, but lower it, so they are left out.
	- The three paladin bubbles are parked, listed in the comment under the PALADIN rows with what bringing them back would take.
	- Power Word: Shield (SHIELD, the Bad Priests tab) is left out on purpose, as a judgement call rather than a fact about the ids. The Strength of Soul rune (passive 415739) makes a shielded target generate rage from absorbed damage anyway, and no add-on can read another player's runes, so the warning would accuse healers who are playing correctly.
	- A rune ability is listed by the ids its casts use, never by the rune's engraving or its "Gain the ability" passive, which are not casts.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/SpellName?build=1.15.9.70003
	https://wago.tools/db2/Spell?build=1.15.9.70003
	https://wago.tools/db2/SpellEffect?build=1.15.9.70003
	https://wago.tools/db2/SpellLevels?build=1.15.9.70003
	https://wago.tools/db2/SpellClassOptions?build=1.15.9.70003
	https://wago.tools/db2/SkillLineAbility?build=1.15.9.70003
	https://wago.tools/db2/SkillLine?build=1.15.9.70003
	https://wago.tools/db2/SpellCooldowns?build=1.15.9.70003
	https://wago.tools/db2/ItemEffect?build=1.15.9.70003
	https://wago.tools/db2/ItemSparse?build=1.15.9.70003
]]
