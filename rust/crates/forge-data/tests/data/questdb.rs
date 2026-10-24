//! `forge data questdb` on tests/fixtures/questdb: the files match tests/fixtures/questdb/expected (the TOC's
//! version line aside, it follows package.json), and a second build is byte-identical.

use std::path::{Path, PathBuf};

use forge_data::questdb::{build, Options};

fn root() -> PathBuf {
	PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

fn unversioned(s: &str) -> String {
	s.lines().filter(|l| !l.starts_with("## Version:")).collect::<Vec<_>>().join("\n")
}

#[test]
fn the_fixture_database_matches_the_expected_files_and_rebuilds_byte_identical() {
	let root = root();
	let fix = root.join("tests/fixtures/questdb");
	let a = build(&fix, &root, &Options::default()).unwrap();
	let b = build(&fix, &root, &Options::default()).unwrap();
	assert_eq!(a.files, b.files, "deterministic");
	let mut names: Vec<String> = std::fs::read_dir(fix.join("expected")).unwrap().map(|e| e.unwrap().file_name().to_string_lossy().into_owned()).collect();
	names.sort();
	let mut got: Vec<String> = a.files.iter().map(|(n, _)| n.clone()).collect();
	got.sort();
	assert_eq!(got, names, "the same files");
	for (name, text) in &a.files {
		let want = std::fs::read_to_string(fix.join("expected").join(name)).unwrap();
		assert_eq!(unversioned(text), unversioned(&want), "{name}");
	}
	assert!(a.warnings.is_empty(), "{:?}", a.warnings);
	assert_eq!((a.stats.quests, a.stats.npcs, a.stats.objects, a.stats.items), (a.db.quests.len(), a.db.npcs.len(), a.db.objects.len(), a.db.items.len()));
}

// ---------------------------------------------------------------------------
// The builder (formerly tests/questdb.test.js): spawn clustering, what the database keeps and drops,
// record layouts, faction derivation, caps, determinism and the size budget.
// ---------------------------------------------------------------------------

use std::collections::BTreeMap;

use forge_data::questdb::{quest_faction, Output, Val};
use forge_guide::cluster::cluster_points;
use forge_guide::js::{parse_json, V};
use serde_json::{json, Value};

const BUDGET: usize = 3 * 1024 * 1024; // bytes of Lua
									   // 30 yd per x %, 20 yd per y %.
const FRAME: &str = r#"{ "c": 0, "left": 1500, "right": -1500, "top": 500, "bottom": -1500 }"#;

fn v(j: &Value) -> V {
	parse_json(&j.to_string()).unwrap()
}

fn val(j: &Value) -> Val {
	match j {
		Value::Null => Val::Nil,
		Value::Number(n) => Val::Num(n.as_f64().unwrap()),
		Value::String(s) => Val::Str(s.clone()),
		Value::Array(a) => Val::List(a.iter().map(val).collect()),
		_ => panic!("no record value: {j}"),
	}
}

fn vals(j: Value) -> Vec<Val> {
	j.as_array().unwrap().iter().map(val).collect()
}

fn num(x: &Val) -> f64 {
	match x {
		Val::Num(n) => *n,
		_ => panic!("not a number: {x:?}"),
	}
}

// (x, y, r, n) of each cluster.
fn clusters(points: &Value, radius: f64, cap: f64) -> Vec<(f64, f64, f64, f64)> {
	let pts: Vec<V> = points.as_array().unwrap().iter().map(v).collect();
	cluster_points(&pts, &v(&serde_json::from_str(FRAME).unwrap()), radius, cap, 0.0).iter().map(|c| (c.get("x").num(), c.get("y").num(), c.get("r").num(), c.get("n").num())).collect()
}

fn fixture() -> PathBuf {
	root().join("tests/fixtures/questdb")
}

fn build_fix(o: &Options) -> Output {
	build(&fixture(), &root(), o).unwrap()
}

/// A copy of tests/fixtures/questdb with `edit` applied to its parsed JSON files (by file name).
fn data_with(name: &str, edit: impl FnOnce(&mut BTreeMap<String, Value>)) -> PathBuf {
	let dir = PathBuf::from(env!("CARGO_TARGET_TMPDIR")).join("questdb").join(name);
	let _ = std::fs::remove_dir_all(&dir);
	std::fs::create_dir_all(&dir).unwrap();
	let mut raw = BTreeMap::new();
	for e in std::fs::read_dir(fixture()).unwrap().flatten() {
		let p = e.path();
		if p.extension().is_some_and(|x| x == "json") {
			raw.insert(e.file_name().to_string_lossy().into_owned(), serde_json::from_str(&std::fs::read_to_string(&p).unwrap()).unwrap());
		}
	}
	edit(&mut raw);
	for (f, j) in raw {
		std::fs::write(dir.join(f), j.to_string()).unwrap();
	}
	dir
}

fn file<'a>(out: &'a Output, name: &str) -> &'a str {
	&out.files.iter().find(|(n, _)| n == name).unwrap_or_else(|| panic!("no {name}")).1
}

#[test]
fn spawn_points_cluster_into_centroids_with_a_radius_in_yards_largest_first() {
	let camp_a = json!([[40, 40], [40.5, 40.2], [41, 40], [40.2, 41]]);
	let camp_b = json!([[60, 60], [60.4, 60.4]]);
	let lone = json!([[90, 10]]);
	let cat = |parts: &[&Value]| Value::Array(parts.iter().flat_map(|p| p.as_array().unwrap().clone()).collect());
	let c = clusters(&cat(&[&camp_b, &lone, &camp_a]), 70.0, f64::INFINITY);
	assert_eq!(c.len(), 3);
	assert_eq!(c.iter().map(|c| c.3).collect::<Vec<_>>(), [4.0, 2.0, 1.0]);
	assert_eq!((c[0].0, c[0].1), (40.4, 40.3));
	// Farthest camp-A point (41, 40) from the emitted centre (40.4, 40.3): 0.6 % x 30 yd, 0.3 % x 20 yd.
	assert_eq!(c[0].2, (0.6f64 * 30.0).hypot(0.3 * 20.0).ceil());
	assert_eq!(c[2].2, 0.0);
	// Order of input never matters; the cap keeps the largest clusters.
	let mut rev = camp_a.as_array().unwrap().clone();
	rev.reverse();
	assert_eq!(clusters(&cat(&[&Value::Array(rev), &lone, &camp_b]), 70.0, f64::INFINITY), c);
	assert_eq!(clusters(&cat(&[&camp_a, &camp_b, &lone]), 70.0, 1.0).iter().map(|c| c.3).collect::<Vec<_>>(), [4.0]);
	// A wide radius merges the camps.
	assert_eq!(clusters(&cat(&[&camp_a, &camp_b]), 2000.0, f64::INFINITY).len(), 1);
}

#[test]
fn a_cluster_radius_covers_every_member_from_the_centre_as_emitted_rounded_to_0_1() {
	// The centroid 10.07 rounds to 10.1: 10.04 lies 0.06 % (1.8 yd) from it, not the 0.03 % from the centroid.
	assert_eq!(clusters(&json!([[10.04, 10], [10.1, 10]]), 70.0, f64::INFINITY), [(10.1, 10.0, 2.0, 2.0)]);
}

#[test]
fn quest_faction_comes_from_the_race_mask_else_from_the_givers() {
	let npcs = v(&json!({ "1": { "faction": "A" }, "2": { "faction": "H" }, "3": { "faction": "AH" } }));
	let f = |q: Value| quest_faction(&v(&q), &npcs);
	assert_eq!(f(json!({ "races": 77 })), Val::Num(1.0));
	assert_eq!(f(json!({ "races": 8 })), Val::Num(1.0));
	assert_eq!(f(json!({ "races": 178 })), Val::Num(2.0));
	assert_eq!(f(json!({ "races": 5 | 2 })), Val::Nil);
	assert_eq!(f(json!({ "races": null, "start": { "npc": [1] } })), Val::Num(1.0));
	assert_eq!(f(json!({ "races": null, "start": { "npc": [1, 2] } })), Val::Nil);
	assert_eq!(f(json!({ "races": null, "start": { "npc": [3] } })), Val::Nil);
	assert_eq!(f(json!({ "races": null, "start": { "npc": [], "object": [5] } })), Val::Nil);
}

#[test]
fn the_fixture_database_keeps_quest_related_entities_only_in_the_documented_layouts() {
	let out = build_fix(&Options::default());
	let db = &out.db;
	assert!(out.warnings.is_empty(), "{:?}", out.warnings);
	assert_eq!(out.stats.quests, 15);
	assert!(!db.npcs.contains_key(&9999), "NPC no quest references is dropped");
	assert!(!db.items.contains_key(&2000), "item no quest references is dropped");
	assert!(db.npcs.contains_key(&40) && db.objects.contains_key(&77), "drop sources of objective items are kept");
	assert_eq!(db.map_frames.keys().copied().collect::<Vec<_>>(), [1411, 1426, 1429], "only maps with points get frames");
	assert_eq!(db.quests[&7], vals(json!(["Kobold Camp Cleanup", 2, 1, null, null, 1, 197, 197, null, 783, null, [1, 6, 10], 1429, null, null, null, null, null, null])));
	assert_eq!(db.quests[&16][6], Val::Num(-31.0), "object givers are negative refs");
	assert_eq!(db.quests[&18][11], val(&json!([3, 55, null, 4, 1, null])));
	assert_eq!(db.quests[&18][13], val(&json!([1429, 0, 40.5, 70.3])));
	assert_eq!(db.quests[&19][9], val(&json!([33, 60])));
	assert_eq!(db.quests[&19][18], val(&json!([772, 900])), "the items the quest hands over, once each: sourceItem and requiredItems");
	assert_eq!(db.quests[&12][15], Val::Num(10.0), "holiday");
	assert_eq!(db.items[&772], vals(json!(["Large Candle", 2, 6, 40, 40, 20.5, 1, 77, 100, 253])));
	assert_eq!(db.npcs[&197], vals(json!(["Marshal McBride", 1429, 0, 1, 48.9, 41.6, 0])));
	let frames = file(&out, "MapFrames.lua");
	assert!(frames.contains("Polestar.RegisterMapFrames({ era = {"), "{frames}");
	assert!(frames.contains("[1429] = {bottom=-1500,c=0,left=1500,right=-1500,top=500},"), "{frames}");
	assert!(file(&out, "LICENSE-DATA.txt").contains("Fixture notice."));
}

#[test]
fn caps_limit_drop_sources() {
	let out = build_fix(&Options { max_droppers: 1, max_object_sources: 0, max_vendors: 0, ..Options::default() });
	assert_eq!(out.db.items[&772], vals(json!(["Large Candle", 1, 6, 40, 0])));
	assert!(!out.db.npcs.contains_key(&40), "a dropper past the cap is not pulled in");
}

#[test]
fn every_known_spawn_of_an_entity_lies_in_one_of_its_clusters_no_cap_and_the_points_the_data_cap_left_out_count() {
	// Kobold Vermin: its camps, plus ten lone spawns 240 yd apart that the data's cap left out.
	let more: Vec<(f64, f64)> = (0..10).map(|i| (10.0 + i as f64 * 8.0, 90.0)).collect();
	let mut pts = Vec::new();
	let dir = data_with("every-spawn", |raw| {
		let s = &mut raw.get_mut("npcs.json").unwrap()["6"]["spawns"]["1429"];
		s["more"] = json!(more.iter().map(|p| [p.0, p.1]).collect::<Vec<_>>());
		pts = s["pts"].as_array().unwrap().iter().map(|p| (p[0].as_f64().unwrap(), p[1].as_f64().unwrap())).collect();
	});
	let out = build(&dir, &root(), &Options::default()).unwrap();
	let rec = &out.db.npcs[&6];
	assert_eq!(rec[1], Val::Num(1429.0));
	let cl: Vec<(f64, f64, f64)> = (0..num(&rec[3]) as usize).map(|k| (num(&rec[4 + k * 3]), num(&rec[5 + k * 3]), num(&rec[6 + k * 3]))).collect();
	assert!(cl.len() > 8, "{} clusters: past the old cap of 8", cl.len());
	// The fixture's Elwynn frame: 30 yd per x percent, 20 yd per y percent.
	let inside = |&(x, y): &(f64, f64)| cl.iter().any(|c| ((x - c.0) * 30.0).hypot((y - c.1) * 20.0) <= c.2);
	let outside: Vec<_> = pts.iter().chain(&more).filter(|p| !inside(p)).collect();
	assert!(outside.is_empty(), "{outside:?}");
	for &(x, y) in &more {
		assert!(cl.iter().any(|c| c.0 == x && c.1 == y), "a marker at the lone spawn {x},{y}");
	}
}

#[test]
fn builds_are_byte_identical_and_the_toc_is_a_load_on_demand_polestar_addon() {
	let base = PathBuf::from(env!("CARGO_TARGET_TMPDIR")).join("questdb");
	let (a, b) = (base.join("identical-a"), base.join("identical-b"));
	for d in [&a, &b] {
		let _ = std::fs::remove_dir_all(d);
		forge_data::questdb::write(&build_fix(&Options::default()), d).unwrap();
	}
	let names = |d: &Path| {
		let mut n: Vec<String> = std::fs::read_dir(d).unwrap().map(|e| e.unwrap().file_name().to_string_lossy().into_owned()).collect();
		n.sort();
		n
	};
	assert_eq!(names(&a), names(&b));
	for n in names(&a) {
		assert_eq!(std::fs::read(a.join(&n)).unwrap(), std::fs::read(b.join(&n)).unwrap(), "{n}");
	}
	let toc = std::fs::read_to_string(a.join("Polestar_QuestDB.toc")).unwrap();
	for line in ["## Interface: 16001", "## LoadOnDemand: 1", "## Dependencies: Polestar"] {
		assert!(toc.lines().any(|l| l == line), "{line}\n{toc}");
	}
	// A stale data file from an older layout is removed on rebuild.
	std::fs::write(a.join("Old.lua"), "-- stale").unwrap();
	forge_data::questdb::write(&build_fix(&Options::default()), &a).unwrap();
	assert!(!a.join("Old.lua").exists());
	let db = build_fix(&Options::default()).db;
	assert_eq!((db.quests.len(), &db.quests[&7][0], db.npcs[&6].len()), (15, &Val::Str("Kobold Camp Cleanup".into()), 13));
}

#[test]
fn the_real_database_fits_the_size_budget_and_builds_deterministically() {
	let real = root().join("data/forever");
	if !real.join("quests.json").exists() {
		eprintln!("skipped: data/forever not built");
		return;
	}
	let one = build(&real, &root(), &Options::default()).unwrap();
	let two = build(&real, &root(), &Options::default()).unwrap();
	assert!(one.files == two.files, "deterministic");
	assert!(one.stats.lua_bytes <= BUDGET, "Lua {} bytes over budget", one.stats.lua_bytes);
	assert!(one.stats.quests > 4000);
	eprintln!("questdb real: Lua {:.2} MB, estimated memory {:.2} MB", one.stats.lua_bytes as f64 / 1048576.0, one.stats.memory_bytes as f64 / 1048576.0);
}

// Maps Forever added have no Era frame in map-frames.json, only a Forever one (formerly
// tests/dsl-forever-maps.test.js).
#[test]
fn quest_database_markers_on_a_forever_only_map_are_clustered_in_that_map_s_own_yards() {
	const ZEPHRAS: i64 = 2521;
	// Two Kobold Miner spawns 1.5% of Zephras Isle apart: 83 yd, two markers at the 70 yd
	// cluster radius (45 yd and one marker through the old 3000 x 2000 yd fallback).
	let dir = data_with("forever-only", |raw| {
		raw.get_mut("map-frames.json").unwrap()["forever"] = json!({ "2521": { "c": 2991, "left": 4231.25, "right": -1331.25, "top": 4956.25, "bottom": 1247.917 } });
		raw.get_mut("npcs.json").unwrap()["40"]["spawns"]["2521"] = json!({ "f": "l", "pts": [[40, 30], [41.5, 30]] });
	});
	let out = build(&dir, &root(), &Options::default()).unwrap();
	assert!(out.warnings.is_empty(), "{:?}", out.warnings);
	let rec = &out.db.npcs[&40];
	let at = rec.iter().position(|x| *x == Val::Num(ZEPHRAS as f64)).unwrap_or_else(|| panic!("{rec:?}"));
	assert!(at > 0, "{rec:?}");
	assert_eq!(rec[at + 1], Val::Num(1.0), "live-frame points");
	assert_eq!(rec[at + 2], Val::Num(2.0), "{rec:?}");
	assert!(!out.db.map_frames.contains_key(&ZEPHRAS), "no Era frame is emitted for it");
}
