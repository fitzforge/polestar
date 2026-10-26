//! gen_nav.py's HPA* graph over a CellGrid (pack.js clusterMoves, buildHpa, Heap): regions per
//! cluster, entrances per border group, intra-cluster edges by Dijkstra per profile, pruned.

use super::cells::{CellGrid, SDX, SDY};
use super::{js_round, CLASS, HUB_ALLIANCE, HUB_HORDE, MULTS, NONE, PROFILES, SWIM};
use crate::grid::ADT as T;
use rayon::prelude::*;
use rustc_hash::{FxHashMap, FxHashSet};
use std::f64::consts::SQRT_2;

/// gen_nav.py's 20-cell entrance runs at 67 cells, in yards.
const ENTRANCE_YD: f64 = (20.0 * T) / 67.0;
/// A road crossing a border gets its own entrance unless a chunk entrance is this near its run.
const ROAD_NEAR_YD: f64 = 8.0;
/// Drop an intra edge when a two-hop path is within 2% (and both hops are shorter).
const PRUNE: f64 = 1.02;

/// A graph edge: costs a -> b and b -> a per profile (Alliance, Horde, none), and the yards.
#[derive(Clone, Debug)]
pub struct Edge {
	pub a: u32,
	pub b: u32,
	pub ab: [f64; 3],
	pub ba: [f64; 3],
	pub yab: f64,
	pub yba: f64,
}

/// The HPA graph: per cluster its nodes, and the edges in the JS Map's insertion order.
#[derive(Default)]
pub struct Hpa {
	pub nodes: FxHashMap<u32, FxHashSet<u32>>,
	pub edges: Vec<Edge>,
	pub inter: usize,
}

impl Hpa {
	pub fn node_count(&self) -> usize {
		self.nodes.values().map(|s| s.len()).sum()
	}
}

/// A cluster's local moves (gen_nav.py moves()).
struct Moves {
	n: usize,
	value: Vec<u8>,
	cls: Vec<u8>,
	off: Vec<u32>,
	to: Vec<u32>,
	diag: Vec<bool>,
	gx0: i64,
	gy0: i64,
	floor_start: usize,
	floor_end: usize,
}

impl Moves {
	fn local(&self, cg: &CellGrid, n: u32) -> i64 {
		let nb = cg.nb();
		let c = cg.c as i64;
		if n >= nb {
			let f = (n - nb) as usize;
			return if f >= self.floor_start && f < self.floor_end { (cg.c * cg.c + f - self.floor_start) as i64 } else { -1 };
		}
		let gx = (n as usize / cg.gh) as i64 - self.gx0;
		let gy = (n as usize % cg.gh) as i64 - self.gy0;
		if gx >= 0 && gy >= 0 && gx < c && gy < c {
			gx * c + gy
		} else {
			-1
		}
	}

	fn global(&self, cg: &CellGrid, l: usize) -> u32 {
		let c = cg.c;
		if l < c * c {
			((self.gx0 as usize + l / c) * cg.gh + self.gy0 as usize + l % c) as u32
		} else {
			cg.nb() + (self.floor_start + l - c * c) as u32
		}
	}

	#[inline]
	fn len(&self, q: usize) -> f64 {
		if self.diag[q] {
			SQRT_2
		} else {
			1.0
		}
	}
}

fn cluster_moves(cg: &CellGrid, k: u32) -> Moves {
	let c = cg.c;
	let cl = cg.cluster(k).unwrap();
	let gx0 = (k as usize / cg.ny * c) as i64;
	let gy0 = (k as usize % cg.ny * c) as i64;
	let nf = cl.floor_end - cl.floor_start;
	let n = c * c + nf;
	let mut value = vec![0u8; n];
	value[..c * c].copy_from_slice(&cl.val);
	let mut cls = vec![0u8; n];
	if let Some(cc) = &cl.cls {
		cls[..c * c].copy_from_slice(cc);
	}
	for f in 0..nf {
		value[c * c + f] = cg.floor_val[cl.floor_start + f];
		cls[c * c + f] = cg.floor_class.get(cl.floor_start + f).copied().unwrap_or(0);
	}
	let (val, flags) = (&cl.val, &cl.flags);
	let step = |x: i64, y: i64, dx: i64, dy: i64| -> bool {
		let l = x * c as i64 + y;
		if dx != 0 {
			return val[(l + dx * c as i64) as usize] != 0 && flags[(if dx > 0 { l } else { l - c as i64 }) as usize] & 1 == 0;
		}
		val[(l + dy) as usize] != 0 && flags[(if dy > 0 { l } else { l - 1 }) as usize] & 2 == 0
	};
	let diag = |x: i64, y: i64, dx: i64, dy: i64| -> bool {
		let v = (x + dx) * c as i64 + y + dy;
		if val[v as usize] == 0 {
			return false;
		}
		if (step(x, y, dx, 0) && step(x + dx, y, 0, dy)) || (step(x, y, 0, dy) && step(x, y + dy, dx, 0)) {
			return true;
		}
		flags[(if dx > 0 { x * c as i64 + y } else { v }) as usize] & (if dx * dy > 0 { 4 } else { 8 }) != 0
	};
	let mut mv = Moves { n, value, cls, off: vec![0; n + 1], to: Vec::new(), diag: Vec::new(), gx0, gy0, floor_start: cl.floor_start, floor_end: cl.floor_end };
	let gh = cg.gh as u32;
	for l in 0..n {
		if mv.value[l] != 0 {
			if l < c * c {
				let lx = (l / c) as i64;
				let ly = (l % c) as i64;
				for d in 0..8 {
					let (vx, vy) = (lx + SDX[d] as i64, ly + SDY[d] as i64);
					if vx < 0 || vy < 0 || vx >= c as i64 || vy >= c as i64 {
						continue;
					}
					if if d < 4 { step(lx, ly, SDX[d] as i64, SDY[d] as i64) } else { diag(lx, ly, SDX[d] as i64, SDY[d] as i64) } {
						mv.to.push((vx * c as i64 + vy) as u32);
						mv.diag.push(d >= 4);
					}
				}
			}
			let u = mv.global(cg, l);
			let cu = cg.cell_of(u);
			if let Some(vs) = cg.links.get(&u) {
				for &v in vs {
					let lv = mv.local(cg, v);
					if lv < 0 {
						continue;
					}
					let cv = cg.cell_of(v);
					mv.to.push(lv as u32);
					mv.diag.push(cv / gh != cu / gh && cv % gh != cu % gh);
				}
			}
		}
		mv.off[l + 1] = mv.to.len() as u32;
	}
	mv
}

fn regions_of(mv: &Moves) -> Vec<i32> {
	let mut reg = vec![-1i32; mv.n];
	let mut stack = Vec::new();
	for s in 0..mv.n {
		if mv.value[s] == 0 || reg[s] >= 0 {
			continue;
		}
		reg[s] = s as i32;
		stack.push(s);
		while let Some(u) = stack.pop() {
			for q in mv.off[u] as usize..mv.off[u + 1] as usize {
				let v = mv.to[q] as usize;
				if reg[v] < 0 {
					reg[v] = s as i32;
					stack.push(v);
				}
			}
		}
	}
	reg
}

/// pack.js Heap: a binary min-heap on (key, value) with its exact tie order.
#[derive(Default)]
struct Heap {
	k: Vec<f64>,
	v: Vec<u32>,
	size: usize,
	top: f64,
}

impl Heap {
	fn clear(&mut self) {
		self.size = 0;
	}

	fn push(&mut self, key: f64, val: u32) {
		let mut i = self.size;
		self.size += 1;
		if self.k.len() < self.size {
			self.k.push(0.0);
			self.v.push(0);
		}
		while i > 0 {
			let p = (i - 1) >> 1;
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

	fn pop(&mut self) -> u32 {
		let out = self.v[0];
		self.top = self.k[0];
		self.size -= 1;
		let n = self.size;
		if n > 0 {
			let key = self.k[n];
			let val = self.v[n];
			let mut i = 0;
			loop {
				let mut c = 2 * i + 1;
				if c >= n {
					break;
				}
				if c + 1 < n && self.k[c + 1] < self.k[c] {
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
		}
		out
	}
}

/// A crossing: border position t, diagonal (0/1), the node on this side, the node beyond.
type Crossing = (i64, u8, u32, u32);

/// pack.js buildHpa.
pub fn build_hpa(cg: &CellGrid) -> Hpa {
	let c = cg.c;
	let (nx, ny, gh) = (cg.nx, cg.ny, cg.gh);
	let cs = T / c as f64;
	let run = (js_round(ENTRANCE_YD / cs) as usize).max(1);
	let near = (js_round(ROAD_NEAR_YD / cs) as i64).max(1);
	let is_road = |n: u32| cg.node_class(n) & 7 == CLASS::ROAD;
	let is_dry = |x: &Crossing| cg.node_value(x.2) == 1 && cg.node_value(x.3) == 1;
	let ks = cg.keys_sorted();
	let regions: FxHashMap<u32, (Vec<i32>, i64, i64, usize, usize)> = ks
		.par_iter()
		.map(|&k| {
			let mv = cluster_moves(cg, k);
			(k, (regions_of(&mv), mv.gx0, mv.gy0, mv.floor_start, mv.floor_end))
		})
		.collect();
	let region_of = |n: u32| -> i64 {
		let k = cg.cluster_of_cell(cg.cell_of(n));
		let Some((reg, gx0, gy0, fs, fe)) = regions.get(&k) else { return -1 };
		let nb = cg.nb();
		let l = if n >= nb {
			let f = (n - nb) as usize;
			if f >= *fs && f < *fe {
				(c * c + f - fs) as i64
			} else {
				-1
			}
		} else {
			let gx = (n as usize / gh) as i64 - gx0;
			let gy = (n as usize % gh) as i64 - gy0;
			if gx >= 0 && gy >= 0 && gx < c as i64 && gy < c as i64 {
				gx * c as i64 + gy
			} else {
				-1
			}
		};
		if l < 0 {
			-1
		} else {
			reg[l as usize] as i64
		}
	};
	let mut hpa = Hpa::default();
	let mut index: FxHashMap<(u32, u32), usize> = FxHashMap::default();
	fn set_edge(hpa: &mut Hpa, index: &mut FxHashMap<(u32, u32), usize>, e: Edge) {
		match index.get(&(e.a, e.b)) {
			Some(&i) => hpa.edges[i] = e,
			None => {
				index.insert((e.a, e.b), hpa.edges.len());
				hpa.edges.push(e);
			}
		}
	}
	let add_node = |hpa: &mut Hpa, n: u32| {
		let k = cg.cluster_of_cell(cg.cell_of(n));
		hpa.nodes.entry(k).or_default().insert(n);
	};
	let mults = &*MULTS;
	for &k in &ks {
		let kx = k as usize / ny;
		let ky = k as usize % ny;
		for axis in 0..2 {
			if (axis == 0 && kx + 1 >= nx) || (axis == 1 && ky + 1 >= ny) {
				continue;
			}
			let other = k + if axis == 0 { ny as u32 } else { 1 };
			if cg.cluster(other).is_none() {
				continue;
			}
			let mut groups: Vec<Vec<Crossing>> = Vec::new();
			let mut gidx: FxHashMap<(i64, i64), usize> = FxHashMap::default();
			let mut push = |key: (i64, i64), item: Crossing| {
				let i = *gidx.entry(key).or_insert_with(|| {
					groups.push(Vec::new());
					groups.len() - 1
				});
				groups[i].push(item);
			};
			for t in 0..c as i64 {
				let (kx, ky, c) = (kx as i64, ky as i64, c as i64);
				let (ux, uy, vx, vy) = if axis == 0 { (kx * c + c - 1, ky * c + t, (kx + 1) * c, ky * c + t) } else { (kx * c + t, ky * c + c - 1, kx * c + t, (ky + 1) * c) };
				if cg.value(ux, uy) == 0 {
					continue;
				}
				let u = (ux * gh as i64 + uy) as u32;
				for s in [0i64, -1, 1] {
					if t + s < 0 || t + s >= c {
						continue;
					}
					let (wx, wy) = if axis == 0 { (vx, vy + s) } else { (vx + s, vy) };
					let ok = if s == 0 { cg.step_ok(ux, uy, wx, wy) } else { cg.diag_ok(ux, uy, wx, wy) };
					if ok {
						let w = (wx * gh as i64 + wy) as u32;
						push((region_of(u), region_of(w)), (t, s.unsigned_abs() as u8, u, w));
					}
				}
			}
			for &u in cg.linked_of.get(&k).map(Vec::as_slice).unwrap_or(&[]) {
				let cu = cg.cell_of(u) as usize;
				let (ux, uy) = (cu / gh, cu % gh);
				for &w in &cg.links[&u] {
					let cw = cg.cell_of(w);
					if cg.cluster_of_cell(cw) != other {
						continue;
					}
					let (wx, wy) = (cw as usize / gh, cw as usize % gh);
					let t = if axis == 0 { uy as i64 - (ky * c) as i64 } else { ux as i64 - (kx * c) as i64 };
					push((region_of(u), region_of(w)), (t, (wx != ux && wy != uy) as u8, u, w));
				}
			}
			let pick = |list: &[Crossing]| -> Crossing {
				let mid = list[list.len() >> 1].0;
				let mut best = list[0];
				for &x in list {
					if x.1 < best.1 || (x.1 == best.1 && (x.0 - mid).abs() < (best.0 - mid).abs()) {
						best = x;
					}
				}
				best
			};
			let mut place = |hpa: &mut Hpa, x: Crossing| {
				let (_, diagonal, u, v) = x;
				let len = cs * if diagonal != 0 { SQRT_2 } else { 1.0 };
				let into = |w: u32| -> [f64; 3] {
					let (cl, swim) = (cg.node_class(w) as usize, if cg.node_value(w) == 2 { SWIM } else { 1.0 });
					[len * mults[0][cl] * swim, len * mults[1][cl] * swim, len * mults[2][cl] * swim]
				};
				set_edge(hpa, &mut index, Edge { a: u, b: v, ab: into(v), ba: into(u), yab: len, yba: len });
				add_node(hpa, u);
				add_node(hpa, v);
			};
			for mut crossings in groups {
				crossings.sort();
				let mut placed: Vec<Crossing> = Vec::new();
				let mut i = 0;
				while i < crossings.len() {
					let best = pick(&crossings[i..(i + run).min(crossings.len())]);
					placed.push(best);
					place(&mut hpa, best);
					i += run;
				}
				let roads: Vec<Crossing> = crossings.iter().copied().filter(|x| is_road(x.2) && is_road(x.3)).collect();
				let mut on_roads = Vec::new();
				let mut i = 0;
				while i < roads.len() {
					let mut j = i + 1;
					while j < roads.len() && roads[j].0 - roads[j - 1].0 <= 1 {
						j += 1;
					}
					let (t0, t1) = (roads[i].0 - near, roads[j - 1].0 + near);
					if !placed.iter().any(|x| x.0 >= t0 && x.0 <= t1) {
						let best = pick(&roads[i..j]);
						on_roads.push(best);
						place(&mut hpa, best);
					}
					i = j;
				}
				placed.extend(on_roads);
				let drys: Vec<Crossing> = crossings.iter().copied().filter(is_dry).collect();
				let mut i = 0;
				while i < drys.len() {
					let mut j = i + 1;
					while j < drys.len() && drys[j].0 - drys[j - 1].0 <= 1 {
						j += 1;
					}
					let (t0, t1) = (drys[i].0, drys[j - 1].0);
					if !placed.iter().any(|x| is_dry(x) && x.0 >= t0 && x.0 <= t1) {
						place(&mut hpa, pick(&drys[i..j]));
					}
					i = j;
				}
			}
		}
	}
	hpa.inter = hpa.edges.len();
	// Intra-cluster edges, per cluster in parallel, inserted in cluster order.
	let mut nk: Vec<u32> = hpa.nodes.keys().copied().collect();
	nk.sort_unstable();
	let intra: Vec<Vec<Edge>> = nk
		.par_iter()
		.map_init(Heap::default, |heap, &k| {
			let mut el: Vec<u32> = hpa.nodes[&k].iter().copied().collect();
			el.sort_unstable();
			intra_edges(cg, k, &el, heap)
		})
		.collect();
	for list in intra {
		for e in list {
			set_edge(&mut hpa, &mut index, e);
		}
	}
	hpa
}

fn intra_edges(cg: &CellGrid, k: u32, el: &[u32], heap: &mut Heap) -> Vec<Edge> {
	let mv = cluster_moves(cg, k);
	let cs = T / cg.c as f64;
	let n = el.len();
	let mut target = vec![-1i32; mv.n];
	for (i, &g) in el.iter().enumerate() {
		target[mv.local(cg, g) as usize] = i as i32;
	}
	let hub_bits = mv.cls.iter().fold(0u8, |a, &b| a | b);
	let priced: Vec<bool> = PROFILES.iter().enumerate().map(|(i, p)| i == NONE || hub_bits & (if *p == Some("Alliance") { HUB_HORDE } else { HUB_ALLIANCE }) != 0).collect();
	// dists[p]: an index into tables (an unpriced profile shares none's).
	let mut tables: Vec<Vec<f64>> = Vec::new();
	let mut dist_of = [0usize; 3];
	let mut yards = vec![f64::INFINITY; n * n];
	let mut gd = vec![0f64; mv.n];
	let mut gy = vec![0f64; mv.n];
	let mults = &*MULTS;
	for p in (0..=NONE).rev() {
		if !priced[p] {
			dist_of[p] = dist_of[NONE];
			continue;
		}
		let mut d = vec![f64::INFINITY; n * n];
		let mt = &mults[p];
		for s in 0..n {
			gd.fill(f64::INFINITY);
			let src = mv.local(cg, el[s]) as usize;
			gd[src] = 0.0;
			gy[src] = 0.0;
			heap.clear();
			heap.push(0.0, src as u32);
			let mut left = n - 1;
			while heap.size > 0 && left > 0 {
				let u = heap.pop() as usize;
				let du = heap.top;
				if du > gd[u] {
					continue;
				}
				let tu = target[u];
				if u != src && tu >= 0 && d[s * n + tu as usize] == f64::INFINITY {
					d[s * n + tu as usize] = du;
					if p == NONE {
						yards[s * n + tu as usize] = gy[u];
					}
					left -= 1;
				}
				for q in mv.off[u] as usize..mv.off[u + 1] as usize {
					let v = mv.to[q] as usize;
					let step = mv.len(q) * cs;
					let cost = du + step * mt[mv.cls[v] as usize] * if mv.value[v] == 2 { SWIM } else { 1.0 };
					if cost < gd[v] {
						gd[v] = cost;
						gy[v] = gy[u] + step;
						heap.push(cost, v as u32);
					}
				}
			}
		}
		dist_of[p] = tables.len();
		tables.push(d);
	}
	let pruned = |a: usize, b: usize| -> bool {
		tables.iter().all(|t| {
			let d = t[a * n + b];
			(0..n).any(|x| x != a && x != b && t[a * n + x] < d && t[x * n + b] < d && t[a * n + x] + t[x * n + b] <= d * PRUNE)
		})
	};
	let none = &tables[dist_of[NONE]];
	let mut out = Vec::new();
	for a in 0..n {
		for b in a + 1..n {
			if none[a * n + b] == f64::INFINITY || none[b * n + a] == f64::INFINITY {
				continue;
			}
			if pruned(a, b) && pruned(b, a) {
				continue;
			}
			let at = |i: usize, j: usize| [tables[dist_of[0]][i * n + j], tables[dist_of[1]][i * n + j], tables[dist_of[2]][i * n + j]];
			out.push(Edge { a: el[a], b: el[b], ab: at(a, b), ba: at(b, a), yab: yards[a * n + b], yba: yards[b * n + a] });
		}
	}
	out
}
