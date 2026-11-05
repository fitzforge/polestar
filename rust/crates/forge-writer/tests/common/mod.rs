//! The reference data the writer tests play on. By default the committed goldens: the shared data slice
//! (rust/tests/golden/world/root/data/forever) with the writer golden's synthetic overlays and mechanics
//! and its public travel.json (rust/tests/golden/writer, README there). With $POLESTAR_V1 set to a
//! checkout with built data/forever (and data/local/mechanics), that checkout's full data instead.
#![allow(dead_code)]

use forge_guide::js::{parse_json, stringify};
use rustc_hash::FxHashMap;
use std::path::{Path, PathBuf};

pub struct Ref {
	pub data: forge_guide::data::Data,
	/// quest-mechanics.json `quests`.
	pub mech: Option<serde_json::Value>,
	/// quest-steps.json `quests`.
	pub steps: Option<serde_json::Value>,
}

pub fn golden(stage: &str) -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden").join(stage)
}

fn mechanics(dir: &Path) -> (Option<serde_json::Value>, Option<serde_json::Value>) {
	let read = |f: &str| std::fs::read(dir.join(f)).ok().and_then(|b| serde_json::from_slice::<serde_json::Value>(&b).ok()).and_then(|v| v.get("quests").cloned());
	(read("quest-mechanics.json"), read("quest-steps.json"))
}

/// The full data of $POLESTAR_V1 (optional local mode), when set and built.
fn full() -> Option<Ref> {
	let root = PathBuf::from(std::env::var_os("POLESTAR_V1")?);
	if !root.join("data/forever/quests.json").exists() {
		eprintln!("POLESTAR_V1 has no data/forever/quests.json: reading the goldens");
		return None;
	}
	let data = forge_guide::data::load_data(&root.join("data/forever")).expect("POLESTAR_V1 data/forever");
	let (mech, steps) = mechanics(&root.join("data/local/mechanics"));
	Some(Ref { data, mech, steps })
}

/// The golden: the data slice's files with the writer golden's overlay.json merged in (per table and id:
/// an entry the slice lacks is added, else its fields are set), `travel` replaced by `travel` (a file of
/// the writer golden) when given.
fn slice(travel: Option<&str>) -> Ref {
	let dir = golden("world/root/data/forever");
	let w = golden("writer");
	let mut texts = FxHashMap::default();
	for name in forge_guide::data::FILES.iter().chain(forge_guide::data::OPTIONAL.iter()) {
		if let Ok(t) = std::fs::read_to_string(dir.join(format!("{name}.json"))) {
			texts.insert(name.to_string(), t);
		}
	}
	let overlay = parse_json(&std::fs::read_to_string(w.join("overlay.json")).unwrap()).expect("overlay.json");
	for (table, entries) in overlay.entries() {
		let t = parse_json(&texts[table.as_ref()]).unwrap();
		for (id, fields) in entries.entries() {
			let e = t.get(&id);
			if e.truthy() {
				for (k, v) in fields.entries() {
					e.set(&k, v);
				}
			} else {
				t.set(&id, fields);
			}
		}
		texts.insert(table.to_string(), stringify(&t, None));
	}
	if let Some(f) = travel {
		texts.insert("travel".into(), std::fs::read_to_string(w.join(f)).unwrap());
	}
	let sources = dir.join("../sources");
	let data = forge_guide::data::Data::from_texts(&texts, forge_guide::solo::load_instances(&sources), forge_guide::areas::load_areas(&sources), Some(dir.to_string_lossy().into_owned()))
		.expect("slice data");
	let (mech, steps) = mechanics(&w.join("mechanics"));
	Ref { data, mech, steps }
}

/// The data the engine tests play on ($POLESTAR_V1's, else the golden slice with its own travel).
pub fn engine_ref() -> Ref {
	full().unwrap_or_else(|| slice(None))
}

/// The data the travel repair plays on ($POLESTAR_V1's, else the golden slice with the writer
/// golden's whole-world travel.json: the repair crosses zones and seas the slice does not hold).
pub fn travel_ref() -> Ref {
	full().unwrap_or_else(|| slice(Some("travel.json")))
}
