local ADDON_NAME, ns = ...

--------------------------------------------------------------------------------
-- Version
--------------------------------------------------------------------------------

-- The nil branch is load-bearing: an unpackaged metadata read comes back nil,
-- and testing "@" first would error on exactly the local-dev path.
local version = C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version")
if not version or version:find("@", 1, true) then
	version = "Dev"
end
ns.Version = version

--------------------------------------------------------------------------------
-- Event Dispatch
--------------------------------------------------------------------------------

ns.EVENT_NAMES = {
	"PLAYER_LOGIN",
	"PLAYER_ENTERING_WORLD",
	"GROUP_ROSTER_UPDATE",
	"ZONE_CHANGED_NEW_AREA",
	"CHAT_MSG_ADDON",
	"UNIT_SPELLCAST_INTERRUPTED",
	"COMBAT_LOG_EVENT_UNFILTERED",
}

-- Feature files append the per-fight state they need cleared on every loading
-- screen; Core runs the list on PLAYER_ENTERING_WORLD.
ns.stateResets = {}

local frame = CreateFrame("Frame")
ns.eventFrame = frame

frame:SetScript("OnEvent", function(_, event, ...)
	if ns.diagnostics and ns.diagnostics.logging then
		ns:LogEvent(event, ...)
	end
	local handler = ns[event]
	if handler then
		handler(ns, ...)
	end
end)

-- COMBAT_LOG_EVENT_UNFILTERED is owned by ns:UpdateCombatLogRegistration, so a
-- disabled or out-of-scope add-on is not woken for every combat line.
for _, event in ipairs(ns.EVENT_NAMES) do
	if event ~= "COMBAT_LOG_EVENT_UNFILTERED" then
		frame:RegisterEvent(event)
	end
end

--------------------------------------------------------------------------------
-- Saved Variables
--------------------------------------------------------------------------------

function ns:ApplyProfile()
	ns:UpdateCombatLogRegistration()
	ns:ApplyMinimapButton()

	local registry = LibStub("AceConfigRegistry-3.0")
	for _, name in pairs(ns.OPTIONS_REGISTRY) do
		registry:NotifyChange(name)
	end
end

function ns:PLAYER_LOGIN()
	ns.db = LibStub("AceDB-3.0"):New("ControlFreakDB", ns.DATABASE_DEFAULTS, true)

	for _, message in ipairs({ "OnProfileChanged", "OnProfileReset", "OnProfileCopied" }) do
		ns.db.RegisterCallback(ns, message, "ApplyProfile")
	end

	ns.playerGUID = UnitGUID("player")

	C_ChatInfo.RegisterAddonMessagePrefix(ns.ADDON_MESSAGE_PREFIX)

	-- Before the panels, which draw the ability rows it produces.
	ns.BuildAbilityIndex()

	ns.RegisterOptionsPanels()
	ns:RegisterMinimapButton()
	ns:ApplyProfile()
	ns:PrintWelcome()
end

--------------------------------------------------------------------------------
-- World State
--------------------------------------------------------------------------------

function ns:PLAYER_ENTERING_WORLD()
	for _, reset in ipairs(ns.stateResets) do
		reset()
	end
	ns:UpdateCombatLogRegistration()
end

function ns:GROUP_ROSTER_UPDATE()
	ns:UpdateCombatLogRegistration()
end

function ns:ZONE_CHANGED_NEW_AREA()
	ns:UpdateCombatLogRegistration()
end
