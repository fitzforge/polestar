//! Spawn heights where floors overlap (maps format 5's `spawn` field): the heights of the NPC and quest object spawns
//! that stand within a cell of a surface more than the router's ZTOL above or below their own, per cluster, so a goal
//! without a height beside one (a map pin clicked over an NPC, a rare's spot, another addon's waypoint) ends on that
//! spawn's floor: in a cave under a hill, a cellar under a house, the Pools of Vision under Spirit Rise. A spawn with
//! one floor round it needs none (a goal without a height finds that floor anyway), which keeps the field small.
//!
//! Ported from Shortest Path Forever v1.33.0 by Cillian Berragan (github.com/cjber/shortest-path-forever,
//! GPL-3.0-or-later, used with his permission): its v1.30 Data/Heights.lua (tools/gen_heights.py and
//! tools/bake_heights.lua: the spawns with another surface more than ZTOL away within a cell, as world x, y and the
//! height of the surface they stand on in whole yards, per walking-map cluster), here a packed field of the walking
//! maps instead of a file of its own, and the spawns from data/forever's spawnz.json (classic-db's and Forever's own
//! world database's heights).
//! Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-11-13.
//!
//! The field: per cluster one string, "x y z x y z ..." (world yards, whole), each spawn once, in the order read.
//! Routing/Path.lua reads it (spawnHeight) for a goal without a height within REACH yards of a listed spawn.

use super::drops::surface_near;
use super::reach::{Frame, Place};
use crate::f4::pack::Cluster;
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::Value;
use std::path::Path;

/// Routing/PathGrid.lua's ZTOL: surfaces this close in height the router stands on alike.
pub const ZTOL: f64 = 10.0;
/// A spawn stands on his surface in its cell within this of its height.
pub const STAND_YD: f64 = 5.0;

/// The spawns of `places` in each cluster (as Routing/PathGrid.lua locates a point: through its global cell).
pub fn by_cluster(places: &[Place], map: u32, f: &Frame) -> FxHashMap<u32, Vec<Place>> {
	let mut out: FxHashMap<u32, Vec<Place>> = FxHashMap::default();
	for p in places.iter().filter(|p| p.map == map) {
		let gx = ((p.x - f.x0) / f.cs).floor() as i64;
		let gy = ((p.y - f.y0) / f.cs).floor() as i64;
		if gx < 0 || gy < 0 || gx >= f.gx || gy >= f.gy {
			continue;
		}
		out.entry(((gx / f.c) * f.ny + gy / f.c) as u32).or_default().push(*p);
	}
	out
}

/// Cluster k's spawn field: of its spawns, those whose surface (his nearest within STAND_YD) has, in its cell or one
/// beside it inside the cluster, another surface more than ZTOL away; each as world x, y and that surface's height in
/// whole yards, once. Only surfaces that stay in the maps count (`kept`: not ground no walk reaches). None when it
/// keeps none. -> the field and how many it holds.
pub fn spawn_field(c: &Cluster, k: u32, f: &Frame, spawns: &[Place], kept: &dyn Fn(usize) -> bool) -> Option<(String, usize)> {
	let cc = f.c;
	let (kx, ky) = (k as i64 / f.ny, k as i64 % f.ny);
	let mut seen: FxHashSet<(i64, i64, i64)> = FxHashSet::default();
	let mut out: Vec<String> = Vec::new();
	for p in spawns {
		let gx = ((p.x - f.x0) / f.cs).floor() as i64;
		let gy = ((p.y - f.y0) / f.cs).floor() as i64;
		let (lx, ly) = (gx - kx * cc, gy - ky * cc);
		if lx < 0 || ly < 0 || lx >= cc || ly >= cc {
			continue;
		}
		let lc = (lx * cc + ly) as usize;
		let Some(s) = surface_near(c, lc, p.z).filter(|&s| kept(s)) else { continue };
		let z = c.z[s] as f64;
		let mut other = false;
		'cells: for dx in -1..=1 {
			for dy in -1..=1 {
				let (x, y) = (lx + dx, ly + dy);
				if x < 0 || y < 0 || x >= cc || y >= cc {
					continue;
				}
				let t = (x * cc + y) as usize;
				if c.val[t] != 0 && kept(t) && (c.z[t] as f64 - z).abs() > ZTOL {
					other = true;
					break 'cells;
				}
				let mut fl = c.first_floor[t];
				while fl >= 0 && (fl as usize) < c.n0 && c.at_cell[fl as usize] as usize == t {
					if c.val[fl as usize] != 0 && kept(fl as usize) && (c.z[fl as usize] as f64 - z).abs() > ZTOL {
						other = true;
						break 'cells;
					}
					fl += 1;
				}
			}
		}
		if !other {
			continue;
		}
		let key = (p.x.round() as i64, p.y.round() as i64, z.round() as i64);
		if seen.insert(key) {
			out.push(format!("{} {} {}", key.0, key.1, key.2));
		}
	}
	(!out.is_empty()).then(|| (out.join(" "), out.len()))
}

/// Every NPC spawn, and every spawn of an object a quest starts at, ends at or names in an objective, with its height
/// (data/forever spawnz.json: per entity [continent, x, y, z, ...]; quests.json).
pub fn spawn_points(root: &Path) -> Result<Vec<Place>, String> {
	let read = |name: &str| -> Result<Value, String> {
		let file = root.join("data/forever").join(name);
		serde_json::from_slice(&std::fs::read(&file).map_err(|e| format!("{}: {e}", file.display()))?).map_err(|e| format!("{}: {e}", file.display()))
	};
	let spawnz = read("spawnz.json")?;
	let quests = read("quests.json")?;
	let mut objects: FxHashSet<u64> = FxHashSet::default();
	for q in quests.as_object().into_iter().flatten().map(|(_, q)| q) {
		for side in ["start", "end"] {
			objects.extend(q[side]["object"].as_array().into_iter().flatten().filter_map(Value::as_u64));
		}
		for o in q["objectives"].as_array().into_iter().flatten() {
			if o["type"].as_str() == Some("object") {
				objects.extend(o["id"].as_u64());
			}
		}
	}
	let mut out = Vec::new();
	let mut push = |rows: &Value| {
		for s in rows.as_array().into_iter().flatten() {
			if let (Some(c), Some(x), Some(y), Some(z)) = (s[0].as_u64(), s[1].as_f64(), s[2].as_f64(), s[3].as_f64()) {
				out.push(Place { map: c as u32, x, y, z });
			}
		}
	};
	for (_, rows) in spawnz["npc"].as_object().into_iter().flatten() {
		push(rows);
	}
	for (id, rows) in spawnz["object"].as_object().into_iter().flatten() {
		if id.parse::<u64>().is_ok_and(|id| objects.contains(&id)) {
			push(rows);
		}
	}
	Ok(out)
}

#[cfg(test)]
mod tests {
	use super::*;

	fn frame() -> Frame {
		Frame { x0: 0.0, y0: 0.0, cs: 4.0, ny: 1, c: 4, gx: 4, gy: 4 }
	}

	/// A 4 x 4 cluster of ground at 10; cell 5 has a floor at 30 over it (a balcony over a street).
	fn street() -> Cluster {
		let mut c = Cluster { n0: 17, val: vec![1; 17], z: vec![10.0; 17], moves: vec![0; 16], first_floor: vec![-1; 16], at_cell: vec![-1; 17], ..Default::default() };
		c.z[16] = 30.0;
		c.first_floor[5] = 16;
		c.at_cell[16] = 5;
		c
	}

	#[test]
	fn a_spawn_with_a_floor_over_or_under_it_within_a_cell_keeps_its_height_one_with_one_floor_none() {
		let c = street();
		let on_balcony = Place { map: 0, x: 5.0, y: 5.0, z: 30.4 };
		let under_it = Place { map: 0, x: 6.0, y: 6.5, z: 10.3 };
		let beside = Place { map: 0, x: 9.0, y: 2.0, z: 10.0 };
		let away = Place { map: 0, x: 15.0, y: 15.0, z: 10.0 };
		let all = |_: usize| true;
		let (field, n) = spawn_field(&c, 0, &frame(), &[on_balcony, under_it, beside, away], &all).unwrap();
		assert_eq!(n, 3, "the balcony's, the one under it and the one beside it; the far one has one floor round it");
		assert_eq!(field, "5 5 30 6 7 10 9 2 10", "world x, y and the surface's height, whole yards");
		assert!(spawn_field(&c, 0, &frame(), &[away], &all).is_none());
		// The balcony is ground no walk reaches (dropped): no spawn is on it, and it counts as no floor over the street.
		let street_only = |s: usize| s != 16;
		assert!(spawn_field(&c, 0, &frame(), &[on_balcony, under_it], &street_only).is_none());
	}

	#[test]
	fn a_spawn_with_no_surface_near_its_height_is_left_out() {
		let c = street();
		assert!(spawn_field(&c, 0, &frame(), &[Place { map: 0, x: 5.0, y: 5.0, z: 60.0 }], &|_| true).is_none());
	}
}
