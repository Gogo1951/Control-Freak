local _, ns = ...

local L = ns.L

local function Feature()
	return ns.db.profile.badPriests
end

local function Section()
	return ns.db.profile.badPriests.alert
end

--[[
    Zero is the "Always" end of the health ladder rather than a percentage, so it
    takes a string of its own instead of the format.
]]
local healthValues = {}
for _, percent in ipairs(ns.SHIELD_HEALTH_THRESHOLDS) do
	if percent == 0 then
		healthValues[percent] = L["BAD_PRIESTS_HEALTH_ALWAYS"]
	else
		healthValues[percent] = string.format(L["BAD_PRIESTS_HEALTH_EXCEPT"], percent)
	end
end

--[[
    Bad Shields is the whole tab today, and it bends the block in the one way no
    other section does: it reads a FRIENDLY target rather than an enemy, so it
    carries no target filter and passes noTarget. That frees the slot beside the
    switch, which every other section in the add-on gives to the Against ladder,
    and the health choice takes it. The switch reads "Enable Alerts for
    Bad Shields" and the dropdown beside it finishes the sentence with when to
    make an exception.

    One row rather than a whose pair, the way Armor Debuffs draws it: the cast is
    the healer's and the problem is the tank's, so "My" would be wrong.
]]
function ns.BuildBadPriestsOptions()
	local args = {}
	local hidden = ns.AddFeatureScope(args, Feature, "BAD_PRIESTS_SUMMARY", "BAD_PRIESTS_ENABLE", 1, "badPriests")

	ns.AddWhoseAlertSection(args, "alert", Section, 20, hidden, {
		headerKey = "BAD_PRIESTS_HEADER",
		enableKey = "BAD_PRIESTS_ALERT_ENABLE",
		descKey = "BAD_PRIESTS_DESC",
		mineKey = "BAD_PRIESTS_REPORT",
		mineDescKey = "BAD_PRIESTS_REPORT_DESC",
		noTarget = true,
		sample = {
			key = "SHIELD_WARNING",
			args = { ns.SAMPLE_OTHER, ns.SampleSpell(17, "Power Word: Shield"), ns.SAMPLE_PLAYER },
		},
		control = {
			type = "select",
			name = "",
			desc = L["BAD_PRIESTS_HEALTH_DESC"],
			width = ns.OPTIONS_CONTROL_WIDTH,
			values = healthValues,
			sorting = ns.SHIELD_HEALTH_THRESHOLDS,
			get = function()
				return ns.ResolveChoice(
					Section().health,
					ns.SHIELD_HEALTH_THRESHOLDS,
					ns.SHIELD_HEALTH_THRESHOLD_DEFAULT
				)
			end,
			set = function(_, value)
				Section().health = value
			end,
		},
		--[[
		    Under the indent because it narrows who counts, the way Ignore Tanks
		    does on Parries.
		]]
		extraRow = function(rowArgs, order, rowsHidden)
			rowArgs.selfOnlyRow = ns.OptionsSubRow(order + 1, rowsHidden, {
				selfOnly = {
					type = "toggle",
					name = ns.OptionsSubLabel(L["BAD_PRIESTS_SELF_ONLY"]),
					desc = L["BAD_PRIESTS_SELF_ONLY_DESC"],
					width = ns.OPTIONS_SUB_LABEL_WIDTH,
					order = 1,
					get = function()
						return Section().selfOnly
					end,
					set = function(_, value)
						Section().selfOnly = value
					end,
				},
			})
		end,
		--[[
		    The whisper goes to the healer rather than into the player's own window
		    or the group's chat, so it sits below the block's example with an
		    example of its own.
		]]
		afterSample = function(rowArgs, order, rowsHidden)
			ns.AddWhisperRow(rowArgs, "alert", order, rowsHidden, {
				labelKey = "BAD_PRIESTS_WHISPER",
				descKey = "BAD_PRIESTS_WHISPER_DESC",
				cooldownDescKey = "BAD_PRIESTS_COOLDOWN_DESC",
				cooldowns = ns.BAD_PET_COOLDOWNS,
				sample = {
					key = "SHIELD_WHISPER",
					args = { ns.SampleSpell(17, "Power Word: Shield"), ns.SAMPLE_PLAYER },
				},
				getWhisper = function()
					return Section().whisper
				end,
				setWhisper = function(_, value)
					Section().whisper = value
				end,
				getCooldown = function()
					return ns.ResolveChoice(Section().cooldown, ns.BAD_PET_COOLDOWNS, ns.SHIELD_COOLDOWN_DEFAULT)
				end,
				setCooldown = function(_, value)
					Section().cooldown = value
				end,
			})
		end,
	})

	return {
		type = "group",
		name = L["TAB_BAD_PRIESTS"],
		args = args,
	}
end
