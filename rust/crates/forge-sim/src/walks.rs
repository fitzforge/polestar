//! Walks the evaluator asks for: routed yards between two world points.
//!
//! `Walks` is the interface (forge-nav's walk store takes it over when it lands). Today's
//! implementation, `WalkTable`, reads `data/sim/walks-<faction>.bin` (tools/lib/sim/binfile.js
//! layout) with v1's semantics (walks.js `attachWalks`): one walk per pair, band 30's where it
//! was re-routed, else band 0's; yards × the document's `smooth`; within a band both-ways walks
//! first, one-way walks over them, and the last entry of a pair wins. Pairs it lacks fall back
//! to the straight line × detour in the evaluator (v1 does not read `unwalkable`), but only
//! within the store's `radius`: a pair beyond it was never asked, and the straight line there
//! may cross a sea or a mountain range (travel.rs direct_walk).
//! A table loaded `with_crossings` also holds the zone-crossing rule (ZoneCrossings): a walk from
//! one zone into another that passes no known crossing is unwalkable.

use rustc_hash::FxHashMap;

/// Routed walking yards from world point `a` to world point `b`, or None (no routed walk).
pub trait Walks: Sync + Send {
	fn yards(&self, a: u32, b: u32) -> Option<f64>;
	/// Straight yards within which the store asked every pair of points (the walks document's
	/// `radius`): a pair it lacks beyond it has no walk. None: no store (every leg straight).
	fn radius(&self) -> Option<f64> {
		None
	}
}

/// No routed walks: every leg is the straight line × detour (the gate's model, walks off).
pub struct NoWalks;

impl Walks for NoWalks {
	fn yards(&self, _: u32, _: u32) -> Option<f64> {
		None
	}
}

/// The band v1 runs take where a pair was re-routed (walks.js V1_BAND).
pub const V1_BAND: u32 = 30;

pub struct WalkTable {
	pub nw: u64,
	pub smooth: f64,
	pub data_hash: String,
	/// The world's walk inputs the walks were built on (World::walks_key; empty in older files).
	pub walks_key: String,
	/// The document's `radius` (yards; None in a file without one).
	pub radius: Option<f64>,
	map: FxHashMap<u64, f64>,
	/// The zone-crossing rule (with_crossings); None: every stored walk stands.
	crossings: Option<ZoneCrossings>,
}

impl Walks for WalkTable {
	#[inline]
	fn yards(&self, a: u32, b: u32) -> Option<f64> {
		let y = self.map.get(&(a as u64 * self.nw + b as u64)).copied();
		match &self.crossings {
			Some(z) => z.judge(a, b, y),
			None => y,
		}
	}
	fn radius(&self) -> Option<f64> {
		self.radius
	}
}

/// A walk between zones that is shorter than the shortest way through the zone crossings is no
/// walk: below this share of that way's yards (the store's yards are the routed path × `smooth`,
/// 0.96; the way is a lower bound) the pair is unwalkable.
const CROSSING_SLACK: f64 = 0.95;

/// No zone group (a point with no zone map): its walks are not judged.
const NO_ZONE: u32 = u32::MAX;

/// The rule that a walk from one zone into another passes a known zone crossing (World::crossings:
/// data/crossings.json, Carbonite's zone connections and the ways added to them, and the grid's open
/// borders): Rev14H1 (Thunder Bluff over the ridge into Desolace), Rev14A1 (Theramore along the coast
/// to Gadgetzan). Zones joined by an open border are one zone here. A crossing is a disc around the
/// middle of its two ends (radius: half the yards between them and the larger end radius), where a
/// walk over that border passes. A pair between two zones whose walk (the store's, else the straight
/// line) is shorter than the shortest way from one point to the other through the discs (straight
/// lines, less the discs' radii: a lower bound of any walk that passes them) did not pass them: no
/// walk (infinite yards; the leg goes by the network, whose node walks are judged the same way).
pub struct ZoneCrossings {
	/// Per world point: continent, region, x, y, zone group (NO_ZONE: none).
	pts: Vec<(i64, i64, f64, f64, u32)>,
	/// The open borders' union: a zone map to the map its group is named by.
	parent: FxHashMap<u32, u32>,
	/// Crossings: continent, side a's zone group, side b's, centre x, y, radius.
	discs: Vec<(i64, u32, u32, f64, f64, f64)>,
	/// The ways over a crossing: (crossing, the zone group it was walked from, the one reached).
	ways: Vec<(usize, u32, u32)>,
	/// The shortest yards from having walked way i to having walked way j (ways.len() squared).
	d: Vec<f64>,
}

/// A crossing passed on a walk ([`ZoneCrossings::path`]): the index of the world's crossing
/// (World::crossings.ways), and whether it is walked from its `a` end to its `b` end.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Passed {
	pub crossing: usize,
	pub from_a: bool,
}

fn group_root(p: &FxHashMap<u32, u32>, x: u32) -> u32 {
	let mut r = x;
	while let Some(&q) = p.get(&r).filter(|&&q| q != r) {
		r = q;
	}
	r
}

impl ZoneCrossings {
	pub fn new(world: &forge_world::World) -> ZoneCrossings {
		ZoneCrossings::of(&world.points, &world.crossings)
	}

	/// The rule over these world points and crossings.
	pub fn of(points: &[forge_world::world::Point], cr: &forge_world::world::Crossings) -> ZoneCrossings {
		let mut parent: FxHashMap<u32, u32> = FxHashMap::default();
		for &(a, b) in &cr.open {
			let (ra, rb) = (group_root(&parent, a), group_root(&parent, b));
			if ra != rb {
				parent.insert(ra.max(rb), ra.min(rb));
			}
		}
		let group = |m: u32| if m == 0 { NO_ZONE } else { group_root(&parent, m) };
		let pts = points.iter().map(|p| (p.c, p.region, p.wx, p.wy, group(p.map))).collect();
		let mut discs = Vec::with_capacity(cr.ways.len());
		let mut ways = Vec::with_capacity(cr.ways.len() * 2);
		for w in &cr.ways {
			let (ga, gb) = (group(w.a.0), group(w.b.0));
			let half = (w.a.1 - w.b.1).hypot(w.a.2 - w.b.2) / 2.0;
			discs.push((w.c, ga, gb, (w.a.1 + w.b.1) / 2.0, (w.a.2 + w.b.2) / 2.0, half + w.a.3.max(w.b.3)));
			let k = discs.len() - 1;
			ways.push((k, ga, gb));
			if !w.one_way {
				ways.push((k, gb, ga));
			}
		}
		let n = ways.len();
		let mut d = vec![f64::INFINITY; n * n];
		for i in 0..n {
			d[i * n + i] = 0.0;
			let (ki, _, reached) = ways[i];
			let ci = discs[ki];
			for j in 0..n {
				let (kj, from, _) = ways[j];
				let cj = discs[kj];
				if i != j && from == reached && ci.0 == cj.0 {
					d[i * n + j] = ((ci.3 - cj.3).hypot(ci.4 - cj.4) - ci.5 - cj.5).max(0.0);
				}
			}
		}
		for k in 0..n {
			for i in 0..n {
				let dik = d[i * n + k];
				if dik == f64::INFINITY {
					continue;
				}
				for j in 0..n {
					let c = dik + d[k * n + j];
					if c < d[i * n + j] {
						d[i * n + j] = c;
					}
				}
			}
		}
		ZoneCrossings { pts, parent, discs, ways, d }
	}

	/// A zone map's group (zones joined by an open border are one).
	pub fn group(&self, map: u32) -> u32 {
		if map == 0 {
			NO_ZONE
		} else {
			group_root(&self.parent, map)
		}
	}

	/// The shortest yards from a to b (continent, x, y, zone group) through the crossings (infinite:
	/// none joins them).
	fn best(&self, pa: (i64, f64, f64, u32), pb: (i64, f64, f64, u32)) -> f64 {
		let n = self.ways.len();
		let to = |p: (i64, f64, f64, u32), k: usize| {
			let c = &self.discs[k];
			((p.1 - c.3).hypot(p.2 - c.4) - c.5).max(0.0)
		};
		let mut best = f64::INFINITY;
		for (i, &(ki, from, _)) in self.ways.iter().enumerate() {
			if from != pa.3 || self.discs[ki].0 != pa.0 {
				continue;
			}
			let first = to(pa, ki);
			for (j, &(kj, _, reached)) in self.ways.iter().enumerate() {
				if reached == pb.3 {
					best = best.min(first + self.d[i * n + j] + to(pb, kj));
				}
			}
		}
		best
	}

	/// The shortest yards from world point a to b through the crossings (infinite: none joins them).
	pub fn way(&self, a: u32, b: u32) -> f64 {
		let (pa, pb) = (&self.pts[a as usize], &self.pts[b as usize]);
		self.best((pa.0, pa.2, pa.3, pa.4), (pb.0, pb.2, pb.3, pb.4))
	}

	/// The same between two places (world x, y and zone map) on continent `c`: 0 within one zone
	/// group, or where a place has no zone.
	pub fn way_between(&self, c: i64, a: (f64, f64, u32), b: (f64, f64, u32)) -> f64 {
		let (ga, gb) = (self.group(a.2), self.group(b.2));
		if ga == gb || ga == NO_ZONE || gb == NO_ZONE {
			return 0.0;
		}
		self.best((c, a.0, a.1, ga), (c, b.0, b.1, gb))
	}

	/// The crossings the shortest way from a to b passes, in order (empty within one zone group, or
	/// where none joins them). Each crossing beyond the first costs HOP_YD more here (Felwood's
	/// Timbermaw tunnel goes into Winterspring at once, not by its Moonglade mouth: the discs of both
	/// ways sit at the same cave), and a crossing inside one zone group (Durotar and the Barrens, joined
	/// by an open border) is no crossing.
	pub fn path(&self, c: i64, a: (f64, f64, u32), b: (f64, f64, u32)) -> Vec<Passed> {
		const HOP_YD: f64 = 200.0;
		let (ga, gb) = (self.group(a.2), self.group(b.2));
		if ga == gb || ga == NO_ZONE || gb == NO_ZONE {
			return Vec::new();
		}
		let to = |p: (f64, f64), k: usize| {
			let d = &self.discs[k];
			((p.0 - d.3).hypot(p.1 - d.4) - d.5).max(0.0)
		};
		let usable = |i: usize| {
			let (k, from, reached) = self.ways[i];
			from != reached && self.discs[k].0 == c
		};
		let n = self.ways.len();
		// Dijkstra over the ways walked: yards to having walked each, and the way before it.
		let mut dist = vec![f64::INFINITY; n];
		let mut prev = vec![usize::MAX; n];
		let mut done = vec![false; n];
		for i in (0..n).filter(|&i| usable(i) && self.ways[i].1 == ga) {
			dist[i] = to((a.0, a.1), self.ways[i].0);
		}
		while let Some(i) = (0..n).filter(|&i| !done[i] && dist[i].is_finite()).min_by(|&x, &y| dist[x].total_cmp(&dist[y])) {
			done[i] = true;
			let (ki, _, reached) = self.ways[i];
			let ci = self.discs[ki];
			for j in (0..n).filter(|&j| !done[j] && usable(j) && self.ways[j].1 == reached) {
				let cj = self.discs[self.ways[j].0];
				let s = dist[i] + ((ci.3 - cj.3).hypot(ci.4 - cj.4) - ci.5 - cj.5).max(0.0) + HOP_YD;
				if s < dist[j] {
					dist[j] = s;
					prev[j] = i;
				}
			}
		}
		let Some(mut j) =
			(0..n).filter(|&j| dist[j].is_finite() && self.ways[j].2 == gb).min_by(|&x, &y| (dist[x] + to((b.0, b.1), self.ways[x].0)).total_cmp(&(dist[y] + to((b.0, b.1), self.ways[y].0))))
		else {
			return Vec::new();
		};
		let mut out = Vec::new();
		loop {
			let (k, from, _) = self.ways[j];
			out.push(Passed { crossing: k, from_a: from == self.discs[k].1 });
			if prev[j] == usize::MAX {
				break;
			}
			j = prev[j];
		}
		out.reverse();
		out
	}

	/// The store's yards `y` from a to b under the rule.
	#[inline]
	pub fn judge(&self, a: u32, b: u32, y: Option<f64>) -> Option<f64> {
		let (Some(pa), Some(pb)) = (self.pts.get(a as usize), self.pts.get(b as usize)) else { return y };
		if pa.4 == pb.4 || pa.4 == NO_ZONE || pb.4 == NO_ZONE || pa.0 != pb.0 || pa.1 != pb.1 || y.is_some_and(f64::is_infinite) {
			return y;
		}
		let walk = y.unwrap_or_else(|| (pa.2 - pb.2).hypot(pa.3 - pb.3));
		if walk >= CROSSING_SLACK * self.way(a, b) {
			y
		} else {
			Some(f64::INFINITY)
		}
	}
}

const MAGIC: u32 = 0x4e42_5350;

impl WalkTable {
	pub fn len(&self) -> usize {
		self.map.len()
	}

	pub fn is_empty(&self) -> bool {
		self.map.is_empty()
	}

	/// From a walks .bin's bytes; `nw`: the world's point count (keys are a * nw + b). The
	/// world must be the one the walks were built on (its `dataHash` and point ids).
	pub fn from_bin(bytes: &[u8], nw: usize) -> Result<WalkTable, String> {
		if bytes.len() < 12 || u32::from_le_bytes(bytes[0..4].try_into().unwrap()) != MAGIC {
			return Err("not a binary data file".into());
		}
		let n = u32::from_le_bytes(bytes[8..12].try_into().unwrap()) as usize;
		let header: serde_json::Value = serde_json::from_slice(&bytes[12..12 + n]).map_err(|e| e.to_string())?;
		let smooth = header.get("smooth").and_then(|v| v.as_f64()).unwrap_or(0.965);
		let sections = header.get("sections").and_then(|v| v.as_object()).ok_or("no sections")?;
		let f64s = |name: &str| -> Option<Vec<f64>> {
			let s = sections.get(name)?.as_array()?;
			if s[0].as_str()? != "Float64Array" {
				return None;
			}
			let at = s[1].as_u64()? as usize;
			let len = s[2].as_u64()? as usize;
			Some(bytes[at..at + len * 8].chunks_exact(8).map(|c| f64::from_le_bytes(c.try_into().unwrap())).collect())
		};
		let nwu = nw as u64;
		let id = |p: f64| -> Option<u64> { Some(p as u64) };
		let mut map: FxHashMap<u64, f64> = FxHashMap::default();
		// The .bin stores 5 values a pair (writeWalks): a, b, yards, cost, oneWay.
		const STRIDE: usize = 5;
		for band in ["p0".to_string(), format!("p{V1_BAND}")] {
			let Some(arr) = f64s(&band) else { continue };
			map.reserve(arr.len() / STRIDE * 2);
			for one in [false, true] {
				for pair in arr.chunks_exact(STRIDE) {
					if (pair[4] == 1.0) != one {
						continue;
					}
					if let (Some(a), Some(b)) = (id(pair[0]), id(pair[1])) {
						let y = pair[2] * smooth;
						map.insert(a * nwu + b, y);
						if !one {
							map.insert(b * nwu + a, y);
						}
					}
				}
			}
		}
		let s = |k: &str| header.get(k).and_then(|v| v.as_str()).unwrap_or("").to_string();
		let radius = header.get("radius").and_then(|v| v.as_f64()).filter(|r| *r > 0.0);
		Ok(WalkTable { nw: nwu, smooth, data_hash: s("dataHash"), walks_key: s("walksKey"), radius, map, crossings: None })
	}

	/// These walks under `world`'s zone crossings (ZoneCrossings): a walk between zones that passes
	/// none is unwalkable. A world without crossings (an older world, a slice) keeps every walk.
	pub fn with_crossings(mut self, world: &forge_world::World) -> WalkTable {
		self.crossings = (!world.crossings.ways.is_empty()).then(|| ZoneCrossings::new(world));
		self
	}

	/// The zone-crossing rule these walks are under (None: every stored walk stands).
	pub fn crossings(&self) -> Option<&ZoneCrossings> {
		self.crossings.as_ref()
	}

	/// Whether these walks are the ones of `world`: the same walk inputs (`walksKey`, World::walks_key:
	/// its points and the places walked to; a data fix that touches neither keeps them), or for a walks
	/// file without one, the same `dataHash`. An unknown side counts as the same.
	pub fn built_on(&self, world: &forge_world::World) -> bool {
		if !self.walks_key.is_empty() {
			return self.walks_key == world.walks_key();
		}
		world.data_hash.as_deref().is_none_or(|h| self.data_hash.is_empty() || h == self.data_hash)
	}

	/// What `built_on` compares, for messages: this file's key and the world's.
	pub fn built_on_text(&self, world: &forge_world::World) -> String {
		if self.walks_key.is_empty() {
			format!("dataHash {} vs this world's {}", self.data_hash, world.data_hash.as_deref().unwrap_or("-"))
		} else {
			format!("walksKey {} vs this world's {}", self.walks_key, world.walks_key())
		}
	}

	#[cfg(feature = "native")]
	pub fn load(path: &std::path::Path, nw: usize) -> Result<WalkTable, String> {
		let b = std::fs::read(path).map_err(|e| format!("{}: {e}", path.display()))?;
		WalkTable::from_bin(&b, nw)
	}
}
