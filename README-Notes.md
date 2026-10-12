# Control Freak // Notes

> Where Control Freak departs from the Gogo1951 add-on Style Guide, kept so no review raises it again.

## Exceptions

### No WoW Forever TOC

- **Departs from:** TOC FILE FORMAT → Flavor TOCs, "Every add-on ships a TOC for every current target."
- **Instead:** Control Freak ships no `_Camelot.toc`, will never support WoW Forever, and keeps `Data/Camelot/` only because DATA → Flavor Folders keeps all seven folders, with `.pkgmeta` ignoring it like any folder no TOC lists.
- **Why:** Control Freak is a combat announcer, and WoW Forever returns in-combat reads as secret values, so it has no path there (COMPATIBILITY).

### Seat words in our own locale strings

- **Departs from:** GAME NAMES, "Locale files hold only our own words."
- **Instead:** the Tank and Healer words that open an Incapacitated line are Control Freak's own translations rather than the client's role labels.
- **Why:** the client's role labels name a role rather than a person, so as the subject of a chat line they read wrongly in several locales and stay English in others.

### Raid marks on WoW Forever

- **Departs from:** MESSAGES → Target Marker, "WoW Forever blocks raid-marker tokens in chat".
- **Instead:** Sent lines keep the mob's raid mark (`{rtN}`) on WoW Forever.
- **Why:** Forever renders raid marks in party, raid and whisper chat, the only channels Control Freak sends to.

### Alert lines keep their closing period

- **Departs from:** MESSAGES, a time-sensitive sent message's "body drops its closing period".
- **Instead:** Alert and whisper bodies end on a period after the headline's bang ("Taunt Failed! Joe's Taunt on Maexxna missed.").
- **Why:** The maintainer's copy choice.

## Decisions

- Scope is per feature: every tab carries a role dropdown beside its enable (As a Tank / As a Healer / As a Tank or Healer / Always) and While in Instances; only Taunts, Tanking Tools, Bad Priests and Bad Pets add When Group Has a Tank.
- Each targeted alert section carries a four-rung Against ladder (Everything / Elites & Bosses / Elites Your Level+ & Bosses / Bosses) plus an Always Alert on Marked Targets override that ships on.
- Only group-affiliated sources are tracked, and there is no Other category.
- A resisted taunt prints only the failure line (success is the taunt debuff landing), with Missed / Resisted / Immune variants; AoE taunt misses are not announced.
- There is no Items category: target dummies count as AoE taunts, and Flash Bomb as a fear.
- Bad Pets alerts and whispers at most once per pet per cooldown (30 seconds, 1 minute or 5 minutes, shipping at 1 minute), with no per-boss or per-instance mode.
- "Tank" means an assigned Main Tank in a raid and the group finder's Tank role in a party, never Main Assist; a raid ignores the Tank role, which lingers from dungeon queues, even though a raid with nobody assigned Main Tank then has no tank.
- Sounds are the add-on's own files under `Includes/Sounds/`, registered with LibSharedMedia so other add-ons' sounds also appear.
- Cold Opener Warnings report only the player's own avoided abilities, since a pull whose holder is unknown is unreadable for others.
- Incapacitated lines open on the player's seat: Tank, Healer, or the player's class name for a player in neither seat.
- The mini-map tooltip's state words are "Enabled / Disabled", by the maintainer's copy choice.
- The rebuild ships no migration off the pre-rebuild profile schema, the print/announce alert shape, the `badPet` to `badPets` rename, or the `tankRoleOnly` to `roleScope` change; those settings reset to defaults once, and their stale keys stay unread in SavedVariables.
- Declined: Taunt Overwrite Warnings (Hey That's Mine), because a planned taunt swap and a stolen mob are identical in the combat log.
- The paladin bubbles stay parked, listed only in a comment in each flavor folder's `Abilities-{Flavor}.lua`, which is not a finding.
- The Bad Priests tab stays visible on every flavor, Season of Discovery included, where the copy says a priest rune gives the rage back rather than the tab hiding itself.
- Sent lines keep the mob's raid mark (`{rtN}`) on WoW Forever, since party, raid and whisper chat, the only channels Control Freak sends to, render it there.
- Alert and whisper lines end their body on a period after the headline's bang ("Taunt Failed! Joe's Taunt on Maexxna missed."), by the maintainer's copy choice.
- Tank Deaths' My Death row fires only while the player is tanking, and both Tank Deaths rows ship printing, so a fresh install keeps tank deaths out of group chat.
- `README.md`'s Related Add-ons files add-ons that do one Control Freak job outright, such as interrupt or loss-of-control announcers, as Direct Alternatives, lists WeakAuras as its only Some Overlap entry, and leaves out GeodesicDragon's ThreatWatch as unimportant, all by the maintainer's choice.
