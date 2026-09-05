local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "esMX")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] = "Mejor información = mejor tanqueo. Mejor tanqueo = mejores bandas."
L["VERSION"] = "Versión"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Versión %s. Los ajustes (incluida la opción de desactivar este mensaje) están en Opciones > AddOns > Control Freak. ¿Te gusta el addon? ¡Cuéntaselo a un amigo! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Por precaución, la Interfaz de Opciones no se puede abrir durante el combate."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Activar mensaje de bienvenida"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Muestra el saludo de Control Freak al iniciar sesión."
L["ENABLE_MINIMAP_BUTTON"] = "Activar botón del minimapa"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Muestra el botón de Control Freak en tu minimapa."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre la Interfaz de Opciones de este addon."

-- The master switch. Its description is shared with the mini-map button's own
-- line for the same toggle, so the two cannot describe it differently.
L["KILL_SWITCH"] = "Interruptor general"
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

L["TAB_TAUNTS"] = "Provocaciones"
L["TAB_INTERRUPTS"] = "Interrupciones"
L["TAB_FEARS"] = "Miedos"
L["TAB_BAD_PET"] = "Mascota traviesa"
L["TAB_TANKING_TOOLS"] = "Herramientas de tanque"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Activa o desactiva esta función."
L["SCOPE_TANK_ROLE_ONLY"] = "Solo cuando juegues de tanque"
L["SCOPE_TANK_ROLE_ONLY_DESC"] =
	"Salta solo mientras estés tanqueando, ya sea como Tanque principal de la banda o con el rol de Tanque seleccionado en el buscador de grupo. Sin ninguno de los dos, esta función se queda callada."
L["SCOPE_GROUP_HAS_TANK"] = "Solo cuando el grupo tenga tanque"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Salta solo mientras alguien de tu grupo esté tanqueando y siga vivo. Un tanque caído cuenta como ningún tanque, porque es justo entonces cuando ayuda que otro sostenga la amenaza."
L["SCOPE_INSTANCE_ONLY"] = "Solo en instancias"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Salta solo dentro de mazmorras y bandas."

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
L["ALERT_SECTION_ENABLE_DESC"] = "Activa o desactiva esta alerta."
L["ALERT_PRINT"] = "Mostrar notificaciones"
L["ALERT_PRINT_DESC"] = "Muestra esta alerta en tu propia ventana de chat."
L["ALERT_PRINT_SCOPE_DESC"] =
	"De quién son los lanzamientos que llegan a tu ventana. Mías te cubre a ti y a tu propia mascota; Todas cubre a todos los de tu grupo. El sonido también sigue este ajuste, así que nunca vas a oír una alerta que no puedas ver."
L["ALERT_ANNOUNCE"] = "Anunciar al grupo"
L["ALERT_ANNOUNCE_DESC"] =
	"Envía esta alerta al chat de tu grupo o banda. Andar narrando lo que hacen los demás ante toda la banda es la forma más rápida de que un addon termine cansando, así que este merece pensarlo antes de activarlo."
L["ALERT_ANNOUNCE_SCOPE_DESC"] =
	"De quién son los lanzamientos que van al chat de grupo o banda. Mías te cubre a ti y a tu propia mascota; Todas cubre a todos los de tu grupo, tú incluido."
L["ALERT_SCOPE_MINE"] = "Mías"
L["ALERT_SCOPE_ALL"] = "Todas"
L["ALERT_BOSS_ONLY"] = "Solo contra jefes y élites"
L["ALERT_BOSS_ONLY_DESC"] =
	"Salta solo contra enemigos que merecen la atención: jefes de banda, jefes de mazmorra y cualquier élite por encima de tu propio nivel."
L["ALERT_SOUND"] = "Sonido"
L["ALERT_SOUND_DESC"] = "Reproduce un sonido cuando salta esta alerta."
L["ALERT_SOUND_FILE_DESC"] = "Elige el sonido que reproduce esta alerta. Al elegir uno, suena."
L["ALERT_SOUND_PREVIEW_DESC"] = "Reproduce este sonido ahora, esté o no activado el sonido."
L["SOUND_NONE"] = "Ninguno"

-- The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
-- list of seconds. Whole minutes read as minutes, and zero reads as "No
-- Cooldown" rather than "0 Second Cooldown".
L["COOLDOWN_NONE"] = "Sin reutilización"
L["COOLDOWN_SECONDS"] = "Reutilización de %d segundos"
L["COOLDOWN_MINUTES"] = "Reutilización de %d minutos"

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
L["SAMPLE_EXAMPLE"] = "Ejemplo: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "Juan"
L["SAMPLE_PET"] = "Firulais"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "Objetos"
L["ABILITIES_CLASS_PET"] = "Mascota de %s"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] = "Las provocaciones son habilidades que quitan la amenaza a quien la tenga en ese momento."
L["TAUNTS_ENABLE"] = "Activar vigilancia de provocaciones"

L["TAUNTS_SUCCESS_HEADER"] = "Provocaciones logradas"
L["TAUNTS_SUCCESS_ENABLE"] = "Activar notificaciones de provocaciones logradas"
L["TAUNTS_SUCCESS_DESC"] =
	"Una provocación que entró y le quitó el enemigo a otra persona. Una provocación sobre un enemigo que ya estaba pegándole a quien provoca es un refresco de amenaza y no un rescate, así que esas se quedan calladas."
L["TAUNTS_FAILED_HEADER"] = "Provocaciones fallidas"
L["TAUNTS_FAILED_ENABLE"] = "Activar notificaciones de provocaciones fallidas"
L["TAUNTS_FAILED_DESC"] =
	"Una provocación que falló, fue resistida o tocó algo inmune. El enemigo no cambió de manos, y nada en pantalla te lo dice."
L["TAUNTS_AOE_HEADER"] = "Provocaciones de área"
L["TAUNTS_AOE_ENABLE"] = "Activar notificaciones de provocaciones de área"
L["TAUNTS_AOE_DESC"] = "Una provocación que agarra de golpe todo lo que tiene alrededor, en vez de un solo objetivo."

L["TAUNTS_ABILITIES_HEADER"] = "Habilidades de provocación"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "Habilidades de provocación de área"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "Las interrupciones cortan un hechizo enemigo a mitad de su lanzamiento."
L["INTERRUPTS_ENABLE"] = "Activar vigilancia de interrupciones"

L["INTERRUPTS_ALERT_HEADER"] = "Interrupciones logradas"
L["INTERRUPTS_ALERT_ENABLE"] = "Activar notificaciones de interrupciones logradas"
L["INTERRUPTS_ALERT_DESC"] = "Un lanzamiento cortado a medias. Dice quién lo cortó y qué cortó."

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Los miedos hacen huir a los enemigos y desperdigan un pull por toda la sala."
L["FEARS_ENABLE"] = "Activar vigilancia de miedos"

L["FEARS_ALERT_HEADER"] = "Miedos"
L["FEARS_ALERT_ENABLE"] = "Activar notificaciones de miedos"
L["FEARS_ALERT_DESC"] =
	"Un miedo que entró y desperdigó el pull fuera del alcance del tanque. Solo cuenta que entre: un lanzamiento a secas, una resistencia y una inmunidad no movieron nada, así que ninguno de ellos se informa."

L["FEARS_ABILITIES_HEADER"] = "Habilidades de miedo"

--------------------------------------------------------------------------------
-- Bad Pet
--------------------------------------------------------------------------------

-- The summary doubles as the mini-map button's Bad Pet line, so the tab and the
-- tooltip cannot describe the feature differently.
L["BAD_PET_SUMMARY"] = "Mascotas de cazador y de brujo con habilidades de amenaza dejadas en lanzamiento automático."
L["BAD_PET_ENABLE"] = "Activar vigilancia de mascotas traviesas"

L["BAD_PET_ALERT_HEADER"] = "Provocaciones de mascota"
L["BAD_PET_ALERT_ENABLE"] = "Activar notificaciones de provocaciones de mascota"
L["BAD_PET_ALERT_DESC"] =
	"Una mascota que le quita el enemigo al tanque con el lanzamiento automático activado, normalmente sin que su dueño se dé cuenta."
L["BAD_PET_WHISPER_ENABLE"] = "Susurrar al dueño"
L["BAD_PET_WHISPER_ENABLE_DESC"] =
	"Envía al dueño de la mascota una nota explicando cómo desactivar el lanzamiento automático. Solo se envía una aunque varias personas de tu grupo usen Control Freak."
L["BAD_PET_COOLDOWN_DESC"] =
	"Cuánto tiempo se queda callada una mascota tras hacer saltar una alerta. Cubre el mensaje, el sonido, el anuncio y el susurro, para que una mascota con el lanzamiento automático activado no llene tu ventana y su dueño no reciba un susurro cada pocos segundos."

L["BAD_PET_ABILITIES_HEADER"] = "Habilidades de mascota traviesa"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

-- No summary line: the Tanking Tools tab opens on its enable, because the tab is
-- a collection of unrelated warnings rather than one idea a sentence can cover.
-- Each section introduces itself instead.
L["TANKING_TOOLS_ENABLE"] = "Activar herramientas de tanque"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Aperturas en frío"
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Activar notificaciones de aperturas en frío"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Avisa de tus propios ataques de apertura que no llegaron a entrar: un fallo, una esquiva, una parada, un bloqueo, una resistencia o una inmunidad en los primeros segundos de un pull. Amenaza que nunca ocurrió, justo en el momento en que más importa."
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Hasta qué punto de un pull sigue contando una habilidad evitada. El reloj arranca la primera vez que Control Freak ve a ese enemigo, y solo cuentan las habilidades: un ataque automático falla demasiado seguido como para ser noticia."
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d segundos de combate"

L["TANKING_TOOLS_ARMOR_HEADER"] = "Debilitamientos de armadura"
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Activar notificaciones de debilitamientos de armadura"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Informa de cuánto tardó el grupo en pelar la armadura de un objetivo: cinco Desgarrar armadura o un Exponer armadura de pícaro. Activa un extra abajo y también va a esperar a ese, pero solo cuando alguien del grupo pueda lanzarlo de verdad."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Incluir Fuego feérico"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Espera a Fuego feérico antes de informar, sea cual sea la forma en que lo lance el druida. Se ignora cuando no hay ningún druida en el grupo."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Incluir Maldición de imprudencia"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Espera a Maldición de imprudencia antes de informar. Se ignora cuando no hay ningún brujo en el grupo."

L["TANKING_TOOLS_PARRY_HEADER"] = "Paradas"
L["TANKING_TOOLS_PARRY_ENABLE"] = "Activar notificaciones de paradas"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Quien recibe una parada de un enemigo al que no está tanqueando está parado delante de él. Cada parada acelera el siguiente golpe de ese enemigo contra quien lo sostiene."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Susurrar al culpable"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Envía al culpable una nota pidiéndole que se ponga detrás del enemigo. Solo se envía una aunque varias personas de tu grupo usen Control Freak."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Cuánto tiempo se queda callado un culpable tras hacer saltar un aviso de parada. Cubre el mensaje, el sonido, el anuncio y el susurro, porque a quien todavía no se movió no hace falta decírselo en cada golpe."

L["TANKING_TOOLS_NOVA_HEADER"] = "Novas de escarcha"
L["TANKING_TOOLS_NOVA_ENABLE"] = "Activar notificaciones de novas de escarcha"
L["TANKING_TOOLS_NOVA_DESC"] = "Avisa de una Nova de escarcha, que desperdiga un pull fuera del alcance del tanque."

--------------------------------------------------------------------------------
-- Message Formats
--------------------------------------------------------------------------------

L["UNKNOWN_SOURCE"] = "Alguien"
L["UNKNOWN_TARGET"] = "un objetivo desconocido"
L["UNKNOWN_SPELL"] = "un hechizo desconocido"

L["TAUNT_SUCCESS"] = "¡Provocación! ¡%s usó %s contra %s!"
L["TAUNT_AOE"] = "¡Provocación de área! ¡%s usó %s!"
L["TAUNT_MISSED"] = "¡Provocación fallida! ¡%s usó %s contra %s y no acertó!"
L["TAUNT_RESISTED"] = "¡Provocación fallida! ¡%s usó %s contra %s y fue resistida!"
L["TAUNT_IMMUNE"] = "¡Provocación fallida! ¡%s usó %s contra %s sin efecto! %s es inmune."
L["TAUNT_FAILED"] = "¡Provocación fallida! ¡%s usó %s contra %s sin efecto!"
L["TAUNT_STOLEN"] = "¡Oye, ese es mío! ¡%s usó %s contra %s!" -- parked; see Data/Default-Settings.lua

L["FEAR_SUCCESS"] = "¡Miedo! ¡%s usó %s contra %s!"
L["FEAR_AOE"] = "¡Miedo de área! ¡%s usó %s!"

L["INTERRUPT"] = "¡Interrupción! ¡%s usó %s contra %s para cortar %s!"

L["COLD_OPENER_MISS"] = "¡Cuidado! ¡%s usó %s y falló contra %s!"
L["COLD_OPENER_DODGE"] = "¡Cuidado! ¡%s usó %s y %s lo esquivó!"
L["COLD_OPENER_PARRY"] = "¡Cuidado! ¡%s usó %s y %s lo paró!"
L["COLD_OPENER_BLOCK"] = "¡Cuidado! ¡%s usó %s y %s lo bloqueó!"
L["COLD_OPENER_IMMUNE"] = "¡Cuidado! ¡%s usó %s y %s fue inmune!"
L["COLD_OPENER_RESIST"] = "¡Cuidado! ¡%s usó %s y %s lo resistió!"

L["ARMOR_REPORT"] = "¡Armadura de %s pelada tras %s segundos!"

L["PARRY_WARNING"] = "¡Prisa por parada! ¡%s está parado delante de %s!"
L["PARRY_WHISPER"] =
	"Oye, ponte detrás de %s, por favor. Por la prisa por parada estás haciendo que reciba más daño."

L["NOVA"] = "¡Nova! ¡%s usó %s contra %s!"
L["NOVA_AOE"] = "¡Nova de área! ¡%s usó %s!"
-- parked with the bubbles themselves; still reads "Annoyance!" and wants wording
-- of its own when Bubble Warnings lands. See Data/Abilities.lua.
L["ANNOYANCE_BUBBLE"] = "¡Qué molestia! ¡%s usó %s en %s con %d%% de vida!"

L["BAD_PET"] = "¡Mascota traviesa! ¡La mascota de %s, %s, usó %s contra %s!"
L["BAD_PET_AOE"] = "¡Mascota traviesa! ¡La mascota de %s, %s, usó %s!"
L["BAD_PET_OWN"] = "¡Mascota traviesa! ¡Tu mascota %s usó %s contra %s!"
L["BAD_PET_OWN_AOE"] = "¡Mascota traviesa! ¡Tu mascota %s usó %s!"
L["BAD_PET_UNKNOWN_OWNER"] = "¡Mascota traviesa! ¡%s usó %s contra %s!"
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "¡Mascota traviesa! ¡%s usó %s!"
L["BAD_PET_WHISPER"] =
	"Tu mascota %s usó %s contra %s. Haz clic derecho en la habilidad en la barra de acción de tu mascota o en tu libro de hechizos para desactivar el lanzamiento automático."
