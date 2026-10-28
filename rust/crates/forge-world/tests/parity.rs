//! World parity with the JS builder (tools/lib/sim/world.js), byte for byte, and of the atlas and the
//! availability rules with the JS judge (tools/lib/judge/atlas.js, rules.js).
//!
//! - synthetic: tests/fixtures/sim/synthetic.js's two data sets, each faction; the reference
//!   worlds come from JS buildWorld (tests/js/gen-synthetic.js).
//! - slice: both factions built from the committed mini repository rust/tests/golden/world/root (a
//!   shareable data/forever slice: Durotar, the Barrens, Orgrimmar, Elwynn Forest, Stormwind; no
//!   walking grid) against the JS worlds, atlas and rule dumps in rust/tests/golden/world/expected
//!   (gzipped; made by rust/tests/golden/world/regen.js, see its README).

use forge_core::Faction;
use forge_world::data::{GameData, Source};
use forge_world::{build_world, BuildOptions, FloorCache, NoFloors, World};
use std::path::PathBuf;

struct Fixture(PathBuf);

impl Source for Fixture {
	fn read(&self, root: &str, name: &str) -> Option<Vec<u8>> {
		(root == "data").then(|| std::fs::read(self.0.join(name)).ok()).flatten()
	}
}

fn manifest() -> PathBuf {
	PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

#[test]
fn synthetic_worlds_equal_js() {
	for set in ["base", "rules"] {
		let dir = manifest().join("tests/fixtures/synthetic").join(set);
		let d = GameData::from_source(&Fixture(dir.clone())).expect("fixture data");
		let starts: serde_json::Value = serde_json::from_slice(&std::fs::read(dir.join("starts.json")).unwrap()).unwrap();
		for f in Faction::BOTH {
			let mut opts = BuildOptions::new(f);
			for (race, s) in starts.as_object().unwrap() {
				opts.extra_starts.push((race.clone(), s["zone"].as_str().unwrap().into(), s["quest"].as_u64().unwrap() as u32));
			}
			let (w, _) = build_world(&d, &opts, &NoFloors).expect("build");
			let js = std::fs::read_to_string(dir.join(format!("world-{}.json", f.lower()))).unwrap();
			assert_eq!(w.to_json(), js, "{set} {f}");
		}
	}
}

fn repo() -> PathBuf {
	manifest().join("../../..").canonicalize().unwrap()
}

/// The golden mini repository (data slice, source slices, rules.json).
fn golden_root() -> PathBuf {
	repo().join("rust/tests/golden/world/root")
}

/// A gzipped JS reference of rust/tests/golden/world/expected.
fn expected(name: &str) -> String {
	use std::io::Read;
	let file = repo().join("rust/tests/golden/world/expected").join(format!("{name}.gz"));
	let mut text = String::new();
	flate2::read::GzDecoder::new(std::fs::File::open(&file).unwrap_or_else(|e| panic!("{}: {e}", file.display()))).read_to_string(&mut text).unwrap();
	text
}

fn slice_world(f: Faction) -> (World, forge_world::data::GameData) {
	assert!(std::env::var_os("POLESTAR_GRID").is_none(), "unset POLESTAR_GRID: the golden worlds were built without a walking grid");
	World::load_with(&golden_root(), f, &NoFloors).expect("slice world")
}

#[test]
fn slice_worlds_equal_js() {
	for f in Faction::BOTH {
		let (w, _) = slice_world(f);
		assert!(w.to_json() == expected(&format!("world-{}.json", f.lower())), "{f}: the Rust world differs from the golden");
	}
}

/// The JS atlas dump (regen.js, as the removed tests/js/jsatlas.js did), from the Rust atlas.
fn atlas_dump(a: &forge_world::Atlas) -> serde_json::Value {
	use serde_json::json;
	let sz = |s: &Option<forge_world::atlas::Subzone>| s.as_ref().map(|s| json!({ "id": s.id, "name": s.name, "zoneId": s.zone_id, "zone": s.zone }));
	let key = |n: usize| a.nodes[n].key.clone();
	json!({
		"areas": a.areas.iter().map(|x| json!({ "id": x.id, "map": x.map, "c": x.c, "name": x.name, "subzone": sz(&x.subzone), "wx": x.wx, "wy": x.wy, "n": x.n, "hub": x.hub,
			"nodes": x.nodes.iter().map(|&n| key(n)).collect::<Vec<_>>(), "give": x.give, "end": x.end,
			"obj": x.obj.iter().map(|(q, l)| json!([q, l.iter().map(|o| json!([o.oi, key(o.node), o.n])).collect::<Vec<_>>()])).collect::<Vec<_>>() })).collect::<Vec<_>>(),
		"zones": a.zones.values().map(|z| json!({ "map": z.map, "areas": z.areas.iter().map(|&i| a.areas[i].id.clone()).collect::<Vec<_>>(),
			"hubs": z.hubs.iter().map(|h| json!({ "name": h.name, "areas": h.areas, "givers": h.givers, "quests": h.quests })).collect::<Vec<_>>() })).collect::<Vec<_>>(),
		"roles": a.roles.iter().map(|(q, r)| json!([q, r.give.iter().map(|&n| key(n)).collect::<Vec<_>>(), r.end.iter().map(|&n| key(n)).collect::<Vec<_>>(),
			r.obj.iter().map(|l| l.iter().map(|&n| key(n)).collect::<Vec<_>>()).collect::<Vec<_>>()])).collect::<Vec<_>>(),
		"nodes": a.nodes.iter().map(|n| json!([n.key, n.name, n.map, n.c, n.wx, n.wy, n.n, n.pts.len()])).collect::<Vec<_>>(),
	})
}

fn sort_zones(v: &mut serde_json::Value) {
	// JS zones are in first-area order; Rust keeps a BTreeMap: compare as sets by map.
	if let Some(z) = v.get_mut("zones").and_then(|z| z.as_array_mut()) {
		z.sort_by_key(|x| x["map"].as_u64());
	}
}

#[test]
fn atlas_equals_js() {
	let root = golden_root();
	let src = forge_world::data::DirSource::repo(&root);
	let d = GameData::from_source(&src).expect("data");
	let sub = forge_world::atlas::GridSubzones::open(&root.join("data/local/nav4"), &root.join("data/sources"));
	for f in Faction::BOTH {
		let mut js: serde_json::Value = serde_json::from_str(&expected(&format!("atlas-{}.json", f.lower()))).unwrap();
		let a = forge_world::Atlas::build_for(f, &d, Some(&sub), None);
		let mut rs = atlas_dump(&a);
		sort_zones(&mut js);
		sort_zones(&mut rs);
		let s = forge_world::json::stringify;
		for k in ["nodes", "roles", "areas", "zones"] {
			let (xa, ya) = (rs[k].as_array().unwrap(), js[k].as_array().unwrap());
			let i = xa.iter().zip(ya).position(|(p, q)| s(p) != s(q));
			if i.is_some() || xa.len() != ya.len() {
				let i = i.unwrap_or(xa.len().min(ya.len()));
				panic!("{f} atlas {k} differ (rust {} js {}) at {i}:\n rust {}\n js   {}", xa.len(), ya.len(), xa.get(i).map_or("-".into(), s), ya.get(i).map_or("-".into(), s));
			}
		}
	}
}

/// The availability rule against judge rules.js (available, levelOk, simRules over sim run.js
/// compileRun) on the slice worlds: expected/rules-ref.json.
#[test]
fn rules_equal_js() {
	use forge_world::rules::{available, level_ok, State};
	use serde_json::{json, Value};
	let refs: Value = serde_json::from_str(&expected("rules-ref.json")).unwrap();
	let mut worlds = std::collections::BTreeMap::new();
	for (key, r) in refs.as_object().unwrap() {
		let parts: Vec<&str> = key.split(':').collect();
		let f = Faction::parse(parts[0]).unwrap();
		let cls = (parts[2] != "null").then_some(parts[2]);
		worlds.entry(f).or_insert_with(|| slice_world(f));
		let (w, d) = &worlds[&f];
		let rules = forge_world::Rules::new(w, parts[1], cls, false);
		let ids: Vec<u32> = rules.open.keys().copied().collect();
		assert_eq!(json!(ids), r["ids"], "{key} open set");
		let solo: Vec<u32> = ids.iter().copied().filter(|&q| rules.solo_ok(q)).collect();
		assert_eq!(json!(solo), r["solo"], "{key} solo set");
		for p in r["pre"].as_array().unwrap() {
			let q = p[0].as_u64().unwrap() as u32;
			let rec = d.quests.get(&q).cloned().unwrap_or_else(|| forge_world::data::Quest { id: q, ..Default::default() });
			let b = rules.prereqs_of(&rec);
			let got = json!({ "any": b.any, "all": b.all, "parent": b.parent, "excl": b.excl });
			assert_eq!(got, p[1], "{key} prereqs of {q}");
		}
		let open: Vec<i64> = ids.iter().map(|&q| q as i64).collect();
		let done = |q: i64| q % 7 == 0 && open.binary_search(&q).is_ok();
		let taken = |q: i64| (q % 7 == 0 || q % 11 == 0) && open.binary_search(&q).is_ok();
		let pre_of = |rec: &forge_world::data::Quest| rules.prereqs_of(rec);
		let mut bad = 0;
		for a in r["avail"].as_array().unwrap() {
			let id = a[0].as_u64().unwrap() as u32;
			let st = State { level: a[1].as_f64().unwrap(), done: &done, taken: &taken, faction: Some(f), race: Some(parts[1]), cls };
			let got = available(d.quests.get(&id), &st, &d.quests, Some(&pre_of));
			let got = json!([id, a[1], got.is_ok(), got.err()]);
			if forge_world::json::stringify(&got) != forge_world::json::stringify(a) {
				bad += 1;
				if bad < 5 {
					eprintln!("{key} available: rust {got} js {a}");
				}
			}
		}
		assert_eq!(bad, 0, "{key}: available() differs");
		for l in r["lv"].as_array().unwrap() {
			assert_eq!(level_ok(l[0].as_f64().unwrap(), l[1].as_f64().unwrap()), l[2].as_bool().unwrap(), "{key} levelOk {l}");
		}
	}
}

/// makeRules (the rule at goal t of a walk) against judge rules.js on a made-up Orc walk of the
/// slice: expected/walkrules-ref.json.
#[test]
fn walk_rules_equal_js() {
	use forge_world::rules::{Goal, WalkRules};
	use serde_json::{json, Value};
	let r: Value = serde_json::from_str(&expected("walkrules-ref.json")).unwrap();
	let (w, d) = slice_world(Faction::Horde);
	let rules = forge_world::Rules::new(&w, "Orc", Some("Warrior"), false);
	let goals: Vec<Goal> = r["goals"]
		.as_array()
		.unwrap()
		.iter()
		.map(|g| Goal {
			i: g["i"].as_u64().unwrap() as usize,
			t: g["t"].as_str().unwrap().into(),
			q: g["q"].as_i64(),
			oi: g["oi"].as_i64(),
			lvl: g["lvl"].as_f64().unwrap(),
			lvl_after: g["lvlAfter"].as_f64(),
		})
		.collect();
	let wr = WalkRules::new(&goals, &d.quests);
	let pre_of = |rec: &forge_world::data::Quest| rules.prereqs_of(rec);
	let s = forge_world::json::stringify;
	for a in r["at"].as_array().unwrap() {
		let (q, t) = (a[0].as_i64().unwrap(), a[1].as_u64().unwrap() as usize);
		let got = wr.acceptable_at(q, t, Some(&pre_of));
		let got = json!([q, t, got.is_ok(), got.err()]);
		assert_eq!(s(&got), s(a), "acceptableAt");
	}
	for c in r["closed"].as_array().unwrap() {
		assert_eq!(wr.closed_by_walk(c[0].as_i64().unwrap()), c[1].as_bool().unwrap(), "closedByWalk {c}");
	}
}

/// World::from_json reads a world file back: to_json gives the same bytes (synthetic and slice worlds).
#[test]
fn world_file_round_trips() {
	let mut texts: Vec<(String, String)> = Vec::new();
	for set in ["base", "rules"] {
		for f in Faction::BOTH {
			let p = manifest().join("tests/fixtures/synthetic").join(set).join(format!("world-{}.json", f.lower()));
			texts.push((p.display().to_string(), std::fs::read_to_string(&p).unwrap()));
		}
	}
	for f in Faction::BOTH {
		let name = format!("world-{}.json", f.lower());
		texts.push((name.clone(), expected(&name)));
	}
	for (name, text) in texts {
		let w = World::from_json(text.as_bytes()).unwrap_or_else(|e| panic!("{name}: {e}"));
		assert!(w.to_json() == text, "{name}: round trip differs");
	}
}

/// A floors cache missing places the world needs is an error, not a different world.
#[test]
fn partial_floors_cache_fails() {
	let empty = FloorCache::from_json(br#"{"key":"x","floors":{}}"#).unwrap();
	let err = World::load_with(&golden_root(), Faction::Horde, &empty).err().expect("an error");
	assert!(err.to_string().contains("floors source lacks"), "{err}");
}

#[test]
#[ignore = "writes the slice worlds to $WORLD_OUT for a field diff"]
fn dump_slice_worlds() {
	let out = PathBuf::from(std::env::var("WORLD_OUT").unwrap());
	for f in Faction::BOTH {
		let (w, _) = slice_world(f);
		std::fs::write(out.join(format!("world-{}.json", f.lower())), w.to_json()).unwrap();
	}
}
