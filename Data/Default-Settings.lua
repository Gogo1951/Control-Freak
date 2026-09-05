local _, ns = ...

--[[
    Every feature carries its own scope settings, so each tab answers "when does
    this fire" for itself rather than inheriting one answer from the root panel.
    Which questions a tab asks comes from ns.FEATURE_SCOPE_OPTIONS, so the stored
    keys and the drawn rows cannot drift apart. Each feature then carries one or
    more alert sections, which answer "how loud, and who hears it".
]]
local function FeatureDefaults(scopeKey, sections)
	local feature = { enabled = true }
	for _, option in ipairs(ns.FEATURE_SCOPE_OPTIONS[scopeKey]) do
		feature[option] = false
	end
	for key, value in pairs(sections) do
		feature[key] = value
	end
	return feature
end

--[[
    Announcing ships OFF for every section but one, so a fresh install is close to
    silent in group chat until the player asks for it. Everything it would say goes
    to their own window instead. The exception is a resisted taunt, and the reason
    it earns one is written where it is set.

    Both scopes are carried by every section, including the five that draw no
    selectors. Storing them costs nothing, and it means a block that later grows a
    selector already has somewhere to put the answer.
]]

local function AlertDefaults(soundName, overrides)
	local alert = {
		enabled = true,
		print = true,
		printScope = ns.PRINT_SCOPE_DEFAULT,
		announce = false,
		announceScope = ns.ANNOUNCE_SCOPE_DEFAULT,
		bossOnly = false,
		sound = true,
		soundName = soundName,
	}
	for key, value in pairs(overrides or {}) do
		alert[key] = value
	end
	return alert
end

ns.DATABASE_DEFAULTS = {
	profile = {
		showWelcome = true,
		enabled = true,
		minimap = {}, -- LibDBIcon owns this subtable

		taunts = FeatureDefaults("taunts", {
			-- A taunt report is a tank's instrument, and a group with nobody
			-- tanking has nobody to hand it to. Questing and solo play are where a
			-- taunt is just another button, so this is what keeps the add-on quiet
			-- everywhere except the content it was written for.
			groupHasTank = true,

			success = AlertDefaults("Control Freak: Taunt"),
			--[[
			    The one section that announces out of the box, and the one that
			    trades its own print away to do it. A resisted taunt is the group's
			    problem the moment it lands -- the mob is loose and somebody has to
			    pick it back up -- and the tank staring at their own window is the
			    single person in the raid who already knows. Printing it to them as
			    well is telling them twice.

			    announceScope stays at its MINE default, so this covers the player's
			    own resists and nobody else's.
			]]
			failed = AlertDefaults("Control Freak: Taunt Resist", { print = false, announce = true }),
			stolen = AlertDefaults(ns.SOUND_NONE),
			aoe = AlertDefaults("Control Freak: AOE Taunt"),
		}),
		interrupts = FeatureDefaults("interrupts", {
			alert = AlertDefaults("Control Freak: Interrupt"),
		}),
		fears = FeatureDefaults("fears", {
			alert = AlertDefaults("Control Freak: Fear"),
		}),
		badPet = FeatureDefaults("badPet", {
			-- A pet on growl only costs anybody anything when there is a tank for
			-- it to pull off, so the same gate the Taunts tab uses applies here for
			-- the same reason. A hunter soloing with growl up is playing correctly
			-- and should never hear about it.
			groupHasTank = true,

			-- The one alert with a sound row and no sound of its own to put in it.
			-- Drop a cf-bad-pet file in Includes/Sounds/, add it to ns.SOUNDS, and
			-- these two values are the whole wiring.
			alert = AlertDefaults(ns.SOUND_NONE, { sound = false }),
			whisper = true,
			cooldown = ns.BAD_PET_COOLDOWN_DEFAULT,
		}),
		--[[
		    Bubble Warnings and Taunt Overwrite Warnings are still being designed and
		    carry no section yet, which ns:Alert reads as nothing to do.

		    Cold Opener and Armor Debuffs ship with the boss filter ON, unlike every
		    other section in the add-on. Both fire on ordinary combat outcomes rather
		    than on a tracked ability, so left unfiltered they would report every
		    dodge on every mob in the instance -- the reference aura turns the same
		    filter on for the same reason, and says so: "to avoid /s spam it only
		    works against bosses".
		]]
		tankingTools = FeatureDefaults("tankingTools", {
			--[[
			    The only feature that ships OFF. Every other tab watches for a
			    discrete ability -- a taunt, an interrupt, a fear -- and says so once
			    when it happens. Three of the four sections here read ordinary combat
			    outcomes instead: a dodge, a parry, a debuff that is merely absent.
			    That is a running commentary on the fight rather than news, and it is
			    not what somebody who installed a taunt add-on is expecting to get.

			    So this tab is opt-in, and the tank who wants it is one switch away.
			    Note what that buys the sections below: settings that would be rude
			    as a default on a tab that ran out of the box -- the parry whisper --
			    are safe here, because nothing under this feature fires until the
			    player has turned it on themselves.
			]]
			enabled = false,

			-- Borrows the Parry sound: both are the same news, that somebody is
			-- standing where the boss can turn their attack aside.
			coldOpener = AlertDefaults("Control Freak: Parry", {
				bossOnly = true,
				window = ns.COLD_OPENER_WINDOW_DEFAULT,
			}),
			-- Draws no sound row (noSound in Options-Tanking-Tools.lua), so it must
			-- ship silent: left on, it would play with no control to stop it.
			-- Both extras ship OFF: a group without a druid or a warlock would never
			-- notice, and a group with one should opt in rather than find its report
			-- quietly waiting on a debuff nobody told it about.
			armor = AlertDefaults(ns.SOUND_NONE, {
				bossOnly = true,
				sound = false,
				includeFaerieFire = false,
				includeRecklessness = false,
			}),
			--[[
			    The whisper ships ON, which is safe here in a way it would not be on
			    a tab that ran by default: nothing under Tanking Tools fires until
			    the tank turns the feature on above, so nobody gets whispered by an
			    add-on they have not opened. Once they have, telling the melee
			    standing in front of the boss is the entire point -- a parry-haste
			    warning the culprit never sees fixes nothing. The cooldown keeps it
			    to one message every few seconds rather than one per swing.
			]]
			parry = AlertDefaults("Control Freak: Parry", {
				whisper = true,
				whisperCooldown = ns.PARRY_COOLDOWN_DEFAULT,
			}),
			nova = AlertDefaults("Control Freak: Nova"),
		}),

		ignoredSpells = {},
	},
}

--[[
    PARKED: "Hey That's Mine" has no place in the redesigned Taunts tab yet, so it
    draws no controls and ships off. Detection still runs in Features/Taunts.lua
    and ns:Alert stops at the enabled flag, so restoring the section is one
    ns.AddAlertSection call and this line.
]]
ns.DATABASE_DEFAULTS.profile.taunts.stolen.enabled = false
