local _, ns = ...

local L = ns.L

local function Feature()
	return ns.db.profile.badPet
end

local function Section()
	return ns.db.profile.badPet.alert
end

function ns.BuildBadPetOptions()
	local args = {}
	local hidden = ns.AddFeatureScope(args, Feature, "BAD_PET_SUMMARY", "BAD_PET_ENABLE", 1, "badPet")

	ns.AddAlertSection(args, "alert", Section, 20, hidden, {
		headerKey = "BAD_PET_ALERT_HEADER",
		enableKey = "BAD_PET_ALERT_ENABLE",
		descKey = "BAD_PET_ALERT_DESC",
		-- Nobody turns this on to hear about their own; it is a report on the group.
		noScope = true,
		sample = {
			key = "BAD_PET",
			args = {
				ns.SAMPLE_OTHER,
				ns.SAMPLE_PET,
				ns.SampleSpell(2649, "Growl"),
				ns.SampleBoss(),
			},
		},
		-- The whisper goes to the pet's owner rather than into the player's own
		-- window or the group's chat, so it sits beside the alert, not under it.
		extraRow = function(rowArgs, order)
			ns.AddWhisperRow(rowArgs, "badPet", order, hidden, {
				labelKey = "BAD_PET_WHISPER_ENABLE",
				descKey = "BAD_PET_WHISPER_ENABLE_DESC",
				cooldownDescKey = "BAD_PET_COOLDOWN_DESC",
				cooldowns = ns.BAD_PET_COOLDOWNS,
				getWhisper = function()
					return Feature().whisper
				end,
				setWhisper = function(_, value)
					Feature().whisper = value
				end,
				getCooldown = function()
					return Feature().cooldown
				end,
				setCooldown = function(_, value)
					Feature().cooldown = value
				end,
			})
		end,
	})

	ns.AddGatedHeader(args, "abilities", "BAD_PET_ABILITIES_HEADER", 40, hidden, true)

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
		name = L["TAB_BAD_PET"],
		args = args,
	}
end
