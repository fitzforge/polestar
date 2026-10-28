//! Port of tools/lib/dsl/resolve.js.
//! Resolver: turns a parsed guide into the compiled structure of docs/ARCHITECTURE.md ("Guide data"),
//! filling titles, names, entities, coordinates, objective indexes and counts from reference data
//! (docs/GUIDE_FORMAT.md, "What the compiler fills in").
//!
//! `resolve_guide(ast, data, diag, pack, author)` -> guide (`author`: the pack's, for a guide without one).
//! Compiled goals and steps carry hidden `_line` (source line) for the validator; everything enumerable is
//! part of the compiled schema.

use crate::data::{objective_label, Data};
use crate::diag::Diagnostics;
use crate::js::{cmp_utf16, hypot, is_integer, math_round, num_str, stringify, Obj, V};
use crate::obj;
use rustc_hash::{FxHashMap, FxHashSet};
use std::cell::RefCell;
use std::cmp::Ordering;
use std::rc::Rc;

const SPAWN_CHECK_YARDS: f64 = 50.0;
/// The fix hint for an id that is not in the reference data.
const FIND_ID_HINT: &str = "find the id with `polestar find <name>`, or give its name in quotes";

/// A collect's sources are named only for an item that few creatures or objects drop.
const MAX_NAMED_SOURCES: usize = 8;
/// `fromNpcs` on a collect: at most this many names.
const MAX_SOURCE_NPCS: usize = 5;
/// Droppers this many levels or more above the quest do not set the likely-dropper bar (levelSplit).
const ABOVE_QUEST_LEVELS: f64 = 3.0;

const RANK_CAPS: [f64; 4] = [75.0, 150.0, 225.0, 300.0];
const RANK_MIN_SKILL: [f64; 4] = [0.0, 50.0, 125.0, 225.0];
const RANK_NAMES: [&str; 4] = ["Apprentice", "Journeyman", "Expert", "Artisan"];

const SPOT_CAP: usize = 6;
const SPOT_CLUSTER_YARDS: f64 = 70.0;
const SPOT_MAX_CLUSTER_YARDS: f64 = 250.0;
const SPOT_MIN_RADIUS: f64 = 15.0;
const SPREAD_YARDS: f64 = 250.0;
const SPREAD_CAP: usize = 12;
const SPREAD_MIN_RADIUS: f64 = 40.0;
const SPREAD_MAX_MIN_RADIUS: f64 = 150.0;
const STRAY_YARDS: f64 = 300.0;
const STRAY_MAX: usize = 2;
const STRAY_SHARE: f64 = 0.75;

const GATHER_ROLES: [&str; 3] = ["mine", "herb", "fishing"];
const LOOP_RADIUS: f64 = 30.0;
const LOOP_VERBS: [&str; 3] = ["kill", "collect", "interact"];
const ON_STEP_ONLY: [&str; 8] = ["goto", "talk", "hearth", "die", "getfp", "fly", "vendor", "task"];
const CATEGORIES: [&str; 9] = ["Leveling", "Class", "Professions", "Reputation", "Legacy", "Exploration", "Collectibles", "Miscellaneous", "Dungeons"];

pub fn round2(n: f64) -> f64 {
	let r = math_round(n * 100.0) / 100.0;
	if r == 0.0 {
		0.0
	} else {
		r
	}
}

// ---- small JS helpers ----

/// `a || b` for comparator numbers (0 and NaN are falsy).
fn jor(a: f64, b: f64) -> f64 {
	if a != 0.0 && !a.is_nan() {
		a
	} else {
		b
	}
}

/// A JS comparator result as an ordering (NaN counts as equal).
fn ord(r: f64) -> Ordering {
	if r < 0.0 {
		Ordering::Less
	} else if r > 0.0 {
		Ordering::Greater
	} else {
		Ordering::Equal
	}
}

fn includes(list: &[V], x: &V) -> bool {
	list.iter().any(|v| v.strict_eq(x))
}

fn ptr_key(v: &V) -> usize {
	match v {
		V::Obj(o) => Rc::as_ptr(&o.0) as *const u8 as usize,
		V::Arr(a) => Rc::as_ptr(&a.0) as *const u8 as usize,
		_ => 0,
	}
}

fn js_max(xs: impl IntoIterator<Item = f64>) -> f64 {
	let mut m = f64::NEG_INFINITY;
	for x in xs {
		if x.is_nan() {
			return f64::NAN;
		}
		if x > m {
			m = x;
		}
	}
	m
}

fn join(list: &[V], sep: &str) -> String {
	list.iter().map(|v| if v.is_nullish() { String::new() } else { v.to_js_string() }).collect::<Vec<_>>().join(sep)
}

fn set_if(obj: &V, key: &str, value: V) {
	if !value.is_nullish() && value.as_str() != Some("") {
		obj.set(key, value);
	}
}

fn opt_str(s: Option<String>) -> V {
	s.map(V::from).unwrap_or(V::Null)
}

/// `x || undefined`.
fn or_undef(v: V) -> V {
	if v.truthy() {
		v
	} else {
		V::Undef
	}
}

fn hint_of(v: &V) -> Option<&str> {
	v.as_str()
}

fn name_of(data: &Data, kind: &str, id: &V) -> Option<String> {
	let e = match kind {
		"npc" => data.npc(id),
		"object" => data.object(id),
		"item" => data.item(id),
		_ => V::Null,
	};
	if e.truthy() && e.get("name").truthy() {
		Some(e.get("name").to_js_string())
	} else {
		None
	}
}

/// Distance between two points on one map: yards when the map's size is known, else map percent.
fn distance(data: &Data, map: &V, ax: f64, ay: f64, bx: f64, by: f64) -> f64 {
	let size = data.map_size(map);
	let dx = (ax - bx) * if size.truthy() { size.get("w").num() / 100.0 } else { 1.0 };
	let dy = (ay - by) * if size.truthy() { size.get("h").num() / 100.0 } else { 1.0 };
	(dx * dx + dy * dy).sqrt()
}

fn px(p: &V) -> f64 {
	p.num_at(0)
}
fn py(p: &V) -> f64 {
	p.num_at(1)
}
fn num(v: &V, k: &str) -> f64 {
	v.get(k).num()
}

/// `o.chance || 0`.
fn chance_of(c: &V) -> f64 {
	let ch = c.get("chance");
	if ch.truthy() {
		ch.num()
	} else {
		0.0
	}
}

/// Whether a data table has any entry (the JS memoises per table; an object's size is known here).
fn non_empty(o: &V) -> bool {
	match o {
		V::Obj(o) => !o.is_empty(),
		V::Arr(a) => !a.is_empty(),
		_ => false,
	}
}

// ---- spawn picking ----

fn point(cand: &V, map: &V, x: f64, y: f64, f: &V) -> Obj {
	let fv: V = if f.as_str() == Some("e") { "e".into() } else { V::Undef };
	obj! { "cand" => cand.clone(), "map" => map.clone(), "x" => round2(x), "y" => round2(y), "f" => fv }
}

fn centroid(cand: &V, s: &V) -> Obj {
	let pts = s.get("pts").items();
	let mut sx = 0.0;
	let mut sy = 0.0;
	for p in &pts {
		sx += px(p);
		sy += py(p);
	}
	let n = pts.len() as f64;
	point(cand, &s.get("map"), sx / n, sy / n, &s.get("f"))
}

/// Pick an entity and a point for it. candidates: [{ kind, id }] in priority order.
/// -> { cand, map, x, y, f, sources, elites } | { cand } (no usable spawns) | Null (no candidates).
/// `sides`: the factions the goal applies to (None: no elite split); `qlvl`: a collect's quest level (NaN: none).
pub fn pick_spawn(data: &Data, candidates: &[V], zone_map: &V, prev: &V, used_maps: &[V], sides: Option<&V>, rares: bool, qlvl: f64) -> V {
	if candidates.is_empty() {
		return V::Null;
	}
	let all: Vec<(V, Vec<V>)> = candidates.iter().map(|c| (c.clone(), data.spawns(&c.get("kind").to_js_string(), &c.get("id")))).collect();
	let mut maps: Vec<V> = Vec::new();
	if !zone_map.is_nullish() {
		maps.push(zone_map.clone());
	}
	for m in used_maps {
		if !includes(&maps, m) {
			maps.push(m.clone());
		}
	}
	for m in &maps {
		let (on, elites) = on_map(data, &all, m, sides, rares, qlvl);
		if on.is_empty() {
			continue;
		}
		let sources: Vec<V> = on.iter().map(|o| o.0.clone()).collect();
		let elites: Vec<V> = elites.iter().map(|o| o.0.clone()).collect();
		let out = if prev.truthy() && prev.get("map").strict_eq(m) {
			let mut best: Option<(f64, V, f64, f64, V)> = None;
			let (bx, by) = (num(prev, "x"), num(prev, "y"));
			for (cand, s) in &on {
				for p in s.get("pts").items() {
					let d = distance(data, m, px(&p), py(&p), bx, by);
					if best.as_ref().is_none_or(|b| d < b.0) {
						best = Some((d, cand.clone(), px(&p), py(&p), s.get("f")));
					}
				}
			}
			let b = best.unwrap();
			point(&b.1, m, b.2, b.3, &b.4)
		} else {
			centroid(&on[0].0, &on[0].1)
		};
		out.set("sources", sources);
		out.set("elites", elites);
		return out.into();
	}
	for (cand, spawns) in &all {
		if spawns.is_empty() {
			continue;
		}
		let mut s = spawns[0].clone();
		for b in &spawns[1..] {
			if b.get("pts").len() > s.get("pts").len() {
				s = b.clone();
			}
		}
		let out = centroid(cand, &s);
		out.set("sources", vec![cand.clone()]);
		return out.into();
	}
	obj! { "cand" => candidates[0].clone() }.into()
}

/// The candidates ([(cand, spawns)]) that spawn on `map`, with their spawns there. -> (on, elites).
fn on_map(data: &Data, all: &[(V, Vec<V>)], map: &V, sides: Option<&V>, rares: bool, qlvl: f64) -> (Vec<(V, V)>, Vec<(V, V)>) {
	let mut on: Vec<(V, V)> = Vec::new();
	let mut elites: Vec<(V, V)> = Vec::new();
	for (cand, spawns) in all {
		if let Some(s) = spawns.iter().find(|sp| sp.get("map").strict_eq(map)) {
			on.push((cand.clone(), s.clone()));
		}
	}
	let split = sides.and_then(|sides| elite_split(data, &on.iter().map(|o| o.0.clone()).collect::<Vec<_>>(), sides, rares));
	if let Some((normal, el)) = split {
		elites = on.iter().filter(|o| includes(&el, &o.0)).cloned().collect();
		on.retain(|o| includes(&normal, &o.0));
	}
	if let Some((near, _)) = level_split(data, &on.iter().map(|o| o.0.clone()).collect::<Vec<_>>(), qlvl) {
		on.retain(|o| includes(&near, &o.0));
	}
	if on.iter().any(|o| o.0.get("chance").is_num()) {
		let best = js_max(on.iter().map(|o| chance_of(&o.0)));
		let likely: Vec<(V, V)> = on.iter().filter(|o| chance_of(&o.0) >= best / 2.0 && (chance_of(&o.0) >= 1.0 || best < 1.0)).cloned().collect();
		if !likely.is_empty() {
			on = likely;
		}
	}
	(on, elites)
}

/// The NPC sources a goal's point and spawn areas belong to, `first` leading. -> [{ npc, npcName }] | Undef
fn source_npcs(data: &Data, first: &V, sources: &[V]) -> V {
	let mut out: Vec<V> = Vec::new();
	let mut seen: Vec<V> = Vec::new();
	let order: Vec<V> = if includes(sources, first) { std::iter::once(first.clone()).chain(sources.iter().cloned()).collect() } else { sources.to_vec() };
	for s in &order {
		if out.len() >= MAX_SOURCE_NPCS {
			break;
		}
		if !s.truthy() || s.get("kind").as_str() != Some("npc") || includes(&seen, &s.get("id")) {
			continue;
		}
		seen.push(s.get("id"));
		let rec = data.npc(&s.get("id"));
		if rec.truthy() && rec.get("name").truthy() {
			out.push(obj! { "npc" => s.get("id"), "npcName" => rec.get("name").to_js_string() }.into());
		}
	}
	if out.is_empty() {
		V::Undef
	} else {
		out.into()
	}
}

/// The sources a hand-placed point stands among: those with a spawn within `near` yards, nearest first.
fn point_sources(data: &Data, sources: &[V], map: &V, f: &V, x: f64, y: f64, near: f64) -> Vec<V> {
	let mut out: Vec<(V, f64)> = Vec::new();
	for src in sources {
		let mut d = f64::INFINITY;
		for p in spawn_points_of(data, std::slice::from_ref(src), map, f) {
			d = d.min(distance(data, map, px(&p), py(&p), x, y));
		}
		if d <= near {
			out.push((src.clone(), d));
		}
	}
	out.sort_by(|a, b| ord(a.1 - b.1));
	out.into_iter().map(|o| o.0).collect()
}

/// Sources that elites and normal sources both drop. -> (normal, elites) | None
fn elite_split(data: &Data, cands: &[V], sides: &V, rares: bool) -> Option<(Vec<V>, Vec<V>)> {
	let chances = cands.iter().any(|c| c.get("chance").is_num());
	let best = js_max(std::iter::once(0.0).chain(cands.iter().map(chance_of)));
	let real: Vec<V> = cands.iter().filter(|c| !chances || chance_of(c) >= 1.0 || best < 1.0).cloned().collect();
	let elites: Vec<V> = real.iter().filter(|c| elite_source(data, c, sides, rares)).cloned().collect();
	let normal: Vec<V> = real.iter().filter(|c| normal_source(data, c, sides, rares)).cloned().collect();
	if !elites.is_empty() && !normal.is_empty() {
		Some((normal, elites))
	} else {
		None
	}
}

/// Droppers near a quest's level crowded out by ones far above it. -> (near, above) | None
fn level_split(data: &Data, cands: &[V], qlvl: f64) -> Option<(Vec<V>, Vec<V>)> {
	if !(qlvl > 0.0) || !cands.iter().any(|c| c.get("chance").is_num()) {
		return None;
	}
	let likely = |list: &[V]| -> Vec<V> {
		let best = js_max(std::iter::once(0.0).chain(list.iter().map(chance_of)));
		list.iter().filter(|c| chance_of(c) >= best / 2.0 && (chance_of(c) >= 1.0 || best < 1.0)).cloned().collect()
	};
	let above: Vec<V> = cands
		.iter()
		.filter(|c| {
			let n = if c.get("kind").as_str() == Some("npc") { data.npc(&c.get("id")) } else { V::Null };
			n.truthy() && n.get("level").num() >= qlvl + ABOVE_QUEST_LEVELS
		})
		.cloned()
		.collect();
	let rest: Vec<V> = cands.iter().filter(|c| !includes(&above, c)).cloned().collect();
	if above.is_empty() || rest.is_empty() {
		return None;
	}
	if js_max(rest.iter().map(chance_of)) < 1.0 && js_max(cands.iter().map(chance_of)) >= 1.0 {
		return None;
	}
	let all = likely(cands);
	let near = likely(&rest);
	if near.iter().any(|c| !includes(&all, c)) {
		Some((near, above))
	} else {
		None
	}
}

/// Whether a rare drops the item at the highest chance while normal sources drop it at 50% or more.
fn rare_leads(data: &Data, cands: &[V], sides: &V) -> bool {
	let mut top: V = if cands.is_empty() { obj! { "chance" => 0 }.into() } else { cands[0].clone() };
	for b in cands {
		if b.get("chance").num() > top.get("chance").num() {
			top = b.clone();
		}
	}
	let n = if top.get("kind").as_str() == Some("npc") { data.npc(&top.get("id")) } else { V::Null };
	if !n.truthy() || !crate::group::is_rare(&n.get("rank"), &n.get("faction"), sides) {
		return false;
	}
	cands.iter().any(|c| c.get("chance").num() >= 50.0 && normal_source(data, c, sides, true))
}

fn elite_source(data: &Data, cand: &V, sides: &V, rares: bool) -> bool {
	let n = if cand.get("kind").as_str() == Some("npc") { data.npc(&cand.get("id")) } else { V::Null };
	n.truthy() && (crate::group::is_elite(&n.get("rank"), &n.get("faction"), sides) || (rares && crate::group::is_rare(&n.get("rank"), &n.get("faction"), sides)))
}

fn normal_source(data: &Data, cand: &V, sides: &V, rares: bool) -> bool {
	if cand.get("kind").as_str() != Some("npc") {
		return true;
	}
	let n = data.npc(&cand.get("id"));
	n.truthy()
		&& crate::group::hostile_to(&n.get("faction"), sides)
		&& !crate::group::is_elite(&n.get("rank"), &n.get("faction"), sides)
		&& !(rares && crate::group::is_rare(&n.get("rank"), &n.get("faction"), sides))
}

// ---- spawn areas ----

/// Median distance in yards from a spawn to its nearest neighbour.
fn median_spacing(pts: &[V], frame: &V) -> f64 {
	let (sx, sy) = crate::cluster::scale_of(frame);
	let ax = sx.abs();
	let mut order: Vec<usize> = (0..pts.len()).collect();
	order.sort_by(|&a, &b| ord(px(&pts[a]) - px(&pts[b])));
	let mut nn = vec![0.0; pts.len()];
	for r in 0..order.len() {
		let p = &pts[order[r]];
		let mut best = f64::INFINITY;
		for step in [-1i64, 1] {
			let mut s = r as i64 + step;
			while s >= 0 && (s as usize) < order.len() {
				let q = &pts[order[s as usize]];
				if (px(p) - px(q)).abs() * ax > best {
					break;
				}
				let d = hypot((px(p) - px(q)) * sx, (py(p) - py(q)) * sy);
				if d < best {
					best = d;
				}
				s += step;
			}
		}
		nn[r] = best;
	}
	nn.sort_by(|a, b| ord(a - b));
	nn[nn.len() / 2]
}

/// Yards from the spawns' centre within which 90% of them lie.
fn extent90(pts: &[V], frame: &V) -> f64 {
	let (sx, sy) = crate::cluster::scale_of(frame);
	let n = pts.len() as f64;
	let mut cx = 0.0;
	let mut cy = 0.0;
	for p in pts {
		cx += px(p) / n;
		cy += py(p) / n;
	}
	let mut ds: Vec<f64> = pts.iter().map(|p| hypot((px(p) - cx) * sx, (py(p) - cy) * sy)).collect();
	ds.sort_by(|a, b| ord(a - b));
	ds[(ds.len() - 1).min((ds.len() as f64 * 0.9).floor() as usize)]
}

fn tie(a: &V, b: &V) -> f64 {
	jor(jor(num(b, "n") - num(a, "n"), num(a, "x") - num(b, "x")), num(a, "y") - num(b, "y"))
}

/// Up to `cap` clusters spread evenly: from the one nearest (x, y), then the one farthest from every pick.
fn evenly(data: &Data, map: &V, clusters: &[V], cap: usize, x: f64, y: f64) -> Vec<V> {
	if clusters.len() <= cap {
		return clusters.to_vec();
	}
	let dist = |a: &V, bx: f64, by: f64| distance(data, map, num(a, "x"), num(a, "y"), bx, by);
	let mut rest: Vec<V> = clusters.to_vec();
	rest.sort_by(|a, b| ord(jor(dist(a, x, y) - dist(b, x, y), tie(a, b))));
	let first = rest.remove(0);
	let mut gap: Vec<f64> = rest.iter().map(|c| dist(c, num(&first, "x"), num(&first, "y"))).collect();
	let mut picked = vec![first];
	while picked.len() < cap && !rest.is_empty() {
		let mut bi = 0;
		for i in 1..rest.len() {
			let d = gap[i] - gap[bi];
			if d > 0.0 || (d == 0.0 && tie(&rest[i], &rest[bi]) < 0.0) {
				bi = i;
			}
		}
		let next = rest.remove(bi);
		gap.remove(bi);
		for (i, c) in rest.iter().enumerate() {
			gap[i] = gap[i].min(dist(c, num(&next, "x"), num(&next, "y")));
		}
		picked.push(next);
	}
	picked
}

/// The spots as a walk from (x, y): each next one the nearest left.
fn walk(data: &Data, map: &V, spots: &[V], x: f64, y: f64) -> Vec<V> {
	let mut left: Vec<V> = spots.to_vec();
	let mut out = Vec::new();
	let (mut atx, mut aty) = (x, y);
	while !left.is_empty() {
		let mut bi = 0;
		for i in 1..left.len() {
			let d = distance(data, map, num(&left[i], "x"), num(&left[i], "y"), atx, aty) - distance(data, map, num(&left[bi], "x"), num(&left[bi], "y"), atx, aty);
			let (li, lb) = (&left[i], &left[bi]);
			if d < 0.0 || (d == 0.0 && (num(li, "n") > num(lb, "n") || (num(li, "n") == num(lb, "n") && jor(num(li, "x") - num(lb, "x"), num(li, "y") - num(lb, "y")) < 0.0))) {
				bi = i;
			}
		}
		let at = left.remove(bi);
		atx = num(&at, "x");
		aty = num(&at, "y");
		out.push(at);
	}
	out
}

/// The stray spawns of `pts` (see spawn_spots, "Strays"), as a set of point identities.
fn stray_points(pts: &[V], frame: &V) -> FxHashSet<usize> {
	let mut strays = FxHashSet::default();
	if pts.len() <= SPOT_CAP {
		return strays;
	}
	let (sx, sy) = crate::cluster::scale_of(frame);
	let mut root: Vec<usize> = (0..pts.len()).collect();
	fn find(root: &mut Vec<usize>, i: usize) -> usize {
		if root[i] == i {
			return i;
		}
		let r = find(root, root[i]);
		root[i] = r;
		r
	}
	let ax = sx.abs();
	let mut order: Vec<usize> = (0..pts.len()).collect();
	order.sort_by(|&a, &b| ord(px(&pts[a]) - px(&pts[b])));
	for r in 0..order.len() {
		let i = order[r];
		for &j in &order[r + 1..] {
			if (px(&pts[j]) - px(&pts[i])) * ax > STRAY_YARDS {
				break;
			}
			if hypot((px(&pts[i]) - px(&pts[j])) * sx, (py(&pts[i]) - py(&pts[j])) * sy) <= STRAY_YARDS {
				let a = find(&mut root, i);
				let b = find(&mut root, j);
				root[a] = b;
			}
		}
	}
	let mut groups: Vec<(usize, Vec<usize>)> = Vec::new();
	let mut at: FxHashMap<usize, usize> = FxHashMap::default();
	for i in 0..pts.len() {
		let g = find(&mut root, i);
		let k = *at.entry(g).or_insert_with(|| {
			groups.push((g, Vec::new()));
			groups.len() - 1
		});
		groups[k].1.push(i);
	}
	let biggest = js_max(groups.iter().map(|g| g.1.len() as f64));
	if biggest < STRAY_SHARE * pts.len() as f64 {
		return strays;
	}
	for (_, g) in &groups {
		if g.len() <= STRAY_MAX {
			for &i in g {
				strays.insert(ptr_key(&pts[i]));
			}
		}
	}
	strays
}

/// Every known spawn point of `sources` on `map` in frame `f` (Undef or "e").
fn spawn_points_of(data: &Data, sources: &[V], map: &V, f: &V) -> Vec<V> {
	let mut pts = Vec::new();
	for src in sources {
		for s in data.spawns(&src.get("kind").to_js_string(), &src.get("id")) {
			let sf: V = if s.get("f").as_str() == Some("e") { "e".into() } else { V::Undef };
			if s.get("map").strict_eq(map) && sf.strict_eq(f) {
				pts.extend(s.get("pts").items());
				pts.extend(s.get("more").items());
			}
		}
	}
	pts
}

/// A gathering node (mine, herb or fishing object).
fn gather_node(data: &Data, src: &V) -> bool {
	let o = if src.get("kind").as_str() == Some("object") { data.object(&src.get("id")) } else { V::Null };
	o.truthy() && o.get("roles").is_arr() && o.get("roles").items().iter().any(|r| r.as_str().is_some_and(|r| GATHER_ROLES.contains(&r)))
}

struct SpawnSpots {
	spots: Vec<V>,
	spread: bool,
	at: Option<(f64, f64)>,
}

fn spawn_spots(data: &Data, sources: &[V], map: &V, f: &V, mut x: f64, mut y: f64, elites: &[V]) -> Option<SpawnSpots> {
	let pts = spawn_points_of(data, sources, map, f);
	if pts.len() < 2 {
		return None;
	}
	let frame = data.frame(map);
	let spread = extent90(&pts, &frame) > SPREAD_YARDS;
	let clusters: Vec<V> = if pts.len() <= SPOT_CAP {
		crate::cluster::cluster_points(&pts, &frame, SPOT_CLUSTER_YARDS, f64::INFINITY, SPOT_MIN_RADIUS)
	} else {
		let spacing = median_spacing(&pts, &frame);
		let radius = SPOT_MAX_CLUSTER_YARDS.min(SPOT_CLUSTER_YARDS.max(2.0 * spacing));
		let min_radius = if spread { math_round(SPREAD_MAX_MIN_RADIUS.min(SPREAD_MIN_RADIUS.max(spacing))) } else { SPOT_MIN_RADIUS };
		crate::cluster::cluster_points(&pts, &frame, radius, f64::INFINITY, min_radius)
	};
	let (sx, sy) = crate::cluster::scale_of(&frame);
	let yards = |ax: f64, ay: f64, c: &V| hypot((ax - num(c, "x")) * sx, (ay - num(c, "y")) * sy);
	let keep = |list: &[V], out: &dyn Fn(&V) -> bool| -> Vec<V> {
		let rest: Vec<V> = list.iter().filter(|c| !out(c)).cloned().collect();
		if rest.is_empty() {
			list.to_vec()
		} else {
			rest
		}
	};
	let elite_pts: Vec<(f64, f64)> = spawn_points_of(data, elites, map, f).iter().map(|p| (px(p), py(p))).collect();
	let in_camp = |c: &V| elite_pts.iter().filter(|p| yards(p.0, p.1, c) <= num(c, "r").max(SPOT_CLUSTER_YARDS)).count() as f64 > num(c, "n");
	let mut open: Vec<V> = if !elite_pts.is_empty() { keep(&clusters, &in_camp) } else { clusters.clone() };
	let strays = stray_points(&pts, &frame);
	if !strays.is_empty() {
		let settled: Vec<(f64, f64)> = pts.iter().filter(|p| !strays.contains(&ptr_key(p))).map(|p| (px(p), py(p))).collect();
		open = keep(&open, &|c: &V| !settled.iter().any(|p| yards(p.0, p.1, c) <= num(c, "r")));
	}
	let mut at = None;
	if open.len() < clusters.len() {
		let (hx, hy) = (x, y);
		let nearest = |list: &[V]| -> V {
			let mut a = list[0].clone();
			for b in &list[1..] {
				if yards(hx, hy, b) < yards(hx, hy, &a) {
					a = b.clone();
				}
			}
			a
		};
		if !includes(&open, &nearest(&clusters)) {
			let to = nearest(&open);
			x = num(&to, "x");
			y = num(&to, "y");
			at = Some((x, y));
		}
	}
	let nearest_first = |spots: Vec<V>| -> Vec<V> {
		let mut ds: Vec<(V, f64)> = spots
			.into_iter()
			.map(|s| {
				let d = distance(data, map, num(&s, "x"), num(&s, "y"), x, y);
				(s, d)
			})
			.collect();
		ds.sort_by(|a, b| ord(jor(jor(jor(a.1 - b.1, num(&b.0, "n") - num(&a.0, "n")), num(&a.0, "x") - num(&b.0, "x")), num(&a.0, "y") - num(&b.0, "y"))));
		ds.into_iter().map(|d| d.0).collect()
	};
	let with_rest = |picked: Vec<V>| -> Vec<V> {
		let others: Vec<V> = clusters.iter().filter(|c| !includes(&picked, c)).cloned().collect();
		let mut out = picked;
		for c in nearest_first(others) {
			let o = c.as_obj().unwrap().spread();
			o.set("alt", true);
			out.push(o.into());
		}
		out
	};
	let spots = if pts.len() <= SPOT_CAP {
		with_rest(if spread { walk(data, map, &open, x, y) } else { nearest_first(open.clone()) })
	} else if spread {
		with_rest(walk(data, map, &evenly(data, map, &open, SPREAD_CAP, x, y), x, y))
	} else {
		let camps: Vec<V> = if open.iter().any(|s| num(s, "n") > 1.0) { open.iter().filter(|s| num(s, "n") > 1.0).cloned().collect() } else { open.clone() };
		let mut nf = nearest_first(camps);
		nf.truncate(SPOT_CAP);
		with_rest(nf)
	};
	Some(SpawnSpots { spots, spread, at })
}

/// A hand-placed goal whose target spawns at several places: the author's point first, every other place
/// an alternative. -> spots | Undef
fn hand_spots(data: &Data, sources: &[V], map: &V, f: &V, x: f64, y: f64, near: f64) -> V {
	if !data.map_size(map).truthy() {
		return V::Undef;
	}
	let pts = spawn_points_of(data, sources, map, f);
	if !pts.iter().any(|p| distance(data, map, px(p), py(p), x, y) <= near) {
		return V::Undef;
	}
	let Some(sp) = spawn_spots(data, sources, map, f, x, y, &[]) else {
		return V::Undef;
	};
	let mut own_r = SPOT_MIN_RADIUS;
	let mut own_n = 0.0;
	let mut alts: Vec<(V, f64)> = Vec::new();
	for s in &sp.spots {
		let d = distance(data, map, num(s, "x"), num(s, "y"), x, y);
		if d <= num(s, "r") + SPOT_MIN_RADIUS {
			own_r = own_r.max((d + num(s, "r")).ceil());
			own_n += num(s, "n");
		} else {
			alts.push((obj! { "x" => s.get("x"), "y" => s.get("y"), "r" => s.get("r"), "n" => s.get("n"), "alt" => true }.into(), d));
		}
	}
	alts.sort_by(|a, b| ord(jor(jor(a.1 - b.1, num(&a.0, "x") - num(&b.0, "x")), num(&a.0, "y") - num(&b.0, "y"))));
	let own: V = obj! { "x" => x, "y" => y, "r" => own_r, "n" => own_n }.into();
	let mut out = vec![own];
	out.extend(alts.into_iter().map(|a| a.0));
	out.into()
}

// ---- resolver state ----

struct R<'a> {
	data: &'a Data,
	file: String,
	diag: &'a mut Diagnostics,
	zone_cache: FxHashMap<usize, V>,
}

impl R<'_> {
	fn err(&mut self, ln: &V, msg: impl Into<String>, hint: Option<&str>) {
		self.diag.error(&self.file, ln.num(), msg, hint.map(String::from));
	}
	fn warn(&mut self, ln: &V, msg: impl Into<String>, hint: Option<&str>) {
		self.diag.warn(&self.file, ln.num(), msg, hint.map(String::from));
	}

	fn resolve_zone(&mut self, spec: &V) -> V {
		if !spec.truthy() {
			return V::Null;
		}
		let key = ptr_key(spec);
		if let Some(v) = self.zone_cache.get(&key) {
			return v.clone();
		}
		let data = self.data;
		let mut out = V::Null;
		if !spec.get("map").is_undef() {
			let z = data.zone(&spec.get("map"));
			if !z.truthy() && non_empty(&data.zones) {
				self.warn(&spec.get("line"), format!("map {} is not in zones.json", spec.get("map")), None);
			}
			let name: V = if z.truthy() && z.get("name").truthy() { z.get("name").to_js_string().into() } else { V::Undef };
			out = obj! { "id" => spec.get("map"), "name" => name }.into();
		} else {
			let found = data.zone_named(&spec.get("name").to_js_string());
			if !found.truthy() {
				self.err(&spec.get("line"), format!("unknown zone \"{}\" (not in zones.json; use `zone map <uiMapID>`)", spec.get("name")), None);
			} else {
				let zone = found.get("zone");
				if found.get("ambiguous").truthy() {
					let ids: Vec<V> = found.get("ambiguous").items().iter().map(|z| z.get("id")).collect();
					self.warn(&spec.get("line"), format!("zone \"{}\" matches maps {}; using {} (write `zone map <uiMapID>` to choose)", spec.get("name"), join(&ids, ", "), zone.get("id")), None);
				}
				out = obj! { "id" => zone.get("id"), "name" => zone.get("name").to_js_string() }.into();
			}
		}
		self.zone_cache.insert(key, out.clone());
		out
	}
}

/// Per skill line: { target, rank } (a V object, mutated in place like the JS map's values).
type ProfProgress = RefCell<Vec<(f64, V)>>;

struct Ctx<'a> {
	sides: V,
	used_maps: &'a [V],
	frame: (String, bool),
	layers: Vec<V>,
	prof: Option<&'a ProfProgress>,
	zone_id: V,
	loop_: bool,
}

fn only_of(c: &V) -> V {
	if !c.truthy() {
		return V::Undef;
	}
	let o: V = V::obj();
	set_if(&o, "classes", c.get("classes"));
	set_if(&o, "races", c.get("races"));
	set_if(&o, "factions", c.get("factions"));
	if o.is_empty() {
		V::Undef
	} else {
		o
	}
}

/// A `loop` step: its `goto` points are the places to search for its kill, collect and interact goals.
fn apply_loop(step: &V, s: &V, r: &mut R) {
	let data = r.data;
	let ln = s.get("loop");
	let goals = step.get("goals").items();
	let gotos: Vec<V> = goals.iter().filter(|g| g.get("t").as_str() == Some("goto")).cloned().collect();
	if gotos.iter().any(|g| g.get("x").is_undef()) {
		return;
	}
	if gotos.len() < 2 {
		return r.err(&ln, "`loop` needs at least two `goto` points in its step", Some("list the places to search as `goto x,y` lines, in the order to walk them"));
	}
	let first = gotos[0].clone();
	if gotos.iter().any(|g| !g.get("map").strict_eq(&first.get("map"))) {
		return r.err(&ln, "`loop` points must all be on one map", Some("split the search into a step per map"));
	}
	if gotos.iter().any(|g| !g.get("f").strict_eq(&first.get("f"))) {
		return r.err(&ln, "`loop` points must all be in one map frame: all Era, or all `live`", None);
	}
	if let Some(own) = gotos.iter().find(|g| g.get("only").truthy() || g.get("optional").truthy()) {
		return r.err(&own.hidden("_line"), "a `loop` point cannot be `optional` or have `only`: every goal of the loop searches it", None);
	}
	let sgoals = s.get("goals");
	let targets: Vec<V> = goals
		.iter()
		.enumerate()
		.filter(|(i, g)| g.get("t").as_str().is_some_and(|t| LOOP_VERBS.contains(&t)) && !sgoals.at(*i).get("explicitCoords").truthy() && !g.get("candidates").truthy())
		.map(|(_, g)| g.clone())
		.collect();
	if targets.is_empty() {
		return r.err(&ln, "`loop` needs a kill, collect or interact goal without its own `@x,y`", Some("a goal placed with `@x,y` keeps its point; drop `loop` to walk the gotos as a path"));
	}
	for goal in &targets {
		goal.set("map", first.get("map"));
		goal.set("x", first.get("x"));
		goal.set("y", first.get("y"));
		if first.get("f").truthy() {
			goal.set("f", first.get("f"));
		} else {
			goal.as_obj().unwrap().delete("f");
		}
		let spots: Vec<V> = gotos
			.iter()
			.map(|g| {
				let rr = if !g.get("r").is_undef() { g.get("r") } else { LOOP_RADIUS.into() };
				obj! { "x" => g.get("x"), "y" => g.get("y"), "r" => rr }.into()
			})
			.collect();
		goal.set("spots", spots);
		goal.set("spread", true);
		goal.as_obj().unwrap().delete("z");
		set_if(goal, "z", crate::heights::goal_height(data, goal).unwrap_or_default());
		for p in goal.get("spots").items() {
			set_if(&p, "z", crate::heights::spot_height(data, goal, &p).unwrap_or_default());
		}
	}
	let kept: Vec<V> = goals.into_iter().filter(|g| g.get("t").as_str() != Some("goto")).collect();
	step.set("goals", kept);
}

/// `resolveGuide(ast, data, diag, { pack, author })`.
pub fn resolve_guide(ast: &V, data: &Data, diag: &mut Diagnostics, pack: Option<&str>, author: Option<&str>) -> V {
	let file = ast.get("file").as_str().unwrap_or("").to_string();
	let mut r = R { data, file, diag, zone_cache: FxHashMap::default() };
	let r = &mut r;
	let h = ast.get("header");

	let guide: V = obj! { "id" => ast.get("id") }.into();
	guide.set("pack", pack.filter(|p| !p.is_empty()).unwrap_or("guides"));
	guide.set("title", h.get("title"));
	set_if(&guide, "faction", h.get("faction"));
	set_if(&guide, "races", h.get("races"));
	set_if(&guide, "classes", h.get("classes"));
	if h.get("levels").truthy() {
		guide.set("minLevel", h.get("levels").get("min"));
		guide.set("maxLevel", h.get("levels").get("max"));
	}
	guide.set("category", canonical_category(&h.get("category"), ast, r));
	set_if(&guide, "folder", h.get("folder"));
	set_if(&guide, "keywords", h.get("keywords"));
	if h.get("collects").truthy() {
		guide.set("collects", h.get("collects").items());
		let have_items = non_empty(&data.items);
		for id in h.get("collects").items() {
			if have_items && !data.item(&id).truthy() {
				r.warn(&ast.get("lines").get("collects"), format!("`collects` item {id} is not in data (new Forever content?)"), None);
			}
		}
	}
	if h.get("reward").truthy() {
		let mut list = Vec::new();
		for e in h.get("reward").items() {
			if !e.get("text").is_undef() {
				list.push(obj! { "text" => e.get("text") }.into());
				continue;
			}
			if !e.get("spell").is_undef() {
				if !e.get("spellName").truthy() {
					r.err(&e.get("line"), format!("reward spell {} needs its name: `reward spell {} \"Spell name\"`", e.get("spell"), e.get("spell")), None);
				}
				list.push(obj! { "spell" => e.get("spell"), "spellName" => e.get("spellName") }.into());
				continue;
			}
			let known = data.item(&e.get("item"));
			let out: V = obj! { "item" => e.get("item") }.into();
			let name: V = if e.get("itemName").truthy() {
				e.get("itemName")
			} else if known.truthy() && known.get("name").truthy() {
				known.get("name").to_js_string().into()
			} else {
				V::Null
			};
			if !name.truthy() {
				r.err(&e.get("line"), format!("reward item {} is not in data; give its name: `{} \"Item name\"`", e.get("item"), e.get("item")), Some(FIND_ID_HINT));
			} else {
				out.set("itemName", name);
			}
			set_if(&out, "quality", e.get("quality"));
			if e.get("choice").truthy() {
				out.set("choice", true);
			}
			list.push(out);
		}
		guide.set("reward", list);
	}
	set_if(&guide, "why", h.get("why"));
	if guide.get("category").as_str() == Some("Class") {
		if !h.get("reward").truthy() {
			r.warn(&ast.get("line"), "a Class guide needs `reward`: what its chain gives (`reward item <id>`, `reward spell <id> \"Name\"` or `reward text <words>`), shown in the guide menu", None);
		}
		if !h.get("why").truthy() {
			r.warn(&ast.get("line"), "a Class guide needs `why`: one short line on why the chain is worth doing, shown in the guide menu", None);
		}
	}
	let hz = r.resolve_zone(&h.get("zone"));
	if hz.truthy() {
		guide.set("zone", hz.get("id"));
		set_if(&guide, "zoneName", hz.get("name"));
	}
	let next = h.get("next");
	if next.truthy() && !next.is_empty() {
		guide.set("next", next.at(0));
		if next.len() > 1 || h.get("nextWhen").truthy() {
			guide.set("nextChoices", next.items());
		}
	}
	let steps = ast.get("steps").items();
	if h.get("nextWhen").truthy() {
		let last_step = steps.last().cloned().unwrap_or_default();
		let last_goal = if last_step.truthy() { last_step.get("goals").items().last().cloned().unwrap_or_default() } else { V::Undef };
		let spec = if last_step.truthy() && last_step.get("zone").truthy() {
			last_step.get("zone")
		} else if last_goal.truthy() {
			last_goal.get("zone")
		} else {
			last_goal.clone()
		};
		let ez = r.resolve_zone(&spec);
		let end_zone = if ez.truthy() { ez } else { hz.clone() };
		let nw: V = V::obj();
		guide.set("nextWhen", nw.clone());
		for id in h.get("next").items() {
			let key = id.to_js_string();
			let p = h.get("nextWhen").get(&key);
			if !p.truthy() {
				continue;
			}
			match p.get("k").as_str() {
				Some("done") => {
					r.err(&p.get("line"), "`done` checks a step of the guide being played: it cannot decide a `next` option", Some("use a predicate on the character, such as `turnedin <quest>`"))
				}
				Some("group") => r.err(&p.get("line"), "`group` asks the player at a step of the guide: it cannot decide a `next` option", Some("put `when group <quest>` on the steps of that quest")),
				_ => {
					let zid = if end_zone.truthy() { end_zone.get("id") } else { V::Null };
					let w = resolve_when(&vec![p.clone()].into(), &zid, None, r);
					nw.set(&key, w);
				}
			}
		}
	}
	set_if(&guide, "pitch", h.get("pitch"));
	set_if(&guide, "pros", h.get("pros"));
	set_if(&guide, "cons", h.get("cons"));
	let author_v: V = if h.get("author").truthy() {
		h.get("author")
	} else if let Some(a) = author.filter(|a| !a.is_empty()) {
		a.into()
	} else {
		"Polestar".into()
	};
	guide.set("author", author_v);
	guide.set("version", if !h.get("version").is_undef() { h.get("version") } else { 1.into() });
	let gsteps: V = V::arr();
	guide.set("steps", gsteps.clone());
	guide.set_hidden("_ast", ast.clone());

	// Every zone the guide sets anywhere (header and `zone` directives).
	let mut zones_set: Vec<V> = Vec::new();
	if hz.truthy() {
		zones_set.push(hz.get("id"));
	}
	for s in &steps {
		for g in s.get("goals").items() {
			let z = r.resolve_zone(&g.get("zone"));
			if z.truthy() && !includes(&zones_set, &z.get("id")) {
				zones_set.push(z.get("id"));
			}
		}
	}

	let mut prev = V::Null;
	let mut used_maps: Vec<V> = Vec::new();
	let use_map = |used: &mut Vec<V>, m: V| {
		if let Some(i) = used.iter().position(|x| x.strict_eq(&m)) {
			used.remove(i);
		}
		used.insert(0, m);
	};
	let classes_of = |race: &str, side: &str| data.race_classes(race, side);
	let head_factions: V = if h.get("faction").truthy() { vec![h.get("faction")].into() } else { V::Null };
	let head_layer: V = obj! {
		"factions" => head_factions.clone(),
		"races" => if h.get("races").truthy() { h.get("races") } else { V::Null },
		"classes" => if h.get("classes").truthy() { h.get("classes") } else { V::Null },
	}
	.into();
	struct Setter {
		spec: V,
		only: V,
		who: Vec<String>,
	}
	let setters: Vec<Setter> = steps
		.iter()
		.filter(|s| s.get("zone").truthy())
		.map(|s| Setter { spec: s.get("zone"), only: s.get("only"), who: crate::conditions::character_keys(&[head_layer.clone(), s.get("only")], Some(&classes_of)) })
		.collect();
	let zone_of_others = |r: &mut R, s: &V, g: &V| -> Option<(V, V, usize)> {
		let own = setters.iter().position(|z| z.spec.strict_eq(&g.get("zone")));
		let here = r.resolve_zone(&g.get("zone"));
		let own = own?;
		if !here.truthy() {
			return None;
		}
		for k in crate::conditions::character_keys(&[head_layer.clone(), s.get("only"), g.get("only")], Some(&classes_of)) {
			if setters[own].who.contains(&k) {
				continue;
			}
			let mut spec = if h.get("zone").truthy() { h.get("zone") } else { V::Null };
			for z in &setters {
				if z.spec.get("line").num() > g.get("line").num() {
					break;
				}
				if z.who.contains(&k) {
					spec = z.spec.clone();
				}
			}
			let there = r.resolve_zone(&spec);
			if there.truthy() && !there.get("id").strict_eq(&here.get("id")) {
				return Some((here, there, own));
			}
		}
		None
	};
	let frame_default = (if h.get("coords").truthy() { h.get("coords").to_js_string() } else { "era".to_string() }, !h.get("coords").is_undef());
	let prof_progress: ProfProgress = RefCell::new(Vec::new());
	let levels = if h.get("levels").truthy() { Some((h.get("levels").get("min").num(), h.get("levels").get("max").num())) } else { None };
	for s in &steps {
		let step: V = V::obj();
		set_if(&step, "title", s.get("title"));
		set_if(&step, "note", s.get("tip"));
		let image = s.get("image");
		if image.truthy() {
			let file = image.get("path").to_js_string().replace('/', "\\");
			let img: V = if image.get("w").truthy() { obj! { "file" => file, "w" => image.get("w"), "h" => image.get("h") }.into() } else { obj! { "file" => file }.into() };
			step.set("image", img);
			step.set_hidden("_imageSpec", image.clone());
		}
		set_if(&step, "only", only_of(&s.get("only")));
		let sgoals = s.get("goals").items();
		let zspec = if s.get("zone").truthy() {
			s.get("zone")
		} else if let Some(g0) = sgoals.first().filter(|g| g.truthy()) {
			g0.get("zone")
		} else {
			V::Undef
		};
		let step_zone = r.resolve_zone(&zspec);
		let szid = if step_zone.truthy() { step_zone.get("id") } else { V::Null };
		set_if(&step, "when", resolve_when(&s.get("when"), &szid, levels, r));
		set_if(&step, "label", s.get("label"));
		set_if(&step, "along", s.get("along"));
		if s.get("skipto").truthy() {
			let mut list = Vec::new();
			for k in s.get("skipto").items() {
				let w = resolve_when(&vec![k.get("when")].into(), &szid, None, r);
				list.push(obj! { "to" => k.get("to"), "when" => w.at(0) }.into());
			}
			step.set("skipto", list);
		}
		let step_goals: V = V::arr();
		step.set("goals", step_goals.clone());
		step.set_hidden("_line", s.get("line"));
		step.set_hidden("_only", s.get("only"));
		for g in &sgoals {
			let zone = r.resolve_zone(&g.get("zone"));
			let zone_id = if zone.truthy() { zone.get("id") } else { V::Null };
			let sonly = s.get("only");
			let gonly = g.get("only");
			let sides = sides_for(&[head_factions.clone(), if sonly.truthy() { sonly.get("factions") } else { sonly.clone() }, if gonly.truthy() { gonly.get("factions") } else { gonly.clone() }]);
			let um = used_maps.clone();
			let ctx = Ctx {
				sides,
				used_maps: &um,
				frame: if g.get("frame").truthy() { (g.get("frame").to_js_string(), true) } else { frame_default.clone() },
				layers: vec![head_layer.clone(), sonly.clone(), gonly.clone()],
				prof: Some(&prof_progress),
				zone_id: zone_id.clone(),
				loop_: s.get("loop").truthy(),
			};
			let goal = resolve_goal(g, &zone_id, &prev, r, &ctx);
			goal.set_hidden("_line", g.get("line"));
			goal.set_hidden("_only", if gonly.truthy() { gonly.clone() } else { V::Null });
			step_goals.push(goal.clone());
			if guide.get("category").as_str() == Some("Leveling") && !goal.get("profLine").is_undef() && !goal.get("optional").truthy() {
				let line = goal.get("profLine").num();
				let prog = prof_progress.borrow().iter().find(|(k, _)| *k == line).map(|(_, v)| v.clone());
				let rank = goal.get("profRank").num();
				let ok = prog.as_ref().is_some_and(|p| p.get("target").num() >= rank || (p.get("rank").num() >= 1.0 && rank <= 1.0));
				if !ok {
					let pname = if goal.get("profName").truthy() { goal.get("profName").to_js_string() } else { format!("skill {}", goal.get("profLine")) };
					let prof = format!("{} {}", pname, goal.get("profRank"));
					let title = if goal.get("title").truthy() { goal.get("title").to_js_string() } else { "untitled".into() };
					let tp = if goal.get("profName").truthy() { goal.get("profName").to_js_string() } else { "<Profession>".into() };
					r.warn(
						&g.get("line"),
						format!("quest {} ({}) needs {}, and the guide does not train it before here: characters without it never see this goal", goal.get("quest"), title, prof),
						Some(&format!("make the goal `optional`, or `train {tp}` earlier in the guide")),
					);
				}
			}
			let gmap = goal.get("map");
			if !gmap.is_undef() && !matches!(zone_id, V::Null) && !gmap.strict_eq(&zone_id) && !includes(&zones_set, &gmap) {
				let name = |id: &V| {
					let z = data.zone(id);
					if z.truthy() && z.get("name").truthy() {
						format!("{} ({})", id, z.get("name"))
					} else {
						id.to_js_string()
					}
				};
				r.warn(
					&g.get("line"),
					format!(
						"coordinates on map {}, but this step's zone is {} and the guide never sets zone {}; check the target, or add `zone map {}` if the route really goes there",
						name(&gmap),
						name(&zone_id),
						gmap,
						gmap
					),
					None,
				);
			}
			let other = if g.get("explicitCoords").truthy() && g.get("coordMap").is_undef() { zone_of_others(r, s, g) } else { None };
			if let Some((here, there, own)) = other {
				let o = if setters[own].only.truthy() { setters[own].only.clone() } else { V::obj() };
				let faction: V = if o.get("factions").truthy() { join(&o.get("factions").items(), "/").into() } else { V::Null };
				let who = crate::conditions::who_label(&obj! { "faction" => faction, "races" => o.get("races"), "classes" => o.get("classes") }.into());
				r.warn(
					&g.get("line"),
					format!(
						"coordinates on {}, the zone line {} sets in a step for {} only; the others who see this goal are in {}",
						here.get("name"),
						g.get("zone").get("line"),
						who,
						there.get("name")
					),
					Some(&format!("add `zone {}` to this step (or to the first step after the {} ones), or `map {}` to the goal", there.get("name"), who, there.get("id"))),
				);
			}
			if !matches!(zone_id, V::Null) {
				use_map(&mut used_maps, zone_id.clone());
			}
			if !goal.get("x").is_undef() {
				prev = obj! { "map" => goal.get("map"), "x" => goal.get("x"), "y" => goal.get("y") }.into();
				use_map(&mut used_maps, goal.get("map"));
			}
		}
		if s.get("loop").truthy() {
			apply_loop(&step, s, r);
			if let Some(last) = step.get("goals").items().iter().rev().find(|goal| !goal.get("x").is_undef()) {
				prev = obj! { "map" => last.get("map"), "x" => last.get("x"), "y" => last.get("y") }.into();
			}
		}
		gsteps.push(step);
	}
	if gsteps.items().iter().any(|s| s.get("goals").items().iter().any(|goal| goal.get("group").truthy() && !goal.get("optional").truthy())) {
		guide.set("group", true);
	}
	check_labels(&steps, r);
	check_along_goals(&gsteps.items(), r);
	guide
}

/// Step labels are guide-wide: each names one step; `along until`/`skipto` name a later step, `done` any.
fn check_labels(steps: &[V], r: &mut R) {
	let mut labels: FxHashMap<String, (usize, V)> = FxHashMap::default();
	for (i, s) in steps.iter().enumerate() {
		if !s.get("label").truthy() {
			continue;
		}
		let l = s.get("label").to_js_string();
		if let Some((_, line)) = labels.get(&l) {
			let msg = format!("duplicate label \"{}\" (first at line {})", l, line);
			r.err(&s.get("labelLine"), msg, None);
		} else {
			labels.insert(l, (i, s.get("labelLine")));
		}
	}
	for (i, s) in steps.iter().enumerate() {
		let Some(along) = s.get("along").as_str().map(str::to_string) else { continue };
		match labels.get(&along) {
			None => r.err(&s.get("alongLine"), format!("unknown label \"{along}\""), Some("name it on a later step with `label <name>`")),
			Some((t, line)) if *t <= i => {
				let msg = format!("`along until {along}` must name a later step (the label is on line {line})");
				r.err(&s.get("alongLine"), msg, None);
			}
			_ => {}
		}
	}
	for (i, s) in steps.iter().enumerate() {
		let skipto = s.get("skipto").items();
		for k in &skipto {
			let to = k.get("to").to_js_string();
			match labels.get(&to) {
				None => r.err(&k.get("line"), format!("unknown label \"{to}\""), Some("name it on a later step with `label <name>`")),
				Some((t, line)) if *t <= i => {
					let msg = format!("`skipto {to}` must name a later step (the label is on line {line})");
					r.err(&k.get("line"), msg, None);
				}
				_ => {}
			}
		}
		let preds: Vec<V> = s.get("when").items().into_iter().chain(skipto.iter().map(|k| k.get("when"))).collect();
		for p in preds {
			if p.get("k").as_str() == Some("done") && !labels.contains_key(&p.get("label").to_js_string()) {
				r.err(&p.get("line"), format!("unknown label \"{}\"", p.get("label")), Some("name a step with `label <name>`"));
			}
		}
	}
}

fn on_step_only(goal: &V) -> bool {
	let t = goal.get("t").to_js_string();
	if ON_STEP_ONLY.contains(&t.as_str()) {
		return true;
	}
	if t == "train" {
		return goal.get("skillLine").is_undef();
	}
	(t == "kill" || t == "interact" || t == "use") && goal.get("quest").is_undef()
}

fn check_along_goals(steps: &[V], r: &mut R) {
	for step in steps {
		if !step.get("along").truthy() {
			continue;
		}
		for goal in step.get("goals").items() {
			if !on_step_only(&goal) {
				continue;
			}
			let t = goal.get("t").to_js_string();
			let what = if goal.get("quest").is_undef() && ["kill", "interact", "use"].contains(&t.as_str()) { format!("`{t}` without `quest`") } else { format!("`{t}`") };
			let until = match step.get("along").as_str() {
				Some(a) => format!(" until the step labelled {a}"),
				None => String::new(),
			};
			r.warn(
				&goal.hidden("_line"),
				format!("{what} in an `along` step never checks off: Polestar checks it only on the step the route is on, so it stays listed{until}"),
				Some("put it in a step of its own, or track something the game counts (a quest objective, a bag count)"),
			);
		}
	}
}

/// What an accept of quest `id` (record `q`, or Null) waits on, for the engine.
fn accept_gate(q: &V, id: &V, data: &Data) -> V {
	let out: V = V::obj();
	let bp = crate::prereqs::blocking_prereqs(q, &|p: &V| data.quest(p));
	let all = bp.get("all").items();
	let any = bp.get("any").items();
	if !any.is_empty() {
		out.set("pre", any.clone());
	}
	if !all.is_empty() {
		out.set("preAll", all.clone());
	}
	let closed_by: Vec<V> = crate::prereqs::closed_by_of(id, &data.quests).into_iter().map(V::from).collect();
	if !closed_by.is_empty() {
		out.set("closedBy", closed_by.clone());
	}
	let titles: V = V::obj();
	for p in all.iter().chain(any.iter()).chain(closed_by.iter()) {
		let pq = data.quest(p);
		if pq.truthy() && pq.get("title").truthy() {
			titles.set(&p.to_js_string(), pq.get("title").to_js_string());
		}
	}
	if !titles.is_empty() {
		out.set("preTitles", titles);
	}
	out
}

/// A step's `when` predicates as the engine reads them. `levels`: the guide's (min, max). -> array | Undef
fn resolve_when(list: &V, zone_id: &V, levels: Option<(f64, f64)>, r: &mut R) -> V {
	let data = r.data;
	if !list.truthy() || list.is_empty() {
		return V::Undef;
	}
	let list = list.items();
	let have_quests = non_empty(&data.quests);
	let have_items = non_empty(&data.items);
	let have_zones = non_empty(&data.zones);
	let mut out = Vec::new();
	for p in &list {
		let k = p.get("k").to_js_string();
		let w: V = obj! { "k" => p.get("k") }.into();
		if p.get("neg").truthy() {
			w.set("neg", true);
		}
		let ln = p.get("line");
		match k.as_str() {
			"level" => {
				w.set("op", p.get("op"));
				w.set("n", p.get("n"));
				if p.get("frac").truthy() {
					w.set("frac", p.get("frac"));
				}
			}
			"money" => {
				w.set("op", p.get("op"));
				w.set("n", p.get("n"));
			}
			"onquest" | "complete" | "turnedin" | "available" | "group" => {
				let pq = p.get("q");
				w.set("q", if pq.is_arr() { pq.items().into() } else { pq.clone() });
				let ids = if pq.is_arr() { pq.items() } else { vec![pq.clone()] };
				for id in ids {
					if have_quests && !data.quest(&id).truthy() {
						r.warn(&ln, format!("quest {id} is not in data (new Forever content?)"), None);
					}
				}
				if k == "available" {
					let q = data.quest(&pq);
					if q.truthy() && q.get("minLevel").num() > 0.0 {
						w.set("minLevel", q.get("minLevel").num());
					}
					let gate = accept_gate(&q, &pq, data);
					set_if(&w, "pre", gate.get("pre"));
					set_if(&w, "preAll", gate.get("preAll"));
					set_if(&w, "closedBy", gate.get("closedBy"));
				}
			}
			"has" => {
				w.set("item", p.get("item"));
				w.set("n", p.get("n"));
				if have_items && !data.item(&p.get("item")).truthy() {
					r.warn(&ln, format!("item {} is not in data (new Forever content?)", p.get("item")), None);
				}
			}
			"upgrade" => {
				w.set("item", p.get("item"));
				if have_items && !data.item(&p.get("item")).truthy() {
					r.warn(&ln, format!("item {} is not in data (new Forever content?)", p.get("item")), None);
				}
			}
			"zone" => {
				w.set("name", p.get("name"));
				let found = data.zone_named(&p.get("name").to_js_string());
				if found.truthy() && found.get("zone").get("areaId").truthy() {
					w.set("area", found.get("zone").get("areaId").num());
				} else if !found.truthy() && have_zones {
					r.warn(
						&ln,
						format!("zone \"{}\" is not in zones.json: the game never reports that zone name, so the predicate never holds there", p.get("name")),
						Some("write the zone as the game names it (`polestar find --kind zone <text>`)"),
					);
				}
			}
			"subzone" => {
				w.set("name", p.get("name"));
				let z = if !zone_id.is_nullish() { data.zone(zone_id) } else { V::Null };
				let zarea = if z.truthy() { z.get("areaId") } else { z.clone() };
				let area = crate::areas::area_named(&data.areas, &p.get("name"), &zarea);
				if area.truthy() {
					w.set("area", area.get("id"));
				} else if data.areas.truthy() {
					let inz = if z.truthy() && z.get("name").truthy() { format!(" in {}", z.get("name")) } else { String::new() };
					r.warn(&ln, format!("subzone \"{}\" names no single area{}: the predicate compares the subzone text as written, in English only", p.get("name"), inz), None);
				}
			}
			"done" => {
				w.set("label", p.get("label"));
			}
			"skill" => {
				let prof = data.profession_named(&p.get("name").to_js_string());
				w.set("name", if prof.truthy() { prof.get("name").to_js_string().into() } else { p.get("name") });
				if prof.truthy() {
					w.set("skillLine", prof.get("id"));
				} else {
					r.warn(&ln, format!("profession \"{}\" is not in data: the predicate reads the skill by that name, in English only", p.get("name")), None);
				}
				w.set("n", p.get("n"));
			}
			"cooldown" => {
				if p.get("item").truthy() {
					w.set("item", p.get("item"));
					if have_items && !data.item(&p.get("item")).truthy() {
						r.warn(&ln, format!("item {} is not in data (new Forever content?)", p.get("item")), None);
					}
				} else {
					w.set("spell", p.get("spell"));
				}
			}
			"dungeon" => {
				w.set("name", p.get("name"));
				let run = crate::group::dungeon_named(data, &p.get("name"));
				if run.truthy() {
					w.set("map", run.get("map"));
				} else if data.instances.truthy() {
					r.warn(
						&ln,
						format!(
							"dungeon \"{}\" is not a dungeon in the client's instance tables: no character can choose it, so `when dungeon` never holds and `when !dungeon` always does",
							p.get("name")
						),
						Some("write the dungeon as the game names it, as the guide window's \"Dungeon:\" line shows it (\"Ragefire Chasm\")"),
					);
				}
			}
			_ => {
				// bound
				w.set("name", p.get("name"));
				let bad = crate::places::check_location(data, "sethome", &p.get("name"));
				if bad.truthy() {
					let m = bad.get("message").to_js_string();
					let m = match m.strip_prefix("sethome") {
						Some(rest) => format!("bound{rest}"),
						None => m,
					};
					r.warn(&ln, m, hint_of(&bad.get("hint")));
				}
				let area = crate::areas::area_named(&data.areas, &p.get("name"), &V::Undef);
				if area.truthy() {
					w.set("area", area.get("id"));
				}
			}
		}
		out.push(w);
	}
	let lv: Vec<&V> = list.iter().filter(|p| p.get("k").as_str() == Some("level")).collect();
	if let (false, Some((l0, l1))) = (lv.is_empty(), levels) {
		let (mut lo, mut hi) = (l0, l1);
		for p in &lv {
			let (a, b) = crate::when::level_range(p);
			lo = lo.max(a);
			hi = hi.min(b);
		}
		if lo > hi {
			r.warn(&lv[lv.len() - 1].get("line"), format!("the step's `when level` never holds for this guide's levels ({}-{}): no character sees the step", num_str(l0), num_str(l1)), None);
		}
	}
	let keys: Vec<String> = list
		.iter()
		.map(|p| {
			let o = p.as_obj().map(|o| o.spread()).unwrap_or_default();
			o.set("neg", V::Undef);
			o.set("line", V::Undef);
			stringify(&o.into(), None)
		})
		.collect();
	for (i, p) in list.iter().enumerate() {
		let k = p.get("k").to_js_string();
		if k != "level" && list.iter().enumerate().any(|(j, o)| j != i && o.get("neg").truthy() != p.get("neg").truthy() && keys[j] == keys[i]) {
			let what = match k.as_str() {
				"has" | "upgrade" => "item",
				"onquest" | "complete" | "turnedin" | "available" | "group" => "quest",
				"dungeon" => "dungeon",
				"done" => "step",
				"skill" => "profession and rank",
				"cooldown" => {
					if p.get("item").truthy() {
						"item"
					} else {
						"spell"
					}
				}
				_ => "place",
			};
			r.warn(&p.get("line"), format!("the step asks for `{k}` and `!{k}` of the same {what}: no character sees it"), None);
			break;
		}
	}
	out.into()
}

fn objective_for(q: &V, kind: Option<&str>, id: &V) -> Option<usize> {
	if !q.truthy() || !q.get("objectives").is_arr() {
		return None;
	}
	q.get("objectives").items().iter().position(|o| o.truthy() && o.get("id").strict_eq(id) && kind.is_none_or(|k| o.get("type").as_str() == Some(k))).map(|i| i + 1)
}

/// Documented categories are matched case-insensitively; others pass through with a warning.
fn canonical_category(raw: &V, ast: &V, r: &mut R) -> V {
	if raw.is_undef() {
		return "Leveling".into();
	}
	let lower = raw.to_js_string().to_lowercase();
	if let Some(known) = CATEGORIES.iter().find(|c| c.to_lowercase() == lower) {
		return (*known).into();
	}
	r.warn(&ast.get("lines").get("category"), format!("unknown category \"{}\" (known: {})", raw, CATEGORIES.join(", ")), None);
	raw.clone()
}

/// Factions a smart goal serves: the goal's factions, narrowed by the races it can apply to.
fn smart_sides(sides: &V, chars: &V) -> V {
	let from_races: Vec<V> = chars.get("races").items().iter().flat_map(|r| crate::conditions::race_sides(&r.to_js_string())).map(V::from).collect();
	let narrowed: Vec<V> = sides.items().into_iter().filter(|s| includes(&from_races, s)).collect();
	if narrowed.is_empty() {
		sides.items().into()
	} else {
		narrowed.into()
	}
}

fn progress_of(ctx: &Ctx, skill_line: &V) -> V {
	let Some(prof) = ctx.prof else {
		return obj! { "target" => V::Undef, "rank" => 0 }.into();
	};
	let key = skill_line.num();
	let same = |k: f64| k == key || (k.is_nan() && key.is_nan());
	if let Some((_, v)) = prof.borrow().iter().find(|(k, _)| same(*k)) {
		return v.clone();
	}
	let v: V = obj! { "target" => V::Undef, "rank" => 0 }.into();
	prof.borrow_mut().push((key, v.clone()));
	v
}

/// Factions a goal can apply to, from the guide faction and step/goal conditions.
fn sides_for(lists: &[V]) -> V {
	let mut sides: Vec<V> = vec!["Alliance".into(), "Horde".into()];
	for l in lists {
		if l.truthy() {
			let li = l.items();
			sides.retain(|s| includes(&li, s));
		}
	}
	sides.into()
}

/// What smart targets need from the goal being resolved.
struct Smart<'a> {
	ctx: &'a Ctx<'a>,
	prev: &'a V,
	v: &'a str,
	ln: &'a V,
}

/// Smart targets: a candidate set the engine chooses from at runtime.
fn smart(sm: &Smart, r: &mut R, target: &V, entries: &[V], what: &str) {
	let data = r.data;
	let chars = crate::conditions::applicable(&sm.ctx.layers);
	let sides = smart_sides(&sm.ctx.sides, &chars);
	let ref_: V = if sm.prev.truthy() {
		sm.prev.clone()
	} else if !sm.ctx.zone_id.is_nullish() {
		obj! { "map" => sm.ctx.zone_id.clone(), "x" => 50, "y" => 50 }.into()
	} else {
		V::Null
	};
	let built = crate::candidates::build_candidates(data, entries, &obj! { "sides" => sides.clone(), "ref" => ref_ }.into());
	let cands = built.get("candidates");
	let side_list = sides.items();
	if cands.is_empty() {
		r.err(sm.ln, format!("`{}` found no {} in data for {} characters; name one with an npc id instead", sm.v, what, join(&side_list, " or ")), None);
		return;
	}
	target.set("candidates", cands.clone());
	for s in &side_list {
		if !built.get("coverage").get(&s.to_js_string()).truthy() {
			r.warn(sm.ln, format!("no {what} for {s} in data, but this goal applies to {s} characters"), None);
		}
	}
	if target.get("class").truthy() {
		for s in &side_list {
			let ss = s.to_js_string();
			for c in chars.get("classes").items() {
				let cs = c.to_js_string();
				let possible = chars.get("races").items().iter().any(|rc| includes(&data.race_classes(&rc.to_js_string(), &ss).items(), &c));
				if !possible {
					continue;
				}
				let tag = if ss == "Alliance" { "A" } else { "H" };
				let has = cands.items().iter().any(|cand| {
					let f = cand.get("faction");
					(f.as_str() == Some(tag) || f.as_str() == Some("AH")) && includes(&cand.get("classes").items(), &c)
				});
				if !has {
					let mut ch = cs.chars();
					let first: String = ch.next().map(|x| x.to_string()).unwrap_or_else(|| "undefined".into());
					let rest: String = ch.as_str().to_lowercase();
					r.warn(sm.ln, format!("no {first}{rest} trainer for {s} in data (trainers.json)"), None);
				}
			}
		}
	}
}

/// `entries.push({ npc: Number(id), side })` for each side's ids, sides sorted.
fn add_sides(entries: &mut Vec<V>, by_side: &V, tag_of: impl Fn(&str) -> V) {
	let mut sides = if by_side.truthy() { by_side.keys() } else { Vec::new() };
	sides.sort_by(|a, b| cmp_utf16(a, b));
	for side in sides {
		let ids = by_side.get(&side);
		for id in if ids.is_arr() { ids.items() } else { Vec::new() } {
			entries.push(obj! { "npc" => id.num(), "side" => tag_of(&side) }.into());
		}
	}
}

/// `train <Profession> [Rank]`.
fn train_profession(g: &V, goal: &V, r: &mut R, sm: &Smart) {
	let data = r.data;
	let ln = g.get("line");
	let p = data.profession_named(&g.get("profession").to_js_string());
	if !p.truthy() {
		r.err(&ln, format!("unknown profession \"{}\" (write `train <Profession> [Apprentice|Journeyman|Expert|Artisan]`, `train class` or `train <npcId>`)", g.get("profession")), None);
		return;
	}
	let fp = data.profession(&p.get("id"));
	let full = if fp.truthy() { fp } else { p.clone() };
	let ranks: Vec<V> = if full.get("ranks").is_arr() { full.get("ranks").items() } else { Vec::new() };
	let rank_at = |r: f64| -> V {
		if r >= 1.0 && is_integer(r) {
			ranks.get(r as usize - 1).cloned().unwrap_or_default()
		} else {
			V::Undef
		}
	};
	let const_at = |a: &[f64; 4], r: f64| -> Option<f64> {
		if r >= 1.0 && is_integer(r) {
			a.get(r as usize - 1).copied()
		} else {
			None
		}
	};
	let name_at = |r: f64| -> String {
		if r >= 1.0 && is_integer(r) {
			RANK_NAMES.get(r as usize - 1).map(|s| s.to_string()).unwrap_or_else(|| "undefined".into())
		} else {
			"undefined".into()
		}
	};
	let min_skill = |r: f64| -> f64 {
		let rk = rank_at(r);
		if rk.truthy() && rk.get("minSkill").num().is_finite() {
			rk.get("minSkill").num()
		} else {
			const_at(&RANK_MIN_SKILL, r).unwrap_or(f64::NAN)
		}
	};
	let prog = progress_of(sm.ctx, &p.get("id"));
	let mut rank = g.get("rank").num();
	if g.get("rank").is_undef() {
		rank = 1.0;
		let target = prog.get("target");
		if !target.is_undef() {
			for rr in (1..=4).rev() {
				if min_skill(rr as f64) <= target.num() {
					rank = rr as f64;
					break;
				}
			}
		}
		if rank <= prog.get("rank").num() {
			rank = prog.get("rank").num() + 1.0;
		}
		if rank > 4.0 {
			r.err(&ln, format!("`train {}`: Artisan is already trained earlier in this guide", p.get("name")), None);
			return;
		}
		let have = if target.is_undef() { 0.0 } else { target.num() };
		if min_skill(rank) > have {
			let ms = num_str(min_skill(rank));
			r.warn(
				&ln,
				format!(
					"`train {}` means {} here (needs skill {}), but no earlier `skill {}` target reaches {}; name the rank or add the skill goal",
					p.get("name"),
					name_at(rank),
					ms,
					p.get("name"),
					ms
				),
				None,
			);
		}
	}
	goal.set("skill", p.get("name").to_js_string());
	goal.set("skillLine", p.get("id"));
	goal.set("rank", if g.get("rank").is_undef() { V::Num(rank) } else { g.get("rank") });
	let rk = rank_at(rank);
	let rank_max: V = if rk.truthy() && rk.get("max").num() > 0.0 { rk.get("max").num().into() } else { const_at(&RANK_CAPS, rank).into() };
	goal.set("rankMax", rank_max);
	prog.set("rank", prog.get("rank").num().max(rank));
	if !g.get("npc").is_undef() {
		return;
	}
	let rk = if rk.truthy() { rk } else { V::obj() };
	let mut entries = Vec::new();
	let tag = |side: &str| -> V {
		match side {
			"Alliance" | "A" => "A".into(),
			"Horde" | "H" => "H".into(),
			_ => V::Undef,
		}
	};
	let pname = p.get("name").to_js_string();
	let rname = name_at(rank);
	let mut what = format!("{pname} {rname} trainer");
	if rk.get("trainers").truthy() {
		add_sides(&mut entries, &rk.get("trainers"), tag);
	} else if rk.get("book").truthy() && rk.get("book").get("vendors").truthy() {
		add_sides(&mut entries, &rk.get("book").get("vendors"), tag);
		what = format!("vendor of the {pname} {rname} book");
	} else if rk.get("quest").truthy() && rk.get("quest").get("npcs").truthy() {
		add_sides(&mut entries, &rk.get("quest").get("npcs"), tag);
		what = format!("{pname} {rname} quest giver");
	} else {
		add_sides(&mut entries, &full.get("trainers"), tag);
	}
	let what = format!("{}{}", what, if data.has_professions { "" } else { " (professions.json missing)" });
	smart(sm, r, goal, &entries, &what);
}

fn cand(kind: &str, id: V) -> V {
	obj! { "kind" => kind, "id" => id }.into()
}

/// `label.replace(/^(\S+) = /, 'quest $1 is ')`.
fn quest_is(label: &str) -> String {
	let end = label.find(char::is_whitespace).unwrap_or(label.len());
	if end > 0 && label[end..].starts_with(" = ") {
		format!("quest {} is {}", &label[..end], &label[end + 3..])
	} else {
		label.to_string()
	}
}

fn resolve_goal(g: &V, zone_map: &V, prev: &V, r: &mut R, ctx: &Ctx) -> V {
	let data = r.data;
	let ln = g.get("line");
	let v = g.get("verb").to_js_string();
	let v = v.as_str();
	let goal: V = obj! { "t" => v }.into();
	let mut candidates: Vec<V> = Vec::new();
	let mut check_kinds: Option<Vec<V>> = None;
	let mut quest_fields = false;
	let mut pass_rares = false;
	let mut drop_level = f64::NAN;
	let sm = Smart { ctx, prev, v, ln: &ln };

	let known_of = |kind: &str, id: &V| match kind {
		"npc" => data.npc(id),
		"object" => data.object(id),
		_ => data.item(id),
	};
	let require_name = |r: &mut R, kind: &str, id: &V, explicit: &V, label: &str| -> V {
		let name: V = if explicit.truthy() { explicit.clone() } else { opt_str(name_of(data, kind, id)) };
		let known = known_of(kind, id);
		if !name.truthy() {
			r.err(&ln, format!("{kind} {id} is not in data; give its name: `{v} {id} \"{label}\"`"), Some(FIND_ID_HINT));
		} else if !known.truthy() {
			r.warn(&ln, format!("{kind} {id} is not in data; using the explicit name (new Forever content?)"), None);
		}
		name
	};
	let optional_name = |r: &mut R, kind: &str, id: &V| -> V {
		let name = opt_str(name_of(data, kind, id));
		if !known_of(kind, id).truthy() {
			r.warn(&ln, format!("{kind} {id} is not in data; its name and position cannot be filled"), None);
		}
		name
	};
	let place_warning = |r: &mut R, verb: &str, location: &V| {
		let bad = crate::places::check_location(data, verb, location);
		if bad.truthy() {
			r.warn(&ln, bad.get("message").to_js_string(), hint_of(&bad.get("hint")));
		}
	};
	let npcs = |role: &str| -> Vec<V> { data.npcs_with_role(role).into_iter().map(|id| obj! { "npc" => id }.into()).collect() };
	let vendors_of = |it: &V| -> Vec<V> {
		if it.truthy() && it.get("vendors").truthy() {
			it.get("vendors").items()
		} else {
			Vec::new()
		}
	};

	'sw: {
		match v {
			"accept" | "turnin" | "complete" | "abandon" => {
				let q = data.quest(&g.get("quest"));
				goal.set("quest", g.get("quest"));
				let title: V = if g.get("title").truthy() {
					g.get("title")
				} else if q.truthy() && q.get("title").truthy() {
					q.get("title").to_js_string().into()
				} else {
					V::Null
				};
				if !title.truthy() {
					r.err(&ln, format!("quest {} is not in data; give its title: `{} {} \"Title\"`", g.get("quest"), v, g.get("quest")), Some(FIND_ID_HINT));
				} else if !q.truthy() {
					r.warn(&ln, format!("quest {} is not in data; using the explicit title (new Forever content?)", g.get("quest")), None);
				}
				goal.set("title", or_undef(title));
				if v == "complete" || v == "abandon" {
					break 'sw;
				}
				let ends = if !q.truthy() {
					q.clone()
				} else if v == "accept" {
					q.get("start")
				} else {
					q.get("end")
				};
				if !g.get("npc").is_undef() {
					candidates = vec![cand("npc", g.get("npc"))];
					optional_name(r, "npc", &g.get("npc"));
				} else if !g.get("object").is_undef() {
					candidates = vec![cand("object", g.get("object"))];
					optional_name(r, "object", &g.get("object"));
				} else if !g.get("item").is_undef() {
					goal.set("item", g.get("item"));
					set_if(&goal, "itemName", optional_name(r, "item", &g.get("item")));
				} else if ends.truthy() {
					for id in ends.get("npc").items() {
						candidates.push(cand("npc", id));
					}
					for id in ends.get("object").items() {
						candidates.push(cand("object", id));
					}
					if candidates.is_empty() && v == "accept" && ends.get("item").truthy() && !ends.get("item").is_empty() {
						goal.set("item", ends.get("item").at(0));
						set_if(&goal, "itemName", opt_str(name_of(data, "item", &goal.get("item"))));
					}
				}
				if v == "accept" {
					let ml = if !g.get("minLevel").is_undef() {
						g.get("minLevel")
					} else if q.truthy() && q.get("minLevel").num() > 0.0 {
						q.get("minLevel")
					} else {
						V::Undef
					};
					set_if(&goal, "minLevel", ml);
					if q.truthy() && q.get("level").num() > 0.0 {
						goal.set("qlvl", q.get("level").num());
					}
					for (k, val) in accept_gate(&q, &goal.get("quest"), data).entries() {
						goal.set(&k, val);
					}
				}
				if v == "turnin" {
					let rewards: V = V::obj();
					let entries = |r: &mut R, list: &V| -> V {
						let mut out_list = Vec::new();
						for it in list.items() {
							let known = data.item(&it.get("item"));
							let out: V = obj! { "item" => it.get("item") }.into();
							let name: V = if it.get("itemName").truthy() {
								it.get("itemName")
							} else if known.truthy() && known.get("name").truthy() {
								known.get("name").to_js_string().into()
							} else {
								V::Null
							};
							if !name.truthy() {
								r.err(&ln, format!("reward item {} is not in data; give its name: `{} \"Item name\"`", it.get("item"), it.get("item")), Some(FIND_ID_HINT));
							} else {
								out.set("itemName", name);
							}
							let kq = known.get("quality");
							let quality = if !it.get("quality").is_undef() {
								it.get("quality")
							} else if known.truthy() && kq.as_num().is_some_and(is_integer) {
								kq
							} else {
								V::Undef
							};
							set_if(&out, "quality", quality);
							out_list.push(out);
						}
						out_list.into()
					};
					if g.get("rewardItems").truthy() {
						rewards.set("items", entries(r, &g.get("rewardItems")));
					}
					if g.get("rewardChoices").truthy() {
						rewards.set("choices", entries(r, &g.get("rewardChoices")));
					}
					if !g.get("rewardXp").is_undef() {
						rewards.set("xp", g.get("rewardXp"));
					}
					if !g.get("rewardMoney").is_undef() {
						rewards.set("money", g.get("rewardMoney"));
					}
					if !rewards.is_empty() {
						goal.set("rewards", rewards);
					}
				}
				check_kinds = Some(candidates.clone());
			}
			"kill" => {
				if !g.get("npc").is_undef() {
					goal.set("target", or_undef(require_name(r, "npc", &g.get("npc"), &g.get("target"), "Target name")));
					goal.set("npc", g.get("npc"));
					candidates = vec![cand("npc", g.get("npc"))];
				} else {
					goal.set("target", g.get("target"));
				}
				quest_fields = true;
				check_kinds = Some(candidates.clone());
			}
			"collect" => {
				goal.set("item", g.get("item"));
				goal.set("itemName", or_undef(require_name(r, "item", &g.get("item"), &g.get("itemName"), "Item name")));
				let it = data.item(&g.get("item"));
				let mut sources: Vec<V> = Vec::new();
				if it.truthy() && it.get("drops").truthy() {
					for kind in ["npc", "object"] {
						for (id, chance) in it.get("drops").get(kind).entries() {
							let ch = chance.num();
							let ch = if ch != 0.0 && !ch.is_nan() { ch } else { 0.0 };
							sources.push(obj! { "kind" => kind, "id" => crate::js::str_to_num(&id), "chance" => ch }.into());
						}
					}
				}
				sources.sort_by(|a, b| {
					let d = num(b, "chance") - num(a, "chance");
					let tie = if a.get("kind").strict_eq(&b.get("kind")) {
						num(a, "id") - num(b, "id")
					} else if a.get("kind").as_str() == Some("npc") {
						-1.0
					} else {
						1.0
					};
					ord(jor(d, tie))
				});
				if g.get("nearest").truthy() {
					if !g.get("quest").is_undef() {
						r.err(&ln, "`collect … nearest` farms by bag count; drop `quest` (quest objectives use the quest’s own targets)", None);
					}
					if g.get("count").is_undef() {
						r.err(&ln, "`collect … nearest` needs a count: `collect <item> xN nearest`", None);
					}
					let chars = crate::conditions::applicable(&ctx.layers);
					let sides = smart_sides(&ctx.sides, &chars).items();
					let fits = |sp: &V, s: &V| {
						let f = sp.get("faction");
						f.as_str() == Some("AH") || f.as_str() == Some(if s.as_str() == Some("Alliance") { "A" } else { "H" })
					};
					let spots: Vec<V> = crate::farmspots::farm_spots(data, &g.get("item")).items().into_iter().filter(|sp| sides.iter().any(|s| fits(sp, s))).collect();
					if spots.is_empty() {
						r.err(
							&ln,
							format!(
								"`collect {} nearest` found no farm spot (normal mobs dropping it at 2% or more, outside towns) for {} characters; give @x,y or a gathering step instead",
								g.get("item"),
								join(&sides, " or ")
							),
							None,
						);
					} else {
						goal.set("candidates", spots.clone());
						for s in &sides {
							if !spots.iter().any(|sp| fits(sp, s)) {
								r.warn(&ln, format!("no farm spot for item {} that is safe for {}, but this goal applies to {} characters", g.get("item"), s, s), None);
							}
						}
					}
					break 'sw;
				}
				if !g.get("npc").is_undef() {
					goal.set("npc", g.get("npc"));
					set_if(&goal, "npcName", optional_name(r, "npc", &g.get("npc")));
					candidates = vec![cand("npc", g.get("npc"))];
					check_kinds = Some(candidates.clone());
					quest_fields = true;
					break 'sw;
				}
				candidates = sources.iter().filter(|s| !data.spawns(&s.get("kind").to_js_string(), &s.get("id")).is_empty()).cloned().collect();
				if candidates.is_empty() && !g.get("quest").is_undef() && it.truthy() && it.get("questItem").truthy() {
					let handover: Vec<V> = vendors_of(&it).iter().map(|id| cand("npc", id.num().into())).filter(|h| !data.spawns("npc", &h.get("id")).is_empty()).collect();
					let first = handover.first().cloned().unwrap_or_default();
					set_if(&goal, "fromNpcs", source_npcs(data, &first, &handover));
				}
				let widespread = candidates.iter().filter(|s| num(s, "chance") >= 2.0).count() > MAX_NAMED_SOURCES;
				pass_rares = !widespread && rare_leads(data, &candidates, &ctx.sides);
				let q = if !g.get("quest").is_undef() { data.quest(&g.get("quest")) } else { V::Null };
				if q.truthy() && q.get("level").num() > 0.0 {
					drop_level = q.get("level").num();
				}
				let split = elite_split(data, &candidates, &ctx.sides, pass_rares);
				let normal = match &split {
					Some((n, _)) => n.clone(),
					None => candidates.clone(),
				};
				let named = match level_split(data, &normal, drop_level) {
					Some((near, _)) => near,
					None => normal,
				};
				if !widespread && !named.is_empty() && (candidates.len() == 1 || num(&named[0], "chance") >= 50.0) {
					let top = &named[0];
					let rec = if top.get("kind").as_str() == Some("npc") { data.npc(&top.get("id")) } else { data.object(&top.get("id")) };
					if rec.truthy() && rec.get("name").truthy() {
						goal.set("from", rec.get("name").to_js_string());
						goal.set("fromId", top.get("id"));
						goal.set("fromKind", top.get("kind"));
						if top.get("kind").as_str() == Some("npc") {
							if rec.get("rank").num() > 0.0 {
								goal.set("fromRank", rec.get("rank").num());
							}
							if rec.get("faction").as_str().is_some_and(|f| ["A", "H", "AH"].contains(&f)) {
								goal.set("fromFaction", rec.get("faction"));
							}
						}
						if let Some(next) = named.get(1) {
							if next.get("kind").strict_eq(&top.get("kind")) && num(next, "chance") >= 50.0 {
								let nrec = if next.get("kind").as_str() == Some("npc") { data.npc(&next.get("id")) } else { data.object(&next.get("id")) };
								if nrec.truthy() && nrec.get("name").truthy() && nrec.get("name").to_js_string() != goal.get("from").to_js_string() {
									goal.set("fromAlso", nrec.get("name").to_js_string());
									goal.set("fromAlsoId", next.get("id"));
								}
							}
						}
					}
				}
				check_kinds = Some(sources.iter().filter(|s| num(s, "chance") >= 2.0 || gather_node(data, s)).cloned().collect());
				quest_fields = true;
			}
			"interact" => {
				goal.set("object", g.get("object"));
				goal.set("objName", or_undef(require_name(r, "object", &g.get("object"), &g.get("objName"), "Object name")));
				candidates = vec![cand("object", g.get("object"))];
				check_kinds = Some(candidates.clone());
				quest_fields = true;
			}
			"use" => {
				goal.set("item", g.get("item"));
				goal.set("itemName", or_undef(require_name(r, "item", &g.get("item"), &g.get("itemName"), "Item name")));
				quest_fields = true;
			}
			"destroy" => {
				goal.set("item", g.get("item"));
				goal.set("itemName", or_undef(require_name(r, "item", &g.get("item"), &g.get("itemName"), "Item name")));
			}
			"talk" => {
				goal.set("npc", g.get("npc"));
				goal.set("npcName", or_undef(require_name(r, "npc", &g.get("npc"), &g.get("npcName"), "NPC name")));
				candidates = vec![cand("npc", g.get("npc"))];
				check_kinds = Some(candidates.clone());
			}
			"sethome" | "getfp" | "train" | "vendor" => {
				let loc = g.get("location");
				if !loc.is_undef() {
					goal.set("location", loc.clone());
				}
				if !loc.is_undef() && (v == "sethome" || v == "getfp") {
					place_warning(r, v, &loc);
				}
				if v == "train" && !g.get("profession").is_undef() {
					train_profession(g, &goal, r, &sm);
				}
				if v == "train" && g.get("classTrain").truthy() {
					goal.set("class", true);
					let set = crate::conditions::applicable(&ctx.layers);
					let set_classes = set.get("classes").items();
					let entries: Vec<V> = data
						.class_trainers()
						.items()
						.iter()
						.map(|t| {
							let classes: Vec<V> = t.get("classes").items().into_iter().filter(|c| includes(&set_classes, c)).collect();
							obj! { "npc" => t.get("id"), "classes" => classes }.into()
						})
						.filter(|e: &V| !e.get("classes").is_empty())
						.collect();
					smart(&sm, r, &goal, &entries, "class trainer");
				}
				if g.get("nearest").truthy() && v == "sethome" {
					smart(&sm, r, &goal, &npcs("innkeeper"), "innkeeper");
				}
				if (v == "sethome" || v == "getfp") && g.get("npc").is_undef() && !g.get("nearest").truthy() {
					let sides = smart_sides(&ctx.sides, &crate::conditions::applicable(&ctx.layers));
					let host = if v == "sethome" { crate::places::goal_innkeeper(data, &loc, &sides) } else { crate::places::goal_flight_master(data, &loc, &sides) };
					if host.truthy() {
						goal.set("npc", host.get("npc"));
						let nm: V = match name_of(data, "npc", &host.get("npc")) {
							Some(n) => n.into(),
							None => or_undef(host.get("npcName")),
						};
						set_if(&goal, "npcName", nm);
						candidates = vec![cand("npc", host.get("npc"))];
						check_kinds = Some(candidates.clone());
					}
				}
				if g.get("nearest").truthy() && v == "vendor" {
					smart(&sm, r, &goal, &npcs("repair"), "repair vendor");
				}
				if !g.get("npc").is_undef() {
					goal.set("npc", g.get("npc"));
					if g.get("npcName").truthy() {
						goal.set("npcName", g.get("npcName"));
						if !data.npc(&g.get("npc")).truthy() {
							r.warn(&ln, format!("npc {} is not in data; using the explicit name (new Forever content?)", g.get("npc")), None);
						}
					} else if (v == "train" || v == "vendor") && !g.get("npcExplicit").truthy() {
						set_if(&goal, "npcName", require_name(r, "npc", &g.get("npc"), &V::Null, "NPC name"));
					} else {
						set_if(&goal, "npcName", optional_name(r, "npc", &g.get("npc")));
					}
					candidates = vec![cand("npc", g.get("npc"))];
					check_kinds = Some(candidates.clone());
				}
			}
			"hearth" | "fly" => {
				goal.set("location", g.get("location"));
				place_warning(r, v, &g.get("location"));
			}
			"die" => {
				goal.set("location", g.get("location"));
				if !g.get("explicitCoords").truthy() {
					r.err(&ln, "`die` needs @x,y at the graveyard's Spirit Healer", None);
				}
				candidates = data.npcs_with_role("spirithealer").into_iter().map(|id| cand("npc", id.into())).collect();
				check_kinds = Some(candidates.clone());
			}
			"enter" => {
				goal.set("location", g.get("location"));
				let loc = g.get("location").to_js_string();
				if data.areas.truthy() && !data.zone_named(&loc).truthy() && !data.areas.get("byName").has(&loc.trim().to_lowercase()) {
					r.warn(
						&ln,
						format!("enter \"{loc}\": no zone or area has that name; the game never reports it, so the goal never checks off by itself"),
						Some("write the place as the game names it (`polestar find --kind zone <text>`)"),
					);
				}
			}
			"buy" => {
				goal.set("item", g.get("item"));
				goal.set("itemName", or_undef(require_name(r, "item", &g.get("item"), &g.get("itemName"), "Item name")));
				if !g.get("count").is_undef() {
					goal.set("count", g.get("count"));
				}
				if !g.get("npc").is_undef() {
					optional_name(r, "npc", &g.get("npc"));
					candidates = vec![cand("npc", g.get("npc"))];
				} else if g.get("nearest").truthy() {
					let it = data.item(&g.get("item"));
					let entries: Vec<V> = vendors_of(&it).iter().map(|id| obj! { "npc" => id.num() }.into()).collect();
					smart(&sm, r, &goal, &entries, &format!("vendor of item {}", g.get("item")));
				} else {
					let it = data.item(&g.get("item"));
					let mut ids = vendors_of(&it);
					ids.sort_by(|a, b| ord(a.num() - b.num()));
					candidates = ids.into_iter().map(|id| cand("npc", id)).collect();
				}
				check_kinds = Some(candidates.clone());
			}
			"level" => {
				goal.set("level", g.get("level"));
				if g.get("frac").truthy() {
					goal.set("frac", g.get("frac"));
				}
			}
			"money" => {
				goal.set("money", g.get("money"));
			}
			"wait" => {
				goal.set("seconds", g.get("seconds"));
			}
			"note" | "task" | "goto" => {}
			"skill" => {
				let p = data.profession_named(&g.get("skill").to_js_string());
				if p.truthy() {
					goal.set("skill", p.get("name").to_js_string());
					goal.set("skillLine", p.get("id"));
				} else if g.get("skillQuoted").truthy() {
					goal.set("skill", g.get("skill"));
					r.warn(
						&ln,
						format!(
							"profession \"{}\" is not in data{}; using the explicit name (new Forever content?)",
							g.get("skill"),
							if data.has_professions { "" } else { " (professions.json missing)" }
						),
						None,
					);
				} else {
					r.err(&ln, format!("unknown profession \"{}\"; quote the name to use it anyway: `skill \"{}\" {}`", g.get("skill"), g.get("skill"), g.get("level")), None);
				}
				goal.set("level", g.get("level"));
				if !goal.get("skillLine").is_undef() {
					progress_of(ctx, &goal.get("skillLine")).set("target", g.get("level"));
				}
			}
			"cast" => {
				let found = data.recipe(&g.get("spell"));
				let name: V = if g.get("spellName").truthy() {
					g.get("spellName")
				} else if found.truthy() && found.get("recipe").get("name").truthy() {
					found.get("recipe").get("name").to_js_string().into()
				} else {
					V::Null
				};
				if !name.truthy() {
					r.err(&ln, format!("spell {} is not in data; give its name: `cast {} \"Name\"`", g.get("spell"), g.get("spell")), None);
				}
				goal.set("spell", g.get("spell"));
				goal.set("spellName", or_undef(name));
			}
			"learn" | "craft" => {
				let found = data.recipe(&g.get("spell"));
				let rc = if found.truthy() { found.get("recipe") } else { V::Null };
				let where_ = if data.has_professions { "" } else { " (professions.json missing)" };
				goal.set("spell", g.get("spell"));
				let name: V = if g.get("spellName").truthy() {
					g.get("spellName")
				} else if rc.truthy() && rc.get("name").truthy() {
					rc.get("name").to_js_string().into()
				} else {
					V::Null
				};
				if !name.truthy() {
					r.err(&ln, format!("spell {} is not in data{}; give its name: `{} {} \"Name\"`", g.get("spell"), where_, v, g.get("spell")), None);
				} else if !found.truthy() {
					r.warn(&ln, format!("spell {} is not in data{}; using the explicit name (new Forever content?)", g.get("spell"), where_), None);
				}
				goal.set("spellName", or_undef(name));
				if found.truthy() {
					goal.set("skillLine", found.get("profession").get("id"));
				}
				if v == "learn" {
					let recipe_item: V = if !g.get("item").is_undef() {
						g.get("item")
					} else if rc.truthy() && rc.get("recipeItem").num() > 0.0 {
						rc.get("recipeItem").num().into()
					} else {
						V::Undef
					};
					if !recipe_item.is_undef() {
						goal.set("item", recipe_item.clone());
						let nm = if !g.get("item").is_undef() { optional_name(r, "item", &recipe_item) } else { opt_str(name_of(data, "item", &recipe_item)) };
						set_if(&goal, "itemName", nm);
					}
					if !g.get("npc").is_undef() {
						goal.set("npc", g.get("npc"));
						set_if(&goal, "npcName", optional_name(r, "npc", &g.get("npc")));
						candidates = vec![cand("npc", g.get("npc"))];
						check_kinds = Some(candidates.clone());
					} else if rc.truthy() && (rc.get("source").as_str() == Some("trainer") || !rc.get("source").truthy()) && recipe_item.is_undef() && !g.get("explicitCoords").truthy() {
						let prof = found.get("profession");
						let ranks: Vec<V> = if prof.get("ranks").is_arr() { prof.get("ranks").items() } else { Vec::new() };
						let at = {
							let a = rc.get("learnedAt").num();
							if a != 0.0 && !a.is_nan() {
								a
							} else {
								0.0
							}
						};
						let rank = ranks.iter().find(|rk| rk.truthy() && rk.get("trainers").truthy() && rk.get("max").num() >= at).cloned().unwrap_or_default();
						let by_side = if rank.truthy() {
							rank.get("trainers")
						} else if prof.get("trainers").truthy() {
							prof.get("trainers")
						} else {
							V::obj()
						};
						let mut entries = Vec::new();
						add_sides(&mut entries, &by_side, |side| match side {
							"Alliance" => "A".into(),
							"Horde" => "H".into(),
							_ => V::Undef,
						});
						let rn = if rank.truthy() && rank.get("name").truthy() { format!(" {}", rank.get("name")) } else { String::new() };
						smart(&sm, r, &goal, &entries, &format!("{}{} trainer", prof.get("name"), rn));
					} else if g.get("nearest").truthy() && !recipe_item.is_undef() {
						let it = data.item(&recipe_item);
						let entries: Vec<V> = vendors_of(&it).iter().map(|id| obj! { "npc" => id.num() }.into()).collect();
						smart(&sm, r, &goal, &entries, &format!("vendor of item {recipe_item}"));
					} else if g.get("nearest").truthy() {
						r.err(&ln, format!("`learn {} nearest`: no trainer or recipe vendor for this spell in data", g.get("spell")), None);
					}
				} else {
					let made = if rc.truthy() && rc.get("item").num() > 0.0 { Some(rc.get("item").num()) } else { None };
					if let Some(made) = made {
						goal.set("item", made);
						set_if(&goal, "itemName", opt_str(name_of(data, "item", &made.into())));
					}
					if !g.get("count").is_undef() {
						let per = if rc.truthy() && rc.get("itemCount").num() > 1.0 { rc.get("itemCount").num() } else { 1.0 };
						goal.set("count", g.get("count").num() * per);
					}
					if !g.get("untilSkill").is_undef() {
						goal.set("untilSkill", g.get("untilSkill"));
						if found.truthy() {
							progress_of(ctx, &found.get("profession").get("id")).set("target", g.get("untilSkill"));
						}
						if !found.truthy() {
							r.warn(&ln, format!("`until` needs the recipe's profession, but spell {} is not in professions.json; the engine cannot check the skill", g.get("spell")), None);
						} else if rc.get("grey").num() > 0.0 && g.get("untilSkill").num() > rc.get("grey").num() {
							r.warn(&ln, format!("{} turns grey at {}; crafting it gives no skill up to {}", goal.get("spellName"), rc.get("grey"), g.get("untilSkill")), None);
						}
					}
					if rc.truthy() && rc.get("reagents").is_arr() && !rc.get("reagents").is_empty() {
						let reagents: Vec<V> = rc
							.get("reagents")
							.items()
							.into_iter()
							.filter(|x| x.truthy() && x.get("item").num() > 0.0)
							.map(|x| {
								let reagent: V = obj! { "item" => x.get("item").num() }.into();
								set_if(&reagent, "itemName", opt_str(name_of(data, "item", &reagent.get("item"))));
								reagent.set("count", if x.get("count").num() > 0.0 { x.get("count").num() } else { 1.0 });
								reagent
							})
							.collect();
						goal.set("reagents", reagents);
					}
				}
			}
			"rep" => {
				let where_ = if data.has_factions { "" } else { " (factions.json missing)" };
				if !g.get("factionId").is_undef() {
					let f = data.faction(&g.get("factionId"));
					goal.set("faction", g.get("factionId"));
					let name: V = if g.get("factionName").truthy() {
						g.get("factionName")
					} else if f.truthy() && f.get("name").truthy() {
						f.get("name").to_js_string().into()
					} else {
						V::Null
					};
					if !name.truthy() {
						r.err(&ln, format!("faction {} is not in data{}; give its name: `rep {} \"Name\" <Standing>`", g.get("factionId"), where_, g.get("factionId")), None);
					} else if !f.truthy() {
						r.warn(&ln, format!("faction {} is not in data{}; using the explicit name (new Forever content?)", g.get("factionId"), where_), None);
					}
					goal.set("factionName", or_undef(name));
				} else {
					let found = data.faction_named(&g.get("factionName").to_js_string());
					if found.truthy() {
						let f = found.get("faction");
						goal.set("faction", f.get("id"));
						goal.set("factionName", f.get("name").to_js_string());
						if found.get("ambiguous").truthy() {
							let ids: Vec<V> = found.get("ambiguous").items().iter().map(|x| x.get("id")).collect();
							r.warn(&ln, format!("faction \"{}\" matches ids {}; using {} (write `rep <factionId> <Standing>` to choose)", g.get("factionName"), join(&ids, ", "), f.get("id")), None);
						}
					} else {
						goal.set("factionName", g.get("factionName"));
						r.err(&ln, format!("unknown faction \"{}\"{}; give its id with the name: `rep <factionId> \"{}\" <Standing>`", g.get("factionName"), where_, g.get("factionName")), None);
					}
				}
				goal.set("standing", g.get("standing"));
			}
			"explore" => {}
			"achieve" => {
				goal.set("achievement", g.get("achievement"));
				if !g.get("achievementName").truthy() {
					r.err(&ln, format!("achievement {} has no reference data; give its name: `achieve {} \"Name\"`", g.get("achievement"), g.get("achievement")), None);
				}
				goal.set("achievementName", g.get("achievementName"));
				if !g.get("criteria").is_undef() {
					goal.set("criteria", g.get("criteria"));
				}
			}
			_ => {}
		}
	}

	if quest_fields && !g.get("quest").is_undef() {
		let gq = g.get("quest");
		let q = data.quest(&gq);
		goal.set("quest", gq.clone());
		if q.truthy() && q.get("title").truthy() {
			goal.set("title", q.get("title").to_js_string());
		}
		let mut oi = g.get("oi");
		if q.truthy() && q.get("objectives").is_arr() {
			let objectives = q.get("objectives").items();
			let olen = objectives.len();
			let listed = || data.quest_objectives(&gq).iter().map(|o| objective_label(&gq, o)).collect::<Vec<_>>().join(", ");
			if !oi.is_undef() && oi.num() > olen as f64 {
				let msg = format!("quest {} has {} objective(s) in data, not {}{}", gq, olen, oi, if olen > 0 { format!(": {}", listed()) } else { String::new() });
				let hint = if olen > 0 { format!("write `quest {gq}.<n>` with one of these (`polestar find {gq}` lists them)") } else { format!("drop the `.{oi}`: write `quest {gq}`") };
				r.warn(&ln, msg, Some(&hint));
			}
			let kind = match v {
				"kill" => Some("kill"),
				"collect" => Some("item"),
				"interact" => Some("object"),
				_ => None,
			};
			let id = match v {
				"kill" => g.get("npc"),
				"interact" => g.get("object"),
				_ => g.get("item"),
			};
			let used = v == "collect" && !id.is_undef() && (includes(&q.get("requiredItems").items(), &id) || q.get("sourceItem").strict_eq(&id));
			let bag_hint =
				format!("the quest uses item {} without counting it: drop `quest {}{}` so the step counts it in the bags", id, gq, if !oi.is_undef() { format!(".{oi}") } else { String::new() });
			let named: V = if !oi.is_undef() && kind.is_some() && !id.is_undef() {
				let i = oi.num() - 1.0;
				if i >= 0.0 && is_integer(i) {
					data.quest_objectives(&gq).get(i as usize).cloned().unwrap_or_default()
				} else {
					V::Undef
				}
			} else {
				V::Null
			};
			let noun = match v {
				"kill" => "npc",
				"interact" => "object",
				_ => "item",
			};
			if named.truthy() && named.get("kind").as_str() == kind && !named.get("id").is_nullish() && !named.get("id").strict_eq(&id) {
				let right = objective_for(&q, kind, &id);
				let own = right.and_then(|ri| data.quest_objectives(&gq).get(ri - 1).cloned());
				let own_part = match (&own, right) {
					(Some(o), Some(ri)) => {
						let nm = if o.get("name").truthy() { o.get("name").to_js_string() } else { format!("{noun} {id}") };
						format!("; {nm} is {gq}.{ri}")
					}
					_ => String::new(),
				};
				let msg = format!("{}, not this {}{}", quest_is(&objective_label(&gq, &named)), noun, own_part);
				let hint = match right {
					Some(ri) => format!("write `quest {gq}.{ri}`, or `quest {gq}` to take the index from the {noun}"),
					None if used => bag_hint.clone(),
					None => format!("its objectives: {}", listed()),
				};
				if right.is_some() {
					r.err(&ln, msg, Some(&hint));
				} else {
					r.warn(&ln, msg, Some(&hint));
				}
			}
			if named.truthy() && v == "collect" && named.get("kind").as_str() != Some("item") {
				let right = objective_for(&q, Some("item"), &id);
				let hint = match right {
					Some(ri) => format!("write `quest {gq}.{ri}`, or `quest {gq}` to take the index from the item"),
					None if used => bag_hint.clone(),
					None => format!("its objectives: {}", listed()),
				};
				r.warn(&ln, format!("{}, not an item", quest_is(&objective_label(&gq, &named))), Some(&hint));
			}
			if oi.is_undef() {
				if !id.is_undef() {
					oi = objective_for(&q, kind, &id).map(V::from).unwrap_or_default();
				}
				if oi.is_undef() && olen > 0 {
					let tail = if used { String::new() } else { format!("; write `quest {gq}.<objective>`") };
					let hint = if used { bag_hint.clone() } else { format!("its objectives: {}", listed()) };
					r.warn(&ln, format!("quest {gq} has no objective for this {noun}{tail}"), Some(&hint));
				}
			}
			if !oi.is_undef() && g.get("count").is_undef() && (v == "kill" || v == "collect") {
				let i = oi.num() - 1.0;
				let o = if i >= 0.0 && is_integer(i) { objectives.get(i as usize).cloned().unwrap_or_default() } else { V::Undef };
				if o.truthy() && o.get("count").num() > 0.0 {
					goal.set("count", o.get("count").num());
				}
			}
		} else if !q.truthy() {
			r.warn(&ln, format!("quest {gq} is not in data; objective index and count cannot be filled"), None);
		}
		if !oi.is_undef() {
			goal.set("oi", oi);
		}
	}
	if (v == "kill" || v == "collect") && !g.get("count").is_undef() {
		goal.set("count", g.get("count"));
	}
	if !goal.get("quest").is_undef() {
		let q = data.quest(&goal.get("quest"));
		let line = if q.truthy() { q.get("skill").num() } else { 0.0 };
		if is_integer(line) && line > 0.0 {
			let p = data.profession(&line.into());
			goal.set("profLine", line);
			set_if(&goal, "profName", if p.truthy() && p.get("name").truthy() { p.get("name").to_js_string().into() } else { V::Undef });
			goal.set("profRank", if q.get("skillLevel").num() > 0.0 { q.get("skillLevel").num() } else { 1.0 });
		}
	}

	if !g.get("text").is_undef() {
		goal.set("text", g.get("text"));
	}

	// Coordinates.
	let map = if !g.get("coordMap").is_undef() { g.get("coordMap") } else { zone_map.clone() };
	let explicit = g.get("explicitCoords").truthy();
	if explicit {
		let (gx, gy) = (g.get("x").num(), g.get("y").num());
		if !(0.0..=100.0).contains(&gx) || !(0.0..=100.0).contains(&gy) {
			r.err(&ln, format!("coordinates {},{} are outside 0-100", g.get("x"), g.get("y")), None);
		} else if map.is_nullish() {
			r.err(&ln, "coordinates need a zone (`zone` in the header or step, or `map <uiMapID>`)", None);
		} else {
			goal.set("map", map.clone());
			goal.set("x", round2(gx));
			goal.set("y", round2(gy));
			let (frame, fexplicit) = (&ctx.frame.0, ctx.frame.1);
			let has_era = data.era_frame(&map).truthy();
			let any_frames = non_empty(&data.map_frames.get("era"));
			if frame == "era" && (has_era || !any_frames) {
				goal.set("f", "e");
			} else if frame == "era" && fexplicit {
				r.warn(&ln, format!("`era` coordinates on map {map}, but map-frames.json has no Era bounds for it; compiling them as live-frame"), None);
			}
			if let Some(ck) = check_kinds.as_ref().filter(|c| !c.is_empty()) {
				let fr = if goal.get("f").as_str() == Some("e") { "e" } else { "l" };
				check_near(data, ck, &map, goal.get("x").num(), goal.get("y").num(), fr, &ln, r);
			}
		}
	}
	if g.get("frame").truthy() && !explicit {
		r.err(&ln, format!("`{}` only applies to explicit coordinates (@x,y)", g.get("frame")), None);
	}
	if explicit && (g.get("nearest").truthy() || g.get("classTrain").truthy() || (!g.get("profession").is_undef() && g.get("npc").is_undef())) {
		r.err(&ln, "smart targets pick their NPC and position at runtime; drop the coordinates, or name an npc id", None);
	}
	let drop_sides = if v == "collect" { Some(&ctx.sides) } else { None };
	let picked = pick_spawn(data, &candidates, &map, prev, ctx.used_maps, drop_sides, pass_rares, drop_level);
	if picked.truthy() {
		let c = picked.get("cand");
		if v == "accept" || v == "turnin" {
			if c.get("kind").as_str() == Some("npc") {
				goal.set("npc", c.get("id"));
				set_if(&goal, "npcName", opt_str(name_of(data, "npc", &c.get("id"))));
			} else {
				goal.set("object", c.get("id"));
				set_if(&goal, "objName", opt_str(name_of(data, "object", &c.get("id"))));
			}
		} else if v == "buy" {
			goal.set("npc", c.get("id"));
			set_if(&goal, "npcName", opt_str(name_of(data, "npc", &c.get("id"))));
		}
		if !explicit && !picked.get("x").is_undef() {
			goal.set("map", picked.get("map"));
			goal.set("x", picked.get("x"));
			goal.set("y", picked.get("y"));
			if picked.get("f").truthy() {
				let any_frames = non_empty(&data.map_frames.get("era"));
				if data.era_frame(&picked.get("map")).truthy() || !any_frames {
					goal.set("f", picked.get("f"));
				} else {
					r.warn(&ln, format!("Era-frame coordinates on map {}, but map-frames.json has no Era bounds for it; compiled as live-frame", picked.get("map")), None);
				}
			}
		}
		let area = v == "kill" || v == "collect" || v == "interact";
		if !explicit && !picked.get("x").is_undef() {
			let srcs: Vec<V> = if area && picked.get("sources").truthy() { picked.get("sources").items() } else { vec![c.clone()] };
			let elites: Vec<V> = if area { picked.get("elites").items() } else { Vec::new() };
			let sp = spawn_spots(data, &srcs, &picked.get("map"), &picked.get("f"), picked.get("x").num(), picked.get("y").num(), &elites);
			if let Some(sp) = sp {
				goal.set("spots", sp.spots);
				if sp.spread && area {
					goal.set("spread", true);
				}
				if let Some((ax, ay)) = sp.at {
					goal.set("x", ax);
					goal.set("y", ay);
				}
			}
			if v == "collect" && goal.get("npc").is_undef() {
				set_if(&goal, "fromNpcs", source_npcs(data, &c, &picked.get("sources").items()));
			}
		} else if explicit && !goal.get("x").is_undef() {
			// No source with known odds (the data's droppers without a chance): the droppers that spawn at
			// the author's point, with every place they spawn; not the other droppers, whose places the
			// author chose against (the Savannah Lion Hide's Matriarchs by Ratchet, #273).
			let unknown_odds = area && !candidates.is_empty() && candidates.iter().all(|s| s.get("chance").is_num() && num(s, "chance") == 0.0);
			let known: Vec<V> =
				if area { candidates.iter().filter(|s| s.get("chance").is_undef() || num(s, "chance") > 0.0 || unknown_odds || gather_node(data, s)).cloned().collect() } else { vec![c.clone()] };
			let all: Vec<(V, Vec<V>)> = known.iter().map(|k| (k.clone(), data.spawns(&k.get("kind").to_js_string(), &k.get("id")))).collect();
			let gmap = goal.get("map");
			let mut sources: Vec<V> = on_map(data, &all, &gmap, drop_sides, pass_rares, drop_level).0.into_iter().map(|o| o.0).collect();
			if unknown_odds {
				let at_pin: FxHashSet<usize> = point_sources(data, &sources, &gmap, &goal.get("f"), goal.get("x").num(), goal.get("y").num(), SPREAD_YARDS).iter().map(ptr_key).collect();
				sources.retain(|s| gather_node(data, s) || at_pin.contains(&ptr_key(s)));
			}
			let near = if !area {
				SPAWN_CHECK_YARDS
			} else if !sources.is_empty() && sources.iter().all(|s| gather_node(data, s)) {
				f64::INFINITY
			} else {
				SPREAD_YARDS
			};
			let (gx, gy, gf) = (goal.get("x").num(), goal.get("y").num(), goal.get("f"));
			set_if(&goal, "spots", hand_spots(data, &sources, &gmap, &gf, gx, gy, near));
			if v == "collect" && goal.get("npc").is_undef() {
				let own = point_sources(data, &sources, &gmap, &gf, gx, gy, near);
				let first = own.first().cloned().unwrap_or_default();
				set_if(&goal, "fromNpcs", source_npcs(data, &first, &own));
			}
		}
	}
	if !g.get("r").is_undef() {
		goal.set("r", g.get("r"));
	}
	if g.get("optional").truthy() {
		goal.set("optional", true);
	}
	if !g.get("gossip").is_undef() {
		goal.set("gossip", g.get("gossip"));
	}
	if g.get("direct").truthy() {
		goal.set("direct", true);
		let q = if !goal.get("quest").is_undef() { data.quest(&goal.get("quest")) } else { V::Null };
		if q.truthy() && q.get("level").num() > 0.0 {
			goal.set("qlvl", q.get("level").num());
		}
	}
	set_if(&goal, "group", crate::group::group_of(&goal, &g.get("group"), &ctx.sides, data));
	set_if(&goal, "escort", crate::escort::escort_of(&goal, data));
	set_if(&goal, "only", only_of(&g.get("only")));
	set_if(&goal, "note", g.get("note"));
	set_if(&goal, "spots", crate::walks::walk_spot(data, &goal).unwrap_or_default());
	set_if(&goal, "z", crate::heights::goal_height(data, &goal).unwrap_or_default());
	for s in goal.get("spots").items() {
		set_if(&s, "z", crate::heights::spot_height(data, &goal, &s).unwrap_or_default());
	}
	set_if(&goal, "area", crate::places::goal_area(data, &goal));
	let node_sides = smart_sides(&ctx.sides, &crate::conditions::applicable(&ctx.layers));
	set_if(&goal, "node", crate::places::goal_node(data, &goal, &node_sides));

	if (v == "kill" || v == "collect" || v == "interact" || v == "use")
		&& goal.get("x").is_undef()
		&& !goal.get("candidates").truthy()
		&& !g.get("nearest").truthy()
		&& !(ctx.loop_ && LOOP_VERBS.contains(&v))
	{
		r.warn(
			&ln,
			format!("`{v}` has no coordinates (no known spawns; add @x,y)"),
			Some("add @x,y where the player finds the target (the map coordinates the game shows), so the arrow can lead there"),
		);
	}
	goal
}

/// Warn when explicit coordinates are far from every known spawn (same map frame only).
fn check_near(data: &Data, kinds: &[V], map: &V, x: f64, y: f64, frame: &str, ln: &V, r: &mut R) {
	let mut any = false;
	let mut on_map = false;
	let mut other_frame = false;
	for k in kinds {
		for s in data.spawns(&k.get("kind").to_js_string(), &k.get("id")) {
			any = true;
			if !s.get("map").strict_eq(map) {
				continue;
			}
			let sf = if s.get("f").as_str() == Some("l") { "l" } else { "e" };
			if sf != frame {
				other_frame = true;
				continue;
			}
			on_map = true;
			if !data.map_size(map).truthy() {
				return;
			}
			for p in s.get("pts").items().iter().chain(s.get("more").items().iter()) {
				if distance(data, map, px(p), py(p), x, y) <= SPAWN_CHECK_YARDS {
					return;
				}
			}
		}
	}
	if !any {
		return;
	}
	if !on_map && other_frame {
		return;
	}
	let (what, look) = if kinds.len() == 1 {
		let (kk, ki) = (kinds[0].get("kind"), kinds[0].get("id"));
		(format!("{kk} {ki}"), format!("`polestar find {ki} --kind {kk}`"))
	} else {
		("the target".to_string(), "`polestar find <id>`".to_string())
	};
	let hint = format!("{look} prints a known spawn: check the coordinates against it, or keep them when the target stands elsewhere in Forever");
	let (xs, ys) = (num_str(x), num_str(y));
	if !on_map {
		r.warn(ln, format!("explicit coordinates {xs},{ys}: {what} has no known spawn on map {map}"), Some(&hint));
	} else {
		r.warn(ln, format!("explicit coordinates {xs},{ys} are more than {} yards from every known spawn of {what}", num_str(SPAWN_CHECK_YARDS)), Some(&hint));
	}
}
