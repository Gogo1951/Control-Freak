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
]]
local pending = {}

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(pending)
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
    target    who receives it, as a full "Name-Realm"
    formatKey the locale line to send
    args      that line's arguments, already rendered to plain strings
]]
function ns:QueueGroupWhisper(kind, id, target, formatKey, args)
	local key = kind .. ":" .. id
	local priority = math.random(1, 10000)

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

function ns:CHAT_MSG_ADDON(prefix, message)
	if prefix ~= ns.ADDON_MESSAGE_PREFIX then
		return
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

	local bid = pending[kind .. ":" .. id]
	if not bid then
		return
	end

	-- Equal bids break on the sender's guid, so both clients stand down the same
	-- way and exactly one whisper goes out.
	if priority > bid.priority or (priority == bid.priority and senderGUID > (ns.playerGUID or "")) then
		pending[kind .. ":" .. id] = nil
		ns.LogWhisperStep("stand down (theirs, ours)", priority, bid.priority)
	end
end
