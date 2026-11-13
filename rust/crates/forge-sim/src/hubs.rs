//! Hubs and passing (Fitz in Brill on c12: sent to pick up a quest past three quest givers he
//! would come back to, past ready hand-ins, back and forth in town).
//!
//! The check's `left-ready`, `walked-past` and `finished-near` rules (forge-judge `check/hub.rs`)
//! counted on the sim's order, cheap enough to guard every kept move (GuardCounts::left_ready,
//! walked_past, finished_near); the fixes they point at, for the hub sweep pass
//! (`search::passby::hub_sweep`); and the shortest straight walk through a hub visit's stops
//! (`loop_order`, the check's `hub-order`).
//!
//! On the order instead of the written guide: places are the steps' run points, a leg is walked
//! when the evaluator walked it, and a leg's path is the straight line between its two steps (the
//! walk store holds yards, not paths; the check reads straight lines too). A leg by the network (a
//! flight, a boat, a zeppelin) walks to its departure node and from its arrival node: those two
//! walks pass NPCs too (c13: Grom'gol, Brackenwall, the Steamwheedle boat, Theramore).
//! `finished-near` reads the walk store's walks near an ender for its reach ([`HubData::with_walks`]).

use crate::eval::{Moved, Step};
use crate::guards::Walk;
use crate::run::{Run, K_ACCEPT, K_GRIND, K_RIDE, K_TASK, K_TRAIN, K_TURNIN, K_VISIT};
use rustc_hash::FxHashMap;

/// Yards: NPC places this close are one hub (single linkage: a hub's NPCs, Brill's stand 20-130
/// yd apart, Ratchet's 40-100), and work this close to one of them is at the hub.
pub const HUB_YD: f64 = 120.0;
/// Yards from every place of a hub (from an ender) the walk has left it (the check's LEAVE_YD:
/// Deathknell's church to the Scarlet farm is 278 yd, #736).
pub const LEAVE_YD: f64 = 200.0;
/// Yards: an NPC this close to a walked leg's straight line is passed on the way (Fitz's own
/// reports, c12w Tirisfal: Deathguard Simmer 42 yd off Calvin Montague -> Gordo, #737; Deathguard
/// Dillinger 49 yd off Holland -> Zygand, #740).
pub const PAST_YD: f64 = 50.0;
/// Levels under a quest's level the character may be for its accept to be ready (the model's
/// dangerGap: further under, it grinds first).
pub const READY_UNDER: f64 = 5.0;
/// Most distinct places of a visit loop_order orders exactly (Held-Karp, 2^n·n²).
pub const LOOP_NODES: usize = 16;
/// Yards a visit's loop must save over its written order to be reordered (the check's hub-order
/// counts a visit more than 20 yd and 1.3 times longer than its best).
pub const LOOP_MIN_YD: f64 = 20.0;

/// Per run point: the run points within HUB_YD (itself included), ascending; and the walk store's
/// yards between each quest ender and the run points within crate::turnin::NEAR_YD of it.
pub struct HubData {
	near: Vec<Vec<u32>>,
	n: u64,
	walk: FxHashMap<u64, f32>,
}

impl HubData {
	pub fn new(run: &Run) -> HubData {
		let n = run.p_x.len();
		let cell = |p: usize| (run.p_r[p], (run.p_x[p] / HUB_YD).floor() as i64, (run.p_y[p] / HUB_YD).floor() as i64);
		let mut grid: FxHashMap<(i64, i64, i64), Vec<u32>> = FxHashMap::default();
		for p in 0..n {
			if run.p_x[p].is_finite() && run.p_y[p].is_finite() {
				grid.entry(cell(p)).or_default().push(p as u32);
			}
		}
		let near = (0..n)
			.map(|p| {
				if !run.p_x[p].is_finite() || !run.p_y[p].is_finite() {
					return vec![p as u32];
				}
				let (r, cx, cy) = cell(p);
				let mut v: Vec<u32> = Vec::new();
				for gx in cx - 1..=cx + 1 {
					for gy in cy - 1..=cy + 1 {
						if let Some(list) = grid.get(&(r, gx, gy)) {
							v.extend(list.iter().copied().filter(|&o| run.straight(p as u32, o) <= HUB_YD));
						}
					}
				}
				v.sort_unstable();
				v
			})
			.collect();
		HubData { near, n: n as u64, walk: FxHashMap::default() }
	}

	/// With the walk store's yards (both ways) between every quest ender and each run point within
	/// crate::turnin::NEAR_YD straight of it: an ender behind a cliff or a wall is not near
	/// (`finished-near`).
	pub fn with_walks(mut self, run: &Run, walks: &dyn crate::Walks) -> HubData {
		let near_yd = crate::turnin::NEAR_YD;
		let cell = |p: usize| (run.p_r[p], (run.p_x[p] / near_yd).floor() as i64, (run.p_y[p] / near_yd).floor() as i64);
		let ok = |p: usize| run.p_x[p].is_finite() && run.p_y[p].is_finite();
		let mut grid: FxHashMap<(i64, i64, i64), Vec<u32>> = FxHashMap::default();
		for p in (0..run.p_x.len()).filter(|&p| ok(p)) {
			grid.entry(cell(p)).or_default().push(p as u32);
		}
		let mut enders: Vec<u32> = run.q_ender.iter().copied().filter(|&e| (e as usize) < run.p_x.len() && ok(e as usize)).collect();
		enders.sort_unstable();
		enders.dedup();
		let yd = |a: u32, b: u32| walks.yards(run.pt_list[a as usize], run.pt_list[b as usize]).filter(|&y| y >= 0.0);
		for e in enders {
			let (r, cx, cy) = cell(e as usize);
			for gx in cx - 1..=cx + 1 {
				for gy in cy - 1..=cy + 1 {
					for &p in grid.get(&(r, gx, gy)).into_iter().flatten() {
						if p == e || run.straight(p, e) > near_yd {
							continue;
						}
						if let Some(y) = yd(p, e) {
							self.walk.insert(u64::from(p) * self.n + u64::from(e), y as f32);
						}
						if let Some(y) = yd(e, p) {
							self.walk.insert(u64::from(e) * self.n + u64::from(p), y as f32);
						}
					}
				}
			}
		}
		self
	}

	/// The walk from run point `a` reaches `b` (an ender) within crate::turnin::REACH_YD, by the walk
	/// store's yards near enders ([`HubData::with_walks`]); true where it has none (`finished-near`).
	pub fn reach(&self, a: u32, b: u32) -> bool {
		self.walk.get(&(u64::from(a) * self.n + u64::from(b))).is_none_or(|&y| f64::from(y) <= crate::turnin::REACH_YD)
	}
}

/// The hub counts of an order.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct HubCounts {
	/// Accepts and hand-ins done after the walk left a visit within HUB_YD of their NPC where
	/// they were ready (the check's `left-ready`).
	pub left_ready: u32,
	/// Hand-ins whose ender a walked leg passed within PAST_YD while they were ready, the walk then
	/// going TRIP_YD away before them (the check's `walked-past`).
	pub walked_past: u32,
	/// Accepts the same way (the planner's own: the check counts hand-ins only).
	pub passed_accepts: u32,
	/// Hand-ins of quests finished within crate::turnin::NEAR_YD of their ender, made only after
	/// the walk went crate::turnin::AWAY_YD away, with no reason to wait (the check's
	/// `finished-near`; crate::turnin).
	pub finished_near: u32,
}

impl HubCounts {
	pub fn sum(&self) -> u32 {
		self.left_ready + self.walked_past + self.passed_accepts + self.finished_near
	}

	/// No count above `bound`'s that a kept move may not raise (left ready, walked past, finished
	/// near: the check's warnings and blockers; passed accepts are the planner's own).
	pub fn within(&self, bound: &HubCounts) -> bool {
		self.left_ready <= bound.left_ready && self.walked_past <= bound.walked_past && self.finished_near <= bound.finished_near
	}
}

/// Counts of several characters' runs added (search::passby: every start of a shared tail).
impl std::ops::AddAssign for HubCounts {
	fn add_assign(&mut self, o: HubCounts) {
		self.left_ready += o.left_ready;
		self.walked_past += o.walked_past;
		self.passed_accepts += o.passed_accepts;
		self.finished_near += o.finished_near;
	}
}

/// Where a step left for later belongs (indices into the steps counted).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Fix {
	/// Step `j` into the visit `s..=e`: the earliest visit to its hub ready at its end that the walk
	/// left before `j` (done there, no visit before it counts). `after`: the step it must follow (its
	/// readiness).
	Visit { j: usize, s: usize, e: usize, after: usize },
	/// Step `j` on the walked leg into step `i` (its NPC within PAST_YD of that leg, ready there).
	Leg { j: usize, i: usize },
	/// Hand-in `j` and the `n` follow-up accepts right after it at its NPC to `to` (right after the
	/// stop the quest was finished near its ender: crate::turnin).
	Near { j: usize, n: usize, to: usize },
}

impl Fix {
	pub fn step(&self) -> usize {
		match *self {
			Fix::Visit { j, .. } | Fix::Leg { j, .. } | Fix::Near { j, .. } => j,
		}
	}
}

/// One visit: steps s..=e at one hub, the hub, and the first step after it LEAVE_YD from every
/// place of the hub (steps.len() when never).
#[derive(Clone, Copy, Debug)]
pub struct Visit {
	pub s: usize,
	pub e: usize,
	pub hub: usize,
	pub leave: usize,
}

const NONE: usize = usize::MAX;

/// A step at an NPC: an accept, a hand-in, a training or a riding lesson.
fn at_npc(s: &Step) -> bool {
	matches!(s.kind, K_ACCEPT | K_TURNIN | K_TRAIN | K_RIDE | K_VISIT)
}

/// The hubs and visits of an order, as the check reads them: a hub is a cluster of the order's
/// NPC places linked within HUB_YD (single linkage: Brill's Holland and Zygand are 166 yd apart,
/// linked by Dillinger); a step is at a hub when its place is one of the hub's or (work, not at an
/// NPC) within HUB_YD of one; a visit is a run of consecutive steps at one hub (a grind checkpoint
/// has no place: it stays in the visit). Returns the visits, each step's visit (NONE: none), and
/// each hub's places.
pub fn visits(h: &HubData, run: &Run, steps: &[Step]) -> (Vec<Visit>, Vec<usize>, Vec<Vec<u32>>) {
	let n = steps.len();
	// Union-find over the NPC places.
	let mut ix: FxHashMap<u32, usize> = FxHashMap::default();
	let mut pts: Vec<u32> = Vec::new();
	for s in steps.iter().filter(|s| at_npc(s)) {
		ix.entry(s.pt).or_insert_with(|| {
			pts.push(s.pt);
			pts.len() - 1
		});
	}
	let mut parent: Vec<usize> = (0..pts.len()).collect();
	fn root(parent: &mut [usize], mut x: usize) -> usize {
		while parent[x] != x {
			parent[x] = parent[parent[x]];
			x = parent[x];
		}
		x
	}
	for (a, &p) in pts.iter().enumerate() {
		for np in &h.near[p as usize] {
			if let Some(&b) = ix.get(np) {
				let (ra, rb) = (root(&mut parent, a), root(&mut parent, b));
				if ra != rb {
					parent[ra.max(rb)] = ra.min(rb);
				}
			}
		}
	}
	let mut hub_of_root: FxHashMap<usize, usize> = FxHashMap::default();
	let mut hubs: Vec<Vec<u32>> = Vec::new();
	let mut hub_of = vec![0usize; pts.len()];
	for a in 0..pts.len() {
		let r = root(&mut parent, a);
		let k = *hub_of_root.entry(r).or_insert_with(|| {
			hubs.push(Vec::new());
			hubs.len() - 1
		});
		hubs[k].push(pts[a]);
		hub_of[a] = k;
	}
	// Each step's hub: its own place's, else (work) the hub of an NPC place within HUB_YD, the
	// current visit's first. A grind checkpoint has no place: it neither ends a visit nor joins it.
	let mut out: Vec<Visit> = Vec::new();
	let mut of = vec![NONE; n];
	let mut open: Option<usize> = None;
	for (i, s) in steps.iter().enumerate() {
		if s.kind == K_GRIND {
			continue;
		}
		let cur = open.map(|v| out[v].hub);
		let hub = match ix.get(&s.pt) {
			Some(&a) if at_npc(s) => Some(hub_of[a]),
			_ => {
				let near: Vec<usize> = h.near[s.pt as usize].iter().filter_map(|np| ix.get(np).map(|&a| hub_of[a])).collect();
				cur.filter(|c| near.contains(c)).or(near.first().copied())
			}
		};
		let Some(hub) = hub else {
			open = None;
			continue;
		};
		if cur == Some(hub) {
			out.last_mut().unwrap().e = i;
		} else {
			out.push(Visit { s: i, e: i, hub, leave: n });
			open = Some(out.len() - 1);
		}
		of[i] = out.len() - 1;
	}
	for v in out.iter_mut() {
		let places = &hubs[v.hub];
		v.leave = (v.e + 1..n).find(|&i| steps[i].kind != K_GRIND && places.iter().all(|&p| run.straight(p, steps[i].pt) > LEAVE_YD)).unwrap_or(n);
	}
	(out, of, hubs)
}

/// A run point as (region, x, y).
fn at_pt(run: &Run, p: u32) -> (i64, f64, f64) {
	let p = p as usize;
	(run.p_r[p], run.p_x[p], run.p_y[p])
}

/// A transport node as (region, x, y).
fn at_node(run: &Run, n: i32) -> (i64, f64, f64) {
	let n = n as usize;
	(run.node_r[n], run.node_x[n], run.node_y[n])
}

/// Yards from point `p` to the straight leg a→b (infinite across regions).
fn seg_dist(p: (i64, f64, f64), a: (i64, f64, f64), b: (i64, f64, f64)) -> f64 {
	if p.0 != a.0 || a.0 != b.0 {
		return f64::INFINITY;
	}
	let ((_, ax, ay), (_, bx, by), (_, px, py)) = (a, b, p);
	let (dx, dy) = (bx - ax, by - ay);
	let l2 = dx * dx + dy * dy;
	let t = if l2 > 0.0 { (((px - ax) * dx + (py - ay) * dy) / l2).clamp(0.0, 1.0) } else { 0.0 };
	(px - ax - t * dx).hypot(py - ay - t * dy)
}

/// Yards from point `p` to the walks of the leg a→b travelled as `m`: the straight line when walked,
/// by the network the walk to the departure node, each node-to-node walk inside the path (Moved::via:
/// Gadgetzan's flight master to the Steamwheedle dock between the flight and the boat, c14 Orc
/// Feralas) and the walk from the arrival node (infinite when nothing of it was walked).
fn walked_dist(run: &Run, p: u32, a: u32, b: u32, m: Moved) -> f64 {
	let p = at_pt(run, p);
	if m.walked {
		return seg_dist(p, at_pt(run, a), at_pt(run, b));
	}
	let dep = if m.dep >= 0 { seg_dist(p, at_pt(run, a), at_node(run, m.dep)) } else { f64::INFINITY };
	let arr = if m.arr >= 0 { seg_dist(p, at_node(run, m.arr), at_pt(run, b)) } else { f64::INFINITY };
	m.via.iter().take_while(|v| v.0 >= 0).map(|&(x, y)| seg_dist(p, at_node(run, i32::from(x)), at_node(run, i32::from(y)))).fold(dep.min(arr), f64::min)
}

/// Count the hub rules on a walk (`walked[i]`: how the leg into step i was travelled), with the
/// fixes they point at when `fixes` is given.
pub(crate) fn count(h: &HubData, w: &Walk, walked: &[Moved], mut fixes: Option<&mut Vec<Fix>>) -> HubCounts {
	let run = w.run;
	let steps = w.steps;
	let n = steps.len();
	let mut c = HubCounts::default();
	if n == 0 {
		return c;
	}
	let (vs, of, hubs) = visits(h, run, steps);
	let mut by_hub: Vec<Vec<usize>> = vec![Vec::new(); hubs.len()];
	for (k, v) in vs.iter().enumerate() {
		by_hub[v.hub].push(k);
	}
	// The positioned step before each step.
	let mut prevpos = vec![NONE; n];
	let mut last = NONE;
	for (i, s) in steps.iter().enumerate() {
		prevpos[i] = last;
		if s.kind != K_GRIND {
			last = i;
		}
	}
	// lv_after is non-decreasing: the first step after which the level is at least `l`.
	let level_at = |l: f64| -> usize { w.lv_after.partition_point(|&x| x < l - 1e-9) };
	let mut last_task = vec![NONE; run.n_quests()];
	// The step after which each hand-in is ready (finished-near).
	let mut ready_of = vec![NONE; n];
	for j in 0..n {
		let s = steps[j];
		let qi = s.q as usize;
		if s.kind == K_TASK {
			last_task[qi] = if last_task[qi] == NONE { j } else { last_task[qi].max(j) };
			continue;
		}
		if !matches!(s.kind, K_ACCEPT | K_TURNIN) {
			continue;
		}
		// The step after which it is ready (a lower bound for an accept: its gates checked again).
		let r = if s.kind == K_TURNIN {
			let a = w.accept_at[qi] as usize;
			if w.accept_at[qi] == u32::MAX || a >= j {
				continue;
			}
			ready_of[j] = if last_task[qi] == NONE { a } else { a.max(last_task[qi]) };
			ready_of[j]
		} else {
			if w.accept_at[qi] as usize != j {
				continue;
			}
			let need = (run.q_min_level[qi] as f64).max(run.q_level[qi] as f64 - READY_UNDER);
			let mut r = level_at(need);
			let t = |q: &u32| w.turnin_at[*q as usize];
			if !run.q_pre[qi].is_empty() {
				r = r.max(run.q_pre[qi].iter().map(t).min().unwrap() as usize);
			}
			if let Some(m) = run.q_all[qi].iter().map(t).max() {
				r = r.max(m as usize);
			}
			if run.q_parent[qi] >= 0 {
				r = r.max(w.accept_at[run.q_parent[qi] as usize] as usize);
			}
			// (After the hand-in of a breadcrumb taken before it: held back while it is in the log.)
			for &c in run.crumbs(qi) {
				if (w.accept_at[c as usize] as usize) < j {
					r = r.max(w.turnin_at[c as usize] as usize);
				}
			}
			r
		};
		if r >= j {
			continue;
		}
		let ready = |t: usize| s.kind == K_TURNIN || (w.acceptable(s.q, t) && w.lvl(t) >= run.q_level[qi] as f64 - READY_UNDER);
		// left-ready: an earlier visit to its hub ready at its end and left before it. The fix names
		// the earliest such visit: done in a later one, the visits before it still count (c14 Orc,
		// Ratchet: WANTED: Baron Longshore moved into the visit before was still left ready at the
		// one before that, each sweep move refused for the unchanged count).
		let vj = of[j];
		let mut found: Option<usize> = None;
		if vj != NONE {
			let list = &by_hub[vs[vj].hub];
			for &v in list[..list.partition_point(|&k| k < vj)].iter().rev() {
				let x = &vs[v];
				if x.e < r {
					break;
				}
				if x.leave <= j && ready(x.e) {
					found = Some(v);
				}
			}
		}
		if let Some(v) = found {
			c.left_ready += 1;
			if let Some(f) = fixes.as_deref_mut() {
				f.push(Fix::Visit { j, s: vs[v].s, e: vs[v].e, after: r });
			}
		}
		// walked-past: the latest walked leg after it was ready passing its NPC, the walk then
		// going LEAVE_YD from it before the step.
		let mut far = false;
		for i in (r + 1..j).rev() {
			if steps[i].kind == K_GRIND {
				continue;
			}
			far |= run.straight(steps[i].pt, s.pt) > LEAVE_YD;
			let a = prevpos[i];
			if a == NONE || a < r {
				break;
			}
			if !far || walked.get(i).is_none_or(|&m| walked_dist(run, s.pt, steps[a].pt, steps[i].pt, m) > PAST_YD) {
				continue;
			}
			if !ready(a) {
				break;
			}
			if s.kind == K_TURNIN {
				c.walked_past += 1;
			} else {
				c.passed_accepts += 1;
			}
			if let Some(f) = fixes.as_deref_mut() {
				f.push(Fix::Leg { j, i });
			}
			break;
		}
	}
	// finished-near: hand-ins made on a trip back, with no reason to wait (crate::turnin).
	let line = StepsLine { h, w, ready: &ready_of };
	for x in crate::turnin::scan(&line) {
		if x.wait.is_some() {
			continue;
		}
		c.finished_near += 1;
		if let Some(f) = fixes.as_deref_mut() {
			f.push(Fix::Near { j: x.j, n: x.follow.len(), to: x.at + 1 });
		}
	}
	c
}

/// An order's walk as crate::turnin reads it: run quest indices, the steps' run points, yards by
/// HubData::yd.
struct StepsLine<'a, 'w> {
	h: &'a HubData,
	w: &'a Walk<'w>,
	ready: &'a [usize],
}

impl crate::turnin::Line for StepsLine<'_, '_> {
	fn len(&self) -> usize {
		self.w.steps.len()
	}
	fn kind(&self, i: usize) -> crate::turnin::Kind {
		use crate::turnin::Kind;
		match self.w.steps[i].kind {
			K_ACCEPT => Kind::Accept,
			K_TASK => Kind::Work,
			K_TURNIN => Kind::Turnin,
			K_GRIND => Kind::None,
			_ => Kind::Npc,
		}
	}
	fn quest(&self, i: usize) -> u32 {
		self.w.steps[i].q
	}
	fn yd(&self, a: usize, b: usize) -> f64 {
		self.w.run.straight(self.w.steps[a].pt, self.w.steps[b].pt)
	}
	fn reach(&self, a: usize, b: usize) -> bool {
		self.h.reach(self.w.steps[a].pt, self.w.steps[b].pt)
	}
	fn same_place(&self, a: usize, b: usize) -> bool {
		self.w.steps[a].pt == self.w.steps[b].pt
	}
	fn lvl_after(&self, i: usize) -> f64 {
		self.w.lvl(i)
	}
	fn ready_after(&self, j: usize) -> Option<usize> {
		Some(self.ready[j]).filter(|&r| r != NONE)
	}
	fn min_level(&self, q: u32) -> f64 {
		f64::from(self.w.run.q_min_level[q as usize])
	}
	fn follows(&self, f: u32, q: u32) -> bool {
		let r = self.w.run;
		r.q_pre[f as usize].contains(&q) || r.q_all[f as usize].contains(&q)
	}
}

/// The shortest straight walk from `entry` through steps `s..=e` to `exit`, the steps grouped by
/// place (a place's steps together, in their order) and `keep(x, y)` (x stays ahead of y, for x
/// before y now) held: the new order of the range as indices into `steps`, with the yards now and
/// then. None when nothing saves LOOP_MIN_YD, the range has a grind checkpoint, more than
/// LOOP_NODES places, or no order keeps the rules by place.
pub fn loop_order(run: &Run, steps: &[Step], s: usize, e: usize, entry: u32, exit: Option<u32>, keep: &dyn Fn(&Step, &Step) -> bool) -> Option<(Vec<usize>, f64, f64)> {
	let range = &steps[s..=e];
	if range.iter().any(|x| x.kind == K_GRIND) {
		return None;
	}
	let mut places: Vec<u32> = Vec::new();
	let mut members: Vec<Vec<usize>> = Vec::new();
	for (k, x) in range.iter().enumerate() {
		match places.iter().position(|&p| p == x.pt) {
			Some(v) => members[v].push(s + k),
			None => {
				places.push(x.pt);
				members.push(vec![s + k]);
			}
		}
	}
	let n = places.len();
	if n < 3 || n > LOOP_NODES {
		return None;
	}
	let d = |a: u32, b: u32| {
		let x = run.straight(a, b);
		if x.is_finite() {
			x
		} else {
			1.0e6
		}
	};
	let node_of = |i: usize| members.iter().position(|m| m.contains(&i)).unwrap();
	let mut pred = vec![0u32; n];
	for x in s..=e {
		for y in x + 1..=e {
			if keep(&steps[x], &steps[y]) {
				let (u, v) = (node_of(x), node_of(y));
				if u != v {
					pred[v] |= 1 << u;
				}
			}
		}
	}
	let walk = |seq: &[usize]| -> f64 {
		let mut t = 0.0;
		let mut at = entry;
		for &v in seq {
			t += d(at, places[v]);
			at = places[v];
		}
		t + exit.map_or(0.0, |x| d(at, x))
	};
	// Now: the places in the order they are first reached (the steps of a place apart count as
	// separate stops).
	let now = {
		let mut t = 0.0;
		let mut at = entry;
		for x in range {
			t += d(at, x.pt);
			at = x.pt;
		}
		t + exit.map_or(0.0, |x| d(at, x))
	};
	let full = (1usize << n) - 1;
	let mut dp = vec![f64::INFINITY; (full + 1) * n];
	let mut from = vec![u8::MAX; (full + 1) * n];
	for v in 0..n {
		if pred[v] == 0 {
			dp[(1 << v) * n + v] = d(entry, places[v]);
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
				let c2 = c + d(places[v], places[w]);
				if c2 < dp[m2 * n + w] - 1e-9 {
					dp[m2 * n + w] = c2;
					from[m2 * n + w] = v as u8;
				}
			}
		}
	}
	let end = |v: usize| dp[full * n + v] + exit.map_or(0.0, |x| d(places[v], x));
	let last = (0..n).filter(|&v| end(v).is_finite()).min_by(|&a, &b| end(a).total_cmp(&end(b)))?;
	let best = end(last);
	if best > now - LOOP_MIN_YD {
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
	debug_assert!((walk(&seq) - best).abs() < 1e-6);
	Some((seq.iter().flat_map(|&v| members[v].iter().copied()).collect(), now, best))
}
