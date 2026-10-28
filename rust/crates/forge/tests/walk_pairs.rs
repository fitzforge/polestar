//! The walk-store misses carry over to the next build: the routes stage's misses (point ids of its
//! world) merge into the extra walk pairs file by their places, as a union that stops changing once
//! nothing new is missed, and read back as the ids of whatever world the next build has.

use forge::{extra_pairs, merge_walk_pairs, walks_stage_key, walks_versions, Part};
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
	let k = |world: &str, versions: &str| walks_stage_key(&[Part::Text(world), Part::Text(versions), Part::File(&lifts)]);
	let base = k("horde aaa", &v);
	assert_eq!(base, k("horde aaa", &v), "the same inputs: skipped");
	assert_ne!(base, k("horde bbb", &v), "new places: walked again (the stores answer the old pairs)");
	assert_ne!(base, k("horde aaa", &v.replace("grid walker v", "grid walker v9")), "another grid walker version");
	assert_ne!(base, k("horde aaa", &walks_versions("other-fp")), "another nav fingerprint");
	std::fs::write(&lifts, "[2]").unwrap();
	assert_ne!(base, k("horde aaa", &v), "another lift layer");
	std::fs::remove_dir_all(&dir).unwrap();
}
