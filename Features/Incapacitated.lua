local _, ns = ...

local L = ns.L

--[[
    Incapacitated.

    A tank who has been stunned, feared or silenced is not tanking, and they are
    the one person in the group who cannot say so: their hands are full and the
    mob is already walking. This puts the reason in front of the group at the
    moment it starts -- what landed, who cast it, how long it lasts, and whether
    anybody can take it off -- so somebody acts instead of watching.

    Ported from the reference aura (Loss of Control Announcer,
    wago.io/qhD2-4WN6), which is where the effect list and the pick-the-longest
    rule come from. The line says more than the aura's does, and the extra half
    is the point of it: the dispel type turns "I am feared" into an instruction
    addressed to a particular four people in the raid.

    Three sources, because no one of them holds the whole line:

      C_LossOfControl is the client's own answer to "why is this button greyed
      out". It says an effect is a loss of control, which of the nine kinds it
      is, and how long it runs -- already classified, already timed. Reading
      that out of the combat log would mean shipping a list of every
      crowd-control spell in the game and keeping it current, and it still could
      not tell a partly-resisted fear from a full-length one. It names no caster
      and no mob, which is why this section has no target ladder and no raid
      mark, and hands ns:Alert nil for both the way Bad Shields does.

      The player's own debuff, found by spell id, carries the dispel type.
      Nothing else does: the combat log has no dispel field at all.

      The combat log carries the mob's NAME, reliably and with no unit to
      resolve, which is why it is stamped on the way past rather than read from
      the debuff's sourceUnit. That token only resolves while the mob happens to
      be somebody's target or on a name plate, and the name is wanted every
      time.
]]

--[[
    The combat log's word for "the player themselves". This alert's trigger is an
    event of its own, so there are no flags to pass along, and ns:Alert still
    reads some: ns.IsGroupSource checks the cast came from inside the player's
    group. The row is not picked from them -- the handler names it outright
    (rowKey) -- and the answer is fixed for a loss of control, which is always
    the player's own, so the value is built once here rather than assembled per
    event.
]]
local MINE_FLAGS = COMBATLOG_OBJECT_AFFILIATION_MINE
	+ COMBATLOG_OBJECT_REACTION_FRIENDLY
	+ COMBATLOG_OBJECT_CONTROL_PLAYER
	+ COMBATLOG_OBJECT_TYPE_PLAYER

--[[
    Answered once, at file scope, the way Features/Utilities.lua settles
    UnitGroupRolesAssigned. The add-on ships for two flavors, and an older client
    answers the same question through a different pair of calls
    (C_LossOfControl.GetNumEvents and GetEventInfo). Rather than carry both
    shapes for an alert neither flavor has
    shipped without, the section goes quiet on a client that does not have the
    modern pair -- and the Diagnostics panel carries a row saying so, so a player
    reporting silence gets an answer rather than a guess.

    The aura call is settled separately and is NOT required. Without it the line
    simply cannot name a dispel type, and there is a message format for exactly
    that case, so a client missing it loses the instruction and keeps the news.
]]
local HAS_LOSS_OF_CONTROL = type(C_LossOfControl) == "table"
	and type(C_LossOfControl.GetActiveLossOfControlDataCount) == "function"
	and type(C_LossOfControl.GetActiveLossOfControlData) == "function"

local HAS_UNIT_AURAS = type(C_UnitAuras) == "table" and type(C_UnitAuras.GetDebuffDataByIndex) == "function"

--[[
    Far past the sixteen a player frame shows, because the cap is on what is
    DRAWN rather than on what is carried, and the loop stops at the first empty
    slot anyway. It exists only so a client returning something unexpected cannot
    spin here forever.
]]
local MAX_DEBUFF_SCAN = 64

--[[
    GetTime() of the last line this section sent. ns.INCAPACITATED_COOLDOWN in
    Data/Data.lua says why it is a constant rather than a setting.
]]
local lastAlert = 0

-- The spellID and startTime of the effect that last line was sent for.
local lastAnnounced = {}

--[[
    The mob behind the last debuff to land on the player. One slot rather than a
    table keyed by spell, exactly as Features/Interrupts.lua keeps the id Era
    omits: the two events describe the same instant, so nothing older than a
    moment is ever wanted, and a single record cannot grow. The spell id and the
    window together stop it answering for a different debuff.
]]
local lastAura = {}

ns.stateResets[#ns.stateResets + 1] = function()
	lastAlert = 0
	wipe(lastAnnounced)
	wipe(lastAura)
end

--[[
    Stamped by Features/Combat-Log.lua for every debuff landing on the player
    while this section is switched on, and read back a moment later when
    LOSS_OF_CONTROL_ADDED fires. Buffs never reach here -- a debuff is the only
    kind of aura that takes control away, and letting a heal over time overwrite
    the slot would cost the fear that landed beside it its caster.
]]
function ns.RememberIncapacitatingAura(spellId, sourceName)
	if not spellId or not sourceName then
		return
	end
	lastAura.spellId, lastAura.sourceName, lastAura.at = spellId, sourceName, GetTime()
end

local function RecallAuraSource(spellId)
	if not spellId or lastAura.spellId ~= spellId then
		return nil
	end
	if GetTime() - lastAura.at > ns.INCAPACITATED_AURA_WINDOW then
		return nil
	end
	return lastAura.sourceName
end

--[[
    The player's own debuff for this loss of control, which is where the dispel
    type lives. Matched on the spell id C_LossOfControl already handed over, so
    no name comparison and nothing to translate.

    NOTE the casing, which is a real trap: a LossOfControlData carries spellID
    and an AuraData carries spellId, and reading the wrong one silently compares
    nil to a number and never matches.
]]
local function FindPlayerDebuff(spellId)
	if not HAS_UNIT_AURAS or not spellId then
		return nil
	end
	for index = 1, MAX_DEBUFF_SCAN do
		local aura = C_UnitAuras.GetDebuffDataByIndex("player", index)
		if not aura then
			return nil
		end
		if aura.spellId == spellId then
			return aura
		end
	end
	return nil
end

--[[
    Whether this effect is one the player asked about. ns.INCAPACITATED_EFFECTS
    maps the API's locType onto the boxes the panel draws, and a locType
    answering to two of them passes when EITHER is ticked -- the reasoning is
    written beside the table.

    An unmapped locType is not wanted. A Blizzard effect type the panel offers no
    box for should stay quiet rather than announce itself under a name nobody
    chose.
]]
local function IsWanted(settings, locType)
	local keys = locType and ns.INCAPACITATED_EFFECTS[locType]
	if not keys then
		return false
	end
	local effects = settings.effects
	if not effects then
		return false
	end
	for _, key in ipairs(keys) do
		if effects[key] then
			return true
		end
	end
	return false
end

--[[
    The worst of whatever is on the player right now, which is the reference
    aura's rule and the right one: stunned for two seconds and feared for six is
    a tank who is gone for six, and six is the number the group has to plan
    around. Announcing the stun instead would tell them to expect a taunt that is
    not coming.

    An effect with no time remaining is indefinite -- a Mind Control runs until
    somebody breaks it -- so it outranks every timed one and answers immediately.

    The active list is re-read rather than taken from the event's payload, which
    is what makes one code path cover both a fresh application and a second
    landing on top of the first; the handler stays quiet when the worst is one it
    has already announced. The count is the number of things on the player, so
    the loop is single digits.
]]
local function WorstActive(settings)
	local count = C_LossOfControl.GetActiveLossOfControlDataCount()
	local worst, worstRemaining

	for index = 1, count do
		local data = C_LossOfControl.GetActiveLossOfControlData(index)
		if data and IsWanted(settings, data.locType) then
			local remaining = data.timeRemaining
			if not remaining then
				return data
			end
			if not worstRemaining or remaining > worstRemaining then
				worst, worstRemaining = data, remaining
			end
		end
	end

	return worst
end

--[[
    LOSS_OF_CONTROL_ADDED carries an event index on some flavors and nothing on
    others, so the payload is ignored and the active list is read instead. That
    is what the reference aura does, and it is also what collapses the two cases
    -- one effect landing, and a second landing on top of it -- into one path.
]]
function ns:LOSS_OF_CONTROL_ADDED()
	if not HAS_LOSS_OF_CONTROL then
		return
	end

	local profile = ns.db and ns.db.profile
	if not profile or not profile.enabled then
		return
	end

	local feature = profile.incapacitated
	local settings = feature and feature.alert
	if not settings or not settings.enabled then
		return
	end

	--[[
	    The tab's own scope gates, asked here rather than by the registration test
	    in Features/Alert-Gates.lua: that one decides whether the COMBAT LOG is
	    hooked, and this alert's trigger is not on that path, so nothing else has
	    asked them. They cost nothing here -- the event only fires when the player
	    is actually crowd controlled.
	]]
	if not ns:IsFeatureGateOpen(feature) then
		return
	end

	local data = WorstActive(settings)
	if not data then
		return
	end
	if data.startTime and data.spellID == lastAnnounced.spellID and data.startTime == lastAnnounced.startTime then
		return
	end

	--[[
	    duration rather than timeRemaining: the line says how long this lasts, and
	    the event arrives at the start of it, so the two are the same number with
	    one of them rounder. An effect reporting no duration runs until somebody
	    breaks it, and that counts as LONG -- there is no longer thing it could be.
	]]
	local duration = data.duration
	local timed = duration ~= nil and duration > 0

	--[[
	    Which of the two rows this line answers to. Not a filter: both rows exist
	    and both have somewhere to send a line, so nothing is thrown away here.
	    ns.INCAPACITATED_LONG_THRESHOLDS says why the ladder starts at one.
	]]
	local threshold =
		ns.ResolveChoice(settings.longThreshold, ns.INCAPACITATED_LONG_THRESHOLDS, ns.INCAPACITATED_LONG_DEFAULT)
	local rowKey = (not timed or duration >= threshold) and "long" or "short"

	--[[
	    The row's own switch, read here rather than left to ns:Alert. It IS read
	    there too, but this section has a cooldown to protect: an effect whose row
	    is switched off must not use up the window that would then swallow the next
	    one that had somewhere to go. The same ordering every whisper cooldown in
	    the add-on uses.
	]]
	local row = settings[rowKey]
	if not row or not row.enabled then
		return
	end

	local now = GetTime()
	if now - lastAlert < ns.INCAPACITATED_COOLDOWN then
		return
	end
	lastAlert = now
	lastAnnounced.spellID, lastAnnounced.startTime = data.spellID, data.startTime

	local spellId = data.spellID
	local aura = FindPlayerDebuff(spellId)
	--[[
	    The combat log first, because its name needs no unit to resolve. The
	    debuff's own caster is a fallback rather than the answer: it is a unit
	    token, so it is only there while the mob happens to be somebody's target
	    or on a name plate.
	]]
	local sourcePart = RecallAuraSource(spellId)
		or (aura and aura.sourceUnit and GetUnitName(aura.sourceUnit, true))
		or L["UNKNOWN_CASTER"]

	--[[
	    A debuff nobody can remove drops the clause entirely rather than printing
	    an empty pair of brackets, so the dispel type decides the format instead of
	    filling a slot in it. The timed and indefinite pair doubles that, which is
	    why there are four: an effect running until somebody breaks it has no
	    seconds to name.

	    The parts are assembled in the order all four formats read them, with the
	    optional dispel type added where it belongs rather than shuffled in
	    afterwards.
	]]
	local dispelKey = aura and ns.DISPEL_TYPES[aura.dispelName or ""]

	--[[
	    Which seat the line opens on, read from the player rather than from the
	    setting: Tank, then Healer, then the player's own class name for somebody
	    in neither seat, which the ALWAYS rung lets through. Tank wins for a
	    character holding both signals, because Main Tank is an assignment
	    somebody made on purpose and outranks a role tag left set from a dungeon.
	]]
	local seat
	if ns.IsPlayerTank() then
		seat = L["INCAPACITATED_ROLE_TANK"]
	elseif ns.IsPlayerHealer() then
		seat = L["INCAPACITATED_ROLE_HEALER"]
	else
		seat = ns.ClassName(select(2, UnitClass("player")))
	end

	local parts = { seat }
	if timed then
		--[[
		    Rounded UP to a whole second. A fear reported as 5.9 promises a taunt
		    back sooner than it is coming, and the decimal was noise besides -- "6
		    seconds" is what somebody covering for you needs, "6.0" is a reading off
		    an instrument.
		]]
		local seconds = math.ceil(duration)
		parts[#parts + 1] =
			string.format(seconds == 1 and L["INCAPACITATED_SECOND"] or L["INCAPACITATED_SECONDS"], seconds)
	end
	parts[#parts + 1] = ns.PlayerPart(GetUnitName("player", true), ns.playerGUID)
	parts[#parts + 1] = ns.SpellPart(spellId, aura and aura.name)
	if dispelKey then
		parts[#parts + 1] = L["DISPEL_" .. dispelKey]
	end
	parts[#parts + 1] = sourcePart

	local formatKey = "INCAPACITATED"
	if not dispelKey then
		formatKey = formatKey .. "_PLAIN"
	end
	if not timed then
		formatKey = formatKey .. "_INDEFINITE"
	end

	ns:Alert(settings, formatKey, parts, MINE_FLAGS, nil, nil, rowKey)
end
