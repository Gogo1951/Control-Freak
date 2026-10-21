local _, ns = ...

local L = ns.L
local GetClientHeader = ns.GetDiagnosticClientHeader

--------------------------------------------------------------------------------
-- API Endpoints
--------------------------------------------------------------------------------

--[[
    Existence and shape checks only: read-only, no side effects, no protected
    calls. One row per API Control Freak actually calls or guards, wherever it
    lives -- nothing incidental, and nothing the add-on does not use. A FAIL on a
    guarded API names the guard that is about to go quiet rather than leaving it
    silent.
]]
ns.DIAGNOSTIC_API_CHECKS = {
	-- { label, testFunction }
	{
		"C_AddOns.GetAddOnMetadata",
		function()
			return type(C_AddOns) == "table" and type(C_AddOns.GetAddOnMetadata) == "function"
		end,
	},
	{
		"C_AddOns.GetAddOnInfo",
		function()
			return type(C_AddOns) == "table" and type(C_AddOns.GetAddOnInfo) == "function"
		end,
	},
	{
		"C_AddOns.GetNumAddOns",
		function()
			return type(C_AddOns) == "table" and type(C_AddOns.GetNumAddOns) == "function"
		end,
	},
	{
		"C_Seasons.GetActiveSeason",
		function()
			return type(C_Seasons) == "table" and type(C_Seasons.GetActiveSeason) == "function"
		end,
	},
	{
		"Enum.SeasonID.SeasonOfDiscovery",
		function()
			return type(Enum) == "table" and type(Enum.SeasonID) == "table" and Enum.SeasonID.SeasonOfDiscovery ~= nil
		end,
	},
	{
		"C_Secrets.ShouldAurasBeSecret (Incapacitated dispel types)",
		function()
			return type(C_Secrets) == "table" and type(C_Secrets.ShouldAurasBeSecret) == "function"
		end,
	},
	{
		"CombatLogGetCurrentEventInfo",
		function()
			return type(CombatLogGetCurrentEventInfo) == "function"
		end,
	},
	{
		"C_EventUtils.IsEventValid",
		function()
			return type(C_EventUtils) == "table" and type(C_EventUtils.IsEventValid) == "function"
		end,
	},
	{
		"C_Spell.GetSpellLink",
		function()
			return type(C_Spell) == "table" and type(C_Spell.GetSpellLink) == "function"
		end,
	},
	{
		"C_Spell.GetSpellInfo",
		function()
			return type(C_Spell) == "table" and type(C_Spell.GetSpellInfo) == "function"
		end,
	},
	{
		"C_Spell.RequestLoadSpellData (Game Names, Validate Data)",
		function()
			return type(C_Spell) == "table" and type(C_Spell.RequestLoadSpellData) == "function"
		end,
	},
	-- Validate Data's spell STATUS: without these every spell row reads NOT ON CLIENT or loses its name.
	{
		"C_Spell.DoesSpellExist (Validate Data)",
		function()
			return type(C_Spell) == "table" and type(C_Spell.DoesSpellExist) == "function"
		end,
	},
	{
		"C_Spell.GetSpellName (Validate Data)",
		function()
			return type(C_Spell) == "table" and type(C_Spell.GetSpellName) == "function"
		end,
	},
	{
		"C_Spell.GetSpellDescription (Validate Data)",
		function()
			return type(C_Spell) == "table" and type(C_Spell.GetSpellDescription) == "function"
		end,
	},
	{
		"C_Spell.IsSpellDataCached (Validate Data)",
		function()
			return type(C_Spell) == "table" and type(C_Spell.IsSpellDataCached) == "function"
		end,
	},
	--[[
	    Validate Data's item reads, for the items the Abilities file's ITEM rows
	    name. One a client lacks leaves its columns blank. The stat read goes
	    through ns.GetItemStats, which takes C_Item.GetItemStats or the legacy
	    global, so the pair is listed as both halves.
	]]
	{
		"C_Item.RequestLoadItemDataByID (Validate Data)",
		function()
			return type(C_Item) == "table" and type(C_Item.RequestLoadItemDataByID) == "function"
		end,
	},
	{
		"C_Item.DoesItemExistByID (Validate Data)",
		function()
			return type(C_Item) == "table" and type(C_Item.DoesItemExistByID) == "function"
		end,
	},
	{
		"C_Item.GetItemInfo (Validate Data)",
		function()
			return type(C_Item) == "table" and type(C_Item.GetItemInfo) == "function"
		end,
	},
	{
		"C_Item.GetItemInfoInstant (Validate Data)",
		function()
			return type(C_Item) == "table" and type(C_Item.GetItemInfoInstant) == "function"
		end,
	},
	{
		"C_Item.GetItemSpell (Validate Data)",
		function()
			return type(C_Item) == "table" and type(C_Item.GetItemSpell) == "function"
		end,
	},
	{
		"C_Item.GetDetailedItemLevelInfo (Validate Data)",
		function()
			return type(C_Item) == "table" and type(C_Item.GetDetailedItemLevelInfo) == "function"
		end,
	},
	{
		"C_Item.GetItemStats (Validate Data)",
		function()
			return type(C_Item) == "table" and type(C_Item.GetItemStats) == "function"
		end,
	},
	{
		"GetItemStats (legacy, Validate Data)",
		function()
			return type(GetItemStats) == "function"
		end,
	},
	{
		"C_Item.GetItemClassInfo (Validate Data)",
		function()
			return type(C_Item) == "table" and type(C_Item.GetItemClassInfo) == "function"
		end,
	},
	{
		"C_Item.GetItemSubClassInfo (Validate Data)",
		function()
			return type(C_Item) == "table" and type(C_Item.GetItemSubClassInfo) == "function"
		end,
	},
	{
		"C_UnitAuras.GetDebuffDataByIndex (Incapacitated dispel types)",
		function()
			return type(C_UnitAuras) == "table" and type(C_UnitAuras.GetDebuffDataByIndex) == "function"
		end,
	},
	{
		"C_LossOfControl (Incapacitated)",
		function()
			return type(C_LossOfControl) == "table"
				and type(C_LossOfControl.GetActiveLossOfControlDataCount) == "function"
				and type(C_LossOfControl.GetActiveLossOfControlData) == "function"
		end,
	},
	{
		"Settings.OpenToCategory",
		function()
			return type(Settings) == "table" and type(Settings.OpenToCategory) == "function"
		end,
	},
	{
		"C_NamePlate.GetNamePlates (Against ladder enemy lookup)",
		function()
			return type(C_NamePlate) == "table" and type(C_NamePlate.GetNamePlates) == "function"
		end,
	},
	{
		"GetPartyAssignment",
		function()
			return type(GetPartyAssignment) == "function"
		end,
	},
	{
		"UnitGroupRolesAssigned (group finder role)",
		function()
			return type(UnitGroupRolesAssigned) == "function"
		end,
	},
	{
		"UnitIsFeignDeath (Tank Deaths feign check)",
		function()
			return type(UnitIsFeignDeath) == "function"
		end,
	},
	{
		"LOCALIZED_CLASS_NAMES_MALE (localized class names)",
		function()
			return type(LOCALIZED_CLASS_NAMES_MALE) == "table"
		end,
	},
	{
		"LOCALIZED_CLASS_NAMES_FEMALE (female class names)",
		function()
			return type(LOCALIZED_CLASS_NAMES_FEMALE) == "table"
		end,
	},
	{
		"LE_PARTY_CATEGORY_INSTANCE (group chat channel)",
		function()
			return type(LE_PARTY_CATEGORY_INSTANCE) == "number"
		end,
	},
	{
		"bit.band (combat log flags)",
		function()
			return type(bit) == "table" and type(bit.band) == "function"
		end,
	},
	{
		"GetPlayerInfoByGUID",
		function()
			return type(GetPlayerInfoByGUID) == "function"
		end,
	},
	{
		"Ambiguate",
		function()
			return type(Ambiguate) == "function"
		end,
	},
	{
		"PlaySoundFile",
		function()
			return type(PlaySoundFile) == "function"
		end,
	},
	{
		"SendChatMessage",
		function()
			return type(SendChatMessage) == "function"
		end,
	},
	{
		"C_ChatInfo.SendAddonMessage",
		function()
			return type(C_ChatInfo) == "table" and type(C_ChatInfo.SendAddonMessage) == "function"
		end,
	},
	{
		"C_ChatInfo.RegisterAddonMessagePrefix",
		function()
			return type(C_ChatInfo) == "table" and type(C_ChatInfo.RegisterAddonMessagePrefix) == "function"
		end,
	},
	{
		"C_ChatInfo.IsAddonMessagePrefixRegistered",
		function()
			return type(C_ChatInfo) == "table" and type(C_ChatInfo.IsAddonMessagePrefixRegistered) == "function"
		end,
	},
	{
		"C_Timer.After",
		function()
			return type(C_Timer) == "table" and type(C_Timer.After) == "function"
		end,
	},
	{
		"C_TooltipInfo.GetItemByID and GetSpellByID (tooltip text, modern path)",
		function()
			return type(C_TooltipInfo) == "table"
				and type(C_TooltipInfo.GetItemByID) == "function"
				and type(C_TooltipInfo.GetSpellByID) == "function"
		end,
	},
	{
		"GameTooltip:SetHyperlink (tooltip text, scan-tooltip path)",
		function()
			return type(GameTooltip) == "table" and type(GameTooltip.SetHyperlink) == "function"
		end,
	},
	{
		"LibSharedMedia-3.0",
		function()
			return LibStub("LibSharedMedia-3.0") ~= nil
		end,
	},
	{
		"LibDataBroker-1.1",
		function()
			return LibStub("LibDataBroker-1.1") ~= nil
		end,
	},
	{
		"LibDBIcon-1.0",
		function()
			return LibStub("LibDBIcon-1.0") ~= nil
		end,
	},
	{
		"Combat log affiliation and type constants",
		function()
			return type(COMBATLOG_OBJECT_AFFILIATION_MASK) == "number"
				and type(COMBATLOG_OBJECT_AFFILIATION_MINE) == "number"
				and type(COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) == "number"
				and type(COMBATLOG_OBJECT_REACTION_FRIENDLY) == "number"
				and type(COMBATLOG_OBJECT_CONTROL_PLAYER) == "number"
				and type(COMBATLOG_OBJECT_TYPE_PLAYER) == "number"
				and type(COMBATLOG_OBJECT_TYPE_PET) == "number"
				and type(COMBATLOG_OBJECT_TYPE_GUARDIAN) == "number"
		end,
	},
	{
		"Combat log raid target constants (raid marks)",
		function()
			if type(COMBATLOG_OBJECT_RAIDTARGET_MASK) ~= "number" then
				return false
			end
			for index = 1, 8 do
				if type(_G["COMBATLOG_OBJECT_RAIDTARGET" .. index]) ~= "number" then
					return false
				end
			end
			return true
		end,
	},
}

--------------------------------------------------------------------------------
-- Alert Context
--------------------------------------------------------------------------------

--[[
    The add-on's own example reports. The privacy note its chat capture needs is
    the shared EVENT_LOG_PRIVACY line beneath the box.
]]
ns.DiagnosticsStrings.EVENT_LOG_EXAMPLES = "Best for 'it never fires' reports. The raw combat log, other add-ons' messages and other units' interrupted casts are left out; the ones "
	.. ns.ADDON_TITLE
	.. " acted on are written in as they happen."

--[[
    Where an announced line or a whisper can go right now. ns:Alert skips group
    chat in a battleground or arena, and with no group channel an announced line
    goes nowhere. A whisper election that never hears the other clients' bids,
    because the prefix did not register, sends one whisper per Control Freak
    user rather than one in all.
]]
local function AppendAnnounceContext(lines)
	local _, instanceType = IsInInstance()
	lines[#lines + 1] = ""
	lines[#lines + 1] = string.format(
		"ns:GetGroupChatChannel() = %s (instance type %s%s)",
		tostring(ns:GetGroupChatChannel()),
		tostring(instanceType),
		(instanceType == "pvp" or instanceType == "arena") and ", announcing is skipped here" or ""
	)
	lines[#lines + 1] = string.format(
		"Add-on message prefix %s registered = %s",
		ns.ADDON_MESSAGE_PREFIX,
		tostring(C_ChatInfo.IsAddonMessagePrefixRegistered(ns.ADDON_MESSAGE_PREFIX))
	)
end

--[[
    Every alert section on every tab, found by the rows it carries rather than
    listed by name, so a new section shows up here without an edit: its switch,
    each row's switch and resolved destination, its target filters, its sound,
    and then every other setting it stores -- a health floor, a whisper, a
    cooldown, the Incapacitated effect boxes -- since any of them can keep a
    line quiet. A sound whose stored name LibSharedMedia no longer knows plays
    nothing, behind a blank picker. A feature's own settings beyond its scope
    questions (Bad Pets' whisper, the Tank Deaths class rows) print on a line of
    their own.
]]
local SECTION_ROW_KEYS = { "mine", "others", "short", "long" }

-- Printed by SectionLine in a fixed order, so the catch-all below skips them.
local SECTION_SHOWN_KEYS = {
	enabled = true,
	against = true,
	alwaysWhenMarked = true,
	sound = true,
	soundName = true,
}
for _, rowKey in ipairs(SECTION_ROW_KEYS) do
	SECTION_SHOWN_KEYS[rowKey] = true
end

local function SortedKeys(value)
	local keys = {}
	for key in pairs(value) do
		keys[#keys + 1] = key
	end
	table.sort(keys, function(a, b)
		return tostring(a) < tostring(b)
	end)
	return keys
end

-- One level of a settings table on one line; anything deeper reads as {...}.
local function SettingText(value)
	if type(value) ~= "table" then
		return tostring(value)
	end
	local parts = {}
	for _, key in ipairs(SortedKeys(value)) do
		local entry = value[key]
		parts[#parts + 1] = tostring(key) .. "=" .. (type(entry) == "table" and "{...}" or tostring(entry))
	end
	return "{" .. table.concat(parts, ",") .. "}"
end

-- Every key in settings that skip does not claim, as key=value.
local function OtherSettings(settings, skip)
	local parts = {}
	for _, key in ipairs(SortedKeys(settings)) do
		if not skip[key] then
			parts[#parts + 1] = tostring(key) .. "=" .. SettingText(settings[key])
		end
	end
	return parts
end

local function SoundText(section)
	if section.sound == nil then
		return nil
	end
	if not section.sound then
		return "sound=off"
	end
	local name = section.soundName
	if name == nil or name == "" or name == ns.SOUND_NONE then
		return "sound=on name=" .. tostring(name) .. " (plays nothing)"
	end
	local resolves = LibStub("LibSharedMedia-3.0"):Fetch("sound", name, true) ~= nil
	return string.format("sound=on name=%s resolves=%s", name, tostring(resolves))
end

local function SectionLine(featureKey, sectionKey, section)
	local rows = {}
	for _, rowKey in ipairs(SECTION_ROW_KEYS) do
		local row = section[rowKey]
		if type(row) == "table" then
			rows[#rows + 1] = string.format(
				"%s=%s/%s",
				rowKey,
				tostring(row.enabled),
				ns.ResolveChoice(row.output, ns.ALERT_OUTPUTS, ns.ALERT_OUTPUT_DEFAULT)
			)
		end
	end
	if #rows == 0 then
		return nil
	end
	local parts = { featureKey .. "." .. sectionKey .. ":", "enabled=" .. tostring(section.enabled) }
	parts[#parts + 1] = table.concat(rows, " ")
	if section.against ~= nil then
		parts[#parts + 1] = "against=" .. tostring(section.against)
		parts[#parts + 1] = "alwaysWhenMarked=" .. tostring(section.alwaysWhenMarked)
	end
	parts[#parts + 1] = SoundText(section)
	for _, part in ipairs(OtherSettings(section, SECTION_SHOWN_KEYS)) do
		parts[#parts + 1] = part
	end
	return table.concat(parts, " ")
end

local function IsSection(value)
	if type(value) ~= "table" then
		return false
	end
	for _, rowKey in ipairs(SECTION_ROW_KEYS) do
		if type(value[rowKey]) == "table" then
			return true
		end
	end
	return false
end

local function AppendSectionLines(lines, profile)
	lines[#lines + 1] = ""
	lines[#lines + 1] = "Alert sections (row=enabled/output):"
	for _, featureKey in ipairs(ns.FEATURE_KEYS) do
		local feature = profile[featureKey]
		if type(feature) == "table" then
			-- The scope questions and the switch print in the gate block above.
			local skip = { enabled = true }
			for _, option in ipairs(ns.FEATURE_SCOPE_OPTIONS[featureKey] or {}) do
				skip[option] = true
			end
			local sectionKeys = {}
			for key, value in pairs(feature) do
				if IsSection(value) then
					sectionKeys[#sectionKeys + 1] = key
					skip[key] = true
				end
			end
			table.sort(sectionKeys)
			local extras = OtherSettings(feature, skip)
			if #extras > 0 then
				lines[#lines + 1] = featureKey .. ": " .. table.concat(extras, " ")
			end
			for _, key in ipairs(sectionKeys) do
				lines[#lines + 1] = SectionLine(featureKey, key, feature[key])
			end
		end
	end
end

-- Every alert plays on the Master channel, so these two decide whether any sound is heard at all.
local function AppendSoundContext(lines)
	lines[#lines + 1] = ""
	lines[#lines + 1] = string.format("Sound_EnableAllSound CVar = %s", tostring(GetCVar("Sound_EnableAllSound")))
	lines[#lines + 1] = string.format("Sound_MasterVolume CVar = %s", tostring(GetCVar("Sound_MasterVolume")))
	lines[#lines + 1] =
		string.format("LibSharedMedia sounds available = %d", #LibStub("LibSharedMedia-3.0"):List("sound"))
end

--[[
    What the ability rows hold on this client: the folder they came from, how
    many of its entries this client's spell data answered for, how many rows
    each tab drew and which of those it has unticked (a tab with no rows can
    never fire here), and how every taunt that can go either way is being
    reported. Incapacitated rides along because its trigger is not an ability
    at all: a client without the loss-of-control pair keeps that tab silent, and
    an effect the panel offers no box for is dropped, so whatever is on the
    player right now prints with the boxes it maps to.
]]
local function AppendAbilityContext(lines)
	lines[#lines + 1] = ""
	lines[#lines + 1] = string.format(
		"Ability rows: %d drawn of %d entries in Data/%s (ns.ABILITY_GROUPS)",
		#ns.ABILITY_GROUPS,
		#ns.ABILITIES,
		tostring(ns.DATA_FOLDER)
	)

	local drawn, ignored = {}, {}
	for _, group in ipairs(ns.ABILITY_GROUPS) do
		local featureKey = ns.CATEGORY_FEATURE[group.category]
		drawn[featureKey] = (drawn[featureKey] or 0) + 1
		ignored[featureKey] = (ignored[featureKey] or 0) + (ns.IsAbilityIgnored(group.entry) and 1 or 0)
	end
	local counts = {}
	for _, featureKey in pairs(ns.CATEGORY_FEATURE) do
		if not drawn[featureKey] then
			drawn[featureKey], ignored[featureKey] = 0, 0
		end
	end
	for _, featureKey in ipairs(ns.FEATURE_KEYS) do
		if drawn[featureKey] then
			counts[#counts + 1] = string.format("%s=%d/%d", featureKey, drawn[featureKey], ignored[featureKey])
		end
	end
	lines[#lines + 1] = "Ability rows per tab (drawn/ignored): " .. table.concat(counts, " ")

	-- By name, since an unticked row is the commonest reason one ability never fires while its tab does.
	local ignoredNames = {}
	for _, group in ipairs(ns.ABILITY_GROUPS) do
		if ns.IsAbilityIgnored(group.entry) then
			ignoredNames[#ignoredNames + 1] =
				string.format("%s %s (%d)", ns.CATEGORY_FEATURE[group.category], tostring(group.name), group.maxRankId)
		end
	end
	lines[#lines + 1] = "Unticked ability rows: " .. (#ignoredNames > 0 and table.concat(ignoredNames, ", ") or "none")

	for _, group in ipairs(ns.ABILITY_GROUPS) do
		if group.entry.kindChoice then
			lines[#lines + 1] = string.format(
				"Taunt kind for %s (%d) = %s",
				tostring(group.name),
				group.maxRankId,
				ns.GetTauntKind(group.entry)
			)
		end
	end

	local hasLossOfControl = type(C_LossOfControl) == "table"
		and type(C_LossOfControl.GetActiveLossOfControlDataCount) == "function"
		and type(C_LossOfControl.GetActiveLossOfControlData) == "function"
	lines[#lines + 1] = string.format("C_LossOfControl pair present (Incapacitated) = %s", tostring(hasLossOfControl))
	if hasLossOfControl then
		local count = C_LossOfControl.GetActiveLossOfControlDataCount() or 0
		lines[#lines + 1] = string.format("Active losses of control = %d", count)
		for index = 1, count do
			local data = C_LossOfControl.GetActiveLossOfControlData(index)
			if data then
				local boxes = data.locType and ns.INCAPACITATED_EFFECTS[data.locType]
				lines[#lines + 1] = string.format(
					"  locType=%s spellID=%s duration=%s timeRemaining=%s -> boxes %s",
					tostring(data.locType),
					tostring(data.spellID),
					tostring(data.duration),
					tostring(data.timeRemaining),
					boxes and table.concat(boxes, ",") or "none (dropped)"
				)
			end
		end
	end
end

--[[
    Armor Debuffs waits on each extra only when its box is ticked AND somebody in
    the group could cast it, so a report that never prints is usually an extra
    still being waited on. Prints both halves for each one.
]]
local function AppendArmorContext(lines, profile)
	local armor = profile.tankingTools and profile.tankingTools.armor
	if type(armor) ~= "table" then
		return
	end
	lines[#lines + 1] = ""
	for _, debuff in ipairs(ns.ARMOR_DEBUFFS or {}) do
		if debuff.setting then
			lines[#lines + 1] = string.format(
				"Armor extra %s: %s=%s, ns.GroupHasClass(%s)=%s, %d stack(s) needed",
				tostring(debuff.key),
				debuff.setting,
				tostring(armor[debuff.setting]),
				tostring(debuff.requiresClass),
				tostring(ns.GroupHasClass(debuff.requiresClass)),
				debuff.stacks or 0
			)
		end
	end
end

--[[
    Control Freak's own context probe, and the first thing to read on a "nothing
    ever fires" report. Scope is per feature, so after the active profile and
    its two top-level switches this prints each feature's own scope settings,
    only the questions its tab asks, and the resulting verdict, then the
    player's own seat and the live world state they were measured against --
    the target's rung and who the combat log last saw it swinging at included
    -- and whether COMBAT_LOG_EVENT_UNFILTERED is actually on the frame.
    The tanks ride along because the role dropdown's tank rungs and When Group
    Has a Tank both read them, and a tab narrowed by either goes silent without
    one. Then where a line can go, every alert section's settings, the armor
    extras still being waited on, the game's own sound switches, and what the
    ability rows and any loss of control hold. All reads.
]]
function ns:BuildAlertContextReport()
	local lines = { GetClientHeader(), "" }
	local profile = ns.db and ns.db.profile

	if not profile then
		lines[#lines + 1] = "ns.db is not initialized."
		return table.concat(lines, "\n")
	end

	local inInstance, instanceType = IsInInstance()
	-- Every setting below is this profile's, so a character on the wrong one reads as settings that never took.
	lines[#lines + 1] = string.format("profile = %s", tostring(ns.db:GetCurrentProfile()))
	lines[#lines + 1] = string.format("enabled (all alerts) = %s", tostring(profile.enabled))
	lines[#lines + 1] = string.format("showWelcome (login line) = %s", tostring(profile.showWelcome))
	lines[#lines + 1] = ""
	for _, key in ipairs(ns.FEATURE_KEYS) do
		local feature = profile[key]
		if type(feature) ~= "table" then
			lines[#lines + 1] = string.format("%s: missing from the profile", key)
		else
			--[[
			    Only the scope questions this feature actually asks, in the order its
			    tab draws them. A key printed for a tab that never shows it reads as
			    a setting the player could not find.
			]]
			local scope = {}
			for _, option in ipairs(ns.FEATURE_SCOPE_OPTIONS[key]) do
				scope[#scope + 1] = option .. "=" .. tostring(feature[option])
			end
			lines[#lines + 1] = string.format(
				"%s: enabled=%s %s -> IsFeatureGateOpen=%s",
				key,
				tostring(feature.enabled),
				table.concat(scope, " "),
				tostring(ns:IsFeatureGateOpen(feature))
			)
		end
	end
	lines[#lines + 1] = ""

	--[[
	    The player's own seat, which every role dropdown reads: the Healer rungs
	    count only the group finder's Healer role, and Incapacitated opens its
	    line on it. The level is what the Elites Your Level+ rung compares a mob
	    against, and ns.playerGUID is what tells the player's own casts, deaths
	    and whisper bids from everybody else's.
	]]
	local _, playerClass = UnitClass("player")
	lines[#lines + 1] = string.format(
		"player = %s level %s, ns.playerGUID matches = %s",
		tostring(playerClass),
		tostring(UnitLevel("player")),
		tostring(ns.playerGUID ~= nil and ns.playerGUID == UnitGUID("player"))
	)
	lines[#lines + 1] = string.format(
		"ns.IsPlayerTank() = %s, ns.IsPlayerHealer() = %s, UnitGroupRolesAssigned(player) = %s",
		tostring(ns.IsPlayerTank()),
		tostring(ns.IsPlayerHealer()),
		tostring(type(UnitGroupRolesAssigned) == "function" and UnitGroupRolesAssigned("player") or nil)
	)
	lines[#lines + 1] = string.format("IsInGroup() = %s", tostring(IsInGroup()))
	lines[#lines + 1] = string.format("IsInRaid() = %s", tostring(IsInRaid()))
	lines[#lines + 1] = string.format("IsInInstance() = %s, %s", tostring(inInstance), tostring(instanceType))
	lines[#lines + 1] = ""

	--[[
	    The player's current target on the Against ladder, which is the cheapest way
	    to see which rung a given mob lands on before a section is set to it. A mob
	    nobody targets is classified off its name plate, so with no plates on
	    screen it goes unanswered and passes every rung.
	]]
	if type(C_NamePlate) == "table" and type(C_NamePlate.GetNamePlates) == "function" then
		lines[#lines + 1] = string.format("Name plates on screen = %d", #C_NamePlate.GetNamePlates())
	end
	if UnitExists("target") then
		local targetGUID = UnitGUID("target")
		local tier = ns.GetEnemyTier(targetGUID)
		lines[#lines + 1] = string.format(
			"target = %s (%s, level %s) -> Against rung %s",
			tostring(GetUnitName("target")),
			tostring(UnitClassification("target")),
			tostring(UnitLevel("target")),
			tier and ns.TARGET_RUNGS[tier] or "nil (not an enemy, or unanswerable)"
		)
		--[[
		    Who the combat log last saw the target swing at. Your taunt on a mob
		    already on you is a refresh and stays quiet, a parry on a mob with
		    nobody on record stays quiet, and your cold opener on a mob on somebody
		    else stays quiet.
		]]
		local holder = "nobody yet"
		if ns.EnemyWasAlreadyOn(targetGUID, ns.playerGUID) then
			holder = "you"
		elseif ns.EnemyIsOnSomeoneElse(targetGUID, ns.playerGUID) then
			holder = "somebody else"
		end
		lines[#lines + 1] = "Target last seen swinging at (combat log) = " .. holder
	else
		lines[#lines + 1] = "target = none"
	end
	lines[#lines + 1] = ""
	lines[#lines + 1] = string.format("ns:IsAlertGateOpen() = %s", tostring(ns:IsAlertGateOpen()))
	lines[#lines + 1] = string.format(
		"COMBAT_LOG_EVENT_UNFILTERED registered = %s",
		tostring(ns.eventFrame:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED") and true or false)
	)

	-- Secret auras, where this client has them, are why an Incapacitated line drops its dispel type.
	if type(C_Secrets) == "table" and type(C_Secrets.ShouldAurasBeSecret) == "function" then
		lines[#lines + 1] =
			string.format("C_Secrets.ShouldAurasBeSecret() = %s", tostring(C_Secrets.ShouldAurasBeSecret()))
	end

	lines[#lines + 1] = ""

	--[[
	    Which signal is in force comes first, because it is what a "why did X
	    count as a tank" report needs: in a raid only the Main Tank assignment
	    counts and the group finder's TANK role is ignored, outside one the role
	    is the only signal (Features/Utilities.lua says why). In a raid the
	    ignored tags are listed too, so a healer still wearing a Tank tag from a
	    dungeon queue shows up as exactly that rather than as a mystery. Each
	    carries its class, because Bad Priests only ever warns about a shield on a
	    tank of a rage class.
	]]
	local inRaid = IsInRaid()
	local hasRoles = type(UnitGroupRolesAssigned) == "function"
	local tanks, ignoredTags = {}, {}
	local function NoteUnit(unit)
		local _, class = UnitClass(unit)
		local entry = string.format(
			"%s (%s, %s%s)",
			unit,
			tostring(GetUnitName(unit, true)),
			tostring(class),
			class and ns.RAGE_TANK_CLASSES[class] and ", rage" or ""
		)
		-- ns.GroupHasTank skips a tank who is dead or offline.
		if UnitIsDeadOrGhost(unit) then
			entry = entry .. " dead"
		elseif not UnitIsConnected(unit) then
			entry = entry .. " offline"
		end
		if ns.IsUnitTank(unit) then
			tanks[#tanks + 1] = entry
		elseif inRaid and hasRoles and UnitGroupRolesAssigned(unit) == "TANK" then
			ignoredTags[#ignoredTags + 1] = entry
		end
	end
	NoteUnit("player")
	if inRaid then
		for index = 1, GetNumGroupMembers() do
			local unit = "raid" .. index
			if UnitGUID(unit) ~= UnitGUID("player") then
				NoteUnit(unit)
			end
		end
	elseif IsInGroup() then
		for index = 1, 4 do
			NoteUnit("party" .. index)
		end
	end
	local rule = inRaid and "in a raid only the Main Tank assignment counts"
		or "outside a raid the group finder's Tank role counts"
	if #tanks == 0 then
		lines[#lines + 1] = "Tanks: none (" .. rule .. "; a tab with either tank scope set never fires without one)"
	else
		lines[#lines + 1] = "Tanks (" .. rule .. "): " .. table.concat(tanks, ", ")
	end
	if #ignoredTags > 0 then
		lines[#lines + 1] = "Tank role tags ignored in a raid: " .. table.concat(ignoredTags, ", ")
	end
	lines[#lines + 1] = string.format("ns.GroupHasTank() = %s (a tank must also be alive)", tostring(ns.GroupHasTank()))

	AppendAnnounceContext(lines)
	AppendSectionLines(lines, profile)
	AppendArmorContext(lines, profile)
	AppendSoundContext(lines)
	AppendAbilityContext(lines)

	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Name Lookups
--------------------------------------------------------------------------------

--[[
    Every record Control Freak shows by the name this client gives it, for the
    Localization tab's Game Names report: each ability row, read the way
    ns.BuildAbilityIndex labels it (the last trigger this client answers for),
    each class the Tank Deaths tab lists, in both its male and female form,
    through ns.ClassName, and each spell the options panels' sample lines name
    (ns.SAMPLE_SPELL_IDS) through ns.SampleSpell. A spell can load late, so its
    row asks for every trigger and the report polls.
]]
local function AbilityLookup(index, entry)
	return {
		constant = string.format("ABILITIES[%d] %s %s", index, entry.class, entry.category),
		kind = "spell",
		id = entry.triggers[1],
		lookup = function()
			local name
			for _, spellId in ipairs(entry.triggers) do
				name = ns.GetSpellNameAndIcon(spellId) or name
			end
			return name
		end,
		request = function()
			for _, spellId in ipairs(entry.triggers) do
				C_Spell.RequestLoadSpellData(spellId)
			end
		end,
	}
end

local function ClassLookup(class, sex)
	return {
		constant = (sex == 3 and "CLASS_FEMALE " or "CLASS ") .. class,
		kind = "class",
		id = class,
		lookup = function()
			return ns.ClassName(class, sex)
		end,
	}
end

--[[
    ns.SampleSpell answers L["UNKNOWN_SPELL"] for a spell this client cannot
    name, so that answer is the NIL here: a sample line showing Unknown Spell.
]]
local function SampleLookup(key, spellId)
	return {
		constant = "SAMPLE_SPELL_IDS." .. key,
		kind = "spell",
		id = spellId,
		lookup = function()
			local name = ns.SampleSpell(spellId)
			if name == L["UNKNOWN_SPELL"] then
				return nil
			end
			return name
		end,
		request = function()
			C_Spell.RequestLoadSpellData(spellId)
		end,
	}
end

ns.DIAGNOSTIC_NAME_LOOKUPS = {}
for index, entry in ipairs(ns.ABILITIES) do
	ns.DIAGNOSTIC_NAME_LOOKUPS[#ns.DIAGNOSTIC_NAME_LOOKUPS + 1] = AbilityLookup(index, entry)
end
for _, class in ipairs(ns.DEATH_CLASSES) do
	ns.DIAGNOSTIC_NAME_LOOKUPS[#ns.DIAGNOSTIC_NAME_LOOKUPS + 1] = ClassLookup(class)
	ns.DIAGNOSTIC_NAME_LOOKUPS[#ns.DIAGNOSTIC_NAME_LOOKUPS + 1] = ClassLookup(class, 3)
end
for _, key in ipairs(SortedKeys(ns.SAMPLE_SPELL_IDS)) do
	ns.DIAGNOSTIC_NAME_LOOKUPS[#ns.DIAGNOSTIC_NAME_LOOKUPS + 1] = SampleLookup(key, ns.SAMPLE_SPELL_IDS[key])
end

--------------------------------------------------------------------------------
-- Message Length
--------------------------------------------------------------------------------

--[[
    Every line Control Freak can send to chat, with the parts its handler hands
    over, in order. Alert lines are announced through ns:Alert, whispers through
    ns:QueueGroupWhisper; both end in ns:BuildAnnounceMessage, which is what this
    report measures. Tank Deaths' class log is print-only and left out.
]]
local ALERT_FORMATS = {
	{ "TAUNT_SUCCESS", "player", "spell", "target" },
	{ "TAUNT_MISSED", "player", "spell", "target" },
	{ "TAUNT_RESISTED", "player", "spell", "target" },
	{ "TAUNT_FAILED", "player", "spell", "target" },
	{ "TAUNT_IMMUNE", "target", "player", "spell" },
	{ "TAUNT_AOE", "player", "spell" },
	{ "INTERRUPT", "player", "spell", "target", "spell" },
	{ "FEAR_SUCCESS", "player", "spell", "target" },
	{ "FEAR_AOE", "player", "spell" },
	{ "NOVA", "player", "spell", "target" },
	{ "NOVA_AOE", "player", "spell" },
	{ "SHIELD_WARNING", "player", "spell", "player" },
	{ "BAD_PET", "player", "player", "spell", "target" },
	{ "BAD_PET_AOE", "player", "player", "spell" },
	{ "BAD_PET_UNKNOWN_OWNER", "player", "spell", "target" },
	{ "BAD_PET_UNKNOWN_OWNER_AOE", "player", "spell" },
	{ "PARRY_WARNING", "player", "target" },
	{ "ARMOR_REPORT", "target", "elapsed" },
	{ "COLD_OPENER_MISS", "player", "spell", "target" },
	{ "COLD_OPENER_DODGE", "player", "spell", "target" },
	{ "COLD_OPENER_PARRY", "player", "spell", "target" },
	{ "COLD_OPENER_BLOCK", "player", "spell", "target" },
	{ "COLD_OPENER_IMMUNE", "player", "spell", "target" },
	{ "COLD_OPENER_RESIST", "player", "spell", "target" },
	{ "INCAPACITATED", "seat", "seconds", "player", "spell", "dispel", "boss" },
	{ "INCAPACITATED_PLAIN", "seat", "seconds", "player", "spell", "boss" },
	{ "INCAPACITATED_INDEFINITE", "seat", "player", "spell", "dispel", "boss" },
	{ "INCAPACITATED_PLAIN_INDEFINITE", "seat", "player", "spell", "boss" },
	{ "TANK_DEATHS_TANK_LINE", "player" },
	{ "BAD_PET_WHISPER", "name", "spell", "boss" },
	{ "BAD_PET_WHISPER_AOE", "name", "spell" },
	{ "SHIELD_WHISPER", "spell", "name" },
	{ "PARRY_WHISPER", "boss" },
}

--[[
    A character name is at most twelve letters, and a two-byte letter is the
    widest a Latin or Cyrillic realm allows, so twelve of them is the longest
    name a line can carry. No player name is stored anywhere to measure instead.
]]
local LONGEST_PLAYER_NAME = string.rep("Ж", 12)

local function Longest(values)
	local best = ""
	for _, value in ipairs(values) do
		if type(value) == "string" and #value > #best then
			best = value
		end
	end
	return best
end

-- The widest value this client gives each kind of part, rendered the way the line will be.
local function WidestParts()
	local spells = {}
	for _, group in ipairs(ns.ABILITY_GROUPS) do
		spells[#spells + 1] = ns.RenderAlertPart(ns.SpellPart(group.maxRankId, group.name), false)
	end
	local bosses = {}
	for _, boss in ipairs(ns.SAMPLE_BOSSES) do
		bosses[#bosses + 1] = boss
	end
	local seats = { L["INCAPACITATED_ROLE_TANK"], L["INCAPACITATED_ROLE_HEALER"] }
	for _, class in ipairs(ns.DEATH_CLASSES) do
		seats[#seats + 1] = ns.ClassName(class)
	end
	local dispels = {}
	for _, suffix in pairs(ns.DISPEL_TYPES) do
		dispels[#dispels + 1] = L["DISPEL_" .. suffix]
	end
	local boss = Longest(bosses)
	return {
		player = ns.RenderAlertPart(ns.PlayerPart(LONGEST_PLAYER_NAME), false),
		name = ns.ShortName(LONGEST_PLAYER_NAME),
		spell = Longest(spells),
		target = ns.RenderAlertPart(ns.TargetPart(boss, 8), false),
		boss = boss,
		seat = Longest(seats),
		seconds = string.format(
			L["INCAPACITATED_SECONDS"],
			ns.INCAPACITATED_LONG_THRESHOLDS[#ns.INCAPACITATED_LONG_THRESHOLDS]
		),
		dispel = Longest(dispels),
		elapsed = "99.9",
	}
end

function ns:BuildMessageLengthReport()
	local lines = { GetClientHeader(), "" }
	local widest = WidestParts()
	local limit = ns.CHAT_MESSAGE_MAX_LENGTH
	for _, row in ipairs(ALERT_FORMATS) do
		local args = {}
		for index = 2, #row do
			args[#args + 1] = widest[row[index]]
		end
		local message = ns:BuildAnnounceMessage(row[1], unpack(args))
		if message then
			lines[#lines + 1] = string.format(
				"[%s] %s: %d / %d bytes: %s",
				#message > limit and "OVER" or "OK",
				row[1],
				#message,
				limit,
				(message:gsub("|", "||"))
			)
		else
			lines[#lines + 1] = string.format("[MISSING] %s: no format in this locale", row[1])
		end
	end
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Validate Data Sources
--------------------------------------------------------------------------------

--[[
    One entry per data file, and one report row per entry on the Data tab
    (Diagnostics/Options-Diagnostics.lua). Each entry's label is the table-name
    part of its file name, so ns.DataSourceFileName can name the file this
    client's folder built. The Abilities and Armor Debuffs files list spell
    ids inside each row, so their sources walk a row's id list and answer once
    per id, keyed by its rank in that list. The Items file is keyed by item
    id, one id per row, and the Sample Spells file by name, one spell id per
    key. dataColumns carries the shipped row's own values beside
    what the client says. DATA_ROW_NAME is the client's name for the row's first id that
    resolves, so a NAME that disagrees with it is an id belonging to a different
    spell, unless the row is marked renamed.
]]
local function IdCollector(field)
	return function(rows)
		local entries = {}
		for _, row in ipairs(rows) do
			for rank, id in ipairs(row[field] or {}) do
				entries[#entries + 1] = { id = id, key = rank, row = row }
			end
		end
		return entries
	end
end

local function RowField(field)
	return function(_, row)
		return row[field]
	end
end

local function Rank(rank)
	return rank
end

local function RowName(field)
	return function(_, row)
		for _, spellId in ipairs(row[field] or {}) do
			local name = ns.GetSpellNameAndIcon(spellId)
			if name then
				return name
			end
		end
		return nil
	end
end

local function Tracked(field, isTracked)
	return function(rank, row)
		return isTracked(row[field][rank])
	end
end

ns.DIAGNOSTIC_DATA_SOURCES = {
	-- { label, sources = { { table, kind, rowId or collect, dataColumns } } }
	{
		label = "Abilities",
		sources = {
			{
				table = "ABILITIES",
				kind = "spell",
				collect = IdCollector("triggers"),
				dataColumns = {
					{ "DATA_CLASS", RowField("class") },
					{ "DATA_CATEGORY", RowField("category") },
					{ "DATA_DETECTION", RowField("detection") },
					{ "DATA_IS_AOE", RowField("isAoe") },
					{ "DATA_KIND_CHOICE", RowField("kindChoice") },
					{ "DATA_RENAMED", RowField("renamed") },
					{ "DATA_RANK", Rank },
					{ "DATA_ROW_NAME", RowName("triggers") },
					{
						"DATA_TRACKED",
						Tracked("triggers", function(spellId)
							return ns.ABILITY_MAP[spellId] ~= nil
						end),
					},
				},
			},
		},
	},
	{
		label = "Armor-Debuffs",
		sources = {
			{
				table = "ARMOR_DEBUFFS",
				kind = "spell",
				collect = IdCollector("ids"),
				dataColumns = {
					{ "DATA_KEY", RowField("key") },
					{ "DATA_SATISFIES", RowField("satisfies") },
					{ "DATA_STACKS", RowField("stacks") },
					{ "DATA_REQUIRES_CLASS", RowField("requiresClass") },
					{ "DATA_SETTING", RowField("setting") },
					{ "DATA_RENAMED", RowField("renamed") },
					{ "DATA_RANK", Rank },
					{ "DATA_ROW_NAME", RowName("ids") },
					{ "DATA_TRACKED", Tracked("ids", ns.IsArmorDebuffSpell) },
				},
			},
		},
	},
	--[[
	    Each item prints beside the spell it casts (the item block's own spell
	    columns), and DATA_SPELL is the spell the row records, so a disagreement
	    between the two is an item id belonging to some other item. DATA_TRACKED
	    marks the items whose spell an Abilities row listens for.
	]]
	{
		label = "Items",
		sources = {
			{
				table = "ITEMS",
				kind = "item",
				rowId = function(itemId)
					return itemId
				end,
				dataColumns = {
					{ "DATA_KIND", RowField("kind") },
					{ "DATA_VIA", RowField("via") },
					{ "DATA_ON", RowField("on") },
					{ "DATA_SPELL", RowField("spell") },
					{
						"DATA_TRACKED",
						function(_, row)
							return ns.ABILITY_MAP[row.spell] ~= nil
						end,
					},
				},
			},
		},
	},
	--[[
	    Keyed by the name each Options/ file asks for, one spell id per key. The
	    key is the row's whole story, so it is the only shipped column.
	]]
	{
		label = "Sample-Spells",
		sources = {
			{
				table = "SAMPLE_SPELL_IDS",
				kind = "spell",
				rowId = function(_, spellId)
					return spellId
				end,
				dataColumns = {
					{
						"DATA_KEY",
						function(key)
							return key
						end,
					},
				},
			},
		},
	},
}
