local ADDON_NAME, ns = ...

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

--[[
    The installed folder is Control-Freak; the in-Lua identity is the brand. One
    constant carries it everywhere that identity appears -- the locale, the LDB
    object, the LibDBIcon key, the add-on message prefix -- so the pieces cannot
    drift apart. ADDON_NAME stays for anything keyed off the packaged add-on:
    metadata reads, the TOC version token, texture paths.
]]
ns.LOCALE_NAME = "ControlFreak"
ns.L = LibStub("AceLocale-3.0"):GetLocale(ns.LOCALE_NAME)
local L = ns.L

ns.ADDON_MESSAGE_PREFIX = ns.LOCALE_NAME

--------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------

ns.PALETTE = {
	TITLE = "FFD100", -- Gold: Titles, Headers, Section Names, Field Titles
	INFO = "00BBFF", -- Blue: Interactions, Toggles, Links, Keybinds, Slash Commands
	BODY = "FFFFFF", -- White: Descriptions, Options Body Text
	HELP = "CCCCCC", -- Silver: Pro Tips, Helper Text
	TEXT = "FFFFFF", -- White: Messages, Values, Spell Names
	ON = "33CC33", -- Green: On
	OFF = "CC3333", -- Red: Off
	SEPARATOR = "AAAAAA", -- Gray: Separators, Dividers
	MUTED = "808080", -- Dark Gray: Meta-data, Version Numbers
}

ns.CLASS_COLORS = {
	DEATHKNIGHT = "C41E3A",
	DRUID = "FF7C0A",
	HUNTER = "AAD372",
	MAGE = "3FC7EB",
	PALADIN = "F48CBA",
	PRIEST = "FFFFFF",
	ROGUE = "FFF468",
	SHAMAN = "0070DD",
	WARLOCK = "8788EE",
	WARRIOR = "C69B6D",
}

-- The client's own spell-link blue. Not a class color, kept separate.
ns.SPELL_LINK_COLOR = "71D5FF"

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------

ns.OPTIONS_REGISTRY = {
	General = ADDON_NAME .. "_General",
	Apology = ADDON_NAME .. "_Apology", -- TEMPORARY; see Options/Options-Apology.lua
	Taunts = ADDON_NAME .. "_Taunts",
	Interrupts = ADDON_NAME .. "_Interrupts",
	Fears = ADDON_NAME .. "_Fears",
	Incapacitated = ADDON_NAME .. "_Incapacitated",
	TankDeaths = ADDON_NAME .. "_TankDeaths",
	BadPriests = ADDON_NAME .. "_BadPriests",
	BadPets = ADDON_NAME .. "_BadPets",
	TankingTools = ADDON_NAME .. "_TankingTools",
	Profiles = ADDON_NAME .. "_Profiles",
	Diagnostics = ADDON_NAME .. "_Diagnostics",
}

--[[
    Which seat the player has to be in for a feature to fire. A LADDER rather
    than boxes, and that is the whole of the answer on every tab that asks:
    the seats are alternatives, since nobody tanks and heals at once, so a pair
    of switches would spend half its combinations on states that cannot happen
    -- both on reading as "narrowed twice" while it actually widens, and both
    off leaving a question about seats with no seat named.

    ALWAYS is the widest rung and the one every tab but two ships on. It is why
    the ladder can be the same four rungs everywhere -- a tab that does not care
    about the seat picks the rung that says so, rather than the panel dropping
    the control.

    Narrowest first, which is the opposite of ns.TARGET_RUNGS. The target ladder
    reads as a widening scale of enemies; this one reads as a list of seats with
    "any of them" at the end, and the maintainer wrote it in that order.

    ns.ROLE_SCOPE_DEFAULT is read twice -- the fallback for a stored rung this
    version no longer offers, and the blanket shipped default -- so a rung that
    falls off the ladder later widens a tab rather than silencing it.
]]
ns.ROLE_SCOPES = { "TANK", "HEALER", "TANK_HEALER", "ALWAYS" }
ns.ROLE_SCOPE_DEFAULT = "ALWAYS"

--[[
    Which of the scope questions a tab asks.

    Every tab asks which seat and asks where: those two are about the PLAYER, so
    there is no tab they cannot sensibly narrow, and a player who wants one
    feature to themselves and another only in dungeons should not have to find
    out which tabs happen to offer the control. Both ship at their widest, so a
    tab picking them up is exactly as loud as it was before it had them.

    groupHasTank is the one that varies, because it is the only question about
    somebody ELSE. It belongs to the alerts whose subject is a mob that a tank is
    supposed to be holding; Interrupts, Fears and Incapacitated are worth hearing
    whether or not the party has a tank at all.

    Read twice -- Data/Default-Settings.lua builds each feature's scope table from
    this list, and ns.AddFeatureScope draws a control per entry -- so a tab cannot
    end up carrying a setting it never shows, or drawing a control with nothing
    behind it.
]]
ns.FEATURE_SCOPE_OPTIONS = {
	taunts = { "roleScope", "groupHasTank", "instanceOnly" },
	interrupts = { "roleScope", "instanceOnly" },
	fears = { "roleScope", "instanceOnly" },
	incapacitated = { "roleScope", "instanceOnly" },
	--[[
	    No groupHasTank, for the same reason Incapacitated has none: a tank dying
	    is exactly the moment the group stops having one, so gating the news on
	    somebody being alive and tanking would suppress the loudest case it has.
	]]
	tankDeaths = { "roleScope", "instanceOnly" },
	tankingTools = { "roleScope", "groupHasTank", "instanceOnly" },
	badPriests = { "roleScope", "groupHasTank", "instanceOnly" },
	badPets = { "roleScope", "groupHasTank", "instanceOnly" },
}

--[[
    The feature tabs in tab order. Every loop over the features reads this, so a
    new tab cannot be gated in one place and missed in another.

    Tanking Tools sits last, below the two Bad tabs, because it is the one tab
    that ships switched off -- its tools are still in beta -- and a tab nobody
    has opted into does not belong in the middle of the ones that work.
]]
ns.FEATURE_KEYS =
	{ "taunts", "interrupts", "fears", "incapacitated", "tankDeaths", "badPriests", "badPets", "tankingTools" }

--[[
    A label-plus-control row. The label half is wide because it carries the longest
    labels in the add-on, the alert switches ("Enable Alerts for Successful
    Interrupts On"), which sit beside the target ladder and in the longer
    translations fit with little to spare. A label half any narrower clips them
    with an ellipsis, and widening it pushes every paired dropdown right, which
    is the trade: a little dead space beside a short label like "Whisper the Pet
    Owner", in exchange for no clipped text anywhere.

    The two must still total OPTIONS_ROW_WIDTH, and that has to stay inside the
    panel: a pair that overflows does not clip, it wraps the control onto its own
    line and strands the label above it.
]]
ns.OPTIONS_ROW_WIDTH = 3.4
ns.OPTIONS_LABEL_WIDTH = 2.1
ns.OPTIONS_CONTROL_WIDTH = ns.OPTIONS_ROW_WIDTH - ns.OPTIONS_LABEL_WIDTH
ns.OPTIONS_REMOVE_ICON_WIDTH = 0.25 -- the item lists' remove column, sized to its icon
ns.OPTIONS_SUB_INDENT_WIDTH = 0.115 -- the blank cell a sub-option row leads with
ns.OPTIONS_SPEAKER_WIDTH = 0.15 -- the sound-preview speaker, sized to its icon

--[[
    DERIVED, never typed: every dropdown in a block starts in the same column, and
    the only way to keep that true is to compute the sub-option widths from the
    section widths rather than pick numbers that happen to line up today.

    A sub-option row leads with the indent, so its label is a whole indent narrower
    than the section label above it; the two then reach the same x. The control
    beside it is the section's control width, so the rows end together as well.

    The sound row runs one speaker wider than the rest, because the speaker sits
    AFTER its dropdown rather than inside the label. That is the one place the grid
    is allowed past OPTIONS_ROW_WIDTH: an icon in the right margin costs nothing,
    where taking the room out of the label would push the sound dropdown out of
    the column every other dropdown lines up in.
]]
ns.OPTIONS_SUB_LABEL_WIDTH = ns.OPTIONS_LABEL_WIDTH - ns.OPTIONS_SUB_INDENT_WIDTH
ns.OPTIONS_SUB_CONTROL_WIDTH = ns.OPTIONS_CONTROL_WIDTH

--[[
    A sub-option that is a choice rather than a switch -- Cold Openers' "Within"
    -- draws a caption with no box. AceConfig starts a checkbox's caption one
    pixel past a 24-pixel box, and one width unit is AceConfigDialog's 170
    pixels, so a blank cell of 25/170 in front of the caption puts its first
    letter in the same column as the captions beside boxes. The caption gives up
    that much of the sub-label width, so the row still ends where its
    neighbours end.
]]
ns.OPTIONS_SUB_CAPTION_INDENT_WIDTH = 0.15
ns.OPTIONS_SUB_CAPTION_WIDTH = ns.OPTIONS_SUB_LABEL_WIDTH - ns.OPTIONS_SUB_CAPTION_INDENT_WIDTH

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

ns.CHAT_MESSAGE_MAX_LENGTH = 255

--[[
    The columns of Data/Abilities.lua's flavors list, in order. Anything past
    Wrath reads the Wrath column; ns.GetFlavorIndex picks the live one.
]]
ns.FLAVOR_NAMES = { "Era", "SoD", "TBC", "Wrath" }

--[[
    Seconds between Bad Pets alerts for the same pet, whisper included -- the
    player picks one on the Bad Pets tab and BAD_PET_COOLDOWN_DEFAULT is what a
    fresh profile starts on.

    Thirty seconds is the floor because it is roughly a pull: anything shorter
    told the same hunter about the same pet twice in one fight, which is nagging
    rather than informing. Five minutes at the top is for somebody who has already
    been told and is not going to change it tonight. A minute is the shipped
    middle: one reminder per fight rather than one per pull.
]]
ns.BAD_PET_COOLDOWNS = { 30, 60, 300 }
ns.BAD_PET_COOLDOWN_DEFAULT = 60

-- Seconds the whisper election waits for other Control Freak users to bid.
ns.WHISPER_ELECTION_DELAY = 1

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

--[[
    How long after a mob is first seen its opener still counts. A few globals is
    about as long as an opener lasts -- past that a dodge is just a dodge, not a
    cold start -- so the ladder tops out at ten seconds rather than running on into
    the body of the fight. Five is the shipped middle, which is the opening
    exchange and little else.
]]
ns.COLD_OPENER_WINDOWS = { 3, 5, 10 }
ns.COLD_OPENER_WINDOW_DEFAULT = 5

--[[
    Which miss types the opener warning reports, mapped to the line each one
    prints. Full phrases per outcome rather than a verb composed into a sentence:
    word order around a verb differs by language, and a shared template would
    force every locale into English shape.

    ABSORB and REFLECT are deliberately absent -- neither is the target avoiding
    the hit, which is what the warning is about. EVADE is absent too: an evading
    mob is a bug in the world, not a tank standing wrong.
]]
ns.COLD_OPENER_MISS_FORMATS = {
	MISS = "COLD_OPENER_MISS",
	DODGE = "COLD_OPENER_DODGE",
	PARRY = "COLD_OPENER_PARRY",
	BLOCK = "COLD_OPENER_BLOCK",
	IMMUNE = "COLD_OPENER_IMMUNE",
	RESIST = "COLD_OPENER_RESIST",
}

--[[
    The armor debuffs the Armor Debuffs tool waits on, and what each one needs
    before it counts as up.

    The ids are the ones the combat log reports on SPELL_AURA_APPLIED, which is
    usually the casting spell but is not always: Righteous Defense is cast as
    31789 and lands as 31790, and Torment's 11776 and 11777 are effect ids
    rather than castable ranks. Every entry below is a plain self-applied
    debuff, where the two match.

    satisfies is what a component contributes, and it is why Sunder and Expose
    Armor share a value: five Sunders OR one Expose Armor is the same answer to
    the same question, and a group with a rogue should not be told its armor is
    still up.

    requiresClass is the gate that keeps an optional component from stalling the
    report forever. Waiting on Faerie Fire in a group with no druid would mean the
    line never prints, so the wait only applies when somebody could actually cast
    it. The player still has to ask for it with the matching setting.

    Devastate is deliberately absent. It applies the same debuff, but it is a
    Wrath ability and this list is matched against the combat log by id; add its
    ids when the Wrath column is worth supporting.
]]
-- TODO: Add SQL Query
ns.ARMOR_DEBUFFS = {
	{
		key = "sunder",
		satisfies = "ARMOR",
		stacks = 5,
		ids = { 7386, 7405, 8380, 11596, 11597, 25225 },
	},
	{
		key = "expose",
		satisfies = "ARMOR",
		stacks = 1,
		ids = { 8647, 8649, 8650, 11197, 11198, 26866 },
	},
	{
		key = "faerieFire",
		satisfies = "FAERIE_FIRE",
		stacks = 1,
		requiresClass = "DRUID",
		setting = "includeFaerieFire",
		--[[
		    Two names by design, so Validate Data reads a differing name as RENAMED
		    rather than as the typo signal NAME MISMATCH.
		]]
		renamed = true,
		-- Balance ranks first, then the feral ones. Either satisfies it.
		ids = { 770, 778, 9749, 9907, 26993, 16857, 17390, 17391, 17392, 27011 },
	},
	{
		key = "recklessness",
		satisfies = "RECKLESSNESS",
		stacks = 1,
		requiresClass = "WARLOCK",
		setting = "includeRecklessness",
		ids = { 704, 7658, 7659, 11717, 27226 },
	},
}

--[[
    Seconds a culprit stays quiet after a parry warning. Much shorter than the Bad
    Pet ladder, because the two are not the same question: a pet with auto-cast on
    will keep taunting all night whatever you say, while somebody standing in front
    of a boss can fix it in one step and wants telling now.

    Zero is on the ladder and means exactly that -- every parry, no throttle. It
    reads as "No Cooldown" rather than "0 Second Cooldown", and the arithmetic
    falls out on its own: nothing is ever less than zero seconds old.

    Nine, the top of the ladder, is what ships. The setting is stored as the
    whisper's cooldown, but it covers the print, the sound and the announce as
    well, so it is also how often one culprit can set the section off at all.
]]
ns.PARRY_COOLDOWNS = { 0, 3, 6, 9 }
ns.PARRY_COOLDOWN_DEFAULT = 9

--[[
    A shield on a tank who is about to die is the right call, so the Bad Shields
    warning goes quiet below a health line the player picks. Zero is "Always",
    meaning warn at any health; every other value reads as the exception it is,
    "Except Under 30% Health" complaining only while the tank is above 30%.

    Thirty is what ships. Between 30% and half the tank is not in danger yet,
    and the rage they are being denied is part of what keeps them out of it;
    below 30% the shield is a save, and telling somebody off for saving the tank
    is the one case this warning is simply wrong.

    Percentages rather than fractions: the label prints the number, and
    ns.ResolveChoice compares a stored value against this list.
]]
ns.SHIELD_HEALTH_THRESHOLDS = { 0, 50, 40, 30, 10 }
ns.SHIELD_HEALTH_THRESHOLD_DEFAULT = 30

--[[
    Seconds between Bad Shield warnings about the same caster, whisper included.
    The ladder is Bad Pets' -- a shield kept rolling is the same shape of problem
    as a pet left on auto-cast -- but the shipped value is its floor rather than
    its middle: a healer shielding on cooldown repeats the mistake every few
    seconds, and a minute of silence lets most of a pull go by unsaid.
]]
ns.SHIELD_COOLDOWN_DEFAULT = 30

-- The classes that take rage from damage taken, and so lose it to an absorb.
ns.RAGE_TANK_CLASSES = { DRUID = true, WARRIOR = true }

--[[
    The API's word for a loss of control, mapped onto the boxes the Incapacitated
    panel draws. Ported from the reference aura (Loss of Control Announcer,
    wago.io/qhD2-4WN6), which is where the pairings come from.

    A list of keys per locType rather than one key, because two of them answer to
    two boxes. PACIFYSILENCE takes both your attacks and your spells, so it counts
    as either -- a player who asked about silences hears it whether or not they
    also asked about pacifies. The _MECHANIC variants are the same effect arriving
    from a mob's mechanic rather than from a spell, and there is nothing for a
    tank to tell apart between them.

    A locType missing from this table is one the panel offers no box for, and
    Features/Incapacitated.lua reads that as "not wanted": a new
    Blizzard effect type stays quiet until somebody adds a row for it, rather
    than announcing itself under a name nobody chose.
]]
ns.INCAPACITATED_EFFECTS = {
	CHARM = { "charm" },
	POSSESS = { "charm" },
	CONFUSE = { "confuse" },
	DISARM = { "disarm" },
	FEAR = { "fear" },
	FEAR_MECHANIC = { "fear" },
	PACIFY = { "pacify" },
	PACIFYSILENCE = { "pacify", "silence" },
	ROOT = { "root" },
	SCHOOL_INTERRUPT = { "schoolInterrupt" },
	SILENCE = { "silence" },
	STUN = { "stun" },
	STUN_MECHANIC = { "stun" },
}

--[[
    The effect rows, in the order the panel draws them. Read twice --
    Data/Default-Settings.lua seeds a key per entry, Options-Incapacitated.lua
    draws a row per entry -- so a box cannot end up stored without being drawn,
    or drawn with nothing behind it.

    Ordered by what it costs a tank, not alphabetically: the top of the list is
    the mob walking away while you watch, and the two at the bottom are the ones
    that leave a tank their taunt button. All nine ship on.
]]
-- { settings key, locale suffix, ships on }
ns.INCAPACITATED_ROWS = {
	{ "stun", "STUN", true },
	{ "fear", "FEAR", true },
	{ "charm", "CHARM", true },
	{ "confuse", "CONFUSE", true },
	{ "silence", "SILENCE", true },
	{ "pacify", "PACIFY", true },
	{ "schoolInterrupt", "SCHOOL_INTERRUPT", true },
	{ "root", "ROOT", true },
	{ "disarm", "DISARM", true },
}

--[[
    Where a loss of control stops being SHORT and starts being LONG. The section
    draws a row for each, so this is not a filter that throws anything away: it
    decides which of the two rows a line answers to, and each row says where it
    goes. A one-second stun is still worth seeing -- it explains the global you
    just lost -- it is only not worth putting in front of the whole group.

    No zero on this ladder, unlike every other one in the add-on. Zero would mean
    "nothing is ever short", which is not a threshold, it is switching the Short
    row off -- and that row has a box of its own for exactly that.

    Four is what ships. Below it a tank is usually back before anybody could
    have taunted in their place, so the line is for them; at four or more
    somebody else has time to act on it, which is what earns the group's chat.
]]
ns.INCAPACITATED_LONG_THRESHOLDS = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
ns.INCAPACITATED_LONG_DEFAULT = 4

--[[
    The four debuff types somebody in the group can remove, mapped from the word
    the aura API returns to this add-on's own locale suffix. The line names the
    type because that is the half a tank cannot act on alone: "Feared" is news,
    "(Magic)" is an instruction, and it says which of four people in the raid it
    is addressed to.

    A debuff whose dispelName is anything else -- nil, an empty string, "none" --
    cannot be removed by anybody, so the line drops the clause entirely rather
    than printing a word nobody can use. Features/Incapacitated.lua
    picks a different message format for that case.

    Not read from a global: the client has no single table of these, and every
    string the player reads in this add-on comes from Locales/.
]]
ns.DISPEL_TYPES = {
	Magic = "MAGIC",
	Curse = "CURSE",
	Disease = "DISEASE",
	Poison = "POISON",
}

--[[
    Seconds an aura landing on the player stays worth reading back.
    C_LossOfControl says what happened and for how long, but never who did it, so
    the mob's name has to come from the combat log's own SPELL_AURA_APPLIED. The
    two describe the same instant, so anything older than a moment belongs to a
    different event -- the same window and the same reasoning as
    INTERRUPTED_CAST_WINDOW in Features/Interrupts.lua.
]]
ns.INCAPACITATED_AURA_WINDOW = 1

--[[
    Seconds before this section will say anything a second time. Not a setting:
    it only ever collapses the player's own back-to-back losses of control -- a
    stun landing on top of a fear is one moment of not tanking, not two -- and any
    value long enough to be worth a dropdown would start swallowing the next real
    one.
]]
ns.INCAPACITATED_COOLDOWN = 1.5

--------------------------------------------------------------------------------
-- Tank Deaths
--------------------------------------------------------------------------------

--[[
    The classes the Tank Deaths tab lists, which is every class Classic Era and
    Burning Crusade have. No Death Knight: it arrives with Wrath, and a row for a
    class nobody in the group can be is a row that never fires.

    Paladin and Shaman are each faction-locked on Era and both stay listed
    anyway. A panel that changes shape depending on which faction the player
    logged in as is worse than a row that stays quiet -- somebody comparing
    settings with a friend across the faction line would find the list disagreeing
    about how many rows it has.

    Token order here is arbitrary: ns.BuildTankDeathsOptions sorts by the
    client's own localized class name, so the list reads alphabetically in every
    language rather than only in English.
]]
ns.DEATH_CLASSES = {
	"DRUID",
	"HUNTER",
	"MAGE",
	"PALADIN",
	"PRIEST",
	"ROGUE",
	"SHAMAN",
	"WARLOCK",
	"WARRIOR",
}

--[[
    Seconds before the same CLASS is reported dead again, and a constant rather
    than a setting for the reason ns.INCAPACITATED_COOLDOWN is one: it exists to
    stop a wipe reading as a wall of text, not to tune anything. Two mages dying
    a second apart is one moment of the fight going wrong.

    The tank line deliberately has no cooldown at all: every tank death is
    wanted, and collapsing two of them would hide the one that mattered.
]]
ns.DEATH_CLASS_COOLDOWN = 3

--[[
    Every alert section asks the same question the same way: WHOSE cast is the
    row, and WHERE the line goes is the dropdown beside it. A section carries a `mine` row and an
    `others` row, each { enabled, output }, so "announce my own resists and say
    nothing about anybody else's" is one row rather than two switches and two
    scopes that have to be read together.

    PRINT is the player's own window, ANNOUNCE is party or raid chat, and a line
    goes to exactly one of them. Both at once would put the same sentence on
    screen twice, so the pair is not on offer.
]]
ns.ALERT_OUTPUTS = { "PRINT", "ANNOUNCE" }
ns.ALERT_OUTPUT_DEFAULT = "PRINT"

--[[
    Which enemies a section counts, as a threshold rather than a set of
    switches: a section on the second rung fires against the second rung and
    the third, and the first rung is "everything". There is no way to pick
    nothing, which is the point -- a set of independent target boxes could all
    be off, and the alert would go quiet with nothing on screen saying why.

    Widest first; ns.GetEnemyTier returns a mob's position in this ladder and
    ns:Alert compares. BOSS is the skull: the worldboss classification, or the
    "??" level.

    ELITE_0 is the one rung measured against the player, and it is what thins a
    dungeon's trash out from under its bosses. A dungeon boss carries no skull,
    so to the add-on it is an elite -- but it is an elite at or above your
    level, where a good deal of the trash around it sits below.

    Every rung that includes bosses says so in its label. The ladder nests, so
    Elites already covers every boss, and a label reading "Elites" beside a
    separate "Bosses" reads as two disjoint sets when it is not.
]]
ns.TARGET_RUNGS = { "ALL", "ELITE", "ELITE_0", "BOSS" }
ns.TARGET_RUNG_DEFAULT = "ALL"

ns.SOUND_NONE = "None"

--[[
    The game's own Taunt icon (warrior Taunt, spell 355). The mini-map button
    reads as a taunt at a glance, which the add-on art does not. The TOC's
    IconTexture is separate on purpose: that one is the add-on list branding.

    The coords trim the frame the game draws into its stock icons. LibDBIcon
    only insets 5% on its own, which clears the thin frame of an add-on's own
    art but leaves this one showing inside the button's ring, so the icon read
    as undersized next to other buttons.
]]
ns.MINIMAP_ICON = "Interface\\Icons\\Spell_Nature_Reincarnation"
ns.MINIMAP_ICON_COORDS = { 0.05, 0.95, 0.05, 0.95 }

--[[
    Raid target icons, indexed by the raid target index the combat log reports.
    Features/Announcements.lua builds both renderings from these: the |T...|t
    texture escape a local print uses, and the {rtN} token chat needs, since
    neither a texture nor a color survives SendChatMessage.
]]
-- One texture per index, 1-8
ns.RAID_ICONS = {
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_1", -- Star
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_2", -- Circle
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_3", -- Diamond
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_4", -- Triangle
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_5", -- Moon
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_6", -- Square
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_7", -- Cross
	"Interface\\TargetingFrame\\UI-RaidTargetingIcon_8", -- Skull
}

--[[
    The mobs a sample line names. Naxxramas, because every one of them is a name a
    tank recognises, and a real boss reads as a real alert where a stand-in like
    "Boss Name" reads as unfinished UI. The names come from the locale, since each
    client calls these bosses something different.
]]
ns.SAMPLE_BOSSES = {
	L["SAMPLE_BOSS_ANUBREKHAN"],
	L["SAMPLE_BOSS_FAERLINA"],
	L["SAMPLE_BOSS_MAEXXNA"],
	L["SAMPLE_BOSS_NOTH"],
	L["SAMPLE_BOSS_HEIGAN"],
	L["SAMPLE_BOSS_LOATHEB"],
	L["SAMPLE_BOSS_RAZUVIOUS"],
	L["SAMPLE_BOSS_GOTHIK"],
	L["SAMPLE_BOSS_MOGRAINE"],
	L["SAMPLE_BOSS_KORTHAZZ"],
	L["SAMPLE_BOSS_BLAUMEUX"],
	L["SAMPLE_BOSS_ZELIEK"],
	L["SAMPLE_BOSS_PATCHWERK"],
	L["SAMPLE_BOSS_GROBBULUS"],
	L["SAMPLE_BOSS_GLUTH"],
	L["SAMPLE_BOSS_THADDIUS"],
	L["SAMPLE_BOSS_SAPPHIRON"],
	L["SAMPLE_BOSS_KELTHUZAD"],
}

ns.SPELL_TOGGLE_WIDGET_TYPE = ADDON_NAME .. "_SpellToggle"

ns.URL_DISCORD = "https://discord.gg/eh8hKq992Q"
ns.URL_GITHUB = "https://github.com/Gogo1951/Control-Freak"
ns.URL_CURSEFORGE = "https://www.curseforge.com/wow/addons/control-freak"
ns.URL_WAGO = "https://addons.wago.io/addons/control-freak"

--------------------------------------------------------------------------------
-- Sounds
--------------------------------------------------------------------------------

--[[
    The add-on's own sounds, shipped under Includes/Sounds/. Both file and picker
    name say which ALERT the sound was made for, not what it sounds like:
    "Control Freak: Parry" places itself the moment a player reads it, where
    "Control Freak: Sword Clash" left them guessing which alert it belonged to.

    A player is still free to put any of them on any alert, and every sound any
    OTHER add-on registers with LibSharedMedia shows up in the picker alongside
    these -- so nothing here limits the choice.

    A sound can also ship as a SPARE, made for no alert in particular, and that
    is the one case where the name says what it sounds like.

    Which sound an alert PLAYS out of the box is Data/Default-Settings.lua's
    call, not the name's, and the two can part ways: an alert can default to a
    spare, and a sound made for an alert can end up nobody's default. Neither is
    renamed to match -- the last paragraph says why -- so the rows below are
    grouped by what plays out of the box, and the names are left as they are.

    The order here is for whoever is READING this list, not for the player.
    LibSharedMedia sorts on register, so the picker is alphabetical no matter
    what order these rows are in -- which is also why a spare cannot be tucked
    out of the way at the bottom of the picker by putting it at the bottom here.

    Keep them SHORT: one to two seconds. They fire mid-pull on top of everything
    else making noise, and anything longer is still playing when the next one
    starts.

    Every one of them is .ogg, and a new one should be too. PlaySoundFile takes
    .mp3 as well, so a stray one plays and nothing here would catch it -- the
    reason to convert is size, since the same clip as Vorbis is a third to a
    quarter of the mp3, and a sound bank this size is most of what the add-on
    weighs. macOS converts without installing anything:

        afconvert -f Oggf -d vorb cf-thing.mp3 cf-thing.ogg

    Whichever it is, the extension has to match the file on disk.

    Renaming one is a breaking change for anybody who picked it by hand: a profile
    stores the name, and a name this list no longer registers leaves that alert
    silent behind a blank picker.
]]
-- { picker name, file name under Includes/Sounds/ }
ns.SOUNDS = {
	{ "Control Freak: Taunt", "cf-taunt.ogg" },
	{ "Control Freak: AOE Taunt", "cf-aoe-taunt.ogg" },
	{ "Control Freak: Interrupt", "cf-interrupt.ogg" },
	{ "Control Freak: Fear", "cf-fears.ogg" },
	{ "Control Freak: Nova", "cf-nova.ogg" },
	{ "Control Freak: Parry", "cf-parry.ogg" },
	--[[
	    Spares that became defaults, keeping the names they arrived under: a
	    name here is a promise, still what the picker shows after the sound has
	    a job. Failure 4 is Failed Taunts', Magic 2 is Bad Shields', and Game
	    Over is Tank Deaths'.
	]]
	{ "Control Freak: Failure 4", "cf-failure-4.ogg" },
	{ "Control Freak: Magic 2", "cf-magic-2.ogg" },
	{ "Control Freak: Game Over", "cf-game-over.ogg" },
	--[[
	    Nothing from here down plays out of the box. All of it is in the picker,
	    and it is the bank an alert draws from when it gets a sound of its own --
	    until then, what a player reaches for to tell two alerts apart by ear.

	    Taunt Resist and Tank Death were made for Failed Taunts and Tank Deaths,
	    which play spares above instead, and both keep their names: a profile
	    that picked one by hand stores it, and a rename would leave that alert
	    silent behind a blank picker.

	    Failure, Failure 2 and Failure 3 are alternates for Failed Taunts, which
	    plays Failure 4 above. Negative Beeps is what Incapacitated's picker
	    points at, though that alert's sound ships off, so it plays nothing out
	    of the box either.
	]]
	{ "Control Freak: Taunt Resist", "cf-taunt-resist.ogg" },
	{ "Control Freak: Tank Death", "cf-tank-death.ogg" },
	{ "Control Freak: Magic", "cf-magic.ogg" },
	{ "Control Freak: Failure", "cf-failure.ogg" },
	{ "Control Freak: Failure 2", "cf-failure-2.ogg" },
	{ "Control Freak: Failure 3", "cf-failure-3.ogg" },
	{ "Control Freak: Defeat", "cf-defeat.ogg" },
	{ "Control Freak: Negative Beeps", "cf-negative-beeps.ogg" },
	{ "Control Freak: Sad Trumpet", "cf-sad-trumpet.ogg" },
}
