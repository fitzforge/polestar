//! World <-> Era map conversions over data/forever/map-frames.json (port of
//! tools/lib/travel/geo.js). World coordinates follow the client: wx grows north, wy grows west.

use forge_core::jsnum::{js_hypot, js_round};
use forge_guide::js::V;
use rustc_hash::FxHashMap;

/// `round(v, places)`: `Math.round(v * 10^places) / 10^places`, `-0` as `0`.
pub fn round(v: f64, places: i32) -> f64 {
	let k = 10f64.powi(places);
	let r = js_round(v * k) / k;
	if r == 0.0 {
		0.0
	} else {
		r
	}
}

#[derive(Clone, Copy, Debug)]
pub struct Frame {
	pub c: f64,
	pub left: f64,
	pub right: f64,
	pub top: f64,
	pub bottom: f64,
}

impl Frame {
	pub fn of(v: &V) -> Frame {
		Frame { c: v.get("c").num(), left: v.get("left").num(), right: v.get("right").num(), top: v.get("top").num(), bottom: v.get("bottom").num() }
	}
}

/// A world point.
#[derive(Clone, Copy, Debug)]
pub struct W {
	pub c: f64,
	pub wx: f64,
	pub wy: f64,
}

pub struct Cand {
	pub map: i64,
	pub x: f64,
	pub y: f64,
	area: f64,
}

pub struct Frames {
	/// uiMapID -> frame, ids ascending (a JS Map built from an object's entries).
	pub list: Vec<(i64, Frame)>,
	by_id: FxHashMap<i64, Frame>,
	/// zones.json.
	pub zones: V,
}

impl Frames {
	pub fn new(era: &V, zones: &V) -> Frames {
		let mut list = Vec::new();
		if let Some(o) = era.as_obj() {
			for (k, v) in o.entries() {
				list.push((forge_guide::js::str_to_num(&k) as i64, Frame::of(&v)));
			}
		}
		let by_id = list.iter().copied().collect();
		Frames { list, by_id, zones: if zones.is_object() { zones.clone() } else { V::obj() } }
	}

	pub fn frame(&self, map: i64) -> Option<Frame> {
		self.by_id.get(&map).copied()
	}

	pub fn zone(&self, map: i64) -> V {
		self.zones.get(&map.to_string())
	}

	pub fn name(&self, map: i64) -> Option<String> {
		let z = self.zone(map);
		if z.truthy() {
			Some(z.get("name").to_js_string())
		} else {
			None
		}
	}

	pub fn to_world(&self, map: i64, x: f64, y: f64) -> Option<W> {
		let b = self.frame(map)?;
		Some(W { c: b.c, wx: b.top + (b.bottom - b.top) * (y / 100.0), wy: b.left + (b.right - b.left) * (x / 100.0) })
	}

	pub fn to_map(&self, map: i64, c: f64, wx: f64, wy: f64) -> Option<(f64, f64)> {
		let b = self.frame(map)?;
		if b.c != c {
			return None;
		}
		Some((((wy - b.left) / (b.right - b.left)) * 100.0, ((wx - b.top) / (b.bottom - b.top)) * 100.0))
	}

	/// Zone/city maps (type 3, or maps zones.json lacks) of continent c holding the point,
	/// smallest first. (Not `!contains`: JS lets NaN through.)
	pub fn containing(&self, c: f64, wx: f64, wy: f64) -> Vec<Cand> {
		let mut out = Vec::new();
		for &(id, b) in &self.list {
			let z = self.zone(id);
			if b.c != c || (z.truthy() && z.get("type").as_num() != Some(3.0)) {
				continue;
			}
			let (x, y) = self.to_map(id, c, wx, wy).unwrap();
			if x < 0.0 || x > 100.0 || y < 0.0 || y > 100.0 {
				continue;
			}
			out.push(Cand { map: id, x, y, area: ((b.right - b.left) * (b.bottom - b.top)).abs() });
		}
		out.sort_by(|a, b| (a.area - b.area).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal).then(a.map.cmp(&b.map)));
		out
	}

	/// Continent uiMap per continent id: the type 2 map with the largest rectangle.
	pub fn continents(&self) -> FxHashMap<i64, i64> {
		let mut best: FxHashMap<i64, (i64, f64)> = FxHashMap::default();
		for &(id, b) in &self.list {
			let z = self.zone(id);
			if !z.truthy() || z.get("type").as_num() != Some(2.0) {
				continue;
			}
			let area = ((b.right - b.left) * (b.bottom - b.top)).abs();
			let e = best.entry(b.c as i64).or_insert((id, area));
			if area > e.1 {
				*e = (id, area);
			}
		}
		best.into_iter().map(|(c, (m, _))| (c, m)).collect()
	}
}

pub struct Placed {
	pub map: i64,
	pub x: f64,
	pub y: f64,
}

/// placePoint: the map for a world point (a preferred map, the location named before the comma
/// in `label`, the region after it, else the smallest containing map).
pub fn place_point(frames: &Frames, c: f64, wx: f64, wy: f64, prefer: &[i64], label: &str) -> Option<Placed> {
	let cands = frames.containing(c, wx, wy);
	if cands.is_empty() {
		return None;
	}
	let (location, suffix) = match label.find(',') {
		Some(i) => (label[..i].trim().to_lowercase(), label[i + 1..].trim().to_lowercase()),
		None => (label.trim().to_lowercase(), String::new()),
	};
	let score = |cand: &Cand| {
		let mut s = 0;
		if prefer.contains(&cand.map) {
			s += 4;
		}
		if let Some(name) = frames.name(cand.map) {
			let n = name.to_lowercase();
			if !location.is_empty() && n == location {
				s += 2;
			}
			if !suffix.is_empty() && n.starts_with(&suffix) {
				s += 1;
			}
		}
		s
	};
	let mut best = &cands[0];
	for cand in &cands {
		if score(cand) > score(best) {
			best = cand;
		}
	}
	Some(Placed { map: best.map, x: round(best.x, 2), y: round(best.y, 2) })
}

pub fn dist2d(a: (f64, f64), b: (f64, f64)) -> f64 {
	js_hypot(a.0 - b.0, a.1 - b.1)
}

/// A TaxiPathNode point.
#[derive(Clone, Copy, Debug)]
pub struct Pt {
	pub i: f64,
	pub c: f64,
	pub wx: f64,
	pub wy: f64,
	pub z: f64,
	pub flags: f64,
	pub delay: f64,
}

pub const JUMP_YARDS: f64 = 3000.0;

pub fn is_jump(a: &Pt, b: &Pt) -> bool {
	a.c != b.c || (crate::jsv::to_int32(a.flags) & 1) != 0 || dist2d((a.wx, a.wy), (b.wx, b.wy)) > JUMP_YARDS
}
