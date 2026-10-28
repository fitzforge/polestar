//! Passed by and avoidable returns on a synthetic world (cases cargo-mutants showed the parity routes
//! leave open): a passed giver's zero minLevel, and a return whose objective item comes from the busiest
//! of several other camps, named by the objective's text.

use forge_core::{Faction, MapFrames, Projector};
use forge_judge::passedby::{passed_by, spawn_points, Opts};
use forge_judge::returns::avoidable_returns;
use forge_judge::walk::{WPt, WalkGoal};
use forge_world::atlas::Atlas;
use forge_world::data::GameData;
use serde_json::json;

const MAP: u32 = 99101;

fn world() -> (GameData, Projector) {
	let quest = |id: u32, title: &str, min: f64, objectives: serde_json::Value| json!({ "id": id, "title": title, "level": 3, "minLevel": min, "start": { "npc": [1] }, "end": { "npc": [1] }, "objectives": objectives, "zone": MAP, "xp": 100 });
	let spawns = |pts: serde_json::Value| json!({ MAP.to_string(): { "f": "e", "pts": pts } });
	let d = GameData {
		quests: serde_json::from_value(json!({
			"1": quest(1, "Pelt Hunt", 2.0, json!([{ "type": "item", "id": 100, "count": 5, "text": "Shiny Pelt" }])),
			"2": quest(2, "Second Errand", 2.0, json!([])),
			"3": quest(3, "Zero Floor", 0.0, json!([])),
			"4": { "id": 4, "title": "No Reward", "level": 3, "start": { "npc": [1] }, "end": { "npc": [1] }, "zone": MAP, "xp": 0 },
		}))
		.unwrap(),
		npcs: serde_json::from_value(json!({
			"1": { "id": 1, "name": "Elder Testa", "level": 10, "faction": "AH", "spawns": spawns(json!([[20, 20]])) },
			"11": { "id": 11, "name": "Lone Fox", "level": 3, "spawns": spawns(json!([[80, 20]])) },
			"12": { "id": 12, "name": "Mangy Wolf", "level": 3, "spawns": spawns(json!([[80, 80], [80.5, 80], [80, 80.5], [80.5, 80.5]])) }
		}))
		.unwrap(),
		items: serde_json::from_value(json!({ "100": { "id": 100, "name": "Shiny Pelt", "questItem": true, "drops": { "npc": { "11": 50, "12": 50 } } } })).unwrap(),
		zones: serde_json::from_value(json!({ MAP.to_string(): { "id": MAP, "name": "Testvale", "areaId": null, "parent": null, "type": 3 } })).unwrap(),
		frames: MapFrames::from_json(format!(r#"{{"era":{{"{MAP}":{{"c":1,"left":0,"right":-10000,"top":10000,"bottom":0}}}}}}"#).as_bytes()).unwrap(),
		..GameData::default()
	};
	let proj = Projector::new(&d.frames);
	(d, proj)
}

fn at(d: &GameData, proj: &Projector, npc: u32) -> WPt {
	let (c, wx, wy, map) = spawn_points(d.npcs.get(&npc), proj, 1)[0];
	WPt { c, wx, wy, map }
}

fn goal(i: usize, t: &str, q: Option<i64>, oi: Option<i64>, w: WPt) -> WalkGoal {
	WalkGoal {
		i,
		guide: "forever/test/01-vale".into(),
		file: "01-vale.guide".into(),
		line: Some(10 + i as u32),
		step: Some(i as u32 + 1),
		t: t.into(),
		q,
		oi,
		optional: false,
		passing: false,
		map: Some(w.map),
		w: Some(w),
		npc: None,
		level: None,
		title: None,
		lvl: 3.0,
		time: i as f64,
		lvl_after: 3.0,
		time_after: i as f64,
		grind: f64::NAN,
		pos: Some(w),
		along: None,
		label: None,
		item: None,
		spots: Vec::new(),
		class: false,
	}
}

#[test]
fn passed_by_drops_a_zero_min_level() {
	let (d, proj) = world();
	let g = at(&d, &proj, 1);
	let a = WPt { wy: g.wy + 2000.0, ..g };
	let b = WPt { wy: g.wy - 2000.0, ..g };
	let goals = [goal(0, "talk", None, None, a), goal(1, "talk", None, None, b)];
	let r = passed_by(&goals, &d, &proj, &|_| true, None, None, Opts::default());
	let zero = r.list.iter().find(|p| p.q == 3).unwrap_or_else(|| panic!("{:#?}", r.list));
	assert_eq!(zero.min_level, None);
	assert_eq!(zero.status, "never done");
	let one = r.list.iter().find(|p| p.q == 1).expect("quest 1 passed");
	assert_eq!(one.min_level, Some(2.0));
}

#[test]
fn return_names_the_busiest_item_camp_by_the_objective_text() {
	let (d, proj) = world();
	let atlas = Atlas::build_for(Faction::Horde, &d, None, None);
	let (giver, wolf) = (at(&d, &proj, 1), at(&d, &proj, 12));
	let goals = [
		goal(0, "accept", Some(1), None, giver),
		goal(1, "collect", Some(1), Some(1), wolf),
		goal(2, "collect", Some(1), Some(1), giver),
		goal(3, "accept", Some(2), None, giver),
		goal(4, "turnin", Some(1), None, giver),
		goal(5, "turnin", Some(2), None, giver),
	];
	let r = avoidable_returns(&goals, &atlas, &d, &|_| true, None, 15);
	let ex = r.examples.first().unwrap_or_else(|| panic!("{}", serde_json::to_string_pretty(&r).unwrap()));
	let collect = ex.v2.goals.iter().find(|g| g.t == "collect").unwrap_or_else(|| panic!("{:#?}", ex.v2.goals));
	assert!(!collect.avoidable);
	assert!(collect.why.starts_with("Shiny Pelt comes from Mangy Wolf"), "{}", collect.why);
}

#[test]
fn return_with_nothing_avoidable_is_no_example_and_zero_xp_is_not_left_behind() {
	let (d, proj) = world();
	let atlas = Atlas::build_for(Faction::Horde, &d, None, None);
	let (giver, wolf) = (at(&d, &proj, 1), at(&d, &proj, 12));
	let goals = [goal(0, "accept", Some(1), None, giver), goal(1, "collect", Some(1), Some(1), wolf), goal(2, "collect", Some(1), Some(1), giver), goal(3, "turnin", Some(1), None, giver)];
	let r = avoidable_returns(&goals, &atlas, &d, &|_| true, None, 15);
	assert!(r.summary.returns >= 1, "{}", serde_json::to_string_pretty(&r).unwrap());
	assert!(r.examples.is_empty(), "{}", serde_json::to_string_pretty(&r.examples).unwrap());
	let left: Vec<u32> = r.left_behind.iter().map(|l| l.q).collect();
	assert!(left.contains(&3) && !left.contains(&4), "{left:?}");
}
