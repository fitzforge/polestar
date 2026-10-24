//! Parity with tools/lib/judge/guidetext.js scoreTarget. tests/js/guidetext-dump.js dumps the JS result
//! with its goals (levels from the sim replay) and sim view; the Rust scorer reads the same goals and view
//! and must give the same JSON.
//!
//! References: rust/tests/golden/guidetext/<case>.json.gz (its README and regen.js: guidetext.js on the
//! committed guide slice and data slice, the golden slice worlds as its sim dir; no consensus export, no
//! walking grid). Optional extra, skipped with a note when unset: the same on a full checkout with
//! $POLESTAR_CHECKOUT, $POLESTAR_JS and $POLESTAR_JSREF (below).

use crate::common;
use forge_core::{Faction, Projector};
use forge_judge::guidetext::{self, Inputs, SimView};
use forge_judge::walk::{DumpLevels, LevelModel, WPt, WalkGoal};
use forge_world::data::{DirSource, GameData};
use serde_json::Value;
use std::path::{Path, PathBuf};
use std::process::Command;
use std::time::Instant;

/// The local inputs: $POLESTAR_CHECKOUT (guides, data/forever, data/sim/export), $POLESTAR_JS (a checkout whose
/// tools/lib/judge/guidetext.js is the reference), $POLESTAR_JSREF (simdir/, repaired/; dumps go to gt/).
struct Paths {
	lodestar: String,
	gt: String,
	sim: String,
	v2: String,
	out: String,
}

impl Paths {
	fn from_env() -> Option<Paths> {
		let var = |k: &str| std::env::var(k).ok();
		let (lodestar, js, jsref) = (var("POLESTAR_CHECKOUT")?, var("POLESTAR_JS")?, var("POLESTAR_JSREF")?);
		Some(Paths { lodestar, gt: format!("{js}/tools/lib/judge/guidetext.js"), sim: format!("{jsref}/simdir"), v2: format!("{jsref}/repaired"), out: format!("{jsref}/gt") })
	}
}

fn goal(v: &Value) -> WalkGoal {
	let s = |k: &str| v[k].as_str().map(String::from);
	let u = |k: &str| v[k].as_f64().map(|x| x as u32);
	let i = |k: &str| v[k].as_f64().map(|x| x as i64);
	WalkGoal {
		i: v["i"].as_u64().unwrap() as usize,
		guide: s("guide").unwrap_or_default(),
		file: s("file").unwrap_or_default(),
		line: u("line"),
		step: u("step"),
		t: s("t").unwrap_or_default(),
		q: i("q"),
		oi: i("oi"),
		optional: v["optional"].as_bool().unwrap_or(false),
		passing: v["passing"].as_bool().unwrap_or(false),
		map: u("map"),
		w: v["w"].as_object().map(|w| WPt { c: w["c"].as_f64().unwrap() as i64, wx: w["wx"].as_f64().unwrap(), wy: w["wy"].as_f64().unwrap(), map: w["map"].as_f64().unwrap() as u32 }),
		npc: u("npc"),
		level: v["level"].as_f64(),
		title: s("title"),
		lvl: v["lvl"].as_f64().unwrap(),
		time: v["time"].as_f64().unwrap(),
		lvl_after: v["lvlAfter"].as_f64().unwrap(),
		time_after: v["timeAfter"].as_f64().unwrap(),
		pos: None,
		along: None,
		label: None,
	}
}

/// Differences between two JSON values, numbers compared as doubles; `n` counts the leaves compared.
fn diff(a: &Value, b: &Value, path: &str, out: &mut Vec<String>, n: &mut usize) {
	match (a, b) {
		(Value::Object(x), Value::Object(y)) => {
			for (k, v) in x {
				match y.get(k) {
					Some(w) => diff(v, w, &format!("{path}.{k}"), out, n),
					None => out.push(format!("{path}.{k}: missing in rust")),
				}
			}
			for k in y.keys().filter(|k| !x.contains_key(*k)) {
				out.push(format!("{path}.{k}: extra in rust = {}", y[k]));
			}
		}
		(Value::Array(x), Value::Array(y)) => {
			if x.len() != y.len() {
				out.push(format!("{path}: length js {} rust {}", x.len(), y.len()));
			}
			for (k, (v, w)) in x.iter().zip(y).enumerate() {
				diff(v, w, &format!("{path}[{k}]"), out, n);
			}
		}
		(Value::Number(x), Value::Number(y)) => {
			*n += 1;
			if x.as_f64() != y.as_f64() {
				out.push(format!("{path}: js {x} rust {y}"));
			}
		}
		_ => {
			*n += 1;
			if a != b {
				out.push(format!("{path}: js {a} rust {b}"));
			}
		}
	}
}

/// Runs guidetext-dump.js on a full checkout (the optional local mode) and returns its dump.
fn dump(p: &Paths, name: &str, target: &str) -> Value {
	let lodestar = &p.lodestar;
	std::fs::create_dir_all(&p.out).unwrap();
	let refp = PathBuf::from(&p.out).join(format!("{name}.json"));
	let st = Command::new("node")
		.arg(concat!(env!("CARGO_MANIFEST_DIR"), "/tests/js/guidetext-dump.js"))
		.args([p.gt.as_str(), target, refp.to_str().unwrap()])
		.env("POLESTAR_JUDGE_SIM", &p.sim)
		.env("POLESTAR_JUDGE_GUIDES", format!("{lodestar}/guides"))
		.env("POLESTAR_JUDGE_DATA", format!("{lodestar}/data/forever"))
		.env("POLESTAR_JUDGE_EXPORT", format!("{lodestar}/data/sim/export"))
		.status()
		.expect("node");
	assert!(st.success(), "{target}: guidetext-dump.js failed");
	serde_json::from_slice(&std::fs::read(&refp).unwrap()).unwrap()
}

/// The Rust scorer on a dump's chain, goal levels and sim view, against the dump's result. `guides`: the
/// target's guides dir; `data_dir`: data/forever; `export`: the dir of the sim's consensus exports.
#[allow(clippy::too_many_arguments)]
fn run(name: &str, d: &Value, guides: &Path, data_dir: &Path, export: &Path, faction: Faction, race: &str, data: &GameData) {
	let js = &d["res"];

	let proj = Projector::new(&data.frames);
	let chain: Vec<String> = js["chain"].as_array().unwrap().iter().map(|v| v.as_str().unwrap().to_string()).collect();
	let js_goals: Vec<WalkGoal> = d["goals"].as_array().unwrap().iter().map(goal).collect();
	// the goal list from the compiled guides, against guidetext.js's; levels from its sim replay
	let tg = Instant::now();
	let mut goals = guidetext::chain_goals(guides, data_dir, &chain, faction, race, &proj).unwrap();
	let goals_ms = tg.elapsed().as_millis();
	let key = |g: &WalkGoal| {
		format!("{} {} {:?} {:?} {} {:?} {:?} {} {} {:?} {:?} {:?} {:?} {:?}", g.guide, g.file, g.line, g.step, g.t, g.q, g.oi, g.optional, g.passing, g.map, g.w, g.npc, g.level, g.title)
	};
	assert_eq!(goals.len(), js_goals.len(), "{name}: goal count");
	let bad: Vec<_> = goals.iter().zip(&js_goals).filter(|(a, b)| key(a) != key(b)).map(|(a, b)| format!("rust {}\n    js {}", key(a), key(b))).collect();
	assert!(bad.is_empty(), "{name}: {} goals differ, first:\n  {}", bad.len(), bad.first().unwrap());
	DumpLevels(js_goals.iter().map(|g| [g.lvl, g.time, g.lvl_after, g.time_after]).collect()).replay(&mut goals, 60.0);
	let t0 = Instant::now();
	let sim: SimView = serde_json::from_value(d["sim"].clone()).unwrap();
	let files = guidetext::guide_texts(guides).unwrap();
	let mentioned = guidetext::mentions(&files, data);
	let consensus = guidetext::load_consensus(export, faction, &guidetext::race_key(race));
	let rs =
		guidetext::score(&Inputs { data, proj: &proj, src: js["src"].as_str().unwrap(), faction, race, chain: &chain, goals: &goals, sim: &sim, consensus: consensus.as_ref(), mentioned: &mentioned });
	let ms = t0.elapsed().as_millis();
	let (mut out, mut n) = (Vec::new(), 0);
	diff(js, &rs, "", &mut out, &mut n);
	let fams = ["pingpong", "log", "missed", "overlap", "bandSplit"];
	let per: Vec<String> = fams
		.iter()
		.map(|f| {
			let (mut o, mut k) = (Vec::new(), 0);
			diff(&js[f], &rs[f], f, &mut o, &mut k);
			format!("{f} {k}")
		})
		.collect();
	println!(
		"{name}: {} goals, {n} values compared ({}), {} differ; js {} ms (incl. world load + compile + replay), rust goals {goals_ms} ms (compile), metrics {ms} ms (incl. mentions)",
		goals.len(),
		per.join(", "),
		out.len(),
		d["ms"]
	);
	for l in out.iter().take(40) {
		println!("  {l}");
	}
	assert!(out.is_empty(), "{name}: {} differences", out.len());
}

/// The committed references on the guide and data slices: the shipped chains of the slice (Orc, Human)
/// and a dir target (the slice's Orc/Troll folder, its guides in id order).
#[test]
#[ignore = "needs POLESTAR_CHECKOUT, POLESTAR_JS, POLESTAR_JSREF and node"]
fn guidetext_parity() {
	let root = common::root();
	let data = GameData::from_source(&DirSource::repo(&root)).unwrap();
	let gold = common::golden().join("guidetext");
	let slice = common::guides();
	let no_export = root.join("data/sim/export");
	assert!(!no_export.exists(), "the references were made without a consensus export");
	for (name, guides, faction, race) in
		[("shipped-orc", slice.clone(), Faction::Horde, "Orc"), ("shipped-human", slice.clone(), Faction::Alliance, "Human"), ("dir-orc", slice.join("forever/horde/orc-troll"), Faction::Horde, "Orc")]
	{
		let d = common::json_gz(&gold.join(format!("{name}.json.gz")));
		run(name, &d, &guides, &common::data(), &no_export, faction, race, &data);
	}
}

/// Optional: the same on a full checkout, guidetext.js run live.
#[test]
fn guidetext_parity_local() {
	let Some(p) = Paths::from_env() else {
		println!("guidetext_parity_local: skipped (set POLESTAR_CHECKOUT, POLESTAR_JS and POLESTAR_JSREF)");
		return;
	};
	let need = [&p.gt, &p.sim, &p.v2, &p.lodestar];
	if need.iter().any(|q| !Path::new(q).exists()) || Command::new("node").arg("--version").output().is_err() {
		println!("guidetext_parity_local: skipped (needs {need:?} from POLESTAR_CHECKOUT/POLESTAR_JS/POLESTAR_JSREF, and node)");
		return;
	}
	let lodestar = PathBuf::from(&p.lodestar);
	let data = GameData::from_source(&DirSource::repo(&lodestar)).unwrap();
	let (data_dir, export) = (lodestar.join("data/forever"), lodestar.join("data/sim/export"));
	let shipped = lodestar.join("guides");
	let (vo, vh) = (PathBuf::from(&p.v2).join("horde-orc-troll-warrior"), PathBuf::from(&p.v2).join("alliance-human-warrior"));
	let cases = [
		("shipped-orc", "polestar:Horde:Orc".to_string(), shipped.clone(), Faction::Horde, "Orc"),
		("shipped-human", "polestar:Alliance:Human".to_string(), shipped, Faction::Alliance, "Human"),
		("v2-orc", format!("file:{}:Horde:Orc", vo.display()), vo, Faction::Horde, "Orc"),
		("v2-human", format!("file:{}:Alliance:Human", vh.display()), vh, Faction::Alliance, "Human"),
	];
	for (name, target, guides, faction, race) in cases {
		let d = dump(&p, name, &target);
		run(name, &d, &guides, &data_dir, &export, faction, race, &data);
	}
}
