local _, ns = ...

-- [itemId] = { kind, via, on, spell }, -- Item Name
ns.ITEMS = {
	-- Taunts
	[4366] = { kind = "TAUNT", via = "CREATURE", on = "USE", spell = 4071 }, -- Target Dummy
	[4392] = { kind = "TAUNT", via = "CREATURE", on = "USE", spell = 4072 }, -- Advanced Target Dummy
	[16023] = { kind = "TAUNT", via = "CREATURE", on = "USE", spell = 19805 }, -- Masterwork Target Dummy

	-- Fears
	[4852] = { kind = "FEAR", via = "SPELL", on = "USE", spell = 5134 }, -- Flash Bomb
	[29532] = { kind = "FEAR", via = "SPELL", on = "USE", spell = 35474 }, -- Drums of Panic
	[185849] = { kind = "FEAR", via = "SPELL", on = "USE", spell = 351357 }, -- Greater Drums of Panic

	-- Armor
	[869] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 13752 }, -- Dazzling Longsword
	[1434] = { kind = "ARMOR", via = "SPELL", on = "USE", spell = 13424 }, -- Glowing Wax Stick
	[6909] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 13526 }, -- Strike of the Hydra
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
	[23736] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 30216 }, -- Fel Iron Bomb
	[23737] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 30217 }, -- Adamantite Grenade
	[23826] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 30461 }, -- The Bigger One
	[23835] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 30507 }, -- Gnomish Poultryizer
	[23836] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 46567 }, -- Goblin Rocket Launcher
	[24268] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 31367 }, -- Netherweave Net
	[24269] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 31368 }, -- Heavy Netherweave Net
	[28441] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 34510 }, -- Deep Thunder
	[28442] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 34510 }, -- Stormherald
	[32413] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 39965 }, -- Frost Grenade
	[34227] = { kind = "CONTROL", via = "SPELL", on = "EQUIP", spell = 27867 }, -- Deadman's Hand

	-- Group Buffs
	[10030] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 12022 }, -- Admiral's Hat
	[13937] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 18264 }, -- Headmaster's Charge
	[18606] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 23034 }, -- Alliance Battle Standard
	[18607] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 23035 }, -- Horde Battle Standard
	[19045] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 23539 }, -- Stormpike Battle Standard
	[19046] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 23538 }, -- Frostwolf Battle Standard
	[20503] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 24854 }, -- Enamored Water Spirit
	[20830] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 25207 }, -- Amulet of the Moon
	[20831] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 25211 }, -- Heavy Golden Necklace of Battle
	[20950] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 25606 }, -- Pendant of the Agate Shield
	[20966] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 25607 }, -- Jade Pendant of Blasting
	[20967] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 25608 }, -- Citrine Pendant of Golden Healing
	[21755] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 26562 }, -- Aquamarine Pendant of the Warrior
	[24092] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 30997 }, -- Pendant of Frozen Flame
	[24093] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 30994 }, -- Pendant of Thawing
	[24095] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 30999 }, -- Pendant of Withering
	[24097] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 31000 }, -- Pendant of Shadow's End
	[24098] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 31002 }, -- Pendant of the Null Rune
	[24106] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 31023 }, -- Thick Felsteel Necklace
	[24110] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 31024 }, -- Living Ruby Pendant
	[24114] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 31025 }, -- Braided Eternium Chain
	[24116] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 31033 }, -- Eye of the Night
	[24117] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 31026 }, -- Embrace of the Dawn
	[24121] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 31035 }, -- Chain of the Twilight Owl
	[29528] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 35475 }, -- Drums of War
	[29529] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 35476 }, -- Drums of Battle
	[29530] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 35477 }, -- Drums of Speed
	[29531] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 35478 }, -- Drums of Restoration
	[185848] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 351355 }, -- Greater Drums of Battle
	[185850] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 351358 }, -- Greater Drums of Restoration
	[185851] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 351359 }, -- Greater Drums of Speed
	[185852] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 351360 }, -- Greater Drums of War

	-- Resurrection
	[5232] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20707 }, -- Minor Soulstone
	[7148] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 8342 }, -- Goblin Jumper Cables
	[8546] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 10850 }, -- Powerful Smelling Salts
	[16892] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20762 }, -- Lesser Soulstone
	[16893] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20763 }, -- Soulstone
	[16895] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20764 }, -- Greater Soulstone
	[16896] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20765 }, -- Major Soulstone
	[18587] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 22999 }, -- Goblin Jumper Cables XL
	[22116] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 27239 }, -- Master Soulstone

	-- Summons
	[3456] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 9515 }, -- Dog Whistle
	[4384] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 4074 }, -- Explosive Sheep
	[4395] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 4100 }, -- Goblin Land Mine
	[4396] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 4073 }, -- Mechanical Dragonling
	[5332] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 6084 }, -- Glowing Cat Figurine
	[10576] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 12749 }, -- Mithril Mechanical Dragonling
	[10587] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 23134 }, -- Goblin Bomb Dispenser
	[10719] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 4074 }, -- Mobile Alarm
	[10725] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 23133 }, -- Gnomish Battle Chicken
	[10847] = { kind = "SUMMON", via = "CREATURE", on = "HIT", spell = 13049 }, -- Dragon's Call
	[12592] = { kind = "SUMMON", via = "CREATURE", on = "HIT", spell = 16602 }, -- Blackblade of Shahram
	[13353] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 17490 }, -- Book of the Dead
	[13382] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 6251 }, -- Cannonball Runner
	[14022] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 18307 }, -- Barov Peasant Caller
	[14023] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 18308 }, -- Barov Peasant Caller
	[16022] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 19804 }, -- Arcanite Dragonling
	[17067] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 17490 }, -- Ancient Cornerstone Grimoire
	[18297] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 22792 }, -- Thornling Seed
	[18645] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 23004 }, -- Gnomish Alarm-O-Bot
	[21326] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 26066 }, -- Defender of the Timbermaw
	[21579] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 26391 }, -- Vanquished Tentacle of C'Thun
	[21763] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 26593 }, -- Figurine - Truesilver Boar
	[23379] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 29305 }, -- Cinder Bracers
	[23841] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 30526 }, -- Gnomish Flame Turret
	[23862] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 30550 }, -- Redemption of the Fallen
	[24124] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 31038 }, -- Figurine - Felsteel Boar
	[24127] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 31045 }, -- Figurine - Talasite Owl
	[25498] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 32254 }, -- Rough Stone Statue
	[25880] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 32802 }, -- Coarse Stone Statue
	[25881] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 32803 }, -- Heavy Stone Statue
	[25882] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 32804 }, -- Solid Stone Statue
	[25883] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 32805 }, -- Dense Stone Statue
	[25884] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 32806 }, -- Primal Stone Statue
	[32471] = { kind = "SUMMON", via = "CREATURE", on = "HIT", spell = 40393 }, -- Shard of Azzinoth
	[32694] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 40811 }, -- Overseer's Badge
	[32695] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 40815 }, -- Captain's Badge
	[32864] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 40815 }, -- Commander's Badge
	[34029] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 43995 }, -- Tiny Voodoo Mask
	[35693] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 46780 }, -- Figurine - Empyrean Tortoise
	[35694] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 46782 }, -- Figurine - Khorium Boar

	-- Portals
	[22589] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[22630] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[22631] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[22632] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[29796] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 35745 }, -- Socrethar's Teleportation Stone

	-- Services
	[18232] = { kind = "SERVICE", via = "CREATURE", on = "USE", spell = 22700 }, -- Field Repair Bot 74A
	[23840] = { kind = "SERVICE", via = "OBJECT", on = "USE", spell = 30524 }, -- Remote Mail Terminal
	[32839] = { kind = "SERVICE", via = "OBJECT", on = "USE", spell = 41443 }, -- Cauldron of Major Arcane Protection
	[32849] = { kind = "SERVICE", via = "OBJECT", on = "USE", spell = 41494 }, -- Cauldron of Major Fire Protection
	[32850] = { kind = "SERVICE", via = "OBJECT", on = "USE", spell = 41495 }, -- Cauldron of Major Frost Protection
	[32851] = { kind = "SERVICE", via = "OBJECT", on = "USE", spell = 41497 }, -- Cauldron of Major Nature Protection
	[32852] = { kind = "SERVICE", via = "OBJECT", on = "USE", spell = 41498 }, -- Cauldron of Major Shadow Protection
	[33219] = { kind = "SERVICE", via = "OBJECT", on = "USE", spell = 42753 }, -- Goblin Gumbo Kettle
	[34113] = { kind = "SERVICE", via = "CREATURE", on = "USE", spell = 44389 }, -- Field Repair Bot 110G
}

--[[
How We Got the Data

Last Validated
	2026-10-28, TBC Anniversary 2.5.6.70577

Notes
	- Every item a player can get that acts on someone besides its user, so the Data Review can search for more items like these from the item side, not only through the spells in Abilities. No feature reads this table yet. Validate Data exports it, and its DATA_TRACKED column marks the rows whose spell an Abilities row listens for.
	- What counts: an item that taunts, fears, lowers armor or crowd-controls an enemy; buffs the whole group; resurrects another player; puts a creature in the fight; opens a portal; or puts a service in the world, such as a repair bot, a mailbox or a resistance cauldron.
	- kind is that job: TAUNT, FEAR, ARMOR, CONTROL, BUFF, RESURRECT, SUMMON, PORTAL or SERVICE. An item that does several takes the first in that order, except that drums, battle standards and Enamored Water Spirit's totem are BUFF.
	- via is how the effect reaches its targets. SPELL means the item's own spell does it. CREATURE means it summons something that does: a target dummy taunts, the Battle Chicken fights. OBJECT means it places something in the world, like Atiesh's portal or a cauldron.
	- on is when the spell fires: USE, EQUIP, or HIT for a weapon's chance on hit. An equip or hit effect counts only when it acts on an enemy.
	- spell is the item's spell: for a USE row the one the combat log reports when the item is used, and for an EQUIP or HIT row the equip spell that carries the effect. Validate Data's SPELL_ID column reads only the Use spell, so it should match a USE row and is blank on most EQUIP and HIT rows.
	- Found two ways. From the spell side, every item's spell is followed through its triggered spells, looking for taunts, threat, fear, armor reduction, crowd control, party-wide auras, resurrection, summons and placed objects. From the item side, every item whose Use is a scripted dummy the tables can't follow is read by its description and sorted by hand. That is how the Gnomish gadgets, the Six Demon Bag and the Goblin Bomb Dispenser got in, and on this client's tables the dragonlings and the Battle Chicken too where their summon is scripted.
	- Left out: quest items, spell books, companion pets and mounts, fireworks, toys and holiday items, brews, single-target scrolls and bandages (they help one player, not the group), test and placeholder items, and Gnomish Shrink Ray (a debuff with no kind here). Also left out: Abyss Shard, a free cast of the warlock's own Summon Voidwalker; Mechanical Yeti, the reward toy from its Winterspring quest chain; Chrono-beacon, which works only inside the Black Morass; and Blade and Rod of the Unyielding, whose undescribed equip spell summons their quest's own Unyielding Knights.
	- The jewelcrafting necklaces whose Use buffs every nearby party member are BUFF: the stat, spell damage and healing pendants and the five pendants that absorb one school of damage.
	- Obtainable means QuestieDB lists a drop, vendor or quest reward, or a recipe creates it. QuestieDB lists no source for world drops and raid-boss drops, so Dazzling Longsword, Freezing Band, Tidal Charm, Princess Theradras' Scepter, Earthshaker, Ancient Cornerstone Grimoire, Dark Edge of Insanity, Dragon's Call, Shard of Azzinoth and Tiny Voodoo Mask stay as known drops. Stormwind Medallion, Hunting Net and Spiked Collar have no source anywhere and are left out as likely unobtainable.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/Item?build=2.5.6.70577
	https://wago.tools/db2/ItemSparse?build=2.5.6.70577
	https://wago.tools/db2/ItemEffect?build=2.5.6.70577
	https://wago.tools/db2/SpellName?build=2.5.6.70577
	https://wago.tools/db2/Spell?build=2.5.6.70577
	https://wago.tools/db2/SpellEffect?build=2.5.6.70577
	https://wago.tools/db2/SummonProperties?build=2.5.6.70006

QuestieDB
	https://raw.githubusercontent.com/Questie/QuestieDB/master/data/TBC/tbcItemDB.lua
]]
