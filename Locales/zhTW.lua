local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "zhTW")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] = "資訊更好 = 坦克更好。坦克更好 = 團隊更好。"
L["VERSION"] = "版本"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"版本 %s。設定（包含關閉這則訊息的選項）可以在 選項 > AddOns > Control Freak 裡找到。喜歡這個插件嗎？告訴朋友吧！(="
L["CHAT_OPTIONS_IN_COMBAT"] = "為了安全起見，戰鬥中無法開啟選項介面。"

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "啟用歡迎訊息"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "登入時顯示 Control Freak 的問候語。"
L["ENABLE_MINIMAP_BUTTON"] = "啟用小地圖按鈕"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "在你的小地圖上顯示 Control Freak 按鈕。"

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "開啟本插件的選項介面。"

-- The master switch. Its description is shared with the mini-map button's own
-- line for the same toggle, so the two cannot describe it differently.
L["KILL_SWITCH"] = "總開關"
L["KILL_SWITCH_ENABLE"] = "啟用 Control Freak"
L["KILL_SWITCH_ENABLE_DESC"] = "開啟或關閉 Control Freak 的所有提示。"

L["FEEDBACK_HEADER"] = "意見與支援"
L["FEEDBACK_DISCORD"] = "Discord"
L["FEEDBACK_GITHUB"] = "GitHub"
L["FEEDBACK_CURSEFORGE"] = "CurseForge"
L["FEEDBACK_WAGO"] = "Wago"

--------------------------------------------------------------------------------
-- Mini-map Button
--------------------------------------------------------------------------------

L["STATE_ON"] = "開"
L["STATE_OFF"] = "關"
L["LEFT_CLICK"] = "左鍵點擊"
L["RIGHT_CLICK"] = "右鍵點擊"
L["SHIFT_MIDDLE_CLICK"] = "Shift + 中鍵點擊"
L["ACTION_TOGGLE"] = "切換"
L["MINIMAP_OPTIONS"] = "Control Freak 選項"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

L["TAB_TAUNTS"] = "嘲諷"
L["TAB_INTERRUPTS"] = "打斷"
L["TAB_FEARS"] = "恐懼"
L["TAB_BAD_PET"] = "搗蛋寵物"
L["TAB_TANKING_TOOLS"] = "坦克工具"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "開啟或關閉這項功能。"
L["SCOPE_TANK_ROLE_ONLY"] = "只在你擔任坦克時"
L["SCOPE_TANK_ROLE_ONLY_DESC"] =
	"只在你正在坦怪時觸發，無論是作為團隊的主坦克，或是在隊伍搜尋器中選了坦克職責。兩者都沒有設定時，這項功能保持安靜。"
L["SCOPE_GROUP_HAS_TANK"] = "只在隊伍中有坦克時"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"只在你隊伍中有人正在坦怪而且還活著時觸發。倒下的坦克算作沒有坦克，因為那正是需要別人接住仇恨的時候。"
L["SCOPE_INSTANCE_ONLY"] = "只在副本中"
L["SCOPE_INSTANCE_ONLY_DESC"] = "只在地城和團隊副本中觸發。"

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
L["ALERT_SECTION_ENABLE_DESC"] = "開啟或關閉這則提示。"
L["ALERT_PRINT"] = "輸出提示"
L["ALERT_PRINT_DESC"] = "把這則提示輸出到你自己的聊天視窗。"
L["ALERT_PRINT_SCOPE_DESC"] =
	"哪些人的施法會進到你自己的視窗。我的包含你和你自己的寵物；全部包含你隊伍裡的每一個人。音效同樣跟著這項設定，所以你不會聽到看不到的提示。"
L["ALERT_ANNOUNCE"] = "向隊伍通報"
L["ALERT_ANNOUNCE_DESC"] =
	"把這則提示送到你的隊伍或團隊頻道。向整個團隊播報別人做了什麼，是插件最快惹人厭的方式，所以開啟之前值得想一想。"
L["ALERT_ANNOUNCE_SCOPE_DESC"] =
	"哪些人的施法會送到隊伍或團隊頻道。我的包含你和你自己的寵物；全部包含你隊伍裡的每一個人，也包含你自己。"
L["ALERT_SCOPE_MINE"] = "我的"
L["ALERT_SCOPE_ALL"] = "全部"
L["ALERT_BOSS_ONLY"] = "只針對首領與精英"
L["ALERT_BOSS_ONLY_DESC"] =
	"只針對值得留意的敵人觸發：團隊首領、地城首領，以及任何等級高於你的精英怪。"
L["ALERT_SOUND"] = "音效"
L["ALERT_SOUND_DESC"] = "這則提示觸發時播放一個音效。"
L["ALERT_SOUND_FILE_DESC"] = "選擇這則提示播放的音效。選取時會立刻播放。"
L["ALERT_SOUND_PREVIEW_DESC"] = "立刻播放這個音效，不管音效有沒有開啟。"
L["SOUND_NONE"] = "無"

-- The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
-- list of seconds. Whole minutes read as minutes, and zero reads as "No
-- Cooldown" rather than "0 Second Cooldown".
L["COOLDOWN_NONE"] = "無冷卻"
L["COOLDOWN_SECONDS"] = "冷卻 %d 秒"
L["COOLDOWN_MINUTES"] = "冷卻 %d 分鐘"

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
L["SAMPLE_EXAMPLE"] = "範例：%s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "小明"
L["SAMPLE_PET"] = "來福"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "物品"
L["ABILITIES_CLASS_PET"] = "%s寵物"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] = "嘲諷是把仇恨從目前持有者身上搶過來的技能。"
L["TAUNTS_ENABLE"] = "啟用嘲諷監看"

L["TAUNTS_SUCCESS_HEADER"] = "成功的嘲諷"
L["TAUNTS_SUCCESS_ENABLE"] = "啟用成功嘲諷提示"
L["TAUNTS_SUCCESS_DESC"] =
	"生效並把怪物從別人身上搶過來的嘲諷。對著已經在打嘲諷者的怪物再嘲諷，只是刷新仇恨而不是救場，所以那些不會提示。"
L["TAUNTS_FAILED_HEADER"] = "失敗的嘲諷"
L["TAUNTS_FAILED_ENABLE"] = "啟用失敗嘲諷提示"
L["TAUNTS_FAILED_DESC"] =
	"未命中、被抵抗，或是打在免疫目標上的嘲諷。怪物沒有易主，而畫面上並不會告訴你這件事。"
L["TAUNTS_AOE_HEADER"] = "群體嘲諷"
L["TAUNTS_AOE_ENABLE"] = "啟用群體嘲諷提示"
L["TAUNTS_AOE_DESC"] = "一次抓住周圍所有目標的嘲諷，而不是只針對一個目標。"

L["TAUNTS_ABILITIES_HEADER"] = "嘲諷技能"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "群體嘲諷技能"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "打斷會在敵人施法途中把法術打停。"
L["INTERRUPTS_ENABLE"] = "啟用打斷監看"

L["INTERRUPTS_ALERT_HEADER"] = "成功的打斷"
L["INTERRUPTS_ALERT_ENABLE"] = "啟用成功打斷提示"
L["INTERRUPTS_ALERT_DESC"] = "一次在半途被打停的施法。會說明是誰打斷的，以及打斷了什麼。"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "恐懼會讓敵人四散奔逃，把一波怪物撒得滿屋子都是。"
L["FEARS_ENABLE"] = "啟用恐懼監看"

L["FEARS_ALERT_HEADER"] = "恐懼"
L["FEARS_ALERT_ENABLE"] = "啟用恐懼提示"
L["FEARS_ALERT_DESC"] =
	"生效並把怪物撒到坦克搆不著的地方的恐懼。只有生效才算：單純的施法、被抵抗和免疫都沒有挪動任何東西，所以三者都不會回報。"

L["FEARS_ABILITIES_HEADER"] = "恐懼技能"

--------------------------------------------------------------------------------
-- Bad Pet
--------------------------------------------------------------------------------

-- The summary doubles as the mini-map button's Bad Pet line, so the tab and the
-- tooltip cannot describe the feature differently.
L["BAD_PET_SUMMARY"] = "把仇恨技能留在自動施放狀態的獵人和術士寵物。"
L["BAD_PET_ENABLE"] = "啟用搗蛋寵物監看"

L["BAD_PET_ALERT_HEADER"] = "寵物嘲諷"
L["BAD_PET_ALERT_ENABLE"] = "啟用寵物嘲諷提示"
L["BAD_PET_ALERT_DESC"] =
	"開著自動施放、把怪物從坦克身上拉走的寵物，通常主人自己毫無察覺。"
L["BAD_PET_WHISPER_ENABLE"] = "密語主人"
L["BAD_PET_WHISPER_ENABLE_DESC"] =
	"給寵物主人發一則密語，說明怎麼關閉自動施放。就算你隊伍裡有好幾個人在用 Control Freak，也只會發出一則。"
L["BAD_PET_COOLDOWN_DESC"] =
	"一隻寵物觸發提示之後保持安靜的時間。它涵蓋輸出、音效、通報和密語，這樣開著自動施放的寵物就不會洗版你的視窗，牠的主人也不會每隔幾秒就被密語一次。"

L["BAD_PET_ABILITIES_HEADER"] = "搗蛋寵物技能"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

-- No summary line: the Tanking Tools tab opens on its enable, because the tab is
-- a collection of unrelated warnings rather than one idea a sentence can cover.
-- Each section introduces itself instead.
L["TANKING_TOOLS_ENABLE"] = "啟用坦克工具"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "開場落空"
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "啟用開場落空提示"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"提示你自己沒能打上的開場攻擊：開怪最初幾秒內的未命中、閃躲、招架、格擋、抵抗或免疫。那是本該產生卻沒有產生的仇恨，而且正發生在最要緊的時刻。"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"開怪之後多久之內被閃過的技能仍然計入。計時從 Control Freak 第一次看到那隻怪物時開始，而且只計入技能：普通攻擊落空得太頻繁，算不上什麼消息。"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "戰鬥 %d 秒內"

L["TANKING_TOOLS_ARMOR_HEADER"] = "護甲削弱"
L["TANKING_TOOLS_ARMOR_ENABLE"] = "啟用護甲削弱提示"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"回報隊伍把目標護甲扒下來花了多久：五層破甲攻擊，或是盜賊的一個割裂。在下面勾選附加項目，它也會等那一項，但只在隊伍裡真的有人能施放時才等。"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "包含精靈之火"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"回報前等待精靈之火，無論德魯伊以哪種形態施放。隊伍中沒有德魯伊時忽略這一項。"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "包含魯莽詛咒"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] = "回報前等待魯莽詛咒。隊伍中沒有術士時忽略這一項。"

L["TANKING_TOOLS_PARRY_HEADER"] = "招架"
L["TANKING_TOOLS_PARRY_ENABLE"] = "啟用招架提示"
L["TANKING_TOOLS_PARRY_DESC"] =
	"被自己沒有在坦的怪物招架，代表這個人正站在怪物的正面。每一次招架都會加快那隻怪物對目前仇恨持有者的下一次揮擊。"
L["TANKING_TOOLS_PARRY_WHISPER"] = "密語肇事者"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"給肇事者發一則密語，請他移動到怪物背後。就算你隊伍裡有好幾個人在用 Control Freak，也只會發出一則。"
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"一個肇事者觸發招架警告之後保持安靜的時間。它涵蓋輸出、音效、通報和密語，因為還沒挪動的人不需要每揮一次就被提醒一次。"

L["TANKING_TOOLS_NOVA_HEADER"] = "新星"
L["TANKING_TOOLS_NOVA_ENABLE"] = "啟用新星提示"
L["TANKING_TOOLS_NOVA_DESC"] = "提示寒冰新星，它會把怪物撒到坦克搆不著的地方。"

--------------------------------------------------------------------------------
-- Message Formats
--------------------------------------------------------------------------------

L["UNKNOWN_SOURCE"] = "某人"
L["UNKNOWN_TARGET"] = "未知目標"
L["UNKNOWN_SPELL"] = "未知法術"

L["TAUNT_SUCCESS"] = "嘲諷！%s 使用 %s，目標 %s！"
L["TAUNT_AOE"] = "群體嘲諷！%s 使用 %s！"
L["TAUNT_MISSED"] = "嘲諷失敗！%s 使用 %s，目標 %s，未命中！"
L["TAUNT_RESISTED"] = "嘲諷失敗！%s 使用 %s，目標 %s，被抵抗！"
L["TAUNT_IMMUNE"] = "嘲諷失敗！%s 使用 %s，目標 %s，沒有效果！%s 免疫。"
L["TAUNT_FAILED"] = "嘲諷失敗！%s 使用 %s，目標 %s，沒有效果！"
L["TAUNT_STOLEN"] = "喂，那是我的！%s 使用 %s，目標 %s！" -- parked; see Data/Default-Settings.lua

L["FEAR_SUCCESS"] = "恐懼！%s 使用 %s，目標 %s！"
L["FEAR_AOE"] = "群體恐懼！%s 使用 %s！"

L["INTERRUPT"] = "打斷！%s 使用 %s，目標 %s，打斷了 %s！"

L["COLD_OPENER_MISS"] = "小心！%s 使用 %s，對 %s 未命中！"
L["COLD_OPENER_DODGE"] = "小心！%s 使用 %s，被 %s 閃躲！"
L["COLD_OPENER_PARRY"] = "小心！%s 使用 %s，被 %s 招架！"
L["COLD_OPENER_BLOCK"] = "小心！%s 使用 %s，被 %s 格擋！"
L["COLD_OPENER_IMMUNE"] = "小心！%s 使用 %s，%s 免疫！"
L["COLD_OPENER_RESIST"] = "小心！%s 使用 %s，被 %s 抵抗！"

L["ARMOR_REPORT"] = "%s 的護甲已削弱，花了 %s 秒！"

L["PARRY_WARNING"] = "招架加速！%s 正站在 %s 的正面！"
L["PARRY_WHISPER"] = "嘿，麻煩站到 %s 的背後。招架加速會讓我承受更多傷害。"

L["NOVA"] = "新星！%s 使用 %s，目標 %s！"
L["NOVA_AOE"] = "群體新星！%s 使用 %s！"
-- parked with the bubbles themselves; still reads "Annoyance!" and wants wording
-- of its own when Bubble Warnings lands. See Data/Abilities.lua.
L["ANNOYANCE_BUBBLE"] = "真煩人！%s 使用 %s，目標 %s，生命值 %d%%！"

L["BAD_PET"] = "搗蛋寵物！%s 的寵物 %s 使用 %s，目標 %s！"
L["BAD_PET_AOE"] = "搗蛋寵物！%s 的寵物 %s 使用 %s！"
L["BAD_PET_OWN"] = "搗蛋寵物！你的寵物 %s 使用 %s，目標 %s！"
L["BAD_PET_OWN_AOE"] = "搗蛋寵物！你的寵物 %s 使用 %s！"
L["BAD_PET_UNKNOWN_OWNER"] = "搗蛋寵物！%s 使用 %s，目標 %s！"
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "搗蛋寵物！%s 使用 %s！"
L["BAD_PET_WHISPER"] =
	"你的寵物 %s 使用了 %s，目標 %s。在寵物快捷列或法術書中按右鍵點擊該技能，即可關閉自動施放。"
