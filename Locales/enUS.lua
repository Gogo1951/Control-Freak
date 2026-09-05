local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "enUS", true)
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"Taunt tracking that tells you who taunted, whose taunt was resisted, and whose pet is growling, plus interrupt, fear, parry, and armor debuff callouts from the combat log. Better information = better tanking. Better tanking = better raids."
L["VERSION"] = "Version"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Version %s. Settings (including the option to disable this message) can be found under Options > AddOns > Control Freak. Enjoying the add-on? Tell a friend about it! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "As a safety precaution, the Options Interface cannot be opened during combat."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Enable Welcome Message"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Show the Control Freak greeting when you log in."
L["ENABLE_MINIMAP_BUTTON"] = "Enable Mini-map Button"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Show the Control Freak button on your mini-map."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Opens the Options Interface for this add-on."

-- The master switch. Its description is shared with the mini-map button's own
-- line for the same toggle, so the two cannot describe it differently.
L["KILL_SWITCH"] = "Kill Switch"
L["KILL_SWITCH_ENABLE"] = "Enable Control Freak"
L["KILL_SWITCH_ENABLE_DESC"] = "Turn every Control Freak alert on or off."

L["FEEDBACK_HEADER"] = "Feedback & Support"
L["FEEDBACK_DISCORD"] = "Discord"
L["FEEDBACK_GITHUB"] = "GitHub"
L["FEEDBACK_CURSEFORGE"] = "CurseForge"
L["FEEDBACK_WAGO"] = "Wago"

--------------------------------------------------------------------------------
-- Mini-map Button
--------------------------------------------------------------------------------

L["STATE_ON"] = "On"
L["STATE_OFF"] = "Off"
L["LEFT_CLICK"] = "Left-Click"
L["RIGHT_CLICK"] = "Right-Click"
L["SHIFT_MIDDLE_CLICK"] = "Shift + Middle-Click"
L["ACTION_TOGGLE"] = "Toggle"
L["MINIMAP_OPTIONS"] = "Control Freak Options"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

L["TAB_TAUNTS"] = "Taunts"
L["TAB_INTERRUPTS"] = "Interrupts"
L["TAB_FEARS"] = "Fears"
L["TAB_BAD_PET"] = "Bad Pet"
L["TAB_TANKING_TOOLS"] = "Tanking Tools"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Turn this feature on or off."
L["SCOPE_TANK_ROLE_ONLY"] = "Only When Playing a Tank"
L["SCOPE_TANK_ROLE_ONLY_DESC"] =
	"Fire only while you are tanking, either as the raid's Main Tank or with the group finder's Tank role selected. With neither set, this feature stays quiet."
L["SCOPE_GROUP_HAS_TANK"] = "Only When Group Has a Tank"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Fire only while someone in your group is tanking and still alive. A tank who is down counts as no tank, because that is when somebody else holding threat is helping."
L["SCOPE_INSTANCE_ONLY"] = "Only While in Instances"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Fire only inside dungeons and raids."

--------------------------------------------------------------------------------
-- Alert Sections
--------------------------------------------------------------------------------

--[[
    Every alert on every tab is drawn as the same block, so each one owns three
    strings: a HEADER naming the thing that happened, an ENABLE reading "Enable
    <that thing> Notifications" -- the switch turns the telling on, not the event
    -- and a DESC of one or two sentences. ns.AddAlertSection in
    Options-Utilities.lua is where that shape lives.

    TRANSLATORS: the two SCOPE_DESC tooltips below quote the dropdown's own
    choices by name. Those quoted words must match your translations of
    ALERT_SCOPE_MINE and ALERT_SCOPE_ALL, or the tooltip explains options the
    player cannot find in the list.
]]
L["ALERT_SECTION_ENABLE_DESC"] = "Turn this alert on or off."
L["ALERT_PRINT"] = "Print Out Notifications"
L["ALERT_PRINT_DESC"] = "Print this alert to your own chat window."
L["ALERT_PRINT_SCOPE_DESC"] =
	"Whose casts reach your own window. Mine covers you and your own pet; All covers everybody in your group. The sound follows this too, so you never hear an alert you cannot see."
L["ALERT_ANNOUNCE"] = "Announce to Group"
L["ALERT_ANNOUNCE_DESC"] =
	"Send this alert to your party or raid chat. Narrating other people to the whole raid is how an add-on wears out its welcome, so this one is worth a thought before you turn it on."
L["ALERT_ANNOUNCE_SCOPE_DESC"] =
	"Whose casts go to party or raid chat. Mine covers you and your own pet; All covers everybody in your group, yourself included."
L["ALERT_SCOPE_MINE"] = "Mine"
L["ALERT_SCOPE_ALL"] = "All"
L["ALERT_BOSS_ONLY"] = "Only Against Bosses & Elites"
L["ALERT_BOSS_ONLY_DESC"] =
	"Fire only against enemies worth the attention: raid bosses, dungeon bosses, and any elite above your own level."
L["ALERT_SOUND"] = "Sound"
L["ALERT_SOUND_DESC"] = "Play a sound when this alert fires."
L["ALERT_SOUND_FILE_DESC"] = "Pick the sound this alert plays. Choosing one plays it."
L["ALERT_SOUND_PREVIEW_DESC"] = "Play this sound now, whether or not the sound is turned on."
L["SOUND_NONE"] = "None"

-- The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
-- list of seconds. Whole minutes read as minutes, and zero reads as "No
-- Cooldown" rather than "0 Second Cooldown".
L["COOLDOWN_NONE"] = "No Cooldown"
L["COOLDOWN_SECONDS"] = "%d Second Cooldown"
L["COOLDOWN_MINUTES"] = "%d Minute Cooldown"

--------------------------------------------------------------------------------
-- Sample Lines
--------------------------------------------------------------------------------

--[[
    The "Example:" line under a block is NOT written here. It is rendered from the
    real message format below with these stand-in names, so a reworded alert
    cannot leave a hand-copied example quoting the old text. The names are
    translatable because they sit inside a sentence whose grammar a locale may
    want to agree with.
]]
L["SAMPLE_EXAMPLE"] = "Example: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "Joe"
L["SAMPLE_PET"] = "Snuffles"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "Items"
L["ABILITIES_CLASS_PET"] = "%s Pet"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] = "Taunts are abilities that take threat from whoever currently has it."
L["TAUNTS_ENABLE"] = "Enable Taunt Monitoring"

L["TAUNTS_SUCCESS_HEADER"] = "Successful Taunts"
L["TAUNTS_SUCCESS_ENABLE"] = "Enable Successful Taunt Notifications"
L["TAUNTS_SUCCESS_DESC"] =
	"A taunt that landed and took the mob off somebody else. A taunt on a mob already hitting the taunter is a threat refresh rather than a save, so those stay quiet."
L["TAUNTS_FAILED_HEADER"] = "Failed Taunts"
L["TAUNTS_FAILED_ENABLE"] = "Enable Failed Taunt Notifications"
L["TAUNTS_FAILED_DESC"] =
	"A taunt that missed, was resisted, or hit something immune. The mob did not change hands, and nothing on screen says so."
L["TAUNTS_AOE_HEADER"] = "AOE Taunts"
L["TAUNTS_AOE_ENABLE"] = "Enable AOE Taunt Notifications"
L["TAUNTS_AOE_DESC"] = "A taunt that grabs everything around it at once, rather than one target."

L["TAUNTS_ABILITIES_HEADER"] = "Taunt Abilities"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "AOE Taunt Abilities"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "Interrupts stop an enemy spell partway through its cast."
L["INTERRUPTS_ENABLE"] = "Enable Interrupt Monitoring"

L["INTERRUPTS_ALERT_HEADER"] = "Successful Interrupts"
L["INTERRUPTS_ALERT_ENABLE"] = "Enable Successful Interrupt Notifications"
L["INTERRUPTS_ALERT_DESC"] = "A cast stopped partway through. Names who stopped it and what they stopped."

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Fears send enemies running and scatter a pull across the room."
L["FEARS_ENABLE"] = "Enable Fear Monitoring"

L["FEARS_ALERT_HEADER"] = "Fears"
L["FEARS_ALERT_ENABLE"] = "Enable Fear Notifications"
L["FEARS_ALERT_DESC"] =
	"A fear that landed and scattered the pull out of the tank's reach. Only the landing counts: a bare cast, a resist and an immune all moved nothing, so none of them are reported."

L["FEARS_ABILITIES_HEADER"] = "Fear Abilities"

--------------------------------------------------------------------------------
-- Bad Pet
--------------------------------------------------------------------------------

-- The summary doubles as the mini-map button's Bad Pet line, so the tab and the
-- tooltip cannot describe the feature differently.
L["BAD_PET_SUMMARY"] = "Hunter and warlock pets with auto-cast threat abilities left on."
L["BAD_PET_ENABLE"] = "Enable Bad Pet Monitoring"

L["BAD_PET_ALERT_HEADER"] = "Pet Taunts"
L["BAD_PET_ALERT_ENABLE"] = "Enable Pet Taunt Notifications"
L["BAD_PET_ALERT_DESC"] =
	"A pet pulling the mob off the tank with auto-cast left on, usually without its owner noticing."
L["BAD_PET_WHISPER_ENABLE"] = "Whisper Owner"
L["BAD_PET_WHISPER_ENABLE_DESC"] =
	"Send the pet's owner a note explaining how to turn off auto-cast. Only one is sent even when several people in your group run Control Freak."
L["BAD_PET_COOLDOWN_DESC"] =
	"How long one pet stays quiet after it sets off an alert. It covers the print, the sound, the announce and the whisper, so a pet with auto-cast left on cannot fill your window, and its owner is not whispered again every few seconds."

L["BAD_PET_ABILITIES_HEADER"] = "Bad Pet Abilities"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

-- No summary line: the Tanking Tools tab opens on its enable, because the tab is
-- a collection of unrelated warnings rather than one idea a sentence can cover.
-- Each section introduces itself instead.
L["TANKING_TOOLS_ENABLE"] = "Enable Tanking Tools"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Cold Openers"
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Enable Cold Opener Notifications"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Call out your own opening attacks that failed to land: a miss, a dodge, a parry, a block, a resist, or an immunity in the first seconds of a pull. Threat that never happened, at the moment it matters most."
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"How long into a pull an avoided ability still counts. The clock starts the first time Control Freak sees that mob, and only abilities count: an auto-attack whiffs too often to be news."
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d Seconds of Fight"

L["TANKING_TOOLS_ARMOR_HEADER"] = "Armor Debuffs"
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Enable Armor Debuff Notifications"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Report how long the group took to strip a target's armor: five Sunders or a rogue's Expose Armor. Turn on an extra below and it waits for that too, but only when somebody in the group can actually cast it."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Include Faerie Fire"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Wait for Faerie Fire before reporting, whichever form the druid casts. Ignored when there is no druid in the group."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Include Curse of Recklessness"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Wait for Curse of Recklessness before reporting. Ignored when there is no warlock in the group."

L["TANKING_TOOLS_PARRY_HEADER"] = "Parries"
L["TANKING_TOOLS_PARRY_ENABLE"] = "Enable Parry Notifications"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Someone parried by a mob they are not tanking is standing in front of it. Every parry speeds up that mob's next swing at whoever is holding it."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Whisper Culprit"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Send the culprit a note asking them to move behind the mob. Only one is sent even when several people in your group run Control Freak."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"How long one culprit stays quiet after setting off a parry warning. It covers the print, the sound, the announce and the whisper, because somebody who has not moved yet does not need telling every swing."

L["TANKING_TOOLS_NOVA_HEADER"] = "Novas"
L["TANKING_TOOLS_NOVA_ENABLE"] = "Enable Nova Notifications"
L["TANKING_TOOLS_NOVA_DESC"] = "Call out a Frost Nova, which scatters a pull out of the tank's reach."

--------------------------------------------------------------------------------
-- Message Formats
--------------------------------------------------------------------------------

L["UNKNOWN_SOURCE"] = "Someone"
L["UNKNOWN_TARGET"] = "an unknown target"
L["UNKNOWN_SPELL"] = "an unknown spell"

L["TAUNT_SUCCESS"] = "Taunt! %s used %s on %s!"
L["TAUNT_AOE"] = "AOE Taunt! %s used %s!"
L["TAUNT_MISSED"] = "Taunt Failed! %s's %s on %s missed!"
L["TAUNT_RESISTED"] = "Taunt Failed! %s's %s on %s was resisted!"
L["TAUNT_IMMUNE"] = "Taunt Failed! %s's %s on %s failed! %s is Immune."
L["TAUNT_FAILED"] = "Taunt Failed! %s's %s on %s failed!"
L["TAUNT_STOLEN"] = "Hey That's Mine! %s used %s on %s!" -- parked; see Data/Default-Settings.lua

L["FEAR_SUCCESS"] = "Fear! %s used %s on %s!"
L["FEAR_AOE"] = "AOE Fear! %s used %s!"

L["INTERRUPT"] = "Interrupt! %s used %s on %s to stop %s!"

L["COLD_OPENER_MISS"] = "Careful! %s's %s missed %s!"
L["COLD_OPENER_DODGE"] = "Careful! %s's %s was dodged by %s!"
L["COLD_OPENER_PARRY"] = "Careful! %s's %s was parried by %s!"
L["COLD_OPENER_BLOCK"] = "Careful! %s's %s was blocked by %s!"
L["COLD_OPENER_IMMUNE"] = "Careful! %s's %s was ignored by %s!"
L["COLD_OPENER_RESIST"] = "Careful! %s's %s was resisted by %s!"

L["ARMOR_REPORT"] = "Armor Debuffs on %s after %s seconds!"

L["PARRY_WARNING"] = "Parry Haste! %s is standing in front of %s!"
L["PARRY_WHISPER"] = "Hey, please try and stand behind %s. You're causing me to take more damage due to Parry Haste."

L["NOVA"] = "Nova! %s used %s on %s!"
L["NOVA_AOE"] = "AOE Nova! %s used %s!"
-- parked with the bubbles themselves; still reads "Annoyance!" and wants wording
-- of its own when Bubble Warnings lands. See Data/Abilities.lua.
L["ANNOYANCE_BUBBLE"] = "Annoyance! %s used %s on %s at %d%% health!"

L["BAD_PET"] = "Bad Pet! %s's pet %s used %s on %s!"
L["BAD_PET_AOE"] = "Bad Pet! %s's pet %s used %s!"
L["BAD_PET_OWN"] = "Bad Pet! Your pet %s used %s on %s!"
L["BAD_PET_OWN_AOE"] = "Bad Pet! Your pet %s used %s!"
L["BAD_PET_UNKNOWN_OWNER"] = "Bad Pet! %s used %s on %s!"
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Bad Pet! %s used %s!"
-- Kept short on purpose. It renders with a spell link and two names inside a 255
-- byte chat limit, and the widest locale runs close to twice the English.
L["BAD_PET_WHISPER"] = "Your pet %s used %s on %s. Right-click it to turn off auto-cast."
