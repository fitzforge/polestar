//! Queries on a customized CCH. A place is attached to the coarse graph by several nodes at once
//! (its tile's entrances, each with the leg's cost and yards: Node's fine search), so every search
//! is a multi-seed elimination-tree search: the union of the seeds' ancestor paths, scanned in
//! rank order. A pair's cost is the minimum over the meeting nodes of forward + backward;
//! tables run one forward search per source against every target's stored backward search, on
//! threads; a path is unpacked through the arcs' middle nodes into coarse graph nodes.

use crate::cch::metric::Metric;
use crate::cch::structure::{Structure, A, INVALID};
use rayon::prelude::*;

/// One attachment of a place: an external node id, the leg's cost and yards.
#[derive(Clone, Copy)]
pub struct Seed {
	pub node: u32,
	pub cost: f64,
	pub yards: f64,
}

pub struct Search {
	dist: Vec<f64>,
	yd: Vec<f64>,
	pred: Vec<u32>,
	seed: Vec<u32>,
	stamp: Vec<u32>,
	gen: u32,
	pub visited: Vec<u32>,
}

impl Search {
	pub fn new(n: usize) -> Search {
		Search { dist: vec![0.0; n], yd: vec![0.0; n], pred: vec![INVALID; n], seed: vec![INVALID; n], stamp: vec![0; n], gen: 0, visited: Vec::new() }
	}

	/// forward: the seeds are sources (costs leave them); else targets (costs reach them).
	pub fn run(&mut self, s: &Structure, m: &Metric, seeds: &[Seed], forward: bool) {
		let rank = s.a(A::Rank);
		let parent = s.a(A::ElimParent);
		let ufo = s.a(A::UpFirstOut);
		let uh = s.a(A::UpHead);
		self.gen = self.gen.wrapping_add(1);
		if self.gen == 0 {
			self.stamp.iter_mut().for_each(|x| *x = 0);
			self.gen = 1;
		}
		let gen = self.gen;
		self.visited.clear();
		for sd in seeds {
			let mut x = rank[sd.node as usize];
			while x != INVALID && self.stamp[x as usize] != gen {
				self.stamp[x as usize] = gen;
				self.dist[x as usize] = f64::INFINITY;
				self.pred[x as usize] = INVALID;
				self.seed[x as usize] = INVALID;
				self.visited.push(x);
				x = parent[x as usize];
			}
		}
		for (i, sd) in seeds.iter().enumerate() {
			let x = rank[sd.node as usize] as usize;
			if sd.cost < self.dist[x] {
				self.dist[x] = sd.cost;
				self.yd[x] = sd.yards;
				self.seed[x] = i as u32;
			}
		}
		self.visited.sort_unstable();
		let (cost, yds) = if forward { (&m.fwd, &m.yf) } else { (&m.bwd, &m.yb) };
		let has_yd = !yds.is_empty();
		for &v in &self.visited {
			let d = self.dist[v as usize];
			if d == f64::INFINITY {
				continue;
			}
			let y = self.yd[v as usize];
			for a in ufo[v as usize] as usize..ufo[v as usize + 1] as usize {
				let w = uh[a] as usize;
				let nd = d + cost[a];
				if nd < self.dist[w] {
					self.dist[w] = nd;
					self.yd[w] = if has_yd { y + yds[a] as f64 } else { 0.0 };
					self.pred[w] = a as u32;
					self.seed[w] = INVALID;
				}
			}
		}
	}

	#[inline]
	fn get(&self, x: u32) -> Option<(f64, f64)> {
		if self.stamp[x as usize] == self.gen {
			let d = self.dist[x as usize];
			if d < f64::INFINITY {
				return Some((d, self.yd[x as usize]));
			}
		}
		None
	}
}

/// A target's backward search, kept: (node, cost, yards) by node.
pub struct Back {
	nodes: Vec<u32>,
	cost: Vec<f64>,
	yards: Vec<f64>,
	/// The arc each node was reached by (INVALID at a seed) and the seed index there.
	pred: Vec<u32>,
	seed: Vec<u32>,
}

fn back_of(sr: &Search) -> Back {
	let mut b = Back { nodes: Vec::new(), cost: Vec::new(), yards: Vec::new(), pred: Vec::new(), seed: Vec::new() };
	for &v in &sr.visited {
		if let Some((d, y)) = sr.get(v) {
			b.nodes.push(v);
			b.cost.push(d);
			b.yards.push(y);
			b.pred.push(sr.pred[v as usize]);
			b.seed.push(sr.seed[v as usize]);
		}
	}
	b
}

/// Each graph edge's yards per zone cell (cch.js prepareYards' .cells file), memory-mapped:
/// u32 E, u32 off[E + 1], u32 key[M], f32 yards[M].
pub struct EdgeCells {
	map: memmap2::Mmap,
	e: usize,
	m: usize,
}

impl EdgeCells {
	pub fn open(path: &std::path::Path) -> std::io::Result<EdgeCells> {
		let f = std::fs::File::open(path)?;
		let map = unsafe { memmap2::Mmap::map(&f)? };
		let bad = || std::io::Error::new(std::io::ErrorKind::InvalidData, format!("{}: not an edge cells file", path.display()));
		if map.len() < 8 {
			return Err(bad());
		}
		let e = u32::from_le_bytes(map[0..4].try_into().unwrap()) as usize;
		if map.len() < 4 * (e + 2) {
			return Err(bad());
		}
		let m = u32::from_le_bytes(map[4 * (e + 1)..4 * (e + 2)].try_into().unwrap()) as usize;
		if map.len() != 4 * (e + 2) + 8 * m {
			return Err(bad());
		}
		Ok(EdgeCells { map, e, m })
	}

	pub fn edges(&self) -> usize {
		self.e
	}

	pub fn off(&self) -> &[u32] {
		unsafe { std::slice::from_raw_parts(self.map.as_ptr().add(4) as *const u32, self.e + 1) }
	}

	pub fn keys(&self) -> &[u32] {
		unsafe { std::slice::from_raw_parts(self.map.as_ptr().add(4 * (self.e + 2)) as *const u32, self.m) }
	}

	pub fn yards(&self) -> &[f32] {
		unsafe { std::slice::from_raw_parts(self.map.as_ptr().add(4 * (self.e + 2) + 4 * self.m) as *const f32, self.m) }
	}
}

/// The input edge customization initialized arc `a`'s up (or down) cost from: the cheapest of its
/// parallel edges that way.
fn input_edge(s: &Structure, m: &Metric, a: usize, up: bool) -> u32 {
	let (first, ef, ex) = if up { (s.a(A::FwdIn), s.a(A::FirstExtraFwd), s.a(A::ExtraFwd)) } else { (s.a(A::BwdIn), s.a(A::FirstExtraBwd), s.a(A::ExtraBwd)) };
	let mut best = first[a];
	let mut bw = if best == INVALID { f64::INFINITY } else { m.w[best as usize] };
	for k in ef[a] as usize..ef[a + 1] as usize {
		let e = ex[k];
		if m.w[e as usize] < bw {
			bw = m.w[e as usize];
			best = e;
		}
	}
	best
}

/// The input edges of arc `a` traversed up (tail → head) or down, in order, appended to `out`.
fn unpack_edges(s: &Structure, m: &Metric, a: u32, up: bool, out: &mut Vec<u32>, stack: &mut Vec<(u32, bool)>) {
	let ufo = s.a(A::UpFirstOut);
	let uh = s.a(A::UpHead);
	let ut = s.a(A::UpTail);
	stack.clear();
	stack.push((a, up));
	while let Some((a, up)) = stack.pop() {
		let (t, h) = (ut[a as usize], uh[a as usize]);
		let mid = if up { m.mf[a as usize] } else { m.mb[a as usize] };
		if mid == INVALID {
			out.push(input_edge(s, m, a as usize, up));
			continue;
		}
		let low_t = s.find_arc(ufo, uh, mid, t);
		let low_h = s.find_arc(ufo, uh, mid, h);
		if up {
			stack.push((low_h, true));
			stack.push((low_t, false));
		} else {
			stack.push((low_t, true));
			stack.push((low_h, false));
		}
	}
}

/// rows() with each pair's way: the source and target seed it leaves and reaches, and its yards per
/// zone cell over the graph edges (the legs are the caller's). Cells CSR over the listed pairs.
pub struct RowsCells {
	pub cost: Vec<f64>,
	pub yards: Vec<f64>,
	pub from: Vec<u32>,
	pub to: Vec<u32>,
	pub cells_off: Vec<u32>,
	pub cells_key: Vec<u32>,
	pub cells_yards: Vec<f64>,
}

/// The cost and yards of every (source, target) pair (row-major, -1 where unreachable). Sources
/// and targets: their seeds, as CSR (off, seeds).
pub fn table(s: &Structure, m: &Metric, src_off: &[u32], src: &[Seed], dst_off: &[u32], dst: &[Seed]) -> (Vec<f64>, Vec<f64>) {
	let ns = src_off.len() - 1;
	let nt = dst_off.len() - 1;
	let n = s.node_count;
	let backs: Vec<Back> = (0..nt)
		.into_par_iter()
		.map_init(
			|| Search::new(n),
			|sr, t| {
				sr.run(s, m, &dst[dst_off[t] as usize..dst_off[t + 1] as usize], false);
				back_of(sr)
			},
		)
		.collect();
	let mut cost = vec![-1.0; ns * nt];
	let mut yards = vec![-1.0; ns * nt];
	cost.par_chunks_mut(nt).zip(yards.par_chunks_mut(nt)).enumerate().for_each_init(
		|| Search::new(n),
		|sr, (i, (crow, yrow))| {
			let seeds = &src[src_off[i] as usize..src_off[i + 1] as usize];
			if seeds.is_empty() {
				return;
			}
			sr.run(s, m, seeds, true);
			for (t, b) in backs.iter().enumerate() {
				let mut best = f64::INFINITY;
				let mut by = 0.0;
				for k in 0..b.nodes.len() {
					if let Some((d, y)) = sr.get(b.nodes[k]) {
						let c = d + b.cost[k];
						if c < best {
							best = c;
							by = y + b.yards[k];
						}
					}
				}
				if best < f64::INFINITY {
					crow[t] = best;
					yrow[t] = by;
				}
			}
		},
	);
	(cost, yards)
}

/// Rows: source i to its own targets row_dst[row_off[i]..row_off[i + 1]] (indices into the targets),
/// each distinct target searched backward once. -> cost and yards per listed pair (-1 none).
pub fn rows(s: &Structure, m: &Metric, src_off: &[u32], src: &[Seed], dst_off: &[u32], dst: &[Seed], row_off: &[u32], row_dst: &[u32]) -> (Vec<f64>, Vec<f64>) {
	let ns = src_off.len() - 1;
	let nt = dst_off.len() - 1;
	let n = s.node_count;
	let mut used = vec![false; nt];
	for &t in row_dst {
		used[t as usize] = true;
	}
	let backs: Vec<Option<Back>> = (0..nt)
		.into_par_iter()
		.map_init(
			|| Search::new(n),
			|sr, t| {
				if !used[t] {
					return None;
				}
				sr.run(s, m, &dst[dst_off[t] as usize..dst_off[t + 1] as usize], false);
				Some(back_of(sr))
			},
		)
		.collect();
	let mut cost = vec![-1.0; row_dst.len()];
	let mut yards = vec![-1.0; row_dst.len()];
	// Split the outputs by row so every source writes its own slices.
	let mut cs: Vec<&mut [f64]> = Vec::with_capacity(ns);
	let mut ys: Vec<&mut [f64]> = Vec::with_capacity(ns);
	{
		let (mut c, mut y) = (&mut cost[..], &mut yards[..]);
		for i in 0..ns {
			let len = (row_off[i + 1] - row_off[i]) as usize;
			let (a, b) = std::mem::take(&mut c).split_at_mut(len);
			let (d, e) = std::mem::take(&mut y).split_at_mut(len);
			cs.push(a);
			ys.push(d);
			c = b;
			y = e;
		}
	}
	cs.into_par_iter().zip(ys).enumerate().for_each_init(
		|| Search::new(n),
		|sr, (i, (crow, yrow))| {
			let seeds = &src[src_off[i] as usize..src_off[i + 1] as usize];
			if seeds.is_empty() || crow.is_empty() {
				return;
			}
			sr.run(s, m, seeds, true);
			for (k, &t) in row_dst[row_off[i] as usize..row_off[i + 1] as usize].iter().enumerate() {
				let b = backs[t as usize].as_ref().unwrap();
				let mut best = f64::INFINITY;
				let mut by = 0.0;
				for x in 0..b.nodes.len() {
					if let Some((d, y)) = sr.get(b.nodes[x]) {
						let c = d + b.cost[x];
						if c < best {
							best = c;
							by = y + b.yards[x];
						}
					}
				}
				if best < f64::INFINITY {
					crow[k] = best;
					yrow[k] = by;
				}
			}
		},
	);
	(cost, yards)
}
pub fn rows_cells(s: &Structure, m: &Metric, cells: &EdgeCells, src_off: &[u32], src: &[Seed], dst_off: &[u32], dst: &[Seed], row_off: &[u32], row_dst: &[u32]) -> RowsCells {
	let ns = src_off.len() - 1;
	let nt = dst_off.len() - 1;
	let n = s.node_count;
	let mut used = vec![false; nt];
	for &t in row_dst {
		used[t as usize] = true;
	}
	let backs: Vec<Option<Back>> = (0..nt)
		.into_par_iter()
		.map_init(
			|| Search::new(n),
			|sr, t| {
				if !used[t] {
					return None;
				}
				sr.run(s, m, &dst[dst_off[t] as usize..dst_off[t + 1] as usize], false);
				Some(back_of(sr))
			},
		)
		.collect();
	let ut = s.a(A::UpTail);
	let (coff, ckey, cyd) = (cells.off(), cells.keys(), cells.yards());
	// One part per source row: (cost, yards, from, to, per pair cell count, keys, yards).
	type Part = (Vec<f64>, Vec<f64>, Vec<u32>, Vec<u32>, Vec<u32>, Vec<u32>, Vec<f64>);
	let parts: Vec<Part> = (0..ns)
		.into_par_iter()
		.map_init(
			|| (Search::new(n), Vec::new(), Vec::new(), Vec::new()),
			|(sr, edges, stack, acc), i| {
				let row = &row_dst[row_off[i] as usize..row_off[i + 1] as usize];
				let mut p: Part = (vec![-1.0; row.len()], vec![-1.0; row.len()], vec![0; row.len()], vec![0; row.len()], vec![0; row.len()], Vec::new(), Vec::new());
				let seeds = &src[src_off[i] as usize..src_off[i + 1] as usize];
				if seeds.is_empty() || row.is_empty() {
					return p;
				}
				sr.run(s, m, seeds, true);
				for (k, &t) in row.iter().enumerate() {
					let b = backs[t as usize].as_ref().unwrap();
					let mut best = f64::INFINITY;
					let mut bi = usize::MAX;
					let mut by = 0.0;
					for x in 0..b.nodes.len() {
						if let Some((d, y)) = sr.get(b.nodes[x]) {
							let c = d + b.cost[x];
							if c < best {
								best = c;
								bi = x;
								by = y + b.yards[x];
							}
						}
					}
					if bi == usize::MAX {
						continue;
					}
					p.0[k] = best;
					p.1[k] = by;
					// The way: up from the source seed to the meeting node, down to the target seed.
					edges.clear();
					let meet = b.nodes[bi];
					let mut ups: Vec<u32> = Vec::new();
					let mut x = meet;
					while sr.pred[x as usize] != INVALID {
						let a = sr.pred[x as usize];
						ups.push(a);
						x = ut[a as usize];
					}
					p.2[k] = sr.seed[x as usize];
					for &a in ups.iter().rev() {
						unpack_edges(s, m, a, true, edges, stack);
					}
					let mut y = bi;
					while b.pred[y] != INVALID {
						let a = b.pred[y];
						unpack_edges(s, m, a, false, edges, stack);
						let next = ut[a as usize];
						y = b.nodes.binary_search(&next).unwrap();
					}
					p.3[k] = b.seed[y];
					acc.clear();
					for &e in edges.iter() {
						for c in coff[e as usize] as usize..coff[e as usize + 1] as usize {
							acc.push((ckey[c], cyd[c] as f64));
						}
					}
					acc.sort_unstable_by_key(|v: &(u32, f64)| v.0);
					let mut cnt = 0;
					let mut q = 0;
					while q < acc.len() {
						let key = acc[q].0;
						let mut sum = 0.0;
						while q < acc.len() && acc[q].0 == key {
							sum += acc[q].1;
							q += 1;
						}
						p.5.push(key);
						p.6.push(sum);
						cnt += 1;
					}
					p.4[k] = cnt;
				}
				p
			},
		)
		.collect();
	let mut r = RowsCells {
		cost: Vec::with_capacity(row_dst.len()),
		yards: Vec::with_capacity(row_dst.len()),
		from: Vec::with_capacity(row_dst.len()),
		to: Vec::with_capacity(row_dst.len()),
		cells_off: vec![0],
		cells_key: Vec::new(),
		cells_yards: Vec::new(),
	};
	for p in parts {
		r.cost.extend(p.0);
		r.yards.extend(p.1);
		r.from.extend(p.2);
		r.to.extend(p.3);
		for c in p.4 {
			let last = *r.cells_off.last().unwrap();
			r.cells_off.push(last + c);
		}
		r.cells_key.extend(p.5);
		r.cells_yards.extend(p.6);
	}
	r
}

pub struct PathResult {
	pub cost: f64,
	pub yards: f64,
	/// Index of the source seed and the target seed the path leaves and reaches.
	pub from: u32,
	pub to: u32,
	/// External coarse node ids from the source seed's node to the target seed's node.
	pub nodes: Vec<u32>,
}

/// Unpacks arc `a` traversed up (tail → head) or down (head → tail), appending the nodes after
/// its first (internal ids).
fn unpack(s: &Structure, m: &Metric, a: u32, up: bool, out: &mut Vec<u32>) {
	let ufo = s.a(A::UpFirstOut);
	let uh = s.a(A::UpHead);
	let ut = s.a(A::UpTail);
	let mut stack = vec![(a, up)];
	while let Some((a, up)) = stack.pop() {
		let (t, h) = (ut[a as usize], uh[a as usize]);
		let mid = if up { m.mf[a as usize] } else { m.mb[a as usize] };
		if mid == INVALID {
			out.push(if up { h } else { t });
			continue;
		}
		let low_t = s.find_arc(ufo, uh, mid, t);
		let low_h = s.find_arc(ufo, uh, mid, h);
		// up: t → mid (arc (mid, t) down), mid → h (arc (mid, h) up); down: h → mid, mid → t.
		if up {
			stack.push((low_h, true));
			stack.push((low_t, false));
		} else {
			stack.push((low_t, true));
			stack.push((low_h, false));
		}
	}
}

/// The way from `src` to every target (one forward search, a backward search per target).
pub fn paths(s: &Structure, m: &Metric, fw: &mut Search, bw: &mut Search, src: &[Seed], dst_off: &[u32], dst: &[Seed]) -> Vec<Option<PathResult>> {
	fw.run(s, m, src, true);
	(0..dst_off.len() - 1).map(|t| meet(s, m, fw, bw, &dst[dst_off[t] as usize..dst_off[t + 1] as usize])).collect()
}

pub fn path(s: &Structure, m: &Metric, fw: &mut Search, bw: &mut Search, src: &[Seed], dst: &[Seed]) -> Option<PathResult> {
	fw.run(s, m, src, true);
	meet(s, m, fw, bw, dst)
}

/// With fw run from the sources: the target's backward search, the best meeting node, the way unpacked.
fn meet(s: &Structure, m: &Metric, fw: &Search, bw: &mut Search, dst: &[Seed]) -> Option<PathResult> {
	if dst.is_empty() {
		return None;
	}
	bw.run(s, m, dst, false);
	let mut best = f64::INFINITY;
	let mut meet = INVALID;
	let mut by = 0.0;
	for &v in &fw.visited {
		if let (Some((d, y)), Some((e, z))) = (fw.get(v), bw.get(v)) {
			if d + e < best {
				best = d + e;
				meet = v;
				by = y + z;
			}
		}
	}
	if meet == INVALID {
		return None;
	}
	let ut = s.a(A::UpTail);
	let order = s.a(A::Order);
	// Up part: arcs from the source seed to meet.
	let mut ups = Vec::new();
	let mut x = meet;
	while fw.pred[x as usize] != INVALID {
		let a = fw.pred[x as usize];
		ups.push(a);
		x = ut[a as usize];
	}
	let from = fw.seed[x as usize];
	let mut nodes = vec![x];
	for &a in ups.iter().rev() {
		unpack(s, m, a, true, &mut nodes);
	}
	let mut y = meet;
	while bw.pred[y as usize] != INVALID {
		let a = bw.pred[y as usize];
		unpack(s, m, a, false, &mut nodes);
		y = ut[a as usize];
	}
	let to = bw.seed[y as usize];
	Some(PathResult { cost: best, yards: by, from, to, nodes: nodes.into_iter().map(|v| order[v as usize]).collect() })
}
