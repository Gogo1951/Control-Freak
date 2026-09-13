local _, ns = ...

local L = ns.L

local function Feature()
	return ns.db.profile.tankDeaths
end

local function Section()
	return ns.db.profile.tankDeaths.alert
end

--[[
    The nine classes sorted by the name this client shows, so the list reads
    alphabetically in the player's own language rather than in English -- German
    puts Jäger before Krieger, Spanish puts Brujo near the top. Built once at
    file scope: the class names do not change during a session.
]]
local classRows = {}
for _, class in ipairs(ns.DEATH_CLASSES) do
	classRows[#classRows + 1] = { class = class, name = ns.ClassName(class) }
end
table.sort(classRows, function(a, b)
	return a.name < b.name
end)

--[[
    Class-coloured, and the colour is decoration rather than the label: the row
    beside it says the class in words, because a colour is not readable to
    everybody and two of the nine are close enough to argue about at a glance.
]]
local function ClassLabel(row)
	local hex = ns.CLASS_COLORS[row.class]
	if hex then
		return "|cff" .. hex .. row.name .. "|r"
	end
	return row.name
end

--[[
    One alert and one list, and the split between them is the design:

      Tank Deaths is the ALERT, drawn as the block every other tab draws and
      bent the way Fears is: a death names no mob, so there is no target ladder
      beside the switch and no marked-targets row. It keeps the whose rows,
      because "whose death" has two answers that want different places. The
      tank lying dead is the one person in the group who already knows; the
      people who have to pick the mob up are the ones who do not.

      Deaths by Class is the LOG. Nine rows, no sounds and no destination: a
      watch list somebody keeps for themselves, and nine classes with a sound
      each plays a wipe as a drum solo.

    The class list is plain sub-option rows rather than a section, so it carries
    no switch of its own. The rows ARE the switches, and a header with one box
    under it that only enables more boxes is a step nobody needs.
]]
function ns.BuildTankDeathsOptions()
	local args = {}
	local hidden = ns.AddFeatureScope(args, Feature, "TANK_DEATHS_SUMMARY", "TANK_DEATHS_ENABLE", 1, "tankDeaths")

	--[[
	    Both rows carry tooltips of their own, because the shared pair describes
	    casts and neither row here reports one. The My row ships announcing;
	    Data/Default-Settings.lua says why.

	    The Example names the player, since the line a fresh install actually
	    puts in front of the group is the player's own.
	]]
	ns.AddWhoseAlertSection(args, "alert", Section, 20, hidden, {
		headerKey = "TANK_DEATHS_ALERT_HEADER",
		enableKey = "TANK_DEATHS_ALERT_ENABLE",
		descKey = "TANK_DEATHS_ALERT_DESC",
		mineKey = "TANK_DEATHS_ALERT_MINE",
		mineDescKey = "TANK_DEATHS_ALERT_MINE_DESC",
		othersKey = "TANK_DEATHS_ALERT_OTHERS",
		othersDescKey = "TANK_DEATHS_ALERT_OTHERS_DESC",
		noTarget = true,
		sample = {
			key = "TANK_DEATHS_TANK_LINE",
			args = { ns.SAMPLE_PLAYER },
		},
	})

	--------------------------------------------------------------------------------
	-- Deaths by Class
	--------------------------------------------------------------------------------

	ns.AddGatedHeader(args, "byClass", "TANK_DEATHS_CLASS_HEADER", 40, hidden, true)
	args.byClassDesc = {
		type = "description",
		name = L["TANK_DEATHS_CLASS_DESC"],
		fontSize = "medium",
		order = 43,
		hidden = hidden,
	}
	args.byClassDescSpace = { type = "description", name = " ", order = 44, hidden = hidden }

	--[[
	    Orders step by tenths, the escape hatch Options/Options-Incapacitated.lua's
	    nine effect rows established: nine whole steps from here would run
	    straight through the sample below.
	]]
	for index, row in ipairs(classRows) do
		local class = row.class
		args["class" .. class] = ns.OptionsSubRow(45 + index / 10, hidden, {
			[class] = {
				type = "toggle",
				name = ClassLabel(row),
				desc = string.format(L["TANK_DEATHS_CLASS_ROW_DESC"], row.name),
				width = ns.OPTIONS_SUB_LABEL_WIDTH,
				order = 1,
				get = function()
					return Feature().classes[class]
				end,
				set = function(_, value)
					Feature().classes[class] = value
				end,
			},
		})
	end

	args.classSampleSpace = { type = "description", name = " ", order = 47, hidden = hidden }
	args.classSample = {
		type = "description",
		name = ns.RenderSample({
			key = "TANK_DEATHS_CLASS_LINE",
			args = { ns.ClassName("MAGE"), ns.SAMPLE_OTHER },
		}),
		fontSize = "medium",
		order = 48,
		hidden = hidden,
	}

	return {
		type = "group",
		name = L["TAB_TANK_DEATHS"],
		args = args,
	}
end
