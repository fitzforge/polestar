//! `forge data build`'s statistics gate and `forge data check`, on the synthetic data fixture
//! (rust/tests/fixtures/data): the first build is taken and becomes the last good statistics; a shift
//! past a field's limit stops the build and leaves the data as it was, the new build in <out>.staging;
//! `forge data check` takes a folder with no last good statistics as its own baseline; `--accept`
//! takes the build. Also the usage errors of the new data commands.

use std::path::{Path, PathBuf};
use std::process::Command;

fn repo() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

fn fixture() -> PathBuf {
	repo().join("rust/tests/fixtures/data")
}

fn tmp(name: &str) -> PathBuf {
	let d = Path::new(env!("CARGO_TARGET_TMPDIR")).join("data-gate").join(name);
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

fn forge(args: &[&str]) -> (i32, String) {
	let o = Command::new(env!("CARGO_BIN_EXE_forge")).args(args).current_dir(repo()).output().unwrap();
	(o.status.code().unwrap_or(-1), format!("{}{}", String::from_utf8_lossy(&o.stdout), String::from_utf8_lossy(&o.stderr)))
}

#[test]
fn a_shift_stops_the_build_and_leaves_the_data_accept_takes_it_and_check_reports() {
	let out = tmp("build").join("forever");
	let (pf, src, rec) = (fixture().join("pfquest"), fixture().join("sources"), fixture().join("recordings"));
	let (pf, src, rec, o) = (pf.to_str().unwrap(), src.to_str().unwrap(), rec.to_str().unwrap(), out.to_str().unwrap());
	let args = [
		"data",
		"build",
		"--offline",
		"--no-questie",
		"--no-forever",
		"--no-web-xp",
		"--no-web-zones",
		"--pfquest",
		pf,
		"--sources",
		src,
		"--recordings",
		rec,
		"--out",
		o,
		"--built-at",
		"2026-01-01T00:00:00Z",
	];
	let (code, text) = forge(&args);
	assert_eq!(code, 0, "{text}");
	assert!(text.contains("no last good statistics"), "{text}");
	let good_file = out.join("stats-good.json");
	let good: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(&good_file).unwrap()).unwrap();
	let total = good["fields"]["quests.total"].as_f64().unwrap();
	assert!(total > 0.0);
	let staging = PathBuf::from(format!("{o}.staging"));
	assert!(!staging.exists(), "the staging folder is gone after a good build");

	// The last good build had twice the quests: this one is a large unexpected shift.
	let mut doubled = good.clone();
	doubled["fields"]["quests.total"] = serde_json::json!(total * 2.0);
	std::fs::write(&good_file, doubled.to_string()).unwrap();
	let quests = out.join("quests.json");
	std::fs::write(&quests, "{\"marker\":1}\n").unwrap();
	let (code, text) = forge(&args);
	assert_eq!(code, 1, "{text}");
	assert!(text.contains("SHIFT  quests.total"), "{text}");
	assert!(text.contains("forge data: stopped: ") && text.contains(" is unchanged"), "{text}");
	assert_eq!(std::fs::read_to_string(&quests).unwrap(), "{\"marker\":1}\n", "the data is left as it was");
	assert!(staging.join("quests.json").exists(), "the new build stays in staging");

	let (code, text) = forge(&["data", "check", "--data", staging.to_str().unwrap(), "--sources", src]);
	assert_eq!(code, 0, "staging has no last good statistics of its own: they become its baseline\n{text}");
	let (code, text) = forge(&["data", "check", "--data", o, "--sources", src]);
	assert_eq!(code, 1, "{text}");
	assert!(text.contains("statistics shifted past their limits"), "{text}");

	let mut accept = args.to_vec();
	accept.push("--accept");
	let (code, text) = forge(&accept);
	assert_eq!(code, 0, "{text}");
	assert_ne!(std::fs::read_to_string(&quests).unwrap(), "{\"marker\":1}\n");
	let now: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(&good_file).unwrap()).unwrap();
	assert_eq!(now["fields"]["quests.total"].as_f64(), Some(total), "the taken build is the last good one");
	let (code, text) = forge(&["data", "check", "--data", o, "--sources", src, "--all"]);
	assert_eq!(code, 0, "{text}");
	assert!(text.contains("  ok   quests.total"), "--all lists every field\n{text}");
}

#[test]
fn the_new_data_commands_reject_bad_usage_with_exit_2() {
	for args in [
		&["data", "sources", "--only", "nope"][..],
		&["data", "sources", "--bogus"],
		&["data", "check", "--bogus"],
		&["data", "itemdb", "extra"],
		&["data", "talents"],
		&["data", "talents", "build", "--bogus"],
		&["data", "maps", "draw"],
		&["data", "maps", "build", "--offline"],
	] {
		let (code, text) = forge(args);
		assert_eq!(code, 2, "{args:?}: {text}");
		assert!(text.starts_with("forge data: "), "{args:?}: {text}");
	}
	for sub in ["sources", "check", "itemdb", "talents", "maps"] {
		let (code, text) = forge(&["data", sub, "--help"]);
		assert_eq!(code, 0, "{sub}");
		assert!(text.starts_with(&format!("usage: forge data {sub}")), "{sub}: {text}");
	}
}

// `forge data questdb` on tests/fixtures/questdb (formerly tests/questdb.test.js).
#[test]
fn the_command_writes_the_addon_and_reports_size_and_memory() {
	let out = tmp("questdb");
	let fix = repo().join("tests/fixtures/questdb");
	let (code, text) = forge(&["data", "questdb", "--data", fix.to_str().unwrap(), "--out", out.to_str().unwrap(), "--json"]);
	assert_eq!(code, 0, "{text}");
	let stats: serde_json::Value = serde_json::from_str(text.trim()).unwrap_or_else(|e| panic!("{e}: {text}"));
	assert_eq!(stats["quests"], 15);
	assert!(stats["luaBytes"].as_u64().unwrap() > 0 && stats["memoryBytes"].as_u64().unwrap() > 0);
	assert!(out.join("Quests.lua").exists());
}
