//! Which grid columns of a continent the walking maps count as road: a port of
//! tools/lib/nav/roadmask.js (kept verbatim beside this file as `roadmask.js`: the road mask tag
//! hashes it, so grids Node prepared keep their file names and the walk stores their keys).
//!
//! The roads layer holds raw weights, 0-255 per column; the client paints roads thin and blends
//! their edges, and a road's texture fades out in places, so a plain threshold leaves a road in
//! pieces a route will not follow:
//! - hysteresis: a column is road at weight STRONG, or at WEAK when 8-connected through columns of
//!   at least WEAK to a STRONG one;
//! - gap bridging: the ends of two road pieces within BRIDGE_YD of each other are joined (a band
//!   BAND columns wide along the straight segment between them) when the pieces run on towards
//!   each other (the ends' outward directions oppose: cosine at least AGREE, and each looks across
//!   the gap: cosine at least AHEAD) and the grid walks the straight segment dry (path.js lineRuns:
//!   no swim on it).
//!
//! A piece's tips: the column farthest from any other, then every local maximum of the walked
//! distance from it, at least TIP_GAP columns apart. An end lies at the centroid of the piece's
//! columns under DIR_NEAR (walked) from a tip, its direction from the centroid of those DIR_NEAR to
//! DIR_FAR away. Every order (tiles, queues, pairs) is the JS's, so the mask is byte-identical.

use crate::grid::{cell_centre, cls, flag, Grid, CELL, DIRS, NO_LINK, TILE_CELLS};
use crate::legs::{Nav, SnapAsk, Snapped};
use forge_core::jsnum::{js_hypot, js_round};
use rustc_hash::{FxHashMap, FxHashSet};

pub const STRONG: u8 = 128;
pub const WEAK: u8 = 32;
const BRIDGE_YD: f64 = 100.0;
const AGREE: f64 = 0.7;
const AHEAD: f64 = 0.5;
const BAND: i64 = 1;
const MIN_PIECE: usize = 8;
const TIP_GAP: f64 = 12.0;
const DIR_NEAR: u32 = 6;
const DIR_FAR: u32 = 20;
const SPAN: i64 = 1 << 14;
const N8: [(i64, i64); 8] = [(1, 0), (1, 1), (0, 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1)];

#[derive(Clone, Copy, Debug, Default)]
pub struct RoadStats {
	pub strong: usize,
	pub weak: usize,
	pub pieces: usize,
	pub ends: usize,
	pub bridges: usize,
	pub bridged_columns: usize,
	pub refused: usize,
}

struct End {
	piece: usize,
	gx: i64,
	gy: i64,
	dx: f64,
	dy: f64,
}

/// One tile's road columns (1 road; index j * 256 + i) per tile with weights, in `tiles` order.
pub struct Mask {
	pub tiles: Vec<((u32, u32), Vec<u8>)>,
	pub stats: RoadStats,
}

#[inline]
fn gxy(n: i64) -> (i64, i64) {
	(n % SPAN, n.div_euclid(SPAN))
}

/// roadMask: `tiles` (col, row) in the grid index's order, `weights` each tile's 65536 weights
/// (None: no roads layer tile), `nav` the grid for the bridges' walkability (None: every bridge).
pub fn road_mask(c: u32, tiles: &[(u32, u32)], weights: impl Fn(u32, u32) -> Option<Vec<u8>>, nav: Option<&Nav>) -> Mask {
	let mut w: Vec<((u32, u32), Vec<u8>)> = Vec::new();
	for &(col, row) in tiles {
		if let Some(v) = weights(col, row) {
			w.push(((col, row), v));
		}
	}
	let at_of: FxHashMap<(u32, u32), usize> = w.iter().enumerate().map(|(i, (k, _))| (*k, i)).collect();
	let mut mask: Vec<Vec<u8>> = w.iter().map(|_| vec![0u8; TILE_CELLS * TILE_CELLS]).collect();
	let at = |gx: i64, gy: i64| -> Option<(usize, usize)> {
		if gx < 0 || gy < 0 {
			return None;
		}
		let t = *at_of.get(&((gx >> 8) as u32, (gy >> 8) as u32))?;
		Some((t, ((gy & 255) * TILE_CELLS as i64 + (gx & 255)) as usize))
	};
	let weight = |gx: i64, gy: i64| at(gx, gy).map_or(0, |(t, k)| w[t].1[k]);
	let is_road = |mask: &Vec<Vec<u8>>, gx: i64, gy: i64| at(gx, gy).is_some_and(|(t, k)| mask[t][k] == 1);
	let set_road = |mask: &mut Vec<Vec<u8>>, gx: i64, gy: i64| -> bool {
		match at(gx, gy) {
			Some((t, k)) if mask[t][k] == 0 => {
				mask[t][k] = 1;
				true
			}
			_ => false,
		}
	};
	let mut stats = RoadStats::default();
	// (a) Hysteresis: from every strong column through columns of at least WEAK.
	let mut queue: Vec<i64> = Vec::new();
	for (ti, ((col, row), wt)) in w.iter().enumerate() {
		for (k, &v) in wt.iter().enumerate() {
			if v < STRONG {
				continue;
			}
			mask[ti][k] = 1;
			stats.strong += 1;
			queue.push((*row as i64 * TILE_CELLS as i64 + (k >> 8) as i64) * SPAN + *col as i64 * TILE_CELLS as i64 + (k & 255) as i64);
		}
	}
	let mut q = 0;
	while q < queue.len() {
		let (gx, gy) = gxy(queue[q]);
		for (dx, dy) in N8 {
			if weight(gx + dx, gy + dy) >= WEAK && set_road(&mut mask, gx + dx, gy + dy) {
				stats.weak += 1;
				queue.push((gy + dy) * SPAN + gx + dx);
			}
		}
		q += 1;
	}
	// (b) Pieces (8-connected), their ends and the ends' outward directions.
	// bfs -> (order, dist by node), dist in order's order.
	let bfs = |start: i64, in_piece: &dyn Fn(i64) -> bool, limit: u32| -> (Vec<i64>, FxHashMap<i64, u32>) {
		let mut dist: FxHashMap<i64, u32> = FxHashMap::default();
		dist.insert(start, 0);
		let mut order = vec![start];
		let mut q = 0;
		while q < order.len() {
			let d = dist[&order[q]];
			if d < limit {
				let (gx, gy) = gxy(order[q]);
				for (dx, dy) in N8 {
					let n = (gy + dy) * SPAN + gx + dx;
					if !dist.contains_key(&n) && in_piece(n) {
						dist.insert(n, d + 1);
						order.push(n);
					}
				}
			}
			q += 1;
		}
		(order, dist)
	};
	let mut seen: FxHashSet<i64> = FxHashSet::default();
	let mut ends: Vec<End> = Vec::new();
	for &seed in &queue {
		if seen.contains(&seed) {
			continue;
		}
		let (piece, _) = {
			let m = &mask;
			let s = &seen;
			bfs(
				seed,
				&|n: i64| {
					let (x, y) = gxy(n);
					!s.contains(&n) && is_road(m, x, y)
				},
				u32::MAX,
			)
		};
		for &n in &piece {
			seen.insert(n);
		}
		stats.pieces += 1;
		if piece.len() < MIN_PIECE {
			continue;
		}
		let members: FxHashSet<i64> = piece.iter().copied().collect();
		let in_piece = |n: i64| members.contains(&n);
		let a = *bfs(piece[0], &in_piece, u32::MAX).0.last().unwrap();
		let (_, dist) = bfs(a, &in_piece, u32::MAX);
		let mut tips = vec![a];
		let mut maxima: Vec<i64> = piece
			.iter()
			.copied()
			.filter(|&n| {
				let (gx, gy) = gxy(n);
				N8.iter().all(|&(dx, dy)| {
					let m = (gy + dy) * SPAN + gx + dx;
					!members.contains(&m) || dist[&m] <= dist[&n]
				})
			})
			.collect();
		maxima.sort_by(|p, q| dist[q].cmp(&dist[p]).then(p.cmp(q)));
		for &n in &maxima {
			let (gx, gy) = gxy(n);
			if tips.iter().all(|&t| {
				let (tx, ty) = gxy(t);
				js_hypot((tx - gx) as f64, (ty - gy) as f64) >= TIP_GAP
			}) {
				tips.push(n);
			}
		}
		for &t in &tips {
			let (order, dist) = bfs(t, &in_piece, DIR_FAR);
			let mut near = [0f64; 3];
			let mut far = [0f64; 3];
			for n in &order {
				let s = if dist[n] < DIR_NEAR { &mut near } else { &mut far };
				let (gx, gy) = gxy(*n);
				s[0] += gx as f64;
				s[1] += gy as f64;
				s[2] += 1.0;
			}
			if far[2] == 0.0 {
				continue;
			}
			let ex = near[0] / near[2];
			let ey = near[1] / near[2];
			let vx = ex - far[0] / far[2];
			let vy = ey - far[1] / far[2];
			let len = js_hypot(vx, vy);
			if len < 1e-9 {
				continue;
			}
			ends.push(End { piece: stats.pieces, gx: js_round(ex) as i64, gy: js_round(ey) as i64, dx: vx / len, dy: vy / len });
		}
	}
	stats.ends = ends.len();
	// Bridges: candidate pairs, nearest first, each end used once.
	let bridge = (BRIDGE_YD / CELL).floor();
	let cell = |g: i64| (g as f64 / bridge).floor() as i64;
	let mut grid: FxHashMap<(i64, i64), Vec<usize>> = FxHashMap::default();
	for (i, e) in ends.iter().enumerate() {
		grid.entry((cell(e.gx), cell(e.gy))).or_default().push(i);
	}
	let mut pairs: Vec<(f64, usize, usize)> = Vec::new();
	for (i, e) in ends.iter().enumerate() {
		let (bx, by) = (cell(e.gx), cell(e.gy));
		for x in bx - 1..=bx + 1 {
			for y in by - 1..=by + 1 {
				for &j in grid.get(&(x, y)).map(|v| v.as_slice()).unwrap_or(&[]) {
					let f = &ends[j];
					if j <= i || f.piece == e.piece {
						continue;
					}
					let gap = js_hypot((f.gx - e.gx) as f64, (f.gy - e.gy) as f64);
					if gap > bridge || gap < 1.0 {
						continue;
					}
					let ux = (f.gx - e.gx) as f64 / gap;
					let uy = (f.gy - e.gy) as f64 / gap;
					if -(e.dx * f.dx + e.dy * f.dy) < AGREE || e.dx * ux + e.dy * uy < AHEAD || -(f.dx * ux + f.dy * uy) < AHEAD {
						continue;
					}
					pairs.push((gap, i, j));
				}
			}
		}
	}
	pairs.sort_by(|p, q| p.0.partial_cmp(&q.0).unwrap().then(p.1.cmp(&q.1)).then(p.2.cmp(&q.2)));
	let mut used: FxHashSet<usize> = FxHashSet::default();
	let snap = |nav: &Nav, gx: i64, gy: i64| {
		let (wx, wy) = cell_centre(gx >> 8, gy >> 8, gx & 255, gy & 255);
		nav.snap(&SnapAsk { c, wx, wy, z: None, radius: 4.0, under: false, stand: false })
	};
	for &(gap, i, j) in &pairs {
		if used.contains(&i) || used.contains(&j) {
			continue;
		}
		let (e, f) = (&ends[i], &ends[j]);
		if let Some(nav) = nav {
			// Walkable straight across, dry all the way: a gap over a river or a lake is no road.
			let a = snap(nav, e.gx, e.gy);
			let b = snap(nav, f.gx, f.gy);
			let swims = match (a, b) {
				(Some(a), Some(b)) if (a.flags | b.flags) & flag::SWIM == 0 => line_swims(&nav.grid, &a, &b),
				_ => None,
			};
			if swims != Some(false) {
				stats.refused += 1;
				continue;
			}
		}
		used.insert(i);
		used.insert(j);
		stats.bridges += 1;
		let steps = (gap * 2.0).ceil();
		let mut s = 0.0;
		while s <= steps {
			let x = js_round(e.gx as f64 + ((f.gx - e.gx) as f64 * s) / steps) as i64;
			let y = js_round(e.gy as f64 + ((f.gy - e.gy) as f64 * s) / steps) as i64;
			for ox in -BAND..=BAND {
				for oy in -BAND..=BAND {
					if set_road(&mut mask, x + ox, y + oy) {
						stats.bridged_columns += 1;
					}
				}
			}
			s += 1.0;
		}
	}
	Mask { tiles: w.into_iter().map(|(k, _)| k).zip(mask).collect(), stats }
}

/// path.js lineRuns as roadMask asks it: the straight line from a to b stepped cell to cell through
/// links (walk, steep, swim; no jumps or falls; Amanatides-Woo, centre to centre) -> None when it is
/// no straight walkable line, else whether any step swims.
pub fn line_swims(grid: &Grid, a: &Snapped, b: &Snapped) -> Option<bool> {
	if a.c != b.c {
		return None;
	}
	let (c0, c1) = (a.col.min(b.col) as i64, a.col.max(b.col) as i64);
	let (r0, r1) = (a.row.min(b.row) as i64, a.row.max(b.row) as i64);
	let tile = |col: i64, row: i64| if (c0..=c1).contains(&col) && (r0..=r1).contains(&row) { grid.tile(a.c, col, row) } else { None };
	let mut t = tile(a.col as i64, a.row as i64)?;
	tile(b.col as i64, b.row as i64)?;
	let mut x = a.col as i64 * 256 + a.i as i64;
	let mut y = a.row as i64 * 256 + a.j as i64;
	let x1 = b.col as i64 * 256 + b.i as i64;
	let y1 = b.row as i64 * 256 + b.j as i64;
	let (dx, dy) = (x1 - x, y1 - y);
	let (sx, sy) = (dx.signum(), dy.signum());
	let (adx, ady) = (dx.abs() as f64, dy.abs() as f64);
	let tdx = if adx != 0.0 { 1.0 / adx } else { f64::INFINITY };
	let tdy = if ady != 0.0 { 1.0 / ady } else { f64::INFINITY };
	let mut tmx = if adx != 0.0 { 0.5 / adx } else { f64::INFINITY };
	let mut tmy = if ady != 0.0 { 0.5 / ady } else { f64::INFINITY };
	let (mut col, mut row) = (a.col as i64, a.row as i64);
	let mut e = a.entry as usize;
	let mut k = a.k();
	let mut swims = false;
	while x != x1 || y != y1 {
		let (mut mx, mut my) = (0i64, 0i64);
		if (tmx - tmy).abs() < 1e-9 {
			mx = sx;
			my = sy;
			tmx += tdx;
			tmy += tdy;
		} else if tmx < tmy {
			mx = sx;
			tmx += tdx;
		} else {
			my = sy;
			tmy += tdy;
		}
		let d = DIRS.iter().rposition(|&(qx, qy)| qx as i64 == mx && qy as i64 == my)?;
		let l = t.links[e * 8 + d];
		if l == NO_LINK || l >> 5 == cls::JUMP {
			return None;
		}
		let (i, j) = ((k & 255) as i64 + mx, (k >> 8) as i64 + my);
		let dc = if i < 0 {
			-1
		} else if i >= TILE_CELLS as i64 {
			1
		} else {
			0
		};
		let dr = if j < 0 {
			-1
		} else if j >= TILE_CELLS as i64 {
			1
		} else {
			0
		};
		if dc != 0 || dr != 0 {
			t = tile(col + dc, row + dr)?;
			col += dc;
			row += dr;
		}
		let k2 = ((j - dr * TILE_CELLS as i64) * TILE_CELLS as i64 + (i - dc * TILE_CELLS as i64)) as usize;
		let v = t.first[k2] as usize + (l & 31) as usize;
		if l >> 5 == cls::SWIM {
			swims = true;
		}
		x += mx;
		y += my;
		e = v;
		k = k2;
	}
	(col == b.col as i64 && row == b.row as i64 && e == b.entry as usize).then_some(swims)
}
