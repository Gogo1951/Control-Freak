local _, ns = ...

function ns:HandleFear(
	feature,
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
	local settings = feature.alert
	local sourcePart = ns.PlayerPart(sourceName, sourceGUID)
	local spellPart = ns.SpellPart(spellId, spellName)

	--[[
	    The section draws no target filter (noTarget in Options-Fears.lua), so the
	    gate reads neither argument today. They are still passed the way the event
	    carries them: an AOE fear has no single target, a landed one does.
	]]
	if ability.isAoe then
		ns:Alert(settings, "FEAR_AOE", { sourcePart, spellPart }, sourceFlags, nil, nil)
		return
	end

	ns:Alert(
		settings,
		"FEAR_SUCCESS",
		{ sourcePart, spellPart, ns.TargetPart(destName, raidIconIndex) },
		sourceFlags,
		destGUID,
		raidIconIndex
	)
end
