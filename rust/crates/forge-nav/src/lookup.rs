//! The sim's walk table (port of tools/lib/sim/walklookup.js) and the walks document it is built
//! from (walks.js readWalks over a `walks-<faction>.bin`, BIN_SCHEMA 5).
//!
//! Per band a CSR table by source point, neighbours sorted; a both-ways pair is entered both ways,
//! a one-way pair from a to b only; of a neighbour's entries the last wins (one-way over both-ways,
//! then the last occurrence), as attachWalks' Map does. Yards are stored yards × the document's
//! smooth (f32), cost as stored (f32). `yd` gives -1 for none and +inf for a pair the document marks
//! unwalkable (a cliff and its foot, both orders); a band other than 0 falls back to band 0.

use crate::psbn::{Bin, Error};
use rustc_hash::FxHashSet;
use serde_json::{Map, Value};

/// walks.js SMOOTH: the walked yards per stored yard of a document without `smooth` (the Lua router's).
pub const SMOOTH_LUA: f64 = 0.965;

#[derive(Clone, Debug, Default)]
pub struct Band {
	pub offsets: Vec<u32>,
	pub nbr: Vec<i32>,
	pub yd: Vec<f32>,
	pub cost: Vec<f32>,
	pub src: Vec<i32>,
}

impl Band {
	/// walklookup.js buildBand: pairs `[a, b, yards, cost, (oneWay)]` with `stride` 5 (or 4: both ways).
	pub fn build(arr: &[f64], nw: usize, stride: usize, smooth: f64) -> Band {
		let one_way = |i: usize| stride == 5 && arr[i + 4] == 1.0;
		let mut offsets = vec![0u32; nw + 1];
		let mut i = 0;
		while i < arr.len() {
			offsets[arr[i] as usize + 1] += 1;
			if !one_way(i) {
				offsets[arr[i + 1] as usize + 1] += 1;
			}
			i += stride;
		}
		for p in 0..nw {
			offsets[p + 1] += offsets[p];
		}
		let total = offsets[nw] as usize;
		let mut nbr = vec![0i32; total];
		let mut yd = vec![0f32; total];
		let mut cost = vec![0f32; total];
		let mut one = vec![0u8; total];
		let mut src = vec![0i32; total];
		let mut fill: Vec<u32> = offsets[..nw].to_vec();
		let mut put = |a: usize, b: f64, y: f64, c: f64, o: u8, i: usize| {
			let k = fill[a] as usize;
			fill[a] += 1;
			nbr[k] = b as i32;
			yd[k] = y as f32;
			cost[k] = c as f32;
			one[k] = o;
			src[k] = (i / stride) as i32;
		};
		let mut i = 0;
		while i < arr.len() {
			let y = arr[i + 2] * smooth;
			if one_way(i) {
				put(arr[i] as usize, arr[i + 1], y, arr[i + 3], 1, i);
			} else {
				put(arr[i] as usize, arr[i + 1], y, arr[i + 3], 0, i);
				put(arr[i + 1] as usize, arr[i], y, arr[i + 3], 0, i);
			}
			i += stride;
		}
		let mut w = 0usize;
		let mut lo = 0usize;
		let mut idx: Vec<usize> = Vec::new();
		let (mut sn, mut sy, mut sc, mut ss) = (Vec::new(), Vec::new(), Vec::new(), Vec::new());
		for p in 0..nw {
			let hi = offsets[p + 1] as usize;
			idx.clear();
			idx.extend(lo..hi);
			idx.sort_by(|&x, &z| nbr[x].cmp(&nbr[z]).then(one[x].cmp(&one[z])).then(x.cmp(&z)));
			sn.clear();
			sy.clear();
			sc.clear();
			ss.clear();
			for j in 0..idx.len() {
				let k = idx[j];
				if j + 1 < idx.len() && nbr[idx[j + 1]] == nbr[k] {
					continue; // a later entry wins
				}
				sn.push(nbr[k]);
				sy.push(yd[k]);
				sc.push(cost[k]);
				ss.push(src[k]);
			}
			nbr[w..w + sn.len()].copy_from_slice(&sn);
			yd[w..w + sn.len()].copy_from_slice(&sy);
			cost[w..w + sn.len()].copy_from_slice(&sc);
			src[w..w + sn.len()].copy_from_slice(&ss);
			offsets[p] = w as u32;
			w += sn.len();
			lo = hi;
		}
		offsets[nw] = w as u32;
		nbr.truncate(w);
		yd.truncate(w);
		cost.truncate(w);
		src.truncate(w);
		Band { offsets, nbr, yd, cost, src }
	}

	/// The entry of (a, b), or None (walklookup.js find).
	pub fn find(&self, a: usize, b: i32) -> Option<usize> {
		let lo = self.offsets[a] as usize;
		let hi = self.offsets[a + 1] as usize;
		self.nbr[lo..hi].binary_search(&b).ok().map(|k| lo + k)
	}

	pub fn bytes(&self) -> usize {
		4 * (self.offsets.len() + self.nbr.len() + self.yd.len() + self.cost.len() + self.src.len())
	}

	/// The rows as (a, b, entry) in table order.
	pub fn entries(&self) -> impl Iterator<Item = (usize, i32, usize)> + '_ {
		(0..self.offsets.len().saturating_sub(1)).flat_map(move |a| (self.offsets[a] as usize..self.offsets[a + 1] as usize).map(move |k| (a, self.nbr[k], k)))
	}
}

/// A walks document as walks.js readWalks gives it (a `.bin`): header fields, pairs per band,
/// the prebuilt tables, the unwalkable pairs and the zone shares' CSR.
pub struct WalksDoc {
	pub header: Map<String, Value>,
	pub bands: Vec<i64>,
	pub pairs: Vec<Vec<f64>>,
	pub lookup: Vec<Option<Band>>,
	pub unwalkable: Vec<i32>,
	pub zones: Option<(Vec<u32>, Vec<f64>, Vec<u8>)>,
}

impl WalksDoc {
	pub fn read(bytes: &[u8]) -> Result<WalksDoc, Error> {
		let bin = Bin::parse(bytes)?;
		let header = bin.header.clone();
		let bands: Vec<i64> = header.get("bands").and_then(|b| b.as_array()).ok_or_else(|| Error("walks: no bands".into()))?.iter().filter_map(|v| v.as_i64()).collect();
		let mut pairs = Vec::new();
		let mut lookup = Vec::new();
		for b in &bands {
			pairs.push(bin.f64s(&format!("p{b}"))?);
			lookup.push(if bin.has(&format!("L{b}.offsets")) {
				Some(Band {
					offsets: bin.u32s(&format!("L{b}.offsets"))?,
					nbr: bin.i32s(&format!("L{b}.nbr"))?,
					yd: bin.f32s(&format!("L{b}.yd"))?,
					cost: bin.f32s(&format!("L{b}.cost"))?,
					src: bin.i32s(&format!("L{b}.src"))?,
				})
			} else {
				None
			});
		}
		let unwalkable = if bin.has("unwalkable") { bin.i32s("unwalkable")? } else { Vec::new() };
		let zones = if bin.has("zoff") { Some((bin.u32s("zoff")?, bin.f64s("zval")?, bin.u8s("zhas")?)) } else { None };
		Ok(WalksDoc { header, bands, pairs, lookup, unwalkable, zones })
	}

	pub fn nw(&self) -> Option<usize> {
		self.header.get("nw").and_then(|v| v.as_u64()).map(|v| v as usize)
	}

	/// walks.js smoothOf.
	pub fn smooth(&self) -> f64 {
		self.header.get("smooth").and_then(|v| v.as_f64()).unwrap_or(SMOOTH_LUA)
	}

	/// walks.js pairStride.
	pub fn stride(&self) -> usize {
		if self.header.get("schema").and_then(|v| v.as_i64()).unwrap_or(0) >= 3 {
			5
		} else {
			4
		}
	}

	pub fn str(&self, k: &str) -> Option<&str> {
		self.header.get(k).and_then(|v| v.as_str())
	}
}

/// walklookup.js buildLookup.
pub struct Lookup {
	pub nw: usize,
	pub bands: Vec<(i64, Band)>,
	unwalk: FxHashSet<u64>,
	pub smooth: f64,
	zones: Option<(Vec<u32>, Vec<f64>, Vec<u8>)>,
}

impl Lookup {
	pub fn new(doc: WalksDoc, nw: usize) -> Lookup {
		let stride = doc.stride();
		let smooth = doc.smooth();
		let built = doc.nw() == Some(nw);
		let mut bands = Vec::new();
		for ((b, arr), l) in doc.bands.iter().zip(&doc.pairs).zip(doc.lookup) {
			let t = match l {
				Some(t) if built => t,
				_ => Band::build(arr, nw, stride, smooth),
			};
			bands.push((*b, t));
		}
		bands.sort_by_key(|x| x.0);
		let mut unwalk = FxHashSet::default();
		for p in doc.unwalkable.chunks_exact(2) {
			unwalk.insert(p[0] as u64 * nw as u64 + p[1] as u64);
			unwalk.insert(p[1] as u64 * nw as u64 + p[0] as u64);
		}
		Lookup { nw, bands, unwalk, smooth, zones: doc.zones }
	}

	pub fn band(&self, band: i64) -> Option<&Band> {
		self.bands.iter().find(|x| x.0 == band).map(|x| &x.1)
	}

	pub fn unwalkable(&self, a: usize, b: usize) -> bool {
		self.unwalk.contains(&(a as u64 * self.nw as u64 + b as u64))
	}

	/// [yards, cost] of the walk a -> b in `band` (else band 0's), or None.
	pub fn get(&self, a: i64, b: i64, band: i64) -> Option<(f32, f32)> {
		if !(a >= 0 && (a as usize) < self.nw) {
			return None;
		}
		let a = a as usize;
		if let Some(t) = self.band(band) {
			if let Some(k) = t.find(a, b as i32) {
				return Some((t.yd[k], t.cost[k]));
			}
		}
		let base = self.band(0)?;
		if band == 0 {
			return None;
		}
		base.find(a, b as i32).map(|k| (base.yd[k], base.cost[k]))
	}

	/// get's yards without allocating: -1 none, +inf unwalkable.
	pub fn yd(&self, a: i64, b: i64, band: i64) -> f32 {
		if !(a >= 0 && (a as usize) < self.nw) {
			return -1.0;
		}
		let none = || if self.unwalk.contains(&(a as u64 * self.nw as u64 + b as u64)) { f32::INFINITY } else { -1.0 };
		let ai = a as usize;
		if let Some(t) = self.band(band) {
			if let Some(k) = t.find(ai, b as i32) {
				return t.yd[k];
			}
		}
		let Some(base) = self.band(0) else { return none() };
		if band == 0 {
			return none();
		}
		base.find(ai, b as i32).map(|k| base.yd[k]).unwrap_or_else(none)
	}

	/// The band holds the pair itself (no fallback).
	pub fn has(&self, a: i64, b: i64, band: i64) -> bool {
		a >= 0 && (a as usize) < self.nw && self.band(band).is_some_and(|t| t.find(a as usize, b as i32).is_some())
	}

	/// The base walk's yards per zone, flat [zone, yards, ...], or None.
	pub fn zones(&self, a: i64, b: i64) -> Option<&[f64]> {
		let (off, val, has) = self.zones.as_ref()?;
		if !(a >= 0 && (a as usize) < self.nw) {
			return None;
		}
		let base = self.band(0)?;
		let k = base.find(a as usize, b as i32)?;
		let s = base.src[k] as usize;
		if has[s] == 0 {
			return None;
		}
		Some(&val[off[s] as usize..off[s + 1] as usize])
	}

	pub fn bytes(&self) -> usize {
		self.bands.iter().map(|b| b.1.bytes()).sum()
	}
}
