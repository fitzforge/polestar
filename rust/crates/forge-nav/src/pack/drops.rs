//! Ledge drops (maps format 5): the falls our navigation grid knows from a ledge to ground DROP_MIN to DROP_MAX yards
//! below (DROP_MAX is the height a fall starts to hurt), landing in the ledge's cell or one beside it, become one-way
//! arcs between Leffe's surfaces there, so a walk takes the short way down a ledge instead of going round to a ramp.
//! His maps carry few drops of their own (about 3,200 on Eastern Kingdoms): his drops are motion between the surfaces
//! his builder joined, where a ledge's two sides are usually not joined at all.
//!
//! Ported from Shortest Path Forever v1.33.0 by Cillian Berragan (github.com/cjber/shortest-path-forever,
//! GPL-3.0-or-later, used with his permission): its v1.31 rule (tools/baker, gen_nav.py: a landing between 2.0 and
//! 14.57 yards below a ledge is a one-way link, never climbed, its fall costing the time free fall takes at the
//! client's gravity, run at 7 yd/s), here on our grid's falls, whose fall column and path the grid builder already
//! checked for walls and shelves, instead of his navmesh's off-mesh connections.
//! Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-11-13.
//!
//! A grid fall is from one of our column's surfaces to a surface of a column up to 12 columns away (grid.rs
//! FALL_SLIDE). Only those landing in the ledge's 4.17-yd cell or one beside it count, inside one map tile (a
//! cluster: the arc field joins surfaces of one cluster), each kept once per pair of cells and heights (the shortest).
//! On his maps a drop stands on his surface in each cell nearest the grid's height within MATCH_YD; one his maps
//! already walk (an open step or a link between the two surfaces) adds nothing.

use crate::f4::pack::Cluster;
use crate::grid::{Tile, FALL_SLIDE, FALL_SPAN, SAFE_FALL, TILE_CELLS};
use rustc_hash::FxHashMap;

/// A fall shorter than this is a step (the player's step reaches 2 yd).
pub const DROP_MIN: f64 = 2.0;
/// The longest fall that does not hurt (grid.rs SAFE_FALL).
pub const DROP_MAX: f64 = SAFE_FALL;
/// The client's gravity (yd/s^2) and the run speed (yd/s) a fall's time is priced at.
pub const GRAVITY: f64 = 19.2911;
pub const RUN: f64 = 7.0;
/// A drop's end stands on his surface in its cell within this of the grid's height (his base heights are stored to
/// 2 yd, his floors to 1 yd).
pub const MATCH_YD: f64 = 3.5;
/// A grid column's side (yd).
const COLUMN: f64 = crate::grid::CELL;

/// A fall of our grid inside one cluster: its ledge's and its landing's local cells (128-cell clusters: x * c + y),
/// their heights, and the yards between the two columns.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct GridDrop {
	pub from: u16,
	pub z1: f32,
	pub to: u16,
	pub z2: f32,
	pub h: f32,
}

/// A drop's walk in yards: across, then the free fall's time at run speed.
pub fn drop_yards(h: f64, fall: f64) -> f64 {
	h + RUN * (2.0 * fall.max(0.0) / GRAVITY).sqrt()
}

/// The local cell (of `cells` per side) of column (i, j) of a tile (cells.rs cell_grid's lx and ly).
fn cell_of(i: usize, j: usize, cells: usize) -> usize {
	let tc = TILE_CELLS;
	let lx = ((((tc - 1 - j) as f64) + 0.5) * cells as f64 / tc as f64).floor() as usize;
	let ly = ((((tc - 1 - i) as f64) + 0.5) * cells as f64 / tc as f64).floor() as usize;
	lx * cells + ly
}

/// The ledge drops of one tile of our grid, at `cells` cells per tile side.
pub fn tile_drops(t: &Tile, cells: usize) -> Vec<GridDrop> {
	let tc = TILE_CELLS;
	let at = t.fall_at();
	let mut best: FxHashMap<(u16, i32, u16, i32), GridDrop> = FxHashMap::default();
	for k in 0..tc * tc {
		let (i, j) = (k & 255, k >> 8);
		let lc1 = cell_of(i, j, cells);
		for e in t.first[k] as usize..t.first[k + 1] as usize {
			let z1 = t.z[e] as f64;
			for f in at[e] as usize..at[e + 1] as usize {
				let off = (t.fall_to[f] >> 5) as i32;
				let ni = i as i32 + off.div_euclid(FALL_SPAN) - FALL_SLIDE;
				let nj = j as i32 + off.rem_euclid(FALL_SPAN) - FALL_SLIDE;
				if ni < 0 || nj < 0 || ni >= tc as i32 || nj >= tc as i32 {
					continue;
				}
				let (ni, nj) = (ni as usize, nj as usize);
				let land = t.first[nj * tc + ni] as usize + (t.fall_to[f] & 31) as usize;
				if land >= t.z.len() {
					continue;
				}
				let z2 = t.z[land] as f64;
				let fall = z1 - z2;
				if !(DROP_MIN..=DROP_MAX).contains(&fall) {
					continue;
				}
				let lc2 = cell_of(ni, nj, cells);
				let (x1, y1, x2, y2) = (lc1 / cells, lc1 % cells, lc2 / cells, lc2 % cells);
				if x1.abs_diff(x2) > 1 || y1.abs_diff(y2) > 1 {
					continue;
				}
				let h = ((ni as f64 - i as f64).powi(2) + (nj as f64 - j as f64).powi(2)).sqrt() * COLUMN;
				let d = GridDrop { from: lc1 as u16, z1: z1 as f32, to: lc2 as u16, z2: z2 as f32, h: h as f32 };
				let key = (d.from, z1.round() as i32, d.to, z2.round() as i32);
				let e = best.entry(key).or_insert(d);
				if d.h < e.h {
					*e = d;
				}
			}
		}
	}
	let mut out: Vec<GridDrop> = best.into_values().collect();
	out.sort_by(|a, b| (a.from, a.to).cmp(&(b.from, b.to)).then(a.z1.total_cmp(&b.z1)).then(a.z2.total_cmp(&b.z2)));
	out
}

/// His surface in local cell lc nearest height z within MATCH_YD (the base first on a tie).
pub(super) fn surface_near(c: &Cluster, lc: usize, z: f64) -> Option<usize> {
	let mut best: Option<(f64, usize)> = None;
	if c.val[lc] != 0 {
		let d = (c.z[lc] as f64 - z).abs();
		if d <= MATCH_YD {
			best = Some((d, lc));
		}
	}
	let mut f = c.first_floor[lc];
	while f >= 0 && (f as usize) < c.n0 && c.at_cell[f as usize] as usize == lc {
		let d = (c.z[f as usize] as f64 - z).abs();
		if d <= MATCH_YD && best.is_none_or(|b| d < b.0) {
			best = Some((d, f as usize));
		}
		f += 1;
	}
	best.map(|b| b.1)
}

/// Whether base cells a and b (neighbours) have an open step between them (the decoded moves: 1 +x, 2 +y, 4 +x+y,
/// 8 +x-y, kept on the lower-x cell).
fn step_open(c: &Cluster, cc: usize, a: usize, b: usize) -> bool {
	let (ax, ay, bx, by) = ((a / cc) as i64, (a % cc) as i64, (b / cc) as i64, (b % cc) as i64);
	let (lo, dx, dy) = if ax < bx || (ax == bx && ay < by) { (a, bx - ax, by - ay) } else { (b, ax - bx, ay - by) };
	let m = c.moves[lo];
	match (dx, dy) {
		(1, 0) => m & 1 != 0,
		(0, 1) => m & 2 != 0,
		(1, 1) => m & 4 != 0,
		(1, -1) => m & 8 != 0,
		_ => false,
	}
}

/// The drops of `drops` (one cluster's) as arcs between his surfaces: (from surface, to surface, yards), once per
/// pair (the cheapest), none where his maps already walk between the two (`links`: his direct links, from walks()).
pub fn drop_arcs(c: &Cluster, cc: usize, drops: &[GridDrop], links: &rustc_hash::FxHashSet<(u32, u32)>) -> Vec<(usize, usize, f64)> {
	let n2 = cc * cc;
	let mut best: FxHashMap<(usize, usize), f64> = FxHashMap::default();
	for d in drops {
		let (Some(a), Some(b)) = (surface_near(c, d.from as usize, d.z1 as f64), surface_near(c, d.to as usize, d.z2 as f64)) else { continue };
		if a == b || links.contains(&(a as u32, b as u32)) || (a < n2 && b < n2 && a != b && step_open(c, cc, a, b)) {
			continue;
		}
		let fall = c.z[a] as f64 - c.z[b] as f64;
		if fall <= 0.0 {
			continue;
		}
		let y = drop_yards(d.h as f64, fall);
		let e = best.entry((a, b)).or_insert(y);
		if y < *e {
			*e = y;
		}
	}
	let mut out: Vec<(usize, usize, f64)> = best.into_iter().map(|((a, b), y)| (a, b, y)).collect();
	out.sort_by(|x, y| (x.0, x.1).cmp(&(y.0, y.1)));
	out
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn a_drop_costs_its_walk_across_and_the_time_free_fall_takes() {
		assert!((drop_yards(0.0, 14.57) - 7.0 * (2.0 * 14.57 / 19.2911f64).sqrt()).abs() < 1e-9, "SPF's drop_cost(0, 14.57)");
		assert!(drop_yards(0.0, 14.57) > drop_yards(0.0, 10.0));
		assert!((drop_yards(4.0, 0.0) - 4.0).abs() < 1e-9);
	}

	#[test]
	fn a_column_lies_in_the_cell_cells_rs_puts_it_in() {
		// 256 columns into 128 cells: two columns a cell, rows and columns reversed (cells.rs lx, ly).
		assert_eq!(cell_of(255, 255, 128), 0);
		assert_eq!(cell_of(254, 254, 128), 0);
		assert_eq!(cell_of(253, 255, 128), 1);
		assert_eq!(cell_of(255, 253, 128), 128);
		assert_eq!(cell_of(0, 0, 128), 127 * 128 + 127);
	}

	#[test]
	fn the_open_steps_of_a_cell_pair_read_from_the_lower_cell() {
		let cc = 4;
		let mut c = Cluster { n0: 16, val: vec![1; 16], z: vec![0.0; 16], moves: vec![0; 16], first_floor: vec![-1; 16], at_cell: vec![-1; 16], ..Default::default() };
		c.moves[5] = 1 | 8; // 5 -> 9 (+x) and 5 -> 8 (+x -y)
		assert!(step_open(&c, cc, 5, 9) && step_open(&c, cc, 9, 5));
		assert!(step_open(&c, cc, 8, 5) && step_open(&c, cc, 5, 8));
		assert!(!step_open(&c, cc, 5, 6) && !step_open(&c, cc, 5, 10));
	}

	#[test]
	fn a_drop_lands_on_his_nearest_surface_and_is_left_out_where_he_already_walks_it() {
		let cc = 4;
		// Cell 5 a ledge at 20, cell 9 ground at 10 and a floor of 9 at 19.5 (a balcony beside the ledge).
		let mut c = Cluster { n0: 17, val: vec![1; 17], z: vec![0.0; 17], moves: vec![0; 16], first_floor: vec![-1; 16], at_cell: vec![-1; 17], ..Default::default() };
		c.z[5] = 20.0;
		c.z[9] = 10.0;
		c.z[16] = 19.5;
		c.first_floor[9] = 16;
		c.at_cell[16] = 9;
		let drop = GridDrop { from: 5, z1: 20.2, to: 9, z2: 10.4, h: 4.2 };
		let none = rustc_hash::FxHashSet::default();
		let arcs = drop_arcs(&c, cc, &[drop], &none);
		assert_eq!(arcs.len(), 1);
		assert_eq!((arcs[0].0, arcs[0].1), (5, 9), "from the ledge to the ground, not to the balcony");
		assert!((arcs[0].2 - drop_yards(4.2, 10.0)).abs() < 1e-6);
		let walked: rustc_hash::FxHashSet<(u32, u32)> = [(5u32, 9u32)].into_iter().collect();
		assert!(drop_arcs(&c, cc, &[drop], &walked).is_empty(), "a link his maps have already walks it");
		c.moves[5] = 1;
		assert!(drop_arcs(&c, cc, &[drop], &none).is_empty(), "so does an open step");
	}
}
