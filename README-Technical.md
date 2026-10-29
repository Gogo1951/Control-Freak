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
│   ├── Data.lua                                  Locale init, palette, registry names, ladders, feature groups, options grid, sample names, sounds
│   ├── Default-Settings.lua                      The AceDB defaults, with the reason each one ships as it does
│   └── {Flavor}/                                 Vanilla, Discovery, TBC, Camelot, Wrath, Mists, Mainline, one complete copy each
│       ├── Abilities-{Flavor}.lua                Every ability this flavor watches, one entry per checkbox
│       ├── Peer-Pressure-Abilities-{Flavor}.lua  Peer Pressure's class cooldowns, in the same row shape
│       ├── Armor-Debuffs-{Flavor}.lua            The debuffs the Armor Debuffs tool waits on
│       ├── Items-{Flavor}.lua                    Items that act on someone else; only Validate Data reads them
│       └── Sample-Spells-{Flavor}.lua            The spells the panels' Example lines name
├── Diagnostics/                                  Diagnostic Tools from Magic Eraser; Manifests.lua holds Control Freak's rows and probes
├── Features/
│   ├── Core.lua                                  Version, ns.EVENT_NAMES, the dispatcher, AceDB init and migrations, the login sequence
│   ├── Utilities.lua                             Colors, spell lookups, combat-log flag tests, group, tank and class lookups, tooltip readers
│   ├── Ability-Index.lua                         The ability map and groups, the ignore list, taunt kinds, category to tab
│   ├── Alert-Gates.lua                           Group switches, per-feature scope gates and the combat-log registration test
│   ├── Enemy-Tier.lua                            Against-ladder classification and its per-mob cache
│   ├── Enemy-Target.lua                          Who each mob was last seen swinging at
│   ├── Announcements.lua                         Sounds, prints, sent chat and the safe cut, ns:Alert and its parts
│   ├── Whisper-Election.lua                      One whisper per culprit however many Control Freak clients see it
│   ├── Combat-Log.lua                            The combat-log handler, its dedupe, and the miss and armor dispatch
│   ├── Taunts.lua                                Taunt lines, quiet on a mob already hitting the taunter
│   ├── Interrupts.lua                            Interrupt lines, recovering the spell ID Era omits
│   ├── Fears.lua
│   ├── Incapacitated.lua                         Loss-of-control alert, the one the combat log does not trigger
│   ├── Tank-Deaths.lua                           Tank death alert and the print-only class log
│   ├── Tanking-Tools-Cold-Opener.lua             Avoided openers and the per-mob pull clock
│   ├── Tanking-Tools-Armor.lua                   Armor debuff stack-up timing
│   ├── Bad-Mages.lua                             Frost Nova on a pull, and its whisper
│   ├── Bad-Parry-Monkeys.lua                     Parries from a mob somebody else holds, and Parry Monkey's confession
│   ├── Bad-Pets.lua                              Pet taunts left on auto-cast, and the owner whisper
│   ├── Bad-Priests.lua                           Power Word: Shield on a rage tank, and its whisper
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
│   ├── Options-Alert-Section.lua                 The alert block, its Print and Announce rows, whisper rows, Example lines
│   ├── Options-Ability-Toggles.lua               Spell-toggle widget, the per-class ability lists, the taunt kind column
│   ├── Options-General.lua                       Root panel (Master Switch, the Features block) and the Monitoring and Naughty List pages
│   ├── Options-Taunts.lua                        Taunts tab and its Tracked Abilities sub-panel
│   ├── Options-Interrupts.lua
│   ├── Options-Fears.lua                         Fears tab and its Tracked Abilities sub-panel
│   ├── Options-Incapacitated.lua
│   ├── Options-Tank-Deaths.lua
│   ├── Options-Peer-Pressure.lua                 Peer Pressure tab and its Tracked Abilities sub-panel
│   ├── Options-Bad-Mages.lua
│   ├── Options-Bad-Parry-Monkeys.lua             Parries and Parry Monkey, with the confession's message box
│   ├── Options-Bad-Pets.lua                      Bad Pets tab and its Tracked Abilities sub-panel
│   ├── Options-Bad-Priests.lua
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

`Data/`, `Features/` and `Options/` are listed in TOC load order rather than alphabetically, because files read at load what an earlier file built: `Features/Combat-Log.lua` aliases the `ns.ABILITY_MAP` that `Features/Ability-Index.lua` creates, `Features/Enemy-Tier.lua`, `Features/Tanking-Tools-Armor.lua` and `Features/Bad-Pets.lua` alias the unit tokens `Features/Utilities.lua` builds, `Features/Tanking-Tools-Armor.lua` indexes `ns.ARMOR_DEBUFFS` from the flavor folder, `Options/Options-General.lua` reads the `ns.TANKING_TOOLS` list declared in `Options/Options-Tanking-Tools.lua` only when it builds, and every file with per-fight state appends to the `ns.stateResets` list `Features/Core.lua` creates. `Includes/Libraries/` is rewritten from `.pkgmeta` by the release workflow on every tag, so a hand edit there is lost at the next release.

Files that must stay gone: `Features/Tanking-Tools-Parry.lua`, replaced by `Features/Bad-Parry-Monkeys.lua` when Parries left Tanking Tools for the Bad Parry Monkeys tab; `Features/Tanking-Tools-Nova.lua`, replaced by `Features/Bad-Mages.lua` when Novas left Tanking Tools for the Bad Mages tab; `Features/Tanking-Tools-Bubble.lua`, since the paladin bubbles are parked (see Bad Priests); `Features/Bad-Pet.lua` and `Options/Options-Bad-Pet.lua`, replaced by the plural `Bad-Pets` pair and its `badPets` key; `.mp3` copies of the sounds, which ship as `.ogg` only (see Adding a New Sound); the unsuffixed `Control-Freak.toc`, since every flavor has its own, and a `Control-Freak_Camelot.toc`, since there is no WoW Forever release; `Data/Abilities.lua`, split into the flavor folders' `Abilities-{Flavor}.lua`; `Features/Diagnostics.lua` and `Options/Options-Diagnostics.lua`, replaced by the `Diagnostics/` folder; `Options/Options-Apology.lua`, the dated post-rebuild letter, retired; and the pre-rebuild `Core.lua` and `Options.lua` at the repo root, with `Data/Vanilla.lua`.

## Architecture

### Event Loop

`Features/Core.lua` owns the add-on's only event frame. Every event routes through one dispatcher, which makes a guarded diagnostics call and then calls the namespace method named for the event: `On` plus the event in CamelCase, built once from `ns.EVENT_NAMES` into `EVENT_HANDLERS`, so `PLAYER_LOGIN` lands on `ns:OnPlayerLogin`.

```lua
frame:SetScript("OnEvent", function(_, event, ...)
	if ns.diagnostics and ns.diagnostics.logging then
		ns:LogEvent(event, ...)
	end
	local name = EVENT_HANDLERS[event]
	local handler = name and ns[name]
	if handler then
		handler(ns, ...)
	end
end)
```

No feature file registers an event for handling: `Features/Core.lua` toggles the combat log on its own frame (`ns.eventFrame`), and the Diagnostics registration probe uses a throwaway frame with no handler. That single tap point is what lets the Diagnostics event log capture everything, and it is why a new event goes into `ns.EVENT_NAMES` rather than into a `RegisterEvent` call in a feature file.

| Event | Handled in | What it drives |
|---|---|---|
| `PLAYER_LOGIN` | `Features/Core.lua` | AceDB, the player GUID, the add-on message prefix, the ability index, the panels, the mini-map button, `ns:ApplyProfile`, the welcome |
| `PLAYER_ENTERING_WORLD` | `Features/Core.lua` | Clears per-fight state and re-tests combat-log registration |
| `ZONE_CHANGED_NEW_AREA` | `Features/Core.lua` | Re-tests combat-log registration |
| `CHAT_MSG_ADDON` | `Features/Whisper-Election.lua` | Other clients' whisper bids |
| `UNIT_SPELLCAST_INTERRUPTED` | `Features/Interrupts.lua` | The interrupted spell ID that Era's combat log omits |
| `GROUP_ROSTER_UPDATE` | `Features/Bad-Parry-Monkeys.lua` | Parry Monkey's count going back to zero on joining a raid |
| `LOSS_OF_CONTROL_ADDED` | `Features/Incapacitated.lua` | The Incapacitated alert |
| `COMBAT_LOG_EVENT_UNFILTERED` | `Features/Combat-Log.lua` | Every other alert |

**`COMBAT_LOG_EVENT_UNFILTERED` is the one event not registered at load.** The file-local `UpdateCombatLogRegistration` in `Features/Core.lua` registers it while `ns:IsAlertGateOpen()` in `Features/Alert-Gates.lua` says some feature could fire, and unregisters it otherwise, so a client with All Alerts off, every feature or group switch off, or every enabled feature limited to instances while it is outside one, is not woken for every combat line in the zone. `ns:ApplyProfile`, `PLAYER_ENTERING_WORLD` and `ZONE_CHANGED_NEW_AREA` re-run the test, and between them they cover everything it reads: the settings and the zone. Every control that changes one of those settings calls `ns:ApplyProfile` for that reason: **All Alerts**, a group switch, a feature's enable (on its tab and on the General panel), **While in Instances**, and every mini-map toggle. **When Group Has a Tank**, the role dropdown and a Tanking Tool's own switch write without it, because the test never reads them (see Scope Gates).

**The events outside the combat log ask their own gates.** `LOSS_OF_CONTROL_ADDED` is registered flat: it fires only while the player is crowd controlled, so gating its registration would cost more bookkeeping than it saves, and its handler checks All Alerts and the Incapacitated tab's gates itself. `ns:HandleUnitDeath` does the same for Tank Deaths, because `UNIT_DIED` reaches it ahead of the ability lookup, where the gates are otherwise applied. Within the combat log, every branch that runs ahead of that lookup (Interrupts, the miss dispatch and armor) asks its own feature's `ns:IsFeatureGateOpen`. All Alerts itself is never re-read on the combat-log path: with it off, the event is unregistered.

**Per-fight state lives in the file that owns it.** Each such file appends a clearing function to `ns.stateResets`, and Core runs the list on `PLAYER_ENTERING_WORLD`, so Core knows nothing about what any feature keeps.

### Combat Lockdown

Control Freak writes no macros and drives no protected frames, so there is exactly one combat guard. `ns:OpenOptionsPanel` in `Options/Options.lua` checks `InCombatLockdown()` first, prints `L["CHAT_OPTIONS_IN_COMBAT"]`, and returns. It never queues and never retries. Blizzard's Settings panel is protected in combat, and without the gate the player gets an `ADDON_ACTION_BLOCKED` error naming the add-on.

The gate lives inside the opener and nowhere else: `/freak` and the mini-map button's Shift + Middle-Click both call the opener and add no check of their own.

Everything else is a read followed by a print, a sound, a chat message or an add-on message, all of which work in combat. Nothing waits for combat to end, so there is no dirty flag and nothing to replay; the one gameplay timer in the add-on is the whisper election's hold (see Whisper Election), and combat has no bearing on it.

### Classify, Gate, Dispatch, Render

One combat-log line takes the same path every time, ordered so the cheap tests run before the expensive ones. `ns:OnCombatLogEventUnfiltered` in `Features/Combat-Log.lua` reads `CombatLogGetCurrentEventInfo` once, then:

1. **Takes the branches that need no tracked ability.** They run first because the ability lookup drops every spell ID the add-on does not own, which is all of theirs.
   - A debuff landing on the player, or an interrupt aimed at them, stamps its caster's name for Incapacitated, while that tab and its section are on (see Incapacitated).
   - `SPELL_INTERRUPT` runs its own source and scope gates, calls `ns:HandleInterrupt`, and returns.
   - Melee swings record which player each mob is hitting (see Taunts).
   - While the Tanking Tools tab and its Cold Openers section are both on, both GUIDs stamp the per-mob pull clock. Both ship off, so nothing is stamped out of the box.
   - `UNIT_DIED` calls `ns:HandleUnitDeath`.
   - `SWING_MISSED` and `SPELL_MISSED` go to the file-local `DispatchMiss`, which feeds Cold Openers and Bad Parry Monkeys, and armor aura changes go to `ns:HandleArmorDebuffs`.
2. **Classifies.** Swings stop here. `ns.ABILITY_MAP` turns the spell ID into an ability entry, or the line is dropped.
3. **Gates.** The ignore list (`ns.IsAbilityIgnored`), `ns.IsGroupSource`, the pet-source test for `PET_TAUNT`, then `ns:IsFeatureGateOpen` for the feature that `ns.CATEGORY_FEATURE` maps the category to. An AOE taunt passes `skipTankCheck`, so it reports through the tab's When Group Has a Tank: the press that matters most comes the moment the tank dies, which is exactly when the group stops having one.
4. **Decides the outcome.** An `AURA` ability succeeds on `SPELL_AURA_APPLIED` or `SPELL_AURA_REFRESH`, a `CAST` ability on `SPELL_CAST_SUCCESS`, and a `SPELL_MISSED` on a taunt reported as Single Target (`not ns.IsAoeTaunt(ability)`, see Taunts) is a failure. `SHIELD` counts only `SPELL_AURA_APPLIED`: a shield kept rolling reapplies constantly, and every refresh is the mistake already reported. The dedupe key runs last (see State Encoding).
5. **Dispatches** to the owning file's handler (`ns:HandleTaunt`, `ns:HandleFear`, `ns:HandleNova`, `ns:HandleBadPriest`, `ns:HandleBadPets` or `ns:HandlePeerPressure`), which picks the section and the message format.
6. **Renders** through `ns:Alert` in `Features/Announcements.lua` (see Alert Sections).

**`DispatchMiss` reads the section switches first.** Every miss in the zone reaches it, and the gates behind it read the group's tank state, which is the expensive question. Cold Openers takes only `SPELL_MISSED` and Bad Parry Monkeys takes both, for reasons their sections give; each then runs behind its own feature's `ns:IsFeatureGateOpen`.

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

**`roleScope` and `instanceOnly` are on every tab; `groupHasTank` is the one that varies.** The first two ask about the player, so there is no alert they cannot sensibly narrow. `groupHasTank` is the only question about somebody else, and it belongs to alerts about a mob a tank should be holding: Taunts, Tanking Tools and the four Bad tabs, all of which ship it on. Interrupts, Fears, Incapacitated and Peer Pressure are worth hearing whether or not the party has a tank, and Tank Deaths must not ask, because a tank dying is the moment the group stops having one.

Two functions in `Features/Alert-Gates.lua` read these settings, and the split is load-bearing:

- **`FeatureCouldFire`** (file-local) decides whether `COMBAT_LOG_EVENT_UNFILTERED` is registered at all, through `ns:IsAlertGateOpen`. It reads `enabled`, the feature's group switch and `instanceOnly`.
- **`ns:IsFeatureGateOpen`** runs per event, calls `FeatureCouldFire`, and adds `roleScope` and `groupHasTank`.

The seat questions stay out of the registration test because they read the raid's Main Tank assignment and the group finder's role. The role has `PLAYER_ROLES_ASSIGNED` behind it, but the assignment fires nothing reliable, so a registration keyed on them could leave the combat log unhooked with no event to put it right. Zone changes do fire events, so zone can gate registration.

**`roleScope` is a ladder, not a pair of boxes.** `ns.ROLE_SCOPES` runs narrowest first, and `PassesRoleFilter` treats `TANK_HEALER` as an OR, since nobody tanks and heals at once and an AND would mean "never". Tanking is `ns.IsUnitTank` in `Features/Utilities.lua`: the Main Tank assignment in a raid and the group finder's TANK role in a party, never Main Assist. In a raid the role is ignored: it is a tag that sticks to the character from a dungeon queue, and counting it would report a healer's death as `Tank Down!`, so the maintainer's rule is that a player not set up as a tank in the raid frames is not a tank in a raid. A raid with nobody assigned Main Tank therefore has no tank as far as the add-on can tell, and every tab gated on `groupHasTank` stays quiet there until somebody assigns one, a cost the maintainer accepted rather than an oversight to fix. Healing is the HEALER role alone, in a raid too, because the game has no raid assignment for healing. `ALWAYS` ships on every tab but two: Incapacitated ships at `TANK_HEALER` and Bad Priests at `TANK`. A stored rung a later version drops resolves through `ns.ResolveChoice` to `ns.ROLE_SCOPE_DEFAULT`, which is `ALWAYS`, so falling off the ladder widens a tab rather than silencing it. A missing `roleScope` still means "this tab does not ask", so it must stay distinguishable from a stored rung and never be folded into that default.

A ladder-shaped scope question goes in the slot beside the feature's enable rather than on a row under it (`SCOPE_CHOICES` in `Options/Options-Feature-Scope.lua`), and it takes its default from `SCOPE_DEFAULTS` in `Data/Default-Settings.lua` rather than the blanket `false` the switches get: a ladder has no off state, and a falsy value is what the gate reads as "not asked". The slot holds one widget, so a tab can ask at most one such question.

**All Alerts** (`ns.db.profile.enabled`, captioned Enable Control Freak) sits above every tab, alone under the General panel's Master Switch header, just above the Features block; `README-Notes.md` records why the panel keeps it. Turning it off closes `ns:IsAlertGateOpen`, which unregisters the combat log, and the two handlers outside the combat log read it themselves. It has no mini-map binding.

**Group switches sit between All Alerts and each feature's own.** `ns.FEATURE_GROUPS` in `Data/Data.lua` names Monitoring (Taunts, Interrupts, Fears, Incapacitated, Tank Deaths, Peer Pressure) and Naughty List (Bad Mages, Bad Parry Monkeys, Bad Pets, Bad Priests), and `ns.FEATURE_GROUP_OF` indexes it by feature. `ns.db.profile.featureGroups` stores each switch by key. A group switched off silences its features without touching their own switches, so switching it back on brings back exactly what was on. `FeatureCouldFire` asks it, so both the registration test and `ns:IsFeatureGateOpen` honour it. Anything but a stored `false` is on, so a profile saved before the groups existed fires as it did. The gates are handed a feature's table rather than its key, so `FeatureGroupIsOn` finds the key by identity, ten comparisons at most. Tanking Tools belongs to no group; its own switch already plays that part for its tools.

**The Features block.** Below All Alerts, the General panel repeats every tab's own switch, built by the same `ns.FeatureEnableToggle` the tab uses, so the two copies are one setting with one tooltip. The root copy is captioned with the tab's name through `FEATURE_CAPTION_KEYS` (`TAB_TAUNTS`, "Taunts"), so it reads as the settings tree does, with the icon `FEATURE_ICONS` gives it ahead of the caption; the tab's copy is its `_ENABLE` key ("Enable Taunt Monitoring"). They sit two to a line in three blocks, built in `Options/Options-General.lua`: a gold Monitoring switch, a gold Naughty List switch, and a gold Tanking Tools switch, the feature's own enable, over one switch per tool from `ns.TANKING_TOOLS`, bound to the same `enabled` as the tool's sub-panel. The rows under a block switch are indented (`ns.OptionsTogglePairs`' `indent`) and greyed out, not hidden, while it is off, so they still show what switching it back on restores. The Features block hides whole while All Alerts is off.

### Enemy Classification

The Against ladder keeps trash from crowding out the pulls that matter, and the combat log gives it nothing to work with: a mob arrives as a GUID, with no level, classification or elite flag. `ns.GetEnemyTier` in `Features/Enemy-Tier.lua` finds a unit token pointing at the same mob and reads the mob from there. It lives in its own file rather than in `Features/Utilities.lua` because it owns a per-fight cache and a `ns.stateResets` entry, and the utilities file holds shared functions with no per-fight state.

`FindEnemyUnit` scans in order of likelihood: `target`, since a single-target taunt needs one and just landed; `focus`, `mouseover` and `boss1` to `boss5`; every name plate; then the group's own targets, since a taunter's target is the mob they taunted. `UnitGUID` answers `nil` for a token the client does not have, so a missing frame costs one comparison rather than a capability probe.

The answer is a position on `ns.TARGET_RUNGS`, widest first, and `ns.TARGET_TIER` maps each rung to its position so a comparison is one table read:

| Rung | Label | A mob lands here when it is |
|---|---|---|
| `ALL` | Everything | None of the below |
| `ELITE` | Elites & Bosses | `elite` or `rareelite`, below the player's level |
| `ELITE_0` | Elites Your Level+ & Bosses | `elite` or `rareelite`, at or above the player's level |
| `BOSS` | Bosses | `worldboss`, or level `-1` (the "??" skull) |

A section stores one rung in `against`, and a mob passes when its rung is at or past that one.

**`ELITE_0` exists because a dungeon boss carries no skull.** To the client a dungeon boss is an elite, and level is the only thing separating it from the trash around it. Making `BOSS` include dungeon bosses would need a signal the combat log does not carry.

**Four rungs are enough because a raid mark overrides the rung.** `alwaysWhenMarked` lets the group name the pull that matters, so the ladder only has to describe a kind of enemy. `BOSS` therefore does not separate a raid boss from a world boss, and classification needs no `IsInInstance()` call.

**`nil` is a third answer, and it passes.** `ns.GetEnemyTier` returns `nil` when no token points at the mob, or when the GUID belongs to a player (Righteous Defense is cast on a group member). The filter tests `tier == nil or tier >= threshold`, never a falsy check: failing closed would trade a little trash noise for silently swallowing the boss taunt the filter was switched on for. Parry Monkey is the one reader that wants the opposite and counts only a mob it can prove is `BOSS` (see Bad Parry Monkeys).

The rung is cached per GUID, since a mob's level and classification do not change mid-fight. A player levelling up moves `ELITE_0` under a cached answer, and the next loading screen clears it.

### Per-Fight State

Everything that only means something inside one fight is cleared on every loading screen through `ns.stateResets`. The five tables that grow with the number of mobs or bids are also capped, and each is emptied whole when it fills rather than pruned: pruning costs a scan on a hot path, and emptying loses only a suppression, an expired window or a stale bid, never an alert that should have fired.

| Table | File | Holds | Cap |
|---|---|---|---|
| `tierByGUID` | `Features/Enemy-Tier.lua` | Against rung per mob | 500 |
| `enemyTarget` | `Features/Enemy-Target.lua` | The player each mob was last seen swinging at, or last taunted by | 500 |
| `firstSeen` | `Features/Tanking-Tools-Cold-Opener.lua` | When each mob first reached the combat log | 500 |
| `runs` | `Features/Tanking-Tools-Armor.lua` | Armor stack-up in progress per mob | 200 |
| `heard` | `Features/Whisper-Election.lua` | Rival bids heard before this client queued its own | 200 |

The rest are keyed by group member, pet or class and stay small: the cooldowns in `Features/Bad-Mages.lua`, `Features/Bad-Parry-Monkeys.lua`, `Features/Bad-Pets.lua`, `Features/Bad-Priests.lua` and `Features/Tank-Deaths.lua`, the pending bids in `Features/Whisper-Election.lua`, Parry Monkey's last confession and raid state, and the single-record slots Interrupts and Incapacitated keep.

`ns.GroupHasTank` and `ns.GroupHasClass` cache differently. Each answers once per frame and reuses the answer, because each walks the raid with an API call or more per member, and a busy frame asks repeatedly for an answer that cannot change within it. `ns.GroupHasClass`, in `Features/Tanking-Tools-Armor.lua`, deliberately ignores whether the member is alive or connected (see Tanking Tools).

### State Encoding

Four keys decide whether two events are the same thing, and each is built from exactly what has to stay distinct.

- **The combat-log dedupe** keeps the last timestamp, caster's GUID, spell ID and outcome as upvalues in `Features/Combat-Log.lua`, plus the mob's GUID for a taunt reported as Single Target, and drops a firing that matches all of them. One AoE taunt lands a separate aura on every mob it hits, all from one caster and sharing a timestamp, so with no mob in the key they collapse into one line. A Single Target taunt keeps the mob in the key, so a Righteous Defense the player reports that way names each mob it took, and for a taunt that only ever takes one mob the extra key changes nothing. **The outcome is part of the key, and that is what lets failures through**: a throttle on source and spell across a time window treats a cast and the miss that follows it as one event and swallows every resist. Two group members casting the same ability within one timestamp each report, because the caster's GUID tells them apart.
- **Interrupts** key on timestamp, caster's GUID and interrupting spell ID in `Features/Interrupts.lua`, because `SPELL_INTERRUPT` returns before the shared dedupe runs.
- **Incapacitated** remembers the `spellID` and `startTime` of the effect it last announced. `LOSS_OF_CONTROL_ADDED` fires again when a second effect lands on the first, and the handler re-reads the whole active list, so without the key the same worst effect would be announced again.
- **The whisper election** keys a pending whisper as `kind:id`. `id` is the GUID the whisper is about, and `kind` is a bare word per feature (`pet`, `parry`, `shield`, `nova`), which keeps the namespaces disjoint: the same player can be a parry culprit and a shield caster in one fight, and those are different whispers about different things.

## Ability Data

`ns.ABILITIES`, declared by `Abilities-{Flavor}.lua` in each flavor folder, holds one entry per Tracked Abilities checkbox. An entry carries `class`, `category`, `detection`, `isAoe`, an optional `kindChoice`, `renamed` and `shipsOff`, and the `triggers` that checkbox owns, in rank order. Peer Pressure's rows sit in `ns.PEER_PRESSURE_ABILITIES`, declared by `Peer-Pressure-Abilities-{Flavor}.lua` beside it, in the same shape; `ns.BuildAbilityIndex` reads both lists (`ABILITY_LISTS`), so from then on they are rows like any other. There is no per-rank row: the entry is the group. Which abilities each folder holds, and why each trigger is the ID it is, is in that file's `How We Got the Data` block; this section covers how the code reads the entries.

- **`class`** is the heading the row is filed under on the panel. `ITEM` is its own heading, drawn last in muted gray: the target dummies and Flash Bomb are rows like any other, carrying the category of what their Use does, and the combat log reports the item's spell from the player who used it.
- **`category`** is `TAUNT`, `FEAR`, `NOVA`, `SHIELD`, `PET_TAUNT` or `COOLDOWN` (Peer Pressure's file only). `ns.CATEGORY_FEATURE` in `Features/Ability-Index.lua` maps it to the feature that owns the alert, and the dispatch at the end of `ns:OnCombatLogEventUnfiltered` picks the handler by it.
- **`isAoe`** says whether the ability takes one mob or a pack. For a taunt it is read through `ns.IsAoeTaunt`, never directly: an entry marked `kindChoice` lets the player report it as Single Target or AOE, and `isAoe` is then only the default (see Taunts). `kindChoice` needs `AURA` detection, because a cast names one target at most where an aura lands on each mob the taunt took.
- **`renamed`** marks an ability whose ranks answer to more than one name on the client. Validate Data exports it in its `DATA_RENAMED` column, so a `DATA_ROW_NAME` that differs from an ID's `NAME` reads as a known rename rather than an ID that belongs to a different spell.
- **`shipsOff`** starts the row's checkbox unticked. Only Peer Pressure's rows set it, for the cooldowns Thanks for the Buff shipped unticked. Ticking one stores `false` against its triggers in `ignoredSpells` rather than clearing them, so the profile stays a diff against the data either way (see Saved Variables).
- **No spell ID may sit in both lists.** `ns.ABILITY_MAP` holds one entry per ID, so an ID shared by an ability row and a Peer Pressure row would answer to only one tab.

**The loaded folder is the authority on what this client tracks.** Every entry in it is registered and drawn; an ability that does not exist on a flavor is left out of that flavor's folder, so its IDs are never registered and can never fire. Leaving it out is the only defense against Blizzard reusing a spell ID for an unrelated ability on another flavor, since the ID still resolves and no existence check can tell. A trigger this client's spell data does not know can never appear in this client's combat log, so it costs nothing. A change to one folder's row is looked up in the other six.

**The index is built on `PLAYER_LOGIN`.** Core calls `ns.BuildAbilityIndex` before registering the options panels, which draw from it, and before the combat log is hooked.

It fills two tables:

- **`ns.ABILITY_MAP`**: spell ID to entry, for every trigger of every entry in the loaded folder.
- **`ns.ABILITY_GROUPS`**: one row per drawable checkbox. A group is drawn only when at least one trigger resolves on this client, and it takes its name, icon and tooltip spell (`maxRankId`) from the **last** trigger in the list that resolves, so the label matches that character's tooltip. That is why `triggers` runs in rank order, and why an entry whose live trigger is not its castable spell lists the castable one last: Righteous Defense listens for the aura each mob takes and lists the cast after it only so the row shows the castable spell's name and icon. Under `AURA` detection the cast never fires, so dropping it would only change the label.

Both are wiped and refilled rather than replaced, so a file-scope alias, such as the local `ABILITY_MAP` in `Features/Combat-Log.lua`, stays pointed at the live table.

`detection` decides what counts as success:

- **`AURA`**: the ability lands an aura, so success is `SPELL_AURA_APPLIED` or `SPELL_AURA_REFRESH`. The aura landing proves the mob changed hands, so a resisted taunt produces exactly one failure line. It is usually a debuff; Power Word: Shield is the one buff on a friendly target.
- **`CAST`**: the ability lands nothing observable, so `SPELL_CAST_SUCCESS` is success, and a resisted single-target `CAST` taunt reports its cast and then its miss. Every pet taunt is `CAST`, because the pet taunts apply no debuff and watching for one leaves Bad Pets silent.

An entry is per ability, not per ID, so one checkbox covers every rank and every variant the client knows, including the Season of Discovery rune abilities that repurpose an ability under new spell IDs. **A row is ignored when any of its triggers is** (`ns.IsAbilityIgnored`), the one rule both the checkbox and the combat log read, so a row that later gains a trigger stays unticked for a profile that unticked it. Unticking a row writes every trigger into `ignoredSpells` (see Options Panels).

## Alert Sections

Every alert on every tab is the same block of settings, drawn by `ns.AddWhoseAlertSection` in `Options/Options-Alert-Section.lua` and applied by `ns:Alert` in `Features/Announcements.lua`. Whose cast it was picks the row, the row says whether the line prints and where it is announced, and the Against ladder beside the section's switch says which mobs count.

| Setting | Default | Meaning |
|---|---|---|
| `enabled` | On (Cold Openers ships off) | The section fires at all |
| `mine` | `{ print = true, announce = "NEVER" }` | The player's own casts, and their pet's |
| `others` | `{ print = true, announce = "NEVER" }` | Everybody else's casts in the group |
| `against` | `ALL` | The lowest rung of `ns.TARGET_RUNGS` that counts |
| `alwaysWhenMarked` | On (Parries ships off) | A raid mark overrides `against` |
| `sound` / `soundName` | On, with a sound picked per section | Play a sound with the line |

`WhoseAlertDefaults(soundName, overrides, noTarget, rowKeys)` in `Data/Default-Settings.lua` builds that shape, and each section's overrides sit beside it with their reasons. An override that names `mine` or `others` replaces the whole row, so it passes both fields. Incapacitated, Parry Monkey, Bad Pets and Armor Debuffs ship silent.

**Where a line goes.** A row is `{ print, announce }`. `announce` is one of `ns.ANNOUNCE_SCOPES`, a ladder of where the group hears it: `NEVER`; `PARTY` ("In a Party"), party chat in a group of five or fewer, or instance chat in an instance group no bigger than a party, and nothing in a raid; or `GROUP` ("In a Party or Raid"), whatever chat the whole group shares (`ns:GetGroupChatChannel`). **`print` is the fallback**: `ns.ResolveAlertDestination` prints the line to the player's own window only when the announce found no channel, because an announced line already shows in the player's chat and two copies of one sentence is noise. So a row announcing In a Party prints in a raid, a row announcing anywhere prints while ungrouped, and a row with `print` off that announces nowhere is off. The row is picked from the combat log's `AFFILIATION_MINE` bit (`ns.IsMineSource`), which already covers the player's pet; a section whose pair is not about whose cast it was names the row outright through `rowKey` (see Bends).

**Group chat only.** `AnnounceChannel` in `Features/Announcements.lua` answers nothing in a battleground or arena, since their chat is a crowd of strangers, so the row prints there instead. Say and Yell are not offered: the client silently drops an add-on's `SAY` or `YELL` outside a dungeon or raid, so the choice would do nothing in the open world with no way for the player to tell.

**What ships loud.** Both rows ship printing and announcing nowhere, so a fresh install is close to silent in group chat. The exceptions announce only the player's own line, because each is news the group needs the moment it happens and the player is the one person who already knows:

| Section | `mine` ships | Why it differs |
|---|---|---|
| Failed Taunts | Print off, `GROUP` | A resist is the group's problem; a solo resist says nothing |
| AOE Taunts | Print on, `GROUP` | A pack changing hands is the group's news |
| Fears | Print off, `GROUP` | Everybody else needs warning about the player's own fear |
| Incapacitated Long (`long`) | Print on, `PARTY` | Announces in a dungeon, prints in a raid (maintainer's decision, 2026-10-28) |
| Cold Openers | Print on, `GROUP` | The section itself ships off |
| Parry Monkey | Print on, `GROUP` | A confession printed only to its maker confesses to nobody |

Cold Openers', Armor Debuffs' and Parry Monkey's `others` rows are stored `{ print = false, announce = "NEVER" }` and never drawn, since those sections draw one row. Both Tank Deaths rows print (see Tank Deaths), and both Peer Pressure rows ship on, copied from the maintainer's own profile.

**What ships narrowed.** Successful and Failed Taunts at `ELITE`, Cold Openers at `ELITE_0`, Armor Debuffs and Parries at `BOSS`, and every other targeted section at `ALL`. `alwaysWhenMarked` ships on wherever it exists but Parries, copied off from the maintainer's profile, since a parry from a marked mob below Bosses is still not parry haste anybody needs to hear about. On Successful and Failed Taunts, Cold Openers and Armor Debuffs, a marked mob below the rung therefore fires from the first pull. That is the override doing its job, and also the one place it pulls against the reason those sections are narrowed; read the note in `Data/Default-Settings.lua` before changing either.

**`against` is a threshold, not a set of switches.** A section fires against its rung and every rung after it. Every rung that includes bosses says so in its label, because a bare "Elites" beside a separate "Bosses" reads as two disjoint sets. There is no way to choose nothing: independent target boxes could all be off, and the alert would go quiet with nothing on screen saying why.

**`alwaysWhenMarked` widens rather than narrows.** A marked target counts whatever `against` says, and the mark is tested first. That order is also what makes it cheap: the combat log carries `destRaidFlags` on every line, the file-local `GetRaidIconIndex` in `Features/Combat-Log.lua` turns them into 1 to 8 or `nil`, and a marked mob is answered by one nil check where the rung may walk every name plate.

**A `noTarget` section carries neither key.** A line that names no single mob has nothing for either filter to act on: AOE Taunts, Fears, Novas, Incapacitated, Tank Deaths, Bad Shields, Peer Pressure's Cooldowns and Parry Monkey. The switch spans its row alone, or shares it with a control of the section's own, and with neither key stored the target filter passes whatever GUID the handler hands `ns:Alert`.

**Bends.** The block's shape is fixed, but a section can bend it through builder options:

- **`rows`** replaces My and Others' with a list of `{ key, labelKey, descKey }`. Incapacitated passes Short and Long, because the game reports only the player's own losses of control, so the question with two answers is how long the effect lasts. The `key` is the settings key, the widget key and the `rowKey` the handler passes as `ns:Alert`'s seventh argument, so the three must match. Tank Deaths keeps My and Others' but names its row through `rowKey` too, since it reads a death rather than a cast.
- **One row.** Cold Openers and Parry Monkey omit `othersKey`, since only the player's own opener is readable and nobody else's parry is theirs to confess. Armor Debuffs and Bad Shields report a problem of the group's to the player, so each draws one row, and its handler passes the player's own affiliation, which files every report under that row.
- **`mineDescKey` and `othersDescKey`** replace the shared row tooltips (the player's own casts, pet included, and everybody else's) wherever those would be wrong: Cold Openers never counts a pet, Armor Debuffs and Bad Shields report the group's problem rather than a cast, Parry Monkey's row is a confession, Tank Deaths and Parries pass both, because their rows report a death or a parry, and Peer Pressure passes both, because only the player's own class counts and no pet casts a class cooldown.
- **`control`** fills the slot beside the switch, which belongs to the Against ladder. Only a `noTarget` section can use it, and Bad Shields puts its health line there; on a targeted section the builder overwrites it with the ladder.
- **`captionRow`** draws a caption and a dropdown under the rows for a parameter of the detection, such as Cold Openers' "Within [5 Seconds of the Pull]". `captionRowFirst` draws it above them instead, for Incapacitated, whose threshold is the definition the Short and Long rows branch on.
- **`extraRow`** adds rows between the filters and the sound: Armor Debuffs' two Include rows, Parries' Ignore Tanks and Ignore Pets, Bad Shields' When Playing a Druid or Warrior Tank, and Parry Monkey's message box and cooldown. Incapacitated's nine effects sit under an Included Effects header of their own below the block, two to a line, because nine indented rows buried the sound and the Example.
- **`afterSample`** adds a row below the Example for something that is not the alert's own output, which is every whisper. Bad Mages, Parries, Bad Pets and Bad Shields all draw theirs through `ns.AddWhisperRow`: the whisper toggle, the cooldown beside it, and the whisper's own Example. The cooldown stays up when the whisper is off, because it covers the whole alert.
- **`noSound`** drops the sound row. Armor Debuffs and Parry Monkey use it, so their defaults ship silent: there would be no control to switch a sound off.
- **`noHeader`** drops the gold header, for a Tanking Tools sub-panel whose page title already names the alert.

**A sound plays only with a line.** `ns:Alert` resolves the row and the channel first, and plays nothing unless the line is going somewhere the player reads, so somebody else's resisted taunt on a row that neither prints nor announces makes no sound.

**`ns:Alert` re-checks the group.** `ns:PassesAlertGates` requires the section's switch, `ns.IsGroupSource` and the target filter. Every combat-log dispatch already drops an outsider to save the work; the check here guarantees it, so a mob interrupting the player's heal can never be announced as a group member's interrupt. A group member's pet counts as the group.

**A whisper or cooldown asks the gates first.** A whisper is not one of the alert's outputs, so Bad Mages, Parries, Bad Pets, Bad Shields and Parry Monkey's confession call `ns:PassesAlertGates` directly, and **before** their cooldown: an event the filters drop neither whispers nor uses up the cooldown that would swallow the next real one. Incapacitated and Tank Deaths call `ns.ResolveAlertDestination` ahead of `ns:Alert` for the same reason.

## Message Rendering and Chat Safety

An alert's arguments reach `ns:Alert` as **parts**, so one locale format renders twice from one call. `ns.PlayerPart`, `ns.SpellPart` and `ns.TargetPart` build them, and anything that is not a table passes through. The renderer is exported as `ns.RenderAlertPart` for the options panel's Examples and the Diagnostics Message Length report.

- **Rich**, for the local print: the name in its class color, the spell as a clickable link, the target behind its raid-icon texture. A pet's GUID carries no class, so it takes the color of the class whose ability it cast.
- **Plain**, for chat: the same content with the `{rtN}` token in place of the texture, which the receiving client renders as the mark. The token goes out with no flavor check, which is safe only because no TOC the add-on ships runs on WoW Forever, the client that blocks raid-marker tokens in chat (`README-Notes.md` says why there is no Forever TOC).

Both put the information first and the brand last, with no target marker in front, because the body already carries its target's own mark: `ns.BuildAlertLine` closes the local print with `// Control Freak` in the add-on's colors (`README-Notes.md` records that departure), and `ns:BuildAnnounceMessage` closes the chat line with ` // ` and `L["ADDON_SHORT_NAME"]`. The locale formats end in a full stop, and both paths drop it (`.` or the CJK `。`) so the brand closes the line. The options panel's Example lines go through the same two (see Options Panels). `ns:PrintLine` is the print-only path for a line with no business in group chat; Tank Deaths' class log is its one caller.

**Never strip color escapes from a sent body.** A spell link is `|cff...|Hspell:id:0|h[Name]|h|r`, one escape sequence. Remove the color wrapper and the malformed link makes the client refuse the message: it is dropped whole with no Lua error, while the local print of the same content keeps working. The file-local `StripChatFormatting` converts the raid-icon texture and touches nothing else.

**A link is rebuilt when a name comes back.** On Era the link API can return a bare spell name. `ns.GetSpellDisplay` in `Features/Utilities.lua` asks the file-local `GetSpellLink`, which calls `C_Spell.GetSpellLink`, checks the shape of the answer, and builds the link from the ID in the client's spell-link color (`ns.SPELL_LINK_COLOR`) when there is no `|Hspell:` in it. An ID of `0` counts as no ID, and with no name either the part prints `L["UNKNOWN_SPELL"]`.

**The ceiling is 255 bytes** (`ns.CHAT_MESSAGE_MAX_LENGTH`), so the locale to measure against is the widest-encoding one, ruRU, rather than English or German. `ns:BuildAnnounceMessage` returns the finished string without sending, so a caller can measure first. A message that overflows loses its brand before any of its body, and if it is still too long, `ns:Announce` cuts it, because **a byte cut is not a safe cut**: a cut inside a spell link leaves a malformed escape that drops the whole message, and a cut inside a multi-byte character leaves a mangled letter, which every locale but English hits first.

`SafeCutLength` walks the string once, counting open escapes, and returns the last position where none was open and no character was half written. One depth counter serves colors, links and textures because they nest: a spell link returns to depth zero only at its final `|r`. A two-byte escape read at the limit lands one byte past it, so the candidate length is bounds-checked, and with no safe point at all the message is not sent rather than sent broken.

This is a floor, not a license. Every message is still written to fit, measured with a real spell link and real names substituted, because a truncated alert is a worse alert even when it sends.

## Whisper Election

Four features whisper somebody about something they are doing wrong: Bad Mages tells a mage the nova froze the pull, Parries asks a player to move out of the boss's front, Bad Pets tells a pet's owner to turn off auto-cast, and Bad Shields tells a healer why the shield hurts. All four go through `ns:QueueGroupWhisper` in `Features/Whisper-Election.lua`.

**Several Control Freak users in one raid would otherwise send the same person identical whispers in the same second.** Each client bids a random priority, broadcasts it to the group on the add-on message channel under `ns.ADDON_MESSAGE_PREFIX`, and holds its whisper for `ns.WHISPER_ELECTION_DELAY` (one second). A client that hears a higher bid drops its own, so exactly one whisper goes out. Equal bids break on the sender's GUID, so both sides stand down the same way. The clients do not see the event at exactly the same moment, so a bid heard before this client queues its own is kept in `heard` for one election delay and wins the same way. Ungrouped, nothing is broadcast and the whisper sends once the delay passes.

The bid is one add-on message, split on `:`, which is why `kind` is a bare word and `id` is a GUID: neither can contain one.

```
kind:id:priority:senderGUID
```

**A client receives its own broadcast.** The bid carries the sender's player GUID, and `ns:OnChatMsgAddon` drops a match before comparing; left in, the echo ties with its own bid, stands down, and nobody whispers at all. **Match on the GUID, never the name**: `CHAT_MSG_ADDON` reports its sender as `Name-Realm`, while the client's own name APIs drop the realm for your own character, so a name comparison never matches and fails silently.

**Nobody is whispered about their own cast or their own pet**, and Parries never whispers a pet, whose name would bounce or reach a stranger who shares it. Every whisper is gated by its section's switch and target filters, never by the rows, so a whisper can go out while its row prints nothing. Bad Pets' and Bad Shields' whispers ship on, Bad Mages' and Parries' ship off by the maintainer's decision, so switching those tabs on starts the warning and not the note to the culprit. With When Playing a Druid or Warrior Tank ticked, Bad Shields' whisper can only ever reach somebody who shielded the player.

**One cooldown covers the whole event.** Each feature's cooldown is keyed by the culprit's GUID, the pet's for Bad Pets, and covers the print, the sound, the announce and the whisper together.

| Feature | Stored as | Ladder | Ships at | Why the ladder or default is shaped that way |
|---|---|---|---|---|
| Bad Mages | `badMages.cooldown` | `ns.BAD_PET_COOLDOWNS`, 30 seconds to 5 minutes | 1 minute | Bad Pets' ladder, for the same reasons |
| Parries | `badParryMonkeys.alert.whisperCooldown` | `ns.PARRY_COOLDOWNS`, none to 30 seconds | 30 seconds | Shorter than Bad Pets' because somebody in front of a boss can fix it in one step; it is stored as the whisper's cooldown, but it is also how often one culprit can set the section off at all |
| Bad Pets | `badPets.cooldown` | `ns.BAD_PET_COOLDOWNS` | 1 minute | Thirty seconds is roughly a pull, and anything shorter tells the same hunter twice in one fight |
| Bad Shields | `badPriests.alert.cooldown` | `ns.BAD_PET_COOLDOWNS` | 1 minute | A shield kept rolling is a pet left on auto-cast, and anything shorter tells the same priest twice in one pull; copied from the maintainer's profile |

`ns.ResolveChoice` reads every ladder, in the dropdown and in the handler alike, so a stored value that a later version's ladder drops falls back to the default rather than to no cooldown.

**The election logs its own steps.** It decides in silence, a second later and partly in another client's code, so `ns.LogWhisperStep` writes each step into the diagnostics event log, and each whispering handler logs its decision beside it. Callers pass a constant label and raw values, never a built string, so logging off costs one boolean read. The broadcast reads `ns:GetGroupChatChannel` directly, so unlike an announce it is not skipped in a battleground.

## Taunts

A successful single-target taunt reports only when the mob was **not** already hitting the taunter. A taunt on a mob already on you is a threat refresh, not a save, and those lines bury the ones that matter.

**Who a mob was on can only be remembered, not asked.** By the time the taunt's aura lands, the mob has changed target, so a unit-token read answers with the taunter every time. The combat log is the only source strictly earlier than the taunt. `Features/Enemy-Target.lua` keeps `enemyTarget`, filled by `ns.RememberEnemyTarget` from **melee swings only**, since a mob melees whoever it is actually on while a spell can land anywhere, and `ns:HandleTaunt` records the taunter as the new holder, so the same player taunting the same mob again is the repeat that goes quiet. Players never enter it as the mob.

- **Unknown means report, for taunts.** `ns.EnemyWasAlreadyOn` suppresses only on a positive match, so a mob nobody has seen swing still announces. Parries and Cold Openers read the same cache through `ns.EnemyIsOnSomeoneElse`, which answers false for a mob with no holder on record: Parries therefore stays quiet on an unknown mob, and Cold Openers reports it. Check the consumer before assuming which way an unknown answers.
- **Failures and AoE taunts are never suppressed.** A failed taunt is the alert a tank most needs, and an AoE taunt reports once per cast, so one mob's history cannot speak for the rest.

A failed taunt picks its format from the miss type: `TAUNT_MISSED`, `TAUNT_RESISTED`, `TAUNT_IMMUNE`, or `TAUNT_FAILED` for anything else. `TAUNT_IMMUNE` alone leads with the mob, so its parts run mob, taunter, taunt. An AoE taunt never reports a miss, since it fires one per immune mob.

**Single Target or AOE is one question with four consequences.** The answer decides which section reports the taunt (Successful and Failed Taunts, or AOE Taunts with no mob and no mark), whether its misses report, whether the mob is part of the dedupe key (see State Encoding), and whether it reports through When Group Has a Tank. The Taunts tab's Tracked Abilities sub-panel draws one ability list with each row's kind beside it (`kindPicker` on `ns.BuildAbilityToggles`). Only a `kindChoice` row gets a Single Target / AOE dropdown; every other row shows its data's `isAoe` as silver text in the dropdown's column, because a taunt that takes one mob or everything around it leaves nothing to choose, and a greyed dropdown on every row read as broken. On a client with no `kindChoice` row the list's intro is `TAUNTS_ABILITIES_DESC_NO_CHOICE`, which never mentions a dropdown. Righteous Defense takes up to three, so the player decides whether it reads as one save per mob or one line per cast. `ns.GetTauntKind` in `Features/Ability-Index.lua` resolves the answer, and `ns.IsAoeTaunt` is what the combat-log gate, the failure test, the dedupe and `ns:HandleTaunt` read. Fears, Novas and Bad Pets have no such choice and read `isAoe` directly; the maintainer ruled that a fear is bad whether it takes one mob or many, so Fears keeps one undivided list.

**There is no steal detection.** A planned taunt swap and a stolen mob are the same lines in the combat log, which carries no intent to tell them apart, and the fights where a steal warning would fire hardest are two-tank fights where both tanks are supposed to taunt the same mobs. A warning that cannot be trusted switched on is not worth shipping switched off. The detection is not the hard part; the missing signal of intent is, so do not rebuild it. `Features/Taunts.lua` points here.

## Interrupts

Interrupts do not come through the ability table. `SPELL_INTERRUPT` names both the interrupting spell and the spell it stopped, so the add-on watches the sub-event directly and the Interrupts tab has no ability list. The branch returns before the ability path's source gate, so it carries its own `ns.IsGroupSource` check: mobs interrupt too.

**On Era the interrupted spell's ID can arrive as `0`**, with only its name, and printed raw that is a literal `[0]` in the alert. `UNIT_SPELLCAST_INTERRUPTED` carries the real ID for the same cast, so `ns:OnUnitSpellcastInterrupted` in `Features/Interrupts.lua` keeps the last one and `ns:HandleInterrupt` reads it back when the combat log's ID is missing. It is one record rather than a table keyed by unit, since both events describe the same instant, and it must match the mob's GUID inside `INTERRUPTED_CAST_WINDOW` (one second), so it cannot answer for a different mob. With neither ID nor name, `ns.GetSpellDisplay` prints `L["UNKNOWN_SPELL"]`.

## Incapacitated

The one alert the combat log does not trigger, and the only one that reads three sources to write one line: what landed, who cast it, how long it lasts, and whether anybody can remove it. It follows the reference aura at [wago.io/qhD2-4WN6](https://wago.io/qhD2-4WN6) and adds the dispel type, which turns "I am feared" into an instruction for the players who can remove it.

- **`C_LossOfControl`** says an effect is a loss of control, which kind, and for how long, already classified and timed. `LOSS_OF_CONTROL_ADDED` wakes `ns:OnLossOfControlAdded`, which re-reads the active list rather than trusting the payload: the payload carries an index on some flavors and nothing on others, and re-reading also collapses "one effect landed" and "a second landed on top" into one path. Reading the same thing from `SPELL_AURA_APPLIED` would need a list of every crowd-control spell in the game, and still could not tell a partly resisted fear from a full one. **The API names no caster and no mob**, so the section is `noTarget`, and the handler hands `ns:Alert` a fixed set of the player's own affiliation flags (`MINE_FLAGS`) for its group test.
- **The player's own debuff**, found by spell ID through `C_UnitAuras.GetDebuffDataByIndex`, carries the **dispel type**; the combat log has no dispel field. `ns.DISPEL_TYPES` maps the API's word to a locale suffix, and any other answer drops the clause rather than printing empty brackets. Mind the casing: a `LossOfControlData` has `spellID`, and an `AuraData` has `spellId`.
- **The combat log** carries the mob's **name** with no unit to resolve. `Features/Combat-Log.lua` stamps each debuff landing on the player, and each interrupt aimed at them, since a spell lockout such as Shield Bash is never an aura, through `ns.RememberIncapacitatingAura`; the handler reads it back, matched on spell ID inside `ns.INCAPACITATED_AURA_WINDOW`, the same one-record arrangement Interrupts uses. Buffs never reach it, so a heal over time cannot overwrite the fear beside it. The debuff's `sourceUnit` is only the fallback, because that token resolves only while the mob is somebody's target or on a name plate, and `UNKNOWN_CASTER` is the last resort. The stamp sits behind the tab's and the section's switches and one GUID comparison, since auras land on the player several times a second in a raid.

`C_LossOfControl` is checked once at file scope (`HAS_LOSS_OF_CONTROL`): without the modern pair the section goes quiet, and Diagnostic Tools' API report says so. `C_UnitAuras` ships on every client and is called directly, but where `C_Secrets.ShouldAurasBeSecret()` says aura reads are secret, the debuff lookup is skipped and the line loses the dispel type while keeping the news.

**The longest effect is the one announced**, indefinite outranking every timed one, because stunned for two seconds and feared for six is a tank gone for six. `ns.INCAPACITATED_EFFECTS` maps each `locType` onto the panel's nine boxes (`ns.INCAPACITATED_ROWS`, all shipping ticked). `PACIFYSILENCE` passes when either of its two boxes is ticked, and a `locType` the table does not map stays quiet rather than announcing under a name nobody chose.

**Short and Long route, they do not filter.** `longThreshold` decides which row a line answers to, and both rows have somewhere to send it: Short ships printing, Long announcing In a Party with its print as the fallback, so it reaches a dungeon group and stays out of raid chat. The threshold ships at five seconds. A one-second stun is still worth seeing, since it explains the global cooldown just lost, but it is not worth the group's chat. The ladder, `ns.INCAPACITATED_LONG_THRESHOLDS`, starts at one second, because zero would mean nothing is ever short, which is what switching the Short row off already does. An effect with no duration counts as Long. The handler names the row outright, since affiliation would pick the same row every time, and resolves that row's destination **before** `ns.INCAPACITATED_COOLDOWN` (1.5 seconds), so an effect whose row goes nowhere never uses up the window.

**Four formats, not one.** The length and the dispel type are each optional, so `INCAPACITATED`, `INCAPACITATED_PLAIN`, `INCAPACITATED_INDEFINITE` and `INCAPACITATED_PLAIN_INDEFINITE` cover the combinations. The length is its own phrase (`INCAPACITATED_SECOND` or `INCAPACITATED_SECONDS`), so the singular needs no extra formats, and it is rounded **up** to a whole second: a fear reported as 5.9 promises a taunt back sooner than it is coming. The verb, "is afflicted by", is Blizzard's own combat-log wording.

**The line opens on the player's seat, read from the player when it fires** rather than from the setting: `INCAPACITATED_ROLE_TANK` when `ns.IsPlayerTank()`, then `INCAPACITATED_ROLE_HEALER`, and otherwise the client's own class name through `ns.ClassName`, which the `ALWAYS` rung lets through. Tank wins for a character holding both signals, since a Main Tank assignment is made on purpose and outranks a role left set from a dungeon. Leading with one role phrase keeps the formats at four rather than eight in every locale.

**It is its own feature because only a feature can ask a scope question.** The Tanking Tools gate asks whether anybody is tanking, for warnings about a mob; this alert is about the player, so what narrows it is the player's seat. It is the one tab whose role ladder ships at `TANK_HEALER`, so a player with no group finder role and no Main Tank assignment hears nothing from it until they pick Always.

## Tank Deaths

One alert section and one list, and the split between them is the design.

- **Tank Deaths is the alert**, drawn like Fears: a death names no mob, so the section is `noTarget`. It keeps the whose pair as **My Death** and **Others' Tank Deaths**, because a tank's death has two audiences: the tank looking at a release button already knows, and the players who must now pick up the mob do not. Its line opens `Tank Down!`.
- **Deaths by Class is the log**: nine rows, all shipping off, with no sound and no destination. Its line opens the same way on the class, `Mage Down! Joe has died.`, so the two read as one family with the answer in the first two words. It prints through `ns:PrintLine`, the print-only path, which has no rows to resolve, no alert gates (a death has no caster and no mob), and no sound, because nine classes with a sound each turns a wipe into a drum solo. The rows are plain sub-option rows under a header rather than a section, so the log has no switch of its own, and its Example comes from the exported `ns.RenderSample`.

**`UNIT_DIED` is the only event that reports somebody else's death as it happens.** `UNIT_HEALTH` arrives late and not for every unit, and raid frames are a picture rather than an event. Most of what `UNIT_DIED` carries is mobs and pets, so `ns:HandleUnitDeath` drops any GUID that is not a player's on a string test before anything else. `UNIT_DIED` names no source, so `Features/Combat-Log.lua` hands over the dead player's own `destFlags`, which `ns:Alert` reads for its group test. The handler finds the player with `ns.FindGroupUnit(destGUID)`, which both proves they were in the group and hands over the unit token the seat test needs. The seat test is `ns.IsUnitTank`, so in a raid only an assigned Main Tank's death is a tank death, and a healer still wearing the group finder's Tank tag from a dungeon queue is not a tank. `ns.FindTankUnit` is built on the same walk, so the two cannot disagree about who is in the group. Feign Death also arrives as `UNIT_DIED`, so `UnitIsFeignDeath` filters it out where the client has it.

**The seat beats the class, and a death sends one line.** A warrior tank dying with Warrior ticked reports `Tank Down!` only. The handler picks the row itself and asks `ns.ResolveAlertDestination` and the section's switch **before** calling `ns:Alert`, because a tank death the section will not report falls through to the log: a player who switched Others' Tank Deaths off and ticked Warrior still hears about a warrior who was tanking. Calling `ns:Alert` first and guessing whether it spoke would report that death twice or not at all.

**My Death reports only while the player is tanking**, since the line says `Tank Down!`, and the log never reports the player. Both rows ship printing by the maintainer's decision, so a fresh install keeps tank deaths out of group chat: every Control Freak in the raid sees the line in its own window, and whoever wants it announced changes one dropdown. Mind the duplicates before changing either default. Every client that sees a tank die files it under Others' Tank Deaths except the dead tank's own, which files it under My Death, so an announcing Others' row puts one copy of the line in raid chat per Control Freak in the group, while My Death is the one row only a single client can ever fire. The section's sound ships on, playing Failure 2, copied from the maintainer's own profile, and a sound stays on the client that plays it.

**There is no `groupHasTank` question and no healer row.** Gating the tab on a living tank would suppress the case it exists for. A healer row would need a signal the game does not give: healing has no raid assignment, few Classic Era players set the Healer role, and inferring healers from heals means testing every heal in the raid and guessing.

`ns.DEATH_CLASS_COOLDOWN` (three seconds) throttles each class row so a wipe reads as a handful of lines. Like `ns.INCAPACITATED_COOLDOWN`, it is a constant because it exists to stop a wall of text, not to tune anything. The tank line has no cooldown, since every tank death is wanted and collapsing two would hide the one that mattered. `ns.DEATH_CLASSES` lists the nine Era and TBC classes, and the panel sorts them by the client's localized class name (`ns.ClassName`) rather than by token.

## Peer Pressure

A player of the player's own class in their group pressed a tracked cooldown, so the player can press theirs. The tab came from Thanks for the Buff. Saved choices stay in that add-on's own saved variables, with no bridge, so every player starts from Control Freak's defaults.

The rows are `COOLDOWN` entries in `ns.PEER_PRESSURE_ABILITIES` (see Ability Data), all `CAST`, so a `SPELL_CAST_SUCCESS` from a group member reaches `ns:HandlePeerPressure` in `Features/Peer-Pressure.lua` through the ordinary ability path, after the ignore list, the group test, the tab's scope gates and the dedupe. The handler then needs two tests of its own: **the row's `class` against the player's class**, which is the whole same-class test because every row is class-locked and needs no lookup of the caster, and a player GUID for the caster, since a group member's pet carries the group's flags too. The line is `PEER_PRESSURE`, or `PEER_PRESSURE_TARGET` when the cast landed on another player, rendered as a player part; a cast on the caster, a pet or nothing reads plain.

One `noTarget` section, `peerPressure.alert`. Both rows ship on and printing, copied from the maintainer's own profile, so the player's own tracked cooldowns report too. Both rows can announce, because a tank calling their own Shield Wall in group chat is a line the group can use. It plays `Control Freak: Thunder`, the sound Thanks for the Buff shipped, under that name. The tab asks `roleScope` and `instanceOnly`, both shipping at their widest, so out of the box it fires everywhere in any seat.

Every class's rows are drawn on the Tracked Abilities sub-panel, not just the player's, because the profile is shared across the account. A row that Thanks for the Buff shipped unticked carries `shipsOff`. The tab's Example names a roster player of the character's own class pressing that class's first ticked cooldown by name (its first cooldown when none is ticked), since a line about any other class is one the tab can never send; a class with no rows borrows the first row of any class, so the Example is never blank.

## Bad Mages

One section, **Novas**: a Frost Nova cast by a group member, which freezes a pull where it stands, out of the tank's reach. `Features/Bad-Mages.lua` holds `ns:HandleNova`, driven by the ability table: the `NOVA` category has one member, Frost Nova, mapped to `badMages` in `ns.CATEGORY_FEATURE`. The section is `noTarget`, since a nova is a ring, and its Example is the `NOVA_AOE` line; the handler's single-target branch is the shape of the call for a nova that does not exist yet. The tab ships on, with both rows printing and the Nova sound, and asks `groupHasTank`, shipping on, since a nova only costs anybody anything when there is a tank to strand the pull away from.

A per-mage cooldown on `ns.BAD_PET_COOLDOWNS` (`badMages.cooldown`, shipping at a minute) keeps a mage who novas every pull from filling the tank's window, and a whisper (`NOVA_WHISPER`, kind `nova`) ships off, because a nova is often the right call and a note to the mage is something a player opts into. Both live on the feature table rather than its section, as Bad Pets' do. No Tracked Abilities sub-panel: a list holding the one Frost Nova row would be the section's switch printed twice.

## Bad Parry Monkeys

Two sections that read the same parries from opposite ends: **Parries**, the warning about somebody standing in a boss's front, and **Parry Monkey**, the player owning up to their own. `Features/Bad-Parry-Monkeys.lua` holds both behind `ns:HandleBadParryMonkey`, which `DispatchMiss` calls for every `PARRY` from a group member while either section's switch is on and the tab's gates are open. The tab ships on, gated on `groupHasTank`, like the other Bad tabs.

**Parries** inverts the reference aura at [wago.io/yJAzyvcvw](https://wago.io/yJAzyvcvw). A mob parries only attacks from its front, and every parry speeds up its next swing at whoever is tanking it, so a parry is the tank's problem. Being parried by a mob you are holding is tanking; being parried by a mob somebody else holds means you are standing in front of it, which `ns.EnemyIsOnSomeoneElse` answers from swings already seen, with no unit token. **A mob with no holder on record reports nothing**, the opposite of the taunt rule, or every pull's opening exchange would name the tank. It reads **both** `SWING_MISSED` and `SPELL_MISSED`, since a melee player in front generates parries mostly from auto-attacks.

- **Ignore Tanks**, shipping on, drops a group member who is tanking through `ns.FindTankUnit`, since an off-tank in front of the boss is there for a taunt swap; the player's own parries still report.
- **Ignore Pets**, shipping on, drops a pet or guardian through `ns.IsPetSource`, the test Bad Pets uses, because the line would name the pet and nobody in the group can act on that. A pet is never whispered whichever way the row is set.
- Both run, with `ns:PassesAlertGates`, **before** the per-culprit cooldown, so a parry they drop does not use it up. The section ships narrowed to `BOSS` with `alwaysWhenMarked` off, since parry haste matters only on something that hits hard enough for the extra swing to count, and its whisper (`PARRY_WHISPER`, kind `parry`) ships off.

**Parry Monkey** is the player's own parries, in their own words, with a running count: `PARRY_CONFESSION` renders as the message and `(xN)`. It counts only parries of the player's own attacks (not their pet's), from a mob somebody else is holding, since it runs behind the same `ns.EnemyIsOnSomeoneElse` test as Parries, and only from a mob that `ns.GetEnemyTier` proves is `BOSS`. That rung is fixed rather than a ladder, so a mob nothing on screen can classify never grows the tally and a raid mark changes nothing. It runs ahead of Parries' own switch and Ignore rows, so the two sections never stand in for each other. **Every such parry counts, but the line goes out at most once per its cooldown** (`ns.PARRY_MONKEY_COOLDOWNS`, 15 or 30 seconds, shipping at 30), one timer rather than one per mob: the count is the news, and a confession on every swing is noise. It is one `noTarget` row that ships announcing to the whole group, with no sound row and no sound.

- **The message** is a player-editable text box with its own Reset (`MessageRow` in `Options/Options-Bad-Parry-Monkeys.lua`), stored as `monkey.message` and shipping as `BAD_PARRY_MONKEYS_MONKEY_MESSAGE_DEFAULT`. `ns.GetParryConfession` strips pipes, since the box never carries a link and a typed `|` would break the sent escape, and a blank box falls back to the shipped words rather than silencing the section. The Example reads the message and the live count every time the panel draws.
- **The count is saved state, not a setting.** `monkey.count` lives in the profile so a `/reload` keeps tonight's number. `ns:OnGroupRosterUpdate` sets it back to zero when the player joins a raid group; `wasInRaid` is only recorded on the first roster update before a loading screen, so a `/reload` inside a raid keeps the count. Reset Profile zeroes it too.

## Bad Pets

Hunter and warlock pets with an auto-cast taunt left on: every `PET_TAUNT` ability, detected as `CAST` and required to come from a pet or guardian (`ns.IsPetSource`). The tab ships gated on `groupHasTank`, since a hunter soloing with Growl on is playing correctly, and with no sound of its own to put in its sound row, so the section ships silent.

`FindPetOwner` names the owner by walking `partypetN` and `raidpetN` (the tokens are never `partyNpet`), and the format follows what it finds: `BAD_PET` naming the owner, or `BAD_PET_UNKNOWN_OWNER` when no owner resolves, each with an `_AOE` form for Suffering. The player's own pet gets the same owner-naming line as anybody's, because the My row can announce, and a line saying "your pet" in group chat would hand the pet to whoever reads it. The whisper goes to a resolved owner and never to the player. This tab's whisper and cooldown live on the feature table (`badPets.whisper`, `badPets.cooldown`) rather than on its alert section.

## Bad Priests

One section, **Bad Shields**: a Power Word: Shield landing on a druid or warrior who is tanking. Rage comes from damage taken, an absorb generates none, and the shield starves the tank of the resource they hold threat with.

- **The flavor folders scope it.** The entry is absent from the Wrath folder and every later one, where the mechanic does not apply, and from the Discovery folder, where a priest rune gives the rage back (`Data/Discovery/Abilities-Discovery.lua`'s notes say why). The tab still registers on every flavor. When the loaded folder draws no `SHIELD` row, a status line between the summary and the switch (`BAD_PRIESTS_DISCOVERY_STATUS`) says the tab cannot fire there. The line keys off the data rather than the flavor, and Season of Discovery is the shipping client it appears on.
- **Four gates, cheapest first**: the target's class (`ns.RAGE_TANK_CLASSES`, read through `GetPlayerInfoByGUID`); tanking (`ns.FindTankUnit`, the same seat test the scope gates read, never inferred from class or form); combat, since a shield on a tank not yet in combat is a harmless pre-pull bubble (`UnitAffectingCombat`); then health. `selfOnly`, When Playing a Druid or Warrior Tank, ships on and narrows them to shields landing on the player.
- **The health line.** A shield on a tank about to die is the right call, so the warning goes quiet below the chosen `health` (`ns.SHIELD_HEALTH_THRESHOLDS`, whole percentages, since the label prints the number). Zero is Always, and the shipped 50 reads "Except Under 50% Health". It takes the slot beside the switch, which is free because the section is `noTarget`.
- **Only the first application counts**, never a refresh, and a player shielding themselves is never reported.

It is the only section that reads a **friendly** target, so it has no Against ladder and no mark, and it files every report under its one row with the player's own affiliation (`REPORT_AS`), as Armor Debuffs does. Its whisper (`SHIELD_WHISPER`, kind `shield`) ships on, with the cooldown on the section (`badPriests.alert.whisper`, `badPriests.alert.cooldown`). The tab ships at `roleScope` `TANK` with `groupHasTank` on.

**The paladin bubbles are deliberately not `SHIELD` abilities.** A bubble on a tank drops every mob onto whoever is next on threat, which is a different problem from rage denial and does not belong in this section. Each `Abilities-{Flavor}.lua` with paladins keeps their IDs in a comment, and bringing them back means a category, a handler, defaults, copy and a panel section of their own.

## Tanking Tools

Two warnings that share a tab, not an implementation. The tab ships off while its tools are in beta, and that switch is the whole opt-in: everything under it ships the way it should run once a player turns the tab on. What keeps it quiet then is that everything under it is narrowed, switched off or gated: the tab asks `groupHasTank`, Cold Openers ships off, and both sections are narrowed, because both read ordinary combat outcomes that would otherwise narrate every dodge in the instance. It is the last feature tab because it is the one that ships off, and `ns.FEATURE_KEYS`, the registration order in `Options/Options.lua` and the General panel's blocks all carry that order, so moving it means changing all three.

- **Cold Openers** (`Features/Tanking-Tools-Cold-Opener.lua`) reports the player's own ability avoided in the first seconds of a pull: threat that never happened, when it matters most. It follows the reference aura at [wago.io/KVtFqses5](https://wago.io/KVtFqses5), whose stated filters are bosses only, aggro only, abilities only and early only. **Abilities only is load-bearing**: it reads `SPELL_MISSED` and never `SWING_MISSED`, since auto-attacks are avoided constantly. It reports only the player's casts, because the first seconds of somebody else's pull are unreadable: no swing has named a holder yet, and a DPS going early looks exactly like the tank. The pull clock is per mob, stamped by `ns.RememberEnemyFirstSeen` from **either** side of an event (a boss opening on the tank is a source before it is a destination), and only while this section is on. The window is `ns.COLD_OPENER_WINDOWS` (3, 5 or 10 seconds, shipping at 5). A mob already on somebody else does not count, a mob never seen does not count, and tracked taunts are skipped, so a resisted opening taunt prints once, as a Failed Taunt. `ns.COLD_OPENER_MISS_FORMATS` leaves out `ABSORB`, `REFLECT` and `EVADE`, none of which is the target avoiding the hit.
- **Armor Debuffs** (`Features/Tanking-Tools-Armor.lua`) times how long the group took to strip a target's armor. `ns.ARMOR_DEBUFFS`, in each flavor folder's `Armor-Debuffs-{Flavor}.lua`, describes the set: five Sunders **or** one Expose Armor answers the armor question, and Faerie Fire and Curse of Recklessness are extras the player can require, both shipping on. An extra is waited on only when `ns.GroupHasClass` finds somebody who could cast it, or the line would never print; that test ignores whether they are alive, since a dead druid is still a reason to wait. Timing runs from the first component to land, and a run resets when an armor component drops, not an extra. **Stacks are counted rather than read from the log's dose field**, because the amount sits in a different return slot per sub-event, and one wrong slot reports a number that is silently wrong. `SPELL_AURA_REFRESH` is not read, since at the top stack it fires on every reapplication.

**The miss type arrives in a different return slot per sub-event**, which is the easiest thing here to get wrong. `SWING_MISSED` has no spell, so its twelfth return is the miss type; `SPELL_MISSED` keeps the spell in the twelfth and puts the miss type in the fifteenth. `ns:OnCombatLogEventUnfiltered` normalizes both before calling `DispatchMiss`. Read the wrong slot and a number is compared to `"PARRY"`, and nothing ever fires.

**One file per tool.** The detection has nothing in common: a pull clock and a stack count. The options stay in one `Options/Options-Tanking-Tools.lua`, which declares `ns.TANKING_TOOLS` and builds the parent tab (the summary, the switch and its scope rows) and one sub-panel per tool from it. Each sub-panel is a status line and the tool's alert block, drawn with `noHeader` since the page title names it, and `ns.RegisterOptionsPanels` finds each builder by name, `ns.Build<registry>Options`. The root panel's Features block draws a switch per tool from the same list under the Tanking Tools switch, greyed out while the feature is off. No tool has an ability list: each warning is one thing, and its enable already says whether it fires.

## Options Panels

Every feature tab is built the same way. `ns.AddFeatureScope` draws the status line, the summary, the enable with the role ladder beside it, and the scope rows, and it **returns a `hidden` predicate**. `ns.AddGatedHeader` and `ns.AddWhoseAlertSection` hang that predicate on everything they draw, so a switched-off feature collapses to its title and one switch. Inside a section, the rows hang on a second predicate that also reads the section's switch, so a switched-off section keeps its header, description, switch and Example, which are what tell a player whether to switch it back on.

**Sub-panels and group pages are never hidden behind a switch.** A Tracked Abilities sub-panel (Taunts, Fears, Bad Pets, Peer Pressure) is one short intro and the ability list, and which abilities count is worth settling before turning the feature on; a Tanking Tools tool's sub-panel and each group page pass `ns.NeverHidden`, so only a block's own switch collapses its rows. What says the page is silenced is a status line instead: `ns.AddQuietStatus` in `Options/Options-Utilities.lua` puts one at the top of every page, shown only while All Alerts, the feature's group switch, or (on a sub-panel) the parent feature's switch has it silenced, naming the switch and where to find it. A feature tab's line never speaks for the tab's own switch, since that switch being off already collapses the page to the switch that says so. The line's `name` is a function that answers blank when there is nothing to say: AceConfigDialog reads every option's name while sorting, hidden ones included, and a feature tab's line carries no tab key, so formatting the feature-off wording there would throw on `L[nil]` and stop the whole page drawing. Each sub-panel's page title is `ns.SubPanelTitle(parent, name)`, "Taunts > Tracked Abilities", so a page reached from search still says whose it is, while the tree shows the short name passed to `AddToBlizOptions`.

```
-- Name of the alert --

One or two sentences on what it is and why it is worth having.

[ ] Enable Alerts for <thing> On              [ Everything          v]
                            Print (Self Only)  Announce
        My <thing>                [ ]         [ Never               v]
        Others' <thing>           [ ]         [ Never               v]
        <caption>                             [ ...                 v]  captionRow
    [ ] Always Alert on Marked Targets
    [ ] ...                                                             extraRow
    [ ] Play Sound                            [ Control Freak: ...  v]  (speaker)

Example: what the group would see

[ ] Whisper ...                               [ ...                 v]  afterSample

Example: what the whisper says
```

The header, description, switch and Example are mandatory, so a new alert cannot arrive half-dressed; everything else is optional. The whose rows are three columns under the indent, headed by `ALERT_PRINT_HEADER` and `ALERT_ANNOUNCE_HEADER`: the row's caption, its Print (Self Only) box, which carries the row's own tooltip since the caption cannot show one, and its Announce dropdown, which keeps the sub-option control width so it lines up with every dropdown above it.

**The Example is rendered, not written, and it follows its row.** A section passes `sample = { key, args, row }`: a real locale format, its parts, and the row whose Announce dropdown decides the form, `mine` unless the line is about somebody else. `args` can also be a function, for a line built from the player's own settings, as Parry Monkey's is. `AddSample` in `Options/Options-Alert-Section.lua` gives it a function `name`, so it redraws the moment that dropdown changes, and `RenderSample` draws it the way it will arrive:

| The row's Announce is | Drawn as |
|---|---|
| `NEVER` | The exact string `ns.BuildAlertLine` builds for `ns:PrintAlert`, names in class colors, body re-tinted after every `\|r` |
| `PARTY` or `GROUP` | `ns:BuildAnnounceMessage`'s output as party chat, `[Party] [Name]: ...` from the client's `CHAT_PARTY_GET`, in `ChatTypeInfo.PARTY`'s color, with each `{rtN}` token drawn as its mark |

Party rather than raid because both draw the same way and party is the one every group has. A whisper's Example, drawn by `ns.AddWhisperRow`, uses the same call as the whisper the other player receives, `[Name] whispers: ...` from `CHAT_WHISPER_GET`. Because both forms go through the live builders, rewording a message cannot leave an Example quoting the old text.

The parts say who is in the line. `ns.SamplePlayer()` is the character the panel is open on, read when the line draws, and the sender of every party line and whisper is that character too. Anybody else is `ns.SampleOther(class)`, a name from `ns.SAMPLE_NAMES`, the house roster keyed by class in `Data/Data.lua`. `ns.SampleCaster(kind, fallbackClass)` picks the player's own class's spell from `ns.SAMPLE_SPELL_IDS` (`TAUNT_DRUID`) and the `mine` row when that class has one, or the roster player of `fallbackClass` and the `others` row when it does not, so the name, its color and the spell agree. Spells are `ns.SpellPart` links built from the flavor folder's IDs, and `ns.SampleTarget` puts a skull on a boss that `ns.SampleBoss` deals from a shuffled deck of `ns.SAMPLE_BOSSES`, the Molten Core and Blackwing Lair bosses in `SAMPLE_BOSS_*` locale keys. Each block deals once at build time, so no two blocks name the same boss and the names hold still while the panel is open; a section whose whisper names the same mob passes the boss it dealt to both.

**Settings arrive as a getter, never as a captured table.** A profile switch replaces `ns.db.profile` outright, so a panel holding a direct reference would go on writing into the old one. Every builder takes a `Feature()` or `Section()` closure.

**Orders are budgeted.** A section owns 20 of order: the frame runs to +6 (a `captionRowFirst` row at +6.5), the column headers at +6.8, the rows from +7, a trailing caption row at +8.5, the mark at +9, extras from +11, the sound at +14, the Example at +15 and +16, and a whisper from +17 to +19 in half steps. A section needing more rows than that steps by tenths, as Tank Deaths' nine class rows do. The General panel's Features blocks take eight orders each. Ability lists live on their tab's Tracked Abilities sub-panel, not among the sections.

**Args keys share one flat table per panel.** Two builders writing the same key overwrite each other with no error, so `ns.AddGatedHeader` suffixes its keys `Header...` apart from the `Head...` keys a section frame uses, every section and whisper row prefixes its keys with the name its caller passes, and `ns.BuildAbilityToggles` writes fixed `class<CLASS>` and `class<CLASS>Pet` keys with no prefix, so a panel calls it once with every category it lists, as each Tracked Abilities sub-panel does.

**Sub-options are marked twice**, indented and captioned in silver, so the dependency reads by shape or by color. `ns.OptionsSubRow` makes one unnamed inline group per sub-option, which pins one row each; laid out flat, the next pair packs onto whatever space is left and the indent stops indenting. The indent is a real widget, since AceConfig pins a checkbox to the left edge of its own widget, and `hidden` goes on the group, never on its members. Every gated blank line is its own `ns.OptionsSpacer(order, hidden)` carrying the section's predicate; a spacer without one stays drawn, and a switched-off feature collapses to a column of empty rows.

**The grid lives in `Data/Data.lua`.** The label half, `ns.OPTIONS_LABEL_WIDTH`, is wide because it carries the longest labels in the add-on, the alert switches such as "Enable Alerts for Successful Interrupts On", with the Against ladder beside them; a longer string clips with an ellipsis, which is why translations are worded short. Sub-option widths are **derived** from the section widths rather than typed, which is what puts every dropdown in a block in one column; a pair that overflows `ns.OPTIONS_ROW_WIDTH` does not clip, it wraps the control onto its own line. The sound row's speaker preview is the one thing past `ns.OPTIONS_ROW_WIDTH`, in the right margin, since taking its room from the label would push the sound dropdown out of that column. A caption with no box sits behind a blank cell of `ns.OPTIONS_SUB_CAPTION_INDENT_WIDTH`, a checkbox's width, so its first letter lines up with the captions beside boxes.

**Ability rows use their own AceGUI widget**, `ns.SPELL_TOGGLE_WIDGET_TYPE` in `Options/Options-Ability-Toggles.lua`. AceGUI's stock CheckBox sends its `OnEnter` to AceConfigDialog, which draws the name-and-description tooltip and leaves no room for the spell's own, so the row opens `GameTooltip:SetHyperlink` on the spell in the option's `arg` field, which AceConfig passes through untouched. Unchecking a row writes **every** trigger ID into `ns.db.profile.ignoredSpells`, including ranks this client cannot see, so levelling or changing flavor keeps the choice. The ignore list is keyed by spell ID and shared by every feature. Both directions go through `ns.SetAbilityTracked` and are read by `ns.IsAbilityIgnored`, in `Features/Ability-Index.lua`: unticking stores `true`, and ticking clears the IDs, or stores `false` on a `shipsOff` row, which starts unticked.

**The sound picker is a plain `select` over `ns.GetSoundValues`**, which lists every sound registered with LibSharedMedia, so other add-ons' sounds appear beside Control Freak's. Choosing a sound plays it, and the speaker previews it whether or not Play Sound is ticked.

**Registration is deferred** into `ns.RegisterOptionsPanels`, which Core calls on `PLAYER_LOGIN` after `AceDB:New` and the ability index, because the Profiles builder reaches `ns.db`. The tree follows the root panel's Features block: General; the **Monitoring** page with Taunts, Interrupts, Fears, Incapacitated, Tank Deaths and Peer Pressure under it; the **Naughty List** page with Bad Mages, Bad Parry Monkeys, Bad Pets and Bad Priests; Tanking Tools with one sub-panel per tool; then Profiles, Feedback & Support and Diagnostic Tools. Both group pages register first, so they sit at the top in that order, then each tab under its group's ID in tab order. Taunts, Fears, Bad Pets and Peer Pressure each carry a Tracked Abilities sub-panel one level further down, the tree's fourth level. Every page nests under the category ID its parent's `AddToBlizOptions` returned, never its title (`README-Notes.md` records why). Each group page (`ns.BuildFeatureGroupOptions`) is the group's summary and the same block the root panel draws for it. `ns:OpenOptionsPanel` routes by the category ID captured from `AddToBlizOptions`, never by title: a title lookup fails on TBC Anniversary, where the category ID is a number assigned at registration, and the panel opens as a floating window instead of docking.

## Mini-map Button

A launcher LDB object registered with LibDBIcon under `ns.LOCALE_NAME`. Its icon is the game's own Taunt icon (`ns.MINIMAP_ICON`), so it reads as a taunt at a glance; the TOC's `IconTexture` is the add-on list's branding. `ns.MINIMAP_ICON_COORDS` crops the frame the game draws into its stock icons: LibDBIcon's own 5% inset clears the thin frame of an add-on's art but leaves this one showing inside the button's ring, where it makes the icon read as undersized. `ns:RegisterMinimapButton` also carries the Style Guide's icon fit for the Retail engine, gated on `ns.FLAVOR` being `Camelot` or `Mainline`; no TOC the add-on ships selects either, so it never runs today, and it fits the icon by hand rather than through `SetButtonIcon`, whose reset errors when another add-on has replaced the button's icon.

| Click | Action |
|---|---|
| Left-Click | Toggles the Monitoring group |
| Right-Click | Toggles the Naughty List group |
| Shift + Left-Click | Toggles Tanking Tools |
| Shift + Middle-Click | Opens the Options Interface, checked before any other binding |

**One block per click, in tooltip order.** `BLOCKS` in `Features/Minimap-Button.lua` holds the three switches the Features block draws in gold, each with its label, state, summary (`MONITORING_MINIMAP_SUMMARY`, `NAUGHTY_LIST_MINIMAP_SUMMARY`, `TANKING_TOOLS_MINIMAP_SUMMARY`, each naming everything its switch reaches) and binding, and both the tooltip and `OnClick` read it, so a binding cannot appear in one and not the other. A click that matches no block, a shifted Right-Click included, does nothing. All Alerts has no binding and no block.

**While All Alerts is off, the tooltip drops its blocks** for one `MINIMAP_ALL_ALERTS_OFF` line, and every click but Shift + Middle-Click does nothing, since with the combat log unregistered no switch would change what fires (`README-Notes.md` records the departure). The combat refusal lives inside `ns:OpenOptionsPanel` and is never repeated in `OnClick`.

**Every click toggle goes through `ns:ApplyProfile`**, not a bare `NotifyChange`, because each flips a switch that decides whether the combat log is registered. Without the registration test, the add-on stays hooked into every combat line for a feature just switched off, or unhooked from one just switched on. After a toggle the tooltip re-renders in place while `GameTooltip:GetOwner()` is still the button. The General panel's **Enable Mini-map Button** writes the inverted `minimap.hide` and calls `ns:ApplyMinimapButton` directly, since the button's visibility is nothing the registration test reads.

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

The framework (runner, panel, event buffer, Validate Data, Game Names) is Magic Eraser's `Diagnostics/` folder, copied whole. What describes Control Freak lives in `Diagnostics/Manifests.lua`, the Settings and Localization report lists in `Diagnostics/Report-Runner.lua`, the excluded firehoses in `Diagnostics/Event-Log.lua`, Display Context in `Diagnostics/Settings-Reports.lua`, and the probe's strings in `Diagnostics/Diagnostics-Core.lua`. Two pieces were built from the guide's rules because Magic Eraser's copy has no need of them: `ns:LogEventNow` in `Event-Log.lua`, and the `"spell"` kind in `Validate-Data.lua`. The tooltip readers Validate Data uses (`ns.GetTooltipLines`, `ns.GetItemStats`) sit in `Features/Utilities.lua`, each resolved once at load, and Diagnostics is their only reader.

Control Freak's own manifests:

- **`ns.DIAGNOSTIC_API_CHECKS`** has rows for every API the add-on calls or guards (the spell calls, the role and class-name lookups, the loss-of-control and aura calls, the Feign Death check, name plates, `C_Secrets`, the add-on message prefix and `Settings.OpenToCategory`) and for the load-bearing calls and libraries the core loop depends on. Validate Data appends a row per reader it calls.
- **`ns.DIAGNOSTIC_DATA_SOURCES`** has one row per flavor-folder file, `Abilities`, `Peer-Pressure-Abilities`, `Armor-Debuffs`, `Items` and `Sample-Spells`, so the Data tab validates all five `{Folder}/{Table}-{Folder}.lua` files for whichever folder this client loaded. `Items` is keyed by item ID and prints each item beside the spell it casts, and `Sample-Spells` is keyed by the name each panel asks for, so its only shipped column is that key. **`ns.ITEMS` has no reader in the feature code.** It exists so the Data Review can search for item families from the item side: the combat log names only the spell, and some items reach their effect through a summoned creature or a placed object that no spell table links back to the item. Its `DATA_TRACKED` column marks the items whose `spell` an Abilities row listens for. Each spell ID gets every reader the client ships, the row's own fields as `DATA_*` columns, and `DATA_ROW_NAME`, the client's name for the row's first resolving ID: a `NAME` that disagrees with it is an ID that belongs to a different spell, unless `DATA_RENAMED` says the rename is real. `SPELL_INFO` prints `C_Spell.GetSpellInfo` as returned, and both target clients hand its range pair back transposed (a 35 yard spell reads `minRange=35; maxRange=0`).
- **`ns.DIAGNOSTIC_NAME_LOOKUPS`** has a row per ability, read the way the index labels it, a male and a female row per Tank Deaths class through `ns.ClassName`, and a row per spell the panels' Example lines name through `ns.SampleSpell`.

**Alert Context** (Settings tab, `ns:BuildAlertContextReport`) is the add-on's context probe and the first thing to read on a "nothing ever fires" report. It prints the active profile, All Alerts and both group switches; each feature's scope settings, only the questions its tab asks, with the `ns:IsFeatureGateOpen` verdict; the group and instance state; the current target's Against rung; whether the combat log is actually registered; who counts as a tank, which Tank role tags a raid is ignoring, and whether a tank is alive; the group chat channel an announced line would use and whether the whisper election's message prefix registered; every alert section's switch, each row's print and announce (`SECTION_ROW_KEYS`), target filters and sound, with whether the stored sound name still resolves, and any other setting the section or feature carries; the `Sound_EnableAllSound` and `Sound_MasterVolume` CVars, since every alert plays on the Master channel; the ability rows this client drew, how many each tab has unticked and which by name, and how each taunt that can go either way is being reported; whether the client has the `C_LossOfControl` pair and what is active now; and how many Peer Pressure rows the player's class draws and has ticked. **Display Context** answers mini-map button reports with the screen size, UI scale and the button's saved state. **Saved Variables** prints every row, `ignoredSpells` and `tauntKinds` included. **Message Length** (Localization tab) builds every line in `ALERT_FORMATS`, Parry Monkey's confession with the stored message included, through `ns:BuildAnnounceMessage` and `ns.RenderAlertPart`, with the longest spell, boss, seat and dispel names this client gives and a twelve-letter two-byte player name, and flags any over 255 bytes; it sends nothing.

Diagnostics strings live in `ns.DiagnosticsStrings` as plain English and are never added to `Locales/`. The one localized string the panel reads is `L["ADDON_TITLE"]`.

## Saved Variables

One SavedVariables global, `ControlFreakDB` (`ns.SAVED_VARIABLES_NAME`), managed by AceDB-3.0 and created on `PLAYER_LOGIN` in `Features/Core.lua`. It holds every setting the player can change, Parry Monkey's running count, and the migration flag below.

**Model: Simple.** `AceDB:New(ns.SAVED_VARIABLES_NAME, ns.DATABASE_DEFAULTS, true)` gives every character the one shared `Default` profile, so everything lives in `ns.db.profile` and `ns.db.global` is unused. Nothing Control Freak stores differs from character to character: every key describes how the add-on behaves, and `ignoredSpells` is a choice about abilities rather than a record of what one character knows. **Reset Profile therefore clears everything back to install defaults**, the mini-map position, the ignored abilities, the taunt kind picks and Parry Monkey's count included. A new setting belongs in `ns.db.profile`.

The profile's shape, from `ns.DATABASE_DEFAULTS` in `Data/Default-Settings.lua`:

- `showWelcome`, `enabled` (All Alerts), `featureGroups` (the Monitoring and Naughty List switches, keyed like `ns.FEATURE_GROUPS`), and `minimap`, which LibDBIcon owns.
- One table per key in `ns.FEATURE_KEYS`. `FeatureDefaults` gives each `enabled` and the scope keys its `ns.FEATURE_SCOPE_OPTIONS` entry names; `WhoseAlertDefaults` builds its alert sections (see Alert Sections); and any setting the feature owns outright sits beside them, such as `tankDeaths.classes` and the whisper and cooldown on `badMages` and `badPets`.
- `ignoredSpells`, keyed by spell ID and shared by every feature: `true` unticks a row, and `false` ticks a `shipsOff` row. It ships empty and stays a diff against the data.
- `tauntKinds`, the Taunts tab's Single Target / AOE picks, keyed by the entry's first trigger ID. It ships empty and stays a diff: the dropdown stores a pick only when it differs from the data's `isAoe` and clears the key when it matches, so Reset Profile puts every row back on the data.

AceDB-3.0 applies `ns.DATABASE_DEFAULTS` when the profile is first accessed, filling only keys the saved table lacks, so an explicit `false` is never overridden, and strips values equal to their defaults when it saves. Control Freak defines no `*` or `**` wildcard defaults.

**There is no refill-on-empty logic**, because the add-on ships no default item or spell list. `ignoredSpells` is a settings map rather than a list: a player who unticked every ability meant it, and re-seeding it on login would undo the choice. The ability data is static Lua in the flavor folders and is never saved.

`ns:ApplyProfile`, wired to `OnProfileChanged`, `OnProfileReset` and `OnProfileCopied` and called once at the end of the login sequence, makes a switch, reset or copy apply live: it runs the migrations below, re-runs the combat-log registration test, re-points the mini-map button, and notifies every registered panel so an open Options Interface follows along.

### Migration Chain

Both run at the top of `ns:ApplyProfile`, in this order, and are tagged `MIGRATION (remove after 2026-11-27)`:

1. **`MigrateParries`**: Parries left Tanking Tools for the Bad Parry Monkeys tab. It merges any saved `tankingTools.parry` into `badParryMonkeys.alert` and nils the old key; if Tanking Tools was on, it switches Bad Parry Monkeys on with Tanking Tools' scope answers and keeps the whisper the old section shipped on unless the player had turned it off. `profile.parriesMigrated` stops it running twice, since a profile that never saved a Parries change leaves nothing to clear.
2. **`MigrateRowOutputs`**: an alert row's `{ enabled, output }` became `{ print, announce }`. A row switched off becomes print off and `NEVER`; otherwise it keeps printing, and an old `PARTY` or `ANNOUNCE` output becomes `PARTY` or `GROUP` with the print as its fallback. It walks every section of every feature for the `mine`, `others`, `short` and `long` rows, and runs after `MigrateParries`, which can carry an old-shape row into Bad Parry Monkeys.

Earlier shape changes shipped without a bridge, by the maintainer's decision: their stale keys (`badPet`, `taunts.stolen`, `tankingTools.nova`, and an alert section's old `print`, `announce` and `bossOnly` booleans, among others) stay in the file unread until a profile reset clears them. What a future change to saved data owes is under Contributing, and why a retired key name is never reused is under Common Pitfalls.

## Adding a New Ability

1. Add one entry to `ns.ABILITIES` in the `Abilities-{Flavor}.lua` of every flavor folder where the ability is live, in its class block, with the ability's name in the trailing comment on the closing brace. An item goes in the `ITEM` block with the category of what its Use does, and its row in that folder's `Items-{Flavor}.lua` names the same spell.
2. Leave it out of every folder where it does not exist, where its ID belongs to a different ability, or where it must not be tracked, and say which folders got it.
3. Set `detection`: `AURA` only if the ability applies an aura on every flavor it is live on, otherwise `CAST`.
4. List every castable rank in `triggers`, in rank order, since the row takes its name from the last one that resolves, with no effect IDs or learn triggers, unless the cast lands nothing the combat log can see, as with Righteous Defense (see Ability Data).
5. Set `renamed = true` only for a verified rename across the entry's ranks or flavors.
6. Set `kindChoice = true` only on a taunt that takes a few mobs rather than one or a whole pack, and only with `AURA` detection; `isAoe` is then the row's default.
7. For a new category, map it in `ns.CATEGORY_FEATURE` in `Features/Ability-Index.lua`, add its branch at the end of `ns:OnCombatLogEventUnfiltered`, and pass it to the `ns.BuildAbilityToggles` call on the owning tab's Tracked Abilities sub-panel. The category lists in each `Abilities-{Flavor}.lua`'s comments are the Data Review's to update.
8. On a live client of each flavor, run Diagnostic Tools → Data → Abilities, and check that the new rows read `OK`.

## Adding a New Alert Section

1. Add the section's defaults to its feature's table in `Data/Default-Settings.lua` through `WhoseAlertDefaults(soundName, overrides, noTarget, rowKeys)`, with the reason beside any override. Pass `true` for `noTarget` when the line names no single mob, and pass both fields of any row an override names.
2. Add its strings to `Locales/enUS.lua`: a `_HEADER`; an `_ENABLE` reading "Enable Alerts for <thing> On", so the Against ladder finishes the sentence (a `noTarget` section drops "On"); a `_DESC` of one or two sentences; and a `_MINE` and `_OTHERS` pair, per section rather than a template, because "My" and "Others'" agree with the noun in some languages.
3. Add the message format, and add it with its part kinds to `ALERT_FORMATS` in `Diagnostics/Manifests.lua`, which is the list Diagnostic Tools → Localization → Message Length measures; a format left off it is never measured. It has to fit 255 bytes in ruRU with a real spell link and a real boss name substituted.
4. Call `ns.AddWhoseAlertSection` in the tab's builder, 20 of order after the previous section, with a prefix no other builder on the panel uses and `sample = { key, args }` naming that format.
5. Call `ns:Alert` from the handler with the section, the format key, its parts, the source flags, and the mob's GUID and raid-icon index. A section whose rows are not picked by affiliation also passes the `rowKey` as the seventh argument, the same word as its `rows` entry and its `WhoseAlertDefaults` row key.
6. If the section whispers or keeps a cooldown, draw the row through `afterSample` and `ns.AddWhisperRow`; in the handler, call `ns:PassesAlertGates` before the cooldown, and send through `ns:QueueGroupWhisper` with a new `kind`. If a row's announce must stay inside the cooldown, resolve it with `ns.ResolveAlertDestination` before the cooldown, as Incapacitated does.
7. If the section is a new Tanking Tool, it gets a sub-panel rather than a place on the parent tab: add a `{ key, headerKey, registry }` row to `ns.TANKING_TOOLS`, its registry name to `ns.OPTIONS_REGISTRY`, an icon to `TOOL_ICONS` in `Options/Options-General.lua`, and a builder in `Options/Options-Tanking-Tools.lua` named `ns.Build<registry>Options` that calls its `ToolPanel`. Registration, the root panel's switch and the sub-panel's order all follow from the list.

## Adding a New Feature Tab

1. In `Data/Data.lua`, add the key to `ns.FEATURE_KEYS` in tab order, its scope questions to `ns.FEATURE_SCOPE_OPTIONS`, its registry name to `ns.OPTIONS_REGISTRY`, and, when it belongs to a group, the key to that group's `features` in `ns.FEATURE_GROUPS`, which puts its switch on the group's page and the root panel and under the group switch.
2. Add its defaults to `Data/Default-Settings.lua` through `FeatureDefaults`.
3. Add `Features/<Name>.lua` with the handler, appending any per-fight state's reset to `ns.stateResets`. If the tab owns an ability category, map it in `ns.CATEGORY_FEATURE`. If its trigger is not the ability path, the handler checks All Alerts and asks `ns:IsFeatureGateOpen` itself, as Incapacitated and Tank Deaths do.
4. Add `Options/Options-<Name>.lua` with a builder that opens on `ns.AddFeatureScope`. A tab with an ability list puts it on a Tracked Abilities sub-panel of its own, with its own registry name, built like `ns.BuildFearsTrackedOptions`, including its `ns.AddQuietStatus(args, 0.4, featureKey, tabKey)` status line.
5. Add both files to every flavor TOC: the feature file among the feature modules, before `Features/Minimap-Button.lua`, and the panel file in tab order, before `Options/Options-Tanking-Tools.lua`.
6. Register the panel in `ns.RegisterOptionsPanels` in tab order, under its group's page ID (`monitoringID` or `naughtyListID`), or under `mainCategoryID` when it belongs to no group, with any sub-panel right after it through `AddSubPanel`.
7. In `Options/Options-General.lua`, add the key to `FEATURE_CAPTION_KEYS` (its `TAB_*` key) and `FEATURE_ICONS`.
8. Add the `TAB_*` key to `Locales/enUS.lua` in the tab-order block, with the tab's `_SUMMARY` and `_ENABLE`, and add the tab to its group's mini-map summary (`MONITORING_MINIMAP_SUMMARY` or `NAUGHTY_LIST_MINIMAP_SUMMARY`), which names everything that switch reaches.

The combat-log registration test, `MigrateRowOutputs` and the Alert Context report all loop over `ns.FEATURE_KEYS`, so none needs an edit.

## Adding a New Registered Event

1. Add the name to `ns.EVENT_NAMES` in `Features/Core.lua`, so the dispatcher and the Diagnostics registration probe pick it up together.
2. Define `ns:On<EventInCamelCase>` in the feature file that owns it (`GROUP_ROSTER_UPDATE` → `ns:OnGroupRosterUpdate`). Never call `RegisterEvent` from a feature file.
3. If the event is a firehose, add it to `ns.DIAGNOSTIC_EVENT_EXCLUDE`, and have its handler write the firings it acts on through `ns:LogEventNow`.
4. If the event triggers an alert outside the combat-log path, its handler checks All Alerts and its feature's scope gates itself.

## Adding a New Sound

1. Add an `.ogg` to `Includes/Sounds/`, one to two seconds long, since it fires mid-pull on top of everything else. `PlaySoundFile` plays `.mp3` too, but the Vorbis file is a third to a quarter of the size; on macOS, `afconvert -f Oggf -d vorb in.mp3 out.ogg` converts it.
2. Add a `{ picker name suffix, file name }` row to `ns.SOUNDS` in `Data/Data.lua`. The picker name is the add-on's title, a colon and that suffix (`Control Freak: Parry`), built into `ns.SOUND_NAMES`. The suffix says which alert the sound was made for, not what it sounds like; a spare made for no alert in particular is the one sound named for how it sounds.
3. To make it an alert's default, point that section's `soundName` at `ns.SOUND_NAMES["<suffix>"]` in `Data/Default-Settings.lua`. Which sound an alert plays out of the box is that file's call, not the name's, so an alert can default to a spare and a sound made for an alert can end up nobody's default.

**Never rename a published suffix** to match the alert that now plays it, or for any other reason: profiles store the full picker name, and a name the list no longer registers leaves that alert silent behind a blank picker.

## Localization

`Locales/enUS.lua` is the source of truth and the only file that passes the `true` default-fallback flag. The other ten translate its key set and belong to the Localization Review (`07 - Localization Review.md`), so they are never hand-edited during ordinary work. A retired key name is never reused, because a stale translation of it would silently win over the English fallback.

**The AceLocale name is `ControlFreak` (`ns.LOCALE_NAME`), not `ADDON_NAME`.** The installed folder is `Control-Freak`, and every `NewLocale()` uses the brand literal. `Data/Data.lua` defines the constant and derives the add-on message prefix from it, and `Features/Minimap-Button.lua` uses it for the LDB object and the LibDBIcon key. `ADDON_NAME` stays for what is keyed off the packaged add-on: metadata reads, registry names, the spell-toggle widget type and sound paths. The Full Name and the Short Name are both "Control Freak", and both keys still ship in every locale.

**Placeholders must match `enUS` per key in every locale**, in count, type and order, or the string crashes the first time that alert fires. `string.format` has no positional placeholders, so a translation moves words around its placeholders and never the placeholders themselves. The orders that need care:

- `TAUNT_IMMUNE` runs mob, taunter, taunt; every other taunt format opens on the taunter.
- The four `INCAPACITATED` formats run seat, length, player, spell, dispel type, caster, each dropping its optional parts.
- `TANK_DEATHS_CLASS_LINE` takes the class name first and the player second.
- `PARRY_CONFESSION` takes the player's own words (`%s`) and then the count (`%d`).
- `ALERT_AGAINST_DESC` quotes `TARGET_RUNG_ELITE_0` and `ALERT_MARKED_ALWAYS` by name, and `ALERT_PRINT_DESC` and `ALERT_ANNOUNCE_DESC` quote the Announce choices, so each must match the strings it quotes or the tooltip explains a choice the player cannot find. The translator note above them in `enUS.lua` says so.

**Game names come from the client by ID, never from `Locales/`.** Spell names come from the trigger IDs in each flavor folder's `Abilities-{Flavor}.lua`, `Peer-Pressure-Abilities-{Flavor}.lua` and `Armor-Debuffs-{Flavor}.lua`, through `ns.GetSpellNameAndIcon` (`C_Spell.GetSpellInfo`) for the panel rows and `ns.GetSpellDisplay` (`C_Spell.GetSpellLink`, rebuilt into a link when Era answers with a bare name) for the alert lines. The Example lines name spells from `ns.SAMPLE_SPELL_IDS` in each flavor folder's `Sample-Spells-{Flavor}.lua`, as links through `ns.SpellPart`, the same part a live alert renders. Diagnostics' Game Names report reads the same IDs through `ns.SampleSpell`, which falls back to `UNKNOWN_SPELL` rather than an English name. The roster names in `ns.SAMPLE_NAMES` are proper names, the same in every locale, so they live in `Data/Data.lua` rather than in `Locales/`. Class names come from the client through `ns.ClassName`, never from the locale files, so they match the tooltips beside them. A line about a person passes their sex, so a female character's class reads in its female form where the language has one (Incapacitated's opener and Tank Deaths' class log); the client's female column is blank in enUS and itIT, and a blank answer falls back to the male name. The sample boss names are locale keys (`SAMPLE_BOSS_*`), written exactly as each client names them. The chat prefixes on the Examples (`CHAT_PARTY_GET`, `CHAT_WHISPER_GET`) and the message box's Reset button (`RESET`) are the client's own GlobalStrings. The Tank and Healer words that open an Incapacitated line (`INCAPACITATED_ROLE_TANK`, `INCAPACITATED_ROLE_HEALER`) are our own translations rather than the client's role labels, which name a role rather than a person and read wrongly as the subject of a chat line; `README-Notes.md` records the exception. Parry Monkey's shipped confession (`BAD_PARRY_MONKEYS_MONKEY_MESSAGE_DEFAULT`) is a locale key, so a fresh profile stores it in the player's language, and a typed message is the player's own words and never translated. Not localized: `ns.DiagnosticsStrings`, which is developer-facing.

Everything else, including the Spanish file pairing and the overflow canary, is per Style Guide → LOCALIZATION and MESSAGES → Message Length.

## Common Pitfalls

- **Stripping pipes or color codes from a sent body**: a spell link is one escape sequence, so the client drops the whole message with no error. `StripChatFormatting` converts the raid-icon texture and nothing else. The one body that is stripped is Parry Monkey's typed message, which never carries a link.
- **Cutting a sent message with `string.sub` at 255**: the cut lands inside a link or a multi-byte character, and the message is dropped or mangled. `ns:Announce` cuts through `SafeCutLength`.
- **Reading the miss type from the wrong return slot**: `SWING_MISSED` puts it twelfth and `SPELL_MISSED` fifteenth, and the wrong one compares a number to `"PARRY"` forever. `ns:OnCombatLogEventUnfiltered` normalizes both before dispatching.
- **Naming a handler after the event**: the dispatcher calls `ns:On<EventInCamelCase>`, so an `ns:COMBAT_LOG_EVENT_UNFILTERED` is never called.
- **Replacing `ns.ABILITY_MAP` rather than refilling it**: `Features/Combat-Log.lua` aliases the table at load and would go on reading the empty original. `ns.BuildAbilityIndex` wipes and refills.
- **Treating `ns.GetEnemyTier` as a boolean**: `nil` means unanswerable and has to pass. The filter tests `tier == nil` by name.
- **Throttling alerts on a time window**: it merges a cast with the miss that follows it and eats every resisted taunt. The dedupe keys on timestamp, caster's GUID, spell ID and outcome, plus the mob's GUID for a taunt reported as Single Target.
- **Starting a cooldown before the gates**: an event the filters drop uses up the window and swallows the next real one. Whispering features and Parry Monkey call `ns:PassesAlertGates` first, and Incapacitated resolves its row's destination first.
- **Reading a row as on or off**: a row is `{ print, announce }`, and `print` is only the fallback when the announce finds no channel. Ask `ns.ResolveAlertDestination`, never `row.print`, for whether a line will show.
- **Comparing names in the whisper election**: `CHAT_MSG_ADDON` reports `Name-Realm` while the client's own name APIs drop your realm, so a name never matches your own and the echo filter silently stops working. The election compares player GUIDs, for the echo filter and the tie-break alike.
- **Passing `control` to a section that has a target**: the builder overwrites it with the Against ladder, and the control silently disappears. A parameter of the detection goes in `captionRow`.
- **A `rows` key the defaults do not build**: the key is the settings key, the widget key and the `rowKey` at once, so the panel's `rows`, `WhoseAlertDefaults`' fourth argument and the handler must all use the same words, or the panel writes to a row `ns:Alert` never reads. A new row key also goes in `ROW_KEYS` in `Features/Core.lua` and `SECTION_ROW_KEYS` in `Diagnostics/Manifests.lua`.
- **Adding a `groupHasTank` default to a tab that does not ask it**: `ns:IsFeatureGateOpen` still reads the key, so the tab would be gated by a switch nobody can see. `ns.FEATURE_SCOPE_OPTIONS` decides which keys exist.
- **Reusing a retired saved-variables key**: profiles still carry keys from earlier data shapes, and AceDB fills a table default only into a slot that is empty or already a table. A new table under an old key that a profile holds as `true`, a number or a string never receives its defaults, and the first read into it errors. Give new data a fresh key.
- **Capturing `ns.db.profile` in a panel closure**: a profile switch replaces the table, and the panel keeps writing into the old one. Every builder takes a getter.
- **Flipping an `enabled`, group or `instanceOnly` flag without `ns:ApplyProfile`**: the combat log stays registered for a feature just switched off, or unregistered for one just switched on.
- **Two builders writing the same args key**: AceConfig args are one flat table per panel, so the later write silently replaces the earlier widget. `ns.AddGatedHeader` suffixes its keys, sections take their caller's prefix, and `ns.BuildAbilityToggles` has no key prefix, so a panel calls it once with every category it lists.
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
- Any change to the shape, name or scope of saved data ships its own migration, tagged with a removal date 30 days past the release that ships it, and run from `ns:ApplyProfile` (see Migration Chain).
- Measure any new or reworded chat line or whisper against the 255 byte ceiling in ruRU, with a real spell link and real names substituted.
- Edit only `Locales/enUS.lua`; the translations belong to the Localization Review.
- Update this document in the same change when the architecture, the File Map or the saved-variables shape moves.

**A pull request description says what a player will notice**, in plain language, the way release notes do: "Righteous Defense can now report each mob it takes", not the function that changed. The commit messages carry the developer detail.
