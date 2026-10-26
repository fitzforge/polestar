//! Port of tools/lib/nav/grid/rasterise.js.
//!
//! Triangles -> solid spans per column (Recast's rcRasterizeTriangles): each
//! triangle is clipped to every column it covers; the clipped polygon's z
//! range is a span carrying the triangle's slope (degrees) and kind. Spans of
//! a column that overlap merge into one: the merged span keeps the attributes
//! of the higher top, or of the flatter one when the tops are within
//! MERGE_TOP (Recast's flagMergeThreshold).
//!
//! Model triangles too steep to stand on (decided 2026-10-15). Taken over a
//! whole 2.08 yd column, the end of a door jamb, a stair stringer or a post
//! poking into its corner closed it from floor to ceiling, so doorways
//! narrower than about two columns were shut (the Lion's Pride Inn's halls,
//! the Undercity lift station's arch). So:
//! - walls (WALL_MIN or steeper) are no spans: they are kept as the z
//!   ranges where they cross each of the column's four half-lines (from its
//!   centre to the middle of each side, format.js HALF), and links.js lets no
//!   link or fall cross one between a step and a body height above the feet;
//! - faces between WALK_MAX and WALL_MIN (roofs, rock faces, a cave's leaning
//!   walls) are spans only where they cross one of the column's two centre
//!   lines, over the z range of that crossing (as walls, a leaning cave wall
//!   at head height closed passages one walks through in the client).
//!
//! Reviewed openings (decided 2026-10-19, #366). A doorway narrower than about
//! three yards still lost to the columns when a jamb's moulding (a walkable
//! slope, so a span over the whole column) or a reveal (a wall on a
//! half-line) sat on the doorway's column centre lines: Brill's town hall,
//! whose only way in is a 2.9 yd side door into its tower room, was a sealed
//! pocket. geom.openings (tools/lib/nav/geom/openings.json, placed by
//! tileGeometry) are cut out after the triangles: in every column whose centre
//! lies inside a cut's footprint, spans and walls between CUT_FLOOR above the
//! portal's bottom and its top are trimmed away (carve), so the threshold's
//! own floor stays and the doorway is open to its full height.
//!
//! Reviewed walkways (#374). A narrow model deck lost to the second rule: a
//! rope bridge placed at 0.71 scale between Darkcloud Pinnacle's mesas has
//! rails whose leaning faces (68-74 degrees) cross the centre lines of the
//! deck's own columns, so their spans covered the planks (blocked below,
//! steep on top) and the bridge was cut in two. The triangles of an M2 listed
//! in tools/lib/nav/geom/walkways.json (tagged KIND_WALKWAY by tileGeometry; here also the
//! WMO groups of its `groups`, kinds 5 and 6, which the JS build does not have: Thunder
//! Bluff's rope bridges)
//! that are steeper than WALK_MAX are walls, as if they were
//! WALL_MIN or steeper: the deck stays open and the rails still keep a walk
//! on it. Every other model keeps the rules above.
//!
//! rasterise(geom) -> Heightfield
//!   head: first span of each column (ascending z), -1 none
//!   next, smin, smax, slope (u8, degrees), kind (u8) per span
//!   tslope (u8, degrees) per span: the steepest terrain triangle merged
//!     into it (0 when none)
//!   walls(): the walls (format.js WALLS), merged per half-line

use crate::fmath;
use crate::format::{half, wall_index, Walls, ADT, CELL, COLUMNS, MERGE_TOP, TILE_CELLS, WALK_MAX, WALL_MIN};
use crate::geom::{Cut, Geometry};

/// yd above a cut's bottom that its threshold's floor may reach
pub const CUT_FLOOR: f64 = 0.25;

#[derive(Clone, Debug)]
pub struct Heightfield {
	pub head: Vec<i32>,
	pub cap: usize,
	pub used: usize,
	pub free: i32,
	pub next: Vec<i32>,
	pub smin: Vec<f32>,
	pub smax: Vec<f32>,
	pub slope: Vec<u8>,
	pub kind: Vec<u8>,
	pub tslope: Vec<u8>,
	pub wn: usize,
	pub w_key: Vec<u32>,
	pub w_lo: Vec<f32>,
	pub w_hi: Vec<f32>,
}

impl Heightfield {
	pub fn new(capacity: usize) -> Self {
		let mut hf = Heightfield {
			head: vec![-1; COLUMNS],
			cap: 0,
			used: 0,
			free: -1,
			next: Vec::new(),
			smin: Vec::new(),
			smax: Vec::new(),
			slope: Vec::new(),
			kind: Vec::new(),
			tslope: Vec::new(),
			wn: 0,
			w_key: Vec::with_capacity(1 << 12),
			w_lo: Vec::with_capacity(1 << 12),
			w_hi: Vec::with_capacity(1 << 12),
		};
		hf.grow(capacity);
		hf
	}

	/// A wall crossing half-line h (format.js HALF) of column k over [lo, hi].
	pub fn add_wall(&mut self, k: usize, h: usize, lo: f64, hi: f64) {
		self.w_key.truncate(self.wn);
		self.w_lo.truncate(self.wn);
		self.w_hi.truncate(self.wn);
		self.w_key.push((k * 4 + h) as u32);
		self.w_lo.push(lo as f32);
		self.w_hi.push(hi as f32);
		self.wn += 1;
	}

	/// Trims column k's spans and walls to outside (lo, hi): a span or wall
	/// inside goes, one across the whole range splits in two.
	pub fn carve(&mut self, k: usize, lo: f64, hi: f64) {
		let mut prev: i32 = -1;
		let mut cur = self.head[k];
		while cur != -1 {
			let c = cur as usize;
			let a = f64::from(self.smin[c]);
			let b = f64::from(self.smax[c]);
			let nx = self.next[c];
			if b <= lo || a >= hi {
				prev = cur;
			} else if a >= lo && b <= hi {
				self.release(c);
				if prev == -1 {
					self.head[k] = nx;
				} else {
					self.next[prev as usize] = nx;
				}
			} else if a < lo && b > hi {
				let s = self.alloc();
				self.smin[s] = hi as f32;
				self.smax[s] = b as f32;
				self.slope[s] = self.slope[c];
				self.kind[s] = self.kind[c];
				self.tslope[s] = self.tslope[c];
				self.smax[c] = lo as f32;
				self.next[s] = nx;
				self.next[c] = s as i32;
				prev = s as i32;
			} else {
				if a < lo {
					self.smax[c] = lo as f32;
				} else {
					self.smin[c] = hi as f32;
				}
				prev = cur;
			}
			cur = nx;
		}
		let n = self.wn;
		for w in 0..n {
			if (self.w_key[w] >> 2) as usize != k {
				continue;
			}
			let a = f64::from(self.w_lo[w]);
			let b = f64::from(self.w_hi[w]);
			if b <= lo || a >= hi {
				continue;
			}
			if a < lo && b > hi {
				self.w_hi[w] = lo as f32;
				self.add_wall(k, (self.w_key[w] & 3) as usize, hi, b);
			} else if a >= lo && b <= hi {
				self.w_lo[w] = f32::INFINITY; // dropped by walls()
			} else if a < lo {
				self.w_hi[w] = lo as f32;
			} else {
				self.w_lo[w] = hi as f32;
			}
		}
	}

	pub fn walls(&mut self) -> Walls {
		let mut n = 0;
		for w in 0..self.wn {
			if self.w_lo[w] == f32::INFINITY {
				continue;
			}
			self.w_key[n] = self.w_key[w];
			self.w_lo[n] = self.w_lo[w];
			self.w_hi[n] = self.w_hi[w];
			n += 1;
		}
		self.wn = n;
		self.w_key.truncate(n);
		self.w_lo.truncate(n);
		self.w_hi.truncate(n);
		let lo: Vec<f64> = self.w_lo.iter().map(|&v| f64::from(v)).collect();
		let hi: Vec<f64> = self.w_hi.iter().map(|&v| f64::from(v)).collect();
		wall_index(&self.w_key, &lo, &hi)
	}

	pub fn grow(&mut self, cap: usize) {
		self.next.resize(cap, 0);
		self.smin.resize(cap, 0.0);
		self.smax.resize(cap, 0.0);
		self.slope.resize(cap, 0);
		self.kind.resize(cap, 0);
		self.tslope.resize(cap, 0);
		self.cap = cap;
	}

	pub fn alloc(&mut self) -> usize {
		if self.free >= 0 {
			let s = self.free as usize;
			self.free = self.next[s];
			return s;
		}
		if self.used == self.cap {
			self.grow(self.cap * 2);
		}
		self.used += 1;
		self.used - 1
	}

	pub fn release(&mut self, s: usize) {
		self.next[s] = self.free;
		self.free = s as i32;
	}

	/// Adds [lo, hi] to column k, merging every span it overlaps; tslope: the
	/// triangle's slope when it is terrain, else 0.
	pub fn add(&mut self, k: usize, mut lo: f64, mut hi: f64, slope: u8, kind: u8, tslope: u8) {
		let mut top_z = hi;
		let mut top_slope = slope;
		let mut top_kind = kind;
		let mut tmax = tslope;
		let mut prev: i32 = -1;
		let mut cur = self.head[k];
		while cur != -1 {
			let c = cur as usize;
			if f64::from(self.smin[c]) > hi {
				break;
			}
			if f64::from(self.smax[c]) < lo {
				prev = cur;
				cur = self.next[c];
				continue;
			}
			let cz = f64::from(self.smax[c]);
			if self.tslope[c] > tmax {
				tmax = self.tslope[c];
			}
			if (cz - top_z).abs() <= MERGE_TOP {
				if self.slope[c] < top_slope {
					top_slope = self.slope[c];
					top_kind = self.kind[c];
				}
				if cz > top_z {
					top_z = cz;
				}
			} else if cz > top_z {
				top_z = cz;
				top_slope = self.slope[c];
				top_kind = self.kind[c];
			}
			if f64::from(self.smin[c]) < lo {
				lo = f64::from(self.smin[c]);
			}
			if cz > hi {
				hi = cz;
			}
			let nx = self.next[c];
			self.release(c);
			if prev == -1 {
				self.head[k] = nx;
			} else {
				self.next[prev as usize] = nx;
			}
			cur = nx;
		}
		let s = self.alloc();
		self.smin[s] = lo as f32;
		self.smax[s] = hi as f32;
		self.slope[s] = top_slope;
		self.kind[s] = top_kind;
		self.tslope[s] = tmax;
		if prev == -1 {
			self.next[s] = self.head[k];
			self.head[k] = s as i32;
		} else {
			let p = prev as usize;
			self.next[s] = self.next[p];
			self.next[p] = s as i32;
		}
	}
}

// Recast's dividePoly: splits polygon `src` (n vertices, 3 floats each) at
// value x on axis into a (<= x) and b (>= x) -> (na, nb).
//
// Ported to JavaScript from dividePoly in Recast/Source/RecastRasterization.cpp
// of Recast & Detour (https://github.com/recastnavigation/recastnavigation);
// altered: flat arrays, the counts packed into one return value (here a pair);
// ported on to Rust. Its notice:
//
// Copyright (c) 2009-2010 Mikko Mononen memon@inside.org
//
// This software is provided 'as-is', without any express or implied
// warranty.  In no event will the authors be held liable for any damages
// arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not
//    claim that you wrote the original software. If you use this software
//    in a product, an acknowledgment in the product documentation would be
//    appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be
//    misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.
fn divide(src: &[f64; POLY], n: usize, a: &mut [f64; POLY], b: &mut [f64; POLY], x: f64, axis: usize, d: &mut [f64; DBUF]) -> (usize, usize) {
	for i in 0..n {
		d[i] = x - src[i * 3 + axis];
	}
	let mut na = 0;
	let mut nb = 0;
	let mut j = n.wrapping_sub(1);
	for i in 0..n {
		let ina = d[j] >= 0.0;
		let inb = d[i] >= 0.0;
		if ina != inb {
			let s = d[j] / (d[j] - d[i]);
			for c in 0..3 {
				let v = src[j * 3 + c] + (src[i * 3 + c] - src[j * 3 + c]) * s;
				a[na * 3 + c] = v;
				b[nb * 3 + c] = v;
			}
			na += 1;
			nb += 1;
			if d[i] > 0.0 {
				a[na * 3..na * 3 + 3].copy_from_slice(&src[i * 3..i * 3 + 3]);
				na += 1;
			} else if d[i] < 0.0 {
				b[nb * 3..nb * 3 + 3].copy_from_slice(&src[i * 3..i * 3 + 3]);
				nb += 1;
			}
		} else {
			if d[i] >= 0.0 {
				a[na * 3..na * 3 + 3].copy_from_slice(&src[i * 3..i * 3 + 3]);
				na += 1;
				if d[i] != 0.0 {
					j = i;
					continue;
				}
			}
			b[nb * 3..nb * 3 + 3].copy_from_slice(&src[i * 3..i * 3 + 3]);
			nb += 1;
		}
		j = i;
	}
	(na, nb)
}

// Records where polygon `p` (n vertices, 3 floats each: u, v, z) of a wall
// crosses the half-lines of column k, centre (cu, cv): the line v = cv
// (halves E, u >= cu, and W) and the line u = cu (S, v >= cv, and N). A
// crossing's whole z range goes to each half it touches.
fn cross_walls(hf: &mut Heightfield, k: usize, p: &[f64; POLY], n: usize, cu: f64, cv: f64) {
	for axis in [1usize, 0] {
		let c = if axis == 1 { cv } else { cu }; // the line's fixed coordinate
		let along = 1 - axis; // the coordinate along the line
		let mut lo = f64::INFINITY;
		let mut hi = f64::NEG_INFINITY;
		let mut p0 = f64::INFINITY;
		let mut p1 = f64::NEG_INFINITY;
		let mut j = n - 1;
		for i in 0..n {
			let a = p[j * 3 + axis] - c;
			let b = p[i * 3 + axis] - c;

			let (z, at) = if a == 0.0 {
				(p[j * 3 + 2], p[j * 3 + along])
			} else if (a < 0.0 && b > 0.0) || (a > 0.0 && b < 0.0) {
				let f = a / (a - b);
				(p[j * 3 + 2] + (p[i * 3 + 2] - p[j * 3 + 2]) * f, p[j * 3 + along] + (p[i * 3 + along] - p[j * 3 + along]) * f)
			} else {
				j = i;
				continue;
			};
			if z < lo {
				lo = z;
			}
			if z > hi {
				hi = z;
			}
			if at < p0 {
				p0 = at;
			}
			if at > p1 {
				p1 = at;
			}
			j = i;
		}
		if lo > hi {
			continue;
		}
		let mid = if axis == 1 { cu } else { cv };
		// axis 1 (line v = cv): E / W; axis 0 (line u = cu): S / N.
		if p1 >= mid {
			hf.add_wall(k, if axis == 1 { half::E } else { half::S }, lo, hi);
		}
		if p0 <= mid {
			hf.add_wall(k, if axis == 1 { half::W } else { half::N }, lo, hi);
		}
	}
}

// The z range where polygon `p` meets either centre line of its column
// (centre cu, cv) -> (lo, hi); None when it meets neither.
fn cross_range(p: &[f64; POLY], n: usize, cu: f64, cv: f64) -> Option<(f64, f64)> {
	let mut lo = f64::INFINITY;
	let mut hi = f64::NEG_INFINITY;
	for axis in 0..2 {
		let c = if axis == 0 { cu } else { cv };
		let mut j = n - 1;
		for i in 0..n {
			let a = p[j * 3 + axis] - c;
			let b = p[i * 3 + axis] - c;

			let z = if a == 0.0 {
				p[j * 3 + 2]
			} else if (a < 0.0 && b > 0.0) || (a > 0.0 && b < 0.0) {
				p[j * 3 + 2] + ((p[i * 3 + 2] - p[j * 3 + 2]) * a) / (a - b)
			} else {
				j = i;
				continue;
			};
			if z < lo {
				lo = z;
			}
			if z > hi {
				hi = z;
			}
			j = i;
		}
	}
	if lo > hi {
		return None;
	}
	Some((lo, hi))
}

const DEG: f64 = 180.0 / std::f64::consts::PI;
/// Polygon buffers (the JS's Float64Array(36): a triangle clipped by 4 planes has at most 7 vertices).
const POLY: usize = 36;
const DBUF: usize = 12;

/// geom: tris (wx, wy, z) x 3 per triangle, kind; openings carved after the triangles.
pub fn rasterise(geom: &Geometry) -> Heightfield {
	rasterise_tris(&geom.tris, &geom.kind, &geom.openings, geom.col, geom.row)
}

/// rasterise() of the given triangles (the JS's `rasterise({ tris, kind, openings }, { col, row })`).
pub fn rasterise_tris(tris: &[f32], kind: &[u8], openings: &[Cut], col: i32, row: i32) -> Heightfield {
	let count = kind.len();
	let mut hf = Heightfield::new((1usize << 16).max((1usize << 22).min(count * 2)));
	let tc = TILE_CELLS as f64;
	let west = (32.0 - f64::from(col)) * ADT;
	let north = (32.0 - f64::from(row)) * ADT;
	let inv = 1.0 / CELL;
	// Polygon buffers: a triangle clipped by 4 planes has at most 7 vertices.
	let mut poly = [0f64; POLY];
	let mut rest = [0f64; POLY];
	let mut row_poly = [0f64; POLY];
	let mut row_rest = [0f64; POLY];
	let mut cell_poly = [0f64; POLY];
	let mut d = [0f64; DBUF];
	let tr = |i: usize| f64::from(tris[i]);
	for t in 0..count {
		let o = t * 9;
		// Local (u east, v south, z) in cells.
		let u0 = (west - tr(o + 1)) * inv;
		let v0 = (north - tr(o)) * inv;
		let u1 = (west - tr(o + 4)) * inv;
		let v1 = (north - tr(o + 3)) * inv;
		let u2 = (west - tr(o + 7)) * inv;
		let v2 = (north - tr(o + 6)) * inv;
		let vmin = fmath::min(fmath::min(v0, v1), v2);
		let vmax = fmath::max(fmath::max(v0, v1), v2);
		let umin = fmath::min(fmath::min(u0, u1), u2);
		let umax = fmath::max(fmath::max(u0, u1), u2);
		if vmax < 0.0 || vmin >= tc || umax < 0.0 || umin >= tc {
			continue;
		}
		// Slope from the world-space normal.
		let ax = tr(o + 3) - tr(o);
		let ay = tr(o + 4) - tr(o + 1);
		let az = tr(o + 5) - tr(o + 2);
		let bx = tr(o + 6) - tr(o);
		let by = tr(o + 7) - tr(o + 1);
		let bz = tr(o + 8) - tr(o + 2);
		let nx = ay * bz - az * by;
		let ny = az * bx - ax * bz;
		let nz = ax * by - ay * bx;
		let len = (nx * nx + ny * ny + nz * nz).sqrt();
		if !(len > 1e-9) {
			continue;
		}
		let slope = fmath::min(90.0, fmath::round(fmath::acos(fmath::min(1.0, nz.abs() / len)) * DEG));
		let kd = kind[t];
		let wall = kd != 0 && (slope >= WALL_MIN || (crate::geom::kind::is_walkway(kd) && slope > WALK_MAX));
		let steep = kd != 0 && slope > WALK_MAX;
		let slope8 = slope as u8;
		poly[0] = u0;
		poly[1] = v0;
		poly[2] = tr(o + 2);
		poly[3] = u1;
		poly[4] = v1;
		poly[5] = tr(o + 5);
		poly[6] = u2;
		poly[7] = v2;
		poly[8] = tr(o + 8);
		let mut n = 3;
		let y0 = fmath::max(-1.0, fmath::min(tc - 1.0, vmin.floor())) as i64;
		let y1 = fmath::max(0.0, fmath::min(tc - 1.0, vmax.floor())) as i64;
		for y in y0..=y1 {
			let (n_row, nb) = divide(&poly, n, &mut row_poly, &mut rest, (y + 1) as f64, 1, &mut d);
			n = nb;
			std::mem::swap(&mut poly, &mut rest);
			if n_row < 3 || y < 0 {
				continue;
			}
			let mut rmin = row_poly[0];
			let mut rmax = row_poly[0];
			for i in 1..n_row {
				let x = row_poly[i * 3];
				if x < rmin {
					rmin = x;
				}
				if x > rmax {
					rmax = x;
				}
			}
			if rmax < 0.0 || rmin >= tc {
				continue;
			}
			let x0 = fmath::max(-1.0, fmath::min(tc - 1.0, rmin.floor())) as i64;
			let x1 = fmath::max(0.0, fmath::min(tc - 1.0, rmax.floor())) as i64;
			let mut m = n_row;
			for x in x0..=x1 {
				let (nc, mb) = divide(&row_poly, m, &mut cell_poly, &mut row_rest, (x + 1) as f64, 0, &mut d);
				m = mb;
				std::mem::swap(&mut row_poly, &mut row_rest);
				if nc < 3 || x < 0 {
					continue;
				}
				let k = y as usize * TILE_CELLS + x as usize;
				let cu = x as f64 + 0.5;
				let cv = y as f64 + 0.5;
				if wall {
					cross_walls(&mut hf, k, &cell_poly, nc, cu, cv);
					continue;
				}
				let mut lo = cell_poly[2];
				let mut hi = cell_poly[2];
				if steep {
					let Some((a, b)) = cross_range(&cell_poly, nc, cu, cv) else { continue };
					lo = a;
					hi = b;
				} else {
					for i in 1..nc {
						let z = cell_poly[i * 3 + 2];
						if z < lo {
							lo = z;
						}
						if z > hi {
							hi = z;
						}
					}
				}
				hf.add(k, lo, hi, slope8, kd, if kd == 0 { slope8 } else { 0 });
			}
		}
	}
	for cut in openings {
		carve_opening(&mut hf, cut, west, north, inv);
	}
	hf
}

// One reviewed opening { pts: [wx, wy] x 4 (a convex footprint), zlo, zhi }:
// carves every column of the tile whose centre lies inside the footprint.
fn carve_opening(hf: &mut Heightfield, cut: &Cut, west: f64, north: f64, inv: f64) {
	let q: Vec<[f64; 2]> = cut.pts.iter().map(|&[wx, wy]| [(west - wy) * inv, (north - wx) * inv]).collect();
	let fold = |f: fn(f64, f64) -> f64, init: f64, i: usize| q.iter().fold(init, |acc, p| f(acc, p[i]));
	let tc1 = TILE_CELLS as f64 - 1.0;
	let x0 = fmath::max(0.0, fold(fmath::min, f64::INFINITY, 0).floor());
	let x1 = fmath::min(tc1, fold(fmath::max, f64::NEG_INFINITY, 0).floor());
	let y0 = fmath::max(0.0, fold(fmath::min, f64::INFINITY, 1).floor());
	let y1 = fmath::min(tc1, fold(fmath::max, f64::NEG_INFINITY, 1).floor());
	if !(x0 <= x1 && y0 <= y1) {
		return;
	}
	for y in y0 as i64..=y1 as i64 {
		for x in x0 as i64..=x1 as i64 {
			let cu = x as f64 + 0.5;
			let cv = y as f64 + 0.5;
			let mut pos = 0;
			let mut neg = 0;
			for i in 0..q.len() {
				let [au, av] = q[i];
				let [bu, bv] = q[(i + 1) % q.len()];
				let cross = (bu - au) * (cv - av) - (bv - av) * (cu - au);
				if cross > 0.0 {
					pos += 1;
				} else if cross < 0.0 {
					neg += 1;
				}
			}
			if pos != 0 && neg != 0 {
				continue;
			}
			hf.carve(y as usize * TILE_CELLS + x as usize, cut.zlo + CUT_FLOOR, cut.zhi);
		}
	}
}
