local _, ns = ...

local GetColor = ns.GetColor

--[[
    TEMPORARY -- REMOVE AFTER 2026-12-03 (90 days from 2026-09-04).

    A one-off note to the people who put up with the add-on before the rebuild.
    It has an expiry date, and a panel apologising for bugs nobody has hit in
    three months is worse than no panel at all.

    Deliberately NOT in Locales/enUS.lua. Everything else the add-on shows is
    interface copy a translator should carry; this is one person's letter in their
    own voice, dated and disposable, and putting it in the locale would ask
    eleven translators to do work that gets deleted.

    TO REMOVE, in this order:
      1. Delete this file.
      2. Drop its line from Control-Freak.toc.
      3. Drop Apology from ns.OPTIONS_REGISTRY in Data/Data.lua.
      4. Drop its two lines from ns.RegisterOptionsPanels in Options/Options.lua.

    Nothing else reads it. It stores no settings, registers no events, and holds
    no state, so those four edits are the whole removal.
]]

ns.APOLOGY_TAB_NAME = "Apology"

local PARAGRAPHS = {
	"Hey Guys,",
	"A quick note for anyone who's been using this add-on over the past 9 months.",
	"I originally made it for a buddy and released it way too early, while it was still very much a proof of concept. Given the number of bugs, I honestly can't imagine many of you stuck around this long. =P",
	"Most of what this add-on does, I was already handling with WeakAuras, so keeping it updated wasn't exactly a high priority for me. But after getting another report of the same bug for what I think was the 19th time, I finally decided it was time to get a little less lazy.",
	"I've spent some time cleaning things up, fixing the recurring problems, and getting it into a state where I can actually support it properly.",
	"That said, please still consider this a beta. There are almost certainly things I haven't caught yet, and feedback of any kind is genuinely welcome. If something isn't working, please report it. If something is confusing, let me know. And if there's something you'd like the add-on to do, tell me that too.",
	"The more feedback I get, the better I can make it. Even the stuff that seems obvious or minor can help uncover problems I haven't run into myself.",
	"I'll do my best to keep it maintained and continue improving it going forward.",
}

-- Two blank lines between the sign-off and the signature, the way it was written.
-- Name and date are muted: a signature is not body copy.
local CLOSING = "Cheers!"
local SIGNATURE = { "Gogo", "September 2026" }

function ns.BuildApologyOptions()
	local args = {}
	local order = 1

	--[[
	    No header. AceConfigDialog already draws "Apology" at the top of the page,
	    and one repeating it reads as the title printed twice -- the same reason
	    every feature tab opens on its summary instead.
	]]
	for index, text in ipairs(PARAGRAPHS) do
		args["paragraph" .. index] = ns.OptionsDesc(text, order)
		args["paragraphSpace" .. index] = ns.OptionsSpacer(order + 1)
		order = order + 2
	end

	args.closing = ns.OptionsDesc(CLOSING, order)
	args.closingSpace1 = ns.OptionsSpacer(order + 1)
	args.closingSpace2 = ns.OptionsSpacer(order + 2)
	order = order + 3

	for index, line in ipairs(SIGNATURE) do
		args["signature" .. index] = ns.OptionsDesc(GetColor("MUTED") .. line .. "|r", order)
		order = order + 1
	end

	return {
		type = "group",
		name = ns.APOLOGY_TAB_NAME,
		args = args,
	}
end
