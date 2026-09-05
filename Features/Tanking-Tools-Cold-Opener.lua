local _, ns = ...

--[[
    Cold Opener Warnings, one of the Tanking Tools.

    An ability avoided in the first seconds of a pull is threat that never
    happened, at the moment threat matters most. The shape of this follows the
    reference aura (Parry/Dodge/Miss Announcer 63+, wago.io/KVtFqses5), whose
    description states the three filters it settled on: "only works against
    bosses, only if you have aggro, only on abilities (not auto-attacks), and only
    during the first 14 sec of the pull".

    Only abilities is the load-bearing one. An auto-attack is dodged and parried
    constantly against a boss and reporting those would bury the specials, so this
    reads SPELL_MISSED and never SWING_MISSED.

    THE PLAYER'S OWN OPENER, and nobody else's. A miss reports while the mob is on
    the player or has not settled on anyone yet, and goes quiet the moment the
    combat log has shown it on somebody else. The first seconds of a pull somebody
    else started are unreadable from here -- no swing has named a holder yet, so
    every other player's miss is either the tank's opener or a DPS going early and
    nothing on the wire tells them apart. Answering only for our own cast is the
    one case where the missing swing does not matter.
]]

--[[
    enemy guid -> GetTime() the mob was first seen. The pull starts the first time
    a mob appears in the combat log while this warning is switched on, which needs
    no event of its own and is per mob rather than per player combat state --
    pulling a boss while trash is still up would otherwise start the clock in the
    wrong place. Switching the warning on mid-fight therefore clocks the mobs
    already up from that moment, which reads as one missed pull rather than a wrong
    one.

    Recorded from EITHER side of an event. A boss that opens on the tank is a
    source before it is ever a destination, and clocking it only as a destination
    would start the window at the tank's first swing back rather than at the pull.

    Players are skipped rather than stored. Nothing asks when a player was first
    seen, and letting them in would fill a bounded cache with entries that can
    only evict the mobs it exists for.
]]
local firstSeen = {}
local firstSeenCount = 0
local FIRST_SEEN_LIMIT = 500

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(firstSeen)
	firstSeenCount = 0
end

function ns.RememberEnemyFirstSeen(guid)
	if not guid or firstSeen[guid] then
		return
	end
	if ns.IsPlayerGUID(guid) then
		return
	end
	-- Emptied whole when it fills, the way the enemy-target cache is: what is lost
	-- is opener windows that had already expired.
	if firstSeenCount >= FIRST_SEEN_LIMIT then
		wipe(firstSeen)
		firstSeenCount = 0
	end
	firstSeen[guid] = GetTime()
	firstSeenCount = firstSeenCount + 1
end

function ns:HandleColdOpener(
	feature,
	sourceGUID,
	sourceName,
	sourceFlags,
	destGUID,
	destName,
	raidIconIndex,
	spellId,
	spellName,
	missType
)
	local settings = feature.coldOpener
	if not settings or not settings.enabled then
		return
	end

	local formatKey = ns.COLD_OPENER_MISS_FORMATS[missType]
	if not formatKey then
		return
	end

	-- Our own cast only. See the note at the top of the file.
	if sourceGUID ~= ns.playerGUID then
		return
	end

	-- Inside the window, measured from the first time anything involving this mob
	-- reached the combat log. A mob we have somehow never seen is not mid-pull, so
	-- it reports nothing rather than treating "unknown" as "just started".
	local started = firstSeen[destGUID]
	if not started then
		return
	end
	local window = ns.ResolveChoice(settings.window, ns.COLD_OPENER_WINDOWS, ns.COLD_OPENER_WINDOW_DEFAULT)
	if GetTime() - started > window then
		return
	end

	-- The mob has to be ours, or not yet anybody's. Being dodged by something the
	-- log has already shown on another player is not a cold opener.
	if ns.EnemyIsOnSomeoneElse(destGUID, ns.playerGUID) then
		return
	end

	ns:Alert(settings, formatKey, {
		ns.PlayerPart(sourceName, sourceGUID),
		ns.SpellPart(spellId, spellName),
		ns.TargetPart(destName, raidIconIndex),
	}, sourceFlags, destGUID)
end
