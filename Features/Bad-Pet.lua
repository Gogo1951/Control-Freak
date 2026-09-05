local _, ns = ...

-- petGUID -> GetTime() of the last alert for that pet. One cooldown covers the
-- print, the sound, the announce, and the whisper. The player picks its length
-- on the Bad Pet tab; a profile written before the setting existed reads the
-- default rather than falling through to no cooldown at all.
local lastAlert = {}

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(lastAlert)
end

function ns:HandleBadPet(
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
	local now = GetTime()
	local last = lastAlert[sourceGUID]
	local cooldown = ns.ResolveChoice(feature.cooldown, ns.BAD_PET_COOLDOWNS, ns.BAD_PET_COOLDOWN_DEFAULT)
	if last and now - last < cooldown then
		return
	end
	lastAlert[sourceGUID] = now

	local settings = feature.alert
	local _, ownerName, ownerGUID = ns.FindPetOwner(sourceGUID)
	local isMine = ownerGUID ~= nil and ownerGUID == ns.playerGUID

	-- A pet's guid carries no class, so it takes the color of the class whose
	-- ability it just cast.
	local petPart = ns.PlayerPart(sourceName, nil, ability.class)
	local spellPart = ns.SpellPart(spellId, spellName)
	local targetPart = ns.TargetPart(destName, raidIconIndex)

	local formatKey, parts
	if isMine then
		if ability.isAoe then
			formatKey, parts = "BAD_PET_OWN_AOE", { petPart, spellPart }
		else
			formatKey, parts = "BAD_PET_OWN", { petPart, spellPart, targetPart }
		end
	elseif ownerName then
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

	ns:Alert(settings, formatKey, parts, sourceFlags, destGUID)

	ns.LogWhisperStep("decide (whisper, owner, isMine)", feature.whisper, ownerName, isMine)

	if feature.whisper and ownerName and not isMine then
		ns:QueueGroupWhisper("pet", sourceGUID, ownerName, "BAD_PET_WHISPER", {
			ns.ShortName(sourceName),
			ns.GetSpellDisplay(spellId, spellName),
			destName or ns.L["UNKNOWN_TARGET"],
		})
	end
end
