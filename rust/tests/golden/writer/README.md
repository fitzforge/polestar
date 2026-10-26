# golden/writer

Inputs for `forge-writer/tests/{engine,travel_repair}.rs` (helper: `forge-writer/tests/common/mod.rs`). The tests play small guides on the shared data slice, `../world/root/data/forever` (README there), plus the files below. There is no JS reference for the writer's engine rules or its travel repair in this checkout, so the tests assert the rules' effects; they assert the same values as on the full data.

- `overlay.json`: merged into the slice's tables by the helper. An entry the slice lacks is added; otherwise the listed fields are set.
  - `quests.5481`, `npcs.10665`/`10666`, `objects.175566`, `items.12737` cover Gordo's Task and its Gloom Weed in Tirisfal Glades. They are copied verbatim from a public JS data build (pfQuest, MIT): the one `../world/README.md` describes, made with `--no-questie --no-web-zones --no-web-xp`.
  - `quests.1166.web = { type: 1 }` is synthetic. It marks the quest as a group quest; the slice has no web zone list data.
- `mechanics/quest-mechanics.json`, `mechanics/quest-steps.json`: synthetic. They hold only the fields the engine reads, for quests 882 (summon by item 10338 at The Dead Tree, 60.0,30.2 in the Barrens) and 2458 (an emote at Taskmaster Fizzule).
- `travel.json` (travel_repair only; it replaces the slice's travel.json): a whole-world travel build. Made with this checkout's JS (rust-retire, a8f669093) on the same public data build:
  `node tools/polestar.js travel build --offline --data <public forever-full> --recordings data/recordings --sources <wago + cmangos only> --shipped tools/lib/travel/crossings.json --crossings <absent file> --grid none --json travel.json`
  Sources: Blizzard client tables (wago.tools), CMaNGOS classic-db (GPL facts), pfQuest npcs/objects (MIT), Polestar's recordings and crossings (Carbonite zone crossings, GPL-3.0). Not read: QuestieDB, ForeverDB, the web zone lists or the walking grid.

Local mode (optional): with `POLESTAR_V1=<checkout with built data/forever and data/local/mechanics>`, the tests play on that checkout's full data instead.
