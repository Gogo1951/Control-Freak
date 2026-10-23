local _, ns = ...

local L = ns.L
local GetColor = ns.GetColor

-- Each switch's caption, keyed like ns.FEATURE_KEYS.
local FEATURE_CAPTION_KEYS = {
	taunts = "FEATURES_TAUNTS",
	interrupts = "FEATURES_INTERRUPTS",
	fears = "FEATURES_FEARS",
	incapacitated = "FEATURES_INCAPACITATED",
	tankDeaths = "FEATURES_TANK_DEATHS",
	badPriests = "FEATURES_BAD_PRIESTS",
	badPets = "FEATURES_BAD_PETS",
	peerPressure = "FEATURES_PEER_PRESSURE",
	tankingTools = "FEATURES_TANKING_TOOLS",
}

-- Each switch's icon, drawn ahead of its caption.
local FEATURE_ICONS = {
	taunts = 136080,
	interrupts = 132219, -- Kick
	fears = 136183,
	incapacitated = 135860,
	tankDeaths = 132293,
	badPriests = 135940, -- Power Word: Shield
	badPets = 132270, -- Growl
	peerPressure = 136146,
	tankingTools = 134951,
}

--[[
    The All Alerts switch alone under its own Master Switch header, since it
    sits above every feature, then the Features header and the features in
    tiers with a blank line between each: the three that report
    what somebody cast, the two about the player's own seat, the two Bad tabs,
    and Peer Pressure and Tanking Tools side by side at the bottom: the one
    whose news is not about the fight going wrong, and the one that ships off,
    which the Tanking Tools section below belongs to. Everything under the top
    switch hides while it is off, since none of it fires then; the switch re-runs
    ns:ApplyProfile, which redraws this panel. The lone switches still go
    through ns.OptionsTogglePairs, so they sit in the same inset as the pairs.
]]
local FEATURE_TIERS = {
	{ "taunts", "interrupts", "fears" },
	{ "incapacitated", "tankDeaths" },
	{ "badPets", "badPriests" },
	{ "peerPressure", "tankingTools" },
}

local function AllAlertsOff()
	return not ns.db.profile.enabled
end

local function AddFeatureToggles(args, startOrder)
	ns.OptionsTogglePairs(args, "rowKillSwitch", startOrder, {
		{
			type = "toggle",
			name = L["KILL_SWITCH_ENABLE"],
			desc = L["KILL_SWITCH_ENABLE_DESC"],
			get = function()
				return ns.db.profile.enabled
			end,
			-- Decides whether the combat log is registered at all, so the write re-runs ns:ApplyProfile.
			set = function(_, value)
				ns.db.profile.enabled = value
				ns:ApplyProfile()
			end,
		},
	})

	-- The first tier's blank line doubles as the one under the Features header.
	args.spaceFeatures0 = ns.OptionsSpacer(startOrder + 2, AllAlertsOff)
	args.headerFeatures = ns.OptionsHeader(L["OPTIONS_FEATURES_HEADER"], startOrder + 3, AllAlertsOff)

	-- Four orders per tier: its blank line, then up to two rows of pairs.
	for tier, keys in ipairs(FEATURE_TIERS) do
		local base = startOrder + 4 + (tier - 1) * 4
		args["spaceFeatures" .. tier] = ns.OptionsSpacer(base, AllAlertsOff)
		local toggles = {}
		for _, key in ipairs(keys) do
			local toggle = ns.FeatureEnableToggle(function()
				return ns.db.profile[key]
			end, FEATURE_CAPTION_KEYS[key])
			toggle.name = "|T" .. FEATURE_ICONS[key] .. ":16|t " .. toggle.name
			toggles[#toggles + 1] = toggle
		end
		ns.OptionsTogglePairs(args, "rowFeatures" .. tier .. "_", base, toggles, AllAlertsOff)
	end
end

--[[
    One switch per tool, so the tools can be turned off without opening each
    sub-panel. Each binds the same setting as the switch on its own sub-panel,
    and is captioned with that sub-panel's name: the sub-panel's "Enable Alerts
    for Cold Openers On" ends on the ladder beside it, which is not drawn here.
    Shown only while Tanking Tools and All Alerts are on; both switches re-run
    ns:ApplyProfile, which redraws this panel when it changes.
]]
local function AddTankingToolToggles(args, order)
	local hidden = function()
		return AllAlertsOff() or not ns.db.profile.tankingTools.enabled
	end

	args.spaceTankingTools0 = ns.OptionsSpacer(order, hidden)
	args.headerTankingTools = ns.OptionsHeader(L["TAB_TANKING_TOOLS"], order + 1, hidden)
	args.spaceTankingTools1 = ns.OptionsSpacer(order + 2, hidden)

	local toggles = {}
	for _, tool in ipairs(ns.TANKING_TOOLS) do
		local key = tool.key
		toggles[#toggles + 1] = {
			type = "toggle",
			name = L[tool.headerKey],
			desc = L["ALERT_SECTION_ENABLE_DESC"],
			get = function()
				return ns.db.profile.tankingTools[key].enabled
			end,
			set = function(_, value)
				ns.db.profile.tankingTools[key].enabled = value
			end,
		}
	end
	ns.OptionsTogglePairs(args, "rowTankingTools", order + 2, toggles, hidden)
end

function ns.BuildGeneralOptions()
	local args = {
		descAddon = ns.OptionsDesc(L["OPTIONS_DESCRIPTION"], 1),
		spaceWelcome0 = ns.OptionsSpacer(2),
		showWelcome = {
			type = "toggle",
			name = L["ENABLE_WELCOME_MESSAGE"],
			desc = L["ENABLE_WELCOME_MESSAGE_DESC"],
			width = "full",
			order = 3,
			get = function()
				return ns.db.profile.showWelcome
			end,
			set = function(_, value)
				ns.db.profile.showWelcome = value
			end,
		},
		toggleMinimap = {
			type = "toggle",
			name = L["ENABLE_MINIMAP_BUTTON"],
			desc = L["ENABLE_MINIMAP_BUTTON_DESC"],
			width = "full",
			order = 4,
			get = function()
				return not ns.db.profile.minimap.hide
			end,
			set = function(_, value)
				ns.db.profile.minimap.hide = not value
				ns:ApplyMinimapButton()
			end,
		},

		spaceMasterSwitch0 = ns.OptionsSpacer(20),
		headerMasterSwitch = ns.OptionsHeader(L["OPTIONS_MASTER_SWITCH_HEADER"], 21),
		spaceMasterSwitch1 = ns.OptionsSpacer(22),

		spaceCommands0 = ns.OptionsSpacer(90),
		headerCommands = ns.OptionsHeader(L["OPTIONS_COMMANDS_HEADER"], 91),
		spaceCommands1 = ns.OptionsSpacer(92),
		descCommands = ns.OptionsDesc(
			GetColor("INFO") .. L["OPTIONS_COMMAND"] .. "|r" .. "  " .. L["OPTIONS_COMMAND_DESCRIPTION"],
			93
		),
	}

	-- The switch at 23, the Features header at 24 and 25, then four tiers of four orders from 26 end at 41.
	AddFeatureToggles(args, 22)
	AddTankingToolToggles(args, 42)

	return {
		type = "group",
		name = L["ADDON_TITLE"],
		args = args,
	}
end
