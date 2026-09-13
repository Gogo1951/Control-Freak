local _, ns = ...

local L = ns.L

--[[
    Every alert on every tab is drawn as the same block, and this file is the
    only place that shape is written down:

        -- Name of the alert --

        One or two sentences on what it is and why it is worth having.

        [ ] Enable Notifications for Name of the alert On  [ Everything v]
            [ ] My Name of the alert            [ Print (Self Only) v]
            [ ] Others' Name of the alert       [ Print (Self Only) v]
            [ ] Always Alert on Marked Targets
            [ ] Play Sound                      [ Control Freak: ... v]

        Example: what the group would see

        [ ] Some other option, a whisper       [ ... v]

    The header, the description, the switch and the sample are mandatory, so a
    new alert cannot arrive half-dressed: the header names it, the description
    sells it, the switch answers it, and the sample says what turning it on
    actually puts in chat. Everything else in the block -- the others' row, a
    caption row, the extra rows, the marked row, the sound row, a whisper -- is
    optional, and a section leaves out what it has no use for.

    ns.AddWhoseAlertSection is the one builder: the target ladder beside the
    switch, a row for the player's own casts and one for everybody else's, each
    with where its line goes, the mark, the sound, the example. The frame around
    the rows is its own function so a section that bends the block -- one row,
    no target, a caption row -- still cannot arrive without a header, a
    description, a switch and an example.
]]

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

--[[
    The block at the top of every feature tab: what the feature is, whether it
    runs, and the three questions that decide when. Each tab answers them for
    itself, so a player can watch taunts everywhere and pet growls only in
    dungeons without the two settings fighting.

    Everything a tab draws after this hides when the feature is off, so the page
    collapses to its title and one switch. The hidden predicate is baked into the
    builders rather than repeated per widget, the same arrangement the
    Diagnostics panel uses.
]]
--[[
    One row per scope question, keyed the way Data/Data.lua names them. gated is
    the ones that decide whether COMBAT_LOG_EVENT_UNFILTERED is registered at all,
    so setting them re-runs ns:ApplyProfile; the rest are read per event and need
    no re-registration.
]]
local SCOPE_ROWS = {
	groupHasTank = { label = "SCOPE_GROUP_HAS_TANK", desc = "SCOPE_GROUP_HAS_TANK_DESC" },
	instanceOnly = { label = "SCOPE_INSTANCE_ONLY", desc = "SCOPE_INSTANCE_ONLY_DESC", gated = true },
}

--[[
    The scope questions that are a choice rather than a switch. They do not get a
    row of their own: they go in the slot BESIDE the feature's enable, which is
    the same arrangement AddSectionFrame gives an alert's target ladder, and for
    the same reason -- a ladder that cannot be off is not narrowing the switch
    from below, it is finishing the switch's own sentence. Each value carries
    its own preposition ("As a Tank"), so the two read as one line.

    The slot holds one widget, so a tab may ask at most one of these. Nothing
    needs that limit today, and the loop in ns.AddFeatureScope keeps the last
    choice it finds, so a second would quietly drop the first.
]]
local SCOPE_CHOICES = {
	roleScope = {
		desc = "SCOPE_ROLE_DESC",
		ladder = ns.ROLE_SCOPES,
		default = ns.ROLE_SCOPE_DEFAULT,
		labelPrefix = "SCOPE_ROLE_",
	},
}

local CHOICE_VALUES = {}
for option, choice in pairs(SCOPE_CHOICES) do
	local values = {}
	for _, rung in ipairs(choice.ladder) do
		values[rung] = L[choice.labelPrefix .. rung]
	end
	CHOICE_VALUES[option] = values
end

--[[
    No header here: AceConfigDialog already draws the tab's own name at the top of
    the page, and a section header repeating it reads as the title printed twice.
    The summary opens the page instead, matching the root General panel.

    scopeKey names this feature's entry in ns.FEATURE_SCOPE_OPTIONS, which decides
    which questions the tab asks. Every tab asks where; only the tabs whose alerts
    are a tank's own instrument ask who is tanking.
]]
function ns.AddFeatureScope(args, getFeature, summaryKey, enableKey, order, scopeKey)
	local hidden = function()
		return not getFeature().enabled
	end

	--[[
	    Optional. A tab whose sections each introduce themselves has nothing left
	    for one sentence at the top to say, so it opens on the enable instead.
	]]
	if summaryKey then
		args.scopeSummary = ns.OptionsDesc(L[summaryKey], order)
		args.scopeSpace0 = ns.OptionsSpacer(order + 1)
	end

	--[[
	    Whichever of this tab's scope questions is a choice rather than a switch.
	    There is at most one, and it sits beside the enable rather than under it.
	]]
	local choiceOption
	for _, option in ipairs(ns.FEATURE_SCOPE_OPTIONS[scopeKey]) do
		if SCOPE_CHOICES[option] then
			choiceOption = option
		end
	end

	--[[
	    Full width when the enable is the whole row, narrowed to the label half
	    when a ladder sits beside it -- the pair totalling a row, the same trade
	    AddSectionFrame makes for an alert's switch.
	]]
	args.scopeEnabled = {
		type = "toggle",
		name = L[enableKey],
		desc = L["SCOPE_ENABLE_DESC"],
		width = choiceOption and ns.OPTIONS_LABEL_WIDTH or "full",
		order = order + 2,
		get = function()
			return getFeature().enabled
		end,
		set = function(_, value)
			getFeature().enabled = value
			ns:ApplyProfile()
		end,
	}

	if choiceOption then
		local choice = SCOPE_CHOICES[choiceOption]
		args.scopeChoice = {
			type = "select",
			name = "",
			desc = L[choice.desc],
			width = ns.OPTIONS_CONTROL_WIDTH,
			order = order + 2.5,
			--[[
			    NOT hidden with the rows below, for the same reason an alert's
			    target ladder is not hidden by its own switch: it belongs to the
			    switch beside it, and the switch is always drawn.
			]]
			values = CHOICE_VALUES[choiceOption],
			sorting = choice.ladder,
			get = function()
				return ns.ResolveChoice(getFeature()[choiceOption], choice.ladder, choice.default)
			end,
			set = function(_, value)
				getFeature()[choiceOption] = value
			end,
		}
	end

	--[[
	    Each narrows the enable above it, so they are sub-options: indented and
	    captioned in silver, marked twice over so the dependency reads whether the
	    player is scanning shape or color. Widths are sized to their captions with
	    room to spare -- a sub-row control on the wrap boundary tips onto its own
	    line and strands the indent above it.
	]]
	local rowOrder = order + 3
	for _, option in ipairs(ns.FEATURE_SCOPE_OPTIONS[scopeKey]) do
		local row = SCOPE_ROWS[option]
		if row then
			args["scope" .. option .. "Row"] = ns.OptionsSubRow(rowOrder, hidden, {
				[option] = {
					type = "toggle",
					name = ns.OptionsSubLabel(L[row.label]),
					desc = L[row.desc],
					width = ns.OPTIONS_SUB_LABEL_WIDTH,
					order = 1,
					get = function()
						return getFeature()[option]
					end,
					set = function(_, value)
						getFeature()[option] = value
						if row.gated then
							ns:ApplyProfile()
						end
					end,
				},
			})
			rowOrder = rowOrder + 1
		end
	end

	return hidden
end

--------------------------------------------------------------------------------
-- Section Pieces
--------------------------------------------------------------------------------

--[[
    An "Example:" line, rendered ONCE from { key, args } naming a real locale
    format and stand-in arguments. It goes through ns:BuildAnnounceMessage -- the
    same call every sent line uses, whispers included -- so the example is what
    somebody would actually receive, brand and all, and rewording a message
    cannot leave a hand-copied example quoting the old text. Helper silver, so
    it reads as an aside rather than as another setting.
]]
local function RenderSample(sample)
	return ns.OptionsSubLabel(
		string.format(L["SAMPLE_EXAMPLE"], ns:BuildAnnounceMessage(sample.key, unpack(sample.args)))
	)
end

--[[
    Exported for the one list that shows an example without an alert section
    around it -- Tank Deaths' class log, whose rows have no switch, no
    destination and no whose. It still wants its example dealt from here, so a
    reworded message cannot leave a hand-built example quoting the old text.
]]
ns.RenderSample = RenderSample

--[[
    A whisper toggle with a cooldown beside it -- the "some other option" row the
    sections that whisper share. The toggle is the row's label, so the dropdown
    carries no caption of its own and the two total ns.OPTIONS_ROW_WIDTH.

    The cooldown does NOT hide with the toggle, because it does not belong to it:
    it covers the whole alert, so a player who never whispers still uses it to keep
    one culprit from filling their window. Its tooltip says so.

    Orders step by halves so the row and its example fit inside the two whole
    numbers a caller has left before the next section: drawn after a block's
    sample at +17, the whisper runs 17 to 19 and the next section starts at 20.

    sample is optional. A whisper is a line somebody ELSE receives, so a section
    that sends one shows it, the way the block above shows what the group sees.

    rowsHidden, not the tab's own predicate: a switched-off section sends no
    whisper (ns:PassesAlertGates in Features/Announcements.lua), so the row goes
    with the rest of the controls rather than sitting under a dead section
    offering something that cannot happen.
]]
function ns.AddWhisperRow(args, prefix, order, rowsHidden, options)
	args[prefix .. "WhisperSpace"] = { type = "description", name = " ", order = order, hidden = rowsHidden }
	args[prefix .. "Whisper"] = {
		type = "toggle",
		name = L[options.labelKey],
		desc = L[options.descKey],
		width = ns.OPTIONS_LABEL_WIDTH,
		order = order + 0.5,
		hidden = rowsHidden,
		get = options.getWhisper,
		set = options.setWhisper,
	}
	args[prefix .. "WhisperCooldown"] = {
		type = "select",
		name = "",
		desc = L[options.cooldownDescKey],
		width = ns.OPTIONS_CONTROL_WIDTH,
		order = order + 1,
		hidden = rowsHidden,
		values = ns.BuildCooldownValues(options.cooldowns),
		sorting = options.cooldowns,
		get = options.getCooldown,
		set = options.setCooldown,
	}
	if options.sample then
		args[prefix .. "WhisperSampleSpace"] =
			{ type = "description", name = " ", order = order + 1.5, hidden = rowsHidden }
		args[prefix .. "WhisperSample"] = {
			type = "description",
			name = RenderSample(options.sample),
			fontSize = "medium",
			order = order + 2,
			hidden = rowsHidden,
		}
	end
end

--[[
    The stand-in names a sample line is rendered with. In the locale because they
    sit inside a sentence whose grammar a translation may want to agree with.
]]
ns.SAMPLE_PLAYER = L["SAMPLE_PLAYER"]
ns.SAMPLE_OTHER = L["SAMPLE_OTHER"]
ns.SAMPLE_PET = L["SAMPLE_PET"]

--[[
    The two dropdowns a whose-shaped row and its Against row offer, labelled from
    the locale once. Sorting comes from the ladders in Data/Data.lua, so each
    dropdown lists its choices in the order the ladder is written.
]]
local OUTPUT_VALUES = {}
for _, output in ipairs(ns.ALERT_OUTPUTS) do
	OUTPUT_VALUES[output] = L["ALERT_OUTPUT_" .. output]
end

local RUNG_VALUES = {}
for _, rung in ipairs(ns.TARGET_RUNGS) do
	RUNG_VALUES[rung] = L["TARGET_RUNG_" .. rung]
end

--[[
    A different boss in every sample line, dealt from a shuffled copy of
    ns.SAMPLE_BOSSES so no panel names the same one twice. The deck is reshuffled
    when it runs out, which the blocks the add-on draws today never manage.

    Dealt once per block at build time, so the names hold still for the session
    rather than changing under a player who is reading them.
]]
local bossDeck = {}

function ns.SampleBoss()
	if #bossDeck == 0 then
		for index, name in ipairs(ns.SAMPLE_BOSSES) do
			bossDeck[index] = name
		end
		for index = #bossDeck, 2, -1 do
			local swap = math.random(index)
			bossDeck[index], bossDeck[swap] = bossDeck[swap], bossDeck[index]
		end
	end
	return table.remove(bossDeck)
end

--[[
    A spell's name for a sample line, from the client rather than the locale, so
    the example reads in the player's own language and matches the tooltip they
    would see. Call it at build time: this client's spell data is not loaded when
    the options files are.
]]
function ns.SampleSpell(spellId, fallback)
	return (ns.GetSpellNameAndIcon(spellId)) or fallback
end

--[[
    ns.OptionsSpacer takes no hidden argument, so a gated spacer is its own
    description widget. Without it the block's blank lines outlive the controls
    they separate and a switched-off feature collapses to a column of empty rows.
]]
local function GatedSpacer(order, hidden)
	return { type = "description", name = " ", order = order, hidden = hidden }
end

--[[
    The frame every section shares, whichever shape its rows take: the blank
    line and gold header, the description, and the switch with an optional
    control beside it. Returns the predicate the rows under the switch hang on.

    Settings arrive as a getter because a profile switch replaces ns.db.profile,
    so a captured table would go stale.
]]
local function AddSectionFrame(args, prefix, getSettings, order, hidden, options)
	--[[
	    Hidden when the feature is off, and again when this alert is: a switched-off
	    block collapses to its header, its description and one line rather than
	    leaving five dead controls under it. The header, description and sample stay,
	    because together they are what tells a player whether to switch it back on.
	]]
	local rowsHidden = function()
		return hidden() or not getSettings().enabled
	end

	args[prefix .. "HeadSpace"] = GatedSpacer(order, hidden)
	args[prefix .. "Head"] = ns.OptionsHeader(L[options.headerKey], order + 1, hidden)
	args[prefix .. "HeadSpaceAfter"] = GatedSpacer(order + 2, hidden)
	args[prefix .. "Desc"] = {
		type = "description",
		name = L[options.descKey],
		fontSize = "medium",
		order = order + 3,
		hidden = hidden,
	}
	args[prefix .. "DescSpace"] = GatedSpacer(order + 4, hidden)

	args[prefix .. "Toggle"] = {
		type = "toggle",
		name = L[options.enableKey],
		desc = L["ALERT_SECTION_ENABLE_DESC"],
		-- Narrowed only when something sits beside it, the pair totalling a row.
		width = options.control and ns.OPTIONS_LABEL_WIDTH or "full",
		order = order + 5,
		hidden = hidden,
		get = function()
			return getSettings().enabled
		end,
		set = function(_, value)
			getSettings().enabled = value
		end,
	}
	if options.control then
		options.control.order = order + 6
		options.control.hidden = hidden
		args[prefix .. "Control"] = options.control
	end

	return rowsHidden
end

--[[
    The sound row both shapes share. Toggle, dropdown, then speaker last. The
    picker keeps the full sub-option label width so it starts in the same column
    as the dropdowns above it, and the speaker goes in the margin past the end of
    the row -- the only place the grid runs wide, and it costs nothing.

    It previews regardless of the toggle's state, which is the point of it:
    hearing a sound BEFORE turning it on is what the button is for.
]]
local function AddSoundRow(args, prefix, order, rowsHidden, getSettings)
	args[prefix .. "SoundRow"] = ns.OptionsSubRow(order, rowsHidden, {
		sound = {
			type = "toggle",
			name = ns.OptionsSubLabel(L["ALERT_SOUND"]),
			desc = L["ALERT_SOUND_DESC"],
			width = ns.OPTIONS_SUB_LABEL_WIDTH,
			order = 1,
			get = function()
				return getSettings().sound
			end,
			set = function(_, value)
				getSettings().sound = value
			end,
		},
		soundName = {
			type = "select",
			name = "",
			desc = L["ALERT_SOUND_FILE_DESC"],
			width = ns.OPTIONS_SUB_CONTROL_WIDTH,
			order = 2,
			values = ns.GetSoundValues,
			-- Picking a sound plays it, which is the other half of the preview.
			get = function()
				return getSettings().soundName
			end,
			set = function(_, value)
				getSettings().soundName = value
				ns:PlayAlertSound(value)
			end,
		},
		soundPreview = ns.DefineSoundPreview(function()
			ns:PlayAlertSound(getSettings().soundName)
		end, 3),
	})
end

--[[
    The sample under a section. One line, rendered ONCE at build time and never
    re-read: it says what the alert says, not what the controls around it are
    set to, so it holds still while the player changes them. It shows the
    ANNOUNCE form rather than the local print: the print is the player's own
    window and costs nothing, while what a section puts in front of the whole
    raid is the thing worth seeing before switching it on.
]]
local function AddSample(args, prefix, order, hidden, sample)
	args[prefix .. "SampleSpace"] = GatedSpacer(order, hidden)
	args[prefix .. "Sample"] = {
		type = "description",
		name = RenderSample(sample),
		fontSize = "medium",
		order = order + 1,
		hidden = hidden,
	}
end

--------------------------------------------------------------------------------
-- Alert Section
--------------------------------------------------------------------------------

--[[
    One row of the whose shape: a switch naming whose casts, and beside it where
    their line goes. The pair is one sentence -- report my taunts, to my window --
    which is why the dropdown sits beside the switch rather than under it.
]]
local function WhoseRow(order, hidden, getSettings, key, labelKey, descKey)
	local function Row()
		return getSettings()[key]
	end

	return ns.OptionsSubRow(order, hidden, {
		[key] = {
			type = "toggle",
			name = ns.OptionsSubLabel(L[labelKey]),
			desc = L[descKey],
			width = ns.OPTIONS_SUB_LABEL_WIDTH,
			order = 1,
			get = function()
				return Row().enabled
			end,
			set = function(_, value)
				Row().enabled = value
			end,
		},
		[key .. "Output"] = {
			type = "select",
			name = "",
			desc = L["ALERT_OUTPUT_DESC"],
			width = ns.OPTIONS_SUB_CONTROL_WIDTH,
			order = 2,
			values = OUTPUT_VALUES,
			sorting = ns.ALERT_OUTPUTS,
			get = function()
				return ns.ResolveChoice(Row().output, ns.ALERT_OUTPUTS, ns.ALERT_OUTPUT_DEFAULT)
			end,
			set = function(_, value)
				Row().output = value
			end,
		},
	})
end

--[[
    The Against ladder, drawn beside the section's own switch rather than on a
    row of its own, so the two read as one sentence: "Enable Notifications for
    Successful Taunts On [Everything]". It is a choice, not a switch, and it
    borrows the section's switch rather than carrying a box of its own. It goes
    in the control slot AddSectionFrame already offers, which narrows the switch
    to ns.OPTIONS_LABEL_WIDTH so the pair totals a row and the dropdown lines up
    with the ones under it. The frame sets its order and hidden.
]]
local function AgainstControl(getSettings)
	return {
		type = "select",
		name = "",
		desc = L["ALERT_AGAINST_DESC"],
		width = ns.OPTIONS_CONTROL_WIDTH,
		values = RUNG_VALUES,
		sorting = ns.TARGET_RUNGS,
		get = function()
			return ns.ResolveChoice(getSettings().against, ns.TARGET_RUNGS, ns.TARGET_RUNG_DEFAULT)
		end,
		set = function(_, value)
			getSettings().against = value
		end,
	}
end

--[[
    One alert's worth of controls: the frame above, with the target ladder in
    the slot beside the switch, then the rows under it

        [ ] Enable Notifications for <thing> On       [ Everything v]
            [ ] My <thing>              [ Print (Self Only)  v]
            [ ] Others' <thing>         [ Print (Self Only)  v]
                <caption>               [ ...                v]   (captionRow)
            [ ] Always Alert on Marked Targets
            [ ] ...                                                (extraRow)
            [ ] Play Sound              [ Control Freak: ... v] (speaker)

        Example: what the group would see

        [ ] Whisper ...                 [ ... v]                  (afterSample)

    Settings arrive as a getter because a profile switch replaces ns.db.profile,
    so a captured table would go stale.

    options:
      headerKey  the block's own gold header, naming the alert
      enableKey  the switch, "Enable Notifications for <thing> On" -- it ends
                 on the preposition the ladder completes; a noTarget section
                 drops the word
      descKey    one or two sentences between them
      sample     { key, args } naming a real locale format and stand-in
                 arguments, rendered once through ns:BuildAnnounceMessage
      mineKey    the caption of the player's own row, "My <thing>"
      mineDescKey
                 optional. The tooltip of that row, for a section whose one row
                 is not the player's own casts: Armor Debuffs reports the
                 group's work, so "My" would be wrong and the row says what it is
      othersKey  the caption of the others' row, "Others' <thing>". Optional: a
                 section that only ever reports the player's own casts leaves
                 it out and draws one row
      othersDescKey
                 optional. The tooltip of that row, the pair to mineDescKey,
                 for a section whose rows are whose but not about a cast: Tank
                 Deaths passes both, because what either row reports is a death
      captionRow optional. { labelKey, control } for a parameter of the
                 detection -- Cold Openers' window -- drawn as a caption and a
                 dropdown under the whose rows, through ns.OptionsSubCaptionRow
      noSound    optional. Draw no sound row -- an alert that fires once after
                 the fact does not need one
      extraRow   optional. function(args, order, rowsHidden) for rows the alert
                 owns beyond the standard ones, drawn UNDER the indent between
                 the filters and the sound, taking rowsHidden so they collapse
                 with the rest when the alert is switched off
      noTarget   optional. Put no ladder beside the switch and draw no Always
                 Alert on Marked Targets row, for a section whose message names no mob
                 -- an AOE taunt -- and so has nothing either filter could
                 apply to. Its switch then spans the row on its own, and its
                 defaults carry neither key (WhoseAlertDefaults in
                 Default-Settings.lua)
      afterSample
                 optional. function(args, order, rowsHidden) for a row the
                 section owns that is NOT one of the alert's own outputs -- a
                 whisper to somebody else. Drawn at the section's own indent
                 BELOW the sample, so the example has already shown what the
                 alert says before the row that sends something further. It
                 takes rowsHidden rather than the tab's predicate, so it
                 collapses with the other rows when the alert is switched off.
                 Orders run from +17; the next section starts at +20, which is
                 why ns.AddWhisperRow steps by halves

      control    optional, and ONLY on a noTarget section. The slot beside the
                 switch belongs to the Against ladder, and the builder
                 overwrites `control` with it on any section that has a target,
                 so passing one there silently loses it. A noTarget section has
                 no ladder, which frees the slot: Bad Shields puts its health
                 choice in it, so the switch and the dropdown read as one
                 sentence the way every laddered section does
]]
function ns.AddWhoseAlertSection(args, prefix, getSettings, order, hidden, options)
	if not options.noTarget then
		options.control = AgainstControl(getSettings)
	end
	local rowsHidden = AddSectionFrame(args, prefix, getSettings, order, hidden, options)

	--[[
	    A caption row is a DEFINITION where it leads and a footnote where it
	    follows, and which one it is depends on the section. Cold Openers' window
	    qualifies the rows above it, so it sits under them; Incapacitated's "Long"
	    threshold is what the two rows below it are named after, so it goes first
	    and they read as its two branches.
	]]
	if options.captionRow and options.captionRowFirst then
		args[prefix .. "CaptionRow"] =
			ns.OptionsSubCaptionRow(order + 6.5, rowsHidden, L[options.captionRow.labelKey], options.captionRow.control)
	end

	--[[
	    Whose casts, by default: the player's own and everybody else's, which is
	    the question all but one section asks. A section may name its own pair
	    instead -- Incapacitated splits on how LONG the effect lasts rather than on
	    whose it was, because the game only ever reports the player's own.

	    The key is the settings key AND the widget key, so a row's stored name
	    always matches what the panel calls it, and ns:Alert is handed that same
	    name to pick the row with.
	]]
	local rows = options.rows
		or {
			{ key = "mine", labelKey = options.mineKey, descKey = options.mineDescKey or "ALERT_MINE_DESC" },
			options.othersKey and {
				key = "others",
				labelKey = options.othersKey,
				descKey = options.othersDescKey or "ALERT_OTHERS_DESC",
			} or nil,
		}

	for index, row in ipairs(rows) do
		-- MineRow, OthersRow, ShortRow, LongRow: the stored key, capitalized.
		local widget = prefix .. (row.key:gsub("^%l", string.upper)) .. "Row"
		args[widget] = WhoseRow(order + 6 + index, rowsHidden, getSettings, row.key, row.labelKey, row.descKey)
	end

	if options.captionRow and not options.captionRowFirst then
		args[prefix .. "CaptionRow"] =
			ns.OptionsSubCaptionRow(order + 8.5, rowsHidden, L[options.captionRow.labelKey], options.captionRow.control)
	end

	if not options.noTarget then
		--[[
		    The one row that widens the section rather than narrowing it: ticked,
		    a raid mark overrides the ladder beside the switch; unticked, the
		    ladder is the whole answer. Both are real states, so it is a plain box
		    rather than a rung of its own.
		]]
		args[prefix .. "MarkedRow"] = ns.OptionsSubRow(order + 9, rowsHidden, {
			alwaysWhenMarked = {
				type = "toggle",
				name = ns.OptionsSubLabel(L["ALERT_MARKED_ALWAYS"]),
				desc = L["ALERT_MARKED_ALWAYS_DESC"],
				width = ns.OPTIONS_SUB_LABEL_WIDTH,
				order = 1,
				get = function()
					return getSettings().alwaysWhenMarked
				end,
				set = function(_, value)
					getSettings().alwaysWhenMarked = value
				end,
			},
		})
	end

	--[[
	    Extras before the sound: what a section adds under the indent changes
	    what counts -- Include Faerie Fire, Ignore Other Tanks -- and
	    belongs with the filters above it, not after the one row that is about
	    noise. Extras run from +11; the sound sits at +14, the sample at +15.
	]]
	if options.extraRow then
		options.extraRow(args, order + 11, rowsHidden)
	end

	if not options.noSound then
		AddSoundRow(args, prefix, order + 14, rowsHidden, getSettings)
	end

	AddSample(args, prefix, order + 15, hidden, options.sample)

	if options.afterSample then
		options.afterSample(args, order + 17, rowsHidden)
	end
end
