local _, ns = ...

local L = ns.L

local function Feature()
	return ns.db.profile.taunts
end

local function Section(key)
	return function()
		return ns.db.profile.taunts[key]
	end
end

function ns.BuildTauntsOptions()
	local args = {}
	local hidden = ns.AddFeatureScope(args, Feature, "TAUNTS_SUMMARY", "TAUNTS_ENABLE", 1, "taunts")

	local TAUNT = ns.SampleSpell(ns.SAMPLE_SPELL_IDS.TAUNT)

	--[[
	    A row for the player's own casts, one for everybody else's, and the
	    Against ladder beside the switch.

	    Three sections, spaced 20 of order apart. The ability list is its own
	    sub-panel, below.
	]]
	ns.AddWhoseAlertSection(args, "success", Section("success"), 20, hidden, {
		headerKey = "TAUNTS_SUCCESS_HEADER",
		enableKey = "TAUNTS_SUCCESS_ENABLE",
		descKey = "TAUNTS_SUCCESS_DESC",
		mineKey = "TAUNTS_SUCCESS_MINE",
		othersKey = "TAUNTS_SUCCESS_OTHERS",
		sample = { key = "TAUNT_SUCCESS", args = { ns.SAMPLE_PLAYER, TAUNT, ns.SampleBoss() } },
	})

	ns.AddWhoseAlertSection(args, "failed", Section("failed"), 40, hidden, {
		headerKey = "TAUNTS_FAILED_HEADER",
		enableKey = "TAUNTS_FAILED_ENABLE",
		descKey = "TAUNTS_FAILED_DESC",
		mineKey = "TAUNTS_FAILED_MINE",
		othersKey = "TAUNTS_FAILED_OTHERS",
		-- RESISTED of the four outcomes: the one a player is most likely to see.
		sample = { key = "TAUNT_RESISTED", args = { ns.SAMPLE_PLAYER, TAUNT, ns.SampleBoss() } },
	})

	--[[
	    No mob in this line, so nothing for Against or a raid mark to apply to:
	    neither target row is drawn.
	]]
	ns.AddWhoseAlertSection(args, "aoe", Section("aoe"), 60, hidden, {
		headerKey = "TAUNTS_AOE_HEADER",
		enableKey = "TAUNTS_AOE_ENABLE",
		descKey = "TAUNTS_AOE_DESC",
		mineKey = "TAUNTS_AOE_MINE",
		othersKey = "TAUNTS_AOE_OTHERS",
		noTarget = true,
		sample = {
			key = "TAUNT_AOE",
			args = { ns.SAMPLE_PLAYER, ns.SampleSpell(ns.SAMPLE_SPELL_IDS.CHALLENGING_SHOUT) },
		},
	})

	return {
		type = "group",
		name = L["TAB_TAUNTS"],
		args = args,
	}
end

--[[
    The Tracked Abilities sub-panel under Taunts: one list, every taunt with a
    Single Target / AOE dropdown beside it. The pick routes the taunt to the
    Successful and Failed sections or to the AOE one, which is the adjustment the
    data cannot make for everybody: whether a taunt that grabs a few mobs is worth
    naming them is the player's call.

    Not hidden behind the Taunts switch: which taunts count is worth settling
    before turning the feature on, and the parent panel says whether it is.
]]
function ns.BuildTauntsTrackedOptions()
	local args = {
		abilitiesDesc = ns.OptionsDesc(L["TAUNTS_ABILITIES_DESC"], 1),
		abilitiesDescSpace = ns.OptionsSpacer(2),
	}

	for key, value in
		pairs(ns.BuildAbilityToggles({
			categories = { TAUNT = true },
			order = 3,
			kindPicker = true,
		}))
	do
		args[key] = value
	end

	return {
		type = "group",
		name = ns.SubPanelTitle(L["TAB_TAUNTS"], L["TRACKED_HEADER"]),
		args = args,
	}
end
