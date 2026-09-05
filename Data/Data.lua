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
	BadPet = ADDON_NAME .. "_BadPet",
	TankingTools = ADDON_NAME .. "_TankingTools",
	Profiles = ADDON_NAME .. "_Profiles",
	Diagnostics = ADDON_NAME .. "_Diagnostics",
}

--[[
    Which of the scope questions a tab asks. Not every feature answers all three.
    A taunt alert is a tank's own instrument, so the Taunts tab asks whether the
    player is tanking; an interrupt is worth hearing whoever is holding the mob,
    so the Interrupts tab asks only where.

    Read twice -- Data/Default-Settings.lua builds each feature's scope table from
    this list, and ns.AddFeatureScope draws a row per entry -- so a tab cannot end
    up carrying a setting it never shows, or drawing a control with nothing behind
    it.
]]
ns.FEATURE_SCOPE_OPTIONS = {
	taunts = { "tankRoleOnly", "groupHasTank", "instanceOnly" },
	interrupts = { "instanceOnly" },
	fears = { "instanceOnly" },
	badPet = { "tankRoleOnly", "groupHasTank", "instanceOnly" },
	tankingTools = { "tankRoleOnly", "groupHasTank", "instanceOnly" },
}

-- The feature tabs in tab order. Every loop over the features reads this, so a
-- new tab cannot be gated in one place and missed in another.
ns.FEATURE_KEYS = { "taunts", "interrupts", "fears", "badPet", "tankingTools" }

--[[
    A label-plus-control row. The label half is wide because it carries the longest
    string in the add-on -- "Enable Successful Interrupt Notifications" -- and at
    the old 1.3 that truncated to "Enable Cold Opener Notific...". Widening it
    pushes every paired dropdown right, which is the trade: a little dead space
    beside a short label like "Whisper Owner", in exchange for no clipped text
    anywhere.

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

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

ns.CHAT_MESSAGE_MAX_LENGTH = 255

-- The columns of Data/Abilities.lua's flavors list, in order. Anything past
-- Wrath reads the Wrath column; ns.GetFlavorIndex picks the live one.
ns.FLAVOR_NAMES = { "Era", "SoD", "TBC", "Wrath" }

-- Seconds a taunt of ours stays claimed for the "Hey That's Mine" check.
ns.TAUNT_STOLEN_WINDOW = 6

--[[
    Seconds between Bad Pet alerts for the same pet, whisper included -- the
    player picks one on the Bad Pet tab and BAD_PET_COOLDOWN_DEFAULT is what a
    fresh profile starts on.

    Thirty seconds is the floor because it is roughly a pull: anything shorter
    told the same hunter about the same pet twice in one fight, which is nagging
    rather than informing. Five minutes at the top is for somebody who has already
    been told and is not going to change it tonight.
]]
ns.BAD_PET_COOLDOWNS = { 30, 60, 300 }
ns.BAD_PET_COOLDOWN_DEFAULT = 30

-- Seconds the whisper election waits for other Control Freak users to bid.
ns.WHISPER_ELECTION_DELAY = 1

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

--[[
    How long after a mob is first seen its opener still counts. A few globals is
    about as long as an opener lasts -- past that a dodge is just a dodge, not a
    cold start -- so the ladder tops out at ten seconds rather than running on into
    the body of the fight.
]]
ns.COLD_OPENER_WINDOWS = { 3, 5, 10 }
ns.COLD_OPENER_WINDOW_DEFAULT = 10

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

    VERIFIED (Wowhead, 2026-09-04): every id below resolves to the ability it is
    filed under -- the Classic ones against the Classic dataset, the five trailing
    TBC ranks (25225, 26866, 26993, 27011, 27226) against the TBC one, where the
    Classic dataset 404s them as it should.

    STILL OPEN, and both matter:
      1. COMPLETENESS. Nothing here proves a rank is not MISSING, and a missing
         rank is silent -- the warrior using it simply never registers. Query 1 of
         Control-Freak-Ability-Verification.sql answers exactly this and all five
         names are now in its list. Take the ranks from an Era source, not the
         Wrath dump, for the reason that file's own caveat gives.
      2. AURA vs CAST id. The matcher below keys on the id the combat log reports
         for SPELL_AURA_APPLIED, which is usually the casting spell but is not
         always: this add-on already carries two counterexamples, Righteous
         Defense (cast 31789, lands as 31790) and Torment (11776/11777 are effect
         ids, not castable ranks). These five are all plain self-applied debuffs
         so the ids should match, but "should" is what wanted checking here.

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
		-- Two names by design, so Validate Data reads a differing name as RENAMED
		-- rather than as the typo signal NAME MISMATCH.
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
]]
ns.PARRY_COOLDOWNS = { 0, 3, 6, 9 }
ns.PARRY_COOLDOWN_DEFAULT = 3

ns.BUBBLE_HEALTH_THRESHOLD = 0.5

--[[
    Whose casts an output covers. MINE is the player and the player's own pet,
    which is exactly the combat log's MINE affiliation; ALL is everyone the add-on
    tracks, which is the group.

    Print and announce each carry their own, and they default differently on
    purpose. Printing lands in the player's own window and costs nobody anything,
    so it starts at ALL; announcing lands in everybody else's, so it starts at MINE
    even though it also ships switched off. Watch the whole group, narrate only
    yourself, is the setup those two defaults describe.
]]
ns.SCOPES = { "MINE", "ALL" }
ns.PRINT_SCOPE_DEFAULT = "ALL"
ns.ANNOUNCE_SCOPE_DEFAULT = "MINE"

ns.SOUND_NONE = "None"

-- The game's own Taunt icon (warrior Taunt, spell 355). The minimap button reads
-- as a taunt at a glance, which the addon art does not. The TOC's IconTexture is
-- separate on purpose: that one is the addon-list branding.
ns.MINIMAP_ICON = "Interface\\Icons\\Spell_Nature_Reincarnation"

--[[
    Raid target icons, indexed by the raid target index the combat log reports.
    Features/Utilities.lua builds both renderings from these: the |T...|t texture
    escape a local print uses, and the {rtN} token chat needs, since neither a
    texture nor a color survives SendChatMessage.
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
    "Boss Name" reads as unfinished UI.

    Data rather than locale: proper nouns the client already translates on its own,
    and a translator who wants them in their own language replaces this table
    wholesale rather than hunting eighteen keys.
]]
ns.SAMPLE_BOSSES = {
	"Anub'Rekhan",
	"Grand Widow Faerlina",
	"Maexxna",
	"Noth the Plaguebringer",
	"Heigan the Unclean",
	"Loatheb",
	"Instructor Razuvious",
	"Gothik the Harvester",
	"Highlord Mograine",
	"Thane Korth'azz",
	"Lady Blaumeux",
	"Sir Zeliek",
	"Patchwerk",
	"Grobbulus",
	"Gluth",
	"Thaddius",
	"Sapphiron",
	"Kel'Thuzad",
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
    name say which ALERT the sound is the default for, not what it sounds like:
    "Control Freak: Parry" places itself the moment a player reads it, where
    "Control Freak: Sword Clash" left them guessing which alert it belonged to.

    A player is still free to put any of them on any alert, and every sound any
    OTHER add-on registers with LibSharedMedia shows up in the picker alongside
    these -- so nothing here limits the choice, it only labels the defaults.

    Keep them SHORT: one to two seconds. They fire mid-pull on top of everything
    else making noise, and anything longer is still playing when the next one
    starts.

    .ogg and .mp3 both play through PlaySoundFile; the extension only has to match
    the file on disk.

    Renaming one is a breaking change for anybody who picked it by hand: a profile
    stores the name, and a name this list no longer registers leaves that alert
    silent behind a blank picker.
]]
-- { picker name, file name under Includes/Sounds/ }
ns.SOUNDS = {
	{ "Control Freak: Taunt", "cf-taunt.ogg" },
	{ "Control Freak: Taunt Resist", "cf-taunt-resist.mp3" },
	{ "Control Freak: AOE Taunt", "cf-aoe-taunt.ogg" },
	{ "Control Freak: Interrupt", "cf-interrupt.ogg" },
	{ "Control Freak: Fear", "cf-fears.mp3" },
	{ "Control Freak: Nova", "cf-nova.ogg" },
	{ "Control Freak: Parry", "cf-parry.mp3" },
}
