//! Zone art overlays (tools/lib/maps/overlays.js -> addon/Polestar/UI/ZoneArtOverlays.lua): the table built
//! from synthetic DB2 rows (keyed by art, tiles row-major, partial tiles, bad rows dropped), the generated Lua,
//! and the addon reading it.

use forge_addontest::tmp::TempDir;
use forge_addontest::{emitted, is_match, lua_string, Addon, RunAddon};
use forge_data::jsv::Row;
use forge_data::worldmap::{build_overlays, emit_overlays, overlay_tables, Overlay, Overlays, OVERLAY_TABLES};
use serde_json::json;

// CSV rows are strings, as wago.tools exports them.
fn row(pairs: &[(&str, i64)]) -> Row {
	pairs.iter().map(|(k, v)| (k.to_string(), v.to_string())).collect()
}

fn srow(pairs: &[(&str, &str)]) -> Row {
	pairs.iter().map(|(k, v)| (k.to_string(), v.to_string())).collect()
}

fn overlay(id: i64, art: i64, w: i64, h: i64, x: i64, y: i64) -> Row {
	row(&[("ID", id), ("UiMapArtID", art), ("TextureWidth", w), ("TextureHeight", h), ("OffsetX", x), ("OffsetY", y), ("Flags", 0)])
}

fn tile(id: i64, ov: i64, r: i64, c: i64, file: i64) -> Row {
	tile_l(id, ov, r, c, file, 0)
}

fn tile_l(id: i64, ov: i64, r: i64, c: i64, file: i64, layer: i64) -> Row {
	row(&[("ID", id), ("WorldMapOverlayID", ov), ("RowIndex", r), ("ColIndex", c), ("FileDataID", file), ("LayerIndex", layer)])
}

fn build() -> Overlays {
	let tables: Vec<(String, Vec<Row>)> = vec![
		// Map 10 shows art 100; map 11 (another phase of it) art 101; art 102 is shown by no map.
		(
			"UiMapXMapArt".into(),
			vec![
				row(&[("ID", 1), ("PhaseID", 0), ("UiMapArtID", 100), ("UiMapID", 10)]),
				row(&[("ID", 2), ("PhaseID", 0), ("UiMapArtID", 101), ("UiMapID", 11)]),
				row(&[("ID", 3), ("PhaseID", 7), ("UiMapArtID", 101), ("UiMapID", 12)]),
			],
		),
		("UiMapArt".into(), vec![row(&[("ID", 100), ("UiMapArtStyleID", 1)]), row(&[("ID", 101), ("UiMapArtStyleID", 4)]), row(&[("ID", 102), ("UiMapArtStyleID", 1)])]),
		(
			"UiMapArtStyleLayer".into(),
			vec![
				row(&[("ID", 1), ("LayerIndex", 0), ("LayerWidth", 1002), ("LayerHeight", 668), ("TileWidth", 256), ("TileHeight", 256), ("UiMapArtStyleID", 1)]),
				row(&[("ID", 6), ("LayerIndex", 0), ("LayerWidth", 512), ("LayerHeight", 512), ("TileWidth", 512), ("TileHeight", 512), ("UiMapArtStyleID", 4)]),
			],
		),
		(
			"WorldMapOverlay".into(),
			vec![
				overlay(20, 100, 600, 300, 10, 20),   // 3 x 2 tiles, the last column 88 wide, the last row 44 high
				overlay(21, 100, 128, 128, 400, 400), // one tile
				overlay(22, 100, 256, 256, 0, 0),     // tiles missing: dropped with a warning
				overlay(23, 100, 0, 0, 0, 0),         // empty: dropped quietly
				overlay(30, 101, 600, 300, 5, 6),     // 512px tiles: 2 x 1
				overlay(40, 102, 128, 128, 0, 0),     // art no map shows: dropped
			],
		),
		(
			"WorldMapOverlayTile".into(),
			vec![
				// Out of order on purpose; one tile of another layer to ignore.
				tile(1, 20, 1, 2, 1006),
				tile(2, 20, 0, 0, 1001),
				tile(3, 20, 1, 0, 1004),
				tile(4, 20, 0, 2, 1003),
				tile(5, 20, 1, 1, 1005),
				tile(6, 20, 0, 1, 1002),
				tile_l(7, 20, 0, 0, 9999, 1),
				tile(8, 21, 0, 0, 2001),
				tile(9, 30, 0, 1, 3002),
				tile(10, 30, 0, 0, 3001),
				tile(11, 40, 0, 0, 4001),
			],
		),
		("UiMap".into(), vec![srow(&[("ID", "10"), ("Name_lang", "Greenvale")]), srow(&[("ID", "11"), ("Name_lang", "Isle")]), srow(&[("ID", "12"), ("Name_lang", "Isle (phased)")])]),
	];
	let t = tables.into_iter().collect();
	build_overlays(&t)
}

type Ov = (f64, f64, f64, f64, f64, Vec<f64>);

fn ov(o: &Overlay) -> Ov {
	(o.id, o.width, o.height, o.x, o.y, o.files.clone())
}

#[test]
fn overlays_are_keyed_by_the_art_they_belong_to_tiles_row_major_partial_tiles_kept_broken_rows_dropped() {
	let out = build();
	assert_eq!(out.arts.keys().copied().collect::<Vec<i64>>(), vec![100, 101]);
	let a = &out.arts[&100];
	assert_eq!(a.maps, vec![10.0]);
	assert_eq!(a.names, vec![Some("Greenvale".to_string())]);
	assert_eq!(a.tile_width, 256.0);
	assert_eq!(a.tile_height, 256.0);
	assert_eq!(
		a.overlays.iter().map(ov).collect::<Vec<Ov>>(),
		vec![(20.0, 600.0, 300.0, 10.0, 20.0, vec![1001.0, 1002.0, 1003.0, 1004.0, 1005.0, 1006.0]), (21.0, 128.0, 128.0, 400.0, 400.0, vec![2001.0]),]
	);
	// The art's own tile size splits it (512 here), and every map showing it is named.
	let b = &out.arts[&101];
	assert_eq!(b.maps, vec![11.0, 12.0]);
	assert_eq!(b.names, vec![Some("Isle".to_string()), Some("Isle (phased)".to_string())]);
	assert_eq!(b.tile_width, 512.0);
	assert_eq!(b.tile_height, 512.0);
	assert_eq!(b.overlays.iter().map(ov).collect::<Vec<Ov>>(), vec![(30.0, 600.0, 300.0, 5.0, 6.0, vec![3001.0, 3002.0])]);
	assert_eq!(out.count, 3);
	assert_eq!(out.tiles, 9);
	assert_eq!(out.warnings, vec!["WorldMapOverlay 22 (art 100): 0 tiles for a 1x1 grid; skipped"]);
}

#[test]
fn the_generated_lua_registers_the_table_with_zoneart_byte_identical_for_the_same_input() {
	let result = build();
	let lua = emit_overlays(&result, "9.9.9.1");
	assert_eq!(lua, emit_overlays(&build(), "9.9.9.1"));
	assert!(is_match(&lua, r#"ZA\.RegisterOverlays\("9\.9\.9\.1", \{"#));
	assert!(is_match(&lua, r"\[100\] = \{ 256, 256, -- Greenvale \(10\)\n\t\t\{ 600, 300, 10, 20, 1001, 1002, 1003, 1004, 1005, 1006 \},"));
	let dir = TempDir::new("polestar-overlays-");
	let file = dir.path().join("ZoneArtOverlays.lua");
	std::fs::write(&file, &lua).unwrap();
	let script = r#"uistub.install()
			local ZA = Polestar.UI.ZoneArt
			assert(loadfile(FILE))("Polestar", { UI = Polestar.UI })
			emit({ ZA.overlaysBuild, ZA.overlays[100], ZA.overlays[101][2] })"#
		.replace("FILE", &lua_string(file.to_str().unwrap()));
	let out = emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"])], script, ..Default::default() }).remove(0);
	assert_eq!(out[0], "9.9.9.1");
	assert_eq!(out[1], json!([256, 256, [600, 300, 10, 20, 1001, 1002, 1003, 1004, 1005, 1006], [128, 128, 400, 400, 2001]]));
	assert_eq!(out[2], 512);
}

#[test]
fn tables_come_from_the_source_cache_fetched_once_when_missing_offline_never_fetches() {
	let dir = TempDir::new("polestar-wago-");
	assert_eq!(OVERLAY_TABLES.len(), 6);
	let e = overlay_tables(dir.path(), "1.2.3.4", true, &|_| {}).unwrap_err();
	assert!(is_match(&e, r"--offline: missing cached"));
	let left = std::fs::read_dir(dir.path()).unwrap().count();
	assert_eq!(left, 0, "offline: nothing fetched");
}
