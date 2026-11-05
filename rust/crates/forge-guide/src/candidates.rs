//! Port of tools/lib/dsl/candidates.js.
//! Candidate sets for smart targets (`train <Profession>`, `train class`, `buy … nearest`, `vendor nearest`,
//! `sethome nearest`): every matching NPC with a spawn point and a faction tag, one per town (hub).

use crate::data::Data;
use crate::heights::candidate_height;
use crate::js::{hypot, math_round, Arr, V};
use crate::obj;
use std::cmp::Ordering;

pub const CAP: f64 = 6.0;
const HUB_YARDS: f64 = 250.0;
const MAX_PER_GROUP: f64 = 120.0;
const SERVICE_ROLES: [&str; 3] = ["vendor", "innkeeper", "repair"];
const SAME_SPOT_YARDS: f64 = 100.0;

fn round2(n: f64) -> f64 {
	let r = math_round(n * 100.0) / 100.0;
	if r == 0.0 {
		0.0
	} else {
		r
	}
}

/// A JS comparator result as an Ordering (NaN and 0 are Equal).
fn sign(d: f64) -> Ordering {
	if d < 0.0 {
		Ordering::Less
	} else if d > 0.0 {
		Ordering::Greater
	} else {
		Ordering::Equal
	}
}

/// `a || b` for comparator numbers.
fn or_else(d: f64, f: impl FnOnce() -> f64) -> f64 {
	if d != 0.0 && !d.is_nan() {
		d
	} else {
		f()
	}
}

/// A world position: c (instance map), wx, wy.
#[derive(Clone)]
pub struct WorldPos {
	pub c: V,
	pub wx: f64,
	pub wy: f64,
}

/// World yards of a map point through data.frame, or None without a frame.
pub fn world_pos(data: &Data, map: &V, x: f64, y: f64) -> Option<WorldPos> {
	let fr = data.frame(map);
	if !fr.truthy() {
		return None;
	}
	let (top, bottom, left, right) = (fr.get("top").num(), fr.get("bottom").num(), fr.get("left").num(), fr.get("right").num());
	Some(WorldPos { c: fr.get("c"), wx: top + ((bottom - top) * y) / 100.0, wy: left + ((right - left) * x) / 100.0 })
}

/// One point per map an npc spawns on: the spawn nearest that map's centroid. -> [{ map, x, y, f? }]
pub fn spawn_points(data: &Data, id: &V) -> Vec<V> {
	data.spawns("npc", id)
		.into_iter()
		.map(|s| {
			let pts = s.get("pts").items();
			let mut cx = 0.0;
			let mut cy = 0.0;
			for p in &pts {
				cx += p.at(0).num();
				cy += p.at(1).num();
			}
			cx /= pts.len() as f64;
			cy /= pts.len() as f64;
			let mut best = pts[0].clone();
			let mut bd = f64::INFINITY;
			for p in &pts {
				let d = (p.at(0).num() - cx).powi(2) + (p.at(1).num() - cy).powi(2);
				if d < bd {
					bd = d;
					best = p.clone();
				}
			}
			let map = s.get("map");
			let era = s.get("f").as_str() == Some("e") && (data.era_frame(&map).truthy() || data.map_frames.get("era").keys().is_empty());
			let o = obj! { "map" => map, "x" => round2(best.at(0).num()), "y" => round2(best.at(1).num()) };
			o.set("f", if era { V::str("e") } else { V::Undef });
			o.into()
		})
		.collect()
}

/// "A" | "H" | "AH" | None: the union of npcs.json's faction and the sides the id was listed for.
pub fn faction_tag(npc: &V, side: &V) -> Option<String> {
	let pick = |v: &V| match v.as_str() {
		Some(s @ ("A" | "H" | "AH")) => s.to_string(),
		_ => String::new(),
	};
	let f = pick(&npc.get("faction"));
	let s = pick(side);
	let a = f.contains('A') || s.contains('A');
	let h = f.contains('H') || s.contains('H');
	if a || h {
		return Some(format!("{}{}", if a { "A" } else { "" }, if h { "H" } else { "" }));
	}
	if !npc.get("faction").truthy() && npc.get("roles").items().iter().any(|r| SERVICE_ROLES.iter().any(|s| r.as_str() == Some(*s))) {
		return Some("AH".into());
	}
	None
}

pub fn usable_by(tag: Option<&str>, side: &V) -> bool {
	tag == Some("AH") || tag == Some(if side.as_str() == Some("Alliance") { "A" } else { "H" })
}

struct Point {
	p: V,
	w: Option<WorldPos>,
}

/// An NPC's points with world positions, the same spot on two maps kept once, on the smaller map.
fn distinct_points(data: &Data, id: &V) -> Vec<Point> {
	let area = |map: &V| {
		let fr = data.frame(map);
		if fr.truthy() {
			((fr.get("right").num() - fr.get("left").num()) * (fr.get("bottom").num() - fr.get("top").num())).abs()
		} else {
			f64::INFINITY
		}
	};
	let mut pts: Vec<(Point, f64)> = spawn_points(data, id)
		.into_iter()
		.map(|p| {
			let map = p.get("map");
			let w = world_pos(data, &map, p.get("x").num(), p.get("y").num());
			let a = area(&map);
			(Point { p, w }, a)
		})
		.collect();
	pts.sort_by(|x, y| sign(or_else(x.1 - y.1, || x.0.p.get("map").num() - y.0.p.get("map").num())));
	let mut kept: Vec<Point> = Vec::new();
	for (q, _) in pts {
		if let Some(qw) = &q.w {
			if kept.iter().any(|k| k.w.as_ref().is_some_and(|kw| kw.c.strict_eq(&qw.c) && hypot(kw.wx - qw.wx, kw.wy - qw.wy) < SAME_SPOT_YARDS)) {
				continue;
			}
		}
		kept.push(q);
	}
	kept
}

struct Entry {
	cand: V,
	c: V,
	w: Option<WorldPos>,
	d: Option<f64>,
}

/// `buildCandidates(data, entries, opts)`: entries = [{ npc, side?, classes? }]; opts = { sides: [..],
/// ref: { map, x, y } | null, cap }. -> { candidates, coverage: { Alliance: bool, Horde: bool } }
pub fn build_candidates(data: &Data, entries: &[V], opts: &V) -> V {
	let sides = opts.get("sides").items();
	let cap = if opts.get("cap").truthy() { opts.get("cap").num() } else { MAX_PER_GROUP };
	let r = opts.get("ref");
	let reference = if r.truthy() { world_pos(data, &r.get("map"), r.get("x").num(), r.get("y").num()) } else { None };
	// npc id -> (side, classes), in insertion order
	let mut merged: Vec<(f64, V, Option<Vec<V>>)> = Vec::new();
	for e in entries {
		let id = e.get("npc").num();
		if !(id > 0.0) {
			continue;
		}
		let e_side = e.get("side");
		let e_classes = e.get("classes");
		match merged.iter_mut().find(|m| m.0 == id) {
			None => merged.push((id, e_side, if e_classes.truthy() { Some(e_classes.items()) } else { None })),
			Some(prev) => {
				if e_side.truthy() && !prev.1.strict_eq(&e_side) {
					prev.1 = if prev.1.truthy() { V::str("AH") } else { e_side };
				}
				if e_classes.truthy() {
					if let Some(pc) = prev.2.as_mut() {
						for c in e_classes.items() {
							if !pc.iter().any(|x| x.strict_eq(&c)) {
								pc.push(c);
							}
						}
					}
				}
			}
		}
	}
	let mut ids: Vec<f64> = merged.iter().map(|m| m.0).collect();
	ids.sort_by(|a, b| sign(a - b));
	let mut all: Vec<Entry> = Vec::new();
	for id in ids {
		let idv = V::Num(id);
		let npc = data.npc(&idv);
		if !npc.truthy() {
			continue;
		}
		let meta = merged.iter().find(|m| m.0 == id).unwrap();
		let tag = faction_tag(&npc, &meta.1);
		let Some(tag) = tag else { continue };
		if !sides.iter().any(|s| usable_by(Some(&tag), s)) {
			continue;
		}
		let classes: Option<V> = meta.2.as_ref().map(|c| V::Arr(Arr::from_vec(c.clone())));
		for Point { p, w } in distinct_points(data, &idv) {
			let cand = obj! { "npc" => id };
			if npc.get("name").truthy() {
				cand.set("npcName", npc.get("name").to_js_string());
			}
			cand.set("map", p.get("map"));
			cand.set("x", p.get("x"));
			cand.set("y", p.get("y"));
			if p.get("f").truthy() {
				cand.set("f", p.get("f"));
			}
			let cv: V = cand.clone().into();
			if let Some(z) = candidate_height(data, &cv) {
				cand.set("z", round2(z.num()));
			}
			cand.set("faction", tag.as_str());
			if let Some(c) = &classes {
				if !c.is_empty() {
					cand.set("classes", c.clone());
				}
			}
			let near = matches!((&reference, &w), (Some(rf), Some(w)) if w.c.strict_eq(&rf.c));
			let d = if near {
				let (rf, w) = (reference.as_ref().unwrap(), w.as_ref().unwrap());
				Some(hypot(w.wx - rf.wx, w.wy - rf.wy))
			} else {
				None
			};
			let c = w.as_ref().map(|w| w.c.clone()).unwrap_or(V::Null);
			all.push(Entry { cand: cv, c, w, d });
		}
	}
	let coverage = obj! {};
	for s in &sides {
		coverage.set(&s.to_js_string(), all.iter().any(|a| usable_by(a.cand.get("faction").as_str(), s)));
	}

	let order = |a: &Entry, b: &Entry| -> Ordering {
		if a.d.is_none() != b.d.is_none() {
			return if a.d.is_none() { Ordering::Greater } else { Ordering::Less };
		}
		if let (Some(ad), Some(bd)) = (a.d, b.d) {
			if ad != bd {
				return sign(ad - bd);
			}
		}
		sign(or_else(a.cand.get("map").num() - b.cand.get("map").num(), || a.cand.get("npc").num() - b.cand.get("npc").num()))
	};
	let mut groups: Vec<(String, Vec<Entry>)> = Vec::new();
	for a in all {
		let key = format!("{}|{}|{}", a.c.to_js_string(), a.cand.get("faction").to_js_string(), a.cand.get("classes").to_js_string());
		match groups.iter_mut().find(|g| g.0 == key) {
			Some(g) => g.1.push(a),
			None => groups.push((key, vec![a])),
		}
	}
	let mut kept: Vec<Entry> = Vec::new();
	for (_, mut list) in groups {
		list.sort_by(order);
		let mut hubs: Vec<Entry> = Vec::new();
		for a in list {
			if hubs.len() as f64 >= cap {
				break;
			}
			let same_hub = a.w.as_ref().is_some_and(|aw| hubs.iter().any(|h| h.w.as_ref().is_some_and(|hw| hw.c.strict_eq(&aw.c) && hypot(hw.wx - aw.wx, hw.wy - aw.wy) < HUB_YARDS)));
			if same_hub {
				continue;
			}
			if a.w.is_none() && hubs.iter().any(|h| h.w.is_none() && h.cand.get("map").strict_eq(&a.cand.get("map"))) {
				continue;
			}
			hubs.push(a);
		}
		kept.extend(hubs);
	}
	kept.sort_by(order);
	let candidates: Vec<V> = kept.into_iter().map(|a| a.cand).collect();
	obj! { "candidates" => candidates, "coverage" => coverage }.into()
}
