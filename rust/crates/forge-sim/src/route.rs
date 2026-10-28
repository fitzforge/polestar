//! One start's route: compile the character under a profile, build the seed from v1's chain,
//! search, and report hours and the difference from v1.

use crate::chain::Goal;
use crate::guards::{GuardCounts, GuardData};
use crate::insertable::Insertable;
use crate::order::{deliberate_pairs, diff, seed_order, Diff, Order, INSERTED, TRAIN_STOP};
use crate::profile::{town_points, Profile};
use crate::run::{compile_run, K_ACCEPT, K_GRIND, K_RIDE, K_TASK, K_TRAIN, K_TURNIN};
use crate::search::{clean, evaluate, pool, runs, search, CtxSpec, Guard, GuardMode, Mode, Problem, SearchOpts, Stats, MOVES, MOVE_NAMES};
use crate::seq::Event;
use crate::walks::{NoWalks, Walks};
use crate::{Evaluator, Model, Params};
use forge_world::{Rules, World};
use serde_json::{json, Value};

/// A character compiled under a profile (towns indexed for `train class`).
pub fn model_for(world: &World, race: &str, profile: &Profile, base: &Params, walks: &dyn Walks) -> Result<(Model, Rules), String> {
	let rules = Rules::new(world, race, None, false);
	let start = world.starts.iter().find(|(r, _)| r == race).map(|(_, st)| st.pt);
	let (towns, own_valley) = if profile.train_stops { town_points(world, start) } else { (Vec::new(), Vec::new()) };
	let rides: &[(u32, u32)] = profile.rides.as_deref().filter(|_| profile.train_stops).map_or(&[], Vec::as_slice);
	let mut p = profile.params(base);
	// Deathskips (route profiles, `--deathskips`): the Spirit Healers are places of the run.
	let deathskips = p.feasible && p.deathskips;
	let healers = world.graveyards.iter().map(|g| g.pt).filter(|_| deathskips);
	let extra: Vec<u32> = towns.iter().copied().chain(rides.iter().map(|r| r.1)).chain(healers).collect();
	let mut run = compile_run(world, &rules, race, None, &extra)?;
	run.towns = towns.iter().filter_map(|&p| run.run_pt(p)).collect();
	let gaps = crate::profile::town_gaps(world, race, &towns);
	run.town_gap_yd = towns.iter().zip(&gaps).filter(|(p, _)| run.run_pt(**p).is_some()).map(|(_, g)| *g).collect();
	let away = crate::profile::town_away(world, race, &towns);
	run.town_away = towns
		.iter()
		.zip(away)
		.filter(|(p, _)| run.run_pt(**p).is_some())
		.map(|(_, cls)| cls.into_iter().map(|v| v.into_iter().filter_map(|p| run.run_pt(p)).collect::<Vec<u32>>()).filter(|v| !v.is_empty()).collect())
		.collect();
	run.town_away_share = 1.0 / crate::profile::race_classes(world, race).len().max(1) as f64;
	run.riding = rides.iter().filter_map(|&(n, p)| run.run_pt(p).map(|x| (n, x))).collect();
	run.valley_towns = own_valley.iter().filter_map(|&p| run.run_pt(p)).collect();
	if profile.train_stops {
		run.task_bag = bag_tasks(world, &rules, &run);
		together_camps(world, &mut run);
		co_sited_tasks(&mut run);
	}
	run.plan = profile.plan.clone();
	if let Some(r) = profile.rare.as_ref().filter(|_| profile.train_stops) {
		run.set_rare(r);
	}
	if deathskips {
		run.set_deaths(world);
	}
	if let Some(sp) = profile.spots.as_ref() {
		run.set_spots(sp);
	}
	// Tauren's racial Plainsrunning, on the route profiles (the gate keeps v1's model).
	if race == "Tauren" && profile.train_stops {
		p.plainsrunning = true;
	}
	Ok((Model::new(run, &p, walks), rules))
}

/// Deliberate `together` work (route fixes): a task whose kill work lives at several camps is done
/// at its camp nearest its pair's place, so the two are one visit (RevH1 c13, #274: the Raptor Horns
/// with Vrang's hides in the Dry Hills, at the Sunscale Scytheclaws there, not at the Raptor Grounds
/// 2981 yd from the hides). The record's second step moves first; when it has no camps to choose
/// from, the first moves to the second's place. Only nearer: a task already closest stays. The
/// shared kill credit is counted again from the sites as they are then.
fn together_camps(world: &World, run: &mut crate::run::Run) {
	use crate::run::W_KILL;
	let mut moved = false;
	for t in crate::order::deliberate_together(run) {
		let task_of = |run: &crate::run::Run, q: u32, ti: i32| -> Option<usize> {
			let q = q as usize;
			if ti >= 0 {
				Some(ti as usize)
			} else {
				(run.q_task1[q] > run.q_task0[q]).then_some(run.q_task0[q] as usize)
			}
		};
		let place = |run: &crate::run::Run, k: u8, q: u32, ti: i32| -> Option<u32> {
			match k {
				K_ACCEPT => Some(run.q_giver[q as usize]),
				K_TURNIN => Some(run.q_ender[q as usize]),
				_ => task_of(run, q, ti).map(|x| run.task_pt[x]),
			}
		};
		for (km, qm, tm, kt, qt, tt) in [(t.kb, t.qb, t.tb, t.ka, t.qa, t.ta), (t.ka, t.qa, t.ta, t.kb, t.qb, t.tb)] {
			let (Some(task), Some(to)) = (if km == K_TASK { task_of(run, qm, tm) } else { None }, place(run, kt, qt, tt)) else { continue };
			// The task's first kill work with camps to choose from (the evaluator's spot term reads it).
			let Some(w) = (run.task_w0[task] as usize..run.task_w1[task] as usize).find(|&w| run.w_kind[w] == W_KILL && run.w_alts[w].len() > 1) else { continue };
			let Some((a, c)) = run.w_alts[w].iter().enumerate().map(|(a, x)| (a, run.camps[x.0 as usize].pt)).min_by(|x, y| run.straight(x.1, to).total_cmp(&run.straight(y.1, to))) else { continue };
			if run.straight(c, to) < run.straight(run.task_pt[task], to) {
				run.task_pt[task] = c;
				run.w_default[w] = a as i32;
				moved = true;
			}
			break;
		}
	}
	if moved {
		let pl = std::mem::take(&mut run.pt_list);
		crate::run::kill_shares(run, world, &pl);
		run.pt_list = pl;
	}
}

/// Yards: another quest's task this close to a site is work done there (forge-world's SITE_R: a task's
/// work within it is one place).
pub const CO_SITE_YD: f64 = 70.0;

/// An object's site where other work is done (RevTauren3, c13 Mulgore: the Well Stones at Thunderhorn
/// well, 9 stones at 471 yd from the giver, over Winterhoof, 7 at 438 yd, 20 yd from where Rite of
/// Vision's totem is used: 771 then needs its own trip): a task whose work is all object use, with other
/// sites (the world's task `alts`), and no other quest's task within CO_SITE_YD of its site in its zone,
/// takes the other site that has one, nearest its giver.
pub fn co_sited_tasks(run: &mut crate::run::Run) {
	use crate::run::W_USE;
	let worked = |run: &crate::run::Run, t: usize, p: u32| {
		(0..run.task_pt.len()).any(|o| o != t && run.t_quest[o] != run.t_quest[t] && run.p_map[run.task_pt[o] as usize] == run.p_map[p as usize] && run.straight(run.task_pt[o], p) <= CO_SITE_YD)
	};
	for t in 0..run.task_pt.len() {
		let q = run.t_quest[t];
		if q < 0 || run.task_alts[t].is_empty() || !(run.task_w0[t]..run.task_w1[t]).all(|w| run.w_kind[w as usize] == W_USE) || worked(run, t, run.task_pt[t]) {
			continue;
		}
		let giver = run.q_giver[q as usize];
		let best = run.task_alts[t].iter().copied().filter(|&p| worked(run, t, p)).min_by(|&a, &b| run.straight(a, giver).total_cmp(&run.straight(b, giver)));
		if let Some(p) = best {
			let old = run.task_pt[t];
			run.task_pt[t] = p;
			// (The old site stays an alternative.)
			for a in run.task_alts[t].iter_mut().filter(|a| **a == p) {
				*a = old;
			}
		}
	}
}

/// A lead-in handed in before its follow-up is taken (RevNightElf3, c13 Teldrassil: the planner's own
/// hub loop took the follow-up first twice): per quest of the run whose world `next` is another quest
/// of the run, its hand-in before that quest's accept (a pair, as the deliberate ones: held when
/// both are in the order, left out where v1's own order breaks it).
pub fn lead_in_pairs(world: &World, rules: &Rules, run: &crate::run::Run) -> Vec<crate::order::Pair> {
	(0..run.n_quests() as u32)
		.filter_map(|q| {
			let next = world.quests[*rules.open.get(&run.q_id[q as usize])?].next?;
			let n = run.q(next as u32).filter(|&n| n != q)?;
			Some(crate::order::Pair::new(K_TURNIN, q, K_ACCEPT, n))
		})
		.collect()
}

/// Minutes of one grind block past which the route benchmark's grind rule counts it (a top-up is at most
/// GRIND_BLOCK_MIN), and the long ones.
pub const GRIND_BLOCK_MIN: f64 = 15.0;
pub const GRIND_LONG_MIN: f64 = 30.0;

/// The grind blocks of an order's replay (the route benchmark: grind in one piece, 44 model minutes on the
/// lake shore in Silverpine at 18.3, against at most 15-minute top-ups at the next camp): per step
/// that grinds (a checkpoint, or the model's own before an accept or work under its level) its
/// minutes, and the grind out to 60. The longest, how many are over GRIND_BLOCK_MIN and
/// GRIND_LONG_MIN, the minutes the model grinds unasked (no checkpoint), and the minutes per
/// 10-level band.
pub fn grind_blocks(ev: &mut Evaluator, o: &Order) -> Value {
	ev.reset();
	let mut blocks: Vec<(f64, f64, bool)> = Vec::new();
	for i in 0..o.len() {
		if ev.s.finished {
			break;
		}
		let (g0, l0) = (ev.s.grind_sec, ev.level_now());
		ev.step_in(&o.steps, i);
		let dg = ev.s.grind_sec - g0;
		if dg > 0.0 {
			blocks.push((l0, dg / 60.0, o.steps[i].kind == K_GRIND));
		}
	}
	let (g0, l0) = (ev.s.grind_sec, ev.level_now());
	ev.finish();
	if ev.s.grind_sec > g0 {
		blocks.push((l0, (ev.s.grind_sec - g0) / 60.0, true));
	}
	let mut bands = [0.0f64; 6];
	for b in &blocks {
		bands[((b.0 / 10.0) as usize).min(5)] += b.1;
	}
	let r = |x: f64| (x * 10.0).round() / 10.0;
	json!({
		"maxMin": r(blocks.iter().map(|b| b.1).fold(0.0, f64::max)),
		"over15": blocks.iter().filter(|b| b.1 > GRIND_BLOCK_MIN).count(),
		"over30": blocks.iter().filter(|b| b.1 > GRIND_LONG_MIN).count(),
		"implicitMin": r(blocks.iter().filter(|b| !b.2).map(|b| b.1).sum::<f64>()),
		"excessMin": r(blocks.iter().map(|b| (b.1 - GRIND_BLOCK_MIN).max(0.0)).sum::<f64>()),
		"byBandMin": bands.iter().map(|&x| r(x)).collect::<Vec<_>>(),
	})
}

/// Hours to 30 and 60 and the counters of an order's replay.
pub fn summary(ev: &mut Evaluator, o: &Order) -> Value {
	let blocks = grind_blocks(ev, o);
	let secs = evaluate(ev, o);
	let s = &ev.s;
	json!({
		"hours30": ev.level_times[30] / 3600.0,
		"hours60": secs / 3600.0,
		"steps": o.len(),
		"quests": s.quests_done,
		"grindHours": s.grind_sec / 3600.0,
		"travelHours": s.travel_sec / 3600.0,
		"zoneChanges": s.zone_changes,
		"zoneReturns": s.zone_returns,
		"spotReturns": s.spot_returns,
		"hearths": s.hearths,
		"deathskips": s.deathskips,
		"flights": s.flights,
		"trains": s.trains,
		"logPeak": s.log_peak,
		"noops": s.noops,
		"late": s.late,
		"planHearthsOnCooldown": s.plan_cooldown,
		"logSkipped": s.log_skipped,
		"logAbandoned": s.log_abandoned,
		"alongKills": (s.along_kills * 10.0).round() / 10.0,
		"pooledKills": (s.pooled_kills * 10.0).round() / 10.0,
		"walkMisses": { "legs": s.walk_misses, "hours": s.walk_miss_sec / 3600.0, "longLegs": s.long_misses, "longHours": s.long_miss_sec / 3600.0 },
		"grindBlocks": blocks,
	})
}

pub struct RouteResult {
	pub seed: Order,
	pub best: Order,
	pub seed_hours: Value,
	pub best_hours: Value,
	/// The same orders in the gate's model (walks off, v1 parameters).
	pub seed_gate: Value,
	pub best_gate: Value,
	/// The same orders under the other fidelity model (camps + spots toggled).
	pub seed_other: Value,
	pub best_other: Value,
	pub in_sample: Gains,
	pub holdout: Gains,
	pub diff: Diff,
	pub stats: Stats,
	pub seconds: f64,
	pub order: Vec<Value>,
	/// The guards' counts (sim's port of the judge's avoidable returns and passed-by).
	pub guard_v1: GuardCounts,
	pub guard_best: GuardCounts,
	/// Quests added and dropped against v1, each with its title and why it may be added.
	pub added: Vec<Value>,
	pub dropped: Vec<Value>,
	/// v1's and the improved order as the judge's goal streams (judge_goals).
	pub judge_v1: Vec<Value>,
	pub judge_best: Vec<Value>,
	/// The feasibility rules in force (item needs, escorts) and the ones v1 breaks.
	pub feas: Vec<Value>,
	/// Edit-budget mode: the curve, the knee, and the edits kept, in plain words.
	pub edits: Value,
	/// Walked legs of the v1 order and of the route the walk store has no walk for (world point
	/// pairs, each smaller id first, sorted, unique).
	pub walk_misses: Vec<(u32, u32)>,
	/// The skip ledger and the edit ledger (ledger.rs).
	pub skips: Vec<Value>,
	pub edit_rows: Vec<Value>,
}

/// What a route run may use beyond the world: the game data (insert eligibility) and the
/// guards' mode (None: no guards).
#[derive(Clone, Copy, Default)]
pub struct Extras<'a> {
	pub data: Option<&'a forge_world::GameData>,
	/// The quest atlas (with the walking grid's subzones, as the judge builds it): the guards'.
	pub atlas: Option<&'a forge_world::Atlas>,
	pub guard: Option<GuardMode>,
	/// Quests the knowledge base is unsure of (insertable::kb_doubts): never added.
	pub doubtful: Option<&'a rustc_hash::FxHashMap<u32, String>>,
	/// Quest reward items (needs::load_rewards): item dependencies.
	pub rewards: Option<&'a crate::needs::Rewards>,
	/// What the knowledge base is missing per quest (insertable::kb_missing): the skip ledger.
	pub kb_missing: Option<&'a rustc_hash::FxHashMap<u32, Vec<crate::insertable::Missing>>>,
}

/// The parameter sets of a route: the base (priors, params.json's calibration, overrides) and
/// the draws the search runs under (none: the base alone) and the held-out draws it is
/// reported under (the optimizer's-curse guard, DeepResearch §1.4).
#[derive(Clone, Debug, Default)]
pub struct ParamSets {
	pub doc: Option<Value>,
	pub over: Vec<(String, f64)>,
	pub search: Vec<Vec<(String, f64)>>,
	pub holdout: Vec<Vec<(String, f64)>>,
}

impl ParamSets {
	pub fn base(&self) -> Params {
		Params::effective(self.doc.as_ref(), None, &self.over)
	}
	/// A draw over the base: the draw's values, then the overrides.
	pub fn with(&self, d: &[(String, f64)]) -> Params {
		let mut all = d.to_vec();
		all.extend(self.over.iter().cloned());
		Params::effective(self.doc.as_ref(), None, &all)
	}
}

/// Gains (hours to 60, v1 minus improved) under a set of draws: per draw, by full replay and by
/// the v1 order's and the improved order's counters priced under the draw.
#[derive(Clone, Debug, Default, serde::Serialize)]
pub struct Gains {
	pub draws: usize,
	pub mean: f64,
	pub min: f64,
	pub max: f64,
	pub share_positive: f64,
	pub mean_by_counters: f64,
	pub v1_mean_hours: f64,
}

fn gains(world: &World, race: &str, profile: &Profile, walks: &dyn Walks, sets: &ParamSets, draws: &[Vec<(String, f64)>], seed: &Order, best: &Order, base: &Model) -> Result<Gains, String> {
	let mut g = Gains { draws: draws.len(), min: f64::INFINITY, max: f64::NEG_INFINITY, ..Default::default() };
	if draws.is_empty() {
		return Ok(Gains::default());
	}
	let mut eb = base.evaluator(walks);
	let _ = evaluate(&mut eb, seed);
	let cs = eb.s.c.clone();
	let _ = evaluate(&mut eb, best);
	let cb = eb.s.c.clone();
	for d in draws {
		let (m, _) = model_for(world, race, profile, &sets.with(d), walks)?;
		let mut ev = m.evaluator(walks);
		let v1 = evaluate(&mut ev, seed);
		let im = evaluate(&mut ev, best);
		let x = (v1 - im) / 3600.0;
		g.mean += x;
		g.min = g.min.min(x);
		g.max = g.max.max(x);
		g.share_positive += f64::from(u8::from(x > 0.0));
		g.v1_mean_hours += v1 / 3600.0;
		g.mean_by_counters += (cs.seconds(&m.run, &m.tables.p) - cb.seconds(&m.run, &m.tables.p)) / 3600.0;
	}
	let n = draws.len() as f64;
	g.mean /= n;
	g.share_positive /= n;
	g.v1_mean_hours /= n;
	g.mean_by_counters /= n;
	Ok(g)
}

/// The route benchmark's rule 3 (grind checkpoints are not sacred: 72 grind minutes in our
/// Barrens 12-21.5 against none in a benchmark guide): the origins of the seed's v1 grind checkpoints that guard no
/// gate, so an edit may drop them. A checkpoint guards a gate when its guide step or the next one
/// trains (the level-20 grind before the Orgrimmar class quests: `04-the-barrens` "Level 20"),
/// takes a quest the class-agnostic route cannot (a class quest), or takes one whose minimum level
/// the checkpoint reaches.
pub fn free_grinds(world: &World, rules: &Rules, goals: &[Goal], seed: &Order) -> Vec<i64> {
	let goal = |o: i64| usize::try_from(o).ok().and_then(|i| goals.get(i).filter(|g| g.i == i).or_else(|| goals.iter().find(|g| g.i == i)));
	let mut out = Vec::new();
	for (k, s) in seed.steps.iter().enumerate() {
		if s.kind != crate::run::K_GRIND {
			continue;
		}
		let Some(g) = goal(seed.origin[k]).filter(|g| g.t == "level") else { continue };
		let Some(step) = g.step else { continue };
		let next = goals.iter().filter(|x| x.file == g.file).filter_map(|x| x.step).filter(|&x| x > step).min();
		let level = g.level.unwrap_or(s.q as f64).floor();
		let gate = goals.iter().filter(|x| x.file == g.file && (x.step == Some(step) || (next.is_some() && x.step == next))).any(|x| {
			x.t == "train"
				|| (x.t == "accept"
					&& x.q.is_some_and(|q| match rules.open.get(&q) {
						None => true,
						Some(&i) => world.quests[i].min_level >= level,
					}))
		});
		if !gate {
			out.push(seed.origin[k]);
		}
	}
	out
}

/// v1's `train class` events with the level they are held at or above: the highest minimum level of
/// the quests their guide step takes (its class quests: the Tome of Divinity, 2998, at 12; Trial of
/// the Lake at 16), so a moved training keeps them open (RevA1, RevTauren, RevDwarfGnome).
pub fn train_floors(world: &World, goals: &[Goal], events: &[Event]) -> Vec<Event> {
	let min_of: rustc_hash::FxHashMap<u32, f64> = world.quests.iter().map(|q| (q.id, q.min_level)).collect();
	events
		.iter()
		.map(|e| {
			let mut e = e.clone();
			if e.t == crate::seq::Ev::Train {
				if let Some(g) = usize::try_from(e.src).ok().and_then(|i| goals.get(i).filter(|g| g.i == i).or_else(|| goals.iter().find(|g| g.i == i))).filter(|g| g.step.is_some()) {
					let floor = goals.iter().filter(|x| x.t == "accept" && x.file == g.file && x.step == g.step).filter_map(|x| x.q.and_then(|q| min_of.get(&q).copied())).fold(0.0f64, f64::max);
					if floor > 1.0 {
						e.level = Some(floor);
					}
				}
			}
			e
		})
		.collect()
}

/// The spawn spots of v1's field goals (kill, collect, interact with a quest), per (quest,
/// objective): the compiled goals' own, as the judge's check reads them.
pub fn spots_of(goals: &[Goal]) -> crate::run::Spots {
	let mut out: crate::run::Spots = Vec::new();
	for g in goals.iter().filter(|g| !g.spots.is_empty() && matches!(g.t.as_str(), "kill" | "collect" | "interact")) {
		let Some(q) = g.q else { continue };
		let pts: Vec<(i64, f64, f64)> = g.spots.iter().map(|w| (w.c, w.wx, w.wy)).collect();
		match out.iter_mut().find(|x| x.0 == q && x.1 == g.oi) {
			Some(x) => {
				for p in pts {
					if !x.2.contains(&p) {
						x.2.push(p);
					}
				}
			}
			None => out.push((q, g.oi, pts)),
		}
	}
	out
}

/// Yards from a v1 riding line's place to the world point taken for its trainer.
pub const RIDE_PT_YD: f64 = 400.0;
/// Yards from the trainer a stop is a visit to it (place_ride).
pub const RIDE_VISIT_YD: f64 = 600.0;

/// The start's riding trainers (npc id, world point): each `train <npc>` goal of v1's chain whose
/// npc is a riding trainer (its title says Riding), at the world point nearest the goal's place.
pub fn riding(world: &World, data: &forge_world::GameData, goals: &[Goal]) -> Vec<(u32, u32)> {
	let mut out: Vec<(u32, u32)> = Vec::new();
	for g in goals.iter().filter(|g| g.t == "train") {
		let (Some(npc), Some(w)) = (g.npc, g.w.as_ref()) else { continue };
		if out.iter().any(|r| r.0 == npc) || !data.npcs.get(&npc).and_then(|n| n.sub_name.as_deref()).is_some_and(|s| s.contains("Riding")) {
			continue;
		}
		let near = world
			.points
			.iter()
			.enumerate()
			.filter(|(_, p)| p.c == w.c)
			.map(|(i, p)| (i as u32, (p.wx - w.wx).hypot(p.wy - w.wy)))
			.min_by(|a, b| a.1.total_cmp(&b.1).then(a.0.cmp(&b.0)));
		if let Some((pt, d)) = near.filter(|x| x.1 <= RIDE_PT_YD) {
			let _ = d;
			out.push((npc, pt));
		}
	}
	out
}

/// The seed with riding learned on the first visit to a riding trainer of the start (a stop within
/// RIDE_VISIT_YD of it) at the mount level or above: v1's riding step moved there (its line kept as
/// the step's origin), else left at v1's line when that is at the mount level or above. Returns the
/// order and a note.
pub fn place_ride(model: &Model, walks: &dyn Walks, seed: &Order, events: &[Event]) -> (Order, Option<String>) {
	let run = &model.run;
	if run.riding.is_empty() {
		return (seed.clone(), None);
	}
	// v1's riding line: its event (the first of a trainer of the start's).
	let Some((k, &(npc, pt))) = events.iter().enumerate().find_map(|(k, e)| (e.t == crate::seq::Ev::Ride).then_some(k).and_then(|k| e.npc.and_then(|n| run.riding.iter().find(|r| r.0 == n)).map(|r| (k, r)))) else {
		return (seed.clone(), None);
	};
	let ride = crate::Step { kind: K_RIDE, q: 0, task: npc as i32, pt };
	let mut out = Order { steps: Vec::with_capacity(seed.len() + 1), origin: Vec::with_capacity(seed.len() + 1) };
	for (s, &g) in seed.steps.iter().zip(&seed.origin) {
		if s.kind != K_RIDE {
			out.steps.push(*s);
			out.origin.push(g);
		}
	}
	let mut ev = model.evaluator(walks);
	ev.reset();
	let mount = model.tables.p.mount_level;
	let mut at = None;
	for i in 0..out.len() {
		ev.step_in(&out.steps, i);
		let s = out.steps[i];
		if s.kind != K_GRIND && ev.level_now() >= mount && run.straight(s.pt, pt) <= RIDE_VISIT_YD {
			at = Some(i + 1);
			break;
		}
	}
	let src = events[k].src;
	match at.or_else(|| seed.steps.iter().position(|s| s.kind == K_RIDE)) {
		Some(j) => {
			out.steps.insert(j, ride);
			out.origin.insert(j, src);
			(out, Some(format!("riding from npc {npc} learned on the first visit to the trainer at level {mount} or above")))
		}
		None => (out, None),
	}
}

/// The quests (ids) v1's order takes that `best` does not: `dropped` (the diff's, from the seed)
/// and the ones the overrides took out before the seed, sorted.
pub fn dropped_from_v1(run: &crate::run::Run, v1: &Order, best: &Order, dropped: &[u32]) -> Vec<u32> {
	let in_best: rustc_hash::FxHashSet<u32> = best.steps.iter().filter(|s| s.kind == K_ACCEPT).map(|s| run.q_id[s.q as usize]).collect();
	let mut out = dropped.to_vec();
	for s in v1.steps.iter().filter(|s| s.kind == K_ACCEPT) {
		let id = run.q_id[s.q as usize];
		if !in_best.contains(&id) && !out.contains(&id) {
			out.push(id);
		}
	}
	out.sort_unstable();
	out
}

/// One start made ready for a search: its model (with v1's travel plan for route profiles),
/// rules, v1 seed order, and the search's constraints (deliberate pairs v1 keeps, eligible
/// inserts, feasibility, guards).
pub struct Prepared {
	pub model: Model,
	pub rules: Rules,
	pub profile: Profile,
	pub seed: Order,
	pub pairs: Vec<crate::order::Pair>,
	pub pool: Vec<u32>,
	pub ins: Option<Insertable>,
	pub feas: crate::order::Feas,
	pub feas_rules: Vec<Value>,
	pub guard: Option<Guard>,
	pub gdata: Option<GuardData>,
	pub guard_v1: GuardCounts,
	/// The overrides in force, and v1's order before them.
	pub ovr: crate::order::Overrides,
	pub v1_seed: Order,
}

/// Prepare one start (see Prepared).
pub fn prepare(world: &World, walks: &dyn Walks, base: &Params, race: &str, events: &[Event], goals: &[Goal], profile: &Profile, ex: &Extras) -> Result<Prepared, String> {
	// The start's riding trainers (route profiles): v1's riding lines become riding steps.
	let rides = match ex.data.filter(|_| profile.train_stops) {
		Some(d) => riding(world, d, goals),
		None => Vec::new(),
	};
	let spots = spots_of(goals);
	let profile = &Profile { rides: (!rides.is_empty()).then(|| std::sync::Arc::new(rides)), spots: (!spots.is_empty()).then(|| std::sync::Arc::new(spots)), ..profile.clone() };
	let events = &train_floors(world, goals, events);
	let (mut model0, _) = model_for(world, race, profile, base, walks)?;
	let mut ev0 = model0.evaluator(walks);
	let mut seed = seed_order(&mut ev0, events, profile.train_stops);
	drop(ev0);
	// Riding learned on the first visit to the trainer at the mount level or above (Main B: the
	// Orc in Orgrimmar at 40.0 learned at 45.5, at v1's line); with no such visit, at v1's line;
	// with neither, the start rides from the mount level (the trainers left out).
	let (placed, ride_note) = place_ride(&model0, walks, &seed, events);
	seed = placed;
	let profile = &if model0.run.riding.is_empty() || seed.steps.iter().any(|s| s.kind == K_RIDE) {
		profile.clone()
	} else {
		model0.run.riding.clear();
		Profile { rides: None, ..profile.clone() }
	};
	// Optional quests (route-fixes.json `optional`: rare-drop starts v1 marks optional) are not
	// counted on: out of v1's order as the route plays it.
	let opt = crate::order::deliberate_optional(&model0.run);
	if !opt.is_empty() {
		let keep: Vec<bool> = seed.steps.iter().map(|s| !(matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN) && opt.contains(&s.q))).collect();
		seed = Order { steps: seed.steps.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect(), origin: seed.origin.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect() };
	}
	// Overrides (route-fixes.json): skips out, includes in; then the plan follows them.
	let ovr = crate::order::overrides_for(&model0.run, &crate::order::overrides_doc());
	let v1_seed = seed.clone();
	seed = crate::order::apply_overrides(&model0.run, &seed, &ovr);
	seed = crate::order::keep_pairs(&seed, &ovr.pairs, &|f, x| crate::order::follows(&model0.run, f, x));
	// route-fixes `after` rules v1's order breaks on one map: kept by moving the later step (fix at
	// generation, not left out).
	let (repaired, mut after_notes) = crate::order::keep_after(&model0.run, &seed, &crate::order::deliberate_after(&model0.run));
	seed = repaired;
	// route-fixes `together` rules v1's order breaks: kept by bringing b next to a.
	let (repaired, notes) = crate::order::keep_together(&model0.run, &seed, &crate::order::deliberate_together(&model0.run));
	seed = repaired;
	after_notes.extend(notes);
	after_notes.extend(ride_note);
	// Route profiles travel as v1's guide does: hearths, binds and flight paths at v1's lines.
	let profile = if profile.train_stops {
		Profile { plan: Some(std::sync::Arc::new(travel_plan(&model0.run, &seed, goals))), rare: ex.data.map(|d| std::sync::Arc::new(rare_starts(d))), ..profile.clone() }
	} else {
		profile.clone()
	};
	let (mut model, rules) = model_for(world, race, &profile, base, walks)?;
	// v1's hearth lines the seed plays while the stone cools down are not the route's (F58).
	let cooling = drop_cooling_hearths(&mut model, walks, &seed.steps);
	let profile = if cooling.is_empty() { profile } else { Profile { plan: model.run.plan.clone(), ..profile } };
	let mut pairs = deliberate_pairs(&model.run);
	pairs.extend(ovr.pairs.iter().copied());
	pairs.extend(lead_in_pairs(world, &rules, &model.run));
	// A pair v1's own order breaks can't be a v1 deliberate order for this start (it would
	// also refuse every move): left out, and named (in the route's `feasibility` notes).
	let mut feas_log = Vec::new();
	let kind_name = |k: u8| match k {
		K_ACCEPT => "accept",
		K_TASK => "task",
		_ => "turnin",
	};
	feas_log.extend(after_notes);
	for k in &cooling {
		feas_log.push(format!("v1 hearth line before {} {}{} met while the hearthstone cools down: left out of the travel plan (the route travels on)", kind_name(k.0), k.1, if k.2 >= 0 { format!(" objective {}", k.2) } else { String::new() }));
	}
	let broken = crate::order::broken_pairs(&seed.steps, &pairs);
	for &k in broken.iter().rev() {
		let p = pairs.remove(k);
		feas_log.push(format!("v1 breaks deliberate pair: {} {} before {} {}: left out", kind_name(p.ka), model.run.q_id[p.qa as usize], kind_name(p.kb), model.run.q_id[p.qb as usize]));
	}
	let mut pool = pool(&model.run, &rules, &seed, &model.tables);
	let none = rustc_hash::FxHashMap::default();
	let ins = ex.data.map(|d| Insertable::new(world, &model.run, &rules, d, &model.tables.q_full, ex.doubtful.unwrap_or(&none)));
	if let Some(ins) = &ins {
		pool.retain(|&q| ins.ok(q));
	}
	let mut gdata = match (ex.data, ex.atlas) {
		(Some(d), Some(a)) => Some(GuardData::new(world, &model.run, &rules, d, a)),
		_ => None,
	};
	let seed_run = &runs(&Problem::single(&model, walks, Vec::new(), Vec::new()), &seed)[0];
	let guard_v1 = gdata.as_ref().map(|g| guard_counts_of(g, &model.run, seed_run)).unwrap_or_default();
	// Feasibility: item needs and escorts, less what v1's own order breaks.
	let mut feas = crate::order::Feas::default();
	if model.tables.p.feasible {
		if let (Some(d), Some(rw)) = (ex.data, ex.rewards) {
			feas.needs = crate::needs::item_needs(world, &model.run, &rules, d, rw, &seed, goals);
		}
		feas.escorts = crate::order::Feas::escorts_of(&model.run);
	}
	(feas.keep, feas.south) = crate::order::deliberate_feas(&model.run);
	feas.together = crate::order::deliberate_together(&model.run);
	feas.needs.extend(crate::order::deliberate_after(&model.run));
	feas.needs.extend(crate::order::deliberate_stay(&model.run, &seed.steps));
	let stays: Vec<(u8, u32, Option<u32>, String)> =
		ovr.stay.iter().map(|&(k, q, t)| (k, q, t, format!("override: {}", ovr.why.get(&model.run.q_id[q as usize]).map_or("", |w| w.0.as_str())))).collect();
	feas.needs.extend(crate::order::stay_needs(&model.run, &v1_seed.steps, &stays));
	feas.keep.extend(ovr.include.iter().map(|x| x.0).chain(ovr.keep.iter().copied()));
	feas.skip.extend(ovr.skip.iter().copied());
	feas.free_grinds = free_grinds(world, &rules, goals, &seed);
	feas.keep_seed(&model.run, &seed.steps, &mut feas_log);
	for l in &feas_log {
		eprintln!("{l}");
	}
	let feas_rules: Vec<Value> = feas
        .needs
        .iter()
        .map(|n| json!({ "after": model.run.q_id[n.qa as usize], "afterStep": match n.ka { K_ACCEPT => "accept", K_TASK => "task", _ => "turnin" }, "before": model.run.q_id[n.qb as usize], "step": match n.kb { K_ACCEPT => "accept", K_TASK => "task", _ => "turnin" }, "why": n.why }))
        .chain(feas.escorts.iter().map(|e| json!({ "escort": model.run.q_id[e.q as usize] })))
        .chain(feas_log.iter().map(|l| json!({ "note": l })))
        .collect();
	let guard = match (ex.guard, gdata.take()) {
		(Some(mode), Some(data)) => Some(Guard { data, mode, v1: guard_v1.clone(), train_levels: crate::search::train_levels(&seed, seed_run) }),
		(_, g) => {
			gdata = g;
			None
		}
	};
	for &(q, after) in &ovr.include {
		if let Some((k, a)) = after {
			pairs.push(crate::order::Pair::new(k, a, K_ACCEPT, q));
		}
	}
	pool.retain(|q| !ovr.skip.contains(q));
	Ok(Prepared { model, rules, profile, seed, pairs, pool, ins, feas, feas_rules, guard, gdata, guard_v1, ovr, v1_seed })
}

/// Improve one start's v1 order: search under `sets.search` draws (or the base), report under
/// the base, the gate's model, the other fidelity model, and the held-out draws. `written`: the
/// route written and its guides checked (crate::flow), its findings fed back for at most FLOW_ROUNDS
/// rounds, each kept when the check finds fewer.
///
/// With a checkpoint unit `ck` (resume.rs): the free search and the edit descent checkpoint as
/// they go, and the finished search (the order and edit list after every pass) is saved before the
/// route is finished from it; a start whose search finished under the same key is finished from
/// that checkpoint without searching.
#[allow(clippy::too_many_arguments)]
pub fn improve(
	world: &World,
	walks: &dyn Walks,
	sets: &ParamSets,
	race: &str,
	events: &[Event],
	goals: &[Goal],
	profile: &Profile,
	opts: &SearchOpts,
	ex: Extras,
	ck: Option<&crate::resume::Unit>,
	written: Option<&mut dyn FnMut(&RouteResult) -> Result<Vec<crate::flow::Finding>, String>>,
) -> Result<RouteResult, String> {
	let base = sets.base();
	let mut prep = prepare(world, walks, &base, race, events, goals, profile, &ex)?;
	let guard = prep.guard.take();
	let (model, rules, seed, ins, gdata) = (&prep.model, &prep.rules, &prep.seed, prep.ins.as_ref(), prep.gdata.as_ref());
	let profile = &prep.profile;
	let drawn: Vec<Model> = sets.search.iter().map(|d| model_for(world, race, profile, &sets.with(d), walks).map(|x| x.0)).collect::<Result<_, _>>()?;
	let mut problem = Problem::single(model, walks, prep.pairs.clone(), prep.pool.clone());
	if !drawn.is_empty() {
		problem.ctxs = drawn.iter().map(|m| CtxSpec { model: m, prefix: Vec::new(), map: None, name: String::new() }).collect();
	}
	problem.feas = prep.feas.clone();
	problem.guard = guard;
	// The log: never above LOG_BOUND (room for the class quests a writer adds), or v1's peak.
	if profile.train_stops {
		let v1_peak = runs(&problem, seed)[0].log_peak;
		problem.log_bound = v1_peak.max(LOG_BOUND);
	}
	if let Some((u, d)) = ck.and_then(|u| u.load::<crate::resume::DoneCk>(crate::resume::DONE).map(|d| (u, d))) {
		u.note(format!("resuming {} from checkpoint (search done, {} tries)", u.name, d.stats.tries));
		let fin = Finish { world, walks, sets, race, goals, ex: &ex, profile, prep: &prep, problem: &problem };
		// (The written check runs again on it; the hub batches are not checkpointed: none undone.)
		let wo = Written { world, rules, model, race, problem: &problem, fin: &fin, batches: &[], refused: d.refused.into_iter().collect(), stats: d.stats, seconds: d.seconds };
		return wo.rounds(d.best.into(), d.edits, written);
	}
	let t0 = std::time::Instant::now();
	let mut refused: rustc_hash::FxHashMap<u32, String> = Default::default();
	let mut stats = Stats::default();
	// The free search (free, hybrid): its order, and the edit list it makes against the seed.
	let mut best = seed.clone();
	let mut edits_doc = Value::Null;
	if opts.mode != Mode::Edits {
		let o = search(&problem, seed, opts, ck);
		eprintln!("{} {race}: free search {} tries, {} kept -> {:.3} h", world.faction.name(), o.stats.tries, o.stats.kept, o.totals.iter().sum::<f64>() / 3600.0);
		stats = o.stats;
		best = o.best;
		edits_doc = free_edits_json(world, rules, &problem, seed, &best);
	}
	// The edit descent (edits, hybrid: from the free search's order, in memory).
	if opts.mode != Mode::Free {
		let mut log = |k: usize, h: f64, kind: &str| eprintln!("{} {race}: edit {k}: {kind} -> {h:.3} h", world.faction.name());
		let dsc = crate::search::edits::descend(&problem, &best, opts.edits.unwrap_or(400), opts.members, opts.no_worse, &mut log, ck);
		let k = crate::search::edits::cut_at(&dsc, opts.budget, opts.cut);
		let mut doc = edits_json(world, rules, model, &dsc, k);
		if let (Some(free), Some(list)) = (edits_doc["list"].as_array(), doc["list"].as_array_mut()) {
			let mut all = free.clone();
			all.append(list);
			*list = all;
			doc["free"] = edits_doc["free"].clone();
		}
		edits_doc = doc;
		if k > 0 {
			best = dsc.orders[k - 1].clone();
		}
	}
	// The pickup pass: worthwhile passed-by quests inserted where they are passed.
	let gd = problem.guard.as_ref().map(|g| &g.data).or(gdata);
	let mut batches = Vec::new();
	if let (true, Some(g)) = (profile.train_stops, gd) {
		let mut m = crate::search::Member::new(&problem, best.clone(), &runs(&problem, &best), 1);
		let mut plog = |s: &str| eprintln!("{s}");
		// Stay on the continent: a trip off it for low quests taken out first (pickups then judge
		// what the route passes without it).
		let stays = crate::search::passby::stay_on_continent(&problem, &mut m, &mut plog);
		let (picks, refused_now) = crate::search::passby::pickup(&problem, &mut m, ins, g, &mut plog);
		refused = refused_now;
		if edits_doc.is_null() {
			edits_doc = json!({ "list": [] });
		}
		if let Some(list) = edits_doc["list"].as_array_mut() {
			let at = list.iter().position(|x| x["kept"] != json!(true)).unwrap_or(list.len());
			for (j, pk) in picks.iter().enumerate() {
				let ins: Vec<&(usize, crate::Step)> = match &pk.mv {
					crate::search::edits::Mv::Insert { at, .. } => at.iter().collect(),
					crate::search::edits::Mv::Seq { mvs, .. } => mvs.iter().flat_map(|m| if let crate::search::edits::Mv::Insert { at, .. } = m { at.iter().collect() } else { Vec::new() }).collect(),
					_ => Vec::new(),
				};
				let steps: Vec<Value> = ins.iter().map(|x| crate::ledger::step_json(&model.run, x.1)).collect();
				let to = ins.first().map_or(Value::Null, |x| json!(x.0));
				list.insert(at + j, json!({ "kept": true, "kind": "pickup", "text": pickup_words(world, rules, model, pk), "savedMin": (-pk.added / 60.0 * 100.0).round() / 100.0, "hours": (pk.hours * 1000.0).round() / 1000.0, "q": pk.v.id, "steps": steps, "to": to }));
			}
			for (n, x) in list.iter_mut().enumerate() {
				x["n"] = json!(n + 1);
			}
		}
		edits_doc["pickups"] = json!(picks.len());
		hub_sweep_rows(world, rules, model, &mut edits_doc, &stays, "stayOnContinent");
		// The hub pickup pass: quests open on an earlier visit to their giver taken then.
		let hubs = crate::search::passby::hub_pickup(&problem, &mut m, &mut plog);
		hub_pickup_rows(world, rules, model, &mut edits_doc, &hubs, "hub pickup", "hubPickups");
		// Quests done from the bags taken, done and handed in at once (a tie the pickup refused).
		let ties = crate::search::passby::bag_ties(&problem, &mut m, &mut plog);
		hub_pickup_rows(world, rules, model, &mut edits_doc, &ties, "bag tie", "bagTies");
		// The camp gather pass: a camp worked in two halves joined.
		let gathers = crate::search::passby::camp_gather(&problem, &mut m, &mut plog);
		camp_gather_rows(world, rules, model, &mut edits_doc, &gathers);
		// The hub batch: a hub return for one hand-in folded into the next visit there.
		batches = crate::search::passby::hub_batch(&problem, &mut m, &mut plog);
		hub_sweep_rows(world, rules, model, &mut edits_doc, &batches, "hubBatches");
		// The hub sweep: what is ready at a hub done in that visit, ready NPCs passed on the way
		// done then, each visit's stops in loop order.
		let sweeps = crate::search::passby::hub_sweep(&problem, &mut m, &mut plog);
		hub_sweep_rows(world, rules, model, &mut edits_doc, &sweeps, "hubSweeps");
		// Trainings at the hub, not inside a field stretch.
		let trains = crate::search::passby::trains_out_of_field(&problem, &mut m, &mut plog);
		hub_sweep_rows(world, rules, model, &mut edits_doc, &trains, "trainsAtHub");
		// Early hard work deferred to its level (grind priced as a cost), then the grind left made
		// explicit and in pieces of at most 15 minutes.
		// Hubs visited again at the level their chains open (the grind their XP removes).
		let revisits = crate::search::passby::hub_revisits(&problem, &mut m, &mut plog);
		hub_sweep_rows(world, rules, model, &mut edits_doc, &revisits, "hubRevisits");
		let defers = crate::search::passby::defer_hard_work(&problem, &mut m, &mut plog);
		hub_sweep_rows(world, rules, model, &mut edits_doc, &defers, "deferredWork");
		let topups = crate::search::passby::grind_topups(&problem, &mut m, &mut plog);
		hub_sweep_rows(world, rules, model, &mut edits_doc, &topups, "grindTopUps");
		best = m.order.clone();
	}
	let seconds = t0.elapsed().as_secs_f64();
	if let Some(u) = ck {
		let mut refused_list: Vec<(u32, String)> = refused.iter().map(|(&q, s)| (q, s.clone())).collect();
		refused_list.sort_unstable();
		u.save(crate::resume::DONE, &crate::resume::DoneCk { best: (&best).into(), edits: edits_doc.clone(), refused: refused_list, stats: stats.clone(), seconds });
	}
	let fin = Finish { world, walks, sets, race, goals, ex: &ex, profile, prep: &prep, problem: &problem };
	let wo = Written { world, rules, model, race, problem: &problem, fin: &fin, batches: &batches, refused, stats, seconds };
	wo.rounds(best, edits_doc, written)
}

/// What the written check's rounds (Written::rounds) read in improve.
struct Written<'a> {
	world: &'a World,
	rules: &'a Rules,
	model: &'a Model,
	race: &'a str,
	problem: &'a Problem<'a>,
	fin: &'a Finish<'a>,
	batches: &'a [crate::search::passby::HubPickup],
	refused: rustc_hash::FxHashMap<u32, String>,
	stats: Stats,
	seconds: f64,
}

impl Written<'_> {
	/// The route finished from `best`; with `written` (route profiles), the written check
	/// (crate::flow): its findings back to the order as moves, written and checked again, a round
	/// kept when the check finds fewer.
	fn rounds(self, mut best: Order, mut edits_doc: Value, written: Option<&mut dyn FnMut(&RouteResult) -> Result<Vec<crate::flow::Finding>, String>>) -> Result<RouteResult, String> {
		let (world, rules, model, race, problem, fin) = (self.world, self.rules, self.model, self.race, self.problem, self.fin);
		let Some(written) = written.filter(|_| fin.profile.train_stops) else { return finish(fin, best, edits_doc, self.refused, self.stats, self.seconds) };
		let mut r = finish(fin, best.clone(), edits_doc.clone(), self.refused.clone(), self.stats.clone(), self.seconds)?;
		let mut found = written(&r)?;
		eprintln!("{} {race}: written check: {}", world.faction.name(), crate::flow::summary(&found));
		let mut fixed = 0;
		for round in 1..=crate::flow::FLOW_ROUNDS {
			if found.is_empty() {
				break;
			}
			let mut m = crate::search::Member::new(problem, best.clone(), &runs(problem, &best), 1);
			let mut plog = |s: &str| eprintln!("{s}");
			let fixes = crate::search::passby::flow_fixes(problem, &mut m, &found, self.batches, &mut plog);
			if fixes.is_empty() {
				break;
			}
			let mut doc = edits_doc.clone();
			hub_sweep_rows(world, rules, model, &mut doc, &fixes, "writtenCheck");
			doc["writtenCheck"] = json!(fixed + fixes.len());
			let nr = finish(fin, m.order.clone(), doc.clone(), self.refused.clone(), self.stats.clone(), self.seconds)?;
			let now = written(&nr)?;
			eprintln!("{} {race}: written check round {round}: {} moves -> {}", world.faction.name(), fixes.len(), crate::flow::summary(&now));
			// (No better: the route as it was, which the caller writes again.)
			if now.len() >= found.len() {
				break;
			}
			(best, edits_doc, r, found) = (m.order, doc, nr, now);
			fixed += fixes.len();
		}
		Ok(r)
	}
}

/// The free search's route against the seed as an edit list (the ledger's rows: free mode has
/// no edit-by-edit history): each quest added (`insert`), dropped (`drop`) or reordered among
/// the quest events (`free move`, the shift in places), with `kept` true and no minutes of its
/// own; `free` holds the hours before and after.
pub fn free_edits_json(world: &World, rules: &Rules, problem: &Problem, seed: &Order, best: &Order) -> Value {
	let run = &problem.model.run;
	let title = |q: u32| rules.open.get(&run.q_id[q as usize]).map(|&i| world.quests[i].title.clone()).unwrap_or_default();
	let zone = |pt: u32| world.zones.get(&run.p_map[pt as usize]).cloned().unwrap_or_default();
	let q_of = |id: u32| run.q(id);
	let steps_of = |o: &Order, q: u32| o.steps.iter().filter(|s| s.q == q && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN)).map(|&s| crate::ledger::step_json(run, s)).collect::<Vec<_>>();
	let acc = |o: &Order, q: u32| o.steps.iter().position(|s| s.q == q && s.kind == K_ACCEPT);
	let lv = runs(problem, best)[0].levels().to_vec();
	let off = problem.ctxs[0].prefix.len();
	let lvl = |i: usize| lv.get(i + off).copied().unwrap_or(60.0);
	let d = diff(run, seed, best);
	let mut list = Vec::new();
	for &id in &d.added {
		let Some(q) = q_of(id) else { continue };
		let i = acc(best, q).unwrap_or(0);
		list.push(json!({ "kept": true, "kind": "insert", "text": format!("{}, L{:.1}: add {} (level {}; free search)", zone(best.steps[i].pt), lvl(i), title(q), run.q_level[q as usize]), "savedMin": Value::Null, "steps": steps_of(best, q), "from": Value::Null, "to": i, "q": id }));
	}
	for &id in &d.dropped {
		let Some(q) = q_of(id) else { continue };
		let i = acc(seed, q).unwrap_or(0);
		list.push(json!({ "kept": true, "kind": "drop", "text": format!("{}: drop {} (level {}; free search)", zone(seed.steps[i].pt), title(q), run.q_level[q as usize]), "savedMin": Value::Null, "steps": steps_of(seed, q), "from": i, "to": Value::Null, "q": id }));
	}
	for &(id, shift) in &d.reordered {
		let Some(q) = q_of(id) else { continue };
		let (Some(i0), Some(i1)) = (acc(seed, q), acc(best, q)) else { continue };
		list.push(json!({ "kept": true, "kind": "free move", "text": format!("{}, L{:.1}: {} reordered, {} quest events {} (free search)", zone(best.steps[i1].pt), lvl(i1), title(q), shift.unsigned_abs(), if shift < 0 { "earlier" } else { "later" }), "savedMin": Value::Null, "steps": steps_of(best, q), "from": i0, "to": i1, "q": id }));
	}
	let h = |o: &Order| runs(problem, o).iter().map(|c| c.total).sum::<f64>() / 3600.0;
	json!({ "free": { "startHours": h(seed), "endHours": h(best), "added": d.added.len(), "dropped": d.dropped.len(), "reordered": d.reordered.len() }, "list": list })
}

/// What `finish` reports a route with: the start's preparation (v1's seed and model: the v1
/// numbers), and the problem whose model plays the route (its travel plan may differ from v1's:
/// a shared tail's), with its constraints and guards.
pub struct Finish<'a> {
	pub world: &'a World,
	pub walks: &'a dyn Walks,
	pub sets: &'a ParamSets,
	pub race: &'a str,
	/// The goals the route's origins index (for a shared route: the start's, then the canonical start's).
	pub goals: &'a [Goal],
	pub ex: &'a Extras<'a>,
	/// The route's profile (its travel plan): draws and the other fidelity model use it.
	pub profile: &'a Profile,
	pub prep: &'a Prepared,
	pub problem: &'a Problem<'a>,
}

/// Report a route found for a prepared start: hours (v1 under its own model, the route under
/// the problem's), the gate's and the other fidelity model's numbers, held-out gains, the order
/// as the writer reads it, the judge's streams, passed-by quests and the ledgers.
pub fn finish(f: &Finish, best: Order, mut edits_doc: Value, refused: rustc_hash::FxHashMap<u32, String>, stats: Stats, seconds: f64) -> Result<RouteResult, String> {
	let (world, walks, sets, race, goals, ex, profile, problem) = (f.world, f.walks, f.sets, f.race, f.goals, f.ex, f.profile, f.problem);
	let p = f.prep;
	let (model, bm, rules, seed, ins, gdata, ovr, v1_seed) = (&p.model, problem.model, &p.rules, &p.seed, p.ins.as_ref(), p.gdata.as_ref(), &p.ovr, &p.v1_seed);
	let base = sets.base();
	let mut ev = model.evaluator(walks);
	let mut bev = bm.evaluator(walks);
	let best = clean(&mut bev, &best);
	// A breadcrumb handed in before its follow-up is taken at the same NPC (RevA2: 2872/2873,
	// 3763/3764 the other way round).
	let crumbs: Vec<(u32, u32)> = world.quests.iter().filter(|w| w.breadcrumb).filter_map(|w| Some((bm.run.q(w.id)?, bm.run.q(w.next? as u32)?))).collect();
	let best = crate::order::breadcrumbs_first(&bm.run, &crumbs, &best);
	// Quests the route takes and never hands in before 60 (an include or insert whose work falls
	// after it: 5845 Of Lost Honor at 59.9) are left out; v1's own carried past 60 stay.
	let (best, unfinished) = drop_unfinished(&bm.run, &best, v1_seed);
	let seed_hours = summary(&mut ev, seed);
	let best_hours = summary(&mut bev, &best);
	// The walk store's misses on v1's order (its own model) and on the route.
	let walk_misses = {
		let mut v = Vec::new();
		for (m, o) in [(model, seed), (bm, &best)] {
			let mut e = m.evaluator(walks);
			e.misses = Some(Vec::new());
			let _ = evaluate(&mut e, o);
			v.extend(e.misses.take().unwrap_or_default().into_iter().map(|(a, b)| (a.min(b), a.max(b))));
		}
		v.sort_unstable();
		v.dedup();
		v
	};
	// The gate's model: v1's parameters, walks off.
	let gate = Profile::gate();
	let v1p = Params { camps: false, spots: false, ..base.clone() };
	let (gm, _) = model_for(world, race, &gate, &v1p, &NoWalks)?;
	let mut gev = gm.evaluator(&NoWalks);
	let to_gate = |o: &Order| Order { steps: o.steps.iter().copied().filter(|s| s.kind != K_TRAIN && s.kind != K_RIDE).map(|s| remap(model, &gm, s)).collect(), origin: Vec::new() };
	let seed_gate = summary(&mut gev, &to_gate(seed));
	let best_gate = summary(&mut gev, &to_gate(&best));
	// The other fidelity model (camps + spots on when the search had them off, and off when on).
	let on = !base.camps;
	let (om, _) = model_for(world, race, profile, &Params { camps: on, spots: on, ..base.clone() }, walks)?;
	let mut oev = om.evaluator(walks);
	let seed_other = summary(&mut oev, seed);
	let best_other = summary(&mut oev, &best);
	let mut dd = diff(&model.run, seed, &best);
	// The quests the overrides skip are dropped too (RevH2: overrides.skip 5821/5943 came out
	// before the seed, so the writer, which drops what `dropped` names, kept v1's lines).
	dd.dropped = dropped_from_v1(&model.run, v1_seed, &best, &dd.dropped);
	ev.reset();
	let _ = evaluate(&mut ev, seed);
	let (sz, ss, sc) = (ev.s.zone_returns, ev.s.spot_returns, ev.s.zone_changes);
	let _ = evaluate(&mut bev, &best);
	dd.zone_returns = (sz, bev.s.zone_returns);
	dd.spot_returns = (ss, bev.s.spot_returns);
	dd.zone_changes = (sc, bev.s.zone_changes);
	let in_sample = gains(world, race, profile, walks, sets, &sets.search, seed, &best, bm)?;
	let holdout = gains(world, race, profile, walks, sets, &sets.holdout, seed, &best, bm)?;
	let order = describe(bm, walks, &best, goals);
	let best_run = &runs(&Problem::single(bm, walks, Vec::new(), Vec::new()), &best)[0];
	let gd = problem.guard.as_ref().map(|g| &g.data).or(gdata);
	let guard_best = gd.map(|g| guard_counts_of(g, &bm.run, best_run)).unwrap_or_default();
	let named = |q: u32| world.quests[rules.open[&model.run.q_id[q as usize]]].title.clone();
	let qi = |id: u32| model.run.q(id).unwrap();
	let added = dd.added.iter().map(|&id| json!({ "q": id, "title": named(qi(id)), "level": model.run.q_level[qi(id) as usize], "allowed": ins.map(|i| i.why(qi(id))) })).collect();
	let dropped = dd.dropped.iter().map(|&id| json!({ "q": id, "title": named(qi(id)), "level": model.run.q_level[qi(id) as usize] })).collect();
	let judge_v1 = judge_goals(model, world, rules, &seed.steps, &runs(&Problem::single(model, walks, Vec::new(), Vec::new()), seed)[0]);
	let judge_best = judge_goals(bm, world, rules, &best.steps, best_run);
	// Passed-by quests (worthwhile or rightly skipped) and long single-quest trips, v1 and best.
	let passby = match gd {
		Some(g) => {
			let rep = |o: &Order| {
				let m = crate::search::Member::new(problem, o.clone(), &runs(problem, o), 1);
				let vs = crate::search::passby::classify(problem, &m, ins, g);
				let trips = crate::search::passby::long_trips(problem, o, &m.ctxs[0].cur);
				let mut j = passby_json(world, rules, bm, &vs, &trips);
				j["hearths"] = json!(crate::search::passby::hearths(problem, o));
				j
			};
			json!({ "v1": rep(seed), "best": rep(&best) })
		}
		None => Value::Null,
	};
	// The ledgers: what the route does not take and why, and what it changed against v1.
	let best_m = crate::search::Member::new(problem, best.clone(), &runs(problem, &best), 1);
	let best_passed = gd.map(|g| crate::search::passby::classify(problem, &best_m, ins, g)).unwrap_or_default();
	let optional: Vec<(u32, String)> = crate::order::deliberate_optional_why(&model.run);
	let lin = crate::ledger::LedgerIn {
		world,
		race,
		rules,
		model: bm,
		data: ex.data,
		goals,
		v1: v1_seed,
		best: &best,
		lv: best_m.ctxs[0].cur.levels(),
		passed: &best_passed,
		refused: &refused,
		ins,
		kb: ex.kb_missing,
		ovr,
		edits: &edits_doc,
		optional: &optional,
		unfinished: &unfinished,
		walks: Some(walks),
	};
	let skips = crate::ledger::skips(&lin);
	let edit_rows = crate::ledger::edit_rows(&edits_doc, ovr, &model.run);
	if !passby.is_null() {
		edits_doc["passby"] = passby;
	}
	Ok(RouteResult {
		walk_misses,
		skips,
		edit_rows,
		edits: edits_doc,
		guard_v1: p.guard_v1.clone(),
		guard_best,
		added,
		dropped,
		judge_v1,
		judge_best,
		feas: p.feas_rules.clone(),
		seed: seed.clone(),
		best,
		seed_hours,
		best_hours,
		seed_gate,
		best_gate,
		seed_other,
		best_other,
		in_sample,
		holdout,
		diff: dd,
		stats,
		seconds,
		order,
	})
}

/// The order without the quests it accepts and never hands in, unless `v1` does the same (a quest
/// v1's last guide hands out for after 60); with those quests (run indices).
pub fn drop_unfinished(run: &crate::run::Run, best: &Order, v1: &Order) -> (Order, Vec<u32>) {
	let open = |o: &Order| -> rustc_hash::FxHashSet<u32> {
		let tin: rustc_hash::FxHashSet<u32> = o.steps.iter().filter(|s| s.kind == K_TURNIN).map(|s| s.q).collect();
		o.steps.iter().filter(|s| s.kind == K_ACCEPT && !tin.contains(&s.q)).map(|s| s.q).collect()
	};
	let v1_open: rustc_hash::FxHashSet<u32> = open(v1).iter().map(|&q| run.q_id[q as usize]).collect();
	let mut drop: Vec<u32> = open(best).into_iter().filter(|q| !v1_open.contains(&run.q_id[*q as usize])).collect();
	drop.sort_unstable();
	if drop.is_empty() {
		return (best.clone(), drop);
	}
	let keep: Vec<usize> = (0..best.len()).filter(|&i| !(matches!(best.steps[i].kind, K_ACCEPT | K_TASK | K_TURNIN) && drop.binary_search(&best.steps[i].q).is_ok())).collect();
	(Order { steps: keep.iter().map(|&i| best.steps[i]).collect(), origin: keep.iter().map(|&i| best.origin[i]).collect() }, drop)
}

/// A step of one model as the same step of another (same world, other point list).
fn remap(from: &Model, to: &Model, s: crate::Step) -> crate::Step {
	let mut x = s;
	if s.kind != K_GRIND {
		let wp = from.run.pt_list[s.pt as usize];
		x.pt = to.run.run_pt(wp).unwrap_or(s.pt);
	}
	x
}

/// Yards away from a town that make the next stop there a return (a bind's `returns`).
pub const RETURN_AWAY_YD: f64 = 600.0;

/// The order as a list a writer reads: per step its kind, quest id and title, where it came
/// from (the seed goal's guide and line, or inserted / a training stop).
pub fn describe(model: &Model, walks: &dyn Walks, o: &Order, goals: &[Goal]) -> Vec<Value> {
	let run = &model.run;
	// The route items the evaluator decides (binds, hearths, flights, flight paths), by step.
	let mut ev = model.evaluator(walks);
	ev.trace = Some(Vec::new());
	let mut levels = Vec::with_capacity(o.len());
	ev.reset();
	for i in 0..o.len() {
		levels.push(ev.level_now());
		if !ev.s.finished {
			ev.step_in(&o.steps, i);
		}
	}
	let mut items: Vec<Vec<Value>> = vec![Vec::new(); o.len()];
	let trace = ev.trace.take().unwrap_or_default();
	// A bind is used when a hearth to it comes before the next bind (the writer's sethome; a
	// hearth never goes to an inn the route did not bind at, #171).
	let used: Vec<bool> = (0..trace.len())
		.map(|k| match trace[k].1 {
			crate::eval::Trace::Bind { inn, .. } => {
				trace[k + 1..].iter().take_while(|x| !matches!(x.1, crate::eval::Trace::Bind { .. })).any(|x| matches!(x.1, crate::eval::Trace::Hearth { inn: h, .. } if h == inn))
			}
			_ => false,
		})
		.collect();
	// A bind's returns: separate later visits to its town (a stop within NEAR_HUB of the inn after
	// being RETURN_AWAY_YD away) before the next bind: where a writer keeps the bind even when
	// the model walks back (Lakeshire, Darkshire).
	let next_bind: Vec<usize> = (0..trace.len()).map(|k| trace[k + 1..].iter().position(|x| matches!(x.1, crate::eval::Trace::Bind { .. })).map_or(o.len(), |m| trace[k + 1 + m].0 as usize)).collect();
	let returns = |k: usize, inn: u32| {
		let ip = run.inn_pt[inn as usize];
		let (mut n, mut away) = (0, false);
		for s in &o.steps[(trace[k].0 as usize + 1).min(o.len())..next_bind[k].min(o.len())] {
			if s.kind == K_GRIND {
				continue;
			}
			let dd = run.straight(ip, s.pt);
			if dd > RETURN_AWAY_YD {
				away = true;
			} else if away && dd <= crate::run::NEAR_HUB {
				n += 1;
				away = false;
			}
		}
		n
	};
	let rets: Vec<u32> = (0..trace.len()).map(|k| if let crate::eval::Trace::Bind { inn, .. } = trace[k].1 { returns(k, inn) } else { 0 }).collect();
	for (j, (k, t)) in trace.into_iter().enumerate() {
		let mut v = serde_json::to_value(&t).unwrap_or_default();
		if matches!(t, crate::eval::Trace::Bind { .. }) {
			v["used"] = json!(used[j]);
			v["returns"] = json!(rets[j]);
		}
		for key in ["pt", "to", "from"] {
			if let Some(p) = v.get(key).and_then(Value::as_u64) {
				v[key] = json!(run.pt_list[p as usize]);
			}
		}
		if let Some(inn) = v.get("inn").and_then(Value::as_u64) {
			v["innPt"] = json!(run.pt_list[run.inn_pt[inn as usize] as usize]);
		}
		if let Some(x) = items.get_mut(k as usize) {
			x.push(v);
		}
	}
	o.steps
		.iter()
		.zip(&o.origin)
		.enumerate()
		.map(|(i, (s, &g))| {
			let t = match s.kind {
				K_ACCEPT => "accept",
				K_TASK => "task",
				K_TURNIN => "turnin",
				K_GRIND => "level",
				K_TRAIN => "train",
				K_RIDE => "ride",
				_ => "?",
			};
			let mut v = json!({ "t": t, "lvl": (levels[i] * 100.0).round() / 100.0 });
			match s.kind {
				K_GRIND => {
					v["level"] = json!(s.q);
					// The fractional level target (the writer's `level N.f`).
					v["target"] = json!(((s.q as f64 + s.task.max(0) as f64 / crate::xp::LEVEL_XP[(s.q as usize).min(59)].max(1.0)) * 100.0).round() / 100.0);
				}
				K_TRAIN => v["pt"] = json!(run.pt_list[s.pt as usize]),
				K_RIDE => {
					v["npc"] = json!(s.task);
					v["pt"] = json!(run.pt_list[s.pt as usize]);
				}
				_ => {
					v["q"] = json!(run.q_id[s.q as usize]);
					if s.kind == K_TASK {
						v["task"] = json!(s.task as u32 - run.q_task0[s.q as usize]);
					}
					v["pt"] = json!(run.pt_list[s.pt as usize]);
				}
			}
			match g {
				INSERTED => v["from"] = json!("inserted"),
				g if g <= TRAIN_STOP => v["from"] = json!("train stop"),
				g => {
					if let Some(goal) = goals.get(g as usize) {
						v["from"] = json!(format!("{}:{}", goal.file, goal.line.unwrap_or(0)));
					}
				}
			}
			if !items[i].is_empty() {
				v["items"] = json!(items[i]);
			}
			v
		})
		.collect()
}

fn guard_counts_of(g: &GuardData, run: &crate::Run, c: &crate::search::Current) -> GuardCounts {
	c.guard_counts(g, run)
}

/// The search's counters as JSON.
pub fn stats_json(s: &Stats, seconds: f64) -> Value {
	let by: Vec<Value> = (0..MOVES).map(|k| json!({ "move": MOVE_NAMES[k], "tried": s.by_move[k][0], "kept": s.by_move[k][1] })).collect();
	json!({
		"tries": s.tries, "invalid": s.invalid, "guardRejected": s.guard_rejected, "estimated": s.estimated, "exact": s.exact, "kept": s.kept,
		"stepsReplayed": s.steps_replayed, "seconds": seconds,
		"evaluationsPerSecond": (s.estimated + s.exact) as f64 / seconds.max(1e-9),
		"triesPerSecond": s.tries as f64 / seconds.max(1e-9),
		"byMove": by,
		"refusedBy": (0..crate::search::RULES).map(|k| json!({ "rule": crate::search::RULE_NAMES[k], "moves": s.refused[k] })).collect::<Vec<_>>(),
	})
}

/// An order as the judge's goal stream (walk.js goals: t, q, oi, w, lvl, lvlAfter): accepts,
/// objective sites (`collect`, with the objective's 1-based oi) and turn-ins at the order's
/// points, levels from the order's run. For checking the guards against the JS judge.
pub fn judge_goals(model: &Model, world: &World, rules: &Rules, steps: &[crate::Step], c: &crate::search::Current) -> Vec<Value> {
	let run = &model.run;
	let lv = c.levels();
	let mut out = Vec::new();
	for (i, s) in steps.iter().enumerate() {
		let t = match s.kind {
			K_ACCEPT => "accept",
			K_TASK => "collect",
			K_TURNIN => "turnin",
			_ => continue,
		};
		let q = s.q as usize;
		let p = s.pt as usize;
		let mut g = json!({ "i": out.len(), "t": t, "q": run.q_id[q], "w": { "c": run.p_c[p], "wx": run.p_x[p], "wy": run.p_y[p], "map": run.p_map[p] }, "lvl": lv.get(i).copied().unwrap_or(60.0), "lvlAfter": lv.get(i + 1).copied().unwrap_or(60.0), "file": "", "line": i });
		if s.kind == K_TASK {
			let ti = s.task as u32 - run.q_task0[q];
			let wq = &world.quests[rules.open[&run.q_id[q]]];
			if let Some(o) = wq.objs.iter().find(|o| o.task == Some(ti)) {
				g["oi"] = json!(o.oi + 1);
			}
		}
		out.push(g);
	}
	out
}

/// A step in plain words.
fn step_words(world: &World, rules: &Rules, model: &Model, s: crate::Step) -> String {
	let run = &model.run;
	let title = |q: u32| world.quests[rules.open[&run.q_id[q as usize]]].title.clone();
	match s.kind {
		K_ACCEPT => format!("take {}", title(s.q)),
		K_TASK => format!("do {} (objective)", title(s.q)),
		K_TURNIN => format!("hand in {}", title(s.q)),
		K_TRAIN => "train".to_string(),
		K_RIDE => format!("learn to ride (trainer {})", s.task),
		_ => format!("grind to {}", s.q),
	}
}

/// The edit-budget descent as JSON: hours after each edit, edits for 50/75/90 % of the gain,
/// the knee, whether the cap stopped it, and each edit (up to `k`, the ones the order keeps, then
/// the rest) in plain words.
pub(crate) fn edits_json(world: &World, rules: &Rules, model: &Model, d: &crate::search::edits::Descent, k: usize) -> Value {
	use crate::search::edits::{edits_for, knee, Mv};
	let run = &model.run;
	let zone = |pt: u32| world.zones.get(&run.p_map[pt as usize]).cloned().unwrap_or_else(|| format!("map {}", run.p_map[pt as usize]));
	let words = |s: crate::Step| step_words(world, rules, model, s);
	let list: Vec<Value> = d
        .edits
        .iter()
        .enumerate()
        .map(|(n, e)| {
            let o = &e.before;
            let (after, _, _) = e.mv.apply(o).expect("edit applies");
            let anchor = |j: usize| if j == 0 { "the start".to_string() } else { format!("'{}'", words(after.steps[j - 1])) };
            let (kind, text) = match &e.mv {
                Mv::Move { s, e: end, to, kind } => {
                    let what = if *kind == crate::search::edits::STAY_LATER {
                        format!("the zone stay ({} steps)", end - s + 1)
                    } else if s == end {
                        words(o.steps[*s])
                    } else {
                        format!("the {} steps at this place ({})", end - s + 1, o.steps[*s..=*end].iter().map(|&x| words(x)).collect::<Vec<_>>().join("; "))
                    };
                    let how = match *kind {
                        "fold" => "on the earlier visit, folding a return",
                        "fold later" => "on the later visit, folding a return",
                        "ride" => "on the first visit to the riding trainer at the mount level or above",
                        crate::search::edits::STAY_LATER => "after the zone stays that come next, nearer its quests' level",
                        crate::search::edits::GATE_LATER => "just before the first accept it gates, after the hand-ins before it",
                        _ => "within the zone stay",
                    };
                    let shift = *to as i64 - *s as i64;
                    let pt = o.steps[*s].pt;
                    (*kind, format!("{}, L{:.1}: {} right after {} ({}; {} steps {})", zone(pt), e.lv[*s], what, anchor(*to), how, shift.unsigned_abs(), if shift < 0 { "earlier" } else { "later" }))
                }
                Mv::Insert { q, at } => {
                    let acc = at[0].0;
                    let last = after.steps.iter().rposition(|x| x.q == *q && x.kind == K_TURNIN).unwrap_or(acc);
                    let qi = *q as usize;
                    (
                        "insert",
                        format!(
                            "{}, L{:.1}: add {} (level {}, giver passed by): take it right after {}, hand it in right after {}",
                            zone(at[0].1.pt),
                            e.lv.get(acc).copied().unwrap_or(60.0),
                            world.quests[rules.open[&run.q_id[qi]]].title,
                            run.q_level[qi],
                            anchor(acc),
                            anchor(last)
                        ),
                    )
                }
                Mv::Join { .. } => ("join", join_words(world, rules, model, o, &e.lv, &e.mv)),
                Mv::Drop { q } => {
                    let i = o.steps.iter().position(|x| x.q == *q && x.kind == K_ACCEPT).unwrap_or(0);
                    let qi = *q as usize;
                    ("drop", format!("{}, L{:.1}: drop {} (level {}): its trip costs more than its XP", zone(o.steps[i].pt), e.lv[i], world.quests[rules.open[&run.q_id[qi]]].title, run.q_level[qi]))
                }
                Mv::DropStep { i } => ("drop grind", format!("L{:.1}: drop the grind to level {}", e.lv[*i], o.steps[*i].q)),
                Mv::Reorder { .. } => ("hub loop", loop_words(world, rules, model, o, &e.lv, &e.mv)),
                Mv::Seq { kind, .. } => (*kind, seq_words(world, rules, model, o, &e.lv, &e.mv)),
            };
            let sj = |x: crate::Step| crate::ledger::step_json(run, x);
            let (steps, from, to, q): (Vec<Value>, Value, Value, Value) = match &e.mv {
                Mv::Move { s, e: end, to, .. } => (o.steps[*s..=*end].iter().map(|&x| sj(x)).collect(), json!(s), json!(to), if matches!(o.steps[*s].kind, K_ACCEPT | K_TASK | K_TURNIN) { json!(run.q_id[o.steps[*s].q as usize]) } else { Value::Null }),
                Mv::Insert { q, at } => (at.iter().map(|x| sj(x.1)).collect(), Value::Null, json!(at[0].0), json!(run.q_id[*q as usize])),
                Mv::Join { q, at } => (at.iter().map(|x| sj(x.1)).collect(), json!(o.steps.iter().position(|x| x.q == *q && x.kind == K_ACCEPT)), json!(at[0].0), json!(run.q_id[*q as usize])),
                Mv::Drop { q } => (o.steps.iter().filter(|x| x.q == *q && matches!(x.kind, K_ACCEPT | K_TASK | K_TURNIN)).map(|&x| sj(x)).collect(), Value::Null, Value::Null, json!(run.q_id[*q as usize])),
                Mv::DropStep { i } => (Vec::new(), json!(i), Value::Null, Value::Null),
                Mv::Reorder { s, perm } => (after.steps[*s..*s + perm.len()].iter().map(|&x| sj(x)).collect(), json!(s), json!(s), Value::Null),
                Mv::Seq { .. } => {
                    let qs = seq_quests(&e.mv, o);
                    let of = |x: &Order| x.steps.iter().filter(|s| qs.contains(&s.q) && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN)).map(|&s| sj(s)).collect::<Vec<_>>();
                    let (_, a, _) = e.mv.apply(o).expect("edit applies");
                    (if after.len() < o.len() { of(o) } else { of(&after) }, Value::Null, json!(a), qs.first().map_or(Value::Null, |&q| json!(run.q_id[q as usize])))
                }
            };
            json!({ "n": n + 1, "kept": n < k, "kind": kind, "text": text, "savedMin": (e.saved / 60.0 * 100.0).round() / 100.0, "hours": (e.hours * 1000.0).round() / 1000.0, "steps": steps, "from": from, "to": to, "q": q })
        })
        .collect();
	json!({
		"startHours": d.start_hours,
		"endHours": d.edits.last().map_or(d.start_hours, |e| e.hours),
		"curve": d.edits.iter().map(|e| (e.hours * 1000.0).round() / 1000.0).collect::<Vec<_>>(),
		"for50": edits_for(d, 0.5), "for75": edits_for(d, 0.75), "for90": edits_for(d, 0.9),
		"knee": knee(d),
		"budget": k,
		"capped": d.capped,
		"list": list,
	})
}

/// Mob kinds above which an item objective counts as carried in the bags (run.task_bag).
pub const BAG_SOURCES: usize = 20;

/// Per run task: every objective worked there is an item dropped by more than BAG_SOURCES kinds
/// of mob (cloth: v1 hands the donations in from the bags).
fn bag_tasks(world: &World, rules: &Rules, run: &crate::run::Run) -> Vec<bool> {
	let mut v = vec![false; run.task_pt.len()];
	for qi in 0..run.n_quests() {
		let Some(&wi) = rules.open.get(&run.q_id[qi]) else { continue };
		let q = &world.quests[wi];
		for t in run.q_task0[qi]..run.q_task1[qi] {
			let local = t - run.q_task0[qi];
			let objs: Vec<_> = q.objs.iter().filter(|o| o.task == Some(local)).collect();
			v[t as usize] = !objs.is_empty() && objs.iter().all(|o| o.kind == "item" && o.chances.len() > BAG_SOURCES);
		}
	}
	v
}

/// Percent: a quest-starting item that only drops from mobs, each at less than this (or an unknown
/// chance), is a rare start (the writer writes it optional: forge-writer RARE_START_PCT).
pub const RARE_START_PCT: f64 = 5.0;
/// Chance per kill taken for a rare start's source with no recorded chance: low, not zero.
pub const UNKNOWN_START_CHANCE: f64 = 0.01;

/// The quests started by a rare drop (RARE_START_PCT), with each source mob's chance per kill:
/// valued at expected value from the route's own kills of those mobs (eval), never farmed for.
pub fn rare_starts(data: &forge_world::GameData) -> crate::run::RareStarts {
	let mut out = Vec::new();
	for (&id, q) in &data.quests {
		if !q.start.npc.is_empty() || !q.start.object.is_empty() || q.start.item.is_empty() {
			continue;
		}
		let mut srcs: Vec<(u32, f64)> = Vec::new();
		let mut rare = true;
		for &i in &q.start.item {
			let Some(it) = u32::try_from(i).ok().and_then(|i| data.items.get(&i)) else {
				rare = false;
				break;
			};
			let d = it.drops.as_ref();
			let npc = d.map(|d| &d.npc);
			let objects = d.is_some_and(|d| !d.object.is_empty());
			// (A rare mob's drop is as rare as the mob: Gruff Swiftbite's 86 % of the Gold Pickup
			// Schedule; insertable::RARE_RANK.)
			let rare_mob = |m: &u32| data.npcs.get(m).and_then(|n| n.rank).is_some_and(|r| r == crate::insertable::RARE_RANK || r == crate::insertable::RARE_ELITE_RANK);
			if objects || it.vendors.as_ref().is_some_and(|v| !v.is_empty()) || npc.is_none_or(|n| n.is_empty()) || npc.is_some_and(|n| n.iter().any(|(m, c)| !rare_mob(m) && c.is_some_and(|c| c >= RARE_START_PCT))) {
				rare = false;
				break;
			}
			for (&m, c) in npc.into_iter().flatten() {
				srcs.push((m, c.filter(|c| *c > 0.0).map_or(UNKNOWN_START_CHANCE, |c| c / 100.0)));
			}
		}
		if rare {
			out.push((id, srcs));
		}
	}
	out
}

/// Quests in the log a route may hold at once: the game's 40 less room for class quests.
pub const LOG_BOUND: u32 = 38;

/// Yards from a guide's sethome / getfp line to the inn / flight master it names.
pub const PLAN_YD: f64 = 300.0;

/// v1's travel plan: each hearth, sethome and getfp goal of the seed's guides, keyed by the
/// first step of the order after it (the step the player does next).
pub fn travel_plan(run: &crate::run::Run, seed: &Order, goals: &[Goal]) -> crate::run::TravelPlan {
	let mut plan = crate::run::TravelPlan::default();
	let next_key = |gi: usize| {
		let k = seed.origin.iter().position(|&o| o > gi as i64)?;
		let s = seed.steps[k..].iter().find(|s| run.step_key(s.kind, s.q, s.task).is_some())?;
		run.step_key(s.kind, s.q, s.task)
	};
	let near = |w: &crate::chain::GoalW, c: &[i64], x: &[f64], y: &[f64], i: usize| c[i] == w.c && (x[i] - w.wx).hypot(y[i] - w.wy) <= PLAN_YD;
	for g in goals {
		match g.t.as_str() {
			"hearth" => {
				if let Some(k) = next_key(g.i) {
					plan.hearth.insert(k);
				}
			}
			"sethome" => {
				let (Some(w), Some(k)) = (g.w.as_ref(), next_key(g.i)) else { continue };
				let inn = (0..run.inn_pt.len()).filter(|&i| near(w, &run.p_c, &run.p_x, &run.p_y, run.inn_pt[i] as usize)).min_by(|&a, &b| {
					let d = |i: usize| (run.p_x[run.inn_pt[i] as usize] - w.wx).hypot(run.p_y[run.inn_pt[i] as usize] - w.wy);
					d(a).total_cmp(&d(b))
				});
				if let Some(i) = inn {
					plan.bind.insert(k, i as u32);
				}
			}
			"getfp" => {
				let (Some(w), Some(k)) = (g.w.as_ref(), next_key(g.i)) else { continue };
				if let Some(n) = (0..run.n_nodes).filter(|&n| run.fp_bit[n] >= 0 && near(w, &run.node_c, &run.node_x, &run.node_y, n)).min_by(|&a, &b| {
					let d = |n: usize| (run.node_x[n] - w.wx).hypot(run.node_y[n] - w.wy);
					d(a).total_cmp(&d(b))
				}) {
					plan.fp.entry(k).or_default().push(n as u32);
				}
			}
			_ => {}
		}
	}
	plan
}

/// v1's hearth lines an order plays while the hearthstone cools down (F58, #576: hearths at
/// least `hearthCooldown` apart), out of the model's travel plan: the evaluator never casts on
/// cooldown (the route travels on there), so the line was never the route's. Without them the
/// order meets no plan hearth on cooldown, and the search's guard (a kept edit never adds one)
/// keeps every searched order at none. A line carried over steps that do nothing is decided at
/// the step that consumes it. Replays the order once; returns the keys taken out.
pub fn drop_cooling_hearths(model: &mut Model, walks: &dyn Walks, steps: &[crate::Step]) -> Vec<crate::run::StepKey> {
	let Some(plan) = model.run.plan.clone() else { return Vec::new() };
	let mut cut: Vec<crate::run::StepKey> = Vec::new();
	{
		let run = &model.run;
		let mut ev = model.evaluator(walks);
		ev.reset();
		let mut pending: Vec<crate::run::StepKey> = Vec::new();
		for i in 0..steps.len() {
			if ev.s.finished {
				break;
			}
			let s = steps[i];
			if s.kind == K_GRIND {
				ev.step_in(steps, i);
				continue;
			}
			if let Some(k) = run.step_key(s.kind, s.q, s.task).filter(|k| plan.hearth.contains(k)) {
				pending.push(k);
			}
			let before = ev.s.plan_cooldown;
			if ev.step_in(steps, i) {
				if ev.s.plan_cooldown > before {
					cut.append(&mut pending);
				} else {
					pending.clear();
				}
			}
		}
	}
	if !cut.is_empty() {
		let mut p = (*plan).clone();
		for k in &cut {
			p.hearth.remove(k);
		}
		model.run.plan = Some(std::sync::Arc::new(p));
	}
	cut
}

/// A pickup in plain words.
/// A join edit (edits::joins) in words: where the quest is taken now and was, its work, its hand-in.
fn join_words(world: &World, rules: &Rules, model: &Model, before: &Order, lv: &[f64], mv: &crate::search::edits::Mv) -> String {
	let run = &model.run;
	let crate::search::edits::Mv::Join { q, at } = mv else { return String::new() };
	let (after, _, _) = mv.apply(before).expect("join applies");
	let words = |s: crate::Step| step_words(world, rules, model, s);
	let anchor = |j: usize| if j == 0 { "the start".to_string() } else { format!("'{}'", words(after.steps[j - 1])) };
	let qi = *q as usize;
	let acc = at[0].0;
	let was = before.steps.iter().position(|x| x.q == *q && x.kind == K_ACCEPT).unwrap_or(0);
	let work: Vec<String> = at.iter().filter(|x| x.1.kind == K_TASK).map(|x| anchor(x.0)).collect();
	let last = after.steps.iter().rposition(|x| x.q == *q && x.kind == K_TURNIN).unwrap_or(acc);
	let zone = world.zones.get(&run.p_map[at[0].1.pt as usize]).cloned().unwrap_or_default();
	format!(
		"{zone}, L{:.1}: take {} (level {}) on this earlier visit to its giver, right after {} (was taken at L{:.1}); its work right after {}; hand it in right after {}",
		lv.get(acc).copied().unwrap_or(60.0),
		world.quests[rules.open[&run.q_id[qi]]].title,
		run.q_level[qi],
		anchor(acc),
		lv.get(was).copied().unwrap_or(60.0),
		if work.is_empty() { "its place".to_string() } else { work.join(", ") },
		anchor(last)
	)
}

/// Joins kept by a pass (`kind` `hub pickup`, `bag tie`) as edit list rows, inserted before the first
/// row not kept, the rows numbered again; `key` counts them.
pub(crate) fn hub_pickup_rows(world: &World, rules: &Rules, model: &Model, edits_doc: &mut Value, picks: &[crate::search::passby::HubPickup], kind: &str, key: &str) {
	if edits_doc.is_null() {
		*edits_doc = json!({ "list": [] });
	}
	if let Some(list) = edits_doc["list"].as_array_mut() {
		let at = list.iter().position(|x| x["kept"] != json!(true)).unwrap_or(list.len());
		for (j, pk) in picks.iter().enumerate() {
			let crate::search::edits::Mv::Join { q, at: places } = &pk.mv else { continue };
			let steps: Vec<Value> = places.iter().map(|x| crate::ledger::step_json(&model.run, x.1)).collect();
			list.insert(
				at + j,
				json!({ "kept": true, "kind": kind, "text": join_words(world, rules, model, &pk.before, &pk.lv, &pk.mv), "savedMin": (-pk.added / 60.0 * 100.0).round() / 100.0, "hours": (pk.hours * 1000.0).round() / 1000.0, "q": model.run.q_id[*q as usize], "steps": steps, "to": places[0].0 }),
			);
		}
		for (n, x) in list.iter_mut().enumerate() {
			x["n"] = json!(n + 1);
		}
	}
	edits_doc[key] = json!(picks.len());
}

/// The camp gather pass's kept moves as edit list rows (kind `camp gather`), inserted before the
/// first row not kept, the rows numbered again.
pub(crate) fn camp_gather_rows(world: &World, rules: &Rules, model: &Model, edits_doc: &mut Value, picks: &[crate::search::passby::HubPickup]) {
	if edits_doc.is_null() {
		*edits_doc = json!({ "list": [] });
	}
	let run = &model.run;
	let words = |s: crate::Step| step_words(world, rules, model, s);
	if let Some(list) = edits_doc["list"].as_array_mut() {
		let at = list.iter().position(|x| x["kept"] != json!(true)).unwrap_or(list.len());
		for (j, pk) in picks.iter().enumerate() {
			let crate::search::edits::Mv::Move { s, to, .. } = pk.mv else { continue };
			let o = &pk.before;
			let (after, _, _) = pk.mv.apply(o).expect("gather applies");
			let moved = o.steps[s];
			let next_to = if to > 0 { words(after.steps[to - 1]) } else { "the start".into() };
			let zone = world.zones.get(&run.p_map[moved.pt as usize]).cloned().unwrap_or_default();
			let text = format!("{zone}, L{:.1}: {} right after '{}': the camp worked in one go, not in two halves around the steps between", pk.lv.get(s).copied().unwrap_or(60.0), words(moved), next_to);
			list.insert(
				at + j,
				json!({ "kept": true, "kind": "camp gather", "text": text, "savedMin": (-pk.added / 60.0 * 100.0).round() / 100.0, "hours": (pk.hours * 1000.0).round() / 1000.0, "q": run.q_id[moved.q as usize], "steps": [crate::ledger::step_json(run, moved)], "from": s, "to": to }),
			);
		}
		for (n, x) in list.iter_mut().enumerate() {
			x["n"] = json!(n + 1);
		}
	}
	edits_doc["campGathers"] = json!(picks.len());
}

/// The quests an edit made of edits in turn adds, drops or (a stay split, its moves' indices into
/// `before`) moves.
fn seq_quests(mv: &crate::search::edits::Mv, before: &Order) -> Vec<u32> {
	use crate::search::edits::{Mv, STAY_SPLIT};
	let Mv::Seq { mvs, kind } = mv else { return Vec::new() };
	if *kind == crate::search::edits::HUB_REVISIT {
		return crate::search::edits::revisit_quests(mv);
	}
	let mut out: Vec<u32> = Vec::new();
	for m in mvs {
		let q = match m {
			Mv::Insert { q, .. } | Mv::Drop { q } => Some(*q),
			Mv::Move { s, .. } if *kind == STAY_SPLIT => before.steps.get(*s).filter(|x| matches!(x.kind, K_ACCEPT | K_TASK | K_TURNIN)).map(|x| x.q),
			_ => None,
		};
		if let Some(q) = q.filter(|q| !out.contains(q)) {
			out.push(q);
		}
	}
	out
}

/// A chain insert, a zone block or a trip dropped, in plain words.
fn seq_words(world: &World, rules: &Rules, model: &Model, before: &Order, lv: &[f64], mv: &crate::search::edits::Mv) -> String {
	let crate::search::edits::Mv::Seq { kind, .. } = mv else { return String::new() };
	let run = &model.run;
	let qs = seq_quests(mv, before);
	let (after, a, _) = mv.apply(before).expect("edit applies");
	let title = |q: u32| world.quests[rules.open[&run.q_id[q as usize]]].title.clone();
	let pt = after.steps.get(a).or(before.steps.get(a)).map_or(run.start_pt, |s| if s.kind == crate::run::K_GRIND { run.start_pt } else { s.pt });
	let zone = world.zones.get(&run.p_map[pt as usize]).cloned().unwrap_or_default();
	let list = qs.iter().map(|&q| format!("{} ({})", title(q), run.q_level[q as usize])).collect::<Vec<_>>().join(", ");
	let what = match *kind {
		"chain insert" => "add a quest with the quests it opens, valued together",
		"zone block" => "add the zone's open chains as one visit",
		"drop trip" => "drop the trip off the continent for quests well under the character",
		"defer hard work" => "defer early hard work to where questing reaches its level (the grind before it priced as a cost)",
		"stay on continent" => "stay on the continent: the trip off it for quests well under the character taken out (the zone's open chains in its place, where it adds them)",
		crate::search::edits::STAY_SPLIT => "do a later zone stay's quests that are far under the character there here instead, on level, as their own visit",
		crate::search::edits::HUB_REVISIT => "go back to the hub at the level its quests open, for them and the quests they open",
		_ => kind,
	};
	format!("{zone}, L{:.1}: {what}: {list}", lv.get(a).copied().unwrap_or(60.0))
}

/// A hub loop in plain words: the visit's stops in their new order.
fn loop_words(world: &World, rules: &Rules, model: &Model, before: &Order, lv: &[f64], mv: &crate::search::edits::Mv) -> String {
	let crate::search::edits::Mv::Reorder { s, perm } = mv else { return String::new() };
	let (after, _, _) = mv.apply(before).expect("loop applies");
	let zone = world.zones.get(&model.run.p_map[before.steps[*s].pt as usize]).cloned().unwrap_or_default();
	let stops: Vec<String> = after.steps[*s..*s + perm.len()].iter().map(|&x| step_words(world, rules, model, x)).collect();
	format!("{zone}, L{:.1}: the hub's stops in the order of the shortest walk through them: {}", lv.get(*s).copied().unwrap_or(60.0), stops.join("; "))
}

/// The hub passes' kept moves as edit list rows (kinds `hub batch`, `hub sweep`, `on the way`,
/// `hub loop`, `written check`, `hub batch undone`), inserted before the first row not kept, the
/// rows numbered again; `key` counts them.
pub(crate) fn hub_sweep_rows(world: &World, rules: &Rules, model: &Model, edits_doc: &mut Value, picks: &[crate::search::passby::HubPickup], key: &str) {
	use crate::search::edits::Mv;
	if edits_doc.is_null() {
		*edits_doc = json!({ "list": [] });
	}
	let run = &model.run;
	let words = |s: crate::Step| step_words(world, rules, model, s);
	if let Some(list) = edits_doc["list"].as_array_mut() {
		let at = list.iter().position(|x| x["kept"] != json!(true)).unwrap_or(list.len());
		for (j, pk) in picks.iter().enumerate() {
			let o = &pk.before;
			let (after, _, _) = pk.mv.apply(o).expect("sweep applies");
			let row = match &pk.mv {
				Mv::Move { s, e, to, kind } => {
					let moved = o.steps[*s];
					let next_to = if *to > 0 { words(after.steps[to - 1]) } else { "the start".into() };
					let zone = world.zones.get(&run.p_map[moved.pt as usize]).cloned().unwrap_or_default();
					let why = match *kind {
						"on the way" => "the walk passes its NPC while it is ready",
						"hub batch" => "a return to the hub for this alone, folded into the next visit there",
						"written check" => "the written guide walks past its NPC while it is ready (the check on the written guides)",
						"hub batch undone" => "back where it was: the written guide walked past it after the hub batch",
						"train at the hub" => "out of the field work it split: trained at the hub, before or after the stretch",
						_ => "ready at this hub visit, not left for a return",
					};
					let shift = *to as i64 - *s as i64;
					let what = o.steps[*s..=*e].iter().map(|&x| words(x)).collect::<Vec<_>>().join("; ");
					let text = format!("{zone}, L{:.1}: {what} right after '{}': {why} ({} steps {})", pk.lv.get(*s).copied().unwrap_or(60.0), next_to, shift.unsigned_abs(), if shift < 0 { "earlier" } else { "later" });
					json!({ "kept": true, "kind": kind, "text": text, "savedMin": (-pk.added / 60.0 * 100.0).round() / 100.0, "hours": (pk.hours * 1000.0).round() / 1000.0, "q": run.q_id[moved.q as usize], "steps": o.steps[*s..=*e].iter().map(|&x| crate::ledger::step_json(run, x)).collect::<Vec<_>>(), "from": s, "to": to })
				}
				Mv::Reorder { s, perm } => {
					let steps: Vec<Value> = after.steps[*s..*s + perm.len()].iter().map(|&x| crate::ledger::step_json(run, x)).collect();
					json!({ "kept": true, "kind": "hub loop", "text": loop_words(world, rules, model, o, &pk.lv, &pk.mv), "savedMin": (-pk.added / 60.0 * 100.0).round() / 100.0, "hours": (pk.hours * 1000.0).round() / 1000.0, "q": Value::Null, "steps": steps, "from": s, "to": s })
				}
				Mv::Seq { kind, mvs } if *kind == "grind top-up" => {
					let targets: Vec<String> = mvs
						.iter()
						.rev()
						.filter_map(|x| if let Mv::Insert { at, .. } = x { at.first().map(|a| format!("{:.2}", a.1.q as f64 + a.1.task.max(0) as f64 / crate::xp::LEVEL_XP[(a.1.q as usize).min(59)].max(1.0))) } else { None })
						.collect();
					let (_, a, _) = pk.mv.apply(o).expect("top-up applies");
					let zone = o.steps[..a.min(o.len())].iter().rev().find(|s| s.kind != crate::run::K_GRIND).map(|s| world.zones.get(&run.p_map[s.pt as usize]).cloned().unwrap_or_default()).unwrap_or_default();
					let text = format!("{zone}, L{:.1}: grind in pieces at the camps of the zone stay, to {} (at most {:.0} minutes each, or the model's own grind made a checkpoint)", pk.lv.get(a).copied().unwrap_or(60.0), targets.join(", "), crate::route::GRIND_BLOCK_MIN);
					json!({ "kept": true, "kind": kind, "text": text, "savedMin": (-pk.added / 60.0 * 100.0).round() / 100.0, "hours": (pk.hours * 1000.0).round() / 1000.0, "q": Value::Null, "steps": Vec::<Value>::new(), "from": a, "to": a })
				}
				Mv::Seq { kind, .. } => {
					let qs = seq_quests(&pk.mv, o);
					// (An edit that adds quests: their steps in the order after it.)
					let after = pk.mv.apply(o).map_or_else(|| o.clone(), |x| x.0);
					let src = if after.len() > o.len() { &after } else { o };
					let steps: Vec<Value> = src.steps.iter().filter(|s| qs.contains(&s.q) && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN)).map(|&s| crate::ledger::step_json(run, s)).collect();
					json!({ "kept": true, "kind": kind, "text": seq_words(world, rules, model, o, &pk.lv, &pk.mv), "savedMin": (-pk.added / 60.0 * 100.0).round() / 100.0, "hours": (pk.hours * 1000.0).round() / 1000.0, "q": qs.first().map_or(Value::Null, |&q| json!(run.q_id[q as usize])), "steps": steps, "from": Value::Null, "to": Value::Null })
				}
				_ => continue,
			};
			list.insert(at + j, row);
		}
		for (n, x) in list.iter_mut().enumerate() {
			x["n"] = json!(n + 1);
		}
	}
	edits_doc[key] = json!(picks.len());
}

fn pickup_words(world: &World, rules: &Rules, model: &Model, pk: &crate::search::passby::Pickup) -> String {
	let run = &model.run;
	let (after, _, _) = pk.mv.apply(&pk.before).expect("pickup applies");
	let words = |s: crate::Step| step_words(world, rules, model, s);
	let q = pk.v.q;
	let acc = after.steps.iter().position(|x| x.q == q && x.kind == K_ACCEPT).unwrap_or(0);
	let tin = after.steps.iter().rposition(|x| x.q == q && x.kind == K_TURNIN).unwrap_or(acc);
	let anchor = |j: usize| if j == 0 { "the start".to_string() } else { format!("'{}'", words(after.steps[j - 1])) };
	let zone = world.zones.get(&run.p_map[after.steps[acc].pt as usize]).cloned().unwrap_or_default();
	let v = &pk.v;
	let chain = if v.chain.len() > 1 { format!(" with the quests it opens ({}), valued together", v.chain[1..].iter().map(|id| world.quests[rules.open[id]].title.clone()).collect::<Vec<_>>().join(", ")) } else { String::new() };
	format!(
        "{zone}, L{:.1}: add {}{chain} (level {}; its giver is passed here): {:.0} XP for {:.1} min of detour and work ({:.0} XP/min against the route's {:.0} at this level{}); take it right after {}, hand it in right after {}",
        v.lvl,
        world.quests[rules.open[&v.id]].title,
        run.q_level[q as usize],
        v.xp,
        v.cost_sec / 60.0,
        v.rate.min(99999.0),
        v.local,
        if v.detour_sec < crate::search::passby::DETOUR_CHEAP_SEC { format!(", detour {:.0} s", v.detour_sec) } else { String::new() },
        anchor(acc),
        anchor(tin)
    )
}

/// Passed-by verdicts and long trips as JSON (counts, reasons, lists).
fn passby_json(world: &World, rules: &Rules, model: &Model, vs: &[crate::search::passby::Passed], trips: &[crate::search::passby::Trip]) -> Value {
	let title = |id: u32| rules.open.get(&id).map(|&i| world.quests[i].title.clone()).unwrap_or_default();
	let mut reasons: std::collections::BTreeMap<String, u32> = Default::default();
	for v in vs.iter().filter(|v| !v.worthwhile) {
		*reasons.entry(v.reason.clone()).or_default() += 1;
	}
	let _ = model;
	json!({
		"worthwhileMissed": vs.iter().filter(|v| v.worthwhile).count(),
		"rightlySkipped": vs.iter().filter(|v| !v.worthwhile).count(),
		"reasons": reasons,
		"worthwhile": vs.iter().filter(|v| v.worthwhile).map(|v| json!({ "q": v.id, "title": title(v.id), "lvl": (v.lvl * 10.0).round() / 10.0, "xp": v.xp.round(), "costMin": (v.cost_sec / 6.0).round() / 10.0, "rate": v.rate.min(99999.0).round(), "local": v.local.round() })).collect::<Vec<_>>(),
		"skipped": vs.iter().filter(|v| !v.worthwhile).map(|v| json!({ "q": v.id, "title": title(v.id), "lvl": (v.lvl * 10.0).round() / 10.0, "why": v.reason })).collect::<Vec<_>>(),
		"longTrips": trips.len(),
		"longTripList": trips.iter().map(|t| json!({ "q": t.id, "title": title(t.id), "lvl": (t.lvl * 10.0).round() / 10.0, "min": (t.sec / 6.0).round() / 10.0, "xp": t.xp.round(), "rate": t.rate.round(), "local": t.local.round() })).collect::<Vec<_>>(),
	})
}
