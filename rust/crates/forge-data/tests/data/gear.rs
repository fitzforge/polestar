//! `forge data gear` (Polestar_ItemDB's Forever.lua, TOC and notice, SpecData.lua and its notice,
//! report.json, stdout) on a slice of the Forever client's tables and hotfixes, a Codex slice, an
//! Items.lua cut, Polestar's Weights.lua and a wowsims (MIT) cache slice: rust/tests/golden/gear
//! (README there).

use crate::common;

use forge_data::gear::{build, Options};

const BUILT_AT: &str = "2026-10-22T00:00:00.000Z";
const BUILD: &str = "1.60.1.70790";

fn options(root: std::path::PathBuf) -> Options {
	Options { root, sources: None, data: None, build: Some(BUILD.into()), hotfixes: None, offline: true, wowsims_cache: None, built_at: BUILT_AT.into() }
}

#[test]
fn gear_matches_golden() {
	let g = common::golden("gear");
	let out = build(&options(g.join("input/root"))).unwrap();
	let want = g.join("expected");
	let mut check = common::Check::new();
	for (rel, text) in &out.files {
		check.file(rel, text, &want.join(rel));
	}
	check.file("stdout.txt", &out.summary, &want.join("stdout.txt"));
	assert_eq!(out.files.len(), 6, "{:?}", out.files.iter().map(|f| &f.0).collect::<Vec<_>>());
	check.finish("gear build");
}

#[test]
fn gear_without_the_client_hotfixes_builds_from_the_tables_and_says_what_is_missing() {
	let root = common::scratch("gear-no-hotfixes");
	common::copy_tree(&common::golden("gear").join("input/root"), &root);
	std::fs::remove_dir_all(root.join("data/sources/hotfix")).unwrap();
	let out = build(&options(root)).unwrap();
	// Three rows only the server pushed: Serpent's Shoulders (retuned) and a Forever quest's two rewards.
	assert!(out.summary.starts_with(&format!("Forever client {BUILD}: 16 item records")), "{}", out.summary);
	assert!(out.summary.contains(&format!("gap: no client hotfixes for {BUILD}")), "{}", out.summary);
}
