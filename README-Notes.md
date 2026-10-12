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
