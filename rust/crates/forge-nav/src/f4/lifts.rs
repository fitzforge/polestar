//! Leffe's lift layer: the lifts his format-4 maps keep out of the walking graph (a transport layer on top of it, as
//! in Shortest Path Forever), spliced into the f4 search as rides. Credit: Leffe's lift layer (its lifts.json, which
//! the grid builder found in the client's transport animations, and the reviewed Thunder Bluff and Undercity lift
//! rule of his Travel.lua). GPL-3.0-or-later.
//!
//! The file: `lift-layer/lifts.json` in the pack folder (the one holding `Nav/`), else beside it
//! (`<pack>/../lift-layer/lifts.json`). It names each landing by a cell of the grid that built the pack (tile col and
//! row, column k, the grid's entry, height z), so it is used only on that build: LAYERS pairs a layer's content
//! (SHA-256) with that grid's build config, which must be the pack's (PACK.json `grid.buildConfig`), and every
//! landing must stand on the pack's walkable surface (within LAND_Z_YD of its height).
//!
//! The floor rule (Travel.lua, reviewed): Thunder Bluff's bluff (uiMap 1456) and its ground (1412), the Undercity
//! (1458) and the Ruins of Lordaeron (1420) are joined only by their lifts (GROUPS). A walk whose ends are on
//! opposite sides of a group takes one of its lifts: a way through an incidental entrance (the Undercity's west
//! sewer pipe) never stands in. A lift of the layer that would join opposite sides of a group anywhere but at one of
//! its reviewed shafts is left out.

use rustc_hash::FxHashMap;

pub const FILE: &str = "lifts.json";
/// A landing stands on the pack's surface within this many yards of its height.
pub const LAND_Z_YD: f64 = 3.0;
/// Travel.lua: a reviewed lift's landings lie within 20 yd of its shaft.
const SHAFT_YD: f64 = 20.0;
/// A reviewed lift's landings lie within this many yards of its top and bottom heights.
const SHAFT_Z_YD: f64 = 2.0;
/// The grid's tile and cell (grid.rs ADT, CELL).
const ADT: f64 = 1600.0 / 3.0;
const CELL: f64 = ADT / 256.0;

/// Lift layers by their lifts.json's SHA-256, with the build config of the grid they were found on (Leffe's lift
/// layer of 2026-10-24: the grid of `polestar-rust-fixed-70532-2026-10-23-candidate`).
pub const LAYERS: &[(&str, &str)] = &[("1933921f004e8c2a2dfb72d6faa02570d268fd34d5b322b8b5c214f1692e1cf1", "ad1802f4455e427ed8b7769aab25b0c0")];

/// A reviewed lift: its shaft and the heights of its top and bottom (Travel.lua reviewedLifts); `walks`: whether
/// walks may cross the city's floors by it (Fitz, 2026-10-25: the Undercity's south lift only, as the in-game
/// planner's fixed way in and out, undercity-south-lift; both of Thunder Bluff's).
#[derive(Debug)]
pub struct Shaft {
	pub id: &'static str,
	pub wx: f64,
	pub wy: f64,
	pub top: f64,
	pub bottom: f64,
	pub walks: bool,
}

/// A city whose floors only its lifts join (Travel.lua forced): a point is inside on the side of `middle` it lies on
/// (above when inner_above) when on its uiMap `map` or within `footprint` of a shaft. Forge's walk ends carry no
/// uiMap of their own (the pack's zone of a point is its ground's: the Ruins' over the whole Undercity), so the
/// footprint covers the city: the Undercity's floors reach 350 yd from its shafts and no ground outside lies below
/// its middle within 650 yd (Leffe's surfaces, 2026-10-25); Thunder Bluff's is Travel.lua's 400 yd. A point of
/// unknown height is inside on the map or near an anchor, outside away from the footprint, and on no side within it.
#[derive(Debug)]
pub struct Group {
	pub id: &'static str,
	pub c: u32,
	pub map: u32,
	pub footprint: f64,
	pub middle: f64,
	pub inner_above: bool,
	pub anchor: Option<(f64, f64, f64)>,
	pub shafts: &'static [Shaft],
}

pub static GROUPS: [Group; 2] = [
	Group {
		id: "thunder-bluff",
		c: 1,
		map: 1456,
		footprint: 400.0,
		middle: 102.0,
		inner_above: true,
		// Tal's flight path (no height in the travel data) is on the bluff.
		anchor: Some((-1197.2, 29.7, 60.0)),
		shafts: &[
			Shaft { id: "lift-thunder-bluff-north", wx: -1032.7, wy: -38.8, top: 140.5, bottom: 69.1, walks: true },
			Shaft { id: "lift-thunder-bluff-west", wx: -1297.3, wy: 187.5, top: 130.1, bottom: 68.7, walks: true },
		],
	},
	Group {
		id: "undercity",
		c: 0,
		map: 1458,
		footprint: 400.0,
		middle: 7.45,
		inner_above: false,
		anchor: None,
		shafts: &[
			Shaft { id: "lift-undercity-east", wx: 1595.3, wy: 188.6, top: 55.7, bottom: -40.8, walks: false },
			Shaft { id: "lift-undercity-south", wx: 1544.2, wy: 240.8, top: 55.7, bottom: -40.8, walks: true },
			Shaft { id: "lift-undercity-west", wx: 1596.2, wy: 291.8, top: 55.7, bottom: -40.8, walks: false },
		],
	},
];

/// The lift-separated city of continent c.
pub fn group_of(c: u32) -> Option<&'static Group> {
	GROUPS.iter().find(|g| g.c == c)
}

impl Group {
	fn near_shaft(&self, x: f64, y: f64) -> bool {
		self.shafts.iter().any(|s| (x - s.wx).powi(2) + (y - s.wy).powi(2) <= self.footprint * self.footprint)
	}
	/// Travel.lua forcedInside: whether a point (its uiMap `zone` when known) is inside the city; None: a point of
	/// unknown height within the footprint, on either side.
	pub fn inside(&self, x: f64, y: f64, z: Option<f64>, zone: Option<u32>) -> Option<bool> {
		let on_map = zone == Some(self.map);
		match z {
			Some(z) => Some((on_map || self.near_shaft(x, y)) && (z > self.middle) == self.inner_above),
			None if on_map || self.anchor.is_some_and(|(ax, ay, r)| (x - ax).powi(2) + (y - ay).powi(2) <= r * r) => Some(true),
			None if self.near_shaft(x, y) => None,
			None => Some(false),
		}
	}
	/// Travel.lua rawForcedInside: a landing's side, by its shaft and height alone.
	fn landing_inside(&self, l: &Landing) -> bool {
		self.near_shaft(l.x, l.y) && (l.z > self.middle) == self.inner_above
	}
	/// The reviewed shaft a car's landings belong to.
	fn shaft_of(&self, a: &Landing, b: &Landing) -> Option<&'static Shaft> {
		let (lo, hi) = if a.z <= b.z { (a, b) } else { (b, a) };
		self.shafts.iter().find(|s| {
			let near = |l: &Landing| (l.x - s.wx).powi(2) + (l.y - s.wy).powi(2) <= SHAFT_YD * SHAFT_YD;
			near(lo) && near(hi) && (lo.z - s.bottom).abs() <= SHAFT_Z_YD && (hi.z - s.top).abs() <= SHAFT_Z_YD
		})
	}
}

/// A landing: world x (north), y (west), height; k and node: where it stands on the pack (resolved on load).
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Landing {
	pub x: f64,
	pub y: f64,
	pub z: f64,
	pub k: u32,
	pub node: u32,
}

/// One car of a lift: its two landings (lifts.json a, b), its name and GameObject, and the reviewed shaft it rides.
#[derive(Clone, Debug)]
pub struct Car {
	pub name: String,
	pub object: String,
	pub ends: [Landing; 2],
	pub shaft: Option<&'static str>,
}

/// A loaded layer: its content hash, the grid build it is for and its cars by continent (landings unresolved).
#[derive(Clone, Debug)]
pub struct Layer {
	pub id: String,
	pub build: &'static str,
	pub maps: Vec<(u32, Vec<Car>)>,
}

/// lifts.json -> its cars by continent, in file order: each landing at its cell's centre and its height. A car of a
/// lift-separated city that would join its sides away from a reviewed shaft is left out (named in the Err list).
pub fn parse(bytes: &[u8]) -> Result<(Vec<(u32, Vec<Car>)>, Vec<String>), String> {
	let v: serde_json::Value = serde_json::from_slice(bytes).map_err(|e| format!("lifts.json: {e}"))?;
	let obj = v.as_object().ok_or("lifts.json: not an object of continents")?;
	let mut maps = Vec::new();
	let mut left = Vec::new();
	for (c, list) in obj {
		let c: u32 = c.parse().map_err(|_| format!("lifts.json: continent {c:?}"))?;
		let mut cars = Vec::new();
		for l in list.as_array().ok_or_else(|| format!("lifts.json: continent {c}: not a list"))? {
			let end = |e: &serde_json::Value| -> Result<Landing, String> {
				let f = |n: &str| e[n].as_f64().ok_or_else(|| format!("lifts.json: continent {c}: a landing without {n}"));
				let (col, row, k, z) = (f("col")?, f("row")?, f("k")? as u32, f("z")?);
				let (i, j) = ((k & 255) as f64, (k >> 8) as f64);
				Ok(Landing { x: (32.0 - row) * ADT - (j + 0.5) * CELL, y: (32.0 - col) * ADT - (i + 0.5) * CELL, z, k: 0, node: 0 })
			};
			let (a, b) = (end(&l["a"])?, end(&l["b"])?);
			let name = l["name"].as_str().unwrap_or("lift").to_string();
			let object = match &l["id"] {
				serde_json::Value::String(s) => s.clone(),
				x => x.to_string(),
			};
			let mut shaft = None;
			if let Some(g) = group_of(c) {
				let s = g.shaft_of(&a, &b);
				if let Some(s) = s.filter(|s| !s.walks) {
					left.push(format!("{name} {object} (continent {c}): {} is not a way in or out for walks", s.id));
					continue;
				}
				shaft = s.map(|s| s.id);
				if shaft.is_none() && g.landing_inside(&a) != g.landing_inside(&b) {
					left.push(format!("{name} {object} (continent {c}) would join {}'s floors away from its reviewed lifts", g.id));
					continue;
				}
			}
			cars.push(Car { name, object, ends: [a, b], shaft });
		}
		maps.push((c, cars));
	}
	Ok((maps, left))
}

/// The layer for a pack: `lift-layer/lifts.json` in the pack folder, else beside it. `nav_dir`: the folder holding
/// Nav.xml (the pack folder is its parent).
#[cfg(feature = "native")]
pub fn find(nav_dir: &std::path::Path) -> Option<std::path::PathBuf> {
	let pack = nav_dir.parent()?;
	[pack.join("lift-layer").join(FILE), pack.parent()?.join("lift-layer").join(FILE)].into_iter().find(|p| p.is_file())
}

/// Reads the layer at `file` for the pack whose Nav folder is `nav_dir`. Err: why it does not fit the pack.
#[cfg(feature = "native")]
pub fn load(file: &std::path::Path, nav_dir: &std::path::Path) -> Result<(Layer, Vec<String>), String> {
	use sha2::{Digest, Sha256};
	let bytes = std::fs::read(file).map_err(|e| format!("{}: {e}", file.display()))?;
	let id: String = Sha256::digest(&bytes).iter().map(|b| format!("{b:02x}")).collect();
	let Some(&(_, build)) = LAYERS.iter().find(|l| l.0 == id) else {
		return Err(format!("an unknown layer (sha256 {}): its grid build is not on record", &id[..12]));
	};
	let pack_json = nav_dir.parent().map(|p| p.join("PACK.json"));
	let pack: serde_json::Value = pack_json
		.as_ref()
		.and_then(|p| std::fs::read(p).ok())
		.and_then(|b| serde_json::from_slice(&b).ok())
		.ok_or_else(|| format!("the maps have no PACK.json beside Nav/ to tell their build (the layer is for grid build config {build})"))?;
	let theirs = pack["grid"]["buildConfig"].as_str().unwrap_or("");
	if theirs != build {
		return Err(format!("it is for grid build config {build}, the maps are {} ({})", if theirs.is_empty() { "unknown" } else { theirs }, pack["grid"]["build"].as_str().unwrap_or("?")));
	}
	let (maps, left) = parse(&bytes)?;
	Ok((Layer { id, build, maps }, left))
}

/// The cars of one map, resolved on the pack: per car its landings' (cluster, node).
#[derive(Clone, Debug, Default)]
pub struct MapLifts {
	pub cars: Vec<Car>,
	pub group: Option<&'static Group>,
}

/// Cars by map.
pub type ByMap = FxHashMap<u32, std::sync::Arc<MapLifts>>;

/// lift_seconds of our grid (cost.rs, move.js liftSeconds): 15 s of wait and boarding, 4 yd/s of shaft.
pub fn ride_seconds(h: f64) -> f64 {
	15.0 + h.abs() / 4.0
}
/// cost.rs RUN: a walks cost is seconds × RUN.
pub const RUN: f64 = 7.0;

#[cfg(test)]
mod tests {
	use super::*;

	// Four cars: the Undercity's south and east Undervators (landings at their reviewed shafts), a car joining the
	// Undercity's floors 42 yd from any shaft, the Great Lift's (no lift-separated city there).
	const LAYER: &str = r#"{
		"0": [
			{ "name": "Undervator", "id": 20655, "a": { "col": 31, "row": 29, "k": 6796, "entry": 1, "z": -41.4 }, "b": { "col": 31, "row": 29, "k": 5772, "entry": 2, "z": 55.2 }, "h": 96.6 },
			{ "name": "Undervator", "id": 20652, "a": { "col": 31, "row": 29, "k": 677, "entry": 3, "z": -41.4 }, "b": { "col": 31, "row": 29, "k": 673, "entry": 4, "z": 55.2 }, "h": 96.6 },
			{ "name": "Fake", "id": 1, "a": { "col": 31, "row": 29, "k": 697, "entry": 5, "z": -41.4 }, "b": { "col": 31, "row": 29, "k": 693, "entry": 6, "z": 55.2 }, "h": 96.6 }
		],
		"1": [
			{ "name": "Mesa Elevator", "id": 11898, "a": { "col": 35, "row": 40, "k": 49003, "entry": 7, "z": -43.9 }, "b": { "col": 35, "row": 40, "k": 48492, "entry": 8, "z": 85.6 }, "h": 129.5 }
		]
	}"#;

	#[test]
	fn a_layer_keeps_the_undercitys_south_lift_alone_and_leaves_out_a_car_joining_a_citys_floors_elsewhere() {
		let (maps, left) = parse(LAYER.as_bytes()).unwrap();
		let uc = &maps.iter().find(|m| m.0 == 0).unwrap().1;
		assert_eq!(uc.len(), 1, "the east lift and the fake car are left out");
		assert_eq!(uc[0].shaft, Some("lift-undercity-south"));
		let a = uc[0].ends[0];
		assert!((a.x - 1544.8).abs() < 0.1 && (a.y - 240.6).abs() < 0.1 && a.z == -41.4, "the landing at its cell's centre: {a:?}");
		assert_eq!(left.len(), 2);
		assert!(left[0].contains("20652") && left[0].contains("lift-undercity-east"), "{left:?}");
		assert!(left[1].contains("Fake 1") && left[1].contains("undercity"), "{left:?}");
		let great = &maps.iter().find(|m| m.0 == 1).unwrap().1;
		assert_eq!((great.len(), great[0].shaft), (1, None), "an ordinary ride away from Thunder Bluff");
	}

	#[test]
	fn the_floor_rule_puts_the_undercity_below_the_ruins_and_the_bluff_above_mulgore() {
		let uc = group_of(0).unwrap();
		assert_eq!(uc.inside(1290.4, 316.2, Some(-57.2), Some(1421)), Some(true), "the Royal Quarter, whatever the pack's zone");
		assert_eq!(uc.inside(1600.0, 230.0, Some(55.0), Some(1420)), Some(false), "the ruins above the shafts");
		assert_eq!(uc.inside(2250.0, 290.0, Some(34.0), Some(1420)), Some(false), "Brill");
		assert_eq!(uc.inside(1290.4, 316.2, None, Some(1420)), None, "no height over the city: either side");
		assert_eq!(uc.inside(2250.0, 290.0, None, Some(1420)), Some(false), "no height away from it: outside");
		let tb = group_of(1).unwrap();
		assert_eq!((tb.inside(-1196.7, 26.1, Some(177.0), Some(1456)), tb.inside(-992.7, -1109.1, Some(44.5), Some(1412))), (Some(true), Some(false)));
		assert_eq!(tb.inside(-1197.2, 29.7, None, Some(1412)), Some(true), "Tal's flight path, heightless, on the bluff");
	}
}
