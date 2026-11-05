# nav-layers: the JS ground layers on synthetic inputs

Read by `forge-navbuild/tests/roads.rs` (the roads layer and its allowlist) and `forge-nav/tests/pack/hubs.rs`
(the hubs layer): `forge nav layers roads|hubs` must give these files byte for byte.

- **Inputs (synthetic; licence: the repository's):**
  - `roads-in/sources/casc/synthetic/1.60.0.99999/<fdid>.blp`: two continents' WDTs (map 0 with big alpha, map 1
    with 4-bit alpha), root ADTs (MCNK flags, half of map 1's chunks needing the 4-bit fix) and tex0 ADTs whose
    layers paint a road (RLE and raw alpha maps), a one-column dirt strip, a dirt patch, a cobble square, a
    reviewed rock strip, a rock patch, a road base; a tile with no tex0. `roads-in/sources/wago/.../Map.csv`
    (the WDTs' ids), `roads-in/sources/listfile/community-listfile.csv` (the textures' paths, synthetic
    lines), `roads-in/road-textures.json` (our allowlist, data/road-textures.json, as the JS read it).
  - `hubs-in/`: spawns (spawnz.json's npc shape), creature templates (creature_template.json's shape) and a
    FactionTemplate table (players, two towns, a goblin town, enemy and friend entries, monsters); the areas,
    zones and map frames of `../nav-pack/data` and the grid of `../nav-grid/nav4`.
  No client file, no game data.
- **Outputs (the JS's):** `roads-out/roads/` (tools/lib/nav/layers/roads.js buildRoads: the tiles' weights and
  index.json), `roads-out/road-textures.json` (roadAllowlist's document as `nav layers roads --allowlist`
  wrote it), `hubs.json` (hubs.js buildHubs as `nav layers hubs` wrote it).
- **JS:** tools/lib/nav/layers of this branch at d1a565942.
- **Command:** `node rust/tests/golden/nav-layers/regen.js <js root> rust/tests/golden/nav-layers`, `<js root>` a
  checkout of that commit.

Real data, checked by hand on 2026-10-23: `forge nav layers hubs` on the 1.60.1.70425 grid and the pinned
classic-db dump gave the JS's hubs.json byte for byte (and its creature_template.json extract). The roads
layer's real run reads the installed client and the community listfile; its parity rests on this golden.
