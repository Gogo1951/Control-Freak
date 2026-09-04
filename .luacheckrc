std = "lua51"
max_line_length = false -- StyLua owns formatting
ignore = { "212/self", "611", "612", "613", "614", "621" } -- implicit self (house ns: methods) + whitespace — StyLua owns the latter
exclude_files = { "Includes/", "Examples/" } -- vendored and reference-only, never linted
read_globals = {
	-- Lua extensions the client adds
	"bit",
	"wipe",
	"strsplit",
	"unpack",
	"time",

	-- Libraries
	"LibStub",

	-- Add-on and UI
	"C_AddOns",
	"C_ChatInfo",
	"C_CVar",
	"C_Engraving",
	"C_EventUtils",
	"C_NamePlate",
	"C_Spell",
	"C_Timer",
	"CreateFrame",
	"PlaySound",
	"GameTooltip",
	"GetBuildInfo",
	"GetPhysicalScreenSize",
	"GetTime",
	"InCombatLockdown",
	"IsShiftKeyDown",
	"IsPlayerSpell",
	"IsSpellKnown",
	"Settings",
	"UIParent",
	"WOW_PROJECT_BURNING_CRUSADE_CLASSIC",
	"WOW_PROJECT_CLASSIC",
	"WOW_PROJECT_ID",

	-- Combat log
	"CombatLogGetCurrentEventInfo",
	"COMBATLOG_OBJECT_AFFILIATION_MASK",
	"COMBATLOG_OBJECT_AFFILIATION_MINE",
	"COMBATLOG_OBJECT_AFFILIATION_OUTSIDER",
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
	"UnitLevel",

	-- Spells, sound, and chat
	"GetSpellInfo",
	"GetSpellLink",
	"PlaySoundFile",
	"SendChatMessage",
}
globals = {
	"ControlFreakDB",
	"SLASH_CONTROLFREAK1",
	"SlashCmdList",
}
