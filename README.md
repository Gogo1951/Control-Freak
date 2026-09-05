# Control Freak

A combat-log announcer for tanks and groups. Catch failed taunts, interrupts, bad pets, fears, parries, armor debuffs, and other combat events as they happen. Turn combat-log noise into useful callouts and know what went wrong before it becomes a wipe.

**TL;DR:** Know who did what, what failed, and why things went sideways while it's happening. No combat-log archaeology required.

## Features

🛡️ **Taunt Notifications** // Know instantly whether the mob actually changed hands. Control Freak tells you who taunted and whether the taunt landed, missed, was resisted, or was immune.

🤐 **Interrupt Notifications** // Know who stopped the cast, and what they stopped. No more wasting a kick on a spell that was already interrupted.

🐕 **Bad Pet Notifications** // Know when a hunter or warlock pet is using its threat ability and stealing mobs. Control Freak can alert you and, if you want, politely let the pet's owner know.

🔧 **Tank Tools** // Fear alerts, cold opener warnings, armor debuff monitoring, parry warnings, nova notifications, and more. The little combat-log events that can turn a clean pull into a bad one.

🎛️ **Highly Configurable** // Decide which alerts you want, where they appear, whether they make noise, and whether they announce to the group. Every alert can be configured around the role you're actually playing.

## Setup

1. Install the add-on, ideally using [CurseForge](https://www.curseforge.com/wow/addons/control-freak) or [Wago](https://addons.wago.io/addons/control-freak).
2. Type `/freak` to open the options, or Shift + Middle-Click the mini-map button.
3. Walk the tabs and switch on the alerts you want. Out of the box everything prints to your own chat window and nothing else.
4. Per alert, decide whether it plays a sound and whether it goes to party or raid chat. Announcing ships off, so nothing reaches your group until you say so.
5. Per feature, decide when it fires: only while you are tanking, only while the group has a living tank, or only inside dungeons and raids.
6. Pull. See every problem the moment it happens, and fix it before anyone notices.
7. "When you do things right, people won't be sure you've done anything at all."

## How It Works

### What It Watches

🛡️ **Taunts** // Landed taunts, failed taunts (missed, resisted, or immune), and AoE taunts. Covers every class taunt including warrior shouts, druid roars, paladin and warlock abilities, rune taunts, pet taunts, and the engineering target dummies.

🤐 **Interrupts** // Who stopped the cast, and what they stopped.

😱 **Fears** // A fear that landed and scattered the pull out of the tank's reach.

🐕 **Bad Pet** // Hunter and warlock pets with auto-cast threat abilities left on, usually without their owner noticing.

🔧 **Tanking Tools** // The things other people do that make tanking harder: cold openers (your opening attacks that never landed), armor debuffs (how long the group took to strip a target), parries (somebody standing in front of a mob they are not tanking), and novas.

### Mini-Map Button

| Click | What It Does |
|---|---|
| Left-Click | Turns every Control Freak alert on or off |
| Right-Click | Turns Bad Pet monitoring on or off |
| Shift + Middle-Click | Opens the Options Interface |

Hovering the button shows what is on right now, and Right-Click is only on offer while the add-on itself is switched on.

### Every Alert Answers the Same Questions

Each alert on each tab is built from the same block, so once you have set one you know how to set all of them.

- **Print Out Notifications** // Show it in your own chat window. On by default.
- **Sound** // Play a sound, picked from the built-in set or anything your other add-ons have shared.
- **Announce to Group** // Send it to party or raid chat. Off by default, on purpose.
- **Only Against Bosses & Elites** // Skip the trash and report raid bosses, dungeon bosses, and elites above your own level.

Print and announce each choose whose casts they cover: Mine, meaning you and your own pet, or All, meaning everybody in your group. Every block also shows a live sample of exactly what your group would see before you switch it on.

### Options

- **Control Freak** // The master switch, the welcome message, the mini-map button, and where to reach us.
- **Taunts** // Successful, failed, and AoE taunt alerts, plus a checklist of every taunt your character's client knows.
- **Interrupts** // Successful interrupt alerts.
- **Fears** // Fear alerts and the fear ability list.
- **Bad Pet** // Pet taunt alerts, whispering the owner, and how long one pet stays quiet after setting an alert off.
- **Tanking Tools** // Cold Openers, Armor Debuffs, Parries, and Novas, each with its own switch.
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

## History

👾 **I didn't create this add-on, I just updated it.**

- Davie3's [Who Taunted?](https://www.curseforge.com/wow/addons/who-taunted)
- BeathsCurse's [Simple Taunt Announce](https://www.curseforge.com/wow/addons/sta)
- BeathsCurse's [Simple Interrupt Announce](https://www.curseforge.com/wow/addons/sia)
- sfnelson's [BadPet](https://www.curseforge.com/wow/addons/badpet)
- gogo1951's [Taunts & Fears](https://wago.io/3cGT5x2OW)
- Vn's [Parry/Dodge/Miss Announcer 63+](https://wago.io/KVtFqses5)
- ColtDoomhowl's [Parry - You're in the wrong spot dipshit](https://wago.io/yJAzyvcvw)

## Related Add-ons

🟢 Pairs With // Funkeh's [BigWigs](https://www.curseforge.com/wow/addons/big-wigs)

🟢 Pairs With // MysticalOS's [Deadly Boss Mods](https://www.curseforge.com/wow/addons/deadly-boss-mods)

🟢 Pairs With // Terciob's [Details! Damage Meter](https://www.curseforge.com/wow/addons/details)

🟢 Pairs With // Nighthawk2001's [Omen3 Threat Meter Classic](https://www.curseforge.com/wow/addons/omen-threat-meter-classic)

🟢 Pairs With // dfherr's [ThreatClassic2](https://www.curseforge.com/wow/addons/threatclassic2)

🟡 Some Overlap // Emmadruid's [CC Announcer](https://www.curseforge.com/wow/addons/cc-announcer)

🟡 Some Overlap // krzysiek_7_5's [InterruptAnnouncer](https://www.curseforge.com/wow/addons/interruptannouncer)

🟡 Some Overlap // OhNoItsGread's [Interruptor](https://www.curseforge.com/wow/addons/interruptor)

🟡 Some Overlap // Tyrnix's [NKThreat](https://www.curseforge.com/wow/addons/nkthreat)

🔴 Direct Alternative // cerrendel's [Night Watch Tank Announcer](https://www.curseforge.com/wow/addons/night-watch-tank-announcer)

🔴 Direct Alternative // GrumpyPlayers' [TankWarningsClassic](https://www.curseforge.com/wow/addons/tankwarningsclassic)

🔴 Direct Alternative // GeodesicDragon's [ThreatWatch](https://www.curseforge.com/wow/addons/threatwatch)
