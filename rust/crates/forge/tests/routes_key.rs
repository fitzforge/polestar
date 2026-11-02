//! The routes stage's two keys (lib.rs routes_stage_key, routes_search_key): a writer change reruns
//! the stage but keeps its search; a planner change searches again; a changed input reruns both. The
//! planner's code is its crates' sources (planner_src.rs, hashed by build.rs), not the forge binary.

use forge::planner_src::{path_closure, sources_hash};
use forge::{routes_search_key, routes_stage_key, Part, PLANNER_HASH};
use serde_json::json;
use std::path::{Path, PathBuf};

fn tmp(name: &str) -> PathBuf {
	let d = std::env::temp_dir().join(format!("forge-{name}-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

/// A made-up crate `name` under `ws` with `src/lib.rs` = `src` and path dependencies `deps`
/// (`dev` as a dev dependency).
fn krate(ws: &Path, name: &str, deps: &[&str], dev: &[&str], src: &str) {
	let d = ws.join(name);
	std::fs::create_dir_all(d.join("src")).unwrap();
	let line = |x: &&str| format!("{x} = {{ path = \"../{x}\", default-features = false }}\n");
	let (deps, dev): (String, String) = (deps.iter().map(line).collect(), dev.iter().map(line).collect());
	let toml = format!("[package]\nname = \"{name}\"\n\n[dependencies]\nserde = \"1\"\n{deps}\n[dev-dependencies]\n{dev}");
	std::fs::write(d.join("Cargo.toml"), toml).unwrap();
	std::fs::write(d.join("src/lib.rs"), src).unwrap();
}

#[test]
fn the_planner_hash_follows_the_planner_crates_and_not_the_writer() {
	let ws = tmp("planner-src");
	krate(&ws, "core", &[], &[], "pub fn c() {}");
	krate(&ws, "world", &["core"], &[], "pub fn w() {}");
	krate(&ws, "writer", &["world"], &[], "pub fn wr() {}");
	krate(&ws, "sim", &["world", "core"], &["writer"], "pub fn s() {}");
	let closure = path_closure(&ws.join("sim"));
	let names: Vec<String> = closure.iter().map(|c| c.file_name().unwrap().to_string_lossy().into_owned()).collect();
	assert_eq!(names, ["core", "sim", "world"], "the planner and its path dependencies, not its dev dependencies");
	let base = sources_hash(&closure);
	assert_eq!(base, sources_hash(&path_closure(&ws.join("sim"))), "the same sources: the same hash");
	// A writer-only change: the same hash.
	std::fs::write(ws.join("writer/src/lib.rs"), "pub fn wr() { let _ = 1; }").unwrap();
	std::fs::create_dir_all(ws.join("writer/src/native")).unwrap();
	std::fs::write(ws.join("writer/src/native/mod.rs"), "pub fn n() {}").unwrap();
	assert_eq!(base, sources_hash(&path_closure(&ws.join("sim"))), "a writer change keeps the planner hash");
	// A planner change, in a nested module of a dependency: another hash.
	std::fs::create_dir_all(ws.join("world/src/rules")).unwrap();
	std::fs::write(ws.join("world/src/rules/mod.rs"), "pub fn r() {}").unwrap();
	let world_changed = sources_hash(&path_closure(&ws.join("sim")));
	assert_ne!(base, world_changed, "a planner dependency change");
	std::fs::write(ws.join("sim/src/lib.rs"), "pub fn s() { let _ = 2; }").unwrap();
	assert_ne!(world_changed, sources_hash(&path_closure(&ws.join("sim"))), "a planner change");
	// Tests and benches are not the planner.
	let now = sources_hash(&path_closure(&ws.join("sim")));
	std::fs::create_dir_all(ws.join("sim/tests")).unwrap();
	std::fs::write(ws.join("sim/tests/t.rs"), "#[test] fn t() {}").unwrap();
	assert_eq!(now, sources_hash(&path_closure(&ws.join("sim"))), "a test file keeps the hash");
	let _ = std::fs::remove_dir_all(&ws);
}

#[test]
fn the_built_planner_hash_is_forge_sim_and_its_workspace_crates() {
	let sim = Path::new(env!("CARGO_MANIFEST_DIR")).join("../forge-sim");
	let closure = path_closure(&sim);
	let names: Vec<String> = closure.iter().map(|c| c.file_name().unwrap().to_string_lossy().into_owned()).collect();
	for c in ["forge-sim", "forge-world", "forge-core"] {
		assert!(names.iter().any(|n| n == c), "{c} in {names:?}");
	}
	for c in ["forge", "forge-writer", "forge-judge", "forge-guide"] {
		assert!(!names.iter().any(|n| n == c), "{c} is not the planner: {names:?}");
	}
	assert_eq!(PLANNER_HASH, sources_hash(&closure), "build.rs hashed these sources");
}

#[test]
fn a_writer_change_keeps_the_search_and_a_planner_or_input_change_does_not() {
	let d = tmp("routes-keys");
	let (guides, exe, places) = (d.join("guides"), d.join("forge"), d.join("places.json"));
	std::fs::create_dir_all(&guides).unwrap();
	std::fs::write(guides.join("a.lua"), "-- step 1").unwrap();
	std::fs::write(&exe, "forge binary 1").unwrap();
	std::fs::write(&places, "{}").unwrap();
	let goals = [json!({ "goals": [{ "q": 1 }] })];
	let keys = |data: &str, planner: &str, goals: &[serde_json::Value]| {
		let search = [Part::Text(data), Part::Text("Orc")];
		(routes_stage_key(&search, &guides, &[Part::File(&exe), Part::File(&places)]), routes_search_key(&search, planner, goals))
	};
	let (stage0, search0) = keys("data 1", "planner 1", &goals);
	assert_eq!((stage0.clone(), search0.clone()), keys("data 1", "planner 1", &goals), "the same inputs: skipped");
	// A writer change (the binary, the places): the stage runs again, its search is reused.
	std::fs::write(&exe, "forge binary 2").unwrap();
	let (stage1, search1) = keys("data 1", "planner 1", &goals);
	assert_ne!(stage1, stage0, "a rebuilt forge reruns the stage");
	assert_eq!(search1, search0, "a writer-only change keeps the search");
	std::fs::write(&places, "{\"x\": 1}").unwrap();
	let (stage2, search2) = keys("data 1", "planner 1", &goals);
	assert_ne!(stage2, stage1, "new places rerun the stage");
	assert_eq!(search2, search0, "new places keep the search");
	// A guide text change that leaves the goal streams as they were: the same search.
	std::fs::write(guides.join("a.lua"), "-- step 1, reworded").unwrap();
	let (stage3, search3) = keys("data 1", "planner 1", &goals);
	assert_ne!(stage3, stage2, "a guide change reruns the stage");
	assert_eq!(search3, search0, "the same goal streams: the same search");
	// A planner change (its sources' hash): searched again.
	let (_, search4) = keys("data 1", "planner 2", &goals);
	assert_ne!(search4, search0, "a planner change searches again");
	// Other goal streams: searched again.
	let (_, search5) = keys("data 1", "planner 1", &[json!({ "goals": [{ "q": 2 }] })]);
	assert_ne!(search5, search0, "other goal streams search again");
	// A changed input of the search (the data): both rerun.
	let (stage6, search6) = keys("data 2", "planner 1", &goals);
	assert_ne!(stage6, stage3, "new data reruns the stage");
	assert_ne!(search6, search0, "and its search");
	let _ = std::fs::remove_dir_all(&d);
}

#[test]
fn the_data_by_its_bytes_but_its_build_time() {
	let d = tmp("routes-data");
	std::fs::write(d.join("meta.json"), "{\"builtAt\": \"10:00\"}").unwrap();
	std::fs::write(d.join("quests.json"), "{}").unwrap();
	let k = || routes_search_key(&[Part::Data(&d)], "planner", &[]);
	let base = k();
	std::fs::write(d.join("meta.json"), "{\"builtAt\": \"11:00\"}").unwrap();
	assert_eq!(k(), base, "the data built again, the same: the same search");
	std::fs::write(d.join("quests.json"), "{\"1\": {}}").unwrap();
	assert_ne!(k(), base, "other data: searched again");
	let _ = std::fs::remove_dir_all(&d);
}
