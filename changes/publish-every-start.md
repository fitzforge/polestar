---
section: forge
---
- `forge guide publish --from <out>/guides` publishes every start of a build
  at once: each faction's shared route a single time (it refuses when the
  starts wrote it differently), each start's own guides, Orc and Troll's
  Durotar and Dwarf and Gnome's Dun Morogh routes once per race (`orc/`,
  `troll/`, `dwarf/`, `gnome/`, their old ids retired), and one `legs.json`.
  The compiled guide parts stay about 2 MB per faction instead of carrying the
  shared route once per race.
