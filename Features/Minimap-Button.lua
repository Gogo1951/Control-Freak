local _, ns = ...

local L = ns.L
local GetColor = ns.GetColor

local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")

--------------------------------------------------------------------------------
-- Blocks
--------------------------------------------------------------------------------

--[[
    One block per click, in tooltip order: the two General panel groups and
    Tanking Tools, the three switches the Features block draws in gold. Each
    summary names everything its switch reaches, so a player sees what there is
    to turn on before opening the panel.
]]
local function GroupBlock(groupKey, labelKey, summaryKey, bindingKey, button, shift)
	return {
		labelKey = labelKey,
		summaryKey = summaryKey,
		bindingKey = bindingKey,
		button = button,
		shift = shift,
		isOn = function(profile)
			return profile.featureGroups[groupKey] ~= false
		end,
		toggle = function(profile)
			profile.featureGroups[groupKey] = profile.featureGroups[groupKey] == false
		end,
	}
end

local BLOCKS = {
	GroupBlock(
		"monitoring",
		"OPTIONS_MONITORING_LABEL",
		"MONITORING_MINIMAP_SUMMARY",
		"LEFT_CLICK",
		"LeftButton",
		false
	),
	GroupBlock(
		"naughtyList",
		"OPTIONS_NAUGHTY_LIST_LABEL",
		"NAUGHTY_LIST_MINIMAP_SUMMARY",
		"RIGHT_CLICK",
		"RightButton",
		false
	),
	{
		labelKey = "TAB_TANKING_TOOLS",
		summaryKey = "TANKING_TOOLS_MINIMAP_SUMMARY",
		bindingKey = "MINIMAP_SHIFT_LEFT_CLICK",
		button = "LeftButton",
		shift = true,
		isOn = function(profile)
			return profile.tankingTools.enabled
		end,
		toggle = function(profile)
			profile.tankingTools.enabled = not profile.tankingTools.enabled
		end,
	},
}

--------------------------------------------------------------------------------
-- Tooltip
--------------------------------------------------------------------------------

local function RefreshTooltip(anchor)
	local tooltip = GameTooltip

	tooltip:SetOwner(anchor, "ANCHOR_BOTTOMLEFT")
	tooltip:ClearLines()

	tooltip:AddDoubleLine(GetColor("TITLE") .. L["ADDON_TITLE"] .. "|r", GetColor("MUTED") .. ns.Version .. "|r")
	tooltip:AddLine(" ")
	tooltip:AddLine(" ")

	local function StateText(value)
		if value then
			return GetColor("ON") .. L["STATE_ON"] .. "|r"
		end
		return GetColor("OFF") .. L["STATE_OFF"] .. "|r"
	end

	local profile = ns.db and ns.db.profile

	--[[
	    All Alerts has no binding, so it has no block. With it off nothing fires
	    whatever the three switches say, so their blocks would advertise clicks
	    that change nothing: they go, and one line says why.
	]]
	if profile and profile.enabled then
		for _, block in ipairs(BLOCKS) do
			tooltip:AddDoubleLine(GetColor("TITLE") .. L[block.labelKey] .. "|r", StateText(block.isOn(profile)))
			tooltip:AddLine(GetColor("BODY") .. L[block.summaryKey] .. "|r", 1, 1, 1, true)
			tooltip:AddDoubleLine(
				GetColor("INFO") .. L[block.bindingKey] .. "|r",
				GetColor("INFO") .. L["ACTION_TOGGLE"] .. "|r"
			)
			tooltip:AddLine(" ")
		end
	else
		tooltip:AddLine(GetColor("OFF") .. L["MINIMAP_ALL_ALERTS_OFF"] .. "|r", 1, 1, 1, true)
		tooltip:AddLine(" ")
	end

	tooltip:AddLine(GetColor("TITLE") .. L["MINIMAP_OPTIONS"] .. "|r")
	tooltip:AddLine(GetColor("INFO") .. L["SHIFT_MIDDLE_CLICK"] .. "|r")

	tooltip:Show()
end

--------------------------------------------------------------------------------
-- LDB Data Object
--------------------------------------------------------------------------------

ns.LDBObject = LibDataBroker:NewDataObject(ns.LOCALE_NAME, {
	type = "launcher",
	text = L["ADDON_TITLE"],
	icon = ns.MINIMAP_ICON,
	iconCoords = ns.MINIMAP_ICON_COORDS,

	OnClick = function(self, button)
		--[[
		    Shift + Middle-Click runs first, before any feature button. The combat
		    refusal lives inside the opener; never duplicate it here.
		]]
		if IsShiftKeyDown() and button == "MiddleButton" then
			ns:OpenOptionsPanel()
			return
		end

		if not ns.db then
			return
		end

		-- Re-render in place so the state updates under the cursor.
		local function Refresh()
			if GameTooltip:GetOwner() == self then
				RefreshTooltip(self)
			end
		end

		--[[
		    Every binding flips a switch that decides whether
		    COMBAT_LOG_EVENT_UNFILTERED is registered at all, so it goes through
		    ns:ApplyProfile rather than a bare NotifyChange: setting it without
		    re-running the registration test would leave the add-on hooked into
		    every combat line for a feature the player just switched off, or
		    unhooked from one they just switched on. ApplyProfile also notifies
		    every panel, so the open options page follows along.

		    Every binding is ignored while All Alerts is off, matching the tooltip,
		    which draws no blocks then. A click that matches no block, a shifted
		    Right-Click included, does nothing.
		]]
		local profile = ns.db.profile
		if not profile.enabled then
			return
		end

		local shift = IsShiftKeyDown()
		for _, block in ipairs(BLOCKS) do
			if block.button == button and block.shift == shift then
				block.toggle(profile)
				ns:ApplyProfile()
				Refresh()
				return
			end
		end
	end,

	OnEnter = function(self)
		RefreshTooltip(self)
	end,

	OnLeave = function()
		GameTooltip:Hide()
	end,
})

--------------------------------------------------------------------------------
-- Registration
--------------------------------------------------------------------------------

--[[
    Called from Core once ns.db exists: LibDBIcon writes the button's angle and
    hide flag into the subtable it is handed, so it cannot register before
    SavedVariables load.
]]
function ns:RegisterMinimapButton()
	if not LibDBIcon:IsRegistered(ns.LOCALE_NAME) then
		LibDBIcon:Register(ns.LOCALE_NAME, ns.LDBObject, ns.db.profile.minimap)
		--[[
		    The Retail engine leaves the square icon off-center in its ring.
		    Fitted by hand, not SetButtonIcon: its ResetButtonIcon calls icon:UpdateCoord(),
		    which errors when another add-on has replaced the button's icon.
		]]
		local button = LibDBIcon:GetMinimapButton(ns.LOCALE_NAME)
		if (ns.FLAVOR == "Camelot" or ns.FLAVOR == "Mainline") and button and button.icon then
			button.icon:SetSize(20, 20)
			button.icon:ClearAllPoints()
			button.icon:SetPoint("CENTER", 1, -0.35)
			local mask = button:CreateMaskTexture()
			mask:SetTexture(130924, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE") -- Interface\CharacterFrame\TempPortraitAlphaMask
			mask:SetAllPoints(button.icon)
			button.icon:AddMaskTexture(mask)
		end
	end
end

--[[
    Refresh, never Show/Hide. LibDBIcon holds a direct reference to the subtable
    it was registered with, and AceDB's ResetProfile empties the profile and
    copies fresh defaults in, which replaces the minimap subtable with a new
    table. Show/Hide alone would leave the button writing its position to the
    detached old one, so the move would never persist. Passing the current
    subtable to Refresh re-points the button and re-applies position and hide
    state in the same call.
]]
function ns:ApplyMinimapButton()
	if not ns.db or not LibDBIcon:IsRegistered(ns.LOCALE_NAME) then
		return
	end
	LibDBIcon:Refresh(ns.LOCALE_NAME, ns.db.profile.minimap)
end
