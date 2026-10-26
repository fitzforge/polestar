# nav-walks: the JS router's walk tables on the synthetic grid

Read by `forge-nav/tests/{walks_parity,route_walks,store_parity}.rs` (via `tests/common/mod.rs`; the grid
is ../nav-grid/nav4). `regen.js` here also writes ../nav-legs and ../nav-store.

- **Inputs (synthetic, written by `regen.js`):** `world-{horde,alliance}.json`, a sim world of 38 places
  over the synthetic grid's features (heights, lift, house floors, lake, cliffs, enclosure, off the grid)
  plus one point on continent 1, zone levels and a 200 yd danger grid; `route-horde.json`, a route of
  `walk` actions over it.
- **Outputs (the JS's):** `horde/asks-{0,10}.{bin,json}` and `horde/ends.json` (parity/asks.js's logic,
  js backend), `walktable/<key>.bin` (walktables.js routerWalks' band tables: router.js distanceRows over
  path.js), `areazones.json` (router.js areaZoneTable and the base groundKey).
- **JS:** this branch's `tools/` at 651ee7536 with path.js's heightless floor rule of 2026-10-25 (outdoors,
  the top surface under the open sky before the highest terrain; the same edit as this tree's path.js), in the
  scratch root nav-grid/regen.js built, its `data/local/nav4` replaced by ../nav-grid/nav4 (so the grid's
  `builtAt` and every key stay the committed grid's).
- **Command:** `POLESTAR_GRID`/`POLESTAR_CAS` are set by the script:
  `node rust/tests/golden/nav-walks/regen.js <scratch js root> <out golden dir>`; copy
  `<out>/{nav-walks,nav-legs,nav-store}` here.
