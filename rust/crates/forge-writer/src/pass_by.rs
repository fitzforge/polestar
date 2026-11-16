//! Pass-by pickups (docs/forge/writer.md, "Pass-by pickups", #1959): a quest the route takes on a later
//! visit to its giver is taken on an earlier walk that passes the giver within [`PASS_YD`], when the
//! character can take it there and its work fits that visit. The accept goes on that walk, its work
//! right after it, and its hand-in too when the ender is at hand. The Barrens' second Dry Hills trip
//! passes Vrang Wildgore 150 yd off at about 18; the route took Bruised Pride and Lion Hides and Vrang's
//! Game on a third trip north.
//!
//! - **Passes.** A walk between two of the route's stops (no hearth, flight, ride or deathskip; other
//!   starts' stops passed over) passes a giver when its straight leg, by way of a flight master the walk
//!   learns on the way, comes within [`PASS_YD`] of the giver. The route's own accept must be a later
//!   visit: the route goes more than [`LATER_YD`] from the giver, or travels, before it.
//! - **The character can take it there**: on level at the walk's level (the hub tour's rule: its minimum,
//!   its level less 5, a level more in a start zone), every prerequisite handed in by then, no exclusive
//!   partner taken or handed in between, not started from an item, not a class's own, repeatable or
//!   on-the-spot quest, and the quest log within the room the route keeps.
//! - **Its work fits that visit**: every task the route works for it within [`REACH_YD`] of the giver,
//!   each at a level that fits there (level_fit.rs), and something done on the visit: a task, or the
//!   hand-in at an ender within [`REACH_YD`] (the hand-in then comes too). A hand-in that comes along
//!   stands the player at the giver of the next part, which comes along in turn when it fits (Vrang's
//!   hand-ins, then The Hermit Tanner to Walton on the ridge).
//! - **Never pulled**: group families, elite, escort and timed quests, the route fixes' optional and
//!   group quests, other starts' events, a line a class step waits for, a quest across the shared
//!   route's join, or out of a race's own guide into another guide.
//! - **The route fixes hold**: never ahead of an event a `pairs` or `after` record (or an `include`'s
//!   `after`) puts first; a `together` step only with its partner; a `stay` or `revert` step stays where
//!   it is; nothing moved onto a `southward` map before its end. A pass a record refuses logs why.
//!
//! Each quest taken earlier logs one line (`pass-by: ...`), as each pass a record refuses.

use crate::hub::{self, PairEv};
use crate::input::{Data, ItemT, Order, OrderT, Pt, Route};
use crate::level_fit::{self, name};
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::Value;

/// A walk passes a quest giver within this many yards of its straight leg: Vrang Wildgore 150 yd off
/// the Barrens' second Dry Hills trip (#1959). Farther off, the walk there and back alone passes 400 yd:
/// a stop of its own.
pub const PASS_YD: f64 = 200.0;
/// A task worked this near its giver, or an ender standing this near, is within the visit's reach:
/// Vrang's traps 326 yd from him and his lions 144 yd, Walton's two quests within 190 yd of the hermit,
/// who stands 188 yd from Vrang.
pub const REACH_YD: f64 = 400.0;
/// The route's own accept is a later visit when the route goes this far from the giver, or travels,
/// before it (the writer's hop between two stops, ZONE_STEP_YD).
pub const LATER_YD: f64 = 600.0;
/// Open quests the route keeps room under (docs/forge/model.md, "Quest log": the class quests the
/// writer adds).
const LOG_ROOM: usize = 38;
/// The givers' grid cell, yards.
const CELL: f64 = 400.0;
/// A walk this near the giver starts or ends at him (the log says "at its giver"; the hub tour's
/// SAME_NPC_YD).
const AT_GIVER_YD: f64 = 3.0;

/// The route fixes' records the rule keeps, and the quests it leaves alone.
#[derive(Debug, Default)]
pub struct Pins {
	/// Never pulled: the route's group families, the route fixes' optional and group quests.
	pub exempt: FxHashSet<u32>,
	/// `a` before `b`: `deliberate` and `overrides` `pairs`, `deliberate.after`, and an `include`'s
	/// `after` step before each of its quest's events.
	pub pairs: FxHashSet<(PairEv, PairEv)>,
	/// `b` right after `a` (`deliberate.together`).
	pub together: Vec<(PairEv, PairEv)>,
	/// Steps that keep v1's neighbours (`deliberate.stay`, `overrides.revert`).
	pub stay: FxHashSet<PairEv>,
	/// A map the route walks only south on until a step (`deliberate.southward`).
	pub southward: Vec<(u32, PairEv)>,
}

/// A route fixes list's records for one side (a record with a `faction` holds for that side only).
fn rows<'a>(v: &'a Value, faction: Option<&'a str>) -> impl Iterator<Item = &'a Value> + 'a {
	v.as_array().into_iter().flatten().filter(move |r| r["faction"].as_str().is_none_or(|f| faction.is_none_or(|g| f.eq_ignore_ascii_case(g))))
}

impl Pins {
	/// The pins of the route fixes in use (when a file is loaded, forge_sim::fixes) and the route's
	/// group families.
	pub fn of(route: &Route) -> Pins {
		let mut p = if forge_sim::fixes::path().is_some() { Pins::of_doc(&forge_sim::fixes::get(), route.faction.as_deref()) } else { Pins::default() };
		p.exempt.extend(route.groups.iter().filter_map(|g| g.q).chain(route.groups.iter().flat_map(|g| g.quests.iter().copied())));
		p
	}

	/// The pins of a route fixes document for one side.
	pub fn of_doc(doc: &Value, faction: Option<&str>) -> Pins {
		let q = |r: &Value| r["q"].as_u64().and_then(|x| u32::try_from(x).ok());
		let mut p = Pins { pairs: hub::pairs_of(doc, faction).into_iter().collect(), ..Pins::default() };
		p.exempt.extend(rows(&doc["deliberate"]["optional"], faction).chain(rows(&doc["deliberate"]["group"], faction)).filter_map(q));
		for r in rows(&doc["overrides"]["include"], faction) {
			if let (Some(x), Some(a)) = (q(r), hub::pair_ev(&r["after"])) {
				p.pairs.extend([OrderT::Accept, OrderT::Task, OrderT::Turnin].map(|t| (a, (t, x))));
			}
		}
		p.together = rows(&doc["deliberate"]["together"], faction).filter_map(|r| Some((hub::pair_ev(&r["a"])?, hub::pair_ev(&r["b"])?))).collect();
		p.stay = rows(&doc["deliberate"]["stay"], faction).chain(rows(&doc["overrides"]["revert"], faction)).filter_map(|r| hub::pair_ev(&r["s"])).collect();
		p.southward = rows(&doc["deliberate"]["southward"], faction).filter_map(|r| Some((u32::try_from(r["map"].as_u64()?).ok()?, hub::pair_ev(&r["until"])?))).collect();
		p
	}
}

/// What the rule did to the order.
#[derive(Debug, Default)]
pub struct Pulled {
	pub order: Vec<Order>,
	/// One line per decision (`pass-by: ...`).
	pub log: Vec<String>,
}

/// Travel that takes the player off the walk: a hearth, a flight or ride, a deathskip.
fn travels(o: &Order) -> bool {
	o.items().iter().any(|it| matches!(it.t, ItemT::Hearth | ItemT::Network | ItemT::Deathskip))
}

fn ev(o: &Order) -> Option<PairEv> {
	Some((o.t, o.q?))
}

/// An event as the log names it: `task harpy lieutenants (875)`.
pub(crate) fn desc(data: &Data, o: &Order) -> String {
	format!("{:?} {}", o.t, o.q.map_or_else(String::new, |q| name(data, q))).to_lowercase()
}

fn pin_desc(data: &Data, e: &PairEv) -> String {
	format!("{:?} {}", e.0, name(data, e.1)).to_lowercase()
}

/// Open quests before each event (the last entry: after the order): taken by the route's own events
/// and not yet handed in.
fn open_counts(o: &[Order]) -> Vec<usize> {
	let mut open: FxHashSet<u32> = FxHashSet::default();
	let mut out = Vec::with_capacity(o.len() + 1);
	out.push(0);
	for e in o {
		if let (false, Some(q)) = (e.extra, e.q) {
			match e.t {
				OrderT::Accept => {
					open.insert(q);
				}
				OrderT::Turnin => {
					open.remove(&q);
				}
				_ => {}
			}
		}
		out.push(open.len());
	}
	out
}

/// Each quest's first accept, and every event of each quest, by index.
fn index(o: &[Order]) -> (FxHashMap<u32, usize>, FxHashMap<u32, Vec<usize>>) {
	let mut accept_at: FxHashMap<u32, usize> = FxHashMap::default();
	let mut events_of: FxHashMap<u32, Vec<usize>> = FxHashMap::default();
	for (m, e) in o.iter().enumerate() {
		let Some(q) = e.q else { continue };
		events_of.entry(q).or_default().push(m);
		if e.t == OrderT::Accept {
			accept_at.entry(q).or_insert(m);
		}
	}
	(accept_at, events_of)
}

/// A quest to take on the walk.
struct Cand {
	q: u32,
	/// Yards off the walk.
	off: f64,
	accept: usize,
	tasks: Vec<usize>,
	/// The hand-in that comes along.
	hand: Option<usize>,
	/// The route's level at its own accept.
	was: Option<f64>,
}

/// The pulled events in their new order: the accepts, then the work, then the hand-ins, each in the
/// route's order.
fn block_of(cands: &[Cand]) -> Vec<usize> {
	let mut tasks: Vec<usize> = cands.iter().flat_map(|c| c.tasks.iter().copied()).collect();
	tasks.sort_unstable();
	let mut hands: Vec<usize> = cands.iter().filter_map(|c| c.hand).collect();
	hands.sort_unstable();
	cands.iter().map(|c| c.accept).chain(tasks).chain(hands).collect()
}

/// The rule on a route's order (module docs). `pinned`: events a class step waits for; `join`: the
/// route order index where the faction's shared route begins (`shared.joinStep`; a start's own part
/// before it, by each event's index in the route).
pub(crate) fn pull(order: Vec<Order>, cx: &level_fit::Ctx, pins: &Pins, pinned: &dyn Fn(&Order) -> bool, join: Option<usize>) -> Pulled {
	let (world, data) = (cx.world, cx.data);
	let mut o = order;
	let mut log = Vec::new();
	let giver = |q: u32| -> Option<Pt> {
		let p = cx.wq.get(&q).and_then(|&i| world.quests[i].giver)?;
		world.points.get(p as usize).copied().filter(|p| p.wx.is_finite() && p.wy.is_finite())
	};
	// The givers of the quests the route accepts, by place.
	let cell = |p: Pt| (p.c, (p.wx / CELL).floor() as i64, (p.wy / CELL).floor() as i64);
	let mut cells: FxHashMap<(i64, i64, i64), Vec<(u32, Pt)>> = FxHashMap::default();
	let mut seen: FxHashSet<u32> = FxHashSet::default();
	for e in &o {
		if let (OrderT::Accept, Some(q)) = (e.t, e.q) {
			if let Some(g) = giver(q).filter(|_| seen.insert(q)) {
				cells.entry(cell(g)).or_default().push((q, g));
			}
		}
	}
	let mut open = open_counts(&o);
	let room = LOG_ROOM.max(open.iter().copied().max().unwrap_or(0));
	let (mut accept_at, mut events_of) = index(&o);
	let own = |e: &Order| join.is_some_and(|j| e.ix.is_some_and(|ix| ix < j));
	let excl = |x: u32, y: u32| cx.wq.get(&x).is_some_and(|&i| world.quests[i].excl.contains(&i64::from(y)));
	let mut pulled: FxHashSet<u32> = FxHashSet::default();
	let mut told: FxHashSet<u32> = FxHashSet::default();
	// The progress through the event a walk leaves from: the route's own accepts and hand-ins of the
	// first `done` events.
	let (mut accepted, mut handed): (FxHashSet<u32>, FxHashSet<u32>) = Default::default();
	let mut done = 0;
	let mut k = 1;
	while k < o.len() {
		if o[k].extra || travels(&o[k]) {
			k += 1;
			continue;
		}
		let Some(kp) = (0..k).rev().find(|&m| !o[m].extra) else {
			k += 1;
			continue;
		};
		while done <= kp {
			if let (false, Some(q)) = (o[done].extra, o[done].q) {
				match o[done].t {
					OrderT::Accept => {
						accepted.insert(q);
					}
					OrderT::Turnin => {
						handed.insert(q);
					}
					_ => {}
				}
			}
			done += 1;
		}
		// (An event with no level, an old route's, is not judged.)
		let (Some(a), Some(b), Some(lvl)) = (cx.pt(&o[kp]), cx.pt(&o[k]), o[k].lvl.or(o[kp].lvl)) else {
			k += 1;
			continue;
		};
		let mut way = vec![a];
		way.extend(o[k].items().iter().filter(|it| it.t == ItemT::Getfp).filter_map(|it| world.nodes.get(it.node?)?.pt).filter_map(|p| world.points.get(p as usize).copied()));
		way.push(b);
		if way.iter().any(|p| p.c != a.c || !p.wx.is_finite() || !p.wy.is_finite()) {
			k += 1;
			continue;
		}
		let off = |g: Pt| way.windows(2).map(|w| hub::seg_yd(g, w[0], w[1]).0).fold(f64::INFINITY, f64::min);
		let (x0, x1) = way.iter().fold((f64::INFINITY, f64::NEG_INFINITY), |(lo, hi), p| (lo.min(p.wx), hi.max(p.wx)));
		let (y0, y1) = way.iter().fold((f64::INFINITY, f64::NEG_INFINITY), |(lo, hi), p| (lo.min(p.wy), hi.max(p.wy)));
		let mut near: Vec<(usize, u32, Pt, f64)> = Vec::new();
		for gx in ((x0 - PASS_YD) / CELL).floor() as i64..=((x1 + PASS_YD) / CELL).floor() as i64 {
			for gy in ((y0 - PASS_YD) / CELL).floor() as i64..=((y1 + PASS_YD) / CELL).floor() as i64 {
				for &(q, g) in cells.get(&(a.c, gx, gy)).into_iter().flatten() {
					let Some(&ai) = accept_at.get(&q) else { continue };
					let d = off(g);
					if ai > k && d <= PASS_YD && !pulled.contains(&q) && !accepted.contains(&q) {
						near.push((ai, q, g, d));
					}
				}
			}
		}
		near.sort_unstable_by_key(|x| (x.0, x.1));
		let mut cands: Vec<Cand> = Vec::new();
		for &(ai, q, g, d) in &near {
			// A later visit: the route leaves the giver, or travels, before its own accept.
			if !((k..=ai).any(|m| travels(&o[m])) || (k..ai).any(|m| !o[m].extra && cx.pt(&o[m]).is_some_and(|p| hub::yd(p, g) > LATER_YD))) {
				continue;
			}
			if pins.exempt.contains(&q) {
				continue;
			}
			let Some(dq) = data.quests.get(&q) else { continue };
			let item_start = dq.start.as_ref().is_some_and(|s| s.npc.is_empty() && s.object.is_empty());
			if item_start || dq.repeatable() || dq.direct() || dq.parent.is_some() || dq.classes.is_some_and(|c| c != 0.0) || dq.required_items.as_ref().is_some_and(|v| !v.is_empty()) {
				continue;
			}
			let w = &world.quests[cx.wq[&q]];
			if w.escort || w.elite || w.limit.is_some_and(|l| l > 0.0) || w.source_dur.is_some_and(|s| s > 0.0) {
				continue;
			}
			if !hub::level_ok(data, &o[ai], q, lvl) || !hub::pre_groups(world, &cx.wq, data, q).iter().all(|grp| grp.iter().any(|p| handed.contains(p))) {
				continue;
			}
			let evs = &events_of[&q];
			if evs.iter().any(|&m| m < ai || o[m].extra || !matches!(o[m].t, OrderT::Accept | OrderT::Task | OrderT::Turnin)) || evs.iter().filter(|&&m| o[m].t == OrderT::Accept).count() != 1 {
				continue;
			}
			let tasks: Vec<usize> = evs.iter().copied().filter(|&m| o[m].t == OrderT::Task).collect();
			// Its work within the visit's reach, at a level that fits there.
			if !tasks.iter().all(|&m| cx.pt(&o[m]).is_some_and(|p| hub::yd(p, g) <= REACH_YD) && cx.need(q, o[m].task, cx.pt(&o[m])).is_none_or(|n| n.fits(lvl))) {
				continue;
			}
			let hand = evs.iter().copied().find(|&m| o[m].t == OrderT::Turnin).filter(|&m| cx.pt(&o[m]).is_some_and(|p| hub::yd(p, g) <= REACH_YD));
			if tasks.is_empty() && hand.is_none() {
				continue;
			}
			let moving: Vec<usize> = std::iter::once(ai).chain(tasks.iter().copied()).chain(hand).collect();
			// The guides' cut and the shared route's join; a bought item stays with its stop.
			let same_part = |e: &Order| own(e) == own(&o[k]) && (hub::file(e) == hub::file(&o[k]) || (!hub::start_zone(e) && !hub::start_zone(&o[k])));
			if !moving.iter().all(|&m| same_part(&o[m])) || moving.iter().any(|&m| o[m].items().iter().any(|it| it.t == ItemT::Buy)) {
				continue;
			}
			if (kp + 1..ai).any(|m| o[m].q.is_some_and(|x| x != q && (excl(q, x) || excl(x, q)))) {
				continue;
			}
			// The quest log: open on the visit only, or from the walk to its own accept.
			let full = if hand.is_some() { open[kp + 1] + 1 > room } else { (kp + 1..ai).any(|m| open[m] + 1 > room) };
			if full {
				continue;
			}
			// The records and the class steps.
			let southward = |m: usize| pins.southward.iter().any(|&(map, until)| cx.pt(&o[m]).is_some_and(|p| p.map == map) && !(0..=kp).any(|j| ev(&o[j]) == Some(until)));
			let jumped =
				moving.iter().find_map(|&m| (kp + 1..m).find(|&j| !moving.contains(&j) && matches!((ev(&o[j]), ev(&o[m])), (Some(x), Some(y)) if pins.pairs.contains(&(x, y)))).map(|j| (j, m)));
			let why = if moving.iter().any(|&m| pinned(&o[m])) {
				Some("a class step waits for its line".to_string())
			} else if let Some(&m) = moving.iter().find(|&&m| ev(&o[m]).is_some_and(|e| pins.stay.contains(&e))) {
				Some(format!("route fixes keep {} between its neighbours", desc(data, &o[m])))
			} else if let Some(&m) = moving.iter().find(|&&m| southward(m)) {
				Some(format!("route fixes keep the walk south on its map until a later step: {}", desc(data, &o[m])))
			} else {
				jumped.map(|(j, m)| format!("route fixes put {} before {}", desc(data, &o[j]), desc(data, &o[m])))
			};
			if let Some(why) = why {
				if told.insert(q) {
					log.push(format!("pass-by: {} passed {d:.0} yd off after {} at level {lvl:.1}: left where the route takes it ({why})", name(data, q), desc(data, &o[kp])));
				}
				continue;
			}
			cands.push(Cand { q, off: d, accept: ai, tasks, hand, was: o[ai].lvl });
		}
		// Taken together: a `together` record keeps both its steps or neither, and the new order keeps
		// every pair among them.
		loop {
			let block = block_of(&cands);
			let moves = |e: &PairEv| block.iter().any(|&m| ev(&o[m]) == Some(*e));
			let in_order = |e: &PairEv| o.iter().any(|x| ev(x) == Some(*e));
			let split = pins.together.iter().find(|(x, y)| moves(x) != moves(y) && in_order(if moves(x) { y } else { x })).map(|(x, y)| {
				let q = if moves(x) { x.1 } else { y.1 };
				(q, format!("route fixes keep {} together with {}", pin_desc(data, x), pin_desc(data, y)))
			});
			let crossed = || {
				for (i, &m) in block.iter().enumerate() {
					for &j in &block[i + 1..] {
						if let (Some(x), Some(y)) = (ev(&o[j]), ev(&o[m])) {
							if pins.pairs.contains(&(x, y)) {
								let later = cands.iter().filter(|c| c.q == x.1 || c.q == y.1).max_by_key(|c| c.accept).map(|c| c.q)?;
								return Some((later, format!("route fixes put {} before {}", desc(data, &o[j]), desc(data, &o[m]))));
							}
						}
					}
				}
				None
			};
			let Some((q, why)) = split.or_else(crossed) else { break };
			if told.insert(q) {
				let c = cands.iter().find(|c| c.q == q).map_or(0.0, |c| c.off);
				log.push(format!("pass-by: {} passed {c:.0} yd off after {} at level {lvl:.1}: left where the route takes it ({why})", name(data, q), desc(data, &o[kp])));
			}
			cands.retain(|c| c.q != q);
		}
		if cands.is_empty() {
			k += 1;
			continue;
		}
		// Out of the later visit (its travel stays there, with the event after it) and onto the walk.
		let block = block_of(&cands);
		let mut idx = block.clone();
		idx.sort_unstable();
		let mut taken: FxHashMap<usize, Order> = FxHashMap::default();
		for &m in idx.iter().rev() {
			taken.insert(m, hub::take_out(&mut o, m));
		}
		let ins: Vec<Order> = block.iter().filter_map(|m| taken.remove(m)).map(|e| Order { lvl: Some(lvl), items: None, ..e }).collect();
		o.splice(kp + 1..kp + 1, ins);
		for c in &cands {
			pulled.insert(c.q);
			let with = match (c.tasks.is_empty(), c.hand.is_some()) {
				(false, true) => ", its work and hand-in with it",
				(false, false) => ", its work with it",
				(true, true) => ", its hand-in with it",
				(true, false) => "",
			};
			// (A walk from the giver's own spot, a hand-in there: at the giver.)
			let at = if c.off <= AT_GIVER_YD { "at its giver".to_string() } else { format!("on the walk past its giver ({:.0} yd off)", c.off) };
			log.push(format!(
				"pass-by: {} taken {at} after {} at level {lvl:.1}{with}; the route took it at {}",
				name(data, c.q),
				desc(data, &o[kp]),
				c.was.map_or_else(|| "-".to_string(), |l| format!("{l:.1}"))
			));
		}
		open = open_counts(&o);
		(accept_at, events_of) = index(&o);
		// (The walk on to the pulled events: a hand-in there stands the player at the next part's giver.)
		k = kp + 1;
	}
	Pulled { order: o, log }
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::input::World;
	use forge_core::frames::MapFrames;
	use serde_json::json;

	/// The Dry Hills in small (#1959): the hub at (-800, 0), the harpies (0, 0), the raptors (0, 300),
	/// Vrang (150, 150) 150 yd off the walk between them, his lions (250, 250). The route walks to the
	/// harpies and the raptors at 17, back to the hub, then to Vrang at 19 (`serena`: Serena's lair
	/// worked on that third trip, right before the lions).
	fn dry_hills(serena: bool) -> (World, Data, MapFrames, Vec<Order>) {
		let world: World = serde_json::from_value(json!({
			"points": [[1, 1, -800, 0, 1411], [1, 1, 0, 0, 1411], [1, 1, 0, 300, 1411], [1, 1, 150, 150, 1411], [1, 1, 250, 250, 1411]],
			"zones": { "1411": "Durotar" },
			"quests": [
				{ "id": 1, "giver": 3, "ender": 3, "objs": [{ "oi": 0, "type": "kill", "id": 30, "task": 0 }], "tasks": [{ "work": [["kill", 15, 6, 0, 0, 30]] }] },
				{ "id": 2, "giver": 0, "ender": 0 }, { "id": 3, "giver": 0, "ender": 0 }, { "id": 876, "giver": 0, "ender": 0 }
			]
		}))
		.unwrap();
		let pts: Vec<Value> = (0..5).map(|i| json!([62.5 + 0.5 * ((i % 3) as f64 - 1.0), 37.5 + 0.5 * ((i / 3) as f64 - 1.0)])).collect();
		let data = Data {
			quests: serde_json::from_value(json!({
				"1": { "title": "Bruised Pride and Lion Hides", "level": 18, "minLevel": 14 }, "2": { "title": "Harpy Lieutenants", "level": 17 },
				"3": { "title": "Raptor Horns", "level": 17 }, "876": { "title": "Serena Bloodfeather", "level": 20 }
			}))
			.unwrap(),
			npcs: serde_json::from_value(json!({ "30": { "name": "Savannah Patriarch", "level": 15, "levelMax": 16, "spawns": { "1411": { "f": "e", "pts": pts } } } })).unwrap(),
			..Data::default()
		};
		let frames = MapFrames::from_json(br#"{ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }"#).unwrap();
		let mut order = vec![
			json!({ "t": "accept", "q": 2, "pt": 0, "lvl": 17.0 }),
			json!({ "t": "accept", "q": 3, "pt": 0, "lvl": 17.0 }),
			json!({ "t": "task", "q": 2, "task": 0, "pt": 1, "lvl": 17.2 }),
			json!({ "t": "task", "q": 3, "task": 0, "pt": 2, "lvl": 17.6 }),
			json!({ "t": "turnin", "q": 2, "pt": 0, "lvl": 18.0 }),
			json!({ "t": "turnin", "q": 3, "pt": 0, "lvl": 18.1 }),
			json!({ "t": "accept", "q": 1, "pt": 3, "lvl": 19.0 }),
			json!({ "t": "task", "q": 1, "task": 0, "pt": 4, "lvl": 19.2 }),
			json!({ "t": "turnin", "q": 1, "pt": 3, "lvl": 19.6 }),
		];
		if serena {
			order.insert(7, json!({ "t": "task", "q": 876, "task": 0, "pt": 4, "lvl": 19.1 }));
		}
		(world, data, frames, serde_json::from_value(Value::Array(order)).unwrap())
	}

	fn seq(o: &[Order]) -> Vec<(OrderT, u32)> {
		o.iter().filter_map(ev).collect()
	}

	#[test]
	fn the_route_fixes_records_read_as_pins() {
		let doc = json!({
			"deliberate": {
				"pairs": [{ "a": ["turnin", 3], "b": ["accept", 1] }],
				"together": [{ "a": ["task", 876], "b": ["task", 1, 0] }, { "a": ["task", 7], "b": ["task", 8], "faction": "Alliance" }],
				"stay": [{ "s": ["turnin", 9] }],
				"southward": [{ "map": 1436, "until": ["turnin", 109], "tolYd": 80 }],
				"optional": [{ "q": 338 }],
				"group": [{ "q": 98403, "size": 2 }]
			},
			"overrides": { "include": [{ "q": 821, "after": ["turnin", 819] }], "revert": [{ "s": ["accept", 2161] }], "pairs": [] }
		});
		let p = Pins::of_doc(&doc, Some("Horde"));
		assert!(p.pairs.contains(&((OrderT::Turnin, 3), (OrderT::Accept, 1))));
		assert!(p.pairs.contains(&((OrderT::Turnin, 819), (OrderT::Accept, 821))) && p.pairs.contains(&((OrderT::Turnin, 819), (OrderT::Turnin, 821))));
		assert_eq!(p.together, vec![((OrderT::Task, 876), (OrderT::Task, 1))]);
		assert!(p.stay.contains(&(OrderT::Turnin, 9)) && p.stay.contains(&(OrderT::Accept, 2161)));
		assert_eq!(p.southward, vec![(1436, (OrderT::Turnin, 109))]);
		assert!(p.exempt.contains(&338) && p.exempt.contains(&98403));
	}

	#[test]
	fn a_route_fix_keeps_the_quest_where_the_route_takes_it() {
		// Today's Barrens records keep Vrang's hides with Serena on the third trip (`together` task 876
		// then task 95494): the walk past him at 17.6 leaves them there, and says which record held.
		let (world, data, frames, order) = dry_hills(true);
		let cx = level_fit::Ctx::new(&world, &data, &frames);
		let free = pull(order.clone(), &cx, &Pins::default(), &|_: &Order| false, None);
		assert_eq!(seq(&free.order)[3], (OrderT::Accept, 1), "{:#?}", free.log);
		let together = Pins { together: vec![((OrderT::Task, 876), (OrderT::Task, 1))], ..Pins::default() };
		let held = pull(order.clone(), &cx, &together, &|_: &Order| false, None);
		assert_eq!(seq(&held.order), seq(&order));
		assert_eq!(
			held.log,
			vec!["pass-by: Bruised Pride and Lion Hides (1) passed 150 yd off after task harpy lieutenants (2) at level 17.6: left where the route takes it (route fixes keep task serena bloodfeather (876) together with task bruised pride and lion hides (1))"]
		);
		// A pair whose first event comes between: never ahead of it.
		let pair = Pins { pairs: FxHashSet::from_iter([((OrderT::Turnin, 3), (OrderT::Accept, 1))]), ..Pins::default() };
		let held = pull(order.clone(), &cx, &pair, &|_: &Order| false, None);
		assert_eq!(seq(&held.order), seq(&order));
		assert!(held.log[0].ends_with("(route fixes put turnin raptor horns (3) before accept bruised pride and lion hides (1))"), "{:#?}", held.log);
		// A line a class step waits for stays too.
		let held = pull(order.clone(), &cx, &Pins::default(), &|o: &Order| o.t == OrderT::Accept && o.q == Some(1), None);
		assert_eq!(seq(&held.order), seq(&order));
		assert!(held.log[0].ends_with("(a class step waits for its line)"), "{:#?}", held.log);
	}
}
