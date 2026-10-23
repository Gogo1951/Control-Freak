local _, ns = ...

local L = ns.L

local function Feature()
	return ns.db.profile.interrupts
end

local function Section()
	return ns.db.profile.interrupts.alert
end

function ns.BuildInterruptsOptions()
	local args = {}
	local hidden = ns.AddFeatureScope(args, Feature, "INTERRUPTS_SUMMARY", "INTERRUPTS_ENABLE", 1, "interrupts")

	--[[
	    The whose shape, the same block the Taunts tab draws: the target ladder
	    beside the switch, a row for the player's own casts and one for everybody
	    else's, the mark, the sound. The Example interrupts with the player's
	    own class's interrupt, or Fathom's Kick on the Others' row for a class
	    with none (ns.SampleCaster).
	]]
	local caster, kick, row = ns.SampleCaster("INTERRUPT", "ROGUE")
	ns.AddWhoseAlertSection(args, "alert", Section, 20, hidden, {
		headerKey = "INTERRUPTS_ALERT_HEADER",
		enableKey = "INTERRUPTS_ALERT_ENABLE",
		descKey = "INTERRUPTS_ALERT_DESC",
		mineKey = "INTERRUPTS_ALERT_MINE",
		othersKey = "INTERRUPTS_ALERT_OTHERS",
		sample = {
			key = "INTERRUPT",
			row = row,
			args = {
				caster,
				kick,
				ns.SampleTarget(),
				ns.SpellPart(ns.SAMPLE_SPELL_IDS.SHADOW_BOLT),
			},
		},
	})

	--[[
	    No ability list: the combat log reports an interrupt and the spell it
	    stopped directly, whatever ability did it.
	]]

	return {
		type = "group",
		name = L["TAB_INTERRUPTS"],
		args = args,
	}
end
