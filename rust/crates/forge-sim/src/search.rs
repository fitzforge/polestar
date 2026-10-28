//! The search: improve a seed order (v1's) for the fastest route to 60.
//!
//! Adapted from Factoruide (MIT, by Joel, used with his permission):
//! - fg-route src/plan/evaluate.rs `evaluate_within` / `estimate`: a move is replayed from the
//!   state before its first changed step for a window past its last one, then the rest is
//!   estimated at equal XP from the current order's run (its time when it had the same total
//!   XP); only a move whose estimate is better is replayed to the end, and only an exact gain
//!   is kept. States come from snapshots taken every SNAP_EVERY steps of the current order
//!   (fg clones the state per stop; ours are a few tens of KB, so every few dozen steps).
//! - fg-route src/plan/search.rs and share.rs: the search is counted in tries, on members
//!   that each run their own seeded moves and meet every `share_every` tries, where the
//!   laggards continue from the best (ties to the lowest member), so the result is the same on
//!   any machine and thread count.
//! - fg-route src/plan/moves.rs operators: move a stop, move an objective to its cheapest
//!   detour, move a block (a zone stay), insert a quest near the route, drop a quest, ruin and
//!   recreate a stretch.
//!
//! A move is kept only when the order still keeps its rules (order::Checker: a quest's own
//! order and v1's deliberate orders) and the hours to 60 drop.

use crate::eval::{Evaluator, Snap, Step};
use crate::order::{Checker, Order, Pair, INSERTED};
use crate::resume::{FreeCk, Unit, FREE};
use crate::run::{Run, K_ACCEPT, K_GRIND, K_TASK, K_TRAIN, K_TURNIN};
use crate::seq::nearest_town;
use crate::walks::Walks;
use crate::Model;

/// Steps between the current order's snapshots.
pub const SNAP_EVERY: usize = 48;
/// Steps replayed past a move's last change before the rest is estimated.
pub const WINDOW: usize = 80;
/// A move must save at least this many seconds.
pub const MIN_GAIN: f64 = 0.5;
/// Steps a single stop moves at most.
pub const STOP_REACH: usize = 60;
/// Steps a block moves at most.
pub const BLOCK_REACH: usize = 300;
/// Longest block (zone stay) moved whole.
pub const BLOCK_MAX: usize = 40;
/// Yards: a quest whose giver an order's stop passes this close is "passed by".
pub const PASSED_BY_YD: f64 = 500.0;
/// Steps after its accept an inserted quest's sites and turn-in may go.
pub const INSERT_SPAN: usize = 300;
/// Steps either side of a stop searched by the same-camp/hub removal.
pub const RUIN_WINDOW: usize = 80;
/// Yards: stops this close are the same camp or hub (removal).
pub const NEAR_YD: f64 = 300.0;
/// Quests a chain removal takes at most.
pub const CHAIN_MAX: usize = 8;
/// Yards and steps of the same-place grouping (fg together.rs gather_radius, AHEAD).
pub const GATHER_YD: f64 = 150.0;
pub const GATHER_AHEAD: usize = 30;
/// Yards and stops of an exact in-hub ordering.
pub const HUB_YD: f64 = 200.0;
pub const HK_MAX: usize = 12;
/// Straight yards standing in for a crossing between regions in the detour proxy.
const FAR_YD: f64 = 1.0e6;

pub mod edits;
pub mod passby;

/// How a route is searched: the edit descent from the seed (`edits`), the free search (`free`:
/// random moves, `tries` of them over `members`), or the free search and then the edit descent
/// from its order (`hybrid`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Mode {
	Edits,
	Free,
	Hybrid,
}

impl Mode {
	pub fn parse(s: &str) -> Option<Mode> {
		match s {
			"edits" => Some(Mode::Edits),
			"free" => Some(Mode::Free),
			"hybrid" => Some(Mode::Hybrid),
			_ => None,
		}
	}
	pub fn name(self) -> &'static str {
		match self {
			Mode::Edits => "edits",
			Mode::Free => "free",
			Mode::Hybrid => "hybrid",
		}
	}
}

#[derive(Clone, Debug)]
pub struct SearchOpts {
	pub mode: Mode,
	pub tries: u64,
	pub members: usize,
	pub seed: u64,
	pub share_every: u64,
	/// The edit descent's cap (edits and hybrid modes); the order after `budget` of them, else
	/// as `cut` says.
	pub edits: Option<usize>,
	pub budget: Option<usize>,
	/// Without a budget: every edit of the descent (the default), or the knee's.
	pub cut: edits::Cut,
	/// A kept move may not slow any character (the shared route: no start loses for another).
	pub no_worse: bool,
}

impl SearchOpts {
	/// forge build's search: `mode` (edits: the descent capped at 400 edits, cut as `cut` says;
	/// free and hybrid: `tries` over `members`, rng 1).
	pub fn forge(mode: Mode, cut: edits::Cut, tries: Option<u64>, members: Option<usize>) -> SearchOpts {
		let d = SearchOpts::default();
		SearchOpts { mode, edits: Some(400), cut, tries: tries.unwrap_or(FORGE_TRIES), members: members.unwrap_or(FORGE_MEMBERS), ..d }
	}
	/// The options as one line (the routes stage's cache key, the route file's `search` facts).
	pub fn key(&self) -> String {
		match self.mode {
			Mode::Edits => format!("edits cut {}", self.cut.name()),
			m => format!("{} tries {} members {} rng {} share {} cut {}", m.name(), self.tries, self.members, self.seed, self.share_every, self.cut.name()),
		}
	}
}

/// forge build's free search (free, hybrid modes) by default: tries and members (RouteSearch030:
/// 2M tries over 24 members reached Orc 112.0 h in ~100 s).
pub const FORGE_TRIES: u64 = 2_000_000;
pub const FORGE_MEMBERS: usize = 24;

impl Default for SearchOpts {
	fn default() -> Self {
		SearchOpts { mode: Mode::Free, tries: 20_000, members: 8, seed: 1, share_every: 250, edits: None, budget: None, cut: edits::Cut::All, no_worse: false }
	}
}

pub use crate::rng::Rng;

/// A canonical step's place in another character's run (the shared route: one order played
/// by every start under every profile): quest index and run point per canonical index, -1
/// where that character has none (its step becomes a no-effect placeholder).
pub struct Mapper {
	pub q: Vec<i32>,
	pub pt: Vec<i32>,
}

impl Mapper {
	pub fn new(from: &Run, to: &Run) -> Mapper {
		Mapper { q: from.q_id.iter().map(|id| to.q(*id).map_or(-1, |x| x as i32)).collect(), pt: from.pt_list.iter().map(|&wp| to.run_pt(wp).map_or(-1, |x| x as i32)).collect() }
	}

	pub fn step(&self, from: &Run, to: &Run, s: Step) -> Step {
		let none = Step::grind(0, 0);
		match s.kind {
			K_GRIND => s,
			K_TRAIN => match self.pt[s.pt as usize] {
				-1 => none,
				p => Step { pt: p as u32, ..s },
			},
			// A riding step only for a start that learns from that trainer (Orc's Kildar is not the
			// Tauren's): its own riding step is its own (shared::keep_own_rest).
			crate::run::K_RIDE => match self.pt[s.pt as usize] {
				p if p >= 0 && to.riding.iter().any(|r| r.0 as i32 == s.task) => Step { pt: p as u32, ..s },
				_ => none,
			},
			_ => {
				let (q, p) = (self.q[s.q as usize], self.pt[s.pt as usize]);
				if q < 0 || p < 0 {
					return none;
				}
				let task = if s.kind == K_TASK {
					(to.q_task0[q as usize] + (s.task as u32 - from.q_task0[s.q as usize])) as i32
				} else if s.kind == K_ACCEPT {
					to.q_accept[q as usize]
				} else {
					-1
				};
				Step { kind: s.kind, q: q as u32, task, pt: p as u32 }
			}
		}
	}
}

/// One character the order is played by: its model, the steps before the order (its own
/// start route, for the shared route) and the mapping from the canonical run.
pub struct CtxSpec<'a> {
	pub model: &'a Model,
	pub prefix: Vec<Step>,
	pub map: Option<Mapper>,
	pub name: String,
}

/// What the search may use: the canonical model (where moves are made), walks, the rules,
/// quests it may add, and the characters that play the order (the score is the sum of their
/// hours to 60).
pub struct Problem<'a> {
	pub model: &'a Model,
	pub walks: &'a dyn Walks,
	pub pairs: Vec<Pair>,
	/// Quests (run indices) that may be inserted: solo, open, not class quests.
	pub pool: Vec<u32>,
	pub ctxs: Vec<CtxSpec<'a>>,
	/// Per quest: the quests that name it as a prerequisite (chain removal).
	pub followers: Vec<Vec<u32>>,
	/// The judge's guards (avoidable returns, passed-by) a kept move may not raise.
	pub guard: Option<Guard>,
	/// Feasibility rules (item needs, escorts).
	pub feas: crate::order::Feas,
	/// Most quests in the log a kept move may reach (the class quests a writer adds need room
	/// under the game's 40): u32::MAX for none.
	pub log_bound: u32,
}

/// Whose counts bound a move: v1's (a move may not take a count above v1's), or the current
/// order's (a kept move never raises a count).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum GuardMode {
	V1,
	Current,
}

pub struct Guard {
	pub data: crate::guards::GuardData,
	pub mode: GuardMode,
	/// The seed's counts.
	pub v1: crate::guards::GuardCounts,
	/// Each training's level in v1's order (by origin): a kept order trains within TRAIN_SHIFT
	/// levels of it (no training moved from 12 to 25).
	pub train_levels: Vec<(i64, f64)>,
}

/// Levels a training may move from where v1's order does it.
pub const TRAIN_SHIFT: f64 = 2.0;

impl Guard {
	/// Trainings of an order more than TRAIN_SHIFT levels from v1's, or dropped.
	pub fn train_shifts(&self, order: &Order, c: &Current) -> u32 {
		let lv = c.levels();
		let off = c.steps.len() - order.len();
		let mut n = 0;
		for &(o, l) in &self.train_levels {
			match order.origin.iter().position(|&x| x == o) {
				Some(k) if order.steps[k].kind == K_TRAIN && (lv.get(k + off).copied().unwrap_or(60.0) - l).abs() <= TRAIN_SHIFT => {}
				_ => n += 1,
			}
		}
		n
	}
}

impl Guard {
	pub fn counts(&self, run: &Run, c: &Current) -> crate::guards::GuardCounts {
		c.guard_counts(&self.data, run)
	}
}

impl Current {
	/// The level before each step.
	pub fn levels(&self) -> &[f64] {
		&self.lv
	}

	/// How the leg into each step was travelled.
	pub fn walked(&self) -> &[crate::eval::Moved] {
		&self.wk
	}

	/// The guards' counts of this run.
	pub fn guard_counts(&self, g: &crate::guards::GuardData, run: &Run) -> crate::guards::GuardCounts {
		crate::guards::guard_counts(g, run, &self.steps, &self.lv, &self.wk)
	}
}

impl<'a> Problem<'a> {
	/// One start: the order played by the canonical model itself.
	pub fn single(model: &'a Model, walks: &'a dyn Walks, pairs: Vec<Pair>, pool: Vec<u32>) -> Problem<'a> {
		Problem {
			model,
			walks,
			pairs,
			pool,
			ctxs: vec![CtxSpec { model, prefix: Vec::new(), map: None, name: String::new() }],
			followers: followers(&model.run),
			guard: None,
			feas: Default::default(),
			log_bound: u32::MAX,
		}
	}

	/// A character's steps for a canonical order.
	pub fn steps_for(&self, k: usize, order: &[Step]) -> Vec<Step> {
		let c = &self.ctxs[k];
		let mut v = Vec::with_capacity(c.prefix.len() + order.len());
		v.extend_from_slice(&c.prefix);
		match &c.map {
			None => v.extend_from_slice(order),
			Some(m) => v.extend(order.iter().map(|&s| m.step(&self.model.run, &c.model.run, s))),
		}
		v
	}
}

/// A character's run of its steps: snapshots every SNAP_EVERY steps (the state before step
/// k * SNAP_EVERY), and after each step the total XP, the cost so far and the level before it.
/// Runs are priced by cost (Evaluator::cost): seconds, each grinding second counted
/// `grindWeight` times, so a route grinds only where no quest is nearly as good.
#[derive(Clone)]
pub struct Current {
	pub steps: Vec<Step>,
	/// Cost to 60 (Evaluator::cost; the real seconds stay in the route's hours blocks).
	pub total: f64,
	snaps: Vec<Snap>,
	xs: Vec<f64>,
	ts: Vec<f64>,
	lv: Vec<f64>,
	/// How the leg into each step was travelled (the passed-by and hub guards).
	wk: Vec<crate::eval::Moved>,
	/// Steps played before level 60 (changes after it change nothing).
	pub live: usize,
	/// Steps that did nothing: a kept move never adds one (a quest is left out only by a drop
	/// move, which keeps the guard; never by an accept moved before its prerequisite).
	pub noops: u32,
	/// Timed quests handed in after their limit (Scalars::late): a kept move never adds one.
	pub late: u32,
	/// The most quests in the log at once.
	pub log_peak: u32,
	/// v1 hearth lines met on cooldown (Scalars::plan_cooldown): a kept move never adds one.
	pub plan_cool: u32,
}

/// Counters of a search.
#[derive(Clone, Debug, Default, serde::Serialize, serde::Deserialize)]
pub struct Stats {
	pub tries: u64,
	pub invalid: u64,
	pub estimated: u64,
	pub exact: u64,
	pub kept: u64,
	/// Gaining moves rejected by the guards.
	pub guard_rejected: u64,
	pub steps_replayed: u64,
	pub by_move: [[u64; 2]; MOVES],
	/// Moves the free search refused by the edit descent's rules (RULE_NAMES order).
	pub refused: [u64; RULES],
}

/// The edit descent's rules a free-search move is held to (Member::rules_ok, levels_ok,
/// no_worse), as counted in Stats::refused.
pub const RULES: usize = 7;
pub const RULE_NAMES: [&str; RULES] = ["checker", "twin training", "walk lengthened", "grind checkpoint", "quest on the way", "objective under level", "a start slower"];

pub const MOVES: usize = 12;
pub const MOVE_NAMES: [&str; MOVES] = [
	"move stop",
	"move objective",
	"move block",
	"insert quest",
	"drop quest",
	"ruin stretch",
	"drop grind",
	"ruin same camp/hub",
	"ruin chain",
	"ruin zone stay",
	"gather same place",
	"held-karp hub order",
];

fn full(ev: &mut Evaluator, steps: Vec<Step>) -> Current {
	ev.reset();
	let n = steps.len();
	let mut c = Current {
		steps,
		total: 0.0,
		snaps: Vec::with_capacity(n / SNAP_EVERY + 2),
		xs: Vec::with_capacity(n),
		ts: Vec::with_capacity(n),
		lv: Vec::with_capacity(n),
		wk: Vec::with_capacity(n),
		live: n,
		noops: 0,
		late: 0,
		log_peak: 0,
		plan_cool: 0,
	};
	for i in 0..n {
		if i % SNAP_EVERY == 0 {
			c.snaps.push(ev.snapshot());
		}
		c.lv.push(ev.level_now());
		if ev.s.finished {
			if c.live == n {
				c.live = i;
			}
			c.wk.push(crate::eval::Moved::STAY);
		} else {
			ev.step_in(&c.steps, i);
			c.wk.push(ev.s.moved);
		}
		c.xs.push(ev.total_xp());
		c.ts.push(ev.cost_now());
	}
	ev.finish();
	c.total = ev.cost();
	c.noops = ev.s.noops;
	c.late = ev.s.late;
	c.log_peak = ev.s.log_peak;
	c.plan_cool = ev.s.plan_cooldown;
	c
}

/// Evaluate an order from scratch: seconds to 60 (real, not the search's cost).
pub fn evaluate(ev: &mut Evaluator, order: &Order) -> f64 {
	let _ = full(ev, order.steps.clone());
	ev.seconds()
}

/// A candidate being replayed by one character.
struct Pending {
	steps: Vec<Step>,
	c0: usize,
	at: usize,
	snaps: Vec<Snap>,
	xs: Vec<f64>,
	ts: Vec<f64>,
	lv: Vec<f64>,
	wk: Vec<crate::eval::Moved>,
	live: usize,
}

/// One character of a member: its evaluator and its run of the member's order.
pub struct Ctx<'a> {
	ev: Evaluator<'a>,
	pub cur: Current,
	off: usize,
}

impl<'a> Ctx<'a> {
	/// Replay `steps` from the snapshot before `a` to `stop`. The estimate of its cost to 60
	/// (exact when it reached 60 or the end), or None past the current run's XP.
	fn window(&mut self, steps: Vec<Step>, a: usize, stop: usize, stats: &mut Stats) -> (Pending, Option<f64>) {
		// The steps before a look ahead at it (the spot term): replay from NEXT_LOOK earlier.
		let c0 = (a.saturating_sub(crate::eval::NEXT_LOOK) / SNAP_EVERY) * SNAP_EVERY;
		self.ev.load(&self.cur.snaps[c0 / SNAP_EVERY]);
		let n = steps.len();
		let mut pd =
			Pending { steps, c0, at: c0, snaps: Vec::new(), xs: Vec::with_capacity(n - c0), ts: Vec::with_capacity(n - c0), lv: Vec::with_capacity(n - c0), wk: Vec::with_capacity(n - c0), live: n };
		self.advance(&mut pd, stop.min(n), stats);
		if pd.at >= n || self.ev.s.finished {
			self.advance(&mut pd, n, stats);
			self.ev.finish();
			return (pd, Some(self.ev.cost()));
		}
		stats.estimated += 1;
		(pd, self.estimate())
	}

	fn advance(&mut self, pd: &mut Pending, to: usize, stats: &mut Stats) {
		let n = pd.steps.len();
		while pd.at < to {
			let i = pd.at;
			if i.is_multiple_of(SNAP_EVERY) && i > pd.c0 {
				pd.snaps.push(self.ev.snapshot());
			}
			pd.lv.push(self.ev.level_now());
			if self.ev.s.finished {
				if pd.live == n {
					pd.live = i;
				}
				pd.wk.push(crate::eval::Moved::STAY);
			} else {
				self.ev.step_in(&pd.steps, i);
				stats.steps_replayed += 1;
				pd.wk.push(self.ev.s.moved);
			}
			pd.xs.push(self.ev.total_xp());
			pd.ts.push(self.ev.cost_now());
			pd.at += 1;
		}
	}

	/// The rest of the replay: the candidate's exact run.
	fn complete(&mut self, mut pd: Pending, stats: &mut Stats) -> Current {
		let n = pd.steps.len();
		if pd.at < n || !self.ev.s.finished {
			self.advance(&mut pd, n, stats);
			self.ev.finish();
		}
		stats.exact += 1;
		let k0 = pd.c0 / SNAP_EVERY;
		let mut snaps = self.cur.snaps[..=k0].to_vec();
		snaps.extend(pd.snaps);
		let cat = |old: &[f64], new: Vec<f64>| {
			let mut v = old[..pd.c0].to_vec();
			v.extend(new);
			v
		};
		Current {
			total: self.ev.cost(),
			noops: self.ev.s.noops,
			late: self.ev.s.late,
			log_peak: self.ev.s.log_peak,
			plan_cool: self.ev.s.plan_cooldown,
			xs: cat(&self.cur.xs, pd.xs),
			ts: cat(&self.cur.ts, pd.ts),
			lv: cat(&self.cur.lv, pd.lv),
			wk: {
				let mut v = self.cur.wk[..pd.c0].to_vec();
				v.extend(pd.wk);
				v
			},
			snaps,
			steps: pd.steps,
			live: pd.live,
		}
	}

	/// The current run's cost to 60 shifted by how much later (or sooner) the candidate is
	/// than the current run was at the same total XP. None past the current run's XP.
	fn estimate(&self) -> Option<f64> {
		let xp = self.ev.total_xp();
		let t = self.ev.cost_now();
		let xs = &self.cur.xs;
		let j = xs.partition_point(|&x| x < xp);
		if j >= xs.len() {
			return None;
		}
		let at = if j == 0 {
			self.cur.ts[0]
		} else {
			let (x0, x1) = (xs[j - 1], xs[j]);
			let f = if x1 > x0 { (xp - x0) / (x1 - x0) } else { 1.0 };
			self.cur.ts[j - 1] + f * (self.cur.ts[j] - self.cur.ts[j - 1])
		};
		Some(self.cur.total + t - at)
	}
}

/// One searcher: its order (canonical), the characters' runs of it, generator, counters.
pub struct Member<'a> {
	pub order: Order,
	pub ctxs: Vec<Ctx<'a>>,
	rng: Rng,
	check: Checker,
	pub stats: Stats,
	in_order: Vec<bool>,
	/// Steps of the order played before 60 by the first character, and its level before each.
	live: usize,
	lv: Vec<f64>,
	/// The guards' counts of the current order.
	pub guard_now: crate::guards::GuardCounts,
	/// Seconds a kept move may add to the hours to 60 (the pickup allowance; 0 in the search).
	pub allow: f64,
	/// A kept move may not slow any character (SearchOpts::no_worse).
	pub no_worse: bool,
	/// A tie (passby::bag_ties): an avoidable return it adds in an area need not be paid for by its
	/// gain (the total stays bounded).
	pub tie: bool,
}

fn d(run: &Run, a: u32, b: u32) -> f64 {
	let x = run.straight(a, b);
	if x.is_finite() {
		x
	} else {
		FAR_YD
	}
}

/// Where each step of an order is (a grind checkpoint is where the step before it was).
pub fn locs(run: &Run, steps: &[Step]) -> Vec<u32> {
	let mut v = Vec::with_capacity(steps.len());
	let mut at = run.start_pt;
	for s in steps {
		if s.kind != K_GRIND {
			at = s.pt;
		}
		v.push(at);
	}
	v
}

/// The cheapest place for `x` in `steps[lo..=hi]` (insert before that index) by the straight
/// detour from the step before to the one after.
fn cheapest(run: &Run, steps: &[Step], loc: &[u32], x: u32, lo: usize, hi: usize) -> usize {
	let hi = hi.min(steps.len());
	let mut best = (f64::INFINITY, lo);
	for j in lo..=hi {
		let prev = if j == 0 { run.start_pt } else { loc[j - 1] };
		let c = if j == steps.len() { d(run, prev, x) } else { d(run, prev, x) + d(run, x, loc[j]) - d(run, prev, loc[j]) };
		if c < best.0 {
			best = (c, j);
		}
	}
	best.1
}

/// The `k` cheapest places for `x` in `steps[lo..=hi]` (as `cheapest`), cheapest first.
fn cheapest_k(run: &Run, steps: &[Step], loc: &[u32], x: u32, lo: usize, hi: usize, k: usize) -> Vec<usize> {
	let hi = hi.min(steps.len());
	let mut all: Vec<(f64, usize)> = (lo..=hi)
		.map(|j| {
			let prev = if j == 0 { run.start_pt } else { loc[j - 1] };
			(if j == steps.len() { d(run, prev, x) } else { d(run, prev, x) + d(run, x, loc[j]) - d(run, prev, loc[j]) }, j)
		})
		.collect();
	all.sort_by(|a, b| a.0.total_cmp(&b.0).then(a.1.cmp(&b.1)));
	all.into_iter().take(k).map(|x| x.1).collect()
}

fn quest_rank(k: u8) -> u8 {
	match k {
		K_ACCEPT => 0,
		K_TASK => 1,
		_ => 2,
	}
}

impl<'a> Member<'a> {
	pub fn new(p: &Problem<'a>, order: Order, runs: &[Current], seed: u64) -> Member<'a> {
		let run = &p.model.run;
		let ctxs = p.ctxs.iter().zip(runs).map(|(c, cur)| Ctx { ev: c.model.evaluator(p.walks), cur: cur.clone(), off: c.prefix.len() }).collect();
		let mut m = Member {
			order,
			ctxs,
			rng: Rng::new(seed),
			check: Checker::new(run),
			stats: Stats::default(),
			in_order: vec![false; run.n_quests()],
			live: 0,
			lv: Vec::new(),
			guard_now: Default::default(),
			allow: 0.0,
			no_worse: false,
			tie: false,
		};
		if let Some(g) = &p.guard {
			m.guard_now = g.counts(run, &m.ctxs[0].cur);
		}
		m.refresh();
		m
	}

	/// Cost to 60 (seconds, grinding weighted: Current::total) summed over the characters.
	pub fn total(&self) -> f64 {
		self.ctxs.iter().map(|c| c.cur.total).sum()
	}

	fn refresh(&mut self) {
		self.in_order.fill(false);
		for s in &self.order.steps {
			if s.kind == K_ACCEPT {
				self.in_order[s.q as usize] = true;
			}
		}
		let c = &self.ctxs[0];
		self.live = c.cur.live.saturating_sub(c.off).min(self.order.len());
		self.lv = c.cur.lv[c.off..].to_vec();
	}

	/// Take another member's order and runs (a meeting).
	fn take(&mut self, o: &Member) {
		self.order = o.order.clone();
		self.guard_now = o.guard_now.clone();
		for (c, oc) in self.ctxs.iter_mut().zip(&o.ctxs) {
			c.cur = oc.cur.clone();
		}
		self.refresh();
	}

	/// Test oracle (fg's FG_VERIFY): make a move of `kind` and return the candidate's seconds
	/// to 60 by the windowed replay from the snapshot before the change (run to the end) and by a
	/// replay from scratch; None when the move makes no candidate or breaks the rules.
	pub fn verify_move(&mut self, p: &Problem, kind: usize) -> Option<(f64, f64)> {
		let (cand, a, _) = self.make_move(p, kind)?;
		if a >= self.live || !self.check.valid(&cand.steps, &p.pairs, &p.feas) {
			return None;
		}
		let steps = p.steps_for(0, &cand.steps);
		let c = &mut self.ctxs[0];
		let mut st = Stats::default();
		let (pd, _) = c.window(steps.clone(), a + c.off, usize::MAX, &mut st);
		let inc = c.complete(pd, &mut st).total;
		let mut ev = p.ctxs[0].model.evaluator(p.walks);
		Some((inc, full(&mut ev, steps).total))
	}

	/// One try: a move, its check, its estimate and (when promising) its exact replay.
	pub fn try_one(&mut self, p: &Problem) {
		self.stats.tries += 1;
		// (Nothing played before 60: no move to make; a shared tail can be empty.)
		if self.live == 0 {
			self.stats.invalid += 1;
			return;
		}
		let kind = self.pick_move();
		let Some((cand, a, b)) = self.make_move(p, kind) else {
			self.stats.invalid += 1;
			return;
		};
		if a >= self.live || !self.rules_ok(p, &cand, a, b) {
			self.stats.invalid += 1;
			return;
		}
		self.stats.by_move[kind][0] += 1;
		if let Some((next, gc)) = self.replay(p, &cand, a, b) {
			if self.no_worse && next.iter().zip(&self.ctxs).any(|(n, c)| n.total > c.cur.total + 1e-6) {
				self.stats.refused[6] += 1;
				return;
			}
			if !self.levels_ok(p, &cand, &next) {
				self.stats.refused[5] += 1;
				return;
			}
			self.guard_now = gc;
			self.stats.by_move[kind][1] += 1;
			self.stats.kept += 1;
			for (c, cur) in self.ctxs.iter_mut().zip(next) {
				c.cur = cur;
			}
			self.order = cand;
			self.refresh();
		}
	}

	/// The rules a free-search move keeps before its replay, beyond the replay's own (no added
	/// no-op, late hand-in, hearth line on cooldown, log over its bound, guard raised), as the
	/// edit descent keeps them (edits::candidates, Member::est_gain): the checker (quest step
	/// order, deliberate pairs, item needs and lock keys, `after`/`stay` records, together, keep,
	/// skip, southward, escorts); no training right after a training it did not have; a
	/// reordering (same steps) adds at most PATH_SLACK_YD to the straight walk over the stretch it
	/// changes; v1's grind checkpoints stay unless they guard no gate (Feas::free_grinds); a quest
	/// dropped costs a trip (not every stop on the way).
	pub(crate) fn rules_ok(&mut self, p: &Problem, cand: &Order, a: usize, b: usize) -> bool {
		if !self.check.valid(&cand.steps, &p.pairs, &p.feas) {
			self.stats.refused[0] += 1;
			return false;
		}
		if edits::twin_trainings(cand) > edits::twin_trainings(&self.order) {
			self.stats.refused[1] += 1;
			return false;
		}
		let run = &p.model.run;
		let o = &self.order;
		if cand.len() == o.len() {
			let hi = (b + 1).min(cand.len() - 1);
			let ok = a > hi || edits::path_len(run, &cand.steps, a, hi) <= edits::path_len(run, &o.steps, a, hi) + edits::PATH_SLACK_YD;
			self.stats.refused[2] += u64::from(!ok);
			return ok;
		}
		let grinds = |x: &Order| x.steps.iter().zip(&x.origin).filter(|(s, g)| s.kind == K_GRIND && !p.feas.free_grinds.contains(g)).count();
		if grinds(cand) < grinds(o) {
			self.stats.refused[3] += 1;
			return false;
		}
		if cand.len() < o.len() {
			let mut kept = vec![false; run.n_quests()];
			for s in cand.steps.iter().filter(|s| s.kind == K_ACCEPT) {
				kept[s.q as usize] = true;
			}
			let dropped = o.steps.iter().filter(|s| s.kind == K_ACCEPT && !kept[s.q as usize]);
			for s in dropped {
				if on_the_way(run, &o.steps, s.q) {
					self.stats.refused[4] += 1;
					return false;
				}
			}
		}
		true
	}

	/// The edit descent's under-level rule after a replay (edits::UNDER_LEVEL): no objective is
	/// done at a lower level than before where that level is more than UNDER_LEVEL under its
	/// quest's (the Daggerspine naga, 30-31, at 26).
	pub(crate) fn levels_ok(&self, p: &Problem, cand: &Order, next: &[Current]) -> bool {
		self.levels_ok_by(p, cand, next, 0.0)
	}

	/// levels_ok, an objective allowed `slack` levels lower than before (a hand-in moved later
	/// delays its XP: the work between it and its new place comes a little lower).
	pub(crate) fn levels_ok_by(&self, p: &Problem, cand: &Order, next: &[Current], slack: f64) -> bool {
		let run = &p.model.run;
		let off = self.ctxs[0].off;
		let lv = &next[0].lv;
		let mut before: rustc_hash::FxHashMap<i32, f64> = Default::default();
		for (k, s) in self.order.steps.iter().enumerate().take(self.live) {
			if s.kind == K_TASK {
				before.insert(s.task, self.lv[k]);
			}
		}
		cand.steps.iter().enumerate().all(|(k, s)| {
			if s.kind != K_TASK {
				return true;
			}
			let Some(&now) = lv.get(k + off) else { return true };
			now >= run.q_level[s.q as usize] as f64 - edits::UNDER_LEVEL || before.get(&s.task).is_none_or(|&was| now >= was - slack - 1e-9)
		})
	}

	fn pick_move(&mut self) -> usize {
		// Weights in percent, by MOVE_NAMES order. (No grind checkpoint is dropped: rules_ok; its
		// share goes to moving objectives.)
		const W: [usize; MOVES] = [14, 16, 10, 15, 5, 8, 0, 8, 6, 6, 6, 6];
		let mut r = self.rng.below(100);
		for (k, &w) in W.iter().enumerate() {
			if r < w {
				return k;
			}
			r -= w;
		}
		MOVES - 1
	}

	/// Replay a candidate for every character from the snapshot before `a`: the windows, the
	/// summed estimate, then (when it promises a gain) the exact runs. The new runs when the
	/// summed seconds to 60 drop and no character's run gains a step that does nothing.
	fn replay(&mut self, p: &Problem, cand: &Order, a: usize, b: usize) -> Option<(Vec<Current>, crate::guards::GuardCounts)> {
		let now = self.total();
		// No training put inside a field stretch (order::field_trains).
		let run = &p.model.run;
		if crate::order::field_trains(run, &cand.steps) > crate::order::field_trains(run, &self.order.steps) {
			return None;
		}
		let mut pend = Vec::with_capacity(self.ctxs.len());
		let mut est = 0.0;
		let mut sure = true;
		for (k, c) in self.ctxs.iter_mut().enumerate() {
			let steps = p.steps_for(k, &cand.steps);
			let (pd, e) = c.window(steps, a + c.off, b + c.off + WINDOW, &mut self.stats);
			match e {
				Some(e) => est += e,
				None => sure = false,
			}
			pend.push(pd);
		}
		let limit = now - MIN_GAIN + self.allow;
		if sure && est >= limit {
			return None;
		}
		let mut next = Vec::with_capacity(pend.len());
		for (c, pd) in self.ctxs.iter_mut().zip(pend) {
			let cur = c.complete(pd, &mut self.stats);
			if cur.noops > c.cur.noops || cur.late > c.cur.late || cur.plan_cool > c.cur.plan_cool || (cur.log_peak > p.log_bound && cur.log_peak > c.cur.log_peak) {
				return None;
			}
			next.push(cur);
		}
		let total: f64 = next.iter().map(|c| c.total).sum();
		if total >= limit {
			return None;
		}
		let mut gc = self.guard_now.clone();
		if let Some(g) = &p.guard {
			gc = g.counts(&p.model.run, &next[0]);
			// Returns, passed-by and training gaps bounded by the mode's counts; split work by
			// v1's per zone (never more separate visits to one place than v1 makes).
			let mut bound = if g.mode == GuardMode::V1 { g.v1.clone() } else { self.guard_now.clone() };
			bound.split_by_zone = g.v1.split_by_zone.clone();
			bound.area_visits = g.v1.area_visits.clone();
			for (list, now) in [(&mut bound.split_by_zone, &self.guard_now.split_by_zone), (&mut bound.area_visits, &self.guard_now.area_visits)] {
				for (z, n) in now {
					if let Some(x) = list.iter_mut().find(|x| x.0 == *z) {
						x.1 = x.1.max(*n);
					} else {
						list.push((*z, *n));
					}
				}
			}
			let ok = if self.allow > 0.0 { gc.within_judge(&bound) } else { gc.within(&bound) };
			// Avoidable returns: the total never above the bound's (as before), and area by area
			// against the current order, each one added must also be paid for by RETURN_COST_SEC of
			// the move's gain (one removed elsewhere does not pay for it).
			let added = gc.added_returns(&self.guard_now);
			let paid = now - total >= MIN_GAIN + f64::from(added) * crate::guards::RETURN_COST_SEC;
			let total_ok = gc.avoidable_returns <= bound.avoidable_returns;
			if !ok || !total_ok || (added > 0 && !paid && !self.tie) || g.train_shifts(cand, &next[0]) > 0 {
				self.stats.guard_rejected += 1;
				return None;
			}
		}
		Some((next, gc))
	}

	fn make_move(&mut self, p: &Problem, kind: usize) -> Option<(Order, usize, usize)> {
		match kind {
			0 => self.move_stop(p, false),
			1 => self.move_stop(p, true),
			2 => self.move_block(p),
			3 => self.insert_quest(p),
			4 => self.drop_quest(p),
			5 => self.ruin(p),
			6 => self.drop_grind(),
			7 => self.ruin_near(p),
			8 => self.ruin_chain(p),
			9 => self.ruin_zone(p),
			10 => self.gather(p),
			_ => self.held_karp(p),
		}
	}

	/// Move one stop (any, or an objective site) to the cheapest detour within its quest's
	/// bounds (or, one time in four, anywhere there).
	fn move_stop(&mut self, p: &Problem, task_only: bool) -> Option<(Order, usize, usize)> {
		let run = &p.model.run;
		let o = &self.order;
		let live = self.live.min(o.len());
		if live < 3 {
			return None;
		}
		let i = (0..8).map(|_| self.rng.below(live)).find(|&i| !task_only || o.steps[i].kind == K_TASK)?;
		let s = o.steps[i];
		let mut lo = i.saturating_sub(STOP_REACH);
		let mut hi = (i + STOP_REACH).min(o.len() - 1);
		if matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN) {
			for j in (lo..i).rev() {
				if o.steps[j].q == s.q && matches!(o.steps[j].kind, K_ACCEPT | K_TASK | K_TURNIN) && quest_rank(o.steps[j].kind) < quest_rank(s.kind) {
					lo = j + 1;
					break;
				}
			}
			for j in i + 1..=hi {
				if o.steps[j].q == s.q && matches!(o.steps[j].kind, K_ACCEPT | K_TASK | K_TURNIN) && quest_rank(o.steps[j].kind) > quest_rank(s.kind) {
					hi = j - 1;
					break;
				}
			}
		}
		let mut steps = o.steps.clone();
		let mut origin = o.origin.clone();
		steps.remove(i);
		let og = origin.remove(i);
		let hi = hi.min(steps.len());
		if lo > hi {
			return None;
		}
		let loc = locs(run, &steps);
		let mut x = s;
		let j = if self.rng.chance(0.25) {
			lo + self.rng.below(hi - lo + 1)
		} else {
			cheapest(run, &steps, &loc, if s.kind == K_GRIND { loc[i.saturating_sub(1).min(loc.len() - 1)] } else { s.pt }, lo, hi)
		};
		if j == i {
			return None;
		}
		if s.kind == K_TRAIN {
			let from = if j == 0 { run.start_pt } else { loc[j - 1] };
			x.pt = train_town(run, s, og, from)?;
		}
		steps.insert(j, x);
		origin.insert(j, og);
		Some((Order { steps, origin }, i.min(j), i.max(j)))
	}

	/// Move a block: the zone stay around a step, or a short stretch, to the cheapest place
	/// within BLOCK_REACH.
	fn move_block(&mut self, p: &Problem) -> Option<(Order, usize, usize)> {
		let run = &p.model.run;
		let o = &self.order;
		let live = self.live.min(o.len());
		if live < 4 {
			return None;
		}
		let i = self.rng.below(live);
		let (s, e) = if self.rng.chance(0.5) {
			let loc = locs(run, &o.steps);
			let m = run.p_map[loc[i] as usize];
			let mut s = i;
			while s > 0 && i - s < BLOCK_MAX && run.p_map[loc[s - 1] as usize] == m {
				s -= 1;
			}
			let mut e = i;
			while e + 1 < o.len() && e - s < BLOCK_MAX && run.p_map[loc[e + 1] as usize] == m {
				e += 1;
			}
			(s, e)
		} else {
			let len = 2 + self.rng.below(11);
			(i, (i + len - 1).min(o.len() - 1))
		};
		if s == 0 && e + 1 >= o.len() {
			return None;
		}
		let block: Vec<Step> = o.steps[s..=e].to_vec();
		let borg: Vec<i64> = o.origin[s..=e].to_vec();
		let mut steps = o.steps.clone();
		let mut origin = o.origin.clone();
		steps.drain(s..=e);
		origin.drain(s..=e);
		let loc = locs(run, &steps);
		let first = block.iter().find(|x| x.kind != K_GRIND).map(|x| x.pt)?;
		let last = block.iter().rev().find(|x| x.kind != K_GRIND).map(|x| x.pt)?;
		let lo = s.saturating_sub(BLOCK_REACH);
		let hi = (s + BLOCK_REACH).min(steps.len());
		let mut best = (f64::INFINITY, s);
		for j in lo..=hi {
			if j == s {
				continue;
			}
			let prev = if j == 0 { run.start_pt } else { loc[j - 1] };
			let c = if j == steps.len() { d(run, prev, first) } else { d(run, prev, first) + d(run, last, loc[j]) - d(run, prev, loc[j]) };
			if c < best.0 {
				best = (c, j);
			}
		}
		let j = if self.rng.chance(0.2) { lo + self.rng.below(hi - lo + 1) } else { best.1 };
		if j == s {
			return None;
		}
		for (k, (x, g)) in block.into_iter().zip(borg).enumerate() {
			steps.insert(j + k, x);
			origin.insert(j + k, g);
		}
		let a = s.min(j);
		let b = (e.max(j + (e - s))).min(steps.len() - 1);
		Some((Order { steps, origin }, a, b))
	}

	/// Whether quest q can be taken at a point of the order where the level is `lv`.
	fn level_ok(p: &Problem, q: usize, lv: f64) -> bool {
		let r = &p.model.run;
		let pp = &p.model.tables.p;
		let opens = (r.q_min_level[q] as f64 - pp.gate_gap).max(r.q_level[q] as f64 - pp.danger_gap - pp.gate_gap);
		lv.floor() >= opens && (r.q_level[q] as f64) >= lv.floor() - 5.0
	}

	/// Insert a quest: its accept at the cheapest stop near its giver where the level allows
	/// it, then each objective site and the turn-in at their cheapest places after it.
	fn insert_quest(&mut self, p: &Problem) -> Option<(Order, usize, usize)> {
		let run = &p.model.run;
		if p.pool.is_empty() {
			return None;
		}
		let q = (0..16).map(|_| p.pool[self.rng.below(p.pool.len())]).find(|&q| !self.in_order[q as usize])?;
		let qi = q as usize;
		let o = &self.order;
		let live = self.live.min(o.len());
		let loc = locs(run, &o.steps);
		let giver = run.q_giver[qi];
		// Stops passing the giver where the level allows it.
		let mut best = (f64::INFINITY, usize::MAX);
		for j in 1..live {
			let dd = d(run, loc[j - 1], giver);
			if dd > PASSED_BY_YD || !Self::level_ok(p, qi, self.lv[j]) {
				continue;
			}
			let c = dd + d(run, giver, loc[j]) - d(run, loc[j - 1], loc[j]);
			if c < best.0 {
				best = (c, j);
			}
		}
		if best.1 == usize::MAX {
			return None;
		}
		let mut steps = o.steps.clone();
		let mut origin = o.origin.clone();
		let quest = crate::seq::quest_steps(run, q);
		let acc = best.1;
		steps.insert(acc, quest[0]);
		origin.insert(acc, INSERTED);
		// Objective sites anywhere after the accept; the turn-in after the latest site.
		let mut latest = acc;
		let mut last = acc;
		for &x in &quest[1..] {
			let loc = locs(run, &steps);
			let lo = if x.kind == K_TASK { acc + 1 } else { latest + 1 };
			let hi = (lo + INSERT_SPAN).min(steps.len());
			let j = cheapest(run, &steps, &loc, x.pt, lo.min(steps.len()), hi);
			steps.insert(j, x);
			origin.insert(j, INSERTED);
			if j <= latest {
				latest += 1;
			}
			if j <= last {
				last += 1;
			}
			if x.kind == K_TASK {
				latest = latest.max(j);
			}
			last = last.max(j);
		}
		Some((Order { steps, origin }, acc, last))
	}

	/// Drop a quest: every step of it. Only a quest that costs a trip: one with every stop on
	/// the way (each within PASSED_BY_YD of another quest's stop nearby in the order) is an
	/// obvious quest the route keeps (the guard against missed quests).
	fn drop_quest(&mut self, p: &Problem) -> Option<(Order, usize, usize)> {
		let o = &self.order;
		let live = self.live.min(o.len());
		let i = (0..8).map(|_| self.rng.below(live.max(1))).find(|&i| o.steps[i].kind == K_ACCEPT)?;
		let q = o.steps[i].q;
		if on_the_way(&p.model.run, &o.steps, q) {
			return None;
		}
		let mut steps = Vec::with_capacity(o.len());
		let mut origin = Vec::with_capacity(o.len());
		let (mut a, mut b) = (usize::MAX, 0);
		for (k, s) in o.steps.iter().enumerate() {
			if s.q == q && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN) {
				a = a.min(k);
				b = k;
				continue;
			}
			steps.push(*s);
			origin.push(o.origin[k]);
		}
		Some((Order { steps, origin }, a, b.saturating_sub(1).max(a)))
	}
}

/// Steps around a quest's stop searched for another quest's stop nearby (on_the_way).
pub const ON_THE_WAY_STEPS: usize = 40;

/// Whether every stop of quest q is on the way: within PASSED_BY_YD of a stop of another
/// quest within ON_THE_WAY_STEPS steps of it.
pub fn on_the_way(run: &Run, steps: &[Step], q: u32) -> bool {
	let own = |s: &Step| s.q == q && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN);
	steps.iter().enumerate().filter(|(_, s)| own(s)).all(|(i, s)| {
		let lo = i.saturating_sub(ON_THE_WAY_STEPS);
		let hi = (i + ON_THE_WAY_STEPS + 1).min(steps.len());
		steps[lo..hi].iter().any(|x| !own(x) && x.kind != K_GRIND && d(run, x.pt, s.pt) <= PASSED_BY_YD)
	})
}

impl<'a> Member<'a> {
	/// Ruin a stretch (every quest with a step in it comes out) and recreate it: each quest
	/// back at its cheapest places, one in eight left out.
	fn ruin(&mut self, p: &Problem) -> Option<(Order, usize, usize)> {
		let o = &self.order;
		let live = self.live.min(o.len());
		if live < 10 {
			return None;
		}
		let len = 8 + self.rng.below(33);
		let s = self.rng.below(live.saturating_sub(len).max(1));
		let e = (s + len).min(o.len());
		let qs: Vec<u32> = o.steps[s..e].iter().filter(|x| matches!(x.kind, K_ACCEPT | K_TASK | K_TURNIN)).map(|x| x.q).collect();
		self.ruin_quests(p, qs, (e - s) + 40)
	}

	/// Same-camp / hub (Shaw) removal: every quest with a stop within NEAR_YD of a stop's place
	/// within RUIN_WINDOW steps of it.
	fn ruin_near(&mut self, p: &Problem) -> Option<(Order, usize, usize)> {
		let run = &p.model.run;
		let o = &self.order;
		let live = self.live.min(o.len());
		let i = (0..8).map(|_| self.rng.below(live.max(1))).find(|&i| o.steps.get(i).is_some_and(|s| s.kind != K_GRIND))?;
		let at = o.steps[i].pt;
		let lo = i.saturating_sub(RUIN_WINDOW);
		let hi = (i + RUIN_WINDOW).min(o.len());
		let qs: Vec<u32> = o.steps[lo..hi].iter().filter(|x| matches!(x.kind, K_ACCEPT | K_TASK | K_TURNIN) && d(run, x.pt, at) <= NEAR_YD).map(|x| x.q).collect();
		self.ruin_quests(p, qs, 2 * RUIN_WINDOW)
	}

	/// Chain removal: a quest and the quests it is linked to by prerequisites (either way)
	/// that the order holds, up to CHAIN_MAX.
	fn ruin_chain(&mut self, p: &Problem) -> Option<(Order, usize, usize)> {
		let run = &p.model.run;
		let o = &self.order;
		let live = self.live.min(o.len());
		let i = (0..8).map(|_| self.rng.below(live.max(1))).find(|&i| o.steps.get(i).is_some_and(|s| s.kind == K_ACCEPT))?;
		let mut chain = vec![o.steps[i].q];
		let mut k = 0;
		while k < chain.len() && chain.len() < CHAIN_MAX {
			let q = chain[k] as usize;
			let mut linked: Vec<u32> = run.q_pre[q].iter().chain(&run.q_all[q]).chain(&run.q_after[q]).copied().collect();
			if run.q_parent[q] >= 0 {
				linked.push(run.q_parent[q] as u32);
			}
			linked.extend(p.followers[q].iter().copied());
			for x in linked {
				if self.in_order[x as usize] && !chain.contains(&x) && chain.len() < CHAIN_MAX {
					chain.push(x);
				}
			}
			k += 1;
		}
		if chain.len() < 2 {
			return None;
		}
		self.ruin_quests(p, chain, INSERT_SPAN)
	}

	/// Zone-stay string removal (SISR): every quest with a stop in one zone stay.
	fn ruin_zone(&mut self, p: &Problem) -> Option<(Order, usize, usize)> {
		let run = &p.model.run;
		let o = &self.order;
		let live = self.live.min(o.len());
		if live < 4 {
			return None;
		}
		let i = self.rng.below(live);
		let loc = locs(run, &o.steps);
		let m = run.p_map[loc[i] as usize];
		let mut s = i;
		while s > 0 && i - s < 2 * BLOCK_MAX && run.p_map[loc[s - 1] as usize] == m {
			s -= 1;
		}
		let mut e = i;
		while e + 1 < o.len() && e - s < 2 * BLOCK_MAX && run.p_map[loc[e + 1] as usize] == m {
			e += 1;
		}
		let qs: Vec<u32> = o.steps[s..=e].iter().filter(|x| matches!(x.kind, K_ACCEPT | K_TASK | K_TURNIN)).map(|x| x.q).collect();
		self.ruin_quests(p, qs, (e - s) + 80)
	}

	/// Take quests out (every stop) and put each back at its cheapest places, accepts within
	/// `span` steps of where the first came out; one in eight left out when off the way.
	fn ruin_quests(&mut self, p: &Problem, mut qs: Vec<u32>, span: usize) -> Option<(Order, usize, usize)> {
		let run = &p.model.run;
		let o = &self.order;
		qs.sort_unstable();
		qs.dedup();
		if qs.is_empty() {
			return None;
		}
		// Each ruined quest's steps, in order, with their origins.
		let mut taken: Vec<(u32, Vec<(Step, i64)>)> = qs.iter().map(|&q| (q, Vec::new())).collect();
		let mut steps = Vec::with_capacity(o.len());
		let mut origin = Vec::with_capacity(o.len());
		let (mut a, mut removed_last) = (usize::MAX, 0usize);
		for (k, x) in o.steps.iter().enumerate() {
			if matches!(x.kind, K_ACCEPT | K_TASK | K_TURNIN) {
				if let Ok(t) = qs.binary_search(&x.q) {
					taken[t].1.push((*x, o.origin[k]));
					a = a.min(k);
					removed_last = k;
					continue;
				}
			}
			steps.push(*x);
			origin.push(o.origin[k]);
		}
		// Shuffle (Fisher-Yates) and recreate.
		for k in (1..taken.len()).rev() {
			let j = self.rng.below(k + 1);
			taken.swap(k, j);
		}
		let mut b = a.max(removed_last.saturating_sub(qs.len()));
		let lo0 = a.saturating_sub(10);
		for (q, list) in taken {
			if self.rng.chance(0.125) && !on_the_way(run, &o.steps, q) {
				continue;
			}
			let lo = lo0;
			let mut acc = None;
			let mut latest_task = None;
			for (x, g) in list {
				let loc = locs(run, &steps);
				let (from, sp) = match x.kind {
					K_ACCEPT => (lo, span),
					K_TASK => (acc.map_or(lo, |p: usize| p + 1), INSERT_SPAN),
					_ => (latest_task.or(acc).map_or(lo, |p: usize| p + 1), INSERT_SPAN),
				};
				let hi = (from + sp).min(steps.len());
				let j = cheapest(run, &steps, &loc, x.pt, from.min(steps.len()), hi);
				steps.insert(j, x);
				origin.insert(j, g);
				// positions after j shift by one
				acc = acc.map(|p| if p >= j { p + 1 } else { p });
				latest_task = latest_task.map(|p| if p >= j { p + 1 } else { p });
				match x.kind {
					K_ACCEPT => acc = Some(j),
					K_TASK => latest_task = Some(latest_task.map_or(j, |p| p.max(j))),
					_ => {}
				}
				a = a.min(j);
				b = b.max(j);
			}
		}
		Some((Order { steps, origin }, a.min(b), b))
	}

	/// Same-place grouping (fg together.rs `bring_together`): the later stops within GATHER_YD of
	/// a stop's place, up to GATHER_AHEAD steps on, move right after it.
	fn gather(&mut self, p: &Problem) -> Option<(Order, usize, usize)> {
		let run = &p.model.run;
		let o = &self.order;
		let live = self.live.min(o.len());
		let i = (0..8).map(|_| self.rng.below(live.max(1))).find(|&i| o.steps.get(i).is_some_and(|s| s.kind != K_GRIND))?;
		let at = o.steps[i].pt;
		let hi = (i + GATHER_AHEAD + 1).min(o.len());
		let far: Vec<usize> = (i + 1..hi).filter(|&j| o.steps[j].kind != K_GRIND && d(run, o.steps[j].pt, at) <= GATHER_YD).collect();
		// Only stops not already next to it.
		let first_gap = far.iter().enumerate().find(|(k, &j)| j != i + 1 + k).map(|(k, _)| k)?;
		let moving = &far[first_gap..];
		let last = *moving.last()?;
		let mut steps = Vec::with_capacity(o.len());
		let mut origin = Vec::with_capacity(o.len());
		for k in 0..o.len() {
			if moving.binary_search(&k).is_ok() {
				continue;
			}
			steps.push(o.steps[k]);
			origin.push(o.origin[k]);
			if k == i + first_gap {
				for &j in moving {
					steps.push(o.steps[j]);
					origin.push(o.origin[j]);
				}
			}
		}
		Some((Order { steps, origin }, i, last))
	}

	/// Exact in-hub ordering (Held-Karp over subsets, DeepResearch §2.2): the consecutive stops
	/// within HUB_YD of a stop's place (up to HK_MAX) in the order of the least straight walk from
	/// the stop before to the stop after, accept before objectives before turn-in and v1's
	/// deliberate pairs kept.
	fn held_karp(&mut self, p: &Problem) -> Option<(Order, usize, usize)> {
		let run = &p.model.run;
		let o = &self.order;
		let live = self.live.min(o.len());
		let i = (0..8).map(|_| self.rng.below(live.max(1))).find(|&i| o.steps.get(i).is_some_and(|s| s.kind != K_GRIND))?;
		let at = o.steps[i].pt;
		let mut e = i;
		while e + 1 < o.len() && e + 1 - i < HK_MAX && o.steps[e + 1].kind != K_GRIND && d(run, o.steps[e + 1].pt, at) <= HUB_YD {
			e += 1;
		}
		let n = e + 1 - i;
		if n < 3 {
			return None;
		}
		let nodes = &o.steps[i..=e];
		let before = if i == 0 { run.start_pt } else { locs(run, &o.steps[..i]).last().copied().unwrap_or(run.start_pt) };
		let after = o.steps[e + 1..].iter().find(|s| s.kind != K_GRIND).map(|s| s.pt);
		// pred[v]: the nodes that must come before v.
		let mut pred = vec![0u32; n];
		for (v, sv) in nodes.iter().enumerate() {
			for (u, su) in nodes.iter().enumerate() {
				if u == v {
					continue;
				}
				let same = su.q == sv.q && matches!(su.kind, K_ACCEPT | K_TASK | K_TURNIN) && matches!(sv.kind, K_ACCEPT | K_TASK | K_TURNIN);
				let by_quest = same && quest_rank(su.kind) < quest_rank(sv.kind);
				let by_pair = p.pairs.iter().any(|pr| pr.qa == su.q && pr.ka == su.kind && pr.qb == sv.q && pr.kb == sv.kind);
				if by_quest || by_pair {
					pred[v] |= 1 << u;
				}
			}
		}
		let dist = |a: u32, b: u32| d(run, a, b);
		let full = (1usize << n) - 1;
		let mut dp = vec![f64::INFINITY; (1 << n) * n];
		let mut from = vec![u8::MAX; (1 << n) * n];
		for v in 0..n {
			if pred[v] == 0 {
				dp[(1 << v) * n + v] = dist(before, nodes[v].pt);
			}
		}
		for mask in 1..=full {
			for v in 0..n {
				let c = dp[mask * n + v];
				if !c.is_finite() {
					continue;
				}
				for w in 0..n {
					if mask & (1 << w) != 0 || (pred[w] as usize) & !mask != 0 {
						continue;
					}
					let m2 = mask | (1 << w);
					let c2 = c + dist(nodes[v].pt, nodes[w].pt);
					if c2 < dp[m2 * n + w] - 1e-9 {
						dp[m2 * n + w] = c2;
						from[m2 * n + w] = v as u8;
					}
				}
			}
		}
		let end = |v: usize| dp[full * n + v] + after.map_or(0.0, |a| dist(nodes[v].pt, a));
		let last = (0..n).min_by(|&a, &b| end(a).total_cmp(&end(b)))?;
		let mut cur = 0.0;
		let mut prev = before;
		for s in nodes {
			cur += dist(prev, s.pt);
			prev = s.pt;
		}
		cur += after.map_or(0.0, |a| dist(prev, a));
		if end(last) >= cur - 1.0 {
			return None;
		}
		let mut seq = Vec::with_capacity(n);
		let (mut mask, mut v) = (full, last);
		loop {
			seq.push(v);
			let u = from[mask * n + v];
			mask &= !(1 << v);
			if u == u8::MAX {
				break;
			}
			v = u as usize;
		}
		seq.reverse();
		let mut c = o.clone();
		for (k, &v) in seq.iter().enumerate() {
			c.steps[i + k] = o.steps[i + v];
			c.origin[i + k] = o.origin[i + v];
		}
		Some((c, i, e))
	}

	/// Drop a grind checkpoint.
	fn drop_grind(&mut self) -> Option<(Order, usize, usize)> {
		let o = &self.order;
		let g: Vec<usize> = (0..self.live.min(o.len())).filter(|&i| o.steps[i].kind == K_GRIND).collect();
		if g.is_empty() {
			return None;
		}
		let i = g[self.rng.below(g.len())];
		let mut c = o.clone();
		c.steps.remove(i);
		c.origin.remove(i);
		Some((c, i, i))
	}
}

/// The search's result: the best order, each character's seconds to 60 with it.
pub struct Outcome {
	pub best: Order,
	pub totals: Vec<f64>,
	pub stats: Stats,
	pub seconds: f64,
}

/// Each character's run of an order from scratch.
pub fn runs(p: &Problem, order: &Order) -> Vec<Current> {
	(0..p.ctxs.len())
		.map(|k| {
			let mut ev = p.ctxs[k].model.evaluator(p.walks);
			full(&mut ev, p.steps_for(k, &order.steps))
		})
		.collect()
}

/// Improve `seed` (counted in tries; deterministic for `opts.seed`).
///
/// With a checkpoint unit `ck`: the members are saved at a meeting every `ck.every()` and after
/// the last round (resume::FreeCk), and a search of the same seed and settings resumes from the
/// last one saved: each member rebuilt from its order (its runs replayed from scratch, as a kept
/// move's exact replay made them), generator and counters plays on as the uninterrupted search's.
pub fn search(p: &Problem, seed: &Order, opts: &SearchOpts, ck: Option<&Unit>) -> Outcome {
	let t0 = std::time::Instant::now();
	let members = opts.members.max(1);
	let per_round = opts.share_every.max(1);
	let rounds = opts.tries.div_ceil(per_round * members as u64);
	let fit = crate::resume::fit(seed, &[members as u64, per_round, opts.seed, u64::from(opts.no_worse)]);
	let saved = ck.and_then(|u| u.load::<FreeCk>(FREE)).filter(|c| c.fit == fit && c.members.len() == members && c.round <= rounds && c.members.iter().all(|m| m.0 < c.orders.len()));
	let (mut ms, r0) = match saved {
		Some(c) => {
			let orders: Vec<Order> = c.orders.into_iter().map(Order::from).collect();
			let rs: Vec<Vec<Current>> = orders.iter().map(|o| runs(p, o)).collect();
			let ms: Vec<Member> = c
				.members
				.into_iter()
				.map(|(k, rng, stats)| {
					let mut m = Member::new(p, orders[k].clone(), &rs[k], 0);
					m.rng = Rng::at(rng);
					m.stats = stats;
					m.no_worse = opts.no_worse;
					m
				})
				.collect();
			if let Some(u) = ck {
				u.note(format!("resuming {} from checkpoint ({} tries done)", u.name, ms.iter().map(|m| m.stats.tries).sum::<u64>()));
			}
			(ms, c.round)
		}
		None => {
			let start = runs(p, seed);
			let ms = (0..members)
				.map(|k| {
					let mut m = Member::new(p, seed.clone(), &start, opts.seed.wrapping_mul(1_000_003).wrapping_add(k as u64));
					m.no_worse = opts.no_worse;
					m
				})
				.collect();
			(ms, 0)
		}
	};
	let best_of = |ms: &[Member]| (0..ms.len()).min_by(|&a, &b| ms[a].total().total_cmp(&ms[b].total()).then(a.cmp(&b))).unwrap();
	let mut last_save = std::time::Instant::now();
	for r in r0..rounds {
		run_round(p, &mut ms, per_round);
		// Meeting: the laggards continue from the best (ties: the lowest member).
		let best = best_of(&ms);
		let (bt, (before, rest)) = (ms[best].total(), ms.split_at_mut(best));
		let (b, after) = rest.split_first_mut().unwrap();
		for m in before.iter_mut().chain(after.iter_mut()) {
			if m.total() > bt {
				m.take(b);
			}
		}
		if let Some(u) = ck {
			if r + 1 == rounds || last_save.elapsed() >= u.every() {
				u.save(FREE, &free_state(&ms, fit, r + 1));
				last_save = std::time::Instant::now();
			}
		}
	}
	let best = best_of(&ms);
	let mut stats = Stats::default();
	for m in &ms {
		stats.tries += m.stats.tries;
		stats.invalid += m.stats.invalid;
		stats.estimated += m.stats.estimated;
		stats.exact += m.stats.exact;
		stats.kept += m.stats.kept;
		stats.guard_rejected += m.stats.guard_rejected;
		stats.steps_replayed += m.stats.steps_replayed;
		for k in 0..MOVES {
			stats.by_move[k][0] += m.stats.by_move[k][0];
			stats.by_move[k][1] += m.stats.by_move[k][1];
		}
		for k in 0..RULES {
			stats.refused[k] += m.stats.refused[k];
		}
	}
	Outcome { best: ms[best].order.clone(), totals: ms[best].ctxs.iter().map(|c| c.cur.total).collect(), stats, seconds: t0.elapsed().as_secs_f64() }
}

/// The members after `round` rounds as a checkpoint (each distinct order once).
fn free_state(ms: &[Member], fit: u64, round: u64) -> FreeCk {
	let mut orders: Vec<&Order> = Vec::new();
	let mut members = Vec::with_capacity(ms.len());
	for m in ms {
		let k = orders.iter().position(|o| **o == m.order).unwrap_or_else(|| {
			orders.push(&m.order);
			orders.len() - 1
		});
		members.push((k, m.rng.state(), m.stats.clone()));
	}
	FreeCk { fit, round, orders: orders.into_iter().map(Into::into).collect(), members }
}

#[cfg(feature = "native")]
fn run_round(p: &Problem, ms: &mut [Member], n: u64) {
	use rayon::prelude::*;
	ms.par_iter_mut().for_each(|m| {
		for _ in 0..n {
			m.try_one(p);
		}
	});
}

#[cfg(not(feature = "native"))]
fn run_round(p: &Problem, ms: &mut [Member], n: u64) {
	for m in ms.iter_mut() {
		for _ in 0..n {
			m.try_one(p);
		}
	}
}

/// The order without steps that do nothing in its own replay (no change of time).
pub fn clean(ev: &mut Evaluator, o: &Order) -> Order {
	let (_, did) = crate::order::play_order(ev, &o.steps);
	let mut c = Order { steps: Vec::new(), origin: Vec::new() };
	for (k, &dd) in did.iter().enumerate() {
		if dd {
			c.steps.push(o.steps[k]);
			c.origin.push(o.origin[k]);
		}
	}
	c
}

/// Quests the search may add: open, solo, not in the seed, with a reward, whose giver is within
/// PASSED_BY_YD of a stop of the seed (passed by).
pub fn pool(run: &Run, rules: &forge_world::Rules, seed: &Order, tables: &crate::Tables) -> Vec<u32> {
	let loc = locs(run, &seed.steps);
	let mut in_seed = vec![false; run.n_quests()];
	for s in &seed.steps {
		if s.kind == K_ACCEPT {
			in_seed[s.q as usize] = true;
		}
	}
	let mut pts: Vec<u32> = loc.clone();
	pts.sort_unstable();
	pts.dedup();
	(0..run.n_quests() as u32)
		.filter(|&q| {
			let qi = q as usize;
			!in_seed[qi] && rules.solo_ok(run.q_id[qi]) && tables.q_full[qi] > 0.0 && pts.iter().any(|&x| d(run, x, run.q_giver[qi]) <= PASSED_BY_YD)
		})
		.collect()
}

/// Per quest: the quests that name it as a prerequisite, a parent or an after-quest.
pub fn followers(run: &Run) -> Vec<Vec<u32>> {
	let mut f = vec![Vec::new(); run.n_quests()];
	for q in 0..run.n_quests() {
		for &p in run.q_pre[q].iter().chain(&run.q_all[q]).chain(&run.q_after[q]) {
			f[p as usize].push(q as u32);
		}
		if run.q_parent[q] >= 0 {
			f[run.q_parent[q] as usize].push(q as u32);
		}
	}
	f
}

/// Each training's (origin, level) in an order's run.
pub fn train_levels(order: &Order, c: &Current) -> Vec<(i64, f64)> {
	let off = c.steps.len() - order.len();
	let lv = c.levels();
	(0..order.len()).filter(|&k| order.steps[k].kind == K_TRAIN).map(|k| (order.origin[k], lv.get(k + off).copied().unwrap_or(60.0))).collect()
}

#[cfg(test)]
mod rule_tests {
	//! The free search keeps the edit descent's rules (Member::rules_ok, levels_ok, no_worse):
	//! each move that breaks one is refused, a move that keeps it is not.
	use super::*;
	use std::io::Read;

	fn gunzip(p: &std::path::Path) -> Vec<u8> {
		let mut out = Vec::new();
		flate2::read::GzDecoder::new(std::fs::File::open(p).unwrap()).read_to_end(&mut out).unwrap();
		out
	}

	struct Fx {
		world: forge_world::World,
		base: crate::Params,
		chain: serde_json::Value,
	}

	fn fx() -> Fx {
		let golden = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden");
		let world = forge_world::World::from_json(&gunzip(&golden.join("world/expected/world-horde.json.gz"))).unwrap();
		let doc: serde_json::Value = serde_json::from_slice(&std::fs::read(golden.join("sim/params.json")).unwrap()).unwrap();
		let chain = serde_json::from_slice(&gunzip(&golden.join("sim/v1-horde-orc-off.json.gz"))).unwrap();
		Fx { world, base: crate::Params::effective(Some(&doc), None, &[]), chain }
	}

	fn model(f: &Fx, profile: &crate::profile::Profile) -> Model {
		crate::route::model_for(&f.world, "Orc", profile, &f.base, &crate::NoWalks).unwrap().0
	}

	fn seed(f: &Fx, m: &Model) -> Order {
		let mut ev = m.evaluator(&crate::NoWalks);
		crate::order::seed_order(&mut ev, &crate::chain::events_from(&f.chain), true)
	}

	#[test]
	fn a_moved_v1_training_keeps_its_town_an_added_one_takes_the_nearest() {
		// #664: v1's Kharanos `train class` moved into Coldridge was retargeted to Anvilmar.
		let f = fx();
		let m = model(&f, &crate::profile::Profile::average(forge_core::Faction::Horde));
		let r = &m.run;
		let (a, b) = (r.towns[0], *r.towns.iter().find(|&&t| r.straight(t, r.towns[0]) > 1000.0).expect("two towns apart"));
		let s = Step { kind: K_TRAIN, q: 0, task: -1, pt: a };
		assert_eq!(train_town(r, s, 17, b), Some(a), "v1's line keeps its town");
		assert_eq!(train_town(r, s, crate::order::TRAIN_STOP - 1, b), crate::seq::nearest_town(r, b), "an added stop trains where it goes");
		assert_ne!(crate::seq::nearest_town(r, b), Some(a));
	}

	fn without(o: &Order, drop: impl Fn(usize, &Step) -> bool) -> Order {
		let keep: Vec<usize> = (0..o.len()).filter(|&i| !drop(i, &o.steps[i])).collect();
		Order { steps: keep.iter().map(|&i| o.steps[i]).collect(), origin: keep.iter().map(|&i| o.origin[i]).collect() }
	}

	#[test]
	fn the_free_search_refuses_what_the_edit_descent_refuses() {
		let f = fx();
		let m = model(&f, &crate::profile::Profile::average(forge_core::Faction::Horde));
		let s = seed(&f, &m);
		let run = &m.run;
		let p = Problem::single(&m, &crate::NoWalks, Vec::new(), Vec::new());
		let mut mem = Member::new(&p, s.clone(), &runs(&p, &s), 1);
		let n = s.len();
		// A training right after a training.
		let t = (0..n).find(|&i| s.steps[i].kind == K_TRAIN).expect("a training");
		let mut twin = s.clone();
		twin.steps.insert(t + 1, s.steps[t]);
		twin.origin.insert(t + 1, INSERTED);
		assert!(!mem.rules_ok(&p, &twin, t, t + 1), "a second training at once");
		// v1's grind checkpoint dropped.
		let g = (0..n).find(|&i| s.steps[i].kind == K_GRIND).expect("a grind checkpoint");
		assert!(!mem.rules_ok(&p, &without(&s, |i, _| i == g), g, g), "a grind checkpoint stays");
		// A quest on the way dropped (the slice's quests are all on the way: the drop rule is the
		// only one this candidate breaks).
		let accepts: Vec<u32> = s.steps.iter().filter(|x| x.kind == K_ACCEPT).map(|x| x.q).collect();
		let drop_q = |q: u32| without(&s, |_, x| x.q == q && matches!(x.kind, K_ACCEPT | K_TASK | K_TURNIN));
		let on = *accepts.iter().find(|&&q| on_the_way(run, &s.steps, q) && mem.check.valid(&drop_q(q).steps, &p.pairs, &p.feas)).expect("a quest on the way");
		assert!(!mem.rules_ok(&p, &drop_q(on), 0, n - 1), "a quest on the way is kept");
		// A reorder: two neighbouring stops swapped, refused when it lengthens the straight walk over
		// the stretch by more than PATH_SLACK_YD, kept when it does not lengthen it.
		let swap = |i: usize| {
			let mut c = s.clone();
			c.steps.swap(i, i + 1);
			c.origin.swap(i, i + 1);
			c
		};
		let quest = |x: &Step| matches!(x.kind, K_ACCEPT | K_TASK | K_TURNIN);
		let cands: Vec<usize> = (1..n - 2).filter(|&i| quest(&s.steps[i]) && quest(&s.steps[i + 1]) && s.steps[i].q != s.steps[i + 1].q && mem.check.valid(&swap(i).steps, &p.pairs, &p.feas)).collect();
		let grow = |i: usize| edits::path_len(run, &swap(i).steps, i, i + 2) - edits::path_len(run, &s.steps, i, i + 2);
		let long = *cands.iter().find(|&&i| grow(i) > edits::PATH_SLACK_YD).expect("a swap that lengthens the walk");
		let short = *cands.iter().find(|&&i| grow(i) <= 0.0).expect("a swap that does not");
		assert!(!mem.rules_ok(&p, &swap(long), long, long + 1), "the walk lengthened by {:.0} yd", grow(long));
		assert!(mem.rules_ok(&p, &swap(short), short, short + 1));
		// An objective moved earlier, to more than UNDER_LEVEL under its quest's level and lower
		// than it was: refused after the replay.
		let lv = runs(&p, &s)[0].levels().to_vec();
		let (ia, it) = (0..n)
			.filter(|&i| s.steps[i].kind == K_ACCEPT)
			.find_map(|ia| {
				let q = s.steps[ia].q;
				let it = (ia + 2..n).find(|&k| s.steps[k].kind == K_TASK && s.steps[k].q == q)?;
				(lv[ia + 1] < run.q_level[q as usize] as f64 - edits::UNDER_LEVEL && lv[it] > lv[ia + 1] + 0.5).then_some((ia, it))
			})
			.expect("an objective done well after its accept, the accept under its level");
		let mut early = s.clone();
		let x = early.steps.remove(it);
		let g0 = early.origin.remove(it);
		early.steps.insert(ia + 1, x);
		early.origin.insert(ia + 1, g0);
		assert!(!mem.levels_ok(&p, &early, &runs(&p, &early)), "the objective done under its level, earlier");
		assert!(mem.levels_ok(&p, &s, &runs(&p, &s)), "the seed itself");
	}

	#[test]
	fn the_free_search_slows_no_character_with_no_worse() {
		// The shared route: one order played by two characters (the fast and the slow profile);
		// with no_worse, no kept move slows either.
		let f = fx();
		let (fast, slow) = (model(&f, &crate::profile::Profile::fast(forge_core::Faction::Horde)), model(&f, &crate::profile::Profile::slow(forge_core::Faction::Horde)));
		let s = seed(&f, &fast);
		let mut p = Problem::single(&fast, &crate::NoWalks, Vec::new(), Vec::new());
		p.ctxs.push(CtxSpec { model: &slow, prefix: Vec::new(), map: None, name: "slow".into() });
		let before: Vec<f64> = runs(&p, &s).iter().map(|c| c.total).collect();
		let out = search(&p, &s, &SearchOpts { tries: 1500, members: 2, no_worse: true, ..Default::default() }, None);
		assert!(out.stats.kept > 0, "some moves kept");
		for (k, (&b, &a)) in before.iter().zip(&out.totals).enumerate() {
			assert!(a <= b + 1e-6, "character {k}: {b:.0} s -> {a:.0} s");
		}
	}
}

/// Where a moved training stop trains: a stop the profile added (origin TRAIN_STOP - k) at the
/// town nearest where it moves; v1's own `train class` line keeps its guide step's town (#664: the
/// Kharanos training moved into Coldridge was retargeted to Anvilmar, 0.03 levels after Anvilmar's
/// own: a duplicate under a Kharanos step).
pub(crate) fn train_town(run: &crate::run::Run, s: Step, origin: i64, from: u32) -> Option<u32> {
	if origin > crate::order::TRAIN_STOP {
		return Some(s.pt);
	}
	nearest_town(run, from)
}

