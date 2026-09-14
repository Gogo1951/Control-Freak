local _, ns = ...

-- No steal detection: a planned taunt swap and a stolen mob are the same combat-log lines (README-Technical.md, Taunts).

local MISS_FORMATS = {
	MISS = "TAUNT_MISSED",
	RESIST = "TAUNT_RESISTED",
	IMMUNE = "TAUNT_IMMUNE",
}

function ns:HandleTaunt(
	feature,
	outcome,
	missType,
	sourceGUID,
	sourceName,
	sourceFlags,
	destGUID,
	destName,
	raidIconIndex,
	spellId,
	spellName,
	ability
)
	local sourcePart = ns.PlayerPart(sourceName, sourceGUID)
	local spellPart = ns.SpellPart(spellId, spellName)
	local targetPart = ns.TargetPart(destName, raidIconIndex)

	if outcome == "FAIL" then
		local formatKey = MISS_FORMATS[missType] or "TAUNT_FAILED"
		--[[
		    The immune line is the one failure format that leads with the MOB:
		    the immunity is what happened, where the other three have nothing to
		    say beyond "it did not land". So its parts run mob, taunter, taunt
		    rather than the taunter-first order the rest share.
		]]
		if formatKey == "TAUNT_IMMUNE" then
			ns:Alert(
				feature.failed,
				formatKey,
				{ targetPart, sourcePart, spellPart },
				sourceFlags,
				destGUID,
				raidIconIndex
			)
		else
			ns:Alert(
				feature.failed,
				formatKey,
				{ sourcePart, spellPart, targetPart },
				sourceFlags,
				destGUID,
				raidIconIndex
			)
		end
		return
	end

	--[[
	    No target: an AOE taunt reports the cast, not a mob, so the section draws
	    no target filter and the gate is handed nothing to filter on. The destGUID
	    the log happened to report first would only ever have been one mob of many.
	]]
	if ability.isAoe then
		ns:Alert(feature.aoe, "TAUNT_AOE", { sourcePart, spellPart }, sourceFlags, nil, nil)
		return
	end

	--[[
	    A taunt on a mob that was already hitting the taunter is a threat refresh,
	    not a save, and reporting those buries the ones that mattered. Only a
	    positive match is suppressed, so a mob whose target we never saw still
	    announces.

	    Recorded either way: the mob is theirs now, so the next taunt on it from
	    the same player is the noise this exists to drop.
	]]
	local alreadyTheirs = ns.EnemyWasAlreadyOn(destGUID, sourceGUID)
	ns.RememberEnemyTarget(destGUID, sourceGUID)

	if not alreadyTheirs then
		ns:Alert(
			feature.success,
			"TAUNT_SUCCESS",
			{ sourcePart, spellPart, targetPart },
			sourceFlags,
			destGUID,
			raidIconIndex
		)
	end
end
