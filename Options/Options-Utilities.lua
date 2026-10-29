local _, ns = ...

local L = ns.L
local GetColor = ns.GetColor

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

--------------------------------------------------------------------------------
-- Standard Helpers
--------------------------------------------------------------------------------

function ns.OptionsHeader(text, order, hidden)
	return { type = "header", name = GetColor("TITLE") .. text .. "|r", order = order, hidden = hidden }
end

function ns.OptionsDesc(text, order)
	return { type = "description", name = text, fontSize = "medium", order = order }
end

function ns.OptionsSpacer(order, hidden)
	return { type = "description", name = " ", order = order, hidden = hidden }
end

function ns.OptionsRowLabel(text, order, width)
	return {
		type = "description",
		name = text,
		fontSize = "medium",
		width = width or ns.OPTIONS_LABEL_WIDTH,
		order = order,
	}
end

--[[
    Lays toggles out two to a line, each pair in its own unnamed inline group so
    every pair pins its own row. The widths leave slack under
    ns.OPTIONS_ROW_WIDTH: a row summing exactly to the pane sits on the wrap
    boundary and can drop its second toggle onto a line of its own. Each
    toggle's width and order are set here.
]]
local TOGGLE_PAIR_WIDTH = 1.6

--[[
    hidden is optional and goes on each pair's group, so a gated block collapses
    whole. indent is optional too: it leads each pair with the blank cell a
    sub-option row uses, for pairs listed under a label of their own.
]]
function ns.OptionsTogglePairs(args, keyPrefix, startOrder, toggles, hidden, indent)
	for index = 1, #toggles, 2 do
		local pair = {}
		if indent then
			pair.indent = { type = "description", name = " ", width = ns.OPTIONS_SUB_INDENT_WIDTH, order = 0 }
		end
		for offset = 0, 1 do
			local toggle = toggles[index + offset]
			if toggle then
				toggle.width = TOGGLE_PAIR_WIDTH
				toggle.order = offset + 1
				pair["toggle" .. (offset + 1)] = toggle
			end
		end
		args[keyPrefix .. index] = {
			type = "group",
			name = "",
			inline = true,
			order = startOrder + index,
			hidden = hidden,
			args = pair,
		}
	end
end

--[[
    A sub-panel's page title names its parent, "Taunts > Tracked Abilities", so
    a page reached from search still says whose list it is. The tree beside it
    shows only the short name passed to AddToBlizOptions.
]]
function ns.SubPanelTitle(parentName, name)
	return parentName .. " > " .. name
end

-- For a sub-panel's blocks: they stay drawn whether or not the feature is on.
function ns.NeverHidden()
	return false
end

function ns.OptionsSubLabel(text)
	return GetColor("HELP") .. text .. "|r"
end

--[[
    The status line at the top of a page that a switch elsewhere has silenced:
    All Alerts off; the General panel's group switch over this page's feature
    (ns.FEATURE_GROUPS); or, given parentKey, the feature this sub-page belongs
    to. Without it a player can tick every box here and never learn why nothing
    fires. tabKey is the parent's TAB_* key. featureKey names the feature whose
    group to ask, for a feature's own page, which passes no parentKey; a
    sub-page's parentKey answers that too. Every one of these switches re-runs
    ns:ApplyProfile, which notifies every panel, so the line follows them.
]]
function ns.AddQuietStatus(args, order, parentKey, tabKey, featureKey)
	featureKey = featureKey or parentKey
	local function GroupOff()
		return featureKey and not ns.IsFeatureGroupOn(featureKey)
	end
	local function Silenced()
		return not ns.db.profile.enabled or GroupOff() or (parentKey and not ns.db.profile[parentKey].enabled)
	end
	local function Hidden()
		return not Silenced()
	end

	--[[
	    Silver, reopened after each coloured part: the switch's name in gold, the word off in red.
	    AceConfigDialog reads every option's name while sorting, hidden ones included, so this
	    answers blank when there is nothing to say: a feature tab passes no tabKey, and L[nil]
	    throws, which stops the whole page drawing.
	]]
	local function Name()
		if not Silenced() then
			return ""
		end
		local help = GetColor("HELP")
		local off = GetColor("OFF") .. L["STATUS_OFF"] .. "|r" .. help
		local line
		if not ns.db.profile.enabled then
			line = string.format(
				L["STATUS_ALL_ALERTS_OFF"],
				GetColor("TITLE") .. L["KILL_SWITCH"] .. "|r" .. help,
				off,
				L["KILL_SWITCH_ENABLE"],
				L["ADDON_TITLE"]
			)
		elseif GroupOff() then
			-- The group's switch is captioned with its own label, on the group's own page, this page's parent.
			local label = L[ns.FEATURE_GROUP_OF[featureKey].labelKey]
			line = string.format(L["STATUS_FEATURE_OFF"], GetColor("TITLE") .. label .. "|r" .. help, off, label)
		else
			line =
				string.format(L["STATUS_FEATURE_OFF"], GetColor("TITLE") .. L[tabKey] .. "|r" .. help, off, L[tabKey])
		end
		return help .. line .. "|r"
	end

	args.quietStatus = {
		type = "description",
		name = Name,
		fontSize = "medium",
		order = order,
		hidden = Hidden,
	}
	args.quietStatusSpace = ns.OptionsSpacer(order + 0.3, Hidden)
end

--[[
    A blank line and a header: the pair that opens a block on a feature tab. Both
    carry the tab's hidden predicate, because a spacer that outlives the controls
    it separated leaves a switched-off feature as a column of empty rows.

    trailingSpace adds the blank line under the header. A notifications header
    does not want one -- the alert section below opens with its own -- while an
    abilities header does, since the inline class groups start immediately.

    The keys are suffixed "Header...", apart from the "HeadSpace", "Head" and
    "DescSpace" an alert section uses, so a header and a section may share a
    prefix without one quietly overwriting the other's spacer.
]]
function ns.AddGatedHeader(args, key, titleKey, order, hidden, trailingSpace)
	args[key .. "HeaderSpace"] = ns.OptionsSpacer(order, hidden)
	args[key .. "Header"] = ns.OptionsHeader(L[titleKey], order + 1, hidden)
	if trailingSpace then
		args[key .. "HeaderSpaceAfter"] = ns.OptionsSpacer(order + 2, hidden)
	end
end

--[[
    One unnamed inline group per sub-option, which is what pins one row per
    sub-option: laid out flat, the next pair packs onto whatever space is left
    and the indent stops indenting anything. The indent has to be a real widget
    too, because AceConfig pins a checkbox at the left edge of its own widget, so
    padding the label with spaces would move only the caption.

    hidden goes on the group, never on the members, or the indent is left behind
    on its own line when the section collapses.
]]
function ns.OptionsSubRow(order, hidden, controls)
	local args = {
		indent = {
			type = "description",
			name = " ",
			width = ns.OPTIONS_SUB_INDENT_WIDTH,
			order = 0,
		},
	}
	for key, control in pairs(controls) do
		args[key] = control
	end
	return {
		type = "group",
		name = "",
		inline = true,
		order = order,
		hidden = hidden,
		args = args,
	}
end

--[[
    A sub-row that is a caption and a control, not a switch: a parameter of the
    detection rather than something on or off. The caption sits behind a blank
    cell the width of a checkbox (ns.OPTIONS_SUB_CAPTION_INDENT_WIDTH) so its
    first letter lands in the column the captions beside boxes start in, and it
    gives up that much width so the row still ends where its neighbours do. The
    control's order is set here; the caller supplies everything else.
]]
function ns.OptionsSubCaptionRow(order, hidden, caption, control)
	control.order = 3
	return ns.OptionsSubRow(order, hidden, {
		captionIndent = {
			type = "description",
			name = " ",
			width = ns.OPTIONS_SUB_CAPTION_INDENT_WIDTH,
			order = 1,
		},
		caption = {
			type = "description",
			name = ns.OptionsSubLabel(caption),
			fontSize = "medium",
			width = ns.OPTIONS_SUB_CAPTION_WIDTH,
			order = 2,
		},
		control = control,
	})
end

--------------------------------------------------------------------------------
-- Sound List
--------------------------------------------------------------------------------

--[[
    The speaker icon that previews a sound, sitting on the same row right after
    its Sound toggle. It plays regardless of the toggle's state -- hearing the
    sound BEFORE turning it on is the point. The texture is the client's own
    voice-chat speaker, so it matches the UI in every locale without shipping art.
]]
function ns.DefineSoundPreview(playSound, order, hidden)
	return {
		type = "execute",
		name = "",
		desc = L["ALERT_SOUND_PREVIEW_DESC"],
		image = "Interface\\Common\\VoiceChat-Speaker",
		imageWidth = 18,
		imageHeight = 18,
		width = ns.OPTIONS_SPEAKER_WIDTH,
		order = order,
		hidden = hidden,
		func = playSound,
	}
end

local soundValues = {}
local soundCount = -1

--[[
    Every sound any add-on has registered with LibSharedMedia shows up here, so
    the picker grows as the player's other add-ons contribute.
]]
function ns.GetSoundValues()
	local list = LibSharedMedia:List("sound")
	if #list ~= soundCount then
		wipe(soundValues)
		soundValues[ns.SOUND_NONE] = L["SOUND_NONE"]
		for _, name in ipairs(list) do
			soundValues[name] = name
		end
		soundCount = #list
	end
	return soundValues
end

--------------------------------------------------------------------------------
-- Cooldown Values
--------------------------------------------------------------------------------

--[[
    "30 Second Cooldown" and friends, built from a list of seconds. Whole minutes
    read as minutes, because "300 Second Cooldown" is arithmetic the player should
    not have to do, and zero reads as "No Cooldown" for the same reason: "0 Second
    Cooldown" is a sentence nobody says.
]]
function ns.BuildCooldownValues(seconds)
	local values = {}
	for _, count in ipairs(seconds) do
		if count == 0 then
			values[count] = L["COOLDOWN_NONE"]
		elseif count < 60 then
			values[count] = string.format(L["COOLDOWN_SECONDS"], count)
		else
			values[count] = string.format(L["COOLDOWN_MINUTES"], count / 60)
		end
	end
	return values
end
