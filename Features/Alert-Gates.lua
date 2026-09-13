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
local function FeatureCouldFire(feature)
	if not feature or not feature.enabled then
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

function ns:IsFeatureGateOpen(feature)
	if not FeatureCouldFire(feature) then
		return false
	end
	if not PassesRoleFilter(feature) then
		return false
	end
	if feature.groupHasTank and not ns.GroupHasTank() then
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

function ns:UpdateCombatLogRegistration()
	if ns:IsAlertGateOpen() then
		ns.eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	else
		ns.eventFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end
end
