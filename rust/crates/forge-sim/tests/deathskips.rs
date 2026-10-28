//! Deathskips (`--deathskips`, the deathskips parameter; eval Evaluator::deathskip): a leg may die at
//! a lethal spot near where it starts and go on from the graveyard the game resurrects the death at,
//! where that beats the leg by DEATHSKIP_GAIN_SEC and the level costs no resurrection sickness.
//!
//! The known case is the Undead's road out of Deathknell to Brill (Tirisfal Glades, map 1420), at
//! the game's graveyards there (CMaNGOS: Deathknell 94, Brill 289, both linked to Tirisfal for the
//! Horde): a character on the road 40% of the way from Deathknell's graveyard to Brill's goes to
//! an inn 250 yd past Brill's. A death by the road is resurrected at Deathknell until past halfway,
//! so the lethal spot is the camp just past it (52%, 147 yd on), not one by the start.

mod common;
use forge_core::Faction;
use forge_sim::eval::{Trace, DEATHSKIP_GAIN_SEC};
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::run::{TravelPlan, K_VISIT};
use forge_sim::{Model, NoWalks, Params, Step};
use forge_world::World;
use serde_json::{json, Value};
use std::sync::Arc;

const DEATHKNELL: (f64, f64, f64) = (1882.9, 1629.1, 94.4);
const BRILL: (f64, f64, f64) = (2348.7, 492.0, 33.4);

/// A point `t` of the way from Deathknell's graveyard to Brill's (past it for t > 1).
fn along(t: f64) -> (f64, f64) {
	(DEATHKNELL.0 + t * (BRILL.0 - DEATHKNELL.0), DEATHKNELL.1 + t * (BRILL.1 - DEATHKNELL.1))
}

struct Case {
	world: World,
	/// World points: the start, the inn in Brill, the spot past halfway, a spot by the start.
	start: u32,
	inn: u32,
	spot: u32,
	near: u32,
}

/// The golden Horde slice with the Tirisfal case added: its points (the start and the inn as inns,
/// so every run has them), the two graveyards and two kill camps of level 8 mobs.
fn case() -> Case {
	let mut w: Value = serde_json::from_slice(&common::gunzip(&common::golden().join("world/expected/world-horde.json.gz"))).unwrap();
	let pts = w["points"].as_array_mut().unwrap();
	let mut add = |x: f64, y: f64, z: Option<f64>| {
		pts.push(json!([0, 0, x, y, 1420, z]));
		(pts.len() - 1) as u32
	};
	let (sx, sy) = along(0.4);
	let start = add(sx, sy, None);
	let len = (BRILL.0 - DEATHKNELL.0).hypot(BRILL.1 - DEATHKNELL.1);
	let (ix, iy) = along(1.0 + 250.0 / len);
	let inn = add(ix, iy, None);
	let (px, py) = along(0.52);
	let spot = add(px, py, None);
	let (nx, ny) = along(0.38);
	let near = add(nx, ny, None);
	let dk = add(DEATHKNELL.0, DEATHKNELL.1, Some(DEATHKNELL.2));
	let br = add(BRILL.0, BRILL.1, Some(BRILL.2));
	w["inns"].as_array_mut().unwrap().extend([json!({ "name": "Start", "pt": start }), json!({ "name": "Brill", "pt": inn })]);
	let camps = w["camps"].as_array_mut().unwrap();
	for (pt, npc) in [(spot, 1890), (near, 1501)] {
		let id = camps.len();
		camps.push(json!({ "id": id, "pt": pt, "c": 0, "region": 0, "radius": 60, "spawns": 6, "levelMin": 7, "levelMax": 8, "respawn": 300,
			"sources": [{ "kind": "npc", "id": npc, "spawns": 6 }] }));
	}
	w["graveyards"] = json!([
		{ "id": 94, "name": "Deathknell", "pt": dk, "loc": [0, DEATHKNELL.0, DEATHKNELL.1, DEATHKNELL.2], "maps": [1420] },
		{ "id": 289, "name": "Brill", "pt": br, "loc": [0, BRILL.0, BRILL.1, BRILL.2], "maps": [1420] },
	]);
	Case { world: World::from_value(&w).unwrap(), start, inn, spot, near }
}

fn model(c: &Case, over: &[(&str, f64)]) -> Model {
	let over: Vec<(String, f64)> = over.iter().map(|(k, v)| (k.to_string(), *v)).collect();
	let base = Params::effective(common::params_doc().as_ref(), None, &over);
	let pr = Profile { plan: Some(Arc::new(TravelPlan::default())), ..Profile::average(Faction::Horde) };
	model_for(&c.world, "Orc", &pr, &base, &NoWalks).unwrap().0
}

/// The leg from the start to the inn at `level`: its seconds, the deathskips taken and the trace.
fn leg(c: &Case, m: &Model, level: usize) -> (f64, u32, Vec<Trace>, f64) {
	let (r, walks) = (&m.run, NoWalks);
	let mut ev = m.evaluator(&walks);
	ev.trace = Some(Vec::new());
	ev.reset();
	ev.s.level = level;
	ev.s.pos = r.run_pt(c.start).unwrap();
	let t0 = ev.s.time;
	assert!(ev.step(Step { kind: K_VISIT, q: 0, task: -1, pt: r.run_pt(c.inn).unwrap() }));
	let priced = ev.s.c.seconds(r, &m.tables.p);
	(ev.s.time - t0, ev.s.deathskips, ev.trace.take().unwrap().into_iter().map(|x| x.1).collect(), priced - ev.s.time)
}

fn yd(w: &World, a: u32, b: u32) -> f64 {
	let (p, q) = (&w.points[a as usize], &w.points[b as usize]);
	(p.wx - q.wx).hypot(p.wy - q.wy)
}

#[test]
fn off_by_default_the_road_to_brill_is_walked() {
	let c = case();
	let m = model(&c, &[]);
	assert!(m.run.deaths.is_empty(), "no deaths priced without the option");
	let (sec, n, trace, _) = leg(&c, &m, 6);
	assert_eq!(n, 0);
	assert!(!trace.iter().any(|t| matches!(t, Trace::Deathskip { .. })));
	let p = &m.tables.p;
	assert!((sec - yd(&c.world, c.start, c.inn) * p.detour0 / p.run_speed).abs() < 1e-6, "the straight walk × detour: {sec:.1} s");
}

#[test]
fn the_road_to_brill_dies_past_halfway_and_rises_at_brill() {
	let c = case();
	let m = model(&c, &[("deathskips", 1.0)]);
	let p = &m.tables.p;
	let walk = yd(&c.world, c.start, c.inn) * p.detour0 / p.run_speed;
	let (sec, n, trace, counters_off) = leg(&c, &m, 6);
	assert_eq!(n, 1, "one deathskip");
	// The walk to the spot past halfway, the death, then Brill's healer to the inn.
	let brill = c.world.graveyards.iter().position(|g| g.name == "Brill").unwrap() as u32;
	let healer = c.world.graveyards[brill as usize].pt;
	let want = yd(&c.world, c.start, c.spot) * p.detour0 / p.run_speed + p.deathskip_sec + yd(&c.world, healer, c.inn) * p.detour0 / p.run_speed;
	assert!((sec - want).abs() < 1e-6, "priced {sec:.1} s, want {want:.1} s (the walk {walk:.1} s)");
	assert!(sec + DEATHSKIP_GAIN_SEC < walk, "beats the walk by a clear margin");
	let ds = trace.iter().find_map(|t| match t {
		Trace::Deathskip { gy, spot, npc, pt, to } => Some((*gy, *spot, *npc, *pt, *to)),
		_ => None,
	});
	let (gy, spot, npc, pt, to) = ds.expect("traced");
	assert_eq!((gy, spot, npc), (brill, c.spot, 1890), "dies at the camp past halfway (the one by the start sends to Deathknell)");
	assert_eq!((m.run.pt_list[pt as usize], m.run.pt_list[to as usize]), (healer, c.inn));
	assert!(counters_off.abs() < 1e-6, "the counters price it: {counters_off}");
	// Not the spot by the start: a death there rises at Deathknell, behind.
	assert_ne!(c.world.graveyard_for(&c.world.points[c.near as usize]), Some(brill as usize));
}

#[test]
fn not_where_the_level_costs_resurrection_sickness() {
	let c = case();
	let m = model(&c, &[("deathskips", 1.0)]);
	assert_eq!(leg(&c, &m, 11).1, 0, "level 11: Forever's resurrection sickness");
	// Allowed above, the sickness is priced (its slowed share of SICKNESS_SEC), and it no longer pays.
	let m = model(&c, &[("deathskips", 1.0), ("deathskipLevel", 60.0)]);
	assert_eq!(leg(&c, &m, 11).1, 0);
}

#[test]
fn not_where_it_saves_too_little() {
	let c = case();
	// A death costing 30 s more than the prior: the gain falls under the margin.
	let m = model(&c, &[("deathskips", 1.0), ("deathskipSec", 90.0)]);
	assert_eq!(leg(&c, &m, 6).1, 0);
}
