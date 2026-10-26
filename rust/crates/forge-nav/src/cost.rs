//! The cost model of time (ports of tools/lib/nav/move.js, edgecost.js, costs.js and router.js's
//! profile: ground, hubs, roads, danger areas), term by term: seconds of a link, times the
//! multiplier of the surface it enters (road 0.8, swim 3 run yards a swum yard, a hostile hub 20,
//! a dangerous zone's chunk 3 or 20).

use crate::grid::{flag, Tile, ADT, CELL, LINK_SLOPE, SAFE_FALL, TILE_CELLS};
use parking_lot::Mutex;
use rustc_hash::FxHashMap;
use std::sync::Arc;

pub const RUN: f64 = 7.0;
pub const SWIM_SPEED: f64 = 4.722222;
pub const JUMP_SECONDS: f64 = 0.5;
pub const SLOPE_MUL: [f64; 8] = [1.0, 4.0, 1.0, 1.0, 1.0, 1.0, 10.0, 2.0];

/// edgecost.js
pub const MODEL: u32 = 2;
pub const ROAD: f64 = 0.8;
pub const HUB: f64 = 20.0;
pub const ROAD_BIT: u8 = 1;
pub const SWIM: f64 = (3.0 * SWIM_SPEED) / RUN;
pub const FACE: f64 = 40.0;
pub const CLIMB: f64 = 1000.0;
pub const WALK_SLOPE_MUL: [f64; 8] = [1.0, FACE, 1.0, 1.0, 1.0, 1.0, CLIMB, 2.0];
pub const SETTLE_RADIUS: f64 = 25.0;
pub const SETTLE_RISE: f64 = 10.0;
pub const SETTLE_DROP: f64 = 30.0;
pub const SETTLE_TRIES: usize = 8;
/// costs.js
pub const HUB_ALLIANCE: u8 = 8;
pub const HUB_HORDE: u8 = 16;

// max/min, not clamp: a NaN height gives 0 here, as in move.js.
#[allow(clippy::manual_clamp)]
pub fn fall_damage(h: f64, into_water: bool) -> f64 {
	if into_water || h < SAFE_FALL {
		return 0.0;
	}
	(0.018 * h - 0.2426).max(0.0).min(1.0)
}

/// move.js fallSeconds.
pub fn fall_seconds(h: f64, into_water: bool) -> f64 {
	1.0 + 3.0 + (h - 5.0).max(0.0) + 20.0 * fall_damage(h, into_water)
}

/// move.js liftSeconds.
pub fn lift_seconds(h: f64) -> f64 {
	15.0 + h.abs() / 4.0
}

/// move.js segmentClass.
pub fn segment_class(code: u8, fa: u8, fb: u8) -> u8 {
	if code == crate::grid::cls::WALK || code == LINK_SLOPE {
		return if (fa | fb) & flag::INDOOR != 0 { crate::grid::cls::INDOOR } else { crate::grid::cls::WALK };
	}
	code
}

/// Roads and hubs of a grid (router.js readRoads, readHubs): the class byte of a column.
pub struct Ground {
	/// (c, col, row) -> 8192 bytes, one bit per column.
	pub roads: FxHashMap<(u32, u32, u32), Vec<u8>>,
	/// side (0 Alliance, 1 Horde) -> c -> flat [wx, wy, r, ...]
	pub disks: [FxHashMap<u32, Vec<f64>>; 2],
	pub roads_tag: String,
	pub hubs_tag: String,
}

impl Ground {
	/// roads: `<grid>/walk/roads-<c>-<tag>.bin` files read for `continents`; hubs: hubs.json bytes.
	pub fn load(grid_dir: &std::path::Path, roads_tag: &str, continents: &[u32], hubs_json: Option<&[u8]>) -> Result<Ground, String> {
		let mut roads = FxHashMap::default();
		for &c in continents {
			let f = grid_dir.join("walk").join(format!("roads-{c}-{roads_tag}.bin"));
			let Ok(b) = std::fs::read(&f) else { continue };
			let n = 4 + TILE_CELLS * TILE_CELLS / 8;
			let mut o = 0;
			while o + n <= b.len() {
				let col = u16::from_le_bytes([b[o], b[o + 1]]) as u32;
				let row = u16::from_le_bytes([b[o + 2], b[o + 3]]) as u32;
				roads.insert((c, col, row), b[o + 4..o + n].to_vec());
				o += n;
			}
		}
		let mut disks: [FxHashMap<u32, Vec<f64>>; 2] = [FxHashMap::default(), FxHashMap::default()];
		// router.js hubsTag: sha1 of JSON.stringify(the hubs document) [:12]; the layer file is
		// written by JSON.stringify, so its bytes (trimmed) are that text.
		let hubs_tag_src: Vec<u8> = hubs_json.map(|h| h.trim_ascii().to_vec()).unwrap_or_else(|| b"null".to_vec());
		if let Some(h) = hubs_json {
			let doc: serde_json::Value = serde_json::from_slice(h).map_err(|e| e.to_string())?;
			for (c, list) in doc.as_object().into_iter().flatten() {
				let Ok(c) = c.parse::<u32>() else { continue };
				for hub in list.as_array().into_iter().flatten() {
					let side = match hub["side"].as_str() {
						Some("Alliance") => 0,
						Some("Horde") => 1,
						_ => continue,
					};
					let v = disks[side].entry(c).or_default();
					for d in hub["disks"].as_array().into_iter().flatten() {
						v.extend([d[0].as_f64().unwrap_or(0.0), d[1].as_f64().unwrap_or(0.0), d[2].as_f64().unwrap_or(0.0)]);
					}
				}
			}
		}
		let hubs_tag = forge_core::key::content_key(&hubs_tag_src)[..12].to_string();
		Ok(Ground { roads, disks, roads_tag: roads_tag.to_string(), hubs_tag })
	}

	/// Whether tile (col, row) of continent c has any road column.
	pub fn has_road(&self, c: u32, col: i64, row: i64) -> bool {
		col >= 0 && row >= 0 && self.roads.get(&(c, col as u32, row as u32)).is_some_and(|m| m.iter().any(|&b| b != 0))
	}

	/// router.js readHubs near: a side's disks reaching tile (col, row).
	pub fn near(&self, side: usize, c: u32, col: u32, row: u32) -> Vec<f64> {
		let x_hi = (32.0 - row as f64) * ADT;
		let y_hi = (32.0 - col as f64) * ADT;
		let mut out = Vec::new();
		for d in self.disks[side].get(&c).map(|v| v.as_slice()).unwrap_or(&[]).chunks_exact(3) {
			let (hx, hy, r) = (d[0], d[1], d[2]);
			if hx + r >= x_hi - ADT && hx - r <= x_hi && hy + r >= y_hi - ADT && hy - r <= y_hi {
				out.extend_from_slice(d);
			}
		}
		out
	}

	/// router.js groundOf: the class byte of every column of a tile (kept on the tile).
	pub fn of<'a>(&self, t: &'a Tile) -> &'a [u8] {
		t.ground.get_or_init(|| {
			let mut g = vec![0u8; TILE_CELLS * TILE_CELLS];
			if let Some(m) = self.roads.get(&(t.c, t.col, t.row)) {
				for (k, v) in g.iter_mut().enumerate() {
					if m[k >> 3] & (1 << (k & 7)) != 0 {
						*v = ROAD_BIT;
					}
				}
			}
			let x1 = (32.0 - t.row as f64) * ADT;
			let y1 = (32.0 - t.col as f64) * ADT;
			for (side, bit) in [(0usize, HUB_ALLIANCE), (1usize, HUB_HORDE)] {
				let d = self.near(side, t.c, t.col, t.row);
				for q in d.chunks_exact(3) {
					let (hx, hy, r) = (q[0], q[1], q[2]);
					let j0 = 0f64.max(((x1 - hx - r) / CELL).floor() - 1.0) as i64;
					let j1 = ((TILE_CELLS - 1) as f64).min(((x1 - hx + r) / CELL).ceil() + 1.0) as i64;
					let i0 = 0f64.max(((y1 - hy - r) / CELL).floor() - 1.0) as i64;
					let i1 = ((TILE_CELLS - 1) as f64).min(((y1 - hy + r) / CELL).ceil() + 1.0) as i64;
					for j in j0..=j1 {
						let dx = ((hx - (x1 - (j as f64 + 0.5) * CELL)).abs() - CELL / 2.0).max(0.0);
						for i in i0..=i1 {
							let dy = ((hy - (y1 - (i as f64 + 0.5) * CELL)).abs() - CELL / 2.0).max(0.0);
							if dx * dx + dy * dy <= r * r {
								g[j as usize * TILE_CELLS + i as usize] |= bit;
							}
						}
					}
				}
			}
			g
		})
	}
}

/// AreaTable area -> uiMapID (pack.js zoneAreas: the area or its nearest ancestor that is a
/// zone), as the walking maps' zone field has it; the tag names its sources (router.js zonesTag).
pub struct Zones {
	pub of_area: FxHashMap<u32, u16>,
	pub tag: String,
	/// router.js gridZone's grids (the sim world's danger grids by continent, walks.js zonesOf):
	/// the zone off the walking grid's tiles.
	pub grids: Vec<ZoneGrid>,
}

/// A 200 yd zone grid (world.danger): zone of cell (gx, gy) at z[(gx - gx0) * ny + gy - gy0].
#[derive(Clone, Debug)]
pub struct ZoneGrid {
	pub c: u32,
	pub region: i64,
	pub gx0: i64,
	pub gy0: i64,
	pub nx: i64,
	pub ny: i64,
	pub cell: f64,
	pub z: Vec<u16>,
}

impl ZoneGrid {
	pub fn at_cell(&self, gx: i64, gy: i64) -> u16 {
		let (x, y) = (gx - self.gx0, gy - self.gy0);
		if x >= 0 && y >= 0 && x < self.nx && y < self.ny {
			self.z[(x * self.ny + y) as usize]
		} else {
			0
		}
	}
}

impl Zones {
	/// router.js gridZone.
	pub fn grid_zone(&self, c: u32, wx: f64, wy: f64) -> u16 {
		for g in self.grids.iter().filter(|g| g.c == c) {
			let z = g.at_cell((wx / g.cell).floor() as i64, (wy / g.cell).floor() as i64);
			if z != 0 {
				return z;
			}
		}
		0
	}

	/// The AreaTable's zones (pack.js zoneAreas: an area or its nearest zone ancestor, up to 8
	/// hops, over data/forever/zones.json's type-3 zones) and router.js's zonesTag.
	pub fn from_area_table(area_csv: &str, build: &str, zones_json: &[u8]) -> Result<Zones, String> {
		let mut lines = area_csv.lines();
		let head: Vec<String> = split_csv(lines.next().ok_or("AreaTable: empty")?);
		let col = |n: &str| head.iter().position(|h| h == n).ok_or(format!("AreaTable: no column {n}"));
		let (ci, cp) = (col("ID")?, col("ParentAreaID")?);
		let mut parent: FxHashMap<u32, u32> = FxHashMap::default();
		let mut ids = Vec::new();
		for l in lines {
			if l.is_empty() {
				continue;
			}
			let f = split_csv(l);
			let (Some(id), Some(p)) = (f.get(ci).and_then(|v| v.parse::<f64>().ok()), f.get(cp)) else { continue };
			parent.insert(id as u32, p.parse::<f64>().unwrap_or(0.0) as u32);
			ids.push(id as u32);
		}
		let doc: serde_json::Value = serde_json::from_slice(zones_json).map_err(|e| e.to_string())?;
		let mut by_area: FxHashMap<u32, u16> = FxHashMap::default();
		for z in doc.as_object().into_iter().flat_map(|o| o.values()) {
			if z["type"].as_f64() == Some(3.0) {
				if let (Some(a), Some(id)) = (z["areaId"].as_f64().filter(|a| *a != 0.0), z["id"].as_f64()) {
					by_area.insert(a as u32, id as u16);
				}
			}
		}
		let mut of_area = FxHashMap::default();
		for id in ids {
			let mut cur = id;
			for _ in 0..8 {
				if cur == 0 {
					break;
				}
				if let Some(&z) = by_area.get(&cur) {
					of_area.insert(id, z);
					break;
				}
				cur = parent.get(&cur).copied().unwrap_or(0);
			}
		}
		let mut h = forge_core::key::ContentHasher::new();
		h.update(format!("{build}\n").as_bytes()).update(zones_json);
		Ok(Zones { of_area, tag: h.hex()[..12].to_string(), grids: Vec::new() })
	}

	/// The zone of each of tile t's 16 x 16 chunks, kept on the tile.
	pub fn chunks<'a>(&self, t: &'a Tile) -> &'a [u16] {
		t.chunk_zone.get_or_init(|| t.areas.iter().map(|a| self.of_area.get(&(*a as u32)).copied().unwrap_or(0)).collect())
	}
}

/// A danger table over chunks (router.js makeArea): a step into a chunk of a zone in it costs
/// that many times.
pub struct Area {
	pub key: String,
	pub mult: FxHashMap<u16, f64>,
	zones: Arc<Zones>,
	tiles: Mutex<FxHashMap<(u32, u32, u32), Option<Arc<Vec<f32>>>>>,
}

impl Area {
	/// danger: zone -> multiplier; None when empty.
	pub fn new(danger: &[(u16, f64)], zones: Arc<Zones>) -> Option<Area> {
		if danger.is_empty() {
			return None;
		}
		let mut d: Vec<_> = danger.to_vec();
		d.sort_by_key(|x| x.0);
		let key = format!("-|{}", d.iter().map(|(z, m)| format!("{z}:{}", forge_core::jsnum::js_to_string(*m))).collect::<Vec<_>>().join(","));
		Some(Area { key, mult: d.into_iter().collect(), zones, tiles: Mutex::new(FxHashMap::default()) })
	}

	pub fn tile_danger(&self, t: &Tile) -> Option<Arc<Vec<f32>>> {
		let key = (t.c, t.col, t.row);
		if let Some(v) = self.tiles.lock().get(&key) {
			return v.clone();
		}
		let m: Vec<f32> = self.zones.chunks(t).iter().map(|z| self.mult.get(z).copied().unwrap_or(1.0) as f32).collect();
		let v = if m.iter().any(|&x| x > 1.0) { Some(Arc::new(m)) } else { None };
		self.tiles.lock().insert(key, v.clone());
		v
	}

	pub fn mult_at(&self, t: &Tile, k: usize) -> f64 {
		match self.tile_danger(t) {
			Some(g) => g[((k >> 12) << 4) + ((k & 255) >> 4)] as f64,
			None => 1.0,
		}
	}

	pub fn touches(&self, t: &Tile) -> bool {
		self.tile_danger(t).is_some()
	}

	pub fn zone_mult(&self, z: u16) -> f64 {
		self.mult.get(&z).copied().unwrap_or(1.0)
	}
}

/// A walking profile (router.js profileOf: move.js profileFor({}) with edgecost.js WALK's face
/// and slope prices, the ground term of a faction and an optional danger area).
pub struct Profile {
	pub name: String,
	pub run: f64,
	pub swim: f64,
	pub outdoor: f64,
	pub indoor: f64,
	pub remount: f64,
	pub face_mul: f64,
	pub slope_mul: [f64; 8],
	pub faction: Option<&'static str>,
	pub hostile: u8,
	pub ground_key: String,
	pub ground: Arc<Ground>,
	pub area: Option<Area>,
}

impl Profile {
	/// The foot profile ("any 1") of a faction (None, "Alliance", "Horde") with an optional danger table.
	pub fn walk(faction: Option<&'static str>, ground: Arc<Ground>, area: Option<Area>) -> Profile {
		let hostile = match faction {
			Some("Horde") => HUB_ALLIANCE,
			Some("Alliance") => HUB_HORDE,
			_ => 0,
		};
		Profile {
			name: "any 1".into(),
			run: RUN,
			swim: SWIM_SPEED,
			outdoor: RUN,
			indoor: RUN,
			remount: 0.0,
			face_mul: FACE,
			slope_mul: WALK_SLOPE_MUL,
			faction,
			hostile,
			ground_key: format!("{MODEL}|{}|{}|{}", ground.roads_tag, ground.hubs_tag, faction.unwrap_or("-")),
			ground,
			area,
		}
	}

	/// edgecost.js stepMult over the column's class byte.
	pub fn ground_mult(&self, t: &Tile, k: usize, flags: u8) -> f64 {
		let cls = self.ground.of(t)[k];
		let mut m = if flags & flag::SWIM != 0 {
			SWIM
		} else if cls & 7 == ROAD_BIT {
			ROAD
		} else {
			1.0
		};
		if cls & self.hostile != 0 {
			m *= HUB;
		}
		m
	}

	/// search.js areaAt.
	pub fn area_at(&self, t: &Tile, k: usize, flags: u8) -> f64 {
		let m = self.ground_mult(t, k, flags);
		match &self.area {
			Some(a) => m * a.mult_at(t, k),
			None => m,
		}
	}

	/// The profile's prices inside one tile (its class bytes and danger chunks looked up once).
	pub fn in_tile<'a>(&'a self, t: &'a Tile) -> TileCost<'a> {
		TileCost { p: self, ground: self.ground.of(t), danger: self.area.as_ref().and_then(|a| a.tile_danger(t)) }
	}

	/// move.js linkSeconds.
	pub fn link_seconds(&self, code: u8, fa: u8, fb: u8, d: f64) -> f64 {
		let mut s = if code == crate::grid::cls::SWIM { d / self.swim } else { (d * self.slope_mul[code as usize]) / (if (fa | fb) & flag::INDOOR != 0 { self.indoor } else { self.outdoor }) };
		if self.face_mul != 0.0 && code != crate::grid::cls::SWIM && (fa | fb) & flag::STEEP != 0 {
			s *= self.face_mul;
		}
		if code == crate::grid::cls::JUMP {
			s += JUMP_SECONDS;
		}
		if self.remount != 0.0 && fa & flag::INDOOR != 0 && fb & (flag::INDOOR | flag::SWIM) == 0 {
			s += self.remount;
		}
		s
	}

	/// path.js edgeKey for graph gi.
	pub fn edge_key(&self, gi: u32) -> String {
		let js = forge_core::jsnum::js_to_string;
		format!(
			"{gi}|{}|{}|{}|{}|{}|{}|{}",
			js(self.outdoor),
			js(self.indoor),
			js(self.swim),
			js(self.remount),
			js(self.face_mul),
			self.slope_mul.iter().map(|v| js(*v)).collect::<Vec<_>>().join(","),
			self.ground_key
		)
	}

	/// The leg cache's key part of a profile (path.js goalLegs: speeds and ground).
	pub fn leg_key(&self) -> String {
		let js = forge_core::jsnum::js_to_string;
		format!("{}:{}:{}:{}", js(self.outdoor), js(self.indoor), js(self.swim), self.ground_key)
	}
}

/// search.js areaAt inside one tile.
pub struct TileCost<'a> {
	pub p: &'a Profile,
	ground: &'a [u8],
	danger: Option<Arc<Vec<f32>>>,
}

impl TileCost<'_> {
	pub fn at(&self, k: usize, flags: u8) -> f64 {
		let cls = self.ground[k];
		let mut m = if flags & flag::SWIM != 0 {
			SWIM
		} else if cls & 7 == ROAD_BIT {
			ROAD
		} else {
			1.0
		};
		if cls & self.p.hostile != 0 {
			m *= HUB;
		}
		match &self.danger {
			Some(g) => m * g[((k >> 12) << 4) + ((k & 255) >> 4)] as f64,
			None => m,
		}
	}
}

/// router.js dangerOf: zones whose minimum level is above `level` + 10 cost ×20, from `level` + 4
/// ×3; the ends' zones are exempt. -> (zone, multiplier), sorted, empty for none.
pub fn danger_of(level: f64, zone_mins: &[(u16, f64)], za: u16, zb: u16) -> Vec<(u16, f64)> {
	let mut out: Vec<(u16, f64)> = zone_mins
		.iter()
		.filter_map(|&(z, min)| {
			let m = if min > level + 10.0 {
				20.0
			} else if min >= level + 4.0 {
				3.0
			} else {
				0.0
			};
			(m != 0.0 && z != za && z != zb).then_some((z, m))
		})
		.collect();
	out.sort_by_key(|x| x.0);
	out
}

/// One CSV line's fields (quoted fields with "" escapes).
fn split_csv(line: &str) -> Vec<String> {
	let mut out = Vec::new();
	let mut cur = String::new();
	let mut q = false;
	let mut it = line.chars().peekable();
	while let Some(ch) = it.next() {
		match ch {
			'"' if q && it.peek() == Some(&'"') => {
				cur.push('"');
				it.next();
			}
			'"' => q = !q,
			',' if !q => out.push(std::mem::take(&mut cur)),
			_ => cur.push(ch),
		}
	}
	out.push(cur);
	out
}
