local _, ns = ...

--[[
    Nova Notifications, one of the Tanking Tools.

    A frost nova on a pull scatters mobs out of the tank's threat range and off
    whatever the group was killing, so the tank wants to know it happened without
    reading the combat log. The NOVA ability category has exactly one member,
    Frost Nova, so the same word runs from Data/Abilities.lua through here to the
    printed line.
]]
function ns:HandleNova(
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
	local settings = feature.nova
	local sourcePart = ns.PlayerPart(sourceName, sourceGUID)
	local spellPart = ns.SpellPart(spellId, spellName)

	if ability.isAoe then
		ns:Alert(settings, "NOVA_AOE", { sourcePart, spellPart }, sourceFlags, destGUID)
		return
	end

	ns:Alert(settings, "NOVA", { sourcePart, spellPart, ns.TargetPart(destName, raidIconIndex) }, sourceFlags, destGUID)
end
