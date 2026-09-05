local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "deDE")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] = "Bessere Informationen = besseres Tanken. Besseres Tanken = bessere Schlachtzüge."
L["VERSION"] = "Version"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Version %s. Die Einstellungen (einschließlich der Option, diese Nachricht abzuschalten) findest du unter Optionen > AddOns > Control Freak. Gefällt dir das Addon? Erzähl es einem Freund! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Aus Sicherheitsgründen kann das Optionsmenü im Kampf nicht geöffnet werden."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Willkommensnachricht aktivieren"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Zeigt beim Einloggen die Begrüßung von Control Freak."
L["ENABLE_MINIMAP_BUTTON"] = "Minikarten-Button aktivieren"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Zeigt den Control Freak Button auf deiner Minikarte."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Öffnet das Optionsmenü dieses Addons."

-- The master switch. Its description is shared with the mini-map button's own
-- line for the same toggle, so the two cannot describe it differently.
L["KILL_SWITCH"] = "Not-Aus"
L["KILL_SWITCH_ENABLE"] = "Control Freak aktivieren"
L["KILL_SWITCH_ENABLE_DESC"] = "Schaltet alle Warnungen von Control Freak ein oder aus."

L["FEEDBACK_HEADER"] = "Feedback & Unterstützung"
L["FEEDBACK_DISCORD"] = "Discord"
L["FEEDBACK_GITHUB"] = "GitHub"
L["FEEDBACK_CURSEFORGE"] = "CurseForge"
L["FEEDBACK_WAGO"] = "Wago"

--------------------------------------------------------------------------------
-- Mini-map Button
--------------------------------------------------------------------------------

L["STATE_ON"] = "An"
L["STATE_OFF"] = "Aus"
L["LEFT_CLICK"] = "Linksklick"
L["RIGHT_CLICK"] = "Rechtsklick"
L["SHIFT_MIDDLE_CLICK"] = "Umschalt + Mittelklick"
L["ACTION_TOGGLE"] = "Umschalten"
L["MINIMAP_OPTIONS"] = "Control Freak Optionen"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

L["TAB_TAUNTS"] = "Spott"
L["TAB_INTERRUPTS"] = "Unterbrechungen"
L["TAB_FEARS"] = "Furcht"
L["TAB_BAD_PET"] = "Böser Begleiter"
L["TAB_TANKING_TOOLS"] = "Tank-Werkzeuge"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Schaltet diese Funktion ein oder aus."
L["SCOPE_TANK_ROLE_ONLY"] = "Nur wenn du Tank spielst"
L["SCOPE_TANK_ROLE_ONLY_DESC"] =
	"Löst nur aus, während du tankst, entweder als Haupttank des Schlachtzugs oder mit der im Gruppenfinder gewählten Tank-Rolle. Ist keines von beidem gesetzt, bleibt diese Funktion still."
L["SCOPE_GROUP_HAS_TANK"] = "Nur wenn die Gruppe einen Tank hat"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Löst nur aus, während jemand in deiner Gruppe tankt und noch am Leben ist. Ein Tank, der liegt, zählt als kein Tank, denn genau dann hilft es, wenn jemand anders die Bedrohung hält."
L["SCOPE_INSTANCE_ONLY"] = "Nur in Instanzen"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Löst nur in Dungeons und Schlachtzügen aus."

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
L["ALERT_SECTION_ENABLE_DESC"] = "Schaltet diese Warnung ein oder aus."
L["ALERT_PRINT"] = "Benachrichtigungen ausgeben"
L["ALERT_PRINT_DESC"] = "Gibt diese Warnung in deinem eigenen Chatfenster aus."
L["ALERT_PRINT_SCOPE_DESC"] =
	"Wessen Zauber in deinem eigenen Fenster landen. Meine umfasst dich und deinen eigenen Begleiter; Alle umfasst jeden in deiner Gruppe. Der Ton folgt dieser Einstellung ebenfalls, damit du nie eine Warnung hörst, die du nicht sehen kannst."
L["ALERT_ANNOUNCE"] = "In der Gruppe ansagen"
L["ALERT_ANNOUNCE_DESC"] =
	"Sendet diese Warnung in deinen Gruppen- oder Schlachtzugschat. Andere Leute vor dem ganzen Schlachtzug zu kommentieren ist der schnellste Weg, auf dem sich ein Addon unbeliebt macht, also lohnt sich hier ein Gedanke, bevor du es einschaltest."
L["ALERT_ANNOUNCE_SCOPE_DESC"] =
	"Wessen Zauber in den Gruppen- oder Schlachtzugschat gehen. Meine umfasst dich und deinen eigenen Begleiter; Alle umfasst jeden in deiner Gruppe, dich eingeschlossen."
L["ALERT_SCOPE_MINE"] = "Meine"
L["ALERT_SCOPE_ALL"] = "Alle"
L["ALERT_BOSS_ONLY"] = "Nur gegen Bosse & Elitegegner"
L["ALERT_BOSS_ONLY_DESC"] =
	"Löst nur gegen Gegner aus, die die Aufmerksamkeit wert sind: Schlachtzugsbosse, Dungeonbosse und jeder Elitegegner über deiner eigenen Stufe."
L["ALERT_SOUND"] = "Ton"
L["ALERT_SOUND_DESC"] = "Spielt einen Ton ab, wenn diese Warnung ausgelöst wird."
L["ALERT_SOUND_FILE_DESC"] = "Wähle den Ton, den diese Warnung abspielt. Beim Auswählen wird er abgespielt."
L["ALERT_SOUND_PREVIEW_DESC"] = "Spielt diesen Ton jetzt ab, egal ob der Ton eingeschaltet ist oder nicht."
L["SOUND_NONE"] = "Kein Ton"

-- The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
-- list of seconds. Whole minutes read as minutes, and zero reads as "No
-- Cooldown" rather than "0 Second Cooldown".
L["COOLDOWN_NONE"] = "Keine Abklingzeit"
L["COOLDOWN_SECONDS"] = "%d Sekunden Abklingzeit"
L["COOLDOWN_MINUTES"] = "%d Minuten Abklingzeit"

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
L["SAMPLE_EXAMPLE"] = "Beispiel: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "Max"
L["SAMPLE_PET"] = "Bello"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "Gegenstände"
L["ABILITIES_CLASS_PET"] = "%s-Begleiter"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] = "Spottfähigkeiten ziehen die Bedrohung von dem ab, der sie gerade hält."
L["TAUNTS_ENABLE"] = "Spott-Überwachung aktivieren"

L["TAUNTS_SUCCESS_HEADER"] = "Erfolgreicher Spott"
L["TAUNTS_SUCCESS_ENABLE"] = "Benachrichtigungen für erfolgreichen Spott aktivieren"
L["TAUNTS_SUCCESS_DESC"] =
	"Ein Spott, der gelandet ist und den Gegner von jemand anderem weggeholt hat. Ein Spott auf einen Gegner, der bereits auf den Spottenden einschlägt, ist eine Auffrischung der Bedrohung statt einer Rettung, deshalb bleiben diese still."
L["TAUNTS_FAILED_HEADER"] = "Fehlgeschlagener Spott"
L["TAUNTS_FAILED_ENABLE"] = "Benachrichtigungen für fehlgeschlagenen Spott aktivieren"
L["TAUNTS_FAILED_DESC"] =
	"Ein Spott, der verfehlt hat, dem widerstanden wurde oder der etwas Immunes getroffen hat. Der Gegner hat den Besitzer nicht gewechselt, und nichts auf dem Bildschirm sagt es dir."
L["TAUNTS_AOE_HEADER"] = "AoE-Spott"
L["TAUNTS_AOE_ENABLE"] = "Benachrichtigungen für AoE-Spott aktivieren"
L["TAUNTS_AOE_DESC"] = "Ein Spott, der alles um sich herum auf einmal packt, statt eines einzelnen Ziels."

L["TAUNTS_ABILITIES_HEADER"] = "Spottfähigkeiten"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "AoE-Spottfähigkeiten"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "Unterbrechungen stoppen einen gegnerischen Zauber mitten im Zaubervorgang."
L["INTERRUPTS_ENABLE"] = "Unterbrechungs-Überwachung aktivieren"

L["INTERRUPTS_ALERT_HEADER"] = "Erfolgreiche Unterbrechungen"
L["INTERRUPTS_ALERT_ENABLE"] = "Benachrichtigungen für erfolgreiche Unterbrechungen aktivieren"
L["INTERRUPTS_ALERT_DESC"] =
	"Ein Zauber, der mittendrin gestoppt wurde. Nennt, wer ihn gestoppt hat und was gestoppt wurde."

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Furcht lässt Gegner davonlaufen und verteilt einen Pull über den ganzen Raum."
L["FEARS_ENABLE"] = "Furcht-Überwachung aktivieren"

L["FEARS_ALERT_HEADER"] = "Furcht"
L["FEARS_ALERT_ENABLE"] = "Benachrichtigungen für Furcht aktivieren"
L["FEARS_ALERT_DESC"] =
	"Eine Furcht, die gelandet ist und den Pull außer Reichweite des Tanks verteilt hat. Nur das Landen zählt: ein bloßer Zauber, ein Widerstand und eine Immunität haben nichts bewegt, deshalb wird keines davon gemeldet."

L["FEARS_ABILITIES_HEADER"] = "Furchtfähigkeiten"

--------------------------------------------------------------------------------
-- Bad Pet
--------------------------------------------------------------------------------

-- The summary doubles as the mini-map button's Bad Pet line, so the tab and the
-- tooltip cannot describe the feature differently.
L["BAD_PET_SUMMARY"] =
	"Jäger- und Hexenmeisterbegleiter, bei denen Bedrohungsfähigkeiten im automatischen Wirken angeschaltet blieben."
L["BAD_PET_ENABLE"] = "Überwachung böser Begleiter aktivieren"

L["BAD_PET_ALERT_HEADER"] = "Begleiter-Spott"
L["BAD_PET_ALERT_ENABLE"] = "Benachrichtigungen für Begleiter-Spott aktivieren"
L["BAD_PET_ALERT_DESC"] =
	"Ein Begleiter, der den Gegner mit angeschaltetem automatischem Wirken vom Tank wegzieht, meist ohne dass sein Besitzer es merkt."
L["BAD_PET_WHISPER_ENABLE"] = "Besitzer anflüstern"
L["BAD_PET_WHISPER_ENABLE_DESC"] =
	"Sendet dem Besitzer des Begleiters eine Nachricht, die erklärt, wie man das automatische Wirken abschaltet. Es wird nur eine gesendet, auch wenn mehrere Leute in deiner Gruppe Control Freak nutzen."
L["BAD_PET_COOLDOWN_DESC"] =
	"Wie lange ein Begleiter still bleibt, nachdem er eine Warnung ausgelöst hat. Das gilt für die Ausgabe, den Ton, die Ansage und das Flüstern, damit ein Begleiter mit angeschaltetem automatischem Wirken nicht dein Fenster füllt und sein Besitzer nicht alle paar Sekunden erneut angeflüstert wird."

L["BAD_PET_ABILITIES_HEADER"] = "Fähigkeiten böser Begleiter"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

-- No summary line: the Tanking Tools tab opens on its enable, because the tab is
-- a collection of unrelated warnings rather than one idea a sentence can cover.
-- Each section introduces itself instead.
L["TANKING_TOOLS_ENABLE"] = "Tank-Werkzeuge aktivieren"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Kalte Eröffnungen"
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Benachrichtigungen für kalte Eröffnungen aktivieren"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Meldet deine eigenen Eröffnungsangriffe, die nicht gelandet sind: ein Verfehlen, ein Ausweichen, ein Parieren, ein Blocken, ein Widerstand oder eine Immunität in den ersten Sekunden eines Pulls. Bedrohung, die nie entstanden ist, genau dann, wenn sie am meisten zählt."
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Wie weit in einen Pull hinein eine abgewehrte Fähigkeit noch zählt. Die Uhr startet, sobald Control Freak diesen Gegner zum ersten Mal sieht, und nur Fähigkeiten zählen: ein Autoangriff geht zu oft daneben, um eine Nachricht wert zu sein."
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d Sekunden Kampf"

L["TANKING_TOOLS_ARMOR_HEADER"] = "Rüstungsschwächungen"
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Benachrichtigungen für Rüstungsschwächungen aktivieren"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Meldet, wie lange die Gruppe gebraucht hat, um die Rüstung eines Ziels abzutragen: fünf Stapel Rüstung zerreißen oder das Rüstung schwächen eines Schurken. Schalte unten einen Zusatz an, dann wartet der Bericht auch darauf, aber nur, wenn ihn jemand in der Gruppe tatsächlich wirken kann."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Feenfeuer einbeziehen"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Wartet vor dem Bericht auf Feenfeuer, in welcher Form der Druide es auch wirkt. Wird ignoriert, wenn kein Druide in der Gruppe ist."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Fluch der Tollkühnheit einbeziehen"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Wartet vor dem Bericht auf Fluch der Tollkühnheit. Wird ignoriert, wenn kein Hexenmeister in der Gruppe ist."

L["TANKING_TOOLS_PARRY_HEADER"] = "Parierte Angriffe"
L["TANKING_TOOLS_PARRY_ENABLE"] = "Benachrichtigungen für Parieren aktivieren"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Wer von einem Gegner pariert wird, den er nicht tankt, steht vor ihm. Jedes Parieren beschleunigt den nächsten Schlag dieses Gegners gegen den, der ihn hält."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Verursacher anflüstern"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Sendet dem Verursacher eine Nachricht mit der Bitte, sich hinter den Gegner zu stellen. Es wird nur eine gesendet, auch wenn mehrere Leute in deiner Gruppe Control Freak nutzen."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Wie lange ein Verursacher still bleibt, nachdem er eine Parierwarnung ausgelöst hat. Das gilt für die Ausgabe, den Ton, die Ansage und das Flüstern, denn wer sich noch nicht bewegt hat, muss es nicht bei jedem Schlag gesagt bekommen."

L["TANKING_TOOLS_NOVA_HEADER"] = "Frostnovas"
L["TANKING_TOOLS_NOVA_ENABLE"] = "Benachrichtigungen für Frostnovas aktivieren"
L["TANKING_TOOLS_NOVA_DESC"] = "Meldet eine Frostnova, die einen Pull außer Reichweite des Tanks verteilt."

--------------------------------------------------------------------------------
-- Message Formats
--------------------------------------------------------------------------------

L["UNKNOWN_SOURCE"] = "Jemand"
L["UNKNOWN_TARGET"] = "ein unbekanntes Ziel"
L["UNKNOWN_SPELL"] = "ein unbekannter Zauber"

L["TAUNT_SUCCESS"] = "Spott! %s hat %s auf %s eingesetzt!"
L["TAUNT_AOE"] = "AoE-Spott! %s hat %s eingesetzt!"
L["TAUNT_MISSED"] = "Spott fehlgeschlagen! %ss %s auf %s: verfehlt!"
L["TAUNT_RESISTED"] = "Spott fehlgeschlagen! %ss %s auf %s: widerstanden!"
L["TAUNT_IMMUNE"] = "Spott fehlgeschlagen! %ss %s auf %s misslang! %s ist immun."
L["TAUNT_FAILED"] = "Spott fehlgeschlagen! %ss %s auf %s misslang!"
L["TAUNT_STOLEN"] = "Hey, der gehört mir! %s hat %s auf %s eingesetzt!" -- parked; see Data/Default-Settings.lua

L["FEAR_SUCCESS"] = "Furcht! %s hat %s auf %s eingesetzt!"
L["FEAR_AOE"] = "AoE-Furcht! %s hat %s eingesetzt!"

L["INTERRUPT"] = "Unterbrechung! %s hat %s auf %s eingesetzt und %s gestoppt!"

L["COLD_OPENER_MISS"] = "Vorsicht! %ss %s auf %s: verfehlt!"
L["COLD_OPENER_DODGE"] = "Vorsicht! %ss %s auf %s: ausgewichen!"
L["COLD_OPENER_PARRY"] = "Vorsicht! %ss %s auf %s: pariert!"
L["COLD_OPENER_BLOCK"] = "Vorsicht! %ss %s auf %s: geblockt!"
L["COLD_OPENER_IMMUNE"] = "Vorsicht! %ss %s auf %s: immun!"
L["COLD_OPENER_RESIST"] = "Vorsicht! %ss %s auf %s: widerstanden!"

L["ARMOR_REPORT"] = "Rüstungsschwächungen auf %s nach %s Sekunden!"

L["PARRY_WARNING"] = "Parierhast! %s steht vor %s!"
L["PARRY_WHISPER"] = "Hey, stell dich bitte hinter %s. Durch Parierhast sorgst du dafür, dass ich mehr Schaden nehme."

L["NOVA"] = "Nova! %s hat %s auf %s eingesetzt!"
L["NOVA_AOE"] = "AoE-Nova! %s hat %s eingesetzt!"
-- parked with the bubbles themselves; still reads "Annoyance!" and wants wording
-- of its own when Bubble Warnings lands. See Data/Abilities.lua.
L["ANNOYANCE_BUBBLE"] = "Nervig! %s hat %s auf %s bei %d%% Leben eingesetzt!"

L["BAD_PET"] = "Böser Begleiter! %ss Begleiter %s hat %s auf %s eingesetzt!"
L["BAD_PET_AOE"] = "Böser Begleiter! %ss Begleiter %s hat %s eingesetzt!"
L["BAD_PET_OWN"] = "Böser Begleiter! Dein Begleiter %s hat %s auf %s eingesetzt!"
L["BAD_PET_OWN_AOE"] = "Böser Begleiter! Dein Begleiter %s hat %s eingesetzt!"
L["BAD_PET_UNKNOWN_OWNER"] = "Böser Begleiter! %s hat %s auf %s eingesetzt!"
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Böser Begleiter! %s hat %s eingesetzt!"
L["BAD_PET_WHISPER"] =
	"Dein Begleiter %s hat %s auf %s eingesetzt. Klicke die Fähigkeit auf der Aktionsleiste deines Begleiters oder in deinem Zauberbuch mit rechts an, um das automatische Wirken abzuschalten."
