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

### Brand last on local alert prints

- **Departs from:** MESSAGES, combat-related prints lead "with its short name, `L["ADDON_SHORT"]`".
- **Instead:** Alert prints in the player's own window put the brand last, `body // Control Freak`, the same shape the group sees in chat.
- **Why:** An alert body already opens on its headline and carries its target's raid mark, so leading with any brand only delays the news.

### Enable Control Freak under Master Switch

- **Departs from:** OPTIONS PANEL → Main Page Layout, "Features never holds a switch for the whole add-on," and its page order, which has no section above Features.
- **Instead:** Enable Control Freak (All Alerts, `ns.db.profile.enabled`) sits alone under a Master Switch header, just above Features. In Features, the feature switches sit in tiers, each with its icon ahead of its caption, two to a line with a blank line between tiers: Taunts, Interrupts and Fears; Incapacitated and Tank Deaths; Bad Pets and Bad Priests; then Peer Pressure and Tanking Tools. All of them, and the Tanking Tools section, hide while it is off.
- **Why:** the switch silences every alert without unloading the add-on, and the mini-map button's Left-Click toggles the same setting; the button can be hidden, so the panel keeps a copy.
