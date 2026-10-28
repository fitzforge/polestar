//! Travel between two run points (port of tools/lib/sim/travel.js): walking, or a walk to a
//! transport node, the network (flights between known flight paths, boats, zeppelins, trams)
//! and a walk from a node, whichever is cheaper. A walk is the walk store's (× routeMul) where it
//! has one, else the straight line × the continent's detour. Matrices are Float32 as in the JS
//! (sums rounded the same way) and built for a known-flight-path set always from the set
//! without its highest bit, so a route's times never depend on what was evaluated before.

use crate::run::{Run, NEAR_CAND, NEAR_K};
use crate::walks::Walks;
use forge_core::js_hypot;
use rustc_hash::FxHashMap;
use std::sync::Arc;

/// Yards: below this, walking always wins.
pub const SHORT: f64 = 400.0;
/// Levels: zones this far above the character are dangerous to cross.
pub const DANGER_GAP: f64 = 5.0;

pub type Matrix = Arc<Vec<f32>>;

/// Shared, parameter-dependent travel data of a run (read-only once built).
pub struct TravelBase {
	pub n: usize,
	pub np: usize,
	pub run_speed: f64,
	pub mount_mul: f64,
	pub route_mul: f64,
	/// Tauren's Plainsrunning on foot (params::plainsrunning_sec).
	pub plainsrunning: bool,
	pub flight_overhead: f64,
	/// Seconds per second of a ride's wait (params transportWait): the path's ride edges.
	pub transport_wait: f64,
	pub death_risk: f64,
	pub detour: [f64; 2],
	pub fp_node: Vec<usize>,
	pub fp_bit: Vec<i32>,
	pub taxi_from: Vec<Vec<(usize, f64)>>,
	pub node_walk: Vec<f64>,
	pub near: Vec<i32>,
	pub near_walk: Vec<f64>,
	pub base: [Matrix; 2],
}

fn detour_of(d: &[f64; 2], c: i64) -> f64 {
	match c {
		0 => d[0],
		1 => d[1],
		_ => (d[0] + d[1]) / 2.0,
	}
}

impl TravelBase {
	pub fn new(run: &Run, p: &crate::params::Params, walks: &dyn Walks) -> TravelBase {
		let n = run.n_nodes;
		let np = run.pt_list.len();
		let detour = [p.detour0, p.detour1];
		let routed = |a: u32, b: u32| walks.yards(a, b).map(|r| r * p.route_mul);
		let mut fp_node = vec![0usize; run.fp_count];
		for k in 0..n {
			if run.fp_bit[k] >= 0 {
				fp_node[run.fp_bit[k] as usize] = k;
			}
		}
		let mut taxi_from = vec![Vec::new(); n];
		for &(a, b, yd) in &run.taxi {
			taxi_from[a].push((b, yd / p.flight_speed));
		}
		let mut node_walk = vec![f64::INFINITY; n * n];
		for i in 0..n {
			for j in 0..n {
				if i == j || run.node_r[i] != run.node_r[j] {
					continue;
				}
				node_walk[i * n + j] =
					routed(run.node_w[i], run.node_w[j]).unwrap_or_else(|| js_hypot(run.node_x[i] - run.node_x[j], run.node_y[i] - run.node_y[j]) * detour_of(&detour, run.node_c[i]));
			}
		}
		let mut near = vec![-1i32; np * NEAR_K];
		let mut near_walk = vec![0.0f64; np * NEAR_K];
		let mut cand: Vec<(f64, usize, usize)> = Vec::with_capacity(NEAR_CAND);
		for a in 0..np {
			cand.clear();
			for k in 0..NEAR_CAND {
				let nn = run.p_near[a * NEAR_CAND + k];
				if nn < 0 {
					break;
				}
				let nn = nn as usize;
				let r = routed(run.pt_list[a], run.node_w[nn]).unwrap_or_else(|| run.p_near_d[a * NEAR_CAND + k] * detour_of(&detour, run.p_c[a]));
				cand.push((r, k, nn));
			}
			let mut walked: Vec<(f64, usize, usize)> = cand.iter().copied().filter(|c| c.0 < f64::INFINITY).collect();
			walked.sort_by(|x, y| x.0.partial_cmp(&y.0).unwrap().then(x.1.cmp(&y.1)));
			let pick = if walked.is_empty() { &cand } else { &walked };
			for (k, c) in pick.iter().take(NEAR_K).enumerate() {
				near[a * NEAR_K + k] = c.2 as i32;
				near_walk[a * NEAR_K + k] = c.0;
			}
		}
		let mut t = TravelBase {
			n,
			np,
			run_speed: p.run_speed,
			mount_mul: p.mount_mul,
			route_mul: p.route_mul,
			plainsrunning: p.plainsrunning,
			flight_overhead: p.flight_overhead,
			transport_wait: p.transport_wait,
			death_risk: p.death_risk,
			detour,
			fp_node,
			fp_bit: run.fp_bit.clone(),
			taxi_from,
			node_walk,
			near,
			near_walk,
			base: [Arc::new(Vec::new()), Arc::new(Vec::new())],
		};
		t.base = [Arc::new(t.base_matrix(run, p, false)), Arc::new(t.base_matrix(run, p, true))];
		t
	}

	#[inline]
	pub fn speed(&self, mounted: bool) -> f64 {
		self.run_speed * if mounted { self.mount_mul } else { 1.0 }
	}

	/// Seconds of one walk that takes `sec` at the run speed: Plainsrunning shortens it on foot.
	#[inline]
	pub fn foot(&self, sec: f64, mounted: bool) -> f64 {
		if self.plainsrunning && !mounted {
			crate::params::plainsrunning_sec(sec)
		} else {
			sec
		}
	}

	fn base_matrix(&self, run: &Run, p: &crate::params::Params, mounted: bool) -> Vec<f32> {
		let n = self.n;
		let mut d = vec![f32::INFINITY; n * n];
		let v = self.speed(mounted);
		for i in 0..n {
			d[i * n + i] = 0.0;
			for j in 0..n {
				if i == j || run.node_r[i] != run.node_r[j] {
					continue;
				}
				d[i * n + j] = (self.node_walk[i * n + j] / v) as f32;
			}
		}
		for r in &run.rides {
			let c = r.ride + r.wait * p.transport_wait;
			if c < d[r.a * n + r.b] as f64 {
				d[r.a * n + r.b] = c as f32;
			}
		}
		for k in 0..n {
			for i in 0..n {
				let dik = d[i * n + k] as f64;
				if dik == f64::INFINITY {
					continue;
				}
				for j in 0..n {
					let c = dik + d[k * n + j] as f64;
					if c < d[i * n + j] as f64 {
						d[i * n + j] = c as f32;
					}
				}
			}
		}
		d
	}

	/// Matrix for `mask` when the parent matrix `parent` (mask without node k) is known.
	fn learn(&self, parent: &[f32], mask: u64, k: usize) -> Vec<f32> {
		let n = self.n;
		let mut m = parent.to_vec();
		let over = self.flight_overhead;
		let mut edges: Vec<(usize, usize, f64)> = Vec::new();
		let fp_bit = |x: usize| -> i32 { self.fp_bit_of(x) };
		for &(b, sec) in &self.taxi_from[k] {
			let bb = fp_bit(b);
			if bb >= 0 && (mask >> bb) & 1 == 1 {
				edges.push((k, b, sec + over));
			}
		}
		for a in 0..n {
			if a == k {
				continue;
			}
			let ab = fp_bit(a);
			if ab < 0 || (mask >> ab) & 1 != 1 {
				continue;
			}
			for &(b, sec) in &self.taxi_from[a] {
				if b == k {
					edges.push((a, k, sec + over));
				}
			}
		}
		for &(a, b, w) in &edges {
			if !(w < m[a * n + b] as f64) {
				continue;
			}
			for i in 0..n {
				let ia = m[i * n + a] as f64;
				if ia == f64::INFINITY {
					continue;
				}
				let base = ia + w;
				for j in 0..n {
					let c = base + m[b * n + j] as f64;
					if c < m[i * n + j] as f64 {
						m[i * n + j] = c as f32;
					}
				}
			}
		}
		m
	}

	#[inline]
	fn fp_bit_of(&self, node: usize) -> i32 {
		self.fp_bit[node]
	}

	/// The network path behind a leg's matrix cost from node `a` to node `b` (dm: the known-set
	/// matrix the leg was priced on, mask: its known set): node by node, the edge whose cost plus
	/// the rest equals the matrix's (walks between nodes of a region, rides, flights between
	/// known flight paths). Walk legs name the world point of the node walked to. No node is
	/// visited twice (zero-cost edges, e.g. a portal arrival on its node, would loop), and of
	/// equally exact edges the one leaving the least of the way is taken.
	pub fn path(&self, run: &Run, mask: u64, dm: &[f32], mounted: bool, a: usize, b: usize) -> Vec<Leg> {
		let n = self.n;
		let v = self.speed(mounted);
		let known = |x: usize| {
			let bit = self.fp_bit_of(x);
			bit >= 0 && (mask >> bit) & 1 == 1
		};
		let mut out = Vec::new();
		let mut u = a;
		let mut seen = vec![false; n];
		seen[a] = true;
		for _ in 0..64 {
			if u == b {
				break;
			}
			let need = dm[u * n + b] as f64;
			let tol = 1e-4 * need + 0.5;
			let mut best: Option<(f64, f64, usize, Leg)> = None;
			let consider = |cost: f64, k: usize, leg: Leg, best: &mut Option<(f64, f64, usize, Leg)>| {
				if seen[k] {
					return;
				}
				let rest = dm[k * n + b] as f64;
				let resid = cost + rest - need;
				if resid <= tol && best.as_ref().is_none_or(|x| (resid.abs(), rest) < (x.0, x.1)) {
					*best = Some((resid.abs(), rest, k, leg));
				}
			};
			if known(u) {
				for &(k, sec) in &self.taxi_from[u] {
					if known(k) {
						consider(sec + self.flight_overhead, k, Leg::Fly { from: u as u32, to: k as u32 }, &mut best);
					}
				}
			}
			for (ri, r) in run.rides.iter().enumerate() {
				if r.a == u {
					consider(r.ride + r.wait * self.transport_wait, r.b, Leg::Ride { ride: ri as u32, from: u as u32, to: r.b as u32 }, &mut best);
				}
			}
			for k in 0..n {
				if k != u && run.node_r[k] == run.node_r[u] {
					consider(self.node_walk[u * n + k] / v, k, Leg::Walk { to: run.node_w[k], node: Some(k as u32) }, &mut best);
				}
			}
			let Some((_, _, k, leg)) = best else { break };
			out.push(leg);
			seen[k] = true;
			u = k;
		}
		out
	}
}

/// One leg of a network path (Trace::Network `legs`): a walk to a world point (and the node
/// there), a flight between two flight-path nodes, or a ride (world.rides index) between two
/// nodes. Node indices are world.nodes indices.
#[derive(Clone, Debug, PartialEq, serde::Serialize)]
#[serde(tag = "k", rename_all = "lowercase")]
pub enum Leg {
	Walk {
		to: u32,
		#[serde(skip_serializing_if = "Option::is_none")]
		node: Option<u32>,
	},
	Fly {
		from: u32,
		to: u32,
	},
	Ride {
		ride: u32,
		from: u32,
		to: u32,
	},
}

/// Per-evaluator travel: the matrix cache (by known set) and the crossed-zone cache.
pub struct Travel {
	pub base: Arc<TravelBase>,
	cache: FxHashMap<u64, Matrix>,
	cross: FxHashMap<u64, Vec<f64>>,
	cache_max: usize,
	pub last_mode: u8,
	pub last_risk: f64,
	pub last_short: bool,
	/// The direct walk of the last leg: raw yards (routed, before routeMul; or straight, before
	/// the detour) and its kind (0 routed, 1 + continent index 0/1/2 straight): the counters.
	pub last_walk: (f64, u8),
	/// The last leg's entry and exit nodes when it used the network (-1: walked).
	pub last_nodes: (i32, i32),
	/// The last leg's direct walk was refused: a pair the walk store lacks beyond its radius.
	pub last_far: bool,
}

const MOUNTED_KEY: u64 = 1 << 51;

impl Travel {
	pub fn new(base: Arc<TravelBase>) -> Travel {
		Travel { base, cache: FxHashMap::default(), cross: FxHashMap::default(), cache_max: 6000, last_mode: 0, last_risk: 0.0, last_short: false, last_walk: (0.0, 0), last_nodes: (-1, -1), last_far: false }
	}

	/// Matrix for a known-flight-path set (built from the set without its highest bit).
	pub fn matrix_for(&mut self, mask: u64, mounted: bool) -> Matrix {
		if mask == 0 {
			return self.base.base[usize::from(mounted)].clone();
		}
		let key = if mounted { mask | MOUNTED_KEY } else { mask };
		if let Some(m) = self.cache.get(&key) {
			return m.clone();
		}
		let mut b = self.base.fp_node.len().saturating_sub(1);
		while b > 0 && (mask >> b) & 1 != 1 {
			b -= 1;
		}
		let parent = self.matrix_for(mask & !(1u64 << b), mounted);
		let m = Arc::new(self.base.learn(&parent, mask, self.base.fp_node[b]));
		if self.cache.len() >= self.cache_max {
			self.cache.clear();
		}
		self.cache.insert(key, m.clone());
		m
	}

	/// Minimum levels of the zones a straight walk from a to b crosses (not the end zones),
	/// highest first.
	fn crossed(&mut self, run: &Run, a: u32, b: u32) -> &[f64] {
		let key = a as u64 * self.base.np as u64 + b as u64;
		if !self.cross.contains_key(&key) {
			let (ai, bi) = (a as usize, b as usize);
			let v = match run.danger.get(&run.p_r[ai]) {
				Some(g) => crossed_zones(g, run, run.p_x[ai], run.p_y[ai], run.p_x[bi], run.p_y[bi], run.p_map[ai], run.p_map[bi]),
				None => Vec::new(),
			};
			if self.cross.len() >= 200_000 {
				self.cross.clear();
			}
			self.cross.insert(key, v);
		}
		&self.cross[&key]
	}

	/// Seconds of the direct walk from a to b at speed v for a character of `level`. A pair the
	/// walk store lacks beyond its radius (Walks::radius) has no direct walk (infinite, last_far)
	/// unless `far_ok`: the straight line there may cross a sea (Dustwallow to Feathermoon on
	/// Sardor Isle, 5841 yd) or a range (Emerald Sanctuary to Everlook, 4299 yd); the leg goes by
	/// the network (leg), and only where the network has no way is it walked straight.
	#[allow(clippy::too_many_arguments)]
	fn direct_walk(&mut self, run: &Run, walks: &dyn Walks, a: u32, b: u32, mounted: bool, level: f64, risk: f64, far_ok: bool) -> f64 {
		let v = self.base.speed(mounted);
		self.last_risk = 0.0;
		self.last_short = false;
		self.last_far = false;
		let (ai, bi) = (a as usize, b as usize);
		if run.p_r[ai] != run.p_r[bi] {
			return f64::INFINITY;
		}
		let d = js_hypot(run.p_x[ai] - run.p_x[bi], run.p_y[ai] - run.p_y[bi]);
		let ry = walks.yards(run.pt_list[ai], run.pt_list[bi]).map(|y| y as f32 as f64).filter(|y| *y >= 0.0);
		self.last_walk = match ry {
			Some(y) => (y, 0),
			None => (
				d,
				match run.p_c[ai] {
					0 => 1,
					1 => 2,
					_ => 3,
				},
			),
		};
		if !far_ok && ry.is_none() && walks.radius().is_some_and(|r| d > r) {
			self.last_far = true;
			return f64::INFINITY;
		}
		let r = ry.map(|y| y * self.base.route_mul);
		let mut walk = self.base.foot(r.unwrap_or_else(|| d * detour_of(&self.base.detour, run.p_c[ai])) / v, mounted);
		if r.unwrap_or(d) < SHORT {
			self.last_short = true;
			return walk;
		}
		if risk > 0.0 {
			let mins = self.crossed(run, a, b);
			let mut k = 0;
			while k < mins.len() && mins[k] >= level + DANGER_GAP {
				k += 1;
			}
			if k > 0 {
				walk += k as f64 * risk;
				self.last_risk = k as f64;
			}
		}
		walk
	}

	/// Seconds of the walk from a to b on foot (no network), for a character of `level`.
	pub fn walk_leg(&mut self, run: &Run, walks: &dyn Walks, a: u32, b: u32, mounted: bool, level: f64) -> f64 {
		self.last_risk = 0.0;
		self.last_mode = 0;
		if a == b {
			return 0.0;
		}
		self.direct_walk(run, walks, a, b, mounted, level, self.base.death_risk, false)
	}

	/// Seconds from a to b (run points) with matrix `dm`, for a character of `level`.
	/// Sets last_mode (0 walk, 1 network) and last_risk.
	pub fn leg(&mut self, run: &Run, walks: &dyn Walks, a: u32, b: u32, dm: &[f32], mounted: bool, level: f64) -> f64 {
		self.last_risk = 0.0;
		self.last_nodes = (-1, -1);
		if a == b {
			return 0.0;
		}
		let v = self.base.speed(mounted);
		let walk = self.direct_walk(run, walks, a, b, mounted, level, self.base.death_risk, false);
		if self.last_short {
			self.last_mode = 0;
			return walk;
		}
		let mut best = walk;
		self.last_mode = 0;
		let n = self.base.n;
		let ka = a as usize * NEAR_K;
		let kb = b as usize * NEAR_K;
		let tb = &*self.base;
		for i in 0..NEAR_K {
			let ni = tb.near[ka + i];
			if ni < 0 {
				break;
			}
			let ni = ni as usize;
			let wi = tb.foot(tb.near_walk[ka + i] / v, mounted);
			if wi >= best {
				continue;
			}
			for j in 0..NEAR_K {
				let nj = tb.near[kb + j];
				if nj < 0 {
					break;
				}
				let nj = nj as usize;
				let dn = dm[ni * n + nj] as f64;
				let c = wi + dn + tb.foot(tb.near_walk[kb + j] / v, mounted);
				if c < best {
					// (A path that only walks between nodes is the direct walk's, unless that walk was
					// refused beyond the store's radius: then the nodes are its waypoints.)
					let far = self.last_far;
					if !far && ni == nj {
						continue;
					}
					if !far && run.node_r[ni] == run.node_r[nj] && dn >= tb.node_walk[ni * n + nj] / v - 0.05 {
						continue;
					}
					best = c;
					self.last_mode = 1;
					self.last_nodes = (ni as i32, nj as i32);
				}
			}
		}
		if self.last_mode == 1 {
			self.last_risk = 0.0;
		}
		if !best.is_finite() && self.last_far {
			// No way by the network either: the straight walk, as before the radius rule.
			best = self.direct_walk(run, walks, a, b, mounted, level, self.base.death_risk, true);
			self.last_far = true;
		}
		best
	}
}

/// travel.js crossedZones: minimum levels of the zones a straight line crosses on danger grid
/// g, not counting the end zones za and zb, highest first.
fn crossed_zones(g: &crate::run::DangerGrid, run: &Run, ax: f64, ay: f64, bx: f64, by: f64, za: u32, zb: u32) -> Vec<f64> {
	let dx = bx - ax;
	let dy = by - ay;
	let n = (js_hypot(dx, dy) / g.cell).ceil() as i64;
	let mut seen: Vec<u32> = Vec::new();
	for i in 1..n {
		let gx = ((ax + (dx * i as f64) / n as f64) / g.cell).floor() as i64 - g.gx0;
		let gy = ((ay + (dy * i as f64) / n as f64) / g.cell).floor() as i64 - g.gy0;
		if gx < 0 || gy < 0 || gx >= g.nx || gy >= g.ny {
			continue;
		}
		let z = g.z[(gx * g.ny + gy) as usize];
		if z == 0 || z == za || z == zb || seen.contains(&z) {
			continue;
		}
		seen.push(z);
	}
	let mut mins: Vec<f64> = seen.iter().filter_map(|z| run.zone_min.get(z).copied()).collect();
	mins.sort_by(|x, y| y.partial_cmp(x).unwrap());
	// Int32Array.from: truncated.
	mins.iter().map(|m| m.trunc()).collect()
}
