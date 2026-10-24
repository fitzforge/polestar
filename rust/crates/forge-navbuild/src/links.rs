//! Links between a tile's walkable entries and their neighbours, and falls (port of
//! tools/lib/nav/grid/links.js; its header documents the rules: neighbour links by gradient and
//! slope class, staircases, walls on half-lines, falls with slides onto stable ground).
//!
//! around: the 3 x 3 tiles centred on the tile, index (drow + 1) * 3 + (dcol + 1), None where
//! there is none; a tile's `walls` may be None.

use crate::fmath;
use crate::format::{
	cls, flag, half, wall_blocks, Tile, AGENT_HEIGHT, CELL, CLIMB_MAX, DIRS, FALL_MAX, FALL_MAX_WATER, FALL_REACH, FALL_SLIDE, GENTLE_MAX, JUMP, LINK_SLOPE, NO_LINK, STAIR_MAX, STEEP_MAX, STEP,
	TILE_CELLS, WALK_MAX,
};
use std::sync::OnceLock;

/// yd between neighbouring swim surfaces (sloping rivers).
pub const SWIM_STEP: f64 = 2.0;
/// Fall target offsets per axis.
pub const FALL_SPAN: i32 = 2 * FALL_SLIDE as i32 + 1;
const RAD: f64 = std::f64::consts::PI / 180.0;
const ORTHO: [usize; 4] = [0, 2, 4, 6];
const DIAG: [usize; 4] = [1, 3, 5, 7];

/// For diagonal d: the two orthogonal directions it needs.
pub fn sides(d: usize) -> [usize; 2] {
	match d {
		1 => [0, 2],
		3 => [4, 2],
		5 => [4, 6],
		_ => [0, 6],
	}
}

struct Tans {
	tan: [f64; 91],
	gentle: f64,
	walk: f64,
	steep: f64,
	climb: f64,
	stair: f64,
}

fn tans() -> &'static Tans {
	static T: OnceLock<Tans> = OnceLock::new();
	T.get_or_init(|| Tans {
		tan: std::array::from_fn(|d| if d >= 90 { 1e9 } else { fmath::tan(d as f64 * RAD) }),
		gentle: fmath::tan(GENTLE_MAX * RAD),
		walk: fmath::tan(WALK_MAX * RAD),
		steep: fmath::tan(STEEP_MAX * RAD),
		climb: fmath::tan(CLIMB_MAX * RAD),
		stair: fmath::tan(STAIR_MAX * RAD),
	})
}

/// The tile and column k of column (i, j) relative to the centre tile (resolver()).
pub fn resolve<'a>(around: &[Option<&'a Tile>; 9], i: i32, j: i32) -> Option<(&'a Tile, usize)> {
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
	if i < -tc || j < -tc || i >= 2 * tc || j >= 2 * tc {
		return None;
	}
	let t = around[((dr + 1) * 3 + (dc + 1)) as usize]?;
	Some((t, ((j - dr * tc) * tc + (i - dc * tc)) as usize))
}

fn is_terrain(f: u8) -> bool {
	f & (flag::TERRAIN | flag::SWIM) == flag::TERRAIN
}

/// The highest rise between the lower entry's height z_lo and the upper entry `up` over the
/// treads under it in its column.
fn tread_rise(zs: &[f32], first: usize, up: usize, z_lo: f64) -> f64 {
	let mut rise = 0.0;
	let mut prev = f64::from(zs[up]);
	let mut w = up as isize - 1;
	while w >= first as isize && f64::from(zs[w as usize]) > z_lo {
		let zw = f64::from(zs[w as usize]);
		if prev - zw > rise {
			rise = prev - zw;
		}
		prev = zw;
		w -= 1;
	}
	fmath::max(rise, prev - z_lo)
}

/// The highest rise under the top tread (0 with no tread between).
fn lower_rise(zs: &[f32], first: usize, up: usize, z_lo: f64) -> f64 {
	if up > first && f64::from(zs[up - 1]) > z_lo {
		tread_rise(zs, first, up - 1, z_lo)
	} else {
		0.0
	}
}

/// The link code from an entry (fa, sa) to one (fb, sb), height change dz over horizontal h;
/// None when there is none.
pub fn link_class(fa: u8, sa: u8, fb: u8, sb: u8, dz: f64, h: f64, riser: f64, lower: f64) -> Option<u8> {
	let t = tans();
	let adz = dz.abs();
	if fa & fb & flag::SWIM != 0 {
		return (adz <= SWIM_STEP).then_some(cls::SWIM);
	}
	if is_terrain(fb) && f64::from(sb) > STEEP_MAX {
		return (dz > 0.0 && adz <= h * t.climb).then_some(cls::CLIMB);
	}
	if is_terrain(fa) && is_terrain(fb) {
		if adz <= fmath::max(STEP, h * t.gentle) {
			return Some(cls::WALK);
		}
		if adz <= h * t.walk {
			return Some(LINK_SLOPE);
		}
		if adz <= h * t.steep {
			return Some(cls::STEEP);
		}
		if adz <= h * t.climb {
			return (dz > 0.0).then_some(cls::CLIMB);
		}
		return (adz <= JUMP).then_some(cls::JUMP);
	}
	let sm = (WALK_MAX as u8).min(sa.max(sb)) as usize;
	if adz > fmath::max(STEP, h * t.tan[sm]) {
		if fa & fb & flag::WMO != 0 && (fa | fb) & flag::SWIM == 0 {
			// Onto a walkable model slope whose foot lies between the two columns: a step of up to
			// STEP, then the slope across the column (a stair's treads or a ramp's foot the column
			// centres miss: the Tirisfal zeppelin tower's top flight, 2.5 yd onto a 39 degree ramp;
			// the Ruins of Lordaeron's bell tower steps, a 0.4 yd riser and a 37 degree ramp). Only
			// between surfaces a stair could be (both at most STAIR_MAX) and no more than STEP + JUMP in
			// all (as steps and a jump): along a steeper model slope (a rock face, a roof) the slope rule
			// alone decides, and a short steep face over a high riser (a tree root's 42 degree flank 2.2
			// yd above the floor, 3.2 yd at the column centre) is no ramp. The tower's flight turns, so its
			// lower column is on the ramp too (38 degrees).
			let (up, low) = if dz > 0.0 { (sb, sa) } else { (sa, sb) };
			if f64::from(low.max(up)) <= STAIR_MAX && adz <= fmath::min(STEP + JUMP, STEP + h * t.tan[usize::from(up)]) {
				return Some(LINK_SLOPE);
			}
			if riser <= STEP && adz <= h * t.stair {
				return Some(LINK_SLOPE);
			}
			if lower <= STEP && riser <= JUMP && adz <= STEP + JUMP {
				return Some(cls::JUMP);
			}
		}
		return (adz <= JUMP).then_some(cls::JUMP);
	}
	Some(if (fa | fb) & flag::SWIM != 0 { cls::SWIM } else { cls::WALK })
}

/// link_tile's result.
pub struct LinkOut {
	pub links: Vec<u8>,
	pub fall_from: Vec<u32>,
	pub fall_to: Vec<u16>,
}

struct Ctx<'a, 'b> {
	around: &'b [Option<&'a Tile>; 9],
}

impl<'a> Ctx<'a, '_> {
	fn wall_at(&self, i: i32, j: i32, h: usize, lo: f64, hi: f64) -> bool {
		resolve(self.around, i, j).is_some_and(|(t, k2)| wall_blocks(t.walls.as_ref(), k2, h, lo, hi))
	}

	/// A wall between column (i, j) and its neighbour (i + dx, j + dy) within (lo, hi).
	fn walled(&self, i: i32, j: i32, dx: i32, dy: i32, lo: f64, hi: f64) -> bool {
		let hx = if dx > 0 { half::E } else { half::W };
		let hy = if dy > 0 { half::S } else { half::N };
		let ox = (hx + 2) & 3;
		let oy = (hy + 2) & 3;
		if dy == 0 {
			return self.wall_at(i, j, hx, lo, hi) || self.wall_at(i + dx, j, ox, lo, hi);
		}
		if dx == 0 {
			return self.wall_at(i, j, hy, lo, hi) || self.wall_at(i, j + dy, oy, lo, hi);
		}
		self.wall_at(i, j, hx, lo, hi)
			|| self.wall_at(i, j, hy, lo, hi)
			|| self.wall_at(i + dx, j, ox, lo, hi)
			|| self.wall_at(i + dx, j, hy, lo, hi)
			|| self.wall_at(i, j + dy, oy, lo, hi)
			|| self.wall_at(i, j + dy, hx, lo, hi)
			|| self.wall_at(i + dx, j + dy, ox, lo, hi)
			|| self.wall_at(i + dx, j + dy, oy, lo, hi)
	}

	/// Open at height zs: an entry at most a step up whose gap holds the body.
	fn open(&self, i: i32, j: i32, zs: f64) -> bool {
		let Some((t2, k2)) = resolve(self.around, i, j) else { return false };
		(t2.first[k2] as usize..t2.first[k2 + 1] as usize).any(|v| f64::from(t2.z[v]) <= zs + STEP && f64::from(t2.ceil[v]) >= zs + AGENT_HEIGHT)
	}

	/// Stable ground at entry v of column (i, j).
	fn stable(&self, i: i32, j: i32, t2: &Tile, v: usize) -> bool {
		if t2.flags[v] & flag::SWIM != 0 {
			return true;
		}
		if f64::from(t2.slope[v]) > STEEP_MAX {
			return false;
		}
		let zv = f64::from(t2.z[v]);
		let level = |di: i32, dj: i32| -> bool {
			if self.walled(i, j, di, dj, zv + STEP, zv + AGENT_HEIGHT) {
				return false;
			}
			let Some((t3, k3)) = resolve(self.around, i + di, j + dj) else { return false };
			(t3.first[k3] as usize..t3.first[k3 + 1] as usize).any(|w| t3.flags[w] & flag::BLOCKED == 0 && f64::from(t3.slope[w]) <= STEEP_MAX && (f64::from(t3.z[w]) - zv).abs() <= STEP)
		};
		for (a, b) in [(1, 1), (1, -1), (-1, 1), (-1, -1)] {
			if level(a, 0) && level(0, b) && level(a, b) {
				return true;
			}
		}
		false
	}

	/// The fall from (i, j) at height zs in direction (dx, dy): (reach, layer, z, swim).
	fn fall(&self, i: i32, j: i32, zs: f64, dx: i32, dy: i32) -> Option<(i32, u32, f64, bool)> {
		let mut top = zs;
		let mut reach = 1i32;
		let mut first_landing = true;
		while reach <= FALL_SLIDE as i32 {
			let ci = i + dx * reach;
			let cj = j + dy * reach;
			if self.walled(ci - dx, cj - dy, dx, dy, top + STEP, top + AGENT_HEIGHT) {
				return None;
			}
			let (t2, k2) = resolve(self.around, ci, cj)?;
			let mut land: isize = -1;
			let mut v = t2.first[k2 + 1] as isize - 1;
			while v >= t2.first[k2] as isize {
				let vu = v as usize;
				if f64::from(t2.z[vu]) < top + STEP && f64::from(t2.ceil[vu]) >= top + AGENT_HEIGHT {
					land = v;
					break;
				}
				v -= 1;
			}
			if land < 0 {
				return None;
			}
			let land = land as usize;
			if t2.flags[land] & flag::BLOCKED != 0 {
				if first_landing && reach >= FALL_REACH as i32 {
					return None;
				}
				reach += 1;
				continue;
			}
			let zl = f64::from(t2.z[land]);
			if first_landing && zl >= top - JUMP {
				return None;
			}
			if self.stable(ci, cj, t2, land) {
				return Some((reach, land as u32 - t2.first[k2], zl, t2.flags[land] & flag::SWIM != 0));
			}
			first_landing = false;
			top = zl;
			reach += 1;
		}
		None
	}
}

pub fn link_tile(around: &[Option<&Tile>; 9]) -> LinkOut {
	let t = around[4].expect("the centre tile");
	let cx = Ctx { around };
	let n = t.n;
	let mut links = vec![NO_LINK; 8 * n];
	let mut fall_from: Vec<u32> = Vec::new();
	let mut fall_to: Vec<u16> = Vec::new();
	let diag_h = CELL * std::f64::consts::SQRT_2;
	let (z, ceil, flags, first) = (&t.z, &t.ceil, &t.flags, &t.first);
	let link = |links: &mut Vec<u8>, s: usize, i: i32, j: i32, d: usize| {
		let [dx, dy] = DIRS[d];
		let Some((t2, k2)) = resolve(around, i + dx, j + dy) else { return };
		let zs = f64::from(z[s]);
		let cs = f64::from(ceil[s]);
		let mut best: isize = -1;
		let mut best_cls = 0u8;
		let mut best_abs = f64::INFINITY;
		let f2 = &t2.first;
		let h = if d & 1 == 1 { diag_h } else { CELL };
		let k_s = (j * TILE_CELLS as i32 + i) as usize;
		for v in f2[k2] as usize..f2[k2 + 1] as usize {
			if t2.flags[v] & flag::BLOCKED != 0 {
				continue;
			}
			let zv = f64::from(t2.z[v]);
			if fmath::min(cs, f64::from(t2.ceil[v])) - fmath::max(zs, zv) < AGENT_HEIGHT {
				continue;
			}
			let adz = (zv - zs).abs();
			if adz >= best_abs {
				continue;
			}
			let (riser, lower) = if zv > zs {
				(tread_rise(&t2.z, f2[k2] as usize, v, zs), lower_rise(&t2.z, f2[k2] as usize, v, zs))
			} else {
				(tread_rise(z, first[k_s] as usize, s, zv), lower_rise(z, first[k_s] as usize, s, zv))
			};
			let Some(c) = link_class(flags[s], t.slope[s], t2.flags[v], t2.slope[v], zv - zs, h, riser, lower) else { continue };
			let top = fmath::max(zs, zv);
			if cx.walled(i, j, dx, dy, top + STEP, top + AGENT_HEIGHT) {
				continue;
			}
			best_abs = adz;
			best = v as isize;
			best_cls = c;
		}
		if best < 0 {
			return;
		}
		links[s * 8 + d] = ((u32::from(best_cls) << 5) | (best as u32 - f2[k2])) as u8;
	};
	for k in 0..TILE_CELLS * TILE_CELLS {
		let i = (k & 255) as i32;
		let j = (k >> 8) as i32;
		for s in first[k] as usize..first[k + 1] as usize {
			if flags[s] & flag::BLOCKED != 0 {
				continue;
			}
			for d in ORTHO {
				link(&mut links, s, i, j, d);
			}
			for d in DIAG {
				let [a, b] = sides(d);
				if links[s * 8 + a] != NO_LINK && links[s * 8 + b] != NO_LINK {
					link(&mut links, s, i, j, d);
				}
			}
			if flags[s] & flag::SWIM != 0 {
				continue;
			}
			let zs = f64::from(z[s]);
			for d in 0..8 {
				if links[s * 8 + d] != NO_LINK {
					continue;
				}
				let [dx, dy] = DIRS[d];
				if d & 1 == 1 {
					let [a, b] = sides(d);
					if !cx.open(i + DIRS[a][0], j + DIRS[a][1], zs) || !cx.open(i + DIRS[b][0], j + DIRS[b][1], zs) {
						continue;
					}
				}
				let Some((reach, v, fz, swim)) = cx.fall(i, j, zs, dx, dy) else { continue };
				let h = zs - fz;
				if h <= JUMP || h > (if swim { FALL_MAX_WATER } else { FALL_MAX }) {
					continue;
				}
				fall_from.push(s as u32);
				let fs = FALL_SLIDE as i32;
				fall_to.push(((((dx * reach + fs) * FALL_SPAN + (dy * reach + fs)) << 5) as u32 | v) as u16);
			}
		}
	}
	LinkOut { links, fall_from, fall_to }
}

/// Decodes a fall target -> (di, dj, layer).
pub fn fall_target(code: u16) -> (i32, i32, u32) {
	let off = i32::from(code >> 5);
	(off.div_euclid(FALL_SPAN) - FALL_SLIDE as i32, off % FALL_SPAN - FALL_SLIDE as i32, u32::from(code & 31))
}
