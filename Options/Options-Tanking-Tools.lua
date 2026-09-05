local _, ns = ...

local L = ns.L

local function Feature()
	return ns.db.profile.tankingTools
end

local function Section(key)
	return function()
		return ns.db.profile.tankingTools[key]
	end
end

-- Built once from ns.COLD_OPENER_WINDOWS so the ladder is declared in one place.
local coldOpenerWindows = {}
for _, seconds in ipairs(ns.COLD_OPENER_WINDOWS) do
	coldOpenerWindows[seconds] = string.format(L["TANKING_TOOLS_COLD_OPENER_WINDOW"], seconds)
end

--[[
    Six warnings sharing a tab rather than four flavors of one alert, but drawn as
    the same block as every other tab's: header, a sentence or two, the switch and
    its sub-options, anything else the warning owns, and a sample of what the group
    would see. ns.AddAlertSection owns that shape.

    Bubble Warnings and Taunt Overwrite Warnings are still being designed; orders
    are spaced 20 apart with room left for them after Parry.
]]
function ns.BuildTankingToolsOptions()
	local args = {}
	local hidden = ns.AddFeatureScope(args, Feature, nil, "TANKING_TOOLS_ENABLE", 1, "tankingTools")

	ns.AddAlertSection(args, "coldOpener", Section("coldOpener"), 20, hidden, {
		headerKey = "TANKING_TOOLS_COLD_OPENER_HEADER",
		enableKey = "TANKING_TOOLS_COLD_OPENER_ENABLE",
		descKey = "TANKING_TOOLS_COLD_OPENER_DESC",
		-- Always your own: the warning covers the player's own opener and nobody
		-- else's, so there is no whose left to choose.
		noScope = true,
		-- BLOCK of the six outcomes, because it is the one the mock-up shows.
		sample = {
			key = "COLD_OPENER_BLOCK",
			args = { ns.SAMPLE_PLAYER, ns.SampleSpell(7386, "Sunder Armor"), ns.SampleBoss() },
		},
		--[[
		    The window sits beside the switch because it is the same sentence: warn
		    me about a cold opener, for this long into the pull. It is not a
		    sub-option -- it narrows nothing, it measures.
		]]
		control = {
			type = "select",
			name = "",
			desc = L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"],
			width = ns.OPTIONS_CONTROL_WIDTH,
			values = coldOpenerWindows,
			sorting = ns.COLD_OPENER_WINDOWS,
			get = function()
				return ns.ResolveChoice(
					Section("coldOpener")().window,
					ns.COLD_OPENER_WINDOWS,
					ns.COLD_OPENER_WINDOW_DEFAULT
				)
			end,
			set = function(_, value)
				Section("coldOpener")().window = value
			end,
		},
	})

	ns.AddAlertSection(args, "armor", Section("armor"), 40, hidden, {
		headerKey = "TANKING_TOOLS_ARMOR_HEADER",
		enableKey = "TANKING_TOOLS_ARMOR_ENABLE",
		descKey = "TANKING_TOOLS_ARMOR_DESC",
		-- Under a second: everything in the first global is the result worth showing.
		sample = { key = "ARMOR_REPORT", args = { ns.SampleBoss(), "0.8" } },
		-- Fires once per target, after the fact. Nothing to react to.
		noSound = true,
		--[[
		    The two optional components, drawn UNDER the indent because that is what
		    they are: they narrow what counts as done, the same way Only Against
		    Bosses & Elites narrows what counts at all. They take rowsHidden so they
		    collapse with the rest when the alert is switched off.
		]]
		extraRow = function(rowArgs, order, rowsHidden)
			local extras = {
				{ key = "includeFaerieFire", label = "TANKING_TOOLS_ARMOR_FAERIE_FIRE" },
				{ key = "includeRecklessness", label = "TANKING_TOOLS_ARMOR_RECKLESSNESS" },
			}
			for index, extra in ipairs(extras) do
				rowArgs["armor" .. extra.key] = ns.OptionsSubRow(order + index, rowsHidden, {
					[extra.key] = {
						type = "toggle",
						name = ns.OptionsSubLabel(L[extra.label]),
						desc = L[extra.label .. "_DESC"],
						width = ns.OPTIONS_SUB_LABEL_WIDTH,
						order = 1,
						get = function()
							return Section("armor")()[extra.key]
						end,
						set = function(_, value)
							Section("armor")()[extra.key] = value
						end,
					},
				})
			end
		end,
	})

	ns.AddAlertSection(args, "parry", Section("parry"), 60, hidden, {
		headerKey = "TANKING_TOOLS_PARRY_HEADER",
		enableKey = "TANKING_TOOLS_PARRY_ENABLE",
		descKey = "TANKING_TOOLS_PARRY_DESC",
		-- Always everyone: the culprit is by definition not the player tanking it.
		noScope = true,
		sample = { key = "PARRY_WARNING", args = { ns.SAMPLE_OTHER, ns.SampleBoss() } },
		-- The whisper goes to the culprit rather than into the player's own window
		-- or the group's chat, so it sits beside the alert, not under it.
		extraRow = function(rowArgs, order)
			ns.AddWhisperRow(rowArgs, "parry", order, hidden, {
				labelKey = "TANKING_TOOLS_PARRY_WHISPER",
				descKey = "TANKING_TOOLS_PARRY_WHISPER_DESC",
				cooldownDescKey = "TANKING_TOOLS_PARRY_COOLDOWN_DESC",
				cooldowns = ns.PARRY_COOLDOWNS,
				getWhisper = function()
					return Section("parry")().whisper
				end,
				setWhisper = function(_, value)
					Section("parry")().whisper = value
				end,
				getCooldown = function()
					return ns.ResolveChoice(
						Section("parry")().whisperCooldown,
						ns.PARRY_COOLDOWNS,
						ns.PARRY_COOLDOWN_DEFAULT
					)
				end,
				setCooldown = function(_, value)
					Section("parry")().whisperCooldown = value
				end,
			})
		end,
	})

	ns.AddAlertSection(args, "nova", Section("nova"), 80, hidden, {
		headerKey = "TANKING_TOOLS_NOVA_HEADER",
		enableKey = "TANKING_TOOLS_NOVA_ENABLE",
		descKey = "TANKING_TOOLS_NOVA_DESC",
		-- Always everyone: a nova is somebody else scattering your pull.
		noScope = true,
		sample = {
			key = "NOVA",
			args = { ns.SAMPLE_OTHER, ns.SampleSpell(122, "Frost Nova"), ns.SampleBoss() },
		},
	})

	--[[
	    No ability list. Every other tab has one because its section covers a whole
	    category a player might want to thin out -- a dozen taunts, half of which
	    they do not care about. Here each warning IS one thing, and the section's own
	    enable already says whether it fires: a list holding the single Frost Nova
	    row was the Nova switch printed a second time.
	]]

	return {
		type = "group",
		name = L["TAB_TANKING_TOOLS"],
		args = args,
	}
end
