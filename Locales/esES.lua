local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "esES")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"Anunciador de combate para provocaciones, interrupciones, miedos, muertes de tanque, mascotas traviesas, paradas, perjuicios de armadura y otros eventos críticos del combate. Controla quién ha provocado, qué ha fallado, quién ha interrumpido un lanzamiento y qué ha ocurrido, con alertas personalizables."
L["VERSION"] = "Versión"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Versión %s. Los ajustes (incluida la opción de desactivar este mensaje) se encuentran en Opciones > Accesorios > Control Freak. ¿Te gusta el add-on? ¡Cuéntaselo a un amigo! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Como medida de seguridad, el panel de opciones no se puede abrir durante el combate."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Activar mensaje de bienvenida"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Muestra el saludo de Control Freak al iniciar sesión."
L["ENABLE_MINIMAP_BUTTON"] = "Activar botón del minimapa"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Muestra el botón de Control Freak en tu minimapa."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre el panel de opciones de este add-on."

--[[
    The add-on's own switch, above every feature's. The title names its REACH
    rather than the act of throwing it, which is what a player cannot read off
    the box beside it -- every other toggle on this panel governs one thing.

    Its ENABLE description is shared with the mini-map button's line for the same
    toggle, so the two cannot describe it differently.
]]
L["KILL_SWITCH"] = "Todas las alertas"
L["KILL_SWITCH_SUMMARY"] =
	"Un único interruptor para todas las alertas de todas las pestañas: al apagarlo el add-on se calla sin cambiar ni un ajuste, y un clic izquierdo en el botón del minimapa hace lo mismo desde cualquier parte."
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
L["TAB_INCAPACITATED"] = "Incapacitación"
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
	'Qué rol tienes que ocupar para que esta función diga algo. Cuentas como tanque cuando estás asignado como tanque principal en una banda, o cuando en un grupo tienes seleccionado el rol de tanque en el buscador de grupos. En una banda, el rol de tanque no significa nada. Cuentas como sanador solo cuando tienes seleccionado el rol de sanador en el buscador de grupos, ya que no hay ninguna asignación de banda para sanar. "Siempre" prescinde de la pregunta y avisa juegues de lo que juegues.'
L["SCOPE_GROUP_HAS_TANK"] = "Cuando el grupo tenga tanque"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Solo avisa mientras alguien de tu grupo esté tanqueando y siga vivo. En una banda eso significa un tanque principal asignado, así que para Control Freak una banda sin ninguno no tiene tanque. Un tanque caído cuenta como si no hubiera tanque, porque es justo entonces cuando ayuda que otro sostenga la amenaza."
L["SCOPE_INSTANCE_ONLY"] = "Cuando estés en una estancia"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Solo avisa dentro de mazmorras y bandas."

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
L["ALERT_SECTION_ENABLE_DESC"] = "Activa o desactiva esta alerta."
L["ALERT_SOUND"] = "Reproducir sonido"
L["ALERT_SOUND_DESC"] = "Reproduce un sonido cuando salta esta alerta."
L["ALERT_SOUND_FILE_DESC"] = "Elige el sonido que reproduce esta alerta. Al elegir uno, suena."
L["ALERT_SOUND_PREVIEW_DESC"] = "Reproduce este sonido ahora, tanto si el sonido está activado como si no."
L["SOUND_NONE"] = "Ninguno"

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
	"Informa de tus propios lanzamientos, incluidos los de tu mascota. El desplegable de al lado indica adónde va el mensaje."
L["ALERT_OTHERS_DESC"] =
	"Informa de los lanzamientos de todos los demás miembros de tu grupo. El desplegable de al lado indica adónde va el mensaje."
L["ALERT_OUTPUT_PRINT"] = "Mostrar (solo a mí)"
L["ALERT_OUTPUT_ANNOUNCE"] = "Anunciar"
L["ALERT_OUTPUT_DESC"] =
	'Adónde va este mensaje: a un solo sitio, nunca a los dos. "Mostrar (solo a mí)" lo pone en tu propia ventana y no le cuesta nada a nadie. "Anunciar" lo envía en su lugar al chat de grupo o de banda, y narrarle a toda la banda lo que hacen los demás es lo que hace que un add-on deje de ser bienvenido, así que merece la pena pensárselo. "Anunciar" no envía nada cuando no estás en un grupo, ni dentro de campos de batalla y arenas.'
L["ALERT_AGAINST_DESC"] =
	'Qué enemigos cuentan; cada opción incluye las que vienen después. Los jefes son enemigos de nivel calavera (??). Un jefe de mazmorra no lleva calavera propia, así que cuenta como élite: "Élites de tu nivel+ y jefes" es la opción que lo mantiene y descarta a los enemigos de relleno de menor nivel que lo rodean. Una marca de banda se impone a todo esto mientras la casilla "Avisar siempre con objetivos marcados" esté marcada.'
L["TARGET_RUNG_ALL"] = "Todo"
L["TARGET_RUNG_ELITE"] = "Élites y jefes"
L["TARGET_RUNG_ELITE_0"] = "Élites de tu nivel+ y jefes"
L["TARGET_RUNG_BOSS"] = "Jefes"
L["ALERT_MARKED_ALWAYS"] = "Avisar siempre con objetivos marcados"
L["ALERT_MARKED_ALWAYS_DESC"] =
	"Un objetivo con marca de banda (calavera, cruz, cualquiera de las ocho) cuenta diga lo que diga el desplegable junto a la casilla de notificación. Las marcas son la forma en que un grupo señala a los enemigos que importan, así que uno que alguien ha marcado nunca se descarta por no tener el rango o el nivel adecuados."

--[[
    The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
    list of seconds. Whole minutes read as minutes, and zero reads as "No
    Cooldown" rather than "0 Second Cooldown".

    TRANSLATORS: one format serves every count it is given, one minute and five
    alike, so word each to read for any number. An abbreviated unit does.
]]
L["COOLDOWN_NONE"] = "Sin reutilización"
L["COOLDOWN_SECONDS"] = "%d s de reutilización"
L["COOLDOWN_MINUTES"] = "%d min de reutilización"

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
L["SAMPLE_OTHER"] = "Pepe"
L["SAMPLE_PET"] = "Pelusa"

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
L["SAMPLE_BOSS_MOGRAINE"] = "Alto Señor Mograine"
L["SAMPLE_BOSS_KORTHAZZ"] = "Thane Korth'azz"
L["SAMPLE_BOSS_BLAUMEUX"] = "Lady Blaumeux"
L["SAMPLE_BOSS_ZELIEK"] = "Sir Zeliek"
L["SAMPLE_BOSS_PATCHWERK"] = "Remendejo"
L["SAMPLE_BOSS_GROBBULUS"] = "Grobbulus"
L["SAMPLE_BOSS_GLUTH"] = "Gluth"
L["SAMPLE_BOSS_THADDIUS"] = "Thaddius"
L["SAMPLE_BOSS_SAPPHIRON"] = "Safirón"
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
	"Una provocación que ha entrado y le ha quitado el enemigo a otra persona. Una provocación sobre un enemigo que ya estaba pegando a quien provoca solo refresca la amenaza y no salva a nadie, así que esas no se notifican."
L["TAUNTS_SUCCESS_ENABLE"] = "Notificar provocaciones logradas contra"
L["TAUNTS_SUCCESS_MINE"] = "Mis provocaciones logradas"
L["TAUNTS_SUCCESS_OTHERS"] = "Provocaciones logradas de los demás"

L["TAUNTS_FAILED_HEADER"] = "Provocaciones fallidas"
L["TAUNTS_FAILED_DESC"] =
	"Una provocación que ha fallado, ha sido resistida o ha dado en algo inmune. El enemigo no ha cambiado de manos, y nada en pantalla te lo indica."
L["TAUNTS_FAILED_ENABLE"] = "Notificar provocaciones fallidas contra"
L["TAUNTS_FAILED_MINE"] = "Mis provocaciones fallidas"
L["TAUNTS_FAILED_OTHERS"] = "Provocaciones fallidas de los demás"

L["TAUNTS_AOE_HEADER"] = "Provocaciones de área"
L["TAUNTS_AOE_DESC"] = "Una provocación que atrae de golpe todo lo que tiene alrededor, en vez de a un solo objetivo."
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
L["INTERRUPTS_ALERT_DESC"] = "Un lanzamiento cortado a medias. Indica quién lo ha cortado y qué ha cortado."
L["INTERRUPTS_ALERT_ENABLE"] = "Notificar interrupciones logradas contra"
L["INTERRUPTS_ALERT_MINE"] = "Mis interrupciones logradas"
L["INTERRUPTS_ALERT_OTHERS"] = "Interrupciones logradas de los demás"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Los miedos hacen huir a los enemigos y los desperdigan por toda la sala."
L["FEARS_ENABLE"] = "Activar vigilancia de miedos"

L["FEARS_ALERT_HEADER"] = "Miedos logrados"
L["FEARS_ALERT_DESC"] =
	"Un miedo que ha entrado y ha desperdigado a los enemigos fuera del alcance del tanque. Solo cuenta si entra: un simple lanzamiento, una resistencia o una inmunidad no mueven a nadie, así que no se notifica ninguno de ellos."
L["FEARS_ALERT_ENABLE"] = "Notificar miedos logrados"
L["FEARS_ALERT_MINE"] = "Mis miedos logrados"
L["FEARS_ALERT_OTHERS"] = "Miedos logrados de los demás"

L["FEARS_ABILITIES_HEADER"] = "Habilidades de miedo"

--------------------------------------------------------------------------------
-- Incapacitated
--------------------------------------------------------------------------------

L["INCAPACITATED_SUMMARY"] =
	"Avisa a tu grupo en cuanto pierdas el control de tu personaje, para que otra persona pueda cubrirte. Un tanque aterrorizado y un sanador silenciado son las dos personas que más necesitan decirlo, y las que menos pueden hacerlo en ese momento."
L["INCAPACITATED_ENABLE"] = "Activar vigilancia de incapacitaciones"

L["INCAPACITATED_HEADER"] = "Estar incapacitado"
L["INCAPACITATED_DESC"] =
	"Avisa al grupo cuando te aturden, te aterrorizan, te silencian o te sacan de la pelea de cualquier otra forma: qué te ha caído, quién lo ha lanzado, cuánto dura y si alguien puede quitártelo."
--[[
    No trailing preposition and nothing beside it: this alert has no target
    ladder, and its "Long" threshold is a row of its own, above the two rows it
    names.
]]
L["INCAPACITATED_ALERT_ENABLE"] = "Notificar cuando te incapaciten"
--[[
    The only pair of rows in the add-on that is not My and Others'. The game
    reports the player's own losses of control and nobody else's, so "whose"
    has one answer; how LONG it lasts is the question with two.

    TRANSLATORS: keep the quotes around Long in the caption. They mark it as the
    word the two rows below are named after rather than as an adjective.
]]
L["INCAPACITATED_LONG_CAPTION"] = 'Mínimo para incapacitación "larga"'
L["INCAPACITATED_LONG_CAPTION_DESC"] =
	"Cuánto tiene que durar una pérdida de control para contar como larga. Si dura menos, es corta. No se descarta ninguna: las dos filas de abajo indican adónde va cada una, y de serie apuntan a sitios distintos."
-- The caption's dropdown: the first reads for 1 only, the second for 2 to 10.
L["INCAPACITATED_THRESHOLD_ONE"] = "%d segundo"
L["INCAPACITATED_THRESHOLD"] = "%d segundos"
L["INCAPACITATED_SHORT"] = "Mi incapacitación corta"
L["INCAPACITATED_SHORT_DESC"] =
	"Adónde va el mensaje cuando te sacan de la pelea durante menos tiempo del indicado arriba. De serie se muestra en tu propia ventana: un aturdimiento del que te recuperas antes de que nadie haya podido cubrirte explica el tiempo de reutilización global que acabas de perder, y no es problema de nadie más."
L["INCAPACITATED_LONG"] = "Mi incapacitación larga"
L["INCAPACITATED_LONG_DESC"] =
	"Adónde va el mensaje cuando te sacan de la pelea durante al menos el tiempo indicado arriba. De serie se anuncia: es la que da tiempo a los demás para actuar, y tú eres la única persona que no puede decirlo. Un efecto sin duración, como un Control mental, cuenta como incapacitación larga."

L["INCAPACITATED_STUN"] = "Incluir aturdimientos"
L["INCAPACITATED_STUN_DESC"] =
	"Pérdida total de control, sin moverte del sitio. Los efectos de sueño cuentan como aturdimiento."
L["INCAPACITATED_FEAR"] = "Incluir miedos"
L["INCAPACITATED_FEAR_DESC"] =
	"Pérdida total de control, corriendo en direcciones aleatorias. El enemigo se va detrás de ti."
L["INCAPACITATED_CHARM"] = "Incluir control mental"
L["INCAPACITATED_CHARM_DESC"] =
	"Completamente bajo el control de otra persona. Suele ser lo peor de esta lista, y suele durar indefinidamente."
L["INCAPACITATED_CONFUSE"] = "Incluir confusión"
L["INCAPACITATED_CONFUSE_DESC"] = "Pérdida total de control, caminando en direcciones aleatorias."
L["INCAPACITATED_SILENCE"] = "Incluir silencios"
L["INCAPACITATED_SILENCE_DESC"] =
	"No puedes lanzar hechizos. La provocación de un druida o de un paladín es un hechizo, así que es una provocación que no va a llegar."
L["INCAPACITATED_PACIFY"] = "Incluir pacificaciones"
L["INCAPACITATED_PACIFY_DESC"] = "No puedes atacar, aunque los hechizos siguen funcionando."
L["INCAPACITATED_SCHOOL_INTERRUPT"] = "Incluir bloqueos de hechizos"
L["INCAPACITATED_SCHOOL_INTERRUPT_DESC"] =
	"No puedes lanzar hechizos de una escuela. Merece la pena tenerlo si provocas con un hechizo, ya que un druida o un paladín bloqueado en Naturaleza o Sagrado se queda sin provocación."
L["INCAPACITATED_ROOT"] = "Incluir inmovilizaciones"
L["INCAPACITATED_ROOT_DESC"] =
	"No puedes moverte. Un tanque inmovilizado sigue teniendo el botón de provocación, así que el enemigo no se va a ninguna parte."
L["INCAPACITATED_DISARM"] = "Incluir desarmes"
L["INCAPACITATED_DISARM_DESC"] =
	"No puedes atacar con armas. Igual que con las inmovilizaciones, el botón de provocación sigue funcionando."

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
	"El tanque de tu grupo ha muerto. Es la única muerte que cambia lo que deben hacer los demás a continuación, y cuarenta retratos de banda son el peor sitio para darse cuenta."
L["TANK_DEATHS_ENABLE"] = "Activar vigilancia de muertes de tanque"

L["TANK_DEATHS_ALERT_HEADER"] = "Muertes de tanque"
L["TANK_DEATHS_ALERT_DESC"] =
	"En una banda solo cuenta a los jugadores asignados como tanque principal, tú incluido, y un rol del buscador de grupos no significa nada allí. En un grupo cuenta a quien tenga seleccionado el rol de tanque en el buscador de grupos. Un tanque sin ninguna de las dos cosas muere sin aviso."
L["TANK_DEATHS_ALERT_ENABLE"] = "Notificar muertes de tanque"
L["TANK_DEATHS_ALERT_MINE"] = "Mi muerte"
L["TANK_DEATHS_ALERT_MINE_DESC"] =
	"Informa de tu propia muerte mientras tanqueas. El desplegable de al lado indica adónde va el mensaje."
L["TANK_DEATHS_ALERT_OTHERS"] = "Muertes de tanque de los demás"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] =
	"Informa de la muerte de cualquier otro miembro de tu grupo que esté tanqueando. El desplegable de al lado indica adónde va el mensaje."

L["TANK_DEATHS_CLASS_HEADER"] = "Muertes por clase"
L["TANK_DEATHS_CLASS_DESC"] = "Todas las demás muertes, por clase, para las que quieras vigilar."
L["TANK_DEATHS_CLASS_ROW_DESC"] = "Avisa cuando muere un %s de tu grupo."

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] =
	"Sanadores que hacen algo que perjudica a un tanque más de lo que le ayuda. Solo en Classic y Burning Crusade: la Temporada de Descubrimiento devuelve la ira mediante una runa de sacerdote, y nada de esto es un problema en versiones posteriores del juego."
L["BAD_PRIESTS_ENABLE"] = "Activar vigilancia de sacerdotes traviesos"

L["BAD_PRIESTS_HEADER"] = "Escudos inoportunos"
L["BAD_PRIESTS_DESC"] =
	"Avisa cuando Palabra de poder: escudo cae sobre un druida o guerrero que está tanqueando. La ira sale del daño recibido, y el daño que absorbe un escudo no genera nada, así que un escudo bienintencionado deja al tanque sin la ira con la que mantiene la amenaza."
L["BAD_PRIESTS_ALERT_ENABLE"] = "Notificar escudos inoportunos"
L["BAD_PRIESTS_HEALTH_DESC"] =
	'Cuánto tiene que bajar la salud del tanque para que un escudo deje de ser un error. Un escudo sobre alguien a punto de morir es lo correcto, así que el aviso no salta por debajo del nivel que elijas aquí. Elige "Siempre" para enterarte de todos los escudos.'
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "Siempre"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "Salvo bajo el %d%% de salud"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "Avisos de escudo inoportuno"
L["BAD_PRIESTS_REPORT_DESC"] =
	"Adónde va el aviso cuando alguien le pone un escudo a un tanque de ira. Aquí no hay una fila para ti y otra para los demás: el lanzamiento es del sanador y el problema, del tanque."
L["BAD_PRIESTS_SELF_ONLY"] = "Cuando juegues de tanque druida o guerrero"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"Solo avisa de los escudos que caen sobre ti, y solo mientras seas un druida o guerrero que está tanqueando. Desactívalo para enterarte de los escudos que caen sobre cualquiera de tu grupo que esté tanqueando con una de esas clases."
L["BAD_PRIESTS_WHISPER"] = "Susurrar al lanzador"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"Envía a quien haya lanzado el escudo una nota explicando por qué perjudica. Solo se envía una aunque varias personas de tu grupo usen Control Freak."
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"Cuánto tiempo guarda silencio Control Freak sobre un mismo lanzador después de que haga saltar un aviso de escudo. Cubre el aviso en tu ventana, el sonido, el anuncio y el susurro, porque un sanador que pone escudos en cuanto se le recargan no debe llenarte la ventana."

--------------------------------------------------------------------------------
-- Bad Pets
--------------------------------------------------------------------------------

L["BAD_PETS_SUMMARY"] =
	"Mascotas de cazador y de brujo con el lanzamiento automático de habilidades de amenaza activado."
L["BAD_PETS_ENABLE"] = "Activar vigilancia de mascotas traviesas"

L["BAD_PETS_ALERT_HEADER"] = "Provocaciones de mascota"
L["BAD_PETS_ALERT_DESC"] =
	"Una mascota que le quita el enemigo al tanque por tener el lanzamiento automático activado, normalmente sin que su dueño se entere."
L["BAD_PETS_ALERT_ENABLE"] = "Notificar provocaciones de mascota contra"
L["BAD_PETS_ALERT_MINE"] = "Provocaciones de mi mascota"
L["BAD_PETS_ALERT_OTHERS"] = "Provocaciones de mascotas de los demás"
L["BAD_PETS_WHISPER_ENABLE"] = "Susurrar al dueño de la mascota"
L["BAD_PETS_WHISPER_ENABLE_DESC"] =
	"Envía al dueño de la mascota una nota explicando cómo desactivar el lanzamiento automático. Solo se envía una aunque varias personas de tu grupo usen Control Freak."
L["BAD_PETS_COOLDOWN_DESC"] =
	"Cuánto tiempo guarda silencio Control Freak sobre una misma mascota después de que haga saltar una alerta. Cubre el aviso en tu ventana, el sonido, el anuncio y el susurro, para que una mascota con el lanzamiento automático activado no te llene la ventana y a su dueño no le llegue otro susurro cada pocos segundos."

L["BAD_PETS_ABILITIES_HEADER"] = "Habilidades de mascota traviesa"

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
L["TANKING_TOOLS_ENABLE"] = "Activar utilidades de tanque"
L["TANKING_TOOLS_MINIMAP_SUMMARY"] = "Aperturas fallidas, perjuicios de armadura, paradas y Novas de Escarcha."

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Aperturas fallidas"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Avisa de tus propios ataques de apertura que no han llegado a entrar: un fallo, una esquiva, una parada, un bloqueo, una resistencia o una inmunidad en los primeros segundos de un combate. Amenaza que nunca llegó a generarse, justo cuando más importa."
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Notificar aperturas fallidas contra"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "Mis aperturas fallidas"
L["TANKING_TOOLS_COLD_OPENER_MINE_DESC"] =
	"Informa de tus propias habilidades de apertura que no han llegado a entrar. El desplegable de al lado indica adónde va el mensaje."
-- The caption before the window dropdown: "Within [10 Seconds of Fight]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "En los primeros"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d segundos de combate"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Cuánto tiempo después de empezar un combate sigue contando una habilidad evitada. El reloj arranca la primera vez que Control Freak ve a ese enemigo, y solo cuentan las habilidades: un ataque automático falla demasiado a menudo como para ser noticia."

L["TANKING_TOOLS_ARMOR_HEADER"] = "Perjuicios de armadura"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Informa de cuánto ha tardado el grupo en reducir la armadura de un objetivo: cinco acumulaciones de Hender armadura o un Exponer armadura de pícaro. Si marcas una de las filas Incluir de abajo, también espera a ese perjuicio, pero solo cuando alguien del grupo pueda lanzarlo de verdad."
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Notificar perjuicios de armadura contra"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "Informes de perjuicios de armadura"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	"Adónde va el informe una vez que el grupo ha reducido la armadura de un objetivo. Aquí no hay una fila para ti y otra para los demás: es trabajo del grupo, contado a ti."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Incluir Fuego feérico"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Espera a Fuego feérico antes de informar, sea cual sea la versión que lance el druida. Se ignora si no hay ningún druida en el grupo."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Incluir Maldición de temeridad"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Espera a Maldición de temeridad antes de informar. Se ignora si no hay ningún brujo en el grupo."

L["TANKING_TOOLS_PARRY_HEADER"] = "Paradas"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Si un enemigo le para un golpe a alguien que no lo está tanqueando, es que ese alguien está delante de él. Cada parada acelera el siguiente golpe del enemigo contra quien lo esté tanqueando."
L["TANKING_TOOLS_PARRY_ENABLE"] = "Notificar paradas contra"
L["TANKING_TOOLS_PARRY_MINE"] = "Mis paradas"
L["TANKING_TOOLS_PARRY_MINE_DESC"] =
	"Informa cuando un enemigo para tus ataques. El desplegable de al lado indica adónde va el mensaje."
L["TANKING_TOOLS_PARRY_OTHERS"] = "Paradas de los demás"
L["TANKING_TOOLS_PARRY_OTHERS_DESC"] =
	"Informa cuando un enemigo para los ataques de cualquier otro miembro de tu grupo. El desplegable de al lado indica adónde va el mensaje."
L["TANKING_TOOLS_PARRY_IGNORE_TANKS"] = "Ignorar a los tanques"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS_DESC"] =
	"No avisa cuando el jugador al que le paran el golpe es un tanque: asignado como tanque principal en una banda, o con el rol de tanque del buscador de grupos en un grupo. Un segundo tanque se coloca delante del jefe para un cambio de provocación, y eso no es un error por el que haya que susurrarle. Tus propias paradas se siguen notificando."
L["TANKING_TOOLS_PARRY_IGNORE_PETS"] = "Ignorar a las mascotas"
L["TANKING_TOOLS_PARRY_IGNORE_PETS_DESC"] =
	"No avisa cuando el golpe parado venía de una mascota, la tuya incluida. Una mascota está donde su dueño la mandó, y una línea con el nombre de la mascota no le da nada que hacer a nadie del grupo. A las mascotas nunca se les susurra, en ningún caso."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Susurrar al culpable"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Envía al culpable una nota pidiéndole que se ponga detrás del enemigo. Solo se envía una aunque varias personas de tu grupo usen Control Freak."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Cuánto tiempo guarda silencio Control Freak sobre un mismo culpable después de que haga saltar un aviso de parada. Cubre el aviso en tu ventana, el sonido, el anuncio y el susurro, porque a quien todavía no se ha movido no hace falta repetírselo en cada golpe."

L["TANKING_TOOLS_NOVA_HEADER"] = "Novas de Escarcha"
L["TANKING_TOOLS_NOVA_DESC"] =
	"Avisa de una Nova de Escarcha, que congela a los enemigos donde están, fuera del alcance del tanque."
L["TANKING_TOOLS_NOVA_ENABLE"] = "Notificar Novas de Escarcha"
L["TANKING_TOOLS_NOVA_MINE"] = "Mis Novas de Escarcha"
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

L["TAUNT_SUCCESS"] = "¡Provocación! %s ha usado %s contra %s."
L["TAUNT_AOE"] = "¡Provocación de área! %s ha usado %s."
L["TAUNT_MISSED"] = "¡Provocación fallida! %s ha usado %s contra %s y no ha acertado."
L["TAUNT_RESISTED"] = "¡Provocación fallida! %s ha usado %s contra %s, que lo ha resistido."
--[[
    The one failure format that leads with the MOB rather than the taunter,
    because the immunity is the news and the other three formats have no news
    beyond "it did not land".

    TRANSLATORS: %s is, in order: mob, taunter, taunt. This is the ONLY taunt
    format whose first %s is not the player who cast it.
]]
L["TAUNT_IMMUNE"] = "¡Provocación fallida! %s es inmune: %s ha usado %s."
L["TAUNT_FAILED"] = "¡Provocación fallida! %s ha usado %s contra %s sin efecto."
L["INTERRUPT"] = "¡Interrupción! %s ha usado %s contra %s y ha cortado %s."

L["FEAR_SUCCESS"] = "¡Miedo! %s ha usado %s contra %s."
L["FEAR_AOE"] = "¡Miedo de área! %s ha usado %s."

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
L["TANK_DEATHS_TANK_LINE"] = "¡Tanque caído! %s ha muerto."
L["TANK_DEATHS_CLASS_LINE"] = "¡%s caído! %s ha muerto."

--[[
    Kept short on purpose: they render with a real spell link and two real names
    inside the 255 byte chat limit, and the widest locale runs close to twice the
    English.

    The WARNING carries no explanation and the WHISPER carries all of it. The
    warning fires mid-pull in front of a tank who already knows what a shield
    does; the whisper goes to the healer who does not, and is read after the
    fact. The tab description explains it at length for whoever wants it.
]]
L["SHIELD_WARNING"] = "¡Escudo inoportuno! %s ha lanzado %s sobre %s."
L["SHIELD_WHISPER"] =
	"¡Escudo inoportuno! Por favor, evita lanzar %s sobre %s. Esta habilidad impide que los tanques generen ira."

L["BAD_PET"] = "¡Mascota traviesa! La mascota de %s, %s, ha usado %s contra %s."
L["BAD_PET_AOE"] = "¡Mascota traviesa! La mascota de %s, %s, ha usado %s."
L["BAD_PET_UNKNOWN_OWNER"] = "¡Mascota traviesa! %s ha usado %s contra %s."
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "¡Mascota traviesa! %s ha usado %s."
--[[
    Kept short on purpose. They render with a spell link and up to two names inside
    a 255 byte chat limit, and the widest locale runs close to twice the English.
]]
L["BAD_PET_WHISPER"] =
	"Tu mascota %s ha usado %s contra %s. Haz clic derecho en la habilidad para desactivar el lanzamiento automático."
L["BAD_PET_WHISPER_AOE"] =
	"Tu mascota %s ha usado %s. Haz clic derecho en la habilidad para desactivar el lanzamiento automático."

L["COLD_OPENER_MISS"] = "¡Cuidado! %s ha usado %s y no ha acertado a %s."
L["COLD_OPENER_DODGE"] = "¡Cuidado! %s ha usado %s y %s lo ha esquivado."
L["COLD_OPENER_PARRY"] = "¡Cuidado! %s ha usado %s y %s lo ha parado."
L["COLD_OPENER_BLOCK"] = "¡Cuidado! %s ha usado %s y %s lo ha bloqueado."
L["COLD_OPENER_IMMUNE"] = "¡Cuidado! %s ha usado %s y %s lo ha ignorado."
L["COLD_OPENER_RESIST"] = "¡Cuidado! %s ha usado %s y %s lo ha resistido."

L["ARMOR_REPORT"] = "¡Armadura reducida! %s ha quedado vulnerable tras %s segundos."

L["PARRY_WARNING"] = "¡Aceleración por parada! %s está delante de %s."
L["PARRY_WHISPER"] =
	"¡Aceleración por parada! Por favor, ponte detrás de %s: cada parada acelera su siguiente golpe."

L["NOVA"] = "¡Nova! %s ha usado %s contra %s."
L["NOVA_AOE"] = "¡Nova de área! %s ha usado %s."
