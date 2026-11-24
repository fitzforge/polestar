//! A leveling guide both factions share (no `faction` header: Shen'dralas, Mount Hyjal) gets baked legs
//! per faction (#3360): each faction's legs run between its own steps (step_targets_for leaves out the
//! other faction's), legs.json holds them as `sides`, and each side ships in its faction's race parts.

use crate::common;
use common::*;
use forge_guide::bake::{guide_hash_for, step_targets_for};
use forge_guide::project::{build_pack, legs_sides, BuildOpts, FileContent};

const SHARED: &str = "guide parts/shared
title Shared Valley
levels 1-10
zone Elwynn Forest

step Start
  goto 40.0,40.0 \"Start\"

step Horde camp
  only Horde
  goto 60.0,40.0 \"Horde camp\"

step Alliance camp
  only Alliance
  goto 40.0,60.0 \"Alliance camp\"

step End
  goto 60.0,60.0 \"End\"
";

/// The pack folder with the shared guide and `legs` as its legs.json (None: no file).
fn pack(name: &str, legs: Option<&str>) -> std::path::PathBuf {
	let dir = scratch(&format!("legs-shared-{name}"));
	let mut files = vec![("pack.json", r#"{"id":"parts","title":"Parts Pack","author":"Ann","version":"1.0.0","license":"CC0-1.0","folder":"PolestarPack_Parts"}"#), ("guides/shared.guide", SHARED)];
	if let Some(l) = legs {
		files.push(("legs.json", l));
	}
	write_tree(&dir, &files);
	dir
}

fn build(dir: &std::path::Path) -> forge_guide::project::Built {
	let (manifest, extra) = forge_guide::manifest::read_manifest(dir, false);
	let b = build_pack(&repo(), dir, &manifest.unwrap(), extra, &fixture_data(), forge_guide::diag::Diagnostics::new(), BuildOpts { include_drafts: false, context: None, force: false }).unwrap();
	assert!(b.project.diag.errors().is_empty(), "{:?}", b.project.diag.sorted());
	b
}

fn text(files: &[(String, FileContent)], name: &str) -> String {
	match files.iter().find(|(k, _)| k == name).map(|(_, c)| c) {
		Some(FileContent::Text(t)) => t.clone(),
		Some(FileContent::Bytes(b)) => String::from_utf8_lossy(b).into_owned(),
		None => panic!("no {name} in {:?}", files.iter().map(|(k, _)| k).collect::<Vec<_>>()),
	}
}

/// legs.json for the shared guide: each side's hash as it walks now (the Alliance's off with `stale`).
fn legs_json(g: &forge_guide::js::V, stale: bool) -> String {
	let frames = fixture_data().map_frames;
	let horde = guide_hash_for(g, &frames, Some("Horde"));
	let alliance = if stale { "000000000000".to_string() } else { guide_hash_for(g, &frames, Some("Alliance")) };
	serde_json::json!({ "schema": 1, "grid": "test maps", "legs": { "parts/shared": { "sides": {
		"Horde": { "hash": horde, "steps": { "2": "HHH", "4": "HHH" } },
		"Alliance": { "hash": alliance, "steps": { "3": "AAA", "4": "AAA" } },
	} } } })
	.to_string()
}

#[test]
fn each_faction_walks_a_shared_guide_without_the_other_factions_steps() {
	let b = build(&pack("walks", None));
	let g = &b.project.guides[0];
	let frames = fixture_data().map_frames;
	let steps = |f: Option<&str>| step_targets_for(g, &frames, f).iter().map(|(s, _, _)| *s).collect::<Vec<_>>();
	assert_eq!(steps(None), vec![2, 3, 4]);
	assert_eq!(steps(Some("Horde")), vec![2, 4]);
	assert_eq!(steps(Some("Alliance")), vec![3, 4]);
	let to_end = |f| step_targets_for(g, &frames, Some(f)).into_iter().find(|(s, _, _)| *s == 4).map(|(_, a, _)| (a.wx.round(), a.wy.round())).unwrap();
	assert_ne!(to_end("Horde"), to_end("Alliance"), "the walk to the end starts at each faction's own camp");
	assert_ne!(guide_hash_for(g, &frames, Some("Horde")), guide_hash_for(g, &frames, Some("Alliance")));
	let sides: Vec<Option<&str>> = legs_sides(g).unwrap().into_iter().map(|(f, _)| f).collect();
	assert_eq!(sides, vec![Some("Horde"), Some("Alliance")]);
	assert_eq!(b.project.unbaked_legs, Vec::<String>::new(), "no legs.json: nothing to say");
}

#[test]
fn a_shared_guide_ships_each_factions_legs_in_that_factions_race_parts() {
	let first = build(&pack("first", None));
	let legs = legs_json(&first.project.guides[0], false);
	let b = build(&pack("sides", Some(&legs)));
	assert_eq!(b.project.stale_legs, Vec::<String>::new());
	let files = b.files.unwrap();
	let orc = text(&files, "../PolestarPack_Parts_Orc/Legs.lua");
	let human = text(&files, "../PolestarPack_Parts_Human/Legs.lua");
	assert!(orc.contains(r#"["parts/shared"] = { [2] = "HHH", [4] = "HHH" }"#), "{orc}");
	assert!(!orc.contains("AAA"), "{orc}");
	assert!(human.contains(r#"["parts/shared"] = { [3] = "AAA", [4] = "AAA" }"#), "{human}");
	assert!(!human.contains("HHH"), "{human}");
}

#[test]
fn a_shared_guide_with_no_legs_is_unbaked_and_with_one_side_off_is_stale() {
	let first = build(&pack("first-2", None));
	let g = &first.project.guides[0];
	let other = r#"{ "schema": 1, "grid": "test maps", "legs": {} }"#;
	assert_eq!(build(&pack("none", Some(other))).project.unbaked_legs, vec!["parts/shared".to_string()]);
	let b = build(&pack("stale", Some(&legs_json(g, true))));
	assert_eq!(b.project.stale_legs, vec!["parts/shared".to_string()]);
	assert!(!b.files.unwrap().iter().any(|(k, _)| k.ends_with("Legs.lua")), "a stale side ships neither side");
}
