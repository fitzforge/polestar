//! The shared faction route: each start keeps its own route to its join point (the first step
//! from a guide every start of the faction plays, about level 12); from there one order for the
//! whole faction, scored as the sum of hours to 60 over the faction's starts × the three class
//! profiles (slow, average, fast). Reported like v1's consensus.js: per start and profile the
//! hours lost against the start's own best route.

use crate::chain::Goal;
use crate::guards::GuardData;
use crate::insertable::Insertable;
use crate::order::{deliberate_pairs, seed_order, Order};
use crate::profile::Profile;
use crate::route::model_for;
use crate::search::{clean, evaluate, followers, pool, runs, search, CtxSpec, Guard, GuardMode, Mapper, Problem, SearchOpts, Stats};
use crate::seq::Event;
use crate::walks::Walks;
use crate::{Model, Params};
use forge_world::World;
use forge_world::{Atlas, GameData};

/// A start: its race and v1's chain (goals and their events).
pub struct Start {
	pub race: String,
	pub goals: Vec<Goal>,
	pub events: Vec<Event>,
}

/// Race folders of the shipped guides: a goal from a guide outside them is shared.
pub const RACE_FOLDERS: &[&str] = &["orc-troll", "tauren", "undead", "skyborne", "human", "dwarf-gnome", "nightelf"];

/// Whether a guide id (`forever/<faction>/<folder>/...`) is one every start plays.
pub fn shared_guide(guide: &str) -> bool {
	!guide.split('/').any(|seg| RACE_FOLDERS.contains(&seg))
}

/// Where an order joins the shared route: after its last step from the start's own guides
/// (every step of a race folder's guide stays in the start's own route).
pub fn join_point(o: &Order, goals: &[Goal]) -> usize {
	o.origin.iter().rposition(|&g| g >= 0 && goals.get(g as usize).is_some_and(|x| !shared_guide(&x.guide))).map_or(0, |i| i + 1)
}

/// The guide after which a faction's starts share one route. Horde: horde/02-the-barrens (Orc and
/// Troll play the early Barrens quests in their own orc-troll/02-the-barrens, the others inside the
/// shared guide). Alliance: alliance/02-westfall (Human plays part of Westfall's quests from its own
/// Elwynn guide, the others inside the shared Westfall guide). A tail that began before that guide
/// would leave the others' quests of it out (RsSim.md "horde shared", "forge all-10"); each start
/// keeps its own order of it.
pub fn join_after(f: forge_core::Faction) -> Option<&'static str> {
	match f {
		forge_core::Faction::Horde => Some("horde/02-the-barrens"),
		forge_core::Faction::Alliance => Some("alliance/02-westfall"),
	}
}

/// Where an order joins its faction's shared route: after its last step from the `join_after`
/// guide (the start's own order of it kept), or, without one or when the order has no step
/// from it, at join_point.
pub fn join_index(o: &Order, goals: &[Goal], join_after: Option<&str>) -> usize {
	join_after.and_then(|g| o.origin.iter().rposition(|&x| x >= 0 && goals.get(x as usize).is_some_and(|y| y.guide.ends_with(g)))).map_or_else(|| join_point(o, goals), |i| i + 1)
}

/// The last goal (index) of a start's own part: its last goal from the `join_after` guide, or,
/// without one or when no goal is from it, its last goal from its own race guides; -1: none.
pub fn join_goal(goals: &[Goal], join_after: Option<&str>) -> i64 {
	let own = || goals.iter().rposition(|x| !shared_guide(&x.guide)).map_or(-1, |i| i as i64);
	join_after.and_then(|g| goals.iter().rposition(|x| x.guide.ends_with(g))).map_or_else(own, |i| i as i64)
}

/// An order split at its start's join goal `jg`: the steps from goals up to `jg`, then the steps
/// from later goals, each in the order's own order (a step with no goal, inserted or a training
/// stop or a grind, goes with the step before it). Splitting by goal, not by position, keeps every
/// goal on one side however the order's edits interleaved the guides around the join.
pub fn split_at_join(o: &Order, jg: i64) -> (Order, Order) {
	let (mut a, mut b) = (Order { steps: Vec::new(), origin: Vec::new() }, Order { steps: Vec::new(), origin: Vec::new() });
	let mut tail = false;
	for (s, &g) in o.steps.iter().zip(&o.origin) {
		if g >= 0 {
			tail = g > jg;
		}
		let side = if tail { &mut b } else { &mut a };
		side.steps.push(*s);
		side.origin.push(g);
	}
	(a, b)
}

/// The steps of a start's own rest (its own cut after the join) that its shared route lacks (its
/// own quests the canonical tail does not take: a guide line `only <race>`), put back: each after
/// the shared route's step that came before it in the own cut (or at the join). Without them the
/// start would lose its own quests of the shared guides.
pub fn keep_own_rest(route: &mut Order, join: usize, own_rest: &Order) -> usize {
	let key = |s: &crate::Step| (s.kind, s.q, s.task);
	let quest = |s: &crate::Step| matches!(s.kind, crate::run::K_ACCEPT | crate::run::K_TASK | crate::run::K_TURNIN);
	let have: rustc_hash::FxHashSet<(u8, u32, i32)> = route.steps[join..].iter().filter(|s| quest(s)).map(key).collect();
	let mut at = join;
	let mut put = 0;
	for (s, &g) in own_rest.steps.iter().zip(&own_rest.origin) {
		if !quest(s) {
			continue;
		}
		if have.contains(&key(s)) {
			if let Some(i) = route.steps[at..].iter().position(|x| key(x) == key(s)) {
				at += i + 1;
			}
			continue;
		}
		route.steps.insert(at, *s);
		route.origin.insert(at, g);
		at += 1;
		put += 1;
	}
	put
}

/// A start's shared route: its own order to `join`, then the canonical tail; `map` takes the
/// tail's steps into the start's run (a step its run lacks is left out) and `offset` moves the
/// tail's origins past the start's own goals (they index the canonical start's goals, appended
/// after the start's).
pub fn joined(own: &Order, join: usize, tail: &Order, map: Option<(&Mapper, &crate::Run, &crate::Run)>, offset: i64) -> Order {
	let mut out = Order { steps: own.steps[..join].to_vec(), origin: own.origin[..join].to_vec() };
	for (s, &g) in tail.steps.iter().zip(&tail.origin) {
		let s = match map {
			Some((m, from, to)) => {
				let x = m.step(from, to, *s);
				if x.kind == crate::run::K_GRIND && s.kind != crate::run::K_GRIND {
					continue;
				}
				x
			}
			None => *s,
		};
		out.steps.push(s);
		out.origin.push(if g >= 0 { g + offset } else { g });
	}
	out
}

/// Per start and profile: hours to 60 with v1's chain, with the start's own best route, and
/// with its own route to the join point followed by the shared order.
#[derive(Clone, Debug, serde::Serialize)]
pub struct Row {
	pub start: String,
	pub profile: &'static str,
	pub join_level: f64,
	pub v1: f64,
	pub own: f64,
	pub shared: f64,
	pub lost: f64,
}

pub struct SharedResult {
	pub rows: Vec<Row>,
	pub order: Order,
	pub seed_sum: f64,
	pub best_sum: f64,
	pub stats: Stats,
	pub seconds: f64,
	pub own_seconds: f64,
}

/// Plan the shared route of a faction. `own_opts`: the per-start search (own best), `opts`: the
/// shared search.
/// `judge`: the game data and atlas for the guards and the insert eligibility (as `route`); the
/// own routes and the shared one are searched with guard=current and only eligible inserts.
pub fn shared_route(
	world: &World,
	walks: &dyn Walks,
	base: &Params,
	starts: &[Start],
	own_opts: &SearchOpts,
	opts: &SearchOpts,
	judge: Option<(&GameData, &Atlas, &rustc_hash::FxHashMap<u32, String>)>,
) -> Result<SharedResult, String> {
	let f = world.faction;
	let trio = Profile::trio(f);
	// Models: per start, per profile (slow, avg, fast); the same run for every profile.
	let mut models: Vec<Vec<Model>> = Vec::new();
	let mut rules = Vec::new();
	for s in starts {
		let mut v = Vec::new();
		for pr in &trio {
			let (m, r) = model_for(world, &s.race, pr, base, walks)?;
			if pr.name == "avg" {
				rules.push(r);
			}
			v.push(m);
		}
		models.push(v);
	}
	const AVG: usize = 1;
	// Each start's v1 seed and own best (average profile), and its join point.
	let t0 = std::time::Instant::now();
	let mut seeds = Vec::new();
	let mut owns = Vec::new();
	let mut joins = Vec::new();
	for (k, s) in starts.iter().enumerate() {
		let m = &models[k][AVG];
		let mut ev = m.evaluator(walks);
		let extra = crate::order::overrides_for(&m.run, &crate::order::overrides_doc()).pairs;
		let seed = crate::order::keep_pairs(&seed_order(&mut ev, &s.events, true), &extra);
		let pairs = deliberate_pairs(&m.run).into_iter().chain(extra).collect();
		let mut p = Problem::single(m, walks, pairs, eligible(world, m, &rules[k], &seed, judge));
		p.guard = guard_for(world, m, &rules[k], &seed, walks, judge);
		let out = search(&p, &seed, own_opts);
		let best = clean(&mut ev, &out.best);
		joins.push(join_point(&best, &s.goals));
		seeds.push(seed);
		owns.push(best);
	}
	let own_seconds = t0.elapsed().as_secs_f64();
	// The canonical order: the first start's own route from its join point.
	let canon = &models[0][AVG];
	let u0 = Order { steps: owns[0].steps[joins[0]..].to_vec(), origin: owns[0].origin[joins[0]..].to_vec() };
	let mut ctxs = Vec::new();
	for (k, s) in starts.iter().enumerate() {
		for (j, pr) in trio.iter().enumerate() {
			let m = &models[k][j];
			let map = if k == 0 { None } else { Some(Mapper::new(&canon.run, &m.run)) };
			ctxs.push(CtxSpec { model: m, prefix: owns[k].steps[..joins[k]].to_vec(), map, name: format!("{} {}", s.race, pr.name) });
		}
	}
	// The guards on the first start's whole route (its own part, then the shared order).
	let full0 = Order { steps: owns[0].steps.clone(), origin: owns[0].origin.clone() };
	let mut guard = guard_for(world, canon, &rules[0], &full0, walks, judge);
	// Only the trainings of the shared part are the shared order's to keep.
	if let Some(g) = guard.as_mut() {
		g.train_levels.retain(|(o, _)| u0.origin.contains(o));
	}
	let p = Problem {
		model: canon,
		walks,
		pairs: deliberate_pairs(&canon.run).into_iter().chain(crate::order::overrides_for(&canon.run, &crate::order::overrides_doc()).pairs).collect(),
		pool: eligible(world, canon, &rules[0], &u0, judge),
		ctxs,
		followers: followers(&canon.run),
		guard,
		feas: Default::default(),
		log_bound: u32::MAX,
	};
	let seed_sum: f64 = runs(&p, &u0).iter().map(|c| c.total).sum();
	let out = search(&p, &u0, opts);
	let best_runs = runs(&p, &out.best);
	let best_sum: f64 = best_runs.iter().map(|c| c.total).sum();
	let mut rows = Vec::new();
	for (k, s) in starts.iter().enumerate() {
		for (j, pr) in trio.iter().enumerate() {
			let m = &models[k][j];
			let mut ev = m.evaluator(walks);
			let v1 = evaluate(&mut ev, &seeds[k]);
			let own = evaluate(&mut ev, &owns[k]);
			let join_level = {
				let pre = Order { steps: owns[k].steps[..joins[k]].to_vec(), origin: Vec::new() };
				ev.reset();
				for &st in &pre.steps {
					ev.step(st);
				}
				ev.level_now()
			};
			let shared = best_runs[k * 3 + j].total;
			rows.push(Row { start: s.race.clone(), profile: pr.name, join_level, v1: v1 / 3600.0, own: own / 3600.0, shared: shared / 3600.0, lost: (shared - own) / 3600.0 });
		}
	}
	Ok(SharedResult { rows, order: out.best, seed_sum, best_sum, stats: out.stats, seconds: out.seconds, own_seconds })
}

fn eligible(world: &World, m: &Model, rules: &forge_world::Rules, seed: &Order, judge: Option<(&GameData, &Atlas, &rustc_hash::FxHashMap<u32, String>)>) -> Vec<u32> {
	let mut v = pool(&m.run, rules, seed, &m.tables);
	if let Some((d, _, doubt)) = judge {
		let ins = Insertable::new(world, &m.run, rules, d, &m.tables.q_full, doubt);
		v.retain(|&q| ins.ok(q));
	}
	v
}

fn guard_for(world: &World, m: &Model, rules: &forge_world::Rules, seed: &Order, walks: &dyn Walks, judge: Option<(&GameData, &Atlas, &rustc_hash::FxHashMap<u32, String>)>) -> Option<Guard> {
	let (d, a, _) = judge?;
	let data = GuardData::new(world, &m.run, rules, d, a);
	let cur = &runs(&Problem::single(m, walks, Vec::new(), Vec::new()), seed)[0];
	let v1 = cur.guard_counts(&data, &m.run);
	Some(Guard { data, mode: GuardMode::Current, v1, train_levels: crate::search::train_levels(seed, cur) })
}
