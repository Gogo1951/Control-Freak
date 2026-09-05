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

	if ability.isAoe then
		ns:Alert(settings, "FEAR_AOE", { sourcePart, spellPart }, sourceFlags, destGUID)
		return
	end

	ns:Alert(
		settings,
		"FEAR_SUCCESS",
		{ sourcePart, spellPart, ns.TargetPart(destName, raidIconIndex) },
		sourceFlags,
		destGUID
	)
end
