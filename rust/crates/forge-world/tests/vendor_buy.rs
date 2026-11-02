//! A quest item a friendly vendor sells near the giver is bought there, not farmed from a rare drop
//! (RevA1, c13: Look to the Stars' Bronze Tube was placed as a 1.9 % drop in Stonetalon while
//! Herble sells it beside Viktori in Darkshire).

use forge_core::Faction;
use forge_world::data::{GameData, Source};
use forge_world::world::Work;
use forge_world::{build_world, BuildOptions, NoFloors};
use std::collections::HashMap;
use std::path::PathBuf;

struct Mem(HashMap<String, Vec<u8>>);

impl Source for Mem {
	fn read(&self, root: &str, name: &str) -> Option<Vec<u8>> {
		(root == "data").then(|| self.0.get(name).cloned()).flatten()
	}
}

fn base() -> HashMap<String, Vec<u8>> {
	let dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/synthetic/base");
	let mut files: HashMap<String, Vec<u8>> = HashMap::new();
	for e in std::fs::read_dir(&dir).unwrap().flatten() {
		files.insert(e.file_name().to_string_lossy().into_owned(), std::fs::read(e.path()).unwrap());
	}
	files
}

/// Quest 502's Fox Pelt (item 100) with the given drop chance from the Pelt Fox (npc 11, at 75-80 %
/// of the zone; the giver at 50,50), sold by a friendly vendor (npc 3) at `at`.
fn work_of_502(chance: f64, at: [f64; 2]) -> (Vec<Work>, u32, u32) {
	let mut files = base();
	let mut items: serde_json::Value = serde_json::from_slice(&files["items.json"]).unwrap();
	items["100"] = serde_json::json!({ "id": 100, "name": "Fox Pelt", "drops": { "npc": { "11": chance }, "object": {} }, "vendors": [3] });
	files.insert("items.json".into(), serde_json::to_vec(&items).unwrap());
	let mut npcs: serde_json::Value = serde_json::from_slice(&files["npcs.json"]).unwrap();
	npcs["3"] = serde_json::json!({ "id": 3, "name": "Pelt Trader", "level": 20, "faction": "AH", "spawns": { "99101": { "f": "e", "pts": [at] } } });
	files.insert("npcs.json".into(), serde_json::to_vec(&npcs).unwrap());
	let d = GameData::from_source(&Mem(files)).expect("data");
	let (w, _) = build_world(&d, &BuildOptions::new(Faction::Horde), &NoFloors).expect("build");
	let q = w.quests.iter().find(|q| q.id == 502).expect("quest 502 in the world");
	(q.tasks[0].work.clone(), q.tasks[0].pt, q.giver)
}

#[test]
fn a_rare_drop_a_vendor_beside_the_giver_sells_is_bought_there() {
	let (work, pt, giver) = work_of_502(2.0, [52.0, 50.0]);
	assert_eq!(work, vec![Work::Buy], "bought, not farmed at 2 %");
	assert_ne!(pt, giver, "at the vendor's spot, not the giver's");
}

#[test]
fn a_sure_drop_nearer_than_the_vendor_is_still_farmed() {
	let (work, _, _) = work_of_502(100.0, [95.0, 95.0]);
	assert!(matches!(work.as_slice(), [Work::Kill { .. }]), "{work:?}");
}
