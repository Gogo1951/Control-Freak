local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "zhCN")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] = "信息更好 = 坦克更好。坦克更好 = 团队更好。"
L["VERSION"] = "版本"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"版本 %s。设置（包括关闭这条消息的选项）可以在 选项 > AddOns > Control Freak 中找到。喜欢这个插件吗？告诉朋友吧！(="
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

-- The master switch. Its description is shared with the mini-map button's own
-- line for the same toggle, so the two cannot describe it differently.
L["KILL_SWITCH"] = "总开关"
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

L["STATE_ON"] = "开"
L["STATE_OFF"] = "关"
L["LEFT_CLICK"] = "左键点击"
L["RIGHT_CLICK"] = "右键点击"
L["SHIFT_MIDDLE_CLICK"] = "Shift + 中键点击"
L["ACTION_TOGGLE"] = "切换"
L["MINIMAP_OPTIONS"] = "Control Freak 选项"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

L["TAB_TAUNTS"] = "嘲讽"
L["TAB_INTERRUPTS"] = "打断"
L["TAB_FEARS"] = "恐惧"
L["TAB_BAD_PET"] = "捣蛋宠物"
L["TAB_TANKING_TOOLS"] = "坦克工具"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "打开或关闭此功能。"
L["SCOPE_TANK_ROLE_ONLY"] = "仅当你担任坦克时"
L["SCOPE_TANK_ROLE_ONLY_DESC"] =
	"只在你正在坦克时触发，无论是作为团队的主坦克，还是在队伍查找器中选择了坦克职责。两者都没有设置时，此功能保持安静。"
L["SCOPE_GROUP_HAS_TANK"] = "仅当队伍中有坦克时"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"只在你队伍中有人正在坦克并且还活着时触发。倒下的坦克算作没有坦克，因为那正是需要别人接住仇恨的时候。"
L["SCOPE_INSTANCE_ONLY"] = "仅在副本中"
L["SCOPE_INSTANCE_ONLY_DESC"] = "只在地下城和团队副本中触发。"

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
L["ALERT_SECTION_ENABLE_DESC"] = "打开或关闭这条提示。"
L["ALERT_PRINT"] = "输出提示"
L["ALERT_PRINT_DESC"] = "把这条提示输出到你自己的聊天窗口。"
L["ALERT_PRINT_SCOPE_DESC"] =
	"哪些人的施法会进入你自己的窗口。我的包含你和你自己的宠物；全部包含你队伍中的每一个人。声音同样跟随这项设置，所以你不会听到看不到的提示。"
L["ALERT_ANNOUNCE"] = "向队伍通报"
L["ALERT_ANNOUNCE_DESC"] =
	"把这条提示发送到你的小队或团队频道。向整个团队播报别人做了什么，是插件最快招人烦的方式，所以打开之前值得想一想。"
L["ALERT_ANNOUNCE_SCOPE_DESC"] =
	"哪些人的施法会发到小队或团队频道。我的包含你和你自己的宠物；全部包含你队伍中的每一个人，也包括你自己。"
L["ALERT_SCOPE_MINE"] = "我的"
L["ALERT_SCOPE_ALL"] = "全部"
L["ALERT_BOSS_ONLY"] = "仅针对首领与精英"
L["ALERT_BOSS_ONLY_DESC"] =
	"只针对值得留意的敌人触发：团队首领、地下城首领，以及任何等级高于你的精英怪。"
L["ALERT_SOUND"] = "声音"
L["ALERT_SOUND_DESC"] = "这条提示触发时播放一个声音。"
L["ALERT_SOUND_FILE_DESC"] = "选择这条提示播放的声音。选中时会立即播放。"
L["ALERT_SOUND_PREVIEW_DESC"] = "立即播放这个声音，无论声音是否已打开。"
L["SOUND_NONE"] = "无"

-- The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
-- list of seconds. Whole minutes read as minutes, and zero reads as "No
-- Cooldown" rather than "0 Second Cooldown".
L["COOLDOWN_NONE"] = "无冷却"
L["COOLDOWN_SECONDS"] = "冷却 %d 秒"
L["COOLDOWN_MINUTES"] = "冷却 %d 分钟"

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
L["SAMPLE_EXAMPLE"] = "示例：%s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "小明"
L["SAMPLE_PET"] = "旺财"

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
L["TAUNTS_SUCCESS_ENABLE"] = "启用成功嘲讽提示"
L["TAUNTS_SUCCESS_DESC"] =
	"生效并把怪物从别人身上抢过来的嘲讽。对着已经在打嘲讽者的怪物再嘲讽，只是刷新仇恨而不是救场，所以那些不会提示。"
L["TAUNTS_FAILED_HEADER"] = "失败的嘲讽"
L["TAUNTS_FAILED_ENABLE"] = "启用失败嘲讽提示"
L["TAUNTS_FAILED_DESC"] =
	"未命中、被抵抗，或者打在免疫目标上的嘲讽。怪物没有易主，而屏幕上并不会告诉你这一点。"
L["TAUNTS_AOE_HEADER"] = "群体嘲讽"
L["TAUNTS_AOE_ENABLE"] = "启用群体嘲讽提示"
L["TAUNTS_AOE_DESC"] = "一次抓住周围所有目标的嘲讽，而不是只针对一个目标。"

L["TAUNTS_ABILITIES_HEADER"] = "嘲讽技能"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "群体嘲讽技能"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "打断会在敌人施法途中把法术打停。"
L["INTERRUPTS_ENABLE"] = "启用打断监视"

L["INTERRUPTS_ALERT_HEADER"] = "成功的打断"
L["INTERRUPTS_ALERT_ENABLE"] = "启用成功打断提示"
L["INTERRUPTS_ALERT_DESC"] = "一次在半途被打停的施法。会说明是谁打断的，以及打断了什么。"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "恐惧会让敌人四散奔逃，把一波怪物撒得满屋子都是。"
L["FEARS_ENABLE"] = "启用恐惧监视"

L["FEARS_ALERT_HEADER"] = "恐惧"
L["FEARS_ALERT_ENABLE"] = "启用恐惧提示"
L["FEARS_ALERT_DESC"] =
	"生效并把怪物撒到坦克够不着的地方的恐惧。只有生效才算：单纯的施法、被抵抗和免疫都没有挪动任何东西，所以三者都不会上报。"

L["FEARS_ABILITIES_HEADER"] = "恐惧技能"

--------------------------------------------------------------------------------
-- Bad Pet
--------------------------------------------------------------------------------

-- The summary doubles as the mini-map button's Bad Pet line, so the tab and the
-- tooltip cannot describe the feature differently.
L["BAD_PET_SUMMARY"] = "把仇恨技能留在自动施放状态的猎人和术士宠物。"
L["BAD_PET_ENABLE"] = "启用捣蛋宠物监视"

L["BAD_PET_ALERT_HEADER"] = "宠物嘲讽"
L["BAD_PET_ALERT_ENABLE"] = "启用宠物嘲讽提示"
L["BAD_PET_ALERT_DESC"] =
	"开着自动施放、把怪物从坦克身上拉走的宠物，通常主人自己毫无察觉。"
L["BAD_PET_WHISPER_ENABLE"] = "密语主人"
L["BAD_PET_WHISPER_ENABLE_DESC"] =
	"给宠物主人发一条密语，说明怎么关闭自动施放。即使你队伍里有好几个人在用 Control Freak，也只会发出一条。"
L["BAD_PET_COOLDOWN_DESC"] =
	"一只宠物触发提示之后保持安静的时长。它涵盖输出、声音、通报和密语，这样开着自动施放的宠物就不会刷满你的窗口，它的主人也不会每隔几秒就被密语一次。"

L["BAD_PET_ABILITIES_HEADER"] = "捣蛋宠物技能"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

-- No summary line: the Tanking Tools tab opens on its enable, because the tab is
-- a collection of unrelated warnings rather than one idea a sentence can cover.
-- Each section introduces itself instead.
L["TANKING_TOOLS_ENABLE"] = "启用坦克工具"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "开场落空"
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "启用开场落空提示"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"提示你自己没能打上的开场攻击：开怪最初几秒内的未命中、躲闪、招架、格挡、抵抗或免疫。那是本该产生却没有产生的仇恨，而且正发生在最要紧的时刻。"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"开怪之后多久之内被闪避的技能仍然计入。计时从 Control Freak 第一次看到那个怪物时开始，而且只计入技能：普通攻击落空得太频繁，算不上什么消息。"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "战斗 %d 秒内"

L["TANKING_TOOLS_ARMOR_HEADER"] = "护甲削弱"
L["TANKING_TOOLS_ARMOR_ENABLE"] = "启用护甲削弱提示"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"上报队伍把目标护甲扒下来用了多久：五层破甲攻击，或者潜行者的一个割裂。在下面勾选附加项，它也会等那一项，但只在队伍里真的有人能施放时才等。"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "包含精灵之火"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"上报前等待精灵之火，无论德鲁伊以哪种形态施放。队伍中没有德鲁伊时忽略此项。"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "包含鲁莽诅咒"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] = "上报前等待鲁莽诅咒。队伍中没有术士时忽略此项。"

L["TANKING_TOOLS_PARRY_HEADER"] = "招架"
L["TANKING_TOOLS_PARRY_ENABLE"] = "启用招架提示"
L["TANKING_TOOLS_PARRY_DESC"] =
	"被自己没有在坦克的怪物招架，说明这个人正站在怪物的正面。每一次招架都会加快那只怪物对当前仇恨持有者的下一次挥击。"
L["TANKING_TOOLS_PARRY_WHISPER"] = "密语肇事者"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"给肇事者发一条密语，请他移动到怪物背后。即使你队伍里有好几个人在用 Control Freak，也只会发出一条。"
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"一个肇事者触发招架警告之后保持安静的时长。它涵盖输出、声音、通报和密语，因为还没挪动的人不需要每挥一次就被提醒一次。"

L["TANKING_TOOLS_NOVA_HEADER"] = "新星"
L["TANKING_TOOLS_NOVA_ENABLE"] = "启用新星提示"
L["TANKING_TOOLS_NOVA_DESC"] = "提示冰霜新星，它会把怪物撒到坦克够不着的地方。"

--------------------------------------------------------------------------------
-- Message Formats
--------------------------------------------------------------------------------

L["UNKNOWN_SOURCE"] = "某人"
L["UNKNOWN_TARGET"] = "未知目标"
L["UNKNOWN_SPELL"] = "未知法术"

L["TAUNT_SUCCESS"] = "嘲讽！%s 使用 %s，目标 %s！"
L["TAUNT_AOE"] = "群体嘲讽！%s 使用 %s！"
L["TAUNT_MISSED"] = "嘲讽失败！%s 使用 %s，目标 %s，未命中！"
L["TAUNT_RESISTED"] = "嘲讽失败！%s 使用 %s，目标 %s，被抵抗！"
L["TAUNT_IMMUNE"] = "嘲讽失败！%s 使用 %s，目标 %s，无效果！%s 免疫。"
L["TAUNT_FAILED"] = "嘲讽失败！%s 使用 %s，目标 %s，无效果！"
L["TAUNT_STOLEN"] = "喂，那是我的！%s 使用 %s，目标 %s！" -- parked; see Data/Default-Settings.lua

L["FEAR_SUCCESS"] = "恐惧！%s 使用 %s，目标 %s！"
L["FEAR_AOE"] = "群体恐惧！%s 使用 %s！"

L["INTERRUPT"] = "打断！%s 使用 %s，目标 %s，打断了 %s！"

L["COLD_OPENER_MISS"] = "小心！%s 使用 %s，对 %s 未命中！"
L["COLD_OPENER_DODGE"] = "小心！%s 使用 %s，被 %s 躲闪！"
L["COLD_OPENER_PARRY"] = "小心！%s 使用 %s，被 %s 招架！"
L["COLD_OPENER_BLOCK"] = "小心！%s 使用 %s，被 %s 格挡！"
L["COLD_OPENER_IMMUNE"] = "小心！%s 使用 %s，%s 免疫！"
L["COLD_OPENER_RESIST"] = "小心！%s 使用 %s，被 %s 抵抗！"

L["ARMOR_REPORT"] = "%s 的护甲已削弱，耗时 %s 秒！"

L["PARRY_WARNING"] = "招架加速！%s 正站在 %s 的正面！"
L["PARRY_WHISPER"] = "嘿，麻烦站到 %s 的背后。招架加速会让我承受更多伤害。"

L["NOVA"] = "新星！%s 使用 %s，目标 %s！"
L["NOVA_AOE"] = "群体新星！%s 使用 %s！"
-- parked with the bubbles themselves; still reads "Annoyance!" and wants wording
-- of its own when Bubble Warnings lands. See Data/Abilities.lua.
L["ANNOYANCE_BUBBLE"] = "真烦人！%s 使用 %s，目标 %s，生命值 %d%%！"

L["BAD_PET"] = "捣蛋宠物！%s 的宠物 %s 使用 %s，目标 %s！"
L["BAD_PET_AOE"] = "捣蛋宠物！%s 的宠物 %s 使用 %s！"
L["BAD_PET_OWN"] = "捣蛋宠物！你的宠物 %s 使用 %s，目标 %s！"
L["BAD_PET_OWN_AOE"] = "捣蛋宠物！你的宠物 %s 使用 %s！"
L["BAD_PET_UNKNOWN_OWNER"] = "捣蛋宠物！%s 使用 %s，目标 %s！"
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "捣蛋宠物！%s 使用 %s！"
L["BAD_PET_WHISPER"] =
	"你的宠物 %s 使用了 %s，目标 %s。在宠物动作条或法术书中右键点击该技能，即可关闭自动施放。"
