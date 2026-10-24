//! The routes stage of `forge build` as a library call: for each start, v1's chain (its goal
//! stream) improved with an edit budget, written as `<out>/<start>.json` (the order and its
//! numbers), `.skips.json` (the skip ledger), `.edits.json` (the edit ledger), their markdown,
//! and the judge's goal streams. The `forge sim route` CLI is a thin wrapper of `route_one`.
//!
//! A faction with more than one start gets one shared route (shared_faction): each start's own
//! cut split at its join (shared::split_at_join: after horde/02-the-barrens for the Horde, after
//! alliance/02-westfall for the Alliance), then the first start's tail (Orc's, Human's),
//! improved by edits that slow no start (search::edits::descend, no_worse), written per start.

use crate::chain::{events_from, Goal};
use crate::params::draws;
use crate::profile::Profile;
use crate::route::{improve, stats_json, Extras, ParamSets, RouteResult};
use crate::search::{GuardMode, SearchOpts};
use crate::{NoWalks, Params, WalkTable, Walks};
use forge_core::Faction;
use forge_world::World;
use serde_json::{json, Value};
use std::path::{Path, PathBuf};

/// The holdout draws' seed: one set for every route, independent of the search's.
pub const HOLDOUT_SEED: u64 = 0x5eed_b0b0;

/// A faction's world, walks and calibrated parameters (`<dir>/world-<f>.json`,
/// `walks-<f>.bin`, `params.json`).
pub struct Loaded {
	pub world: World,
	pub walks: Box<dyn Walks>,
	pub params_doc: Option<Value>,
}

pub fn load(dir: &Path, faction: Faction, walks_on: bool) -> Result<Loaded, String> {
	let world = crate::load_world(dir, faction)?;
	let walks: Box<dyn Walks> = if walks_on {
		let f = dir.join(format!("walks-{}.bin", faction.lower()));
		let w = WalkTable::load(&f, world.points.len())?;
		if Some(&w.data_hash) != world.data_hash.as_ref() {
			eprintln!("warning: {} was built on world {} (this world {:?})", f.display(), w.data_hash, world.data_hash);
		}
		Box::new(w)
	} else {
		Box::new(NoWalks)
	};
	let params_doc = std::fs::read(dir.join("params.json")).ok().and_then(|b| serde_json::from_slice(&b).ok());
	Ok(Loaded { world, walks, params_doc })
}

/// What the guards, the insert eligibility and the ledgers read beside the world: game data,
/// the judge's atlas, the knowledge base, quest rewards. `root`: a repository-shaped tree
/// (data/forever, data/sources, data/local/kb, data/local/nav4).
pub struct Context {
	pub data: forge_world::GameData,
	pub atlas: forge_world::Atlas,
	pub doubtful: rustc_hash::FxHashMap<u32, String>,
	pub kb_missing: rustc_hash::FxHashMap<u32, Vec<crate::insertable::Missing>>,
	pub rewards: crate::needs::Rewards,
}

/// The knowledge base: $POLESTAR_KB or `<root>/data/local/kb/forever-kb.sqlite`.
pub fn kb_path(root: &Path) -> PathBuf {
	std::env::var("POLESTAR_KB").map(PathBuf::from).unwrap_or_else(|_| root.join("data/local/kb/forever-kb.sqlite"))
}

pub fn context(root: &Path, faction: Faction) -> Result<Context, String> {
	let data = forge_world::GameData::from_source(&forge_world::data::DirSource::repo(root)).map_err(|e| format!("game data: {e:?}"))?;
	let grid = std::env::var("POLESTAR_GRID").map(PathBuf::from).unwrap_or_else(|_| root.join("data/local/nav4"));
	let sub = forge_world::atlas::GridSubzones::open(&grid, &root.join("data/sources"));
	let atlas = forge_world::Atlas::build_for(faction, &data, Some(&sub), None);
	let kb = kb_path(root);
	let doubtful = crate::insertable::kb_doubts(&kb).map_err(|e| format!("knowledge base: {e}"))?;
	let kb_missing = crate::insertable::kb_missing(&kb).map_err(|e| format!("knowledge base: {e}"))?;
	let rewards = crate::needs::load_rewards(root);
	Ok(Context { data, atlas, doubtful, kb_missing, rewards })
}

/// One start's route settings.
#[derive(Clone, Debug)]
pub struct RouteOpts {
	pub profile: Profile,
	pub search: SearchOpts,
	pub guard: Option<GuardMode>,
	/// `--param` overrides, search draws, holdout draws.
	pub over: Vec<(String, f64)>,
	pub search_draws: usize,
	pub holdout: usize,
}

impl RouteOpts {
	/// forge build's defaults: the average profile, the edit budget at the knee (400 edits),
	/// guard=current, 16 holdout draws.
	pub fn forge(faction: Faction) -> RouteOpts {
		RouteOpts { profile: Profile::average(faction), search: SearchOpts { edits: Some(400), ..Default::default() }, guard: Some(GuardMode::Current), over: Vec::new(), search_draws: 0, holdout: 16 }
	}
}

/// The parameter sets of a route (see route::ParamSets).
pub fn param_sets(l: &Loaded, o: &RouteOpts) -> ParamSets {
	let search = draws(l.params_doc.as_ref(), o.search_draws, o.search.seed.wrapping_mul(0x2545_f491_4f6c_dd1d));
	ParamSets { doc: l.params_doc.clone(), over: o.over.clone(), search, holdout: draws(l.params_doc.as_ref(), o.holdout, HOLDOUT_SEED) }
}

/// One start's route: v1's goal stream improved, every output written under `out` with stem
/// `name` (`<name>.json`, `.skips.json`, `.edits.json`, `-skips.md`, `-ledger.md`,
/// `.judge-v1.json`, `.judge-improved.json`). Returns the result and the files written.
pub fn route_one(l: &Loaded, cx: &Context, race: &str, goals_doc: &Value, seed_name: &str, o: &RouteOpts, out: &Path, name: &str) -> Result<(RouteResult, Vec<PathBuf>), String> {
	let goals: Vec<Goal> = crate::chain::goals_from(goals_doc);
	let events = events_from(goals_doc);
	let sets = param_sets(l, o);
	let ex = Extras { data: Some(&cx.data), atlas: Some(&cx.atlas), guard: o.guard, doubtful: Some(&cx.doubtful), rewards: Some(&cx.rewards), kb_missing: Some(&cx.kb_missing) };
	let r = improve(&l.world, &*l.walks, &sets, race, &events, &goals, &o.profile, &o.search, ex)?;
	let files = write_route(l, race, seed_name, o, &sets, &r, out, name, Value::Null)?;
	Ok((r, files))
}

/// A route's files (see route_one); `shared`: the shared route's facts (Null for an own cut).
#[allow(clippy::too_many_arguments)]
fn write_route(l: &Loaded, race: &str, seed_name: &str, o: &RouteOpts, sets: &ParamSets, r: &RouteResult, out: &Path, name: &str, shared: Value) -> Result<Vec<PathBuf>, String> {
	let base: Params = sets.base();
	let mut doc = json!({
		"faction": l.world.faction.name(), "start": race, "profile": o.profile.name, "classFactor": o.profile.class_factor,
		"walks": "on", "camps": base.camps, "spots": base.spots,
		"seed": seed_name, "tries": o.search.tries, "rng": o.search.seed, "members": o.search.members,
		"searchDraws": sets.search.len(), "holdoutDraws": sets.holdout.len(),
		"v1": r.seed_hours, "improved": r.best_hours, "v1Other": r.seed_other, "improvedOther": r.best_other,
		"v1Gate": r.seed_gate, "improvedGate": r.best_gate, "inSample": r.in_sample, "holdout": r.holdout,
		"guard": format!("{:?}", o.guard), "guardsV1": r.guard_v1, "guardsImproved": r.guard_best,
		"added": r.added, "dropped": r.dropped, "feasibility": r.feas, "edits": r.edits,
		"diff": r.diff, "search": stats_json(&r.stats, r.seconds), "order": r.order,
		"dataHash": l.world.data_hash,
	});
	if !shared.is_null() {
		doc["shared"] = shared;
	}
	std::fs::create_dir_all(out).map_err(|e| format!("{}: {e}", out.display()))?;
	let mut files = Vec::new();
	let mut put = |file: String, body: String| -> Result<(), String> {
		let p = out.join(file);
		std::fs::write(&p, body).map_err(|e| format!("{}: {e}", p.display()))?;
		files.push(p);
		Ok(())
	};
	put(format!("{name}.json"), serde_json::to_string_pretty(&doc).unwrap())?;
	put(format!("{name}.skips.json"), serde_json::to_string_pretty(&r.skips).unwrap())?;
	put(format!("{name}-skips.md"), crate::ledger::skips_md(race, &r.skips))?;
	put(format!("{name}.edits.json"), serde_json::to_string_pretty(&r.edit_rows).unwrap())?;
	put(format!("{name}-ledger.md"), crate::ledger::edits_md(race, &r.edit_rows))?;
	for (k, g) in [("v1", &r.judge_v1), ("improved", &r.judge_best)] {
		put(format!("{name}.judge-{k}.json"), serde_json::to_string(&json!({ "goals": g })).unwrap())?;
	}
	Ok(files)
}

/// A start of the routes stage: its race, faction, the file stem it is written as, and v1's goal
/// stream (a `{"goals": [...]}` document).
pub struct StartIn {
	pub race: String,
	pub faction: Faction,
	pub name: String,
	pub goals: Value,
	pub seed_name: String,
}

/// The routes stage's inputs.
pub struct RoutesIn<'a> {
	/// A repository-shaped tree: data/forever, data/sources, data/local (kb, nav4 grid).
	pub root: &'a Path,
	/// world-<faction>.json, walks-<faction>.bin, params.json.
	pub world_dir: &'a Path,
	pub starts: Vec<StartIn>,
	pub out: &'a Path,
}

/// The routes stage's outputs: files written, and per start a summary row.
pub struct RoutesOut {
	pub files: Vec<PathBuf>,
	pub rows: Vec<Value>,
}

/// The routes stage: every start, faction by faction (one world and context per faction).
pub fn run(inp: &RoutesIn) -> Result<RoutesOut, String> {
	let mut files = Vec::new();
	let mut rows = Vec::new();
	for f in [Faction::Horde, Faction::Alliance] {
		let starts: Vec<&StartIn> = inp.starts.iter().filter(|s| s.faction == f).collect();
		if starts.is_empty() {
			continue;
		}
		let l = load(inp.world_dir, f, true)?;
		let cx = context(inp.root, f)?;
		let o = RouteOpts::forge(f);
		if starts.len() == 1 {
			let s = starts[0];
			let (r, fs) = route_one(&l, &cx, &s.race, &s.goals, &s.seed_name, &o, inp.out, &s.name)?;
			files.extend(fs);
			rows.push(row(&s.name, &r, Value::Null));
			continue;
		}
		let (fs, rs) = shared_faction(&l, &cx, &starts, &o, inp.out)?;
		files.extend(fs);
		rows.extend(rs);
	}
	Ok(RoutesOut { files, rows })
}

fn row(name: &str, r: &RouteResult, shared: Value) -> Value {
	json!({ "start": name, "v1": r.seed_hours, "improved": r.best_hours, "edits": r.edit_rows.len(), "skips": r.skips.len(), "missingInfo": r.skips.iter().filter(|x| x["reason"] == "missing-info").count(), "shared": shared })
}

/// The tail's edits a start's ledger lists: its own cut's kept edits on the quests of its own
/// part (up to the join), then the shared tail's, numbered again.
fn joined_edits(own: &Value, own_quests: &rustc_hash::FxHashSet<u32>, shared: &Value) -> Value {
	let on_own = |e: &Value| {
		e["q"].as_u64().is_some_and(|q| own_quests.contains(&(q as u32)))
			|| e["steps"].as_array().is_some_and(|ss| ss.iter().any(|x| x["q"].as_u64().is_some_and(|q| own_quests.contains(&(q as u32)))))
	};
	let mut list: Vec<Value> = Vec::new();
	for (part, doc, keep) in [("own", own, true), ("shared", shared, false)] {
		for e in doc["list"].as_array().into_iter().flatten() {
			if keep && !on_own(e) {
				continue;
			}
			let mut e = e.clone();
			e["part"] = json!(part);
			list.push(e);
		}
	}
	for (n, e) in list.iter_mut().enumerate() {
		e["n"] = json!(n + 1);
	}
	json!({ "list": list, "own": { "knee": own["knee"], "pickups": own["pickups"] }, "shared": { "knee": shared["knee"], "edits": shared["list"].as_array().map_or(0, Vec::len) } })
}

/// One faction's shared route over `starts` (the first is the canonical one): each start's own
/// cut (written under `<out>/own/`), its own part (shared::split_at_join at join_goal), the canonical start's tail
/// from its join improved by edits no start loses by (descend, no_worse, at the knee), then per
/// start its own cut to the join + the tail in its run (steps its run lacks or does not play
/// left out), reported under its own v1 seed and written as `<out>/<name>.json` and the rest.
pub fn shared_faction(l: &Loaded, cx: &Context, starts: &[&StartIn], o: &RouteOpts, out: &Path) -> Result<(Vec<PathBuf>, Vec<Value>), String> {
	use crate::order::{broken_pairs, play_order, Order};
	use crate::route::{edits_json, finish, prepare, Finish};
	use crate::search::{followers, CtxSpec, Mapper, Problem};
	let world = &l.world;
	let walks = &*l.walks;
	let faction = world.faction;
	let mut files = Vec::new();
	// Each start's own cut.
	let own_dir = out.join("own");
	let mut owns = Vec::new();
	for s in starts {
		let (r, fs) = route_one(l, cx, &s.race, &s.goals, &s.seed_name, o, &own_dir, &s.name)?;
		eprintln!("shared {}: own cut {}: v1 {:.2} h -> {:.2} h", faction.name(), s.name, r.seed_hours["hours60"].as_f64().unwrap_or(0.0), r.best_hours["hours60"].as_f64().unwrap_or(0.0));
		files.extend(fs);
		owns.push(r);
	}
	let sets = param_sets(l, o);
	let base = sets.base();
	let ex = Extras { data: Some(&cx.data), atlas: Some(&cx.atlas), guard: o.guard, doubtful: Some(&cx.doubtful), rewards: Some(&cx.rewards), kb_missing: Some(&cx.kb_missing) };
	let goals: Vec<Vec<Goal>> = starts.iter().map(|s| crate::chain::goals_from(&s.goals)).collect();
	let mut preps = Vec::new();
	for (s, g) in starts.iter().zip(&goals) {
		preps.push(prepare(world, walks, &base, &s.race, &events_from(&s.goals), g, &o.profile, &ex)?);
	}
	// Each own cut split at its join goal: its own part (every step from goals up to the join) and
	// the rest; the canonical start's rest is the tail.
	let rule = crate::shared::join_after(faction);
	let parts: Vec<(Order, Order)> = owns.iter().zip(&goals).map(|(r, g)| crate::shared::split_at_join(&r.best, crate::shared::join_goal(g, rule))).collect();
	let joins: Vec<usize> = parts.iter().map(|p| p.0.len()).collect();
	let u0 = parts[0].1.clone();
	// Each start's model for the shared route: its own travel plan for its part, the canonical
	// start's for the tail.
	let mut smodels = Vec::new();
	for k in 0..starts.len() {
		smodels.push(crate::widen::shared_model(world, walks, &base, &preps[k].profile, &starts[k].race, &preps[k], &parts[k].0.steps, &preps[0], &u0.steps)?);
	}
	// The tail: the canonical start's constraints on it; every start a context (its own part as
	// the prefix); an edit is kept only when no start is slower.
	let mut pairs = preps[0].pairs.clone();
	for k in broken_pairs(&u0.steps, &pairs).into_iter().rev() {
		pairs.remove(k);
	}
	let mut feas = preps[0].feas.clone();
	let mut notes = Vec::new();
	feas.keep_seed(&preps[0].model.run, &u0.steps, &mut notes);
	let guard0 = preps[0].guard.take().map(|mut g| {
		g.train_levels.retain(|(x, _)| u0.origin.contains(x));
		g
	});
	let ctxs: Vec<CtxSpec> = (0..starts.len())
		.map(|k| CtxSpec { model: &smodels[k].0, prefix: parts[k].0.steps.clone(), map: (k > 0).then(|| Mapper::new(&preps[0].model.run, &preps[k].model.run)), name: starts[k].name.clone() })
		.collect();
	let mut p = Problem { model: &smodels[0].0, walks, pairs, pool: preps[0].pool.clone(), ctxs, followers: followers(&preps[0].model.run), guard: guard0, feas, log_bound: u32::MAX };
	let mut lg = |k: usize, h: f64, kind: &str| eprintln!("shared {} edit {k}: {kind} -> {h:.3} h (sum)", faction.name());
	let max = o.search.edits.unwrap_or(400);
	let d = crate::search::edits::descend(&p, &u0, max, o.search.members, true, &mut lg);
	let kk = o.search.budget.unwrap_or_else(|| crate::search::edits::knee(&d)).min(d.edits.len());
	let tail = if kk == 0 { u0.clone() } else { d.orders[kk - 1].clone() };
	let shared_doc = edits_json(world, &preps[0].rules, &preps[0].model, &d, kk);
	let mut guard0 = p.guard.take();
	drop(p);
	// Per start: own part + the tail in its run, its no-op tail steps left out, reported.
	let mut rows = Vec::new();
	for k in 0..starts.len() {
		let s = starts[k];
		let (sm, sprof) = (&smodels[k].0, &smodels[k].1);
		let map = Mapper::new(&preps[0].model.run, &preps[k].model.run);
		let offset = if k == 0 { 0 } else { goals[k].len() as i64 };
		let mut order = crate::shared::joined(&parts[k].0, joins[k], &tail, (k > 0).then_some((&map, &preps[0].model.run, &preps[k].model.run)), offset);
		let kept_own = if k == 0 { 0 } else { crate::shared::keep_own_rest(&mut order, joins[k], &parts[k].1) };
		let mut ev = sm.evaluator(walks);
		let (_, did) = play_order(&mut ev, &order.steps);
		let keep: Vec<bool> = (0..order.len()).map(|i| i < joins[k] || did[i] || !matches!(order.steps[i].kind, crate::run::K_ACCEPT | crate::run::K_TASK | crate::run::K_TURNIN)).collect();
		let left_out = keep.iter().filter(|x| !**x).count();
		order = Order { steps: order.steps.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect(), origin: order.origin.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect() };
		let all_goals: Vec<Goal> = if k == 0 { goals[0].clone() } else { goals[k].iter().chain(&goals[0]).cloned().collect() };
		let mut problem = Problem::single(sm, walks, preps[k].pairs.clone(), preps[k].pool.clone());
		problem.feas = preps[k].feas.clone();
		problem.guard = if k == 0 { guard0.take() } else { preps[k].guard.take() };
		let own_quests: rustc_hash::FxHashSet<u32> =
			order.steps[..joins[k]].iter().filter(|x| matches!(x.kind, crate::run::K_ACCEPT | crate::run::K_TASK | crate::run::K_TURNIN)).map(|x| preps[k].model.run.q_id[x.q as usize]).collect();
		let edits_doc = joined_edits(&owns[k].edits, &own_quests, &shared_doc);
		let fin = Finish { world, walks, sets: &sets, race: &s.race, goals: &all_goals, ex: &ex, profile: sprof, prep: &preps[k], problem: &problem };
		let r = finish(&fin, order, edits_doc, Default::default(), Default::default(), d.seconds)?;
		let jl = owns[k].best_hours.clone();
		let facts = json!({
			"canonical": starts[0].name, "joinAfter": rule, "joinStep": joins[k], "tailSteps": tail.len(), "tailEdits": kk, "tailLeftOut": left_out, "ownKept": kept_own,
			"own": { "hours30": jl["hours30"], "hours60": jl["hours60"] },
		});
		eprintln!(
			"shared {}: {}: join step {}, v1 {:.2} h, own cut {:.2} h, shared {:.2} h ({} tail steps it does not play left out)",
			faction.name(),
			s.name,
			joins[k],
			r.seed_hours["hours60"].as_f64().unwrap_or(0.0),
			jl["hours60"].as_f64().unwrap_or(0.0),
			r.best_hours["hours60"].as_f64().unwrap_or(0.0),
			left_out
		);
		files.extend(write_route(l, &s.race, &s.seed_name, o, &sets, &r, out, &s.name, facts.clone())?);
		rows.push(row(&s.name, &r, facts));
	}
	for n in &notes {
		eprintln!("shared {}: {n}", faction.name());
	}
	Ok((files, rows))
}
