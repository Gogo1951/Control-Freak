local _, ns = ...

local UNIT_TOKENS = ns.UNIT_TOKENS

--------------------------------------------------------------------------------
-- Enemy Lookups
--------------------------------------------------------------------------------

--[[
    The combat log names a mob with a guid and nothing else -- no level, no
    classification, no elite bit -- so the target ladder has to find a unit token
    pointing at the same mob and read it from there.

    Candidates are ordered by how likely they are to be the mob in question. Your
    own target leads, because a single-target taunt needs one and the taunt just
    landed; then the frames a fight puts up, then every name plate on screen, and
    last the group's own targets -- the taunter's target IS the mob they taunted,
    which is what answers for somebody else's taunt across the room.

    focus and boss1-5 do not exist on every client. UnitGUID answers nil for a
    unit token the client does not have, so an absent frame costs one nil compare
    rather than needing a capability probe.
]]
local ENEMY_UNIT_CANDIDATES = {
	"target",
	"focus",
	"mouseover",
	"boss1",
	"boss2",
	"boss3",
	"boss4",
	"boss5",
}

local function FindEnemyUnit(guid)
	for _, unit in ipairs(ENEMY_UNIT_CANDIDATES) do
		if UnitGUID(unit) == guid then
			return unit
		end
	end

	if C_NamePlate and C_NamePlate.GetNamePlates then
		for _, plate in ipairs(C_NamePlate.GetNamePlates()) do
			local unit = plate.namePlateUnitToken
			if unit and UnitGUID(unit) == guid then
				return unit
			end
		end
	end

	local tokens, count
	if IsInRaid() then
		tokens, count = UNIT_TOKENS.raidTarget, GetNumGroupMembers()
	elseif IsInGroup() then
		tokens, count = UNIT_TOKENS.partyTarget, 4
	else
		return nil
	end

	for index = 1, count do
		local unit = tokens[index]
		if UnitGUID(unit) == guid then
			return unit
		end
	end

	return nil
end

--[[
    A mob's rung on the Against ladder (ns.TARGET_RUNGS in Data/Data.lua), which
    is what "worth the attention" means now that it is a threshold rather than a
    switch. The client hands over two facts, a classification and a level, and
    the ladder is read off them:

      BOSS     the skull -- worldboss classification, or level -1, which reads
               as "??" in game
      ELITE_0  elite or rareelite at or above the player's level
      ELITE    elite or rareelite below the player's level
      ALL      everything else

    ELITE_0 is where a dungeon boss lives, and it is the rung that thins the
    trash out from under it. A boss carries no skull, so the only thing telling
    it apart from the elites around it is level: a level 60 clearing a level 60
    dungeon meets trash from 58 and bosses at 61-63.

    THREE kinds of answer, not two. nil means the question could not be asked --
    no unit token pointed at the mob, or the guid is a player's because the
    ability was cast on a group member -- and ns:Alert treats that as a pass.
    Failing closed would trade a little trash noise for silently swallowing the
    one boss taunt the filter was turned on for, which is the worse of the two.

    The answer is kept per guid because a mob's level and classification never
    change within a fight. Emptied whole when it fills, the way the enemy-target
    cache is: what it costs is one lookup again, and a raid night is a lot of
    corpses. A level-up mid-session moves ELITE_0 under a cached answer, which
    the next loading screen puts right.
]]
-- Rung name -> position in the ladder, so a comparison is one table read.
ns.TARGET_TIER = {}
for index, rung in ipairs(ns.TARGET_RUNGS) do
	ns.TARGET_TIER[rung] = index
end

local ELITE_CLASSIFICATIONS = { elite = true, rareelite = true }
local TIER = ns.TARGET_TIER
local TIER_CACHE_LIMIT = 500

local tierByGUID = {}
local tierCacheCount = 0

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(tierByGUID)
	tierCacheCount = 0
end

local function ClassifyUnit(unit)
	local classification = UnitClassification(unit)
	local level = UnitLevel(unit)

	if classification == "worldboss" or level == -1 then
		return TIER.BOSS
	end

	if ELITE_CLASSIFICATIONS[classification] then
		if level >= UnitLevel("player") then
			return TIER.ELITE_0
		end
		return TIER.ELITE
	end

	return TIER.ALL
end

function ns.GetEnemyTier(guid)
	if not guid then
		return nil
	end

	--[[
	    An ability cast on a group member (Righteous Defense) hands us a player
	    rather than the mob. Unanswerable, which ns:Alert lets through.
	]]
	if ns.IsPlayerGUID(guid) then
		return nil
	end

	local cached = tierByGUID[guid]
	if cached ~= nil then
		return cached
	end

	local unit = FindEnemyUnit(guid)
	if not unit then
		return nil
	end

	local tier = ClassifyUnit(unit)

	if tierCacheCount >= TIER_CACHE_LIMIT then
		wipe(tierByGUID)
		tierCacheCount = 0
	end
	tierByGUID[guid] = tier
	tierCacheCount = tierCacheCount + 1

	return tier
end
