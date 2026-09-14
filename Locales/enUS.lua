local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "enUS", true)
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"Combat announcer for taunts, interrupts, fears, tank deaths, bad pets, parries, armor debuffs, and other critical fight events. Track who taunted, what failed, who interrupted a cast, and what happened with customizable alerts."
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

--[[
    The add-on's own switch, above every feature's. The title names its REACH
    rather than the act of throwing it, which is what a player cannot read off
    the box beside it -- every other toggle on this panel governs one thing.

    The title and the ENABLE description are shared with the mini-map button's
    block for the same toggle, so the two cannot name or describe it differently.
]]
L["KILL_SWITCH"] = "All Alerts"
L["KILL_SWITCH_SUMMARY"] =
	"One switch for every alert on every tab: turning it off silences the add-on without changing a setting, and a Left-Click on the mini-map button does the same from anywhere."
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

--[[
    "Enabled" and "Disabled" rather than the shorter pair, matching the other
    add-ons in the family.
]]
L["STATE_ON"] = "Enabled"
L["STATE_OFF"] = "Disabled"
L["LEFT_CLICK"] = "Left-Click"
L["RIGHT_CLICK"] = "Right-Click"
L["SHIFT_MIDDLE_CLICK"] = "Shift + Middle-Click"
L["ACTION_TOGGLE"] = "Toggle"
L["MINIMAP_OPTIONS"] = "Control Freak Options"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

-- In tab order.
L["TAB_TAUNTS"] = "Taunts"
L["TAB_INTERRUPTS"] = "Interrupts"
L["TAB_FEARS"] = "Fears"
L["TAB_INCAPACITATED"] = "Incapacitated"
L["TAB_TANK_DEATHS"] = "Tank Deaths"
L["TAB_BAD_PRIESTS"] = "Bad Priests"
L["TAB_BAD_PETS"] = "Bad Pets"
L["TAB_TANKING_TOOLS"] = "Tanking Tools"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Turn this feature on or off."
--[[
    The dropdown beside every feature tab's enable, asking which seat the player
    has to be in. Always is the widest rung and the one most tabs ship on: it
    asks nothing about the seat at all.

    TRANSLATORS: these four sit beside a feature's enable and finish its sentence
    -- "Enable Incapacitation Monitoring" + "As a Tank" -- so they carry their
    own preposition rather than expecting one from the label, which lets each
    language put it where it belongs. They must also read on their own, since a
    closed dropdown shows the value without the label beside it. Keep them short:
    they share a 1.3-unit dropdown with "Elites Your Level+ & Bosses".
]]
L["SCOPE_ROLE_TANK"] = "As a Tank"
L["SCOPE_ROLE_HEALER"] = "As a Healer"
L["SCOPE_ROLE_TANK_HEALER"] = "As a Tank or Healer"
L["SCOPE_ROLE_ALWAYS"] = "Always"
L["SCOPE_ROLE_DESC"] =
	"Which seat you have to be in for this feature to say anything. You count as tanking when you are assigned Main Tank in a raid, or have the group finder's Tank role selected in a party. In a raid the Tank role means nothing. You count as healing only when you have the group finder's Healer role selected, since there is no raid assignment for healing. Always drops the question and fires whatever you are playing."
L["SCOPE_GROUP_HAS_TANK"] = "When Group Has a Tank"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Fire only while somebody in your group is tanking and still alive. In a raid that means an assigned Main Tank, so a raid with none assigned has no tank as far as Control Freak can tell. A tank who is down counts as no tank, because that is when somebody else holding threat is helping."
L["SCOPE_INSTANCE_ONLY"] = "While in Instances"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Fire only inside dungeons and raids."

--------------------------------------------------------------------------------
-- Alert Sections
--------------------------------------------------------------------------------

--[[
    Every alert on every tab is drawn as the same block, so each one owns five
    strings: a HEADER naming the thing that happened; an ENABLE reading "Enable
    Alerts for <that thing> On" -- the switch turns the telling on, not the
    event, and the target dropdown beside it finishes the sentence, so the
    string ENDS on the preposition (a section with no target drops the word); a
    DESC of one or two sentences; and a MINE and an OTHERS naming the two rows.
    ns.AddWhoseAlertSection in Options-Alert-Section.lua is where that shape
    lives.

    The ENABLE is the longest label in the add-on and fits its column with
    little to spare, so keep translations short -- a longer one clips with an
    ellipsis.
]]
L["ALERT_SECTION_ENABLE_DESC"] = "Turn this alert on or off."
L["ALERT_SOUND"] = "Play Sound"
L["ALERT_SOUND_DESC"] = "Play a sound when this alert fires."
L["ALERT_SOUND_FILE_DESC"] = "Pick the sound this alert plays. Choosing one plays it."
L["ALERT_SOUND_PREVIEW_DESC"] = "Play this sound now, whether or not the sound is turned on."
L["SOUND_NONE"] = "None"

--[[
    The block every tab draws: whose cast is the row, where its line goes is
    the dropdown beside it, and the target filter is a ladder rather than a
    switch. Each section names its own two rows -- see
    TAUNTS_SUCCESS_MINE below -- because "My" and "Others'" agree with the noun
    in some languages and a shared "%s" template could not.

    TRANSLATORS: ALERT_AGAINST_DESC quotes one rung and one row by name; that
    wording must match your TARGET_RUNG_ELITE_0 and ALERT_MARKED_ALWAYS, or the
    tooltip explains a choice the player cannot find. The four rungs are a threshold, widest first: each
    one counts itself and the ones after it, which is why every rung that
    includes bosses says so. Keep that in your translations -- a rung reading
    only "Elites" beside a separate "Bosses" reads as two disjoint sets.

    ALERT_MARKED_ALWAYS is the one control that WIDENS a section rather than
    narrowing it: a marked target counts whatever the rung says. Keep "Always"
    in it, and keep it distinct from ALERT_OUTPUT_ANNOUNCE -- this row decides
    WHETHER the alert fires, never where its line goes.
]]
L["ALERT_MINE_DESC"] = "Report your own casts, your pet's included. The dropdown beside it says where the line goes."
L["ALERT_OTHERS_DESC"] = "Report everybody else's casts in your group. The dropdown beside it says where the line goes."
L["ALERT_OUTPUT_PRINT"] = "Print (Self Only)"
L["ALERT_OUTPUT_ANNOUNCE"] = "Announce"
L["ALERT_OUTPUT_DESC"] =
	"Where this line goes: one place, never both. Print (Self Only) is your own window and costs nobody anything. Announce sends it to party or raid chat instead, and narrating other people to the whole raid is how an add-on wears out its welcome, so that one is worth a thought. Announce stays silent when you are not in a group, and inside battlegrounds and arenas."
L["ALERT_AGAINST_DESC"] =
	"Which enemies count, each choice including the ones after it. Bosses are skull-level (??) enemies. A dungeon boss carries no skull of its own, so it counts as an elite: Elites Your Level+ & Bosses is the choice that keeps it while dropping the lower-level trash around it. A raid mark overrides all of this while Always Alert on Marked Targets is ticked."
L["TARGET_RUNG_ALL"] = "Everything"
L["TARGET_RUNG_ELITE"] = "Elites & Bosses"
L["TARGET_RUNG_ELITE_0"] = "Elites Your Level+ & Bosses"
L["TARGET_RUNG_BOSS"] = "Bosses"
L["ALERT_MARKED_ALWAYS"] = "Always Alert on Marked Targets"
L["ALERT_MARKED_ALWAYS_DESC"] =
	"A target carrying a raid mark (skull, cross, any of the eight) counts whatever the dropdown beside the switch says. Marks are how a group points at the pull that matters, so one somebody has marked is never dropped for being the wrong rank or level."

--[[
    The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
    list of seconds. Whole minutes read as minutes, and zero reads as "No
    Cooldown" rather than "0 Second Cooldown".

    TRANSLATORS: one format serves every count it is given, one minute and five
    alike, so word each to read for any number. An abbreviated unit does.
]]
L["COOLDOWN_NONE"] = "No Cooldown"
L["COOLDOWN_SECONDS"] = "%d Second Cooldown"
L["COOLDOWN_MINUTES"] = "%d Minute Cooldown"

--------------------------------------------------------------------------------
-- Sample Lines
--------------------------------------------------------------------------------

--[[
    Only the "Example:" frame is written here. The line inside it is rendered
    from the real message format below with these stand-in names, so a reworded
    alert cannot leave a hand-copied example quoting the old text. The names are
    translatable because they sit inside a sentence whose grammar a locale may
    want to agree with.
]]
L["SAMPLE_EXAMPLE"] = "Example: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "Joe"
L["SAMPLE_PET"] = "Snuffles"

--[[
    The Naxxramas bosses the Example lines name, dealt one per line.

    TRANSLATORS: use each boss's name exactly as your client writes it, title
    included, not a translation of the English.
]]
L["SAMPLE_BOSS_ANUBREKHAN"] = "Anub'Rekhan"
L["SAMPLE_BOSS_FAERLINA"] = "Grand Widow Faerlina"
L["SAMPLE_BOSS_MAEXXNA"] = "Maexxna"
L["SAMPLE_BOSS_NOTH"] = "Noth the Plaguebringer"
L["SAMPLE_BOSS_HEIGAN"] = "Heigan the Unclean"
L["SAMPLE_BOSS_LOATHEB"] = "Loatheb"
L["SAMPLE_BOSS_RAZUVIOUS"] = "Instructor Razuvious"
L["SAMPLE_BOSS_GOTHIK"] = "Gothik the Harvester"
L["SAMPLE_BOSS_MOGRAINE"] = "Highlord Mograine"
L["SAMPLE_BOSS_KORTHAZZ"] = "Thane Korth'azz"
L["SAMPLE_BOSS_BLAUMEUX"] = "Lady Blaumeux"
L["SAMPLE_BOSS_ZELIEK"] = "Sir Zeliek"
L["SAMPLE_BOSS_PATCHWERK"] = "Patchwerk"
L["SAMPLE_BOSS_GROBBULUS"] = "Grobbulus"
L["SAMPLE_BOSS_GLUTH"] = "Gluth"
L["SAMPLE_BOSS_THADDIUS"] = "Thaddius"
L["SAMPLE_BOSS_SAPPHIRON"] = "Sapphiron"
L["SAMPLE_BOSS_KELTHUZAD"] = "Kel'Thuzad"

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
L["TAUNTS_SUCCESS_DESC"] =
	"A taunt that landed and took the mob off somebody else. A taunt on a mob already hitting the taunter is a threat refresh rather than a save, so those stay quiet."
L["TAUNTS_SUCCESS_ENABLE"] = "Enable Alerts for Successful Taunts On"
L["TAUNTS_SUCCESS_MINE"] = "My Successful Taunts"
L["TAUNTS_SUCCESS_OTHERS"] = "Others' Successful Taunts"

L["TAUNTS_FAILED_HEADER"] = "Failed Taunts"
L["TAUNTS_FAILED_DESC"] =
	"A taunt that missed, was resisted, or hit something immune. The mob did not change hands, and nothing on screen says so."
L["TAUNTS_FAILED_ENABLE"] = "Enable Alerts for Failed Taunts On"
L["TAUNTS_FAILED_MINE"] = "My Failed Taunts"
L["TAUNTS_FAILED_OTHERS"] = "Others' Failed Taunts"

L["TAUNTS_AOE_HEADER"] = "AOE Taunts"
L["TAUNTS_AOE_DESC"] = "A taunt that grabs everything around it at once, rather than one target."
L["TAUNTS_AOE_ENABLE"] = "Enable Alerts for AOE Taunts"
L["TAUNTS_AOE_MINE"] = "My AOE Taunts"
L["TAUNTS_AOE_OTHERS"] = "Others' AOE Taunts"

L["TAUNTS_ABILITIES_HEADER"] = "Taunt Abilities"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "AOE Taunt Abilities"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "Interrupts stop an enemy spell partway through its cast."
L["INTERRUPTS_ENABLE"] = "Enable Interrupt Monitoring"

L["INTERRUPTS_ALERT_HEADER"] = "Successful Interrupts"
L["INTERRUPTS_ALERT_DESC"] = "A cast stopped partway through. Names who stopped it and what they stopped."
L["INTERRUPTS_ALERT_ENABLE"] = "Enable Alerts for Successful Interrupts On"
L["INTERRUPTS_ALERT_MINE"] = "My Successful Interrupts"
L["INTERRUPTS_ALERT_OTHERS"] = "Others' Successful Interrupts"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Fears send enemies running and scatter a pull across the room."
L["FEARS_ENABLE"] = "Enable Fear Monitoring"

L["FEARS_ALERT_HEADER"] = "Successful Fears"
L["FEARS_ALERT_DESC"] =
	"A fear that landed and scattered the pull out of the tank's reach. Only the landing counts: a bare cast, a resist, and an immunity all moved nothing, so none of them are reported."
L["FEARS_ALERT_ENABLE"] = "Enable Alerts for Successful Fears"
L["FEARS_ALERT_MINE"] = "My Successful Fears"
L["FEARS_ALERT_OTHERS"] = "Others' Successful Fears"

L["FEARS_ABILITIES_HEADER"] = "Fear Abilities"

--------------------------------------------------------------------------------
-- Incapacitated
--------------------------------------------------------------------------------

L["INCAPACITATED_SUMMARY"] =
	"Tell your group the moment you lose control of your character, so somebody else can cover for you. A tank who has been feared and a healer who has been silenced are the two people who most need to say so, and the two least able to at the time."
L["INCAPACITATED_ENABLE"] = "Enable Incapacitation Monitoring"

L["INCAPACITATED_HEADER"] = "Being Incapacitated"
L["INCAPACITATED_DESC"] =
	"Tell the group when you have been stunned, feared, silenced, or otherwise taken out of the fight: what landed, who cast it, how long it lasts, and whether anybody can take it off."
--[[
    No trailing preposition and nothing beside it: this alert has no target
    ladder, and its "Long" threshold is a row of its own, above the two rows it
    names.
]]
L["INCAPACITATED_ALERT_ENABLE"] = "Enable Alerts for Being Incapacitated"
--[[
    The only pair of rows in the add-on that is not My and Others'. The game
    reports the player's own losses of control and nobody else's, so "whose"
    has one answer; how LONG it lasts is the question with two.

    TRANSLATORS: keep the quotes around Long in the caption. They mark it as the
    word the two rows below are named after rather than as an adjective.
]]
L["INCAPACITATED_LONG_CAPTION"] = 'Minimum for "Long" Incapacitation'
L["INCAPACITATED_LONG_CAPTION_DESC"] =
	"How long a loss of control has to last to count as long. Anything under it is short. Neither is thrown away. The two rows below say where each one goes, and they ship pointing at different places."
-- The caption's dropdown: the first reads for 1 only, the second for 2 to 10.
L["INCAPACITATED_THRESHOLD_ONE"] = "%d Second"
L["INCAPACITATED_THRESHOLD"] = "%d Seconds"
L["INCAPACITATED_SHORT"] = "My Short Incapacitation"
L["INCAPACITATED_SHORT_DESC"] =
	"Where the line goes when you are taken out of the fight for less than the length above. It ships printing to your own window: a stun you are back from before anybody could have covered for you explains the global you just lost, and is nobody else's problem."
L["INCAPACITATED_LONG"] = "My Long Incapacitation"
L["INCAPACITATED_LONG_DESC"] =
	"Where the line goes when you are taken out of the fight for at least the length above. It ships announcing: this is the one somebody else has time to act on, and you are the one person who cannot say so. An effect with no length at all, like a Mind Control, counts as long."

L["INCAPACITATED_STUN"] = "Include Stuns"
L["INCAPACITATED_STUN_DESC"] = "Complete loss of control, standing still. Sleep counts as a stun."
L["INCAPACITATED_FEAR"] = "Include Fears"
L["INCAPACITATED_FEAR_DESC"] = "Complete loss of control, running in random directions. The mob comes with you."
L["INCAPACITATED_CHARM"] = "Include Mind Control"
L["INCAPACITATED_CHARM_DESC"] =
	"Completely under somebody else's control. Usually the worst thing on this list, and usually indefinite."
L["INCAPACITATED_CONFUSE"] = "Include Confusion"
L["INCAPACITATED_CONFUSE_DESC"] = "Complete loss of control, walking in random directions."
L["INCAPACITATED_SILENCE"] = "Include Silences"
L["INCAPACITATED_SILENCE_DESC"] =
	"Unable to cast spells. A druid or paladin taunt is a spell, so this is a taunt that is not coming."
L["INCAPACITATED_PACIFY"] = "Include Pacifies"
L["INCAPACITATED_PACIFY_DESC"] = "Unable to attack, though spells still work."
L["INCAPACITATED_SCHOOL_INTERRUPT"] = "Include Spell Lockouts"
L["INCAPACITATED_SCHOOL_INTERRUPT_DESC"] =
	"Unable to cast spells from one school. Worth having if you taunt with a spell, since a druid or paladin locked out of Nature or Holy has no taunt."
L["INCAPACITATED_ROOT"] = "Include Roots"
L["INCAPACITATED_ROOT_DESC"] =
	"Unable to move. A rooted tank still has the taunt button, so the mob is not going anywhere."
L["INCAPACITATED_DISARM"] = "Include Disarms"
L["INCAPACITATED_DISARM_DESC"] = "Unable to attack with weapons. As with Roots, the taunt button still works."

--------------------------------------------------------------------------------
-- Tank Deaths
--------------------------------------------------------------------------------

--[[
    One alert and one list: the tank going down is an alert section, with a row
    for your own death and one for every other tank's, and Deaths by Class is
    the log beside it.

    TRANSLATORS: the MINE and OTHERS rows name a death rather than a cast, which
    is why each carries a tooltip of its own. CLASS_ROW_DESC's %s is a class
    name, from the client.
]]
L["TANK_DEATHS_SUMMARY"] =
	"The tank in your group has died. It is the one death that changes what everybody else should do next, and forty raid portraits are the worst place to notice it."
L["TANK_DEATHS_ENABLE"] = "Enable Tank Death Monitoring"

L["TANK_DEATHS_ALERT_HEADER"] = "Tank Deaths"
L["TANK_DEATHS_ALERT_DESC"] =
	"In a raid, counts only the players assigned Main Tank, you included, and a group finder role means nothing there. In a party, counts anybody with the group finder's Tank role selected. A tank with neither dies unreported."
L["TANK_DEATHS_ALERT_ENABLE"] = "Enable Alerts for Tank Deaths"
L["TANK_DEATHS_ALERT_MINE"] = "My Death"
L["TANK_DEATHS_ALERT_MINE_DESC"] =
	"Report your own death while you are tanking. The dropdown beside it says where the line goes."
L["TANK_DEATHS_ALERT_OTHERS"] = "Others' Tank Deaths"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] =
	"Report the death of anybody else in your group who is tanking. The dropdown beside it says where the line goes."

L["TANK_DEATHS_CLASS_HEADER"] = "Deaths by Class"
L["TANK_DEATHS_CLASS_DESC"] = "Every other death, by class, for the ones you want to watch."
L["TANK_DEATHS_CLASS_ROW_DESC"] = "Report it when a %s in your group dies."

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] =
	"Healers doing something that hurts a tank more than it helps. Classic and Burning Crusade only: Season of Discovery gives the rage back through a priest rune, and none of it is a problem on later game versions."
L["BAD_PRIESTS_ENABLE"] = "Enable Bad Priest Monitoring"

L["BAD_PRIESTS_HEADER"] = "Bad Shields"
L["BAD_PRIESTS_DESC"] =
	"Call out a Power Word: Shield landing on a druid or warrior who is tanking. Rage comes from damage taken, and damage a shield absorbs generates none, so a well-meant shield starves the tank of the rage they hold threat with."
L["BAD_PRIESTS_ALERT_ENABLE"] = "Enable Alerts for Bad Shields"
L["BAD_PRIESTS_HEALTH_DESC"] =
	"How low the tank has to drop before a shield stops being a mistake. A shield on somebody about to die is the right call, so the warning stays quiet below the level you pick here. Pick Always to hear about every shield."
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "Always"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "Except Under %d%% Health"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "Bad Shield Warnings"
L["BAD_PRIESTS_REPORT_DESC"] =
	"Where the warning goes when somebody shields a rage tank. There is no My or Others' row here: the cast is the healer's and the problem is the tank's."
L["BAD_PRIESTS_SELF_ONLY"] = "When Playing a Druid or Warrior Tank"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"Only warn about shields landing on you, and only while you are a druid or warrior who is tanking. Turn this off to hear about a shield on anybody in your group who is tanking as one of those classes."
L["BAD_PRIESTS_WHISPER"] = "Whisper the Caster"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"Send whoever cast the shield a note explaining why it hurts. Only one is sent even when several people in your group run Control Freak."
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"How long one caster stays quiet after setting off a shield warning. It covers the print, the sound, the announce, and the whisper, because a healer shielding on cooldown must not fill your window."

--------------------------------------------------------------------------------
-- Bad Pets
--------------------------------------------------------------------------------

L["BAD_PETS_SUMMARY"] = "Hunter and warlock pets with auto-cast threat abilities left on."
L["BAD_PETS_ENABLE"] = "Enable Bad Pet Monitoring"

L["BAD_PETS_ALERT_HEADER"] = "Pet Taunts"
L["BAD_PETS_ALERT_DESC"] =
	"A pet pulling the mob off the tank with auto-cast left on, usually without its owner noticing."
L["BAD_PETS_ALERT_ENABLE"] = "Enable Alerts for Pet Taunts On"
L["BAD_PETS_ALERT_MINE"] = "My Pet Taunts"
L["BAD_PETS_ALERT_OTHERS"] = "Others' Pet Taunts"
L["BAD_PETS_WHISPER_ENABLE"] = "Whisper the Pet Owner"
L["BAD_PETS_WHISPER_ENABLE_DESC"] =
	"Send the pet's owner a note explaining how to turn off auto-cast. Only one is sent even when several people in your group run Control Freak."
L["BAD_PETS_COOLDOWN_DESC"] =
	"How long one pet stays quiet after it sets off an alert. It covers the print, the sound, the announce, and the whisper, so a pet with auto-cast left on cannot fill your window, and its owner is not whispered again every few seconds."

L["BAD_PETS_ABILITIES_HEADER"] = "Bad Pet Abilities"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

--[[
    No summary line on the tab: Tanking Tools opens on its enable, because the
    tab is a collection of unrelated warnings rather than one idea a sentence
    can cover. Each section introduces itself instead.

    The mini-map tooltip carries a short one anyway, because the button's
    Right-Click toggles this tab and the tooltip has to say what it is turning
    on. TRANSLATORS: it lists the four section headers below in your own words
    for them; keep it to two lines in the tooltip.
]]
L["TANKING_TOOLS_ENABLE"] = "Enable Tanking Tools"
L["TANKING_TOOLS_MINIMAP_SUMMARY"] = "Cold openers, armor debuffs, parries, and novas."

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Cold Openers"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Call out your own opening attacks that failed to land: a miss, a dodge, a parry, a block, a resist, or an immunity in the first seconds of a pull. Threat that never happened, at the moment it matters most."
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Enable Alerts for Cold Openers On"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "My Cold Openers"
L["TANKING_TOOLS_COLD_OPENER_MINE_DESC"] =
	"Report your own opening abilities that failed to land. The dropdown beside it says where the line goes."
-- The caption before the window dropdown: "Within [10 Seconds of Fight]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "Within"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d Seconds of Fight"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"How long into a pull an avoided ability still counts. The clock starts the first time Control Freak sees that mob, and only abilities count: an auto-attack whiffs too often to be news."

L["TANKING_TOOLS_ARMOR_HEADER"] = "Armor Debuffs"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Report how long the group took to strip a target's armor: five Sunders or a rogue's Expose Armor. Tick an Include row below and it waits for that debuff too, but only when somebody in the group can actually cast it."
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Enable Alerts for Armor Debuffs On"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "Armor Debuff Reports"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	"Where the report goes once the group has stripped a target's armor. There is no My or Others' row here: it is the group's work, told to you."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Include Faerie Fire"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Wait for Faerie Fire before reporting, whichever form the druid casts. Ignored when there is no druid in the group."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Include Curse of Recklessness"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Wait for Curse of Recklessness before reporting. Ignored when there is no warlock in the group."

L["TANKING_TOOLS_PARRY_HEADER"] = "Parries"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Somebody parried by a mob they are not tanking is standing in front of it. Every parry speeds up that mob's next swing at whoever is holding it."
L["TANKING_TOOLS_PARRY_ENABLE"] = "Enable Alerts for Parries On"
L["TANKING_TOOLS_PARRY_MINE"] = "My Parries"
L["TANKING_TOOLS_PARRY_MINE_DESC"] =
	"Report a mob parrying your attacks. The dropdown beside it says where the line goes."
L["TANKING_TOOLS_PARRY_OTHERS"] = "Others' Parries"
L["TANKING_TOOLS_PARRY_OTHERS_DESC"] =
	"Report a mob parrying anybody else in your group. The dropdown beside it says where the line goes."
L["TANKING_TOOLS_PARRY_IGNORE_TANKS"] = "Ignore Tanks"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS_DESC"] =
	"Stay quiet when the player parried is a tank: assigned Main Tank in a raid, or holding the group finder's Tank role in a party. An off-tank stands in front of the boss for a taunt swap, and that is not a mistake to whisper about. Your own parries still report."
L["TANKING_TOOLS_PARRY_IGNORE_PETS"] = "Ignore Pets"
L["TANKING_TOOLS_PARRY_IGNORE_PETS_DESC"] =
	"Stay quiet when the one parried is a pet, yours included. A pet stands where its owner sent it, and a line naming the pet gives nobody in the group anything to do. Pets are never whispered either way."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Whisper the Culprit"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Send the culprit a note asking them to move behind the mob. Only one is sent even when several people in your group run Control Freak."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"How long one culprit stays quiet after setting off a parry warning. It covers the print, the sound, the announce, and the whisper, because somebody who has not moved yet does not need telling every swing."

L["TANKING_TOOLS_NOVA_HEADER"] = "Novas"
L["TANKING_TOOLS_NOVA_DESC"] = "Call out a Frost Nova, which freezes a pull where it stands, out of the tank's reach."
L["TANKING_TOOLS_NOVA_ENABLE"] = "Enable Alerts for Novas"
L["TANKING_TOOLS_NOVA_MINE"] = "My Novas"
L["TANKING_TOOLS_NOVA_OTHERS"] = "Others' Novas"

--------------------------------------------------------------------------------
-- Message Formats
--------------------------------------------------------------------------------

--[[
    UNKNOWN_SOURCE opens a sentence ("Someone used..."). UNKNOWN_CASTER finishes
    one, after "from" in the INCAPACITATED lines below, whenever the game never
    named the mob that cast it.

    TRANSLATORS: word each for its own place in the sentence, including any case
    your "from" needs.
]]
L["UNKNOWN_SOURCE"] = "Someone"
L["UNKNOWN_CASTER"] = "an unknown caster"
L["UNKNOWN_TARGET"] = "an unknown target"
L["UNKNOWN_SPELL"] = "an unknown spell"

L["TAUNT_SUCCESS"] = "Taunt! %s used %s on %s."
L["TAUNT_AOE"] = "AOE Taunt! %s used %s."
L["TAUNT_MISSED"] = "Taunt Failed! %s's %s on %s missed."
L["TAUNT_RESISTED"] = "Taunt Failed! %s's %s on %s was resisted."
--[[
    The one failure format that leads with the MOB rather than the taunter,
    because the immunity is the news and the other three formats have no news
    beyond "it did not land".

    TRANSLATORS: %s is, in order: mob, taunter, taunt. This is the ONLY taunt
    format whose first %s is not the player who cast it.
]]
L["TAUNT_IMMUNE"] = "Taunt Failed! %s is immune to %s's %s."
L["TAUNT_FAILED"] = "Taunt Failed! %s's %s on %s failed."
L["INTERRUPT"] = "Interrupt! %s's %s on %s stopped %s."

L["FEAR_SUCCESS"] = "Fear! %s used %s on %s."
L["FEAR_AOE"] = "AOE Fear! %s used %s."

--[[
    Four formats for one line, because two clauses of it are optional and an
    empty pair of brackets reads worse than no brackets: the length, only when
    the effect has one (a Mind Control runs until somebody breaks it), and the
    (dispel type), only when the debuff has one a player could remove.

    TRANSLATORS: %s is, in order: role, [length,] player, spell, [dispel type,]
    caster. The role is INCAPACITATED_ROLE_TANK or _HEALER below, whichever seat
    the player is actually in, or the client's own class name for a player in
    neither seat. The length is a whole phrase from
    INCAPACITATED_SECOND / INCAPACITATED_SECONDS below, in whole seconds rounded
    up, and the two INDEFINITE formats have none. The two PLAIN formats have no
    dispel type.

    It names the player even though chat shows who sent it: several people in a
    raid may run Control Freak, and a bare "Incapacitated!" leaves the group
    working out who to cover for.
]]
L["INCAPACITATED"] = "%s Incapacitated for %s; %s is afflicted by %s (%s) from %s."
L["INCAPACITATED_PLAIN"] = "%s Incapacitated for %s; %s is afflicted by %s from %s."
L["INCAPACITATED_INDEFINITE"] = "%s Incapacitated; %s is afflicted by %s (%s) from %s."
L["INCAPACITATED_PLAIN_INDEFINITE"] = "%s Incapacitated; %s is afflicted by %s from %s."

--[[
    The seat the line opens on, as its own phrase rather than a format per role,
    which would be eight copies of the four above.

    TRANSLATORS: this is the client's own word for the group finder role, and it
    opens a sentence. "Afflicted by" in the formats above is deliberately the
    phrasing Blizzard's combat log uses for a debuff landing
    (AURAADDEDOTHERHARMFUL), so a player reads the same words here as in the log
    they already watch -- use your client's wording for both if it has one.
]]
L["INCAPACITATED_ROLE_TANK"] = "Tank"
L["INCAPACITATED_ROLE_HEALER"] = "Healer"

--[[
    The length, as its own phrase rather than a bare number with "seconds" in the
    format, so the singular does not need two more formats beside the four
    above. Always a whole number: the handler rounds UP, because a fear reported
    as 5.9 promises a taunt back sooner than it is coming.

    TRANSLATORS: the handler reads exactly these two, the first for 1 and the
    second for every other count, so a language with more number forms words
    the second to read for any count. An abbreviated unit does.
]]
L["INCAPACITATED_SECOND"] = "%d second"
L["INCAPACITATED_SECONDS"] = "%d seconds"

--[[
    The four debuff types a player can take off. They name the class that can
    help -- Magic is a priest or paladin, Curse a mage or druid -- so they are
    the half of the line a tank cannot act on alone.

    TRANSLATORS: use the client's own words for these, the ones on the debuff
    tooltips, not a literal translation of the English.
]]
L["DISPEL_MAGIC"] = "Magic"
L["DISPEL_CURSE"] = "Curse"
L["DISPEL_DISEASE"] = "Disease"
L["DISPEL_POISON"] = "Poison"

--[[
    BOTH lines open on a bang, and the bang names the seat or the class that
    just went down: "Tank Down!" and "Mage Down!" read as one family, with the
    answer to "who died" in the first two words rather than in the middle of a
    sentence. What keeps the class rows quiet is that all nine ship OFF and
    none of them can play a sound, never a meeker wording.

    TRANSLATORS: %s in TANK_DEATHS_TANK_LINE is the dead player's name. In
    _CLASS_LINE it is the CLASS first and the name second. The class comes from
    the client rather than from this file, and it has to read as the subject of
    "Down!" in your language, so word the line around that order.
]]
L["TANK_DEATHS_TANK_LINE"] = "Tank Down! %s has died."
L["TANK_DEATHS_CLASS_LINE"] = "%s Down! %s has died."

--[[
    Kept short on purpose: they render with a real spell link and two real names
    inside the 255 byte chat limit, and the widest locale runs close to twice the
    English.

    The WARNING carries no explanation and the WHISPER carries all of it. The
    warning fires mid-pull in front of a tank who already knows what a shield
    does; the whisper goes to the healer who does not, and is read after the
    fact. The tab description explains it at length for whoever wants it.
]]
L["SHIELD_WARNING"] = "Bad Shield! %s's %s on %s."
L["SHIELD_WHISPER"] = "Bad Shield! Please avoid casting %s on %s. This ability blocks tanks from getting rage."

L["BAD_PET"] = "Bad Pet! %s's pet %s used %s on %s."
L["BAD_PET_AOE"] = "Bad Pet! %s's pet %s used %s."
L["BAD_PET_UNKNOWN_OWNER"] = "Bad Pet! %s used %s on %s."
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Bad Pet! %s used %s."
--[[
    Kept short on purpose. They render with a spell link and up to two names inside
    a 255 byte chat limit, and the widest locale runs close to twice the English.
]]
L["BAD_PET_WHISPER"] = "Your pet %s used %s on %s. Right-click the ability to turn off auto-cast."
L["BAD_PET_WHISPER_AOE"] = "Your pet %s used %s. Right-click the ability to turn off auto-cast."

L["COLD_OPENER_MISS"] = "Careful! %s's %s missed %s."
L["COLD_OPENER_DODGE"] = "Careful! %s's %s was dodged by %s."
L["COLD_OPENER_PARRY"] = "Careful! %s's %s was parried by %s."
L["COLD_OPENER_BLOCK"] = "Careful! %s's %s was blocked by %s."
L["COLD_OPENER_IMMUNE"] = "Careful! %s's %s was ignored by %s."
L["COLD_OPENER_RESIST"] = "Careful! %s's %s was resisted by %s."

L["ARMOR_REPORT"] = "Armor Stripped! %s became vulnerable after %s seconds."

L["PARRY_WARNING"] = "Parry Haste! %s is standing in front of %s."
L["PARRY_WHISPER"] = "Parry Haste! Please get behind %s: every parry speeds up its next swing."

L["NOVA"] = "Nova! %s used %s on %s."
L["NOVA_AOE"] = "AOE Nova! %s used %s."
