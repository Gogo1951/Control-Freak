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

    The keys are suffixed "Header..." rather than the "Space0" an alert section
    uses, so a header and a section may share a key without one quietly
    overwriting the other's spacer. The Tanking Tools tab does exactly that: its
    header and its section are both "nova".
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

-- Every sound any add-on has registered with LibSharedMedia shows up here, so
-- the picker grows as the player's other add-ons contribute.
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
	tankRoleOnly = { label = "SCOPE_TANK_ROLE_ONLY", desc = "SCOPE_TANK_ROLE_ONLY_DESC" },
	groupHasTank = { label = "SCOPE_GROUP_HAS_TANK", desc = "SCOPE_GROUP_HAS_TANK_DESC" },
	instanceOnly = { label = "SCOPE_INSTANCE_ONLY", desc = "SCOPE_INSTANCE_ONLY_DESC", gated = true },
}

-- No header here: AceConfigDialog already draws the tab's own name at the top of
-- the page, and a section header repeating it reads as the title printed twice.
-- The summary opens the page instead, matching the root General panel.
--
-- scopeKey names this feature's entry in ns.FEATURE_SCOPE_OPTIONS, which decides
-- which questions the tab asks. Every tab asks where; only the tabs whose alerts
-- are a tank's own instrument ask who is tanking.
function ns.AddFeatureScope(args, getFeature, summaryKey, enableKey, order, scopeKey)
	local hidden = function()
		return not getFeature().enabled
	end

	-- Optional. A tab whose sections each introduce themselves has nothing left
	-- for one sentence at the top to say, so it opens on the enable instead.
	if summaryKey then
		args.scopeSummary = ns.OptionsDesc(L[summaryKey], order)
		args.scopeSpace0 = ns.OptionsSpacer(order + 1)
	end

	-- Full width with nothing beside it: the enable is the whole row, and the
	-- scope sub-options below are the only thing that narrows it.
	args.scopeEnabled = {
		type = "toggle",
		name = L[enableKey],
		desc = L["SCOPE_ENABLE_DESC"],
		width = "full",
		order = order + 2,
		get = function()
			return getFeature().enabled
		end,
		set = function(_, value)
			getFeature().enabled = value
			ns:ApplyProfile()
		end,
	}

	-- Each narrows the enable above it, so they are sub-options: indented and
	-- captioned in silver, marked twice over so the dependency reads whether the
	-- player is scanning shape or color. Widths are sized to their captions with
	-- room to spare -- a sub-row control on the wrap boundary tips onto its own
	-- line and strands the indent above it.
	local rowOrder = order + 3
	for _, option in ipairs(ns.FEATURE_SCOPE_OPTIONS[scopeKey]) do
		local row = SCOPE_ROWS[option]
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

	return hidden
end

--------------------------------------------------------------------------------
-- Alert Section
--------------------------------------------------------------------------------
--[[
    Every alert on every tab is drawn as the same block, and this is the only
    place that shape is written down:

        -- Name of the alert --

        One or two sentences on what it is and why it is worth having.

        [ ] Enable Name of the alert
            [ ] Print Out Notifications
            [ ] ...

        [ ] Some other option

        Example: what the group would see

    Every piece but the extra row is mandatory, so a new alert cannot arrive
    half-dressed. The header names it, the description sells it, the switch
    answers it, and the sample says what turning it on actually puts in chat.
]]

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

--[[
    A whisper toggle with a cooldown beside it -- the "some other option" row Bad
    Pet and Parry Warnings share. The toggle is the row's label, so the dropdown
    carries no caption of its own and the two total ns.OPTIONS_ROW_WIDTH.

    The cooldown does NOT hide with the toggle, because it does not belong to it:
    it covers the whole alert, so a player who never whispers still uses it to keep
    one culprit from filling their window. Its tooltip says so.
]]
function ns.AddWhisperRow(args, prefix, order, hidden, options)
	args[prefix .. "WhisperSpace"] = { type = "description", name = " ", order = order, hidden = hidden }
	args[prefix .. "Whisper"] = {
		type = "toggle",
		name = L[options.labelKey],
		desc = L[options.descKey],
		width = ns.OPTIONS_LABEL_WIDTH,
		order = order + 1,
		hidden = hidden,
		get = options.getWhisper,
		set = options.setWhisper,
	}
	args[prefix .. "WhisperCooldown"] = {
		type = "select",
		name = "",
		desc = L[options.cooldownDescKey],
		width = ns.OPTIONS_CONTROL_WIDTH,
		order = order + 2,
		hidden = hidden,
		values = ns.BuildCooldownValues(options.cooldowns),
		sorting = options.cooldowns,
		get = options.getCooldown,
		set = options.setCooldown,
	}
end

--[[
    The stand-in names a sample line is rendered with. In the locale because they
    sit inside a sentence whose grammar a translation may want to agree with.
]]
ns.SAMPLE_PLAYER = L["SAMPLE_PLAYER"]
ns.SAMPLE_OTHER = L["SAMPLE_OTHER"]
ns.SAMPLE_PET = L["SAMPLE_PET"]

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
    A sub-option that is a switch plus "whose". Print and Announce are both that,
    and the selector sits beside the toggle rather than under it because it is the
    same sentence: send this to my window, these people's casts.

    A block that answers the question for itself gets no selectors at all. Fears,
    Nova, Parry and Bad Pet are each "somebody did something unhelpful" -- narrowing
    them to your own casts would report that YOU feared the pull, which is not what
    anybody turns them on for. Cold Opener passes noScope from the other end: it
    only ever reports the player's own opener, so there is no whose left to choose.
    Those pass noScope, and a missing scope reads as ALL.
]]
local function ScopedRow(order, hidden, getSettings, opts)
	local row = {
		[opts.key] = {
			type = "toggle",
			name = ns.OptionsSubLabel(L[opts.labelKey]),
			desc = L[opts.descKey],
			width = ns.OPTIONS_SUB_LABEL_WIDTH,
			order = 1,
			get = function()
				return getSettings()[opts.key]
			end,
			set = function(_, value)
				getSettings()[opts.key] = value
			end,
		},
	}

	if opts.showScope then
		row[opts.scopeKey] = {
			type = "select",
			name = "",
			desc = L[opts.scopeDescKey],
			width = ns.OPTIONS_SUB_CONTROL_WIDTH,
			order = 2,
			values = { MINE = L["ALERT_SCOPE_MINE"], ALL = L["ALERT_SCOPE_ALL"] },
			sorting = ns.SCOPES,
			get = function()
				return ns.ResolveChoice(getSettings()[opts.scopeKey], ns.SCOPES, opts.scopeDefault)
			end,
			set = function(_, value)
				getSettings()[opts.scopeKey] = value
			end,
		}
	end

	return ns.OptionsSubRow(order, hidden, row)
end

--[[
    One alert's worth of controls, drawn to the block above. Settings arrive as a
    getter because a profile switch replaces ns.db.profile, so a captured table
    would go stale.

    options:
      headerKey  the block's own gold header, naming the alert
      enableKey  the switch, "Enable <the same name>"
      descKey    one or two sentences between them
      sample     { key, args } naming a real locale format and stand-in arguments.
                 Rendered through ns:BuildAnnounceMessage -- the same call the live
                 alert uses -- so the "Example:" line is what the group would
                 actually see, brand and all, and rewording a message cannot leave
                 a hand-copied example quoting the old text
      control    optional. One widget beside the switch, which narrows the switch
                 to ns.OPTIONS_LABEL_WIDTH so the pair totals a row
      noSound    optional. Draw no sound row -- an alert that fires a handful of
                 times a pull, or once after the fact, does not need one
      noScope    optional. Drop the Mine/All selectors, for a block that is only
                 ever about other people
      extraRow   optional. function(args, order, rowsHidden) for anything the
                 alert owns beyond the standard four. Rows drawn at the section's
                 own indent take `hidden` from the caller's closure, the way a
                 whisper does; rows drawn UNDER the indent take rowsHidden, so
                 they collapse with the rest when the alert is switched off

    Print, sound and announce all cover every cast the GROUP makes -- the add-on
    reports nothing else, which ns:Alert enforces.
]]
function ns.AddAlertSection(args, prefix, getSettings, order, hidden, options)
	-- ns.OptionsSpacer takes no hidden argument, so a gated spacer is its own
	-- description widget. Without it the block's blank lines outlive the controls
	-- they separate and a switched-off feature collapses to a column of empty rows.
	local function Spacer(spacerOrder)
		return { type = "description", name = " ", order = spacerOrder, hidden = hidden }
	end

	local function Prose(text, proseOrder)
		return { type = "description", name = text, fontSize = "medium", order = proseOrder, hidden = hidden }
	end

	-- Hidden when the feature is off, and again when this alert is: a switched-off
	-- block collapses to its header, its description and one line rather than
	-- leaving five dead controls under it. The header, description and sample stay,
	-- because together they are what tells a player whether to switch it back on.
	local rowsHidden = function()
		return hidden() or not getSettings().enabled
	end

	args[prefix .. "HeadSpace"] = Spacer(order)
	args[prefix .. "Head"] = ns.OptionsHeader(L[options.headerKey], order + 1, hidden)
	args[prefix .. "HeadSpaceAfter"] = Spacer(order + 2)
	args[prefix .. "Desc"] = Prose(L[options.descKey], order + 3)
	args[prefix .. "DescSpace"] = Spacer(order + 4)

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

	--[[
	    What the add-on does about this alert, nested under the switch that owns
	    them: indented and captioned in silver, marked twice over so the dependency
	    reads whether the player is scanning shape or color. Widths are sized to
	    their captions with room to spare -- a sub-row control on the wrap boundary
	    tips onto its own line and strands the indent above it, which is why the
	    sound row does not reuse the full-width grid.
	]]
	args[prefix .. "PrintRow"] = ScopedRow(order + 7, rowsHidden, getSettings, {
		key = "print",
		labelKey = "ALERT_PRINT",
		descKey = "ALERT_PRINT_DESC",
		scopeKey = "printScope",
		scopeDescKey = "ALERT_PRINT_SCOPE_DESC",
		scopeDefault = ns.PRINT_SCOPE_DEFAULT,
		showScope = not options.noScope,
	})

	args[prefix .. "AnnounceRow"] = ScopedRow(order + 8, rowsHidden, getSettings, {
		key = "announce",
		labelKey = "ALERT_ANNOUNCE",
		descKey = "ALERT_ANNOUNCE_DESC",
		scopeKey = "announceScope",
		scopeDescKey = "ALERT_ANNOUNCE_SCOPE_DESC",
		scopeDefault = ns.ANNOUNCE_SCOPE_DEFAULT,
		showScope = not options.noScope,
	})

	args[prefix .. "BossOnlyRow"] = ns.OptionsSubRow(order + 9, rowsHidden, {
		bossOnly = {
			type = "toggle",
			name = ns.OptionsSubLabel(L["ALERT_BOSS_ONLY"]),
			desc = L["ALERT_BOSS_ONLY_DESC"],
			width = ns.OPTIONS_SUB_LABEL_WIDTH,
			order = 1,
			get = function()
				return getSettings().bossOnly
			end,
			set = function(_, value)
				getSettings().bossOnly = value
			end,
		},
	})

	--[[
	    Toggle, dropdown, then speaker last. The picker keeps the full sub-option
	    label width so it starts in the same column as the Print and Announce
	    dropdowns above it, and the speaker goes in the margin past the end of the
	    row -- the only place the grid runs wide, and it costs nothing.

	    It still previews regardless of the toggle's state, which is the point of
	    it: hearing a sound BEFORE turning it on is what the button is for.
	]]
	if not options.noSound then
		args[prefix .. "SoundRow"] = ns.OptionsSubRow(order + 10, rowsHidden, {
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

	if options.extraRow then
		options.extraRow(args, order + 12, rowsHidden)
	end

	-- The sample, in helper silver so it reads as an aside rather than as another
	-- setting. It shows the ANNOUNCE form rather than the local print: the print is
	-- the player's own window and costs nothing, while what a section puts in front
	-- of the whole raid is the thing worth seeing before switching it on.
	args[prefix .. "SampleSpace"] = Spacer(order + 15)
	args[prefix .. "Sample"] = {
		type = "description",
		name = ns.OptionsSubLabel(
			string.format(L["SAMPLE_EXAMPLE"], ns:BuildAnnounceMessage(options.sample.key, unpack(options.sample.args)))
		),
		order = order + 16,
		hidden = hidden,
	}
end

--------------------------------------------------------------------------------
-- Spell Toggle Widget
--------------------------------------------------------------------------------

--[[
    A checkbox that shows the spell's own game tooltip on hover, used via
    dialogControl on the ability rows. AceGUI's stock CheckBox fires its OnEnter
    straight at AceConfigDialog, which draws the name-and-desc tooltip and leaves
    no room for the real one, so the row carries its own widget instead. Same
    approach as Magic Eraser's item-link rows: the AceGUI widget the option would
    have used, plus mouse handling that opens a GameTooltip on the thing itself.

    The spell to show arrives in the option's arg field, which AceConfig passes
    through untouched. It is the highest rank this client has, so the tooltip
    reads for the character looking at it rather than for rank 1.
]]
local AceGUI = LibStub("AceGUI-3.0")
local SPELL_TOGGLE_WIDGET_VERSION = 1

local function SpellToggleOnEnter(frame)
	local self = frame.obj
	local option = self:GetUserData("option")
	local spellId = option and option.arg
	if not spellId then
		return
	end
	GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
	GameTooltip:SetHyperlink("spell:" .. spellId)
	GameTooltip:Show()
end

local function SpellToggleOnLeave()
	GameTooltip:Hide()
end

local function SpellToggleOnClick(frame)
	local self = frame.obj
	if self.disabled then
		return
	end
	self.checked = not self.checked
	self:SetValue(self.checked)
	PlaySound(self.checked and 856 or 857) -- checkbox on / off
	self:Fire("OnValueChanged", self.checked)
end

local spellToggleMethods = {}

function spellToggleMethods:OnAcquire()
	self:SetValue(false)
	self:SetDisabled(nil)
	self:SetWidth(200)
	self:SetHeight(24)
end

function spellToggleMethods:OnRelease()
	self.frame:Enable()
end

function spellToggleMethods:SetValue(value)
	self.checked = value and true or false
	if self.checked then
		self.check:Show()
	else
		self.check:Hide()
	end
end

function spellToggleMethods:GetValue()
	return self.checked
end

function spellToggleMethods:SetLabel(text)
	self.text:SetText(text or "")
end

function spellToggleMethods:SetDisabled(disabled)
	self.disabled = disabled
	if disabled then
		self.frame:Disable()
		self.text:SetTextColor(0.5, 0.5, 0.5)
	else
		self.frame:Enable()
		self.text:SetTextColor(1, 1, 1)
	end
end

-- AceConfigDialog drives every toggle through these; this row has no tristate,
-- no inline description, and no image of its own.
function spellToggleMethods:SetTriState() end

function spellToggleMethods:SetDescription() end

function spellToggleMethods:SetImage() end

local function SpellToggleConstructor()
	local frame = CreateFrame("Button", nil, UIParent)
	frame:EnableMouse(true)
	frame:SetHeight(24)
	frame:RegisterForClicks("AnyUp")
	frame:SetScript("OnEnter", SpellToggleOnEnter)
	frame:SetScript("OnLeave", SpellToggleOnLeave)
	frame:SetScript("OnClick", SpellToggleOnClick)

	local checkbg = frame:CreateTexture(nil, "ARTWORK")
	checkbg:SetWidth(24)
	checkbg:SetHeight(24)
	checkbg:SetPoint("TOPLEFT")
	checkbg:SetTexture(130755) -- Interface\Buttons\UI-CheckBox-Up

	local check = frame:CreateTexture(nil, "OVERLAY")
	check:SetAllPoints(checkbg)
	check:SetTexture(130751) -- Interface\Buttons\UI-CheckBox-Check

	local highlight = frame:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetAllPoints(checkbg)
	highlight:SetTexture(130753) -- Interface\Buttons\UI-CheckBox-Highlight
	highlight:SetBlendMode("ADD")

	local text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	text:SetJustifyH("LEFT")
	text:SetPoint("LEFT", checkbg, "RIGHT", 1, 0)
	text:SetPoint("RIGHT")

	local widget = {
		frame = frame,
		checkbg = checkbg,
		check = check,
		highlight = highlight,
		text = text,
		type = ns.SPELL_TOGGLE_WIDGET_TYPE,
	}

	for method, func in pairs(spellToggleMethods) do
		widget[method] = func
	end
	frame.obj = widget

	return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(ns.SPELL_TOGGLE_WIDGET_TYPE, SpellToggleConstructor, SPELL_TOGGLE_WIDGET_VERSION)

--------------------------------------------------------------------------------
-- Ability Toggles
--------------------------------------------------------------------------------

local CLASS_ORDER = {
	"WARRIOR",
	"PALADIN",
	"HUNTER",
	"ROGUE",
	"PRIEST",
	"DEATHKNIGHT",
	"SHAMAN",
	"MAGE",
	"WARLOCK",
	"DRUID",
	"ITEM",
}

-- Pet abilities belong to the pet, not the class, so the heading says so. Built
-- from a format string rather than concatenation, since a locale may not put the
-- qualifier after the class name.
local BUCKET_SUFFIXES = { "", "Pet" }

local function ClassLabel(class, isPet)
	if class == "ITEM" then
		return GetColor("MUTED") .. L["ABILITIES_ITEMS"] .. "|r"
	end
	local name = LOCALIZED_CLASS_NAMES_MALE and LOCALIZED_CLASS_NAMES_MALE[class] or class
	if isPet then
		name = string.format(L["ABILITIES_CLASS_PET"], name)
	end
	local hex = ns.CLASS_COLORS[class]
	if hex then
		return "|cff" .. hex .. name .. "|r"
	end
	return name
end

--[[
    One toggle per ability, reading the groups Features/Combat-Log.lua built. It
    has already dropped what this flavor does not have and what this client's
    spell data does not know, so every group here has a rank to draw. Unchecking a
    row ignores every rank at once, including the ranks this client cannot see, so
    a character who levels or changes flavor keeps the choice they made.

    options:
      categories  -- set of ability categories to draw
      order       -- the first group's order
      hidden      -- predicate hung on every group
      aoe         -- "AOE" or "SINGLE" to draw only that half; nil draws both
      keyPrefix   -- namespaces the returned arg keys, so a panel calling this
                     twice does not have its second set overwrite its first
]]
function ns.BuildAbilityToggles(options)
	local args = {}
	local byClass = {}
	local hidden = options.hidden
	local keyPrefix = options.keyPrefix or "class"
	local filterAoe = options.aoe ~= nil
	local wantAoe = options.aoe == "AOE"

	-- Bucketed by class AND by whether the ability is the class's or its pet's, so
	-- a panel showing both keeps them under separate headings.
	for _, group in ipairs(ns.ABILITY_GROUPS) do
		local isAoe = group.isAoe and true or false
		if options.categories[group.category] and (not filterAoe or isAoe == wantAoe) then
			local bucketKey = group.class .. (group.category == "PET_TAUNT" and "Pet" or "")
			local entries = byClass[bucketKey]
			if not entries then
				entries = {}
				byClass[bucketKey] = entries
			end
			entries[#entries + 1] = group
		end
	end

	local groupOrder = options.order
	for _, class in ipairs(CLASS_ORDER) do
		for _, suffix in ipairs(BUCKET_SUFFIXES) do
			local entries = byClass[class .. suffix]
			if entries then
				table.sort(entries, function(a, b)
					return a.name < b.name
				end)

				local classArgs = {}
				for index, group in ipairs(entries) do
					local label = group.name
					if group.icon then
						label = "|T" .. group.icon .. ":16|t " .. group.name
					end
					local ids = group.ids
					classArgs["ability" .. index] = {
						type = "toggle",
						dialogControl = ns.SPELL_TOGGLE_WIDGET_TYPE,
						name = label,
						-- The widget reads arg to pick the spell whose tooltip it shows.
						arg = group.maxRankId,
						-- One per row. Two columns puts each cell at half the row, which
						-- is not enough for the longest ability names -- "Masterwork
						-- Target Dummy" wrapped onto a second line and left the row
						-- ragged. Sorted by name within the class, so the column reads
						-- alphabetically.
						width = "full",
						order = index,
						get = function()
							local ignored = ns.db.profile.ignoredSpells
							for _, id in ipairs(ids) do
								if ignored[id] then
									return false
								end
							end
							return true
						end,
						set = function(_, value)
							local ignored = ns.db.profile.ignoredSpells
							for _, id in ipairs(ids) do
								if value then
									ignored[id] = nil
								else
									ignored[id] = true
								end
							end
						end,
					}
				end

				args[keyPrefix .. class .. suffix] = {
					type = "group",
					name = ClassLabel(class, suffix == "Pet"),
					inline = true,
					order = groupOrder,
					hidden = hidden,
					args = classArgs,
				}
				groupOrder = groupOrder + 1
			end
		end
	end

	return args
end
