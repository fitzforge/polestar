//! The routes stage on the golden slice worlds: a repository-shaped root over the golden data slice
//! with an empty knowledge base, a sim dir with the golden worlds and empty walk tables, and three
//! starts (the Horde as a shared route of Orc and Troll on v1's Orc chain, the Alliance as Human's own
//! cut).

use forge_core::Faction;
use forge_sim::stage::StartIn;
use std::path::{Path, PathBuf};

/// A walks .bin with no pairs, on the world `data_hash` (the binary layout WalkTable::from_bin reads).
pub fn empty_walks(data_hash: &str) -> Vec<u8> {
	let header = serde_json::json!({ "smooth": 0.965, "sections": {}, "dataHash": data_hash }).to_string();
	let mut b = Vec::new();
	b.extend_from_slice(&0x4e42_5350u32.to_le_bytes());
	b.extend_from_slice(&1u32.to_le_bytes());
	b.extend_from_slice(&(header.len() as u32).to_le_bytes());
	b.extend_from_slice(header.as_bytes());
	b
}

/// A repository-shaped root over the golden data slice with an empty knowledge base, and the sim dir.
pub fn inputs(dir: &Path) -> (PathBuf, PathBuf) {
	let root = dir.join("root");
	let golden_root = super::golden().join("world/root/data");
	std::fs::create_dir_all(root.join("data/local/kb")).unwrap();
	for f in ["forever", "sources", "rules.json"] {
		std::os::unix::fs::symlink(golden_root.join(f), root.join("data").join(f)).unwrap();
	}
	let kb = rusqlite::Connection::open(root.join("data/local/kb/forever-kb.sqlite")).unwrap();
	kb.execute_batch(
		"create table facts (kind text, id integer, field text, value text, source text, confidence text, agree integer, total integer);
		 create table verify_in_game (kind text, id integer, conflicts text);
		 create table mechanics (quest integer, kind text, confidence text, sources text, drives integer);",
	)
	.unwrap();
	let sim = dir.join("sim");
	std::fs::create_dir_all(&sim).unwrap();
	for f in Faction::BOTH {
		let bytes = super::gunzip(&super::golden().join(format!("world/expected/world-{}.json.gz", f.lower())));
		let w = forge_world::World::from_json(&bytes).unwrap();
		std::fs::write(sim.join(format!("world-{}.json", f.lower())), &bytes).unwrap();
		std::fs::write(sim.join(format!("walks-{}.bin", f.lower())), empty_walks(w.data_hash.as_deref().unwrap_or(""))).unwrap();
	}
	std::fs::copy(super::golden().join("sim/params.json"), sim.join("params.json")).unwrap();
	(root, sim)
}

pub fn starts() -> Vec<StartIn> {
	let orc = super::seed_doc(Faction::Horde, "orc");
	let human = super::seed_doc(Faction::Alliance, "human");
	let s = |race: &str, faction, goals: &serde_json::Value| StartIn {
		race: race.into(),
		faction,
		name: race.into(),
		goals: serde_json::json!({ "goals": goals["goals"] }),
		seed_name: "golden v1 chain".into(),
	};
	vec![s("Orc", Faction::Horde, &orc), s("Troll", Faction::Horde, &orc), s("Human", Faction::Alliance, &human)]
}

/// Every file the stage wrote (relative path -> bytes), the search's wall time taken out of the routes.
pub fn outputs(out: &Path, files: &[PathBuf]) -> Vec<(String, Vec<u8>)> {
	let mut v: Vec<(String, Vec<u8>)> = files
		.iter()
		.map(|f| {
			let rel = f.strip_prefix(out).unwrap().to_string_lossy().into_owned();
			let mut bytes = std::fs::read(f).unwrap();
			// A route (`<name>.json`, own cuts under own/): its search numbers carry wall time.
			let name = f.file_name().unwrap().to_string_lossy().into_owned();
			if name.ends_with(".json") && name.matches('.').count() == 1 {
				let mut doc: serde_json::Value = serde_json::from_slice(&bytes).unwrap();
				if let Some(s) = doc.get_mut("search").and_then(|s| s.as_object_mut()) {
					for k in ["seconds", "evaluationsPerSecond", "triesPerSecond"] {
						s.remove(k);
					}
				}
				bytes = serde_json::to_vec_pretty(&doc).unwrap();
			}
			(rel, bytes)
		})
		.collect();
	v.sort();
	v
}
