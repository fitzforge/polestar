# golden/world

Inputs and JS references for `forge-world/tests/parity.rs`. They are also the shared data slice that the sim, judge and guide goldens use.

## root/: a mini repository (inputs)

- `data/forever/`: a shareable data slice. It covers Durotar 1411, the Barrens 1413, Orgrimmar 1454, Elwynn Forest 1429 and Stormwind 1453. `slice.js` cut it from a full JS data build:
  `node tools/polestar.js data build --offline --no-questie --no-web-zones --no-web-xp --sources $POLESTAR_CHECKOUT/data/sources --built-at 2026-10-22T00:00:00.000Z --out <scratch>/forever-full`
  The build ran in a checkout of next @ eb7b47840. The cut command was:
  `node slice.js <scratch>/forever-full <main>/data/forever/trainers.json <main>/data/forever/travel.json root/data/forever`
  Sources and licences: pfQuest (MIT), Blizzard client tables (wago.tools), CMaNGOS classic-db heights (GPL facts) and Polestar's curated trainers.json. travel.json keeps only the client-table taxi nodes, legs and inns. dungeons.json is synthetic and empty: no DungeonJournal data. Nothing comes from QuestieDB, ForeverDB, the web quest-database pages, the web zone lists or web XP.
- `data/sources/`: small source files.
  - `wago/1.15.9.70003/QuestXP.csv`, `wago/1.60.1.70450/{Map,AreaTable}.csv`: Blizzard client tables.
  - `cmangos/22b51464f162/gameobject_facts.json`: CMaNGOS facts (GPL), cut to the slice's objects.
  - `cmangos/22b51464f162/graveyards.json`: CMaNGOS's graveyard table (GPL facts), cut to the links of the slice's zones (Durotar 14, the Barrens 17, Orgrimmar 1637, Elwynn Forest 12, Stormwind 1519) and those graveyards' places.
- `data/rules.json`: a copy of this checkout's rules file. `regen.js` refuses to run if the copy differs from the JS checkout's.
- There is no walking grid (`data/local/nav4` does not exist), so worlds have no floor heights and the atlas has no subzones.

## expected/ (gzipped JS outputs)

- `world-{horde,alliance}.json.gz`: the world files from `getWorld` (tools/lib/sim/world.js). Since A10 (2026-10-24) the Alliance world's Zephras Isle exit is the Rust builder's (the skycutter lands in Alterac; the Skyborne Portal to Stormwind is its own ride): world-alliance.json.gz and the synthetic Alliance fixtures were rewritten from the Rust builder; the JS builder keeps the old one-ride exit.
- Since the one-camp rule (2026-10-25: a quest's kill work at one camp when one camp has every target), both worlds were rewritten from the Rust builder (the JS builder places each target at its own best site).
- Since the graveyard table (2026-10-27: World::graveyards, for deathskips) both worlds carry `graveyards`, their Spirit Healers' points after every other point and the graveyards' input digest; rewritten from the Rust builder again: `WORLD_OUT=<dir> cargo test -p forge-world --test parity dump_slice_worlds -- --ignored`, then `gzip -n -9`.
- Since the vendor rule (2026-10-27: an item objective a friendly vendor sells is bought there when that costs less than its best drop), both worlds were rewritten from the Rust builder again (Gathering the Cure's Earthroot and Give Gerard a Drink's Rhapsody Malt are bought).
- Since tasks' other places (2026-10-27: a task's `alts`, a bought item's other friendly vendors and an object's other sites), both worlds were rewritten from the Rust builder again (same command, `gzip -n -9`): tasks gained `alts` (3 Horde, 5 Alliance) and a bought item's other vendors their points (2 Horde, 26 Alliance, so later point ids shift).
- `atlas-*.json.gz`: the atlas dump in the format of the removed `forge-world/tests/js/jsatlas.js` (git history at 734380d2a).
- `rules-ref.json.gz`: made the same way as the removed `jsrules.js`, for Orc Warrior, Troll, Human Mage and Human Paladin.
- `walkrules-ref.json.gz`: made the same way as the removed `jswalkrules.js`.

To regenerate (not run in CI): `JS_ROOT=<a checkout at 734380d2a> node rust/tests/golden/world/regen.js` (this checkout no longer has the JS judge atlas and rules). POLESTAR_GRID must be unset when the tests run.

Not CI-provable: worlds with grid floor heights and atlas subzones. Both need the walking grid, which is client geometry and cannot be shared.
