local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "zhTW")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"戰鬥播報插件，涵蓋嘲諷、打斷、恐懼、坦克死亡、搗蛋寵物、招架、護甲削弱以及其他關鍵戰鬥事件。透過可自訂的提示，掌握誰嘲諷了、什麼失敗了、誰打斷了施法，以及發生了什麼事。"
L["VERSION"] = "版本"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"版本 %s。設定（包含關閉這則訊息的選項）可在 選項 > 插件 > Control Freak 中找到。喜歡這個插件嗎？告訴朋友吧！(="
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

--[[
    The add-on's own switch, above every feature's. The title names its REACH
    rather than the act of throwing it, which is what a player cannot read off
    the box beside it -- every other toggle on this panel governs one thing.

    Its ENABLE description is shared with the mini-map button's line for the same
    toggle, so the two cannot describe it differently.
]]
L["KILL_SWITCH"] = "所有提示"
L["KILL_SWITCH_SUMMARY"] =
	"一個開關管住所有標籤頁裡的全部提示：關掉它，插件就安靜下來，而所有設定都原樣保留；左鍵點擊小地圖按鈕也能隨時做同樣的事。"
L["KILL_SWITCH_ENABLE"] = "啟用 Control Freak"
L["KILL_SWITCH_ENABLE_DESC"] = "開啟或關閉 Control Freak 的所有提示。"

L["FEEDBACK_HEADER"] = "回饋與支援"
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
L["STATE_ON"] = "已啟用"
L["STATE_OFF"] = "已停用"
L["LEFT_CLICK"] = "左鍵點擊"
L["RIGHT_CLICK"] = "右鍵點擊"
L["SHIFT_MIDDLE_CLICK"] = "Shift + 中鍵點擊"
L["ACTION_TOGGLE"] = "切換"
L["MINIMAP_OPTIONS"] = "Control Freak 選項"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

-- In tab order.
L["TAB_TAUNTS"] = "嘲諷"
L["TAB_INTERRUPTS"] = "打斷"
L["TAB_FEARS"] = "恐懼"
L["TAB_INCAPACITATED"] = "失去控制"
L["TAB_TANK_DEATHS"] = "坦克死亡"
L["TAB_BAD_PRIESTS"] = "搗蛋牧師"
L["TAB_BAD_PETS"] = "搗蛋寵物"
L["TAB_TANKING_TOOLS"] = "坦克工具"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "開啟或關閉這項功能。"
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
L["SCOPE_ROLE_TANK"] = "擔任坦克時"
L["SCOPE_ROLE_HEALER"] = "擔任治療者時"
L["SCOPE_ROLE_TANK_HEALER"] = "擔任坦克或治療者時"
L["SCOPE_ROLE_ALWAYS"] = "一律"
L["SCOPE_ROLE_DESC"] =
	'這項功能要開口，你必須擔任的職責。當你是團隊的主坦克，或在隊伍搜尋器中選擇了坦克職責時，算作坦克；只有在選擇了治療者職責時才算作治療者，因為治療沒有團隊指派。選擇"一律"就不問職責，無論你玩什麼都會提示。'
L["SCOPE_GROUP_HAS_TANK"] = "隊伍中有坦克時"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"只在你隊伍中有人正在坦怪而且還活著時觸發。倒下的坦克算作沒有坦克，因為那正是別人扛住仇恨能幫上忙的時候。"
L["SCOPE_INSTANCE_ONLY"] = "在副本中時"
L["SCOPE_INSTANCE_ONLY_DESC"] = "只在地城和團隊副本中觸發。"

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
L["ALERT_SECTION_ENABLE_DESC"] = "開啟或關閉這則提示。"
L["ALERT_SOUND"] = "播放音效"
L["ALERT_SOUND_DESC"] = "這則提示觸發時播放音效。"
L["ALERT_SOUND_FILE_DESC"] = "選擇這則提示播放的音效。選取後會立刻播放一次。"
L["ALERT_SOUND_PREVIEW_DESC"] = "立刻播放這個音效，無論音效是否已開啟。"
L["SOUND_NONE"] = "無"

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
	"回報你自己的施放，包括你寵物的。旁邊的下拉選單決定這行訊息送到哪裡。"
L["ALERT_OTHERS_DESC"] =
	"回報你隊伍中其他所有人的施放。旁邊的下拉選單決定這行訊息送到哪裡。"
L["ALERT_OUTPUT_PRINT"] = "顯示（僅限自己）"
L["ALERT_OUTPUT_ANNOUNCE"] = "通報"
L["ALERT_OUTPUT_DESC"] =
	'這行訊息送到哪裡：只送一處，絕不會兩處都送。"顯示（僅限自己）"只出現在你自己的視窗，不打擾任何人。"通報"則改送到隊伍或團隊頻道；向整個團隊實況轉播別人的一舉一動，正是插件開始惹人厭的原因，所以選這一項前值得三思。你不在隊伍中時，以及在戰場和競技場內，"通報"都不會發出任何訊息。'
L["ALERT_AGAINST_DESC"] =
	'決定哪些敵人算數，每個選項都包含排在它後面的選項。首領是等級顯示為骷髏（??）的敵人。地城首領本身沒有骷髏標示，所以算作精英："同級以上精英與首領"這個選項會保留它，同時略過它周圍等級較低的小怪。勾選下方那一列時，團隊標記會凌駕以上所有設定。'
L["TARGET_RUNG_ALL"] = "全部"
L["TARGET_RUNG_ELITE"] = "精英與首領"
L["TARGET_RUNG_ELITE_0"] = "同級以上精英與首領"
L["TARGET_RUNG_BOSS"] = "首領"
L["ALERT_MARKED_ALWAYS"] = "一律提示已標記的目標"
L["ALERT_MARKED_ALWAYS_DESC"] =
	"帶有團隊標記的目標一律算數，不論開關旁的下拉選單怎麼設定：頭顱、十字，八種標記中的任何一種都算。標記是隊伍指出哪一波怪最要緊的方式，所以有人標記過的目標，絕不會因為階級或等級不符而被略過。"

--[[
    The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
    list of seconds. Whole minutes read as minutes, and zero reads as "No
    Cooldown" rather than "0 Second Cooldown".

    TRANSLATORS: one format serves every count it is given, one minute and five
    alike, so word each to read for any number. An abbreviated unit does.
]]
L["COOLDOWN_NONE"] = "無冷卻"
L["COOLDOWN_SECONDS"] = "冷卻 %d 秒"
L["COOLDOWN_MINUTES"] = "冷卻 %d 分鐘"

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
L["SAMPLE_EXAMPLE"] = "範例：%s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "小明"
L["SAMPLE_PET"] = "來福"

--[[
    The Naxxramas bosses the Example lines name, dealt one per line.

    TRANSLATORS: use each boss's name exactly as your client writes it, title
    included, not a translation of the English.
]]
L["SAMPLE_BOSS_ANUBREKHAN"] = "阿努比瑞克漢"
L["SAMPLE_BOSS_FAERLINA"] = "大寡婦費琳娜"
L["SAMPLE_BOSS_MAEXXNA"] = "梅克絲娜"
L["SAMPLE_BOSS_NOTH"] = "瘟疫者諾斯"
L["SAMPLE_BOSS_HEIGAN"] = "骯髒者海根"
L["SAMPLE_BOSS_LOATHEB"] = "洛斯伯"
L["SAMPLE_BOSS_RAZUVIOUS"] = "講師拉祖維斯"
L["SAMPLE_BOSS_GOTHIK"] = "收割者高希"
L["SAMPLE_BOSS_MOGRAINE"] = "莫格萊尼公爵"
L["SAMPLE_BOSS_KORTHAZZ"] = "寇斯艾茲族長"
L["SAMPLE_BOSS_BLAUMEUX"] = "布洛莫斯爵士"
L["SAMPLE_BOSS_ZELIEK"] = "札里克爵士"
L["SAMPLE_BOSS_PATCHWERK"] = "縫補者"
L["SAMPLE_BOSS_GROBBULUS"] = "葛羅巴斯"
L["SAMPLE_BOSS_GLUTH"] = "古魯斯"
L["SAMPLE_BOSS_THADDIUS"] = "泰迪斯"
L["SAMPLE_BOSS_SAPPHIRON"] = "薩菲隆"
L["SAMPLE_BOSS_KELTHUZAD"] = "科爾蘇加德"

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
L["TAUNTS_SUCCESS_DESC"] =
	"生效並把怪物從別人身上搶過來的嘲諷。對一隻已經在打嘲諷者的怪物使用嘲諷，只是刷新仇恨而不是救場，所以不會提示。"
L["TAUNTS_SUCCESS_ENABLE"] = "啟用成功嘲諷提示，針對"
L["TAUNTS_SUCCESS_MINE"] = "我的成功嘲諷"
L["TAUNTS_SUCCESS_OTHERS"] = "他人的成功嘲諷"

L["TAUNTS_FAILED_HEADER"] = "失敗的嘲諷"
L["TAUNTS_FAILED_DESC"] =
	"未命中、被抵抗，或打在免疫目標上的嘲諷。怪物沒有易主，而畫面上也不會有任何提示。"
L["TAUNTS_FAILED_ENABLE"] = "啟用失敗嘲諷提示，針對"
L["TAUNTS_FAILED_MINE"] = "我的失敗嘲諷"
L["TAUNTS_FAILED_OTHERS"] = "他人的失敗嘲諷"

L["TAUNTS_AOE_HEADER"] = "群體嘲諷"
L["TAUNTS_AOE_DESC"] = "一次抓住周圍所有目標的嘲諷，而不是只針對一個目標。"
L["TAUNTS_AOE_ENABLE"] = "啟用群體嘲諷提示"
L["TAUNTS_AOE_MINE"] = "我的群體嘲諷"
L["TAUNTS_AOE_OTHERS"] = "他人的群體嘲諷"

L["TAUNTS_ABILITIES_HEADER"] = "嘲諷技能"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "群體嘲諷技能"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "打斷能讓敵人的法術在施放到一半時停下來。"
L["INTERRUPTS_ENABLE"] = "啟用打斷監看"

L["INTERRUPTS_ALERT_HEADER"] = "成功的打斷"
L["INTERRUPTS_ALERT_DESC"] = "施法到一半被中止。會說出是誰打斷的，以及打斷了什麼。"
L["INTERRUPTS_ALERT_ENABLE"] = "啟用成功打斷提示，針對"
L["INTERRUPTS_ALERT_MINE"] = "我的成功打斷"
L["INTERRUPTS_ALERT_OTHERS"] = "他人的成功打斷"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "恐懼會讓敵人四散奔逃，把一整波怪撒得滿屋子都是。"
L["FEARS_ENABLE"] = "啟用恐懼監看"

L["FEARS_ALERT_HEADER"] = "成功的恐懼"
L["FEARS_ALERT_DESC"] =
	"生效並把怪物撒到坦克搆不著之處的恐懼。只有生效才算：單純的施法、被抵抗和免疫都沒讓任何怪物移動，所以都不會回報。"
L["FEARS_ALERT_ENABLE"] = "啟用成功恐懼提示"
L["FEARS_ALERT_MINE"] = "我的成功恐懼"
L["FEARS_ALERT_OTHERS"] = "他人的成功恐懼"

L["FEARS_ABILITIES_HEADER"] = "恐懼技能"

--------------------------------------------------------------------------------
-- Incapacitated
--------------------------------------------------------------------------------

L["INCAPACITATED_SUMMARY"] =
	"在你失去角色控制的那一刻告訴隊伍，好讓別人替你補位。被恐懼的坦克和被沉默的治療者，是最需要開口的兩個人，偏偏也是當下最無法開口的兩個人。"
L["INCAPACITATED_ENABLE"] = "啟用失控監看"

L["INCAPACITATED_HEADER"] = "自身失控"
L["INCAPACITATED_DESC"] =
	"當你中了昏迷、恐懼、沉默或其他讓你無法作戰的效果時告訴隊伍：中了什麼、誰施放的、持續多久，以及有沒有人能解除。"
--[[
    No trailing preposition and nothing beside it: this alert has no target
    ladder, and its "Long" threshold is a row of its own, above the two rows it
    names.
]]
L["INCAPACITATED_ALERT_ENABLE"] = "啟用失控提示"
--[[
    The only pair of rows in the add-on that is not My and Others'. The game
    reports the player's own losses of control and nobody else's, so "whose"
    has one answer; how LONG it lasts is the question with two.

    TRANSLATORS: keep the quotes around Long in the caption. They mark it as the
    word the two rows below are named after rather than as an adjective.
]]
L["INCAPACITATED_LONG_CAPTION"] = '"長時間"失控門檻'
L["INCAPACITATED_LONG_CAPTION_DESC"] =
	"失去控制要持續多久才算長時間，低於這個門檻的就算短時間。兩者都不會被丟掉：下面兩列分別決定它們送到哪裡，而且預設送往不同的地方。"
-- The caption's dropdown: the first reads for 1 only, the second for 2 to 10.
L["INCAPACITATED_THRESHOLD_ONE"] = "%d 秒"
L["INCAPACITATED_THRESHOLD"] = "%d 秒"
L["INCAPACITATED_SHORT"] = "我的短時間失控"
L["INCAPACITATED_SHORT_DESC"] =
	"你失去控制的時間短於上面設定的長度時，這行訊息送到哪裡。預設只顯示在你自己的視窗：一個在別人來得及替你補位之前就結束的昏迷，只是解釋了你為什麼剛剛損失一個公共冷卻，不關別人的事。"
L["INCAPACITATED_LONG"] = "我的長時間失控"
L["INCAPACITATED_LONG_DESC"] =
	"你失去控制的時間達到上面設定的長度時，這行訊息送到哪裡。預設為通報：這種情況別人才有時間應對，而你是唯一沒辦法開口的人。完全沒有持續時間的效果，例如精神控制，算作長時間。"

L["INCAPACITATED_STUN"] = "包含昏迷"
L["INCAPACITATED_STUN_DESC"] = "完全失去控制，站在原地不動。沉睡也算作昏迷。"
L["INCAPACITATED_FEAR"] = "包含恐懼"
L["INCAPACITATED_FEAR_DESC"] = "完全失去控制，朝隨機方向亂跑。怪物也會跟著你跑。"
L["INCAPACITATED_CHARM"] = "包含精神控制"
L["INCAPACITATED_CHARM_DESC"] =
	"完全落入別人的控制。通常是這份清單上最糟的情況，而且通常沒有時限。"
L["INCAPACITATED_CONFUSE"] = "包含困惑"
L["INCAPACITATED_CONFUSE_DESC"] = "完全失去控制，朝隨機方向亂走。"
L["INCAPACITATED_SILENCE"] = "包含沉默"
L["INCAPACITATED_SILENCE_DESC"] =
	"無法施放法術。德魯伊或聖騎士的嘲諷是法術，所以這代表嘲諷不會來了。"
L["INCAPACITATED_PACIFY"] = "包含平靜"
L["INCAPACITATED_PACIFY_DESC"] = "無法攻擊，但仍然可以施放法術。"
L["INCAPACITATED_SCHOOL_INTERRUPT"] = "包含法術封鎖"
L["INCAPACITATED_SCHOOL_INTERRUPT_DESC"] =
	"無法施放某一系的法術。如果你用法術嘲諷，這一項就值得開啟，因為被封鎖自然系或神聖系法術的德魯伊或聖騎士，就沒有嘲諷可用。"
L["INCAPACITATED_ROOT"] = "包含定身"
L["INCAPACITATED_ROOT_DESC"] = "無法移動。被定身的坦克仍然按得到嘲諷，所以怪物跑不掉。"
L["INCAPACITATED_DISARM"] = "包含繳械"
L["INCAPACITATED_DISARM_DESC"] = "無法用武器攻擊。和定身一樣，嘲諷按鈕仍然有效。"

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
	"隊伍裡的坦克死了。這是唯一會改變其他人下一步該做什麼的死亡，而四十個團隊頭像是最難注意到它的地方。"
L["TANK_DEATHS_ENABLE"] = "啟用坦克死亡監看"

L["TANK_DEATHS_ALERT_HEADER"] = "坦克死亡"
L["TANK_DEATHS_ALERT_DESC"] =
	"計入團隊的主坦克，以及在隊伍搜尋器中選擇了坦克職責的人，也包括你自己。遊戲只用這兩種方式表明誰在當坦克，所以兩者都沒有的坦克死亡時不會回報。"
L["TANK_DEATHS_ALERT_ENABLE"] = "啟用坦克死亡提示"
L["TANK_DEATHS_ALERT_MINE"] = "我的死亡"
L["TANK_DEATHS_ALERT_MINE_DESC"] =
	"回報你在當坦克時自己的死亡。旁邊的下拉選單決定這行訊息送到哪裡。"
L["TANK_DEATHS_ALERT_OTHERS"] = "他人的坦克死亡"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] =
	"回報你隊伍中其他正在當坦克的人的死亡。旁邊的下拉選單決定這行訊息送到哪裡。"

L["TANK_DEATHS_CLASS_HEADER"] = "依職業的死亡"
L["TANK_DEATHS_CLASS_DESC"] = "其餘所有死亡，依職業列出，挑你想盯的。"
L["TANK_DEATHS_CLASS_ROW_DESC"] = "隊伍中的%s死亡時提示。"

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] =
	"治療者做了對坦克弊大於利的事。僅適用於經典版與燃燒的遠征：探索賽季透過牧師符文把怒氣補了回來，而更後期的遊戲版本則完全不存在這些問題。"
L["BAD_PRIESTS_ENABLE"] = "啟用搗蛋牧師監看"

L["BAD_PRIESTS_HEADER"] = "幫倒忙的護盾"
L["BAD_PRIESTS_DESC"] =
	"提示落在正在坦怪的德魯伊或戰士身上的真言術：盾。怒氣來自承受的傷害，而護盾吸收的傷害不會產生怒氣，所以一個好心的盾，反而讓坦克缺少用來穩住仇恨的怒氣。"
L["BAD_PRIESTS_ALERT_ENABLE"] = "啟用幫倒忙護盾提示"
L["BAD_PRIESTS_HEALTH_DESC"] =
	'坦克的生命值要掉到多低，上盾才不算失誤。對快死的人上盾是正確的判斷，所以生命值低於你在這裡選的數值時，警告會保持安靜。選擇"總是"就會聽到每一個盾的提示。'
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "總是"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "生命值低於 %d%% 時除外"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "幫倒忙護盾警告"
L["BAD_PRIESTS_REPORT_DESC"] =
	'有人對怒氣坦克上盾時，警告送到哪裡。這裡沒有"我的"和"他人的"兩列之分：施法的是治療者，吃虧的是坦克。'
L["BAD_PRIESTS_SELF_ONLY"] = "擔任德魯伊或戰士坦克時"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"只在盾落在你身上，而且你是正在坦怪的德魯伊或戰士時才警告。關閉這一項，隊伍中任何以這兩種職業坦怪的人被上盾時，你都會收到提示。"
L["BAD_PRIESTS_WHISPER"] = "密語施法者"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"給上盾的人發一則密語，說明為什麼這樣反而有害。就算你隊伍裡有好幾個人在用 Control Freak，也只會發出一則。"
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"同一個施法者觸發護盾警告後，針對他保持安靜的時間。這段時間涵蓋顯示、音效、通報和密語，因為一個冷卻一好就上盾的治療者，不該洗版你的視窗。"

--------------------------------------------------------------------------------
-- Bad Pets
--------------------------------------------------------------------------------

-- Doubles as the mini-map button's Bad Pets line, so the two cannot differ.
L["BAD_PETS_SUMMARY"] = "把仇恨技能留在自動施放狀態的獵人和術士寵物。"
L["BAD_PETS_ENABLE"] = "啟用搗蛋寵物監看"

L["BAD_PETS_ALERT_HEADER"] = "寵物嘲諷"
L["BAD_PETS_ALERT_DESC"] =
	"開著自動施放、把怪物從坦克身上拉走的寵物，通常主人自己毫無察覺。"
L["BAD_PETS_ALERT_ENABLE"] = "啟用寵物嘲諷提示，針對"
L["BAD_PETS_ALERT_MINE"] = "我的寵物嘲諷"
L["BAD_PETS_ALERT_OTHERS"] = "他人的寵物嘲諷"
L["BAD_PETS_WHISPER_ENABLE"] = "密語寵物主人"
L["BAD_PETS_WHISPER_ENABLE_DESC"] =
	"給寵物主人發一則密語，說明怎麼關閉自動施放。就算你隊伍裡有好幾個人在用 Control Freak，也只會發出一則。"
L["BAD_PETS_COOLDOWN_DESC"] =
	"同一隻寵物觸發提示後，針對牠保持安靜的時間。這段時間涵蓋顯示、音效、通報和密語，所以開著自動施放的寵物不會洗版你的視窗，牠的主人也不會每隔幾秒就被密語一次。"

L["BAD_PETS_ABILITIES_HEADER"] = "搗蛋寵物技能"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

--[[
    No summary line: the Tanking Tools tab opens on its enable, because the tab is
    a collection of unrelated warnings rather than one idea a sentence can cover.
    Each section introduces itself instead.
]]
L["TANKING_TOOLS_ENABLE"] = "啟用坦克工具"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "開場落空"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"提示你自己沒能命中的開場攻擊：開怪最初幾秒內的未命中、閃躲、招架、格擋、抵抗或免疫。這些是從未產生的仇恨，偏偏發生在最要緊的時刻。"
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "啟用開場落空提示，針對"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "我的開場落空"
-- The caption before the window dropdown: "Within [10 Seconds of Fight]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "限定在"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "開戰後 %d 秒內"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"開怪後多久之內，被避開的技能仍然算數。計時從 Control Freak 第一次看到那隻怪物時開始，而且只有技能算數：自動攻擊落空得太頻繁，算不上什麼新聞。"

L["TANKING_TOOLS_ARMOR_HEADER"] = "護甲削弱"
L["TANKING_TOOLS_ARMOR_DESC"] =
	'回報隊伍花了多久削掉目標的護甲：五層破甲攻擊，或盜賊的破甲。在下方勾選某個"包含"項目，它也會等待那個削弱效果，但只在隊伍中真的有人能施放時才會等。'
L["TANKING_TOOLS_ARMOR_ENABLE"] = "啟用護甲削弱提示，針對"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "護甲削弱報告"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	'隊伍削完目標護甲後，報告送到哪裡。這裡沒有"我的"和"他人的"兩列之分：這是全隊的成果，報告給你知道。'
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "包含精靈之火"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"回報前等待精靈之火，無論德魯伊施放的是哪一個版本。隊伍中沒有德魯伊時忽略這一項。"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "包含魯莽詛咒"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] = "回報前等待魯莽詛咒。隊伍中沒有術士時忽略這一項。"

L["TANKING_TOOLS_PARRY_HEADER"] = "招架"
L["TANKING_TOOLS_PARRY_DESC"] =
	"有人被自己沒在坦的怪物招架，就代表他正站在怪物面前。每一次招架都會加快那隻怪物對仇恨持有者的下一次揮擊。"
L["TANKING_TOOLS_PARRY_ENABLE"] = "啟用招架提示，針對"
L["TANKING_TOOLS_PARRY_MINE"] = "我被招架"
L["TANKING_TOOLS_PARRY_OTHERS"] = "他人被招架"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS"] = "忽略其他坦克"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS_DESC"] =
	"被招架的玩家是坦克時保持安靜：團隊的主坦克，或選了坦克職責的人。副坦站在首領面前是為了換坦嘲諷，這不是需要密語提醒的錯誤。你自己被招架仍會回報。"
L["TANKING_TOOLS_PARRY_WHISPER"] = "密語肇事者"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"給肇事者發一則密語，請他移到怪物背後。就算你隊伍裡有好幾個人在用 Control Freak，也只會發出一則。"
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"同一個肇事者觸發招架警告後，針對他保持安靜的時間。這段時間涵蓋顯示、音效、通報和密語，因為還沒移動的人，不需要怪物每揮一次就被提醒一次。"

L["TANKING_TOOLS_NOVA_HEADER"] = "新星"
L["TANKING_TOOLS_NOVA_DESC"] = "提示冰霜新星，它會讓一波怪散落在坦克搆不著的地方。"
L["TANKING_TOOLS_NOVA_ENABLE"] = "啟用新星提示"
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
L["UNKNOWN_TARGET"] = "未知目標"
L["UNKNOWN_SPELL"] = "未知法術"

L["TAUNT_SUCCESS"] = "嘲諷！%s 使用 %s，目標 %s。"
L["TAUNT_AOE"] = "群體嘲諷！%s 使用 %s。"
L["TAUNT_MISSED"] = "嘲諷失敗！%s 的 %s 未命中 %s。"
L["TAUNT_RESISTED"] = "嘲諷失敗！%s 的 %s 被 %s 抵抗了。"
--[[
    The one failure format that leads with the MOB rather than the taunter,
    because the immunity is the news and the other three formats have no news
    beyond "it did not land".

    TRANSLATORS: %s is, in order: mob, taunter, taunt. This is the ONLY taunt
    format whose first %s is not the player who cast it.
]]
L["TAUNT_IMMUNE"] = "嘲諷失敗！%s 免疫：%s 使用了 %s。"
L["TAUNT_FAILED"] = "嘲諷失敗！%s 的 %s 對 %s 沒有生效。"
L["INTERRUPT"] = "打斷！%s 用 %s 打斷了 %s 的 %s。"

L["FEAR_SUCCESS"] = "恐懼！%s 使用 %s，目標 %s。"
L["FEAR_AOE"] = "群體恐懼！%s 使用 %s。"

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
L["INCAPACITATED"] = "%s失控 %s！%s 中了 %s（%s），來自 %s。"
L["INCAPACITATED_PLAIN"] = "%s失控 %s！%s 中了 %s，來自 %s。"
L["INCAPACITATED_INDEFINITE"] = "%s失控！%s 中了 %s（%s），來自 %s。"
L["INCAPACITATED_PLAIN_INDEFINITE"] = "%s失控！%s 中了 %s，來自 %s。"

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
L["INCAPACITATED_ROLE_HEALER"] = "治療"

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
L["DISPEL_CURSE"] = "詛咒"
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
L["SHIELD_WARNING"] = "幫倒忙的盾！%s 把 %s 施放在 %s 身上。"
L["SHIELD_WHISPER"] =
	"幫倒忙的盾！請避免把 %s 施放在 %s 身上。這個技能會讓坦克拿不到怒氣。"

L["BAD_PET"] = "搗蛋寵物！%s 的寵物 %s 使用 %s，目標 %s。"
L["BAD_PET_AOE"] = "搗蛋寵物！%s 的寵物 %s 使用 %s。"
L["BAD_PET_OWN"] = "搗蛋寵物！你的寵物 %s 使用 %s，目標 %s。"
L["BAD_PET_OWN_AOE"] = "搗蛋寵物！你的寵物 %s 使用 %s。"
L["BAD_PET_UNKNOWN_OWNER"] = "搗蛋寵物！%s 使用 %s，目標 %s。"
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "搗蛋寵物！%s 使用 %s。"
--[[
    Kept short on purpose. It renders with a spell link and two names inside a 255
    byte chat limit, and the widest locale runs close to twice the English.
]]
L["BAD_PET_WHISPER"] = "你的寵物 %s 使用了 %s，目標 %s。右鍵點擊該技能即可關閉自動施放。"

L["COLD_OPENER_MISS"] = "小心！%s 的 %s 未命中 %s。"
L["COLD_OPENER_DODGE"] = "小心！%s 的 %s 被 %s 閃躲。"
L["COLD_OPENER_PARRY"] = "小心！%s 的 %s 被 %s 招架。"
L["COLD_OPENER_BLOCK"] = "小心！%s 的 %s 被 %s 格擋。"
L["COLD_OPENER_IMMUNE"] = "小心！%s 的 %s 被 %s 免疫。"
L["COLD_OPENER_RESIST"] = "小心！%s 的 %s 被 %s 抵抗。"

L["ARMOR_REPORT"] = "護甲已削弱！%s 在 %s 秒後變得脆弱。"

L["PARRY_WARNING"] = "招架加速！%s 正站在 %s 面前。"
L["PARRY_WHISPER"] = "招架加速！請站到 %s 的背後：每次招架都會加快它的下一次攻擊。"

L["NOVA"] = "新星！%s 使用 %s，目標 %s。"
L["NOVA_AOE"] = "群體新星！%s 使用 %s。"
