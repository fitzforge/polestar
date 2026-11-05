//! Heights from the walking grid for the world builder (port of tools/lib/sim/world.js gridFloor's
//! `surfaces`): the column path.js snap takes for a point without a height (its floor rule, then the
//! lowest indoor floor / the top surface under the open sky / the terrain's top), and that column's open surfaces in a region of at least
//! SNAP_REGION, ascending: `[snap's z, ...storeys]`, or none when nothing is within snap's reach.
//! Implements forge-world's `Floors`, so a world builds with no JS `floors.json`.

use crate::grid::{flag, Grid, TILE_CELLS};
use crate::legs::{is_open, Nav, SnapAsk, SNAP_OPEN, SNAP_REGION};
use parking_lot::Mutex;
use rustc_hash::FxHashMap;
use std::sync::Arc;

pub struct GridFloors {
	nav: Nav,
	memo: Mutex<FxHashMap<(i64, u64, u64), Vec<f64>>>,
}

impl GridFloors {
	pub fn new(grid: Arc<Grid>) -> GridFloors {
		GridFloors { nav: Nav::new(grid), memo: Mutex::new(FxHashMap::default()) }
	}

	/// gridFloor's surfaces: `[]` when snap finds no surface.
	pub fn surfaces_at(&self, c: i64, wx: f64, wy: f64) -> Vec<f64> {
		let key = (c, wx.to_bits(), wy.to_bits());
		if let Some(v) = self.memo.lock().get(&key) {
			return v.clone();
		}
		let v = self.compute(c, wx, wy);
		self.memo.lock().insert(key, v.clone());
		v
	}

	fn compute(&self, c: i64, wx: f64, wy: f64) -> Vec<f64> {
		let Some(s) = self.nav.snap(&SnapAsk { c: c as u32, wx, wy, z: None, radius: 20.0, under: false, stand: false }) else { return Vec::new() };
		let grid = &self.nav.grid;
		let Some(t) = grid.tile(s.c, s.col as i64, s.row as i64) else { return Vec::new() };
		let k = s.j as usize * TILE_CELLS + s.i as usize;
		let mut open = Vec::new();
		for e in t.first[k] as usize..t.first[k + 1] as usize {
			if t.flags[e] & flag::BLOCKED != 0 || !self.open(&t, k, e) {
				continue;
			}
			let size = grid.region_size(s.c, s.col, s.row, e as u32);
			if size.is_none_or(|n| n >= SNAP_REGION) {
				open.push(t.z[e] as f64);
			}
		}
		open.sort_by(|a, b| a.partial_cmp(b).unwrap());
		let mut v = vec![s.z];
		v.extend(open);
		v
	}

	fn open(&self, t: &crate::grid::Tile, k: usize, e: usize) -> bool {
		if let Some(&v) = t.open.lock().get(&(e as u32)) {
			return v;
		}
		let v = is_open(t, k, e, SNAP_OPEN);
		t.open.lock().insert(e as u32, v);
		v
	}

	pub fn places(&self) -> usize {
		self.memo.lock().len()
	}
}

#[cfg(feature = "world")]
impl forge_world::Floors for GridFloors {
	fn surfaces(&self, c: i64, wx: f64, wy: f64) -> Option<Vec<f64>> {
		Some(self.surfaces_at(c, wx, wy))
	}
}
