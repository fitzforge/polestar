# nav-grid: the JS grid builder on a synthetic grid

Read by `forge-navbuild/tests/{surfaces,links,graph,format_roundtrip}.rs` and, as the grid, by every
`forge-nav` golden (nav-legs, nav-walks, nav-store).

- **Inputs (synthetic, written by `regen.js`; licence: the repository's):** four tiles (32..33 x 32..33) of
  continent 0 built from `tests/helpers/navscene.js` scenes: terrain with holes, models, indoor floors and a
  ramp, MH2O water (fresh, deep, ocean, magma), a WMO liquid, a reviewed opening, a maze, a model plateau
  with falls, an enclosure (another region), a terrain cliff and ramp, a mesa with an elevator (one lift);
  chunk areas from a synthetic AreaTable (`data/AreaTable.csv`, build `data/build.txt`) and
  `data/zones.json`; hubs (`nav-layers/hubs.json`) and a roads layer (weights, not committed: regen.js
  writes them). No client file, no game data.
- **Outputs (the JS's):** `geom/0/*.geom.gz` (the geometry in tileGeometry's shape, the serialisation of
  RsWriter's scratch dump.js), `surf/0/*.{surf,walls}.gz` (worker.js surfaces op), `nav4/` (build.js
  buildGrid: tiles, walls, graph parts, `graph/0.bin.gz`, `index.json`, `lifts.json`; router.js prepare:
  `walk/` road mask, walk graphs per faction, zone mix).
- **JS:** this branch's `tools/` at 651ee7536 (the v1 seed has no router.js), copied to a scratch root.
- **Command:** `node rust/tests/golden/nav-grid/regen.js <scratch js root> <out>`; then copy `<out>` here.
  Run nav-walks/regen.js after it on the same scratch root.

Not CI-provable: `geom.rs` (tile_geometry over the client's ADT/WMO/M2 files: client geometry is not
shareable; opt-in with `POLESTAR_NAV_SCRATCH`), and build.rs's lift search (`lift_links`, private) and
`index.json` writing, which need a geometry Source; the lift's graph edges are checked through
`lifts.json`.
