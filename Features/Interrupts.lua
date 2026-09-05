local _, ns = ...

local lastTimestamp, lastSpellId

--[[
    Era reports the interrupted spell's id as 0 on SPELL_INTERRUPT, handing over
    only its name, so the alert could name the spell but never link it.
    UNIT_SPELLCAST_INTERRUPTED carries the real id for the same cast, so it is
    caught here and read back when the combat log's id is missing.

    One slot rather than a table keyed by unit: the two events describe the same
    instant, so nothing older than a moment is ever wanted, and a single record
    cannot grow. The guid and the window together stop it answering for a
    different mob.
]]
local INTERRUPTED_CAST_WINDOW = 1
local interruptedCast = {}

function ns:UNIT_SPELLCAST_INTERRUPTED(unit, _, spellId)
	if type(spellId) ~= "number" or spellId == 0 then
		return
	end
	local guid = UnitGUID(unit)
	if not guid then
		return
	end
	interruptedCast.guid, interruptedCast.spellId, interruptedCast.at = guid, spellId, GetTime()
end

local function RecallInterruptedSpell(destGUID)
	if not destGUID or interruptedCast.guid ~= destGUID then
		return nil
	end
	if GetTime() - interruptedCast.at > INTERRUPTED_CAST_WINDOW then
		return nil
	end
	return interruptedCast.spellId
end

function ns:HandleInterrupt(
	timestamp,
	sourceGUID,
	sourceName,
	sourceFlags,
	destGUID,
	destName,
	raidIconIndex,
	spellId,
	spellName,
	interruptedSpellId,
	interruptedSpellName
)
	local settings = ns.db.profile.interrupts.alert

	if timestamp == lastTimestamp and spellId == lastSpellId then
		return
	end
	lastTimestamp, lastSpellId = timestamp, spellId

	if not interruptedSpellId or interruptedSpellId == 0 then
		interruptedSpellId = RecallInterruptedSpell(destGUID)
	end

	ns:Alert(settings, "INTERRUPT", {
		ns.PlayerPart(sourceName, sourceGUID),
		ns.SpellPart(spellId, spellName),
		ns.TargetPart(destName, raidIconIndex),
		ns.SpellPart(interruptedSpellId, interruptedSpellName),
	}, sourceFlags, destGUID)
end
