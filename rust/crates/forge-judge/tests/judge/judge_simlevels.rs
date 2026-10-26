//! The judge with levels from forge-sim's evaluator (`levels::SimLevels`, walks off, the golden slice
//! world and params.json as walk.js loads them) against the JS judge (references as
//! tests/judge_parity.rs: rust/tests/golden/judge): chain, goal list, passed by and returns equal; levels
//! and times within the evaluator's parity bound.

use crate::common;
use forge_judge::levels::SimLevels;
use forge_judge::walk::{judge_walk, JudgeOpts};
use serde_json::Value;

const CASES: [(&str, &str, &str, &str, f64); 4] =
	[("orc61", "Horde", "Orc", "Warrior", 61.0), ("orc12", "Horde", "Orc", "Warrior", 12.0), ("human61", "Alliance", "Human", "Warrior", 61.0), ("human10", "Alliance", "Human", "Warrior", 10.0)];

/// Numbers as f64 (JS has one number type).
fn norm(v: Value) -> Value {
	match v {
		Value::Number(n) => serde_json::Number::from_f64(n.as_f64().unwrap()).map_or(Value::Null, Value::Number),
		Value::Array(a) => Value::Array(a.into_iter().map(norm).collect()),
		Value::Object(o) => Value::Object(o.into_iter().map(|(k, v)| (k, norm(v))).collect()),
		x => x,
	}
}

#[test]
fn judge_with_sim_levels_equals_js() {
	let params = Some(common::params());
	let mut failures = Vec::new();
	for (name, faction, race, cls, to) in CASES {
		let js: Value = norm(common::json_gz(&common::golden().join(format!("judge/{name}.json.gz"))));
		let world = common::world(forge_core::Faction::parse(faction).unwrap());
		let levels = SimLevels::new(&world, race, params.as_ref()).unwrap();
		let mut o = JudgeOpts::new(&common::guides(), faction, race, Some(cls), &common::root());
		// walk.js walks to an along step's goals where the step stands.
		o.along_on_the_way = false;
		o.grid = common::no_grid();
		o.to = to;
		let r = judge_walk(&o, &levels).expect("judge");
		let jg = js["goals"].as_array().unwrap();
		let (mut dl, mut dt) = (0f64, 0f64);
		for (g, j) in r.walk.goals.iter().zip(jg) {
			let n = |k: &str| j[k].as_f64().unwrap_or(f64::NAN);
			dl = dl.max((g.lvl - n("lvl")).abs()).max((g.lvl_after - n("lvlAfter")).abs());
			dt = dt.max((g.time - n("time")).abs()).max((g.time_after - n("timeAfter")).abs());
		}
		let rs = norm(common::strip_prefix(serde_json::json!({ "passedBy": r.passed_by, "returns": r.returns }), &common::guides()));
		let mut bad = Vec::new();
		if r.walk.goals.len() != jg.len() {
			bad.push(format!("goals rust {} js {}", r.walk.goals.len(), jg.len()));
		}
		if dl > 1e-6 || dt > 1e-3 {
			bad.push(format!("levels max |dlevel| {dl:.2e} |dt| {dt:.4} s"));
		}
		for k in ["passedBy", "returns"] {
			if rs[k] != js[k] {
				bad.push(format!("{k} differs"));
			}
		}
		eprintln!(
			"{name}: {} goals, {} passed by, {} returns, end level {:.3}, {:.2} h; |dlevel| {dl:.1e} |dt| {dt:.4} s; {}",
			r.walk.goals.len(),
			r.passed_by.count,
			r.returns.summary.returns,
			r.walk.end_level,
			r.walk.hours,
			if bad.is_empty() { "equal".into() } else { bad.join("; ") }
		);
		if !bad.is_empty() {
			failures.push(name);
		}
	}
	assert!(failures.is_empty(), "differ: {failures:?}");
}
