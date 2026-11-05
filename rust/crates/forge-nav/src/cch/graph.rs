//! The coarse graph of one continent: graph/<c>.bin.gz as grid/format.js writes it (GRAPH,
//! GRAPH_VERSION 5): border-entrance nodes per tile and, per reference profile, a CSR of edges
//! (in-tile edges between a tile's nodes, links across borders, lift rides).

use std::io::Read;

const MAGIC_GRAPH: u32 = 0x5247_4e50; // 'PNGR'
const GRAPH_VERSION: u32 = 5;
pub const ADT: f64 = 1600.0 / 3.0;
pub const CELL: f64 = ADT / 256.0;

pub struct RefGraph {
	/// CSR offsets, N + 1.
	pub off: Vec<u32>,
	/// Edge target node, E.
	pub to: Vec<u32>,
}

pub struct CoarseGraph {
	pub c: u32,
	pub node_count: usize,
	/// Per node: world x, y of its column's centre (path.js graph(): nodeWx, nodeWy).
	pub wx: Vec<f64>,
	pub wy: Vec<f64>,
	pub graphs: Vec<RefGraph>,
}

fn align4(n: usize) -> usize {
	(n + 3) & !3
}

pub fn gunzip_file(path: &std::path::Path) -> std::io::Result<Vec<u8>> {
	let gz = std::fs::read(path)?;
	let isize = if gz.len() >= 18 { u32::from_le_bytes(gz[gz.len() - 4..].try_into().unwrap()) as usize } else { 0 };
	let mut out = Vec::with_capacity(isize + 1);
	flate2::read::GzDecoder::new(&gz[..]).read_to_end(&mut out)?;
	Ok(out)
}

impl CoarseGraph {
	pub fn read(path: &std::path::Path) -> std::io::Result<CoarseGraph> {
		let raw = gunzip_file(path)?;
		Self::decode(&raw).map_err(|e| std::io::Error::new(std::io::ErrorKind::InvalidData, e))
	}

	pub fn decode(raw: &[u8]) -> Result<CoarseGraph, String> {
		let u32at = |o: usize| u32::from_le_bytes(raw[o..o + 4].try_into().unwrap());
		let u16at = |o: usize| u16::from_le_bytes(raw[o..o + 2].try_into().unwrap());
		if raw.len() < 32 || u32at(0) != MAGIC_GRAPH {
			return Err("not a nav graph".into());
		}
		if u32at(4) != GRAPH_VERSION {
			return Err(format!("nav graph version {}, expected {GRAPH_VERSION}", u32at(4)));
		}
		let c = u32at(8);
		let t = u32at(12) as usize;
		let n = u32at(16) as usize;
		let r = u32at(20) as usize;
		let g = u32at(24) as usize;
		let k = u32at(28) as usize;
		let mut o = 32;
		let mut wx = vec![0.0; n];
		let mut wy = vec![0.0; n];
		let tiles_at = o;
		o += 20 * t;
		// node entry u32[N], node k u16[N] (pad 4), node z f32[N], region u32[R], regionSize u32[K]
		o = align4(o + 4 * n);
		let k_at = o;
		o = align4(o + 2 * n);
		o = align4(o + 4 * n);
		o = align4(o + 4 * r);
		o = align4(o + 4 * k);
		for ti in 0..t {
			let b = tiles_at + 20 * ti;
			let col = u16at(b) as f64;
			let row = u16at(b + 2) as f64;
			let base = u32at(b + 4) as usize;
			let cnt = u32at(b + 8) as usize;
			for x in base..base + cnt {
				let kk = u16at(k_at + 2 * x) as u32;
				wx[x] = (32.0 - row) * ADT - (((kk >> 8) as f64) + 0.5) * CELL;
				wy[x] = (32.0 - col) * ADT - (((kk & 255) as f64) + 0.5) * CELL;
			}
		}
		let mut graphs = Vec::with_capacity(g);
		for _ in 0..g {
			let e = u32at(o) as usize;
			o += 4;
			let off: Vec<u32> = (0..=n).map(|i| u32at(o + 4 * i)).collect();
			o = align4(o + 4 * (n + 1));
			let to: Vec<u32> = (0..e).map(|i| u32at(o + 4 * i)).collect();
			o = align4(o + 4 * e);
			o = align4(o + 2 * e * 7);
			graphs.push(RefGraph { off, to });
		}
		Ok(CoarseGraph { c, node_count: n, wx, wy, graphs })
	}
}
