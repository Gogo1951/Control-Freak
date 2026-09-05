local _, ns = ...

--[[
    Parry Warnings, one of the Tanking Tools.

    A mob can only parry an attack coming at its front, and every parry it lands
    speeds up its next swing at whoever is tanking it. So a parry is not the
    parried player's problem -- it is the tank's.

    The test comes from the reference aura (Parry - You're in the wrong spot,
    wago.io/yJAzyvcvw), which fires when your attack is parried and then hides
    itself unless UnitGUID("targettarget") ~= UnitGUID("player"): being parried
    while the mob is on you is just tanking, and unavoidable. Being parried while
    it is on somebody else means you are standing in front of it.

    Inverted for a tank's client, that is: warn about a group member parried by a
    mob they are not holding. ns.EnemyWasAlreadyOn answers "are they holding it"
    from the swings the combat log has already shown us, so it needs no unit token
    and works for a mob nobody is targeting.

    Both SWING_MISSED and SPELL_MISSED count here, unlike the cold opener. A melee
    DPS standing in front generates parries with auto-attacks more than with
    anything else, and those are exactly the ones worth catching.
]]

-- culprit GUID -> GetTime() of the last warning about them. One cooldown covers
-- the print, the sound, the announce and the whisper: somebody who has not moved
-- yet does not need telling every swing.
local lastWarning = {}

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(lastWarning)
end

function ns:HandleParry(feature, sourceGUID, sourceName, sourceFlags, destGUID, destName, raidIconIndex, missType)
	local settings = feature.parry
	if not settings or not settings.enabled then
		return
	end
	if missType ~= "PARRY" then
		return
	end

	-- A tank being parried by their own mob is normal and unavoidable, so the only
	-- parry worth reporting is one from a mob the parried player is not holding.
	if ns.EnemyWasAlreadyOn(destGUID, sourceGUID) then
		return
	end

	local now = GetTime()
	local last = lastWarning[sourceGUID]
	local cooldown = ns.ResolveChoice(settings.whisperCooldown, ns.PARRY_COOLDOWNS, ns.PARRY_COOLDOWN_DEFAULT)
	if last and now - last < cooldown then
		return
	end
	lastWarning[sourceGUID] = now

	local culpritPart = ns.PlayerPart(sourceName, sourceGUID)
	local targetPart = ns.TargetPart(destName, raidIconIndex)

	ns:Alert(settings, "PARRY_WARNING", { culpritPart, targetPart }, sourceFlags, destGUID)

	--[[
	    Never whisper yourself. The player standing in front of their own mob is
	    reading the print already, and a tell from your own add-on reads as a bug.

	    The whisper rides the same election as Bad Pet's, so a raid with four
	    Control Freak users sends the culprit one note rather than four.
	]]
	if settings.whisper and sourceName and not ns.IsMineSource(sourceFlags) then
		ns:QueueGroupWhisper("parry", sourceGUID, sourceName, "PARRY_WHISPER", {
			destName or ns.L["UNKNOWN_TARGET"],
		})
	end
end
