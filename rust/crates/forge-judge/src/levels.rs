//! Levels and time along a walk from forge-sim's evaluator: walk.js's replay (each goal as a sim
//! event, `ev.step`/grind checkpoints, walks off) without a JS run.

use forge_sim::chain::{goal_event, Goal};
use forge_sim::{compile_events, compile_run, Model, NoWalks, Params};
use forge_world::{Rules, World};

use crate::walk::{LevelModel, WalkGoal};

/// The judge's character model: walk.js's `makeRun(world, { race, cls: null, params: mean, family: 'solo' })`.
pub struct SimLevels {
	model: Model,
}

impl SimLevels {
	/// `world`: the sim world (a sim dir's `world-<faction>.json`, or one built from data); `params`: the
	/// sim dir's `params.json` document (None: the defaults).
	pub fn new(world: &World, race: &str, params: Option<&serde_json::Value>) -> Result<SimLevels, String> {
		let rules = Rules::new(world, race, None, false);
		let run = compile_run(world, &rules, race, None, &[])?;
		let p = Params::effective(params, None, &[]);
		Ok(SimLevels { model: Model::new(run, &p, &NoWalks) })
	}
}

impl LevelModel for SimLevels {
	fn replay(&self, goals: &mut [WalkGoal], to: f64) -> usize {
		let mut events = Vec::new();
		for g in goals.iter() {
			let sg = Goal { i: g.i, guide: String::new(), file: String::new(), line: None, t: g.t.clone(), q: g.q.and_then(|q| u32::try_from(q).ok()), oi: g.oi, level: g.level, w: None };
			if let Some(e) = goal_event(&sg) {
				events.push(e);
			}
		}
		let (steps, _) = compile_events(&self.model.run, &events, false);
		let mut ev = self.model.evaluator(&NoWalks);
		ev.journaling = false;
		ev.reset();
		// Steps per goal index (events keep their goal in `src`).
		let mut si = 0;
		for (k, g) in goals.iter_mut().enumerate() {
			g.lvl = ev.level_now();
			g.time = ev.s.time;
			if g.lvl >= to {
				return k;
			}
			while si < steps.len() && events[steps[si].ev as usize].src < g.i as i64 {
				si += 1;
			}
			while si < steps.len() && events[steps[si].ev as usize].src == g.i as i64 {
				ev.step(steps[si].step);
				si += 1;
			}
			g.lvl_after = ev.level_now();
			g.time_after = ev.s.time;
		}
		goals.len()
	}
}

impl SimLevels {
	/// sdiff.js's play: each goal with a quest (or a `level` grind) as one event, in order, until level
	/// 60; the level (with its fraction) and time after each goal (None: not played).
	pub fn play(&self, goals: &[WalkGoal]) -> Vec<Option<(f64, f64)>> {
		let mut events = Vec::new();
		for (k, g) in goals.iter().enumerate() {
			if g.t != "level" && g.q.is_none() {
				continue;
			}
			let t = if g.t == "level" || g.t == "accept" || g.t == "turnin" { g.t.clone() } else { "complete".to_string() };
			let sg = Goal { i: k, guide: String::new(), file: String::new(), line: None, t, q: g.q.and_then(|q| u32::try_from(q).ok()), oi: g.oi, level: g.level, w: None };
			if let Some(e) = goal_event(&sg) {
				events.push(e);
			}
		}
		let (steps, _) = compile_events(&self.model.run, &events, false);
		let mut ev = self.model.evaluator(&NoWalks);
		ev.journaling = false;
		ev.reset();
		let mut out = vec![None; goals.len()];
		let mut si = 0;
		for e in &events {
			let k = e.src as usize;
			while si < steps.len() && events[steps[si].ev as usize].src == e.src {
				ev.step(steps[si].step);
				si += 1;
			}
			out[k] = Some((ev.level_now(), ev.s.time));
			if ev.level_now() >= 60.0 {
				break;
			}
		}
		out
	}
}
