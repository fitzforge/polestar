//! Map frames and route points (port of tools/lib/route/geo.js makeProjector, dist, segDist).
//! Map percent converts to world yards through map-frames.json:
//! `wx = top + (bottom - top) * y/100`, `wy = left + (right - left) * x/100` (x north, y west).
//! Live-frame ("l") spawns convert through the Forever bounds and come back in the Era frame
//! when the map has Era bounds on the same continent; a map only Forever has keeps its frame.

use crate::jsnum::{js_hypot, round2};
use crate::{Continent, MapId};
use rustc_hash::FxHashMap;
use serde::Deserialize;
use std::sync::Mutex;

/// Distance between points on different continents: finite so tour arithmetic stays exact.
pub const FAR: f64 = 1e6;

/// A spawn's frame: Era ("e") or live Forever ("l").
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum Frame {
	Era,
	Live,
}

impl Frame {
	pub fn parse(s: &str) -> Option<Frame> {
		match s {
			"e" => Some(Frame::Era),
			"l" => Some(Frame::Live),
			_ => None,
		}
	}
	pub fn as_str(self) -> &'static str {
		match self {
			Frame::Era => "e",
			Frame::Live => "l",
		}
	}
}

/// One map's bounds in world yards; `c` the instance map (continent).
#[derive(Clone, Copy, Debug, Deserialize, PartialEq)]
pub struct Bounds {
	pub c: Continent,
	pub left: Option<f64>,
	pub right: Option<f64>,
	pub top: Option<f64>,
	pub bottom: Option<f64>,
}

/// Bounds with every side present.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Rect {
	pub c: Continent,
	pub left: f64,
	pub right: f64,
	pub top: f64,
	pub bottom: f64,
}

impl Bounds {
	pub fn rect(&self) -> Option<Rect> {
		Some(Rect { c: self.c, left: self.left?, right: self.right?, top: self.top?, bottom: self.bottom? })
	}
}

/// map-frames.json: `{ era: { map: bounds }, forever: { map: bounds } }`.
#[derive(Clone, Debug, Default, Deserialize)]
pub struct MapFrames {
	#[serde(default)]
	pub era: FxHashMap<String, Bounds>,
	#[serde(default)]
	pub forever: FxHashMap<String, Bounds>,
}

impl MapFrames {
	pub fn from_json(bytes: &[u8]) -> Result<Self, serde_json::Error> {
		let raw: MapFramesRaw = serde_json::from_slice(bytes)?;
		Ok(MapFrames { era: raw.era.unwrap_or_default(), forever: raw.forever.unwrap_or_default() })
	}
}

#[derive(Deserialize)]
struct MapFramesRaw {
	era: Option<FxHashMap<String, Bounds>>,
	forever: Option<FxHashMap<String, Bounds>>,
}

/// A route point: map percent in frame `f` (None when author-given) plus world yards.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct RoutePoint {
	pub map: MapId,
	pub x: f64,
	pub y: f64,
	pub f: Option<Frame>,
	pub c: Continent,
	pub wx: f64,
	pub wy: f64,
}

/// Converts map percent to world yards (geo.js makeProjector). Integer-keyed copies of the
/// frames; maps without bounds fall back to a 1000-yard square on continent `-map`, warned once.
pub struct Projector {
	era: FxHashMap<MapId, Rect>,
	forever: FxHashMap<MapId, Rect>,
	era_present: FxHashMap<MapId, Bounds>,
	warned: Mutex<Vec<MapId>>,
}

impl Projector {
	pub fn new(frames: &MapFrames) -> Self {
		let conv = |m: &FxHashMap<String, Bounds>| -> FxHashMap<MapId, Rect> { m.iter().filter_map(|(k, b)| Some((k.parse().ok()?, b.rect()?))).collect() };
		Projector { era: conv(&frames.era), forever: conv(&frames.forever), era_present: frames.era.iter().filter_map(|(k, b)| Some((k.parse().ok()?, *b))).collect(), warned: Mutex::new(Vec::new()) }
	}

	/// The map's Era bounds, else its Forever ones, else the fallback square on `-map`.
	pub fn bounds(&self, map: MapId) -> Rect {
		if let Some(b) = self.era.get(&map) {
			return *b;
		}
		if let Some(b) = self.forever.get(&map) {
			return *b;
		}
		let mut w = self.warned.lock().expect("warned");
		if !w.contains(&map) {
			w.push(map);
		}
		Rect { c: -(map as Continent), left: 0.0, right: -1000.0, top: 0.0, bottom: -1000.0 }
	}

	/// Era bounds (all sides present).
	pub fn era_bounds(&self, map: MapId) -> Option<Rect> {
		self.era.get(&map).copied()
	}

	/// Forever (live) bounds (all sides present).
	pub fn live_bounds(&self, map: MapId) -> Option<Rect> {
		self.forever.get(&map).copied()
	}

	/// Maps asked for without bounds, in first-asked order (geo.js warns once per map).
	pub fn unbounded_maps(&self) -> Vec<MapId> {
		self.warned.lock().expect("warned").clone()
	}

	/// geo.js `point(map, x, y, f)`.
	pub fn point(&self, map: MapId, x: f64, y: f64, f: Option<Frame>) -> RoutePoint {
		if f == Some(Frame::Live) {
			if let Some(lb) = self.live_bounds(map) {
				let wx = lb.top + ((lb.bottom - lb.top) * y) / 100.0;
				let wy = lb.left + ((lb.right - lb.left) * x) / 100.0;
				if let Some(eb) = self.era.get(&map) {
					if eb.c == lb.c {
						return RoutePoint {
							map,
							x: round2(((wy - eb.left) / (eb.right - eb.left)) * 100.0),
							y: round2(((wx - eb.top) / (eb.bottom - eb.top)) * 100.0),
							f: Some(Frame::Era),
							c: eb.c,
							wx,
							wy,
						};
					}
				}
				// geo.js: `if (!eb)` — an Era entry (even one without full bounds, or on
				// another continent) falls through to bounds().
				if !self.era_present.contains_key(&map) {
					return RoutePoint { map, x, y, f, c: lb.c, wx, wy };
				}
			}
		}
		let b = self.bounds(map);
		RoutePoint { map, x, y, f, c: b.c, wx: b.top + ((b.bottom - b.top) * y) / 100.0, wy: b.left + ((b.right - b.left) * x) / 100.0 }
	}
}

/// Yards between two points; `FAR` across continents (geo.js dist).
pub fn dist(a: &RoutePoint, b: &RoutePoint) -> f64 {
	if a.c != b.c {
		return FAR;
	}
	js_hypot(a.wx - b.wx, a.wy - b.wy)
}

/// Yards from `p` to the segment a-b (geo.js segDist).
pub fn seg_dist(p: &RoutePoint, a: &RoutePoint, b: &RoutePoint) -> f64 {
	if p.c != a.c || p.c != b.c {
		return dist(p, a).min(dist(p, b));
	}
	let dx = b.wx - a.wx;
	let dy = b.wy - a.wy;
	let len2 = dx * dx + dy * dy;
	let mut t = if len2 > 0.0 { ((p.wx - a.wx) * dx + (p.wy - a.wy) * dy) / len2 } else { 0.0 };
	t = t.clamp(0.0, 1.0);
	js_hypot(p.wx - (a.wx + t * dx), p.wy - (a.wy + t * dy))
}

#[cfg(test)]
mod tests {
	use super::*;

	fn frames() -> MapFrames {
		MapFrames::from_json(
			br#"{"era":{"1411":{"c":1,"left":-1962.5,"right":-7250,"top":1808.333,"bottom":-1716.667}},
                 "forever":{"1411":{"c":1,"left":-1962.5,"right":-7250,"top":1808.333,"bottom":-1716.667},
                            "2521":{"c":2991,"left":100,"right":-100,"top":100,"bottom":-100}}}"#,
		)
		.unwrap()
	}

	#[test]
	fn projects_like_geo() {
		let p = Projector::new(&frames());
		let a = p.point(1411, 50.0, 50.0, Some(Frame::Era));
		assert_eq!(a.c, 1);
		assert_eq!(a.wx, 1808.333 + ((-1716.667 - 1808.333) * 50.0) / 100.0);
		let l = p.point(1411, 50.0, 50.0, Some(Frame::Live));
		assert_eq!(l.f, Some(Frame::Era));
		assert_eq!((l.x, l.y), (50.0, 50.0));
		let isle = p.point(2521, 10.0, 10.0, Some(Frame::Live));
		assert_eq!((isle.c, isle.f), (2991, Some(Frame::Live)));
		let none = p.point(9999, 0.0, 0.0, None);
		assert_eq!(none.c, -9999);
		assert_eq!(p.unbounded_maps(), vec![9999]);
	}
}
