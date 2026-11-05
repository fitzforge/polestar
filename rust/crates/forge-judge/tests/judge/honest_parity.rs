//! Parity of the honest playtest (src/honest.rs, legacy mode) with `playtest --honest`
//! (tools/lib/playtest-honest.js through tools/lib/playtest.js).
//!
//! Default: rust/tests/golden/honest (its README and regen.js): this checkout's JS on the guide slice made to
//! compile on the data slice (drop.json's lines commented out), Orc (forever/horde/) and Human
//! (forever/alliance/), no knowledge base.
//!
//! Optional extra on a full checkout: the shipped Orc and Human chains (the Horde and Alliance guides of the
//! pack) and the v2 slice. tests/js/honest-ref.js writes the JS findings to $POLESTAR_JSREF/honest/<name>.json
//! (rust/target/judge-ref/honest when unset; made here when missing); each row must be equal: rule,
//! severity, guide, line, step, title, reason, repair, race, class. Inputs: $POLESTAR_CHECKOUT (guides,
//! data/forever, data/local/kb), $POLESTAR_JSREF/repaired (the v2 slice), $POLESTAR_JS (the JS reference
//! tree). Unset or absent: skipped with a note.
//!
//! cargo test --release -p forge-judge --test honest_parity -- --nocapture

use crate::common;
use forge_judge::honest::{load_kb, play_pack, Finding, HonestOpts, PackRun};
use std::path::{Path, PathBuf};
use std::time::Instant;

#[test]
fn honest_parity_slice() {
	let pack = common::clean_slice("honest");
	let data = forge_guide::data::load_data(&common::data()).expect("data");
	let mut failed = Vec::new();
	for (name, filter) in [("orc", "forever/horde/"), ("human", "forever/alliance/")] {
		let js: serde_json::Value = serde_json::from_slice(&std::fs::read(common::golden().join(format!("honest/{name}.json"))).unwrap()).unwrap();
		let run = PackRun { filter: Some(filter.to_string()), ..Default::default() };
		let got = play_pack(&pack, &data, None, &run, &HonestOpts::legacy()).expect("play");
		let want: Vec<serde_json::Value> = js["findings"].as_array().unwrap().iter().map(js_row).collect();
		let have: Vec<serde_json::Value> = got.findings.iter().map(row).collect();
		let equal = want.iter().zip(have.iter()).filter(|(a, b)| a == b).count();
		eprintln!("honest parity slice {name}: {} guides (JS {}); JS {} rows, Rust {} rows, {equal} equal", got.played, js["played"], want.len(), have.len());
		if equal != want.len() || want.len() != have.len() || js["played"].as_u64() != Some(got.played as u64) {
			for (i, (a, b)) in want.iter().zip(have.iter()).enumerate().filter(|(_, (a, b))| a != b).take(6) {
				eprintln!("  row {i}\n    js:   {a}\n    rust: {b}");
			}
			failed.push(name);
		}
	}
	assert!(failed.is_empty(), "honest parity differs on {failed:?}");
}

fn main_dir() -> Option<String> {
	std::env::var("POLESTAR_CHECKOUT").ok()
}

fn ref_dir() -> PathBuf {
	match std::env::var_os("POLESTAR_JSREF") {
		Some(d) => PathBuf::from(d).join("honest"),
		None => Path::new(env!("CARGO_MANIFEST_DIR")).join("../../target/judge-ref/honest"),
	}
}

struct Case {
	name: &'static str,
	pack: String,
	filter: Option<&'static str>,
}

fn cases(main: &str) -> Vec<Case> {
	let v2 = std::env::var("POLESTAR_JSREF").map(|d| format!("{d}/repaired")).unwrap_or_default();
	vec![
		Case { name: "orc", pack: format!("{main}/guides"), filter: Some("forever/horde/") },
		Case { name: "human", pack: format!("{main}/guides"), filter: Some("forever/alliance/") },
		Case { name: "v2orc", pack: format!("{v2}/horde-orc-troll-warrior"), filter: None },
		Case { name: "v2human", pack: format!("{v2}/alliance-human-warrior"), filter: None },
	]
}

fn script() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/js/honest-ref.js")
}

fn reference(c: &Case, data: &Path, kb: &Path) -> Option<serde_json::Value> {
	// The JS tree the reference comes from: POLESTAR_HONEST_JS, else $POLESTAR_JS (the frozen v2-route
	// writer's tree, whose honest playtest the Rust one follows), else this checkout's. Each tree's
	// references apart.
	let js = std::env::var("POLESTAR_HONEST_JS").ok().or_else(|| std::env::var("POLESTAR_JS").ok().filter(|j| Path::new(j).join("tools/lib/playtest-honest.js").exists()));
	let dir = match &js {
		Some(js) => ref_dir().join(js.trim_matches('/').replace('/', "_")),
		None => ref_dir(),
	};
	let _ = std::fs::create_dir_all(&dir);
	let file = dir.join(format!("{}.json", c.name));
	if !file.exists() {
		let mut cmd = std::process::Command::new("node");
		if let Some(js) = &js {
			cmd.env("POLESTAR_HONEST_JS", js);
		}
		let st = cmd.arg(script()).arg(&c.pack).arg(c.filter.unwrap_or("-")).arg(&file).args(["--data", data.to_str().unwrap(), "--kb", kb.to_str().unwrap()]).status().ok()?;
		if !st.success() {
			return None;
		}
	}
	serde_json::from_str(&std::fs::read_to_string(&file).ok()?).ok()
}

fn row(f: &Finding) -> serde_json::Value {
	serde_json::json!({
		"rule": f.rule, "severity": f.severity.as_str(), "guide": f.guide, "line": f.line, "step": f.step,
		"title": f.title, "reason": f.reason, "repair": f.repair, "race": f.race, "cls": f.cls,
	})
}

fn js_row(v: &serde_json::Value) -> serde_json::Value {
	let mut o = serde_json::Map::new();
	for k in ["rule", "severity", "guide", "line", "step", "title", "reason", "repair", "race", "cls"] {
		o.insert(k.into(), v.get(k).cloned().unwrap_or(serde_json::Value::Null));
	}
	serde_json::Value::Object(o)
}

#[test]
#[ignore = "needs POLESTAR_CHECKOUT (data/forever, the knowledge base) and node"]
fn honest_parity() {
	let main = main_dir().expect("honest parity needs POLESTAR_CHECKOUT");
	let data_dir = PathBuf::from(format!("{main}/data/forever"));
	let kb_file = PathBuf::from(format!("{main}/data/local/kb/forever-kb.sqlite"));
	assert!(data_dir.exists() && kb_file.exists(), "honest parity needs {} and {}", data_dir.display(), kb_file.display());
	let mut failed = Vec::new();
	for c in cases(&main) {
		if !Path::new(&c.pack).exists() {
			eprintln!("honest parity {}: skipped ({} is not there)", c.name, c.pack);
			continue;
		}
		let Some(js) = reference(&c, &data_dir, &kb_file) else {
			eprintln!("honest parity {}: skipped (no JS reference: node or the JS tree missing)", c.name);
			continue;
		};
		let t0 = Instant::now();
		let data = forge_guide::data::load_data(&data_dir).expect("data");
		let kb = load_kb(&kb_file).expect("kb");
		let t1 = Instant::now();
		let run = PackRun { filter: c.filter.map(str::to_string), ..Default::default() };
		let got = play_pack(Path::new(&c.pack), &data, kb.as_ref(), &run, &HonestOpts::legacy()).expect("play");
		let t2 = Instant::now();
		let want: Vec<serde_json::Value> = js["findings"].as_array().unwrap().iter().map(js_row).collect();
		let have: Vec<serde_json::Value> = got.findings.iter().map(row).collect();
		let equal = want.iter().zip(have.iter()).filter(|(a, b)| a == b).count();
		eprintln!(
			"honest parity {}: {} guides; JS {} rows, Rust {} rows, {} equal; JS {:.0} ms (data+compile+play), Rust {:.0} ms (data+kb {:.0}, compile+play {:.0})",
			c.name,
			got.played,
			want.len(),
			have.len(),
			equal,
			js["ms"].as_f64().unwrap_or(0.0),
			(t2 - t0).as_secs_f64() * 1e3,
			(t1 - t0).as_secs_f64() * 1e3,
			(t2 - t1).as_secs_f64() * 1e3
		);
		if equal != want.len() || want.len() != have.len() {
			let mut shown = 0;
			for (i, (a, b)) in want.iter().zip(have.iter()).enumerate() {
				if a != b && shown < 6 {
					eprintln!("  row {i}\n    js:   {a}\n    rust: {b}");
					shown += 1;
				}
			}
			failed.push(c.name);
		}
	}
	assert!(failed.is_empty(), "honest parity differs on {failed:?}");
}

/// The default (non-legacy) play on the same inputs: deduplicated findings with R6-R10, counted per rule
/// and severity (a report, not a pin: guides change). POLESTAR_HONEST_DUMP=<dir> writes them as JSON.
#[test]
#[ignore = "needs POLESTAR_CHECKOUT (data/forever)"]
fn honest_default_summary() {
	let main = main_dir().expect("the honest summary needs POLESTAR_CHECKOUT");
	let data_dir = PathBuf::from(format!("{main}/data/forever"));
	let kb_file = PathBuf::from(format!("{main}/data/local/kb/forever-kb.sqlite"));
	assert!(data_dir.exists(), "the honest summary needs {}", data_dir.display());
	let data = forge_guide::data::load_data(&data_dir).expect("data");
	let kb = load_kb(&kb_file).expect("kb");
	for c in cases(&main) {
		if !Path::new(&c.pack).exists() {
			continue;
		}
		let t0 = Instant::now();
		let run = PackRun { filter: c.filter.map(str::to_string), ..Default::default() };
		let got = play_pack(Path::new(&c.pack), &data, kb.as_ref(), &run, &HonestOpts::default()).expect("play");
		let mut counts: std::collections::BTreeMap<String, usize> = Default::default();
		for f in &got.findings {
			*counts.entry(format!("{} {}", f.rule, f.severity.as_str())).or_default() += 1;
		}
		eprintln!("honest default {}: {} findings in {:.0} ms: {counts:?}", c.name, got.findings.len(), t0.elapsed().as_secs_f64() * 1e3);
		if let Ok(dir) = std::env::var("POLESTAR_HONEST_DUMP") {
			std::fs::create_dir_all(&dir).unwrap();
			std::fs::write(Path::new(&dir).join(format!("{}.json", c.name)), serde_json::to_string_pretty(&got.findings).unwrap()).unwrap();
		}
	}
}
