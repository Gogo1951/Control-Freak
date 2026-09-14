local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "deDE")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"Kampfansagen zu Spott, Unterbrechungen, Furcht, Tank-Toden, bösen Begleitern, parierten Angriffen, Rüstungsschwächungen und anderen kritischen Kampfereignissen. Verfolge mit anpassbaren Meldungen, wer gespottet hat, was fehlgeschlagen ist, wer einen Zauber unterbrochen hat und was passiert ist."
L["VERSION"] = "Version"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Version %s. Die Einstellungen (einschließlich der Option, diese Nachricht abzuschalten) findest du unter Optionen > AddOns > Control Freak. Gefällt dir das Add-on? Erzähl einem Freund davon! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Aus Sicherheitsgründen kann das Optionsfenster im Kampf nicht geöffnet werden."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Willkommensnachricht aktivieren"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Zeigt beim Einloggen die Begrüßung von Control Freak."
L["ENABLE_MINIMAP_BUTTON"] = "Minikartensymbol aktivieren"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Zeigt das Symbol von Control Freak an deiner Minikarte."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Öffnet das Optionsfenster dieses Add-ons."

--[[
    The add-on's own switch, above every feature's. The title names its REACH
    rather than the act of throwing it, which is what a player cannot read off
    the box beside it -- every other toggle on this panel governs one thing.

    Its ENABLE description is shared with the mini-map button's line for the same
    toggle, so the two cannot describe it differently.
]]
L["KILL_SWITCH"] = "Alle Meldungen"
L["KILL_SWITCH_SUMMARY"] =
	"Ein Schalter für jede Meldung auf jedem Reiter: Ausschalten macht das Add-on still, ohne eine einzige Einstellung zu ändern, und ein Linksklick auf das Minikartensymbol macht von überall dasselbe."
L["KILL_SWITCH_ENABLE"] = "Control Freak aktivieren"
L["KILL_SWITCH_ENABLE_DESC"] = "Schaltet alle Meldungen von Control Freak ein oder aus."

L["FEEDBACK_HEADER"] = "Feedback & Unterstützung"
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
L["STATE_ON"] = "Aktiviert"
L["STATE_OFF"] = "Deaktiviert"
L["LEFT_CLICK"] = "Linksklick"
L["RIGHT_CLICK"] = "Rechtsklick"
L["SHIFT_MIDDLE_CLICK"] = "Umschalt + Mittelklick"
L["ACTION_TOGGLE"] = "Ein/Aus"
L["MINIMAP_OPTIONS"] = "Optionen für Control Freak"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

-- In tab order.
L["TAB_TAUNTS"] = "Spott"
L["TAB_INTERRUPTS"] = "Unterbrechungen"
L["TAB_FEARS"] = "Furcht"
L["TAB_INCAPACITATED"] = "Handlungsunfähig"
L["TAB_TANK_DEATHS"] = "Tank-Tode"
L["TAB_BAD_PRIESTS"] = "Böse Priester"
L["TAB_BAD_PETS"] = "Böse Begleiter"
L["TAB_TANKING_TOOLS"] = "Tank-Werkzeuge"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Schaltet diese Funktion ein oder aus."
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
L["SCOPE_ROLE_TANK"] = "Als Tank"
L["SCOPE_ROLE_HEALER"] = "Als Heiler"
L["SCOPE_ROLE_TANK_HEALER"] = "Als Tank oder Heiler"
L["SCOPE_ROLE_ALWAYS"] = "Immer"
L["SCOPE_ROLE_DESC"] =
	'Welche Rolle du spielen musst, damit diese Funktion überhaupt etwas sagt. Als Tank zählst du, wenn du im Schlachtzug als Haupttank eingeteilt bist oder in einer Gruppe in der Gruppensuche die Tank-Rolle gewählt hast. Im Schlachtzug bedeutet die Tank-Rolle nichts. Als Heiler zählst du nur, wenn du in der Gruppensuche die Heiler-Rolle gewählt hast, denn fürs Heilen gibt es keine Zuweisung im Schlachtzug. "Immer" lässt die Frage weg und löst aus, egal was du spielst.'
L["SCOPE_GROUP_HAS_TANK"] = "Wenn die Gruppe einen Tank hat"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Löst nur aus, während jemand in deiner Gruppe tankt und noch lebt. Im Schlachtzug heißt das ein eingeteilter Haupttank, ein Schlachtzug ohne Haupttank hat für Control Freak also keinen Tank. Ein Tank, der am Boden liegt, zählt nicht als Tank, denn genau dann hilft es, wenn jemand anderes die Bedrohung hält."
L["SCOPE_INSTANCE_ONLY"] = "Wenn du in einer Instanz bist"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Löst nur in Dungeons und Schlachtzügen aus."

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
L["ALERT_SECTION_ENABLE_DESC"] = "Schaltet diese Meldung ein oder aus."
L["ALERT_SOUND"] = "Ton abspielen"
L["ALERT_SOUND_DESC"] = "Spielt einen Ton ab, wenn diese Meldung ausgelöst wird."
L["ALERT_SOUND_FILE_DESC"] = "Wähle den Ton, den diese Meldung abspielt. Beim Auswählen wird er abgespielt."
L["ALERT_SOUND_PREVIEW_DESC"] = "Spielt diesen Ton jetzt ab, egal ob der Ton eingeschaltet ist oder nicht."
L["SOUND_NONE"] = "Kein Ton"

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
L["ALERT_MINE_DESC"] =
	"Meldet deine eigenen Zauber und Fähigkeiten, auch die deines Begleiters. Das Auswahlmenü daneben legt fest, wohin die Zeile geht."
L["ALERT_OTHERS_DESC"] =
	"Meldet die Zauber und Fähigkeiten aller anderen in deiner Gruppe. Das Auswahlmenü daneben legt fest, wohin die Zeile geht."
L["ALERT_OUTPUT_PRINT"] = "Anzeigen (nur für mich)"
L["ALERT_OUTPUT_ANNOUNCE"] = "Ansagen"
L["ALERT_OUTPUT_DESC"] =
	'Wohin diese Zeile geht: an einen Ort, nie an beide. "Anzeigen (nur für mich)" landet in deinem eigenen Fenster und kostet niemanden etwas. "Ansagen" schickt sie stattdessen in den Chat deiner Gruppe oder deines Schlachtzugs, und andere Leute vor dem ganzen Schlachtzug zu kommentieren ist genau das, womit sich ein Add-on unbeliebt macht, also ist diese Wahl einen Gedanken wert. "Ansagen" bleibt stumm, wenn du in keiner Gruppe bist, sowie auf Schlachtfeldern und in Arenen.'
L["ALERT_AGAINST_DESC"] =
	'Welche Gegner zählen, wobei jede Auswahl die nach ihr folgenden einschließt. Bosse sind Gegner mit Totenkopf-Stufe (??). Ein Dungeonboss trägt keinen eigenen Totenkopf und zählt deshalb als Elitegegner: "Elite deiner Stufe+ & Bosse" ist die Auswahl, die ihn behält und dabei das niedrigstufige Fußvolk um ihn herum weglässt. Solange "Bei markierten Zielen immer melden" angehakt ist, hat eine Zielmarkierung Vorrang vor alldem.'
L["TARGET_RUNG_ALL"] = "Alles"
L["TARGET_RUNG_ELITE"] = "Elite & Bosse"
L["TARGET_RUNG_ELITE_0"] = "Elite deiner Stufe+ & Bosse"
L["TARGET_RUNG_BOSS"] = "Bosse"
L["ALERT_MARKED_ALWAYS"] = "Bei markierten Zielen immer melden"
L["ALERT_MARKED_ALWAYS_DESC"] =
	"Ein Ziel mit Zielmarkierung (Totenschädel, Kreuz, jede der acht) zählt, egal was im Auswahlmenü neben dem Schalter steht. Mit Markierungen zeigt eine Gruppe auf die Gegner, auf die es ankommt, also fällt ein Ziel, das jemand markiert hat, nie heraus, nur weil es den falschen Rang oder die falsche Stufe hat."

--[[
    The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
    list of seconds. Whole minutes read as minutes, and zero reads as "No
    Cooldown" rather than "0 Second Cooldown".

    TRANSLATORS: one format serves every count it is given, one minute and five
    alike, so word each to read for any number. An abbreviated unit does.
]]
L["COOLDOWN_NONE"] = "Keine Abklingzeit"
L["COOLDOWN_SECONDS"] = "%d Sek. Abklingzeit"
L["COOLDOWN_MINUTES"] = "%d Min. Abklingzeit"

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
L["SAMPLE_EXAMPLE"] = "Beispiel: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "Max"
L["SAMPLE_PET"] = "Bello"

--[[
    The Naxxramas bosses the Example lines name, dealt one per line.

    TRANSLATORS: use each boss's name exactly as your client writes it, title
    included, not a translation of the English.
]]
L["SAMPLE_BOSS_ANUBREKHAN"] = "Anub'Rekhan"
L["SAMPLE_BOSS_FAERLINA"] = "Großwitwe Faerlina"
L["SAMPLE_BOSS_MAEXXNA"] = "Maexxna"
L["SAMPLE_BOSS_NOTH"] = "Noth der Seuchenfürst"
L["SAMPLE_BOSS_HEIGAN"] = "Heigan der Unreine"
L["SAMPLE_BOSS_LOATHEB"] = "Loatheb"
L["SAMPLE_BOSS_RAZUVIOUS"] = "Instrukteur Razuvious"
L["SAMPLE_BOSS_GOTHIK"] = "Gothik der Seelenjäger"
L["SAMPLE_BOSS_MOGRAINE"] = "Hochlord Mograine"
L["SAMPLE_BOSS_KORTHAZZ"] = "Thane Korth'azz"
L["SAMPLE_BOSS_BLAUMEUX"] = "Lady Blaumeux"
L["SAMPLE_BOSS_ZELIEK"] = "Sire Zeliek"
L["SAMPLE_BOSS_PATCHWERK"] = "Flickwerk"
L["SAMPLE_BOSS_GROBBULUS"] = "Grobbulus"
L["SAMPLE_BOSS_GLUTH"] = "Gluth"
L["SAMPLE_BOSS_THADDIUS"] = "Thaddius"
L["SAMPLE_BOSS_SAPPHIRON"] = "Saphiron"
L["SAMPLE_BOSS_KELTHUZAD"] = "Kel'Thuzad"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "Gegenstände"
L["ABILITIES_CLASS_PET"] = "%s-Begleiter"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] = "Spottfähigkeiten entreißen die Bedrohung dem, der sie gerade hält."
L["TAUNTS_ENABLE"] = "Spott-Überwachung aktivieren"

L["TAUNTS_SUCCESS_HEADER"] = "Erfolgreicher Spott"
L["TAUNTS_SUCCESS_DESC"] =
	"Ein Spott, der getroffen und jemand anderem den Gegner abgenommen hat. Ein Spott auf einen Gegner, der schon auf den Spottenden einschlägt, frischt nur die Bedrohung auf und rettet niemanden, deshalb bleiben solche still."
L["TAUNTS_SUCCESS_ENABLE"] = "Erfolgreichen Spott melden gegen"
L["TAUNTS_SUCCESS_MINE"] = "Mein erfolgreicher Spott"
L["TAUNTS_SUCCESS_OTHERS"] = "Erfolgreicher Spott anderer"

L["TAUNTS_FAILED_HEADER"] = "Fehlgeschlagener Spott"
L["TAUNTS_FAILED_DESC"] =
	"Ein Spott, der verfehlt hat, dem widerstanden wurde oder der auf etwas Immunes traf. Der Gegner hat sein Ziel nicht gewechselt, und nichts auf dem Bildschirm verrät es dir."
L["TAUNTS_FAILED_ENABLE"] = "Fehlgeschlagenen Spott melden gegen"
L["TAUNTS_FAILED_MINE"] = "Mein fehlgeschlagener Spott"
L["TAUNTS_FAILED_OTHERS"] = "Fehlgeschlagener Spott anderer"

L["TAUNTS_AOE_HEADER"] = "Flächenspott"
L["TAUNTS_AOE_DESC"] = "Ein Spott, der alles um sich herum auf einmal packt statt nur ein einzelnes Ziel."
L["TAUNTS_AOE_ENABLE"] = "Flächenspott melden"
L["TAUNTS_AOE_MINE"] = "Mein Flächenspott"
L["TAUNTS_AOE_OTHERS"] = "Flächenspott anderer"

L["TAUNTS_ABILITIES_HEADER"] = "Spottfähigkeiten"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "Flächenspott-Fähigkeiten"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "Unterbrechungen stoppen einen gegnerischen Zauber mitten im Wirken."
L["INTERRUPTS_ENABLE"] = "Unterbrechungs-Überwachung aktivieren"

L["INTERRUPTS_ALERT_HEADER"] = "Erfolgreiche Unterbrechungen"
L["INTERRUPTS_ALERT_DESC"] =
	"Ein Zauber, der mitten im Wirken unterbrochen wurde. Nennt, wer ihn unterbrochen hat und was unterbrochen wurde."
L["INTERRUPTS_ALERT_ENABLE"] = "Erfolgreiche Unterbrechungen melden gegen"
L["INTERRUPTS_ALERT_MINE"] = "Meine erfolgreichen Unterbrechungen"
L["INTERRUPTS_ALERT_OTHERS"] = "Erfolgreiche Unterbrechungen anderer"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Furchteffekte lassen Gegner davonrennen und verstreuen eine Gegnergruppe im ganzen Raum."
L["FEARS_ENABLE"] = "Furcht-Überwachung aktivieren"

L["FEARS_ALERT_HEADER"] = "Erfolgreiche Furchtzauber"
L["FEARS_ALERT_DESC"] =
	"Eine Furcht, die getroffen und die Gegnergruppe aus der Reichweite des Tanks verstreut hat. Nur der Treffer zählt: Ein bloßes Wirken, ein Widerstehen oder eine Immunität hat nichts bewegt, deshalb wird nichts davon gemeldet."
L["FEARS_ALERT_ENABLE"] = "Erfolgreiche Furchtzauber melden"
L["FEARS_ALERT_MINE"] = "Meine erfolgreichen Furchtzauber"
L["FEARS_ALERT_OTHERS"] = "Erfolgreiche Furchtzauber anderer"

L["FEARS_ABILITIES_HEADER"] = "Furchtfähigkeiten"

--------------------------------------------------------------------------------
-- Incapacitated
--------------------------------------------------------------------------------

L["INCAPACITATED_SUMMARY"] =
	"Sagt deiner Gruppe sofort Bescheid, wenn du die Kontrolle über deinen Charakter verlierst, damit jemand anderes für dich einspringen kann. Ein in Furcht versetzter Tank und ein zum Schweigen gebrachter Heiler sind die beiden, die es am dringendsten sagen müssten, und genau die beiden, die es in dem Moment am wenigsten können."
L["INCAPACITATED_ENABLE"] = "Überwachung der Handlungsunfähigkeit aktivieren"

L["INCAPACITATED_HEADER"] = "Handlungsunfähigkeit"
L["INCAPACITATED_DESC"] =
	"Sagt der Gruppe Bescheid, wenn du betäubt, in Furcht versetzt, zum Schweigen gebracht oder anderweitig außer Gefecht gesetzt wurdest: was dich getroffen hat, wer es gewirkt hat, wie lange es dauert und ob es jemand entfernen kann."
--[[
    No trailing preposition and nothing beside it: this alert has no target
    ladder, and its "Long" threshold is a row of its own, above the two rows it
    names.
]]
L["INCAPACITATED_ALERT_ENABLE"] = "Handlungsunfähigkeit melden"
--[[
    The only pair of rows in the add-on that is not My and Others'. The game
    reports the player's own losses of control and nobody else's, so "whose"
    has one answer; how LONG it lasts is the question with two.

    TRANSLATORS: keep the quotes around Long in the caption. They mark it as the
    word the two rows below are named after rather than as an adjective.
]]
L["INCAPACITATED_LONG_CAPTION"] = 'Mindestdauer für "lange" Effekte'
L["INCAPACITATED_LONG_CAPTION_DESC"] =
	"Wie lange ein Kontrollverlust dauern muss, um als lang zu gelten. Alles darunter ist kurz. Keiner von beiden wird verworfen. Die zwei Zeilen darunter legen fest, wohin jeder davon geht, und ab Werk sind sie auf unterschiedliche Ausgaben eingestellt."
-- The caption's dropdown: the first reads for 1 only, the second for 2 to 10.
L["INCAPACITATED_THRESHOLD_ONE"] = "%d Sekunde"
L["INCAPACITATED_THRESHOLD"] = "%d Sekunden"
L["INCAPACITATED_SHORT"] = "Meine kurze Handlungsunfähigkeit"
L["INCAPACITATED_SHORT_DESC"] =
	"Wohin die Zeile geht, wenn du kürzer als die Dauer darüber außer Gefecht gesetzt wirst. Ab Werk wird sie in deinem eigenen Fenster angezeigt: Eine Betäubung, die vorbei ist, bevor jemand für dich hätte einspringen können, erklärt die globale Abklingzeit, die du gerade verloren hast, und ist niemandes Problem außer deinem."
L["INCAPACITATED_LONG"] = "Meine lange Handlungsunfähigkeit"
L["INCAPACITATED_LONG_DESC"] =
	"Wohin die Zeile geht, wenn du mindestens für die Dauer darüber außer Gefecht gesetzt wirst. Ab Werk wird sie angesagt: Das ist der Fall, bei dem jemand anderes noch Zeit hat zu reagieren, und du bist genau die Person, die es nicht sagen kann. Ein Effekt ganz ohne Dauer, etwa eine Gedankenkontrolle, zählt als lang."

L["INCAPACITATED_STUN"] = "Betäubungen einbeziehen"
L["INCAPACITATED_STUN_DESC"] = "Völliger Kontrollverlust, du stehst still. Schlaf zählt als Betäubung."
L["INCAPACITATED_FEAR"] = "Furcht einbeziehen"
L["INCAPACITATED_FEAR_DESC"] = "Völliger Kontrollverlust, du rennst in zufällige Richtungen. Der Gegner kommt mit."
L["INCAPACITATED_CHARM"] = "Gedankenkontrolle einbeziehen"
L["INCAPACITATED_CHARM_DESC"] =
	"Vollständig unter der Kontrolle von jemand anderem. Meist das Schlimmste auf dieser Liste, und meist ohne feste Dauer."
L["INCAPACITATED_CONFUSE"] = "Verwirrung einbeziehen"
L["INCAPACITATED_CONFUSE_DESC"] = "Völliger Kontrollverlust, du gehst in zufällige Richtungen."
L["INCAPACITATED_SILENCE"] = "Stille einbeziehen"
L["INCAPACITATED_SILENCE_DESC"] =
	"Du kannst keine Zauber wirken. Der Spott eines Druiden oder Paladins ist ein Zauber, also ist das ein Spott, der nicht kommt."
L["INCAPACITATED_PACIFY"] = "Befriedungen einbeziehen"
L["INCAPACITATED_PACIFY_DESC"] = "Du kannst nicht angreifen, Zauber funktionieren aber noch."
L["INCAPACITATED_SCHOOL_INTERRUPT"] = "Zaubersperren einbeziehen"
L["INCAPACITATED_SCHOOL_INTERRUPT_DESC"] =
	"Du kannst keine Zauber einer bestimmten Schule wirken. Sinnvoll, wenn du mit einem Zauber spottest, denn ein Druide oder Paladin, für den Natur oder Heilig gesperrt ist, hat keinen Spott."
L["INCAPACITATED_ROOT"] = "Wurzeleffekte einbeziehen"
L["INCAPACITATED_ROOT_DESC"] =
	"Du kannst dich nicht bewegen. Ein festgewurzelter Tank hat noch seine Spott-Taste, also geht der Gegner nirgendwohin."
L["INCAPACITATED_DISARM"] = "Entwaffnungen einbeziehen"
L["INCAPACITATED_DISARM_DESC"] =
	"Du kannst nicht mit Waffen angreifen. Wie bei Wurzeleffekten funktioniert die Spott-Taste weiterhin."

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
	"Der Tank in deiner Gruppe ist gestorben. Es ist der eine Tod, der ändert, was alle anderen als Nächstes tun sollten, und vierzig Schlachtzugsporträts sind der schlechteste Ort, um ihn zu bemerken."
L["TANK_DEATHS_ENABLE"] = "Überwachung von Tank-Toden aktivieren"

L["TANK_DEATHS_ALERT_HEADER"] = "Tank-Tode"
L["TANK_DEATHS_ALERT_DESC"] =
	"Im Schlachtzug zählen nur die als Haupttank eingeteilten Spieler, dich eingeschlossen, und eine Rolle aus der Gruppensuche bedeutet dort nichts. In einer Gruppe zählt, wer in der Gruppensuche die Tank-Rolle gewählt hat. Ein Tank ohne beides stirbt ungemeldet."
L["TANK_DEATHS_ALERT_ENABLE"] = "Tank-Tode melden"
L["TANK_DEATHS_ALERT_MINE"] = "Mein Tod"
L["TANK_DEATHS_ALERT_MINE_DESC"] =
	"Meldet deinen eigenen Tod, wenn du gerade tankst. Das Auswahlmenü daneben legt fest, wohin die Zeile geht."
L["TANK_DEATHS_ALERT_OTHERS"] = "Tank-Tode anderer"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] =
	"Meldet es, wenn jemand anderes in deiner Gruppe stirbt, der gerade tankt. Das Auswahlmenü daneben legt fest, wohin die Zeile geht."

L["TANK_DEATHS_CLASS_HEADER"] = "Tode nach Klasse"
L["TANK_DEATHS_CLASS_DESC"] = "Alle übrigen Tode, nach Klasse, für die, die du im Auge behalten willst."
L["TANK_DEATHS_CLASS_ROW_DESC"] = "Meldet es, wenn ein %s in deiner Gruppe stirbt."

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] =
	"Heiler, die etwas tun, das einem Tank mehr schadet als hilft. Nur in Classic und Burning Crusade: In der Saison der Entdeckungen gibt eine Priesterrune die Wut zurück, und in späteren Spielversionen ist nichts davon ein Problem."
L["BAD_PRIESTS_ENABLE"] = "Überwachung böser Priester aktivieren"

L["BAD_PRIESTS_HEADER"] = "Schlechte Schilde"
L["BAD_PRIESTS_DESC"] =
	"Meldet ein Machtwort: Schild, das auf einem tankenden Druiden oder Krieger landet. Wut entsteht durch erlittenen Schaden, und Schaden, den ein Schild absorbiert, erzeugt keine, also lässt ein gut gemeinter Schild den Tank um die Wut hungern, mit der er die Bedrohung hält."
L["BAD_PRIESTS_ALERT_ENABLE"] = "Schlechte Schilde melden"
L["BAD_PRIESTS_HEALTH_DESC"] =
	'Wie tief die Gesundheit des Tanks fallen muss, bevor ein Schild kein Fehler mehr ist. Ein Schild auf jemandem, der gleich stirbt, ist die richtige Entscheidung, also bleibt die Warnung unterhalb des hier gewählten Werts still. Wähle "Immer", um von jedem Schild zu erfahren.'
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "Immer"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "Außer unter %d%% Gesundheit"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "Warnungen bei schlechten Schilden"
L["BAD_PRIESTS_REPORT_DESC"] =
	"Wohin die Warnung geht, wenn jemand einen Tank, der auf Wut angewiesen ist, mit einem Schild belegt. Getrennte Zeilen für eigene und fremde Zauber gibt es hier nicht: Der Zauber gehört dem Heiler, das Problem dem Tank."
L["BAD_PRIESTS_SELF_ONLY"] = "Wenn du als Druide oder Krieger tankst"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"Warnt nur vor Schilden, die auf dir landen, und nur, während du als Druide oder Krieger tankst. Schalte das aus, um von einem Schild auf jedem in deiner Gruppe zu erfahren, der als eine dieser Klassen tankt."
L["BAD_PRIESTS_WHISPER"] = "Den Zaubernden anflüstern"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"Schickt dem, der den Schild gewirkt hat, eine Nachricht, die erklärt, warum er schadet. Es wird nur eine geschickt, auch wenn mehrere Leute in deiner Gruppe Control Freak nutzen."
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"Wie lange ein Zaubernder verschont bleibt, nachdem er eine Schildwarnung ausgelöst hat. Das gilt für die Anzeige, den Ton, die Ansage und das Flüstern, denn ein Heiler, der Schilde wirkt, sobald die Abklingzeit um ist, darf dein Fenster nicht füllen."

--------------------------------------------------------------------------------
-- Bad Pets
--------------------------------------------------------------------------------

L["BAD_PETS_SUMMARY"] =
	"Begleiter von Jägern und Hexenmeistern, deren Bedrohungsfähigkeiten noch auf automatischem Wirken stehen."
L["BAD_PETS_ENABLE"] = "Überwachung böser Begleiter aktivieren"

L["BAD_PETS_ALERT_HEADER"] = "Begleiter-Spott"
L["BAD_PETS_ALERT_DESC"] =
	"Ein Begleiter, der dem Tank mit eingeschaltetem automatischem Wirken den Gegner wegzieht, meist ohne dass sein Besitzer es merkt."
L["BAD_PETS_ALERT_ENABLE"] = "Begleiter-Spott melden gegen"
L["BAD_PETS_ALERT_MINE"] = "Spott meines Begleiters"
L["BAD_PETS_ALERT_OTHERS"] = "Begleiter-Spott anderer"
L["BAD_PETS_WHISPER_ENABLE"] = "Den Besitzer des Begleiters anflüstern"
L["BAD_PETS_WHISPER_ENABLE_DESC"] =
	"Schickt dem Besitzer des Begleiters eine Nachricht, die erklärt, wie man das automatische Wirken abschaltet. Es wird nur eine geschickt, auch wenn mehrere Leute in deiner Gruppe Control Freak nutzen."
L["BAD_PETS_COOLDOWN_DESC"] =
	"Wie lange ein Begleiter verschont bleibt, nachdem er eine Meldung ausgelöst hat. Das gilt für die Anzeige, den Ton, die Ansage und das Flüstern, damit ein Begleiter mit eingeschaltetem automatischem Wirken nicht dein Fenster füllt und sein Besitzer nicht alle paar Sekunden erneut angeflüstert wird."

L["BAD_PETS_ABILITIES_HEADER"] = "Fähigkeiten böser Begleiter"

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
L["TANKING_TOOLS_ENABLE"] = "Tank-Werkzeuge aktivieren"
L["TANKING_TOOLS_MINIMAP_SUMMARY"] = "Verpatzte Eröffnungen, Rüstungsschwächungen, parierte Angriffe und Frostnovas."

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Verpatzte Eröffnungen"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Meldet deine eigenen Eröffnungsangriffe, die nicht getroffen haben: ein Verfehlen, Ausweichen, Parieren, Blocken, Widerstehen oder eine Immunität in den ersten Sekunden eines Kampfes. Bedrohung, die nie entstanden ist, genau in dem Moment, in dem sie am meisten zählt."
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Verpatzte Eröffnungen melden gegen"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "Meine verpatzten Eröffnungen"
L["TANKING_TOOLS_COLD_OPENER_MINE_DESC"] =
	"Meldet deine eigenen Eröffnungsfähigkeiten, die nicht getroffen haben. Das Auswahlmenü daneben legt fest, wohin die Zeile geht."
-- The caption before the window dropdown: "Within [10 Seconds of Fight]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "In den ersten"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d Sekunden des Kampfes"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Wie lange nach Kampfbeginn eine abgewehrte Fähigkeit noch zählt. Die Uhr startet, sobald Control Freak diesen Gegner zum ersten Mal sieht, und nur Fähigkeiten zählen: Ein automatischer Angriff geht zu oft daneben, um eine Meldung wert zu sein."

L["TANKING_TOOLS_ARMOR_HEADER"] = "Rüstungsschwächungen"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Meldet, wie lange die Gruppe gebraucht hat, um die Rüstung eines Ziels abzubauen: fünf Stapel Rüstung zerreißen oder Rüstung schwächen von einem Schurken. Hakst du unten eine Schwächung zum Einbeziehen an, wartet die Meldung auch auf sie, aber nur, wenn jemand in der Gruppe sie tatsächlich wirken kann."
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Rüstungsschwächungen melden gegen"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "Berichte zu Rüstungsschwächungen"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	"Wohin der Bericht geht, sobald die Gruppe die Rüstung eines Ziels abgebaut hat. Getrennte Zeilen für eigene und fremde Zauber gibt es hier nicht: Es ist die Arbeit der Gruppe, über die dir berichtet wird."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Feenfeuer einbeziehen"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Wartet vor dem Bericht auf Feenfeuer, egal in welcher Form der Druide es wirkt. Wird ignoriert, wenn kein Druide in der Gruppe ist."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Fluch der Tollkühnheit einbeziehen"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Wartet vor dem Bericht auf Fluch der Tollkühnheit. Wird ignoriert, wenn kein Hexenmeister in der Gruppe ist."

L["TANKING_TOOLS_PARRY_HEADER"] = "Parierte Angriffe"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Wer von einem Gegner pariert wird, den er nicht tankt, steht vor ihm. Jedes Parieren beschleunigt den nächsten Schlag dieses Gegners gegen den, der ihn hält."
L["TANKING_TOOLS_PARRY_ENABLE"] = "Parierte Angriffe melden gegen"
L["TANKING_TOOLS_PARRY_MINE"] = "Meine parierten Angriffe"
L["TANKING_TOOLS_PARRY_MINE_DESC"] =
	"Meldet, wenn ein Gegner deine Angriffe pariert. Das Auswahlmenü daneben legt fest, wohin die Zeile geht."
L["TANKING_TOOLS_PARRY_OTHERS"] = "Parierte Angriffe anderer"
L["TANKING_TOOLS_PARRY_OTHERS_DESC"] =
	"Meldet, wenn ein Gegner die Angriffe von jemand anderem in deiner Gruppe pariert. Das Auswahlmenü daneben legt fest, wohin die Zeile geht."
L["TANKING_TOOLS_PARRY_IGNORE_TANKS"] = "Tanks ignorieren"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS_DESC"] =
	"Bleibt still, wenn der parierte Spieler ein Tank ist: im Schlachtzug als Haupttank eingeteilt oder in einer Gruppe mit der Tank-Rolle aus der Gruppensuche. Ein Zweittank steht für einen Spottwechsel vor dem Boss, und das ist kein Fehler, für den man jemanden anflüstern sollte. Deine eigenen parierten Angriffe werden weiterhin gemeldet."
L["TANKING_TOOLS_PARRY_IGNORE_PETS"] = "Begleiter ignorieren"
L["TANKING_TOOLS_PARRY_IGNORE_PETS_DESC"] =
	"Bleibt still, wenn der parierte Angriff von einem Begleiter kam, auch von deinem eigenen. Ein Begleiter steht dort, wo sein Besitzer ihn hingeschickt hat, und eine Zeile mit dem Namen des Begleiters gibt niemandem in der Gruppe etwas zu tun. Begleiter werden so oder so nie angeflüstert."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Den Übeltäter anflüstern"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Schickt dem Übeltäter eine Nachricht mit der Bitte, sich hinter den Gegner zu stellen. Es wird nur eine geschickt, auch wenn mehrere Leute in deiner Gruppe Control Freak nutzen."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Wie lange ein Übeltäter verschont bleibt, nachdem er eine Parierwarnung ausgelöst hat. Das gilt für die Anzeige, den Ton, die Ansage und das Flüstern, denn wer sich noch nicht bewegt hat, muss es nicht bei jedem Schlag gesagt bekommen."

L["TANKING_TOOLS_NOVA_HEADER"] = "Frostnovas"
L["TANKING_TOOLS_NOVA_DESC"] =
	"Meldet eine Frostnova, die eine Gegnergruppe dort festfriert, wo sie steht, außer Reichweite des Tanks."
L["TANKING_TOOLS_NOVA_ENABLE"] = "Frostnovas melden"
L["TANKING_TOOLS_NOVA_MINE"] = "Meine Frostnovas"
L["TANKING_TOOLS_NOVA_OTHERS"] = "Frostnovas anderer"

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
L["UNKNOWN_SOURCE"] = "Jemand"
L["UNKNOWN_CASTER"] = "einem unbekannten Zaubernden"
L["UNKNOWN_TARGET"] = "ein unbekanntes Ziel"
L["UNKNOWN_SPELL"] = "einen unbekannten Zauber"

L["TAUNT_SUCCESS"] = "Spott! %s hat %s auf %s eingesetzt."
L["TAUNT_AOE"] = "Flächenspott! %s hat %s eingesetzt."
L["TAUNT_MISSED"] = "Spott fehlgeschlagen! %s hat %s auf %s eingesetzt: verfehlt."
L["TAUNT_RESISTED"] = "Spott fehlgeschlagen! %s hat %s auf %s eingesetzt: widerstanden."
--[[
    The one failure format that leads with the MOB rather than the taunter,
    because the immunity is the news and the other three formats have no news
    beyond "it did not land".

    TRANSLATORS: %s is, in order: mob, taunter, taunt. This is the ONLY taunt
    format whose first %s is not the player who cast it.
]]
L["TAUNT_IMMUNE"] = "Spott fehlgeschlagen! %s ist immun: %s hat %s eingesetzt."
L["TAUNT_FAILED"] = "Spott fehlgeschlagen! %s hat %s auf %s eingesetzt: misslungen."
L["INTERRUPT"] = "Unterbrechung! %s hat mit %s auf %s %s unterbrochen."

L["FEAR_SUCCESS"] = "Furcht! %s hat %s auf %s eingesetzt."
L["FEAR_AOE"] = "Flächenfurcht! %s hat %s eingesetzt."

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
L["INCAPACITATED"] = "%s für %s handlungsunfähig; %s erleidet %s (%s) von %s."
L["INCAPACITATED_PLAIN"] = "%s für %s handlungsunfähig; %s erleidet %s von %s."
L["INCAPACITATED_INDEFINITE"] = "%s handlungsunfähig; %s erleidet %s (%s) von %s."
L["INCAPACITATED_PLAIN_INDEFINITE"] = "%s handlungsunfähig; %s erleidet %s von %s."

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
L["INCAPACITATED_ROLE_HEALER"] = "Heiler"

--[[
    The length, as its own phrase rather than a bare number with "seconds" in the
    format, so the singular does not need two more formats beside the four
    above. Always a whole number: the handler rounds UP, because a fear reported
    as 5.9 promises a taunt back sooner than it is coming.

    TRANSLATORS: the handler reads exactly these two, the first for 1 and the
    second for every other count, so a language with more number forms words
    the second to read for any count. An abbreviated unit does.
]]
L["INCAPACITATED_SECOND"] = "%d Sekunde"
L["INCAPACITATED_SECONDS"] = "%d Sekunden"

--[[
    The four debuff types a player can take off. They name the class that can
    help -- Magic is a priest or paladin, Curse a mage or druid -- so they are
    the half of the line a tank cannot act on alone.

    TRANSLATORS: use the client's own words for these, the ones on the debuff
    tooltips, not a literal translation of the English.
]]
L["DISPEL_MAGIC"] = "Magie"
L["DISPEL_CURSE"] = "Fluch"
L["DISPEL_DISEASE"] = "Krankheit"
L["DISPEL_POISON"] = "Gift"

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
L["TANK_DEATHS_TANK_LINE"] = "Tank am Boden! %s ist gestorben."
L["TANK_DEATHS_CLASS_LINE"] = "%s am Boden! %s ist gestorben."

--[[
    Kept short on purpose: they render with a real spell link and two real names
    inside the 255 byte chat limit, and the widest locale runs close to twice the
    English.

    The WARNING carries no explanation and the WHISPER carries all of it. The
    warning fires mid-pull in front of a tank who already knows what a shield
    does; the whisper goes to the healer who does not, and is read after the
    fact. The tab description explains it at length for whoever wants it.
]]
L["SHIELD_WARNING"] = "Schlechter Schild! %s hat %s auf %s gewirkt."
L["SHIELD_WHISPER"] =
	"Schlechter Schild! Bitte vermeide es, %s auf %s zu wirken. Diese Fähigkeit hindert Tanks daran, Wut aufzubauen."

L["BAD_PET"] = "Böser Begleiter! Der Begleiter von %s, %s, hat %s auf %s eingesetzt."
L["BAD_PET_AOE"] = "Böser Begleiter! Der Begleiter von %s, %s, hat %s eingesetzt."
L["BAD_PET_UNKNOWN_OWNER"] = "Böser Begleiter! %s hat %s auf %s eingesetzt."
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Böser Begleiter! %s hat %s eingesetzt."
--[[
    Kept short on purpose. They render with a spell link and up to two names inside
    a 255 byte chat limit, and the widest locale runs close to twice the English.
]]
L["BAD_PET_WHISPER"] =
	"Dein Begleiter %s hat %s auf %s eingesetzt. Ein Rechtsklick auf die Fähigkeit schaltet das automatische Wirken ab."
L["BAD_PET_WHISPER_AOE"] =
	"Dein Begleiter %s hat %s eingesetzt. Ein Rechtsklick auf die Fähigkeit schaltet das automatische Wirken ab."

L["COLD_OPENER_MISS"] = "Vorsicht! %s hat %s auf %s eingesetzt: verfehlt."
L["COLD_OPENER_DODGE"] = "Vorsicht! %s hat %s auf %s eingesetzt: ausgewichen."
L["COLD_OPENER_PARRY"] = "Vorsicht! %s hat %s auf %s eingesetzt: pariert."
L["COLD_OPENER_BLOCK"] = "Vorsicht! %s hat %s auf %s eingesetzt: geblockt."
L["COLD_OPENER_IMMUNE"] = "Vorsicht! %s hat %s auf %s eingesetzt: ignoriert."
L["COLD_OPENER_RESIST"] = "Vorsicht! %s hat %s auf %s eingesetzt: widerstanden."

L["ARMOR_REPORT"] = "Rüstung abgebaut! %s war nach %s Sekunden verwundbar."

L["PARRY_WARNING"] = "Parierhast! %s steht vor %s."
L["PARRY_WHISPER"] =
	"Parierhast! Bitte stell dich hinter %s: Jedes Parieren beschleunigt den nächsten Schlag des Gegners."

L["NOVA"] = "Nova! %s hat %s auf %s eingesetzt."
L["NOVA_AOE"] = "Flächennova! %s hat %s eingesetzt."
