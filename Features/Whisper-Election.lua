local _, ns = ...

--[[
    Whisper election, shared by every feature that tells somebody off.

    Four people running Control Freak in the same raid would otherwise send the
    same hunter four identical whispers in the same second, which is how an add-on
    gets uninstalled by a whole group. Each client bids a random priority,
    broadcasts it, and holds its whisper for a beat; a client that hears a higher
    bid drops its own. The highest bid sends, so exactly one whisper goes out
    however many of us are watching.

    The trap: a client receives its own broadcast. Left unfiltered it ties with
    itself, stands down, and nobody whispers at all -- and grouped is the only
    state where there is anybody to whisper, so the feature never fires.

    The bid therefore carries the sender's player guid and is dropped on a match
    before any comparison. A guid rather than a name: CHAT_MSG_ADDON reports its
    sender as "Name-Realm" while the client's own name APIs drop the realm on your
    own character, so the two never compare equal and the filter silently fails.

    The wire format is kind:id:priority:senderGUID, split on ":" -- which is why
    kind is a bare word and id is a guid, neither of which can contain one. kind
    keeps two features from colliding on the same subject: a pet and the player it
    belongs to are different whispers about different things.

    A bid heard before this client queues its own is kept for one election
    delay and wins the same way, since the clients do not see the event at
    exactly the same moment.
]]
local pending = {}

local heard = {}
local heardCount = 0
local HEARD_LIMIT = 200

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(pending)
	wipe(heard)
	heardCount = 0
end

-- The stand-down rule: the higher bid wins, and equal bids break on the sender's guid.
local function Beats(priority, senderGUID, otherPriority, otherGUID)
	return priority > otherPriority or (priority == otherPriority and senderGUID > otherGUID)
end

--[[
    The election is the most opaque thing the add-on does: it decides in silence,
    a second after the fact, in another client's code as much as this one's. Its
    steps are written into the diagnostics event log so a "no whisper arrived"
    report answers itself, naming the target string verbatim rather than the
    shortened form the alert prints.

    Callers pass raw values and a constant label, never a built string: off has to
    mean off, and the boolean is read before any work happens.
]]
function ns.LogWhisperStep(step, ...)
	if ns.diagnostics and ns.diagnostics.logging and ns.LogEventNow then
		ns:LogEventNow("WHISPER_ELECTION", step, ...)
	end
end

--[[
    kind      a bare word naming the feature, so two features never collide
    id        the guid the whisper is about, which is what the election is keyed on
    target    who receives it, as the caller has the name: the combat log's, or
              GetUnitName(unit, true) in Bad Pets, carrying a realm only for a
              player from another realm
    formatKey the locale line to send
    args      that line's arguments, already rendered to plain strings
]]
function ns:QueueGroupWhisper(kind, id, target, formatKey, args)
	local key = kind .. ":" .. id
	local priority = math.random(1, 10000)

	local earlier = heard[key]
	if earlier then
		heard[key] = nil
		heardCount = heardCount - 1
		if
			GetTime() - earlier.at <= ns.WHISPER_ELECTION_DELAY
			and Beats(earlier.priority, earlier.senderGUID, priority, ns.playerGUID or "")
		then
			ns.LogWhisperStep("stand down, heard earlier (theirs, ours)", earlier.priority, priority)
			return
		end
	end

	pending[key] = { priority = priority, target = target, formatKey = formatKey, args = args }

	local channel = ns:GetGroupChatChannel()
	if channel then
		C_ChatInfo.SendAddonMessage(
			ns.ADDON_MESSAGE_PREFIX,
			kind .. ":" .. id .. ":" .. priority .. ":" .. (ns.playerGUID or ""),
			channel
		)
	end

	ns.LogWhisperStep("queued (kind, target, priority, channel)", kind, target, priority, channel)

	C_Timer.After(ns.WHISPER_ELECTION_DELAY, function()
		local bid = pending[key]
		pending[key] = nil
		if not bid then
			ns.LogWhisperStep("dropped, another client won the bid")
			return
		end
		ns.LogWhisperStep("sending (target)", bid.target)
		ns:Announce("WHISPER", bid.target, bid.formatKey, unpack(bid.args))
	end)
end

function ns:OnChatMsgAddon(prefix, message, channel, sender)
	if prefix ~= ns.ADDON_MESSAGE_PREFIX then
		return
	end

	--[[
	    Written in by hand because CHAT_MSG_ADDON is excluded from the log: it
	    carries every add-on's traffic, and only this prefix is Control Freak's.
	]]
	if ns.diagnostics and ns.diagnostics.logging and ns.LogEventNow then
		ns:LogEventNow("CHAT_MSG_ADDON", prefix, message, channel, sender)
	end

	local kind, id, priority, senderGUID = strsplit(":", message)
	priority = tonumber(priority)
	if not kind or not id or not priority or not senderGUID then
		return
	end
	if senderGUID == ns.playerGUID then
		ns.LogWhisperStep("own echo ignored")
		return
	end

	local key = kind .. ":" .. id
	local bid = pending[key]
	if not bid then
		local kept = heard[key]
		if not kept or Beats(priority, senderGUID, kept.priority, kept.senderGUID) then
			if not kept then
				if heardCount >= HEARD_LIMIT then
					wipe(heard)
					heardCount = 0
				end
				heardCount = heardCount + 1
			end
			heard[key] = { priority = priority, senderGUID = senderGUID, at = GetTime() }
		end
		return
	end

	--[[
	    Equal bids break on the sender's guid, so both clients stand down the same
	    way and exactly one whisper goes out.
	]]
	if Beats(priority, senderGUID, bid.priority, ns.playerGUID or "") then
		pending[key] = nil
		ns.LogWhisperStep("stand down (theirs, ours)", priority, bid.priority)
	end
end
