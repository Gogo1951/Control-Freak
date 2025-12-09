local _, core = ...

core.SpellDB = {Taunts = {}, Fears = {}, Items = {}, Pets = {}, Annoyances = {}}

local Taunts = core.SpellDB.Taunts
local Fears = core.SpellDB.Fears
local Pets = core.SpellDB.Pets
local Items = core.SpellDB.Items
local Annoyances = core.SpellDB.Annoyances

--------------------------------------------------------------------------------
-- DRUID
--------------------------------------------------------------------------------
Taunts[6795] = {name = "Growl", aoe = false}
Taunts[5209] = {name = "Challenging Roar", aoe = true}

--------------------------------------------------------------------------------
-- HUNTER
--------------------------------------------------------------------------------
-- Distracting Shot
Taunts[20736] = {name = "Distracting Shot (Rank 1)", aoe = false}
Taunts[14274] = {name = "Distracting Shot (Rank 2)", aoe = false}
Taunts[15629] = {name = "Distracting Shot (Rank 3)", aoe = false}
Taunts[15630] = {name = "Distracting Shot (Rank 4)", aoe = false}
Taunts[15631] = {name = "Distracting Shot (Rank 5)", aoe = false}
Taunts[15632] = {name = "Distracting Shot (Rank 6)", aoe = false}
-- Scare Beast
Fears[1513] = {name = "Scare Beast (Rank 1)", aoe = false}
Fears[14326] = {name = "Scare Beast (Rank 2)", aoe = false}
Fears[14327] = {name = "Scare Beast (Rank 3)", aoe = false}

--------------------------------------------------------------------------------
-- MAGE
--------------------------------------------------------------------------------
Annoyances[122] = {name = "Frost Nova (Rank 1)", aoe = true}
Annoyances[865] = {name = "Frost Nova (Rank 2)", aoe = true}
Annoyances[6131] = {name = "Frost Nova (Rank 3)", aoe = true}
Annoyances[10230] = {name = "Frost Nova (Rank 4)", aoe = true}

--------------------------------------------------------------------------------
-- PALADIN
--------------------------------------------------------------------------------
Fears[2812] = {name = "Turn Undead (Rank 1)", aoe = false}
Fears[10308] = {name = "Turn Undead (Rank 2)", aoe = false}

--------------------------------------------------------------------------------
-- PRIEST
--------------------------------------------------------------------------------
Fears[8122] = {name = "Psychic Scream (Rank 1)", aoe = true}
Fears[8124] = {name = "Psychic Scream (Rank 2)", aoe = true}
Fears[10888] = {name = "Psychic Scream (Rank 3)", aoe = true}
Fears[10890] = {name = "Psychic Scream (Rank 4)", aoe = true}

--------------------------------------------------------------------------------
-- SHAMAN
--------------------------------------------------------------------------------
-- Stoneclaw Totem (Classified as Taunt for alerts)
Taunts[5730] = {name = "Stoneclaw Totem (Rank 1)", aoe = true}
Taunts[5854] = {name = "Stoneclaw Totem (Rank 2)", aoe = true}
Taunts[5928] = {name = "Stoneclaw Totem (Rank 3)", aoe = true}
Taunts[8198] = {name = "Stoneclaw Totem (Rank 4)", aoe = true}
Taunts[10406] = {name = "Stoneclaw Totem (Rank 5)", aoe = true}
Taunts[10407] = {name = "Stoneclaw Totem (Rank 6)", aoe = true}

--------------------------------------------------------------------------------
-- WARLOCK
--------------------------------------------------------------------------------
-- Death Coil
Fears[6789] = {name = "Death Coil (Rank 1)", aoe = false}
Fears[17925] = {name = "Death Coil (Rank 2)", aoe = false}
Fears[17926] = {name = "Death Coil (Rank 3)", aoe = false}
-- Fear
Fears[5782] = {name = "Fear (Rank 1)", aoe = false}
Fears[6213] = {name = "Fear (Rank 2)", aoe = false}
Fears[6215] = {name = "Fear (Rank 3)", aoe = false}
-- Howl of Terror
Fears[5484] = {name = "Howl of Terror (Rank 1)", aoe = true}
Fears[17928] = {name = "Howl of Terror (Rank 2)", aoe = true}

--------------------------------------------------------------------------------
-- WARRIOR
--------------------------------------------------------------------------------
Taunts[355] = {name = "Taunt", aoe = false}
Taunts[1161] = {name = "Challenging Shout", aoe = true}
-- Mocking Blow
Taunts[694] = {name = "Mocking Blow (Rank 1)", aoe = false}
Taunts[7400] = {name = "Mocking Blow (Rank 2)", aoe = false}
Taunts[7402] = {name = "Mocking Blow (Rank 3)", aoe = false}
Taunts[20559] = {name = "Mocking Blow (Rank 4)", aoe = false}
Taunts[20560] = {name = "Mocking Blow (Rank 5)", aoe = false}
-- Intimidating Shout
Fears[5246] = {name = "Intimidating Shout", aoe = true}

--------------------------------------------------------------------------------
-- PETS
--------------------------------------------------------------------------------
-- Hunter (Growl)
Pets[2649] = {name = "Growl (Rank 1)", aoe = false}
Pets[14916] = {name = "Growl (Rank 2)", aoe = false}
Pets[14917] = {name = "Growl (Rank 3)", aoe = false}
Pets[14918] = {name = "Growl (Rank 4)", aoe = false}
Pets[14919] = {name = "Growl (Rank 5)", aoe = false}
Pets[14920] = {name = "Growl (Rank 6)", aoe = false}
Pets[14921] = {name = "Growl (Rank 7)", aoe = false}
-- Warlock (Suffering)
Pets[17735] = {name = "Suffering (Rank 1)", aoe = true}
Pets[17750] = {name = "Suffering (Rank 2)", aoe = true}
Pets[17751] = {name = "Suffering (Rank 3)", aoe = true}
Pets[17752] = {name = "Suffering (Rank 4)", aoe = true}
-- Warlock (Torment)
Pets[3716] = {name = "Torment (Rank 1)", aoe = false}
Pets[7809] = {name = "Torment (Rank 2)", aoe = false}
Pets[7810] = {name = "Torment (Rank 3)", aoe = false}
Pets[11774] = {name = "Torment (Rank 4)", aoe = false}
Pets[11775] = {name = "Torment (Rank 5)", aoe = false}
Pets[11776] = {name = "Torment (Rank 6)", aoe = false}

--------------------------------------------------------------------------------
-- ITEMS
--------------------------------------------------------------------------------
-- Target Dummies
Items[4054] = {name = "Target Dummy", aoe = true}
Items[4068] = {name = "Advanced Target Dummy", aoe = true}
Items[23455] = {name = "Masterwork Target Dummy", aoe = true}
-- Consumables
Items[5134] = {name = "Flash Bomb", aoe = true}