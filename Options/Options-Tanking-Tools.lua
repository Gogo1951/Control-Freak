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
    Four separate tools, each on a sub-panel of its own under Tanking Tools. The
    parent keeps only what they share: the feature's switch and its scope rows.
    The root panel draws one switch per tool from this same list, bound to the
    same setting as the tool's own (Options/Options-General.lua), and
    Options/Options.lua registers the sub-panels in this order.
]]
ns.TANKING_TOOLS = {
	{ key = "coldOpener", headerKey = "TANKING_TOOLS_COLD_OPENER_HEADER", registry = "TankingToolsColdOpener" },
	{ key = "armor", headerKey = "TANKING_TOOLS_ARMOR_HEADER", registry = "TankingToolsArmor" },
	{ key = "parry", headerKey = "TANKING_TOOLS_PARRY_HEADER", registry = "TankingToolsParry" },
	{ key = "nova", headerKey = "TANKING_TOOLS_NOVA_HEADER", registry = "TankingToolsNova" },
}

function ns.BuildTankingToolsOptions()
	local args = {}
	ns.AddFeatureScope(args, Feature, "TANKING_TOOLS_SUMMARY", "TANKING_TOOLS_ENABLE", 1, "tankingTools")

	return {
		type = "group",
		name = L["TAB_TANKING_TOOLS"],
		args = args,
	}
end

--[[
    One tool's sub-panel: its alert block and nothing else, drawn without the
    block's header because the page title already names it. Not hidden behind
    the Tanking Tools switch, like the Tracked Abilities sub-panels: the block's
    own switch still collapses its rows, and a status line at the top says when
    Tanking Tools, or All Alerts, has the tool silenced.
]]
local function ToolPanel(key, options)
	local args = {}
	ns.AddQuietStatus(args, 0.4, "tankingTools", "TAB_TANKING_TOOLS")
	options.noHeader = true
	ns.AddWhoseAlertSection(args, key, Section(key), 1, ns.NeverHidden, options)
	return {
		type = "group",
		name = ns.SubPanelTitle(L["TAB_TANKING_TOOLS"], L[options.headerKey]),
		args = args,
	}
end

--[[
    Cold Openers reports the player's own opener and nobody else's, so it has a
    My row and no Others'. Its window -- how long into a pull an avoided ability
    still counts -- is a parameter of the detection, not a filter, and sits as a
    caption row under the whose row, "Within [10 Seconds of the Pull]". The slot
    beside the switch belongs to the target ladder, as everywhere.
]]
-- Classes whose opener in the Example is a melee swing, which a mob blocks; every other class's is a spell, which it resists.
local MELEE_OPENER_CLASSES = { DRUID = true, ROGUE = true, WARRIOR = true }

function ns.BuildTankingToolsColdOpenerOptions()
	-- Every class has an OPENER row, so the Example always lands on the My row this section draws.
	local caster, opener = ns.SampleCaster("OPENER", "WARRIOR")
	local _, playerClass = UnitClass("player")
	return ToolPanel("coldOpener", {
		headerKey = "TANKING_TOOLS_COLD_OPENER_HEADER",
		enableKey = "TANKING_TOOLS_COLD_OPENER_ENABLE",
		descKey = "TANKING_TOOLS_COLD_OPENER_DESC",
		mineKey = "TANKING_TOOLS_COLD_OPENER_MINE",
		mineDescKey = "TANKING_TOOLS_COLD_OPENER_MINE_DESC",
		-- BLOCK or RESIST of the six outcomes: the one this class's opener meets most often on a pull.
		sample = {
			key = MELEE_OPENER_CLASSES[playerClass] and "COLD_OPENER_BLOCK" or "COLD_OPENER_RESIST",
			args = { caster, opener, ns.SampleTarget() },
		},
		captionRow = {
			labelKey = "TANKING_TOOLS_COLD_OPENER_WITHIN",
			control = {
				type = "select",
				name = "",
				desc = L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"],
				width = ns.OPTIONS_SUB_CONTROL_WIDTH,
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
		},
	})
end

--[[
    Armor Debuffs has no whose at all: the report is the group's, told to the
    player, so it draws one row for where that report goes and the handler files
    every report under it.
]]
function ns.BuildTankingToolsArmorOptions()
	return ToolPanel("armor", {
		headerKey = "TANKING_TOOLS_ARMOR_HEADER",
		enableKey = "TANKING_TOOLS_ARMOR_ENABLE",
		descKey = "TANKING_TOOLS_ARMOR_DESC",
		mineKey = "TANKING_TOOLS_ARMOR_REPORT",
		mineDescKey = "TANKING_TOOLS_ARMOR_REPORT_DESC",
		-- Under a second: everything in the first global is the result worth showing.
		sample = { key = "ARMOR_REPORT", args = { ns.SampleTarget(), "0.8" } },
		-- Fires once per target, after the fact. Nothing to react to.
		noSound = true,
		--[[
		    The two optional components, drawn UNDER the indent because that is what
		    they are: they narrow what counts as done, the way the rows above them
		    decide what counts at all. They take rowsHidden so they collapse with
		    the rest when the alert is switched off.
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
end

function ns.BuildTankingToolsParryOptions()
	--[[
	    One mob for both of Parries' examples: the warning the group sees and the
	    whisper its culprit gets describe the same swing.
	]]
	local PARRY_BOSS = ns.SampleBoss()

	return ToolPanel("parry", {
		headerKey = "TANKING_TOOLS_PARRY_HEADER",
		enableKey = "TANKING_TOOLS_PARRY_ENABLE",
		descKey = "TANKING_TOOLS_PARRY_DESC",
		mineKey = "TANKING_TOOLS_PARRY_MINE",
		mineDescKey = "TANKING_TOOLS_PARRY_MINE_DESC",
		othersKey = "TANKING_TOOLS_PARRY_OTHERS",
		othersDescKey = "TANKING_TOOLS_PARRY_OTHERS_DESC",
		sample = {
			key = "PARRY_WARNING",
			row = "others",
			args = { ns.SampleOther("ROGUE"), ns.SampleTarget(PARRY_BOSS) },
		},
		--[[
		    Under the indent because both narrow who counts: an off-tank in front
		    of the boss for a taunt swap is not a mistake to whisper about, and a
		    pet in front of it is where its owner sent it, so the line would name
		    somebody nobody can act on.
		]]
		extraRow = function(rowArgs, order, rowsHidden)
			local extras = {
				{ key = "ignoreTanks", label = "TANKING_TOOLS_PARRY_IGNORE_TANKS" },
				{ key = "ignorePets", label = "TANKING_TOOLS_PARRY_IGNORE_PETS" },
			}
			for index, extra in ipairs(extras) do
				rowArgs["parry" .. extra.key] = ns.OptionsSubRow(order + index, rowsHidden, {
					[extra.key] = {
						type = "toggle",
						name = ns.OptionsSubLabel(L[extra.label]),
						desc = L[extra.label .. "_DESC"],
						width = ns.OPTIONS_SUB_LABEL_WIDTH,
						order = 1,
						get = function()
							return Section("parry")()[extra.key]
						end,
						set = function(_, value)
							Section("parry")()[extra.key] = value
						end,
					},
				})
			end
		end,
		--[[
		    The whisper goes to the culprit rather than into the player's own window
		    or the group's chat, so it is not one of the alert's outputs: it sits
		    below the block's example with an example of its own.
		]]
		afterSample = function(rowArgs, order, rowsHidden)
			ns.AddWhisperRow(rowArgs, "parry", order, rowsHidden, {
				labelKey = "TANKING_TOOLS_PARRY_WHISPER",
				descKey = "TANKING_TOOLS_PARRY_WHISPER_DESC",
				cooldownDescKey = "TANKING_TOOLS_PARRY_COOLDOWN_DESC",
				cooldowns = ns.PARRY_COOLDOWNS,
				sample = { key = "PARRY_WHISPER", args = { PARRY_BOSS } },
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
end

--[[
    Frost Nova is a ring, not a target: nothing for a ladder or a mark to apply
    to, so this draws like AOE Taunts, and its example is the AOE line the one
    nova in the category actually produces.

    No ability list, here or on any tool: each warning IS one thing, and its own
    switch already says whether it fires. A list holding the single Frost Nova
    row would be the Nova switch printed a second time.
]]
function ns.BuildTankingToolsNovaOptions()
	return ToolPanel("nova", {
		headerKey = "TANKING_TOOLS_NOVA_HEADER",
		enableKey = "TANKING_TOOLS_NOVA_ENABLE",
		descKey = "TANKING_TOOLS_NOVA_DESC",
		mineKey = "TANKING_TOOLS_NOVA_MINE",
		othersKey = "TANKING_TOOLS_NOVA_OTHERS",
		noTarget = true,
		sample = {
			key = "NOVA_AOE",
			row = "others",
			args = { ns.SampleOther("MAGE"), ns.SpellPart(ns.SAMPLE_SPELL_IDS.FROST_NOVA) },
		},
	})
end
