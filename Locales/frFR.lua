local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "frFR")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"Annonceur de combat pour les provocations, les interruptions, les peurs, les morts de tank, les vilains familiers, les parades, les affaiblissements d'armure et d'autres événements critiques du combat. Suivez qui a provoqué, ce qui a échoué, qui a interrompu une incantation et ce qui s'est passé, grâce à des alertes personnalisables."
L["VERSION"] = "Version"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Version %s. Les réglages (dont l'option pour désactiver ce message) se trouvent dans Options > AddOns > Control Freak. L'add-on vous plaît ? Parlez-en à un ami ! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Par mesure de sécurité, la fenêtre des options ne peut pas être ouverte en combat."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Activer le message d'accueil"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Affiche le message d'accueil de Control Freak à la connexion."
L["ENABLE_MINIMAP_BUTTON"] = "Activer le bouton de la minicarte"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Affiche le bouton Control Freak sur votre minicarte."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Ouvre la fenêtre des options de cet add-on."

--[[
    The add-on's own switch, above every feature's. The title names its REACH
    rather than the act of throwing it, which is what a player cannot read off
    the box beside it -- every other toggle on this panel governs one thing.

    Its ENABLE description is shared with the mini-map button's line for the same
    toggle, so the two cannot describe it differently.
]]
L["KILL_SWITCH"] = "Toutes les alertes"
L["KILL_SWITCH_SUMMARY"] =
	"Un seul interrupteur pour toutes les alertes de tous les onglets : le couper rend l'add-on silencieux sans modifier le moindre réglage, et un clic gauche sur le bouton de la minicarte fait la même chose depuis n'importe où."
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

--[[
    "Enabled" and "Disabled" rather than the shorter pair, matching the other
    add-ons in the family.
]]
L["STATE_ON"] = "Activé"
L["STATE_OFF"] = "Désactivé"
L["LEFT_CLICK"] = "Clic gauche"
L["RIGHT_CLICK"] = "Clic droit"
L["SHIFT_MIDDLE_CLICK"] = "Maj + clic du milieu"
L["ACTION_TOGGLE"] = "Activer/désactiver"
L["MINIMAP_OPTIONS"] = "Options de Control Freak"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

-- In tab order.
L["TAB_TAUNTS"] = "Provocations"
L["TAB_INTERRUPTS"] = "Interruptions"
L["TAB_FEARS"] = "Peurs"
L["TAB_INCAPACITATED"] = "Neutralisé"
L["TAB_TANK_DEATHS"] = "Morts de tank"
L["TAB_BAD_PRIESTS"] = "Vilains prêtres"
L["TAB_BAD_PETS"] = "Vilains familiers"
L["TAB_TANKING_TOOLS"] = "Outils de tank"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Active ou désactive cette fonction."
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
L["SCOPE_ROLE_TANK"] = "Comme tank"
L["SCOPE_ROLE_HEALER"] = "Comme soigneur"
L["SCOPE_ROLE_TANK_HEALER"] = "Comme tank ou soigneur"
L["SCOPE_ROLE_ALWAYS"] = "Toujours"
L["SCOPE_ROLE_DESC"] =
	"Le rôle que vous devez occuper pour que cette fonction dise quoi que ce soit. Vous comptez comme tank quand vous êtes désigné tank principal dans un raid, ou quand vous avez sélectionné le rôle Tank dans la recherche de groupe au sein d'un groupe. En raid, le rôle Tank ne compte pour rien. Vous comptez comme soigneur uniquement quand vous avez sélectionné le rôle Soigneur dans la recherche de groupe, car il n'existe pas d'assignation de raid pour les soins. Avec \"Toujours\", la question ne se pose plus : la fonction se déclenche quel que soit votre rôle."
L["SCOPE_GROUP_HAS_TANK"] = "Quand le groupe a un tank"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Ne se déclenche que lorsqu'un membre de votre groupe tanke et est encore en vie. En raid, cela veut dire un tank principal désigné : pour Control Freak, un raid sans tank principal n'a pas de tank. Un tank à terre revient à ne pas avoir de tank, car c'est justement là que quelqu'un d'autre qui tient la menace rend service."
L["SCOPE_INSTANCE_ONLY"] = "Quand vous êtes en instance"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Ne se déclenche que dans les donjons et les raids."

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
L["ALERT_SECTION_ENABLE_DESC"] = "Active ou désactive cette alerte."
L["ALERT_SOUND"] = "Jouer un son"
L["ALERT_SOUND_DESC"] = "Joue un son quand cette alerte se déclenche."
L["ALERT_SOUND_FILE_DESC"] = "Choisissez le son joué par cette alerte. En sélectionner un le fait entendre."
L["ALERT_SOUND_PREVIEW_DESC"] = "Joue ce son maintenant, que le son soit activé ou non."
L["SOUND_NONE"] = "Aucun"

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
	"Signale vos propres sorts, y compris ceux de votre familier. Le menu déroulant à côté indique où va la ligne."
L["ALERT_OTHERS_DESC"] =
	"Signale les sorts de tous les autres membres de votre groupe. Le menu déroulant à côté indique où va la ligne."
L["ALERT_OUTPUT_PRINT"] = "Afficher (moi seulement)"
L["ALERT_OUTPUT_ANNOUNCE"] = "Annoncer"
L["ALERT_OUTPUT_DESC"] =
	'Où va cette ligne : un seul endroit, jamais les deux. "Afficher (moi seulement)", c\'est votre propre fenêtre, et cela ne coûte rien à personne. "Annoncer" l\'envoie plutôt sur le canal de groupe ou de raid, et commenter les faits et gestes des autres devant tout le raid, c\'est ainsi qu\'un add-on finit par lasser tout le monde : ce choix mérite donc réflexion. "Annoncer" reste muet quand vous n\'êtes pas en groupe, ainsi que dans les champs de bataille et les arènes.'
L["ALERT_AGAINST_DESC"] =
	'Quels ennemis comptent, chaque choix incluant ceux qui le suivent. Les boss sont les ennemis de niveau crâne (??). Un boss de donjon n\'affiche pas de crâne, il compte donc parmi les élites : "Élites de votre niv+ et boss" est le choix qui le garde tout en écartant le menu fretin de niveau inférieur au vôtre qui l\'entoure. Une marque de raid l\'emporte sur tout cela tant que la case "Toujours alerter sur les cibles marquées" est cochée.'
L["TARGET_RUNG_ALL"] = "Tout"
L["TARGET_RUNG_ELITE"] = "Élites et boss"
L["TARGET_RUNG_ELITE_0"] = "Élites de votre niv+ et boss"
L["TARGET_RUNG_BOSS"] = "Boss"
L["ALERT_MARKED_ALWAYS"] = "Toujours alerter sur les cibles marquées"
L["ALERT_MARKED_ALWAYS_DESC"] =
	"Une cible portant une marque de raid (crâne, croix, n'importe laquelle des huit) compte, quoi qu'indique le menu déroulant à côté de l'interrupteur de la section. Les marques servent au groupe à désigner le pull qui compte : une cible que quelqu'un a marquée n'est donc jamais écartée pour un mauvais rang ou un mauvais niveau."

--[[
    The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
    list of seconds. Whole minutes read as minutes, and zero reads as "No
    Cooldown" rather than "0 Second Cooldown".

    TRANSLATORS: one format serves every count it is given, one minute and five
    alike, so word each to read for any number. An abbreviated unit does.
]]
L["COOLDOWN_NONE"] = "Aucune recharge"
L["COOLDOWN_SECONDS"] = "%d s de recharge"
L["COOLDOWN_MINUTES"] = "%d min de recharge"

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
L["SAMPLE_EXAMPLE"] = "Exemple : %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "Jean"
L["SAMPLE_PET"] = "Médor"

--[[
    The Naxxramas bosses the Example lines name, dealt one per line.

    TRANSLATORS: use each boss's name exactly as your client writes it, title
    included, not a translation of the English.
]]
L["SAMPLE_BOSS_ANUBREKHAN"] = "Anub'Rekhan"
L["SAMPLE_BOSS_FAERLINA"] = "Grande veuve Faerlina"
L["SAMPLE_BOSS_MAEXXNA"] = "Maexxna"
L["SAMPLE_BOSS_NOTH"] = "Noth le Porte-peste"
L["SAMPLE_BOSS_HEIGAN"] = "Heigan l'Impur"
L["SAMPLE_BOSS_LOATHEB"] = "Horreb"
L["SAMPLE_BOSS_RAZUVIOUS"] = "Instructeur Razuvious"
L["SAMPLE_BOSS_GOTHIK"] = "Gothik le Moissonneur"
L["SAMPLE_BOSS_MOGRAINE"] = "Généralissime Mograine"
L["SAMPLE_BOSS_KORTHAZZ"] = "Thane Korth'azz"
L["SAMPLE_BOSS_BLAUMEUX"] = "Dame Blaumeux"
L["SAMPLE_BOSS_ZELIEK"] = "Sire Zeliek"
L["SAMPLE_BOSS_PATCHWERK"] = "Le Recousu"
L["SAMPLE_BOSS_GROBBULUS"] = "Grobbulus"
L["SAMPLE_BOSS_GLUTH"] = "Gluth"
L["SAMPLE_BOSS_THADDIUS"] = "Thaddius"
L["SAMPLE_BOSS_SAPPHIRON"] = "Saphiron"
L["SAMPLE_BOSS_KELTHUZAD"] = "Kel'Thuzad"

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
L["TAUNTS_SUCCESS_DESC"] =
	"Une provocation qui a porté et a repris l'ennemi à quelqu'un d'autre. Une provocation sur un ennemi qui frappait déjà son auteur n'est qu'un rafraîchissement de menace, pas un sauvetage : celles-là ne sont donc pas signalées."
L["TAUNTS_SUCCESS_ENABLE"] = "Signaler les provocations réussies sur"
L["TAUNTS_SUCCESS_MINE"] = "Mes provocations réussies"
L["TAUNTS_SUCCESS_OTHERS"] = "Provocations réussies des autres"

L["TAUNTS_FAILED_HEADER"] = "Provocations ratées"
L["TAUNTS_FAILED_DESC"] =
	"Une provocation qui a raté, à laquelle l'ennemi a résisté ou qui a touché une cible insensible. L'ennemi n'a pas changé de mains, et rien à l'écran ne l'indique."
L["TAUNTS_FAILED_ENABLE"] = "Signaler les provocations ratées sur"
L["TAUNTS_FAILED_MINE"] = "Mes provocations ratées"
L["TAUNTS_FAILED_OTHERS"] = "Provocations ratées des autres"

L["TAUNTS_AOE_HEADER"] = "Provocations de zone"
L["TAUNTS_AOE_DESC"] = "Une provocation qui attire tout ce qui l'entoure d'un coup, plutôt qu'une seule cible."
L["TAUNTS_AOE_ENABLE"] = "Signaler les provocations de zone"
L["TAUNTS_AOE_MINE"] = "Mes provocations de zone"
L["TAUNTS_AOE_OTHERS"] = "Provocations de zone des autres"

L["TAUNTS_ABILITIES_HEADER"] = "Capacités de provocation"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "Capacités de provocation de zone"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "Les interruptions stoppent un sort ennemi en pleine incantation."
L["INTERRUPTS_ENABLE"] = "Activer la surveillance des interruptions"

L["INTERRUPTS_ALERT_HEADER"] = "Interruptions réussies"
L["INTERRUPTS_ALERT_DESC"] =
	"Une incantation stoppée en cours de route. Indique qui l'a interrompue et ce qui a été interrompu."
L["INTERRUPTS_ALERT_ENABLE"] = "Signaler les interruptions réussies sur"
L["INTERRUPTS_ALERT_MINE"] = "Mes interruptions réussies"
L["INTERRUPTS_ALERT_OTHERS"] = "Interruptions réussies des autres"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Les peurs font fuir les ennemis et éparpillent un pull dans toute la salle."
L["FEARS_ENABLE"] = "Activer la surveillance des peurs"

L["FEARS_ALERT_HEADER"] = "Peurs réussies"
L["FEARS_ALERT_DESC"] =
	"Une peur qui a porté et a éparpillé le pull hors de portée du tank. Seule la peur qui porte compte : une simple incantation, une résistance ou une immunité ne déplacent rien, aucune n'est donc signalée."
L["FEARS_ALERT_ENABLE"] = "Signaler les peurs réussies"
L["FEARS_ALERT_MINE"] = "Mes peurs réussies"
L["FEARS_ALERT_OTHERS"] = "Peurs réussies des autres"

L["FEARS_ABILITIES_HEADER"] = "Capacités de peur"

--------------------------------------------------------------------------------
-- Incapacitated
--------------------------------------------------------------------------------

L["INCAPACITATED_SUMMARY"] =
	"Prévient votre groupe dès que vous perdez le contrôle de votre personnage, pour que quelqu'un d'autre puisse prendre le relais. Un tank apeuré et un soigneur réduit au silence sont les deux personnes qui ont le plus besoin de le signaler, et les deux qui en sont le moins capables sur le moment."
L["INCAPACITATED_ENABLE"] = "Activer la surveillance des neutralisations"

L["INCAPACITATED_HEADER"] = "Être neutralisé"
L["INCAPACITATED_DESC"] =
	"Prévient le groupe quand vous êtes étourdi, apeuré, réduit au silence ou mis hors jeu d'une autre façon : ce qui vous a touché, qui l'a lancé, combien de temps cela dure et si quelqu'un peut le dissiper."
--[[
    No trailing preposition and nothing beside it: this alert has no target
    ladder, and its "Long" threshold is a row of its own, above the two rows it
    names.
]]
L["INCAPACITATED_ALERT_ENABLE"] = "Signaler quand vous êtes neutralisé"
--[[
    The only pair of rows in the add-on that is not My and Others'. The game
    reports the player's own losses of control and nobody else's, so "whose"
    has one answer; how LONG it lasts is the question with two.

    TRANSLATORS: keep the quotes around Long in the caption. They mark it as the
    word the two rows below are named after rather than as an adjective.
]]
L["INCAPACITATED_LONG_CAPTION"] = 'Neutralisation "longue" à partir de'
L["INCAPACITATED_LONG_CAPTION_DESC"] =
	"Durée qu'une perte de contrôle doit atteindre pour compter comme longue. En dessous, elle est courte. Aucune n'est ignorée : les deux lignes ci-dessous indiquent où va chacune, et elles sont réglées par défaut sur des destinations différentes."
-- The caption's dropdown: the first reads for 1 only, the second for 2 to 10.
L["INCAPACITATED_THRESHOLD_ONE"] = "%d seconde"
L["INCAPACITATED_THRESHOLD"] = "%d secondes"
L["INCAPACITATED_SHORT"] = "Ma neutralisation courte"
L["INCAPACITATED_SHORT_DESC"] =
	"Où va la ligne quand vous êtes mis hors jeu moins longtemps que la durée ci-dessus. Par défaut, elle s'affiche dans votre propre fenêtre : un étourdissement dont vous êtes sorti avant que quiconque ait pu vous couvrir explique le temps de recharge global que vous venez de perdre, et ne concerne personne d'autre."
L["INCAPACITATED_LONG"] = "Ma neutralisation longue"
L["INCAPACITATED_LONG_DESC"] =
	"Où va la ligne quand vous êtes mis hors jeu au moins aussi longtemps que la durée ci-dessus. Par défaut, elle est annoncée : c'est celle sur laquelle quelqu'un d'autre a le temps d'agir, et vous êtes la seule personne à ne pas pouvoir le dire. Un effet sans aucune durée, comme un Contrôle mental, compte comme une neutralisation longue."

L["INCAPACITATED_STUN"] = "Inclure les étourdissements"
L["INCAPACITATED_STUN_DESC"] = "Perte totale de contrôle, sur place. Le sommeil compte comme un étourdissement."
L["INCAPACITATED_FEAR"] = "Inclure les peurs"
L["INCAPACITATED_FEAR_DESC"] = "Perte totale de contrôle, en courant au hasard. L'ennemi vous suit."
L["INCAPACITATED_CHARM"] = "Inclure le contrôle mental"
L["INCAPACITATED_CHARM_DESC"] =
	"Entièrement sous le contrôle de quelqu'un d'autre. En général le pire de cette liste, et le plus souvent sans limite de durée."
L["INCAPACITATED_CONFUSE"] = "Inclure la désorientation"
L["INCAPACITATED_CONFUSE_DESC"] = "Perte totale de contrôle, en marchant au hasard."
L["INCAPACITATED_SILENCE"] = "Inclure les silences"
L["INCAPACITATED_SILENCE_DESC"] =
	"Impossible de lancer des sorts. La provocation d'un druide ou d'un paladin est un sort : c'est donc une provocation qui ne viendra pas."
L["INCAPACITATED_PACIFY"] = "Inclure les pacifications"
L["INCAPACITATED_PACIFY_DESC"] = "Impossible d'attaquer, mais les sorts fonctionnent encore."
L["INCAPACITATED_SCHOOL_INTERRUPT"] = "Inclure les verrouillages de sorts"
L["INCAPACITATED_SCHOOL_INTERRUPT_DESC"] =
	"Impossible de lancer les sorts d'une école. Utile si vous provoquez avec un sort, car un druide ou un paladin verrouillé en Nature ou en Sacré n'a plus de provocation."
L["INCAPACITATED_ROOT"] = "Inclure les immobilisations"
L["INCAPACITATED_ROOT_DESC"] =
	"Impossible de bouger. Un tank immobilisé a toujours son bouton de provocation, l'ennemi ne va donc nulle part."
L["INCAPACITATED_DISARM"] = "Inclure les désarmements"
L["INCAPACITATED_DISARM_DESC"] =
	"Impossible d'attaquer avec ses armes. Comme pour les immobilisations, le bouton de provocation fonctionne toujours."

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
	"Le tank de votre groupe est mort. C'est la seule mort qui change ce que tous les autres doivent faire ensuite, et quarante portraits de raid sont le pire endroit pour s'en apercevoir."
L["TANK_DEATHS_ENABLE"] = "Activer la surveillance des morts de tank"

L["TANK_DEATHS_ALERT_HEADER"] = "Morts de tank"
L["TANK_DEATHS_ALERT_DESC"] =
	"En raid, ne compte que les joueurs désignés tank principal, vous compris, et un rôle de la recherche de groupe n'y compte pour rien. En groupe, compte quiconque a sélectionné le rôle Tank dans la recherche de groupe. Un tank qui n'a ni l'un ni l'autre meurt sans être signalé."
L["TANK_DEATHS_ALERT_ENABLE"] = "Signaler les morts de tank"
L["TANK_DEATHS_ALERT_MINE"] = "Ma mort"
L["TANK_DEATHS_ALERT_MINE_DESC"] =
	"Signale votre propre mort lorsque vous tankez. Le menu déroulant à côté indique où va la ligne."
L["TANK_DEATHS_ALERT_OTHERS"] = "Morts de tank des autres"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] =
	"Signale la mort de tout autre membre de votre groupe qui tanke. Le menu déroulant à côté indique où va la ligne."

L["TANK_DEATHS_CLASS_HEADER"] = "Morts par classe"
L["TANK_DEATHS_CLASS_DESC"] = "Toutes les autres morts, par classe, pour celles que vous voulez suivre."
L["TANK_DEATHS_CLASS_ROW_DESC"] = "Signale la mort d'un %s de votre groupe."

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] =
	"Des soigneurs qui font plus de mal que de bien au tank. Classic et Burning Crusade uniquement : la Saison de la Découverte rend la rage grâce à une rune de prêtre, et rien de tout cela ne pose problème dans les versions ultérieures du jeu."
L["BAD_PRIESTS_ENABLE"] = "Activer la surveillance des vilains prêtres"

L["BAD_PRIESTS_HEADER"] = "Mauvais boucliers"
L["BAD_PRIESTS_DESC"] =
	"Signale un Mot de pouvoir : Bouclier posé sur un druide ou un guerrier en train de tanker. La rage vient des dégâts subis, et les dégâts absorbés par un bouclier n'en génèrent aucune : un bouclier bien intentionné prive donc le tank de la rage qui lui sert à tenir la menace."
L["BAD_PRIESTS_ALERT_ENABLE"] = "Signaler les mauvais boucliers"
L["BAD_PRIESTS_HEALTH_DESC"] =
	"Jusqu'où la vie du tank doit descendre avant qu'un bouclier cesse d'être une erreur. Un bouclier sur quelqu'un sur le point de mourir est le bon réflexe, l'avertissement se tait donc en dessous du niveau choisi ici. Choisissez \"Toujours\" pour être averti de chaque bouclier."
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "Toujours"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "Sauf sous %d %% de vie"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "Avertissements de mauvais bouclier"
L["BAD_PRIESTS_REPORT_DESC"] =
	"Où va l'avertissement quand quelqu'un pose un bouclier sur un tank à rage. Il n'y a pas ici une ligne pour vous et une pour les autres : le sort est celui du soigneur et le problème, celui du tank."
L["BAD_PRIESTS_SELF_ONLY"] = "Quand vous tankez en druide ou guerrier"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"N'avertit que des boucliers posés sur vous, et seulement quand vous êtes un druide ou un guerrier en train de tanker. Désactivez cette option pour être averti d'un bouclier posé sur n'importe quel membre de votre groupe qui tanke avec l'une de ces classes."
L["BAD_PRIESTS_WHISPER"] = "Chuchoter au lanceur"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"Envoie à celui qui a posé le bouclier un mot expliquant pourquoi il est nuisible. Un seul message est envoyé, même si plusieurs personnes de votre groupe utilisent Control Freak."
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"Durée pendant laquelle un même lanceur n'est plus signalé après avoir déclenché un avertissement de bouclier. Cela couvre l'affichage, le son, l'annonce et le chuchotement, car un soigneur qui pose ses boucliers à chaque recharge ne doit pas remplir votre fenêtre."

--------------------------------------------------------------------------------
-- Bad Pets
--------------------------------------------------------------------------------

L["BAD_PETS_SUMMARY"] =
	"Familiers de chasseur et de démoniste dont les capacités de menace sont restées en lancement automatique."
L["BAD_PETS_ENABLE"] = "Activer la surveillance des vilains familiers"

L["BAD_PETS_ALERT_HEADER"] = "Provocations de familier"
L["BAD_PETS_ALERT_DESC"] =
	"Un familier qui arrache l'ennemi au tank parce que son lancement automatique est resté activé, généralement sans que son maître s'en aperçoive."
L["BAD_PETS_ALERT_ENABLE"] = "Signaler les provocations de familier sur"
L["BAD_PETS_ALERT_MINE"] = "Provocations de mon familier"
L["BAD_PETS_ALERT_OTHERS"] = "Provocations des familiers des autres"
L["BAD_PETS_WHISPER_ENABLE"] = "Chuchoter au maître du familier"
L["BAD_PETS_WHISPER_ENABLE_DESC"] =
	"Envoie au maître du familier un mot expliquant comment couper le lancement automatique. Un seul message est envoyé, même si plusieurs personnes de votre groupe utilisent Control Freak."
L["BAD_PETS_COOLDOWN_DESC"] =
	"Durée pendant laquelle un même familier n'est plus signalé après avoir déclenché une alerte. Cela couvre l'affichage, le son, l'annonce et le chuchotement, pour qu'un familier resté en lancement automatique ne remplisse pas votre fenêtre et que son maître ne reçoive pas un nouveau chuchotement toutes les quelques secondes."

L["BAD_PETS_ABILITIES_HEADER"] = "Capacités des vilains familiers"

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
L["TANKING_TOOLS_ENABLE"] = "Activer les outils de tank"
L["TANKING_TOOLS_MINIMAP_SUMMARY"] = "Ouvertures ratées, affaiblissements d'armure, parades et novas de givre."

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Ouvertures ratées"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Signale vos propres attaques d'ouverture qui n'ont pas porté : un raté, une esquive, une parade, un blocage, une résistance ou une immunité dans les premières secondes d'un pull. De la menace qui n'a jamais existé, au moment où elle compte le plus."
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Signaler les ouvertures ratées sur"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "Mes ouvertures ratées"
L["TANKING_TOOLS_COLD_OPENER_MINE_DESC"] =
	"Signale vos propres capacités d'ouverture qui n'ont pas porté. Le menu déroulant à côté indique où va la ligne."
-- The caption before the window dropdown: "Within [10 Seconds of Fight]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "Dans les"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d secondes de combat"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Combien de temps après le début d'un pull une capacité évitée compte encore. Le chrono démarre la première fois que Control Freak voit cet ennemi, et seules les capacités comptent : une attaque automatique rate bien trop souvent pour faire l'événement."

L["TANKING_TOOLS_ARMOR_HEADER"] = "Affaiblissements d'armure"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Indique combien de temps le groupe a mis pour réduire l'armure d'une cible : cinq Fracasser armure ou un Exposer l'armure de voleur. Cochez l'une des lignes Inclure ci-dessous et le rapport attendra aussi cet affaiblissement, mais seulement si quelqu'un du groupe peut réellement le lancer."
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Signaler les affaiblissements d'armure sur"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "Rapports d'affaiblissement d'armure"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	"Où va le rapport une fois que le groupe a réduit l'armure d'une cible. Il n'y a pas ici une ligne pour vous et une pour les autres : c'est le travail du groupe, qui vous est rapporté."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Inclure Lucioles"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Attend Lucioles avant de faire le rapport, quelle que soit la forme sous laquelle le druide le lance. Ignoré s'il n'y a aucun druide dans le groupe."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Inclure Malédiction de témérité"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Attend Malédiction de témérité avant de faire le rapport. Ignoré s'il n'y a aucun démoniste dans le groupe."

L["TANKING_TOOLS_PARRY_HEADER"] = "Parades"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Quelqu'un qui se fait parer par un ennemi qu'il ne tanke pas se tient devant lui. Chaque parade accélère le prochain coup de cet ennemi sur celui qui le tient."
L["TANKING_TOOLS_PARRY_ENABLE"] = "Signaler les parades sur"
L["TANKING_TOOLS_PARRY_MINE"] = "Mes parades"
L["TANKING_TOOLS_PARRY_MINE_DESC"] =
	"Signale un ennemi qui pare vos attaques. Le menu déroulant à côté indique où va la ligne."
L["TANKING_TOOLS_PARRY_OTHERS"] = "Parades des autres"
L["TANKING_TOOLS_PARRY_OTHERS_DESC"] =
	"Signale un ennemi qui pare les attaques de tout autre membre de votre groupe. Le menu déroulant à côté indique où va la ligne."
L["TANKING_TOOLS_PARRY_IGNORE_TANKS"] = "Ignorer les tanks"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS_DESC"] =
	"Reste silencieux quand le joueur qui se fait parer est un tank : désigné tank principal en raid, ou avec le rôle Tank de la recherche de groupe en groupe. Un second tank se tient devant le boss pour un échange de provocation, et ce n'est pas une erreur qui mérite un chuchotement. Vos propres parades sont toujours signalées."
L["TANKING_TOOLS_PARRY_IGNORE_PETS"] = "Ignorer les familiers"
L["TANKING_TOOLS_PARRY_IGNORE_PETS_DESC"] =
	"Reste silencieux quand l'attaque parée vient d'un familier, le vôtre compris. Un familier se tient là où son maître l'a envoyé, et une ligne qui nomme le familier ne donne rien à faire à personne dans le groupe. Aucun chuchotement n'est envoyé pour un familier, quoi qu'il en soit."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Chuchoter au fautif"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Envoie au fautif un mot lui demandant de se placer derrière l'ennemi. Un seul message est envoyé, même si plusieurs personnes de votre groupe utilisent Control Freak."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Durée pendant laquelle un même fautif n'est plus signalé après avoir déclenché un avertissement de parade. Cela couvre l'affichage, le son, l'annonce et le chuchotement, car quelqu'un qui n'a pas encore bougé n'a pas besoin qu'on le lui répète à chaque coup."

L["TANKING_TOOLS_NOVA_HEADER"] = "Novas de givre"
L["TANKING_TOOLS_NOVA_DESC"] = "Signale une Nova de givre, qui gèle un pull sur place, hors de portée du tank."
L["TANKING_TOOLS_NOVA_ENABLE"] = "Signaler les novas de givre"
L["TANKING_TOOLS_NOVA_MINE"] = "Mes novas de givre"
L["TANKING_TOOLS_NOVA_OTHERS"] = "Novas de givre des autres"

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
L["UNKNOWN_SOURCE"] = "Quelqu'un"
L["UNKNOWN_CASTER"] = "source inconnue"
L["UNKNOWN_TARGET"] = "une cible inconnue"
L["UNKNOWN_SPELL"] = "un sort inconnu"

L["TAUNT_SUCCESS"] = "Provocation ! %s a utilisé %s sur %s."
L["TAUNT_AOE"] = "Provocation de zone ! %s a utilisé %s."
L["TAUNT_MISSED"] = "Provocation ratée ! %s a utilisé %s sur %s et a raté."
L["TAUNT_RESISTED"] = "Provocation ratée ! %s a utilisé %s sur %s, qui a résisté."
--[[
    The one failure format that leads with the MOB rather than the taunter,
    because the immunity is the news and the other three formats have no news
    beyond "it did not land".

    TRANSLATORS: %s is, in order: mob, taunter, taunt. This is the ONLY taunt
    format whose first %s is not the player who cast it.
]]
L["TAUNT_IMMUNE"] = "Provocation ratée ! %s est insensible : %s a utilisé %s."
L["TAUNT_FAILED"] = "Provocation ratée ! %s a utilisé %s sur %s sans effet."
L["INTERRUPT"] = "Interruption ! %s a utilisé %s sur %s et a interrompu %s."

L["FEAR_SUCCESS"] = "Peur ! %s a utilisé %s sur %s."
L["FEAR_AOE"] = "Peur de zone ! %s a utilisé %s."

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
L["INCAPACITATED"] = "%s neutralisé pendant %s ; %s subit %s (%s) de %s."
L["INCAPACITATED_PLAIN"] = "%s neutralisé pendant %s ; %s subit %s de %s."
L["INCAPACITATED_INDEFINITE"] = "%s neutralisé ; %s subit %s (%s) de %s."
L["INCAPACITATED_PLAIN_INDEFINITE"] = "%s neutralisé ; %s subit %s de %s."

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
L["INCAPACITATED_ROLE_HEALER"] = "Soigneur"

--[[
    The length, as its own phrase rather than a bare number with "seconds" in the
    format, so the singular does not need two more formats beside the four
    above. Always a whole number: the handler rounds UP, because a fear reported
    as 5.9 promises a taunt back sooner than it is coming.

    TRANSLATORS: the handler reads exactly these two, the first for 1 and the
    second for every other count, so a language with more number forms words
    the second to read for any count. An abbreviated unit does.
]]
L["INCAPACITATED_SECOND"] = "%d seconde"
L["INCAPACITATED_SECONDS"] = "%d secondes"

--[[
    The four debuff types a player can take off. They name the class that can
    help -- Magic is a priest or paladin, Curse a mage or druid -- so they are
    the half of the line a tank cannot act on alone.

    TRANSLATORS: use the client's own words for these, the ones on the debuff
    tooltips, not a literal translation of the English.
]]
L["DISPEL_MAGIC"] = "Magie"
L["DISPEL_CURSE"] = "Malédiction"
L["DISPEL_DISEASE"] = "Maladie"
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
L["TANK_DEATHS_TANK_LINE"] = "Tank à terre ! %s vient de mourir."
L["TANK_DEATHS_CLASS_LINE"] = "%s à terre ! %s vient de mourir."

--[[
    Kept short on purpose: they render with a real spell link and two real names
    inside the 255 byte chat limit, and the widest locale runs close to twice the
    English.

    The WARNING carries no explanation and the WHISPER carries all of it. The
    warning fires mid-pull in front of a tank who already knows what a shield
    does; the whisper goes to the healer who does not, and is read after the
    fact. The tab description explains it at length for whoever wants it.
]]
L["SHIELD_WARNING"] = "Mauvais bouclier ! %s a lancé %s sur %s."
L["SHIELD_WHISPER"] =
	"Mauvais bouclier ! Merci d'éviter de lancer %s sur %s. Cette capacité empêche les tanks de gagner de la rage."

L["BAD_PET"] = "Vilain familier ! Le familier de %s, %s, a utilisé %s sur %s."
L["BAD_PET_AOE"] = "Vilain familier ! Le familier de %s, %s, a utilisé %s."
L["BAD_PET_UNKNOWN_OWNER"] = "Vilain familier ! %s a utilisé %s sur %s."
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Vilain familier ! %s a utilisé %s."
--[[
    Kept short on purpose. They render with a spell link and up to two names inside
    a 255 byte chat limit, and the widest locale runs close to twice the English.
]]
L["BAD_PET_WHISPER"] =
	"Ton familier %s a utilisé %s sur %s. Fais un clic droit sur la capacité pour couper le lancement automatique."
L["BAD_PET_WHISPER_AOE"] =
	"Ton familier %s a utilisé %s. Fais un clic droit sur la capacité pour couper le lancement automatique."

L["COLD_OPENER_MISS"] = "Attention ! %s a lancé %s et a raté %s."
L["COLD_OPENER_DODGE"] = "Attention ! %s a lancé %s et %s a esquivé."
L["COLD_OPENER_PARRY"] = "Attention ! %s a lancé %s et %s a paré."
L["COLD_OPENER_BLOCK"] = "Attention ! %s a lancé %s et %s a bloqué."
L["COLD_OPENER_IMMUNE"] = "Attention ! %s a lancé %s et %s y est insensible."
L["COLD_OPENER_RESIST"] = "Attention ! %s a lancé %s et %s a résisté."

L["ARMOR_REPORT"] = "Armure réduite ! %s : vulnérable en %s s."

L["PARRY_WARNING"] = "Hâte de parade ! %s se tient devant %s."
L["PARRY_WHISPER"] =
	"Hâte de parade ! Place-toi derrière %s, s'il te plaît : chaque parade accélère son prochain coup."

L["NOVA"] = "Nova ! %s a utilisé %s sur %s."
L["NOVA_AOE"] = "Nova de zone ! %s a utilisé %s."
