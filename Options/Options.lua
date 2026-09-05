local _, ns = ...

local L = ns.L

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

--------------------------------------------------------------------------------
-- Registration
--------------------------------------------------------------------------------

-- Deferred, never file-scope: the Profiles builder reaches ns.db, which does not
-- exist until the SavedVariables init point.
function ns.RegisterOptionsPanels()
	local registry = ns.OPTIONS_REGISTRY

	AceConfig:RegisterOptionsTable(registry.General, ns.BuildGeneralOptions())
	local mainPanel, mainCategoryID = AceConfigDialog:AddToBlizOptions(registry.General, L["ADDON_TITLE"])
	ns.optionsFrames = { main = mainPanel, categoryID = mainCategoryID }

	AceConfig:RegisterOptionsTable(registry.Taunts, ns.BuildTauntsOptions())
	AceConfigDialog:AddToBlizOptions(registry.Taunts, L["TAB_TAUNTS"], L["ADDON_TITLE"])

	AceConfig:RegisterOptionsTable(registry.Interrupts, ns.BuildInterruptsOptions())
	AceConfigDialog:AddToBlizOptions(registry.Interrupts, L["TAB_INTERRUPTS"], L["ADDON_TITLE"])

	AceConfig:RegisterOptionsTable(registry.Fears, ns.BuildFearsOptions())
	AceConfigDialog:AddToBlizOptions(registry.Fears, L["TAB_FEARS"], L["ADDON_TITLE"])

	AceConfig:RegisterOptionsTable(registry.BadPet, ns.BuildBadPetOptions())
	AceConfigDialog:AddToBlizOptions(registry.BadPet, L["TAB_BAD_PET"], L["ADDON_TITLE"])

	-- Last of the feature tabs, directly above Profiles: it is the one still being
	-- built out, and the alert tabs above it are what a player opens first.
	AceConfig:RegisterOptionsTable(registry.TankingTools, ns.BuildTankingToolsOptions())
	AceConfigDialog:AddToBlizOptions(registry.TankingTools, L["TAB_TANKING_TOOLS"], L["ADDON_TITLE"])

	-- AceDBOptions-3.0 names the panel in every locale it ships, so the tab takes
	-- its name from the table rather than carrying a translation of our own.
	local profiles = ns.BuildProfilesOptions()
	AceConfig:RegisterOptionsTable(registry.Profiles, profiles)
	AceConfigDialog:AddToBlizOptions(registry.Profiles, profiles.name, L["ADDON_TITLE"])

	AceConfig:RegisterOptionsTable(registry.Diagnostics, ns.BuildDiagnosticsOptions())
	AceConfigDialog:AddToBlizOptions(registry.Diagnostics, ns.DiagnosticsStrings.TAB, L["ADDON_TITLE"])

	-- TEMPORARY (remove after 2026-12-03) -- see Options/Options-Apology.lua.
	-- Registered last so it sits at the bottom of the list: it is a note to read
	-- once, not a panel to come back to, and it should not push the settings down.
	AceConfig:RegisterOptionsTable(registry.Apology, ns.BuildApologyOptions())
	AceConfigDialog:AddToBlizOptions(registry.Apology, ns.APOLOGY_TAB_NAME, L["ADDON_TITLE"])
end

--------------------------------------------------------------------------------
-- Opening the Panel
--------------------------------------------------------------------------------

-- Never look up a category by name: Settings.GetCategory(<title>) returns nil on
-- any client with the Settings API, and the panel opens as a floating window.
function ns:OpenOptionsPanel()
	if InCombatLockdown() then
		ns:PrintMessage(L["CHAT_OPTIONS_IN_COMBAT"])
		return
	end
	if not ns.optionsFrames then
		return
	end
	if Settings and Settings.OpenToCategory and ns.optionsFrames.categoryID then
		Settings.OpenToCategory(ns.optionsFrames.categoryID)
		return
	end
	AceConfigDialog:Open(ns.OPTIONS_REGISTRY.General)
end

--------------------------------------------------------------------------------
-- Slash Commands
--------------------------------------------------------------------------------

SLASH_CONTROLFREAK1 = "/freak"
SlashCmdList["CONTROLFREAK"] = function()
	ns:OpenOptionsPanel()
end
