local _, ns = ...

local L = ns.L

-- destGUID -> expiry time of our own taunt on that mob. The claim ends on that
-- timer alone: a taunt debuff is shorter than the window a taunt-over is worth
-- reporting in, so clearing on SPELL_AURA_REMOVED would silence the late steal
-- this section exists to catch.
local myTaunts = {}

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(myTaunts)
end

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
		if formatKey == "TAUNT_IMMUNE" then
			ns:Alert(
				feature.failed,
				formatKey,
				{ sourcePart, spellPart, targetPart, destName or L["UNKNOWN_TARGET"] },
				sourceFlags,
				destGUID
			)
		else
			ns:Alert(feature.failed, formatKey, { sourcePart, spellPart, targetPart }, sourceFlags, destGUID)
		end
		return
	end

	if ability.isAoe then
		ns:Alert(feature.aoe, "TAUNT_AOE", { sourcePart, spellPart }, sourceFlags, destGUID)
		return
	end

	-- Only an aura-detected taunt proves the mob actually changed hands, so only
	-- those claim it.
	--
	-- PARKED: the section this feeds draws no controls yet and ships off, so the
	-- alert below cannot fire. The bookkeeping is left running because it is the
	-- part that cannot be reconstructed after the fact -- a claim has to be
	-- recorded at the moment of the taunt or the steal is unprovable.
	if ability.detection == "AURA" and destGUID then
		if sourceGUID == ns.playerGUID then
			myTaunts[destGUID] = GetTime() + ns.TAUNT_STOLEN_WINDOW
		else
			local expiry = myTaunts[destGUID]
			if expiry and expiry > GetTime() then
				myTaunts[destGUID] = nil
				ns:Alert(feature.stolen, "TAUNT_STOLEN", { sourcePart, spellPart, targetPart }, sourceFlags, destGUID)
			end
		end
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
		ns:Alert(feature.success, "TAUNT_SUCCESS", { sourcePart, spellPart, targetPart }, sourceFlags, destGUID)
	end
end
