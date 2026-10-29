local _, ns = ...

local L = ns.L
local GetColor = ns.GetColor

--[[
    Each switch's caption, keyed like ns.FEATURE_KEYS: the tab's own name, so
    the switch reads exactly as the settings tree beside it does.
]]
local FEATURE_CAPTION_KEYS = {
	taunts = "TAB_TAUNTS",
	interrupts = "TAB_INTERRUPTS",
	fears = "TAB_FEARS",
	incapacitated = "TAB_INCAPACITATED",
	tankDeaths = "TAB_TANK_DEATHS",
	badMages = "TAB_BAD_MAGES",
	badParryMonkeys = "TAB_BAD_PARRY_MONKEYS",
	badPets = "TAB_BAD_PETS",
	badPriests = "TAB_BAD_PRIESTS",
	peerPressure = "TAB_PEER_PRESSURE",
	tankingTools = "TAB_TANKING_TOOLS",
}

-- Each feature switch's icon, drawn ahead of its caption. Block switches are gold instead and carry none.
local FEATURE_ICONS = {
	taunts = 136080,
	interrupts = 132219, -- Kick
	fears = 136183,
	incapacitated = 135860,
	tankDeaths = 132293,
	badMages = "Interface\\Icons\\Spell_Frost_FrostNova",
	badParryMonkeys = "Interface\\Icons\\Ability_Parry",
	badPets = 132270, -- Growl
	badPriests = 135940, -- Power Word: Shield
	peerPressure = 136146,
}

-- Each Tanking Tools switch's icon, keyed like ns.TANKING_TOOLS.
local TOOL_ICONS = {
	coldOpener = "Interface\\Icons\\Ability_Warrior_Charge",
	armor = "Interface\\Icons\\Ability_Warrior_Sunder",
}

local function WithIcon(icon, text)
	return "|T" .. icon .. ":16|t " .. text
end

local function AllAlertsOff()
	return not ns.db.profile.enabled
end

--[[
    A block's own switch: gold, full width, standing where a label would. It
    reads as the heading of the switches indented under it, and is one.
]]
local function BlockSwitch(toggle)
	toggle.name = GetColor("TITLE") .. toggle.name .. "|r"
	toggle.width = "full"
	return toggle
end

local function GroupSwitch(group)
	return BlockSwitch({
		type = "toggle",
		name = L[group.labelKey],
		desc = string.format(L["OPTIONS_GROUP_ENABLE_DESC"], L[group.labelKey]),
		get = function()
			return ns.IsFeatureGroupOn(group.features[1])
		end,
		-- Decides whether the combat log is registered at all, so the write re-runs ns:ApplyProfile.
		set = function(_, value)
			ns.db.profile.featureGroups[group.key] = value
			ns:ApplyProfile()
		end,
	})
end

local function FeatureSwitch(key)
	local toggle = ns.FeatureEnableToggle(function()
		return ns.db.profile[key]
	end, FEATURE_CAPTION_KEYS[key])
	toggle.name = WithIcon(FEATURE_ICONS[key], toggle.name)
	return toggle
end

--[[
    One switch per tool, captioned with its sub-panel's name: the sub-panel's
    "Enable Alerts for Cold Openers On" ends on the ladder beside it, which is
    not drawn here. Each binds the same setting as the switch on its sub-panel,
    and writes without ns:ApplyProfile, since the registration test reads only
    the feature's switch.
]]
local function ToolSwitch(tool)
	local key = tool.key
	return {
		type = "toggle",
		name = WithIcon(TOOL_ICONS[key], L[tool.headerKey]),
		desc = L["ALERT_SECTION_ENABLE_DESC"],
		get = function()
			return ns.db.profile.tankingTools[key].enabled
		end,
		set = function(_, value)
			ns.db.profile.tankingTools[key].enabled = value
		end,
	}
end

--[[
    The Features block, top to bottom:

        [x] Monitoring                    the group switch, gold
              [x] Taunts       [x] Interrupts
              ...
              [x] Tank Deaths  [x] Peer Pressure
        [x] Naughty List
              [x] Bad Mages    [x] Bad Parry Monkeys
              [x] Bad Pets     [x] Bad Priests
        [ ] Tanking Tools                 the feature's own switch, gold
              [ ] Cold Openers [x] Armor Debuffs

    A block switch silences everything indented under it without touching
    their own switches, so the rows under one that is off stay drawn, greyed
    out, still showing what will come back. Tanking Tools' block switch is the
    feature's own enable, the same setting as its tab; its tools are the
    sections under it.
]]
local function GroupBlock(group)
	local children = {}
	for _, key in ipairs(group.features) do
		children[#children + 1] = FeatureSwitch(key)
	end
	return {
		switch = GroupSwitch(group),
		children = children,
		off = function()
			return not ns.IsFeatureGroupOn(group.features[1])
		end,
	}
end

local function TankingToolsBlock()
	local tools = {}
	for _, tool in ipairs(ns.TANKING_TOOLS) do
		tools[#tools + 1] = ToolSwitch(tool)
	end
	local tankingTools = ns.FeatureEnableToggle(function()
		return ns.db.profile.tankingTools
	end, FEATURE_CAPTION_KEYS.tankingTools)
	return {
		switch = BlockSwitch(tankingTools),
		children = tools,
		off = function()
			return not ns.db.profile.tankingTools.enabled
		end,
	}
end

--[[
    One block at base: its switch at base + 1, then up to three rows of pairs
    from base + 2, so a block needs seven orders after base. hidden goes on the
    switch and every row, so the block collapses whole.
]]
local function AddBlock(args, prefix, base, block, hidden)
	block.switch.order = base + 1
	block.switch.hidden = hidden
	args[prefix .. "Switch"] = block.switch
	for _, child in ipairs(block.children) do
		child.disabled = block.off
	end
	ns.OptionsTogglePairs(args, prefix .. "Row", base + 1, block.children, hidden, true)
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

	-- The first group's blank line doubles as the one under the Features header.
	args.spaceFeatures0 = ns.OptionsSpacer(startOrder + 2, AllAlertsOff)
	args.headerFeatures = ns.OptionsHeader(L["OPTIONS_FEATURES_HEADER"], startOrder + 3, AllAlertsOff)

	local blocks = {}
	for _, group in ipairs(ns.FEATURE_GROUPS) do
		blocks[#blocks + 1] = GroupBlock(group)
	end
	blocks[#blocks + 1] = TankingToolsBlock()

	-- Eight orders per block: its blank line, then the block itself.
	for index, block in ipairs(blocks) do
		local base = startOrder + 4 + (index - 1) * 8
		args["spaceFeatures" .. index] = ns.OptionsSpacer(base, AllAlertsOff)
		AddBlock(args, "features" .. index, base, block, AllAlertsOff)
	end
end

--[[
    A group's own page in the settings tree, the parent its features' tabs nest
    under: the All Alerts status line, the group's summary, then the same block
    the root panel draws for it, so the group switch and its features can be
    worked from here without going back up. Nothing hides, the way a
    sub-panel's blocks never do; the status line says when All Alerts has the
    page silenced.
]]
function ns.BuildFeatureGroupOptions(group)
	local args = {
		summary = ns.OptionsDesc(L[group.summaryKey], 1),
		summarySpace = ns.OptionsSpacer(2),
	}
	ns.AddQuietStatus(args, 0.4)
	AddBlock(args, "group", 2, GroupBlock(group), ns.NeverHidden)

	return {
		type = "group",
		name = L[group.labelKey],
		args = args,
	}
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

	-- The switch at 23, the Features header at 24 and 25, then three blocks of eight orders from 26 end at 49.
	AddFeatureToggles(args, 22)

	return {
		type = "group",
		name = L["ADDON_TITLE"],
		args = args,
	}
end
