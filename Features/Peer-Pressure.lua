local _, ns = ...

--[[
    Peer Pressure: another player of YOUR class in your group pressed one of the
    tracked cooldowns, so you can press yours. With the My row on, your own
    cooldowns report too.

    The rows are this flavor's Peer-Pressure-Abilities file, indexed with every
    other ability by ns.BuildAbilityIndex, so by the time a cast reaches this
    handler Features/Combat-Log.lua has already matched a tracked, ticked row,
    checked the caster is in the group, opened the tab's scope gates and dropped
    a repeat of the same cast.

    The rows are class-locked, so "the caster is your class" needs no lookup of
    the caster: the row's class against your own is the whole test.
]]
local playerClass

function ns:HandlePeerPressure(
	feature,
	sourceGUID,
	sourceName,
	sourceFlags,
	destGUID,
	destName,
	spellId,
	spellName,
	ability
)
	playerClass = playerClass or select(2, UnitClass("player"))
	if ability.class ~= playerClass then
		return
	end

	-- A group member's pet carries the group's flags too, and no pet casts a class cooldown worth hearing.
	if not ns.IsPlayerGUID(sourceGUID) then
		return
	end

	--[[
	    "on Sally" only when the cast had a target who is another player: a
	    cooldown cast on the caster, on a pet or on nothing at all reads as the
	    plain line.
	]]
	local formatKey = "PEER_PRESSURE"
	local parts = { ns.PlayerPart(sourceName, sourceGUID), ns.SpellPart(spellId, spellName) }
	if destName and destGUID ~= sourceGUID and ns.IsPlayerGUID(destGUID) then
		formatKey = "PEER_PRESSURE_TARGET"
		parts[3] = ns.PlayerPart(destName, destGUID)
	end

	--[[
	    The section names no mob, so no guid and no mark go to the gates: the
	    rung filter lets a missing pair through. The affiliation bit picks the
	    My or the Others' row, which is where the own-casts choice lives.
	]]
	ns:Alert(feature.alert, formatKey, parts, sourceFlags)
end
