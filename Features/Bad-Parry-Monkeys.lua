local _, ns = ...

--[[
    Bad Parry Monkeys, the Naughty List tab for somebody who is not tanking and
    keeps getting parried.

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

--------------------------------------------------------------------------------
-- Parry Monkey
--------------------------------------------------------------------------------

--[[
    The tab's second section: the player owning up to their own parries, in
    their own words, with a running count. It reads the same parries as the
    Parries section above it but is its own switch, rows and filters, so the
    warning everybody gets and the confession never stand in for each other.

    Every parry counts, but the line goes out at most once per the section's
    cooldown: the count is the news, and a confession on every swing is noise.
    The count goes back to zero whenever the player joins a raid group, so the
    number is tonight's. A roster update before the first loading screen only
    records the raid state, so a /reload inside a raid keeps the count.
]]
local lastConfession
local wasInRaid

ns.stateResets[#ns.stateResets + 1] = function()
	lastConfession = nil
	wasInRaid = IsInRaid()
end

function ns:OnGroupRosterUpdate()
	local inRaid = IsInRaid()
	if inRaid and wasInRaid == false and ns.db then
		ns.db.profile.badParryMonkeys.monkey.count = 0
	end
	wasInRaid = inRaid
end

--[[
    The player's words, pipes stripped since they never carry a link, so a
    typed "|" cannot break the escape the client sends. Left blank, the shipped
    words stand in rather than the section going quiet behind an empty box.
]]
function ns.GetParryConfession(settings)
	local message = type(settings.message) == "string" and settings.message:gsub("|", "") or ""
	if message:match("^%s*$") then
		return ns.L["BAD_PARRY_MONKEYS_MONKEY_MESSAGE_DEFAULT"]
	end
	return message
end

--[[
    Raid bosses only, fixed rather than a ladder, and a raid mark changes
    nothing: the count is how often a boss parried the player tonight. A mob
    nothing on screen can classify does not count, since the tally must not
    grow on trash it could not tell apart.
]]
local function Confess(settings, sourceFlags, destGUID, raidIconIndex)
	if not settings.enabled then
		return
	end
	if ns.GetEnemyTier(destGUID) ~= ns.TARGET_TIER.BOSS then
		return
	end
	if not ns:PassesAlertGates(settings, sourceFlags, nil, nil) then
		return
	end
	settings.count = settings.count + 1

	local now = GetTime()
	local cooldown = ns.ResolveChoice(settings.cooldown, ns.PARRY_MONKEY_COOLDOWNS, ns.PARRY_MONKEY_COOLDOWN_DEFAULT)
	if lastConfession and now - lastConfession < cooldown then
		return
	end
	lastConfession = now
	ns:Alert(
		settings,
		"PARRY_CONFESSION",
		{ ns.GetParryConfession(settings), settings.count },
		sourceFlags,
		destGUID,
		raidIconIndex
	)
end

--------------------------------------------------------------------------------
-- Parries
--------------------------------------------------------------------------------

function ns:HandleBadParryMonkey(
	feature,
	sourceGUID,
	sourceName,
	sourceFlags,
	destGUID,
	destName,
	raidIconIndex,
	missType
)
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

	-- The player's own parry, not their pet's.
	if sourceGUID == ns.playerGUID then
		Confess(feature.monkey, sourceFlags, destGUID, raidIconIndex)
	end

	local settings = feature.alert
	if not settings.enabled then
		return
	end

	--[[
	    An off-tank in front of the boss is there on purpose -- a taunt swap, a
	    pick-up -- and telling them to move is wrong, not merely noisy. The
	    player's own parries still report, tank or not: a tank reading their own
	    window asked to hear about themselves. FindTankUnit reads the same seat
	    test the scope gates do: Main Tank in a raid, the Tank role in a party.
	    Before the cooldown, so a tank's parries do not use it up.
	]]
	if settings.ignoreTanks and not ns.IsMineSource(sourceFlags) and ns.FindTankUnit(sourceGUID) then
		return
	end

	--[[
	    A pet in front of the boss is where its owner sent it, and the warning
	    would name the pet -- "Idiot is standing in front of Blackwing
	    Guardsman" -- which nobody in the group can act on, least of all the
	    hunter at range who is not reading it. Pets and guardians both, the way
	    Bad Pets counts them, and the player's own pet too. Before the cooldown,
	    for the same reason as above.
	]]
	if settings.ignorePets and ns.IsPetSource(sourceFlags) then
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
	    warning above still names the pet, for a player who unticked Ignore Pets.

	    The whisper rides the same election as the other Bad tabs', so a raid with four
	    Control Freak users sends the culprit one note rather than four.
	]]
	if settings.whisper and sourceName and not ns.IsMineSource(sourceFlags) and not ns.IsPetSource(sourceFlags) then
		ns:QueueGroupWhisper("parry", sourceGUID, sourceName, "PARRY_WHISPER", {
			destName or ns.L["UNKNOWN_TARGET"],
		})
	end
end
