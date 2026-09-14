local _, ns = ...

--[[
    Tank Deaths.

    Somebody in the group has died. Most of the time that is news for exactly one
    person, and they already have it. One death is not like that: the tank, who
    was holding everything in the room. That one changes what every other person
    should do in the next second, and it is the one the raid frames are worst at
    telling you about -- forty portraits and one of them just went grey.

    So the tab is the tank death, plus a LOG beside it: nine class rows, no
    sounds, for the player who wants to watch one class go down and nothing
    else. The distinction is the whole design, and it is why the class rows have
    no sound picker -- nine sounds on a wipe is a drum solo.

    The tank death is an alert like any other, so it goes through ns:Alert and
    its My and Others' rows decide print or announce. The log goes through
    ns:PrintLine: a watch list somebody keeps for themselves has nowhere to go
    but their own window.
]]

local HAS_FEIGN_DEATH = type(UnitIsFeignDeath) == "function"

--[[
    GetTime() of the last line for each class, so a wipe reads as a handful of
    lines rather than a wall. ns.DEATH_CLASS_COOLDOWN says why it is a constant.
    Keyed by class token, so it cannot grow past nine entries.
]]
local lastClassAlert = {}

ns.stateResets[#ns.stateResets + 1] = function()
	wipe(lastClassAlert)
end

--[[
    Whether the dead player was the tank, which is the one seat this tab reports.
    ns.IsUnitTank decides, and in a raid that means the Main Tank assignment
    alone: a healer still wearing a Tank tag from a dungeon queue would otherwise
    be reported as "Tank Down!", and Features/Utilities.lua says why the tag
    counts only in a party.
]]
local function IsTank(unit)
	return unit and ns.IsUnitTank(unit) or false
end

--[[
    UNIT_DIED, from Features/Combat-Log.lua. The combat log is the only place
    that reports somebody else's death at the moment it happens -- UNIT_HEALTH
    arrives late and not for everybody, and the raid frames are a picture rather
    than an event.

    A mob or a pet dying is most of what UNIT_DIED carries in a fight, so a GUID
    that is not a player's is dropped on a string test before the group walk.
    A player is then found by walking the group for their GUID, which does
    double duty: it establishes they were in the group at all, and it hands over
    the unit token the seat test needs.

    destFlags are the dead player's affiliation. A death has no caster, and
    ns:Alert reads these where it would read a caster's: to check the line is
    about somebody in the group.
]]
function ns:HandleUnitDeath(destGUID, destName, destFlags)
	if not ns.IsPlayerGUID(destGUID) then
		return
	end

	local profile = ns.db and ns.db.profile
	if not profile or not profile.enabled then
		return
	end

	local feature = profile.tankDeaths
	if not feature or not feature.enabled then
		return
	end

	local unit = ns.FindGroupUnit(destGUID)
	if not unit then
		return
	end

	-- Feign Death reaches the combat log as UNIT_DIED.
	if HAS_FEIGN_DEATH and UnitIsFeignDeath(unit) then
		return
	end

	--[[
	    The tab's own scope gates, asked here rather than by the registration test
	    in Features/Alert-Gates.lua, the same way Incapacitated asks its own: this
	    handler runs off a sub-event nothing else has gated, and a death is rare
	    enough that asking costs nothing.
	]]
	if not ns:IsFeatureGateOpen(feature) then
		return
	end

	local _, class = GetPlayerInfoByGUID(destGUID)
	local playerPart = ns.PlayerPart(destName, destGUID, class)
	local isMine = destGUID == ns.playerGUID

	--[[
	    The seat beats the class, and only one line is ever sent. A warrior
	    tank dying with Warrior ticked is one event, and the seat is the reason
	    anybody cares -- "Tank Down!" says everything the Warrior line would have
	    and the thing it would not.

	    The row is named outright rather than left to the flags, and its switch
	    is read here rather than left to ns:Alert, because a tank death the
	    section is not going to report falls through to the log below. Somebody
	    who switched Others' Tank Deaths off and ticked Warrior asked to hear
	    about warriors, and a warrior who happened to be tanking is still one.
	]]
	local settings = feature.alert
	local rowKey = isMine and "mine" or "others"
	local row = settings[rowKey]
	if IsTank(unit) and settings.enabled and row and row.enabled then
		ns:Alert(settings, "TANK_DEATHS_TANK_LINE", { playerPart }, destFlags, nil, nil, rowKey)
		return
	end

	--[[
	    Your own death never reaches the log. You are looking at a release
	    button, and a list kept for watching other people go down has nothing to
	    tell you about yourself. Your own death reaches only the My row above,
	    and only while you are tanking.
	]]
	if isMine then
		return
	end

	if not class or not feature.classes[class] then
		return
	end

	local now = GetTime()
	local last = lastClassAlert[class]
	if last and now - last < ns.DEATH_CLASS_COOLDOWN then
		return
	end
	lastClassAlert[class] = now

	--[[
	    The class leads, because it is what this row was ticked for: "Mage Down!"
	    answers the question in the first two words, the way "Tank Down!" does
	    above, and the two lines read as one family rather than as an alarm and a
	    footnote.

	    It is spelled out rather than left to the name's class colour, because a
	    colour is not a label: somebody watching three classes has to read which
	    one this was, and colour-blind players need it at all.
	]]
	ns:PrintLine("TANK_DEATHS_CLASS_LINE", { ns.ClassName(class), playerPart })
end
