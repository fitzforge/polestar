//! The routes stage of `forge build` as a library call: for each start, v1's chain (its goal
//! stream) improved with an edit budget, written as `<out>/<start>.json` (the order and its
//! numbers), `.skips.json` (the skip ledger), `.edits.json` (the edit ledger), their markdown,
//! and the judge's goal streams. The `forge sim route` CLI is a thin wrapper of `route_one`.
//!
//! A faction with more than one start gets one shared route (shared_faction): each start's own
//! cut split at its join (shared::split_at_join: after horde/02-the-barrens for the Horde, after
//! alliance/02-westfall for the Alliance), then the first start's tail (Orc's, Human's),
//! improved by edits that slow no start (search::edits::descend, no_worse), written per start.
//!
//! With checkpoints (RoutesIn::resume, resume.rs) every search unit (a start's route, an own cut
//! `own-<start>`, a faction's tail `shared-<faction>`) checkpoints as it goes and when it is done,
//! and a rerun under the same key resumes each where it was.

use crate::chain::{events_from, Goal};
use crate::flow::FlowCheck;
use crate::params::draws;
use crate::profile::Profile;
use crate::resume::{DoneCk, Resume, Unit, DONE};
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
		if !w.built_on(&world) {
			eprintln!("warning: {} was built on another world ({})", f.display(), w.built_on_text(&world));
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
	/// forge build's defaults: the average profile, the search as `search` says (forge build: the
	/// edit descent capped at 400 edits, every edit kept), guard=current, 16 holdout draws.
	pub fn forge(faction: Faction, search: SearchOpts) -> RouteOpts {
		RouteOpts {
			profile: Profile::average(faction),
			search,
			guard: Some(GuardMode::Current),
			over: Vec::new(),
			search_draws: 0,
			holdout: 16,
		}
	}
}

/// The parameter sets of a route (see route::ParamSets).
pub fn param_sets(l: &Loaded, o: &RouteOpts) -> ParamSets {
	let search = draws(l.params_doc.as_ref(), o.search_draws, o.search.seed.wrapping_mul(0x2545_f491_4f6c_dd1d));
	ParamSets { doc: l.params_doc.clone(), over: o.over.clone(), search, holdout: draws(l.params_doc.as_ref(), o.holdout, HOLDOUT_SEED) }
}

/// One start's route: v1's goal stream improved, every output written under `out` with stem
/// `name` (`<name>.json`, `.skips.json`, `.edits.json`, `-skips.md`, `-ledger.md`,
/// `.judge-v1.json`, `.judge-improved.json`); with `flow`, its written guides checked and the
/// findings fed back (route::improve). Returns the result and the files written. `ck`: its
/// search's checkpoints (route::improve).
#[allow(clippy::too_many_arguments)]
pub fn route_one(l: &Loaded, cx: &Context, race: &str, goals_doc: &Value, seed_name: &str, o: &RouteOpts, out: &Path, name: &str, ck: Option<&Unit>, flow: Option<&FlowCheck>) -> Result<(RouteResult, Vec<PathBuf>), String> {
	let goals: Vec<Goal> = crate::chain::goals_from(goals_doc);
	let events = events_from(goals_doc);
	let sets = param_sets(l, o);
	let ex = Extras { data: Some(&cx.data), atlas: Some(&cx.atlas), guard: o.guard, doubtful: Some(&cx.doubtful), rewards: Some(&cx.rewards), kb_missing: Some(&cx.kb_missing) };
	let names = [name.to_string()];
	let mut written = |r: &RouteResult| -> Result<Vec<crate::flow::Finding>, String> {
		write_route(l, race, seed_name, o, &sets, r, out, name, Value::Null)?;
		flow.map_or(Ok(Vec::new()), |check| check(out, &names))
	};
	let cb: Option<&mut dyn FnMut(&RouteResult) -> Result<Vec<crate::flow::Finding>, String>> = if flow.is_some() { Some(&mut written) } else { None };
	let r = improve(&l.world, &*l.walks, &sets, race, &events, &goals, &o.profile, &o.search, ex, ck, cb)?;
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
		"seed": seed_name, "searchMode": o.search.mode.name(), "tries": o.search.tries, "rng": o.search.seed, "members": o.search.members, "cut": o.search.cut.name(),
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
	/// Threads for every search (the starts and factions share them).
	pub threads: usize,
	/// How every route is searched (forge build: SearchOpts::forge).
	pub search: SearchOpts,
	/// Deathskips priced (`forge build --deathskips`; the deathskips parameter).
	pub deathskips: bool,
	/// The searches' checkpoints (forge build: under the stage cache, for the routes stage key).
	pub resume: Option<&'a Resume>,
	/// The check on the guides written from the routes (crate::flow; forge build gives it), fed
	/// back to each faction's route; None: not checked.
	pub flow: Option<&'a FlowCheck<'a>>,
}

/// The routes stage's outputs: files written, and per start a summary row.
pub struct RoutesOut {
	pub files: Vec<PathBuf>,
	pub rows: Vec<Value>,
}

/// The routes stage's walk-store misses (`<out>/walk-misses.json`): per faction, the world point
/// pairs its orders walked with no walk in the store, smaller id first, sorted, unique. forge build
/// merges them into the next build's extra walk pairs.
pub const WALK_MISSES: &str = "walk-misses.json";

/// Per faction (horde, alliance), the pairs a set of route results walked with no stored walk.
type Misses = Vec<(u32, u32)>;

fn union(mut v: Misses) -> Misses {
	v.sort_unstable();
	v.dedup();
	v
}

/// The routes stage: every start, faction by faction (one world and context per faction).
pub fn run(inp: &RoutesIn) -> Result<RoutesOut, String> {
	use rayon::prelude::*;
	// The factions at once, each start's own cut at once (shared_faction), every search's own threads in the
	// same pool: the routes are the same as one at a time (each search is counted in tries and edits, not
	// time), the files and rows come out in start order.
	let pool = rayon::ThreadPoolBuilder::new().num_threads(inp.threads).build().map_err(|e| e.to_string())?;
	let per: Vec<(Vec<PathBuf>, Vec<Value>, Misses)> = pool.install(|| {
		[Faction::Horde, Faction::Alliance]
			.par_iter()
			.map(|&f| -> Result<(Vec<PathBuf>, Vec<Value>, Misses), String> {
				// Each start's goal stream with its own shared guides before its join (shared::own_guides).
				let owned: Vec<StartIn> = inp
					.starts
					.iter()
					.filter(|s| s.faction == f)
					.map(|s| StartIn { race: s.race.clone(), faction: s.faction, name: s.name.clone(), goals: crate::shared::with_own_guides(&s.goals, &s.race, crate::shared::join_at(f)), seed_name: s.seed_name.clone() })
					.collect();
				let starts: Vec<&StartIn> = owned.iter().collect();
				if starts.is_empty() {
					return Ok((Vec::new(), Vec::new(), Vec::new()));
				}
				let l = load(inp.world_dir, f, true)?;
				let cx = context(inp.root, f)?;
				let mut o = RouteOpts::forge(f, inp.search.clone());
				if inp.deathskips {
					o.over.push(("deathskips".into(), 1.0));
				}
				if starts.len() == 1 {
					let s = starts[0];
					let ck = inp.resume.map(|r| r.unit(&s.name));
					let (r, fs) = route_one(&l, &cx, &s.race, &s.goals, &s.seed_name, &o, inp.out, &s.name, ck.as_ref(), inp.flow)?;
					return Ok((fs, vec![row(&s.name, &r, Value::Null)], r.walk_misses.clone()));
				}
				shared_faction(&l, &cx, &starts, &o, inp.out, inp.resume, inp.flow)
			})
			.collect::<Result<Vec<_>, String>>()
	})?;
	let (mut files, mut rows) = (Vec::new(), Vec::new());
	let mut doc = serde_json::Map::new();
	for (f, (fs, rs, ms)) in [Faction::Horde, Faction::Alliance].into_iter().zip(per) {
		files.extend(fs);
		rows.extend(rs);
		doc.insert(f.lower().to_string(), json!(ms.iter().map(|&(a, b)| [a, b]).collect::<Vec<_>>()));
	}
	let p = inp.out.join(WALK_MISSES);
	std::fs::create_dir_all(inp.out).map_err(|e| e.to_string())?;
	std::fs::write(&p, serde_json::to_string(&Value::Object(doc)).unwrap_or_default()).map_err(|e| format!("{}: {e}", p.display()))?;
	files.push(p);
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
/// from its join improved by edits no start loses by (descend, no_worse, cut as `o` says), then per
/// start its own cut to the join + the tail in its run (steps its run lacks or does not play
/// left out), reported under its own v1 seed and written as `<out>/<name>.json` and the rest.
/// `resume`: the own cuts' and the tail's checkpoints (`own-<start>`, `shared-<faction>`).
#[allow(clippy::too_many_arguments)]
pub fn shared_faction(l: &Loaded, cx: &Context, starts: &[&StartIn], o: &RouteOpts, out: &Path, resume: Option<&Resume>, flow: Option<&FlowCheck>) -> Result<(Vec<PathBuf>, Vec<Value>, Misses), String> {
	use crate::order::{broken_pairs, Order};
	use crate::route::{hub_sweep_rows, prepare};
	let world = &l.world;
	let walks = &*l.walks;
	let faction = world.faction;
	let mut files = Vec::new();
	// Each start's own cut.
	let own_dir = out.join("own");
	let mut owns = Vec::new();
	let mut misses: Misses = Vec::new();
	use rayon::prelude::*;
	// (Own cuts are not written as guides: the shared route is.)
	let cuts: Vec<(RouteResult, Vec<PathBuf>)> = starts
		.par_iter()
		.map(|s| {
			let ck = resume.map(|r| r.unit(&format!("own-{}", s.name)));
			route_one(l, cx, &s.race, &s.goals, &s.seed_name, o, &own_dir, &s.name, ck.as_ref(), None)
		})
		.collect::<Result<_, String>>()?;
	for (s, (r, fs)) in starts.iter().zip(cuts) {
		eprintln!("shared {}: own cut {}: v1 {:.2} h -> {:.2} h", faction.name(), s.name, r.seed_hours["hours60"].as_f64().unwrap_or(0.0), r.best_hours["hours60"].as_f64().unwrap_or(0.0));
		files.extend(fs);
		misses.extend(r.walk_misses.iter().copied());
		owns.push(r);
	}
	let sets = param_sets(l, o);
	let base = sets.base();
	let ex = Extras { data: Some(&cx.data), atlas: Some(&cx.atlas), guard: o.guard, doubtful: Some(&cx.doubtful), rewards: Some(&cx.rewards), kb_missing: Some(&cx.kb_missing) };
	let goals: Vec<Vec<Goal>> = starts.iter().map(|s| crate::chain::goals_from(&s.goals)).collect();
	let mut preps: Vec<_> = starts.par_iter().zip(goals.par_iter()).map(|(s, g)| prepare(world, walks, &base, &s.race, &events_from(&s.goals), g, &o.profile, &ex)).collect::<Result<_, String>>()?;
	// Each own cut split at its join goal: its own part (every step from goals up to the join) and
	// the rest; the canonical start's rest is the tail.
	let rule = crate::shared::join_at(faction);
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
	let mut p = tail_problem(&smodels, walks, &parts, &preps, starts, &pairs, &feas, guard0);
	let t0 = std::time::Instant::now();
	// The tail: its finished search's checkpoint, else searched (shared_tail) and checkpointed.
	let ck = resume.map(|r| r.unit(&format!("shared-{}", faction.lower())));
	let done = ck.as_ref().and_then(|u| u.load::<DoneCk>(DONE).map(|d| (u, d)));
	// (A resumed tail has no hub batches to undo: they are not checkpointed.)
	let (mut tail, mut shared_doc, tail_seconds, batches) = match done {
		Some((u, d)) => {
			u.note(format!("resuming {} from checkpoint (search done)", u.name));
			(d.best.into(), d.edits, d.seconds, Vec::new())
		}
		None => {
			let (tail, doc, batches) = shared_tail(world, &preps[0], &p, &u0, o, ck.as_ref());
			let seconds = t0.elapsed().as_secs_f64();
			if let Some(u) = &ck {
				u.save(DONE, &DoneCk { best: (&tail).into(), edits: doc.clone(), refused: Vec::new(), stats: Default::default(), seconds });
			}
			(tail, doc, seconds, batches)
		}
	};
	let mut plog = |s: &str| eprintln!("shared {}: {s}", faction.name());
	// Per start, its guard (the canonical start's: the tail's) for finishing it; the tail problem
	// is made again for each round of the written check.
	let mut guards: Vec<Option<crate::search::Guard>> = (0..starts.len()).map(|k| if k == 0 { p.guard.take() } else { preps[k].guard.take() }).collect();
	drop(p);
	// The models' travel plans as the search had them: each start's finish leaves out the plan's
	// hearth lines its order meets on cooldown, from the plans as they were, every round.
	let plans: Vec<_> = smodels.iter().map(|(m, pr)| (m.run.plan.clone(), pr.plan.clone())).collect();
	let ss = Starts { l, o, out, starts, world, walks, sets: &sets, ex: &ex, preps: &preps, parts: &parts, joins: &joins, goals: &goals, owns: &owns, rule, tail_seconds };
	let mut w = ss.write(&tail, &shared_doc, &mut smodels, &plans, &mut guards)?;
	// The written check (crate::flow): its findings back to the tail as moves, written and checked
	// again; a round is kept when the check finds fewer.
	if let (Some(check), true) = (flow, o.profile.train_stops) {
		let names: Vec<String> = starts.iter().map(|s| s.name.clone()).collect();
		let mut found = check(out, &names)?;
		eprintln!("shared {}: written check: {}", faction.name(), crate::flow::summary(&found));
		let mut fixed = 0;
		for round in 1..=crate::flow::FLOW_ROUNDS {
			if found.is_empty() {
				break;
			}
			restore_plans(&mut smodels, &plans);
			let mut p = tail_problem(&smodels, walks, &parts, &preps, starts, &pairs, &feas, guards[0].take());
			let mut m = crate::search::Member::new(&p, tail.clone(), &crate::search::runs(&p, &tail), 1);
			let fixes = crate::search::passby::flow_fixes(&p, &mut m, &found, &batches, &mut plog);
			let next = m.order.clone();
			drop(m);
			guards[0] = p.guard.take();
			drop(p);
			if fixes.is_empty() {
				break;
			}
			let mut doc = shared_doc.clone();
			hub_sweep_rows(world, &preps[0].rules, &preps[0].model, &mut doc, &fixes, "writtenCheck");
			doc["writtenCheck"] = json!(fixed + fixes.len());
			let nw = ss.write(&next, &doc, &mut smodels, &plans, &mut guards)?;
			let now = check(out, &names)?;
			eprintln!("shared {}: written check round {round}: {} moves -> {}", faction.name(), fixes.len(), crate::flow::summary(&now));
			if now.len() >= found.len() {
				// No better: the routes as they were.
				w = ss.write(&tail, &shared_doc, &mut smodels, &plans, &mut guards)?;
				break;
			}
			(tail, shared_doc, w, found) = (next, doc, nw, now);
			fixed += fixes.len();
		}
	}
	for n in &notes {
		eprintln!("shared {}: {n}", faction.name());
	}
	files.extend(w.0);
	misses.extend(w.2);
	Ok((files, w.1, union(misses)))
}

/// The shared tail's problem: the canonical start's model and constraints, every start a context
/// (its own part as the prefix), the guard given.
#[allow(clippy::too_many_arguments)]
fn tail_problem<'s>(
	smodels: &'s [(crate::Model, Profile)],
	walks: &'s dyn Walks,
	parts: &[(crate::order::Order, crate::order::Order)],
	preps: &[crate::route::Prepared],
	starts: &[&StartIn],
	pairs: &[crate::order::Pair],
	feas: &crate::order::Feas,
	guard: Option<crate::search::Guard>,
) -> crate::search::Problem<'s> {
	use crate::search::{followers, CtxSpec, Mapper};
	let ctxs: Vec<CtxSpec> = (0..starts.len())
		.map(|k| CtxSpec { model: &smodels[k].0, prefix: parts[k].0.steps.clone(), map: (k > 0).then(|| Mapper::new(&preps[0].model.run, &preps[k].model.run)), name: starts[k].name.clone() })
		.collect();
	crate::search::Problem { model: &smodels[0].0, walks, pairs: pairs.to_vec(), pool: preps[0].pool.clone(), ctxs, followers: followers(&preps[0].model.run), guard, feas: feas.clone(), log_bound: u32::MAX }
}

/// The models' travel plans back to `plans` (see shared_faction).
fn restore_plans(smodels: &mut [(crate::Model, Profile)], plans: &[(Option<std::sync::Arc<crate::run::TravelPlan>>, Option<std::sync::Arc<crate::run::TravelPlan>>)]) {
	for ((m, pr), (a, b)) in smodels.iter_mut().zip(plans) {
		m.run.plan = a.clone();
		pr.plan = b.clone();
	}
}

/// What writing a shared route's starts reads (shared_faction).
struct Starts<'a> {
	l: &'a Loaded,
	o: &'a RouteOpts,
	out: &'a Path,
	starts: &'a [&'a StartIn],
	world: &'a World,
	walks: &'a dyn Walks,
	sets: &'a ParamSets,
	ex: &'a Extras<'a>,
	preps: &'a [crate::route::Prepared],
	parts: &'a [(crate::order::Order, crate::order::Order)],
	joins: &'a [usize],
	goals: &'a [Vec<Goal>],
	owns: &'a [RouteResult],
	rule: Option<&'static str>,
	tail_seconds: f64,
}

impl Starts<'_> {
	/// Per start: its own part + the tail in its run, its no-op tail steps left out, reported and
	/// written as `<out>/<name>.json` and the rest. -> the files, the rows, the walk store misses.
	fn write(
		&self,
		tail: &crate::order::Order,
		shared_doc: &Value,
		smodels: &mut [(crate::Model, Profile)],
		plans: &[(Option<std::sync::Arc<crate::run::TravelPlan>>, Option<std::sync::Arc<crate::run::TravelPlan>>)],
		guards: &mut [Option<crate::search::Guard>],
	) -> Result<(Vec<PathBuf>, Vec<Value>, Misses), String> {
		use crate::order::{play_order, Order};
		use crate::route::{finish, Finish};
		use crate::search::{Mapper, Problem};
		let (world, walks, preps, parts, joins, goals) = (self.world, self.walks, self.preps, self.parts, self.joins, self.goals);
		let faction = world.faction;
		restore_plans(smodels, plans);
		let (mut files, mut rows, mut misses) = (Vec::new(), Vec::new(), Vec::new());
		for k in 0..self.starts.len() {
			let s = self.starts[k];
			let map = Mapper::new(&preps[0].model.run, &preps[k].model.run);
			let offset = if k == 0 { 0 } else { goals[k].len() as i64 };
			let mut order = crate::shared::joined(&parts[k].0, joins[k], tail, (k > 0).then_some((&map, &preps[0].model.run, &preps[k].model.run)), offset);
			let kept_own = if k == 0 {
				0
			} else {
				crate::shared::keep_own_rest(&mut order, joins[k], &parts[k].1, &|a, b| {
					let d = preps[k].model.run.straight(a, b);
					if d.is_finite() {
						d
					} else {
						1.0e6
					}
				})
			};
			if k > 0 {
				crate::shared::own_lines(&mut order, joins[k], &goals[k], crate::shared::join_goal(&goals[k], self.rule), &goals[0], offset);
			}
			// The tail's steps from its own shared guides left out (shared::own_guides: done in its own
			// part; the quests it did not take there are not taken on a return).
			let own = crate::shared::own_guides(&s.race);
			if !own.is_empty() {
				let from_own = |i: usize| i >= joins[k] && order.origin[i] >= offset && goals[0].get((order.origin[i] - offset) as usize).is_some_and(|g| crate::shared::in_guides(&g.guide, own));
				let keep: Vec<bool> = (0..order.len()).map(|i| !from_own(i)).collect();
				order = Order { steps: order.steps.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect(), origin: order.origin.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect() };
			}
			let mut ev = smodels[k].0.evaluator(walks);
			let (_, did) = play_order(&mut ev, &order.steps);
			drop(ev);
			let keep: Vec<bool> = (0..order.len()).map(|i| i < joins[k] || did[i] || !matches!(order.steps[i].kind, crate::run::K_ACCEPT | crate::run::K_TASK | crate::run::K_TURNIN)).collect();
			let left_out = keep.iter().filter(|x| !**x).count();
			order = Order { steps: order.steps.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect(), origin: order.origin.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect() };
			// The plan's hearth lines this start's final order meets while the stone cools down (its
			// own rest put back, the tail's later edits and passes) are left out of its plan: the model
			// never plans a hearth on cooldown (c11: Tauren and NightElf one each).
			if !crate::route::drop_cooling_hearths(&mut smodels[k].0, walks, &order.steps).is_empty() {
				smodels[k].1.plan = smodels[k].0.run.plan.clone();
			}
			let (sm, sprof) = (&smodels[k].0, &smodels[k].1);
			let all_goals: Vec<Goal> = if k == 0 { goals[0].clone() } else { goals[k].iter().chain(&goals[0]).cloned().collect() };
			let mut problem = Problem::single(sm, walks, preps[k].pairs.clone(), preps[k].pool.clone());
			problem.feas = preps[k].feas.clone();
			problem.guard = guards[k].take();
			let own_quests: rustc_hash::FxHashSet<u32> =
				order.steps[..joins[k]].iter().filter(|x| matches!(x.kind, crate::run::K_ACCEPT | crate::run::K_TASK | crate::run::K_TURNIN)).map(|x| preps[k].model.run.q_id[x.q as usize]).collect();
			let edits_doc = joined_edits(&self.owns[k].edits, &own_quests, shared_doc);
			let fin = Finish { world, walks, sets: self.sets, race: &s.race, goals: &all_goals, ex: self.ex, profile: sprof, prep: &preps[k], problem: &problem };
			let r = finish(&fin, order, edits_doc, Default::default(), Default::default(), self.tail_seconds);
			guards[k] = problem.guard.take();
			let r = r?;
			let jl = self.owns[k].best_hours.clone();
			let facts = json!({
				"canonical": self.starts[0].name, "joinAt": self.rule, "joinStep": joins[k], "tailSteps": tail.len(), "tailEdits": shared_doc["list"].as_array().map_or(0, |l| l.iter().filter(|e| e["kept"] == true).count()), "tailSearch": self.o.search.mode.name(), "tailLeftOut": left_out, "ownKept": kept_own,
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
			files.extend(write_route(self.l, &s.race, &s.seed_name, self.o, self.sets, &r, self.out, &s.name, facts.clone())?);
			misses.extend(r.walk_misses.iter().copied());
			rows.push(row(&s.name, &r, facts));
		}
		Ok((files, rows, misses))
	}
}

/// The shared tail's search from `u0` (the canonical start's rest): the free search (free, hybrid),
/// no start slower for a kept move, then the edit descent from its order (edits, hybrid), then the
/// hub passes over every start's context. The tail, its edit list, and the hub batches it made
/// (for the written check to undo, flow_fixes).
fn shared_tail(world: &World, prep0: &crate::route::Prepared, p: &crate::search::Problem, u0: &crate::order::Order, o: &RouteOpts, ck: Option<&Unit>) -> (crate::order::Order, Value, Vec<crate::search::passby::HubPickup>) {
	use crate::route::edits_json;
	let faction = world.faction;
	let mut lg = |k: usize, h: f64, kind: &str| eprintln!("shared {} edit {k}: {kind} -> {h:.3} h (sum)", faction.name());
	let mut tail = u0.clone();
	let mut shared_doc = Value::Null;
	let mut batches = Vec::new();
	if o.search.mode != crate::search::Mode::Edits {
		let out = crate::search::search(p, u0, &SearchOpts { no_worse: true, ..o.search.clone() }, ck);
		eprintln!("shared {}: free search {} tries, {} kept -> {:.3} h (sum)", faction.name(), out.stats.tries, out.stats.kept, out.totals.iter().sum::<f64>() / 3600.0);
		tail = out.best;
		shared_doc = crate::route::free_edits_json(world, &prep0.rules, p, u0, &tail);
	}
	if o.search.mode != crate::search::Mode::Free {
		let max = o.search.edits.unwrap_or(400);
		let d = crate::search::edits::descend(p, &tail, max, o.search.members, true, &mut lg, ck);
		let kk = crate::search::edits::cut_at(&d, o.search.budget, o.search.cut);
		let mut doc = edits_json(world, &prep0.rules, &prep0.model, &d, kk);
		if let (Some(free), Some(list)) = (shared_doc["list"].as_array(), doc["list"].as_array_mut()) {
			let mut all = free.clone();
			all.append(list);
			*list = all;
			doc["free"] = shared_doc["free"].clone();
		}
		shared_doc = doc;
		if kk > 0 {
			tail = d.orders[kk - 1].clone();
		}
	}
	// The hub pickup pass over the tail (every start's context: an earlier visit's pickup no start
	// pays more than the allowance for in sum).
	if o.profile.train_stops {
		let mut m = crate::search::Member::new(p, tail.clone(), &crate::search::runs(p, &tail), 1);
		let mut plog = |s: &str| eprintln!("shared {}: {s}", faction.name());
		let stays = crate::search::passby::stay_on_continent(p, &mut m, &mut plog);
		crate::route::hub_sweep_rows(world, &prep0.rules, &prep0.model, &mut shared_doc, &stays, "stayOnContinent");
		let hubs = crate::search::passby::hub_pickup(p, &mut m, &mut plog);
		crate::route::hub_pickup_rows(world, &prep0.rules, &prep0.model, &mut shared_doc, &hubs, "hub pickup", "hubPickups");
		let ties = crate::search::passby::bag_ties(p, &mut m, &mut plog);
		crate::route::hub_pickup_rows(world, &prep0.rules, &prep0.model, &mut shared_doc, &ties, "bag tie", "bagTies");
		let gathers = crate::search::passby::camp_gather(p, &mut m, &mut plog);
		crate::route::camp_gather_rows(world, &prep0.rules, &prep0.model, &mut shared_doc, &gathers);
		batches = crate::search::passby::hub_batch(p, &mut m, &mut plog);
		crate::route::hub_sweep_rows(world, &prep0.rules, &prep0.model, &mut shared_doc, &batches, "hubBatches");
		let sweeps = crate::search::passby::hub_sweep(p, &mut m, &mut plog);
		crate::route::hub_sweep_rows(world, &prep0.rules, &prep0.model, &mut shared_doc, &sweeps, "hubSweeps");
		let trains = crate::search::passby::trains_out_of_field(p, &mut m, &mut plog);
		crate::route::hub_sweep_rows(world, &prep0.rules, &prep0.model, &mut shared_doc, &trains, "trainsAtHub");
		let revisits = crate::search::passby::hub_revisits(p, &mut m, &mut plog);
		crate::route::hub_sweep_rows(world, &prep0.rules, &prep0.model, &mut shared_doc, &revisits, "hubRevisits");
		let defers = crate::search::passby::defer_hard_work(p, &mut m, &mut plog);
		crate::route::hub_sweep_rows(world, &prep0.rules, &prep0.model, &mut shared_doc, &defers, "deferredWork");
		let topups = crate::search::passby::grind_topups(p, &mut m, &mut plog);
		crate::route::hub_sweep_rows(world, &prep0.rules, &prep0.model, &mut shared_doc, &topups, "grindTopUps");
		tail = m.order.clone();
	}
	(tail, shared_doc, batches)
}
