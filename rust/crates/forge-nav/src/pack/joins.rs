//! Grid joins (`forge nav pack --leffe`): walks players make that our navigation grid makes and Leffe's navigation
//! maps do not: a mine his maps cut off from its mouth, a tower's top, a stretch of road, rope bridges (Fitz,
//! 2026-10-25: where his maps have no walkable surface and our grid does, fill from our grid in the pack builder).
//! Each join of joins.json (two places, compiled in) is routed on our grid both ways (Walker::route_path: the guide
//! bake's drawn way), and that way goes into the clusters of his maps it crosses:
//! - each of its cells stands on his surface there nearest the way's height (within MATCH_YD), else on a floor of ours
//!   added after the cell's floors (with our surface's value, class and area), so every entrance keeps its layer;
//! - a step of the way his maps cannot make is added: an arc inside a cluster, an entrance on each side and an edge
//!   between them across a cluster border;
//! - each entrance of a cluster the way changed gets an edge to every entrance of the cluster it now reaches for
//!   less, priced as the router prices the grid (pack/ingame.rs);
//! - the components the way joins become one (Path.lua answers "unreachable" without a search when the start's and
//!   the goal's entrances share none).
//!
//! A way with a climb his maps lack is refused (Forever's client slides off a face over 60 degrees), a way off his maps
//! is refused, and a lift ride is left to the lift chokepoints. A way his maps already make adds nothing.

use super::cells::{CellGrid, ZQ};
use super::ingame::{self, cost_value, yards_value, Cluster, Edge, Row, HERE};
use super::leffe::Out;
use super::NONE;
use crate::cost::{Ground, Profile};
use crate::grid::{cls, Grid};
use crate::legs::SnapAsk;
use crate::space::WayCell;
use crate::walker::Walker;
use rayon::prelude::*;
use rustc_hash::{FxHashMap, FxHashSet};
use std::collections::{BTreeMap, BTreeSet};
use std::path::Path;
use std::sync::Arc;

/// A cell of the way stands on his surface when its height is within this of the way's (his base heights are stored
/// to 2 yd, his floors to 1 yd; our columns are half his cells, so a slope differs by a few yards across one).
pub const MATCH_YD: f64 = 3.5;
/// A step of the way his maps make by a walk of at most this cost (yd at plain ground's price) needs no arc or
/// entrance: his surfaces lie a little differently from our columns, and the way is not his only walk.
const NEAR: f64 = 40.0;
/// An entrance keeps at most this many edges (the graph field's degree symbol).
const DEGREE: usize = 63;
/// The component a new entrance has until the merge gives it one.
const UNSET: u32 = u32::MAX;

/// A join as joins.json writes it: two places on one map, routed both ways.
#[derive(Clone, Debug)]
pub struct Join {
	pub id: String,
	pub map: u32,
	pub a: (f64, f64, Option<f64>),
	pub b: (f64, f64, Option<f64>),
}

/// The joins of joins.json (compiled in).
pub fn joins() -> Vec<Join> {
	let v: serde_json::Value = serde_json::from_str(include_str!("joins.json")).expect("joins.json");
	let end = |e: &serde_json::Value| (e[0].as_f64().expect("joins.json: x"), e[1].as_f64().expect("joins.json: y"), e[2].as_f64());
	v["joins"]
		.as_array()
		.expect("joins.json: joins")
		.iter()
		.map(|j| Join { id: j["id"].as_str().expect("joins.json: id").to_string(), map: j["map"].as_u64().expect("joins.json: map") as u32, a: end(&j["a"]), b: end(&j["b"]) })
		.collect()
}

/// One direction of a join: its id ("<id> a-b" or "b-a") and our grid's drawn way.
#[derive(Clone, Debug)]
pub struct JoinWay {
	pub id: String,
	pub cells: Vec<WayCell>,
}

/// Our grid's drawn way of each join of `map`, both ways: a walk for no faction, as the guide bake draws a leg
/// (Walker::route_path). `hubs`: the ground layers' hubs.json, when there is one. A join our grid cannot walk is logged
/// and left out.
pub fn ways(grid_dir: &Path, map: u32, hubs: Option<&Path>, log: &(dyn Fn(&str) + Sync)) -> Result<Vec<JoinWay>, String> {
	let list: Vec<Join> = joins().into_iter().filter(|j| j.map == map).collect();
	if list.is_empty() {
		return Ok(Vec::new());
	}
	let grid = Arc::new(Grid::open(grid_dir, 256)?);
	let walk = grid_dir.join("walk");
	let roads = std::fs::read_dir(&walk)
		.map_err(|e| format!("joins: {}: {e}", walk.display()))?
		.flatten()
		.filter_map(|e| e.file_name().to_str()?.strip_prefix("roads-0-")?.strip_suffix(".bin").map(String::from))
		.min()
		.ok_or_else(|| format!("joins: no walk/roads-0-<tag>.bin in {} (forge nav prepare)", grid_dir.display()))?;
	let hubs = hubs.and_then(|h| std::fs::read(h).ok());
	let ground = Arc::new(Ground::load(grid_dir, &roads, &[map], hubs.as_deref())?);
	let profile = Profile::walk(None, ground, None);
	let walker = Walker::new(grid);
	let ask = |e: (f64, f64, Option<f64>)| SnapAsk { c: map, wx: e.0, wy: e.1, z: e.2, radius: 20.0, under: true, stand: true };
	let mut out = Vec::new();
	for j in list {
		for (dir, a, b) in [("a-b", j.a, j.b), ("b-a", j.b, j.a)] {
			let id = format!("{} {dir}", j.id);
			match walker.route_path(&ask(a), &ask(b), &profile, "")? {
				Some(w) => out.push(JoinWay { id, cells: w.cells }),
				None => log(&format!("join {id}: our grid has no way")),
			}
		}
	}
	Ok(out)
}

/// What the joins added, for the log and PACK.json.
#[derive(Clone, Debug, Default)]
pub struct JoinStats {
	pub ways: usize,
	pub refused: usize,
	/// Ways his maps already made.
	pub walkable: usize,
	pub floors: usize,
	pub arcs: usize,
	pub entrances: usize,
	pub edges: usize,
	/// Components joined into another.
	pub merged: usize,
	pub clusters: usize,
}

/// The frame of his maps.
pub struct Geo {
	pub c: usize,
	pub cs: f64,
	pub zstep: f64,
	pub x0: f64,
	pub y0: f64,
	pub ny: i64,
	pub swim: f64,
}

/// A cell of the way on his cells: cluster, local cell, global cell, the way's height, the class of the step into
/// it (crate::grid::cls), and its flat yards from the cell before.
#[derive(Clone, Copy, Debug)]
struct Pt {
	k: u32,
	lc: usize,
	gx: i64,
	gy: i64,
	z: f64,
	cls: u8,
	yd: f64,
}

fn points(g: &Geo, cells: &[WayCell]) -> Option<Vec<Pt>> {
	let c = g.c as i64;
	let mut out = Vec::with_capacity(cells.len());
	for (i, w) in cells.iter().enumerate() {
		let (gx, gy) = (((w.x - g.x0) / g.cs).floor() as i64, ((w.y - g.y0) / g.cs).floor() as i64);
		if gx < 0 || gy < 0 {
			return None;
		}
		let yd = if i == 0 { 0.0 } else { (w.x - cells[i - 1].x).hypot(w.y - cells[i - 1].y) };
		out.push(Pt { k: ((gx / c) * g.ny + gy / c) as u32, lc: ((gx % c) * c + gy % c) as usize, gx, gy, z: w.z, cls: w.cls, yd });
	}
	Some(out)
}

/// Our surface in global cell (gx, gy) nearest height z, within MATCH_YD: its value, class and area.
fn ours(cg: &CellGrid, gx: i64, gy: i64, z: f64) -> Option<(u8, u8, u32)> {
	let (_, l) = cg.at(gx, gy)?;
	let cell = (gx as usize * cg.gh + gy as usize) as u32;
	let cl = cg.cluster(cg.cluster_of_cell(cell))?;
	let mut best: Option<((u8, u8, u32), f64)> = None;
	if cl.val[l] != 0 {
		let g = (cl.zq[l] as f64 * ZQ as f64 - z).abs();
		best = Some(((cl.val[l], cl.cls.as_ref().map_or(0, |v| v[l]), cl.area.as_ref().map_or(0, |a| a[l])), g));
	}
	if let Some(&f0) = cg.floor_at.get(&cell) {
		let mut f = f0 as usize;
		while f < cg.floor_cell.len() && cg.floor_cell[f] == cell {
			let g = (cg.floor_z[f] - z).abs();
			if best.is_none_or(|b| g < b.1) {
				best = Some(((cg.floor_val[f], cg.floor_class[f], cg.floor_area[f]), g));
			}
			f += 1;
		}
	}
	best.filter(|b| b.1 <= MATCH_YD).map(|b| b.0)
}

/// His surface the way's cell stands on.
fn matched(c: &Cluster, p: &Pt) -> Option<usize> {
	c.surface(p.lc, -1, p.z).filter(|&v| (c.z[v] - p.z).abs() <= MATCH_YD)
}

fn has_move(c: &Cluster, a: usize, b: usize, buf: &mut Vec<(usize, f64)>) -> bool {
	c.moves(a, false, buf);
	buf.iter().any(|m| m.0 == b)
}

/// The octile distance between two nodes' cells, in cells (a step no shorter keeps Path.lua's heuristics consistent).
fn octile(c: &Cluster, a: usize, b: usize) -> f64 {
	let (ca, cb) = (c.cell(a) as i64, c.cell(b) as i64);
	let n = c.c as i64;
	let (dx, dy) = ((ca / n - cb / n).abs() as f64, (ca % n - cb % n).abs() as f64);
	dx.max(dy) + (std::f64::consts::SQRT_2 - 1.0) * dx.min(dy)
}

/// The row of cluster `rows` at node's cell and layer, made (component unset) when it has none. -> (row, made).
fn row_at(c: &Cluster, rows: &mut Vec<Row>, node: usize) -> Result<(usize, bool), String> {
	let (cell, layer) = (c.cell(node) as u32, c.layer(node));
	if let Some(r) = rows.iter().position(|r| r.cell == cell && r.layer == layer) {
		return Ok((r, false));
	}
	if rows.len() >= 4095 || layer >= 64 {
		return Err(format!("joins: no room for an entrance at cell {cell} layer {layer}"));
	}
	rows.push(Row { cell, layer, comp: UNSET, edges: Vec::new() });
	Ok((rows.len() - 1, true))
}

/// The component ids a graph field's rows carry (each row's 2 symbols after its cell and layer).
fn comps_of(s: &str) -> Vec<u32> {
	let b = s.as_bytes();
	let v = |i: usize| super::B64.iter().position(|&c| c == b[i]).unwrap_or(0) as u32;
	let n = (v(0) * 64 + v(1)) as usize;
	(0..n).map(|r| v(2 + r * 7 + 4) * 64 + v(2 + r * 7 + 5)).collect()
}

/// The graph field with each row's component replaced by `to`'s.
fn relabel(s: &str, to: &FxHashMap<u32, u32>) -> String {
	let comps = comps_of(s);
	let mut b = s.as_bytes().to_vec();
	for (r, c) in comps.into_iter().enumerate() {
		if let Some(&n) = to.get(&c) {
			let n = n.min(4095);
			b[2 + r * 7 + 4] = super::B64[(n / 64) as usize];
			b[2 + r * 7 + 5] = super::B64[(n % 64) as usize];
		}
	}
	String::from_utf8(b).expect("graph field is base64")
}

fn find(parent: &mut FxHashMap<u32, u32>, x: u32) -> u32 {
	let mut r = x;
	while let Some(&p) = parent.get(&r) {
		if p == r {
			break;
		}
		r = p;
	}
	let mut y = x;
	while y != r {
		let p = parent[&y];
		parent.insert(y, r);
		y = p;
	}
	r
}

/// Joins the sets of a and b. -> the set ids kept and gone, None when already one.
fn union(parent: &mut FxHashMap<u32, u32>, a: u32, b: u32) -> Option<(u32, u32)> {
	parent.entry(a).or_insert(a);
	parent.entry(b).or_insert(b);
	let (ra, rb) = (find(parent, a), find(parent, b));
	if ra == rb {
		return None;
	}
	// the smaller id stays: the component his maps already call it
	let (keep, gone) = if ra < rb { (ra, rb) } else { (rb, ra) };
	parent.insert(gone, keep);
	Some((keep, gone))
}

/// Cluster edges after a join: each entrance (row) gets an edge to every entrance of its cluster it reaches for less
/// with the join's floors and arcs than before (`bf`, the cluster before them), priced per profile as the router prices
/// the grid; only rows whose search meets the way (`marks`, the way's nodes) can gain one. -> the (row, row) pairs
/// given or lowered an edge, and how many edges are new.
fn cluster_edges(after: &Cluster, rows: &mut [Row], bf: &Cluster, marks: &[usize], swim: f64) -> (Vec<(usize, usize)>, usize) {
	let nodes_after: Vec<Option<usize>> = rows.iter().map(|r| after.surface(r.cell as usize, r.layer as i32, 0.0)).collect();
	let nodes_before: Vec<Option<usize>> = rows.iter().map(|r| if r.comp == UNSET { None } else { bf.surface(r.cell as usize, r.layer as i32, 0.0) }).collect();
	let (mut pairs, mut made) = (Vec::new(), 0);
	for r in 0..rows.len() {
		let Some(ra) = nodes_after[r] else { continue };
		let none_after = after.dijkstra(&[(ra, 0.0, 0.0)], NONE, swim, false);
		if !marks.iter().any(|&m| none_after.0[m].is_finite()) {
			continue;
		}
		let ga = [after.dijkstra(&[(ra, 0.0, 0.0)], 0, swim, false).0, after.dijkstra(&[(ra, 0.0, 0.0)], 1, swim, false).0, none_after.0];
		let gb = nodes_before[r].map(|rb| [0, 1, 2].map(|p| bf.dijkstra(&[(rb, 0.0, 0.0)], p, swim, false).0));
		let mut new = FxHashSet::default();
		for t in 0..rows.len() {
			let Some(ta) = nodes_after[t].filter(|_| t != r) else { continue };
			let ca = [ga[0][ta], ga[1][ta], ga[2][ta]];
			if !ca[NONE].is_finite() {
				continue;
			}
			let cb = match (&gb, nodes_before[t]) {
				(Some(gb), Some(tb)) => [gb[0][tb], gb[1][tb], gb[2][tb]],
				_ => [f64::INFINITY; 3],
			};
			if !(0..3).any(|p| ca[p] < cb[p] - 1.0) {
				continue;
			}
			let rec = Edge { off: HERE, ent: t as u32, cost: ca.map(cost_value), yards: yards_value(none_after.1[ta]) };
			match rows[r].edges.iter_mut().find(|e| e.off == HERE && e.ent == t as u32) {
				Some(e) => {
					if rec.cost[NONE] < e.cost[NONE] {
						e.yards = rec.yards;
					}
					for p in 0..3 {
						e.cost[p] = e.cost[p].min(rec.cost[p]);
					}
				}
				None => {
					rows[r].edges.push(rec);
					made += 1;
				}
			}
			new.insert(t as u32);
			pairs.push((r, t));
		}
		if rows[r].edges.len() > DEGREE {
			// the join's edges stay; the dearest of the others go, as for his edges past 63
			let mut e = std::mem::take(&mut rows[r].edges);
			e.sort_by_key(|x| (!(x.off == HERE && new.contains(&x.ent)), x.cost[NONE]));
			e.truncate(DEGREE);
			rows[r].edges = e;
		}
	}
	(pairs, made)
}

/// Puts the ways into the clusters of `outs` (his clusters as written, by cluster key). -> what was added, and the
/// area rows of the floors added.
pub(super) fn apply(g: &Geo, outs: &mut [(u32, Out)], ways: &[JoinWay], cg: &CellGrid, log: &(dyn Fn(&str) + Sync)) -> Result<(JoinStats, BTreeSet<u32>), String> {
	let mut st = JoinStats::default();
	let mut areas = BTreeSet::new();
	if ways.is_empty() {
		return Ok((st, areas));
	}
	let at: FxHashMap<u32, usize> = outs.iter().enumerate().map(|(i, (k, _))| (*k, i)).collect();
	let pts: Vec<Option<Vec<Pt>>> = ways.iter().map(|w| points(g, &w.cells)).collect();
	// every cluster of his a way crosses, decoded
	let mut cl: BTreeMap<u32, (Cluster, Vec<Row>)> = BTreeMap::new();
	for p in pts.iter().flatten().flatten() {
		if cl.contains_key(&p.k) {
			continue;
		}
		let Some(&i) = at.get(&p.k) else { continue };
		let o = &outs[i].1;
		let (Some(grid), Some(height)) = (o.grid.as_deref(), o.height.as_deref()) else { continue };
		let c = Cluster::decode(g.c, g.cs, g.zstep, grid, height, o.floor.as_deref(), o.class.as_deref(), o.area.as_deref(), o.arc.as_deref()).map_err(|e| format!("joins: cluster {}: {e}", p.k))?;
		let rows = o.graph.as_deref().map(ingame::decode_graph).transpose().map_err(|e| format!("joins: cluster {}: {e}", p.k))?.unwrap_or_default();
		cl.insert(p.k, (c, rows));
	}
	let before: BTreeMap<u32, Cluster> = cl.iter().map(|(k, (c, _))| (*k, c.clone())).collect();
	let mut buf = Vec::new();
	// refusals: off his maps, or a climb he lacks
	let mut keep = vec![true; ways.len()];
	for (w, p) in pts.iter().enumerate() {
		let why = match p {
			None => Some("off the map's frame".to_string()),
			Some(p) if p.iter().any(|q| !cl.contains_key(&q.k)) => Some("crosses a cluster his maps have no data for".to_string()),
			Some(p) => (1..p.len()).find_map(|i| {
				if p[i].cls != cls::CLIMB {
					return None;
				}
				let c = &cl[&p[i].k].0;
				let has = p[i - 1].k == p[i].k && matches!((matched(c, &p[i - 1]), matched(c, &p[i])), (Some(a), Some(b)) if a == b || has_move(c, a, b, &mut buf));
				(!has).then(|| format!("climbs a face his maps lack at {:.1},{:.1}", ways[w].cells[i].x, ways[w].cells[i].y))
			}),
		};
		if let Some(why) = why {
			keep[w] = false;
			st.refused += 1;
			log(&format!("join {}: refused: {why}", ways[w].id));
		}
	}
	// floors of ours where his maps have no surface near the way
	let mut changed: BTreeSet<u32> = BTreeSet::new();
	let mut added = vec![(0usize, 0usize, 0usize); ways.len()]; // per way: floors, arcs, edges
	for (w, p) in pts.iter().enumerate() {
		let Some(p) = p.as_ref().filter(|_| keep[w]) else { continue };
		for q in p {
			let c = &mut cl.get_mut(&q.k).unwrap().0;
			if matched(c, q).is_some() {
				continue;
			}
			let (val, class, area) = ours(cg, q.gx, q.gy, q.z).unwrap_or((1, 0, 0));
			c.add_floor(q.lc, val.max(1), q.z, class, area);
			if area != 0 {
				areas.insert(area);
			}
			st.floors += 1;
			added[w].0 += 1;
			changed.insert(q.k);
		}
	}
	// the way's steps his maps cannot make: arcs inside a cluster, entrances and an edge across a border
	let mut on_way: FxHashMap<u32, FxHashSet<usize>> = FxHashMap::default();
	let mut joined: Vec<((u32, usize), (u32, usize))> = Vec::new();
	for (w, p) in pts.iter().enumerate() {
		let Some(p) = p.as_ref().filter(|_| keep[w]) else { continue };
		// the way as nodes of his: consecutive cells on one node are one, keeping the hardest step into it and the yards
		let mut seq: Vec<(u32, usize, Pt)> = Vec::new();
		for q in p {
			let node = matched(&cl[&q.k].0, q).ok_or_else(|| format!("joins: {}: no surface at cluster {} cell {} after the floors", ways[w].id, q.k, q.lc))?;
			on_way.entry(q.k).or_default().insert(node);
			match seq.last_mut() {
				Some(last) if last.0 == q.k && last.1 == node => {
					last.2.yd += q.yd;
					if q.cls == cls::LIFT || (q.cls == cls::FALL || q.cls == cls::JUMP) && last.2.cls != cls::LIFT {
						last.2.cls = q.cls;
					}
				}
				_ => seq.push((q.k, node, *q)),
			}
		}
		for i in 1..seq.len() {
			let ((ka, a, pa), (kb, b, pb)) = (seq[i - 1], seq[i]);
			if pb.cls == cls::LIFT {
				continue;
			}
			if ka == kb {
				let c = &mut cl.get_mut(&ka).unwrap().0;
				if !has_move(c, a, b, &mut buf) && !c.bounded(a, NEAR, NONE, g.swim).contains_key(&b) {
					let yards = pb.yd.max(octile(c, a, b) * g.cs);
					c.add_arc(a, b, yards);
					st.arcs += 1;
					added[w].1 += 1;
					changed.insert(ka);
				}
				continue;
			}
			let (dkx, dky) = (kb as i64 / g.ny - ka as i64 / g.ny, kb as i64 % g.ny - ka as i64 % g.ny);
			if dkx.abs() > 1 || dky.abs() > 1 || (pa.gx - pb.gx).abs() > 1 || (pa.gy - pb.gy).abs() > 1 {
				log(&format!("join {}: a step from cluster {ka} to {kb} that is no neighbour's, left out", ways[w].id));
				continue;
			}
			let off = ((dkx + 1) * 3 + dky + 1) as u32;
			// His maps cross this border near the way already: an entrance the way's cell reaches within NEAR, its edge
			// across, and the way's next cell within NEAR of that edge's end.
			let crosses = {
				let ((ca, rows_a), (cb, rows_b)) = (&cl[&ka], &cl[&kb]);
				let from_a = ca.bounded(a, NEAR, NONE, g.swim);
				rows_a.iter().any(|r| {
					ca.surface(r.cell as usize, r.layer as i32, 0.0).is_some_and(|n| from_a.contains_key(&n))
						&& r.edges.iter().any(|e| {
							e.off == off
								&& rows_b
									.get(e.ent as usize)
									.and_then(|t| cb.surface(t.cell as usize, t.layer as i32, 0.0))
									.is_some_and(|tn| tn == b || cb.bounded(tn, NEAR, NONE, g.swim).contains_key(&b))
						})
				})
			};
			if crosses {
				continue;
			}
			let (ra, made_a) = {
				let (c, rows) = cl.get_mut(&ka).unwrap();
				row_at(c, rows, a)?
			};
			let (rb, made_b) = {
				let (c, rows) = cl.get_mut(&kb).unwrap();
				row_at(c, rows, b)?
			};
			st.entrances += made_a as usize + made_b as usize;
			let len = if pa.gx != pb.gx && pa.gy != pb.gy { std::f64::consts::SQRT_2 } else { 1.0 };
			let cost: [u32; 3] = {
				let c = &cl[&kb].0;
				[0, 1, 2].map(|p| cost_value(c.step_cost(b, len, p, g.swim)))
			};
			let rows = &mut cl.get_mut(&ka).unwrap().1;
			if !rows[ra].edges.iter().any(|e| e.off == off && e.ent == rb as u32) {
				rows[ra].edges.push(Edge { off, ent: rb as u32, cost, yards: yards_value(len * g.cs) });
				st.edges += 1;
				added[w].2 += 1;
				joined.push(((ka, ra), (kb, rb)));
			}
			changed.insert(ka);
			changed.insert(kb);
		}
	}
	// each entrance of a changed cluster: an edge to every entrance it now reaches for less (clusters side by side)
	let mut work: Vec<(u32, &mut (Cluster, Vec<Row>))> = cl.iter_mut().filter(|(k, _)| changed.contains(*k)).map(|(k, v)| (*k, v)).collect();
	let priced: Vec<(u32, Vec<(usize, usize)>, usize)> = work
		.par_iter_mut()
		.map(|(k, (after, rows))| {
			let marks: Vec<usize> = on_way.get(&*k).map(|s| s.iter().copied().collect()).unwrap_or_default();
			let (pairs, made) = cluster_edges(after, rows, &before[&*k], &marks, g.swim);
			(*k, pairs, made)
		})
		.collect();
	for (k, pairs, made) in priced {
		st.edges += made;
		joined.extend(pairs.into_iter().map(|(r, t)| ((k, r), (k, t))));
	}
	// components: the ones the joins join become one; a new entrance takes the component of what it joins
	let mut parent: FxHashMap<u32, u32> = FxHashMap::default();
	let mut fresh = outs.iter().filter_map(|(_, o)| o.graph.as_deref()).flat_map(comps_of).max().unwrap_or(0) + 1;
	let first_fresh = fresh;
	for (_, rows) in cl.values_mut() {
		for r in rows.iter_mut().filter(|r| r.comp == UNSET) {
			r.comp = fresh;
			fresh += 1;
		}
	}
	for &((ka, ra), (kb, rb)) in &joined {
		let (a, b) = (cl[&ka].1[ra].comp, cl[&kb].1[rb].comp);
		// (two of his components joined; a new entrance only takes the component of what it joins)
		if union(&mut parent, a, b).is_some_and(|(keep, gone)| keep < first_fresh && gone < first_fresh) {
			st.merged += 1;
		}
	}
	let keys: Vec<u32> = parent.keys().copied().collect();
	let to: FxHashMap<u32, u32> = keys.into_iter().map(|c| (c, find(&mut parent, c))).filter(|(c, r)| c != r).collect();
	for (_, rows) in cl.values_mut() {
		for r in rows.iter_mut() {
			if let Some(&n) = to.get(&r.comp) {
				r.comp = n;
			}
		}
	}
	// written back: the changed clusters' fields, every other graph's components
	st.clusters = changed.len();
	for (k, o) in outs.iter_mut() {
		if let Some((c, rows)) = cl.get(k).filter(|_| changed.contains(k)) {
			o.floor = c.floor_field()?;
			o.class = Some(c.class_field());
			o.area = c.area_field()?;
			o.arc = c.arc_field();
			o.graph = if rows.is_empty() { None } else { Some(ingame::encode_graph(rows)?) };
			o.max_degree = rows.iter().map(|r| r.edges.len()).max().unwrap_or(0).max(o.max_degree);
			o.stats.entrances = rows.len();
			o.areas.extend(c.area.iter().copied().filter(|&a| a != 0));
		} else if !to.is_empty() {
			if let Some(s) = o.graph.as_deref() {
				o.graph = Some(relabel(s, &to));
			}
		}
	}
	for (w, way) in ways.iter().enumerate() {
		if !keep[w] {
			continue;
		}
		st.ways += 1;
		let (f, a, e) = added[w];
		if f + a + e == 0 {
			st.walkable += 1;
			log(&format!("join {}: his maps make it already", way.id));
		} else {
			log(&format!("join {}: {} cells of our grid, {f} floors, {a} arcs, {e} border edges added", way.id, way.cells.len()));
		}
	}
	Ok((st, areas))
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::pack::encode::{encode_heights, run_length};

	const C: usize = 8;
	const CS: f64 = 1600.0 / 3.0 / 128.0;

	fn geo(ny: i64) -> Geo {
		Geo { c: C, cs: CS, zstep: 2.0, x0: 0.0, y0: 0.0, ny, swim: 3.0 }
	}

	/// A cluster of plain ground at height 0 but the `blocked` cells, with entrance rows.
	fn out(blocked: &[(usize, usize)], rows: Vec<Row>) -> Out {
		let mut val = vec![1u8; C * C];
		for &(x, y) in blocked {
			val[x * C + y] = 0;
		}
		let grid = run_length(&val.iter().map(|v| v * 16).collect::<Vec<u8>>());
		let height = encode_heights(&val, &vec![0; C * C], C).unwrap();
		Out { grid: Some(grid), height: Some(height), graph: (!rows.is_empty()).then(|| ingame::encode_graph(&rows).unwrap()), ..Default::default() }
	}

	fn decoded(o: &Out) -> Cluster {
		Cluster::decode(C, CS, 2.0, o.grid.as_deref().unwrap(), o.height.as_deref().unwrap(), o.floor.as_deref(), o.class.as_deref(), o.area.as_deref(), o.arc.as_deref()).unwrap()
	}

	/// Our grid's way through global cells (gx, gy), at height 0, each cell's centre.
	fn way(id: &str, cells: &[(i64, i64)]) -> JoinWay {
		JoinWay { id: id.into(), cells: cells.iter().map(|&(x, y)| WayCell { x: (x as f64 + 0.5) * CS, y: (y as f64 + 0.5) * CS, z: 0.0, floor: 0, cls: cls::WALK }).collect() }
	}

	fn reaches(c: &Cluster, from: usize, to: usize) -> bool {
		c.dijkstra(&[(from, 0.0, 0.0)], NONE, 3.0, false).0[to].is_finite()
	}

	/// A wall his maps have across the way (a mine's shaft he lacks): the way's cell there gets a floor of ours, and
	/// arcs join it to his ground either side, so the search walks through.
	#[test]
	fn a_gap_inside_a_cluster_gets_a_floor_and_arcs_and_walks() {
		let wall: Vec<(usize, usize)> = (0..C).map(|y| (4, y)).collect();
		let mut outs = vec![(0u32, out(&wall, Vec::new()))];
		let (a, b) = (3 * C + 2, 5 * C + 2);
		assert!(!reaches(&decoded(&outs[0].1), a, b), "his maps alone: the wall cuts the cluster in two");
		let cg = CellGrid::new(C, 1, 1, 0, 0);
		let (st, _) = apply(&geo(1), &mut outs, &[way("mine a-b", &[(3, 2), (4, 2), (5, 2)]), way("mine b-a", &[(5, 2), (4, 2), (3, 2)])], &cg, &|_| {}).unwrap();
		assert_eq!((st.ways, st.floors, st.arcs, st.refused), (2, 1, 4, 0), "one floor in the wall's cell, an arc each way either side: {st:?}");
		let c = decoded(&outs[0].1);
		assert_eq!(c.t(), C * C + 1, "the floor is in the written floor field");
		assert!(reaches(&c, a, b) && reaches(&c, b, a), "the way walks both ways through the wall's cell");
	}

	/// A way his maps make already adds nothing.
	#[test]
	fn a_way_his_maps_make_adds_nothing() {
		let mut outs = vec![(0u32, out(&[], Vec::new()))];
		let before = outs[0].1.grid.clone();
		let cg = CellGrid::new(C, 1, 1, 0, 0);
		let (st, _) = apply(&geo(1), &mut outs, &[way("plain a-b", &[(1, 1), (2, 2), (3, 3)])], &cg, &|_| {}).unwrap();
		assert_eq!((st.walkable, st.floors, st.arcs, st.edges, st.clusters), (1, 0, 0, 0, 0));
		assert_eq!(outs[0].1.grid, before);
		assert!(outs[0].1.floor.is_none() && outs[0].1.arc.is_none());
	}

	/// Two clusters side by side his maps never join (no entrance on their border): the way across gets an entrance
	/// on each side and an edge between them, each cluster's entrance an edge to the new one, and the two components
	/// become one.
	#[test]
	fn a_way_across_a_border_gets_entrances_edges_and_one_component() {
		let row = |cell: usize, comp: u32| Row { cell: cell as u32, layer: 0, comp, edges: Vec::new() };
		// cluster 0: global y 0..8, cluster 1: global y 8..16 (ny 2: cluster k = gx / C * 2 + gy / C)
		let mut outs = vec![(0u32, out(&[], vec![row(C + 1, 7)])), (1u32, out(&[], vec![row(C + 6, 9)]))];
		let cg = CellGrid::new(C, 1, 2, 0, 0);
		let cells: Vec<(i64, i64)> = (5..12).map(|y| (1, y)).collect();
		let back: Vec<(i64, i64)> = cells.iter().rev().copied().collect();
		let (st, _) = apply(&geo(2), &mut outs, &[way("road a-b", &cells), way("road b-a", &back)], &cg, &|_| {}).unwrap();
		assert_eq!(st.entrances, 2, "{st:?}");
		assert_eq!(st.merged, 1, "the two components become one: {st:?}");
		let r0 = ingame::decode_graph(outs[0].1.graph.as_deref().unwrap()).unwrap();
		let r1 = ingame::decode_graph(outs[1].1.graph.as_deref().unwrap()).unwrap();
		assert!(r0.iter().chain(&r1).all(|r| r.comp == 7), "every entrance in component 7: {r0:?} {r1:?}");
		// cluster 0's own entrance reaches the new border entrance, which crosses to cluster 1's, which reaches cluster
		// 1's own entrance
		let (old0, new0) = (0usize, r0.iter().position(|r| r.cell as usize == C + 7).expect("an entrance at the border, cluster 0"));
		let new1 = r1.iter().position(|r| r.cell as usize == C).expect("an entrance at the border, cluster 1");
		assert!(r0[old0].edges.iter().any(|e| e.off == HERE && e.ent as usize == new0), "cluster 0: its entrance to the border's");
		assert!(r0[new0].edges.iter().any(|e| e.off == 5 && e.ent as usize == new1), "across the border (offset dy +1)");
		assert!(r1[new1].edges.iter().any(|e| e.off == HERE && e.ent == 0), "cluster 1: the border's to its entrance");
		assert!(r1[new1].edges.iter().any(|e| e.off == 3 && e.ent as usize == new0), "and back across (offset dy -1)");
	}

	/// A climb his maps lack is refused (Forever's client slides off a face over 60 degrees): nothing is added.
	#[test]
	fn a_way_with_a_climb_his_maps_lack_is_refused() {
		let wall: Vec<(usize, usize)> = (0..C).map(|y| (4, y)).collect();
		let mut outs = vec![(0u32, out(&wall, Vec::new()))];
		let cg = CellGrid::new(C, 1, 1, 0, 0);
		let mut w = way("cliff a-b", &[(3, 2), (4, 2), (5, 2)]);
		w.cells[1].cls = cls::CLIMB;
		let (st, _) = apply(&geo(1), &mut outs, &[w], &cg, &|_| {}).unwrap();
		assert_eq!((st.refused, st.ways, st.floors, st.arcs), (1, 0, 0, 0));
		assert!(outs[0].1.floor.is_none() && outs[0].1.arc.is_none());
	}
}
