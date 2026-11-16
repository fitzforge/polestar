//! Ground a player can reach (maps format 5): the walking maps keep only the surfaces a walk from a fixed place
//! reaches, as the in-game router walks them. A fixed place is where players arrive at a known height: a flight
//! master, a boat, zeppelin or tram landing, a lift landing, a portal's end, an inn and the nodes of the travel
//! chains (data/crossings.json). Every other surface is ground no player stands on (the top of a statue, a sealed
//! room, a roof no stair reaches), and a point without a height that starts or ends on one finds no walk: in
//! Stormwind's Valley of Heroes the statue bases between the street's cells were all a start there could stand on.
//!
//! Ported from Shortest Path Forever v1.33.0 by Cillian Berragan (github.com/cjber/shortest-path-forever,
//! GPL-3.0-or-later, used with his permission): its v1.24.8 rule (tools/baker/gen_nav.py components(), "keep only
//! walking ground a fixed place reaches", and tools/baker/places.lua, the fixed places), on Leffe's surfaces and
//! entrance graph instead of navmesh polygons. His components are undirected; here a walk is followed the way the
//! router takes it (a jump, drop or one-way graph edge only forward), so ground a fixed place reaches only by a fall
//! is kept and ground with a way out but none in is dropped.
//! Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-11-13.
//!
//! The walks followed are the router's (addon/Polestar_Nav Routing/): a base cell's open steps (its moves), each
//! surface's links (base, the nth floor, or the surface nearest its height in the cell the link points to) and arcs
//! inside a cluster, and the entrance graph's edges between entrances (the 63 an entrance keeps). A place stands on
//! the surface of its cell or a neighbouring one nearest it (its distance plus twice the height gap) within
//! PLACE_DZ yards of its height; a place with none there stands nowhere (counted).

use rustc_hash::FxHashMap;
use serde_json::Value;
use std::path::Path;

/// A place stands on a surface at most this far above or below its height (yd). Leffe's heights are whole steps
/// of the map's height step (2 yd), and a spawn stands a little above its floor.
pub const PLACE_DZ: f64 = 5.0;
/// An NPC's spawn stands for the place it serves within this many yards of the place's point.
const NPC_NEAR: f64 = 40.0;

/// A fixed place: map, world x and y, height.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Place {
	pub map: u32,
	pub x: f64,
	pub y: f64,
	pub z: f64,
}

/// One cluster as the walks see it: its surfaces (base cells first, then floors), each surface's walks inside the
/// cluster, and its entrances with the edges they keep.
#[derive(Default, Debug)]
pub struct Local {
	/// Cells per side.
	pub c: usize,
	/// Per surface: 0 none, else walkable (1) or water (2).
	pub val: Vec<u8>,
	/// Per surface: its height.
	pub z: Vec<f32>,
	/// Per base cell: its open steps (1 to +x, 2 to +y, 4 to +x+y, 8 to +x-y), as the router decodes them.
	pub moves: Vec<u8>,
	/// Per base cell: its first floor, -1 for none.
	pub first: Vec<i32>,
	/// Per floor (index - c * c): its cell.
	pub at: Vec<u32>,
	/// Per surface: the surfaces of this cluster its links and arcs walk to (CSR).
	pub out_off: Vec<u32>,
	pub out: Vec<u32>,
	/// Per entrance: the surface it stands on.
	pub rows: Vec<u32>,
	/// Per entrance: its kept edges (CSR) as (target cluster's index, target entrance).
	pub edge_off: Vec<u32>,
	pub edges: Vec<(u32, u32)>,
}

impl Local {
	fn n0(&self) -> usize {
		self.val.len()
	}
	/// The surfaces of local cell lc: its base (when it has one), then its floors.
	fn surfaces(&self, lc: usize, out: &mut Vec<usize>) {
		out.clear();
		if self.val[lc] != 0 {
			out.push(lc);
		}
		let c2 = self.c * self.c;
		let mut f = self.first[lc];
		while f >= 0 && (f as usize) < self.n0() && self.at[f as usize - c2] as usize == lc {
			out.push(f as usize);
			f += 1;
		}
	}
	/// The base cells a base cell's open steps reach.
	fn steps(&self, a: usize, out: &mut Vec<usize>) {
		let c = self.c;
		let (x, y) = (a / c, a % c);
		let m = |b: usize| self.moves[b];
		let open = |b: usize| self.val[b] != 0;
		if x + 1 < c && m(a) & 1 != 0 && open(a + c) {
			out.push(a + c);
		}
		if x > 0 && m(a - c) & 1 != 0 && open(a - c) {
			out.push(a - c);
		}
		if y + 1 < c && m(a) & 2 != 0 && open(a + 1) {
			out.push(a + 1);
		}
		if y > 0 && m(a - 1) & 2 != 0 && open(a - 1) {
			out.push(a - 1);
		}
		if x + 1 < c && y + 1 < c && m(a) & 4 != 0 && open(a + c + 1) {
			out.push(a + c + 1);
		}
		if x > 0 && y > 0 && m(a - c - 1) & 4 != 0 && open(a - c - 1) {
			out.push(a - c - 1);
		}
		if x + 1 < c && y > 0 && m(a) & 8 != 0 && open(a + c - 1) {
			out.push(a + c - 1);
		}
		if x > 0 && y + 1 < c && m(a - c + 1) & 8 != 0 && open(a - c + 1) {
			out.push(a - c + 1);
		}
	}
}

/// The map frame a place is placed on: the global cell of world (x, y).
#[derive(Clone, Copy, Debug)]
pub struct Frame {
	pub x0: f64,
	pub y0: f64,
	pub cs: f64,
	/// Clusters per column (the map's ny) and cells per cluster side.
	pub ny: i64,
	pub c: i64,
	/// Global cells across x and y.
	pub gx: i64,
	pub gy: i64,
}

/// The surface place p stands on: (index of its cluster in `clusters`' order, surface), or None. `index` finds a
/// cluster's index by its number.
pub fn stand(locals: &[Local], index: &FxHashMap<u32, usize>, f: &Frame, p: &Place) -> Option<(usize, usize)> {
	let gx = ((p.x - f.x0) / f.cs).floor() as i64;
	let gy = ((p.y - f.y0) / f.cs).floor() as i64;
	let mut best: Option<(f64, usize, usize)> = None;
	let mut list = Vec::new();
	for dx in -1..=1 {
		for dy in -1..=1 {
			let (x, y) = (gx + dx, gy + dy);
			if x < 0 || y < 0 || x >= f.gx || y >= f.gy {
				continue;
			}
			let k = ((x / f.c) * f.ny + y / f.c) as u32;
			let Some(&ki) = index.get(&k) else { continue };
			let l = &locals[ki];
			let lc = ((x % f.c) * f.c + y % f.c) as usize;
			l.surfaces(lc, &mut list);
			let d = if dx == 0 && dy == 0 {
				0.0
			} else {
				let (cx, cy) = (f.x0 + (x as f64 + 0.5) * f.cs, f.y0 + (y as f64 + 0.5) * f.cs);
				((cx - p.x).powi(2) + (cy - p.y).powi(2)).sqrt()
			};
			for &s in &list {
				let dz = (l.z[s] as f64 - p.z).abs();
				if dz > PLACE_DZ {
					continue;
				}
				let score = d + 2.0 * dz;
				if best.is_none_or(|b| score < b.0) {
					best = Some((score, ki, s));
				}
			}
		}
	}
	best.map(|b| (b.1, b.2))
}

/// Every surface a walk from `starts` reaches: per cluster (in `locals`' order), per surface.
pub fn reached(locals: &[Local], starts: &[(usize, usize)]) -> Vec<Vec<bool>> {
	let mut seen: Vec<Vec<bool>> = locals.iter().map(|l| vec![false; l.n0()]).collect();
	// The entrances on each surface, per cluster.
	let on: Vec<FxHashMap<u32, Vec<u32>>> = locals
		.iter()
		.map(|l| {
			let mut m: FxHashMap<u32, Vec<u32>> = FxHashMap::default();
			for (r, &s) in l.rows.iter().enumerate() {
				m.entry(s).or_default().push(r as u32);
			}
			m
		})
		.collect();
	let mut stack: Vec<(usize, usize)> = Vec::new();
	for &(k, s) in starts {
		if !seen[k][s] {
			seen[k][s] = true;
			stack.push((k, s));
		}
	}
	let mut next = Vec::new();
	while let Some((k, s)) = stack.pop() {
		let l = &locals[k];
		next.clear();
		if s < l.c * l.c {
			l.steps(s, &mut next);
		}
		next.extend(l.out[l.out_off[s] as usize..l.out_off[s + 1] as usize].iter().map(|&t| t as usize));
		for &t in &next {
			if !seen[k][t] {
				seen[k][t] = true;
				stack.push((k, t));
			}
		}
		if let Some(rows) = on[k].get(&(s as u32)) {
			for &r in rows {
				for &(k2, e2) in &l.edges[l.edge_off[r as usize] as usize..l.edge_off[r as usize + 1] as usize] {
					let (k2, t) = (k2 as usize, locals[k2 as usize].rows[e2 as usize] as usize);
					if !seen[k2][t] {
						seen[k2][t] = true;
						stack.push((k2, t));
					}
				}
			}
		}
	}
	seen
}

/// A cluster's entrances as they stay: per old entrance its new index, u32::MAX for one on ground no walk reaches.
pub fn row_map(l: &Local, seen: &[bool]) -> Vec<u32> {
	let mut next = 0u32;
	l.rows
		.iter()
		.map(|&s| {
			if seen[s as usize] {
				next += 1;
				next - 1
			} else {
				u32::MAX
			}
		})
		.collect()
}

fn read_json(file: &Path) -> Result<Value, String> {
	serde_json::from_slice(&std::fs::read(file).map_err(|e| format!("{}: {e}", file.display()))?).map_err(|e| format!("{}: {e}", file.display()))
}

/// World (continent, x, y) of map percent (x, y) on uiMap `map` in frame `f` ("e" the Era frame, else the live one)
/// of data/forever/map-frames.json; the Era frame falls back to the live one for a map without it.
fn map_to_world(frames: &Value, map: u64, x: f64, y: f64, f: &str) -> Option<(u32, f64, f64)> {
	let key = map.to_string();
	let fr = if f == "e" { frames["era"].get(&key).or_else(|| frames["forever"].get(&key)) } else { frames["forever"].get(&key) }?;
	let num = |k: &str| fr[k].as_f64();
	let (left, right, top, bottom) = (num("left")?, num("right")?, num("top")?, num("bottom")?);
	Some((fr["c"].as_u64()? as u32, top - y / 100.0 * (top - bottom), left - x / 100.0 * (left - right)))
}

/// Where NPC `npc` stands on continent c nearest world (x, y), within NPC_NEAR yards: its spawn (data/forever
/// spawnz.json: per NPC [continent, x, y, z, ...]).
fn npc_at(spawnz: &Value, npc: u64, c: u32, x: f64, y: f64) -> Option<Place> {
	let mut best: Option<(f64, Place)> = None;
	for s in spawnz["npc"][npc.to_string()].as_array()? {
		let (Some(sc), Some(sx), Some(sy), Some(sz)) = (s[0].as_u64(), s[1].as_f64(), s[2].as_f64(), s[3].as_f64()) else { continue };
		let d = ((sx - x).powi(2) + (sy - y).powi(2)).sqrt();
		if sc as u32 == c && d <= NPC_NEAR && best.is_none_or(|b| d < b.0) {
			best = Some((d, Place { map: c, x: sx, y: sy, z: sz }));
		}
	}
	best.map(|b| b.1)
}

/// The fixed places of every map, from data/forever (travel.json: flight masters and inns by their NPC's spawn in
/// spawnz.json, boat, zeppelin and tram landings, lift landings, portal ends; map-frames.json) and
/// data/crossings.json's travel chains (their nodes' heights). A place without a height is left out: it cannot say
/// which floor it stands on.
pub fn fixed_places(root: &Path) -> Result<Vec<Place>, String> {
	let forever = root.join("data/forever");
	let travel = read_json(&forever.join("travel.json"))?;
	let spawnz = read_json(&forever.join("spawnz.json"))?;
	let frames = read_json(&forever.join("map-frames.json"))?;
	let mut out = Vec::new();
	let point = |v: &Value| -> Option<Place> { Some(Place { map: v["c"].as_u64()? as u32, x: v["wx"].as_f64()?, y: v["wy"].as_f64()?, z: v["z"].as_f64()? }) };
	// Flight masters and inns: where their NPC stands.
	let served = travel["taxi"]["nodes"].as_array().into_iter().flatten().chain(travel["inns"].as_array().into_iter().flatten());
	for n in served {
		let (Some(npc), Some(c), Some(x), Some(y)) = (n["npc"].as_u64(), n["c"].as_u64(), n["wx"].as_f64(), n["wy"].as_f64()) else { continue };
		out.extend(npc_at(&spawnz, npc, c as u32, x, y));
	}
	// Boat, zeppelin and tram landings with a height.
	for t in travel["transports"].as_array().into_iter().flatten() {
		out.extend(point(&t["a"]));
		out.extend(point(&t["b"]));
	}
	// Portal ends with a height.
	for p in travel["transit"]["portals"].as_array().into_iter().flatten() {
		out.extend(point(&p["a"]));
		out.extend(point(&p["b"]));
	}
	// Lift landings: each lift route's stops, [arrive, leave, continent, x, y, z, landing].
	for r in travel["transit"]["routes"].as_object().into_iter().flatten().map(|(_, r)| r) {
		if r["kind"].as_str() != Some("lift") {
			continue;
		}
		for s in r["stops"].as_array().into_iter().flatten() {
			if let (Some(c), Some(x), Some(y), Some(z)) = (s[2].as_u64(), s[3].as_f64(), s[4].as_f64(), s[5].as_f64()) {
				out.push(Place { map: c as u32, x, y, z });
			}
		}
	}
	// The travel chains' nodes (map percent in the file's frame, with heights).
	let chains = root.join("data/crossings.json");
	if chains.is_file() {
		let doc = read_json(&chains)?;
		let f = doc["frame"].as_str().unwrap_or("e").to_string();
		for ch in doc["chains"].as_array().into_iter().flatten() {
			for n in ch["nodes"].as_array().into_iter().flatten() {
				let (Some(map), Some(x), Some(y), Some(z)) = (n["map"].as_u64(), n["x"].as_f64(), n["y"].as_f64(), n["z"].as_f64()) else { continue };
				if let Some((c, wx, wy)) = map_to_world(&frames, map, x, y, &f) {
					out.push(Place { map: c, x: wx, y: wy, z });
				}
			}
		}
	}
	Ok(out)
}

#[cfg(test)]
mod tests {
	use super::*;

	/// A 4 x 4 cluster: base cells only, every base cell with a surface at height 0.
	fn flat(c: usize) -> Local {
		let n = c * c;
		Local { c, val: vec![1; n], z: vec![0.0; n], moves: vec![0; n], first: vec![-1; n], at: vec![], out_off: vec![0; n + 1], out: vec![], ..Default::default() }
	}

	fn frame(c: i64, clusters: i64) -> Frame {
		Frame { x0: 0.0, y0: 0.0, cs: 4.0, ny: clusters, c, gx: c * clusters, gy: c * clusters }
	}

	#[test]
	fn a_walk_follows_open_steps_both_ways_and_stops_at_closed_ones() {
		let mut l = flat(4);
		// 0 -> +x (cell 4) and 4 -> +y (cell 5) open; cell 15 is walled off.
		l.moves[0] = 1;
		l.moves[4] = 2;
		let seen = reached(&[l], &[(0, 5)]);
		assert!(seen[0][5] && seen[0][4] && seen[0][0], "back along both steps");
		assert!(!seen[0][15], "no step reaches the far corner");
	}

	#[test]
	fn arcs_and_one_way_edges_are_walked_forward_only() {
		let mut a = flat(2);
		let mut b = flat(2);
		// In a: surface 0 drops to surface 3 (one way). One entrance on a's 3 and one on b's 0; a's has an edge to
		// b's entrance, b's none back.
		a.out_off = vec![0, 1, 1, 1, 1];
		a.out = vec![3];
		a.rows = vec![3];
		a.edge_off = vec![0, 1];
		a.edges = vec![(1, 0)];
		b.rows = vec![0];
		b.edge_off = vec![0, 0];
		let locals = [a, b];
		let down = reached(&locals, &[(0, 0)]);
		assert!(down[0][3] && down[1][0], "the drop, then the edge into b");
		let up = reached(&locals, &[(1, 0)]);
		assert!(!up[0][3] && !up[0][0], "from b nothing leads back into a");
	}

	#[test]
	fn a_place_stands_on_the_surface_nearest_its_height_never_one_far_above_or_below() {
		// One cell with its base at 75 (ground buried under a street) and a floor at 94 (the street).
		let mut l = flat(2);
		l.z = vec![75.0, 75.0, 75.0, 75.0, 94.0];
		l.val.push(1);
		l.first = vec![4, -1, -1, -1];
		l.at = vec![0];
		l.out_off.push(0);
		let index: FxHashMap<u32, usize> = [(0u32, 0usize)].into_iter().collect();
		let f = frame(2, 1);
		assert_eq!(stand(&[l], &index, &f, &Place { map: 0, x: 1.0, y: 1.0, z: 93.0 }).map(|s| s.1), Some(4), "the street");
		let l = flat(2);
		assert_eq!(stand(&[l], &index, &f, &Place { map: 0, x: 1.0, y: 1.0, z: 20.0 }), None, "nothing within PLACE_DZ");
	}

	#[test]
	fn the_entrances_kept_are_renumbered_in_order() {
		let mut l = flat(2);
		l.rows = vec![0, 1, 2];
		assert_eq!(row_map(&l, &[true, false, true, true]), vec![0, u32::MAX, 1]);
	}
}
