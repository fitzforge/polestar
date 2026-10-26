//! Parity with V8: values printed by node (tests/jsnum.json: [a, b, Math.hypot(a,b), String(a),
//! a.toFixed(d), d, t, t.toFixed(2), Math.round(a)]), generated once by a seeded LCG.
use forge_core::*;

#[test]
fn matches_v8() {
	let rows: Vec<Vec<serde_json::Value>> = serde_json::from_str(include_str!("jsnum.json")).unwrap();
	let mut bad = 0;
	for r in &rows {
		let a = r[0].as_f64().unwrap();
		let b = r[1].as_f64().unwrap();
		let checks = [
			(js_hypot(a, b).to_bits() == r[2].as_f64().unwrap().to_bits(), "hypot"),
			(js_to_string(a) == r[3].as_str().unwrap(), "toString"),
			(js_to_fixed(a, r[5].as_u64().unwrap() as usize) == r[4].as_str().unwrap(), "toFixed"),
			(js_to_fixed(r[6].as_f64().unwrap(), 2) == r[7].as_str().unwrap(), "toFixed tie"),
			(js_round(a) == r[8].as_f64().unwrap(), "round"),
		];
		for (ok, what) in checks {
			if !ok {
				bad += 1;
				eprintln!("{what} differs on {r:?}");
			}
		}
	}
	assert_eq!(bad, 0);
}
