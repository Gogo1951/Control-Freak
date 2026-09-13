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
    mob somebody ELSE is holding. ns.EnemyIsOnSomeoneElse answers that from the
    swings the combat log has already shown us, so it needs no unit token and
    works for a mob nobody is targeting.

    A mob with no swing on record is not reported at all. That is the opening
    exchange of a pull, before anything has hit anybody, and it is where the
    tank's own parried opener would otherwise be read as somebody standing in
    front of a boss they are tanking correctly.

    Both SWING_MISSED and SPELL_MISSED count here, unlike the cold opener. A melee
    DPS standing in front generates parries with auto-attacks more than with
    anything else, and those are exactly the ones worth catching.
]]

--[[
    culprit GUID -> GetTime() of the last warning about them. One cooldown covers
    the print, the sound, the announce and the whisper: somebody who has not moved
    yet does not need telling every swing.
]]
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

	--[[
	    The mob must have been seen swinging at somebody else. Being parried by
	    your own mob is just tanking, and a mob with no holder on record is a
	    pull that has not landed a blow yet rather than anybody standing wrong.

	    Unknown means quiet here, which is the opposite of the taunt cache's
	    rule: a taunt nobody has history for is still worth reporting, while a
	    parry nobody has history for is the first second of a pull.
	]]
	if not ns.EnemyIsOnSomeoneElse(destGUID, sourceGUID) then
		return
	end

	--[[
	    An off-tank in front of the boss is there on purpose -- a taunt swap, a
	    pick-up -- and telling them to move is wrong, not merely noisy. "Other" is
	    the word: the player's own parries still report, tank or not, and
	    FindTankUnit reads the same Main Tank assignment and Tank role the scope
	    gates do. Before the cooldown, so a tank's parries do not use it up.
	]]
	if settings.ignoreTanks and not ns.IsMineSource(sourceFlags) and ns.FindTankUnit(sourceGUID) then
		return
	end

	--[[
	    The section's own gates before the cooldown: a parry its target filters
	    drop must not whisper the culprit, and must not use up the cooldown that
	    would then swallow the next real one.
	]]
	if not ns:PassesAlertGates(settings, sourceFlags, destGUID, raidIconIndex) then
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

	ns:Alert(settings, "PARRY_WARNING", { culpritPart, targetPart }, sourceFlags, destGUID, raidIconIndex)

	--[[
	    Never whisper yourself. The player standing in front of their own mob is
	    reading the print already, and a tell from your own add-on reads as a bug.

	    Never whisper a pet either. The culprit's name is then the pet's, so the
	    tell would bounce, or land on a stranger who happens to share it. The
	    warning above still names the pet.

	    The whisper rides the same election as Bad Pets', so a raid with four
	    Control Freak users sends the culprit one note rather than four.
	]]
	if settings.whisper and sourceName and not ns.IsMineSource(sourceFlags) and not ns.IsPetSource(sourceFlags) then
		ns:QueueGroupWhisper("parry", sourceGUID, sourceName, "PARRY_WHISPER", {
			destName or ns.L["UNKNOWN_TARGET"],
		})
	end
end
