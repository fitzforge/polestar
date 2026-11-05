//! The navigation grid's constants and files (port of tools/lib/nav/grid/format.js; its header
//! documents the layouts: TILE, WALLS, GRAPH). Arrays mirror the JS typed arrays: `Vec<f32>` for a
//! Float32Array, `Vec<u8>` for a Uint8Array and so on.

use flate2::{Compress, Compression, FlushCompress, Status};
use std::io::Read;

pub const ADT: f64 = 1600.0 / 3.0;
pub const TILE_CELLS: usize = 256;
pub const CELL: f64 = ADT / 256.0;
pub const COLUMNS: usize = TILE_CELLS * TILE_CELLS;

pub const GENTLE_MAX: f64 = 35.0;
pub const WALK_MAX: f64 = 50.0;
pub const STEEP_MAX: f64 = 60.0;
pub const CLIMB_MAX: f64 = 80.0;
pub const STAIR_MAX: f64 = 45.0;
pub const WALL_MIN: f64 = 80.0;
/// Half-lines E, S, W, N; the orthogonal direction DIRS[d] has half-line d >> 1.
pub mod half {
	pub const E: usize = 0;
	pub const S: usize = 1;
	pub const W: usize = 2;
	pub const N: usize = 3;
}
pub const AGENT_HEIGHT: f64 = 1.6;
pub const STEP: f64 = 1.0;
pub const JUMP: f64 = 1.6;
pub const SWIM_DEPTH: f64 = 1.5;
pub const SAFE_FALL: f64 = 14.57;
pub const FALL_MAX: f64 = 30.0;
pub const FALL_MAX_WATER: f64 = 60.0;
pub const STABLE_CELLS: usize = 4;
pub const MERGE_TOP: f64 = 0.5;
pub const LIFT_RADIUS: f64 = 8.0;
pub const LIFT_REACH: f64 = 10.0;
pub const LIFT_MIN: f64 = 10.0;
pub const LIFT_FIT: f64 = 2.0;
pub const LIFT_OPEN: usize = 200;
/// Yards from a car's stop (travel.json) its object's spawns may lie (a tenth of a percent of Mulgore's map is 5 yd).
pub const LIFT_CAR: f64 = 12.0;
/// Yards of distance a yard of a landing's height off the car's floor counts.
pub const LIFT_LEVEL: f64 = 2.0;

/// FLAG bits.
pub mod flag {
	pub const TERRAIN: u8 = 1;
	pub const WMO: u8 = 2;
	pub const M2: u8 = 4;
	pub const INDOOR: u8 = 8;
	pub const SWIM: u8 = 16;
	pub const OCEAN: u8 = 32;
	pub const STEEP: u8 = 64;
	pub const BLOCKED: u8 = 128;
}
/// Route segment classes (CLS).
pub mod cls {
	pub const WALK: u8 = 0;
	pub const STEEP: u8 = 1;
	pub const SWIM: u8 = 2;
	pub const JUMP: u8 = 3;
	pub const FALL: u8 = 4;
	pub const INDOOR: u8 = 5;
	pub const CLIMB: u8 = 6;
	pub const LIFT: u8 = 7;
}
pub const CLS_NAMES: [&str; 8] = ["walk", "steep", "swim", "jump", "fall", "indoor", "climb", "lift"];
pub const LINK_SLOPE: u8 = 7;
pub const CODE_LIFT: u8 = 8;
pub const NO_LINK: u8 = 0xff;
pub const NO_COMP: u32 = 0xffff_ffff;
pub const MAX_LAYERS: usize = 31;
/// E, SE, S, SW, W, NW, N, NE (i east, j south).
pub const DIRS: [[i32; 2]; 8] = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]];
pub const FALL_REACH: usize = 3;
pub const FALL_SLIDE: usize = 12;
pub const RUN_MAX: usize = 32;
pub const REF_PROFILES: [&str; 2] = ["foot", "mount"];

pub const VERSION: u32 = 4;
pub const TILE_VERSIONS: [u32; 2] = [3, 4];
pub const WALLS_VERSION: u32 = 1;
pub const GRAPH_VERSION: u32 = 5;
const MAGIC_TILE: u32 = 0x564e_4150;
const MAGIC_GRAPH: u32 = 0x5247_4e50;
const MAGIC_WALLS: u32 = 0x4c57_4e50;
pub const WALL_MERGE: f64 = 0.05;

/// index.json `constants`, in the JS object's key order (name, value).
pub fn constants() -> Vec<(&'static str, f64)> {
	vec![
		("ADT", ADT),
		("CELL", CELL),
		("TILE_CELLS", TILE_CELLS as f64),
		("GENTLE_MAX", GENTLE_MAX),
		("WALK_MAX", WALK_MAX),
		("STEEP_MAX", STEEP_MAX),
		("CLIMB_MAX", CLIMB_MAX),
		("STAIR_MAX", STAIR_MAX),
		("WALL_MIN", WALL_MIN),
		("AGENT_HEIGHT", AGENT_HEIGHT),
		("STEP", STEP),
		("JUMP", JUMP),
		("SWIM_DEPTH", SWIM_DEPTH),
		("SAFE_FALL", SAFE_FALL),
		("FALL_MAX", FALL_MAX),
		("FALL_MAX_WATER", FALL_MAX_WATER),
		("STABLE_CELLS", STABLE_CELLS as f64),
		("MERGE_TOP", MERGE_TOP),
		("MAX_LAYERS", MAX_LAYERS as f64),
		("FALL_REACH", FALL_REACH as f64),
		("FALL_SLIDE", FALL_SLIDE as f64),
		("RUN_MAX", RUN_MAX as f64),
		("LIFT_RADIUS", LIFT_RADIUS),
		("LIFT_REACH", LIFT_REACH),
		("LIFT_MIN", LIFT_MIN),
		("LIFT_FIT", LIFT_FIT),
		("LIFT_OPEN", LIFT_OPEN as f64),
		("LIFT_CAR", LIFT_CAR),
		("LIFT_LEVEL", LIFT_LEVEL),
	]
}

pub fn tile_key(col: i32, row: i32) -> String {
	format!("{col}_{row}")
}

const fn align4(n: usize) -> usize {
	(n + 3) & !3
}

/// The world centre of column (i, j) of tile (col, row): (wx, wy).
pub fn cell_centre(col: i32, row: i32, i: i32, j: i32) -> (f64, f64) {
	((32.0 - row as f64) * ADT - (j as f64 + 0.5) * CELL, (32.0 - col as f64) * ADT - (i as f64 + 0.5) * CELL)
}

/// The tile and column of a world point: (col, row, i, j).
pub fn cell_of(wx: f64, wy: f64) -> (i32, i32, i32, i32) {
	let u = (32.0 * ADT - wy) / CELL;
	let v = (32.0 * ADT - wx) / CELL;
	let gi = u.floor() as i64;
	let gj = v.floor() as i64;
	let col = gi.div_euclid(TILE_CELLS as i64);
	let row = gj.div_euclid(TILE_CELLS as i64);
	(col as i32, row as i32, (gi - col * TILE_CELLS as i64) as i32, (gj - row * TILE_CELLS as i64) as i32)
}

/// Prefix sums of the per-column entry counts.
pub fn first_of(count: &[u8]) -> Vec<u32> {
	let mut first = vec![0u32; COLUMNS + 1];
	for k in 0..COLUMNS {
		first[k + 1] = first[k] + count[k] as u32;
	}
	first
}

/// A tile's walls (WALLS): half-line key k * 4 + h has ranges [at[key], at[key + 1]).
#[derive(Clone, Debug, Default)]
pub struct Walls {
	pub at: Vec<u32>,
	pub lo: Vec<f32>,
	pub hi: Vec<f32>,
}

/// A lift ride from an entry of the tile (worker.js `lifts`): the other end and the rise.
#[derive(Clone, Debug)]
pub struct LiftRide {
	pub col: i32,
	pub row: i32,
	pub k: u32,
	pub entry: u32,
	pub h: f64,
}

/// One ADT tile's surfaces (TILE). `links`, `comp`, `n_comp`, `fall_from`, `fall_to` are present
/// once linked; `walls` only between the surfaces and links passes; `lifts` only in the graph
/// pass (entry -> rides, in insertion order).
#[derive(Clone, Debug, Default)]
pub struct Tile {
	pub c: u32,
	pub col: i32,
	pub row: i32,
	pub n: usize,
	pub count: Vec<u8>,
	pub first: Vec<u32>,
	pub z: Vec<f32>,
	pub ceil: Vec<f32>,
	pub flags: Vec<u8>,
	pub slope: Vec<u8>,
	pub tslope: Option<Vec<u8>>,
	pub areas: Vec<u16>,
	pub links: Option<Vec<u8>>,
	pub comp: Option<Vec<u32>>,
	pub n_comp: u32,
	pub fall_from: Vec<u32>,
	pub fall_to: Vec<u16>,
	pub walls: Option<Walls>,
	pub lifts: Option<Vec<(u32, Vec<LiftRide>)>>,
}

/// zlib.gzipSync(buf, { level: 6 }): the same bytes. Node feeds the whole input with Z_FINISH into
/// 16 KiB output chunks, and zlib-ng's output depends on the chunk size, so this does the same.
pub fn gzip(raw: &[u8]) -> Vec<u8> {
	const CHUNK: usize = 16 * 1024;
	let mut c = Compress::new_gzip(Compression::new(6), 15);
	let mut out: Vec<u8> = Vec::with_capacity(raw.len() / 3 + CHUNK);
	let mut buf = vec![0u8; CHUNK];
	loop {
		let (i0, o0) = (c.total_in() as usize, c.total_out());
		let st = c.compress(&raw[i0..], &mut buf, FlushCompress::Finish).expect("gzip to memory");
		out.extend_from_slice(&buf[..(c.total_out() - o0) as usize]);
		if st == Status::StreamEnd {
			break;
		}
	}
	out
}

pub fn gunzip(gz: &[u8]) -> Result<Vec<u8>, String> {
	let isize = if gz.len() >= 18 { u32::from_le_bytes(gz[gz.len() - 4..].try_into().unwrap()) as usize } else { 0 };
	let mut out = Vec::with_capacity(isize);
	flate2::read::GzDecoder::new(gz).read_to_end(&mut out).map_err(|e| format!("gunzip: {e}"))?;
	Ok(out)
}

struct W(Vec<u8>);
impl W {
	fn u16(&mut self, v: u16) {
		self.0.extend_from_slice(&v.to_le_bytes());
	}
	fn u32(&mut self, v: u32) {
		self.0.extend_from_slice(&v.to_le_bytes());
	}
	fn u16s(&mut self, a: &[u16]) {
		for &v in a {
			self.u16(v);
		}
	}
	fn u32s(&mut self, a: &[u32]) {
		for &v in a {
			self.u32(v);
		}
	}
	fn f32s(&mut self, a: &[f32]) {
		for &v in a {
			self.0.extend_from_slice(&v.to_le_bytes());
		}
	}
	fn pad4(&mut self) {
		while !self.0.len().is_multiple_of(4) {
			self.0.push(0);
		}
	}
}

/// The tile's TILE bytes, gzipped.
pub fn encode_tile(t: &Tile) -> Result<Vec<u8>, String> {
	let has_links = t.links.is_some();
	let n = t.n;
	let m = if has_links { t.fall_from.len() } else { 0 };
	let tslope = t.tslope.as_ref().filter(|s| s.len() == n).ok_or_else(|| format!("nav tile {} {}: no tslope (a version 3 tile is never written)", t.c, tile_key(t.col, t.row)))?;
	let mut w = W(Vec::with_capacity(32 + 512 + COLUMNS + 20 * n));
	w.u32(MAGIC_TILE);
	w.u32(VERSION);
	w.u32(t.c);
	w.u16(t.col as u16);
	w.u16(t.row as u16);
	w.u32(n as u32);
	w.u32(m as u32);
	w.u32(if has_links { t.n_comp } else { 0 });
	w.u32(u32::from(has_links));
	w.u16s(&t.areas);
	w.0.extend_from_slice(&t.count);
	w.f32s(&t.z);
	w.f32s(&t.ceil);
	if has_links {
		w.u32s(t.comp.as_ref().expect("linked tile has comp"));
		w.u32s(&t.fall_from);
		w.u16s(&t.fall_to);
		w.pad4();
	}
	w.0.extend_from_slice(&t.flags);
	w.0.extend_from_slice(&t.slope);
	if let Some(l) = &t.links {
		w.0.extend_from_slice(l);
	}
	w.0.extend_from_slice(tslope);
	Ok(gzip(&w.0))
}

struct R<'a> {
	b: &'a [u8],
	o: usize,
}
impl R<'_> {
	fn u32_at(&self, o: usize) -> u32 {
		u32::from_le_bytes(self.b[o..o + 4].try_into().unwrap())
	}
	fn u16_at(&self, o: usize) -> u16 {
		u16::from_le_bytes(self.b[o..o + 2].try_into().unwrap())
	}
	fn bytes(&mut self, len: usize) -> Result<Vec<u8>, String> {
		let s = self.b.get(self.o..self.o + len).ok_or("nav file truncated")?.to_vec();
		self.o += len;
		Ok(s)
	}
	fn u16s(&mut self, len: usize) -> Result<Vec<u16>, String> {
		Ok(self.bytes(2 * len)?.chunks_exact(2).map(|c| u16::from_le_bytes([c[0], c[1]])).collect())
	}
	fn u32s(&mut self, len: usize) -> Result<Vec<u32>, String> {
		Ok(self.bytes(4 * len)?.chunks_exact(4).map(|c| u32::from_le_bytes(c.try_into().unwrap())).collect())
	}
	fn f32s(&mut self, len: usize) -> Result<Vec<f32>, String> {
		Ok(self.bytes(4 * len)?.chunks_exact(4).map(|c| f32::from_le_bytes(c.try_into().unwrap())).collect())
	}
}

pub fn decode_tile(gz: &[u8]) -> Result<Tile, String> {
	let raw = gunzip(gz)?;
	if raw.len() < 32 {
		return Err("not a nav tile".into());
	}
	let mut r = R { b: &raw, o: 32 };
	if r.u32_at(0) != MAGIC_TILE {
		return Err("not a nav tile".into());
	}
	let version = r.u32_at(4);
	if !TILE_VERSIONS.contains(&version) {
		return Err(format!("nav tile version {version}, expected 3 or 4"));
	}
	let n = r.u32_at(16) as usize;
	let m = r.u32_at(20) as usize;
	let has_links = r.u32_at(28) & 1 == 1;
	let mut t = Tile { c: r.u32_at(8), col: r.u16_at(12) as i32, row: r.u16_at(14) as i32, n, ..Tile::default() };
	t.areas = r.u16s(256)?;
	t.count = r.bytes(COLUMNS)?;
	t.z = r.f32s(n)?;
	t.ceil = r.f32s(n)?;
	if has_links {
		t.n_comp = r.u32_at(24);
		t.comp = Some(r.u32s(n)?);
		t.fall_from = r.u32s(m)?;
		t.fall_to = r.u16s(m)?;
		r.o = align4(r.o);
	}
	t.flags = r.bytes(n)?;
	t.slope = r.bytes(n)?;
	if has_links {
		t.links = Some(r.bytes(8 * n)?);
	}
	t.tslope = if version >= 4 { Some(r.bytes(n)?) } else { None };
	t.first = first_of(&t.count);
	Ok(t)
}

/// Wall ranges (key = k * 4 + h, lo, hi; any order) -> the merged index (format.js wallIndex).
/// `lo`/`hi` are the JS arrays' values (f64; stored into Float32Arrays here).
pub fn wall_index(key: &[u32], lo: &[f64], hi: &[f64]) -> Walls {
	let kk = 4 * COLUMNS;
	let mut at = vec![0u32; kk + 1];
	for &k in key {
		at[k as usize + 1] += 1;
	}
	for x in 0..kk {
		at[x + 1] += at[x];
	}
	let mut fill: Vec<u32> = at[..kk].to_vec();
	let mut s_lo = vec![0f32; key.len()];
	let mut s_hi = vec![0f32; key.len()];
	for r in 0..key.len() {
		let p = fill[key[r] as usize] as usize;
		fill[key[r] as usize] += 1;
		s_lo[p] = lo[r] as f32;
		s_hi[p] = hi[r] as f32;
	}
	let mut o_lo = vec![0f32; key.len()];
	let mut o_hi = vec![0f32; key.len()];
	let mut out = vec![0u32; kk + 1];
	let mut w = 0usize;
	for x in 0..kk {
		let a = at[x] as usize;
		let b = at[x + 1] as usize;
		for p in a + 1..b {
			let l = s_lo[p];
			let h = s_hi[p];
			let mut q = p as isize - 1;
			while q >= a as isize && s_lo[q as usize] > l {
				s_lo[q as usize + 1] = s_lo[q as usize];
				s_hi[q as usize + 1] = s_hi[q as usize];
				q -= 1;
			}
			s_lo[(q + 1) as usize] = l;
			s_hi[(q + 1) as usize] = h;
		}
		let start = w;
		for p in a..b {
			if w > start && (f64::from(s_lo[p]) <= f64::from(o_hi[w - 1]) + WALL_MERGE || w - start == 255) {
				if s_hi[p] > o_hi[w - 1] {
					o_hi[w - 1] = s_hi[p];
				}
				continue;
			}
			o_lo[w] = s_lo[p];
			o_hi[w] = s_hi[p];
			w += 1;
		}
		out[x + 1] = w as u32;
	}
	o_lo.truncate(w);
	o_hi.truncate(w);
	Walls { at: out, lo: o_lo, hi: o_hi }
}

/// Whether a wall crosses half-line h of column k anywhere in (lo, hi).
pub fn wall_blocks(walls: Option<&Walls>, k: usize, h: usize, lo: f64, hi: f64) -> bool {
	let Some(walls) = walls else { return false };
	let key = k * 4 + h;
	(walls.at[key] as usize..walls.at[key + 1] as usize).any(|r| f64::from(walls.lo[r]) < hi && f64::from(walls.hi[r]) > lo)
}

pub fn encode_walls(walls: &Walls) -> Vec<u8> {
	let kk = 4 * COLUMNS;
	let w = walls.lo.len();
	let mut b = W(Vec::with_capacity(12 + kk + 8 * w));
	b.u32(MAGIC_WALLS);
	b.u32(WALLS_VERSION);
	b.u32(w as u32);
	for x in 0..kk {
		b.0.push((walls.at[x + 1] - walls.at[x]) as u8);
	}
	b.f32s(&walls.lo);
	b.f32s(&walls.hi);
	gzip(&b.0)
}

pub fn decode_walls(gz: &[u8]) -> Result<Walls, String> {
	let buf = gunzip(gz)?;
	let kk = 4 * COLUMNS;
	let mut r = R { b: &buf, o: 12 + kk };
	if buf.len() < 12 + kk || r.u32_at(0) != MAGIC_WALLS {
		return Err("not a nav walls file".into());
	}
	if r.u32_at(4) != WALLS_VERSION {
		return Err(format!("nav walls version {}, expected {WALLS_VERSION}", r.u32_at(4)));
	}
	let w = r.u32_at(8) as usize;
	let mut at = vec![0u32; kk + 1];
	for x in 0..kk {
		at[x + 1] = at[x] + buf[12 + x] as u32;
	}
	let lo = r.f32s(w)?;
	let hi = r.f32s(w)?;
	Ok(Walls { at, lo, hi })
}

#[derive(Clone, Debug, Default, PartialEq)]
pub struct GraphTile {
	pub col: i32,
	pub row: i32,
	pub node_base: u32,
	pub node_count: u32,
	pub comp_base: u32,
	pub comp_count: u32,
}

#[derive(Clone, Debug, Default)]
pub struct GraphProfile {
	pub off: Vec<u32>,
	pub to: Vec<u32>,
	pub terms: Vec<u16>,
}

/// A continent's abstract graph (GRAPH).
#[derive(Clone, Debug, Default)]
pub struct Graph {
	pub c: u32,
	pub tiles: Vec<GraphTile>,
	pub node_entry: Vec<u32>,
	pub node_k: Vec<u16>,
	pub node_z: Vec<f32>,
	pub region: Vec<u32>,
	pub region_size: Vec<u32>,
	pub graphs: Vec<GraphProfile>,
}

pub fn encode_graph(g: &Graph) -> Vec<u8> {
	let n = g.node_entry.len();
	let mut b = W(Vec::new());
	b.u32(MAGIC_GRAPH);
	b.u32(GRAPH_VERSION);
	b.u32(g.c);
	b.u32(g.tiles.len() as u32);
	b.u32(n as u32);
	b.u32(g.region.len() as u32);
	b.u32(g.graphs.len() as u32);
	b.u32(g.region_size.len() as u32);
	for t in &g.tiles {
		b.u16(t.col as u16);
		b.u16(t.row as u16);
		b.u32(t.node_base);
		b.u32(t.node_count);
		b.u32(t.comp_base);
		b.u32(t.comp_count);
	}
	b.u32s(&g.node_entry);
	b.u16s(&g.node_k);
	b.pad4();
	b.f32s(&g.node_z);
	b.u32s(&g.region);
	b.u32s(&g.region_size);
	for gr in &g.graphs {
		b.u32(gr.to.len() as u32);
		b.u32s(&gr.off);
		b.u32s(&gr.to);
		b.u16s(&gr.terms);
		b.pad4();
	}
	gzip(&b.0)
}

pub fn decode_graph(gz: &[u8]) -> Result<Graph, String> {
	let raw = gunzip(gz)?;
	let mut r = R { b: &raw, o: 32 };
	if raw.len() < 32 || r.u32_at(0) != MAGIC_GRAPH {
		return Err("not a nav graph".into());
	}
	if r.u32_at(4) != GRAPH_VERSION {
		return Err(format!("nav graph version {}, expected {GRAPH_VERSION}", r.u32_at(4)));
	}
	let (tn, n, rn, gn, kn) = (r.u32_at(12) as usize, r.u32_at(16) as usize, r.u32_at(20) as usize, r.u32_at(24) as usize, r.u32_at(28) as usize);
	let mut g = Graph { c: r.u32_at(8), ..Graph::default() };
	for _ in 0..tn {
		let o = r.o;
		g.tiles.push(GraphTile {
			col: r.u16_at(o) as i32,
			row: r.u16_at(o + 2) as i32,
			node_base: r.u32_at(o + 4),
			node_count: r.u32_at(o + 8),
			comp_base: r.u32_at(o + 12),
			comp_count: r.u32_at(o + 16),
		});
		r.o += 20;
	}
	g.node_entry = r.u32s(n)?;
	g.node_k = r.u16s(n)?;
	r.o = align4(r.o);
	g.node_z = r.f32s(n)?;
	g.region = r.u32s(rn)?;
	g.region_size = r.u32s(kn)?;
	for _ in 0..gn {
		let e = r.u32_at(r.o) as usize;
		r.o += 4;
		let off = r.u32s(n + 1)?;
		let to = r.u32s(e)?;
		let terms = r.u16s(e * 7)?;
		r.o = align4(r.o);
		g.graphs.push(GraphProfile { off, to, terms });
	}
	Ok(g)
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn cells_round_trip() {
		let (wx, wy) = cell_centre(30, 40, 7, 200);
		assert_eq!(cell_of(wx, wy), (30, 40, 7, 200));
	}
}
