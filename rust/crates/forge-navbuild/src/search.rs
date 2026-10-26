//! Search primitives over linked tiles (port of tools/lib/nav/grid/search.js, the parts the build
//! uses: MinHeap, Space with expand, in-links without falls, isOpen).
//!
//! A Space numbers the entries of a set of tiles (slots) as one node range: node = base[slot] +
//! entry. expand() lists a node's out-links that stay in the Space, with their seconds for a
//! profile (move.js).

use crate::format::{cls, flag, Tile, ADT, CELL, CODE_LIFT, DIRS, FALL_SLIDE, NO_LINK, TILE_CELLS};
use crate::links::FALL_SPAN;
use crate::moves::{fall_seconds, lift_seconds, link_seconds, segment_class, Profile};
use rustc_hash::{FxHashMap, FxHashSet};

const DIAG: f64 = CELL * std::f64::consts::SQRT_2;

/// A binary min-heap of (key, value), popping ties in the JS heap's order.
pub struct MinHeap {
	keys: Vec<f64>,
	vals: Vec<i32>,
	pub size: usize,
	/// The key of the last pop.
	pub top: f64,
}

impl MinHeap {
	pub fn new(cap: usize) -> Self {
		MinHeap { keys: vec![0.0; cap], vals: vec![0; cap], size: 0, top: 0.0 }
	}

	pub fn push(&mut self, key: f64, val: i32) {
		if self.size == self.keys.len() {
			let n = self.size * 2;
			self.keys.resize(n, 0.0);
			self.vals.resize(n, 0);
		}
		let mut i = self.size;
		self.size += 1;
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
		self.size -= 1;
		let n = self.size;
		if n > 0 {
			let key = self.keys[n];
			let v = self.vals[n];
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

/// One out-link of expand().
#[derive(Clone, Copy, Debug, Default)]
pub struct Out {
	pub to: i32,
	pub slot: i32,
	pub k: i32,
	/// Stored link code, CLS.FALL or CODE_LIFT.
	pub code: u8,
	pub cls: u8,
	pub cost: f64,
	pub d: f64,
	/// Fall or lift height, else 0.
	pub h: f64,
}

pub struct Space<'a> {
	pub tiles: Vec<&'a Tile>,
	pub base: Vec<i32>,
	slots: FxHashMap<i64, i32>,
	nb: Vec<i32>,
	fall_at: Vec<Option<Vec<u32>>>,
	rs: i32,
	pub out: Vec<Out>,
}

impl<'a> Space<'a> {
	pub fn new(tiles: &[&'a Tile]) -> Self {
		let mut s = Space { tiles: Vec::new(), base: vec![0], slots: FxHashMap::default(), nb: Vec::new(), fall_at: Vec::new(), rs: -1, out: Vec::with_capacity(32) };
		for t in tiles {
			s.add(t);
		}
		s
	}

	fn add(&mut self, t: &'a Tile) -> i32 {
		let s = self.tiles.len() as i32;
		self.tiles.push(t);
		let b = self.base[s as usize] + t.n as i32;
		self.base.push(b);
		self.slots.insert(i64::from(t.col) * 65536 + i64::from(t.row), s);
		for x in 0..9 {
			self.nb.push(if x == 4 { s } else { -2 });
		}
		self.fall_at.push(None);
		s
	}

	pub fn size(&self) -> i32 {
		self.base[self.tiles.len()]
	}

	pub fn slot(&mut self, col: i32, row: i32) -> i32 {
		let key = i64::from(col) * 65536 + i64::from(row);
		if let Some(&s) = self.slots.get(&key) {
			return s;
		}
		self.slots.insert(key, -1);
		-1
	}

	pub fn slot_of(&self, node: i32) -> usize {
		let b = &self.base;
		let (mut lo, mut hi) = (0usize, self.tiles.len() - 1);
		while lo < hi {
			let mid = (lo + hi + 1) >> 1;
			if b[mid] <= node {
				lo = mid;
			} else {
				hi = mid - 1;
			}
		}
		lo
	}

	pub fn wx(&self, slot: usize, k: usize) -> f64 {
		(32.0 - f64::from(self.tiles[slot].row)) * ADT - ((k >> 8) as f64 + 0.5) * CELL
	}

	pub fn wy(&self, slot: usize, k: usize) -> f64 {
		(32.0 - f64::from(self.tiles[slot].col)) * ADT - ((k & 255) as f64 + 0.5) * CELL
	}

	/// The slot and column of (i, j) relative to slot -> sets rs, returns k or -1.
	fn col(&mut self, slot: usize, i: i32, j: i32) -> i32 {
		let tc = TILE_CELLS as i32;
		let dc = if i < 0 {
			-1
		} else if i >= tc {
			1
		} else {
			0
		};
		let dr = if j < 0 {
			-1
		} else if j >= tc {
			1
		} else {
			0
		};
		let mut s = slot as i32;
		if dc != 0 || dr != 0 {
			let x = slot * 9 + ((dr + 1) * 3 + (dc + 1)) as usize;
			s = self.nb[x];
			if s == -2 {
				let t = self.tiles[slot];
				s = self.slot(t.col + dc, t.row + dr);
				self.nb[x] = s;
			}
		}
		self.rs = s;
		if s < 0 {
			return -1;
		}
		(j - dr * tc) * tc + (i - dc * tc)
	}

	/// Out-links of entry e (column k) of slot for profile p into `self.out` -> count. Lifts come
	/// from tile.lifts.
	pub fn expand(&mut self, slot: usize, e: usize, k: usize, p: &Profile) -> usize {
		self.out.clear();
		let t = self.tiles[slot];
		let i = (k & 255) as i32;
		let j = (k >> 8) as i32;
		let fa = t.flags[e];
		let za = f64::from(t.z[e]);
		let lk = t.links.as_ref().expect("a linked tile");
		for (d, dir) in DIRS.iter().enumerate() {
			let b = lk[e * 8 + d];
			if b == NO_LINK {
				continue;
			}
			let k2 = self.col(slot, i + dir[0], j + dir[1]);
			if k2 < 0 {
				continue;
			}
			let s2 = self.rs as usize;
			let t2 = self.tiles[s2];
			let v = t2.first[k2 as usize] as usize + usize::from(b & 31);
			let code = b >> 5;
			let dz = f64::from(t2.z[v]) - za;
			let h = if d & 1 == 1 { DIAG } else { CELL };
			let dist = (h * h + dz * dz).sqrt();
			let fb = t2.flags[v];
			self.out.push(Out { to: self.base[s2] + v as i32, slot: s2 as i32, k: k2, code, cls: segment_class(code, fa, fb), cost: link_seconds(p, code, fa, fb, dist), d: dist, h: 0.0 });
		}
		if let Some(lifts) = &t.lifts {
			if let Some((_, rides)) = lifts.iter().find(|(from, _)| *from as usize == e) {
				for l in rides {
					let s2 = if l.col == t.col && l.row == t.row { slot as i32 } else { self.slot(l.col, l.row) };
					if s2 < 0 {
						continue;
					}
					self.out.push(Out { to: self.base[s2 as usize] + l.entry as i32, slot: s2, k: l.k as i32, code: CODE_LIFT, cls: cls::LIFT, cost: lift_seconds(l.h), d: l.h.abs(), h: l.h });
				}
			}
		}
		if fa & flag::SWIM != 0 || t.fall_from.is_empty() {
			return self.out.len();
		}
		if self.fall_at[slot].is_none() {
			self.fall_at[slot] = Some(fall_index(t));
		}
		let (f0, f1) = {
			let at = self.fall_at[slot].as_ref().unwrap();
			(at[e] as usize, at[e + 1] as usize)
		};
		for f in f0..f1 {
			let code = t.fall_to[f];
			let off = i32::from(code >> 5);
			let di = off.div_euclid(FALL_SPAN) - FALL_SLIDE as i32;
			let dj = off % FALL_SPAN - FALL_SLIDE as i32;
			let k2 = self.col(slot, i + di, j + dj);
			if k2 < 0 {
				continue;
			}
			let s2 = self.rs as usize;
			let t2 = self.tiles[s2];
			let v = t2.first[k2 as usize] as usize + usize::from(code & 31);
			let hgt = za - f64::from(t2.z[v]);
			let hor = f64::from(di * di + dj * dj).sqrt() * CELL;
			self.out.push(Out {
				to: self.base[s2] + v as i32,
				slot: s2 as i32,
				k: k2,
				code: cls::FALL,
				cls: cls::FALL,
				cost: fall_seconds(hgt, t2.flags[v] & flag::SWIM != 0),
				d: (hor * hor + hgt * hgt).sqrt(),
				h: hgt,
			});
		}
		self.out.len()
	}
}

/// A linked tile's fallFrom index by entry: falls of entry e at [at[e], at[e + 1]).
fn fall_index(t: &Tile) -> Vec<u32> {
	let mut at = vec![0u32; t.n + 1];
	for &f in &t.fall_from {
		at[f as usize + 1] += 1;
	}
	for e in 0..t.n {
		at[e + 1] += at[e];
	}
	at
}

/// In-links of entry u (column k) of a linked tile from inside the tile, neighbour links only
/// (search.js inLinks(t, u, k, null, false)) -> (source entry, its column).
pub fn in_links(t: &Tile, u: usize, k: usize, out: &mut Vec<(u32, u32)>) {
	out.clear();
	let links = t.links.as_ref().expect("a linked tile");
	let first = &t.first;
	let tc = TILE_CELLS as i32;
	let i = (k & 255) as i32;
	let j = (k >> 8) as i32;
	let layer = (u as u32 - first[k]) as u8;
	for (d, dir) in DIRS.iter().enumerate() {
		let si = i - dir[0];
		let sj = j - dir[1];
		if si < 0 || sj < 0 || si >= tc || sj >= tc {
			continue;
		}
		let ks = (sj * tc + si) as usize;
		for s in first[ks] as usize..first[ks + 1] as usize {
			let b = links[s * 8 + d];
			if b == NO_LINK || b & 31 != layer {
				continue;
			}
			out.push((s as u32, ks as u32));
		}
	}
}

/// Whether entry e (column k) of a linked tile is open both ways: walking (neighbour links: no
/// falls, no lifts) inside the tile leads from it to `limit` surfaces, or to a link leaving the
/// tile, and from as many to it.
pub fn is_open(t: &Tile, k: usize, e: usize, limit: usize) -> bool {
	let links = t.links.as_ref().expect("a linked tile");
	let first = &t.first;
	let tc = TILE_CELLS as i32;
	let mut inl: Vec<(u32, u32)> = Vec::new();
	let mut spread = |forward: bool| -> bool {
		let mut seen: FxHashSet<u32> = FxHashSet::default();
		seen.insert(e as u32);
		let mut queue: Vec<(u32, u32)> = vec![(e as u32, k as u32)];
		let mut q = 0;
		while q < queue.len() && seen.len() < limit {
			let (u, ku) = queue[q];
			q += 1;
			let u = u as usize;
			let i = (ku & 255) as i32;
			let j = (ku >> 8) as i32;
			for (d, dir) in DIRS.iter().enumerate() {
				let b = links[u * 8 + d];
				if b == NO_LINK {
					continue;
				}
				let ni = i + dir[0];
				let nj = j + dir[1];
				if ni < 0 || nj < 0 || ni >= tc || nj >= tc {
					return true;
				}
				if !forward {
					continue;
				}
				let kv = (nj * tc + ni) as u32;
				let v = first[kv as usize] + u32::from(b & 31);
				if seen.insert(v) {
					queue.push((v, kv));
				}
			}
			if forward {
				continue;
			}
			in_links(t, u, ku as usize, &mut inl);
			for &(s, ks) in &inl {
				if seen.insert(s) {
					queue.push((s, ks));
				}
			}
		}
		seen.len() >= limit
	};
	spread(true) && spread(false)
}
