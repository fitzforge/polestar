//! A quest item found only inside another item is worked where that container drops (#619:
//! Tallonkai's Jewel inside the Gnarlpine Necklace Ferocitas drops was placed at the quest's giver
//! in Dolanaar).

use forge_core::Faction;
use forge_world::data::{GameData, Source};
use forge_world::{build_world, BuildOptions, NoFloors};
use std::collections::HashMap;
use std::path::PathBuf;

struct Mem(HashMap<String, Vec<u8>>);

impl Source for Mem {
	fn read(&self, root: &str, name: &str) -> Option<Vec<u8>> {
		(root == "data").then(|| self.0.get(name).cloned()).flatten()
	}
}

#[test]
fn an_item_found_inside_another_is_worked_where_the_container_drops() {
	let dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/synthetic/base");
	let mut files: HashMap<String, Vec<u8>> = HashMap::new();
	for e in std::fs::read_dir(&dir).unwrap().flatten() {
		files.insert(e.file_name().to_string_lossy().into_owned(), std::fs::read(e.path()).unwrap());
	}
	// Quest 502 collects Fox Pelts (item 100, dropped by npc 11); a Fox Charm (101) found only
	// inside the pelt replaces them.
	let mut items: serde_json::Value = serde_json::from_slice(&files["items.json"]).unwrap();
	items["101"] = serde_json::json!({ "id": 101, "name": "Fox Charm", "drops": { "npc": {}, "object": {} }, "vendors": [], "questItem": true, "containers": [100] });
	files.insert("items.json".into(), serde_json::to_vec(&items).unwrap());
	let mut quests: serde_json::Value = serde_json::from_slice(&files["quests.json"]).unwrap();
	quests["502"]["objectives"] = serde_json::json!([{ "type": "item", "id": 101, "count": 1 }]);
	files.insert("quests.json".into(), serde_json::to_vec(&quests).unwrap());
	let d = GameData::from_source(&Mem(files.clone())).expect("data");
	let (w, _) = build_world(&d, &BuildOptions::new(Faction::Horde), &NoFloors).expect("build");
	let q = w.quests.iter().find(|q| q.id == 502).expect("quest 502 in the world");
	let t = &q.tasks[0];
	// Where the pelt's dropper is: the original world's kill site for 502.
	let pelt = {
		let d0 = GameData::from_source(&Mem({
			let mut f = files;
			f.insert("items.json".into(), std::fs::read(dir.join("items.json")).unwrap());
			f.insert("quests.json".into(), std::fs::read(dir.join("quests.json")).unwrap());
			f
		}))
		.unwrap();
		let (w0, _) = build_world(&d0, &BuildOptions::new(Faction::Horde), &NoFloors).unwrap();
		w0.quests.iter().find(|q| q.id == 502).unwrap().tasks[0].pt
	};
	assert_ne!(t.pt, q.giver, "not at the giver");
	assert_eq!(t.pt, pelt, "where the container drops");
}
