local _, ns = ...

--------------------------------------------------------------------------------
-- Ability Lookup
--------------------------------------------------------------------------------

--[[
    The flavors column in Data/Abilities.lua decides what this client tracks, so
    an entry marked "-" here is never registered and can never fire -- which is
    the only defence against Blizzard reusing an id for a different ability on
    another flavor, since the id still resolves and no existence check can tell.

    Everything else is registered. A trigger this client's spell data does not
    know is inert: it can never appear in this client's combat log, so ranks from
    other flavors cost nothing.

    The panel draws a row only for an entry with at least one trigger the client
    knows, which is what keeps TBC abilities off an Era panel. Name and icon come
    from the highest such trigger, so the label matches the tooltip and both read
    for the character looking at them -- and a renamed ability (Turn Undead became
    Turn Evil) shows whichever name this client uses.
]]
local ABILITY_MAP = {}
local ABILITY_GROUPS = {}

--[[
    Built on PLAYER_LOGIN rather than at file scope, because the flavor it reads
    is not answerable this early: Season of Discovery is told apart from Era by
    asking whether engraving is enabled, and that answer needs the character to be
    in. Core calls this before it registers the options panels, and the combat log
    is not hooked until later, so nothing reads either table before it runs.
]]
function ns.BuildAbilityIndex()
	wipe(ABILITY_MAP)
	wipe(ABILITY_GROUPS)

	local flavor = ns.GetFlavorIndex()

	for _, entry in ipairs(ns.ABILITIES) do
		if entry.flavors[flavor] ~= "-" then
			local group = {
				class = entry.class,
				category = entry.category,
				isAoe = entry.isAoe,
				ids = entry.triggers,
				knownIds = {},
			}

			for _, spellId in ipairs(entry.triggers) do
				ABILITY_MAP[spellId] = entry
				local name, icon = ns.GetSpellNameAndIcon(spellId)
				if name then
					group.knownIds[#group.knownIds + 1] = spellId
					group.maxRankId = spellId
					group.name, group.icon = name, icon
				end
			end

			if group.maxRankId then
				ABILITY_GROUPS[#ABILITY_GROUPS + 1] = group
			end
		end
	end
end

ns.ABILITY_MAP = ABILITY_MAP
ns.ABILITY_GROUPS = ABILITY_GROUPS

--------------------------------------------------------------------------------
-- Alert Gate
--------------------------------------------------------------------------------

ns.CATEGORY_FEATURE = {
	TAUNT = "taunts",
	FEAR = "fears",
	PET_TAUNT = "badPet",
	-- Both live on the Tanking Tools tab: the categories name the abilities, the
	-- tab names what a tank does about them.
	NOVA = "tankingTools",
	BUBBLE = "tankingTools",
}

--[[
    Scope is per feature, so each tab decides for itself, and which questions a
    tab asks comes from ns.FEATURE_SCOPE_OPTIONS -- a feature that never asks one
    stores no key for it, and the checks below read as false rather than needing
    a per-feature branch here.

    tankRoleOnly and groupHasTank are checked in ns:IsFeatureGateOpen but
    deliberately NOT in the registration test below. They read two signals -- the
    raid's Main Tank assignment and the group finder's TANK role -- and while the
    role has PLAYER_ROLES_ASSIGNED behind it, the assignment fires nothing
    reliable, so a registration keyed on the pair could still leave the combat log
    unhooked with no event to put it right. Zone has an event that fires, so it
    can gate registration and save the work when nothing could match.
]]
local function FeatureCouldFire(feature)
	if not feature or not feature.enabled then
		return false
	end
	if feature.instanceOnly then
		local inInstance, instanceType = IsInInstance()
		if not inInstance or (instanceType ~= "party" and instanceType ~= "raid") then
			return false
		end
	end
	return true
end

function ns:IsFeatureGateOpen(feature)
	if not FeatureCouldFire(feature) then
		return false
	end
	if feature.tankRoleOnly and not ns.IsPlayerTank() then
		return false
	end
	if feature.groupHasTank and not ns.GroupHasTank() then
		return false
	end
	return true
end

function ns:IsAlertGateOpen()
	local profile = ns.db and ns.db.profile
	if not profile or not profile.enabled then
		return false
	end
	for _, key in ipairs(ns.FEATURE_KEYS) do
		if FeatureCouldFire(profile[key]) then
			return true
		end
	end
	return false
end

function ns:UpdateCombatLogRegistration()
	if ns:IsAlertGateOpen() then
		ns.eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	else
		ns.eventFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end
end

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

    Unknown means report. The cache only ever suppresses on a positive match, so
    a mob nobody has seen swing still announces.
]]
local ENEMY_TARGET_LIMIT = 500
local SWING_SUBEVENTS = {
	SWING_DAMAGE = true,
	SWING_MISSED = true,
}

-- The three sub-events an armor debuff moves through. REFRESH is absent: at the
-- top stack it fires on every reapplication, and none of them is a new stack.
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
	-- The section switches first: the gate below reads the group's tank state,
	-- which is the expensive question, and every miss in the zone reaches here.
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
		-- Emptied whole when it fills rather than pruned: what is lost is only a
		-- line that would have been suppressed, and a raid night is a lot of corpses.
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

-- The strict opposite of the above: a mob nobody has been seen swinging at
-- answers false, so "not on somebody else" covers "not settled on anyone yet".
function ns.EnemyIsOnSomeoneElse(enemyGUID, playerGUID)
	if not enemyGUID then
		return false
	end
	local holder = enemyTarget[enemyGUID]
	return holder ~= nil and holder ~= playerGUID
end

--------------------------------------------------------------------------------
-- Combat Log Handler
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
	local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, _, destRaidFlags, spellId, spellName, _, extra, extraName =
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
		-- Mobs interrupt too. This branch returns before the ability path's own
		-- source gate below, so without this it happily reported a Defias Prisoner
		-- kicking the player's heal.
		if not ns.IsGroupSource(sourceFlags) then
			return
		end
		if not ns:IsFeatureGateOpen(ns.db.profile.interrupts) then
			return
		end
		-- Written in by hand because the raw combat log is excluded from the log,
		-- and these two slots are the ones an interrupt report is read for.
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
			isSwing and nil or spellName,
			isSwing and spellId or extra,
			isSwing
		)
	elseif ARMOR_SUBEVENTS[subevent] then
		-- Switch and spell id first, both table reads: an aura lands on somebody in
		-- the raid several times a second and almost none of them are ours.
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

	-- Only a single-target taunt reports a failure. An AoE taunt fires one miss
	-- per immune mob, which is noise rather than information.
	if not outcome and subevent == "SPELL_MISSED" and category == "TAUNT" and not ability.isAoe then
		outcome = "FAIL"
	end

	if not outcome then
		return
	end

	-- A refresh is not a new bubble.
	if category == "BUBBLE" and subevent ~= "SPELL_AURA_APPLIED" then
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
	elseif category == "BUBBLE" then
		ns:HandleBubble(
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
		ns:HandleBadPet(
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
