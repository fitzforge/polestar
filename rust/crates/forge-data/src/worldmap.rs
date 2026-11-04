//! `forge data maps build|overlays` (port of tools/lib/maps/{zonelevels,overlays}.js and
//! commands/maps.js). Same inputs give byte-identical output.
//!
//! build: each zone's level range from data/forever (forge_world::zonelevels, the heuristic) ->
//! addon/Polestar/Maps/ZoneLevels.lua. Forever-only zones (maps with Forever frames and no Era
//! frames in map-frames.json) are held to the sparse thresholds.
//!
//! overlays: every world map overlay (the explored-area paintings) of every zone map, from the
//! client's DB2 tables -> addon/Polestar/UI/ZoneArtOverlays.lua, so the zone art can show a map
//! without fog of war. Keyed by UiMapArtID: the addon draws a table only when C_Map.GetMapArtID
//! returns the art it was built for.
//!   UiMapXMapArt         uiMapID -> UiMapArtID (every phase)
//!   UiMapArt             UiMapArtID -> UiMapArtStyleID
//!   UiMapArtStyleLayer   the style's layer 0 tile size
//!   WorldMapOverlay      per art: texture size, offset on the layer
//!   WorldMapOverlayTile  per overlay: tile FileDataIDs at RowIndex/ColIndex
//!   UiMap                names, for comments only

use std::collections::BTreeMap;
use std::path::Path;

use forge_guide::js::num_str;
use forge_world::data::{Entity, Zone};
use rustc_hash::FxHashMap;

use crate::jsv::{col_num, col_str, Rows};

/// The Forever client build the overlays are read from.
pub const OVERLAYS_BUILD: &str = "1.60.1.70338";
pub const OVERLAY_TABLES: [&str; 6] = ["UiMapXMapArt", "UiMapArt", "UiMapArtStyleLayer", "WorldMapOverlay", "WorldMapOverlayTile", "UiMap"];

fn read_json<T: serde::de::DeserializeOwned>(file: &Path) -> Result<T, String> {
	let text = std::fs::read_to_string(file).map_err(|_| format!("missing {} (run: forge data build)", file.display()))?;
	serde_json::from_str(&text).map_err(|e| format!("{}: {e}", file.display()))
}

/// Maps with Forever frames and no Era frames: the Forever-only zones.
pub fn forever_only(frames: &serde_json::Value) -> Vec<u32> {
	let era = frames.get("era").and_then(|v| v.as_object());
	let mut out: Vec<u32> =
		frames.get("forever").and_then(|v| v.as_object()).into_iter().flat_map(|f| f.keys()).filter(|k| !era.is_some_and(|e| e.contains_key(k.as_str()))).filter_map(|k| k.parse().ok()).collect();
	out.sort();
	out
}

/// ZoneLevels.lua from data/forever. -> (zones with a range, the Lua)
pub fn zone_levels(data: &Path) -> Result<(usize, String), String> {
	let npcs: BTreeMap<u32, Entity> = read_json(&data.join("npcs.json"))?;
	let zones: BTreeMap<u32, Zone> = read_json(&data.join("zones.json"))?;
	let frames = data.join("map-frames.json");
	let sparse = if frames.exists() { forever_only(&read_json(&frames)?) } else { Vec::new() };
	let levels = forge_world::zonelevels::zone_levels(&npcs, &zones, &sparse);
	let mut l = vec![
		forge_guide::emit::header("lua", "forge data maps build", "data/forever/npcs.json"),
		"-- Zone level ranges from data/forever/npcs.json (pfQuest, MIT): spawn-weighted".into(),
		"-- P10..P90 of normal-rank creatures friendly to neither faction, critters more".into(),
		"-- than 15 levels under the median dropped (rust/crates/forge-world/src/zonelevels.rs).".into(),
		String::new(),
		"local ADDON, ns = ...".into(),
		"local M = ns.Maps".into(),
		"if not (M and M.RegisterZoneLevels) then return end".into(),
		String::new(),
		"M.RegisterZoneLevels({".into(),
		"\t-- [uiMapID] = { minLevel, maxLevel, labelX, labelY } (label point in zone map percent)".into(),
	];
	let opt = |x: Option<f64>| x.map(num_str).unwrap_or_else(|| "null".into());
	for (id, z) in &levels {
		let name = zones[id].name.as_deref().unwrap_or("").replace('\n', " ");
		l.push(format!("\t[{id}] = {{ {}, {}, {}, {} }}, -- {name}", opt(z.min), opt(z.max), num_str(z.x), num_str(z.y)));
	}
	l.push("})".into());
	l.push(String::new());
	Ok((levels.len(), l.join("\n")))
}

pub struct Overlay {
	pub id: f64,
	pub width: f64,
	pub height: f64,
	pub x: f64,
	pub y: f64,
	pub files: Vec<f64>,
}

pub struct Art {
	pub maps: Vec<f64>,
	pub names: Vec<Option<String>>,
	pub tile_width: f64,
	pub tile_height: f64,
	pub overlays: Vec<Overlay>,
}

pub struct Overlays {
	/// By UiMapArtID.
	pub arts: BTreeMap<i64, Art>,
	pub count: usize,
	pub tiles: usize,
	pub warnings: Vec<String>,
}

/// overlays.js `buildOverlays` over the six tables' rows.
pub fn build_overlays(t: &FxHashMap<String, Rows>) -> Overlays {
	let rows = |n: &str| t.get(n).map(Vec::as_slice).unwrap_or(&[]);
	let key = |x: f64| x.to_bits();
	let mut warnings = Vec::new();
	let mut maps_of: FxHashMap<u64, Vec<f64>> = FxHashMap::default();
	for r in rows("UiMapXMapArt") {
		let m = maps_of.entry(key(col_num(r, "UiMapArtID"))).or_default();
		let map = col_num(r, "UiMapID");
		if !m.contains(&map) {
			m.push(map);
		}
	}
	let style_of: FxHashMap<u64, f64> = rows("UiMapArt").iter().map(|r| (key(col_num(r, "ID")), col_num(r, "UiMapArtStyleID"))).collect();
	let mut layer_of: FxHashMap<u64, &crate::jsv::Row> = FxHashMap::default();
	for r in rows("UiMapArtStyleLayer") {
		if col_num(r, "LayerIndex") == 0.0 {
			layer_of.insert(key(col_num(r, "UiMapArtStyleID")), r);
		}
	}
	let name_of: FxHashMap<u64, &str> = rows("UiMap").iter().map(|r| (key(col_num(r, "ID")), col_str(r, "Name_lang"))).collect();
	let mut tiles_of: FxHashMap<u64, Vec<&crate::jsv::Row>> = FxHashMap::default();
	for r in rows("WorldMapOverlayTile") {
		if col_num(r, "LayerIndex") != 0.0 {
			continue;
		}
		tiles_of.entry(key(col_num(r, "WorldMapOverlayID"))).or_default().push(r);
	}
	let mut sorted: Vec<&crate::jsv::Row> = rows("WorldMapOverlay").iter().collect();
	sorted.sort_by(|a, b| {
		let d = col_num(a, "UiMapArtID") - col_num(b, "UiMapArtID");
		let d = if d == 0.0 { col_num(a, "ID") - col_num(b, "ID") } else { d };
		d.partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal)
	});
	let mut arts: BTreeMap<i64, Art> = BTreeMap::new();
	let (mut count, mut tile_count) = (0, 0);
	for o in sorted {
		let art = col_num(o, "UiMapArtID");
		let Some(maps) = maps_of.get(&key(art)) else { continue };
		let oid = col_str(o, "ID");
		let Some(layer) = style_of.get(&key(art)).and_then(|s| layer_of.get(&key(*s))) else {
			warnings.push(format!("UiMapArt {}: no style layer 0; overlay {oid} skipped", num_str(art)));
			continue;
		};
		let (tw, th) = (col_num(layer, "TileWidth"), col_num(layer, "TileHeight"));
		let (width, height) = (col_num(o, "TextureWidth"), col_num(o, "TextureHeight"));
		let cols = (width / tw).ceil();
		let rows_n = (height / th).ceil();
		let mut grid: FxHashMap<(u64, u64), f64> = FxHashMap::default();
		for t in tiles_of.get(&key(col_num(o, "ID"))).into_iter().flatten() {
			grid.insert((key(col_num(t, "RowIndex")), key(col_num(t, "ColIndex"))), col_num(t, "FileDataID"));
		}
		if !(width > 0.0 && height > 0.0) {
			continue; // an empty row: nothing to draw
		}
		let mut files = Vec::new();
		let mut r = 0.0;
		while r < rows_n {
			let mut c = 0.0;
			while c < cols {
				files.push(grid.get(&(key(r), key(c))).copied());
				c += 1.0;
			}
			r += 1.0;
		}
		let complete = files.iter().all(|f| f.is_some_and(|x| x != 0.0 && !x.is_nan()));
		if grid.len() as f64 != cols * rows_n || !complete {
			warnings.push(format!("WorldMapOverlay {oid} (art {}): {} tiles for a {}x{} grid; skipped", num_str(art), grid.len(), num_str(cols), num_str(rows_n)));
			continue;
		}
		let entry = arts.entry(art as i64).or_insert_with(|| {
			let mut m = maps.clone();
			m.sort_by(f64::total_cmp);
			let names = m.iter().map(|x| name_of.get(&key(*x)).map(|s| s.to_string())).collect();
			Art { maps: m, names, tile_width: tw, tile_height: th, overlays: Vec::new() }
		});
		let files: Vec<f64> = files.into_iter().flatten().collect();
		tile_count += files.len();
		entry.overlays.push(Overlay { id: col_num(o, "ID"), width, height, x: col_num(o, "OffsetX"), y: col_num(o, "OffsetY"), files });
		count += 1;
	}
	Overlays { arts, count, tiles: tile_count, warnings }
}

pub fn emit_overlays(o: &Overlays, build: &str) -> String {
	let mut l = vec![
		forge_guide::emit::header("lua", "forge data maps overlays", "the client's map tables"),
		"-- Every world map overlay of every zone map, from the client's own tables".into(),
		"-- (UiMapXMapArt, UiMapArt, UiMapArtStyleLayer, WorldMapOverlay,".into(),
		format!("-- WorldMapOverlayTile; build {build} via wago.tools), so UI.ZoneArt can"),
		"-- show a zone without fog of war (rust/crates/forge-data/src/worldmap.rs). File IDs only:".into(),
		"-- the textures are the player's own client files.".into(),
		String::new(),
		"local ADDON, ns = ...".into(),
		"local ZA = ns.UI and ns.UI.ZoneArt".into(),
		"if not (ZA and ZA.RegisterOverlays) then return end".into(),
		String::new(),
		format!("ZA.RegisterOverlays({}, {{", serde_json::to_string(build).unwrap()),
		"\t-- [uiMapArtID] = { tileWidth, tileHeight, { textureWidth, textureHeight, offsetX, offsetY, fileDataID, ... (row-major) }, ... }".into(),
	];
	for (id, a) in &o.arts {
		let label: Vec<String> = a
			.maps
			.iter()
			.zip(&a.names)
			.map(|(m, n)| match n.as_deref().filter(|s| !s.is_empty()) {
				Some(n) => format!("{n} ({})", num_str(*m)),
				None => num_str(*m),
			})
			.collect();
		l.push(format!("\t[{id}] = {{ {}, {}, -- {}", num_str(a.tile_width), num_str(a.tile_height), label.join(", ").replace('\n', " ")));
		for ov in &a.overlays {
			let mut v = vec![ov.width, ov.height, ov.x, ov.y];
			v.extend(&ov.files);
			l.push(format!("\t\t{{ {} }},", v.into_iter().map(num_str).collect::<Vec<_>>().join(", ")));
		}
		l.push("\t},".into());
	}
	l.push("})".into());
	l.push(String::new());
	l.join("\n")
}

/// The six tables of `build` (fetched when missing unless `offline`).
pub fn overlay_tables(sources: &Path, build: &str, offline: bool, log: &dyn Fn(&str)) -> Result<FxHashMap<String, Rows>, String> {
	let (_, t, _) = crate::sources::client_tables(sources, &crate::tables::FOREVER, Some(build), &OVERLAY_TABLES, offline, log)?;
	Ok(t.into_iter().collect())
}

#[cfg(test)]
mod tests {
	use super::*;

	fn rows(header: &str, lines: &[&str]) -> Rows {
		crate::tables::parse_csv(&format!("{header}\n{}\n", lines.join("\n"))).unwrap()
	}

	#[test]
	fn overlays_cover_every_tile_or_are_skipped() {
		let mut t: FxHashMap<String, Rows> = FxHashMap::default();
		t.insert("UiMapXMapArt".into(), rows("UiMapID,UiMapArtID", &["1429,5", "1430,5", "9,6"]));
		t.insert("UiMapArt".into(), rows("ID,UiMapArtStyleID", &["5,1", "6,2"]));
		t.insert("UiMapArtStyleLayer".into(), rows("UiMapArtStyleID,LayerIndex,TileWidth,TileHeight", &["1,0,256,256", "1,1,10,10"]));
		t.insert("UiMap".into(), rows("ID,Name_lang", &["1429,Elwynn Forest"]));
		t.insert(
			"WorldMapOverlay".into(),
			rows("ID,UiMapArtID,TextureWidth,TextureHeight,OffsetX,OffsetY", &["21,5,300,200,10,20", "20,5,100,100,0,0", "22,5,0,0,0,0", "23,6,10,10,0,0", "24,5,512,10,0,0"]),
		);
		t.insert("WorldMapOverlayTile".into(), rows("WorldMapOverlayID,RowIndex,ColIndex,FileDataID,LayerIndex", &["20,0,0,100,0", "21,0,1,202,0", "21,0,0,201,0", "24,0,0,7,0"]));
		let o = build_overlays(&t);
		assert_eq!((o.count, o.tiles), (2, 3));
		assert_eq!(o.warnings, vec!["WorldMapOverlay 24 (art 5): 1 tiles for a 2x1 grid; skipped", "UiMapArt 6: no style layer 0; overlay 23 skipped"]);
		let lua = emit_overlays(&o, "1.60.1.70338");
		assert!(lua.contains("ZA.RegisterOverlays(\"1.60.1.70338\", {"));
		assert!(lua.contains("\t[5] = { 256, 256, -- Elwynn Forest (1429), 1430\n\t\t{ 100, 100, 0, 0, 100 },\n\t\t{ 300, 200, 10, 20, 201, 202 },\n\t},\n"), "{lua}");
	}

	#[test]
	fn forever_only_maps_are_the_ones_without_era_frames() {
		let f: serde_json::Value = serde_json::from_str(r#"{"era":{"1":{},"2":{}},"forever":{"2":{},"10":{},"3":{}}}"#).unwrap();
		assert_eq!(forever_only(&f), vec![3, 10]);
	}
}
