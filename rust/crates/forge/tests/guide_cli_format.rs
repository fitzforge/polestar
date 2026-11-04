//! Lint and compile output formats on a pack (tests/fixtures/packs/format, with packs/context as our guides):
//! text with fix hints, one JSON document, GitHub workflow annotations, --quiet; an unknown --format is a
//! usage error; a failed write is an error in the document; unknown items and objects get the find hint.

use std::path::{Path, PathBuf};
use std::process::Command;

fn repo() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

fn packs() -> PathBuf {
	repo().join("tests/fixtures/packs")
}

fn data() -> String {
	repo().join("tests/fixtures/dsl/data").to_string_lossy().into_owned()
}

fn context() -> String {
	packs().join("context").to_string_lossy().into_owned()
}

const HINT: &str = "find the id with `polestar find <name>`, or give its name in quotes";

struct Run {
	status: i32,
	stdout: String,
	stderr: String,
}

fn forge(args: &[&str]) -> Run {
	let o = Command::new(env!("CARGO_BIN_EXE_forge")).current_dir(repo()).arg("guide").args(args).output().unwrap();
	Run { status: o.status.code().unwrap_or(-1), stdout: String::from_utf8(o.stdout).unwrap(), stderr: String::from_utf8(o.stderr).unwrap() }
}

/// `<name> --pack packs/format --data <fixture> --context packs/context --context-data <fixture> <args>`.
fn cmd(name: &str, args: &[&str]) -> Run {
	let pack = packs().join("format");
	let (d, c) = (data(), context());
	let mut all = vec![name, "--pack", pack.to_str().unwrap(), "--data", &d, "--context", &c, "--context-data", &d];
	all.extend_from_slice(args);
	forge(&all)
}

fn re(p: &str) -> regex::Regex {
	regex::Regex::new(p).unwrap()
}

#[test]
fn format_json_prints_one_document_with_the_counts_the_diagnostics_and_the_hint() {
	for name in ["lint", "compile"] {
		let r = cmd(name, &["--format", "json"]);
		assert_eq!(r.status, 1, "{}", r.stderr);
		let doc: serde_json::Value = serde_json::from_str(&r.stdout).unwrap();
		assert_eq!(doc["ok"], false);
		assert_eq!(doc["errors"], 1);
		assert_eq!(doc["warnings"], 1);
		let (error, warning) = (&doc["diagnostics"][0], &doc["diagnostics"][1]);
		let mut keys: Vec<&String> = error.as_object().unwrap().keys().collect();
		keys.sort();
		assert_eq!(keys, ["file", "hint", "line", "message", "severity"]);
		assert!(error["file"].as_str().unwrap().ends_with("format/guides/a.guide"));
		assert_eq!(error["line"], 10);
		assert_eq!(error["severity"], "error");
		assert!(error["message"].as_str().unwrap().starts_with("quest 999999 is not in data"));
		assert_eq!(error["hint"], HINT);
		assert_eq!(warning["severity"], "warning");
		assert_eq!(warning["hint"], "turn it in later in this guide or in a guide after it, or make the accept `optional` when the player may leave it");
		assert!(!re("lint failed|compile failed").is_match(&format!("{}{}", r.stdout, r.stderr)), "no summary");
	}
}

#[test]
fn format_github_prints_workflow_annotations_with_the_hint() {
	let r = cmd("lint", &["--format", "github"]);
	assert_eq!(r.status, 1);
	let lines: Vec<&str> = r.stdout.trim().split('\n').collect();
	assert_eq!(lines.len(), 2);
	assert!(
		re(r"^::error file=[^,]*format/guides/a\.guide,line=10::quest 999999 is not in data.* \(hint: find the id with `polestar find <name>`, or give its name in quotes\)$").is_match(lines[0]),
		"{}",
		lines[0]
	);
	assert!(re(r"^::warning file=[^,]*a\.guide,line=10::quest 999999 is accepted but never turned in").is_match(lines[1]), "{}", lines[1]);
}

#[test]
fn text_prints_the_hint_on_its_own_line() {
	let r = cmd("lint", &[]);
	assert_eq!(r.status, 1);
	assert!(
		re(r"a\.guide:10: error: quest 999999 is not in data; give its title: `accept 999999 \x22Title\x22`\n {2}hint: find the id with `polestar find <name>`, or give its name in quotes\n")
			.is_match(&r.stderr),
		"{}",
		r.stderr
	);
	assert!(r.stderr.contains("lint failed: 1 file, 1 guide: 1 error, 1 warning"), "{}", r.stderr);
}

#[test]
fn an_unknown_format_exits_2() {
	for name in ["lint", "compile"] {
		let r = cmd(name, &["--format", "xml"]);
		assert_eq!(r.status, 2);
		assert!(r.stderr.contains("unknown --format xml"), "{}", r.stderr);
	}
}

#[test]
fn format_json_quiet_leaves_the_warnings_out_of_the_list_but_still_counts_them() {
	let r = cmd("lint", &["--format", "json", "--quiet"]);
	let doc: serde_json::Value = serde_json::from_str(&r.stdout).unwrap();
	assert_eq!(doc["errors"], 1);
	assert_eq!(doc["warnings"], 1);
	assert_eq!(doc["diagnostics"].as_array().unwrap().iter().map(|d| d["severity"].as_str().unwrap()).collect::<Vec<_>>(), ["error"]);
}

#[test]
fn compile_format_json_a_failed_write_is_an_error_in_the_document_so_ok_matches_the_exit_code() {
	let out = Path::new(env!("CARGO_TARGET_TMPDIR")).join("guide-cli-format-write");
	let _ = std::fs::remove_dir_all(&out);
	std::fs::create_dir_all(&out).unwrap();
	std::fs::write(out.join("mine.txt"), "not a pack\n").unwrap();
	let joe = packs().join("joe");
	let (d, c) = (data(), context());
	let r = forge(&["compile", "--pack", joe.to_str().unwrap(), "--data", &d, "--context", &c, "--context-data", &d, "--out", out.to_str().unwrap(), "--format", "json"]);
	assert_eq!(r.status, 1, "{}", r.stderr);
	let doc: serde_json::Value = serde_json::from_str(&r.stdout).unwrap();
	assert_eq!(doc["ok"], false);
	assert_eq!(doc["errors"], 1);
	let e = doc["diagnostics"].as_array().unwrap().iter().find(|x| x["severity"] == "error").unwrap();
	assert_eq!(e["file"], out.to_str().unwrap());
	assert!(e["message"].as_str().unwrap().contains("refusing to write into"));
	assert_eq!(std::fs::read_dir(&out).unwrap().count(), 1);
}

#[test]
fn an_unknown_item_or_object_gets_the_same_find_the_id_hint_as_an_unknown_quest() {
	let dir = Path::new(env!("CARGO_TARGET_TMPDIR")).join("guide-cli-format-unknown");
	let _ = std::fs::remove_dir_all(&dir);
	std::fs::create_dir_all(dir.join("guides")).unwrap();
	std::fs::copy(packs().join("format/pack.json"), dir.join("pack.json")).unwrap();
	std::fs::write(
		dir.join("guides/a.guide"),
		"guide fmt/a\ntitle Format\nfaction Alliance\nlevels 1-6\nzone Elwynn Forest\n\nstep Somewhere\n  collect 99999999\n  interact 99999999\n  use 99999998\n",
	)
	.unwrap();
	let (d, c) = (data(), context());
	let r = forge(&["lint", dir.to_str().unwrap(), "--data", &d, "--context", &c, "--context-data", &d, "--format", "json"]);
	assert_eq!(r.status, 1, "{}", r.stderr);
	let doc: serde_json::Value = serde_json::from_str(&r.stdout).unwrap();
	let errors: Vec<(i64, String, String)> = doc["diagnostics"]
		.as_array()
		.unwrap()
		.iter()
		.filter(|d| d["severity"] == "error")
		.map(|d| (d["line"].as_i64().unwrap(), d["message"].as_str().unwrap().split(';').next().unwrap().to_string(), d["hint"].as_str().unwrap().to_string()))
		.collect();
	let h = HINT.to_string();
	assert_eq!(errors, vec![(8, "item 99999999 is not in data".into(), h.clone()), (9, "object 99999999 is not in data".into(), h.clone()), (10, "item 99999998 is not in data".into(), h)]);
}
