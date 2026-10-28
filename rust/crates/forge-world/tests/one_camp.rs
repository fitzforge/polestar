//! A quest's kill work goes to one camp when one camp has every target (Sharing the Land, 745: its
//! Tanners and Skinners were placed south of Bloodhoof and its Poachers at Palemane Rock 900 yd away,
//! while Palemane Rock has all three).

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

fn build(rats_at_fox_camp: bool) -> Vec<forge_world::world::Task> {
	let dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/synthetic/base");
	let mut files: HashMap<String, Vec<u8>> = HashMap::new();
	for e in std::fs::read_dir(&dir).unwrap().flatten() {
		files.insert(e.file_name().to_string_lossy().into_owned(), std::fs::read(e.path()).unwrap());
	}
	// Quest 501 kills Burrow Rats (their big camp at 22,22) and Pelt Foxes (77,77).
	let mut quests: serde_json::Value = serde_json::from_slice(&files["quests.json"]).unwrap();
	quests["501"]["objectives"] = serde_json::json!([{ "type": "kill", "id": 10, "count": 8 }, { "type": "kill", "id": 11, "count": 4 }]);
	files.insert("quests.json".into(), serde_json::to_vec(&quests).unwrap());
	if rats_at_fox_camp {
		let mut npcs: serde_json::Value = serde_json::from_slice(&files["npcs.json"]).unwrap();
		let pts = npcs["10"]["spawns"]["99101"]["pts"].as_array_mut().unwrap();
		pts.extend([[76.0, 76.0], [77.0, 76.0], [76.0, 77.0], [77.0, 77.0]].iter().map(|p| serde_json::json!(p)));
		files.insert("npcs.json".into(), serde_json::to_vec(&npcs).unwrap());
	}
	let d = GameData::from_source(&Mem(files)).expect("data");
	let (w, _) = build_world(&d, &BuildOptions::new(Faction::Horde), &NoFloors).expect("build");
	w.quests.iter().find(|q| q.id == 501).expect("quest 501").tasks.clone()
}

#[test]
fn kill_work_goes_to_the_camp_with_every_target() {
	let kills = |t: &forge_world::world::Task| t.work.iter().filter(|w| matches!(w, Work::Kill { .. })).count();
	let apart = build(false);
	assert_eq!(apart.len(), 2, "no camp has both: each at its own");
	let one = build(true);
	assert_eq!(one.len(), 1, "the fox camp has rats too: one camp");
	assert_eq!(kills(&one[0]), 2);
	let rat_camp = apart.iter().find(|t| t.work.iter().any(|w| matches!(w, Work::Kill { npc: 10, .. }))).unwrap().pt;
	assert_ne!(one[0].pt, rat_camp, "at the fox camp, not the rats' own");
}
