//! Levels and time along a walk from forge-sim's evaluator: walk.js's replay (each goal as a sim
//! event, `ev.step`/grind checkpoints, walks off) without a JS run.
//!
//! Two models: [`SimLevels::new`], the gate's (v1's evaluator as walk.js ran it: the JS-parity tests),
//! and [`SimLevels::route`], the routes stage's own (the average route profile on the walk store): the
//! accept rule that lets a quest with no kill work be taken early (G6), items from the bags (dropped by
//! more than BAG_SOURCES kinds of mob), training stops, and every placed line with no quest (a `goto`,
//! `getfp`, `sethome`, vendor) travelled to, so a written detour costs what the model would pay for it.

use std::sync::Arc;

use forge_sim::chain::{goal_event, Goal};
use forge_sim::run::K_VISIT;
use forge_sim::{compile_events, compile_run, Model, NoWalks, Params, Step, WalkTable, Walks};
use forge_world::{Rules, World};

use crate::walk::{LevelModel, WalkGoal};

/// A placed line with no quest travels to the run point nearest it within this many yards (the run's
/// points are the quests' givers, enders and camps, the towns, inns and flight masters); farther, it is
/// not priced.
pub const VISIT_SNAP_YD: f64 = 400.0;

/// The judge's character model: walk.js's `makeRun(world, { race, cls: null, params: mean, family: 'solo' })`,
/// or the routes stage's ([`SimLevels::route`]).
pub struct SimLevels {
	model: Model,
	walks: Option<Arc<WalkTable>>,
	/// Placed lines with no quest are travel events (the route model).
	visits: bool,
}

impl SimLevels {
	/// The gate's model. `world`: the sim world (a sim dir's `world-<faction>.json`, or one built from
	/// data); `params`: the sim dir's `params.json` document (None: the defaults).
	pub fn new(world: &World, race: &str, params: Option<&serde_json::Value>) -> Result<SimLevels, String> {
		let rules = Rules::new(world, race, None, false);
		let run = compile_run(world, &rules, race, None, &[])?;
		let p = Params::effective(params, None, &[]);
		Ok(SimLevels { model: Model::new(run, &p, &NoWalks), walks: None, visits: false })
	}

	/// The routes stage's model of a start (the average route profile of the world's faction), on the
	/// walk store `walks` (None: straight lines × detour): written hours priced as the model prices an
	/// order, the guide's own travel lines included.
	pub fn route(world: &World, race: &str, params: Option<&serde_json::Value>, walks: Option<Arc<WalkTable>>) -> Result<SimLevels, String> {
		let profile = forge_sim::profile::Profile::average(world.faction);
		let base = Params::effective(params, None, &[]);
		let w: &dyn Walks = match &walks {
			Some(w) => &**w,
			None => &NoWalks,
		};
		let (model, _) = forge_sim::route::model_for(world, race, &profile, &base, w)?;
		Ok(SimLevels { model, walks, visits: true })
	}

	fn walks(&self) -> &dyn Walks {
		match &self.walks {
			Some(w) => &**w,
			None => &NoWalks,
		}
	}

	/// The run point a placed line with no quest travels to (None: not a travel event, or no run point
	/// within [`VISIT_SNAP_YD`]).
	fn visit_pt(&self, g: &WalkGoal) -> Option<u32> {
		// (`train class` is a training stop event; a trainer named by id is the guide's own line, a visit.)
		if !self.visits || g.q.is_some() || g.along.is_some() || matches!(g.t.as_str(), "level" | "note" | "die") || (g.t == "train" && g.npc.is_none()) {
			return None;
		}
		let w = g.w?;
		let r = &self.model.run;
		let mut best = (VISIT_SNAP_YD, None);
		for i in 0..r.p_x.len() {
			if r.p_c[i] != w.c {
				continue;
			}
			let d = (r.p_x[i] - w.wx).hypot(r.p_y[i] - w.wy);
			if d <= best.0 {
				best = (d, Some(i as u32));
			}
		}
		best.1
	}

	/// The steps of a goal list with the goal index each comes from: each quest goal's (compile_events),
	/// each placed line's visit, in goal order; and per goal whether it is an event (has a sim event or
	/// a visit, played even when it compiles to no step).
	fn steps(&self, goals: &[WalkGoal], quest_only: bool) -> (Vec<(usize, Step)>, Vec<bool>) {
		let mut events = Vec::new();
		let mut evented = vec![false; goals.len()];
		for (k, g) in goals.iter().enumerate() {
			if quest_only && g.t != "level" && g.q.is_none() {
				continue;
			}
			let t = if quest_only && g.t != "level" && g.t != "accept" && g.t != "turnin" { "complete".to_string() } else { g.t.clone() };
			let sg = Goal { i: k, guide: String::new(), file: String::new(), line: None, t, q: g.q.and_then(|q| u32::try_from(q).ok()), oi: g.oi, level: g.level, w: None, npc: g.npc, class: Some(g.class), step: g.step, spots: Vec::new() };
			if let Some(e) = goal_event(&sg) {
				events.push(e);
				evented[k] = true;
			}
		}
		let (compiled, _) = compile_events(&self.model.run, &events, false);
		let mut out: Vec<(usize, Step)> = compiled.into_iter().map(|t| (events[t.ev as usize].src as usize, t.step)).collect();
		for (k, g) in goals.iter().enumerate() {
			if let Some(pt) = self.visit_pt(g) {
				out.push((k, Step { kind: K_VISIT, q: 0, task: -1, pt }));
				evented[k] = true;
			}
		}
		// Stable: a goal's own steps keep their order.
		out.sort_by_key(|x| x.0);
		(out, evented)
	}
}

impl LevelModel for SimLevels {
	fn replay(&self, goals: &mut [WalkGoal], to: f64) -> usize {
		let (steps, _) = self.steps(goals, false);
		let mut ev = self.model.evaluator(self.walks());
		ev.journaling = false;
		ev.reset();
		let mut si = 0;
		for k in 0..goals.len() {
			goals[k].lvl = ev.level_now();
			goals[k].time = ev.s.time;
			if goals[k].lvl >= to {
				return k;
			}
			while si < steps.len() && steps[si].0 < k {
				si += 1;
			}
			let g0 = ev.s.grind_sec;
			while si < steps.len() && steps[si].0 == k {
				ev.step(steps[si].1);
				si += 1;
			}
			goals[k].lvl_after = ev.level_now();
			goals[k].time_after = ev.s.time;
			goals[k].grind = ev.s.grind_sec - g0;
		}
		goals.len()
	}
}

impl SimLevels {
	/// sdiff.js's play: each goal with a quest (or a `level` grind) as one event, in order (with the
	/// route model, placed lines with no quest travelled to as well), until level 60; the level (with
	/// its fraction) and time after each goal (None: not played).
	pub fn play(&self, goals: &[WalkGoal]) -> Vec<Option<(f64, f64)>> {
		let (steps, evented) = self.steps(goals, true);
		let mut ev = self.model.evaluator(self.walks());
		ev.journaling = false;
		ev.reset();
		let mut out = vec![None; goals.len()];
		let mut si = 0;
		for k in (0..goals.len()).filter(|&k| evented[k]) {
			while si < steps.len() && steps[si].0 == k {
				ev.step(steps[si].1);
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

/// The walk store of a sim dir's faction (`walks-<faction>.bin` on `world`'s points), once per
/// faction for every start of a run: None when the file is missing or unreadable.
#[cfg(feature = "native")]
pub fn walks_for(cache: &std::sync::Mutex<rustc_hash::FxHashMap<String, Option<Arc<WalkTable>>>>, sim_dir: &std::path::Path, world: &World) -> Option<Arc<WalkTable>> {
	let f = world.faction.lower().to_string();
	let mut c = cache.lock().unwrap_or_else(|e| e.into_inner());
	c.entry(f.clone()).or_insert_with(|| WalkTable::load(&sim_dir.join(format!("walks-{f}.bin")), world.points.len()).ok().map(Arc::new)).clone()
}
