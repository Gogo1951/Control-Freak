# Control Freak // Manual Test Plan

This is the manual test plan for Control Freak, the steps to confirm it works before a release is tagged. For what it does, see [README.md](https://github.com/Gogo1951/Control-Freak/blob/main/README.md); for how it works, see [README-Technical.md](https://github.com/Gogo1951/Control-Freak/blob/main/README-Technical.md).

## Before you start

**Run the whole list on Classic Era, then `/reload` and run it again on TBC Anniversary.** Steps are numbered continuously so you can report "failed on step N."

Gather these once so you aren't caught short mid-run:

- **This build installed on both clients**, in each client's own `Interface/AddOns` folder.
- **A warrior of level 26 or higher with a shield equipped.** Taunt, Mocking Blow, Challenging Shout, Intimidating Shout and Shield Bash cover every combat step you run yourself, and a warrior is the kind of tank the Bad Priests tab watches.
- **Saved settings written by 2026.09.04.A**, the previous release, for step 1. Don't clear your `WTF` folder before the run. On a client that never ran 2026.09.04.A, step 1 is an ordinary login.
- **A second player in your group** who swaps characters along the way: a priest for steps 7, 8 and 11, and a hunter or warlock with the pet's single-target taunt (Growl or Torment) on auto-cast for step 12. Any class that can melee works for everything else.
- **The Tank role.** Pick the Tank role in the group finder, or convert the group to a raid and set yourself as Main Tank. Steps say when to drop it and when to take it back. In a raid, every line this plan expects in party chat arrives in raid chat instead.
- **Mobs to fight:** elites at or a few levels above your level, because the taunt alerts ship counting only elites and bosses and a higher level makes resists and parries easier to produce; a pack of three or more for the shouts; and a mob that casts spells, for the interrupt.
- **Control Freak as your only enabled add-on** for step 14. You can turn the others back on after it.
- **A non-English client**, only for the optional step 25.

Unless a step says otherwise, be **out of combat** in the open world, grouped with your second player, and holding the Tank role.

**What this plan deliberately skips:** Cold Openers, Armor Debuffs, Novas and **Ignore Other Tanks** on the Tanking Tools tab; the Bad Shields whisper, which ships off; two clients both running Control Freak sending one whisper between them; Incapacitated's nine effect boxes; the middle rungs of the target dropdown and **While in Instances**; the item taunts (Target Dummies, Flash Bomb); and Season of Discovery's rune taunts.

## Verify this release's changes

These steps cover what changed since 2026.09.04.A, the last release.

**Upgrading from 2026.09.04.A**

**1.** Log in on a character whose saved settings were written by 2026.09.04.A. No Lua error window may appear, no red error text may print, and the welcome line must print unless you turned it off. Type `/freak` and read the category list on the left: **Control Freak** and, under it, **Taunts**, **Interrupts**, **Fears**, **Incapacitated**, **Tank Deaths**, **Bad Priests**, **Bad Pets**, **Tanking Tools**, **Profiles**, **Diagnostic Tools** and **Apology**, in that order. Open each feature tab: every dropdown must show a choice. Alert choices you made in the old version may come back at this release's defaults; that is intended, since the release does not convert them. Failure is an error window naming Control Freak, a missing or misplaced entry, a tab still named **Bad Pet**, or a dropdown showing blank.

**Shipped defaults**

**2.** Go to **Profiles** and click **Reset Profile**. Open **Tanking Tools** first: **Enable Tanking Tools** must be **unticked**, the one feature tab that ships off, with only its dropdown beside it and nothing drawn below it. Tick it, and leave it ticked for the rest of this plan. Then read every feature tab. Exactly five rows may read **Announce**: **My Failed Taunts**, **My AOE Taunts**, **My Successful Fears**, **My Long Incapacitation** and **My Death**. Every other row with that dropdown must be ticked and read **Print (Self Only)**. **Successful Taunts** and **Failed Taunts** must read **Elites & Bosses** beside their switches. **Whisper the Caster** on Bad Priests must be unticked, **Whisper the Pet Owner** on Bad Pets ticked at **1 Minute Cooldown**, and **Whisper the Culprit** on Tanking Tools ticked at **9 Second Cooldown**. **Cold Openers** must be the one unticked section on Tanking Tools, its rows hidden. Failure is any other row on Announce, which means a fresh install talks in group chat unasked, a ticked Whisper the Caster, Tanking Tools already ticked after the reset, or any other tab switched off.

**Role dropdown on every tab**

**3.** On each of the eight feature tabs, the Enable box must have a dropdown **on the same line**, offering exactly **As a Tank**, **As a Healer**, **As a Tank or Healer** and **Always**, in that order, each shown in full. It must read **As a Tank** on Bad Priests, **As a Tank or Healer** on Incapacitated and **Always** on the other six. Below the box, **While in Instances** must be unticked everywhere, and **When Group Has a Tank** must be ticked on Taunts, Bad Priests, Bad Pets and Tanking Tools and absent from the other four. Failure is a dropdown stranded on its own line under its label, a label cut short with an ellipsis, a fifth choice, or a tab with no dropdown.

**4.** Make sure **nobody** in your group holds the Tank role or Main Tank, then taunt an elite. **Nothing** may print and no sound may play, because Taunts ships with **When Group Has a Tank** ticked. Open **Diagnostic Tools**, tick **Enable Diagnostic Tools** and click **Read Alert Gate State**. The `taunts:` line must include `roleScope=ALWAYS groupHasTank=true` and end in `IsFeatureGateOpen=false`, and the report must say no tank was found by Main Tank assignment or group finder role. Take the Tank role and click the button again: that line must now end in `IsFeatureGateOpen=true`. Failure is a taunt alert while nobody is tanking, or a report that disagrees with what printed.

**The rebuilt alert block**

**5.** Open **Taunts**. Above the two ability lists it must draw exactly three alert sections, **Successful Taunts**, **Failed Taunts** and **AOE Taunts**, and no **Taunt Overwrites**, which this release removed. Read **Successful Taunts**: **Enable Notifications for Successful Taunts On** with a dropdown beside it listing **Everything**, **Elites & Bosses**, **Elites Your Level+ & Bosses** and **Bosses**, in that order; indented rows **My Successful Taunts** and **Others' Successful Taunts**, each with a dropdown offering exactly **Print (Self Only)** and **Announce**; **Always Alert on Marked Targets**, ticked; **Play Sound** with a sound picker and a small speaker; then one **Example:** line, a finished sentence naming a boss and ending in `// Control Freak`. **AOE Taunts** must have nothing beside its switch and no marked-targets row. Untick the Successful Taunts switch: its indented rows must vanish while the header, the description, the dropdown beside the switch and the Example stay. Failure is a label cut short, a dropdown wrapped onto its own line, rows that don't collapse, a fourth alert section, or an Example containing `%s`.

**6.** Re-tick that switch, set the dropdown beside it to **Bosses**, and taunt an unmarked elite that is not attacking you yet: **nothing** may print. Put a skull on a second elite and taunt it before it swings at you. Your window must print "Taunt! <your name> used [Taunt] on <skull icon> <mob>. // Control Freak", because a raid mark overrides the dropdown while **Always Alert on Marked Targets** is ticked. Set the dropdown back to **Elites & Bosses**. Failure is a line for the unmarked elite, or silence for the marked one.

**Incapacitated tab**

**7.** Have your second player, on the priest, duel you and cast **Psychic Scream** on you. One line must arrive as a **party-chat message from you**, reading "Tank Incapacitated for <seconds> seconds; <your name> is afflicted by [Psychic Scream] (Magic) from <priest>. // Control Freak", and Control Freak must not also print it as a plain line: an effect lasting at least the **4 Seconds** set under **Minimum for "Long" Incapacitation** answers to **My Long Incapacitation**, which ships on Announce. The Fears tab printing its own "AOE Fear! <priest> used [Psychic Scream]. // Control Freak" in your window is expected. Failure is no line, a printed copy of the Incapacitated line, a decimal in the seconds, or "an unknown caster" where the priest's name belongs.

**8.** On **Incapacitated**, set **Minimum for "Long" Incapacitation** to **10 Seconds**, set the dropdown beside **Enable Incapacitation Monitoring** to **Always**, and drop your Tank role. Have the priest duel you and cast Psychic Scream again. The Incapacitated line must now print in **your own window** and not go to party chat, and it must open on your class name: "Warrior Incapacitated for <seconds> seconds; ...". The AOE Fear line prints beside it, as in step 7. Put both dropdowns back and take the Tank role again. Failure is the line in party chat, a line opening on **Tank** while you hold no role, or no line at all.

**Tank Deaths tab**

**9.** Holding the Tank role, die. "Tank Down! <your name> has died. // Control Freak" must arrive once, as a **party-chat message from you**, with the **Control Freak: Failure 2** sound, and Control Freak must not also print it as a plain line. Release, drop the Tank role, and die again: no **Tank Down!** line may be sent or printed, because **My Death** reports only while you are tanking. Take the Tank role back. Failure is a printed copy of the line, no line while tanking, or a Tank Down! line for the death without the role.

**10.** On **Tank Deaths**, tick your second player's class under **Deaths by Class**, then have them die while they hold no role. Your window must print "<their class> Down! <their name> has died. // Control Freak", with no sound. Give them the Tank role and have them die again: your window must print "Tank Down! <their name> has died. // Control Freak" with the **Control Freak: Failure 2** sound, and **not** the class line as well. Failure is two lines for one death, a sound from the class line, or either line in party chat.

**Bad Priests tab**

**11.** With your health above 30%, have your second player, on the priest, cast **Power Word: Shield** on you. Your window must print "Bad Shield! <priest>'s [Power Word: Shield] on <your name>. // Control Freak", the **Control Freak: Magic 2** sound must play, and the priest must receive **no** whisper, because **Whisper the Caster** ships off. Failure is no line, no sound, or a whisper arriving.

**Bad Pets rename**

**12.** Have your second player switch to the hunter or warlock, with the pet's taunt on auto-cast, and send the pet at a mob. Your window must print "Bad Pet! <owner>'s pet <pet> used [<taunt>] on <mob>. // Control Freak", and the owner must receive exactly **one** whisper: "Your pet <pet> used [<taunt>] on <mob>. Right-click it to turn off auto-cast. // Control Freak". Let the pet taunt again within a minute: **nothing**, no line and no second whisper. Failure is no whisper, a second whisper inside the minute, or a whisper sent to you.

**Parries whisper and 9-second cooldown**

**13.** **Enable Tanking Tools** must still be ticked from step 2. Put a skull on an elite, pull it, and let it hit you. Have your second player, without the Tank role, stand beside you in front of it and melee it until it parries them. Your window must print "Parry Haste! <their name> is standing in front of <skull icon> <mob>. // Control Freak" with the **Control Freak: Parry** sound, and they must receive exactly **one** whisper: "Parry Haste! Please get behind <mob>: every parry speeds up its next swing. // Control Freak". Inside the tab, Parries ships switched on and counts only bosses, so the skull is what lets this elite through. A second parry within 9 seconds must add nothing. Failure is no line, no whisper, a whisper sent to you, or a second line or whisper inside those 9 seconds.

**Sounds and the sound library**

**14.** At the character select screen, open **AddOns**, disable every add-on except Control Freak, and log in. No error may appear. Open the **Play Sound** picker under **Successful Taunts**: it must list **None** and eighteen Control Freak sounds, in alphabetical order: AOE Taunt, Defeat, Failure, Failure 2, Failure 3, Failure 4, Fear, Game Over, Interrupt, Magic, Magic 2, Negative Beeps, Nova, Parry, Sad Trumpet, Tank Death, Taunt, Taunt Resist. Pick each in turn: every one must play the moment you pick it. Finish on **Control Freak: Taunt**, untick **Play Sound**, and click the speaker: it must still play. Re-tick Play Sound. **Run this step with Control Freak alone:** this release moved where the add-on loads its sound library from, and another add-on that ships the same library can hide a broken one. Failure is an error naming Control Freak or LibSharedMedia, a picker holding only None, or a sound that stays silent.

When steps 1-14 pass on both flavors, this release's changes are verified. Proceed to `4 - Pre-Launch Review Prompt.md`.

## Core checks

**15.** Log in with Control Freak enabled. No Lua error window may appear, no red error text may print, and a colored welcome line must read "Control Freak // Version ..." and say the settings live under Options > AddOns > Control Freak. Type `/reload`: the same must be true again. Failure is an error on either, a line containing `nil` or a stray `%s`, or no welcome line while **Enable Welcome Message** is ticked.

**16.** Open the options panel three ways: type `/freak`, the add-on's only slash command; **Shift + Middle-Click** the mini-map button; and press `Esc`, choose **Options**, then **AddOns**, and select **Control Freak**. All three must land **docked inside the Blizzard Options window**, with Control Freak selected in the category list on the left. Failure looks like either nothing happening at all, or a standalone window floating free of the Options frame. **TBC Anniversary is the client where this panel has historically floated free, so a run on Classic Era alone has not finished this step.**

**17.** Pull a mob, and while still in combat type `/freak`, then Shift + Middle-Click the mini-map button. Each must print "Control Freak // As a safety precaution, the Options Interface cannot be opened during combat." and the panel must **not** open. Kill the mob and wait: the panel must not open by itself once combat ends. Failure is the panel opening, silence with no message, or a red `ADDON_ACTION_BLOCKED` error.

**18.** Hover the mini-map button. The tooltip must show the add-on name and version, then **Control Freak** / **Enabled** with **Left-Click** / **Toggle**, **Bad Pets** / **Enabled** with **Right-Click** / **Toggle**, and last **Control Freak Options** / **Shift + Middle-Click**, with no Bad Priests block anywhere in it. With the options panel open, Right-Click must flip only Bad Pets, changing its state word in the tooltip and its **Enable** box on the panel, and **Shift + Left-Click** and **Shift + Right-Click** must do nothing at all. Left-Click must flip Control Freak to **Disabled**, remove the Bad Pets block from the tooltip, and untick **Enable Control Freak** under **All Alerts** on the main panel; while it is off, Right-Click must do nothing. Turn everything back on. Failure is a click doing something other than what the tooltip says, a Bad Priests block in the tooltip, the tooltip and the panel disagreeing, or state words reading On and Off.

**19.** Taunt an elite that is not attacking you yet. Your window must print "Taunt! <your name> used [Taunt] on <mob>. // Control Freak", with your name in your class color, the spell as a **clickable link**, and the **Control Freak: Taunt** sound. Let it hit you for a few seconds, then taunt it again: **nothing** may print, because a taunt on a mob already hitting you is a threat refresh rather than a save. Failure is no line on the pull, a line on the second taunt, or the spell name as plain text. **Classic Era is the client that hands back a plain name where a link belongs, so check the link there.**

**20.** Taunt an elite several levels above you until a taunt misses, is resisted, or hits something immune. The **Control Freak: Failure 4** sound must play, and one line must arrive as a **party-chat message from you**, as one complete sentence, such as "Taunt Failed! <your name>'s [Taunt] on <mob> was resisted. // Control Freak". An immune mob reads "Taunt Failed! <mob> is immune to <your name>'s [Taunt]. // Control Freak". The spell must be a working link, and a raid mark on the mob must show as its icon rather than as `{rt8}` text. Failure is a line that never arrives, a broken or half-rendered link, a second copy printed as a plain line, or a sound with no line anywhere to explain it.

**21.** Use **Challenging Shout** on a pack of three or more mobs, then **Intimidating Shout** on the same pack. Two lines must arrive, each exactly once, as **party-chat messages from you**: "AOE Taunt! <your name> used [Challenging Shout]. // Control Freak" and "AOE Fear! <your name> used [Intimidating Shout]. // Control Freak", because **My AOE Taunts** and **My Successful Fears** ship on Announce. Failure is a line repeated once per mob, a missing line after a shout that plainly landed, or a second copy printed as a plain line.

**22.** Interrupt a casting mob with **Shield Bash**. Your window must print "Interrupt! <your name>'s [Shield Bash] on <mob> stopped [<the spell it was casting>]. // Control Freak", with the stopped spell named. **Classic Era is the client that reports the stopped spell without an id, so check this there.** Failure is the end of the line reading "an unknown spell" or `[0]`.

**23.** On **Taunts**, read **AOE Taunt Abilities**, and on **Fears**, read **Fear Abilities**. The Paladin row **Righteous Defense** must appear under AOE Taunt Abilities **on TBC Anniversary and be absent on Classic Era**, and the Paladin row under Fear Abilities must read **Turn Undead** on Classic Era and **Turn Evil** on TBC Anniversary, a renamed ability rather than a broken one. Hover any row: the game's own spell tooltip must appear. Untick **Mocking Blow** under Taunt Abilities and use it on an elite that is not attacking you yet: **no** alert may fire. Re-tick it. Failure is a row for an ability this client does not have, a row labelled with a number or a blank, or an alert from an unticked ability.

**24.** Type `/reload` and open **Diagnostic Tools**. Only two things may show: the warning paragraph and **Enable Diagnostic Tools**, unticked, even though you ticked it in step 4. Tick it, and these sections must appear without reopening the panel: Event Log, Event Registration, API Endpoints, Alert Gate, Display Context, Validate Data: Data/Abilities.lua, Validate Data: Data/Data.lua, Other Add-ons, Saved Variables, Library Versions, Taint Log and External Tools. Failure is the box still ticked after the reload, report buttons showing before you tick it, or a missing section.

**25.** *Optional, and only worth running on a non-English client.* Log in on one, read the options panel, and set off one taunt line, one Incapacitated line and one Tank Deaths line. Every label, description and Example line must render in that language with no raw keys showing, such as `TAUNTS_SUMMARY` where words belong, and each alert must read as one complete sentence with the name, spell, mob and seconds in sensible places: no `nil`, no stray `%s` or `%d`, and no value appearing twice. Two things are **not** failures: the **Diagnostic Tools** and **Apology** panels are deliberately English everywhere, and a translation that reorders the sentence is intended as long as it is grammatical.

When every step passes on both Classic Era and TBC Anniversary, manual testing is complete. Proceed to `4 - Pre-Launch Review Prompt.md`.
