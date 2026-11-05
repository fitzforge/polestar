# travel build golden

JS: a checkout of next at eb7b47840 (next pipeline).
Command: `sh regen.sh $POLESTAR_V1` (`travel build --offline --grid none`, data ../data/expected, everything else from input/).
Inputs (`node slice.js <data/sources> input` plus hand-written files):
- sources/wago: Blizzard client table rows: Era TaxiNodes/AreaTrigger whole, TaxiPath/TaxiPathNode for 7 flight masters; Forever TaxiNodes, TaxiPathNode (those paths + Forever-only), TransportAnimation, SpellCastTimes, teleport spells' rows, AreaTable cut.
- sources/cmangos/22b51464f162/transit.json: CMaNGOS classic-db (GPL facts) cached extract, whole.
- crossings.json: data/crossings.json (ours); local/crossings.json and recordings/: synthetic (ours).
- package.json: version 0.2.6 = the JS checkout's (Polestar_Travel TOC).

When the shipped crossings file moved out of tools/ to data/crossings.json, expected/travel.json's Carbonite source `use` (which names that path) was updated by hand to the new path, in the Rust and the JS builders alike; nothing else changed.

When the Rust builder's inn list gained Zephras Isle's two inns (Shen'dar Village, Valanaar; 2026-10-27), expected/travel.json's warnings gained their two "not in npcs.json" lines by hand (the slice has neither innkeeper); nothing else changed.

Test: rust/crates/forge-data/tests/travel.rs (byte compare of every file in expected/). Regenerate only when the JS is the reference; CI never runs the generator.
