//! `dungeons build` (dungeons.json) against the JavaScript's output on a synthetic DungeonJournal
//! and the data golden: rust/tests/golden/dungeons (README there).

use crate::common;

#[test]
fn dungeons_match_golden() {
	let g = common::golden("dungeons");
	let (json, n, _) = forge_data::dungeons::run(Some(&g.join("input").join("ForeverDungeonJournal")), &common::golden("data").join("expected")).unwrap();
	assert_eq!(n, 2);
	let mut check = common::Check::new();
	check.file("dungeons.json", &json, &g.join("expected").join("dungeons.json"));
	check.finish("dungeons build");
}

fn fixture_dj() -> std::path::PathBuf {
	std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/fixtures/dungeonjournal/ForeverDungeonJournal")
}

fn dsl_data() -> std::path::PathBuf {
	std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../tests/fixtures/dsl/data")
}

fn s(v: &forge_guide::js::V) -> serde_json::Value {
	serde_json::from_str(&forge_guide::js::stringify(v, None)).unwrap()
}

/// The synthetic DungeonJournal (rust/tests/fixtures/dungeonjournal) over the compiler's fixture data:
/// the files load as the client runs them, dungeons, bosses and quests with their positions by
/// precedence, money and names read from the text, and dungeons.json staying out of the compiler.
#[test]
fn the_synthetic_journal_dungeons_bosses_quests_and_positions_by_precedence() {
	use forge_data::dungeons::*;
	use serde_json::json;
	let dir = fixture_dj();
	let raw = load_dungeon_journal(&dir).unwrap();
	assert_eq!(s(&raw.get("ORDER")), json!(["The Test Mine"]));
	assert_eq!(s(&raw.get("FOREVER_QUEST_XP_FALLBACK").get("990002")), json!(900), "QuestUpdates.lua patches the tables earlier files made");
	assert_eq!(s(&raw.get("QUEST_SHAREABILITY_AUDIT").get("990001")), json!(true), "files using the global table see the same namespace");
	let toc = read_toc(&dir);
	assert_eq!(s(&forge_guide::js::V::Obj(toc.clone())), json!({ "interface": "16001", "title": "DungeonJournal", "author": "Fixture", "version": "0.0.1" }));
	assert_eq!(find_dungeon_journal(Some(&dir)), Some(dir.clone()));
	assert_eq!(find_dungeon_journal(Some(&dir.join("missing"))), None);

	let data = forge_guide::data::load_data(&dsl_data()).unwrap();
	let (dataset, report) = build_dungeons(&raw, &data, &toc);
	let ds = s(&dataset);
	assert_eq!((&ds["source"]["name"], &ds["source"]["version"]), (&json!("DungeonJournal"), &json!("0.0.1")));
	let d = &ds["dungeons"][0];
	assert_eq!(
		(&d["key"], &d["levels"], &d["entrance"], &d["zoneName"], &d["factions"]),
		(&json!("test-mine"), &json!({ "min": 5, "max": 10 }), &json!({ "map": 1429, "x": 50, "y": 50, "f": "l" }), &json!("Elwynn Forest"), &json!(["Alliance", "Horde"]))
	);
	let bosses: Vec<serde_json::Value> = d["bosses"].as_array().unwrap().iter().map(|b| json!([b["name"], b["npc"], b["level"], b["rare"]])).collect();
	assert_eq!(bosses, vec![json!(["Gnasher", 990100, 7, false]), json!(["Tunnel Rat", null, null, true]), json!(["Foreman Grub", 990101, { "min": 9, "max": 10 }, false])], "kill order, no trash");
	assert_eq!(d["bosses"][0]["loot"], json!([{ "item": 990030, "name": "Gnasher's Tooth", "slot": "Neck", "quality": 2 }]));
	let q: std::collections::BTreeMap<String, serde_json::Value> = d["quests"].as_array().unwrap().iter().map(|x| (x["id"].to_string(), x.clone())).collect();
	assert_eq!(q["7"]["start"], json!({ "map": 1429, "x": 48.92, "y": 41.61, "f": "e", "source": "data", "kind": "npc", "id": 197, "name": "Marshal McBride" }), "our data wins");
	assert_eq!((&q["7"]["xp"], &q["7"]["xpSource"], &q["7"]["money"], &q["7"]["chain"]), (&json!(250), &json!("data"), &json!(150), &json!([783])));
	assert_eq!(q["7"]["rewards"], json!({ "items": [], "choices": [{ "item": 159, "name": "Refreshing Spring Water", "quality": 1 }, { "item": 750, "name": "Tough Wolf Meat", "quality": 2 }] }));
	let g = &q["990001"];
	assert_eq!((&g["start"]["source"], &g["start"]["inDungeon"], &g["faction"]), (&json!("entrance"), &json!(true), &serde_json::Value::Null), "a giver inside stands at the entrance");
	assert_eq!((&g["xp"], &g["money"], &g["bosses"]), (&json!(1100), &json!(700), &json!(["Foreman Grub"])));
	assert_eq!((&q["990002"]["startBoss"], &q["990002"]["startItem"]), (&json!("Foreman Grub"), &json!({ "item": 990020, "name": "Rusty Pick" })));
	assert_eq!(q["990002"]["end"], json!({ "map": 1429, "x": 42, "y": 65, "f": "l", "source": "dj", "kind": "npc", "name": "Old Miner" }));
	assert_eq!(q["990003"]["chain"], json!([783]), "the quest itself is not part of its chain");
	assert_eq!(q["990005"]["hidden"], json!(true));
	assert!(report.unresolved.is_empty());
	assert_eq!(["data", "dj", "entrance"].iter().map(|k| report.coverage.get(*k).copied().unwrap_or(0.0)).sum::<f64>(), 14.0);

	// Money and NPC names from the text.
	use forge_guide::js::V;
	assert_eq!(s(&parse_money(&V::str("1g 50s  •  Ironforge +100"))), json!(15000));
	assert_eq!(s(&parse_money(&V::str("Choose: A or B\n3,570 XP • 7s • Gadgetzan +100"))), json!(700));
	assert_eq!(s(&parse_money(&V::str("Ironforge +100"))), serde_json::Value::Null);
	assert_eq!(npc_name_of(&V::str("Nalpak, above the entrance to Wailing Caverns, The Barrens")).as_deref(), Some("Nalpak"));
	assert_eq!(npc_name_of(&V::str("Item start: Abominable Head, inside Ruins of Lordaeron")), None);
	assert!(says_inside(&V::str("Captain Truman, just inside Ruins of Lordaeron"), "Ruins of Lordaeron"));
	assert!(says_inside(&V::str("Vorrel Sengutz, inside the Graveyard"), "Scarlet Monastery: Graveyard"));
	assert!(!says_inside(&V::str("Thrall, Valley of Wisdom, Orgrimmar"), "Ragefire Chasm"));

	// The compiler reads nothing from dungeons.json; rebuilding with it gives the same dataset.
	let with = crate::common::scratch("dungeons-data");
	crate::common::copy_tree(&dsl_data(), &with);
	std::fs::write(with.join("dungeons.json"), forge_guide::js::stringify(&dataset, None)).unwrap();
	let data2 = forge_guide::data::load_data(&with).unwrap();
	assert!(!data2.quest(&V::Num(990001.0)).truthy(), "a quest only the journal knows is not in the compiler's data");
	assert_eq!(s(&build_dungeons(&raw, &data2, &toc).0), ds);
}
