//! Solid spans -> a column's entries (port of tools/lib/nav/grid/surfaces.js; format.js TILE):
//! every span top, with the gap above it (`ceil`), walkable when its slope is at most CLIMB_MAX
//! (terrain) or WALK_MAX (WMO and M2 surfaces; steeper terrain is STEEP) and the gap is at least
//! AGENT_HEIGHT (else BLOCKED). Liquids (MH2O, per quad of 2 x 2 columns): the entry whose gap
//! holds the liquid's surface is its floor; water or ocean at least SWIM_DEPTH above the floor
//! (or with no floor) turns it into a swim surface at the liquid's height; magma and slime block
//! their floor at any depth. Fatigue water (MH2O's deep quads) is a swim surface that is BLOCKED.
//! Each entry keeps the steepest terrain triangle of its span (`tslope`) when its surface is
//! terrain, 0 on model and swim surfaces.

use crate::format::{first_of, flag, Tile, AGENT_HEIGHT, CLIMB_MAX, COLUMNS, MAX_LAYERS, SWIM_DEPTH, WALK_MAX};
use crate::geom::{liquid, Geometry};
use crate::rasterise::{rasterise_tris, Heightfield};

/// geom KIND -> flags (a walkway's surfaces are its model's).
const KIND_FLAGS: [u8; 7] = [flag::TERRAIN, flag::WMO, flag::WMO | flag::INDOOR, flag::M2, flag::M2, flag::WMO, flag::WMO | flag::INDOOR];

/// buildSurfaces' stats.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct SurfaceStats {
	pub entries: usize,
	pub walkable: usize,
	pub swim: usize,
	pub dropped: usize,
}

/// hf: rasterise()'s Heightfield; geom: tileGeometry's -> (tile without links, with walls; stats).
/// WMO liquids (city canals, the forge's lava) are rasterised like the collision; each column
/// takes the highest liquid surface over it and applies it as MH2O's.
pub fn build_surfaces(mut hf: Heightfield, geom: &Geometry) -> (Tile, SurfaceStats) {
	let wmo_liquid = wmo_liquid_columns(geom);
	let mut count = vec![0u8; COLUMNS];
	let cap = (1usize << 16).max(hf.used + 4096);
	let mut z: Vec<f32> = Vec::with_capacity(cap);
	let mut ceil: Vec<f32> = Vec::with_capacity(cap);
	let mut flags: Vec<u8> = Vec::with_capacity(cap);
	let mut slope: Vec<u8> = Vec::with_capacity(cap);
	let mut tslope: Vec<u8> = Vec::with_capacity(cap);
	let (mut dropped, mut walkable, mut swim) = (0usize, 0usize, 0usize);
	let liq = (!geom.liquid.ty.is_empty()).then_some(&geom.liquid);
	let mut cz = [0f32; 256];
	let mut cc = [0f32; 256];
	let mut cf = [0u8; 256];
	let mut cs = [0u8; 256];
	let mut ct = [0u8; 256];
	for k in 0..COLUMNS {
		let mut m = 0usize;
		let mut first_bottom = f32::INFINITY;
		let mut s = hf.head[k];
		while s != -1 {
			let su = s as usize;
			if m == 0 {
				first_bottom = hf.smin[su];
			}
			if m == cz.len() {
				break;
			}
			let nx = hf.next[su];
			let top = hf.smax[su];
			let gap = if nx == -1 { f32::INFINITY } else { hf.smin[nx as usize] };
			let sl = hf.slope[su];
			let kd = hf.kind[su];
			let mut f = KIND_FLAGS.get(kd as usize).copied().unwrap_or(0);
			if f64::from(sl) > WALK_MAX {
				f |= flag::STEEP;
			}
			if f64::from(sl) > (if kd == 0 { CLIMB_MAX } else { WALK_MAX }) || f64::from(gap) - f64::from(top) < AGENT_HEIGHT {
				f |= flag::BLOCKED;
			}
			cz[m] = top;
			cc[m] = gap;
			cf[m] = f;
			cs[m] = sl;
			ct[m] = if kd == 0 { hf.tslope[su] } else { 0 };
			m += 1;
			s = nx;
		}
		let mut apply = |ty: u8, lz: f32, deep: u8, m: &mut usize| {
			let mut e: isize = -1;
			for x in (0..*m).rev() {
				if cz[x] <= lz && lz <= cc[x] {
					e = x as isize;
					break;
				}
			}
			let wet = |ty: u8, deep: u8| flag::SWIM | if ty == liquid::OCEAN { flag::OCEAN } else { 0 } | if deep != 0 { flag::BLOCKED } else { 0 };
			if ty == liquid::MAGMA || ty == liquid::SLIME {
				if e >= 0 && lz > cz[e as usize] {
					cf[e as usize] |= flag::BLOCKED;
				}
			} else if e >= 0 {
				let e = e as usize;
				if f64::from(lz) - f64::from(cz[e]) >= SWIM_DEPTH {
					cz[e] = lz;
					cs[e] = 0;
					ct[e] = 0;
					cf[e] = (cf[e] & (flag::INDOOR | flag::WMO | flag::M2 | flag::TERRAIN)) | wet(ty, deep);
				}
			} else if *m == 0 || lz < first_bottom {
				// No floor under the liquid: a swim surface below every span. (A full column of
				// 256 spans has no room: the JS typed array drops the write past its end.)
				for x in (1..=*m).rev() {
					if x < 256 {
						cz[x] = cz[x - 1];
						cc[x] = cc[x - 1];
						cf[x] = cf[x - 1];
						cs[x] = cs[x - 1];
						ct[x] = ct[x - 1];
					}
				}
				cz[0] = lz;
				cc[0] = if *m > 0 { first_bottom } else { f32::INFINITY };
				cf[0] = wet(ty, deep);
				cs[0] = 0;
				ct[0] = 0;
				*m += 1;
			}
		};
		if let Some(l) = liq {
			let q = ((k >> 8) >> 1) * 128 + ((k & 255) >> 1);
			if l.ty[q] != liquid::NONE {
				apply(l.ty[q], l.z[q], l.deep.get(q).copied().unwrap_or(0), &mut m);
			}
		}
		if let Some((wt, wz)) = &wmo_liquid {
			if wt[k] != liquid::NONE {
				apply(wt[k], wz[k], 0, &mut m);
			}
		}
		if m > MAX_LAYERS {
			dropped += m - MAX_LAYERS;
			m = MAX_LAYERS;
		}
		for x in 0..m {
			z.push(cz[x]);
			ceil.push(cc[x]);
			flags.push(cf[x]);
			slope.push(cs[x]);
			tslope.push(ct[x]);
			if cf[x] & flag::BLOCKED == 0 {
				walkable += 1;
			}
			if cf[x] & flag::SWIM != 0 {
				swim += 1;
			}
		}
		count[k] = m as u8;
	}
	let mut areas = vec![0u16; 256];
	for (a, &v) in areas.iter_mut().zip(&geom.areas) {
		*a = v;
	}
	let n = z.len();
	let first = first_of(&count);
	let walls = hf.walls();
	let tile = Tile { c: geom.c, col: geom.col, row: geom.row, n, count, first, z, ceil, flags, slope, tslope: Some(tslope), areas, walls: Some(walls), ..Tile::default() };
	(tile, SurfaceStats { entries: n, walkable, swim, dropped })
}

/// The WMO liquid over each column: (type, z) per column (the highest surface; None without WMO
/// liquids).
pub fn wmo_liquid_columns(geom: &Geometry) -> Option<(Vec<u8>, Vec<f32>)> {
	if geom.wmo_liquid.is_empty() {
		return None;
	}
	let mut ty = vec![0u8; COLUMNS];
	let mut z = vec![f32::NEG_INFINITY; COLUMNS];
	for w in &geom.wmo_liquid {
		if w.tris.is_empty() {
			continue;
		}
		let kind = vec![0u8; w.tris.len() / 9];
		let hf = rasterise_tris(&w.tris, &kind, &[], geom.col, geom.row);
		for k in 0..COLUMNS {
			let mut top = f32::NEG_INFINITY;
			let mut s = hf.head[k];
			while s != -1 {
				top = hf.smax[s as usize];
				s = hf.next[s as usize];
			}
			if top > z[k] {
				z[k] = top;
				ty[k] = w.ty;
			}
		}
	}
	Some((ty, z))
}
