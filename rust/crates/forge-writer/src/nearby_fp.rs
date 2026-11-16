//! Nearby flight paths (docs/forge/writer.md, "Nearby flight paths"): a stop within [`NEAR_YD`] of a
//! flight master whose path the character has not learnt learns it, by a walk to the master and its
//! `getfp` on the walk into the stop or out of it (whichever is shorter), when the route's later walks
//! gain more by flying from or to that master than the walk there costs, by [`NET_S`] at least. The
//! Barrens' first guide stops at Ziz Fizziks' hut, 685 yd from Sun Rock Retreat's flight master; the
//! second Barrens guide walks the Webwinder Path up to Sun Rock and back down instead of flying there.
//!
//! Later is this guide and the next ones, up to [`HORIZON_LVL`] levels on, until the route learns the
//! path itself; the route's own later `getfp` of it then goes. A later run of walks (between two
//! hearths, flights, rides or deathskips) gains:
//! - **flying in**: the walk from where its travel left the player to a stop, through stops it walks
//!   past again on the way out (or none), against a flight to this master (from where the run's flight
//!   took off, else from the known flight master nearest where its travel left the player) and the
//!   walk on from it;
//! - **flying out**: the walk from a stop to the flight master the run flies from, through stops it
//!   walked past on the way in (or none), against the walk to this master and the flight from it.
//!
//! The estimates are the writer's (apply.rs): walks at 7 yd/s on the walk store's yards (else the
//! straight line), 1.6 times faster from the riding training on (forge-sim's mounted speed), flights at
//! 25 yd/s straight plus a minute at the masters. Not on a walk an escort or a timed quest is running
//! on. Each flight path learnt logs one line (`nearby fp: ...`), and so does one not learnt whose later
//! flights would gain a minute or more.

use crate::apply::{FLY_S, FLY_YPS, WALK_YPS};
use crate::input::{Data, Item, ItemT, Leg, Order, OrderT, Pt, World};
use crate::pass_by::desc;
use forge_core::jsnum::js_hypot;
use rustc_hash::{FxHashMap, FxHashSet};

/// A stop this near a flight master (straight yards) may learn its path: Ziz Fizziks' hut, 685 yd from
/// Sun Rock Retreat's master. The walk there and back stays under four minutes.
pub const NEAR_YD: f64 = 800.0;
/// Seconds the later flights must gain beyond the walk to the master.
pub const NET_S: f64 = 120.0;
/// Levels on from the stop within which the route's walks count (the Barrens' second guide is played at
/// 24-26, about four levels after Ziz's hut).
pub const HORIZON_LVL: f64 = 10.0;
/// A stop the run's walk passes this near is walked past (level_fit.rs: a visit to the same place).
const PASSED_YD: f64 = crate::level_fit::VISIT_YD;
/// Mounted walking speed over walking (forge-sim's `mountMul`).
const MOUNT_MUL: f64 = 1.6;
/// A flight path not learnt is logged when its later flights would gain this many seconds.
const TOLD_S: f64 = 60.0;

/// The writer's travel estimates on the route's world.
struct Est<'a> {
	world: &'a World,
	walks: Option<&'a dyn forge_sim::walks::Walks>,
}

impl Est<'_> {
	fn p(&self, pt: Option<u32>) -> Option<Pt> {
		self.world.points.get(pt? as usize).copied().filter(|p| p.wx.is_finite() && p.wy.is_finite())
	}

	/// Walking yards between two world points: the walk store's, else the straight line (one continent).
	fn walk(&self, a: Option<u32>, b: Option<u32>) -> f64 {
		let (Some(pa), Some(pb)) = (self.p(a), self.p(b)) else { return f64::INFINITY };
		if pa.c != pb.c {
			return f64::INFINITY;
		}
		if a == b {
			return 0.0;
		}
		self.walks.and_then(|w| w.yards(a.unwrap(), b.unwrap())).unwrap_or_else(|| js_hypot(pa.wx - pb.wx, pa.wy - pb.wy))
	}

	fn node_pt(&self, n: usize) -> Option<u32> {
		self.world.nodes.get(n)?.pt
	}

	/// Seconds of a flight between two flight masters.
	fn fly(&self, a: usize, b: usize) -> f64 {
		let (Some(pa), Some(pb)) = (self.p(self.node_pt(a)), self.p(self.node_pt(b))) else { return f64::INFINITY };
		if pa.c != pb.c {
			return f64::INFINITY;
		}
		js_hypot(pa.wx - pb.wx, pa.wy - pb.wy) / FLY_YPS + FLY_S
	}
}

/// Travel that ends a run of walks: a hearth, a deathskip, a flight or a ride (a network item that only
/// walks, by a waypoint, does not).
fn travels(o: &Order) -> bool {
	o.items().iter().any(|it| match it.t {
		ItemT::Hearth | ItemT::Deathskip => true,
		ItemT::Network => it.legs.as_ref().is_none_or(|ls| ls.iter().any(|l| matches!(l.k.as_deref(), Some("fly" | "ride")))),
		_ => false,
	})
}

/// Reached by a plain walk: no hearth, deathskip or network item (the walk to the master goes there).
fn walked(o: &Order) -> bool {
	!o.items().iter().any(|it| matches!(it.t, ItemT::Hearth | ItemT::Deathskip | ItemT::Network))
}

/// Where an event's travel leaves the player, and the flight that took them there (its last flight's
/// masters) when it is a flight.
fn landing(est: &Est, o: &Order) -> (Option<u32>, Option<(usize, usize)>) {
	let (mut land, mut fly) = (None, None);
	for it in o.items() {
		match it.t {
			ItemT::Hearth => (land, fly) = (it.inn_pt, None),
			ItemT::Deathskip => (land, fly) = (it.pt, None),
			ItemT::Network => {
				for l in it.legs.iter().flatten() {
					match (l.k.as_deref(), l.from, l.to) {
						(Some("fly"), Some(a), Some(b)) => (land, fly) = (est.node_pt(b as usize), Some((a as usize, b as usize))),
						(Some("ride"), ..) => (land, fly) = (None, None),
						_ => {}
					}
				}
			}
			_ => {}
		}
	}
	(land, fly)
}

/// The flight an event's travel starts with (its first flight's masters), when the travel is a flight.
fn departure(o: &Order) -> Option<(usize, usize)> {
	let first = o.items().iter().find(|it| matches!(it.t, ItemT::Hearth | ItemT::Deathskip | ItemT::Network))?;
	let leg = first.legs.iter().flatten().find(|l| matches!(l.k.as_deref(), Some("fly" | "ride")))?;
	(first.t == ItemT::Network && leg.k.as_deref() == Some("fly")).then_some((leg.from? as usize, leg.to? as usize))
}

/// For each stop of a run (positions `s..=e` in the stops), the last later walk of the run that passes it
/// (the position the walk ends at; 0: none) and the first earlier one (usize::MAX: none), its own walks
/// in and out left aside.
fn passes(est: &Est, order: &[Order], stops: &[usize], (s, e): (usize, usize)) -> (Vec<usize>, Vec<usize>) {
	let p = |q: usize| est.p(order[stops[q]].pt);
	let near = |q: usize, j: usize| matches!((p(q), p(j - 1), p(j)), (Some(x), Some(a), Some(b)) if crate::hub::seg_yd(x, a, b).0 <= PASSED_YD);
	let last = (s..=e).map(|q| (q + 2..=e).rev().find(|&j| near(q, j)).unwrap_or(0)).collect();
	let first = (s..=e).map(|q| (s + 1..q).find(|&j| near(q, j)).unwrap_or(usize::MAX)).collect();
	(last, first)
}

/// The guide an event's line is in, as the log names it (`horde/04-the-barrens`).
fn guide_of(o: &Order) -> String {
	crate::hub::file(o).map_or_else(|| "the route".into(), |f| f.trim_start_matches("guides/").trim_start_matches("forever/").trim_end_matches(".guide").to_string())
}

/// A walk-only network item from `from` to `to` by the flight master `n`, and the master's `getfp`.
fn learn_items(n: usize, node_pt: Option<u32>, from: Option<u32>, to: Option<u32>) -> [Item; 2] {
	let leg = |to: Option<u32>, node: Option<usize>| Leg { k: Some("walk".into()), from: None, to, ride: None, node };
	let item = |t: ItemT| Item { t, inn: None, pt: None, inn_pt: None, used: None, returns: None, from: None, to: None, node: None, legs: None, gy: None, spot: None, npc: None, q: None };
	[Item { from, to, legs: Some(vec![leg(node_pt, Some(n)), leg(to, None)]), ..item(ItemT::Network) }, Item { node: Some(n), ..item(ItemT::Getfp) }]
}

/// Where the walk to the master goes: on the walk into stop `p` or out of it (positions in the stops).
#[derive(Clone, Copy)]
enum Way {
	Into(usize),
	OutOf(usize),
}

/// The rule on a route's order (module docs). -> the order, a log line per decision.
pub(crate) fn add(mut order: Vec<Order>, world: &World, data: &Data, walks: Option<&dyn forge_sim::walks::Walks>) -> (Vec<Order>, Vec<String>) {
	let est = Est { world, walks };
	let mut log = Vec::new();
	// The route's own stops in play order (other starts' stops passed over).
	let stops: Vec<usize> = (0..order.len()).filter(|&i| !order[i].extra && est.p(order[i].pt).is_some()).collect();
	if stops.len() < 2 {
		return (order, log);
	}
	// When the route knows each flight path: its first `getfp` or flight.
	let mut known_at: Vec<usize> = vec![usize::MAX; world.nodes.len()];
	for (i, o) in order.iter().enumerate() {
		for it in o.items() {
			let fly_ends = it.legs.iter().flatten().filter(|l| l.k.as_deref() == Some("fly")).flat_map(|l| [l.from, l.to]);
			let nodes: Vec<usize> = match it.t {
				ItemT::Getfp => it.node.into_iter().collect(),
				ItemT::Network => fly_ends.flatten().map(|n| n as usize).collect(),
				_ => Vec::new(),
			};
			for n in nodes {
				if let Some(k) = known_at.get_mut(n) {
					*k = (*k).min(i);
				}
			}
		}
	}
	let rode = order.iter().position(|o| o.t == OrderT::Ride);
	let speed = |i: usize| WALK_YPS * if rode.is_some_and(|r| i > r) { MOUNT_MUL } else { 1.0 };
	// Runs of walks, as positions in the stops: cut where a stop's travel takes the player off the walk.
	let mut runs: Vec<(usize, usize)> = Vec::new();
	let mut s0 = 0;
	for p in 1..stops.len() {
		if travels(&order[stops[p]]) {
			runs.push((s0, p - 1));
			s0 = p;
		}
	}
	runs.push((s0, stops.len() - 1));
	let mut run_passes: Vec<Option<(Vec<usize>, Vec<usize>)>> = vec![None; runs.len()];
	// An escort or a timed quest running after each stop (no walk to a master while one runs).
	let wq: FxHashMap<u32, usize> = world.quests.iter().enumerate().map(|(i, q)| (q.id, i)).collect();
	let held = |q: u32| wq.get(&q).is_some_and(|&i| world.quests[i].escort || world.quests[i].limit.is_some_and(|l| l > 0.0) || world.quests[i].source_dur.is_some_and(|s| s > 0.0));
	let mut running: FxHashSet<u32> = FxHashSet::default();
	let busy: Vec<bool> = stops
		.iter()
		.map(|&i| {
			if let Some(q) = order[i].q.filter(|&q| held(q)) {
				match order[i].t {
					OrderT::Accept => {
						running.insert(q);
					}
					OrderT::Turnin => {
						running.remove(&q);
					}
					_ => {}
				}
			}
			!running.is_empty()
		})
		.collect();
	for n in 0..world.nodes.len() {
		if world.nodes[n].kind != "fp" {
			continue;
		}
		let np = world.nodes[n].pt;
		let Some(npt) = est.p(np) else { continue };
		let g = known_at[n];
		// The stops within reach of the master before the route knows its path.
		let cands: Vec<usize> = (0..stops.len())
			.filter(|&p| {
				let i = stops[p];
				i < g && order[i].lvl.is_some() && est.p(order[i].pt).is_some_and(|q| q.c == npt.c && js_hypot(q.wx - npt.wx, q.wy - npt.wy) <= NEAR_YD)
			})
			.collect();
		let (Some(&first), Some(&last)) = (cands.first(), cands.last()) else { continue };
		let top = order[stops[last]].lvl.unwrap_or(0.0) + HORIZON_LVL;
		// What each later run gains: (its first event, its level, seconds).
		let mut gains: Vec<(usize, f64, f64)> = Vec::new();
		for (ri, &(s, e)) in runs.iter().enumerate() {
			let si = stops[s];
			let Some(ls) = order[si].lvl.filter(|&l| l <= top) else { continue };
			if si <= stops[first] || si > g || est.p(order[si].pt).is_none_or(|q| q.c != npt.c) {
				continue;
			}
			let pass = run_passes[ri].get_or_insert_with(|| passes(&est, &order, &stops, (s, e)));
			let sp = speed(si);
			let mut best = 0.0f64;
			// Flying in.
			if travels(&order[si]) {
				let (land, fly) = landing(&est, &order[si]);
				let land = land.or(order[si].pt);
				let base = match fly {
					Some((a, b)) if a != n && b != n => Some((est.fly(a, b), est.fly(a, n))),
					Some(_) => None,
					None => (0..world.nodes.len())
						.filter(|&f| f != n && world.nodes[f].kind == "fp" && known_at[f] < si)
						.map(|f| est.walk(land, est.node_pt(f)) / sp + est.fly(f, n))
						.filter(|x| x.is_finite())
						.min_by(f64::total_cmp)
						.map(|x| (0.0, x)),
				};
				if let Some((route_fly, alt_fly)) = base {
					let mut walked = est.walk(land, order[si].pt);
					let mut need = usize::MAX;
					for q in s..=e {
						let i = stops[q];
						if i > g {
							break;
						}
						if q > s {
							walked += est.walk(order[stops[q - 1]].pt, order[i].pt);
							need = need.min(pass.0[q - 1 - s]);
							if need < q + 1 {
								break;
							}
						}
						let gain = route_fly + walked / sp - alt_fly - est.walk(np, order[i].pt) / sp;
						if gain.is_finite() {
							best = best.max(gain);
						}
					}
				}
			}
			// Flying out.
			if let Some((a, b)) = stops.get(e + 1).filter(|&&nx| nx < g).and_then(|&nx| departure(&order[nx])).filter(|&(a, b)| a != n && b != n) {
				let tail = est.walk(order[stops[e]].pt, est.node_pt(a)) / sp + est.fly(a, b);
				let alt_fly = est.fly(n, b);
				let (mut walked, mut need) = (0.0, 0usize);
				for q in (s..=e).rev() {
					if q < e {
						walked += est.walk(order[stops[q]].pt, order[stops[q + 1]].pt);
						need = need.max(pass.1[q + 1 - s]);
						if need > q {
							break;
						}
					}
					let gain = walked / sp + tail - est.walk(order[stops[q]].pt, np) / sp - alt_fly;
					if gain.is_finite() {
						best = best.max(gain);
					}
				}
			}
			if best > 0.0 {
				gains.push((si, ls, best));
			}
		}
		// The stop that learns it: the most gained beyond the walk there (the earliest of equals).
		let mut pick: Option<(usize, Way, f64, f64)> = None;
		for &p in &cands {
			let i = stops[p];
			let li = order[i].lvl.unwrap_or(0.0);
			let total: f64 = gains.iter().filter(|x| x.0 > i && x.1 <= li + HORIZON_LVL).map(|x| x.2).sum();
			if total <= 0.0 {
				continue;
			}
			let sp = speed(i);
			let detour = |a: Option<u32>, b: Option<u32>| (est.walk(a, np) + est.walk(np, b) - est.walk(a, b)) / sp;
			let into = (p > 0 && walked(&order[i]) && !busy[p - 1]).then(|| (detour(order[stops[p - 1]].pt, order[i].pt), Way::Into(p)));
			let out = (p + 1 < stops.len() && walked(&order[stops[p + 1]]) && !busy[p]).then(|| (detour(order[i].pt, order[stops[p + 1]].pt), Way::OutOf(p)));
			let Some((extra, way)) = [into, out].into_iter().flatten().filter(|x| x.0.is_finite()).min_by(|x, y| x.0.total_cmp(&y.0)) else { continue };
			if pick.is_none_or(|b| total - extra > b.2 - b.3) {
				pick = Some((p, way, total, extra));
			}
		}
		let Some((p, way, total, extra)) = pick else { continue };
		let i = stops[p];
		let off = est.p(order[i].pt).map_or(0.0, |q| js_hypot(q.wx - npt.wx, q.wy - npt.wy));
		let name = &world.nodes[n].name;
		let lvl = order[i].lvl.unwrap_or(0.0);
		if total - extra < NET_S {
			if total >= TOLD_S {
				log.push(format!(
					"nearby fp: {name} not learnt at {} at level {lvl:.1} ({off:.0} yd off): its later flights gain {:.1} min against {:.1} min more walking",
					desc(data, &order[i]),
					total / 60.0,
					extra / 60.0
				));
			}
			continue;
		}
		let (t, from, side) = match way {
			Way::Into(p) => (i, order[stops[p - 1]].pt, "into"),
			Way::OutOf(p) => (stops[p + 1], order[i].pt, "out of"),
		};
		let mut items: Vec<Item> = learn_items(n, np, from, order[t].pt).into();
		items.extend(order[t].items.take().unwrap_or_default());
		order[t].items = Some(items);
		// (The route's own later flight path there goes: it is known from here.)
		for o in order[t + 1..].iter_mut() {
			if let Some(v) = o.items.as_mut() {
				v.retain(|it| !(it.t == ItemT::Getfp && it.node == Some(n)));
				if v.is_empty() {
					o.items = None;
				}
			}
		}
		known_at[n] = t;
		let mut top3: Vec<&(usize, f64, f64)> = gains.iter().filter(|x| x.0 > i && x.1 <= lvl + HORIZON_LVL).collect();
		top3.sort_by(|x, y| y.2.total_cmp(&x.2).then(x.0.cmp(&y.0)));
		let at: Vec<String> = top3.iter().take(3).map(|x| format!("{} at {:.1}, {:.1} min", guide_of(&order[x.0]), x.1, x.2 / 60.0)).collect();
		log.push(format!(
			"nearby fp: getfp {name} on the walk {side} {} at level {lvl:.1} ({off:.0} yd off, {:.1} min more walking): flying from or to it gains about {:.1} min later ({})",
			desc(data, &order[i]),
			extra / 60.0,
			total / 60.0,
			at.join("; ")
		));
	}
	(order, log)
}
