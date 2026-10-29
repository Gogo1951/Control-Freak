local _, ns = ...

--------------------------------------------------------------------------------
-- Alert Gate
--------------------------------------------------------------------------------

--[[
    Scope is per feature, so each tab decides for itself, and which questions a
    tab asks comes from ns.FEATURE_SCOPE_OPTIONS -- a feature that never asks one
    stores no key for it, and the checks below read as false rather than needing
    a per-feature branch here.

    The seat questions -- roleScope and groupHasTank -- are checked in
    ns:IsFeatureGateOpen but deliberately NOT in the registration test below.
    They read the raid's Main Tank assignment and the group finder's role, and
    while the role has PLAYER_ROLES_ASSIGNED behind it, the assignment fires
    nothing reliable, so a registration keyed on them could still leave the combat
    log unhooked with no event to put it right. Zone has an event that fires, so it
    can gate registration and save the work when nothing could match.
]]
--[[
    Whether the General panel's group switch over this feature is on
    (ns.FEATURE_GROUPS). A feature in no group answers yes. Anything but a
    stored false is on, so a profile saved before the groups existed fires as
    it did.
]]
function ns.IsFeatureGroupOn(featureKey)
	local group = ns.FEATURE_GROUP_OF[featureKey]
	if not group then
		return true
	end
	local groups = ns.db.profile.featureGroups
	return not groups or groups[group.key] ~= false
end

--[[
    The gates are handed the feature's table rather than its key, so the key is
    found by identity. Ten comparisons at most, which is nothing beside the
    seat questions the gate asks next.
]]
local function FeatureGroupIsOn(feature)
	local profile = ns.db.profile
	for featureKey in pairs(ns.FEATURE_GROUP_OF) do
		if profile[featureKey] == feature then
			return ns.IsFeatureGroupOn(featureKey)
		end
	end
	return true
end

local function FeatureCouldFire(feature)
	if not feature or not feature.enabled then
		return false
	end
	if not FeatureGroupIsOn(feature) then
		return false
	end
	if feature.instanceOnly then
		local inInstance, instanceType = IsInInstance()
		if not inInstance or (instanceType ~= "party" and instanceType ~= "raid") then
			return false
		end
	end
	return true
end

--[[
    Which seat the player has to be in, from the ns.ROLE_SCOPES ladder.

    A feature that never asks stores no roleScope key, so the nil answers the
    question rather than needing a per-feature branch -- the same arrangement
    every other scope key here relies on. Every tab asks today, so nothing
    exercises that branch; it stays because it is the contract
    ns.FEATURE_SCOPE_OPTIONS is built on, not because a caller needs it. Do not
    fold it into ResolveChoice's default: nil means "not asked" and has to stay
    distinguishable from a stored rung.

    TANK_HEALER is an OR rather than an AND, which is the only reading that
    works: nobody is tanking and healing at once, so an AND would make the widest
    seat rung mean "never".

    ResolveChoice rather than a raw read, so a profile carrying a rung this
    version no longer offers lands on ALWAYS instead of matching nothing and
    silencing the tab.
]]
local function PassesRoleFilter(feature)
	if not feature.roleScope then
		return true
	end
	local scope = ns.ResolveChoice(feature.roleScope, ns.ROLE_SCOPES, ns.ROLE_SCOPE_DEFAULT)
	if scope == "ALWAYS" then
		return true
	end
	if scope ~= "HEALER" and ns.IsPlayerTank() then
		return true
	end
	if scope ~= "TANK" and ns.IsPlayerHealer() then
		return true
	end
	return false
end

--[[
    skipTankCheck lets one alert through the tab's groupHasTank: an AOE taunt,
    a maintainer decision, since the press that matters most comes the moment
    the tank dies, which is exactly when the group stops having one.
]]
function ns:IsFeatureGateOpen(feature, skipTankCheck)
	if not FeatureCouldFire(feature) then
		return false
	end
	if not PassesRoleFilter(feature) then
		return false
	end
	if not skipTankCheck and feature.groupHasTank and not ns.GroupHasTank() then
		return false
	end
	return true
end

function ns:IsAlertGateOpen()
	local profile = ns.db and ns.db.profile
	if not profile or not profile.enabled then
		return false
	end
	for _, key in ipairs(ns.FEATURE_KEYS) do
		if FeatureCouldFire(profile[key]) then
			return true
		end
	end
	return false
end
