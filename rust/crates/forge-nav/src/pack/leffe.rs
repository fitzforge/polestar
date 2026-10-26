//! Leffe's navigation maps as Polestar's walking maps (`forge nav pack --leffe <dir>`, maps format 5): his surfaces,
//! floors, classes, zones, jumps and drops and his entrance graph, read with `crate::f4` and written in the encodings
//! the in-game engine (addon/Polestar_Nav Routing/) reads (docs/forge/nav.md, "The walking maps"). Credit: Leffe's
//! navigation maps.
//!
//! His cell fields (grid, height, floor, class, zone) already are the in-game encodings and pass through, except the
//! few steps his flags leave open past the walkable slope (his reader closes them; ours reads only the flags), which
//! are closed here, and the floors no walk can use, which are dropped (`isolated`). What changes:
//! - **floor**: his records as format 5's columns (`floor_columns`): half the bytes after zlib.
//! - **arc**: at the in-game cell size every arc of his motion stream is a step inside one surface, a step his cells
//!   already make, a jump (kind 1), or a drop or climb (kind 0 rising or falling past the walkable slope), each to the
//!   same or a neighbouring cell. The jumps, drops and climbs inside a cluster become its arc field (one way, between
//!   the surfaces owning their ends, once per pair: the shortest); those across a border are already his graph's.
//! - **graph**: his PMG4 entrance graph in the in-game encoding: an entrance on a refined port becomes the surface
//!   owning it, costs and yards are rounded, an entrance keeps its 63 cheapest edges. His edges may be one way.
//! - **area**: his maps have none; each surface takes the WMOAreaTable row of our grid's surface in the same cell
//!   nearest in height (within MATCH_YD): the Undercity's floors keep their names.

use super::cells::{CellGrid, ZQ};
use super::encode::{encode_areas, run_length, Maps, COST_MAX, YARDS_MAX};
use super::{b32, enc, js_round, zigzag, B64, NONE};
use crate::f4::pack::{self, Assembly, Cluster, Graph, Meta, Span, TILE, WALK_TAN};
use crate::f4::{NavDir, PackSource};
use rayon::prelude::*;
use rustc_hash::FxHashMap;
use std::collections::{BTreeMap, BTreeSet};
use std::path::Path;

/// A surface of his takes the area of ours when their heights are within this (our base heights are stored to 2 yd).
pub const MATCH_YD: f64 = 6.0;
/// An entrance keeps at most this many edges (the graph field's degree symbol).
const DEGREE: usize = 63;

/// What the conversion found, for the log and PACK.json.
#[derive(Clone, Debug, Default)]
pub struct LeffeStats {
	pub clusters: usize,
	pub floors: usize,
	pub entrances: usize,
	pub edges: usize,
	/// Floors no walk can use, dropped (isolated).
	pub dropped_floors: usize,
	/// Edges past an entrance's 63 (the most costly dropped).
	pub dropped: usize,
	pub jumps: usize,
	pub drops: usize,
	pub climbs: usize,
	pub arcs: usize,
	/// Steps his flags left open past the walkable slope, closed.
	pub closed: usize,
	/// Surfaces given an area of ours.
	pub areas: usize,
}

fn read_field(src: &NavDir, meta: &Meta, field: &str, k: u32) -> Result<Option<Vec<u8>>, String> {
	let Some(spans) = meta.spans(field, k) else { return Ok(None) };
	let mut parts = Vec::new();
	for &Span { part, start, end } in spans {
		let buf = src.read(meta.map, part as usize, start, end)?;
		pack::inflate_blocks(&buf, &mut parts)?;
	}
	Ok(Some(parts.concat()))
}

fn text(b: Vec<u8>) -> Result<String, String> {
	String::from_utf8(b).map_err(|e| format!("leffe: a field is not text: {e}"))
}

/// A node's surface: itself, or the cell or floor owning a refined port.
fn owner(c: &Cluster, node: usize) -> usize {
	if c.owner[node] >= 0 {
		c.owner[node] as usize
	} else {
		node
	}
}

/// The area of our surface in global cell (gx, gy) nearest height z, 0 for none within MATCH_YD.
fn our_area(cg: &CellGrid, gx: i64, gy: i64, z: f64) -> u32 {
	let Some((_, l)) = cg.at(gx, gy) else { return 0 };
	let cell = (gx as usize * cg.gh + gy as usize) as u32;
	let Some(cl) = cg.cluster(cg.cluster_of_cell(cell)) else { return 0 };
	let mut best = (0u32, f64::INFINITY);
	if cl.val[l] != 0 {
		best = (cl.area.as_ref().map_or(0, |a| a[l]), (cl.zq[l] as f64 * ZQ as f64 - z).abs());
	}
	if let Some(&f0) = cg.floor_at.get(&cell) {
		let mut f = f0 as usize;
		while f < cg.floor_cell.len() && cg.floor_cell[f] == cell {
			let g = (cg.floor_z[f] - z).abs();
			if g < best.1 {
				best = (cg.floor_area[f], g);
			}
			f += 1;
		}
	}
	if best.1 <= MATCH_YD {
		best.0
	} else {
		0
	}
}

/// One cluster's fields.
#[derive(Default)]
struct Out {
	grid: Option<String>,
	height: Option<String>,
	floor: Option<String>,
	class: Option<String>,
	area: Option<String>,
	arc: Option<String>,
	graph: Option<String>,
	areas: BTreeSet<u32>,
	stats: LeffeStats,
	max_degree: usize,
	clamped: usize,
}

/// His grid field with the steps past the walkable slope closed (flag 1: +x, 2: +y), and how many.
fn close_steep(meta: &Meta, c: &Cluster, s: &str) -> Result<(String, usize), String> {
	let cc = meta.c as usize;
	let n = cc * cc;
	let mut vals: Vec<u8> = Vec::with_capacity(n);
	let (mut last, b) = (0u8, s.as_bytes());
	for &ch in b {
		let sym = pack::B64[ch as usize];
		if sym < 0 {
			return Err("leffe: grid symbol off the alphabet".into());
		}
		if sym < 48 {
			last = sym as u8;
			vals.push(last);
		} else {
			for _ in 48..=sym {
				vals.push(last);
			}
		}
	}
	if vals.len() != n {
		return Err(format!("leffe: grid holds {} cells, not {n}", vals.len()));
	}
	let straight = (meta.cs * WALK_TAN) as f32;
	let mut closed = 0;
	for a in 0..n {
		if vals[a] / 16 == 0 {
			continue;
		}
		if a + cc < n && vals[a + cc] / 16 != 0 && vals[a] & 1 == 0 && (c.z[a + cc] - c.z[a]).abs() > straight {
			vals[a] |= 1;
			closed += 1;
		}
		if a % cc < cc - 1 && vals[a + 1] / 16 != 0 && vals[a] & 2 == 0 && (c.z[a + 1] - c.z[a]).abs() > straight {
			vals[a] |= 2;
			closed += 1;
		}
	}
	Ok((if closed == 0 { s.to_string() } else { run_length(&vals) }, closed))
}

/// Floors no walk can use: no step or link out of them, none into them from the cluster's surfaces, no jump, drop or
/// entrance at them, and not on the cluster's border (where a neighbour's links may land). About a fifth of his
/// floors; a player standing on one is snapped to a surface beside it as on any spot the maps lack.
fn isolated(meta: &Meta, c: &Cluster, g: &Graph) -> Vec<bool> {
	let cc = meta.c;
	let n2 = (cc * cc) as usize;
	let mut used = vec![false; c.n0];
	for r in 0..g.rows {
		used[owner(c, g.row_node[r] as usize)] = true;
	}
	for a in 0..c.a_from.len() {
		for o in [owner(c, c.a_from[a] as usize)].into_iter().chain((c.a_dx[a] == 0 && c.a_dy[a] == 0).then(|| owner(c, c.a_to[a] as usize))) {
			if o < c.n0 {
				used[o] = true;
			}
		}
	}
	for u in 0..c.n0 {
		let lc = if u < n2 { u as i64 } else { c.at_cell[u] as i64 };
		for e in c.link_off[u] as usize..c.link_off[u + 1] as usize {
			let l = c.link_val[e] as usize;
			let (tx, ty) = (lc / cc + pack::DX[l % 8], lc % cc + pack::DY[l % 8]);
			if tx < 0 || ty < 0 || tx >= cc || ty >= cc {
				continue;
			}
			let t = (tx * cc + ty) as usize;
			let layer = (l / 8) as i64 - 1;
			let first = c.first_floor[t] as i64;
			let target = if layer > 0 {
				(first >= 0).then(|| (first + layer - 1) as usize)
			} else if layer < 0 {
				let h = c.z[u];
				let mut best = (None, if c.val[t] != 0 { (c.z[t] - h).abs() } else { f32::INFINITY });
				let mut f = first;
				while f >= 0 && (f as usize) < c.n0 && c.at_cell[f as usize] as usize == t {
					let d = (c.z[f as usize] - h).abs();
					if d < best.1 {
						best = (Some(f as usize), d);
					}
					f += 1;
				}
				best.0
			} else {
				None
			};
			if let Some(t) = target.filter(|&t| t >= n2 && t < c.n0) {
				used[t] = true;
			}
		}
	}
	(0..c.n0)
		.map(|f| {
			if f < n2 || used[f] || c.link_off[f + 1] > c.link_off[f] {
				return false;
			}
			let lc = c.at_cell[f] as i64;
			let (x, y) = (lc / cc, lc % cc);
			x > 0 && y > 0 && x < cc - 1 && y < cc - 1
		})
		.collect()
}

/// His floor field (rows: n(3) | n x [cell(3) count(1) count x [value(1) height + 2048(2) steps(2)]] | m(3) | m x
/// [node(3) direction(1) layer(1)]) without the `dead` floors, as format 5's columns: their records gone, the floors
/// after them renumbered, and an explicit link's layer in this cluster lowered by the dead floors under it in its
/// cell (links across the border land on border cells, where nothing is dropped). The columns, each a run of b32
/// numbers or fixed symbols: n | n cell gaps (cell - previous cell - 1, from -1) | n counts (1) | the floors' values
/// (1) | their heights (zigzag: against the floor below in the cell, a cell's first against the previous cell's
/// first, from 0) | their steps (2) | m | m link nodes (zigzag against the previous link's, from 0) | m directions
/// (1) | m layers (1). Half the bytes of the rows after zlib: like values sit together.
fn floor_columns(s: &str, cc: usize, dead: &[bool]) -> Result<String, String> {
	let b = s.as_bytes();
	let num = |i: usize, w: usize| -> usize { (0..w).fold(0, |v, j| v * 64 + pack::B64[b[i + j] as usize] as usize) };
	let n2 = cc * cc;
	let mut p = 3;
	let mut cells: Vec<(usize, Vec<(usize, usize, i64, usize)>)> = Vec::new(); // (cell, [(old node, val, z, steps)])
	let mut node = n2;
	let mut cell_of: Vec<usize> = Vec::new(); // a floor node's cell, by node - n2
	for _ in 0..num(0, 3) {
		let (cell, count) = (num(p, 3), num(p + 3, 1));
		p += 4;
		let mut fl = Vec::with_capacity(count);
		for _ in 0..count {
			fl.push((node, num(p, 1), num(p + 1, 2) as i64 - 2048, num(p + 3, 2)));
			cell_of.push(cell);
			p += 5;
			node += 1;
		}
		cells.push((cell, fl));
	}
	let dead = |n: usize| dead.get(n).copied().unwrap_or(false);
	// old node -> new node; per cell, its dead floors' old layers
	let mut renum = vec![0usize; node];
	let mut next = n2;
	let mut dead_layers: FxHashMap<usize, Vec<usize>> = FxHashMap::default();
	for (cell, fl) in &mut cells {
		for (i, f) in fl.iter().enumerate() {
			if dead(f.0) {
				dead_layers.entry(*cell).or_default().push(i + 1);
			} else {
				renum[f.0] = next;
				next += 1;
			}
		}
		fl.retain(|f| !dead(f.0));
	}
	cells.retain(|(_, fl)| !fl.is_empty());
	let mut out = String::new();
	b32(cells.len() as u64, &mut out);
	let mut last = -1i64;
	for (cell, _) in &cells {
		b32((*cell as i64 - last - 1) as u64, &mut out);
		last = *cell as i64;
	}
	for (_, fl) in &cells {
		out.push_str(&enc(fl.len() as f64, 1)?);
	}
	for f in cells.iter().flat_map(|(_, fl)| fl) {
		out.push_str(&enc(f.1 as f64, 1)?);
	}
	let mut first = 0;
	for (_, fl) in &cells {
		let mut below = first;
		for (i, f) in fl.iter().enumerate() {
			b32(zigzag(f.2 - below), &mut out);
			if i == 0 {
				first = f.2;
			}
			below = f.2;
		}
	}
	for f in cells.iter().flat_map(|(_, fl)| fl) {
		out.push_str(&enc(f.3 as f64, 2)?);
	}
	let m = num(p, 3);
	p += 3;
	let mut links = Vec::with_capacity(m);
	for _ in 0..m {
		let (u, d, layer) = (num(p, 3), num(p + 3, 1), num(p + 4, 1));
		p += 5;
		let lc = if u < n2 { u } else { cell_of[u - n2] };
		let (tx, ty) = ((lc / cc) as i64 + pack::DX[d], (lc % cc) as i64 + pack::DY[d]);
		let mut layer2 = layer;
		if layer > 0 && tx >= 0 && ty >= 0 && tx < cc as i64 && ty < cc as i64 {
			let t = (tx as usize) * cc + ty as usize;
			layer2 -= dead_layers.get(&t).map_or(0, |v| v.iter().filter(|&&l| l < layer).count());
		}
		links.push((if u < n2 { u } else { renum[u] }, d, layer2));
	}
	if p != b.len() {
		return Err(format!("leffe: floor field has {} symbols past its records", b.len() - p));
	}
	b32(m as u64, &mut out);
	let mut prev = 0i64;
	for &(u, _, _) in &links {
		b32(zigzag(u as i64 - prev), &mut out);
		prev = u as i64;
	}
	for &(_, d, _) in &links {
		out.push_str(&enc(d as f64, 1)?);
	}
	for &(_, _, layer) in &links {
		out.push_str(&enc(layer as f64, 1)?);
	}
	Ok(out)
}

/// His class field (per node, run-length; missing tail 0) without the `dead` nodes.
fn drop_classes(s: &str, n0: usize, dead: &[bool]) -> String {
	let mut v: Vec<u8> = Vec::with_capacity(n0);
	let mut last = 0u8;
	for &ch in s.as_bytes() {
		let sym = pack::B64[ch as usize] as u8;
		if sym < 48 {
			last = sym;
			v.push(last);
		} else {
			v.extend(std::iter::repeat_n(last, (sym - 47) as usize));
		}
	}
	v.resize(n0, 0);
	let kept: Vec<u8> = v.iter().zip(dead).filter(|(_, &d)| !d).map(|(&x, _)| x).collect();
	run_length(&kept)
}

#[allow(clippy::too_many_arguments)]
fn cluster(meta: &Meta, k: u32, c: &Cluster, g: &Graph, fields: &FxHashMap<&str, String>, cg: &CellGrid, has: &dyn Fn(u32) -> bool, layers: &FxHashMap<u32, Vec<u8>>) -> Result<Out, String> {
	let cc = meta.c as usize;
	let n2 = cc * cc;
	let mut o = Out::default();
	let (grid, closed) = close_steep(meta, c, &fields["grid"])?;
	o.stats.closed = closed;
	o.grid = Some(grid);
	o.height = fields.get("height").cloned();
	// The floors no walk can use are dropped; every node after one moves down.
	let dead = isolated(meta, c, g);
	o.stats.dropped_floors = dead.iter().filter(|&&d| d).count();
	let mut renum = vec![u32::MAX; c.n0];
	let mut layer_of = vec![0usize; c.n0];
	let mut next = 0u32;
	let mut run = (usize::MAX, 0usize);
	for node in 0..c.n0 {
		if dead[node] {
			continue;
		}
		renum[node] = next;
		next += 1;
		if node >= n2 {
			let cell = c.at_cell[node] as usize;
			run = if run.0 == cell { (cell, run.1 + 1) } else { (cell, 1) };
			layer_of[node] = run.1;
		}
	}
	o.floor = fields.get("floor").map(|f| floor_columns(f, cc, &dead)).transpose()?;
	o.class = fields.get("class").map(|s| if o.stats.dropped_floors > 0 { drop_classes(s, c.n0, &dead) } else { s.clone() });
	o.stats.clusters = 1;
	o.stats.floors = c.n0 - n2 - o.stats.dropped_floors;
	// area: per surface, ours in the same cell nearest in height
	let (kx, ky) = (k as i64 / meta.ny, k as i64 % meta.ny);
	let mut av = Vec::with_capacity(c.n0);
	for node in 0..c.n0 {
		if dead[node] {
			continue;
		}
		let lc = if node < n2 { node } else { c.at_cell[node] as usize };
		let a = if node < n2 && c.val[node] == 0 { 0 } else { our_area(cg, kx * cc as i64 + (lc / cc) as i64, ky * cc as i64 + (lc % cc) as i64, c.z[node] as f64) };
		if a != 0 {
			o.areas.insert(a);
			o.stats.areas += 1;
		}
		av.push(a);
	}
	if av.iter().any(|&a| a != 0) {
		o.area = Some(encode_areas(&av)?);
	}
	// arc: the jumps, drops and climbs inside the cluster, between the surfaces owning their ends
	let mut arcs: BTreeMap<(usize, usize), f64> = BTreeMap::new();
	for a in 0..c.a_from.len() {
		if c.a_dx[a] != 0 || c.a_dy[a] != 0 {
			continue;
		}
		let (from, to) = (c.a_from[a] as usize, c.a_to[a] as usize);
		if c.a_kind[a] == 1 {
			o.stats.jumps += 1;
		} else {
			let (ga, gb) = (geometry(meta, k, c, from), geometry(meta, k, c, to));
			let h = ((gb[0] - ga[0]).powi(2) + (gb[1] - ga[1]).powi(2)).sqrt();
			let slope = h * WALK_TAN + pack::SLOPE_EPS;
			let dz = gb[2] - ga[2];
			if dz < -slope {
				o.stats.drops += 1;
			} else if dz > slope {
				o.stats.climbs += 1;
			} else {
				continue;
			}
		}
		let (fa, fb) = (owner(c, from), owner(c, to));
		if fa == fb || fa >= c.n0 || fb >= c.n0 {
			continue;
		}
		let (fa, fb) = (renum[fa] as usize, renum[fb] as usize);
		let y = c.a_yards[a] as f64;
		let e = arcs.entry((fa, fb)).or_insert(y);
		if y < *e {
			*e = y;
		}
	}
	// As columns (b32, see floor_columns): n | n from gaps (from - previous from, from 0) | n ends (zigzag: to - from) |
	// n yards * 4.
	if !arcs.is_empty() {
		let mut s = String::new();
		b32(arcs.len() as u64, &mut s);
		let mut last = 0;
		for &(a, _) in arcs.keys() {
			b32((a - last) as u64, &mut s);
			last = a;
		}
		for &(a, b) in arcs.keys() {
			b32(zigzag(b as i64 - a as i64), &mut s);
		}
		for &y in arcs.values() {
			b32(js_round(y * 4.0).clamp(1.0, YARDS_MAX) as u64, &mut s);
		}
		o.stats.arcs = arcs.len();
		o.arc = Some(s);
	}
	// graph: his entrances and edges in the in-game encoding
	if g.rows > 0 {
		if g.rows >= 4096 {
			return Err(format!("leffe: cluster {k} has {} entrances (at most 4095)", g.rows));
		}
		let mut rec = enc(g.rows as f64, 2)?;
		let mut erec = String::new();
		for r in 0..g.rows {
			let o0 = owner(c, g.row_node[r] as usize);
			let (lc, layer) = if o0 < n2 { (o0, 0) } else { (c.at_cell[o0] as usize, layer_of[o0]) };
			if layer >= 64 {
				return Err(format!("leffe: cluster {k} entrance {r} on floor {layer} (at most 63)"));
			}
			let mut list: Vec<usize> = (g.row_out[r] as usize..g.row_out[r + 1] as usize)
				.filter(|&e| {
					let q = (kx + g.e_dx[e] as i64) * meta.ny + ky + g.e_dy[e] as i64;
					has(q as u32) && (g.e_ent[e] as usize) < layers.get(&(q as u32)).map_or(0, |v| v.len())
				})
				.collect();
			o.stats.edges += list.len();
			if list.len() > DEGREE {
				list.sort_by(|&p, &q| g.e_cost[3 * p + NONE].total_cmp(&g.e_cost[3 * q + NONE]).then(p.cmp(&q)));
				o.stats.dropped += list.len() - DEGREE;
				list.truncate(DEGREE);
				list.sort_unstable();
			}
			o.max_degree = o.max_degree.max(list.len());
			rec.push_str(&enc(lc as f64, 3)?);
			rec.push_str(&enc(layer as f64, 1)?);
			rec.push_str(&enc((g.row_comp[r] as f64).min(4095.0), 2)?);
			rec.push_str(&enc(list.len() as f64, 1)?);
			for e in list {
				erec.push_str(&enc(((g.e_dx[e] + 1) * 3 + g.e_dy[e] + 1) as f64, 1)?);
				erec.push_str(&enc(g.e_ent[e] as f64, 2)?);
				for s in 0..3 {
					let w = js_round(g.e_cost[3 * e + s] as f64);
					if w > COST_MAX {
						o.clamped += 1;
					}
					erec.push_str(&enc(w.clamp(0.0, COST_MAX), 3)?);
				}
				let y = js_round(g.e_yards[e] as f64);
				if y > YARDS_MAX {
					o.clamped += 1;
				}
				erec.push_str(&enc(y.clamp(0.0, YARDS_MAX), 2)?);
			}
		}
		rec.push_str(&erec);
		o.stats.entrances = g.rows;
		o.graph = Some(rec);
	}
	Ok(o)
}

/// A node's exact place: his f32 geometry where the motion refines it, else its cell's centre and height.
fn geometry(meta: &Meta, k: u32, c: &Cluster, node: usize) -> [f64; 3] {
	let s = c.spec_idx[node];
	if s >= 0 {
		let s = s as usize;
		return [c.spec_x[s], c.spec_y[s], c.spec_z[s] as f64];
	}
	let cc = meta.c;
	let o = owner(c, node);
	let lc = if (o as i64) < cc * cc { o as i64 } else { c.at_cell[o] as i64 };
	[meta.x0 + ((k as i64 / meta.ny * cc + lc / cc) as f64 + 0.5) * meta.cs, meta.y0 + ((k as i64 % meta.ny * cc + lc % cc) as f64 + 0.5) * meta.cs, c.z[o] as f64]
}

/// Map `map` of Leffe's Nav folder `dir` as the in-game fields (maps format 5), with `cg` (our grid's cells, the same
/// frame and cells) for the areas. -> the fields, the area rows they use, and the counts.
pub fn leffe_maps(dir: &Path, map: u32, cg: &CellGrid) -> Result<(Maps, BTreeSet<u32>, LeffeStats), String> {
	let src = NavDir::open(dir)?;
	let text_meta = src.meta(map)?.ok_or_else(|| format!("leffe: {} has no map {map}", dir.display()))?;
	let mut meta = pack::parse_meta(&text_meta, map)?;
	let mut asm = Assembly::default();
	for part in 0..src.parts(map) {
		let name = format!("Nav{map}_{}.lua", part + 1);
		let mut res = Ok(());
		src.with_part(map, part, &mut |bytes| res = pack::scan_part(bytes, part as u32, &mut meta.index, &mut asm, &name))?;
		res?;
	}
	if meta.c as usize != cg.c
		|| meta.nx as usize != cg.nx
		|| meta.ny as usize != cg.ny
		|| (meta.x0 / TILE).round() as i32 != cg.cx0
		|| (meta.y0 / TILE).round() as i32 != cg.cy0
		|| meta.zstep != ZQ as f64
	{
		return Err(format!("leffe: map {map}'s frame, cells or height step differ from the grid's (his {} cells, {}x{}; ours {}, {}x{})", meta.c, meta.nx, meta.ny, cg.c, cg.nx, cg.ny));
	}
	let mut keys: Vec<u32> = meta.index.get("grid").map(|m| m.keys().copied().collect()).unwrap_or_default();
	keys.sort_unstable();
	let populated: rustc_hash::FxHashSet<u32> = keys.iter().copied().collect();
	let has = |k: u32| populated.contains(&k);
	let (meta, src) = (&meta, &src);
	// Every populated cluster's entrance count, for edges into it.
	let rows: FxHashMap<u32, Vec<u8>> = keys
		.par_iter()
		.map(|&k| -> Result<(u32, Vec<u8>), String> {
			let g = read_field(src, meta, "graph", k)?.unwrap_or_default();
			// PMG4's row count is the first u32 after its 4-byte magic.
			let n = if g.len() >= 8 { u32::from_le_bytes(g[4..8].try_into().unwrap()) as usize } else { 0 };
			Ok((k, vec![0; n]))
		})
		.collect::<Result<_, String>>()?;
	let outs: Vec<(u32, Out)> = keys
		.par_iter()
		.map(|&k| -> Result<(u32, Out), String> {
			let mut read = |f: &str, k: u32| read_field(src, meta, f, k);
			let c = pack::decode_cluster(meta, k, &mut read)?.ok_or_else(|| format!("leffe: map {map} cluster {k} does not decode"))?;
			let g = pack::decode_graph(k, &mut read, Some(&c))?;
			let mut fields: FxHashMap<&str, String> = FxHashMap::default();
			for f in ["grid", "height", "floor", "class"] {
				if let Some(b) = read(f, k)? {
					fields.insert(f, text(b)?);
				}
			}
			if g.rows != rows[&k].len() {
				return Err(format!("leffe: map {map} cluster {k}: {} entrance rows, the header says {}", g.rows, rows[&k].len()));
			}
			Ok((k, cluster(meta, k, &c, &g, &fields, cg, &has, &rows)?))
		})
		.collect::<Result<_, String>>()?;
	let mut maps = Maps { class: Some(BTreeMap::new()), zone: Some(BTreeMap::new()), area: Some(BTreeMap::new()), arc: Some(BTreeMap::new()), ..Default::default() };
	let mut used = BTreeSet::new();
	let mut st = LeffeStats::default();
	let mut comps = BTreeSet::new();
	for (k, o) in outs {
		let put = |m: &mut BTreeMap<u32, String>, v: Option<String>| {
			if let Some(v) = v {
				m.insert(k, v);
			}
		};
		put(&mut maps.grid, o.grid);
		put(&mut maps.height, o.height);
		put(&mut maps.floor, o.floor);
		put(maps.class.as_mut().unwrap(), o.class);
		put(maps.area.as_mut().unwrap(), o.area);
		put(maps.arc.as_mut().unwrap(), o.arc);
		put(&mut maps.graph, o.graph);
		used.extend(o.areas);
		maps.max_degree = maps.max_degree.max(o.max_degree);
		maps.clamped += o.clamped;
		let s = o.stats;
		st.clusters += s.clusters;
		st.floors += s.floors;
		st.entrances += s.entrances;
		st.edges += s.edges;
		st.dropped += s.dropped;
		st.dropped_floors += s.dropped_floors;
		st.jumps += s.jumps;
		st.drops += s.drops;
		st.climbs += s.climbs;
		st.arcs += s.arcs;
		st.closed += s.closed;
		st.areas += s.areas;
	}
	// zone: his, as stored
	if let Some(z) = &meta.zone {
		for (k, s) in z.iter().enumerate() {
			if let Some(s) = s {
				if populated.contains(&(k as u32)) {
					maps.zone.as_mut().unwrap().insert(k as u32, text(s.clone())?);
				}
			}
		}
	}
	// components: count the distinct ids his graph names
	for s in maps.graph.values() {
		let b = s.as_bytes();
		let num = |i: usize, w: usize| (0..w).fold(0usize, |v, j| v * 64 + B64.iter().position(|&c| c == b[i + j]).unwrap());
		let n = num(0, 2);
		for r in 0..n {
			comps.insert(num(2 + r * 7 + 4, 2));
		}
	}
	maps.components = comps.len();
	if maps.area.as_ref().unwrap().is_empty() {
		return Err(format!("leffe: map {map}: no surface matched an area of ours (is the grid the same client build?)"));
	}
	Ok((maps, used, st))
}
