local _, ns = ...

local L = ns.L
local GetColor = ns.GetColor

--[[
    The link rows override the default label/control split. Their labels are one
    short word each, so the standard label width would leave a wide gap after
    "Wago" while the URL beside it, the part the player is here to copy,
    truncates mid-address. The label takes only what a word needs and the box
    takes the rest, and the two still total ns.OPTIONS_ROW_WIDTH, so the rows end
    where every other row ends.
]]
local LINK_LABEL_WIDTH = 0.6
local LINK_URL_WIDTH = ns.OPTIONS_ROW_WIDTH - LINK_LABEL_WIDTH

-- { captionKey, linkKey }, in display order; the URLs live in ns.LINKS (Data/Data.lua).
local LINKS = {
	{ "OPTIONS_DISCORD", "DISCORD" },
	{ "OPTIONS_CURSEFORGE", "CURSEFORGE" },
	{ "OPTIONS_WAGO", "WAGO" },
	{ "OPTIONS_GITHUB", "GITHUB" },
}

local LEVEL_UP_PARAGRAPHS = {
	"OPTIONS_LEVEL_UP_INTRO",
	"OPTIONS_LEVEL_UP_WAYS",
	"OPTIONS_LEVEL_UP_FEEDBACK",
	"OPTIONS_LEVEL_UP_FRIEND",
	"OPTIONS_LEVEL_UP_CURSEFORGE",
	"OPTIONS_LEVEL_UP_GITHUB",
	"OPTIONS_LEVEL_UP_THANKS",
}

--------------------------------------------------------------------------------
-- Feedback & Support Panel
--------------------------------------------------------------------------------

--[[
    The group's name is the page title; the tree lists the page under
    OPTIONS_FEEDBACK, the name it is registered with in Options/Options.lua.
]]
function ns.BuildFeedbackSupportOptions()
	local args = {}
	local order = 1

	for index, key in ipairs(LEVEL_UP_PARAGRAPHS) do
		if index > 1 then
			args["spacerLevelUp" .. index] = ns.OptionsSpacer(order)
			order = order + 1
		end
		args["descLevelUp" .. index] = ns.OptionsDesc(L[key], order)
		order = order + 1
	end

	args.spacerLinks0 = ns.OptionsSpacer(50)
	args.headerLinks = ns.OptionsHeader(L["OPTIONS_FEEDBACK_LINKS_HEADER"], 51)
	args.spacerLinks1 = ns.OptionsSpacer(52)

	order = 53
	for index, entry in ipairs(LINKS) do
		local captionKey, linkKey = entry[1], entry[2]

		if index > 1 then
			args["spacerLink" .. index] = ns.OptionsSpacer(order)
			order = order + 1
		end
		args["labelLink" .. index] =
			ns.OptionsRowLabel(GetColor("TITLE") .. L[captionKey] .. "|r", order, LINK_LABEL_WIDTH)
		args["link" .. index] = {
			type = "input",
			name = "",
			width = LINK_URL_WIDTH,
			order = order + 1,
			get = function()
				return ns.LINKS[linkKey]
			end,
			set = function() end,
		}
		order = order + 2
	end

	args.spacerCopyLink = ns.OptionsSpacer(order)
	args.descCopyLink = ns.OptionsDesc(GetColor("HELP") .. L["OPTIONS_COPY_LINK"] .. "|r", order + 1)

	args.spaceVersion0 = {
		type = "description",
		name = " ",
		width = "full",
		order = 998,
	}
	args.versionLine = {
		type = "description",
		name = GetColor("INFO") .. L["OPTIONS_VERSION"]:format(ns.Version) .. "|r",
		fontSize = "medium",
		order = 999,
	}

	return {
		type = "group",
		name = L["OPTIONS_LEVEL_UP_TITLE"],
		args = args,
	}
end
