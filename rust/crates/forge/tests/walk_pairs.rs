//! The walk-store misses carry over to the next build: the routes stage's misses (point ids of its
//! world) merge into the extra walk pairs file by their places, as a union that stops changing once
//! nothing new is missed, and read back as the ids of whatever world the next build has.

use forge::{extra_pairs, merge_walk_pairs, search_pairs, walks_keys, walks_versions, Part, SearchPairs};
use forge_core::Faction;
use serde_json::{json, Value};

fn points(xs: &[f64]) -> Vec<Value> {
	xs.iter().map(|&x| json!([0, 0, x, 10.5, 1420, null])).collect()
}

fn write_world(dir: &std::path::Path, f: &str, pts: &[Value]) {
	std::fs::write(dir.join(format!("world-{f}.json")), json!({ "points": pts }).to_string()).unwrap();
}

#[test]
fn misses_merge_into_the_extra_pairs_once_by_their_places() {
	let dir = std::env::temp_dir().join(format!("forge-walk-pairs-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&dir);
	std::fs::create_dir_all(&dir).unwrap();
	let (misses, extra, worlds) = (dir.join("walk-misses.json"), dir.join("walks/extra-pairs.json"), dir.join("world"));
	std::fs::create_dir_all(&worlds).unwrap();
	let horde = points(&[0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]);
	let alliance = points(&[100.0, 200.0, 300.0]);
	write_world(&worlds, "horde", &horde);
	write_world(&worlds, "alliance", &alliance);
	std::fs::write(&misses, r#"{"horde": [[9, 3], [1, 2]], "alliance": [[2, 0]]}"#).unwrap();
	assert_eq!(merge_walk_pairs(&misses, &extra, &worlds).unwrap(), 3);
	assert_eq!(extra_pairs(&extra, Faction::Horde, &horde).unwrap(), vec![(1, 2), (3, 9)]);
	assert_eq!(extra_pairs(&extra, Faction::Alliance, &alliance).unwrap(), vec![(0, 2)]);
	let bytes = std::fs::read(&extra).unwrap();
	// The same misses again: nothing new, the file (the walks stage's key) unchanged.
	assert_eq!(merge_walk_pairs(&misses, &extra, &worlds).unwrap(), 0);
	assert_eq!(std::fs::read(&extra).unwrap(), bytes);
	// A new miss grows it.
	std::fs::write(&misses, r#"{"horde": [[2, 1], [4, 5]]}"#).unwrap();
	assert_eq!(merge_walk_pairs(&misses, &extra, &worlds).unwrap(), 1);
	assert_eq!(extra_pairs(&extra, Faction::Horde, &horde).unwrap(), vec![(1, 2), (3, 9), (4, 5)]);
	// A correction adds two places ahead of the others: the pairs follow their places to the new ids,
	// and a place the world no longer has drops its pair.
	let mut grown = points(&[50.0, 60.0]);
	grown.extend(horde.iter().filter(|p| p[2] != json!(9.0)).cloned());
	assert_eq!(extra_pairs(&extra, Faction::Horde, &grown).unwrap(), vec![(3, 4), (6, 7)]);
	assert!(extra_pairs(&dir.join("none.json"), Faction::Horde, &horde).unwrap().is_empty());
	// A file of point ids (schema 1) is of an unknown world: read as none, rewritten by the next merge.
	std::fs::write(&extra, r#"{"horde": [[1, 2]]}"#).unwrap();
	assert!(extra_pairs(&extra, Faction::Horde, &horde).unwrap().is_empty());
	std::fs::write(&misses, r#"{"horde": [[4, 5]]}"#).unwrap();
	assert_eq!(merge_walk_pairs(&misses, &extra, &worlds).unwrap(), 1);
	assert_eq!(extra_pairs(&extra, Faction::Horde, &horde).unwrap(), vec![(4, 5)]);
	std::fs::remove_dir_all(&dir).unwrap();
}

#[test]
fn the_walks_stage_key_follows_the_walk_inputs_and_the_walkers_versions() {
	let dir = std::env::temp_dir().join(format!("forge-walks-key-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&dir);
	std::fs::create_dir_all(&dir).unwrap();
	let lifts = dir.join("lifts.json");
	std::fs::write(&lifts, "[1]").unwrap();
	let v = walks_versions("forge-walks");
	let k = |world: &str, versions: &str| walks_keys(&[Part::Text(world), Part::Text(versions), Part::File(&lifts)], None).0;
	let base = k("horde aaa", &v);
	assert_eq!(base, k("horde aaa", &v), "the same inputs: skipped");
	assert_ne!(base, k("horde bbb", &v), "new places: walked again (the stores answer the old pairs)");
	assert_ne!(base, k("horde aaa", &v.replace("grid walker v", "grid walker v9")), "another grid walker version");
	assert_ne!(base, k("horde aaa", &walks_versions("other-fp")), "another nav fingerprint");
	std::fs::write(&lifts, "[2]").unwrap();
	assert_ne!(base, k("horde aaa", &v), "another lift layer");
	std::fs::remove_dir_all(&dir).unwrap();
}

/// c14: a build failed in its report after its routes stage added 60 walk pairs; the rerun walked
/// them (a new walks key) and searched for 45 minutes again, the walks key being part of the search
/// key. The search reads the walks but the extra pairs.
#[test]
fn new_walk_pairs_rerun_the_walks_but_keep_the_search_key() {
	let dir = std::env::temp_dir().join(format!("forge-walks-search-key-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&dir);
	std::fs::create_dir_all(&dir).unwrap();
	let extra = dir.join("extra-pairs.json");
	let keys = |world: &str| walks_keys(&[Part::Text(world), Part::Text("versions")], Some(&extra));
	let (walks0, search0) = keys("horde aaa");
	std::fs::write(&extra, r#"{"schema": 2, "horde": [[[0, 1, 2, 3], [0, 4, 5, 6]]]}"#).unwrap();
	let (walks1, search1) = keys("horde aaa");
	assert_ne!(walks1, walks0, "new pairs: walked");
	assert_eq!(search1, search0, "new pairs: the same search key");
	let (walks2, search2) = keys("horde bbb");
	assert_ne!(walks2, walks1, "new places: walked again");
	assert_ne!(search2, search1, "new places: searched again");
	assert_eq!(walks_keys(&[Part::Text("horde aaa"), Part::Text("versions")], None).1, search0, "imported walks read no pairs");
	std::fs::remove_dir_all(&dir).unwrap();
}

/// The pairs a search ran with, beside its checkpoints: more keep its finished searches (and drop its
/// unfinished ones, which would go on at other prices), fewer drop them all.
#[test]
fn a_search_is_kept_while_the_walk_pairs_only_grow() {
	let dir = std::env::temp_dir().join(format!("forge-search-pairs-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&dir);
	let (search, extra) = (dir.join("routes-search"), dir.join("extra-pairs.json"));
	let pair = |x: i64| json!([[0, x, 0, 0], [0, x, 1, 0]]);
	let write_pairs = |horde: Vec<Value>| std::fs::write(&extra, json!({ "schema": 2, "horde": horde, "alliance": [] }).to_string()).unwrap();
	let resume = forge_sim::resume::Resume::open(&search, "key").unwrap();
	write_pairs(vec![pair(1)]);
	assert_eq!(search_pairs(&resume, Some(&extra)).unwrap(), SearchPairs::Same, "a new search: its pairs recorded");
	let parts = |names: &[&str]| {
		for n in names {
			std::fs::write(search.join(n), "{}").unwrap();
		}
	};
	let left = || {
		let mut v: Vec<String> = std::fs::read_dir(&search).unwrap().flatten().map(|e| e.file_name().to_string_lossy().into_owned()).collect();
		v.sort();
		v
	};
	parts(&["own-Human.done.json", "own-Human.free.json", "own-Dwarf.free.json", "own-Dwarf.descent.json"]);
	assert_eq!(search_pairs(&resume, Some(&extra)).unwrap(), SearchPairs::Same);
	assert_eq!(left().len(), 6, "the same pairs: every checkpoint kept");
	write_pairs(vec![pair(1), pair(2), pair(3)]);
	assert_eq!(search_pairs(&resume, Some(&extra)).unwrap(), SearchPairs::Grew(2));
	assert_eq!(left(), ["KEY", "own-Human.done.json", "walk-pairs.json"], "pairs added: the finished search kept, the unfinished dropped");
	assert_eq!(search_pairs(&resume, Some(&extra)).unwrap(), SearchPairs::Same, "the grown pairs are now the ones it ran with");
	write_pairs(vec![pair(1), pair(3)]);
	assert_eq!(search_pairs(&resume, Some(&extra)).unwrap(), SearchPairs::Lost(1));
	assert_eq!(left(), ["KEY", "walk-pairs.json"], "a pair gone: searched again");
	std::fs::remove_dir_all(&dir).unwrap();
}
