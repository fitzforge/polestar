//! The trail layer (`forge nav pack --leffe <dir> --trails <trails.json>`, maps format 5): where players walk in the
//! capitals. `polestar nav city trails` aggregates players' recorded walks into walked levels per cell of the walking
//! maps (4.17 yd, 128 per ADT tile), each a level 3+ distinct people walked. A surface of Leffe's maps in a capital
//! (the ADT chunk under it is a capital's by AreaTable's flag or the zone map, as CLASS::CITY) inside a tile with trail
//! data that no walked level covers, none in its cell or a cell beside it within NEAR_YD of its height, becomes
//! OFF_TRAIL (outdoors) or OFF_TRAIL_INDOOR (indoor or indoor city ground), its hub bits kept: a step into it costs 3
//! times (Routing/Costs.lua MULT). Water keeps its class (a swum yard already costs 3).
//!
//! His graph's edges carry his costs, not ours: an edge the new classes make dearer is priced again as pack/cuts.rs
//! does, by what the router's grid search inside the cluster (pack/ingame.rs, Balanced) adds between the two entrances,
//! per profile; an edge across a border, a step into the entrance beyond, by the ratio of that entrance's multipliers.

use super::ingame::{self, cost_value, yards_value, Cluster, Row, HERE};
use super::joins::Geo;
use super::leffe::Out;
use super::{mult, CLASS, HUB_ALLIANCE, HUB_HORDE, NONE, PROFILES};
use rayon::prelude::*;
use rustc_hash::FxHashMap;
use serde_json::Value;
use std::collections::BTreeSet;
use std::path::Path;

/// The trail layer's cells per ADT tile side: the walking maps' cells.
pub const CELLS: usize = 128;
/// A walked level covers a surface within this of its height (yd).
pub const NEAR_YD: f64 = 3.0;

/// trails.json: { format: 1, k, train, cells: 128, maps: { "<c>": { "<col>_<row>": [[i, j, z, w], ...] } } }, i east
/// and j south within the tile (a grid column >> 1), z the walked level's height (yd), w its weight (1-3, unused here).
pub struct Trails {
	/// Counted from the gate's training people only.
	pub train: bool,
	pub maps: FxHashMap<u32, MapTrails>,
}

/// One map's walked levels.
#[derive(Default)]
pub struct MapTrails {
	/// The tiles (col, row) with trail data.
	pub tiles: BTreeSet<(u32, u32)>,
	/// The walked levels' heights by map-wide cell (col * 128 + i, row * 128 + j).
	pub levels: FxHashMap<(u32, u32), Vec<f64>>,
}

impl MapTrails {
	/// Whether a walked level in map-wide cell (gi, gj) or one beside it lies within NEAR_YD of height z.
	pub fn covers(&self, gi: u32, gj: u32, z: f64) -> bool {
		for dj in -1i64..=1 {
			for di in -1i64..=1 {
				let (i, j) = (gi as i64 + di, gj as i64 + dj);
				if i < 0 || j < 0 {
					continue;
				}
				if self.levels.get(&(i as u32, j as u32)).is_some_and(|l| l.iter().any(|&h| (h - z).abs() <= NEAR_YD)) {
					return true;
				}
			}
		}
		false
	}
}

/// Reads trails.json.
pub fn read(file: &Path) -> Result<Trails, String> {
	let bad = |m: &str| format!("{}: {m}", file.display());
	let v: Value = serde_json::from_slice(&std::fs::read(file).map_err(|e| bad(&e.to_string()))?).map_err(|e| bad(&e.to_string()))?;
	if v["format"].as_u64() != Some(1) {
		return Err(bad("not a trail layer of format 1 (polestar nav city trails)"));
	}
	if v["cells"].as_u64() != Some(CELLS as u64) {
		return Err(bad(&format!("{} cells per tile, the walking maps have {CELLS}", v["cells"])));
	}
	let mut maps = FxHashMap::default();
	for (c, tiles) in v["maps"].as_object().ok_or_else(|| bad("no maps"))? {
		let c: u32 = c.parse().map_err(|_| bad(&format!("map {c}")))?;
		let mut m = MapTrails::default();
		for (key, list) in tiles.as_object().ok_or_else(|| bad(&format!("map {c}: no tiles")))? {
			let (col, row) = key.split_once('_').and_then(|(a, b)| Some((a.parse::<u32>().ok()?, b.parse::<u32>().ok()?))).ok_or_else(|| bad(&format!("map {c}: tile {key}")))?;
			m.tiles.insert((col, row));
			for e in list.as_array().ok_or_else(|| bad(&format!("map {c} tile {key}: no levels")))? {
				let (i, j, z) = (e[0].as_u64(), e[1].as_u64(), e[2].as_f64());
				let (Some(i), Some(j), Some(z)) = (i, j, z) else { return Err(bad(&format!("map {c} tile {key}: level {e}"))) };
				if i >= CELLS as u64 || j >= CELLS as u64 {
					return Err(bad(&format!("map {c} tile {key}: cell {i}, {j} outside the tile")));
				}
				m.levels.entry((col * CELLS as u32 + i as u32, row * CELLS as u32 + j as u32)).or_default().push(z);
			}
		}
		maps.insert(c, m);
	}
	Ok(Trails { train: v["train"].as_bool().unwrap_or(false), maps })
}

/// One map's trail layer as the packer applies it: the walked levels, and per tile with trail data whether each ADT
/// chunk lies in a capital (cells::chunk_city).
pub struct Layer<'a> {
	pub trails: &'a MapTrails,
	pub city: FxHashMap<(u32, u32), [bool; 256]>,
	/// The tile row and column of cluster 0 (a cluster is a tile: kx = max_row - row, ky = max_col - col).
	pub max_row: u32,
	pub max_col: u32,
}

impl Layer<'_> {
	/// The tile (col, row) of cluster k and the trail cell (i, j) of its local cell lc (128-cell clusters).
	fn place(&self, ny: i64, k: u32, lc: usize) -> Option<(u32, u32, u32, u32)> {
		let (kx, ky) = (k as i64 / ny, k as i64 % ny);
		let (row, col) = (self.max_row as i64 - kx, self.max_col as i64 - ky);
		if row < 0 || col < 0 {
			return None;
		}
		let (lx, ly) = (lc / CELLS, lc % CELLS);
		Some((col as u32, row as u32, (CELLS - 1 - ly) as u32, (CELLS - 1 - lx) as u32))
	}

	/// Node v's class off the trails, or None when it keeps its own: ground (not water) in a capital's chunk of a tile
	/// with trail data that no walked level covers.
	fn off_trail(&self, ny: i64, k: u32, c: &Cluster, v: usize) -> Option<u8> {
		if c.val[v] == 0 || c.val[v] == 2 {
			return None;
		}
		let (col, row, i, j) = self.place(ny, k, c.cell(v))?;
		let chunks = self.city.get(&(col, row))?;
		if !chunks[(j as usize >> 3) * 16 + (i as usize >> 3)] {
			return None;
		}
		if self.trails.covers(col * CELLS as u32 + i, row * CELLS as u32 + j, c.z[v]) {
			return None;
		}
		let cls = c.cls[v];
		let base = match cls & 7 {
			CLASS::INDOOR | CLASS::CITY | CLASS::OFF_TRAIL_INDOOR => CLASS::OFF_TRAIL_INDOOR,
			_ => CLASS::OFF_TRAIL,
		};
		Some(base | (cls & (HUB_ALLIANCE | HUB_HORDE)))
	}
}

/// What the trail layer changed, for the log and PACK.json.
#[derive(Clone, Debug, Default)]
pub struct TrailStats {
	/// Ground surfaces in a capital's chunks of the tiles with trail data, and those re-classed off the trails
	/// (of them indoors).
	pub capital: usize,
	pub off: usize,
	pub indoor: usize,
	/// Entrance edges priced again: inside a cluster, and across a border.
	pub inside: usize,
	pub across: usize,
}

/// A cluster the layer re-classed: as written, and its new classes.
struct Reclassed {
	before: Cluster,
	cls: Vec<u8>,
}

/// The trail layer applied to `outs` (his clusters as written, after the joins and cuts): the capitals' surfaces off
/// the trails re-classed, the edges they make dearer priced again.
pub(super) fn apply(g: &Geo, outs: &mut [(u32, Out)], layer: &Layer, map: u32, log: &(dyn Fn(&str) + Sync)) -> Result<TrailStats, String> {
	if g.c != CELLS {
		return Err(format!("trails: the walking maps have {} cells per tile, the trail layer {CELLS}", g.c));
	}
	let at: FxHashMap<u32, usize> = outs.iter().enumerate().map(|(i, (k, _))| (*k, i)).collect();
	let key = |col: u32, row: u32| -> Option<u32> {
		let (kx, ky) = (layer.max_row.checked_sub(row)? as i64, layer.max_col.checked_sub(col)? as i64);
		(ky < g.ny).then_some((kx * g.ny + ky) as u32)
	};
	let tiles: Vec<((u32, u32), u32)> = layer.city.keys().filter_map(|&(col, row)| key(col, row).filter(|k| at.contains_key(k)).map(|k| ((col, row), k))).collect();
	let decode = |o: &Out, k: u32| -> Result<Option<Cluster>, String> {
		let (Some(grid), Some(height)) = (o.grid.as_deref(), o.height.as_deref()) else { return Ok(None) };
		Cluster::decode(g.c, g.cs, g.zstep, grid, height, o.floor.as_deref(), o.class.as_deref(), o.area.as_deref(), o.arc.as_deref()).map(Some).map_err(|e| format!("trails: cluster {k}: {e}"))
	};
	let mut st = TrailStats::default();
	// The new classes, per cluster of a tile with trail data.
	let found: Vec<((u32, u32), u32, Option<Reclassed>, usize, usize, usize)> = tiles
		.par_iter()
		.map(|&(tile, k)| -> Result<_, String> {
			let Some(before) = decode(&outs[at[&k]].1, k)? else { return Ok((tile, k, None, 0, 0, 0)) };
			let mut cls = before.cls.clone();
			let (mut capital, mut off, mut indoor) = (0, 0, 0);
			let chunks = &layer.city[&tile];
			for v in 0..before.t() {
				if before.val[v] != 0 && before.val[v] != 2 {
					if let Some((_, _, i, j)) = layer.place(g.ny, k, before.cell(v)) {
						capital += usize::from(chunks[(j as usize >> 3) * 16 + (i as usize >> 3)]);
					}
				}
				if let Some(n) = layer.off_trail(g.ny, k, &before, v) {
					cls[v] = n;
					off += 1;
					indoor += usize::from(n & 7 == CLASS::OFF_TRAIL_INDOOR);
				}
			}
			Ok((tile, k, (off > 0).then_some(Reclassed { before, cls }), capital, off, indoor))
		})
		.collect::<Result<_, String>>()?;
	let mut changed: FxHashMap<u32, Reclassed> = FxHashMap::default();
	let mut sorted = found;
	sorted.sort_by_key(|f| f.0);
	for ((col, row), k, r, capital, off, indoor) in sorted {
		log(&format!("trails {map} {col}_{row}: {off} of {capital} capital ground surfaces off the trails ({indoor} indoors)"));
		st.capital += capital;
		st.off += off;
		st.indoor += indoor;
		if let Some(r) = r {
			changed.insert(k, r);
		}
	}
	// Each changed cluster's entrances: their node's class before and after (an edge across a border steps into one).
	let rows_of = |o: &Out, k: u32| -> Result<Vec<Row>, String> { o.graph.as_deref().map(ingame::decode_graph).transpose().map_err(|e| format!("trails: cluster {k}: {e}")).map(Option::unwrap_or_default) };
	let mut ends: FxHashMap<u32, Vec<Option<(u8, u8)>>> = FxHashMap::default();
	for (&k, r) in &changed {
		let rows = rows_of(&outs[at[&k]].1, k)?;
		ends.insert(k, rows.iter().map(|row| r.before.surface(row.cell as usize, row.layer as i32, 0.0).map(|n| (r.before.cls[n], r.cls[n]))).collect());
	}
	// The clusters whose edges may change: the changed ones and their neighbours.
	let mut touched: BTreeSet<u32> = BTreeSet::new();
	for &k in changed.keys() {
		let (kx, ky) = (k as i64 / g.ny, k as i64 % g.ny);
		for dx in -1..=1 {
			for dy in -1..=1 {
				let (x, y) = (kx + dx, ky + dy);
				if x >= 0 && y >= 0 && y < g.ny && at.contains_key(&((x * g.ny + y) as u32)) {
					touched.insert((x * g.ny + y) as u32);
				}
			}
		}
	}
	let touched: Vec<u32> = touched.into_iter().collect();
	let priced: Vec<(u32, Option<String>, Option<String>, usize, usize)> = touched
		.par_iter()
		.map(|&k| -> Result<_, String> {
			let o = &outs[at[&k]].1;
			let mut rows = rows_of(o, k)?;
			let here = changed.get(&k);
			let after = here.map(|r| {
				let mut a = r.before.clone();
				a.cls.clone_from(&r.cls);
				a
			});
			let (mut inside, mut across) = (0, 0);
			let (kx, ky) = (k as i64 / g.ny, k as i64 % g.ny);
			let nodes: Vec<Option<usize>> = match here {
				Some(r) => rows.iter().map(|row| r.before.surface(row.cell as usize, row.layer as i32, 0.0)).collect(),
				None => Vec::new(),
			};
			for ri in 0..rows.len() {
				// inside: what the router's search adds between the entrances, per profile
				let walks = match (here, &after, nodes.get(ri).copied().flatten()) {
					(Some(r), Some(a), Some(s)) if rows[ri].edges.iter().any(|e| e.off == HERE) => {
						Some((0..3).map(|p| (r.before.dijkstra(&[(s, 0.0, 0.0)], p, g.swim, false), a.dijkstra(&[(s, 0.0, 0.0)], p, g.swim, false))).collect::<Vec<_>>())
					}
					_ => None,
				};
				for e in rows[ri].edges.iter_mut() {
					if e.off == HERE {
						let (Some(w), Some(Some(t))) = (&walks, nodes.get(e.ent as usize)) else { continue };
						let mut more = false;
						for (p, (b, a)) in w.iter().enumerate() {
							let add = a.0[*t] - b.0[*t];
							if add.is_finite() && add > 0.0 {
								let v = cost_value(e.cost[p] as f64 + add);
								more |= v != e.cost[p];
								e.cost[p] = v;
							}
						}
						if more {
							let add = w[NONE].1 .1[*t] - w[NONE].0 .1[*t];
							if add.is_finite() && add > 0.0 {
								e.yards = yards_value(e.yards as f64 + add);
							}
							inside += 1;
						}
					} else {
						// across: a step into the entrance beyond, priced by its multipliers' ratio
						let (x, y) = (kx + e.off as i64 / 3 - 1, ky + e.off as i64 % 3 - 1);
						if x < 0 || y < 0 || y >= g.ny {
							continue;
						}
						let Some(Some((was, now))) = ends.get(&((x * g.ny + y) as u32)).and_then(|v| v.get(e.ent as usize)) else { continue };
						if was == now {
							continue;
						}
						for (p, prof) in PROFILES.iter().enumerate() {
							e.cost[p] = cost_value(e.cost[p] as f64 * mult(*now, *prof) / mult(*was, *prof));
						}
						across += 1;
					}
				}
			}
			let graph = if rows.is_empty() { None } else { Some(ingame::encode_graph(&rows)?) };
			Ok((k, after.map(|a| a.class_field()), graph, inside, across))
		})
		.collect::<Result<_, String>>()?;
	for (k, class, graph, inside, across) in priced {
		let o = &mut outs[at[&k]].1;
		if class.is_some() {
			o.class = class;
		}
		if o.graph.is_some() {
			o.graph = graph;
		}
		st.inside += inside;
		st.across += across;
	}
	Ok(st)
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::pack::encode::{encode_heights, run_length};
	use crate::pack::ingame::Edge;

	const C: usize = CELLS;
	const CS: f64 = 1600.0 / 3.0 / 128.0;
	/// Cluster 0 is tile (MAX_COL, MAX_ROW); cluster 1 (ny 2) the tile west of it.
	const MAX_ROW: u32 = 40;
	const MAX_COL: u32 = 30;

	fn geo(ny: i64) -> Geo {
		Geo { c: C, cs: CS, zstep: 2.0, x0: 0.0, y0: 0.0, ny, swim: 3.0 }
	}

	/// The local cell of trail cell (i, j).
	fn lc(i: usize, j: usize) -> usize {
		(C - 1 - j) * C + (C - 1 - i)
	}

	/// Flat ground at height 0 with `val` and `cls` per base cell, and entrance rows.
	fn out(val: &[u8], cls: Option<&[u8]>, rows: Vec<Row>) -> Out {
		let grid = run_length(&val.iter().map(|v| v * 16).collect::<Vec<u8>>());
		let height = encode_heights(val, &vec![0; C * C], C).unwrap();
		Out {
			grid: Some(grid),
			height: Some(height),
			class: cls.map(run_length),
			graph: (!rows.is_empty()).then(|| ingame::encode_graph(&rows).unwrap()),
			..Default::default()
		}
	}

	fn classes(o: &Out) -> Vec<u8> {
		Cluster::decode(C, CS, 2.0, o.grid.as_deref().unwrap(), o.height.as_deref().unwrap(), None, o.class.as_deref(), None, None).unwrap().cls
	}

	fn trails(levels: &[(u32, u32, f64)]) -> MapTrails {
		let mut t = MapTrails::default();
		t.tiles.insert((MAX_COL, MAX_ROW));
		for &(i, j, z) in levels {
			t.levels.entry((MAX_COL * C as u32 + i, MAX_ROW * C as u32 + j)).or_default().push(z);
		}
		t
	}

	fn layer(t: &MapTrails, city: [bool; 256]) -> Layer<'_> {
		let mut by_tile = FxHashMap::default();
		by_tile.insert((MAX_COL, MAX_ROW), city);
		Layer { trails: t, city: by_tile, max_row: MAX_ROW, max_col: MAX_COL }
	}

	/// A capital's ground no walked level covers goes off the trails, indoors to 7, its hub bits kept; ground a level
	/// covers (in its cell or one beside it, within 3 yd), water and a chunk outside the capital keep their class.
	#[test]
	fn a_capitals_ground_no_trail_covers_goes_off_the_trails_keeping_its_hub_bits() {
		let mut val = vec![1u8; C * C];
		let mut cls = vec![0u8; C * C];
		val[lc(30, 30)] = 2;
		cls[lc(10, 12)] = CLASS::INDOOR;
		cls[lc(10, 11)] = CLASS::CITY | HUB_ALLIANCE;
		cls[lc(20, 20)] = CLASS::ROAD | HUB_ALLIANCE;
		cls[lc(20, 21)] = CLASS::STEEP | HUB_HORDE;
		cls[lc(21, 21)] = CLASS::CITY;
		let t = trails(&[(10, 10, 0.0), (60, 60, 2.5), (50, 50, 5.0)]);
		let mut city = [true; 256];
		city[255] = false; // trail cells i, j 120-127
		let mut outs = vec![(0u32, out(&val, Some(&cls), Vec::new()))];
		let st = apply(&geo(1), &mut outs, &layer(&t, city), 0, &|_| {}).unwrap();
		let got = classes(&outs[0].1);
		assert_eq!(got[lc(10, 12)], CLASS::OFF_TRAIL_INDOOR, "indoor, two cells from the walked level: off the trails indoors");
		assert_eq!(got[lc(10, 11)], CLASS::CITY | HUB_ALLIANCE, "a cell beside a walked level at its height keeps its class");
		assert_eq!(got[lc(11, 9)], CLASS::NORMAL, "a diagonal neighbour too");
		assert_eq!(got[lc(20, 20)], CLASS::OFF_TRAIL | HUB_ALLIANCE, "a road off the trails, still in the Alliance hub");
		assert_eq!(got[lc(20, 21)], CLASS::OFF_TRAIL | HUB_HORDE, "steep ground off the trails is off the trails");
		assert_eq!(got[lc(21, 21)], CLASS::OFF_TRAIL_INDOOR, "an indoor city off the trails is indoors");
		assert_eq!(got[lc(50, 50)], CLASS::OFF_TRAIL, "a walked level 5 yd above covers nothing");
		assert_eq!(got[lc(61, 61)], CLASS::NORMAL, "one 2.5 yd above covers");
		assert_eq!(got[lc(30, 30)], CLASS::NORMAL, "water keeps its class");
		assert_eq!(got[lc(125, 125)], CLASS::NORMAL, "outside the capital's chunks");
		assert_eq!(got[lc(119, 125)], CLASS::OFF_TRAIL, "the chunk beside it is the capital's");
		let (capital, covered) = (C * C - 1 - 64, 9 + 9);
		assert_eq!((st.capital, st.off, st.indoor), (capital, capital - covered, 2));
	}

	/// The edges the new classes make dearer are priced again: one inside the cluster by what the walk between its
	/// entrances adds (here the whole way, three times), one across a border into it by the ratio of its entrance's
	/// multipliers; an edge out of it into a cluster without trails keeps its cost.
	#[test]
	fn the_edges_into_and_inside_a_cluster_off_the_trails_are_priced_again() {
		let (a, b) = (lc(5, 5), lc(25, 5));
		let straight = 20.0 * CS;
		let w = straight.round() as u32;
		let edge = |off: u32, ent: u32, cost: u32| Edge { off, ent, cost: [cost; 3], yards: cost };
		let rows0 = vec![Row { cell: a as u32, layer: 0, comp: 1, edges: vec![edge(HERE, 1, w), edge(5, 0, 6)] }, Row { cell: b as u32, layer: 0, comp: 1, edges: Vec::new() }];
		let rows1 = vec![Row { cell: (C - 1) as u32, layer: 0, comp: 1, edges: vec![edge(3, 1, 6)] }];
		let val = vec![1u8; C * C];
		let t = trails(&[]);
		let mut outs = vec![(0u32, out(&val, None, rows0)), (1u32, out(&val, None, rows1))];
		let st = apply(&geo(2), &mut outs, &layer(&t, [true; 256]), 0, &|_| {}).unwrap();
		assert_eq!((st.inside, st.across), (1, 1));
		let r0 = ingame::decode_graph(outs[0].1.graph.as_deref().unwrap()).unwrap();
		let inside = &r0[0].edges[0];
		for p in 0..3 {
			assert!((inside.cost[p] as f64 - 3.0 * straight).abs() <= 1.0, "inside, profile {p}: {} for {:.1}", inside.cost[p], 3.0 * straight);
		}
		assert_eq!(inside.yards, w, "the same way, the same yards");
		assert_eq!(r0[0].edges[1].cost, [6; 3], "into the cluster without trails: as it was");
		let r1 = ingame::decode_graph(outs[1].1.graph.as_deref().unwrap()).unwrap();
		assert_eq!(r1[0].edges[0].cost, [18; 3], "across the border into ground off the trails: 3 times");
		assert!(outs[1].1.class.is_none(), "the cluster without trails keeps its classes");
	}
}
