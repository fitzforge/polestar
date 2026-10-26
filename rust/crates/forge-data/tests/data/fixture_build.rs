//! The data build on the synthetic fixture (rust/tests/fixtures/data): the CSV reader, map frames,
//! objective counts, spawn reduction, what the build makes of pfQuest, the client tables and the
//! recordings, meta.json, determinism, the pfQuest licence check, the web XP lookups' timeout, the
//! source cache offline, and the riding and training helpers.

use std::path::{Path, PathBuf};

use forge_data::jsv::Row;
use forge_data::{run, Options};
use serde_json::{json, Value};

pub fn fixture() -> PathBuf {
	std::fs::canonicalize(Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/fixtures/data")).unwrap()
}

pub fn repo() -> PathBuf {
	std::fs::canonicalize(Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..")).unwrap()
}

fn wago(t: &str) -> Vec<Row> {
	let f = fixture().join("sources/wago/1.15.9.11111").join(format!("{t}.csv"));
	forge_data::tables::parse_csv(&std::fs::read_to_string(f).unwrap()).unwrap()
}

/// The JS build's fixture options: offline, Era tables only, no QuestieDB, web XP or web zone lists.
pub fn options(recordings: Option<&Path>) -> Options {
	let mut o = Options::new(&repo());
	o.sources = fixture().join("sources");
	o.pfquest = Some(fixture().join("pfquest"));
	o.recordings = recordings.map(Path::to_path_buf).unwrap_or_else(|| fixture().join("recordings"));
	o.questie = None;
	o.forever = false;
	o.web_xp = false;
	o.web_zones = false;
	o.built_at = "2026-01-01T00:00:00.000Z".into();
	o
}

pub struct Built {
	pub out: forge_data::Output,
}

impl Built {
	pub fn read(&self, name: &str) -> Value {
		let text = &self.out.files.iter().find(|(n, _)| n == name).unwrap_or_else(|| panic!("no {name}.json")).1;
		serde_json::from_str(text).unwrap()
	}
	pub fn meta(&self) -> Value {
		self.read("meta")
	}
}

pub fn build(o: &Options) -> Built {
	Built { out: run(o, &|_| {}).unwrap() }
}

fn no_recordings() -> PathBuf {
	std::env::temp_dir().join("forge-data-no-recordings")
}

fn to_world(f: &forge_data::maps::Frame, x: f64, y: f64) -> (f64, f64) {
	(f.top + ((f.bottom - f.top) * y) / 100.0, f.left + ((f.right - f.left) * x) / 100.0)
}

#[test]
fn csv_quoted_fields_doubled_quotes_newlines_crlf_bom_and_bad_widths() {
	let rows = forge_data::tables::parse_csv("\u{feff}ID,Name,Note\r\n1,\"Hills, \"\"Test\"\"\",\"two\nlines\"\r\n2,Plain,\n").unwrap();
	assert_eq!(rows.len(), 2);
	assert_eq!((rows[0]["ID"].as_str(), rows[0]["Name"].as_str(), rows[0]["Note"].as_str()), ("1", "Hills, \"Test\"", "two\nlines"));
	assert_eq!((rows[1]["Name"].as_str(), rows[1]["Note"].as_str()), ("Plain", ""));
	assert!(forge_data::tables::parse_csv("A,B\n1,2,3\n").unwrap_err().contains("row 2 has 3 fields"));
	assert!(forge_data::tables::parse_csv("A,B\n\"open,2\n").unwrap_err().contains("unterminated"));
}

#[test]
fn map_frames_orientation_insets_zones_and_area_mapping() {
	use forge_data::maps::{build_maps, frame_from_assignment, Frame};
	let asg = wago("UiMapAssignment");
	let elwynn = frame_from_assignment(asg.iter().find(|a| a["ID"] == "46739").unwrap()).unwrap();
	assert_eq!(elwynn, Frame { c: 0.0, left: 1535.417, right: -1935.417, top: -7939.583, bottom: -10254.166 });
	let (nw, se) = (to_world(&elwynn, 0.0, 0.0), to_world(&elwynn, 100.0, 100.0));
	assert!(nw.0 > se.0 && nw.1 > se.1, "map (0,0) is the north-west corner");
	assert!(((elwynn.left - elwynn.right) / (elwynn.top - elwynn.bottom) - 1.5).abs() < 0.002);
	let inset = frame_from_assignment(asg.iter().find(|a| a["UiMapID"] == "2000").unwrap()).unwrap();
	assert_eq!(inset, Frame { c: 0.0, left: 875.0, right: -625.0, top: 500.0, bottom: -500.0 }, "UiMin/UiMax extrapolated");
	assert_eq!(to_world(&inset, 25.0, 50.0), (0.0, 500.0));
	assert_eq!(to_world(&inset, 75.0, 100.0), (-500.0, -250.0));

	let maps = build_maps(&wago("UiMap"), &asg, &wago("AreaTable"));
	let zone = |id: i64| maps.zones.iter().find(|z| z.id == id).unwrap();
	assert_eq!((zone(1429).name.as_str(), zone(1429).area_id, zone(1429).parent, zone(1429).kind), ("Elwynn Forest", Some(12), Some(1415), 3.0));
	assert_eq!(zone(2000).name, "Inset, \"Test\"");
	assert_eq!(zone(947).parent, None);
	assert!(!maps.frames.contains_key(&947), "Azeroth spans two continents");
	assert!(maps.warnings.iter().any(|w| w.contains("uiMap 947: spans 2 continents")));
	assert_eq!(maps.frames[&1429].bottom, -10254.166, "the full assignment wins over the quarter one");
	assert!(!maps.warnings.iter().any(|w| w.contains("1429")));
	let (sw, el) = (maps.frames[&1453], maps.frames[&1429]);
	assert!(sw.left <= el.left && sw.right >= el.right && sw.top <= el.top && sw.bottom >= el.bottom);
	assert_eq!(maps.resolve_area(12.0), Some(1429));
	assert_eq!(maps.resolve_area(87.0), Some(1429), "subzone Goldshire walks up to Elwynn");
	assert_eq!(maps.resolve_area(1519.0), Some(1453));
	assert_eq!(maps.resolve_area(9999.0), None, "area without a UiMap");
	assert_eq!(maps.resolve_area(123456.0), None);

	// Implausible frames are rejected; square taxi maps are not.
	let row = |pairs: &[(&str, String)]| -> Row { pairs.iter().map(|(k, v)| (k.to_string(), v.clone())).collect() };
	let ui = |id: i64, system: i64| row(&[("Name_lang", format!("M{id}")), ("ID", id.to_string()), ("ParentUiMapID", "0".into()), ("System", system.to_string()), ("Type", "2".into())]);
	let a = |id: i64| {
		let mut r = row(&[("ID", (id + 10).to_string()), ("UiMapID", id.to_string()), ("OrderIndex", "0".into()), ("MapID", "0".into()), ("AreaID", "0".into())]);
		for (k, v) in [("UiMin_0", "0"), ("UiMin_1", "0"), ("UiMax_0", "1"), ("UiMax_1", "1"), ("Region_0", "-1000"), ("Region_1", "-1000"), ("Region_3", "1000"), ("Region_4", "1000")] {
			r.insert(k.into(), v.into());
		}
		r
	};
	let m = build_maps(&[ui(1, 0), ui(2, 1)], &[a(1), a(2)], &[]);
	assert!(!m.frames.contains_key(&1));
	assert!(m.warnings.iter().any(|w| w.contains("uiMap 1: aspect 1.000")));
	assert_eq!(m.frames[&2], Frame { c: 0.0, left: 1000.0, right: -1000.0, top: 1000.0, bottom: -1000.0 });
}

#[test]
fn objective_counts_from_the_text_never_guessed() {
	let cases: [(&str, &str, &str, &[&str], Option<f64>); 14] = [
		("Kill 10 Kobold Vermin, then return to Marshal McBride.", "Kobold Vermin", "", &[], Some(10.0)),
		("bring him 7 Plainstrider Feathers and 7 pieces of Plainstrider Meat.", "Plainstrider Feather", "", &[], Some(7.0)),
		("bring him 7 Plainstrider Feathers and 7 pieces of Plainstrider Meat.", "Plainstrider Meat", "", &[], Some(7.0)),
		("Bring six Golden Scale Bracers to Hank.", "Golden Scale Bracers", "", &[], Some(6.0)),
		("Kill 5 Mangy Wolves.", "Mangy Wolf", "", &[], Some(5.0)),
		("Bring 2 Idols of Strife and 5 Bone Scarabs.", "Idol of Strife", "", &[], Some(2.0)),
		("Kill 7 Tidehunters, 7 Warriors and 7 Coastrunners.", "Murloc Tidehunter", "", &["Murloc Warrior"], Some(7.0)),
		("Kill 8 Dragonmaw Raiders and a Dragonmaw Battlemaster.", "Dragonmaw Battlemaster", "kill", &[], Some(1.0)),
		("Retrieve the Warchief's Orders.", "Warchief's Orders", "item", &[], Some(1.0)),
		("Kill Rot Hide Graverobbers and Rot Hide Mongrels.", "Rot Hide Graverobber", "kill", &[], None),
		("Use Morbent's Bane on Morbent Fel, kill Morbent Fel.", "Morbent Fel", "kill", &[], None),
		("Kill the Murloc Oracle.", "Murloc Oracle", "kill", &[], None),
		("Gather Lurker Venom.", "Lurker Venom", "item", &[], None),
		("Kill 10 Wolves.", "Wolf Rider", "", &[], None),
	];
	for (text, name, kind, others, want) in cases {
		let others: Vec<String> = others.iter().map(|s| s.to_string()).collect();
		assert_eq!(forge_data::objectives::parse_count(Some(text), Some(name), kind, &others), want, "{name} in {text:?}");
	}
	let gnoll = vec!["Gnoll Warrior".to_string()];
	assert_eq!(forge_data::objectives::parse_count(Some("Kill 7 Warriors."), Some("Murloc Warrior"), "", &gnoll), None, "a shared trailing name part is no alias");
	assert!(forge_data::objectives::parse_progress_text("Explore the ruins").is_none());
}

#[test]
fn spawn_reduction_rounds_dedupes_caps_evenly_and_loses_no_spawn() {
	use forge_data::spawns::{reduce_spawns, SpawnOptions, DEFAULTS};
	let r = reduce_spawns(&[[10.0, 10.0], [10.05, 10.02], [10.0, 10.0], [70.004, 20.006], [101.0, 5.0], [-1.0, 5.0], [f64::NAN, 1.0]], DEFAULTS);
	assert_eq!((r.pts, r.more), (vec![[10.0, 10.0], [70.0, 20.01]], vec![]));
	let mut grid = Vec::new();
	for i in 0..10 {
		for j in 0..6 {
			grid.push([20.0 + i as f64 * 5.0, 30.0 + j as f64 * 5.0]);
		}
	}
	let cap = |n| SpawnOptions { cap: n, ..DEFAULTS };
	let few = reduce_spawns(&grid[..24], cap(24));
	assert_eq!((few.pts, few.more.len()), (grid[..24].to_vec(), 0), "few points are all kept");
	let r = reduce_spawns(&grid, cap(12));
	assert_eq!(r.pts.len(), 12);
	let d = |a: &[f64; 2], b: &[f64; 2]| (a[0] - b[0]).hypot(a[1] - b[1]);
	let far = grid.iter().map(|p| r.pts.iter().map(|q| d(p, q)).fold(f64::INFINITY, f64::min)).fold(0.0, f64::max);
	assert!(far <= 10.5, "the kept points cover the area");
	let mut gap = f64::INFINITY;
	for a in 0..r.pts.len() {
		for b in a + 1..r.pts.len() {
			gap = gap.min(d(&r.pts[a], &r.pts[b]));
		}
	}
	assert!(gap >= 10.0, "min gap {gap}");
	assert_eq!(r.more.len(), grid.len() - 12);
	let mut all: Vec<[f64; 2]> = r.pts.iter().chain(&r.more).copied().collect();
	all.sort_by(|a, b| a.partial_cmp(b).unwrap());
	assert_eq!(all, grid, "pts and more hold every point once");
	let mut sorted = r.more.clone();
	sorted.sort_by(|a, b| a.partial_cmp(b).unwrap());
	assert_eq!(r.more, sorted, "more is sorted by x then y");
	let rev: Vec<[f64; 2]> = grid.iter().rev().copied().collect();
	let r2 = reduce_spawns(&rev, cap(12));
	assert_eq!((r2.pts, r2.more), (r.pts, r.more), "independent of input order");
}

#[test]
fn quests_npcs_objects_items_zones_and_factions_from_pfquest_and_the_era_tables() {
	let b = build(&options(Some(&no_recordings())));
	let q = b.read("quests");
	let ids: Vec<&String> = q.as_object().unwrap().keys().collect();
	assert_eq!(ids, ["100", "101", "102", "104"], "untitled quest 103 is skipped");
	assert_eq!(
		q["101"],
		json!({
			"id": 101, "title": "Wolf Trouble", "level": 3, "minLevel": 2, "races": 77, "classes": 1,
			"start": { "npc": [2], "object": [], "item": [] }, "end": { "npc": [2], "object": [] },
			"pre": [100], "excl": [102], "next": 104,
			"objectives": [
				{ "type": "kill", "id": 3, "count": 10, "text": "Fixture Wolf" },
				{ "type": "kill", "id": 4, "count": 4, "text": "Fixture Wolf Alpha" },
				{ "type": "item", "id": 50, "count": 3, "text": "Wolf Pelt" }
			],
			"objectiveText": "Bring 3 pieces of Wolf Pelt, and kill 10 Fixture Wolves and 4 Fixture Wolf Alphas for Alice.",
			"zone": 1429, "xp": null, "skill": null, "event": null, "source": ["pfquest"]
		})
	);
	assert_eq!(q["100"]["races"], Value::Null, "all-races mask means unrestricted");
	assert_eq!(q["100"]["next"], Value::Null, "two follow-ups: no single next");
	assert_eq!((&q["102"]["classes"], &q["102"]["skill"], &q["102"]["event"], &q["102"]["zone"]), (&Value::Null, &json!(186), &json!(12), &json!(1429)));
	assert_eq!(
		q["102"]["objectives"],
		json!([{ "type": "object", "id": 500, "count": null, "text": "Fixture Altar" }, { "type": "event", "id": 7, "count": null, "text": null, "map": 1429, "f": "e", "x": 61.2, "y": 52.9 }])
	);
	assert_eq!(q["104"]["start"], json!({ "npc": [], "object": [], "item": [53] }));
	assert_eq!(q["104"]["objectives"], json!([{ "type": "item", "id": 51, "count": 1, "text": "Sealed Letter" }]));

	let npcs = b.read("npcs");
	assert_eq!(npcs["1"], json!({ "id": 1, "name": "Bob", "level": 20, "faction": "A", "roles": ["flightmaster"], "spawns": { "1429": { "f": "e", "pts": [[48.9, 41.6]] } } }));
	assert_eq!(
		npcs["2"],
		json!({ "id": 2, "name": "Alice", "level": 5, "levelMax": 6, "rank": 1, "faction": "AH", "roles": ["vendor"], "spawns": { "1429": { "f": "e", "pts": [[42.1, 65.9]] }, "1453": { "f": "e", "pts": [[50, 50]] } } })
	);
	assert_eq!(npcs["3"]["spawns"]["1429"]["pts"].as_array().unwrap().len(), 24, "60 spawns capped at 24");
	assert_eq!(npcs["4"]["spawns"], json!({ "1429": { "f": "e", "pts": [[10, 10], [70, 20.01]] } }));
	assert_eq!(npcs["5"]["spawns"], json!({}), "spawns in an area without a UiMap are dropped");
	assert_eq!(b.meta()["counts"]["unmappedSpawnPoints"], 1);
	let objects = b.read("objects");
	assert_eq!(objects["500"], json!({ "id": 500, "name": "Fixture Altar", "spawns": { "1429": { "f": "e", "pts": [[30.12, 40.99]] } } }));
	assert_eq!(objects["600"]["roles"], json!(["herb"]));
	let items = b.read("items");
	assert_eq!(items["50"], json!({ "id": 50, "name": "Wolf Pelt", "drops": { "npc": { "3": 45.5, "4": 80, "5": 2.5 }, "object": { "600": 2.5 } }, "vendors": [] }));
	assert_eq!(items["52"]["vendors"], json!([1, 2]), "vendor ids 1..n stay ids");
	assert_eq!(items["53"]["drops"], json!({ "npc": {}, "object": { "500": 100 } }));
	assert_eq!(b.read("zones")["1453"]["name"], "Stormwind City");
	let frames: Vec<String> = b.read("map-frames")["era"].as_object().unwrap().keys().cloned().collect();
	assert_eq!(frames, ["1415", "1429", "1453", "2000"]);

	let f = b.read("factions");
	assert!(f.get("1").is_none(), "player template factions are not reputations");
	let fids: Vec<&String> = f.as_object().unwrap().keys().collect();
	assert_eq!(fids, ["21", "46", "67", "69", "72", "76", "169", "469", "529", "576", "589", "609", "630", "889", "890", "891", "892", "2586"]);
	assert_eq!(f["72"], json!({ "id": 72, "name": "Stormwind", "side": "Alliance", "parent": 469, "source": ["blizzard"] }));
	assert_eq!(f["76"], json!({ "id": 76, "name": "Orgrimmar", "side": "Horde", "parent": 67, "source": ["blizzard"] }));
	assert_eq!(f["469"], json!({ "id": 469, "name": "Alliance", "side": "Alliance", "parent": null, "source": ["blizzard"] }));
	assert_eq!(f["890"]["side"], "Alliance");
	assert_eq!(f["889"]["side"], "Horde");
	assert_eq!((&f["589"]["side"], &f["630"]["side"], &f["2586"]["side"]), (&json!("Alliance"), &json!("Horde"), &json!("Alliance")), "sides from one-sided Hated locks");
	for id in ["529", "576", "609"] {
		assert_eq!(f[id]["side"], Value::Null, "{id} is neutral");
	}
	assert_eq!(f["21"], json!({ "id": 21, "name": "Booty Bay", "side": null, "parent": 169, "source": ["blizzard"] }));
	assert_eq!(f["46"]["name"], "Blacksmithing - Armorsmithing", "names are trimmed");
}

#[test]
fn recordings_override_era_data_add_factions_and_recorder_only_records_with_full_xp() {
	let b = build(&options(None));
	let f = b.read("factions");
	assert_eq!(f["529"], json!({ "id": 529, "name": "The Argent Dawn", "side": null, "parent": null, "source": ["blizzard", "recorder"] }));
	assert_eq!(f["2587"]["source"], json!(["recorder"]));
	assert_eq!(f["72"], json!({ "id": 72, "name": "Stormwind", "side": "Alliance", "parent": 469, "source": ["blizzard", "recorder"] }));
	assert_eq!(f["469"]["parent"], Value::Null, "a recorded parent that would form a cycle is ignored");
	assert_eq!(f["2700"], json!({ "id": 2700, "name": "Skyborne Accord", "side": "Alliance", "parent": 469, "source": ["recorder"] }));
	assert_eq!(f["2702"], json!({ "id": 2702, "name": "Fixture Horde Child", "side": "Horde", "parent": 2701, "source": ["recorder"] }));
	assert_eq!(f["2703"]["parent"], Value::Null, "unknown parent dropped");
	assert!(f.get("0").is_none());
	let m = b.meta();
	assert_eq!((&m["counts"]["recorderOnlyFactions"], &m["counts"]["factions"]), (&json!(5), &json!(23)));

	let q = b.read("quests");
	let npcs = b.read("npcs");
	assert_eq!(npcs["1"]["spawns"], json!({ "1429": { "f": "l", "pts": [[47.5, 40.25]] } }));
	assert_eq!(npcs["2"]["spawns"], json!({ "1429": { "f": "l", "pts": [[48, 41]] }, "1453": { "f": "e", "pts": [[50, 50]] } }));
	assert_eq!((&q["100"]["title"], &q["100"]["level"], &q["100"]["xp"], &q["100"]["xpSamples"]), (&json!("Fixture Calling (Forever)"), &json!(2), &json!(40), &json!(2)));
	assert_eq!(q["100"]["source"], json!(["pfquest", "recorder", "recorder:xp-turnin"]));
	assert_eq!(q["101"]["objectives"][0], json!({ "type": "kill", "id": 3, "count": 12, "text": "Fixture Wolf" }), "the recorded count wins");
	assert_eq!(
		q["9001"],
		json!({
			"id": 9001, "title": "Skyborne Welcome", "level": 1, "minLevel": null, "races": null, "classes": null,
			"start": { "npc": [70001], "object": [], "item": [] }, "end": { "npc": [70001], "object": [] },
			"pre": [], "excl": [], "next": null, "objectives": [{ "type": "item", "id": 80001, "count": 5, "text": "Sky Shard" }],
			"objectiveText": null, "zone": 2500, "xp": 100, "xpSamples": 1, "skill": null, "event": null, "source": ["recorder", "recorder:xp-turnin"]
		})
	);
	assert_eq!(npcs["70001"], json!({ "id": 70001, "name": "Sky Warden", "level": null, "faction": null, "spawns": { "2500": { "f": "l", "pts": [[50, 50]] } } }));
	let keys: Vec<&String> = npcs["70002"].as_object().unwrap().keys().collect();
	assert_eq!(keys, ["id", "name", "level", "faction", "roles", "spawns"]);
	assert_eq!(b.read("objects")["500"]["spawns"], json!({ "1429": { "f": "l", "pts": [[31.5, 41.25]] } }));
	assert_eq!((&q["102"]["xp"], &q["102"]["start"]["object"]), (&json!(300), &json!([500])));
	assert_eq!(b.read("items")["80001"], json!({ "id": 80001, "name": "Sky Shard", "drops": { "npc": {}, "object": {} }, "vendors": [] }));
	assert_eq!(b.read("zones")["2500"], json!({ "id": 2500, "name": "Skyreach", "areaId": null, "parent": 1415, "type": 3 }));
	assert_eq!((&m["counts"]["recorderOnlyQuests"], &m["counts"]["recordings"]), (&json!(5), &json!(4)));

	// Quest XP is the full reward, never an out-levelled one.
	let xp = |id: &str| (q[id]["xp"].clone(), q[id].get("xpSamples").cloned(), q[id]["source"].clone());
	assert_eq!(xp("9101"), (json!(800), Some(json!(1)), json!(["recorder", "recorder:xp-turnin"])));
	assert_eq!(xp("9102"), (Value::Null, None, json!(["recorder"])), "only out-levelled turn-ins: no XP");
	assert_eq!(xp("9103"), (json!(820), Some(json!(1)), json!(["recorder", "recorder:xp-base"])));
	assert_eq!(xp("9104"), (json!(760), Some(json!(1)), json!(["recorder", "recorder:xp-log"])));
	let keys: Vec<&String> = q["9101"].as_object().unwrap().keys().skip(14).take(3).collect();
	assert_eq!(keys, ["xp", "xpSamples", "skill"]);

	// meta.json: sources, licences, counts.
	assert_eq!(m["builtAt"], "2026-01-01T00:00:00.000Z");
	let pf = m["sources"].as_array().unwrap().iter().find(|s| s["name"] == "pfQuest").unwrap();
	assert_eq!((&pf["license"], &pf["copyright"]), (&json!("MIT"), &json!("Copyright (c) 2020 Fixture Author")));
	assert!(pf["notice"].as_str().unwrap().starts_with("MIT License"));
	assert!(m["sources"][1]["revision"].as_str().unwrap().contains("wow_classic_era 1.15.9.11111"));
	let c = &m["counts"];
	assert_eq!([&c["quests"], &c["npcs"], &c["objects"], &c["items"], &c["mapFrames"]], [&json!(9), &json!(7), &json!(2), &json!(5), &json!(4)]);
}

#[test]
fn meta_names_the_web_xp_cache_with_forward_slashes() {
	let root = common_scratch("forge-data-webxp-meta");
	let sources = root.join("data").join("sources");
	crate::common::copy_tree(&fixture().join("sources"), &sources);
	std::fs::create_dir_all(sources.join("webxp")).unwrap();
	std::fs::write(sources.join("webxp/quest-xp.json"), r#"{"101":{"wft":450,"fc":null}}"#).unwrap();
	let mut o = options(None);
	o.root = root.clone();
	o.corrections = repo().join("forever-db/corrections");
	o.sources = sources;
	o.web_xp = true;
	let b = build(&o);
	let m = b.meta();
	let xp = m["sources"].as_array().unwrap().iter().find(|s| s["name"].as_str().unwrap().starts_with("Quest XP")).unwrap();
	assert_eq!(xp["revision"], "1 quests; cache data/sources/webxp/quest-xp.json");
	assert_eq!(b.read("quests")["101"]["xp"], 450);
}

fn common_scratch(name: &str) -> PathBuf {
	crate::common::scratch(name)
}

#[test]
fn without_the_private_overlay_one_plain_line_and_a_warning_when_other_private_sources_are_there() {
	let line = "private corrections: none found (public corrections only)";
	let root = common_scratch("forge-data-private");
	let mut o = options(None);
	o.root = root.clone();
	o.corrections = repo().join("forever-db/corrections");
	o.corrections_private = Some(root.join("data/local/corrections-private.json"));
	let logged = std::cell::RefCell::new(Vec::new());
	let out = run(&o, &|m| logged.borrow_mut().push(m.to_string())).unwrap();
	assert_eq!(logged.borrow().iter().filter(|m| m.starts_with("private corrections")).collect::<Vec<_>>(), [line]);
	assert!(!out.warnings.iter().any(|w| w == line));
	assert_eq!(build(&o).meta()["counts"]["correctionsPrivate"], 0);
	std::fs::create_dir_all(root.join("data/local/kb")).unwrap();
	assert_eq!(run(&o, &|_| {}).unwrap().warnings.iter().filter(|w| w.starts_with("private corrections")).collect::<Vec<_>>(), [line], "the local KB is here, the overlay not");
	o.corrections_private = None;
	assert!(!run(&o, &|_| {}).unwrap().warnings.iter().any(|w| w == line), "turned off on purpose: no warning");
}

#[test]
fn output_is_deterministic_and_names_its_files() {
	let a = build(&options(None)).out;
	let b = build(&options(None)).out;
	assert_eq!(a.files, b.files);
	let mut names: Vec<&str> = a.files.iter().map(|(n, _)| n.as_str()).collect();
	names.sort();
	assert_eq!(names, ["factions", "instances", "items", "map-frames", "meta", "npcs", "objects", "quests", "zones"]);
}

#[test]
fn refuses_a_pfquest_checkout_that_is_not_mit_licensed() {
	let d = common_scratch("forge-data-licence");
	std::fs::write(d.join("LICENSE"), "All rights reserved.\n").unwrap();
	assert!(forge_data::pfquest::check_license(&d).err().unwrap().contains("not the MIT license"));
	assert_eq!(forge_data::pfquest::check_license(&fixture().join("pfquest")).unwrap().license, "MIT");
}

#[test]
fn a_site_that_never_answers_fails_its_lookup_instead_of_stalling() {
	let l = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
	let url = format!("http://{}/sitemap-0.xml", l.local_addr().unwrap());
	let held = std::thread::spawn(move || {
		let c = l.accept();
		std::thread::sleep(std::time::Duration::from_secs(3));
		drop(c);
	});
	let t = std::time::Instant::now();
	let http = forge_data::sources::Http::new(std::time::Duration::from_millis(300), "forge-test");
	assert!(http.get(&url, 1024).is_err());
	assert!(t.elapsed() < std::time::Duration::from_secs(2), "{:?}", t.elapsed());
	held.join().unwrap();
}

#[test]
fn the_source_cache_works_offline_once_filled_and_fails_clearly_without_it() {
	// A cached table is read as it is, whatever the network (wago_table never fetches it again).
	let any = forge_data::sources::Http::new(std::time::Duration::from_millis(100), "forge-test");
	assert!(!forge_data::sources::wago_table(Some(&any), &fixture().join("sources"), "1.15.9.11111", "UiMap", &|_| panic!("no fetch")).unwrap());
	let mut o = options(None);
	o.sources = common_scratch("forge-data-nocache");
	let e = run(&o, &|_| {}).err().unwrap();
	assert!(e.contains("--offline: no cached wago.tools build"), "{e}");
}

#[test]
fn mount_vendors_cheapest_mount_per_vendor_at_the_level() {
	let rows = |v: &[&[(&str, &str)]]| -> Vec<Row> { v.iter().map(|r| r.iter().map(|(k, x)| (k.to_string(), x.to_string())).collect()).collect() };
	let items = rows(&[
		&[("ID", "5665"), ("ClassID", "15"), ("SubclassID", "5")],
		&[("ID", "1132"), ("ClassID", "15"), ("SubclassID", "5")],
		&[("ID", "18796"), ("ClassID", "15"), ("SubclassID", "5")],
		&[("ID", "999"), ("ClassID", "4"), ("SubclassID", "0")],
	]);
	let sparse = rows(&[
		&[("ID", "5665"), ("BuyPrice", "200000"), ("RequiredLevel", "40")],
		&[("ID", "1132"), ("BuyPrice", "200000"), ("RequiredLevel", "40")],
		&[("ID", "18796"), ("BuyPrice", "1000000"), ("RequiredLevel", "60")],
		&[("ID", "999"), ("BuyPrice", "100"), ("RequiredLevel", "40")],
	]);
	let ours = forge_guide::js::parse_json(r#"{"5665":{"vendors":[3362]},"1132":{"vendors":[3362]},"18796":{"vendors":[3362]},"999":{"vendors":[3362]}}"#).unwrap();
	let ours = ours.as_obj().unwrap();
	let s = |o| forge_guide::js::stringify(&forge_guide::js::V::Obj(o), None);
	assert_eq!(s(forge_data::build::mount_vendors(&items, &sparse, ours, 40.0)), r#"{"3362":[200000,1132]}"#, "the lower item id on a tie");
	assert_eq!(s(forge_data::build::mount_vendors(&items, &sparse, ours, 60.0)), r#"{"3362":[1000000,18796]}"#);
}

#[test]
fn named_spells_rank_by_level_among_same_named_spells() {
	let rows: Vec<Row> = [("772", "Rend"), ("6546", "Rend"), ("284", "Heroic Strike")]
		.iter()
		.map(|(i, n)| [("ID".to_string(), i.to_string()), ("Name_lang".to_string(), n.to_string())].into_iter().collect())
		.collect();
	let spells = forge_guide::js::parse_json(r#"{"WARRIOR":{"10":[[6546,600]],"4":[[772,100]],"8":[[284,200],[9,5]]}}"#).unwrap();
	let out = forge_data::build::named_spells(&spells, &rows);
	assert_eq!(forge_guide::js::stringify(&out.get("WARRIOR"), None), r#"{"4":[[772,100,"Rend",1]],"8":[[9,5,null,0],[284,200,"Heroic Strike",1]],"10":[[6546,600,"Rend",2]]}"#);
}
