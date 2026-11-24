//! The zone a world point stands in, from the walking grid's area ids (#2875): each map chunk of a grid tile (16 x 16
//! cells, about 33 yards a side) carries the client's AreaTable id of its ground, which the caller turns into a zone's
//! map (maps.rs `resolve_area`). Along a zone's border, and in a building or a cave whose own area the game reads
//! there, a chunk's area can be the neighbour's (The Ancient Egg, in The Hinterlands where players loot it, lies in a
//! chunk the grid gives Arathi Highlands), so a point's zone counts only where its chunk and the eight around it
//! agree.

use forge_nav::grid::{cell_of, Grid};
use rustc_hash::FxHashMap;
use std::cell::RefCell;

/// Map chunks across a grid tile.
const CHUNKS: i64 = 16;

pub struct GridZones<'a> {
	grid: &'a Grid,
	/// (continent, tile column, tile row) -> its chunks' area ids (None: no tile there).
	areas: RefCell<FxHashMap<(u32, i64, i64), Option<Vec<u16>>>>,
}

impl<'a> GridZones<'a> {
	pub fn new(grid: &'a Grid) -> GridZones<'a> {
		GridZones { grid, areas: RefCell::default() }
	}

	/// The area id of chunk (`gx`, `gy`) of continent `c` (chunks counted across the whole map), or None.
	fn area(&self, c: u32, gx: i64, gy: i64) -> Option<u16> {
		let (col, row) = (gx.div_euclid(CHUNKS), gy.div_euclid(CHUNKS));
		let mut memo = self.areas.borrow_mut();
		let tile = memo.entry((c, col, row)).or_insert_with(|| self.grid.tile(c, col, row).map(|t| t.areas.clone()));
		let a = *tile.as_ref()?.get((gy.rem_euclid(CHUNKS) * CHUNKS + gx.rem_euclid(CHUNKS)) as usize)?;
		(a > 0).then_some(a)
	}

	/// The zone (`zone_of_area`'s answer for an area id) of a world point, when its map chunk and the eight around it
	/// all give that zone, else None.
	pub fn zone_at(&self, c: f64, wx: f64, wy: f64, zone_of_area: &dyn Fn(u16) -> Option<i64>) -> Option<i64> {
		if !(c >= 0.0 && c.fract() == 0.0) {
			return None;
		}
		let (col, row, i, j) = cell_of(wx, wy);
		let (gx, gy) = (col * CHUNKS + (i >> 4), row * CHUNKS + (j >> 4));
		agree((-1..=1).flat_map(|dy| (-1..=1).map(move |dx| (dx, dy))).map(|(dx, dy)| self.area(c as u32, gx + dx, gy + dy).and_then(zone_of_area)))
	}
}

/// The one zone every chunk gives, or None (a chunk without one, or two zones).
pub fn agree(zones: impl IntoIterator<Item = Option<i64>>) -> Option<i64> {
	let mut it = zones.into_iter();
	let first = it.next()??;
	it.all(|z| z == Some(first)).then_some(first)
}

#[cfg(test)]
mod tests {
	use super::agree;

	#[test]
	fn a_point_s_zone_counts_only_where_the_chunks_around_it_agree() {
		assert_eq!(agree([Some(1425); 9]), Some(1425));
		let mut border = [Some(1425); 9];
		border[4] = Some(1417);
		assert_eq!(agree(border), None, "The Ancient Egg's chunk, Arathi Highlands' among The Hinterlands'");
		let mut edge = [Some(1425); 9];
		edge[8] = None;
		assert_eq!(agree(edge), None, "a chunk with no zone (no tile, no area)");
	}
}
