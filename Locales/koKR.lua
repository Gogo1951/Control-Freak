local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "koKR")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"도발, 차단, 공포, 탱커 사망, 말썽쟁이 소환수, 무기 막기, 방어도 감소 등 전투의 중요한 순간을 알려 주는 전투 알림 애드온입니다. 원하는 대로 설정할 수 있는 알림으로 누가 도발했는지, 무엇이 실패했는지, 누가 시전을 차단했는지, 무슨 일이 일어났는지 확인하세요."
L["VERSION"] = "버전"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"버전 %s. 설정(이 메시지를 끄는 옵션 포함)은 설정 > 애드온 > Control Freak에서 찾을 수 있습니다. 애드온이 마음에 드시나요? 친구에게도 알려 주세요! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "안전을 위해 전투 중에는 설정 창을 열 수 없습니다."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "환영 메시지 사용"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "접속할 때 Control Freak 인사말을 표시합니다."
L["ENABLE_MINIMAP_BUTTON"] = "미니맵 버튼 사용"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "미니맵에 Control Freak 버튼을 표시합니다."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "이 애드온의 설정 창을 엽니다."

--[[
    The add-on's own switch, above every feature's. The title names its REACH
    rather than the act of throwing it, which is what a player cannot read off
    the box beside it -- every other toggle on this panel governs one thing.

    Its ENABLE description is shared with the mini-map button's line for the same
    toggle, so the two cannot describe it differently.
]]
L["KILL_SWITCH"] = "모든 알림"
L["KILL_SWITCH_SUMMARY"] =
	"모든 탭의 모든 알림을 한 번에 켜고 끄는 스위치입니다. 끄더라도 설정은 그대로 남고, 미니맵 버튼을 좌클릭해도 어디서든 같은 일을 할 수 있습니다."
L["KILL_SWITCH_ENABLE"] = "Control Freak 사용"
L["KILL_SWITCH_ENABLE_DESC"] = "Control Freak의 모든 알림을 켜거나 끕니다."

L["FEEDBACK_HEADER"] = "의견 및 지원"
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
L["STATE_ON"] = "활성화됨"
L["STATE_OFF"] = "비활성화됨"
L["LEFT_CLICK"] = "좌클릭"
L["RIGHT_CLICK"] = "우클릭"
L["SHIFT_MIDDLE_CLICK"] = "Shift + 가운데 클릭"
L["ACTION_TOGGLE"] = "전환"
L["MINIMAP_OPTIONS"] = "Control Freak 설정"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

-- In tab order.
L["TAB_TAUNTS"] = "도발"
L["TAB_INTERRUPTS"] = "차단"
L["TAB_FEARS"] = "공포"
L["TAB_INCAPACITATED"] = "행동 불가"
L["TAB_TANK_DEATHS"] = "탱커 사망"
L["TAB_BAD_PRIESTS"] = "말썽쟁이 사제"
L["TAB_BAD_PETS"] = "말썽쟁이 소환수"
L["TAB_TANKING_TOOLS"] = "탱킹 도구"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "이 기능을 켜거나 끕니다."
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
L["SCOPE_ROLE_TANK"] = "탱커일 때"
L["SCOPE_ROLE_HEALER"] = "힐러일 때"
L["SCOPE_ROLE_TANK_HEALER"] = "탱커 또는 힐러일 때"
L["SCOPE_ROLE_ALWAYS"] = "항상"
L["SCOPE_ROLE_DESC"] =
	"이 기능이 무언가를 알리려면 맡고 있어야 하는 역할입니다. 공격대에서는 메인 탱커로 지정되었을 때, 파티에서는 파티 찾기에서 방어 전담 역할을 선택했을 때 탱커로 인정됩니다. 공격대에서는 방어 전담 역할이 아무 의미도 없습니다. 파티 찾기에서 치유 전담 역할을 선택했을 때만 힐러로 인정됩니다. 치유에는 공격대 지정이 없기 때문입니다. '항상'을 고르면 이 조건을 따지지 않고 어떤 역할이든 작동합니다."
L["SCOPE_GROUP_HAS_TANK"] = "파티에 탱커가 있을 때"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"파티에서 누군가 탱킹 중이고 아직 살아 있을 때만 작동합니다. 공격대에서는 지정된 메인 탱커만 해당하므로, 메인 탱커가 지정되지 않은 공격대는 Control Freak에게 탱커가 없는 것과 같습니다. 쓰러진 탱커는 탱커가 없는 것으로 칩니다. 바로 그때가 다른 누군가가 위협 수준을 붙잡아 주는 것이 도움이 되는 순간이기 때문입니다."
L["SCOPE_INSTANCE_ONLY"] = "인스턴스 안에 있을 때"
L["SCOPE_INSTANCE_ONLY_DESC"] = "던전과 공격대 안에서만 작동합니다."

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
L["ALERT_SECTION_ENABLE_DESC"] = "이 알림을 켜거나 끕니다."
L["ALERT_SOUND"] = "소리 재생"
L["ALERT_SOUND_DESC"] = "이 알림이 발생할 때 소리를 재생합니다."
L["ALERT_SOUND_FILE_DESC"] = "이 알림이 재생할 소리를 고릅니다. 고르면 바로 재생됩니다."
L["ALERT_SOUND_PREVIEW_DESC"] = "소리 재생을 켰는지와 상관없이 지금 이 소리를 재생합니다."
L["SOUND_NONE"] = "없음"

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
	"내가 시전한 것을 알립니다. 내 소환수의 시전도 포함됩니다. 옆의 드롭다운에서 이 줄을 보낼 곳을 정합니다."
L["ALERT_OTHERS_DESC"] =
	"파티에 있는 다른 모든 사람의 시전을 알립니다. 옆의 드롭다운에서 이 줄을 보낼 곳을 정합니다."
L["ALERT_OUTPUT_PRINT"] = "출력(나에게만)"
L["ALERT_OUTPUT_ANNOUNCE"] = "알리기"
L["ALERT_OUTPUT_DESC"] =
	"이 줄을 보낼 곳입니다. 한 곳으로만 가며, 양쪽 모두로 가지는 않습니다. 출력(나에게만)은 내 대화창에만 표시되므로 아무에게도 부담을 주지 않습니다. 알리기는 대신 파티나 공격대 대화로 보내는데, 다른 사람의 행동을 공격대 전체에 중계하는 것은 애드온이 눈총을 받는 지름길이므로 한 번 생각해 볼 만합니다. 알리기는 파티나 공격대에 있지 않을 때, 그리고 전장과 투기장 안에서는 아무것도 보내지 않습니다."
L["ALERT_AGAINST_DESC"] =
	"어떤 적을 셀지 정합니다. 각 선택지는 목록에서 그 아래에 있는 선택지를 모두 포함합니다. 우두머리는 해골 레벨(??)인 적입니다. 던전 우두머리에게는 해골 표시가 없어서 정예로 칩니다. '내 레벨+ 정예와 우두머리'를 고르면 던전 우두머리는 남기고 주변의 낮은 레벨 일반몹은 걸러 냅니다. '징표 대상은 항상 포함'이 선택되어 있으면 공격대 징표가 이 모든 설정보다 우선합니다."
L["TARGET_RUNG_ALL"] = "모든 적"
L["TARGET_RUNG_ELITE"] = "정예와 우두머리"
L["TARGET_RUNG_ELITE_0"] = "내 레벨+ 정예와 우두머리"
L["TARGET_RUNG_BOSS"] = "우두머리"
L["ALERT_MARKED_ALWAYS"] = "징표 대상은 항상 포함"
L["ALERT_MARKED_ALWAYS_DESC"] =
	"공격대 징표가 붙은 대상은 위의 대상 드롭다운에서 무엇을 골랐든 포함됩니다. 해골, 가위표 등 여덟 가지 모두 해당합니다. 징표는 파티가 중요한 무리를 가리키는 방법이므로, 누군가 징표를 붙인 적은 등급이나 레벨이 맞지 않는다는 이유로 빠지지 않습니다."

--[[
    The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
    list of seconds. Whole minutes read as minutes, and zero reads as "No
    Cooldown" rather than "0 Second Cooldown".

    TRANSLATORS: one format serves every count it is given, one minute and five
    alike, so word each to read for any number. An abbreviated unit does.
]]
L["COOLDOWN_NONE"] = "대기시간 없음"
L["COOLDOWN_SECONDS"] = "%d초 대기시간"
L["COOLDOWN_MINUTES"] = "%d분 대기시간"

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
L["SAMPLE_EXAMPLE"] = "예시: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "철수"
L["SAMPLE_PET"] = "멍멍이"

--[[
    The Naxxramas bosses the Example lines name, dealt one per line.

    TRANSLATORS: use each boss's name exactly as your client writes it, title
    included, not a translation of the English.
]]
L["SAMPLE_BOSS_ANUBREKHAN"] = "아눕레칸"
L["SAMPLE_BOSS_FAERLINA"] = "귀부인 팰리나"
L["SAMPLE_BOSS_MAEXXNA"] = "맥스나"
L["SAMPLE_BOSS_NOTH"] = "역병술사 노스"
L["SAMPLE_BOSS_HEIGAN"] = "부정의 헤이건"
L["SAMPLE_BOSS_LOATHEB"] = "로데브"
L["SAMPLE_BOSS_RAZUVIOUS"] = "훈련교관 라주비어스"
L["SAMPLE_BOSS_GOTHIK"] = "영혼의 착취자 고딕"
L["SAMPLE_BOSS_MOGRAINE"] = "대영주 모그레인"
L["SAMPLE_BOSS_KORTHAZZ"] = "영주 코스아즈"
L["SAMPLE_BOSS_BLAUMEUX"] = "여군주 블라미우스"
L["SAMPLE_BOSS_ZELIEK"] = "젤리에크 경"
L["SAMPLE_BOSS_PATCHWERK"] = "패치워크"
L["SAMPLE_BOSS_GROBBULUS"] = "그라불루스"
L["SAMPLE_BOSS_GLUTH"] = "글루스"
L["SAMPLE_BOSS_THADDIUS"] = "타디우스"
L["SAMPLE_BOSS_SAPPHIRON"] = "사피론"
L["SAMPLE_BOSS_KELTHUZAD"] = "켈투자드"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "아이템"
L["ABILITIES_CLASS_PET"] = "%s 소환수"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] =
	"도발은 현재 위협 수준을 쥐고 있는 대상에게서 그것을 빼앗아 오는 기술입니다."
L["TAUNTS_ENABLE"] = "도발 감시 사용"

L["TAUNTS_SUCCESS_HEADER"] = "도발 성공"
L["TAUNTS_SUCCESS_DESC"] =
	"적중해서 다른 사람에게서 적을 빼앗아 온 도발입니다. 이미 도발한 사람을 때리고 있던 적에게 건 도발은 구원이 아니라 위협 수준 갱신이므로 조용히 넘어갑니다."
L["TAUNTS_SUCCESS_ENABLE"] = "도발 성공 알림 사용, 대상:"
L["TAUNTS_SUCCESS_MINE"] = "내 도발 성공"
L["TAUNTS_SUCCESS_OTHERS"] = "다른 사람의 도발 성공"

L["TAUNTS_FAILED_HEADER"] = "도발 실패"
L["TAUNTS_FAILED_DESC"] =
	"빗나갔거나, 저항당했거나, 면역인 대상에게 걸린 도발입니다. 적의 주인은 바뀌지 않았고, 화면에는 그 사실이 나타나지 않습니다."
L["TAUNTS_FAILED_ENABLE"] = "도발 실패 알림 사용, 대상:"
L["TAUNTS_FAILED_MINE"] = "내 도발 실패"
L["TAUNTS_FAILED_OTHERS"] = "다른 사람의 도발 실패"

L["TAUNTS_AOE_HEADER"] = "광역 도발"
L["TAUNTS_AOE_DESC"] = "대상 하나가 아니라 주위의 모든 적을 한 번에 끌어오는 도발입니다."
L["TAUNTS_AOE_ENABLE"] = "광역 도발 알림 사용"
L["TAUNTS_AOE_MINE"] = "내 광역 도발"
L["TAUNTS_AOE_OTHERS"] = "다른 사람의 광역 도발"

L["TAUNTS_ABILITIES_HEADER"] = "도발 기술"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "광역 도발 기술"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "차단은 적의 주문 시전을 도중에 끊습니다."
L["INTERRUPTS_ENABLE"] = "차단 감시 사용"

L["INTERRUPTS_ALERT_HEADER"] = "차단 성공"
L["INTERRUPTS_ALERT_DESC"] =
	"도중에 끊긴 시전입니다. 누가 끊었고 무엇을 끊었는지 알려 줍니다."
L["INTERRUPTS_ALERT_ENABLE"] = "차단 성공 알림 사용, 대상:"
L["INTERRUPTS_ALERT_MINE"] = "내 차단 성공"
L["INTERRUPTS_ALERT_OTHERS"] = "다른 사람의 차단 성공"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "공포는 적을 달아나게 만들어 끌어온 무리를 사방으로 흩어 놓습니다."
L["FEARS_ENABLE"] = "공포 감시 사용"

L["FEARS_ALERT_HEADER"] = "공포 성공"
L["FEARS_ALERT_DESC"] =
	"적중해서 무리를 탱커의 손이 닿지 않는 곳으로 흩어 놓은 공포입니다. 적중한 경우만 셉니다. 단순 시전, 저항, 면역은 아무것도 움직이지 못했으므로 어느 것도 알리지 않습니다."
L["FEARS_ALERT_ENABLE"] = "공포 성공 알림 사용"
L["FEARS_ALERT_MINE"] = "내 공포 성공"
L["FEARS_ALERT_OTHERS"] = "다른 사람의 공포 성공"

L["FEARS_ABILITIES_HEADER"] = "공포 기술"

--------------------------------------------------------------------------------
-- Incapacitated
--------------------------------------------------------------------------------

L["INCAPACITATED_SUMMARY"] =
	"캐릭터를 제어할 수 없게 된 순간 파티에 알려서, 다른 누군가가 대신 메워 줄 수 있게 합니다. 공포에 걸린 탱커와 침묵에 걸린 힐러는 이를 가장 알려야 하는 두 사람이면서, 그 순간 가장 알리기 어려운 두 사람입니다."
L["INCAPACITATED_ENABLE"] = "행동 불가 감시 사용"

L["INCAPACITATED_HEADER"] = "행동 불가 상태"
L["INCAPACITATED_DESC"] =
	"기절, 공포, 침묵 등으로 싸울 수 없게 되었을 때 파티에 알립니다. 무엇에 걸렸는지, 누가 걸었는지, 얼마나 지속되는지, 누군가 해제할 수 있는지를 전합니다."
--[[
    No trailing preposition and nothing beside it: this alert has no target
    ladder, and its "Long" threshold is a row of its own, above the two rows it
    names.
]]
L["INCAPACITATED_ALERT_ENABLE"] = "행동 불가 알림 사용"
--[[
    The only pair of rows in the add-on that is not My and Others'. The game
    reports the player's own losses of control and nobody else's, so "whose"
    has one answer; how LONG it lasts is the question with two.

    TRANSLATORS: keep the quotes around Long in the caption. They mark it as the
    word the two rows below are named after rather than as an adjective.
]]
L["INCAPACITATED_LONG_CAPTION"] = '"긴" 행동 불가 최소 시간'
L["INCAPACITATED_LONG_CAPTION_DESC"] =
	"행동 불가 상태가 얼마나 지속되어야 긴 것으로 칠지 정합니다. 그보다 짧으면 짧은 것입니다. 어느 쪽도 버려지지 않습니다. 아래 두 항목이 각각 어디로 갈지 정하며, 처음에는 서로 다른 곳으로 설정되어 있습니다."
-- The caption's dropdown: the first reads for 1 only, the second for 2 to 10.
L["INCAPACITATED_THRESHOLD_ONE"] = "%d초"
L["INCAPACITATED_THRESHOLD"] = "%d초"
L["INCAPACITATED_SHORT"] = "내 짧은 행동 불가"
L["INCAPACITATED_SHORT_DESC"] =
	"위에서 정한 시간보다 짧게 행동 불가 상태가 되었을 때 이 줄을 보낼 곳입니다. 기본값은 내 대화창에 출력하는 것입니다. 누가 대신 메워 주기도 전에 풀리는 기절은 방금 놓친 전역 재사용 대기시간의 이유를 알려 줄 뿐, 다른 사람의 문제가 아니기 때문입니다."
L["INCAPACITATED_LONG"] = "내 긴 행동 불가"
L["INCAPACITATED_LONG_DESC"] =
	"위에서 정한 시간 이상 행동 불가 상태가 되었을 때 이 줄을 보낼 곳입니다. 기본값은 알리기입니다. 이쪽은 다른 누군가가 대처할 시간이 있는 경우이고, 정작 나는 그 사실을 알릴 수 없기 때문입니다. 정신 지배처럼 지속시간이 아예 없는 효과는 긴 것으로 칩니다."

L["INCAPACITATED_STUN"] = "기절 포함"
L["INCAPACITATED_STUN_DESC"] =
	"완전히 제어를 잃고 그 자리에 멈춰 섭니다. 수면도 기절로 칩니다."
L["INCAPACITATED_FEAR"] = "공포 포함"
L["INCAPACITATED_FEAR_DESC"] =
	"완전히 제어를 잃고 아무 방향으로나 달아납니다. 적도 함께 따라옵니다."
L["INCAPACITATED_CHARM"] = "정신 지배 포함"
L["INCAPACITATED_CHARM_DESC"] =
	"완전히 다른 누군가의 조종을 받는 상태입니다. 대개 이 목록에서 가장 나쁜 효과이며, 대개 끝이 정해져 있지 않습니다."
L["INCAPACITATED_CONFUSE"] = "혼란 포함"
L["INCAPACITATED_CONFUSE_DESC"] = "완전히 제어를 잃고 아무 방향으로나 걸어 다닙니다."
L["INCAPACITATED_SILENCE"] = "침묵 포함"
L["INCAPACITATED_SILENCE_DESC"] =
	"주문을 시전할 수 없습니다. 드루이드나 성기사의 도발은 주문이므로, 오지 않을 도발이라는 뜻입니다."
L["INCAPACITATED_PACIFY"] = "평정 포함"
L["INCAPACITATED_PACIFY_DESC"] = "공격할 수 없지만 주문은 여전히 쓸 수 있습니다."
L["INCAPACITATED_SCHOOL_INTERRUPT"] = "주문 계열 차단 포함"
L["INCAPACITATED_SCHOOL_INTERRUPT_DESC"] =
	"한 계열의 주문을 시전할 수 없습니다. 주문으로 도발한다면 켜 둘 만합니다. 자연이나 신성 계열이 차단된 드루이드나 성기사는 도발할 수 없기 때문입니다."
L["INCAPACITATED_ROOT"] = "이동 불가 포함"
L["INCAPACITATED_ROOT_DESC"] =
	"움직일 수 없습니다. 이동 불가 상태인 탱커도 도발 버튼은 누를 수 있으므로 적은 어디로도 가지 않습니다."
L["INCAPACITATED_DISARM"] = "무장 해제 포함"
L["INCAPACITATED_DISARM_DESC"] =
	"무기로 공격할 수 없습니다. 이동 불가와 마찬가지로 도발 버튼은 여전히 쓸 수 있습니다."

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
	"파티의 탱커가 사망했습니다. 다른 사람들이 당장 무엇을 해야 하는지를 바꾸는 유일한 죽음이며, 마흔 개의 공격대 초상화는 그것을 알아차리기에 가장 나쁜 곳입니다."
L["TANK_DEATHS_ENABLE"] = "탱커 사망 감시 사용"

L["TANK_DEATHS_ALERT_HEADER"] = "탱커 사망"
L["TANK_DEATHS_ALERT_DESC"] =
	"공격대에서는 메인 탱커로 지정된 플레이어만 탱커로 셉니다. 나도 포함되며, 파티 찾기의 역할은 공격대에서 아무 의미도 없습니다. 파티에서는 파티 찾기에서 방어 전담 역할을 선택한 사람을 셉니다. 둘 다 없는 탱커는 죽어도 알리지 않습니다."
L["TANK_DEATHS_ALERT_ENABLE"] = "탱커 사망 알림 사용"
L["TANK_DEATHS_ALERT_MINE"] = "내 사망"
L["TANK_DEATHS_ALERT_MINE_DESC"] =
	"내가 탱킹 중일 때 나의 사망을 알립니다. 옆의 드롭다운에서 이 줄을 보낼 곳을 정합니다."
L["TANK_DEATHS_ALERT_OTHERS"] = "다른 탱커의 사망"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] =
	"파티에서 탱킹 중인 다른 사람이 사망하면 알립니다. 옆의 드롭다운에서 이 줄을 보낼 곳을 정합니다."

L["TANK_DEATHS_CLASS_HEADER"] = "직업별 사망"
L["TANK_DEATHS_CLASS_DESC"] = "그 외 모든 사망을 직업별로, 지켜보고 싶은 것만 고르세요."
L["TANK_DEATHS_CLASS_ROW_DESC"] = "파티의 %s 직업 플레이어가 사망하면 알립니다."

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] =
	"탱커에게 도움보다 해가 되는 일을 하는 힐러입니다. 클래식과 불타는 성전 전용입니다. 디스커버리 시즌에서는 사제 룬으로 분노를 돌려받고, 이후 게임 버전에서는 전혀 문제가 되지 않습니다."
L["BAD_PRIESTS_ENABLE"] = "말썽쟁이 사제 감시 사용"

L["BAD_PRIESTS_HEADER"] = "잘못된 보호막"
L["BAD_PRIESTS_DESC"] =
	"탱킹 중인 드루이드나 전사에게 신의 권능: 보호막이 걸리면 알려 줍니다. 분노는 받은 피해에서 생기는데 보호막이 흡수한 피해로는 분노가 생기지 않으므로, 좋은 뜻으로 건 보호막이 탱커가 위협 수준을 붙잡는 데 필요한 분노를 빼앗습니다."
L["BAD_PRIESTS_ALERT_ENABLE"] = "잘못된 보호막 알림 사용"
L["BAD_PRIESTS_HEALTH_DESC"] =
	"탱커의 생명력이 얼마나 떨어져야 보호막이 더 이상 실수가 아니게 되는지 정합니다. 곧 죽을 사람에게 거는 보호막은 옳은 판단이므로, 여기서 고른 수치보다 낮을 때는 경고하지 않습니다. '항상'을 고르면 모든 보호막을 알려 줍니다."
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "항상"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "생명력 %d%% 미만 제외"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "잘못된 보호막 경고"
L["BAD_PRIESTS_REPORT_DESC"] =
	"누군가 분노를 쓰는 탱커에게 보호막을 걸었을 때 경고를 보낼 곳입니다. 여기에는 나와 다른 사람을 나누는 항목이 없습니다. 시전은 힐러의 것이고, 문제는 탱커의 것이기 때문입니다."
L["BAD_PRIESTS_SELF_ONLY"] = "드루이드나 전사로 탱킹할 때"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"나에게 걸린 보호막만, 그리고 내가 드루이드나 전사로 탱킹 중일 때만 경고합니다. 이 항목을 끄면 파티에서 이 직업들로 탱킹 중인 누구에게 걸린 보호막이든 알려 줍니다."
L["BAD_PRIESTS_WHISPER"] = "시전자에게 귓속말"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"보호막을 건 사람에게 그것이 왜 해가 되는지 설명하는 귓속말을 보냅니다. 파티에서 여러 명이 Control Freak을 쓰고 있어도 귓속말은 하나만 전송됩니다."
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"한 시전자가 보호막 경고를 일으킨 뒤, 그 사람에 대해 다시 알리지 않는 시간입니다. 출력, 소리, 알리기, 귓속말 모두에 적용됩니다. 재사용 대기시간이 돌아올 때마다 보호막을 거는 힐러가 대화창을 가득 채워서는 안 되기 때문입니다."

--------------------------------------------------------------------------------
-- Bad Pets
--------------------------------------------------------------------------------

L["BAD_PETS_SUMMARY"] = "위협 기술의 자동 시전을 켜 둔 사냥꾼과 흑마법사의 소환수입니다."
L["BAD_PETS_ENABLE"] = "말썽쟁이 소환수 감시 사용"

L["BAD_PETS_ALERT_HEADER"] = "소환수 도발"
L["BAD_PETS_ALERT_DESC"] =
	"자동 시전을 켜 둔 채로 탱커에게서 적을 빼앗아 가는 소환수입니다. 대개 주인은 눈치채지 못합니다."
L["BAD_PETS_ALERT_ENABLE"] = "소환수 도발 알림 사용, 대상:"
L["BAD_PETS_ALERT_MINE"] = "내 소환수 도발"
L["BAD_PETS_ALERT_OTHERS"] = "다른 사람의 소환수 도발"
L["BAD_PETS_WHISPER_ENABLE"] = "소환수 주인에게 귓속말"
L["BAD_PETS_WHISPER_ENABLE_DESC"] =
	"소환수 주인에게 자동 시전을 끄는 방법을 알려 주는 귓속말을 보냅니다. 파티에서 여러 명이 Control Freak을 쓰고 있어도 귓속말은 하나만 전송됩니다."
L["BAD_PETS_COOLDOWN_DESC"] =
	"한 소환수가 알림을 일으킨 뒤, 그 소환수에 대해 다시 알리지 않는 시간입니다. 출력, 소리, 알리기, 귓속말 모두에 적용되므로, 자동 시전을 켜 둔 소환수가 대화창을 가득 채우거나 주인이 몇 초마다 귓속말을 받는 일이 없습니다."

L["BAD_PETS_ABILITIES_HEADER"] = "말썽쟁이 소환수 기술"

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
L["TANKING_TOOLS_ENABLE"] = "탱킹 도구 사용"
L["TANKING_TOOLS_MINIMAP_SUMMARY"] = "초반 공격 실패, 방어도 감소, 무기 막기, 회오리."

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "초반 공격 실패"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"전투 시작 후 처음 몇 초 안에 들어가지 못한 내 공격을 알려 줍니다. 빗나감, 회피, 무기 막기, 방패 막기, 저항, 면역이 해당합니다. 가장 중요한 순간에 생기지 못한 위협 수준입니다."
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "초반 공격 실패 알림 사용, 대상:"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "내 초반 공격 실패"
L["TANKING_TOOLS_COLD_OPENER_MINE_DESC"] =
	"전투 초반에 들어가지 못한 내 기술을 알립니다. 옆의 드롭다운에서 이 줄을 보낼 곳을 정합니다."
-- The caption before the window dropdown: "Within [10 Seconds of Fight]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "전투 시작 후"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d초 이내"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"전투 시작 후 얼마 동안 적이 피한 기술을 셀지 정합니다. 시간은 Control Freak이 그 적을 처음 본 순간부터 흐르며, 기술만 셉니다. 자동 공격은 너무 자주 헛쳐서 알릴 거리가 못 됩니다."

L["TANKING_TOOLS_ARMOR_HEADER"] = "방어도 감소"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"파티가 대상의 방어도를 벗기는 데 걸린 시간을 알립니다. 방어구 가르기 5중첩 또는 도적의 약점 노출이 기준입니다. 아래의 '포함' 항목을 선택하면 그 약화 효과도 기다리지만, 파티에 그것을 실제로 시전할 수 있는 사람이 있을 때만 그렇습니다."
L["TANKING_TOOLS_ARMOR_ENABLE"] = "방어도 감소 알림 사용, 대상:"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "방어도 감소 보고"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	"파티가 대상의 방어도를 모두 벗겼을 때 보고를 보낼 곳입니다. 여기에는 나와 다른 사람을 나누는 항목이 없습니다. 파티 전체가 한 일을 나에게 알려 주는 것이기 때문입니다."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "요정의 불꽃 포함"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"드루이드가 어느 형태로 걸든 요정의 불꽃이 걸릴 때까지 기다린 뒤 알립니다. 파티에 드루이드가 없으면 무시합니다."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "무모함의 저주 포함"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"무모함의 저주가 걸릴 때까지 기다린 뒤 알립니다. 파티에 흑마법사가 없으면 무시합니다."

L["TANKING_TOOLS_PARRY_HEADER"] = "무기 막기"
L["TANKING_TOOLS_PARRY_DESC"] =
	"자신이 맡지 않은 적에게 무기 막기를 당한 사람은 그 적의 정면에 서 있는 것입니다. 무기 막기가 일어날 때마다 그 적은 자신을 붙잡고 있는 사람에게 다음 공격을 더 빨리 휘두릅니다."
L["TANKING_TOOLS_PARRY_ENABLE"] = "무기 막기 알림 사용, 대상:"
L["TANKING_TOOLS_PARRY_MINE"] = "내가 당한 무기 막기"
L["TANKING_TOOLS_PARRY_MINE_DESC"] =
	"적이 내 공격을 무기 막기하면 알립니다. 옆의 드롭다운에서 이 줄을 보낼 곳을 정합니다."
L["TANKING_TOOLS_PARRY_OTHERS"] = "다른 사람이 당한 무기 막기"
L["TANKING_TOOLS_PARRY_OTHERS_DESC"] =
	"적이 파티의 다른 사람의 공격을 무기 막기하면 알립니다. 옆의 드롭다운에서 이 줄을 보낼 곳을 정합니다."
L["TANKING_TOOLS_PARRY_IGNORE_TANKS"] = "탱커 무시"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS_DESC"] =
	"무기 막기를 당한 플레이어가 탱커, 즉 공격대에서 메인 탱커로 지정되었거나 파티에서 파티 찾기의 방어 전담 역할을 선택한 사람이라면 알리지 않습니다. 보조 탱커는 도발 교대를 위해 우두머리 앞에 서는 것이므로 귓속말을 보낼 실수가 아닙니다. 내가 당한 무기 막기는 그대로 알립니다."
L["TANKING_TOOLS_PARRY_IGNORE_PETS"] = "소환수 무시"
L["TANKING_TOOLS_PARRY_IGNORE_PETS_DESC"] =
	"무기 막기를 당한 것이 소환수라면 알리지 않습니다. 내 소환수도 포함됩니다. 소환수는 주인이 보낸 자리에 서 있을 뿐이고, 소환수 이름이 적힌 알림으로는 파티의 누구도 할 수 있는 일이 없습니다. 소환수에게는 어떤 경우에도 귓속말을 보내지 않습니다."
L["TANKING_TOOLS_PARRY_WHISPER"] = "당사자에게 귓속말"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"당사자에게 적의 뒤로 이동해 달라는 귓속말을 보냅니다. 파티에서 여러 명이 Control Freak을 쓰고 있어도 귓속말은 하나만 전송됩니다."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"한 사람이 무기 막기 경고를 일으킨 뒤, 그 사람에 대해 다시 알리지 않는 시간입니다. 출력, 소리, 알리기, 귓속말 모두에 적용됩니다. 아직 자리를 옮기지 않은 사람에게 공격이 들어갈 때마다 알려 줄 필요는 없기 때문입니다."

L["TANKING_TOOLS_NOVA_HEADER"] = "회오리"
L["TANKING_TOOLS_NOVA_DESC"] =
	"끌어온 무리를 그 자리에 얼려 탱커의 손이 닿지 않게 만드는 얼음 회오리를 알려 줍니다."
L["TANKING_TOOLS_NOVA_ENABLE"] = "회오리 알림 사용"
L["TANKING_TOOLS_NOVA_MINE"] = "내 회오리"
L["TANKING_TOOLS_NOVA_OTHERS"] = "다른 사람의 회오리"

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
L["UNKNOWN_SOURCE"] = "누군가"
L["UNKNOWN_CASTER"] = "알 수 없음"
L["UNKNOWN_TARGET"] = "알 수 없는 대상"
L["UNKNOWN_SPELL"] = "알 수 없는 주문"

L["TAUNT_SUCCESS"] = "도발! %s님이 %s 사용, 대상: %s."
L["TAUNT_AOE"] = "광역 도발! %s님이 %s 사용."
L["TAUNT_MISSED"] = "도발 실패! %s님의 %s, %s에게 빗나감."
L["TAUNT_RESISTED"] = "도발 실패! %s님의 %s, %s에게 저항당함."
--[[
    The one failure format that leads with the MOB rather than the taunter,
    because the immunity is the news and the other three formats have no news
    beyond "it did not land".

    TRANSLATORS: %s is, in order: mob, taunter, taunt. This is the ONLY taunt
    format whose first %s is not the player who cast it.
]]
L["TAUNT_IMMUNE"] = "도발 실패! %s 면역: %s님의 %s."
L["TAUNT_FAILED"] = "도발 실패! %s님의 %s, %s에게 실패."
L["INTERRUPT"] = "차단! %s님의 %s, %s의 %s 차단."

L["FEAR_SUCCESS"] = "공포! %s님이 %s 사용, 대상: %s."
L["FEAR_AOE"] = "광역 공포! %s님이 %s 사용."

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
L["INCAPACITATED"] = "%s %s 행동 불가! %s님이 %s(%s)에 걸림, 시전자: %s."
L["INCAPACITATED_PLAIN"] = "%s %s 행동 불가! %s님이 %s에 걸림, 시전자: %s."
L["INCAPACITATED_INDEFINITE"] = "%s 행동 불가! %s님이 %s(%s)에 걸림, 시전자: %s."
L["INCAPACITATED_PLAIN_INDEFINITE"] = "%s 행동 불가! %s님이 %s에 걸림, 시전자: %s."

--[[
    The seat the line opens on, as its own phrase rather than a format per role,
    which would be eight copies of the four above.

    TRANSLATORS: this is the client's own word for the group finder role, and it
    opens a sentence. "Afflicted by" in the formats above is deliberately the
    phrasing Blizzard's combat log uses for a debuff landing
    (AURAADDEDOTHERHARMFUL), so a player reads the same words here as in the log
    they already watch -- use your client's wording for both if it has one.
]]
L["INCAPACITATED_ROLE_TANK"] = "탱커"
L["INCAPACITATED_ROLE_HEALER"] = "힐러"

--[[
    The length, as its own phrase rather than a bare number with "seconds" in the
    format, so the singular does not need two more formats beside the four
    above. Always a whole number: the handler rounds UP, because a fear reported
    as 5.9 promises a taunt back sooner than it is coming.

    TRANSLATORS: the handler reads exactly these two, the first for 1 and the
    second for every other count, so a language with more number forms words
    the second to read for any count. An abbreviated unit does.
]]
L["INCAPACITATED_SECOND"] = "%d초간"
L["INCAPACITATED_SECONDS"] = "%d초간"

--[[
    The four debuff types a player can take off. They name the class that can
    help -- Magic is a priest or paladin, Curse a mage or druid -- so they are
    the half of the line a tank cannot act on alone.

    TRANSLATORS: use the client's own words for these, the ones on the debuff
    tooltips, not a literal translation of the English.
]]
L["DISPEL_MAGIC"] = "마법"
L["DISPEL_CURSE"] = "저주"
L["DISPEL_DISEASE"] = "질병"
L["DISPEL_POISON"] = "독"

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
L["TANK_DEATHS_TANK_LINE"] = "탱커 사망! %s님이 죽었습니다."
L["TANK_DEATHS_CLASS_LINE"] = "%s 사망! %s님이 죽었습니다."

--[[
    Kept short on purpose: they render with a real spell link and two real names
    inside the 255 byte chat limit, and the widest locale runs close to twice the
    English.

    The WARNING carries no explanation and the WHISPER carries all of it. The
    warning fires mid-pull in front of a tank who already knows what a shield
    does; the whisper goes to the healer who does not, and is read after the
    fact. The tab description explains it at length for whoever wants it.
]]
L["SHIELD_WARNING"] = "잘못된 보호막! %s님이 %s 시전, 대상: %s님."
L["SHIELD_WHISPER"] =
	"잘못된 보호막! %s 시전을 %s님에게는 자제해 주세요. 이 기술은 탱커가 분노를 얻지 못하게 합니다."

L["BAD_PET"] = "말썽쟁이 소환수! %s님의 소환수 %s, %s 사용, 대상: %s."
L["BAD_PET_AOE"] = "말썽쟁이 소환수! %s님의 소환수 %s, %s 사용."
L["BAD_PET_UNKNOWN_OWNER"] = "말썽쟁이 소환수! %s, %s 사용, 대상: %s."
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "말썽쟁이 소환수! %s, %s 사용."
--[[
    Kept short on purpose. They render with a spell link and up to two names inside
    a 255 byte chat limit, and the widest locale runs close to twice the English.
]]
L["BAD_PET_WHISPER"] =
	"소환수 %s, %s 사용, 대상: %s. 해당 기술을 우클릭하면 자동 시전이 꺼집니다."
L["BAD_PET_WHISPER_AOE"] = "소환수 %s, %s 사용. 해당 기술을 우클릭하면 자동 시전이 꺼집니다."

L["COLD_OPENER_MISS"] = "주의! %s님의 %s, %s에게 빗나감."
L["COLD_OPENER_DODGE"] = "주의! %s님의 %s, %s에게 회피당함."
L["COLD_OPENER_PARRY"] = "주의! %s님의 %s, %s에게 무기로 막힘."
L["COLD_OPENER_BLOCK"] = "주의! %s님의 %s, %s에게 방패로 막힘."
L["COLD_OPENER_IMMUNE"] = "주의! %s님의 %s, %s에게 통하지 않음."
L["COLD_OPENER_RESIST"] = "주의! %s님의 %s, %s에게 저항당함."

L["ARMOR_REPORT"] = "방어도 제거! %s, %s초 만에 취약해짐."

L["PARRY_WARNING"] = "무기 막기 가속! %s님이 %s 정면에 서 있습니다."
L["PARRY_WHISPER"] =
	"무기 막기 가속! %s 뒤쪽으로 이동해 주세요. 무기 막기가 일어날 때마다 다음 공격이 빨라집니다."

L["NOVA"] = "회오리! %s님이 %s 사용, 대상: %s."
L["NOVA_AOE"] = "광역 회오리! %s님이 %s 사용."
