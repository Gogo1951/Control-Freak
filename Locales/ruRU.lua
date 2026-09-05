local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "ruRU")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"Больше информации = лучше танкование. Лучше танкование = лучше рейды."
L["VERSION"] = "Версия"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Версия %s. Настройки (включая возможность отключить это сообщение) находятся в разделе Настройки > AddOns > Control Freak. Нравится аддон? Расскажите о нем другу! (="
L["CHAT_OPTIONS_IN_COMBAT"] =
	"В целях безопасности окно настроек нельзя открыть в бою."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Включить приветствие"
L["ENABLE_WELCOME_MESSAGE_DESC"] =
	"Показывать приветствие Control Freak при входе в игру."
L["ENABLE_MINIMAP_BUTTON"] = "Включить кнопку на миникарте"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Показывать кнопку Control Freak на вашей миникарте."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Открывает окно настроек этого аддона."

-- The master switch. Its description is shared with the mini-map button's own
-- line for the same toggle, so the two cannot describe it differently.
L["KILL_SWITCH"] = "Общий выключатель"
L["KILL_SWITCH_ENABLE"] = "Включить Control Freak"
L["KILL_SWITCH_ENABLE_DESC"] = "Включает или выключает все оповещения Control Freak."

L["FEEDBACK_HEADER"] = "Отзывы и поддержка"
L["FEEDBACK_DISCORD"] = "Discord"
L["FEEDBACK_GITHUB"] = "GitHub"
L["FEEDBACK_CURSEFORGE"] = "CurseForge"
L["FEEDBACK_WAGO"] = "Wago"

--------------------------------------------------------------------------------
-- Mini-map Button
--------------------------------------------------------------------------------

L["STATE_ON"] = "Вкл."
L["STATE_OFF"] = "Выкл."
L["LEFT_CLICK"] = "Левый щелчок"
L["RIGHT_CLICK"] = "Правый щелчок"
L["SHIFT_MIDDLE_CLICK"] = "Shift + средний щелчок"
L["ACTION_TOGGLE"] = "Переключить"
L["MINIMAP_OPTIONS"] = "Настройки Control Freak"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

L["TAB_TAUNTS"] = "Провокации"
L["TAB_INTERRUPTS"] = "Прерывания"
L["TAB_FEARS"] = "Страх"
L["TAB_BAD_PET"] = "Плохой питомец"
L["TAB_TANKING_TOOLS"] = "Инструменты танка"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Включает или выключает эту функцию."
L["SCOPE_TANK_ROLE_ONLY"] = "Только когда вы играете танком"
L["SCOPE_TANK_ROLE_ONLY_DESC"] =
	"Срабатывает, только пока вы танкуете: как основной танк рейда или с выбранной ролью танка в поиске группы. Если не задано ни то, ни другое, функция молчит."
L["SCOPE_GROUP_HAS_TANK"] = "Только когда в группе есть танк"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Срабатывает, только пока кто-то в вашей группе танкует и еще жив. Павший танк считается за отсутствие танка, ведь именно тогда и полезно, что угрозу держит кто-то другой."
L["SCOPE_INSTANCE_ONLY"] = "Только в подземельях"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Срабатывает только внутри подземелий и рейдов."

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
L["ALERT_SECTION_ENABLE_DESC"] = "Включает или выключает это оповещение."
L["ALERT_PRINT"] = "Выводить уведомления"
L["ALERT_PRINT_DESC"] = "Выводит это оповещение в ваше окно чата."
L["ALERT_PRINT_SCOPE_DESC"] =
	"Чьи заклинания попадают в ваше окно. Мои охватывает вас и вашего питомца; Все охватывает всех в вашей группе. Звук тоже следует этой настройке, поэтому вы никогда не услышите оповещение, которого не видите."
L["ALERT_ANNOUNCE"] = "Объявлять группе"
L["ALERT_ANNOUNCE_DESC"] =
	"Отправляет это оповещение в чат группы или рейда. Комментировать чужие действия на весь рейд это самый быстрый способ для аддона всем надоесть, так что тут стоит подумать, прежде чем включать."
L["ALERT_ANNOUNCE_SCOPE_DESC"] =
	"Чьи заклинания уходят в чат группы или рейда. Мои охватывает вас и вашего питомца; Все охватывает всех в вашей группе, включая вас."
L["ALERT_SCOPE_MINE"] = "Мои"
L["ALERT_SCOPE_ALL"] = "Все"
L["ALERT_BOSS_ONLY"] = "Только против боссов и элитных"
L["ALERT_BOSS_ONLY_DESC"] =
	"Срабатывает только против противников, которые того стоят: рейдовые боссы, боссы подземелий и любой элитный противник выше вашего уровня."
L["ALERT_SOUND"] = "Звук"
L["ALERT_SOUND_DESC"] =
	"Проигрывает звук, когда срабатывает это оповещение."
L["ALERT_SOUND_FILE_DESC"] =
	"Выберите звук для этого оповещения. При выборе он сразу проигрывается."
L["ALERT_SOUND_PREVIEW_DESC"] =
	"Проиграть этот звук сейчас, независимо от того, включен звук или нет."
L["SOUND_NONE"] = "Нет"

-- The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
-- list of seconds. Whole minutes read as minutes, and zero reads as "No
-- Cooldown" rather than "0 Second Cooldown".
L["COOLDOWN_NONE"] = "Без задержки"
L["COOLDOWN_SECONDS"] = "Задержка %d сек."
L["COOLDOWN_MINUTES"] = "Задержка %d мин."

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
L["SAMPLE_EXAMPLE"] = "Пример: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "Иван"
L["SAMPLE_PET"] = "Шарик"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "Предметы"
L["ABILITIES_CLASS_PET"] = "Питомец: %s"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] =
	"Провокации это способности, которые забирают угрозу у того, кто держит ее сейчас."
L["TAUNTS_ENABLE"] = "Включить отслеживание провокаций"

L["TAUNTS_SUCCESS_HEADER"] = "Удачные провокации"
L["TAUNTS_SUCCESS_ENABLE"] = "Включить уведомления об удачных провокациях"
L["TAUNTS_SUCCESS_DESC"] =
	"Провокация, которая прошла и забрала противника у кого-то другого. Провокация на противника, который и так бил провоцирующего, это обновление угрозы, а не спасение, поэтому такие остаются без сообщения."
L["TAUNTS_FAILED_HEADER"] = "Неудачные провокации"
L["TAUNTS_FAILED_ENABLE"] = "Включить уведомления о неудачных провокациях"
L["TAUNTS_FAILED_DESC"] =
	"Провокация, которая промахнулась, была отражена сопротивлением или попала по цели с иммунитетом. Противник не сменил хозяина, и на экране об этом ничего не сказано."
L["TAUNTS_AOE_HEADER"] = "Провокации по площади"
L["TAUNTS_AOE_ENABLE"] = "Включить уведомления о провокациях по площади"
L["TAUNTS_AOE_DESC"] =
	"Провокация, которая забирает все вокруг разом, а не одну цель."

L["TAUNTS_ABILITIES_HEADER"] = "Способности провокации"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "Способности провокации по площади"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] =
	"Прерывания останавливают вражеское заклинание посреди сотворения."
L["INTERRUPTS_ENABLE"] = "Включить отслеживание прерываний"

L["INTERRUPTS_ALERT_HEADER"] = "Удачные прерывания"
L["INTERRUPTS_ALERT_ENABLE"] = "Включить уведомления об удачных прерываниях"
L["INTERRUPTS_ALERT_DESC"] =
	"Заклинание, остановленное на середине. Называет, кто остановил и что именно."

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] =
	"Страх заставляет противников разбегаться и разбрасывает набранную пачку по всему залу."
L["FEARS_ENABLE"] = "Включить отслеживание страха"

L["FEARS_ALERT_HEADER"] = "Страх"
L["FEARS_ALERT_ENABLE"] = "Включить уведомления о страхе"
L["FEARS_ALERT_DESC"] =
	"Страх, который прошел и разбросал пачку за пределы досягаемости танка. Считается только попадание: простое сотворение, сопротивление и иммунитет ничего не сдвинули, поэтому ни об одном из них не сообщается."

L["FEARS_ABILITIES_HEADER"] = "Способности страха"

--------------------------------------------------------------------------------
-- Bad Pet
--------------------------------------------------------------------------------

-- The summary doubles as the mini-map button's Bad Pet line, so the tab and the
-- tooltip cannot describe the feature differently.
L["BAD_PET_SUMMARY"] =
	"Питомцы охотников и чернокнижников с оставленным автоприменением способностей на угрозу."
L["BAD_PET_ENABLE"] = "Включить отслеживание плохих питомцев"

L["BAD_PET_ALERT_HEADER"] = "Провокации питомцев"
L["BAD_PET_ALERT_ENABLE"] = "Включить уведомления о провокациях питомцев"
L["BAD_PET_ALERT_DESC"] =
	"Питомец с включенным автоприменением стягивает противника с танка, обычно так, что хозяин этого не замечает."
L["BAD_PET_WHISPER_ENABLE"] = "Шептать хозяину"
L["BAD_PET_WHISPER_ENABLE_DESC"] =
	"Отправляет хозяину питомца записку с объяснением, как отключить автоприменение. Отправляется только одна, даже если Control Freak стоит у нескольких человек в вашей группе."
L["BAD_PET_COOLDOWN_DESC"] =
	"Сколько один питомец молчит после того, как вызвал оповещение. Действует на вывод в чат, звук, объявление и шепот, чтобы питомец с оставленным автоприменением не забивал ваше окно, а его хозяин не получал шепот каждые несколько секунд."

L["BAD_PET_ABILITIES_HEADER"] = "Способности плохих питомцев"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

-- No summary line: the Tanking Tools tab opens on its enable, because the tab is
-- a collection of unrelated warnings rather than one idea a sentence can cover.
-- Each section introduces itself instead.
L["TANKING_TOOLS_ENABLE"] = "Включить инструменты танка"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Холодное начало"
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Включить уведомления о холодном начале"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Сообщает о ваших собственных начальных атаках, которые не прошли: промах, уклонение, парирование, блок, сопротивление или иммунитет в первые секунды боя. Угроза, которой так и не появилось, ровно тогда, когда она важнее всего."
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Насколько далеко от начала боя отраженная способность еще считается. Отсчет начинается с того момента, когда Control Freak впервые увидел этого противника, и считаются только способности: автоатака мажет слишком часто, чтобы это было новостью."
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d сек. боя"

L["TANKING_TOOLS_ARMOR_HEADER"] = "Ослабление брони"
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Включить уведомления об ослаблении брони"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Сообщает, сколько времени группе потребовалось, чтобы снять броню с цели: пять зарядов Раскола брони или одно Ослабить броню от разбойника. Включите дополнение ниже, и отчет будет ждать и его, но только когда кто-то в группе действительно может его применить."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Учитывать Огонь фей"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Ждать Огонь фей перед отчетом, в какой бы форме друид его ни применил. Игнорируется, когда в группе нет друида."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Учитывать Проклятие безрассудства"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Ждать Проклятие безрассудства перед отчетом. Игнорируется, когда в группе нет чернокнижника."

L["TANKING_TOOLS_PARRY_HEADER"] = "Парирования"
L["TANKING_TOOLS_PARRY_ENABLE"] = "Включить уведомления о парированиях"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Тот, кого парирует противник, которого он не танкует, стоит к нему лицом. Каждое парирование ускоряет следующий удар этого противника по тому, кто его держит."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Шептать виновнику"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Отправляет виновнику записку с просьбой встать позади противника. Отправляется только одна, даже если Control Freak стоит у нескольких человек в вашей группе."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Сколько один виновник молчит после того, как вызвал предупреждение о парировании. Действует на вывод в чат, звук, объявление и шепот, ведь тому, кто еще не сдвинулся, незачем напоминать об этом на каждом ударе."

L["TANKING_TOOLS_NOVA_HEADER"] = "Кольца льда"
L["TANKING_TOOLS_NOVA_ENABLE"] = "Включить уведомления о кольцах льда"
L["TANKING_TOOLS_NOVA_DESC"] =
	"Сообщает о Кольце льда, которое разбрасывает пачку за пределы досягаемости танка."

--------------------------------------------------------------------------------
-- Message Formats
--------------------------------------------------------------------------------

L["UNKNOWN_SOURCE"] = "Кто-то"
L["UNKNOWN_TARGET"] = "неизвестная цель"
L["UNKNOWN_SPELL"] = "неизвестное заклинание"

L["TAUNT_SUCCESS"] = "Провокация! %s применил %s на %s!"
L["TAUNT_AOE"] = "Провокация по площади! %s применил %s!"
L["TAUNT_MISSED"] = "Провокация не удалась! %s применил %s на %s, промах!"
L["TAUNT_RESISTED"] =
	"Провокация не удалась! %s применил %s на %s, сопротивление!"
L["TAUNT_IMMUNE"] =
	"Провокация не удалась! %s применил %s на %s, без эффекта! У %s иммунитет."
L["TAUNT_FAILED"] = "Провокация не удалась! %s применил %s на %s, без эффекта!"
L["TAUNT_STOLEN"] = "Эй, он мой! %s применил %s на %s!" -- parked; see Data/Default-Settings.lua

L["FEAR_SUCCESS"] = "Страх! %s применил %s на %s!"
L["FEAR_AOE"] = "Страх по площади! %s применил %s!"

L["INTERRUPT"] = "Прерывание! %s применил %s на %s и остановил %s!"

L["COLD_OPENER_MISS"] = "Осторожно! %s применил %s, промах по %s!"
L["COLD_OPENER_DODGE"] = "Осторожно! %s применил %s, %s уклонился!"
L["COLD_OPENER_PARRY"] = "Осторожно! %s применил %s, %s парировал!"
L["COLD_OPENER_BLOCK"] = "Осторожно! %s применил %s, %s заблокировал!"
L["COLD_OPENER_IMMUNE"] = "Осторожно! %s применил %s, у %s иммунитет!"
L["COLD_OPENER_RESIST"] = "Осторожно! %s применил %s, %s сопротивился!"

L["ARMOR_REPORT"] = "Броня цели %s снята за %s сек.!"

L["PARRY_WARNING"] = "Ускорение от парирования! %s стоит перед %s!"
L["PARRY_WHISPER"] =
	"Привет! Встань, пожалуйста, позади %s. Из-за ускорения от парирования я получаю больше урона."

L["NOVA"] = "Кольцо льда! %s применил %s на %s!"
L["NOVA_AOE"] = "Кольцо льда по площади! %s применил %s!"
-- parked with the bubbles themselves; still reads "Annoyance!" and wants wording
-- of its own when Bubble Warnings lands. See Data/Abilities.lua.
L["ANNOYANCE_BUBBLE"] = "Помеха! %s применил %s на %s при %d%% здоровья!"

L["BAD_PET"] = "Плохой питомец! %s: питомец %s применил %s на %s!"
L["BAD_PET_AOE"] = "Плохой питомец! %s: питомец %s применил %s!"
L["BAD_PET_OWN"] = "Плохой питомец! Ваш питомец %s применил %s на %s!"
L["BAD_PET_OWN_AOE"] = "Плохой питомец! Ваш питомец %s применил %s!"
L["BAD_PET_UNKNOWN_OWNER"] = "Плохой питомец! %s применил %s на %s!"
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Плохой питомец! %s применил %s!"
L["BAD_PET_WHISPER"] =
	"Ваш питомец %s применил %s на %s. Отключите автоприменение: правый щелчок по способности на панели питомца или в книге заклинаний."
