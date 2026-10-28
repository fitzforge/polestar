//! Walks the evaluator asks for: routed yards between two world points.
//!
//! `Walks` is the interface (forge-nav's walk store takes it over when it lands). Today's
//! implementation, `WalkTable`, reads `data/sim/walks-<faction>.bin` (tools/lib/sim/binfile.js
//! layout) with v1's semantics (walks.js `attachWalks`): one walk per pair, band 30's where it
//! was re-routed, else band 0's; yards × the document's `smooth`; within a band both-ways walks
//! first, one-way walks over them, and the last entry of a pair wins. Pairs it lacks fall back
//! to the straight line × detour in the evaluator (v1 does not read `unwalkable`), but only
//! within the store's `radius`: a pair beyond it was never asked, and the straight line there
//! may cross a sea or a mountain range (travel.rs direct_walk).

use rustc_hash::FxHashMap;

/// Routed walking yards from world point `a` to world point `b`, or None (no routed walk).
pub trait Walks: Sync + Send {
	fn yards(&self, a: u32, b: u32) -> Option<f64>;
	/// Straight yards within which the store asked every pair of points (the walks document's
	/// `radius`): a pair it lacks beyond it has no walk. None: no store (every leg straight).
	fn radius(&self) -> Option<f64> {
		None
	}
}

/// No routed walks: every leg is the straight line × detour (the gate's model, walks off).
pub struct NoWalks;

impl Walks for NoWalks {
	fn yards(&self, _: u32, _: u32) -> Option<f64> {
		None
	}
}

/// The band v1 runs take where a pair was re-routed (walks.js V1_BAND).
pub const V1_BAND: u32 = 30;

pub struct WalkTable {
	pub nw: u64,
	pub smooth: f64,
	pub data_hash: String,
	/// The world's walk inputs the walks were built on (World::walks_key; empty in older files).
	pub walks_key: String,
	/// The document's `radius` (yards; None in a file without one).
	pub radius: Option<f64>,
	map: FxHashMap<u64, f64>,
}

impl Walks for WalkTable {
	#[inline]
	fn yards(&self, a: u32, b: u32) -> Option<f64> {
		self.map.get(&(a as u64 * self.nw + b as u64)).copied()
	}
	fn radius(&self) -> Option<f64> {
		self.radius
	}
}

const MAGIC: u32 = 0x4e42_5350;

impl WalkTable {
	pub fn len(&self) -> usize {
		self.map.len()
	}

	pub fn is_empty(&self) -> bool {
		self.map.is_empty()
	}

	/// From a walks .bin's bytes; `nw`: the world's point count (keys are a * nw + b). The
	/// world must be the one the walks were built on (its `dataHash` and point ids).
	pub fn from_bin(bytes: &[u8], nw: usize) -> Result<WalkTable, String> {
		if bytes.len() < 12 || u32::from_le_bytes(bytes[0..4].try_into().unwrap()) != MAGIC {
			return Err("not a binary data file".into());
		}
		let n = u32::from_le_bytes(bytes[8..12].try_into().unwrap()) as usize;
		let header: serde_json::Value = serde_json::from_slice(&bytes[12..12 + n]).map_err(|e| e.to_string())?;
		let smooth = header.get("smooth").and_then(|v| v.as_f64()).unwrap_or(0.965);
		let sections = header.get("sections").and_then(|v| v.as_object()).ok_or("no sections")?;
		let f64s = |name: &str| -> Option<Vec<f64>> {
			let s = sections.get(name)?.as_array()?;
			if s[0].as_str()? != "Float64Array" {
				return None;
			}
			let at = s[1].as_u64()? as usize;
			let len = s[2].as_u64()? as usize;
			Some(bytes[at..at + len * 8].chunks_exact(8).map(|c| f64::from_le_bytes(c.try_into().unwrap())).collect())
		};
		let nwu = nw as u64;
		let id = |p: f64| -> Option<u64> { Some(p as u64) };
		let mut map: FxHashMap<u64, f64> = FxHashMap::default();
		// The .bin stores 5 values a pair (writeWalks): a, b, yards, cost, oneWay.
		const STRIDE: usize = 5;
		for band in ["p0".to_string(), format!("p{V1_BAND}")] {
			let Some(arr) = f64s(&band) else { continue };
			map.reserve(arr.len() / STRIDE * 2);
			for one in [false, true] {
				for pair in arr.chunks_exact(STRIDE) {
					if (pair[4] == 1.0) != one {
						continue;
					}
					if let (Some(a), Some(b)) = (id(pair[0]), id(pair[1])) {
						let y = pair[2] * smooth;
						map.insert(a * nwu + b, y);
						if !one {
							map.insert(b * nwu + a, y);
						}
					}
				}
			}
		}
		let s = |k: &str| header.get(k).and_then(|v| v.as_str()).unwrap_or("").to_string();
		let radius = header.get("radius").and_then(|v| v.as_f64()).filter(|r| *r > 0.0);
		Ok(WalkTable { nw: nwu, smooth, data_hash: s("dataHash"), walks_key: s("walksKey"), radius, map })
	}

	/// Whether these walks are the ones of `world`: the same walk inputs (`walksKey`, World::walks_key:
	/// its points and the places walked to; a data fix that touches neither keeps them), or for a walks
	/// file without one, the same `dataHash`. An unknown side counts as the same.
	pub fn built_on(&self, world: &forge_world::World) -> bool {
		if !self.walks_key.is_empty() {
			return self.walks_key == world.walks_key();
		}
		world.data_hash.as_deref().is_none_or(|h| self.data_hash.is_empty() || h == self.data_hash)
	}

	/// What `built_on` compares, for messages: this file's key and the world's.
	pub fn built_on_text(&self, world: &forge_world::World) -> String {
		if self.walks_key.is_empty() {
			format!("dataHash {} vs this world's {}", self.data_hash, world.data_hash.as_deref().unwrap_or("-"))
		} else {
			format!("walksKey {} vs this world's {}", self.walks_key, world.walks_key())
		}
	}

	#[cfg(feature = "native")]
	pub fn load(path: &std::path::Path, nw: usize) -> Result<WalkTable, String> {
		let b = std::fs::read(path).map_err(|e| format!("{}: {e}", path.display()))?;
		WalkTable::from_bin(&b, nw)
	}
}
