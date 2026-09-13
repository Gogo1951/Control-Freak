local _, ns = ...

local L = ns.L

local function Feature()
	return ns.db.profile.fears
end

local function Section()
	return ns.db.profile.fears.alert
end

function ns.BuildFearsOptions()
	local args = {}
	local hidden = ns.AddFeatureScope(args, Feature, "FEARS_SUMMARY", "FEARS_ENABLE", 1, "fears")

	--[[
	    The whose shape as AOE Taunts draws it: no target filter, because a fear is
	    somebody scattering the pull and which mob it landed on is not the point.
	    The My row ships announcing on purpose; Data/Default-Settings.lua says why.
	]]
	ns.AddWhoseAlertSection(args, "alert", Section, 20, hidden, {
		headerKey = "FEARS_ALERT_HEADER",
		enableKey = "FEARS_ALERT_ENABLE",
		descKey = "FEARS_ALERT_DESC",
		mineKey = "FEARS_ALERT_MINE",
		othersKey = "FEARS_ALERT_OTHERS",
		noTarget = true,
		sample = {
			key = "FEAR_SUCCESS",
			args = { ns.SAMPLE_OTHER, ns.SampleSpell(8122, "Psychic Scream"), ns.SampleBoss() },
		},
	})

	ns.AddGatedHeader(args, "abilities", "FEARS_ABILITIES_HEADER", 40, hidden, true)

	for key, value in
		pairs(ns.BuildAbilityToggles({
			categories = { FEAR = true },
			order = 45,
			hidden = hidden,
		}))
	do
		args[key] = value
	end

	return {
		type = "group",
		name = L["TAB_FEARS"],
		args = args,
	}
end
