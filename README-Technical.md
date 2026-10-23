# Control Freak // Technical Reference

This document combines architecture notes and contribution guidance for developers working on Control Freak. For end-user documentation, see [README.md](https://github.com/Gogo1951/Control-Freak/blob/main/README.md).

## File Map

```text
Control-Freak/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── config.yml                            Per add-on: the New issue page's links, started from Common-Core
│   │   ├── defect.yml                            Shared from Common-Core: the bug report form
│   │   └── request.yml                           Shared from Common-Core: the suggestion form
│   └── workflows/
│       ├── ci.yml                                Calls Common-Core: shared-file, lint and StyLua checks on every PR and push to main
│       ├── issue-labels.yml                      Calls Common-Core: labels a new issue from the Defect form's Issue Type
│       └── package.yml                           Calls Common-Core: CurseForge and Wago release on a tag, a dry run from the Actions tab
├── .gitattributes                                Shared from Common-Core
├── .gitignore                                    Shared from Common-Core
├── .luacheckrc                                   Lint config
├── .pkgmeta                                      Externals, and the ignore list that keeps the four TOC-less data folders out of the zip
├── Control-Freak_Vanilla.toc                     Classic Era, Season of Discovery included
├── Control-Freak_TBC.toc                         TBC Anniversary
├── Data/
│   ├── Flavor.lua                                Canonical copy: flavor identity from the TOC's X-Flavor
│   ├── Data.lua                                  Locale init, palette, registry names, ladders, options grid, sample names, sounds, tuning constants
│   ├── Default-Settings.lua                      The AceDB defaults, with the reason each one ships as it does
│   └── {Flavor}/                                 Vanilla, Discovery, TBC, Camelot, Wrath, Mists, Mainline, one complete copy each
│       ├── Abilities-{Flavor}.lua                Every ability this flavor watches, one entry per checkbox
│       ├── Peer-Pressure-Abilities-{Flavor}.lua  Peer Pressure's class cooldowns, in the same row shape
│       ├── Armor-Debuffs-{Flavor}.lua            The debuffs the Armor Debuffs tool waits on
│       ├── Items-{Flavor}.lua                    Items that act on someone else; only Validate Data reads them
│       └── Sample-Spells-{Flavor}.lua            The spells the panels' Example lines name
├── Diagnostics/                                  Diagnostic Tools from Magic Eraser; Manifests.lua holds Control Freak's rows and probes
├── Features/
│   ├── Core.lua                                  Version, ns.EVENT_NAMES, the dispatcher, AceDB init, the login sequence
│   ├── Utilities.lua                             Colors, spell lookups, combat-log flag tests, group, tank and class lookups, tooltip readers
│   ├── Ability-Index.lua                         The ability map and groups, the ignore list, category to tab, taunt kinds
│   ├── Alert-Gates.lua                           Per-feature scope gates and the combat-log registration test
│   ├── Enemy-Tier.lua                            Against-ladder classification and its per-mob cache
│   ├── Announcements.lua                         Sounds, prints, sent chat and the safe cut, ns:Alert and its parts
│   ├── Whisper-Election.lua                      One whisper per culprit however many Control Freak clients see it
│   ├── Combat-Log.lua                            The combat-log handler, its dedupe, and the enemy-target cache
│   ├── Taunts.lua                                Taunt lines, quiet on a mob already hitting the taunter
│   ├── Interrupts.lua                            Interrupt lines, recovering the spell ID Era omits
│   ├── Fears.lua
│   ├── Incapacitated.lua                         Loss-of-control alert, the one the combat log does not trigger
│   ├── Tank-Deaths.lua                           Tank death alert and the print-only class log
│   ├── Tanking-Tools-Cold-Opener.lua             Avoided openers and the per-mob pull clock
│   ├── Tanking-Tools-Armor.lua                   Armor debuff stack-up timing
│   ├── Tanking-Tools-Parry.lua                   Parry warning and its whisper
│   ├── Tanking-Tools-Nova.lua
│   ├── Bad-Priests.lua                           Power Word: Shield on a rage tank, and its whisper
│   ├── Bad-Pets.lua                              Pet taunts left on auto-cast, and the owner whisper
│   ├── Peer-Pressure.lua                         A classmate's cooldown, the tab that came from Thanks for the Buff
│   └── Minimap-Button.lua                        LDB object, tooltip, click handlers, LibDBIcon registration
├── Includes/
│   ├── Images/                                   The TOC's IconTexture
│   ├── Libraries/                                Ace3, LibDataBroker, LibDBIcon and LibSharedMedia, refreshed from .pkgmeta on every tag
│   └── Sounds/                                   The .ogg alert sounds ns.SOUNDS registers
├── Locales/                                      The enUS source and ten translations
├── Options/
│   ├── Options-Utilities.lua                     Panel helpers, status lines, toggle pairs, sub-option rows, the sound list, cooldown values
│   ├── Options-Feature-Scope.lua                 The block every feature tab opens on: summary, enable, role ladder, scope rows
│   ├── Options-Alert-Section.lua                 The alert block, whisper rows, Example lines
│   ├── Options-Ability-Toggles.lua               Spell-toggle widget, the per-class ability lists, the taunt kind column
│   ├── Options-General.lua                       Root panel: Master Switch, the Features tiers, the Tanking Tools switches
│   ├── Options-Taunts.lua                        Taunts tab and its Tracked Abilities sub-panel
│   ├── Options-Interrupts.lua
│   ├── Options-Fears.lua                         Fears tab and its Tracked Abilities sub-panel
│   ├── Options-Incapacitated.lua
│   ├── Options-Tank-Deaths.lua
│   ├── Options-Bad-Priests.lua
│   ├── Options-Bad-Pets.lua                      Bad Pets tab and its Tracked Abilities sub-panel
│   ├── Options-Peer-Pressure.lua                 Peer Pressure tab and its Tracked Abilities sub-panel
│   ├── Options-Tanking-Tools.lua                 The tool list, the parent tab and one sub-panel per tool
│   ├── Options-Profiles.lua                      Stock AceDBOptions-3.0 table, returned unmodified
│   ├── Options-Feedback-Support.lua              The Level Up note, the four links and the version line
│   └── Options.lua                               Registration, ns:OpenOptionsPanel, the /freak command
├── LICENSE                                       MIT
├── README.md                                     End-user documentation
├── README-Notes.md                               Where Control Freak departs from the Style Guide
├── README-Technical.md                           This document
└── README-Testing.md                             Volunteer test checklist
```

`.github/`, `.gitattributes`, `.gitignore`, `.luacheckrc`, `.pkgmeta`, `LICENSE`, `README-Notes.md`, `README-Technical.md` and `README-Testing.md` are repo-only: `.pkgmeta`'s ignore list keeps them out of the zip, so an installed copy carries none of them. There is no `Tests/` folder, so CI's offline-test step has nothing to run. Each flavor has its own TOC, which names the flavor in `## X-Flavor` and lists its own data folder and no other; the Vanilla TOC lists `Data/Vanilla/` then `Data/Discovery/`, whose files open with opposite `ns.IS_DISCOVERY` guards so exactly one set of tables is built. `Data/Wrath/`, `Data/Mists/` and `Data/Mainline/` have no TOC yet, `Data/Camelot/` will never have one (`README-Notes.md` says why), and `.pkgmeta` keeps all four out of the zip. What each data file holds and how its rows were chosen is in that file's own `How We Got the Data` block, which only the Data Review edits.

`Data/`, `Features/` and `Options/` are listed in TOC load order rather than alphabetically, because files read at load what an earlier file built: `Features/Combat-Log.lua` aliases the `ns.ABILITY_MAP` that `Features/Ability-Index.lua` creates, `Features/Enemy-Tier.lua` and `Features/Bad-Pets.lua` walk the unit tokens `Features/Utilities.lua` builds, `Features/Tanking-Tools-Armor.lua` indexes `ns.ARMOR_DEBUFFS` from the flavor folder, and every file with per-fight state appends to the `ns.stateResets` list `Features/Core.lua` creates. `Includes/Libraries/` is rewritten from `.pkgmeta` by the release workflow on every tag, so a hand edit there is lost at the next release.

Files that must stay gone: `Features/Tanking-Tools-Bubble.lua`, since the paladin bubbles are parked (see Bad Priests); `Features/Bad-Pet.lua` and `Options/Options-Bad-Pet.lua`, replaced by the plural `Bad-Pets` pair and its `badPets` key; `.mp3` copies of the sounds, which ship as `.ogg` only (see Adding a New Sound); the unsuffixed `Control-Freak.toc`, since every flavor has its own, and a `Control-Freak_Camelot.toc`, since there is no WoW Forever release; `Data/Abilities.lua`, split into the flavor folders' `Abilities-{Flavor}.lua`; `Features/Diagnostics.lua` and `Options/Options-Diagnostics.lua`, replaced by the `Diagnostics/` folder; `Options/Options-Apology.lua`, the dated post-rebuild letter, retired; and the pre-rebuild `Core.lua` and `Options.lua` at the repo root, with `Data/Vanilla.lua`.

## Architecture

### Event Loop

`Features/Core.lua` owns the add-on's only event frame. Every event routes through one dispatcher, which makes a guarded diagnostics call and then calls the namespace method named after the event:

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

No feature file registers an event for handling: `Features/Alert-Gates.lua` toggles the combat log on Core's frame (`ns.eventFrame`), and the Diagnostics registration probe uses a throwaway frame with no handler. That single tap point is what lets the Diagnostics event log capture everything, and it is why a new event goes into `ns.EVENT_NAMES` rather than into a `RegisterEvent` call in a feature file.

| Event | Handled in | What it drives |
|---|---|---|
| `PLAYER_LOGIN` | `Features/Core.lua` | AceDB, the player GUID, the add-on message prefix, the ability index, the panels, the mini-map button, the welcome |
| `PLAYER_ENTERING_WORLD` | `Features/Core.lua` | Clears per-fight state and re-tests combat-log registration |
| `ZONE_CHANGED_NEW_AREA` | `Features/Core.lua` | Re-tests combat-log registration |
| `CHAT_MSG_ADDON` | `Features/Whisper-Election.lua` | Other clients' whisper bids |
| `UNIT_SPELLCAST_INTERRUPTED` | `Features/Interrupts.lua` | The interrupted spell ID that Era's combat log omits |
| `LOSS_OF_CONTROL_ADDED` | `Features/Incapacitated.lua` | The Incapacitated alert |
| `COMBAT_LOG_EVENT_UNFILTERED` | `Features/Combat-Log.lua` | Every other alert |

**`COMBAT_LOG_EVENT_UNFILTERED` is the one event not registered at load.** `ns:UpdateCombatLogRegistration` in `Features/Alert-Gates.lua` registers and unregisters it, so a client with All Alerts off, every feature off, or every enabled feature limited to instances while it is outside one, is not woken for every combat line in the zone. `ns:ApplyProfile`, `PLAYER_ENTERING_WORLD` and `ZONE_CHANGED_NEW_AREA` re-run the test, and between them they cover everything it reads: the settings and the zone. Every control that changes one of those settings calls `ns:ApplyProfile` for that reason: **All Alerts**, a feature's enable, **While in Instances**, and both mini-map button clicks. **When Group Has a Tank** and the role dropdown write without it, because the test never reads them (see Scope Gates).

**`LOSS_OF_CONTROL_ADDED` is registered flat.** It fires only while the player is crowd controlled, so gating its registration would cost more bookkeeping than it saves. It is not on the combat-log path, so its handler checks All Alerts and the Incapacitated tab's scope gates itself. The alerts that fire from combat-log branches ahead of the ability lookup (Interrupts, the Tanking Tools misses and armor, and `ns:HandleUnitDeath` for Tank Deaths) ask their own feature's gates the same way, because the lookup path is where the gates are otherwise applied.

**Per-fight state lives in the file that owns it.** Each such file appends a clearing function to `ns.stateResets`, and Core runs the list on `PLAYER_ENTERING_WORLD`, so Core knows nothing about what any feature keeps.

### Combat Lockdown

Control Freak writes no macros and drives no protected frames, so there is exactly one combat guard. `ns:OpenOptionsPanel` in `Options/Options.lua` checks `InCombatLockdown()` first, prints `L["CHAT_OPTIONS_IN_COMBAT"]`, and returns. It never queues and never retries. Blizzard's Settings panel is protected in combat, and without the gate the player gets an `ADDON_ACTION_BLOCKED` error naming the add-on.

The gate lives inside the opener and nowhere else: `/freak` and the mini-map button's Shift + Middle-Click both call the opener and add no check of their own.

Everything else is a read followed by a print, a sound, a chat message or an add-on message, all of which work in combat. Nothing waits for combat to end, so there is no dirty flag and nothing to replay; the one gameplay timer in the add-on is the whisper election's hold (see Whisper Election), and combat has no bearing on it.

### Classify, Gate, Dispatch, Render

One combat-log line takes the same path every time, ordered so the cheap tests run before the expensive ones. `ns:COMBAT_LOG_EVENT_UNFILTERED` in `Features/Combat-Log.lua` reads `CombatLogGetCurrentEventInfo` once, then:

1. **Takes the branches that need no tracked ability.** They run first because the ability lookup drops every spell ID the add-on does not own, which is all of theirs.
   - `SPELL_INTERRUPT` runs its own source and scope gates, calls `ns:HandleInterrupt`, and returns.
   - Melee swings record which player each mob is hitting (see Taunts).
   - While the Tanking Tools tab and its Cold Openers section are both on, both GUIDs stamp the per-mob pull clock. Both ship off, so nothing is stamped out of the box.
   - While Incapacitated is on, a debuff landing on the player stamps its caster's name.
   - `UNIT_DIED` calls `ns:HandleUnitDeath`.
   - `SWING_MISSED` and `SPELL_MISSED` go to `ns:DispatchTankingToolMiss` (Cold Openers, Parries), and armor aura changes go to `ns:HandleArmorDebuffs`.
2. **Classifies.** Swings stop here. `ns.ABILITY_MAP` turns the spell ID into an ability entry, or the line is dropped.
3. **Gates.** The ignore list (`ignoredSpells`), `ns.IsGroupSource`, the pet-source test for `PET_TAUNT`, then `ns:IsFeatureGateOpen` for the feature that `ns.CATEGORY_FEATURE` maps the category to.
4. **Decides the outcome.** An `AURA` ability succeeds on `SPELL_AURA_APPLIED` or `SPELL_AURA_REFRESH`, a `CAST` ability on `SPELL_CAST_SUCCESS`, and a `SPELL_MISSED` on a taunt reported as Single Target (`not ns.IsAoeTaunt(ability)`, see Taunts) is a failure. `SHIELD` counts only `SPELL_AURA_APPLIED`: a shield kept rolling reapplies constantly, and every refresh is the mistake already reported. The dedupe key runs last (see State Encoding).
5. **Dispatches** to the owning file's handler (`ns:HandleTaunt`, `ns:HandleFear`, `ns:HandleNova`, `ns:HandleBadPriest`, `ns:HandleBadPets` or `ns:HandlePeerPressure`), which picks the section and the message format.
6. **Renders** through `ns:Alert` in `Features/Announcements.lua` (see Alert Sections).

The handler signatures are long and positional on purpose. Everything a handler needs came out of that one call, and packing it into a table would allocate on the hottest path in the add-on.

### Scope Gates

Scope is per feature. Every tab answers "when does this fire" for itself, so a player can watch taunts everywhere and pet taunts only in dungeons without the two answers fighting.

| Setting | Meaning |
|---|---|
| `enabled` | The feature runs at all |
| `roleScope` | Which seat the player must be in: `TANK`, `HEALER`, `TANK_HEALER` or `ALWAYS` |
| `groupHasTank` | Only while somebody in the group is tanking, connected and alive |
| `instanceOnly` | Only inside dungeons and raids |

`ns.FEATURE_SCOPE_OPTIONS` in `Data/Data.lua` names the questions each tab asks, and it is read twice: `FeatureDefaults` in `Data/Default-Settings.lua` builds each feature's stored scope keys from it, and `ns.AddFeatureScope` draws one control per entry. A tab therefore cannot store a setting it never shows or draw a control with nothing behind it. A question a tab does not ask has no key, the gate reads nothing there, and the check is skipped without a per-feature branch.

**`roleScope` and `instanceOnly` are on every tab; `groupHasTank` is the one that varies.** The first two ask about the player, so there is no alert they cannot sensibly narrow. `groupHasTank` is the only question about somebody else, and it belongs to alerts about a mob a tank should be holding: Taunts, Tanking Tools, Bad Priests and Bad Pets. Interrupts, Fears, Incapacitated and Peer Pressure are worth hearing whether or not the party has a tank, and Tank Deaths must not ask, because a tank dying is the moment the group stops having one.

Two functions in `Features/Alert-Gates.lua` read these settings, and the split is load-bearing:

- **`FeatureCouldFire`** (file-local) decides whether `COMBAT_LOG_EVENT_UNFILTERED` is registered at all. It reads `enabled` and `instanceOnly` only.
- **`ns:IsFeatureGateOpen`** runs per event and adds `roleScope` and `groupHasTank`.

The seat questions stay out of the registration test because they read the raid's Main Tank assignment and the group finder's role. The role has `PLAYER_ROLES_ASSIGNED` behind it, but the assignment fires nothing reliable, so a registration keyed on them could leave the combat log unhooked with no event to put it right. Zone changes do fire events, so zone can gate registration.

**`roleScope` is a ladder, not a pair of boxes.** `ns.ROLE_SCOPES` runs narrowest first, and `PassesRoleFilter` treats `TANK_HEALER` as an OR, since nobody tanks and heals at once and an AND would mean "never". Tanking is `ns.IsUnitTank`: the Main Tank assignment in a raid and the group finder's TANK role in a party, never Main Assist. In a raid the role is ignored: it is a tag that sticks to the character from a dungeon queue, and counting it would report a healer's death as `Tank Down!`, so the maintainer's rule is that a player not set up as a tank in the raid frames is not a tank in a raid. A raid with nobody assigned Main Tank therefore has no tank as far as the add-on can tell, and every tab gated on `groupHasTank` stays quiet there until somebody assigns one, a cost the maintainer accepted rather than an oversight to fix. Healing is the HEALER role alone, in a raid too, because the game has no raid assignment for healing. `ALWAYS` ships on every tab but two: Incapacitated ships at `TANK_HEALER` and Bad Priests at `TANK`. A stored rung a later version drops resolves through `ns.ResolveChoice` to `ns.ROLE_SCOPE_DEFAULT`, which is `ALWAYS`, so falling off the ladder widens a tab rather than silencing it. A missing `roleScope` still means "this tab does not ask", so it must stay distinguishable from a stored rung and never be folded into that default.

A ladder-shaped scope question goes in the slot beside the feature's enable rather than on a row under it (`SCOPE_CHOICES` in `Options/Options-Feature-Scope.lua`), and it takes its default from `SCOPE_DEFAULTS` in `Data/Default-Settings.lua` rather than the blanket `false` the switches get: a ladder has no off state, and a falsy value is what the gate reads as "not asked". The slot holds one widget, so a tab can ask at most one such question.

**All Alerts** (`ns.db.profile.enabled`, captioned Enable Control Freak) sits above every tab: it sits alone under the General panel's Master Switch header, just above the Features block, and `README-Notes.md` records why the panel keeps it. Turning it off closes `ns:IsAlertGateOpen`, which unregisters the combat log, and the mini-map button's Left-Click toggles it. Below it the Features block repeats every tab's own switch, built by the same `ns.FeatureEnableToggle` the tab uses, so the two copies are one setting with one tooltip. Each copy passes its own caption: the root panel's comes from `FEATURE_CAPTION_KEYS` (`FEATURES_TAUNTS`, "Taunt Monitoring") and the tab's is its `_ENABLE` key ("Enable Taunt Monitoring"), and only the root copy draws the icon `FEATURE_ICONS` gives it ahead of the caption. They sit two to a line in the tiers `FEATURE_TIERS` in `Options/Options-General.lua` lays out (what somebody cast; the player's own seat; the two Bad tabs; Peer Pressure and Tanking Tools), with a blank line between tiers, and the Features block hides whole while All Alerts is off. While Tanking Tools is on, a Tanking Tools section under them draws one switch per tool from `ns.TANKING_TOOLS`, bound to the same `enabled` as the tool's own sub-panel. A tool's switch writes without `ns:ApplyProfile`, since the registration test reads only the feature's switch.

### Enemy Classification

The Against ladder keeps trash from crowding out the pulls that matter, and the combat log gives it nothing to work with: a mob arrives as a GUID, with no level, classification or elite flag. `ns.GetEnemyTier` in `Features/Enemy-Tier.lua` finds a unit token pointing at the same mob and reads the mob from there. It lives in its own file rather than in `Features/Utilities.lua` because it owns a per-fight cache and a `ns.stateResets` entry, and the utilities file holds shared functions with no per-fight state.

`FindEnemyUnit` scans in order of likelihood: `target`, since a single-target taunt needs one and just landed; `focus`, `mouseover` and `boss1` to `boss5`; every name plate; then the group's own targets, since a taunter's target is the mob they taunted. `UnitGUID` answers `nil` for a token the client does not have, so a missing frame costs one comparison rather than a capability probe.

The answer is a position on `ns.TARGET_RUNGS`, widest first:

| Rung | Label | A mob lands here when it is |
|---|---|---|
| `ALL` | Everything | None of the below |
| `ELITE` | Elites & Bosses | `elite` or `rareelite`, below the player's level |
| `ELITE_0` | Elites Your Level+ & Bosses | `elite` or `rareelite`, at or above the player's level |
| `BOSS` | Bosses | `worldboss`, or level `-1` (the "??" skull) |

A section stores one rung in `against`, and a mob passes when its rung is at or past that one.

**`ELITE_0` exists because a dungeon boss carries no skull.** To the client a dungeon boss is an elite, and level is the only thing separating it from the trash around it: a level 60 in a level 60 dungeon meets trash at 58 and bosses at 61 to 63. Making `BOSS` include dungeon bosses would need a signal the combat log does not carry.

**Four rungs are enough because a raid mark overrides the rung.** `alwaysWhenMarked` lets the group name the pull that matters, so the ladder only has to describe a kind of enemy. `BOSS` therefore does not separate a raid boss from a world boss, and classification needs no `IsInInstance()` call.

**`nil` is a third answer, and it passes.** `ns.GetEnemyTier` returns `nil` when no token points at the mob, or when the GUID belongs to a player. The filter tests `tier == nil or tier >= threshold`, never a falsy check: failing closed would trade a little trash noise for silently swallowing the boss taunt the filter was switched on for.

The rung is cached per GUID, since a mob's level and classification do not change mid-fight. A player levelling up moves `ELITE_0` under a cached answer, and the next loading screen clears it.

### Per-Fight State

Everything that only means something inside one fight is cleared on every loading screen through `ns.stateResets`. The four tables that grow with the number of mobs are also capped, and each is emptied whole when it fills rather than pruned: pruning costs a scan on a hot path, and emptying loses only a suppression or an expired window, never an alert that should have fired.

| Table | File | Holds | Cap |
|---|---|---|---|
| `tierByGUID` | `Features/Enemy-Tier.lua` | Against rung per mob | 500 |
| `enemyTarget` | `Features/Combat-Log.lua` | The player each mob was last seen swinging at | 500 |
| `firstSeen` | `Features/Tanking-Tools-Cold-Opener.lua` | When each mob first reached the combat log | 500 |
| `runs` | `Features/Tanking-Tools-Armor.lua` | Armor stack-up in progress per mob | 200 |

The rest are keyed by group member, pet or class and stay small: the cooldowns in `Features/Bad-Pets.lua`, `Features/Bad-Priests.lua`, `Features/Tanking-Tools-Parry.lua` and `Features/Tank-Deaths.lua`, the pending bids in `Features/Whisper-Election.lua`, and Incapacitated's last-alert records.

`ns.GroupHasTank` and `ns.GroupHasClass` cache differently. Each answers once per frame and reuses the answer, because each walks the raid with an API call or more per member, and a busy frame asks repeatedly for an answer that cannot change within it. `ns.GroupHasClass`, in `Features/Tanking-Tools-Armor.lua`, deliberately ignores whether the member is alive or connected (see Tanking Tools).

### State Encoding

Four keys decide whether two events are the same thing, and each is built from exactly what has to stay distinct.

- **The combat-log dedupe** keeps the last timestamp, caster's GUID, spell ID and outcome as upvalues in `Features/Combat-Log.lua`, plus the mob's GUID for a taunt reported as Single Target, and drops a firing that matches all of them. One AoE taunt lands a separate aura on every mob it hits, all from one caster and sharing a timestamp, so with no mob in the key they collapse into one line. A Single Target taunt keeps the mob in the key, so a Righteous Defense the player reports that way names each mob it took, and for a taunt that only ever takes one mob the extra key changes nothing. **The outcome is part of the key, and that is what lets failures through**: a throttle on source and spell across a time window treats a cast and the miss that follows it as one event and swallows every resist. Two group members casting the same ability within one timestamp each report, because the caster's GUID tells them apart.
- **Interrupts** key on timestamp, caster's GUID and interrupting spell ID in `Features/Interrupts.lua`, because `SPELL_INTERRUPT` returns before the shared dedupe runs.
- **Incapacitated** remembers the `spellID` and `startTime` of the effect it last announced. `LOSS_OF_CONTROL_ADDED` fires again when a second effect lands on the first, and the handler re-reads the whole active list, so without the key the same worst effect would be announced again.
- **The whisper election** keys a pending whisper as `kind:id`. `id` is the GUID the whisper is about, and `kind` is a bare word per feature (`pet`, `parry`, `shield`), which keeps the namespaces disjoint: the same player can be a parry culprit and a shield caster in one fight, and those are different whispers about different things.

## Ability Data

`ns.ABILITIES`, declared by `Abilities-{Flavor}.lua` in each flavor folder, holds one entry per Tracked Abilities checkbox. An entry carries `class`, `category`, `detection`, `isAoe`, an optional `kindChoice`, `renamed` and `shipsOff`, and the `triggers` that checkbox owns, in rank order. Peer Pressure's rows sit in `ns.PEER_PRESSURE_ABILITIES`, declared by `Peer-Pressure-Abilities-{Flavor}.lua` beside it, in the same shape; `ns.BuildAbilityIndex` reads both lists, so from then on they are rows like any other. There is no per-rank row: the entry is the group. Which abilities each folder holds, and why each trigger is the ID it is, is in that file's `How We Got the Data` block; this section covers how the code reads the entries.

- **`class`** is the heading the row is filed under on the panel. `ITEM` is its own heading, drawn last in muted gray: the target dummies and Flash Bomb are rows like any other, carrying the category of what their Use does, and the combat log reports the item's spell from the player who used it.
- **`category`** is `TAUNT`, `FEAR`, `NOVA`, `SHIELD`, `PET_TAUNT` or `COOLDOWN` (Peer Pressure's file only). `ns.CATEGORY_FEATURE` in `Features/Ability-Index.lua` maps it to the feature that owns the alert, and the dispatch at the end of `ns:COMBAT_LOG_EVENT_UNFILTERED` picks the handler by it.
- **`isAoe`** says whether the ability takes one mob or a pack. For a taunt it is read through `ns.IsAoeTaunt`, never directly: an entry marked `kindChoice` lets the player report it as Single Target or AOE, and `isAoe` is then only the default (see Taunts). `kindChoice` needs `AURA` detection, because a cast names one target at most where an aura lands on each mob the taunt took.
- **`renamed`** marks an ability whose ranks answer to more than one name on the client. Validate Data exports it in its `DATA_RENAMED` column, so a `DATA_ROW_NAME` that differs from an ID's `NAME` reads as a known rename rather than an ID that belongs to a different spell.
- **`shipsOff`** starts the row's checkbox unticked. Only Peer Pressure's rows set it, for the cooldowns Thanks for the Buff shipped unticked (Evasion, Vanish, Ice Block and the like). Ticking one stores `false` against its triggers in `ignoredSpells` rather than clearing them, so the profile stays a diff against the data either way (see Saved Variables).
- **No spell ID may sit in both lists.** `ns.ABILITY_MAP` holds one entry per ID, so an ID shared by an ability row and a Peer Pressure row would answer to only one tab.

**The loaded folder is the authority on what this client tracks.** Every entry in it is registered and drawn; an ability that does not exist on a flavor is left out of that flavor's folder, so its IDs are never registered and can never fire. Leaving it out is the only defense against Blizzard reusing a spell ID for an unrelated ability on another flavor, since the ID still resolves and no existence check can tell. A trigger this client's spell data does not know can never appear in this client's combat log, so it costs nothing. A change to one folder's row is looked up in the other six.

**The index is built on `PLAYER_LOGIN`.** Core calls `ns.BuildAbilityIndex` in `Features/Ability-Index.lua` before registering the options panels, which draw from it, and before the combat log is hooked.

It fills two tables:

- **`ns.ABILITY_MAP`**: spell ID to entry, for every trigger of every entry in the loaded folder.
- **`ns.ABILITY_GROUPS`**: one row per drawable checkbox. A group is drawn only when at least one trigger resolves on this client, and it takes its name, icon and tooltip spell from the **last** trigger in the list that resolves, so the label matches that character's tooltip. That is why `triggers` runs in rank order, and why an entry whose live trigger is not its castable spell lists the castable one last: Righteous Defense listens for 31790, the aura each mob takes, and lists the cast, 31789, after it only so the row shows the castable spell's name and icon. Under `AURA` detection the cast never fires, so dropping it would only change the label.

Both are wiped and refilled rather than replaced, so a file-scope alias, such as the local `ABILITY_MAP` in `Features/Combat-Log.lua`, stays pointed at the live table.

`detection` decides what counts as success:

- **`AURA`**: the ability lands an aura, so success is `SPELL_AURA_APPLIED` or `SPELL_AURA_REFRESH`. The aura landing proves the mob changed hands, so a resisted taunt produces exactly one failure line. It is usually a debuff; Power Word: Shield is the one buff on a friendly target.
- **`CAST`**: the ability lands nothing observable, so `SPELL_CAST_SUCCESS` is success, and a resisted single-target `CAST` taunt reports its cast and then its miss. Every pet taunt is `CAST`, because the pet taunts apply no debuff and watching for one leaves Bad Pets silent.

An entry is per ability, not per ID, so one checkbox covers every rank and every variant the client knows, including the Season of Discovery rune abilities that repurpose an ability under new spell IDs. Unticking a row writes every trigger into `ignoredSpells` (see Options Panels).

## Alert Sections

Every alert on every tab is the same block of settings, drawn by `ns.AddWhoseAlertSection` in `Options/Options-Alert-Section.lua` and applied by `ns:Alert` in `Features/Announcements.lua`. Whose cast it was picks the row, the dropdown beside the row says where the line goes, and the Against ladder beside the section's switch says which mobs count.

| Setting | Default | Meaning |
|---|---|---|
| `enabled` | On (Cold Openers ships off) | The section fires at all |
| `mine` | On, `PRINT` | The player's own casts, and their pet's |
| `others` | On, `PRINT` | Everybody else's casts in the group |
| `against` | `ALL` | The lowest rung of `ns.TARGET_RUNGS` that counts |
| `alwaysWhenMarked` | On | A raid mark overrides `against` |
| `sound` / `soundName` | On, with a sound picked per section | Play a sound with the line |

`WhoseAlertDefaults` in `Data/Default-Settings.lua` builds that shape, and each section's overrides sit beside it with their reasons. Incapacitated, Bad Pets and Armor Debuffs ship silent.

**Where a line goes.** An `output` is one of `ns.ALERT_OUTPUTS`: `PRINT` to the player's own window or `ANNOUNCE` to group chat, one place and never both, because both would put the same sentence on screen twice. The row is picked from the combat log's `AFFILIATION_MINE` bit, which already covers the player's pet.

**What ships loud.** Both rows print by default, so a fresh install is close to silent in group chat. The exceptions announce only the player's own line, because each is news the group needs the moment it happens and the player is the one person who already knows: Failed Taunts, AOE Taunts, Fears, and Incapacitated's Long row. Cold Openers' one row announces too, but that section ships off. Both Tank Deaths rows print (see Tank Deaths). Peer Pressure's My row ships off, as Thanks for the Buff's "Trigger on Own Casts" did (see Peer Pressure).

**What ships narrowed.** Successful and Failed Taunts at `ELITE`, Cold Openers at `ELITE_0`, Armor Debuffs and Parries at `BOSS`, and every other targeted section at `ALL`. `alwaysWhenMarked` ships on wherever it exists, so on the narrowed sections a marked mob below the rung fires from the first pull. That is the override doing its job, and also the one place it pulls against the reason those sections are narrowed; read the note in `Data/Default-Settings.lua` before changing either.

**`against` is a threshold, not a set of switches.** A section fires against its rung and every rung after it. Every rung that includes bosses says so in its label, because a bare "Elites" beside a separate "Bosses" reads as two disjoint sets. There is no way to choose nothing: independent target boxes could all be off, and the alert would go quiet with nothing on screen saying why.

**`alwaysWhenMarked` widens rather than narrows.** A marked target counts whatever `against` says, and the mark is tested first. That order is also what makes it cheap: the combat log carries `destRaidFlags` on every line, `ns.GetRaidIconIndex` turns them into 1 to 8 or `nil`, and a marked mob is answered by one nil check where the rung may walk every name plate.

**A `noTarget` section carries neither key.** A line that names no single mob has nothing for either filter to act on: AOE Taunts, Fears, Novas, Incapacitated, Tank Deaths, Bad Shields and Peer Pressure's Cooldowns. The switch spans its row alone, or shares it with a control of the section's own, and with neither key stored the target filter passes whatever GUID the handler hands `ns:Alert`.

**Bends.** The block's shape is fixed, but a section can bend it through builder options:

- **`rows`** replaces My and Others' with a list of `{ key, labelKey, descKey }`. Incapacitated passes Short and Long, because the game reports only the player's own losses of control, so the question with two answers is how long the effect lasts. The `key` is the settings key, the widget key and the `rowKey` the handler passes as `ns:Alert`'s seventh argument, so the three must match.
- **One row.** Cold Openers omits `othersKey`, since only the player's own opener is readable. Armor Debuffs and Bad Shields report a problem of the group's to the player, so each draws one row, and its handler passes the player's own affiliation, which files every report under that row.
- **`mineDescKey` and `othersDescKey`** replace the shared row tooltips (the player's own casts, pet included, and everybody else's) wherever those would be wrong: Cold Openers never counts a pet, Armor Debuffs and Bad Shields report the group's problem rather than a cast, Tank Deaths and Parries pass both, because their rows report a death or a parry, and Peer Pressure passes both, because only the player's own class counts and no pet casts a class cooldown.
- **`control`** fills the slot beside the switch, which belongs to the Against ladder. Only a `noTarget` section can use it, and Bad Shields puts its health line there; on a targeted section the builder overwrites it with the ladder.
- **`captionRow`** draws a caption and a dropdown under the rows for a parameter of the detection, such as Cold Openers' "Within [5 Seconds of the Pull]". `captionRowFirst` draws it above them instead, for Incapacitated, whose threshold is the definition the Short and Long rows branch on.
- **`extraRow`** adds rows between the filters and the sound: Armor Debuffs' two Include rows, Parries' Ignore Tanks and Ignore Pets, Bad Shields' When Playing a Druid or Warrior Tank, and Incapacitated's nine effects.
- **`afterSample`** adds a row below the Example for something that is not the alert's own output, which is every whisper. Bad Pets, Bad Shields and Parries all draw theirs through `ns.AddWhisperRow`: the whisper toggle, the cooldown beside it, and the whisper's own Example. The cooldown stays up when the whisper is off, because it covers the whole alert.
- **`noSound`** drops the sound row. Armor Debuffs uses it, so its defaults ship silent: there would be no control to switch a sound off.

**A sound plays only with a line.** `ns:Alert` resolves the row and the channel first, and plays nothing unless the line is going somewhere the player reads, so somebody else's resisted taunt with `others` off makes no sound.

**Group chat only.** `ns:GetGroupChatChannel` resolves instance chat, raid, then party, and returns `nil` when ungrouped, so an announced line then goes nowhere. Battlegrounds and arenas are skipped, since their chat is a crowd of strangers. Say and Yell are not offered: the client silently drops an add-on's `SAY` or `YELL` outside a dungeon or raid, so the choice would do nothing in the open world with no way for the player to tell.

**`ns:Alert` re-checks the group.** `ns:PassesAlertGates` requires the section's switch, `ns.IsGroupSource` and the target filter. Every combat-log dispatch already drops an outsider to save the work; the check here guarantees it, so a mob interrupting the player's heal can never be announced as a group member's interrupt. A group member's pet counts as the group.

**A whisper asks the gates before its cooldown.** A whisper is not one of the alert's outputs, so Parries, Bad Pets and Bad Shields call `ns:PassesAlertGates` directly, and **before** their cooldown: an event the filters drop neither whispers nor uses up the cooldown that would swallow the next real one.

## Message Rendering and Chat Safety

An alert's arguments reach `ns:Alert` as **parts**, so one locale format renders twice from one call. `ns.PlayerPart`, `ns.SpellPart` and `ns.TargetPart` build them, and anything that is not a table passes through.

- **Rich**, for the local print: the name in its class color, the spell as a clickable link, the target behind its raid-icon texture. A pet's GUID carries no class, so it takes the color of the class whose ability it cast.
- **Plain**, for chat: the same content with the `{rtN}` token in place of the texture, which the receiving client renders as the mark. The token goes out with no flavor check, which is safe only because no TOC the add-on ships runs on WoW Forever, the client that blocks raid-marker tokens in chat (`README-Notes.md` says why there is no Forever TOC).

Both put the information first and the brand last, `body // Control Freak`, with no target marker in front, because the body already carries its target's own mark. The locale formats end in a full stop, and both paths drop it (`.` or the CJK `。`) so the brand closes the line. A chat line too long for its brand is sent bare, period kept. `ns.BuildAlertLine` builds that shape for the local print and `ns:BuildAnnounceMessage` builds it for chat, and the options panel's Example lines go through the same two (see Options Panels). `ns:PrintLine` is the print-only path for a line with no business in group chat; Tank Deaths' class log is its one caller.

**Never strip color escapes from a sent body.** A spell link is `|cff...|Hspell:id:0|h[Name]|h|r`, one escape sequence. Remove the color wrapper and the malformed link makes the client refuse the message: it is dropped whole with no Lua error, while the local print of the same content keeps working. `ns.StripChatFormatting` converts the raid-icon texture and touches nothing else.

**A link is rebuilt when a name comes back.** On Era the link API can return a bare spell name. `ns.GetSpellLink` in `Features/Utilities.lua` calls `C_Spell.GetSpellLink`, which every client ships, then checks the shape of the answer and builds the link from the ID, in the client's spell-link color (`ns.SPELL_LINK_COLOR`), when there is no `|Hspell:` in it.

**The ceiling is 255 bytes** (`ns.CHAT_MESSAGE_MAX_LENGTH`), so the locale to measure against is the widest-encoding one, ruRU, rather than English or German. `ns:BuildAnnounceMessage` returns the finished string without sending, so a caller can measure first. A message that overflows loses its brand before any of its body, and if it is still too long, `ns:Announce` cuts it, because **a byte cut is not a safe cut**: a cut inside a spell link leaves a malformed escape that drops the whole message, and a cut inside a multi-byte character leaves a mangled letter, which every locale but English hits first.

`SafeCutLength` walks the string once, counting open escapes, and returns the last position where none was open and no character was half written. One depth counter serves colors, links and textures because they nest: a spell link returns to depth zero only at its final `|r`. A two-byte escape read at the limit lands one byte past it, so the candidate length is bounds-checked, and with no safe point at all the message is not sent rather than sent broken.

This is a floor, not a license. Every message is still written to fit, measured with a real spell link and real names substituted, because a truncated alert is a worse alert even when it sends.

## Whisper Election

Three features whisper somebody about something they are doing wrong: Bad Pets tells a pet's owner to turn off auto-cast, Parries asks a player to move behind the mob, and Bad Shields tells a healer why the shield hurts. All three go through `ns:QueueGroupWhisper` in `Features/Whisper-Election.lua`.

**Several Control Freak users in one raid would otherwise send the same person identical whispers in the same second.** Each client bids a random priority, broadcasts it to the group on the add-on message channel under `ns.ADDON_MESSAGE_PREFIX`, and holds its whisper for `ns.WHISPER_ELECTION_DELAY`. A client that hears a higher bid drops its own, so exactly one whisper goes out. Equal bids break on the sender's GUID, so both sides stand down the same way. Ungrouped, nothing is broadcast and the whisper sends once the delay passes.

The bid is one add-on message, split on `:`, which is why `kind` is a bare word and `id` is a GUID: neither can contain one.

```
kind:id:priority:senderGUID
```

**A client receives its own broadcast.** The bid carries the sender's player GUID, and `ns:CHAT_MSG_ADDON` drops a match before comparing. An echo never wins a tie against its own bid, since the tie-break is a strict comparison, but an echo of an earlier, higher bid for the same `kind:id` would cancel a whisper queued again inside the delay, which Parries can do at No Cooldown. **Match on the GUID, never the name**: `CHAT_MSG_ADDON` reports its sender as `Name-Realm`, while the client's own name APIs drop the realm for your own character, so a name comparison never matches and fails silently.

**Nobody is whispered about their own cast or their own pet**, and Parries never whispers a pet, whose name would bounce or reach a stranger who shares it. Every whisper is gated by its section's switch and target filters, never by the My and Others' rows, so a whisper can go out while its row prints nothing. The Bad Pets and Parries whispers ship on, Parries' inside a tab that ships off. Bad Shields' whisper ships off, and with When Playing a Druid or Warrior Tank ticked it can only ever reach somebody who shielded the player.

**One cooldown covers the whole event.** Each feature's cooldown is keyed by the culprit's GUID, the pet's for Bad Pets, and covers the print, the sound, the announce and the whisper together.

| Feature | Ladder | Ships at | Why the ladder or default is shaped that way |
|---|---|---|---|
| Bad Pets | `ns.BAD_PET_COOLDOWNS`, 30 seconds to 5 minutes | 1 minute | Thirty seconds is roughly a pull, and anything shorter tells the same hunter twice in one fight |
| Parries | `ns.PARRY_COOLDOWNS`, none to 9 seconds | 9 seconds | The ladder is short because somebody in front of a boss can fix it in one step; it is stored as `whisperCooldown`, but it is also how often one culprit can set the section off at all |
| Bad Shields | `ns.BAD_PET_COOLDOWNS` | 30 seconds | A shield kept rolling is a pet left on auto-cast, but a healer repeats it every few seconds, so it ships on the floor |

`ns.ResolveChoice` reads every ladder, so a stored value that a later version's ladder drops falls back to the default rather than to no cooldown.

**The election logs its own steps.** It decides in silence, a second later and partly in another client's code, so `ns.LogWhisperStep` writes each step into the diagnostics event log. Callers pass a constant label and raw values, never a built string, so logging off costs one boolean read.

## Taunts

A successful single-target taunt reports only when the mob was **not** already hitting the taunter. A taunt on a mob already on you is a threat refresh, not a save, and those lines bury the ones that matter.

**Who a mob was on can only be remembered, not asked.** By the time the taunt's aura lands, the mob has changed target, so a unit-token read answers with the taunter every time. The combat log is the only source strictly earlier than the taunt. `Features/Combat-Log.lua` keeps `enemyTarget`, filled from **melee swings only**, since a mob melees whoever it is actually on while a spell can land anywhere, and a successful taunt records the taunter as the new holder, so the same player taunting the same mob again is the repeat that goes quiet.

- **Unknown means report, for taunts.** Only a positive match suppresses, so a mob nobody has seen swing still announces. Parries and Cold Openers read the same cache through `ns.EnemyIsOnSomeoneElse`: Parries stays quiet on an unknown mob, and Cold Openers reports it. Check the consumer before assuming which way an unknown answers.
- **Failures and AoE taunts are never suppressed.** A failed taunt is the alert a tank most needs, and an AoE taunt reports once per cast, so one mob's history cannot speak for the rest.

A failed taunt picks its format from the miss type: `TAUNT_MISSED`, `TAUNT_RESISTED`, `TAUNT_IMMUNE`, or `TAUNT_FAILED` for anything else. `TAUNT_IMMUNE` alone leads with the mob, so its parts run mob, taunter, taunt. An AoE taunt never reports a miss, since it fires one per immune mob.

**Single Target or AOE is one question with three consequences.** The answer decides which section reports the taunt (Successful and Failed Taunts, or AOE Taunts with no mob and no mark), whether its misses report, and whether the mob is part of the dedupe key (see State Encoding). The Taunts tab's Tracked Abilities sub-panel draws one ability list with each row's kind beside it (`kindPicker` on `ns.BuildAbilityToggles`). Only a `kindChoice` row gets a Single Target / AOE dropdown; every other row shows its data's `isAoe` as silver text in the dropdown's column, because a taunt that takes one mob or everything around it leaves nothing to choose, and a greyed dropdown on every row read as broken. On a client with no `kindChoice` row the list's intro is `TAUNTS_ABILITIES_DESC_NO_CHOICE`, which never mentions a dropdown. Righteous Defense takes up to three, so the player decides whether it reads as one save per mob or one line per cast. `ns.GetTauntKind` in `Features/Ability-Index.lua` resolves the answer, and `ns.IsAoeTaunt` is what the combat-log failure gate and `ns:HandleTaunt` read. Fears, Novas and Bad Pets have no such choice and read `isAoe` directly; the maintainer ruled that a fear is bad whether it takes one mob or many, so Fears keeps one undivided list.

**There is no steal detection.** A planned taunt swap and a stolen mob are the same lines in the combat log, which carries no intent to tell them apart, and the fights where a steal warning would fire hardest are two-tank fights where both tanks are supposed to taunt the same mobs. A warning that cannot be trusted switched on is not worth shipping switched off. The detection is not the hard part; the missing signal of intent is, so do not rebuild it. `Features/Taunts.lua` points here.

## Interrupts

Interrupts do not come through the ability table. `SPELL_INTERRUPT` names both the interrupting spell and the spell it stopped, so the add-on watches the sub-event directly and the Interrupts tab has no ability list. The branch returns before the ability path's source gate, so it carries its own `ns.IsGroupSource` check: mobs interrupt too.

**On Era the interrupted spell's ID arrives as `0`**, with only its name, and printed raw that is a literal `[0]` in the alert. `UNIT_SPELLCAST_INTERRUPTED` carries the real ID for the same cast, so `Features/Interrupts.lua` keeps the last one and reads it back when the combat log's ID is missing. It is one record rather than a table keyed by unit, since both events describe the same instant, and it must match the mob's GUID inside a one second window, so it cannot answer for a different mob. `ns.GetSpellDisplay` treats an ID of `0` as no ID at all, and with no name either it prints `L["UNKNOWN_SPELL"]`.

## Incapacitated

The one alert the combat log does not trigger, and the only one that reads three sources to write one line: what landed, who cast it, how long it lasts, and whether anybody can remove it. It follows the reference aura at [wago.io/qhD2-4WN6](https://wago.io/qhD2-4WN6) and adds the dispel type, which turns "I am feared" into an instruction for the players who can remove it.

- **`C_LossOfControl`** says an effect is a loss of control, which kind, and for how long, already classified and timed. `LOSS_OF_CONTROL_ADDED` wakes the handler, which re-reads the active list rather than trusting the payload: the payload carries an index on some flavors and nothing on others, and re-reading also collapses "one effect landed" and "a second landed on top" into one path. Reading the same thing from `SPELL_AURA_APPLIED` would need a list of every crowd-control spell in the game, and still could not tell a partly resisted fear from a full one. **The API names no caster and no mob**, so the section is `noTarget`, and the handler builds the player's own affiliation flags for `ns:Alert`'s group test.
- **The player's own debuff**, found by spell ID through `C_UnitAuras.GetDebuffDataByIndex`, carries the **dispel type**; the combat log has no dispel field. `ns.DISPEL_TYPES` maps the API's word to a locale key, and any other answer drops the clause rather than printing empty brackets. Mind the casing: a `LossOfControlData` has `spellID`, and an `AuraData` has `spellId`.
- **The combat log** carries the mob's **name** with no unit to resolve. `Features/Combat-Log.lua` stamps each debuff landing on the player through `ns.RememberIncapacitatingAura`, and the handler reads it back, matched on spell ID inside `ns.INCAPACITATED_AURA_WINDOW`, the same one-record arrangement Interrupts uses. The debuff's `sourceUnit` is only the fallback, because that token resolves only while the mob is somebody's target or on a name plate. The stamp sits behind the section's switches and one GUID comparison, since auras land on the player several times a second in a raid.

`C_LossOfControl` is checked once at file scope: without it the section goes quiet, and Diagnostic Tools' API report says so. `C_UnitAuras` ships on every client and is called directly, but where `C_Secrets.ShouldAurasBeSecret()` says aura reads are secret (WoW Forever in combat), the debuff lookup is skipped and the line loses the dispel type while keeping the news.

**The longest effect is the one announced**, indefinite outranking every timed one, because stunned for two seconds and feared for six is a tank gone for six. `ns.INCAPACITATED_EFFECTS` maps each `locType` onto the panel's nine boxes. `PACIFYSILENCE` passes when either of its two boxes is ticked, and a `locType` the table does not map stays quiet rather than announcing under a name nobody chose.

**Short and Long route, they do not filter.** `longThreshold` decides which row a line answers to, and both rows have somewhere to send it: Short ships printing, Long announcing. A one-second stun is still worth seeing, since it explains the global cooldown just lost, but it is not worth the group's chat. The ladder, `ns.INCAPACITATED_LONG_THRESHOLDS`, starts at one second, because zero would mean nothing is ever short, which is what switching the Short row off already does. An effect with no duration counts as Long. The handler names the row outright, since affiliation would pick the same row every time, and reads that row's switch **before** `ns.INCAPACITATED_COOLDOWN`, so an effect whose row is off never uses up the window.

**Four formats, not one.** The length and the dispel type are each optional, so `INCAPACITATED`, `INCAPACITATED_PLAIN`, `INCAPACITATED_INDEFINITE` and `INCAPACITATED_PLAIN_INDEFINITE` cover the combinations. The length is its own phrase (`INCAPACITATED_SECOND` or `INCAPACITATED_SECONDS`), so the singular needs no extra formats, and it is rounded **up** to a whole second: a fear reported as 5.9 promises a taunt back sooner than it is coming. The verb, "is afflicted by", is Blizzard's own combat-log wording.

**The line opens on the player's seat, read from the player when it fires** rather than from the setting: `INCAPACITATED_ROLE_TANK` when `ns.IsPlayerTank()`, then `INCAPACITATED_ROLE_HEALER`, and otherwise the client's own class name through `ns.ClassName`, which the `ALWAYS` rung lets through. Tank wins for a character holding both signals, since a Main Tank assignment is made on purpose and outranks a role left set from a dungeon. Leading with one role phrase keeps the formats at four rather than eight in every locale.

**It is its own feature because only a feature can ask a scope question.** The Tanking Tools gate asks whether anybody is tanking, for warnings about a mob; this alert is about the player, so what narrows it is the player's seat. It is the one tab whose role ladder ships at `TANK_HEALER`, so a player with no group finder role and no Main Tank assignment hears nothing from it until they pick Always.

## Tank Deaths

One alert section and one list, and the split between them is the design.

- **Tank Deaths is the alert**, drawn like Fears: a death names no mob, so the section is `noTarget`. It keeps the whose pair as **My Death** and **Others' Tank Deaths**, because a tank's death has two audiences: the tank looking at a release button already knows, and the players who must now pick up the mob do not. Its line opens `Tank Down!`.
- **Deaths by Class is the log**: nine rows, all shipping off, with no sound and no destination. Its line opens the same way on the class, `Mage Down! Joe has died.`, so the two read as one family with the answer in the first two words. It prints through `ns:PrintLine`, the print-only path, which has no output rows to resolve, no alert gates (a death has no caster and no mob), and no sound, because nine classes with a sound each turns a wipe into a drum solo. The rows are plain sub-option rows under a header rather than a section, so the log has no switch of its own, and its Example comes from the exported `ns.RenderSample`.

**`UNIT_DIED` is the only event that reports somebody else's death as it happens.** `UNIT_HEALTH` arrives late and not for every unit, and raid frames are a picture rather than an event. Most of what `UNIT_DIED` carries is mobs and pets, so `ns:HandleUnitDeath` drops any GUID that is not a player's on a string test before anything else. `UNIT_DIED` names no source, so `Features/Combat-Log.lua` hands over the dead player's own `destFlags`, which `ns:Alert` reads for its group test. The handler finds the player with `ns.FindGroupUnit(destGUID)`, which both proves they were in the group and hands over the unit token the seat test needs. The seat test is `ns.IsUnitTank`, so in a raid only an assigned Main Tank's death is a tank death, and a healer still wearing the group finder's Tank tag from a dungeon queue is not a tank. `ns.FindTankUnit` is built on the same walk, so the two cannot disagree about who is in the group. Feign Death also arrives as `UNIT_DIED`, so `UnitIsFeignDeath` filters it out.

**The seat beats the class, and a death sends one line.** A warrior tank dying with Warrior ticked reports `Tank Down!` only. The handler picks the row itself and reads the section's switch and that row's switch **before** calling `ns:Alert`, because a tank death the section will not report falls through to the log: a player who switched Others' Tank Deaths off and ticked Warrior still hears about a warrior who was tanking. Calling `ns:Alert` first and guessing whether it spoke would report that death twice or not at all.

**My Death reports only while the player is tanking**, since the line says `Tank Down!`, and the log never reports the player. Both rows ship printing by the maintainer's decision, so a fresh install keeps tank deaths out of group chat: every Control Freak in the raid sees the line in its own window, and whoever wants it announced flips one dropdown. Mind the duplicates before changing either default. Every client that sees a tank die files it under Others' Tank Deaths except the dead tank's own, which files it under My Death, so an announcing Others' row puts one copy of the line in raid chat per Control Freak in the group, while My Death is the one row only a single client can ever fire. The section's sound ships on, playing Game Over, and a sound stays on the client that plays it.

**There is no `groupHasTank` question and no healer row.** Gating the tab on a living tank would suppress the case it exists for. A healer row would need a signal the game does not give: healing has no raid assignment, few Classic Era players set the Healer role, and inferring healers from heals means testing every heal in the raid and guessing.

`ns.DEATH_CLASS_COOLDOWN` throttles each class row so a wipe reads as a handful of lines. Like `ns.INCAPACITATED_COOLDOWN`, it is a constant because it exists to stop a wall of text, not to tune anything. The tank line has no cooldown, since every tank death is wanted and collapsing two would hide the one that mattered. `ns.DEATH_CLASSES` lists the nine Era and TBC classes, and the panel sorts them by the client's localized class name (`ns.ClassName`) rather than by token.

## Bad Priests

One section, **Bad Shields**: a Power Word: Shield landing on a druid or warrior who is tanking. Rage comes from damage taken, an absorb generates none, and the shield starves the tank of the resource they hold threat with.

- **The flavor folders scope it.** The entry is absent from the Wrath folder and every later one, where the mechanic does not apply, and from the Discovery folder, where a priest rune gives the rage back (`Data/Discovery/Abilities-Discovery.lua`'s notes say why). The tab still registers on every flavor. When the loaded folder draws no `SHIELD` row, a status line between the summary and the switch (`BAD_PRIESTS_DISCOVERY_STATUS`) says the tab cannot fire there. The line keys off the data rather than the flavor, and Season of Discovery is the shipping client it appears on.
- **Three gates, cheapest first**: the target's class (`ns.RAGE_TANK_CLASSES`, read through `GetPlayerInfoByGUID`), then tanking (`ns.FindTankUnit`, the same seat test the scope gates read, Main Tank in a raid and the TANK role in a party, never inferred from class or form), then health. `selfOnly`, When Playing a Druid or Warrior Tank, ships on and narrows all three to shields landing on the player.
- **The health line.** A shield on a tank about to die is the right call, so the warning goes quiet below the chosen `health` (`ns.SHIELD_HEALTH_THRESHOLDS`, whole percentages, since the label prints the number). Zero is Always, and the shipped 30 reads "Except Under 30% Health". It takes the slot beside the switch, which is free because the section is `noTarget`.
- **Only the first application counts**, never a refresh, and a player shielding themselves is never reported.

It is the only section that reads a **friendly** target, so it has no Against ladder and no mark, and it files every report under its one row with the player's own affiliation, as Armor Debuffs does.

**The paladin bubbles are deliberately not `SHIELD` abilities.** A bubble on a tank drops every mob onto whoever is next on threat, which is a different problem from rage denial and does not belong in this section. Each `Abilities-{Flavor}.lua` with paladins keeps their IDs in a comment, and bringing them back means a category, a handler, defaults, copy and a panel section of their own.

## Bad Pets

Hunter and warlock pets with an auto-cast taunt left on: every `PET_TAUNT` ability, detected as `CAST` and required to come from a pet or guardian (`ns.IsPetSource`). The tab ships gated on `groupHasTank`, since a hunter soloing with Growl on is playing correctly.

`ns.FindPetOwner` names the owner by walking `partypetN` and `raidpetN` (the tokens are never `partyNpet`), and the format follows what it finds: `BAD_PET` naming the owner, or `BAD_PET_UNKNOWN_OWNER` when no owner resolves, each with an `_AOE` form for Suffering. The player's own pet gets the same owner-naming line as anybody's, because the My row can announce, and a line saying "your pet" in group chat would hand the pet to whoever reads it. The whisper goes to a resolved owner and never to the player. This tab's whisper and cooldown live on the feature table (`badPets.whisper`, `badPets.cooldown`) rather than on its alert section.

## Peer Pressure

A player of the player's own class in their group pressed a tracked cooldown, so the player can press theirs. The tab came from Thanks for the Buff. Saved choices stay in that add-on's own saved variables, with no bridge, so every player starts from Control Freak's defaults.

The rows are `COOLDOWN` entries in `ns.PEER_PRESSURE_ABILITIES` (see Ability Data), all `CAST`, so a `SPELL_CAST_SUCCESS` from a group member reaches `ns:HandlePeerPressure` in `Features/Peer-Pressure.lua` through the ordinary ability path, after the ignore list, the group test, the tab's scope gates and the dedupe. The handler then needs two tests of its own: **the row's `class` against the player's class**, which is the whole same-class test because every row is class-locked and needs no lookup of the caster, and a player GUID for the caster. The line is `PEER_PRESSURE`, or `PEER_PRESSURE_TARGET` when the cast landed on another player, rendered as a player part; a cast on the caster, a pet or nothing reads plain.

One `noTarget` section, `peerPressure.alert`. The My row ships off, as Thanks for the Buff's "Trigger on Own Casts" did, and the Others' row prints. Both rows can announce, because a tank calling their own Shield Wall in group chat is a line the group can use. It plays `Control Freak: Thunder`, the sound Thanks for the Buff shipped, under that name. The tab asks `roleScope` and `instanceOnly`, both shipping at their widest, so out of the box it fires everywhere in any seat, the way it did there.

Every class's rows are drawn on the Tracked Abilities sub-panel, not just the player's, because the profile is shared across the account. A row that Thanks for the Buff shipped unticked carries `shipsOff`. The tab's Example names a roster player of the character's own class pressing that class's first ticked cooldown by name (its first cooldown when none is ticked), since a line about any other class is one the tab can never send; a class with no rows borrows the first row of any class, so the Example is never blank.

## Tanking Tools

Four warnings that share a tab, not an implementation. The tab ships off while its tools are in beta, and that switch is the whole opt-in: everything under it, the parry whisper included, ships the way it should run once a player turns the tab on. What keeps it quiet then is that everything under it is narrowed, switched off or gated: the tab asks `groupHasTank`, Cold Openers ships off, and every targeted section is narrowed, because three of the four read ordinary combat outcomes that would otherwise narrate every dodge in the instance. It is the last feature tab because it is the one that ships off, and `ns.FEATURE_KEYS`, the registration order in `Options/Options.lua` and `FEATURE_TIERS` in `Options/Options-General.lua` all carry that order, so moving it means changing all three.

- **Cold Openers** (`Features/Tanking-Tools-Cold-Opener.lua`) reports the player's own ability avoided in the first seconds of a pull: threat that never happened, when it matters most. It follows the reference aura at [wago.io/KVtFqses5](https://wago.io/KVtFqses5), whose stated filters are bosses only, aggro only, abilities only and early only. **Abilities only is load-bearing**: it reads `SPELL_MISSED` and never `SWING_MISSED`, since auto-attacks are avoided constantly. It reports only the player's casts, because the first seconds of somebody else's pull are unreadable: no swing has named a holder yet, and a DPS going early looks exactly like the tank. The pull clock is per mob, stamped by `ns.RememberEnemyFirstSeen` from **either** side of an event (a boss opening on the tank is a source before it is a destination), and only while this section is on. A mob already on somebody else does not count, a mob never seen does not count, and tracked taunts are skipped, so a resisted opening taunt prints once, as a Failed Taunt. `ns.COLD_OPENER_MISS_FORMATS` leaves out `ABSORB`, `REFLECT` and `EVADE`, none of which is the target avoiding the hit.
- **Armor Debuffs** (`Features/Tanking-Tools-Armor.lua`) times how long the group took to strip a target's armor. `ns.ARMOR_DEBUFFS`, in each flavor folder's `Armor-Debuffs-{Flavor}.lua`, describes the set: five Sunders **or** one Expose Armor answers the armor question, and Faerie Fire and Curse of Recklessness are extras the player can require. An extra is waited on only when `ns.GroupHasClass` finds somebody who could cast it, or the line would never print; that test ignores whether they are alive, since a dead druid is still a reason to wait. Timing runs from the first component to land, and a run resets when an armor component drops, not an extra. **Stacks are counted rather than read from the log's dose field**, because the amount sits in a different return slot per sub-event, and one wrong slot reports a number that is silently wrong.
- **Parries** (`Features/Tanking-Tools-Parry.lua`) inverts the reference aura at [wago.io/yJAzyvcvw](https://wago.io/yJAzyvcvw). A mob parries only attacks from its front, and every parry speeds up its next swing at whoever is tanking it, so a parry is the tank's problem. Being parried by a mob you are holding is tanking; being parried by a mob somebody else holds means you are standing in front of it, which `ns.EnemyIsOnSomeoneElse` answers from swings already seen, with no unit token. **A mob with no holder on record reports nothing**, the opposite of the taunt rule, or every pull's opening exchange would name the tank. It reads **both** `SWING_MISSED` and `SPELL_MISSED`, since a melee player in front generates parries mostly from auto-attacks. Ignore Tanks, shipping on, drops a group member who is a tank through `ns.FindTankUnit` before the cooldown; the player's own parries still report. Ignore Pets, also shipping on, drops a pet or guardian through `ns.IsPetSource`, the test Bad Pets uses, because the line would name the pet and nobody in the group can act on that; a pet is never whispered whichever way the row is set.
- **Novas** (`Features/Tanking-Tools-Nova.lua`) is the only tool driven by the ability table: the `NOVA` category has one member, Frost Nova.

**The miss type arrives in a different return slot per sub-event**, which is the easiest thing here to get wrong. `SWING_MISSED` has no spell, so its twelfth return is the miss type; `SPELL_MISSED` keeps the spell in the twelfth and puts the miss type in the fifteenth. `ns:COMBAT_LOG_EVENT_UNFILTERED` normalizes both before calling `ns:DispatchTankingToolMiss`. Read the wrong slot and a number is compared to `"PARRY"`, and nothing ever fires.

**One file per tool.** The detection has nothing in common: a pull clock, a stack count, a miss-type filter and a plain cast. The options stay in one `Options/Options-Tanking-Tools.lua`, which declares `ns.TANKING_TOOLS` and builds the parent tab (the summary, the switch and its scope rows) and one sub-panel per tool from it. Each sub-panel is a status line and the tool's alert block, drawn with `noHeader` since the page title names it, and `ns.RegisterOptionsPanels` finds each builder by name, `ns.Build<registry>Options`. The root panel's Tanking Tools section draws a switch per tool from the same list, shown while the feature is on. No tool has an ability list: each warning is one thing, and its enable already says whether it fires.

## Options Panels

Every feature tab is built the same way. `ns.AddFeatureScope` draws the optional summary, the enable with the role ladder beside it, and the scope rows, and it **returns a `hidden` predicate**. `ns.AddGatedHeader` and `ns.AddWhoseAlertSection` hang that predicate on everything they draw, so a switched-off feature collapses to its title and one switch. Inside a section, the rows hang on a second predicate that also reads the section's switch, so a switched-off section keeps its header, description, switch and Example, which are what tell a player whether to switch it back on.

**Sub-panels are never hidden behind their feature's switch.** A Tracked Abilities sub-panel (Taunts, Fears, Bad Pets, Peer Pressure) is one short intro and the ability list, and which abilities count is worth settling before turning the feature on; a Tanking Tools tool's sub-panel passes `ns.NeverHidden` as its tab predicate, so only the block's own switch collapses its rows. What says the feature is off is a status line instead: `ns.AddQuietStatus` puts one at the top of every sub-panel, shown only while All Alerts or the parent feature's switch has it silenced, naming the switch and where to find it. Every feature tab opens on the same line for All Alerts alone, since the tab's own switch being off already collapses the page to the switch that says so. The line's `name` is a function that answers blank when there is nothing to say. AceConfigDialog reads every option's name while sorting, hidden ones included, and a feature tab's line carries no tab key, so formatting the feature-off wording there would throw on `L[nil]` and stop the whole page drawing. Each sub-panel's page title is `ns.SubPanelTitle(parent, name)`, "Taunts > Tracked Abilities", so a page reached from search still says whose it is, while the tree shows the short name passed to `AddToBlizOptions`.

```
-- Name of the alert --

One or two sentences on what it is and why it is worth having.

[ ] Enable Alerts for <thing> On          [ Everything          v]
    [ ] My <thing>                        [ Print (Self Only)   v]
    [ ] Others' <thing>                   [ Print (Self Only)   v]
        <caption>                         [ ...                 v]  captionRow
    [ ] Always Alert on Marked Targets
    [ ] ...                                                         extraRow
    [ ] Play Sound                        [ Control Freak: ...  v]  (speaker)

Example: what the group would see

[ ] Whisper ...                           [ ...                 v]  afterSample

Example: what the whisper says
```

The header, description, switch and Example are mandatory, so a new alert cannot arrive half-dressed; everything else is optional.

**The Example is rendered, not written, and it follows its row.** A section passes `sample = { key, args, row }`: a real locale format, its parts, and the row whose dropdown decides the form, `mine` unless the line is about somebody else. `AddSample` in `Options/Options-Alert-Section.lua` gives it a function `name`, so it redraws the moment that dropdown changes, and `RenderSample` draws it the way it will arrive:

| The row is set to | Drawn as |
|---|---|
| `PRINT` | The exact string `ns.BuildAlertLine` builds for `ns:PrintAlert`, names in class colors, body re-tinted after every `\|r` |
| `ANNOUNCE` | `ns:BuildAnnounceMessage`'s output as party chat, `[Party] [Name]: ...` from the client's `CHAT_PARTY_GET`, in `ChatTypeInfo.PARTY`'s color, with each `{rtN}` token drawn as its mark |

A whisper's Example, drawn by `ns.AddWhisperRow`, uses the same call as the whisper the other player receives, `[Name] whispers: ...` from `CHAT_WHISPER_GET`. Because both forms go through the live builders, rewording a message cannot leave an Example quoting the old text.

The parts say who is in the line. `ns.SamplePlayer()` is the character the panel is open on, read when the line draws, and the sender of every party line and whisper is that character too. Anybody else is `ns.SampleOther(class)`, a name from `ns.SAMPLE_NAMES`, the house roster keyed by class in `Data/Data.lua`. `ns.SampleCaster(kind, fallbackClass)` picks the player's own class's spell from `ns.SAMPLE_SPELL_IDS` (`TAUNT_DRUID`) and the `mine` row when that class has one, or the roster player of `fallbackClass` and the `others` row when it does not, so the name, its color and the spell agree. Spells are `ns.SpellPart` links built from the flavor folder's IDs, and `ns.SampleTarget` puts a skull on a boss that `ns.SampleBoss` deals from a shuffled deck of `ns.SAMPLE_BOSSES`, the Molten Core and Blackwing Lair bosses in `SAMPLE_BOSS_*` locale keys. Each block deals once at build time, so no two blocks name the same boss and the names hold still while the panel is open.

**Settings arrive as a getter, never as a captured table.** A profile switch replaces `ns.db.profile` outright, so a panel holding a direct reference would go on writing into the old one. Every builder takes a `Feature()` or `Section()` closure.

**Orders are budgeted.** A section owns 20 of order: the frame runs to +6, the rows to +9, extras from +11, the sound at +14, the Example at +15 and +16, and a whisper from +17 to +19 in half steps. A section needing more extra rows than that holds steps by tenths, as Incapacitated's nine effects and Tank Deaths' nine class rows do. Ability lists live on their tab's Tracked Abilities sub-panel, not among the sections.

**Args keys share one flat table per panel.** Two builders writing the same key overwrite each other with no error, so `ns.AddGatedHeader` suffixes its keys `Header...` apart from the `Head...` keys a section frame uses, and `ns.BuildAbilityToggles` writes fixed `class<CLASS>` keys with no prefix, so a panel calls it once with every category it lists, as each Tracked Abilities sub-panel does.

**Sub-options are marked twice**, indented and captioned in silver, so the dependency reads by shape or by color. `ns.OptionsSubRow` makes one unnamed inline group per sub-option, which pins one row each; laid out flat, the next pair packs onto whatever space is left and the indent stops indenting. The indent is a real widget, since AceConfig pins a checkbox to the left edge of its own widget, and `hidden` goes on the group, never on its members. Every gated blank line is its own `ns.OptionsSpacer(order, hidden)` carrying the section's predicate; a spacer without one stays drawn, and a switched-off feature collapses to a column of empty rows.

**The grid lives in `Data/Data.lua`.** The label half, `ns.OPTIONS_LABEL_WIDTH`, is wide because it carries the longest labels in the add-on, the alert switches such as "Enable Alerts for Successful Interrupts On", with the Against ladder beside them; a longer string clips with an ellipsis, which is why translations are worded short. Sub-option widths are **derived** from the section widths rather than typed, and the sub-rows that pair a caption with a dropdown fill the row exactly, which is what puts every dropdown in a block in one column (verified in-game on both flavors, with no wrapping). The sound row's speaker preview is the one thing past `ns.OPTIONS_ROW_WIDTH`, in the right margin, since taking its room from the label would push the sound dropdown out of that column. A caption with no box sits behind a blank cell of `ns.OPTIONS_SUB_CAPTION_INDENT_WIDTH`, a checkbox's width, so its first letter lines up with the captions beside boxes.

**Ability rows use their own AceGUI widget**, `ns.SPELL_TOGGLE_WIDGET_TYPE` in `Options/Options-Ability-Toggles.lua`. AceGUI's stock CheckBox sends its `OnEnter` to AceConfigDialog, which draws the name-and-description tooltip and leaves no room for the spell's own, so the row opens `GameTooltip:SetHyperlink` on the spell in the option's `arg` field, which AceConfig passes through untouched. Unchecking a row writes **every** trigger ID into `ns.db.profile.ignoredSpells`, including ranks this client cannot see, so levelling or changing flavor keeps the choice. The ignore list is keyed by spell ID and shared by every feature. Both directions go through `ns.SetAbilityTracked` and are read by `ns.IsAbilityIgnored`, in `Features/Ability-Index.lua`: unticking stores `true`, and ticking clears the IDs, or stores `false` on a `shipsOff` row, which starts unticked.

**The sound picker is a plain `select` over `ns.GetSoundValues`**, which lists every sound registered with LibSharedMedia, so other add-ons' sounds appear beside Control Freak's. Choosing a sound plays it, and the speaker previews it whether or not Play Sound is ticked.

Registration is deferred into `ns.RegisterOptionsPanels`, which Core calls on `PLAYER_LOGIN` after `AceDB:New` and the ability index, because the Profiles builder reaches `ns.db`. The order is General, the nine feature tabs in `ns.FEATURE_KEYS` order, each followed by its sub-panels, Profiles, Feedback & Support, then Diagnostic Tools. Taunts, Fears, Bad Pets and Peer Pressure each carry a Tracked Abilities sub-panel and Tanking Tools one per tool; a sub-panel nests under the category ID its parent's `AddToBlizOptions` returned. `ns:OpenOptionsPanel` routes by the category ID captured from `AddToBlizOptions`, never by title: a title lookup fails on TBC Anniversary, where the category ID is a number assigned at registration, and the panel opens as a floating window instead of docking.

## Mini-map Button

A launcher LDB object registered with LibDBIcon under `ns.LOCALE_NAME`. Its icon is the game's own Taunt icon (`ns.MINIMAP_ICON`), so it reads as a taunt at a glance; the TOC's `IconTexture` is the add-on list's branding. `ns.MINIMAP_ICON_COORDS` crops the frame the game draws into its stock icons: LibDBIcon's own 5% inset clears the thin frame of an add-on's art but leaves this one showing inside the button's ring, where it makes the icon read as undersized. `ns:RegisterMinimapButton` also carries the Style Guide's icon fit for the Retail engine, gated on `ns.FLAVOR` being `Camelot` or `Mainline`; no TOC the add-on ships selects either, so it never runs today, and it fits the icon by hand rather than through `SetButtonIcon`, whose reset errors when another add-on has replaced the button's icon.

| Click | Action |
|---|---|
| Left-Click | Toggles All Alerts |
| Right-Click | Toggles Tanking Tools |
| Shift + Middle-Click | Opens the Options Interface, checked before any other binding |

**The tooltip lists only what a click on the button changes**: an All Alerts block, a Tanking Tools block and the options line, so no other tab appears in it. The All Alerts block takes its title from `KILL_SWITCH` and its description from `KILL_SWITCH_ENABLE_DESC`, the panel toggle's own tooltip, so the button and the panel cannot name or describe the switch differently. The Tanking Tools block draws only while All Alerts is on, and Right-Click does nothing while it is off: with the combat log unregistered the tab cannot fire, and a binding the tooltip does not advertise does nothing. Every other button and modifier combination is unbound, and a shifted Left- or Right-Click is ignored rather than read as the plain click. The combat refusal lives inside `ns:OpenOptionsPanel` and is never repeated in `OnClick`.

**A tab earns a binding by shipping switched off.** Tanking Tools is the opt-in tab, so Right-Click is the way in and out mid-run without opening the panel. Its block's description is `TANKING_TOOLS_MINIMAP_SUMMARY`, a short list of its four tools kept to two lines, rather than the tab's longer `TANKING_TOOLS_SUMMARY`. The tabs that ship on are reached through the panel.

**Every click toggle goes through `ns:ApplyProfile`**, not a bare `NotifyChange`, because each flips an `enabled` flag that decides whether the combat log is registered. Without the registration test, the add-on stays hooked into every combat line for a feature just switched off, or unhooked from one just switched on. After a toggle the tooltip re-renders in place while `GameTooltip:GetOwner()` is still the button. The General panel's **Enable Mini-map Button** writes the inverted `minimap.hide` and calls `ns:ApplyMinimapButton` directly, since the button's visibility is nothing the registration test reads.

**Always `LibDBIcon:Refresh(name, db)`, never `Show` or `Hide`.** LibDBIcon keeps a direct reference to the subtable it was registered with, and AceDB's `ResetProfile` replaces `profile.minimap` with a fresh table, so a button still pointing at the old one writes its position where nothing reads it. `ns:ApplyMinimapButton` passes the current subtable to `Refresh` and runs inside `ns:ApplyProfile`, so every profile switch, reset and copy re-points the button. It registers on `PLAYER_LOGIN`, after `AceDB:New`, since the subtable does not exist until SavedVariables load.

## Diagnostic Tools

The standard panel, gated by a runtime-only enable in `ns.diagnostics` that starts off at every login and persists nothing. Off means off: the dispatcher's logging branch is one boolean read before any allocation, and disabling the panel releases the event buffer, stops any run and clears every report. While it is on, five tabs show: Run Tests (Event Log, Taint Log, In-Game Tools, External Tools), Settings, Code, Data and Localization, each report tab with a Run All and one output box. Reports build only on a button press, and the only state the panel writes is the `taintLog` CVar, through its own buttons.

**Three registered events are excluded from the event log** through `ns.DIAGNOSTIC_EVENT_EXCLUDE`, because raw they would evict the whole buffer between two alerts. The handler that acts on each writes its real firings back through `ns:LogEventNow`, so the log still separates "never fired" from "fired and nothing happened":

| Event | Too noisy because it carries | Written back by |
|---|---|---|
| `COMBAT_LOG_EVENT_UNFILTERED` | Every swing in the zone | `Features/Combat-Log.lua`, for matched lines and interrupts |
| `CHAT_MSG_ADDON` | Every add-on's messages in the group and guild | `Features/Whisper-Election.lua`, for Control Freak's prefix |
| `UNIT_SPELLCAST_INTERRUPTED` | Every interrupted or cancelled cast of every unit | `Features/Interrupts.lua`, when it lends a spell ID |

The whisper election writes its steps in as `WHISPER_ELECTION`. `ns.MESSAGE_ID_FILTERED_EVENTS` is empty, since nothing Control Freak registers needs per-ID classification, but the filter stays wired so adding such an event is a one-line change.

The framework (runner, panel, event buffer, Validate Data, Game Names) is Magic Eraser's `Diagnostics/` folder, copied whole. What describes Control Freak lives in `Diagnostics/Manifests.lua`, the Settings and Localization report lists in `Diagnostics/Report-Runner.lua`, the excluded firehoses in `Diagnostics/Event-Log.lua`, Display Context in `Diagnostics/Settings-Reports.lua`, and the probe's strings in `Diagnostics/Diagnostics-Core.lua`. Two pieces were built from the guide's rules because Magic Eraser's copy has no need of them: `ns:LogEventNow` in `Event-Log.lua`, and the `"spell"` kind in `Validate-Data.lua`.

Control Freak's own manifests:

- **`ns.DIAGNOSTIC_API_CHECKS`** has rows for every API the add-on calls or guards (the spell calls, the role and class-name lookups, the loss-of-control and aura calls, the Feign Death check, name plates, `C_Secrets`, the add-on message prefix and `Settings.OpenToCategory`) and for the load-bearing calls and libraries the core loop depends on. Validate Data appends a row per reader it calls.
- **`ns.DIAGNOSTIC_DATA_SOURCES`** has one row per flavor-folder file, `Abilities`, `Peer-Pressure-Abilities`, `Armor-Debuffs`, `Items` and `Sample-Spells`, so the Data tab validates all five `{Folder}/{Table}-{Folder}.lua` files for whichever folder this client loaded. `Items` is keyed by item ID and prints each item beside the spell it casts, and `Sample-Spells` is keyed by the name each panel asks for, so its only shipped column is that key. **`ns.ITEMS` has no reader in the feature code.** It exists so the Data Review can search for item families from the item side: the combat log names only the spell, and some items reach their effect through a summoned creature or a placed object (the Battle Chicken, Atiesh's portal) that no spell table links back to the item. Its `DATA_TRACKED` column marks the items whose `spell` an Abilities row listens for. Each spell ID gets every reader the client ships, the row's own fields as `DATA_*` columns, and `DATA_ROW_NAME`, the client's name for the row's first resolving ID: a `NAME` that disagrees with it is an ID that belongs to a different spell, unless `DATA_RENAMED` says the rename is real. `SPELL_INFO` prints `C_Spell.GetSpellInfo` as returned, and both target clients hand its range pair back transposed (a 35 yard spell reads `minRange=35; maxRange=0`).
- **`ns.DIAGNOSTIC_NAME_LOOKUPS`** has a row per ability, read the way the index labels it, a male and a female row per Tank Deaths class through `ns.ClassName`, and a row per spell the panels' Example lines name through `ns.SampleSpell`.

**Alert Context** (Settings tab, `ns:BuildAlertContextReport`) is the add-on's context probe and the first thing to read on a "nothing ever fires" report. It prints the active profile and All Alerts; each feature's scope settings, only the questions its tab asks, with the `ns:IsFeatureGateOpen` verdict; the group and instance state; the current target's Against rung; whether the combat log is actually registered; who counts as a tank, which Tank role tags a raid is ignoring, and whether a tank is alive; the group chat channel an announced line would use and whether the whisper election's message prefix registered; every alert section's switch, rows, target filters and sound, with whether the stored sound name still resolves; the `Sound_EnableAllSound` and `Sound_MasterVolume` CVars, since every alert plays on the Master channel; the ability rows this client drew, how many each tab has unticked, and how each taunt that can go either way is being reported; whether the client has the `C_LossOfControl` pair and what is active now; and how many Peer Pressure rows the player's class draws and has ticked. **Display Context** answers mini-map button reports with the screen size, UI scale and the button's saved state. **Saved Variables** prints every row, `ignoredSpells` and `tauntKinds` included. **Message Length** (Localization tab) builds every line the add-on can send to chat through `ns:BuildAnnounceMessage`, with the longest spell, boss, seat and dispel names this client gives and a twelve-letter two-byte player name, and flags any over 255 bytes; it sends nothing.

Diagnostics strings live in `ns.DiagnosticsStrings` as plain English and are never added to `Locales/`. The one localized string the panel reads is `L["ADDON_TITLE"]`.

## Saved Variables

One SavedVariables global, `ControlFreakDB`, managed by AceDB-3.0 and created on `PLAYER_LOGIN` in `Features/Core.lua`. It holds every setting the player can change, and nothing else.

**Model: Simple.** `AceDB:New(ns.SAVED_VARIABLES_NAME, ns.DATABASE_DEFAULTS, true)` gives every character the one shared `Default` profile, so everything lives in `ns.db.profile` and `ns.db.global` is unused. Nothing Control Freak stores differs from character to character: every key describes how the add-on behaves, and `ignoredSpells` is a choice about abilities rather than a record of what one character knows. **Reset Profile therefore clears everything back to install defaults**, the mini-map position, the ignored abilities and the taunt kind picks included. A new setting belongs in `ns.db.profile`.

The profile's shape, from `ns.DATABASE_DEFAULTS` in `Data/Default-Settings.lua`:

- `showWelcome`, `enabled` (All Alerts), and `minimap`, which LibDBIcon owns.
- One table per key in `ns.FEATURE_KEYS`. `FeatureDefaults` gives each `enabled` and the scope keys its `ns.FEATURE_SCOPE_OPTIONS` entry names; `WhoseAlertDefaults` builds its alert sections (see Alert Sections); and any setting the feature owns outright sits beside them, such as `tankDeaths.classes` and `badPets.whisper` and `badPets.cooldown`.
- `ignoredSpells`, keyed by spell ID and shared by every feature: `true` unticks a row, and `false` ticks a `shipsOff` row. It ships empty and stays a diff against the data.
- `tauntKinds`, the Taunts tab's Single Target / AOE picks, keyed by the entry's first trigger ID. It ships empty and stays a diff: the dropdown stores a pick only when it differs from the data's `isAoe` and clears the key when it matches, so Reset Profile puts every row back on the data.

AceDB-3.0 applies `ns.DATABASE_DEFAULTS` when the profile is first accessed, filling only keys the saved table lacks, so an explicit `false` is never overridden, and strips values equal to their defaults when it saves. Control Freak defines no `*` or `**` wildcard defaults.

**There is no refill-on-empty logic**, because the add-on ships no default item or spell list. `ignoredSpells` is a settings map rather than a list: a player who unticked every ability meant it, and re-seeding it on login would undo the choice. The ability data is static Lua in the flavor folders and is never saved.

**There is no migration chain.** Profiles saved under earlier shapes of the data carry no bridge, by the maintainer's decision: those settings fall back to their defaults, and their stale keys (`badPet`, `taunts.stolen`, and an alert section's old `print`, `announce` and `bossOnly`, among others) stay in the file unread until a profile reset clears them. What a future change to saved data owes is under Contributing, and why a retired key name is never reused is under Common Pitfalls.

`ns:ApplyProfile`, wired to `OnProfileChanged`, `OnProfileReset` and `OnProfileCopied`, makes a switch, reset or copy apply live: it re-runs the combat-log registration test, re-points the mini-map button, and notifies every registered panel so an open Options Interface follows along.

## Adding a New Ability

1. Add one entry to `ns.ABILITIES` in the `Abilities-{Flavor}.lua` of every flavor folder where the ability is live, in its class block, with the ability's name in the trailing comment on the closing brace. An item goes in the `ITEM` block with the category of what its Use does, and its row in that folder's `Items-{Flavor}.lua` names the same spell.
2. Leave it out of every folder where it does not exist, where its ID belongs to a different ability, or where it must not be tracked, and say which folders got it.
3. Set `detection`: `AURA` only if the ability applies an aura on every flavor it is live on, otherwise `CAST`.
4. List every castable rank in `triggers`, in rank order, since the row takes its name from the last one that resolves, with no effect IDs or learn triggers, unless the cast lands nothing the combat log can see, as with Righteous Defense (see Ability Data).
5. Set `renamed = true` only for a verified rename across the entry's ranks or flavors.
6. Set `kindChoice = true` only on a taunt that takes a few mobs rather than one or a whole pack, and only with `AURA` detection; `isAoe` is then the row's default.
7. For a new category, map it in `ns.CATEGORY_FEATURE` in `Features/Ability-Index.lua`, add its branch at the end of `ns:COMBAT_LOG_EVENT_UNFILTERED`, and pass it to the `ns.BuildAbilityToggles` call on the owning tab's Tracked Abilities sub-panel. The category lists in each `Abilities-{Flavor}.lua`'s comments are the Data Review's to update.
8. On a live client of each flavor, run Diagnostic Tools → Data → Abilities, and check that the new rows read `OK`.

## Adding a New Alert Section

1. Add the section's defaults to its feature's table in `Data/Default-Settings.lua` through `WhoseAlertDefaults(soundName, overrides, noTarget, rowKeys)`, with the reason beside any override. Pass `true` for `noTarget` when the line names no single mob.
2. Add its strings to `Locales/enUS.lua`: a `_HEADER`; an `_ENABLE` reading "Enable Alerts for <thing> On", so the Against ladder finishes the sentence (a `noTarget` section drops "On"); a `_DESC` of one or two sentences; and a `_MINE` and `_OTHERS` pair, per section rather than a template, because "My" and "Others'" agree with the noun in some languages.
3. Add the message format, and add it with its part kinds to `ALERT_FORMATS` in `Diagnostics/Manifests.lua`, which is the list Diagnostic Tools → Localization → Message Length measures; a format left off it is never measured. It has to fit 255 bytes in ruRU with a real spell link and a real boss name substituted.
4. Call `ns.AddWhoseAlertSection` in the tab's builder, 20 of order after the previous section, with `sample = { key, args }` naming that format.
5. Call `ns:Alert` from the handler with the section, the format key, its parts, the source flags, and the mob's GUID and raid-icon index. A section whose rows are not My and Others' also passes the `rowKey` as the seventh argument, the same word as its `rows` entry and its `WhoseAlertDefaults` row key.
6. If the section whispers, draw the row through `afterSample` and `ns.AddWhisperRow`; in the handler, call `ns:PassesAlertGates` before the cooldown, and send through `ns:QueueGroupWhisper` with a new `kind`.
7. If the section is a new Tanking Tool, it gets a sub-panel rather than a place on the parent tab: add a `{ key, headerKey, registry }` row to `ns.TANKING_TOOLS`, its registry name to `ns.OPTIONS_REGISTRY`, and a builder in that file named `ns.Build<registry>Options` that calls its `ToolPanel`. Registration, the root panel's switch and the sub-panel's order all follow from the list.

## Adding a New Feature Tab

1. In `Data/Data.lua`, add the key to `ns.FEATURE_KEYS` in tab order, its scope questions to `ns.FEATURE_SCOPE_OPTIONS`, and its registry name to `ns.OPTIONS_REGISTRY`.
2. Add its defaults to `Data/Default-Settings.lua` through `FeatureDefaults`.
3. Add `Features/<Name>.lua` with the handler, appending any per-fight state's reset to `ns.stateResets`. If the tab owns an ability category, map it in `ns.CATEGORY_FEATURE`. If its trigger is not the ability path, the handler checks All Alerts and asks `ns:IsFeatureGateOpen` itself, as Incapacitated and Tank Deaths do.
4. Add `Options/Options-<Name>.lua` with a builder that opens on `ns.AddFeatureScope`. A tab with an ability list puts it on a Tracked Abilities sub-panel of its own, with its own registry name, built like `ns.BuildFearsTrackedOptions`, including its `ns.AddQuietStatus(args, 0.4, featureKey, tabKey)` status line.
5. Add both files to every flavor TOC: the feature file among the feature modules, before `Features/Minimap-Button.lua`, and the panel file in tab order, before `Options/Options-Profiles.lua`.
6. Register the panel in `ns.RegisterOptionsPanels` in tab order, ahead of Profiles and Diagnostic Tools, with any sub-panel right after it through `AddSubPanel`.
7. In `Options/Options-General.lua`, add the key to `FEATURE_CAPTION_KEYS`, `FEATURE_ICONS` and a tier in `FEATURE_TIERS`, or the root panel's Features block never draws its switch.
8. Add the `TAB_*` key to `Locales/enUS.lua` in the tab-order block, with the tab's `_SUMMARY` and `_ENABLE`, and the root panel's `FEATURES_*` caption.

The combat-log registration test and the Alert Context report both loop over `ns.FEATURE_KEYS`, so neither needs an edit.

## Adding a New Registered Event

1. Add the name to `ns.EVENT_NAMES` in `Features/Core.lua`, so the dispatcher and the Diagnostics registration probe pick it up together.
2. Define `ns:<EVENT_NAME>` in the feature file that owns it. Never call `RegisterEvent` from a feature file.
3. If the event is a firehose, add it to `ns.DIAGNOSTIC_EVENT_EXCLUDE`, and have its handler write the firings it acts on through `ns:LogEventNow`.
4. If the event triggers an alert outside the combat-log path, its handler checks All Alerts and its feature's scope gates itself.

## Adding a New Sound

1. Add an `.ogg` to `Includes/Sounds/`, one to two seconds long, since it fires mid-pull on top of everything else. `PlaySoundFile` plays `.mp3` too, but the Vorbis file is a third to a quarter of the size; on macOS, `afconvert -f Oggf -d vorb in.mp3 out.ogg` converts it.
2. Add a `{ picker name, file name }` row to `ns.SOUNDS` in `Data/Data.lua`. The picker name says which alert the sound was made for, not what it sounds like; a spare made for no alert in particular is the one sound named for how it sounds.
3. To make it an alert's default, point that section's `soundName` at it in `Data/Default-Settings.lua`. Which sound an alert plays out of the box is that file's call, not the name's, so an alert can default to a spare and a sound made for an alert can end up nobody's default.

**Never rename a published picker name** to match the alert that now plays it, or for any other reason: profiles store the name, and a name the list no longer registers leaves that alert silent behind a blank picker.

## Localization

`Locales/enUS.lua` is the source of truth and the only file that passes the `true` default-fallback flag. The other ten translate its key set and belong to the Localization Review (`07 - Localization Review.md`), so they are never hand-edited during ordinary work. A retired key name is never reused, because a stale translation of it would silently win over the English fallback.

**The AceLocale name is `ControlFreak` (`ns.LOCALE_NAME`), not `ADDON_NAME`.** The installed folder is `Control-Freak`, and every `NewLocale()` uses the brand literal. `Data/Data.lua` defines the constant and derives the add-on message prefix from it, and `Features/Minimap-Button.lua` uses it for the LDB object and the LibDBIcon key. `ADDON_NAME` stays for what is keyed off the packaged add-on: metadata reads, registry names, the spell-toggle widget type and sound paths.

**Placeholders must match `enUS` per key in every locale**, in count, type and order, or the string crashes the first time that alert fires. `string.format` has no positional placeholders, so a translation moves words around its placeholders and never the placeholders themselves. The orders that need care are noted beside their keys in `enUS.lua`:

- `TAUNT_IMMUNE` runs mob, taunter, taunt; every other taunt format opens on the taunter.
- The four `INCAPACITATED` formats run role, length, player, spell, dispel type, caster, each dropping its optional parts.
- `TANK_DEATHS_CLASS_LINE` takes the class name first and the player second.
- `ALERT_AGAINST_DESC` quotes `TARGET_RUNG_ELITE_0` and `ALERT_MARKED_ALWAYS` by name, so all three must match or the tooltip explains a choice the player cannot find.

**Game names come from the client by ID, never from `Locales/`.** Spell names come from the trigger IDs in each flavor folder's `Abilities-{Flavor}.lua`, `Peer-Pressure-Abilities-{Flavor}.lua` and `Armor-Debuffs-{Flavor}.lua`, through `ns.GetSpellNameAndIcon` (`C_Spell.GetSpellInfo`) for the panel rows and `ns.GetSpellLink` (`C_Spell.GetSpellLink`) for the alert lines. The Example lines name spells from `ns.SAMPLE_SPELL_IDS` in each flavor folder's `Sample-Spells-{Flavor}.lua`, as links through `ns.SpellPart`, the same part a live alert renders. Diagnostics' Game Names report reads the same IDs through `ns.SampleSpell`, which falls back to `UNKNOWN_SPELL` rather than an English name. The roster names in `ns.SAMPLE_NAMES` are proper names, the same in every locale, so they live in `Data/Data.lua` rather than in `Locales/`. Class names come from the client through `ns.ClassName`, never from the locale files, so they match the tooltips beside them. A line about a person passes their sex, so a female character's class reads in its female form where the language has one (Incapacitated's opener and Tank Deaths' class log); the client's female column is blank in enUS and itIT, and a blank answer falls back to the male name. The sample boss names are locale keys (`SAMPLE_BOSS_*`), written exactly as each client names them. The Tank and Healer words that open an Incapacitated line (`INCAPACITATED_ROLE_TANK`, `INCAPACITATED_ROLE_HEALER`) are our own translations rather than the client's role labels, which name a role rather than a person and read wrongly as the subject of a chat line; `README-Notes.md` records the exception. Not localized: `ns.DiagnosticsStrings`, which is developer-facing.

Everything else, including the Spanish file pairing and the overflow canary, is per Style Guide → LOCALIZATION and MESSAGES → Message Length.

## Common Pitfalls

- **Stripping pipes or color codes from a sent body**: a spell link is one escape sequence, so the client drops the whole message with no error. `ns.StripChatFormatting` converts the raid-icon texture and nothing else.
- **Cutting a sent message with `string.sub` at 255**: the cut lands inside a link or a multi-byte character, and the message is dropped or mangled. `ns:Announce` cuts through `SafeCutLength`.
- **Reading the miss type from the wrong return slot**: `SWING_MISSED` puts it twelfth and `SPELL_MISSED` fifteenth, and the wrong one compares a number to `"PARRY"` forever. `ns:COMBAT_LOG_EVENT_UNFILTERED` normalizes both before dispatching.
- **Replacing `ns.ABILITY_MAP` rather than refilling it**: `Features/Combat-Log.lua` aliases the table at load and would go on reading the empty original. `ns.BuildAbilityIndex` wipes and refills.
- **Treating `ns.GetEnemyTier` as a boolean**: `nil` means unanswerable and has to pass. The filter tests `tier == nil` by name.
- **Throttling alerts on a time window**: it merges a cast with the miss that follows it and eats every resisted taunt. The dedupe keys on timestamp, caster's GUID, spell ID and outcome, plus the mob's GUID for a taunt reported as Single Target.
- **Starting a cooldown before the gates**: an event the filters drop uses up the window and swallows the next real one. Whispering features call `ns:PassesAlertGates` first, and Incapacitated reads its row's switch first.
- **Comparing names in the whisper election**: `CHAT_MSG_ADDON` reports `Name-Realm` while the client's own name APIs drop your realm, so a name never matches your own and the echo filter silently stops working. The election compares player GUIDs, for the echo filter and the tie-break alike.
- **Passing `control` to a section that has a target**: the builder overwrites it with the Against ladder, and the control silently disappears. A parameter of the detection goes in `captionRow`.
- **A `rows` key the defaults do not build**: the key is the settings key, the widget key and the `rowKey` at once, so the panel's `rows`, `WhoseAlertDefaults`' fourth argument and the handler must all use the same words, or the panel writes to a row `ns:Alert` never reads.
- **Adding a `groupHasTank` default to a tab that does not ask it**: `ns:IsFeatureGateOpen` still reads the key, so the tab would be gated by a switch nobody can see. `ns.FEATURE_SCOPE_OPTIONS` decides which keys exist.
- **Reusing a retired saved-variables key**: profiles still carry keys from earlier data shapes, and AceDB fills a table default only into a slot that is empty or already a table. A new table under an old key that a profile holds as `true`, a number or a string never receives its defaults, and the first read into it errors. Give new data a fresh key.
- **Capturing `ns.db.profile` in a panel closure**: a profile switch replaces the table, and the panel keeps writing into the old one. Every builder takes a getter.
- **Flipping an `enabled` or `instanceOnly` flag without `ns:ApplyProfile`**: the combat log stays registered for a feature just switched off, or unregistered for one just switched on.
- **Two builders writing the same args key**: AceConfig args are one flat table per panel, so the later write silently replaces the earlier widget. `ns.AddGatedHeader` suffixes its keys, and `ns.BuildAbilityToggles` has no key prefix, so a panel calls it once with every category it lists.
- **Reading `ability.isAoe` for a taunt**: it ignores the player's Single Target / AOE pick on a `kindChoice` row, so the line lands in the wrong section and its misses go unreported or reported against the player's choice. Taunt code reads `ns.IsAoeTaunt(ability)`; only Fears, Novas and Bad Pets, which have no pick, read `isAoe` directly.
- **`LibDBIcon:Show` or `Hide` after a profile reset**: the button keeps writing to the detached old `minimap` table. Always go through `ns:ApplyMinimapButton`.
- **Registering an event in a feature file**: the dispatcher never routes it and the Diagnostics probe never tests it. Add it to `ns.EVENT_NAMES`.
- **Reading `spellId` from a `LossOfControlData`**: it is `spellID` there and `spellId` on an `AuraData`, and the wrong case compares `nil` and never matches.
- **`dialogControl = "LSM30_Sound"` on the sound picker**: that widget lives in AceGUI-3.0-SharedMediaWidgets, which Control Freak does not ship, so the panel would work only where another add-on happened to load it. The picker is a plain `select` over `ns.GetSoundValues`.
- **Renaming an entry in `ns.SOUNDS`**: profiles store the picker name, so every profile using it goes silent behind a blank picker.
- **Retaining references in the event log**: some events carry frames or tables that leak or go stale. `ns:LogEvent` snapshots each argument to a string, caps the count and length, and escapes pipes after the cut so a truncated argument cannot leave a dangling pipe.
- **Adding `GITHUB_OAUTH` or `GITHUB_API_TOKEN` to Common-Core's `package.yml`**: given either, the packager overwrites the GitHub release's name and hand-written notes with a commit-message changelog on every build. The workflow sets neither, on purpose.

## Contributing

Issues go to [GitHub Issues](https://github.com/Gogo1951/Control-Freak/issues). For anything conversational, the [Discord](https://discord.gg/eh8hKq992Q) is faster.

**A bug report needs** your game version and flavor (Classic Era, Season of Discovery or TBC Anniversary), client locale, class and level, whether you were solo, in a party or in a raid, the steps that reproduce it, and the exact chat line or whisper you got. Diagnostic Tools builds most of that: enable it, open the Settings tab, press **Run All Settings Reports**, and paste the output. For "it never fires", add an **Event Log** capture (Run Tests tab) around one attempt.

**Pull requests:**

- Keep the scope to one behavior.
- Match the surrounding code: run StyLua with its default configuration, then `luac -p` and a clean `luacheck .`, and fix a luacheck warning rather than widening the config.
- Any change to the shape, name or scope of saved data ships its own migration, tagged with a removal date 30 days past the release that ships it.
- Measure any new or reworded chat line or whisper against the 255 byte ceiling in ruRU, with a real spell link and real names substituted.
- Edit only `Locales/enUS.lua`; the translations belong to the Localization Review.
- Update this document in the same change when the architecture, the File Map or the saved-variables shape moves.

**A pull request description says what a player will notice**, in plain language, the way release notes do: "Righteous Defense can now report each mob it takes", not the function that changed. The commit messages carry the developer detail.
