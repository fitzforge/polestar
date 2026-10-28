//! The hub tour: how the route's order moves the player through a town, a camp, any cluster of quest
//! NPCs, the way leveling guides players trust walk it (Fitz, c12w Undead Warlock: #736, #737, #739,
//! #740). It runs on the route's order, before the writer puts it into v1's lines (route legs only),
//! and only moves events earlier, to where they are ready.
//!
//! - **On the way.** On a walk between two events at least [`HUB_YD`] apart, a giver or ender with a
//!   ready accept, hand-in or talk within [`PASS_YD`] of the straight leg is visited on the way, in leg
//!   order (Simmer's Fields of Grief between Calvin and Gordo, #737). Not an NPC of the hub the leg
//!   leaves (the hub's own visit takes it), nor one beside where the leg ends that the route goes on
//!   to from there anyway (Arren beside Marla's grave).
//! - **Nothing ready left behind.** At each visit to a hub (the route's NPC points linked within
//!   [`HUB_YD`]), the hub's later accepts and hand-ins that are ready by then join it (Dillinger's A
//!   Putrid Task with Holland and Zygand, #740; Aramis' A Light in the Darkness back from the cave,
//!   #736), and so do its talks the route comes back for after leaving (more than [`LEAVE_YD`] away).
//!   Ready: an accept on level (its minimum, its level less 5) with its prerequisites handed in, no
//!   exclusive partner in between, taken by the route within [`ACCEPT_AHEAD_LVL`] levels
//!   ([`PASS_AHEAD_LVL`] on the way); a hand-in accepted with every task of the world's done; a talk
//!   for a quest in the log.
//! - **One sweep.** A visit's NPCs are walked in the shortest order (exact up to
//!   [`forge_judge::check::EXACT_STOPS`], improved by moving single stops beyond: Goldshire) from
//!   where the route comes in to where it goes next, each NPC once unless the quests' own order makes
//!   a second stop shorter by more than [`STOP_YD`], the quests' own order kept. Clockwise when that
//!   walks within [`CLOCKWISE_SLACK`] of the best (Fitz told players the loops run clockwise).
//! - **What stays.** Events of one v1 guide move only among that guide's events (the guides' cut); a
//!   line a class's own v1 step waits for stays where the route has it, first in its visit; travel
//!   (a hearth, a flight) stays the visit's way in.

use crate::input::{Data, ItemT, Order, OrderT, Pt, World};
use rustc_hash::{FxHashMap, FxHashSet};

/// Quest NPCs within this many yards of each other are one hub.
pub const HUB_YD: f64 = 120.0;
/// A walk passes an NPC within this many yards of its straight leg (Dillinger 49 yd off Holland to
/// Zygand, #740; Simmer 42 yd off Calvin to Gordo, #737).
pub const PASS_YD: f64 = 50.0;
/// Two events this close are at one NPC.
const SAME_NPC_YD: f64 = 3.0;
/// A visit's order is changed only when the new one saves this many yards.
const SAVE_YD: f64 = 5.0;
/// A stop in a hub costs this many yards more: one NPC twice only when it saves more (Northshire's
/// NPCs visited twice in one visit).
pub const STOP_YD: f64 = 40.0;
/// The route has left a hub once it works or travels this far from all its NPCs (the judge's
/// `left-ready`: Deathknell's Scarlet farm, 280 yd from the church).
pub const LEAVE_YD: f64 = 200.0;
/// A clockwise loop is taken over a counter-clockwise one up to this share longer.
pub const CLOCKWISE_SLACK: f64 = 1.10;
/// A loop enclosing less than this (shoelace yd², twice the area) is a line: no turn to prefer.
const LINE_AREA_YD2: f64 = 400.0;
/// A quest more than this many levels over the character is not on level (the judge's gap).
const ON_LEVEL_GAP: f64 = 5.0;
/// An accept joins a hub visit up to this many levels before the route takes it (with it go v1's
/// lines the route does not name: Tai'jin's level 10 Hex of Weakness after Gar'Thok's accept).
pub const ACCEPT_AHEAD_LVL: f64 = 1.5;
/// ... and is taken on the way up to this many (a giver passed long before the route needs it).
pub const PASS_AHEAD_LVL: f64 = 1.0;
/// In a start zone an accept moves only where the route is this many levels over its minimum (the
/// model runs 1-1.3 levels ahead of real play there).
const START_ZONE_MARGIN_LVL: f64 = 1.0;
/// A task this close to a hub NPC is at the NPC's own spot (Kaga Wildhoof's campfire, 3 yd off): part
/// of the visit, not field work that ends it.
const NPC_SITE_YD: f64 = 10.0;
/// A delivery whose item lasts at most this many seconds is handed in first in its visit.
const TIMED_LEAD_S: f64 = 900.0;

fn yd(a: Pt, b: Pt) -> f64 {
	if a.c != b.c {
		return f64::INFINITY;
	}
	(a.wx - b.wx).hypot(a.wy - b.wy)
}

fn seg_yd(p: Pt, a: Pt, b: Pt) -> (f64, f64) {
	if p.c != a.c || a.c != b.c {
		return (f64::INFINITY, 0.0);
	}
	let (dx, dy) = (b.wx - a.wx, b.wy - a.wy);
	let l2 = dx * dx + dy * dy;
	let t = if l2 > 0.0 { (((p.wx - a.wx) * dx + (p.wy - a.wy) * dy) / l2).clamp(0.0, 1.0) } else { 0.0 };
	((p.wx - a.wx - t * dx).hypot(p.wy - a.wy - t * dy), t)
}

/// A travel item that moves the player (a hearth, a flight, a learned flight path on the way): its
/// event is where the player arrives.
fn travels(o: &Order) -> bool {
	o.items().iter().any(|it| it.t != ItemT::Bind)
}

/// What the tour reads.
struct Tour<'a> {
	world: &'a World,
	data: &'a Data,
	/// World quest by id.
	wq: FxHashMap<u32, usize>,
	/// Route fixes' orders: (a, b), a before b.
	pairs: FxHashSet<(PairEv, PairEv)>,
	/// Points where the route accepts or hands in a quest (an NPC's).
	npc_pts: FxHashSet<u32>,
	/// Events the tour leaves where the route has them (a class step waits for them).
	pinned: &'a dyn Fn(&Order) -> bool,
}

/// The order's progress up to a point: what is accepted, handed in, worked.
#[derive(Default, Clone)]
struct State {
	accepted: FxHashSet<u32>,
	handed: FxHashSet<u32>,
	tasks: FxHashSet<(u32, u32)>,
}

impl State {
	fn add(&mut self, o: &Order) {
		let Some(q) = o.q else { return };
		match o.t {
			OrderT::Accept => {
				self.accepted.insert(q);
			}
			OrderT::Turnin => {
				self.handed.insert(q);
			}
			OrderT::Task => {
				self.tasks.insert((q, o.task.unwrap_or(0)));
			}
			_ => {}
		}
	}

	fn of(order: &[Order]) -> State {
		let mut s = State::default();
		for o in order {
			s.add(o);
		}
		s
	}
}

impl Tour<'_> {
	fn pos(&self, o: &Order) -> Option<Pt> {
		o.pt.and_then(|p| self.world.points.get(p as usize)).copied().filter(|p| p.wx.is_finite() && p.wy.is_finite())
	}

	/// An event done by talking to an NPC: an accept, a hand-in, a task at a giver's or ender's point
	/// (Dillinger's report for Patience).
	/// (A task at the quest's own giver or ender is its bag hand-in, the Green Hills' chapters: not a
	/// talk.)
	fn at_npc(&self, o: &Order) -> bool {
		if matches!(o.t, OrderT::Accept | OrderT::Turnin) {
			return true;
		}
		let (OrderT::Task, Some(p), Some(q)) = (o.t, o.pt, o.q) else { return false };
		let own = self.wq.get(&q).is_some_and(|&i| self.world.quests[i].giver == Some(p) || self.world.quests[i].ender == Some(p));
		self.npc_pts.contains(&p) && !own
	}

	/// A task the world does by buying an item (the Arcane Quickener at Arbington).
	fn buys(&self, o: &Order) -> bool {
		let (OrderT::Task, Some(q)) = (o.t, o.q) else { return false };
		self.wq.get(&q).and_then(|&i| self.world.quests[i].tasks.as_ref()?.get(o.task.unwrap_or(0) as usize)).is_some_and(|t| t.is("buy"))
	}

	/// A task done on the spot by using an item (Kaga's campfire): no fight, escort or trip.
	fn spot_task(&self, o: &Order) -> bool {
		let (OrderT::Task, Some(q)) = (o.t, o.q) else { return false };
		self.wq
			.get(&q)
			.and_then(|&i| self.world.quests[i].tasks.as_ref()?.get(o.task.unwrap_or(0) as usize))
			.is_some_and(|t| !t.work.is_empty() && t.work.iter().all(|w| w.first().and_then(serde_json::Value::as_str) == Some("use")))
	}

	/// The hand-in of a delivery whose item runs out within [`TIMED_LEAD_S`] (the world's `sourceDur`:
	/// Scalding Mornbrew, 5 minutes).
	fn timed(&self, o: &Order) -> bool {
		o.t == OrderT::Turnin && o.q.and_then(|q| self.wq.get(&q)).is_some_and(|&i| self.world.quests[i].source_dur.is_some_and(|d| d > 0.0 && d <= TIMED_LEAD_S))
	}

	/// The quest's prerequisites as groups, any one of each group needed: the data's `pre` (a negative
	/// id: any of them) and `preAny`, the world's `pre`. A prerequisite the route does not hand in
	/// holds the quest where the route has it: on a shared guide the canonical start's run writes, it
	/// may be another start's (The State of the Mines before Moonbrook Espionage, Dwarves and Gnomes).
	fn pre_groups(&self, q: u32) -> Vec<Vec<u32>> {
		let mut all: Vec<u32> = Vec::new();
		let mut any: Vec<u32> = Vec::new();
		let mut push = |v: i64| {
			if v > 0 {
				all.push(v as u32);
			} else if v < 0 {
				any.push((-v) as u32);
			}
		};
		if let Some(d) = self.data.quests.get(&q) {
			for v in d.pre.iter().flatten().filter_map(serde_json::Value::as_i64) {
				push(v);
			}
		}
		if let Some(w) = self.wq.get(&q).map(|&i| &self.world.quests[i]) {
			for &v in w.pre.iter().flatten() {
				push(v);
			}
		}
		let mut groups: Vec<Vec<u32>> = all.into_iter().map(|p| vec![p]).collect();
		if !any.is_empty() {
			groups.push(any);
		}
		if let Some(pa) = self.data.quests.get(&q).and_then(|d| d.pre_any.as_ref()) {
			let g: Vec<u32> = pa.iter().filter_map(serde_json::Value::as_i64).map(|v| v.unsigned_abs() as u32).collect();
			if !g.is_empty() {
				groups.push(g);
			}
		}
		groups
	}

	/// On level at `lvl`: its minimum, its level less ON_LEVEL_GAP. In a start zone (a race's own v1
	/// guide) START_ZONE_MARGIN_LVL more: the model runs about a level ahead of real play there
	/// (Gordo's Task, minimum 5, moved onto the walk in at 4.5, #739).
	fn level_ok(&self, o: &Order, q: u32, lvl: f64) -> bool {
		let Some(d) = self.data.quests.get(&q) else { return false };
		let lvl = if start_zone(o) { lvl - START_ZONE_MARGIN_LVL } else { lvl };
		d.min_level.is_none_or(|m| m <= lvl + 1e-9) && d.level.is_none_or(|l| l - ON_LEVEL_GAP <= lvl)
	}

	/// Route fixes (`deliberate` and `overrides` `pairs`) put `a` before `b`.
	fn pair_before(&self, a: &Order, b: &Order) -> bool {
		let ev = |o: &Order| Some((o.t, o.q?));
		let (Some(x), Some(y)) = (ev(a), ev(b)) else { return false };
		self.pairs.contains(&(x, y))
	}

	/// Event `o` can be done at a point where the order's progress is `st` and the level `lvl`, with
	/// `between` the events it would jump over.
	fn ready(&self, o: &Order, st: &State, lvl: f64, between: &[Order]) -> bool {
		let Some(q) = o.q else { return false };
		// (Never ahead of an event a route-fixes pair puts before it.)
		if between.iter().any(|b| self.pair_before(b, o)) {
			return false;
		}
		match o.t {
			OrderT::Accept => {
				if st.accepted.contains(&q) || !self.level_ok(o, q, lvl) {
					return false;
				}
				// Started from an item: taken where the item is, not at an NPC.
				if self.data.quests.get(&q).is_some_and(|d| d.start.as_ref().is_some_and(|s| s.npc.is_empty() && s.object.is_empty())) {
					return false;
				}
				if !self.pre_groups(q).iter().all(|g| g.iter().any(|p| st.handed.contains(p))) {
					return false;
				}
				// An exclusive partner the route takes or hands in on the way: keep the route's order.
				let excl = self.wq.get(&q).map_or(&[][..], |&i| &self.world.quests[i].excl[..]);
				!between.iter().any(|b| b.q.is_some_and(|bq| excl.contains(&i64::from(bq)) || self.wq.get(&bq).is_some_and(|&i| self.world.quests[i].excl.contains(&i64::from(q)))))
			}
			OrderT::Turnin => {
				if !st.accepted.contains(&q) || st.handed.contains(&q) {
					return false;
				}
				let Some(w) = self.wq.get(&q).map(|&i| &self.world.quests[i]) else { return false };
				let n = w.tasks.as_ref().map_or(0, Vec::len) as u32;
				// (Objectives the world has no task for, Krang's sparring match: done somewhere the
				// route does not say, so not ready before the route's own hand-in.)
				if n == 0 && self.data.quests.get(&q).is_some_and(|d| d.objectives().next().is_some()) {
					return false;
				}
				(0..n).all(|t| st.tasks.contains(&(q, t))) && !between.iter().any(|b| b.q == Some(q))
			}
			OrderT::Task => st.accepted.contains(&q) && !st.handed.contains(&q) && !between.iter().any(|b| b.q == Some(q) && b.t != OrderT::Task),
			_ => false,
		}
	}

	/// `b` must stay after `a` (both in one visit, `a` first in the route's order): the same quest's
	/// events, a prerequisite's hand-in and its follow-up's accept, exclusive partners, a training or an
	/// accept over the visit's starting level after the hand-ins before it, and lines of two v1 guides
	/// (Mulgore's last hand-in at the Crossroads before the Barrens guide's accepts: the guides' cut).
	fn must_follow(&self, a: &Order, b: &Order, lvl0: f64) -> bool {
		if matches!(a.t, OrderT::Level | OrderT::Ride | OrderT::Other) || matches!(b.t, OrderT::Level | OrderT::Ride | OrderT::Other) || file(a) != file(b) {
			return true;
		}
		if self.pair_before(a, b) {
			return true;
		}
		if a.q.is_some() && a.q == b.q {
			return true;
		}
		if a.t == OrderT::Turnin && (b.t == OrderT::Train || b.t == OrderT::Accept && b.q.is_some_and(|q| self.data.quests.get(&q).and_then(|d| d.min_level).is_some_and(|m| m > lvl0 + 1e-9))) {
			return true;
		}
		let (Some(qa), Some(qb)) = (a.q, b.q) else { return false };
		if a.t == OrderT::Turnin && b.t == OrderT::Accept && self.pre_groups(qb).iter().any(|g| g.contains(&qa)) {
			return true;
		}
		let ex = |x: u32, y: u32| self.wq.get(&x).is_some_and(|&i| self.world.quests[i].excl.contains(&i64::from(y)));
		ex(qa, qb) || ex(qb, qa)
	}
}

fn opt(q: Option<u32>) -> String {
	q.map_or_else(|| "-".into(), |q| q.to_string())
}

/// The v1 guide an event's line is in. The tour moves events within one guide: the guides' cut and
/// the class steps placed by the route's lines stay as they were (Booty Bay's Bloodsail Buccaneers at
/// the end of the Arathi guide moved Stranglethorn's first steps into it).
fn file(o: &Order) -> Option<&str> {
	o.from.as_deref().and_then(|f| f.rsplit_once(':')).map(|f| f.0)
}

/// An event of a start zone: its v1 guide is a race's own (`forever/horde/undead/...`), not one of the
/// faction's shared guides (`forever/horde/04-the-barrens`, `forever/horde/30-40/...`).
fn start_zone(o: &Order) -> bool {
	let Some(f) = file(o) else { return false };
	let parts: Vec<&str> = f.trim_start_matches("guides/").split('/').collect();
	matches!(parts.as_slice(), ["forever", "horde" | "alliance", dir, _] if !dir.starts_with(|c: char| c.is_ascii_digit()))
}

/// An event a route-fixes pair names: (kind, quest).
pub type PairEv = (OrderT, u32);

/// The route fixes' `deliberate` and `overrides` `pairs` and `deliberate` `after` (`a` before `b`) as events, when a route
/// fixes file is loaded (forge_sim::fixes).
pub fn fix_pairs() -> Vec<(PairEv, PairEv)> {
	if forge_sim::fixes::path().is_none() {
		return Vec::new();
	}
	let doc = forge_sim::fixes::get();
	let ev = |v: &serde_json::Value| -> Option<PairEv> {
		let t = match v.get(0)?.as_str()? {
			"accept" => OrderT::Accept,
			"turnin" => OrderT::Turnin,
			"task" => OrderT::Task,
			_ => return None,
		};
		Some((t, u32::try_from(v.get(1)?.as_u64()?).ok()?))
	};
	// (`after` rules too: `a` before `b`, as a pair, W1.)
	[&doc["deliberate"]["pairs"], &doc["overrides"]["pairs"], &doc["deliberate"]["after"]].into_iter().filter_map(|v| v.as_array()).flatten().filter_map(|p| Some((ev(&p["a"])?, ev(&p["b"])?))).collect()
}

/// The hub tour of the route's order (module docs). -> the order, a log line per moved event.
/// `pinned`: events the tour must not move; `pairs`: route fixes' orders it keeps ([`fix_pairs`]).
pub fn tour(order: Vec<Order>, world: &World, data: &Data, pinned: &dyn Fn(&Order) -> bool, pairs: &[(PairEv, PairEv)]) -> (Vec<Order>, Vec<String>) {
	let mut t = Tour { world, data, wq: FxHashMap::default(), pairs: pairs.iter().copied().collect(), npc_pts: FxHashSet::default(), pinned };
	for (i, q) in world.quests.iter().enumerate() {
		t.wq.insert(q.id, i);
	}
	for o in &order {
		if matches!(o.t, OrderT::Accept | OrderT::Turnin) {
			t.npc_pts.extend(o.pt);
		}
	}
	let mut log = Vec::new();
	let hub_of = hubs(&t, &order);
	let order = on_the_way(&t, &hub_of, order, &mut log);
	(hub_visits(&t, &hub_of, order, &mut log), log)
}

/// Ready NPC events within [`PASS_YD`] of a walk leg go on that leg, in leg order. (A leg inside a
/// hub is the hub's sweep's: Terrence on the road out of Brill is not between two of its NPCs.)
fn on_the_way(t: &Tour, hub_of: &FxHashMap<u32, usize>, mut order: Vec<Order>, log: &mut Vec<String>) -> Vec<Order> {
	let hub = |o: &Order| o.pt.and_then(|p| hub_of.get(&p).copied());
	let mut st = State::default();
	let mut x = 1;
	if let Some(o) = order.first() {
		st.add(o);
	}
	while x < order.len() {
		let (Some(a), Some(b)) = (t.pos(&order[x - 1]), t.pos(&order[x])) else {
			st.add(&order[x]);
			x += 1;
			continue;
		};
		// (A leg inside a hub, or a step across the street, is the hub's sweep's.)
		if travels(&order[x]) || yd(a, b) <= HUB_YD || hub(&order[x]).is_some_and(|h| hub(&order[x - 1]) == Some(h)) {
			st.add(&order[x]);
			x += 1;
			continue;
		}
		let lvl = order[x].lvl.unwrap_or(0.0);
		// (index, leg share) of each event to take on the way.
		let mut take: Vec<(usize, f64)> = Vec::new();
		for k in x + 1..order.len() {
			let o = &order[k];
			if !t.at_npc(o) || travels(o) || !soon(o, lvl, PASS_AHEAD_LVL) || file(o) != file(&order[x]) || hub(o).is_some_and(|h| hub(&order[x - 1]) == Some(h)) {
				continue;
			}
			let Some(p) = t.pos(o) else { continue };
			let (d, s) = seg_yd(p, a, b);
			// (An NPC beside where the leg ends that the route goes on to from there anyway is its next
			// stop: Arren beside Marla's grave. Not Simmer by Gordo, left behind for Brill.)
			let next_stop = || yd(p, b) <= HUB_YD && order[x..k].iter().all(|e| t.pos(e).is_none_or(|q| yd(q, b) <= LEAVE_YD));
			if d > PASS_YD || yd(p, a) <= SAME_NPC_YD || yd(p, b) <= SAME_NPC_YD || next_stop() {
				continue;
			}
			if !(t.pinned)(o) && t.ready(o, &st, lvl, &order[x..k]) {
				take.push((k, s));
			}
		}
		if take.is_empty() {
			st.add(&order[x]);
			x += 1;
			continue;
		}
		take.sort_by(|p, q| p.1.total_cmp(&q.1).then(p.0.cmp(&q.0)));
		let mut moved: Vec<Order> = Vec::new();
		let mut idx: Vec<usize> = take.iter().map(|p| p.0).collect();
		idx.sort_unstable();
		let mut by_k: FxHashMap<usize, Order> = FxHashMap::default();
		for &k in idx.iter().rev() {
			by_k.insert(k, take_out(&mut order, k));
		}
		for (k, _) in &take {
			let mut o = by_k.remove(k).unwrap();
			log.push(format!("hub tour: {:?} {} on the way, level {:.2} -> {lvl:.2}", o.t, opt(o.q), o.lvl.unwrap_or(0.0)));
			o.lvl = Some(lvl);
			moved.push(o);
		}
		let n = moved.len();
		for (m, o) in moved.into_iter().enumerate() {
			order.insert(x + m, o);
		}
		for o in &order[x..x + n] {
			st.add(o);
		}
		x += n;
	}
	order
}

/// Removes event `k`; its travel items go to the event after it, which is now reached that way.
fn take_out(order: &mut Vec<Order>, k: usize) -> Order {
	let mut o = order.remove(k);
	if let Some(its) = o.items.take().filter(|v| !v.is_empty()) {
		if let Some(next) = order.get_mut(k) {
			let mut v = its;
			v.extend(next.items.take().unwrap_or_default());
			next.items = Some(v);
		}
	}
	o
}

/// The hubs: the route's NPC points linked within [`HUB_YD`]. -> hub of each point.
fn hubs(t: &Tour, order: &[Order]) -> FxHashMap<u32, usize> {
	let mut pts: Vec<u32> = order.iter().filter(|o| t.at_npc(o) || o.t == OrderT::Train).filter_map(|o| o.pt).filter(|&p| t.world.points.get(p as usize).is_some()).collect();
	pts.sort_unstable();
	pts.dedup();
	let w = |p: u32| t.world.points[p as usize];
	let cell = |p: Pt| (p.c, (p.wx / HUB_YD).floor() as i64, (p.wy / HUB_YD).floor() as i64);
	let mut grid: FxHashMap<(i64, i64, i64), Vec<usize>> = FxHashMap::default();
	for (k, &p) in pts.iter().enumerate() {
		grid.entry(cell(w(p))).or_default().push(k);
	}
	let mut parent: Vec<usize> = (0..pts.len()).collect();
	fn root(p: &mut [usize], mut x: usize) -> usize {
		while p[x] != x {
			p[x] = p[p[x]];
			x = p[x];
		}
		x
	}
	for (k, &p) in pts.iter().enumerate() {
		let (c, x, y) = cell(w(p));
		for dx in -1..=1 {
			for dy in -1..=1 {
				for &m in grid.get(&(c, x + dx, y + dy)).into_iter().flatten() {
					if m < k && yd(w(pts[m]), w(p)) <= HUB_YD {
						let (a, b) = (root(&mut parent, k), root(&mut parent, m));
						parent[a] = b;
					}
				}
			}
		}
	}
	let mut id: FxHashMap<usize, usize> = FxHashMap::default();
	let mut of: FxHashMap<u32, usize> = FxHashMap::default();
	for (k, &p) in pts.iter().enumerate() {
		let r = root(&mut parent, k);
		let n = id.len();
		of.insert(p, *id.entry(r).or_insert(n));
	}
	of
}

/// An event the tour may move to a point at level `lvl`: any hand-in or talk, an accept the route
/// takes within `ahead` levels (a quest taken much later is a later visit's, not one left behind:
/// Kolkar Leaders at 20, not at 14).
fn soon(o: &Order, lvl: f64, ahead: f64) -> bool {
	o.t != OrderT::Accept || o.lvl.is_none_or(|l| l - lvl <= ahead)
}

/// Each visit to a hub takes every later line of the hub ready by then, and walks its NPCs in one
/// sweep.
fn hub_visits(t: &Tour, hub_of: &FxHashMap<u32, usize>, mut order: Vec<Order>, log: &mut Vec<String>) -> Vec<Order> {
	let hub = |o: &Order| -> Option<usize> { o.pt.and_then(|p| hub_of.get(&p).copied()).filter(|_| t.at_npc(o) || o.t == OrderT::Train) };
	let mut members: Vec<Vec<Pt>> = Vec::new();
	for (&p, &h) in hub_of {
		if members.len() <= h {
			members.resize(h + 1, Vec::new());
		}
		members[h].push(t.world.points[p as usize]);
	}
	// (Field work, a grind, travel: the visit ends; Brill's Discipline round splits it in two. Not a
	// task at a hub NPC's own spot, Kaga Wildhoof's campfire in Bloodhoof Village.)
	let in_hub = |o: &Order, h: usize| -> bool {
		!travels(o) && (hub(o) == Some(h) || (t.spot_task(o) && t.pos(o).is_some_and(|p| members[h].iter().any(|&m| yd(m, p) <= NPC_SITE_YD))))
	};
	// (The route has left hub `h` at an event: travel, or a place more than LEAVE_YD from it.)
	let away = |o: &Order, h: usize| travels(o) || t.pos(o).is_some_and(|p| members[h].iter().all(|&m| yd(m, p) > LEAVE_YD));
	let mut i = 0;
	while i < order.len() {
		let Some(h) = hub(&order[i]) else {
			i += 1;
			continue;
		};
		let mut j = i + 1;
		while j < order.len() && in_hub(&order[j], h) {
			j += 1;
		}
		// Every later line of the hub, ready by now, joins the visit (a hand-in may open an accept):
		// the accepts and hand-ins of this stay in town (Dillinger's Putrid Task with Holland and
		// Zygand, before the Discipline round, #740) and any the route comes back for. A talk of this
		// stay keeps its place (Dillinger's report for Patience, after the round). A visit to buy an
		// item takes nothing: an Arcane Quickener runs out before Chillwind's hand-ins are done (the
		// writer keeps a timed item's chain together).
		let lvl = order[i].lvl.unwrap_or(0.0);
		let mut st = State::of(&order[..j]);
		let mut left = (j..order.len()).find(|&k| away(&order[k], h)).unwrap_or(order.len());
		let errand = order[i..j].iter().any(|o| t.buys(o));
		while !errand {
			let mut pulled = false;
			let mut k = j;
			while k < order.len() {
				let o = &order[k];
				if (k >= left || o.t != OrderT::Task)
					&& hub(o) == Some(h)
					&& !travels(o) && t.at_npc(o)
					&& !(t.pinned)(o)
					&& soon(o, lvl, ACCEPT_AHEAD_LVL)
					&& file(o) == file(&order[i])
					&& t.ready(o, &st, lvl, &order[j..k])
				{
					if k >= left {
						left += 1;
					}
					let mut o = take_out(&mut order, k);
					log.push(format!("hub tour: {:?} {} to an earlier visit, level {:.2} -> {lvl:.2}", o.t, opt(o.q), o.lvl.unwrap_or(0.0)));
					o.lvl = Some(lvl);
					st.add(&o);
					order.insert(j, o);
					j += 1;
					pulled = true;
				}
				k += 1;
			}
			if !pulled {
				break;
			}
		}
		sweep(t, &mut order, i, j, lvl);
		bind_at_inn(t, &mut order, i, j);
		i = j;
	}
	order
}

/// A bind made in a visit goes with the visit's event nearest the inn: the writer's `sethome` is a stop
/// at the innkeeper, made on the sweep's way past the inn (Lakeshire, the judge's hub-order).
fn bind_at_inn(t: &Tour, order: &mut [Order], i: usize, j: usize) {
	for k in i..j {
		let binds: Vec<_> = order[k].items().iter().filter(|it| it.t == ItemT::Bind).cloned().collect();
		for b in binds {
			let Some(inn) = b.inn_pt.or(b.pt).and_then(|p| t.world.points.get(p as usize)).copied() else { continue };
			let d = |x: usize| t.pos(&order[x]).map_or(f64::INFINITY, |p| yd(p, inn));
			let Some(best) = (i..j).min_by(|&a, &b| d(a).total_cmp(&d(b))) else { continue };
			if best == k || d(best) + SAME_NPC_YD >= d(k) {
				continue;
			}
			if let Some(its) = order[k].items.as_mut() {
				if let Some(p) = its.iter().position(|x| *x == b) {
					its.remove(p);
				}
			}
			order[best].items.get_or_insert_with(Vec::new).push(b);
		}
	}
}

/// Walks the visit `order[i..j]` in the shortest order from where the route comes in to where it goes
/// next: one stop per NPC (else per run of lines at one NPC, when the quests' order needs an NPC
/// twice), each stop's lines in the route's order.
fn sweep(t: &Tour, order: &mut [Order], i: usize, j: usize, lvl0: f64) {
	if j - i < 2 {
		return;
	}
	// Where the route comes in: the inn it hearths to, else the event before (a flight: anywhere).
	let first = &order[i];
	let entry = match first.items().iter().find(|it| it.t != ItemT::Bind) {
		Some(it) if it.t == ItemT::Hearth => it.inn_pt.and_then(|p| t.world.points.get(p as usize)).copied(),
		Some(_) => None,
		None => i.checked_sub(1).and_then(|p| t.pos(&order[p])),
	};
	let exit = order.get(j).and_then(|o| t.pos(o));
	let ev: Vec<usize> = (i..j).collect();
	let Some(pts) = ev.iter().map(|&e| t.pos(&order[e])).collect::<Option<Vec<Pt>>>() else { return };
	let group = |by_run: bool| -> Vec<Vec<usize>> {
		let mut stops: Vec<Vec<usize>> = Vec::new();
		for k in 0..ev.len() {
			let at = |s: &Vec<usize>| t.at_npc(&order[ev[s[0]]]) && t.at_npc(&order[ev[k]]) && yd(pts[s[0]], pts[k]) <= SAME_NPC_YD;
			let found = if by_run { stops.last().filter(|s| at(s)).map(|_| stops.len() - 1) } else { stops.iter().position(at) };
			match found {
				Some(s) => stops[s].push(k),
				None => stops.push(vec![k]),
			}
		}
		stops
	};
	let preds = |stops: &[Vec<usize>]| -> Option<Vec<u64>> {
		let n = stops.len();
		if n > 64 {
			return None;
		}
		let mut pred = vec![0u64; n];
		for a in 0..n {
			for b in 0..n {
				if a != b && stops[a].iter().any(|&x| stops[b].iter().any(|&y| x < y && t.must_follow(&order[ev[x]], &order[ev[y]], lvl0))) {
					pred[b] |= 1 << a;
				}
			}
		}
		// The arrival (a hearth or flight) stays first.
		if travels(first) {
			let s0 = stops.iter().position(|s| s.contains(&0)).unwrap();
			for (b, p) in pred.iter_mut().enumerate() {
				if b != s0 {
					*p |= 1 << s0;
				}
			}
		}
		// The first line a class step waits for (the class step goes right before it: the Warlocks'
		// Perrine's Chest before Burgess' hand-in) goes last, after every stop that does not wait for
		// it: the class step closes the town visit, never splits it (Islen inside Ratchet).
		if let Some(k0) = (0..ev.len()).find(|&k| (t.pinned)(&order[ev[k]])).filter(|&k| !(travels(first) && stops.iter().position(|s| s.contains(&k)) == stops.iter().position(|s| s.contains(&0)))) {
			let s0 = stops.iter().position(|s| s.contains(&k0)).unwrap();
			let mut after: u64 = 0;
			let mut grow = true;
			while grow {
				grow = false;
				for (b, p) in pred.iter().enumerate() {
					if after & (1 << b) == 0 && (*p & ((1 << s0) | after)) != 0 {
						after |= 1 << b;
						grow = true;
					}
				}
			}
			for b in 0..n {
				if b != s0 && after & (1 << b) == 0 && pred[b] & (1 << s0) == 0 {
					pred[s0] |= 1 << b;
				}
			}
		}
		Some(pred)
	};
	// Each NPC once; else, where it pays, an NPC's lines no other stop opens first, then the rest
	// (Dillinger's Putrid Task on the way in to Zygand, his report for Patience after): each stop costs
	// [`STOP_YD`] more.
	let split = |stops: &[Vec<usize>]| -> Vec<Vec<usize>> {
		let mut out = Vec::new();
		for (si, s) in stops.iter().enumerate() {
			let mut dep: Vec<usize> = Vec::new();
			for &y in s {
				let opened = stops.iter().enumerate().any(|(sj, o)| sj != si && o.iter().any(|&x| x < y && t.must_follow(&order[ev[x]], &order[ev[y]], lvl0)));
				if opened || dep.iter().any(|&x| x < y && t.must_follow(&order[ev[x]], &order[ev[y]], lvl0)) {
					dep.push(y);
				}
			}
			let free: Vec<usize> = s.iter().copied().filter(|k| !dep.contains(k)).collect();
			out.extend([free, dep].into_iter().filter(|v| !v.is_empty()));
		}
		out
	};
	let solve = |stops: &[Vec<usize>]| -> Option<(f64, f64, Vec<usize>)> {
		let mut pred = preds(stops)?;
		// (A delivery whose item runs out leads the visit, after its way in: Durnan's Scalding Mornbrew
		// before Anvilmar's other NPCs, RevDwarfGnome3.)
		if let Some(s0) = stops.iter().position(|s| s.iter().any(|&k| t.timed(&order[ev[k]]))) {
			let way_in = travels(first).then(|| stops.iter().position(|s| s.contains(&0))).flatten();
			for b in 0..stops.len() {
				if b != s0 && Some(b) != way_in && pred[s0] & (1 << b) == 0 {
					pred[b] |= 1 << s0;
				}
			}
		}
		let sp: Vec<Pt> = stops.iter().map(|s| pts[s[0]]).collect();
		let cost = |a: Option<usize>, b: Option<usize>| match (a.map(|a| sp[a]).or(entry), b.map(|b| sp[b]).or(exit)) {
			(Some(p), Some(q)) if a.is_some() || b.is_some() => yd(p, q),
			_ => 0.0,
		};
		let (mut c, mut o) = forge_judge::check::best_tour(sp.len(), &pred, &cost)?;
		// Clockwise when that walks within CLOCKWISE_SLACK of the best (Fitz: "clockwise").
		if clockwise(&o.iter().map(|&s| sp[s]).collect::<Vec<_>>()) == Some(false) {
			let r: Vec<usize> = o.iter().rev().copied().collect();
			let rc = tour_yd(&r, &cost);
			if fits(&r, &pred) && rc <= c * CLOCKWISE_SLACK {
				(c, o) = (rc, r);
			}
		}
		Some((c, c + STOP_YD * stops.len() as f64, o))
	};
	let mut stops = group(false);
	let mut sol = solve(&stops);
	let parts = split(&stops);
	if parts.len() > stops.len() {
		if let Some(s2) = solve(&parts).filter(|s2| sol.as_ref().is_none_or(|s1| s2.1 < s1.1)) {
			stops = parts;
			sol = Some(s2);
		}
	}
	if sol.is_none() {
		stops = group(true);
		sol = solve(&stops);
	}
	let Some((best, _, tour)) = sol else { return };
	let now = path_yd(&pts, entry, exit);
	// (A written counter-clockwise loop turns clockwise when that costs no more than the slack.)
	let cw = clockwise(&tour.iter().map(|&s| pts[stops[s][0]]).collect::<Vec<_>>()) == Some(true);
	let turn = cw && clockwise(&pts) == Some(false) && best <= now * CLOCKWISE_SLACK;
	// (A delivery written after another NPC of the visit: the tour leads with it, whatever it costs.)
	let way_in = usize::from(travels(first));
	let timed_late = (0..ev.len()).find(|&k| t.timed(&order[ev[k]])).is_some_and(|k| (way_in..k).any(|x| yd(pts[x], pts[k]) > SAME_NPC_YD));
	if best >= now - SAVE_YD && !turn && !timed_late {
		return;
	}
	let seq: Vec<usize> = tour.iter().flat_map(|&s| stops[s].iter().copied()).collect();
	let mut new: Vec<Order> = seq.iter().map(|&k| order[ev[k]].clone()).collect();
	// The arrival's travel goes with whatever comes first now.
	if seq[0] != 0 {
		let travel: Vec<_> = order[i].items().iter().filter(|it| it.t != ItemT::Bind).cloned().collect();
		if !travel.is_empty() {
			let k0 = seq.iter().position(|&k| k == 0).unwrap();
			new[k0].items = Some(order[i].items().iter().filter(|it| it.t == ItemT::Bind).cloned().collect());
			let mut v = travel;
			v.extend(new[0].items.take().unwrap_or_default());
			new[0].items = Some(v);
		}
	}
	for (o, n) in order[i..j].iter_mut().zip(new) {
		let lvl = o.lvl;
		*o = n;
		o.lvl = lvl.or(o.lvl);
	}
}

fn path_yd(pts: &[Pt], entry: Option<Pt>, exit: Option<Pt>) -> f64 {
	let mut at = entry;
	let mut sum = 0.0;
	for &p in pts.iter().chain(exit.as_ref()) {
		if let Some(a) = at {
			sum += yd(a, p);
		}
		at = Some(p);
	}
	sum
}

/// Whether a loop through `pts` (closed) runs clockwise on the map (north up: world x north, y west);
/// None when it encloses next to nothing (a line of stops).
fn clockwise(pts: &[Pt]) -> Option<bool> {
	if pts.len() < 3 {
		return None;
	}
	// Shoelace on (east, north) = (-wy, wx): positive is counter-clockwise.
	let mut a = 0.0;
	for (k, p) in pts.iter().enumerate() {
		let q = pts[(k + 1) % pts.len()];
		a += (-p.wy) * q.wx - (-q.wy) * p.wx;
	}
	(a.abs() > LINE_AREA_YD2).then_some(a < 0.0)
}

fn tour_yd(order: &[usize], cost: &dyn Fn(Option<usize>, Option<usize>) -> f64) -> f64 {
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
