local _, ns = ...

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

-- Filled by the swing dispatch in Features/Combat-Log.lua, and by ns:HandleTaunt through ns.RememberEnemyTarget.
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
