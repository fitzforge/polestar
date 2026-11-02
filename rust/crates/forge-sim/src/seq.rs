//! Orders as events and their steps (port of tools/lib/sim/sequence.js `compileSequence`).
//!
//! An event is what a guide goal or a route action asks: accept a quest, complete it (every
//! objective site), turn it in (any site not yet done, then the ender) or reach a level (a
//! checkpoint the character grinds to). Each compiles to steps the evaluator plays.

use crate::eval::Step;
use crate::run::{Run, K_ACCEPT, K_GRIND, K_RIDE, K_TASK, K_TRAIN, K_TURNIN};
use serde::{Deserialize, Serialize};

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum Ev {
	Accept,
	Complete,
	Turnin,
	Level,
	/// `train class`: the nearest town's trainers from where the order is (profile towns only).
	Train,
	/// `train <npc>`: a named trainer (`npc`); a riding trainer of the run's (Run::riding) is a
	/// K_RIDE step, any other is left out (the guide's own line).
	Ride,
}

/// One event; `src` is where it came from (a goal index in the seed, or an action index).
#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]
pub struct Event {
	pub t: Ev,
	#[serde(default, skip_serializing_if = "Option::is_none")]
	pub q: Option<u32>,
	#[serde(default, skip_serializing_if = "Option::is_none")]
	pub level: Option<f64>,
	#[serde(default, skip_serializing_if = "Option::is_none")]
	pub xp: Option<f64>,
	#[serde(default)]
	pub src: i64,
	/// The objective a `complete` goal names (1-based, as the guide's goals), if any.
	#[serde(default, skip_serializing_if = "Option::is_none")]
	pub oi: Option<i64>,
	/// A named trainer's npc id (Ev::Ride).
	#[serde(default, skip_serializing_if = "Option::is_none")]
	pub npc: Option<u32>,
}

/// A step with the event it came from.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct Tagged {
	pub step: Step,
	pub ev: u32,
}

/// The steps of the events (in order), each tagged with its event index. Events naming a
/// quest the character cannot take are left out (listed in `unknown`). With `by_objective`, a
/// `complete` naming one objective works only the tasks of that objective (v1's own step for
/// it; sequence.js works every task at the quest's first goal, which splits a visit when the
/// order moves).
pub fn compile_events(run: &Run, events: &[Event], by_objective: bool) -> (Vec<Tagged>, Vec<u32>) {
	let mut out: Vec<Tagged> = Vec::with_capacity(events.len() * 2);
	let mut unknown = Vec::new();
	for (k, e) in events.iter().enumerate() {
		let ev = k as u32;
		if e.t == Ev::Level {
			let l = e.level.unwrap_or(0.0);
			if (1.0..=60.0).contains(&l) {
				let xp = forge_core::js_round(e.xp.unwrap_or(0.0)).max(0.0);
				out.push(Tagged { step: Step::grind(l as u32, xp as i32), ev });
			}
			continue;
		}
		if e.t == Ev::Ride {
			if let Some(&(npc, pt)) = e.npc.and_then(|n| run.riding.iter().find(|r| r.0 == n)) {
				out.push(Tagged { step: Step { kind: K_RIDE, q: 0, task: npc as i32, pt }, ev });
			}
			continue;
		}
		if e.t == Ev::Train {
			let from = out.iter().rev().find(|t| t.step.kind != K_GRIND).map_or(run.start_pt, |t| t.step.pt);
			if let Some(town) = nearest_town(run, from) {
				// (`task`: the level the training is held at or above: its step's class quests', route::train_floors.)
				let floor = e.level.map_or(-1, |l| l as i32);
				out.push(Tagged { step: Step { kind: K_TRAIN, q: 0, task: floor, pt: town }, ev });
			}
			continue;
		}
		let Some(id) = e.q else { continue };
		let Some(qi) = run.q(id) else {
			if !unknown.contains(&id) {
				unknown.push(id);
			}
			continue;
		};
		let q = qi as usize;
		match e.t {
			Ev::Accept => out.push(Tagged { step: Step { kind: K_ACCEPT, q: qi, task: run.q_accept[q], pt: run.q_giver[q] }, ev }),
			Ev::Complete | Ev::Turnin => {
				let only = match (by_objective, e.t, e.oi) {
					(true, Ev::Complete, Some(oi)) if (1..=63).contains(&oi) => {
						let bit = 1u64 << (oi - 1);
						let m: Vec<u32> = (run.q_task0[q]..run.q_task1[q]).filter(|&t| run.task_objs.get(t as usize).is_some_and(|b| b & bit != 0)).collect();
						(!m.is_empty()).then_some(m)
					}
					_ => None,
				};
				for t in run.q_task0[q]..run.q_task1[q] {
					if only.as_ref().is_some_and(|m| !m.contains(&t)) {
						continue;
					}
					out.push(Tagged { step: Step { kind: K_TASK, q: qi, task: t as i32, pt: run.task_pt[t as usize] }, ev });
				}
				if e.t == Ev::Turnin {
					out.push(Tagged { step: Step { kind: K_TURNIN, q: qi, task: -1, pt: run.q_ender[q] }, ev });
				}
			}
			Ev::Level | Ev::Train | Ev::Ride => unreachable!(),
		}
	}
	unknown.sort_unstable();
	(out, unknown)
}

/// The town (run point with the class trainers) nearest `from` in its region, if any; the
/// starting valley only from inside it.
pub fn nearest_town(run: &Run, from: u32) -> Option<u32> {
	let out = run.straight(run.start_pt, from) > crate::profile::LEFT_VALLEY_YD;
	run.towns
		.iter()
		.copied()
		.filter(|&t| run.straight(from, t).is_finite() && !(out && run.valley_towns.contains(&t)))
		.min_by(|&a, &b| run.straight(from, a).total_cmp(&run.straight(from, b)).then(a.cmp(&b)))
}

/// A quest's steps in order (accept, every task, turn-in): what an insert adds.
pub fn quest_steps(run: &Run, qi: u32) -> Vec<Step> {
	let q = qi as usize;
	let mut v = vec![Step { kind: K_ACCEPT, q: qi, task: run.q_accept[q], pt: run.q_giver[q] }];
	for t in run.q_task0[q]..run.q_task1[q] {
		v.push(Step { kind: K_TASK, q: qi, task: t as i32, pt: run.task_pt[t as usize] });
	}
	v.push(Step { kind: K_TURNIN, q: qi, task: -1, pt: run.q_ender[q] });
	v
}

/// Whether a step is a grind checkpoint.
pub fn is_grind(s: &Step) -> bool {
	s.kind == K_GRIND
}
