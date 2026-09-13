local _, ns = ...

local L = ns.L
local GetColor = ns.GetColor

local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")

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

	tooltip:AddDoubleLine(GetColor("TITLE") .. L["ADDON_TITLE"] .. "|r", StateText(profile and profile.enabled))
	tooltip:AddLine(GetColor("BODY") .. L["KILL_SWITCH_ENABLE_DESC"] .. "|r", 1, 1, 1, true)
	tooltip:AddDoubleLine(GetColor("INFO") .. L["LEFT_CLICK"] .. "|r", GetColor("INFO") .. L["ACTION_TOGGLE"] .. "|r")

	--[[
	    The add-on's own switch unregisters the combat log outright, so with it off
	    Bad Pets cannot fire whatever its own setting says. Showing the block would
	    be advertising a toggle that changes nothing, so it goes with everything else.

	    Bad Pets is the only feature with a block and a binding, and it earns
	    them by whispering pet owners out of the box: a tank may need to hush it
	    mid-run. Bad Priests had both until 2026-09-12 and lost them because it
	    ships with nothing that reaches anybody else -- its whisper off and its
	    warning printing to the player's own window -- so a quick switch here had
	    nothing to hush, and one feature toggle keeps the tooltip short.
	]]
	if profile and profile.enabled then
		tooltip:AddLine(" ")
		tooltip:AddDoubleLine(GetColor("TITLE") .. L["TAB_BAD_PETS"] .. "|r", StateText(profile.badPets.enabled))
		tooltip:AddLine(GetColor("BODY") .. L["BAD_PETS_SUMMARY"] .. "|r", 1, 1, 1, true)
		tooltip:AddDoubleLine(
			GetColor("INFO") .. L["RIGHT_CLICK"] .. "|r",
			GetColor("INFO") .. L["ACTION_TOGGLE"] .. "|r"
		)
	end

	tooltip:AddLine(" ")
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
		    Both bindings flip an `enabled` and therefore go through
		    ns:ApplyProfile rather than a bare NotifyChange. That flag decides
		    whether COMBAT_LOG_EVENT_UNFILTERED is registered at all, so setting it
		    without re-running the registration test would leave the add-on hooked
		    into every combat line for a feature the player just switched off -- or
		    unhooked from one they just switched on. ApplyProfile also notifies every
		    panel, so the open options page follows along.

		    Right-Click is ignored while the add-on's own switch is off, matching
		    the tooltip: the block is not drawn, so the binding is not on offer.

		    A shifted Left- or Right-Click is ignored rather than read as the plain
		    click: the tooltip advertises three bindings, and a click that matches
		    none of them does nothing. Shift + Left-Click used to toggle Bad
		    Priests, so treating it as a plain Left-Click would hand anybody with
		    that habit the add-on's own switch instead.
		]]
		if IsShiftKeyDown() then
			return
		end

		local profile = ns.db.profile

		if button == "RightButton" then
			if profile.enabled then
				profile.badPets.enabled = not profile.badPets.enabled
				ns:ApplyProfile()
				Refresh()
			end
			return
		end

		if button == "LeftButton" then
			profile.enabled = not profile.enabled
			ns:ApplyProfile()
			Refresh()
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
