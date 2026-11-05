# nav-pack: the JS walking-map writer on the synthetic grid

Read by `forge-nav/tests/pack` (golden.rs): `forge nav pack`'s writer must give these files byte for byte
when it names the JS command as its generator.

- **Inputs (synthetic; licence: the repository's):** the grid of `../nav-grid/nav4` (four tiles of continent
  0 built from scenes, its README) with its lifts; `nav-layers/hubs.json` (nav-grid's hubs) and
  `nav-layers/roads/` (nav-grid regen.js's roads layer: weights per column); `data/AreaTable.csv` (nav-grid's
  areas with names and flags: Mid Ridge, 9002, is a capital), `data/zones.json` (nav-grid's),
  `data/map-frames.json` (Era frames of the zones), `aids.json` (approach chains and zone crossings in map
  percent on the continent's frame: a building mouth, a cave, a pass, a lift chain left out, a bridge, a
  tunnel, a lift crossing left out, a pass). No client file, no game data.
- **Outputs (the JS's):** `Polestar_Nav/` (`--cells 128`) and `Polestar_Nav-32/` (`--cells 32`): `Nav/Nav0.lua`,
  its parts, `Nav/Chokepoints.lua`, `Nav/Nav.xml`, `PACK.json`; dated 2026-10-23.
- **JS:** tools/lib/nav/pack.js and chokepoints.js of baked-legs at 73e0ebbc8 (maps format 3's area field, the
  cave and building mouths that are doorways), the last JS writer, composed as its tools/commands/nav.js
  `nav pack` composed them (packPlaces, zoneLookup, packLayers), on `../nav-grid/nav4` as regenerated at
  01ff845ca. The grid has no area sidecars: the maps are format 2. (The first version, e678900c8's writer on the
  grid before 01ff845ca, differed only in the grid's `builtAt` and the header's area lines.)
- **Command:** `node rust/tests/golden/nav-pack/regen.js <js root> rust/tests/golden/nav-pack`, `<js root>` a
  checkout (or `git archive baked-legs tools`) of that commit.

The real grid is checked opt-in (`golden.rs` real_grid_matches_the_js, its doc comment): every file identical
on 2026-10-23's 1.60.1.70532 grid (Eastern Kingdoms, Kalimdor, Zephras Isle: 70 Lua files and PACK.json).
