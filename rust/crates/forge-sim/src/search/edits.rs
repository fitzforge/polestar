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
use crate::resume::{DescentCk, Pick, Unit, DESCENT};
use crate::run::{K_ACCEPT, K_GRIND, K_TASK, K_TRAIN, K_TURNIN, K_VISIT};

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
/// A zone stay moved later ("stay later") has at least this many quest steps, and goes past at
/// most STAY_LATER_MAX of the next stays that have as many (a town stop between does not count),
/// and STAY_LATER_REACH stays in all.
pub const STAY_MIN_STEPS: usize = 6;
pub const STAY_LATER_MAX: usize = 4;
pub const STAY_LATER_REACH: usize = 12;
/// The edit kind of a zone stay moved later: it keeps every stay whole, so the straight-walk
/// rule for reorders (PATH_SLACK_YD, against a visit split by a longer leg) does not hold it;
/// the model prices its travel.
pub const STAY_LATER: &str = "stay later";
/// The edit kind of a zone's low quests done earlier as their own visit ("stay split"): quests
/// every step of which is in one zone stay and that are STAY_SPLIT_UNDER or more levels under the
/// character there, at least STAY_SPLIT_MIN of them, moved together (in their order) to the start
/// of one of the first STAY_SPLIT_PLACES earlier stays where none of them is more than UNDER_LEVEL
/// above the character. Like STAY_LATER, not held to the straight-walk rule.
pub const STAY_SPLIT: &str = "stay split";
pub const STAY_SPLIT_UNDER: f64 = 3.0;
pub const STAY_SPLIT_MIN: usize = 3;
pub const STAY_SPLIT_PLACES: usize = 3;
/// The edit kind of a gate checkpoint (a v1 grind that guards an accept) moved to just before the
/// first accept it gates, when no training or other grind is between.
pub const GATE_LATER: &str = "gate later";

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
	/// A quest's steps taken out and put back (indices into the order without them, in
	/// insertion order): its accept on an earlier visit to its giver, its work beside another
	/// quest's work on the same ground, its turn-in on the next visit to its ender (join).
	Join { q: u32, at: Vec<(usize, Step)> },
	/// The steps s..s+perm.len() in a new order: the k-th is the old step s+perm[k] (a hub
	/// visit's stops in the order of the shortest walk through them: hubs::loop_order).
	Reorder { s: usize, perm: Vec<usize> },
	/// Edits made in turn as one (`kind` names it): a quest inserted with the quests it opens
	/// (`chain insert`), a zone's open chains as one visit (`zone block`), the quests of a trip
	/// off the continent dropped together (`drop trip`), a hub return's steps folded into the
	/// next visit (`hub batch`).
	Seq { kind: &'static str, mvs: Vec<Mv> },
}

impl Mv {
	/// The edit's kind as the edit list names it.
	pub fn kind(&self) -> &'static str {
		match self {
			Mv::Move { kind, .. } => kind,
			Mv::Insert { .. } => "insert",
			Mv::Join { .. } => "join",
			Mv::Drop { .. } => "drop",
			Mv::DropStep { .. } => "drop grind",
			Mv::Reorder { .. } => "hub loop",
			Mv::Seq { kind, .. } => kind,
		}
	}
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
			Mv::Join { q, at } => {
				let mine = |s: &Step| s.q == *q && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN);
				let (mut steps, mut origin) = (Vec::with_capacity(o.len()), Vec::with_capacity(o.len()));
				let mut taken: Vec<(Step, i64)> = Vec::new();
				let (mut a, mut b) = (usize::MAX, 0);
				for (k, s) in o.steps.iter().enumerate() {
					if mine(s) {
						taken.push((*s, o.origin[k]));
						a = a.min(k);
						b = k;
					} else {
						steps.push(*s);
						origin.push(o.origin[k]);
					}
				}
				for &(j, x) in at {
					let k = taken.iter().position(|t| t.0.kind == x.kind && t.0.task == x.task)?;
					let (x, g) = taken.swap_remove(k);
					if j > steps.len() {
						return None;
					}
					steps.insert(j, x);
					origin.insert(j, g);
					a = a.min(j);
					b = b.max(j);
				}
				if !taken.is_empty() || a == usize::MAX {
					return None;
				}
				Some((Order { steps, origin }, a, b.min(o.len() - 1)))
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
			Mv::Reorder { s, perm } => {
				let n = perm.len();
				if n == 0 || s + n > o.len() {
					return None;
				}
				let mut c = o.clone();
				for (k, &v) in perm.iter().enumerate() {
					c.steps[s + k] = o.steps[*s + v];
					c.origin[s + k] = o.origin[*s + v];
				}
				Some((c, *s, s + n - 1))
			}
			Mv::Seq { mvs, .. } => {
				let mut c = o.clone();
				let (mut a, mut b) = (usize::MAX, 0);
				for mv in mvs {
					let (next, x, y) = mv.apply(&c)?;
					c = next;
					(a, b) = (a.min(x), b.max(y));
				}
				if a == usize::MAX || c.is_empty() {
					return None;
				}
				// (Later edits' indices are in the order as it grew: the last changed index is at most
				// the latest one plus the steps the order gained.)
				let b = (b + c.len().saturating_sub(o.len())).min(c.len() - 1).max(a.min(c.len() - 1));
				let a = a.min(c.len() - 1);
				Some((c, a, b))
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
	/// The descent stopped at its cap (`max_edits`) with gain maybe left: the cap was binding.
	pub capped: bool,
}

/// Where a route cuts its descent: after every edit it made (`All`, the default: every edit saves at
/// least EDIT_MIN_GAIN, and the route check gates what is written), or at the knee of the
/// gain-vs-edits curve (`Knee`: the fewest edits for most of the gain, for a short review).
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub enum Cut {
	Knee,
	#[default]
	All,
}

impl Cut {
	pub fn parse(s: &str) -> Option<Cut> {
		match s {
			"knee" => Some(Cut::Knee),
			"all" => Some(Cut::All),
			_ => None,
		}
	}

	pub fn name(self) -> &'static str {
		match self {
			Cut::Knee => "knee",
			Cut::All => "all",
		}
	}
}

/// The edits a route keeps: `budget` when given, else as `cut` says (the knee, or every edit).
pub fn cut_at(d: &Descent, budget: Option<usize>, cut: Cut) -> usize {
	budget
		.unwrap_or_else(|| match cut {
			Cut::Knee => knee(d),
			Cut::All => d.edits.len(),
		})
		.min(d.edits.len())
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
		if !(is_quest(&s) || s.kind == K_TRAIN || s.kind == crate::run::K_RIDE) {
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
	// Drops: a quest that costs a trip (not every stop on the way), a grind checkpoint that guards
	// no gate (Feas::free_grinds; the others are gates for what follows that the model cannot see,
	// a class chain at 20 in Orgrimmar).
	let mut seen = vec![false; run.n_quests()];
	for i in 0..live {
		let s = o.steps[i];
		if s.kind == K_ACCEPT && !seen[s.q as usize] {
			seen[s.q as usize] = true;
			if !p.feas.keep.contains(&s.q) && !super::on_the_way(run, &o.steps, s.q) {
				out.push(Mv::Drop { q: s.q });
			}
		}
		if s.kind == K_GRIND && p.feas.free_grinds.contains(&o.origin[i]) {
			out.push(Mv::DropStep { i });
		}
	}
	out.extend(gate_moves(p, m));
	// The quests of a trip off the continent for quests well under the character, together.
	out.extend(trip_drops(p, m));
	// Inserts: a passed-by quest, each later step at its cheapest place in its own zone; with the
	// quests it opens (a chain, valued together); a zone's open chains as one visit.
	for &q in &p.pool {
		if m.in_order[q as usize] {
			continue;
		}
		if let Some(mv) = insertion(p, m, q, &loc, live, 0) {
			out.push(mv);
		}
		if p.followers[q as usize].iter().any(|f| !m.in_order[*f as usize]) {
			if let Some(mv) = chain_insertion(p, o, &m.lv, live, q) {
				out.push(mv);
			}
		}
	}
	out.extend(zone_blocks(p, m));
	// Joins: a quest taken on an earlier visit to its giver, its work beside work on its ground.
	out.extend(joins(p, m));
	// Riding learned on the first visit to its trainer at the mount level or above.
	if let Some(i) = o.steps.iter().position(|s| s.kind == crate::run::K_RIDE) {
		let pt = o.steps[i].pt;
		let mount = p.model.tables.p.mount_level;
		if let Some(j) = (0..live).find(|&j| j != i && o.steps[j].kind != K_GRIND && m.lv.get(j + 1).is_some_and(|&l| l >= mount) && d(run, loc[j], pt) <= crate::route::RIDE_VISIT_YD) {
			let to = if j < i { j + 1 } else { j };
			if to != i {
				out.push(Mv::Move { s: i, e: i, to, kind: "ride" });
			}
		}
	}
	out.extend(stay_moves(p, m));
	// No objective moved earlier to where the character is more than UNDER_LEVEL below the
	// quest's level (the Daggerspine naga, 30-31, at 26; Miner Hackett, 29, at 25).
	out.retain(|mv| match *mv {
		Mv::Move { s, e, to, kind } => {
			let dest = if to <= s { to } else { to + (e - s + 1) };
			let lv_dest = m.lv.get(dest).copied().unwrap_or(60.0);
			// A stay moved later brings the stays it passes earlier, without its levels.
			let gain = m.lv.get(e + 1).copied().unwrap_or(60.0) - m.lv[s];
			let passed_ok = kind != STAY_LATER
				|| (e + 1..dest).all(|k| {
					let x = o.steps[k];
					x.kind != K_TASK || m.lv[k] - gain >= run.q_level[x.q as usize] as f64 - UNDER_LEVEL
				});
			passed_ok
				&& (s..=e).all(|k| {
					let x = o.steps[k];
					x.kind != K_TASK || lv_dest >= m.lv[k] || lv_dest >= run.q_level[x.q as usize] as f64 - UNDER_LEVEL
				})
		}
		_ => true,
	});
	out
}

/// Zone order edits (the route benchmark's 30-40, where the 100-yard straight-walk rule held every
/// reorder to v1's zone order): `stay later` and `stay split`, unfiltered (candidates holds them
/// to the under-level rule).
pub fn stay_moves(p: &Problem, m: &Member) -> Vec<Mv> {
	let run = &p.model.run;
	let o = &m.order;
	let live = m.live.min(o.len()).min(m.lv.len());
	let loc = locs(run, &o.steps);
	let st = stays(run, &loc);
	let is_quest = |s: &Step| matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN);
	let mut out = Vec::new();
	if live < 2 {
		return out;
	}
	// A zone stay moved later, past the next stays: a zone entered when its quests are on level,
	// not three levels early with a grind before them (the route benchmark's 30-40: Desolace at
	// 30.0 and Stranglethorn at 33.5, 288 and 410 model minutes of grind, where a benchmark guide
	// goes at 33.2 and 35.3 after Hillsbrad, Arathi and the Shimmering Flats).
	let mut runs_of: Vec<(usize, usize)> = Vec::new();
	let mut k = 0;
	while k < live {
		let (zs, ze) = st[k];
		runs_of.push((zs, ze.min(live - 1)));
		k = ze + 1;
	}
	let big = |(s, e): (usize, usize)| (s..=e).filter(|&k| is_quest(&o.steps[k])).count() >= STAY_MIN_STEPS;
	for (bi, &(zs, ze)) in runs_of.iter().enumerate() {
		if !big((zs, ze)) {
			continue;
		}
		// Past the next stays, up to STAY_LATER_MAX big ones: a town stop between two zones (a
		// flight master, a hand-in) does not count (the Plaguelands at 52.4 against Felwood and
		// Winterspring after them, Thunder Bluff and Orgrimmar between).
		let mut passed = 0;
		for &(ns, ne) in runs_of.iter().skip(bi + 1).take(STAY_LATER_REACH) {
			out.push(Mv::Move { s: zs, e: ze, to: ne + 1 - (ze - zs + 1), kind: STAY_LATER });
			passed += usize::from(big((ns, ne)));
			if passed >= STAY_LATER_MAX {
				break;
			}
		}
	}
	// A zone's quests far under the character where the route does them (STAY_SPLIT_UNDER levels or
	// more: their XP cut, or grey soon), done earlier as their own visit where they are on level (the
	// route benchmark's 30-40: a benchmark guide does Arathi's low half at 31-32 and its high half
	// at 38; our c12 Orc all of it at 38.3, its quests handed in 2.7 levels over theirs).
	for (bi, &(zs, ze)) in runs_of.iter().enumerate() {
		let l0 = m.lv[zs];
		let mut low: Vec<u32> = Vec::new();
		for k in zs..=ze {
			let s = o.steps[k];
			if s.kind != K_ACCEPT || low.contains(&s.q) || (run.q_level[s.q as usize] as f64) > l0 - STAY_SPLIT_UNDER {
				continue;
			}
			let all_here = o.steps.iter().enumerate().all(|(j, x)| x.q != s.q || !is_quest(x) || (zs..=ze).contains(&j));
			if all_here {
				low.push(s.q);
			}
		}
		if low.len() < STAY_SPLIT_MIN {
			continue;
		}
		let ks: Vec<usize> = (zs..=ze).filter(|&k| is_quest(&o.steps[k]) && low.contains(&o.steps[k].q)).collect();
		let top = low.iter().map(|&q| run.q_level[q as usize] as f64).fold(0.0, f64::max);
		let mut places = 0;
		for &(ds, _) in runs_of[..bi].iter() {
			if places >= STAY_SPLIT_PLACES || m.lv[ds] > l0 - 1.0 {
				break;
			}
			if m.lv[ds] < top - UNDER_LEVEL {
				continue;
			}
			let mvs = ks.iter().enumerate().map(|(r, &k)| Mv::Move { s: k, e: k, to: ds + r, kind: STAY_SPLIT }).collect();
			out.push(Mv::Seq { kind: STAY_SPLIT, mvs });
			places += 1;
		}
	}
	out
}

/// A gate (a v1 grind checkpoint `Feas::free_grinds` does not free) that guards an accept, not a
/// training, waits until just before the first accept it gates: the hand-ins between give their XP
/// first (RevA2: Feralas' level-45 grind before Shay's escort and the Feathermoon hand-ins). One
/// `gate later` move per such checkpoint, when no training or other grind is between.
pub fn gate_moves(p: &Problem, m: &Member) -> Vec<Mv> {
	let run = &p.model.run;
	let o = &m.order;
	let live = m.live.min(o.len()).min(m.lv.len());
	let mut out = Vec::new();
	for i in 0..live {
		if o.steps[i].kind != K_GRIND || p.feas.free_grinds.contains(&o.origin[i]) {
			continue;
		}
		let gated = (i + 1..live).find(|&j| o.steps[j].kind == K_ACCEPT && f64::from(run.q_min_level[o.steps[j].q as usize]) > m.lv[i]);
		if let Some(j) = gated.filter(|&j| j > i + 1 && !o.steps[i + 1..j].iter().any(|x| matches!(x.kind, K_TRAIN | K_GRIND))) {
			out.push(Mv::Move { s: i, e: i, to: j - 1, kind: GATE_LATER });
		}
	}
	out
}

/// Yards from a quest's giver (ender) a stop is a visit to it (join): a hub's quest givers
/// (Ratchet's are 40-100 yd apart).
pub const JOIN_YD: f64 = 120.0;
/// Yards the route goes from a giver between two stops there for the later to be another visit.
pub const LEAVE_YD: f64 = 400.0;
/// Earlier visits a join tries per quest (the earliest open one and the latest).
pub const JOIN_VISITS: usize = 2;

/// Join: a quest the order takes on a later visit to its giver although it was open on an
/// earlier one (a player review: "Ratchet gives 2 quests while 5 others are available you could
/// do while doing those 2") is taken on the earlier visit; each of its objectives goes right
/// after the first other quest's work on the same ground (sites within POOL_YD, where the pooled
/// kills do it) before its own place, else stays; its turn-in goes to the first visit to its
/// ender after its work, else stays. Two coupled moves the one-step edits never find.
pub fn joins(p: &Problem, m: &Member) -> Vec<Mv> {
	let run = &p.model.run;
	let o = &m.order;
	let n = o.len();
	let loc = &locs(run, &o.steps);
	let live = m.live.min(n);
	let mine = |k: usize, q: u32| o.steps[k].q == q && matches!(o.steps[k].kind, K_ACCEPT | K_TASK | K_TURNIN);
	let mut out = Vec::new();
	let mut seen = vec![false; run.n_quests()];
	for ia in 0..live.min(n) {
		let s = o.steps[ia];
		if s.kind != K_ACCEPT || seen[s.q as usize] {
			continue;
		}
		seen[s.q as usize] = true;
		let (q, qi) = (s.q, s.q as usize);
		let giver = s.pt;
		out.extend(bag_join(p, m, ia));
		let tin = |pq: u32| o.steps.iter().position(|x| x.kind == K_TURNIN && x.q == pq);
		let any = run.q_pre[qi].iter().filter_map(|&pq| tin(pq)).min();
		let open_from = run.q_all[qi].iter().filter_map(|&pq| tin(pq)).max().into_iter().chain(any).max().map_or(0, |k| k + 1);
		// Earlier visits: a stop at the giver with the route gone from it before the accept.
		let mut visits = Vec::new();
		let mut left = false;
		for j in (open_from..ia).rev() {
			let x = o.steps[j];
			if x.kind == K_GRIND {
				continue;
			}
			let dd = d(run, loc[j], giver);
			if dd > LEAVE_YD {
				left = true;
			} else if left && dd <= JOIN_YD && Member::level_ok(p, qi, m.lv[j]) {
				visits.push(j);
			}
		}
		if visits.is_empty() {
			continue;
		}
		// The latest earlier visit and the earliest.
		let mut tried: Vec<usize> = vec![visits[0], *visits.last().unwrap()];
		tried.dedup();
		tried.truncate(JOIN_VISITS);
		// The order without the quest's steps: rest index of original index k.
		let before = |k: usize| (0..k).filter(|&x| mine(x, q)).count();
		let rest: Vec<usize> = (0..n).filter(|&k| !mine(k, q)).collect();
		for v in tried {
			let mut place: Vec<(usize, Step)> = vec![(v + 1, s)];
			let mut last = v + 1;
			for k in ia + 1..n {
				if !mine(k, q) {
					continue;
				}
				let x = o.steps[k];
				let own = k - before(k);
				let mut at = own;
				if x.kind == K_TASK {
					let site = run.task_pt[x.task as usize];
					// Its mobs no more than the model's work gap over the character (eval A7: the
					// quest's level, capped; Baron Longshore, 16, beside the Freebooters at 13).
					let lvl = run.q_level[qi] as f64 - p.model.tables.p.work_gap.max(UNDER_LEVEL);
					if let Some(w) = (last..own).find(|&w| {
						let y = o.steps[rest[w]];
						y.kind == K_TASK && y.q != q && m.lv[rest[w]] >= lvl && d(run, run.task_pt[y.task as usize], site) <= crate::eval::POOL_YD
					}) {
						at = w + 1;
					}
				} else if x.kind == K_TURNIN {
					if let Some(w) = (last..own).find(|&w| o.steps[rest[w]].kind != K_GRIND && d(run, loc[rest[w]], x.pt) <= JOIN_YD) {
						at = w + 1;
					}
				}
				at = at.max(last);
				place.push((at, x));
				last = at;
			}
			// Into insertion order (each index into the order as it grows).
			let at: Vec<(usize, Step)> = place.iter().enumerate().map(|(i, &(r, x))| (r + i, x)).collect();
			out.push(Mv::Join { q, at });
		}
	}
	out
}

/// From the bags (cloth donations, 7820-7822): a quest accepted at step `ia` whose every objective is
/// carried (Run::task_bag) and whose ender stands at its giver, done and handed in right after the
/// accept, not on a later trip. None when it already is, or is not such a quest.
pub fn bag_join(p: &Problem, m: &Member, ia: usize) -> Option<Mv> {
	let run = &p.model.run;
	let o = &m.order;
	let s = o.steps[ia];
	let (q, qi) = (s.q, s.q as usize);
	let mine = |k: usize| o.steps[k].q == q && matches!(o.steps[k].kind, K_ACCEPT | K_TASK | K_TURNIN);
	let mine_after: Vec<usize> = (ia + 1..o.len()).filter(|&k| mine(k)).collect();
	let bag = |k: &usize| o.steps[*k].kind != K_TASK || run.task_bag.get(o.steps[*k].task as usize).copied().unwrap_or(false);
	if s.kind != K_ACCEPT || !p.model.tables.p.feasible || mine_after.is_empty() || !mine_after.iter().all(bag) || d(run, run.q_ender[qi], s.pt) > JOIN_YD || mine_after[0] == ia + 1 {
		return None;
	}
	let r0 = ia - (0..ia).filter(|&x| mine(x)).count();
	let at: Vec<(usize, Step)> = std::iter::once(ia).chain(mine_after.iter().copied()).enumerate().map(|(i, k)| (r0 + i, o.steps[k])).collect();
	Some(Mv::Join { q, at })
}

/// Yards a moved stop may add to the straight walk over the stretch it changes: a reviewer
/// walks the guide by its straight legs, and a move that lengthens them splits a visit
/// (Molsen Farm, Stone Cairn Lake, the second Darkshore loop) whatever the model's walks say.
pub const PATH_SLACK_YD: f64 = 100.0;

/// The straight walk (yards; a crossing between regions counts FAR_YD) over steps lo..=hi,
/// from the place before lo.
pub(super) fn path_len(run: &crate::run::Run, steps: &[Step], lo: usize, hi: usize) -> f64 {
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
/// Accept places (the cheapest by straight detour) an insertion tries for one whose later steps can
/// follow.
pub const ACCEPT_TRIES: usize = 8;

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
/// between two steps in the step's own zone, else at the cheapest place of the route's next visit
/// to that zone (a quest whose work or hand-in is in a zone the route comes back to later).
pub(super) fn insertion(p: &Problem, m: &Member, q: u32, loc: &[u32], live: usize, nth: usize) -> Option<Mv> {
	insertion_in(p, &m.order, &m.lv, q, loc, live, nth)
}

/// insertion into the order `o` whose levels before each step are `lv` (`loc`: the order's places,
/// search::locs; `live`: its steps before 60).
pub fn insertion_in(p: &Problem, o: &Order, lv: &[f64], q: u32, loc: &[u32], live: usize, nth: usize) -> Option<Mv> {
	let run = &p.model.run;
	let qi = q as usize;
	let giver = run.q_giver[qi];
	// Not before its prerequisites are handed in (one of `pre`, every one of `all`): a follow-up
	// whose giver takes the prerequisite's hand-in opens right after it, at no detour (B3: Target:
	// Writhing Haunt after Return to the Bulwark; G5).
	let tin = |pq: u32| o.steps.iter().position(|s| s.kind == K_TURNIN && s.q == pq);
	// Never when the order never hands them in: it would do nothing (a hub revisit's quests whose
	// chain the route does not take: The Rumormonger without Parts for Kravel).
	if !opens_after(run, q, &|y| tin(y).is_some()) {
		return None;
	}
	let any = run.q_pre[qi].iter().filter_map(|&pq| tin(pq)).min();
	let open_from = run.q_all[qi].iter().filter_map(|&pq| tin(pq)).max().into_iter().chain(any).max().map_or(1, |k| k + 1);
	let mut all: Vec<(f64, usize)> = Vec::new();
	for j in open_from.max(1)..live {
		// The leg into step j passes the giver (the guards' passed-by: any point of the leg).
		let dd = d(run, loc[j - 1], giver);
		if seg_dist(run, loc[j - 1], loc[j], giver) > PASSED_BY_YD || !Member::level_ok(p, qi, lv.get(j).copied().unwrap_or(60.0)) {
			continue;
		}
		let c = dd + d(run, giver, loc[j]) - d(run, loc[j - 1], loc[j]);
		all.push((c, j));
	}
	all.sort_by(|a, b| a.0.total_cmp(&b.0).then(a.1.cmp(&b.1)));
	// nth: the accept's rank (nth % ACCEPT_RANKS) and the later steps' rank (nth / ACCEPT_RANKS),
	// among the accept places (the ACCEPT_TRIES cheapest) where the quest's later steps can follow:
	// the cheapest pass can be the route's last one, after its work's zone (Goblin Invaders: c13's
	// `zone-left` taken at 26.9, the Stonetalon work already behind; the 23.5 pass works).
	let later = nth / ACCEPT_RANKS;
	let quest = crate::seq::quest_steps(run, q);
	let place = |acc: usize| -> Option<Vec<(usize, Step)>> {
		let mut steps = o.steps.clone();
		steps.insert(acc, quest[0]);
		let mut at = vec![(acc, quest[0])];
		let mut latest = acc;
		for &x in &quest[1..] {
			let l = locs(run, &steps);
			let lo = if x.kind == K_TASK { acc + 1 } else { latest + 1 };
			let hi = (lo + INSERT_REACH).min(steps.len());
			let map = run.p_map[x.pt as usize];
			let cost = |j: usize| {
				let prev = l[j - 1];
				if j == steps.len() {
					d(run, prev, x.pt)
				} else {
					d(run, prev, x.pt) + d(run, x.pt, l[j]) - d(run, prev, l[j])
				}
			};
			let on = |j: usize| run.p_map[l[j - 1] as usize] == map;
			let mut cands: Vec<(f64, usize)> = (lo.min(steps.len())..=hi).filter(|&j| on(j)).map(|j| (cost(j), j)).collect();
			// None within reach: the route's next visit to that zone, however far (Pawn Captures
			// Queen: taken in Tanaris at 50.8, worked in Un'Goro at 51-52, handed in on the Tanaris
			// return at 57.4; c13's `zone-left`, "not reached soon after").
			if cands.is_empty() {
				if let Some(v0) = (hi + 1..=steps.len()).find(|&j| on(j)) {
					cands.extend((v0..=steps.len()).take_while(|&j| on(j)).map(|j| (cost(j), j)));
				}
			}
			cands.sort_by(|a, b| a.0.total_cmp(&b.0).then(a.1.cmp(&b.1)));
			let j = cands.get(later).or(cands.first())?.1;
			steps.insert(j, x);
			at.push((j, x));
			if j <= latest {
				latest += 1;
			}
			if x.kind == K_TASK {
				latest = latest.max(j);
			}
		}
		Some(at)
	};
	let at = all.iter().take(ACCEPT_TRIES).filter_map(|&(_, acc)| place(acc)).nth(nth % ACCEPT_RANKS)?;
	Some(Mv::Insert { q, at })
}

/// Most quests a chain insert takes (the head and the quests it opens, in turn).
pub const CHAIN_INSERT_MAX: usize = 6;

/// The levels before each step after `mv` (an insert, or inserts in turn) applied to an order with
/// levels `lv`: an inserted step takes the level of the step it comes before.
fn levels_after(lv: &[f64], mv: &Mv) -> Vec<f64> {
	let mut lv = lv.to_vec();
	let mut put = |at: &[(usize, Step)]| {
		for &(j, _) in at {
			let l = lv.get(j).or(lv.last()).copied().unwrap_or(1.0);
			lv.insert(j.min(lv.len()), l);
		}
	};
	match mv {
		Mv::Insert { at, .. } => put(at),
		Mv::Seq { mvs, .. } => {
			for m in mvs {
				if let Mv::Insert { at, .. } = m {
					put(at);
				}
			}
		}
		_ => {}
	}
	lv
}

/// Whether quest q opens once the quests of `done` are handed in (any of `pre`, all of `all`, its
/// parent), or needs nothing.
fn opens_after(run: &crate::run::Run, q: u32, done: &dyn Fn(u32) -> bool) -> bool {
	let qi = q as usize;
	(run.q_pre[qi].is_empty() || run.q_pre[qi].iter().any(|&x| done(x))) && run.q_all[qi].iter().all(|&x| done(x)) && (run.q_parent[qi] < 0 || done(run.q_parent[qi] as u32))
}

/// Value a chain, not a quest (the route benchmark's rule 1: Goblin Invaders, Meats to Orgrimmar and Blood
/// Feeders dropped as low-value alone, the quests they open then `chain-not-open`): quest q
/// inserted as `insertion` does, then each quest it opens that may be added (the pool), inserted
/// the same way after it, up to CHAIN_INSERT_MAX. None when q itself does not insert or opens
/// nothing insertable.
pub fn chain_insertion(p: &Problem, o: &Order, lv: &[f64], live: usize, q: u32) -> Option<Mv> {
	let run = &p.model.run;
	let in_pool = |x: u32| p.pool.binary_search(&x).is_ok();
	let mut in_order = vec![false; run.n_quests()];
	for s in &o.steps {
		if s.kind == K_ACCEPT {
			in_order[s.q as usize] = true;
		}
	}
	let (mut cur, mut lvs, mut live) = (o.clone(), lv.to_vec(), live);
	let mut mvs = Vec::new();
	let mut taken: Vec<u32> = Vec::new();
	let mut queue = std::collections::VecDeque::from([q]);
	while let Some(x) = queue.pop_front() {
		// Open by the order's hand-ins or the chain's own and not closed by a quest it takes (a quest
		// whose prerequisite the route never hands in would do nothing).
		let open = opens_after(run, x, &|y| taken.contains(&y) || cur.steps.iter().any(|s| s.kind == K_TURNIN && s.q == y)) && !run.q_excl[x as usize].iter().any(|&e| in_order[e as usize] || taken.contains(&e));
		if mvs.len() >= CHAIN_INSERT_MAX || in_order[x as usize] || taken.contains(&x) || !in_pool(x) || !open {
			if x == q {
				return None;
			}
			continue;
		}
		let loc = locs(run, &cur.steps);
		let Some(mv) = insertion_in(p, &cur, &lvs, x, &loc, live, 0) else {
			if x == q {
				return None;
			}
			continue;
		};
		let (next, _, _) = mv.apply(&cur)?;
		lvs = levels_after(&lvs, &mv);
		live += next.len() - cur.len();
		cur = next;
		mvs.push(mv);
		taken.push(x);
		let done = |y: u32| taken.contains(&y) || cur.steps.iter().any(|s| s.kind == K_TURNIN && s.q == y);
		for &f in &p.followers[x as usize] {
			if opens_after(run, f, &done) {
				queue.push_back(f);
			}
		}
	}
	(mvs.len() >= 2).then_some(Mv::Seq { kind: "chain insert", mvs })
}

/// The quests an insert (or inserts in turn) adds, in the order it adds them.
pub fn chain_quests(mv: &Mv) -> Vec<u32> {
	let mut out: Vec<u32> = Vec::new();
	let mut add = |m: &Mv| {
		if let Mv::Insert { q, .. } = m {
			if !out.contains(q) {
				out.push(*q);
			}
		}
	};
	match mv {
		Mv::Seq { mvs, .. } => mvs.iter().for_each(&mut add),
		m => add(m),
	}
	out
}

/// Fewest quests a zone block takes, and most.
pub const BLOCK_MIN: usize = 3;
pub const BLOCK_MAX: usize = 12;
/// Yards from the route's stop to the zone block's nearest giver, at most.
pub const BLOCK_REACH_YD: f64 = 3000.0;

/// A zone's open chains as one visit (the route benchmark's rule 1: Stonetalon south at 17-19, about 9.2 k XP
/// within 190-560 yd, where the route goes to Silverpine): per map, the quests that may be added
/// whose giver, work and ender are all on it and whose level window is open, with the quests they
/// open, inserted as one block after the route's stop nearest their givers at the level where most
/// of them are open; the block walks them nearest first (an accept before its work, the work
/// before its hand-in, a prerequisite's hand-in before the follow-up's accept), then the route goes
/// on from that stop.
pub fn zone_blocks(p: &Problem, m: &Member) -> Vec<Mv> {
	zone_blocks_in(p, &m.order, &m.lv, m.live)
}

/// zone_blocks for the order `o`, its levels before each step `lv`, its steps before 60 `live`.
fn zone_blocks_in(p: &Problem, o: &Order, lv: &[f64], live: usize) -> Vec<Mv> {
	let run = &p.model.run;
	let live = live.min(o.len()).min(lv.len());
	if live < 2 {
		return Vec::new();
	}
	let mut in_order = vec![false; run.n_quests()];
	for s in o.steps.iter().filter(|s| s.kind == K_ACCEPT) {
		in_order[s.q as usize] = true;
	}
	let loc = locs(run, &o.steps);
	let map_of = |pt: u32| run.p_map[pt as usize];
	let mut by_map: rustc_hash::FxHashMap<u32, Vec<u32>> = Default::default();
	for &q in &p.pool {
		let qi = q as usize;
		if in_order[qi] || p.feas.skip.contains(&q) {
			continue;
		}
		let z = map_of(run.q_giver[qi]);
		let steps = crate::seq::quest_steps(run, q);
		if steps.iter().all(|s| map_of(s.pt) == z) {
			by_map.entry(z).or_default().push(q);
		}
	}
	// Each quest's first hand-in in the order.
	let mut tin = vec![usize::MAX; run.n_quests()];
	for (k, s) in o.steps.iter().enumerate() {
		if s.kind == K_TURNIN && tin[s.q as usize] == usize::MAX {
			tin[s.q as usize] = k;
		}
	}
	let mut maps: Vec<u32> = by_map.keys().copied().collect();
	maps.sort_unstable();
	let mut out = Vec::new();
	for z in maps {
		let qs = &by_map[&z];
		if qs.len() < BLOCK_MIN {
			continue;
		}
		// The stop: most of them open and on level there (not more than a level under the
		// character: the full XP the block is for), then nearest their givers.
		let open_at = |j: usize| {
			qs.iter().filter(|&&q| Member::level_ok(p, q as usize, lv[j]) && run.q_level[q as usize] as f64 >= lv[j] - 1.0 && opens_after(run, q, &|y| tin[y as usize] < j)).count()
		};
		let near = |j: usize| qs.iter().map(|&q| d(run, loc[j], run.q_giver[q as usize])).fold(f64::INFINITY, f64::min);
		let Some((j, n)) = (1..live).filter(|&j| o.steps[j].kind != K_GRIND && near(j) <= BLOCK_REACH_YD).map(|j| (j, open_at(j))).max_by(|a, b| a.1.cmp(&b.1).then(near(b.0).total_cmp(&near(a.0))).then(b.0.cmp(&a.0))) else { continue };
		if n < BLOCK_MIN {
			continue;
		}
		// Its quests: those open there, then the ones they open.
		let done_before = |y: u32| tin[y as usize] <= j;
		let mut chosen: Vec<u32> = qs.iter().copied().filter(|&q| Member::level_ok(p, q as usize, lv[j]) && opens_after(run, q, &done_before)).collect();
		let mut k = 0;
		while k < chosen.len() && chosen.len() < BLOCK_MAX {
			for &f in &p.followers[chosen[k] as usize] {
				if qs.contains(&f) && !chosen.contains(&f) && chosen.len() < BLOCK_MAX && opens_after(run, f, &|y| done_before(y) || chosen.contains(&y)) && Member::level_ok(p, f as usize, lv[j] + 1.0) {
					chosen.push(f);
				}
			}
			k += 1;
		}
		chosen.truncate(BLOCK_MAX);
		// The walk: nearest available step first.
		let mut left: Vec<Step> = chosen.iter().flat_map(|&q| crate::seq::quest_steps(run, q)).collect();
		let mut tour: Vec<Step> = Vec::with_capacity(left.len());
		let mut at = loc[j];
		while !left.is_empty() {
			let ready = |s: &Step| {
				let mine_before = |k: u8| tour.iter().any(|t| t.q == s.q && t.kind == k);
				match s.kind {
					K_ACCEPT => opens_after(run, s.q, &|y| done_before(y) || tour.iter().any(|t| t.kind == K_TURNIN && t.q == y)),
					K_TASK => mine_before(K_ACCEPT),
					_ => mine_before(K_ACCEPT) && !left.iter().any(|x| x.q == s.q && x.kind == K_TASK),
				}
			};
			let Some(k) = (0..left.len()).filter(|&k| ready(&left[k])).min_by(|&a, &b| d(run, at, left[a].pt).total_cmp(&d(run, at, left[b].pt)).then(a.cmp(&b))) else { break };
			let s = left.remove(k);
			at = s.pt;
			tour.push(s);
		}
		if !left.is_empty() {
			continue;
		}
		let mvs = tour.iter().enumerate().map(|(t, &s)| Mv::Insert { q: s.q, at: vec![(j + 1 + t, s)] }).collect();
		out.push(Mv::Seq { kind: "zone block", mvs });
	}
	out
}

/// The edit kind of a hub visited again at the level its quests open (revisit_moves).
pub const HUB_REVISIT: &str = "hub revisit";
/// Levels over the hub's quests' window floor the stop a revisit follows may be.
pub const REVISIT_SPAN: f64 = 2.0;
/// Fewest quests a revisit takes (a chain's worth, not one quest's trip).
pub const REVISIT_MIN_QUESTS: usize = 2;
/// Stops a revisit is tried from per giver (the nearest at the level, at different places).
pub const REVISIT_STOPS: usize = 3;

/// A hub visited again at the level its quests open (Fitz's flow policy: an extra visit is fine
/// when it carries a chain's worth of quest XP): per giver of quests that may be added, the route's
/// stop nearest it (500 yd or more off; on another continent, the first: Ratchet from Stranglethorn
/// by the Booty Bay boat) where one of the givers' quests within
/// JOIN_YD of it is open (its prerequisites handed in) and the character is at its window's floor
/// (its minimum level, or two under its level) to REVISIT_SPAN over it (the REVISIT_STOPS nearest
/// such stops at different places, each a candidate). After that stop the route
/// goes to the giver; each of those quests is inserted as `chain insert` does (with the quests it
/// opens, their work and hand-ins on the route's visits to their zones), else as `insert` does,
/// none of them taken before the stop. At least REVISIT_MIN_QUESTS quests (c13 Orc: Ratchet passed
/// only at 29.6-30.3, the Shimmering Flats chains Wharfmaster Dizzywig and Goblin Sponsorship at
/// 36-37 left `level`; the Fallen Hero chain at Stonard left after Fall From Grace).
pub fn revisit_moves(p: &Problem, m: &Member) -> Vec<Mv> {
	let run = &p.model.run;
	let o = &m.order;
	let live = m.live.min(o.len()).min(m.lv.len());
	if live < 2 {
		return Vec::new();
	}
	let lv = &m.lv;
	let loc = locs(run, &o.steps);
	let mut in_order = vec![false; run.n_quests()];
	for s in o.steps.iter().filter(|s| s.kind == K_ACCEPT) {
		in_order[s.q as usize] = true;
	}
	let mut tin = vec![usize::MAX; run.n_quests()];
	for (k, s) in o.steps.iter().enumerate() {
		if s.kind == K_TURNIN && tin[s.q as usize] == usize::MAX {
			tin[s.q as usize] = k;
		}
	}
	let free = |q: u32| !in_order[q as usize] && !p.feas.skip.contains(&q);
	let floor = |q: u32| f64::from(run.q_min_level[q as usize]).max(f64::from(run.q_level[q as usize]) - forge_world::rules::ACCEPT_ABOVE);
	let mut givers: Vec<u32> = p.pool.iter().copied().filter(|&q| free(q)).map(|q| run.q_giver[q as usize]).collect();
	givers.sort_unstable();
	givers.dedup();
	let mut out = Vec::new();
	for g in givers {
		let mut here: Vec<u32> = p.pool.iter().copied().filter(|&q| free(q) && d(run, run.q_giver[q as usize], g) <= JOIN_YD).collect();
		here.sort_by_key(|&q| (run.q_level[q as usize], q));
		let open_at = |q: u32, k: usize| opens_after(run, q, &|y| tin[y as usize] < k) && lv[k] >= floor(q) && lv[k] < floor(q) + REVISIT_SPAN;
		let mut stops: Vec<usize> = (1..live).filter(|&k| o.steps[k].kind != K_GRIND && here.iter().any(|&q| open_at(q, k))).collect();
		stops.sort_by(|&a, &b| d(run, loc[a], g).total_cmp(&d(run, loc[b], g)).then(a.cmp(&b)));
		// At the giver already: a plain insert or join reaches it.
		if stops.first().is_none_or(|&j| d(run, loc[j], g) <= PASSED_BY_YD) {
			continue;
		}
		// The nearest few stops, at different places (a trip from one can meet a hearth on
		// cooldown where one from another does not).
		let mut picked: Vec<usize> = Vec::new();
		for j in stops {
			if picked.len() >= REVISIT_STOPS {
				break;
			}
			if picked.iter().all(|&k| d(run, loc[k], loc[j]) > FOLD_YD) {
				picked.push(j);
			}
		}
		for j in picked {
			let visit = Step { kind: K_VISIT, q: 0, task: -1, pt: g };
			let mut cur = o.clone();
			cur.steps.insert(j + 1, visit);
			cur.origin.insert(j + 1, INSERTED);
			// No accept before the visit: the levels there closed.
			let mut lvs: Vec<f64> = lv.iter().enumerate().map(|(k, &l)| if k <= j { 0.0 } else { l }).collect();
			lvs.insert((j + 1).min(lvs.len()), lv[j]);
			let mut cur_live = live + 1;
			let mut mvs = vec![Mv::Insert { q: 0, at: vec![(j + 1, visit)] }];
			let mut taken = 0;
			for &q in &here {
				if cur.steps.iter().any(|s| s.kind == K_ACCEPT && s.q == q) {
					continue;
				}
				let cloc = locs(run, &cur.steps);
				let Some(mv) = chain_insertion(p, &cur, &lvs, cur_live, q).or_else(|| insertion_in(p, &cur, &lvs, q, &cloc, cur_live, 0)) else { continue };
				let Some((next, _, _)) = mv.apply(&cur) else { continue };
				taken += chain_quests(&mv).len();
				lvs = levels_after(&lvs, &mv);
				cur_live += next.len() - cur.len();
				cur = next;
				mvs.push(mv);
			}
			if taken < REVISIT_MIN_QUESTS {
				continue;
			}
			// The visit's own stop goes: the accepts there carry the trip.
			let Some(i) = cur.steps.iter().position(|s| s.kind == K_VISIT && s.pt == g) else { continue };
			mvs.push(Mv::DropStep { i });
			out.push(Mv::Seq { kind: HUB_REVISIT, mvs });
		}
	}
	out
}

/// The quests an edit made of inserts takes (a revisit's, without its visit stop).
pub fn revisit_quests(mv: &Mv) -> Vec<u32> {
	let Mv::Seq { mvs, .. } = mv else { return Vec::new() };
	let mut out: Vec<u32> = Vec::new();
	for m in mvs {
		let qs = match m {
			Mv::Insert { q, at } if at.iter().all(|x| matches!(x.1.kind, K_ACCEPT | K_TASK | K_TURNIN)) => vec![*q],
			Mv::Seq { .. } => chain_quests(m),
			_ => Vec::new(),
		};
		for q in qs {
			if !out.contains(&q) {
				out.push(q);
			}
		}
	}
	out
}

/// Stay on the continent (the route benchmark's rule 2: our 16-19 Silverpine trip, two zeppelins
/// and two hearths for level 11-17 quests at 40-60 % XP, against the Barrens and Stonetalon at
/// level). Per trip off the continent and back (guards::trips): its quests whose every step is on
/// the trip and that are LOW_TRIP_UNDER or more levels under the character there, dropped together;
/// when those make two thirds of the trip's quest steps (a low trip), the trip's every quest dropped,
/// alone and with the best zone block of the continent left (zone_blocks) in its place.
pub fn trip_drops(p: &Problem, m: &Member) -> Vec<Mv> {
	let run = &p.model.run;
	let o = &m.order;
	let live = m.live.min(o.len());
	let mut out = Vec::new();
	for (s, e) in crate::guards::trips(run, &o.steps[..live]) {
		let l = m.lv[s];
		let quest = |x: &Step| matches!(x.kind, K_ACCEPT | K_TASK | K_TURNIN);
		let mut qs: Vec<u32> = o.steps[s..=e].iter().filter(|x| quest(x)).map(|x| x.q).collect();
		qs.sort_unstable();
		qs.dedup();
		let inside = |q: u32| o.steps.iter().enumerate().filter(|(_, x)| x.q == q && quest(x)).all(|(k, _)| (s..=e).contains(&k)) && !p.feas.keep.contains(&q);
		let is_low = |q: u32| run.q_level[q as usize] as f64 <= l - crate::guards::LOW_TRIP_UNDER;
		let all: Vec<u32> = qs.iter().copied().filter(|&q| inside(q)).collect();
		let low: Vec<u32> = all.iter().copied().filter(|&q| is_low(q)).collect();
		// Dropped in turn: each later drop's quest is found by id, so the indices need not track.
		let drops = |qs: &[u32]| qs.iter().map(|&q| Mv::Drop { q }).collect::<Vec<_>>();
		if !low.is_empty() {
			out.push(Mv::Seq { kind: "drop trip", mvs: drops(&low) });
		}
		let steps = o.steps[s..=e].iter().filter(|x| quest(x)).count();
		let low_steps = o.steps[s..=e].iter().filter(|x| quest(x) && is_low(x.q)).count();
		if all.is_empty() || 3 * low_steps < 2 * steps {
			continue;
		}
		if all.len() > low.len() {
			out.push(Mv::Seq { kind: "drop trip", mvs: drops(&all) });
		}
		// The trip's quests out, a zone of the continent left in.
		let whole = Mv::Seq { kind: "drop trip", mvs: drops(&all) };
		let Some((o2, _, _)) = whole.apply(o) else { continue };
		let gone: Vec<bool> = o.steps.iter().map(|x| quest(x) && all.contains(&x.q)).collect();
		let lv2: Vec<f64> = m.lv.iter().zip(&gone).filter(|x| !*x.1).map(|x| *x.0).collect();
		let live2 = live - gone[..live].iter().filter(|&&g| g).count();
		let home = run.p_c[o.steps[..s].iter().rev().find(|x| x.kind != K_GRIND).map_or(run.start_pt, |x| x.pt) as usize];
		for b in zone_blocks_in(p, &o2, &lv2, live2) {
			let Mv::Seq { mvs, .. } = &b else { continue };
			let first = mvs.iter().find_map(|x| if let Mv::Insert { at, .. } = x { at.first().map(|a| (a.0, a.1.pt)) } else { None });
			// A block on the continent the trip left, near where the trip was.
			if first.is_some_and(|(j, pt)| run.p_c[pt as usize] == home && j + 40 >= s && j <= s + 40) {
				let mut seq = drops(&all);
				seq.extend(mvs.iter().cloned());
				out.push(Mv::Seq { kind: "drop trip", mvs: seq });
			}
		}
	}
	out
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
	/// The estimated seconds a candidate saves (None: breaks a rule or past the end). `slack`: the
	/// yards a reorder may add to the straight walk over the stretch it changes.
	fn est_gain(&mut self, p: &Problem, cand: &Order, a: usize, b: usize, slack: f64) -> Option<f64> {
		if a >= self.live || !self.check.valid(&cand.steps, &p.pairs, &p.feas) || twin_trainings(cand) > twin_trainings(&self.order) {
			return None;
		}
		// Same steps reordered (a move): no longer straight walk over the stretch it changes.
		if cand.len() == self.order.len() {
			let run = &p.model.run;
			let hi = (b + 1).min(cand.len() - 1);
			if path_len(run, &cand.steps, a, hi) > path_len(run, &self.order.steps, a, hi) + slack {
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

/// Keep edit `mv` (its exact gain `gain`) on every member: member 0 replays it exactly, the rest
/// take its order. None when it does not replay to a gain (a checkpoint's edit on another order).
fn keep(p: &Problem, ms: &mut [Member], mv: Mv, gain: f64) -> Option<Edit> {
	let m0 = &mut ms[0];
	let (o, a, b) = mv.apply(&m0.order)?;
	let (next, gc) = m0.replay(p, &o, a, b)?;
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
	Some(Edit { mv, before, lv, saved: gain, hours })
}

/// Steepest descent from `seed` with local edits, at most `max_edits`; `workers` members
/// share the candidates (the result is the same for any number).
///
/// `no_worse`: an edit is kept only when no character's hours to 60 rise (the shared route: an
/// edit that helps one start must not slow another sharing the guide).
///
/// With a checkpoint unit `ck`: the edits kept so far are saved every `ck.every()` and at the end
/// (resume::DescentCk), and a descent from the same seed replays them (each candidate by its index
/// among the candidates of the order before it, one exact replay, no estimates), checked against the
/// hours each reached, then goes on as the uninterrupted descent would.
pub fn descend(p: &Problem, seed: &Order, max_edits: usize, workers: usize, no_worse: bool, log: &mut dyn FnMut(usize, f64, &str), ck: Option<&Unit>) -> Descent {
	let t0 = std::time::Instant::now();
	let start = super::runs(p, seed);
	let fresh = || -> Vec<Member> { (0..workers.max(1)).map(|k| Member::new(p, seed.clone(), &start, k as u64)).collect() };
	let mut ms = fresh();
	let start_hours = ms[0].total() / 3600.0;
	let fit = crate::resume::fit(seed, &[u64::from(no_worse)]);
	let mut edits: Vec<Edit> = Vec::new();
	let mut orders = Vec::new();
	let mut picks: Vec<Pick> = Vec::new();
	let mut ended = false;
	if let Some((u, c)) = ck.and_then(|u| u.load::<DescentCk>(DESCENT).filter(|c| c.fit == fit).map(|c| (u, c))) {
		let mut replayed = true;
		for pk in c.picks.iter().take(max_edits) {
			let cands = candidates(p, &ms[0]);
			let Some(e) = cands.get(pk.cand).and_then(|mv| keep(p, &mut ms, mv.clone(), pk.gain)).filter(|e| e.hours == pk.hours) else {
				u.note(format!("{}: the descent's checkpoint does not replay at edit {}; the descent starts over", u.name, edits.len() + 1));
				ms = fresh();
				(edits, orders, picks) = (Vec::new(), Vec::new(), Vec::new());
				replayed = false;
				break;
			};
			orders.push(ms[0].order.clone());
			edits.push(e);
			picks.push(pk.clone());
		}
		if replayed {
			ended = c.ended && edits.len() == c.picks.len();
			u.note(format!("resuming {} edit descent from checkpoint ({} edits done{})", u.name, edits.len(), if ended { ", ended" } else { "" }));
		}
	}
	let mut last_save = std::time::Instant::now();
	while !ended && edits.len() < max_edits {
		let cands = candidates(p, &ms[0]);
		let ests: Vec<Option<f64>> = par_each(&mut ms, cands.len(), |m, i| {
			let (o, a, b) = cands[i].apply(&m.order)?;
			let slack = if matches!(cands[i].kind(), STAY_LATER | STAY_SPLIT) { f64::INFINITY } else { PATH_SLACK_YD };
			m.est_gain(p, &o, a, b, slack)
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
		let Some((ci, gain)) = found else {
			ended = true;
			break;
		};
		let e = keep(p, &mut ms, cands[ci].clone(), gain).expect("exact gain repeats");
		log(edits.len() + 1, e.hours, e.mv.kind());
		picks.push(Pick { cand: ci, gain, hours: e.hours });
		orders.push(ms[0].order.clone());
		edits.push(e);
		if let Some(u) = ck {
			if last_save.elapsed() >= u.every() {
				u.save(DESCENT, &DescentCk { fit, picks: picks.clone(), ended: false });
				last_save = std::time::Instant::now();
			}
		}
	}
	if let Some(u) = ck {
		u.save(DESCENT, &DescentCk { fit, picks, ended });
	}
	let capped = edits.len() >= max_edits;
	if capped {
		eprintln!("edit descent: stopped at its cap of {max_edits} edits with gain maybe left (raise the cap)");
	}
	Descent { start_hours, edits, orders, seconds: t0.elapsed().as_secs_f64(), capped }
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

#[cfg(test)]
mod tests {
	use super::*;

	/// A descent of edits saving `saved` seconds each, from 100 h.
	fn descent(saved: &[f64]) -> Descent {
		let mut h = 100.0;
		let o = Order { steps: Vec::new(), origin: Vec::new() };
		let edits: Vec<Edit> = saved
			.iter()
			.map(|&s| {
				h -= s / 3600.0;
				Edit { mv: Mv::DropStep { i: 0 }, before: o.clone(), lv: Vec::new(), saved: s, hours: h }
			})
			.collect();
		Descent { start_hours: 100.0, orders: vec![o; edits.len()], edits, seconds: 0.0, capped: false }
	}

	#[test]
	fn cut_all_keeps_every_edit_the_descent_made_knee_fewer() {
		// Most of the gain in two edits, then a long tail of small ones (each at least EDIT_MIN_GAIN).
		let d = descent(&[3000.0, 2000.0, 60.0, 40.0, 30.0, 20.0, EDIT_MIN_GAIN, EDIT_MIN_GAIN]);
		assert!(d.edits.iter().all(|e| e.saved >= EDIT_MIN_GAIN));
		assert_eq!(cut_at(&d, None, Cut::All), d.edits.len());
		let k = cut_at(&d, None, Cut::Knee);
		assert_eq!(k, knee(&d));
		assert!(k < d.edits.len(), "the knee leaves the tail: {k}");
		// A budget wins over either cut, and never past the descent.
		assert_eq!(cut_at(&d, Some(3), Cut::All), 3);
		assert_eq!(cut_at(&d, Some(99), Cut::Knee), d.edits.len());
		assert_eq!(Cut::default(), Cut::All);
		assert_eq!(Cut::parse("knee"), Some(Cut::Knee));
		assert_eq!(Cut::parse("half"), None);
	}

	use std::io::Read;

	fn gunzip(p: &std::path::Path) -> Vec<u8> {
		let mut out = Vec::new();
		flate2::read::GzDecoder::new(std::fs::File::open(p).unwrap()).read_to_end(&mut out).unwrap();
		out
	}

	#[test]
	fn a_follow_up_is_inserted_after_its_prerequisite_s_hand_in() {
		// B3, G5: Target: Writhing Haunt (5233) from the Bulwark NPC that takes Return to the Bulwark
		// (5232): its accept goes after that hand-in (where its chain opens), not on an earlier pass.
		let golden = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden");
		let world = forge_world::World::from_json(&gunzip(&golden.join("world/expected/world-horde.json.gz"))).unwrap();
		let doc: serde_json::Value = serde_json::from_slice(&std::fs::read(golden.join("sim/params.json")).unwrap()).unwrap();
		let base = crate::Params::effective(Some(&doc), None, &[]);
		let walks = crate::NoWalks;
		let profile = crate::profile::Profile::average(forge_core::Faction::Horde);
		let model = crate::route::model_for(&world, "Orc", &profile, &base, &walks).unwrap().0;
		let chain: serde_json::Value = serde_json::from_slice(&gunzip(&golden.join("sim/v1-horde-orc-off.json.gz"))).unwrap();
		let mut ev = model.evaluator(&walks);
		let seed = crate::order::seed_order(&mut ev, &crate::chain::events_from(&chain), true);
		drop(ev);
		let run = &model.run;
		let tin = |o: &Order, q: u32| o.steps.iter().position(|s| s.kind == K_TURNIN && s.q == q);
		let acc = |o: &Order, q: u32| o.steps.iter().position(|s| s.kind == K_ACCEPT && s.q == q);
		// A follow-up in v1's order whose giver is where its prerequisite is handed in.
		let (q, pre) = (0..run.n_quests() as u32)
			.filter(|&q| run.q_pre[q as usize].len() == 1 && run.q_all[q as usize].is_empty())
			.map(|q| (q, run.q_pre[q as usize][0]))
			.find(|&(q, pq)| run.q_giver[q as usize] == run.q_ender[pq as usize] && acc(&seed, q).is_some() && tin(&seed, pq).is_some_and(|t| t > 20))
			.expect("a follow-up given where its prerequisite is handed in");
		let without = Order { steps: seed.steps.iter().filter(|s| s.q != q || !matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN)).copied().collect(), origin: Vec::new() };
		let without = Order { origin: vec![-1; without.steps.len()], ..without };
		let p = Problem::single(&model, &walks, Vec::new(), Vec::new());
		let m = Member::new(&p, without.clone(), &super::super::runs(&p, &without), 1);
		let loc = locs(run, &without.steps);
		let t = tin(&without, pre).unwrap();
		for nth in 0..ACCEPT_RANKS {
			if let Some(Mv::Insert { at, .. }) = insertion(&p, &m, q, &loc, m.live.min(without.len()), nth) {
				assert!(at[0].0 > t, "accept at {} before the prerequisite's hand-in at {t}", at[0].0);
			}
		}
		let Some(Mv::Insert { at, .. }) = insertion(&p, &m, q, &loc, m.live.min(without.len()), 0) else { panic!("no insertion") };
		assert_eq!(at[0].0, t + 1, "right after the hand-in, at its giver");
	}
}
