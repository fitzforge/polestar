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

// The surfaces at (c, x, y) on the shipped maps: { height, the row's English name, its name in the client's language
// from the language folder's Subzones.lua, loaded as Core/Locale.lua loads the folder } each.
const SUBZONES_AT: &str = r#"
local Path = Polestar_NavEngine
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local z, areas = {}, {}
Path.SurfacesAt(@C, @X, @Y, z, areas)
while #frames > 0 do table.remove(frames, 1)() end
local n = Path.SurfacesAt(@C, @X, @Y, z, areas)
local out = {}
for i = 1, n do
	out[i] = { z[i], Path.AreaName(@C, areas[i]) or false, Polestar.Names.Get("subzone", areas[i]) or false }
end
emit(out)"#;

// #2244 (Reaperwest), the Undercity, on a Spanish (Latin America) client: in the Apothecarium (1458 50.7,71.0) the
// walk to the bat handler started from a floor above the player and the arrow pointed at the wall. The client gives
// no height: there the floor is the surface the client's subzone names, and the walking maps name their areas in
// English, so "El Apothecarium" named none. The language folders name them as each language's client does
// (Subzones.lua, `forge data subzones`): at the Apothecarium and on the canal by the auction house (1628, 305: the
// canal, the walkway over it, the Ruins above), the subzone of every surface names, in each language, the surfaces
// its English name names on an English client, and the Apothecarium's name its one floor.
fn undercity_subzones_name_the_english_floors(locale: &str, apothecarium: &str) {
	forge_addontest::needs!("map-frames.json");
	let folder = forge_guide::toc::language_addon(locale);
	for (spot, at) in [("the Apothecarium", world(1458, 50.7, 71.0)), ("the canal by the auction house", Pt { c: 0, x: 1628.02, y: 305.49, z: None })] {
		let script = SUBZONES_AT.replace("@C", &at.c.to_string()).replace("@X", &at.x.to_string()).replace("@Y", &at.y.to_string());
		let got = emitted(&RunAddon {
			stubs: vec!["stub_encoding.lua"],
			before: format!("function GetLocale() return \"{locale}\" end"),
			addons: vec![Addon::name("Polestar_Nav"), Addon::files("Polestar", &["Core/Init.lua", "Core/LuaChunks.lua", "Core/Names.lua"]), Addon::files(&folder, &["Subzones.lua"])],
			script,
			..Default::default()
		})
		.remove(0);
		// (height, English name, name in the language: the folder's, else the English one)
		let surfaces: Vec<(f64, String, String)> = got
			.as_array()
			.unwrap()
			.iter()
			.map(|s| {
				let en = s[1].as_str().unwrap_or("").to_string();
				(s[0].as_f64().unwrap(), en.clone(), s[2].as_str().map_or(en, str::to_string))
			})
			.collect();
		eprintln!("{locale}, {spot}: {surfaces:?}");
		assert!(surfaces.iter().filter(|s| !s.1.is_empty()).count() >= 2, "{locale}, {spot}: floors with areas there: {surfaces:?}");
		for (_, en, local) in surfaces.iter().filter(|s| !s.1.is_empty()) {
			let by_en: Vec<f64> = surfaces.iter().filter(|s| s.1 == *en).map(|s| s.0).collect();
			let by_local: Vec<f64> = surfaces.iter().filter(|s| s.2 == *local).map(|s| s.0).collect();
			assert_eq!(by_local, by_en, "{locale}, {spot}: \"{local}\" names the surfaces \"{en}\" names in English: {surfaces:?}");
		}
		if spot == "the Apothecarium" {
			let named: Vec<f64> = surfaces.iter().filter(|s| s.2 == apothecarium).map(|s| s.0).collect();
			assert!(!named.is_empty() && surfaces.iter().any(|s| s.1 == "The Apothecarium" && s.2 == apothecarium), "{locale}: \"{apothecarium}\" names the Apothecarium: {surfaces:?}");
			let (lo, hi) = named.iter().fold((f64::INFINITY, f64::NEG_INFINITY), |(lo, hi), z| (lo.min(*z), hi.max(*z)));
			assert!(hi - lo <= 10.0, "{locale}: one floor (Walk.lua's ZTOL): {named:?}");
		}
	}
}

#[test]
fn undercity_on_a_spanish_latin_america_client_the_subzones_name_the_floors_english_names_name_2244() {
	undercity_subzones_name_the_english_floors("esMX", "El Apothecarium");
}

#[test]
fn undercity_on_a_german_client_the_subzones_name_the_floors_english_names_name_2244() {
	undercity_subzones_name_the_english_floors("deDE", "Das Apothekarium");
}

#[test]
fn undercity_on_a_russian_client_the_subzones_name_the_floors_english_names_name_2244() {
	undercity_subzones_name_the_english_floors("ruRU", "Квартал аптекарей");
}

#[test]
fn undercity_on_a_simplified_chinese_client_the_subzones_name_the_floors_english_names_name_2244() {
	undercity_subzones_name_the_english_floors("zhCN", "炼金房");
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

// #1238 (asymptotic1), Stormwind, Old Town, Alliance: on the way to the flight master (Dungar Longdrink, his spawn
// at -8835.8, 490.1, z 109.7) the arrow pointed through the back of Champion's Hall (the hall's door 1453
// 75.94,66.25, its back wall 74.15,67.63 in the client's frame), which has no way out there. The shipped maps found
// no walk from Old Town to him ("unreachable"): every graph edge carried another edge's yards, so the search's
// detour cutoff (8 times the straight line plus 2,000 yd of yards) dropped the way round by the Trade District,
// and the arrow fell back to the straight line across the hall. With each edge's own yards the walk goes round.
#[test]
fn stormwind_the_walk_from_old_town_to_the_flight_master_is_found_both_ways_and_keeps_out_of_champions_hall_1238() {
	let street = Pt { c: 0, x: -8733.5, y: 410.8, z: Some(97.8) };
	let dungar = Pt { c: 0, x: -8835.8, y: 490.1, z: Some(109.7) };
	let back_wall = Pt { c: 0, x: -8779.2, y: 434.6, z: None };
	for (from, to, what) in [(street, dungar, "to the flight master"), (dungar, street, "back to Old Town")] {
		let got = walk(from, to, Some("Alliance"));
		assert!(truthy(&got), "the engine finds a walk {what}");
		let pts = points(&got);
		let last = pts[pts.len() - 1];
		assert!((last.0 - to.x).hypot(last.1 - to.y) < 10.0, "{what}: it ends there");
		let off = off_path(&pts, back_wall);
		assert!(off > 10.0, "{what}: the line passes {:.1} yd from the hall's back wall ({} points, {} yd)", off, pts.len(), yards_of(&pts).round());
	}
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
// crossed them above the city's map (1453 30 to 52 across, -16 to 6 down): up from 70 to 162 yd at 50 to 59
// degrees, then 24 yd down at 58 degrees into the city. The walking maps from Leffe's navigation maps go round them.
#[test]
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

// A walk between two world points (z where given) is found, both ways, and each ends within 10 yd of its goal and,
// for a goal with a height, within 5 yd of it: the walking maps join the two places.
fn joined_both_ways(a: Pt, b: Pt, profile: Option<&str>, what: &str) {
	for (from, to) in [(a, b), (b, a)] {
		let got = walk(from, to, profile);
		assert!(truthy(&got), "{what}: the engine finds a walk from {:.1},{:.1} to {:.1},{:.1}", from.x, from.y, to.x, to.y);
		let pts = points(&got);
		let last = pts[pts.len() - 1];
		let gap = (last.0 - to.x).hypot(last.1 - to.y);
		assert!(gap < 10.0, "{what}: the walk to {:.1},{:.1} ends {gap:.1} yd from it", to.x, to.y);
		if let (Some(z), Some(lz)) = (to.z, last.2) {
			assert!((lz - z).abs() < 5.0, "{what}: the walk to {:.1},{:.1} ends at height {lz:.1}, the goal's is {z:.1}", to.x, to.y);
		}
	}
}

// #1875 (Megabite), Loch Modan, "Filthy Paws": the arrow pointed at the Miners' League crates over the hill above the
// Silver Stream Mine. The walking maps joined the mine to the world nowhere: no walk from Mountaineer Stormpike to the
// crates inside, at their height or without one. Our grid's way in through the mine's mouth is a grid join now.
#[test]
fn loch_modan_the_walk_from_mountaineer_stormpike_into_the_silver_stream_mine_is_found_both_ways_1875() {
	let stormpike = Pt { c: 0, x: -4826.0, y: -2676.7, z: Some(341.2) };
	let crates = Pt { c: 0, x: -4943.2, y: -2993.9, z: Some(319.9) };
	joined_both_ways(stormpike, crates, Some("Alliance"), "Silver Stream Mine");
}

// The Jasperlode Mine (Elwynn Forest): its deeper tunnels, where Westfall's and Elwynn's kobolds stand, were walked
// 600 yd round from the mouth on the walking maps, where the way in is 161 yd. A grid join takes the short way.
#[test]
fn elwynn_the_walk_from_the_jasperlode_mines_mouth_to_its_deep_tunnels_is_no_detour() {
	let mouth = Pt { c: 0, x: -9154.7, y: -564.4, z: None };
	let deep = Pt { c: 0, x: -9078.9, y: -582.3, z: Some(62.2) };
	joined_both_ways(mouth, deep, Some("Alliance"), "Jasperlode Mine");
	let got = walk(mouth, deep, Some("Alliance"));
	let yards = yards_of(&points(&got));
	assert!(yards < 300.0, "the walk in is {yards:.0} yd (our grid's way: 161)");
}

// #1766: four pairs of places players walk between that the walking maps could not join. Felwood's road between
// Bloodvenom Post's and Talonbranch Glade's flight masters, Shadowprey Village's inn and flight master, and Brill's
// inn and the Orgrimmar zeppelin's platform at the top of the Undercity's tower are grid joins now (the Rohashi Spires
// pair is one neither map walks).
#[test]
fn felwood_the_walk_between_bloodvenom_post_and_talonbranch_glade_flight_masters_is_found_both_ways_1766() {
	joined_both_ways(Pt { c: 1, x: 5068.3, y: -337.5, z: None }, Pt { c: 1, x: 6206.0, y: -1949.8, z: None }, Some("Horde"), "Felwood's road");
}

#[test]
fn desolace_the_walk_between_shadowprey_villages_inn_and_flight_master_is_found_both_ways_1766() {
	joined_both_ways(Pt { c: 1, x: -1592.8, y: 3150.3, z: None }, Pt { c: 1, x: -1767.6, y: 3264.0, z: None }, Some("Horde"), "Shadowprey Village");
}

// #1969 (Yeeshak), Desolace, Horde: in Shadowprey Village the route was one straight line over the mountains, with
// any route setting; a report from inside the inn showed the same. The inn's floor was joined to the rest of Desolace
// nowhere, so every walk from it failed (to the middle of Desolace too); with the village's grid join it is found.
#[test]
fn desolace_the_walk_from_shadowprey_villages_inn_to_the_middle_of_desolace_is_found_1969() {
	let inn = Pt { c: 1, x: -1592.8, y: 3150.3, z: None }; // 24.09,68.21
	let middle = Pt { c: 1, x: -1196.8, y: 1985.4, z: None }; // 50,55
	let got = walk(inn, middle, Some("Horde"));
	assert!(truthy(&got), "the engine finds a walk from Shadowprey Village's inn to Desolace 50,55");
	let pts = points(&got);
	let last = pts[pts.len() - 1];
	let gap = (last.0 - middle.x).hypot(last.1 - middle.y);
	assert!(gap < 10.0, "the walk ends {gap:.1} yd from Desolace 50,55");
}

#[test]
fn tirisfal_the_walk_from_brills_inn_to_the_orgrimmar_zeppelins_platform_is_found_both_ways_1766() {
	joined_both_ways(Pt { c: 0, x: 2269.5, y: 244.4, z: None }, Pt { c: 0, x: 2064.0, y: 288.6, z: Some(98.3) }, Some("Horde"), "Brill's zeppelin tower");
}

// #1919 (Jaesais), Moonglade: the Stormrage Barrow Dens were joined to the world nowhere on the walking maps, so the
// arrow pointed through the den's wall at the next goal outside. Our grid's way down the ramp and the tunnel to the
// Relic of the Fang is a grid join now (and the den's approach chains lead the planner out, nav-e2e t_1919).
#[test]
fn moonglade_the_walk_from_the_stormrage_barrow_dens_mouth_to_the_relic_of_the_fang_is_found_both_ways_1919() {
	let mouth = Pt { c: 1, x: 7540.2, y: -3024.8, z: Some(464.0) };
	let fang = Pt { c: 1, x: 7475.5, y: -3052.5, z: Some(429.0) };
	joined_both_ways(mouth, fang, Some("Alliance"), "Stormrage Barrow Dens");
}

// #1936, Thousand Needles, Horde (Arnak Grimtotem, 0.3.7): from Freewind Post the arrow took the lift down, walked
// the canyon to the Great Lift, rode it up and came round by the Barrens' rim to Darkcloud Pinnacle (2,580 yd from
// beside the lift's top). Players ride the lift down, walk the canyon, go up the ramp below Darkcloud Pinnacle and
// over its rope bridges; the walking maps lacked the bridges. The ramp-and-bridges way is a grid join now: about
// 1,830 yd, and never up on the rim north of the mesas.
#[test]
fn thousand_needles_the_walk_from_freewind_post_to_arnak_grimtotem_goes_over_darkcloud_pinnacles_bridges_1936() {
	let freewind = Pt { c: 1, x: -5365.3, y: -2483.7, z: Some(89.0) }; // beside the lift's top, 46.60,47.68
	let arnak = Pt { c: 1, x: -4755.7, y: -2109.7, z: Some(83.3) };
	let got = walk(freewind, arnak, Some("Horde"));
	assert!(truthy(&got), "the engine finds a walk from Freewind Post to Arnak Grimtotem");
	let pts = points(&got);
	let yards = yards_of(&pts);
	assert!(yards < 2100.0, "the walk is {yards:.0} yd (by the ramp and the bridges: about 1,830; round by the Great Lift: 2,580)");
	let north = pts.iter().map(|p| p.0).fold(f64::NEG_INFINITY, f64::max);
	assert!(north < -4700.0, "the walk goes {north:.0} yd north, up on the Barrens' rim (Arnak stands at -4756)");
}

// #1945 (dloyd), Duskwood, Alliance: bound for Zzarc' Vul (the Ogre's Monocle, below ground in the Vul'Gol Ogre
// Mound) the arrow led straight over the hill above the cave. The goal has the cave floor's height now (Zzarc' Vul's
// spawn, tests/guides-caves.test.js), and with it the walk from where the player stood (35.37,77.94) goes in by the
// entrance the player marked (34.08,76.91) and ends on the cave's floor.
#[test]
fn duskwood_the_walk_to_zzarc_vul_goes_in_by_the_vulgol_ogre_mounds_entrance_1945() {
	let player = Pt { c: 0, x: -11119.6, y: -121.7, z: Some(48.0) }; // 35.37,77.94, on the hill over the cave
	let monocle = Pt { c: 0, x: -11156.7, y: -192.7, z: Some(13.7) }; // the Ogre's Monocle's goal, 38.0,80.0
	let entrance = Pt { c: 0, x: -11101.0, y: -86.8, z: None };
	joined_both_ways(player, monocle, Some("Alliance"), "Vul'Gol Ogre Mound");
	let pts = points(&walk(player, monocle, Some("Alliance")));
	let off = off_path(&pts, entrance);
	assert!(off < 15.0, "the walk passes {off:.0} yd from the mound's entrance");
	let yards = yards_of(&pts);
	assert!(yards < 350.0, "the walk in is {yards:.0} yd");
}

// #2331 (Logan), Wetlands, the Water Totem's Call of Water: from the road (48.00,39.13) the arrow pointed straight at
// Hervdana Saegrund (65.80,76.50) over the mountain. Her ledge above the Dun Algaz road was joined to nothing on the
// walking maps, so every walk to her came back with no way; players walk up to her from the road to the north. A grid
// join puts that way in: the walk from the reporter's spot, and from Menethil Harbor, is found and ends at her.
#[test]
fn wetlands_the_walk_to_hervdana_saegrund_is_found_from_the_road_and_from_menethil_harbor_2331() {
	forge_addontest::needs!("map-frames.json");
	let hervdana = world(1437, 65.80, 76.50);
	for (from, what) in [(world(1437, 48.00, 39.13), "the reporter's spot"), (world(1437, 10.80, 59.60), "Menethil Harbor")] {
		let got = walk(from, hervdana, Some("Alliance"));
		assert!(truthy(&got), "the engine finds a walk from {what} to Hervdana Saegrund");
		let pts = points(&got);
		let last = pts[pts.len() - 1];
		let gap = (last.0 - hervdana.x).hypot(last.1 - hervdana.y);
		assert!(gap < 10.0, "the walk from {what} ends {gap:.1} yd from her");
	}
	joined_both_ways(world(1437, 64.50, 74.90), hervdana, Some("Alliance"), "Hervdana Saegrund's ledge");
}

// #2316 (Fenn), Desolace, Horde: walking up to Gurda Wildmane at Ghost Walker Post from the road to the east, the arrow
// led straight up the post's east face, which can't be climbed. Players' recordings come down that face and go up by
// the slope on the north side. The face is a cut on the walking maps now (up across it is closed, down stays): the walk
// from the road (60.0,60.5) to Gurda (56.29,59.68) goes round by the north side, and crosses the face's line (Desolace
// 57.3 from 57.6 to 60.3) nowhere.
#[test]
fn desolace_the_walk_from_the_road_to_gurda_wildmane_goes_up_the_north_slope_not_the_east_face_2316() {
	forge_addontest::needs!("map-frames.json");
	let road = world(1443, 60.0, 60.5);
	let gurda = world(1443, 56.29, 59.68);
	let (north, south) = (world(1443, 57.3, 57.6), world(1443, 57.3, 60.3));
	let got = walk(road, gurda, Some("Horde"));
	assert!(truthy(&got), "the engine finds a walk from the road to Gurda Wildmane");
	let pts = points(&got);
	for w in pts.windows(2) {
		let (a, b) = (w[0], w[1]);
		if (a.1 - north.y) * (b.1 - north.y) <= 0.0 && a.1 != b.1 {
			let t = (north.y - a.1) / (b.1 - a.1);
			let x = a.0 + (b.0 - a.0) * t;
			assert!(x > north.x || x < south.x, "the walk crosses the east face's line at {x:.1} (the face runs {:.1} to {:.1})", north.x, south.x);
		}
	}
}

// The city sweep (0.4.1, #2028): every guide goal in the capitals walked from its city's flight master. Three NPCs
// whose spawn height stands a few yards beside or under the surfaces of their own cell (a bar, a counter, a balcony's
// steps) were walked to nowhere at their height, and without it over the city's roof: Gwenna Firebrew, the Stonefire
// Tavern's innkeeper (Ironforge 18.64,51.76, 502), Nissa Firestone (the Great Forge, 55.09,58.26, 512.5) and Connor
// Rivers (Stormwind's Mage Quarter, 105.2). The router settles such a goal on the surface nearest its height a few
// cells away that walks to the city, so the walk to them is found at the NPC's height (Gwenna's and Connor's both
// ways; a walk from Nissa's spot still settles on the ledge beside her, as starts do).
#[test]
fn ironforge_and_stormwind_npcs_beside_their_cells_surfaces_are_walked_to_at_their_height() {
	let ironforge_fm = Pt { c: 0, x: -4821.1, y: -1152.4, z: Some(502.3) };
	joined_both_ways(ironforge_fm, Pt { c: 0, x: -4842.3, y: -861.0, z: Some(502.0) }, Some("Alliance"), "Gwenna Firebrew");
	let nissa = Pt { c: 0, x: -4876.6, y: -1149.2, z: Some(512.5) };
	let got = walk(ironforge_fm, nissa, Some("Alliance"));
	assert!(truthy(&got), "the engine finds a walk from Ironforge's flight master to Nissa Firestone");
	let pts = points(&got);
	let last = pts[pts.len() - 1];
	assert!(last.2.is_some_and(|z| (z - 512.5).abs() < 5.0) && (last.0 - nissa.x).hypot(last.1 - nissa.y) < 10.0, "the walk ends at Nissa Firestone");
	joined_both_ways(Pt { c: 0, x: -8835.8, y: 490.1, z: Some(109.7) }, Pt { c: 0, x: -9102.3, y: 834.7, z: Some(105.2) }, Some("Alliance"), "Connor Rivers");
}

// The city sweep's NPCs whose floor neither map joined to the city (0.4.1, #2028): grid joins from the flight master.
// Ilsa Corbin, Stormwind's warriors' trainer in Old Town (109.5), Thatog in Orgrimmar's Valley of Strength (36.7) and
// Jes'rimon on the Drag (54.8) are walked to at their height and back; Thom Filch, under Ironforge (399.1, the
// Forever server's spawn), is walked to (our grid's way down to him has a drop it can't climb back, so the way out
// is left for the in-game check).
#[test]
fn stormwind_orgrimmar_and_ironforge_npcs_on_floors_joined_from_the_flight_master_are_walked_to_at_their_height_2028() {
	let stormwind_fm = Pt { c: 0, x: -8835.8, y: 490.1, z: Some(109.7) };
	let orgrimmar_fm = Pt { c: 1, x: 1676.3, y: -4313.4, z: Some(61.7) };
	joined_both_ways(stormwind_fm, Pt { c: 0, x: -8688.6, y: 325.8, z: Some(109.5) }, Some("Alliance"), "Ilsa Corbin");
	joined_both_ways(orgrimmar_fm, Pt { c: 1, x: 1598.6, y: -4460.2, z: Some(36.7) }, Some("Horde"), "Thatog");
	joined_both_ways(orgrimmar_fm, Pt { c: 1, x: 1955.1, y: -4459.4, z: Some(54.8) }, Some("Horde"), "Jes'rimon");
	let thom = Pt { c: 0, x: -4803.7, y: -968.2, z: Some(399.1) };
	let got = walk(Pt { c: 0, x: -4821.1, y: -1152.4, z: Some(502.3) }, thom, Some("Alliance"));
	assert!(truthy(&got), "the engine finds a walk from Ironforge's flight master to Thom Filch");
	let pts = points(&got);
	let last = pts[pts.len() - 1];
	assert!(last.2.is_some_and(|z| (z - 399.1).abs() < 5.0), "the walk to Thom Filch ends at his height, not {:?}", last.2);
}

const FIND_AND_MANY: &str = r#"
local Path = Polestar_NavEngine
local _, cost = Path.FindSync(@C, @FROM, @TO, { profile = "Alliance" })
local costs = Path.FindManySync(@C, @FROM, { @TO }, { profile = "Alliance" })
emit({ find = cost or false, many = costs and costs[1] or false })"#;

// #2723 (undersailor, read in the code): the abstract A* measured its heuristic to the goal's snapped cell, but the
// goal's nodes may lie a cell off it (the surfaces of a point without a height) and settle up to SNAP cells further, so
// it could overstate the way left and settle on a dearer walk. In the Eastern Kingdoms, from 2894.9,-2879 to
// 2679.7,-5343.9 (no heights, the Alliance profile; a pair of nav eval's broad sample) Find's walk cost 2765.94 where
// the cheapest is 2765.21. FindMany's abstract search is a Dijkstra (no heuristic): Find's cost is no dearer than its.
#[test]
fn the_abstract_search_never_settles_on_a_dearer_walk_than_the_cheapest_2723() {
	let (from, to) = (Pt { c: 0, x: 2894.9, y: -2879.0, z: None }, Pt { c: 0, x: 2679.7, y: -5343.9, z: None });
	let pt = |p: Pt| format!("{{ x = {}, y = {} }}", p.x, p.y);
	let script = FIND_AND_MANY.replace("@C", &from.c.to_string()).replace("@FROM", &pt(from)).replace("@TO", &pt(to));
	let got = emitted(&RunAddon { stubs: vec!["stub_encoding.lua"], addons: vec![Addon::name("Polestar_Nav")], script, ..Default::default() }).into_iter().next().unwrap_or(Value::Null);
	let (find, many) = (got["find"].as_f64().expect("Find finds a walk"), got["many"].as_f64().expect("FindMany finds one"));
	assert!(find <= many + 0.01, "Find's walk costs {find:.3}, the cheapest {many:.3}");
}

// #1986 (xstevan), Orgrimmar: from the wind rider tower the arrow walked down the ramp round the tower, where players
// drop off the platform's south edge into the Valley of Strength (29 yd: it hurts, it doesn't kill; 121 recorded
// players do). A drop join puts that fall in, one way: the walk from the flight master Doras (61.7) to Kaja's shop on
// the Drag (21.7) goes off the edge (47.50, 65.47) and is about the players' 126 yd, not the ramp's 195.
#[test]
fn orgrimmar_the_walk_down_from_the_wind_rider_tower_drops_off_its_edge_as_players_do_1986() {
	let doras = Pt { c: 1, x: 1676.3, y: -4313.4, z: Some(61.7) };
	let kaja = Pt { c: 1, x: 1692.7, y: -4412.0, z: Some(21.7) };
	let got = walk(doras, kaja, Some("Horde"));
	assert!(truthy(&got), "the engine finds a walk from Doras to Kaja");
	let pts = points(&got);
	let edge = Pt { c: 1, x: 1661.5, y: -4346.9, z: None };
	let off = off_path(&pts, edge);
	assert!(off < 6.0, "the walk passes {off:.0} yd from the tower's edge");
	let yards = yards_of(&pts);
	assert!(yards < 160.0, "the walk down is {yards:.0} yd");
}

// #2860, Ironforge: from the reporter's spot (31.78, 66.47, on the floor at 501) to Daryl Riknussun, the cooking
// trainer, at the goal's point (60.25, 36.79) and his height (509.5), the walk found no way: that part of his platform
// was joined to nothing in the walking maps, and the walk asked again without his height went out of the gate and over
// the mountain (3,515 yd). Players walk onto the platform from the Great Forge's floor (27 recorded players by its
// steps, 32 beside them): step joins put that in. The walk is found at his height, ends on his platform, and is about
// the players' 356 yd.
#[test]
fn ironforge_the_walk_onto_daryl_riknussuns_platform_is_found_at_his_height_2860() {
	let reporter = Pt { c: 0, x: -4919.9, y: -964.9, z: Some(501.0) };
	let daryl = Pt { c: 0, x: -4763.3, y: -1189.9, z: Some(509.5) };
	let got = walk(reporter, daryl, Some("Alliance"));
	assert!(truthy(&got), "the engine finds a walk to Daryl Riknussun at his height");
	let pts = points(&got);
	let last = pts[pts.len() - 1];
	assert!(last.2.is_some_and(|z| (z - 509.5).abs() < 5.0) && (last.0 - daryl.x).hypot(last.1 - daryl.y) < 10.0, "the walk ends on his platform: {last:?}");
	let yards = yards_of(&pts);
	assert!(yards < 450.0, "the walk is {yards:.0} yd");
	joined_both_ways(Pt { c: 0, x: -4790.6, y: -1167.7, z: Some(502.2) }, daryl, Some("Alliance"), "Daryl Riknussun's platform");
}

// Ironforge (33.92, 49.31): the spot where players talk to Afadra Dunwall was joined to
// nothing in the walking maps (no walk to or from it at its floor, 501.9); 32 recorded players step across the gap
// beside it, and a step join puts that in. The walk to Thurgrum Deepforge on the Great Forge's floor (498.9) and back
// is found.
#[test]
fn ironforge_afadra_dunwalls_spot_is_joined_to_the_city_by_the_step_players_take() {
	let afadra = Pt { c: 0, x: -4822.4, y: -980.7, z: Some(501.9) };
	let thurgrum = Pt { c: 0, x: -4795.0, y: -1122.6, z: Some(498.9) };
	joined_both_ways(afadra, thurgrum, Some("Alliance"), "Afadra Dunwall's spot");
}

// Ironforge, the Great Forge (55.08, 58.26): Nissa Firestone, the first aid trainer, stands at 512.5 on a floor the
// walking maps joined to nothing, so the reach rule would drop it and a walk from her height found no way (to Fimble
// Finespindle, 40.15, 33.21). 16 recorded players step onto it from the Forge's floor beside her (55.46, 59.93); the
// step join for that keeps her floor and the walk goes down off it round the Forge (about 235 yd).
#[test]
fn ironforge_a_walk_from_nissa_firestone_at_her_height_steps_off_her_floor_onto_the_forges() {
	let nissa = Pt { c: 0, x: -4876.6, y: -1149.1, z: Some(512.5) };
	let fimble = Pt { c: 0, x: -4744.5, y: -1031.0, z: Some(504.5) };
	let got = walk(nissa, fimble, Some("Alliance"));
	assert!(truthy(&got), "the engine finds a walk from Nissa Firestone at her height");
	let yards = yards_of(&points(&got));
	assert!(yards < 300.0, "the walk is {yards:.0} yd");
}

// Undercity, the Rogues' Quarter: the arched bridge over the canal (72.5, 63.4 to 76.4, 67.3) was cut at its crest in
// the walking maps into two decks that meet only down at the canal, so the walk from the ring below the bat handler to
// Mennet Carkad went round the district (487 yd; the recorded players' walk is 292). A strict join puts the crest in:
// the walk crosses the bridge and is about the grid's 317 yd.
#[test]
fn undercity_the_walk_to_the_rogues_quarter_crosses_the_canal_bridge() {
	let ring = Pt { c: 0, x: 1568.6, y: 267.9, z: Some(-59.65) };
	let mennet = Pt { c: 0, x: 1436.1, y: 74.0, z: Some(-62.3) };
	let got = walk(ring, mennet, Some("Horde"));
	assert!(truthy(&got), "the engine finds a walk to Mennet Carkad");
	let pts = points(&got);
	let crest = Pt { c: 0, x: 1457.4, y: 161.3, z: None };
	let off = off_path(&pts, crest);
	assert!(off < 6.0, "the walk passes {off:.0} yd from the bridge's crest");
	let yards = yards_of(&pts);
	assert!(yards < 360.0, "the walk is {yards:.0} yd");
}

// Darnassus: where a recorded player stood at Yldan (65.5, 52.8, height 1339.6) the walking maps had no walk out at
// all ("unreachable"), so a walk from him to the trainer Eladriel failed; our grid walks down from his floor in 43 yd.
// A join puts that in: the walk from his floor to the innkeeper Saelienne and back is found.
#[test]
fn darnassus_yldans_floor_is_joined_to_the_city() {
	let yldan = Pt { c: 1, x: 9865.4, y: 2245.05, z: Some(1339.6) };
	let saelienne = Pt { c: 1, x: 10127.9, y: 2224.79, z: Some(1328.8) };
	joined_both_ways(yldan, saelienne, Some("Alliance"), "Yldan's floor");
}

// Thunder Bluff, the wind rider tower: players leave Tal's platform (177 yd up) by hopping down its south ledges and
// dropping 26 yd to the mesa (52 of the 53 recorded players who pass the lower ledge); the walking maps took the ramp
// round the tower, 197 yd to Innkeeper Pala for the players' 113. Drop joins put the falls in: the walk goes off the
// south ledge and is under 150 yd.
#[test]
fn thunder_bluff_from_tal_the_walk_drops_off_the_wind_rider_towers_south_ledges_as_players_do() {
	let tal = Pt { c: 1, x: -1196.75, y: 26.08, z: Some(177.03) };
	let pala = Pt { c: 1, x: -1300.28, y: 38.49, z: Some(129.29) };
	let got = walk(tal, pala, Some("Horde"));
	assert!(truthy(&got), "the engine finds a walk from Tal to Innkeeper Pala");
	let pts = points(&got);
	let ledge = Pt { c: 1, x: -1217.7, y: 32.3, z: None };
	let off = off_path(&pts, ledge);
	assert!(off < 6.0, "the walk passes {off:.0} yd from the lower south ledge");
	let yards = yards_of(&pts);
	assert!(yards < 150.0, "the walk down is {yards:.0} yd");
}

// Stormwind, the Park (34.69, 63.26): from the path at 93 down to the lawn at 90, 2 yd away, the walking maps went
// round (75 yd); 20 recorded players walk straight down there. A join puts that in.
#[test]
fn stormwind_the_park_the_walk_down_from_the_path_to_the_lawn_goes_straight_down_as_players_do() {
	let path = Pt { c: 0, x: -8728.9, y: 1119.2, z: Some(93.0) };
	let lawn = Pt { c: 0, x: -8728.4, y: 1121.1, z: Some(90.0) };
	let got = walk(path, lawn, Some("Alliance"));
	assert!(truthy(&got), "the engine finds the walk down");
	let yards = yards_of(&points(&got));
	assert!(yards < 20.0, "the walk down is {yards:.0} yd");
}
