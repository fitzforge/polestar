//! One start's route: compile the character under a profile, build the seed from v1's chain,
//! search, and report hours and the difference from v1.

use crate::chain::Goal;
use crate::guards::{GuardCounts, GuardData};
use crate::insertable::Insertable;
use crate::order::{deliberate_pairs, diff, seed_order, Diff, Order, INSERTED, TRAIN_STOP};
use crate::profile::{town_points, Profile};
use crate::run::{compile_run, K_ACCEPT, K_GRIND, K_TASK, K_TRAIN, K_TURNIN};
use crate::search::{clean, evaluate, pool, runs, search, CtxSpec, Guard, GuardMode, Problem, SearchOpts, Stats, MOVES, MOVE_NAMES};
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
	let mut run = compile_run(world, &rules, race, None, &towns)?;
	run.towns = towns.iter().filter_map(|&p| run.run_pt(p)).collect();
	run.valley_towns = own_valley.iter().filter_map(|&p| run.run_pt(p)).collect();
	if profile.train_stops {
		run.task_bag = bag_tasks(world, &rules, &run);
	}
	run.plan = profile.plan.clone();
	Ok((Model::new(run, &profile.params(base), walks), rules))
}

/// Hours to 30 and 60 and the counters of an order's replay.
pub fn summary(ev: &mut Evaluator, o: &Order) -> Value {
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
		"flights": s.flights,
		"trains": s.trains,
		"logPeak": s.log_peak,
		"noops": s.noops,
		"late": s.late,
		"planHearthsOnCooldown": s.plan_cooldown,
		"logSkipped": s.log_skipped,
		"logAbandoned": s.log_abandoned,
		"alongKills": (s.along_kills * 10.0).round() / 10.0,
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
	let (model0, _) = model_for(world, race, profile, base, walks)?;
	let mut ev0 = model0.evaluator(walks);
	let mut seed = seed_order(&mut ev0, events, profile.train_stops);
	drop(ev0);
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
	seed = crate::order::keep_pairs(&seed, &ovr.pairs);
	// Route profiles travel as v1's guide does: hearths, binds and flight paths at v1's lines.
	let profile = if profile.train_stops { Profile { plan: Some(std::sync::Arc::new(travel_plan(&model0.run, &seed, goals))), ..profile.clone() } } else { profile.clone() };
	let (model, rules) = model_for(world, race, &profile, base, walks)?;
	let mut pairs = deliberate_pairs(&model.run);
	pairs.extend(ovr.pairs.iter().copied());
	// A pair v1's own order breaks can't be a v1 deliberate order for this start (it would
	// also refuse every move): left out, and named (in the route's `feasibility` notes).
	let mut feas_log = Vec::new();
	let kind_name = |k: u8| match k {
		K_ACCEPT => "accept",
		K_TASK => "task",
		_ => "turnin",
	};
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
			pairs.push(crate::order::Pair { ka: k, qa: a, kb: K_ACCEPT, qb: q });
		}
	}
	pool.retain(|q| !ovr.skip.contains(q));
	Ok(Prepared { model, rules, profile, seed, pairs, pool, ins, feas, feas_rules, guard, gdata, guard_v1, ovr, v1_seed })
}

/// Improve one start's v1 order: search under `sets.search` draws (or the base), report under
/// the base, the gate's model, the other fidelity model, and the held-out draws.
pub fn improve(world: &World, walks: &dyn Walks, sets: &ParamSets, race: &str, events: &[Event], goals: &[Goal], profile: &Profile, opts: &SearchOpts, ex: Extras) -> Result<RouteResult, String> {
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
	let mut edits_doc = Value::Null;
	let mut refused: rustc_hash::FxHashMap<u32, String> = Default::default();
	let out = match opts.edits {
		Some(max) => {
			let mut log = |k: usize, h: f64, kind: &str| eprintln!("edit {k}: {kind} -> {h:.3} h");
			let dsc = crate::search::edits::descend(&problem, seed, max, opts.members, false, &mut log);
			let k = opts.budget.unwrap_or_else(|| crate::search::edits::knee(&dsc)).min(dsc.edits.len());
			edits_doc = edits_json(world, rules, model, &dsc, k);
			let mut best = if k == 0 { seed.clone() } else { dsc.orders[k - 1].clone() };
			// The pickup pass: worthwhile passed-by quests inserted where they are passed.
			let gd = problem.guard.as_ref().map(|g| &g.data).or(gdata);
			if let (true, Some(g)) = (profile.train_stops, gd) {
				let mut m = crate::search::Member::new(&problem, best.clone(), &runs(&problem, &best), 1);
				let mut plog = |s: &str| eprintln!("{s}");
				let (picks, refused_now) = crate::search::passby::pickup(&problem, &mut m, ins, g, &mut plog);
				refused = refused_now;
				if let Some(list) = edits_doc["list"].as_array_mut() {
					let at = list.iter().position(|x| x["kept"] != json!(true)).unwrap_or(list.len());
					for (j, pk) in picks.iter().enumerate() {
						let steps: Vec<Value> = match &pk.mv {
							crate::search::edits::Mv::Insert { at, .. } => at.iter().map(|x| crate::ledger::step_json(&model.run, x.1)).collect(),
							_ => Vec::new(),
						};
						let to = match &pk.mv {
							crate::search::edits::Mv::Insert { at, .. } => json!(at[0].0),
							_ => Value::Null,
						};
						list.insert(at + j, json!({ "n": k + j + 1, "kept": true, "kind": "pickup", "text": pickup_words(world, rules, model, pk), "savedMin": (-pk.added / 60.0 * 100.0).round() / 100.0, "hours": (pk.hours * 1000.0).round() / 1000.0, "q": pk.v.id, "steps": steps, "to": to }));
					}
					for (n, x) in list.iter_mut().enumerate() {
						x["n"] = json!(n + 1);
					}
				}
				edits_doc["pickups"] = json!(picks.len());
				best = m.order.clone();
			}
			crate::search::Outcome { best, totals: Vec::new(), stats: Default::default(), seconds: dsc.seconds }
		}
		None => search(&problem, seed, opts),
	};
	let fin = Finish { world, walks, sets, race, goals, ex: &ex, profile, prep: &prep, problem: &problem };
	finish(&fin, out.best, edits_doc, refused, out.stats, out.seconds)
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
	let seed_hours = summary(&mut ev, seed);
	let best_hours = summary(&mut bev, &best);
	// The gate's model: v1's parameters, walks off.
	let gate = Profile::gate();
	let v1p = Params { camps: false, spots: false, ..base.clone() };
	let (gm, _) = model_for(world, race, &gate, &v1p, &NoWalks)?;
	let mut gev = gm.evaluator(&NoWalks);
	let to_gate = |o: &Order| Order { steps: o.steps.iter().copied().filter(|s| s.kind != K_TRAIN).map(|s| remap(model, &gm, s)).collect(), origin: Vec::new() };
	let seed_gate = summary(&mut gev, &to_gate(seed));
	let best_gate = summary(&mut gev, &to_gate(&best));
	// The other fidelity model (camps + spots on when the search had them off, and off when on).
	let on = !base.camps;
	let (om, _) = model_for(world, race, profile, &Params { camps: on, spots: on, ..base.clone() }, walks)?;
	let mut oev = om.evaluator(walks);
	let seed_other = summary(&mut oev, seed);
	let best_other = summary(&mut oev, &best);
	let mut dd = diff(&model.run, seed, &best);
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
	};
	let skips = crate::ledger::skips(&lin);
	let edit_rows = crate::ledger::edit_rows(&edits_doc, ovr, &model.run);
	if !passby.is_null() {
		edits_doc["passby"] = passby;
	}
	Ok(RouteResult {
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
		_ => format!("grind to {}", s.q),
	}
}

/// The edit-budget descent as JSON: hours after each edit, edits for 50/75/90 % of the gain,
/// the knee, and each edit (up to `k`, the ones the order keeps, then the rest) in plain words.
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
                    let what = if s == end { words(o.steps[*s]) } else { format!("the {} steps at this place ({})", end - s + 1, o.steps[*s..=*end].iter().map(|&x| words(x)).collect::<Vec<_>>().join("; ")) };
                    let how = match *kind {
                        "fold" => "on the earlier visit, folding a return",
                        "fold later" => "on the later visit, folding a return",
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
                Mv::Drop { q } => {
                    let i = o.steps.iter().position(|x| x.q == *q && x.kind == K_ACCEPT).unwrap_or(0);
                    let qi = *q as usize;
                    ("drop", format!("{}, L{:.1}: drop {} (level {}): its trip costs more than its XP", zone(o.steps[i].pt), e.lv[i], world.quests[rules.open[&run.q_id[qi]]].title, run.q_level[qi]))
                }
                Mv::DropStep { i } => ("drop grind", format!("L{:.1}: drop the grind to level {}", e.lv[*i], o.steps[*i].q)),
            };
            let sj = |x: crate::Step| crate::ledger::step_json(run, x);
            let (steps, from, to, q): (Vec<Value>, Value, Value, Value) = match &e.mv {
                Mv::Move { s, e: end, to, .. } => (o.steps[*s..=*end].iter().map(|&x| sj(x)).collect(), json!(s), json!(to), if matches!(o.steps[*s].kind, K_ACCEPT | K_TASK | K_TURNIN) { json!(run.q_id[o.steps[*s].q as usize]) } else { Value::Null }),
                Mv::Insert { q, at } => (at.iter().map(|x| sj(x.1)).collect(), Value::Null, json!(at[0].0), json!(run.q_id[*q as usize])),
                Mv::Drop { q } => (o.steps.iter().filter(|x| x.q == *q && matches!(x.kind, K_ACCEPT | K_TASK | K_TURNIN)).map(|&x| sj(x)).collect(), Value::Null, Value::Null, json!(run.q_id[*q as usize])),
                Mv::DropStep { i } => (Vec::new(), json!(i), Value::Null, Value::Null),
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

/// A pickup in plain words.
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
	format!(
        "{zone}, L{:.1}: add {} (level {}; its giver is passed here): {:.0} XP for {:.1} min of detour and work ({:.0} XP/min against the route's {:.0} at this level{}); take it right after {}, hand it in right after {}",
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
