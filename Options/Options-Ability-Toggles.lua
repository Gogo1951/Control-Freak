local _, ns = ...

local L = ns.L
local GetColor = ns.GetColor

--------------------------------------------------------------------------------
-- Spell Toggle Widget
--------------------------------------------------------------------------------

--[[
    A checkbox that shows the spell's own game tooltip on hover, used via
    dialogControl on the ability rows. AceGUI's stock CheckBox fires its OnEnter
    straight at AceConfigDialog, which draws the name-and-desc tooltip and leaves
    no room for the real one, so the row carries its own widget instead. Same
    approach as Magic Eraser's item-link rows: the AceGUI widget the option would
    have used, plus mouse handling that opens a GameTooltip on the thing itself.

    The spell to show arrives in the option's arg field, which AceConfig passes
    through untouched. It is the highest rank this client has, so the tooltip
    reads for the character looking at it rather than for rank 1.
]]
local AceGUI = LibStub("AceGUI-3.0")
local SPELL_TOGGLE_WIDGET_VERSION = 1

local function SpellToggleOnEnter(frame)
	local self = frame.obj
	local option = self:GetUserData("option")
	local spellId = option and option.arg
	if not spellId then
		return
	end
	GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
	GameTooltip:SetHyperlink("spell:" .. spellId)
	GameTooltip:Show()
end

local function SpellToggleOnLeave()
	GameTooltip:Hide()
end

local function SpellToggleOnClick(frame)
	local self = frame.obj
	if self.disabled then
		return
	end
	self.checked = not self.checked
	self:SetValue(self.checked)
	PlaySound(self.checked and 856 or 857) -- checkbox on / off
	self:Fire("OnValueChanged", self.checked)
end

local spellToggleMethods = {}

function spellToggleMethods:OnAcquire()
	self:SetValue(false)
	self:SetDisabled(nil)
	self:SetWidth(200)
	self:SetHeight(24)
end

function spellToggleMethods:OnRelease()
	self.frame:Enable()
end

function spellToggleMethods:SetValue(value)
	self.checked = value and true or false
	if self.checked then
		self.check:Show()
	else
		self.check:Hide()
	end
end

function spellToggleMethods:GetValue()
	return self.checked
end

function spellToggleMethods:SetLabel(text)
	self.text:SetText(text or "")
end

function spellToggleMethods:SetDisabled(disabled)
	self.disabled = disabled
	if disabled then
		self.frame:Disable()
		self.text:SetTextColor(0.5, 0.5, 0.5)
	else
		self.frame:Enable()
		self.text:SetTextColor(1, 1, 1)
	end
end

--[[
    AceConfigDialog drives every toggle through these; this row has no tristate,
    no inline description, and no image of its own.
]]
function spellToggleMethods:SetTriState() end

function spellToggleMethods:SetDescription() end

function spellToggleMethods:SetImage() end

local function SpellToggleConstructor()
	local frame = CreateFrame("Button", nil, UIParent)
	frame:EnableMouse(true)
	frame:SetHeight(24)
	frame:RegisterForClicks("AnyUp")
	frame:SetScript("OnEnter", SpellToggleOnEnter)
	frame:SetScript("OnLeave", SpellToggleOnLeave)
	frame:SetScript("OnClick", SpellToggleOnClick)

	local checkbg = frame:CreateTexture(nil, "ARTWORK")
	checkbg:SetWidth(24)
	checkbg:SetHeight(24)
	checkbg:SetPoint("TOPLEFT")
	checkbg:SetTexture(130755) -- Interface\Buttons\UI-CheckBox-Up

	local check = frame:CreateTexture(nil, "OVERLAY")
	check:SetAllPoints(checkbg)
	check:SetTexture(130751) -- Interface\Buttons\UI-CheckBox-Check

	local highlight = frame:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetAllPoints(checkbg)
	highlight:SetTexture(130753) -- Interface\Buttons\UI-CheckBox-Highlight
	highlight:SetBlendMode("ADD")

	local text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	text:SetJustifyH("LEFT")
	text:SetPoint("LEFT", checkbg, "RIGHT", 1, 0)
	text:SetPoint("RIGHT")

	local widget = {
		frame = frame,
		checkbg = checkbg,
		check = check,
		highlight = highlight,
		text = text,
		type = ns.SPELL_TOGGLE_WIDGET_TYPE,
	}

	for method, func in pairs(spellToggleMethods) do
		widget[method] = func
	end
	frame.obj = widget

	return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(ns.SPELL_TOGGLE_WIDGET_TYPE, SpellToggleConstructor, SPELL_TOGGLE_WIDGET_VERSION)

--------------------------------------------------------------------------------
-- Ability Toggles
--------------------------------------------------------------------------------

local CLASS_ORDER = {
	"WARRIOR",
	"PALADIN",
	"HUNTER",
	"ROGUE",
	"PRIEST",
	"DEATHKNIGHT",
	"SHAMAN",
	"MAGE",
	"WARLOCK",
	"DRUID",
	"ITEM",
}

--[[
    Pet abilities belong to the pet, not the class, so the heading says so. Built
    from a format string rather than concatenation, since a locale may not put the
    qualifier after the class name.
]]
local BUCKET_SUFFIXES = { "", "Pet" }

local function ClassLabel(class, isPet)
	if class == "ITEM" then
		return GetColor("MUTED") .. L["ABILITIES_ITEMS"] .. "|r"
	end
	local name = ns.ClassName(class)
	if isPet then
		name = string.format(L["ABILITIES_CLASS_PET"], name)
	end
	local hex = ns.CLASS_COLORS[class]
	if hex then
		return "|cff" .. hex .. name .. "|r"
	end
	return name
end

--[[
    One toggle per ability, reading the groups ns.BuildAbilityIndex built in
    Features/Ability-Index.lua. It has already dropped what this flavor does not
    have and what this client's spell data does not know, so every group here has
    a rank to draw. Unchecking a row ignores every rank at once, including the
    ranks this client cannot see, so a character who levels or changes flavor
    keeps the choice they made.

    options:
      categories  -- set of ability categories to draw
      order       -- the first group's order
      hidden      -- predicate hung on every group
      aoe         -- "AOE" or "SINGLE" to draw only that half; nil draws both
      keyPrefix   -- namespaces the returned arg keys, so a panel calling this
                     twice does not have its second set overwrite its first
]]
function ns.BuildAbilityToggles(options)
	local args = {}
	local byClass = {}
	local hidden = options.hidden
	local keyPrefix = options.keyPrefix or "class"
	local filterAoe = options.aoe ~= nil
	local wantAoe = options.aoe == "AOE"

	--[[
	    Bucketed by class AND by whether the ability is the class's or its pet's, so
	    a panel showing both keeps them under separate headings.
	]]
	for _, group in ipairs(ns.ABILITY_GROUPS) do
		local isAoe = group.isAoe and true or false
		if options.categories[group.category] and (not filterAoe or isAoe == wantAoe) then
			local bucketKey = group.class .. (group.category == "PET_TAUNT" and "Pet" or "")
			local entries = byClass[bucketKey]
			if not entries then
				entries = {}
				byClass[bucketKey] = entries
			end
			entries[#entries + 1] = group
		end
	end

	local groupOrder = options.order
	for _, class in ipairs(CLASS_ORDER) do
		for _, suffix in ipairs(BUCKET_SUFFIXES) do
			local entries = byClass[class .. suffix]
			if entries then
				table.sort(entries, function(a, b)
					return a.name < b.name
				end)

				local classArgs = {}
				for index, group in ipairs(entries) do
					local label = group.name
					if group.icon then
						label = "|T" .. group.icon .. ":16|t " .. group.name
					end
					local ids = group.ids
					classArgs["ability" .. index] = {
						type = "toggle",
						dialogControl = ns.SPELL_TOGGLE_WIDGET_TYPE,
						name = label,
						-- The widget reads arg to pick the spell whose tooltip it shows.
						arg = group.maxRankId,
						--[[
						    One per row. Two columns puts each cell at half the row, which
						    is not enough for the longest ability names -- "Masterwork
						    Target Dummy" wrapped onto a second line and left the row
						    ragged. Sorted by name within the class, so the column reads
						    alphabetically.
						]]
						width = "full",
						order = index,
						get = function()
							local ignored = ns.db.profile.ignoredSpells
							for _, id in ipairs(ids) do
								if ignored[id] then
									return false
								end
							end
							return true
						end,
						set = function(_, value)
							local ignored = ns.db.profile.ignoredSpells
							for _, id in ipairs(ids) do
								if value then
									ignored[id] = nil
								else
									ignored[id] = true
								end
							end
						end,
					}
				end

				args[keyPrefix .. class .. suffix] = {
					type = "group",
					name = ClassLabel(class, suffix == "Pet"),
					inline = true,
					order = groupOrder,
					hidden = hidden,
					args = classArgs,
				}
				groupOrder = groupOrder + 1
			end
		end
	end

	return args
end
