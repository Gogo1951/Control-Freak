local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "frFR")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] = "De meilleures infos = un meilleur tanking. Un meilleur tanking = de meilleurs raids."
L["VERSION"] = "Version"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Version %s. Les réglages (dont l'option pour désactiver ce message) se trouvent dans Options > AddOns > Control Freak. L'addon vous plaît ? Parlez-en à un ami ! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Par précaution, l'interface des options ne peut pas être ouverte pendant le combat."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Activer le message d'accueil"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Affiche le message d'accueil de Control Freak à la connexion."
L["ENABLE_MINIMAP_BUTTON"] = "Activer le bouton de minicarte"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Affiche le bouton Control Freak sur votre minicarte."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Ouvre l'interface des options de cet addon."

-- The master switch. Its description is shared with the mini-map button's own
-- line for the same toggle, so the two cannot describe it differently.
L["KILL_SWITCH"] = "Coupe-circuit"
L["KILL_SWITCH_ENABLE"] = "Activer Control Freak"
L["KILL_SWITCH_ENABLE_DESC"] = "Active ou désactive toutes les alertes de Control Freak."

L["FEEDBACK_HEADER"] = "Retours et assistance"
L["FEEDBACK_DISCORD"] = "Discord"
L["FEEDBACK_GITHUB"] = "GitHub"
L["FEEDBACK_CURSEFORGE"] = "CurseForge"
L["FEEDBACK_WAGO"] = "Wago"

--------------------------------------------------------------------------------
-- Mini-map Button
--------------------------------------------------------------------------------

L["STATE_ON"] = "Activé"
L["STATE_OFF"] = "Désactivé"
L["LEFT_CLICK"] = "Clic gauche"
L["RIGHT_CLICK"] = "Clic droit"
L["SHIFT_MIDDLE_CLICK"] = "Maj + clic du milieu"
L["ACTION_TOGGLE"] = "Basculer"
L["MINIMAP_OPTIONS"] = "Options de Control Freak"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

L["TAB_TAUNTS"] = "Provocations"
L["TAB_INTERRUPTS"] = "Interruptions"
L["TAB_FEARS"] = "Peurs"
L["TAB_BAD_PET"] = "Vilain familier"
L["TAB_TANKING_TOOLS"] = "Outils de tank"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Active ou désactive cette fonction."
L["SCOPE_TANK_ROLE_ONLY"] = "Uniquement quand vous jouez tank"
L["SCOPE_TANK_ROLE_ONLY_DESC"] =
	"Ne se déclenche que pendant que vous tankez, soit en tant que Tank principal du raid, soit avec le rôle de Tank sélectionné dans l'outil de groupe. Sans l'un ni l'autre, cette fonction reste silencieuse."
L["SCOPE_GROUP_HAS_TANK"] = "Uniquement quand le groupe a un tank"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Ne se déclenche que pendant que quelqu'un de votre groupe tanke et est encore en vie. Un tank au sol compte comme aucun tank, car c'est justement là que quelqu'un d'autre tenant la menace rend service."
L["SCOPE_INSTANCE_ONLY"] = "Uniquement en instance"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Ne se déclenche que dans les donjons et les raids."

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
L["ALERT_SECTION_ENABLE_DESC"] = "Active ou désactive cette alerte."
L["ALERT_PRINT"] = "Afficher les notifications"
L["ALERT_PRINT_DESC"] = "Affiche cette alerte dans votre propre fenêtre de discussion."
L["ALERT_PRINT_SCOPE_DESC"] =
	"Les sorts de qui arrivent dans votre fenêtre. Les miens vous couvre, vous et votre propre familier ; Tous couvre tout le monde dans votre groupe. Le son suit ce réglage lui aussi, pour que vous n'entendiez jamais une alerte que vous ne pouvez pas voir."
L["ALERT_ANNOUNCE"] = "Annoncer au groupe"
L["ALERT_ANNOUNCE_DESC"] =
	"Envoie cette alerte dans la discussion de votre groupe ou de votre raid. Commenter ce que font les autres devant tout le raid est le moyen le plus rapide pour un addon de lasser son monde, celle-ci mérite donc réflexion avant d'être activée."
L["ALERT_ANNOUNCE_SCOPE_DESC"] =
	"Les sorts de qui partent dans la discussion de groupe ou de raid. Les miens vous couvre, vous et votre propre familier ; Tous couvre tout le monde dans votre groupe, vous compris."
L["ALERT_SCOPE_MINE"] = "Les miens"
L["ALERT_SCOPE_ALL"] = "Tous"
L["ALERT_BOSS_ONLY"] = "Uniquement contre les boss et les élites"
L["ALERT_BOSS_ONLY_DESC"] =
	"Ne se déclenche que contre les ennemis qui méritent l'attention : boss de raid, boss de donjon et tout élite au-dessus de votre propre niveau."
L["ALERT_SOUND"] = "Son"
L["ALERT_SOUND_DESC"] = "Joue un son quand cette alerte se déclenche."
L["ALERT_SOUND_FILE_DESC"] = "Choisissez le son que joue cette alerte. En choisir un le joue."
L["ALERT_SOUND_PREVIEW_DESC"] = "Joue ce son maintenant, que le son soit activé ou non."
L["SOUND_NONE"] = "Aucun"

-- The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
-- list of seconds. Whole minutes read as minutes, and zero reads as "No
-- Cooldown" rather than "0 Second Cooldown".
L["COOLDOWN_NONE"] = "Aucun temps de recharge"
L["COOLDOWN_SECONDS"] = "Temps de recharge de %d secondes"
L["COOLDOWN_MINUTES"] = "Temps de recharge de %d minutes"

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
L["SAMPLE_EXAMPLE"] = "Exemple : %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "Jean"
L["SAMPLE_PET"] = "Médor"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "Objets"
L["ABILITIES_CLASS_PET"] = "Familier de %s"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] = "Les provocations sont des capacités qui prennent la menace à celui qui la détient."
L["TAUNTS_ENABLE"] = "Activer la surveillance des provocations"

L["TAUNTS_SUCCESS_HEADER"] = "Provocations réussies"
L["TAUNTS_SUCCESS_ENABLE"] = "Activer les notifications de provocations réussies"
L["TAUNTS_SUCCESS_DESC"] =
	"Une provocation qui a fonctionné et a repris l'ennemi à quelqu'un d'autre. Une provocation sur un ennemi qui tapait déjà sur celui qui provoque est un rafraîchissement de menace plutôt qu'un sauvetage, celles-là restent donc silencieuses."
L["TAUNTS_FAILED_HEADER"] = "Provocations ratées"
L["TAUNTS_FAILED_ENABLE"] = "Activer les notifications de provocations ratées"
L["TAUNTS_FAILED_DESC"] =
	"Une provocation qui a raté, qui a été résistée ou qui a touché quelque chose d'immunisé. L'ennemi n'a pas changé de mains, et rien à l'écran ne le dit."
L["TAUNTS_AOE_HEADER"] = "Provocations de zone"
L["TAUNTS_AOE_ENABLE"] = "Activer les notifications de provocations de zone"
L["TAUNTS_AOE_DESC"] = "Une provocation qui attrape tout ce qui l'entoure d'un coup, au lieu d'une seule cible."

L["TAUNTS_ABILITIES_HEADER"] = "Capacités de provocation"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "Capacités de provocation de zone"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "Les interruptions arrêtent un sort ennemi en plein incantation."
L["INTERRUPTS_ENABLE"] = "Activer la surveillance des interruptions"

L["INTERRUPTS_ALERT_HEADER"] = "Interruptions réussies"
L["INTERRUPTS_ALERT_ENABLE"] = "Activer les notifications d'interruptions réussies"
L["INTERRUPTS_ALERT_DESC"] =
	"Une incantation arrêtée en cours de route. Indique qui l'a arrêtée et ce qui a été arrêté."

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Les peurs font fuir les ennemis et éparpillent un pull dans toute la salle."
L["FEARS_ENABLE"] = "Activer la surveillance des peurs"

L["FEARS_ALERT_HEADER"] = "Peurs"
L["FEARS_ALERT_ENABLE"] = "Activer les notifications de peurs"
L["FEARS_ALERT_DESC"] =
	"Une peur qui a fonctionné et a éparpillé le pull hors de portée du tank. Seule compte la peur qui prend : une simple incantation, une résistance et une immunité n'ont rien déplacé, aucune d'elles n'est donc signalée."

L["FEARS_ABILITIES_HEADER"] = "Capacités de peur"

--------------------------------------------------------------------------------
-- Bad Pet
--------------------------------------------------------------------------------

-- The summary doubles as the mini-map button's Bad Pet line, so the tab and the
-- tooltip cannot describe the feature differently.
L["BAD_PET_SUMMARY"] =
	"Familiers de chasseur et de démoniste dont les capacités de menace sont restées en lancement automatique."
L["BAD_PET_ENABLE"] = "Activer la surveillance des vilains familiers"

L["BAD_PET_ALERT_HEADER"] = "Provocations de familier"
L["BAD_PET_ALERT_ENABLE"] = "Activer les notifications de provocations de familier"
L["BAD_PET_ALERT_DESC"] =
	"Un familier qui reprend l'ennemi au tank avec le lancement automatique laissé actif, en général sans que son maître s'en aperçoive."
L["BAD_PET_WHISPER_ENABLE"] = "Chuchoter au maître"
L["BAD_PET_WHISPER_ENABLE_DESC"] =
	"Envoie au maître du familier un mot expliquant comment couper le lancement automatique. Un seul est envoyé, même si plusieurs personnes de votre groupe utilisent Control Freak."
L["BAD_PET_COOLDOWN_DESC"] =
	"Combien de temps un familier reste silencieux après avoir déclenché une alerte. Cela couvre l'affichage, le son, l'annonce et le chuchotement, pour qu'un familier laissé en lancement automatique ne remplisse pas votre fenêtre et que son maître ne reçoive pas un chuchotement toutes les quelques secondes."

L["BAD_PET_ABILITIES_HEADER"] = "Capacités de vilain familier"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

-- No summary line: the Tanking Tools tab opens on its enable, because the tab is
-- a collection of unrelated warnings rather than one idea a sentence can cover.
-- Each section introduces itself instead.
L["TANKING_TOOLS_ENABLE"] = "Activer les outils de tank"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Ouvertures à froid"
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Activer les notifications d'ouvertures à froid"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Signale vos propres attaques d'ouverture qui n'ont pas abouti : un raté, une esquive, une parade, un blocage, une résistance ou une immunité dans les premières secondes d'un pull. De la menace qui n'a jamais existé, au moment où elle compte le plus."
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Jusqu'où dans un pull une capacité évitée compte encore. Le chrono démarre la première fois que Control Freak voit cet ennemi, et seules les capacités comptent : une attaque automatique rate bien trop souvent pour faire l'événement."
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d secondes de combat"

L["TANKING_TOOLS_ARMOR_HEADER"] = "Affaiblissements d'armure"
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Activer les notifications d'affaiblissements d'armure"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Indique combien de temps le groupe a mis à décaper l'armure d'une cible : cinq Fracasser armure ou un Exposer l'armure de voleur. Activez un supplément ci-dessous et il attendra celui-ci aussi, mais seulement quand quelqu'un du groupe peut vraiment le lancer."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Inclure Flamme de féerie"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Attend Flamme de féerie avant de faire son rapport, quelle que soit la forme sous laquelle le druide la lance. Ignoré quand il n'y a aucun druide dans le groupe."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Inclure Malédiction de témérité"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Attend Malédiction de témérité avant de faire son rapport. Ignoré quand il n'y a aucun démoniste dans le groupe."

L["TANKING_TOOLS_PARRY_HEADER"] = "Parades"
L["TANKING_TOOLS_PARRY_ENABLE"] = "Activer les notifications de parades"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Celui qui se fait parer par un ennemi qu'il ne tanke pas se tient devant lui. Chaque parade accélère le prochain coup de cet ennemi sur celui qui le tient."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Chuchoter au fautif"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Envoie au fautif un mot lui demandant de se placer derrière l'ennemi. Un seul est envoyé, même si plusieurs personnes de votre groupe utilisent Control Freak."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Combien de temps un fautif reste silencieux après avoir déclenché un avertissement de parade. Cela couvre l'affichage, le son, l'annonce et le chuchotement, car quelqu'un qui n'a pas encore bougé n'a pas besoin qu'on le lui dise à chaque coup."

L["TANKING_TOOLS_NOVA_HEADER"] = "Novas de givre"
L["TANKING_TOOLS_NOVA_ENABLE"] = "Activer les notifications de novas de givre"
L["TANKING_TOOLS_NOVA_DESC"] = "Signale une Nova de givre, qui éparpille un pull hors de portée du tank."

--------------------------------------------------------------------------------
-- Message Formats
--------------------------------------------------------------------------------

L["UNKNOWN_SOURCE"] = "Quelqu'un"
L["UNKNOWN_TARGET"] = "une cible inconnue"
L["UNKNOWN_SPELL"] = "un sort inconnu"

L["TAUNT_SUCCESS"] = "Provocation ! %s a utilisé %s sur %s !"
L["TAUNT_AOE"] = "Provocation de zone ! %s a utilisé %s !"
L["TAUNT_MISSED"] = "Provocation ratée ! %s a utilisé %s sur %s et a raté !"
L["TAUNT_RESISTED"] = "Provocation ratée ! %s a utilisé %s sur %s et a été résistée !"
L["TAUNT_IMMUNE"] = "Provocation ratée ! %s a utilisé %s sur %s sans effet ! %s est immunisé."
L["TAUNT_FAILED"] = "Provocation ratée ! %s a utilisé %s sur %s sans effet !"
L["TAUNT_STOLEN"] = "Hé, c'est le mien ! %s a utilisé %s sur %s !" -- parked; see Data/Default-Settings.lua

L["FEAR_SUCCESS"] = "Peur ! %s a utilisé %s sur %s !"
L["FEAR_AOE"] = "Peur de zone ! %s a utilisé %s !"

L["INTERRUPT"] = "Interruption ! %s a utilisé %s sur %s pour arrêter %s !"

L["COLD_OPENER_MISS"] = "Attention ! %s a lancé %s et a raté %s !"
L["COLD_OPENER_DODGE"] = "Attention ! %s a lancé %s et %s l'a esquivé !"
L["COLD_OPENER_PARRY"] = "Attention ! %s a lancé %s et %s l'a paré !"
L["COLD_OPENER_BLOCK"] = "Attention ! %s a lancé %s et %s l'a bloqué !"
L["COLD_OPENER_IMMUNE"] = "Attention ! %s a lancé %s et %s y était immunisé !"
L["COLD_OPENER_RESIST"] = "Attention ! %s a lancé %s et %s y a résisté !"

L["ARMOR_REPORT"] = "Armure de %s décapée après %s secondes !"

L["PARRY_WARNING"] = "Hâte de parade ! %s se tient devant %s !"
L["PARRY_WHISPER"] =
	"Hé, place-toi derrière %s, s'il te plaît. À cause de la hâte de parade, tu me fais prendre plus de dégâts."

L["NOVA"] = "Nova ! %s a utilisé %s sur %s !"
L["NOVA_AOE"] = "Nova de zone ! %s a utilisé %s !"
-- parked with the bubbles themselves; still reads "Annoyance!" and wants wording
-- of its own when Bubble Warnings lands. See Data/Abilities.lua.
L["ANNOYANCE_BUBBLE"] = "Pénible ! %s a utilisé %s sur %s à %d%% de vie !"

L["BAD_PET"] = "Vilain familier ! Le familier de %s, %s, a utilisé %s sur %s !"
L["BAD_PET_AOE"] = "Vilain familier ! Le familier de %s, %s, a utilisé %s !"
L["BAD_PET_OWN"] = "Vilain familier ! Votre familier %s a utilisé %s sur %s !"
L["BAD_PET_OWN_AOE"] = "Vilain familier ! Votre familier %s a utilisé %s !"
L["BAD_PET_UNKNOWN_OWNER"] = "Vilain familier ! %s a utilisé %s sur %s !"
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Vilain familier ! %s a utilisé %s !"
L["BAD_PET_WHISPER"] =
	"Ton familier %s a utilisé %s sur %s. Fais un clic droit sur la capacité dans la barre d'action de ton familier ou dans ton grimoire pour couper le lancement automatique."
