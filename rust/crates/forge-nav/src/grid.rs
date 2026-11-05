//! The walking grid's files (port of tools/lib/nav/grid/format.js TILE v3/v4 and GRAPH v5 readers,
//! path.js Nav.tile/graph/region and lift rides): `<dir>/index.json`, `lifts.json`,
//! `tiles/<c>/<col>_<row>.nav.gz`, `graph/<c>.bin.gz`.
//!
//! Columns: k = j * 256 + i, i east (wy decreasing), j south (wx decreasing); centre
//! wx = (32 - row) * ADT - (j + 0.5) * CELL, wy = (32 - col) * ADT - (i + 0.5) * CELL.

use parking_lot::Mutex;
use rustc_hash::FxHashMap;
use std::io::Read;
use std::path::{Path, PathBuf};
use std::sync::{Arc, OnceLock};

pub const ADT: f64 = 1600.0 / 3.0;
pub const TILE_CELLS: usize = 256;
pub const CELL: f64 = ADT / 256.0;
pub const COLUMNS: usize = TILE_CELLS * TILE_CELLS;
pub const AGENT_HEIGHT: f64 = 1.6;
pub const STEP: f64 = 1.0;
pub const WALK_MAX: f64 = 50.0;
pub const SAFE_FALL: f64 = 14.57;

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

pub const LINK_SLOPE: u8 = 7;
pub const CODE_LIFT: u8 = 8;
pub const NO_LINK: u8 = 0xff;
pub const NO_COMP: u32 = 0xffff_ffff;
pub const DIRS: [(i32, i32); 8] = [(1, 0), (1, 1), (0, 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1)];
pub const FALL_SLIDE: i32 = 12;
pub const FALL_SPAN: i32 = 2 * FALL_SLIDE + 1;

const MAGIC_TILE: u32 = 0x564e_4150;
const MAGIC_GRAPH: u32 = 0x5247_4e50;
const GRAPH_VERSION: u32 = 5;

/// A lift ride from an entry: the landing's tile, column and entry, and the height (landing - start).
#[derive(Clone, Debug)]
pub struct Ride {
	pub col: u32,
	pub row: u32,
	pub k: u32,
	pub entry: u32,
	pub h: f64,
}

/// Falls landing inside a tile, by landing (search.js fallsInto).
pub struct FallsInto {
	pub at: Vec<u32>,
	pub from: Vec<u32>,
	pub k: Vec<u32>,
}

/// A linked tile (format.js decodeTile; only tiles with links are routed).
pub struct Tile {
	pub c: u32,
	pub col: u32,
	pub row: u32,
	pub n: usize,
	pub areas: Vec<u16>,
	pub first: Vec<u32>,
	pub z: Vec<f32>,
	pub ceil: Vec<f32>,
	pub comp: Vec<u32>,
	pub fall_from: Vec<u32>,
	pub fall_to: Vec<u16>,
	pub flags: Vec<u8>,
	pub slope: Vec<u8>,
	/// Format 4: the steepest terrain triangle of each entry's span, degrees (empty on a v3 tile).
	pub tslope: Vec<u8>,
	pub links: Vec<u8>,
	pub lifts: Option<FxHashMap<u32, Vec<Ride>>>,
	fall_at: OnceLock<Vec<u32>>,
	falls_into: OnceLock<FallsInto>,
	/// isOpen per entry (path.js Nav.isOpen's cache).
	pub open: Mutex<FxHashMap<u32, bool>>,
	/// The class byte of every column (router.js groundOf), set once by the router.
	pub ground: OnceLock<Vec<u8>>,
	/// The zone of each 16 x 16 chunk (router.js zs.chunks), set once by the router.
	pub chunk_zone: OnceLock<Vec<u16>>,
}

fn rd<T: Copy, const N: usize>(b: &[u8], o: &mut usize, n: usize, f: fn([u8; N]) -> T) -> Vec<T> {
	let v = b[*o..*o + n * N].chunks_exact(N).map(|c| f(c.try_into().unwrap())).collect();
	*o += n * N;
	v
}

pub fn gunzip(gz: &[u8]) -> std::io::Result<Vec<u8>> {
	let isize = if gz.len() >= 18 { u32::from_le_bytes(gz[gz.len() - 4..].try_into().unwrap()) as usize } else { 0 };
	let mut out = Vec::with_capacity(isize);
	flate2::read::GzDecoder::new(gz).read_to_end(&mut out)?;
	Ok(out)
}

impl Tile {
	pub fn decode(raw: &[u8]) -> Result<Tile, String> {
		let u32at = |o: usize| u32::from_le_bytes(raw[o..o + 4].try_into().unwrap());
		if raw.len() < 32 || u32at(0) != MAGIC_TILE {
			return Err("not a nav tile".into());
		}
		let version = u32at(4);
		if version != 3 && version != 4 {
			return Err(format!("nav tile version {version}"));
		}
		let n = u32at(16) as usize;
		let m = u32at(20) as usize;
		let has_links = u32at(28) & 1 == 1;
		let mut o = 32;
		let areas = rd(raw, &mut o, 256, u16::from_le_bytes);
		let count = &raw[o..o + COLUMNS];
		o += COLUMNS;
		let z = rd(raw, &mut o, n, f32::from_le_bytes);
		let ceil = rd(raw, &mut o, n, f32::from_le_bytes);
		let (mut comp, mut fall_from, mut fall_to) = (Vec::new(), Vec::new(), Vec::new());
		if has_links {
			comp = rd(raw, &mut o, n, u32::from_le_bytes);
			fall_from = rd(raw, &mut o, m, u32::from_le_bytes);
			fall_to = rd(raw, &mut o, m, u16::from_le_bytes);
			o = (o + 3) & !3;
		}
		let flags = raw[o..o + n].to_vec();
		o += n;
		let slope = raw[o..o + n].to_vec();
		o += n;
		let links = if has_links { raw[o..o + 8 * n].to_vec() } else { Vec::new() };
		if has_links {
			o += 8 * n;
		}
		let tslope = if version >= 4 && raw.len() >= o + n { raw[o..o + n].to_vec() } else { Vec::new() };
		let mut first = vec![0u32; COLUMNS + 1];
		for k in 0..COLUMNS {
			first[k + 1] = first[k] + count[k] as u32;
		}
		Ok(Tile {
			c: u32at(8),
			col: u16::from_le_bytes(raw[12..14].try_into().unwrap()) as u32,
			row: u16::from_le_bytes(raw[14..16].try_into().unwrap()) as u32,
			n,
			areas,
			first,
			z,
			ceil,
			comp,
			fall_from,
			fall_to,
			flags,
			slope,
			tslope,
			links,
			lifts: None,
			fall_at: OnceLock::new(),
			falls_into: OnceLock::new(),
			open: Mutex::new(FxHashMap::default()),
			ground: OnceLock::new(),
			chunk_zone: OnceLock::new(),
		})
	}

	pub fn has_links(&self) -> bool {
		!self.links.is_empty() || self.n == 0
	}

	/// The falls of each entry: [at[e], at[e + 1]) in fallFrom (search.js fallIndex).
	pub fn fall_at(&self) -> &[u32] {
		self.fall_at.get_or_init(|| {
			let mut at = vec![0u32; self.n + 1];
			for &f in &self.fall_from {
				at[f as usize + 1] += 1;
			}
			for e in 0..self.n {
				at[e + 1] += at[e];
			}
			at
		})
	}

	/// search.js fallsInto.
	pub fn falls_into(&self) -> &FallsInto {
		self.falls_into.get_or_init(|| {
			let m = self.fall_from.len();
			let mut to = Vec::with_capacity(m);
			let mut fk = Vec::with_capacity(m);
			let mut fe = Vec::with_capacity(m);
			let mut f = 0;
			let mut k = 0;
			while k < COLUMNS && f < m {
				let i = (k & 255) as i32;
				let j = (k >> 8) as i32;
				while f < m && self.fall_from[f] < self.first[k + 1] {
					let off = (self.fall_to[f] >> 5) as i32;
					let ni = i + off.div_euclid(FALL_SPAN) - FALL_SLIDE;
					let nj = j + off.rem_euclid(FALL_SPAN) - FALL_SLIDE;
					if !(ni < 0 || nj < 0 || ni >= TILE_CELLS as i32 || nj >= TILE_CELLS as i32) {
						to.push(self.first[(nj as usize) * TILE_CELLS + ni as usize] + (self.fall_to[f] & 31) as u32);
						fe.push(self.fall_from[f]);
						fk.push(k as u32);
					}
					f += 1;
				}
				k += 1;
			}
			let mut at = vec![0u32; self.n + 1];
			for &v in &to {
				at[v as usize + 1] += 1;
			}
			for v in 0..self.n {
				at[v + 1] += at[v];
			}
			let mut fill: Vec<u32> = at[..self.n].to_vec();
			let mut from = vec![0u32; to.len()];
			let mut kk = vec![0u32; to.len()];
			for x in 0..to.len() {
				let y = fill[to[x] as usize] as usize;
				fill[to[x] as usize] += 1;
				from[y] = fe[x];
				kk[y] = fk[x];
			}
			FallsInto { at, from, k: kk }
		})
	}

	pub fn wx(&self, k: usize) -> f64 {
		(32.0 - self.row as f64) * ADT - ((k >> 8) as f64 + 0.5) * CELL
	}
	pub fn wy(&self, k: usize) -> f64 {
		(32.0 - self.col as f64) * ADT - ((k & 255) as f64 + 0.5) * CELL
	}
}

#[derive(Clone, Copy, Debug)]
pub struct GTile {
	pub col: u32,
	pub row: u32,
	pub node_base: u32,
	pub node_count: u32,
	pub comp_base: u32,
	pub comp_count: u32,
}

/// A continent's abstract graph (format.js decodeGraphRaw; graph 0, the foot graph, kept).
pub struct Graph {
	pub c: u32,
	pub tiles: Vec<GTile>,
	pub at: FxHashMap<u32, u32>,
	pub node_entry: Vec<u32>,
	pub node_k: Vec<u16>,
	pub node_z: Vec<f32>,
	pub node_tile: Vec<u32>,
	pub region: Vec<u32>,
	pub region_size: Vec<u32>,
	pub off: Vec<u32>,
	pub to: Vec<u32>,
}

impl Graph {
	pub fn decode(raw: &[u8]) -> Result<Graph, String> {
		let u32at = |o: usize| u32::from_le_bytes(raw[o..o + 4].try_into().unwrap());
		if u32at(0) != MAGIC_GRAPH {
			return Err("not a nav graph".into());
		}
		if u32at(4) != GRAPH_VERSION {
			return Err(format!("nav graph version {}", u32at(4)));
		}
		let (t, n, r, k) = (u32at(12) as usize, u32at(16) as usize, u32at(20) as usize, u32at(28) as usize);
		let mut o = 32;
		let mut tiles = Vec::with_capacity(t);
		for _ in 0..t {
			let u16at = |o: usize| u16::from_le_bytes(raw[o..o + 2].try_into().unwrap()) as u32;
			tiles.push(GTile { col: u16at(o), row: u16at(o + 2), node_base: u32at(o + 4), node_count: u32at(o + 8), comp_base: u32at(o + 12), comp_count: u32at(o + 16) });
			o += 20;
		}
		let a4 = |o: &mut usize| *o = (*o + 3) & !3;
		let node_entry = rd(raw, &mut o, n, u32::from_le_bytes);
		a4(&mut o);
		let node_k = rd(raw, &mut o, n, u16::from_le_bytes);
		a4(&mut o);
		let node_z = rd(raw, &mut o, n, f32::from_le_bytes);
		let region = rd(raw, &mut o, r, u32::from_le_bytes);
		let region_size = rd(raw, &mut o, k, u32::from_le_bytes);
		let e = u32at(o) as usize;
		o += 4;
		let off = rd(raw, &mut o, n + 1, u32::from_le_bytes);
		let to = rd(raw, &mut o, e, u32::from_le_bytes);
		let at = tiles.iter().enumerate().map(|(i, t)| (t.col * 65536 + t.row, i as u32)).collect();
		let mut node_tile = vec![0u32; n];
		for (ti, t) in tiles.iter().enumerate() {
			for x in t.node_base..t.node_base + t.node_count {
				node_tile[x as usize] = ti as u32;
			}
		}
		Ok(Graph { c: u32at(8), tiles, at, node_entry, node_k, node_z, node_tile, region, region_size, off, to })
	}

	/// Graph 0's edge terms (E × 7 uint16, after its `to` array; decodeGraphRaw's `terms`).
	pub fn terms(raw: &[u8]) -> Result<Vec<u16>, String> {
		let u32at = |o: usize| u32::from_le_bytes(raw[o..o + 4].try_into().unwrap());
		if raw.len() < 32 || u32at(0) != MAGIC_GRAPH || u32at(4) != GRAPH_VERSION {
			return Err("not a nav graph of this version".into());
		}
		let (t, n, r, k) = (u32at(12) as usize, u32at(16) as usize, u32at(20) as usize, u32at(28) as usize);
		let a4 = |o: usize| (o + 3) & !3;
		let mut o = 32 + 20 * t;
		o = a4(o + 4 * n); // nodeEntry
		o = a4(o + 2 * n); // nodeK
		o += 4 * n + 4 * r + 4 * k; // nodeZ, region, regionSize
		let e = u32at(o) as usize;
		o += 4 + 4 * (n + 1) + 4 * e; // E, off, to
		let mut o2 = o;
		Ok(rd(raw, &mut o2, 7 * e, u16::from_le_bytes))
	}

	pub fn tile_of(&self, col: u32, row: u32) -> Option<&GTile> {
		self.at.get(&(col * 65536 + row)).map(|&i| &self.tiles[i as usize])
	}

	pub fn edges(&self) -> usize {
		self.to.len()
	}
}

/// The grid: index, lift rides, tiles (kept, least recently used dropped) and graphs.
pub struct Grid {
	pub dir: PathBuf,
	pub index: serde_json::Value,
	pub built_at: String,
	rides: FxHashMap<(u32, u32, u32), FxHashMap<u32, Vec<Ride>>>,
	tiles: Mutex<TileCache>,
	graphs: Mutex<FxHashMap<u32, Option<Arc<Graph>>>>,
}

struct TileCache {
	map: FxHashMap<(u32, u32, u32), (Option<Arc<Tile>>, u64)>,
	tick: u64,
	cap: usize,
}

impl Grid {
	pub fn open(dir: &Path, cache_tiles: usize) -> Result<Grid, String> {
		let index: serde_json::Value = serde_json::from_slice(&std::fs::read(dir.join("index.json")).map_err(|e| format!("{}: {e}", dir.display()))?).map_err(|e| e.to_string())?;
		let built_at = index["builtAt"].as_str().unwrap_or("").to_string();
		let mut rides: FxHashMap<(u32, u32, u32), FxHashMap<u32, Vec<Ride>>> = FxHashMap::default();
		if let Ok(b) = std::fs::read(dir.join("lifts.json")) {
			let lifts: serde_json::Value = serde_json::from_slice(&b).map_err(|e| e.to_string())?;
			for (c, list) in lifts.as_object().into_iter().flatten() {
				let c: u32 = c.parse().unwrap_or(0);
				for l in list.as_array().into_iter().flatten() {
					for (x, y) in [(&l["a"], &l["b"]), (&l["b"], &l["a"])] {
						let g = |v: &serde_json::Value, f: &str| v[f].as_f64().unwrap_or(0.0);
						let key = (c, g(x, "col") as u32, g(x, "row") as u32);
						rides.entry(key).or_default().entry(g(x, "entry") as u32).or_default().push(Ride {
							col: g(y, "col") as u32,
							row: g(y, "row") as u32,
							k: g(y, "k") as u32,
							entry: g(y, "entry") as u32,
							h: g(y, "z") - g(x, "z"),
						});
					}
				}
			}
		}
		Ok(Grid { dir: dir.to_path_buf(), index, built_at, rides, tiles: Mutex::new(TileCache { map: FxHashMap::default(), tick: 0, cap: cache_tiles }), graphs: Mutex::new(FxHashMap::default()) })
	}

	/// A linked tile with its lift rides, or None.
	pub fn tile(&self, c: u32, col: i64, row: i64) -> Option<Arc<Tile>> {
		if !(0..64).contains(&col) || !(0..64).contains(&row) {
			return None;
		}
		let key = (c, col as u32, row as u32);
		{
			let mut tc = self.tiles.lock();
			tc.tick += 1;
			let tick = tc.tick;
			if let Some(v) = tc.map.get_mut(&key) {
				v.1 = tick;
				return v.0.clone();
			}
		}
		let file = self.dir.join("tiles").join(c.to_string()).join(format!("{col}_{row}.nav.gz"));
		let t = std::fs::read(file).ok().and_then(|gz| gunzip(&gz).ok()).and_then(|raw| Tile::decode(&raw).ok()).filter(|t| !t.links.is_empty()).map(|mut t| {
			t.lifts = self.rides.get(&key).cloned();
			Arc::new(t)
		});
		let mut tc = self.tiles.lock();
		tc.tick += 1;
		let tick = tc.tick;
		tc.map.insert(key, (t.clone(), tick));
		if tc.map.len() > tc.cap {
			// Drop the least recently used quarter.
			let mut ticks: Vec<u64> = tc.map.values().map(|v| v.1).collect();
			ticks.sort_unstable();
			let cut = ticks[ticks.len() / 4];
			tc.map.retain(|_, v| v.1 > cut);
		}
		t
	}

	pub fn graph(&self, c: u32) -> Option<Arc<Graph>> {
		if let Some(g) = self.graphs.lock().get(&c) {
			return g.clone();
		}
		let g = std::fs::read(self.dir.join("graph").join(format!("{c}.bin.gz"))).ok().and_then(|gz| gunzip(&gz).ok()).and_then(|raw| Graph::decode(&raw).ok()).map(Arc::new);
		self.graphs.lock().insert(c, g.clone());
		g
	}

	/// path.js Nav.region.
	pub fn region(&self, c: u32, col: u32, row: u32, entry: u32) -> Option<u32> {
		let g = self.graph(c)?;
		let t = self.tile(c, col as i64, row as i64)?;
		let gt = g.tile_of(col, row)?;
		if t.comp[entry as usize] == NO_COMP {
			return None;
		}
		Some(g.region[(gt.comp_base + t.comp[entry as usize]) as usize])
	}

	/// path.js Nav.regionSize.
	pub fn region_size(&self, c: u32, col: u32, row: u32, entry: u32) -> Option<u32> {
		let r = self.region(c, col, row, entry)?;
		Some(self.graph(c)?.region_size[r as usize])
	}

	/// The size of the graph file (walk graph and mix file names).
	pub fn graph_file_size(&self, c: u32) -> u64 {
		std::fs::metadata(self.dir.join("graph").join(format!("{c}.bin.gz"))).map(|m| m.len()).unwrap_or(0)
	}

	/// Graph 0's edge terms of continent c (format.js decodeGraphRaw's `terms`: 7 quantised
	/// uint16 per edge, graph.js TERM_SCALE), read from the graph file each call (not kept: only
	/// the walk graph builder needs them).
	pub fn graph_terms(&self, c: u32) -> Option<Vec<u16>> {
		let raw = std::fs::read(self.dir.join("graph").join(format!("{c}.bin.gz"))).ok().and_then(|gz| gunzip(&gz).ok())?;
		Graph::terms(&raw).ok()
	}
}

/// format.js cellOf: the tile and column of a world point.
pub fn cell_of(wx: f64, wy: f64) -> (i64, i64, i64, i64) {
	let u = (32.0 * ADT - wy) / CELL;
	let v = (32.0 * ADT - wx) / CELL;
	let gi = u.floor() as i64;
	let gj = v.floor() as i64;
	let col = gi.div_euclid(TILE_CELLS as i64);
	let row = gj.div_euclid(TILE_CELLS as i64);
	(col, row, gi - col * TILE_CELLS as i64, gj - row * TILE_CELLS as i64)
}

/// format.js cellCentre.
pub fn cell_centre(col: i64, row: i64, i: i64, j: i64) -> (f64, f64) {
	((32.0 - row as f64) * ADT - (j as f64 + 0.5) * CELL, (32.0 - col as f64) * ADT - (i as f64 + 0.5) * CELL)
}
