local _, ns = ...

local L = ns.L

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
    the same arrangement Options/Options-Alert-Section.lua gives an alert's
    target ladder, and for
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
	    an alert section makes for its switch.
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
