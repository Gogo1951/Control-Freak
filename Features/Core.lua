local ADDON_NAME, ns = ...

--------------------------------------------------------------------------------
-- Version
--------------------------------------------------------------------------------

--[[
    The nil branch is load-bearing: an unpackaged metadata read comes back nil,
    and testing "@" first would error on exactly the local-dev path.
]]
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
	"ZONE_CHANGED_NEW_AREA",
	"CHAT_MSG_ADDON",
	"UNIT_SPELLCAST_INTERRUPTED",
	-- Joining a raid group restarts Parry Monkey's count.
	"GROUP_ROSTER_UPDATE",
	--[[
	    The one alert not driven by the combat log, so it is registered flat like
	    the rest rather than through UpdateCombatLogRegistration. It fires only
	    when the player is actually crowd controlled, which is rare enough that
	    gating the registration would cost more than it saves, and its handler
	    asks the Incapacitated tab's own scope gates itself.
	]]
	"LOSS_OF_CONTROL_ADDED",
	"COMBAT_LOG_EVENT_UNFILTERED",
}

--[[
    Feature files append the per-fight state they need cleared on every loading
    screen; Core runs the list on PLAYER_ENTERING_WORLD.
]]
ns.stateResets = {}

-- Each event's handler name, built once: PLAYER_LOGIN is handled by ns:OnPlayerLogin.
local EVENT_HANDLERS = {}
for _, event in ipairs(ns.EVENT_NAMES) do
	EVENT_HANDLERS[event] = "On"
		.. event:lower():gsub("(%a)(%a*)_?", function(first, rest)
			return first:upper() .. rest
		end)
end

local frame = CreateFrame("Frame")
ns.eventFrame = frame

frame:SetScript("OnEvent", function(_, event, ...)
	if ns.diagnostics and ns.diagnostics.logging then
		ns:LogEvent(event, ...)
	end
	local name = EVENT_HANDLERS[event]
	local handler = name and ns[name]
	if handler then
		handler(ns, ...)
	end
end)

--[[
    COMBAT_LOG_EVENT_UNFILTERED is owned by UpdateCombatLogRegistration, so a
    disabled or out-of-scope add-on is not woken for every combat line.
]]
for _, event in ipairs(ns.EVENT_NAMES) do
	if event ~= "COMBAT_LOG_EVENT_UNFILTERED" then
		frame:RegisterEvent(event)
	end
end

local function UpdateCombatLogRegistration()
	if ns:IsAlertGateOpen() then
		frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	else
		frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end
end

--------------------------------------------------------------------------------
-- Saved Variables
--------------------------------------------------------------------------------

--[[
    MIGRATION (remove after 2026-11-27): Parries left Tanking Tools for the Bad
    Parry Monkeys tab. A player who tuned the section keeps their settings, and
    one who had it running (Tanking Tools on, Parries not switched off) keeps it
    running, with Tanking Tools' scope answers and the whisper the old section
    shipped on. The flag stops it running twice,
    since a profile that never saved a Parries change leaves nothing to clear.
]]
local function MergeInto(target, source)
	for key, value in pairs(source) do
		if type(value) == "table" and type(target[key]) == "table" then
			MergeInto(target[key], value)
		else
			target[key] = value
		end
	end
end

local function MigrateParries(profile)
	if profile.parriesMigrated then
		return
	end
	profile.parriesMigrated = true

	local tankingTools = profile.tankingTools
	local old = tankingTools.parry
	tankingTools.parry = nil

	local feature = profile.badParryMonkeys
	if old then
		MergeInto(feature.alert, old)
	end
	if tankingTools.enabled then
		feature.enabled = true
		feature.alert.whisper = not (old and old.whisper == false)
		feature.roleScope = tankingTools.roleScope
		feature.groupHasTank = tankingTools.groupHasTank
		feature.instanceOnly = tankingTools.instanceOnly
	end
end

--[[
    MIGRATION (remove after 2026-11-27): an alert row's one destination,
    { enabled, output }, became { print, announce }. A row switched off stays
    off. Otherwise it keeps printing, and an old Party Only or whole-group
    announce keeps announcing there, with the print as its fallback. A row the
    profile never changed holds neither old key, and the new defaults already
    mean what the old ones did. Runs after MigrateParries, which can carry an
    old-shape row into Bad Parry Monkeys.
]]
local OLD_OUTPUT_ANNOUNCE = { PRINT = "NEVER", PARTY = "PARTY", ANNOUNCE = "GROUP" }
local ROW_KEYS = { "mine", "others", "short", "long" }

local function MigrateRowOutputs(profile)
	for _, featureKey in ipairs(ns.FEATURE_KEYS) do
		for _, section in pairs(profile[featureKey]) do
			if type(section) == "table" then
				for _, rowKey in ipairs(ROW_KEYS) do
					local row = section[rowKey]
					if type(row) == "table" and (row.output ~= nil or row.enabled ~= nil) then
						if row.enabled == false then
							row.print, row.announce = false, "NEVER"
						else
							row.print, row.announce = true, OLD_OUTPUT_ANNOUNCE[row.output] or "NEVER"
						end
						row.enabled, row.output = nil, nil
					end
				end
			end
		end
	end
end

function ns:ApplyProfile()
	MigrateParries(ns.db.profile) -- MIGRATION (remove after 2026-11-27)
	MigrateRowOutputs(ns.db.profile) -- MIGRATION (remove after 2026-11-27)
	UpdateCombatLogRegistration()
	ns:ApplyMinimapButton()

	local registry = LibStub("AceConfigRegistry-3.0")
	for _, name in pairs(ns.OPTIONS_REGISTRY) do
		registry:NotifyChange(name)
	end
end

--------------------------------------------------------------------------------
-- PLAYER_LOGIN
--------------------------------------------------------------------------------

function ns:OnPlayerLogin()
	ns.db = LibStub("AceDB-3.0"):New(ns.SAVED_VARIABLES_NAME, ns.DATABASE_DEFAULTS, true)

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
-- PLAYER_ENTERING_WORLD, ZONE_CHANGED_NEW_AREA
--------------------------------------------------------------------------------

function ns:OnPlayerEnteringWorld()
	for _, reset in ipairs(ns.stateResets) do
		reset()
	end
	UpdateCombatLogRegistration()
end

function ns:OnZoneChangedNewArea()
	UpdateCombatLogRegistration()
end
