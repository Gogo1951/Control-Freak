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

- **Departs from:** MESSAGES, "Every print leads with the Full Name, `L["ADDON_TITLE"]`."
- **Instead:** Alert prints in the player's own window put the brand last, `body // Control Freak`, the same shape the group sees in chat.
- **Why:** An alert body already opens on its headline and carries its target's raid mark, so leading with any brand only delays the news.

### Enable Control Freak under Master Switch

- **Departs from:** OPTIONS PANEL → Main Page Layout, "Features never holds a switch for the whole add-on," and its page order, which has no section above Features.
- **Instead:** Enable Control Freak (All Alerts, `ns.db.profile.enabled`) sits alone under a Master Switch header, just above Features. In Features, each feature switch carries its tab's own name with its icon ahead of it, two to a line, in blocks with a blank line between them: a gold Monitoring switch over Taunts, Interrupts, Fears, Incapacitated, Tank Deaths and Peer Pressure; a gold Naughty List switch over Bad Mages, Bad Parry Monkeys, Bad Pets and Bad Priests; then a gold Tanking Tools switch over Cold Openers and Armor Debuffs. Each gold switch silences the switches indented under it, which grey out rather than hide. All of them hide while it is off.
- **Why:** the switch silences every alert in one click without unloading the add-on or changing any group's or feature's own switch, so switching it back on restores exactly what was on.

### Group pages in the settings tree

- **Departs from:** OPTIONS PANEL → Panels and Registration, "General (root) → feature panels, each followed by its sub-panels."
- **Instead:** Monitoring and Naughty List each have a page under the root with their feature tabs nested beneath it, and Tanking Tools stays directly under the root.
- **Why:** the tree mirrors the General panel's Features groups, so a player finds each tab under the switch that silences it.

### Mini-map tooltip while All Alerts is off

- **Departs from:** MINIMAP BUTTON → Tooltip Structure, the per-feature blocks.
- **Instead:** while All Alerts is off, the tooltip replaces its click blocks with one line saying nothing fires, and every click but Shift + Middle-Click does nothing.
- **Why:** with every alert silenced, those blocks would advertise clicks that change nothing.

### Sub-panels nest by category ID

- **Departs from:** OPTIONS PANEL → Panels and Registration, "registered with that panel's display name as the parent."
- **Instead:** group pages, feature tabs and their sub-panels register under the category ID their parent's registration returned, while Profiles, Feedback & Support and Diagnostic Tools pass the Full Name.
- **Why:** the tree nests more than one level deep, and a lookup by display name does not reliably find a parent below the top level on every client.
