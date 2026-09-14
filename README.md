# Control Freak

Combat announcer for taunts, interrupts, fears, tank deaths, bad pets, parries, armor debuffs, and other critical fight events. Track who taunted, what failed, who interrupted a cast, and what happened with customizable alerts.

**TL;DR:** Tells you what happened, who caused it, and what needs fixing while the fight is still happening. Less combat-log archaeology after the wipe, more information when it matters, so you can make better decisions and have cleaner runs.

## Features

🛡️ **Taunts, Interrupts & Fears** // Know when a mob changes hands, whether a taunt landed or failed, who stopped a cast, and whose fear just scattered the pull.

😵 **Incapacitated & Tank Deaths** // Call out dangerous stuns, fears, silences, roots, and other loss-of-control effects with the spell, caster, duration, and dispel type. Get an immediate warning when a tank goes down.

🐕 **Bad Pets & Bad Shields** // Catch hunter and warlock pets taunting with Growl or Torment enabled, and warn when Power Word: Shield prevents a warrior or druid tank from generating rage. Optional whispers tell the culprit how to fix it.

🎛️ **Your Alerts, Your Rules** // Control where every alert appears, which enemies count, when each tab speaks, whether marked targets always trigger, and which sound plays. Filter alerts by role, dungeon or raid, and whether your group has a living tank.

🦺 **Quiet by Default** // Most alerts stay in your own window until you decide otherwise. Group announcements stay quiet when you're ungrouped or in PvP, and one-time whispers prevent the same mistake from becoming a chorus of messages.

## Setup

1. Install the add-on, ideally using [CurseForge](https://www.curseforge.com/wow/addons/control-freak) or [Wago](https://addons.wago.io/addons/control-freak).
2. Type `/freak`, or Shift + Middle-Click the mini-map button, to open the Options Interface.
3. Walk the tabs. Every tab but Tanking Tools is on out of the box, and most lines print only to your own window.
4. Decide what your group hears. Four of your own lines announce out of the box, because the group needs them the moment they happen: a failed taunt, an AoE taunt, a fear you cast, and a long incapacitation.
5. Narrow each tab to when it matters, like only while you're tanking or only inside dungeons and raids.
6. *"When you do things right, people won't be sure you've done anything at all."*

## How It Works

### Every Alert Works the Same Way

Plenty of add-ons and WeakAuras already handled announcements, but each had its own interface and its own filter settings. Wanting a callout only on bosses, or only while you're tanking or healing, meant hunting for that option in every one of them, when it existed at all. Control Freak brings those great ideas under one roof, with one consistent layout and plenty of easy settings: every alert on every tab is built from the same block, so once you've set one, you know how to set them all.

- **Enable Alerts** // The alert's own switch. An alert aimed at one mob carries the enemies it counts beside it: Everything, Elites & Bosses, Elites Your Level+ & Bosses, or Bosses. Each choice includes the ones after it, and since a dungeon boss carries no skull, the third choice is the one that keeps it while dropping the lower-level trash around it.
- **My and Others' Rows** // Your own casts, your pet's included, and everybody else's in your group. Each row says where its line goes: Print (Self Only) or Announce.
- **Always Alert on Marked Targets** // A mob carrying a raid mark always counts, whatever the enemy choice says. On by default.
- **Play Sound** // Control Freak's own sounds, plus any your other add-ons share.
- **Example** // Every block shows a sample of exactly what your group would see.

A few alerts bend the block. Incapacitated splits its rows into short and long, Tank Deaths into your own death and other tanks', and Bad Shields and Armor Debuffs report through a single row. Bad Pets, Bad Shields, and Parries can also whisper the person responsible, once per cooldown.

Above its alerts, each tab asks when it should speak at all: which seat you're in (As a Tank, As a Healer, As a Tank or Healer, or Always), whether you're inside a dungeon or raid, and on Taunts, Bad Priests, Bad Pets, and Tanking Tools, whether the group has a living tank.

### What the Lines Look Like

Printed or announced, a line leads with the news and ends with the add-on's name. Spells are real links, and a marked mob keeps its raid mark.

| Alert | Line |
|---|---|
| Failed Taunts | Taunt Failed! Gogo's [Taunt] on Patchwerk was resisted. // Control Freak |
| Successful Interrupts | Interrupt! Gogo's [Pummel] on Gothik the Harvester stopped [Shadow Bolt]. // Control Freak |
| Being Incapacitated | Tank Incapacitated for 6 seconds; Gogo is afflicted by [Fear] (Magic) from Maexxna. // Control Freak |
| Tank Deaths | Tank Down! Gogo has died. // Control Freak |
| Pet Taunts | Bad Pet! Joe's pet Snuffles used [Growl] on Anub'Rekhan. // Control Freak |

### Mini-Map Button

| Click | What It Does |
|---|---|
| Left-Click | Turns every Control Freak alert on or off |
| Right-Click | Turns Tanking Tools on or off |
| Shift + Middle-Click | Opens the Options Interface |

Hovering the button shows whether All Alerts and Tanking Tools are on right now. Right-Click only works while All Alerts is on.

### Options

- **Control Freak** // All Alerts, the one switch that silences every tab without changing a setting, plus the welcome message, the mini-map button, and where to reach us.
- **Taunts** // Successful, failed, and AoE taunts, with checklists of every taunt your game client knows: class taunts, rune taunts, and engineering target dummies. Waits for a living tank in your group out of the box.
- **Interrupts** // Successful interrupts: who stopped which cast.
- **Fears** // Fears that landed, plus the fear checklist, Flash Bomb included.
- **Incapacitated** // Which effects count (stuns, fears, mind control, confusion, silences, pacifies, spell lockouts, roots, and disarms) and how many seconds make one long. Short ones print for you, long ones announce, and out of the box the tab only speaks while you're a tank or healer.
- **Tank Deaths** // Your own death while tanking and any other tank's, plus a by-class death log for your own window.
- **Bad Priests** // Power Word: Shield landing on a warrior or druid tank, with a health line below which a shield counts as a save, an optional whisper to the caster, and a cooldown. Out of the box it only watches shields landing on you while you're tanking.
- **Bad Pets** // Hunter and warlock pet taunts, a whisper telling the owner how to turn auto-cast off, and how long one pet stays quiet after an alert.
- **Tanking Tools** // Still in beta, so it ships switched off: Cold Openers (your opening abilities that didn't land, off until you turn them on), Armor Debuffs (how long the group took to strip a target's armor), Parries (somebody standing in front of the boss, whispered to move behind it), and Novas.
- **Profiles** // The standard profile picker, copy, and reset.
- **Diagnostic Tools** // Everything a bug report needs, gathered for you. Nothing runs until you press a button.

## Testing & Localization Status

🟢 World of Warcraft Classic (🟡 Season of Discovery) // WoW 1.15.9

🟢 Burning Crusade Anniversary // WoW 2.5.6

🔴 Mists of Pandaria Classic // WoW 5.5.4

🔴 World of Warcraft // WoW 12.1.0

**Localization Status** // Works with all Classic WoW Locales (enUS, deDE, esES, esMX, frFR, itIT, koKR, ptBR, ruRU, zhCN, zhTW).

Please reach out if you would like to be involved!

## Links

- [GitHub](https://github.com/Gogo1951/Control-Freak)
- [Discord](https://discord.gg/eh8hKq992Q)

## Appreciation & History

🚀 **This add-on stands on the shoulders of those that came before.**

- Davie3's [Who Taunted?](https://www.curseforge.com/wow/addons/who-taunted)
- BeathsCurse's [Simple Taunt Announce](https://www.curseforge.com/wow/addons/sta)
- BeathsCurse's [Simple Interrupt Announce](https://www.curseforge.com/wow/addons/sia)
- sfnelson's [BadPet](https://www.curseforge.com/wow/addons/badpet)
- gogo1951's [Taunts & Fears](https://wago.io/3cGT5x2OW)
- Vn's [Parry/Dodge/Miss Announcer 63+](https://wago.io/KVtFqses5)
- ColtDoomhowl's [Parry - You're in the wrong spot dipshit](https://wago.io/yJAzyvcvw)
- Commander_Snuggles's [Loss of Control Announcer](https://wago.io/qhD2-4WN6)

## Related Add-ons

🟢 Pairs With // Funkeh's [BigWigs](https://www.curseforge.com/wow/addons/bigwigs)

🟢 Pairs With // MysticalOS's [Deadly Boss Mods](https://www.curseforge.com/wow/addons/deadly-boss-mods)

🟢 Pairs With // Terciob's [Details! Damage Meter](https://www.curseforge.com/wow/addons/details)

🟢 Pairs With // Suicidal_Katt's [Threat Plates](https://www.curseforge.com/wow/addons/tidy-plates-threat-plates)

🟢 Pairs With // dfherr's [ThreatClassic2](https://www.curseforge.com/wow/addons/threatclassic2)

🟡 Some Overlap // Stanzilla's [WeakAuras](https://www.curseforge.com/wow/addons/weakauras-2)

🔴 Direct Alternative // krzysiek_7_5's [InterruptAnnouncer](https://www.curseforge.com/wow/addons/interruptannouncer)

🔴 Direct Alternative // OhNoItsGread's [Interruptor](https://www.curseforge.com/wow/addons/interruptor)

🔴 Direct Alternative // D4KiR's [LossOfControlMessages](https://www.curseforge.com/wow/addons/lossofcontrolmessages)

🔴 Direct Alternative // cerrendel's [Night Watch Tank Announcer](https://www.curseforge.com/wow/addons/night-watch-tank-announcer)

🔴 Direct Alternative // GrumpyPlayers's [TankWarningsClassic](https://www.curseforge.com/wow/addons/tankwarningsclassic)
