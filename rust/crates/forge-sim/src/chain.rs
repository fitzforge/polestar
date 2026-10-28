//! Seeds and replays: v1's chain as events (the judge's goal stream, judge/walk.js), a route's
//! events, and the replay that records level and time after each event.

use crate::eval::{Evaluator, Step};
use crate::seq::{compile_events, Ev, Event, Tagged};
use crate::Run;
use serde::{Deserialize, Serialize};
use serde_json::Value;

/// A goal of a guide chain (judge walk.js `goals`): type, quest, objective, level, where.
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Goal {
	pub i: usize,
	#[serde(default)]
	pub guide: String,
	#[serde(default)]
	pub file: String,
	#[serde(default)]
	pub line: Option<u32>,
	pub t: String,
	#[serde(default)]
	pub q: Option<u32>,
	#[serde(default)]
	pub oi: Option<i64>,
	#[serde(default)]
	pub level: Option<f64>,
	/// Where the goal is (world yards), when located.
	#[serde(default)]
	pub w: Option<GoalW>,
	/// The NPC the goal names (`train 4752`: a trainer by id, not `train class`).
	#[serde(default)]
	pub npc: Option<u32>,
	/// A `train` goal: whether it is `train class` (None: not recorded, as before: a `train` goal
	/// without an npc is). `train Cooking` is not (RevNightElf: it became a class training at
	/// Dolanaar).
	#[serde(default)]
	pub class: Option<bool>,
	/// The line of the guide step the goal is in (the goals of one step share it).
	#[serde(default)]
	pub step: Option<u32>,
	/// The compiled goal's spawn spots (cluster centres), world points: the judge's walk goals'
	/// own (`forge judge check` reads the same), for what one camp is (search::passby::camp_gathers).
	#[serde(default)]
	pub spots: Vec<GoalW>,
}

#[derive(Clone, Debug, Default, serde::Deserialize, serde::Serialize, PartialEq)]
pub struct GoalW {
	pub c: i64,
	pub wx: f64,
	pub wy: f64,
}

/// walk.js's goal -> event: `level` a checkpoint, accept and turn-in themselves, any other
/// goal naming a quest completes it; goals naming no quest are left out.
pub fn goal_event(g: &Goal) -> Option<Event> {
	if g.t == "level" {
		return Some(Event { t: Ev::Level, q: None, level: g.level, xp: None, src: g.i as i64, oi: None, npc: None });
	}
	// (`train class` only is a class training stop: a trainer named by id, a riding trainer of one
	// race, Kildar in Orgrimmar, is a line of its race's guide the route may not move to the nearest
	// town: it was placed at another race's hub. A riding trainer's line is a riding step at that
	// trainer, Ev::Ride.)
	if g.t == "train" {
		if let Some(npc) = g.npc {
			return Some(Event { t: Ev::Ride, q: None, level: None, xp: None, src: g.i as i64, oi: None, npc: Some(npc) });
		}
		if g.class == Some(false) {
			return None;
		}
		return Some(Event { t: Ev::Train, q: None, level: None, xp: None, src: g.i as i64, oi: None, npc: None });
	}
	let q = g.q?;
	let t = match g.t.as_str() {
		"accept" => Ev::Accept,
		"turnin" => Ev::Turnin,
		_ => Ev::Complete,
	};
	Some(Event { t, q: Some(q), level: None, xp: None, src: g.i as i64, oi: g.oi, npc: None })
}

/// Goals from a JSON document's `goals` array (the JS reference driver's output, or a seed).
pub fn goals_from(doc: &Value) -> Vec<Goal> {
	doc.get("goals").and_then(|g| serde_json::from_value(g.clone()).ok()).unwrap_or_default()
}

/// Events from a document: `events` (a route's) or `goals` (a chain's).
pub fn events_from(doc: &Value) -> Vec<Event> {
	if let Some(ev) = doc.get("events").and_then(Value::as_array) {
		return ev
			.iter()
			.enumerate()
			.filter_map(|(k, e)| {
				let t = match e.get("t")?.as_str()? {
					"accept" => Ev::Accept,
					"turnin" => Ev::Turnin,
					"level" => Ev::Level,
					_ => Ev::Complete,
				};
				Some(Event {
					t,
					q: e.get("q").and_then(Value::as_u64).map(|q| q as u32),
					level: e.get("level").and_then(Value::as_f64),
					xp: e.get("xp").and_then(Value::as_f64),
					src: e.get("a").and_then(Value::as_i64).unwrap_or(k as i64),
					oi: None,
					npc: None,
				})
			})
			.collect();
	}
	goals_from(doc).iter().filter_map(goal_event).collect()
}

/// After each event of a replay: level (with fraction) and seconds.
#[derive(Clone, Debug, Default)]
pub struct Replay {
	pub per: Vec<(f64, f64)>,
	pub steps: Vec<Tagged>,
	/// Whether each step did something.
	pub did: Vec<bool>,
	pub unknown: Vec<u32>,
	pub end_time: f64,
	pub end_level: f64,
	pub seconds60: f64,
	pub to30: f64,
}

/// Replay events as walk.js does: each event's steps in turn (grind checkpoints honoured),
/// then grind out to 60.
pub fn replay_events(ev: &mut Evaluator, run: &Run, events: &[Event]) -> Replay {
	let (steps, unknown) = compile_events(run, events, false);
	ev.reset();
	let mut per = Vec::with_capacity(events.len());
	let mut did = Vec::with_capacity(steps.len());
	let mut si = 0;
	for k in 0..events.len() as u32 {
		while si < steps.len() && steps[si].ev == k {
			did.push(ev.step(steps[si].step));
			si += 1;
		}
		per.push((ev.level_now(), ev.s.time));
	}
	let end_time = ev.s.time;
	let end_level = ev.level_now();
	ev.finish();
	Replay { per, steps, did, unknown, end_time, end_level, seconds60: ev.seconds(), to30: ev.level_times[30] }
}

/// Play plain steps from a reset and grind out to 60: seconds to 60.
pub fn play(ev: &mut Evaluator, steps: &[Step]) -> f64 {
	ev.reset();
	for i in 0..steps.len() {
		if ev.s.finished {
			break;
		}
		ev.step_in(steps, i);
	}
	ev.finish();
	ev.seconds()
}

/// A replay against a JS reference (the golden rust/tests/golden/sim: `per` after each goal or event,
/// `hours60`, `levelTimes`, `atEnd.steps`).
#[derive(Clone, Debug)]
pub struct Compared {
	pub hours60: f64,
	pub js_hours60: f64,
	pub to30: f64,
	pub js_to30: f64,
	pub max_dlevel: f64,
	pub max_dt: f64,
	/// First event whose level or time differs (level by > 1e-5, time by > 1 ms).
	pub first: Option<usize>,
	pub compared: usize,
}

pub fn compare_reference(doc: &Value, events: &[Event], rep: &Replay) -> Compared {
	let jper: Vec<(f64, f64)> = doc["per"].as_array().map(|a| a.iter().map(|x| (x[0].as_f64().unwrap_or(f64::NAN), x[1].as_f64().unwrap_or(f64::NAN))).collect()).unwrap_or_default();
	// The reference records after each of its own entries: events (a route's) or goals (a chain's).
	let by_event = doc.get("events").is_some();
	let mut c = Compared {
		hours60: rep.seconds60 / 3600.0,
		js_hours60: doc["hours60"].as_f64().unwrap_or(f64::NAN),
		to30: rep.to30 / 3600.0,
		js_to30: doc["levelTimes"][30].as_f64().unwrap_or(f64::NAN) / 3600.0,
		max_dlevel: 0.0,
		max_dt: 0.0,
		first: None,
		compared: 0,
	};
	for (k, a) in rep.per.iter().enumerate() {
		let j = if by_event { k } else { events[k].src as usize };
		let Some(b) = jper.get(j) else { continue };
		let el = (a.0 - b.0).abs();
		let et = (a.1 - b.1).abs();
		if (el > 1e-5 || et > 1e-3 || el.is_nan() || et.is_nan()) && c.first.is_none() {
			c.first = Some(k);
		}
		c.max_dlevel = c.max_dlevel.max(el);
		c.max_dt = c.max_dt.max(et);
		c.compared += 1;
	}
	c
}

#[cfg(test)]
mod train_tests {
	use super::*;

	#[test]
	fn only_train_class_is_a_class_training_stop() {
		// c4 Troll and an Orc free search moved v1's `train 4752 optional -- Kildar` (the Orc riding
		// trainer, horde/40-50/02-feralas:90) to the Undercity and Bloodhoof trainer hubs.
		let g = |npc: Option<u32>| Goal { i: 3, guide: String::new(), file: String::new(), line: None, t: "train".into(), q: None, oi: None, level: None, w: None, npc, class: None, step: None, spots: Vec::new() };
		assert!(goal_event(&g(Some(4752))).is_some_and(|e| e.t == Ev::Ride && e.npc == Some(4752)), "a named trainer is the guide's own line (a riding step when it is a riding trainer)");
		assert!(goal_event(&g(None)).is_some_and(|e| e.t == Ev::Train), "train class");
		let cooking = Goal { class: Some(false), ..g(None) };
		assert!(goal_event(&cooking).is_none(), "a profession's training is not a class training");
		assert!(goal_event(&Goal { class: Some(true), ..g(None) }).is_some_and(|e| e.t == Ev::Train));
	}
}
