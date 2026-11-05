//! Walking routes on Leffe's navigation maps (format 4), for the build-time route pipeline.
//!
//! A port of the Node reader and router (tools/lib/nav/nav4: pack.js, store.js, router.js and the needed parts of
//! index.js), which port Leffe's format-4 reader (his Routing/Motion.lua, PathGrid.lua, Path.lua, Costs.lua) bit for
//! bit: same heap and ties, same expansion order, same float arithmetic. Path.lua and PathGrid.lua started from
//! Shortest Path Forever v1.16.0 by Cillian Berragan. Copyright (C) 2026 Cillian Berragan; Copyright (c) 2026 The
//! Polestar authors (Leffe's reader). GPL-3.0-or-later.
//!
//! The core is wasm-safe: decoders take bytes through a [`PackSource`]; [`NavDir`] reads a Nav folder (feature
//! `native`). Decoded clusters live in one byte-bounded LRU shared by every thread; `F4` is `Send + Sync`.
//!
//! Lifts: his maps' walking graph has none (a transport layer on top of it); `F4::open` splices Leffe's lift layer
//! (lifts.rs) into the search when it sits with the maps and fits their build.

pub mod lifts;
pub mod pack;
mod router;
mod store;

pub use router::{cost_mult, style_min};
use router::{Checks, Run, Scratch};
use std::sync::Mutex;
pub use store::Stats;
use store::Store;

/// Drawn yards per FindMany label yard (index.js SMOOTH: the cost-best path's labels, before smoothing).
pub const SMOOTH: f64 = 0.961;
/// index.js zone cells (ZONE_CELL, cellKey): 200 yd, keyed by absolute indices.
pub const ZONE_CELL: f64 = 200.0;
pub fn cell_key(wx: f64, wy: f64) -> f64 {
	((wx / ZONE_CELL).floor() + 512.0) * 1024.0 + (wy / ZONE_CELL).floor() + 512.0
}

/// A pack's bytes: the metadata file of a map and byte ranges of its part files.
pub trait PackSource: Send + Sync {
	/// The maps with a metadata file, in the pack's load order.
	fn maps(&self) -> Vec<u32>;
	/// Nav<map>.lua (None: no such map).
	fn meta(&self, map: u32) -> Result<Option<Vec<u8>>, String>;
	/// The number of part files of `map` (Nav<map>_<i>.lua), in load order.
	fn parts(&self, map: u32) -> usize;
	/// Hands part file `part` (0-based, load order) to `f` whole (scanned once to index the cluster blocks).
	fn with_part(&self, map: u32, part: usize, f: &mut dyn FnMut(&[u8])) -> Result<(), String>;
	/// Bytes [start, end) of part file `part`.
	fn read(&self, map: u32, part: usize, start: usize, end: usize) -> Result<Vec<u8>, String>;
}

/// A point in UnitPosition's frame (x north, y west); z None when unknown (the router tries every surface).
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct P {
	pub x: f64,
	pub y: f64,
	pub z: Option<f64>,
}

#[derive(Clone, Copy, Debug, Default, PartialEq, Eq, Hash)]
pub enum Style {
	Fastest,
	#[default]
	Balanced,
	Roads,
}
impl Style {
	/// Costs.Style: anything else is balanced.
	pub fn parse(s: &str) -> Style {
		match s {
			"fastest" => Style::Fastest,
			"roads" => Style::Roads,
			_ => Style::Balanced,
		}
	}
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum Faction {
	Alliance,
	Horde,
}

/// How the reader's own consistency checks run: Lua (a failing cluster fails every route reaching it), Tolerant
/// (one-ulp yard labels pass, a crossing takes the floor its edge names, unjoinable labels are routed around; the
/// pipeline's default), Off (no checks).
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq, Hash)]
pub enum Validate {
	Lua,
	#[default]
	Tolerant,
	Off,
}

#[derive(Clone, Debug, Default)]
pub struct Opts {
	/// "Alliance" | "Horde" (anything else: no faction).
	pub profile: Option<&'static str>,
	pub style: Style,
	/// Danger multipliers by uiMapID (only those > 1 count).
	pub danger: Vec<(u32, f64)>,
	pub water_walking: bool,
	pub validate: Validate,
	/// route_many: a cost past which the search stops.
	pub limit: Option<f64>,
	/// route_many: each reached target's entrance chain.
	pub chains: bool,
}
impl Opts {
	pub fn faction(&self) -> Option<Faction> {
		match self.profile {
			Some("Alliance") => Some(Faction::Alliance),
			Some("Horde") => Some(Faction::Horde),
			_ => None,
		}
	}
}

/// A motion arc taken (Path.lua's events).
#[derive(Clone, Debug, PartialEq)]
pub struct Event {
	pub cluster: u32,
	pub ordinal: u32,
	/// 0 a motion step, 1 a jump.
	pub kind: u32,
	pub from: u32,
	pub to_cluster: u32,
	pub to: u32,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Hub {
	pub id: String,
	pub name: Option<String>,
	pub area_id: Option<u32>,
}

/// How a leg is moved. The pack's motion arcs are kinds 0 (a raw motion step, possibly along a connector path)
/// and 1 (a jump); a kind-0 arc falling or rising past the walkable slope is a drop or a climb.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Move {
	Walk,
	Swim,
	Jump,
	Drop,
	Climb,
	Motion,
	/// A ride on a lift (Leffe's lift layer).
	Lift,
}

/// A drawn segment: points[from] -> points[to], its move, the floor of its start surface (0 base, i the cell's ith
/// floor from the bottom, on his maps) and its start's ground class (Costs.lua: 0 normal, 1 road, 2 gentle slope,
/// 3 steep slope, 4 indoor, 5 indoor city).
#[derive(Clone, Debug, PartialEq)]
pub struct Leg {
	pub from: usize,
	pub to: usize,
	pub kind: Move,
	pub floor: Option<u32>,
	pub ground: u8,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Route {
	pub ok: bool,
	/// 'outside' | 'offmesh' | 'unreachable' | 'error: ...'
	pub reason: Option<String>,
	/// From a to b, each at the height of its surface (z NaN where unknown).
	pub points: Vec<[f64; 3]>,
	pub cost: f64,
	/// The cost-best path's label yards (before drawing).
	pub label_yards: f64,
	/// The drawn line's 3D length.
	pub yards: f64,
	pub wet: f64,
	pub jumps: f64,
	pub hubs: Vec<Hub>,
	pub events: Vec<Event>,
	pub legs: Vec<Leg>,
}
impl Route {
	pub(crate) fn failed(reason: String) -> Route {
		Route { ok: false, reason: Some(reason), points: Vec::new(), cost: 0.0, label_yards: 0.0, yards: 0.0, wet: 0.0, jumps: 0.0, hubs: Vec::new(), events: Vec::new(), legs: Vec::new() }
	}
}

/// FindMany from one point: per target its cost, label yards (apply SMOOTH for drawn yards) and jumps (-1 not
/// reached), the reason when not, and (opts.chains) the entrance ids it passes, start first.
#[derive(Clone, Debug, PartialEq)]
pub struct Many {
	pub costs: Vec<f64>,
	pub yards: Vec<f64>,
	pub jumps: Vec<f64>,
	pub reasons: Vec<Option<String>>,
	pub chains: Option<Vec<Option<Vec<i64>>>>,
}

#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Surface {
	pub z: f64,
	pub water: bool,
	pub floor: u32,
}

/// heightAt's floor: the base surface (else the lowest), floor i, or the surface nearest a height.
#[derive(Clone, Copy, Debug, PartialEq)]
pub enum Floor {
	Base,
	Index(u32),
	Near(f64),
}

/// Leffe's navigation maps, routed.
pub struct F4 {
	store: Store,
	checks: Checks,
	scratch: Mutex<Vec<Scratch>>,
	/// Leffe's lift layer, resolved on the maps (empty: none).
	lifts: lifts::ByMap,
	/// The layer's content hash (None: no lifts).
	lift_layer: Option<String>,
}

impl F4 {
	/// A Nav folder (Nav.xml beside Nav<map>.lua), or a folder holding one as Nav/; with Leffe's lift layer when it
	/// sits with the maps (lifts::find) and fits their build (one log line either way).
	#[cfg(feature = "native")]
	pub fn open(dir: &std::path::Path, cache_mb: usize) -> Result<F4, String> {
		let nav = NavDir::open(dir)?;
		let nav_dir = nav.dir.clone();
		let mut f4 = F4::from_source(Box::new(nav), cache_mb);
		if let Some(file) = lifts::find(&nav_dir) {
			match lifts::load(&file, &nav_dir) {
				Ok((layer, left)) => {
					for l in left {
						eprintln!("  Leffe's lift layer: left out {l}");
					}
					for l in f4.set_lifts(Some(layer)) {
						eprintln!("  Leffe's lift layer ({}): {l}", file.display());
					}
				}
				Err(e) => eprintln!("  Leffe's lift layer ({}): not used, no lifts on his maps: {e}", file.display()),
			}
		}
		Ok(f4)
	}

	pub fn from_source(source: Box<dyn PackSource>, cache_mb: usize) -> F4 {
		F4 { store: Store::new(source, cache_mb), checks: Checks::default(), scratch: Mutex::default(), lifts: Default::default(), lift_layer: None }
	}

	/// Splices a lift layer into the search (None: takes the lifts out). Each landing is resolved on the maps (the
	/// node it stands on, within lifts::LAND_Z_YD of its height); a car with a landing that does not stand on them is
	/// left out. -> what it did, one line per map and per car left out.
	pub fn set_lifts(&mut self, layer: Option<lifts::Layer>) -> Vec<String> {
		self.lifts.clear();
		self.lift_layer = None;
		let Some(layer) = layer else { return Vec::new() };
		let mut log = Vec::new();
		for (map, cars) in layer.maps {
			let mut kept = Vec::new();
			for mut car in cars {
				let mut ok = true;
				for l in car.ends.iter_mut() {
					match self.with(map, Validate::Off, |r| r.landing(l.x, l.y, l.z)) {
						Ok(Ok(Some((k, node)))) => {
							l.k = k;
							l.node = node;
						}
						_ => ok = false,
					}
				}
				if ok {
					kept.push(car);
				} else {
					log.push(format!("map {map}: left out {} {}: a landing does not stand on the maps", car.name, car.object));
				}
			}
			if !kept.is_empty() {
				log.push(format!("map {map}: {} lift cars spliced", kept.len()));
				self.lifts.insert(map, std::sync::Arc::new(lifts::MapLifts { cars: kept, group: lifts::group_of(map) }));
			}
		}
		if !self.lifts.is_empty() {
			self.lift_layer = Some(layer.id);
		}
		log
	}

	/// The spliced lift layer's content hash (None: no lifts).
	pub fn lift_layer(&self) -> Option<&str> {
		self.lift_layer.as_deref()
	}

	pub fn maps(&self) -> Vec<u32> {
		self.store.source.maps()
	}

	/// Runs f over map's state with a pooled scratch.
	fn with<T>(&self, map: u32, validate: Validate, f: impl FnOnce(&mut Run) -> T) -> Result<T, String> {
		let meta = self.store.meta(map)?.ok_or_else(|| format!("no nav data for map {map}"))?;
		let mut sc = self.scratch.lock().unwrap().pop().unwrap_or_default();
		let out = {
			let mut run = Run::new(&self.store, &self.checks, meta, validate, &mut sc, self.lifts.get(&map).cloned());
			let out = f(&mut run);
			run.finish();
			out
		};
		sc.trim();
		self.scratch.lock().unwrap().push(sc);
		Ok(out)
	}

	pub fn route(&self, map: u32, a: P, b: P, o: &Opts) -> Route {
		self.with(map, o.validate, |r| r.route(&a, &b, o)).unwrap_or_else(|e| Route::failed(format!("error: {e}")))
	}

	pub fn route_many(&self, map: u32, from: P, targets: &[P], o: &Opts) -> Many {
		self.with(map, o.validate, |r| r.route_many(&from, targets, o)).unwrap_or_else(|e| {
			let n = targets.len();
			Many { costs: vec![-1.0; n], yards: vec![-1.0; n], jumps: vec![-1.0; n], reasons: vec![Some(format!("error: {e}")); n], chains: None }
		})
	}

	/// The cell's base surface and floors, base first (empty off the map or on errors).
	pub fn surfaces_at(&self, map: u32, x: f64, y: f64) -> Vec<Surface> {
		self.with(map, Validate::Off, |r| r.surfaces_at(x, y)).and_then(|v| v).unwrap_or_default()
	}

	/// index.js heightOn.
	pub fn height_at(&self, map: u32, x: f64, y: f64, floor: Floor) -> Option<f64> {
		let s = self.surfaces_at(map, x, y);
		if s.is_empty() {
			return None;
		}
		match floor {
			Floor::Base => Some(s.iter().find(|v| v.floor == 0).unwrap_or(&s[0]).z),
			Floor::Index(i) => s.iter().find(|v| v.floor == i).map(|v| v.z),
			Floor::Near(h) => {
				let mut best = &s[0];
				for v in &s[1..] {
					if (v.z - h).abs() < (best.z - h).abs() {
						best = v;
					}
				}
				Some(best.z)
			}
		}
	}

	/// The uiMapID of the zone at (x, y) (None off the map or where the pack has none).
	pub fn zone_at(&self, map: u32, x: f64, y: f64) -> Option<u32> {
		self.with(map, Validate::Off, |r| r.zone_at(x, y)).ok().flatten()
	}

	/// An entrance's position (route_many chains' ids: k * STRIDE + row, or a lift landing), index.js chainCells'
	/// geometry.
	pub fn entrance_xy(&self, map: u32, id: i64) -> Option<(f64, f64)> {
		self.with(map, Validate::Off, |r| r.entrance_xy(id)).ok()?.ok().map(|g| (g[0], g[1]))
	}

	/// index.js chainCells: a reached target's label yards per zone cell (its way as straight legs through the
	/// chain's entrances, sampled every 4 yd or less, scaled to `total`) -> [(cell key, yards)] in first-visit order.
	pub fn chain_cells(&self, map: u32, from: P, to: P, chain: &[i64], total: f64) -> Vec<(f64, f64)> {
		let mut pts = vec![(from.x, from.y)];
		for &id in chain {
			if let Some(p) = self.entrance_xy(map, id) {
				pts.push(p);
			}
		}
		pts.push((to.x, to.y));
		let mut keys: Vec<f64> = Vec::new();
		let mut acc: rustc_hash::FxHashMap<u64, (usize, f64)> = Default::default();
		let mut flat = 0.0;
		for w in pts.windows(2) {
			let (ax, ay) = w[0];
			let (dx, dy) = (w[1].0 - ax, w[1].1 - ay);
			let len = js_hypot(dx, dy);
			if len == 0.0 || len.is_nan() {
				continue;
			}
			let steps = (len / 4.0).ceil() as usize;
			for s in 0..steps {
				let t = (s as f64 + 0.5) / steps as f64;
				let key = cell_key(ax + dx * t, ay + dy * t);
				let e = acc.entry(key.to_bits()).or_insert_with(|| {
					keys.push(key);
					(keys.len() - 1, 0.0)
				});
				e.1 += len / steps as f64;
			}
			flat += len;
		}
		if flat == 0.0 {
			return vec![(cell_key(from.x, from.y), total)];
		}
		keys.iter().map(|&k| (k, acc[&k.to_bits()].1 / flat * total)).collect()
	}

	/// index.js zonesNear: every zone of a cluster whose box reaches the ellipse of points whose distances to a and
	/// b add up to at most D / MIN (the style's least cost per yard) -> sorted uiMapIDs.
	pub fn zones_near(&self, map: u32, a: P, b: P, d: f64, style: Style) -> Vec<u32> {
		self.with(map, Validate::Off, |r| {
			let st = &r.st;
			if st.meta.zone.is_none() {
				return Vec::new();
			}
			let rr = d / style_min(style);
			let w = st.c as f64 * st.cs;
			let x0 = 0f64.max(((a.x.min(b.x) - rr - st.x0) / w).floor()) as i64;
			let x1 = ((st.nx - 1) as f64).min(((a.x.max(b.x) + rr - st.x0) / w).floor()) as i64;
			let y0 = 0f64.max(((a.y.min(b.y) - rr - st.y0) / w).floor()) as i64;
			let y1 = ((st.ny - 1) as f64).min(((a.y.max(b.y) + rr - st.y0) / w).floor()) as i64;
			let gap = |lo: (f64, f64), hi: (f64, f64), p: &P| js_hypot((lo.0 - p.x).max(0.0).max(p.x - hi.0), (lo.1 - p.y).max(0.0).max(p.y - hi.1));
			let mut out: Vec<u32> = Vec::new();
			for cx in x0..=x1 {
				for cy in y0..=y1 {
					let lo = (st.x0 + cx as f64 * w, st.y0 + cy as f64 * w);
					let hi = (lo.0 + w, lo.1 + w);
					if gap(lo, hi, &a) + gap(lo, hi, &b) > rr {
						continue;
					}
					for z in r.cluster_zones((cx * st.ny + cy) as u32) {
						if !out.contains(&z) {
							out.push(z);
						}
					}
				}
			}
			out.sort_unstable();
			out
		})
		.unwrap_or_default()
	}

	/// The decode cache's counters.
	pub fn stats(&self) -> Stats {
		self.store.stats()
	}
	/// Drops every decoded cluster.
	pub fn clear(&self) {
		self.store.clear();
	}
}

/// V8's Math.hypot for two arguments (scaled, Kahan-summed), bit for bit.
pub fn js_hypot(a: f64, b: f64) -> f64 {
	let (a, b) = (a.abs(), b.abs());
	if a.is_infinite() || b.is_infinite() {
		return f64::INFINITY;
	}
	if a.is_nan() || b.is_nan() {
		return f64::NAN;
	}
	let max = a.max(b);
	if max == 0.0 {
		return 0.0;
	}
	let (mut sum, mut comp) = (0.0f64, 0.0f64);
	for v in [a, b] {
		let n = v / max;
		let s = n * n - comp;
		let p = sum + s;
		comp = (p - sum) - s;
		sum = p;
	}
	sum.sqrt() * max
}

/// A Nav folder on disk (Nav.xml's script order). Part files are read whole once (the index scan), then by range.
#[cfg(feature = "native")]
pub struct NavDir {
	dir: std::path::PathBuf,
	maps: Vec<(u32, Option<String>, Vec<String>)>,
}

#[cfg(feature = "native")]
impl NavDir {
	/// dir itself (holding Nav.xml) or its Nav/.
	pub fn open(dir: &std::path::Path) -> Result<NavDir, String> {
		let dir = if dir.join("Nav.xml").exists() {
			dir.to_path_buf()
		} else if dir.join("Nav").join("Nav.xml").exists() {
			dir.join("Nav")
		} else {
			return Err(format!("{} holds no Nav/Nav.xml", dir.display()));
		};
		let xml = std::fs::read_to_string(dir.join("Nav.xml")).map_err(|e| e.to_string())?;
		let mut order = Vec::new();
		let mut rest = xml.as_str();
		while let Some(p) = rest.find("<Script file=\"") {
			let s = &rest[p + 14..];
			let Some(e) = s.find('"') else { break };
			order.push(s[..e].to_string());
			rest = &s[e..];
		}
		let mut maps: Vec<(u32, Option<String>, Vec<String>)> = Vec::new();
		for f in order {
			let Some(stem) = f.strip_prefix("Nav").and_then(|s| s.strip_suffix(".lua")) else { continue };
			let (m, part) = match stem.split_once('_') {
				Some((m, p)) => (m, Some(p)),
				None => (stem, None),
			};
			if m.is_empty() || !m.bytes().all(|b| b.is_ascii_digit()) || part.is_some_and(|p| p.is_empty() || !p.bytes().all(|b| b.is_ascii_digit())) {
				continue;
			}
			let Ok(m) = m.parse::<u32>() else { continue };
			let i = match maps.iter().position(|e| e.0 == m) {
				Some(i) => i,
				None => {
					maps.push((m, None, Vec::new()));
					maps.len() - 1
				}
			};
			match part {
				None => maps[i].1 = Some(f),
				Some(_) => maps[i].2.push(f),
			}
		}
		Ok(NavDir { dir, maps })
	}
	fn entry(&self, map: u32) -> Option<&(u32, Option<String>, Vec<String>)> {
		self.maps.iter().find(|e| e.0 == map)
	}
	fn part_path(&self, map: u32, part: usize) -> Result<std::path::PathBuf, String> {
		let name = self.entry(map).and_then(|e| e.2.get(part)).ok_or_else(|| format!("map {map}: no part {part}"))?;
		Ok(self.dir.join(name))
	}
}

#[cfg(feature = "native")]
impl PackSource for NavDir {
	fn maps(&self) -> Vec<u32> {
		self.maps.iter().filter(|e| e.1.is_some()).map(|e| e.0).collect()
	}
	fn meta(&self, map: u32) -> Result<Option<Vec<u8>>, String> {
		match self.entry(map).and_then(|e| e.1.as_ref()) {
			None => Ok(None),
			Some(f) => std::fs::read(self.dir.join(f)).map(Some).map_err(|e| format!("{f}: {e}")),
		}
	}
	fn parts(&self, map: u32) -> usize {
		self.entry(map).map_or(0, |e| e.2.len())
	}
	fn with_part(&self, map: u32, part: usize, f: &mut dyn FnMut(&[u8])) -> Result<(), String> {
		let p = self.part_path(map, part)?;
		let bytes = std::fs::read(&p).map_err(|e| format!("{}: {e}", p.display()))?;
		f(&bytes);
		Ok(())
	}
	fn read(&self, map: u32, part: usize, start: usize, end: usize) -> Result<Vec<u8>, String> {
		use std::io::{Read, Seek, SeekFrom};
		let p = self.part_path(map, part)?;
		let err = |e: std::io::Error| format!("{} [{start}..{end}]: {e}", p.display());
		let mut file = std::fs::File::open(&p).map_err(err)?;
		file.seek(SeekFrom::Start(start as u64)).map_err(err)?;
		let mut buf = vec![0u8; end.saturating_sub(start)];
		file.read_exact(&mut buf).map_err(err)?;
		Ok(buf)
	}
}
