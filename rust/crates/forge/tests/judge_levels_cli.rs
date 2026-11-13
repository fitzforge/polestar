//! Saved judge levels obey --to just like the simulator, using the committed mini pack.

use serde_json::{json, Value};
use std::path::{Path, PathBuf};
use std::process::Command;

fn repo() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

fn recording(name: &str, rows: &[[f64; 4]]) -> PathBuf {
	let dir = Path::new(env!("CARGO_TARGET_TMPDIR")).join("judge-levels-cli").join(name);
	std::fs::create_dir_all(&dir).unwrap();
	let file = dir.join("levels.json");
	let goals: Vec<Value> = rows.iter().map(|r| json!({ "lvl": r[0], "time": r[1], "lvlAfter": r[2], "timeAfter": r[3] })).collect();
	std::fs::write(&file, serde_json::to_vec(&json!({ "goals": goals })).unwrap()).unwrap();
	file
}

fn judge(levels: &Path, to: Option<&str>, legacy: bool) -> Value {
	let mut cmd = Command::new(env!("CARGO_BIN_EXE_forge"));
	cmd.current_dir(repo())
		.args([
			"judge",
			"tests/fixtures/packs/mini/guides",
			"--root",
			"rust/tests/golden/world/root",
			"--data",
			"tests/fixtures/dsl/data",
			"--faction",
			"Alliance",
			"--race",
			"Human",
			"--class",
			"Warrior",
			"--json",
			"--levels",
		])
		.arg(levels);
	if let Some(to) = to {
		cmd.args(["--to", to]);
	}
	if legacy {
		cmd.arg("--legacy");
	}
	let out = cmd.output().unwrap();
	assert!(out.status.success(), "{}\n{}", String::from_utf8_lossy(&out.stderr), String::from_utf8_lossy(&out.stdout));
	serde_json::from_slice(&out.stdout).unwrap()
}

fn walk(out: &Value, goals: u64, level: f64, seconds: f64) {
	assert_eq!(out["walk"]["chain"], json!(["mini/a", "mini/b"]));
	assert_eq!(out["walk"]["goals"], goals);
	assert_eq!(out["walk"]["endLevel"], level);
	assert!((out["walk"]["hours"].as_f64().unwrap() - seconds / 3600.0).abs() < 1e-12);
}

#[test]
fn saved_levels_honor_stop_level_in_default_and_legacy_modes() {
	let levels = recording("cutoffs", &[[1.0, 0.0, 2.0, 60.0], [2.0, 60.0, 3.0, 120.0], [3.0, 120.0, 4.0, 180.0]]);
	for legacy in [false, true] {
		let full = judge(&levels, None, legacy);
		walk(&full, 3, 4.0, 180.0);
		assert_eq!(full["honest"], json!({ "played": 2, "findings": [] }));
		assert!(full["walk"]["passedBy"]["count"].as_u64().unwrap() > 0);
		for (to, count, end, seconds) in [("1", 0, 1.0, 0.0), ("2", 1, 2.0, 60.0), ("2.5", 2, 3.0, 120.0)] {
			let cut = judge(&levels, Some(to), legacy);
			walk(&cut, count, end, seconds);
			assert_eq!(cut["honest"], full["honest"], "--to cuts the walk, not honest play");
			assert_eq!(cut["walk"]["passedBy"]["count"], 0, "the omitted third goal cannot create passed-by findings");
		}
	}
}

#[test]
fn saved_levels_keep_the_goal_that_crosses_the_threshold() {
	let levels = recording("crossing", &[[1.0, 0.0, 2.75, 60.0], [2.75, 60.0, 3.25, 120.0], [3.25, 120.0, 4.0, 180.0]]);
	for legacy in [false, true] {
		let cut = judge(&levels, Some("2.5"), legacy);
		walk(&cut, 1, 2.75, 60.0);
		assert_eq!(cut["honest"], json!({ "played": 2, "findings": [] }));
	}
}

#[test]
fn saved_levels_still_stop_at_the_end_of_a_short_recording() {
	let levels = recording("short", &[[1.0, 0.0, 2.0, 60.0], [2.0, 60.0, 3.0, 120.0]]);
	for legacy in [false, true] {
		walk(&judge(&levels, Some("61"), legacy), 2, 3.0, 120.0);
	}
}
