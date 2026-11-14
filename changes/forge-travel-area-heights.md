---
section: forge
---
- `data/crossings.json` areas take an optional height range (`"z":
  { "min", "max" }`): a place only the portals that land in it reach,
  under or over other ground on its map, which the walking maps have no
  floor in. `travel build` (forge and the Node toolchain) validates it
  and writes it to TravelData.lua (`zmin`, `zmax`) and travel.json. The
  Wizard's Sanctum's chamber is the first (#1970); its portals' ends keep
  their own name, no AreaTable area naming the Sanctum.
