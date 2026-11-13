//! Objective areas from players' recorded spots (#1963): a goal bound to a quest objective takes its place from
//! the trusted spots `forge record learn` found the objective done at (data/recorded/quests.json), at their
//! centre and size: Trouble in the Valley's orders within 47 yd of one point, not 100 yd around every spawn of
//! Corporal Adamore; a camp inside a wider recorded spot stays (it is finer); a goal whose spawns lie far from
//! where players do it moves there, unless the data also knows the place players use (they did it elsewhere on
//! their way). Without a trusted spot (a gap, too few players, lines that don't match the data's) the spawn
//! areas stay.

use forge_guide::data::{load_data, Data};
use forge_guide::diag::Diagnostics;
use forge_guide::js::{parse_json, V};
use forge_guide::project::{resolve_sources, Source};
use rustc_hash::FxHashMap;

use crate::common::{scratch, write_tree};

const BARRENS: &str = r#""1413":{"c":1,"left":2622.917,"right":-7510.417,"top":1612.5,"bottom":-5143.75}"#;
const MULGORE_ERA: &str = r#""1412":{"c":1,"left":2047.917,"right":-3089.583,"top":-272.917,"bottom":-3697.917}"#;
const MULGORE_FOREVER: &str = r#""1412":{"c":1,"left":2479.167,"right":-3675,"top":266.666,"bottom":-3835.416}"#;

/// The Barrens with Trouble in the Valley (95621: Benedict's Orders from Corporal Adamore's seven spawns about
/// one camp), a quest whose drops spawn far from where players get them (92553: the Hatchling's mobs at
/// 60,60), and Mulgore (both frames) with Galak centaurs away from where players kill them (99080) and Galak
/// outrunners in one small camp (99081).
fn data() -> Data {
	let mut t: FxHashMap<String, String> = FxHashMap::default();
	t.insert("zones".into(), r#"{"1413":{"id":1413,"name":"The Barrens","areaId":17,"type":3},"1412":{"id":1412,"name":"Mulgore","areaId":215,"type":3}}"#.into());
	t.insert("map-frames".into(), format!(r#"{{"era":{{{BARRENS},{MULGORE_ERA}}},"forever":{{{BARRENS},{MULGORE_FOREVER}}}}}"#));
	t.insert(
		"quests".into(),
		r#"{"95621":{"id":95621,"title":"Trouble in the Valley","level":18,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[{"type":"item","id":270151,"count":1}]},
		"92553":{"id":92553,"title":"Far Drops","level":18,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[{"type":"item","id":6889,"count":5}]},
		"95700":{"id":95700,"title":"The Lone Crate","level":18,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[{"type":"object","id":500,"count":1}]},
		"95701":{"id":95701,"title":"Eggs","level":18,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[{"type":"item","id":7777,"count":3}]},
		"95702":{"id":95702,"title":"Totems","level":18,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[{"type":"item","id":9999,"count":5}]},
		"95704":{"id":95704,"title":"Supplies","level":18,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[{"type":"object","id":600,"count":1}]},
		"95703":{"id":95703,"title":"The Wanderer","level":18,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[{"type":"kill","id":9001,"count":1}]},
		"99080":{"id":99080,"title":"Galak","level":8,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[{"type":"kill","id":2967,"count":6}]},
		"99081":{"id":99081,"title":"Outrunners","level":8,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[{"type":"kill","id":2968,"count":4}]}}"#
			.into(),
	);
	t.insert(
		"npcs".into(),
		r#"{"262119":{"id":262119,"name":"Corporal Adamore","level":18,"spawns":{"1413":{"f":"e","pts":[[41.0,14.8],[42.6,14.9],[41.2,16.6],[42.5,16.4],[41.8,15.6],[40.9,15.9],[42.8,15.6]]}}},
		"7":{"id":7,"name":"Far Raptor","level":18,"spawns":{"1413":{"f":"e","pts":[[60.0,60.0],[60.3,60.2],[59.8,60.3]]}}},
		"8001":{"id":8001,"name":"Maraudine Centaur","level":18,"spawns":{"1413":{"f":"e","pts":[[30.0,60.0],[30.2,60.3],[29.9,60.2]]}}},
		"8002":{"id":8002,"name":"Kolkar Centaur","level":18,"spawns":{"1413":{"f":"e","pts":[[70.0,40.0],[70.2,40.1],[69.9,40.3]]}}},
		"9001":{"id":9001,"name":"Wandering Courier","level":18,"spawns":{"1413":{"f":"e","pts":[[40.0,30.0]]}}},
		"2967":{"id":2967,"name":"Galak Centaur","level":8,"spawns":{"1412":{"f":"e","pts":[[66.0,62.0],[66.3,62.2],[65.8,62.3]]}}},
		"2968":{"id":2968,"name":"Galak Outrunner","level":8,"spawns":{"1412":{"f":"e","pts":[[63.5,58.5],[63.9,58.2],[63.3,58.0]]}}}}"#
			.into(),
	);
	t.insert("objects".into(), r#"{"500":{"id":500,"name":"Lone Crate","spawns":{"1413":{"f":"e","pts":[[50.0,50.0]]}}},"600":{"id":600,"name":"Supply Crate","spawns":{"1413":{"f":"e","pts":[[20.0,20.0],[22.0,20.0],[20.0,23.0]]}}}}"#.into());
	t.insert(
		"items".into(),
		r#"{"270151":{"id":270151,"name":"Benedict's Orders","drops":{"npc":{"262119":null},"object":{}},"questItem":true},
		"6889":{"id":6889,"name":"Raptor Egg","drops":{"npc":{"7":null},"object":{}},"questItem":true},
		"7777":{"id":7777,"name":"Small Egg","drops":{"npc":{},"object":{}},"questItem":true},
		"9999":{"id":9999,"name":"Centaur Totem","drops":{"npc":{"8001":null,"8002":null},"object":{}},"questItem":true}}"#
			.into(),
	);
	t.insert("meta".into(), "{}".into());
	Data::from_texts(&t, V::Null, V::Null, None).unwrap()
}

/// A recorded line of one objective: `spots` as [x, y, r, counted] on `map`.
fn line(quest: u32, map: u32, list: &str, status: &str, spots: &[(f64, f64, f64, u32)]) -> String {
	let value: Vec<String> = spots.iter().map(|(x, y, r, c)| format!(r#"{{"map":{map},"x":{x},"y":{y},"r":{r},"voters":{},"counted":{c}}}"#, c + 2)).collect();
	let counted: u32 = spots.iter().map(|s| s.3).sum();
	format!(
		r#""{quest}":{{"zone":{map},"list":[{list}],"objectives":[{{"line":1,"type":{list},"count":1,"at":{{"value":[{}],"voters":{},"counted":{counted},"status":"{status}","builds":[70790,70888],"beats":null}}}}]}}"#,
		value.join(","),
		counted + 2
	)
}

fn recorded(d: &mut Data, lines: &[String]) {
	d.recorded = parse_json(&format!("{{{}}}", lines.join(","))).unwrap();
}

/// The compiled goals of `body` (step lines) in a Horde guide of `zone`, and the warnings.
fn compiled(d: &Data, zone: &str, body: &[&str]) -> (Vec<V>, Vec<String>) {
	let text = format!("guide forever/t\ntitle T\nfaction Horde\nlevels 10-20\nzone {zone}\n\nstep A\n{}\n", body.iter().map(|l| format!("  {l}")).collect::<Vec<_>>().join("\n"));
	let src = Source { source: "t.guide".into(), file: "t.guide".into(), text };
	let mut diag = Diagnostics::new();
	let g = &resolve_sources(&[src], d, &mut diag, Some("guides"), None)[0];
	let goals = g.get("steps").items()[0].get("goals").items().into_iter().filter(|x| x.get("quest").truthy()).collect();
	(goals, diag.warnings().iter().map(|w| w.message.clone()).collect())
}

fn spot(s: &V) -> (f64, f64, f64, bool) {
	(s.get("x").num(), s.get("y").num(), s.get("r").num(), s.get("alt").truthy())
}

fn trouble(d: &Data) -> V {
	compiled(d, "The Barrens", &["collect 270151 quest 95621.1 @41.8,15.6"]).0.remove(0)
}

#[test]
fn trouble_in_the_valley_takes_the_47_yard_spot_players_loot_the_orders_in_not_the_camp_of_every_spawn_1963() {
	let mut d = data();
	// From the spawns alone: one area about all seven of Corporal Adamore's spawns, far wider than where the
	// orders are looted.
	let before = trouble(&d).get("spots").items();
	assert!(before[0].get("r").num() >= 70.0, "{before:?}");
	recorded(&mut d, &[line(95621, 1413, r#""item""#, "trusted", &[(41.79, 15.43, 47.0, 13)])]);
	let g = trouble(&d);
	let spots = g.get("spots").items();
	assert_eq!(spot(&spots[0]), (41.79, 15.43, 47.0, false), "{spots:?}");
	// The camp's area, which holds the recorded one, is gone; nothing else is marked.
	assert_eq!(spots.len(), 1, "{spots:?}");
	// The author's point lies in it: it stays.
	assert_eq!((g.get("x").num(), g.get("y").num()), (41.8, 15.6));
	// One of Corporal Adamore's spawns lies in the area.
	assert_eq!(spots[0].get("n").num(), 1.0);
}

#[test]
fn a_goal_whose_spawns_lie_far_from_where_players_do_it_moves_to_the_recorded_spot_and_keeps_the_spawns_as_an_alternative_1963() {
	let mut d = data();
	recorded(&mut d, &[line(92553, 1413, r#""item""#, "trusted", &[(42.68, 38.08, 30.0, 6)])]);
	// Placed by the compiler from the raptors' spawns at 60,60.
	let (goals, warnings) = compiled(&d, "The Barrens", &["collect 6889 quest 92553.1"]);
	let g = &goals[0];
	assert_eq!((g.get("x").num(), g.get("y").num()), (42.68, 38.08));
	let spots = g.get("spots").items();
	assert_eq!(spot(&spots[0]), (42.68, 38.08, 30.0, false), "{spots:?}");
	assert!(spots[1..].iter().all(|s| s.get("alt").truthy() && (s.get("x").num() - 60.0).abs() < 1.0), "{spots:?}");
	assert!(warnings.iter().all(|w| !w.contains("recordings")), "{warnings:?}");
	// Placed by the author at the raptors: moved too, with a warning on the line.
	let (goals, warnings) = compiled(&d, "The Barrens", &["collect 6889 quest 92553.1 @60,60"]);
	assert_eq!((goals[0].get("x").num(), goals[0].get("y").num()), (42.68, 38.08));
	assert_eq!(spot(&goals[0].get("spots").items()[0]), (42.68, 38.08, 30.0, false));
	assert!(warnings.iter().any(|w| w.starts_with("players' recordings place quest 92553.1 ") && w.contains("6 players within 30 yd of 42.68,38.08")), "{warnings:?}");
}

#[test]
fn without_a_trusted_spot_the_spawn_areas_stay_1963() {
	let mut d = data();
	let spawns = trouble(&d);
	let same = |d: &Data| {
		let g = trouble(d);
		assert_eq!(g.get("spots").items().iter().map(spot).collect::<Vec<_>>(), spawns.get("spots").items().iter().map(spot).collect::<Vec<_>>());
		assert_eq!((g.get("x").num(), g.get("y").num()), (41.8, 15.6));
	};
	// A gap (too few players to trust).
	recorded(&mut d, &[line(95621, 1413, r#""item""#, "gap", &[(41.79, 15.43, 47.0, 2)])]);
	same(&d);
	// A trusted line, but this spot is backed by fewer players than a spot needs (data/recorded/meta.json).
	recorded(&mut d, &[line(95621, 1413, r#""item""#, "trusted", &[(41.79, 15.43, 47.0, 2)])]);
	same(&d);
	d.spot_voters = 2.0;
	assert_eq!(spot(&trouble(&d).get("spots").items()[0]), (41.79, 15.43, 47.0, false));
	d.spot_voters = 3.0;
	// The game's objective list doesn't line up with the data's (a kill line for our item): no line is ours.
	recorded(&mut d, &[line(95621, 1413, r#""monster""#, "trusted", &[(41.79, 15.43, 47.0, 13)])]);
	same(&d);
}

#[test]
fn a_recorded_spot_far_off_at_a_place_the_data_also_knows_leaves_the_goal_where_its_step_has_it_1963() {
	let mut d = data();
	let step = ["collect 9999 quest 95702.1 @30,60"];
	let before = compiled(&d, "The Barrens", &step).0.remove(0);
	// Players on another route took the totems from the Kolkar, whom the data knows to drop them too: the step's
	// Maraudine are another place to do it, not a wrong one.
	recorded(&mut d, &[line(95702, 1413, r#""item""#, "trusted", &[(70.05, 40.1, 40.0, 5)])]);
	let (goals, warnings) = compiled(&d, "The Barrens", &step);
	assert_eq!(goals[0].get("spots").items().iter().map(spot).collect::<Vec<_>>(), before.get("spots").items().iter().map(spot).collect::<Vec<_>>());
	assert_eq!((goals[0].get("x").num(), goals[0].get("y").num()), (30.0, 60.0));
	assert!(warnings.iter().all(|w| !w.contains("recordings")), "{warnings:?}");
}

#[test]
fn a_goal_at_one_place_keeps_its_point_while_a_recorded_spot_holds_it_1963() {
	let mut d = data();
	recorded(&mut d, &[line(95700, 1413, r#""object""#, "trusted", &[(50.02, 50.01, 3.0, 9)])]);
	let (goals, _) = compiled(&d, "The Barrens", &["interact 500 quest 95700.1"]);
	assert_eq!((goals[0].get("x").num(), goals[0].get("y").num()), (50.0, 50.0));
	assert!(goals[0].get("spots").is_undef(), "{:?}", goals[0].get("spots"));
	// Recorded 200 yd away, it moves there; the crate's spawn stays an alternative.
	recorded(&mut d, &[line(95700, 1413, r#""object""#, "trusted", &[(52.0, 50.0, 3.0, 9)])]);
	let (goals, _) = compiled(&d, "The Barrens", &["interact 500 quest 95700.1"]);
	assert_eq!((goals[0].get("x").num(), goals[0].get("y").num()), (52.0, 50.0));
	assert_eq!(goals[0].get("spots").items().iter().map(spot).collect::<Vec<_>>(), vec![(52.0, 50.0, 15.0, false), (50.0, 50.0, 15.0, true)]);
}

#[test]
fn a_creature_players_meet_at_several_places_gets_them_all_while_the_best_backed_is_away_from_its_spawn_1963() {
	let mut d = data();
	let step = ["kill 9001 quest 95703.1"];
	// One spawn: a point goal, no areas.
	assert!(compiled(&d, "The Barrens", &step).0[0].get("spots").is_undef());
	// Players met it at its spawn, but most of them 300 and 600 yd along its way.
	recorded(&mut d, &[line(95703, 1413, r#""monster""#, "trusted", &[(46.0, 30.0, 60.0, 9), (43.0, 30.0, 50.0, 6), (40.2, 30.1, 40.0, 4)])]);
	let g = compiled(&d, "The Barrens", &step).0.remove(0);
	// The spawn stays the point; every place players met it is searched, from the spawn on.
	assert_eq!((g.get("x").num(), g.get("y").num()), (40.0, 30.0));
	assert_eq!(g.get("spots").items().iter().map(spot).collect::<Vec<_>>(), vec![(40.2, 30.1, 40.0, false), (43.0, 30.0, 50.0, false), (46.0, 30.0, 60.0, false)]);
	assert!(g.get("spread").truthy());
	// With the best-backed spot at the spawn, the spawn is the finer place: the point alone.
	recorded(&mut d, &[line(95703, 1413, r#""monster""#, "trusted", &[(40.2, 30.1, 40.0, 9), (46.0, 30.0, 60.0, 4)])]);
	assert!(compiled(&d, "The Barrens", &step).0[0].get("spots").is_undef());
}

#[test]
fn an_author_s_point_where_the_data_places_no_source_takes_the_recorded_area_around_it_1963() {
	let mut d = data();
	recorded(&mut d, &[line(95701, 1413, r#""item""#, "trusted", &[(45.4, 45.2, 60.0, 6), (70.0, 80.0, 40.0, 4)])]);
	let (goals, warnings) = compiled(&d, "The Barrens", &["collect 7777 quest 95701.1 @45,45"]);
	// The point is no spawn of anything the data knows: the area where players find the eggs is drawn, around a
	// point that stays the author's; the eggs players found across the zone are another place, an alternative.
	assert_eq!((goals[0].get("x").num(), goals[0].get("y").num()), (45.0, 45.0));
	assert_eq!(goals[0].get("spots").items().iter().map(spot).collect::<Vec<_>>(), vec![(45.4, 45.2, 60.0, false), (70.0, 80.0, 40.0, true)]);
	assert!(warnings.iter().all(|w| !w.contains("recordings")), "{warnings:?}");
}

/// Mulgore's Forever-frame point 60.11,61.66 (where the game client records) in its Era frame (the spawns').
fn mulgore_era() -> (f64, f64) {
	let world = |(l, r, t, b): (f64, f64, f64, f64), x: f64, y: f64| (t + (b - t) * y / 100.0, l + (r - l) * x / 100.0);
	let (wx, wy) = world((2479.167, -3675.0, 266.666, -3835.416), 60.11, 61.66);
	let (l, r, t, b) = (2047.917, -3089.583, -272.917, -3697.917);
	(((wy - l) / (r - l) * 10000.0).round() / 100.0, ((wx - t) / (b - t) * 10000.0).round() / 100.0)
}

#[test]
fn a_recorded_spot_in_the_game_s_frame_lands_where_it_was_recorded_on_an_era_frame_goal_1963() {
	let mut d = data();
	recorded(&mut d, &[line(99080, 1412, r#""monster""#, "trusted", &[(60.11, 61.66, 77.0, 8)])]);
	let (goals, _) = compiled(&d, "Mulgore", &["kill 2967 quest 99080.1"]);
	let g = &goals[0];
	assert_eq!(g.get("f").as_str(), Some("e"));
	let era = mulgore_era();
	let s = g.get("spots").items();
	assert_eq!(spot(&s[0]), (era.0, era.1, 77.0, false), "{s:?}");
	// The centaurs' camp in the data lies 180 yd off: the goal moves to where players kill them, the camp stays
	// an alternative.
	assert_eq!((g.get("x").num(), g.get("y").num()), era);
	assert!(s.len() == 2 && s[1].get("alt").truthy() && s[1].get("x").num() > 65.0, "{s:?}");
}

#[test]
fn a_recorded_spot_wider_than_the_camp_inside_it_keeps_the_camp_1963() {
	let mut d = data();
	let before = compiled(&d, "Mulgore", &["kill 2968 quest 99081.1"]).0.remove(0);
	recorded(&mut d, &[line(99081, 1412, r#""monster""#, "trusted", &[(60.11, 61.66, 77.0, 8)])]);
	let g = compiled(&d, "Mulgore", &["kill 2968 quest 99081.1"]).0.remove(0);
	// The outrunners' one camp lies inside the 77 yd where players kill them: it is the finer place, kept.
	let s = g.get("spots").items();
	assert_eq!(s.len(), 1, "{s:?}");
	assert_eq!(spot(&s[0]), spot(&before.get("spots").items()[0]));
	assert!(s[0].get("r").num() < 77.0, "{s:?}");
	assert_eq!((g.get("x").num(), g.get("y").num()), (before.get("x").num(), before.get("y").num()));
}

#[test]
fn the_reference_data_reads_the_recorded_snapshot_beside_it_with_its_spot_quorum_1963() {
	let root = scratch("recorded-areas");
	let src = crate::common::data_dir();
	std::fs::create_dir_all(root.join("forever")).unwrap();
	for e in std::fs::read_dir(&src).unwrap().flatten() {
		std::fs::copy(e.path(), root.join("forever").join(e.file_name())).unwrap();
	}
	assert!(load_data(&root.join("forever")).unwrap().recorded.is_nullish());
	write_tree(
		&root,
		&[("recorded/quests.json", &format!("{{{}}}", line(95621, 1413, r#""item""#, "trusted", &[(41.79, 15.43, 47.0, 13)]))), ("recorded/meta.json", r#"{"thresholds":{"spotVoters":5}}"#)],
	);
	let d = load_data(&root.join("forever")).unwrap();
	assert_eq!(d.recorded.get("95621").get("zone").num(), 1413.0);
	assert_eq!(d.spot_voters, 5.0);
}

#[test]
fn exact_points_stay_while_the_best_backed_spot_holds_one_else_the_recorded_place_leads_and_they_are_alternatives_1963() {
	let mut d = data();
	let step = ["interact 600 quest 95704.1"];
	let before = compiled(&d, "The Barrens", &step).0.remove(0);
	let points: Vec<_> = before.get("spots").items().iter().map(spot).collect();
	assert!(points.len() == 3 && points.iter().all(|p| p.2 == 0.0), "{points:?}");
	// Players at one of the crates: the points stay.
	recorded(&mut d, &[line(95704, 1413, r#""object""#, "trusted", &[(22.0, 20.05, 5.0, 9)])]);
	let g = compiled(&d, "The Barrens", &step).0.remove(0);
	assert_eq!(g.get("spots").items().iter().map(spot).collect::<Vec<_>>(), points);
	// Players where the data has no crate: the recorded place leads, the crates are alternatives.
	recorded(&mut d, &[line(95704, 1413, r#""object""#, "trusted", &[(30.0, 30.0, 20.0, 9)])]);
	let g = compiled(&d, "The Barrens", &step).0.remove(0);
	let s = g.get("spots").items();
	assert_eq!(spot(&s[0]), (30.0, 30.0, 20.0, false), "{s:?}");
	assert!(s.len() == 4 && s[1..].iter().all(|x| x.get("alt").truthy() && x.get("r").num() == 0.0), "{s:?}");
	assert_eq!((g.get("x").num(), g.get("y").num()), (30.0, 30.0));
}
