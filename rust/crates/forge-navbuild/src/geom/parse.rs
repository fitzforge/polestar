//! Client file parsers (ports of tools/lib/nav/geom/{adt,mh2o,place,m2,wmo}.js; their headers
//! document the formats and the rules followed).

use super::Mh2o;
use crate::fmath;
use std::sync::Arc;

pub const ADT: f64 = 1600.0 / 3.0;
pub const CHUNK: f64 = ADT / 16.0;
pub const UNIT: f64 = CHUNK / 8.0;
const HEADER: usize = 128;
const FLAG_HIGH_RES_HOLES: u32 = 0x10000;

fn u16le(b: &[u8], o: usize) -> u16 {
	u16::from_le_bytes([b[o], b[o + 1]])
}
fn u32le(b: &[u8], o: usize) -> u32 {
	u32::from_le_bytes(b[o..o + 4].try_into().unwrap())
}
fn i32le(b: &[u8], o: usize) -> i32 {
	i32::from_le_bytes(b[o..o + 4].try_into().unwrap())
}
fn f32le(b: &[u8], o: usize) -> f32 {
	f32::from_le_bytes(b[o..o + 4].try_into().unwrap())
}
fn need(b: &[u8], end: usize, what: &str) -> Result<(), String> {
	if end > b.len() {
		Err(format!("{what}: read past the end ({end} > {})", b.len()))
	} else {
		Ok(())
	}
}

/// A chunk: tag (as read reversed: 'MCNK') and its data.
pub struct Chunk<'a> {
	pub tag: [u8; 4],
	pub data: &'a [u8],
}

/// The chunks in buf[start, end) (adt.js chunks; tags stored reversed).
pub fn chunks(buf: &[u8], start: usize) -> Result<Vec<Chunk<'_>>, String> {
	let end = buf.len();
	let mut out = Vec::new();
	let mut o = start;
	while o + 8 <= end {
		let tag = [buf[o + 3], buf[o + 2], buf[o + 1], buf[o]];
		let size = u32le(buf, o + 4) as usize;
		if o + 8 + size > end {
			return Err(format!("chunk {} at {o} ({size} bytes) runs past the end ({end})", String::from_utf8_lossy(&tag)));
		}
		out.push(Chunk { tag, data: &buf[o + 8..o + 8 + size] });
		o += 8 + size;
	}
	Ok(out)
}

pub fn chunk<'a>(list: &[Chunk<'a>], tag: &[u8; 4]) -> Option<&'a [u8]> {
	list.iter().find(|c| &c.tag == tag).map(|c| c.data)
}

pub struct Mcnk {
	pub index_x: u32,
	pub index_y: u32,
	pub area_id: u32,
	pub wx: f32,
	pub wy: f32,
	pub z: f32,
	pub heights: Vec<f32>,
	pub holes: [u8; 8],
}

fn parse_mcnk(d: &[u8]) -> Result<Mcnk, String> {
	if d.len() < HEADER {
		return Err(format!("MCNK: {} bytes, header is {HEADER}", d.len()));
	}
	let flags = u32le(d, 0);
	let mut holes = [0u8; 8];
	if flags & FLAG_HIGH_RES_HOLES != 0 {
		holes.copy_from_slice(&d[0x14..0x1c]);
	} else {
		let low = u16le(d, 0x3c);
		if low != 0 {
			for (y, h) in holes.iter_mut().enumerate() {
				for x in 0..8 {
					if low & (1 << ((y >> 1) * 4 + (x >> 1))) != 0 {
						*h |= 1 << x;
					}
				}
			}
		}
	}
	let sub = chunks(d, HEADER)?;
	let mcvt = chunk(&sub, b"MCVT").filter(|m| m.len() >= 145 * 4).ok_or_else(|| format!("MCNK {},{}: no MCVT", u32le(d, 4), u32le(d, 8)))?;
	let heights = (0..145).map(|i| f32le(mcvt, i * 4)).collect();
	Ok(Mcnk { index_x: u32le(d, 4), index_y: u32le(d, 8), area_id: u32le(d, 0x34), wx: f32le(d, 0x68), wy: f32le(d, 0x6c), z: f32le(d, 0x70), heights, holes })
}

/// Root ADT -> (256 MCNK, MH2O data).
pub fn parse_root(buf: &[u8]) -> Result<(Vec<Mcnk>, Option<&[u8]>), String> {
	let list = chunks(buf, 0)?;
	let mcnk = list.iter().filter(|c| &c.tag == b"MCNK").map(|c| parse_mcnk(c.data)).collect::<Result<Vec<_>, _>>()?;
	if mcnk.len() != 256 {
		return Err(format!("root ADT: {} MCNK chunks, not 256", mcnk.len()));
	}
	Ok((mcnk, chunk(&list, b"MH2O")))
}

/// The four triangles of each quad: (outer row, outer col) offsets, None for the inner vertex.
const QUAD: [[Option<(usize, usize)>; 3]; 4] = [[Some((0, 0)), None, Some((0, 1))], [Some((0, 1)), None, Some((1, 1))], [Some((1, 1)), None, Some((1, 0))], [Some((1, 0)), None, Some((0, 0))]];

/// Parsed MCNK list -> (triangles, 9 floats each; holed quads).
pub fn terrain_triangles(mcnk: &[Mcnk]) -> (Vec<f32>, usize) {
	let mut holes = 0;
	for m in mcnk {
		for y in 0..8 {
			for x in 0..8 {
				if m.holes[y] & (1 << x) != 0 {
					holes += 1;
				}
			}
		}
	}
	let mut tris = Vec::with_capacity((mcnk.len() * 64 - holes) * 36);
	for m in mcnk {
		let h = &m.heights;
		let (mwx, mwy, mz) = (f64::from(m.wx), f64::from(m.wy), f64::from(m.z));
		for y in 0..8 {
			for x in 0..8 {
				if m.holes[y] & (1 << x) != 0 {
					continue;
				}
				let cx = mwx - (y as f64 + 0.5) * UNIT;
				let cy = mwy - (x as f64 + 0.5) * UNIT;
				let cz = mz + f64::from(h[y * 17 + 9 + x]);
				for tri in &QUAD {
					for v in tri {
						match v {
							None => tris.extend([cx as f32, cy as f32, cz as f32]),
							Some((dr, dc)) => {
								let (r, c) = (y + dr, x + dc);
								tris.extend([(mwx - r as f64 * UNIT) as f32, (mwy - c as f64 * UNIT) as f32, (mz + f64::from(h[r * 17 + c])) as f32]);
							}
						}
					}
				}
			}
		}
	}
	(tris, holes)
}

/// The liquid tables' answers (index.js liquidInfo).
pub trait LiquidInfo {
	fn kind(&self, liquid_type: u32) -> Result<u8, String>;
	fn lvf(&self, liquid_type: u32, object_or_lvf: u32) -> Result<u32, String>;
}

const GRID: usize = 128;

/// MH2O data -> 128 x 128 quads (mh2o.js parseMh2o).
pub fn parse_mh2o(buf: Option<&[u8]>, liquid: &dyn LiquidInfo) -> Result<Mh2o, String> {
	let mut ty = vec![0u8; GRID * GRID];
	let mut z = vec![0f32; GRID * GRID];
	let mut deep = vec![0u8; GRID * GRID];
	let Some(buf) = buf else { return Ok(Mh2o { ty, z, deep }) };
	if buf.len() < 256 * 12 {
		return Err(format!("MH2O: {} bytes, header is {}", buf.len(), 256 * 12));
	}
	for ci in 0..256 {
		let ofs = u32le(buf, ci * 12) as usize;
		let layers = u32le(buf, ci * 12 + 4) as usize;
		let attrs = u32le(buf, ci * 12 + 8) as usize;
		if ofs == 0 || layers == 0 {
			continue;
		}
		let row0 = (ci >> 4) * 8;
		let col0 = (ci & 15) * 8;
		for k in 0..layers {
			let p = ofs + k * 24;
			need(buf, p + 24, "MH2O")?;
			let liquid_type = u32::from(u16le(buf, p));
			let object_or_lvf = u32::from(u16le(buf, p + 2));
			let min_height = f32le(buf, p + 4);
			let (xo, yo, w, h) = (buf[p + 12] as usize, buf[p + 13] as usize, buf[p + 14] as usize, buf[p + 15] as usize);
			let ofs_exists = u32le(buf, p + 16) as usize;
			let ofs_verts = u32le(buf, p + 20) as usize;
			let kind = liquid.kind(liquid_type)?;
			if kind == 0 || w == 0 || h == 0 {
				continue;
			}
			let heights = if ofs_verts != 0 && liquid.lvf(liquid_type, object_or_lvf)? != 2 { ofs_verts } else { 0 };
			let vz = |vx: usize, vy: usize| -> Result<f64, String> {
				if heights != 0 {
					let o = heights + (vy * (w + 1) + vx) * 4;
					need(buf, o + 4, "MH2O heights")?;
					Ok(f64::from(f32le(buf, o)))
				} else {
					Ok(f64::from(min_height))
				}
			};
			for y in 0..h {
				for x in 0..w {
					let bit = y * w + x;
					if ofs_exists != 0 {
						need(buf, ofs_exists + (bit >> 3) + 1, "MH2O exists")?;
						if buf[ofs_exists + (bit >> 3)] & (1 << (bit & 7)) == 0 {
							continue;
						}
					}
					let qz = (vz(x, y)? + vz(x + 1, y)? + vz(x, y + 1)? + vz(x + 1, y + 1)?) / 4.0;
					let i = (row0 + yo + y) * GRID + col0 + xo + x;
					if i >= GRID * GRID {
						continue;
					}
					if ty[i] != 0 && f64::from(z[i]) >= qz {
						continue;
					}
					ty[i] = kind;
					z[i] = qz as f32;
					deep[i] = if attrs != 0 {
						let (dx, dy) = (xo + x, yo + y);
						let b = attrs + 8 + ((dy * 8 + dx) >> 3);
						need(buf, b + 1, "MH2O attributes")?;
						(buf[b] >> ((dy * 8 + dx) & 7)) & 1
					} else {
						u8::from(kind == 2)
					};
				}
			}
		}
	}
	Ok(Mh2o { ty, z, deep })
}

const ORIGIN: f64 = 32.0 * (1600.0 / 3.0);

/// A placement (place.js parsePlacements).
#[derive(Clone, Debug)]
pub struct Place {
	pub fdid: u32,
	pub unique_id: u32,
	/// MODF nameSet (WMOAreaTable's NameSetID); 0 for an M2.
	pub name_set: u32,
	pub pos: [f64; 3],
	pub rot: [f64; 3],
	pub scale: f64,
	pub extents: [f64; 6],
}

fn to_world(b: &[u8], o: usize) -> [f64; 3] {
	[ORIGIN - f64::from(f32le(b, o + 8)), ORIGIN - f64::from(f32le(b, o)), f64::from(f32le(b, o + 4))]
}

/// obj0 chunks -> (m2, wmo) placements.
pub fn parse_placements(list: &[Chunk]) -> Result<(Vec<Place>, Vec<Place>), String> {
	let mut m2 = Vec::new();
	let mut wmo = Vec::new();
	for c in list {
		let data = c.data;
		if &c.tag == b"MDDF" {
			let mut o = 0;
			while o + 36 <= data.len() {
				let flags = u16le(data, o + 34);
				if flags & 0x40 == 0 {
					return Err(format!("MDDF entry {}: model by name (flags {flags:x}), not a FileDataID", o / 36));
				}
				m2.push(Place {
					fdid: u32le(data, o),
					unique_id: u32le(data, o + 4),
					name_set: 0,
					pos: to_world(data, o + 8),
					rot: [f64::from(f32le(data, o + 20)), f64::from(f32le(data, o + 24)), f64::from(f32le(data, o + 28))],
					scale: f64::from(u16le(data, o + 32)) / 1024.0,
					extents: [0.0; 6],
				});
				o += 36;
			}
		} else if &c.tag == b"MODF" {
			let mut o = 0;
			while o + 64 <= data.len() {
				let flags = u16le(data, o + 56);
				if flags & 0x8 == 0 {
					return Err(format!("MODF entry {}: WMO by name (flags {flags:x}), not a FileDataID", o / 64));
				}
				let a = to_world(data, o + 32);
				let b = to_world(data, o + 44);
				wmo.push(Place {
					fdid: u32le(data, o),
					unique_id: u32le(data, o + 4),
					name_set: u32::from(u16le(data, o + 60)),
					pos: to_world(data, o + 8),
					rot: [f64::from(f32le(data, o + 20)), f64::from(f32le(data, o + 24)), f64::from(f32le(data, o + 28))],
					scale: if flags & 0x4 != 0 { f64::from(u16le(data, o + 62)) / 1024.0 } else { 1.0 },
					extents: [fmath::min(a[0], b[0]), fmath::min(a[1], b[1]), fmath::min(a[2], b[2]), fmath::max(a[0], b[0]), fmath::max(a[1], b[1]), fmath::max(a[2], b[2])],
				});
				o += 64;
			}
		}
	}
	Ok((m2, wmo))
}

const RAD: f64 = std::f64::consts::PI / 180.0;

/// Placement -> row-major 3 x 4 [R * scale | position].
pub fn placement_matrix(p: &Place) -> [f64; 12] {
	let z = (p.rot[1] + 180.0) * RAD;
	let y = p.rot[0] * RAD;
	let x = p.rot[2] * RAD;
	let (cz, sz) = (fmath::cos(z), fmath::sin(z));
	let (cy, sy) = (fmath::cos(y), fmath::sin(y));
	let (cx, sx) = (fmath::cos(x), fmath::sin(x));
	let s = p.scale;
	[
		cz * cy * s,
		(cz * sy * sx - sz * cx) * s,
		(cz * sy * cx + sz * sx) * s,
		p.pos[0],
		sz * cy * s,
		(sz * sy * sx + cz * cx) * s,
		(sz * sy * cx - cz * sx) * s,
		p.pos[1],
		-sy * s,
		cy * sx * s,
		cy * cx * s,
		p.pos[2],
	]
}

/// The points of src (x, y, z triples) under m, into a Float32Array.
pub fn transform_points(m: &[f64; 12], src: &[f32]) -> Vec<f32> {
	let mut dst = Vec::with_capacity(src.len());
	for v in src.chunks_exact(3) {
		let (x, y, z) = (f64::from(v[0]), f64::from(v[1]), f64::from(v[2]));
		dst.push((m[0] * x + m[1] * y + m[2] * z + m[3]) as f32);
		dst.push((m[4] * x + m[5] * y + m[6] * z + m[7]) as f32);
		dst.push((m[8] * x + m[9] * y + m[10] * z + m[11]) as f32);
	}
	dst
}

/// World AABB of a model-space box under m.
pub fn transform_box(m: &[f64; 12], b: &[f64; 6]) -> [f64; 6] {
	let mut out = [f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::NEG_INFINITY, f64::NEG_INFINITY, f64::NEG_INFINITY];
	for k in 0..8 {
		let v = [b[if k & 1 != 0 { 3 } else { 0 }], b[if k & 2 != 0 { 4 } else { 1 }], b[if k & 4 != 0 { 5 } else { 2 }]];
		let mut p = [0.0; 3];
		for r in 0..3 {
			p[r] = m[r * 4] * v[0] + m[r * 4 + 1] * v[1] + m[r * 4 + 2] * v[2] + m[r * 4 + 3];
		}
		for r in 0..3 {
			if p[r] < out[r] {
				out[r] = p[r];
			}
			if p[r] > out[r + 3] {
				out[r + 3] = p[r];
			}
		}
	}
	out
}

/// A model's collision (and for a WMO its liquid) in model space.
#[derive(Clone, Debug, Default)]
pub struct Model {
	pub verts: Vec<f32>,
	pub idx: Vec<u32>,
	/// Per triangle (WMO: 1 outdoor, 2 indoor; M2: unused).
	pub kind: Vec<u8>,
	pub box_: [f64; 6],
	pub liquid_verts: Vec<f32>,
	pub liquid_idx: Vec<u32>,
	pub liquid_kind: Vec<u8>,
	pub portals: Vec<Vec<f32>>,
	pub missing: Vec<u32>,
	/// WMO: the root's WMOID (MOHD) and per triangle its group's WMOGroupID (MOGP), the keys of
	/// WMOAreaTable; empty for an M2.
	pub wmo_id: u32,
	pub group: Vec<i32>,
}

/// M2 file -> collision (m2.js parseM2).
pub fn parse_m2(buf: &[u8]) -> Result<Model, String> {
	let mut d: Option<&[u8]> = None;
	if buf.len() >= 4 && &buf[..4] == b"MD20" {
		d = Some(buf);
	} else {
		let mut o = 0;
		while o + 8 <= buf.len() {
			let size = u32le(buf, o + 4) as usize;
			if &buf[o..o + 4] == b"MD21" {
				d = buf.get(o + 8..(o + 8 + size).min(buf.len()));
				break;
			}
			o += 8 + size;
		}
	}
	let d = d.filter(|d| d.len() >= 4 && &d[..4] == b"MD20").ok_or("M2: no MD20 header")?;
	need(d, 0xe8, "M2 header")?;
	let version = u32le(d, 4);
	if version < 264 {
		return Err(format!("M2: version {version} (pre-WotLK header layout)"));
	}
	let mut box_ = [0.0; 6];
	for (i, b) in box_.iter_mut().enumerate() {
		*b = f64::from(f32le(d, 0xbc + i * 4));
	}
	let (ni, oi, nv, ov) = (u32le(d, 0xd8) as usize, u32le(d, 0xdc) as usize, u32le(d, 0xe0) as usize, u32le(d, 0xe4) as usize);
	if ni == 0 || nv == 0 {
		return Ok(Model { box_, ..Model::default() });
	}
	if oi + ni * 2 > d.len() || ov + nv * 12 > d.len() {
		return Err("M2: collision arrays past the end".into());
	}
	let mut idx = Vec::with_capacity(ni - ni % 3);
	for i in 0..ni - ni % 3 {
		let v = u32::from(u16le(d, oi + i * 2));
		if v as usize >= nv {
			return Err(format!("M2: collision index {v} past {nv} positions"));
		}
		idx.push(v);
	}
	let verts = (0..nv * 3).map(|i| f32le(d, ov + i * 4)).collect();
	Ok(Model { verts, idx, box_, ..Model::default() })
}

const F_DETAIL: u32 = 0x04;
const F_COLLISION: u32 = 0x08;
const F_RENDER: u32 = 0x20;
const G_UNREACHABLE: u32 = 0x80;
const G_INDOOR: u32 = 0x2000;
const G_OCEAN: u32 = 0x80000;
const G_ANTIPORTAL: u32 = 0x400_0000;
const ROOT_LIQUID_DBC: u32 = 0x4;
const MOGP_HEADER: usize = 68;
const MLIQ_HEADER: usize = 30;
const NO_LIQUID: u8 = 0x0f;
const GREEN_LAVA: u32 = 15;

fn collides(f: u32) -> bool {
	f & F_COLLISION != 0 || (f & F_RENDER != 0 && f & F_DETAIL == 0)
}

/// A reviewed landing group's face (walkways.json `landings`): a collision face, or any rendered one
/// (render + detail without the collision bit: the faces both builders drop elsewhere).
fn landing_face(f: u32) -> bool {
	collides(f) || f & F_RENDER != 0
}

struct WmoRoot<'a> {
	flags: u32,
	wmo_id: u32,
	box_: [f64; 6],
	groups: Vec<u32>,
	names: Option<&'a [u8]>,
	portals: Vec<Vec<f32>>,
}

fn parse_wmo_root(buf: &[u8]) -> Result<WmoRoot<'_>, String> {
	let list = chunks(buf, 0)?;
	let mohd = chunk(&list, b"MOHD").ok_or("WMO root: no MOHD")?;
	need(mohd, 0x3e, "MOHD")?;
	let n_groups = u32le(mohd, 4) as usize;
	let mut box_ = [0.0; 6];
	for (i, b) in box_.iter_mut().enumerate() {
		*b = f64::from(f32le(mohd, 0x24 + i * 4));
	}
	let gfid = chunk(&list, b"GFID").ok_or("WMO root: no GFID (groups by name)")?;
	if gfid.len() < n_groups * 4 {
		return Err(format!("WMO root: GFID lists {} groups, MOHD {n_groups}", gfid.len() / 4));
	}
	let groups = (0..n_groups).map(|g| u32le(gfid, g * 4)).collect();
	let mut portals = Vec::new();
	if let (Some(mopt), Some(mopv)) = (chunk(&list, b"MOPT"), chunk(&list, b"MOPV")) {
		let mut o = 0;
		while o + 20 <= mopt.len() {
			let start = u16le(mopt, o) as usize;
			let count = u16le(mopt, o + 2) as usize;
			if (start + count) * 12 > mopv.len() {
				return Err(format!("WMO root: portal {} past MOPV", o / 20));
			}
			portals.push((0..count * 3).map(|i| f32le(mopv, start * 12 + i * 4)).collect());
			o += 20;
		}
	}
	Ok(WmoRoot { flags: u32::from(u16le(mohd, 0x3c)), wmo_id: u32le(mohd, 0x20), box_, groups, names: chunk(&list, b"MOGN"), portals })
}

fn name_at(names: Option<&[u8]>, ofs: usize) -> Vec<u8> {
	let Some(n) = names.filter(|n| ofs < n.len()) else { return Vec::new() };
	let end = n[ofs..].iter().position(|&b| b == 0).map_or(n.len(), |p| ofs + p);
	n[ofs..end].to_vec()
}

fn collision(sub: &[Chunk], landing: bool) -> Result<(Vec<f32>, Vec<u32>), String> {
	let keep: fn(u32) -> bool = if landing { landing_face } else { collides };
	let poly: Vec<u32> = if let Some(m) = chunk(sub, b"MPY2") {
		(0..m.len() / 4).map(|i| u32::from(u16le(m, i * 4))).collect()
	} else if let Some(m) = chunk(sub, b"MOPY") {
		(0..m.len() / 2).map(|i| u32::from(m[i * 2])).collect()
	} else {
		return Ok((Vec::new(), Vec::new()));
	};
	let movx = chunk(sub, b"MOVX");
	let movi = chunk(sub, b"MOVI");
	let Some(movt) = chunk(sub, b"MOVT") else { return Ok((Vec::new(), Vec::new())) };
	if movx.is_none() && movi.is_none() {
		return Ok((Vec::new(), Vec::new()));
	}
	let index = |i: usize| -> u32 {
		match movx {
			Some(x) => u32le(x, i * 4),
			None => u32::from(u16le(movi.unwrap(), i * 2)),
		}
	};
	let n_index = movx.map_or_else(|| movi.unwrap().len() / 2, |x| x.len() / 4);
	let n_verts = movt.len() / 12;
	let n_tris = poly.len().min(n_index / 3);
	let mut remap = vec![-1i64; n_verts];
	let mut kept = Vec::new();
	let mut used = 0i64;
	for t in 0..n_tris {
		if !keep(poly[t]) {
			continue;
		}
		for k in 0..3 {
			let v = index(t * 3 + k) as usize;
			if v >= n_verts {
				return Err(format!("WMO group: index {v} past {n_verts} vertices"));
			}
			if remap[v] < 0 {
				remap[v] = used;
				used += 1;
			}
			kept.push(remap[v] as u32);
		}
	}
	let mut verts = vec![0f32; used as usize * 3];
	for v in 0..n_verts {
		let r = remap[v];
		if r < 0 {
			continue;
		}
		let r = r as usize;
		verts[r * 3] = f32le(movt, v * 12);
		verts[r * 3 + 1] = f32le(movt, v * 12 + 4);
		verts[r * 3 + 2] = f32le(movt, v * 12 + 8);
	}
	Ok((verts, kept))
}

/// TrinityCore WMOGroup::GetLiquidTypeId.
fn liquid_type_id(id: u32, group_flags: u32) -> u32 {
	if id > 0 && id < 21 {
		return match (id - 1) & 3 {
			0 => {
				if group_flags & G_OCEAN != 0 {
					14
				} else {
					13
				}
			}
			1 => 14,
			2 => 19,
			_ => 20,
		};
	}
	id
}

type Liq = (u32, Vec<f32>, Vec<u32>);

fn group_liquid(mogp: &[u8], sub: &[Chunk], flags: u32, root_flags: u32) -> Result<Option<Liq>, String> {
	let gl = u32le(mogp, 0x34);
	let mliq = chunk(sub, b"MLIQ");
	let mut ty = if root_flags & ROOT_LIQUID_DBC != 0 {
		liquid_type_id(gl, flags)
	} else if gl == GREEN_LAVA {
		0
	} else {
		liquid_type_id(gl.wrapping_add(1), flags)
	};
	let ok = mliq.filter(|m| m.len() >= MLIQ_HEADER);
	let xt = ok.map_or(0, |m| i32le(m, 8));
	let yt = ok.map_or(0, |m| i32le(m, 12));
	if xt == 0 || yt == 0 {
		if ty == 0 || root_flags & ROOT_LIQUID_DBC == 0 {
			return Ok(None);
		}
		let (x0, y0, x1, y1, z) = (f32le(mogp, 0x0c), f32le(mogp, 0x10), f32le(mogp, 0x18), f32le(mogp, 0x1c), f32le(mogp, 0x20));
		return Ok(Some((ty, vec![x0, y0, z, x1, y0, z, x1, y1, z, x0, y1, z], vec![0, 1, 2, 0, 2, 3])));
	}
	let mliq = ok.unwrap();
	let xv = i32le(mliq, 0);
	let yv = i32le(mliq, 4);
	if xv != xt + 1 || yv != yt + 1 {
		return Err(format!("WMO MLIQ: {xv} x {yv} vertices for {xt} x {yt} tiles"));
	}
	let (xv, yv, xt, yt) = (xv as usize, yv as usize, xt as usize, yt as usize);
	let tiles = MLIQ_HEADER + xv * yv * 8;
	if tiles + xt * yt > mliq.len() {
		return Err(format!("WMO MLIQ: {} bytes, {} needed", mliq.len(), tiles + xt * yt));
	}
	if ty == 0 {
		for i in 0..xt * yt {
			let legacy = mliq[tiles + i] & 0x0f;
			if legacy != NO_LIQUID {
				ty = liquid_type_id(u32::from(legacy) + 1, flags);
				if ty != 0 {
					break;
				}
			}
		}
		if ty == 0 {
			return Ok(None);
		}
	}
	let cx = f64::from(f32le(mliq, 16));
	let cy = f64::from(f32le(mliq, 20));
	let mut verts = vec![0f32; xv * yv * 3];
	for j in 0..yv {
		for i in 0..xv {
			let v = j * xv + i;
			verts[v * 3] = (cx + i as f64 * UNIT) as f32;
			verts[v * 3 + 1] = (cy + j as f64 * UNIT) as f32;
			verts[v * 3 + 2] = f32le(mliq, MLIQ_HEADER + v * 8 + 4);
		}
	}
	let mut idx = Vec::new();
	for j in 0..yt {
		for i in 0..xt {
			if mliq[tiles + j * xt + i] & 0x0f == NO_LIQUID {
				continue;
			}
			let a = (j * xv + i) as u32;
			let xv = xv as u32;
			idx.extend([a, a + 1, a + 1 + xv, a, a + 1 + xv, a + xv]);
		}
	}
	if idx.is_empty() {
		return Ok(None);
	}
	Ok(Some((ty, verts, idx)))
}

struct Group {
	/// MOGP's WMOGroupID (WMOAreaTable's key; -1 when the header is too short).
	id: i32,
	indoor: bool,
	walkway: bool,
	verts: Vec<f32>,
	idx: Vec<u32>,
	liquid: Option<Liq>,
}

fn parse_group(buf: &[u8], names: Option<&[u8]>, root_flags: u32, walkways: &[&str], landings: &[&str]) -> Result<Group, String> {
	let top = chunks(buf, 0)?;
	let mogp = chunk(&top, b"MOGP").filter(|m| m.len() >= MOGP_HEADER).ok_or("WMO group: no MOGP")?;
	let flags = u32le(mogp, 8);
	let name = name_at(names, u32le(mogp, 0) as usize);
	let skip = flags & G_UNREACHABLE != 0 || flags & G_ANTIPORTAL != 0 || name == b"antiportal";
	let indoor = flags & G_INDOOR != 0;
	let walkway = walkways.iter().any(|w| w.as_bytes().eq_ignore_ascii_case(&name));
	if skip {
		return Ok(Group { id: group_id(mogp), indoor, walkway, verts: Vec::new(), idx: Vec::new(), liquid: None });
	}
	let sub = chunks(mogp, MOGP_HEADER)?;
	let landing = landings.iter().any(|w| w.as_bytes().eq_ignore_ascii_case(&name));
	let (verts, idx) = collision(&sub, landing)?;
	Ok(Group { id: group_id(mogp), indoor, walkway, verts, idx, liquid: group_liquid(mogp, &sub, flags, root_flags)? })
}

/// MOGP header's WMOGroupID (offset 0x38).
fn group_id(mogp: &[u8]) -> i32 {
	if mogp.len() >= 0x3c {
		u32le(mogp, 0x38) as i32
	} else {
		-1
	}
}

/// A whole WMO, its groups merged (wmo.js loadWmo). `get(fdid)`: Ok(None) is a missing file.
/// `walkways`: names of its groups whose triangles are walkway kinds (geom::kind 5 outdoor, 6 indoor);
/// `landings`: names of its groups whose rendered faces without the collision bit are kept too.
pub fn load_wmo(
	get: &dyn Fn(u32) -> Result<Option<Arc<Vec<u8>>>, String>,
	fdid: u32,
	kind_of: &dyn Fn(u32) -> Result<u8, String>,
	walkways: &[&str],
	landings: &[&str],
) -> Result<Option<Model>, String> {
	let Some(rb) = get(fdid)? else { return Ok(None) };
	let root = parse_wmo_root(&rb)?;
	let mut missing = Vec::new();
	let mut parts = Vec::new();
	for &g in &root.groups {
		if g == 0 {
			continue;
		}
		match get(g)? {
			None => missing.push(g),
			Some(b) => parts.push(parse_group(&b, root.names, root.flags, walkways, landings)?),
		}
	}
	let mut m = Model { box_: root.box_, portals: root.portals.clone(), missing, wmo_id: root.wmo_id, ..Model::default() };
	for p in &parts {
		let vo = (m.verts.len() / 3) as u32;
		m.verts.extend_from_slice(&p.verts);
		m.idx.extend(p.idx.iter().map(|&i| i + vo));
		let k = match (p.indoor, p.walkway) {
			(false, false) => 1,
			(true, false) => 2,
			(false, true) => 5,
			(true, true) => 6,
		};
		m.kind.extend(std::iter::repeat_n(k, p.idx.len() / 3));
		m.group.extend(std::iter::repeat_n(p.id, p.idx.len() / 3));
	}
	for p in &parts {
		let Some((ty, verts, idx)) = &p.liquid else { continue };
		let k = kind_of(*ty)?;
		if k == 0 {
			continue;
		}
		let vo = (m.liquid_verts.len() / 3) as u32;
		m.liquid_verts.extend_from_slice(verts);
		m.liquid_idx.extend(idx.iter().map(|&i| i + vo));
		m.liquid_kind.extend(std::iter::repeat_n(k, idx.len() / 3));
	}
	Ok(Some(m))
}
