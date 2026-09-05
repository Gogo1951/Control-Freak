local _, ns = ...

--------------------------------------------------------------------------------
-- Diagnostic Tools
--------------------------------------------------------------------------------

--[[
    Environment probing and state capture for bug reports, not unit tests. WoW's
    sandboxed Lua has no assertion runner, so everything here is read-only and
    side-effect free. The one exception is the explicit Taint Log button, which
    sets the taintLog CVar. Reports build only on a button press, never on load
    or panel open.
]]

local L = ns.L

--------------------------------------------------------------------------------
-- Runtime State
--------------------------------------------------------------------------------

--[[
    Runtime-only state. NOT a SavedVariable. File-scope init is correct here —
    the "initialize on PLAYER_LOGIN" rule applies only to SavedVariables, which
    don't exist until the client loads them. This is a plain namespace table.
]]
ns.diagnostics = ns.diagnostics or { enabled = false, logging = false, log = nil }

--------------------------------------------------------------------------------
-- Strings
--------------------------------------------------------------------------------

--[[
    Diagnostics strings are intentionally NOT localized. They are
    developer-facing troubleshooting text; translating them is wasted effort for
    zero player value. Every diagnostics string lives here as plain English, in
    the diagnostics files only — never in Locales/. The one exception is the
    add-on's own display name, read from ns.L["ADDON_TITLE"], which is the
    add-on's identity, not a diagnostics string.
]]
ns.DiagnosticsStrings = {
	TAB = "Diagnostic Tools",
	WARNING = "These tools help diagnose problems and are meant for developers. They won't change how the add-on works, but their output includes technical details about your client and installed add-ons. Leave this off unless you're troubleshooting with someone.",
	ENABLE = "Enable Diagnostic Tools",
	EVENT_LOG_TITLE = "Event Log",
	EVENT_LOG_START = "Start Event Log",
	EVENT_LOG_STOP = "Stop Event Log",
	EVENT_LOG_SHOW = "Show Captured Events",
	EVENT_LOG_HINT = "Captures events the add-on registered for, with arguments, in order fired. The raw combat log is excluded; the alerts it matched are written in as they happen.",
	EVENTS_TITLE = "Event Registration",
	EVENTS_BUTTON = "Test Event Registration",
	API_TITLE = "API Endpoints",
	API_BUTTON = "Test WoW API Endpoints",
	GATE_TITLE = "Alert Gate",
	GATE_BUTTON = "Read Alert Gate State",
	DISPLAY_TITLE = "Display Context",
	DISPLAY_BUTTON = "Read Display Context",
	DATA_TITLE = "Validate Data: %s",
	DATA_BUTTON = "Validate Ability IDs",
	ADDONS_TITLE = "Other Add-ons",
	ADDONS_BUTTON = "List Installed Add-ons",
	SAVED_TITLE = "Saved Variables",
	SAVED_BUTTON = "Dump Saved Variables",
	LIBS_TITLE = "Library Versions",
	LIBS_BUTTON = "List Library Versions",
	TAINT_TITLE = "Taint Log",
	TAINT_STATE = "Taint logging is currently set to level %d (0 = off, 2 = verbose).",
	TAINT_ON = "Turn On Taint Log",
	TAINT_OFF = "Turn Off Taint Log",
	TAINT_HINT = "Writes to Logs\\taint.log. The setting persists until turned off; reload your UI to capture taint from login onward.",
	TOOLS_TITLE = "External Tools",
	TOOLS_ERRORS = "Lua errors: install BugSack and !BugGrabber, or enable %s to surface them.",
	TOOLS_ETRACE = "Live event tracing: use %s.",
}

--------------------------------------------------------------------------------
-- Enable Gate
--------------------------------------------------------------------------------

function ns:SetDiagnosticsEnabled(value)
	ns.diagnostics.enabled = value and true or false
	if not ns.diagnostics.enabled then
		ns:StopEventLog()
	end
end

--------------------------------------------------------------------------------
-- Report Header
--------------------------------------------------------------------------------

local function GetClientHeader()
	local version, build, _, tocVersion = GetBuildInfo()
	return string.format(
		"%s %s // Client %s // Build %s // TOC %s // Locale %s // Project %s // Flavor %s",
		L["ADDON_TITLE"],
		ns.Version,
		version,
		build,
		tocVersion,
		GetLocale(),
		tostring(WOW_PROJECT_ID),
		ns.GetFlavorName()
	)
end

--------------------------------------------------------------------------------
-- Event Log
--------------------------------------------------------------------------------

local EVENT_LOG_SIZE = 500
local EVENT_LOG_MAX_ARGS = 8
local EVENT_LOG_MAX_ARG_LENGTH = 255

--[[
    COMBAT_LOG_EVENT_UNFILTERED is the one firehose Control Freak registers, and
    it is pure noise raw: it fires on every swing in the zone and would evict the
    whole buffer between two taunts. It is dropped here, and Features/Combat-Log
    writes the firings it actually matched back through ns:LogEventNow, so the log
    still separates "the event never fired" from "it fired and nothing happened".
]]
ns.DIAGNOSTIC_EVENT_EXCLUDE = {
	COMBAT_LOG_EVENT_UNFILTERED = true,
}

--[[
    Events that carry a message id, and the argument position it arrives in.
    Empty: Control Freak registers nothing that needs per-id classification. The
    filter stays wired so adding such an event is a one-line change.
]]
ns.MESSAGE_ID_FILTERED_EVENTS = {}

function ns:SuppressUncorrelatedMessage(event, ...)
	local idPosition = ns.MESSAGE_ID_FILTERED_EVENTS[event]
	if not idPosition then
		return false
	end
	local messageID = select(idPosition, ...)
	if type(messageID) ~= "number" then
		return false
	end
	local suppressed = ns.diagnostics.suppressed
	if not suppressed then
		return true
	end
	local entry = suppressed[messageID]
	if entry then
		entry.count = entry.count + 1
		return true
	end
	local text = ""
	if select("#", ...) > idPosition then
		local raw = string.sub(tostring((select(idPosition + 1, ...))), 1, EVENT_LOG_MAX_ARG_LENGTH)
		text = (raw:gsub("|", "||"))
	end
	suppressed[messageID] = { event = event, text = text, count = 1 }
	return true
end

function ns:StartEventLog()
	ns.diagnostics.log = {}
	ns.diagnostics.suppressed = {}
	ns.diagnostics.logging = true
end

function ns:StopEventLog()
	ns.diagnostics.logging = false
	ns.diagnostics.log = nil
	ns.diagnostics.suppressed = nil
end

local function AppendEntry(event, ...)
	local parts = {}
	for index = 1, select("#", ...) do
		if index > EVENT_LOG_MAX_ARGS then
			break
		end
		local raw = string.sub(tostring((select(index, ...))), 1, EVENT_LOG_MAX_ARG_LENGTH)
		parts[index] = (raw:gsub("|", "||"))
	end
	local log = ns.diagnostics.log
	log[#log + 1] = string.format("%.3f %s(%s)", GetTime(), event, table.concat(parts, ", "))
	if #log > EVENT_LOG_SIZE then
		table.remove(log, 1)
	end
end

--[[
    Called by Core's dispatcher for every event while logging is active.
    Snapshots arguments to strings immediately — never retain references, since
    some events carry frames or tables that would leak memory or go stale. Caps
    the arg count and string length so a single entry can't run away.

    Pipes are escaped (| -> ||) AFTER the length cut so each argument shows
    verbatim in the report editbox, and so a cut can never leave a dangling pipe
    that would eat the following ", " separator.
]]
function ns:LogEvent(event, ...)
	if ns.DIAGNOSTIC_EVENT_EXCLUDE[event] then
		return
	end
	if ns:SuppressUncorrelatedMessage(event, ...) then
		return
	end
	AppendEntry(event, ...)
end

-- The escape hatch for an excluded firehose: a handler that decided a firing was
-- signal writes it in directly, bypassing the exclude list.
function ns:LogEventNow(event, ...)
	if not ns.diagnostics.logging or not ns.diagnostics.log then
		return
	end
	AppendEntry(event, ...)
end

local function AppendSuppressedSummary(lines)
	local suppressed = ns.diagnostics.suppressed
	if not suppressed then
		return
	end
	local rows = {}
	for messageID, entry in pairs(suppressed) do
		rows[#rows + 1] = { id = messageID, entry = entry }
	end
	if #rows == 0 then
		return
	end
	table.sort(rows, function(a, b)
		if a.entry.count ~= b.entry.count then
			return a.entry.count > b.entry.count
		end
		return a.id < b.id
	end)
	lines[#lines + 1] = ""
	lines[#lines + 1] = "Suppressed uncorrelated traffic:"
	for _, row in ipairs(rows) do
		lines[#lines + 1] = string.format("%s(%d, %s) x%d", row.entry.event, row.id, row.entry.text, row.entry.count)
	end
end

function ns:BuildEventLogReport()
	local lines = { GetClientHeader(), "" }
	local log = ns.diagnostics.log
	if not log or #log == 0 then
		lines[#lines + 1] = "(no events captured)"
	else
		for _, entry in ipairs(log) do
			lines[#lines + 1] = entry
		end
	end
	AppendSuppressedSummary(lines)
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Event Registration
--------------------------------------------------------------------------------

--[[
    For every event Control Freak registers (ns.EVENT_NAMES, exported by
    Core.lua), report whether it is valid on this client and whether
    RegisterEvent succeeds. The probe frame registers then immediately
    unregisters each event with no handler attached, so nothing is ever
    processed. The list is sourced from Core so it can never drift from the
    events the add-on actually uses.
]]

local probeFrame

local function GetProbeFrame()
	if not probeFrame then
		probeFrame = CreateFrame("Frame")
	end
	return probeFrame
end

function ns:RunEventChecks()
	local lines = { GetClientHeader(), "" }
	local probe = GetProbeFrame()
	local failures = 0
	for _, event in ipairs(ns.EVENT_NAMES or {}) do
		local valid = C_EventUtils.IsEventValid(event) and "valid" or "INVALID"
		local ok = pcall(probe.RegisterEvent, probe, event)
		if ok then
			probe:UnregisterEvent(event)
		else
			failures = failures + 1
		end
		lines[#lines + 1] = string.format("[%s] %s (IsEventValid: %s)", ok and "PASS" or "FAIL", event, valid)
	end
	lines[#lines + 1] = ""
	if failures == 0 then
		lines[#lines + 1] = "All events register on this client."
	else
		lines[#lines + 1] = string.format("%d event(s) failed to register.", failures)
	end
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- API Endpoints
--------------------------------------------------------------------------------

--[[
    Existence and shape checks only: read-only, no side effects, no protected
    calls. One row per API the add-on actually calls, plus every API reached
    through an availability guard, so a FAIL names the guard that is about to
    take the fallback path rather than leaving it silent.
]]
ns.DIAGNOSTIC_API_CHECKS = {
	-- { label, testFunction }
	{
		"CombatLogGetCurrentEventInfo",
		function()
			return type(CombatLogGetCurrentEventInfo) == "function"
		end,
	},
	{
		"C_Spell.GetSpellLink (modern path)",
		function()
			return type(C_Spell) == "table" and type(C_Spell.GetSpellLink) == "function"
		end,
	},
	{
		"GetSpellLink (legacy fallback)",
		function()
			return type(GetSpellLink) == "function"
		end,
	},
	{
		"C_Spell.GetSpellInfo (modern path)",
		function()
			return type(C_Spell) == "table" and type(C_Spell.GetSpellInfo) == "function"
		end,
	},
	{
		"GetSpellInfo (legacy fallback)",
		function()
			return type(GetSpellInfo) == "function"
		end,
	},
	{
		"C_AddOns.GetAddOnMetadata",
		function()
			return type(C_AddOns) == "table" and type(C_AddOns.GetAddOnMetadata) == "function"
		end,
	},
	{
		"Settings.OpenToCategory",
		function()
			return type(Settings) == "table" and type(Settings.OpenToCategory) == "function"
		end,
	},
	{
		"C_Engraving.IsEngravingEnabled (Season of Discovery probe)",
		function()
			return type(C_Engraving) == "table" and type(C_Engraving.IsEngravingEnabled) == "function"
		end,
	},
	{
		"C_NamePlate.GetNamePlates (boss filter fallback)",
		function()
			return type(C_NamePlate) == "table" and type(C_NamePlate.GetNamePlates) == "function"
		end,
	},
	{
		"GetPartyAssignment",
		function()
			return type(GetPartyAssignment) == "function"
		end,
	},
	{
		"UnitGroupRolesAssigned (group finder role)",
		function()
			return type(UnitGroupRolesAssigned) == "function"
		end,
	},
	{
		"GetPlayerInfoByGUID",
		function()
			return type(GetPlayerInfoByGUID) == "function"
		end,
	},
	{
		"Ambiguate",
		function()
			return type(Ambiguate) == "function"
		end,
	},
	{
		"PlaySoundFile",
		function()
			return type(PlaySoundFile) == "function"
		end,
	},
	{
		"SendChatMessage",
		function()
			return type(SendChatMessage) == "function"
		end,
	},
	{
		"C_ChatInfo.SendAddonMessage",
		function()
			return type(C_ChatInfo) == "table" and type(C_ChatInfo.SendAddonMessage) == "function"
		end,
	},
	{
		"C_ChatInfo.RegisterAddonMessagePrefix",
		function()
			return type(C_ChatInfo) == "table" and type(C_ChatInfo.RegisterAddonMessagePrefix) == "function"
		end,
	},
	{
		"LibSharedMedia-3.0",
		function()
			return LibStub("LibSharedMedia-3.0") ~= nil
		end,
	},
	{
		"LibDataBroker-1.1",
		function()
			return LibStub("LibDataBroker-1.1") ~= nil
		end,
	},
	{
		"LibDBIcon-1.0",
		function()
			return LibStub("LibDBIcon-1.0") ~= nil
		end,
	},
	{
		"Combat log affiliation constants",
		function()
			return type(COMBATLOG_OBJECT_AFFILIATION_MASK) == "number"
				and type(COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) == "number"
				and type(COMBATLOG_OBJECT_TYPE_PET) == "number"
				and type(COMBATLOG_OBJECT_TYPE_GUARDIAN) == "number"
				and type(COMBATLOG_OBJECT_RAIDTARGET_MASK) == "number"
		end,
	},
}

function ns:RunApiChecks()
	local lines = { GetClientHeader(), "" }
	for _, check in ipairs(ns.DIAGNOSTIC_API_CHECKS) do
		local ok, result = pcall(check[2])
		lines[#lines + 1] = ((ok and result) and "[PASS] " or "[FAIL] ") .. check[1]
	end
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Alert Gate
--------------------------------------------------------------------------------

--[[
    Control Freak's own context probe, and the first thing to read on a "nothing
    ever fires" report. Scope is per feature, so this prints all four scope
    settings and the resulting verdict for each one, then the live world state
    they were measured against and whether COMBAT_LOG_EVENT_UNFILTERED is actually
    on the frame. Main Tank assignments ride along because "Only When Playing a
    Tank" and "Only When Group Has a Tank" both read them, and a tab with either
    set goes silent with nobody assigned. All reads.
]]
function ns:BuildAlertGateReport()
	local lines = { GetClientHeader(), "" }
	local profile = ns.db and ns.db.profile

	if not profile then
		lines[#lines + 1] = "ns.db is not initialized."
		return table.concat(lines, "\n")
	end

	local inInstance, instanceType = IsInInstance()
	lines[#lines + 1] = string.format("enabled (master) = %s", tostring(profile.enabled))
	lines[#lines + 1] = ""
	for _, key in ipairs(ns.FEATURE_KEYS) do
		local feature = profile[key]
		if type(feature) ~= "table" then
			lines[#lines + 1] = string.format("%s: missing from the profile", key)
		else
			-- Only the scope questions this feature actually asks, in the order its
			-- tab draws them. A key printed for a tab that never shows it reads as
			-- a setting the player could not find.
			local scope = {}
			for _, option in ipairs(ns.FEATURE_SCOPE_OPTIONS[key]) do
				scope[#scope + 1] = option .. "=" .. tostring(feature[option])
			end
			lines[#lines + 1] = string.format(
				"%s: enabled=%s %s -> IsFeatureGateOpen=%s",
				key,
				tostring(feature.enabled),
				table.concat(scope, " "),
				tostring(ns:IsFeatureGateOpen(feature))
			)
		end
	end
	lines[#lines + 1] = ""
	lines[#lines + 1] = string.format("IsInGroup() = %s", tostring(IsInGroup()))
	lines[#lines + 1] = string.format("IsInRaid() = %s", tostring(IsInRaid()))
	lines[#lines + 1] = string.format("IsInInstance() = %s, %s", tostring(inInstance), tostring(instanceType))
	lines[#lines + 1] = ""
	lines[#lines + 1] = string.format("ns:IsAlertGateOpen() = %s", tostring(ns:IsAlertGateOpen()))
	lines[#lines + 1] = string.format(
		"COMBAT_LOG_EVENT_UNFILTERED registered = %s",
		tostring(ns.eventFrame:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED") and true or false)
	)

	lines[#lines + 1] = ""
	local tanks = {}
	if ns.IsUnitTank("player") then
		tanks[#tanks + 1] = "player (" .. tostring(GetUnitName("player", true)) .. ")"
	end
	if IsInRaid() then
		for index = 1, GetNumGroupMembers() do
			local unit = "raid" .. index
			if ns.IsUnitTank(unit) then
				tanks[#tanks + 1] = unit .. " (" .. tostring(GetUnitName(unit, true)) .. ")"
			end
		end
	elseif IsInGroup() then
		for index = 1, 4 do
			local unit = "party" .. index
			if ns.IsUnitTank(unit) then
				tanks[#tanks + 1] = unit .. " (" .. tostring(GetUnitName(unit, true)) .. ")"
			end
		end
	end
	if #tanks == 0 then
		lines[#lines + 1] =
			"Tanks: none by Main Tank assignment or group finder role (a tab with either tank scope set never fires without one)"
	else
		lines[#lines + 1] = "Tanks (Main Tank assignment or TANK role): " .. table.concat(tanks, ", ")
	end
	lines[#lines + 1] = string.format("ns.GroupHasTank() = %s (a tank must also be alive)", tostring(ns.GroupHasTank()))

	lines[#lines + 1] = ""
	lines[#lines + 1] =
		string.format("LibSharedMedia sounds available = %d", #LibStub("LibSharedMedia-3.0"):List("sound"))

	local ignoredCount = 0
	for _ in pairs(profile.ignoredSpells) do
		ignoredCount = ignoredCount + 1
	end
	lines[#lines + 1] = string.format("Ignored ability IDs = %d", ignoredCount)

	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Display Context
--------------------------------------------------------------------------------

--[[
    What a "my mini-map button is gone" or "it is off the edge of the screen"
    report needs: the resolution and scale the saved angle was chosen against,
    and the saved state itself. The button is read through LibDBIcon rather than
    created, so this report never brings one into existence as a side effect.
]]
function ns:BuildDisplayReport()
	local lines = { GetClientHeader(), "" }
	local screenWidth, screenHeight = GetPhysicalScreenSize()
	lines[#lines + 1] =
		string.format("GetPhysicalScreenSize() = %s x %s", tostring(screenWidth), tostring(screenHeight))
	lines[#lines + 1] = string.format("UIParent:GetScale() = %s", tostring(UIParent:GetScale()))
	lines[#lines + 1] = string.format("uiScale CVar = %s", tostring(C_CVar.GetCVar("uiScale")))

	lines[#lines + 1] = ""
	local saved = ns.db and ns.db.profile.minimap
	if saved then
		lines[#lines + 1] = string.format(
			"Saved mini-map state: hide=%s minimapPos=%s",
			tostring(saved.hide),
			tostring(saved.minimapPos)
		)
	else
		lines[#lines + 1] = "Saved mini-map state: unavailable (ns.db is not initialized)"
	end

	local button = LibStub("LibDBIcon-1.0"):GetMinimapButton(ns.LOCALE_NAME)
	if button then
		lines[#lines + 1] = string.format("Live mini-map button: shown=%s", tostring(button:IsShown()))
	else
		lines[#lines + 1] = "Live mini-map button: not registered this session"
	end

	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Validate Data
--------------------------------------------------------------------------------

--[[
    One manifest row per static data file, so the validator can never drift from
    what the add-on ships. Adding a data file adds a row here and a section on
    the panel.
]]
ns.DIAGNOSTIC_DATA_SOURCES = {
	--[[
	    { label, table, kind, idField, isTracked }
	      idField    the field on each entry holding that entry's ids
	      isTracked  given an id, whether this client currently watches it
	]]
	{
		"Data/Abilities.lua",
		ns.ABILITIES,
		"spell",
		"triggers",
		function(spellId)
			return ns.ABILITY_MAP[spellId] ~= nil
		end,
	},
	{
		"Data/Data.lua",
		ns.ARMOR_DEBUFFS,
		"spell",
		"ids",
		ns.IsArmorDebuffSpell,
	},
}

--[[
    Exports everything this client knows about every ability ID the add-on
    ships, as TSV that pastes straight into a spreadsheet, and flags every ID the
    client does not recognise. This is how an ID that renumbered across a patch,
    or that only exists on one flavor, gets caught without waiting for a player
    report. Tabs and newlines are stripped from values and pipes escaped so a
    spell link arrives as copyable text rather than a rendered link.
]]
local function CleanCell(value)
	local text = tostring(value)
	text = text:gsub("[\t\n\r]", " ")
	text = text:gsub("|", "||")
	return text
end

--[[
    Both target clients hand the range pair back the wrong way round: a 35 yard
    spell reports minRange 35 and maxRange 0, verified on Era 1.15.9 and TBC
    2.5.6. Order the pair instead of trusting the field names, so a client that
    fills them correctly is unaffected.
]]
local function OrderRange(low, high)
	low, high = low or 0, high or 0
	if high < low then
		return high, low
	end
	return low, high
end

-- Everything the client will hand back for one ID. Deliberately wider than the
-- display shim in Utilities: more columns always beat fewer in a bug report.
local function GetFullSpellInfo(spellId)
	if C_Spell and C_Spell.GetSpellInfo then
		local info = C_Spell.GetSpellInfo(spellId)
		if not info then
			return nil
		end
		--[[
		    The subtext is answered only once the client has that spell cached, so
		    it is blank for whatever nothing has touched yet and cannot be relied
		    on. The RANK column is our own trigger position; this rides alongside
		    it as the client's own answer, blank or not.
		]]
		local subtext = C_Spell.GetSpellSubtext and C_Spell.GetSpellSubtext(spellId) or ""
		local minRange, maxRange = OrderRange(info.minRange, info.maxRange)
		return {
			name = info.name,
			subtext = subtext,
			icon = info.iconID,
			castTime = info.castTime,
			minRange = minRange,
			maxRange = maxRange,
		}
	end
	local name, subtext, icon, castTime, low, high = GetSpellInfo(spellId)
	if not name then
		return nil
	end
	local minRange, maxRange = OrderRange(low, high)
	return {
		name = name,
		subtext = subtext,
		icon = icon,
		castTime = castTime,
		minRange = minRange,
		maxRange = maxRange,
	}
end

local function SafeCall(fn, spellId)
	if type(fn) ~= "function" then
		return ""
	end
	local ok, result = pcall(fn, spellId)
	if not ok then
		return ""
	end
	return result
end

function ns:BuildDataReport(source)
	local lines = { GetClientHeader(), "", "Source: " .. source[1], "" }
	lines[#lines + 1] = table.concat({
		"STATUS",
		"SPELL_ID",
		"NAME",
		"RANK",
		"CLIENT_SUBTEXT",
		"ICON",
		"CAST_TIME",
		"MIN_RANGE",
		"MAX_RANGE",
		"IS_PLAYER_SPELL",
		"IS_SPELL_KNOWN",
		"CLASS",
		"CATEGORY",
		"IS_AOE",
		"DETECTION",
		"FLAVORS",
		"TRACKED",
		"LINK",
	}, "\t")

	local flavor = ns.GetFlavorIndex()
	local idField, isTracked = source[4], source[5]
	local total, missing, offFlavor, mismatched = 0, 0, 0, 0

	for _, entry in ipairs(source[2]) do
		-- A table with no flavors column exists on every flavor, so it is live.
		local live = not entry.flavors or entry.flavors[flavor] ~= "-"
		local flavors = ""
		if entry.flavors then
			for index = 1, #entry.flavors do
				flavors = flavors .. (index > 1 and "/" or "") .. tostring(entry.flavors[index])
			end
		end
		local ids = entry[idField]

		--[[
		    The entry's name on this client, from its first resolving trigger. A
		    later trigger answering to something else is the typo signal: the
		    flavors column decides what is tracked, so a bad id is reported here
		    rather than silently dropped at load. Comparing the client's own
		    answers against each other keeps the check locale-independent.
		]]
		local entryName
		for _, spellId in ipairs(ids) do
			local info = GetFullSpellInfo(spellId)
			if info then
				entryName = info.name
				break
			end
		end

		for rankIndex, spellId in ipairs(ids) do
			total = total + 1
			local info = GetFullSpellInfo(spellId)
			local tracked = isTracked(spellId)
			local status = "OK"
			if not live then
				status = "OFF FLAVOR"
				offFlavor = offFlavor + 1
			elseif not info then
				status = "NOT ON CLIENT"
				missing = missing + 1
			elseif entryName and info.name ~= entryName then
				if entry.renamed then
					status = "RENAMED"
				else
					status = "NAME MISMATCH"
					mismatched = mismatched + 1
				end
			end
			info = info or {}
			lines[#lines + 1] = table.concat({
				status,
				CleanCell(spellId),
				CleanCell(info.name or ""),
				CleanCell(rankIndex),
				CleanCell(info.subtext or ""),
				CleanCell(info.icon or ""),
				CleanCell(info.castTime or ""),
				CleanCell(info.minRange or ""),
				CleanCell(info.maxRange or ""),
				CleanCell(SafeCall(IsPlayerSpell, spellId)),
				CleanCell(SafeCall(IsSpellKnown, spellId)),
				CleanCell(entry.class or ""),
				CleanCell(entry.category or ""),
				CleanCell(entry.isAoe == nil and "" or entry.isAoe),
				CleanCell(entry.detection or ""),
				CleanCell(flavors),
				CleanCell(tracked),
				CleanCell(ns.GetSpellLink(spellId) or ""),
			}, "\t")
		end
	end

	lines[#lines + 1] = ""
	lines[#lines + 1] = string.format("Flavor column read: %s.", ns.GetFlavorName())
	lines[#lines + 1] = string.format("%d of %d ids are not on this client.", missing, total)
	lines[#lines + 1] = string.format("%d are marked absent on this flavor and are never registered.", offFlavor)
	lines[#lines + 1] =
		string.format("%d resolve to a different spell than the rest of their entry (check the id).", mismatched)
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Other Add-ons
--------------------------------------------------------------------------------

function ns:BuildAddOnReport()
	local lines = { GetClientHeader(), "" }
	local count = C_AddOns.GetNumAddOns()
	for index = 1, count do
		local name, _, _, loadable = C_AddOns.GetAddOnInfo(index)
		local version = C_AddOns.GetAddOnMetadata(index, "Version") or "?"
		lines[#lines + 1] = string.format("%s v%s [%s]", name, version, loadable and "loadable" or "disabled")
	end
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Saved Variables
--------------------------------------------------------------------------------

--[[
    The ignored-ability list is summarized by length rather than printed row by
    row: it grows with every ability the player unchecks and would bury the
    settings a bug report is actually read for. Identified by key name against a
    numeric-keyed table, so the settings tables are never collapsed by mistake.
]]
local function CountEntries(list)
	local count = 0
	for _ in pairs(list) do
		count = count + 1
	end
	return count
end

local function DumpTable(value, indent, depth, lines)
	if depth > 8 then
		lines[#lines + 1] = indent .. "<max depth>"
		return
	end
	local keys = {}
	for key in pairs(value) do
		keys[#keys + 1] = key
	end
	table.sort(keys, function(a, b)
		return tostring(a) < tostring(b)
	end)
	for _, key in ipairs(keys) do
		local entry = value[key]
		if type(entry) == "table" then
			if key == "ignoredSpells" then
				lines[#lines + 1] = indent .. tostring(key) .. " = <" .. CountEntries(entry) .. " abilities>"
			else
				lines[#lines + 1] = indent .. tostring(key) .. " = {"
				DumpTable(entry, indent .. "    ", depth + 1, lines)
				lines[#lines + 1] = indent .. "}"
			end
		else
			lines[#lines + 1] = indent .. tostring(key) .. " = " .. tostring(entry)
		end
	end
end

function ns:BuildSavedVariablesReport()
	local lines = { GetClientHeader(), "", "ControlFreakDB = {" }
	DumpTable(ControlFreakDB or {}, "    ", 1, lines)
	lines[#lines + 1] = "}"
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Library Versions
--------------------------------------------------------------------------------

function ns:BuildLibraryReport()
	local lines = { GetClientHeader(), "" }
	local names = {}
	for name in LibStub:IterateLibraries() do
		names[#names + 1] = name
	end
	table.sort(names)
	for _, name in ipairs(names) do
		lines[#lines + 1] = string.format("%s (minor %s)", name, tostring(LibStub.minors[name]))
	end
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Taint Log
--------------------------------------------------------------------------------

--[[
    The taintLog CVar controls UI taint logging to Logs\taint.log. Level 2 logs
    both blocked actions and accesses to tainted globals; 0 is off. This is the
    only state the diagnostics panel ever writes.
]]

function ns:GetTaintLogState()
	return tonumber(C_CVar.GetCVar("taintLog")) or 0
end

function ns:SetTaintLog(enabled)
	C_CVar.SetCVar("taintLog", enabled and 2 or 0)
end
