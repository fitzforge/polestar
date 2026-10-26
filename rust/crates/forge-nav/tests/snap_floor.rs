//! The floor a place without a height is put on (Nav::snap, z None), on the committed synthetic
//! grid (rust/tests/golden/nav-grid): outdoors, the surface under the open sky, not the terrain a
//! model stands over (a city's streets over the ground they were built on).
mod common;

use forge_nav::grid::Grid;
use forge_nav::legs::{Nav, SnapAsk};
use std::sync::Arc;

#[test]
fn a_heightless_place_over_a_model_deck_stands_on_the_deck_not_the_terrain_under_it() {
	let grid = Arc::new(Grid::open(&common::golden_dir().join("nav-grid/nav4"), 16).unwrap());
	let nav = Nav::new(grid);
	let ask = |wx: f64, wy: f64| nav.snap(&SnapAsk { c: 0, wx, wy, z: None, radius: 20.0, under: true, stand: true }).map(|s| s.z);
	// The mesa's flat model top (z 60, open sky) over the scene's terrain (z 0, 60 yd below).
	assert_eq!(ask(-301.04, -59.38), Some(60.0));
	// Plain terrain, nothing above: the terrain.
	let open = ask(-301.04, -40.0).unwrap();
	assert!(open.abs() < 1.0, "open ground snaps to the terrain, got {open}");
}
