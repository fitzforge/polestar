//! `forge judge doors`: the dungeon runs in the leveling guides against their floors (Fitz, 2026-11-13: never
//! send a player to a dungeon too low).
//!
//! - The walk to the door ([`door_zones`], blocker): from the route's stop before a run (a `when dungeon
//!   "<Name>"` step, not negated, with an `enter` goal) to its door, by the legs the guides write (their
//!   walks and flights), every zone a walk crosses on the world's danger grid, each walk's end and each
//!   flight's landing, but not the stop's own zone, against the run's level gate (its `when level>=`): a
//!   zone whose danger level (the world's: its lowest level, or its danger floor) is the gate +
//!   [`DOOR_GAP`] or more sends a player at the gate among mobs 4 levels over them (the in-game planner's
//!   mark, Nav/Danger.lua). A flight crosses nothing.
//! - With the calibrated level model's output (`--levels`, the files the danger gate reads), a run the model
//!   places under its floor ([`Rule::UnderFloor`], warning: the gate hides it for most players; borderline
//!   runs would flap with each model update), and a pick-up whose gate isn't the floor less the levels the
//!   model plans between it and the run ([`Rule::PickupGate`], warning).
//!
//! The floor is the Codex's (`Data::dungeon_floors`); a run gated under it is forge-guide's lint error.

use crate::check::{Level, Violation};
use crate::walk::{wpt, WPt};
use forge_guide::data::Data;
use forge_guide::js::V;
use forge_world::world::Danger;
use rustc_hash::FxHashMap;
use std::collections::BTreeMap;

/// Levels over a run's gate from which a zone on the walk to the door is dangerous.
pub const DOOR_GAP: f64 = 4.0;

/// How far a pick-up's gate may sit from the floor less the levels the model plans before the run.
pub const PICKUP_SLACK: f64 = 0.5;

/// The rules, as their lines name them.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Rule {
	DoorDanger,
	UnderFloor,
	PickupGate,
}

impl Rule {
	pub fn as_str(self) -> &'static str {
		match self {
			Rule::DoorDanger => "door-danger",
			Rule::UnderFloor => "under-floor",
			Rule::PickupGate => "pickup-gate",
		}
	}
}

/// A point the walk to a door reaches: where, and whether a flight brought the player there (its zone is a
/// landing; the leg to it crosses nothing).
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Leg {
	pub to: WPt,
	pub flown: bool,
}

/// The zones the walk from `stop` along `legs` meets whose danger level (`zone_min`) is `gate` + [`DOOR_GAP`]
/// or more, in the order met, with that level; the stop's own zone is the route's anyway and left out.
pub fn door_zones(stop: &WPt, legs: &[Leg], gate: f64, grids: &[Danger], zone_min: &BTreeMap<u32, f64>) -> Vec<(u32, f64)> {
	let mut met: Vec<u32> = Vec::new();
	let add = |z: u32, met: &mut Vec<u32>| {
		if z != 0 && z != stop.map && !met.contains(&z) {
			met.push(z);
		}
	};
	let mut at = *stop;
	for leg in legs {
		if !leg.flown && leg.to.c == at.c {
			for z in crossed(grids, &at, &leg.to) {
				add(z, &mut met);
			}
		}
		add(leg.to.map, &mut met);
		at = leg.to;
	}
	met.into_iter().filter_map(|z| zone_min.get(&z).copied().filter(|l| *l >= gate + DOOR_GAP).map(|l| (z, l))).collect()
}

/// The zones a straight walk from `a` to `b` crosses on the danger grids of its continent (a world region's
/// grid: region = continent × 10 + island), sampled once a grid cell as the travel planner's crossedZones
/// does, both ends included.
fn crossed(grids: &[Danger], a: &WPt, b: &WPt) -> Vec<u32> {
	let mine: Vec<&Danger> = grids.iter().filter(|g| g.region.div_euclid(10) == a.c).collect();
	let Some(cell) = mine.first().map(|g| g.cell) else { return Vec::new() };
	let (dx, dy) = (b.wx - a.wx, b.wy - a.wy);
	let n = (dx.hypot(dy) / cell).ceil().max(1.0) as i64;
	let mut out = Vec::new();
	for i in 0..=n {
		let (x, y) = (a.wx + dx * i as f64 / n as f64, a.wy + dy * i as f64 / n as f64);
		for g in &mine {
			let gx = (x / g.cell).floor() as i64 - g.gx0;
			let gy = (y / g.cell).floor() as i64 - g.gy0;
			if gx < 0 || gy < 0 || gx >= g.nx || gy >= g.ny {
				continue;
			}
			let z = g.z[(gx * g.ny + gy) as usize];
			if z != 0 {
				if !out.contains(&z) {
					out.push(z);
				}
				break;
			}
		}
	}
	out
}

/// A step's non-negated `when dungeon` predicate: the dungeon a runner chose.
fn dungeon_of(step: &V) -> Option<V> {
	step.get("when").items().into_iter().find(|p| p.get("k").as_str() == Some("dungeon") && !p.get("neg").truthy())
}

fn same_dungeon(a: &V, b: &V) -> bool {
	let k = |p: &V| p.get("name").to_js_string().trim().trim_start_matches("The ").to_lowercase();
	k(a) == k(b)
}

/// Whether a runner of `dungeon` plays `step`: not the solo way round it (`when !dungeon` of it) and not another
/// dungeon's step.
fn runner_plays(step: &V, dungeon: &V) -> bool {
	step.get("when").items().iter().all(|p| p.get("k").as_str() != Some("dungeon") || (same_dungeon(p, dungeon) != p.get("neg").truthy()))
}

fn is_run(step: &V) -> bool {
	dungeon_of(step).is_some() && step.get("goals").items().iter().any(|g| g.get("t").as_str() == Some("enter"))
}

/// Goals that move the player without doing anything where they end: the walk's waypoints.
const WAYPOINTS: [&str; 4] = ["goto", "fly", "enter", "note"];

/// The flight landing of a `fly` goal: the data's taxi node its location names (short or full name, of the
/// faction's side or neutral), as `check::land_flights` finds it.
fn landing(goal: &V, data: &Data, proj: &forge_core::Projector, side: f64) -> Option<WPt> {
	let loc = goal.get("location").to_js_string().to_lowercase();
	let node = data.travel.get("taxi").get("nodes").items().into_iter().find(|n| {
		let f = n.get("faction").as_num();
		((f != Some(1.0) && f != Some(2.0)) || f == Some(side)) && [n.get("short"), n.get("name")].iter().any(|s| s.to_js_string().to_lowercase() == loc)
	})?;
	wpt(proj, &node.get("map"), &node.get("x"), &node.get("y"), &V::Undef)
}

fn point(goal: &V, proj: &forge_core::Projector) -> Option<WPt> {
	wpt(proj, &goal.get("map"), &goal.get("x"), &goal.get("y"), &goal.get("f"))
}

/// One run of the leveling guides: where it is, its dungeon, its gate, and the walk to its door.
#[derive(Clone, Debug)]
pub struct Run {
	pub guide: String,
	pub file: String,
	pub line: u32,
	/// 1-based, as the Engine counts steps.
	pub step: usize,
	pub dungeon: String,
	pub map: Option<u32>,
	pub gate: f64,
	/// The stop the walk starts at (None: nothing located before the run in its guide).
	pub stop: Option<WPt>,
	pub legs: Vec<Leg>,
}

/// Every run of `guides` (compiled), with the walk to its door: back from the run over the steps a runner
/// plays to the last goal that does something where it stands (the stop), then forward through the walks
/// (`goto`) and flights (`fly`, to its landing) to the `enter`.
pub fn runs(guides: &[V], data: &Data, proj: &forge_core::Projector, faction: &str) -> Vec<Run> {
	let side = if faction.eq_ignore_ascii_case("alliance") { 1.0 } else { 2.0 };
	let mut out = Vec::new();
	for g in guides {
		let steps = g.get("steps").items();
		for (s, step) in steps.iter().enumerate() {
			if !is_run(step) {
				continue;
			}
			let Some(d) = dungeon_of(step) else { continue };
			let goals = step.get("goals").items();
			let enter_at = goals.iter().position(|x| x.get("t").as_str() == Some("enter")).unwrap_or(0);
			// The run step's own goals before its `enter`, then the steps before it, newest first.
			let mut back: Vec<V> = goals[..enter_at].iter().rev().cloned().collect();
			for prev in steps[..s].iter().rev().filter(|p| runner_plays(p, &d)) {
				back.extend(prev.get("goals").items().into_iter().rev());
			}
			let mut path: Vec<V> = Vec::new();
			let mut stop = None;
			for x in back {
				let t = x.get("t").to_js_string();
				if WAYPOINTS.contains(&t.as_str()) {
					path.push(x);
				} else if let Some(p) = point(&x, proj) {
					stop = Some(p);
					break;
				}
			}
			path.reverse();
			let mut legs = Vec::new();
			for x in &path {
				match x.get("t").as_str() {
					Some("fly") => legs.extend(landing(x, data, proj, side).map(|to| Leg { to, flown: true })),
					Some("goto") => legs.extend(point(x, proj).map(|to| Leg { to, flown: false })),
					_ => {}
				}
			}
			let enter = &goals[enter_at];
			legs.extend(point(enter, proj).map(|to| Leg { to, flown: false }));
			let stop = stop.or_else(|| legs.first().map(|l| l.to));
			out.push(Run {
				guide: g.get("id").to_js_string(),
				file: g.hidden("_ast").get("file").to_js_string(),
				line: enter.hidden("_line").as_num().unwrap_or(0.0) as u32,
				step: s + 1,
				dungeon: d.get("name").to_js_string(),
				map: d.get("map").as_num().map(|m| m as u32),
				gate: forge_guide::validate::lowest_level(step),
				stop,
				legs,
			});
		}
	}
	out
}

/// The blocker for each run whose walk to the door meets a zone [`DOOR_GAP`] or more over its gate.
pub fn door_danger(runs: &[Run], grids: &[Danger], zone_min: &BTreeMap<u32, f64>, zone_name: &dyn Fn(u32) -> String) -> Vec<Violation> {
	let mut out = Vec::new();
	for r in runs {
		let Some(stop) = r.stop else { continue };
		let hot = door_zones(&stop, &r.legs, r.gate, grids, zone_min);
		if hot.is_empty() {
			continue;
		}
		let zones: Vec<String> = hot.iter().map(|(z, l)| format!("{} ({})", zone_name(*z), forge_guide::js::num_str(*l))).collect();
		out.push(Violation::new(
			r.file.clone(),
			r.line,
			Rule::DoorDanger.as_str(),
			Level::Blocker,
			format!(
				"the walk to the door of {} from the stop before it crosses {}, {} or more levels over the run's gate ({}): gate the run higher or start it from a nearer stop",
				r.dungeon,
				zones.join(", "),
				forge_guide::js::num_str(DOOR_GAP),
				forge_guide::js::num_str(r.gate)
			),
		));
	}
	out
}

/// The calibrated level model's output (danger.js `levelsOf`): per guide id, its start level and the level
/// after each quest's hand-in, each the mean over the model's race × class branches.
#[derive(Clone, Debug, Default)]
pub struct ModelLevels {
	pub start: FxHashMap<String, f64>,
	pub after: FxHashMap<String, FxHashMap<i64, f64>>,
}

impl ModelLevels {
	/// From the model's output files: arrays of branches `{ rows: [{ id, start, tq: [[quest, level], ...] }] }`.
	pub fn from_files(docs: &[serde_json::Value]) -> ModelLevels {
		let mut start: FxHashMap<String, Vec<f64>> = FxHashMap::default();
		let mut after: FxHashMap<String, FxHashMap<i64, Vec<f64>>> = FxHashMap::default();
		for doc in docs {
			for branch in doc.as_array().into_iter().flatten() {
				for r in branch["rows"].as_array().into_iter().flatten() {
					let Some(id) = r["id"].as_str() else { continue };
					if let Some(s) = r["start"].as_f64() {
						start.entry(id.to_string()).or_default().push(s);
					}
					for tq in r["tq"].as_array().into_iter().flatten() {
						if let (Some(q), Some(l)) = (tq[0].as_i64(), tq[1].as_f64()) {
							after.entry(id.to_string()).or_default().entry(q).or_default().push(l);
						}
					}
				}
			}
		}
		let mean = |v: &Vec<f64>| v.iter().sum::<f64>() / v.len() as f64;
		ModelLevels { start: start.iter().map(|(k, v)| (k.clone(), mean(v))).collect(), after: after.iter().map(|(k, m)| (k.clone(), m.iter().map(|(q, v)| (*q, mean(v))).collect())).collect() }
	}

	/// The model's level at step `s` (0-based) of guide `g` (danger.js's reading): its start, raised by the
	/// guide's own `level` goals and the hand-ins before the step. None for a guide the model didn't play.
	pub fn at(&self, g: &V, s: usize) -> Option<f64> {
		let id = g.get("id").to_js_string();
		let mut level = *self.start.get(&id)?;
		let after = self.after.get(&id);
		for step in g.get("steps").items().iter().take(s) {
			for goal in step.get("goals").items() {
				match goal.get("t").as_str() {
					Some("level") => level = level.max(goal.get("level").as_num().unwrap_or(0.0)),
					Some("turnin") => {
						if let Some(l) = goal.get("quest").as_num().and_then(|q| after?.get(&(q as i64))) {
							level = level.max(*l);
						}
					}
					_ => {}
				}
			}
		}
		Some(level)
	}
}

/// The model's warnings: each run it places under its floor, and each pick-up whose gate isn't the floor less
/// the levels it plans between the pick-up and the dungeon's next run (within [`PICKUP_SLACK`]).
pub fn model_warnings(guides: &[V], floors: &V, lm: &ModelLevels) -> Vec<Violation> {
	let floor_of = |d: &V| floors.get(&d.get("map").to_js_string()).get("floor").as_num();
	// Every run with the model's level there, by dungeon.
	let mut at_runs: Vec<(V, f64)> = Vec::new();
	for g in guides {
		for (s, step) in g.get("steps").items().iter().enumerate() {
			if let (true, Some(d), Some(l)) = (is_run(step), dungeon_of(step), lm.at(g, s)) {
				at_runs.push((d, l));
			}
		}
	}
	let mut out = Vec::new();
	for g in guides {
		let file = g.hidden("_ast").get("file").to_js_string();
		for (s, step) in g.get("steps").items().iter().enumerate() {
			let (Some(d), Some(level)) = (dungeon_of(step), lm.at(g, s)) else { continue };
			let Some(floor) = floor_of(&d) else { continue };
			let goals = step.get("goals").items();
			let line = goals.first().map_or(0, |x| x.hidden("_line").as_num().unwrap_or(0.0) as u32);
			let name = d.get("name").to_js_string();
			let n = forge_guide::js::num_str;
			let r1 = |x: f64| (x * 10.0).round() / 10.0;
			if is_run(step) {
				if level < floor {
					out.push(Violation::new(
						file.clone(),
						line,
						Rule::UnderFloor.as_str(),
						Level::Warn,
						format!("the level model's players reach this {name} run at {}, under its floor of {}: its gate hides the run for most of them", n(r1(level)), n(floor)),
					));
				}
			} else if goals.iter().any(|x| x.get("t").as_str() == Some("accept")) {
				let Some(run) = at_runs.iter().filter(|(rd, l)| same_dungeon(rd, &d) && *l >= level).map(|(_, l)| *l).reduce(f64::min) else { continue };
				let want = floor - (run - level);
				let gate = forge_guide::validate::lowest_level(step);
				if (gate - want).abs() > PICKUP_SLACK {
					out.push(Violation::new(
						file.clone(),
						line,
						Rule::PickupGate.as_str(),
						Level::Warn,
						format!("this {name} pick-up is gated at {}; the floor {} less the {} levels the model plans before the run gives {}", n(r1(gate)), n(floor), n(r1(run - level)), n(r1(want))),
					));
				}
			}
		}
	}
	out
}

#[cfg(test)]
mod tests {
	use super::*;

	/// A row of zones along the x axis, 100-yard cells, one cell deep: each zone `width` cells wide.
	fn grid(zones: &[(u32, i64)]) -> Vec<Danger> {
		let z: Vec<u32> = zones.iter().flat_map(|&(z, w)| std::iter::repeat_n(z, w as usize)).collect();
		vec![Danger { region: 0, gx0: 0, gy0: 0, nx: z.len() as i64, ny: 1, cell: 100.0, z }]
	}

	fn at(x: f64, map: u32) -> WPt {
		WPt { c: 0, wx: x, wy: 50.0, map }
	}

	fn walk(to: WPt) -> Leg {
		Leg { to, flown: false }
	}

	// Zone ids as the game numbers them; levels as the world's danger levels give them.
	const BADLANDS: u32 = 1418;
	const SEARING_GORGE: u32 = 1427;
	const BLACKROCK_MOUNTAIN: u32 = 1428;
	const DUSKWOOD: u32 = 1431;
	const DEADWIND_PASS: u32 = 1430;
	const SWAMP: u32 = 1435;
	const UNDERCITY: u32 = 1458;
	const TIRISFAL: u32 = 1420;

	fn levels() -> BTreeMap<u32, f64> {
		[(BADLANDS, 36.0), (SEARING_GORGE, 45.0), (DUSKWOOD, 18.0), (DEADWIND_PASS, 55.0), (SWAMP, 36.0), (TIRISFAL, 1.0)].into_iter().collect()
	}

	/// Fitz's examples (2026-11-13): Blackrock Depths gated 40 through the Searing Gorge (45) is dangerous, at its
	/// floor of 52 it isn't; the Sunken Temple gated 30 on foot from Darkshire crosses Deadwind Pass (55) and ends in
	/// the Swamp (36); the Ruins of Lordaeron gated 15 from the Undercity is a walk in Tirisfal (1).
	#[test]
	fn the_walk_to_the_door_is_dangerous_from_four_levels_over_the_gate() {
		let brd = grid(&[(BADLANDS, 5), (SEARING_GORGE, 5), (BLACKROCK_MOUNTAIN, 2)]);
		let (kargath, gorge, door) = (at(50.0, BADLANDS), at(750.0, SEARING_GORGE), at(1150.0, BLACKROCK_MOUNTAIN));
		let legs = [walk(gorge), walk(door)];
		assert_eq!(door_zones(&kargath, &legs, 40.0, &brd, &levels()), vec![(SEARING_GORGE, 45.0)]);
		assert_eq!(door_zones(&kargath, &legs, 52.0, &brd, &levels()), vec![], "at the floor: 45 is under 56");
		assert_eq!(door_zones(&kargath, &legs, 41.0, &brd, &levels()), vec![(SEARING_GORGE, 45.0)], "41 + 4 = 45: at the mark");
		assert_eq!(door_zones(&kargath, &legs, 41.1, &brd, &levels()), vec![]);

		let st = grid(&[(DUSKWOOD, 4), (DEADWIND_PASS, 4), (SWAMP, 4)]);
		let (darkshire, door) = (at(50.0, DUSKWOOD), at(1150.0, SWAMP));
		assert_eq!(door_zones(&darkshire, &[walk(door)], 30.0, &st, &levels()), vec![(DEADWIND_PASS, 55.0), (SWAMP, 36.0)]);
		assert_eq!(door_zones(&darkshire, &[walk(door)], 50.0, &st, &levels()), vec![(DEADWIND_PASS, 55.0)], "the Swamp's 36 is no danger at 50");

		let rol = grid(&[(UNDERCITY, 3), (TIRISFAL, 3)]);
		assert_eq!(door_zones(&at(50.0, UNDERCITY), &[walk(at(450.0, TIRISFAL))], 15.0, &rol, &levels()), vec![]);
	}

	#[test]
	fn the_stops_own_zone_is_left_out_and_a_flight_crosses_nothing_but_lands_somewhere() {
		let g = grid(&[(SEARING_GORGE, 3), (DEADWIND_PASS, 3), (SWAMP, 3)]);
		// A stop in the Searing Gorge: its own zone is the route's anyway.
		assert_eq!(door_zones(&at(50.0, SEARING_GORGE), &[walk(at(250.0, SEARING_GORGE))], 30.0, &g, &levels()), vec![]);
		// A flight over Deadwind Pass to the Swamp: the landing counts, the ground under the flight doesn't.
		let flown = [Leg { to: at(750.0, SWAMP), flown: true }, walk(at(850.0, SWAMP))];
		assert_eq!(door_zones(&at(50.0, SEARING_GORGE), &flown, 30.0, &g, &levels()), vec![(SWAMP, 36.0)]);
		assert_eq!(door_zones(&at(50.0, SEARING_GORGE), &flown, 33.0, &g, &levels()), vec![]);
	}

	fn guide(json: serde_json::Value) -> V {
		forge_guide::js::parse_json(&json.to_string()).unwrap()
	}

	fn rk() -> serde_json::Value {
		serde_json::json!({ "k": "dungeon", "name": "Razorfen Kraul", "map": 47 })
	}

	#[test]
	fn the_model_warns_of_a_run_under_its_floor_and_a_pick_up_gated_off_its_plan() {
		let g = guide(serde_json::json!({ "id": "forever/horde/07", "steps": [
			{ "title": "Pick-up", "when": [rk(), { "k": "level", "op": ">=", "n": 27, "frac": 0.9 }], "goals": [{ "t": "accept", "quest": 1109 }] },
			{ "title": "Hand-in", "goals": [{ "t": "turnin", "quest": 1 }] },
			{ "title": "Hand-in", "goals": [{ "t": "turnin", "quest": 2 }] },
			{ "title": "Run", "when": [rk(), { "k": "level", "op": ">=", "n": 30, "frac": 0.9 }], "goals": [{ "t": "enter", "map": 1413, "x": 42.9, "y": 90.2 }] },
		] }));
		let floors = guide(serde_json::json!({ "47": { "name": "Razorfen Kraul", "floor": 30.9 } }));
		let lm = |start: f64, q1: f64, q2: f64| ModelLevels::from_files(&[serde_json::json!([{ "rows": [{ "id": "forever/horde/07", "start": start, "tq": [[1, q1], [2, q2]] }] }])]);
		// On pace: picked up at 28, run at 31 (3 levels on): the pick-up's gate is 30.9 - 3 = 27.9, the run is over its floor.
		assert!(model_warnings(std::slice::from_ref(&g), &floors, &lm(28.0, 29.5, 31.0)).is_empty());
		// The model at 29.6 by the run: under 30.9.
		let w = model_warnings(std::slice::from_ref(&g), &floors, &lm(26.6, 28.0, 29.6));
		assert_eq!(w.iter().map(|v| v.rule.as_str()).collect::<Vec<_>>(), ["under-floor"]);
		assert!(w[0].message.contains("at 29.6, under its floor of 30.9"), "{}", w[0].message);
		// Picked up at 28 but run at 33 (5 levels on): the pick-up wants 25.9, and its 27.9 is off by 2.
		let w = model_warnings(std::slice::from_ref(&g), &floors, &lm(28.0, 30.0, 33.0));
		assert_eq!(w.iter().map(|v| v.rule.as_str()).collect::<Vec<_>>(), ["pickup-gate"]);
		assert!(w[0].message.contains("gives 25.9"), "{}", w[0].message);
	}

	#[test]
	fn a_runner_plays_its_dungeons_steps_and_the_solo_ones_not_the_way_round_or_another_dungeons() {
		let dm = guide(serde_json::json!({ "k": "dungeon", "name": "The Deadmines" }));
		let step = |when: serde_json::Value| guide(serde_json::json!({ "when": when, "goals": [] }));
		assert!(runner_plays(&step(serde_json::json!([])), &dm));
		assert!(runner_plays(&step(serde_json::json!([{ "k": "dungeon", "name": "Deadmines" }])), &dm));
		assert!(!runner_plays(&step(serde_json::json!([{ "k": "dungeon", "neg": true, "name": "The Deadmines" }])), &dm));
		assert!(!runner_plays(&step(serde_json::json!([{ "k": "dungeon", "name": "The Stockade" }])), &dm));
		assert!(runner_plays(&step(serde_json::json!([{ "k": "dungeon", "neg": true, "name": "The Stockade" }])), &dm));
	}
}
