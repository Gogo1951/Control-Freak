local _, ns = ...

local L = ns.L
local GetColor = ns.GetColor

--[[
    The Feedback & Support rows override the default half-and-half label/control
    split. Their labels are one short word each, so the standard
    ns.OPTIONS_LABEL_WIDTH leaves a wide gap after "Wago" and spends half the row
    on nothing, while the URL beside it — the part the player is there to copy —
    truncates mid-address. Giving the label only what a word needs and the rest to
    the input fits every URL but the longest, and the two still total
    ns.OPTIONS_ROW_WIDTH, so the rows end where every other row ends.
]]
local LINK_LABEL_WIDTH = 0.6
local LINK_URL_WIDTH = ns.OPTIONS_ROW_WIDTH - LINK_LABEL_WIDTH

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

		spaceCommands0 = ns.OptionsSpacer(5),
		headerCommands = ns.OptionsHeader(L["OPTIONS_COMMANDS_HEADER"], 6),
		spaceCommands1 = ns.OptionsSpacer(7),
		descCommands = ns.OptionsDesc(
			GetColor("INFO") .. L["OPTIONS_COMMAND"] .. "|r" .. "  " .. L["OPTIONS_COMMAND_DESCRIPTION"],
			8
		),

		spaceKillSwitch0 = ns.OptionsSpacer(10),
		headerKillSwitch = ns.OptionsHeader(L["KILL_SWITCH"], 11),
		spaceKillSwitch1 = ns.OptionsSpacer(12),
		enabled = {
			type = "toggle",
			name = L["KILL_SWITCH_ENABLE"],
			desc = L["KILL_SWITCH_ENABLE_DESC"],
			width = "full",
			order = 13,
			get = function()
				return ns.db.profile.enabled
			end,
			set = function(_, value)
				ns.db.profile.enabled = value
				ns:ApplyProfile()
			end,
		},

		spaceFeedback0 = ns.OptionsSpacer(20),
		headerFeedback = ns.OptionsHeader(L["FEEDBACK_HEADER"], 21),
		spaceFeedback1 = ns.OptionsSpacer(22),

		spaceVersion = {
			type = "description",
			name = " ",
			width = "full",
			order = 998,
		},
		version = {
			type = "description",
			name = function()
				return GetColor("MUTED") .. L["VERSION"] .. " " .. ns.Version .. "|r"
			end,
			order = 999,
		},
	}

	local urls = {
		{ L["FEEDBACK_DISCORD"], ns.URL_DISCORD },
		{ L["FEEDBACK_GITHUB"], ns.URL_GITHUB },
		{ L["FEEDBACK_CURSEFORGE"], ns.URL_CURSEFORGE },
		{ L["FEEDBACK_WAGO"], ns.URL_WAGO },
	}

	local order = 23
	for index, row in ipairs(urls) do
		if index > 1 then
			args["urlSpace" .. index] = ns.OptionsSpacer(order)
			order = order + 1
		end
		local url = row[2]
		args["urlLabel" .. index] = ns.OptionsRowLabel(GetColor("TITLE") .. row[1] .. "|r", order, LINK_LABEL_WIDTH)
		args["urlValue" .. index] = {
			type = "input",
			name = "",
			width = LINK_URL_WIDTH,
			order = order + 1,
			get = function()
				return url
			end,
			set = function() end,
		}
		order = order + 2
	end

	return {
		type = "group",
		name = L["ADDON_TITLE"],
		args = args,
	}
end
