# Repacking the walking maps

The walking maps the arrow uses (`addon/Polestar_Nav`, `addon/Polestar_Nav_EK`, `addon/Polestar_Nav_Kalimdor`) are
more than one `forge nav pack`. One command makes them from their inputs, and checks that it still does:

```sh
tools/nav/repack.sh            # repack into addon/: the maps, PACK.json, the two pins it moved (with --move-pins)
tools/nav/repack.sh --check    # repack into a scratch folder and check it against addon/ byte for byte
```

Both take a few minutes and as much memory as `forge nav pack --leffe` (run them as a heavy job). The script builds
`forge` and forge-nav's `occupied_floor` example from the checkout first (cargo, profile `quick`).

## The steps

1. **`forge nav pack --leffe`** ([docs/forge/nav.md](../forge/nav.md), "The walking maps"): the checkout's forge
   with its grid joins and cuts (`rust/crates/forge-nav/src/pack/joins.json`, compiled in), on the grid, the ground
   layers, Leffe's navigation maps and the data build below, at the cells and date of the checkout's `PACK.json`
   (`--date` for a repack with new inputs).
2. **The graft** (`tools/lib/nav/repack.js graft`): 0.4.2's shipped maps carry layers a plain pack does not make:
   the detail lanes (`detailLanes`, walking corridors) at the end of `Nav0.lua` and `Nav1.lua`, the rope bridges in
   `Chokepoints.lua`, and the ground pages of local walks at the end of each map's first part. Each layer goes
   after the same file of the new pack; a file the new pack left as the plain pack under 0.4.2's had it keeps
   0.4.2's whole. A file the new pack changed whose 0.4.2 copy is not the plain one with a layer appended stops the
   graft. The three ground sidecars (`TerminalGround.lua`) come along. The manifest's sha256 of each grafted file
   is replaced in place and the manifest written with two-space indents, as 0.4.2's was.
3. **The Ironforge cluster rebuild** (`rust/crates/forge-nav/examples/occupied_floor.rs`): takes out the occupied
   floor at the city's centre and the obstructed signpost, ramp and street steps. Its `SOURCE` pins the sha256 of
   step 2's `PACK.json`.
4. **The regional import** (`tools/lib/nav/import-regions.js`; `addon/Polestar_Nav/CREDITS.md`, "Reproducing the
   regional 70532 import"): the pages as regions in each continent's part. Its `inputManifest` pins the sha256 of
   step 3's `PACK.json`, and its `terminal` the sidecars'.
5. **The record** (`tools/lib/nav/repack.js record`): `PACK.json`'s `repack` holds the sha256 of each step's
   manifest (`packManifestSha256`, `derivedManifestSha256` = step 3's pin, `rebuiltManifestSha256` = step 4's), of
   0.4.2's maps and the plain pack under them (`graft`), and of the inputs (`inputs`, by role: Leffe's `PACK.json`,
   the grid's `index.json` and sidecars, the ground layers' `hubs.json` and roads index, the data files the pack
   reads, the AreaTable by build, `data/crossings.json` and `joins.json`). The grid's tiles are not hashed: its
   `index.json` (`builtAt`) names the build.

Then `forge nav check` checks every file against `PACK.json`, and the script lists any file in the maps' folders
that `PACK.json` does not (a region a new pack no longer writes: remove it with the repack's commit).

## The inputs

The paths are private (Leffe's map files never go into the repository, and the rest are local builds). The script
reads them from an env file outside the checkout: `$POLESTAR_REPACK_ENV`, else
`~/.config/polestar/nav-repack.env`. The maintainer's notes (the local `AGENTS.md`, its "Walking-maps repack"
line) say where each one is kept.

| Variable | What |
|---|---|
| `NAV_GRID` | The navigation grid (format 4, client build 70532: the tiles of the legs bake's grid) with the walk graphs `forge nav prepare` builds, which the grid joins are routed on |
| `NAV_LEFFE` | Leffe's navigation maps (his format-4 `Nav` folder or the folder holding it): the maps of the legs bake |
| `NAV_LAYERS` | The ground layers (`forge nav layers`: `roads/` and `hubs.json`) |
| `NAV_DATA` | The data build the maps are packed with: `forever/` (zones, map frames, travel, spawns) and `sources/wago/<build>/AreaTable.csv` |
| `NAV_GRAFT_BASE` | 0.4.2's shipped maps with their layers and ground sidecars (`Polestar_Nav`, `Polestar_Nav_EK`, `Polestar_Nav_Kalimdor`) |
| `NAV_GRAFT_PLAIN` | The plain `forge nav pack` those were made from (the same three folders) |

```sh
# nav-repack.env (sourced by bash)
NAV_GRID=...
NAV_LEFFE=...
NAV_LAYERS=...
NAV_DATA=...
NAV_GRAFT_BASE=...
NAV_GRAFT_PLAIN=...
```

## When the inputs change

New grid joins (or a new grid, layers or data build) change step 1's maps, so step 2's and step 3's manifests are no
longer the ones steps 3 and 4 pin: the repack stops there and names both hashes. Check the new maps (the joins'
lines in the pack log, `forge nav check`, the walks they were added for), then run `tools/nav/repack.sh --move-pins`:
it moves `SOURCE` in `occupied_floor.rs` and `inputManifest` in `import-regions.js`, rebuilds the example, and
writes the maps into `addon/`. The rebuild still asserts the Ironforge cluster and cells it changes, so a pack that
moved them stops it. Commit the maps, `PACK.json` and the two pins together.

## The check

`tools/nav/repack.sh --check` repacks into a scratch folder and checks every file `PACK.json` lists, and
`PACK.json` itself, against the checkout's maps; any file that differs or is missing, and any file in the maps'
folders `PACK.json` does not list, fails it (exit 1, the files named). With `--work <dir>` the steps' folders stay
for a look; `--pack <dir>` starts from a plain pack already made from the same inputs.

`tests/nav-repack.test.js` tests the graft and the check on small packs everywhere, and runs `--check` on the
checkout when `POLESTAR_REPACK_ENV` names the inputs file. It is skipped otherwise, so a test run that does not ask
for it (CI included) never starts the pack.
