//! Test helpers: the JS grid builder's stage files on the committed synthetic grid
//! (rust/tests/golden/nav-grid, its README), read as forge-navbuild's types.
//!
//! POLESTAR_NAV_SCRATCH=<dir> reads the old local references instead: the Zephras Isle (map 2991) JS dumps
//! of RsWriter's scratch dump.js (<dir>/NavSurfaces/out/2991, <dir>/js/tiles/2991, <dir>/js/graph/2991.bin.gz).
#![allow(dead_code)]
use forge_navbuild::format::{gunzip, LiftRide, Tile};
use forge_navbuild::geom::{Cut, Geometry, Mh2o, WmoLiquid};
use forge_navbuild::graph::{Lift, LiftEnd};
use serde_json::Value;
use std::path::{Path, PathBuf};

pub fn golden() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden/nav-grid")
}

/// Where a grid's stage files are: the JS's geometry, its surfaces-only tiles and walls, its linked
/// tiles and graph parts, its continent graph and lifts.
pub struct Src {
	pub c: u32,
	pub geom: PathBuf,
	pub surf: PathBuf,
	/// The linked tiles (.nav.gz) and graph parts (.hpa.gz).
	pub tiles: PathBuf,
	pub graph: PathBuf,
	pub lifts: Vec<Lift>,
}

pub fn src() -> Src {
	if let Ok(s) = std::env::var("POLESTAR_NAV_SCRATCH") {
		let s = PathBuf::from(s);
		let out = s.join("NavSurfaces/out/2991");
		return Src { c: 2991, geom: out.clone(), surf: out, tiles: s.join("js/tiles/2991"), graph: s.join("js/graph/2991.bin.gz"), lifts: Vec::new() };
	}
	let g = golden();
	let lifts: Value = serde_json::from_slice(&std::fs::read(g.join("nav4/lifts.json")).expect("golden nav-grid lifts.json")).unwrap();
	let end = |v: &Value| LiftEnd {
		col: v["col"].as_i64().unwrap() as i32,
		row: v["row"].as_i64().unwrap() as i32,
		k: v["k"].as_u64().unwrap() as u32,
		entry: v["entry"].as_u64().unwrap() as u32,
		z: v["z"].as_f64().unwrap(),
	};
	let lifts = lifts["0"]
		.as_array()
		.unwrap()
		.iter()
		.map(|l| Lift { name: l["name"].as_str().unwrap().into(), id: l["id"].as_u64().unwrap() as u32, a: end(&l["a"]), b: end(&l["b"]), h: l["h"].as_f64().unwrap() })
		.collect();
	Src { c: 0, geom: g.join("geom/0"), surf: g.join("surf/0"), tiles: g.join("nav4/tiles/0"), graph: g.join("nav4/graph/0.bin.gz"), lifts }
}

impl Src {
	/// The tiles (col, row) with a geometry file.
	pub fn tiles_listed(&self) -> Vec<(i32, i32)> {
		let mut v: Vec<(i32, i32)> = std::fs::read_dir(&self.geom)
			.unwrap_or_else(|e| panic!("{}: {e}", self.geom.display()))
			.filter_map(|e| e.ok()?.file_name().to_str()?.strip_suffix(".geom.gz").and_then(|k| k.split_once('_')).map(|(a, b)| (a.parse().unwrap(), b.parse().unwrap())))
			.collect();
		v.sort();
		assert!(!v.is_empty(), "no geometry in {}", self.geom.display());
		v
	}

	/// A tile's lift rides (build.js ridesOf): (from entry, ride).
	pub fn rides(&self, col: i32, row: i32) -> Vec<(u32, LiftRide)> {
		let mut out = Vec::new();
		for l in &self.lifts {
			if l.a.col == col && l.a.row == row {
				out.push((l.a.entry, LiftRide { col: l.b.col, row: l.b.row, k: l.b.k, entry: l.b.entry, h: l.b.z - l.a.z }));
			}
			if l.b.col == col && l.b.row == row {
				out.push((l.b.entry, LiftRide { col: l.a.col, row: l.a.row, k: l.a.k, entry: l.a.entry, h: l.a.z - l.b.z }));
			}
		}
		out
	}

	/// worker.js's graph job: the centre tile's `lifts` (entry -> rides, in insertion order) and the entries.
	pub fn set_lifts(&self, t: &mut Tile, col: i32, row: i32) -> Vec<u32> {
		let rides = self.rides(col, row);
		let mut lifts: Vec<(u32, Vec<LiftRide>)> = Vec::new();
		for (from, r) in &rides {
			match lifts.iter_mut().find(|x| x.0 == *from) {
				Some(x) => x.1.push(r.clone()),
				None => lifts.push((*from, vec![r.clone()])),
			}
		}
		t.lifts = if rides.is_empty() { None } else { Some(lifts) };
		rides.iter().map(|r| r.0).collect()
	}

	pub fn read_geom(&self, col: i32, row: i32) -> Geometry {
		let raw = gunzip(&std::fs::read(self.geom.join(format!("{col}_{row}.geom.gz"))).unwrap()).unwrap();
		let mut r = Rd(&raw, 0);
		let mut g = Geometry { c: r.u32(), col: r.u32() as i32, row: r.u32() as i32, ..Geometry::default() };
		let nt = r.u32() as usize;
		g.tris = r.f32s(9 * nt);
		g.kind = r.take(nt).to_vec();
		let na = r.u32() as usize;
		g.areas = r.take(2 * na).chunks_exact(2).map(|c| u16::from_le_bytes([c[0], c[1]])).collect();
		let nl = r.u32() as usize;
		if nl > 0 {
			let ty = r.take(nl).to_vec();
			let z = r.f32s(nl);
			let deep = r.take(nl).to_vec();
			g.liquid = Mh2o { ty, z, deep };
		}
		for _ in 0..r.u32() {
			let ty = r.u32() as u8;
			let n = r.u32() as usize;
			g.wmo_liquid.push(WmoLiquid { ty, tris: r.f32s(n) });
		}
		for _ in 0..r.u32() {
			let n = r.u32() as usize;
			let id = String::from_utf8(r.take(n).to_vec()).unwrap();
			let mut pts = [[0.0; 2]; 4];
			for p in &mut pts {
				*p = [r.f64(), r.f64()];
			}
			g.openings.push(Cut { id, pts, zlo: r.f64(), zhi: r.f64() });
		}
		assert_eq!(r.1, raw.len(), "{col}_{row}.geom.gz: trailing bytes");
		g
	}
}

struct Rd<'a>(&'a [u8], usize);
impl Rd<'_> {
	fn take(&mut self, n: usize) -> &[u8] {
		let s = &self.0[self.1..self.1 + n];
		self.1 += n;
		s
	}
	fn u32(&mut self) -> u32 {
		u32::from_le_bytes(self.take(4).try_into().unwrap())
	}
	fn f64(&mut self) -> f64 {
		f64::from_le_bytes(self.take(8).try_into().unwrap())
	}
	fn f32s(&mut self, n: usize) -> Vec<f32> {
		self.take(4 * n).chunks_exact(4).map(|c| f32::from_le_bytes(c.try_into().unwrap())).collect()
	}
}
