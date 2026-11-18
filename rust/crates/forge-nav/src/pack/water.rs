//! Leffe's entrance graph priced again with water at another swim factor than the one his maps were baked at
//! (`forge nav pack --leffe --swim <factor>`, maps format 5).
//!
//! His edges carry costs with water at his maps' swim factor (his metadata's `swim`), and the in-game router prices the
//! grid steps inside a walk's start and goal clusters at the factor of the metadata Polestar writes. Writing only
//! another factor would price those steps at one factor and every edge between them at another. So the graph is
//! priced again, cluster by cluster, as the router walks it (pack/ingame.rs: the cluster as Routing/PathGrid.lua decodes
//! it, Routing/Path.lua's grid search over it):
//! - an edge inside a cluster with water (offset HERE) costs what its way saves at the new factor less: the cluster
//!   search from its entrance at both factors, per profile (all three only in a cluster with a hub; elsewhere they are
//!   one). An edge whose way stays dry keeps his cost exactly, and no cost goes past his times the factors' ratio. Its
//!   yards follow the way the new factor takes.
//! - an entrance gains an edge inside its cluster where the new factor makes the way to another entrance cheaper, by
//!   more than ADD_SLACK, than the edges walk it (a swim across a bay that his edges, priced at his factor, go round):
//!   his edges' own cost between the two less the way's saving, as for his. His graph keeps an entrance's edges
//!   sparse (the others are walked through other entrances), so without these the cheaper water would show only in
//!   the clusters a walk starts and ends in. An entrance holds at most DEGREE edges; his are never dropped for one.
//! - an edge across a border is one step (his graph's are 2 to 8 yd), priced by the node it enters: into water it
//!   costs the factors' ratio times his.
//! A dry cluster's edges, and every edge into dry ground, stay as they were. Where an edge goes, one way or both, and
//! which profiles a hostile hub costs more, are his: only the water's price changes. The clusters are the in-game
//! fields `pack/leffe.rs` writes, after the joins and cuts (pack/joins.rs, pack/cuts.rs): their edges are priced again
//! the same way.

use super::ingame::{cost_value, decode_graph, encode_graph, yards_value, Cluster, Edge, Row, HERE};
use super::joins::Geo;
use super::leffe::Out;
use super::{HUB_ALLIANCE, HUB_HORDE, NONE};
use rayon::prelude::*;
use rustc_hash::FxHashMap;

/// An entrance holds at most this many edges (the graph field's degree symbol; pack/leffe.rs).
pub const DEGREE: usize = 63;
/// The factors `--swim` takes: a swum yard never costs less than a run one, and past 10 the water is all but closed.
pub const MIN_FACTOR: f64 = 1.0;
pub const MAX_FACTOR: f64 = 10.0;
/// A new edge goes in only where the edges walk the way dearer by more than this share of their cost (and a yard):
/// across open water nearly every pair of entrances is a little cheaper straight than through a third, and an edge
/// for each would double the graph for nothing a walk notices.
pub const ADD_SLACK: f64 = 0.05;

/// What the repricing did on one map, for the log and PACK.json.
#[derive(Clone, Copy, Debug, Default, PartialEq)]
pub struct WaterStats {
	/// His maps' swim factor and the one the graph is priced at now.
	pub from: f64,
	pub to: f64,
	/// Clusters with water, searched.
	pub clusters: usize,
	/// Edges inside a cluster given another cost, and edges added inside one (and those left out: the entrance's
	/// DEGREE edges were taken).
	pub repriced: usize,
	pub added: usize,
	pub full: usize,
	/// Edges across a border into water.
	pub cross: usize,
}

/// `--swim`'s factor, checked.
pub fn check_factor(f: f64) -> Result<f64, String> {
	if f.is_finite() && (MIN_FACTOR..=MAX_FACTOR).contains(&f) {
		Ok(f)
	} else {
		Err(format!("the swim factor must be a number from {MIN_FACTOR} to {MAX_FACTOR}, got {f}"))
	}
}

/// What the way from one entrance to another of its cluster saves at the new factor, per profile, and its yards
/// (no profile) at his factor and at the new one.
#[derive(Clone, Copy, Debug)]
struct Way {
	save: [f64; 3],
	from_yd: f64,
	to_yd: f64,
}

/// A cost of his (or his edges') less a way's saving, kept between it and it times the factors' ratio.
fn priced(cost: f64, save: f64, lo: f64, hi: f64) -> u32 {
	cost_value((cost - save).clamp(cost * lo, cost * hi))
}

/// The cheapest cost from row r to every row of the cluster over the rows' edges inside it, profile p; u64::MAX where
/// they lead nowhere.
fn row_costs(rows: &[Row], r: usize, p: usize) -> Vec<u64> {
	let mut d = vec![u64::MAX; rows.len()];
	lower(rows, &mut d, r, 0, p);
	d
}

/// `d` (row_costs') with row t reached for cost c, and every row its edges lead to lowered after it.
fn lower(rows: &[Row], d: &mut [u64], t: usize, c: u64, p: usize) {
	if c >= d[t] {
		return;
	}
	d[t] = c;
	let mut heap = std::collections::BinaryHeap::from([std::cmp::Reverse((c, t))]);
	while let Some(std::cmp::Reverse((c, u))) = heap.pop() {
		if c > d[u] {
			continue;
		}
		for e in rows[u].edges.iter().filter(|e| e.off == HERE) {
			let (v, cv) = (e.ent as usize, c + e.cost[p] as u64);
			if v < d.len() && cv < d[v] {
				d[v] = cv;
				heap.push(std::cmp::Reverse((cv, v)));
			}
		}
	}
}

/// Cluster c's entrance rows priced with water at `to` instead of `from` (the first two rules above). -> (edges
/// repriced, added, left out for DEGREE).
pub fn reprice_cluster(c: &Cluster, rows: &mut [Row], from: f64, to: f64) -> (usize, usize, usize) {
	if !c.val.contains(&2) {
		return (0, 0, 0);
	}
	let (lo, hi) = ((to / from).min(1.0), (to / from).max(1.0));
	let hub = c.cls.iter().any(|&b| b & (HUB_ALLIANCE | HUB_HORDE) != 0);
	let profiles: &[usize] = if hub { &[0, 1, 2] } else { &[NONE] };
	let nodes: Vec<Option<usize>> = rows.iter().map(|r| c.surface(r.cell as usize, r.layer as i32, 0.0)).collect();
	let ways: Vec<Vec<Option<Way>>> = nodes
		.iter()
		.enumerate()
		.map(|(r, &node)| {
			let Some(s) = node else { return vec![None; nodes.len()] };
			// (profile, at his factor, at the new one): costs and yards of every node
			let runs: Vec<_> = profiles.iter().map(|&p| (p, c.dijkstra(&[(s, 0.0, 0.0)], p, from, false), c.dijkstra(&[(s, 0.0, 0.0)], p, to, false))).collect();
			let run = |p: usize| runs.iter().find(|x| x.0 == p).unwrap_or(&runs[0]);
			nodes
				.iter()
				.enumerate()
				.map(|(t, &tn)| {
					let tn = tn.filter(|_| t != r)?;
					let mut save = [0.0; 3];
					for (p, s) in save.iter_mut().enumerate() {
						let (_, (a, _), (b, _)) = run(p);
						if !a[tn].is_finite() || !b[tn].is_finite() {
							return None;
						}
						*s = a[tn] - b[tn];
					}
					let (_, (_, ya), (_, yb)) = run(NONE);
					Some(Way { save, from_yd: ya[tn], to_yd: yb[tn] })
				})
				.collect()
		})
		.collect();
	let his = rows.to_vec();
	let mut repriced = 0;
	for (r, row) in rows.iter_mut().enumerate() {
		for e in row.edges.iter_mut().filter(|e| e.off == HERE) {
			let Some(w) = ways[r].get(e.ent as usize).copied().flatten() else { continue };
			if w.save.iter().all(|s| s.abs() <= 0.5) {
				continue;
			}
			let his_cost = e.cost;
			e.cost = [0, 1, 2].map(|p| priced(his_cost[p] as f64, w.save[p], lo, hi));
			if w.save[NONE].abs() > 0.5 {
				e.yards = yards_value(e.yards as f64 + w.to_yd - w.from_yd).max(1);
			}
			repriced += 1;
		}
	}
	let (mut added, mut full) = (0, 0);
	for r in 0..rows.len() {
		let before = [0, 1, 2].map(|p| row_costs(&his, r, p));
		let mut want: Vec<(usize, [u32; 3], f64)> = ways[r]
			.iter()
			.enumerate()
			.filter_map(|(t, w)| {
				let w = w.as_ref().filter(|w| w.save.iter().any(|&s| s > 1.0))?;
				if before.iter().any(|b| b[t] == u64::MAX) {
					return None;
				}
				Some((t, [0, 1, 2].map(|p| priced(before[p][t] as f64, w.save[p], lo, hi)), w.to_yd))
			})
			.collect();
		want.sort_by_key(|w| (w.1[NONE], w.0));
		let mut now = [0, 1, 2].map(|p| row_costs(rows, r, p));
		for (t, cost, yd) in want {
			if !(0..3).any(|p| (cost[p] as f64) < now[p][t] as f64 - (ADD_SLACK * now[p][t] as f64).max(1.0)) {
				continue;
			}
			if rows[r].edges.len() >= DEGREE {
				full += 1;
				continue;
			}
			rows[r].edges.push(Edge { off: HERE, ent: t as u32, cost, yards: yards_value(yd).max(1) });
			added += 1;
			for (p, d) in now.iter_mut().enumerate() {
				lower(rows, d, t, cost[p] as u64, p);
			}
		}
	}
	(repriced, added, full)
}

/// Every cluster of `outs` (one map's, his and the joins' fields; `g` its frame with his swim factor) with its graph
/// priced at swim factor `to` (the rules above): the changed graph fields written back. A cluster without water and
/// with no edge into water keeps its field as it was.
pub(super) fn reprice(g: &Geo, outs: &mut [(u32, Out)], to: f64, log: &(dyn Fn(&str) + Sync)) -> Result<WaterStats, String> {
	let from = g.swim;
	let mut st = WaterStats { from, to, ..Default::default() };
	// Per cluster (by its place in outs): its rows, priced inside it when it has water, whether it has water, the
	// counts; and apart, per row whether its node is water (the edges across a border into it read them).
	type Priced = (Vec<Row>, bool, (usize, usize, usize));
	let (priced, wet): (Vec<Option<Priced>>, Vec<Option<Vec<bool>>>) = outs
		.par_iter()
		.map(|(k, o)| -> Result<(Option<Priced>, Option<Vec<bool>>), String> {
			let (Some(grid), Some(height), Some(graph)) = (o.grid.as_deref(), o.height.as_deref(), o.graph.as_deref()) else { return Ok((None, None)) };
			let c = Cluster::decode(g.c, g.cs, g.zstep, grid, height, o.floor.as_deref(), o.class.as_deref(), o.area.as_deref(), o.arc.as_deref()).map_err(|e| format!("water: cluster {k}: {e}"))?;
			let mut rows = decode_graph(graph).map_err(|e| format!("water: cluster {k}: {e}"))?;
			let wet: Vec<bool> = rows.iter().map(|r| c.surface(r.cell as usize, r.layer as i32, 0.0).is_some_and(|n| c.val[n] == 2)).collect();
			let has = c.val.contains(&2);
			let n = reprice_cluster(&c, &mut rows, from, to);
			Ok((Some((rows, has, n)), Some(wet)))
		})
		.collect::<Result<Vec<_>, String>>()?
		.into_iter()
		.unzip();
	let at: FxHashMap<u32, usize> = outs.iter().enumerate().map(|(i, (k, _))| (*k, i)).collect();
	let ratio = to / from;
	for ((k, o), p) in outs.iter_mut().zip(priced) {
		let Some((mut rows, has, (repriced, added, full))) = p else { continue };
		let mut cross = 0;
		for e in rows.iter_mut().flat_map(|r| r.edges.iter_mut()).filter(|e| e.off != HERE) {
			let there = *k as i64 + (e.off as i64 / 3 - 1) * g.ny + e.off as i64 % 3 - 1;
			let into = u32::try_from(there).ok().and_then(|t| at.get(&t)).and_then(|&i| wet[i].as_ref()).and_then(|w| w.get(e.ent as usize));
			if into == Some(&true) {
				e.cost = e.cost.map(|v| cost_value(v as f64 * ratio).max(1));
				cross += 1;
			}
		}
		st.clusters += has as usize;
		st.repriced += repriced;
		st.added += added;
		st.full += full;
		st.cross += cross;
		if repriced + added + cross > 0 {
			o.graph = Some(encode_graph(&rows)?);
			o.max_degree = o.max_degree.max(rows.iter().map(|r| r.edges.len()).max().unwrap_or(0));
		}
	}
	log(&format!(
		"water: swim {from} -> {to}: {} clusters with water, {} edges inside them repriced, {} added ({} left out: the entrance's {DEGREE} taken), {} across a border into water",
		st.clusters, st.repriced, st.added, st.full, st.cross
	));
	Ok(st)
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::pack::encode::{encode_heights, run_length};

	const C: usize = 5;
	const CS: f64 = 4.0;
	/// A bay: land along x 0 and x 4 and up y 4, water between (x 1-3, y 0-3).
	fn bay(water: bool) -> Cluster {
		let val: Vec<u8> = (0..C * C).map(|a| if water && (1..4).contains(&(a / C)) && a % C < 4 { 2 } else { 1 }).collect();
		let grid = run_length(&val.iter().map(|v| v * 16).collect::<Vec<u8>>());
		let height = encode_heights(&val, &[0; C * C], C).unwrap();
		Cluster::decode(C, CS, 2.0, &grid, &height, None, None, None, None).unwrap()
	}
	fn row(cell: u32, edges: Vec<Edge>) -> Row {
		Row { cell, layer: 0, comp: 1, edges }
	}
	fn edge(ent: u32, cost: u32, yards: u32) -> Edge {
		Edge { off: HERE, ent, cost: [cost; 3], yards }
	}
	fn way(c: &Cluster, a: usize, b: usize, swim: f64) -> (f64, f64) {
		let (g, y) = c.dijkstra(&[(a, 0.0, 0.0)], NONE, swim, false);
		(g[b], y[b])
	}

	/// The factors --swim takes.
	#[test]
	fn the_swim_factor_is_checked() {
		assert_eq!(check_factor(2.0), Ok(2.0));
		for bad in [0.5, 0.0, -2.0, 11.0, f64::NAN, f64::INFINITY] {
			assert!(check_factor(bad).is_err(), "{bad}");
		}
	}

	/// The pack refuses a factor out of range, and one without his maps to price; without one it reads on as before.
	#[test]
	fn a_pack_takes_a_swim_factor_only_for_his_maps() {
		fn run(swim: Option<f64>, leffe: Option<(&std::path::Path, &[u32])>) -> String {
			let p = std::path::Path::new("/nonexistent-forge-nav-water");
			let i = crate::pack::PackIn {
				grid: p,
				layers: p,
				area_table: p,
				zones: p,
				map_frames: p,
				aids: None,
				cells: 128,
				date: "2026-11-18",
				continents: &[0],
				generator: "forge nav pack",
				leffe,
				zlib_literals: false,
				places: None,
				ground_cities: false,
				ledges: false,
				spawns: None,
				swim,
				log: &|_| {},
			};
			crate::pack::pack_nav(&i).err().expect("no grid here")
		}
		let p = std::path::Path::new("/nonexistent-forge-nav-water");
		assert!(run(Some(2.0), None).contains("needs his maps"), "{}", run(Some(2.0), None));
		assert!(run(Some(2.0), Some((p, &[1]))).contains("needs his maps"), "his maps of another continent only");
		assert!(run(Some(0.5), Some((p, &[0]))).contains("swim factor must be"));
		assert!(!run(None, None).contains("swim"), "without one: as before");
		assert!(!run(Some(2.0), Some((p, &[0]))).contains("swim"), "a good factor with his maps reads on");
	}

	/// A cluster with no water keeps every edge as his, whatever the factor.
	#[test]
	fn a_dry_cluster_keeps_its_edges() {
		let c = bay(false);
		let mut rows = vec![row(0, vec![edge(1, 17, 16)]), row(20, vec![edge(0, 17, 16)])];
		let his = rows.clone();
		assert_eq!(reprice_cluster(&c, &mut rows, 3.0, 2.0), (0, 0, 0));
		assert_eq!(rows, his);
	}

	/// Across the bay (cell 0 to cell 20): his edge costs what the way saves at 2 less, its yards follow the way; the
	/// edge along the dry shore (cell 0 to cell 4) keeps his cost and yards exactly.
	#[test]
	fn an_edge_over_water_costs_its_saving_less_and_a_dry_one_stays() {
		let c = bay(true);
		let (g3, y3) = way(&c, 0, 20, 3.0);
		let (g2, y2) = way(&c, 0, 20, 2.0);
		assert!(g3 - g2 > 1.0, "the swim is cheaper at 2: {g3} -> {g2}");
		let mut rows = vec![row(0, vec![edge(1, 41, 17), edge(2, 17, 16)]), row(20, vec![]), row(4, vec![])];
		let (repriced, _, _) = reprice_cluster(&c, &mut rows, 3.0, 2.0);
		assert_eq!(repriced, 1);
		assert_eq!(rows[0].edges[0].cost, [cost_value(41.0 - (g3 - g2)); 3], "his 41 less the saving");
		assert_eq!(rows[0].edges[0].yards, yards_value(17.0 + y2 - y3).max(1));
		assert_eq!(rows[0].edges[1], edge(2, 17, 16), "the shore way is dry: his edge as it was");
		// a factor above his raises the swim, never past his times the ratio
		let mut up = vec![row(0, vec![edge(1, 41, 17)]), row(20, vec![])];
		reprice_cluster(&c, &mut up, 3.0, 6.0);
		assert!(up[0].edges[0].cost[NONE] > 41 && up[0].edges[0].cost[NONE] <= 82, "{:?}", up[0].edges[0]);
	}

	/// His edges go round the bay through a third entrance (cell 4, the corner): at 2 the swim straight across is
	/// cheaper than they walk it, so the entrance gains an edge across: his edges' cost less the swim's saving.
	#[test]
	fn an_entrance_gains_the_edge_across_the_water_his_edges_go_round() {
		let c = bay(true);
		let (g3, _) = way(&c, 0, 20, 3.0);
		let (g2, y2) = way(&c, 0, 20, 2.0);
		let mut rows = vec![row(0, vec![edge(2, 17, 16)]), row(20, vec![]), row(4, vec![edge(1, 34, 32)])];
		let (_, added, full) = reprice_cluster(&c, &mut rows, 3.0, 2.0);
		assert_eq!((added, full), (1, 0));
		let via = 17 + rows[2].edges[0].cost[NONE];
		let across = rows[0].edges.iter().find(|e| e.ent == 1).expect("an edge across");
		assert_eq!(across.cost, [cost_value((51.0 - (g3 - g2)).clamp(51.0 * 2.0 / 3.0, 51.0)); 3], "his 17 + 34 less the swim's saving");
		assert!((across.cost[NONE] as f64) < via as f64 * (1.0 - ADD_SLACK), "cheaper than round the shore ({via})");
		assert_eq!(across.yards, yards_value(y2));
		// at his own factor nothing is added or changed
		let mut same = vec![row(0, vec![edge(2, 17, 16)]), row(20, vec![]), row(4, vec![edge(1, 34, 32)])];
		let his = same.clone();
		assert_eq!(reprice_cluster(&c, &mut same, 3.0, 3.0), (0, 0, 0));
		assert_eq!(same, his);
	}

	/// An edge across a border is priced by the node it enters: into the bay's water at the ratio, onto its dry
	/// shore as it was; the dry cluster's field is written back only for its edge into water.
	#[test]
	fn an_edge_across_a_border_into_water_takes_the_ratio() {
		let fields = |c: &Cluster, rows: &[Row]| Out { grid: Some(c.grid.clone()), height: Some(c.height.clone()), graph: Some(encode_graph(rows).unwrap()), ..Default::default() };
		// cluster 0 (dry) left of cluster 1 (the bay): off 7 is +x (dx 1, dy 0)
		let dry = bay(false);
		let wet = bay(true);
		let into = |ent: u32| Edge { off: 7, ent, cost: [30, 31, 32], yards: 4 };
		let r0 = vec![row(20, vec![into(0), into(1)])];
		let r1 = vec![row(5, vec![]), row(0, vec![])]; // cell 5 is water (x 1, y 0), cell 0 the shore
		let mut outs = vec![(0, fields(&dry, &r0)), (1, fields(&wet, &r1))];
		let g = Geo { c: C, cs: CS, zstep: 2.0, x0: 0.0, y0: 0.0, ny: 1, swim: 3.0 };
		let st = reprice(&g, &mut outs, 2.0, &|_| {}).unwrap();
		assert_eq!((st.from, st.to, st.clusters, st.cross), (3.0, 2.0, 1, 1));
		let rows = decode_graph(outs[0].1.graph.as_deref().unwrap()).unwrap();
		assert_eq!(rows[0].edges[0].cost, [20, 21, 21], "into water: his costs times 2/3, rounded");
		assert_eq!(rows[0].edges[1], into(1), "onto the shore: as it was");
		assert_eq!(outs[1].1.graph.as_deref(), Some(encode_graph(&r1).unwrap().as_str()), "the bay's rows have no edge: its field as it was");
	}
}
