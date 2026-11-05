//! Cases (src/cases.rs) edges cargo-mutants showed cases_parity leaves open: notThrough's danger budget,
//! ref keys camp/area/act, the live frame set, fractional maps, step filters, mode's first leg, and
//! reported.json validation.

use forge_core::{MapFrames, Projector};
use forge_judge::cases::*;
use serde_json::{json, Value};

fn case(v: Value) -> Case {
	serde_json::from_value(v).expect("case")
}
fn act(t: f64, area: i64, a: &str, quest: Option<i64>) -> Action {
	Action { t, level: 10.0, area: Some(area), act: a.into(), quest, ..Action::default() }
}
fn q(t: f64, area: i64, a: &str, quest: i64) -> Action {
	act(t, area, a, Some(quest))
}
fn chk(c: Value, acts: &[Action], w: &CaseWorld, geo: Option<&Geo>) -> Outcome {
	check_case(&case(c), acts, w, geo).expect("no throw")
}

/// Point 0 on map 5, point 1 on map 6; danger cells of 210 yd (30 s on foot, 18.75 s mounted).
fn danger_world() -> CaseWorld {
	CaseWorld::from_json(json!({ "points": [[0, 0, 0, 0, 5], [0, 0, 10, 10, 6]], "danger": [{ "cell": 210 }] }).to_string().as_bytes()).unwrap()
}

#[test]
fn not_through_budget() {
	let w = danger_world();
	let walk = |level: f64, enemy: Vec<f64>| Action { level, enemy: Some(enemy), ..act(1., 1, "walk", None) };
	let kill = |level: f64| Action { level, ..q(2., 2, "kill", 1) };
	let nt = |acts: &[Action]| chk(json!({ "id": "n", "property": "notThrough", "quests": [1], "map": 5, "levels": [5, 50] }), acts, &w, None).ok;
	assert_eq!(nt(&[walk(10., vec![5., 31.]), kill(10.)]), Some(false));
	assert_eq!(nt(&[walk(10., vec![5., 30.]), kill(10.)]), Some(true));
	// Only seconds in the case's map count; each pair is (map, seconds).
	assert_eq!(nt(&[walk(10., vec![5., 20., 6., 100.]), kill(10.)]), Some(true));
	assert_eq!(nt(&[walk(10., vec![6., 100., 5., 20.]), kill(10.)]), Some(true));
	assert_eq!(nt(&[walk(10., vec![5., 10., 5., 25.]), kill(10.)]), Some(false));
	// Mounted from level 40: the budget is 18.75 s.
	assert_eq!(nt(&[walk(45., vec![5., 20.]), kill(45.)]), Some(false));
	assert_eq!(nt(&[walk(40., vec![5., 20.]), kill(40.)]), Some(false));
	assert_eq!(nt(&[walk(39., vec![5., 20.]), kill(39.)]), Some(true));
	assert_eq!(nt(&[walk(45., vec![5., 18.]), kill(45.)]), Some(true));
	// The case's level window, inclusive.
	assert_eq!(nt(&[walk(10., vec![5., 31.]), kill(5.)]), Some(false));
	assert_eq!(nt(&[walk(10., vec![5., 31.]), kill(50.)]), Some(false));
	assert_eq!(nt(&[walk(10., vec![5., 31.]), kill(4.)]), Some(true));
	assert_eq!(nt(&[walk(10., vec![5., 31.]), kill(51.)]), Some(true));
	// Back over the quests' own work and anything in the map; another map's work ends the search.
	assert_eq!(nt(&[walk(10., vec![5., 31.]), q(1.5, 2, "accept", 1), kill(10.)]), Some(false));
	let other = |pt| Action { pt: Some(pt), ..q(1.5, 3, "kill", 9) };
	assert_eq!(nt(&[walk(10., vec![5., 31.]), other(0), kill(10.)]), Some(false));
	assert_eq!(nt(&[walk(10., vec![5., 31.]), other(1), kill(10.)]), Some(true));
	let r = chk(json!({ "id": "n", "property": "notThrough", "quests": [1], "map": 5 }), &[walk(10., vec![5., 31.]), kill(10.)], &w, None);
	assert!(r.why.contains("spends 31 s in map 5 (over one 210 yd cell, 30 s)"), "{}", r.why);
}

#[test]
fn refs_by_camp_area_and_act() {
	let w = CaseWorld::default();
	let before = |a: Value, acts: &[Action]| chk(json!({ "id": "b", "property": "before", "a": a, "b": { "quest": 2 } }), acts, &w, None).ok;
	let camp = |c, a: Action| Action { camp: Some(c), ..a };
	let acts = [camp(3, q(1., 1, "kill", 1)), q(2., 1, "accept", 2), camp(7, q(3., 1, "kill", 1))];
	assert_eq!(before(json!({ "quest": 1, "camp": 7 }), &acts), Some(false));
	assert_eq!(before(json!({ "quest": 1, "camp": 3 }), &acts), Some(true));
	let acts = [q(1., 4, "kill", 1), q(2., 1, "accept", 2), q(3., 9, "kill", 1)];
	assert_eq!(before(json!({ "quest": 1, "area": 9 }), &acts), Some(false));
	let acts = [q(1., 1, "accept", 1), q(2., 1, "accept", 2), q(3., 1, "turnin", 1)];
	assert_eq!(before(json!({ "quest": 1, "act": "turnin" }), &acts), Some(false));
	assert_eq!(before(json!({ "quest": 1, "act": "accept" }), &acts), Some(true));
	// One action matching both refs is not before itself.
	assert_eq!(chk(json!({ "id": "b", "property": "before", "a": { "quest": 1 }, "b": { "quest": 1 } }), &acts, &w, None).ok, Some(false));
}

#[test]
fn single_visit_step_filter_and_taken() {
	let w = CaseWorld::default();
	let acts = [q(1., 1, "accept", 1), q(2., 2, "kill", 9), q(3., 1, "accept", 2), q(4., 3, "turnin", 1)];
	let r = chk(json!({ "id": "s", "property": "singleVisit", "quests": [1, 2], "steps": ["accept"] }), &acts, &w, None);
	assert_eq!(r.ok, Some(false), "{}", r.why);
	assert_eq!(chk(json!({ "id": "t", "property": "taken", "quest": 5 }), &[q(1., 1, "turnin", 5)], &w, None).ok, Some(false));
}

/// Map 1 in both frame sets, the live one shifted 100 yd; point 0 at (10, 10) in the Era frame.
fn two_frame_world() -> (Projector, CaseWorld) {
	let frames = MapFrames::from_json(br#"{"era":{"1":{"c":0,"left":100,"right":-100,"top":100,"bottom":-100}},"forever":{"1":{"c":0,"left":200,"right":0,"top":200,"bottom":0}}}"#).unwrap();
	let w = json!({ "points": [[0, 0, 100.0 - 20.0, 100.0 - 20.0, 1]], "camps": [{ "pt": 0 }] });
	(Projector::new(&frames), CaseWorld::from_json(w.to_string().as_bytes()).unwrap())
}

#[test]
fn places_use_the_named_frame_set() {
	let (proj, w) = two_frame_world();
	let geo = Geo { proj: &proj };
	let acts = [Action { objective: Some(0), camp: Some(0), ..q(1., 1, "kill", 7) }];
	let camp = |near: Value| check_case(&case(json!({ "id": "c", "property": "campOf", "quest": 7, "near": near })), &acts, &w, Some(&geo));
	assert_eq!(camp(json!({ "map": 1, "x": 10, "y": 10, "yards": 5 })).unwrap().ok, Some(true));
	assert_eq!(camp(json!({ "map": 1, "x": 10, "y": 10, "yards": 5, "f": "l" })).unwrap().ok, Some(false));
	let e = camp(json!({ "map": 1.5, "x": 10, "y": 10, "yards": 5 })).unwrap_err();
	assert!(e.contains("map 1.5 has no frame"), "{e}");
}

#[test]
fn mode_legs_start_after_the_departure() {
	let (proj, w) = two_frame_world();
	let geo = Geo { proj: &proj };
	let at = |t, a: &str, pt| Action { pt: Some(pt), ..act(t, 1, a, None) };
	// Leaving point 0 by a fly that starts there does not make the next walk a flight.
	let acts = [at(1., "fly", 0), at(2., "walk", 0)];
	let r = chk(json!({ "id": "m", "property": "mode", "from": { "map": 1, "x": 10, "y": 10, "yards": 5 }, "to": { "map": 1, "x": 10, "y": 10, "yards": 5 }, "act": "fly" }), &acts, &w, Some(&geo));
	assert_eq!(r.ok, Some(false), "{}", r.why);
}

#[test]
fn parse_validates_schema_and_todo() {
	let load = |schema: Value, extra: Value| {
		let mut c = json!({ "id": "x", "title": "t", "faction": "Horde", "source": { "refs": ["test"] } });
		c.as_object_mut().unwrap().extend(extra.as_object().unwrap().clone());
		parse_cases(json!({ "schema": schema, "cases": [c] }).to_string().as_bytes(), "c.json")
	};
	assert!(load(json!(2), json!({ "property": "taken" })).unwrap_err().contains("expected { schema: 1"));
	assert_eq!(load(json!(1), json!({ "todo": "later" })).unwrap().len(), 1);
	let todo = json!("");
	assert!(load(json!(1), json!({ "todo": todo })).unwrap_err().contains("unknown property"), "{todo}");
	let e = serde_json::from_value::<Case>(json!({ "id": "x", "a": 5 })).unwrap_err().to_string();
	assert!(e.contains("an object"), "{e}");
}
