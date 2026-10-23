local _, ns = ...

local L = ns.L

local function Feature()
	return ns.db.profile.peerPressure
end

local function Section()
	return ns.db.profile.peerPressure.alert
end

--[[
    The Example's classmate and cooldown: a player of the character's own class
    pressing one of that class's tracked cooldowns, since only that class ever
    reports, so any other class would show a line this tab can never send.
    The first ticked cooldown by name, or the first at all when every one is
    unticked. A class with no cooldown rows falls back to the first row of any
    class, so the Example is never blank.
]]
local function SampleCooldown()
	local _, playerClass = UnitClass("player")
	local own, any = {}, {}
	for _, group in ipairs(ns.ABILITY_GROUPS) do
		if group.category == "COOLDOWN" then
			any[#any + 1] = group
			if group.class == playerClass then
				own[#own + 1] = group
			end
		end
	end

	table.sort(own, function(a, b)
		return a.name < b.name
	end)
	for _, group in ipairs(own) do
		if not ns.IsAbilityIgnored(group.entry) then
			return group
		end
	end
	if own[1] then
		return own[1]
	end

	table.sort(any, function(a, b)
		if a.class ~= b.class then
			return a.class < b.class
		end
		return a.name < b.name
	end)
	return any[1]
end

function ns.BuildPeerPressureOptions()
	local args = {}
	local hidden = ns.AddFeatureScope(args, Feature, "PEER_PRESSURE_SUMMARY", "PEER_PRESSURE_ENABLE", 1, "peerPressure")

	--[[
	    The whose shape as Fears draws it: no target filter, because the line
	    names a classmate and a cooldown rather than a mob. Both rows say what
	    they count in their own tooltips, since neither is "everybody's casts":
	    only your own class ever reports, and the My row has no pet to include.
	    The My row ships off; Data/Default-Settings.lua says why.
	]]
	local cooldown = SampleCooldown()
	ns.AddWhoseAlertSection(args, "alert", Section, 20, hidden, {
		headerKey = "PEER_PRESSURE_ALERT_HEADER",
		enableKey = "PEER_PRESSURE_ALERT_ENABLE",
		descKey = "PEER_PRESSURE_ALERT_DESC",
		mineKey = "PEER_PRESSURE_ALERT_MINE",
		mineDescKey = "PEER_PRESSURE_ALERT_MINE_DESC",
		othersKey = "PEER_PRESSURE_ALERT_OTHERS",
		othersDescKey = "PEER_PRESSURE_ALERT_OTHERS_DESC",
		noTarget = true,
		sample = {
			key = "PEER_PRESSURE",
			row = "others",
			args = { ns.SampleOther(cooldown.class), ns.SpellPart(cooldown.maxRankId) },
		},
	})

	return {
		type = "group",
		name = L["TAB_PEER_PRESSURE"],
		args = args,
	}
end

--[[
    The Tracked Abilities sub-panel under Peer Pressure; not hidden, for the
    reason Taunts' is not. Every class is listed, not just the player's, because
    the default profile is shared across the account.
]]
function ns.BuildPeerPressureTrackedOptions()
	local args = {
		abilitiesDesc = ns.OptionsDesc(L["PEER_PRESSURE_ABILITIES_DESC"], 1),
		abilitiesDescSpace = ns.OptionsSpacer(2),
	}
	ns.AddQuietStatus(args, 0.4, "peerPressure", "TAB_PEER_PRESSURE")

	for key, value in
		pairs(ns.BuildAbilityToggles({
			categories = { COOLDOWN = true },
			order = 3,
		}))
	do
		args[key] = value
	end

	return {
		type = "group",
		name = ns.SubPanelTitle(L["TAB_PEER_PRESSURE"], L["TRACKED_HEADER"]),
		args = args,
	}
end
