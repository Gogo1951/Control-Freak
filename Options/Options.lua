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
		return select(2, AceConfigDialog:AddToBlizOptions(appName, name, parentID))
	end

	--[[
	    The tree follows the General panel's Features block: a page per group
	    (ns.FEATURE_GROUPS) with its features' tabs nested under it, then
	    Tanking Tools with its tools. Both group pages register first, so they
	    sit at the top of the list in that order; the tabs then nest under the
	    IDs they handed back, in tab order. A Tracked Abilities page sits one
	    level further down, under its tab.
	]]
	local groupIDs = {}
	for _, group in ipairs(ns.FEATURE_GROUPS) do
		groupIDs[group.key] =
			AddSubPanel(registry[group.registry], ns.BuildFeatureGroupOptions(group), L[group.labelKey], mainCategoryID)
	end
	local monitoringID, naughtyListID = groupIDs.monitoring, groupIDs.naughtyList

	local tauntsID = AddSubPanel(registry.Taunts, ns.BuildTauntsOptions(), L["TAB_TAUNTS"], monitoringID)
	AddSubPanel(registry.TauntsTracked, ns.BuildTauntsTrackedOptions(), L["TRACKED_HEADER"], tauntsID)

	AddSubPanel(registry.Interrupts, ns.BuildInterruptsOptions(), L["TAB_INTERRUPTS"], monitoringID)

	local fearsID = AddSubPanel(registry.Fears, ns.BuildFearsOptions(), L["TAB_FEARS"], monitoringID)
	AddSubPanel(registry.FearsTracked, ns.BuildFearsTrackedOptions(), L["TRACKED_HEADER"], fearsID)

	--[[
	    Directly under Fears, because the two are the same news read from opposite
	    ends: a fear scattering the pull, and the tank it landed on saying so.
	]]
	AddSubPanel(registry.Incapacitated, ns.BuildIncapacitatedOptions(), L["TAB_INCAPACITATED"], monitoringID)

	--[[
	    Next after Incapacitated, because the two are one step apart: losing
	    control of your character, then losing it for good.
	]]
	AddSubPanel(registry.TankDeaths, ns.BuildTankDeathsOptions(), L["TAB_TANK_DEATHS"], monitoringID)

	--[[
	    Last of the Monitoring tabs, as the General panel's Features block lists
	    it: the one whose news is not the fight going wrong, but a classmate
	    pressing a cooldown so the player can press theirs.
	]]
	local peerPressureID =
		AddSubPanel(registry.PeerPressure, ns.BuildPeerPressureOptions(), L["TAB_PEER_PRESSURE"], monitoringID)
	AddSubPanel(registry.PeerPressureTracked, ns.BuildPeerPressureTrackedOptions(), L["TRACKED_HEADER"], peerPressureID)

	--[[
	    The four Bad tabs sit together, alphabetically, as the General panel's
	    Naughty List draws them: they are the ones about somebody in the group
	    doing something wrong, where everything above them reports what
	    happened.
	]]
	AddSubPanel(registry.BadMages, ns.BuildBadMagesOptions(), L["TAB_BAD_MAGES"], naughtyListID)

	AddSubPanel(registry.BadParryMonkeys, ns.BuildBadParryMonkeysOptions(), L["TAB_BAD_PARRY_MONKEYS"], naughtyListID)

	local badPetsID = AddSubPanel(registry.BadPets, ns.BuildBadPetsOptions(), L["TAB_BAD_PETS"], naughtyListID)
	AddSubPanel(registry.BadPetsTracked, ns.BuildBadPetsTrackedOptions(), L["TRACKED_HEADER"], badPetsID)

	--[[
	    Registered on every flavor, Season of Discovery included, where a status
	    line says a priest rune gives the rage back, rather than the tab hiding itself.
	]]
	AddSubPanel(registry.BadPriests, ns.BuildBadPriestsOptions(), L["TAB_BAD_PRIESTS"], naughtyListID)

	--[[
	    Last of the feature tabs, below Naughty List, because its tools are still
	    in beta and it ships switched off. A tab nobody has opted into yet does
	    not belong in the middle of the ones that work. ns.FEATURE_KEYS carries
	    the same order; keep the two in step.
	]]
	local tankingToolsID =
		AddSubPanel(registry.TankingTools, ns.BuildTankingToolsOptions(), L["TAB_TANKING_TOOLS"], mainCategoryID)

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
