local _, ns = ...

--[[
    Every feature carries its own scope settings, so each tab answers "when does
    this fire" for itself rather than inheriting one answer from the root panel.
    Which questions a tab asks comes from ns.FEATURE_SCOPE_OPTIONS, so the stored
    keys and the drawn rows cannot drift apart. Each feature then carries one or
    more alert sections, which answer "how loud, and who hears it".
]]
--[[
    A scope question that is a LADDER rather than a switch has no off state, so
    "not narrowed" is not a value it can hold. It ships on its own default
    instead, named here rather than in each feature's block so a tab cannot pick
    up the ladder and forget to store a rung -- which would read as nil, and nil
    is the one thing the gate treats as "this tab does not ask".

    ALWAYS for the role ladder, so a tab that picks it up is as loud as it was
    before it had the control. The two tabs that ship narrower say so in their
    own blocks below, beside the reason.
]]
local SCOPE_DEFAULTS = {
	roleScope = ns.ROLE_SCOPE_DEFAULT,
}

local function FeatureDefaults(scopeKey, sections)
	local feature = { enabled = true }
	for _, option in ipairs(ns.FEATURE_SCOPE_OPTIONS[scopeKey]) do
		feature[option] = SCOPE_DEFAULTS[option] or false
	end
	for key, value in pairs(sections) do
		feature[key] = value
	end
	return feature
end

--[[
    Every alert section is the same block (ns.ALERT_OUTPUTS and ns.TARGET_RUNGS
    in Data/Data.lua): one row for the player's own casts, one for everybody
    else's, each carrying where its line goes, and a target threshold. Both rows
    ship pointing at the player's own window, so a fresh install is close to
    silent in group chat until the player asks for it. The exceptions are the
    sections that announce the player's own line, and each says why where it is
    set. `against` starts at the widest rung unless a section says otherwise.

    alwaysWhenMarked WIDENS a section rather than narrowing it: a target
    carrying a raid mark counts whatever the rung says.

    It ships ON for every targeted section, and what that means differs by
    section. On the ones that ship at Everything it is inert, because Everything
    already passes everything, and it starts mattering the moment a player
    narrows one. On every section that ships narrowed --
    Successful and Failed Taunts, Cold Openers, Armor Debuffs and Parries -- it
    is LIVE from the first pull: a marked mob below the rung reaches the section
    out of the box. That is the override doing its job, and it is also the one
    place it pulls against the reason those sections ship narrowed, so read this
    before changing either.

    A section whose message names no target -- AOE Taunts -- passes noTarget and
    carries neither `against` nor `alwaysWhenMarked`: a filter on a target the
    line does not have is not a setting, and ns:Alert reads a missing pair as
    "nothing to filter".

    An override that names `mine` or `others` replaces the whole row, so pass
    both fields.
]]
local function WhoseAlertDefaults(soundName, overrides, noTarget, rowKeys)
	local alert = {
		enabled = true,
		sound = true,
		soundName = soundName,
	}
	--[[
	    The rows this section carries. Whose cast it was, for all but one: a
	    section may name its own pair instead, and Incapacitated does, splitting
	    on how long the effect lasts because the game only ever reports the
	    player's own. The keys have to match the `rows` the panel draws
	    (ns.AddWhoseAlertSection) and the rowKey the handler hands ns:Alert.
	]]
	for _, key in ipairs(rowKeys or { "mine", "others" }) do
		alert[key] = { enabled = true, output = ns.ALERT_OUTPUT_DEFAULT }
	end
	if not noTarget then
		alert.against = ns.TARGET_RUNG_DEFAULT
		alert.alwaysWhenMarked = true
	end
	for key, value in pairs(overrides or {}) do
		alert[key] = value
	end
	return alert
end

--[[
    One key per row the Incapacitated panel draws, seeded from the same list the
    panel reads (ns.INCAPACITATED_ROWS in Data/Data.lua), so a box cannot ship
    stored-but-undrawn or drawn-but-unstored. Which ones start ticked is written
    beside that list, with the reason.
]]
local function IncapacitatedEffectDefaults()
	local effects = {}
	for _, row in ipairs(ns.INCAPACITATED_ROWS) do
		effects[row[1]] = row[3]
	end
	return effects
end

--[[
    Every class off. The class list is for a player watching one particular
    class, so each row is a deliberate choice rather than something to switch
    back off after the first wipe. Built from ns.DEATH_CLASSES so the stored keys
    and the drawn rows cannot drift apart.
]]
local function DeathClassDefaults()
	local classes = {}
	for _, class in ipairs(ns.DEATH_CLASSES) do
		classes[class] = false
	end
	return classes
end

ns.DATABASE_DEFAULTS = {
	profile = {
		showWelcome = true,
		enabled = true,
		minimap = {}, -- LibDBIcon owns this subtable

		taunts = FeatureDefaults("taunts", {
			--[[
			    A taunt report is a tank's instrument, and a group with nobody
			    tanking has nobody to hand it to. Questing and solo play are where a
			    taunt is just another button, so this is what keeps the add-on quiet
			    everywhere except the content it was written for.
			]]
			groupHasTank = true,

			-- Narrowed to ELITE, the same rung as Failed Taunts below.
			success = WhoseAlertDefaults("Control Freak: Taunt", { against = "ELITE" }),
			--[[
			    The player's own resists go to group chat rather than to their own
			    window. A resisted taunt is the group's problem the moment it lands
			    -- the mob is loose and somebody has to pick it back up -- and the
			    tank staring at their own window is the single person in the raid
			    who already knows. Printing it to them as well is telling them twice.

			    Somebody else's resist prints locally instead: worth knowing, not
			    worth narrating back to the person who just missed.

			    Narrowed to ELITE, the same rung as Successful Taunts, so a taunt
			    on ordinary non-elite trash stays quiet.

			    Plays Failure 4, one of the alternates for the original Taunt
			    Resist sound, rather than the Taunt Resist file named for this
			    alert. Neither name changes to match; Data/Data.lua's sound list
			    says why.
			]]
			failed = WhoseAlertDefaults("Control Freak: Failure 4", {
				mine = { enabled = true, output = "ANNOUNCE" },
				others = { enabled = true, output = ns.ALERT_OUTPUT_DEFAULT },
				against = "ELITE",
			}),
			--[[
			    Names no mob, so no target filters: neither Against nor the mark.
			    The player's own announce for the same reason Failed Taunts does:
			    an AOE taunt is a pack changing hands, which is the group's news.
			]]
			aoe = WhoseAlertDefaults("Control Freak: AOE Taunt", {
				mine = { enabled = true, output = "ANNOUNCE" },
			}, true),
		}),
		interrupts = FeatureDefaults("interrupts", {
			alert = WhoseAlertDefaults("Control Freak: Interrupt"),
		}),
		fears = FeatureDefaults("fears", {
			--[[
			    Drawn like AOE Taunts: a fear is somebody scattering the pull, and
			    which mob it landed on is not what anybody filters by.

			    The player's own announce, like the other two announcing sections.
			    A fear the player cast is the one everybody else in the group needs
			    warning about, and they are the only person who does not.
			]]
			alert = WhoseAlertDefaults("Control Freak: Fear", {
				mine = { enabled = true, output = "ANNOUNCE" },
			}, true),
		}),
		incapacitated = FeatureDefaults("incapacitated", {
			--[[
			    The one tab that narrows the role ladder to the two seats rather
			    than leaving it on ALWAYS, because it is the only alert whose
			    subject is the player: a tank who has been feared and a healer who
			    has been silenced are the two people who need to say so, and a
			    rogue who has been feared is not news. Either seat, since nobody is
			    in both. A player in neither seat hears nothing: in a raid that is
			    anybody not assigned Main Tank and not holding the group finder's
			    Healer role, since the Tank role is ignored there
			    (Features/Utilities.lua says why), and in a party anybody with no
			    group finder role at all. They can pick Always if they want it
			    anyway.

			    Do NOT re-add a groupHasTank default here. This tab does not draw
			    that row (ns.FEATURE_SCOPE_OPTIONS in Data/Data.lua), and
			    ns:IsFeatureGateOpen still reads the key -- so a value set here
			    would gate the feature from a switch nobody can find.
			]]
			roleScope = "TANK_HEALER",

			--[[
			    SHORT and LONG rather than mine and others', the only section in
			    the add-on whose pair is not about whose cast it was. The game
			    reports the player's own losses of control and nobody else's, so
			    affiliation would pick the same row every time; how long the effect
			    lasts is the question that actually has two answers here.

			    That split replaced a minimum-duration filter, and it is a better
			    answer to the same problem. The filter threw the short ones away;
			    this routes them. A one-second stun is still worth SEEING -- it
			    explains the global you just lost -- it is only not worth putting
			    in front of the whole group. So Short prints to the player's own
			    window and Long announces, and the threshold between them is one
			    dropdown rather than a wall the short ones fall off.

			    Long announcing is the fourth alert in the add-on to do so for the
			    reason the other three do: the person reading their own window is
			    the only one in the group who already knows. A stunned tank does
			    not need telling they are stunned.

			    No target keys: C_LossOfControl names no caster and no mob, so
			    there is nothing for a ladder or a raid mark to be about. The mob
			    that DID it is named in the line, but that comes from the combat
			    log rather than from anything a filter could read.

			    Points at Negative Beeps, so ticking Play Sound does something
			    immediately, and ships silent: a tank who has just been feared is
			    watching their character run, and a sound explaining it is news the
			    player already has.
			]]
			alert = WhoseAlertDefaults("Control Freak: Negative Beeps", {
				short = { enabled = true, output = "PRINT" },
				long = { enabled = true, output = "ANNOUNCE" },
				sound = false,
				longThreshold = ns.INCAPACITATED_LONG_DEFAULT,
				effects = IncapacitatedEffectDefaults(),
			}, true, { "short", "long" }),
		}),
		--[[
		    The tank death is an alert section, drawn like Fears: a death names
		    no mob, so noTarget. The class log beside it is a list rather than a
		    section and carries no row, no destination and no sound.

		    Both rows ship PRINTING, so a fresh install keeps tank deaths out of
		    group chat: every Control Freak in the group sees the line in its own
		    window, and a player who wants it announced changes one dropdown. My
		    Death printing is a recorded maintainer decision, so do not switch it
		    back to Announce without asking.

		    All nine class rows ship OFF, and that is the same judgement from the
		    other end: the class list is for somebody watching one particular
		    class, so every row is a deliberate choice. Nine of them on by default
		    would be a running commentary on every wipe.

		    Its sound ships ON, playing Game Over rather than the Tank Death file
		    named for this tab. A sound stays on the client that plays it, so it
		    makes no noise in anybody else's game whatever the rows say.

		    The role ladder stays on ALWAYS. Which seat the DEAD player was in is
		    what the tab is about; which seat the reader is in is a separate
		    question, and a rogue who wants to know the tank is down has as good a
		    reason as the tank's co-tank.
		]]
		tankDeaths = FeatureDefaults("tankDeaths", {
			alert = WhoseAlertDefaults("Control Freak: Game Over", nil, true),
			classes = DeathClassDefaults(),
		}),
		badPriests = FeatureDefaults("badPriests", {
			-- Runs only while the player is tanking and the group has a living tank.
			roleScope = "TANK",
			groupHasTank = true,

			--[[
			    Lands on a friendly tank rather than an enemy, so it carries no
			    target filter at all: noTarget here and in the panel, and the
			    handler passes nil for the guid and the mark. The slot beside the
			    switch that a ladder would occupy holds the health choice instead.

			    selfOnly ships ON. A shield on somebody else's tank is their
			    business, and a mage who installed a taunt add-on should not be
			    told about the priest's healing.

			    Its own feature and its own tab, so the scope questions above it
			    are this alert's own.

			    The whisper ships OFF. Switched on, it goes to whoever cast the
			    shield, and with selfOnly ticked that is only ever somebody who
			    shielded YOU, never a stranger about a third party. Untick selfOnly
			    and the whisper widens with the warning, which is worth knowing
			    before doing it.

			    The cooldown borrows the Bad Pets ladder, because a shield kept
			    rolling is the same shape of problem as a pet left on auto-cast,
			    and ships on the floor of it rather than the middle.

			    The sound is Magic 2, which arrived as a spare and keeps that name
			    now it has an alert of its own; Data/Data.lua's sound list says why.
			]]
			alert = WhoseAlertDefaults("Control Freak: Magic 2", {
				selfOnly = true,
				health = ns.SHIELD_HEALTH_THRESHOLD_DEFAULT,
				whisper = false,
				cooldown = ns.SHIELD_COOLDOWN_DEFAULT,
			}, true),
		}),
		badPets = FeatureDefaults("badPets", {
			--[[
			    A pet on growl only costs anybody anything when there is a tank for
			    it to pull off, so the same gate the Taunts tab uses applies here for
			    the same reason. A hunter soloing with growl up is playing correctly
			    and should never hear about it.
			]]
			groupHasTank = true,

			--[[
			    The one alert with a sound row and no sound of its own to put in it.
			    Drop a cf-bad-pet file in Includes/Sounds/, add it to ns.SOUNDS, and
			    these two values are the whole wiring.
			]]
			alert = WhoseAlertDefaults(ns.SOUND_NONE, { sound = false }),
			whisper = true,
			cooldown = ns.BAD_PET_COOLDOWN_DEFAULT,
		}),
		--[[
		    Every targeted section on this tab ships narrowed: Armor Debuffs and
		    Parries at BOSS, Cold Openers at ELITE_0.
		    All three fire on ordinary combat outcomes rather than on a tracked
		    ability, so left unfiltered they would report every dodge on every mob
		    in the instance -- the reference aura turns the same filter on for the
		    same reason, and says so: "to avoid /s spam it only works against
		    bosses".
		]]
		tankingTools = FeatureDefaults("tankingTools", {
			--[[
			    The tab ships OFF because its tools are still in beta: a player
			    switches Tanking Tools on for themselves. Once on, what keeps it
			    quiet is that every section under it is narrowed, switched off, or
			    gated some other way. Three of the four read ordinary combat
			    outcomes -- a dodge, a parry, a debuff that is merely absent -- and
			    that is a running commentary on the fight rather than news, so none
			    of those runs wide.

			    That switch is the whole opt-in. Everything under it ships the way
			    it should run once a player has chosen Tanking Tools, the parry
			    whisper included, so switching the tab on starts that whisper too
			    rather than asking a second time.
			]]
			enabled = false,

			--[[
			    A tank's instrument: with nobody tanking there is nothing for these
			    warnings to be about, and a solo player gets none of them.
			]]
			groupHasTank = true,

			--[[
			    Ships OFF, the one section here that does. It reports the player's
			    own avoided openers, which is the narrowest thing on the tab and the
			    easiest to read as nagging.

			    Borrows the Parry sound: both are the same news, that somebody is
			    standing where the boss can turn their attack aside.

			    The player's own opener and nobody else's: the handler reports only
			    the player's casts, so the others' row is stored off and never
			    drawn. That one row announces, so switching the section on puts the
			    line in front of the group rather than only the player.
			]]
			coldOpener = WhoseAlertDefaults("Control Freak: Parry", {
				enabled = false,
				against = "ELITE_0",
				mine = { enabled = true, output = "ANNOUNCE" },
				others = { enabled = false, output = ns.ALERT_OUTPUT_DEFAULT },
				window = ns.COLD_OPENER_WINDOW_DEFAULT,
			}),
			--[[
			    Draws no sound row (noSound in Options-Tanking-Tools.lua), so it must
			    ship silent: left on, it would play with no control to stop it.

			    Both extras ship ON, so the report waits for Faerie Fire and Curse of
			    Recklessness as well as the armor itself. Each is ignored unless the
			    group actually has the class for it (ns.GroupHasClass), so the only
			    groups that pay for them are the ones that can supply them.

			    Narrowed to BOSS: a stack-up on trash is not a number anybody reads.

			    No whose: the report is the group's, told to the player, so the
			    handler files every one under the mine row and the others' row is
			    stored off and never drawn.
			]]
			armor = WhoseAlertDefaults(ns.SOUND_NONE, {
				against = "BOSS",
				others = { enabled = false, output = ns.ALERT_OUTPUT_DEFAULT },
				sound = false,
				includeFaerieFire = true,
				includeRecklessness = true,
			}),
			--[[
			    The whisper ships ON, since telling the melee standing in front of
			    the boss is the point of the section, and a player who switched the
			    tab on has already opted in to it. It only goes where the warning
			    itself would -- past the section's switch, its target filters and
			    the ignore rows below -- never to the player or a pet, and once per
			    group however many people in it run Control Freak. The cooldown
			    covers it along with the print, so a culprit who has not moved yet
			    is not whispered every swing.

			    ignoreTanks ships ON: an off-tank in front of the boss is there for a
			    taunt swap, and a warning about it is wrong, not merely noisy.

			    ignorePets ships ON: a pet in front of the boss is where its owner
			    sent it, and a line naming the pet gives nobody in the group anything
			    to do.

			    Narrowed to BOSS: parry haste only matters on something that hits
			    hard enough for the extra swing to count.
			]]
			parry = WhoseAlertDefaults("Control Freak: Parry", {
				against = "BOSS",
				whisper = true,
				whisperCooldown = ns.PARRY_COOLDOWN_DEFAULT,
				ignoreTanks = true,
				ignorePets = true,
			}),
			-- A frost nova is a ring, not a target: drawn like AOE Taunts.
			nova = WhoseAlertDefaults("Control Freak: Nova", nil, true),
		}),

		ignoredSpells = {},
	},
}
