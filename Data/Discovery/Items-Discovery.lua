local _, ns = ...

if not ns.IS_DISCOVERY then
	return
end

-- [itemId] = { kind, via, on, spell }, -- Item Name
ns.ITEMS = {
	-- Taunts
	[4366] = { kind = "TAUNT", via = "CREATURE", on = "USE", spell = 4071 }, -- Target Dummy
	[4392] = { kind = "TAUNT", via = "CREATURE", on = "USE", spell = 4072 }, -- Advanced Target Dummy
	[16023] = { kind = "TAUNT", via = "CREATURE", on = "USE", spell = 19805 }, -- Masterwork Target Dummy

	-- Fears
	[4852] = { kind = "FEAR", via = "SPELL", on = "USE", spell = 5134 }, -- Flash Bomb
	[227282] = { kind = "FEAR", via = "SPELL", on = "EQUIP", spell = 27780 }, -- Ring of the Dreaded Mist
	[228410] = { kind = "FEAR", via = "SPELL", on = "EQUIP", spell = 462229 }, -- Dreadblade of the Destructor
	[228498] = { kind = "FEAR", via = "SPELL", on = "EQUIP", spell = 462229 }, -- Dreadblade of the Destructor

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
	[209562] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 422996 }, -- Deadly Strike of the Hydra
	[213295] = { kind = "ARMOR", via = "SPELL", on = "HIT", spell = 434837 }, -- Ultrasonic Vibroblade

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
	[191272] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 370308 }, -- Rod of Necromancy
	[216502] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 436473 }, -- Bloodstorm War Totem
	[219345] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 443265 }, -- Infernal Lasso
	[220173] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 446707 }, -- Parasomnia
	[220649] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 448572 }, -- Merithra's Inheritence
	[221310] = { kind = "CONTROL", via = "SPELL", on = "EQUIP", spell = 446390 }, -- Darkmoon Card: Torment
	[221439] = { kind = "CONTROL", via = "SPELL", on = "EQUIP", spell = 9160 }, -- Armor of the Emerald Slumber
	[221465] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 436473 }, -- Corrupted Smashbringer
	[221468] = { kind = "CONTROL", via = "SPELL", on = "EQUIP", spell = 27561 }, -- Wall of Whispers
	[221469] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 446731 }, -- Headhunter's Barbed Spear
	[227279] = { kind = "CONTROL", via = "SPELL", on = "EQUIP", spell = 27867 }, -- Loop of the Magister
	[227858] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 56 }, -- Hammer of the Wild Gods
	[227887] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 463448 }, -- Hardened Frostguard
	[228024] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 18278 }, -- Silent Fang
	[228230] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 56 }, -- Refined Hammer of the Titans
	[228248] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 21152 }, -- Earthshaker
	[228463] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 21152 }, -- Earthshaker
	[233216] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 473525 }, -- Freez-O-Matic Ray
	[233640] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 1214205 }, -- Dark Edge of Insanity
	[233796] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 56 }, -- Obsidian Destroyer
	[233984] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 1213924 }, -- Arcane Megabomb
	[234459] = { kind = "CONTROL", via = "SPELL", on = "EQUIP", spell = 1214272 }, -- Jagged Obsidian Shield
	[234985] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 1214205 }, -- Dark Edge of Insanity
	[236224] = { kind = "CONTROL", via = "SPELL", on = "USE", spell = 1220533 }, -- Stygian Buckler
	[236340] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 1227820 }, -- Might of Menethil
	[238945] = { kind = "CONTROL", via = "SPELL", on = "HIT", spell = 1232312 }, -- Caladboulder

	-- Group Buffs
	[10030] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 12022 }, -- Admiral's Hat
	[13937] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 18264 }, -- Headmaster's Charge
	[18606] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 23034 }, -- Alliance Battle Standard
	[18607] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 23035 }, -- Horde Battle Standard
	[19045] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 23539 }, -- Stormpike Battle Standard
	[19046] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 23538 }, -- Frostwolf Battle Standard
	[20503] = { kind = "BUFF", via = "CREATURE", on = "USE", spell = 24854 }, -- Enamored Water Spirit
	[213349] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 435895 }, -- Gniodine Pill Bottle
	[216517] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 436373 }, -- Sanguine Sanctuary
	[228022] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 18264 }, -- Headmaster's Charge
	[228186] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 461314 }, -- Abandoned Wedding Band
	[228189] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 461318 }, -- Gift of Gob
	[228978] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 463864 }, -- Enchanted Sigil: Flowing Waters
	[230280] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 467525 }, -- Aegis of Preservation
	[233995] = { kind = "BUFF", via = "SPELL", on = "USE", spell = 1214001 }, -- Scroll: Wrath of the Swarm

	-- Resurrection
	[5232] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20707 }, -- Minor Soulstone
	[7148] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 8342 }, -- Goblin Jumper Cables
	[8546] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 10850 }, -- Powerful Smelling Salts
	[16892] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20762 }, -- Lesser Soulstone
	[16893] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20763 }, -- Soulstone
	[16895] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20764 }, -- Greater Soulstone
	[16896] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 20765 }, -- Major Soulstone
	[18587] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 22999 }, -- Goblin Jumper Cables XL
	[213353] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 435532 }, -- Defibrillating Staff
	[221315] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 446397 }, -- Rainbow Generator
	[221443] = { kind = "RESURRECT", via = "SPELL", on = "USE", spell = 446710 }, -- Roar of the Grove

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
	[10847] = { kind = "SUMMON", via = "CREATURE", on = "HIT", spell = 13049 }, -- Dragon's Call
	[12592] = { kind = "SUMMON", via = "CREATURE", on = "HIT", spell = 16602 }, -- Blackblade of Shahram
	[13353] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 17490 }, -- Book of the Dead
	[13382] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 6251 }, -- Cannonball Runner
	[14022] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 18307 }, -- Barov Peasant Caller
	[14023] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 18308 }, -- Barov Peasant Caller
	[16022] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 23074 }, -- Arcanite Dragonling
	[17067] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 17490 }, -- Ancient Cornerstone Grimoire
	[18297] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 22792 }, -- Thornling Seed
	[18645] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 23004 }, -- Gnomish Alarm-O-Bot
	[21326] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 26066 }, -- Defender of the Timbermaw
	[21579] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 26391 }, -- Vanquished Tentacle of C'Thun
	[23379] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 29305 }, -- Cinder Bracers
	[191477] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 370647 }, -- Skeletal Hitching Post
	[191661] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 370832 }, -- Monstrous Spider Fang
	[210253] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 425285 }, -- Rot Totem
	[211487] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 429732 }, -- Demolition Explosives
	[211527] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 429961 }, -- Cozy Sleeping Bag
	[215461] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 436069 }, -- Domesticated Attack Chicken
	[216941] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 438305 }, -- Ariden's Sigil
	[220582] = { kind = "SUMMON", via = "CREATURE", on = "HIT", spell = 13049 }, -- Dragon's Cry
	[220619] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 446101 }, -- Atal'ai Blood Ceremony
	[223168] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 448627 }, -- Worldcore Fragment
	[226122] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 459170 }, -- Dalton's Horn
	[226523] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 459207 }, -- Dalton's Horn
	[226545] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 459232 }, -- Dalton's Horn
	[227811] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 26066 }, -- Defender of the Timbermaw
	[228130] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 461240 }, -- Altruist Ward
	[228131] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 461241 }, -- Altruist Ward
	[228523] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 462358 }, -- Cannonball Runner
	[228539] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 17490 }, -- Book of the Dead
	[228606] = { kind = "SUMMON", via = "CREATURE", on = "HIT", spell = 16602 }, -- Blackblade of Shahram
	[228955] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 17490 }, -- Ancient Cornerstone Grimoire
	[230920] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 467720 }, -- Mar'li's Eye
	[230939] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 467754 }, -- Will of Arlokk
	[231850] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 467754 }, -- Will of Arlokk
	[233197] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 473384 }, -- Argent Training Manual
	[233250] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 473702 }, -- Ancient Branch
	[233639] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 1214206 }, -- Vanquished Tentacle of C'Thun
	[233987] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 1213955 }, -- G00 DV-1B3 Generator
	[239010] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 1229340 }, -- Hilt of the Ashbringer
	[240936] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 1229340 }, -- Inert Ashbringer
	[241068] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 1230980 }, -- Stiltz's Standard
	[241081] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 1229340 }, -- Corrupted Ashbringer
	[242793] = { kind = "SUMMON", via = "CREATURE", on = "USE", spell = 1233908 }, -- Portable Cannon

	-- Portals
	[22589] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[22630] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[22631] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[22632] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[236398] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[236399] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[236400] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian
	[236401] = { kind = "PORTAL", via = "OBJECT", on = "USE", spell = 28148 }, -- Atiesh, Greatstaff of the Guardian

	-- Services
	[18232] = { kind = "SERVICE", via = "CREATURE", on = "USE", spell = 22700 }, -- Field Repair Bot 74A
	[233209] = { kind = "SERVICE", via = "OBJECT", on = "USE", spell = 473466 }, -- Firewater Cauldron
	[238641] = { kind = "SERVICE", via = "OBJECT", on = "USE", spell = 1225906 }, -- Specklefin Feast
	[238642] = { kind = "SERVICE", via = "OBJECT", on = "USE", spell = 1225907 }, -- Grand Lobster Banquet
}

--[[
How We Got the Data

Last Validated
	2026-10-28, Season of Discovery 1.15.9.70576

Notes
	- Every item a player can get that acts on someone besides its user, so the Data Review can search for more items like these from the item side, not only through the spells in Abilities. No feature reads this table yet. Validate Data exports it, and its DATA_TRACKED column marks the rows whose spell an Abilities row listens for.
	- What counts: an item that taunts, fears, lowers armor or crowd-controls an enemy; buffs the whole group; resurrects another player; puts a creature in the fight; opens a portal; or puts a service in the world, such as a repair bot, a mailbox or a resistance cauldron.
	- kind is that job: TAUNT, FEAR, ARMOR, CONTROL, BUFF, RESURRECT, SUMMON, PORTAL or SERVICE. An item that does several takes the first in that order, except that battle standards and Enamored Water Spirit's totem are BUFF.
	- via is how the effect reaches its targets. SPELL means the item's own spell does it. CREATURE means it summons something that does: a target dummy taunts, the Battle Chicken fights. OBJECT means it places something in the world, like Atiesh's portal or a cauldron.
	- on is when the spell fires: USE, EQUIP, or HIT for a weapon's chance on hit. An equip or hit effect counts only when it acts on an enemy.
	- spell is the item's spell: for a USE row the one the combat log reports when the item is used, and for an EQUIP or HIT row the equip spell that carries the effect. Validate Data's SPELL_ID column reads only the Use spell, so it should match a USE row and is blank on most EQUIP and HIT rows.
	- Found two ways. From the spell side, every item's spell is followed through its triggered spells, looking for taunts, threat, fear, armor reduction, crowd control, party-wide auras, resurrection, summons and placed objects. From the item side, every item whose Use is a scripted dummy the tables can't follow is read by its description and sorted by hand. That is how the Gnomish gadgets, the Six Demon Bag and the Goblin Bomb Dispenser got in, and on this client's tables the dragonlings and the Battle Chicken too where their summon is scripted.
	- Left out: quest items, spell books, companion pets and mounts, fireworks, toys and holiday items, brews, single-target scrolls and bandages (they help one player, not the group), test and placeholder items, and Gnomish Shrink Ray (a debuff with no kind here). Also left out: Abyss Shard, a free cast of the warlock's own Summon Voidwalker, and Mechanical Yeti, the reward toy from its Winterspring quest chain.
	- Obtainable means QuestieDB lists a drop, vendor or quest reward, or a recipe creates it. QuestieDB lists no source for world drops and raid-boss drops, so Dazzling Longsword, Freezing Band, Tidal Charm, Princess Theradras' Scepter, Earthshaker, Ancient Cornerstone Grimoire, Dark Edge of Insanity and Dragon's Call stay as known drops. Stormwind Medallion, Hunting Net and Spiked Collar have no source anywhere and are left out as likely unobtainable.
	- Holds the Classic Era rows plus Season of Discovery's own items: ids from 190000 up that QuestieDB's Classic table lacks. QuestieDB's Season of Discovery item list gives most of them no source, so such an item is kept when it is uncommon or better or a recipe creates it. That leaves out the rune-quest props (Ominous Tome, the bait meats, Battle Totem, Tortured Soul and the like, and Infernal Lasso, which only weakens one quest boss), Scroll of Reintegration, a common resurrection scroll, and Scroll of Polymorph: Odd Melon, a common polymorph scroll. No recipe makes either scroll and QuestieDB lists no source for them. The feasts (Specklefin Feast, Grand Lobster Banquet) are SERVICE: like a cauldron, they place something the group uses.

SQL (CMaNGOS)
	TODO: Add SQL Query

Wowhead
	None.

wago.tools
	https://wago.tools/db2/Item?build=1.15.9.70576
	https://wago.tools/db2/ItemSparse?build=1.15.9.70576
	https://wago.tools/db2/ItemEffect?build=1.15.9.70576
	https://wago.tools/db2/SpellName?build=1.15.9.70576
	https://wago.tools/db2/Spell?build=1.15.9.70576
	https://wago.tools/db2/SpellEffect?build=1.15.9.70576
	https://wago.tools/db2/SummonProperties?build=1.15.9.70003

QuestieDB
	https://raw.githubusercontent.com/Questie/QuestieDB/master/data/Classic/classicItemDB.lua
	https://raw.githubusercontent.com/Questie/QuestieDB/master/src/corrections/Sod/sodBaseItems.lua
]]
