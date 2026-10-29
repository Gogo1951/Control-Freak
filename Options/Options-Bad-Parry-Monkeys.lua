local _, ns = ...

local L = ns.L

local function Feature()
	return ns.db.profile.badParryMonkeys
end

local function Section()
	return ns.db.profile.badParryMonkeys.alert
end

local function Monkey()
	return ns.db.profile.badParryMonkeys.monkey
end

-- The message row: the indent, a caption, the box and the Reset every text input carries, totalling under a row.
local MESSAGE_CAPTION_WIDTH = 0.5
local MESSAGE_RESET_WIDTH = 0.6
local MESSAGE_INPUT_WIDTH = ns.OPTIONS_ROW_WIDTH
	- ns.OPTIONS_SUB_INDENT_WIDTH
	- ns.OPTIONS_SUB_CAPTION_INDENT_WIDTH
	- MESSAGE_CAPTION_WIDTH
	- MESSAGE_RESET_WIDTH
	- 0.1

local function MessageRow(order, rowsHidden)
	return ns.OptionsSubRow(order, rowsHidden, {
		captionIndent = {
			type = "description",
			name = " ",
			width = ns.OPTIONS_SUB_CAPTION_INDENT_WIDTH,
			order = 1,
		},
		caption = {
			type = "description",
			name = ns.OptionsSubLabel(L["BAD_PARRY_MONKEYS_MONKEY_MESSAGE"]),
			fontSize = "medium",
			width = MESSAGE_CAPTION_WIDTH,
			order = 2,
		},
		message = {
			type = "input",
			name = "",
			desc = L["BAD_PARRY_MONKEYS_MONKEY_MESSAGE_DESC"],
			width = MESSAGE_INPUT_WIDTH,
			order = 3,
			get = function()
				return Monkey().message
			end,
			set = function(_, value)
				Monkey().message = value
			end,
		},
		reset = {
			type = "execute",
			name = RESET,
			width = MESSAGE_RESET_WIDTH,
			order = 4,
			disabled = function()
				return Monkey().message == ns.DATABASE_DEFAULTS.profile.badParryMonkeys.monkey.message
			end,
			func = function()
				Monkey().message = ns.DATABASE_DEFAULTS.profile.badParryMonkeys.monkey.message
			end,
		},
	})
end

--[[
    Two sections. Parries is the warning about anybody standing in front of a
    boss, the full block with its two Ignore rows and its whisper. Parry Monkey
    under it is the player owning up to their own, in their own words, with the
    running count; its own switch, row and filters, so the two never overlap.
]]
function ns.BuildBadParryMonkeysOptions()
	local args = {}
	local hidden =
		ns.AddFeatureScope(args, Feature, "BAD_PARRY_MONKEYS_SUMMARY", "BAD_PARRY_MONKEYS_ENABLE", 1, "badParryMonkeys")

	--[[
	    One mob for both examples: the warning the group sees and the whisper its
	    culprit gets describe the same swing.
	]]
	local BOSS = ns.SampleBoss()

	ns.AddWhoseAlertSection(args, "alert", Section, 20, hidden, {
		headerKey = "BAD_PARRY_MONKEYS_ALERT_HEADER",
		enableKey = "BAD_PARRY_MONKEYS_ALERT_ENABLE",
		descKey = "BAD_PARRY_MONKEYS_ALERT_DESC",
		mineKey = "BAD_PARRY_MONKEYS_ALERT_MINE",
		mineDescKey = "BAD_PARRY_MONKEYS_ALERT_MINE_DESC",
		othersKey = "BAD_PARRY_MONKEYS_ALERT_OTHERS",
		othersDescKey = "BAD_PARRY_MONKEYS_ALERT_OTHERS_DESC",
		sample = {
			key = "PARRY_WARNING",
			row = "others",
			args = { ns.SampleOther("ROGUE"), ns.SampleTarget(BOSS) },
		},
		--[[
		    Under the indent because both narrow who counts: an off-tank in front
		    of the boss for a taunt swap is not a mistake to whisper about, and a
		    pet in front of it is where its owner sent it, so the line would name
		    somebody nobody can act on.
		]]
		extraRow = function(rowArgs, order, rowsHidden)
			local extras = {
				{ key = "ignoreTanks", label = "BAD_PARRY_MONKEYS_IGNORE_TANKS" },
				{ key = "ignorePets", label = "BAD_PARRY_MONKEYS_IGNORE_PETS" },
			}
			for index, extra in ipairs(extras) do
				rowArgs["alert" .. extra.key] = ns.OptionsSubRow(order + index, rowsHidden, {
					[extra.key] = {
						type = "toggle",
						name = ns.OptionsSubLabel(L[extra.label]),
						desc = L[extra.label .. "_DESC"],
						width = ns.OPTIONS_SUB_LABEL_WIDTH,
						order = 1,
						get = function()
							return Section()[extra.key]
						end,
						set = function(_, value)
							Section()[extra.key] = value
						end,
					},
				})
			end
		end,
		--[[
		    The whisper goes to the culprit rather than into the player's own window
		    or the group's chat, so it is not one of the alert's outputs: it sits
		    below the block's example with an example of its own.
		]]
		afterSample = function(rowArgs, order, rowsHidden)
			ns.AddWhisperRow(rowArgs, "alert", order, rowsHidden, {
				labelKey = "BAD_PARRY_MONKEYS_WHISPER",
				descKey = "BAD_PARRY_MONKEYS_WHISPER_DESC",
				cooldownDescKey = "BAD_PARRY_MONKEYS_COOLDOWN_DESC",
				cooldowns = ns.PARRY_COOLDOWNS,
				sample = { key = "PARRY_WHISPER", args = { BOSS } },
				getWhisper = function()
					return Section().whisper
				end,
				setWhisper = function(_, value)
					Section().whisper = value
				end,
				getCooldown = function()
					return ns.ResolveChoice(Section().whisperCooldown, ns.PARRY_COOLDOWNS, ns.PARRY_COOLDOWN_DEFAULT)
				end,
				setCooldown = function(_, value)
					Section().whisperCooldown = value
				end,
			})
		end,
	})

	--[[
	    One row, the player's own: nobody else's parry is theirs to confess. Raid
	    bosses only, so noTarget: no ladder beside the switch and no mark row. The
	    message box and the cooldown go under the indent, and the Example reads
	    the message and the live count every time the panel draws, so it shows
	    exactly what the next confession will say.
	]]
	ns.AddWhoseAlertSection(args, "monkey", Monkey, 40, hidden, {
		headerKey = "BAD_PARRY_MONKEYS_MONKEY_HEADER",
		enableKey = "BAD_PARRY_MONKEYS_MONKEY_ENABLE",
		descKey = "BAD_PARRY_MONKEYS_MONKEY_DESC",
		mineKey = "BAD_PARRY_MONKEYS_MONKEY_MINE",
		mineDescKey = "BAD_PARRY_MONKEYS_MONKEY_MINE_DESC",
		noTarget = true,
		noSound = true,
		sample = {
			key = "PARRY_CONFESSION",
			args = function()
				return { ns.GetParryConfession(Monkey()), Monkey().count + 1 }
			end,
		},
		extraRow = function(rowArgs, order, rowsHidden)
			rowArgs.monkeyMessageRow = MessageRow(order + 1, rowsHidden)
			rowArgs.monkeyCooldownRow =
				ns.OptionsSubCaptionRow(order + 2, rowsHidden, L["BAD_PARRY_MONKEYS_MONKEY_COOLDOWN"], {
					type = "select",
					name = "",
					desc = L["BAD_PARRY_MONKEYS_MONKEY_COOLDOWN_DESC"],
					width = ns.OPTIONS_SUB_CONTROL_WIDTH,
					values = ns.BuildCooldownValues(ns.PARRY_MONKEY_COOLDOWNS),
					sorting = ns.PARRY_MONKEY_COOLDOWNS,
					get = function()
						return ns.ResolveChoice(
							Monkey().cooldown,
							ns.PARRY_MONKEY_COOLDOWNS,
							ns.PARRY_MONKEY_COOLDOWN_DEFAULT
						)
					end,
					set = function(_, value)
						Monkey().cooldown = value
					end,
				})
		end,
	})

	return {
		type = "group",
		name = L["TAB_BAD_PARRY_MONKEYS"],
		args = args,
	}
end
