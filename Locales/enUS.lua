local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "enUS", true)

if not L then
    return
end

-- Branding
L["BRAND_SUFFIX"] = " // Control Freak"

-- Prefixes
L["PREFIX_TAUNT"] = "Taunt!"
L["PREFIX_TAUNT_AOE"] = "AOE Taunt!"
L["PREFIX_TAUNT_FAIL"] = "Taunt Failed!"
L["PREFIX_FEAR"] = "Fear!"
L["PREFIX_PET"] = "Bad Pet!"
L["PREFIX_ANNOYANCE"] = "Annoyance!"

-- Actions
L["ACTION_USED"] = "used"
L["ACTION_RESISTED"] = "resisted"
L["ACTION_IMMUNE"] = "is immune to"
L["ACTION_MISSED"] = "missed"

-- Formats
L["FMT_SUCCESS_TARGET"] = "|cff%1$s%2$s %3$s %4$s |r%5$s|cff%1$s on |r%6$s|cff%1$s%7$s%8$s|r"
L["FMT_SUCCESS_NO_TARGET"] = "|cff%1$s%2$s %3$s %4$s |r%5$s|cff%1$s%8$s|r"
L["FMT_FAIL"] = "|cff%1$s%2$s |r%3$s|cff%1$s%4$s %5$s %6$s's |r%7$s|cff%1$s%8$s|r"
L["CLEAN_SUCCESS_TARGET"] = "%s %s %s %s on %s%s%s"
L["CLEAN_SUCCESS_NO_TARGET"] = "%s %s %s %s%s"
L["CLEAN_FAIL"] = "%s %s%s %s %s's %s%s"

-- Bad Pet Whisper
L["BAD_PET_WHISPER"] =
    "FYI // %s used %s on %s. You can right-click the ability on your action bar or inside your spell book to disable auto-cast."

-- General UI
L["TAGLINE"] = "|cffeda55fAn add-on for Tanks and Tank wanna-bes.|r\n"
L["ENABLE"] = "Enable"
L["ENABLE_DESC"] = "Master switch for the addon."
L["GENERAL_SETTINGS"] = "General Settings"
L["GROUP_SETTINGS"] = "Group Settings"
L["ZONE_SETTINGS"] = "Zone Settings"

L["SOLO_ENABLE"] = "Enable when Not In Group"
L["SOLO_DESC"] = "Enable when playing solo (not in a party or raid)."
L["PARTY_ENABLE"] = "Enable when in Party"
L["PARTY_DESC"] = "Enable when in a 5-man party."
L["RAID_ENABLE"] = "Enable when in Raid"
L["RAID_DESC"] = "Enable when in a Raid group."

L["OPEN_WORLD_ENABLE"] = "Enable in Open World"
L["OPEN_WORLD_DESC"] = "Enable when in the outdoor world (not inside an instance)."
L["INSTANCE_ENABLE"] = "Enable in Instances"
L["INSTANCE_DESC"] = "Enable while in a dungeon or raid instance."
L["BG_ENABLE"] = "Enable in Battlegrounds"
L["BG_DESC"] = "Enable when in a player vs player Battleground."
L["ARENA_ENABLE"] = "Enable in Arenas"
L["ARENA_DESC"] = "Enable when in a player vs player Arena."

-- Categories (Full Titles)
L["OWN_TAUNTS"] = "Own Taunts"
L["GROUP_TAUNTS"] = "Group Member Taunts"
L["OTHER_TAUNTS"] = "Other Taunts"
L["PETS"] = "Pets"
L["ITEMS"] = "Items"
L["FEARS"] = "Fears"
L["ANNOYANCES"] = "Annoyances"

-- Grammar Helpers
L["TERM_OWN"] = "Own"
L["TERM_GROUP"] = "Group Member"
L["TERM_OTHER"] = "Other"
L["TERM_OWN_TAUNT"] = "Own Taunt"
L["TERM_GROUP_TAUNT"] = "Group Member Taunt"
L["TERM_OTHER_TAUNT"] = "Other Taunt"

-- Common Settings Formats
L["ENABLE_FOR_SECTION"] = "Enable for %s"
L["ENEMY_TYPE"] = "Enemy Type"
L["PRINT_ENABLE"] = "Enable Print Out for %s"
L["PRINT_TO"] = "Print To"
L["AUDIO_ENABLE"] = "Enable Audio for %s"

-- Specific Grammatical Formats
L["AUDIO_AOE_TAUNTS"] = "Enable Audio for %s AOE Taunts"
L["FAIL_PRINT_FMT"] = "Enable Print Out for %s Fails"
L["FAIL_AUDIO_FMT"] = "Enable Audio for %s Fails"
L["SOUND"] = "Sound"

-- Bad Pet Settings
L["BAD_PET_ENABLE"] = 'Enable "Bad Pet" Messages'
L["BAD_PET_DESC"] =
    "When enabled, you'll send a whisper to the offending Pet's Owner whenever you receive a notification."
L["BAD_PET_FREQ"] = "Frequency"
L["FREQ_INSTANCE"] = "Once per Instance"
L["FREQ_BOSS"] = "Once per Boss"
L["FREQ_ALWAYS"] = "Every Time"

-- Dropdowns
L["BOSSES_ONLY"] = "Bosses Only"
L["ELITES_HIGHER"] = "Elites and Higher"
L["ALL_TARGETS"] = "All Targets"
L["CHANNEL_SELF"] = "Self (Local)"
L["CHANNEL_GROUP"] = "Group (Smart)"

-- Examples
L["EXAMPLE_OWN_TAUNT"] =
    "|cffC79C6E Taunt! Gogowarrior-Mal'ganis used |r|cff71d5ff[Taunt]|r|cffC79C6E on Prince Malchezaar // Control Freak|r"
L["EXAMPLE_OWN_FAIL"] =
    "|cffC79C6E Taunt Failed! Moroes resisted Gogowarrior-Mal'ganis's |r|cff71d5ff[Mocking Blow]|r|cffC79C6E // Control Freak|r"
L["EXAMPLE_GROUP_TAUNT"] =
    "|cffFF7D0A Taunt! Gogodruid-Mal'ganis used |r|cff71d5ff[Growl]|r|cffFF7D0A on The Curator // Control Freak|r"
L["EXAMPLE_GROUP_FAIL"] =
    "|cffF58CBA Taunt Failed! Attumen the Huntsman is immune to Gogopaladin-Mal'ganis's |r|cff71d5ff[Righteous Defense]|r|cffF58CBA // Control Freak|r"
L["EXAMPLE_OTHER_TAUNT"] =
    "|cffC79C6E Taunt! Gogowarrior-Mal'ganis used |r|cff71d5ff[Mocking Blow]|r|cffC79C6E on Midnight // Control Freak|r"
L["EXAMPLE_OTHER_FAIL"] =
    "|cffC79C6E Taunt Failed! Prince Malchezaar resisted Gogowarrior-Mal'ganis's |r|cff71d5ff[Challenging Shout]|r|cffC79C6E // Control Freak|r"
L["EXAMPLE_PETS"] =
    "|cffABD473 Bad Pet! Gogocat (Gogohunter) used |r|cff71d5ff[Growl]|r|cffABD473 on Big Bad Wolf // Control Freak|r"
L["EXAMPLE_FEARS"] =
    "|cff9482C9 Fear! Gogowarlock-Mal'ganis used |r|cff71d5ff[Howl of Terror]|r|cff9482C9 // Control Freak|r"
L["EXAMPLE_ANNOYANCE"] =
    "|cff40C7EB Annoyance! Gogomage-Mal'ganis used |r|cff71d5ff[Frost Nova]|r|cff40C7EB // Control Freak|r"
L["EXAMPLE_ITEMS"] =
    "|cffFFF569 AOE Taunt! Gogorogue-Mal'ganis used |r|cff71d5ff[Advanced Target Dummy]|r|cffFFF569 // Control Freak|r"
L["EXAMPLE_BAD_PET"] =
    '|cffff80ffWhisper to Gogohunter-Mal\'ganis: "FYI // Gogocat, used [Growl] on Magtheridon. You can right-click the ability on your action bar or inside your spell book to disable auto-cast."|r'
