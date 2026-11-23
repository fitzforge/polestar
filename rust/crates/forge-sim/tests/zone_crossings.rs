//! A walk from one zone into another passes a known zone crossing (forge-sim ZoneCrossings,
//! World::crossings), or it is no walk: c14 review, Thunder Bluff's west lift over the ridge to
//! Scrabblescrew's Camp in Desolace (the store's 3505 yd; Mulgore's one crossing is the gate to the
//! Barrens, Desolace's are Stonetalon's and Feralas').

use forge_sim::walks::ZoneCrossings;
use forge_world::world::{Crossing, Crossings, Point};

const MULGORE: u32 = 1412;
const THUNDER_BLUFF: u32 = 1456;
const BARRENS: u32 = 1413;
const DESOLACE: u32 = 1443;
const STONETALON: u32 = 1442;

fn pt(map: u32, wx: f64, wy: f64) -> Point {
	Point { c: 1, region: 10, wx, wy, map, z: None }
}

fn way(id: &str, a: (u32, f64, f64), b: (u32, f64, f64)) -> Crossing {
	Crossing { id: id.into(), c: 1, a: (a.0, a.1, a.2, 30.0), b: (b.0, b.1, b.2, 30.0), one_way: false }
}

/// c14's data/crossings.json ways out of Mulgore and into Desolace (the Barrens to Stonetalon left
/// out: no way joins them here) and Mulgore's open border with Thunder Bluff.
fn crossings() -> Crossings {
	Crossings {
		ways: vec![
			way("carbonite-the-barrens--mulgore", (BARRENS, -2348.0, -1619.9), (MULGORE, -2348.1, -1475.9)),
			way("carbonite-desolace--stonetalon-mountains", (DESOLACE, 286.6, 1832.6), (STONETALON, 454.6, 1770.6)),
		],
		open: vec![(MULGORE, THUNDER_BLUFF)],
	}
}

#[test]
fn a_walk_between_zones_that_passes_no_crossing_is_no_walk() {
	// 0: Thunder Bluff's west lift (top); 1: Scrabblescrew's Camp; 2: Bloodhoof Village (Mulgore);
	// 3: Camp Taurajo (the Barrens); 4: Sun Rock Retreat (Stonetalon); 5: Ghost Walker Post.
	let pts =
		[pt(THUNDER_BLUFF, -1297.3, 187.5), pt(DESOLACE, -1402.4, 1497.2), pt(MULGORE, -2338.0, -400.0), pt(BARRENS, -2380.0, -1980.0), pt(STONETALON, 966.6, 1040.3), pt(DESOLACE, -1100.0, 1700.0)];
	let z = ZoneCrossings::of(&pts, &crossings());
	// No way joins Mulgore to Desolace here: the store's 3505 yd ridge walk is unwalkable.
	assert_eq!(z.judge(0, 1, Some(3505.0)), Some(f64::INFINITY));
	// A pair the store lacks is judged by its straight line: no straight walk over the ridge.
	assert_eq!(z.judge(0, 1, None), Some(f64::INFINITY));
	// Thunder Bluff and Mulgore share an open border: one zone, walks stand.
	assert_eq!(z.judge(0, 2, Some(2800.0)), Some(2800.0));
	// Bloodhoof to Camp Taurajo through the gate stands; one shorter than the way through it does not.
	let through = z.way(2, 3);
	assert!(through.is_finite() && through > 1300.0, "{through}");
	assert_eq!(z.judge(2, 3, Some(through + 200.0)), Some(through + 200.0));
	assert_eq!(z.judge(2, 3, Some(through * 0.8)), Some(f64::INFINITY));
	// Stonetalon to Desolace by its crossing: Sun Rock to Ghost Walker Post's walk stands.
	let st = z.way(4, 5);
	assert!(st.is_finite());
	assert_eq!(z.judge(4, 5, Some(st * 1.2)), Some(st * 1.2));
	// Within a zone nothing is judged, nor an unwalkable pair.
	assert_eq!(z.judge(1, 5, Some(400.0)), Some(400.0));
	assert_eq!(z.judge(2, 3, Some(f64::INFINITY)), Some(f64::INFINITY));
}

#[test]
fn a_point_with_no_zone_map_or_on_another_region_is_not_judged() {
	let mut lift = pt(0, -1297.3, 187.5);
	let isle = Point { region: 12, ..pt(DESOLACE, -1402.4, 1497.2) };
	lift.map = 0;
	let pts = [lift, pt(DESOLACE, -1402.4, 1497.2), isle, pt(MULGORE, -1300.0, 190.0)];
	let z = ZoneCrossings::of(&pts, &crossings());
	assert_eq!(z.judge(0, 1, Some(900.0)), Some(900.0));
	assert_eq!(z.judge(3, 2, Some(900.0)), Some(900.0));
}
