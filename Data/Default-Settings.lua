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
    Every alert section is the same block (ns.ANNOUNCE_SCOPES and
    ns.TARGET_RUNGS in Data/Data.lua): one row for the player's own casts, one
    for everybody else's, each carrying whether it prints and where it is
    announced, and a target threshold. Both rows ship printing and announcing
    nowhere, so a fresh install is close to silent in group chat until the
    player asks for it. The exceptions are the sections that announce the
    player's own line, and each says why where it is set. Most keep print on,
    so the line still reaches the player when there is no group to announce
    to; the player's own Failed Taunts and Fears ship with it off, since the
    player is the one person who already knows.
    `against` starts at the widest rung unless a section says otherwise.

    alwaysWhenMarked WIDENS a section rather than narrowing it: a target
    carrying a raid mark counts whatever the rung says.

    It ships ON for every targeted section but Parries, which ships it off from
    the maintainer's own profile, and what that means differs by section. On the
    ones that ship at Everything it is inert, because Everything already passes
    everything, and it starts mattering the moment a player narrows one. On
    every other section that ships narrowed -- Successful and Failed Taunts, Cold
    Openers and Armor Debuffs -- it is LIVE from the first pull: a marked mob below the rung reaches the section
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
		alert[key] = { print = true, announce = ns.ANNOUNCE_SCOPE_DEFAULT }
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

		-- The General panel's group switches (ns.FEATURE_GROUPS), both on: each feature's own switch decides.
		featureGroups = {
			monitoring = true,
			naughtyList = true,
		},

		taunts = FeatureDefaults("taunts", {
			--[[
			    A taunt report is a tank's instrument, and a group with nobody
			    tanking has nobody to hand it to. Questing and solo play are where a
			    taunt is just another button, so this is what keeps the add-on quiet
			    everywhere except the content it was written for.
			]]
			groupHasTank = true,

			-- Narrowed to ELITE, the same rung as Failed Taunts below.
			success = WhoseAlertDefaults(ns.SOUND_NAMES["Taunt"], { against = "ELITE" }),
			--[[
			    The player's own resists go to group chat rather than to their own
			    window. A resisted taunt is the group's problem the moment it lands
			    -- the mob is loose and somebody has to pick it back up -- and the
			    tank staring at their own window is the single person in the raid
			    who already knows. Printing it to them as well is telling them twice,
			    so the row ships with print off, copied from the maintainer's own
			    profile, and a solo resist says nothing.

			    Somebody else's resist prints locally instead: worth knowing, not
			    worth narrating back to the person who just missed.

			    Narrowed to ELITE, the same rung as Successful Taunts, so a taunt
			    on ordinary non-elite trash stays quiet.

			    Plays Failure 4, one of the alternates for the original Taunt
			    Resist sound, rather than the Taunt Resist file named for this
			    alert. Neither name changes to match; Data/Data.lua's sound list
			    says why.
			]]
			failed = WhoseAlertDefaults(ns.SOUND_NAMES["Failure 4"], {
				mine = { print = false, announce = "GROUP" },
				others = { print = true, announce = ns.ANNOUNCE_SCOPE_DEFAULT },
				against = "ELITE",
			}),
			--[[
			    Names no mob, so no target filters: neither Against nor the mark.
			    The player's own announce for the same reason Failed Taunts does:
			    an AOE taunt is a pack changing hands, which is the group's news.
			]]
			aoe = WhoseAlertDefaults(ns.SOUND_NAMES["AOE Taunt"], {
				mine = { print = true, announce = "GROUP" },
			}, true),
		}),
		interrupts = FeatureDefaults("interrupts", {
			alert = WhoseAlertDefaults(ns.SOUND_NAMES["Interrupt"]),
		}),
		fears = FeatureDefaults("fears", {
			--[[
			    Drawn like AOE Taunts: a fear is somebody scattering the pull, and
			    which mob it landed on is not what anybody filters by.

			    The player's own announce, like every section that sends the player's
			    own line to group chat.
			    A fear the player cast is the one everybody else in the group needs
			    warning about, and they are the only person who does not, so the
			    row ships with print off, copied from the maintainer's own profile.
			]]
			alert = WhoseAlertDefaults(ns.SOUND_NAMES["Fear"], {
				mine = { print = false, announce = "GROUP" },
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

			    A one-second stun is still worth SEEING -- it explains the global
			    you just lost -- it is only not worth putting in front of the
			    whole group. So Short prints to the player's own window and Long
			    announces, and the threshold between them is one dropdown rather
			    than a wall the short ones fall off.

			    Long goes to group chat for the reason every section that sends the
			    player's own line there does: the person reading their own window is
			    the only one in the group who already knows. A stunned tank does
			    not need telling they are stunned.

			    It announces in a party only, the one alert that ships there: in a
			    dungeon that is the whole group, and in a raid it stays out of chat
			    and prints to the player instead. A maintainer decision
			    (2026-10-28), so ask before widening it to raids.

			    No target keys: C_LossOfControl names no caster and no mob, so
			    there is nothing for a ladder or a raid mark to be about. The mob
			    that DID it is named in the line, but that comes from the combat
			    log rather than from anything a filter could read.

			    Points at Negative Beeps, so ticking Play Sound does something
			    immediately, and ships silent: a tank who has just been feared is
			    watching their character run, and a sound explaining it is news the
			    player already has.
			]]
			alert = WhoseAlertDefaults(ns.SOUND_NAMES["Negative Beeps"], {
				short = { print = true, announce = "NEVER" },
				long = { print = true, announce = "PARTY" },
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

		    Its sound ships ON, playing Failure 2 rather than the Tank Death
		    file named for this tab (copied from the maintainer's own profile). A
		    sound stays on the client that plays it, so it makes no noise in
		    anybody else's game whatever the rows say.

		    The role ladder stays on ALWAYS. Which seat the DEAD player was in is
		    what the tab is about; which seat the reader is in is a separate
		    question, and a rogue who wants to know the tank is down has as good a
		    reason as the tank's co-tank.
		]]
		tankDeaths = FeatureDefaults("tankDeaths", {
			alert = WhoseAlertDefaults(ns.SOUND_NAMES["Failure 2"], nil, true),
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

			    The whisper ships ON, copied from the maintainer's own profile. It
			    goes to whoever cast the shield, and with selfOnly ticked that is
			    only ever somebody who shielded YOU, never a stranger about a third
			    party. Untick selfOnly and the whisper
			    widens with the warning, which is worth knowing before doing it.

			    The cooldown borrows the Bad Pets ladder, because a shield kept
			    rolling is the same shape of problem as a pet left on auto-cast,
			    and ships at a minute (ns.SHIELD_COOLDOWN_DEFAULT says why).

			    The sound is Magic 2, which arrived as a spare and keeps that name
			    now it has an alert of its own; Data/Data.lua's sound list says why.
			]]
			alert = WhoseAlertDefaults(ns.SOUND_NAMES["Magic 2"], {
				selfOnly = true,
				health = ns.SHIELD_HEALTH_THRESHOLD_DEFAULT,
				whisper = true,
				cooldown = ns.SHIELD_COOLDOWN_DEFAULT,
			}, true),
		}),
		badMages = FeatureDefaults("badMages", {
			--[[
			    Ships ON like Bad Pets and Bad Priests, copied from the maintainer's
			    own profile.
			]]

			-- A nova only costs anybody anything when there is a tank for it to strand the pull away from.
			groupHasTank = true,

			-- A frost nova is a ring, not a target: drawn like AOE Taunts.
			alert = WhoseAlertDefaults(ns.SOUND_NAMES["Nova"], nil, true),

			--[[
			    The whisper ships OFF, unlike Bad Pets' and Bad Priests', a
			    maintainer decision: a nova is often the right call, so a note to
			    the mage is something a player opts into.
			]]
			whisper = false,
			cooldown = ns.NOVA_COOLDOWN_DEFAULT,
		}),
		--[[
		    Ships ON like the other Bad tabs, copied from the maintainer's own
		    profile.

		    A tank's instrument: with nobody tanking there is nothing for the
		    warning to be about, and a solo player gets none of it.
		]]
		badParryMonkeys = FeatureDefaults("badParryMonkeys", {
			groupHasTank = true,

			--[[
			    The whisper ships OFF, a maintainer decision, so switching the tab
			    on starts the warning and not the note to the culprit. Ticked, it
			    only goes where the warning itself would -- past the section's switch, its target filters and
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
			    hard enough for the extra swing to count. It fires on an ordinary
			    combat outcome rather than a tracked ability, and unfiltered it
			    would report every parry on every mob in the instance.

			    alwaysWhenMarked ships OFF, copied from the maintainer's own
			    profile: a parry from a marked mob below Bosses is still not parry
			    haste anybody needs telling about.
			]]
			alert = WhoseAlertDefaults(ns.SOUND_NAMES["Parry"], {
				against = "BOSS",
				alwaysWhenMarked = false,
				whisper = false,
				whisperCooldown = ns.PARRY_COOLDOWN_DEFAULT,
				ignoreTanks = true,
				ignorePets = true,
			}),

			--[[
			    Parry Monkey, the player owning up to their own parries. Its one
			    row announces to the group, a maintainer decision: a confession
			    printed only to the person making it confesses to nobody. Raid
			    bosses only, a maintainer decision held in the handler, so noTarget
			    here: no ladder and no mark override to store. No sound, since the
			    cooldown keeps it to a line every so often. count is not a setting:
			    it is the running tally the line carries, which goes back to zero
			    on joining a raid group.
			]]
			monkey = WhoseAlertDefaults(ns.SOUND_NONE, {
				mine = { print = true, announce = "GROUP" },
				others = { print = false, announce = ns.ANNOUNCE_SCOPE_DEFAULT },
				sound = false,
				message = ns.L["BAD_PARRY_MONKEYS_MONKEY_MESSAGE_DEFAULT"],
				cooldown = ns.PARRY_MONKEY_COOLDOWN_DEFAULT,
				count = 0,
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
		    Ships the way Thanks for the Buff ran it, where this tab came from: on
		    everywhere, in any seat, printing to the player's own window with the
		    Thunder sound. Saved choices stayed in that add-on's profile, so a
		    player who had tuned it there starts again from these.

		    Names no mob, so noTarget: the line is a classmate and a cooldown,
		    and a target, when it names one, is a friendly player.

		    Both rows ship ON and printing, copied from the maintainer's own
		    profile, so the player's own tracked cooldowns report too. Announce
		    stays on offer for the My row: a tank calling Shield Wall or Last
		    Stand in group chat is the one line here the group can use.

		    Which cooldowns count is the Tracked Abilities page, read from the
		    rows in this flavor's Peer-Pressure-Abilities file, where a row's
		    shipsOff starts it unticked.
		]]
		peerPressure = FeatureDefaults("peerPressure", {
			alert = WhoseAlertDefaults(ns.SOUND_NAMES["Thunder"], nil, true),
		}),
		--[[
		    Every targeted section on this tab ships narrowed: Armor Debuffs at
		    BOSS, Cold Openers at ELITE_0.
		    Both fire on ordinary combat outcomes rather than on a tracked
		    ability, so left unfiltered they would report every dodge on every mob
		    in the instance -- the reference aura turns the same filter on for the
		    same reason, and says so: "to avoid /s spam it only works against
		    bosses".
		]]
		tankingTools = FeatureDefaults("tankingTools", {
			--[[
			    The tab ships OFF because its tools are still in beta: a player
			    switches Tanking Tools on for themselves. Once on, what keeps it
			    quiet is that every section under it is narrowed or switched off.
			    Both read ordinary combat outcomes -- a dodge, a debuff that is
			    merely absent -- and that is a running commentary on the fight
			    rather than news, so neither runs wide.

			    That switch is the whole opt-in. Everything under it ships the way
			    it should run once a player has chosen Tanking Tools.
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
			coldOpener = WhoseAlertDefaults(ns.SOUND_NAMES["Parry"], {
				enabled = false,
				against = "ELITE_0",
				mine = { print = true, announce = "GROUP" },
				others = { print = false, announce = ns.ANNOUNCE_SCOPE_DEFAULT },
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
				others = { print = false, announce = ns.ANNOUNCE_SCOPE_DEFAULT },
				sound = false,
				includeFaerieFire = true,
				includeRecklessness = true,
			}),
		}),

		--[[
		    Keyed by spell id: true unticks a row, and false ticks a row whose
		    data ships it unticked (shipsOff, Peer Pressure's rows only). Empty
		    on purpose, so Reset Profile puts every row back on the data.
		]]
		ignoredSpells = {},

		--[[
		    Single Target or AOE, per taunt, keyed by the entry's first trigger id.
		    Empty on purpose: a taunt nobody has picked for reads its isAoe from
		    this flavor's Data/{Game}/Abilities-{Game}.lua, so Reset Profile puts
		    every row back on the data.
		]]
		tauntKinds = {},
	},
}
