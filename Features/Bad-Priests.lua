local _, ns = ...

--[[
    Bad Priests, its own tab.

    A druid or warrior holds threat with rage, and rage comes from damage taken.
    Damage a shield absorbs generates none, so a well-meant Power Word: Shield
    starves the tank of the resource they tank with. That is true on Classic Era
    and Burning Crusade and not on later versions, which is why the ability's
    flavors column in Data/Abilities.lua carries "-" for Wrath: the ids are never
    registered there and the section can never fire.

    Three gates, cheapest first.

      class    the target has to be a rage tank at all. A priest shielding a
               paladin or a mage is nobody's problem.
      tanking  ns.FindTankUnit, the same seat test the scope gates read: Main
               Tank in a raid, the group finder's TANK role in a party. A feral
               druid in cat form is not tanking and does not want telling.
      health   a shield on somebody about to die is the right call, so the
               warning goes quiet below the line the player picked.

    selfOnly narrows all of it to the player. Ticked, the shield has to have
    landed on them and they have to be the rage tank; unticked, anybody in the
    group who is tanking as one of those classes counts.
]]

--[[
    The report is the group's, told to the player, so ns:Alert is handed the
    player's own affiliation rather than the caster's: the section draws one row
    and every warning has to file under it, whoever did the shielding. The
    caster is still required to be in the group -- the ability dispatch in
    Features/Combat-Log.lua checks that before this runs.
]]
local REPORT_AS = COMBATLOG_OBJECT_AFFILIATION_MINE

--[[
    casterGUID -> GetTime() of the last warning about them. One cooldown covers
    the print, the sound, the announce and the whisper: a healer shielding on
    cooldown must not fill the tank's window.
]]
local lastWarning = {}

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(lastWarning)
end

--[[
    Whether this shield landed somewhere worth complaining about. Returns the
    unit token of the tank it landed on, or nil.
]]
local function FindRageTank(settings, destGUID)
	if not destGUID then
		return nil
	end

	if settings.selfOnly and destGUID ~= ns.playerGUID then
		return nil
	end

	local _, class = GetPlayerInfoByGUID(destGUID)
	if not class or not ns.RAGE_TANK_CLASSES[class] then
		return nil
	end

	return ns.FindTankUnit(destGUID)
end

--[[
    The raid mark is not read: the shield lands on a friendly tank, and a mark on
    a group member is not what the marked-target override is for.
]]
function ns:HandleBadPriest(
	feature,
	sourceGUID,
	sourceName,
	sourceFlags,
	destGUID,
	destName,
	_raidIconIndex,
	spellId,
	spellName
)
	local settings = feature.alert
	if not settings or not settings.enabled then
		return
	end

	--[[
	    Never warn about your own shield on yourself: a priest is not a rage tank,
	    so this only fires when somebody has hand-cast it on their own character.
	]]
	if sourceGUID == destGUID then
		return
	end

	local unit = FindRageTank(settings, destGUID)
	if not unit then
		return
	end

	local maxHealth = UnitHealthMax(unit)
	if not maxHealth or maxHealth == 0 then
		return
	end

	--[[
	    The threshold is a percentage and zero means "Always", so the comparison
	    is against the number the player picked rather than a stored fraction.
	]]
	local threshold = ns.ResolveChoice(settings.health, ns.SHIELD_HEALTH_THRESHOLDS, ns.SHIELD_HEALTH_THRESHOLD_DEFAULT)
	if threshold > 0 and (UnitHealth(unit) / maxHealth) * 100 < threshold then
		return
	end

	--[[
	    No enemy guid to hand the target filter: a shield lands on a friendly
	    tank, so there is nothing here to classify and the section is drawn
	    noTarget. nil lets the alert through rather than asking whether a player
	    is a raid boss.
	]]
	if not ns:PassesAlertGates(settings, REPORT_AS, nil, nil) then
		return
	end

	local now = GetTime()
	local last = lastWarning[sourceGUID]
	local cooldown = ns.ResolveChoice(settings.cooldown, ns.BAD_PET_COOLDOWNS, ns.SHIELD_COOLDOWN_DEFAULT)
	if last and now - last < cooldown then
		return
	end
	lastWarning[sourceGUID] = now

	local casterPart = ns.PlayerPart(sourceName, sourceGUID)
	local spellPart = ns.SpellPart(spellId, spellName)
	local tankPart = ns.PlayerPart(destName, destGUID)

	ns:Alert(settings, "SHIELD_WARNING", { casterPart, spellPart, tankPart }, REPORT_AS, nil, nil)

	ns.LogWhisperStep("decide (whisper, caster)", settings.whisper, sourceName)

	--[[
	    Never whisper yourself, the way the parry warning does not: a player who
	    shielded their own character is reading the print already.

	    The whisper rides the same election as Bad Pets' and Parry's, so a raid
	    with four Control Freak users sends the healer one note rather than four.
	]]
	if settings.whisper and sourceName and not ns.IsMineSource(sourceFlags) then
		ns:QueueGroupWhisper("shield", sourceGUID, sourceName, "SHIELD_WHISPER", {
			ns.GetSpellDisplay(spellId, spellName),
			ns.ShortName(destName),
		})
	end
end
