//! Every guide id Polestar's own packs have shipped stays reachable (#3924): guides/ids.json lists every id a
//! release of guides/ or experimental/ shipped (derived from the release tags) and every id they have now. Each
//! one is a guide of the packs or in a retired.json, so a character's saved tab of it opens the guide it became
//! (Guides.Successor) instead of waiting as a tab of a guide no part has. A new guide's id is added to the list;
//! a retired entry's `to` is a guide the packs have.

use crate::common::repo;
use serde_json::Value;
use std::collections::BTreeSet;
use std::path::Path;

const PACKS: [&str; 2] = ["guides", "experimental"];

/// The `guide <id>` of every .guide file under `dir` (translations under locales/ are not guides).
fn guide_ids(dir: &Path, out: &mut BTreeSet<String>) {
	let Ok(rd) = std::fs::read_dir(dir) else { return };
	for e in rd.flatten() {
		let p = e.path();
		if p.is_dir() {
			if e.file_name() != "locales" {
				guide_ids(&p, out);
			}
		} else if p.extension().is_some_and(|x| x == "guide") {
			let text = std::fs::read_to_string(&p).unwrap();
			let id = text.lines().find_map(|l| l.strip_prefix("guide ")).unwrap_or_else(|| panic!("{}: no `guide <id>` line", p.display()));
			out.insert(id.trim().to_string());
		}
	}
}

/// Each pack's retired.json as (id, to).
fn retired() -> Vec<(String, Option<String>)> {
	let mut out = Vec::new();
	for pack in PACKS {
		let file = repo().join(pack).join("retired.json");
		let Ok(text) = std::fs::read_to_string(&file) else { continue };
		let list: Vec<Value> = serde_json::from_str(&text).unwrap_or_else(|e| panic!("{}: {e}", file.display()));
		for e in list {
			match &e {
				Value::String(id) => out.push((id.clone(), None)),
				_ => out.push((e["id"].as_str().unwrap().to_string(), e["to"].as_str().map(str::to_string))),
			}
		}
	}
	out
}

#[test]
fn every_guide_id_a_release_shipped_is_a_guide_or_retired_3924() {
	let mut present = BTreeSet::new();
	for pack in PACKS {
		guide_ids(&repo().join(pack), &mut present);
	}
	assert!(present.len() > 200, "only {} guides found", present.len());
	let doc: Value = serde_json::from_str(&std::fs::read_to_string(repo().join("guides/ids.json")).unwrap()).unwrap();
	let known: BTreeSet<String> = doc["ids"].as_array().unwrap().iter().map(|v| v.as_str().unwrap().to_string()).collect();
	let retired = retired();
	let gone: BTreeSet<&str> = retired.iter().map(|(id, _)| id.as_str()).collect();
	let lost: Vec<&String> = known.iter().filter(|id| !present.contains(*id) && !gone.contains(id.as_str())).collect();
	assert!(lost.is_empty(), "guide ids a release shipped that are neither a guide nor in retired.json (a saved tab of one finds nothing): {lost:?}");
	let unlisted: Vec<&String> = present.iter().filter(|id| !known.contains(*id)).collect();
	assert!(unlisted.is_empty(), "guides whose id is not in guides/ids.json (add it: the list keeps every id a saved tab may hold): {unlisted:?}");
	let nowhere: Vec<String> = retired.iter().filter_map(|(id, to)| to.as_ref().filter(|to| !present.contains(*to)).map(|to| format!("{id} -> {to}"))).collect();
	assert!(nowhere.is_empty(), "retired ids going to a guide the packs don't have: {nowhere:?}");
}
