//! Port of tools/lib/dsl/timed.js.
//! Timed quest items: an item that vanishes a while after the player gets it must reach the goal that
//! uses or turns it in before it does. The time is estimated with the simulator's model at its priors
//! (params.rs) over the guide's own goals and places; see the JS source for the full description.
//!
//! `check_timed_items(g, data, diag, level_at, characters, meets)`: `level_at(goal)` -> the character's
//! level there (route XP, validate.rs; None when unknown); `characters(step, goal)` -> the goal's
//! character keys; `meets(a, b)`.

use std::cell::RefCell;
use std::rc::Rc;

use rustc_hash::FxHashMap;

use crate::data::Data;
use crate::diag::Diagnostics;
use crate::js::{hypot, math_round, num_str, str_to_num, V};
use crate::params as P;
use crate::validate::{jmax, jmin, key, CharSet, Key};

const DEFAULT_SPACING: f64 = 30.0; // yards between mobs where the goal has no spawn areas (sim world grind default)
const MIN_SPACING: f64 = 12.0;
const TALK: &[&str] = &["accept", "turnin", "talk", "getfp", "sethome", "train", "vendor", "buy", "learn"];

fn side_of(faction: &V) -> i32 {
	match faction.as_str() {
		Some("Alliance") => 1,
		Some("Horde") => 2,
		_ => 0,
	}
}

/// A world position { c, wx, wy }.
#[derive(Clone)]
pub struct Pos {
	pub c: V,
	pub wx: f64,
	pub wy: f64,
}

/// World position of a compiled point (frame "e" Era, else live, read with the Era bounds when the live
/// ones are unknown), or None.
fn place(data: &Data, map: &V, x: &V, y: &V, f: &V) -> Option<Pos> {
	if map.is_undef() || x.is_undef() || y.is_undef() {
		return None;
	}
	let era = data.map_frames.get("era");
	let live = data.map_frames.get("forever");
	let mk = map.to_js_string();
	let b = if f.as_str() == Some("e") {
		era.get(&mk)
	} else {
		let l = live.get(&mk);
		if l.truthy() {
			l
		} else {
			era.get(&mk)
		}
	};
	if !b.truthy() {
		return None;
	}
	let (top, bottom, left, right) = (b.get("top").num(), b.get("bottom").num(), b.get("left").num(), b.get("right").num());
	Some(Pos { c: b.get("c"), wx: top + ((bottom - top) * y.num()) / 100.0, wy: left + ((right - left) * x.num()) / 100.0 })
}

fn detour(c: &V) -> f64 {
	if c.strict_eq(&V::Num(0.0)) {
		P::DETOUR0
	} else if c.strict_eq(&V::Num(1.0)) {
		P::DETOUR1
	} else {
		(P::DETOUR0 + P::DETOUR1) / 2.0
	}
}

fn yards(a: Option<&Pos>, b: Option<&Pos>) -> f64 {
	match (a, b) {
		(Some(a), Some(b)) if a.c.strict_eq(&b.c) => hypot(a.wx - b.wx, a.wy - b.wy),
		_ => f64::INFINITY,
	}
}

fn walk_sec(a: Option<&Pos>, b: Option<&Pos>, mounted: bool) -> f64 {
	match (a, b) {
		(Some(pa), Some(pb)) if pa.c.strict_eq(&pb.c) => (yards(a, b) * detour(&pa.c)) / (P::RUN_SPEED * if mounted { P::MOUNT_MUL } else { 1.0 }),
		_ => 0.0,
	}
}

fn lower(s: &V) -> String {
	let s = if s.truthy() { s.to_js_string() } else { String::new() };
	s.trim().to_lowercase()
}

/// Seconds per kill of a mob of level M (elite or not) at character level L.
fn kill_sec(l: f64, m: f64, elite: bool) -> f64 {
	let base = P::KILL_SEC1 + ((P::KILL_SEC60 - P::KILL_SEC1) * (jmax(1.0, jmin(60.0, l)) - 1.0)) / 59.0;
	let d = m - l;
	let f = if d >= 0.0 { 1.0 + P::KILL_UP * d } else { jmax(0.5, 1.0 + P::KILL_DOWN * d) };
	base * f * P::CLASS_FACTOR * if elite { P::ELITE_TIME } else { 1.0 }
}

/// A mob's level: the middle of its range (as the simulator's world takes it).
fn npc_level(npc: &V, fallback: f64) -> f64 {
	let lo = if npc.truthy() { crate::js::parse_int(&npc.get("level").to_js_string()) } else { f64::NAN };
	if !lo.is_finite() {
		return fallback;
	}
	let hi = crate::js::parse_int(&npc.get("levelMax").to_js_string());
	math_round((lo + if hi.is_finite() { hi } else { lo }) / 2.0)
}

/// Mean yards from one mob to the next in the goal's spawn areas (radius r, n spawns each).
fn spacing(goal: &V) -> f64 {
	let spots: Vec<V> = goal.get("spots").items().into_iter().filter(|s| s.get("r").num() > 0.0 && s.get("n").num() > 0.0).collect();
	if spots.is_empty() {
		return DEFAULT_SPACING;
	}
	let mut sum = 0.0;
	let mut n = 0.0;
	for s in &spots {
		let (sr, sn) = (s.get("r").num(), s.get("n").num());
		sum += sn * 0.5 * ((std::f64::consts::PI * sr * sr) / sn).sqrt();
		n += sn;
	}
	jmax(MIN_SPACING, sum / n)
}

fn is_elite_rank(rank: &V) -> bool {
	matches!(rank.as_num(), Some(r) if r == 1.0 || r == 2.0 || r == 3.0)
}

/// Seconds for one kill of npc at level L, the walk to it included.
fn per_kill(data: &Data, npc_id: &V, l: f64, goal: &V) -> f64 {
	let npc = data.npc(npc_id);
	kill_sec(l, npc_level(&npc, l), npc.truthy() && is_elite_rank(&npc.get("rank"))) + (spacing(goal) * P::SPACING) / P::RUN_SPEED
}

const NEAR: f64 = 300.0;

/// Seconds for one item of a `collect`: its quickest source among those spawning within NEAR yards of the
/// goal's place, else on its map, else anywhere. Without sources: a talk when a vendor sells it, else 0.
fn per_item(data: &Data, goal: &V, l: f64) -> f64 {
	let it = data.item(&goal.get("item"));
	if !it.truthy() {
		return 0.0;
	}
	let drops = it.get("drops");
	let at = place(data, &goal.get("map"), &goal.get("x"), &goal.get("y"), &goal.get("f"));
	let mut best: Option<(i32, f64)> = None;
	for kind in ["npc", "object"] {
		for (id, raw) in drops.get(kind).entries() {
			let chance = if raw.is_nullish() { 100.0 } else { jmin(100.0, raw.num()) };
			if !(chance > 0.0) {
				continue;
			}
			let idv = V::Num(str_to_num(&id));
			let e = if kind == "npc" { data.npc(&idv) } else { V::Null };
			if e.truthy() && e.get("rank").strict_eq(&V::Num(4.0)) {
				continue;
			}
			let spawns = data.spawns(kind, &idv);
			let gmap = goal.get("map");
			let on_map: Vec<&V> = spawns.iter().filter(|s| s.get("map").strict_eq(&gmap)).collect();
			let near = at.is_some()
				&& on_map
					.iter()
					.any(|s| s.get("pts").items().into_iter().chain(s.get("more").items()).any(|p| yards(at.as_ref(), place(data, &s.get("map"), &p.at(0), &p.at(1), &s.get("f")).as_ref()) <= NEAR));
			let tier = if near {
				0
			} else if !on_map.is_empty() {
				1
			} else {
				2
			};
			let sec = (100.0 / chance) * if kind == "npc" { (1.0 + P::EXTRA_KILL) * per_kill(data, &idv, l, goal) } else { P::INTERACT_SEC };
			if best.is_none_or(|(bt, bs)| tier < bt || (tier == bt && sec < bs)) {
				best = Some((tier, sec));
			}
		}
	}
	match best {
		None => {
			if !it.get("vendors").items().is_empty() {
				P::TALK_SEC
			} else {
				0.0
			}
		}
		Some((_, sec)) => sec,
	}
}

/// A flight: yards along the taxi path a second, and seconds per hop.
pub const FLIGHT_SPEED: f64 = 30.0;
pub const FLIGHT_STOP: f64 = 2.0;

fn to_int32(x: f64) -> i32 {
	if !x.is_finite() {
		0
	} else {
		(x.trunc() as i64) as i32
	}
}

/// Cheapest flight seconds from taxi node a to every node (Dijkstra over travel.json's legs; the faction's
/// nodes only). `from(a)` memoizes per start node.
pub struct Flights {
	pub nodes: Vec<V>,
	out: FxHashMap<Key, Vec<(V, f64)>>,
	memo: RefCell<FxHashMap<Key, Rc<FxHashMap<Key, f64>>>>,
}

impl Flights {
	pub fn from(&self, a: &V) -> Rc<FxHashMap<Key, f64>> {
		if let Some(d) = self.memo.borrow().get(&key(a)) {
			return d.clone();
		}
		let mut dist: FxHashMap<Key, f64> = FxHashMap::default();
		dist.insert(key(a), 0.0);
		let mut open = vec![a.clone()];
		while !open.is_empty() {
			open.sort_by(|x, y| {
				let (dx, dy) = (dist[&key(x)], dist[&key(y)]);
				(dy - dx).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal)
			});
			let n = open.pop().unwrap();
			if let Some(legs) = self.out.get(&key(&n)) {
				for (m, c) in legs {
					let d = dist[&key(&n)] + c;
					let km = key(m);
					if d < dist.get(&km).copied().unwrap_or(f64::INFINITY) {
						if !dist.contains_key(&km) {
							open.push(m.clone());
						}
						dist.insert(km, d);
					}
				}
			}
		}
		let dist = Rc::new(dist);
		self.memo.borrow_mut().insert(key(a), dist.clone());
		dist
	}
}

pub fn flights(data: &Data, side: i32) -> Flights {
	let taxi = data.travel.get("taxi");
	let nodes: Vec<V> = taxi.get("nodes").items().into_iter().filter(|n| side == 0 || to_int32(n.get("faction").num()) & side != 0).collect();
	let ids: rustc_hash::FxHashSet<Key> = nodes.iter().map(|n| key(&n.get("id"))).collect();
	let mut out: FxHashMap<Key, Vec<(V, f64)>> = FxHashMap::default();
	for l in taxi.get("legs").items() {
		if !ids.contains(&key(&l.get("from"))) || !ids.contains(&key(&l.get("to"))) {
			continue;
		}
		out.entry(key(&l.get("from"))).or_default().push((l.get("to"), l.get("yards").num() / FLIGHT_SPEED + FLIGHT_STOP));
	}
	Flights { nodes, out, memo: RefCell::new(FxHashMap::default()) }
}

fn node_pos(n: &V) -> Pos {
	Pos { c: n.get("c"), wx: n.get("wx").num(), wy: n.get("wy").num() }
}

/// A `fly` from pos: walk to the nearest flight master with a flight to the named town, fly, land there.
fn fly(net: &Flights, pos: Option<&Pos>, location: &V, mounted: bool) -> (f64, Option<Pos>) {
	let q = lower(location);
	let to: Vec<&V> = net.nodes.iter().filter(|n| lower(&n.get("short")) == q || lower(&n.get("name")) == q).collect();
	if to.is_empty() {
		return (0.0, None);
	}
	let mut best: Option<(f64, Pos)> = None;
	for dest in to {
		let at = node_pos(dest);
		let Some(p) = pos else {
			if best.is_none() {
				best = Some((0.0, at));
			}
			continue;
		};
		for n in &net.nodes {
			if !n.get("c").strict_eq(&p.c) {
				continue;
			}
			let Some(air) = net.from(&n.get("id")).get(&key(&dest.get("id"))).copied() else { continue };
			let np = node_pos(n);
			let sec = walk_sec(Some(p), Some(&np), mounted) + air + P::FLIGHT_OVERHEAD;
			if best.as_ref().is_none_or(|(bs, _)| sec < *bs) {
				best = Some((sec, at.clone()));
			}
		}
	}
	match best {
		Some((s, p)) => (s, Some(p)),
		None => (0.0, None),
	}
}

fn inn(data: &Data, location: &V) -> Option<Pos> {
	let q = lower(location);
	let hit = data.inns().items().into_iter().find(|i| lower(&i.get("location")) == q || i.get("names").items().iter().any(|n| lower(n) == q))?;
	Some(node_pos(&hit))
}

/// Seconds of a goal's own work at level L (travel apart).
fn work_sec(data: &Data, goal: &V, l: f64) -> f64 {
	let t = goal.get("t");
	let t = t.as_str().unwrap_or("");
	if TALK.contains(&t) {
		return P::TALK_SEC;
	}
	let c = goal.get("count").num();
	let count = if c > 0.0 { c } else { 1.0 };
	if t == "kill" && !goal.get("npc").is_undef() {
		return count * (1.0 + P::EXTRA_KILL) * per_kill(data, &goal.get("npc"), l, goal);
	}
	match t {
		"collect" => count * per_item(data, goal, l),
		"interact" => count * P::INTERACT_SEC,
		"use" => P::INTERACT_SEC,
		_ => 0.0,
	}
}

/// How many of item x the turn-in of quest q spends (0: none).
fn spends(q: &V, x: &V, collected: Option<f64>) -> f64 {
	if !q.truthy() {
		return 0.0;
	}
	if q.get("sourceItem").strict_eq(x) || q.get("requiredItems").items().iter().any(|r| r.strict_eq(x)) {
		return 1.0;
	}
	let Some(o) = q.get("objectives").items().into_iter().find(|o| o.get("type").as_str() == Some("item") && o.get("id").strict_eq(x)) else {
		return 0.0;
	};
	let c = o.get("count").num();
	if c > 0.0 {
		c
	} else if collected.is_some_and(|n| n > 0.0) {
		collected.unwrap()
	} else {
		1.0
	}
}

fn fmt(sec: f64) -> String {
	let s = math_round(sec);
	if s < 3600.0 {
		return format!("{}:{:0>2}", num_str((s / 60.0).floor()), num_str(s % 60.0));
	}
	format!("{} h {:0>2} min", num_str((s / 3600.0).floor()), num_str(((s % 3600.0) / 60.0).floor()))
}

fn lasts(sec: f64) -> String {
	if sec % 3600.0 == 0.0 {
		return if sec == 3600.0 { "an hour".into() } else { format!("{} hours", num_str(sec / 3600.0)) };
	}
	if sec % 60.0 == 0.0 {
		return if sec == 60.0 { "a minute".into() } else { format!("{} minutes", num_str(sec / 60.0)) };
	}
	format!("{} seconds", num_str(sec))
}

/// One stretch a guide carries a timed item.
pub struct Span {
	pub item: V,
	pub from: V,
	pub to: V,
	pub seconds: f64,
}

fn units(goal: &V) -> f64 {
	if goal.get("t").as_str() == Some("accept") {
		return 1.0;
	}
	let c = goal.get("count").num();
	if c > 0.0 {
		c
	} else {
		1.0
	}
}

/// Every stretch a guide carries a timed item (from: the goal that gets it; to: the last goal that spends
/// what it got; seconds: the estimate).
pub fn timed_spans(g: &V, data: &Data, level_at: &dyn Fn(&V) -> Option<f64>, characters: &dyn Fn(&V, &V) -> CharSet, meets: &dyn Fn(&CharSet, &CharSet) -> bool) -> Vec<Span> {
	let list: Vec<(V, V)> = g.get("steps").items().into_iter().flat_map(|step| step.get("goals").items().into_iter().map(move |goal| (step.clone(), goal))).collect();
	// The timed item a goal gets, if any.
	let gets = |goal: &V| -> Option<V> {
		let t = goal.get("t");
		let x = match t.as_str() {
			Some("accept") => {
				let q = data.quest(&goal.get("quest"));
				if q.truthy() {
					q.get("sourceItem")
				} else {
					q
				}
			}
			Some("collect") | Some("buy") => goal.get("item"),
			_ => V::Undef,
		};
		let it = if !x.is_nullish() { data.item(&x) } else { V::Null };
		if it.truthy() && it.get("duration").num() > 0.0 {
			Some(it)
		} else {
			None
		}
	};
	let mut spans = Vec::new();
	if !list.iter().any(|(_, goal)| gets(goal).is_some()) {
		return spans;
	}
	let side = side_of(&g.get("faction"));
	let mut net: Option<Flights> = None;
	let min_l = {
		let v = g.get("minLevel");
		if v.truthy() {
			v.num()
		} else {
			1.0
		}
	};
	let max_l = {
		let v = g.get("maxLevel");
		if v.truthy() {
			v.num()
		} else {
			60.0
		}
	};
	let level = |goal: &V| -> f64 {
		let l = level_at(goal).filter(|x| *x != 0.0 && !x.is_nan()).unwrap_or(min_l);
		jmax(min_l, jmin(max_l, l))
	};
	let chars: Vec<CharSet> = list.iter().map(|(step, goal)| characters(step, goal)).collect();
	for (i, (_, goal)) in list.iter().enumerate() {
		let Some(it) = gets(goal) else { continue };
		let mine = &chars[i];
		let it_id = it.get("id");
		// The goals spending what this one got: newest first; a goal getting more of it puts its items on top.
		let mut stack: Vec<(usize, f64)> = vec![(i, units(goal))];
		let mut collected: FxHashMap<Key, f64> = FxHashMap::default();
		if goal.get("t").as_str() == Some("collect") && !goal.get("quest").is_undef() {
			collected.insert(key(&goal.get("quest")), units(goal));
		}
		let mut k: isize = -1;
		let mut j = i + 1;
		while j < list.len() && !stack.is_empty() && stack[0].0 == i {
			let o = &list[j].1;
			if !meets(&chars[j], mine) {
				j += 1;
				continue;
			}
			if let Some(got) = gets(o) {
				if got.get("id").strict_eq(&it_id) {
					stack.push((j, units(o)));
					if o.get("t").as_str() == Some("collect") && !o.get("quest").is_undef() {
						collected.insert(key(&o.get("quest")), units(o));
					}
					j += 1;
					continue;
				}
			}
			let ot = o.get("t");
			let mut need = if ot.as_str() == Some("turnin") {
				spends(&data.quest(&o.get("quest")), &it_id, collected.get(&key(&o.get("quest"))).copied())
			} else if ot.as_str() == Some("use") && o.get("item").strict_eq(&it_id) {
				1.0
			} else {
				0.0
			};
			while need > 0.0 && !stack.is_empty() {
				let top = stack.last_mut().unwrap();
				let take = jmin(need, top.1);
				top.1 -= take;
				need -= take;
				if top.0 == i {
					k = j as isize;
				}
				if top.1 == 0.0 {
					stack.pop();
				}
			}
			j += 1;
		}
		if k < 0 {
			continue;
		}
		let k = k as usize;
		// Where the character stands at the source: its place, else the last located goal before it.
		let pl = |o: &V| place(data, &o.get("map"), &o.get("x"), &o.get("y"), &o.get("f"));
		let mut pos = pl(goal);
		let mut jj = i as isize - 1;
		while pos.is_none() && jj >= 0 {
			pos = pl(&list[jj as usize].1);
			jj -= 1;
		}
		let l0 = level(goal);
		let mut t = if goal.get("t").as_str() == Some("collect") { per_item(data, goal, l0) } else { work_sec(data, goal, l0) };
		for j in i + 1..=k {
			let o = &list[j].1;
			if j < k && (o.get("optional").truthy() || !meets(&chars[j], mine)) {
				continue;
			}
			let l = level(o);
			let mounted = l >= P::MOUNT_LEVEL;
			let ot = o.get("t");
			if ot.as_str() == Some("fly") {
				let n = net.get_or_insert_with(|| flights(data, side));
				let (sec, p) = fly(n, pos.as_ref(), &o.get("location"), mounted);
				t += sec;
				pos = p;
				continue;
			}
			if ot.as_str() == Some("hearth") {
				t += P::HEARTH_CAST;
				pos = inn(data, &o.get("location"));
				continue;
			}
			if let Some(at) = pl(o) {
				t += walk_sec(pos.as_ref(), Some(&at), mounted);
				pos = Some(at);
			}
			if j < k {
				t += work_sec(data, o, l);
			}
		}
		spans.push(Span { item: it, from: goal.clone(), to: list[k].1.clone(), seconds: t });
	}
	spans
}

pub fn check_timed_items(g: &V, data: &Data, diag: &mut Diagnostics, level_at: &dyn Fn(&V) -> Option<f64>, characters: &dyn Fn(&V, &V) -> CharSet, meets: &dyn Fn(&CharSet, &CharSet) -> bool) {
	let file = g.hidden("_ast").get("file").to_js_string();
	for Span { item, from, to, seconds } in timed_spans(g, data, level_at, characters, meets) {
		let duration = item.get("duration").num();
		if seconds <= duration {
			continue;
		}
		diag.warn(
			&file,
			from.hidden("_line").num(),
			format!(
				"item {} ({}) lasts {}, but the route takes about {} from here to the `{}` that spends it (line {})",
				item.get("id").to_js_string(),
				item.get("name").to_js_string(),
				lasts(duration),
				fmt(seconds),
				to.get("t").to_js_string(),
				to.hidden("_line").to_js_string()
			),
			Some("get it later, nearer that goal, or go there straight away (the estimate is the simulator's travel and kill times over this guide's goals: docs/SIMULATION.md)".into()),
		);
	}
}
