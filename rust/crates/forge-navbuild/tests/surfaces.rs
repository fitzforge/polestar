//! rasterise + build_surfaces on the JS tileGeometry-shaped geometry of every golden tile (terrain,
//! models, indoor floors, MH2O and WMO liquids, a reviewed opening): the walls and surfaces files equal
//! the JS worker's surfaces op byte for byte (rust/tests/golden/nav-grid).
mod common;
use forge_navbuild::format::{encode_tile, encode_walls};

#[test]
fn surfaces_equal_the_js() {
	let src = common::src();
	let tiles = src.tiles_listed();
	let mut bad = Vec::new();
	for &(col, row) in &tiles {
		let g = src.read_geom(col, row);
		let hf = forge_navbuild::rasterise::rasterise(&g);
		let (tile, _) = forge_navbuild::surfaces::build_surfaces(hf, &g);
		let walls = std::fs::read(src.surf.join(format!("{col}_{row}.walls.gz"))).unwrap();
		let surf = std::fs::read(src.surf.join(format!("{col}_{row}.surf.gz"))).unwrap();
		if encode_walls(tile.walls.as_ref().unwrap()) != walls {
			bad.push(format!("{col}_{row} walls"));
		}
		if encode_tile(&tile).unwrap() != surf {
			bad.push(format!("{col}_{row} surf"));
		}
	}
	assert!(bad.is_empty(), "{} tiles, differ: {bad:?}", tiles.len());
}
