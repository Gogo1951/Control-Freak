std = "lua51"
max_line_length = false -- StyLua owns formatting
ignore = { "212/self", "611", "612", "613", "614", "621" } -- implicit self (house ns: methods) + whitespace — StyLua owns the latter
exclude_files = { "Includes/", ".claude/" } -- vendored or session-local, never linted
read_globals = {
	-- Lua extensions the client adds
	"bit",
	"wipe",
	"strsplit",
	"unpack",

	-- Libraries
	"LibStub",

	-- Add-on and UI
	"C_AddOns",
	"C_ChatInfo",
	"C_CombatLog",
	"C_CVar",
	"C_EventUtils",
	"C_Item",
	"C_LossOfControl",
	"C_NamePlate",
	"C_QuestLog",
	"C_Seasons",
	"C_Secrets",
	"C_Spell",
	"C_SpellBook",
	"C_Timer",
	"C_TooltipInfo",
	"C_UnitAuras",
	"CreateFrame",
	"Enum",
	"PlaySound",
	"GameTooltip",
	"GetBuildInfo",
	"GetCVar",
	"GetPhysicalScreenSize",
	"GetTime",
	"InCombatLockdown",
	"IsShiftKeyDown",
	"IsPlayerSpell",
	"IsSpellKnown",
	"Settings",
	"SetCVar",
	"UIParent",
	"WorldFrame",

	-- Combat log
	"CombatLogGetCurrentEventInfo",
	"COMBATLOG_OBJECT_AFFILIATION_MASK",
	"COMBATLOG_OBJECT_AFFILIATION_MINE",
	"COMBATLOG_OBJECT_AFFILIATION_OUTSIDER",
	"COMBATLOG_OBJECT_CONTROL_PLAYER",
	"COMBATLOG_OBJECT_REACTION_FRIENDLY",
	"COMBATLOG_OBJECT_RAIDTARGET_MASK",
	"COMBATLOG_OBJECT_RAIDTARGET1",
	"COMBATLOG_OBJECT_RAIDTARGET2",
	"COMBATLOG_OBJECT_RAIDTARGET3",
	"COMBATLOG_OBJECT_RAIDTARGET4",
	"COMBATLOG_OBJECT_RAIDTARGET5",
	"COMBATLOG_OBJECT_RAIDTARGET6",
	"COMBATLOG_OBJECT_RAIDTARGET7",
	"COMBATLOG_OBJECT_RAIDTARGET8",
	"COMBATLOG_OBJECT_TYPE_GUARDIAN",
	"COMBATLOG_OBJECT_TYPE_PET",
	"COMBATLOG_OBJECT_TYPE_PLAYER",

	-- Units and groups
	"Ambiguate",
	"GetLocale",
	"GetNumGroupMembers",
	"GetPartyAssignment",
	"GetPlayerInfoByGUID",
	"GetUnitName",
	"IsInGroup",
	"IsInInstance",
	"IsInRaid",
	"LE_PARTY_CATEGORY_INSTANCE",
	"LOCALIZED_CLASS_NAMES_FEMALE",
	"LOCALIZED_CLASS_NAMES_MALE",
	"UnitClass",
	"UnitClassification",
	"UnitGroupRolesAssigned",
	"UnitGUID",
	"UnitHealth",
	"UnitHealthMax",
	"UnitIsConnected",
	"UnitExists",
	"UnitIsDeadOrGhost",
	"UnitIsFeignDeath",
	"UnitLevel",
	"UnitSex",

	-- Spells, sound, and chat
	"PlaySoundFile",
	"SendChatMessage",
}
globals = {
	"ControlFreakDB",
	"SLASH_CONTROLFREAK1",
	SlashCmdList = { fields = { "CONTROLFREAK" } }, -- a field, so only the add-on's own slash entry is writable
}
