//! f4 parity: forge-nav's port of the format-4 reader (Leffe's navigation maps) against
//! 1. his Lua on Zephras Isle (tests/fixtures/nav4-parity-zephras.json, the bar tests/nav4-parity.test.js holds the
//!    Node reader to): every route's ok/reason/cost/jumps equal, yards and points within 1e-9; every FindMany
//!    batch's costs equal, yards within 1e-9, jumps equal;
//! 2. the Node reader on a sample (parity/f4-ref.js's out, $F4_REF): acceptance walks, random pairs and FindMany
//!    batches with limit and chains, bit for bit.
//!
//! Pack: $POLESTAR_LEFFE_NAV (a Nav folder or one holding Nav/, e.g. Leffe's candidate folder); ignored by default.
//! cargo test --release -p forge-nav --test f4_parity -- --ignored --nocapture

use forge_nav::f4::{Move, Opts, Style, Validate, F4, P};
use rayon::prelude::*;
use serde_json::Value;
use std::path::PathBuf;
use std::time::Instant;

fn open(cache_mb: usize) -> F4 {
	let d = std::env::var_os("POLESTAR_LEFFE_NAV").map(PathBuf::from).expect("needs POLESTAR_LEFFE_NAV (a format-4 Nav folder)");
	assert!(d.join("Nav.xml").exists() || d.join("Nav").join("Nav.xml").exists(), "no format-4 pack at POLESTAR_LEFFE_NAV ({})", d.display());
	F4::open(&d, cache_mb).unwrap()
}

fn point(v: &Value) -> P {
	let a = v.as_array().unwrap();
	P { x: a[0].as_f64().unwrap(), y: a[1].as_f64().unwrap(), z: a.get(2).and_then(|z| z.as_f64()) }
}
fn profile(v: &Value) -> Option<&'static str> {
	match v.as_str() {
		Some("Alliance") => Some("Alliance"),
		Some("Horde") => Some("Horde"),
		_ => None,
	}
}
fn danger(v: &Value) -> Vec<(u32, f64)> {
	v.as_object().map_or_else(Vec::new, |o| o.iter().filter_map(|(k, m)| Some((k.parse().ok()?, m.as_f64()?))).collect())
}
fn opts(v: &Value, validate: Validate) -> Opts {
	Opts { profile: profile(&v["profile"]), style: Style::parse(v["style"].as_str().unwrap_or("")), danger: danger(&v["danger"]), validate, ..Default::default() }
}
fn f(v: &Value) -> f64 {
	v.as_f64().unwrap_or(-1.0)
}

#[test]
#[ignore = "needs POLESTAR_LEFFE_NAV (a format-4 Nav folder)"]
fn zephras_matches_the_lua_reader() {
	let nav = open(256);
	let fx: Value = serde_json::from_str(&std::fs::read_to_string(concat!(env!("CARGO_MANIFEST_DIR"), "/tests/fixtures/nav4-parity-zephras.json")).unwrap()).unwrap();
	let map = fx["map"].as_u64().unwrap() as u32;
	for r in fx["routes"].as_array().unwrap() {
		let id = r["id"].as_str().unwrap();
		let got = nav.route(map, point(&r["from"]), point(&r["to"]), &opts(r, Validate::Lua));
		let want = &r["lua"];
		assert_eq!(got.ok, want["ok"].as_bool().unwrap(), "{id}: ok ({:?})", got.reason);
		assert_eq!(got.reason.as_deref(), want["reason"].as_str(), "{id}: reason");
		if !got.ok {
			continue;
		}
		assert_eq!(got.cost, f(&want["cost"]), "{id}: cost");
		assert_eq!(got.jumps, f(&want["jumps"]), "{id}: jumps");
		assert!((got.yards - f(&want["yards"])).abs() < 1e-9, "{id}: yards {} vs {}", got.yards, want["yards"]);
		let pts = want["pts"].as_array().unwrap();
		assert_eq!(got.points.len(), pts.len(), "{id}: points");
		for (i, (p, w)) in got.points.iter().zip(pts).enumerate() {
			for j in 0..3 {
				let (v, w) = (p[j], &w[j]);
				let same = match w.as_f64() {
					None => v.is_nan(),
					Some(w) => (v - w).abs() < 1e-9,
				};
				assert!(same, "{id}: point {i} [{j}] {v} vs {w}");
			}
		}
		assert_eq!(got.legs.len(), got.points.len() - 1, "{id}: legs");
	}
	for q in fx["many"].as_array().unwrap() {
		let id = q["id"].as_str().unwrap();
		let targets: Vec<P> = q["targets"].as_array().unwrap().iter().map(point).collect();
		let got = nav.route_many(map, point(&q["from"]), &targets, &opts(q, Validate::Lua));
		let lua = &q["lua"];
		for i in 0..targets.len() {
			let cost = if lua["costs"][i] == Value::Bool(false) { -1.0 } else { f(&lua["costs"][i]) };
			assert_eq!(got.costs[i], cost, "{id}: target {i} cost");
			if cost >= 0.0 {
				assert!((got.yards[i] - f(&lua["yards"][i])).abs() < 1e-9, "{id}: target {i} yards");
				assert_eq!(got.jumps[i], f(&lua["jumps"][i]), "{id}: target {i} jumps");
			} else if let Some(e) = lua["error"].as_str() {
				assert_eq!(got.reasons[i].as_deref(), Some(e), "{id}: target {i} reason");
			}
		}
	}
	// heightAt and surfaces.
	let r = fx["routes"].as_array().unwrap().iter().find(|r| r["lua"]["ok"] == Value::Bool(true) && r["from"][2].is_number()).unwrap();
	let p = point(&r["from"]);
	let z = p.z.unwrap();
	assert!(nav.surfaces_at(map, p.x, p.y).iter().any(|s| s.z == z));
	assert_eq!(nav.height_at(map, p.x, p.y, forge_nav::f4::Floor::Near(z)), Some(z));
	assert_eq!(nav.height_at(map, -1e6, -1e6, forge_nav::f4::Floor::Base), None);
}

fn same_f(a: f64, b: &Value) -> bool {
	match b.as_f64() {
		Some(b) => a.to_bits() == b.to_bits() || a == b,
		None => a.is_nan() || a == -1.0,
	}
}

/// The Node reader's answers on the sample (F4_REF), bit for bit; timings and the cache on the way.
#[test]
#[ignore = "needs POLESTAR_LEFFE_NAV and F4_REF (parity/f4-ref.js output)"]
fn sample_matches_the_node_reader() {
	let file = std::env::var("F4_REF").expect("needs F4_REF (parity/f4-ref.js output)");
	let cache_mb: usize = std::env::var("F4_CACHE_MB").ok().and_then(|v| v.parse().ok()).unwrap_or(1024);
	let nav = open(cache_mb);
	let rf: Value = serde_json::from_str(&std::fs::read_to_string(file).unwrap()).unwrap();
	let routes = rf["routes"].as_array().unwrap();
	let mut bad = Vec::new();
	let (mut cold, mut warm, mut node_cold, mut node_warm) = (0.0, 0.0, 0.0, 0.0);
	let mut got_all = Vec::new();
	for pass in 0..2 {
		for r in routes {
			let t = Instant::now();
			let got = nav.route(r["map"].as_u64().unwrap() as u32, point(&r["from"]), point(&r["to"]), &opts(r, Validate::Tolerant));
			let ms = t.elapsed().as_secs_f64() * 1e3;
			if pass == 0 {
				cold += ms;
				node_cold += f(&r["msCold"]);
				got_all.push(got);
			} else {
				warm += ms;
				node_warm += f(&r["msWarm"]);
			}
		}
	}
	for (r, got) in routes.iter().zip(&got_all) {
		let id = r["id"].as_str().unwrap();
		let w = &r["res"];
		let mut why = Vec::new();
		if got.ok != w["ok"].as_bool().unwrap() || got.reason.as_deref() != w["reason"].as_str() {
			why.push(format!("ok/reason {} {:?} vs {} {}", got.ok, got.reason, w["ok"], w["reason"]));
		} else if got.ok {
			for (name, v) in [("cost", got.cost), ("yards", got.yards), ("wet", got.wet), ("jumps", got.jumps)] {
				if !same_f(v, &w[name]) {
					why.push(format!("{name} {v} vs {}", w[name]));
				}
			}
			let pts = w["pts"].as_array().unwrap();
			if pts.len() != got.points.len() {
				why.push(format!("points {} vs {}", got.points.len(), pts.len()));
			} else {
				for (i, (p, q)) in got.points.iter().zip(pts).enumerate() {
					if (0..3).any(|j| !same_f(p[j], &q[j]) || (q[j].is_null() != p[j].is_nan())) {
						why.push(format!("point {i} {p:?} vs {q}"));
						break;
					}
				}
			}
			let hubs: Vec<&str> = got.hubs.iter().map(|h| h.id.as_str()).collect();
			let whubs: Vec<&str> = w["hubs"].as_array().map_or_else(Vec::new, |a| a.iter().map(|h| h.as_str().unwrap()).collect());
			if hubs != whubs {
				why.push(format!("hubs {hubs:?} vs {whubs:?}"));
			}
			let ev = w["events"].as_array().unwrap();
			if ev.len() != got.events.len()
				|| ev
					.iter()
					.zip(&got.events)
					.any(|(a, b)| a["ordinal"].as_u64() != Some(b.ordinal as u64) || a["cluster"].as_u64() != Some(b.cluster as u64) || a["kind"].as_u64() != Some(b.kind as u64))
			{
				why.push("events".into());
			}
		}
		if !why.is_empty() {
			bad.push(format!("{id}: {}", why.join("; ")));
		}
	}
	let n = routes.len() as f64;
	let ok = got_all.iter().filter(|r| r.ok).count();
	eprintln!("routes: {} ({ok} ok), mismatches {}", routes.len(), bad.len());
	eprintln!("  per route ms: rust cold {:.2} warm {:.2}; node cold {:.2} warm {:.2}", cold / n, warm / n, node_cold / n, node_warm / n);
	let mut kinds = std::collections::BTreeMap::new();
	for r in &got_all {
		for l in &r.legs {
			*kinds.entry(format!("{:?}", l.kind)).or_insert(0) += 1;
		}
	}
	eprintln!("  legs by move: {kinds:?}");

	let batches = rf["many"].as_array().unwrap();
	let (mut mcold, mut mwarm, mut nmcold, mut nmwarm) = (0.0, 0.0, 0.0, 0.0);
	for q in batches {
		let id = q["id"].as_str().unwrap();
		let map = q["map"].as_u64().unwrap() as u32;
		let from = point(&q["from"]);
		let targets: Vec<P> = q["targets"].as_array().unwrap().iter().map(point).collect();
		let mut o = opts(q, Validate::Tolerant);
		o.limit = q["limit"].as_f64();
		o.chains = true;
		let t = Instant::now();
		let got = nav.route_many(map, from, &targets, &o);
		mcold += t.elapsed().as_secs_f64() * 1e3;
		let t = Instant::now();
		let again = nav.route_many(map, from, &targets, &o);
		mwarm += t.elapsed().as_secs_f64() * 1e3;
		assert_eq!(got, again, "{id}: repeat differs");
		nmcold += f(&q["msCold"]);
		nmwarm += f(&q["msWarm"]);
		let w = &q["res"];
		for i in 0..targets.len() {
			let mut why = Vec::new();
			for (name, v) in [("costs", got.costs[i]), ("yards", got.yards[i]), ("jumps", got.jumps[i])] {
				if v.to_bits() != f(&w[name][i]).to_bits() {
					why.push(format!("{name} {v} vs {}", w[name][i]));
				}
			}
			if got.reasons[i].as_deref() != w["reasons"][i].as_str() {
				why.push(format!("reason {:?} vs {}", got.reasons[i], w["reasons"][i]));
			}
			let chain = got.chains.as_ref().unwrap()[i].clone();
			let wchain: Option<Vec<i64>> = w["chains"][i].as_array().map(|a| a.iter().map(|v| v.as_i64().unwrap()).collect());
			if chain != wchain {
				why.push(format!("chain {chain:?} vs {wchain:?}"));
			}
			if got.costs[i] >= 0.0 {
				let cells = nav.chain_cells(map, from, targets[i], chain.as_deref().unwrap_or(&[]), got.yards[i]);
				let flat: Vec<f64> = cells.iter().flat_map(|c| [c.0, c.1]).collect();
				let wcells: Vec<f64> = w["cells"][i].as_array().unwrap().iter().map(|v| v.as_f64().unwrap()).collect();
				if flat.len() != wcells.len() || flat.iter().zip(&wcells).any(|(a, b)| a.to_bits() != b.to_bits()) {
					why.push("cells".into());
				}
			}
			if !why.is_empty() {
				bad.push(format!("{id} target {i}: {}", why.join("; ")));
			}
		}
	}
	let nb = batches.len() as f64;
	eprintln!("batches: {}; per batch ms: rust cold {:.1} warm {:.1}; node cold {:.1} warm {:.1}", batches.len(), mcold / nb, mwarm / nb, nmcold / nb, nmwarm / nb);

	// The same routes on 8 threads over the shared cache: the same answers.
	let t = Instant::now();
	let par: Vec<_> = routes.par_iter().map(|r| nav.route(r["map"].as_u64().unwrap() as u32, point(&r["from"]), point(&r["to"]), &opts(r, Validate::Tolerant))).collect();
	eprintln!("parallel pass: {:.0} ms", t.elapsed().as_secs_f64() * 1e3);
	// Bitwise (Debug) equality: unknown heights are NaN.
	let pdiff = par.iter().zip(&got_all).filter(|(a, b)| format!("{a:?}") != format!("{b:?}")).count();
	assert_eq!(pdiff, 0, "parallel answers differ");
	let s = nav.stats();
	eprintln!(
		"cache: {} decodes, {} graph decodes, {} ms decoding, {:.1} MB cached (peak {:.1} MB, limit {cache_mb} MB), {} evictions; node {}",
		s.decodes, s.graph_decodes, s.decode_ms, s.cached_mb, s.peak_mb, s.evictions, rf["stats"]
	);
	if let Ok(st) = std::fs::read_to_string("/proc/self/status") {
		for l in st.lines().filter(|l| l.starts_with("VmHWM") || l.starts_with("VmRSS")) {
			eprintln!("  {l}");
		}
	}
	eprintln!("node peak RSS {:.0} MB", f(&rf["peakRssMB"]));
	for b in bad.iter().take(30) {
		eprintln!("MISMATCH {b}");
	}
	assert!(bad.is_empty(), "{} mismatches", bad.len());
}

/// The acceptance walks (parity/accept-leffe.json) of maps 0 and 1.
fn acceptance() -> Vec<Value> {
	let doc: Value = serde_json::from_str(&std::fs::read_to_string(concat!(env!("CARGO_MANIFEST_DIR"), "/parity/accept-leffe.json")).unwrap()).unwrap();
	doc["routes"].as_array().unwrap().iter().filter(|r| matches!(r["map"].as_u64(), Some(0 | 1)) && r["from"].is_array()).cloned().collect()
}

/// Leffe's lift layer (lift-layer/lifts.json with the pack): Thunder Bluff's bluff, an island on his graph alone,
/// and the Undercity, left by its west sewer pipe there, are walked over their lifts: one ride, a leg of the Lift
/// move up or down the shaft, priced as our grid prices a ride; FindMany prices the walk as the route does.
#[test]
#[ignore = "needs POLESTAR_LEFFE_NAV (the 70532 candidate, its lift-layer/ beside it)"]
fn lifts_thunder_bluffs_bluff_and_the_undercity_are_walked_over_their_lifts() {
	let lifted = open(512);
	assert!(lifted.lift_layer().is_some(), "Leffe's lift layer is spliced");
	let mut bare = open(512);
	bare.set_lifts(None);
	let o = Opts { profile: Some("Horde"), validate: Validate::Tolerant, ..Default::default() };
	let walks = [
		("Red Rocks up to Tal", 1, P { x: -992.7, y: -1109.1, z: Some(44.5) }, P { x: -1196.7, y: 26.1, z: Some(177.0) }),
		("Cuely down in the Undercity out to the Bulwark", 0, P { x: 1421.0, y: 405.9, z: Some(-85.2) }, P { x: 1760.8, y: -723.2, z: Some(60.0) }),
	];
	for (name, map, a, b) in walks {
		let before = bare.route(map, a, b, &o);
		let after = lifted.route(map, a, b, &o);
		let rides: Vec<_> = after.legs.iter().filter(|l| l.kind == Move::Lift).collect();
		eprintln!(
			"{name}: his graph alone {} (cost {:.1}, {:.1} yd); with the lifts {} (cost {:.1}, {:.1} yd, {} ride)",
			before.reason.as_deref().unwrap_or("ok"),
			before.cost,
			before.yards,
			after.reason.as_deref().unwrap_or("ok"),
			after.cost,
			after.yards,
			rides.len()
		);
		assert!(before.legs.iter().all(|l| l.kind != Move::Lift), "{name}: no ride without the layer");
		assert!(after.ok && rides.len() == 1, "{name}: one ride");
		let dz = (after.points[rides[0].to][2] - after.points[rides[0].from][2]).abs();
		assert!(dz > 50.0, "{name}: the ride climbs or falls the shaft ({dz:.1} yd)");
		if map == 0 {
			let p = after.points[rides[0].from];
			assert!(((p[0] - 1544.2).powi(2) + (p[1] - 240.8).powi(2)).sqrt() < 20.0, "{name}: the Undercity's south lift, its only way in and out ({p:?})");
		}
		let many = lifted.route_many(map, a, &[b], &o);
		assert!((many.costs[0] - after.cost).abs() <= 1e-9 * after.cost, "{name}: FindMany {} vs the route {}", many.costs[0], after.cost);
	}
	assert!(!bare.route(1, walks[0].2, walks[0].3, &o).ok, "the bluff is an island on his graph alone");
}

/// Walks no lift serves are answered with the lift layer as without it, bit for bit: every acceptance walk of maps 0
/// and 1 whose route rides no lift (cost, points, legs, events), and FindMany from each acceptance start to every
/// acceptance end of its map, for each target whose chain passes no landing (costs, yards, jumps, reasons).
#[test]
#[ignore = "needs POLESTAR_LEFFE_NAV (the 70532 candidate, its lift-layer/ beside it)"]
fn lifts_leave_every_walk_no_lift_serves_as_his_reader_answers_it() {
	let lifted = open(1024);
	assert!(lifted.lift_layer().is_some(), "Leffe's lift layer is spliced");
	let mut bare = open(1024);
	bare.set_lifts(None);
	let walks = acceptance();
	let mut bad = Vec::new();
	let (mut same, mut rides) = (0, 0);
	for r in &walks {
		let (map, a, b, o) = (r["map"].as_u64().unwrap() as u32, point(&r["from"]), point(&r["to"]), opts(r, Validate::Tolerant));
		let (x, y) = (bare.route(map, a, b, &o), lifted.route(map, a, b, &o));
		let id = r["id"].as_str().unwrap();
		if y.legs.iter().any(|l| l.kind == Move::Lift) {
			rides += 1;
			eprintln!("  {id}: rides a lift: cost {:.1} -> {:.1}, {:.1} -> {:.1} yd ({})", x.cost, y.cost, x.yards, y.yards, x.reason.as_deref().unwrap_or("ok"));
		} else if format!("{x:?}") == format!("{y:?}") {
			same += 1;
		} else {
			bad.push(format!("{id}: route differs without a ride: {} {:.3} vs {} {:.3}", x.ok, x.cost, y.ok, y.cost));
		}
	}
	let (mut many_same, mut many_lift) = (0, 0);
	for map in [0u32, 1] {
		let on: Vec<&Value> = walks.iter().filter(|r| r["map"].as_u64() == Some(map as u64)).collect();
		let targets: Vec<P> = on.iter().map(|r| point(&r["to"])).collect();
		for r in &on {
			let mut o = opts(r, Validate::Tolerant);
			o.chains = true;
			let from = point(&r["from"]);
			let (x, y) = (bare.route_many(map, from, &targets, &o), lifted.route_many(map, from, &targets, &o));
			for i in 0..targets.len() {
				let lift = y.chains.as_ref().unwrap()[i].as_ref().is_some_and(|c| c.iter().any(|&id| id >= 1 << 46));
				if lift {
					many_lift += 1;
				} else if [(x.costs[i], y.costs[i]), (x.yards[i], y.yards[i]), (x.jumps[i], y.jumps[i])].iter().all(|(p, q)| p.to_bits() == q.to_bits())
					&& x.reasons[i] == y.reasons[i]
					&& x.chains.as_ref().unwrap()[i] == y.chains.as_ref().unwrap()[i]
				{
					many_same += 1;
				} else {
					bad.push(format!("{} -> target {i}: FindMany differs without a ride: {} vs {}", r["id"], x.costs[i], y.costs[i]));
				}
			}
		}
	}
	eprintln!("routes: {same} unchanged, {rides} ride a lift; FindMany targets: {many_same} unchanged, {many_lift} over a lift; {} differ", bad.len());
	for b in bad.iter().take(30) {
		eprintln!("MISMATCH {b}");
	}
	assert!(bad.is_empty(), "{} walks no lift serves changed", bad.len());
}

/// A lift layer for another build of the grid is refused: no lifts on the maps.
#[test]
#[ignore = "needs POLESTAR_LEFFE_NAV (the 70532 candidate, its lift-layer/ beside it)"]
fn lifts_a_layer_for_another_grid_build_is_refused() {
	let d = std::env::var_os("POLESTAR_LEFFE_NAV").map(PathBuf::from).unwrap();
	let nav = if d.join("Nav.xml").exists() { d.clone() } else { d.join("Nav") };
	let layer = forge_nav::f4::lifts::find(&nav).expect("a lift layer with the pack");
	let tmp = std::env::temp_dir().join(format!("f4-lifts-other-build-{}", std::process::id()));
	std::fs::create_dir_all(tmp.join("lift-layer")).unwrap();
	std::os::unix::fs::symlink(&nav, tmp.join("Nav")).unwrap();
	std::fs::copy(&layer, tmp.join("lift-layer/lifts.json")).unwrap();
	std::fs::write(tmp.join("PACK.json"), r#"{ "grid": { "build": "1.60.1.1", "buildConfig": "0000" } }"#).unwrap();
	let other = F4::open(&tmp, 64).unwrap();
	std::fs::remove_dir_all(&tmp).unwrap();
	assert_eq!(other.lift_layer(), None);
	assert!(forge_nav::f4::lifts::load(&layer, &nav).is_ok(), "its own pack takes it");
}
