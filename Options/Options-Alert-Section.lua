local _, ns = ...

local L = ns.L

--[[
    Every alert on every tab is drawn as the same block, and this file is the
    only place that shape is written down:

        -- Name of the alert --

        One or two sentences on what it is and why it is worth having.

        [ ] Enable Alerts for Name of the alert On  [ Everything v]
                                    Print (Self Only)  Announce
            My Name of the alert           [ ]         [ Never v]
            Others' Name of the alert      [ ]         [ Never v]
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
-- Section Pieces
--------------------------------------------------------------------------------

--[[
    The stand-ins from the locale: the pet's name, and the player's for a client
    that cannot say yet who they are (PlayerName). In the locale because they
    sit inside a sentence whose grammar a translation may want to agree with.
]]
ns.SAMPLE_PLAYER = L["SAMPLE_PLAYER"]
ns.SAMPLE_PET = L["SAMPLE_PET"]

-- Skull: the mark a raid puts on the boss a sample line names.
ns.SAMPLE_RAID_ICON = 8

--[[
    How a sample line reaches whoever reads it, which decides how it is drawn:
    party chat for the line a section puts in front of the group, a whisper for
    the note one player receives, and the player's own window for a line that
    never leaves it. Party rather than raid because both are drawn the same way
    and party is the one every group has, so In a Party and In a Party or Raid
    draw alike.

    chatType is the client's own ChatTypeInfo key, so a player who recoloured
    party chat sees their own colour. The hex is only for a client that has not
    filled that table in. prefix is the client's own GlobalStrings line opener,
    so "[Party]" and "whispers:" read in the player's language.
]]
local SAMPLE_FORMS = {
	PARTY = { chatType = "PARTY", hex = "AAAAFF", prefix = CHAT_PARTY_GET or "[Party] %s: " },
	WHISPER = { chatType = "WHISPER", hex = "FF80FF", prefix = CHAT_WHISPER_GET or "%s whispers: " },
}

local function ChatColor(form)
	local info = ChatTypeInfo and ChatTypeInfo[form.chatType]
	if not info then
		return "|cff" .. form.hex
	end
	return string.format(
		"|cff%02x%02x%02x",
		math.floor(info.r * 255 + 0.5),
		math.floor(info.g * 255 + 0.5),
		math.floor(info.b * 255 + 0.5)
	)
end

--[[
    A chat frame draws a whole line in its channel's colour, so a link's closing
    |r falls back to that colour. A panel's text falls back to white instead,
    so the colour is opened again after every |r the line holds.
]]
local function Tint(color, text)
	return color .. (string.gsub(text, "|r", "|r" .. color)) .. "|r"
end

--[[
    The character the player is on, read when the line is drawn rather than when
    the panel is built, so every sample that means "you" names them. The
    stand-in is only for a client that has not said yet.
]]
local function PlayerName()
	return GetUnitName("player") or ns.SAMPLE_PLAYER
end

local function PlayerClass()
	local _, class = UnitClass("player")
	return class
end

--[[
    The sender as a chat frame names them: the player's own character, in their
    class colour, since every line in a sample is one this player's client
    would send.
]]
local function SampleSender()
	return "[" .. ns.GetClassColor(nil, PlayerClass()) .. PlayerName() .. "|r]"
end

--[[
    The players a sample names, so a printed sample colours them by class the
    way a real print does; sent chat drops the colour either way. The player's
    own part is a marker that RenderSample fills in with their character, and
    somebody else's is the name ns.SAMPLE_NAMES gives the class whose ability
    the sample names.
]]
function ns.SamplePlayer()
	return { kind = "samplePlayer" }
end

function ns.SampleOther(class)
	return ns.PlayerPart(ns.SAMPLE_NAMES[class] or ns.SAMPLE_NAMES.WARRIOR, nil, class)
end

--[[
    Who casts a sample line's spell, the spell, and the row the line follows:
    the player with their own class's spell from ns.SAMPLE_SPELL_IDS
    ("TAUNT_DRUID"), or, for a class that has none, the roster player of
    fallbackClass on the Others' row. The Example rule wants the name, its
    colour and the spell to agree, which a mage casting Pummel does not.
]]
function ns.SampleCaster(kind, fallbackClass)
	local spellId = ns.SAMPLE_SPELL_IDS[kind .. "_" .. (PlayerClass() or "")]
	if spellId then
		return ns.SamplePlayer(), ns.SpellPart(spellId), "mine"
	end
	return ns.SampleOther(fallbackClass), ns.SpellPart(ns.SAMPLE_SPELL_IDS[kind .. "_" .. fallbackClass]), "others"
end

--[[
    An "Example:" line, from { key, args, row }: a real locale format and
    stand-in arguments, the arguments as the parts ns:Alert takes (PlayerPart,
    SpellPart, TargetPart) or plain strings, and the row whose dropdown decides
    the form (AddSample). The label is helper silver, so it reads as an aside;
    the line after it is drawn the way it will actually arrive, so the player
    sees what their settings put where before it happens:

      PARTY     "[Party] [Gogo]: ..." in party colour, through
                ns:BuildAnnounceMessage -- the same call every sent line uses --
                with the {rtN} token drawn as the mark the receiving client shows
      WHISPER   "[Gogo] whispers: ..." in whisper colour, the same call again
      PRINT     the player's own window, through ns.BuildAlertLine, the string
                ns:PrintAlert prints

    A spell is its real link in the client's link blue, never a bare name, and
    rewording a message cannot leave a hand-copied example quoting the old text.
]]
local function RenderSample(sample, formKey)
	local rich = formKey == "PRINT"
	-- A function for a line built from the player's own settings, read each time the panel draws.
	local args = type(sample.args) == "function" and sample.args() or sample.args
	local count = #args
	local rendered = {}
	for index = 1, count do
		local part = args[index]
		if type(part) == "table" and part.kind == "samplePlayer" then
			part = ns.PlayerPart(PlayerName(), nil, PlayerClass())
		end
		rendered[index] = ns.RenderAlertPart(part, rich)
	end

	local line
	if rich then
		line = Tint(ns.GetColor("TEXT"), ns.BuildAlertLine(string.format(L[sample.key], unpack(rendered, 1, count))))
	else
		local form = SAMPLE_FORMS[formKey or "PARTY"]
		local message = ns:BuildAnnounceMessage(sample.key, unpack(rendered, 1, count))
		message = string.gsub(message, "{rt(%d)}", function(index)
			return ns.GetRaidIconTexture(tonumber(index))
		end)
		line = Tint(ChatColor(form), string.format(form.prefix, SampleSender()) .. message)
	end

	-- Silver opened again after the line, for a locale whose label runs on past it.
	return ns.OptionsSubLabel(string.format(L["SAMPLE_EXAMPLE"], line .. ns.GetColor("HELP")))
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
	args[prefix .. "WhisperSpace"] = ns.OptionsSpacer(order, rowsHidden)
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
		args[prefix .. "WhisperSampleSpace"] = ns.OptionsSpacer(order + 1.5, rowsHidden)
		args[prefix .. "WhisperSample"] = {
			type = "description",
			-- A function so the sender is the character the panel is opened on.
			name = function()
				return RenderSample(options.sample, "WHISPER")
			end,
			fontSize = "medium",
			order = order + 2,
			hidden = rowsHidden,
		}
	end
end

--[[
    The two dropdowns a whose-shaped row and its Against row offer, labelled from
    the locale once. Sorting comes from the ladders in Data/Data.lua, so each
    dropdown lists its choices in the order the ladder is written.
]]
local ANNOUNCE_VALUES = {}
for _, scope in ipairs(ns.ANNOUNCE_SCOPES) do
	ANNOUNCE_VALUES[scope] = L["ALERT_ANNOUNCE_" .. scope]
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
    A boss as a sample line's target, under the skull a raid would put on it, so
    the example shows the mark the real line carries. name is optional: a
    section whose whisper names the same boss passes the one it dealt.
]]
function ns.SampleTarget(name)
	return ns.TargetPart(name or ns.SampleBoss(), ns.SAMPLE_RAID_ICON)
end

--[[
    A spell's name from the client rather than the locale, for Diagnostics'
    check that every ns.SAMPLE_SPELL_IDS entry resolves. A sample line itself
    takes ns.SpellPart(id), which renders as the spell's link. The ids live in
    each flavor's Data/{Game}/Sample-Spells-{Game}.lua. Call it at build time:
    this client's spell data is not loaded when the options files are.
]]
function ns.SampleSpell(spellId)
	return (ns.GetSpellNameAndIcon(spellId)) or L["UNKNOWN_SPELL"]
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

	--[[
	    No header on a sub-panel that holds only this block: the page title above
	    it already names the alert, and a header under it would print it twice.
	]]
	if not options.noHeader then
		args[prefix .. "HeadSpace"] = ns.OptionsSpacer(order, hidden)
		args[prefix .. "Head"] = ns.OptionsHeader(L[options.headerKey], order + 1, hidden)
		args[prefix .. "HeadSpaceAfter"] = ns.OptionsSpacer(order + 2, hidden)
	end
	args[prefix .. "Desc"] = {
		type = "description",
		name = L[options.descKey],
		fontSize = "medium",
		order = order + 3,
		hidden = hidden,
	}
	args[prefix .. "DescSpace"] = ns.OptionsSpacer(order + 4, hidden)

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
    The sample under a section, drawn the way the row will draw it in a group: a
    row that announces anywhere shows the line in party chat, and one that never
    announces shows it in the player's own window. The line belongs to one row
    -- sample.row, "mine" unless the sample names somebody else -- so it is that
    row's dropdown the sample follows. A function, so the panel redraws it the
    moment the dropdown changes; the names and the boss in it were dealt at
    build time and hold still.
]]
local function AddSample(args, prefix, order, hidden, sample, getSettings)
	args[prefix .. "SampleSpace"] = ns.OptionsSpacer(order, hidden)
	args[prefix .. "Sample"] = {
		type = "description",
		name = function()
			local row = getSettings()[sample.row or "mine"]
			local announce = ns.ResolveChoice(row and row.announce, ns.ANNOUNCE_SCOPES, ns.ANNOUNCE_SCOPE_DEFAULT)
			return RenderSample(sample, announce == "NEVER" and "PRINT" or "PARTY")
		end,
		fontSize = "medium",
		order = order + 1,
		hidden = hidden,
	}
end

--------------------------------------------------------------------------------
-- Alert Section
--------------------------------------------------------------------------------

--[[
    The whose rows are three columns under the indent: the row's caption, its
    Print (Self Only) box, and its Announce dropdown. The dropdown keeps the
    sub-option control width so it starts in the column every dropdown above it
    shares; the print column comes out of the caption's half, wide enough for
    its header.
]]
local PRINT_COLUMN_WIDTH = 0.75
local ROW_CAPTION_WIDTH = ns.OPTIONS_SUB_LABEL_WIDTH - PRINT_COLUMN_WIDTH

-- The column headers over a section's whose rows.
local function WhoseHeaderRow(order, hidden)
	return ns.OptionsSubRow(order, hidden, {
		caption = { type = "description", name = " ", width = ROW_CAPTION_WIDTH, order = 1 },
		print = {
			type = "description",
			name = ns.OptionsSubLabel(L["ALERT_PRINT_HEADER"]),
			fontSize = "medium",
			width = PRINT_COLUMN_WIDTH,
			order = 2,
		},
		announce = {
			type = "description",
			name = ns.OptionsSubLabel(L["ALERT_ANNOUNCE_HEADER"]),
			fontSize = "medium",
			width = ns.OPTIONS_SUB_CONTROL_WIDTH,
			order = 3,
		},
	})
end

--[[
    One row of the whose shape: a caption naming whose casts, whether its line
    prints, and where it is announced. The box carries the row's own tooltip
    ahead of what printing does, since the caption beside it cannot show one.
]]
local function WhoseRow(order, hidden, getSettings, key, labelKey, descKey)
	local function Row()
		return getSettings()[key]
	end

	return ns.OptionsSubRow(order, hidden, {
		[key .. "Caption"] = {
			type = "description",
			name = ns.OptionsSubLabel(L[labelKey]),
			fontSize = "medium",
			width = ROW_CAPTION_WIDTH,
			order = 1,
		},
		[key .. "Print"] = {
			type = "toggle",
			name = "",
			desc = L[descKey] .. "\n\n" .. L["ALERT_PRINT_DESC"],
			width = PRINT_COLUMN_WIDTH,
			order = 2,
			get = function()
				return Row().print
			end,
			set = function(_, value)
				Row().print = value
			end,
		},
		[key .. "Announce"] = {
			type = "select",
			name = "",
			desc = L["ALERT_ANNOUNCE_DESC"],
			width = ns.OPTIONS_SUB_CONTROL_WIDTH,
			order = 3,
			values = ANNOUNCE_VALUES,
			sorting = ns.ANNOUNCE_SCOPES,
			get = function()
				return ns.ResolveChoice(Row().announce, ns.ANNOUNCE_SCOPES, ns.ANNOUNCE_SCOPE_DEFAULT)
			end,
			set = function(_, value)
				Row().announce = value
			end,
		},
	})
end

--[[
    The Against ladder, drawn beside the section's own switch rather than on a
    row of its own, so the two read as one sentence: "Enable Alerts for
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

        [ ] Enable Alerts for <thing> On              [ Everything v]
                                   Print (Self Only)  Announce
                My <thing>                [ ]         [ Never              v]
                Others' <thing>           [ ]         [ Never              v]
                <caption>                             [ ...                v]   (captionRow)
            [ ] Always Alert on Marked Targets
            [ ] ...                                                (extraRow)
            [ ] Play Sound              [ Control Freak: ... v] (speaker)

        Example: what the group would see

        [ ] Whisper ...                 [ ... v]                  (afterSample)

    Settings arrive as a getter because a profile switch replaces ns.db.profile,
    so a captured table would go stale.

    options:
      headerKey  the block's own gold header, naming the alert
      enableKey  the switch, "Enable Alerts for <thing> On" -- it ends
                 on the preposition the ladder completes; a noTarget section
                 drops the word
      descKey    one or two sentences between them
      sample     { key, args, row } naming a real locale format and stand-in
                 arguments, or a function returning them for a line built from
                 the player's own settings. row is optional, "mine" by default, and names the
                 row whose Announce dropdown picks the form. Redrawn every time
                 the panel draws, through ns.BuildAlertLine when that row never
                 announces and ns:BuildAnnounceMessage when it does
      mineKey    the caption of the player's own row, "My <thing>"
      mineDescKey
                 optional. The tooltip of that row, for a section whose row is
                 not simply the player's own casts, pet included: Armor Debuffs
                 reports the group's work, Cold Openers never counts a pet, and
                 a parry is not a cast
      othersKey  the caption of the others' row, "Others' <thing>". Optional: a
                 section that only ever reports the player's own casts leaves
                 it out and draws one row
      othersDescKey
                 optional. The tooltip of that row, the pair to mineDescKey,
                 for a section whose rows are whose but not about a cast: Tank
                 Deaths and Parries pass both, because what their rows report is
                 a death or a parry
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

	args[prefix .. "WhoseHeaderRow"] = WhoseHeaderRow(order + 6.8, rowsHidden)

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
	    what counts -- Include Faerie Fire, Ignore Tanks -- and
	    belongs with the filters above it, not after the one row that is about
	    noise. Extras run from +11; the sound sits at +14, the sample at +15.
	]]
	if options.extraRow then
		options.extraRow(args, order + 11, rowsHidden)
	end

	if not options.noSound then
		AddSoundRow(args, prefix, order + 14, rowsHidden, getSettings)
	end

	AddSample(args, prefix, order + 15, hidden, options.sample, getSettings)

	if options.afterSample then
		options.afterSample(args, order + 17, rowsHidden)
	end
end
