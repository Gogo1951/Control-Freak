local _, ns = ...

--[[
    Bad Mages: the Novas alert.

    A frost nova on a pull scatters mobs out of the tank's threat range and off
    whatever the group was killing, so the tank wants to know it happened without
    reading the combat log. The NOVA ability category has exactly one member,
    Frost Nova, so the same word runs from each flavor's
    Data/{Game}/Abilities-{Game}.lua through here to the printed line.
]]

--[[
    mage GUID -> GetTime() of the last alert about them. One cooldown covers the
    print, the sound, the announce and the whisper: a mage who novas every pull
    must not fill the tank's window.
]]
local lastAlert = {}

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(lastAlert)
end
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
	local settings = feature.alert

	--[[
	    The section draws no target filter (noTarget in Options-Bad-Mages.lua):
	    a nova is a ring. The one member of the category is AOE, so the
	    single-target branch below is the shape of the call for a nova that does
	    not exist yet, passed the way the event would carry it.
	]]
	local targetGUID = not ability.isAoe and destGUID or nil
	local targetIcon = not ability.isAoe and raidIconIndex or nil

	--[[
	    The section's own gates first: a nova its switch drops must not whisper
	    the mage, and must not use up the cooldown that would then swallow the
	    next real one.
	]]
	if not ns:PassesAlertGates(settings, sourceFlags, targetGUID, targetIcon) then
		return
	end

	local now = GetTime()
	local last = lastAlert[sourceGUID]
	local cooldown = ns.ResolveChoice(feature.cooldown, ns.BAD_PET_COOLDOWNS, ns.NOVA_COOLDOWN_DEFAULT)
	if last and now - last < cooldown then
		return
	end
	lastAlert[sourceGUID] = now

	local sourcePart = ns.PlayerPart(sourceName, sourceGUID)
	local spellPart = ns.SpellPart(spellId, spellName)

	if ability.isAoe then
		ns:Alert(settings, "NOVA_AOE", { sourcePart, spellPart }, sourceFlags, nil, nil)
	else
		ns:Alert(
			settings,
			"NOVA",
			{ sourcePart, spellPart, ns.TargetPart(destName, raidIconIndex) },
			sourceFlags,
			destGUID,
			raidIconIndex
		)
	end

	ns.LogWhisperStep("decide (whisper, mage)", feature.whisper, sourceName)

	--[[
	    Never whisper yourself: a mage who novaed is reading the print already.
	    The whisper rides the same election as the other Bad tabs', so a raid
	    with four Control Freak users sends the mage one note rather than four.
	]]
	if feature.whisper and sourceName and not ns.IsMineSource(sourceFlags) then
		ns:QueueGroupWhisper("nova", sourceGUID, sourceName, "NOVA_WHISPER", {
			ns.GetSpellDisplay(spellId, spellName),
		})
	end
end
