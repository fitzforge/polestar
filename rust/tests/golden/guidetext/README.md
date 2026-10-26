# golden/guidetext

References for `forge-judge/tests/guidetext_parity.rs`.

- `<case>.json.gz`: the dumps that `forge-judge/tests/js/guidetext-dump.js` makes: guidetext.js `scoreTarget`'s result, its goals with the levels of its sim replay, and the sim view it read.
  - `shipped-orc` (`polestar:Horde:Orc`) and `shipped-human` (`polestar:Alliance:Human`): the default chains of the guide slice (`../guide/slice`).
  - `dir-orc` (`file:<slice>/forever/horde/orc-troll:Horde:Orc`): a guide folder as the target, its guides in id order (the code path of a written v2 pack).
  - Inputs: the guide slice and the data slice (`../world/root/data/forever`, sources `../world/root/data/sources`). The sim dir is the golden slice worlds (`../world/expected`) with `../sim/params.json`. There is no consensus export (`simConsensus` is null), no walks and no walking grid.
  - File names are relative to the guide slice's parent (`slice/forever/...`).
- The JS: guidetext.js exists only on the v2-guidetext branch (`tools/lib/judge/guidetext.js` @ 4b76ba03a). It was copied into a scratch copy of this checkout's `tools/` (rust-retire @ a8f669093, which has the judge's frameless-goal fix 734380d2a) plus `tests/helpers`, so its requires resolve to this checkout's modules. The copy got that same fix in its own `wpt` (used for goals and spawn points): `proj.point(map, x, y, f || 'e')` became `proj.point(map, x, y, f === 'e' ? 'e' : 'l')`. A goal or spawn with no frame is live, as in forge-judge.
- Regenerate (not run in CI), from the repo root: `node rust/tests/golden/guidetext/regen.js <scratch>/tools/lib/judge/guidetext.js`.

Not CI-provable: the consensus export comparison (`simConsensus`), because the slice has no `data/sim/export`. Also a pack written by the v2 route writer: the slice has none, so `dir-orc` covers the folder target with our own guides instead.
