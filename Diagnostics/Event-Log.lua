local _, ns = ...

local GetClientHeader = ns.GetDiagnosticClientHeader

--------------------------------------------------------------------------------
-- Event Log
--------------------------------------------------------------------------------

local EVENT_LOG_SIZE = 500
local EVENT_LOG_MAX_ARGS = 8
local EVENT_LOG_MAX_ARG_LENGTH = 255

--[[
    The firehoses Control Freak registers, dropped here because raw they would
    evict the whole buffer between two taunts. Each one's signal is written back
    through ns:LogEventNow by the handler that decided it mattered, so the log
    still separates "the event never fired" from "it fired and nothing happened":

      COMBAT_LOG_EVENT_UNFILTERED  every swing in the zone; Features/Combat-Log.lua
                                   writes back the lines it matched
      CHAT_MSG_ADDON               every add-on's messages in the group and guild;
                                   Features/Whisper-Election.lua writes back
                                   Control Freak's own
      UNIT_SPELLCAST_INTERRUPTED   every interrupted or cancelled cast of every
                                   unit; Features/Interrupts.lua writes back the id
                                   it recovers for an interrupt
]]
ns.DIAGNOSTIC_EVENT_EXCLUDE = {
	COMBAT_LOG_EVENT_UNFILTERED = true,
	CHAT_MSG_ADDON = true,
	UNIT_SPELLCAST_INTERRUPTED = true,
}

--[[
    Events that carry a message id, and the argument position it arrives in,
    for ns:SuppressUncorrelatedMessage to classify per firing rather than drop
    wholesale. Deliberately empty: Control Freak registers no message-id
    firehose such as UI_ERROR_MESSAGE. One that is registered later goes here,
    and the ids the add-on correlates join the allowlist check in the filter.
]]
ns.MESSAGE_ID_FILTERED_EVENTS = {}

--[[
    Per-firing filter for the events above. A firing whose id the add-on does
    not correlate folds into a per-id counter (first-seen text plus a count)
    rendered as one block at the end of the report, so firehose traffic can't
    evict the entries the log exists to carry. A firing carrying no numeric id
    in the filtered position is unclassifiable, and unclassifiable is signal:
    it logs verbatim. With no correlated ids yet, every classifiable firing is
    counted.

    Returns true when the firing was counted and must not reach the buffer.
]]
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
end

local function AppendEntry(event, ...)
	local log = ns.diagnostics.log
	if not log then
		return
	end
	local parts = {}
	for index = 1, select("#", ...) do
		if index > EVENT_LOG_MAX_ARGS then
			break
		end
		local raw = string.sub(tostring((select(index, ...))), 1, EVENT_LOG_MAX_ARG_LENGTH)
		parts[index] = (raw:gsub("|", "||"))
	end
	log[#log + 1] = string.format("%.3f %s(%s)", GetTime(), event, table.concat(parts, ", "))
	if #log > EVENT_LOG_SIZE then
		table.remove(log, 1)
	end
end

--[[
    Called by Core's central dispatcher for every event while logging is active.
    Snapshots arguments to strings immediately -- never retain references, since
    some events carry frames or tables that would leak memory or go stale. Caps
    the arg count and per-argument byte length so a single entry can't run away.

    Pipes are escaped (| -> ||) AFTER the length cut so each argument shows
    verbatim in the report editbox instead of rendering as a clickable item
    swatch. Escaping last also means the cut can never leave a dangling pipe that
    would eat the following ", " separator.
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

--[[
    The way back in for an excluded firehose: the handler that decided a firing
    was signal writes it here, past the exclude list. Callers read
    ns.diagnostics.logging first, so off costs one boolean.
]]
function ns:LogEventNow(event, ...)
	if not ns.diagnostics.logging then
		return
	end
	AppendEntry(event, ...)
end

--[[
    Renders the suppressed-traffic counters as one compact block, biggest
    offender first. This is also how a tester discovers a message id the add-on
    should be correlating but isn't.
]]
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
-- Taint Log
--------------------------------------------------------------------------------

--[[
    The taintLog CVar controls UI taint logging to Logs\taint.log. Level 2 logs
    both blocked actions and accesses to tainted globals; 0 is off. This is the
    only state the diagnostics panel ever writes.
]]

function ns:GetTaintLogState()
	return tonumber(GetCVar("taintLog")) or 0
end

function ns:SetTaintLog(enabled)
	SetCVar("taintLog", enabled and 2 or 0)
end
