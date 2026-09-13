local _, ns = ...

local L = ns.L

local function Feature()
	return ns.db.profile.badPets
end

local function Section()
	return ns.db.profile.badPets.alert
end

function ns.BuildBadPetsOptions()
	local args = {}
	local hidden = ns.AddFeatureScope(args, Feature, "BAD_PETS_SUMMARY", "BAD_PETS_ENABLE", 1, "badPets")

	--[[
	    One pet, one growl, one mob for both examples: the line the group sees and
	    the whisper its owner gets describe the same event.
	]]
	local GROWL = ns.SampleSpell(2649, "Growl")
	local BOSS = ns.SampleBoss()

	--[[
	    The whose shape with the full block: a pet's growl lands on one mob, so the
	    target ladder and the mark apply. The My row is the player's own pet, which
	    the locale already has lines for (BAD_PET_OWN); the whisper below never goes
	    to yourself, whatever that row says.
	]]
	ns.AddWhoseAlertSection(args, "alert", Section, 20, hidden, {
		headerKey = "BAD_PETS_ALERT_HEADER",
		enableKey = "BAD_PETS_ALERT_ENABLE",
		descKey = "BAD_PETS_ALERT_DESC",
		mineKey = "BAD_PETS_ALERT_MINE",
		othersKey = "BAD_PETS_ALERT_OTHERS",
		sample = {
			key = "BAD_PET",
			args = { ns.SAMPLE_OTHER, ns.SAMPLE_PET, GROWL, BOSS },
		},
		--[[
		    The whisper goes to the pet's owner rather than into the player's own
		    window or the group's chat, so it is not one of the alert's outputs: it
		    sits below the block's example, at the section's own indent, with an
		    example of its own -- the same pet, the same mob, as the owner would
		    read it.
		]]
		afterSample = function(rowArgs, order, rowsHidden)
			ns.AddWhisperRow(rowArgs, "badPets", order, rowsHidden, {
				labelKey = "BAD_PETS_WHISPER_ENABLE",
				descKey = "BAD_PETS_WHISPER_ENABLE_DESC",
				cooldownDescKey = "BAD_PETS_COOLDOWN_DESC",
				cooldowns = ns.BAD_PET_COOLDOWNS,
				sample = { key = "BAD_PET_WHISPER", args = { ns.SAMPLE_PET, GROWL, BOSS } },
				getWhisper = function()
					return Feature().whisper
				end,
				setWhisper = function(_, value)
					Feature().whisper = value
				end,
				getCooldown = function()
					return ns.ResolveChoice(Feature().cooldown, ns.BAD_PET_COOLDOWNS, ns.BAD_PET_COOLDOWN_DEFAULT)
				end,
				setCooldown = function(_, value)
					Feature().cooldown = value
				end,
			})
		end,
	})

	ns.AddGatedHeader(args, "abilities", "BAD_PETS_ABILITIES_HEADER", 40, hidden, true)

	for key, value in
		pairs(ns.BuildAbilityToggles({
			categories = { PET_TAUNT = true },
			order = 45,
			hidden = hidden,
		}))
	do
		args[key] = value
	end

	return {
		type = "group",
		name = L["TAB_BAD_PETS"],
		args = args,
	}
end
