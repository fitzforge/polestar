//! Walking routes over a format-4 pack: a port of tools/lib/nav/nav4/router.js, itself a port of Leffe's format-4
//! router (his Routing/Path.lua: endpoint connections, the abstract Dijkstra over the PMG4 entrance graph, replay
//! of the selected motion traces, drawing; Routing/PathGrid.lua: surfaces, snapping, neighbour, sight, string
//! pulling; Routing/Costs.lua). Path.lua and PathGrid.lua started from Shortest Path Forever v1.16.0 by Cillian
//! Berragan. Copyright (C) 2026 Cillian Berragan; Copyright (c) 2026 The Polestar authors (Leffe's reader).
//! GPL-3.0-or-later.
//!
//! Faithful to the JS port step for step: the same heap (and so the same ties), expansion order, map insertion
//! orders and float arithmetic, so a route's cost and points are the JS port's bit for bit.
//!
//! Leffe's lift layer (lifts.rs) is spliced on top: each landing is a node of the abstract search (LIFT + its
//! index), joined to its cluster's entrances (and to the ends and other landings of its cluster) by grid searches,
//! and to the other landing of its car by the ride. A walk across a lift-separated city's floors searches a second
//! layer of the graph (LAYER + id) that only a ride on one of the city's lifts reaches. Landings and that layer go
//! on a heap of their own (heap3), popped only when its top is strictly cheaper than the reader's: a walk that no
//! lift serves pops, relaxes and draws exactly as the reader's does.

use super::lifts::{ride_seconds, Group, MapLifts, RUN};
use super::pack::{fail, Cluster, Graph, Meta, B64, DX, DY, R, SLOPE_EPS, STRIDE, WALK_TAN};
use super::store::Store;
use super::{Event, Faction, Hub, Leg, Many, Move, Opts, Route, Style, Surface, Validate, P};
use rustc_hash::{FxHashMap, FxHashSet};
use std::collections::VecDeque;
use std::sync::{Arc, Mutex};

/// A walk reached map piece `k`, which the maps do not hold.
fn missing_cluster(k: u32) -> String {
	format!("Leffe's navigation maps: no piece {k} where a walk needs one (missing or damaged files?)")
}

const SNAP: i64 = 6;
const ZTOL: f64 = 10.0;
const RETRIES: usize = 8;
const DROP: f64 = 30.0;
const START: i64 = -1;
const GOAL: i64 = -2;
/// A lift landing's id in the abstract search: LIFT + 2 × car + end.
const LIFT: i64 = 1 << 46;
/// The second layer of the abstract search (a node after a ride on a lift-separated city's lift): LAYER + id.
const LAYER: i64 = 1 << 47;
/// Pts.arc's cluster for a ride's landing (the arc: its car).
const RIDE: u32 = u32::MAX;
/// Lb.edge of a ride.
const RIDE_EDGE: i64 = -2;

/// An abstract id -> (its id on the first layer, its layer offset).
fn unlayer(id: i64) -> (i64, i64) {
	if id >= LAYER {
		(id - LAYER, LAYER)
	} else {
		(id, 0)
	}
}

/// The gap between float32 x and the next float32 away from zero.
fn ulp32(x: f64) -> f64 {
	let f = x as f32;
	let next = f32::from_bits((f.to_bits() as i32).wrapping_add(1) as u32);
	(next as f64 - x).abs()
}

fn direction(dx: i64, dy: i64) -> usize {
	for d in 0..8 {
		if DX[d] == dx && DY[d] == dy {
			return d;
		}
	}
	0
}

// ---- Routing/Costs.lua ----
pub const HUB_ALLIANCE: i64 = 8;
pub const HUB_HORDE: i64 = 16;
pub const HUB: f64 = 20.0;

fn style_mult(style: Style) -> [f64; 6] {
	match style {
		Style::Fastest => [1.0, 1.0, 1.0, 1.2, 2.0, 1.0],
		Style::Balanced => [1.0, 0.8, 1.3, 2.5, 2.0, 1.0],
		Style::Roads => [1.0, 0.5, 1.6, 4.0, 2.0, 1.0],
	}
}
pub fn style_min(style: Style) -> f64 {
	match style {
		Style::Fastest => 1.0,
		Style::Balanced => 0.8,
		Style::Roads => 0.5,
	}
}
/// Costs.Mult(c, profile, style).
pub fn cost_mult(c: i64, profile: Option<Faction>, style: Style) -> f64 {
	let m = style_mult(style).get((c % 8) as usize).copied().unwrap_or(1.0);
	let hub = c - c % 8;
	let hostile = (profile == Some(Faction::Horde) && hub % 16 >= 8) || (profile == Some(Faction::Alliance) && hub % 32 >= 16);
	if hostile {
		m * HUB
	} else {
		m
	}
}

// ---- the heap (Path.lua push/pop on parallel arrays) ----
#[derive(Default)]
pub(crate) struct Heap {
	k: Vec<f64>,
	v: Vec<i64>,
	n: usize,
}
impl Heap {
	fn clear(&mut self) {
		self.n = 0;
	}
	fn push(&mut self, key: f64, val: i64) {
		self.n += 1;
		if self.n >= self.k.len() {
			let cap = (self.k.len() * 2).max(1 << 16);
			self.k.resize(cap, 0.0);
			self.v.resize(cap, 0);
		}
		let mut i = self.n;
		while i > 1 {
			let p = i >> 1;
			if self.k[p] <= key {
				break;
			}
			self.k[i] = self.k[p];
			self.v[i] = self.v[p];
			i = p;
		}
		self.k[i] = key;
		self.v[i] = val;
	}
	fn pop(&mut self) -> i64 {
		let top = self.v[1];
		let key = self.k[self.n];
		let val = self.v[self.n];
		self.n -= 1;
		let mut i = 1;
		loop {
			let mut c = i * 2;
			if c > self.n {
				break;
			}
			if c < self.n && self.k[c + 1] < self.k[c] {
				c += 1;
			}
			if self.k[c] >= key {
				break;
			}
			self.k[i] = self.k[c];
			self.v[i] = self.v[c];
			i = c;
		}
		self.k[i] = key;
		self.v[i] = val;
		top
	}
}

/// A search tree: g, parent, stamps, yards, jumps and the motion arc reaching each node.
#[derive(Default)]
pub(crate) struct Tree {
	cap: usize,
	gen: u32,
	g: Vec<f64>,
	par: Vec<i32>,
	stamp: Vec<u32>,
	closed: Vec<u32>,
	y: Vec<f64>,
	j: Vec<f64>,
	arc: Vec<i32>,
}
impl Tree {
	fn fit(&mut self, n: usize) {
		if n <= self.cap {
			return;
		}
		// Exactly what the cluster needs (no doubling: pooled trees move between clusters of similar size).
		let cap = n.max(1024);
		self.g = vec![0.0; cap];
		self.par = vec![0; cap];
		self.stamp = vec![0; cap];
		self.closed = vec![0; cap];
		self.y = vec![0.0; cap];
		self.j = vec![0.0; cap];
		self.arc = vec![0; cap];
		self.cap = cap;
	}
	fn reached(&self, node: u32) -> bool {
		let n = node as usize;
		n < self.cap && self.stamp[n] == self.gen && self.closed[n] == self.gen
	}
	/// Node path from node back to the source (node first), with the arc ordinal reaching each (0 none).
	fn trace(&self, node: u32) -> (Vec<u32>, Vec<i32>) {
		let (mut out, mut arcs) = (Vec::new(), Vec::new());
		let mut node = node as i64;
		while node >= 0 {
			out.push(node as u32);
			arcs.push(self.arc[node as usize]);
			node = self.par[node as usize] as i64;
		}
		(out, arcs)
	}
}

/// An insertion-ordered map (JS Map's iteration order).
#[derive(Clone, Default)]
pub(crate) struct OMap<V> {
	keys: Vec<i64>,
	vals: Vec<V>,
	idx: FxHashMap<i64, usize>,
}
impl<V: Clone> OMap<V> {
	fn get(&self, k: i64) -> Option<&V> {
		self.idx.get(&k).map(|&i| &self.vals[i])
	}
	fn set(&mut self, k: i64, v: V) {
		match self.idx.get(&k) {
			Some(&i) => self.vals[i] = v,
			None => {
				self.idx.insert(k, self.keys.len());
				self.keys.push(k);
				self.vals.push(v);
			}
		}
	}
	fn iter(&self) -> impl Iterator<Item = (i64, &V)> {
		self.keys.iter().copied().zip(self.vals.iter())
	}
}

type Lab = [f64; 3];

struct TargetConn {
	merged: OMap<Lab>,
	ends: Vec<u32>,
}
impl TargetConn {
	/// Its heap bytes (with the cache key's), for the cache's bound.
	fn bytes(&self, key: &str) -> usize {
		let m = &self.merged;
		160 + key.len() + 8 * m.keys.capacity() + 24 * m.vals.capacity() + 17 * m.idx.capacity() + 4 * self.ends.capacity()
	}
}

/// Trees a thread keeps between calls (a call takes more while it runs: FindMany's source ends, its scratch).
const KEEP_TREES: usize = 8;
/// The target connections a thread keeps across calls (Lua: st.ends), by their heap bytes.
const ENDS_BYTES: usize = 48 << 20;
/// Clusters and graphs a call holds besides the shared cache (its own handles: evicted ones stay alive with it).
const CALL_CLUSTERS: usize = 24;

/// One thread's working memory: heaps, trees, the reach stamps and the target connections (Lua: st.ends).
#[derive(Default)]
pub(crate) struct Scratch {
	heap: Heap,
	heap2: Heap,
	/// The abstract search's lift landings and second layer (the lift layer's own heap).
	heap3: Heap,
	trees: Vec<Tree>,
	free: Vec<usize>,
	used: Vec<usize>,
	seen: Vec<u32>,
	queue: Vec<i32>,
	seen_gen: u32,
	ends: FxHashMap<String, Arc<TargetConn>>,
	ends_order: VecDeque<(String, usize)>,
	ends_bytes: usize,
	/// Lift landings' connections (Leffe's lift layer), by connection key.
	lift_conns: FxHashMap<String, Arc<TargetConn>>,
}

impl Scratch {
	/// Between calls (no tree in use): keep KEEP_TREES trees and modest heaps.
	pub(crate) fn trim(&mut self) {
		debug_assert!(self.used.is_empty());
		if self.trees.len() > KEEP_TREES {
			self.trees.truncate(KEEP_TREES);
			self.trees.shrink_to_fit();
			self.free.clear();
			self.free.extend(0..KEEP_TREES);
		}
		for h in [&mut self.heap, &mut self.heap2, &mut self.heap3] {
			if h.k.len() > 1 << 20 {
				*h = Heap::default();
			}
		}
		if self.lift_conns.len() > 4096 {
			self.lift_conns.clear();
		}
	}
}

/// The reader's lazy consistency checks, per (mode, cluster), shared by every thread.
#[derive(Default)]
pub(crate) struct Checks {
	motion: Mutex<FxHashMap<(bool, u64), Option<String>>>,
	joins: Mutex<FxHashMap<(bool, u64), Result<Arc<FxHashSet<u32>>, String>>>,
}

pub(crate) struct MapState {
	pub map: u32,
	pub meta: Arc<Meta>,
	pub c: i64,
	pub ny: i64,
	pub nx: i64,
	pub gx: i64,
	pub gy: i64,
	pub x0: f64,
	pub y0: f64,
	pub cs: f64,
	pub swim: f64,
	pub n: i64,
}

impl MapState {
	pub(crate) fn new(meta: Arc<Meta>) -> MapState {
		MapState { map: meta.map, c: meta.c, ny: meta.ny, nx: meta.nx, gx: meta.gx, gy: meta.gy, x0: meta.x0, y0: meta.y0, cs: meta.cs, swim: meta.swim, n: meta.c * meta.c, meta }
	}
	fn neighbor_cluster(&self, k: u32, dx: i64, dy: i64) -> R<u32> {
		let x = k as i64 / self.ny + dx;
		let y = k as i64 % self.ny + dy;
		if !(x >= 0 && y >= 0 && x < self.nx && y < self.ny) {
			return fail("cluster coordinate wrap");
		}
		Ok((x * self.ny + y) as u32)
	}
	/// The node on local cell lc for a link layer (0 base, i the ith floor up, -1 nearest height h) -> (node, gap).
	fn surface(&self, c: &Cluster, lc: i64, layer: i64, h: f64) -> (i64, f64) {
		let first = c.first_floor[lc as usize] as i64;
		if layer == 0 {
			return (if c.val[lc as usize] != 0 { lc } else { -1 }, f64::INFINITY);
		}
		if layer > 0 {
			if first < 0 {
				return (-1, f64::INFINITY);
			}
			let node = first + layer - 1;
			return (if (node as usize) < c.n && c.at_cell[node as usize] as i64 == lc { node } else { -1 }, f64::INFINITY);
		}
		let (mut best, mut gap) = (-1i64, f64::INFINITY);
		if c.val[lc as usize] != 0 {
			best = lc;
			gap = (c.z[lc as usize] as f64 - h).abs();
		}
		let mut node = first;
		while node >= 0 && (node as usize) < c.n && c.at_cell[node as usize] as i64 == lc {
			let d = (c.z[node as usize] as f64 - h).abs();
			if best < 0 || d < gap {
				best = node;
				gap = d;
			}
			node += 1;
		}
		(best, gap)
	}
	fn cell_of(&self, c: &Cluster, node: u32) -> i64 {
		let mut node = node as usize;
		if c.owner[node] >= 0 {
			node = c.owner[node] as usize;
		}
		if (node as i64) < self.n {
			node as i64
		} else {
			c.at_cell[node] as i64
		}
	}
	fn geometry(&self, c: &Cluster, k: u32, node: u32) -> [f64; 3] {
		let node = node as usize;
		let s = c.spec_idx[node];
		if s >= 0 {
			let s = s as usize;
			return [c.spec_x[s], c.spec_y[s], c.spec_z[s] as f64];
		}
		let cc = self.c;
		let lc = if (node as i64) < self.n { node as i64 } else { c.at_cell[node] as i64 };
		[self.x0 + ((k as i64 / self.ny * cc + lc / cc) as f64 + 0.5) * self.cs, self.y0 + ((k as i64 % self.ny * cc + lc % cc) as f64 + 0.5) * self.cs, c.z[node] as f64]
	}
	fn raw_xy(&self, k: u32, column: i64) -> (f64, f64) {
		let j = column / 256;
		let i = column % 256;
		(self.x0 + ((k as i64 / self.ny) as f64 + (255.5 - j as f64) / 256.0) * (1600.0 / 3.0), self.y0 + ((k as i64 % self.ny) as f64 + (255.5 - i as f64) / 256.0) * (1600.0 / 3.0))
	}
	fn locate(&self, x: f64, y: f64) -> Option<(u32, i64)> {
		let gx = ((x - self.x0) / self.cs).floor();
		let gy = ((y - self.y0) / self.cs).floor();
		if !(gx >= 0.0 && gy >= 0.0 && gx < self.gx as f64 && gy < self.gy as f64) {
			return None;
		}
		let (gx, gy) = (gx as i64, gy as i64);
		let c = self.c;
		Some(((gx / c * self.ny + gy / c) as u32, (gx % c) * c + gy % c))
	}
	fn chunk_of(&self, lc: i64) -> usize {
		let c = self.c;
		((lc / c * 16) / c * 16 + (lc % c * 16) / c) as usize
	}
	fn zone_at_cell(&self, k: u32, lc: i64) -> Option<i64> {
		let s = self.meta.zone.as_ref()?.get(k as usize)?.as_ref()?;
		let q = self.chunk_of(lc) as i64;
		let (mut i, mut n, mut value) = (0usize, -1i64, 0i64);
		while i < s.len() {
			let a = B64[s[i] as usize] as i64;
			if a < 48 {
				value = a * 64 + s.get(i + 1).map_or(-1, |&c| B64[c as usize] as i64);
				n += 1;
				i += 2;
			} else {
				n += a - 47;
				i += 1;
			}
			if n >= q {
				return if value != 0 { Some(value) } else { None };
			}
		}
		None
	}
	fn chunk_danger(&self, k: u32, danger: &Danger) -> Option<Box<[f64; 256]>> {
		let s = self.meta.zone.as_ref()?.get(k as usize)?.as_ref()?;
		let mut out = Box::new([1.0f64; 256]);
		let (mut any, mut n, mut value, mut i) = (false, 0usize, 1.0f64, 0usize);
		while i < s.len() {
			let a = B64[s[i] as usize] as i64;
			let reps;
			if a < 48 {
				let id = a * 64 + s.get(i + 1).map_or(-1, |&c| B64[c as usize] as i64);
				let m = danger.get(id);
				value = m.unwrap_or(1.0);
				any = any || m.is_some();
				reps = 1;
				i += 2;
			} else {
				reps = a - 47;
				i += 1;
			}
			for _ in 0..reps {
				if n < 256 {
					out[n] = value;
				}
				n += 1;
			}
		}
		if any {
			Some(out)
		} else {
			None
		}
	}
}

/// The danger table (multipliers > 1 by uiMapID), sorted by id.
#[derive(Clone, Debug)]
pub(crate) struct Danger(Vec<(i64, f64)>);
impl Danger {
	fn of(d: &[(u32, f64)]) -> Option<Danger> {
		let mut kept: Vec<(i64, f64)> = Vec::new();
		for &(id, m) in d {
			if m > 1.0 {
				match kept.iter_mut().find(|e| e.0 == id as i64) {
					Some(e) => e.1 = m,
					None => kept.push((id as i64, m)),
				}
			}
		}
		if kept.is_empty() {
			return None;
		}
		kept.sort_by_key(|e| e.0);
		Some(Danger(kept))
	}
	fn get(&self, id: i64) -> Option<f64> {
		self.0.binary_search_by_key(&id, |e| e.0).ok().map(|i| self.0[i].1)
	}
	fn tag(&self) -> String {
		self.0.iter().map(|(a, b)| format!("{a},{b}")).collect::<Vec<_>>().join(",")
	}
}

pub(crate) struct Mult {
	danger: Option<Danger>,
	style: Style,
	profile: Option<Faction>,
	/// 0 Alliance, 1 Horde, 2 none.
	slot: usize,
	m: [f64; 48],
}

/// P's per-entry arrays (Path.lua's refinement path).
#[derive(Default, Clone)]
struct Pts {
	x: Vec<f64>,
	y: Vec<f64>,
	w: Vec<f64>,
	k: Vec<u32>,
	n: Vec<u32>,
	wx: Vec<f64>,
	wy: Vec<f64>,
	wz: Vec<f64>,
	hard: Vec<bool>,
	/// For legs: the motion arc an entry belongs to (source cluster, arc index), path vertices included.
	arc: Vec<Option<(u32, u32)>>,
}
impl Pts {
	fn len(&self) -> usize {
		self.x.len()
	}
	fn truncate(&mut self, n: usize) {
		self.x.truncate(n);
		self.y.truncate(n);
		self.w.truncate(n);
		self.k.truncate(n);
		self.n.truncate(n);
		self.wx.truncate(n);
		self.wy.truncate(n);
		self.wz.truncate(n);
		self.hard.truncate(n);
		self.arc.truncate(n);
	}
}

struct End {
	node: u32,
	edges: OMap<Lab>,
	tree: usize,
}

struct Side {
	merged: OMap<Lab>,
	via: FxHashMap<i64, usize>,
	ends: Vec<End>,
}

struct Refine {
	p: Pts,
	events: Vec<Event>,
	seen: FxHashMap<i64, usize>,
}

/// One call's routing context (the JS Router over one map, its per-call state).
pub(crate) struct Run<'a> {
	store: &'a Store,
	checks: &'a Checks,
	pub st: MapState,
	validate: bool,
	tolerant: bool,
	grids: FxHashMap<u32, Option<Arc<Cluster>>>,
	graphs: FxHashMap<u32, Arc<Graph>>,
	sc: &'a mut Scratch,
	pub expansions: u64,
	/// The map's lift cars (Leffe's lift layer).
	lifts: Option<Arc<MapLifts>>,
}

/// A call's lifts, per landing (2 × car + end): where it stands (cluster, node, height; the node its connection
/// settled on), the ride from it to the other landing (None: not priced), whether its car is a lift-separated city's
/// and its connection from its cluster's entrances (None: it does not join the graph).
struct LiftCx {
	at: Vec<(u32, u32, f64)>,
	ride: Vec<Option<Lab>>,
	city: Vec<bool>,
	inn: Vec<Option<Arc<TargetConn>>>,
	group: Option<&'static Group>,
}
impl LiftCx {
	/// Entrance id -> the landings it walks to (landing, label), in landing order.
	fn links(&self) -> FxHashMap<i64, Vec<(usize, Lab)>> {
		let mut out: FxHashMap<i64, Vec<(usize, Lab)>> = FxHashMap::default();
		for (e, c) in self.inn.iter().enumerate() {
			for (id, lab) in c.iter().flat_map(|c| c.merged.iter()) {
				out.entry(id).or_default().push((e, *lab));
			}
		}
		out
	}
}

fn step_safe(cs: f64, dx: f64, dy: f64, za: f64, zb: f64) -> bool {
	if za.is_nan() || zb.is_nan() || (dx == 0.0 && dy == 0.0) {
		return false;
	}
	(zb - za).abs() <= cs * (dx * dx + dy * dy).sqrt() * WALK_TAN + SLOPE_EPS
}

impl<'a> Run<'a> {
	pub(crate) fn new(store: &'a Store, checks: &'a Checks, meta: Arc<Meta>, mode: Validate, sc: &'a mut Scratch, lifts: Option<Arc<MapLifts>>) -> Run<'a> {
		Run {
			store,
			checks,
			st: MapState::new(meta),
			validate: mode != Validate::Off,
			tolerant: mode == Validate::Tolerant,
			grids: FxHashMap::default(),
			graphs: FxHashMap::default(),
			sc,
			expansions: 0,
			lifts,
		}
	}

	/// Return the call's trees to the pool.
	pub(crate) fn finish(&mut self) {
		let sc = &mut *self.sc;
		sc.free.append(&mut sc.used);
	}

	fn grid(&mut self, k: u32) -> R<Option<Arc<Cluster>>> {
		if let Some(c) = self.grids.get(&k) {
			return Ok(c.clone());
		}
		if self.grids.len() >= CALL_CLUSTERS {
			self.grids.clear();
		}
		let c = self.store.cluster(&self.st.meta, k)?;
		self.grids.insert(k, c.clone());
		Ok(c)
	}
	/// A cluster the walk needs: an error when the maps have none there.
	fn grid_req(&mut self, k: u32) -> R<Arc<Cluster>> {
		self.grid(k)?.ok_or_else(|| missing_cluster(k))
	}
	fn graph(&mut self, k: u32) -> R<Arc<Graph>> {
		if let Some(g) = self.graphs.get(&k) {
			return Ok(g.clone());
		}
		if self.graphs.len() >= CALL_CLUSTERS {
			self.graphs.clear();
		}
		let g = self.store.graph(&self.st.meta, k)?;
		self.graphs.insert(k, g.clone());
		Ok(g)
	}
	fn entrance_node(&mut self, id: i64) -> R<u32> {
		let k = (id / STRIDE) as u32;
		let g = self.graph(k)?;
		let row = (id % STRIDE) as usize;
		if row >= g.rows {
			return fail("invalid entrance index");
		}
		Ok(g.row_node[row])
	}
	fn tree(&mut self) -> usize {
		let t = match self.sc.free.pop() {
			Some(t) => t,
			None => {
				self.sc.trees.push(Tree::default());
				self.sc.trees.len() - 1
			}
		};
		self.sc.used.push(t);
		t
	}

	// ---- PathGrid.lua over the grid ----

	fn standing(&mut self, k: u32, lc: i64, h: Option<f64>) -> R<(i64, f64)> {
		let Some(c) = self.grid(k)? else { return Ok((-1, 0.0)) };
		match h {
			None => Ok((if c.val[lc as usize] != 0 { lc } else { -1 }, 0.0)),
			Some(h) => Ok(self.st.surface(&c, lc, -1, h)),
		}
	}
	fn snap(&mut self, k: u32, lc: i64, x: f64, y: f64, h: Option<f64>) -> R<i64> {
		let (cc, cs) = (self.st.c, self.st.cs);
		let (lx, ly) = (lc / cc, lc % cc);
		let cx = self.st.x0 + ((k as i64 / self.st.ny * cc + lx) as f64 + 0.5) * cs;
		let cy = self.st.y0 + ((k as i64 % self.st.ny * cc + ly) as f64 + 0.5) * cs;
		let (mut best, mut best_cost, mut any, mut any_d) = (-1i64, None::<f64>, -1i64, None::<f64>);
		for r in 0..=SNAP {
			if best >= 0 && (r - 1) as f64 * cs > best_cost.unwrap() {
				break;
			}
			for dx in -r..=r {
				for dy in -r..=r {
					let (nx, ny) = (lx + dx, ly + dy);
					if (dx == r || dx == -r || dy == r || dy == -r) && nx >= 0 && ny >= 0 && nx < cc && ny < cc {
						let (n, gap) = self.standing(k, nx * cc + ny, h)?;
						if n >= 0 {
							let d = if r == 0 {
								0.0
							} else {
								let a = cx + dx as f64 * cs - x;
								let b = cy + dy as f64 * cs - y;
								(a * a + b * b).sqrt()
							};
							if gap <= ZTOL && (best_cost.is_none() || d + 2.0 * gap < best_cost.unwrap()) {
								best = n;
								best_cost = Some(d + 2.0 * gap);
							}
							if any_d.is_none() || d < any_d.unwrap() {
								any = n;
								any_d = Some(d);
							}
						}
					}
				}
			}
		}
		Ok(if best >= 0 { best } else { any })
	}
	/// The grid cluster of global cell (gx, gy) and its local cell (no bounds check).
	fn at_global(&self, gx: i64, gy: i64) -> (u32, usize) {
		let c = self.st.c;
		((gx.div_euclid(c) * self.st.ny + gy.div_euclid(c)) as u32, (gx.rem_euclid(c) * c + gy.rem_euclid(c)) as usize)
	}
	fn in_bounds(&self, gx: i64, gy: i64) -> bool {
		gx >= 0 && gy >= 0 && gx < self.st.gx && gy < self.st.gy
	}
	fn value(&mut self, gx: i64, gy: i64) -> R<u8> {
		if !self.in_bounds(gx, gy) {
			return Ok(0);
		}
		let (k, lc) = self.at_global(gx, gy);
		Ok(self.grid(k)?.map_or(0, |c| c.val[lc]))
	}
	fn base_height(&mut self, gx: i64, gy: i64) -> R<f64> {
		if !self.in_bounds(gx, gy) {
			return Ok(f64::NAN);
		}
		let (k, lc) = self.at_global(gx, gy);
		Ok(self.grid(k)?.map_or(f64::NAN, |c| c.z[lc] as f64))
	}
	fn rendered_step_safe(&mut self, gx: i64, gy: i64, dx: i64, dy: i64, za: Option<f64>, zb: Option<f64>) -> R<bool> {
		let za = match za {
			Some(z) => z,
			None => self.base_height(gx, gy)?,
		};
		let zb = match zb {
			Some(z) => z,
			None => self.base_height(gx + dx, gy + dy)?,
		};
		Ok(step_safe(self.st.cs, dx as f64, dy as f64, za, zb))
	}
	fn ordinary_base(&mut self, gx: i64, gy: i64) -> R<bool> {
		let (k, lc) = self.at_global(gx, gy);
		Ok(self.grid(k)?.is_some_and(|c| c.over_kind[lc] != 0))
	}
	fn move_flags(&mut self, ax: i64, ay: i64) -> R<u8> {
		let (k, lc) = self.at_global(ax, ay);
		Ok(self.grid(k)?.map_or(0, |c| c.moves[lc]) >> 4)
	}
	fn step_open(&mut self, gx: i64, gy: i64, dx: i64, dy: i64, water: bool) -> R<bool> {
		let (mut ax, mut ay) = (gx, gy);
		if dx < 0 || dy < 0 {
			ax = gx + dx;
			ay = gy + dy;
		}
		let a = self.value(ax, ay)?;
		let b = self.value(ax + (dx != 0) as i64, ay + (dy != 0) as i64)?;
		if a == 0 || b == 0 || (!water && (a == 2 || b == 2)) {
			return Ok(false);
		}
		if !self.ordinary_base(gx, gy)? || !self.ordinary_base(gx + dx, gy + dy)? {
			return Ok(false);
		}
		if !self.rendered_step_safe(gx, gy, dx, dy, None, None)? {
			return Ok(false);
		}
		let f = self.move_flags(ax, ay)?;
		Ok(if dx != 0 { f % 2 == 0 } else { f % 4 < 2 })
	}
	fn diagonal_open(&mut self, gx: i64, gy: i64, sx: i64, sy: i64, water: bool) -> R<bool> {
		let b = self.value(gx + sx, gy + sy)?;
		if b == 0 || (!water && b == 2) {
			return Ok(false);
		}
		if !self.rendered_step_safe(gx, gy, sx, sy, None, None)? {
			return Ok(false);
		}
		if (self.step_open(gx, gy, sx, 0, water)? && self.step_open(gx + sx, gy, 0, sy, water)?) || (self.step_open(gx, gy, 0, sy, water)? && self.step_open(gx, gy + sy, sx, 0, water)?) {
			return Ok(true);
		}
		let (mut ax, mut ay, mut up) = (gx, gy, sy > 0);
		if sx < 0 {
			ax = gx + sx;
			ay = gy + sy;
			up = sy < 0;
		}
		let a = self.value(ax, ay)?;
		if a == 0 || (!water && a == 2) {
			return Ok(false);
		}
		let f = self.move_flags(ax, ay)?;
		Ok(if up { f % 8 >= 4 } else { f >= 8 })
	}

	/// PathGrid.lua neighbour -> (tk, node) or None. gx, gy f64: the JS sight may pass a special node's fractional
	/// coordinates, where neighbour returns at its first check.
	fn neighbour(&mut self, k: u32, node: u32, gx: f64, gy: f64, dx: i64, dy: i64, water: bool, want: i64) -> R<Option<(u32, u32)>> {
		let c = self.grid(k)?.ok_or_else(|| missing_cluster(k))?;
		let nu = node as usize;
		if c.owner[nu] >= 0 || c.over_kind[nu] == 0 {
			return Ok(None);
		}
		if gx.fract() != 0.0 || gy.fract() != 0.0 {
			// Unreached: only special nodes carry fractional coordinates.
			return Ok(None);
		}
		let (gx, gy) = (gx as i64, gy as i64);
		let (tx, ty) = (gx + dx, gy + dy);
		if !self.in_bounds(tx, ty) {
			return Ok(None);
		}
		let cc = self.st.c;
		let n = self.st.n;
		let (tk, tlc) = self.at_global(tx, ty);
		let tlc = tlc as i64;
		if (node as i64) < n && (want < 0 || want == tlc) {
			let open;
			let mut validated = false;
			let ni = node as i64;
			let same = tk == k;
			let vv = |i: i64| c.val[i as usize];
			if same && (water || (vv(ni) != 2 && vv(tlc) != 2 && (dx == 0 || dy == 0 || (vv(ni + dx * cc) != 2 && vv(ni + dy) != 2)))) {
				let m = &c.moves;
				let at = |pos: bool| m[if pos { nu } else { tlc as usize }];
				open = if dy == 0 {
					at(dx > 0) % 2 == 1
				} else if dx == 0 {
					at(dy > 0) % 4 >= 2
				} else if dx == dy {
					at(dx > 0) % 8 >= 4
				} else {
					at(dx > 0) % 16 >= 8
				};
			} else if dx == 0 || dy == 0 {
				open = self.step_open(gx, gy, dx, dy, water)?;
				validated = true;
			} else {
				open = self.diagonal_open(gx, gy, dx, dy, water)?;
				validated = true;
			}
			if open {
				if !self.ordinary_base(tx, ty)? {
					return Ok(None);
				}
				if !validated {
					let t = self.grid(tk)?.ok_or_else(|| missing_cluster(tk))?;
					if !self.rendered_step_safe(gx, gy, dx, dy, Some(c.z[nu] as f64), Some(t.z[tlc as usize] as f64))? {
						return Ok(None);
					}
				}
				return Ok(Some((tk, tlc as u32)));
			}
		}
		let (lo, hi) = (c.link_off[nu] as usize, c.link_off[nu + 1] as usize);
		if lo == hi {
			return Ok(None);
		}
		let here = c.val[nu];
		let h = c.z[nu] as f64;
		let d = direction(dx, dy) as u8;
		for e in lo..hi {
			let l = c.link_val[e];
			if l % 8 == d {
				let t = self.grid(tk)?.ok_or_else(|| missing_cluster(tk))?;
				let (v, _) = self.st.surface(&t, tlc, (l / 8) as i64 - 1, h);
				if v >= 0 {
					let vu = v as usize;
					if (want < 0 || v == want)
						&& t.owner[vu] < 0 && t.over_kind[vu] != 0
						&& (water || (here != 2 && t.val[vu] != 2))
						&& self.rendered_step_safe(gx, gy, dx, dy, Some(h), Some(t.z[vu] as f64))?
					{
						return Ok(Some((tk, v as u32)));
					}
				}
				// Tolerant: a nearest-height link reaches the floor the graph edge names even where an override moved
				// another surface of that cell nearer.
				if self.tolerant && want >= 0 && v != want && l / 8 == 0 {
					let wu = want as usize;
					let on_cell = if want == tlc { t.val[wu] != 0 } else { wu < t.n && t.at_cell[wu] as i64 == tlc };
					if on_cell && t.owner[wu] < 0 && t.over_kind[wu] != 0 && (water || (here != 2 && t.val[wu] != 2)) && self.rendered_step_safe(gx, gy, dx, dy, Some(h), Some(t.z[wu] as f64))? {
						return Ok(Some((tk, want as u32)));
					}
				}
			}
		}
		Ok(None)
	}
	fn class_of(&mut self, k: u32, node: u32) -> R<i64> {
		Ok(self.grid(k)?.map_or(0, |c| c.cls[node as usize] as i64))
	}

	// ---- Path.lua search ----

	/// Grid Dijkstra inside cluster k (format 4: no heuristic). goal -1 for none.
	fn search(&mut self, k: u32, swim: f64, mult: &Mult, source: u32, ti: usize, goal: i64, targets: Option<&FxHashSet<u32>>, left: usize, reverse: bool, zero_special: bool) -> R<bool> {
		if self.validate {
			self.validate_motion(k)?;
		}
		let c = self.grid_req(k)?;
		let dz = match &mult.danger {
			Some(d) => self.st.chunk_danger(k, d),
			None => None,
		};
		let st = &self.st;
		let Scratch { heap, trees, .. } = &mut *self.sc;
		let tree = &mut trees[ti];
		let (exp, found) = search_in(st, &c, k, swim, mult, dz.as_deref(), source, tree, heap, goal, targets, left as i64, reverse, zero_special);
		self.expansions += exp;
		Ok(found)
	}

	fn endpoint(&mut self, swim: f64, mult: &Mult, ti: usize, k: u32, node: u32, reverse: bool) -> R<()> {
		let g = self.graph(k)?;
		let targets: FxHashSet<u32> = g.row_node.iter().copied().collect();
		self.search(k, swim, mult, node, ti, -1, Some(&targets), targets.len(), reverse, false)?;
		Ok(())
	}
	fn connected(&mut self, ti: usize, k: u32) -> R<bool> {
		let g = self.graph(k)?;
		let t = &self.sc.trees[ti];
		Ok(g.row_node.iter().any(|&e| t.reached(e)))
	}
	fn settle(&mut self, swim: f64, mult: &Mult, ti: usize, k: u32, node: u32, reverse: bool) -> R<(u32, usize)> {
		let cc = self.st.c;
		self.endpoint(swim, mult, ti, k, node, reverse)?;
		if self.connected(ti, k)? {
			return Ok((node, ti));
		}
		let mut tries = 0;
		let mut retry: Option<usize> = None;
		let c = self.grid_req(k)?;
		let h = c.z[node as usize] as f64;
		let cell = self.st.cell_of(&c, node);
		let (lx, ly) = (cell / cc, cell % cc);
		for r in 1..=SNAP {
			for dx in -r..=r {
				for dy in -r..=r {
					if tries >= RETRIES {
						return Ok((node, ti));
					}
					let (x, y) = (lx + dx, ly + dy);
					let ring = dx == r || dx == -r || dy == r || dy == -r;
					if ring && x >= 0 && y >= 0 && x < cc && y < cc {
						let (near, _) = self.standing(k, x * cc + y, Some(h))?;
						if near >= 0 {
							let rise = c.z[near as usize] as f64 - h;
							if rise <= ZTOL && rise >= -DROP && !self.sc.trees[retry.unwrap_or(ti)].reached(near as u32) {
								tries += 1;
								let rt = match retry {
									Some(t) => t,
									None => {
										let t = self.tree();
										retry = Some(t);
										t
									}
								};
								self.endpoint(swim, mult, rt, k, near as u32, reverse)?;
								if self.connected(rt, k)? {
									return Ok((near as u32, rt));
								}
							}
						}
					}
				}
			}
		}
		Ok((node, ti))
	}
	fn connections(&mut self, ti: usize, k: u32) -> R<OMap<Lab>> {
		let g = self.graph(k)?;
		let mut edges = OMap::default();
		let t = &self.sc.trees[ti];
		for (i, &e) in g.row_node.iter().enumerate() {
			if t.reached(e) {
				let e = e as usize;
				edges.set(k as i64 * STRIDE + i as i64, [t.g[e], t.y[e], t.j[e]]);
			}
		}
		Ok(edges)
	}
	/// -> (cluster, node, why) with node -1 when none.
	fn point_node(&mut self, p: &P) -> R<(u32, i64, Option<&'static str>)> {
		let Some((k, cell)) = self.st.locate(p.x, p.y) else { return Ok((0, -1, Some("outside"))) };
		let node = self.snap(k, cell, p.x, p.y, p.z)?;
		Ok((k, node, if node < 0 { Some("offmesh") } else { None }))
	}
	fn connect(&mut self, swim: f64, mult: &Mult, k: u32, node: u32, reverse: bool) -> R<End> {
		let ti = self.tree();
		let (node, tree) = self.settle(swim, mult, ti, k, node, reverse)?;
		Ok(End { node, edges: self.connections(tree, k)?, tree })
	}
	fn connect_point(&mut self, swim: f64, mult: &Mult, k: u32, node: u32, h: Option<f64>, reverse: bool) -> R<Side> {
		let mut nodes = vec![node];
		if h.is_none() {
			let c = self.grid_req(k)?;
			let cc = self.st.c;
			let cell = self.st.cell_of(&c, node);
			let (lx, ly) = (cell / cc, cell % cc);
			let consider = |nodes: &mut Vec<u32>, n: usize, r: i64| {
				if r > 0 && c.val[n] == 2 {
					return;
				}
				for &m in nodes.iter() {
					if (c.z[n] as f64 - c.z[m as usize] as f64).abs() <= ZTOL {
						return;
					}
				}
				nodes.push(n as u32);
			};
			for r in 0..=1i64 {
				for dx in -r..=r {
					for dy in -r..=r {
						let (x, y) = (lx + dx, ly + dy);
						if (dx == r || dx == -r || dy == r || dy == -r) && x >= 0 && y >= 0 && x < cc && y < cc {
							let ccell = (x * cc + y) as usize;
							if c.val[ccell] != 0 {
								consider(&mut nodes, ccell, r);
							}
							let mut n = c.first_floor[ccell] as i64;
							while n >= 0 && (n as usize) < c.n && c.at_cell[n as usize] as usize == ccell {
								consider(&mut nodes, n as usize, r);
								n += 1;
							}
						}
					}
				}
			}
		}
		let mut side = Side { merged: OMap::default(), via: FxHashMap::default(), ends: Vec::new() };
		for start in nodes {
			let end = self.connect(swim, mult, k, start, reverse)?;
			let ei = side.ends.len();
			for (id, lab) in end.edges.iter() {
				let better = match side.merged.get(id) {
					None => true,
					Some(prior) => lab[0] < prior[0],
				};
				if better {
					side.merged.set(id, *lab);
					side.via.insert(id, ei);
				}
			}
			side.ends.push(end);
		}
		Ok(side)
	}

	fn weights(&self, o: &Opts) -> Mult {
		let profile = o.faction();
		let danger = if self.st.meta.zone.is_some() { Danger::of(&o.danger) } else { None };
		let slot = match profile {
			Some(Faction::Alliance) => 0,
			Some(Faction::Horde) => 1,
			None => 2,
		};
		let mut m = [0.0; 48];
		for (c, v) in m.iter_mut().enumerate() {
			*v = cost_mult(c as i64, profile, o.style);
		}
		Mult { danger, style: o.style, profile, slot, m }
	}

	fn edge_danger_at(&mut self, danger: &Danger, memo: &mut FxHashMap<i64, f64>, id: i64) -> R<f64> {
		if let Some(&m) = memo.get(&id) {
			return Ok(m);
		}
		let k = (id / STRIDE) as u32;
		let c = self.grid_req(k)?;
		let e = self.entrance_node(id)?;
		let z = self.st.zone_at_cell(k, self.st.cell_of(&c, e));
		let m = z.and_then(|z| danger.get(z)).unwrap_or(1.0);
		memo.insert(id, m);
		Ok(m)
	}
	fn edged(&mut self, danger: Option<&Danger>, memo: &mut FxHashMap<i64, f64>, a: i64, b: i64) -> R<Option<f64>> {
		let Some(d) = danger else { return Ok(None) };
		let ma = self.edge_danger_at(d, memo, a)?;
		let mb = self.edge_danger_at(d, memo, b)?;
		Ok(Some(if ma > mb { ma } else { mb }))
	}

	// ---- route ----

	pub(crate) fn route(&mut self, from: &P, to: &P, o: &Opts) -> Route {
		self.expansions = 0;
		let r = self.run(from, to, o);
		self.finish();
		match r {
			Ok(r) => r,
			Err(e) => Route::failed(format!("error: {e}")),
		}
	}

	fn run(&mut self, from: &P, to: &P, o: &Opts) -> R<Route> {
		let swim = if o.water_walking { 1.0 } else { self.st.swim };
		let mult = self.weights(o);
		let slot = mult.slot;
		let danger = mult.danger.clone();
		let mut memo = FxHashMap::default();
		let (sk, sc, r1) = self.point_node(from)?;
		if sc < 0 {
			return Ok(Route::failed(r1.unwrap().to_string()));
		}
		let (gk, gc, r2) = self.point_node(to)?;
		if gc < 0 {
			return Ok(Route::failed(r2.unwrap().to_string()));
		}
		let (sc, gc) = (sc as u32, gc as u32);
		let s_tree = self.tree();
		let g_tree = self.tree();
		let r_tree = self.tree();
		let src = self.connect_point(swim, &mult, sk, sc, from.z, false)?;
		let dst = self.connect_point(swim, &mult, gk, gc, to.z, true)?;
		// Leffe's lift layer: the map's landings, and whether the walk crosses a lift-separated city's floors (then only
		// a ride on one of its lifts reaches the goal).
		let lx = self.lift_cx(swim, &mult);
		let must = match lx.as_ref().and_then(|l| l.group) {
			Some(g) => match (self.side(g, from), self.side(g, to)) {
				(Some(a), Some(b)) => a != b,
				_ => false,
			},
			None => false,
		};
		let mut src_lifts = Vec::new();
		if let Some(l) = &lx {
			for e in 0..l.at.len() {
				if l.at[e].0 == sk && l.inn[e].is_some() {
					if let Ok(Some(w)) = self.reach_from_side(swim, &mult, &src, sk, l.at[e].1, r_tree) {
						src_lifts.push((e, w));
					}
				}
			}
		}
		let links = lx.as_ref().map(|l| l.links()).unwrap_or_default();
		let mut direct: Option<f64> = None;
		let (mut direct_yards, mut direct_jumps, mut direct_from, mut direct_to) = (0.0, 0.0, 0u32, 0u32);
		if sk == gk && !must {
			for a in 0..src.ends.len() {
				for b in 0..dst.ends.len() {
					let (an, bn) = (src.ends[a].node, dst.ends[b].node);
					if self.search(sk, swim, &mult, an, s_tree, bn as i64, None, 0, false, false)? {
						let t = &self.sc.trees[s_tree];
						let gb = t.g[bn as usize];
						if direct.is_none() || gb < direct.unwrap() {
							direct = Some(gb);
							direct_yards = t.y[bn as usize];
							direct_from = an;
							direct_to = bn;
							direct_jumps = t.j[bn as usize];
						}
					}
				}
			}
		}
		let source = &src.merged;
		let target = &dst.merged;
		let mut comps = FxHashSet::default();
		for (id, _) in source.iter() {
			let g = self.graph((id / STRIDE) as u32)?;
			comps.insert(g.row_comp[(id % STRIDE) as usize]);
		}
		let mut shared = false;
		for (id, _) in target.iter() {
			let g = self.graph((id / STRIDE) as u32)?;
			shared = shared || comps.contains(&g.row_comp[(id % STRIDE) as usize]);
		}
		if direct.is_none() && !shared && lx.is_none() {
			return Ok(Route::failed("unreachable".into()));
		}

		// Abstract Dijkstra from START to GOAL through the entrance graph (and the lift layer's landings and layer).
		#[derive(Clone, Copy)]
		struct Lb {
			g: f64,
			y: f64,
			par: i64,
			j: f64,
			edge: i64,
			/// From START to a landing: the start's end; from a landing to GOAL: the goal's.
			end: usize,
		}
		let mut lab: FxHashMap<i64, Lb> = FxHashMap::default();
		let mut aclosed: FxHashSet<i64> = FxHashSet::default();
		self.sc.heap.clear();
		self.sc.heap3.clear();
		fn relax(lab: &mut FxHashMap<i64, Lb>, heap: &mut Heap, v: i64, l: Lb) {
			let better = match lab.get(&v) {
				None => true,
				Some(p) => l.g < p.g,
			};
			if better {
				lab.insert(v, l);
				heap.push(l.g, v);
			}
		}
		for (id, l) in source.iter() {
			relax(&mut lab, &mut self.sc.heap, id, Lb { g: l[0], y: l[1], par: START, j: l[2], edge: -1, end: 0 });
		}
		if let Some(d) = direct {
			relax(&mut lab, &mut self.sc.heap, GOAL, Lb { g: d, y: direct_yards, par: START, j: direct_jumps, edge: -1, end: 0 });
		}
		for (e, (a, w)) in src_lifts {
			relax(&mut lab, &mut self.sc.heap3, LIFT + e as i64, Lb { g: w[0], y: w[1], par: START, j: w[2], edge: -1, end: a });
		}
		let mut found = false;
		loop {
			// The lift layer's heap only when its top is strictly cheaper.
			let lifted = self.sc.heap3.n > 0 && (self.sc.heap.n == 0 || self.sc.heap3.k[1] < self.sc.heap.k[1]);
			let u = if lifted {
				self.sc.heap3.pop()
			} else if self.sc.heap.n > 0 {
				self.sc.heap.pop()
			} else {
				break;
			};
			if !aclosed.insert(u) {
				continue;
			}
			self.expansions += 1;
			if u == GOAL {
				found = true;
				break;
			}
			let lu = lab[&u];
			let (b, layer) = unlayer(u);
			let at = |g: f64, y: f64, j: f64, edge: i64, end: usize| Lb { g: lu.g + g, y: lu.y + y, par: u, j: lu.j + j, edge, end };
			if b >= LIFT {
				let Some(l) = &lx else { continue };
				let e = (b - LIFT) as usize;
				if let Some(r) = l.ride[e] {
					let to_layer = if must && l.city[e] { LAYER } else { layer };
					relax(&mut lab, &mut self.sc.heap3, LIFT + (e ^ 1) as i64 + to_layer, at(r[0], r[1], r[2], RIDE_EDGE, 0));
				}
				if let Ok(out) = self.aside(|r| r.landing_out(swim, &mult, l, e)) {
					for (id, w) in out.merged.iter() {
						let heap = if layer == 0 { &mut self.sc.heap } else { &mut self.sc.heap3 };
						relax(&mut lab, heap, id + layer, at(w[0], w[1], w[2], -1, 0));
					}
				}
				// The goal and the other landings of its cluster, walked to straight from it.
				let (k, node, _) = l.at[e];
				let mut goals: Vec<(i64, u32, usize)> = Vec::new();
				if k == gk && (layer != 0 || !must) {
					goals.extend(dst.ends.iter().enumerate().map(|(i, d)| (GOAL, d.node, i)));
				}
				for (f, &(fk, fnode, _)) in l.at.iter().enumerate() {
					if f != e && fk == k && l.inn[f].is_some() {
						goals.push((LIFT + f as i64 + layer, fnode, 0));
					}
				}
				if !goals.is_empty() {
					let nodes: Vec<u32> = goals.iter().map(|g| g.1).collect();
					if let Ok(reached) = self.aside(|r| r.reach_nodes(swim, &mult, k, node, &nodes, r_tree)) {
						for (gi, w) in reached {
							let (id, _, end) = goals[gi];
							let heap = if id == GOAL && layer == 0 { &mut self.sc.heap } else { &mut self.sc.heap3 };
							relax(&mut lab, heap, id, at(w[0], w[1], w[2], -1, end));
						}
					}
				}
				continue;
			}
			if let Some(t) = target.get(b) {
				if layer != 0 {
					relax(&mut lab, &mut self.sc.heap3, GOAL, at(t[0], t[1], t[2], -1, 0));
				} else if !must {
					relax(&mut lab, &mut self.sc.heap, GOAL, at(t[0], t[1], t[2], -1, 0));
				}
			}
			for &(e, w) in links.get(&b).into_iter().flatten() {
				relax(&mut lab, &mut self.sc.heap3, LIFT + e as i64 + layer, at(w[0], w[1], w[2], -1, 0));
			}
			let k = (b / STRIDE) as u32;
			let row = (b % STRIDE) as usize;
			let bad = if self.validate { Some(self.validate_joins(k)?) } else { None };
			let g = self.graph(k)?;
			for e in g.row_out[row] as usize..g.row_out[row + 1] as usize {
				let q = self.st.neighbor_cluster(k, g.e_dx[e] as i64, g.e_dy[e] as i64)?;
				let v = q as i64 * STRIDE + g.e_ent[e] as i64;
				if !aclosed.contains(&(v + layer)) && !bad.as_ref().is_some_and(|b| b.contains(&((3 * e + slot) as u32))) {
					let cost = g.e_cost[3 * e + slot] as f64;
					let gv = match self.edged(danger.as_ref(), &mut memo, b, v)? {
						Some(m) => lu.g + cost * m,
						None => lu.g + cost,
					};
					let heap = if layer == 0 { &mut self.sc.heap } else { &mut self.sc.heap3 };
					relax(&mut lab, heap, v + layer, Lb { g: gv, y: lu.y + g.e_yards[3 * e + slot] as f64, par: u, j: lu.j + g.e_jumps[3 * e + slot] as f64, edge: e as i64, end: 0 });
				}
			}
		}
		if !found {
			return Ok(Route::failed("unreachable".into()));
		}
		let gl = lab[&GOAL];
		let (cost, jumps) = (gl.g, gl.j);
		let mut hops = vec![GOAL];
		while *hops.last().unwrap() != START {
			hops.push(lab[hops.last().unwrap()].par);
		}

		// Refinement.
		let mut rf = Refine { p: Pts::default(), events: Vec::new(), seen: FxHashMap::default() };
		let mut lifted = false;
		for i in (1..hops.len()).rev() {
			let lb = lab[&hops[i - 1]];
			let (a, b) = (unlayer(hops[i]).0, unlayer(hops[i - 1]).0);
			if a >= LIFT || b >= LIFT {
				// A lift's way on, its ride or its way off.
				lifted = true;
				let l = lx.as_ref().ok_or("a lift hop without lifts")?;
				let at = |id: i64| l.at[(id - LIFT) as usize];
				if a >= LIFT && b >= LIFT && lb.edge == RIDE_EDGE {
					let (k, node, _) = at(b);
					self.add_ride(&mut rf, k, node, ((b - LIFT) / 2) as u32)?;
					continue;
				}
				let (k, from_node, to_node) = if a == START {
					let (k, n, _) = at(b);
					(k, src.ends[lb.end].node, n)
				} else if b == GOAL {
					let (k, n, _) = at(a);
					(k, n, dst.ends[lb.end].node)
				} else if a >= LIFT && b >= LIFT {
					let (k, n, _) = at(a);
					(k, n, at(b).1)
				} else if a >= LIFT {
					let (k, n, _) = at(a);
					(k, n, self.entrance_node(b)?)
				} else {
					let (k, n, _) = at(b);
					(k, self.entrance_node(a)?, n)
				};
				self.walk_trace(&mut rf, swim, &mult, k, from_node, to_node, r_tree)?;
			} else if a == START && b == GOAL {
				self.search(sk, swim, &mult, direct_from, s_tree, direct_to as i64, None, 0, false, false)?;
				let (nodes, arcs) = self.sc.trees[s_tree].trace(direct_to);
				self.add_all(&mut rf, sk, &nodes, &arcs, nodes.len() as i64 - 1, 0, -1)?;
			} else if a == START {
				let entry = &src.ends[src.via[&b]];
				let finish = self.entrance_node(b)?;
				let (nodes, arcs) = self.endpoint_leg(swim, &mult, sk, entry.node, entry.tree, finish, s_tree, false)?;
				self.add_all(&mut rf, sk, &nodes, &arcs, nodes.len() as i64 - 1, 0, -1)?;
			} else if b == GOAL {
				let entry = &dst.ends[dst.via[&a]];
				let finish = self.entrance_node(a)?;
				let (nodes, arcs) = self.endpoint_leg(swim, &mult, gk, entry.node, entry.tree, finish, g_tree, true)?;
				self.add_all(&mut rf, gk, &nodes, &arcs, 0, nodes.len() as i64 - 1, 1)?;
			} else {
				let (fnode, tnode) = (self.entrance_node(a)?, self.entrance_node(b)?);
				self.replay_hop(&mut rf, swim, &mult, slot, r_tree, a, b, fnode, tnode, lb.edge)?;
			}
		}
		let mut count = 0.0;
		for e in &rf.events {
			count += e.kind as f64;
		}
		// A lift's ways on and off are searched again forward (their labels came from the landings' connections, which
		// may break a tie between equal ways differently): there the drawn way's jumps are the label's.
		if count != jumps && !lifted {
			return fail("selected event count disagrees with path label");
		}
		let mut keep = self.smooth_hard(&rf.p, mult.profile, o.style, danger.as_ref())?;
		if keep.len() == 1 {
			keep.push(keep[0]);
		}
		let mut route = self.draw(from, to, &rf.p, &keep, mult.profile)?;
		route.cost = cost;
		route.label_yards = gl.y;
		route.jumps = if lifted { count } else { jumps };
		route.events = rf.events;
		Ok(route)
	}
	fn endpoint_leg(&mut self, swim: f64, mult: &Mult, k: u32, entry_node: u32, entry_tree: usize, finish: u32, scratch: usize, reverse: bool) -> R<(Vec<u32>, Vec<i32>)> {
		let mut tree = entry_tree;
		if !self.sc.trees[tree].reached(finish) {
			let set: FxHashSet<u32> = [finish].into_iter().collect();
			self.search(k, swim, mult, entry_node, scratch, -1, Some(&set), 1, reverse, false)?;
			tree = scratch;
		}
		if !self.sc.trees[tree].reached(finish) {
			return Err("cached endpoint entrance became unreachable".into());
		}
		Ok(self.sc.trees[tree].trace(finish))
	}

	fn add(&mut self, rf: &mut Refine, k: u32, node: u32, ordinal: i32, source_k: Option<u32>) -> R<()> {
		let st_n = self.st.n;
		let mut arc: i64 = -1;
		let mut arc_ref = None;
		if ordinal != 0 {
			let sk = source_k.unwrap_or(k);
			let mc = self.grid_req(sk)?;
			let a = (ordinal - 1) as usize;
			arc = a as i64;
			arc_ref = Some((sk, a as u32));
			let q = self.st.neighbor_cluster(sk, mc.a_dx[a] as i64, mc.a_dy[a] as i64)?;
			if !(q == k && mc.a_to[a] == node) {
				return fail("selected motion endpoint mismatch");
			}
			rf.events.push(Event { cluster: sk, ordinal: ordinal as u32, kind: mc.a_kind[a] as u32, from: mc.a_from[a], to_cluster: q, to: mc.a_to[a] });
			let p = &mut rf.p;
			if !(p.k.last() == Some(&sk) && p.n.last() == Some(&mc.a_from[a])) {
				return fail("selected event takeoff anchor missing");
			}
			rf.seen = FxHashMap::default();
			let path = mc.a_path[a] as usize;
			if path > 0 {
				for v in mc.path_off[path - 1] as usize..mc.path_off[path] as usize {
					let j = p.len();
					let (x, y) = self.st.raw_xy(sk, mc.pv_col[v] as i64);
					p.x.push((x - self.st.x0) / self.st.cs - 0.5);
					p.y.push((y - self.st.y0) / self.st.cs - 0.5);
					p.wx.push(x);
					p.wy.push(y);
					p.wz.push(mc.pv_z[v] as f64);
					p.k.push(sk);
					p.n.push(mc.a_from[a]);
					p.w.push(if j > 0 { p.w[j - 1] } else { 0.0 });
					p.hard.push(true);
					p.arc.push(arc_ref);
				}
			}
		}
		let id = k as i64 * STRIDE + node as i64;
		if let Some(&at) = rf.seen.get(&id) {
			if arc < 0 {
				let p = &mut rf.p;
				let mut j = p.len() as i64 - 1;
				while j > at as i64 {
					rf.seen.remove(&(p.k[j as usize] as i64 * STRIDE + p.n[j as usize] as i64));
					j -= 1;
				}
				p.truncate(at + 1);
				return Ok(());
			}
		}
		let c = self.grid_req(k)?;
		let cc = self.st.c;
		let p = &mut rf.p;
		let n = p.len();
		let cell = if (node as i64) < st_n { node as i64 } else { self.st.cell_of(&c, node) };
		let g = self.st.geometry(&c, k, node);
		let special = c.owner[node as usize] >= 0 || c.over_kind[node as usize] == 0;
		p.x.push(if special { (g[0] - self.st.x0) / self.st.cs - 0.5 } else { (k as i64 / self.st.ny * cc + cell / cc) as f64 });
		p.y.push(if special { (g[1] - self.st.y0) / self.st.cs - 0.5 } else { (k as i64 % self.st.ny * cc + cell % cc) as f64 });
		p.k.push(k);
		p.n.push(node);
		p.w.push((if n > 0 { p.w[n - 1] } else { 0.0 }) + if c.val[node as usize] == 2 { 1.0 } else { 0.0 });
		p.wx.push(g[0]);
		p.wy.push(g[1]);
		p.wz.push(g[2]);
		p.hard.push(arc >= 0);
		p.arc.push(arc_ref);
		rf.seen.insert(id, n);
		Ok(())
	}
	/// nodes: trace order (finish first); walk source -> finish (step -1) or finish -> source (step 1).
	fn add_all(&mut self, rf: &mut Refine, k: u32, nodes: &[u32], arcs: &[i32], first: i64, last: i64, step: i64) -> R<()> {
		let mut i = first;
		while if step < 0 { i >= last } else { i <= last } {
			let ordinal = if i != first { arcs[if step < 0 { i } else { i - 1 } as usize] } else { 0 };
			self.add(rf, k, nodes[i as usize], ordinal, None)?;
			i += step;
		}
		Ok(())
	}
	fn replay_hop(&mut self, rf: &mut Refine, swim: f64, mult: &Mult, slot: usize, r_tree: usize, from_id: i64, to_id: i64, from_node: u32, to_node: u32, edge: i64) -> R<()> {
		let source_k = (from_id / STRIDE) as u32;
		let target_k = (to_id / STRIDE) as u32;
		let g = self.graph(source_k)?;
		let row = (from_id % STRIDE) as usize;
		if !(edge >= g.row_out[row] as i64 && edge < g.row_out[row + 1] as i64) {
			return fail("missing selected abstract edge");
		}
		let e = edge as usize;
		if !(self.st.neighbor_cluster(source_k, g.e_dx[e] as i64, g.e_dy[e] as i64)? == target_k && g.e_ent[e] as i64 == to_id % STRIDE) {
			return fail("selected abstract edge identity");
		}
		let t = g.e_trace[3 * e + slot] as usize;
		let mut cursor = from_node;
		self.add(rf, source_k, from_node, 0, None)?;
		let mc = self.grid_req(source_k)?;
		let count = if t > 0 { (g.trace_off[t] - g.trace_off[t - 1]) as usize } else { 0 };
		for i in 0..count {
			let ordinal = g.trace_val[g.trace_off[t - 1] as usize + i];
			let a = (ordinal - 1) as usize;
			self.gap(rf, swim, mult, r_tree, source_k, &mut cursor, mc.a_from[a])?;
			let q = self.st.neighbor_cluster(source_k, mc.a_dx[a] as i64, mc.a_dy[a] as i64)?;
			self.add(rf, q, mc.a_to[a], ordinal as i32, Some(source_k))?;
			cursor = mc.a_to[a];
		}
		if source_k == target_k {
			self.gap(rf, swim, mult, r_tree, source_k, &mut cursor, to_node)?;
		} else if count == 0 {
			let cc = self.st.c;
			let sc = self.grid_req(source_k)?;
			let tc = self.grid_req(target_k)?;
			let fc = self.st.cell_of(&sc, from_node);
			let tcell = self.st.cell_of(&tc, to_node);
			let gx = source_k as i64 / self.st.ny * cc + fc / cc;
			let gy = source_k as i64 % self.st.ny * cc + fc % cc;
			let tx = target_k as i64 / self.st.ny * cc + tcell / cc;
			let ty = target_k as i64 % self.st.ny * cc + tcell % cc;
			let r = self.neighbour(source_k, from_node, gx as f64, gy as f64, tx - gx, ty - gy, true, to_node as i64)?;
			if r != Some((target_k, to_node)) {
				return fail("unwitnessed legacy graph crossing");
			}
			self.add(rf, target_k, to_node, 0, None)?;
		}
		Ok(())
	}
	fn gap(&mut self, rf: &mut Refine, swim: f64, mult: &Mult, r_tree: usize, k: u32, cursor: &mut u32, to: u32) -> R<()> {
		if *cursor == to {
			return Ok(());
		}
		if !self.search(k, swim, mult, *cursor, r_tree, to as i64, None, 0, false, true)? {
			return fail("selected trace has an unjoinable ordinary gap");
		}
		let (nodes, arcs) = self.sc.trees[r_tree].trace(to);
		self.add_all(rf, k, &nodes, &arcs, nodes.len() as i64 - 1, 0, -1)?;
		*cursor = to;
		Ok(())
	}

	// ---- the reader's lazy consistency checks ----

	fn validate_motion(&mut self, k: u32) -> R<()> {
		let key = (self.tolerant, self.st.map as u64 * 4096 + k as u64);
		let cached = self.checks.motion.lock().unwrap().get(&key).cloned();
		let v = match cached {
			Some(v) => v,
			None => {
				let v = self.check_motion(k).err();
				self.checks.motion.lock().unwrap().insert(key, v.clone());
				v
			}
		};
		match v {
			Some(e) => Err(e),
			None => Ok(()),
		}
	}
	/// -> the edge labels the search must skip (tolerant mode; empty in the Lua's mode, which errs instead).
	fn validate_joins(&mut self, k: u32) -> R<Arc<FxHashSet<u32>>> {
		let key = (self.tolerant, self.st.map as u64 * 4096 + k as u64);
		let cached = self.checks.joins.lock().unwrap().get(&key).cloned();
		let v = match cached {
			Some(v) => v,
			None => {
				let v = (|| -> R<Arc<FxHashSet<u32>>> {
					self.validate_motion(k)?;
					self.check_graph(k)?;
					let mut bad = FxHashSet::default();
					let tolerant = self.tolerant;
					self.check_joins(k, if tolerant { Some(&mut bad) } else { None })?;
					Ok(Arc::new(bad))
				})();
				self.checks.joins.lock().unwrap().insert(key, v.clone());
				v
			}
		};
		v
	}

	/// Motion.Validate for cluster k: the Lua's first error.
	fn check_motion(&mut self, k: u32) -> R<()> {
		let Some(c) = self.grid(k)? else { return fail("unpopulated motion source") };
		let ny = self.st.ny;
		struct Anchor<'c> {
			col: i64,
			layer: i64,
			owner: i64,
			c: Option<&'c Cluster>,
			node: usize,
		}
		fn anchor(c: &Cluster, node: u32) -> Option<Anchor<'_>> {
			let s = c.spec_idx[node as usize];
			if s < 0 {
				return None;
			}
			let s = s as usize;
			let o = c.owner[node as usize];
			Some(Anchor { col: c.spec_col[s] as i64, layer: c.spec_layer[s] as i64, owner: if o >= 0 { o as i64 } else { node as i64 }, c: Some(c), node: node as usize })
		}
		let witnessed = |a: Option<&Anchor>, ak: u32, b: Option<&Anchor>, bk: u32| -> Option<&'static str> {
			let (Some(a), Some(b)) = (a, b) else { return Some("motion endpoint lacks a retained raw/interface anchor") };
			if a.col < 0 || b.col < 0 {
				let (split, raw) = if a.col < 0 { (a, b) } else { (b, a) };
				let sc = split.c.unwrap();
				let o = sc.over_idx[split.node];
				let ok = ak == bk && raw.col >= 0 && o >= 0 && {
					let o = o as usize;
					split.owner == raw.owner
						&& ((raw.col == sc.ov_column[o] as i64 && raw.layer == sc.ov_layer[o] as i64) || (raw.col == sc.ov_to_column[o] as i64 && raw.layer == sc.ov_to_layer[o] as i64))
				};
				if !ok {
					return Some("motion segment lacks a split-link witness");
				}
			} else {
				let dx = bk as i64 / ny - ak as i64 / ny;
				let dy = bk as i64 % ny - ak as i64 % ny;
				let dj = b.col / 256 - a.col / 256 - 256 * dx;
				let di = b.col % 256 - a.col % 256 - 256 * dy;
				if !(dj.abs() <= 1 && di.abs() <= 1 && (dj != 0 || di != 0)) {
					return Some("motion polyline lacks neighboring raw vertices");
				}
			}
			None
		};
		for a in 0..c.a_from.len() {
			let ordinal = a as i64 + 1;
			let q = self.st.neighbor_cluster(k, c.a_dx[a] as i64, c.a_dy[a] as i64)?;
			let Some(dest) = self.grid(q)? else { return fail("unpopulated motion destination") };
			let keys = in_keys(&dest, ny);
			if keys.get(&(k as i64 * STRIDE + ordinal)) != Some(&c.a_hash[a]) {
				return fail("missing/mismatched incoming motion counterpart");
			}
			let (to, from) = (c.a_to[a], c.a_from[a]);
			if !((to as usize) < dest.n && dest.val[to as usize] != 0) {
				return fail("invalid motion target");
			}
			let ga = self.st.geometry(&c, k, from);
			let gb = self.st.geometry(&dest, q, to);
			let from_owner = if c.owner[from as usize] >= 0 { c.owner[from as usize] as i64 } else { from as i64 };
			let p = c.a_path[a] as usize;
			let (lo, hi) = if p > 0 { (c.path_off[p - 1] as usize, c.path_off[p] as usize) } else { (0, 0) };
			let mut why;
			{
				let mut prev = anchor(&c, from);
				let mut prev_k = k;
				why = None;
				let mut v = lo;
				while v < hi && why.is_none() {
					let r = Anchor { col: c.pv_col[v] as i64, layer: c.pv_layer[v] as i64, owner: from_owner, c: None, node: 0 };
					why = witnessed(prev.as_ref(), prev_k, Some(&r), k);
					prev = Some(r);
					prev_k = k;
					v += 1;
				}
				if why.is_none() {
					why = witnessed(prev.as_ref(), prev_k, anchor(&dest, to).as_ref(), q);
				}
			}
			if why.is_none() && (c.a_kind[a] == 1 || q != k) {
				let ap = anchor(&c, from);
				let bp = anchor(&dest, to);
				match (ap, bp) {
					(Some(ap), Some(bp)) if ap.col >= 0 && bp.col >= 0 => {
						let dj = bp.col / 256 - ap.col / 256 - 256 * c.a_dx[a] as i64;
						let di = bp.col % 256 - ap.col % 256 - 256 * c.a_dy[a] as i64;
						if !(dj.abs() <= 1 && di.abs() <= 1 && (dj != 0 || di != 0)) {
							why = Some("motion is not a raw neighbor");
						} else if c.a_kind[a] == 1 {
							let bo = if dest.owner[to as usize] >= 0 { dest.owner[to as usize] as usize } else { to as usize };
							if !(c.over_kind[from_owner as usize] == 0 && dest.over_kind[bo] == 0) {
								why = Some("jump endpoint owner is not refined");
							}
						}
					}
					_ => why = Some("jump/boundary endpoint is not raw"),
				}
			}
			if let Some(w) = why {
				return fail(w);
			}
			let (mut total, mut px, mut py, mut pz) = (0.0f64, ga[0], ga[1], ga[2]);
			for v in lo..hi {
				let (x, y) = self.st.raw_xy(k, c.pv_col[v] as i64);
				let zz = c.pv_z[v] as f64;
				total += ((x - px) * (x - px) + (y - py) * (y - py) + (zz - pz) * (zz - pz)).sqrt();
				px = x;
				py = y;
				pz = zz;
			}
			total += ((gb[0] - px) * (gb[0] - px) + (gb[1] - py) * (gb[1] - py) + (gb[2] - pz) * (gb[2] - pz)).sqrt();
			let label = c.a_yards[a] as f64;
			if (total as f32) as f64 != label && !(self.tolerant && (label - total).abs() <= ulp32(label)) {
				return fail("motion yard label disagrees with retained geometry");
			}
			let owner = if dest.owner[to as usize] >= 0 { dest.owner[to as usize] as usize } else { to as usize };
			let factor = if dest.val[owner] == 2 { self.st.swim } else { 1.0 };
			for (i, profile) in [Some(Faction::Alliance), Some(Faction::Horde), None].into_iter().enumerate() {
				let expected = (c.a_yards[a] as f64 * cost_mult(dest.cls[owner] as i64, profile, Style::Balanced) * factor) as f32;
				if expected != c.a_cost[3 * a + i] {
					return fail("motion profile cost disagrees with entered owner");
				}
			}
		}
		for i in 0..c.i_ordinal.len() {
			let source = self.st.neighbor_cluster(k, -(c.i_dx[i] as i64), -(c.i_dy[i] as i64))?;
			let Some(s) = self.grid(source)? else { return fail("unpopulated motion destination") };
			let o = c.i_ordinal[i] as usize - 1;
			if !(o < s.a_hash.len() && s.a_hash[o] == c.i_hash[i]) {
				return fail("extra/mismatched incoming motion row");
			}
		}
		Ok(())
	}

	/// Motion.ValidateGraph's own checks for cluster k.
	fn check_graph(&mut self, k: u32) -> R<()> {
		let g = self.graph(k)?;
		let c = self.grid(k)?;
		for row in 0..g.rows {
			for e in g.row_out[row] as usize..g.row_out[row + 1] as usize {
				let q = self.st.neighbor_cluster(k, g.e_dx[e] as i64, g.e_dy[e] as i64)?;
				let tg = self.graph(q)?;
				let t = g.e_ent[e] as usize;
				if t >= tg.rows {
					return fail("graph target entrance");
				}
				let mut matches = 0;
				for b in tg.row_in[t] as usize..tg.row_in[t + 1] as usize {
					if tg.in_ent[b] as usize == row && tg.in_hash[b] == g.e_hash[e] {
						matches += 1;
					}
				}
				if matches != 1 {
					return fail("missing/duplicate graph incoming counterpart");
				}
				for p in 0..3 {
					let tr = g.e_trace[3 * e + p] as usize;
					if tr > 0 && !(tr < g.trace_off.len() && g.trace_off[tr] > g.trace_off[tr - 1]) {
						return fail("missing/empty graph trace");
					}
					let (lo, hi) = if tr > 0 { (g.trace_off[tr - 1] as usize, g.trace_off[tr] as usize) } else { (0, 0) };
					let c = c.as_ref().ok_or_else(|| "Leffe's navigation maps: a path runs through a piece the maps do not have (missing or damaged files?)".to_string())?;
					let mut jumps = 0u64;
					for i in lo..hi {
						let a = g.trace_val[i] as usize - 1;
						if a >= c.a_from.len() {
							return fail("trace references missing motion arc");
						}
						jumps += c.a_kind[a] as u64;
						if q == k && !(c.a_dx[a] == 0 && c.a_dy[a] == 0) {
							return fail("intra-cluster trace leaves cluster");
						}
					}
					if jumps != g.e_jumps[3 * e + p] as u64 {
						return fail("trace jump count mismatch");
					}
					if q != k && hi > lo {
						let a = g.trace_val[lo] as usize - 1;
						if !(hi - lo == 1 && c.a_from[a] == g.row_node[row] && c.a_to[a] == tg.row_node[t] && c.a_dx[a] == g.e_dx[e] && c.a_dy[a] == g.e_dy[e]) {
							return fail("crossing trace endpoint mismatch");
						}
					}
				}
			}
			for e in g.row_in[row] as usize..g.row_in[row + 1] as usize {
				let q = self.st.neighbor_cluster(k, -(g.in_dx[e] as i64), -(g.in_dy[e] as i64))?;
				let sg = self.graph(q)?;
				let s = g.in_ent[e] as usize;
				if s >= sg.rows {
					return fail("incoming source entrance");
				}
				let mut count = 0;
				for o in sg.row_out[s] as usize..sg.row_out[s + 1] as usize {
					if sg.e_ent[o] as usize == row && sg.e_hash[o] == g.in_hash[e] {
						count += 1;
					}
				}
				if count != 1 {
					return fail("extra/mismatched graph incoming counterpart");
				}
			}
		}
		Ok(())
	}

	/// bad None: the Lua's error at the first failure; Some: collect the failing edge labels (3 e + slot).
	fn check_joins(&mut self, k: u32, mut bad: Option<&mut FxHashSet<u32>>) -> R<()> {
		let g = self.graph(k)?;
		let c = self.grid_req(k)?;
		// source -> (targets in order, target -> label keys)
		let mut pending: Vec<(u32, Vec<(u32, Vec<u32>)>)> = Vec::new();
		let mut pidx: FxHashMap<u32, usize> = FxHashMap::default();
		let mut gap = |a: u32, b: u32, key: u32| {
			if a == b {
				return;
			}
			let i = *pidx.entry(a).or_insert_with(|| {
				pending.push((a, Vec::new()));
				pending.len() - 1
			});
			let t = &mut pending[i].1;
			match t.iter_mut().find(|e| e.0 == b) {
				Some(e) => e.1.push(key),
				None => t.push((b, vec![key])),
			}
		};
		let cc = self.st.c;
		let mut fails: Vec<u32> = Vec::new();
		for row in 0..g.rows {
			let node = g.row_node[row];
			for e in g.row_out[row] as usize..g.row_out[row + 1] as usize {
				let q = self.st.neighbor_cluster(k, g.e_dx[e] as i64, g.e_dy[e] as i64)?;
				let dest = if q == k { g.clone() } else { self.graph(q)? };
				let target = dest.row_node[g.e_ent[e] as usize];
				for p in 0..3 {
					let key = (3 * e + p) as u32;
					let t = g.e_trace[key as usize] as usize;
					let (lo, hi) = if t > 0 { (g.trace_off[t - 1] as usize, g.trace_off[t] as usize) } else { (0, 0) };
					if q == k {
						let mut cursor = node;
						for i in lo..hi {
							let a = g.trace_val[i] as usize - 1;
							gap(cursor, c.a_from[a], key);
							cursor = c.a_to[a];
						}
						gap(cursor, target, key);
					} else if hi == lo {
						let qc = self.grid_req(q)?;
						let a = self.st.cell_of(&c, node);
						let b = self.st.cell_of(&qc, target);
						let gx = k as i64 / self.st.ny * cc + a / cc;
						let gy = k as i64 % self.st.ny * cc + a % cc;
						let tx = q as i64 / self.st.ny * cc + b / cc;
						let ty = q as i64 % self.st.ny * cc + b % cc;
						let (dx, dy) = (tx - gx, ty - gy);
						let r = if dx.abs() <= 1 && dy.abs() <= 1 && (dx != 0 || dy != 0) { self.neighbour(k, node, gx as f64, gy as f64, dx, dy, true, target as i64)? } else { None };
						if r != Some((q, target)) {
							if bad.is_none() {
								return fail("unwitnessed legacy graph crossing");
							}
							fails.push(key);
						}
					}
				}
			}
		}
		if let Some(b) = bad.as_deref_mut() {
			b.extend(fails);
		}
		for (source, targets) in &pending {
			let set: FxHashMap<u32, ()> = targets.iter().map(|t| (t.0, ())).collect();
			if self.reach(k, *source, &set)? {
				continue;
			}
			for (t, keys) in targets {
				if *t != *source && self.sc.seen[*t as usize] != self.sc.seen_gen {
					match bad.as_deref_mut() {
						None => return fail("selected trace has an unjoinable ordinary gap"),
						Some(b) => b.extend(keys.iter().copied()),
					}
				}
			}
		}
		Ok(())
	}

	/// Does every target lie within reach of source, by search's steps without motion arcs?
	fn reach(&mut self, k: u32, source: u32, targets: &FxHashMap<u32, ()>) -> R<bool> {
		let c = self.grid_req(k)?;
		let st = &self.st;
		let (cc, n) = (st.c, st.n);
		let sc = &mut *self.sc;
		if sc.seen.len() < c.n {
			let len = c.n.max(32768);
			sc.seen = vec![0; len];
			sc.queue = vec![0; len];
		}
		sc.seen_gen = sc.seen_gen.wrapping_add(1);
		let gen = sc.seen_gen;
		let (seen, queue) = (&mut sc.seen, &mut sc.queue);
		let (mut head, mut tail) = (0usize, 0usize);
		let mut left = targets.len() as i64;
		seen[source as usize] = gen;
		queue[tail] = source as i32;
		tail += 1;
		if targets.contains_key(&source) {
			left -= 1;
			if left <= 0 {
				return Ok(true);
			}
		}
		let m = &c.moves;
		while head < tail {
			let u = queue[head] as usize;
			head += 1;
			let o = if c.owner[u] >= 0 { c.owner[u] as i64 } else { u as i64 };
			let cell = if o < n { o } else { c.at_cell[o as usize] as i64 };
			let (ux, uy) = (cell / cc, cell % cc);
			let a = st.geometry(&c, k, u as u32);
			let mut visit = |v: usize, seen: &mut Vec<u32>, queue: &mut Vec<i32>, tail: &mut usize| -> bool {
				if seen[v] == gen {
					return false;
				}
				if c.over_kind[u] == 0 || c.over_kind[v] == 0 {
					return false;
				}
				let b = st.geometry(&c, k, v as u32);
				if !step_safe(st.cs, (b[0] - a[0]) / st.cs, (b[1] - a[1]) / st.cs, a[2], b[2]) {
					return false;
				}
				seen[v] = gen;
				queue[*tail] = v as i32;
				*tail += 1;
				if targets.contains_key(&(v as u32)) {
					left -= 1;
					return left <= 0;
				}
				false
			};
			let cu = cc as usize;
			if (u as i64) < n {
				let mi = m[u] % 16;
				if mi % 2 == 1 && visit(u + cu, seen, queue, &mut tail) {
					return Ok(true);
				}
				if ux > 0 && m[u - cu] % 2 == 1 && visit(u - cu, seen, queue, &mut tail) {
					return Ok(true);
				}
				if mi % 4 >= 2 && visit(u + 1, seen, queue, &mut tail) {
					return Ok(true);
				}
				if uy > 0 && m[u - 1] % 4 >= 2 && visit(u - 1, seen, queue, &mut tail) {
					return Ok(true);
				}
				if mi % 8 >= 4 && visit(u + cu + 1, seen, queue, &mut tail) {
					return Ok(true);
				}
				if mi >= 8 && visit(u + cu - 1, seen, queue, &mut tail) {
					return Ok(true);
				}
				if ux > 0 && uy > 0 && m[u - cu - 1] % 8 >= 4 && visit(u - cu - 1, seen, queue, &mut tail) {
					return Ok(true);
				}
				if ux > 0 && uy < cc - 1 && m[u - cu + 1] % 16 >= 8 && visit(u - cu + 1, seen, queue, &mut tail) {
					return Ok(true);
				}
			}
			for e in c.link_off[u] as usize..c.link_off[u + 1] as usize {
				let l = c.link_val[e];
				let d = (l % 8) as usize;
				let (tx, ty) = (ux + DX[d], uy + DY[d]);
				if tx >= 0 && ty >= 0 && tx < cc && ty < cc {
					let (v, _) = st.surface(&c, tx * cc + ty, (l / 8) as i64 - 1, c.z[u] as f64);
					if v >= 0 && step_safe(st.cs, DX[d] as f64, DY[d] as f64, c.z[u] as f64, c.z[v as usize] as f64) && visit(v as usize, seen, queue, &mut tail) {
						return Ok(true);
					}
				}
			}
		}
		Ok(false)
	}

	// ---- FindMany ----

	pub(crate) fn route_many(&mut self, from: &P, targets: &[P], o: &Opts) -> Many {
		self.expansions = 0;
		let n = targets.len();
		let mut ms = ManyState::new(n, o.chains);
		let r = self.run_many(from, targets, o, &mut ms);
		self.finish();
		match r {
			Ok(()) => ms.into_many(),
			Err(e) => {
				let why = format!("error: {e}");
				Many { costs: vec![-1.0; n], yards: vec![-1.0; n], jumps: vec![-1.0; n], reasons: vec![Some(why); n], chains: None }
			}
		}
	}

	fn run_many(&mut self, from: &P, targets: &[P], o: &Opts, ms: &mut ManyState) -> R<()> {
		let n = targets.len();
		let (sk, sc, why) = self.point_node(from)?;
		if sc < 0 {
			for i in 0..n {
				ms.fail(i, why.unwrap());
			}
			ms.chains = None;
			return Ok(());
		}
		for (i, p) in targets.iter().enumerate() {
			if p.x == from.x && p.y == from.y {
				let (k, node, _) = self.point_node(p)?;
				if k == sk && node == sc {
					ms.costs[i] = 0.0;
					ms.yards[i] = 0.0;
					ms.jumps[i] = 0.0;
				}
			}
		}
		let swim = if o.water_walking { 1.0 } else { self.st.swim };
		let mult = self.weights(o);
		let slot = mult.slot;
		let danger = mult.danger.clone();
		let mut memo = FxHashMap::default();
		let src = self.connect_point(swim, &mult, sk, sc as u32, from.z, false)?;
		// Leffe's lift layer: the map's landings, and which targets lie across a lift-separated city's floors from the
		// start (they are reached only after a ride on one of its lifts).
		let lx = self.lift_cx(swim, &mult);
		let mut must = vec![false; n];
		if let Some(g) = lx.as_ref().and_then(|l| l.group) {
			if let Some(s) = self.side(g, from) {
				for (i, t) in targets.iter().enumerate() {
					must[i] = self.side(g, t).is_some_and(|t| t != s);
				}
			}
		}
		let layered = must.contains(&true);
		let mut src_lifts = Vec::new();
		if let Some(l) = &lx {
			let tree = self.tree();
			for e in 0..l.at.len() {
				if l.at[e].0 == sk && l.inn[e].is_some() {
					if let Ok(Some((_, w))) = self.reach_from_side(swim, &mult, &src, sk, l.at[e].1, tree) {
						src_lifts.push((e, w));
					}
				}
			}
			for (id, ls) in l.links() {
				ms.links.insert(id, ls.into_iter().map(|(e, w)| (LIFT + e as i64, w[0], w[1], w[2])).collect());
			}
		}
		let limit = o.limit.unwrap_or(f64::INFINITY);
		let mut clusters: FxHashMap<u32, Vec<usize>> = FxHashMap::default();
		ms.left = n as i64;
		for (i, t) in targets.iter().enumerate() {
			let at = self.st.locate(t.x, t.y);
			if !ms.costs[i].is_nan() {
				ms.left -= 1;
			} else if let Some((k, _)) = at {
				clusters.entry(k).or_default().push(i);
			} else {
				ms.fail(i, "outside");
				ms.left -= 1;
			}
		}
		self.sc.heap.clear();
		self.sc.heap3.clear();
		let mut cx = ManyCx { swim, sk, src: &src, targets, clusters, must: &must, prepared: FxHashMap::default(), lift_tree: None };
		self.prepare(&mut cx, &mult, ms, sk)?;
		for (id, lab) in src.merged.iter() {
			ms.relax(&mut self.sc.heap, id, lab[0], lab[1], lab[2], START);
		}
		for (e, w) in src_lifts {
			ms.relax(&mut self.sc.heap3, LIFT + e as i64, w[0], w[1], w[2], START);
		}
		while ms.left > 0 {
			// The lift layer's heap only when its top is strictly cheaper.
			let lifted = self.sc.heap3.n > 0 && (self.sc.heap.n == 0 || self.sc.heap3.k[1] < self.sc.heap.k[1]);
			let u = if lifted {
				self.sc.heap3.pop()
			} else if self.sc.heap.n > 0 {
				self.sc.heap.pop()
			} else {
				break;
			};
			if ms.closed.contains(&u) {
				continue;
			}
			let du = ms.lab[&u];
			if du.0 > limit {
				break;
			}
			ms.closed.insert(u);
			if u < 0 {
				let i = (-1 - u) as usize;
				ms.costs[i] = du.0;
				ms.yards[i] = du.1;
				ms.jumps[i] = du.2;
				ms.left -= 1;
				continue;
			}
			let (b, layer) = unlayer(u);
			if b >= LIFT {
				if let Some(l) = &lx {
					self.many_landing(&mut cx, &mult, ms, l, layered, u, (b - LIFT) as usize, layer, du)?;
				}
				self.expansions += 1;
				continue;
			}
			let k = (b / STRIDE) as u32;
			let row = (b % STRIDE) as usize;
			self.prepare(&mut cx, &mult, ms, k)?;
			let (du, yu, ju) = du;
			if let Some(ends) = ms.links.get(&b).cloned() {
				for e in ends {
					if e.0 >= 0 {
						ms.relax(&mut self.sc.heap3, e.0 + layer, du + e.1, yu + e.2, ju + e.3, u);
					} else if layer != 0 {
						ms.relax(&mut self.sc.heap3, e.0, du + e.1, yu + e.2, ju + e.3, u);
					} else if !must[(-1 - e.0) as usize] {
						ms.relax(&mut self.sc.heap, e.0, du + e.1, yu + e.2, ju + e.3, u);
					}
				}
			}
			let bad = if self.validate { Some(self.validate_joins(k)?) } else { None };
			let g = self.graph(k)?;
			for e in g.row_out[row] as usize..g.row_out[row + 1] as usize {
				let v = self.st.neighbor_cluster(k, g.e_dx[e] as i64, g.e_dy[e] as i64)? as i64 * STRIDE + g.e_ent[e] as i64;
				if ms.closed.contains(&(v + layer)) || bad.as_ref().is_some_and(|b| b.contains(&((3 * e + slot) as u32))) {
					continue;
				}
				let ec = g.e_cost[3 * e + slot] as f64;
				let c = match self.edged(danger.as_ref(), &mut memo, b, v)? {
					Some(m) => du + ec * m,
					None => du + ec,
				};
				let heap = if layer == 0 { &mut self.sc.heap } else { &mut self.sc.heap3 };
				ms.relax(heap, v + layer, c, yu + g.e_yards[3 * e + slot] as f64, ju + g.e_jumps[3 * e + slot] as f64, u);
			}
			self.expansions += 1;
		}
		for i in 0..n {
			if ms.costs[i].is_nan() {
				ms.fail(i, "unreachable");
			}
		}
		Ok(())
	}

	fn prepare(&mut self, cx: &mut ManyCx, mult: &Mult, ms: &mut ManyState, k: u32) -> R<()> {
		let Some(list) = cx.clusters.remove(&k) else { return Ok(()) };
		std::mem::swap(&mut self.sc.heap, &mut self.sc.heap2);
		let r = self.prepare_in(cx, mult, ms, k, &list);
		std::mem::swap(&mut self.sc.heap, &mut self.sc.heap2);
		let (direct, ends) = r?;
		for (i, l) in direct.iter() {
			if !cx.must[i as usize] {
				ms.relax(&mut self.sc.heap, -1 - i, l[0], l[1], l[2], START);
			}
		}
		for (i, edges) in &ends {
			for (id, lab) in edges.merged.iter() {
				ms.links.entry(id).or_default().push((-1 - *i as i64, lab[0], lab[1], lab[2]));
			}
		}
		if self.lifts.is_some() {
			cx.prepared.insert(k, ends);
		}
		Ok(())
	}
	fn prepare_in(&mut self, cx: &mut ManyCx, mult: &Mult, ms: &mut ManyState, k: u32, list: &[usize]) -> R<(OMap<Lab>, Vec<(usize, Arc<TargetConn>)>)> {
		let mut direct: OMap<Lab> = OMap::default();
		let mut ends = Vec::new();
		let r_tree = self.tree();
		for &i in list {
			let (_, node, why) = self.point_node(&cx.targets[i])?;
			if node < 0 {
				ms.fail(i, why.unwrap());
				ms.left -= 1;
				continue;
			}
			let goal = self.target_connection(cx.swim, mult, k, node as u32, cx.targets[i].z)?;
			ends.push((i, goal.clone()));
			if k != cx.sk {
				continue;
			}
			for a in &cx.src.ends {
				for &last in &goal.ends {
					let first = a.node;
					let mut cost = None;
					if first == last {
						cost = Some([0.0, 0.0, 0.0]);
					} else if self.sc.trees[a.tree].reached(last) {
						let t = &self.sc.trees[a.tree];
						let l = last as usize;
						cost = Some([t.g[l], t.y[l], t.j[l]]);
					} else if self.search(k, cx.swim, mult, first, r_tree, last as i64, None, 0, false, false)? {
						let t = &self.sc.trees[r_tree];
						let l = last as usize;
						cost = Some([t.g[l], t.y[l], t.j[l]]);
					}
					if let Some(cst) = cost {
						let better = match direct.get(i as i64) {
							None => true,
							Some(p) => cst[0] < p[0],
						};
						if better {
							direct.set(i as i64, cst);
						}
					}
				}
			}
		}
		Ok((direct, ends))
	}
	/// A connection's cache key (a point's node in its cluster, the cost model and the checks' mode).
	fn conn_key(&self, swim: f64, mult: &Mult, k: u32, node: u32, h: Option<f64>) -> String {
		format!(
			"{}:{}:{}:{}:{}:{}:{:?}:{}:{}",
			self.st.map,
			k,
			node,
			h.map_or("-".to_string(), |h| format!("{:?}", h.to_bits())),
			swim.to_bits(),
			mult.slot,
			mult.style,
			mult.danger.as_ref().map_or(String::new(), |d| d.tag()),
			self.tolerant as u8 + 2 * self.validate as u8
		)
	}
	/// A target's reverse connection (entrance -> point costs), cached by the point's node (Lua: connect's st.ends).
	fn target_connection(&mut self, swim: f64, mult: &Mult, k: u32, node: u32, h: Option<f64>) -> R<Arc<TargetConn>> {
		let key = self.conn_key(swim, mult, k, node, h);
		if let Some(e) = self.sc.ends.get(&key) {
			return Ok(e.clone());
		}
		// Its trees go back to the pool at once: a connection keeps only its labels and end nodes (a FindMany of a
		// thousand targets would otherwise hold a thousand trees until it ends).
		let mark = self.sc.used.len();
		let side = self.connect_point(swim, mult, k, node, h, true)?;
		let released: Vec<usize> = self.sc.used.drain(mark..).collect();
		self.sc.free.extend(released);
		let e = Arc::new(TargetConn { merged: side.merged, ends: side.ends.iter().map(|x| x.node).collect() });
		let bytes = e.bytes(&key);
		while self.sc.ends_bytes + bytes > ENDS_BYTES || self.sc.ends.len() >= 8192 {
			let Some((old, b)) = self.sc.ends_order.pop_front() else { break };
			self.sc.ends.remove(&old);
			self.sc.ends_bytes -= b;
		}
		self.sc.ends.insert(key.clone(), e.clone());
		self.sc.ends_order.push_back((key, bytes));
		self.sc.ends_bytes += bytes;
		Ok(e)
	}

	// ---- Leffe's lift layer (lifts.rs) ----

	/// A lift landing's node: where (x, y) snaps at height z, when its surface is within LAND_Z_YD of z.
	pub(crate) fn landing(&mut self, x: f64, y: f64, z: f64) -> R<Option<(u32, u32)>> {
		let (k, node, _) = self.point_node(&P { x, y, z: Some(z) })?;
		if node < 0 {
			return Ok(None);
		}
		let c = self.grid_req(k)?;
		Ok(((c.z[node as usize] as f64 - z).abs() <= super::lifts::LAND_Z_YD).then_some((k, node as u32)))
	}
	/// A landing's connection (reverse: from its cluster's entrances to it; else from it to them), kept for the
	/// thread's life (a handful per map and cost model).
	fn landing_connection(&mut self, swim: f64, mult: &Mult, k: u32, node: u32, h: f64, reverse: bool) -> R<Arc<TargetConn>> {
		let key = format!("{}{}", if reverse { "in:" } else { "out:" }, self.conn_key(swim, mult, k, node, Some(h)));
		if let Some(e) = self.sc.lift_conns.get(&key) {
			return Ok(e.clone());
		}
		let mark = self.sc.used.len();
		let side = self.connect_point(swim, mult, k, node, Some(h), reverse)?;
		let released: Vec<usize> = self.sc.used.drain(mark..).collect();
		self.sc.free.extend(released);
		let e = Arc::new(TargetConn { merged: side.merged, ends: side.ends.iter().map(|x| x.node).collect() });
		self.sc.lift_conns.insert(key, e.clone());
		Ok(e)
	}
	/// The multiplier of a landing's surface, its class's and its zone's danger (our grid prices a ride by the surface
	/// it lands on).
	fn landing_mult(&mut self, mult: &Mult, k: u32, node: u32) -> R<f64> {
		let c = self.grid_req(k)?;
		let nu = node as usize;
		let mut m = mult.m.get(c.cls[nu] as usize).copied().unwrap_or(1.0);
		if let Some(d) = &mult.danger {
			let o = if c.owner[nu] >= 0 { c.owner[nu] as i64 } else { node as i64 };
			let cell = if o < self.st.n { o } else { c.at_cell[o as usize] as i64 };
			if let Some(z) = self.st.zone_at_cell(k, cell) {
				m *= d.get(z).unwrap_or(1.0);
			}
		}
		Ok(m)
	}
	/// The call's lifts (None: the map has none). A landing whose connection or ride fails stays out of the search.
	fn lift_cx(&mut self, swim: f64, mult: &Mult) -> Option<LiftCx> {
		let ml = self.lifts.clone()?;
		let n = 2 * ml.cars.len();
		let mut l = LiftCx { at: Vec::with_capacity(n), ride: Vec::with_capacity(n), city: Vec::with_capacity(n), inn: Vec::with_capacity(n), group: ml.group };
		for e in 0..n {
			let car = &ml.cars[e / 2];
			let (a, b) = (car.ends[e % 2], car.ends[1 - e % 2]);
			let inn = self.landing_connection(swim, mult, a.k, a.node, a.z, true).ok();
			l.at.push((a.k, inn.as_ref().and_then(|c| c.ends.first().copied()).unwrap_or(a.node), a.z));
			let h = b.z - a.z;
			l.ride.push(self.landing_mult(mult, b.k, b.node).ok().map(|m| [ride_seconds(h) * RUN * m, h.abs(), 0.0]));
			l.city.push(car.shaft.is_some());
			l.inn.push(inn);
		}
		Some(l)
	}
	/// The walk off landing e: to its cluster's entrances.
	fn landing_out(&mut self, swim: f64, mult: &Mult, l: &LiftCx, e: usize) -> R<Arc<TargetConn>> {
		let (k, node, z) = l.at[e];
		self.landing_connection(swim, mult, k, node, z, false)
	}
	/// Whether p is inside a lift-separated city (lifts::Group::inside; p's uiMap: the pack's zone there); None: either.
	fn side(&mut self, g: &Group, p: &P) -> Option<bool> {
		let zone = self.zone_at(p.x, p.y);
		g.inside(p.x, p.y, p.z, zone)
	}
	/// Runs f with the cluster searches' heap set aside (the abstract search's stays as it is).
	fn aside<T>(&mut self, f: impl FnOnce(&mut Self) -> R<T>) -> R<T> {
		std::mem::swap(&mut self.sc.heap, &mut self.sc.heap2);
		let r = f(self);
		std::mem::swap(&mut self.sc.heap, &mut self.sc.heap2);
		r
	}
	/// A grid search in cluster k from `from` to the nodes `to` -> (index into to, label) of those reached.
	fn reach_nodes(&mut self, swim: f64, mult: &Mult, k: u32, from: u32, to: &[u32], tree: usize) -> R<Vec<(usize, Lab)>> {
		let set: FxHashSet<u32> = to.iter().copied().filter(|&n| n != from).collect();
		if !set.is_empty() {
			self.search(k, swim, mult, from, tree, -1, Some(&set), set.len(), false, false)?;
		}
		let t = &self.sc.trees[tree];
		Ok(to
			.iter()
			.enumerate()
			.filter_map(|(i, &n)| {
				if n == from {
					Some((i, [0.0; 3]))
				} else if t.reached(n) {
					Some((i, [t.g[n as usize], t.y[n as usize], t.j[n as usize]]))
				} else {
					None
				}
			})
			.collect())
	}
	/// The cheapest walk from a start's ends to node `to` of its cluster k -> (the end, label).
	fn reach_from_side(&mut self, swim: f64, mult: &Mult, side: &Side, k: u32, to: u32, tree: usize) -> R<Option<(usize, Lab)>> {
		let mut best: Option<(usize, Lab)> = None;
		for (a, end) in side.ends.iter().enumerate() {
			let t = &self.sc.trees[end.tree];
			let w = if end.node == to {
				Some([0.0; 3])
			} else if t.reached(to) {
				Some([t.g[to as usize], t.y[to as usize], t.j[to as usize]])
			} else if self.search(k, swim, mult, end.node, tree, to as i64, None, 0, false, false)? {
				let t = &self.sc.trees[tree];
				Some([t.g[to as usize], t.y[to as usize], t.j[to as usize]])
			} else {
				None
			};
			if let Some(w) = w {
				if best.is_none_or(|b| w[0] < b.1[0]) {
					best = Some((a, w));
				}
			}
		}
		Ok(best)
	}
	/// The drawn walk between two nodes of cluster k (a lift's way on or off).
	fn walk_trace(&mut self, rf: &mut Refine, swim: f64, mult: &Mult, k: u32, from: u32, to: u32, tree: usize) -> R<()> {
		if from == to {
			return self.add(rf, k, from, 0, None);
		}
		if !self.search(k, swim, mult, from, tree, to as i64, None, 0, false, false)? {
			return fail("a lift landing's walk became unjoinable");
		}
		let (nodes, arcs) = self.sc.trees[tree].trace(to);
		self.add_all(rf, k, &nodes, &arcs, nodes.len() as i64 - 1, 0, -1)
	}
	/// A ride's landing: a hard point whose segment is the ride (Move::Lift); loops are cut afresh after it.
	fn add_ride(&mut self, rf: &mut Refine, k: u32, node: u32, car: u32) -> R<()> {
		rf.seen = FxHashMap::default();
		self.add(rf, k, node, 0, None)?;
		let last = rf.p.len() - 1;
		rf.p.hard[last] = true;
		rf.p.arc[last] = Some((RIDE, car));
		Ok(())
	}
	/// FindMany at landing e (abstract id u, layer `layer`, label du): the ride to the other landing, the walks off
	/// it to its cluster's entrances, targets and other landings.
	#[allow(clippy::too_many_arguments)]
	fn many_landing(&mut self, cx: &mut ManyCx, mult: &Mult, ms: &mut ManyState, l: &LiftCx, layered: bool, u: i64, e: usize, layer: i64, du: (f64, f64, f64)) -> R<()> {
		let (d, y, j) = du;
		if let Some(r) = l.ride[e] {
			let to = if layered && l.city[e] { LAYER } else { layer };
			ms.relax(&mut self.sc.heap3, LIFT + (e ^ 1) as i64 + to, d + r[0], y + r[1], j + r[2], u);
		}
		let swim = cx.swim;
		if let Ok(out) = self.aside(|r| r.landing_out(swim, mult, l, e)) {
			for (id, w) in out.merged.iter() {
				let heap = if layer == 0 { &mut self.sc.heap } else { &mut self.sc.heap3 };
				ms.relax(heap, id + layer, d + w[0], y + w[1], j + w[2], u);
			}
		}
		let (k, node, _) = l.at[e];
		self.prepare(cx, mult, ms, k)?;
		let mut goals: Vec<(i64, u32)> = Vec::new();
		for (i, tc) in cx.prepared.get(&k).into_iter().flatten() {
			if ms.costs[*i].is_nan() && !(layer == 0 && cx.must[*i]) {
				goals.extend(tc.ends.iter().map(|&n| (-1 - *i as i64, n)));
			}
		}
		for (f, &(fk, fnode, _)) in l.at.iter().enumerate() {
			if f != e && fk == k && l.inn[f].is_some() {
				goals.push((LIFT + f as i64 + layer, fnode));
			}
		}
		if goals.is_empty() {
			return Ok(());
		}
		let tree = match cx.lift_tree {
			Some(t) => t,
			None => {
				let t = self.tree();
				cx.lift_tree = Some(t);
				t
			}
		};
		let nodes: Vec<u32> = goals.iter().map(|g| g.1).collect();
		let Ok(reached) = self.aside(|r| r.reach_nodes(swim, mult, k, node, &nodes, tree)) else { return Ok(()) };
		for (gi, w) in reached {
			let id = goals[gi].0;
			let heap = if id < 0 && layer == 0 { &mut self.sc.heap } else { &mut self.sc.heap3 };
			ms.relax(heap, id, d + w[0], y + w[1], j + w[2], u);
		}
		Ok(())
	}

	// ---- PathGrid.lua sight and smooth ----
	fn sight(
		&mut self,
		p: &PView,
		a: usize,
		b: usize,
		water: bool,
		limit: f64,
		profile: Option<Faction>,
		hb: Option<i64>,
		hostile_ok: bool,
		style: Style,
		danger_at: &mut Option<DangerAt>,
	) -> R<bool> {
		let (ax, ay, bx, by) = (p.x[a], p.y[a], p.x[b], p.y[b]);
		let (mut k, mut node) = (p.k[a], p.n[a]);
		let (dx, dy) = (bx - ax, by - ay);
		let sx: f64 = if dx > 0.0 { 1.0 } else { -1.0 };
		let sy: f64 = if dy > 0.0 { 1.0 } else { -1.0 };
		let (nx, ny) = (dx * sx, dy * sy);
		let (mut x, mut y, mut ix, mut iy) = (ax, ay, 0.0f64, 0.0f64);
		while ix < nx || iy < ny {
			self.expansions += 1;
			let d = (1.0 + 2.0 * ix) * ny - (1.0 + 2.0 * iy) * nx;
			let (mut mx, mut my) = (0.0, 0.0);
			if d == 0.0 {
				mx = sx;
				my = sy;
			} else if d < 0.0 {
				mx = sx;
			} else {
				my = sy;
			}
			let Some(r) = self.neighbour(k, node, x, y, mx as i64, my as i64, water, -1)? else { return Ok(false) };
			(k, node) = r;
			let c = self.class_of(k, node)?;
			let mut m = cost_mult(c, profile, style);
			if let Some(da) = danger_at.as_mut() {
				m *= self.danger_at(da, k, node)?;
			}
			if m > limit || (hb.is_some_and(|hb| !hostile_ok && c % (hb + hb) >= hb)) {
				return Ok(false);
			}
			x += mx;
			y += my;
			ix += mx * sx;
			iy += my * sy;
		}
		Ok(k == p.k[b] && node == p.n[b])
	}

	fn danger_at(&mut self, da: &mut DangerAt, k: u32, node: u32) -> R<f64> {
		if !da.chunks.contains_key(&k) {
			let z = self.st.chunk_danger(k, &da.danger);
			da.chunks.insert(k, z);
		}
		match &da.chunks[&k] {
			Some(z) => {
				let c = self.grid_req(k)?;
				Ok(z[self.st.chunk_of(self.st.cell_of(&c, node))])
			}
			None => Ok(1.0),
		}
	}

	/// PathGrid.lua smooth over a path with hard entries -> kept indexes.
	fn smooth_hard(&mut self, p: &Pts, profile: Option<Faction>, style: Style, danger: Option<&Danger>) -> R<Vec<usize>> {
		let mut out: Vec<usize> = Vec::new();
		fn keep(out: &mut Vec<usize>, i: usize) {
			if out.last() != Some(&i) {
				out.push(i);
			}
		}
		let ordinary = |this: &mut Self, out: &mut Vec<usize>, a: usize, b: usize| -> R<()> {
			if a == b {
				keep(out, a);
				return Ok(());
			}
			let q = PView { x: &p.x[a..=b], y: &p.y[a..=b], w: &p.w[a..=b], k: &p.k[a..=b], n: &p.n[a..=b] };
			for j in this.smooth(&q, profile, style, danger)? {
				keep(out, a + j);
			}
			Ok(())
		};
		let mut first = 0;
		for i in 1..p.len() {
			if p.hard[i] {
				ordinary(self, &mut out, first, i - 1)?;
				keep(&mut out, i);
				first = i;
			}
		}
		ordinary(self, &mut out, first, p.len() - 1)?;
		Ok(out)
	}

	fn smooth(&mut self, p: &PView, profile: Option<Faction>, style: Style, danger: Option<&Danger>) -> R<Vec<usize>> {
		let n = p.x.len();
		let mut keep = vec![0usize];
		for i in 1..n.saturating_sub(1) {
			if p.x[i + 1] - p.x[i] != p.x[i] - p.x[i - 1] || p.y[i + 1] - p.y[i] != p.y[i] - p.y[i - 1] || p.w[i + 1] != p.w[i] {
				keep.push(i);
			}
		}
		if n > 1 {
			keep.push(n - 1);
		}
		let hb = match profile {
			Some(Faction::Horde) => Some(HUB_ALLIANCE),
			Some(Faction::Alliance) => Some(HUB_HORDE),
			None => None,
		};
		let mut danger_at = danger.map(|d| DangerAt { danger: d.clone(), chunks: FxHashMap::default() });
		let mut out = vec![keep[0]];
		let mut a = 0;
		while a < keep.len() - 1 {
			let mut b = a + 1;
			let (mut limit, mut hostile, mut last) = (0.0f64, false, keep[a]);
			for j in a + 2..keep.len() {
				let (pp, q) = (keep[a], keep[j]);
				for i in last + 1..=q {
					let c = self.class_of(p.k[i], p.n[i])?;
					let mut m = cost_mult(c, profile, style);
					if let Some(da) = danger_at.as_mut() {
						m *= self.danger_at(da, p.k[i], p.n[i])?;
					}
					if m > limit {
						limit = m;
					}
					if hb.is_some_and(|hb| c % (hb + hb) >= hb) {
						hostile = true;
					}
				}
				last = q;
				if !self.chord_safe(p, pp, q)? || !self.sight(p, pp, q, p.w[q] - p.w[pp] > 0.0, limit, profile, hb, hostile, style, &mut danger_at)? {
					break;
				}
				b = j;
			}
			let (pp, q) = (keep[a], keep[b]);
			if self.chord_safe(p, pp, q)? {
				out.push(q);
			} else {
				for j in pp + 1..=q {
					out.push(j);
				}
			}
			a = b;
		}
		Ok(out)
	}
	fn chord_safe(&mut self, p: &PView, a: usize, b: usize) -> R<bool> {
		let dx = p.x[b] - p.x[a];
		let dy = p.y[b] - p.y[a];
		let horizontal = self.st.cs * (dx * dx + dy * dy).sqrt();
		let za = self.grid_req(p.k[a])?.z[p.n[a] as usize] as f64;
		let zb = self.grid_req(p.k[b])?.z[p.n[b] as usize] as f64;
		let dz = (zb - za).abs();
		Ok((horizontal > 0.0 && dz <= horizontal * WALK_TAN + SLOPE_EPS) || (horizontal == 0.0 && dz <= SLOPE_EPS))
	}

	// ---- Path.lua drawMotionPath ----

	fn draw(&mut self, from: &P, to: &P, p: &Pts, keep: &[usize], profile: Option<Faction>) -> R<Route> {
		struct Pt {
			x: f64,
			y: f64,
			z: Option<f64>,
			/// The path entry the point stands on (from/to: the snapped ends).
			at: usize,
		}
		let mut points: Vec<Pt> = Vec::new();
		let (mut wet_yards, mut drawn) = (0.0f64, 0.0f64);
		let same = |a: Option<f64>, b: Option<f64>| match (a, b) {
			(None, None) => true,
			(Some(a), Some(b)) => a == b,
			_ => false,
		};
		let mut append = |pt: Pt, wet: f64, points: &mut Vec<Pt>| {
			if let Some(prior) = points.last() {
				if prior.x == pt.x && prior.y == pt.y && same(prior.z, pt.z) {
					return;
				}
				let dz = match (prior.z, pt.z) {
					(Some(a), Some(b)) => b - a,
					_ => 0.0,
				};
				let (ax, ay) = (pt.x - prior.x, pt.y - prior.y);
				let length = (ax * ax + ay * ay + dz * dz).sqrt();
				drawn += length;
				wet_yards += length * wet;
			}
			points.push(pt);
		};
		append(Pt { x: from.x, y: from.y, z: from.z, at: 0 }, 0.0, &mut points);
		let mut prior = 0;
		for &index in keep {
			let wet = if index > prior {
				(p.w[index] - p.w[prior]) / (index - prior) as f64
			} else if p.w[index] > 0.0 {
				1.0
			} else {
				0.0
			};
			append(Pt { x: p.wx[index], y: p.wy[index], z: Some(p.wz[index]), at: index }, wet, &mut points);
			prior = index;
		}
		let last = p.len() - 1;
		let wet = if p.w[last] - (if last > 0 { p.w[last - 1] } else { 0.0 }) > 0.0 { 1.0 } else { 0.0 };
		append(Pt { x: to.x, y: to.y, z: to.z, at: last }, wet, &mut points);
		if points.len() == 1 {
			points.push(Pt { x: to.x, y: to.y, z: to.z, at: last });
		}
		let xyz: Vec<[f64; 3]> = points.iter().map(|q| [q.x, q.y, q.z.unwrap_or(f64::NAN)]).collect();
		let hubs = hubs_on(&self.st.meta, &xyz, profile);
		// Legs: each drawn segment's move (the motion arc its far entry belongs to, else walking or swimming) and the
		// floor of its start surface.
		let mut legs = Vec::with_capacity(points.len().saturating_sub(1));
		for i in 1..points.len() {
			let (pa, pb) = (points[i - 1].at, points[i].at);
			let kind = match p.arc[pb] {
				Some((sk, a)) if pb > pa || p.hard[pb] => self.arc_move(sk, a)?,
				_ => {
					let wet = if pb > pa { p.w[pb] - p.w[pa] > 0.0 } else { p.w[pb] - if pb > 0 { p.w[pb - 1] } else { 0.0 } > 0.0 };
					if wet {
						Move::Swim
					} else {
						Move::Walk
					}
				}
			};
			let floor = self.floor_of(p.k[pa], p.n[pa])?;
			let ground = (self.class_of(p.k[pa], p.n[pa])? & 7) as u8;
			legs.push(Leg { from: i - 1, to: i, kind, floor, ground });
		}
		Ok(Route { ok: true, reason: None, points: xyz, cost: 0.0, label_yards: 0.0, yards: drawn, wet: wet_yards, jumps: 0.0, hubs, events: Vec::new(), legs })
	}
	/// A motion arc's move: a jump (kind 1), a drop or climb (its rise past the walkable slope), else a motion step; a
	/// ride's landing (RIDE) is a lift.
	fn arc_move(&mut self, sk: u32, a: u32) -> R<Move> {
		if sk == RIDE {
			return Ok(Move::Lift);
		}
		let c = self.grid_req(sk)?;
		let a = a as usize;
		if c.a_kind[a] == 1 {
			return Ok(Move::Jump);
		}
		let q = self.st.neighbor_cluster(sk, c.a_dx[a] as i64, c.a_dy[a] as i64)?;
		let d = self.grid_req(q)?;
		let ga = self.st.geometry(&c, sk, c.a_from[a]);
		let gb = self.st.geometry(&d, q, c.a_to[a]);
		let h = ((gb[0] - ga[0]).powi(2) + (gb[1] - ga[1]).powi(2)).sqrt();
		let dz = gb[2] - ga[2];
		let slope = h * WALK_TAN + SLOPE_EPS;
		Ok(if dz < -slope {
			Move::Drop
		} else if dz > slope {
			Move::Climb
		} else {
			Move::Motion
		})
	}
	/// A node's floor: 0 the base surface, i the cell's ith floor from the bottom (a port: its owner's).
	fn floor_of(&mut self, k: u32, node: u32) -> R<Option<u32>> {
		let Some(c) = self.grid(k)? else { return Ok(None) };
		let mut o = node as usize;
		if c.owner[o] >= 0 {
			o = c.owner[o] as usize;
		}
		if (o as i64) < self.st.n {
			return Ok(Some(0));
		}
		let lc = c.at_cell[o];
		if lc < 0 {
			return Ok(None);
		}
		let f = c.first_floor[lc as usize];
		Ok(if f >= 0 && o as i64 >= f as i64 { Some((o as i64 - f as i64 + 1) as u32) } else { None })
	}

	// ---- surfaces, zones, entrances ----

	pub(crate) fn zone_at(&mut self, x: f64, y: f64) -> Option<u32> {
		self.st.meta.zone.as_ref()?;
		let (k, lc) = self.st.locate(x, y)?;
		self.st.zone_at_cell(k, lc).map(|v| v as u32)
	}
	pub(crate) fn surfaces_at(&mut self, x: f64, y: f64) -> R<Vec<Surface>> {
		let Some((k, lc)) = self.st.locate(x, y) else { return Ok(Vec::new()) };
		let Some(c) = self.grid(k)? else { return Ok(Vec::new()) };
		let mut out = Vec::new();
		let l = lc as usize;
		if c.val[l] != 0 {
			out.push(Surface { z: c.z[l] as f64, water: c.val[l] == 2, floor: 0 });
		}
		let mut nd = c.first_floor[l] as i64;
		let mut i = 1;
		while nd >= 0 && (nd as usize) < c.n && c.at_cell[nd as usize] as i64 == lc {
			let v = c.val[nd as usize];
			if v != 0 {
				out.push(Surface { z: c.z[nd as usize] as f64, water: v == 2, floor: i });
			}
			nd += 1;
			i += 1;
		}
		Ok(out)
	}
	/// An entrance's position (chainCells); a lift landing's.
	pub(crate) fn entrance_xy(&mut self, id: i64) -> R<[f64; 3]> {
		if id >= LIFT {
			let e = (unlayer(id).0 - LIFT) as usize;
			let l = self.lifts.as_ref().and_then(|m| m.cars.get(e / 2)).map(|c| c.ends[e % 2]).ok_or("no such lift landing")?;
			return Ok([l.x, l.y, l.z]);
		}
		let k = (id / STRIDE) as u32;
		let c = self.grid_req(k)?;
		let e = self.entrance_node(id)?;
		Ok(self.st.geometry(&c, k, e))
	}
	/// The zones of cluster k's chunks (index.js clusterZones).
	pub(crate) fn cluster_zones(&self, k: u32) -> Vec<u32> {
		let mut set = Vec::new();
		if let Some(Some(s)) = self.st.meta.zone.as_ref().and_then(|z| z.get(k as usize)) {
			let mut i = 0;
			while i < s.len() {
				let a = B64[s[i] as usize] as i64;
				if a < 48 {
					let z = a * 64 + s.get(i + 1).map_or(-1, |&c| B64[c as usize] as i64);
					if z != 0 && !set.contains(&(z as u32)) {
						set.push(z as u32);
					}
					i += 2;
				} else {
					i += 1;
				}
			}
		}
		set
	}
}

/// The incoming-row identities of a cluster (router.js inKeys), built once per decoded cluster.
fn in_keys(d: &Cluster, ny: i64) -> &FxHashMap<i64, u32> {
	d.in_keys.get_or_init(|| {
		let mut m = FxHashMap::default();
		let (dkx, dky) = (d.k as i64 / ny, d.k as i64 % ny);
		for i in 0..d.i_ordinal.len() {
			m.insert(((dkx - d.i_dx[i] as i64) * ny + (dky - d.i_dy[i] as i64)) * STRIDE + d.i_ordinal[i] as i64, d.i_hash[i]);
		}
		m
	})
}

struct DangerAt {
	danger: Danger,
	chunks: FxHashMap<u32, Option<Box<[f64; 256]>>>,
}

/// A slice view of P (smooth's ordinary pieces).
struct PView<'p> {
	x: &'p [f64],
	y: &'p [f64],
	w: &'p [f64],
	k: &'p [u32],
	n: &'p [u32],
}

struct ManyCx<'s> {
	swim: f64,
	sk: u32,
	src: &'s Side,
	/// Per target: whether it lies across a lift-separated city's floors from the start.
	must: &'s [bool],
	/// The lift layer's: each prepared cluster's targets and their connections.
	prepared: FxHashMap<u32, Vec<(usize, Arc<TargetConn>)>>,
	/// The lift layer's scratch tree.
	lift_tree: Option<usize>,
	targets: &'s [P],
	clusters: FxHashMap<u32, Vec<usize>>,
}

struct ManyState {
	/// NaN: not yet settled (JS null); -1: not reached (false).
	costs: Vec<f64>,
	yards: Vec<f64>,
	jumps: Vec<f64>,
	reasons: Vec<Option<String>>,
	left: i64,
	lab: FxHashMap<i64, (f64, f64, f64)>,
	closed: FxHashSet<i64>,
	prev: Option<FxHashMap<i64, i64>>,
	links: FxHashMap<i64, Vec<(i64, f64, f64, f64)>>,
	chains: Option<()>,
}
impl ManyState {
	fn new(n: usize, chains: bool) -> ManyState {
		ManyState {
			costs: vec![f64::NAN; n],
			yards: vec![f64::NAN; n],
			jumps: vec![f64::NAN; n],
			reasons: vec![None; n],
			left: n as i64,
			lab: FxHashMap::default(),
			closed: FxHashSet::default(),
			prev: chains.then(FxHashMap::default),
			links: FxHashMap::default(),
			chains: chains.then_some(()),
		}
	}
	fn fail(&mut self, i: usize, why: &str) {
		self.costs[i] = -1.0;
		self.yards[i] = -1.0;
		self.jumps[i] = -1.0;
		self.reasons[i] = Some(why.to_string());
	}
	fn relax(&mut self, heap: &mut Heap, id: i64, cost: f64, yd: f64, jc: f64, by: i64) {
		let better = match self.lab.get(&id) {
			None => true,
			Some(p) => cost < p.0,
		};
		if better {
			self.lab.insert(id, (cost, yd, jc));
			if let Some(prev) = &mut self.prev {
				prev.insert(id, by);
			}
			heap.push(cost, id);
		}
	}
	fn into_many(self) -> Many {
		let n = self.costs.len();
		let chains = match (&self.chains, &self.prev) {
			(Some(()), Some(prev)) => {
				let mut out = vec![None; n];
				for (i, slot) in out.iter_mut().enumerate() {
					if self.costs[i] < 0.0 {
						continue;
					}
					let Some(&first) = prev.get(&(-1 - i as i64)) else { continue };
					let mut chain = Vec::new();
					let mut id = first;
					while id != START {
						chain.push(unlayer(id).0);
						id = prev[&id];
					}
					chain.reverse();
					*slot = Some(chain);
				}
				Some(out)
			}
			_ => None,
		};
		Many { costs: self.costs, yards: self.yards, jumps: self.jumps, reasons: self.reasons, chains }
	}
}

/// Path.lua search's core: grid Dijkstra in cluster k over its tree and heap -> (expansions, found).
fn search_in(
	st: &MapState,
	c: &Cluster,
	k: u32,
	swim: f64,
	mult: &Mult,
	dz: Option<&[f64; 256]>,
	source: u32,
	tree: &mut Tree,
	heap: &mut Heap,
	goal: i64,
	targets: Option<&FxHashSet<u32>>,
	mut left: i64,
	reverse: bool,
	zero_special: bool,
) -> (u64, bool) {
	let (cc, cs, n) = (st.c, st.cs, st.n);
	let cu = cc as usize;
	tree.fit(c.n);
	tree.gen = tree.gen.wrapping_add(1);
	let gen = tree.gen;
	heap.clear();
	let s = source as usize;
	tree.g[s] = 0.0;
	tree.par[s] = -1;
	tree.stamp[s] = gen;
	tree.j[s] = 0.0;
	tree.arc[s] = 0;
	tree.y[s] = 0.0;
	heap.push(0.0, source as i64);
	let balanced = mult.style == Style::Balanced;
	let slot = mult.slot;
	let swim_ratio = swim / st.swim;
	let mut exp = 0u64;
	struct Cur {
		u: usize,
		gu: f64,
		yu: f64,
		ju: f64,
		a: [f64; 3],
	}
	let relax = |tree: &mut Tree, heap: &mut Heap, cur: &Cur, v: usize, arc: i64| {
		let u = cur.u;
		let priced = if reverse { u } else { v };
		if arc < 0 && (c.over_kind[u] == 0 || c.over_kind[v] == 0) {
			return;
		}
		let b = st.geometry(c, k, v as u32);
		let a = cur.a;
		if arc < 0 && !step_safe(cs, (b[0] - a[0]) / cs, (b[1] - a[1]) / cs, a[2], b[2]) {
			return;
		}
		let step = if arc >= 0 { c.a_yards[arc as usize] as f64 } else { ((b[0] - a[0]) * (b[0] - a[0]) + (b[1] - a[1]) * (b[1] - a[1]) + (b[2] - a[2]) * (b[2] - a[2])).sqrt() };
		let wet = c.val[priced] == 2;
		let priced_step = if arc >= 0 && balanced {
			c.a_cost[3 * arc as usize + slot] as f64 * (if wet { swim_ratio } else { 1.0 })
		} else {
			let cm = mult.m.get(c.cls[priced] as usize).copied().unwrap_or(1.0);
			step * (cm * (if wet { swim } else { 1.0 }))
		};
		let gv = match dz {
			Some(dz) => {
				let o = if c.owner[priced] >= 0 { c.owner[priced] as i64 } else { priced as i64 };
				let cell = if o < n { o } else { c.at_cell[o as usize] as i64 };
				cur.gu + priced_step * dz[((cell / cc * 16) / cc * 16 + (cell % cc * 16) / cc) as usize]
			}
			None => cur.gu + priced_step,
		};
		if tree.stamp[v] != gen || gv < tree.g[v] {
			tree.g[v] = gv;
			tree.par[v] = u as i32;
			tree.stamp[v] = gen;
			tree.j[v] = cur.ju + if arc >= 0 { c.a_kind[arc as usize] as f64 } else { 0.0 };
			tree.arc[v] = if arc >= 0 { arc as i32 + 1 } else { 0 };
			tree.y[v] = cur.yu + step;
			heap.push(gv, v as i64);
		}
	};
	let m = &c.moves;
	while heap.n > 0 {
		let u = heap.pop() as usize;
		if tree.closed[u] == gen {
			continue;
		}
		tree.closed[u] = gen;
		exp += 1;
		if u as i64 == goal {
			return (exp, true);
		}
		if let Some(t) = targets {
			if t.contains(&(u as u32)) {
				left -= 1;
				if left <= 0 {
					return (exp, true);
				}
			}
		}
		let o = if c.owner[u] >= 0 { c.owner[u] as i64 } else { u as i64 };
		let cell = if o < n { o } else { c.at_cell[o as usize] as i64 };
		let (ux, uy) = (cell / cc, cell % cc);
		let cur = Cur { u, gu: tree.g[u], yu: tree.y[u], ju: tree.j[u], a: st.geometry(c, k, u as u32) };
		if (u as i64) < n {
			let mi = m[u] % 16;
			if mi % 2 == 1 {
				relax(tree, heap, &cur, u + cu, -1);
			}
			if ux > 0 && m[u - cu] % 2 == 1 {
				relax(tree, heap, &cur, u - cu, -1);
			}
			if mi % 4 >= 2 {
				relax(tree, heap, &cur, u + 1, -1);
			}
			if uy > 0 && m[u - 1] % 4 >= 2 {
				relax(tree, heap, &cur, u - 1, -1);
			}
			if mi % 8 >= 4 {
				relax(tree, heap, &cur, u + cu + 1, -1);
			}
			if mi >= 8 {
				relax(tree, heap, &cur, u + cu - 1, -1);
			}
			if ux > 0 && uy > 0 && m[u - cu - 1] % 8 >= 4 {
				relax(tree, heap, &cur, u - cu - 1, -1);
			}
			if ux > 0 && uy < cc - 1 && m[u - cu + 1] % 16 >= 8 {
				relax(tree, heap, &cur, u - cu + 1, -1);
			}
		}
		for e in c.link_off[u] as usize..c.link_off[u + 1] as usize {
			let l = c.link_val[e];
			let d = (l % 8) as usize;
			let (tx, ty) = (ux + DX[d], uy + DY[d]);
			if tx >= 0 && ty >= 0 && tx < cc && ty < cc {
				let (v, _) = st.surface(c, tx * cc + ty, (l / 8) as i64 - 1, c.z[u] as f64);
				if v >= 0 && step_safe(cs, DX[d] as f64, DY[d] as f64, c.z[u] as f64, c.z[v as usize] as f64) {
					relax(tree, heap, &cur, v as usize, -1);
				}
			}
		}
		if !zero_special {
			if reverse {
				for e in c.in_off[u] as usize..c.in_off[u + 1] as usize {
					let a = c.in_idx[e] as usize;
					relax(tree, heap, &cur, c.a_from[a] as usize, a as i64);
				}
			} else {
				for e in c.out_off[u] as usize..c.out_off[u + 1] as usize {
					let a = c.out_idx[e] as usize;
					if c.a_dx[a] == 0 && c.a_dy[a] == 0 {
						relax(tree, heap, &cur, c.a_to[a] as usize, a as i64);
					}
				}
			}
		}
	}
	(exp, goal < 0)
}

fn enters(a: &[f64; 3], b: &[f64; 3], disks: &[[f64; 3]]) -> Option<f64> {
	let (dx, dy) = (b[0] - a[0], b[1] - a[1]);
	let aa = dx * dx + dy * dy;
	let mut first: Option<f64> = None;
	for d in disks {
		let (fx, fy) = (a[0] - d[0], a[1] - d[1]);
		let c = fx * fx + fy * fy - d[2] * d[2];
		let mut t = None;
		if c <= 0.0 {
			t = Some(0.0);
		} else if aa > 0.0 {
			let bb = 2.0 * (fx * dx + fy * dy);
			let disc = bb * bb - 4.0 * aa * c;
			if disc >= 0.0 {
				let v = (-bb - disc.sqrt()) / (2.0 * aa);
				if !(v < 0.0 || v > 1.0) {
					t = Some(v);
				}
			}
		}
		if let Some(t) = t {
			if first.is_none() || t < first.unwrap() {
				first = Some(t);
			}
		}
	}
	first
}

fn hubs_on(meta: &Meta, points: &[[f64; 3]], profile: Option<Faction>) -> Vec<Hub> {
	let mut out = Vec::new();
	let Some(profile) = profile else { return out };
	let mine = match profile {
		Faction::Alliance => "Alliance",
		Faction::Horde => "Horde",
	};
	let mut listed = vec![false; meta.hubs.len()];
	for i in 1..points.len() {
		let mut hits: Vec<(f64, usize)> = Vec::new();
		for (order, hub) in meta.hubs.iter().enumerate() {
			let side = hub.side.as_deref();
			if !listed[order] && side != Some(mine) && matches!(side, Some("Alliance") | Some("Horde")) {
				if let Some(t) = enters(&points[i - 1], &points[i], &hub.disks) {
					hits.push((t, order));
				}
			}
		}
		hits.sort_by(|p, q| p.0.partial_cmp(&q.0).unwrap_or(std::cmp::Ordering::Equal).then(p.1.cmp(&q.1)));
		for (_, order) in hits {
			listed[order] = true;
			let h = &meta.hubs[order];
			out.push(Hub { id: h.id.clone(), name: h.name.clone(), area_id: if h.area_id.is_nan() { None } else { Some(h.area_id as u32) } });
		}
	}
	out
}
