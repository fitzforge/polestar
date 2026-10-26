//! v1 improved with an edit budget: from v1's order, repeatedly apply the single best local
//! edit (steepest descent), recording the hours after each, so the gain-vs-edits curve shows
//! how few edits carry most of the gain and the order at its knee can be read edit by edit.
//!
//! Edits are local: a stop moved within its zone stay, a return's work folded into the
//! earlier (or later) visit to the same place, a passed-by quest inserted with every step in
//! the zone it is in, a quest that costs a trip dropped (v1's level checkpoints stay). Each is
//! checked like a search move (the order's rules, feasibility, guards) and scored by the same
//! windowed estimate, then the most promising are replayed exactly and the best kept.
//!
//! Adapted from Factoruide (MIT, by Joel, used with his permission): fg-route
//! src/plan/evaluate.rs (windowed estimate, exact replay) and src/plan/moves.rs (the local
//! operators); the steepest-descent loop is ours.

use super::{cheapest_k, d, locs, quest_rank, Member, Problem, MIN_GAIN, PASSED_BY_YD, WINDOW};
use crate::eval::Step;
use crate::order::{Order, INSERTED};
use crate::run::{K_ACCEPT, K_GRIND, K_TASK, K_TRAIN, K_TURNIN};

/// Yards: a stop this close to an earlier (or later) stop is the same place (a return).
pub const FOLD_YD: f64 = 200.0;
/// Positions tried per moved stop (the cheapest by straight detour).
pub const MOVE_TRIES: usize = 3;
/// Candidates replayed exactly per round (best estimates first).
pub const EXACT_PER_ROUND: usize = 32;
/// Most candidates replayed exactly in a round (batches of EXACT_PER_ROUND).
pub const EXACT_MAX: usize = 1024;
/// An edit must save at least this many seconds (shorter ones are not worth a reviewer's read).
pub const EDIT_MIN_GAIN: f64 = 10.0;
/// Steps after its accept an inserted quest's other steps may go.
pub const INSERT_REACH: usize = 200;

/// One local edit of an order (indices into the order before it).
#[derive(Clone, Debug)]
pub enum Mv {
	/// Steps s..=e removed and put back at `to` (an index into the order without them).
	Move { s: usize, e: usize, to: usize, kind: &'static str },
	/// A quest added: (index into the order as it grows, step) in insertion order.
	Insert { q: u32, at: Vec<(usize, Step)> },
	/// A quest's every step dropped.
	Drop { q: u32 },
	/// One step dropped (a grind checkpoint).
	DropStep { i: usize },
}

impl Mv {
	/// The order after the edit and the first and last changed index.
	pub fn apply(&self, o: &Order) -> Option<(Order, usize, usize)> {
		match self {
			Mv::Move { s, e, to, .. } => {
				let (s, e, to) = (*s, *e, *to);
				let mut steps = o.steps.clone();
				let mut origin = o.origin.clone();
				let block: Vec<Step> = steps.drain(s..=e).collect();
				let borg: Vec<i64> = origin.drain(s..=e).collect();
				if to > steps.len() || to == s {
					return None;
				}
				let n = block.len();
				for (k, (x, g)) in block.into_iter().zip(borg).enumerate() {
					steps.insert(to + k, x);
					origin.insert(to + k, g);
				}
				let a = s.min(to);
				let b = (e.max(to + n - 1)).min(steps.len() - 1);
				Some((Order { steps, origin }, a, b))
			}
			Mv::Insert { at, .. } => {
				let mut steps = o.steps.clone();
				let mut origin = o.origin.clone();
				let (mut a, mut b) = (usize::MAX, 0);
				for &(j, x) in at {
					if j > steps.len() {
						return None;
					}
					steps.insert(j, x);
					origin.insert(j, INSERTED);
					a = a.min(j);
					b = if j <= b { b + 1 } else { j };
				}
				Some((Order { steps, origin }, a, b))
			}
			Mv::Drop { q } => {
				let mut steps = Vec::with_capacity(o.len());
				let mut origin = Vec::with_capacity(o.len());
				let (mut a, mut b) = (usize::MAX, 0);
				for (k, s) in o.steps.iter().enumerate() {
					if s.q == *q && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN) {
						a = a.min(k);
						b = k;
						continue;
					}
					steps.push(*s);
					origin.push(o.origin[k]);
				}
				if a == usize::MAX {
					return None;
				}
				Some((Order { steps, origin }, a, b.saturating_sub(1).max(a)))
			}
			Mv::DropStep { i } => {
				let mut steps = o.steps.clone();
				let mut origin = o.origin.clone();
				steps.remove(*i);
				origin.remove(*i);
				Some((Order { steps, origin }, *i, *i))
			}
		}
	}
}

/// One kept edit: what it did, its seconds saved, the hours to 60 after it.
#[derive(Clone, Debug)]
pub struct Edit {
	pub mv: Mv,
	/// The order before the edit (for describing it).
	pub before: Order,
	pub lv: Vec<f64>,
	pub saved: f64,
	pub hours: f64,
}

/// The greedy descent's result: the edits in the order made, and the order after each.
pub struct Descent {
	pub start_hours: f64,
	pub edits: Vec<Edit>,
	pub orders: Vec<Order>,
	pub seconds: f64,
}

/// Zone stays: per step, the first and last index of its run of steps on one map.
fn stays(run: &crate::run::Run, loc: &[u32]) -> Vec<(usize, usize)> {
	let n = loc.len();
	let mut out = vec![(0, 0); n];
	let mut s = 0;
	for i in 0..=n {
		if i == n || (i > s && run.p_map[loc[i] as usize] != run.p_map[loc[s] as usize]) {
			for x in out.iter_mut().take(i).skip(s) {
				*x = (s, i - 1);
			}
			s = i;
		}
	}
	out
}

/// Every local edit of the member's order.
fn candidates(p: &Problem, m: &Member) -> Vec<Mv> {
	let run = &p.model.run;
	let o = &m.order;
	let n = o.len();
	let live = m.live.min(n);
	let loc = locs(run, &o.steps);
	let st = stays(run, &loc);
	let mut out = Vec::new();
	let is_quest = |s: &Step| matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN);
	// Bounds of a quest step's own order: after its earlier-rank steps, before its later ones.
	let bounds = |i: usize, lo: usize, hi: usize| -> (usize, usize) {
		let s = o.steps[i];
		let (mut lo, mut hi) = (lo, hi);
		if is_quest(&s) {
			for j in (lo..i).rev() {
				if o.steps[j].q == s.q && is_quest(&o.steps[j]) && quest_rank(o.steps[j].kind) < quest_rank(s.kind) {
					lo = j + 1;
					break;
				}
			}
			for j in i + 1..=hi.min(n - 1) {
				if o.steps[j].q == s.q && is_quest(&o.steps[j]) && quest_rank(o.steps[j].kind) > quest_rank(s.kind) {
					hi = j - 1;
					break;
				}
			}
		}
		(lo, hi)
	};
	for i in 0..live {
		let s = o.steps[i];
		if !(is_quest(&s) || s.kind == K_TRAIN) {
			continue;
		}
		// Within the zone stay.
		let (zs, ze) = st[i];
		let (lo, hi) = bounds(i, zs, ze);
		if hi > lo {
			let mut rest = o.steps.clone();
			rest.remove(i);
			let rl = locs(run, &rest);
			for to in cheapest_k(run, &rest, &rl, s.pt, lo, hi.min(rest.len()), MOVE_TRIES) {
				if to != i {
					out.push(Mv::Move { s: i, e: i, to, kind: "move" });
				}
			}
		}
		if !is_quest(&s) {
			continue;
		}
		// Fold into the latest earlier visit to the same place (before this stay), alone and with
		// the steps at this place around it.
		let here = |k: usize| o.steps[k].kind != K_GRIND && d(run, loc[k], s.pt) <= FOLD_YD;
		let mut bs = i;
		while bs > zs && here(bs - 1) {
			bs -= 1;
		}
		let mut be = i;
		while be < ze && be + 1 < live && here(be + 1) {
			be += 1;
		}
		if let Some(j) = (0..zs).rev().find(|&j| o.steps[j].kind != K_GRIND && d(run, loc[j], s.pt) <= FOLD_YD) {
			out.push(Mv::Move { s: i, e: i, to: j + 1, kind: "fold" });
			if be > bs && i == bs {
				out.push(Mv::Move { s: bs, e: be, to: j + 1, kind: "fold" });
			}
		}
		// Or into the next later visit (after this stay).
		if let Some(j) = (ze + 1..live).find(|&j| o.steps[j].kind != K_GRIND && d(run, loc[j], s.pt) <= FOLD_YD) {
			out.push(Mv::Move { s: i, e: i, to: j - 1, kind: "fold later" });
			if be > bs && i == bs {
				out.push(Mv::Move { s: bs, e: be, to: j - (be - bs + 1), kind: "fold later" });
			}
		}
	}
	// Drops: a quest that costs a trip (not every stop on the way), a grind checkpoint.
	let mut seen = vec![false; run.n_quests()];
	for i in 0..live {
		let s = o.steps[i];
		// v1's level checkpoints stay: they are gates for what follows (a class chain at 20 in
		// Orgrimmar) that the model cannot see.
		if s.kind == K_ACCEPT && !seen[s.q as usize] {
			seen[s.q as usize] = true;
			if !p.feas.keep.contains(&s.q) && !super::on_the_way(run, &o.steps, s.q) {
				out.push(Mv::Drop { q: s.q });
			}
		}
	}
	// Inserts: a passed-by quest, each later step at its cheapest place in its own zone.
	for &q in &p.pool {
		if m.in_order[q as usize] {
			continue;
		}
		if let Some(mv) = insertion(p, m, q, &loc, live, 0) {
			out.push(mv);
		}
	}
	// No objective moved earlier to where the character is more than UNDER_LEVEL below the
	// quest's level (the Daggerspine naga, 30-31, at 26; Miner Hackett, 29, at 25).
	out.retain(|mv| match *mv {
		Mv::Move { s, e, to, .. } => {
			let dest = if to <= s { to } else { to + (e - s + 1) };
			let lv_dest = m.lv.get(dest).copied().unwrap_or(60.0);
			(s..=e).all(|k| {
				let x = o.steps[k];
				x.kind != K_TASK || lv_dest >= m.lv[k] || lv_dest >= run.q_level[x.q as usize] as f64 - UNDER_LEVEL
			})
		}
		_ => true,
	});
	out
}

/// Yards a moved stop may add to the straight walk over the stretch it changes: a reviewer
/// walks the guide by its straight legs, and a move that lengthens them splits a visit
/// (Molsen Farm, Stone Cairn Lake, the second Darkshore loop) whatever the model's walks say.
pub const PATH_SLACK_YD: f64 = 100.0;

/// The straight walk (yards; a crossing between regions counts FAR_YD) over steps lo..=hi,
/// from the place before lo.
fn path_len(run: &crate::run::Run, steps: &[Step], lo: usize, hi: usize) -> f64 {
	let mut at = steps[..lo].iter().rev().find(|x| x.kind != K_GRIND).map_or(run.start_pt, |x| x.pt);
	let mut sum = 0.0;
	for x in &steps[lo..=hi.min(steps.len() - 1)] {
		if x.kind == K_GRIND {
			continue;
		}
		sum += d(run, at, x.pt);
		at = x.pt;
	}
	sum
}

/// Levels under a quest's level an objective may be moved earlier to (no lower).
pub const UNDER_LEVEL: f64 = 2.0;

/// Accept places tried per later-steps rank in insertion's `nth`.
pub const ACCEPT_RANKS: usize = 3;

/// Straight yards from point g to the segment a-b (to a when they are in other regions).
pub(super) fn seg_dist(run: &crate::run::Run, a: u32, b: u32, g: u32) -> f64 {
	let (a, b, g) = (a as usize, b as usize, g as usize);
	if run.p_r[a] != run.p_r[g] {
		return f64::INFINITY;
	}
	if run.p_r[b] != run.p_r[a] {
		return (run.p_x[a] - run.p_x[g]).hypot(run.p_y[a] - run.p_y[g]);
	}
	let (dx, dy) = (run.p_x[b] - run.p_x[a], run.p_y[b] - run.p_y[a]);
	let l2 = dx * dx + dy * dy;
	let t = if l2 > 0.0 { (((run.p_x[g] - run.p_x[a]) * dx + (run.p_y[g] - run.p_y[a]) * dy) / l2).clamp(0.0, 1.0) } else { 0.0 };
	(run.p_x[a] + t * dx - run.p_x[g]).hypot(run.p_y[a] + t * dy - run.p_y[g])
}

/// A quest's insertion: the accept at the cheapest stop passing its giver where the level
/// allows it; each site, then the turn-in, at the cheapest place within INSERT_REACH after it
/// between two steps in the step's own zone.
pub(super) fn insertion(p: &Problem, m: &Member, q: u32, loc: &[u32], live: usize, nth: usize) -> Option<Mv> {
	let run = &p.model.run;
	let qi = q as usize;
	let giver = run.q_giver[qi];
	let mut all: Vec<(f64, usize)> = Vec::new();
	for j in 1..live {
		// The leg into step j passes the giver (the guards' passed-by: any point of the leg).
		let dd = d(run, loc[j - 1], giver);
		if seg_dist(run, loc[j - 1], loc[j], giver) > PASSED_BY_YD || !Member::level_ok(p, qi, m.lv[j]) {
			continue;
		}
		let c = dd + d(run, giver, loc[j]) - d(run, loc[j - 1], loc[j]);
		all.push((c, j));
	}
	all.sort_by(|a, b| a.0.total_cmp(&b.0).then(a.1.cmp(&b.1)));
	// nth: the accept's rank (nth % ACCEPT_RANKS) and the later steps' rank (nth / ACCEPT_RANKS).
	let best = *all.get(nth % ACCEPT_RANKS)?;
	let later = nth / ACCEPT_RANKS;
	let quest = crate::seq::quest_steps(run, q);
	let mut steps = m.order.steps.clone();
	let acc = best.1;
	steps.insert(acc, quest[0]);
	let mut at = vec![(acc, quest[0])];
	let mut latest = acc;
	for &x in &quest[1..] {
		let l = locs(run, &steps);
		let lo = if x.kind == K_TASK { acc + 1 } else { latest + 1 };
		let hi = (lo + INSERT_REACH).min(steps.len());
		let map = run.p_map[x.pt as usize];
		let mut cands: Vec<(f64, usize)> = Vec::new();
		for j in lo.min(steps.len())..=hi {
			let prev = l[j - 1];
			if run.p_map[prev as usize] != map {
				continue;
			}
			let c = if j == steps.len() { d(run, prev, x.pt) } else { d(run, prev, x.pt) + d(run, x.pt, l[j]) - d(run, prev, l[j]) };
			cands.push((c, j));
		}
		cands.sort_by(|a, b| a.0.total_cmp(&b.0).then(a.1.cmp(&b.1)));
		let j = cands.get(later).or(cands.first()).map_or(usize::MAX, |x| x.1);
		if j == usize::MAX {
			return None;
		}
		steps.insert(j, x);
		at.push((j, x));
		if j <= latest {
			latest += 1;
		}
		if x.kind == K_TASK {
			latest = latest.max(j);
		}
	}
	Some(Mv::Insert { q, at })
}

/// Trainings right after a training (only grind checkpoints between): the second learns nothing.
pub(super) fn twin_trainings(o: &Order) -> usize {
	let mut last = u8::MAX;
	let mut n = 0;
	for s in &o.steps {
		if s.kind == K_GRIND {
			continue;
		}
		if s.kind == K_TRAIN && last == K_TRAIN {
			n += 1;
		}
		last = s.kind;
	}
	n
}

impl<'a> Member<'a> {
	/// The estimated seconds a candidate saves (None: breaks a rule or past the end).
	fn est_gain(&mut self, p: &Problem, cand: &Order, a: usize, b: usize) -> Option<f64> {
		if a >= self.live || !self.check.valid(&cand.steps, &p.pairs, &p.feas) || twin_trainings(cand) > twin_trainings(&self.order) {
			return None;
		}
		// Same steps reordered (a move): no longer straight walk over the stretch it changes.
		if cand.len() == self.order.len() {
			let run = &p.model.run;
			let hi = (b + 1).min(cand.len() - 1);
			if path_len(run, &cand.steps, a, hi) > path_len(run, &self.order.steps, a, hi) + PATH_SLACK_YD {
				return None;
			}
		}
		let now = self.total();
		let mut est = 0.0;
		for (k, c) in self.ctxs.iter_mut().enumerate() {
			let steps = p.steps_for(k, &cand.steps);
			let (_, e) = c.window(steps, a + c.off, b + c.off + WINDOW, &mut self.stats);
			est += e?;
		}
		Some(now - est)
	}
}

#[cfg(feature = "native")]
fn par_each<T: Send, F: Fn(&mut Member, usize) -> T + Sync>(ms: &mut [Member], n: usize, f: F) -> Vec<T> {
	use rayon::prelude::*;
	let k = ms.len();
	let mut parts: Vec<Vec<(usize, T)>> = ms.par_iter_mut().enumerate().map(|(w, m)| (w..n).step_by(k).map(|i| (i, f(m, i))).collect()).collect();
	let mut all: Vec<(usize, T)> = parts.drain(..).flatten().collect();
	all.sort_by_key(|x| x.0);
	all.into_iter().map(|x| x.1).collect()
}

#[cfg(not(feature = "native"))]
fn par_each<T, F: Fn(&mut Member, usize) -> T>(ms: &mut [Member], n: usize, f: F) -> Vec<T> {
	(0..n).map(|i| f(&mut ms[0], i)).collect()
}

/// Steepest descent from `seed` with local edits, at most `max_edits`; `workers` members
/// share the candidates (the result is the same for any number).
///
/// `no_worse`: an edit is kept only when no character's hours to 60 rise (the shared route: an
/// edit that helps one start must not slow another sharing the guide).
pub fn descend(p: &Problem, seed: &Order, max_edits: usize, workers: usize, no_worse: bool, log: &mut dyn FnMut(usize, f64, &str)) -> Descent {
	let t0 = std::time::Instant::now();
	let start = super::runs(p, seed);
	let mut ms: Vec<Member> = (0..workers.max(1)).map(|k| Member::new(p, seed.clone(), &start, k as u64)).collect();
	let start_hours = ms[0].total() / 3600.0;
	let mut edits = Vec::new();
	let mut orders = Vec::new();
	while edits.len() < max_edits {
		let cands = candidates(p, &ms[0]);
		let ests: Vec<Option<f64>> = par_each(&mut ms, cands.len(), |m, i| {
			let (o, a, b) = cands[i].apply(&m.order)?;
			m.est_gain(p, &o, a, b)
		});
		let mut ranked: Vec<(usize, f64)> = ests.iter().enumerate().filter_map(|(i, e)| e.filter(|&g| g > MIN_GAIN).map(|g| (i, g))).collect();
		ranked.sort_by(|x, y| y.1.total_cmp(&x.1).then(x.0.cmp(&y.0)));
		ranked.truncate(EXACT_MAX);
		let now = ms[0].total();
		// Exact replays a batch at a time down the estimates, until a batch holds a kept edit.
		let mut found = None;
		for lo in (0..ranked.len()).step_by(EXACT_PER_ROUND) {
			let batch = &ranked[lo..(lo + EXACT_PER_ROUND).min(ranked.len())];
			let exact: Vec<Option<f64>> = par_each(&mut ms, batch.len(), |m, k| {
				let (o, a, b) = cands[batch[k].0].apply(&m.order)?;
				let (next, _) = m.replay(p, &o, a, b)?;
				if no_worse && next.iter().zip(&m.ctxs).any(|(n, c)| n.total > c.cur.total + 1e-6) {
					return None;
				}
				Some(now - next.iter().map(|c| c.total).sum::<f64>())
			});
			if let Some((k, g)) = exact.iter().enumerate().filter_map(|(k, g)| g.filter(|&g| g >= EDIT_MIN_GAIN).map(|g| (k, g))).max_by(|x, y| x.1.total_cmp(&y.1).then(y.0.cmp(&x.0))) {
				found = Some((batch[k].0, g));
				break;
			}
		}
		let Some((ci, gain)) = found else { break };
		let mv = cands[ci].clone();
		let m0 = &mut ms[0];
		let (o, a, b) = mv.apply(&m0.order).expect("candidate applies");
		let (next, gc) = m0.replay(p, &o, a, b).expect("exact gain repeats");
		let before = m0.order.clone();
		let lv = m0.lv.clone();
		m0.guard_now = gc;
		for (c, cur) in m0.ctxs.iter_mut().zip(next) {
			c.cur = cur;
		}
		m0.order = o;
		m0.refresh();
		let hours = m0.total() / 3600.0;
		let (head, rest) = ms.split_at_mut(1);
		for m in rest {
			m.take(&head[0]);
		}
		log(
			edits.len() + 1,
			hours,
			match &mv {
				Mv::Move { kind, .. } => kind,
				Mv::Insert { .. } => "insert",
				Mv::Drop { .. } => "drop",
				Mv::DropStep { .. } => "drop grind",
			},
		);
		orders.push(ms[0].order.clone());
		edits.push(Edit { mv, before, lv, saved: gain, hours });
	}
	Descent { start_hours, edits, orders, seconds: t0.elapsed().as_secs_f64() }
}

/// Edits needed for each share of the descent's gain (the first edit count reaching it).
pub fn edits_for(d: &Descent, share: f64) -> usize {
	let total = d.start_hours - d.edits.last().map_or(d.start_hours, |e| e.hours);
	d.edits.iter().position(|e| d.start_hours - e.hours >= share * total - 1e-9).map_or(0, |k| k + 1)
}

/// The knee of the gain-vs-edits curve (Kneedle: the most gain above the straight line from
/// no edits to all of them).
pub fn knee(d: &Descent) -> usize {
	let n = d.edits.len();
	if n == 0 {
		return 0;
	}
	let total = d.start_hours - d.edits[n - 1].hours;
	if total <= 0.0 {
		return 0;
	}
	(1..=n)
		.max_by(|&a, &b| {
			let f = |k: usize| (d.start_hours - d.edits[k - 1].hours) / total - k as f64 / n as f64;
			f(a).total_cmp(&f(b)).then(b.cmp(&a))
		})
		.unwrap_or(0)
}
