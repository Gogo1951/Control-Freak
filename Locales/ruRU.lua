local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "ruRU")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"Боевой глашатай: сообщает о провокациях, прерываниях, страхе, смертях танка, плохих питомцах, парированиях, снижении брони и других критических событиях боя. Отслеживайте, кто спровоцировал, что не сработало, кто прервал заклинание и что произошло, с помощью настраиваемых оповещений."
L["VERSION"] = "Версия"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Версия %s. Настройки (включая возможность отключить это сообщение) находятся в разделе Настройки > Модификации > Control Freak. Нравится аддон? Расскажите о нём другу! (="
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

--[[
    The add-on's own switch, above every feature's. The title names its REACH
    rather than the act of throwing it, which is what a player cannot read off
    the box beside it -- every other toggle on this panel governs one thing.

    Its ENABLE description is shared with the mini-map button's line for the same
    toggle, so the two cannot describe it differently.
]]
L["KILL_SWITCH"] = "Все оповещения"
L["KILL_SWITCH_SUMMARY"] =
	"Один выключатель для всех оповещений на всех вкладках: если его выключить, аддон умолкает, но ни одна настройка не меняется, а щелчок левой кнопкой по кнопке на миникарте делает то же самое откуда угодно."
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

--[[
    "Enabled" and "Disabled" rather than the shorter pair, matching the other
    add-ons in the family.
]]
L["STATE_ON"] = "Включено"
L["STATE_OFF"] = "Выключено"
L["LEFT_CLICK"] = "Левый щелчок"
L["RIGHT_CLICK"] = "Правый щелчок"
L["SHIFT_MIDDLE_CLICK"] = "Shift + средний щелчок"
L["ACTION_TOGGLE"] = "Переключить"
L["MINIMAP_OPTIONS"] = "Настройки Control Freak"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

-- In tab order.
L["TAB_TAUNTS"] = "Провокации"
L["TAB_INTERRUPTS"] = "Прерывания"
L["TAB_FEARS"] = "Страх"
L["TAB_INCAPACITATED"] = "Потеря контроля"
L["TAB_TANK_DEATHS"] = "Смерти танка"
L["TAB_BAD_PRIESTS"] = "Плохие жрецы"
L["TAB_BAD_PETS"] = "Плохие питомцы"
L["TAB_TANKING_TOOLS"] = "Инструменты танка"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Включает или выключает эту функцию."
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
L["SCOPE_ROLE_TANK"] = "Как танк"
L["SCOPE_ROLE_HEALER"] = "Как лекарь"
L["SCOPE_ROLE_TANK_HEALER"] = "Как танк или лекарь"
L["SCOPE_ROLE_ALWAYS"] = "Всегда"
L["SCOPE_ROLE_DESC"] =
	'Какую роль вы должны занимать, чтобы эта функция вообще что-то говорила. Танком вы считаетесь, если вы главный танк рейда или выбрали роль танка в поиске группы, а лекарем только тогда, когда выбрали роль лекаря, так как рейдового назначения для лечения нет. Вариант "Всегда" снимает этот вопрос: функция срабатывает при любой вашей роли.'
L["SCOPE_GROUP_HAS_TANK"] = "Когда в группе есть танк"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Срабатывает, только пока кто-то в вашей группе танкует и ещё жив. Павший танк приравнивается к отсутствию танка: именно тогда и полезно, что угрозу держит кто-то другой."
L["SCOPE_INSTANCE_ONLY"] = "В подземельях и рейдах"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Срабатывает только в подземельях и рейдах."

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
L["ALERT_SECTION_ENABLE_DESC"] = "Включает или выключает это оповещение."
L["ALERT_SOUND"] = "Воспроизводить звук"
L["ALERT_SOUND_DESC"] =
	"Воспроизводит звук, когда срабатывает это оповещение."
L["ALERT_SOUND_FILE_DESC"] =
	"Выберите звук для этого оповещения. Выбранный звук сразу проигрывается."
L["ALERT_SOUND_PREVIEW_DESC"] =
	"Проиграть этот звук сейчас, независимо от того, включён звук или нет."
L["SOUND_NONE"] = "Нет"

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
	"Сообщает о ваших собственных действиях, включая действия вашего питомца. Список рядом задаёт, куда уходит строка."
L["ALERT_OTHERS_DESC"] =
	"Сообщает о действиях всех остальных в вашей группе. Список рядом задаёт, куда уходит строка."
L["ALERT_OUTPUT_PRINT"] = "Выводить (только себе)"
L["ALERT_OUTPUT_ANNOUNCE"] = "Объявлять"
L["ALERT_OUTPUT_DESC"] =
	'Куда уходит эта строка: в одно место, никогда в оба. "Выводить (только себе)" показывает её в вашем собственном окне и никому ничего не стоит. "Объявлять" вместо этого отправляет её в чат группы или рейда, а аддон, который пересказывает чужие действия всему рейду, быстро всем надоедает, так что здесь стоит подумать. "Объявлять" молчит, когда вы не в группе, а также на полях боя и аренах.'
L["ALERT_AGAINST_DESC"] =
	'Какие противники учитываются; каждый вариант включает и все следующие за ним. Боссами считаются противники с черепом вместо уровня (??). У босса подземелья нет собственного черепа, поэтому он считается элитным: вариант "Элита своего ур+ и боссы" оставляет его, отсекая противников пониже уровнем вокруг. Рейдовая метка перекрывает всё это, пока отмечен пункт ниже.'
L["TARGET_RUNG_ALL"] = "Все"
L["TARGET_RUNG_ELITE"] = "Элита и боссы"
L["TARGET_RUNG_ELITE_0"] = "Элита своего ур+ и боссы"
L["TARGET_RUNG_BOSS"] = "Боссы"
L["ALERT_MARKED_ALWAYS"] = "Всегда учитывать помеченные цели"
L["ALERT_MARKED_ALWAYS_DESC"] =
	"Цель с рейдовой меткой учитывается, что бы ни было выбрано в списке рядом с переключателем: череп, крест, любая из восьми. Метками группа показывает, какой противник важен, поэтому помеченную кем-то цель никогда не отбросят из-за неподходящего ранга или уровня."

--[[
    The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
    list of seconds. Whole minutes read as minutes, and zero reads as "No
    Cooldown" rather than "0 Second Cooldown".

    TRANSLATORS: one format serves every count it is given, one minute and five
    alike, so word each to read for any number. An abbreviated unit does.
]]
L["COOLDOWN_NONE"] = "Без задержки"
L["COOLDOWN_SECONDS"] = "Задержка %d сек."
L["COOLDOWN_MINUTES"] = "Задержка %d мин."

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
L["SAMPLE_EXAMPLE"] = "Пример: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "Иван"
L["SAMPLE_PET"] = "Шарик"

--[[
    The Naxxramas bosses the Example lines name, dealt one per line.

    TRANSLATORS: use each boss's name exactly as your client writes it, title
    included, not a translation of the English.
]]
L["SAMPLE_BOSS_ANUBREKHAN"] = "Ануб'Рекан"
L["SAMPLE_BOSS_FAERLINA"] = "Великая вдова Фарлина"
L["SAMPLE_BOSS_MAEXXNA"] = "Мексна"
L["SAMPLE_BOSS_NOTH"] = "Нот Чумной"
L["SAMPLE_BOSS_HEIGAN"] = "Хейган Нечестивый"
L["SAMPLE_BOSS_LOATHEB"] = "Мерзот"
L["SAMPLE_BOSS_RAZUVIOUS"] = "Инструктор Разувиус"
L["SAMPLE_BOSS_GOTHIK"] = "Готик Жнец"
L["SAMPLE_BOSS_MOGRAINE"] = "Верховный лорд Могрейн"
L["SAMPLE_BOSS_KORTHAZZ"] = "Тан Кортазз"
L["SAMPLE_BOSS_BLAUMEUX"] = "Леди Бломе"
L["SAMPLE_BOSS_ZELIEK"] = "Сэр Зелиек"
L["SAMPLE_BOSS_PATCHWERK"] = "Лоскутик"
L["SAMPLE_BOSS_GROBBULUS"] = "Гроббулус"
L["SAMPLE_BOSS_GLUTH"] = "Глут"
L["SAMPLE_BOSS_THADDIUS"] = "Таддиус"
L["SAMPLE_BOSS_SAPPHIRON"] = "Сапфирон"
L["SAMPLE_BOSS_KELTHUZAD"] = "Кел'Тузад"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "Предметы"
L["ABILITIES_CLASS_PET"] = "%s (питомец)"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] =
	"Провокациями называются способности, которые забирают угрозу у того, кто держит её сейчас."
L["TAUNTS_ENABLE"] = "Включить отслеживание провокаций"

L["TAUNTS_SUCCESS_HEADER"] = "Удачные провокации"
L["TAUNTS_SUCCESS_DESC"] =
	"Провокация, которая прошла и забрала противника у кого-то другого. Провокация на противника, который и так бьёт провоцирующего, лишь обновляет угрозу, а не спасает положение, поэтому о таких не сообщается."
L["TAUNTS_SUCCESS_ENABLE"] = "Сообщать об удачных провокациях, цели:"
L["TAUNTS_SUCCESS_MINE"] = "Мои удачные провокации"
L["TAUNTS_SUCCESS_OTHERS"] = "Чужие удачные провокации"

L["TAUNTS_FAILED_HEADER"] = "Неудачные провокации"
L["TAUNTS_FAILED_DESC"] =
	"Провокация, которая промахнулась, встретила сопротивление или попала по цели с иммунитетом. Противник не сменил хозяина, и на экране об этом ничего не сказано."
L["TAUNTS_FAILED_ENABLE"] = "Сообщать о неудачных провокациях, цели:"
L["TAUNTS_FAILED_MINE"] = "Мои неудачные провокации"
L["TAUNTS_FAILED_OTHERS"] = "Чужие неудачные провокации"

L["TAUNTS_AOE_HEADER"] = "Провокации по площади"
L["TAUNTS_AOE_DESC"] =
	"Провокация, которая разом забирает всех вокруг, а не одну цель."
L["TAUNTS_AOE_ENABLE"] = "Сообщать о провокациях по площади"
L["TAUNTS_AOE_MINE"] = "Мои провокации по площади"
L["TAUNTS_AOE_OTHERS"] = "Чужие провокации по площади"

L["TAUNTS_ABILITIES_HEADER"] = "Способности провокации"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "Способности провокации по площади"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] =
	"Прерывания останавливают вражеское заклинание посреди его произнесения."
L["INTERRUPTS_ENABLE"] = "Включить отслеживание прерываний"

L["INTERRUPTS_ALERT_HEADER"] = "Удачные прерывания"
L["INTERRUPTS_ALERT_DESC"] =
	"Заклинание, остановленное на середине. Называет, кто его остановил и что именно."
L["INTERRUPTS_ALERT_ENABLE"] = "Сообщать об удачных прерываниях, цели:"
L["INTERRUPTS_ALERT_MINE"] = "Мои удачные прерывания"
L["INTERRUPTS_ALERT_OTHERS"] = "Чужие удачные прерывания"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] =
	"Страх заставляет противников разбегаться и разбрасывает пачку по всему залу."
L["FEARS_ENABLE"] = "Включить отслеживание страха"

L["FEARS_ALERT_HEADER"] = "Сработавший страх"
L["FEARS_ALERT_DESC"] =
	"Страх, который прошёл и разбросал пачку за пределы досягаемости танка. Учитывается только попадание: простое применение, сопротивление и иммунитет ничего не сдвинули, поэтому ни о чём из этого не сообщается."
L["FEARS_ALERT_ENABLE"] = "Сообщать о сработавшем страхе"
L["FEARS_ALERT_MINE"] = "Мой сработавший страх"
L["FEARS_ALERT_OTHERS"] = "Чужой сработавший страх"

L["FEARS_ABILITIES_HEADER"] = "Способности страха"

--------------------------------------------------------------------------------
-- Incapacitated
--------------------------------------------------------------------------------

L["INCAPACITATED_SUMMARY"] =
	"Сообщает группе, как только вы теряете контроль над персонажем, чтобы кто-то другой мог вас подстраховать. Танку под страхом и лекарю под немотой нужнее всех сказать об этом, и именно они меньше всех способны сделать это в тот момент."
L["INCAPACITATED_ENABLE"] = "Включить отслеживание потери контроля"

L["INCAPACITATED_HEADER"] = "Выведение из строя"
L["INCAPACITATED_DESC"] =
	"Сообщает группе, когда вас оглушили, напугали, заставили замолчать или иначе вывели из боя: что сработало, кто это применил, сколько это длится и может ли кто-нибудь это снять."
--[[
    No trailing preposition and nothing beside it: this alert has no target
    ladder, and its "Long" threshold is a row of its own, above the two rows it
    names.
]]
L["INCAPACITATED_ALERT_ENABLE"] = "Сообщать о потере контроля"
--[[
    The only pair of rows in the add-on that is not My and Others'. The game
    reports the player's own losses of control and nobody else's, so "whose"
    has one answer; how LONG it lasts is the question with two.

    TRANSLATORS: keep the quotes around Long in the caption. They mark it as the
    word the two rows below are named after rather than as an adjective.
]]
L["INCAPACITATED_LONG_CAPTION"] = '"Долгая" потеря контроля от'
L["INCAPACITATED_LONG_CAPTION_DESC"] =
	"Сколько должна длиться потеря контроля, чтобы считаться долгой. Всё, что короче, считается короткой. Ни та, ни другая не пропадает: два пункта ниже задают, куда уходит каждая, и изначально они направлены в разные места."
-- The caption's dropdown: the first reads for 1 only, the second for 2 to 10.
L["INCAPACITATED_THRESHOLD_ONE"] = "%d сек."
L["INCAPACITATED_THRESHOLD"] = "%d сек."
L["INCAPACITATED_SHORT"] = "Моя короткая потеря контроля"
L["INCAPACITATED_SHORT_DESC"] =
	"Куда уходит строка, когда вас выводят из боя на время меньше указанного выше. Изначально она выводится в ваше собственное окно: оглушение, из которого вы вышли раньше, чем кто-то успел бы вас подстраховать, объясняет только что потерянное общее время восстановления и больше никого не касается."
L["INCAPACITATED_LONG"] = "Моя долгая потеря контроля"
L["INCAPACITATED_LONG_DESC"] =
	"Куда уходит строка, когда вас выводят из боя хотя бы на указанное выше время. Изначально она объявляется: именно на это у кого-то другого есть время отреагировать, а сами вы сказать об этом не можете. Эффект вовсе без длительности, например Контроль над разумом, считается долгим."

L["INCAPACITATED_STUN"] = "Учитывать оглушения"
L["INCAPACITATED_STUN_DESC"] =
	"Полная потеря контроля, персонаж стоит на месте. Сон считается оглушением."
L["INCAPACITATED_FEAR"] = "Учитывать страх"
L["INCAPACITATED_FEAR_DESC"] =
	"Полная потеря контроля, персонаж бегает в случайных направлениях. Противник бежит за вами."
L["INCAPACITATED_CHARM"] = "Учитывать контроль над разумом"
L["INCAPACITATED_CHARM_DESC"] =
	"Персонаж полностью под чужим контролем. Обычно худшее в этом списке и обычно бессрочное."
L["INCAPACITATED_CONFUSE"] = "Учитывать дезориентацию"
L["INCAPACITATED_CONFUSE_DESC"] =
	"Полная потеря контроля, персонаж бродит в случайных направлениях."
L["INCAPACITATED_SILENCE"] = "Учитывать немоту"
L["INCAPACITATED_SILENCE_DESC"] =
	"Нельзя произносить заклинания. Провокация друида или паладина является заклинанием, так что провокации не будет."
L["INCAPACITATED_PACIFY"] = "Учитывать усмирение"
L["INCAPACITATED_PACIFY_DESC"] =
	"Нельзя атаковать, но заклинания по-прежнему работают."
L["INCAPACITATED_SCHOOL_INTERRUPT"] = "Учитывать блокировку школ магии"
L["INCAPACITATED_SCHOOL_INTERRUPT_DESC"] =
	"Нельзя произносить заклинания одной школы. Стоит включить, если вы провоцируете заклинанием: друид или паладин, у которого заблокирована школа природы или света, остаётся без провокации."
L["INCAPACITATED_ROOT"] = "Учитывать обездвиживание"
L["INCAPACITATED_ROOT_DESC"] =
	"Нельзя двигаться. У обездвиженного танка остаётся кнопка провокации, так что противник никуда не денется."
L["INCAPACITATED_DISARM"] = "Учитывать разоружение"
L["INCAPACITATED_DISARM_DESC"] =
	"Нельзя атаковать оружием. Как и при обездвиживании, кнопка провокации по-прежнему работает."

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
	"Танк в вашей группе погиб. Это единственная смерть, которая меняет то, что всем остальным делать дальше, а среди сорока рейдовых портретов её труднее всего заметить."
L["TANK_DEATHS_ENABLE"] = "Включить отслеживание смертей танка"

L["TANK_DEATHS_ALERT_HEADER"] = "Смерти танка"
L["TANK_DEATHS_ALERT_DESC"] =
	"Учитывает главного танка рейда и всех, кто выбрал роль танка в поиске группы, включая вас. Других способов узнать, кто танкует, у игры нет, поэтому о смерти танка без того и другого не сообщается."
L["TANK_DEATHS_ALERT_ENABLE"] = "Сообщать о смерти танка"
L["TANK_DEATHS_ALERT_MINE"] = "Моя смерть"
L["TANK_DEATHS_ALERT_MINE_DESC"] =
	"Сообщает о вашей собственной смерти, пока вы танкуете. Список рядом задаёт, куда уходит строка."
L["TANK_DEATHS_ALERT_OTHERS"] = "Смерти других танков"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] =
	"Сообщает о смерти любого другого участника вашей группы, который танкует. Список рядом задаёт, куда уходит строка."

L["TANK_DEATHS_CLASS_HEADER"] = "Смерти по классам"
L["TANK_DEATHS_CLASS_DESC"] =
	"Все остальные смерти по классам, для тех, за кем вы хотите следить."
L["TANK_DEATHS_CLASS_ROW_DESC"] =
	"Сообщает, когда в вашей группе погибает персонаж класса %s."

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] =
	"Лекари, которые делают то, что вредит танку больше, чем помогает. Только Classic и Burning Crusade: в Сезоне открытий ярость возвращает руна жреца, а в более поздних версиях игры всё это не проблема."
L["BAD_PRIESTS_ENABLE"] = "Включить отслеживание плохих жрецов"

L["BAD_PRIESTS_HEADER"] = "Плохие щиты"
L["BAD_PRIESTS_DESC"] =
	"Сообщает о Слове силы: Щит, наложенном на танкующего друида или воина. Ярость копится от получаемого урона, а поглощённый щитом урон её не даёт, так что щит из лучших побуждений лишает танка ярости, которой он держит угрозу."
L["BAD_PRIESTS_ALERT_ENABLE"] = "Сообщать о плохих щитах"
L["BAD_PRIESTS_HEALTH_DESC"] =
	'Насколько должно упасть здоровье танка, чтобы щит перестал быть ошибкой. Щит на того, кто вот-вот погибнет, вполне оправдан, поэтому ниже выбранного здесь уровня предупреждение молчит. Выберите "Всегда", чтобы слышать о каждом щите.'
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "Всегда"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "Кроме здоровья ниже %d%%"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "Предупреждения о плохих щитах"
L["BAD_PRIESTS_REPORT_DESC"] =
	"Куда уходит предупреждение, когда кто-то накладывает щит на танка, живущего за счёт ярости. Здесь нет отдельных пунктов для своих и чужих: применение за лекарем, а проблема у танка."
L["BAD_PRIESTS_SELF_ONLY"] = "Когда вы танкуете друидом или воином"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"Предупреждать только о щитах на вас и только пока вы танкуете друидом или воином. Снимите отметку, чтобы слышать о щите на любом участнике группы, который танкует одним из этих классов."
L["BAD_PRIESTS_WHISPER"] = "Шептать наложившему щит"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"Отправляет наложившему щит записку с объяснением, почему это вредит. Отправляется только одна, даже если Control Freak стоит у нескольких человек в вашей группе."
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"Сколько один лекарь молчит после того, как вызвал предупреждение о щите. Действует на вывод в чат, звук, объявление и шёпот, ведь лекарь, накладывающий щит всякий раз, как тот восстановится, не должен забивать ваше окно."

--------------------------------------------------------------------------------
-- Bad Pets
--------------------------------------------------------------------------------

-- Doubles as the mini-map button's Bad Pets line, so the two cannot differ.
L["BAD_PETS_SUMMARY"] =
	"Питомцы охотников и чернокнижников с оставленным автоприменением способностей, вызывающих угрозу."
L["BAD_PETS_ENABLE"] = "Включить отслеживание плохих питомцев"

L["BAD_PETS_ALERT_HEADER"] = "Провокации питомцев"
L["BAD_PETS_ALERT_DESC"] =
	"Питомец с оставленным автоприменением стягивает противника с танка, обычно так, что хозяин этого не замечает."
L["BAD_PETS_ALERT_ENABLE"] = "Сообщать о провокациях питомцев, цели:"
L["BAD_PETS_ALERT_MINE"] = "Провокации моего питомца"
L["BAD_PETS_ALERT_OTHERS"] = "Провокации чужих питомцев"
L["BAD_PETS_WHISPER_ENABLE"] = "Шептать хозяину питомца"
L["BAD_PETS_WHISPER_ENABLE_DESC"] =
	"Отправляет хозяину питомца записку с объяснением, как отключить автоприменение. Отправляется только одна, даже если Control Freak стоит у нескольких человек в вашей группе."
L["BAD_PETS_COOLDOWN_DESC"] =
	"Сколько один питомец молчит после того, как вызвал оповещение. Действует на вывод в чат, звук, объявление и шёпот, чтобы питомец с оставленным автоприменением не забивал ваше окно, а его хозяин не получал шёпот каждые несколько секунд."

L["BAD_PETS_ABILITIES_HEADER"] = "Способности плохих питомцев"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

--[[
    No summary line: the Tanking Tools tab opens on its enable, because the tab is
    a collection of unrelated warnings rather than one idea a sentence can cover.
    Each section introduces itself instead.
]]
L["TANKING_TOOLS_ENABLE"] = "Включить инструменты танка"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Холодное начало"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Сообщает о ваших собственных начальных атаках, которые не прошли: промах, уклонение, парирование, блок, сопротивление или иммунитет в первые секунды боя. Угроза, которой так и не появилось, ровно тогда, когда она важнее всего."
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Сообщать о холодном начале, цели:"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "Моё холодное начало"
-- The caption before the window dropdown: "Within [10 Seconds of Fight]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "В первые"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d сек. боя"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Как долго с начала боя не прошедшая способность ещё учитывается. Отсчёт начинается, когда Control Freak впервые видит этого противника, и учитываются только способности: автоатака промахивается слишком часто, чтобы это было новостью."

L["TANKING_TOOLS_ARMOR_HEADER"] = "Снижение брони"
L["TANKING_TOOLS_ARMOR_DESC"] =
	'Сообщает, сколько времени группе понадобилось, чтобы снять броню с цели: пять Расколов брони или Ослабление доспеха от разбойника. Отметьте один из пунктов "Учитывать" ниже, и отчёт будет ждать и этот эффект, но только если кто-то в группе действительно может его применить.'
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Сообщать о снижении брони, цели:"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "Отчёты о снижении брони"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	"Куда уходит отчёт, когда группа сняла броню с цели. Здесь нет отдельных пунктов для своих и чужих: это работа группы, о которой сообщают вам."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Учитывать Волшебный огонь"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Ждать Волшебного огня перед отчётом, в каком бы облике друид его ни применил. Не учитывается, если в группе нет друида."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Учитывать Проклятие безрассудства"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Ждать Проклятия безрассудства перед отчётом. Не учитывается, если в группе нет чернокнижника."

L["TANKING_TOOLS_PARRY_HEADER"] = "Парирования"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Если противник парирует удары того, кто его не танкует, значит этот игрок стоит перед ним. Каждое парирование ускоряет следующий удар противника по тому, кто его держит."
L["TANKING_TOOLS_PARRY_ENABLE"] = "Сообщать о парированиях, цели:"
L["TANKING_TOOLS_PARRY_MINE"] = "Мои парирования"
L["TANKING_TOOLS_PARRY_OTHERS"] = "Чужие парирования"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS"] = "Не учитывать других танков"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS_DESC"] =
	"Молчать, если парировали танка: главного танка рейда или игрока с ролью танка. Второй танк стоит перед боссом ради смены танков, и это не та ошибка, о которой стоит шептать. О ваших собственных парированиях сообщается по-прежнему."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Шептать виновнику"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Отправляет виновнику записку с просьбой встать позади противника. Отправляется только одна, даже если Control Freak стоит у нескольких человек в вашей группе."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Сколько один виновник молчит после того, как вызвал предупреждение о парировании. Действует на вывод в чат, звук, объявление и шёпот, ведь тому, кто ещё не сдвинулся, незачем напоминать на каждом ударе."

L["TANKING_TOOLS_NOVA_HEADER"] = "Кольца льда"
L["TANKING_TOOLS_NOVA_DESC"] =
	"Сообщает о Кольце льда, которое разбрасывает пачку за пределы досягаемости танка."
L["TANKING_TOOLS_NOVA_ENABLE"] = "Сообщать о кольцах льда"
L["TANKING_TOOLS_NOVA_MINE"] = "Мои кольца льда"
L["TANKING_TOOLS_NOVA_OTHERS"] = "Чужие кольца льда"

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
L["UNKNOWN_SOURCE"] = "Кто-то"
L["UNKNOWN_CASTER"] = "неизвестного заклинателя"
L["UNKNOWN_TARGET"] = "неизвестная цель"
L["UNKNOWN_SPELL"] = "неизвестное заклинание"

L["TAUNT_SUCCESS"] = "Провокация! %s: %s на %s."
L["TAUNT_AOE"] = "Провокация по площади! %s: %s."
L["TAUNT_MISSED"] = "Провал провокации! %s: %s на %s, промах."
L["TAUNT_RESISTED"] = "Провал провокации! %s: %s на %s, сопротивление."
--[[
    The one failure format that leads with the MOB rather than the taunter,
    because the immunity is the news and the other three formats have no news
    beyond "it did not land".

    TRANSLATORS: %s is, in order: mob, taunter, taunt. This is the ONLY taunt
    format whose first %s is not the player who cast it.
]]
L["TAUNT_IMMUNE"] = "Провал провокации! Иммунитет у цели %s: %s применяет %s."
L["TAUNT_FAILED"] = "Провал провокации! %s: %s на %s, без эффекта."
L["INTERRUPT"] = "Прервано! %s: %s на %s сбивает %s."

L["FEAR_SUCCESS"] = "Страх! %s: %s на %s."
L["FEAR_AOE"] = "Страх по площади! %s: %s."

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
L["INCAPACITATED"] = "%s выведен из строя на %s; %s: %s (%s) от %s."
L["INCAPACITATED_PLAIN"] = "%s выведен из строя на %s; %s: %s от %s."
L["INCAPACITATED_INDEFINITE"] = "%s выведен из строя; %s: %s (%s) от %s."
L["INCAPACITATED_PLAIN_INDEFINITE"] = "%s выведен из строя; %s: %s от %s."

--[[
    The seat the line opens on, as its own phrase rather than a format per role,
    which would be eight copies of the four above.

    TRANSLATORS: this is the client's own word for the group finder role, and it
    opens a sentence. "Afflicted by" in the formats above is deliberately the
    phrasing Blizzard's combat log uses for a debuff landing
    (AURAADDEDOTHERHARMFUL), so a player reads the same words here as in the log
    they already watch -- use your client's wording for both if it has one.
]]
L["INCAPACITATED_ROLE_TANK"] = "Танк"
L["INCAPACITATED_ROLE_HEALER"] = "Лекарь"

--[[
    The length, as its own phrase rather than a bare number with "seconds" in the
    format, so the singular does not need two more formats beside the four
    above. Always a whole number: the handler rounds UP, because a fear reported
    as 5.9 promises a taunt back sooner than it is coming.

    TRANSLATORS: the handler reads exactly these two, the first for 1 and the
    second for every other count, so a language with more number forms words
    the second to read for any count. An abbreviated unit does.
]]
L["INCAPACITATED_SECOND"] = "%d секунду"
L["INCAPACITATED_SECONDS"] = "%d сек."

--[[
    The four debuff types a player can take off. They name the class that can
    help -- Magic is a priest or paladin, Curse a mage or druid -- so they are
    the half of the line a tank cannot act on alone.

    TRANSLATORS: use the client's own words for these, the ones on the debuff
    tooltips, not a literal translation of the English.
]]
L["DISPEL_MAGIC"] = "Магия"
L["DISPEL_CURSE"] = "Проклятие"
L["DISPEL_DISEASE"] = "Болезнь"
L["DISPEL_POISON"] = "Яд"

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
L["TANK_DEATHS_TANK_LINE"] = "Танк погиб! %s мёртв."
L["TANK_DEATHS_CLASS_LINE"] = "%s погиб! %s мёртв."

--[[
    Kept short on purpose: they render with a real spell link and two real names
    inside the 255 byte chat limit, and the widest locale runs close to twice the
    English.

    The WARNING carries no explanation and the WHISPER carries all of it. The
    warning fires mid-pull in front of a tank who already knows what a shield
    does; the whisper goes to the healer who does not, and is read after the
    fact. The tab description explains it at length for whoever wants it.
]]
L["SHIELD_WARNING"] = "Плохой щит! %s: %s на %s."
L["SHIELD_WHISPER"] =
	"Плохой щит! Прошу не накладывать %s на %s: щит мешает танку копить ярость."

L["BAD_PET"] = "Плохой питомец! %s: питомец %s применяет %s на %s."
L["BAD_PET_AOE"] = "Плохой питомец! %s: питомец %s применяет %s."
L["BAD_PET_OWN"] = "Плохой питомец! Ваш питомец %s применяет %s на %s."
L["BAD_PET_OWN_AOE"] = "Плохой питомец! Ваш питомец %s применяет %s."
L["BAD_PET_UNKNOWN_OWNER"] = "Плохой питомец! %s применяет %s на %s."
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Плохой питомец! %s применяет %s."
--[[
    Kept short on purpose. It renders with a spell link and two names inside a 255
    byte chat limit, and the widest locale runs close to twice the English.
]]
L["BAD_PET_WHISPER"] =
	"Ваш питомец %s: %s на %s. Отключите автоприменение: ПКМ по кнопке."

L["COLD_OPENER_MISS"] = "Осторожно! %s: %s, промах по %s."
L["COLD_OPENER_DODGE"] = "Осторожно! %s: %s, %s уклоняется."
L["COLD_OPENER_PARRY"] = "Осторожно! %s: %s, %s парирует."
L["COLD_OPENER_BLOCK"] = "Осторожно! %s: %s, %s блокирует."
L["COLD_OPENER_IMMUNE"] = "Осторожно! %s: %s, у %s иммунитет."
L["COLD_OPENER_RESIST"] = "Осторожно! %s: %s, %s сопротивляется."

L["ARMOR_REPORT"] = "Броня снята! Цель %s уязвима через %s сек."

L["PARRY_WARNING"] = "Ускорение от парирования! %s стоит перед %s."
L["PARRY_WHISPER"] =
	"Ускорение от парирования! Прошу встать позади %s: каждое парирование ускоряет его следующий удар."

L["NOVA"] = "Кольцо льда! %s: %s на %s."
L["NOVA_AOE"] = "Кольцо льда по площади! %s: %s."
