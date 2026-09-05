local _, ns = ...

--[[
    Bubble Warnings, one of the Tanking Tools.

    PARKED, with the bubbles themselves -- see Data/Abilities.lua. No ability
    carries the BUBBLE category, so ns:HandleBubble cannot be reached, and
    feature.bubble is not in the defaults either, which ns:Alert reads as nothing
    to do. Both come back together when the section is designed, along with
    wording of its own: ANNOYANCE_BUBBLE still reads "Annoyance!".

    A bubble on a tank drops every mob on them, which lands the whole pull on
    whoever is second on threat. Tanks only, and only above the health threshold:
    a bubble on a tank who is about to die is the right call, not something to
    warn about. "Tank" means the Main Tank assignment or the group finder's TANK
    role; with neither set this check never fires rather than guessing from class.
]]
function ns:HandleBubble(
	feature,
	sourceGUID,
	sourceName,
	sourceFlags,
	destGUID,
	destName,
	raidIconIndex,
	spellId,
	spellName
)
	local unit = ns.FindTankUnit(destGUID)
	if not unit then
		return
	end

	local maxHealth = UnitHealthMax(unit)
	if not maxHealth or maxHealth == 0 then
		return
	end

	local fraction = UnitHealth(unit) / maxHealth
	if fraction <= ns.BUBBLE_HEALTH_THRESHOLD then
		return
	end

	-- No enemy guid to hand the boss filter: a bubble lands on a friendly tank, so
	-- there is nothing here to classify and nil lets the alert through rather than
	-- asking whether a player is a raid boss.
	ns:Alert(feature.bubble, "ANNOYANCE_BUBBLE", {
		ns.PlayerPart(sourceName, sourceGUID),
		ns.SpellPart(spellId, spellName),
		ns.TargetPart(destName, raidIconIndex),
		math.floor(fraction * 100 + 0.5),
	}, sourceFlags, nil)
end
