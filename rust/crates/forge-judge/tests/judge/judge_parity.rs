//! The judge's walk, passed by and avoidable returns against the JS (tools/lib/judge walk.js,
//! passedby.js, returns.js via index.js judgeWalk, the v2-route branch's judge).
//!
//! References: rust/tests/golden/judge/<case>.json.gz (its regen.js: the JS judge on the committed guide
//! and data slices, its sim world the golden slice world; no walking grid). Levels: replayed from the
//! JS dump here (tests/judge_simlevels.rs runs forge-sim's evaluator instead), so the JS walk's per-goal
//! lvl/time/lvlAfter/timeAfter are replayed through `DumpLevels` (the cut at `to` comes with them);
//! everything else is computed here and compared.

use crate::common;
use forge_judge::walk::{judge_walk, DumpLevels, JudgeOpts};
use serde_json::Value;
use std::time::Instant;

/// (case, faction, race, class, to)
const CASES: [(&str, &str, &str, &str, f64); 4] =
	[("orc61", "Horde", "Orc", "Warrior", 61.0), ("orc12", "Horde", "Orc", "Warrior", 12.0), ("human61", "Alliance", "Human", "Warrior", 61.0), ("human10", "Alliance", "Human", "Warrior", 10.0)];

/// Numbers as f64 (JS has one number type; 12 and 12.0 are the same value).
fn norm(v: Value) -> Value {
	match v {
		Value::Number(n) => serde_json::Number::from_f64(n.as_f64().unwrap()).map_or(Value::Null, Value::Number),
		Value::Array(a) => Value::Array(a.into_iter().map(norm).collect()),
		Value::Object(o) => Value::Object(o.into_iter().map(|(k, v)| (k, norm(v))).collect()),
		x => x,
	}
}

/// The first differing path, or None.
fn diff(a: &Value, b: &Value, at: &str) -> Option<String> {
	match (a, b) {
		(Value::Array(x), Value::Array(y)) => {
			for (i, (p, q)) in x.iter().zip(y).enumerate() {
				if let Some(d) = diff(p, q, &format!("{at}[{i}]")) {
					return Some(d);
				}
			}
			(x.len() != y.len()).then(|| format!("{at}: length rust {} js {}", x.len(), y.len()))
		}
		(Value::Object(x), Value::Object(y)) => {
			for k in x.keys().chain(y.keys()) {
				match (x.get(k), y.get(k)) {
					(Some(p), Some(q)) => {
						if let Some(d) = diff(p, q, &format!("{at}.{k}")) {
							return Some(d);
						}
					}
					(p, q) => return Some(format!("{at}.{k}: rust {p:?} js {q:?}")),
				}
			}
			None
		}
		_ => (a != b).then(|| format!("{at}: rust {a} js {b}")),
	}
}

#[test]
fn judge_equals_js() {
	let mut failures = Vec::new();
	for (name, faction, race, cls, to) in CASES {
		let js: Value = norm(common::json_gz(&common::golden().join(format!("judge/{name}.json.gz"))));
		let levels = DumpLevels(
			js["goals"]
				.as_array()
				.unwrap()
				.iter()
				.map(|g| [g["lvl"].as_f64().unwrap(), g["time"].as_f64().unwrap(), g["lvlAfter"].as_f64().unwrap_or(f64::NAN), g["timeAfter"].as_f64().unwrap_or(f64::NAN)])
				.collect(),
		);
		let guides = common::guides();
		let mut o = JudgeOpts::new(&guides, faction, race, Some(cls), &common::root());
		// walk.js walks to an along step's goals where the step stands.
		o.along_on_the_way = false;
		o.grid = common::no_grid();
		o.to = to;
		let t0 = Instant::now();
		let r = judge_walk(&o, &levels).expect("judge");
		let ms = t0.elapsed().as_secs_f64() * 1e3;
		let rs = norm(common::strip_prefix(
			serde_json::json!({
				"chain": r.walk.chain,
				"goals": r.walk.goals,
				"passedBy": r.passed_by,
				"returns": r.returns,
			}),
			&guides,
		));
		let mut bad = Vec::new();
		for k in ["chain", "goals", "passedBy", "returns"] {
			if let Some(d) = diff(&rs[k], &js[k], k) {
				bad.push(d);
			}
		}
		eprintln!(
			"{name}: {} goals, {} passed by, {} returns / {} examples / {} left behind / {} same mob; rust {ms:.0} ms, js {:.0} ms; {}",
			r.walk.goals.len(),
			r.passed_by.count,
			r.returns.summary.returns,
			r.returns.examples.len(),
			r.returns.left_behind.len(),
			r.returns.same_mob.len(),
			js["ms"].as_f64().unwrap_or(f64::NAN),
			if bad.is_empty() { "equal".to_string() } else { bad.join("; ") }
		);
		if !bad.is_empty() {
			failures.push(name);
		}
	}
	assert!(failures.is_empty(), "differ: {failures:?}");
}
