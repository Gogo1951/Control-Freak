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
			key = "FEAR_AOE",
			args = { ns.SAMPLE_OTHER, ns.SampleSpell(ns.SAMPLE_SPELL_IDS.PSYCHIC_SCREAM) },
		},
	})

	return {
		type = "group",
		name = L["TAB_FEARS"],
		args = args,
	}
end

-- The Tracked Abilities sub-panel under Fears; not hidden, for the reason Taunts' is not.
function ns.BuildFearsTrackedOptions()
	local args = {
		abilitiesDesc = ns.OptionsDesc(L["FEARS_ABILITIES_DESC"], 1),
		abilitiesDescSpace = ns.OptionsSpacer(2),
	}

	for key, value in
		pairs(ns.BuildAbilityToggles({
			categories = { FEAR = true },
			order = 3,
		}))
	do
		args[key] = value
	end

	return {
		type = "group",
		name = ns.SubPanelTitle(L["TAB_FEARS"], L["TRACKED_HEADER"]),
		args = args,
	}
end
