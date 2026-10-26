//! Regions: connected components over links, continent-wide (port of tools/lib/nav/grid/regions.js).
//! Each tile labels its own components (links and falls inside the tile, both ways; numbered in
//! entry order, so a rebuild is identical), then the continent joins the components that links
//! across tile borders connect (a union-find over every tile's components). Falls count as links.

use crate::format::{flag, Tile, DIRS, NO_COMP, NO_LINK, TILE_CELLS};
use crate::links::fall_target;
use rustc_hash::FxHashMap;

pub struct UnionFind {
	parent: Vec<u32>,
}

impl UnionFind {
	pub fn new(n: usize) -> Self {
		UnionFind { parent: (0..n as u32).collect() }
	}

	pub fn find(&mut self, mut a: u32) -> u32 {
		let p = &mut self.parent;
		let mut r = a;
		while p[r as usize] != r {
			r = p[r as usize];
		}
		while p[a as usize] != r {
			let nx = p[a as usize];
			p[a as usize] = r;
			a = nx;
		}
		r
	}

	pub fn union(&mut self, a: u32, b: u32) {
		let ra = self.find(a);
		let rb = self.find(b);
		if ra == rb {
			return;
		}
		if ra < rb {
			self.parent[rb as usize] = ra;
		} else {
			self.parent[ra as usize] = rb;
		}
	}
}

/// A linked tile -> (comp per entry, NO_COMP for blocked; component count).
pub fn local_components(tile: &Tile) -> (Vec<u32>, u32) {
	let n = tile.n;
	let links = tile.links.as_ref().expect("a linked tile");
	let first = &tile.first;
	let tc = TILE_CELLS as i32;
	let mut uf = UnionFind::new(n);
	for k in 0..TILE_CELLS * TILE_CELLS {
		let i = (k & 255) as i32;
		let j = (k >> 8) as i32;
		for s in first[k] as usize..first[k + 1] as usize {
			for (d, dir) in DIRS.iter().enumerate() {
				let b = links[s * 8 + d];
				if b == NO_LINK {
					continue;
				}
				let ni = i + dir[0];
				let nj = j + dir[1];
				if ni < 0 || nj < 0 || ni >= tc || nj >= tc {
					continue;
				}
				uf.union(s as u32, first[(nj * tc + ni) as usize] + u32::from(b & 31));
			}
		}
	}
	for (f, &s) in tile.fall_from.iter().enumerate() {
		let (di, dj, layer) = fall_target(tile.fall_to[f]);
		let k = column_of(first, s) as i32;
		let ni = (k & 255) + di;
		let nj = (k >> 8) + dj;
		if ni < 0 || nj < 0 || ni >= tc || nj >= tc {
			continue;
		}
		uf.union(s, first[(nj * tc + ni) as usize] + layer);
	}
	let mut comp = vec![NO_COMP; n];
	let mut ids: FxHashMap<u32, u32> = FxHashMap::default();
	for s in 0..n {
		if tile.flags[s] & flag::BLOCKED != 0 {
			continue;
		}
		let r = uf.find(s as u32);
		let next = ids.len() as u32;
		comp[s] = *ids.entry(r).or_insert(next);
	}
	(comp, ids.len() as u32)
}

/// The column of entry s (binary search over first).
pub fn column_of(first: &[u32], s: u32) -> usize {
	let mut lo = 0usize;
	let mut hi = TILE_CELLS * TILE_CELLS - 1;
	while lo < hi {
		let mid = (lo + hi + 1) >> 1;
		if first[mid] <= s {
			lo = mid;
		} else {
			hi = mid - 1;
		}
	}
	lo
}

/// Continent regions: components of every tile at compBase offsets, joined by pairs
/// [globalA, globalB] -> (region per global component, numbered in component order; count).
pub fn join_regions(total: usize, pairs: &[u32]) -> (Vec<u32>, u32) {
	let mut uf = UnionFind::new(total);
	for p in pairs.chunks_exact(2) {
		uf.union(p[0], p[1]);
	}
	let mut region = vec![0u32; total];
	let mut ids: FxHashMap<u32, u32> = FxHashMap::default();
	for (g, r) in region.iter_mut().enumerate() {
		let root = uf.find(g as u32);
		let next = ids.len() as u32;
		*r = *ids.entry(root).or_insert(next);
	}
	(region, ids.len() as u32)
}
