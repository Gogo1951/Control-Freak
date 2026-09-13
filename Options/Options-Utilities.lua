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

function ns.OptionsSpacer(order)
	return { type = "description", name = " ", order = order }
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

function ns.OptionsSubLabel(text)
	return GetColor("HELP") .. text .. "|r"
end

--[[
    A blank line and a header: the pair that opens a block on a feature tab. Both
    carry the tab's hidden predicate, because ns.OptionsSpacer takes no hidden
    argument and a spacer that outlives the controls it separated leaves a
    switched-off feature as a column of empty rows.

    trailingSpace adds the blank line under the header. A notifications header
    does not want one -- the alert section below opens with its own -- while an
    abilities header does, since the inline class groups start immediately.

    The keys are suffixed "Header...", apart from the "HeadSpace", "Head" and
    "DescSpace" an alert section uses, so a header and a section may share a
    prefix without one quietly overwriting the other's spacer.
]]
function ns.AddGatedHeader(args, key, titleKey, order, hidden, trailingSpace)
	args[key .. "HeaderSpace"] = { type = "description", name = " ", order = order, hidden = hidden }
	args[key .. "Header"] = ns.OptionsHeader(L[titleKey], order + 1, hidden)
	if trailingSpace then
		args[key .. "HeaderSpaceAfter"] = { type = "description", name = " ", order = order + 2, hidden = hidden }
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
