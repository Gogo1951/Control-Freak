local _, ns = ...

local L = ns.L

local function Feature()
	return ns.db.profile.incapacitated
end

local function Section()
	return ns.db.profile.incapacitated.alert
end

-- One second reads as "1 Second"; the ladder starts there, so the singular is real.
local thresholdValues = {}
for _, seconds in ipairs(ns.INCAPACITATED_LONG_THRESHOLDS) do
	local format = seconds == 1 and L["INCAPACITATED_THRESHOLD_ONE"] or L["INCAPACITATED_THRESHOLD"]
	thresholdValues[seconds] = string.format(format, seconds)
end

--[[
    One alert, its own tab, sitting between Fears and Tank Deaths. It is a
    feature rather than a Tanking Tools section because its scope question is
    about the PLAYER's own seat, where the Tanking Tools gate asks "is anybody
    tanking" for four warnings that are all about a mob, and a section cannot
    answer a scope question of its own -- only a feature can.

    It bends the alert block three ways, and the middle one is the interesting
    one:

      No target, because C_LossOfControl names no caster and no mob. Nothing
      takes the freed slot beside the switch, so the switch spans the row on its
      own the way Novas and Fears do.

      SHORT and LONG instead of My and Others'. Every other section splits its
      two rows on whose cast it was; the game reports the player's own losses of
      control and nobody else's, so that question has one answer here and how
      LONG the effect lasts is the one with two. The caption row above them
      names the boundary, and it leads rather than follows because the two rows
      are named after it. ns:Alert is handed the row by name for the same
      reason -- affiliation would pick the same one every time.

      Nine effect boxes, the longest extraRow in the add-on, drawn from
      ns.INCAPACITATED_ROWS so the panel and the defaults read one list.

    No whisper row: the effect is on the player, so the person who would receive
    the note is the person sending it.
]]
function ns.BuildIncapacitatedOptions()
	local args = {}
	local hidden =
		ns.AddFeatureScope(args, Feature, "INCAPACITATED_SUMMARY", "INCAPACITATED_ENABLE", 1, "incapacitated")

	ns.AddWhoseAlertSection(args, "alert", Section, 20, hidden, {
		headerKey = "INCAPACITATED_HEADER",
		enableKey = "INCAPACITATED_ALERT_ENABLE",
		descKey = "INCAPACITATED_DESC",
		noTarget = true,
		rows = {
			{ key = "short", labelKey = "INCAPACITATED_SHORT", descKey = "INCAPACITATED_SHORT_DESC" },
			{ key = "long", labelKey = "INCAPACITATED_LONG", descKey = "INCAPACITATED_LONG_DESC" },
		},
		--[[
		    The dispellable form, which is the shape worth showing: it is the one
		    that names a type, and naming the type is what the alert is for. A fear
		    because it is the one every tank has watched happen, and Magic because
		    a feared tank waiting on a priest is the whole point of the line. An
		    undispellable one drops the brackets and reads shorter.

		    It opens on Tank because the sample has to pick one seat and that is
		    the one the sentence beside it describes; a healer sees Healer there
		    when the line actually fires.
		]]
		sample = {
			key = "INCAPACITATED",
			args = {
				L["INCAPACITATED_ROLE_TANK"],
				string.format(L["INCAPACITATED_SECONDS"], 6),
				ns.SAMPLE_PLAYER,
				ns.SampleSpell(5782, "Fear"),
				L["DISPEL_MAGIC"],
				ns.SampleBoss(),
			},
		},
		--[[
		    Drawn FIRST, above the two rows it names: it is the definition they
		    branch on, not a footnote qualifying them, which is the opposite of
		    Cold Openers' window.
		]]
		captionRowFirst = true,
		captionRow = {
			labelKey = "INCAPACITATED_LONG_CAPTION",
			control = {
				type = "select",
				name = "",
				desc = L["INCAPACITATED_LONG_CAPTION_DESC"],
				width = ns.OPTIONS_SUB_CONTROL_WIDTH,
				values = thresholdValues,
				sorting = ns.INCAPACITATED_LONG_THRESHOLDS,
				get = function()
					return ns.ResolveChoice(
						Section().longThreshold,
						ns.INCAPACITATED_LONG_THRESHOLDS,
						ns.INCAPACITATED_LONG_DEFAULT
					)
				end,
				set = function(_, value)
					Section().longThreshold = value
				end,
			},
		},
		--[[
		    Under the indent because they narrow what counts, like every other
		    extra in the add-on -- there are simply nine of them.

		    Orders step by TENTHS rather than whole numbers: extras start at the
		    caller's +11 and the sound row sits at +14, so nine whole steps would
		    run straight through the sound and the sample.
		]]
		extraRow = function(rowArgs, order, rowsHidden)
			for index, row in ipairs(ns.INCAPACITATED_ROWS) do
				local key, localeSuffix = row[1], row[2]
				rowArgs["effect" .. key] = ns.OptionsSubRow(order + index / 10, rowsHidden, {
					[key] = {
						type = "toggle",
						name = ns.OptionsSubLabel(L["INCAPACITATED_" .. localeSuffix]),
						desc = L["INCAPACITATED_" .. localeSuffix .. "_DESC"],
						width = ns.OPTIONS_SUB_LABEL_WIDTH,
						order = 1,
						get = function()
							return Section().effects[key]
						end,
						set = function(_, value)
							Section().effects[key] = value
						end,
					},
				})
			end
		end,
	})

	--[[
	    No ability list. Every other tab that has one covers a category built from
	    spell ids, and ns.BuildAbilityToggles draws a row per ability with a
	    tooltip per rank. A loss of control has no spell behind it that this
	    add-on tracks: the client hands over an effect TYPE, and the nine boxes
	    inside the block above are what thins that out.
	]]

	return {
		type = "group",
		name = L["TAB_INCAPACITATED"],
		args = args,
	}
end
