local _, ns = ...

--[[
    Armor Debuffs, one of the Tanking Tools.

    Armor is the tank's damage and the raid's, and the interesting number is not
    that the debuffs are up but how long the group took to get them there. Timed
    from the first component to land, reported once the set is complete.

    "The set" is not just Sunder. Five Sunders OR a rogue's Expose Armor answers
    the armor question, and a player can ask for Faerie Fire and Curse of
    Recklessness on top -- but only ever waits on those when the group actually
    has a druid or a warlock in it, or the line would never print.

    Stacks are counted here rather than read from the combat log's dose field.
    That amount sits in a different return slot per sub-event, and one wrong slot
    reports a number that is silently incorrect, while a count restarted by every
    fresh SPELL_AURA_APPLIED cannot be.
]]

local DEBUFF_BY_ID = {}
for _, debuff in ipairs(ns.ARMOR_DEBUFFS) do
	for _, spellId in ipairs(debuff.ids) do
		DEBUFF_BY_ID[spellId] = debuff
	end
end

-- Read by the combat-log dispatch, so an aura landing on anybody is dropped on a
-- table lookup rather than on a group scan.
function ns.IsArmorDebuffSpell(spellId)
	return DEBUFF_BY_ID[spellId] ~= nil
end

-- destGUID -> { started, counts, reported }. Bounded rather than pruned, the way
-- the other per-mob caches are.
local runs = {}
local runCount = 0
local RUN_LIMIT = 200

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(runs)
	runCount = 0
end

local function Forget(destGUID)
	if runs[destGUID] then
		runs[destGUID] = nil
		runCount = runCount - 1
	end
end

--[[
    Whether everything this player asked for is up. The armor half is an OR --
    Sunder or Expose, either one -- while each extra is an AND, but only when the
    player asked for it AND somebody in the group could cast it.
]]
local function IsComplete(counts, settings)
	local armor = false

	for _, debuff in ipairs(ns.ARMOR_DEBUFFS) do
		local up = (counts[debuff.key] or 0) >= debuff.stacks
		if debuff.satisfies == "ARMOR" then
			armor = armor or up
		elseif settings[debuff.setting] and ns.GroupHasClass(debuff.requiresClass) then
			if not up then
				return false
			end
		end
	end

	return armor
end

--[[
    subevent is one of SPELL_AURA_APPLIED, SPELL_AURA_APPLIED_DOSE or
    SPELL_AURA_REMOVED; the caller has already checked that.

    A fresh APPLIED starts that component's count over, which is what makes the
    Sunder count reliable: a target whose stack falls off and is re-sundered times
    from its own first stack rather than inheriting a half-finished one.
]]
function ns:HandleArmorDebuffs(feature, subevent, sourceFlags, destGUID, destName, raidIconIndex, spellId)
	local debuff = DEBUFF_BY_ID[spellId]
	if not debuff or not destGUID then
		return
	end

	--[[
	    Only the ARMOR component ending ends the run. Faerie Fire dropping is one
	    reapplication away and the armor is still down; Sunder or Expose dropping
	    means the group is starting over, which is a new thing to time.
	]]
	if subevent == "SPELL_AURA_REMOVED" then
		if debuff.satisfies == "ARMOR" then
			Forget(destGUID)
		end
		return
	end

	local run = runs[destGUID]
	if not run then
		if runCount >= RUN_LIMIT then
			wipe(runs)
			runCount = 0
		end
		runCount = runCount + 1
		run = { started = GetTime(), counts = {}, reported = false }
		runs[destGUID] = run
	end

	if subevent == "SPELL_AURA_APPLIED" then
		run.counts[debuff.key] = 1
	else
		run.counts[debuff.key] = (run.counts[debuff.key] or 0) + 1
	end

	if run.reported then
		return
	end

	local settings = feature.armor
	if not settings or not IsComplete(run.counts, settings) then
		return
	end
	run.reported = true

	-- One decimal place. A stack-up is measured in globals, and a second's
	-- precision would round most of the interesting range to the same number.
	local elapsed = string.format("%.1f", GetTime() - run.started)

	ns:Alert(settings, "ARMOR_REPORT", {
		ns.TargetPart(destName, raidIconIndex),
		elapsed,
	}, sourceFlags, destGUID)
end
