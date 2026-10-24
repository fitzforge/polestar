//! Walking paths players reported as impossible, each on the real engine and the shipped maps
//! (addon/Polestar_Nav): the player's spot and the target as the bug report gave them (Era map coordinates),
//! the path the engine draws, and the ground it must not cross. A report stays here once fixed, so the next
//! re-pack cannot bring it back.

use forge_addontest::{emitted, truthy, Addon, RunAddon};
use serde_json::Value;

/// A point in the world: continent, wx (north), wy (west), and a height only when given.
#[derive(Clone, Copy)]
struct Pt {
	c: i64,
	x: f64,
	y: f64,
	z: Option<f64>,
}

/// A path's point: x, y, and its height when it has one.
type P = (f64, f64, Option<f64>);

// Compat.MapToWorld with the Era frame: continent, wx (north), wy (west).
fn world(map: i64, x: f64, y: f64) -> Pt {
	let file = forge_addontest::locale::data_dir().join("map-frames.json");
	let text = std::fs::read_to_string(&file).unwrap_or_else(|e| panic!("{}: {e}", file.display()));
	let frames: Value = serde_json::from_str(&text).unwrap();
	let b = &frames["era"][map.to_string()];
	let f = |k: &str| b[k].as_f64().unwrap_or_else(|| panic!("map {map}: no {k}"));
	Pt { c: b["c"].as_i64().unwrap(), x: f("top") + ((f("bottom") - f("top")) * y) / 100.0, y: f("left") + ((f("right") - f("left")) * x) / 100.0, z: None }
}

const WALK: &str = r#"
local Path = Polestar_NavEngine
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local got = false
Path.Find(@C, @FROM, @TO, function(points, cost)
	if points then
		got = { points = {}, cost = cost }
		for i, p in ipairs(points) do got.points[i] = { p.x, p.y, p.z or false } end
	end
end@PROFILE)
while #frames > 0 do table.remove(frames, 1)() end
emit(got)"#;

// The engine's path from `from` to `to` (a height each only when given: the client reports none for the
// player; a goal or a leg's end may carry one), as { points = { { x, y, z }, ... }, cost } or false when it
// finds none; profile: "Alliance" | "Horde" (none by default).
fn walk(from: Pt, to: Pt, profile: Option<&str>) -> Value {
	assert_eq!(from.c, to.c);
	let pt = |p: Pt| match p.z {
		Some(z) => format!("{{ x = {}, y = {}, z = {} }}", p.x, p.y, z),
		None => format!("{{ x = {}, y = {} }}", p.x, p.y),
	};
	let profile = profile.map(|p| format!(", {{ profile = \"{p}\" }}")).unwrap_or_default();
	let script = WALK.replace("@C", &from.c.to_string()).replace("@FROM", &pt(from)).replace("@TO", &pt(to)).replace("@PROFILE", &profile);
	emitted(&RunAddon { stubs: vec!["stub_encoding.lua"], addons: vec![Addon::name("Polestar_Nav")], script, ..Default::default() }).into_iter().next().unwrap_or(Value::Null)
}

/// The points of a walk the engine found.
fn points(got: &Value) -> Vec<P> {
	got["points"].as_array().expect("points").iter().map(|p| (p[0].as_f64().unwrap(), p[1].as_f64().unwrap(), p[2].as_f64())).collect()
}

/// The walk's cost, rounded.
fn cost(got: &Value) -> f64 {
	got["cost"].as_f64().unwrap_or(f64::NAN).round()
}

// Nearest distance (yd) from point p to the path's line.
fn off_path(points: &[P], p: Pt) -> f64 {
	let mut best = f64::INFINITY;
	for i in 1..points.len() {
		let (ax, ay, _) = points[i - 1];
		let (bx, by, _) = points[i];
		let dx = bx - ax;
		let dy = by - ay;
		let l2 = dx * dx + dy * dy;
		let t = if l2 > 0.0 { (((p.x - ax) * dx + (p.y - ay) * dy) / l2).clamp(0.0, 1.0) } else { 0.0 };
		best = best.min((ax + dx * t - p.x).hypot(ay + dy * t - p.y));
	}
	best
}

// The yards a path walks, along the ground (x, y).
fn yards_of(pts: &[P]) -> f64 {
	let mut yards = 0.0;
	for i in 1..pts.len() {
		yards += (pts[i].0 - pts[i - 1].0).hypot(pts[i].1 - pts[i - 1].1);
	}
	yards
}

// Fitz, 2026-10-16, Raptor Horns (The Barrens): from 61.66,35.46 to the horns' first spot at 61.00,33.70 the
// arrow went straight up the hill in front of him, which he could not climb. The maps put the ground at 80 yd
// where he stood and 94 yd 12 yd on (84, 90 between: 45-56 degrees), flat beyond; every cell of that face
// packed as walkable both ways.
#[test]
fn raptor_horns_the_barrens_the_walk_from_61_66_35_46_to_61_00_33_70_does_not_climb_the_80_to_94_yd_face_in_front_of_the_player() {
	forge_addontest::needs!("map-frames.json");
	let from = world(1413, 61.66, 35.46);
	let to = world(1413, 61.0, 33.7);
	let got = walk(from, to, None);
	assert!(truthy(&got), "the engine finds a walk");
	let pts = points(&got);
	let last = pts[pts.len() - 1];
	assert!((last.0 - to.x).hypot(last.1 - to.y) < 10.0, "to the spot");
	// The middle of the face: 8 yd from the player towards the spot (90 yd high).
	let straight = (to.x - from.x).hypot(to.y - from.y);
	let face = Pt { c: from.c, x: from.x + ((to.x - from.x) * 8.0) / straight, y: from.y + ((to.y - from.y) * 8.0) / straight, z: None };
	let off = off_path(&pts, face);
	assert!(off > 3.0, "the path passes {:.1} yd from the face's middle ({} points, {} yd)", off, pts.len(), cost(&got));
}

// Fitz, 2026-10-16, Ratchet (The Barrens), Horde, heading for 54,51: the walk left the north-east road, ran
// straight south along a line and turned 90 degrees west onto the main road instead of keeping to the
// north-east road down to the junction. The tile border at y -3733.3 crosses both roads 35 yd apart, and its
// one entrance there sat on the main road, so every walk off the north-east road crossed the border along it.
// The 62 yd leg between two spots on the north-east road either side of the border walked 91 yd.
#[test]
fn ratchet_the_barrens_the_62_yd_walk_along_the_north_east_road_across_the_tile_border_913_3_3749_2_to_935_1_3692_stays_on_the_road() {
	forge_addontest::needs!("map-frames.json");
	let from = Pt { c: 1, x: -913.3, y: -3749.2, z: None };
	let to = Pt { c: 1, x: -935.1, y: -3692.0, z: None };
	let got = walk(from, to, Some("Horde"));
	assert!(truthy(&got), "the engine finds a walk");
	let pts = points(&got);
	let last = pts[pts.len() - 1];
	assert!((last.0 - to.x).hypot(last.1 - to.y) < 10.0, "to the spot");
	let yards = yards_of(&pts);
	let straight = (to.x - from.x).hypot(to.y - from.y);
	assert!(yards <= straight * 1.15, "the walk is {:.1} yd for {:.1} yd straight ({} points)", yards, straight, pts.len());
}

// #420 (Fitz, found checking Annie's #350), the Undercity: every walk from the Apothecarium (1458
// 51.47,56.39, z -61.4) to the Royal Quarter climbed out of the city to the ruins (z +80) and ended in a 485 yd
// straight line down, 1159 yd: the corridor into the Royal Quarter (1458 46,73 to 49,88) and the quarter itself
// lie under one of Tirisfal's lakes, and the pack dropped every floor under the lake. The navigation grid walks
// it in 373 yd indoors.
#[test]
fn undercity_the_walk_from_the_apothecarium_to_varimathras_stays_in_the_city_420() {
	forge_addontest::needs!("map-frames.json");
	let from = Pt { c: 0, x: 1516.99, y: 379.403, z: Some(-61.4) };
	let to = Pt { c: 0, x: 1287.769, y: 333.545, z: Some(-60.0) };
	let got = walk(from, to, Some("Horde"));
	assert!(truthy(&got), "the engine finds a walk");
	let pts = points(&got);
	let last = pts[pts.len() - 1];
	assert!((last.0 - to.x).hypot(last.1 - to.y) < 10.0, "to Varimathras");
	let yards = yards_of(&pts);
	assert!(yards < 500.0, "the walk is {:.0} yd ({} points)", yards, pts.len());
	let top = pts.iter().filter_map(|p| p.2).fold(f64::NEG_INFINITY, f64::max);
	assert!(top < -30.0, "it stays under the ground, never higher than {:.1}", top);
}

// #541 (Deadshot), Stormwind, Alliance: from the Trade District (1453 68.48,75.35 live, street height 107) to
// Jennea Cannon in the Wizard's Sanctum (the guide's goal: 49.56,85.80 live, z 29.7) the arrow ran a straight
// line along the city walls, 369 yd. The client gives no height for the player, so the walk may start on any
// storey under them: it takes the terrain buried under the streets (75 yd under the Trade District, 59.5 under
// the Mage Quarter) and joins the Sanctum's lower floors from it. The navigation grid walks the streets, 489
// yd, never under 87 yd. Open: the maps keep that terrain walkable.
#[test]
#[ignore = "open: the maps still walk the terrain under the city"]
fn stormwind_the_walk_from_the_trade_district_to_jennea_cannon_keeps_to_the_streets_not_the_terrain_under_them_541() {
	forge_addontest::needs!("map-frames.json");
	let from = Pt { c: 0, x: -8868.639, y: 533.077, z: None };
	let to = Pt { c: 0, x: -8989.686, y: 861.813, z: Some(29.7) };
	let got = walk(from, to, Some("Alliance"));
	assert!(truthy(&got), "the engine finds a walk");
	let pts = points(&got);
	let last = pts[pts.len() - 1];
	assert!((last.0 - to.x).hypot(last.1 - to.y) < 10.0, "to Jennea Cannon");
	// Outside the Sanctum (40 yd round her), every point stands on a street.
	for &(x, y, z) in &pts {
		let Some(z) = z else { continue };
		if (x - to.x).hypot(y - to.y) < 40.0 {
			continue;
		}
		assert!(z > 85.0, "the walk passes {:.1},{:.1} at {} yd, under the streets ({} points, {} yd)", x, y, z, pts.len(), yards_of(&pts).round());
	}
}

// #338 (Tazul), Stormwind: from the Dwarven District (66.04,39.37, street height 95) the walk to the Deeprun
// Tram climbed the road towards the Keep and ended on the roof above the tram's entrance, 417 yd: the tram's
// end had no height, so the engine took the cheapest surface there. The travel data gives the end the
// entrance's floor (its AreaTrigger's height on the grid), and the walk there is 131 yd, almost straight.
#[test]
fn stormwind_the_walk_to_the_deeprun_tram_ends_at_its_entrance_not_on_the_roof_above_it_338() {
	forge_addontest::needs!("map-frames.json");
	let tram = emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		script: r#"
			for _, t in ipairs(Polestar.Nav.GetTravelData().transports) do
				if t.id == "tram-stormwind-ironforge" then emit({ c = t.a.c, x = t.a.wx, y = t.a.wy, z = t.a.z or false }) end
			end"#
			.into(),
		..Default::default()
	})
	.into_iter()
	.next()
	.unwrap_or(Value::Null);
	assert!(truthy(&tram), "the tram is in the travel data");
	assert!(tram["z"].is_number(), "its Stormwind end has a height");
	let tram_z = tram["z"].as_f64().unwrap();
	let to = Pt { c: tram["c"].as_i64().unwrap(), x: tram["x"].as_f64().unwrap(), y: tram["y"].as_f64().unwrap(), z: Some(tram_z) };
	let from = Pt { c: 0, x: -8451.868, y: 575.472, z: Some(95.0) };
	let got = walk(from, to, Some("Alliance"));
	assert!(truthy(&got), "the engine finds a walk");
	let pts = points(&got);
	let last = pts[pts.len() - 1];
	assert!((last.0 - to.x).hypot(last.1 - to.y) < 10.0, "to the tram");
	let yards = yards_of(&pts);
	assert!(yards < 150.0, "the walk is {:.0} yd ({} points)", yards, pts.len());
	let end = pts.iter().filter_map(|p| p.2).next_back().expect("a point with a height");
	assert!((end - tram_z).abs() < 5.0, "it ends at the entrance's height ({}, the entrance {})", end, tram_z);
}

// #540 (EpicTibbles), Teldrassil, Alliance: from 1438 42.10,56.59 to The Sleeping Druid at Ban'ethil Barrow
// Den (44.94,61.59) the arrow led up the hill in front of the player, which they could not climb. The client's
// terrain there rises from 1364 to 1403 yd in the first 40 yd at 51 to 62 degrees, and the walk goes straight
// up it (and up two more faces past it, 56 to 61 degrees). Open: on the grid, nothing joins the ground below to
// the Barrow Den's hilltop but faces over 50 degrees, so the pack opens the gentlest of them as the only way
// up; whether the client walks them is #98's.
#[test]
#[ignore = "open: the maps still climb the face (#98)"]
fn teldrassil_the_walk_from_42_10_56_59_to_the_sleeping_druid_does_not_climb_the_face_in_front_of_the_player_540() {
	forge_addontest::needs!("map-frames.json");
	let from = world(1438, 42.1, 56.59);
	let to = world(1438, 44.94, 61.59);
	let got = walk(from, to, Some("Alliance"));
	assert!(truthy(&got), "the engine finds a walk");
	let pts = points(&got);
	let last = pts[pts.len() - 1];
	assert!((last.0 - to.x).hypot(last.1 - to.y) < 10.0, "to The Sleeping Druid");
	// The face's middle: the ground at 1380 yd, its triangles 53 to 56 degrees.
	let face = world(1438, 42.22, 56.29);
	let off = off_path(&pts, face);
	assert!(off > 3.0, "the path passes {:.1} yd from the face's middle ({} points, {} yd)", off, pts.len(), yards_of(&pts).round());
}

// #314 (Tac), Stormwind, Alliance: from the shore north-west of the city (1415 41.08,62.23) to Grimand Elmore
// in the Dwarven District (1453 59.73,33.78, his spawn; the report cut the target's coordinates short) the walk
// crossed the cliffs and rocky ground just north-west of the walls, which the player could not climb. The maps
// cross them above the city's map (1453 30 to 52 across, -16 to 6 down): up from 70 to 162 yd at 50 to 59
// degrees, then 24 yd down at 58 degrees into the city. Open, one of #98's slopes.
#[test]
#[ignore = "open: the maps still cross the cliffs (#98)"]
fn stormwind_the_walk_from_the_shore_north_west_of_the_city_to_grimand_elmore_does_not_cross_the_cliffs_north_west_of_the_walls_314() {
	forge_addontest::needs!("map-frames.json");
	let from = world(1415, 41.08, 62.23);
	let to = world(1453, 59.73, 33.78);
	let got = walk(from, to, Some("Alliance"));
	assert!(truthy(&got), "the engine finds a walk");
	let pts = points(&got);
	let last = pts[pts.len() - 1];
	assert!((last.0 - to.x).hypot(last.1 - to.y) < 10.0, "to Grimand Elmore");
	let a = world(1453, 30.0, -16.0);
	let b = world(1453, 52.0, 6.0);
	let inside = |x: f64, y: f64| x <= a.x && x >= b.x && y <= a.y && y >= b.y;
	for i in 1..pts.len() {
		let (ax, ay, _) = pts[i - 1];
		let (bx, by, _) = pts[i];
		let steps = ((bx - ax).hypot(by - ay) / 2.0).ceil();
		for s in 0..=(steps as i64) {
			let x = ax + ((bx - ax) * s as f64) / steps;
			let y = ay + ((by - ay) * s as f64) / steps;
			assert!(!inside(x, y), "the leg from {:.1},{:.1} to {:.1},{:.1} crosses the cliffs ({} points, {} yd)", ax, ay, bx, by, pts.len(), yards_of(&pts).round());
		}
	}
}
