local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "itIT")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"Annunciatore di combattimento per provocazioni, interruzioni, paure, morti del difensore, famigli cattivi, parate, penalità all'armatura e altri eventi critici dello scontro. Tieni traccia di chi ha provocato, di cosa è fallito, di chi ha interrotto un lancio e di cosa è successo, con avvisi personalizzabili."
L["VERSION"] = "Versione"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Versione %s. Le impostazioni (compresa l'opzione per disattivare questo messaggio) si trovano in Opzioni > Add-on > Control Freak. Ti piace l'add-on? Parlane a un amico! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Per precauzione, il pannello delle opzioni non si può aprire durante il combattimento."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Attiva il messaggio di benvenuto"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Mostra il saluto di Control Freak quando accedi."
L["ENABLE_MINIMAP_BUTTON"] = "Attiva il pulsante sulla minimappa"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Mostra il pulsante di Control Freak sulla tua minimappa."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Apre il pannello delle opzioni di questo add-on."

--[[
    The add-on's own switch, above every feature's. The title names its REACH
    rather than the act of throwing it, which is what a player cannot read off
    the box beside it -- every other toggle on this panel governs one thing.

    Its ENABLE description is shared with the mini-map button's line for the same
    toggle, so the two cannot describe it differently.
]]
L["KILL_SWITCH"] = "Tutti gli avvisi"
L["KILL_SWITCH_SUMMARY"] =
	"Un unico interruttore per ogni avviso di ogni scheda: spegnerlo azzittisce l'add-on senza cambiare una sola impostazione, e un clic col pulsante sinistro sul pulsante della minimappa fa lo stesso da qualunque punto."
L["KILL_SWITCH_ENABLE"] = "Attiva Control Freak"
L["KILL_SWITCH_ENABLE_DESC"] = "Attiva o disattiva tutti gli avvisi di Control Freak."

L["FEEDBACK_HEADER"] = "Commenti e supporto"
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
L["STATE_ON"] = "Attivato"
L["STATE_OFF"] = "Disattivato"
L["LEFT_CLICK"] = "Pulsante sinistro"
L["RIGHT_CLICK"] = "Pulsante destro"
L["SHIFT_MIDDLE_CLICK"] = "MAIUSC + pulsante centrale"
L["ACTION_TOGGLE"] = "Attiva/Disattiva"
L["MINIMAP_OPTIONS"] = "Opzioni di Control Freak"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

-- In tab order.
L["TAB_TAUNTS"] = "Provocazioni"
L["TAB_INTERRUPTS"] = "Interruzioni"
L["TAB_FEARS"] = "Paure"
L["TAB_INCAPACITATED"] = "Inabilitato"
L["TAB_TANK_DEATHS"] = "Morti del difensore"
L["TAB_BAD_PRIESTS"] = "Sacerdoti cattivi"
L["TAB_BAD_PETS"] = "Famigli cattivi"
L["TAB_TANKING_TOOLS"] = "Strumenti di difesa"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Attiva o disattiva questa funzione."
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
L["SCOPE_ROLE_TANK"] = "Come difensore"
L["SCOPE_ROLE_HEALER"] = "Come guaritore"
L["SCOPE_ROLE_TANK_HEALER"] = "Come difensore o guaritore"
L["SCOPE_ROLE_ALWAYS"] = "Sempre"
L["SCOPE_ROLE_DESC"] =
	"Il ruolo che devi ricoprire perché questa funzione dica qualcosa. Conti come difensore se in un'incursione sei incaricato come difensore principale, o se in un gruppo hai selezionato il ruolo di difensore nella Ricerca gruppi. In un'incursione il ruolo di difensore non conta nulla. Conti come guaritore solo se hai selezionato il ruolo di guaritore nella Ricerca gruppi, perché per chi cura non esiste un incarico d'incursione. \"Sempre\" mette da parte la domanda e scatta qualunque ruolo tu abbia."
L["SCOPE_GROUP_HAS_TANK"] = "Quando il gruppo ha un difensore"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Scatta solo mentre qualcuno del tuo gruppo fa da difensore ed è ancora vivo. In un'incursione questo significa un difensore principale incaricato, quindi per Control Freak un'incursione senza nessuno incaricato non ha difensori. Un difensore a terra conta come nessun difensore, perché è proprio allora che chiunque altro tenga la minaccia sta dando una mano."
L["SCOPE_INSTANCE_ONLY"] = "Quando sei in un'istanza"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Scatta solo nelle spedizioni e nelle incursioni."

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
L["ALERT_SECTION_ENABLE_DESC"] = "Attiva o disattiva questo avviso."
L["ALERT_SOUND"] = "Riproduci un suono"
L["ALERT_SOUND_DESC"] = "Riproduce un suono quando questo avviso scatta."
L["ALERT_SOUND_FILE_DESC"] = "Scegli il suono che questo avviso riproduce. Quando ne scegli uno, lo senti subito."
L["ALERT_SOUND_PREVIEW_DESC"] = "Riproduce subito questo suono, che il suono sia attivo o no."
L["SOUND_NONE"] = "Nessuno"

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
	"Segnala i tuoi lanci, compresi quelli del tuo famiglio. Il menu a tendina accanto indica dove va la riga."
L["ALERT_OTHERS_DESC"] =
	"Segnala i lanci di tutti gli altri nel tuo gruppo. Il menu a tendina accanto indica dove va la riga."
L["ALERT_OUTPUT_PRINT"] = "Mostra (solo a me)"
L["ALERT_OUTPUT_ANNOUNCE"] = "Annuncia"
L["ALERT_OUTPUT_DESC"] =
	"Dove va questa riga: in un posto solo, mai in entrambi. Mostra (solo a me) la scrive nella tua finestra e non costa niente a nessuno. Annuncia invece la manda nella chat di gruppo o d'incursione, e raccontare a tutta l'incursione quello che fanno gli altri è il modo in cui un add-on si rende antipatico, quindi pensaci bene. Annuncia resta in silenzio quando non sei in un gruppo, e nei campi di battaglia e nelle arene."
L["ALERT_AGAINST_DESC"] =
	'Quali nemici contano: ogni scelta include anche quelle che la seguono. I boss sono i nemici di livello teschio (??). Un boss di spedizione non ha un teschio suo, quindi conta come élite: "Élite del tuo livello+ e boss" è la scelta che lo tiene scartando la marmaglia di livello inferiore che lo circonda. Un\'icona del bersaglio prevale su tutto questo finché la casella "Avvisa sempre sui bersagli contrassegnati" è spuntata.'
L["TARGET_RUNG_ALL"] = "Tutti i nemici"
L["TARGET_RUNG_ELITE"] = "Élite e boss"
L["TARGET_RUNG_ELITE_0"] = "Élite del tuo livello+ e boss"
L["TARGET_RUNG_BOSS"] = "Boss"
L["ALERT_MARKED_ALWAYS"] = "Avvisa sempre sui bersagli contrassegnati"
L["ALERT_MARKED_ALWAYS_DESC"] =
	"Un bersaglio contrassegnato con un'icona (teschio, croce, una qualsiasi delle otto) conta a prescindere da quello che dice il menu a tendina accanto all'interruttore. Le icone sono il modo in cui un gruppo indica i nemici che contano, quindi un bersaglio che qualcuno ha contrassegnato non viene mai scartato per rango o livello sbagliato."

--[[
    The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
    list of seconds. Whole minutes read as minutes, and zero reads as "No
    Cooldown" rather than "0 Second Cooldown".

    TRANSLATORS: one format serves every count it is given, one minute and five
    alike, so word each to read for any number. An abbreviated unit does.
]]
L["COOLDOWN_NONE"] = "Nessun tempo di recupero"
L["COOLDOWN_SECONDS"] = "%d s di recupero"
L["COOLDOWN_MINUTES"] = "%d min di recupero"

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
L["SAMPLE_EXAMPLE"] = "Esempio: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "Marco"
L["SAMPLE_PET"] = "Fido"

--[[
    The Naxxramas bosses the Example lines name, dealt one per line.

    TRANSLATORS: use each boss's name exactly as your client writes it, title
    included, not a translation of the English.
]]
L["SAMPLE_BOSS_ANUBREKHAN"] = "Anub'rekhan"
L["SAMPLE_BOSS_FAERLINA"] = "Faerlina la Vedova Nera"
L["SAMPLE_BOSS_MAEXXNA"] = "Maexxna"
L["SAMPLE_BOSS_NOTH"] = "Noth l'Araldo della Piaga"
L["SAMPLE_BOSS_HEIGAN"] = "Heigan l'Impuro"
L["SAMPLE_BOSS_LOATHEB"] = "Loatheb"
L["SAMPLE_BOSS_RAZUVIOUS"] = "Istruttore Razuvious"
L["SAMPLE_BOSS_GOTHIK"] = "Gothik il Falciatore"
L["SAMPLE_BOSS_MOGRAINE"] = "Gran Signore Mograine"
L["SAMPLE_BOSS_KORTHAZZ"] = "Thane Korth'azz"
L["SAMPLE_BOSS_BLAUMEUX"] = "Dama Blaumeux"
L["SAMPLE_BOSS_ZELIEK"] = "Ser Zeliek"
L["SAMPLE_BOSS_PATCHWERK"] = "Pezzacarne"
L["SAMPLE_BOSS_GROBBULUS"] = "Grobbulus"
L["SAMPLE_BOSS_GLUTH"] = "Gluth"
L["SAMPLE_BOSS_THADDIUS"] = "Thaddius"
L["SAMPLE_BOSS_SAPPHIRON"] = "Zaffirion"
L["SAMPLE_BOSS_KELTHUZAD"] = "Kel'Thuzad"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "Oggetti"
L["ABILITIES_CLASS_PET"] = "%s (famiglio)"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] = "Le provocazioni sono abilità che tolgono la minaccia a chiunque la stia tenendo."
L["TAUNTS_ENABLE"] = "Attiva il monitoraggio delle provocazioni"

L["TAUNTS_SUCCESS_HEADER"] = "Provocazioni riuscite"
L["TAUNTS_SUCCESS_DESC"] =
	"Una provocazione andata a segno che ha tolto il nemico a qualcun altro. Una provocazione su un nemico che sta già colpendo chi provoca è un rinnovo della minaccia, non un salvataggio, quindi quelle restano in silenzio."
L["TAUNTS_SUCCESS_ENABLE"] = "Segnala le provocazioni riuscite contro"
L["TAUNTS_SUCCESS_MINE"] = "Le mie provocazioni riuscite"
L["TAUNTS_SUCCESS_OTHERS"] = "Provocazioni riuscite degli altri"

L["TAUNTS_FAILED_HEADER"] = "Provocazioni fallite"
L["TAUNTS_FAILED_DESC"] =
	"Una provocazione che ha mancato il colpo, a cui il nemico ha resistito o che ha colpito qualcosa di immune. Il nemico non ha cambiato padrone, e niente sullo schermo te lo dice."
L["TAUNTS_FAILED_ENABLE"] = "Segnala le provocazioni fallite contro"
L["TAUNTS_FAILED_MINE"] = "Le mie provocazioni fallite"
L["TAUNTS_FAILED_OTHERS"] = "Provocazioni fallite degli altri"

L["TAUNTS_AOE_HEADER"] = "Provocazioni ad area"
L["TAUNTS_AOE_DESC"] =
	"Una provocazione che agguanta in un colpo solo tutto ciò che ha intorno, anziché un solo bersaglio."
L["TAUNTS_AOE_ENABLE"] = "Segnala le provocazioni ad area"
L["TAUNTS_AOE_MINE"] = "Le mie provocazioni ad area"
L["TAUNTS_AOE_OTHERS"] = "Provocazioni ad area degli altri"

L["TAUNTS_ABILITIES_HEADER"] = "Abilità di provocazione"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "Abilità di provocazione ad area"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "Le interruzioni fermano un incantesimo nemico a metà del lancio."
L["INTERRUPTS_ENABLE"] = "Attiva il monitoraggio delle interruzioni"

L["INTERRUPTS_ALERT_HEADER"] = "Interruzioni riuscite"
L["INTERRUPTS_ALERT_DESC"] = "Un lancio fermato a metà. Indica chi l'ha fermato e che cosa ha fermato."
L["INTERRUPTS_ALERT_ENABLE"] = "Segnala le interruzioni riuscite contro"
L["INTERRUPTS_ALERT_MINE"] = "Le mie interruzioni riuscite"
L["INTERRUPTS_ALERT_OTHERS"] = "Interruzioni riuscite degli altri"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Le paure mettono in fuga i nemici e li sparpagliano per tutta la stanza."
L["FEARS_ENABLE"] = "Attiva il monitoraggio delle paure"

L["FEARS_ALERT_HEADER"] = "Paure riuscite"
L["FEARS_ALERT_DESC"] =
	"Una paura andata a segno che ha sparpagliato i nemici fuori dalla portata del difensore. Conta solo quando va a segno: un semplice lancio, una resistenza e un'immunità non spostano niente, quindi nessuno dei tre viene segnalato."
L["FEARS_ALERT_ENABLE"] = "Segnala le paure riuscite"
L["FEARS_ALERT_MINE"] = "Le mie paure riuscite"
L["FEARS_ALERT_OTHERS"] = "Paure riuscite degli altri"

L["FEARS_ABILITIES_HEADER"] = "Abilità di paura"

--------------------------------------------------------------------------------
-- Incapacitated
--------------------------------------------------------------------------------

L["INCAPACITATED_SUMMARY"] =
	"Avvisa il gruppo nel momento in cui perdi il controllo del personaggio, così qualcun altro può coprirti. Un difensore impaurito e un guaritore silenziato sono le due persone che più hanno bisogno di dirlo, e le due meno in grado di farlo in quel momento."
L["INCAPACITATED_ENABLE"] = "Attiva il monitoraggio della perdita di controllo"

L["INCAPACITATED_HEADER"] = "Perdita di controllo"
L["INCAPACITATED_DESC"] =
	"Avvisa il gruppo quando subisci uno stordimento, una paura, un silenzio, o quando qualcos'altro ti mette fuori gioco: cosa ti ha colpito, chi l'ha lanciato, quanto dura e se qualcuno può rimuoverlo."
--[[
    No trailing preposition and nothing beside it: this alert has no target
    ladder, and its "Long" threshold is a row of its own, above the two rows it
    names.
]]
L["INCAPACITATED_ALERT_ENABLE"] = "Segnala quando perdi il controllo"
--[[
    The only pair of rows in the add-on that is not My and Others'. The game
    reports the player's own losses of control and nobody else's, so "whose"
    has one answer; how LONG it lasts is the question with two.

    TRANSLATORS: keep the quotes around Long in the caption. They mark it as the
    word the two rows below are named after rather than as an adjective.
]]
L["INCAPACITATED_LONG_CAPTION"] = 'Minimo per perdita di controllo "lunga"'
L["INCAPACITATED_LONG_CAPTION_DESC"] =
	"Quanto deve durare una perdita di controllo per contare come lunga. Tutto ciò che dura meno è breve. Nessuna delle due viene scartata. Le due righe qui sotto dicono dove va ciascuna, e di serie puntano a posti diversi."
-- The caption's dropdown: the first reads for 1 only, the second for 2 to 10.
L["INCAPACITATED_THRESHOLD_ONE"] = "%d secondo"
L["INCAPACITATED_THRESHOLD"] = "%d secondi"
L["INCAPACITATED_SHORT"] = "La mia perdita di controllo breve"
L["INCAPACITATED_SHORT_DESC"] =
	"Dove va la riga quando resti fuori gioco per meno della durata qui sopra. Di serie viene mostrata nella tua finestra: uno stordimento da cui ti riprendi prima che qualcuno possa coprirti spiega il recupero globale che hai appena perso, e non è un problema di nessun altro."
L["INCAPACITATED_LONG"] = "La mia perdita di controllo lunga"
L["INCAPACITATED_LONG_DESC"] =
	"Dove va la riga quando resti fuori gioco almeno per la durata qui sopra. Di serie viene annunciata: è quella su cui qualcun altro ha il tempo di intervenire, e tu sei l'unica persona che non può dirlo. Un effetto senza alcuna durata, come un Controllo Mentale, conta come lungo."

L["INCAPACITATED_STUN"] = "Includi stordimenti"
L["INCAPACITATED_STUN_DESC"] = "Perdita totale del controllo, restando immobile. Il sonno conta come stordimento."
L["INCAPACITATED_FEAR"] = "Includi paure"
L["INCAPACITATED_FEAR_DESC"] = "Perdita totale del controllo, correndo in direzioni casuali. Il nemico ti segue."
L["INCAPACITATED_CHARM"] = "Includi controllo mentale"
L["INCAPACITATED_CHARM_DESC"] =
	"Completamente sotto il controllo di qualcun altro. Di solito la cosa peggiore di questo elenco, e di solito a tempo indeterminato."
L["INCAPACITATED_CONFUSE"] = "Includi confusione"
L["INCAPACITATED_CONFUSE_DESC"] = "Perdita totale del controllo, camminando in direzioni casuali."
L["INCAPACITATED_SILENCE"] = "Includi silenzi"
L["INCAPACITATED_SILENCE_DESC"] =
	"Impossibile lanciare incantesimi. La provocazione di un druido o di un paladino è un incantesimo, quindi questa è una provocazione che non arriverà."
L["INCAPACITATED_PACIFY"] = "Includi pacificazioni"
L["INCAPACITATED_PACIFY_DESC"] = "Impossibile attaccare, anche se gli incantesimi funzionano ancora."
L["INCAPACITATED_SCHOOL_INTERRUPT"] = "Includi incantesimi bloccati"
L["INCAPACITATED_SCHOOL_INTERRUPT_DESC"] =
	"Impossibile lanciare incantesimi di una scuola. Utile se provochi con un incantesimo, perché un druido o un paladino con la Natura o il Sacro bloccati resta senza provocazione."
L["INCAPACITATED_ROOT"] = "Includi immobilizzazioni"
L["INCAPACITATED_ROOT_DESC"] =
	"Impossibile muoversi. Un difensore immobilizzato ha ancora il pulsante della provocazione, quindi il nemico non va da nessuna parte."
L["INCAPACITATED_DISARM"] = "Includi disarmi"
L["INCAPACITATED_DISARM_DESC"] =
	"Impossibile attaccare con le armi. Come per le immobilizzazioni, il pulsante della provocazione funziona ancora."

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
	"Il difensore del tuo gruppo è morto. È l'unica morte che cambia ciò che tutti gli altri devono fare subito dopo, e quaranta ritratti d'incursione sono il posto peggiore per accorgersene."
L["TANK_DEATHS_ENABLE"] = "Attiva il monitoraggio delle morti del difensore"

L["TANK_DEATHS_ALERT_HEADER"] = "Morti del difensore"
L["TANK_DEATHS_ALERT_DESC"] =
	"In un'incursione conta solo i giocatori incaricati come difensore principale, te compreso, e lì un ruolo della Ricerca gruppi non conta nulla. In un gruppo conta chiunque abbia selezionato il ruolo di difensore nella Ricerca gruppi. Un difensore senza nessuno dei due muore senza essere segnalato."
L["TANK_DEATHS_ALERT_ENABLE"] = "Segnala le morti del difensore"
L["TANK_DEATHS_ALERT_MINE"] = "La mia morte"
L["TANK_DEATHS_ALERT_MINE_DESC"] =
	"Segnala la tua morte mentre fai da difensore. Il menu a tendina accanto indica dove va la riga."
L["TANK_DEATHS_ALERT_OTHERS"] = "Morti degli altri difensori"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] =
	"Segnala la morte di chiunque altro nel tuo gruppo stia facendo da difensore. Il menu a tendina accanto indica dove va la riga."

L["TANK_DEATHS_CLASS_HEADER"] = "Morti per classe"
L["TANK_DEATHS_CLASS_DESC"] = "Tutte le altre morti, per classe, per quelle che vuoi tenere d'occhio."
L["TANK_DEATHS_CLASS_ROW_DESC"] = "Segnala la morte di un membro del tuo gruppo di classe %s."

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] =
	"Guaritori che fanno qualcosa che danneggia un difensore più di quanto lo aiuti. Solo in Classic e Burning Crusade: la Stagione della Scoperta restituisce la rabbia tramite una runa del sacerdote, e nelle versioni successive del gioco niente di tutto questo è un problema."
L["BAD_PRIESTS_ENABLE"] = "Attiva il monitoraggio dei sacerdoti cattivi"

L["BAD_PRIESTS_HEADER"] = "Scudi sbagliati"
L["BAD_PRIESTS_DESC"] =
	"Segnala una Parola del Potere: Scudo che finisce su un druido o un guerriero che fa da difensore. La rabbia viene dai danni subiti, e i danni assorbiti da uno scudo non ne generano, quindi uno scudo lanciato con le migliori intenzioni lascia il difensore senza la rabbia con cui tiene la minaccia."
L["BAD_PRIESTS_ALERT_ENABLE"] = "Segnala gli scudi sbagliati"
L["BAD_PRIESTS_HEALTH_DESC"] =
	'Quanto deve scendere la salute del difensore prima che uno scudo smetta di essere un errore. Uno scudo su qualcuno che sta per morire è la scelta giusta, quindi l\'avviso resta in silenzio sotto il livello che scegli qui. Scegli "Sempre" per ricevere un avviso a ogni scudo.'
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "Sempre"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "Dal %d%% di salute in su"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "Avvisi di scudo sbagliato"
L["BAD_PRIESTS_REPORT_DESC"] =
	"Dove va l'avviso quando qualcuno mette uno scudo su un difensore che usa la rabbia. Qui non c'è una riga per te e una per gli altri: il lancio è del guaritore e il problema è del difensore."
L["BAD_PRIESTS_SELF_ONLY"] = "Quando sei un difensore druido o guerriero"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"Avvisa solo degli scudi che finiscono su di te, e solo mentre sei un druido o un guerriero che fa da difensore. Disattiva questa opzione per ricevere avvisi anche sugli scudi lanciati su chiunque nel tuo gruppo faccia da difensore con una di queste classi."
L["BAD_PRIESTS_WHISPER"] = "Sussurra all'incantatore"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"Manda a chi ha lanciato lo scudo un messaggio che spiega perché è controproducente. Ne parte uno solo anche quando più persone nel tuo gruppo usano Control Freak."
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"Per quanto tempo lo stesso incantatore non viene più segnalato dopo aver fatto scattare un avviso di scudo. Vale per la riga mostrata, il suono, l'annuncio e il sussurro, perché un guaritore che lancia lo scudo appena è pronto non deve riempirti la finestra."

--------------------------------------------------------------------------------
-- Bad Pets
--------------------------------------------------------------------------------

L["BAD_PETS_SUMMARY"] = "Famigli di cacciatori e stregoni con abilità di minaccia lasciate in lancio automatico."
L["BAD_PETS_ENABLE"] = "Attiva il monitoraggio dei famigli cattivi"

L["BAD_PETS_ALERT_HEADER"] = "Provocazioni dei famigli"
L["BAD_PETS_ALERT_DESC"] =
	"Un famiglio che strappa il nemico al difensore con il lancio automatico lasciato attivo, di solito senza che il padrone se ne accorga."
L["BAD_PETS_ALERT_ENABLE"] = "Segnala le provocazioni dei famigli contro"
L["BAD_PETS_ALERT_MINE"] = "Le provocazioni del mio famiglio"
L["BAD_PETS_ALERT_OTHERS"] = "Provocazioni dei famigli degli altri"
L["BAD_PETS_WHISPER_ENABLE"] = "Sussurra al padrone del famiglio"
L["BAD_PETS_WHISPER_ENABLE_DESC"] =
	"Manda al padrone del famiglio un messaggio che spiega come disattivare il lancio automatico. Ne parte uno solo anche quando più persone nel tuo gruppo usano Control Freak."
L["BAD_PETS_COOLDOWN_DESC"] =
	"Per quanto tempo lo stesso famiglio non viene più segnalato dopo aver fatto scattare un avviso. Vale per la riga mostrata, il suono, l'annuncio e il sussurro, così un famiglio con il lancio automatico attivo non ti riempie la finestra e il suo padrone non riceve un sussurro ogni pochi secondi."

L["BAD_PETS_ABILITIES_HEADER"] = "Abilità dei famigli cattivi"

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
L["TANKING_TOOLS_ENABLE"] = "Attiva gli strumenti di difesa"
L["TANKING_TOOLS_MINIMAP_SUMMARY"] = "Aperture a vuoto, penalità all'armatura, parate ed esplosioni gelide."

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Aperture a vuoto"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Segnala i tuoi attacchi d'apertura che non sono andati a segno: un colpo mancato, una schivata, una parata, un blocco, una resistenza o un'immunità nei primi secondi di uno scontro. Minaccia mai generata, proprio nel momento in cui conta di più."
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Segnala le aperture a vuoto contro"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "Le mie aperture a vuoto"
L["TANKING_TOOLS_COLD_OPENER_MINE_DESC"] =
	"Segnala le tue abilità d'apertura che non sono andate a segno. Il menu a tendina accanto indica dove va la riga."
-- The caption before the window dropdown: "Within [10 Seconds of Fight]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "Entro i primi"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d secondi di scontro"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Per quanto tempo, dall'inizio di uno scontro, un'abilità evitata conta ancora. Il cronometro parte la prima volta che Control Freak vede quel nemico, e contano solo le abilità: un attacco automatico va a vuoto troppo spesso per fare notizia."

L["TANKING_TOOLS_ARMOR_HEADER"] = "Penalità all'armatura"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Riferisce quanto ci ha messo il gruppo ad abbattere l'armatura di un bersaglio: cinque accumuli di Incrinatura o uno Smantella Armatura di un ladro. Spunta una delle righe Includi qui sotto e aspetterà anche quella penalità, ma solo se nel gruppo c'è qualcuno che può davvero lanciarla."
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Segnala le penalità all'armatura contro"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "Rapporti sulle penalità all'armatura"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	"Dove va il rapporto una volta che il gruppo ha abbattuto l'armatura di un bersaglio. Qui non c'è una riga per te e una per gli altri: è il lavoro del gruppo, riferito a te."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Includi Fuoco Fatato"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Aspetta Fuoco Fatato prima di riferire, in qualunque forma lo lanci il druido. Ignorato quando nel gruppo non c'è un druido."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Includi Maledizione dell'Avventatezza"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Aspetta Maledizione dell'Avventatezza prima di riferire. Ignorata quando nel gruppo non c'è uno stregone."

L["TANKING_TOOLS_PARRY_HEADER"] = "Parate"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Chi si fa parare un colpo da un nemico che non sta tenendo gli sta davanti. Ogni parata accelera il colpo successivo di quel nemico contro chi lo sta tenendo."
L["TANKING_TOOLS_PARRY_ENABLE"] = "Segnala le parate contro"
L["TANKING_TOOLS_PARRY_MINE"] = "Le mie parate"
L["TANKING_TOOLS_PARRY_MINE_DESC"] =
	"Segnala un nemico che para i tuoi attacchi. Il menu a tendina accanto indica dove va la riga."
L["TANKING_TOOLS_PARRY_OTHERS"] = "Parate degli altri"
L["TANKING_TOOLS_PARRY_OTHERS_DESC"] =
	"Segnala un nemico che para gli attacchi di chiunque altro nel tuo gruppo. Il menu a tendina accanto indica dove va la riga."
L["TANKING_TOOLS_PARRY_IGNORE_TANKS"] = "Ignora i difensori"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS_DESC"] =
	"Resta in silenzio quando chi si fa parare è un difensore: incaricato come difensore principale in un'incursione, o con il ruolo di difensore della Ricerca gruppi in un gruppo. Un secondo difensore sta davanti al boss per uno scambio di provocazione, e non è un errore su cui mandargli un sussurro. Le tue parate vengono comunque segnalate."
L["TANKING_TOOLS_PARRY_IGNORE_PETS"] = "Ignora i famigli"
L["TANKING_TOOLS_PARRY_IGNORE_PETS_DESC"] =
	"Resta in silenzio quando l'attacco parato viene da un famiglio, il tuo compreso. Un famiglio sta dove il suo padrone l'ha mandato, e una riga che nomina il famiglio non dà niente da fare a nessuno del gruppo. A un famiglio non viene mai mandato un sussurro, in ogni caso."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Sussurra al colpevole"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Manda al colpevole un messaggio che gli chiede di spostarsi dietro al nemico. Ne parte uno solo anche quando più persone nel tuo gruppo usano Control Freak."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Per quanto tempo lo stesso colpevole non viene più segnalato dopo aver fatto scattare un avviso di parata. Vale per la riga mostrata, il suono, l'annuncio e il sussurro, perché a chi non si è ancora spostato non serve sentirselo dire a ogni colpo."

L["TANKING_TOOLS_NOVA_HEADER"] = "Esplosioni gelide"
L["TANKING_TOOLS_NOVA_DESC"] =
	"Segnala un'Esplosione Gelida, che blocca i nemici sul posto, fuori dalla portata del difensore."
L["TANKING_TOOLS_NOVA_ENABLE"] = "Segnala le esplosioni gelide"
L["TANKING_TOOLS_NOVA_MINE"] = "Le mie esplosioni gelide"
L["TANKING_TOOLS_NOVA_OTHERS"] = "Esplosioni gelide degli altri"

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
L["UNKNOWN_SOURCE"] = "Qualcuno"
L["UNKNOWN_CASTER"] = "un incantatore sconosciuto"
L["UNKNOWN_TARGET"] = "un bersaglio sconosciuto"
L["UNKNOWN_SPELL"] = "un incantesimo sconosciuto"

L["TAUNT_SUCCESS"] = "Provocazione! %s ha usato %s su %s."
L["TAUNT_AOE"] = "Provocazione ad area! %s ha usato %s."
L["TAUNT_MISSED"] = "Provocazione fallita! %s ha usato %s su %s, ma ha mancato."
L["TAUNT_RESISTED"] = "Provocazione fallita! %s ha usato %s su %s, che ha resistito."
--[[
    The one failure format that leads with the MOB rather than the taunter,
    because the immunity is the news and the other three formats have no news
    beyond "it did not land".

    TRANSLATORS: %s is, in order: mob, taunter, taunt. This is the ONLY taunt
    format whose first %s is not the player who cast it.
]]
L["TAUNT_IMMUNE"] = "Provocazione fallita! %s è immune: %s ha usato %s."
L["TAUNT_FAILED"] = "Provocazione fallita! %s ha usato %s su %s senza effetto."
L["INTERRUPT"] = "Interruzione! %s ha usato %s su %s e ha fermato %s."

L["FEAR_SUCCESS"] = "Paura! %s ha usato %s su %s."
L["FEAR_AOE"] = "Paura ad area! %s ha usato %s."

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
L["INCAPACITATED"] = "%s inabilitato per %s: %s subisce %s (%s) da %s."
L["INCAPACITATED_PLAIN"] = "%s inabilitato per %s: %s subisce %s da %s."
L["INCAPACITATED_INDEFINITE"] = "%s inabilitato: %s subisce %s (%s) da %s."
L["INCAPACITATED_PLAIN_INDEFINITE"] = "%s inabilitato: %s subisce %s da %s."

--[[
    The seat the line opens on, as its own phrase rather than a format per role,
    which would be eight copies of the four above.

    TRANSLATORS: this is the client's own word for the group finder role, and it
    opens a sentence. "Afflicted by" in the formats above is deliberately the
    phrasing Blizzard's combat log uses for a debuff landing
    (AURAADDEDOTHERHARMFUL), so a player reads the same words here as in the log
    they already watch -- use your client's wording for both if it has one.
]]
L["INCAPACITATED_ROLE_TANK"] = "Difensore"
L["INCAPACITATED_ROLE_HEALER"] = "Guaritore"

--[[
    The length, as its own phrase rather than a bare number with "seconds" in the
    format, so the singular does not need two more formats beside the four
    above. Always a whole number: the handler rounds UP, because a fear reported
    as 5.9 promises a taunt back sooner than it is coming.

    TRANSLATORS: the handler reads exactly these two, the first for 1 and the
    second for every other count, so a language with more number forms words
    the second to read for any count. An abbreviated unit does.
]]
L["INCAPACITATED_SECOND"] = "%d secondo"
L["INCAPACITATED_SECONDS"] = "%d secondi"

--[[
    The four debuff types a player can take off. They name the class that can
    help -- Magic is a priest or paladin, Curse a mage or druid -- so they are
    the half of the line a tank cannot act on alone.

    TRANSLATORS: use the client's own words for these, the ones on the debuff
    tooltips, not a literal translation of the English.
]]
L["DISPEL_MAGIC"] = "Magia"
L["DISPEL_CURSE"] = "Maledizione"
L["DISPEL_DISEASE"] = "Malattia"
L["DISPEL_POISON"] = "Veleno"

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
L["TANK_DEATHS_TANK_LINE"] = "Difensore a terra! %s muore."
L["TANK_DEATHS_CLASS_LINE"] = "%s a terra! %s muore."

--[[
    Kept short on purpose: they render with a real spell link and two real names
    inside the 255 byte chat limit, and the widest locale runs close to twice the
    English.

    The WARNING carries no explanation and the WHISPER carries all of it. The
    warning fires mid-pull in front of a tank who already knows what a shield
    does; the whisper goes to the healer who does not, and is read after the
    fact. The tab description explains it at length for whoever wants it.
]]
L["SHIELD_WARNING"] = "Scudo sbagliato! %s ha lanciato %s su %s."
L["SHIELD_WHISPER"] =
	"Scudo sbagliato! Per favore, evita di lanciare %s su %s. Questa abilità impedisce ai difensori di generare rabbia."

L["BAD_PET"] = "Famiglio cattivo! Il famiglio di %s, %s, ha usato %s su %s."
L["BAD_PET_AOE"] = "Famiglio cattivo! Il famiglio di %s, %s, ha usato %s."
L["BAD_PET_UNKNOWN_OWNER"] = "Famiglio cattivo! %s ha usato %s su %s."
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Famiglio cattivo! %s ha usato %s."
--[[
    Kept short on purpose. They render with a spell link and up to two names inside
    a 255 byte chat limit, and the widest locale runs close to twice the English.
]]
L["BAD_PET_WHISPER"] =
	"Il tuo famiglio %s ha usato %s su %s. Clicca col destro sull'abilità per disattivarne il lancio automatico."
L["BAD_PET_WHISPER_AOE"] =
	"Il tuo famiglio %s ha usato %s. Clicca col destro sull'abilità per disattivarne il lancio automatico."

L["COLD_OPENER_MISS"] = "Attenzione! %s ha usato %s, ma ha mancato %s."
L["COLD_OPENER_DODGE"] = "Attenzione! %s ha usato %s, ma %s ha schivato."
L["COLD_OPENER_PARRY"] = "Attenzione! %s ha usato %s, ma %s ha parato."
L["COLD_OPENER_BLOCK"] = "Attenzione! %s ha usato %s, ma %s ha bloccato."
L["COLD_OPENER_IMMUNE"] = "Attenzione! %s ha usato %s, ma %s è immune."
L["COLD_OPENER_RESIST"] = "Attenzione! %s ha usato %s, ma %s ha resistito."

L["ARMOR_REPORT"] = "Armatura abbattuta! %s: vulnerabile in %s secondi."

L["PARRY_WARNING"] = "Celerità da parata! %s sta davanti a %s."
L["PARRY_WHISPER"] =
	"Celerità da parata! Per favore, mettiti dietro a %s: ogni parata accelera il suo colpo successivo."

L["NOVA"] = "Esplosione Gelida! %s ha usato %s su %s."
L["NOVA_AOE"] = "Esplosione Gelida ad area! %s ha usato %s."
