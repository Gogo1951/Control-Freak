local _, core = ...
local ControlFreak = LibStub("AceAddon-3.0"):GetAddon("ControlFreak")
local L = LibStub("AceLocale-3.0"):GetLocale("ControlFreak")

local function GetDB()
    if not ControlFreak.db or not ControlFreak.db.profile then
        return {
            blacklist = {},
            general = {globalEnable = false},
            own = {},
            group = {},
            other = {},
            pets = {},
            fears = {},
            annoyances = {},
            items = {}
        }
    end
    return ControlFreak.db.profile
end

local outputChannels = {
    ["SELF"] = L["CHANNEL_SELF"],
    ["GROUP"] = L["CHANNEL_GROUP"]
}

local function DefineSpellToggle(name, desc, idList, order)
    return {
        type = "toggle",
        name = name,
        desc = desc,
        order = order,
        width = "full",
        get = function(info)
            for _, id in ipairs(idList) do
                if GetDB().blacklist[id] then
                    return false
                end
            end
            return true
        end,
        set = function(info, value)
            for _, id in ipairs(idList) do
                if value then
                    GetDB().blacklist[id] = nil
                else
                    GetDB().blacklist[id] = true
                end
            end
        end
    }
end

local options = {
    name = "Control Freak",
    handler = ControlFreak,
    type = "group",
    args = {
        home = {
            name = "Total Combat Awareness",
            type = "group",
            order = 0,
            args = {
                desc = {
                    order = 2,
                    type = "description",
                    fontSize = "medium",
                    name = "\nAre you a Tank tired of guessing if your taunt was resisted? A Raid Leader trying to figure out who feared the trash pack? Or maybe you just hate it when a Hunter's pet growls off you in a dungeon?\n\nControl Freak gives you granular control over Combat Log events that actually matter. Unlike other lightweight announcers, Control Freak allows you to set different rules for |cffffd700You|r, your |cffffd700Party|r, and |cffffd700Outsiders|r."
                },
                headerFeatures = {
                    order = 3,
                    type = "header",
                    name = "Features"
                },
                features = {
                    order = 4,
                    type = "description",
                    fontSize = "medium",
                    name = "|cffffd700Smart Tracking:|r Monitors Taunts (Single & AoE), Fears, Annoyances (Frost Nova), Pets (Growl/Torment), and Items (Target Dummies).\n\n" ..
                        "|cffffd700Resist & Immune Detection:|r Specifically tracks when critical spells fail so you can react instantly.\n\n" ..
                            "|cffffd700Context Aware:|r Automatically switches settings based on if you are Solo, in a Party, Raid, Battleground, or Arena.\n\n" ..
                                '|cffffd700The "Bad Pet" Monitor:|r Instantly calls out (locally) when a pet growls, identifying both the pet and the owner.\n\n' ..
                                    "|cffffd700Optional Audio Alerts:|r Distinct sounds for success, failure, and AoE events. Know your taunt failed without looking at the chat."
                },
                version = {
                    order = 5,
                    type = "description",
                    name = function()
                        return "\n\nVersion: |cffffd700" .. ControlFreak.version .. "|r\nAuthor: |cffffd700Gogo1951|r"
                    end
                },
                note = {
                    order = 6,
                    type = "description",
                    name = "\nUse the |cffffd700+ button|r on the left to expand the settings menu."
                }
            }
        },
        main_settings = {
            name = "Settings",
            type = "group",
            order = 1,
            args = {
                genHeader = {order = 1, type = "header", name = L["GENERAL_SETTINGS"]},
                globalEnable = {
                    order = 2,
                    type = "toggle",
                    name = L["ENABLE"],
                    desc = L["ENABLE_DESC"],
                    width = "full",
                    get = function()
                        return GetDB().general.globalEnable
                    end,
                    set = function(_, v)
                        GetDB().general.globalEnable = v
                    end
                },
                groupsHeader = {order = 3, type = "header", name = L["GROUP_SETTINGS"]},
                enableNotInGroup = {
                    order = 4,
                    type = "toggle",
                    name = L["SOLO_ENABLE"],
                    desc = L["SOLO_DESC"],
                    width = "full",
                    get = function()
                        return GetDB().general.notInGroup
                    end,
                    set = function(_, v)
                        GetDB().general.notInGroup = v
                    end
                },
                enableInParty = {
                    order = 5,
                    type = "toggle",
                    name = L["PARTY_ENABLE"],
                    desc = L["PARTY_DESC"],
                    width = "full",
                    get = function()
                        return GetDB().general.inParty
                    end,
                    set = function(_, v)
                        GetDB().general.inParty = v
                    end
                },
                enableInRaid = {
                    order = 6,
                    type = "toggle",
                    name = L["RAID_ENABLE"],
                    desc = L["RAID_DESC"],
                    width = "full",
                    get = function()
                        return GetDB().general.inRaid
                    end,
                    set = function(_, v)
                        GetDB().general.inRaid = v
                    end
                },
                zonesHeader = {order = 7, type = "header", name = L["ZONE_SETTINGS"]},
                enableOpenWorld = {
                    order = 8,
                    type = "toggle",
                    name = L["OPEN_WORLD_ENABLE"],
                    desc = L["OPEN_WORLD_DESC"],
                    width = "full",
                    get = function()
                        return GetDB().general.openWorld
                    end,
                    set = function(_, v)
                        GetDB().general.openWorld = v
                    end
                },
                enableInstances = {
                    order = 9,
                    type = "toggle",
                    name = L["INSTANCE_ENABLE"],
                    desc = L["INSTANCE_DESC"],
                    width = "full",
                    get = function()
                        return GetDB().general.instances
                    end,
                    set = function(_, v)
                        GetDB().general.instances = v
                    end
                },
                enableBattlegrounds = {
                    order = 10,
                    type = "toggle",
                    name = L["BG_ENABLE"],
                    desc = L["BG_DESC"],
                    width = "full",
                    get = function()
                        return GetDB().general.battlegrounds
                    end,
                    set = function(_, v)
                        GetDB().general.battlegrounds = v
                    end
                },
                enableArenas = {
                    order = 11,
                    type = "toggle",
                    name = L["ARENA_ENABLE"],
                    desc = L["ARENA_DESC"],
                    width = "full",
                    get = function()
                        return GetDB().general.arenas
                    end,
                    set = function(_, v)
                        GetDB().general.arenas = v
                    end
                },
                ownHeader = {order = 20, type = "header", name = L["OWN_TAUNTS"]},
                ownEnable = {
                    order = 21,
                    type = "toggle",
                    name = string.format(L["ENABLE_FOR_SECTION"], L["OWN_TAUNTS"]),
                    width = "double",
                    get = function()
                        return GetDB().own.enable
                    end,
                    set = function(_, v)
                        GetDB().own.enable = v
                    end
                },
                ownRank = {
                    order = 22,
                    type = "select",
                    name = L["ENEMY_TYPE"],
                    width = "normal",
                    values = {[1] = L["BOSSES_ONLY"], [2] = L["ELITES_HIGHER"], [3] = L["ALL_TARGETS"]},
                    get = function()
                        return GetDB().own.rank
                    end,
                    set = function(_, v)
                        GetDB().own.rank = v
                    end
                },
                ownPrint = {
                    order = 23,
                    type = "toggle",
                    name = string.format(L["PRINT_ENABLE"], L["OWN_TAUNTS"]),
                    width = "double",
                    get = function()
                        return GetDB().own.print
                    end,
                    set = function(_, v)
                        GetDB().own.print = v
                    end
                },
                ownChannel = {
                    order = 24,
                    type = "select",
                    name = L["PRINT_TO"],
                    width = "normal",
                    values = outputChannels,
                    get = function()
                        return GetDB().own.channel
                    end,
                    set = function(_, v)
                        GetDB().own.channel = v
                    end
                },
                ownExample = {order = 25, type = "description", name = L["EXAMPLE_OWN_TAUNT"]},
                ownAudio = {
                    order = 26,
                    type = "toggle",
                    name = string.format(L["AUDIO_ENABLE"], L["OWN_TAUNTS"]),
                    width = "double",
                    get = function()
                        return GetDB().own.audio
                    end,
                    set = function(_, v)
                        GetDB().own.audio = v
                    end
                },
                ownSound = {
                    order = 27,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().own.sound
                    end,
                    set = function(_, v)
                        GetDB().own.sound = v
                    end
                },
                ownAoeAudio = {
                    order = 28,
                    type = "toggle",
                    name = string.format(L["AUDIO_AOE_TAUNTS"], L["TERM_OWN"]),
                    width = "double",
                    get = function()
                        return GetDB().own.aoeAudio
                    end,
                    set = function(_, v)
                        GetDB().own.aoeAudio = v
                    end
                },
                ownAoeSound = {
                    order = 29,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().own.aoeSound
                    end,
                    set = function(_, v)
                        GetDB().own.aoeSound = v
                    end
                },
                ownFailPrint = {
                    order = 30,
                    type = "toggle",
                    name = string.format(L["FAIL_PRINT_FMT"], L["TERM_OWN_TAUNT"]),
                    width = "double",
                    get = function()
                        return GetDB().own.failPrint
                    end,
                    set = function(_, v)
                        GetDB().own.failPrint = v
                    end
                },
                ownFailChannel = {
                    order = 31,
                    type = "select",
                    name = L["PRINT_TO"],
                    width = "normal",
                    values = outputChannels,
                    get = function()
                        return GetDB().own.failChannel
                    end,
                    set = function(_, v)
                        GetDB().own.failChannel = v
                    end
                },
                ownFailExample = {order = 31.5, type = "description", name = L["EXAMPLE_OWN_FAIL"]},
                ownFailAudio = {
                    order = 32,
                    type = "toggle",
                    name = string.format(L["FAIL_AUDIO_FMT"], L["TERM_OWN_TAUNT"]),
                    width = "double",
                    get = function()
                        return GetDB().own.failAudio
                    end,
                    set = function(_, v)
                        GetDB().own.failAudio = v
                    end
                },
                ownFailSound = {
                    order = 33,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().own.failSound
                    end,
                    set = function(_, v)
                        GetDB().own.failSound = v
                    end
                },
                groupHeader = {order = 40, type = "header", name = L["GROUP_TAUNTS"]},
                groupEnable = {
                    order = 41,
                    type = "toggle",
                    name = string.format(L["ENABLE_FOR_SECTION"], L["GROUP_TAUNTS"]),
                    width = "double",
                    get = function()
                        return GetDB().group.enable
                    end,
                    set = function(_, v)
                        GetDB().group.enable = v
                    end
                },
                groupRank = {
                    order = 42,
                    type = "select",
                    name = L["ENEMY_TYPE"],
                    width = "normal",
                    values = {[1] = L["BOSSES_ONLY"], [2] = L["ELITES_HIGHER"], [3] = L["ALL_TARGETS"]},
                    get = function()
                        return GetDB().group.rank
                    end,
                    set = function(_, v)
                        GetDB().group.rank = v
                    end
                },
                groupPrint = {
                    order = 43,
                    type = "toggle",
                    name = string.format(L["PRINT_ENABLE"], L["GROUP_TAUNTS"]),
                    width = "double",
                    get = function()
                        return GetDB().group.print
                    end,
                    set = function(_, v)
                        GetDB().group.print = v
                    end
                },
                groupChannel = {
                    order = 44,
                    type = "select",
                    name = L["PRINT_TO"],
                    width = "normal",
                    values = outputChannels,
                    get = function()
                        return GetDB().group.channel
                    end,
                    set = function(_, v)
                        GetDB().group.channel = v
                    end
                },
                groupExample = {order = 44.5, type = "description", name = L["EXAMPLE_GROUP_TAUNT"]},
                groupAudio = {
                    order = 45,
                    type = "toggle",
                    name = string.format(L["AUDIO_ENABLE"], L["GROUP_TAUNTS"]),
                    width = "double",
                    get = function()
                        return GetDB().group.audio
                    end,
                    set = function(_, v)
                        GetDB().group.audio = v
                    end
                },
                groupSound = {
                    order = 46,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().group.sound
                    end,
                    set = function(_, v)
                        GetDB().group.sound = v
                    end
                },
                groupAoeAudio = {
                    order = 47,
                    type = "toggle",
                    name = string.format(L["AUDIO_AOE_TAUNTS"], L["TERM_GROUP"]),
                    width = "double",
                    get = function()
                        return GetDB().group.aoeAudio
                    end,
                    set = function(_, v)
                        GetDB().group.aoeAudio = v
                    end
                },
                groupAoeSound = {
                    order = 48,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().group.aoeSound
                    end,
                    set = function(_, v)
                        GetDB().group.aoeSound = v
                    end
                },
                groupFailPrint = {
                    order = 49,
                    type = "toggle",
                    name = string.format(L["FAIL_PRINT_FMT"], L["TERM_GROUP_TAUNT"]),
                    width = "double",
                    get = function()
                        return GetDB().group.failPrint
                    end,
                    set = function(_, v)
                        GetDB().group.failPrint = v
                    end
                },
                groupFailChannel = {
                    order = 50,
                    type = "select",
                    name = L["PRINT_TO"],
                    width = "normal",
                    values = outputChannels,
                    get = function()
                        return GetDB().group.failChannel
                    end,
                    set = function(_, v)
                        GetDB().group.failChannel = v
                    end
                },
                groupFailExample = {order = 50.5, type = "description", name = L["EXAMPLE_GROUP_FAIL"]},
                groupFailAudio = {
                    order = 51,
                    type = "toggle",
                    name = string.format(L["FAIL_AUDIO_FMT"], L["TERM_GROUP_TAUNT"]),
                    width = "double",
                    get = function()
                        return GetDB().group.failAudio
                    end,
                    set = function(_, v)
                        GetDB().group.failAudio = v
                    end
                },
                groupFailSound = {
                    order = 52,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().group.failSound
                    end,
                    set = function(_, v)
                        GetDB().group.failSound = v
                    end
                },
                otherHeader = {order = 60, type = "header", name = L["OTHER_TAUNTS"]},
                otherEnable = {
                    order = 61,
                    type = "toggle",
                    name = string.format(L["ENABLE_FOR_SECTION"], L["OTHER_TAUNTS"]),
                    width = "double",
                    get = function()
                        return GetDB().other.enable
                    end,
                    set = function(_, v)
                        GetDB().other.enable = v
                    end
                },
                otherRank = {
                    order = 62,
                    type = "select",
                    name = L["ENEMY_TYPE"],
                    width = "normal",
                    values = {[1] = L["BOSSES_ONLY"], [2] = L["ELITES_HIGHER"], [3] = L["ALL_TARGETS"]},
                    get = function()
                        return GetDB().other.rank
                    end,
                    set = function(_, v)
                        GetDB().other.rank = v
                    end
                },
                otherPrint = {
                    order = 63,
                    type = "toggle",
                    name = string.format(L["PRINT_ENABLE"], L["OTHER_TAUNTS"]),
                    width = "double",
                    get = function()
                        return GetDB().other.print
                    end,
                    set = function(_, v)
                        GetDB().other.print = v
                    end
                },
                otherChannel = {
                    order = 64,
                    type = "select",
                    name = L["PRINT_TO"],
                    width = "normal",
                    values = outputChannels,
                    get = function()
                        return GetDB().other.channel
                    end,
                    set = function(_, v)
                        GetDB().other.channel = v
                    end
                },
                otherExample = {order = 64.5, type = "description", name = L["EXAMPLE_OTHER_TAUNT"]},
                otherAudio = {
                    order = 65,
                    type = "toggle",
                    name = string.format(L["AUDIO_ENABLE"], L["OTHER_TAUNTS"]),
                    width = "double",
                    get = function()
                        return GetDB().other.audio
                    end,
                    set = function(_, v)
                        GetDB().other.audio = v
                    end
                },
                otherSound = {
                    order = 66,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().other.sound
                    end,
                    set = function(_, v)
                        GetDB().other.sound = v
                    end
                },
                otherAoeAudio = {
                    order = 67,
                    type = "toggle",
                    name = string.format(L["AUDIO_AOE_TAUNTS"], L["TERM_OTHER"]),
                    width = "double",
                    get = function()
                        return GetDB().other.aoeAudio
                    end,
                    set = function(_, v)
                        GetDB().other.aoeAudio = v
                    end
                },
                otherAoeSound = {
                    order = 68,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().other.aoeSound
                    end,
                    set = function(_, v)
                        GetDB().other.aoeSound = v
                    end
                },
                otherFailPrint = {
                    order = 69,
                    type = "toggle",
                    name = string.format(L["FAIL_PRINT_FMT"], L["TERM_OTHER_TAUNT"]),
                    width = "double",
                    get = function()
                        return GetDB().other.failPrint
                    end,
                    set = function(_, v)
                        GetDB().other.failPrint = v
                    end
                },
                otherFailChannel = {
                    order = 70,
                    type = "select",
                    name = L["PRINT_TO"],
                    width = "normal",
                    values = outputChannels,
                    get = function()
                        return GetDB().other.failChannel
                    end,
                    set = function(_, v)
                        GetDB().other.failChannel = v
                    end
                },
                otherFailExample = {order = 70.5, type = "description", name = L["EXAMPLE_OTHER_FAIL"]},
                otherFailAudio = {
                    order = 71,
                    type = "toggle",
                    name = string.format(L["FAIL_AUDIO_FMT"], L["TERM_OTHER_TAUNT"]),
                    width = "double",
                    get = function()
                        return GetDB().other.failAudio
                    end,
                    set = function(_, v)
                        GetDB().other.failAudio = v
                    end
                },
                otherFailSound = {
                    order = 72,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().other.failSound
                    end,
                    set = function(_, v)
                        GetDB().other.failSound = v
                    end
                },
                fearsHeader = {order = 80, type = "header", name = L["FEARS"]},
                fearsEnable = {
                    order = 81,
                    type = "toggle",
                    name = string.format(L["ENABLE_FOR_SECTION"], L["FEARS"]),
                    width = "double",
                    get = function()
                        return GetDB().fears.enable
                    end,
                    set = function(_, v)
                        GetDB().fears.enable = v
                    end
                },
                fearsPrint = {
                    order = 82,
                    type = "toggle",
                    name = string.format(L["PRINT_ENABLE"], L["FEARS"]),
                    width = "double",
                    get = function()
                        return GetDB().fears.print
                    end,
                    set = function(_, v)
                        GetDB().fears.print = v
                    end
                },
                fearsChannel = {
                    order = 83,
                    type = "select",
                    name = L["PRINT_TO"],
                    width = "normal",
                    values = outputChannels,
                    get = function()
                        return GetDB().fears.channel
                    end,
                    set = function(_, v)
                        GetDB().fears.channel = v
                    end
                },
                fearsExample = {order = 83.5, type = "description", name = L["EXAMPLE_FEARS"]},
                fearsAudio = {
                    order = 84,
                    type = "toggle",
                    name = string.format(L["AUDIO_ENABLE"], L["FEARS"]),
                    width = "double",
                    get = function()
                        return GetDB().fears.audio
                    end,
                    set = function(_, v)
                        GetDB().fears.audio = v
                    end
                },
                fearsSound = {
                    order = 85,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().fears.sound
                    end,
                    set = function(_, v)
                        GetDB().fears.sound = v
                    end
                },
                annoyHeader = {order = 90, type = "header", name = L["ANNOYANCES"]},
                annoyNote = {
                    order = 90.5,
                    type = "description",
                    width = "full",
                    name = "|cffCCCCCCNote: Only in-party players are tracked.|r"
                },
                annoyEnable = {
                    order = 91,
                    type = "toggle",
                    name = string.format(L["ENABLE_FOR_SECTION"], L["ANNOYANCES"]),
                    width = "full",
                    get = function()
                        return GetDB().annoyances.enable
                    end,
                    set = function(_, v)
                        GetDB().annoyances.enable = v
                    end
                },
                annoyPrint = {
                    order = 93,
                    type = "toggle",
                    name = string.format(L["PRINT_ENABLE"], L["ANNOYANCES"]),
                    width = "double",
                    get = function()
                        return GetDB().annoyances.print
                    end,
                    set = function(_, v)
                        GetDB().annoyances.print = v
                    end
                },
                annoyChannel = {
                    order = 94,
                    type = "select",
                    name = L["PRINT_TO"],
                    width = "normal",
                    values = outputChannels,
                    get = function()
                        return GetDB().annoyances.channel
                    end,
                    set = function(_, v)
                        GetDB().annoyances.channel = v
                    end
                },
                annoyExample = {order = 94.5, type = "description", name = L["EXAMPLE_ANNOYANCE"]},
                annoyAudio = {
                    order = 95,
                    type = "toggle",
                    name = string.format(L["AUDIO_ENABLE"], L["ANNOYANCES"]),
                    width = "double",
                    get = function()
                        return GetDB().annoyances.audio
                    end,
                    set = function(_, v)
                        GetDB().annoyances.audio = v
                    end
                },
                annoySound = {
                    order = 96,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().annoyances.sound
                    end,
                    set = function(_, v)
                        GetDB().annoyances.sound = v
                    end
                },
                petsHeader = {order = 100, type = "header", name = L["PETS"]},
                petsNote = {
                    order = 100.5,
                    type = "description",
                    width = "full",
                    name = "|cffCCCCCCNote: Only in-party Pets are ever tracked.|r"
                },
                petsEnable = {
                    order = 101,
                    type = "toggle",
                    name = string.format(L["ENABLE_FOR_SECTION"], L["PETS"]),
                    width = "double",
                    get = function()
                        return GetDB().pets.enable
                    end,
                    set = function(_, v)
                        GetDB().pets.enable = v
                    end
                },
                petsRank = {
                    order = 102,
                    type = "select",
                    name = L["ENEMY_TYPE"],
                    width = "normal",
                    values = {[1] = L["BOSSES_ONLY"], [2] = L["ELITES_HIGHER"], [3] = L["ALL_TARGETS"]},
                    get = function()
                        return GetDB().pets.rank
                    end,
                    set = function(_, v)
                        GetDB().pets.rank = v
                    end
                },
                petsPrint = {
                    order = 103,
                    type = "toggle",
                    name = string.format(L["PRINT_ENABLE"], L["PETS"]),
                    width = "double",
                    get = function()
                        return GetDB().pets.print
                    end,
                    set = function(_, v)
                        GetDB().pets.print = v
                    end
                },
                petsChannel = {
                    order = 104,
                    type = "select",
                    name = L["PRINT_TO"],
                    width = "normal",
                    values = outputChannels,
                    get = function()
                        return GetDB().pets.channel
                    end,
                    set = function(_, v)
                        GetDB().pets.channel = v
                    end
                },
                petsExample = {order = 104.5, type = "description", name = L["EXAMPLE_PETS"]},
                petsAudio = {
                    order = 105,
                    type = "toggle",
                    name = string.format(L["AUDIO_ENABLE"], L["PETS"]),
                    width = "double",
                    get = function()
                        return GetDB().pets.audio
                    end,
                    set = function(_, v)
                        GetDB().pets.audio = v
                    end
                },
                petsSound = {
                    order = 106,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().pets.sound
                    end,
                    set = function(_, v)
                        GetDB().pets.sound = v
                    end
                },
                badPetEnable = {
                    order = 107,
                    type = "toggle",
                    name = L["BAD_PET_ENABLE"],
                    desc = L["BAD_PET_DESC"],
                    width = "double",
                    get = function()
                        return GetDB().pets.badPetEnable
                    end,
                    set = function(_, v)
                        GetDB().pets.badPetEnable = v
                    end
                },
                badPetFreq = {
                    order = 108,
                    type = "select",
                    name = L["BAD_PET_FREQ"],
                    width = "normal",
                    values = {
                        ["INSTANCE"] = L["FREQ_INSTANCE"],
                        ["BOSS"] = L["FREQ_BOSS"],
                        ["ALWAYS"] = L["FREQ_ALWAYS"]
                    },
                    get = function()
                        return GetDB().pets.badPetFreq
                    end,
                    set = function(_, v)
                        GetDB().pets.badPetFreq = v
                    end
                },
                badPetDesc = {
                    order = 109,
                    type = "description",
                    name = L["BAD_PET_DESC"],
                    fontSize = "small"
                },
                badPetSpacer = {
                    order = 109.2,
                    type = "description",
                    name = " "
                },
                badPetExample = {
                    order = 109.5,
                    type = "description",
                    name = L["EXAMPLE_BAD_PET"]
                },
                itemsHeader = {order = 110, type = "header", name = L["ITEMS"]},
                itemsNote = {
                    order = 110.5,
                    type = "description",
                    width = "full",
                    name = "|cffCCCCCCNote: Only in-party players are tracked.|r"
                },
                itemsEnable = {
                    order = 111,
                    type = "toggle",
                    name = string.format(L["ENABLE_FOR_SECTION"], L["ITEMS"]),
                    width = "full",
                    get = function()
                        return GetDB().items.enable
                    end,
                    set = function(_, v)
                        GetDB().items.enable = v
                    end
                },
                itemsPrint = {
                    order = 112,
                    type = "toggle",
                    name = string.format(L["PRINT_ENABLE"], L["ITEMS"]),
                    width = "double",
                    get = function()
                        return GetDB().items.print
                    end,
                    set = function(_, v)
                        GetDB().items.print = v
                    end
                },
                itemsChannel = {
                    order = 113,
                    type = "select",
                    name = L["PRINT_TO"],
                    width = "normal",
                    values = outputChannels,
                    get = function()
                        return GetDB().items.channel
                    end,
                    set = function(_, v)
                        GetDB().items.channel = v
                    end
                },
                itemsExample = {order = 113.5, type = "description", name = L["EXAMPLE_ITEMS"]},
                itemsAudio = {
                    order = 114,
                    type = "toggle",
                    name = string.format(L["AUDIO_ENABLE"], L["ITEMS"]),
                    width = "double",
                    get = function()
                        return GetDB().items.audio
                    end,
                    set = function(_, v)
                        GetDB().items.audio = v
                    end
                },
                itemsSound = {
                    order = 115,
                    type = "select",
                    dialogControl = "LSM30_Sound",
                    name = L["SOUND"],
                    width = "normal",
                    values = AceGUIWidgetLSMlists.sound,
                    get = function()
                        return GetDB().items.sound
                    end,
                    set = function(_, v)
                        GetDB().items.sound = v
                    end
                }
            }
        },
        spells = {
            name = "Spells & Items",
            type = "group",
            order = 3,
            args = {
                intro = {order = 0, type = "description", name = "Uncheck spells to ignore them."},
                druid = {
                    name = "|cffFF7D0ADruid|r",
                    type = "group",
                    order = 1,
                    inline = false,
                    args = {
                        h1 = {type = "header", name = "Single Target Taunts", order = 1},
                        growl = DefineSpellToggle("Growl", "Growl", {6795}, 2),
                        h2 = {type = "header", name = "AOE Taunts", order = 10},
                        roar = DefineSpellToggle("Challenging Roar", "Challenging Roar", {5209}, 11)
                    }
                },
                hunter = {
                    name = "|cffABD473Hunter|r",
                    type = "group",
                    order = 2,
                    inline = false,
                    args = {
                        h1 = {type = "header", name = "Single Target Taunts", order = 1},
                        distracting = DefineSpellToggle(
                            "Distracting Shot",
                            "Distracting Shot (All Ranks)",
                            {20736, 14274, 15629, 15630, 15631, 15632},
                            2
                        ),
                        h2 = {type = "header", name = "Fears", order = 10},
                        scare = DefineSpellToggle("Scare Beast", "Scare Beast (All Ranks)", {1513, 14326, 14327}, 11)
                    }
                },
                mage = {
                    name = "|cff40C7EBMage|r",
                    type = "group",
                    order = 3,
                    inline = false,
                    args = {
                        h1 = {type = "header", name = "Annoyances", order = 1},
                        frostnova = DefineSpellToggle(
                            "Frost Nova",
                            "Frost Nova (All Ranks)",
                            {122, 865, 6131, 10230},
                            2
                        )
                    }
                },
                paladin = {
                    name = "|cffF58CBAPaladin|r",
                    type = "group",
                    order = 4,
                    inline = false,
                    args = {
                        h1 = {type = "header", name = "Fears", order = 1},
                        turn = DefineSpellToggle("Turn Undead", "Turn Undead (All Ranks)", {2812, 10308}, 2)
                    }
                },
                priest = {
                    name = "|cffFFFFFFPriest|r",
                    type = "group",
                    order = 5,
                    inline = false,
                    args = {
                        h1 = {type = "header", name = "Fears", order = 1},
                        scream = DefineSpellToggle(
                            "Psychic Scream",
                            "Psychic Scream (All Ranks)",
                            {8122, 8124, 10888, 10890},
                            2
                        )
                    }
                },
                shaman = {
                    name = "|cff0070DEShaman|r",
                    type = "group",
                    order = 6,
                    inline = false,
                    args = {
                        h1 = {type = "header", name = "AOE Taunts", order = 1},
                        stoneclaw = DefineSpellToggle(
                            "Stoneclaw Totem",
                            "Stoneclaw Totem (All Ranks)",
                            {5730, 5854, 5928, 8198, 10406, 10407},
                            2
                        )
                    }
                },
                warlock = {
                    name = "|cff9482C9Warlock|r",
                    type = "group",
                    order = 7,
                    inline = false,
                    args = {
                        h1 = {type = "header", name = "Fears", order = 1},
                        coil = DefineSpellToggle("Death Coil", "Death Coil (All Ranks)", {6789, 17925, 17926}, 2),
                        fear = DefineSpellToggle("Fear", "Fear (All Ranks)", {5782, 6213, 6215}, 3),
                        howl = DefineSpellToggle("Howl of Terror", "Howl of Terror (All Ranks)", {5484, 17928}, 4)
                    }
                },
                warrior = {
                    name = "|cffC79C6EWarrior|r",
                    type = "group",
                    order = 8,
                    inline = false,
                    args = {
                        h1 = {type = "header", name = "Single Target Taunts", order = 1},
                        mocking = DefineSpellToggle(
                            "Mocking Blow",
                            "Mocking Blow (All Ranks)",
                            {694, 7400, 7402, 20559, 20560},
                            2
                        ),
                        taunt = DefineSpellToggle("Taunt", "Taunt (All Ranks)", {355}, 3),
                        h2 = {type = "header", name = "AOE Taunts", order = 10},
                        challenging = DefineSpellToggle("Challenging Shout", "Challenging Shout", {1161}, 11),
                        h3 = {type = "header", name = "Fears", order = 20},
                        intimidating = DefineSpellToggle("Intimidating Shout", "Intimidating Shout", {5246}, 21)
                    }
                },
                pets = {
                    name = "|cff999999Pets|r",
                    type = "group",
                    order = 9,
                    inline = false,
                    args = {
                        h1 = {type = "header", name = "Pet Abilities", order = 1},
                        growl = DefineSpellToggle(
                            "Growl (Hunter Pet)",
                            "Growl (All Ranks)",
                            {2649, 14916, 14917, 14918, 14919, 14920, 14921},
                            2
                        ),
                        suffering = DefineSpellToggle(
                            "Suffering (Voidwalker)",
                            "Suffering (All Ranks)",
                            {17735, 17750, 17751, 17752},
                            3
                        ),
                        torment = DefineSpellToggle(
                            "Torment (Voidwalker)",
                            "Torment (All Ranks)",
                            {3716, 7809, 7810, 11774, 11775, 11776},
                            4
                        )
                    }
                },
                items = {
                    name = "|cff999999Items|r",
                    type = "group",
                    order = 10,
                    inline = false,
                    args = {
                        h1 = {type = "header", name = "Engineering", order = 1},
                        advDummy = DefineSpellToggle("Advanced Target Dummy", "Advanced Target Dummy", {4068}, 2),
                        flash = DefineSpellToggle("Flash Bomb", "Flash Bomb", {5134}, 3),
                        mastDummy = DefineSpellToggle("Masterwork Target Dummy", "Masterwork Target Dummy", {23455}, 4),
                        dummy = DefineSpellToggle("Target Dummy", "Target Dummy", {4054}, 5)
                    }
                }
            }
        },
        feedback = {
            name = "Feedback",
            type = "group",
            order = 4,
            args = {
                header = {type = "header", name = "Feedback & Support", order = 1},
                desc = {
                    type = "description",
                    fontSize = "medium",
                    name = " ",
                    order = 2
                },
                desc = {
                    type = "description",
                    fontSize = "medium",
                    name = "Have a suggestion or found a bug? Join the Discord or check out the GitHub.",
                    order = 3
                },
                desc = {
                    type = "description",
                    fontSize = "medium",
                    name = " ",
                    order = 4
                },
                discord = {
                    type = "input",
                    name = "Discord",
                    width = "full",
                    order = 11,
                    get = function()
                        return "https://discord.gg/eh8hKq992Q"
                    end,
                    set = function()
                    end
                },
                github = {
                    type = "input",
                    name = "GitHub",
                    width = "full",
                    order = 12,
                    get = function()
                        return "https://github.com/gogo1951/ControlFreak"
                    end,
                    set = function()
                    end
                },
                headerInspo = {type = "header", name = "Inspiration & Credits", order = 20},
                lblWhoTaunted = {
                    type = "description",
                    name = "|cffffd700Who Taunted?|r (Davie3)",
                    order = 21,
                    fontSize = "medium"
                },
                linkWhoTauntedCF = {
                    type = "input",
                    name = "CurseForge",
                    width = "full",
                    order = 22,
                    get = function()
                        return "https://www.curseforge.com/wow/addons/who-taunted"
                    end,
                    set = function()
                    end
                },
                linkWhoTauntedGH = {
                    type = "input",
                    name = "GitHub",
                    width = "full",
                    order = 23,
                    get = function()
                        return "https://github.com/Davie3/who-taunted"
                    end,
                    set = function()
                    end
                },
                lblSTA = {
                    type = "description",
                    name = "\n|cffffd700Simple Taunt Announce|r (BeathsCurse)",
                    order = 24,
                    fontSize = "medium"
                },
                linkSTACF = {
                    type = "input",
                    name = "CurseForge",
                    width = "full",
                    order = 25,
                    get = function()
                        return "https://www.curseforge.com/wow/addons/sta"
                    end,
                    set = function()
                    end
                },
                lblBadPet = {
                    type = "description",
                    name = "\n|cffffd700Bad Pet|r (sfnelson)",
                    order = 26,
                    fontSize = "medium"
                },
                linkBadPetCF = {
                    type = "input",
                    name = "CurseForge",
                    width = "full",
                    order = 27,
                    get = function()
                        return "https://www.curseforge.com/wow/addons/badpet"
                    end,
                    set = function()
                    end
                },
                linkBadPetGH = {
                    type = "input",
                    name = "GitHub",
                    width = "full",
                    order = 28,
                    get = function()
                        return "https://github.com/sfnelson/badpet"
                    end,
                    set = function()
                    end
                },
                lblTF = {
                    type = "description",
                    name = "\n|cffffd700Taunts & Fears WA|r",
                    order = 29,
                    fontSize = "medium"
                },
                linkTFWago = {
                    type = "input",
                    name = "Wago.io",
                    width = "full",
                    order = 30,
                    get = function()
                        return "https://wago.io/3cGT5x2OW"
                    end,
                    set = function()
                    end
                }
            }
        }
    }
}

function ControlFreak:SetupOptions()
    local ACD = LibStub("AceConfigDialog-3.0")

    LibStub("AceConfig-3.0"):RegisterOptionsTable("ControlFreak", options)
    local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(ControlFreak.db)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("ControlFreakProfiles", profiles)

    ACD:AddToBlizOptions("ControlFreak", "Control Freak", nil, "home")

    ACD:AddToBlizOptions("ControlFreak", "Settings", "Control Freak", "main_settings")

    ACD:AddToBlizOptions("ControlFreak", "Spells & Items", "Control Freak", "spells")

    ACD:AddToBlizOptions("ControlFreakProfiles", "Profiles", "Control Freak")

    ACD:AddToBlizOptions("ControlFreak", "Feedback", "Control Freak", "feedback")
end
