# Control Freak // Manual Test Plan

This is the manual test plan for Control Freak, the steps to confirm it works before a release is tagged. For what it does, see [README.md](https://github.com/Gogo1951/Control-Freak/blob/main/README.md); for how it works, see [README-Technical.md](https://github.com/Gogo1951/Control-Freak/blob/main/README-Technical.md).

## Before you start

**Run the whole list on Classic Era, then `/reload` and run it again on TBC Anniversary.** Steps are numbered continuously so you can report "failed on step N."

Gather these once so you aren't caught short mid-run:

- **A warrior.** This is the character that covers most of the plan: Taunt and Mocking Blow for single-target taunts, Challenging Shout for the AoE taunt, Intimidating Shout for a fear, and Shield Bash for the interrupt. A druid works nearly as well (Growl, Challenging Roar), but you will need something else for the interrupt.
- **A hunter or warlock with a pet**, and the pet's taunt on auto-cast — Growl for a hunter, Torment or Suffering for a warlock. Steps 7 and 8 need one.
- **A second player**, for the steps where a message leaves your own window: 7, 8, 16, and 17. Step 16 needs them to have a taunt of their own — a warrior's Taunt, a druid's Growl, a hunter's Distracting Shot — and step 8 needs Control Freak installed on their client too.
- **Your existing saved settings from the previous release.** Step 1 checks that upgrading over them is clean, so do **not** clear your `WTF` folder before this run.
- **Something to fight** — any mob you can pull, taunt, and be missed by. A mob a few levels above you makes the failed-taunt and cold-opener steps much easier to produce.
- **A non-English client** — only for the optional spot-check in step 25.

Unless a step says otherwise, be **out of combat** and standing in the open world.

**What this plan deliberately skips:** the Armor Debuffs report, the Parry warning, and the Nova alert on the Tanking Tools tab (each needs a specific class or a partner standing in the wrong place), the "Only When Playing a Tank" and "Only While in Instances" scopes, and the item taunts (Target Dummies, Flash Bomb). Everything else the add-on ships is covered below.

## Verify this release's changes

This release is a full rebuild. The previous version was a handful of files behind one flat settings page; this one is a feature-per-tab add-on with a mini-map button, profiles, sounds, whispers, a diagnostics panel, and eleven languages. These nine steps check the parts that did not exist before, or that changed shape entirely.

**Upgrading from the old version**

**1.** Log in on a character that ran the previous release, with its old saved settings still on disk. No Lua error window may appear and no red error text may print. The welcome line must print, a **mini-map button must appear** where there was none before, and `/freak` must open a working settings panel. Failure is an error window naming Control Freak, a panel that opens blank, or settings that show empty dropdowns and unticked boxes where the defaults in step 5 belong — all three mean the old saved file is not being read safely.

**The rebuilt settings panel**

**2.** Type `/freak` and read the category list on the left. Nine entries must be there, in this order: **Control Freak**, **Taunts**, **Interrupts**, **Fears**, **Bad Pet**, **Tanking Tools**, **Profiles**, **Diagnostic Tools**, **Apology**. Failure is a missing entry, a different order, or an entry nested under the wrong parent. (The Apology tab is a dated one-off note and is meant to be last.)

**3.** Open all nine in turn. Each must open without an error and read as sentences and labels in your language. Failure is a raw key showing through — text like `TAUNTS_SUMMARY` or `ALERT_PRINT_DESC` on screen instead of words — a blank where a label belongs, the word `nil`, or a stray `%s`.

**Alert blocks and their defaults**

**4.** On the **Taunts** tab, find **Successful Taunts**. It must read: a gold header, a description, an **Enable Successful Taunt Notifications** box, then four indented rows — **Print Out Notifications** with a Mine/All dropdown, **Announce to Group** with a Mine/All dropdown, **Only Against Bosses & Elites**, and **Sound** with a sound picker and a small speaker beside it — and last an **Example:** line showing a finished sentence naming a boss. Untick the Enable box: the four indented rows must vanish while the header, description, and Example stay. Failure is rows that don't collapse, a dropdown stranded on its own line below its label, or an Example line containing `%s`.

**5.** Go to **Profiles** and click **Reset Profile**, then read the tabs. **Enable Control Freak** must be ticked; Taunts, Interrupts, Fears, and Bad Pet must be enabled; **Tanking Tools must be off**; and every **Announce to Group** must be unticked *except* the one on **Failed Taunts**, which ships ticked with its own **Print Out Notifications** unticked. Failure is any other combination — Tanking Tools arriving switched on, or an Announce ticked where it shouldn't be, means a fresh install talks to other people's chat without being asked.

**6.** Open any Sound picker. It must offer **None** and all seven Control Freak sounds — Taunt, Taunt Resist, AOE Taunt, Interrupt, Fear, Nova, Parry — and choosing one must play it immediately. (Sounds from your other add-ons appear in the same list by design; that is not a failure.) Now untick that block's **Sound** box and click the speaker beside the picker — it must still play. Failure is silence from either, one of the seven missing, or an error.

**Whispers to other players**

**7.** Group with your second player, have them put their pet's taunt on auto-cast, and untick **Only When Group Has a Tank** on the **Bad Pet** tab so the alert can fire without a tank present. When the pet taunts, a **Bad Pet!** line must print in your window and the owner must receive **exactly one** whisper explaining how to switch auto-cast off. Let the pet taunt again within thirty seconds: **nothing** may happen — no print, no second whisper. Failure is a repeated whisper, a whisper sent to yourself, or no whisper at all.

**8.** With Control Freak running on **both** clients in that group, trigger the same pet taunt again. The owner must still receive **exactly one** whisper, not two. Failure is two whispers arriving within a second of each other, which means the two clients aren't agreeing on who sends.

**Tanking Tools, the new tab**

**9.** Open **Tanking Tools**. With its enable off, the tab must show only its own **Enable Tanking Tools** box. Tick it: four sections must appear — **Cold Openers**, **Armor Debuffs**, **Parries**, **Novas** — with **Whisper Culprit** ticked under Parries and **Only Against Bosses & Elites** ticked under Cold Openers and Armor Debuffs. Now untick **Only Against Bosses & Elites** under Cold Openers, attack an ordinary mob, and keep using abilities until one is dodged, parried, blocked, or missed in the first few seconds. A **Careful!** line must print naming your ability and the mob. Failure is the sections showing while the tab is off, the tab arriving switched on, or no line after an ability plainly missed at the start of a fight.

When steps 1–9 pass on both flavors, this release's changes are verified. Finish the core checks below, then proceed to `4 - Pre-Launch Review Prompt.md`.

## Core checks

**10.** Log in with Control Freak enabled. No Lua error window may appear and no red error text may print, and a coloured welcome line must read *"Control Freak // Version …"* and tell you the settings live under Options > AddOns > Control Freak. Type `/reload` — the same must be true again. Failure is an error on either, a line containing `nil` or a stray `%s`, or no welcome line while **Enable Welcome Message** is ticked.

**11.** Open the settings three ways: type `/freak`; **Shift + Middle-Click** the mini-map button; and press `Esc` → **Options** → **AddOns** → **Control Freak**. All three must land **docked inside the Blizzard Options window**, with Control Freak selected in the category list on the left. Failure looks like either nothing happening at all, or a standalone window floating free of the Options frame. **This step is flavor-sensitive — TBC Anniversary is the client where the panel has historically floated free — so a tester who ran only Era has not finished this step.** `/freak` is the add-on's only slash command.

**12.** Pull a mob, and while still in combat type `/freak`, then Shift + Middle-Click the mini-map button. Each must print *"Control Freak // As a safety precaution, the Options Interface cannot be opened during combat."* and the panel must **not** open. Kill the mob and wait — the panel must not open by itself once combat ends. Failure is the panel opening, silence with no message, or a red `ADDON_ACTION_BLOCKED` error.

**13.** Hover the mini-map button. The tooltip must show the add-on name and version, then **Control Freak — On** with **Left-Click / Toggle** under it, then **Bad Pet — On** with **Right-Click / Toggle**, then **Control Freak Options** with **Shift + Middle-Click**. Left-click: Control Freak must flip to **Off** in the tooltip, the Bad Pet block must disappear from the tooltip entirely, and right-clicking must now do nothing. Left-click again to turn it back on, and confirm each toggle moves the matching box on the open settings panel without a `/reload`. Then untick **Enable Mini-map Button** on the main tab — the button must vanish; re-tick it, drag it to a new spot on the mini-map ring, and `/reload`: it must come back **in the spot you dragged it to**. Failure is a click doing something other than what the tooltip says, the tooltip and the panel disagreeing, a hidden button reappearing after a reload, or the button snapping back to its old position.

**14.** On the **Taunts** tab, untick **Only When Group Has a Tank** so alerts can fire while you are solo. Now **pull a mob with the taunt itself**, before it has swung at anybody. Your window must print *"Taunt! <your name> used [Taunt] on <mob>! // Control Freak"*, with your name in your class colour, the spell as a **clickable link**, and the taunt sound playing. Let it melee you for a few seconds, then taunt it again: **nothing** must print — a taunt on a mob already hitting you is a refresh, not a save. Failure is no line on the pull, a line on the second taunt, or a spell name in plain text where a link belongs.

**15.** Re-tick **Only When Group Has a Tank** and taunt again while solo. **Nothing** must happen — that gate is on by default and nobody solo is tanking. Then open **Diagnostic Tools** → tick **Enable Diagnostic Tools** → **Read Alert Gate State**: the report must say `taunts: enabled=true … groupHasTank=true … IsFeatureGateOpen=false` and name that no tank was found. Failure is alerts still firing with no tank, or a report claiming the gate is open while nothing prints. This is the single most common "it's broken" report, and this step is how you tell the two apart. **Untick the gate again and leave it off through step 24**, then re-tick it when you are finished.

**16.** Group with your second player and set the dropdown beside **Print Out Notifications** on **Successful Taunts** to **Mine**. Have them taunt something: **nothing** may print in your window and no sound may play. Set the dropdown back to **All** and have them taunt again: their taunt must now print, named for them. Failure is Mine showing other people's casts, or All showing nothing.

**17.** Still grouped, taunt a mob several levels above you until one of your own taunts misses, resists, or hits something immune. The failure sound must play, **nothing** may print in your own window, and a **Taunt Failed!** line must arrive in **party chat** — one complete sentence ending in *"// Control Freak"*, with the spell as a working link and any raid mark on the mob rendering as the icon rather than as `{rt4}` text. Failure is a broken or half-rendered line, a line that never arrives, or the same alert appearing twice because it both printed and announced.

**18.** Use Challenging Shout (or Challenging Roar) on a group of three or more mobs. Exactly **one** *"AOE Taunt!"* line must print, not one per mob. Failure is three identical lines in the same instant.

**19.** Interrupt a casting mob (Shield Bash, Kick, Earth Shock). The line must read *"Interrupt! <name> used [Shield Bash] on <mob> to stop [the spell it was casting]!"* — with the **stopped spell named**. **This step is flavor-sensitive — Classic Era is the client that reports the stopped spell without an id**, so Era is where this breaks. Failure is the last part of the line reading *"an unknown spell"* or `[0]`.

**20.** Fear a mob. A line must print naming the caster and the spell — *"Fear!"* for a single-target fear like a warlock's Fear, *"AOE Fear!"* for one that hits everything around it like Intimidating Shout or Psychic Scream. Now fear something that resists or is immune: **nothing** may print — only a fear that actually landed is reported. Failure is a line on a resist, no line on one that plainly landed, or an AoE fear reported as a single-target one.

**21.** On the **Taunts** tab, scroll to **Taunt Abilities** and hover a row — the game's own spell tooltip must appear. Untick one ability you can actually use (Mocking Blow, say), then use it: **no alert** may fire, while your other taunts still do. Re-tick it and confirm it reports again. Failure is unticking doing nothing, or unticking one ability silencing another.

**22.** Read the ability lists on the **Taunts** and **Fears** tabs. They show only abilities this client has, which differs by flavor: the Paladin row **Righteous Defense** must appear under **AOE Taunt Abilities on TBC Anniversary and must be absent on Classic Era**, and the Paladin row under **Fear Abilities** correctly reads *Turn Undead* on Era and *Turn Evil* on Anniversary — a renamed ability, not a broken one. Failure is a row for an ability this client does not have, an empty list under a heading, or a row whose label is a spell id or a blank instead of a name.

**23.** Log in fresh and open **Diagnostic Tools**. Only two things may be visible: the warning paragraph and **Enable Diagnostic Tools**, which must be **off**. Tick it — the sections must appear without reopening the panel: Event Log, Event Registration, API Endpoints, Alert Gate, Display Context, Validate Data (one per data file), Other Add-ons, Saved Variables, Library Versions, Taint Log, External Tools. Now `/reload` and reopen: the toggle must be **off** again, because diagnostics never persists. Failure is the toggle on by default, report buttons visible before you enable anything, or diagnostics surviving a reload.

**24.** With diagnostics enabled, click **Start Event Log**, go and land a taunt that printed, come back and click **Show Captured Events**. The report must open with a header naming Control Freak, its version, and your client, and must contain a line for the taunt you cast, naming you, the mob, and the outcome. It must **not** contain a wall of raw combat traffic — every swing in the zone is deliberately kept out, and anything the add-on counted rather than logged appears only as a **Suppressed uncorrelated traffic** summary at the very end. Click **Stop Event Log**, then **Show Captured Events** again: it must read **(no events captured)**. Failure is an empty report after a taunt that demonstrably printed, the log flooded with combat lines, or old entries surviving a stop.

**25.** *Optional, and only worth running on a non-English client.* Log in on one and read the settings panel and one alert of each kind. Every label, description, and Example line must render in that language with no raw keys showing, and each alert must read as one complete sentence with the player name, spell, and target in sensible places — no `nil`, no stray `%s`, no value appearing twice. Two things are **not** failures: the **Diagnostic Tools** panel is deliberately English everywhere, and a translation that reorders the sentence is intentional as long as it is grammatical.

When every step passes on both Classic Era and TBC Anniversary, manual testing is complete. Proceed to `4 - Pre-Launch Review Prompt.md`.
