local _, ns = ...

local L = ns.L

local function Feature()
	return ns.db.profile.badMages
end

local function Section()
	return ns.db.profile.badMages.alert
end

--[[
    Novas, on a Bad tab of its own so the General panel's Naughty List names
    the class it is about.

    Frost Nova is a ring, not a target: nothing for a ladder or a mark to apply
    to, so this draws like AOE Taunts, and its example is the AOE line the one
    nova in the category actually produces.

    No Tracked Abilities sub-panel, unlike Bad Pets: a list holding the single
    Frost Nova row would be the section's switch printed a second time.
]]
function ns.BuildBadMagesOptions()
	local args = {}
	local hidden = ns.AddFeatureScope(args, Feature, "BAD_MAGES_SUMMARY", "BAD_MAGES_ENABLE", 1, "badMages")

	-- One nova for both examples: the line the group sees and the whisper the mage gets.
	local NOVA = ns.SpellPart(ns.SAMPLE_SPELL_IDS.FROST_NOVA)

	ns.AddWhoseAlertSection(args, "alert", Section, 20, hidden, {
		headerKey = "BAD_MAGES_ALERT_HEADER",
		enableKey = "BAD_MAGES_ALERT_ENABLE",
		descKey = "BAD_MAGES_ALERT_DESC",
		mineKey = "BAD_MAGES_ALERT_MINE",
		othersKey = "BAD_MAGES_ALERT_OTHERS",
		noTarget = true,
		sample = {
			key = "NOVA_AOE",
			row = "others",
			args = { ns.SampleOther("MAGE"), NOVA },
		},
		-- The whisper goes to the mage, so like Bad Pets' it sits below the block's example with one of its own.
		afterSample = function(rowArgs, order, rowsHidden)
			ns.AddWhisperRow(rowArgs, "badMages", order, rowsHidden, {
				labelKey = "BAD_MAGES_WHISPER_ENABLE",
				descKey = "BAD_MAGES_WHISPER_ENABLE_DESC",
				cooldownDescKey = "BAD_MAGES_COOLDOWN_DESC",
				cooldowns = ns.BAD_PET_COOLDOWNS,
				sample = { key = "NOVA_WHISPER", args = { NOVA } },
				getWhisper = function()
					return Feature().whisper
				end,
				setWhisper = function(_, value)
					Feature().whisper = value
				end,
				getCooldown = function()
					return ns.ResolveChoice(Feature().cooldown, ns.BAD_PET_COOLDOWNS, ns.NOVA_COOLDOWN_DEFAULT)
				end,
				setCooldown = function(_, value)
					Feature().cooldown = value
				end,
			})
		end,
	})

	return {
		type = "group",
		name = L["TAB_BAD_MAGES"],
		args = args,
	}
end
