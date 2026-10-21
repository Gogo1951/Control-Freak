local _, ns = ...

local L = ns.L

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

--------------------------------------------------------------------------------
-- Registration
--------------------------------------------------------------------------------

--[[
    Deferred, never file-scope: the Profiles builder reaches ns.db, which does not
    exist until the SavedVariables init point.
]]
function ns.RegisterOptionsPanels()
	local registry = ns.OPTIONS_REGISTRY

	AceConfig:RegisterOptionsTable(registry.General, ns.BuildGeneralOptions())
	local mainPanel, mainCategoryID = AceConfigDialog:AddToBlizOptions(registry.General, L["ADDON_TITLE"])
	ns.optionsFrames = { main = mainPanel, categoryID = mainCategoryID }

	--[[
	    A sub-panel nests under the category ID its parent's AddToBlizOptions
	    handed back, never under the parent's title: the vendored AceConfigDialog
	    looks the parent up with Settings.GetCategory, which finds a category at
	    any depth by ID and indents each level under the one above it.
	]]
	local function AddSubPanel(appName, options, name, parentID)
		AceConfig:RegisterOptionsTable(appName, options)
		AceConfigDialog:AddToBlizOptions(appName, name, parentID)
	end

	AceConfig:RegisterOptionsTable(registry.Taunts, ns.BuildTauntsOptions())
	local _, tauntsID = AceConfigDialog:AddToBlizOptions(registry.Taunts, L["TAB_TAUNTS"], L["ADDON_TITLE"])
	AddSubPanel(registry.TauntsTracked, ns.BuildTauntsTrackedOptions(), L["TRACKED_HEADER"], tauntsID)

	AceConfig:RegisterOptionsTable(registry.Interrupts, ns.BuildInterruptsOptions())
	AceConfigDialog:AddToBlizOptions(registry.Interrupts, L["TAB_INTERRUPTS"], L["ADDON_TITLE"])

	AceConfig:RegisterOptionsTable(registry.Fears, ns.BuildFearsOptions())
	local _, fearsID = AceConfigDialog:AddToBlizOptions(registry.Fears, L["TAB_FEARS"], L["ADDON_TITLE"])
	AddSubPanel(registry.FearsTracked, ns.BuildFearsTrackedOptions(), L["TRACKED_HEADER"], fearsID)

	--[[
	    Directly under Fears, because the two are the same news read from opposite
	    ends: a fear scattering the pull, and the tank it landed on saying so.
	]]
	AceConfig:RegisterOptionsTable(registry.Incapacitated, ns.BuildIncapacitatedOptions())
	AceConfigDialog:AddToBlizOptions(registry.Incapacitated, L["TAB_INCAPACITATED"], L["ADDON_TITLE"])

	--[[
	    Next after Incapacitated, because the two are one step apart: losing
	    control of your character, then losing it for good.
	]]
	AceConfig:RegisterOptionsTable(registry.TankDeaths, ns.BuildTankDeathsOptions())
	AceConfigDialog:AddToBlizOptions(registry.TankDeaths, L["TAB_TANK_DEATHS"], L["ADDON_TITLE"])

	--[[
	    The two Bad tabs sit together: they are the ones about somebody in the
	    group doing something wrong, where everything above them reports what
	    happened.
	]]
	--[[
	    Registered on every flavor, Season of Discovery included, where its summary
	    says a priest rune gives the rage back, rather than the tab hiding itself.
	]]
	AceConfig:RegisterOptionsTable(registry.BadPriests, ns.BuildBadPriestsOptions())
	AceConfigDialog:AddToBlizOptions(registry.BadPriests, L["TAB_BAD_PRIESTS"], L["ADDON_TITLE"])

	AceConfig:RegisterOptionsTable(registry.BadPets, ns.BuildBadPetsOptions())
	local _, badPetsID = AceConfigDialog:AddToBlizOptions(registry.BadPets, L["TAB_BAD_PETS"], L["ADDON_TITLE"])
	AddSubPanel(registry.BadPetsTracked, ns.BuildBadPetsTrackedOptions(), L["TRACKED_HEADER"], badPetsID)

	--[[
	    Last of the feature tabs, below the Bad pair, because it is the only one
	    that ships switched off -- its tools are still in beta. A tab nobody has
	    opted into yet does not belong in the middle of the ones that work.
	    ns.FEATURE_KEYS carries the same order; keep the two in step.
	]]
	AceConfig:RegisterOptionsTable(registry.TankingTools, ns.BuildTankingToolsOptions())
	local _, tankingToolsID =
		AceConfigDialog:AddToBlizOptions(registry.TankingTools, L["TAB_TANKING_TOOLS"], L["ADDON_TITLE"])

	-- One sub-panel per tool, in ns.TANKING_TOOLS order; each builder is named after its registry key.
	for _, tool in ipairs(ns.TANKING_TOOLS) do
		local build = ns["Build" .. tool.registry .. "Options"]
		AddSubPanel(registry[tool.registry], build(), L[tool.headerKey], tankingToolsID)
	end

	--[[
	    AceDBOptions-3.0 names the panel in every locale it ships, so the tab takes
	    its name from the table rather than carrying a translation of our own.
	]]
	local profiles = ns.BuildProfilesOptions()
	AceConfig:RegisterOptionsTable(registry.Profiles, profiles)
	AceConfigDialog:AddToBlizOptions(registry.Profiles, profiles.name, L["ADDON_TITLE"])

	AceConfig:RegisterOptionsTable(registry.FeedbackSupport, ns.BuildFeedbackSupportOptions())
	AceConfigDialog:AddToBlizOptions(registry.FeedbackSupport, L["OPTIONS_FEEDBACK"], L["ADDON_TITLE"])

	-- A builder function, so the tabs come and go with the enable toggle (see Diagnostics/Options-Diagnostics.lua).
	AceConfig:RegisterOptionsTable(registry.Diagnostics, ns.BuildDiagnosticsOptions)
	AceConfigDialog:AddToBlizOptions(registry.Diagnostics, ns.DiagnosticsStrings.TAB, L["ADDON_TITLE"])
end

--------------------------------------------------------------------------------
-- Opening the Panel
--------------------------------------------------------------------------------

--[[
    Never look up a category by name: a title lookup fails on TBC Anniversary,
    where the category ID is a number assigned at registration, and the panel
    then opens as a floating window. Routing uses the captured category ID.
]]
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
