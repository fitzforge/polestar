//! A leveling guide's zone blocks (#1249, "do this zone, then come back"; docs/PACK_FORMAT.md, "Zone blocks").
//!
//! A block is a maximal run of steps whose goals sit on one zone map. Travel-only steps (a flight, a hearth, a
//! note) and steps for some classes or races only (`only`) or of background goals (`along`) carry no zone of
//! their own: they belong to the block they lead into. The guide window offers a block that comes later in the
//! guide while the player is in its zone (Core/Engine.lua, "Zone detours"): its steps first, then back to the
//! steps it passed over, which are neither done nor skipped.
//!
//! Each block also lists what it waits for from the steps before it (`waits`): a step of the block that hands
//! in or works on a quest accepted before the block (`at` is that accept's step), or accepts a quest whose
//! prerequisite is handed in before the block (`done`: the prerequisite must be turned in, not only taken).
//! The Engine passes such a step over while its quest is missing and the step named by `at` is still open,
//! and says so in the offer's preview. A block whose every quest step waits is not written: nothing in it can
//! be done ahead.
//!
//! Step numbers are the guide's own (1-based, as the addon numbers them); the Engine moves them onto its plan
//! of the steps (feeders put in, steps dropped: Own.withFeeders' `fromBase`).

use crate::js::{Obj, V};
use rustc_hash::FxHashMap;

/// A block needs this many steps with a zone of their own to be offered: a two-step city stop between two
/// visits of a zone (a trainer, a flight) is no zone to do ahead.
pub const MIN_BLOCK_STEPS: usize = 3;

/// The keys of a `zones` entry, in this order.
pub const ZONE_KEYS: [&str; 5] = ["start", "stop", "map", "steps", "waits"];
/// The keys of a block's `waits` entry, in this order.
pub const WAIT_KEYS: [&str; 4] = ["s", "q", "at", "done"];

/// Goals that move the player on rather than do something where they are.
const TRAVEL: [&str; 3] = ["fly", "hearth", "note"];

/// A step's own zone: the map of its first goal that is not travel, or None (travel, `only`, `along`, no map).
fn step_map(step: &V) -> Option<f64> {
	if step.get("only").truthy() || step.get("along").truthy() {
		return None;
	}
	step.get("goals").items().iter().find(|g| !g.get("t").as_str().is_some_and(|t| TRAVEL.contains(&t)) && g.get("map").is_num()).map(|g| g.get("map").num())
}

fn quest_of(goal: &V) -> Option<i64> {
	goal.get("quest").as_num().map(|q| q as i64)
}

/// The first step (1-based) of each quest's accept and turn-in.
fn first_steps(steps: &[V]) -> (FxHashMap<i64, usize>, FxHashMap<i64, usize>) {
	let (mut accepts, mut turnins) = (FxHashMap::default(), FxHashMap::default());
	for (i, step) in steps.iter().enumerate() {
		for goal in step.get("goals").items() {
			let Some(q) = quest_of(&goal) else { continue };
			match goal.get("t").as_str() {
				Some("accept") => {
					accepts.entry(q).or_insert(i + 1);
				}
				Some("turnin") => {
					turnins.entry(q).or_insert(i + 1);
				}
				_ => {}
			}
		}
	}
	(accepts, turnins)
}

fn ids(v: &V) -> Vec<i64> {
	v.items().iter().filter_map(|x| x.as_num()).map(|x| x as i64).collect()
}

/// What steps start..=stop (1-based) wait for from the steps before `start`: { s, q, at, done? } in step order.
fn waits_of(steps: &[V], start: usize, stop: usize, accepts: &FxHashMap<i64, usize>, turnins: &FxHashMap<i64, usize>) -> Vec<V> {
	let mut out: Vec<V> = Vec::new();
	let mut seen: Vec<(usize, i64)> = Vec::new();
	let mut push = |s: usize, q: i64, at: usize, done: bool, out: &mut Vec<V>| {
		if seen.contains(&(s, q)) {
			return;
		}
		seen.push((s, q));
		let w = Obj::new();
		w.set("s", s as f64);
		w.set("q", q as f64);
		w.set("at", at as f64);
		if done {
			w.set("done", true);
		}
		out.push(V::Obj(w));
	};
	// Parked: the first accept or turn-in of the quest is before the block, and none comes inside it up to s.
	let parked = |first: Option<&usize>| first.copied().filter(|&at| at < start);
	for s in start..=stop {
		for goal in steps[s - 1].get("goals").items() {
			let t = goal.get("t").as_str().unwrap_or("").to_string();
			if t == "accept" {
				for p in ids(&goal.get("preAll")) {
					if let Some(at) = parked(turnins.get(&p)) {
						push(s, p, at, true, &mut out);
					}
				}
				let pre = ids(&goal.get("pre"));
				// One of `pre` is enough: the step waits only when every one the guide hands in is before the block.
				let handed: Vec<(i64, Option<usize>)> = pre.iter().filter_map(|p| turnins.get(p).map(|&at| (*p, Some(at)))).collect();
				if !handed.is_empty() && handed.len() == pre.len() && handed.iter().all(|(_, at)| parked(at.as_ref()).is_some()) {
					let (p, at) = handed[0];
					push(s, p, at.unwrap_or(0), true, &mut out);
				}
			} else if t != "abandon" {
				if let Some(q) = quest_of(&goal) {
					if let Some(at) = parked(accepts.get(&q)) {
						push(s, q, at, false, &mut out);
					}
				}
			}
		}
	}
	out
}

/// The zone blocks of a guide's resolved steps, as the compiler writes them (`zones`), or None for a guide of
/// one zone (nothing to do ahead).
pub fn blocks(steps: &[V]) -> Option<V> {
	let own: Vec<Option<f64>> = steps.iter().map(step_map).collect();
	// Each step's zone: its own, else the next step's with one (it leads there), else the last one's.
	let mut maps: Vec<Option<f64>> = own.clone();
	let mut next: Option<f64> = None;
	for m in maps.iter_mut().rev() {
		match m {
			Some(v) => next = Some(*v),
			None => *m = next,
		}
	}
	let mut last: Option<f64> = None;
	for m in maps.iter_mut() {
		match m {
			Some(v) => last = Some(*v),
			None => *m = last,
		}
	}
	// Runs of one zone: (start, stop, map), 1-based.
	let mut runs: Vec<(usize, usize, f64)> = Vec::new();
	for (i, m) in maps.iter().enumerate() {
		let Some(m) = *m else { continue };
		match runs.last_mut() {
			Some(r) if r.2 == m => r.1 = i + 1,
			_ => runs.push((i + 1, i + 1, m)),
		}
	}
	if runs.len() < 2 {
		return None;
	}
	let (accepts, turnins) = first_steps(steps);
	let mut out: Vec<V> = Vec::new();
	for (start, stop, map) in runs {
		let n = (start..=stop).filter(|s| own[s - 1].is_some()).count();
		if n < MIN_BLOCK_STEPS {
			continue;
		}
		let waits = waits_of(steps, start, stop, &accepts, &turnins);
		// Steps with quest work, and those of them that wait: a block whose every one waits is left out.
		let quest_steps = (start..=stop).filter(|s| steps[s - 1].get("goals").items().iter().any(|g| quest_of(g).is_some())).count();
		let mut waiting: Vec<usize> = waits.iter().map(|w| w.get("s").num() as usize).collect();
		waiting.dedup();
		if quest_steps > 0 && waiting.len() >= quest_steps {
			continue;
		}
		let b = Obj::new();
		b.set("start", start as f64);
		b.set("stop", stop as f64);
		b.set("map", map);
		b.set("steps", n as f64);
		if !waits.is_empty() {
			b.set("waits", V::from(waits));
		}
		out.push(V::Obj(b));
	}
	if out.is_empty() {
		None
	} else {
		Some(V::from(out))
	}
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::js::V;

	fn goal(t: &str, map: f64, quest: Option<f64>) -> V {
		let g = Obj::new();
		g.set("t", t);
		g.set("map", map);
		if let Some(q) = quest {
			g.set("quest", q);
		}
		V::Obj(g)
	}

	fn step(goals: Vec<V>) -> V {
		let s = Obj::new();
		s.set("goals", V::from(goals));
		V::Obj(s)
	}

	fn nums(v: &V, k: &str) -> Vec<f64> {
		v.items().iter().map(|b| b.get(k).num()).collect()
	}

	const ASH: f64 = 1440.0;
	const WET: f64 = 1437.0;
	const IF: f64 = 1455.0;

	#[test]
	fn runs_of_one_zone_are_blocks_and_travel_leads_into_the_next() {
		let steps = vec![
			step(vec![goal("accept", ASH, Some(1.0))]),
			step(vec![goal("kill", ASH, Some(1.0))]),
			step(vec![goal("turnin", ASH, Some(1.0))]),
			step(vec![goal("fly", ASH, None)]),
			step(vec![goal("accept", WET, Some(2.0))]),
			step(vec![goal("collect", WET, Some(2.0))]),
			step(vec![goal("turnin", WET, Some(2.0))]),
		];
		let z = blocks(&steps).expect("two zones");
		assert_eq!(nums(&z, "start"), vec![1.0, 4.0], "the flight out of Ashenvale belongs to the Wetlands block");
		assert_eq!(nums(&z, "stop"), vec![3.0, 7.0]);
		assert_eq!(nums(&z, "map"), vec![ASH, WET]);
		assert_eq!(nums(&z, "steps"), vec![3.0, 3.0], "travel steps are not counted");
		assert!(z.at(1).get("waits").is_undef(), "nothing in the Wetlands needs Ashenvale");
	}

	#[test]
	fn a_guide_of_one_zone_has_no_blocks() {
		let steps = vec![step(vec![goal("accept", ASH, Some(1.0))]), step(vec![goal("turnin", ASH, Some(1.0))])];
		assert!(blocks(&steps).is_none());
	}

	#[test]
	fn a_short_city_stop_is_no_block_and_class_steps_take_the_zone_around_them() {
		let class = step(vec![goal("train", IF, None)]);
		class.set("only", Obj::new());
		let steps = vec![
			step(vec![goal("accept", ASH, Some(1.0))]),
			step(vec![goal("kill", ASH, Some(1.0))]),
			step(vec![goal("turnin", ASH, Some(1.0))]),
			step(vec![goal("train", IF, None)]),
			step(vec![goal("accept", WET, Some(2.0))]),
			class,
			step(vec![goal("collect", WET, Some(2.0))]),
			step(vec![goal("turnin", WET, Some(2.0))]),
		];
		let z = blocks(&steps).expect("blocks");
		assert_eq!(nums(&z, "start"), vec![1.0, 5.0], "the one-step Ironforge stop is not offered");
		assert_eq!(nums(&z, "stop"), vec![3.0, 8.0], "the class-only step stays inside the Wetlands block");
	}

	#[test]
	fn a_block_lists_the_quests_it_waits_for_from_earlier_steps() {
		let acc = step(vec![goal("accept", WET, Some(5.0))]);
		acc.get("goals").at(0).set("preAll", V::from(vec![V::Num(3.0)]));
		let steps = vec![
			step(vec![goal("accept", ASH, Some(3.0)), goal("accept", ASH, Some(4.0))]),
			step(vec![goal("turnin", ASH, Some(3.0))]),
			step(vec![goal("kill", ASH, Some(9.0))]),
			step(vec![goal("accept", WET, Some(6.0))]),
			step(vec![goal("turnin", WET, Some(4.0))]),
			acc,
			step(vec![goal("turnin", WET, Some(6.0))]),
		];
		let z = blocks(&steps).expect("blocks");
		let w = z.at(1).get("waits");
		assert_eq!(nums(&w, "s"), vec![5.0, 6.0]);
		assert_eq!(nums(&w, "q"), vec![4.0, 3.0]);
		assert_eq!(nums(&w, "at"), vec![1.0, 2.0], "the hand-in of 4 needs the accept at step 1; the accept of 5 needs 3 turned in at step 2");
		assert!(!w.at(0).get("done").truthy());
		assert!(w.at(1).get("done").truthy());
	}

	#[test]
	fn a_block_whose_every_quest_step_waits_is_left_out() {
		let steps = vec![
			step(vec![goal("accept", ASH, Some(1.0))]),
			step(vec![goal("accept", ASH, Some(2.0))]),
			step(vec![goal("kill", ASH, Some(9.0))]),
			step(vec![goal("goto", WET, None)]),
			step(vec![goal("turnin", WET, Some(1.0))]),
			step(vec![goal("turnin", WET, Some(2.0))]),
		];
		let z = blocks(&steps).expect("Ashenvale still listed");
		assert_eq!(nums(&z, "map"), vec![ASH], "the Wetlands block only hands in Ashenvale's quests");
	}
}
