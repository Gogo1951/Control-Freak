local _, ns = ...

local bit_band = bit.band

-- Wiped and refilled by ns.BuildAbilityIndex, so this alias stays pointed at the live table.
local ABILITY_MAP = ns.ABILITY_MAP

--------------------------------------------------------------------------------
-- Who Each Enemy Is Already On
--------------------------------------------------------------------------------

--[[
    A taunt on a mob that was already hitting you is a threat refresh, not news,
    so the success alert needs to know who the mob was on a moment ago.

    It cannot be asked. By the time the taunt's aura lands the mob has already
    changed target, so reading it from a nameplate or unit token answers with the
    taunter every time. The combat log is the only source that is strictly
    earlier, and melee swings are the honest signal: a mob melees whoever it is
    actually on, while a spell can land anywhere.

    Unknown means report, FOR TAUNTS. That consumer only ever suppresses on a
    positive match, so a mob nobody has seen swing still announces.

    The parry warning reads the same cache the other way round and wants the
    opposite: it asks ns.EnemyIsOnSomeoneElse and stays quiet on an unknown mob,
    because a parry with no holder on record is the opening exchange of a pull
    rather than somebody standing wrong. Read a consumer's own file before
    assuming which way an unknown answers.
]]
local ENEMY_TARGET_LIMIT = 500
local SWING_SUBEVENTS = {
	SWING_DAMAGE = true,
	SWING_MISSED = true,
}

--[[
    The three sub-events an armor debuff moves through. REFRESH is absent: at the
    top stack it fires on every reapplication, and none of them is a new stack.
]]
local ARMOR_SUBEVENTS = {
	SPELL_AURA_APPLIED = true,
	SPELL_AURA_APPLIED_DOSE = true,
	SPELL_AURA_REMOVED = true,
}

--[[
    Cold Opener and Parry both key off an avoided attack, so one dispatch reads
    the event and hands each the shape it wants.

    They disagree about auto-attacks, and deliberately. A cold opener is about
    abilities -- an auto-attack is dodged constantly against a boss and reporting
    those would bury the specials -- while a parry from a melee DPS standing in
    front comes mostly FROM auto-attacks, which are the ones worth catching.
]]
function ns:DispatchTankingToolMiss(
	sourceGUID,
	sourceName,
	sourceFlags,
	destGUID,
	destName,
	raidIconIndex,
	spellId,
	spellName,
	missType,
	isSwing
)
	--[[
	    The section switches first: the gate below reads the group's tank state,
	    which is the expensive question, and every miss in the zone reaches here.
	]]
	local tankingTools = ns.db.profile.tankingTools
	if not tankingTools.coldOpener.enabled and not tankingTools.parry.enabled then
		return
	end

	if not ns.IsGroupSource(sourceFlags) then
		return
	end

	if not ns:IsFeatureGateOpen(tankingTools) then
		return
	end

	if not isSwing then
		ns:HandleColdOpener(
			tankingTools,
			sourceGUID,
			sourceName,
			sourceFlags,
			destGUID,
			destName,
			raidIconIndex,
			spellId,
			spellName,
			missType
		)
	end

	ns:HandleParry(tankingTools, sourceGUID, sourceName, sourceFlags, destGUID, destName, raidIconIndex, missType)
end

-- Filled by the swing dispatch below, and by ns:HandleTaunt through ns.RememberEnemyTarget.
local enemyTarget = {}
local enemyTargetCount = 0

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(enemyTarget)
	enemyTargetCount = 0
end

function ns.RememberEnemyTarget(enemyGUID, playerGUID)
	if not enemyGUID or not playerGUID then
		return
	end
	if not ns.IsPlayerGUID(playerGUID) or ns.IsPlayerGUID(enemyGUID) then
		return
	end
	if enemyTarget[enemyGUID] == nil then
		--[[
		    Emptied whole when it fills rather than pruned: what is lost is only a
		    line that would have been suppressed, and a raid night is a lot of corpses.
		]]
		if enemyTargetCount >= ENEMY_TARGET_LIMIT then
			wipe(enemyTarget)
			enemyTargetCount = 0
		end
		enemyTargetCount = enemyTargetCount + 1
	end
	enemyTarget[enemyGUID] = playerGUID
end

function ns.EnemyWasAlreadyOn(enemyGUID, playerGUID)
	return enemyGUID ~= nil and enemyTarget[enemyGUID] == playerGUID
end

--[[
    The strict opposite of the above: a mob nobody has been seen swinging at
    answers false, so "not on somebody else" covers "not settled on anyone yet".
]]
function ns.EnemyIsOnSomeoneElse(enemyGUID, playerGUID)
	if not enemyGUID then
		return false
	end
	local holder = enemyTarget[enemyGUID]
	return holder ~= nil and holder ~= playerGUID
end

--------------------------------------------------------------------------------
-- Raid Icons
--------------------------------------------------------------------------------

local RAID_ICON_INDEX = {
	[COMBATLOG_OBJECT_RAIDTARGET1] = 1,
	[COMBATLOG_OBJECT_RAIDTARGET2] = 2,
	[COMBATLOG_OBJECT_RAIDTARGET3] = 3,
	[COMBATLOG_OBJECT_RAIDTARGET4] = 4,
	[COMBATLOG_OBJECT_RAIDTARGET5] = 5,
	[COMBATLOG_OBJECT_RAIDTARGET6] = 6,
	[COMBATLOG_OBJECT_RAIDTARGET7] = 7,
	[COMBATLOG_OBJECT_RAIDTARGET8] = 8,
}

function ns.GetRaidIconIndex(destRaidFlags)
	if not destRaidFlags then
		return nil
	end
	return RAID_ICON_INDEX[bit_band(destRaidFlags, COMBATLOG_OBJECT_RAIDTARGET_MASK)]
end

--------------------------------------------------------------------------------
-- COMBAT_LOG_EVENT_UNFILTERED
--------------------------------------------------------------------------------

--[[
    One AoE taunt lands a separate aura on every mob it hits, so identical
    timestamp + spell + outcome is the same cast reported again.

    The outcome is part of the key on purpose. Never throttle on source plus
    spell across a time window: that collapses a cast and the miss that follows
    it into one event, and every resisted taunt is swallowed.
]]
local lastTimestamp, lastSpellId, lastOutcome

function ns:COMBAT_LOG_EVENT_UNFILTERED()
	local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, _, extra, extraName =
		CombatLogGetCurrentEventInfo()

	--[[
	    For SPELL_INTERRUPT the fifteenth and sixteenth returns are the interrupted
	    spell's id and name; for SPELL_MISSED the fifteenth carries the miss type
	    instead.

	    Take the name as well as the id. Era reports the id as 0 for some
	    interrupts, and the name is then the only thing that can name the spell
	    that was stopped.
	]]
	if subevent == "SPELL_INTERRUPT" then
		--[[
		    Mobs interrupt too. This branch returns before the ability path's own
		    source gate below, so it needs a source gate of its own.
		]]
		if not ns.IsGroupSource(sourceFlags) then
			return
		end
		if not ns:IsFeatureGateOpen(ns.db.profile.interrupts) then
			return
		end
		--[[
		    Written in by hand because the raw combat log is excluded from the log,
		    and these two slots are the ones an interrupt report is read for.
		]]
		if ns.diagnostics and ns.diagnostics.logging and ns.LogEventNow then
			ns:LogEventNow("COMBAT_LOG_EVENT_UNFILTERED", subevent, sourceName, destName, spellId, extra, extraName)
		end
		ns:HandleInterrupt(
			timestamp,
			sourceGUID,
			sourceName,
			sourceFlags,
			destGUID,
			destName,
			ns.GetRaidIconIndex(destRaidFlags),
			spellId,
			spellName,
			extra,
			extraName
		)
		return
	end

	-- Ahead of the ability lookup, because a swing carries no tracked spell id.
	if SWING_SUBEVENTS[subevent] then
		ns.RememberEnemyTarget(sourceGUID, destGUID)
	end

	-- Only Cold Opener reads the pull clock, so nothing else pays to keep it.
	local tankingToolsProfile = ns.db.profile.tankingTools
	if tankingToolsProfile.enabled and tankingToolsProfile.coldOpener.enabled then
		ns.RememberEnemyFirstSeen(sourceGUID)
		ns.RememberEnemyFirstSeen(destGUID)
	end

	--[[
	    Incapacitated names the mob that took the player out of the fight, and
	    C_LossOfControl carries no caster at all. This is the only place that name
	    is reliable -- the debuff's own sourceUnit is a token, so it resolves only
	    while the mob happens to be somebody's target or on a name plate -- so the
	    aura is stamped on the way past and read back a moment later when
	    LOSS_OF_CONTROL_ADDED fires. Features/Interrupts.lua keeps the spell id
	    Era omits the same way.

	    DEBUFF only, and behind that feature's own switches and one guid
	    comparison: auras land on the player several times a second in a raid,
	    almost none of them take control away, and a heal over time overwriting
	    the slot would cost the fear beside it its caster.

	    Incapacitated is its own feature rather than a Tanking Tool, so this is
	    the one place in this file reaching outside the tab whose event it is
	    handling.
	]]
	local incapacitatedProfile = ns.db.profile.incapacitated
	if
		subevent == "SPELL_AURA_APPLIED"
		and extra == "DEBUFF"
		and destGUID == ns.playerGUID
		and incapacitatedProfile.enabled
		and incapacitatedProfile.alert.enabled
	then
		ns.RememberIncapacitatingAura(spellId, sourceName)
	end

	--[[
	    Tank Deaths, which reads a sub-event the rest of this file has no use for
	    and which carries no tracked ability, so it is handled here rather than
	    past the lookup below.

	    UNIT_DIED is the only event that reports somebody else's death at the
	    moment it happens: UNIT_HEALTH arrives late and not for every unit, and
	    the raid frames are a picture rather than something a handler can hook.
	    It names no source, so the dead player's own flags travel with it.
	]]
	if subevent == "UNIT_DIED" then
		ns:HandleUnitDeath(destGUID, destName, destFlags)
	end

	--[[
	    Cold Opener, Armor Debuffs and Parry read raw combat outcomes rather than a
	    tracked ability, so they run BEFORE the ability lookup below -- that lookup
	    drops every spell id the add-on does not own, which is all of theirs.

	    The miss type arrives in a different slot per sub-event: SWING_MISSED has
	    no spell, so its twelfth return IS the miss type and lands in the spellId
	    variable; SPELL_MISSED keeps the spell in twelve and puts the miss type in
	    fifteen. Reading the wrong one silently compares a number to "PARRY" and
	    the feature never fires.
	]]
	if subevent == "SWING_MISSED" or subevent == "SPELL_MISSED" then
		local isSwing = subevent == "SWING_MISSED"
		ns:DispatchTankingToolMiss(
			sourceGUID,
			sourceName,
			sourceFlags,
			destGUID,
			destName,
			ns.GetRaidIconIndex(destRaidFlags),
			isSwing and 0 or spellId,
			not isSwing and spellName or nil,
			isSwing and spellId or extra,
			isSwing
		)
	elseif ARMOR_SUBEVENTS[subevent] then
		--[[
		    Switch and spell id first, both table reads: an aura lands on somebody in
		    the raid several times a second and almost none of them are ours.
		]]
		local tankingTools = ns.db.profile.tankingTools
		if
			tankingTools.armor.enabled
			and ns.IsArmorDebuffSpell(spellId)
			and ns.IsGroupSource(sourceFlags)
			and ns:IsFeatureGateOpen(tankingTools)
		then
			ns:HandleArmorDebuffs(
				tankingTools,
				subevent,
				sourceFlags,
				destGUID,
				destName,
				ns.GetRaidIconIndex(destRaidFlags),
				spellId
			)
		end
	end

	if SWING_SUBEVENTS[subevent] then
		return
	end

	local ability = ABILITY_MAP[spellId]
	if not ability then
		return
	end
	if ns.db.profile.ignoredSpells[spellId] then
		return
	end
	if not ns.IsGroupSource(sourceFlags) then
		return
	end

	local category = ability.category
	if category == "PET_TAUNT" and not ns.IsPetSource(sourceFlags) then
		return
	end

	local feature = ns.db.profile[ns.CATEGORY_FEATURE[category]]
	if not ns:IsFeatureGateOpen(feature) then
		return
	end

	local outcome
	if ability.detection == "AURA" then
		if subevent == "SPELL_AURA_APPLIED" or subevent == "SPELL_AURA_REFRESH" then
			outcome = "SUCCESS"
		end
	elseif subevent == "SPELL_CAST_SUCCESS" then
		outcome = "SUCCESS"
	end

	--[[
	    Only a single-target taunt reports a failure. An AoE taunt fires one miss
	    per immune mob, which is noise rather than information.
	]]
	if not outcome and subevent == "SPELL_MISSED" and category == "TAUNT" and not ability.isAoe then
		outcome = "FAIL"
	end

	if not outcome then
		return
	end

	--[[
	    A refresh is not a new shield. A healer keeping one rolling on the tank
	    reapplies it constantly, and every reapplication is the same mistake
	    already reported, so only the aura first landing counts.
	]]
	if category == "SHIELD" and subevent ~= "SPELL_AURA_APPLIED" then
		return
	end

	if timestamp == lastTimestamp and spellId == lastSpellId and outcome == lastOutcome then
		return
	end
	lastTimestamp, lastSpellId, lastOutcome = timestamp, spellId, outcome

	local raidIconIndex = ns.GetRaidIconIndex(destRaidFlags)

	if ns.diagnostics and ns.diagnostics.logging and ns.LogEventNow then
		ns:LogEventNow("COMBAT_LOG_EVENT_UNFILTERED", subevent, sourceName, destName, spellId, outcome)
	end

	if category == "TAUNT" then
		ns:HandleTaunt(
			feature,
			outcome,
			extra,
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
	elseif category == "FEAR" then
		ns:HandleFear(
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
	elseif category == "NOVA" then
		ns:HandleNova(
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
	elseif category == "SHIELD" then
		ns:HandleBadPriest(
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
	elseif category == "PET_TAUNT" then
		ns:HandleBadPets(
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
	end
end
