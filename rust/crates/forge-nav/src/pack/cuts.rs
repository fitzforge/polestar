//! Cuts (`forge nav pack --leffe`): faces players cannot climb that Leffe's maps (and our grid) walk up, a line each
//! in joins.json's `cuts` (compiled in). Every move of his maps that crosses the line going up (its end more than RISE
//! above its start, both ends inside the cut's height band) is taken out: a base cell's step by its data flag, a
//! floor's step by its step mask, an explicit link, an arc. A move taken out whose way down players do walk stays as
//! a one-way arc down (the step's length), so the arrow still walks down the face and never up it. The entrances of a
//! cut cluster then keep their edges only where the cluster still walks them: an edge the cut makes dearer is
//! priced by the walk round, and one it leaves no walk for goes.
//!
//! Add a cut only where players' recordings or a report show the face can't be walked up, and walks up it are what
//! the maps make.

use super::ingame::{self, cost_value, yards_value, Cluster, Row, DX, DY, HERE};
use super::joins::Geo;
use super::leffe::Out;
use super::NONE;
use std::collections::BTreeMap;

/// A move rises when its end is more than this above its start (yd).
pub const RISE: f64 = 0.5;

/// A cut as joins.json writes it: a line on one map between two places (world yards, UnitPosition's frame) and the
/// band of heights it holds for.
#[derive(Clone, Debug)]
pub struct Cut {
	pub id: String,
	pub map: u32,
	pub a: (f64, f64),
	pub b: (f64, f64),
	pub z: (f64, f64),
}

/// The cuts of joins.json (compiled in).
pub fn cuts() -> Vec<Cut> {
	let v: serde_json::Value = serde_json::from_str(include_str!("joins.json")).expect("joins.json");
	let pt = |e: &serde_json::Value| (e[0].as_f64().expect("joins.json: cut x"), e[1].as_f64().expect("joins.json: cut y"));
	v["cuts"]
		.as_array()
		.map(|list| {
			list.iter()
				.map(|c| Cut {
					id: c["id"].as_str().expect("joins.json: cut id").to_string(),
					map: c["map"].as_u64().expect("joins.json: cut map") as u32,
					a: pt(&c["a"]),
					b: pt(&c["b"]),
					z: (c["z"][0].as_f64().expect("joins.json: cut z"), c["z"][1].as_f64().expect("joins.json: cut z")),
				})
				.collect()
		})
		.unwrap_or_default()
}

/// What the cuts took out, for the log and PACK.json.
#[derive(Clone, Debug, Default)]
pub struct CutStats {
	pub cuts: usize,
	/// Moves up taken out, and the one-way arcs down put back for them.
	pub moves: usize,
	pub arcs: usize,
	/// Entrance edges made dearer, and taken out.
	pub dearer: usize,
	pub gone: usize,
	pub clusters: usize,
}

/// Whether segments p1-p2 and q1-q2 cross (touching counts).
fn crosses(p1: (f64, f64), p2: (f64, f64), q1: (f64, f64), q2: (f64, f64)) -> bool {
	let side = |a: (f64, f64), b: (f64, f64), c: (f64, f64)| (b.0 - a.0) * (c.1 - a.1) - (b.1 - a.1) * (c.0 - a.0);
	let (d1, d2) = (side(q1, q2, p1), side(q1, q2, p2));
	let (d3, d4) = (side(p1, p2, q1), side(p1, p2, q2));
	d1 * d2 <= 0.0 && d3 * d4 <= 0.0 && !(d1 == 0.0 && d2 == 0.0)
}

/// The world centre of local cell lc of cluster k.
fn centre(g: &Geo, k: u32, lc: usize) -> (f64, f64) {
	let (kx, ky) = (k as i64 / g.ny, k as i64 % g.ny);
	let (lx, ly) = ((lc / g.c) as i64, (lc % g.c) as i64);
	(g.x0 + ((kx * g.c as i64 + lx) as f64 + 0.5) * g.cs, g.y0 + ((ky * g.c as i64 + ly) as f64 + 0.5) * g.cs)
}

/// Whether the move u -> v of cluster k crosses the cut going up, inside its band.
fn up_across(g: &Geo, k: u32, c: &Cluster, cut: &Cut, u: usize, v: usize) -> bool {
	let (zu, zv) = (c.z[u], c.z[v]);
	zv - zu > RISE && zu >= cut.z.0 && zu <= cut.z.1 && zv >= cut.z.0 && zv <= cut.z.1 && crosses(centre(g, k, c.cell(u)), centre(g, k, c.cell(v)), cut.a, cut.b)
}

/// The clusters the cut's line passes (and their neighbours within a cell of it).
fn clusters_of(g: &Geo, cut: &Cut) -> Vec<u32> {
	let len = (cut.b.0 - cut.a.0).hypot(cut.b.1 - cut.a.1);
	let steps = (len / (g.cs / 2.0)).ceil().max(1.0) as usize;
	let mut ks = std::collections::BTreeSet::new();
	for i in 0..=steps {
		let t = i as f64 / steps as f64;
		let (x, y) = (cut.a.0 + (cut.b.0 - cut.a.0) * t, cut.a.1 + (cut.b.1 - cut.a.1) * t);
		for (dx, dy) in [(0.0, 0.0), (g.cs, 0.0), (-g.cs, 0.0), (0.0, g.cs), (0.0, -g.cs)] {
			let (gx, gy) = (((x + dx - g.x0) / g.cs).floor() as i64, ((y + dy - g.y0) / g.cs).floor() as i64);
			if gx >= 0 && gy >= 0 {
				ks.insert(((gx / g.c as i64) * g.ny + gy / g.c as i64) as u32);
			}
		}
	}
	ks.into_iter().collect()
}

/// One cluster with the cut's moves up taken out (`downs`: the arcs down to put back, (from, to, cells)). -> the
/// cluster and how many moves went.
fn cut_cluster(g: &Geo, k: u32, before: &Cluster, cut: &Cut, downs: &mut Vec<(usize, usize, f64)>) -> Result<(Cluster, usize), String> {
	let (n, c) = (before.n(), before.c);
	let s2 = std::f64::consts::SQRT_2;
	let mut gone = 0;
	// base cells' straight steps: closed by the data flag (both ways; the way down comes back as an arc)
	let mut flags: Vec<u8> = (0..n).map(|a| before.flags(a)).collect();
	let mut buf = Vec::new();
	for a in 0..n {
		if before.val[a] == 0 {
			continue;
		}
		for (b, bit) in [(a + c, 1u8), (a + 1, 2u8)] {
			if b >= n || (bit == 2 && a % c == c - 1) || before.val[b] == 0 || flags[a] & bit != 0 {
				continue;
			}
			before.moves(a, false, &mut buf);
			if !buf.iter().any(|m| m.0 == b) {
				continue;
			}
			let (lo, hi) = if before.z[b] > before.z[a] { (a, b) } else { (b, a) };
			if up_across(g, k, before, cut, lo, hi) {
				flags[a] |= bit;
				downs.push((hi, lo, 1.0));
				gone += 1;
			}
		}
	}
	// diagonals his flags open on their own (4: +x+y, 8: +x-y) across the line, closed the same way
	for a in 0..n {
		for (bit, b) in [(4u8, (a % c < c - 1).then(|| a + c + 1)), (8u8, (a % c > 0).then(|| a + c - 1))] {
			let Some(b) = b.filter(|&b| b < n && flags[a] & bit != 0 && before.val[a] != 0 && before.val[b] != 0) else { continue };
			let (lo, hi) = if before.z[b] > before.z[a] { (a, b) } else { (b, a) };
			if up_across(g, k, before, cut, lo, hi) {
				flags[a] &= !bit;
				downs.push((hi, lo, s2));
				gone += 1;
			}
		}
	}
	let mut after = Cluster::decode(
		c,
		g.cs,
		g.zstep,
		&before.grid_field(&flags),
		&before.height,
		before.floor_field()?.as_deref(),
		Some(&before.class_field()),
		before.area_field()?.as_deref(),
		before.arc_field().as_deref(),
	)
	.map_err(|e| format!("cuts: cluster {k}: {e}"))?;
	// a floor's steps (its mask: to the neighbour's surface nearest its height, and back from a base cell)
	for f in n..after.t() {
		let lc = after.cell(f) as i64;
		for d in 0..8 {
			if after.steps[f - n] >> d & 1 == 0 {
				continue;
			}
			let (tx, ty) = (lc / c as i64 + DX[d], lc % c as i64 + DY[d]);
			if tx < 0 || ty < 0 || tx >= c as i64 || ty >= c as i64 {
				continue;
			}
			let Some(v) = after.surface((tx * c as i64 + ty) as usize, -1, after.z[f]) else { continue };
			let (lo, hi) = if after.z[v] > after.z[f] { (f, v) } else { (v, f) };
			if up_across(g, k, &after, cut, lo, hi) {
				after.steps[f - n] &= !(1 << d);
				downs.push((hi, lo, if d >= 4 { s2 } else { 1.0 }));
				gone += 1;
			}
		}
	}
	// explicit links
	let links = std::mem::take(&mut after.links);
	for (u, d, layer) in links {
		let (lc, d8) = (after.cell(u as usize) as i64, d as usize);
		let (tx, ty) = (lc / c as i64 + DX[d8], lc % c as i64 + DY[d8]);
		let v = (tx >= 0 && ty >= 0 && tx < c as i64 && ty < c as i64).then(|| after.surface((tx * c as i64 + ty) as usize, layer as i32, after.z[u as usize])).flatten();
		if let Some(v) = v {
			let (lo, hi) = if after.z[v] > after.z[u as usize] { (u as usize, v) } else { (v, u as usize) };
			if up_across(g, k, &after, cut, lo, hi) {
				downs.push((hi, lo, if d8 >= 4 { s2 } else { 1.0 }));
				gone += 1;
				continue;
			}
		}
		after.links.push((u, d, layer));
	}
	// arcs up across the line (jumps and climbs of his)
	let arcs = std::mem::take(&mut after.arcs);
	for ((a, b), y) in arcs {
		if up_across(g, k, &after, cut, a as usize, b as usize) {
			gone += 1;
			continue;
		}
		after.arcs.insert((a, b), y);
	}
	after.index();
	Ok((after, gone))
}

/// The cuts of `map` taken out of the clusters of `outs` (his clusters as written, by cluster key).
pub(super) fn apply(g: &Geo, outs: &mut [(u32, Out)], map: u32, log: &(dyn Fn(&str) + Sync)) -> Result<CutStats, String> {
	let list: Vec<Cut> = cuts().into_iter().filter(|c| c.map == map).collect();
	apply_list(g, outs, &list, log)
}

fn apply_list(g: &Geo, outs: &mut [(u32, Out)], list: &[Cut], log: &(dyn Fn(&str) + Sync)) -> Result<CutStats, String> {
	let mut st = CutStats::default();
	let at: BTreeMap<u32, usize> = outs.iter().enumerate().map(|(i, (k, _))| (*k, i)).collect();
	for cut in list {
		st.cuts += 1;
		let (mut moves, mut arcs) = (0, 0);
		for k in clusters_of(g, cut) {
			let Some(&i) = at.get(&k) else { continue };
			let o = &outs[i].1;
			let (Some(grid), Some(height)) = (o.grid.as_deref(), o.height.as_deref()) else { continue };
			let before =
				Cluster::decode(g.c, g.cs, g.zstep, grid, height, o.floor.as_deref(), o.class.as_deref(), o.area.as_deref(), o.arc.as_deref()).map_err(|e| format!("cuts: cluster {k}: {e}"))?;
			let mut downs = Vec::new();
			let (mut after, gone) = cut_cluster(g, k, &before, cut, &mut downs)?;
			if gone == 0 {
				continue;
			}
			// the ways down players walk, back as one-way arcs (where the cluster has no other move down there)
			let mut buf = Vec::new();
			for &(hi, lo, len) in &downs {
				after.moves(hi, false, &mut buf);
				if !buf.iter().any(|m| m.0 == lo) {
					after.add_arc(hi, lo, len * g.cs);
					arcs += 1;
				}
			}
			// what is left of the cut's moves up (none, unless the line misses a move's cells): logged
			let mut left = 0;
			for u in 0..after.t() {
				after.moves(u, false, &mut buf);
				left += buf.iter().filter(|m| up_across(g, k, &after, cut, u, m.0)).count();
			}
			if left > 0 {
				log(&format!("cut {}: cluster {k}: {left} moves up across the line are left", cut.id));
			}
			let mut rows = o.graph.as_deref().map(ingame::decode_graph).transpose().map_err(|e| format!("cuts: cluster {k}: {e}"))?.unwrap_or_default();
			let (dearer, went) = reprice(&before, &after, &mut rows, g.swim);
			st.dearer += dearer;
			st.gone += went;
			let o = &mut outs[i].1;
			o.grid = Some(after.grid_field(&(0..after.n()).map(|a| after.flags(a)).collect::<Vec<u8>>()));
			o.floor = after.floor_field()?;
			o.arc = after.arc_field();
			o.graph = if rows.is_empty() { None } else { Some(ingame::encode_graph(&rows)?) };
			moves += gone;
			st.clusters += 1;
		}
		st.moves += moves;
		st.arcs += arcs;
		log(&format!("cut {}: {moves} moves up taken out, {arcs} arcs down put back", cut.id));
	}
	Ok(st)
}

/// Each entrance edge inside the cluster priced again where the cut changed its walk: dearer by what the walk round
/// adds (per profile), gone where no walk is left. Edges the cut leaves alone keep their costs. -> (dearer, gone).
pub fn reprice(before: &Cluster, after: &Cluster, rows: &mut [Row], swim: f64) -> (usize, usize) {
	let node = |c: &Cluster, r: &Row| c.surface(r.cell as usize, r.layer as i32, 0.0);
	let ends: Vec<(Option<usize>, Option<usize>)> = rows.iter().map(|r| (node(before, r), node(after, r))).collect();
	let (mut dearer, mut gone) = (0, 0);
	for r in 0..rows.len() {
		let (Some(rb), Some(ra)) = ends[r] else { continue };
		if !rows[r].edges.iter().any(|e| e.off == HERE) {
			continue;
		}
		let gb: Vec<(Vec<f64>, Vec<f64>)> = (0..3).map(|p| before.dijkstra(&[(rb, 0.0, 0.0)], p, swim, false)).collect();
		let ga: Vec<(Vec<f64>, Vec<f64>)> = (0..3).map(|p| after.dijkstra(&[(ra, 0.0, 0.0)], p, swim, false)).collect();
		let mut kept = Vec::with_capacity(rows[r].edges.len());
		for mut e in std::mem::take(&mut rows[r].edges) {
			let t = e.ent as usize;
			let (Some(tb), Some(ta)) = ends.get(t).copied().unwrap_or((None, None)) else {
				kept.push(e);
				continue;
			};
			if e.off != HERE || !gb[NONE].0[tb].is_finite() {
				kept.push(e);
				continue;
			}
			if !ga[NONE].0[ta].is_finite() {
				gone += 1;
				continue;
			}
			let mut more = false;
			for p in 0..3 {
				let add = ga[p].0[ta] - gb[p].0[tb];
				if add > 1.0 {
					e.cost[p] = cost_value(e.cost[p] as f64 + add);
					more = true;
				}
			}
			if more {
				let add = ga[NONE].1[ta] - gb[NONE].1[tb];
				if add > 0.0 {
					e.yards = yards_value(e.yards as f64 + add);
				}
				dearer += 1;
			}
			kept.push(e);
		}
		rows[r].edges = kept;
	}
	(dearer, gone)
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::pack::encode::{encode_heights, run_length};
	use crate::pack::ingame::Edge;

	const C: usize = 8;
	const CS: f64 = 1600.0 / 3.0 / 128.0;

	fn geo() -> Geo {
		Geo { c: C, cs: CS, zstep: 2.0, x0: 0.0, y0: 0.0, ny: 1, swim: 3.0 }
	}

	/// Plain ground rising 4 yd a row in x from row 4 on (a face between rows 3 and 4 and beyond), with entrance rows.
	fn out(rows: Vec<Row>) -> Out {
		let val = vec![1u8; C * C];
		let zq: Vec<i32> = (0..C * C).map(|a| if a / C >= 4 { ((a / C - 3) * 2) as i32 } else { 0 }).collect();
		let grid = run_length(&val.iter().map(|v| v * 16).collect::<Vec<u8>>());
		let height = encode_heights(&val, &zq, C).unwrap();
		Out { grid: Some(grid), height: Some(height), graph: (!rows.is_empty()).then(|| ingame::encode_graph(&rows).unwrap()), ..Default::default() }
	}

	fn decoded(o: &Out) -> Cluster {
		Cluster::decode(C, CS, 2.0, o.grid.as_deref().unwrap(), o.height.as_deref().unwrap(), o.floor.as_deref(), o.class.as_deref(), o.area.as_deref(), o.arc.as_deref()).unwrap()
	}

	fn reaches(c: &Cluster, from: usize, to: usize) -> bool {
		c.dijkstra(&[(from, 0.0, 0.0)], NONE, 3.0, false).0[to].is_finite()
	}

	/// The line between rows 3 and 4 across the whole cluster, every height.
	fn cut() -> Cut {
		Cut { id: "face".into(), map: 0, a: (4.0 * CS, -CS), b: (4.0 * CS, 9.0 * CS), z: (-100.0, 100.0) }
	}

	#[test]
	fn a_cut_takes_the_way_up_out_and_keeps_the_way_down() {
		let (lo, hi) = (3 * C + 3, 6 * C + 3);
		let mut downs = Vec::new();
		let before = decoded(&out(Vec::new()));
		assert!(reaches(&before, lo, hi) && reaches(&before, hi, lo), "his maps alone walk the face both ways");
		let (mut after, gone) = cut_cluster(&geo(), 0, &before, &cut(), &mut downs).unwrap();
		assert_eq!(gone, C, "every straight step up across the line goes (8 cells a row)");
		for &(h, l, len) in &downs {
			after.add_arc(h, l, len * CS);
		}
		assert!(!reaches(&after, lo, hi), "no way up across the line");
		assert!(reaches(&after, hi, lo), "the way down stays");
	}

	#[test]
	fn a_cut_outside_its_height_band_takes_nothing() {
		let mut c = cut();
		c.z = (50.0, 100.0);
		let (after, gone) = cut_cluster(&geo(), 0, &decoded(&out(Vec::new())), &c, &mut Vec::new()).unwrap();
		assert_eq!(gone, 0);
		assert!(reaches(&after, 3 * C + 3, 6 * C + 3));
	}

	/// The entrance below the face to the one above: its edge goes (no walk up is left); the one above to below keeps
	/// its walk down and its cost.
	#[test]
	fn the_edges_follow_the_cut() {
		let edge = |ent: u32, cost: u32| Edge { off: HERE, ent, cost: [cost; 3], yards: cost };
		let rows = vec![Row { cell: (3 * C) as u32, layer: 0, comp: 1, edges: vec![edge(1, 40)] }, Row { cell: (6 * C) as u32, layer: 0, comp: 1, edges: vec![edge(0, 40)] }];
		let mut outs = vec![(0u32, out(rows))];
		let st = super::apply_list(&geo(), &mut outs, &[cut()], &|_| {}).unwrap();
		assert_eq!(st.moves, C);
		let rows = ingame::decode_graph(outs[0].1.graph.as_deref().unwrap()).unwrap();
		assert!(rows[0].edges.is_empty(), "below to above: gone");
		assert_eq!(rows[1].edges.len(), 1, "above to below: kept");
		let after = decoded(&outs[0].1);
		assert!(!reaches(&after, 3 * C + 3, 6 * C + 3) && reaches(&after, 6 * C + 3, 3 * C + 3), "the written cluster: down only");
	}
}
