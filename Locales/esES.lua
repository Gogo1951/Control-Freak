local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "esES")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["ADDON_SHORT_NAME"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"Anunciador de combate para provocaciones, interrupciones, miedos, muertes de tanque, mascotas traviesas, paradas, perjuicios de armadura y otros eventos críticos del combate. Controla quién ha provocado, qué ha fallado, quién ha interrumpido un lanzamiento y qué ha ocurrido, con alertas personalizables."

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Versión %s. Los ajustes (incluida la opción de desactivar este mensaje) están en Opciones > Accesorios > Control Freak. ¿Te gusta este add-on? Cuéntaselo a un amigo, márcalo como favorito en CurseForge o dale una estrella en GitHub. (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Como medida de seguridad, el panel de opciones no se puede abrir durante el combate."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Activar mensaje de bienvenida"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Muestra el saludo de Control Freak al iniciar sesión."
L["ENABLE_MINIMAP_BUTTON"] = "Activar botón del minimapa"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Muestra el botón de Control Freak en tu minimapa."

L["OPTIONS_MASTER_SWITCH_HEADER"] = "Interruptor general"
L["OPTIONS_FEATURES_HEADER"] = "Funciones"
-- The Features block's group switches and their tooltip, whose %s is the group's own name, then each group's page summary. Its other switches read each tab's own name (TAB_*).
L["OPTIONS_MONITORING_LABEL"] = "Vigilancia"
L["OPTIONS_NAUGHTY_LIST_LABEL"] = "Lista de traviesos"
L["OPTIONS_GROUP_ENABLE_DESC"] =
	"Desactiva de una vez todo lo que hay en %s, o vuelve a activarlo. Cada función conserva su propio interruptor, así que al reactivarlo recuperas exactamente lo que tenías."
L["OPTIONS_MONITORING_SUMMARY"] =
	'Lo que ha pasado en el combate: provocaciones, interrupciones, miedos, perder el control de tu personaje, muertes del tanque y los tiempos de reutilización de un compañero de clase. Al desactivar "Vigilancia" se silencian las seis a la vez, y cada una conserva su propio interruptor.'
L["OPTIONS_NAUGHTY_LIST_SUMMARY"] =
	'Alguien del grupo que le complica el trabajo al tanque: la nova de un mago, alguien que no es tanque y al que un jefe le para los golpes, una mascota con la provocación activada, el escudo de un sacerdote sobre un tanque de ira. Al desactivar "Lista de traviesos" se silencian las cuatro a la vez, y cada una conserva su propio interruptor.'

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre el panel de opciones de este add-on."

--[[
    The add-on's own switch. KILL_SWITCH names it in the status line a silenced
    page opens on, naming its REACH rather than the act of throwing it.
    KILL_SWITCH_ENABLE captions it under the General panel's Master Switch
    header, and KILL_SWITCH_ENABLE_DESC is that switch's tooltip.
]]
L["KILL_SWITCH"] = "Todas las alertas"
L["KILL_SWITCH_ENABLE"] = "Activar Control Freak"
L["KILL_SWITCH_ENABLE_DESC"] = "Activa o desactiva todas las alertas de Control Freak."

--------------------------------------------------------------------------------
-- Feedback & Support Panel
--------------------------------------------------------------------------------

L["OPTIONS_LEVEL_UP_TITLE"] = "Ayuda a Control Freak a subir de nivel"
L["OPTIONS_LEVEL_UP_INTRO"] =
	"Este add-on lo han creado jugadores a los que les encanta este juego y que quieren hacerlo lo más divertido posible para todos. Nunca pediremos donativos. La verdadera satisfacción es saber que nuestro trabajo hace el juego un poco mejor para ti. Si es así, ¡nos encantaría saberlo!"
L["OPTIONS_LEVEL_UP_WAYS"] = "Estas son algunas formas de ayudarnos a llegar a más jugadores."
L["OPTIONS_LEVEL_UP_FEEDBACK"] =
	"• Comparte tus comentarios: ¿Has encontrado un error o tienes una idea? Cuéntanoslo en Discord. Tus comentarios nos ayudan a mejorar el add-on, y los pull requests siempre son bienvenidos."
L["OPTIONS_LEVEL_UP_FRIEND"] =
	"• Cuéntaselo a un amigo: ¿Conoces a alguien a quien le pueda gustar este add-on? Háblale de él. El boca a boca ayuda a más jugadores a descubrir grandes add-ons."
L["OPTIONS_LEVEL_UP_CURSEFORGE"] =
	'• Favorito en CurseForge: Abre el enlace de CurseForge de abajo, inicia sesión y haz clic en la estrella que hay bajo el botón "Download". Los favoritos ayudan a más jugadores a descubrir el add-on.'
L["OPTIONS_LEVEL_UP_GITHUB"] =
	'• Estrella en GitHub: Abre el enlace de GitHub de abajo, inicia sesión y haz clic en "Star", arriba a la derecha. Las estrellas ayudan al proyecto a optar a más herramientas gratuitas para desarrolladores.'
L["OPTIONS_LEVEL_UP_THANKS"] = "¡Gracias por elegir Control Freak!"

L["OPTIONS_FEEDBACK"] = "Comentarios y soporte"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "Enlaces de comentarios y soporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] = "Para copiar un enlace, haz clic en su casilla y pulsa Ctrl+A y Ctrl+C."
L["OPTIONS_VERSION"] = "Versión %s"

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
L["MINIMAP_SHIFT_LEFT_CLICK"] = "Mayús + clic izquierdo"
L["SHIFT_MIDDLE_CLICK"] = "Mayús + clic central"
L["ACTION_TOGGLE"] = "Alternar"
L["MINIMAP_OPTIONS"] = "Opciones de Control Freak"
--[[
    Each block's summary names everything its switch reaches, to show a player
    what there is to turn on. TRANSLATORS: keep each to two lines in the
    tooltip. TANKING_TOOLS_MINIMAP_SUMMARY, the third, sits with its tab below.
]]
L["MONITORING_MINIMAP_SUMMARY"] =
	"Provocaciones, interrupciones, miedos, incapacitación, muertes del tanque y presión de grupo."
L["NAUGHTY_LIST_MINIMAP_SUMMARY"] =
	"Novas de Escarcha, monos de paradas, mascotas con la provocación activada y escudos sobre tanques de ira."
-- Replaces the three blocks while All Alerts is off, since none of their clicks would do anything.
L["MINIMAP_ALL_ALERTS_OFF"] = '"Todas las alertas" está desactivado, así que no salta nada.'

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

-- In tab order.
L["TAB_TAUNTS"] = "Provocaciones"
L["TAB_INTERRUPTS"] = "Interrupciones"
L["TAB_FEARS"] = "Miedos"
L["TAB_INCAPACITATED"] = "Incapacitación"
L["TAB_TANK_DEATHS"] = "Muertes de tanque"
L["TAB_PEER_PRESSURE"] = "Presión de grupo"
L["TAB_BAD_MAGES"] = "Magos traviesos"
L["TAB_BAD_PARRY_MONKEYS"] = "Monos de paradas traviesos"
L["TAB_BAD_PETS"] = "Mascotas traviesas"
L["TAB_BAD_PRIESTS"] = "Sacerdotes traviesos"
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
L["SCOPE_INSTANCE_ONLY"] = "Cuando estés en una instancia"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Solo avisa dentro de mazmorras y bandas."

--[[
    The line at the top of a page that a switch somewhere else has silenced:
    All Alerts on any feature page, the group a feature tab sits under, or the
    feature a sub-page belongs to. A group uses STATUS_FEATURE_OFF too.

    TRANSLATORS: in both, the first %s is the name of the switch that is off
    (drawn gold) and the second is STATUS_OFF (drawn red). The rest are plain
    names: in STATUS_ALL_ALERTS_OFF the switch's caption and then the page it
    is on, in STATUS_FEATURE_OFF the page it is on. STATUS_OFF is the single
    word for a switch being off.
]]
L["STATUS_OFF"] = "desactivado"
L["STATUS_ALL_ALERTS_OFF"] =
	"%s: %s, así que esta página no avisa de nada. Su interruptor, %s, está en la página %s."
L["STATUS_FEATURE_OFF"] = "%s: %s, así que esta página no avisa de nada. Su interruptor está en la página %s."

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
    The block every tab draws: whose cast is the row, beside it a Print box and
    an Announce dropdown, and the target filter is a ladder rather than a
    switch. Each section names its own two rows -- see
    TAUNTS_SUCCESS_MINE below -- because "My" and "Others'" agree with the noun
    in some languages and a shared "%s" template could not.

    TRANSLATORS: ALERT_AGAINST_DESC quotes one rung and one row by name; that
    wording must match your TARGET_RUNG_ELITE_0 and ALERT_MARKED_ALWAYS, or the
    tooltip explains a choice the player cannot find. ALERT_PRINT_DESC and
    ALERT_ANNOUNCE_DESC quote the Announce choices the same way. Keep
    ALERT_PRINT_HEADER short: it heads a narrow column of boxes. The four
    rungs are a threshold, widest first: each one counts itself and the ones
    after it, which is why every rung that includes bosses says so. Keep that
    in your translations -- a rung reading only "Elites" beside a separate
    "Bosses" reads as two disjoint sets.

    ALERT_MARKED_ALWAYS is the one control that WIDENS a section rather than
    narrowing it: a marked target counts whatever the rung says. Keep "Always"
    in it, and keep it distinct from the Announce choices -- this row decides
    WHETHER the alert fires, never where its line goes.
]]
L["ALERT_MINE_DESC"] = "Tus propios lanzamientos, incluidos los de tu mascota."
L["ALERT_OTHERS_DESC"] = "Los lanzamientos de todos los demás miembros de tu grupo."
-- The two column headers over a section's rows, then the Announce dropdown's three choices.
L["ALERT_PRINT_HEADER"] = "Mostrar (solo yo)"
L["ALERT_ANNOUNCE_HEADER"] = "Anunciar"
L["ALERT_ANNOUNCE_NEVER"] = "Nunca"
L["ALERT_ANNOUNCE_PARTY"] = "En un grupo"
L["ALERT_ANNOUNCE_GROUP"] = "En grupo o banda"
L["ALERT_PRINT_DESC"] =
	'Si está marcada, el mensaje se muestra en tu propia ventana siempre que no se anuncie: cuando vas solo, cuando "Anunciar" está en "Nunca", cuando "En un grupo" se encuentra con una banda, o dentro de un campo de batalla o una arena. Un mensaje anunciado ya aparece en tu chat, así que nunca se muestra dos veces.'
L["ALERT_ANNOUNCE_DESC"] =
	'Quién más ve el mensaje. "En un grupo" lo envía al chat de grupo en un grupo de cinco o menos, y no dice nada en una banda. "En grupo o banda" lo envía al chat de grupo o de banda, según dónde estés. Narrarle a toda la banda lo que hacen los demás es lo que hace que un add-on deje de ser bienvenido, así que conviene pensarse bien esa opción. No se anuncia nada cuando no estás en un grupo, ni dentro de campos de batalla y arenas.'
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
    from the real message format below, so a reworded alert cannot leave a
    hand-copied example quoting the old text. The player's own name is the
    character they are on; SAMPLE_PLAYER stands in only until the client knows
    it. The other players' names are proper names in Data/Data.lua, the same in
    every locale. The pet's is translatable because it sits inside a sentence
    whose grammar a locale may want to agree with.
]]
L["SAMPLE_EXAMPLE"] = "Ejemplo: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_PET"] = "Pelusa"

--[[
    The Molten Core and Blackwing Lair bosses the Example lines name, dealt one
    per line.

    TRANSLATORS: use each boss's name exactly as your client writes it, title
    included, not a translation of the English.
]]
L["SAMPLE_BOSS_LUCIFRON"] = "Lucifron"
L["SAMPLE_BOSS_MAGMADAR"] = "Magmadar"
L["SAMPLE_BOSS_GEHENNAS"] = "Gehennas"
L["SAMPLE_BOSS_GARR"] = "Garr"
L["SAMPLE_BOSS_SHAZZRAH"] = "Shazzrah"
L["SAMPLE_BOSS_GEDDON"] = "Barón Geddon"
L["SAMPLE_BOSS_GOLEMAGG"] = "Golemagg el Incinerador"
L["SAMPLE_BOSS_SULFURON"] = "Sulfuron Presagista"
L["SAMPLE_BOSS_MAJORDOMO"] = "Mayordomo Executus"
L["SAMPLE_BOSS_RAGNAROS"] = "Ragnaros"
L["SAMPLE_BOSS_RAZORGORE"] = "Sangrevaja el Indomable"
L["SAMPLE_BOSS_VAELASTRASZ"] = "Vaelastrasz el Corrupto"
L["SAMPLE_BOSS_BROODLORD"] = "Señor de prole Capazote"
L["SAMPLE_BOSS_FIREMAW"] = "Faucefogo"
L["SAMPLE_BOSS_EBONROC"] = "Ebanorroca"
L["SAMPLE_BOSS_FLAMEGOR"] = "Flamagor"
L["SAMPLE_BOSS_CHROMAGGUS"] = "Chromaggus"
L["SAMPLE_BOSS_NEFARIAN"] = "Nefarian"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["TRACKED_HEADER"] = "Habilidades rastreadas"
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
L["TAUNTS_AOE_DESC"] =
	"Una provocación que atrae de golpe todo lo que tiene alrededor, en vez de a un solo objetivo. Se notifica cada lanzamiento, alcance a lo que alcance, aunque el grupo no tenga tanque."
L["TAUNTS_AOE_ENABLE"] = "Notificar provocaciones de área"
L["TAUNTS_AOE_MINE"] = "Mis provocaciones de área"
L["TAUNTS_AOE_OTHERS"] = "Provocaciones de área de los demás"

L["TAUNTS_ABILITIES_DESC"] =
	'Desmarca una provocación para dejar de rastrearla. El desplegable de al lado elige entre "Objetivo único" y "Área".'
-- The same intro on a client where no taunt's kind can be picked, so no row carries a dropdown.
L["TAUNTS_ABILITIES_DESC_NO_CHOICE"] = "Desmarca una provocación para dejar de rastrearla."
L["TAUNTS_KIND_SINGLE"] = "Objetivo único"
L["TAUNTS_KIND_AOE"] = "Área"
L["TAUNTS_KIND_DESC"] =
	'Esta provocación atrae a unos pocos enemigos a la vez, así que puede notificarse de las dos formas. La opción "Objetivo único" nombra a cada enemigo atraído, en "Provocaciones logradas", e informa de sus fallos en "Provocaciones fallidas". La opción "Área" solo informa del lanzamiento, en "Provocaciones de área", y omite sus fallos.'

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
	"Un miedo que desperdiga a los enemigos fuera del alcance del tanque. Un miedo de área se notifica en cada lanzamiento, alcance a lo que alcance. Un miedo de un solo objetivo solo se notifica cuando entra, porque una resistencia o una inmunidad no mueven a nadie."
L["FEARS_ALERT_ENABLE"] = "Notificar miedos logrados"
L["FEARS_ALERT_MINE"] = "Mis miedos logrados"
L["FEARS_ALERT_OTHERS"] = "Miedos logrados de los demás"

L["FEARS_ABILITIES_DESC"] = "Desmarca un miedo para dejar de rastrearlo."

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
	"Te sacan de la pelea durante menos tiempo del indicado arriba. De serie solo se muestra en tu propia ventana: un aturdimiento del que te recuperas antes de que nadie haya podido cubrirte explica el tiempo de reutilización global que acabas de perder, y no es problema de nadie más."
L["INCAPACITATED_LONG"] = "Mi incapacitación larga"
L["INCAPACITATED_LONG_DESC"] =
	"Te sacan de la pelea durante al menos el tiempo indicado arriba. De serie se anuncia en un grupo y se muestra en tu ventana en una banda: es la que da tiempo a los demás para actuar, y tú eres la única persona que no puede decirlo. Un efecto sin duración, como un Control mental, cuenta como incapacitación larga."

L["INCAPACITATED_EFFECTS_HEADER"] = "Efectos incluidos"
L["INCAPACITATED_EFFECTS_DESC"] = "Desmarca un efecto para dejar de avisar de él."

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
	"Entérate en el momento en que muere un tanque de tu grupo. Es la única muerte que cambia lo que deben hacer los demás a continuación, y cuarenta retratos de banda son el peor sitio para darse cuenta."
L["TANK_DEATHS_ENABLE"] = "Activar vigilancia de muertes de tanque"

L["TANK_DEATHS_ALERT_HEADER"] = "Muertes de tanque"
L["TANK_DEATHS_ALERT_DESC"] =
	"En una banda solo cuenta a los jugadores asignados como tanque principal, tú incluido, y un rol del buscador de grupos no significa nada allí. En un grupo cuenta a quien tenga seleccionado el rol de tanque en el buscador de grupos. Un tanque sin ninguna de las dos cosas muere sin aviso."
L["TANK_DEATHS_ALERT_ENABLE"] = "Notificar muertes de tanque"
L["TANK_DEATHS_ALERT_MINE"] = "Mi muerte"
L["TANK_DEATHS_ALERT_MINE_DESC"] = "Tu propia muerte mientras tanqueas."
L["TANK_DEATHS_ALERT_OTHERS"] = "Muertes de tanque de los demás"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] = "La muerte de cualquier otro miembro de tu grupo que esté tanqueando."

L["TANK_DEATHS_CLASS_HEADER"] = "Muertes por clase"
L["TANK_DEATHS_CLASS_DESC"] = "Todas las demás muertes, por clase, para las que quieras vigilar."
L["TANK_DEATHS_CLASS_ROW_DESC"] = "Avisa cuando muere un %s de tu grupo."

--------------------------------------------------------------------------------
-- Peer Pressure
--------------------------------------------------------------------------------

--[[
    The alert is the whose shape with no target, like Fears: the line names a
    classmate and a cooldown.

    TRANSLATORS: the two rows' tooltips each say what they count, because
    neither is "everybody's casts": only the player's own class ever reports,
    and the My row has no pet to include.
]]
L["PEER_PRESSURE_SUMMARY"] =
	"Recibe un aviso cuando otros jugadores de tu clase usen sus habilidades con reutilización, para que puedas ceder a la presión de grupo."
L["PEER_PRESSURE_ENABLE"] = "Activar presión de grupo"

L["PEER_PRESSURE_ALERT_HEADER"] = "Tiempos de reutilización"
L["PEER_PRESSURE_ALERT_DESC"] =
	"Una habilidad con reutilización que usa un jugador de tu clase en tu grupo: la señal para usar la tuya. Solo se avisa de tu propia clase, y Habilidades rastreadas elige cuáles cuentan."
L["PEER_PRESSURE_ALERT_ENABLE"] = "Notificar tiempos de reutilización"
L["PEER_PRESSURE_ALERT_MINE"] = "Mis tiempos de reutilización"
L["PEER_PRESSURE_ALERT_MINE_DESC"] = "Tus propias habilidades con reutilización rastreadas."
L["PEER_PRESSURE_ALERT_OTHERS"] = "Tiempos de reutilización de los demás"
L["PEER_PRESSURE_ALERT_OTHERS_DESC"] =
	"Una habilidad con reutilización rastreada que usa cualquier otro jugador de tu clase en tu grupo."

L["PEER_PRESSURE_ABILITIES_DESC"] =
	"Desmarca una habilidad con reutilización para dejar de rastrearla. Solo avisan las de tu propia clase."

--------------------------------------------------------------------------------
-- Bad Mages
--------------------------------------------------------------------------------

L["BAD_MAGES_SUMMARY"] = "Magos que hacen algo que deja a los enemigos fuera del alcance del tanque."
L["BAD_MAGES_ENABLE"] = "Activar vigilancia de magos traviesos"

L["BAD_MAGES_ALERT_HEADER"] = "Novas"
L["BAD_MAGES_ALERT_DESC"] =
	"Avisa de una Nova de Escarcha, que congela a los enemigos donde están, fuera del alcance del tanque."
L["BAD_MAGES_ALERT_ENABLE"] = "Notificar novas"
L["BAD_MAGES_ALERT_MINE"] = "Mis novas"
L["BAD_MAGES_ALERT_OTHERS"] = "Novas de los demás"
L["BAD_MAGES_WHISPER_ENABLE"] = "Susurrar al mago"
L["BAD_MAGES_WHISPER_ENABLE_DESC"] =
	"Envía al mago una nota pidiéndole que guarde Nova de Escarcha para las emergencias. Solo se envía una aunque varias personas de tu grupo usen Control Freak."
L["BAD_MAGES_COOLDOWN_DESC"] =
	"Cuánto tiempo guarda silencio Control Freak sobre un mismo mago después de que haga saltar un aviso de nova. Cubre el aviso en tu ventana, el sonido, el anuncio y el susurro, para que un mago que lanza una nova en cada pull no te llene la ventana."

--------------------------------------------------------------------------------
-- Bad Parry Monkeys
--------------------------------------------------------------------------------

L["BAD_PARRY_MONKEYS_SUMMARY"] =
	"Jugadores que no están tanqueando, que se ponen delante de un jefe y a los que les paran los golpes. Cada parada acelera el siguiente golpe del jefe contra el tanque."
L["BAD_PARRY_MONKEYS_ENABLE"] = "Activar vigilancia de monos de paradas"

L["BAD_PARRY_MONKEYS_ALERT_HEADER"] = "Paradas"
L["BAD_PARRY_MONKEYS_ALERT_DESC"] =
	"Si un enemigo le para un golpe a alguien que no lo está tanqueando, es que ese alguien está delante de él. Cada parada acelera el siguiente golpe del enemigo contra quien lo esté tanqueando."
L["BAD_PARRY_MONKEYS_ALERT_ENABLE"] = "Notificar paradas contra"
L["BAD_PARRY_MONKEYS_ALERT_MINE"] = "Mis paradas"
L["BAD_PARRY_MONKEYS_ALERT_MINE_DESC"] = "Un enemigo que para tus ataques."
L["BAD_PARRY_MONKEYS_ALERT_OTHERS"] = "Paradas de los demás"
L["BAD_PARRY_MONKEYS_ALERT_OTHERS_DESC"] = "Un enemigo que para los ataques de cualquier otro miembro de tu grupo."
L["BAD_PARRY_MONKEYS_IGNORE_TANKS"] = "Ignorar a los tanques"
L["BAD_PARRY_MONKEYS_IGNORE_TANKS_DESC"] =
	"No avisa cuando el jugador al que le han parado el golpe es un tanque: asignado como tanque principal en una banda, o con el rol de tanque seleccionado en el buscador de grupos en un grupo. Un segundo tanque se coloca delante del jefe para un cambio de provocación, y eso no es un error por el que haya que susurrarle. Tus propias paradas se siguen notificando."
L["BAD_PARRY_MONKEYS_IGNORE_PETS"] = "Ignorar a las mascotas"
L["BAD_PARRY_MONKEYS_IGNORE_PETS_DESC"] =
	"No avisa cuando a quien le han parado el golpe es una mascota, la tuya incluida. Una mascota está donde su dueño la mandó, y un mensaje con el nombre de la mascota no le da nada que hacer a nadie del grupo. A las mascotas nunca se les susurra, en ningún caso."
L["BAD_PARRY_MONKEYS_WHISPER"] = "Susurrar al culpable"
L["BAD_PARRY_MONKEYS_WHISPER_DESC"] =
	"Envía al culpable una nota pidiéndole que se ponga detrás del enemigo. Solo se envía una aunque varias personas de tu grupo usen Control Freak."
L["BAD_PARRY_MONKEYS_COOLDOWN_DESC"] =
	"Cuánto tiempo guarda silencio Control Freak sobre un mismo culpable después de que haga saltar un aviso de parada. Cubre el aviso en tu ventana, el sonido, el anuncio y el susurro, porque a quien todavía no se ha movido no hace falta repetírselo en cada golpe."

--[[
    Parry Monkey, the section under Parries: the player owning up to their own
    parries, with a running count, every so often. TRANSLATORS: the message is
    the player's own words, so its default is a line a player would say about
    themselves.
]]
L["BAD_PARRY_MONKEYS_MONKEY_HEADER"] = "Mono de paradas"
L["BAD_PARRY_MONKEYS_MONKEY_DESC"] =
	"Confiésalo cuando un jefe de banda al que no estás tanqueando te para un golpe, con la cuenta de todas las paradas desde que entraste en el grupo de banda. Cuentan todas, y el tiempo de reutilización de abajo decide cada cuánto lo dices."
L["BAD_PARRY_MONKEYS_MONKEY_ENABLE"] = "Notificar mono de paradas"
L["BAD_PARRY_MONKEYS_MONKEY_MINE"] = "Mis confesiones"
L["BAD_PARRY_MONKEYS_MONKEY_MINE_DESC"] = "Tus propias paradas, con tus propias palabras."
L["BAD_PARRY_MONKEYS_MONKEY_MESSAGE"] = "Mensaje"
L["BAD_PARRY_MONKEYS_MONKEY_MESSAGE_DESC"] =
	"Lo que dice tu confesión. La cuenta va detrás y vuelve a empezar desde cero cada vez que entras en un grupo de banda."
L["BAD_PARRY_MONKEYS_MONKEY_MESSAGE_DEFAULT"] = "¡Soy un mono de paradas muy travieso!"
L["BAD_PARRY_MONKEYS_MONKEY_COOLDOWN"] = "Tiempo de reutilización"
L["BAD_PARRY_MONKEYS_MONKEY_COOLDOWN_DESC"] =
	"Cuánto tiempo te quedas callado después de una confesión. Las paradas de en medio siguen contando, así que la siguiente lleva la cuenta entera."

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

L["BAD_PETS_ABILITIES_DESC"] = "Desmarca una habilidad de mascota para dejar de rastrearla."

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] = "Sanadores que hacen algo que perjudica a un tanque más de lo que le ayuda."
-- Shown only on a client whose data has no Power Word: Shield row, which among the shipped ones is Season of Discovery's.
L["BAD_PRIESTS_DISCOVERY_STATUS"] =
	"La Temporada de Descubrimiento nunca avisa de un escudo inoportuno: la runa Fuerza del alma devuelve la ira a los tanques, y ningún add-on puede ver las runas de otro jugador."
L["BAD_PRIESTS_ENABLE"] = "Activar vigilancia de sacerdotes traviesos"

L["BAD_PRIESTS_HEADER"] = "Escudos inoportunos"
L["BAD_PRIESTS_DESC"] =
	"Avisa cuando Palabra de poder: escudo cae sobre un druida o guerrero que está tanqueando. La ira sale del daño recibido, y el daño que absorbe un escudo no genera nada, así que un escudo bienintencionado deja al tanque sin la ira con la que mantiene la amenaza. Un escudo antes del pull, sobre un tanque que aún no está en combate, no se tiene en cuenta."
L["BAD_PRIESTS_ALERT_ENABLE"] = "Notificar escudos inoportunos"
L["BAD_PRIESTS_HEALTH_DESC"] =
	'Cuánto tiene que bajar la salud del tanque para que un escudo deje de ser un error. Un escudo sobre alguien a punto de morir es lo correcto, así que el aviso no salta por debajo del nivel que elijas aquí. Elige "Siempre" para enterarte de todos los escudos.'
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "Siempre"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "Salvo bajo el %d%% de salud"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "Avisos de escudo inoportuno"
L["BAD_PRIESTS_REPORT_DESC"] =
	"Alguien le pone un escudo a un tanque de ira. Aquí no hay una fila para ti y otra para los demás: el lanzamiento es del sanador y el problema, del tanque."
L["BAD_PRIESTS_SELF_ONLY"] = "Cuando juegues de tanque druida o guerrero"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"Solo avisa de los escudos que caen sobre ti, y solo mientras seas un druida o guerrero que está tanqueando. Desactívalo para enterarte de los escudos que caen sobre cualquiera de tu grupo que esté tanqueando con una de esas clases."
L["BAD_PRIESTS_WHISPER"] = "Susurrar al lanzador"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"Envía a quien haya lanzado el escudo una nota explicando por qué perjudica. Solo se envía una aunque varias personas de tu grupo usen Control Freak."
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"Cuánto tiempo guarda silencio Control Freak sobre un mismo lanzador después de que haga saltar un aviso de escudo. Cubre el aviso en tu ventana, el sonido, el anuncio y el susurro, porque un sanador que pone escudos en cuanto se le recargan no debe llenarte la ventana."

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

--[[
    The tab's summary says it ships off and where its two tools live, since
    each tool is a page of its own and the tab page holds only the switch.

    The mini-map tooltip carries its own shorter one, because the button's
    Shift + Left-Click toggles this tab and the tooltip has to say what it is
    turning on. TRANSLATORS: it lists the two section headers below in your
    own words for them; keep it to two lines in the tooltip.
]]
L["TANKING_TOOLS_SUMMARY"] =
	"Esta función aún está en beta, así que viene desactivada. Aperturas fallidas y Perjuicios de armadura tienen cada una su propia página dentro de Utilidades de tanque."
L["TANKING_TOOLS_ENABLE"] = "Activar utilidades de tanque"
L["TANKING_TOOLS_MINIMAP_SUMMARY"] = "Aperturas fallidas y perjuicios de armadura."

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Aperturas fallidas"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Avisa de tus propios ataques de apertura que no han llegado a entrar: un fallo, una esquiva, una parada, un bloqueo, una resistencia o una inmunidad en los primeros segundos de un combate. Amenaza que nunca llegó a generarse, justo cuando más importa."
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Notificar aperturas fallidas contra"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "Mis aperturas fallidas"
L["TANKING_TOOLS_COLD_OPENER_MINE_DESC"] = "Tus propias habilidades de apertura que no han llegado a entrar."
-- The caption before the window dropdown: "Within [10 Seconds of the Pull]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "En los primeros"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d segundos del combate"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Cuánto tiempo después de empezar un combate sigue contando una habilidad evitada. El reloj arranca la primera vez que Control Freak ve a ese enemigo, y solo cuentan las habilidades: un ataque automático falla demasiado a menudo como para ser noticia."

L["TANKING_TOOLS_ARMOR_HEADER"] = "Perjuicios de armadura"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Informa de cuánto ha tardado el grupo en reducir la armadura de un objetivo: cinco acumulaciones de Hender armadura o un Exponer armadura de pícaro. Si marcas una de las filas Incluir de abajo, también espera a ese perjuicio, pero solo cuando alguien del grupo pueda lanzarlo de verdad."
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Notificar perjuicios de armadura contra"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "Informes de perjuicios de armadura"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	"El grupo reduciendo la armadura de un objetivo. Aquí no hay una fila para ti y otra para los demás: es trabajo del grupo, y el informe es para ti."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Incluir Fuego feérico"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Espera a Fuego feérico antes de informar, sea cual sea la versión que lance el druida. Se ignora si no hay ningún druida en el grupo."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Incluir Maldición de temeridad"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Espera a Maldición de temeridad antes de informar. Se ignora si no hay ningún brujo en el grupo."

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
L["TAUNT_FAILED"] = "¡Provocación fallida! %s ha usado %s contra %s y no ha surtido efecto."
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
L["INCAPACITATED"] = "¡%s incapacitado durante %s! %s sufre %s (%s) de %s."
L["INCAPACITATED_PLAIN"] = "¡%s incapacitado durante %s! %s sufre %s de %s."
L["INCAPACITATED_INDEFINITE"] = "¡%s incapacitado! %s sufre %s (%s) de %s."
L["INCAPACITATED_PLAIN_INDEFINITE"] = "¡%s incapacitado! %s sufre %s de %s."

--[[
    The seat the line opens on, as its own phrase rather than a format per role,
    which would be eight copies of the four above.

    TRANSLATORS: this is our own word for the person in that seat, not the
    client's group finder role label, which names a role rather than a person.
    It opens a sentence as its subject. "Afflicted by" in the formats above is
    deliberately the phrasing Blizzard's combat log uses for a debuff landing
    (AURAADDEDOTHERHARMFUL), so a player reads the same words here as in the
    log they already watch -- use your client's wording for both if it has one.
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
	"¡Sacerdote travieso! Por favor, evita lanzar %s sobre %s. Esta habilidad impide que los tanques generen ira."

L["BAD_PET"] = "¡Mascota traviesa! La mascota de %s, %s, ha usado %s contra %s."
L["BAD_PET_AOE"] = "¡Mascota traviesa! La mascota de %s, %s, ha usado %s."
L["BAD_PET_UNKNOWN_OWNER"] = "¡Mascota traviesa! %s ha usado %s contra %s."
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "¡Mascota traviesa! %s ha usado %s."
--[[
    Kept short on purpose. They render with a spell link and up to two names
    inside a 255 byte chat limit, and the widest locale runs close to twice the
    English.
]]
L["BAD_PET_WHISPER"] =
	"¡Mascota traviesa! Tu mascota %s ha usado %s contra %s. Haz clic derecho en la habilidad para desactivar el lanzamiento automático."
L["BAD_PET_WHISPER_AOE"] =
	"¡Mascota traviesa! Tu mascota %s ha usado %s. Haz clic derecho en la habilidad para desactivar el lanzamiento automático."

L["COLD_OPENER_MISS"] = "¡Cuidado! %s ha usado %s y no ha acertado a %s."
L["COLD_OPENER_DODGE"] = "¡Cuidado! %s ha usado %s y %s lo ha esquivado."
L["COLD_OPENER_PARRY"] = "¡Cuidado! %s ha usado %s y %s lo ha parado."
L["COLD_OPENER_BLOCK"] = "¡Cuidado! %s ha usado %s y %s lo ha bloqueado."
L["COLD_OPENER_IMMUNE"] = "¡Cuidado! %s ha usado %s y %s lo ha ignorado."
L["COLD_OPENER_RESIST"] = "¡Cuidado! %s ha usado %s y %s lo ha resistido."

L["ARMOR_REPORT"] = "¡Armadura reducida! %s ha quedado vulnerable tras %s segundos."

L["PARRY_WARNING"] = "¡Aceleración por parada! %s está delante de %s."
L["PARRY_WHISPER"] =
	"¡Mono de paradas travieso! Por favor, ponte detrás de %s; cada parada hace que el jefe ataque más rápido y que el tanque reciba más daño."
-- Parry Monkey's line. TRANSLATORS: %s is the player's own message, %d the count since joining the raid group.
L["PARRY_CONFESSION"] = "%s (x%d)"

L["NOVA"] = "¡Nova! %s ha usado %s contra %s."
L["NOVA_AOE"] = "¡Nova de área! %s ha usado %s."
--[[
    Every whisper opens on "Naughty" and the culprit it is addressed to, the
    Naughty List's own word, where the line the group sees opens on the news.
    TRANSLATORS: %s is the spell.
]]
L["NOVA_WHISPER"] =
	"¡Mago travieso! Tu %s ha congelado a los enemigos fuera del alcance del tanque. Por favor, guárdala para las emergencias."

--[[
    Opens on a bang naming the news, like every other alert line.

    TRANSLATORS: %s in PEER_PRESSURE_TARGET is, in order: caster, spell, and
    the friendly player it was cast on. The target is a player, never a mob.
]]
L["PEER_PRESSURE"] = "¡Presión de grupo! %s ha usado %s."
L["PEER_PRESSURE_TARGET"] = "¡Presión de grupo! %s ha usado %s sobre %s."
