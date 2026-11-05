//! The zone crossings a written walk passes (the world's crossings: data/crossings.json, under
//! forge-sim's ZoneCrossings rule, as the routes price their walks): a walk from one zone into another
//! goes over a known crossing, never straight across a border with none (Azshara into Winterspring;
//! the way is Felwood's Timbermaw tunnel). The writer's walks get the crossings as waypoints, and the
//! travel repair's walks cost the way over them.

use forge_sim::walks::ZoneCrossings;
use forge_world::world::Crossings;

/// A walk's crossings are written as waypoints when the way over them is this much longer than the
/// straight line (the arrow would point across a border with no way over it)...
const DETOUR: f64 = 1.1;
/// ...or when the straight walk is this long (the honest play's "walk far into another zone").
const FAR_YD: f64 = forge_judge::honest::WALK_FAR_YD;
/// A waypoint this near the walk's start, its end or the waypoint before it is none.
const NEAR_YD: f64 = 100.0;

/// A place: world x, y and its zone map.
pub type Place = (f64, f64, u32);

pub struct Borders {
	zc: ZoneCrossings,
	/// Each crossing's ends (zone map, world x, y), as World::crossings.ways.
	ends: Vec<(Place, Place)>,
}

impl Borders {
	/// None for a world built without crossings.
	pub fn of(cr: &Crossings) -> Option<Borders> {
		(!cr.ways.is_empty()).then(|| Borders { zc: ZoneCrossings::of(&[], cr), ends: cr.ways.iter().map(|w| ((w.a.1, w.a.2, w.a.0), (w.b.1, w.b.2, w.b.0))).collect() })
	}

	/// The fewest yards a walk from a to b on continent `c` takes: the straight line, or the way over
	/// the crossings when that is longer (infinite where no crossing joins their zones).
	pub fn walk_yd(&self, c: i64, a: Place, b: Place) -> f64 {
		(a.0 - b.0).hypot(a.1 - b.1).max(self.zc.way_between(c, a, b))
	}

	/// The waypoints of a walk from a to b on continent `c`: each crossing it passes, at the crossing's
	/// end in the zone it leads into (the way in, not a stop out to one side of the walk), when the
	/// straight line would miss the crossings or is far. None within one zone, nor where no crossing
	/// joins them.
	pub fn waypoints(&self, c: i64, a: Place, b: Place) -> Vec<Place> {
		let straight = (a.0 - b.0).hypot(a.1 - b.1);
		let way = self.zc.way_between(c, a, b);
		if !way.is_finite() || way == 0.0 || (way <= straight * DETOUR && straight <= FAR_YD) {
			return Vec::new();
		}
		let near = |p: Place, q: Place| (p.0 - q.0).hypot(p.1 - q.1) <= NEAR_YD;
		let mut out: Vec<Place> = Vec::new();
		for x in self.zc.path(c, a, b) {
			let (ea, eb) = self.ends[x.crossing];
			let p = if x.from_a { eb } else { ea };
			if near(p, a) || near(p, b) || out.last().is_some_and(|&q| near(p, q)) {
				continue;
			}
			out.push(p);
		}
		out
	}
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_world::world::Crossing;

	fn cr() -> Crossings {
		// Three zones in a row (1, 2, 3; 3 also borders 4 with no crossing): crossings at x = 1000 and
		// x = 2000, the ends 20 yd apart.
		let w = |id: &str, a: u32, b: u32, x: f64| Crossing { id: id.into(), c: 1, a: (a, x - 10.0, 500.0, 30.0), b: (b, x + 10.0, 500.0, 30.0), one_way: false };
		Crossings { ways: vec![w("one-two", 1, 2, 1000.0), w("two-three", 2, 3, 2000.0)], open: Vec::new() }
	}

	#[test]
	fn a_walk_across_a_border_with_no_crossing_goes_by_the_crossings() {
		let b = Borders::of(&cr()).unwrap();
		// Zone 1 at the bottom to zone 3 at the bottom: the straight line misses both crossings.
		let (from, to) = ((500.0, 4000.0, 1), (2500.0, 4000.0, 3));
		assert_eq!(b.waypoints(1, from, to), vec![(1010.0, 500.0, 2), (2010.0, 500.0, 3)]);
		assert!(b.walk_yd(1, from, to) > 6000.0);
		// Through the crossing anyway: no waypoint.
		assert!(b.waypoints(1, (500.0, 500.0, 1), (1500.0, 500.0, 2)).is_empty());
		// One zone: none; no crossing joins them: none, and no walk.
		assert!(b.waypoints(1, (100.0, 100.0, 1), (900.0, 4000.0, 1)).is_empty());
		assert!(b.waypoints(1, from, (2500.0, 4000.0, 4)).is_empty());
		assert!(b.walk_yd(1, from, (2500.0, 4000.0, 4)).is_infinite());
	}

	#[test]
	fn a_crossing_inside_zones_joined_by_an_open_border_is_no_waypoint() {
		// Durotar and the Barrens are one (an open border): their crossing is not written on the walk
		// from Durotar on into a third zone.
		let mut c = cr();
		c.open.push((1, 2));
		let b = Borders::of(&c).unwrap();
		assert_eq!(b.waypoints(1, (500.0, 4000.0, 1), (2500.0, 4000.0, 3)), vec![(2010.0, 500.0, 3)]);
	}
}
