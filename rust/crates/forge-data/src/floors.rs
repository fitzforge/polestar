//! Floor words for spawns (#2751): where an NPC or object stands a floor up a building, at its top, or under the
//! ground, from its spawn height (spawnz.json) against the walking grid's surfaces at its spot. floors.json:
//! `{ npc: { id: [[c, wx, wy, word], ...] }, object: { ... } }`, word "up" | "top" | "below", only spawns with one.
//! The guide compiler writes the word on a goal at that spawn (forge-guide heights.rs `goal_floor`).
//!
//! A column of the grid holds every surface over one cell: the terrain's, each model's or building's floor. The
//! spawn stands on the walkable one within AT_YARDS of its height. The ground is the terrain's surface there when it
//! lies within STOREY_YARDS (a city built in a cave or under a mountain is no storey of anything), else the lowest
//! walkable surface no further than that below the spawn; but a hall whose lowest indoor floor stands more than
//! FLOOR_YARDS over the terrain under it (Grommash Hold, on terrain carved far under its floor) has that floor as
//! its ground. More than FLOOR_YARDS under the ground, in an indoor space: "below" (Goldshire's inn cellar,
//! Maximillian Crowe, #2856). More than that above it, with an indoor floor in the column (a building, not a deck or
//! a bridge in the open): "up", but "top" where no indoor floor lies over the spawn's within STOREY_YARDS (only the
//! roof) and it stands more than TOP_YARDS up: a tower's top (Brother Neals, 33 yards over Northshire Abbey's
//! ground), not a house's upper floor (Khelden Bremen, 8 up). A column without the terrain's surface (an
//! instance's halls) gets no word.

use crate::jsv::arr;
use forge_guide::js::{Obj, V};
use forge_nav::grid::{cell_of, flag, Grid, TILE_CELLS};
use rustc_hash::FxHashMap;
use std::path::{Path, PathBuf};

/// A spawn this far above or below the ground is on another floor (yards).
pub const FLOOR_YARDS: f64 = 6.0;
/// Floors of one building lie within this of each other (yards): Northshire Abbey's tower top is 31 over its floor.
pub const STOREY_YARDS: f64 = 40.0;
/// The surface a spawn stands on lies within this of its height (yards).
pub const AT_YARDS: f64 = 3.0;
/// The top floor of a tower stands this far up at least (yards); a lower floor with only the roof over it is upstairs.
pub const TOP_YARDS: f64 = 20.0;

const NOT_WALKED: u8 = flag::BLOCKED | flag::SWIM | flag::OCEAN;

fn indoor(f: u8) -> bool {
	f & flag::INDOOR != 0 && f & NOT_WALKED == 0
}

/// The walkable surface of a column a spawn at height `z` stands on: (z, flags), or None.
fn stand(col: &[(f64, u8)], z: f64) -> Option<(f64, u8)> {
	col.iter().copied().filter(|(s, f)| f & NOT_WALKED == 0 && (s - z).abs() <= AT_YARDS).min_by(|a, b| (a.0 - z).abs().total_cmp(&(b.0 - z).abs()))
}

/// The ground of a column under a floor at `at`: the terrain's surface within STOREY_YARDS, or the floor of a hall
/// raised over it (its lowest indoor floor not under the terrain, more than FLOOR_YARDS up); without the terrain, the
/// lowest walkable surface no further than STOREY_YARDS below.
fn column_ground(col: &[(f64, u8)], at: f64) -> f64 {
	let terrain = col.iter().filter(|(_, f)| f & flag::TERRAIN != 0).map(|(s, _)| *s).filter(|t| (t - at).abs() <= STOREY_YARDS).reduce(f64::max);
	match terrain {
		Some(t) => {
			let hall = col.iter().filter(|(s, f)| indoor(*f) && *s >= t - FLOOR_YARDS).map(|(s, _)| *s).reduce(f64::min);
			hall.filter(|h| h - t > FLOOR_YARDS).unwrap_or(t)
		}
		None => col.iter().filter(|(s, f)| f & NOT_WALKED == 0 && *s >= at - STOREY_YARDS).map(|(s, _)| *s).fold(at, f64::min),
	}
}

/// The floor word of a spawn at height `z` over its column's surfaces (`(z, grid flags)`, any order), or None.
pub fn floor_word(col: &[(f64, u8)], z: f64) -> Option<&'static str> {
	if !col.iter().any(|(_, f)| f & flag::TERRAIN != 0) {
		return None;
	}
	let (at, at_flags) = stand(col, z)?;
	let d = at - column_ground(col, at);
	if d < -FLOOR_YARDS {
		return (at_flags & flag::INDOOR != 0).then_some("below");
	}
	if d > FLOOR_YARDS && col.iter().any(|(_, f)| indoor(*f)) {
		let under_roof = !col.iter().any(|(s, f)| indoor(*f) && *s > at + AT_YARDS && *s <= at + STOREY_YARDS);
		return Some(if under_roof && d > TOP_YARDS { "top" } else { "up" });
	}
	None
}

/// The floor word of a spawn at height `z` on continent `c` at world (`wx`, `wy`), over the grid's column there.
pub fn floor_word_at(grid: &Grid, c: u32, wx: f64, wy: f64, z: f64) -> Option<&'static str> {
	let (col, row, i, j) = cell_of(wx, wy);
	let t = grid.tile(c, col, row)?;
	let k = j as usize * TILE_CELLS + i as usize;
	let (a, b) = (*t.first.get(k)? as usize, *t.first.get(k + 1)? as usize);
	let surfaces: Vec<(f64, u8)> = (a..b).map(|e| (t.z[e] as f64, t.flags[e])).collect();
	floor_word(&surfaces, z)
}

/// The walking grid the data build reads: $POLESTAR_GRID, else <root>/data/local/nav4.
pub fn grid_dir(root: &Path) -> PathBuf {
	std::env::var_os("POLESTAR_GRID").map_or_else(|| root.join("data").join("local").join("nav4"), PathBuf::from)
}

/// floors.json from spawnz.json's `npc` and `object` tables (id -> [[c, wx, wy, z, ...], ...]), read tile by tile:
/// (the document, the number of spawns that got a word, the number looked at).
pub fn floors(grid: &Grid, npc: &V, object: &V) -> (V, usize, usize) {
	// Every spawn: (kind, id, its index in the id's list, c, wx, wy, z), grouped by the tile it lies in.
	let tables = [("npc", npc), ("object", object)];
	let mut by_tile: FxHashMap<(u32, i64, i64), Vec<(usize, usize, usize, f64, f64, f64)>> = FxHashMap::default();
	let mut lists: Vec<Vec<(String, Vec<V>)>> = Vec::new();
	let mut seen = 0;
	for (t, (_, table)) in tables.iter().enumerate() {
		let entries: Vec<(String, Vec<V>)> = table.entries().into_iter().map(|(id, list)| (id.to_string(), list.items())).collect();
		for (n, (_, list)) in entries.iter().enumerate() {
			for (k, s) in list.iter().enumerate() {
				let (c, wx, wy, z) = (s.num_at(0), s.num_at(1), s.num_at(2), s.num_at(3));
				if !(c >= 0.0 && c.fract() == 0.0 && wx.is_finite() && wy.is_finite() && z.is_finite()) {
					continue;
				}
				seen += 1;
				let (col, row, _, _) = cell_of(wx, wy);
				by_tile.entry((c as u32, col, row)).or_default().push((t, n, k, wx, wy, z));
			}
		}
		lists.push(entries);
	}
	let mut found: FxHashMap<(usize, usize, usize), &'static str> = FxHashMap::default();
	let mut tiles: Vec<_> = by_tile.into_iter().collect();
	tiles.sort_by_key(|(k, _)| *k);
	for ((c, _, _), spawns) in tiles {
		for (t, n, k, wx, wy, z) in spawns {
			if let Some(w) = floor_word_at(grid, c, wx, wy, z) {
				found.insert((t, n, k), w);
			}
		}
	}
	let out = Obj::new();
	for (t, (kind, _)) in tables.iter().enumerate() {
		let by_id = Obj::new();
		for (n, (id, list)) in lists[t].iter().enumerate() {
			let rows: Vec<V> =
				list.iter().enumerate().filter_map(|(k, s)| found.get(&(t, n, k)).map(|w| arr(vec![V::Num(s.num_at(0)), V::Num(s.num_at(1)), V::Num(s.num_at(2)), V::str(w)]))).collect();
			if !rows.is_empty() {
				by_id.set(id, arr(rows));
			}
		}
		out.set(kind, V::Obj(by_id));
	}
	(V::Obj(out), found.len(), seen)
}

/// floors.json's text for spawnz.json's text over the grid: (text, spawns with a word, spawns looked at).
pub fn build(grid: &Grid, spawnz: &str) -> Result<(String, usize, usize), String> {
	let db = forge_guide::js::parse_json(spawnz)?;
	let (doc, words, seen) = floors(grid, &db.get("npc"), &db.get("object"));
	Ok((crate::cmangos::serialize_spawn_heights(&doc), words, seen))
}

/// meta.json's source entry for the walking grid (floors.json, and the zones spawns are placed in).
pub fn source(grid: &Grid) -> V {
	let o = Obj::new();
	o.set("name", "Polestar's walking grid: the floors over each spot (floors.json) and the zone each spot stands in");
	o.set("url", V::Null);
	o.set("revision", format!("built {}", grid.built_at).as_str());
	o.set("license", "Polestar original work, built from the game client's map geometry (heights, flags and area ids only)");
	o.set("copyright", V::Null);
	V::Obj(o)
}

#[cfg(test)]
mod tests {
	use super::*;
	const T: u8 = flag::TERRAIN;
	const W: u8 = flag::WMO;
	const I: u8 = flag::WMO | flag::INDOOR;
	const B: u8 = flag::BLOCKED;

	#[test]
	fn a_cellar_under_the_ground_is_below_the_ground_floor_and_open_ground_is_nothing() {
		// The walking grid at Maximillian Crowe in Goldshire's inn (spawn z 49.9): the cellar's floor, the terrain
		// (blocked: under the inn) at 56.5, the inn's floors and its roof.
		let inn = [(49.79, I), (55.99, I | B), (56.47, T | B), (57.43, I | B), (57.52, W), (62.87, W | B), (66.32, I | B | 64), (71.02, W)];
		assert_eq!(floor_word(&inn, 49.9), Some("below"));
		assert_eq!(floor_word(&inn, 57.5), None, "the ground floor");
		assert_eq!(floor_word(&[(30.0, T)], 30.2), None, "open ground");
	}

	#[test]
	fn a_floor_over_the_ground_is_up_a_tower_s_top_under_its_roof_only_is_the_top() {
		// Khelden Bremen, one floor up in Northshire Abbey (z 89.5): only the roof over him.
		let khelden = [(80.78, T | B), (81.94, I), (88.81, I | B), (89.31, I), (105.55, W), (110.73, W)];
		assert_eq!(floor_word(&khelden, 89.5), Some("up"));
		// Brother Neals at the top of the Abbey's tower (z 113.2): its floors under him, its roof over him.
		let tower = [(80.34, T), (82.5, I), (86.07, I | B | 64), (98.81, I), (108.83, I), (113.16, I), (126.7, W | B), (128.45, W)];
		assert_eq!(floor_word(&tower, 113.2), Some("top"));
		assert_eq!(floor_word(&tower, 98.8), Some("up"), "a floor of the tower with more over it");
	}

	#[test]
	fn no_word_out_of_doors_far_under_a_mountain_in_an_instance_or_off_every_surface() {
		assert_eq!(floor_word(&[(10.0, T), (18.0, W)], 18.0), None, "a deck or a bridge in the open");
		// A city under a mountain: the terrain 120 yards up is no storey of it.
		assert_eq!(floor_word(&[(620.0, T), (502.0, I), (508.0, I)], 502.0), None);
		assert_eq!(floor_word(&[(620.0, T), (502.0, I), (512.0, I)], 512.0), Some("up"), "a floor over the city's");
		assert_eq!(floor_word(&[(30.0, T), (40.0, I)], 35.0), None, "no surface at the spawn's height");
		assert_eq!(floor_word(&[(0.0, I), (12.0, I)], 12.0), None, "an instance's halls, no terrain");
		// Thrall in Grommash Hold (z 43): the hall's floor stands 17 yards over the terrain carved under it.
		let hold = [(25.4, T), (42.9, I), (55.8, I), (63.5, I)];
		assert_eq!(floor_word(&hold, 43.0), None, "a raised hall's own floor");
		assert_eq!(floor_word(&hold, 55.8), Some("up"), "a floor over the hall's");
	}
}
