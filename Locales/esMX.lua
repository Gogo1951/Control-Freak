local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "esMX")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"Anunciador de combate para provocaciones, interrupciones, miedos, muertes de tanque, mascotas traviesas, paradas, perjuicios de armadura y otros eventos críticos del combate. Controla quién provocó, qué falló, quién interrumpió un lanzamiento y qué pasó, con alertas personalizables."
L["VERSION"] = "Versión"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Versión %s. La configuración (incluida la opción de desactivar este mensaje) se encuentra en Opciones > AddOns > Control Freak. ¿Te gusta el add-on? ¡Cuéntaselo a un amigo! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Como medida de seguridad, la interfaz de opciones no se puede abrir durante el combate."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Activar mensaje de bienvenida"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Muestra el saludo de Control Freak al iniciar sesión."
L["ENABLE_MINIMAP_BUTTON"] = "Activar botón del minimapa"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Muestra el botón de Control Freak en tu minimapa."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre la interfaz de opciones de este add-on."

--[[
    The add-on's own switch, above every feature's. The title names its REACH
    rather than the act of throwing it, which is what a player cannot read off
    the box beside it -- every other toggle on this panel governs one thing.

    Its ENABLE description is shared with the mini-map button's line for the same
    toggle, so the two cannot describe it differently.
]]
L["KILL_SWITCH"] = "Todas las alertas"
L["KILL_SWITCH_SUMMARY"] =
	"Un solo interruptor para todas las alertas de todas las pestañas: al apagarlo el add-on se calla sin cambiar ningún ajuste, y un clic izquierdo en el botón del minimapa hace lo mismo desde donde estés."
L["KILL_SWITCH_ENABLE"] = "Activar Control Freak"
L["KILL_SWITCH_ENABLE_DESC"] = "Activa o desactiva todas las alertas de Control Freak."

L["FEEDBACK_HEADER"] = "Comentarios y soporte"
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
L["STATE_ON"] = "Activado"
L["STATE_OFF"] = "Desactivado"
L["LEFT_CLICK"] = "Clic izquierdo"
L["RIGHT_CLICK"] = "Clic derecho"
L["SHIFT_MIDDLE_CLICK"] = "Mayús + clic central"
L["ACTION_TOGGLE"] = "Alternar"
L["MINIMAP_OPTIONS"] = "Opciones de Control Freak"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

-- In tab order.
L["TAB_TAUNTS"] = "Provocaciones"
L["TAB_INTERRUPTS"] = "Interrupciones"
L["TAB_FEARS"] = "Miedos"
L["TAB_INCAPACITATED"] = "Incapacitado"
L["TAB_TANK_DEATHS"] = "Muertes de tanque"
L["TAB_BAD_PRIESTS"] = "Sacerdotes traviesos"
L["TAB_BAD_PETS"] = "Mascotas traviesas"
L["TAB_TANKING_TOOLS"] = "Utilidades de tanque"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Activa o desactiva esta función."
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
L["SCOPE_ROLE_TANK"] = "Como tanque"
L["SCOPE_ROLE_HEALER"] = "Como sanador"
L["SCOPE_ROLE_TANK_HEALER"] = "Como tanque o sanador"
L["SCOPE_ROLE_ALWAYS"] = "Siempre"
L["SCOPE_ROLE_DESC"] =
	"Qué rol tienes que ocupar para que esta función diga algo. Cuentas como Tanque cuando eres el tanque principal de la banda o tienes seleccionado el rol de Tanque en el buscador de grupos, y como Sanador solo cuando tienes seleccionado el rol de Sanador, ya que no existe una asignación de banda para sanar. Siempre prescinde de la pregunta y avisa juegues de lo que juegues."
L["SCOPE_GROUP_HAS_TANK"] = "Si el grupo tiene tanque"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Solo avisa mientras alguien de tu grupo esté tanqueando y siga vivo. Un tanque caído cuenta como si no hubiera tanque, porque es justo entonces cuando ayuda que otra persona mantenga la amenaza."
L["SCOPE_INSTANCE_ONLY"] = "Si estás en una instancia"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Solo avisa dentro de calabozos y bandas."

--------------------------------------------------------------------------------
-- Alert Sections
--------------------------------------------------------------------------------

--[[
    Every alert on every tab is drawn as the same block, so each one owns five
    strings: a HEADER naming the thing that happened; an ENABLE reading "Enable
    Notifications for <that thing> On" -- the switch turns the telling on, not
    the event, and the target dropdown beside it finishes the sentence, so the
    string ENDS on the preposition (a section with no target drops the word); a
    DESC of one or two sentences; and a MINE and an OTHERS naming the two rows.
    ns.AddWhoseAlertSection in Options-Alert-Section.lua is where that shape
    lives.

    The ENABLE is the longest label in the add-on and fits its column with
    little to spare, so keep translations short -- a longer one clips with an
    ellipsis.
]]
L["ALERT_SECTION_ENABLE_DESC"] = "Activa o desactiva esta alerta."
L["ALERT_SOUND"] = "Reproducir sonido"
L["ALERT_SOUND_DESC"] = "Reproduce un sonido cuando se dispara esta alerta."
L["ALERT_SOUND_FILE_DESC"] = "Elige el sonido que reproduce esta alerta. Al elegir uno, suena."
L["ALERT_SOUND_PREVIEW_DESC"] = "Reproduce este sonido ahora, esté o no activado el sonido."
L["SOUND_NONE"] = "Ninguno"

--[[
    The block every tab draws: whose cast is the row, where its line goes is
    the dropdown beside it, and the target filter is a ladder rather than a
    switch. Each section names its own two rows -- see
    TAUNTS_SUCCESS_MINE below -- because "My" and "Others'" agree with the noun
    in some languages and a shared "%s" template could not.

    TRANSLATORS: ALERT_AGAINST_DESC quotes one rung by name; that wording must
    match your TARGET_RUNG_ELITE_0, or the tooltip explains a choice the player
    cannot find in the list. The four rungs are a threshold, widest first: each
    one counts itself and the ones after it, which is why every rung that
    includes bosses says so. Keep that in your translations -- a rung reading
    only "Elites" beside a separate "Bosses" reads as two disjoint sets.

    ALERT_MARKED_ALWAYS is the one control that WIDENS a section rather than
    narrowing it: a marked target counts whatever the rung says. Keep "Always"
    in it, and keep it distinct from ALERT_OUTPUT_ANNOUNCE -- this row decides
    WHETHER the alert fires, never where its line goes.
]]
L["ALERT_MINE_DESC"] =
	"Informa sobre tus propios lanzamientos, incluidos los de tu mascota. El menú desplegable de al lado indica adónde va la línea."
L["ALERT_OTHERS_DESC"] =
	"Informa sobre los lanzamientos de todos los demás en tu grupo. El menú desplegable de al lado indica adónde va la línea."
L["ALERT_OUTPUT_PRINT"] = "Mostrar (solo para mí)"
L["ALERT_OUTPUT_ANNOUNCE"] = "Anunciar"
L["ALERT_OUTPUT_DESC"] =
	"Adónde va esta línea: a un solo lugar, nunca a los dos. Mostrar (solo para mí) usa tu propia ventana y no le cuesta nada a nadie. Anunciar, en cambio, la envía al chat de grupo o de banda, y narrarle a toda la banda lo que hacen los demás es la forma en que un add-on deja de ser bienvenido, así que vale la pena pensarlo. Anunciar se queda en silencio cuando no estás en un grupo, y también dentro de campos de batalla y arenas."
L["ALERT_AGAINST_DESC"] =
	"Qué enemigos cuentan: cada opción incluye las que vienen después. Los jefes son enemigos de nivel calavera (??). Un jefe de calabozo no lleva calavera propia, así que cuenta como élite, y la opción Élites de tu nivel+ y jefes es la que lo conserva mientras descarta a los enemigos menores de nivel más bajo que lo rodean. Una marca de banda anula todo esto mientras la casilla de abajo esté activada."
L["TARGET_RUNG_ALL"] = "Todo"
L["TARGET_RUNG_ELITE"] = "Élites y jefes"
L["TARGET_RUNG_ELITE_0"] = "Élites de tu nivel+ y jefes"
L["TARGET_RUNG_BOSS"] = "Jefes"
L["ALERT_MARKED_ALWAYS"] = "Alertar siempre sobre objetivos marcados"
L["ALERT_MARKED_ALWAYS_DESC"] =
	"Un objetivo con una marca de banda (calavera, cruz, cualquiera de las ocho) cuenta, diga lo que diga el menú desplegable junto al interruptor de la sección. Las marcas son la forma en que un grupo señala a los enemigos que importan, así que uno que alguien marcó nunca se descarta por tener la categoría o el nivel equivocados."

--[[
    The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
    list of seconds. Whole minutes read as minutes, and zero reads as "No
    Cooldown" rather than "0 Second Cooldown".

    TRANSLATORS: one format serves every count it is given, one minute and five
    alike, so word each to read for any number. An abbreviated unit does.
]]
L["COOLDOWN_NONE"] = "Sin reutilización"
L["COOLDOWN_SECONDS"] = "Reutilización de %d s"
L["COOLDOWN_MINUTES"] = "Reutilización de %d min"

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
L["SAMPLE_EXAMPLE"] = "Ejemplo: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "Juan"
L["SAMPLE_PET"] = "Firulais"

--[[
    The Naxxramas bosses the Example lines name, dealt one per line.

    TRANSLATORS: use each boss's name exactly as your client writes it, title
    included, not a translation of the English.
]]
L["SAMPLE_BOSS_ANUBREKHAN"] = "Anub'Rekhan"
L["SAMPLE_BOSS_FAERLINA"] = "Gran Viuda Faerlina"
L["SAMPLE_BOSS_MAEXXNA"] = "Maexxna"
L["SAMPLE_BOSS_NOTH"] = "Noth el Pesteador"
L["SAMPLE_BOSS_HEIGAN"] = "Heigan el Impuro"
L["SAMPLE_BOSS_LOATHEB"] = "Loatheb"
L["SAMPLE_BOSS_RAZUVIOUS"] = "Instructor Razuvious"
L["SAMPLE_BOSS_GOTHIK"] = "Gothik el Cosechador"
L["SAMPLE_BOSS_MOGRAINE"] = "Alto señor Mograine"
L["SAMPLE_BOSS_KORTHAZZ"] = "Señor feudal Korth'azz"
L["SAMPLE_BOSS_BLAUMEUX"] = "Lady Blaumeux"
L["SAMPLE_BOSS_ZELIEK"] = "Sir Zeliek"
L["SAMPLE_BOSS_PATCHWERK"] = "Remendejo"
L["SAMPLE_BOSS_GROBBULUS"] = "Grobbulus"
L["SAMPLE_BOSS_GLUTH"] = "Gluth"
L["SAMPLE_BOSS_THADDIUS"] = "Thaddius"
L["SAMPLE_BOSS_SAPPHIRON"] = "Sapphiron"
L["SAMPLE_BOSS_KELTHUZAD"] = "Kel'Thuzad"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "Objetos"
L["ABILITIES_CLASS_PET"] = "Mascota de %s"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] = "Las provocaciones son habilidades que le quitan la amenaza a quien la tenga en ese momento."
L["TAUNTS_ENABLE"] = "Activar vigilancia de provocaciones"

L["TAUNTS_SUCCESS_HEADER"] = "Provocaciones logradas"
L["TAUNTS_SUCCESS_DESC"] =
	"Una provocación que acertó y le quitó el enemigo a otra persona. Una provocación sobre un enemigo que ya le estaba pegando a quien provoca es solo una renovación de amenaza, no un rescate, así que esas se quedan en silencio."
L["TAUNTS_SUCCESS_ENABLE"] = "Notificar provocaciones logradas contra"
L["TAUNTS_SUCCESS_MINE"] = "Mis provocaciones logradas"
L["TAUNTS_SUCCESS_OTHERS"] = "Provocaciones logradas de los demás"

L["TAUNTS_FAILED_HEADER"] = "Provocaciones fallidas"
L["TAUNTS_FAILED_DESC"] =
	"Una provocación que falló, fue resistida o dio con algo inmune. El enemigo no cambió de manos, y nada en pantalla te lo indica."
L["TAUNTS_FAILED_ENABLE"] = "Notificar provocaciones fallidas contra"
L["TAUNTS_FAILED_MINE"] = "Mis provocaciones fallidas"
L["TAUNTS_FAILED_OTHERS"] = "Provocaciones fallidas de los demás"

L["TAUNTS_AOE_HEADER"] = "Provocaciones de área"
L["TAUNTS_AOE_DESC"] = "Una provocación que agarra de golpe todo lo que tiene alrededor, en vez de un solo objetivo."
L["TAUNTS_AOE_ENABLE"] = "Notificar provocaciones de área"
L["TAUNTS_AOE_MINE"] = "Mis provocaciones de área"
L["TAUNTS_AOE_OTHERS"] = "Provocaciones de área de los demás"

L["TAUNTS_ABILITIES_HEADER"] = "Habilidades de provocación"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "Habilidades de provocación de área"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "Las interrupciones cortan un hechizo enemigo a mitad de su lanzamiento."
L["INTERRUPTS_ENABLE"] = "Activar vigilancia de interrupciones"

L["INTERRUPTS_ALERT_HEADER"] = "Interrupciones logradas"
L["INTERRUPTS_ALERT_DESC"] = "Un lanzamiento cortado a medias. Dice quién lo cortó y qué cortó."
L["INTERRUPTS_ALERT_ENABLE"] = "Notificar interrupciones logradas contra"
L["INTERRUPTS_ALERT_MINE"] = "Mis interrupciones logradas"
L["INTERRUPTS_ALERT_OTHERS"] = "Interrupciones logradas de los demás"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Los miedos hacen huir a los enemigos y los dispersan por toda la sala."
L["FEARS_ENABLE"] = "Activar vigilancia de miedos"

L["FEARS_ALERT_HEADER"] = "Miedos logrados"
L["FEARS_ALERT_DESC"] =
	"Un miedo que acertó y dispersó a los enemigos fuera del alcance del tanque. Solo cuenta si acierta: un simple lanzamiento, una resistencia y una inmunidad no movieron nada, así que ninguno se notifica."
L["FEARS_ALERT_ENABLE"] = "Notificar miedos logrados"
L["FEARS_ALERT_MINE"] = "Mis miedos logrados"
L["FEARS_ALERT_OTHERS"] = "Miedos logrados de los demás"

L["FEARS_ABILITIES_HEADER"] = "Habilidades de miedo"

--------------------------------------------------------------------------------
-- Incapacitated
--------------------------------------------------------------------------------

L["INCAPACITATED_SUMMARY"] =
	"Avisa a tu grupo en cuanto pierdas el control de tu personaje, para que otra persona pueda cubrirte. Un tanque aterrorizado y un sanador silenciado son las dos personas que más necesitan decirlo, y las dos que menos pueden hacerlo en ese momento."
L["INCAPACITATED_ENABLE"] = "Activar vigilancia de incapacitaciones"

L["INCAPACITATED_HEADER"] = "Tu incapacitación"
L["INCAPACITATED_DESC"] =
	"Avisa al grupo cuando te aturden, te aterrorizan, te silencian o te sacan del combate de cualquier otra forma: qué te alcanzó, quién lo lanzó, cuánto dura y si alguien puede quitártelo."
--[[
    No trailing preposition and nothing beside it: this alert has no target
    ladder, and its "Long" threshold is a row of its own, above the two rows it
    names.
]]
L["INCAPACITATED_ALERT_ENABLE"] = "Notificar tu incapacitación"
--[[
    The only pair of rows in the add-on that is not My and Others'. The game
    reports the player's own losses of control and nobody else's, so "whose"
    has one answer; how LONG it lasts is the question with two.

    TRANSLATORS: keep the quotes around Long in the caption. They mark it as the
    word the two rows below are named after rather than as an adjective.
]]
L["INCAPACITATED_LONG_CAPTION"] = 'Mínimo para incapacitación "larga"'
L["INCAPACITATED_LONG_CAPTION_DESC"] =
	"Cuánto tiene que durar una pérdida de control para contar como larga. Lo que dure menos cuenta como corta. Ninguna se descarta. Las dos filas de abajo indican adónde va cada una, y por defecto apuntan a lugares distintos."
-- The caption's dropdown: the first reads for 1 only, the second for 2 to 10.
L["INCAPACITATED_THRESHOLD_ONE"] = "%d segundo"
L["INCAPACITATED_THRESHOLD"] = "%d segundos"
L["INCAPACITATED_SHORT"] = "Mi incapacitación corta"
L["INCAPACITATED_SHORT_DESC"] =
	"Adónde va la línea cuando te sacan del combate por menos tiempo que la duración de arriba. Por defecto se muestra en tu propia ventana: un aturdimiento del que te recuperas antes de que nadie haya podido cubrirte explica el tiempo de reutilización global que acabas de perder, y no es problema de nadie más."
L["INCAPACITATED_LONG"] = "Mi incapacitación larga"
L["INCAPACITATED_LONG_DESC"] =
	"Adónde va la línea cuando te sacan del combate durante al menos la duración de arriba. Por defecto se anuncia: es la que otra persona sí tiene tiempo de atender, y tú eres la única persona que no puede decirlo. Un efecto sin ninguna duración, como un Control mental, cuenta como larga."

L["INCAPACITATED_STUN"] = "Incluir aturdimientos"
L["INCAPACITATED_STUN_DESC"] =
	"Pérdida total de control, sin moverte del lugar. Los efectos de sueño cuentan como aturdimiento."
L["INCAPACITATED_FEAR"] = "Incluir miedos"
L["INCAPACITATED_FEAR_DESC"] = "Pérdida total de control, corriendo en direcciones al azar. El enemigo se va contigo."
L["INCAPACITATED_CHARM"] = "Incluir Control mental"
L["INCAPACITATED_CHARM_DESC"] =
	"Totalmente bajo el control de otra persona. Suele ser lo peor de esta lista, y por lo general dura indefinidamente."
L["INCAPACITATED_CONFUSE"] = "Incluir confusión"
L["INCAPACITATED_CONFUSE_DESC"] = "Pérdida total de control, caminando en direcciones al azar."
L["INCAPACITATED_SILENCE"] = "Incluir silencios"
L["INCAPACITATED_SILENCE_DESC"] =
	"No puedes lanzar hechizos. La provocación de un druida o de un paladín es un hechizo, así que es una provocación que no va a llegar."
L["INCAPACITATED_PACIFY"] = "Incluir pacificaciones"
L["INCAPACITATED_PACIFY_DESC"] = "No puedes atacar, aunque los hechizos siguen funcionando."
L["INCAPACITATED_SCHOOL_INTERRUPT"] = "Incluir bloqueos de hechizos"
L["INCAPACITATED_SCHOOL_INTERRUPT_DESC"] =
	"No puedes lanzar hechizos de una escuela. Vale la pena tenerlo si provocas con un hechizo, ya que un druida o un paladín con la escuela de Naturaleza o Sagrado bloqueada se queda sin provocación."
L["INCAPACITATED_ROOT"] = "Incluir enraizamientos"
L["INCAPACITATED_ROOT_DESC"] =
	"No puedes moverte. Un tanque enraizado todavía tiene el botón de provocar, así que el enemigo no se va a ninguna parte."
L["INCAPACITATED_DISARM"] = "Incluir desarmes"
L["INCAPACITATED_DISARM_DESC"] =
	"No puedes atacar con armas. Igual que con los enraizamientos, el botón de provocar sigue funcionando."

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
	"El tanque de tu grupo murió. Es la única muerte que cambia lo que deben hacer los demás a continuación, y cuarenta retratos de banda son el peor lugar para notarlo."
L["TANK_DEATHS_ENABLE"] = "Activar vigilancia de muertes de tanque"

L["TANK_DEATHS_ALERT_HEADER"] = "Muertes de tanque"
L["TANK_DEATHS_ALERT_DESC"] =
	"Cuenta al tanque principal de la banda y a quien tenga seleccionado el rol de Tanque en el buscador de grupos, tú incluido. Son las dos únicas formas en que el juego indica quién tanquea, así que un tanque sin ninguna de ellas muere sin aviso."
L["TANK_DEATHS_ALERT_ENABLE"] = "Notificar muertes de tanque"
L["TANK_DEATHS_ALERT_MINE"] = "Mi muerte"
L["TANK_DEATHS_ALERT_MINE_DESC"] =
	"Informa sobre tu propia muerte mientras tanqueas. El menú desplegable de al lado indica adónde va la línea."
L["TANK_DEATHS_ALERT_OTHERS"] = "Muertes de tanque de los demás"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] =
	"Informa sobre la muerte de cualquier otro en tu grupo que esté tanqueando. El menú desplegable de al lado indica adónde va la línea."

L["TANK_DEATHS_CLASS_HEADER"] = "Muertes por clase"
L["TANK_DEATHS_CLASS_DESC"] = "Todas las demás muertes, por clase, para las que quieras vigilar."
L["TANK_DEATHS_CLASS_ROW_DESC"] = "Avisa cuando muere un %s de tu grupo."

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] =
	"Sanadores que hacen algo que perjudica al tanque más de lo que lo ayuda. Solo en Classic y Burning Crusade: la Temporada de descubrimiento devuelve la ira mediante una runa de sacerdote, y nada de esto es un problema en versiones posteriores del juego."
L["BAD_PRIESTS_ENABLE"] = "Activar vigilancia de sacerdotes traviesos"

L["BAD_PRIESTS_HEADER"] = "Malos escudos"
L["BAD_PRIESTS_DESC"] =
	"Avisa cuando una Palabra de poder: escudo cae sobre un druida o un guerrero que está tanqueando. La ira viene del daño recibido, y el daño que absorbe un escudo no genera nada, así que un escudo bienintencionado deja al tanque sin la ira con la que mantiene la amenaza."
L["BAD_PRIESTS_ALERT_ENABLE"] = "Notificar malos escudos"
L["BAD_PRIESTS_HEALTH_DESC"] =
	"Cuánto tiene que bajar la salud del tanque para que un escudo deje de ser un error. Un escudo sobre alguien a punto de morir es lo correcto, así que el aviso guarda silencio por debajo del nivel que elijas aquí. Elige Siempre para enterarte de todos los escudos."
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "Siempre"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "Excepto bajo %d%% de salud"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "Avisos de malos escudos"
L["BAD_PRIESTS_REPORT_DESC"] =
	"Adónde va el aviso cuando alguien le pone un escudo a un tanque de ira. Aquí no hay una fila para ti y otra para los demás: el lanzamiento es del sanador y el problema es del tanque."
L["BAD_PRIESTS_SELF_ONLY"] = "Si juegas de tanque druida o guerrero"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"Solo avisa de escudos que caen sobre ti, y solo mientras seas un druida o un guerrero que está tanqueando. Desactívalo para enterarte de un escudo sobre cualquier miembro de tu grupo que esté tanqueando con una de esas clases."
L["BAD_PRIESTS_WHISPER"] = "Susurrar al lanzador"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"Envía a quien lanzó el escudo una nota que explica por qué perjudica. Solo se envía un susurro aunque varias personas de tu grupo usen Control Freak."
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"Cuánto tiempo se queda en silencio un mismo lanzador después de disparar un aviso de escudo. Cubre el mensaje, el sonido, el anuncio y el susurro, porque un sanador que pone un escudo cada vez que puede no debe llenarte la ventana."

--------------------------------------------------------------------------------
-- Bad Pets
--------------------------------------------------------------------------------

-- Doubles as the mini-map button's Bad Pets line, so the two cannot differ.
L["BAD_PETS_SUMMARY"] =
	"Mascotas de cazador y de brujo con habilidades de amenaza que se dejaron en lanzamiento automático."
L["BAD_PETS_ENABLE"] = "Activar vigilancia de mascotas traviesas"

L["BAD_PETS_ALERT_HEADER"] = "Provocaciones de mascota"
L["BAD_PETS_ALERT_DESC"] =
	"Una mascota que le quita el enemigo al tanque con el lanzamiento automático activado, normalmente sin que su dueño se dé cuenta."
L["BAD_PETS_ALERT_ENABLE"] = "Notificar provocaciones de mascota contra"
L["BAD_PETS_ALERT_MINE"] = "Provocaciones de mi mascota"
L["BAD_PETS_ALERT_OTHERS"] = "Provocaciones de mascota de los demás"
L["BAD_PETS_WHISPER_ENABLE"] = "Susurrar al dueño de la mascota"
L["BAD_PETS_WHISPER_ENABLE_DESC"] =
	"Envía al dueño de la mascota una nota que explica cómo desactivar el lanzamiento automático. Solo se envía un susurro aunque varias personas de tu grupo usen Control Freak."
L["BAD_PETS_COOLDOWN_DESC"] =
	"Cuánto tiempo se queda en silencio una misma mascota después de disparar una alerta. Cubre el mensaje, el sonido, el anuncio y el susurro, para que una mascota con el lanzamiento automático activado no llene tu ventana y su dueño no reciba otro susurro cada pocos segundos."

L["BAD_PETS_ABILITIES_HEADER"] = "Habilidades de mascota traviesa"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

--[[
    No summary line: the Tanking Tools tab opens on its enable, because the tab is
    a collection of unrelated warnings rather than one idea a sentence can cover.
    Each section introduces itself instead.
]]
L["TANKING_TOOLS_ENABLE"] = "Activar utilidades de tanque"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Aperturas en frío"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Avisa de tus propios ataques de apertura que no lograron conectar: un fallo, una esquiva, una parada, un bloqueo, una resistencia o una inmunidad en los primeros segundos de un combate. Amenaza que nunca se generó, justo en el momento en que más importa."
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Notificar aperturas en frío contra"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "Mis aperturas en frío"
-- The caption before the window dropdown: "Within [10 Seconds of Fight]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "En los primeros"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d segundos de combate"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Hasta qué momento del combate sigue contando una habilidad evitada. El reloj arranca la primera vez que Control Freak ve a ese enemigo, y solo cuentan las habilidades: un ataque automático falla demasiado seguido como para ser noticia."

L["TANKING_TOOLS_ARMOR_HEADER"] = "Perjuicios de armadura"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Indica cuánto tardó el grupo en reducir la armadura de un objetivo: cinco acumulaciones de Hender armadura o un Exponer armadura de pícaro. Si activas una de las filas Incluir de abajo, también espera a ese perjuicio, pero solo cuando alguien del grupo puede lanzarlo de verdad."
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Notificar perjuicios de armadura contra"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "Informes de perjuicios de armadura"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	"Adónde va el informe una vez que el grupo redujo la armadura de un objetivo. Aquí no hay una fila para ti y otra para los demás: es el trabajo del grupo, y el informe es para ti."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Incluir Fuego feérico"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Espera a Fuego feérico antes de informar, sea cual sea la versión que lance el druida. Se ignora cuando no hay ningún druida en el grupo."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Incluir Maldición de temeridad"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Espera a Maldición de temeridad antes de informar. Se ignora cuando no hay ningún brujo en el grupo."

L["TANKING_TOOLS_PARRY_HEADER"] = "Paradas"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Si un enemigo le para un golpe a alguien que no lo está tanqueando, esa persona está delante de él. Cada parada acelera el siguiente golpe de ese enemigo contra quien lo esté tanqueando."
L["TANKING_TOOLS_PARRY_ENABLE"] = "Notificar paradas contra"
L["TANKING_TOOLS_PARRY_MINE"] = "Mis paradas"
L["TANKING_TOOLS_PARRY_OTHERS"] = "Paradas de los demás"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS"] = "Ignorar a otros tanques"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS_DESC"] =
	"Guarda silencio cuando el jugador al que le paran es un tanque: el Tanque principal de la banda o alguien con el rol de Tanque. Un tanque secundario se pone delante del jefe para un cambio de provocación, y eso no es un error por el que haya que susurrarle. Los golpes que te paran a ti se siguen notificando."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Susurrar al culpable"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Envía al culpable una nota pidiéndole que se ponga detrás del enemigo. Solo se envía un susurro aunque varias personas de tu grupo usen Control Freak."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Cuánto tiempo se queda en silencio un mismo culpable después de disparar un aviso de parada. Cubre el mensaje, el sonido, el anuncio y el susurro, porque a quien todavía no se movió no hace falta decírselo en cada golpe."

L["TANKING_TOOLS_NOVA_HEADER"] = "Novas de Escarcha"
L["TANKING_TOOLS_NOVA_DESC"] =
	"Avisa de una Nova de Escarcha, que dispersa a los enemigos fuera del alcance del tanque."
L["TANKING_TOOLS_NOVA_ENABLE"] = "Notificar novas de Escarcha"
L["TANKING_TOOLS_NOVA_MINE"] = "Mis novas de Escarcha"
L["TANKING_TOOLS_NOVA_OTHERS"] = "Novas de Escarcha de los demás"

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
L["UNKNOWN_SOURCE"] = "Alguien"
L["UNKNOWN_CASTER"] = "un lanzador desconocido"
L["UNKNOWN_TARGET"] = "un objetivo desconocido"
L["UNKNOWN_SPELL"] = "un hechizo desconocido"

L["TAUNT_SUCCESS"] = "¡Provocación! %s usó %s contra %s."
L["TAUNT_AOE"] = "¡Provocación de área! %s usó %s."
L["TAUNT_MISSED"] = "¡Provocación fallida! %s usó %s contra %s y no acertó."
L["TAUNT_RESISTED"] = "¡Provocación fallida! %s usó %s contra %s y fue resistida."
--[[
    The one failure format that leads with the MOB rather than the taunter,
    because the immunity is the news and the other three formats have no news
    beyond "it did not land".

    TRANSLATORS: %s is, in order: mob, taunter, taunt. This is the ONLY taunt
    format whose first %s is not the player who cast it.
]]
L["TAUNT_IMMUNE"] = "¡Provocación fallida! %s es inmune: %s usó %s."
L["TAUNT_FAILED"] = "¡Provocación fallida! %s usó %s contra %s sin efecto."
L["INTERRUPT"] = "¡Interrupción! %s usó %s contra %s y cortó %s."

L["FEAR_SUCCESS"] = "¡Miedo! %s usó %s contra %s."
L["FEAR_AOE"] = "¡Miedo de área! %s usó %s."

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
L["INCAPACITATED"] = "%s incapacitado durante %s: %s sufre %s (%s) de %s."
L["INCAPACITATED_PLAIN"] = "%s incapacitado durante %s: %s sufre %s de %s."
L["INCAPACITATED_INDEFINITE"] = "%s incapacitado: %s sufre %s (%s) de %s."
L["INCAPACITATED_PLAIN_INDEFINITE"] = "%s incapacitado: %s sufre %s de %s."

--[[
    The seat the line opens on, as its own phrase rather than a format per role,
    which would be eight copies of the four above.

    TRANSLATORS: this is the client's own word for the group finder role, and it
    opens a sentence. "Afflicted by" in the formats above is deliberately the
    phrasing Blizzard's combat log uses for a debuff landing
    (AURAADDEDOTHERHARMFUL), so a player reads the same words here as in the log
    they already watch -- use your client's wording for both if it has one.
]]
L["INCAPACITATED_ROLE_TANK"] = "Tanque"
L["INCAPACITATED_ROLE_HEALER"] = "Sanador"

--[[
    The length, as its own phrase rather than a bare number with "seconds" in the
    format, so the singular does not need two more formats beside the four
    above. Always a whole number: the handler rounds UP, because a fear reported
    as 5.9 promises a taunt back sooner than it is coming.

    TRANSLATORS: the handler reads exactly these two, the first for 1 and the
    second for every other count, so a language with more number forms words
    the second to read for any count. An abbreviated unit does.
]]
L["INCAPACITATED_SECOND"] = "%d segundo"
L["INCAPACITATED_SECONDS"] = "%d segundos"

--[[
    The four debuff types a player can take off. They name the class that can
    help -- Magic is a priest or paladin, Curse a mage or druid -- so they are
    the half of the line a tank cannot act on alone.

    TRANSLATORS: use the client's own words for these, the ones on the debuff
    tooltips, not a literal translation of the English.
]]
L["DISPEL_MAGIC"] = "Magia"
L["DISPEL_CURSE"] = "Maldición"
L["DISPEL_DISEASE"] = "Enfermedad"
L["DISPEL_POISON"] = "Veneno"

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
L["TANK_DEATHS_TANK_LINE"] = "¡Tanque caído! %s murió."
L["TANK_DEATHS_CLASS_LINE"] = "¡%s caído! %s murió."

--[[
    Kept short on purpose: they render with a real spell link and two real names
    inside the 255 byte chat limit, and the widest locale runs close to twice the
    English.

    The WARNING carries no explanation and the WHISPER carries all of it. The
    warning fires mid-pull in front of a tank who already knows what a shield
    does; the whisper goes to the healer who does not, and is read after the
    fact. The tab description explains it at length for whoever wants it.
]]
L["SHIELD_WARNING"] = "¡Mal escudo! %s lanzó %s sobre %s."
L["SHIELD_WHISPER"] =
	"¡Mal escudo! Por favor, evita lanzar %s sobre %s. Esta habilidad impide que los tanques generen ira."

L["BAD_PET"] = "¡Mascota traviesa! La mascota de %s, %s, usó %s contra %s."
L["BAD_PET_AOE"] = "¡Mascota traviesa! La mascota de %s, %s, usó %s."
L["BAD_PET_OWN"] = "¡Mascota traviesa! Tu mascota %s usó %s contra %s."
L["BAD_PET_OWN_AOE"] = "¡Mascota traviesa! Tu mascota %s usó %s."
L["BAD_PET_UNKNOWN_OWNER"] = "¡Mascota traviesa! %s usó %s contra %s."
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "¡Mascota traviesa! %s usó %s."
--[[
    Kept short on purpose. It renders with a spell link and two names inside a 255
    byte chat limit, and the widest locale runs close to twice the English.
]]
L["BAD_PET_WHISPER"] =
	"Tu mascota %s usó %s contra %s. Haz clic derecho en la habilidad para desactivar el lanzamiento automático."

L["COLD_OPENER_MISS"] = "¡Cuidado! %s usó %s y no le dio a %s."
L["COLD_OPENER_DODGE"] = "¡Cuidado! %s usó %s y %s lo esquivó."
L["COLD_OPENER_PARRY"] = "¡Cuidado! %s usó %s y %s lo paró."
L["COLD_OPENER_BLOCK"] = "¡Cuidado! %s usó %s y %s lo bloqueó."
L["COLD_OPENER_IMMUNE"] = "¡Cuidado! %s usó %s y %s lo ignoró."
L["COLD_OPENER_RESIST"] = "¡Cuidado! %s usó %s y %s lo resistió."

L["ARMOR_REPORT"] = "¡Armadura reducida! %s quedó vulnerable a los %s segundos."

L["PARRY_WARNING"] = "¡Celeridad por parada! %s está frente a %s."
L["PARRY_WHISPER"] = "¡Celeridad por parada! Por favor, ponte detrás de %s: cada parada acelera su siguiente golpe."

L["NOVA"] = "¡Nova! %s usó %s contra %s."
L["NOVA_AOE"] = "¡Nova de área! %s usó %s."
