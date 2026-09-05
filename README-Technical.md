# Control Freak // Technical Reference

This document combines architecture notes and contribution guidance for developers working on Control Freak. For end-user documentation, see [README.md](https://github.com/Gogo1951/Control-Freak/blob/main/README.md).

## File Map

```
Control-Freak/
├── .github/
│   └── workflows/
│       └── package.yml                     CurseForge release + library vendoring
├── .gitattributes                          Line-ending normalization
├── .gitignore                              Dev-clutter ignore list
├── .luacheckrc                             Lint config
├── .pkgmeta                                Externals and ignore list
├── Control-Freak.toc                       Single TOC, Era + TBC on one Interface line
├── Control-Freak-Ability-Discovery.sql     Dev-only. Mangos queries that found the ability IDs
├── Control-Freak-Ability-Verification.sql  Dev-only. Queries that re-check them
├── Data/
│   ├── Data.lua                            Locale init, palette, options grid, tuning constants
│   ├── Default-Settings.lua                ns.DATABASE_DEFAULTS
│   └── Abilities.lua                       Every watched ability, with its per-flavor column
├── Examples/                               Dev-only reference add-ons. Never add these to the TOC
├── Features/
│   ├── Core.lua                            Version, event dispatcher, saved-variable lifecycle
│   ├── Utilities.lua                       Shims, flag predicates, group and enemy lookups
│   ├── Announcements.lua                   Sounds, prints, sent chat, the shared ns:Alert
│   ├── Whisper-Election.lua                One whisper per group however many of us watch
│   ├── Combat-Log.lua                      Ability index, alert gate, classify and dispatch
│   ├── Taunts.lua
│   ├── Interrupts.lua
│   ├── Fears.lua
│   ├── Bad-Pet.lua
│   ├── Tanking-Tools-Cold-Opener.lua
│   ├── Tanking-Tools-Armor.lua
│   ├── Tanking-Tools-Parry.lua
│   ├── Tanking-Tools-Nova.lua
│   ├── Tanking-Tools-Bubble.lua            Dormant. No ability carries the BUBBLE category
│   ├── Diagnostics.lua                     Probes and manifests
│   └── Minimap-Button.lua                  LDB object, tooltip, LibDBIcon registration
├── Includes/
│   ├── Images/                             Control-Freak.tga, the add-on and mini-map icon
│   ├── Libraries/                          Vendored. Never edited by hand, never linted
│   └── Sounds/                             The seven alert sounds the add-on ships
├── Locales/
│   ├── enUS.lua                            Source of truth. The only file passing the true flag
│   └── ...                                 Ten translations, one file per supported locale
├── Options/
│   ├── Options-Utilities.lua               Shared helpers, alert block, spell-toggle widget
│   ├── Options-General.lua                 Root panel
│   ├── Options-Apology.lua                 TEMPORARY. Delete after 2026-12-03
│   ├── Options-Taunts.lua
│   ├── Options-Interrupts.lua
│   ├── Options-Fears.lua
│   ├── Options-Bad-Pet.lua
│   ├── Options-Tanking-Tools.lua           Four warnings, one page
│   ├── Options-Profiles.lua                Stock AceDBOptions table, unmodified
│   ├── Options-Diagnostics.lua
│   └── Options.lua                         Registration, panel opener, slash command
├── LICENSE                                 MIT
├── README.md                               End-user documentation
├── README-Technical.md                     This file
└── Sound-Shortlist.md                      Dev-only. Audition notes for candidate sounds
```

`Examples/` and the two `.sql` files exist for development only. `Examples/` is not wired into the TOC and is excluded from linting; adding any of it to the TOC would load a second copy of Ace3.

`Options/Options-Apology.lua` is a dated one-off note that removes itself. Its own header comment lists the four edits that delete it, and it holds no state, so do not build anything on it.

## Architecture

### Event Loop

`Features/Core.lua` creates one frame and registers every name in `ns.EVENT_NAMES` on it, with one exception noted below. The dispatcher runs a guarded logging call and then looks up a handler named after the event on the namespace:

```lua
frame:SetScript("OnEvent", function(_, event, ...)
    if ns.diagnostics and ns.diagnostics.logging then
        ns:LogEvent(event, ...)
    end
    local handler = ns[event]
    if handler then
        handler(ns, ...)
    end
end)
```

Feature files never create frames or register events of their own. That is what lets the Diagnostics event log tap a single point and capture everything, and it is why a new event has to reach `ns.EVENT_NAMES` rather than a `RegisterEvent` call somewhere convenient.

`COMBAT_LOG_EVENT_UNFILTERED` is the exception. It is registered and unregistered at runtime by `ns:UpdateCombatLogRegistration`, so an add-on with nothing switched on is not woken for every combat line in the zone. `ns:ApplyProfile`, `PLAYER_ENTERING_WORLD`, `GROUP_ROSTER_UPDATE` and `ZONE_CHANGED_NEW_AREA` all re-run that test.

Per-fight state lives in the feature file that owns it. Each such file appends a clearing function to `ns.stateResets`, and Core runs the whole list on `PLAYER_ENTERING_WORLD`, so Core needs no knowledge of what any feature caches.

### Combat Lockdown

Control Freak writes no macros and drives no protected frames, so there is exactly one combat guard: `ns:OpenOptionsPanel` in `Options/Options.lua` checks `InCombatLockdown()` first, prints `L["CHAT_OPTIONS_IN_COMBAT"]`, and returns. It never queues and never retries. Blizzard's Settings panel is protected in combat, and without the gate the player gets an `ADDON_ACTION_BLOCKED` error naming the add-on.

The gate lives inside the opener and nowhere else. The slash handler and the mini-map button's Shift + Middle-Click both call the opener and add no check of their own, so there is only one copy to drift.

Everything else the add-on does is a read plus a print or a chat message, all of which are safe in combat. Nothing is deferred, and there is no dirty-flag replay to maintain.

### Classify, Gate, Dispatch, Render

One combat-log line takes the same four steps every time, and the order is chosen so the cheap tests run before the expensive ones.

1. **Classify** (`ns:COMBAT_LOG_EVENT_UNFILTERED` in `Features/Combat-Log.lua`). The sub-event decides the path. `SPELL_INTERRUPT` returns early on its own branch. Swings feed the enemy-target cache. Miss and armor-aura sub-events dispatch to the Tanking Tools before the ability lookup, because that lookup drops every spell ID the add-on does not own, which is all of theirs. Everything else falls through to `ABILITY_MAP`.
2. **Gate**. The ignore list, the group-source test, the pet-source test for `PET_TAUNT`, and then the feature's own scope gate.
3. **Dispatch**. `ns.CATEGORY_FEATURE` maps the ability's category to the feature that owns it, and the matching `ns:HandleXxx` in that feature's file decides what to say.
4. **Render** (`ns:Alert` in `Features/Announcements.lua`). One call renders the same locale format twice, rich for the local print and plain for chat.

The handler signatures are long and positional on purpose: everything a handler needs already came out of `CombatLogGetCurrentEventInfo`, and packing it into a table per line would allocate on the hottest path in the add-on.

### The Two-Tier Alert Gate

Scope is per feature, not global. Every tab answers "when does this fire" for itself, so a player can watch taunts everywhere and pet growls only in dungeons without the two answers fighting.

| Setting | Meaning |
|---|---|
| `enabled` | The feature runs at all |
| `tankRoleOnly` | Only while the player is tanking |
| `groupHasTank` | Only while somebody in the group is tanking and alive |
| `instanceOnly` | Only inside dungeons and raids |

**Not every tab asks every question.** `ns.FEATURE_SCOPE_OPTIONS` in `Data/Data.lua` names the ones each feature asks, and it is read twice: `Data/Default-Settings.lua` builds the stored table from it, and `ns.AddFeatureScope` draws a row per entry. A tab therefore cannot end up carrying a setting it never shows, or drawing a control with nothing behind it. A feature that never asks a question stores no key for it, so the gate reads `nil` and skips the check without a per-feature branch.

Two gates read these settings, and the split is load-bearing:

- **`FeatureCouldFire`** (file-local in `Features/Combat-Log.lua`) decides whether `COMBAT_LOG_EVENT_UNFILTERED` is registered at all. It reads `enabled` and `instanceOnly` only.
- **`ns:IsFeatureGateOpen`** runs per event and adds `tankRoleOnly` and `groupHasTank`.

The two tank questions are deliberately excluded from the registration test. They read the raid's Main Tank assignment and the group finder's TANK role; the role has `PLAYER_ROLES_ASSIGNED` behind it, but the assignment fires nothing reliable, so a registration keyed on the pair could leave the combat log unhooked with no event to put it right. Zone has an event that fires, so zone can gate registration and save the work when nothing could match.

`ns.db.profile.enabled` sits above all of it as the master switch, and the mini-map button's Left-Click drives it.

### Enemy Classification and the Boss Filter

`bossOnly` answers trash crowding out the pulls that matter, and the combat log gives it nothing to work with: a mob arrives as a GUID, with no level, no classification and no elite bit. `ns.IsBossEnemy` therefore has to find a unit token pointing at the same mob and read it from there.

`FindEnemyUnit` scans in order of likelihood: `target` first, because a single-target taunt needs one and the taunt just landed; then `focus`, `mouseover` and `boss1` to `boss5`; then every name plate on screen; then the group's own targets, since the taunter's target is the mob they taunted, which is what answers for somebody else's taunt across the room. `UnitGUID` answers `nil` for a token the client does not have, so an absent frame costs one compare rather than a capability probe.

A mob counts when it is `worldboss`-classified, when its level is `-1` (the client's "??"), or when it is `elite` or `rareelite` **strictly above** the player's own level. Strictly above is the whole filter: a level 60 clearing a level 60 dungeon meets elite trash at 58 to 60 and elite bosses at 61 to 63, so at-or-above would let every trash pack through.

**Three answers, not two.** `nil` means the question could not be asked, and `ns:Alert` treats that as a pass. The test is `ns.IsBossEnemy(destGUID) == false`, never a falsy check. Failing closed would trade a little trash noise for silently swallowing the one boss taunt the filter was turned on for.

### Per-Fight Caches

Five tables hold state that only means anything inside one fight, and they all follow the same rules: bounded, emptied whole when full rather than pruned, and cleared by `ns.stateResets` on every loading screen.

| Cache | File | Holds | Limit |
|---|---|---|---|
| `bossByGUID` | `Features/Utilities.lua` | Boss-filter answer per mob | 500 |
| `enemyTarget` | `Features/Combat-Log.lua` | Who each mob was last seen swinging at | 500 |
| `firstSeen` | `Features/Tanking-Tools-Cold-Opener.lua` | When each mob entered the combat log | 500 |
| `runs` | `Features/Tanking-Tools-Armor.lua` | Armor stack-up in progress per mob | 200 |
| `myTaunts` | `Features/Taunts.lua` | Our own taunt claims, for Hey That's Mine | Time-bounded |

Emptying whole is deliberate. Pruning the oldest entry costs a scan on a hot path, and what a wipe loses is only a suppression or an expired window, never an alert that should have fired. A raid night leaves a lot of corpses behind.

`ns.GroupHasTank` is a sixth cache of a different kind: it is answered once per frame and reused, because it walks the raid with several API calls per member and a busy combat-log frame asks it repeatedly for an answer that cannot change between two lines sharing a timestamp.

### The Dedupe Key

Three upvalues in `Features/Combat-Log.lua` hold the last timestamp, spell ID and outcome, and a firing matching all three is dropped. One AoE taunt lands a separate aura on every mob it hits and those events share a timestamp, so this collapses them into one line.

**The outcome is part of the key, and that is what makes failures work.** A throttle on source plus spell across a time window treats a cast and the miss that follows it as the same event, and swallows every resist. Never reintroduce a time-window throttle here.

The cost is that two players casting the same taunt on different mobs inside one combat-log timestamp report once rather than twice. That is rare, and it is the trade the reference announcers make too.

## Ability Data

`ns.ABILITIES` in `Data/Abilities.lua` is one entry per options checkbox, covering every flavor. An entry carries `class`, `category`, `detection`, `isAoe`, a `flavors` column, an optional `renamed` flag, and the `triggers` that checkbox owns in rank order. There is no per-rank row and no grouping key: the entry is the group.

**The `flavors` column is the authority on what this client tracks.** It reads `{ Era, SoD, TBC, Wrath }`, where `1` means the ability exists here and its checkbox starts on, `0` means it exists but starts off, and `"-"` means it does not exist on this flavor, so it is never registered and can never fire. Anything past Wrath reads the Wrath column.

`"-"` is the only defence against Blizzard reusing a spell ID for an unrelated ability on another flavor. The ID still resolves, so no existence check can catch it, and the data has to say so. Everything else is registered: a trigger this client's spell data does not know can never appear in this client's combat log, so ranks belonging to other flavors cost nothing and stay listed.

`ns.BuildAbilityIndex` in `Features/Combat-Log.lua` turns the array into two tables, `ABILITY_MAP` (spell ID to entry) and `ABILITY_GROUPS` (one row per drawable checkbox). A group is drawn only when at least one of its triggers resolves on this client, which is what keeps TBC abilities off an Era panel, and its name and icon come from the highest such trigger so the label matches the tooltip a character would see.

**The index is built on `PLAYER_LOGIN`, never at file scope.** Which flavor column is live comes from `ns.GetFlavorIndex`, and Season of Discovery shares Era's `WOW_PROJECT_ID`, so the project alone cannot separate them. Engraving is the probe that can, and it does not answer until the character is in. Resolving early would read Era and lose the three taunts the SoD column carries. Core calls `ns.BuildAbilityIndex` before it registers the options panels, and the combat log is not hooked until later, so nothing reads either table before it is filled.

`detection` is the other load-bearing field:

- **`AURA`** means the ability lands a debuff, so success is `SPELL_AURA_APPLIED` or `SPELL_AURA_REFRESH`. The aura landing is proof the mob actually changed hands, which is why a resisted taunt produces exactly one failure line rather than a success followed by a failure.
- **`CAST`** means the ability lands nothing to observe, so the cast itself is success. Every pet taunt is `CAST`: on these clients Growl, Torment and Suffering apply no debuff, and watching for an aura leaves the whole feature silent.

A rename across flavors is one entry, not two. Turn Undead became Turn Evil, so both IDs ride one row and the panel shows whichever name this client uses. Such an entry sets `renamed`, which is what separates a real rename from a typo in the Validate Data report.

**Triggers hold castable ranks, never effect IDs.** Several abilities ship a second family of same-named spells with no resource cost, no class requirement and no description, at 100 yard range. Those are the effect the real spell applies, not something anybody casts. Torment is the worked example: its castable ranks stop at 11775 on Era, while 11776 and 11777 are effect IDs. Tell them apart by the cost and the ability text, since a castable rank has both.

Season of Discovery tanking runs on runes rather than new classes, and each rune repurposes an existing ability under a new spell ID:

| Class | Rune | Taunt |
|---|---|---|
| Rogue | Just a Flesh Wound | Tease, in place of Feint |
| Shaman | Way of Earth | Earth Shock, single target, melee range |
| Warlock | Metamorphosis | Demonic Howl, an AoE taunt |

The Shaman case is why the column is per entry rather than per ID. The taunting Earth Shock has its own IDs, two seasons of them, and the plain Earth Shock ranks never taunt. Tracking the ordinary ranks would report every shock any shaman casts as a taunt.

The array is meant to be regenerated from a Mangos-style database dump. Until that query is known it carries the `-- TODO: Add SQL Query` marker rather than a reconstruction, and `Control-Freak-Ability-Verification.sql` holds the queries that check the data by hand in the meantime.

## Alert Sections

Every alert in the add-on, on every tab, is the same block of settings, and `ns:Alert` is the one place all of them are applied.

| Setting | Default | Meaning |
|---|---|---|
| `enabled` | on | The section fires at all |
| `print` | on | Print to the player's own chat window |
| `printScope` | `ALL` | Whose casts reach the print, `MINE` or `ALL` |
| `announce` | off | Send to party or raid chat |
| `announceScope` | `MINE` | Whose casts reach the announce |
| `bossOnly` | off | Fire only against bosses and elites |
| `sound` / `soundName` | on | Play a sound |

**Print and announce carry separate scopes, and they default differently on purpose.** Printing lands in the player's own window and costs nobody anything, so it starts at `ALL`. Announcing lands in everybody else's, so it starts at `MINE`, and ships switched off besides. Watch the whole group, narrate only yourself, is the setup those defaults describe.

`MINE` is the combat log's own `AFFILIATION_MINE` bit, which already covers the player's pet, so the pet case needs no handling. A missing scope reads as `ALL`, which covers both a block that draws no selectors and a profile written before the setting existed.

**The sound follows the print scope rather than carrying a third one.** Print and sound are both the player's own window, and a sound with no line to explain it is exactly the noise this add-on exists to cut.

Above all of it, `ns:Alert` re-checks that the source is in the player's group. Every dispatch in `Features/Combat-Log.lua` already bails on an outsider, which saves the work; the check here exists because `SPELL_INTERRUPT` once did not, and a mob kicking the player's heal was announced to the raid as though a group member had done something useful.

Announced alerts go to group chat and nowhere else. `ns:GetGroupChatChannel` resolves instance, raid, then party, and returns `nil` when the player is not grouped, which `ns:Announce` treats as a no-op. Say and Yell are deliberately not offered: the client silently drops an add-on's `SAY` or `YELL` outside a dungeon or raid, so the setting would do nothing in the open world with no way for the player to tell.

## Message Rendering and Chat Safety

An alert's arguments reach `ns:Alert` as **parts** rather than as finished strings, so one locale format renders twice from one call. `ns.PlayerPart`, `ns.SpellPart` and `ns.TargetPart` in `Features/Announcements.lua` build them; anything that is not a table passes straight through.

- **Rich**, for the local print: the source name in its class color, the spell as a clickable link, the target preceded by its raid-icon texture escape.
- **Plain**, for chat: the same content with the `{rtN}` token in place of the texture, since texture escapes do not survive `SendChatMessage` and the receiving client renders the token into the mark.

**Never strip color escapes from a sent body.** A spell link is `|cff...|Hspell:id:0|h[Name]|h|r`, one escape sequence. Remove the color wrapper and what is left is a malformed link, which the client refuses to send: it drops the whole message with no error and no Lua error, so the alert simply never arrives while local prints of the same content keep working. `ns.StripChatFormatting` converts the raid-icon texture and touches nothing else.

**Sent messages brand as a trailing suffix and carry no target marker.** `ns:BuildAnnounceMessage` returns `body // Control Freak`, where the house format elsewhere in the family leads with a raid-target marker and the add-on name. That is deliberate here: an alert body already carries its own target's raid mark, so a second marker in front of the line reads as two targets. `ns:BuildAnnounceMessage` is the only place the shape is applied, so keep it there.

The chat ceiling is 255 bytes, defined once as `ns.CHAT_MESSAGE_MAX_LENGTH` in `Data/Data.lua`. Because the limit is in bytes, the locale to measure against is the widest-encoding one, which here is ruRU, not English and not German. `ns:BuildAnnounceMessage` returns the finished string without sending, so a caller can measure first.

**A message that overflows loses its brand before it loses any of its body**, because the body is the information. If it is still too long after that, `ns:Announce` cuts it, and **a byte cut is not a safe cut**. Both ways of getting it wrong are silent: a cut landing inside a spell link leaves a malformed escape, which the client refuses and drops whole, so the alert never arrives at all; a cut inside a multi-byte character leaves a mangled letter, which every locale but English hits first.

`SafeCutLength` walks the string instead of measuring it. One pass counts how many escapes are open, and the answer is the last position where none of them was and no character was half written. The depth counter is a single number for colors, links and textures, because they nest: a spell link is `|cff...|Hspell:id:0|h[Name]|h|r`, which only returns to zero at its very end. Two edge cases are handled and worth keeping: a two-byte escape read at the limit lands one byte past it, so the candidate length is bounds-checked before it is accepted, and a cut with no safe point at all returns without sending rather than sending a broken line.

This is a floor, not a licence. **Every message is still written to fit**, because a truncated alert is a worse alert even when it sends. The Bad Pet whisper is the shape to copy: it renders at 123 bytes in English with a real spell link and two real names, which leaves room for a translation running twice that.

## Taunts

A successful single-target taunt is reported only when the mob was **not** already hitting the taunter. Taunting something already on you is a threat refresh rather than a save, and those lines buried the ones that mattered.

**Who the mob was on cannot be asked, only remembered.** By the time the taunt's aura lands the mob has already changed target, so a name plate or unit-token read answers with the taunter every time and would suppress everything. The combat log is the only source strictly earlier than the taunt.

`Features/Combat-Log.lua` keeps `enemyTarget`, filled from **melee swings only**. A mob melees whoever it is actually on, while a spell can land anywhere through a cleave or a random nuke. The swing branch sits ahead of the ability lookup, since a swing carries no tracked spell ID, and returns immediately afterwards.

- **Unknown means report.** Only a positive match suppresses, so a mob nobody has seen swing still announces. The cache failing costs a line you did not need, never a line you missed.
- **A successful taunt records the new owner**, so the same player taunting the same mob again is the repeat this exists to drop.

Three things are never suppressed this way: failed taunts, which are the alert a tank most needs; AoE taunts, which report once per cast rather than once per mob, so one mob's history cannot speak for the rest; and Hey That's Mine, where the mob was by definition somebody else's a moment ago.

**Hey That's Mine is parked.** The redesigned Taunts tab has no place for it yet, so `Data/Default-Settings.lua` ships `taunts.stolen.enabled` false on the last line of the file and `Options/Options-Taunts.lua` draws no section for it. The bookkeeping in `Features/Taunts.lua` keeps running, because a claim has to be recorded at the moment of the taunt or the steal is unprovable after the fact. Restoring the section is one `ns.AddAlertSection` call and deleting that last line.

## Interrupts

Interrupts do not come through the ability table. `SPELL_INTERRUPT` names both the interrupting spell and the interrupted one, so the add-on watches the sub-event directly and the Interrupts tab ships no ability list.

The branch returns before the ability path's own source gate, so it carries its own `ns.IsGroupSource` check. Without it, a Defias Prisoner kicking the player's heal was reported as though a group member had done it.

**On Era the interrupted spell has no ID.** `SPELL_INTERRUPT` reports it as `0` and hands over only the name, which printed a literal `[0]` where the spell belonged. `UNIT_SPELLCAST_INTERRUPTED` carries the true ID for the same cast and fires first, so `Features/Interrupts.lua` catches it and reads it back whenever the combat log's ID is missing. It keeps one record rather than a table keyed by unit, since both events describe the same instant, and matches on the mob's GUID inside a one second window so it can never answer for a different mob. With no ID and no name, `ns.GetSpellDisplay` falls back to `L["UNKNOWN_SPELL"]` rather than printing a raw zero.

## Bad Pet and Parry: the Whisper Election

Two features whisper a person about something they are doing wrong: Bad Pet tells a hunter their pet has auto-cast left on, and Parry Warnings tells a melee DPS to move behind the boss. Both route through `Features/Whisper-Election.lua`.

**Four people running Control Freak in one raid would otherwise send the same hunter four identical whispers in the same second**, which is how an add-on gets uninstalled by a whole group. Each client bids a random priority, broadcasts it on the add-on message channel, and holds its whisper for `ns.WHISPER_ELECTION_DELAY`. A client that hears a higher bid drops its own, so exactly one whisper goes out however many of us are watching. Ties break on the sender's GUID, so both sides stand down identically.

The wire format is:

```
kind:id:priority:senderGUID
```

`kind` is a bare word naming the feature and `id` is a GUID, neither of which can contain the `":"` the message splits on. `kind` is what keeps two features from colliding on the same subject: a pet and the player it belongs to are different whispers about different things.

**A client receives its own broadcast**, so the bid carries the sender's player GUID and `ns:CHAT_MSG_ADDON` drops any message from the player before comparing. Left unfiltered, every client ties with itself, every client stands down, and the whisper never sends while grouped, which is the only state where there is anybody to whisper.

**Match on the GUID, never on the name.** `CHAT_MSG_ADDON` reports its sender as `"Name-Realm"`, while the client's own name APIs drop the realm for your own character, so the two never compare equal and a name-based filter fails silently.

Because the election decides in silence, a second after the fact, partly in another client's code, its steps are written into the diagnostics event log through `ns.LogWhisperStep`. Callers pass raw values and a constant label, never a built string, so off costs nothing.

Each feature carries its own cooldown, keyed by the culprit's GUID, and one cooldown covers the print, the sound, the announce and the whisper together. Bad Pet's ladder starts at 30 seconds, roughly a pull, because anything shorter told the same hunter about the same pet twice in one fight. Parry's is much shorter and includes zero, because somebody standing in front of a boss can fix it in one step and wants telling now. `ns.ResolveChoice` reads both, so a profile holding a value the ladder no longer offers falls back to the default rather than to no cooldown at all.

## Tanking Tools

The tab for warnings about what other people do that makes tanking harder. It is the only feature that ships switched off, because three of its four sections read ordinary combat outcomes rather than a tracked ability, which is a running commentary on the fight rather than news. It sits last of the feature tabs, directly above Profiles, and carries no summary line, because each section introduces itself.

That opt-in buys the sections something: settings that would be rude as a default on a tab running out of the box, the parry whisper in particular, are safe here.

- **Cold Opener** (`Features/Tanking-Tools-Cold-Opener.lua`) reports an ability of the player's own that was avoided in the first seconds of a pull, which is threat that never happened at the moment threat matters most. It follows the reference aura at [wago.io/KVtFqses5](https://wago.io/KVtFqses5), whose description states its filters: only bosses, only with aggro, only abilities, only early in the pull. **Only abilities is the load-bearing one**, so it reads `SPELL_MISSED` and never `SWING_MISSED`. "You have aggro" resolves to the player's own cast and nobody else's: the first seconds of somebody else's pull are unreadable from here, because no swing has named a holder yet and a third warrior's dodge looks exactly like the tank's. The section therefore passes `noScope`. The pull clock is per mob, stamped by `ns.RememberEnemyFirstSeen` from **either** side of an event, because a boss that opens on the tank is a source before it is ever a destination. Nothing else reads that clock, so the dispatcher only stamps it while this section is on.
- **Armor Debuffs** (`Features/Tanking-Tools-Armor.lua`) times how long the group took to strip a target's armor. `ns.ARMOR_DEBUFFS` in `Data/Data.lua` describes the set: five Sunders **or** one Expose Armor answers the armor question, and Faerie Fire and Curse of Recklessness are extras the player can ask for. An extra is only ever waited on when `ns.GroupHasClass` says somebody could cast it, since otherwise ticking it in a druidless group would mean the line never prints. Timing runs from the first component to land; a run resets when the armor component drops, not when an extra does. **Stacks are counted here rather than read from the log's dose field**, because that amount sits in a different return slot per sub-event, and one wrong slot reports a number that is silently incorrect while a count restarted by every fresh `SPELL_AURA_APPLIED` cannot be.
- **Parry** (`Features/Tanking-Tools-Parry.lua`) inverts the reference aura at [wago.io/yJAzyvcvw](https://wago.io/yJAzyvcvw). A mob can only parry an attack coming at its front, and every parry speeds up its next swing at whoever is tanking it, so a parry is not the parried player's problem, it is the tank's. Being parried by a mob you are holding is just tanking; being parried by a mob somebody else is holding means you are standing in front of it. `ns.EnemyWasAlreadyOn` answers that from the swings the log has already shown, so it needs no unit token. Unlike the cold opener it takes **both** `SWING_MISSED` and `SPELL_MISSED`, because a melee DPS standing in front generates parries mostly from auto-attacks.
- **Nova** (`Features/Tanking-Tools-Nova.lua`) is the only tool driven by the ability table. The `NOVA` category has exactly one member, Frost Nova, so the same word runs from `Data/Abilities.lua` through the handler to the printed line.

Cold Opener and Armor Debuffs ship with `bossOnly` on, the only sections in the add-on that do. Both fire on ordinary combat outcomes, so unfiltered they would report every dodge on every mob in the instance, and the reference aura turns the same filter on for the same stated reason.

**The miss type arrives in a different return slot per sub-event**, and this is the easiest thing here to get wrong. `SWING_MISSED` has no spell, so its twelfth return is the miss type and lands in the `spellId` variable; `SPELL_MISSED` keeps the spell in twelve and puts the miss type in fifteen. Read the wrong one and a number is silently compared to `"PARRY"`, and the feature never fires with nothing to say so.

**One file per tool.** These share a tab, not an implementation, and their detection has nothing in common: a fight timer, aura-dose tracking, a miss-type filter, a plain cast. Anything that turns out to be genuinely shared gets a `Features/Tanking-Tools.lua` when it does, and there is no empty shell waiting for it. The **options** stay in one `Options/Options-Tanking-Tools.lua` deliberately, because section order, spacing and the header and enable pairing are a layout decision about the page as a whole.

The tab has **no ability list**, alone among the tabs that could have one. The others list abilities because their section covers a whole category a player might want to thin out; here each warning is one thing, and its own enable already says whether it fires.

### Bubble Warnings, dormant

**No ability carries the `BUBBLE` category.** The three paladin bubbles were the whole of it and are parked in a comment in `Data/Abilities.lua` that names the exact rows to paste back. Nothing registers the category, so `ns:HandleBubble` is unreachable, and `tankingTools.bubble` is absent from the defaults, which `ns:Alert` reads as nothing to do.

The machinery is dormant rather than gone: the tank and health-threshold checks in `Features/Tanking-Tools-Bubble.lua`, the `SPELL_AURA_APPLIED`-only rule in `Features/Combat-Log.lua`, `ns.BUBBLE_HEALTH_THRESHOLD`, and the `ANNOYANCE_BUBBLE` string, which still reads "Annoyance!" and wants wording of its own when the section lands.

"Tank" there means the Main Tank assignment or the group finder's TANK role, through `ns.FindTankUnit`. With neither set the check never fires, which is deliberate: guessing from class would flag a DPS warrior getting bubbled.

## Options Panels

Every feature tab is built the same way. `ns.AddFeatureScope` draws the optional summary and this feature's scope controls, and **returns a `hidden` predicate**; `ns.AddGatedHeader`, `ns.AddAlertSection` and `ns.BuildAbilityToggles` then take that predicate and hang it on everything they draw. When the feature is off the page collapses to its title and one switch.

`ns.OptionsSpacer` takes no `hidden` argument, so every gated blank line is its own description widget. Without that, a switched-off feature collapses to a column of empty rows.

**Every alert on every tab is the same block, and `ns.AddAlertSection` is the only place that shape is written down:**

```
-- Name of the alert --

One or two sentences on what it is and why it is worth having.

[ ] Enable Name of the alert
    [ ] Print Out Notifications
    [ ] ...

[ ] Some other option

Example: what the group would see
```

Header, description, switch and sample are mandatory, so a new alert cannot arrive half-dressed; only the extra row is optional. The sub-rows carry a second predicate, `hidden()` or the alert switched off, so switching one off collapses it to its header, its description and one line, which are the three things that tell a player whether to switch it back on.

The `Example:` line is **rendered, not written**. A block supplies `sample = { key, args }` naming a real locale format and stand-in names, and it goes through `ns:BuildAnnounceMessage`, the same call the live alert uses, so rewording a message cannot leave a hand-copied example quoting the old text. It shows the announce form rather than the local print on purpose, since what a section puts in front of the whole raid is the thing worth seeing before switching it on. Spell names come from the client, so the sample reads in the player's own language, and `ns.SampleBoss` deals from a shuffled deck so no two blocks name the same boss.

**Settings arrive as a getter, never as a captured table.** A profile switch replaces `ns.db.profile` outright, so a panel holding a direct reference would write into the old one. Every builder in `Options/` takes a `Section()` closure for this reason.

Sub-options are marked twice over, indented and captioned in silver, so the dependency reads whether the player is scanning shape or color. `ns.OptionsSubRow` is one unnamed inline group per sub-option, which is what pins one row per sub-option; laid out flat, the next pair packs onto whatever space is left and the indent stops indenting anything. The indent has to be a real widget, because AceConfig pins a checkbox at the left edge of its own widget and padding the label with spaces would move only the caption. `hidden` goes on the group, never on the members.

The grid constants live in `Data/Data.lua`, and the sub-option widths are **derived from the section widths rather than typed**, so every dropdown in a block starts in the same column. The one place the grid runs past `ns.OPTIONS_ROW_WIDTH` is the sound row's speaker preview, which sits in the right margin because taking the room out of the label would push the sound dropdown out of the column every other dropdown lines up in.

Ability rows use a custom AceGUI widget, `ns.SPELL_TOGGLE_WIDGET_TYPE`, registered in `Options/Options-Utilities.lua`. AceGUI's stock CheckBox fires its `OnEnter` straight at AceConfigDialog, which draws the name-and-desc tooltip and leaves no room for the spell's own, so the row carries its own widget plus mouse handling that opens a `GameTooltip` via `SetHyperlink`. The spell to show arrives in the option's `arg` field, which is a real AceConfig field passed through untouched, and it is the highest rank this client has so the tooltip reads for the character looking at it.

Unchecking an ability row writes **every** trigger ID into `ns.db.profile.ignoredSpells`, including ranks this client cannot see, so levelling or changing flavor preserves the choice. The ignore list is keyed by spell ID and shared across every feature rather than being per tab.

Panel registration is deferred into `ns.RegisterOptionsPanels`, called from Core immediately after `AceDB:New`, because the Profiles builder reaches `ns.db` and file-scope registration would crash on load. `ns:OpenOptionsPanel` routes by the category ID captured from `AddToBlizOptions`, never by looking a category up by title: `Settings.GetCategory(<title>)` returns `nil` on any client that has the Settings API, and execution falls through to `AceConfigDialog:Open`, which draws the panel as a floating window instead of docking it.

## Mini-map Button

A launcher-type LDB object registered with LibDBIcon under `ns.LOCALE_NAME`. Left-Click toggles the master enable, Right-Click toggles Bad Pet, and Shift + Middle-Click opens the Options Interface and is checked first in `OnClick`, before any feature button. The combat refusal lives inside `ns:OpenOptionsPanel` and is never duplicated here.

Both toggles go through `ns:ApplyProfile` rather than a bare `NotifyChange`, because both flip an `enabled` flag that decides whether `COMBAT_LOG_EVENT_UNFILTERED` is registered at all. Setting one without re-running the registration test would leave the add-on hooked into every combat line for a feature the player just switched off, or unhooked from one they just switched on. After a toggle the tooltip is re-rendered in place when `GameTooltip:GetOwner()` is still the button, so the On or Off state updates under the cursor.

**Always `LibDBIcon:Refresh(name, db)`, never `Show` or `Hide`.** LibDBIcon keeps a direct reference to the subtable it was registered with, and AceDB's `ResetProfile` empties the profile and copies fresh defaults back in, which replaces `profile.minimap` with a new table. A button left pointing at the old one would keep writing its position somewhere nothing reads. `Refresh` re-points the button and re-applies position and hide state in one call, and `ns:ApplyMinimapButton` is wired into `ns:ApplyProfile` so every profile switch, reset and copy goes through it.

Registration happens on `PLAYER_LOGIN` after `AceDB:New`, because the subtable does not exist until SavedVariables load.

## Diagnostic Tools

The standard panel, gated behind a runtime-only enable in `ns.diagnostics` that starts false at every login and persists nothing. Off means off: the dispatcher's logging branch is a single boolean read before any allocation, and disabling the panel releases the buffer to zero. Reports build only on an explicit button press, and the only state the panel ever writes is the `taintLog` CVar through its own button.

Two manifests are Control Freak's own and must not drift:

- **`ns.DIAGNOSTIC_DATA_SOURCES`** carries one row per static data file, each naming the table, the field its IDs live in, and a test for whether this client currently watches a given ID. `Data/Abilities.lua` answers through `ABILITY_MAP`; `ns.ARMOR_DEBUFFS` keeps its IDs in `ids` and answers through `ns.IsArmorDebuffSpell`. The panel builds one Validate Data section per row, so adding a data file adds a row rather than a new report builder.
- **`ns.DIAGNOSTIC_API_CHECKS`** carries one row per API reached through an availability guard, one-to-one with the guards in `Features/Utilities.lua`, plus the load-bearing calls the core loop depends on.

**`COMBAT_LOG_EVENT_UNFILTERED` is excluded from the event log** through `ns.DIAGNOSTIC_EVENT_EXCLUDE`, because raw it fires on every swing in the zone and would evict the whole buffer between two taunts. `Features/Combat-Log.lua` writes the firings it actually matched back in through `ns:LogEventNow`, so the log still separates "the event never fired" from "it fired and nothing happened". `ns.MESSAGE_ID_FILTERED_EVENTS` is empty, because nothing Control Freak registers needs per-ID classification, but the filter stays wired so adding such an event is a one-line change.

`ns:BuildAlertGateReport` is the add-on's own context probe and the first thing to read on a "nothing ever fires" report. It prints every feature's scope settings and the resulting verdict, the live world state they were measured against, whether the combat log is actually registered on the frame, and who the client thinks is tanking.

Diagnostics strings live in `ns.DiagnosticsStrings` as plain English and are never added to `Locales/`. The one localized string the panel reads is `L["ADDON_TITLE"]`.

Three client quirks are handled inside the reports, all found by reading a live Validate Data export against Wowhead:

- **The range pair comes back transposed.** `C_Spell.GetSpellInfo` reports a 35 yard Distracting Shot as `minRange = 35, maxRange = 0`. `OrderRange` sorts the pair rather than trusting the field names, so a client that fills them correctly is unaffected.
- **Rank subtext is answered only for cached spells**, so the export's `RANK` column is the trigger's own position, which is always known, and the client's answer rides alongside as `CLIENT_SUBTEXT`.
- **A spell link is not always a link.** On Era `GetSpellLink` hands back a bare name where a link belongs. `ns.GetSpellLink` still picks its API by availability rather than by result, but checks the **shape** of the answer and rebuilds a link from the ID when a name comes back.

## Saved Variables

One SavedVariables global, `ControlFreakDB`, managed by AceDB-3.0 and created on `PLAYER_LOGIN` in `Features/Core.lua`.

**Control Freak uses the Simple model**: `AceDB:New("ControlFreakDB", ns.DATABASE_DEFAULTS, true)`, one shared `Default` profile for every character, everything in `ns.db.profile`, and `ns.db.global` unused. It stores nothing that genuinely differs from character to character, so there is no reason for a per-character profile. **Reset Profile therefore clears everything back to install defaults**, the mini-map position and the ability ignore list included. A new setting belongs in `ns.db.profile`.

The profile's shape, regenerated from `Data/Default-Settings.lua`:

- `showWelcome`, `enabled` (the master switch), and `minimap` (owned by LibDBIcon).
- One subtable per key in `ns.FEATURE_KEYS`: `taunts`, `interrupts`, `fears`, `badPet`, `tankingTools`. Each holds `enabled`, the scope flags its entry in `ns.FEATURE_SCOPE_OPTIONS` names, one subtable per alert section, and any settings the feature owns outright.
- `ignoredSpells`, a set of spell IDs shared by every feature.

Defaults come from `ns.DATABASE_DEFAULTS` and are applied by AceDB-3.0 when a scope is first accessed, and explicit user values, including `false`, are never overridden. Note that scalar and table defaults are physically copied into the saved table (`copyDefaults` via `rawset`); only `*`/`**` wildcard defaults resolve through metatables.

**There is no refill-on-empty logic**, because the add-on ships no default item or spell list. `ignoredSpells` is a settings map, not a list: a player who unchecked every ability meant it, and re-seeding it on login would undo the choice.

There is no migration chain. The rebuild ships no bridge off the pre-rebuild schema, so a profile from the 2025 builds reads through AceDB's defaults and its old keys stay in the file unread. Any future change to the shape, name or scope of saved data ships its own 30 day migration, tagged with an explicit removal date.

Profile switches, resets and copies all fire `ns:ApplyProfile`, which re-runs the combat-log registration test, re-points the mini-map button, and notifies every registered panel so an open Options Interface follows along.

## Adding a New Ability, Alert, or Event

### A tracked ability

1. Add one entry to `ns.ABILITIES` in `Data/Abilities.lua`, in its class block, with the trailing `-- Name` comment on the closing brace.
2. Set `flavors` per column, `{ Era, SoD, TBC, Wrath }`. Use `"-"` for any flavor where the ID belongs to a different ability, and only there. Anything past Wrath reads the Wrath column.
3. Set `detection`. `AURA` only if the ability actually applies a debuff on both target clients; if in doubt, `CAST`.
4. List every castable rank in `triggers`, in rank order. Never list effect IDs.
5. If the ability answers to more than one name across its ranks or flavors, set `renamed = true` so Validate Data reports `RENAMED` rather than the typo signal `NAME MISMATCH`.
6. If the category is new, add it to `ns.CATEGORY_FEATURE` in `Features/Combat-Log.lua`, add a dispatch branch, and give the owning tab's `ns.BuildAbilityToggles` call the new category.
7. Run the Diagnostic Tools panel's Validate Data section for `Data/Abilities.lua` on a live client and check the new rows are `OK`.

### An alert section on an existing tab

1. Add the section's defaults to that feature's table in `Data/Default-Settings.lua`, through `AlertDefaults`.
2. Add three keys to `Locales/enUS.lua`: a `_HEADER`, an `_ENABLE` reading "Enable <that thing> Notifications", and a `_DESC` of one or two sentences.
3. Add the message format the alert prints, also in `Locales/enUS.lua`.
4. Call `ns.AddAlertSection` in the tab's builder, passing `sample = { key, args }` that names the real format. Leave 20 of order between sections.
5. Call `ns:Alert` from the feature's handler with that format key and its parts.
6. Measure the finished line. It has to fit 255 bytes in the widest-encoding locale, which is ruRU, with a real spell link and a real boss name substituted in.

### A feature tab

1. Add its key to `ns.FEATURE_KEYS` and its scope questions to `ns.FEATURE_SCOPE_OPTIONS`, both in `Data/Data.lua`, and a registry name to `ns.OPTIONS_REGISTRY`.
2. Add its defaults in `Data/Default-Settings.lua` through `FeatureDefaults`.
3. Add `Features/<Name>.lua` with the handler, and `Options/Options-<Name>.lua` with the builder, opening on `ns.AddFeatureScope`.
4. Add both files to `Control-Freak.toc` in the right block, feature file before Diagnostics, panel file before Profiles.
5. Register the panel in `ns.RegisterOptionsPanels`, keeping Profiles second to last and Diagnostic Tools last.
6. Add a `TAB_*` key to `Locales/enUS.lua`.

### A registered event

1. Add the event name to `ns.EVENT_NAMES` in `Features/Core.lua`, so the dispatcher and the Diagnostics event registration probe pick it up together.
2. Define `ns:<EVENT_NAME>` on the namespace. Never call `RegisterEvent` from a feature file.
3. If the event is a firehose, add it to `ns.DIAGNOSTIC_EVENT_EXCLUDE` and have the deciding handler write its real firings back through `ns:LogEventNow`.

### A sound

1. Drop the file in `Includes/Sounds/`. Keep it to one or two seconds: it fires mid-pull on top of everything else making noise.
2. Add a `{ picker name, file name }` row to `ns.SOUNDS` in `Data/Data.lua`. The picker name says which alert the sound is the default for, not what it sounds like.
3. Renaming an existing row is a breaking change. A profile stores the name, and a name the list no longer registers leaves that alert silent behind a blank picker.

## Localization

`Locales/enUS.lua` is the source of truth and the only file that passes the `true` default-fallback flag. The other ten translate its key set, and the Localization pass owns them; never hand-edit them during ordinary work.

**The AceLocale name is `ns.LOCALE_NAME`, not `ADDON_NAME`.** The installed folder is `Control-Freak` while the in-Lua identity is `ControlFreak`, and every `NewLocale()` call uses that same literal. `Data/Data.lua` defines the constant once and uses it for the locale, the LDB object, the LibDBIcon key and the add-on message prefix, so the pieces cannot drift apart. `ADDON_NAME` stays for anything keyed off the packaged add-on: metadata reads, the TOC version token, texture paths.

**Placeholders must match `enUS` per key in every locale**, in count, type and order. A locale whose format string drops a `%s` crashes at runtime when that alert fires, which may be the first time anybody has taunted anything on that client.

Two things are deliberately not localized:

- **Diagnostics strings** live in `ns.DiagnosticsStrings` as developer-facing plain English.
- **The Apology panel** is one person's letter in their own voice, dated and disposable. Putting it in the locale would ask every translator to do work that gets deleted.

`Locales/enUS.lua` carries one translator note, and it is load-bearing: `ALERT_PRINT_SCOPE_DESC` and `ALERT_ANNOUNCE_SCOPE_DESC` quote the dropdown's own choices by name, so those quoted words have to match the translations of `ALERT_SCOPE_MINE` and `ALERT_SCOPE_ALL`, or the tooltip explains options the player cannot find in the list.

`ns.SAMPLE_BOSSES` is data rather than locale copy: they are proper nouns the client already translates, and a translator who wants them in their own language replaces the table wholesale rather than hunting eighteen keys.

## Common Pitfalls

- **Stripping pipes from a sent body**: a spell link is one escape sequence, so removing the color wrapper leaves a malformed link and the client drops the whole message with no error. `ns.StripChatFormatting` converts the raid-icon texture and nothing else, and there is a comment on it saying so.
- **Cutting a sent message with `string.sub`**: the cut lands inside a spell link or inside a multi-byte character, and the client drops the message with no error. `ns:Announce` goes through `SafeCutLength`, which backs off to the last point where no escape is open and no character is half written.
- **Reading the miss type from the wrong slot**: `SWING_MISSED` puts it in the twelfth return, `SPELL_MISSED` in the fifteenth. `ns:COMBAT_LOG_EVENT_UNFILTERED` normalizes both before dispatching, and getting it wrong compares a number to `"PARRY"` and fails silently.
- **Building the ability index at file scope**: engraving does not answer until the character is in, so the flavor resolves to Era and every Season of Discovery taunt disappears. `ns.BuildAbilityIndex` is called from `PLAYER_LOGIN` for that reason.
- **`LibDBIcon:Show` / `Hide` after a profile reset**: `ResetProfile` replaces `profile.minimap` with a new table, so the button keeps writing to the detached old one. Always `ns:ApplyMinimapButton`, which calls `Refresh` with the current subtable.
- **Treating `ns.IsBossEnemy` as a boolean**: it returns `nil` when no unit token pointed at the mob, and `ns:Alert` tests `== false` so that case passes. A falsy check swallows the boss taunt the filter was turned on for.
- **Throttling alerts on a time window**: it collapses a cast and the miss that follows into one event and eats every resisted taunt. The dedupe keys on timestamp, spell ID **and** outcome instead.
- **Capturing `ns.db.profile` in a panel closure**: a profile switch replaces the table, and the panel goes on writing into the old one. Every builder takes a getter.
- **Registering an event in a feature file**: the dispatcher would never route it and the Diagnostics registration probe would never test it. Add the name to `ns.EVENT_NAMES`.
- **`dialogControl = "LSM30_Sound"` on the sound picker**: that widget lives in AceGUI-3.0-SharedMediaWidgets, which this add-on does not ship, so the panel would work only where another add-on happened to load it. The picker is a plain AceConfig `select` over `ns.GetSoundValues`.
- **Retaining references in the event log**: some events carry frames or tables that would leak or go stale. `ns:LogEvent` snapshots every argument to a string immediately, caps the count and the length, and escapes pipes **after** the length cut so a truncated argument cannot leave a dangling pipe.

## Contributing

Issues and pull requests go to [github.com/Gogo1951/Control-Freak](https://github.com/Gogo1951/Control-Freak/issues). For anything conversational, the [Discord](https://discord.gg/eh8hKq992Q) is faster.

**A bug report needs**: game version and flavor (Classic Era or TBC Anniversary), client locale, your class and level, whether you were solo, in a party or in a raid, the steps that reproduce it, and the exact chat output or whisper you got. The Diagnostic Tools panel builds most of that for you: enable it, run **Read Alert Gate State**, and paste the output. For "it never fires", add an **Event Log** capture around one attempt.

**Pull requests**:

- Keep the scope tight. One behavior per pull request.
- Match the surrounding code. Run StyLua with its default configuration, then `luac -p` and `luacheck .`, and fix every luacheck warning rather than widening the config.
- Any change to the shape, name or scope of saved data ships its own migration with an explicit removal date 30 days out.
- Any change to a chat message or whisper gets measured against the 255 byte ceiling in the widest-encoding locale, which here is ruRU, with a real spell link and a real boss name substituted in.
- Only `Locales/enUS.lua` is edited by hand. The other ten are the Localization pass's.
- Update this document in the same change when the architecture or the file map moves.

**Commit and pull request descriptions require a user story.** Do not just say "I changed X" or "I fixed Y". Frame the change in terms of who it helps and why:

> As a [role], I [needed / wanted] [behavior] so that [outcome]. This change [does X].

For example: *As a raid tank, I wanted to know when my opening Sunder was dodged so that I could tell threat problems from damage problems. This change adds the Cold Opener warning.*
