local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "itIT")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] = "Informazioni migliori = tanking migliore. Tanking migliore = incursioni migliori."
L["VERSION"] = "Versione"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Versione %s. Le impostazioni (compresa l'opzione per disattivare questo messaggio) si trovano in Opzioni > AddOns > Control Freak. Ti piace l'addon? Parlane a un amico! (="
L["CHAT_OPTIONS_IN_COMBAT"] =
	"Per precauzione, l'Interfaccia delle Opzioni non può essere aperta durante il combattimento."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Attiva il messaggio di benvenuto"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Mostra il saluto di Control Freak quando accedi."
L["ENABLE_MINIMAP_BUTTON"] = "Attiva il pulsante sulla minimappa"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Mostra il pulsante di Control Freak sulla tua minimappa."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Apre l'Interfaccia delle Opzioni di questo addon."

-- The master switch. Its description is shared with the mini-map button's own
-- line for the same toggle, so the two cannot describe it differently.
L["KILL_SWITCH"] = "Interruttore generale"
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

L["STATE_ON"] = "Attivo"
L["STATE_OFF"] = "Disattivo"
L["LEFT_CLICK"] = "Clic sinistro"
L["RIGHT_CLICK"] = "Clic destro"
L["SHIFT_MIDDLE_CLICK"] = "Maiusc + clic centrale"
L["ACTION_TOGGLE"] = "Commuta"
L["MINIMAP_OPTIONS"] = "Opzioni di Control Freak"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

L["TAB_TAUNTS"] = "Provocazioni"
L["TAB_INTERRUPTS"] = "Interruzioni"
L["TAB_FEARS"] = "Paure"
L["TAB_BAD_PET"] = "Famiglio molesto"
L["TAB_TANKING_TOOLS"] = "Strumenti da tank"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Attiva o disattiva questa funzione."
L["SCOPE_TANK_ROLE_ONLY"] = "Solo quando giochi da tank"
L["SCOPE_TANK_ROLE_ONLY_DESC"] =
	"Scatta solo mentre stai tankando, come Tank Principale dell'incursione oppure con il ruolo Tank selezionato nel cercagruppo. Senza nessuno dei due, questa funzione resta in silenzio."
L["SCOPE_GROUP_HAS_TANK"] = "Solo quando il gruppo ha un tank"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Scatta solo mentre qualcuno del tuo gruppo sta tankando ed è ancora vivo. Un tank a terra vale come nessun tank, perché è proprio allora che avere qualcun altro a tenere la minaccia aiuta."
L["SCOPE_INSTANCE_ONLY"] = "Solo nelle istanze"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Scatta solo dentro spedizioni e incursioni."

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
L["ALERT_SECTION_ENABLE_DESC"] = "Attiva o disattiva questo avviso."
L["ALERT_PRINT"] = "Mostra le notifiche"
L["ALERT_PRINT_DESC"] = "Mostra questo avviso nella tua finestra di chat."
L["ALERT_PRINT_SCOPE_DESC"] =
	"Di chi sono le magie che arrivano nella tua finestra. Miei copre te e il tuo famiglio; Tutti copre chiunque nel tuo gruppo. Anche il suono segue questa impostazione, così non sentirai mai un avviso che non puoi vedere."
L["ALERT_ANNOUNCE"] = "Annuncia al gruppo"
L["ALERT_ANNOUNCE_DESC"] =
	"Manda questo avviso nella chat del tuo gruppo o della tua incursione. Raccontare a tutta l'incursione quello che fanno gli altri è il modo più rapido con cui un addon si rende antipatico, quindi vale la pena pensarci prima di attivarlo."
L["ALERT_ANNOUNCE_SCOPE_DESC"] =
	"Di chi sono le magie che finiscono nella chat di gruppo o d'incursione. Miei copre te e il tuo famiglio; Tutti copre chiunque nel tuo gruppo, te compreso."
L["ALERT_SCOPE_MINE"] = "Miei"
L["ALERT_SCOPE_ALL"] = "Tutti"
L["ALERT_BOSS_ONLY"] = "Solo contro boss ed élite"
L["ALERT_BOSS_ONLY_DESC"] =
	"Scatta solo contro i nemici che meritano attenzione: boss d'incursione, boss di spedizione e qualsiasi élite di livello superiore al tuo."
L["ALERT_SOUND"] = "Suono"
L["ALERT_SOUND_DESC"] = "Riproduce un suono quando questo avviso scatta."
L["ALERT_SOUND_FILE_DESC"] = "Scegli il suono che riproduce questo avviso. Sceglierne uno lo riproduce."
L["ALERT_SOUND_PREVIEW_DESC"] = "Riproduce questo suono adesso, che il suono sia attivo o no."
L["SOUND_NONE"] = "Nessuno"

-- The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
-- list of seconds. Whole minutes read as minutes, and zero reads as "No
-- Cooldown" rather than "0 Second Cooldown".
L["COOLDOWN_NONE"] = "Nessun tempo di recupero"
L["COOLDOWN_SECONDS"] = "Tempo di recupero di %d secondi"
L["COOLDOWN_MINUTES"] = "Tempo di recupero di %d minuti"

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
L["SAMPLE_EXAMPLE"] = "Esempio: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "Marco"
L["SAMPLE_PET"] = "Fido"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "Oggetti"
L["ABILITIES_CLASS_PET"] = "Famiglio del %s"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] = "Le provocazioni sono abilità che tolgono la minaccia a chi la sta tenendo."
L["TAUNTS_ENABLE"] = "Attiva il controllo delle provocazioni"

L["TAUNTS_SUCCESS_HEADER"] = "Provocazioni riuscite"
L["TAUNTS_SUCCESS_ENABLE"] = "Attiva le notifiche delle provocazioni riuscite"
L["TAUNTS_SUCCESS_DESC"] =
	"Una provocazione andata a segno che ha tolto il nemico a qualcun altro. Una provocazione su un nemico che stava già picchiando chi provoca è un rinnovo della minaccia e non un salvataggio, quindi quelle restano in silenzio."
L["TAUNTS_FAILED_HEADER"] = "Provocazioni fallite"
L["TAUNTS_FAILED_ENABLE"] = "Attiva le notifiche delle provocazioni fallite"
L["TAUNTS_FAILED_DESC"] =
	"Una provocazione che ha mancato, a cui è stato resistito o che ha colpito qualcosa di immune. Il nemico non ha cambiato padrone, e niente sullo schermo lo dice."
L["TAUNTS_AOE_HEADER"] = "Provocazioni ad area"
L["TAUNTS_AOE_ENABLE"] = "Attiva le notifiche delle provocazioni ad area"
L["TAUNTS_AOE_DESC"] =
	"Una provocazione che agguanta tutto quello che ha intorno in un colpo solo, invece di un solo bersaglio."

L["TAUNTS_ABILITIES_HEADER"] = "Abilità di provocazione"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "Abilità di provocazione ad area"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "Le interruzioni fermano una magia nemica a metà del lancio."
L["INTERRUPTS_ENABLE"] = "Attiva il controllo delle interruzioni"

L["INTERRUPTS_ALERT_HEADER"] = "Interruzioni riuscite"
L["INTERRUPTS_ALERT_ENABLE"] = "Attiva le notifiche delle interruzioni riuscite"
L["INTERRUPTS_ALERT_DESC"] = "Un lancio fermato a metà. Dice chi l'ha fermato e che cosa ha fermato."

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Le paure fanno scappare i nemici e sparpagliano un gruppo di nemici per tutta la stanza."
L["FEARS_ENABLE"] = "Attiva il controllo delle paure"

L["FEARS_ALERT_HEADER"] = "Paure"
L["FEARS_ALERT_ENABLE"] = "Attiva le notifiche delle paure"
L["FEARS_ALERT_DESC"] =
	"Una paura andata a segno che ha sparpagliato i nemici fuori dalla portata del tank. Conta solo quando prende: un semplice lancio, una resistenza e un'immunità non hanno spostato niente, quindi nessuno dei tre viene segnalato."

L["FEARS_ABILITIES_HEADER"] = "Abilità di paura"

--------------------------------------------------------------------------------
-- Bad Pet
--------------------------------------------------------------------------------

-- The summary doubles as the mini-map button's Bad Pet line, so the tab and the
-- tooltip cannot describe the feature differently.
L["BAD_PET_SUMMARY"] = "Famigli di cacciatori e stregoni con le abilità di minaccia lasciate in lancio automatico."
L["BAD_PET_ENABLE"] = "Attiva il controllo dei famigli molesti"

L["BAD_PET_ALERT_HEADER"] = "Provocazioni dei famigli"
L["BAD_PET_ALERT_ENABLE"] = "Attiva le notifiche delle provocazioni dei famigli"
L["BAD_PET_ALERT_DESC"] =
	"Un famiglio che toglie il nemico al tank con il lancio automatico lasciato attivo, di solito senza che il padrone se ne accorga."
L["BAD_PET_WHISPER_ENABLE"] = "Sussurra al padrone"
L["BAD_PET_WHISPER_ENABLE_DESC"] =
	"Manda al padrone del famiglio un messaggio che spiega come disattivare il lancio automatico. Ne parte uno solo anche quando più persone nel tuo gruppo usano Control Freak."
L["BAD_PET_COOLDOWN_DESC"] =
	"Per quanto tempo un famiglio resta in silenzio dopo aver fatto scattare un avviso. Copre il messaggio, il suono, l'annuncio e il sussurro, così un famiglio lasciato in lancio automatico non ti riempie la finestra e il suo padrone non riceve un sussurro ogni pochi secondi."

L["BAD_PET_ABILITIES_HEADER"] = "Abilità dei famigli molesti"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

-- No summary line: the Tanking Tools tab opens on its enable, because the tab is
-- a collection of unrelated warnings rather than one idea a sentence can cover.
-- Each section introduces itself instead.
L["TANKING_TOOLS_ENABLE"] = "Attiva gli strumenti da tank"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Aperture a freddo"
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Attiva le notifiche delle aperture a freddo"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Segnala i tuoi attacchi di apertura che non sono andati a segno: un colpo mancato, una schivata, una parata, un blocco, una resistenza o un'immunità nei primi secondi di uno scontro. Minaccia che non è mai esistita, proprio nel momento in cui conta di più."
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Fino a che punto dello scontro un'abilità evitata conta ancora. Il cronometro parte la prima volta che Control Freak vede quel nemico, e contano solo le abilità: un attacco automatico va a vuoto troppo spesso per fare notizia."
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d secondi di scontro"

L["TANKING_TOOLS_ARMOR_HEADER"] = "Indebolimenti dell'armatura"
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Attiva le notifiche degli indebolimenti dell'armatura"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Riporta quanto ci ha messo il gruppo a scrostare l'armatura di un bersaglio: cinque Frantumare Armatura oppure un Esporre Armatura di un ladro. Attiva un extra qui sotto e aspetterà anche quello, ma solo quando qualcuno nel gruppo può davvero lanciarlo."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Includi Fuoco Fatato"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Aspetta Fuoco Fatato prima di riportare, in qualunque forma lo lanci il druido. Ignorato quando nel gruppo non c'è nessun druido."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Includi Maledizione dell'Imprudenza"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Aspetta Maledizione dell'Imprudenza prima di riportare. Ignorato quando nel gruppo non c'è nessuno stregone."

L["TANKING_TOOLS_PARRY_HEADER"] = "Parate"
L["TANKING_TOOLS_PARRY_ENABLE"] = "Attiva le notifiche delle parate"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Chi si fa parare da un nemico che non sta tankando gli è davanti. Ogni parata accelera il colpo successivo di quel nemico su chi lo sta tenendo."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Sussurra al colpevole"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Manda al colpevole un messaggio che gli chiede di spostarsi dietro al nemico. Ne parte uno solo anche quando più persone nel tuo gruppo usano Control Freak."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Per quanto tempo un colpevole resta in silenzio dopo aver fatto scattare un avviso di parata. Copre il messaggio, il suono, l'annuncio e il sussurro, perché a chi non si è ancora spostato non serve sentirselo dire a ogni colpo."

L["TANKING_TOOLS_NOVA_HEADER"] = "Nove"
L["TANKING_TOOLS_NOVA_ENABLE"] = "Attiva le notifiche delle nove"
L["TANKING_TOOLS_NOVA_DESC"] = "Segnala una Nova di Gelo, che sparpaglia i nemici fuori dalla portata del tank."

--------------------------------------------------------------------------------
-- Message Formats
--------------------------------------------------------------------------------

L["UNKNOWN_SOURCE"] = "Qualcuno"
L["UNKNOWN_TARGET"] = "un bersaglio sconosciuto"
L["UNKNOWN_SPELL"] = "una magia sconosciuta"

L["TAUNT_SUCCESS"] = "Provocazione! %s ha usato %s su %s!"
L["TAUNT_AOE"] = "Provocazione ad area! %s ha usato %s!"
L["TAUNT_MISSED"] = "Provocazione fallita! %s ha usato %s su %s e ha mancato!"
L["TAUNT_RESISTED"] = "Provocazione fallita! %s ha usato %s su %s ed è stata resistita!"
L["TAUNT_IMMUNE"] = "Provocazione fallita! %s ha usato %s su %s senza effetto! %s è immune."
L["TAUNT_FAILED"] = "Provocazione fallita! %s ha usato %s su %s senza effetto!"
L["TAUNT_STOLEN"] = "Ehi, quello è mio! %s ha usato %s su %s!" -- parked; see Data/Default-Settings.lua

L["FEAR_SUCCESS"] = "Paura! %s ha usato %s su %s!"
L["FEAR_AOE"] = "Paura ad area! %s ha usato %s!"

L["INTERRUPT"] = "Interruzione! %s ha usato %s su %s per fermare %s!"

L["COLD_OPENER_MISS"] = "Attento! %s ha usato %s e ha mancato %s!"
L["COLD_OPENER_DODGE"] = "Attento! %s ha usato %s e %s l'ha schivata!"
L["COLD_OPENER_PARRY"] = "Attento! %s ha usato %s e %s l'ha parata!"
L["COLD_OPENER_BLOCK"] = "Attento! %s ha usato %s e %s l'ha bloccata!"
L["COLD_OPENER_IMMUNE"] = "Attento! %s ha usato %s e %s era immune!"
L["COLD_OPENER_RESIST"] = "Attento! %s ha usato %s e %s ha resistito!"

L["ARMOR_REPORT"] = "Armatura di %s scrostata dopo %s secondi!"

L["PARRY_WARNING"] = "Fretta da parata! %s è davanti a %s!"
L["PARRY_WHISPER"] =
	"Ehi, mettiti dietro a %s, per favore. Con la fretta da parata mi stai facendo prendere più danni."

L["NOVA"] = "Nova! %s ha usato %s su %s!"
L["NOVA_AOE"] = "Nova ad area! %s ha usato %s!"
-- parked with the bubbles themselves; still reads "Annoyance!" and wants wording
-- of its own when Bubble Warnings lands. See Data/Abilities.lua.
L["ANNOYANCE_BUBBLE"] = "Che noia! %s ha usato %s su %s al %d%% di salute!"

L["BAD_PET"] = "Famiglio molesto! Il famiglio di %s, %s, ha usato %s su %s!"
L["BAD_PET_AOE"] = "Famiglio molesto! Il famiglio di %s, %s, ha usato %s!"
L["BAD_PET_OWN"] = "Famiglio molesto! Il tuo famiglio %s ha usato %s su %s!"
L["BAD_PET_OWN_AOE"] = "Famiglio molesto! Il tuo famiglio %s ha usato %s!"
L["BAD_PET_UNKNOWN_OWNER"] = "Famiglio molesto! %s ha usato %s su %s!"
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Famiglio molesto! %s ha usato %s!"
L["BAD_PET_WHISPER"] =
	"Il tuo famiglio %s ha usato %s su %s. Fai clic destro sull'abilità nella barra delle azioni del tuo famiglio o nel libro degli incantesimi per disattivare il lancio automatico."
