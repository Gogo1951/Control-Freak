local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "koKR")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"더 나은 정보 = 더 나은 방어 전담. 더 나은 방어 전담 = 더 나은 공격대."
L["VERSION"] = "버전"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"버전 %s. 설정은 (이 메시지를 끄는 옵션을 포함해) 옵션 > AddOns > Control Freak 에서 찾을 수 있습니다. 애드온이 마음에 드시나요? 친구에게 알려 주세요! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "안전을 위해 전투 중에는 설정 창을 열 수 없습니다."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "환영 메시지 사용"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "접속할 때 Control Freak 인사말을 표시합니다."
L["ENABLE_MINIMAP_BUTTON"] = "미니맵 단추 사용"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "미니맵에 Control Freak 단추를 표시합니다."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "이 애드온의 설정 창을 엽니다."

-- The master switch. Its description is shared with the mini-map button's own
-- line for the same toggle, so the two cannot describe it differently.
L["KILL_SWITCH"] = "전체 차단"
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

L["STATE_ON"] = "켜짐"
L["STATE_OFF"] = "꺼짐"
L["LEFT_CLICK"] = "좌클릭"
L["RIGHT_CLICK"] = "우클릭"
L["SHIFT_MIDDLE_CLICK"] = "Shift + 가운데 클릭"
L["ACTION_TOGGLE"] = "전환"
L["MINIMAP_OPTIONS"] = "Control Freak 설정"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

L["TAB_TAUNTS"] = "도발"
L["TAB_INTERRUPTS"] = "차단"
L["TAB_FEARS"] = "공포"
L["TAB_BAD_PET"] = "말썽쟁이 소환수"
L["TAB_TANKING_TOOLS"] = "방어 전담 도구"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "이 기능을 켜거나 끕니다."
L["SCOPE_TANK_ROLE_ONLY"] = "방어 전담으로 플레이할 때만"
L["SCOPE_TANK_ROLE_ONLY_DESC"] =
	"공격대의 주 탱커이거나 파티 찾기에서 방어 전담 역할을 선택한 상태로 탱킹하는 동안에만 작동합니다. 둘 다 아니라면 이 기능은 조용히 있습니다."
L["SCOPE_GROUP_HAS_TANK"] = "파티에 방어 전담이 있을 때만"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"파티원 중 누군가가 탱킹 중이고 아직 살아 있을 때만 작동합니다. 쓰러진 탱커는 탱커가 없는 것으로 봅니다. 바로 그때가 다른 누군가가 위협 수준을 붙잡아 주는 것이 도움이 되는 순간이기 때문입니다."
L["SCOPE_INSTANCE_ONLY"] = "인스턴스 안에서만"
L["SCOPE_INSTANCE_ONLY_DESC"] = "던전과 공격대 안에서만 작동합니다."

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
L["ALERT_SECTION_ENABLE_DESC"] = "이 알림을 켜거나 끕니다."
L["ALERT_PRINT"] = "알림 출력"
L["ALERT_PRINT_DESC"] = "이 알림을 내 대화창에 출력합니다."
L["ALERT_PRINT_SCOPE_DESC"] =
	"누구의 시전이 내 창에 표시될지 정합니다. 내 것은 나와 내 소환수를, 전체는 파티원 전원을 포함합니다. 소리도 이 설정을 따르므로, 볼 수 없는 알림을 듣게 되는 일은 없습니다."
L["ALERT_ANNOUNCE"] = "파티에 알리기"
L["ALERT_ANNOUNCE_DESC"] =
	"이 알림을 파티 또는 공격대 대화에 보냅니다. 다른 사람이 한 일을 공격대 전체에 중계하는 것은 애드온이 미움받는 가장 빠른 길이므로, 켜기 전에 한 번 생각해 볼 만합니다."
L["ALERT_ANNOUNCE_SCOPE_DESC"] =
	"누구의 시전이 파티 또는 공격대 대화로 갈지 정합니다. 내 것은 나와 내 소환수를, 전체는 나를 포함한 파티원 전원을 포함합니다."
L["ALERT_SCOPE_MINE"] = "내 것"
L["ALERT_SCOPE_ALL"] = "전체"
L["ALERT_BOSS_ONLY"] = "우두머리 및 정예 상대로만"
L["ALERT_BOSS_ONLY_DESC"] =
	"신경 쓸 가치가 있는 적에게만 작동합니다. 공격대 우두머리, 던전 우두머리, 그리고 내 레벨보다 높은 모든 정예 몬스터입니다."
L["ALERT_SOUND"] = "소리"
L["ALERT_SOUND_DESC"] = "이 알림이 발생할 때 소리를 재생합니다."
L["ALERT_SOUND_FILE_DESC"] = "이 알림이 재생할 소리를 고릅니다. 고르면 바로 재생됩니다."
L["ALERT_SOUND_PREVIEW_DESC"] = "소리 사용 여부와 상관없이 지금 이 소리를 재생합니다."
L["SOUND_NONE"] = "없음"

-- The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
-- list of seconds. Whole minutes read as minutes, and zero reads as "No
-- Cooldown" rather than "0 Second Cooldown".
L["COOLDOWN_NONE"] = "대기시간 없음"
L["COOLDOWN_SECONDS"] = "%d초 대기시간"
L["COOLDOWN_MINUTES"] = "%d분 대기시간"

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
L["SAMPLE_EXAMPLE"] = "예시: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "철수"
L["SAMPLE_PET"] = "멍멍이"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "아이템"
L["ABILITIES_CLASS_PET"] = "%s 소환수"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] =
	"도발은 현재 위협 수준을 쥐고 있는 대상에게서 그것을 빼앗는 기술입니다."
L["TAUNTS_ENABLE"] = "도발 감시 사용"

L["TAUNTS_SUCCESS_HEADER"] = "도발 성공"
L["TAUNTS_SUCCESS_ENABLE"] = "도발 성공 알림 사용"
L["TAUNTS_SUCCESS_DESC"] =
	"적중해서 다른 사람에게서 적을 빼앗아 온 도발입니다. 이미 도발한 사람을 때리고 있던 적에게 건 도발은 구원이 아니라 위협 수준 갱신이므로 조용히 넘어갑니다."
L["TAUNTS_FAILED_HEADER"] = "도발 실패"
L["TAUNTS_FAILED_ENABLE"] = "도발 실패 알림 사용"
L["TAUNTS_FAILED_DESC"] =
	"빗나갔거나, 저항당했거나, 면역인 대상에게 걸린 도발입니다. 적은 주인이 바뀌지 않았고, 화면에는 그 사실이 나타나지 않습니다."
L["TAUNTS_AOE_HEADER"] = "광역 도발"
L["TAUNTS_AOE_ENABLE"] = "광역 도발 알림 사용"
L["TAUNTS_AOE_DESC"] = "대상 하나가 아니라 주위 전체를 한 번에 끌어오는 도발입니다."

L["TAUNTS_ABILITIES_HEADER"] = "도발 기술"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "광역 도발 기술"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "차단은 적의 주문을 시전 도중에 멈춥니다."
L["INTERRUPTS_ENABLE"] = "차단 감시 사용"

L["INTERRUPTS_ALERT_HEADER"] = "차단 성공"
L["INTERRUPTS_ALERT_ENABLE"] = "차단 성공 알림 사용"
L["INTERRUPTS_ALERT_DESC"] =
	"시전 도중에 멈춘 주문입니다. 누가 멈췄는지, 무엇을 멈췄는지 알려 줍니다."

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "공포는 적을 달아나게 만들어 끌어온 무리를 사방으로 흩어 놓습니다."
L["FEARS_ENABLE"] = "공포 감시 사용"

L["FEARS_ALERT_HEADER"] = "공포"
L["FEARS_ALERT_ENABLE"] = "공포 알림 사용"
L["FEARS_ALERT_DESC"] =
	"적중해서 무리를 탱커의 손이 닿지 않는 곳으로 흩어 놓은 공포입니다. 적중한 경우만 셉니다. 단순 시전, 저항, 면역은 아무것도 움직이지 못했으므로 어느 것도 보고하지 않습니다."

L["FEARS_ABILITIES_HEADER"] = "공포 기술"

--------------------------------------------------------------------------------
-- Bad Pet
--------------------------------------------------------------------------------

-- The summary doubles as the mini-map button's Bad Pet line, so the tab and the
-- tooltip cannot describe the feature differently.
L["BAD_PET_SUMMARY"] = "위협 기술을 자동 시전으로 켜 둔 사냥꾼과 흑마법사의 소환수입니다."
L["BAD_PET_ENABLE"] = "말썽쟁이 소환수 감시 사용"

L["BAD_PET_ALERT_HEADER"] = "소환수 도발"
L["BAD_PET_ALERT_ENABLE"] = "소환수 도발 알림 사용"
L["BAD_PET_ALERT_DESC"] =
	"자동 시전을 켜 둔 채로 탱커에게서 적을 빼앗아 가는 소환수입니다. 대개 주인은 눈치채지 못합니다."
L["BAD_PET_WHISPER_ENABLE"] = "주인에게 귓속말"
L["BAD_PET_WHISPER_ENABLE_DESC"] =
	"소환수 주인에게 자동 시전을 끄는 방법을 설명하는 귓속말을 보냅니다. 파티에서 여러 명이 Control Freak을 쓰고 있어도 한 번만 전송됩니다."
L["BAD_PET_COOLDOWN_DESC"] =
	"한 소환수가 알림을 발생시킨 뒤 조용히 있는 시간입니다. 출력, 소리, 알리기, 귓속말 전부에 적용되므로, 자동 시전을 켜 둔 소환수가 대화창을 가득 채우거나 주인이 몇 초마다 귓속말을 받는 일이 없습니다."

L["BAD_PET_ABILITIES_HEADER"] = "말썽쟁이 소환수 기술"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

-- No summary line: the Tanking Tools tab opens on its enable, because the tab is
-- a collection of unrelated warnings rather than one idea a sentence can cover.
-- Each section introduces itself instead.
L["TANKING_TOOLS_ENABLE"] = "방어 전담 도구 사용"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "초반 실패"
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "초반 실패 알림 사용"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"전투 시작 몇 초 안에 들어가지 못한 내 첫 공격을 알려 줍니다. 빗나감, 회피, 무기 막기, 방패 막기, 저항, 면역이 대상입니다. 가장 중요한 순간에 생기지 못한 위협 수준입니다."
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"전투 시작 후 어디까지 피해진 기술을 셀지 정합니다. 시계는 Control Freak이 그 적을 처음 본 순간부터 돌아가며, 기술만 셉니다. 자동 공격은 너무 자주 빗나가서 알릴 가치가 없습니다."
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "전투 %d초"

L["TANKING_TOOLS_ARMOR_HEADER"] = "방어도 감소"
L["TANKING_TOOLS_ARMOR_ENABLE"] = "방어도 감소 알림 사용"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"파티가 대상의 방어도를 벗기는 데 걸린 시간을 보고합니다. 갑옷 부수기 5중첩 또는 도적의 방어구 가르기가 기준입니다. 아래에서 추가 항목을 켜면 그것도 기다리지만, 파티에 실제로 시전할 수 있는 사람이 있을 때만 그렇습니다."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "요정의 불꽃 포함"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"드루이드가 어떤 형태로 시전하든 요정의 불꽃을 기다린 뒤 보고합니다. 파티에 드루이드가 없으면 무시합니다."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "무모함의 저주 포함"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"무모함의 저주를 기다린 뒤 보고합니다. 파티에 흑마법사가 없으면 무시합니다."

L["TANKING_TOOLS_PARRY_HEADER"] = "무기 막기"
L["TANKING_TOOLS_PARRY_ENABLE"] = "무기 막기 알림 사용"
L["TANKING_TOOLS_PARRY_DESC"] =
	"자기가 맡지 않은 적에게 무기 막기를 당한 사람은 그 적의 정면에 서 있는 것입니다. 무기 막기가 일어날 때마다 그 적이 잡고 있는 사람을 향해 다음 공격을 더 빨리 휘두릅니다."
L["TANKING_TOOLS_PARRY_WHISPER"] = "당사자에게 귓속말"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"당사자에게 적의 뒤로 이동해 달라는 귓속말을 보냅니다. 파티에서 여러 명이 Control Freak을 쓰고 있어도 한 번만 전송됩니다."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"한 사람이 무기 막기 경고를 발생시킨 뒤 조용히 있는 시간입니다. 출력, 소리, 알리기, 귓속말 전부에 적용됩니다. 아직 움직이지 않은 사람에게 공격마다 알려 줄 필요는 없기 때문입니다."

L["TANKING_TOOLS_NOVA_HEADER"] = "회오리"
L["TANKING_TOOLS_NOVA_ENABLE"] = "회오리 알림 사용"
L["TANKING_TOOLS_NOVA_DESC"] =
	"얼음 회오리를 알려 줍니다. 끌어온 무리를 탱커의 손이 닿지 않는 곳으로 흩어 놓습니다."

--------------------------------------------------------------------------------
-- Message Formats
--------------------------------------------------------------------------------

L["UNKNOWN_SOURCE"] = "누군가"
L["UNKNOWN_TARGET"] = "알 수 없는 대상"
L["UNKNOWN_SPELL"] = "알 수 없는 주문"

L["TAUNT_SUCCESS"] = "도발! %s님이 %s 시전, 대상 %s!"
L["TAUNT_AOE"] = "광역 도발! %s님이 %s 시전!"
L["TAUNT_MISSED"] = "도발 실패! %s님의 %s, 대상 %s, 빗나감!"
L["TAUNT_RESISTED"] = "도발 실패! %s님의 %s, 대상 %s, 저항됨!"
L["TAUNT_IMMUNE"] = "도발 실패! %s님의 %s, 대상 %s, 실패! %s 면역."
L["TAUNT_FAILED"] = "도발 실패! %s님의 %s, 대상 %s, 실패!"
L["TAUNT_STOLEN"] = "이봐, 내 거야! %s님이 %s 시전, 대상 %s!" -- parked; see Data/Default-Settings.lua

L["FEAR_SUCCESS"] = "공포! %s님이 %s 시전, 대상 %s!"
L["FEAR_AOE"] = "광역 공포! %s님이 %s 시전!"

L["INTERRUPT"] = "차단! %s님이 %s 시전, 대상 %s, %s 차단!"

L["COLD_OPENER_MISS"] = "주의! %s님의 %s, 대상 %s, 빗나감!"
L["COLD_OPENER_DODGE"] = "주의! %s님의 %s, 대상 %s, 회피됨!"
L["COLD_OPENER_PARRY"] = "주의! %s님의 %s, 대상 %s, 무기 막기!"
L["COLD_OPENER_BLOCK"] = "주의! %s님의 %s, 대상 %s, 방패 막기!"
L["COLD_OPENER_IMMUNE"] = "주의! %s님의 %s, 대상 %s, 면역!"
L["COLD_OPENER_RESIST"] = "주의! %s님의 %s, 대상 %s, 저항됨!"

L["ARMOR_REPORT"] = "%s 방어도 감소 완료, %s초 소요!"

L["PARRY_WARNING"] = "무기 막기 가속! %s님이 %s 정면에 서 있습니다!"
L["PARRY_WHISPER"] =
	"저기요, %s 뒤쪽으로 이동해 주세요. 무기 막기 가속 때문에 제가 피해를 더 받고 있습니다."

L["NOVA"] = "회오리! %s님이 %s 시전, 대상 %s!"
L["NOVA_AOE"] = "광역 회오리! %s님이 %s 시전!"
-- parked with the bubbles themselves; still reads "Annoyance!" and wants wording
-- of its own when Bubble Warnings lands. See Data/Abilities.lua.
L["ANNOYANCE_BUBBLE"] = "성가심! %s님이 %s 시전, 대상 %s, 생명력 %d%%!"

L["BAD_PET"] = "말썽쟁이 소환수! %s님의 소환수 %s, %s 시전, 대상 %s!"
L["BAD_PET_AOE"] = "말썽쟁이 소환수! %s님의 소환수 %s, %s 시전!"
L["BAD_PET_OWN"] = "말썽쟁이 소환수! 내 소환수 %s, %s 시전, 대상 %s!"
L["BAD_PET_OWN_AOE"] = "말썽쟁이 소환수! 내 소환수 %s, %s 시전!"
L["BAD_PET_UNKNOWN_OWNER"] = "말썽쟁이 소환수! %s, %s 시전, 대상 %s!"
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "말썽쟁이 소환수! %s, %s 시전!"
L["BAD_PET_WHISPER"] =
	"당신의 소환수 %s, %s 시전, 대상 %s. 소환수 행동 단축바나 주문서에서 해당 기술을 우클릭하면 자동 시전을 끌 수 있습니다."
