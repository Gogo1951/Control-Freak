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

	local TAUNT = ns.SampleSpell(355, "Taunt")

	-- "Hey That's Mine" is parked and draws nothing: the redesign has no place for
	-- it yet. Data/Default-Settings.lua ships the section off so it stays quiet
	-- while it has no controls, and restoring it is one call here.
	ns.AddAlertSection(args, "success", Section("success"), 20, hidden, {
		headerKey = "TAUNTS_SUCCESS_HEADER",
		enableKey = "TAUNTS_SUCCESS_ENABLE",
		descKey = "TAUNTS_SUCCESS_DESC",
		sample = { key = "TAUNT_SUCCESS", args = { ns.SAMPLE_PLAYER, TAUNT, ns.SampleBoss() } },
	})

	ns.AddAlertSection(args, "failed", Section("failed"), 40, hidden, {
		headerKey = "TAUNTS_FAILED_HEADER",
		enableKey = "TAUNTS_FAILED_ENABLE",
		descKey = "TAUNTS_FAILED_DESC",
		-- RESISTED of the four outcomes: the one a player is most likely to see.
		sample = { key = "TAUNT_RESISTED", args = { ns.SAMPLE_PLAYER, TAUNT, ns.SampleBoss() } },
	})

	ns.AddAlertSection(args, "aoe", Section("aoe"), 60, hidden, {
		headerKey = "TAUNTS_AOE_HEADER",
		enableKey = "TAUNTS_AOE_ENABLE",
		descKey = "TAUNTS_AOE_DESC",
		sample = {
			key = "TAUNT_AOE",
			args = { ns.SAMPLE_PLAYER, ns.SampleSpell(1161, "Challenging Shout") },
		},
	})

	ns.AddGatedHeader(args, "abilities", "TAUNTS_ABILITIES_HEADER", 90, hidden, true)

	for key, value in
		pairs(ns.BuildAbilityToggles({
			categories = { TAUNT = true },
			order = 93,
			hidden = hidden,
			aoe = "SINGLE",
			keyPrefix = "single",
		}))
	do
		args[key] = value
	end

	-- Split from the single-target list because the alert sections above are split
	-- the same way: an AOE taunt has its own Successful section, so its abilities
	-- get their own list rather than being mixed in.
	ns.AddGatedHeader(args, "aoeAbilities", "TAUNTS_AOE_ABILITIES_HEADER", 110, hidden, true)

	for key, value in
		pairs(ns.BuildAbilityToggles({
			categories = { TAUNT = true },
			order = 113,
			hidden = hidden,
			aoe = "AOE",
			keyPrefix = "aoe",
		}))
	do
		args[key] = value
	end

	return {
		type = "group",
		name = L["TAB_TAUNTS"],
		args = args,
	}
end
