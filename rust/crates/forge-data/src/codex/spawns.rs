//! build.js spawns: `cluster`, `frameOf`, `spawnsOf` (map points -> the Codex's capped places,
//! the inner map first where two maps hold the same place).

use forge_guide::js::{Obj, V};

use super::util::{hypot, round1};
use crate::spawns::{reduce_spawns, SpawnOptions, P};

const RADIUS: f64 = 3.0;
const PER_MAP: usize = 5;
const MAPS: usize = 4;
const INNER_MAX: f64 = 1500.0;
const SAME_PLACE: f64 = 50.0;

#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Spawn {
	pub map: f64,
	pub x: f64,
	pub y: f64,
	/// `f: 'e'` (the Era frame), else null.
	pub era: bool,
}

impl Spawn {
	pub fn to_v(&self) -> V {
		let o = Obj::new();
		o.set("map", self.map);
		o.set("x", self.x);
		o.set("y", self.y);
		o.set("f", if self.era { V::str("e") } else { V::Null });
		V::Obj(o)
	}
}

pub fn spawns_v(list: &[Spawn]) -> V {
	V::from(list.iter().map(Spawn::to_v).collect::<Vec<V>>())
}

#[derive(Clone, Copy)]
struct Cluster {
	x: f64,
	y: f64,
	n: f64,
}

/// `cluster(points)`: greedy clusters (radius in map percent), biggest first.
fn cluster(points: &[V]) -> Vec<Cluster> {
	let mut pts: Vec<(f64, f64)> = points.iter().filter(|p| p.is_arr() && p.num_at(0).is_finite() && p.num_at(1).is_finite()).map(|p| (p.num_at(0), p.num_at(1))).collect();
	pts.sort_by(|a, b| super::util::ord(if a.0 - b.0 != 0.0 { a.0 - b.0 } else { a.1 - b.1 }));
	let mut clusters: Vec<(f64, f64, f64)> = Vec::new();
	for (x, y) in pts {
		let mut best = None;
		for (i, c) in clusters.iter().enumerate() {
			let dx = c.0 / c.2 - x;
			let dy = c.1 / c.2 - y;
			if dx * dx + dy * dy <= RADIUS * RADIUS {
				best = Some(i);
				break;
			}
		}
		match best {
			Some(i) => {
				clusters[i].0 += x;
				clusters[i].1 += y;
				clusters[i].2 += 1.0;
			}
			None => clusters.push((x, y, 1.0)),
		}
	}
	let mut out: Vec<Cluster> = clusters.iter().map(|c| Cluster { x: round1(c.0 / c.2), y: round1(c.1 / c.2), n: c.2 }).collect();
	out.sort_by(|a, b| {
		let d = b.n - a.n;
		let d = if d != 0.0 { d } else { a.x - b.x };
		let d = if d != 0.0 { d } else { a.y - b.y };
		super::util::ord(d)
	});
	out
}

#[derive(Clone, Copy)]
pub struct Frame {
	pub c: f64,
	pub left: f64,
	pub right: f64,
	pub top: f64,
	pub bottom: f64,
}

/// `frameOf(frames, map, f)`.
pub fn frame_of(frames: &V, map: f64, era: bool) -> Option<Frame> {
	let set = frames.get(if era { "era" } else { "forever" });
	let fr = set.get(&super::util::key(map));
	if !fr.is_obj() {
		return None;
	}
	let f = Frame { c: fr.get("c").num(), left: fr.get("left").num(), right: fr.get("right").num(), top: fr.get("top").num(), bottom: fr.get("bottom").num() };
	((f.right - f.left).abs() > 0.0 && (f.bottom - f.top).abs() > 0.0).then_some(f)
}

#[derive(Clone, Copy)]
struct BoxW {
	c: f64,
	x0: f64,
	x1: f64,
	y0: f64,
	y1: f64,
}

fn box_of(fr: Option<Frame>) -> Option<BoxW> {
	fr.map(|f| BoxW { c: f.c, x0: f.left.min(f.right), x1: f.left.max(f.right), y0: f.top.min(f.bottom), y1: f.top.max(f.bottom) })
}

fn within(b: Option<BoxW>, a: Option<BoxW>) -> bool {
	let (Some(b), Some(a)) = (b, a) else { return false };
	if b.c != a.c {
		return false;
	}
	if !(b.x0 >= a.x0 && b.x1 <= a.x1 && b.y0 >= a.y0 && b.y1 <= a.y1) {
		return false;
	}
	(b.x1 - b.x0) * (b.y1 - b.y0) < (a.x1 - a.x0) * (a.y1 - a.y0)
}

fn enclosed(b: Option<BoxW>) -> bool {
	b.is_some_and(|b| (b.x1 - b.x0).max(b.y1 - b.y0) <= INNER_MAX)
}

fn more_inner(b: Option<BoxW>, a: Option<BoxW>) -> bool {
	if enclosed(b) && !enclosed(a) {
		return true;
	}
	within(b, a)
}

#[derive(Clone, Copy)]
struct World {
	c: f64,
	wx: f64,
	wy: f64,
}

fn world_of(frames: &V, map: f64, era: bool, x: f64, y: f64) -> Option<World> {
	let fr = frame_of(frames, map, era)?;
	Some(World { c: fr.c, wx: fr.top + (y / 100.0) * (fr.bottom - fr.top), wy: fr.left + (x / 100.0) * (fr.right - fr.left) })
}

fn same_place(a: Option<World>, b: Option<World>) -> bool {
	match (a, b) {
		(Some(a), Some(b)) => a.c == b.c && hypot(a.wx - b.wx, a.wy - b.wy) <= SAME_PLACE,
		_ => false,
	}
}

struct MapPlaces {
	map: f64,
	era: bool,
	clusters: Vec<Cluster>,
	at: Option<World>,
	bx: Option<BoxW>,
}

/// `spawnsOf(byMap, zones, frames, exact)`. `frames` the map-frames.json value (Undef: none).
pub fn spawns_of(by_map: &V, zones: &V, frames: &V, exact: bool) -> Vec<Spawn> {
	let mut maps: Vec<MapPlaces> = Vec::new();
	for (map, s) in super::util::oentries(by_map) {
		if zones.is_object() && !zones.get(&map).truthy() {
			continue;
		}
		let era = s.get("f").as_str() == Some("e");
		let clusters = if exact {
			let mut pts: Vec<P> = crate::spawns::points_of(&s.get("pts"));
			pts.extend(crate::spawns::points_of(&s.get("more")));
			reduce_spawns(&pts, SpawnOptions { cap: usize::MAX, dedupe: 0.0 }).pts.iter().map(|p| Cluster { x: p[0], y: p[1], n: 1.0 }).collect()
		} else {
			cluster(&s.get("pts").items())
		};
		if clusters.is_empty() {
			continue;
		}
		maps.push(MapPlaces { map: forge_guide::js::str_to_num(&map), era, clusters, at: None, bx: None });
	}
	let total = |m: &MapPlaces| m.clusters.iter().map(|c| c.n).sum::<f64>();
	maps.sort_by(|a, b| {
		let d = total(b) - total(a);
		super::util::ord(if d != 0.0 { d } else { a.map - b.map })
	});
	if !exact {
		maps.truncate(MAPS);
	}
	if frames.is_object() {
		for m in maps.iter_mut() {
			m.at = world_of(frames, m.map, m.era, m.clusters[0].x, m.clusters[0].y);
			m.bx = box_of(frame_of(frames, m.map, m.era));
		}
		for i in 0..maps.len() {
			let mut inner = i;
			for j in i + 1..maps.len() {
				if same_place(maps[i].at, maps[j].at) && more_inner(maps[j].bx, maps[inner].bx) {
					inner = j;
				}
			}
			if inner != i {
				let m = maps.remove(inner);
				maps.insert(i, m);
			}
		}
	}
	let mut out = Vec::new();
	for m in &maps {
		let n = if exact { m.clusters.len() } else { PER_MAP.min(m.clusters.len()) };
		for c in &m.clusters[..n] {
			out.push(Spawn { map: m.map, x: c.x, y: c.y, era: m.era });
		}
	}
	out
}

/// Spawns back from a record's `spawns` value.
pub fn spawns_from(v: &V) -> Vec<Spawn> {
	v.items().iter().map(|s| Spawn { map: s.get("map").num(), x: s.get("x").num(), y: s.get("y").num(), era: s.get("f").as_str() == Some("e") }).collect()
}
