local _, ns = ...

local UNIT_TOKENS = ns.UNIT_TOKENS

--[[
    petGUID -> GetTime() of the last alert for that pet. One cooldown covers the
    print, the sound, the announce, and the whisper. The player picks its length
    on the Bad Pets tab; a profile written before the setting existed reads the
    default rather than falling through to no cooldown at all.
]]
local lastAlert = {}

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(lastAlert)
end

-- The owner's pet is addressed as "partypetN" / "raidpetN", never "partyNpet".
function ns.FindPetOwner(petGUID)
	if not petGUID then
		return nil
	end

	if UnitGUID("pet") == petGUID then
		return "player", GetUnitName("player", true), UnitGUID("player")
	end

	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			if UnitGUID(UNIT_TOKENS.raidpet[i]) == petGUID then
				local unit = UNIT_TOKENS.raid[i]
				return unit, GetUnitName(unit, true), UnitGUID(unit)
			end
		end
	elseif IsInGroup() then
		for i = 1, 4 do
			if UnitGUID(UNIT_TOKENS.partypet[i]) == petGUID then
				local unit = UNIT_TOKENS.party[i]
				return unit, GetUnitName(unit, true), UnitGUID(unit)
			end
		end
	end

	return nil
end

function ns:HandleBadPets(
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
	    The section's own gates first: a growl its switch or its target filters
	    drop must not whisper the owner, and must not use up the cooldown that
	    would then swallow the next real one.
	]]
	if not ns:PassesAlertGates(settings, sourceFlags, destGUID, raidIconIndex) then
		return
	end

	local now = GetTime()
	local last = lastAlert[sourceGUID]
	local cooldown = ns.ResolveChoice(feature.cooldown, ns.BAD_PET_COOLDOWNS, ns.BAD_PET_COOLDOWN_DEFAULT)
	if last and now - last < cooldown then
		return
	end
	lastAlert[sourceGUID] = now

	local _, ownerName, ownerGUID = ns.FindPetOwner(sourceGUID)
	local isMine = ownerGUID ~= nil and ownerGUID == ns.playerGUID

	--[[
	    A pet's guid carries no class, so it takes the color of the class whose
	    ability it just cast.
	]]
	local petPart = ns.PlayerPart(sourceName, nil, ability.class)
	local spellPart = ns.SpellPart(spellId, spellName)
	local targetPart = ns.TargetPart(destName, raidIconIndex)

	--[[
	    The player's own pet takes the same line as anybody's, naming the owner:
	    the My row can announce, and a line addressing "your pet" would tell the
	    whole group the pet is theirs.
	]]
	local formatKey, parts
	if ownerName then
		local ownerPart = ns.PlayerPart(ownerName, ownerGUID)
		if ability.isAoe then
			formatKey, parts = "BAD_PET_AOE", { ownerPart, petPart, spellPart }
		else
			formatKey, parts = "BAD_PET", { ownerPart, petPart, spellPart, targetPart }
		end
	else
		if ability.isAoe then
			formatKey, parts = "BAD_PET_UNKNOWN_OWNER_AOE", { petPart, spellPart }
		else
			formatKey, parts = "BAD_PET_UNKNOWN_OWNER", { petPart, spellPart, targetPart }
		end
	end

	--[[
	    Whose row this lands on comes from the pet's own affiliation bit, which
	    already reads MINE for the player's pet. An AOE pet taunt (Suffering)
	    names no single mob, so neither target filter has anything to work on:
	    there is no mark to override with, and the rung passes it as
	    unanswerable.
	]]
	ns:Alert(settings, formatKey, parts, sourceFlags, destGUID, raidIconIndex)

	ns.LogWhisperStep("decide (whisper, owner, isMine)", feature.whisper, ownerName, isMine)

	if feature.whisper and ownerName and not isMine then
		if ability.isAoe then
			ns:QueueGroupWhisper("pet", sourceGUID, ownerName, "BAD_PET_WHISPER_AOE", {
				ns.ShortName(sourceName),
				ns.GetSpellDisplay(spellId, spellName),
			})
		else
			ns:QueueGroupWhisper("pet", sourceGUID, ownerName, "BAD_PET_WHISPER", {
				ns.ShortName(sourceName),
				ns.GetSpellDisplay(spellId, spellName),
				destName or ns.L["UNKNOWN_TARGET"],
			})
		end
	end
end
