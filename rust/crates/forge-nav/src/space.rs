//! A search over several tiles (port of grid/search.js Space and path.js Nav.search, cellYards):
//! the bounded A* that joins two abstract nodes into a cell path (path.js piece), for yards and
//! zone cells where no prepareYards edge yards exist.

use crate::cost::{fall_seconds, lift_seconds, Profile, ROAD};
use crate::grid::{flag, Grid, Tile, CELL, DIRS, FALL_SLIDE, FALL_SPAN, NO_LINK, TILE_CELLS};
use crate::legs::{Cells, MinHeap, Snapped};
use forge_core::jsnum::js_hypot_n;
use rustc_hash::FxHashMap;
use std::sync::Arc;

const DIAG: f64 = CELL * std::f64::consts::SQRT_2;
const OCT: f64 = std::f64::consts::SQRT_2 - 1.0;
/// path.js PIECE_WEIGHT.
pub const PIECE_WEIGHT: f64 = 1.05;
/// edgecost.js MIN_MULT.
pub const MIN_MULT: f64 = if ROAD < 1.0 { ROAD } else { 1.0 };

pub struct Space<'g> {
	grid: &'g Grid,
	c: u32,
	allow: Vec<(u32, u32)>,
	pub tiles: Vec<Arc<Tile>>,
	danger: Vec<Option<Arc<Vec<f32>>>>,
	pub base: Vec<usize>,
	slots: FxHashMap<(u32, u32), i32>,
	nb: Vec<i32>,
}

pub struct Out {
	pub to: usize,
	pub slot: usize,
	pub k: usize,
	pub cost: f64,
	pub d: f64,
	/// The step's segment class (grid::cls, move.js segmentClass).
	pub cls: u8,
}

impl<'g> Space<'g> {
	pub fn new(grid: &'g Grid, c: u32, allow: Vec<(u32, u32)>) -> Self {
		Space { grid, c, allow, tiles: Vec::new(), danger: Vec::new(), base: vec![0], slots: FxHashMap::default(), nb: Vec::new() }
	}

	pub fn size(&self) -> usize {
		*self.base.last().unwrap()
	}

	fn add(&mut self, t: Arc<Tile>, p: &Profile) -> usize {
		let s = self.tiles.len();
		self.base.push(self.base[s] + t.n);
		self.slots.insert((t.col, t.row), s as i32);
		for x in 0..9 {
			self.nb.push(if x == 4 { s as i32 } else { -2 });
		}
		self.danger.push(p.area.as_ref().and_then(|a| a.tile_danger(&t)));
		self.tiles.push(t);
		s
	}

	pub fn slot(&mut self, col: i64, row: i64, p: &Profile) -> i32 {
		if col < 0 || row < 0 {
			return -1;
		}
		let key = (col as u32, row as u32);
		if let Some(&s) = self.slots.get(&key) {
			return s;
		}
		let t = if self.allow.contains(&key) { self.grid.tile(self.c, col, row) } else { None };
		match t {
			Some(t) => self.add(t, p) as i32,
			None => {
				self.slots.insert(key, -1);
				-1
			}
		}
	}

	/// The slot and column of (i, j) relative to slot.
	fn col(&mut self, slot: usize, i: i32, j: i32, p: &Profile) -> Option<(usize, usize)> {
		let dc = if i < 0 {
			-1
		} else if i >= TILE_CELLS as i32 {
			1
		} else {
			0
		};
		let dr = if j < 0 {
			-1
		} else if j >= TILE_CELLS as i32 {
			1
		} else {
			0
		};
		let mut s = slot as i32;
		if dc != 0 || dr != 0 {
			let x = slot * 9 + ((dr + 1) * 3 + (dc + 1)) as usize;
			s = self.nb[x];
			if s == -2 {
				let (tc, tr) = (self.tiles[slot].col as i64, self.tiles[slot].row as i64);
				s = self.slot(tc + dc as i64, tr + dr as i64, p);
				self.nb[x] = s;
			}
		}
		if s < 0 {
			return None;
		}
		Some((s as usize, ((j - dr * TILE_CELLS as i32) * TILE_CELLS as i32 + (i - dc * TILE_CELLS as i32)) as usize))
	}

	fn area_at(&self, p: &Profile, s: usize, k: usize, flags: u8) -> f64 {
		let m = p.ground_mult(&self.tiles[s], k, flags);
		match &self.danger[s] {
			Some(g) => m * g[((k >> 12) << 4) + ((k & 255) >> 4)] as f64,
			None => m,
		}
	}

	/// grid/search.js Space.expand.
	pub fn expand(&mut self, slot: usize, e: usize, k: usize, p: &Profile, out: &mut Vec<Out>) {
		out.clear();
		let t = self.tiles[slot].clone();
		let i = (k & 255) as i32;
		let j = (k >> 8) as i32;
		let fa = t.flags[e];
		let za = t.z[e] as f64;
		for d in 0..8 {
			let b = t.links[e * 8 + d];
			if b == NO_LINK {
				continue;
			}
			let Some((s2, k2)) = self.col(slot, i + DIRS[d].0, j + DIRS[d].1, p) else { continue };
			let t2 = self.tiles[s2].clone();
			let v = t2.first[k2] as usize + (b & 31) as usize;
			let cls = b >> 5;
			let dz = t2.z[v] as f64 - za;
			let h = if d & 1 == 1 { DIAG } else { CELL };
			let dist = (h * h + dz * dz).sqrt();
			let fb = t2.flags[v];
			out.push(Out { to: self.base[s2] + v, slot: s2, k: k2, cost: p.link_seconds(cls, fa, fb, dist) * self.area_at(p, s2, k2, fb), d: dist, cls: crate::cost::segment_class(cls, fa, fb) });
		}
		if let Some(rides) = t.lifts.as_ref().and_then(|l| l.get(&(e as u32))) {
			for r in rides {
				let s2 = if r.col == t.col && r.row == t.row { slot as i32 } else { self.slot(r.col as i64, r.row as i64, p) };
				if s2 < 0 {
					continue;
				}
				let s2 = s2 as usize;
				let fl = self.tiles[s2].flags[r.entry as usize];
				out.push(Out {
					to: self.base[s2] + r.entry as usize,
					slot: s2,
					k: r.k as usize,
					cost: lift_seconds(r.h) * self.area_at(p, s2, r.k as usize, fl),
					d: r.h.abs(),
					cls: crate::grid::cls::LIFT,
				});
			}
		}
		if fa & flag::SWIM != 0 || t.fall_from.is_empty() {
			return;
		}
		let at = t.fall_at();
		for f in at[e] as usize..at[e + 1] as usize {
			let code = t.fall_to[f];
			let off = (code >> 5) as i32;
			let di = off.div_euclid(FALL_SPAN) - FALL_SLIDE;
			let dj = off.rem_euclid(FALL_SPAN) - FALL_SLIDE;
			let Some((s2, k2)) = self.col(slot, i + di, j + dj, p) else { continue };
			let t2 = self.tiles[s2].clone();
			let v = t2.first[k2] as usize + (code & 31) as usize;
			let hgt = za - t2.z[v] as f64;
			let hor = ((di * di + dj * dj) as f64).sqrt() * CELL;
			let fb = t2.flags[v];
			out.push(Out {
				to: self.base[s2] + v,
				slot: s2,
				k: k2,
				cost: fall_seconds(hgt, fb & flag::SWIM != 0) * self.area_at(p, s2, k2, fb),
				d: (hor * hor + hgt * hgt).sqrt(),
				cls: crate::grid::cls::FALL,
			});
		}
	}
}

/// A search's scratch (path.js Nav.grow's).
#[derive(Default)]
pub struct AStar {
	g: Vec<f64>,
	parent: Vec<i32>,
	k: Vec<i32>,
	slot: Vec<i32>,
	/// The class of the step into each entry (its parent's step).
	cls: Vec<u8>,
	stamp: Vec<u32>,
	closed: Vec<u32>,
	gen: u32,
	heap: MinHeap,
	out: Vec<Out>,
}

impl AStar {
	fn grow(&mut self, size: usize) {
		if self.g.len() >= size {
			return;
		}
		let cap = size.max((self.g.len() as f64 * 1.5).ceil() as usize).max(1 << 18);
		self.g.resize(cap, 0.0);
		self.parent.resize(cap, 0);
		self.k.resize(cap, 0);
		self.slot.resize(cap, 0);
		self.cls.resize(cap, 0);
		self.stamp.resize(cap, 0);
		self.closed.resize(cap, 0);
	}
}

/// The cell path's 3D yards and zone cells (path.js cellYards) of an A* from A to B over the
/// tiles of A and B (path.js search with PIECE_WEIGHT, as piece asks it), or None.
pub fn piece_path(grid: &Grid, a: &Snapped, b: &Snapped, p: &Profile, sc: &mut AStar, cells: bool) -> Option<(f64, Cells)> {
	let (space, nodes) = piece_search(grid, a, b, p, sc)?;
	// cellYards.
	let mut yards = 0.0;
	let mut acc = Cells::default();
	let pos = |x: usize| {
		let s = sc.slot[x] as usize;
		let t = &space.tiles[s];
		let k = sc.k[x] as usize;
		(t.wx(k), t.wy(k), t.z[x - space.base[s]] as f64)
	};
	let (mut qx, mut qy, mut qz) = pos(nodes[0]);
	for &x in &nodes[1..] {
		let (rx, ry, rz) = pos(x);
		let d = js_hypot_n(&[rx - qx, ry - qy, rz - qz]);
		yards += d;
		if cells {
			acc.add(forge_core::cells::cell_key(rx, ry) as u32, d);
		}
		(qx, qy, qz) = (rx, ry, rz);
	}
	Some((yards, acc))
}

/// A cell of a drawn way: its centre and surface height, the floor (the surface's index in its
/// column, 0 the lowest), and the class of the step into it (the first cell's: 0).
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct WayCell {
	pub x: f64,
	pub y: f64,
	pub z: f64,
	pub floor: u8,
	pub cls: u8,
}

/// piece_path's A* as cells (the bake's drawn way between two snapped points), or None.
pub fn piece_cells(grid: &Grid, a: &Snapped, b: &Snapped, p: &Profile, sc: &mut AStar) -> Option<Vec<WayCell>> {
	let (space, nodes) = piece_search(grid, a, b, p, sc)?;
	Some(
		nodes
			.iter()
			.enumerate()
			.map(|(n, &x)| {
				let s = sc.slot[x] as usize;
				let t = &space.tiles[s];
				let k = sc.k[x] as usize;
				let e = x - space.base[s];
				WayCell { x: t.wx(k), y: t.wy(k), z: t.z[e] as f64, floor: (e - t.first[k] as usize).min(255) as u8, cls: if n == 0 { 0 } else { sc.cls[x] } }
			})
			.collect(),
	)
}

/// The A* from A to B over their tiles: the space and the entries of the way, A first.
fn piece_search<'g>(grid: &'g Grid, a: &Snapped, b: &Snapped, p: &Profile, sc: &mut AStar) -> Option<(Space<'g>, Vec<usize>)> {
	let mut space = Space::new(grid, a.c, vec![(a.col, a.row), (b.col, b.row)]);
	let sa = space.slot(a.col as i64, a.row as i64, p);
	let sb = space.slot(b.col as i64, b.row as i64, p);
	if sa < 0 || sb < 0 {
		return None;
	}
	let (sa, sb) = (sa as usize, sb as usize);
	sc.grow(space.size());
	sc.gen = sc.gen.wrapping_add(1);
	if sc.gen == u32::MAX {
		sc.stamp.fill(0);
		sc.closed.fill(0);
		sc.gen = 1;
	}
	let gen = sc.gen;
	let s0 = space.base[sa] + a.entry as usize;
	let g0 = space.base[sb] + b.entry as usize;
	let max_speed = p.outdoor.max(p.indoor).max(p.swim);
	let scale = ((CELL * MIN_MULT) / max_speed) * PIECE_WEIGHT;
	let bi = b.col as i64 * TILE_CELLS as i64 + b.i as i64;
	let bj = b.row as i64 * TILE_CELLS as i64 + b.j as i64;
	let h_of = |space: &Space, slot: usize, k: usize| {
		let t = &space.tiles[slot];
		let dx = (t.col as i64 * TILE_CELLS as i64 + (k & 255) as i64 - bi).abs() as f64;
		let dy = (t.row as i64 * TILE_CELLS as i64 + (k >> 8) as i64 - bj).abs() as f64;
		(if dx > dy { dx + OCT * dy } else { dy + OCT * dx }) * scale
	};
	sc.heap.clear();
	sc.stamp[s0] = gen;
	sc.g[s0] = 0.0;
	sc.parent[s0] = -1;
	sc.k[s0] = a.k() as i32;
	sc.slot[s0] = sa as i32;
	sc.cls[s0] = 0;
	sc.heap.push(h_of(&space, sa, a.k()), s0 as i32);
	let mut found = false;
	let mut out = std::mem::take(&mut sc.out);
	while !sc.heap.is_empty() {
		let u = sc.heap.pop() as usize;
		if u == g0 {
			found = true;
			break;
		}
		let slot = sc.slot[u] as usize;
		let e = u - space.base[slot];
		let gu = sc.g[u];
		let ku = sc.k[u] as usize;
		if sc.closed[u] == gen {
			continue;
		}
		sc.closed[u] = gen;
		space.expand(slot, e, ku, p, &mut out);
		sc.grow(space.size());
		for o in &out {
			let v = o.to;
			let nd = gu + o.cost;
			if sc.closed[v] != gen && (sc.stamp[v] != gen || nd < sc.g[v]) {
				sc.stamp[v] = gen;
				sc.g[v] = nd;
				sc.parent[v] = u as i32;
				sc.k[v] = o.k as i32;
				sc.slot[v] = o.slot as i32;
				sc.cls[v] = o.cls;
				sc.heap.push(nd + h_of(&space, o.slot, o.k), v as i32);
			}
		}
	}
	sc.out = out;
	if !found {
		return None;
	}
	let mut nodes = Vec::new();
	let mut u = g0 as i32;
	while u != -1 {
		nodes.push(u as usize);
		u = sc.parent[u as usize];
	}
	nodes.reverse();
	Some((space, nodes))
}
