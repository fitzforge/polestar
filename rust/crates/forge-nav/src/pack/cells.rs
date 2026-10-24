//! The grid as cells (pack.js CellGrid, Faces, cellGrid, markHubs): per walking-map cell its
//! surfaces (the base one and floors), their ground classes, and which neighbouring surfaces a link
//! joins. Every order (tiles, pieces, joins) is the JS's, so the maps are byte-identical.

use super::{node_class, Hub, HUB_ALLIANCE, HUB_HORDE};
use crate::grid::{cls, flag, Tile, ADT as T, CELL, DIRS, NO_COMP, NO_LINK, STEP, TILE_CELLS};
use rustc_hash::FxHashMap;
use std::collections::BTreeSet;
use std::f64::consts::SQRT_2;

/// Walkable surfaces a region needs to be packed (path.js SNAP_REGION).
pub const MIN_REGION: u32 = 1000;
/// Base heights are stored to this step (yd).
pub const ZQ: i32 = 2;
const JUMP: f64 = 1.6;
/// Columns either way the ground's steepness is measured over (8.3 yd across).
const FALL_SPAN: usize = 2;
/// tan(WALK_MAX) and tan(STEEP_MAX), as V8's Math.tan gives them.
const TAN_WALK: f64 = 1.19175359259421;
const TAN_STEEP: f64 = 1.7320508075688767;
/// SPF directions: +x, -x, +y, -y, +x+y, +x-y, -x+y, -x-y (x north, y west).
pub const SDX: [i32; 8] = [1, -1, 0, 0, 1, 1, -1, -1];
pub const SDY: [i32; 8] = [0, 0, 1, -1, 1, -1, 1, -1];
const OPP: [usize; 8] = [1, 0, 3, 2, 7, 6, 5, 4];

/// The SPF direction of a step (dx, dy) in -1..=1, or -1.
pub fn dir_of(dx: i64, dy: i64) -> i32 {
	(0..8).find(|&d| SDX[d] as i64 == dx && SDY[d] as i64 == dy).map_or(-1, |d| d as i32)
}

#[inline]
fn closed(code: u8) -> bool {
	code == NO_LINK || code >> 5 == cls::CLIMB
}

/// One ADT tile's cells (a cluster).
#[derive(Clone, Debug)]
pub struct Cluster {
	/// 0 blocked, 1 ground, 2 water.
	pub val: Vec<u8>,
	/// The base height / ZQ, rounded.
	pub zq: Vec<i32>,
	/// Bit d: the base surface joins the neighbour's base in SPF direction d.
	pub mask: Vec<u8>,
	/// 1/2 close the +x/+y step, 4/8 open the +x+y/+x-y diagonal.
	pub flags: Vec<u8>,
	/// The base surface's ground class byte; None on a hand-made map (format 1).
	pub cls: Option<Vec<u8>>,
	pub floor_start: usize,
	pub floor_end: usize,
	/// The zone (uiMapID) of each of its 16 x 16 chunks, in its own axes.
	pub zone: Option<Vec<u16>>,
	/// The base surface's WMOAreaTable row per cell (maps format 3), when any has one.
	pub area: Option<Vec<u32>>,
}

impl Cluster {
	pub fn new(c2: usize, classed: bool) -> Cluster {
		Cluster { val: vec![0; c2], zq: vec![0; c2], mask: vec![0; c2], flags: vec![0; c2], cls: classed.then(|| vec![0; c2]), floor_start: 0, floor_end: 0, zone: None, area: None }
	}
}

/// pack.js CellGrid: a base node is its global cell gx * GH + gy, a floor GW * GH + its index.
pub struct CellGrid {
	pub c: usize,
	pub nx: usize,
	pub ny: usize,
	pub cx0: i32,
	pub cy0: i32,
	pub gw: usize,
	pub gh: usize,
	clusters: Vec<Cluster>,
	slot: Vec<i32>,
	keys: Vec<u32>,
	pub floor_cell: Vec<u32>,
	pub floor_val: Vec<u8>,
	pub floor_z: Vec<f64>,
	pub floor_layer: Vec<u32>,
	pub floor_class: Vec<u8>,
	/// Per floor its WMOAreaTable row (0 none; maps format 3).
	pub floor_area: Vec<u32>,
	/// The WMOAreaTable rows any node carries.
	pub areas: BTreeSet<u32>,
	pub floor_at: FxHashMap<u32, u32>,
	pairs: Vec<(u32, u32)>,
	/// After finish: node -> sorted targets (every pair with a floor, both ways).
	pub links: FxHashMap<u32, Vec<u32>>,
	/// After finish: cluster -> its sorted nodes with links.
	pub linked_of: FxHashMap<u32, Vec<u32>>,
}

impl CellGrid {
	pub fn new(c: usize, nx: usize, ny: usize, cx0: i32, cy0: i32) -> CellGrid {
		CellGrid {
			c,
			nx,
			ny,
			cx0,
			cy0,
			gw: nx * c,
			gh: ny * c,
			clusters: Vec::new(),
			slot: vec![-1; nx * ny],
			keys: Vec::new(),
			floor_cell: Vec::new(),
			floor_val: Vec::new(),
			floor_z: Vec::new(),
			floor_layer: Vec::new(),
			floor_class: Vec::new(),
			floor_area: Vec::new(),
			areas: BTreeSet::new(),
			floor_at: FxHashMap::default(),
			pairs: Vec::new(),
			links: FxHashMap::default(),
			linked_of: FxHashMap::default(),
		}
	}

	#[inline]
	pub fn nb(&self) -> u32 {
		(self.gw * self.gh) as u32
	}

	/// Cluster k, made (classed) when missing.
	pub fn cluster_mut(&mut self, k: u32) -> &mut Cluster {
		if self.slot[k as usize] < 0 {
			self.slot[k as usize] = self.clusters.len() as i32;
			self.clusters.push(Cluster::new(self.c * self.c, true));
			self.keys.push(k);
		}
		let s = self.slot[k as usize] as usize;
		&mut self.clusters[s]
	}

	/// Puts a hand-made cluster at k.
	pub fn set_cluster(&mut self, k: u32, cl: Cluster) {
		if self.slot[k as usize] < 0 {
			self.slot[k as usize] = self.clusters.len() as i32;
			self.clusters.push(cl);
			self.keys.push(k);
		} else {
			let s = self.slot[k as usize] as usize;
			self.clusters[s] = cl;
		}
	}

	pub fn cluster(&self, k: u32) -> Option<&Cluster> {
		let s = *self.slot.get(k as usize)?;
		(s >= 0).then(|| &self.clusters[s as usize])
	}

	pub fn cluster_count(&self) -> usize {
		self.clusters.len()
	}

	/// The cluster keys, ascending.
	pub fn keys_sorted(&self) -> Vec<u32> {
		let mut k = self.keys.clone();
		k.sort_unstable();
		k
	}

	pub fn clusters(&self) -> impl Iterator<Item = &Cluster> {
		self.clusters.iter()
	}

	pub fn add_floor(&mut self, cell: u32, val: u8, z: f64, class: u8, area: u32) -> u32 {
		let f = self.floor_cell.len() as u32;
		self.floor_area.push(area);
		if area != 0 {
			self.areas.insert(area);
		}
		let first = *self.floor_at.entry(cell).or_insert(f);
		self.floor_layer.push(f - first + 1);
		self.floor_cell.push(cell);
		self.floor_val.push(val);
		self.floor_z.push(z);
		self.floor_class.push(class);
		self.nb() + f
	}

	/// Keeps only the WMOAreaTable rows `keep` accepts: every other node's area becomes 0 (a cluster left
	/// with none carries no area field).
	pub fn keep_areas(&mut self, keep: impl Fn(u32) -> bool) {
		let mut kept = BTreeSet::new();
		for a in self.floor_area.iter_mut().filter(|a| **a != 0) {
			if keep(*a) {
				kept.insert(*a);
			} else {
				*a = 0;
			}
		}
		for cl in &mut self.clusters {
			if let Some(v) = cl.area.as_mut() {
				for a in v.iter_mut().filter(|a| **a != 0) {
					if keep(*a) {
						kept.insert(*a);
					} else {
						*a = 0;
					}
				}
				if v.iter().all(|&a| a == 0) {
					cl.area = None;
				}
			}
		}
		self.areas = kept;
	}

	/// The cluster index and local cell of global cell (gx, gy).
	#[inline]
	pub fn at(&self, gx: i64, gy: i64) -> Option<(usize, usize)> {
		let c = self.c as i64;
		if gx < 0 || gy < 0 || gx >= self.gw as i64 || gy >= self.gh as i64 {
			return None;
		}
		let s = self.slot[((gx / c) * self.ny as i64 + gy / c) as usize];
		(s >= 0).then(|| (s as usize, ((gx % c) * c + gy % c) as usize))
	}

	/// Value of global cell (gx, gy); 0 outside.
	#[inline]
	pub fn value(&self, gx: i64, gy: i64) -> u8 {
		self.at(gx, gy).map_or(0, |(s, l)| self.clusters[s].val[l])
	}

	pub fn node_value(&self, n: u32) -> u8 {
		let nb = self.nb();
		if n >= nb {
			return self.floor_val[(n - nb) as usize];
		}
		self.value((n as usize / self.gh) as i64, (n as usize % self.gh) as i64)
	}

	/// The ground class byte of node n; 0 without classes.
	pub fn node_class(&self, n: u32) -> u8 {
		let nb = self.nb();
		if n >= nb {
			return self.floor_class.get((n - nb) as usize).copied().unwrap_or(0);
		}
		match self.at((n as usize / self.gh) as i64, (n as usize % self.gh) as i64) {
			Some((s, l)) => self.clusters[s].cls.as_ref().map_or(0, |c| c[l]),
			None => 0,
		}
	}

	#[inline]
	pub fn cell_of(&self, n: u32) -> u32 {
		let nb = self.nb();
		if n < nb {
			n
		} else {
			self.floor_cell[(n - nb) as usize]
		}
	}

	#[inline]
	pub fn cluster_of_cell(&self, c: u32) -> u32 {
		let gx = c as usize / self.gh;
		let gy = c as usize % self.gh;
		((gx / self.c) * self.ny + gy / self.c) as u32
	}

	/// ORs hub bits into every surface of global cell (gx, gy).
	fn add_hub(&mut self, gx: i64, gy: i64, bits: u8) {
		let Some((s, l)) = self.at(gx, gy) else { return };
		let cl = &mut self.clusters[s];
		if cl.val[l] != 0 {
			if let Some(c) = cl.cls.as_mut() {
				c[l] |= bits;
			}
		}
		let c = (gx as usize * self.gh + gy as usize) as u32;
		if let Some(&f0) = self.floor_at.get(&c) {
			let mut f = f0 as usize;
			while f < self.floor_cell.len() && self.floor_cell[f] == c {
				self.floor_class[f] |= bits;
				f += 1;
			}
		}
	}

	/// Two nodes of neighbouring cells are joined (either way round).
	pub fn join(&mut self, a: u32, b: u32) {
		let gh = self.gh as i64;
		let (ca, cb) = (self.cell_of(a) as i64, self.cell_of(b) as i64);
		let dx = cb / gh - ca / gh;
		let dy = cb % gh - ca % gh;
		if !(-1..=1).contains(&dx) || !(-1..=1).contains(&dy) || (dx == 0 && dy == 0) {
			return;
		}
		let nb = self.nb();
		if a < nb && b < nb {
			let d = dir_of(dx, dy) as usize;
			let (s, l) = self.at(ca / gh, ca % gh).unwrap();
			self.clusters[s].mask[l] |= 1 << d;
			let (s, l) = self.at(cb / gh, cb % gh).unwrap();
			self.clusters[s].mask[l] |= 1 << OPP[d];
			return;
		}
		self.pairs.push((a, b));
		self.pairs.push((b, a));
	}

	/// Sorted unique links, the grid's flags, and per cluster its linked nodes.
	pub fn finish(&mut self) {
		let mut p = std::mem::take(&mut self.pairs);
		p.sort_unstable();
		p.dedup();
		self.links = FxHashMap::default();
		for (a, b) in p {
			self.links.entry(a).or_default().push(b);
		}
		let mut from: Vec<u32> = self.links.keys().copied().collect();
		from.sort_unstable();
		self.linked_of = FxHashMap::default();
		for a in from {
			let k = self.cluster_of_cell(self.cell_of(a));
			self.linked_of.entry(k).or_default().push(a);
		}
		self.cut_flags();
	}

	/// gen_nav.py step_ok: the orthogonal step from (ux, uy) into (vx, vy).
	pub fn step_ok(&self, ux: i64, uy: i64, vx: i64, vy: i64) -> bool {
		if self.value(vx, vy) == 0 {
			return false;
		}
		if vx != ux {
			return self.at(ux.min(vx), uy).is_some_and(|(s, l)| self.clusters[s].flags[l] & 1 == 0);
		}
		self.at(ux, uy.min(vy)).is_some_and(|(s, l)| self.clusters[s].flags[l] & 2 == 0)
	}

	/// gen_nav.py diag_ok: either L-shaped detour open, or the explicit diagonal flag.
	pub fn diag_ok(&self, ux: i64, uy: i64, vx: i64, vy: i64) -> bool {
		if self.value(vx, vy) == 0 {
			return false;
		}
		if (self.step_ok(ux, uy, vx, uy) && self.step_ok(vx, uy, vx, vy)) || (self.step_ok(ux, uy, ux, vy) && self.step_ok(ux, vy, vx, vy)) {
			return true;
		}
		let (ax, ay, by) = if vx > ux { (ux, uy, vy) } else { (vx, vy, uy) };
		self.at(ax, ay).is_some_and(|(s, l)| self.clusters[s].flags[l] & (if by > ay { 4 } else { 8 }) != 0)
	}

	fn cut_flags(&mut self) {
		let (c, ny) = (self.c, self.ny);
		let ks = self.keys_sorted();
		for pass in 0..2 {
			for &k in &ks {
				let s = self.slot[k as usize] as usize;
				let gx0 = (k as usize / ny * c) as i64;
				let gy0 = (k as usize % ny * c) as i64;
				for l in 0..c * c {
					if self.clusters[s].val[l] == 0 {
						continue;
					}
					let gx = gx0 + (l / c) as i64;
					let gy = gy0 + (l % c) as i64;
					let m = self.clusters[s].mask[l];
					let mut set = 0u8;
					if pass == 0 {
						if self.value(gx + 1, gy) != 0 && m & 1 == 0 {
							set |= 1;
						}
						if self.value(gx, gy + 1) != 0 && m & 4 == 0 {
							set |= 2;
						}
					} else {
						if m & 16 != 0 && self.value(gx + 1, gy + 1) != 0 && !self.diag_ok(gx, gy, gx + 1, gy + 1) {
							set |= 4;
						}
						if m & 32 != 0 && self.value(gx + 1, gy - 1) != 0 && !self.diag_ok(gx, gy, gx + 1, gy - 1) {
							set |= 8;
						}
					}
					self.clusters[s].flags[l] |= set;
				}
			}
		}
	}
}

/// The joins between cells, holding back those up a face; bridge() opens, gentlest first, only the
/// face links that join two parts nothing else joins.
struct Faces {
	nb: u32,
	base: Vec<i32>,
	floor: Vec<i32>,
	a: Vec<u32>,
	b: Vec<u32>,
	g: Vec<f64>,
}

impl Faces {
	fn new(cg: &CellGrid) -> Faces {
		Faces { nb: cg.nb(), base: vec![0; cg.nb() as usize], floor: vec![0; 1 << 16], a: Vec::new(), b: Vec::new(), g: Vec::new() }
	}

	fn up(&self, x: u32) -> i64 {
		if x < self.nb {
			return self.base[x as usize] as i64 - 1;
		}
		let f = (x - self.nb) as usize;
		if f < self.floor.len() {
			self.floor[f] as i64 - 1
		} else {
			-1
		}
	}

	fn set(&mut self, x: u32, p: u32) {
		if x < self.nb {
			self.base[x as usize] = p as i32 + 1;
			return;
		}
		let f = (x - self.nb) as usize;
		if f >= self.floor.len() {
			let n = (f + 1).max(self.floor.len() * 2);
			self.floor.resize(n, 0);
		}
		self.floor[f] = p as i32 + 1;
	}

	fn find(&mut self, mut x: u32) -> u32 {
		let mut p = self.up(x);
		while p >= 0 {
			let q = self.up(p as u32);
			if q >= 0 {
				self.set(x, q as u32);
			}
			x = p as u32;
			p = self.up(x);
		}
		x
	}

	/// An open join; one between clusters that meet only at a corner joins nothing for the engine.
	fn join(&mut self, cg: &mut CellGrid, a: u32, b: u32) {
		cg.join(a, b);
		let ka = cg.cluster_of_cell(cg.cell_of(a)) as usize;
		let kb = cg.cluster_of_cell(cg.cell_of(b)) as usize;
		if ka / cg.ny != kb / cg.ny && ka % cg.ny != kb % cg.ny {
			return;
		}
		let ra = self.find(a);
		let rb = self.find(b);
		if ra != rb {
			self.set(ra.max(rb), ra.min(rb));
		}
	}

	fn add(&mut self, a: u32, b: u32, g: f64) {
		self.a.push(a);
		self.b.push(b);
		self.g.push(g);
	}

	fn bridge(&mut self, cg: &mut CellGrid) -> usize {
		let mut order: Vec<usize> = (0..self.g.len()).collect();
		order.sort_by(|&x, &y| self.g[x].partial_cmp(&self.g[y]).unwrap().then(self.a[x].cmp(&self.a[y])).then(self.b[x].cmp(&self.b[y])));
		let mut opened = 0;
		for x in order {
			let (a, b) = (self.a[x], self.b[x]);
			if self.find(a) == self.find(b) {
				continue;
			}
			self.join(cg, a, b);
			opened += 1;
		}
		opened
	}
}

/// What cellGrid's ground classes come from (each optional).
#[derive(Default)]
pub struct ClassLayers<'a> {
	/// A tile's road columns (65536, j * 256 + i, nonzero road), by (col, row).
	pub roads: Option<&'a FxHashMap<(u32, u32), Vec<u8>>>,
	pub hubs: &'a [Hub],
	/// Whether a chunk (its centre, its area) lies in a capital.
	pub city: Option<&'a dyn Fn(u32, f64, f64, u32) -> bool>,
	/// The uiMapID of the zone a chunk's area lies in (0 for none).
	pub zone: Option<&'a dyn Fn(u32) -> u32>,
}

/// The regions of a continent's graph (path.js readRegions).
pub struct Regions<'a> {
	pub comp_base: &'a dyn Fn(u32, u32) -> Option<u32>,
	pub region: &'a [u32],
	pub region_size: &'a [u32],
}

/// Counters for the log line.
#[derive(Default, Debug)]
pub struct CellStats {
	pub packed: usize,
	pub dropped: usize,
	pub faces: usize,
	pub opened: usize,
	pub hub_cells: usize,
}

struct Piece {
	root: usize,
	count: u32,
	wet: u32,
	rep: usize,
	rep_k: usize,
	d2: f64,
	size: u32,
	joined: u8,
	members: Vec<u32>,
	indoor: u32,
	road: u32,
	tslope: u8,
	z: f64,
	val: u8,
	cls: u8,
	/// Its entries' WMOAreaTable rows with their counts (maps format 3).
	areas: Vec<(u32, u32)>,
	/// The commonest of them (ties: the lower row id), 0 when none has one.
	area: u32,
}

/// A tile as cell_grid reads it: the tile, and the WMOAreaTable row of each entry when the grid
/// has the tile's area sidecar (maps format 3).
pub type LoadedTile = (Tile, Option<Vec<u32>>);

/// pack.js cellGrid: tiles (col, row) of continent c, loaded one at a time by `load`.
pub fn cell_grid(tiles: &[(u32, u32)], load: &dyn Fn(u32, u32) -> Result<LoadedTile, String>, regions: &Regions, cells: usize, c: u32, layers: &ClassLayers) -> Result<(CellGrid, CellStats), String> {
	let cc = cells;
	let max_row = tiles.iter().map(|t| t.1).max().ok_or("pack: no tiles")?;
	let min_row = tiles.iter().map(|t| t.1).min().unwrap();
	let max_col = tiles.iter().map(|t| t.0).max().unwrap();
	let min_col = tiles.iter().map(|t| t.0).min().unwrap();
	let mut cg = CellGrid::new(cc, (max_row - min_row + 1) as usize, (max_col - min_col + 1) as usize, 31 - max_row as i32, 31 - max_col as i32);
	let gh = cg.gh;
	let tc = TILE_CELLS;
	let mut lx = vec![0usize; tc];
	let mut ly = vec![0usize; tc];
	for j in 0..tc {
		lx[j] = (((tc - 1 - j) as f64 + 0.5) * cc as f64 / tc as f64).floor() as usize;
	}
	for i in 0..tc {
		ly[i] = (((tc - 1 - i) as f64 + 0.5) * cc as f64 / tc as f64).floor() as usize;
	}
	let mut cols_at = vec![0usize; cc * cc + 1];
	for k in 0..tc * tc {
		cols_at[lx[k >> 8] * cc + ly[k & 255] + 1] += 1;
	}
	for l in 0..cc * cc {
		cols_at[l + 1] += cols_at[l];
	}
	let mut col_list = vec![0usize; tc * tc];
	let mut fill = cols_at[..cc * cc].to_vec();
	for k in 0..tc * tc {
		let l = lx[k >> 8] * cc + ly[k & 255];
		col_list[fill[l]] = k;
		fill[l] += 1;
	}
	let mut off = vec![0f64; tc];
	for (q, o) in off.iter_mut().enumerate() {
		*o = q as f64 + 0.5 - (((((q as f64 + 0.5) * cc as f64) / tc as f64).floor() + 0.5) * tc as f64) / cc as f64;
	}
	let mut order: Vec<(u32, u32)> = tiles.to_vec();
	order.sort_by(|a, b| b.1.cmp(&a.1).then(b.0.cmp(&a.0)));
	let listed: rustc_hash::FxHashSet<(u32, u32)> = tiles.iter().copied().collect();
	let mut border: FxHashMap<(u32, u32), FxHashMap<u32, u32>> = FxHashMap::default();
	let mut cross: Vec<(u32, (u32, u32), u32, bool)> = Vec::new();
	let mut faces = Faces::new(&cg);
	let mut st = CellStats::default();
	for &(col, row) in &order {
		let (t, tile_area) = load(col, row)?;
		let kx = (max_row - row) as usize;
		let ky = (max_col - col) as usize;
		let k = (kx * cg.ny + ky) as u32;
		let floor_start = cg.floor_cell.len();
		cg.cluster_mut(k).floor_start = floor_start;
		let n = t.n;
		let (first, z, ceil, flags, links, comp) = (&t.first, &t.z, &t.ceil, &t.flags, &t.links, &t.comp);
		let zero = vec![0u8; if t.tslope.len() == n { 0 } else { n }];
		let tslope: &[u8] = if t.tslope.len() == n { &t.tslope } else { &zero };
		let roads = layers.roads.and_then(|m| m.get(&(col, row)));
		let mut city = [0u8; 256];
		if let Some(f) = layers.city {
			for (ch, v) in city.iter_mut().enumerate() {
				let wx = (32 - row as i64) as f64 * T - (((ch >> 4) * 16 + 8) as f64) * CELL;
				let wy = (32 - col as i64) as f64 * T - (((ch & 15) * 16 + 8) as f64) * CELL;
				*v = f(c, wx, wy, t.areas[ch] as u32) as u8;
			}
		}
		if let Some(f) = layers.zone {
			let mut zone = vec![0u16; 256];
			let mut any = false;
			for (q, zq) in zone.iter_mut().enumerate() {
				*zq = f(t.areas[255 - q] as u32) as u16;
				any = *zq != 0 || any;
			}
			if any {
				cg.cluster_mut(k).zone = Some(zone);
			}
		}
		let terr = |e: usize| flags[e] & (flag::TERRAIN | flag::WMO | flag::M2) == flag::TERRAIN;
		let slide = |e: usize| flags[e] & (flag::TERRAIN | flag::WMO | flag::M2 | flag::STEEP) == (flag::TERRAIN | flag::STEEP);
		let at = |x: usize, dir: usize, ci: i32, cj: i32| -> Option<(usize, i32, i32)> {
			let code = links[x * 8 + dir];
			let ni = ci + DIRS[dir].0;
			let nj = cj + DIRS[dir].1;
			if code == NO_LINK || !(0..=255).contains(&ni) || !(0..=255).contains(&nj) {
				return None;
			}
			Some((first[nj as usize * tc + ni as usize] as usize + (code & 31) as usize, ni, nj))
		};
		let steep_run = |e: usize, i: i32, j: i32, d: usize, e2: usize| -> bool {
			if !terr(e) || !terr(e2) || !(slide(e) || slide(e2)) {
				return false;
			}
			let mut lo = f64::INFINITY;
			let mut hi = f64::NEG_INFINITY;
			let mut walk = |mut x: usize, mut ci: i32, mut cj: i32, dir: usize| {
				let mut s = 0;
				while s < 64 && slide(x) {
					let zx = z[x] as f64;
					if zx < lo {
						lo = zx;
					}
					if zx > hi {
						hi = zx;
					}
					let Some((y, ni, nj)) = at(x, dir, ci, cj) else { return };
					x = y;
					if !terr(x) {
						return;
					}
					ci = ni;
					cj = nj;
					s += 1;
				}
			};
			walk(e2, i + DIRS[d].0, j + DIRS[d].1, d);
			walk(e, i, j, (d + 4) & 7);
			hi > lo + JUMP
		};
		// The fall cache is a Float32Array: the first call returns the f64 root, later ones the f32.
		let mut fall = vec![-1f32; n];
		let reach = |e: usize, i: i32, j: i32, d: usize| -> (usize, usize) {
			let (mut x, mut ci, mut cj) = (e, i, j);
			let mut steps = 0;
			while steps < FALL_SPAN {
				let Some((y, ni, nj)) = at(x, d, ci, cj) else { break };
				if !terr(y) {
					break;
				}
				x = y;
				ci = ni;
				cj = nj;
				steps += 1;
			}
			(x, steps)
		};
		let mut fall_of = |e: usize, k2: usize| -> f64 {
			if fall[e] >= 0.0 {
				return fall[e] as f64;
			}
			let i = (k2 & 255) as i32;
			let j = (k2 >> 8) as i32;
			let mut g2 = 0.0;
			for d in [0usize, 2] {
				let (p, sp) = reach(e, i, j, d);
				let (q, sq) = reach(e, i, j, d + 4);
				if sp + sq > 0 {
					let g = (z[p] as f64 - z[q] as f64) / ((sp + sq) as f64 * CELL);
					g2 += g * g;
				}
			}
			let r = g2.sqrt();
			fall[e] = r as f32;
			r
		};
		let gt = (regions.comp_base)(col, row);
		let size_of = |e: usize| -> u32 { regions.region_size[regions.region[(gt.unwrap() + comp[e]) as usize] as usize] };
		let big = |e: usize| flags[e] & flag::BLOCKED == 0 && comp[e] != NO_COMP && gt.is_some() && size_of(e) >= MIN_REGION;
		let mut node = vec![-1i64; n];
		let mut loc = vec![-1i32; n];
		let mut parent: Vec<usize> = Vec::new();
		let mut joined = vec![0u8; n];
		for k2 in 0..tc * tc {
			let i = (k2 & 255) as i32;
			let j = (k2 >> 8) as i32;
			for e in first[k2] as usize..first[k2 + 1] as usize {
				if !big(e) {
					continue;
				}
				for (d, &(di, dj)) in DIRS.iter().enumerate() {
					let code = links[e * 8 + d];
					if closed(code) {
						continue;
					}
					let (i2, j2) = (i + di, j + dj);
					if !(0..=255).contains(&i2) || !(0..=255).contains(&j2) {
						joined[e] = 1;
					} else if lx[j2 as usize] != lx[j as usize] || ly[i2 as usize] != ly[i as usize] {
						let f = first[j2 as usize * tc + i2 as usize] as usize + (code & 31) as usize;
						if big(f) {
							joined[e] = 1;
							joined[f] = 1;
						}
					}
				}
			}
		}
		let mut ents: Vec<(usize, usize)> = Vec::new();
		for lc in 0..cc * cc {
			ents.clear();
			for &kk in &col_list[cols_at[lc]..cols_at[lc + 1]] {
				for e in first[kk] as usize..first[kk + 1] as usize {
					if !big(e) {
						if flags[e] & flag::BLOCKED == 0 {
							st.dropped += 1;
						}
						continue;
					}
					let a = ents.len();
					loc[e] = a as i32;
					if parent.len() <= a {
						parent.resize(a + 1, 0);
					}
					parent[a] = a;
					ents.push((e, kk));
				}
			}
			let m = ents.len();
			if m == 0 {
				continue;
			}
			let clx = lc / cc;
			let cly = lc % cc;
			fn find(parent: &mut [usize], mut x: usize) -> usize {
				while parent[x] != x {
					parent[x] = parent[parent[x]];
					x = parent[x];
				}
				x
			}
			for a in 0..m {
				let (e, kk) = ents[a];
				let i = (kk & 255) as i32;
				let j = (kk >> 8) as i32;
				for (d, &(di, dj)) in DIRS.iter().enumerate() {
					let code = links[e * 8 + d];
					if closed(code) {
						continue;
					}
					let (i2, j2) = (i + di, j + dj);
					if !(0..=255).contains(&i2) || !(0..=255).contains(&j2) || lx[j2 as usize] != clx || ly[i2 as usize] != cly {
						continue;
					}
					let b = loc[first[j2 as usize * tc + i2 as usize] as usize + (code & 31) as usize];
					if b >= 0 {
						let ra = find(&mut parent, a);
						let rb = find(&mut parent, b as usize);
						if ra != rb {
							parent[ra.max(rb)] = ra.min(rb);
						}
					}
				}
			}
			let mut pieces: Vec<Piece> = Vec::new();
			let mut of_root: FxHashMap<usize, usize> = FxHashMap::default();
			for a in 0..m {
				let r = find(&mut parent, a);
				let (e, kk) = ents[a];
				let pi = *of_root.entry(r).or_insert_with(|| {
					pieces.push(Piece {
						root: r,
						count: 0,
						wet: 0,
						rep: usize::MAX,
						rep_k: 0,
						d2: f64::INFINITY,
						size: 0,
						joined: 0,
						members: Vec::new(),
						indoor: 0,
						road: 0,
						tslope: 0,
						z: 0.0,
						val: 0,
						cls: 0,
						areas: Vec::new(),
						area: 0,
					});
					pieces.len() - 1
				});
				let p = &mut pieces[pi];
				p.count += 1;
				p.members.push(e as u32);
				if flags[e] & flag::SWIM != 0 {
					p.wet += 1;
				}
				if flags[e] & flag::INDOOR != 0 {
					p.indoor += 1;
				}
				if roads.is_some_and(|r| r[kk] != 0) {
					p.road += 1;
				}
				if tslope[e] > p.tslope {
					p.tslope = tslope[e];
				}
				p.joined |= joined[e];
				if let Some(a) = tile_area.as_ref().map(|v| v[e]).filter(|&a| a != 0) {
					match p.areas.iter_mut().find(|x| x.0 == a) {
						Some(x) => x.1 += 1,
						None => p.areas.push((a, 1)),
					}
				}
				let (o1, o2) = (off[255 - (kk >> 8)], off[255 - (kk & 255)]);
				let d2 = o1 * o1 + o2 * o2;
				if d2 < p.d2 || (d2 == p.d2 && p.rep != usize::MAX && z[e] > z[p.rep]) {
					p.d2 = d2;
					p.rep = e;
					p.rep_k = kk;
				}
				p.size = p.size.max(size_of(e));
			}
			let mut list: Vec<Piece> = pieces.into_iter().filter(|p| p.joined != 0 && z[p.rep] >= -2048.0 && z[p.rep] <= 2047.0).collect();
			if list.is_empty() {
				for &(e, _) in &ents {
					loc[e] = -1;
				}
				continue;
			}
			for p in list.iter_mut() {
				// The piece's area: its entries' commonest (ties: the lower row id), 0 when none has one.
				let mut n = 0;
				for &(a, m) in &p.areas {
					if m > n || (m == n && a < p.area) {
						p.area = a;
						n = m;
					}
				}
				p.z = z[p.rep] as f64;
				p.val = if p.wet * 2 > p.count { 2 } else { 1 };
				let indoor = p.indoor * 2 > p.count;
				p.cls =
					node_class((if indoor { flag::INDOOR } else { 0 }) | (if p.val == 2 { flag::SWIM } else { 0 }), p.tslope, p.road > 0, city[(p.rep_k >> 12) * 16 + ((p.rep_k & 255) >> 4)] == 1, 0);
			}
			let water = list.iter().filter(|p| p.val == 2).map(|p| p.z).fold(f64::NEG_INFINITY, f64::max);
			list.retain(|p| p.z >= water - STEP || (p.indoor * 2 > p.count && (ceil[p.rep] as f64) < water));
			list.sort_by(|p, q| q.size.cmp(&p.size).then(q.count.cmp(&p.count)).then(q.z.partial_cmp(&p.z).unwrap()).then(p.root.cmp(&q.root)));
			let packed = list.len();
			let mut it = list.into_iter();
			let bottom = it.next().unwrap();
			let mut rest: Vec<Piece> = it.collect();
			rest.sort_by(|p, q| p.z.partial_cmp(&q.z).unwrap().then(q.count.cmp(&p.count)).then(p.root.cmp(&q.root)));
			let gx = kx * cc + clx;
			let gy = ky * cc + cly;
			let cell = (gx * gh + gy) as u32;
			{
				let cl = cg.cluster_mut(k);
				cl.val[lc] = bottom.val;
				cl.zq[lc] = super::js_round(bottom.z / ZQ as f64) as i32;
				cl.cls.as_mut().unwrap()[lc] = bottom.cls;
				if bottom.area != 0 {
					cl.area.get_or_insert_with(|| vec![0; cc * cc])[lc] = bottom.area;
				}
			}
			if bottom.area != 0 {
				cg.areas.insert(bottom.area);
			}
			for &e in &bottom.members {
				node[e as usize] = cell as i64;
			}
			for p in &rest {
				let f = cg.add_floor(cell, p.val, p.z, p.cls, p.area);
				for &e in &p.members {
					node[e as usize] = f as i64;
				}
			}
			st.packed += packed;
			for &(e, _) in &ents {
				loc[e] = -1;
			}
		}
		let floor_end = cg.floor_cell.len();
		cg.cluster_mut(k).floor_end = floor_end;
		// Joins: every link (not a closed one) into another cell.
		let mut mine: FxHashMap<u32, u32> = FxHashMap::default();
		for k2 in 0..tc * tc {
			let i = (k2 & 255) as i32;
			let j = (k2 >> 8) as i32;
			let edge = i == 0 || j == 0 || i == 255 || j == 255;
			for e in first[k2] as usize..first[k2 + 1] as usize {
				let a = node[e];
				if a < 0 {
					continue;
				}
				let a = a as u32;
				if edge {
					mine.insert(((k2 as u32) << 5) | (e as u32 - first[k2]), a);
				}
				for (d, &(di, dj)) in DIRS.iter().enumerate() {
					let code = links[e * 8 + d];
					if closed(code) {
						continue;
					}
					let (mut i2, mut j2) = (i + di, j + dj);
					if (0..=255).contains(&i2) && (0..=255).contains(&j2) {
						if lx[j2 as usize] == lx[j as usize] && ly[i2 as usize] == ly[i as usize] {
							continue;
						}
						let k3 = j2 as usize * tc + i2 as usize;
						let e2 = first[k3] as usize + (code & 31) as usize;
						let b = node[e2];
						if b < 0 {
							continue;
						}
						let b = b as u32;
						if code >> 5 == cls::STEEP || steep_run(e, i, j, d, e2) || (terr(e) && terr(e2) && (fall_of(e, k2) > TAN_WALK || fall_of(e2, k3) > TAN_WALK)) {
							faces.add(a, b, (z[e2] as f64 - z[e] as f64).abs() / if d & 1 == 1 { CELL * SQRT_2 } else { CELL });
						} else {
							faces.join(&mut cg, a, b);
						}
						continue;
					}
					let (mut ncol, mut nrow) = (col as i64, row as i64);
					if i2 < 0 {
						ncol -= 1;
						i2 += 256;
					} else if i2 > 255 {
						ncol += 1;
						i2 -= 256;
					}
					if j2 < 0 {
						nrow -= 1;
						j2 += 256;
					} else if j2 > 255 {
						nrow += 1;
						j2 -= 256;
					}
					if ncol >= 0 && nrow >= 0 && listed.contains(&(ncol as u32, nrow as u32)) {
						cross.push((a, (ncol as u32, nrow as u32), ((((j2 as u32) << 8) | i2 as u32) << 5) | (code & 31) as u32, code >> 5 == cls::STEEP));
					}
				}
			}
		}
		border.insert((col, row), mine);
	}
	for &(a, key, code, steep) in &cross {
		let Some(&b) = border.get(&key).and_then(|m| m.get(&code)) else { continue };
		if steep {
			faces.add(a, b, TAN_STEEP);
		} else {
			faces.join(&mut cg, a, b);
		}
	}
	st.faces = faces.g.len();
	st.opened = faces.bridge(&mut cg);
	drop(faces);
	st.hub_cells = mark_hubs(&mut cg, layers.hubs);
	cg.finish();
	Ok((cg, st))
}

/// The hub bits: every cell a hub's disk touches, on every surface of the cell. -> cells marked.
pub fn mark_hubs(cg: &mut CellGrid, hubs: &[Hub]) -> usize {
	let cs = T / cg.c as f64;
	let x0 = cg.cx0 as f64 * T;
	let y0 = cg.cy0 as f64 * T;
	let mut marked = 0;
	for hub in hubs {
		let bits = match hub.side.as_str() {
			"Alliance" => HUB_ALLIANCE,
			"Horde" => HUB_HORDE,
			_ => 0,
		};
		if bits == 0 {
			continue;
		}
		let mut cells: rustc_hash::FxHashSet<(i64, i64)> = Default::default();
		for &[hx, hy, r] in &hub.disks {
			let gx_end = ((hx + r - x0) / cs).floor() as i64;
			let mut gx = ((hx - r - x0) / cs).floor() as i64;
			while gx <= gx_end {
				let dx = (x0 + gx as f64 * cs - hx).max(0.0).max(hx - (x0 + (gx + 1) as f64 * cs));
				let gy_end = ((hy + r - y0) / cs).floor() as i64;
				let mut gy = ((hy - r - y0) / cs).floor() as i64;
				while gy <= gy_end {
					let dy = (y0 + gy as f64 * cs - hy).max(0.0).max(hy - (y0 + (gy + 1) as f64 * cs));
					if dx * dx + dy * dy <= r * r && gx >= 0 && gy >= 0 && gx < cg.gw as i64 && gy < cg.gh as i64 {
						cells.insert((gx, gy));
					}
					gy += 1;
				}
				gx += 1;
			}
		}
		for &(gx, gy) in &cells {
			cg.add_hub(gx, gy, bits);
		}
		marked += cells.len();
	}
	marked
}
