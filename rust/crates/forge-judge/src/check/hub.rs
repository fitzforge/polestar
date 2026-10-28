//! Rules for how a walk moves through a hub (a town, a camp: quest NPCs close together), the way
//! leveling guides that players trust walk it (Fitz, c12w Deathknell and Brill, #736, #739, #740):
//! one sweep from the side you come in to the side you leave by, every NPC once, nothing ready left
//! behind, and no ready hand-in walked past.
//!
//! - [`hub_order`] (warn): a hub visit whose written NPC order walks more than [`HUB_ORDER_RATIO`] times
//!   the best order.
//! - [`walked_past`] (warn): the walk passed within [`PASS_YD`] of a quest's ender while its hand-in was
//!   ready, went on more than [`LEAVE_YD`] away, and handed it in later.
//! - [`left_ready`] (warn): a hub visit left with a takeable accept or a ready hand-in at one of its NPCs
//!   that the walk comes back for later.

use super::play::seg_dist;
use super::*;

/// Quest NPCs within this many yards of each other are one hub.
pub const HUB_YD: f64 = 120.0;
/// A walk passes an NPC within this many yards of its path (Dillinger 49 yd off Holland to Zygand,
/// #740; Simmer 42 yd off Calvin to Gordo, #737).
pub const PASS_YD: f64 = 50.0;
/// The walk has left a hub (or an NPC it passed) once it works or travels this far from it: Deathknell's
/// Scarlet farm, 280 yd from the church (#736).
pub const LEAVE_YD: f64 = 200.0;
/// A visit's written order may walk this many times the best order.
pub const HUB_ORDER_RATIO: f64 = 1.3;
/// ... and this many yards more (a few steps either way is no detour).
pub const HUB_ORDER_SLACK_YD: f64 = 20.0;

/// A goal done by talking to an NPC (or at a service NPC) where it stands.
pub fn is_npc_line(g: &WalkGoal) -> bool {
	matches!(g.t.as_str(), "accept" | "turnin" | "train" | "sethome" | "getfp" | "vendor" | "talk" | "buy") || (g.npc.is_some() && matches!(g.t.as_str(), "collect" | "complete" | "interact"))
}

/// A goal the walk does where it stands (not along, not optional, with a point).
fn at_stop(g: &WalkGoal) -> bool {
	g.w.is_some() && g.along.is_none() && !g.optional && !is_move(g) && g.t != "note" && g.t != "level"
}

/// The goal is where the walk is: a travel line, or a required goal of a step the route stops at.
fn walk_here(g: &WalkGoal) -> bool {
	g.w.is_some() && g.along.is_none() && (is_move(g) || !g.optional) && g.t != "note" && g.t != "level"
}

/// One visit to a hub: its goals (indices, written order), the hub, and where the walk was before and
/// after.
#[derive(Clone, Debug)]
pub struct Visit {
	pub goals: Vec<usize>,
	pub hub: usize,
	pub entry: Option<WPt>,
	pub exit: Option<WPt>,
}

impl Visit {
	fn npc_goals<'a>(&'a self, goals: &'a [WalkGoal]) -> impl Iterator<Item = usize> + 'a {
		self.goals.iter().copied().filter(|&i| is_npc_line(&goals[i]))
	}
}

/// The walk's hubs: its NPC lines' points linked within [`HUB_YD`] of each other (Brill from Holland
/// at its north-west edge to the inn). -> each NPC line's hub, each hub's points.
pub struct Hubs {
	pub of: FxHashMap<usize, usize>,
	pub pts: Vec<Vec<WPt>>,
}

impl Hubs {
	pub fn new(goals: &[WalkGoal]) -> Hubs {
		let idx: Vec<usize> = (0..goals.len()).filter(|&i| at_stop(&goals[i]) && is_npc_line(&goals[i])).collect();
		let cell = |w: WPt| (w.c, (w.wx / HUB_YD).floor() as i64, (w.wy / HUB_YD).floor() as i64);
		let mut grid: FxHashMap<(i64, i64, i64), Vec<usize>> = FxHashMap::default();
		for (k, &i) in idx.iter().enumerate() {
			grid.entry(cell(goals[i].w.unwrap())).or_default().push(k);
		}
		let mut parent: Vec<usize> = (0..idx.len()).collect();
		fn root(p: &mut [usize], mut x: usize) -> usize {
			while p[x] != x {
				p[x] = p[p[x]];
				x = p[x];
			}
			x
		}
		for (k, &i) in idx.iter().enumerate() {
			let w = goals[i].w.unwrap();
			let (c, x, y) = cell(w);
			for dx in -1..=1 {
				for dy in -1..=1 {
					for &m in grid.get(&(c, x + dx, y + dy)).into_iter().flatten() {
						if m < k && dist(goals[idx[m]].w.unwrap(), w) <= HUB_YD {
							let (a, b) = (root(&mut parent, k), root(&mut parent, m));
							parent[a] = b;
						}
					}
				}
			}
		}
		let mut id: FxHashMap<usize, usize> = FxHashMap::default();
		let mut hubs = Hubs { of: FxHashMap::default(), pts: Vec::new() };
		for (k, &i) in idx.iter().enumerate() {
			let r = root(&mut parent, k);
			let h = *id.entry(r).or_insert_with(|| {
				hubs.pts.push(Vec::new());
				hubs.pts.len() - 1
			});
			hubs.of.insert(i, h);
			let w = goals[i].w.unwrap();
			if !hubs.pts[h].iter().any(|&p| dist(p, w) < 3.0) {
				hubs.pts[h].push(w);
			}
		}
		hubs
	}

	fn near(&self, h: usize, w: WPt, yd: f64) -> bool {
		self.pts[h].iter().any(|&p| dist(p, w) <= yd)
	}
}

/// The walk's hub visits: runs of goals done where the walk stands at one hub, NPC lines of that hub and
/// other goals within [`HUB_YD`] of it. A `goto` inside the hub stays in it (Brill's Discipline round);
/// any other travel line ends it. Along, optional and pointless goals neither join nor break a run.
pub fn hub_visits(goals: &[WalkGoal], hubs: &Hubs) -> Vec<Visit> {
	let mut out: Vec<Visit> = Vec::new();
	let mut cur: Option<Visit> = None;
	let mut last_pos: Option<WPt> = None;
	let close = |out: &mut Vec<Visit>, cur: &mut Option<Visit>, exit: Option<WPt>| {
		if let Some(mut v) = cur.take() {
			v.exit = exit;
			out.push(v);
		}
	};
	for (i, g) in goals.iter().enumerate() {
		if !walk_here(g) {
			continue;
		}
		let w = g.w.unwrap();
		match hubs.of.get(&i) {
			Some(&h) if cur.as_ref().is_some_and(|v| v.hub == h) => cur.as_mut().unwrap().goals.push(i),
			Some(&h) => {
				close(&mut out, &mut cur, Some(w));
				cur = Some(Visit { goals: vec![i], hub: h, entry: last_pos, exit: None });
			}
			None if (at_stop(g) || g.t == "goto") && cur.as_ref().is_some_and(|v| hubs.near(v.hub, w, HUB_YD)) => cur.as_mut().unwrap().goals.push(i),
			None => close(&mut out, &mut cur, Some(w)),
		}
		last_pos = Some(w);
	}
	close(&mut out, &mut cur, None);
	out
}

/// `b` must come after `a` in one visit: the same quest's accept, work and hand-in in that order, a
/// prerequisite's hand-in before its follow-up's accept.
fn must_follow(a: &WalkGoal, b: &WalkGoal, facts: &Facts) -> bool {
	let rank = |g: &WalkGoal| match g.t.as_str() {
		"accept" => 0,
		"turnin" => 2,
		_ => 1,
	};
	match (a.q, b.q) {
		(Some(qa), Some(qb)) if qa == qb => rank(a) < rank(b),
		(Some(qa), Some(qb)) => a.t == "turnin" && b.t == "accept" && facts.quests.get(&qb).is_some_and(|f| f.pre.contains(&qa)),
		_ => false,
	}
}

/// The shortest walk through stops `0..n`, each after the stops in its `pred` mask, with `cost(a, b)`
/// the yards between stops (`None`: where the walk comes in, as `a`; where it goes next, as `b`). ->
/// (yards, order), None when no order fits or there are more than 64 stops. Exact (Held-Karp) up to
/// [`EXACT_STOPS`]; a larger visit (Goldshire's fifteen-odd NPCs) starts from the precedence order
/// nearest the first stops and moves single stops while that shortens the walk.
pub fn best_tour(n: usize, pred: &[u64], cost: &dyn Fn(Option<usize>, Option<usize>) -> f64) -> Option<(f64, Vec<usize>)> {
	if n == 0 || n > 64 {
		return None;
	}
	if n > EXACT_STOPS {
		return improved_tour(n, pred, cost);
	}
	let full = (1usize << n) - 1;
	let mut dp = vec![f64::INFINITY; (full + 1) * n];
	let mut from = vec![usize::MAX; (full + 1) * n];
	for s in 0..n {
		if pred[s] == 0 {
			dp[(1 << s) * n + s] = cost(None, Some(s));
		}
	}
	for mask in 1..=full {
		for last in 0..n {
			let c = dp[mask * n + last];
			if !c.is_finite() {
				continue;
			}
			for nx in 0..n {
				if mask & (1 << nx) != 0 || (pred[nx] as usize) & !mask != 0 {
					continue;
				}
				let m2 = mask | (1 << nx);
				let c2 = c + cost(Some(last), Some(nx));
				if c2 < dp[m2 * n + nx] {
					dp[m2 * n + nx] = c2;
					from[m2 * n + nx] = last;
				}
			}
		}
	}
	let (mut best, mut end) = (f64::INFINITY, usize::MAX);
	for last in 0..n {
		let c = dp[full * n + last] + cost(Some(last), None);
		if c < best {
			best = c;
			end = last;
		}
	}
	if !best.is_finite() {
		return None;
	}
	let mut order = Vec::with_capacity(n);
	let (mut mask, mut at) = (full, end);
	while at != usize::MAX {
		order.push(at);
		let p = from[mask * n + at];
		mask &= !(1 << at);
		at = p;
	}
	order.reverse();
	Some((best, order))
}

/// Stops solved exactly up to this many (2^15 states).
pub const EXACT_STOPS: usize = 15;

fn tour_cost(order: &[usize], cost: &dyn Fn(Option<usize>, Option<usize>) -> f64) -> f64 {
	let mut at = None;
	let mut sum = 0.0;
	for &s in order {
		sum += cost(at, Some(s));
		at = Some(s);
	}
	sum + cost(at, None)
}

fn fits(order: &[usize], pred: &[u64]) -> bool {
	let mut seen = 0u64;
	order.iter().all(|&s| {
		let ok = pred[s] & !seen == 0;
		seen |= 1 << s;
		ok
	})
}

/// A larger visit: the nearest stop whose predecessors are done, each in turn, then single stops moved
/// elsewhere while that shortens the walk.
fn improved_tour(n: usize, pred: &[u64], cost: &dyn Fn(Option<usize>, Option<usize>) -> f64) -> Option<(f64, Vec<usize>)> {
	let mut order = Vec::with_capacity(n);
	let mut done = 0u64;
	let mut at = None;
	while order.len() < n {
		let next = (0..n).filter(|&s| done & (1 << s) == 0 && pred[s] & !done == 0).min_by(|&a, &b| cost(at, Some(a)).total_cmp(&cost(at, Some(b))))?;
		order.push(next);
		done |= 1 << next;
		at = Some(next);
	}
	let mut best = tour_cost(&order, cost);
	loop {
		let mut improved = false;
		for i in 0..n {
			for j in 0..n {
				if i == j {
					continue;
				}
				let mut o = order.clone();
				let s = o.remove(i);
				o.insert(j, s);
				if !fits(&o, pred) {
					continue;
				}
				let c = tour_cost(&o, cost);
				if c + 1e-6 < best {
					best = c;
					order = o;
					improved = true;
				}
			}
		}
		if !improved {
			break;
		}
	}
	Some((best, order))
}

/// Yards of a path through `pts` from `entry` to `exit`.
fn path_yd(pts: impl IntoIterator<Item = WPt>, entry: Option<WPt>, exit: Option<WPt>) -> f64 {
	let mut at = entry;
	let mut yd = 0.0;
	for p in pts.into_iter().chain(exit) {
		if let Some(a) = at {
			yd += dist(a, p);
		}
		at = Some(p);
	}
	yd
}

/// A visit's NPC stops: its NPC lines grouped by NPC (by point, else by npc id), each stop's goals and
/// its point; with `by_run`, one stop per run of consecutive lines at one NPC instead.
fn stops_of(v: &Visit, goals: &[WalkGoal], by_run: bool) -> Vec<(WPt, Vec<usize>)> {
	let mut out: Vec<(WPt, Vec<usize>)> = Vec::new();
	let same = |a: &WalkGoal, b: &WalkGoal| a.npc.is_some() && a.npc == b.npc || dist(a.w.unwrap(), b.w.unwrap()) < 3.0;
	for i in v.npc_goals(goals) {
		let k = if by_run { out.last().filter(|(_, gs)| same(&goals[gs[0]], &goals[i])).map(|_| out.len() - 1) } else { out.iter().position(|(_, gs)| same(&goals[gs[0]], &goals[i])) };
		match k {
			Some(k) => out[k].1.push(i),
			None => out.push((goals[i].w.unwrap(), vec![i])),
		}
	}
	out
}

/// Each stop's predecessors as a bit mask; None on a cycle.
fn preds(stops: &[(WPt, Vec<usize>)], goals: &[WalkGoal], facts: &Facts) -> Option<Vec<u64>> {
	let n = stops.len();
	if n > 64 {
		return None;
	}
	let mut pred = vec![0u64; n];
	for a in 0..n {
		for b in 0..n {
			if a != b && stops[a].1.iter().any(|&x| stops[b].1.iter().any(|&y| must_follow(&goals[x], &goals[y], facts))) {
				pred[b] |= 1 << a;
			}
		}
	}
	// A cycle: some stop's predecessors include itself transitively.
	let mut reach = pred.clone();
	for _ in 0..n {
		for b in 0..n {
			let mut r = reach[b];
			for a in 0..n {
				if reach[b] & (1 << a) != 0 {
					r |= reach[a];
				}
			}
			reach[b] = r;
		}
	}
	(0..n).all(|b| reach[b] & (1 << b) == 0).then_some(pred)
}

/// Rule `hub-order` (warn): a hub visit with three NPC stops or more whose written order walks more
/// than [`HUB_ORDER_RATIO`] times (and [`HUB_ORDER_SLACK_YD`] more than) the best order from where the
/// walk came in to where it goes next, each NPC once, the quests' own order kept.
pub fn hub_order(goals: &[WalkGoal], facts: &Facts) -> Vec<Violation> {
	let mut out = Vec::new();
	let hubs = Hubs::new(goals);
	for v in hub_visits(goals, &hubs) {
		let written: Vec<WPt> = v.npc_goals(goals).map(|i| goals[i].w.unwrap()).collect();
		let mut stops = stops_of(&v, goals, false);
		let pred = match preds(&stops, goals, facts) {
			Some(p) => p,
			None => {
				stops = stops_of(&v, goals, true);
				match preds(&stops, goals, facts) {
					Some(p) => p,
					None => continue,
				}
			}
		};
		if stops.len() < 3 {
			continue;
		}
		let pts: Vec<WPt> = stops.iter().map(|s| s.0).collect();
		let cost = |a: Option<usize>, b: Option<usize>| match (a.map(|a| pts[a]).or(v.entry), b.map(|b| pts[b]).or(v.exit)) {
			(Some(p), Some(q)) if a.is_some() || b.is_some() => dist(p, q),
			_ => 0.0,
		};
		let Some((best, order)) = best_tour(pts.len(), &pred, &cost) else { continue };
		let w = path_yd(written, v.entry, v.exit);
		if w <= best * HUB_ORDER_RATIO || w - best <= HUB_ORDER_SLACK_YD {
			continue;
		}
		let first = v.npc_goals(goals).next().unwrap();
		let name = |s: &(WPt, Vec<usize>)| goals[s.1[0]].line.map_or_else(|| "?".to_string(), |l| l.to_string());
		out.push(Violation::at(
			&goals[first],
			"hub-order",
			Level::Warn,
			format!(
				"this hub visit walks its NPCs in {:.0} yd as written (lines {}), {:.0} yd in the best order (lines {}): one sweep from where you come in to where you leave",
				w,
				v.npc_goals(goals).map(|i| goals[i].line.unwrap_or(0).to_string()).collect::<Vec<_>>().join(" "),
				best,
				order.iter().map(|&k| name(&stops[k])).collect::<Vec<_>>().join(" ")
			),
		));
	}
	out
}

/// Required work goals of quest `q` (along ones too: they count wherever they are done).
fn is_work_of(g: &WalkGoal, q: i64) -> bool {
	g.q == Some(q) && !g.optional && matches!(g.t.as_str(), "kill" | "collect" | "interact" | "use" | "complete")
}

/// Quest `q`'s hand-in is ready after goal `i`: accepted at or before it, no work of it after it before
/// `until`.
fn turnin_ready(goals: &[WalkGoal], i: usize, until: usize, q: i64) -> bool {
	goals[..=i].iter().any(|g| g.t == "accept" && g.q == Some(q)) && !goals[i + 1..until].iter().any(|g| is_work_of(g, q))
}

/// Rule `walked-past` (warn): the walk passed within [`PASS_YD`] of a quest's ender while its hand-in
/// was ready (accepted, its work done), then went on more than [`LEAVE_YD`] from the ender, and hands it
/// in later. Walking legs only: straight lines between the goals where the walk is (a flight, a hearth
/// does not pass anyone).
pub fn walked_past(goals: &[WalkGoal]) -> Vec<Violation> {
	walked_past_at(goals).into_iter().map(|f| f.v).collect()
}

/// [`walked_past`] with where: the hand-in, done after the goal the passing leg starts at, else
/// before the goal it ends at.
pub fn walked_past_at(goals: &[WalkGoal]) -> Vec<FlowAt> {
	let path: Vec<usize> = (0..goals.len()).filter(|&i| walk_here(&goals[i])).collect();
	let mut out = Vec::new();
	for (j, g) in goals.iter().enumerate() {
		let (Some(q), Some(e)) = (g.q.filter(|_| g.t == "turnin" && !g.optional && g.along.is_none()), g.w) else { continue };
		let Some(acc) = goals[..j].iter().rposition(|x| x.t == "accept" && x.q == Some(q)) else { continue };
		let ready = goals[acc..j].iter().rposition(|x| is_work_of(x, q)).map_or(acc, |k| acc + k);
		let legs = &path[path.partition_point(|&k| k < ready)..path.partition_point(|&k| k < j)];
		let passed = legs.windows(2).position(|w| {
			let (a, b) = (&goals[w[0]], &goals[w[1]]);
			!matches!(b.t.as_str(), "fly" | "hearth" | "die") && seg_dist(e, a.w.unwrap(), b.w.unwrap()) <= PASS_YD
		});
		let Some(p) = passed else { continue };
		// Then away: a trip, not the walk into the hand-in itself.
		let Some(&away) = legs[p + 1..].iter().find(|&&k| dist(goals[k].w.unwrap(), e) > LEAVE_YD) else { continue };
		let by = legs[p];
		out.push(FlowAt {
			v: Violation::at(
				g,
				"walked-past",
				Level::Warn,
				format!("handed in here, but the walk passed its ender ready to hand in at {} and went on to {} first", line_of(&goals[by]), line_of(&goals[away])),
			),
			lines: vec![j],
			after: by,
			before: legs[p + 1],
		});
	}
	out
}

/// Rule `left-ready` (warn): a line at one of a hub visit's NPCs, written after the walk left the hub
/// (more than [`LEAVE_YD`] from all its NPCs), that was ready when the visit ended: an accept open
/// there (on level, its prerequisites handed in), a hand-in accepted with its work done.
pub fn left_ready(goals: &[WalkGoal], facts: &Facts) -> Vec<Violation> {
	let hubs = Hubs::new(goals);
	// Each hub's accepts and hand-ins, in walk order.
	let mut lines: Vec<Vec<usize>> = vec![Vec::new(); hubs.pts.len()];
	for (j, g) in goals.iter().enumerate() {
		if let (Some(&h), Some(_)) = (hubs.of.get(&j), g.q) {
			if matches!(g.t.as_str(), "accept" | "turnin") {
				lines[h].push(j);
			}
		}
	}
	let mut out = Vec::new();
	let mut flagged: FxHashSet<usize> = FxHashSet::default();
	for v in hub_visits(goals, &hubs) {
		let end = *v.goals.last().unwrap();
		let Some(left) = (end + 1..goals.len()).find(|&k| walk_here(&goals[k]) && !hubs.near(v.hub, goals[k].w.unwrap(), LEAVE_YD)) else { continue };
		let hl = &lines[v.hub];
		for &j in &hl[hl.partition_point(|&j| j <= left)..] {
			let g = &goals[j];
			let q = g.q.unwrap();
			if flagged.contains(&j) {
				continue;
			}
			let ready = match g.t.as_str() {
				"accept" => open_at(goals, end, q, facts),
				_ => turnin_ready(goals, end, j, q),
			};
			if !ready {
				continue;
			}
			flagged.insert(j);
			out.push(Violation::at(
				g,
				"left-ready",
				Level::Warn,
				format!(
					"{} {} here, though it was ready when the walk left this hub at {}: one visit could do it",
					if g.t == "accept" { "accepted" } else { "handed in" },
					facts.title(q),
					line_of(&goals[end])
				),
			));
		}
	}
	out
}
