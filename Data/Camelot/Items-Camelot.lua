local _, ns = ...

-- [itemId] = { kind, via, on, spell }, -- Item Name
ns.ITEMS = {
	-- Taunts
	[4366] = { kind = "TAUNT", via = "CREATURE", on = "USE", spell = 4071 }, -- Target Dummy
	[4392] = { kind = "TAUNT", via = "CREATURE", on = "USE", spell = 4072 }, -- Advanced Target Dummy
	[16023] = { kind = "TAUNT", via = "CREATURE", on = "USE", spell = 19805 }, -- Masterwork Target Dummy

	-- Fears
	[4852] = { kind = "FEAR", via = "SPELL", on = "USE", spell = 5134 }, -- Flash Bomb

	-- Armor
	[869] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 13752 }, -- Dazzling Longsword
	[1434] = { kind = "ARMOR", via = "SPELL", on = "USE", spell = 13424 }, -- Glowing Wax Stick
	[6909] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 13526 }, -- Strike of the Hydra
	[7344] = { kind = "ARMOR", via = "SPELL", on = "USE", spell = 9176 }, -- Torch of Holy Flame
	[7961] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 9806 }, -- Phantom Blade
	[9465] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 11791 }, -- Digmaster 5000
	[9485] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 11791 }, -- Vibroblade
	[11607] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 15280 }, -- Dark Iron Sunderer
	[11635] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 13526 }, -- Hookfang Shanker
	[12798] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 16928 }, -- Annihilator
	[13204] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 17315 }, -- Bashguuder
	[13286] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 17315 }, -- Rivenspike
	[17766] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 21961 }, -- Princess Theradras' Scepter

	-- Crowd Control
	[835] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 8312 }, -- Large Rope Net
	[942] = { kind = "CONTROL", via = "SPELL", on = "EQUIP", spell = 18799 }, -- Freezing Band
	[1404] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 835 }, -- Tidal Charm
	[2091] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 1090 }, -- Magic Dust
	[3434] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 700 }, -- Slumber Sand
	[4360] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 4064 }, -- Rough Copper Bomb
	[4370] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 4065 }, -- Large Copper Bomb
	[4374] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 4066 }, -- Small Bronze Bomb
	[4380] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 4067 }, -- Big Bronze Bomb
	[4390] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 4068 }, -- Iron Grenade
	[4394] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 4069 }, -- Big Iron Bomb
	[4403] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 4067 }, -- Portable Bronze Mortar
	[4941] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 8312 }, -- Really Sticky Glue
	[7375] = { kind = "CONTROL", via = "SPELL", on = "EQUIP", spell = 9160 }, -- Green Whelp Armor
	[7506] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 8344 }, -- Gnomish Universal Remote
	[7734] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 14537 }, -- Six Demon Bag
	[9394] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 22641 }, -- Horned Viking Helmet
	[9477] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 56 }, -- The Chief's Enforcer
	[10514] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 12421 }, -- Mithril Frag Bomb
	[10562] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 12543 }, -- Hi-Explosive Bomb
	[10577] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 13237 }, -- Goblin Mortar
	[10586] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 12562 }, -- The Big One
	[10588] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 22641 }, -- Goblin Rocket Helmet
	[10627] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 56 }, -- Bludgeon of the Grinning Dog
	[10720] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 13120 }, -- Gnomish Net-o-Matic Projector
	[10726] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 13180 }, -- Gnomish Mind Control Cap
	[10830] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 13808 }, -- M73 Frag Grenade
	[11608] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 15283 }, -- Dark Iron Pulverizer
	[11905] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 15712 }, -- Linken's Boomerang
	[12528] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 56 }, -- The Judge's Gavel
	[12796] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 56 }, -- Hammer of the Titans
	[13198] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 17308 }, -- Hurd Smasher
	[13393] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 17500 }, -- Malown's Slam
	[13953] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 18278 }, -- Silent Fang
	[15993] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 19769 }, -- Thorium Grenade
	[16005] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 19784 }, -- Dark Iron Bomb
	[16040] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 19821 }, -- Arcane Bomb
	[17073] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 21152 }, -- Earthshaker
	[19323] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 23454 }, -- The Unstoppable Force
	[21134] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 26108 }, -- Dark Edge of Insanity
	[22198] = { kind = "CONTROL", via = "SPELL", on = "EQUIP", spell = 27561 }, -- Jagged Obsidian Shield

	-- Group Buffs
	[18606] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 23034 }, -- Alliance Battle Standard
	[18607] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 23035 }, -- Horde Battle Standard
	[19045] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 23539 }, -- Stormpike Battle Standard
	[19046] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 23538 }, -- Frostwolf Battle Standard

	-- Resurrection
	[5232] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20707 }, -- Minor Soulstone
	[7148] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 8342 }, -- Goblin Jumper Cables
	[8546] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 10850 }, -- Powerful Smelling Salts
	[16892] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20762 }, -- Lesser Soulstone
	[16893] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20763 }, -- Soulstone
	[16895] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20764 }, -- Greater Soulstone
	[16896] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20765 }, -- Major Soulstone
	[18587] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 22999 }, -- Goblin Jumper Cables XL

	-- Summons
	[3456] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 9515 }, -- Dog Whistle
	[4384] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 4074 }, -- Explosive Sheep
	[4395] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 4100 }, -- Goblin Land Mine
	[4396] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 23076 }, -- Mechanical Dragonling
	[5052] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 5161 }, -- Unconscious Dig Rat
	[5332] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 6084 }, -- Glowing Cat Figurine
	[10576] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 23075 }, -- Mithril Mechanical Dragonling
	[10587] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 23134 }, -- Goblin Bomb Dispenser
	[10719] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 4074 }, -- Mobile Alarm
	[10725] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 23133 }, -- Gnomish Battle Chicken
	[13353] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 17490 }, -- Book of the Dead
	[14022] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 18307 }, -- Barov Peasant Caller
	[14023] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 18308 }, -- Barov Peasant Caller
	[16022] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 23074 }, -- Arcanite Dragonling
	[17067] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 17490 }, -- Ancient Cornerstone Grimoire
	[18297] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 22792 }, -- Thornling Seed
	[18645] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 23004 }, -- Gnomish Alarm-O-Bot
	[21326] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 26066 }, -- Defender of the Timbermaw
	[21579] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 26391 }, -- Vanquished Tentacle of C'Thun
	[23379] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 29305 }, -- Cinder Bracers

	-- Portals
	[22589] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[22630] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[22631] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[22632] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian

	-- Services
	[18232] = { kind = "SERVICE", via = "CREATURE", on = "USE", spell = 22700 }, -- Field Repair Bot 74A
}

--[[
How We Got the Data

Last Validated
	Never. Copied from Data/Vanilla/.

Notes
	- Every item a player can get that acts on someone besides its user, so the Data Review can search for more items like these from the item side, not only through the spells in Abilities. No feature reads this table yet. Validate Data exports it, and its DATA_TRACKED column marks the rows whose spell an Abilities row listens for.
	- What counts: an item that taunts, fears, lowers armor or crowd-controls an enemy; buffs the whole group; resurrects another player; puts a creature in the fight; opens a portal; or puts a service in the world, such as a repair bot, a mailbox or a resistance cauldron.
	- kind is that job: TAUNT, FEAR, ARMOR, CONTROL, BUFF, RESURRECT, SUMMON, PORTAL or SERVICE. An item that does several takes the first in that order, except that drums and battle standards are BUFF.
	- via is how the effect reaches its targets. SPELL means the item's own spell does it. CREATURE means it summons something that does: a target dummy taunts, the Battle Chicken fights. OBJECT means it places something in the world, like Atiesh's portal or a cauldron.
	- on is when the spell fires: USE, EQUIP, or HIT for a weapon's chance on hit. An equip or hit effect counts only when it acts on an enemy.
	- spell is the item's spell, the one the combat log reports when the item is used. Validate Data's SPELL_ID column should match it.
	- Found two ways. From the spell side, every item's spell is followed through its triggered spells, looking for taunts, threat, fear, armor reduction, crowd control, party-wide auras, resurrection, summons and placed objects. From the item side, every item whose Use is a scripted dummy the tables can't follow is read by its description and sorted by hand. That is how the Gnomish gadgets, the Six Demon Bag and the Goblin Bomb Dispenser got in, and on this client's tables the dragonlings and the Battle Chicken too where their summon is scripted.
	- Left out: quest items, spell books, companion pets and mounts, fireworks, toys and holiday items, brews, single-target scrolls and bandages (they help one player, not the group), test and placeholder items, and Gnomish Shrink Ray (a debuff with no kind here).
	- Obtainable means QuestieDB lists a drop, vendor or quest reward, or a recipe creates it. QuestieDB lists no source for world drops and raid-boss drops, so Dazzling Longsword, Freezing Band, Tidal Charm, Princess Theradras' Scepter, Earthshaker, Ancient Cornerstone Grimoire and Dark Edge of Insanity stay as known drops. Stormwind Medallion, Hunting Net and Spiked Collar have no source anywhere and are left out as likely unobtainable.
	- Copied from Data/Vanilla/ by script. Control Freak ships no WoW Forever TOC, so nothing loads this folder.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	None.

QuestieDB
	None.
]]
