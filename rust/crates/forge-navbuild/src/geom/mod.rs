//! Client geometry per ADT tile (port of tools/lib/nav/geom/index.js; the file parsers in
//! parse.rs): terrain triangles, area ids and liquids from the root ADT, WMO and M2 collision and
//! WMO liquids from the obj0 placements, all in world yards (wx north, wy west, z up). The client
//! tables (Map, LiquidType, LiquidMaterial, LiquidObject, TransportAnimation) are read as
//! wago.tools CSV text (`Tables::from_csv`).
//!
//! Liquid kinds come from LiquidType.SoundBank (0 water, 1 ocean, 2 magma, 3 slime); a water row
//! with Flags & 0x400 is ocean; a LiquidType whose LiquidMaterial has Flags & 0x2 (VisualOnly) is
//! no liquid.

pub mod parse;

use crate::fmath;
use parking_lot::Mutex;
use parse::{chunk, chunks, LiquidInfo, Model};
use rustc_hash::FxHashMap;
use std::path::PathBuf;
use std::sync::Arc;

/// Triangle kinds (index.js KIND).
pub mod kind {
	pub const TERRAIN: u8 = 0;
	pub const WMO_OUTDOOR: u8 = 1;
	pub const WMO_INDOOR: u8 = 2;
	pub const M2: u8 = 3;
	pub const M2_WALKWAY: u8 = 4;
	/// A reviewed walkway WMO group's triangle (walkways.json `groups`; not in the JS build).
	pub const WMO_OUTDOOR_WALKWAY: u8 = 5;
	pub const WMO_INDOOR_WALKWAY: u8 = 6;

	/// Steeper than WALK_MAX is a wall (rasterise.rs).
	pub fn is_walkway(k: u8) -> bool {
		matches!(k, M2_WALKWAY | WMO_OUTDOOR_WALKWAY | WMO_INDOOR_WALKWAY)
	}
}

/// Liquid types (index.js LIQUID).
pub mod liquid {
	pub const NONE: u8 = 0;
	pub const WATER: u8 = 1;
	pub const OCEAN: u8 = 2;
	pub const MAGMA: u8 = 3;
	pub const SLIME: u8 = 4;
}

/// Client files by fileDataID. `Ok(None)`: the client has no such file (the JS's HTTP 404).
pub trait Source: Send + Sync {
	fn get(&self, fdid: u32) -> Result<Option<Arc<Vec<u8>>>, String>;
}

/// The tile's MH2O liquid (mh2o.js parseMh2o): 128 x 128 quads, row-major from the NW corner.
#[derive(Clone, Debug, Default)]
pub struct Mh2o {
	pub ty: Vec<u8>,
	pub z: Vec<f32>,
	pub deep: Vec<u8>,
}

/// WMO liquid triangles of one type (9 floats per triangle).
#[derive(Clone, Debug, Default)]
pub struct WmoLiquid {
	pub ty: u8,
	pub tris: Vec<f32>,
}

/// tileGeometry's `stats`.
#[derive(Clone, Debug, Default)]
pub struct GeomStats {
	pub terrain_tris: usize,
	pub wmo: usize,
	pub wmo_tris: usize,
	pub wmo_liquid_tris: usize,
	pub m2: usize,
	pub m2_tris: usize,
	pub holes: usize,
	pub missing: Vec<u32>,
}

/// The collision triangle range a placement added.
#[derive(Clone, Debug, Default)]
pub struct Placement {
	/// "wmo" or "m2".
	pub ty: &'static str,
	pub fdid: u32,
	pub unique_id: u32,
	pub first: usize,
	pub count: usize,
}

/// A reviewed opening's cut (index.js openingCut, placed): 4 corners (wx, wy), z range.
#[derive(Clone, Debug, Default)]
pub struct Cut {
	pub id: String,
	pub pts: [[f64; 2]; 4],
	pub zlo: f64,
	pub zhi: f64,
}

/// One ADT tile's geometry (index.js tileGeometry's return value, field for field).
#[derive(Clone, Debug, Default)]
pub struct Geometry {
	pub c: u32,
	pub col: i32,
	pub row: i32,
	/// 9 floats (x, y, z of 3 corners) per triangle, world yards.
	pub tris: Vec<f32>,
	pub kind: Vec<u8>,
	/// Chunk area ids, index indexY * 16 + indexX.
	pub areas: Vec<u16>,
	pub liquid: Mh2o,
	pub wmo_liquid: Vec<WmoLiquid>,
	pub stats: GeomStats,
	pub placements: Vec<Placement>,
	pub openings: Vec<Cut>,
	/// Per triangle its WMO group's WMOAreaTable row ID (Tables::wmo_area; 0 for terrain, M2s and
	/// groups without one). Rust only (the JS has no such field).
	pub tri_area: Vec<u32>,
}

/// A tile of a continent's WDT (MAID).
#[derive(Clone, Debug)]
pub struct TileRef {
	pub col: i32,
	pub row: i32,
	pub root: u32,
	pub obj0: u32,
	pub tex0: u32,
}

/// A transport's travel: vertical and horizontal span in yards.
#[derive(Clone, Copy, Debug)]
pub struct Travel {
	pub rise: f64,
	pub sway: f64,
}

/// JS `Number(v) || 0`.
fn num(v: &str) -> f64 {
	let t = v.trim();
	let x = match t {
		"" => 0.0,
		"Infinity" | "+Infinity" => f64::INFINITY,
		"-Infinity" => f64::NEG_INFINITY,
		_ if t.bytes().any(|b| b.is_ascii_alphabetic() && b != b'e' && b != b'E') => f64::NAN,
		_ => t.parse().unwrap_or(f64::NAN),
	};
	if x.is_nan() {
		0.0
	} else {
		x
	}
}

/// RFC 4180 rows (tools/lib/data/csv.js parseRows) as header-keyed maps.
fn parse_csv(text: &str) -> Result<Vec<FxHashMap<String, String>>, String> {
	let mut rows: Vec<Vec<String>> = Vec::new();
	let mut row: Vec<String> = Vec::new();
	let mut field = String::new();
	let mut quoted = false;
	let chars: Vec<char> = text.strip_prefix('\u{feff}').unwrap_or(text).chars().collect();
	let mut i = 0;
	while i < chars.len() {
		let c = chars[i];
		if quoted {
			if c == '"' {
				if chars.get(i + 1) == Some(&'"') {
					field.push('"');
					i += 2;
					continue;
				}
				quoted = false;
				i += 1;
				continue;
			}
			field.push(c);
			i += 1;
			continue;
		}
		if c == '"' && field.is_empty() {
			quoted = true;
			i += 1;
		} else if c == ',' {
			row.push(std::mem::take(&mut field));
			i += 1;
		} else if c == '\n' || c == '\r' {
			row.push(std::mem::take(&mut field));
			rows.push(std::mem::take(&mut row));
			i += if c == '\r' && chars.get(i + 1) == Some(&'\n') { 2 } else { 1 };
		} else {
			field.push(c);
			i += 1;
		}
	}
	if quoted {
		return Err("CSV: unterminated quoted field".into());
	}
	if !field.is_empty() || !row.is_empty() {
		row.push(field);
		rows.push(row);
	}
	let Some(header) = rows.first().cloned() else { return Ok(Vec::new()) };
	let mut out = Vec::new();
	for (r, row) in rows.iter().enumerate().skip(1) {
		if row.len() == 1 && row[0].is_empty() {
			continue;
		}
		if row.len() != header.len() {
			return Err(format!("CSV: row {} has {} fields, header has {}", r + 1, row.len(), header.len()));
		}
		out.push(header.iter().cloned().zip(row.iter().cloned()).collect());
	}
	Ok(out)
}

/// The client tables the geometry reads.
pub struct Tables {
	/// Map rows: (ID, WdtFileDataID, MapName_lang), in file order.
	maps: Vec<(f64, f64, String)>,
	/// LiquidType by ID: (SoundBank text, MaterialID, Flags).
	types: FxHashMap<u64, (String, f64, f64)>,
	/// LiquidMaterial by ID: (Flags, LVF).
	materials: FxHashMap<u64, (f64, f64)>,
	/// LiquidObject ID -> LiquidTypeID.
	objects: FxHashMap<u64, f64>,
	/// TransportAnimation rows: (TransportID, Pos_0, Pos_1, Pos_2).
	transport: Vec<(f64, f64, f64, f64)>,
	/// WMOAreaTable: (WMOID, NameSetID, WMOGroupID) -> the row's ID (a group of -1 is the root's own
	/// row). Empty when the client gives no such table.
	wmo_areas: FxHashMap<(u32, u32, i32), u32>,
	/// WMOAreaTable row ID -> (the client's subzone name there: the row's AreaName, else its
	/// AreaTableID's AreaTable name; that AreaTableID).
	wmo_names: FxHashMap<u32, (String, u32)>,
}

/// A map key from a table number (integral ids; others never match).
fn key(v: f64) -> u64 {
	if v >= 0.0 && v.fract() == 0.0 {
		v as u64
	} else {
		u64::MAX
	}
}

impl Tables {
	/// `text(name)`: the wago.tools CSV of table `name`.
	pub fn from_csv(text: impl Fn(&str) -> Result<String, String>) -> Result<Tables, String> {
		let rows = |name: &str| -> Result<Vec<FxHashMap<String, String>>, String> { parse_csv(&text(name)?).map_err(|e| format!("{name}.csv: {e}")) };
		let g = |r: &FxHashMap<String, String>, k: &str| r.get(k).map_or(0.0, |v| num(v));
		let maps = rows("Map")?.iter().map(|r| (g(r, "ID"), g(r, "WdtFileDataID"), r.get("MapName_lang").cloned().unwrap_or_default())).collect();
		let mut types = FxHashMap::default();
		for r in rows("LiquidType")? {
			types.insert(key(g(&r, "ID")), (r.get("SoundBank").cloned().unwrap_or_default(), g(&r, "MaterialID"), g(&r, "Flags")));
		}
		let mut materials = FxHashMap::default();
		for r in rows("LiquidMaterial")? {
			materials.insert(key(g(&r, "ID")), (g(&r, "Flags"), g(&r, "LVF")));
		}
		let mut objects = FxHashMap::default();
		for r in rows("LiquidObject")? {
			objects.insert(key(g(&r, "ID")), g(&r, "LiquidTypeID"));
		}
		let transport = rows("TransportAnimation")?.iter().map(|r| (g(r, "TransportID"), g(r, "Pos_0"), g(r, "Pos_1"), g(r, "Pos_2"))).collect();
		let mut wmo_areas = FxHashMap::default();
		let mut wmo_names = FxHashMap::default();
		// Optional: the synthetic goldens' tables and old CSV caches have none (every surface's area is 0 then).
		if let Ok(rows) = rows("WMOAreaTable") {
			let area_names: FxHashMap<u32, String> = match parse_csv(&text("AreaTable").unwrap_or_default()) {
				Ok(at) => at.iter().map(|r| (g(r, "ID") as u32, r.get("AreaName_lang").cloned().unwrap_or_default())).collect(),
				Err(_) => FxHashMap::default(),
			};
			for r in rows {
				let id = g(&r, "ID");
				if id > 0.0 {
					wmo_areas.insert((g(&r, "WMOID") as u32, g(&r, "NameSetID") as u32, g(&r, "WMOGroupID") as i32), id as u32);
					let parent = g(&r, "AreaTableID") as u32;
					let own = r.get("AreaName_lang").cloned().unwrap_or_default();
					let name = if own.is_empty() { area_names.get(&parent).cloned().unwrap_or_default() } else { own };
					wmo_names.insert(id as u32, (name, parent));
				}
			}
		}
		Ok(Tables { maps, types, materials, objects, transport, wmo_areas, wmo_names })
	}

	/// The WMOAreaTable rows by ID: (subzone name, AreaTableID), sorted by ID (the grid's areas.json).
	pub fn wmo_area_names(&self) -> Vec<(u32, &str, u32)> {
		let mut v: Vec<(u32, &str, u32)> = self.wmo_names.iter().map(|(&id, (n, p))| (id, n.as_str(), *p)).collect();
		v.sort_unstable_by_key(|x| x.0);
		v
	}

	/// A WMO group's WMOAreaTable row ID (the client's subzone there: the row's AreaName, else its
	/// AreaTableID's name): its own row in the placement's name set, else the root's (group -1), else
	/// name set 0's; 0 when none.
	pub fn wmo_area(&self, wmo_id: u32, name_set: u32, group: i32) -> u32 {
		for key in [(wmo_id, name_set, group), (wmo_id, name_set, -1), (wmo_id, 0, group), (wmo_id, 0, -1)] {
			if let Some(&a) = self.wmo_areas.get(&key) {
				return a;
			}
		}
		0
	}
}

impl LiquidInfo for Tables {
	fn kind(&self, id: u32) -> Result<u8, String> {
		let r = self.types.get(&u64::from(id)).ok_or_else(|| format!("LiquidType {id}: not in LiquidType.csv"))?;
		let sb = num(&r.0);
		let k = match sb {
			0.0 => liquid::WATER,
			1.0 => liquid::OCEAN,
			2.0 => liquid::MAGMA,
			3.0 => liquid::SLIME,
			_ => return Err(format!("LiquidType {id}: SoundBank {} is none of water/ocean/magma/slime", r.0)),
		};
		if let Some(m) = self.materials.get(&key(r.1)) {
			if (m.0 as i64) & 0x2 != 0 {
				return Ok(liquid::NONE);
			}
		}
		Ok(if k == liquid::WATER && (r.2 as i64) & 0x400 != 0 { liquid::OCEAN } else { k })
	}

	fn lvf(&self, liquid_type: u32, object_or_lvf: u32) -> Result<u32, String> {
		if object_or_lvf < 42 {
			return Ok(object_or_lvf);
		}
		let t = self.objects.get(&u64::from(object_or_lvf)).copied().filter(|&t| t != 0.0).unwrap_or(f64::from(liquid_type));
		let v = self.types.get(&key(t)).and_then(|r| self.materials.get(&key(r.1)));
		let v = v.ok_or_else(|| format!("LiquidObject {object_or_lvf} (LiquidType {liquid_type}): no LiquidMaterial vertex format"))?;
		Ok(v.1 as u32)
	}
}

/// The travel of every transport the client animates, in TransportAnimation order.
pub fn transport_travel(t: &Tables) -> Vec<(u32, Travel)> {
	let mut out: Vec<(f64, [f64; 6])> = Vec::new();
	let mut at: FxHashMap<u64, usize> = FxHashMap::default();
	for &(id, x, y, z) in &t.transport {
		let i = *at.entry(id.to_bits()).or_insert_with(|| {
			out.push((id, [x, x, y, y, z, z]));
			out.len() - 1
		});
		let b = &mut out[i].1;
		b[0] = fmath::min(b[0], x);
		b[1] = fmath::max(b[1], x);
		b[2] = fmath::min(b[2], y);
		b[3] = fmath::max(b[3], y);
		b[4] = fmath::min(b[4], z);
		b[5] = fmath::max(b[5], z);
	}
	out.into_iter().map(|(id, b)| (id as u32, Travel { rise: b[5] - b[4], sway: fmath::hypot(b[1] - b[0], b[3] - b[2]) })).collect()
}

fn get_or_404(src: &dyn Source, fdid: u32) -> Result<Arc<Vec<u8>>, String> {
	src.get(fdid)?.ok_or_else(|| format!("fileDataID {fdid}: HTTP 404"))
}

/// Continent c's WDT top-level chunks' MAID and MPHD (from Map.csv WdtFileDataID).
fn continent_wdt(src: &dyn Source, t: &Tables, c: u32) -> Result<(u32, Arc<Vec<u8>>), String> {
	let row = t.maps.iter().find(|r| r.0 == f64::from(c)).ok_or_else(|| format!("Map {c}: not in Map.csv"))?;
	let wdt = row.1 as u32;
	if wdt == 0 {
		return Err(format!("Map {c} ({}): no WdtFileDataID", row.2));
	}
	Ok((wdt, get_or_404(src, wdt)?))
}

/// Every tile of continent c (WDT MAID: 8 u32 per tile, index row * 64 + col).
pub fn continent_tiles(src: &dyn Source, t: &Tables, c: u32) -> Result<Vec<TileRef>, String> {
	let (fdid, buf) = continent_wdt(src, t, c)?;
	let top = chunks(&buf, 0)?;
	let maid = chunk(&top, b"MAID").filter(|m| m.len() >= 64 * 64 * 32).ok_or_else(|| format!("Map {c}: WDT {fdid} has no full MAID"))?;
	let u = |o: usize| u32::from_le_bytes(maid[o..o + 4].try_into().unwrap());
	let mut out = Vec::new();
	for i in 0..64 * 64 {
		let root = u(i * 32);
		if root != 0 {
			out.push(TileRef { col: (i % 64) as i32, row: (i / 64) as i32, root, obj0: u(i * 32 + 4), tex0: u(i * 32 + 12) });
		}
	}
	Ok(out)
}

/// The MPHD flags of continent c's WDT.
pub fn continent_flags(src: &dyn Source, t: &Tables, c: u32) -> Result<u32, String> {
	let (fdid, buf) = continent_wdt(src, t, c)?;
	let top = chunks(&buf, 0)?;
	let m = chunk(&top, b"MPHD").filter(|m| m.len() >= 4).ok_or_else(|| format!("Map {c}: WDT {fdid} has no MPHD"))?;
	Ok(u32::from_le_bytes(m[..4].try_into().unwrap()))
}

/// Parsed WMO/M2 models by fileDataID, shared by the build's threads (None: the client has no
/// such file).
#[derive(Default)]
pub struct ModelCache {
	wmo: Mutex<FxHashMap<u32, Option<Arc<Model>>>>,
	m2: Mutex<FxHashMap<u32, Option<Arc<Model>>>>,
}

impl ModelCache {
	fn get(map: &Mutex<FxHashMap<u32, Option<Arc<Model>>>>, fdid: u32, load: impl FnOnce() -> Result<Option<Model>, String>) -> Result<Option<Arc<Model>>, String> {
		if let Some(m) = map.lock().get(&fdid) {
			return Ok(m.clone());
		}
		let m = load()?.map(Arc::new);
		map.lock().insert(fdid, m.clone());
		Ok(m)
	}
}

/// The reviewed openings (openings.json): (id, wmo, portal, depth).
fn openings() -> &'static [(String, u32, usize, f64)] {
	static O: std::sync::OnceLock<Vec<(String, u32, usize, f64)>> = std::sync::OnceLock::new();
	O.get_or_init(|| {
		let v: serde_json::Value = serde_json::from_str(include_str!("openings.json")).expect("openings.json");
		v["openings"]
			.as_array()
			.expect("openings")
			.iter()
			.map(|o| (o["id"].as_str().expect("id").to_string(), o["wmo"].as_u64().expect("wmo") as u32, o["portal"].as_u64().expect("portal") as usize, o["depth"].as_f64().expect("depth")))
			.collect()
	})
}

/// The reviewed walkways (walkways.json): their M2 fileDataIDs.
fn walkways() -> &'static [u32] {
	static W: std::sync::OnceLock<Vec<u32>> = std::sync::OnceLock::new();
	W.get_or_init(|| {
		let v: serde_json::Value = serde_json::from_str(include_str!("walkways.json")).expect("walkways.json");
		v["walkways"].as_array().expect("walkways").iter().map(|w| w["m2"].as_u64().expect("m2") as u32).collect()
	})
}

/// The reviewed walkway WMO groups (walkways.json `groups`): (WMO fileDataID, MOGN group name).
static WALKWAY_GROUPS: std::sync::LazyLock<Vec<(u32, String)>> = std::sync::LazyLock::new(|| reviewed_groups("groups"));
/// The reviewed landing WMO groups (walkways.json `landings`): their rendered faces are kept.
static LANDING_GROUPS: std::sync::LazyLock<Vec<(u32, String)>> = std::sync::LazyLock::new(|| reviewed_groups("landings"));

fn reviewed_groups(key: &str) -> Vec<(u32, String)> {
	let v: serde_json::Value = serde_json::from_str(include_str!("walkways.json")).expect("walkways.json");
	v[key].as_array().into_iter().flatten().map(|g| (g["wmo"].as_u64().expect("wmo") as u32, g["group"].as_str().expect("group").to_string())).collect()
}

pub fn walkway_groups() -> &'static [(u32, String)] {
	&WALKWAY_GROUPS
}

pub fn landing_groups() -> &'static [(u32, String)] {
	&LANDING_GROUPS
}

fn overlaps(aabb: &[f64; 6], b: &[f64; 4]) -> bool {
	aabb[0] <= b[2] && aabb[3] >= b[0] && aabb[1] <= b[3] && aabb[4] >= b[1]
}

/// Adds the triangles idx (into world points w) whose xy box meets box -> count added.
fn soup_add(tris: &mut Vec<f32>, kinds_out: &mut Vec<u8>, w: &[f32], idx: &[u32], kinds: Result<&[u8], u8>, b: &[f64; 4], mut kept: Option<&mut Vec<usize>>) -> usize {
	let start = kinds_out.len();
	for (t, tri) in idx.chunks_exact(3).enumerate() {
		let (a, bb, c) = (tri[0] as usize * 3, tri[1] as usize * 3, tri[2] as usize * 3);
		let (ax, bx, cx) = (f64::from(w[a]), f64::from(w[bb]), f64::from(w[c]));
		if (ax > b[2] && bx > b[2] && cx > b[2]) || (ax < b[0] && bx < b[0] && cx < b[0]) {
			continue;
		}
		let (ay, by, cy) = (f64::from(w[a + 1]), f64::from(w[bb + 1]), f64::from(w[c + 1]));
		if (ay > b[3] && by > b[3] && cy > b[3]) || (ay < b[1] && by < b[1] && cy < b[1]) {
			continue;
		}
		tris.extend([w[a], w[a + 1], w[a + 2], w[bb], w[bb + 1], w[bb + 2], w[c], w[c + 1], w[c + 2]]);
		kinds_out.push(match kinds {
			Ok(k) => k[t],
			Err(k) => k,
		});
		if let Some(kept) = kept.as_deref_mut() {
			kept.push(t);
		}
	}
	kinds_out.len() - start
}

/// A placed portal -> its cut: span along its wall, `depth` yards to each side, z range; None
/// when the portal is not upright (index.js openingCut).
pub fn opening_cut(v: &[f32], depth: f64) -> Option<([[f64; 2]; 4], f64, f64)> {
	let n = v.len() / 3;
	if n < 3 {
		return None;
	}
	let p = |i: usize, c: usize| f64::from(v[i * 3 + c]);
	let (mut nx, mut ny, mut nz) = (0.0, 0.0, 0.0);
	for i in 0..n {
		let j = (i + 1) % n;
		nx += (p(i, 1) - p(j, 1)) * (p(i, 2) + p(j, 2));
		ny += (p(i, 2) - p(j, 2)) * (p(i, 0) + p(j, 0));
		nz += (p(i, 0) - p(j, 0)) * (p(i, 1) + p(j, 1));
	}
	let h = fmath::hypot(nx, ny);
	if !(h > 1e-6) || nz.abs() / fmath::hypot(h, nz) > 0.2 {
		return None;
	}
	nx /= h;
	ny /= h;
	let (ax, ay) = (-ny, nx);
	let (mut lo, mut hi, mut zlo, mut zhi, mut along) = (f64::INFINITY, f64::NEG_INFINITY, f64::INFINITY, f64::NEG_INFINITY, 0.0);
	for i in 0..n {
		let t = p(i, 0) * ax + p(i, 1) * ay;
		if t < lo {
			lo = t;
		}
		if t > hi {
			hi = t;
		}
		along += p(i, 0) * nx + p(i, 1) * ny;
		zlo = fmath::min(zlo, p(i, 2));
		zhi = fmath::max(zhi, p(i, 2));
	}
	along /= n as f64;
	let at = |t: f64, s: f64| [ax * t + nx * (along + s), ay * t + ny * (along + s)];
	Some(([at(lo, -depth), at(hi, -depth), at(hi, depth), at(lo, depth)], zlo, zhi))
}

/// One tile's geometry (index.js tileGeometry, margin 0, the reviewed openings and walkways).
pub fn tile_geometry(src: &dyn Source, t: &Tables, c: u32, tile: &TileRef, cache: &ModelCache) -> Result<Geometry, String> {
	let root_buf = get_or_404(src, tile.root)?;
	let obj_buf = if tile.obj0 != 0 { Some(get_or_404(src, tile.obj0)?) } else { None };
	let (mcnk, mh2o) = parse::parse_root(&root_buf)?;
	let (ttris, holes) = parse::terrain_triangles(&mcnk);
	let mut areas = vec![0u16; 256];
	for m in &mcnk {
		let i = m.index_y as usize * 16 + m.index_x as usize;
		if i < 256 {
			areas[i] = m.area_id as u16;
		}
	}
	let water = parse::parse_mh2o(mh2o, t)?;
	let (col, row) = (f64::from(tile.col), f64::from(tile.row));
	let bx = [(31.0 - row) * parse::ADT, (31.0 - col) * parse::ADT, (32.0 - row) * parse::ADT, (32.0 - col) * parse::ADT];
	let mut tris = ttris;
	let mut kind = vec![kind::TERRAIN; tris.len() / 9];
	let mut stats = GeomStats { terrain_tris: kind.len(), holes, ..GeomStats::default() };
	let (mut wet_tris, mut wet_kind) = (Vec::new(), Vec::new());
	let mut missing: Vec<u32> = Vec::new();
	let mut placements = Vec::new();
	let mut cuts = Vec::new();
	let mut tri_area: Vec<u32> = Vec::new();
	let get = |fdid: u32| src.get(fdid);
	let (m2, wmo) = match &obj_buf {
		Some(b) => parse::parse_placements(&chunks(b, 0)?)?,
		None => (Vec::new(), Vec::new()),
	};
	let kind_of = |ty: u32| t.kind(ty);
	let mut wmo_models = Vec::with_capacity(wmo.len());
	for p in &wmo {
		let groups: Vec<&str> = walkway_groups().iter().filter(|g| g.0 == p.fdid).map(|g| g.1.as_str()).collect();
		let landings: Vec<&str> = landing_groups().iter().filter(|g| g.0 == p.fdid).map(|g| g.1.as_str()).collect();
		wmo_models.push(ModelCache::get(&cache.wmo, p.fdid, || parse::load_wmo(&get, p.fdid, &kind_of, &groups, &landings))?);
	}
	let mut m2_models = Vec::with_capacity(m2.len());
	for p in &m2 {
		m2_models.push(ModelCache::get(&cache.m2, p.fdid, || match src.get(p.fdid)? {
			Some(b) => parse::parse_m2(&b).map(Some),
			None => Ok(None),
		})?);
	}
	let walk = walkways();
	for (p, mdl) in wmo.iter().zip(&wmo_models) {
		stats.wmo += 1;
		let Some(mdl) = mdl else {
			if !missing.contains(&p.fdid) {
				missing.push(p.fdid);
			}
			continue;
		};
		for &g in &mdl.missing {
			if !missing.contains(&g) {
				missing.push(g);
			}
		}
		let m = parse::placement_matrix(p);
		let first = kind.len();
		let mut kept = Vec::new();
		let count = if overlaps(&p.extents, &bx) { soup_add(&mut tris, &mut kind, &parse::transform_points(&m, &mdl.verts), &mdl.idx, Ok(&mdl.kind), &bx, Some(&mut kept)) } else { 0 };
		tri_area.resize(first, 0);
		tri_area.extend(kept.iter().map(|&tt| mdl.group.get(tt).map_or(0, |&g| t.wmo_area(mdl.wmo_id, p.name_set, g))));
		placements.push(Placement { ty: "wmo", fdid: p.fdid, unique_id: p.unique_id, first, count });
		stats.wmo_tris += count;
		for (id, owmo, portal, depth) in openings() {
			if *owmo != p.fdid {
				continue;
			}
			let v = mdl.portals.get(*portal).ok_or_else(|| format!("openings.json {id}: WMO {} has no portal {portal}", p.fdid))?;
			let (pts, zlo, zhi) = opening_cut(&parse::transform_points(&m, v), *depth).ok_or_else(|| format!("openings.json {id}: portal {portal} of WMO {} is not upright", p.fdid))?;
			let xs = pts.map(|q| q[0]);
			let ys = pts.map(|q| q[1]);
			let mn = |a: [f64; 4]| a.into_iter().fold(f64::INFINITY, fmath::min);
			let mx = |a: [f64; 4]| a.into_iter().fold(f64::NEG_INFINITY, fmath::max);
			if overlaps(&[mn(xs), mn(ys), 0.0, mx(xs), mx(ys), 0.0], &bx) {
				cuts.push(Cut { id: id.clone(), pts, zlo, zhi });
			}
		}
		if !mdl.liquid_idx.is_empty() && overlaps(&p.extents, &bx) {
			stats.wmo_liquid_tris += soup_add(&mut wet_tris, &mut wet_kind, &parse::transform_points(&m, &mdl.liquid_verts), &mdl.liquid_idx, Ok(&mdl.liquid_kind), &bx, None);
		}
	}
	for (p, mdl) in m2.iter().zip(&m2_models) {
		stats.m2 += 1;
		let Some(mdl) = mdl else {
			if !missing.contains(&p.fdid) {
				missing.push(p.fdid);
			}
			continue;
		};
		if mdl.idx.is_empty() {
			continue;
		}
		let m = parse::placement_matrix(p);
		let aabb = parse::transform_box(&m, &mdl.box_);
		let k = if walk.contains(&p.fdid) { kind::M2_WALKWAY } else { kind::M2 };
		let first = kind.len();
		let count = if overlaps(&aabb, &bx) { soup_add(&mut tris, &mut kind, &parse::transform_points(&m, &mdl.verts), &mdl.idx, Err(k), &bx, None) } else { 0 };
		placements.push(Placement { ty: "m2", fdid: p.fdid, unique_id: p.unique_id, first, count });
		stats.m2_tris += count;
	}
	missing.sort_unstable();
	stats.missing = missing;
	let mut wmo_liquid = Vec::new();
	for ty in liquid::WATER..=liquid::SLIME {
		let mut lt = Vec::new();
		for (i, &k) in wet_kind.iter().enumerate() {
			if k == ty {
				lt.extend_from_slice(&wet_tris[i * 9..i * 9 + 9]);
			}
		}
		if !lt.is_empty() {
			wmo_liquid.push(WmoLiquid { ty, tris: lt });
		}
	}
	tri_area.resize(kind.len(), 0);
	Ok(Geometry { c, col: tile.col, row: tile.row, tris, kind, areas, liquid: water, wmo_liquid, stats, placements, openings: cuts, tri_area })
}

/// Client files from a JS CASC cache folder (`<fdid>.blp`; an absent file is a 404).
pub struct CacheDir(pub PathBuf);

impl Source for CacheDir {
	fn get(&self, fdid: u32) -> Result<Option<Arc<Vec<u8>>>, String> {
		match std::fs::read(self.0.join(format!("{fdid}.blp"))) {
			Ok(b) => Ok(Some(Arc::new(b))),
			Err(e) if e.kind() == std::io::ErrorKind::NotFound => Ok(None),
			Err(e) => Err(format!("{fdid}.blp: {e}")),
		}
	}
}

/// Client files from the installed client (local CASC; a file the root does not list, or one
/// with encrypted parts, is a 404).
pub struct ClientSource(forge_gamedata::Storage);

impl ClientSource {
	pub fn open(install: &std::path::Path, product: &str) -> Result<ClientSource, String> {
		Ok(ClientSource(forge_gamedata::Storage::open(install, product)?))
	}
}

impl Source for ClientSource {
	fn get(&self, fdid: u32) -> Result<Option<Arc<Vec<u8>>>, String> {
		const EN_US: u32 = 0x2;
		if !self.0.has_fdid(fdid) {
			return Ok(None);
		}
		// A file the local storage cannot give (not downloaded, an entry for another key) is
		// missing, as the JS's 404 (its models are listed in the build's warnings).
		Ok(match self.0.read_fdid(fdid, EN_US) {
			Ok(d) if d.encrypted.is_empty() => Some(Arc::new(d.data)),
			_ => None,
		})
	}
}
