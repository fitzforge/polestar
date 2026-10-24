//! Legs: a place's way into its tile's abstract nodes and back (port of tools/lib/nav/path.js
//! snap, isOpen, tileTree, treeCells, goalLegs, settleCandidates, and cch.js startLegs/startOf;
//! grid/search.js MinHeap, Space.expand inside one tile, inLinks, fallsInto, isOpen).
//!
//! A start's legs: its tile searched forward from it (every entry's seconds and yards); its seeds
//! are the tile's graph nodes reached. A goal's legs: its tile searched backward to it (inLinks: no
//! lifts). A place in a pocket that reaches none of its tile's nodes takes the first surface near
//! it that does (settleCandidates). Zone cells: each step's yards in the 200 yd cell of the
//! column it enters (router.js cellKey).

use crate::cost::{fall_seconds, lift_seconds, Profile, TileCost, SETTLE_DROP, SETTLE_RADIUS, SETTLE_RISE, SETTLE_TRIES};
use crate::grid::{cell_centre, cell_of, flag, Graph, Grid, Tile, AGENT_HEIGHT, CELL, DIRS, FALL_SLIDE, FALL_SPAN, NO_LINK, STEP, TILE_CELLS, WALK_MAX};
use forge_core::jsnum::js_hypot;
use std::sync::Arc;

pub const SNAP_REGION: u32 = 1000;
pub const SNAP_OPEN: usize = 400;
pub const UNDER_SLACK: f64 = 2.0;
pub const UNDER_WEIGHT: f64 = 5.0;
pub const STAND_DZ: f64 = 10.0;
pub const STAND_RADIUS: f64 = 36.0;
const DIAG: f64 = CELL * std::f64::consts::SQRT_2;

/// Zone cells in insertion order (a JS Map's): [(key, yards)].
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Cells(pub Vec<(u32, f64)>);
impl Cells {
	pub fn add(&mut self, k: u32, y: f64) {
		match self.0.iter_mut().find(|x| x.0 == k) {
			Some(x) => x.1 += y,
			None => self.0.push((k, y)),
		}
	}
	pub fn add_all(&mut self, o: &Cells) {
		for &(k, y) in &o.0 {
			self.add(k, y);
		}
	}
}

/// grid/search.js MinHeap (same sift order: ties pop as the JS heap pops them).
#[derive(Default)]
pub struct MinHeap {
	keys: Vec<f64>,
	vals: Vec<i32>,
	pub top: f64,
}
impl MinHeap {
	pub fn len(&self) -> usize {
		self.keys.len()
	}
	pub fn is_empty(&self) -> bool {
		self.keys.is_empty()
	}
	pub fn clear(&mut self) {
		self.keys.clear();
		self.vals.clear();
	}
	pub fn push(&mut self, key: f64, val: i32) {
		let mut i = self.keys.len();
		self.keys.push(key);
		self.vals.push(val);
		while i > 0 {
			let p = (i - 1) >> 1;
			if self.keys[p] <= key {
				break;
			}
			self.keys[i] = self.keys[p];
			self.vals[i] = self.vals[p];
			i = p;
		}
		self.keys[i] = key;
		self.vals[i] = val;
	}
	pub fn pop(&mut self) -> i32 {
		let val = self.vals[0];
		self.top = self.keys[0];
		let n = self.keys.len() - 1;
		let key = self.keys[n];
		let v = self.vals[n];
		self.keys.pop();
		self.vals.pop();
		if n > 0 {
			let mut i = 0;
			loop {
				let mut c = 2 * i + 1;
				if c >= n {
					break;
				}
				if c + 1 < n && self.keys[c + 1] < self.keys[c] {
					c += 1;
				}
				if self.keys[c] >= key {
					break;
				}
				self.keys[i] = self.keys[c];
				self.vals[i] = self.vals[c];
				i = c;
			}
			self.keys[i] = key;
			self.vals[i] = v;
		}
		val
	}
}

/// A tile search's scratch (path.js tileTree's): valid where stamp == gen.
#[derive(Default)]
pub struct Tree {
	pub dist: Vec<f64>,
	pub yd: Vec<f64>,
	pub par: Vec<i32>,
	pub k_of: Vec<i32>,
	pub stamp: Vec<u32>,
	done: Vec<u32>,
	pub gen: u32,
	heap: MinHeap,
}
impl Tree {
	pub fn reached(&self, e: usize) -> bool {
		self.stamp[e] == self.gen
	}
}

/// An out- or in-link list (Space.expand's out arrays, search.js IN).
#[derive(Default)]
pub struct Links {
	pub to: Vec<u32>,
	pub k: Vec<u32>,
	pub cost: Vec<f64>,
	pub d: Vec<f64>,
}
impl Links {
	fn clear(&mut self) {
		self.to.clear();
		self.k.clear();
		self.cost.clear();
		self.d.clear();
	}
	fn add(&mut self, to: u32, k: u32, cost: f64, d: f64) {
		self.to.push(to);
		self.k.push(k);
		self.cost.push(cost);
		self.d.push(d);
	}
}

/// The column (i, j) of a tile, when inside it.
fn inside(i: i32, j: i32) -> Option<usize> {
	if i < 0 || j < 0 || i >= TILE_CELLS as i32 || j >= TILE_CELLS as i32 {
		None
	} else {
		Some(j as usize * TILE_CELLS + i as usize)
	}
}

/// Space.expand over one tile (a Space of [t] that loads nothing): the out-links of entry e
/// (column k) that stay in the tile.
pub fn expand(t: &Tile, e: usize, k: usize, tc: &TileCost, out: &mut Links) {
	let p = tc.p;
	out.clear();
	let i = (k & 255) as i32;
	let j = (k >> 8) as i32;
	let fa = t.flags[e];
	let za = t.z[e] as f64;
	for d in 0..8 {
		let b = t.links[e * 8 + d];
		if b == NO_LINK {
			continue;
		}
		let Some(k2) = inside(i + DIRS[d].0, j + DIRS[d].1) else { continue };
		let v = t.first[k2] as usize + (b & 31) as usize;
		let cls = b >> 5;
		let dz = t.z[v] as f64 - za;
		let h = if d & 1 == 1 { DIAG } else { CELL };
		let dist = (h * h + dz * dz).sqrt();
		let fb = t.flags[v];
		out.add(v as u32, k2 as u32, p.link_seconds(cls, fa, fb, dist) * tc.at(k2, fb), dist);
	}
	if let Some(rides) = t.lifts.as_ref().and_then(|l| l.get(&(e as u32))) {
		for r in rides {
			if r.col != t.col || r.row != t.row {
				continue;
			}
			out.add(r.entry, r.k, lift_seconds(r.h) * tc.at(r.k as usize, t.flags[r.entry as usize]), r.h.abs());
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
		let Some(k2) = inside(i + di, j + dj) else { continue };
		let v = t.first[k2] as usize + (code & 31) as usize;
		let hgt = za - t.z[v] as f64;
		let hor = ((di * di + dj * dj) as f64).sqrt() * CELL;
		let fb = t.flags[v];
		out.add(v as u32, k2 as u32, fall_seconds(hgt, fb & flag::SWIM != 0) * tc.at(k2, fb), (hor * hor + hgt * hgt).sqrt());
	}
}

/// search.js inLinks: in-links of entry u (column k) from inside its tile (lifts left out).
pub fn in_links(t: &Tile, u: usize, k: usize, tc: Option<&TileCost>, falls: bool, out: &mut Links) {
	let p = tc.map(|tc| tc.p);
	out.clear();
	let i = (k & 255) as i32;
	let j = (k >> 8) as i32;
	let layer = (u - t.first[k] as usize) as u8;
	let fb = t.flags[u];
	let am = tc.map(|tc| tc.at(k, fb)).unwrap_or(1.0);
	for d in 0..8 {
		let Some(ks) = inside(i - DIRS[d].0, j - DIRS[d].1) else { continue };
		for s in t.first[ks] as usize..t.first[ks + 1] as usize {
			let b = t.links[s * 8 + d];
			if b == NO_LINK || (b & 31) != layer {
				continue;
			}
			let h = if d & 1 == 1 { DIAG } else { CELL };
			let dz = t.z[u] as f64 - t.z[s] as f64;
			let dist = (h * h + dz * dz).sqrt();
			out.add(s as u32, ks as u32, p.map(|p| p.link_seconds(b >> 5, t.flags[s], fb, dist) * am).unwrap_or(0.0), dist);
		}
	}
	if !falls {
		return;
	}
	let fi = t.falls_into();
	for x in fi.at[u] as usize..fi.at[u + 1] as usize {
		let s = fi.from[x] as usize;
		let ks = fi.k[x] as usize;
		let hgt = t.z[s] as f64 - t.z[u] as f64;
		let hor = js_hypot((ks & 255) as f64 - i as f64, (ks >> 8) as f64 - j as f64) * CELL;
		out.add(s as u32, ks as u32, p.map(|_| fall_seconds(hgt, fb & flag::SWIM != 0) * am).unwrap_or(0.0), (hor * hor + hgt * hgt).sqrt());
	}
}

/// search.js isOpen.
pub fn is_open(t: &Tile, k: usize, e: usize, limit: usize) -> bool {
	let spread = |forward: bool| -> bool {
		let mut seen = rustc_hash::FxHashSet::default();
		seen.insert(e);
		let mut queue = vec![(e, k)];
		let mut links = Links::default();
		let mut q = 0;
		while q < queue.len() && seen.len() < limit {
			let (u, ku) = queue[q];
			q += 1;
			let i = (ku & 255) as i32;
			let j = (ku >> 8) as i32;
			for d in 0..8 {
				let b = t.links[u * 8 + d];
				if b == NO_LINK {
					continue;
				}
				let Some(kv) = inside(i + DIRS[d].0, j + DIRS[d].1) else { return true };
				if !forward {
					continue;
				}
				let v = t.first[kv] as usize + (b & 31) as usize;
				if seen.insert(v) {
					queue.push((v, kv));
				}
			}
			if forward {
				continue;
			}
			in_links(t, u, ku, None, false, &mut links);
			for x in 0..links.to.len() {
				let s = links.to[x] as usize;
				if seen.insert(s) {
					queue.push((s, links.k[x] as usize));
				}
			}
		}
		seen.len() >= limit
	};
	spread(true) && spread(false)
}

/// A snapped point (path.js snap's).
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Snapped {
	pub c: u32,
	pub wx: f64,
	pub wy: f64,
	pub z: f64,
	pub col: u32,
	pub row: u32,
	pub i: u32,
	pub j: u32,
	pub layer: u32,
	pub entry: u32,
	pub region: Option<u32>,
	pub flags: u8,
}
impl Snapped {
	pub fn k(&self) -> usize {
		self.j as usize * TILE_CELLS + self.i as usize
	}
	pub fn same_tile(&self, o: &Snapped) -> bool {
		self.col == o.col && self.row == o.row
	}
}

/// What a walk end asks of snap (router.js asPoint: under and stand for the router's ends).
#[derive(Clone, Copy, Debug)]
pub struct SnapAsk {
	pub c: u32,
	pub wx: f64,
	pub wy: f64,
	pub z: Option<f64>,
	pub radius: f64,
	pub under: bool,
	pub stand: bool,
}

struct SnapCell {
	col: i64,
	row: i64,
	i: i64,
	j: i64,
	dh: f64,
	wx: f64,
	wy: f64,
}

/// The legs of a place: its nodes (graph ids), their seconds and yards, and per node its cells.
#[derive(Clone, Debug, Default)]
pub struct Legs {
	pub nodes: Vec<u32>,
	pub sec: Vec<f64>,
	pub yd: Vec<f64>,
	pub cells: Option<Vec<Cells>>,
}

/// The fine-grid side of the router: snaps, tile searches, legs.
pub struct Nav {
	pub grid: Arc<Grid>,
}

impl Nav {
	pub fn new(grid: Arc<Grid>) -> Nav {
		Nav { grid }
	}

	fn is_open_cached(&self, t: &Tile, k: usize, e: usize) -> bool {
		if let Some(&v) = t.open.lock().get(&(e as u32)) {
			return v;
		}
		let v = is_open(t, k, e, SNAP_OPEN);
		t.open.lock().insert(e as u32, v);
		v
	}

	fn usable(&self, c: u32, t: &Tile, k: usize, cell: &SnapCell, e: usize, strict: bool) -> bool {
		if t.flags[e] & flag::BLOCKED != 0 {
			return false;
		}
		if !strict {
			return true;
		}
		let size = self.grid.region_size(c, cell.col as u32, cell.row as u32, e as u32);
		(size.is_none() || size.unwrap() >= SNAP_REGION) && self.is_open_cached(t, k, e)
	}

	fn make(&self, c: u32, t: &Tile, k: usize, cell: &SnapCell, e: usize) -> Snapped {
		Snapped {
			c,
			wx: cell.wx,
			wy: cell.wy,
			z: t.z[e] as f64,
			col: cell.col as u32,
			row: cell.row as u32,
			i: cell.i as u32,
			j: cell.j as u32,
			layer: (e - t.first[k] as usize) as u32,
			entry: e as u32,
			region: self.grid.region(c, cell.col as u32, cell.row as u32, e as u32),
			flags: t.flags[e],
		}
	}

	/// path.js Nav.snap (prefer 'any').
	pub fn snap(&self, q: &SnapAsk) -> Option<Snapped> {
		let SnapAsk { c, wx, wy, z, radius, under, stand } = *q;
		if !wx.is_finite() || !wy.is_finite() {
			return None;
		}
		let z = z.filter(|v| v.is_finite());
		let (acol, arow, ai, aj) = cell_of(wx, wy);
		let standing = stand && z.is_some();
		let reach = if standing { radius.max(STAND_RADIUS) } else { radius };
		let r = (reach / CELL).ceil() as i64;
		let mut cells = Vec::new();
		for dj in -r..=r {
			for di in -r..=r {
				let gi = acol * TILE_CELLS as i64 + ai + di;
				let gj = arow * TILE_CELLS as i64 + aj + dj;
				let col = gi.div_euclid(TILE_CELLS as i64);
				let row = gj.div_euclid(TILE_CELLS as i64);
				let i = gi - col * TILE_CELLS as i64;
				let j = gj - row * TILE_CELLS as i64;
				let (cx, cy) = cell_centre(col, row, i, j);
				let dh = js_hypot(cx - wx, cy - wy);
				if dh <= reach + CELL {
					cells.push(SnapCell { col, row, i, j, dh, wx: cx, wy: cy });
				}
			}
		}
		cells.sort_by(|a, b| a.dh.partial_cmp(&b.dh).unwrap());
		let tile_of = |cell: &SnapCell| self.grid.tile(c, cell.col, cell.row);
		let kk = |cell: &SnapCell| cell.j as usize * TILE_CELLS + cell.i as usize;
		if z.is_none() {
			if let Some(r) = self.floor_snap(c, &cells) {
				return Some(r);
			}
		}
		if standing {
			let zz = z.unwrap();
			let mut best: Option<(Arc<Tile>, usize, usize)> = None;
			let mut best_cost = f64::INFINITY;
			for (ci, cell) in cells.iter().enumerate() {
				if cell.dh > best_cost {
					break;
				}
				let Some(t) = tile_of(cell) else { continue };
				let k = kk(cell);
				for e in t.first[k] as usize..t.first[k + 1] as usize {
					let gap = (t.z[e] as f64 - zz).abs();
					if gap > STAND_DZ || cell.dh + 2.0 * gap >= best_cost || !self.usable(c, &t, k, cell, e, true) {
						continue;
					}
					best_cost = cell.dh + 2.0 * gap;
					best = Some((t.clone(), ci, e));
				}
			}
			if let Some((t, ci, e)) = best {
				return Some(self.make(c, &t, kk(&cells[ci]), &cells[ci], e));
			}
		}
		for strict in [true, false] {
			if let Some(zz) = z {
				let mut best: Option<(Arc<Tile>, usize, usize)> = None;
				let mut best_score = f64::INFINITY;
				for (ci, cell) in cells.iter().enumerate() {
					if cell.dh > best_score || cell.dh > radius + CELL {
						break;
					}
					let Some(t) = tile_of(cell) else { continue };
					let k = kk(cell);
					for e in t.first[k] as usize..t.first[k + 1] as usize {
						if !self.usable(c, &t, k, cell, e, strict) {
							continue;
						}
						let dz = t.z[e] as f64 - zz;
						let score = js_hypot(cell.dh, if under && dz > UNDER_SLACK { dz * UNDER_WEIGHT } else { dz });
						if score < best_score {
							best_score = score;
							best = Some((t.clone(), ci, e));
						}
					}
				}
				if let Some((t, ci, e)) = best {
					return Some(self.make(c, &t, kk(&cells[ci]), &cells[ci], e));
				}
				continue;
			}
			// rule: lowest indoor, else highest terrain, else the lowest usable.
			for cell in &cells {
				let Some(t) = tile_of(cell) else { continue };
				let k = kk(cell);
				let pick = |test: &dyn Fn(u8) -> bool, highest: bool| -> Option<usize> {
					let mut best = None;
					for e in t.first[k] as usize..t.first[k + 1] as usize {
						if !self.usable(c, &t, k, cell, e, strict) || !test(t.flags[e]) {
							continue;
						}
						if best.is_none() || highest {
							best = Some(e);
						}
					}
					best
				};
				let e = pick(&|f| f & flag::INDOOR != 0, false).or_else(|| pick(&|f| f & flag::TERRAIN != 0, true)).or_else(|| pick(&|_| true, false));
				if let Some(e) = e {
					return Some(self.make(c, &t, k, cell, e));
				}
			}
		}
		None
	}

	/// path.js Nav.floorSnap.
	fn floor_snap(&self, c: u32, cells: &[SnapCell]) -> Option<Snapped> {
		let mut c0 = None;
		for (ci, cell) in cells.iter().enumerate() {
			let Some(t) = self.grid.tile(c, cell.col, cell.row) else { continue };
			let k = cell.j as usize * TILE_CELLS + cell.i as usize;
			if t.first[k] == t.first[k + 1] {
				continue;
			}
			c0 = Some((ci, t, k));
			break;
		}
		let (ci0, t0, k0) = c0?;
		let cell0 = &cells[ci0];
		let mut zf: Option<f32> = None;
		let mut strict_indoor = false;
		for e in t0.first[k0] as usize..t0.first[k0 + 1] as usize {
			if t0.flags[e] & flag::INDOOR == 0 {
				continue;
			}
			if zf.is_none() && (t0.flags[e] & flag::BLOCKED == 0 || ((t0.ceil[e] as f64 - t0.z[e] as f64) < AGENT_HEIGHT && t0.slope[e] as f64 <= WALK_MAX)) {
				zf = Some(t0.z[e]);
			}
			if self.usable(c, &t0, k0, cell0, e, true) {
				strict_indoor = true;
			}
		}
		let zf = zf? as f64;
		let gi0 = cell0.col * TILE_CELLS as i64 + cell0.i;
		let gj0 = cell0.row * TILE_CELLS as i64 + cell0.j;
		for cell in cells {
			if strict_indoor && ((cell.col * TILE_CELLS as i64 + cell.i - gi0).abs() > 1 || (cell.row * TILE_CELLS as i64 + cell.j - gj0).abs() > 1) {
				continue;
			}
			let Some(t) = self.grid.tile(c, cell.col, cell.row) else { continue };
			let k = cell.j as usize * TILE_CELLS + cell.i as usize;
			let mut best = None;
			let mut best_dz = f64::INFINITY;
			for e in t.first[k] as usize..t.first[k + 1] as usize {
				let dz = (t.z[e] as f64 - zf).abs();
				if dz <= STEP && dz < best_dz && self.usable(c, &t, k, cell, e, true) {
					best = Some(e);
					best_dz = dz;
				}
			}
			if let Some(e) = best {
				return Some(self.make(c, &t, k, cell, e));
			}
		}
		None
	}

	/// path.js tileTree: the whole tile searched from (forward) or to (reverse) entry e.
	pub fn tile_tree(&self, t: &Tile, e: usize, k: usize, p: &Profile, reverse: bool, sc: &mut Tree) {
		if sc.dist.len() < t.n {
			let cap = t.n.max(if sc.dist.is_empty() { 1 << 17 } else { sc.dist.len() * 2 });
			*sc = Tree { dist: vec![0.0; cap], yd: vec![0.0; cap], par: vec![0; cap], k_of: vec![0; cap], stamp: vec![0; cap], done: vec![0; cap], gen: 0, heap: MinHeap::default() };
		}
		sc.gen = sc.gen.wrapping_add(1);
		if sc.gen == u32::MAX {
			sc.stamp.fill(0);
			sc.done.fill(0);
			sc.gen = 1;
		}
		let gen = sc.gen;
		sc.heap.clear();
		sc.stamp[e] = gen;
		sc.dist[e] = 0.0;
		sc.yd[e] = 0.0;
		sc.par[e] = -1;
		sc.k_of[e] = k as i32;
		sc.heap.push(0.0, e as i32);
		let mut links = Links::default();
		let tc = p.in_tile(t);
		while !sc.heap.is_empty() {
			let u = sc.heap.pop() as usize;
			if sc.done[u] == gen {
				continue;
			}
			sc.done[u] = gen;
			let du = sc.dist[u];
			if !reverse {
				expand(t, u, sc.k_of[u] as usize, &tc, &mut links);
			} else {
				in_links(t, u, sc.k_of[u] as usize, Some(&tc), true, &mut links);
			}
			for x in 0..links.to.len() {
				let v = links.to[x] as usize;
				let nd = du + links.cost[x];
				if sc.stamp[v] != gen || nd < sc.dist[v] {
					sc.stamp[v] = gen;
					sc.dist[v] = nd;
					sc.yd[v] = sc.yd[u] + links.d[x];
					sc.par[v] = u as i32;
					sc.k_of[v] = links.k[x] as i32;
					sc.heap.push(nd, v as i32);
				}
			}
		}
	}

	/// path.js treeCells: the yards of the tree's way to (forward) or from (reverse) entry e per zone cell.
	pub fn tree_cells(&self, t: &Tile, sc: &Tree, e: usize, reverse: bool) -> Cells {
		let mut acc = Cells::default();
		let mut v = e;
		while sc.par[v] != -1 {
			let pv = sc.par[v] as usize;
			let w = if reverse { pv } else { v };
			let k = sc.k_of[w] as usize;
			acc.add(forge_core::cells::cell_key(t.wx(k), t.wy(k)) as u32, (sc.yd[v] - sc.yd[pv]).abs());
			v = pv;
		}
		acc
	}

	/// cch.js startLegs: the start's tile searched from it; seeds are the tile's nodes reached.
	pub fn start_legs(&self, g: &Graph, a: &Snapped, p: &Profile, sc: &mut Tree, cells: bool) -> Option<Legs> {
		let t = self.grid.tile(a.c, a.col as i64, a.row as i64)?;
		self.tile_tree(&t, a.entry as usize, a.k(), p, false, sc);
		Some(self.collect(g, &t, a, sc, cells, false))
	}

	fn collect(&self, g: &Graph, t: &Tile, a: &Snapped, sc: &Tree, cells: bool, reverse: bool) -> Legs {
		let mut l = Legs { cells: if cells { Some(Vec::new()) } else { None }, ..Default::default() };
		if let Some(gt) = g.tile_of(a.col, a.row) {
			for x in gt.node_base..gt.node_base + gt.node_count {
				let e = g.node_entry[x as usize] as usize;
				if !sc.reached(e) {
					continue;
				}
				l.nodes.push(x);
				l.sec.push(sc.dist[e]);
				l.yd.push(sc.yd[e]);
				if let Some(c) = l.cells.as_mut() {
					c.push(self.tree_cells(t, sc, e, reverse));
				}
			}
		}
		l
	}

	/// path.js goalLegs (uncached): the goal's tile searched backward to it.
	pub fn goal_legs(&self, g: &Graph, b: &Snapped, p: &Profile, sc: &mut Tree, cells: bool) -> Legs {
		let Some(t) = self.grid.tile(b.c, b.col as i64, b.row as i64) else { return Legs { cells: cells.then(Vec::new), ..Default::default() } };
		if g.tile_of(b.col, b.row).is_none() {
			return Legs { cells: cells.then(Vec::new), ..Default::default() };
		}
		self.tile_tree(&t, b.entry as usize, b.k(), p, true, sc);
		self.collect(g, &t, b, sc, cells, true)
	}

	/// path.js settleCandidates.
	pub fn settle_candidates(&self, e: &Snapped, p: &Profile, goal: bool, sc: &mut Tree) -> Vec<Snapped> {
		let Some(t0) = self.grid.tile(e.c, e.col as i64, e.row as i64) else { return Vec::new() };
		self.tile_tree(&t0, e.entry as usize, e.k(), p, goal, sc);
		let r = (SETTLE_RADIUS / CELL).ceil() as i64;
		let gi0 = e.col as i64 * TILE_CELLS as i64 + e.i as i64;
		let gj0 = e.row as i64 * TILE_CELLS as i64 + e.j as i64;
		let mut out: Vec<(f64, f64, Snapped)> = Vec::new();
		for dj in -r..=r {
			for di in -r..=r {
				let dh = js_hypot(di as f64, dj as f64) * CELL;
				if dh > SETTLE_RADIUS {
					continue;
				}
				let col = (gi0 + di).div_euclid(TILE_CELLS as i64);
				let row = (gj0 + dj).div_euclid(TILE_CELLS as i64);
				let Some(t) = self.grid.tile(e.c, col, row) else { continue };
				let i = gi0 + di - col * TILE_CELLS as i64;
				let j = gj0 + dj - row * TILE_CELLS as i64;
				let k = (j * TILE_CELLS as i64 + i) as usize;
				for x in t.first[k] as usize..t.first[k + 1] as usize {
					if t.flags[x] & flag::BLOCKED != 0 {
						continue;
					}
					let dz = t.z[x] as f64 - e.z;
					if !(-SETTLE_DROP..=SETTLE_RISE).contains(&dz) {
						continue;
					}
					if t.col == t0.col && t.row == t0.row && sc.reached(x) {
						continue;
					}
					let region = self.grid.region(e.c, col as u32, row as u32, x as u32);
					if e.region.is_some() && region != e.region {
						continue;
					}
					let (wx, wy) = cell_centre(col, row, i, j);
					out.push((
						dh,
						dz.abs(),
						Snapped {
							c: e.c,
							wx,
							wy,
							z: t.z[x] as f64,
							col: col as u32,
							row: row as u32,
							i: i as u32,
							j: j as u32,
							layer: (x - t.first[k] as usize) as u32,
							entry: x as u32,
							region,
							flags: t.flags[x],
						},
					));
				}
			}
		}
		out.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap().then(a.1.partial_cmp(&b.1).unwrap()));
		out.into_iter().take(SETTLE_TRIES).map(|x| x.2).collect()
	}

	/// cch.js startOf: the start's legs; a start in a pocket that reaches none of its tile's nodes
	/// takes the first surface near it that does (settleCandidates). -> (legs, the candidate taken
	/// or None, the place the legs leave from).
	pub fn start_of(&self, g: &Graph, a: &Snapped, p: &Profile, sc: &mut Tree, cells: bool) -> Option<(Legs, Option<usize>, Snapped)> {
		let l = self.start_legs(g, a, p, sc, cells)?;
		if !l.nodes.is_empty() {
			return Some((l, None, *a));
		}
		for (k, e) in self.settle_candidates(a, p, false, sc).into_iter().enumerate() {
			if let Some(l2) = self.start_legs(g, &e, p, sc, cells) {
				if !l2.nodes.is_empty() {
					return Some((l2, Some(k), e));
				}
			}
		}
		Some((self.start_legs(g, a, p, sc, cells)?, None, *a))
	}

	/// cch.js distanceRows goalOf: the goal's legs, settled as start_of settles a start.
	pub fn goal_of(&self, g: &Graph, b: &Snapped, p: &Profile, sc: &mut Tree, cells: bool) -> (Legs, Option<usize>) {
		let l = self.goal_legs(g, b, p, sc, cells);
		if !l.nodes.is_empty() {
			return (l, None);
		}
		for (k, e) in self.settle_candidates(b, p, true, sc).into_iter().enumerate() {
			let l2 = self.goal_legs(g, &e, p, sc, cells);
			if !l2.nodes.is_empty() {
				return (l2, Some(k));
			}
		}
		(l, None)
	}
}
