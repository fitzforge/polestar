//! Heights for points without a source's (world.js gridFloor): the walking grid's surfaces at a
//! place, `[snap's z, ...open storeys ascending]`, or none. The grid itself belongs to the nav
//! crate; the world takes any `Floors` and ships two: the JS builder's cache file
//! (`<simDir>/floors.json`, key `${c}:${wx}:${wy}` with JS number strings) and none.

use forge_core::js_to_string;
use rustc_hash::FxHashMap;

/// Height storeys stacked closer than this are one (world.js Z_STEP).
pub const Z_STEP: f64 = 3.0;

pub trait Floors {
	/// The surfaces at (c, wx, wy): `Some(vec![])` none reachable, `None` unknown to this source.
	fn surfaces(&self, c: i64, wx: f64, wy: f64) -> Option<Vec<f64>>;
}

/// No grid: every point without a source height has none.
pub struct NoFloors;

impl Floors for NoFloors {
	fn surfaces(&self, _: i64, _: f64, _: f64) -> Option<Vec<f64>> {
		Some(Vec::new())
	}
}

/// The JS world builder's floors cache (`{ key, floors: { "c:wx:wy": [z, ...] | 0 } }`).
pub struct FloorCache {
	pub key: String,
	map: FxHashMap<String, Vec<f64>>,
}

impl FloorCache {
	pub fn from_json(bytes: &[u8]) -> Result<FloorCache, serde_json::Error> {
		#[derive(serde::Deserialize)]
		struct Doc {
			key: String,
			floors: FxHashMap<String, serde_json::Value>,
		}
		let doc: Doc = serde_json::from_slice(bytes)?;
		let map = doc
			.floors
			.into_iter()
			.map(|(k, v)| {
				let zs = v.as_array().map(|a| a.iter().filter_map(serde_json::Value::as_f64).collect()).unwrap_or_default();
				(k, zs)
			})
			.collect();
		Ok(FloorCache { key: doc.key, map })
	}
	pub fn len(&self) -> usize {
		self.map.len()
	}
	pub fn is_empty(&self) -> bool {
		self.map.is_empty()
	}
}

impl Floors for FloorCache {
	fn surfaces(&self, c: i64, wx: f64, wy: f64) -> Option<Vec<f64>> {
		self.map.get(&format!("{c}:{}:{}", js_to_string(wx), js_to_string(wy))).cloned()
	}
}

/// gridFloor's answer from the surfaces: `{ z, floors }` or None (no surface). With a hint (a
/// nearby spawn's height) the storey nearest it, else snap's surface.
pub fn floor_of(v: &[f64], hint: Option<f64>) -> Option<(f64, u32)> {
	if v.is_empty() {
		return None;
	}
	let mut floors = 0;
	for i in 1..v.len() {
		if i == 1 || v[i] - v[i - 1] > Z_STEP {
			floors += 1;
		}
	}
	let mut z = v[0];
	if let Some(h) = hint.filter(|h| h.is_finite()) {
		for &s in &v[1..] {
			if (s - h).abs() < (z - h).abs() {
				z = s;
			}
		}
	}
	Some((z, floors))
}
