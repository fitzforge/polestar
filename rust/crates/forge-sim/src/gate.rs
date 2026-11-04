//! The accept level rule: no quest is accepted where the model's level is under its minimum
//! (`Run::q_min_level`, the world's `minLevel`). The game refuses the quest there, so a player at the
//! route's level is held at the giver (c19r: Lazy Peons 5441, minimum 3, taken at the Den at 2.6
//! after the c17 `together 4402/5441` record moved it to Galgar's accept; the evaluator ground the
//! 0.4 level there unseen). Every placement keeps it: the record repairs (order::keep_records), every
//! search, edit and pass move (search::Member::replay refuses a move that takes a quest under its
//! minimum where the order did not), and the pass search::passby::accept_gates for what is left.
//! A moved accept goes to the first later place that meets the level and picks up its giver (a stop
//! at its hub or a leg passing it), never past its quest's first objective or hand-in ([`later_places`]).

use crate::eval::{Evaluator, Step};
use crate::run::{Run, K_ACCEPT, K_GRIND, K_TASK, K_TURNIN};

/// Level slack under the minimum (the replay's fractions only).
pub const EPS: f64 = 1e-6;
/// Later places replayed at most for one accept moved by the rule (the first ones that pass
/// [`later_places`]'s level and giver test).
pub const PLACES_TRIED: usize = 8;

/// Whether step `s`, played at level `lv`, accepts its quest under its minimum level.
pub fn is_under(run: &Run, s: &Step, lv: f64) -> bool {
	s.kind == K_ACCEPT && lv + EPS < f64::from(run.q_min_level[s.q as usize])
}

/// The quests (ids, sorted) an order's run accepts under their minimum level: `lv[i]` is the level
/// before step i (search::Current::levels, [`levels`]).
pub fn under_min(run: &Run, steps: &[Step], lv: &[f64]) -> Vec<u32> {
	let mut v: Vec<u32> = steps.iter().zip(lv).filter(|(s, &l)| is_under(run, s, l)).map(|(s, _)| run.q_id[s.q as usize]).collect();
	v.sort_unstable();
	v.dedup();
	v
}

/// The level before each step of `steps`, played from the start.
pub fn levels(ev: &mut Evaluator, steps: &[Step]) -> Vec<f64> {
	ev.reset();
	let mut lv = Vec::with_capacity(steps.len());
	for i in 0..steps.len() {
		lv.push(ev.level_now());
		if !ev.s.finished {
			ev.step_in(steps, i);
		}
	}
	lv
}

/// Straight yards from point `g` to the leg a→b (infinite across regions).
fn leg_dist(run: &Run, a: u32, b: u32, g: u32) -> f64 {
	let (a, b, g) = (a as usize, b as usize, g as usize);
	if run.p_r[a] != run.p_r[g] || run.p_r[b] != run.p_r[g] {
		return f64::INFINITY;
	}
	let (dx, dy) = (run.p_x[b] - run.p_x[a], run.p_y[b] - run.p_y[a]);
	let l2 = dx * dx + dy * dy;
	let t = if l2 > 0.0 { (((run.p_x[g] - run.p_x[a]) * dx + (run.p_y[g] - run.p_y[a]) * dy) / l2).clamp(0.0, 1.0) } else { 0.0 };
	(run.p_x[g] - run.p_x[a] - t * dx).hypot(run.p_y[g] - run.p_y[a] - t * dy)
}

/// Whether an accept at giver point `g` put before `steps[j]` is a pickup there: the stop before
/// it or the one after it is at the giver's hub (hubs::HUB_YD), or the leg between them passes it
/// (hubs::PAST_YD).
pub fn picks_up(run: &Run, steps: &[Step], j: usize, g: u32) -> bool {
	let prev = steps[..j].iter().rev().find(|s| s.kind != K_GRIND).map_or(run.start_pt, |s| s.pt);
	let next = steps[j..].iter().find(|s| s.kind != K_GRIND).map(|s| s.pt);
	let near = |p: u32| run.straight(p, g) <= crate::hubs::HUB_YD;
	near(prev) || next.is_some_and(|n| near(n) || leg_dist(run, prev, n, g) <= crate::hubs::PAST_YD)
}

/// The places (insertion indices into `rest`, the order without the accept that stood at `i`) an
/// accept of quest `q` at giver point `g` may go instead, first first: after `i`, no later than
/// its quest's first objective or hand-in in `rest`, where `level_ok(j)` holds (every character's
/// level before `rest[j]` meets its minimum) and the place picks up its giver ([`picks_up`]).
pub fn later_places(run: &Run, rest: &[Step], i: usize, q: u32, g: u32, level_ok: &dyn Fn(usize) -> bool) -> Vec<usize> {
	let last = rest.iter().enumerate().skip(i).find(|(_, s)| s.q == q && matches!(s.kind, K_TASK | K_TURNIN)).map_or(rest.len(), |(k, _)| k);
	(i + 1..=last).filter(|&j| level_ok(j) && picks_up(run, rest, j, g)).collect()
}

/// One accept under its minimum level in a written route's `order` (routes/<Start>.json).
#[derive(Clone, Debug, PartialEq)]
pub struct Under {
	/// Index in `order`.
	pub i: usize,
	pub q: u32,
	pub lvl: f64,
	pub min: f64,
	/// The entry's `from` (its guide line, or inserted).
	pub from: String,
}

/// The accepts of a route's `order` (each entry's `t`, `q`, and `lvl`: the model's level before
/// it) under their quest's minimum level in `world` (`sim route --audit`).
pub fn audit_order(world: &forge_world::World, order: &[serde_json::Value]) -> Vec<Under> {
	let min: rustc_hash::FxHashMap<u32, f64> = world.quests.iter().map(|q| (q.id, q.min_level)).collect();
	order
		.iter()
		.enumerate()
		.filter(|(_, e)| e["t"] == "accept")
		.filter_map(|(i, e)| {
			let q = u32::try_from(e["q"].as_u64()?).ok()?;
			let lvl = e["lvl"].as_f64()?;
			let m = *min.get(&q)?;
			(lvl + EPS < m).then(|| Under { i, q, lvl, min: m, from: e["from"].as_str().unwrap_or("").to_string() })
		})
		.collect()
}
