//! Our navigation grid as Polestar's walking maps (format 2; format 3 with the grid's area sidecars), the maps of Polestar's walking router
//! (addon/Polestar_Nav Routing/), and the chokepoints: a port of tools/lib/nav/pack.js and
//! chokepoints.js with byte-identical output (docs/forge/nav.md, "forge nav pack").
//!
//! Ported from Shortest Path Forever v1.15.0 by Cillian Berragan (github.com/cjber/shortest-path-forever,
//! GPL-3.0-or-later, used with his permission): the HPA* graph, the cluster encodings and the floor links of
//! tools/baker/gen_nav.py, and the zlib + base64 parts of tools/pack_nav.py.
//! Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
//!
//! Stages: `cells::cell_grid` (the grid -> per cell its surfaces, ground classes and joins),
//! `hpa::build_hpa` (the graph, each edge priced per profile), `encode::encode_maps` (the per-cluster
//! strings), `encode::pack_files` (strings -> NavN.lua + NavN_i.lua parts). The rules (ground
//! classes, entrances, faces, cells) are written down in pack.js's header comment and
//! docs/ARCHITECTURE.md, "Packing for the in-game engine".

pub mod cells;
pub mod chokepoints;
pub mod encode;
pub mod fixture;
pub mod hpa;
pub mod layers;
pub mod leffe;

use crate::grid::{flag, Grid, Tile};
use crate::legs::Nav;
use serde_json::{json, Map, Value};
use sha2::{Digest, Sha256};
use std::path::{Path, PathBuf};
use std::sync::{Arc, LazyLock};

pub use forge_core::jsnum::js_round;
use forge_core::jsnum::js_to_string;

/// The ground class bases (Routing/Costs.lua, costs.js CLASS).
#[allow(non_snake_case)]
pub mod CLASS {
	pub const NORMAL: u8 = 0;
	pub const ROAD: u8 = 1;
	pub const GENTLE: u8 = 2;
	pub const STEEP: u8 = 3;
	pub const INDOOR: u8 = 4;
	pub const CITY: u8 = 5;
}
/// Inside an Alliance hub (hostile to Horde players) and a Horde one.
pub const HUB_ALLIANCE: u8 = 8;
pub const HUB_HORDE: u8 = 16;
/// By base class: normal, road, gentle slope, steep slope, indoor, indoor city; 6 and 7 as normal.
pub const MULT: [f64; 6] = [1.0, 0.8, 1.3, 2.5, 2.0, 1.0];
/// A hostile hub, on top of its base class.
pub const HUB: f64 = 20.0;
/// tslope bands (degrees): gentle from GENTLE, steep from STEEP.
pub const SLOPE_GENTLE: u8 = 30;
pub const SLOPE_STEEP: u8 = 40;
/// The profiles a graph edge is priced for, in record order: Alliance, Horde, none.
pub const PROFILES: [Option<&str>; 3] = [Some("Alliance"), Some("Horde"), None];
pub const NONE: usize = 2;
/// gen_nav.py: a swum yard counts as three running ones.
pub const SWIM: f64 = 3.0;
/// The maps `forge nav pack` writes: Eastern Kingdoms, Kalimdor, Zephras Isle.
pub const MAPS: [u32; 3] = [0, 1, 2991];
/// The load-on-demand addon a continent's map parts ship in when its maps are Leffe's (maps format 5: too big
/// to load both continents at login). Its metadata file stays in Polestar_Nav and names the part; the router
/// loads the part the first time it searches that map (Routing/PathGrid.lua, out of combat).
pub const PARTS: [(u32, &str); 2] = [(0, "Polestar_Nav_EK"), (1, "Polestar_Nav_Kalimdor")];

/// The part addon of map `map`'s parts, if it has one.
pub fn part_of(map: u32) -> Option<&'static str> {
	PARTS.iter().find(|p| p.0 == map).map(|p| p.1)
}
pub const PACK_JSON: &str = "PACK.json";
pub const B64: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

/// costs.js mult: the multiplier of a step into a node of class byte `cls` under a profile.
pub fn mult(cls: u8, profile: Option<&str>) -> f64 {
	let m = MULT.get((cls & 7) as usize).copied().unwrap_or(1.0);
	let hostile = (profile == Some("Horde") && cls & HUB_ALLIANCE != 0) || (profile == Some("Alliance") && cls & HUB_HORDE != 0);
	if hostile {
		m * HUB
	} else {
		m
	}
}

/// Per profile, the multiplier of every class byte (5 bits).
pub static MULTS: LazyLock<[[f64; 32]; 3]> = LazyLock::new(|| {
	let mut out = [[0.0; 32]; 3];
	for (p, row) in out.iter_mut().enumerate() {
		for (c, v) in row.iter_mut().enumerate() {
			*v = mult(c as u8, PROFILES[p]);
		}
	}
	out
});

/// A node's ground class byte (pack.js nodeClass): steep slope > indoor (indoor city in a capital) >
/// road (never on water) > gentle slope > normal, plus its hub bits.
pub fn node_class(surface_flags: u8, tslope: u8, road: bool, area_city: bool, hub_bits: u8) -> u8 {
	let base = if tslope >= SLOPE_STEEP {
		CLASS::STEEP
	} else if surface_flags & flag::INDOOR != 0 {
		if area_city {
			CLASS::CITY
		} else {
			CLASS::INDOOR
		}
	} else if road && surface_flags & flag::SWIM == 0 {
		CLASS::ROAD
	} else if tslope >= SLOPE_GENTLE {
		CLASS::GENTLE
	} else {
		CLASS::NORMAL
	};
	base | (hub_bits & (HUB_ALLIANCE | HUB_HORDE))
}

/// A hub of hubs.json: { id, side, name, areaId, disks: [[x, y, r]] }.
#[derive(Clone, Debug)]
pub struct Hub {
	pub id: Value,
	pub side: String,
	pub name: Value,
	/// Number(areaId) || 0.
	pub area_id: f64,
	pub disks: Vec<[f64; 3]>,
}

impl Hub {
	pub fn from_json(v: &Value) -> Hub {
		let area = match &v["areaId"] {
			Value::Number(n) => n.as_f64().unwrap_or(0.0),
			Value::String(s) => s.trim().parse().unwrap_or(0.0),
			_ => 0.0,
		};
		Hub {
			id: v["id"].clone(),
			side: v["side"].as_str().unwrap_or("").to_string(),
			name: v["name"].clone(),
			area_id: if area.is_nan() { 0.0 } else { area },
			disks: v["disks"].as_array().into_iter().flatten().map(|d| [0, 1, 2].map(|i| d[i].as_f64().unwrap_or(f64::NAN))).collect(),
		}
	}
}

/// String(v) of a JSON value.
pub fn js_str(v: &Value) -> String {
	match v {
		Value::String(s) => s.clone(),
		Value::Number(n) => forge_core::jsnum::js_to_string(n.as_f64().unwrap_or(0.0)),
		Value::Null => "null".into(),
		Value::Bool(b) => b.to_string(),
		Value::Array(_) | Value::Object(_) => v.to_string(),
	}
}

/// v as `width` base64 digits, most significant first.
pub fn enc(v: f64, width: u32) -> Result<String, String> {
	if !(v >= 0.0 && v < 64f64.powi(width as i32) && v.fract() == 0.0) {
		return Err(format!("pack: {} does not fit {width} base64 digits", forge_core::jsnum::js_to_string(v)));
	}
	let v = v as u64;
	Ok((0..width).rev().map(|i| B64[((v >> (6 * i)) & 63) as usize] as char).collect())
}

/// v as a number of maps format 5's columns: base 32 in base64 digits, five bits a digit, low first; a digit of 32
/// or more says another follows.
pub fn b32(mut v: u64, out: &mut String) {
	while v >= 32 {
		out.push(B64[32 + (v & 31) as usize] as char);
		v >>= 5;
	}
	out.push(B64[v as usize] as char);
}

/// A signed difference as a column number: 0, -1, 1, -2, 2, ... -> 0, 1, 2, 3, 4, ...
pub fn zigzag(v: i64) -> u64 {
	if v >= 0 {
		(v as u64) << 1
	} else {
		(v.unsigned_abs() << 1) - 1
	}
}

/// Standard base64 with padding.
pub fn base64(b: &[u8]) -> String {
	let mut out = String::with_capacity(b.len().div_ceil(3) * 4);
	for ch in b.chunks(3) {
		let n = (ch[0] as u32) << 16 | (*ch.get(1).unwrap_or(&0) as u32) << 8 | *ch.get(2).unwrap_or(&0) as u32;
		out.push(B64[(n >> 18) as usize & 63] as char);
		out.push(B64[(n >> 12) as usize & 63] as char);
		out.push(if ch.len() > 1 { B64[(n >> 6) as usize & 63] as char } else { '=' });
		out.push(if ch.len() > 2 { B64[n as usize & 63] as char } else { '=' });
	}
	out
}

/// What `pack_nav` reads.
pub struct PackIn<'a> {
	/// The grid (format 4).
	pub grid: &'a Path,
	/// The ground layers (roads/, hubs.json).
	pub layers: &'a Path,
	/// The client's AreaTable.csv.
	pub area_table: &'a Path,
	/// data/forever zones.json and map-frames.json.
	pub zones: &'a Path,
	pub map_frames: &'a Path,
	/// The arrow's aids (forge nav aids' aids.json; the CLI takes the grid's), for the chokepoints.
	pub aids: Option<&'a Path>,
	pub cells: usize,
	/// YYYY-MM-DD for the generated headers.
	pub date: &'a str,
	pub continents: &'a [u32],
	/// The command named in the headers, PACK.json and Nav.xml ("forge nav pack").
	pub generator: &'a str,
	/// Leffe's navigation maps (format 4: his Nav folder or the folder holding it) and the maps to take from them
	/// (maps format 5, pack/leffe.rs); the others are ours. None: today's maps, byte for byte.
	pub leffe: Option<(&'a Path, &'a [u32])>,
	/// Leffe's maps carry their blocks as zlib bytes in the string literals (metadata `blocks = "zlib"`) instead of
	/// base64: a quarter less on disk and in memory. Only Leffe's maps; ours stay base64.
	pub zlib_literals: bool,
	pub log: &'a (dyn Fn(&str) + Sync),
}

/// A pack: the files (name -> Lua source, in load order), PACK.json's content without hashes, and the files whose
/// block literals ship as zlib bytes (ship_pack writes them so: Lua source that is not UTF-8).
pub struct Pack {
	pub files: Vec<(String, String)>,
	pub manifest: Map<String, Value>,
	pub raw: Vec<String>,
}

/// The first line of a generated Lua file (tools/lib/generated.js header).
pub fn generated_header(command: &str, sources: &str) -> String {
	format!("-- Generated by `{command}` from {sources}. Do not edit: rebuild with that command.")
}

fn read_json(file: &Path) -> Result<Value, String> {
	serde_json::from_slice(&std::fs::read(file).map_err(|e| format!("{}: {e}", file.display()))?).map_err(|e| format!("{}: {e}", file.display()))
}

/// pack.js packNav (with nav.js's packPlaces and packLayers): every continent of `continents`.
pub fn pack_nav(i: &PackIn) -> Result<Pack, String> {
	let date = i.date;
	let ok_date = date.len() == 10 && date.bytes().enumerate().all(|(n, b)| if n == 4 || n == 7 { b == b'-' } else { b.is_ascii_digit() });
	if !ok_date {
		return Err(format!("pack: date must be YYYY-MM-DD, got {date}"));
	}
	let log = i.log;
	let layers = layers::read_layers(i.layers)?;
	let areas = layers::AreaTable::read(i.area_table)?;
	let zones = read_json(i.zones)?;
	let frames = layers::Frames::new(&read_json(i.map_frames)?, zones.clone());
	let capitals = areas.capitals();
	let city = |c: u32, x: f64, y: f64, area: u32| capitals.contains(&area) || capitals.contains(&frames.zone_area_at(c, x, y));
	let zone_of = areas.zone_of(&zones);
	let opt = |p: &Path| -> Result<Value, String> {
		if p.is_file() {
			read_json(p)
		} else {
			Ok(Value::Null)
		}
	};
	let aids = match i.aids {
		Some(p) => read_json(p)?,
		None => Value::Null,
	};
	let lifts = opt(&i.grid.join("lifts.json"))?;
	// The WMOAreaTable names of the grid's area sidecars (forge nav grid's areas.json: { id: [name, AreaTableID] }).
	// Only named rows are packed: the planner matches a surface's area by its name to the client's subzone
	// (Walk.lua named; Path.AreaName gives none for ""), so an unnamed row is as no area, and the area field
	// and areaNames of every map are half as big without them (Polestar_Nav's memory budget).
	let area_names = opt(&i.grid.join("areas.json"))?;
	let named = |a: u32| area_names[a.to_string()][0].as_str().is_some_and(|n| !n.is_empty());
	let grid = Arc::new(Grid::open(i.grid, 16)?);
	let index = grid.index.clone();
	let mut list = i.continents.to_vec();
	list.sort_unstable();
	let s = |k: &str| index[k].as_str().map_or("null".to_string(), str::to_string);
	let grid_info = json!({ "product": index["product"].as_str(), "build": index["build"].as_str(), "builtAt": index["builtAt"].as_str(), "version": index["version"] });
	let built: String = s("builtAt").chars().take(10).collect();
	// Leffe's maps for any map of this pack: the headers name them (and the command its --leffe).
	let leffe_used = i.leffe.is_some_and(|l| list.iter().any(|c| l.1.contains(c)));
	let source = format!("the navigation grid ({} {}, built {built}){} on {date}", s("product"), s("build"), if leffe_used { " and Leffe's navigation maps" } else { "" });
	let gen = generated_header(&format!("{} --cells {}{}", i.generator, i.cells, if leffe_used { " --leffe" } else { "" }), &source);
	let mut manifest = Map::new();
	manifest.insert("generator".into(), json!(i.generator));
	manifest.insert("format".into(), json!(2));
	manifest.insert("grid".into(), grid_info);
	manifest.insert("cells".into(), json!(i.cells));
	manifest.insert("date".into(), json!(date));
	let mut maps_json = Map::new();
	let mut files: Vec<(String, String)> = Vec::new();
	let mut by_map: Vec<(u32, Vec<chokepoints::Choke>)> = Vec::new();
	let mut raw_files: Vec<String> = Vec::new();
	let nav = Nav::new(grid.clone());
	for &c in &list {
		let t0 = std::time::Instant::now();
		if index["continents"][c.to_string()].is_null() {
			return Err(format!("pack: no continent {c} in {}", i.grid.display()));
		}
		let tiles = crate::prepare::index_tiles(&grid, c);
		let graph = grid.graph(c).ok_or_else(|| format!("pack: {} is missing or unreadable", i.grid.join("graph").join(format!("{c}.bin.gz")).display()))?;
		// The road columns: roadmask.js over the layer's raw weights.
		let mut weights = rustc_hash::FxHashMap::default();
		for &(col, row) in &tiles {
			if let Some(w) = layers::road_weights(&layers.roads, c, col, row)? {
				weights.insert((col, row), w);
			}
		}
		let mask = crate::roadmask::road_mask(c, &tiles, |col, row| weights.get(&(col, row)).cloned(), Some(&nav));
		drop(weights);
		let rs = mask.stats;
		log(&format!(
			"roads {c}: {} strong columns, {} joined by hysteresis, {} pieces, {} ends, {} gaps bridged ({} columns), {} refused (not walkable)",
			rs.strong, rs.weak, rs.pieces, rs.ends, rs.bridges, rs.bridged_columns, rs.refused
		));
		let roads: rustc_hash::FxHashMap<(u32, u32), Vec<u8>> = mask.tiles.into_iter().collect();
		let hubs: Vec<Hub> = layers.hubs.get(&c).cloned().unwrap_or_default();
		let class_layers = cells::ClassLayers { roads: Some(&roads), hubs: &hubs, city: Some(&city), zone: Some(&*zone_of) };
		let gdir = i.grid.to_path_buf();
		let load = move |col: u32, row: u32| -> Result<cells::LoadedTile, String> {
			let key = format!("{c}/{col}_{row}");
			let dir = gdir.join("tiles").join(c.to_string());
			let file = dir.join(format!("{col}_{row}.nav.gz"));
			let raw = std::fs::read(&file).map_err(|e| format!("pack: tile {key}: {e}"))?;
			let raw = crate::grid::gunzip(&raw).map_err(|e| format!("pack: tile {key}: {e}"))?;
			let t = Tile::decode(&raw).map_err(|e| format!("pack: tile {key}: {e}"))?;
			if !t.has_links() {
				return Err(format!("pack: tile {key}: not linked (rerun `forge nav grid`)"));
			}
			if t.tslope.len() != t.n {
				return Err(format!("pack: tile {key}: grid format 3 has no slope per surface (rebuild the grid with `forge nav grid`)"));
			}
			// The WMO group area of each entry (forge nav grid's <tile>.area.gz: a u32 per entry), when the grid has it.
			let af = dir.join(format!("{col}_{row}.area.gz"));
			let area = if af.is_file() {
				let raw = std::fs::read(&af).map_err(|e| format!("pack: tile {key}: {e}"))?;
				let raw = crate::grid::gunzip(&raw).map_err(|e| format!("pack: tile {key}: {e}"))?;
				if raw.len() != t.n * 4 {
					return Err(format!("pack: tile {key}: {} areas for {} entries", js_to_string(raw.len() as f64 / 4.0), t.n));
				}
				Some(raw.chunks_exact(4).map(|b| u32::from_le_bytes(b.try_into().unwrap())).collect())
			} else {
				None
			};
			Ok((t, area))
		};
		let comp_base = |col: u32, row: u32| graph.tile_of(col, row).map(|t| t.comp_base);
		let regions = cells::Regions { comp_base: &comp_base, region: &graph.region, region_size: &graph.region_size };
		let (mut cg, st) = cells::cell_grid(&tiles, &load, &regions, i.cells, c, &class_layers)?;
		cg.keep_areas(named);
		drop(roads);
		log(&format!(
			"cells {}: {} clusters, surfaces {} (floors {}), dropped small-region entries {}, face links {} (opened as the only way in {}), hub cells {}",
			i.cells,
			cg.cluster_count(),
			st.packed,
			cg.floor_cell.len(),
			st.dropped,
			st.faces,
			st.opened,
			st.hub_cells
		));
		let mut m = Map::new();
		// Leffe's navigation maps for this map (format 5), else ours (format 3).
		let leffe = i.leffe.filter(|l| l.1.contains(&c)).map(|l| l.0);
		let (maps, entrances, edges) = match leffe {
			Some(dir) => {
				let (maps, used, s) = leffe::leffe_maps(dir, c, &cg)?;
				log(&format!(
					"Leffe's maps {c}: {} clusters, floors {} ({} no walk can use dropped), entrances {}, edges {} ({} past 63 dropped), jumps {}, drops {}, climbs {} -> {} arcs, {} steep steps closed, {} surfaces with an area of ours",
					s.clusters, s.floors, s.dropped_floors, s.entrances, s.edges, s.dropped, s.jumps, s.drops, s.climbs, s.arcs, s.closed, s.areas
				));
				cg.areas = used;
				m.insert(
					"leffe".into(),
					json!({ "floors": s.floors, "droppedFloors": s.dropped_floors, "jumps": s.jumps, "drops": s.drops, "climbs": s.climbs, "arcs": s.arcs, "droppedEdges": s.dropped, "closedSteps": s.closed, "areaSurfaces": s.areas }),
				);
				(maps, s.entrances, s.edges - s.dropped)
			}
			None => {
				let h = hpa::build_hpa(&cg);
				log(&format!("grid HPA: nodes {}, edges {} (inter {})", h.node_count(), h.edges.len(), h.inter));
				(encode::encode_maps(&cg, &h)?, h.node_count(), h.edges.len())
			}
		};
		let lifts_c: Vec<Value> = lifts[c.to_string()].as_array().cloned().unwrap_or_default();
		let chokes = chokepoints::chokepoints(&nav, c, &aids, &lifts_c, &frames, &areas);
		m.insert("chokepoints".into(), json!(chokes.len()));
		by_map.push((c, chokes));
		let part = leffe.and_then(|_| part_of(c));
		let (mut out, packed_bytes) = encode::pack_files(c, &cg, &maps, "PolestarPathData", &gen, &hubs, Some(&area_names), part)?;
		if let Some(p) = part {
			m.insert("part".into(), json!(p));
		}
		if leffe.is_some() && i.zlib_literals {
			// The metadata says so; its parts' literals are written as zlib bytes (ship_pack).
			out[0].1 = out[0].1.replacen("\tformat = 5,\n", "\tformat = 5,\n\tblocks = \"zlib\",\n", 1);
			raw_files.extend(out.iter().skip(1).map(|f| f.0.clone()));
			m.insert("blocks".into(), json!("zlib"));
		}
		if maps.area.is_some() && manifest.get("format") != Some(&json!(5)) {
			manifest.insert("format".into(), json!(if maps.arc.is_some() { 5 } else { 3 }));
		}
		let raw: usize = maps.fields().iter().map(|f| maps.field(f).values().map(String::len).sum::<usize>()).sum();
		m.insert("clusters".into(), json!(cg.cluster_count()));
		if leffe.is_none() {
			m.insert("floors".into(), json!(cg.floor_cell.len()));
		}
		m.insert("nodes".into(), json!(entrances));
		m.insert("edges".into(), json!(edges));
		m.insert("components".into(), json!(maps.components));
		m.insert("clampedCosts".into(), json!(maps.clamped));
		m.insert("maxDegree".into(), json!(maps.max_degree));
		m.insert("rawBytes".into(), json!(raw));
		m.insert("packedBytes".into(), json!(packed_bytes));
		m.insert("files".into(), json!(out.len()));
		m.insert("hubs".into(), json!(hubs.len()));
		if leffe.is_none() {
			m.insert("classes".into(), class_counts(&cg));
		}
		m.insert(
			"roads".into(),
			json!({ "strong": rs.strong, "weak": rs.weak, "pieces": rs.pieces, "ends": rs.ends, "bridges": rs.bridges, "bridgedColumns": rs.bridged_columns, "refused": rs.refused }),
		);
		if maps.area.is_some() {
			m.insert("areas".into(), json!(cg.areas.len()));
		}
		files.extend(out);
		log(&format!("map {c}: {} ({:.1} s)", Value::Object(m.clone()), t0.elapsed().as_secs_f64()));
		maps_json.insert(c.to_string(), Value::Object(m));
	}
	files.push(("Chokepoints.lua".into(), chokepoints::chokepoints_lua(&by_map, &gen)));
	manifest.insert("maps".into(), Value::Object(maps_json));
	Ok(Pack { files, manifest, raw: raw_files })
}

/// Surfaces per base class, and in a hub of each side, for PACK.json.
fn class_counts(cg: &cells::CellGrid) -> Value {
	let names = ["normal", "road", "gentle", "steep", "indoor", "city"];
	let mut n = [0usize; 8];
	let mut count = |b: u8| {
		n[if ((b & 7) as usize) < 6 { (b & 7) as usize } else { 0 }] += 1;
		if b & HUB_ALLIANCE != 0 {
			n[6] += 1;
		}
		if b & HUB_HORDE != 0 {
			n[7] += 1;
		}
	};
	for cl in cg.clusters() {
		let cls = cl.cls.as_deref().unwrap_or(&[]);
		for (l, &v) in cl.val.iter().enumerate() {
			if v != 0 {
				count(cls.get(l).copied().unwrap_or(0));
			}
		}
	}
	for &b in &cg.floor_class {
		count(b);
	}
	let mut out = Map::new();
	for (i, name) in names.iter().enumerate() {
		out.insert((*name).into(), json!(n[i]));
	}
	out.insert("allianceHub".into(), json!(n[6]));
	out.insert("hordeHub".into(), json!(n[7]));
	Value::Object(out)
}

/// Files of ours in an addon's Nav/: our maps' files and the chokepoints.
pub fn own_file(name: &str) -> bool {
	if name == "Chokepoints.lua" {
		return true;
	}
	let Some(rest) = name.strip_prefix("Nav").and_then(|r| r.strip_suffix(".lua")) else { return false };
	let (m, part) = rest.split_once('_').map_or((rest, None), |(a, b)| (a, Some(b)));
	MAPS.iter().any(|x| x.to_string() == m) && part.is_none_or(|p| !p.is_empty() && p.bytes().all(|b| b.is_ascii_digit()))
}

/// JSON.stringify(v, null, '\t').
pub fn json_tabs(v: &Value) -> String {
	let mut out = Vec::new();
	let mut ser = serde_json::Serializer::with_formatter(&mut out, serde_json::ser::PrettyFormatter::with_indent(b"\t"));
	serde::Serialize::serialize(v, &mut ser).unwrap();
	String::from_utf8(out).unwrap()
}

/// Nav/Nav.xml of an addon folder: the files of its PACK.json, in its order, the chokepoints last;
/// its comment names PACK.json's generator.
pub fn nav_xml(addon_dir: &Path) -> String {
	let doc: Value = std::fs::read(addon_dir.join(PACK_JSON)).ok().and_then(|b| serde_json::from_slice(&b).ok()).unwrap_or(Value::Null);
	let ours: Vec<String> = doc["files"].as_object().map(|m| m.keys().filter_map(|k| k.strip_prefix("Nav/").map(str::to_string)).collect()).unwrap_or_default();
	let generator = doc["generator"].as_str().unwrap_or("forge nav pack");
	let mut lines = vec!["<Ui xmlns=\"http://www.blizzard.com/wow/ui/\">".to_string(), format!("\t<!-- Written by {generator}: Polestar's walking maps (PACK.json), then the chokepoints. -->")];
	for n in ours.iter().filter(|n| *n != "Chokepoints.lua").chain(ours.iter().filter(|n| *n == "Chokepoints.lua")) {
		lines.push(format!("\t<Script file=\"{n}\"/>"));
	}
	lines.push("</Ui>".into());
	lines.push(String::new());
	lines.join("\n")
}

fn sha256(b: &[u8]) -> String {
	Sha256::digest(b).iter().map(|x| format!("{x:02x}")).collect()
}

/// Where a packed file lives and its PACK.json key: `Nav/<name>` in the addon folder, or a part addon's
/// `<part>/<file>` in the folder beside it (the AddOns folder).
fn placed(addon_dir: &Path, name: &str) -> (PathBuf, String) {
	match name.split_once('/') {
		Some((part, file)) => (addon_dir.parent().unwrap_or(Path::new(".")).join(part).join(file), format!("{part}/{file}")),
		None => (addon_dir.join("Nav").join(name), format!("Nav/{name}")),
	}
}

/// A part addon's map parts: Nav<map>_<n>.lua.
fn own_part_file(name: &str) -> bool {
	own_file(name) && name != "Chokepoints.lua" && name.contains('_')
}

/// The `## Interface` and `## Version` lines of Polestar_Nav's TOC, which a part's TOC repeats.
fn toc_heads(addon_dir: &Path) -> Vec<String> {
	let name = addon_dir.file_name().map(|n| n.to_string_lossy().into_owned()).unwrap_or_default();
	let text = std::fs::read_to_string(addon_dir.join(format!("{name}.toc"))).unwrap_or_default();
	["## Interface:", "## Version:"].iter().filter_map(|h| text.lines().find(|l| l.starts_with(h)).map(str::to_string)).collect()
}

/// A part addon's TOC: load on demand after Polestar_Nav, its map parts in order.
pub fn part_toc(part: &str, files: &[String], heads: &[String], generator: &str) -> String {
	let continent = match PARTS.iter().find(|p| p.1 == part).map(|p| p.0) {
		Some(0) => "the Eastern Kingdoms",
		_ => "Kalimdor",
	};
	let mut lines: Vec<String> = heads.iter().filter(|h| h.starts_with("## Interface:")).cloned().collect();
	lines.push(format!("## Title: Polestar Nav ({})", continent.trim_start_matches("the ")));
	lines.push(format!("## Notes: Walking maps of {continent} for Polestar's arrow, from Leffe's navigation maps. Loaded on demand on that continent."));
	lines.extend(forge_guide::toc::toc_lines(part));
	lines.push("## Author: Polestar; walking maps: Leffe's navigation maps".into());
	lines.extend(heads.iter().filter(|h| h.starts_with("## Version:")).cloned());
	lines.push("## Category: Polestar".into());
	lines.push("## Group: Polestar".into());
	lines.push("## LoadOnDemand: 1".into());
	lines.push("## Dependencies: Polestar_Nav".into());
	lines.push("## X-License: GPL-3.0-or-later".into());
	lines.push(format!("# Written by {generator}: the map parts Polestar_Nav's router loads when it first searches {continent}."));
	lines.push(String::new());
	lines.extend(files.iter().cloned());
	lines.push(String::new());
	lines.join("\n")
}

/// The files a part's TOC loads, in order.
fn toc_files(text: &str) -> Vec<String> {
	text.lines().map(str::trim).filter(|l| !l.is_empty() && !l.starts_with('#')).map(str::to_string).collect()
}

/// Writes a pack into an addon folder: Nav/<files>, PACK.json (with the sha256 of every file, in
/// load order), Nav/Nav.xml, and each part addon's files and TOC beside it. Our files the pack has no more
/// are removed (a part addon the pack no longer has loses its files and TOC). -> (written, removed)
pub fn ship_pack(pack: &Pack, addon_dir: &Path) -> Result<(Vec<String>, Vec<String>), String> {
	let nav_dir = addon_dir.join("Nav");
	let err = |p: &Path, e: std::io::Error| format!("{}: {e}", p.display());
	std::fs::create_dir_all(&nav_dir).map_err(|e| err(&nav_dir, e))?;
	let keys: Vec<String> = pack.files.iter().map(|f| placed(addon_dir, &f.0).1).collect();
	let mut removed = Vec::new();
	let mut names: Vec<String> = std::fs::read_dir(&nav_dir).map_err(|e| err(&nav_dir, e))?.filter_map(|e| e.ok()?.file_name().into_string().ok()).collect();
	names.sort();
	for name in names {
		if own_file(&name) && !keys.contains(&format!("Nav/{name}")) {
			let p = nav_dir.join(&name);
			std::fs::remove_file(&p).map_err(|e| err(&p, e))?;
			removed.push(format!("Nav/{name}"));
		}
	}
	let parent = addon_dir.parent().unwrap_or(Path::new("."));
	for (_, part) in PARTS {
		let dir = parent.join(part);
		let used = keys.iter().any(|k| k.starts_with(&format!("{part}/")));
		if used {
			std::fs::create_dir_all(&dir).map_err(|e| err(&dir, e))?;
		}
		let mut names: Vec<String> = std::fs::read_dir(&dir).into_iter().flatten().filter_map(|e| e.ok()?.file_name().into_string().ok()).collect();
		names.sort();
		for name in names {
			let key = format!("{part}/{name}");
			if (own_part_file(&name) && !keys.contains(&key)) || (!used && name == format!("{part}.toc")) {
				let p = dir.join(&name);
				std::fs::remove_file(&p).map_err(|e| err(&p, e))?;
				removed.push(key);
			}
		}
		if !used && dir.is_dir() && std::fs::read_dir(&dir).map(|mut d| d.next().is_none()).unwrap_or(false) {
			std::fs::remove_dir(&dir).map_err(|e| err(&dir, e))?;
		}
	}
	let mut hashes = Map::new();
	for (name, text) in &pack.files {
		let (p, key) = placed(addon_dir, name);
		let bytes = if pack.raw.contains(name) { zlib_literals(text)? } else { text.as_bytes().to_vec() };
		std::fs::write(&p, &bytes).map_err(|e| err(&p, e))?;
		hashes.insert(key, json!(sha256(&bytes)));
	}
	let written = hashes.keys().cloned().collect();
	let generator = pack.manifest.get("generator").and_then(Value::as_str).unwrap_or("forge nav pack").to_string();
	let heads = toc_heads(addon_dir);
	for (_, part) in PARTS {
		let files: Vec<String> = keys.iter().filter_map(|k| k.strip_prefix(&format!("{part}/")).map(str::to_string)).collect();
		if !files.is_empty() {
			let p = parent.join(part).join(format!("{part}.toc"));
			std::fs::write(&p, part_toc(part, &files, &heads, &generator)).map_err(|e| err(&p, e))?;
		}
	}
	let mut doc = pack.manifest.clone();
	doc.insert("files".into(), Value::Object(hashes));
	let pj = addon_dir.join(PACK_JSON);
	std::fs::write(&pj, format!("{}\n", json_tabs(&Value::Object(doc)))).map_err(|e| err(&pj, e))?;
	let xml = nav_dir.join("Nav.xml");
	std::fs::write(&xml, nav_xml(addon_dir)).map_err(|e| err(&xml, e))?;
	Ok((written, removed))
}

/// What differs between an addon folder (and its part addons beside it) and its PACK.json: changed, missing and
/// unlisted files of ours, a Nav.xml that is not nav_xml's, a part TOC not loading its listed parts in order.
/// Empty when it matches.
pub fn check_pack(addon_dir: &Path) -> Vec<String> {
	let file: PathBuf = addon_dir.join(PACK_JSON);
	if !file.is_file() {
		return vec![format!("{} is missing: run `forge nav pack`", file.display())];
	}
	let manifest: Value = match std::fs::read(&file).map_err(|e| e.to_string()).and_then(|b| serde_json::from_slice(&b).map_err(|e| e.to_string())) {
		Ok(v) => v,
		Err(e) => return vec![format!("{} is not valid JSON ({e})", file.display())],
	};
	let Some(listed) = manifest["files"].as_object() else { return vec![format!("{} lacks files", file.display())] };
	let mut problems = Vec::new();
	let parent = addon_dir.parent().unwrap_or(Path::new("."));
	for (rel, want) in listed {
		let (dir, name) = rel.split_once('/').unwrap_or(("", ""));
		let ours = if dir == "Nav" { own_file(name) } else { PARTS.iter().any(|p| p.1 == dir) && own_part_file(name) };
		if !ours {
			problems.push(format!("{rel} in PACK.json is not a packed file"));
			continue;
		}
		let path = if dir == "Nav" { addon_dir.join("Nav").join(name) } else { parent.join(dir).join(name) };
		match std::fs::read(path) {
			Err(_) => problems.push(format!("{rel} is missing")),
			Ok(b) => {
				if Some(sha256(&b).as_str()) != want.as_str() {
					problems.push(format!("{rel} differs from PACK.json"));
				}
			}
		}
	}
	let nav_dir = addon_dir.join("Nav");
	let mut names: Vec<String> = std::fs::read_dir(&nav_dir).into_iter().flatten().filter_map(|e| e.ok()?.file_name().into_string().ok()).collect();
	names.sort();
	for name in names {
		if own_file(&name) && !listed.contains_key(&format!("Nav/{name}")) {
			problems.push(format!("Nav/{name} is not listed in PACK.json"));
		}
	}
	for (_, part) in PARTS {
		let dir = parent.join(part);
		let want: Vec<String> = listed.keys().filter_map(|k| k.strip_prefix(&format!("{part}/")).map(str::to_string)).collect();
		let mut names: Vec<String> = std::fs::read_dir(&dir).into_iter().flatten().filter_map(|e| e.ok()?.file_name().into_string().ok()).collect();
		names.sort();
		for name in names {
			if own_part_file(&name) && !want.contains(&name) {
				problems.push(format!("{part}/{name} is not listed in PACK.json"));
			}
		}
		let toc = std::fs::read_to_string(dir.join(format!("{part}.toc"))).ok();
		match (want.is_empty(), toc) {
			(false, None) => problems.push(format!("{part}/{part}.toc is missing")),
			(false, Some(t)) if toc_files(&t) != want => problems.push(format!("{part}/{part}.toc does not load its packed maps in order (rerun `forge nav pack`)")),
			(true, Some(_)) => problems.push(format!("{part}/{part}.toc is left over: the pack has no part there")),
			_ => {}
		}
	}
	let xml = std::fs::read_to_string(nav_dir.join("Nav.xml")).ok();
	if xml.as_deref() != Some(nav_xml(addon_dir).as_str()) {
		problems.push("Nav/Nav.xml does not list the packed maps (rerun `forge nav pack`)".into());
	}
	problems
}

/// A part file with its block literals as the zlib bytes themselves (maps metadata `blocks = "zlib"`): every
/// quoted base64 block of a `data.packed` line decoded, written back with only the bytes a Lua 5.1 string literal
/// cannot hold, and NUL and Ctrl-Z, as three-digit decimal escapes.
pub fn zlib_literals(text: &str) -> Result<Vec<u8>, String> {
	let mut out = Vec::with_capacity(text.len());
	for line in text.split_inclusive('\n') {
		if !line.starts_with("data.packed.") {
			out.extend_from_slice(line.as_bytes());
			continue;
		}
		let mut parts = line.split('"');
		out.extend_from_slice(parts.next().unwrap_or("").as_bytes());
		for (i, piece) in parts.enumerate() {
			out.push(b'"');
			if i % 2 == 1 {
				out.extend_from_slice(piece.as_bytes());
				continue;
			}
			for &b in &unbase64(piece)? {
				match b {
					0 | 10 | 13 | 26 | b'"' | b'\\' => out.extend_from_slice(format!("\\{b:03}").as_bytes()),
					_ => out.push(b),
				}
			}
		}
	}
	Ok(out)
}

fn unbase64(s: &str) -> Result<Vec<u8>, String> {
	let val = |c: u8| B64.iter().position(|&x| x == c).map(|v| v as u32).ok_or_else(|| format!("pack: {} is not base64", c as char));
	let b = s.trim_end_matches('=').as_bytes();
	let mut out = Vec::with_capacity(b.len() * 3 / 4);
	for ch in b.chunks(4) {
		let mut n = 0u32;
		for (i, &c) in ch.iter().enumerate() {
			n |= val(c)? << (18 - 6 * i);
		}
		out.push((n >> 16) as u8);
		if ch.len() > 2 {
			out.push((n >> 8) as u8);
		}
		if ch.len() > 3 {
			out.push(n as u8);
		}
	}
	Ok(out)
}
