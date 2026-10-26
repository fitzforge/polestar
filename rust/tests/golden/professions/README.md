# profession build golden

JS: this checkout's tools/ (rust-retire, a8f669093).
Command: `sh regen.sh <this checkout>`. It runs `profession build --offline --data <tmp> --sources input/sources --out professions.json` with cwd `expected/`. `<tmp>` holds input/data/items.json plus the world slice's npcs.json and objects.json.

Inputs. `node slice.js <data/sources> <public data/forever> input` cut them. The professions kept are First Aid 129, Alchemy 171, Cooking 185 and Mining 186; the other skill lines keep only their SkillLine row.
- `sources/wago/1.60.1.70450`, `sources/wago/1.15.9.70003`: Blizzard client table rows (wago.tools CSVs, verbatim).
  - SkillLine and SpellFocusObject are whole.
  - SkillLineAbility keeps only the four professions' rows.
  - The spell tables keep the rows of their spells and of the spells that teach them.
  - ItemSparse and Item keep the items those recipes make or need, the tools of their tool categories, and the recipe items.
  - ItemEffect and ItemXItemEffect keep the rows for those recipe items.
- `data/items.json`: those items from a public JS data build (pfQuest, MIT, plus client tables; built `--no-questie --no-web-zones --no-web-xp`, see ../world/README.md). Each item's vendors and drops are cut to the world slice's npcs and objects. The test and regen.sh pair it with `../world/root/data/forever/{npcs,objects}.json`, so the slice's zones are the vendor and trainer zones.
- `sources/pfQuest/db/items.lua`: pfQuest (MIT, shagu/pfQuest; LICENSE kept). It has the entries for those items, each cut to its vendor block (the stock limits), lines verbatim.

expected/: `professions.json`, `report.txt` (stdout) and `warnings.txt` (the `warning:` lines from stderr).

Test: rust/crates/forge-data/tests/professions.rs. It compares professions.json, the report and the warnings byte for byte. Regenerate only when the JS is the reference; CI never runs the generator.
