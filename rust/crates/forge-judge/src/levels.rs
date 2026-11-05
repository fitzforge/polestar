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
		self.run_pt(g.w?)
	}

	/// The run point nearest `w` within [`VISIT_SNAP_YD`].
	fn run_pt(&self, w: crate::walk::WPt) -> Option<u32> {
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
			let sg = Goal {
				i: k,
				guide: String::new(),
				file: String::new(),
				line: None,
				t,
				q: g.q.and_then(|q| u32::try_from(q).ok()),
				oi: g.oi,
				level: g.level,
				w: None,
				npc: g.npc,
				class: Some(g.class),
				step: g.step,
				spots: Vec::new(),
			};
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
		let skip = self.optional_skips(goals, &out);
		if !skip.is_empty() {
			out.retain(|s| !skip.contains(&s.0));
			for &k in &skip {
				evented[k] = false;
			}
		}
		(out, evented)
	}

	/// The optional goals a player skips: one whose event would make the model grind (an optional
	/// accept the model would only take at a higher level: Vehena's cloth donations, quest level 60,
	/// written in Orgrimmar at 52.9 in c17, where the walk ground 12 hours to take one), with the
	/// rest of its quest after a skipped accept. The player takes such a line when they can and walks
	/// on when they cannot; the routes stage never grinds for one either.
	fn optional_skips(&self, goals: &[WalkGoal], steps: &[(usize, Step)]) -> rustc_hash::FxHashSet<usize> {
		let mut skip = rustc_hash::FxHashSet::default();
		if !goals.iter().any(|g| g.optional) {
			return skip;
		}
		let mut ev = self.model.evaluator(self.walks());
		ev.journaling = false;
		ev.reset();
		let mut dropped: rustc_hash::FxHashSet<i64> = rustc_hash::FxHashSet::default();
		let mut si = 0;
		while si < steps.len() {
			let k = steps[si].0;
			let n = steps[si..].iter().take_while(|s| s.0 == k).count();
			let g = &goals[k];
			if g.q.is_some_and(|q| dropped.contains(&q)) {
				skip.insert(k);
			} else if g.optional {
				let (snap, grind0) = (ev.snapshot(), ev.s.grind_sec);
				for s in &steps[si..si + n] {
					ev.step(s.1);
				}
				if ev.s.grind_sec > grind0 {
					ev.load(&snap);
					skip.insert(k);
					if let Some(q) = g.q.filter(|_| g.t == "accept") {
						dropped.insert(q);
					}
				}
			} else {
				for s in &steps[si..si + n] {
					ev.step(s.1);
				}
			}
			si += n;
		}
		skip
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

/// A travel stretch of a walk: the moves (`is_move` goals) between goal `from`, which does something,
/// and goal `to`, the next that does (its first place). `written`: the model's seconds from where
/// `from` leaves the player to `to`'s place along the moves (grinding left out); `best`: the model's
/// best way between the same two points then (walk, the flights, boats and trams the character knows).
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Stretch {
	pub from: usize,
	pub to: usize,
	pub written: f64,
	pub best: f64,
}

impl SimLevels {
	/// The walk's travel stretches with their written and best seconds (a replay of the walk as
	/// [`LevelModel::replay`] plays it).
	pub fn stretches(&self, goals: &[WalkGoal], is_move: &dyn Fn(&WalkGoal) -> bool) -> Vec<Stretch> {
		let (steps, _) = self.steps(goals, false);
		let mut ev = self.model.evaluator(self.walks());
		ev.journaling = false;
		ev.reset();
		let mut out = Vec::new();
		// (The goal that did something last: where it left the player (its written place, else the
		// model's), the time and the grind then; and whether a move has been played since, with the
		// seconds the first move's leg takes from the written place over the model's. Work the model
		// has no step for (a class quest of no profile) is work at its written place too; with no place
		// either (`vendor nearest`), it is done where the player stands and is passed. A `level` goal
		// that grinds is work where the player stands, the camp the moves went to; one that grinds
		// nothing is passed. The best way is the one known where the stretch starts: a flight path the
		// model learns by passing its master on the way, Freewind Post's on the walk to it, is not.)
		let mut anchor: Option<(usize, u32, f64, f64)> = None;
		let mut known = ev.s.d.clone();
		let mut moved: Option<f64> = None;
		let mut si = 0;
		for (k, g) in goals.iter().enumerate() {
			while si < steps.len() && steps[si].0 < k {
				si += 1;
			}
			let n = steps[si..].iter().take_while(|s| s.0 == k).count();
			let mv = is_move(g);
			let work = !mv && g.t != "note" && g.t != "level";
			let (time0, pos0, grind0) = (ev.s.time, ev.s.pos, ev.s.grind_sec);
			// (Where the goal is done: its written place, else, for quest work, its first step's; a line
			// with no quest and no place (`train class`) is done where the moves left the player, not at
			// the model's own trainer.)
			let place = g.w.and_then(|w| self.run_pt(w)).or_else(|| (n > 0).then(|| if g.q.is_some() { steps[si].1.pt } else { pos0 }));
			// (The stretch ending at the place `pt`, `there` seconds on from where the moves left the
			// player.)
			let (an, mo, kn) = (anchor, moved, &known);
			let mut end = |ev: &mut forge_sim::Evaluator, pt: u32, there: f64| {
				if let (Some((a, pos, time, grind)), Some(off)) = (an, mo) {
					let best = ev.leg_known(pos, pt, kn);
					out.push(Stretch { from: a, to: k, written: time0 - time - (grind0 - grind) + there + off, best });
				}
			};
			if work {
				if let Some(pt) = place {
					let there = ev.leg_now(pos0, pt);
					end(&mut ev, pt, there);
				}
			}
			if n > 0 && mv && moved.is_none() {
				let pt = steps[si].1.pt;
				moved = Some(anchor.map_or(0.0, |a| ev.leg_now(a.1, pt) - ev.leg_now(pos0, pt)));
			}
			for _ in 0..n {
				ev.step(steps[si].1);
				si += 1;
			}
			let grinds = g.t == "level" && ev.s.grind_sec > grind0;
			if grinds {
				end(&mut ev, pos0, 0.0);
			}
			if (work && place.is_some()) || grinds {
				anchor = if grinds { Some(pos0) } else { place }.map(|here| (k, here, ev.s.time, ev.s.grind_sec));
				known = ev.s.d.clone();
				moved = None;
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
	c.entry(f.clone()).or_insert_with(|| WalkTable::load(&sim_dir.join(format!("walks-{f}.bin")), world.points.len()).ok().map(|t| Arc::new(t.with_crossings(world)))).clone()
}
