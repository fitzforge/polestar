# Synthetic data-build fixture

A hand-made, tiny world for the data build's tests (rust/crates/forge-data/tests/data: fixture_build,
questie_store, data_gate in rust/crates/forge/tests) and tests/record-finds.test.js. Nothing here comes from
a third party: the quests, NPCs, objects and items are invented.

- `pfquest/`: an open quest database in pfQuest's layout (MIT licence file with a fixture author).
- `sources/wago/1.15.9.11111/`: client tables in the CSV layout of the source cache (UiMap,
  UiMapAssignment, AreaTable, Faction), rows written by hand.
- `recordings/`: four recorder sessions.

Edit by hand; there is nothing to regenerate.
