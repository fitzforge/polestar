//! The inputs of the walking maps' ground classes and chokepoint names: the client's AreaTable
//! (capitals, zones, names), the map frames (the zone map around a point), and the ground layers
//! (roads/<c>/<col>_<row>.bin, hubs.json). Ports pack.js capitalAreas, zoneAreas, cityTest,
//! readLayers, chokepoints.js areaNames and travel/geo.js Frames.toWorld/containing.

use super::Hub;
use rustc_hash::FxHashMap;
use serde_json::Value;
use std::path::{Path, PathBuf};

/// AreaTable Flags_0: a capital city.
pub const AREA_CAPITAL: i64 = 0x100;

/// One AreaTable row (the columns the pack reads).
#[derive(Clone, Debug, Default)]
pub struct Area {
	pub id: u32,
	pub parent: u32,
	pub flags: i64,
	pub name: String,
	pub zone_name: String,
}

/// The client's AreaTable rows, in file order.
#[derive(Clone, Debug, Default)]
pub struct AreaTable {
	pub rows: Vec<Area>,
	pub by_id: FxHashMap<u32, usize>,
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

/// JS Number() of a CSV field (empty: 0, not a number: NaN).
fn num(s: Option<&String>) -> f64 {
	match s {
		None => f64::NAN,
		Some(s) if s.trim().is_empty() => 0.0,
		Some(s) => s.trim().parse::<f64>().unwrap_or(f64::NAN),
	}
}

impl AreaTable {
	pub fn parse(csv: &str) -> Result<AreaTable, String> {
		let mut lines = csv.lines();
		let head = split_csv(lines.next().ok_or("AreaTable: empty")?);
		let col = |n: &str| head.iter().position(|h| h == n);
		let ci = col("ID").ok_or("AreaTable: no ID column")?;
		let (cp, cf, cn, cz) = (col("ParentAreaID"), col("Flags_0"), col("AreaName_lang"), col("ZoneName"));
		let mut t = AreaTable::default();
		for l in lines {
			if l.is_empty() {
				continue;
			}
			let f = split_csv(l);
			let get = |c: Option<usize>| c.and_then(|c| f.get(c));
			let id = num(f.get(ci));
			if !id.is_finite() {
				continue;
			}
			let p = num(get(cp));
			let flags = num(get(cf));
			let a = Area {
				id: id as u32,
				parent: if p.is_finite() { p as u32 } else { 0 },
				flags: if flags.is_finite() { flags as i64 } else { 0 },
				name: get(cn).cloned().unwrap_or_default(),
				zone_name: get(cz).cloned().unwrap_or_default(),
			};
			t.by_id.insert(a.id, t.rows.len());
			t.rows.push(a);
		}
		Ok(t)
	}

	pub fn read(file: &Path) -> Result<AreaTable, String> {
		AreaTable::parse(&std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?)
	}

	fn parent_of(&self, id: u32) -> u32 {
		self.by_id.get(&id).map_or(0, |&i| self.rows[i].parent)
	}

	/// pack.js capitalAreas: an area flagged AREA_CAPITAL and every area under one (8 hops).
	pub fn capitals(&self) -> rustc_hash::FxHashSet<u32> {
		let capital: rustc_hash::FxHashSet<u32> = self.rows.iter().filter(|r| r.flags & AREA_CAPITAL != 0).map(|r| r.id).collect();
		let mut out = rustc_hash::FxHashSet::default();
		for r in &self.rows {
			let mut cur = r.id;
			for _ in 0..8 {
				if cur == 0 {
					break;
				}
				if capital.contains(&cur) {
					out.insert(r.id);
					break;
				}
				cur = self.parent_of(cur);
			}
		}
		out
	}

	/// pack.js zoneAreas: the uiMapID of the first area up an area's parents that is a zone of
	/// zones.json (type 3 with an areaId), else 0.
	pub fn zone_of<'a>(&'a self, zones: &Value) -> Box<dyn Fn(u32) -> u32 + Sync + 'a> {
		let mut by_area: FxHashMap<u32, u32> = FxHashMap::default();
		for z in zones.as_object().into_iter().flat_map(|o| o.values()) {
			if z["type"].as_f64() == Some(3.0) {
				if let Some(a) = z["areaId"].as_f64().filter(|a| *a != 0.0) {
					by_area.insert(a as u32, z["id"].as_f64().unwrap_or(0.0) as u32);
				}
			}
		}
		Box::new(move |id: u32| {
			let mut cur = id;
			for _ in 0..8 {
				if cur == 0 {
					break;
				}
				if let Some(&z) = by_area.get(&cur) {
					return z;
				}
				cur = self.parent_of(cur);
			}
			0
		})
	}

	/// chokepoints.js areaNames: the area's name (never empty), its zone, and the ids of the rows
	/// the two names come from.
	pub fn names(&self, id: u32) -> Option<AreaName> {
		let first = &self.rows[*self.by_id.get(&id)?];
		let pick = |a: &Area| if a.name.is_empty() { a.zone_name.clone() } else { a.name.clone() };
		let name = pick(first);
		let mut r = first;
		let mut seen = rustc_hash::FxHashSet::default();
		while r.parent > 0 && self.by_id.contains_key(&r.parent) && !seen.contains(&r.id) {
			seen.insert(r.id);
			r = &self.rows[self.by_id[&r.parent]];
		}
		let zone = pick(r);
		Some(AreaName {
			name: if name.is_empty() { zone.clone() } else { name.clone() },
			area: if name.is_empty() { r.id } else { first.id },
			zone: if zone.is_empty() { name.clone() } else { zone.clone() },
			zone_area: if zone.is_empty() { first.id } else { r.id },
		})
	}
}

/// A place's names (chokepoints.js areaNames).
#[derive(Clone, Debug, Default, PartialEq)]
pub struct AreaName {
	pub name: String,
	pub area: u32,
	pub zone: String,
	pub zone_area: u32,
}

/// One map frame: continent and rectangle (world yards).
#[derive(Clone, Copy, Debug)]
struct Frame {
	c: u32,
	left: f64,
	right: f64,
	top: f64,
	bottom: f64,
}

/// map-frames.json's Era frames (planner geo's frame set 'e', the live one where a map lacks an
/// Era frame) with zones.json.
pub struct Frames {
	era: Vec<(u32, Frame)>,
	live: Vec<(u32, Frame)>,
	zones: Value,
}

fn frames_of(v: &Value) -> Vec<(u32, Frame)> {
	let mut out: Vec<(u32, Frame)> = v
		.as_object()
		.into_iter()
		.flatten()
		.filter_map(|(id, b)| {
			let g = |k: &str| b[k].as_f64();
			Some((id.parse().ok()?, Frame { c: g("c")? as u32, left: g("left")?, right: g("right")?, top: g("top")?, bottom: g("bottom")? }))
		})
		.collect();
	out.sort_by_key(|x| x.0);
	out
}

impl Frames {
	pub fn new(map_frames: &Value, zones: Value) -> Frames {
		Frames { era: frames_of(&map_frames["era"]), live: frames_of(&map_frames["forever"]), zones }
	}

	fn get(set: &[(u32, Frame)], map: u32) -> Option<Frame> {
		set.binary_search_by_key(&map, |x| x.0).ok().map(|i| set[i].1)
	}

	/// Geo.toWorld(map, x, y, 'e'): map percent -> (c, wx, wy).
	pub fn to_world(&self, map: u32, x: f64, y: f64) -> Option<(u32, f64, f64)> {
		let b = Frames::get(&self.era, map).or_else(|| Frames::get(&self.live, map))?;
		Some((b.c, b.top + (b.bottom - b.top) * (y / 100.0), b.left + (b.right - b.left) * (x / 100.0)))
	}

	/// nav.js zoneLookup: the area id of the smallest zone or city map (Era frames) around a point
	/// whose zones.json entry has an areaId, else 0.
	pub fn zone_area_at(&self, c: u32, wx: f64, wy: f64) -> u32 {
		let mut out: Vec<(f64, u32)> = Vec::new();
		for &(id, b) in &self.era {
			let z = &self.zones[id.to_string()];
			if b.c != c || (!z.is_null() && z["type"].as_f64() != Some(3.0)) {
				continue;
			}
			let x = ((wy - b.left) / (b.right - b.left)) * 100.0;
			let y = ((wx - b.top) / (b.bottom - b.top)) * 100.0;
			if x < 0.0 || x > 100.0 || y < 0.0 || y > 100.0 {
				continue;
			}
			out.push((((b.right - b.left) * (b.bottom - b.top)).abs(), id));
		}
		out.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap().then(a.1.cmp(&b.1)));
		for (_, id) in out {
			let z = &self.zones[id.to_string()];
			if let Some(a) = z["areaId"].as_f64().filter(|a| *a != 0.0) {
				return a as u32;
			}
		}
		0
	}
}

/// The ground layers of `forge nav layers` for the pack: the roads layer's folder and the hubs.
pub struct GroundLayers {
	pub roads: PathBuf,
	pub hubs: FxHashMap<u32, Vec<Hub>>,
}

/// pack.js readLayers: refuses a folder without hubs.json or roads/index.json.
pub fn read_layers(dir: &Path) -> Result<GroundLayers, String> {
	let hubs_file = dir.join("hubs.json");
	if !hubs_file.is_file() {
		return Err(format!("pack: no hubs layer at {} (forge nav layers hubs)", hubs_file.display()));
	}
	let roads = dir.join("roads");
	if !roads.join("index.json").is_file() {
		return Err(format!("pack: no roads layer under {} (forge nav layers roads)", roads.display()));
	}
	let doc: Value = serde_json::from_slice(&std::fs::read(&hubs_file).map_err(|e| format!("{}: {e}", hubs_file.display()))?).map_err(|e| format!("{}: {e}", hubs_file.display()))?;
	let mut hubs = FxHashMap::default();
	for (key, list) in doc.as_object().into_iter().flatten() {
		if let (Ok(c), Some(list)) = (key.parse::<u32>(), list.as_array()) {
			if key.bytes().all(|b| b.is_ascii_digit()) {
				hubs.insert(c, list.iter().map(Hub::from_json).collect());
			}
		}
	}
	Ok(GroundLayers { roads, hubs })
}

/// A tile's roads layer weights (65536 bytes), None when the layer has no file for it.
pub fn road_weights(roads: &Path, c: u32, col: u32, row: u32) -> Result<Option<Vec<u8>>, String> {
	let file = roads.join(c.to_string()).join(format!("{col}_{row}.bin"));
	match std::fs::read(&file) {
		Ok(b) if b.len() == 65536 => Ok(Some(b)),
		Ok(b) => Err(format!("pack: {} holds {} bytes, not 65536", file.display(), b.len())),
		Err(_) => Ok(None),
	}
}
