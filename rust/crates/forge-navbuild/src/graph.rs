//! The abstract graph the route search runs over first (port of tools/lib/nav/grid/graph.js):
//! nodes at tile borders, edges between a tile's nodes inside the tile, costed per reference
//! profile (format.js REF_PROFILES), and the links across borders.
//!
//! Entrances: every link (or fall) between tiles T and N gives a pair (entry in T, entry in N).
//! Pairs of one border group into runs (pairs whose ends are neighbouring columns on both sides
//! at close heights), cut every RUN_MAX; a chunk's entrance is its middle pair crossing both ways
//! (else the middle one-way pair of each direction), whose two entries are nodes of their tiles.
//! Both tiles find the same pairs, order them the same way and so pick the same entrances.
//!
//! tile_graph(around) works on one tile and its 3 x 3 neighbourhood (linked, with components);
//! assemble_graph joins every tile's part into the continent's graph (GRAPH) and its regions.

use crate::fmath;
use crate::format::{cls, flag, Graph, GraphProfile, GraphTile, Tile, CODE_LIFT, DIRS, FALL_SLIDE, NO_COMP, NO_LINK, REF_PROFILES, RUN_MAX, TILE_CELLS};
use crate::moves::{add_link_terms, fall_seconds, lift_seconds, refs};
use crate::regions::join_regions;
use crate::search::{MinHeap, Space};
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::Value;

/// Border columns whose links and falls may leave the tile.
const BAND: usize = FALL_SLIDE + 1;
pub const TERM_SCALE: [f64; 7] = [4.0, 4.0, 4.0, 1.0, 10.0, 1.0, 10.0];

type Terms = [f64; 7];

fn quantise(terms: &Terms) -> Terms {
	std::array::from_fn(|i| fmath::min(65535.0, fmath::round(terms[i] * TERM_SCALE[i])))
}

/// Terms of one step: code (stored link code, CLS.FALL or CODE_LIFT), flags, length, height.
fn step_terms(out: &mut Terms, code: u8, fa: u8, fb: u8, d: f64, h: f64) {
	if code == cls::FALL {
		out[4] += fall_seconds(h, fb & flag::SWIM != 0);
	} else if code == CODE_LIFT {
		out[6] += lift_seconds(h);
	} else {
		add_link_terms(out, code, fa, fb, d);
	}
}

fn in_band(k: usize) -> bool {
	let i = k & 255;
	let j = k >> 8;
	i < BAND || j < BAND || i >= TILE_CELLS - BAND || j >= TILE_CELLS - BAND
}

/// Entries e (column k) and e2 (column k2) of one tile: the same, or linked either way.
fn joined(t: &Tile, e: u32, k: u32, e2: u32, k2: u32) -> bool {
	if e == e2 {
		return true;
	}
	let dx = (k2 & 255) as i32 - (k & 255) as i32;
	let dy = (k2 >> 8) as i32 - (k >> 8) as i32;
	if dx.abs() > 1 || dy.abs() > 1 {
		return false;
	}
	let links = t.links.as_ref().unwrap();
	for (d, dir) in DIRS.iter().enumerate() {
		if dir[0] != dx || dir[1] != dy {
			continue;
		}
		let back = (d + 4) & 7;
		let a = links[e as usize * 8 + d];
		let b = links[e2 as usize * 8 + back];
		return (a != NO_LINK && t.first[k2 as usize] + u32::from(a & 31) == e2) || (b != NO_LINK && t.first[k as usize] + u32::from(b & 31) == e);
	}
	false
}

/// One tile's part of the abstract graph (the .hpa.gz JSON).
#[derive(Clone, Debug, Default)]
pub struct Part {
	pub col: i32,
	pub row: i32,
	pub n_comp: u32,
	pub comp_size: Vec<u32>,
	pub nodes: Vec<u32>,
	pub node_k: Vec<u32>,
	pub node_z: Vec<f64>,
	/// [local node, dc, dr, entry in N, 7 terms].
	pub cross: Vec<(u32, i32, i32, u32, Terms)>,
	/// Per reference profile: [a, b, 7 terms].
	pub intra: [Vec<(u32, u32, Terms)>; 2],
	/// Triples ct, nIdx, cn.
	pub pairs: Vec<u32>,
	/// [entry, comp].
	pub lifts: Vec<(u32, u32)>,
}

#[derive(Clone, Debug)]
struct Pair {
	e_t: u32,
	k_t: u32,
	e_n: u32,
	k_n: u32,
	dir: u8,
	step: Option<(u8, f64, f64)>,
}

/// around: 3 x 3 linked tiles, index (drow + 1) * 3 + (dcol + 1), centre at 4 (its `lifts` set
/// for its lift rides); lift_entries: the entries of the tile lifts start from.
pub fn tile_graph(around: &[Option<&Tile>; 9], lift_entries: &[u32]) -> Part {
	let tt = around[4].expect("the centre tile");
	let comp_t = tt.comp.as_ref().expect("a tile with components");
	let order: Vec<usize> = [4usize, 0, 1, 2, 3, 5, 6, 7, 8].into_iter().filter(|&x| around[x].is_some()).collect();
	let tiles: Vec<&Tile> = order.iter().map(|&x| around[x].unwrap()).collect();
	let mut space = Space::new(&tiles);
	let [foot, mount] = refs();
	// Pairs per neighbour (around index), in insertion order.
	let mut borders: Vec<(usize, Vec<Pair>, FxHashMap<(u32, u32), usize>)> = Vec::new();
	let add_pair = |borders: &mut Vec<(usize, Vec<Pair>, FxHashMap<(u32, u32), usize>)>, n_idx: usize, e_t: u32, k_t: u32, e_n: u32, k_n: u32, dir: u8, step: Option<(u8, f64, f64)>| {
		let bi = match borders.iter().position(|b| b.0 == n_idx) {
			Some(i) => i,
			None => {
				borders.push((n_idx, Vec::new(), FxHashMap::default()));
				borders.len() - 1
			}
		};
		let b = &mut borders[bi];
		let pi = match b.2.get(&(e_t, e_n)) {
			Some(&i) => i,
			None => {
				b.1.push(Pair { e_t, k_t, e_n, k_n, dir: 0, step: None });
				b.2.insert((e_t, e_n), b.1.len() - 1);
				b.1.len() - 1
			}
		};
		let p = &mut b.1[pi];
		p.dir |= dir;
		if step.is_some() {
			p.step = step;
		}
	};
	for slot in 0..order.len() {
		let t = tiles[slot];
		let own = order[slot];
		for k in 0..TILE_CELLS * TILE_CELLS {
			if !in_band(k) {
				continue;
			}
			for e in t.first[k] as usize..t.first[k + 1] as usize {
				if t.flags[e] & flag::BLOCKED != 0 {
					continue;
				}
				space.expand(slot, e, k, &foot);
				let outs = space.out.clone();
				for o in outs {
					if o.code == CODE_LIFT {
						continue;
					}
					let s2 = space.slot_of(o.to);
					if s2 == slot {
						continue;
					}
					let other = order[s2];
					let v = (o.to - space.base[s2]) as u32;
					if slot == 0 {
						add_pair(&mut borders, other, e as u32, k as u32, v, o.k as u32, 1, Some((o.code, o.d, o.h)));
					} else if s2 == 0 {
						add_pair(&mut borders, own, v, o.k as u32, e as u32, k as u32, 2, None);
					}
				}
			}
		}
	}
	let mut node_set: FxHashSet<u32> = FxHashSet::default();
	struct Rep {
		n_idx: usize,
		dc: i32,
		dr: i32,
		rep: Pair,
	}
	let mut reps: Vec<Rep> = Vec::new();
	let mut pairs: Vec<(u32, usize, u32)> = Vec::new();
	let mut pair_seen: FxHashSet<(u32, usize, u32)> = FxHashSet::default();
	for (n_idx, list0, _) in &borders {
		let n_idx = *n_idx;
		let nn = around[n_idx].unwrap();
		let comp_n = nn.comp.as_ref().unwrap();
		let t_first = tt.row * 64 + tt.col < nn.row * 64 + nn.col;
		let mut list = list0.clone();
		for p in &list {
			let ct = comp_t[p.e_t as usize];
			let cn = comp_n[p.e_n as usize];
			if ct != NO_COMP && cn != NO_COMP && pair_seen.insert((ct, n_idx, cn)) {
				pairs.push((ct, n_idx, cn));
			}
		}
		let key = |p: &Pair| if t_first { [p.k_t, p.e_t, p.k_n, p.e_n] } else { [p.k_n, p.e_n, p.k_t, p.e_t] };
		list.sort_by_key(key);
		let mut parent: Vec<usize> = (0..list.len()).collect();
		fn find(parent: &mut [usize], mut a: usize) -> usize {
			while parent[a] != a {
				parent[a] = parent[parent[a]];
				a = parent[a];
			}
			a
		}
		let dc = (n_idx % 3) as i32 - 1;
		let dr = (n_idx / 3) as i32 - 1;
		let g_t = |k: u32| (tt.col * 256 + (k & 255) as i32, tt.row * 256 + (k >> 8) as i32);
		let g_n = |k: u32| ((tt.col + dc) * 256 + (k & 255) as i32, (tt.row + dr) * 256 + (k >> 8) as i32);
		let mut by_cell: FxHashMap<i64, Vec<usize>> = FxHashMap::default();
		for (i, p) in list.iter().enumerate() {
			let (x, y) = g_t(p.k_t);
			by_cell.entry(i64::from(x) * 100000 + i64::from(y)).or_default().push(i);
		}
		for i in 0..list.len() {
			let p = &list[i];
			let (x, y) = g_t(p.k_t);
			let (nx, ny) = g_n(p.k_n);
			for ox in -1..=1 {
				for oy in -1..=1 {
					let Some(qs) = by_cell.get(&(i64::from(x + ox) * 100000 + i64::from(y + oy))) else { continue };
					for &q in qs {
						if q == i {
							continue;
						}
						let o = &list[q];
						let (mx, my) = g_n(o.k_n);
						if (mx - nx).abs() > 1 || (my - ny).abs() > 1 {
							continue;
						}
						if !joined(tt, p.e_t, p.k_t, o.e_t, o.k_t) || !joined(nn, p.e_n, p.k_n, o.e_n, o.k_n) {
							continue;
						}
						let a = find(&mut parent, i);
						let b = find(&mut parent, q);
						if a != b {
							parent[a.max(b)] = a.min(b);
						}
					}
				}
			}
		}
		let mut groups: Vec<(usize, Vec<usize>)> = Vec::new();
		let mut gi: FxHashMap<usize, usize> = FxHashMap::default();
		for i in 0..list.len() {
			let g = find(&mut parent, i);
			let at = *gi.entry(g).or_insert_with(|| {
				groups.push((g, Vec::new()));
				groups.len() - 1
			});
			groups[at].1.push(i);
		}
		let mid = |arr: &[&Pair]| arr[(arr.len() - 1) >> 1].clone();
		for (_, members) in &groups {
			let mut chunks: Vec<Vec<&Pair>> = Vec::new();
			let mut cur: Vec<&Pair> = Vec::new();
			let mut cols: FxHashSet<u32> = FxHashSet::default();
			for &m in members {
				let p = &list[m];
				let pk = if t_first { p.k_t } else { p.k_n };
				if !cols.contains(&pk) && cols.len() == RUN_MAX {
					chunks.push(std::mem::take(&mut cur));
					cols.clear();
				}
				cols.insert(pk);
				cur.push(p);
			}
			if !cur.is_empty() {
				chunks.push(cur);
			}
			for chunk in &chunks {
				let both: Vec<&Pair> = chunk.iter().copied().filter(|p| p.dir == 3).collect();
				let picks: Vec<Pair> = if !both.is_empty() {
					vec![mid(&both)]
				} else {
					[1u8, 2].iter().map(|&d| chunk.iter().copied().filter(|p| p.dir == d).collect::<Vec<&Pair>>()).filter(|a| !a.is_empty()).map(|a| mid(&a)).collect()
				};
				for rep in picks {
					node_set.insert(rep.e_t);
					reps.push(Rep { n_idx, dc, dr, rep });
				}
			}
		}
	}
	for &e in lift_entries {
		if comp_t[e as usize] != NO_COMP {
			node_set.insert(e);
		}
	}
	let mut nodes: Vec<u32> = node_set.into_iter().collect();
	nodes.sort_unstable();
	let local: FxHashMap<u32, u32> = nodes.iter().enumerate().map(|(i, &e)| (e, i as u32)).collect();
	let col_of = |e: u32| crate::regions::column_of(&tt.first, e) as u32;
	let node_k: Vec<u32> = nodes.iter().map(|&e| col_of(e)).collect();
	let node_z: Vec<f64> = nodes.iter().map(|&e| f64::from(tt.z[e as usize])).collect();
	let mut cross = Vec::new();
	for r in &reps {
		if r.rep.dir & 1 == 0 {
			continue;
		}
		let nn = around[r.n_idx].unwrap();
		let mut terms = [0.0; 7];
		let (c, d, h) = r.rep.step.expect("a crossing pair has its step");
		step_terms(&mut terms, c, tt.flags[r.rep.e_t as usize], nn.flags[r.rep.e_n as usize], d, h);
		cross.push((local[&r.rep.e_t], r.dc, r.dr, r.rep.e_n, quantise(&terms)));
	}
	// Intra-tile edges per reference profile: Dijkstra from every node over the tile's links,
	// gathered once (CSR) with their seconds per profile.
	let mut one = Space::new(&[tt]);
	let n = tt.n;
	let profiles = [foot, mount];
	let mut off = vec![0u32; n + 1];
	let mut e_to: Vec<i32> = Vec::with_capacity(n * 4);
	let mut e_cls: Vec<u8> = Vec::with_capacity(n * 4);
	let mut e_d: Vec<f32> = Vec::with_capacity(n * 4);
	let mut e_h: Vec<f32> = Vec::with_capacity(n * 4);
	let mut costs: [Vec<f32>; 2] = [Vec::with_capacity(n * 4), Vec::with_capacity(n * 4)];
	let mut m = 0u32;
	for k in 0..TILE_CELLS * TILE_CELLS {
		for e in tt.first[k] as usize..tt.first[k + 1] as usize {
			off[e] = m;
			if tt.flags[e] & flag::BLOCKED != 0 {
				continue;
			}
			let mut cnt = 0;
			for (r, p) in profiles.iter().enumerate() {
				cnt = one.expand(0, e, k, p);
				for o in &one.out {
					costs[r].push(o.cost as f32);
					if r == 0 {
						e_to.push(o.to);
						e_cls.push(o.code);
						e_d.push(o.d as f32);
						e_h.push(o.h as f32);
					}
				}
			}
			m += cnt as u32;
		}
	}
	off[n] = m;
	let mut e_from = vec![0i32; m as usize];
	for e in 0..n {
		for x in off[e]..off[e + 1] {
			e_from[x as usize] = e as i32;
		}
	}
	let mut intra: [Vec<(u32, u32, Terms)>; 2] = [Vec::new(), Vec::new()];
	let mut dist = vec![f64::INFINITY; n];
	let mut pe = vec![0i32; n];
	let mut heap = MinHeap::new(4096);
	let mut comp_nodes: FxHashMap<u32, i64> = FxHashMap::default();
	for &e in &nodes {
		*comp_nodes.entry(comp_t[e as usize]).or_insert(0) += 1;
	}
	for r in 0..REF_PROFILES.len() {
		let cost = &costs[r];
		let edges = &mut intra[r];
		for a in 0..nodes.len() {
			dist.fill(f64::INFINITY);
			let src = nodes[a] as usize;
			dist[src] = 0.0;
			pe[src] = -1;
			heap.size = 0;
			heap.push(0.0, src as i32);
			let mut left = comp_nodes[&comp_t[src]] - 1;
			while heap.size > 0 && left > 0 {
				let u = heap.pop() as usize;
				let du = dist[u];
				if heap.top > du {
					continue;
				}
				if u != src && local.contains_key(&(u as u32)) {
					left -= 1;
				}
				for x in off[u] as usize..off[u + 1] as usize {
					let v = e_to[x] as usize;
					let nd = du + f64::from(cost[x]);
					if nd < dist[v] {
						dist[v] = nd;
						pe[v] = x as i32;
						heap.push(nd, v as i32);
					}
				}
			}
			for b in 0..nodes.len() {
				if b == a || dist[nodes[b] as usize] == f64::INFINITY {
					continue;
				}
				let mut terms = [0.0; 7];
				let mut v = nodes[b] as usize;
				while v != src {
					let x = pe[v] as usize;
					let from = e_from[x] as usize;
					step_terms(&mut terms, e_cls[x], tt.flags[from], tt.flags[v], f64::from(e_d[x]), f64::from(e_h[x]));
					v = from;
				}
				edges.push((a as u32, b as u32, quantise(&terms)));
			}
		}
	}
	let mut pair_list = Vec::with_capacity(pairs.len() * 3);
	for (ct, ni, cn) in pairs {
		pair_list.extend([ct, ni as u32, cn]);
	}
	let mut comp_size = vec![0u32; tt.n_comp as usize];
	for e in 0..n {
		if comp_t[e] != NO_COMP {
			comp_size[comp_t[e] as usize] += 1;
		}
	}
	let lifts = lift_entries.iter().filter(|&&e| comp_t[e as usize] != NO_COMP).map(|&e| (e, comp_t[e as usize])).collect();
	Part { col: tt.col, row: tt.row, n_comp: tt.n_comp, comp_size, nodes, node_k, node_z, cross, intra, pairs: pair_list, lifts }
}

fn put_num(s: &mut String, v: f64) {
	if v.is_finite() {
		s.push_str(&fmath::num_to_string(v));
	} else {
		s.push_str("null");
	}
}

fn put_list<T: Copy>(s: &mut String, v: &[T], f: impl Fn(T) -> f64) {
	s.push('[');
	for (i, &x) in v.iter().enumerate() {
		if i > 0 {
			s.push(',');
		}
		put_num(s, f(x));
	}
	s.push(']');
}

fn put_terms(s: &mut String, t: &Terms) {
	for v in t {
		s.push(',');
		put_num(s, *v);
	}
}

/// JSON.stringify(part).
pub fn part_json(p: &Part) -> String {
	let mut s = String::with_capacity(4096 + p.intra[0].len() * 60);
	s.push_str(&format!("{{\"col\":{},\"row\":{},\"nComp\":{},\"compSize\":", p.col, p.row, p.n_comp));
	put_list(&mut s, &p.comp_size, f64::from);
	s.push_str(",\"nodes\":");
	put_list(&mut s, &p.nodes, f64::from);
	s.push_str(",\"nodeK\":");
	put_list(&mut s, &p.node_k, f64::from);
	s.push_str(",\"nodeZ\":");
	put_list(&mut s, &p.node_z, |v| v);
	s.push_str(",\"cross\":[");
	for (i, (a, dc, dr, e_n, t)) in p.cross.iter().enumerate() {
		if i > 0 {
			s.push(',');
		}
		s.push_str(&format!("[{a},{dc},{dr},{e_n}"));
		put_terms(&mut s, t);
		s.push(']');
	}
	s.push_str("],\"intra\":{");
	for (r, name) in REF_PROFILES.iter().enumerate() {
		if r > 0 {
			s.push(',');
		}
		s.push_str(&format!("\"{name}\":["));
		for (i, (a, b, t)) in p.intra[r].iter().enumerate() {
			if i > 0 {
				s.push(',');
			}
			s.push_str(&format!("[{a},{b}"));
			put_terms(&mut s, t);
			s.push(']');
		}
		s.push(']');
	}
	s.push_str("},\"pairs\":");
	put_list(&mut s, &p.pairs, f64::from);
	s.push_str(",\"lifts\":[");
	for (i, (e, c)) in p.lifts.iter().enumerate() {
		if i > 0 {
			s.push(',');
		}
		s.push_str(&format!("[{e},{c}]"));
	}
	s.push_str("]}");
	s
}

pub fn parse_part_json(text: &str) -> Result<Part, String> {
	let v: Value = serde_json::from_str(text).map_err(|e| format!("graph part: {e}"))?;
	let nums = |x: &Value| -> Vec<f64> { x.as_array().map(|a| a.iter().map(|y| y.as_f64().unwrap_or(f64::NAN)).collect()).unwrap_or_default() };
	let u32s = |x: &Value| -> Vec<u32> { nums(x).into_iter().map(|y| y as u32).collect() };
	let terms = |a: &[f64]| -> Terms { std::array::from_fn(|i| a.get(i).copied().unwrap_or(f64::NAN)) };
	let mut p = Part { col: v["col"].as_i64().unwrap_or(0) as i32, row: v["row"].as_i64().unwrap_or(0) as i32, n_comp: v["nComp"].as_u64().unwrap_or(0) as u32, ..Part::default() };
	p.comp_size = u32s(&v["compSize"]);
	p.nodes = u32s(&v["nodes"]);
	p.node_k = u32s(&v["nodeK"]);
	p.node_z = nums(&v["nodeZ"]);
	for c in v["cross"].as_array().into_iter().flatten() {
		let a = nums(c);
		p.cross.push((a[0] as u32, a[1] as i32, a[2] as i32, a[3] as u32, terms(&a[4..])));
	}
	for (r, name) in REF_PROFILES.iter().enumerate() {
		for e in v["intra"][name].as_array().into_iter().flatten() {
			let a = nums(e);
			p.intra[r].push((a[0] as u32, a[1] as u32, terms(&a[2..])));
		}
	}
	p.pairs = u32s(&v["pairs"]);
	for l in v["lifts"].as_array().into_iter().flatten() {
		let a = u32s(l);
		p.lifts.push((a[0], a[1]));
	}
	Ok(p)
}

/// A part with its intra edges as the JS's typed arrays (compactPart).
pub struct CompactPart {
	pub col: i32,
	pub row: i32,
	pub n_comp: u32,
	pub comp_size: Vec<u32>,
	pub nodes: Vec<u32>,
	pub node_k: Vec<u32>,
	pub node_z: Vec<f64>,
	pub cross: Vec<(u32, i32, i32, u32, Terms)>,
	pub intra: [(Vec<u16>, Vec<u16>, Vec<u16>); 2],
	pub pairs: Vec<u32>,
	pub lifts: Vec<(u32, u32)>,
}

/// ToUint16 of a JS number.
fn to_u16(v: f64) -> u16 {
	if !v.is_finite() {
		return 0;
	}
	(v.trunc() as i64).rem_euclid(65536) as u16
}

pub fn compact_part(p: Part) -> CompactPart {
	let intra = p.intra.map(|edges| {
		let a = edges.iter().map(|e| to_u16(f64::from(e.0))).collect();
		let b = edges.iter().map(|e| to_u16(f64::from(e.1))).collect();
		let terms = edges.iter().flat_map(|e| e.2.map(to_u16)).collect();
		(a, b, terms)
	});
	CompactPart { col: p.col, row: p.row, n_comp: p.n_comp, comp_size: p.comp_size, nodes: p.nodes, node_k: p.node_k, node_z: p.node_z, cross: p.cross, intra, pairs: p.pairs, lifts: p.lifts }
}

/// A lift end (build.js liftLinks).
#[derive(Clone, Debug, PartialEq)]
pub struct LiftEnd {
	pub col: i32,
	pub row: i32,
	pub k: u32,
	pub entry: u32,
	pub z: f64,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Lift {
	pub name: String,
	pub id: u32,
	pub a: LiftEnd,
	pub b: LiftEnd,
	pub h: f64,
}

#[derive(Clone, Debug, Default)]
pub struct GraphStats {
	pub nodes: usize,
	pub edges: Vec<usize>,
	pub regions: u32,
	pub components: u32,
	pub broken: usize,
}

/// parts: every tile's part of continent c; lifts: the continent's lifts -> (graph, stats).
pub fn assemble_graph(c: u32, mut parts: Vec<CompactPart>, lifts: &[Lift]) -> (Graph, GraphStats) {
	parts.sort_by(|a, b| a.row.cmp(&b.row).then(a.col.cmp(&b.col)));
	let mut at: FxHashMap<i64, (usize, FxHashMap<u32, u32>)> = FxHashMap::default();
	let (mut node_base, mut comp_base) = (0u32, 0u32);
	let mut tiles = Vec::with_capacity(parts.len());
	for (i, p) in parts.iter().enumerate() {
		tiles.push(GraphTile { col: p.col, row: p.row, node_base, node_count: p.nodes.len() as u32, comp_base, comp_count: p.n_comp });
		at.insert(i64::from(p.col) * 65536 + i64::from(p.row), (i, p.nodes.iter().enumerate().map(|(x, &e)| (e, x as u32)).collect()));
		node_base += p.nodes.len() as u32;
		comp_base += p.n_comp;
	}
	let nn = node_base as usize;
	let mut node_entry = Vec::with_capacity(nn);
	let mut node_k = Vec::with_capacity(nn);
	let mut node_z = Vec::with_capacity(nn);
	for p in &parts {
		node_entry.extend(&p.nodes);
		node_k.extend(p.node_k.iter().map(|&k| k as u16));
		node_z.extend(p.node_z.iter().map(|&z| z as f32));
	}
	let key = |col: i32, row: i32| i64::from(col) * 65536 + i64::from(row);
	let mut broken = 0usize;
	let mut cross: Vec<(u32, u32, Terms)> = Vec::new();
	for (i, p) in parts.iter().enumerate() {
		for (a, dc, dr, e_n, terms) in &p.cross {
			let Some((ti, local)) = at.get(&key(p.col + dc, p.row + dr)) else {
				broken += 1;
				continue;
			};
			let Some(b) = local.get(e_n) else {
				broken += 1;
				continue;
			};
			cross.push((tiles[i].node_base + a, tiles[*ti].node_base + b, *terms));
		}
	}
	let mut joins: Vec<u32> = Vec::new();
	for l in lifts {
		let end = |x: &LiftEnd| -> Option<(u32, u32)> {
			let (ti, local) = at.get(&key(x.col, x.row))?;
			let node = local.get(&x.entry)?;
			let comp = parts[*ti].lifts.iter().find(|(e, _)| *e == x.entry)?;
			Some((tiles[*ti].node_base + node, tiles[*ti].comp_base + comp.1))
		};
		let (Some(ea), Some(eb)) = (end(&l.a), end(&l.b)) else { continue };
		let terms = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, fmath::min(65535.0, fmath::round(lift_seconds(l.h) * TERM_SCALE[6]))];
		cross.push((ea.0, eb.0, terms));
		cross.push((eb.0, ea.0, terms));
		joins.extend([ea.1, eb.1]);
	}
	let mut graphs = Vec::with_capacity(REF_PROFILES.len());
	for r in 0..REF_PROFILES.len() {
		let mut off = vec![0u32; nn + 1];
		for (i, p) in parts.iter().enumerate() {
			let base = tiles[i].node_base as usize;
			for &a in &p.intra[r].0 {
				off[base + a as usize + 1] += 1;
			}
		}
		for (a, _, _) in &cross {
			off[*a as usize + 1] += 1;
		}
		for v in 0..nn {
			off[v + 1] += off[v];
		}
		let mut at2: Vec<u32> = off[..nn].to_vec();
		let total = off[nn] as usize;
		let mut to = vec![0u32; total];
		let mut terms = vec![0u16; total * 7];
		for (i, p) in parts.iter().enumerate() {
			let base = tiles[i].node_base;
			let (ea, eb, et) = &p.intra[r];
			for x in 0..ea.len() {
				let y = at2[(base + u32::from(ea[x])) as usize] as usize;
				at2[(base + u32::from(ea[x])) as usize] += 1;
				to[y] = base + u32::from(eb[x]);
				terms[y * 7..y * 7 + 7].copy_from_slice(&et[x * 7..x * 7 + 7]);
			}
		}
		for (a, b, tm) in &cross {
			let y = at2[*a as usize] as usize;
			at2[*a as usize] += 1;
			to[y] = *b;
			for q in 0..7 {
				terms[y * 7 + q] = to_u16(tm[q]);
			}
		}
		graphs.push(GraphProfile { off, to, terms });
	}
	for (i, p) in parts.iter().enumerate() {
		for x in p.pairs.chunks_exact(3) {
			let (ct, n_idx, cn) = (x[0], x[1] as i32, x[2]);
			let Some((ti, _)) = at.get(&key(p.col + n_idx % 3 - 1, p.row + n_idx.div_euclid(3) - 1)) else { continue };
			joins.extend([tiles[i].comp_base + ct, tiles[*ti].comp_base + cn]);
		}
	}
	let (region, count) = join_regions(comp_base as usize, &joins);
	let mut region_size = vec![0u32; count as usize];
	for (i, p) in parts.iter().enumerate() {
		for x in 0..p.n_comp as usize {
			region_size[region[tiles[i].comp_base as usize + x] as usize] += p.comp_size[x];
		}
	}
	let stats = GraphStats { nodes: nn, edges: graphs.iter().map(|g| g.to.len()).collect(), regions: count, components: comp_base, broken };
	(Graph { c, tiles, node_entry, node_k, node_z, region, region_size, graphs }, stats)
}
