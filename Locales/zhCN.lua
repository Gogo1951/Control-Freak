local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "zhCN")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"战斗播报插件，覆盖嘲讽、打断、恐惧、坦克死亡、捣蛋宠物、招架、护甲削弱以及其他关键战斗事件。通过可自定义的提示，掌握谁嘲讽了、什么失败了、谁打断了施法，以及发生了什么。"
L["VERSION"] = "版本"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"版本 %s。设置（包括关闭这条消息的选项）可以在 选项 > 插件 > Control Freak 中找到。喜欢这个插件吗？告诉朋友吧！(="
L["CHAT_OPTIONS_IN_COMBAT"] = "出于安全考虑，战斗中无法打开选项界面。"

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "启用欢迎消息"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "登录时显示 Control Freak 的问候语。"
L["ENABLE_MINIMAP_BUTTON"] = "启用小地图按钮"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "在你的小地图上显示 Control Freak 按钮。"

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "打开本插件的选项界面。"

--[[
    The add-on's own switch, above every feature's. The title names its REACH
    rather than the act of throwing it, which is what a player cannot read off
    the box beside it -- every other toggle on this panel governs one thing.

    Its ENABLE description is shared with the mini-map button's line for the same
    toggle, so the two cannot describe it differently.
]]
L["KILL_SWITCH"] = "所有提示"
L["KILL_SWITCH_SUMMARY"] =
	"一个开关管住所有标签页里的全部提示：关掉它，插件就安静下来，而所有设置都原样保留；左键点击小地图按钮也能随时做同样的事。"
L["KILL_SWITCH_ENABLE"] = "启用 Control Freak"
L["KILL_SWITCH_ENABLE_DESC"] = "打开或关闭 Control Freak 的全部提示。"

L["FEEDBACK_HEADER"] = "反馈与支持"
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
L["STATE_ON"] = "已启用"
L["STATE_OFF"] = "已禁用"
L["LEFT_CLICK"] = "左键点击"
L["RIGHT_CLICK"] = "右键点击"
L["SHIFT_MIDDLE_CLICK"] = "Shift + 中键点击"
L["ACTION_TOGGLE"] = "切换"
L["MINIMAP_OPTIONS"] = "Control Freak 选项"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

-- In tab order.
L["TAB_TAUNTS"] = "嘲讽"
L["TAB_INTERRUPTS"] = "打断"
L["TAB_FEARS"] = "恐惧"
L["TAB_INCAPACITATED"] = "失控"
L["TAB_TANK_DEATHS"] = "坦克死亡"
L["TAB_BAD_PRIESTS"] = "捣蛋牧师"
L["TAB_BAD_PETS"] = "捣蛋宠物"
L["TAB_TANKING_TOOLS"] = "坦克工具"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "打开或关闭此功能。"
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
L["SCOPE_ROLE_TANK"] = "担任坦克时"
L["SCOPE_ROLE_HEALER"] = "担任治疗时"
L["SCOPE_ROLE_TANK_HEALER"] = "担任坦克或治疗时"
L["SCOPE_ROLE_ALWAYS"] = "始终"
L["SCOPE_ROLE_DESC"] =
	'你必须担任哪种职责，这项功能才会开口。在团队中，只有被指派为主坦克时才算作坦克；在小队中，在队伍查找器中选择了坦克职责时算作坦克。在团队中，坦克职责不起任何作用。只有在队伍查找器中选择了治疗职责时才算作治疗，因为治疗没有团队指派。选择"始终"就不问职责，无论你玩什么都会提示。'
L["SCOPE_GROUP_HAS_TANK"] = "队伍中有坦克时"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"只在队伍中有人正在当坦克并且还活着时触发。在团队中，这指的是被指派的主坦克，所以在 Control Freak 看来，没有指派主坦克的团队就没有坦克。倒下的坦克算作没有坦克，因为这时有别人接住仇恨是在帮忙。"
L["SCOPE_INSTANCE_ONLY"] = "身处副本时"
L["SCOPE_INSTANCE_ONLY_DESC"] = "只在地下城和团队副本中触发。"

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
L["ALERT_SECTION_ENABLE_DESC"] = "打开或关闭这条提示。"
L["ALERT_SOUND"] = "播放声音"
L["ALERT_SOUND_DESC"] = "这条提示触发时播放一个声音。"
L["ALERT_SOUND_FILE_DESC"] = "选择这条提示播放的声音。选中时会立即播放。"
L["ALERT_SOUND_PREVIEW_DESC"] = "立即播放这个声音，无论声音是否已打开。"
L["SOUND_NONE"] = "无"

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
	"报告你自己的施法，包括你宠物的。旁边的下拉框决定这条消息发往哪里。"
L["ALERT_OTHERS_DESC"] =
	"报告你队伍里其他所有人的施法。旁边的下拉框决定这条消息发往哪里。"
L["ALERT_OUTPUT_PRINT"] = "显示（仅自己可见）"
L["ALERT_OUTPUT_ANNOUNCE"] = "通报"
L["ALERT_OUTPUT_DESC"] =
	"这条消息发往哪里：只发一处，绝不两处都发。显示（仅自己可见）只出现在你自己的窗口里，不会给任何人添麻烦。通报则改为发到小队或团队频道，而向整个团队播报别人的一举一动，正是插件惹人嫌的原因，所以选它之前值得三思。你不在队伍中时，以及在战场和竞技场里，通报不会发出任何消息。"
L["ALERT_AGAINST_DESC"] =
	'哪些敌人计入：每个选项都包含排在它后面的选项。首领指骷髅等级（??）的敌人。地下城首领的等级不显示为骷髅，所以算作精英："同级及以上精英与首领"这一项会保留它，同时滤掉它周围等级较低的小怪。勾选"始终提示已标记的目标"时，团队标记优先于以上所有规则。'
L["TARGET_RUNG_ALL"] = "全部"
L["TARGET_RUNG_ELITE"] = "精英与首领"
L["TARGET_RUNG_ELITE_0"] = "同级及以上精英与首领"
L["TARGET_RUNG_BOSS"] = "首领"
L["ALERT_MARKED_ALWAYS"] = "始终提示已标记的目标"
L["ALERT_MARKED_ALWAYS_DESC"] =
	"带有团队标记（骷髅、十字，八个标记中的任何一个）的目标一律计入，不管开关旁边的下拉框选的是什么。标记是队伍指明重点目标的方式，所以有人标记过的目标，绝不会因为类型或等级不符而被漏掉。"

--[[
    The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
    list of seconds. Whole minutes read as minutes, and zero reads as "No
    Cooldown" rather than "0 Second Cooldown".

    TRANSLATORS: one format serves every count it is given, one minute and five
    alike, so word each to read for any number. An abbreviated unit does.
]]
L["COOLDOWN_NONE"] = "无冷却"
L["COOLDOWN_SECONDS"] = "冷却 %d 秒"
L["COOLDOWN_MINUTES"] = "冷却 %d 分钟"

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
L["SAMPLE_EXAMPLE"] = "示例：%s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "小明"
L["SAMPLE_PET"] = "旺财"

--[[
    The Naxxramas bosses the Example lines name, dealt one per line.

    TRANSLATORS: use each boss's name exactly as your client writes it, title
    included, not a translation of the English.
]]
L["SAMPLE_BOSS_ANUBREKHAN"] = "阿努布雷坎"
L["SAMPLE_BOSS_FAERLINA"] = "黑女巫法琳娜"
L["SAMPLE_BOSS_MAEXXNA"] = "迈克斯纳"
L["SAMPLE_BOSS_NOTH"] = "瘟疫使者诺斯"
L["SAMPLE_BOSS_HEIGAN"] = "肮脏的希尔盖"
L["SAMPLE_BOSS_LOATHEB"] = "洛欧塞布"
L["SAMPLE_BOSS_RAZUVIOUS"] = "教官拉苏维奥斯"
L["SAMPLE_BOSS_GOTHIK"] = "收割者戈提克"
L["SAMPLE_BOSS_MOGRAINE"] = "大领主莫格莱尼"
L["SAMPLE_BOSS_KORTHAZZ"] = "库尔塔兹领主"
L["SAMPLE_BOSS_BLAUMEUX"] = "女公爵布劳缪克丝"
L["SAMPLE_BOSS_ZELIEK"] = "瑟里耶克爵士"
L["SAMPLE_BOSS_PATCHWERK"] = "帕奇维克"
L["SAMPLE_BOSS_GROBBULUS"] = "格罗布鲁斯"
L["SAMPLE_BOSS_GLUTH"] = "格拉斯"
L["SAMPLE_BOSS_THADDIUS"] = "塔迪乌斯"
L["SAMPLE_BOSS_SAPPHIRON"] = "萨菲隆"
L["SAMPLE_BOSS_KELTHUZAD"] = "克尔苏加德"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "物品"
L["ABILITIES_CLASS_PET"] = "%s宠物"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] = "嘲讽是把仇恨从当前持有者身上抢过来的技能。"
L["TAUNTS_ENABLE"] = "启用嘲讽监视"

L["TAUNTS_SUCCESS_HEADER"] = "成功的嘲讽"
L["TAUNTS_SUCCESS_DESC"] =
	"生效并把怪物从别人身上抢过来的嘲讽。如果怪物本来就在打嘲讽者，这次嘲讽只是刷新仇恨而不是救场，所以这类嘲讽不会提示。"
L["TAUNTS_SUCCESS_ENABLE"] = "启用成功嘲讽提示，针对"
L["TAUNTS_SUCCESS_MINE"] = "我的成功嘲讽"
L["TAUNTS_SUCCESS_OTHERS"] = "他人的成功嘲讽"

L["TAUNTS_FAILED_HEADER"] = "失败的嘲讽"
L["TAUNTS_FAILED_DESC"] =
	"未命中、被抵抗，或者打在免疫目标上的嘲讽。怪物没有易主，而屏幕上并不会告诉你这一点。"
L["TAUNTS_FAILED_ENABLE"] = "启用失败嘲讽提示，针对"
L["TAUNTS_FAILED_MINE"] = "我的失败嘲讽"
L["TAUNTS_FAILED_OTHERS"] = "他人的失败嘲讽"

L["TAUNTS_AOE_HEADER"] = "群体嘲讽"
L["TAUNTS_AOE_DESC"] = "一次抓住周围所有目标的嘲讽，而不是只针对一个目标。"
L["TAUNTS_AOE_ENABLE"] = "启用群体嘲讽提示"
L["TAUNTS_AOE_MINE"] = "我的群体嘲讽"
L["TAUNTS_AOE_OTHERS"] = "他人的群体嘲讽"

L["TAUNTS_ABILITIES_HEADER"] = "嘲讽技能"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "群体嘲讽技能"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "打断会在敌人施法途中把法术打停。"
L["INTERRUPTS_ENABLE"] = "启用打断监视"

L["INTERRUPTS_ALERT_HEADER"] = "成功的打断"
L["INTERRUPTS_ALERT_DESC"] = "一次在半途被打停的施法。会说明是谁打断的，以及打断了什么。"
L["INTERRUPTS_ALERT_ENABLE"] = "启用成功打断提示，针对"
L["INTERRUPTS_ALERT_MINE"] = "我的成功打断"
L["INTERRUPTS_ALERT_OTHERS"] = "他人的成功打断"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "恐惧会让敌人四散奔逃，把一波怪物撒得满屋子都是。"
L["FEARS_ENABLE"] = "启用恐惧监视"

L["FEARS_ALERT_HEADER"] = "成功的恐惧"
L["FEARS_ALERT_DESC"] =
	"生效并把怪物撒到坦克够不着的地方的恐惧。只有生效才算：单纯的施法、被抵抗和免疫都没有挪动任何东西，所以三者都不会上报。"
L["FEARS_ALERT_ENABLE"] = "启用成功恐惧提示"
L["FEARS_ALERT_MINE"] = "我的成功恐惧"
L["FEARS_ALERT_OTHERS"] = "他人的成功恐惧"

L["FEARS_ABILITIES_HEADER"] = "恐惧技能"

--------------------------------------------------------------------------------
-- Incapacitated
--------------------------------------------------------------------------------

L["INCAPACITATED_SUMMARY"] =
	"在你失去角色控制的那一刻告诉队伍，好让别人替你顶上。被恐惧的坦克和被沉默的治疗，是最需要说出来的两个人，也恰恰是当时最没法开口的两个人。"
L["INCAPACITATED_ENABLE"] = "启用失控监视"

L["INCAPACITATED_HEADER"] = "自身失控"
L["INCAPACITATED_DESC"] =
	"当你陷入昏迷、恐惧、沉默，或以其他方式失去战斗能力时，告诉队伍：中了什么、谁施放的、持续多久，以及有没有人能驱散。"
--[[
    No trailing preposition and nothing beside it: this alert has no target
    ladder, and its "Long" threshold is a row of its own, above the two rows it
    names.
]]
L["INCAPACITATED_ALERT_ENABLE"] = "启用失控提示"
--[[
    The only pair of rows in the add-on that is not My and Others'. The game
    reports the player's own losses of control and nobody else's, so "whose"
    has one answer; how LONG it lasts is the question with two.

    TRANSLATORS: keep the quotes around Long in the caption. They mark it as the
    word the two rows below are named after rather than as an adjective.
]]
L["INCAPACITATED_LONG_CAPTION"] = '"长时"失控至少持续'
L["INCAPACITATED_LONG_CAPTION_DESC"] =
	'失控要持续多久才算"长时"。短于这个时长的都算"短时"。两者都不会被丢弃。下面两行分别决定它们发往哪里，而且默认指向不同的地方。'
-- The caption's dropdown: the first reads for 1 only, the second for 2 to 10.
L["INCAPACITATED_THRESHOLD_ONE"] = "%d 秒"
L["INCAPACITATED_THRESHOLD"] = "%d 秒"
L["INCAPACITATED_SHORT"] = "我的短时失控"
L["INCAPACITATED_SHORT_DESC"] =
	"失控时间短于上面设定的时长时，这条消息发往哪里。默认只显示在你自己的窗口：一个在别人来得及替你顶上之前就已结束的昏迷，只是解释了你刚刚丢掉的那个公共冷却，与别人无关。"
L["INCAPACITATED_LONG"] = "我的长时失控"
L["INCAPACITATED_LONG_DESC"] =
	"失控时间达到或超过上面设定的时长时，这条消息发往哪里。默认会通报：这种情况别人有时间做出反应，而你恰恰是那个没法开口的人。完全没有持续时间的效果，比如精神控制，算作长时失控。"

L["INCAPACITATED_STUN"] = "包含昏迷效果"
L["INCAPACITATED_STUN_DESC"] = "完全失去控制，原地不动。沉睡也算作昏迷。"
L["INCAPACITATED_FEAR"] = "包含恐惧效果"
L["INCAPACITATED_FEAR_DESC"] = "完全失去控制，向随机方向奔跑。怪物也会跟着你跑。"
L["INCAPACITATED_CHARM"] = "包含精神控制效果"
L["INCAPACITATED_CHARM_DESC"] =
	"完全处于别人的控制之下。通常是这份列表里最糟的情况，而且通常没有时限。"
L["INCAPACITATED_CONFUSE"] = "包含迷惑效果"
L["INCAPACITATED_CONFUSE_DESC"] = "完全失去控制，向随机方向走动。"
L["INCAPACITATED_SILENCE"] = "包含沉默效果"
L["INCAPACITATED_SILENCE_DESC"] =
	"无法施放法术。德鲁伊或圣骑士的嘲讽是法术，所以这意味着嘲讽放不出来了。"
L["INCAPACITATED_PACIFY"] = "包含平静效果"
L["INCAPACITATED_PACIFY_DESC"] = "无法攻击，但法术仍然可用。"
L["INCAPACITATED_SCHOOL_INTERRUPT"] = "包含法术封锁效果"
L["INCAPACITATED_SCHOOL_INTERRUPT_DESC"] =
	"无法施放某一系的法术。如果你用法术嘲讽，这项值得开启，因为被封锁了自然或神圣系法术的德鲁伊或圣骑士就没有嘲讽可用了。"
L["INCAPACITATED_ROOT"] = "包含定身效果"
L["INCAPACITATED_ROOT_DESC"] =
	"无法移动。被定身的坦克仍然能按嘲讽键，所以怪物哪儿也去不了。"
L["INCAPACITATED_DISARM"] = "包含缴械效果"
L["INCAPACITATED_DISARM_DESC"] = "无法用武器攻击。和定身一样，嘲讽键仍然能用。"

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
	"队伍里的坦克死了。这是唯一会改变其他人下一步该做什么的死亡，而四十个团队头像是最难注意到它的地方。"
L["TANK_DEATHS_ENABLE"] = "启用坦克死亡监视"

L["TANK_DEATHS_ALERT_HEADER"] = "坦克死亡"
L["TANK_DEATHS_ALERT_DESC"] =
	"在团队中，只计入被指派为主坦克的玩家，也包括你自己，队伍查找器的职责在团队中不起任何作用。在小队中，计入在队伍查找器中选择了坦克职责的人。两者都没有的坦克死亡时不会提示。"
L["TANK_DEATHS_ALERT_ENABLE"] = "启用坦克死亡提示"
L["TANK_DEATHS_ALERT_MINE"] = "我的死亡"
L["TANK_DEATHS_ALERT_MINE_DESC"] =
	"报告你在当坦克时自己的死亡。旁边的下拉框决定这条消息发往哪里。"
L["TANK_DEATHS_ALERT_OTHERS"] = "他人的坦克死亡"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] =
	"报告你队伍里其他正在当坦克的人的死亡。旁边的下拉框决定这条消息发往哪里。"

L["TANK_DEATHS_CLASS_HEADER"] = "按职业的死亡"
L["TANK_DEATHS_CLASS_DESC"] = "其余所有死亡，按职业列出，挑你想盯的。"
L["TANK_DEATHS_CLASS_ROW_DESC"] = "队伍中的%s死亡时提示。"

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] =
	"治疗做了对坦克弊大于利的事。仅限经典旧世和燃烧的远征：探索赛季会通过一个牧师符文把怒气还回来，而在更晚的游戏版本中这些都不成问题。"
L["BAD_PRIESTS_ENABLE"] = "启用捣蛋牧师监视"

L["BAD_PRIESTS_HEADER"] = "有害护盾"
L["BAD_PRIESTS_DESC"] =
	"提示落在正在当坦克的德鲁伊或战士身上的真言术：盾。怒气来自所受的伤害，而被护盾吸收的伤害不产生怒气，所以一个好心的护盾会让坦克缺少用来保持仇恨的怒气。"
L["BAD_PRIESTS_ALERT_ENABLE"] = "启用有害护盾提示"
L["BAD_PRIESTS_HEALTH_DESC"] =
	'坦克的生命值要降到多低，护盾才不再算失误。给快死的人上盾是正确的做法，所以生命值低于你在这里选择的水平时，警告保持安静。选择"始终"，每个护盾都会提示。'
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "始终"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "生命值低于 %d%% 时除外"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "有害护盾警告"
L["BAD_PRIESTS_REPORT_DESC"] =
	'有人给怒气坦克上盾时，警告发往哪里。这里没有"我的"和"他人的"两行之分：施法的是治疗，吃亏的是坦克。'
L["BAD_PRIESTS_SELF_ONLY"] = "担任德鲁伊或战士坦克时"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"只提示落在你身上的护盾，而且只在你是正在当坦克的德鲁伊或战士时提示。关闭此项，队伍里任何以这两个职业当坦克的人被上盾时都会提示。"
L["BAD_PRIESTS_WHISPER"] = "密语施法者"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"给施放护盾的人发一条密语，解释为什么这样有害。即使你队伍里有好几个人在用 Control Freak，也只会发出一条。"
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"同一个施法者触发护盾警告后，要过多久才会再次提示。它同时作用于显示、声音、通报和密语，因为不能让一个盾一好就套的治疗刷满你的窗口。"

--------------------------------------------------------------------------------
-- Bad Pets
--------------------------------------------------------------------------------

L["BAD_PETS_SUMMARY"] = "开着仇恨技能自动施放的猎人和术士宠物。"
L["BAD_PETS_ENABLE"] = "启用捣蛋宠物监视"

L["BAD_PETS_ALERT_HEADER"] = "宠物嘲讽"
L["BAD_PETS_ALERT_DESC"] =
	"开着自动施放、把怪物从坦克身上拉走的宠物，通常主人自己毫无察觉。"
L["BAD_PETS_ALERT_ENABLE"] = "启用宠物嘲讽提示，针对"
L["BAD_PETS_ALERT_MINE"] = "我的宠物嘲讽"
L["BAD_PETS_ALERT_OTHERS"] = "他人的宠物嘲讽"
L["BAD_PETS_WHISPER_ENABLE"] = "密语宠物主人"
L["BAD_PETS_WHISPER_ENABLE_DESC"] =
	"给宠物主人发一条密语，说明怎么关闭自动施放。即使你队伍里有好几个人在用 Control Freak，也只会发出一条。"
L["BAD_PETS_COOLDOWN_DESC"] =
	"同一只宠物触发提示后，要过多久才会再次提示。它同时作用于显示、声音、通报和密语，这样开着自动施放的宠物就不会刷满你的窗口，它的主人也不会每隔几秒就被密语一次。"

L["BAD_PETS_ABILITIES_HEADER"] = "捣蛋宠物技能"

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
L["TANKING_TOOLS_ENABLE"] = "启用坦克工具"
L["TANKING_TOOLS_MINIMAP_SUMMARY"] = "开场落空、护甲削弱、招架和新星。"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "开场落空"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"提示你自己没能打上的开场攻击：开怪最初几秒内的未命中、躲闪、招架、格挡、抵抗或免疫。那是本该产生却没有产生的仇恨，而且正发生在最要紧的时刻。"
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "启用开场落空提示，针对"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "我的开场落空"
L["TANKING_TOOLS_COLD_OPENER_MINE_DESC"] =
	"报告你自己没能打上的开场技能。旁边的下拉框决定这条消息发往哪里。"
-- The caption before the window dropdown: "Within [10 Seconds of Fight]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "限定在"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "开战后 %d 秒内"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"开怪后多长时间内落空的技能仍然计入。计时从 Control Freak 第一次发现那个怪物时开始，而且只计入技能：自动攻击落空得太频繁，算不上什么新闻。"

L["TANKING_TOOLS_ARMOR_HEADER"] = "护甲削弱"
L["TANKING_TOOLS_ARMOR_DESC"] =
	'报告队伍花了多久扒掉目标的护甲：五层破甲攻击，或者潜行者的破甲。在下面勾选某个"包含"项后，它还会等待那个削弱效果，但只在队伍里确实有人能施放时才等。'
L["TANKING_TOOLS_ARMOR_ENABLE"] = "启用护甲削弱提示，针对"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "护甲削弱报告"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	'队伍削掉目标护甲后，报告发往哪里。这里没有"我的"和"他人的"两行之分：这是全队的成果，只是报告给你。'
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "包含精灵之火"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"上报前等待精灵之火，无论德鲁伊以哪种形态施放。队伍中没有德鲁伊时忽略此项。"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "包含鲁莽诅咒"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] = "上报前等待鲁莽诅咒。队伍中没有术士时忽略此项。"

L["TANKING_TOOLS_PARRY_HEADER"] = "招架"
L["TANKING_TOOLS_PARRY_DESC"] =
	"有人被一只不归他坦的怪物招架，说明他正站在怪物正面。每一次招架都会让那只怪物更快地对拉住它的人挥出下一击。"
L["TANKING_TOOLS_PARRY_ENABLE"] = "启用招架提示，针对"
L["TANKING_TOOLS_PARRY_MINE"] = "我被招架"
L["TANKING_TOOLS_PARRY_MINE_DESC"] =
	"报告你的攻击被怪物招架。旁边的下拉框决定这条消息发往哪里。"
L["TANKING_TOOLS_PARRY_OTHERS"] = "他人被招架"
L["TANKING_TOOLS_PARRY_OTHERS_DESC"] =
	"报告你队伍里其他人的攻击被怪物招架。旁边的下拉框决定这条消息发往哪里。"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS"] = "忽略坦克"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS_DESC"] =
	"被招架的玩家是坦克时保持安静：在团队中被指派为主坦克，或在小队中选择了队伍查找器的坦克职责。副坦克站在首领面前是为了换坦时接嘲讽，这不是需要密语提醒的错误。你自己被招架时仍会提示。"
L["TANKING_TOOLS_PARRY_IGNORE_PETS"] = "忽略宠物"
L["TANKING_TOOLS_PARRY_IGNORE_PETS_DESC"] =
	"被招架的是宠物时保持安静，你自己的宠物也算。宠物站在主人派它去的地方，一条写着宠物名字的提示，队伍里没人能据此做什么。无论如何都不会密语宠物。"
L["TANKING_TOOLS_PARRY_WHISPER"] = "密语肇事者"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"给肇事者发一条密语，请他移动到怪物背后。即使你队伍里有好几个人在用 Control Freak，也只会发出一条。"
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"同一个肇事者触发招架警告后，要过多久才会再次提示。它同时作用于显示、声音、通报和密语，因为还没挪位置的人，不需要每挥一下就被提醒一次。"

L["TANKING_TOOLS_NOVA_HEADER"] = "新星"
L["TANKING_TOOLS_NOVA_DESC"] = "提示冰霜新星，它会把怪物冻在原地，让坦克够不着。"
L["TANKING_TOOLS_NOVA_ENABLE"] = "启用新星提示"
L["TANKING_TOOLS_NOVA_MINE"] = "我的新星"
L["TANKING_TOOLS_NOVA_OTHERS"] = "他人的新星"

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
L["UNKNOWN_SOURCE"] = "某人"
L["UNKNOWN_CASTER"] = "未知施法者"
L["UNKNOWN_TARGET"] = "未知目标"
L["UNKNOWN_SPELL"] = "未知法术"

L["TAUNT_SUCCESS"] = "嘲讽！%s 使用 %s，目标 %s。"
L["TAUNT_AOE"] = "群体嘲讽！%s 使用 %s。"
L["TAUNT_MISSED"] = "嘲讽失败！%s 使用 %s，目标 %s，未命中。"
L["TAUNT_RESISTED"] = "嘲讽失败！%s 使用 %s，目标 %s，被抵抗。"
--[[
    The one failure format that leads with the MOB rather than the taunter,
    because the immunity is the news and the other three formats have no news
    beyond "it did not land".

    TRANSLATORS: %s is, in order: mob, taunter, taunt. This is the ONLY taunt
    format whose first %s is not the player who cast it.
]]
L["TAUNT_IMMUNE"] = "嘲讽失败！%s 免疫：%s 使用了 %s。"
L["TAUNT_FAILED"] = "嘲讽失败！%s 使用 %s，目标 %s，无效果。"
L["INTERRUPT"] = "打断！%s 使用 %s，目标 %s，打断了 %s。"

L["FEAR_SUCCESS"] = "恐惧！%s 使用 %s，目标 %s。"
L["FEAR_AOE"] = "群体恐惧！%s 使用 %s。"

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
L["INCAPACITATED"] = "%s失控 %s！%s 中了 %s（%s），来自 %s。"
L["INCAPACITATED_PLAIN"] = "%s失控 %s！%s 中了 %s，来自 %s。"
L["INCAPACITATED_INDEFINITE"] = "%s失控！%s 中了 %s（%s），来自 %s。"
L["INCAPACITATED_PLAIN_INDEFINITE"] = "%s失控！%s 中了 %s，来自 %s。"

--[[
    The seat the line opens on, as its own phrase rather than a format per role,
    which would be eight copies of the four above.

    TRANSLATORS: this is the client's own word for the group finder role, and it
    opens a sentence. "Afflicted by" in the formats above is deliberately the
    phrasing Blizzard's combat log uses for a debuff landing
    (AURAADDEDOTHERHARMFUL), so a player reads the same words here as in the log
    they already watch -- use your client's wording for both if it has one.
]]
L["INCAPACITATED_ROLE_TANK"] = "坦克"
L["INCAPACITATED_ROLE_HEALER"] = "治疗"

--[[
    The length, as its own phrase rather than a bare number with "seconds" in the
    format, so the singular does not need two more formats beside the four
    above. Always a whole number: the handler rounds UP, because a fear reported
    as 5.9 promises a taunt back sooner than it is coming.

    TRANSLATORS: the handler reads exactly these two, the first for 1 and the
    second for every other count, so a language with more number forms words
    the second to read for any count. An abbreviated unit does.
]]
L["INCAPACITATED_SECOND"] = "%d 秒"
L["INCAPACITATED_SECONDS"] = "%d 秒"

--[[
    The four debuff types a player can take off. They name the class that can
    help -- Magic is a priest or paladin, Curse a mage or druid -- so they are
    the half of the line a tank cannot act on alone.

    TRANSLATORS: use the client's own words for these, the ones on the debuff
    tooltips, not a literal translation of the English.
]]
L["DISPEL_MAGIC"] = "魔法"
L["DISPEL_CURSE"] = "诅咒"
L["DISPEL_DISEASE"] = "疾病"
L["DISPEL_POISON"] = "中毒"

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
L["TANK_DEATHS_TANK_LINE"] = "坦克倒了！%s 死亡。"
L["TANK_DEATHS_CLASS_LINE"] = "%s倒了！%s 死亡。"

--[[
    Kept short on purpose: they render with a real spell link and two real names
    inside the 255 byte chat limit, and the widest locale runs close to twice the
    English.

    The WARNING carries no explanation and the WHISPER carries all of it. The
    warning fires mid-pull in front of a tank who already knows what a shield
    does; the whisper goes to the healer who does not, and is read after the
    fact. The tab description explains it at length for whoever wants it.
]]
L["SHIELD_WARNING"] = "有害护盾！%s 使用 %s，目标 %s。"
L["SHIELD_WHISPER"] =
	"有害护盾！请尽量别把 %s 套在 %s 身上。这个技能会让坦克无法获得怒气。"

L["BAD_PET"] = "捣蛋宠物！%s 的宠物 %s 使用 %s，目标 %s。"
L["BAD_PET_AOE"] = "捣蛋宠物！%s 的宠物 %s 使用 %s。"
L["BAD_PET_UNKNOWN_OWNER"] = "捣蛋宠物！%s 使用 %s，目标 %s。"
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "捣蛋宠物！%s 使用 %s。"
--[[
    Kept short on purpose. They render with a spell link and up to two names inside
    a 255 byte chat limit, and the widest locale runs close to twice the English.
]]
L["BAD_PET_WHISPER"] = "你的宠物 %s 使用了 %s，目标 %s。右键点击该技能即可关闭自动施放。"
L["BAD_PET_WHISPER_AOE"] = "你的宠物 %s 使用了 %s。右键点击该技能即可关闭自动施放。"

L["COLD_OPENER_MISS"] = "小心！%s 使用 %s，对 %s 未命中。"
L["COLD_OPENER_DODGE"] = "小心！%s 使用 %s，被 %s 躲闪。"
L["COLD_OPENER_PARRY"] = "小心！%s 使用 %s，被 %s 招架。"
L["COLD_OPENER_BLOCK"] = "小心！%s 使用 %s，被 %s 格挡。"
L["COLD_OPENER_IMMUNE"] = "小心！%s 使用 %s，%s 免疫。"
L["COLD_OPENER_RESIST"] = "小心！%s 使用 %s，被 %s 抵抗。"

L["ARMOR_REPORT"] = "护甲已削弱！%s 用了 %s 秒变得脆弱。"

L["PARRY_WARNING"] = "招架加速！%s 正站在 %s 的正面。"
L["PARRY_WHISPER"] = "招架加速！请站到 %s 背后：每次招架都会加快它的下一次攻击。"

L["NOVA"] = "新星！%s 使用 %s，目标 %s。"
L["NOVA_AOE"] = "群体新星！%s 使用 %s。"
