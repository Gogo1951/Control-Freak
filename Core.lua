local _, core = ...
local ControlFreak = LibStub("AceAddon-3.0"):NewAddon("ControlFreak", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ControlFreak")
local LSM = LibStub("LibSharedMedia-3.0")

--------------------------------------------------------------------------------
-- UPVALUES
--------------------------------------------------------------------------------
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local UnitGUID = UnitGUID
local UnitName = UnitName
local UnitInParty = UnitInParty
local UnitInRaid = UnitInRaid
local IsInGroup = IsInGroup
local IsInRaid = IsInRaid
local IsInInstance = IsInInstance
local SendChatMessage = SendChatMessage
local PlaySoundFile = PlaySoundFile
local GetSpellLink = GetSpellLink
local string_format = string.format
local string_find = string.find
local bit_band = bit.band
local GetRealmName = GetRealmName
local GetTime = GetTime
local pairs, ipairs = pairs, ipairs

local PLAYER_REALM = GetRealmName()
local PLAYER_GUID = UnitGUID("player")

local projectVersion = "@project-version@"
if projectVersion:find("project") then
    projectVersion = "Dev"
end
ControlFreak.version = projectVersion

local petOwnerCache = {}
local spamThrottle = {}
local badPetHistory = {
    instance = {},
    boss = {}
}

local CLASS_HEX = {
    DEATHKNIGHT = "C41F3B",
    DRUID = "FF7D0A",
    HUNTER = "ABD473",
    MAGE = "40C7EB",
    PALADIN = "F58CBA",
    PRIEST = "FFFFFF",
    ROGUE = "FFF569",
    SHAMAN = "0070DE",
    WARLOCK = "9482C9",
    WARRIOR = "C79C6E",
    DEFAULT = "CCCCCC"
}

--------------------------------------------------------------------------------
-- INITIALIZATION
--------------------------------------------------------------------------------
function ControlFreak:OnInitialize()
    local defaults = {
        profile = {
            blacklist = {},
            general = {
                globalEnable = true,
                notInGroup = false,
                inParty = true,
                inRaid = true,
                openWorld = false,
                instances = true,
                battlegrounds = false,
                arenas = false
            },
            own = {
                enable = true,
                rank = 2,
                print = true,
                channel = "SELF",
                audio = true,
                sound = "Punch",
                aoeAudio = true,
                aoeSound = "Boxing Arena Gong",
                failPrint = true,
                failChannel = "GROUP",
                failAudio = true,
                failSound = "Synth Chord"
            },
            group = {
                enable = true,
                rank = 2,
                print = true,
                channel = "SELF",
                audio = true,
                sound = "Punch",
                aoeAudio = true,
                aoeSound = "Boxing Arena Gong",
                failPrint = true,
                failChannel = "SELF",
                failAudio = true,
                failSound = "Synth Chord"
            },
            other = {
                enable = false,
                rank = 2,
                print = false,
                channel = "SELF",
                audio = false,
                sound = "Punch",
                aoeAudio = false,
                aoeSound = "Boxing Arena Gong",
                failPrint = false,
                failChannel = "SELF",
                failAudio = false,
                failSound = "Synth Chord"
            },
            pets = {
                enable = true,
                rank = 2,
                print = true,
                channel = "SELF",
                audio = false,
                sound = "Bite",
                badPetEnable = false,
                badPetFreq = "BOSS"
            },
            fears = {
                enable = true,
                rank = 3,
                print = true,
                channel = "SELF",
                audio = true,
                sound = "Voice: Idiot"
            },
            annoyances = {
                enable = true,
                print = true,
                channel = "SELF",
                audio = false,
                sound = "Voice: Idiot"
            },
            items = {
                enable = true,
                print = true,
                channel = "SELF",
                audio = true,
                sound = "Squeaky Toy Short"
            }
        }
    }

    self.db = LibStub("AceDB-3.0"):New("ControlFreakDB", defaults, true)

    if not self.db.profile then
        self.db.profile = defaults.profile
    end

    self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")

    self:SetupOptions()

    self.SpellMap = {}
    if core.SpellDB then
        for id, data in pairs(core.SpellDB.Taunts or {}) do
            self.SpellMap[id] = {type = "Taunt", data = data}
        end
        for id, data in pairs(core.SpellDB.Pets or {}) do
            self.SpellMap[id] = {type = "Pet", data = data}
        end
        for id, data in pairs(core.SpellDB.Fears or {}) do
            self.SpellMap[id] = {type = "Fear", data = data}
        end
        for id, data in pairs(core.SpellDB.Items or {}) do
            self.SpellMap[id] = {type = "Item", data = data}
        end
        for id, data in pairs(core.SpellDB.Annoyances or {}) do
            self.SpellMap[id] = {type = "Annoyance", data = data}
        end
    end
end

function ControlFreak:RefreshConfig()
end

function ControlFreak:OnEnable()
    PLAYER_GUID = UnitGUID("player")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("UNIT_PET")
    self:RegisterEvent("GROUP_ROSTER_UPDATE", "ScanAllPets")

    self:RegisterEvent("ENCOUNTER_END")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")

    self:ScanAllPets()
end

--------------------------------------------------------------------------------
-- PET CACHING & HISTORY
--------------------------------------------------------------------------------
function ControlFreak:UNIT_PET(_, unitId)
    local petGUID = UnitGUID(unitId .. "pet")
    if petGUID then
        petOwnerCache[petGUID] = {
            ownerName = UnitName(unitId),
            ownerGUID = UnitGUID(unitId)
        }
    end
end

function ControlFreak:ScanAllPets()
    petOwnerCache = {}
    self:UNIT_PET(nil, "player")

    if IsInRaid() then
        for i = 1, 40 do
            self:UNIT_PET(nil, "raid" .. i)
        end
    elseif IsInGroup() then
        for i = 1, 4 do
            self:UNIT_PET(nil, "party" .. i)
        end
    end
end

function ControlFreak:ENCOUNTER_END()
    badPetHistory.boss = {}
end

function ControlFreak:PLAYER_ENTERING_WORLD()
    badPetHistory.instance = {}
    badPetHistory.boss = {}
end

function ControlFreak:CheckFrequency(guid, spellID)
    local freq = self.db.profile.pets.badPetFreq or "BOSS"

    if freq == "ALWAYS" then
        return true
    end

    local key = guid .. "-" .. spellID

    if freq == "INSTANCE" then
        if badPetHistory.instance[key] then
            return false
        end
        badPetHistory.instance[key] = true
        return true
    end

    if freq == "BOSS" then
        if badPetHistory.boss[key] then
            return false
        end
        badPetHistory.boss[key] = true
        return true
    end

    return true
end

function ControlFreak:SendBadPetWhisper(ownerName, petName, spellID, spellName, destName)
    if not ownerName then
        return
    end

    local safeDest = destName or "Unknown Target"

    local spellLink = "|cff71d5ff|Hspell:" .. spellID .. ":0|h[" .. spellName .. "]|h|r"

    local msg = string_format(L["BAD_PET_WHISPER"], petName, spellLink, safeDest)

    SendChatMessage(msg, "WHISPER", nil, ownerName)
end

--------------------------------------------------------------------------------
-- HELPERS
--------------------------------------------------------------------------------
local function IsZoneEnabled(db)
    if not db.general.globalEnable then
        return false
    end

    local _, instanceType = IsInInstance()

    if instanceType == "pvp" then
        return db.general.battlegrounds
    elseif instanceType == "arena" then
        return db.general.arenas
    elseif instanceType == "party" or instanceType == "raid" then
        return db.general.instances
    end

    if not db.general.openWorld then
        return false
    end

    if IsInRaid() then
        return db.general.inRaid
    elseif IsInGroup() then
        return db.general.inParty
    else
        return db.general.notInGroup
    end
end

local function CheckRank(guid, minRankSetting)
    local rank = minRankSetting or 3
    if rank == 3 then
        return true
    end
    if not guid or guid == "" then
        return false
    end

    local classification = "normal"
    local tokens = {"target", "focus", "mouseover"}
    for _, unit in ipairs(tokens) do
        if UnitGUID(unit) == guid then
            classification = UnitClassification(unit)
            break
        end
    end

    if rank == 1 then
        return classification == "worldboss"
    elseif rank == 2 then
        return (classification == "worldboss" or classification == "rareelite" or classification == "elite")
    end
    return false
end

local function PlayAlertSound(soundName)
    if not soundName or soundName == "None" then
        return
    end
    local soundFile = LSM:Fetch("sound", soundName)
    if soundFile then
        PlaySoundFile(soundFile, "Master")
    end
end

local function FormatNameWithRealm(name, guid)
    if not name then
        return "?"
    end
    if string_find(name, "-") then
        return name
    end

    if guid and string_find(guid, "^Player") then
        return name .. "-" .. PLAYER_REALM
    end
    return name
end

local function GetRaidIconFromFlags(destRaidFlags)
    if not destRaidFlags then
        return ""
    end
    if bit_band(destRaidFlags, COMBATLOG_OBJECT_RAIDTARGET8) > 0 then
        return "{rt8} "
    end
    if bit_band(destRaidFlags, COMBATLOG_OBJECT_RAIDTARGET7) > 0 then
        return "{rt7} "
    end
    if bit_band(destRaidFlags, COMBATLOG_OBJECT_RAIDTARGET6) > 0 then
        return "{rt6} "
    end
    if bit_band(destRaidFlags, COMBATLOG_OBJECT_RAIDTARGET5) > 0 then
        return "{rt5} "
    end
    if bit_band(destRaidFlags, COMBATLOG_OBJECT_RAIDTARGET4) > 0 then
        return "{rt4} "
    end
    if bit_band(destRaidFlags, COMBATLOG_OBJECT_RAIDTARGET3) > 0 then
        return "{rt3} "
    end
    if bit_band(destRaidFlags, COMBATLOG_OBJECT_RAIDTARGET2) > 0 then
        return "{rt2} "
    end
    if bit_band(destRaidFlags, COMBATLOG_OBJECT_RAIDTARGET1) > 0 then
        return "{rt1} "
    end
    return ""
end

local function GetThemeColor(sourceGUID, spellName, spellInfo)
    if spellInfo.type == "Pet" then
        if string_find(spellName, "Growl") then
            return CLASS_HEX.HUNTER
        elseif string_find(spellName, "Torment") or string_find(spellName, "Suffering") then
            return CLASS_HEX.WARLOCK
        end
    end
    if sourceGUID then
        local _, englishClass = GetPlayerInfoByGUID(sourceGUID)
        if englishClass and CLASS_HEX[englishClass] then
            return CLASS_HEX[englishClass]
        end
    end
    return CLASS_HEX.DEFAULT
end

local function GetSpellDisplay(spellID, spellName)
    return "|cff71d5ff|Hspell:" .. spellID .. ":0|h[" .. spellName .. "]|h|r"
end

local function SendSmartGroupMessage(msg)
    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        SendChatMessage(msg, "INSTANCE_CHAT")
    elseif IsInRaid() then
        SendChatMessage(msg, "RAID")
    elseif IsInGroup() then
        SendChatMessage(msg, "PARTY")
    end
end

--------------------------------------------------------------------------------
-- COMBAT LOG HANDLER
--------------------------------------------------------------------------------
function ControlFreak:COMBAT_LOG_EVENT_UNFILTERED()
    if not IsZoneEnabled(self.db.profile) then
        return
    end

    local _,
        eventType,
        _,
        sourceGUID,
        sourceName,
        _,
        _,
        destGUID,
        destName,
        _,
        destRaidFlags,
        spellID,
        spellName,
        _,
        missType = CombatLogGetCurrentEventInfo()

    local spellInfo = self.SpellMap[spellID]
    if not spellInfo then
        return
    end

    if self.db.profile.blacklist[spellID] then
        return
    end

    local spellType = spellInfo.type
    local isAoE = spellInfo.data.aoe

    local isSuccess = false
    local isFail = false

    if eventType == "SPELL_CAST_SUCCESS" then
        isSuccess = true
    elseif eventType == "SPELL_MISSED" or eventType == "RANGE_MISSED" then
        isFail = true
    end

    if not isSuccess and not isFail then
        return
    end

    local categoryKey = "other"
    local db = self.db.profile
    local cfg
    local petOwnerName = nil

    local isMine = (sourceGUID == PLAYER_GUID)
    local isGroup = (UnitInParty(sourceName) or UnitInRaid(sourceName))

    if spellType == "Fear" then
        cfg = db.fears
    elseif spellType == "Annoyance" then
        cfg = db.annoyances
        if not (isMine or isGroup) then
            return
        end
    elseif spellType == "Pet" then
        cfg = db.pets
        local ownerData = petOwnerCache[sourceGUID]
        if ownerData then
            if ownerData.ownerGUID == PLAYER_GUID then
                isMine = true
            end
            if UnitInParty(ownerData.ownerName) or UnitInRaid(ownerData.ownerName) then
                isGroup = true
            end
            petOwnerName = ownerData.ownerName
        end
        if not (isMine or isGroup) then
            return
        end
    elseif spellType == "Item" then
        cfg = db.items
        if spellID == 4054 and not db.items.targetDummy then
            return
        end
        if spellID == 4068 and not db.items.advTargetDummy then
            return
        end
        if not (isMine or isGroup) then
            return
        end
    else
        if isMine then
            categoryKey = "own"
        elseif isGroup then
            categoryKey = "group"
        else
            categoryKey = "other"
        end
        cfg = db[categoryKey]
    end

    if not cfg.enable then
        return
    end

    if spellType ~= "Item" then
        if not (isAoE and isSuccess) then
            if not CheckRank(destGUID, cfg.rank or 3) then
                return
            end
        end
    end

    local now = GetTime()
    local spamKey = (sourceGUID or "nil") .. (spellID or "0")
    if spamThrottle[spamKey] and (now - spamThrottle[spamKey] < 0.5) then
        return
    end
    spamThrottle[spamKey] = now

    if isAoE and isSuccess then
        destName = nil
    end

    if isSuccess then
        local playSound = cfg.audio
        local whichSound = cfg.sound

        if isAoE and cfg.aoeAudio ~= nil then
            playSound = cfg.aoeAudio
            whichSound = cfg.aoeSound
        end

        if playSound then
            PlayAlertSound(whichSound)
        end

        if spellType == "Pet" and cfg.badPetEnable and not isMine and petOwnerName then
            if self:CheckFrequency(sourceGUID, spellID) then
                self:SendBadPetWhisper(petOwnerName, sourceName, spellID, spellName, destName)
            end
        end

        if cfg.print then
            self:ConstructAndSend(
                cfg.channel,
                sourceGUID,
                sourceName,
                destName,
                destRaidFlags,
                spellID,
                spellName,
                spellInfo,
                spellType,
                true,
                nil
            )
        end
    elseif isFail then
        if cfg.failAudio then
            PlayAlertSound(cfg.failSound)
        end
        if cfg.failPrint then
            self:ConstructAndSend(
                cfg.failChannel,
                sourceGUID,
                sourceName,
                destName,
                destRaidFlags,
                spellID,
                spellName,
                spellInfo,
                spellType,
                false,
                missType
            )
        end
    end
end

--------------------------------------------------------------------------------
-- MESSAGE CONSTRUCTION
--------------------------------------------------------------------------------
function ControlFreak:ConstructAndSend(
    channel,
    sourceGUID,
    sourceName,
    destName,
    destRaidFlags,
    spellID,
    spellName,
    spellInfo,
    spellType,
    isSuccess,
    missType)
    local spellDisplay = GetSpellDisplay(spellID, spellName)
    local raidIcon = GetRaidIconFromFlags(destRaidFlags)
    local sourceNameFull = FormatNameWithRealm(sourceName, sourceGUID)

    if spellType == "Pet" then
        local ownerData = petOwnerCache[sourceGUID]
        if ownerData then
            sourceNameFull = sourceName .. " (" .. FormatNameWithRealm(ownerData.ownerName, ownerData.ownerGUID) .. ")"
        else
            if string_find(spellName, "Growl") then
                sourceNameFull = sourceName .. " (Unknown Hunter)"
            elseif string_find(spellName, "Torment") or string_find(spellName, "Suffering") then
                sourceNameFull = sourceName .. " (Unknown Warlock)"
            end
        end
    end

    local prefix = L["PREFIX_TAUNT"]
    if spellType == "Fear" then
        prefix = L["PREFIX_FEAR"]
    elseif spellType == "Pet" then
        prefix = L["PREFIX_PET"]
    elseif spellType == "Annoyance" then
        prefix = L["PREFIX_ANNOYANCE"]
    elseif spellInfo.data.aoe and isSuccess then
        prefix = L["PREFIX_TAUNT_AOE"]
    end

    local failAction = L["ACTION_MISSED"]
    if not isSuccess and missType then
        if missType == "IMMUNE" then
            failAction = L["ACTION_IMMUNE"]
        elseif missType == "RESIST" then
            failAction = L["ACTION_RESISTED"]
        end
        prefix = L["PREFIX_TAUNT_FAIL"]
    end

    if channel == "GROUP" and not (IsInGroup() or IsInRaid()) then
        channel = "SELF"
    end

    local hex = GetThemeColor(sourceGUID, spellName, spellInfo)
    local msg = ""

    if channel == "SELF" then
        if isSuccess then
            local action = L["ACTION_USED"]
            if destName then
                msg =
                    string_format(
                    L["FMT_SUCCESS_TARGET"],
                    hex,
                    prefix,
                    sourceNameFull,
                    action,
                    spellDisplay,
                    raidIcon,
                    destName,
                    L["BRAND_SUFFIX"]
                )
            else
                msg =
                    string_format(
                    L["FMT_SUCCESS_NO_TARGET"],
                    hex,
                    prefix,
                    sourceNameFull,
                    action,
                    spellDisplay,
                    raidIcon,
                    "",
                    L["BRAND_SUFFIX"]
                )
            end
        else
            local safeDest = destName or "Unknown Target"
            msg =
                string_format(
                L["FMT_FAIL"],
                hex,
                prefix,
                raidIcon,
                safeDest,
                failAction,
                sourceNameFull,
                spellDisplay,
                L["BRAND_SUFFIX"]
            )
        end
        print(msg)
    elseif channel == "GROUP" then
        if isSuccess then
            local action = L["ACTION_USED"]
            if destName then
                msg =
                    string_format(
                    L["CLEAN_SUCCESS_TARGET"],
                    prefix,
                    sourceNameFull,
                    action,
                    spellDisplay,
                    raidIcon,
                    destName,
                    L["BRAND_SUFFIX"]
                )
            else
                msg =
                    string_format(
                    L["CLEAN_SUCCESS_NO_TARGET"],
                    prefix,
                    sourceNameFull,
                    action,
                    spellDisplay,
                    raidIcon,
                    L["BRAND_SUFFIX"]
                )
            end
        else
            local safeDest = destName or "Unknown Target"
            msg =
                string_format(
                L["CLEAN_FAIL"],
                prefix,
                raidIcon,
                safeDest,
                failAction,
                sourceNameFull,
                spellDisplay,
                L["BRAND_SUFFIX"]
            )
        end
        SendSmartGroupMessage(msg)
    end
end
