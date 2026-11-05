//! Cases (src/cases.rs) against the removed tools/lib/sim/cases.js (git history at 734380d2a): the
//! property semantics of its tests/sim-cases.test.js, the shipped fixture's integrity, and parity on v2 routes of the slice.
//! References: rust/tests/golden/cases (its README and regen.sh: a dump of the removed JS cases, git history at 734380d2a, on greedy v2 routes
//! in the golden slice worlds). Optional extra: the same on $POLESTAR_JSREF's dumps (its simdir) with the
//! map frames from $POLESTAR_CHECKOUT; skipped with a note when unset.

use crate::common;
use forge_core::{MapFrames, Projector};
use forge_judge::cases::*;
use serde::Deserialize;
use serde_json::{json, Value};
use std::path::{Path, PathBuf};
use std::time::Instant;

fn case(v: Value) -> Case {
	serde_json::from_value(v).expect("case")
}
fn act(t: f64, area: i64, a: &str, quest: Option<i64>) -> Action {
	Action { t, level: 5.0, area: Some(area), pt: Some(area * 10), act: a.into(), quest, ..Action::default() }
}
fn q(t: f64, area: i64, a: &str, quest: i64) -> Action {
	act(t, area, a, Some(quest))
}
fn empty_world() -> CaseWorld {
	CaseWorld::default()
}
fn chk(c: Value, acts: &[Action], w: &CaseWorld, geo: Option<&Geo>) -> Outcome {
	check_case(&case(c), acts, w, geo).expect("no throw")
}

#[test]
fn single_visit() {
	let w = empty_world();
	let acts = [q(1., 1, "accept", 817), q(2., 1, "accept", 818), q(3., 2, "kill", 999), q(4., 1, "accept", 826)];
	let r = chk(json!({"id":"c","property":"singleVisit","quests":[817,818,826]}), &acts, &w, None);
	assert_eq!(r.ok, Some(false));
	assert!(r.why.contains("826"));
	assert_eq!(chk(json!({"id":"c","property":"singleVisit","quests":[817,818]}), &acts, &w, None).ok, Some(true));
	let sv = |acts: &[Action]| chk(json!({"id":"c","property":"singleVisit","quests":[6394,794]}), acts, &w, None);
	let lp = [q(1., 1, "accept", 6394), act(2., 1, "walk", None), q(3., 2, "loot", 6394), q(4., 2, "loot", 794), q(5., 1, "turnin", 6394)];
	assert_eq!(sv(&lp).ok, Some(true));
	assert_eq!(sv(&[q(1., 2, "loot", 6394), act(2., 3, "walk", None), q(3., 2, "loot", 794)]).ok, Some(true));
	let foreign = [q(1., 1, "accept", 6394), q(2., 2, "loot", 6394), q(3., 3, "turnin", 5), q(4., 2, "loot", 794), q(5., 1, "turnin", 6394)];
	let r = sv(&foreign);
	assert_eq!(r.ok, Some(false));
	assert!(r.why.contains("794") && r.why.contains("area 3"), "{}", r.why);
	let mut acts = vec![
		q(1., 1, "accept", 581),
		q(2., 4, "kill", 9),
		q(3., 1, "accept", 189),
		q(4., 2, "kill", 581),
		q(5., 2, "loot", 189),
		q(6., 3, "turnin", 581),
		q(7., 4, "kill", 9),
		q(8., 1, "turnin", 189),
	];
	let st = |acts: &[Action], steps: Value| chk(json!({"id":"c","property":"singleVisit","quests":[581,189],"steps":steps}), acts, &w, None).ok;
	assert_eq!(st(&acts, Value::Null), Some(false));
	assert_eq!(st(&acts, json!(["objective"])), Some(true));
	assert_eq!(st(&acts, json!(["accept"])), Some(false));
	acts.insert(4, q(4.5, 4, "kill", 9));
	assert_eq!(st(&acts, json!(["objective"])), Some(false));
	let it = |quest, area, a: &str, item: Option<i64>, npc: Option<i64>| Action { item, npc, ..q(1., area, a, quest) };
	let acts = [it(99130, 5, "loot", Some(286214), None), it(9, 4, "kill", None, None), it(99130, 2, "loot", Some(286215), None), it(52, 2, "kill", None, Some(822))];
	let m = |m: Value| chk(json!({"id":"c","property":"singleVisit","quests":[99130,52],"steps":["objective"],"match":m}), &acts, &w, None).ok;
	assert_eq!(m(Value::Null), Some(false));
	assert_eq!(m(json!([{"quest":99130,"item":286215},{"quest":52,"npc":822}])), Some(true));
}

#[test]
fn parse_rejects_bad_steps_and_match() {
	let load = |extra: Value| {
		let mut c = json!({"id":"bad","title":"t","faction":"Horde","property":"singleVisit","quests":[1],"source":{"refs":["test"],"credit":[]}});
		c.as_object_mut().unwrap().extend(extra.as_object().unwrap().clone());
		parse_cases(json!({"schema":1,"cases":[c]}).to_string().as_bytes(), "c.json")
	};
	assert!(load(json!({"steps":["turn-in"]})).unwrap_err().contains("bad: steps"));
	assert!(load(json!({"match":[]})).unwrap_err().contains("bad: match"));
	assert!(load(json!({"match":[{}]})).unwrap_err().contains("bad: match"));
	assert_eq!(load(json!({"steps":["turnin","objective"],"match":[{"quest":1}]})).unwrap().len(), 1);
}

#[test]
fn order_properties_and_messages() {
	let w = empty_world();
	let lv = |a: Action, level| Action { level, ..a };
	let acts = [q(1., 1, "accept", 784), lv(q(2., 2, "accept", 837), 10.), Action { via: Some("pass".into()), ..q(3., 3, "accept", 488) }];
	assert_eq!(chk(json!({"id":"b","property":"before","a":{"quest":784,"step":"accept"},"b":{"quest":837,"step":"accept"}}), &acts, &w, None).ok, Some(true));
	assert_eq!(chk(json!({"id":"n","property":"never","quest":98299}), &acts, &w, None).ok, Some(true));
	assert_eq!(chk(json!({"id":"p","property":"onLeg","quest":488,"step":"accept"}), &acts, &w, None).ok, Some(true));
	let carry = [lv(q(1., 1, "accept", 837), 6.), lv(q(2., 2, "kill", 837), 8.)];
	assert_eq!(chk(json!({"id":"w","property":"notBefore","quest":837,"step":"objective","level":8}), &carry, &w, None).ok, Some(true));
	assert_eq!(chk(json!({"id":"w","property":"notBefore","quest":837,"step":"objective","level":9}), &carry, &w, None).ok, Some(false));
	let acts = [lv(q(1., 1, "accept", 837), 7.46), q(2., 2, "accept", 784)];
	let late = chk(json!({"id":"b","property":"before","a":{"quest":784,"step":"accept"},"b":{"quest":837,"step":"accept"}}), &acts, &w, None);
	assert_eq!(late.ok, Some(false));
	assert!(late.why.contains("accept quest 837 at t=1s, level 7.5, area 1"), "{}", late.why);
	assert!(chk(json!({"id":"n","property":"never","quest":784}), &acts, &w, None).why.contains("784 at t=2s"));
	assert_eq!(chk(json!({"id":"t","property":"taken","quest":999}), &acts, &w, None).ok, Some(false));
	let acts = [q(1., 1, "turnin", 3364), act(2., 1, "walk", None), q(3., 1, "accept", 3365), q(4., 2, "kill", 1), q(5., 1, "turnin", 218)];
	let same = |b: Value| chk(json!({"id":"s","property":"sameVisit","a":{"quest":3364,"step":"turnin"},"b":b}), &acts, &w, None).ok;
	assert_eq!(same(json!({"quest":3365,"step":"accept"})), Some(true));
	assert_eq!(same(json!({"quest":218,"step":"turnin"})), Some(false));
	assert_eq!(same(json!({"quest":9,"step":"turnin"})), Some(false));
	let acts = [q(1., 16, "accept", 837), q(2., 16, "turnin", 791), act(3., 7, "walk", None), q(4., 7, "turnin", 784)];
	let bsv = |qq: i64, p: &str| chk(json!({"id":"v","property":p,"a":{"quest":qq,"step":"turnin"},"b":{"quest":837,"step":"accept"}}), &acts, &w, None);
	assert_eq!(bsv(791, "beforeOrSameVisit"), Outcome { ok: Some(true), why: String::new() });
	assert_eq!(bsv(791, "before").ok, Some(false));
	assert!(bsv(784, "beforeOrSameVisit").why.contains("turnin quest 784 at t=4s"));
	assert_eq!(bsv(999, "beforeOrSameVisit").ok, Some(false));
	assert_eq!(chk(json!({"id":"t","property":"service","todo":"needs service"}), &[], &w, None), Outcome { ok: None, why: "todo: needs service".into() });
}

// One map, 1 % = 2 yd: world wx = 100 - 2y, wy = 100 - 2x.
fn camp_world() -> (Projector, CaseWorld) {
	let frames = MapFrames::from_json(br#"{"era":{"1":{"c":0,"left":100,"right":-100,"top":100,"bottom":-100}}}"#).unwrap();
	let pt = |x: f64, y: f64| json!([0, 0, 100. - 2. * y, 100. - 2. * x, 1]);
	let w = json!({"points":[pt(10.,10.),pt(80.,80.),pt(50.,50.),pt(52.,50.)],"camps":[{"pt":0},{"pt":1}],"inns":[{"name":"Here","pt":2}]});
	(Projector::new(&frames), CaseWorld::from_json(w.to_string().as_bytes()).unwrap())
}

#[test]
fn places_inns_hearths_modes() {
	let (proj, w) = camp_world();
	let geo = Geo { proj: &proj };
	let ob = |a: Action, o, camp| Action { objective: Some(o), camp: Some(camp), ..a };
	let acts = [ob(q(1., 1, "kill", 287), 0, 0), ob(q(2., 1, "loot", 287), 1, 1)];
	let run = |p: &str, o: Value| chk(json!({"id":"c","property":p,"quest":287,"objective":o,"near":{"map":1,"x":11,"y":10,"yards":10}}), &acts, &w, Some(&geo)).ok;
	assert_eq!(run("campOf", json!(0)), Some(true));
	assert_eq!(run("campOf", json!(1)), Some(false));
	assert_eq!(run("campOf", Value::Null), Some(false));
	assert_eq!(run("notCampOf", json!(1)), Some(true));
	assert_eq!(run("notCampOf", json!(0)), Some(false));
	let e = check_case(&case(json!({"id":"c","property":"campOf","quest":287,"objective":0,"near":{"map":1,"x":11,"y":10,"yards":10}})), &acts, &w, None).unwrap_err();
	assert!(e.contains("map frames"));
	let at = |t, a: &str, pt| Action { pt: Some(pt), ..act(t, 1, a, None) };
	let b = |acts: &[Action], c: Value| chk(c, acts, &w, None).ok;
	let bound = json!({"id":"h","property":"boundAt"});
	assert_eq!(b(&[at(1., "bind", 2), q(2., 2, "kill", 1), at(3., "hearth", 2)], bound.clone()), Some(true));
	assert_eq!(b(&[q(2., 2, "kill", 1), at(3., "hearth", 2)], bound.clone()), Some(false));
	assert_eq!(b(&[at(1., "bind", 2), at(2., "bind", 3), at(3., "hearth", 2)], bound), Some(false));
	assert_eq!(b(&[at(1., "bind", 2), at(3., "hearth", 2)], json!({"id":"h","property":"boundAt","inns":["There"]})), Some(false));
	let h = |t| act(t, 1, "hearth", None);
	let hs = json!({"id":"s","property":"hearthSpacing"});
	assert_eq!(b(&[h(100.), q(2000., 2, "kill", 1), h(3700.), h(7400.)], hs.clone()), Some(true));
	let close = [h(100.), q(2000., 2, "kill", 1), h(3699.)];
	let r = chk(hs, &close, &w, None);
	assert!(r.why.contains("comes 3599 s after the last hearth (t=100s; at least 3600 s)"), "{}", r.why);
	assert_eq!(b(&close, json!({"id":"s","property":"hearthSpacing","minSec":1800})), Some(true));
	let mode = |acts: &[Action], a: &str, without: Value| {
		chk(json!({"id":"m","property":"mode","from":{"map":1,"x":50,"y":50,"yards":5},"to":{"map":1,"x":80,"y":80,"yards":5},"act":a,"without":without}), acts, &w, Some(&geo))
	};
	let flown = [at(1., "walk", 2), at(2., "fly", 1), at(3., "turnin", 1)];
	let hearthed = [at(1., "accept", 3), at(2., "hearth", 0), at(3., "walk", 1)];
	assert_eq!(mode(&flown, "fly", json!([])).ok, Some(true));
	assert_eq!(mode(&flown, "ride", json!([])).ok, Some(false));
	let r = mode(&hearthed, "walk", json!(["hearth"]));
	assert_eq!(r.ok, Some(false));
	assert!(r.why.contains("hearth"));
	assert_eq!(mode(&[at(1., "walk", 1)], "fly", json!([])).ok, Some(true));
}

fn fixture() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../tests/fixtures/sim/cases/reported.json")
}

#[test]
fn shipped_fixture_parses_and_runs_on_an_empty_route() {
	let cases = parse_cases(&std::fs::read(fixture()).unwrap(), "reported.json").unwrap();
	assert!(cases.len() >= 60);
	for c in &cases {
		match &c.todo {
			Some(t) => assert!(t.starts_with("needs "), "{}: todo", c.id),
			None => assert!(PROPERTIES.contains(&c.property.as_deref().unwrap_or("")), "{}", c.id),
		}
		assert!(c.faction == "Alliance" || c.faction == "Horde", "{}: faction", c.id);
	}
	let (proj, _) = camp_world();
	let geo = Geo { proj: &proj };
	for c in &cases {
		check_case(c, &[], &empty_world(), Some(&geo)).unwrap_or_else(|e| panic!("{}: {e}", c.id));
	}
}

#[derive(Deserialize)]
struct Res {
	id: String,
	ok: Option<bool>,
	why: String,
	own: bool,
}
#[derive(Deserialize)]
struct Dump {
	ms: f64,
	run2: RunIndex,
	#[serde(rename = "rawActions")]
	raw_actions: Vec<RouteAction>,
	actions: Vec<Action>,
	results: Vec<Res>,
	empty: Vec<Res>,
}

/// The Rust case actions and outcomes of one dump against its JS ones.
fn compare(name: &str, d: &Dump, world: &CaseWorld, proj: &Projector, cases: &[Case]) {
	let geo = Geo { proj };
	let t0 = Instant::now();
	let acts = case_actions(&d.run2, &d.raw_actions);
	let outs: Vec<Outcome> = d.results.iter().map(|r| check_case_or_fail(cases.iter().find(|c| c.id == r.id).unwrap(), &acts, world, Some(&geo))).collect();
	let ms = t0.elapsed().as_secs_f64() * 1e3;
	assert_eq!(acts.len(), d.actions.len(), "{name}: action count");
	for (i, (a, b)) in acts.iter().zip(&d.actions).enumerate() {
		// caseActions keeps a route action's fields; enemy is only on travel the JS kept too.
		assert_eq!(a, b, "{name}: action {i}");
	}
	let mut tally = [[0usize; 3]; 2];
	for (r, o) in d.results.iter().zip(&outs) {
		assert_eq!((o.ok, o.why.as_str()), (r.ok, r.why.as_str()), "{name}: case {}", r.id);
		let k = match o.ok {
			Some(true) => 0,
			Some(false) => 1,
			None => 2,
		};
		tally[0][k] += 1;
		if r.own {
			tally[1][k] += 1;
		}
	}
	for r in &d.empty {
		let o = check_case_or_fail(cases.iter().find(|c| c.id == r.id).unwrap(), &[], world, Some(&geo));
		assert_eq!((o.ok, o.why.as_str()), (r.ok, r.why.as_str()), "{name}: empty route, case {}", r.id);
	}
	eprintln!(
		"cases parity {name}: {} actions, {} cases equal: ok/fail/null {:?}; own start {:?}; empty route {} equal; JS {:.1} ms, Rust {ms:.1} ms",
		acts.len(),
		outs.len(),
		tally[0],
		tally[1],
		d.empty.len(),
		d.ms
	);
}

const ROUTES: [(&str, &str); 2] = [("horde-orc-warrior", "horde"), ("alliance-human-warrior", "alliance")];

#[test]
fn slice_parity() {
	let cases = parse_cases(&std::fs::read(fixture()).unwrap(), "reported.json").unwrap();
	let proj = Projector::new(&MapFrames::from_json(&std::fs::read(common::data().join("map-frames.json")).unwrap()).unwrap());
	for (name, faction) in ROUTES {
		let d: Dump = serde_json::from_slice(&common::gunzip(&common::golden().join(format!("cases/cases-{name}.json.gz")))).unwrap();
		let world = CaseWorld::from_json(&common::gunzip(&common::golden().join(format!("world/expected/world-{faction}.json.gz")))).unwrap();
		compare(name, &d, &world, &proj, &cases);
	}
}

#[test]
fn slice_parity_local() {
	let (Some(refdir), Some(checkout)) = (std::env::var_os("POLESTAR_JSREF").map(PathBuf::from), std::env::var_os("POLESTAR_CHECKOUT").map(PathBuf::from)) else {
		eprintln!("cases parity local: skipped (set POLESTAR_JSREF and POLESTAR_CHECKOUT)");
		return;
	};
	let slice = refdir.join("simdir");
	let frames = checkout.join("data/forever/map-frames.json");
	let cases = parse_cases(&std::fs::read(fixture()).unwrap(), "reported.json").unwrap();
	for (name, faction) in ROUTES {
		let file = refdir.join(format!("cases-{name}.json"));
		let wfile = slice.join(format!("world-{faction}.json"));
		if !file.exists() || !wfile.exists() || !frames.exists() {
			eprintln!("cases parity {name}: skipped (POLESTAR_JSREF lacks cases-{name}.json or simdir/; dump them with the removed JS cases, git history at 734380d2a)");
			continue;
		}
		let d: Dump = serde_json::from_slice(&std::fs::read(&file).unwrap()).unwrap();
		let world = CaseWorld::load(&wfile).unwrap();
		let proj = Projector::new(&MapFrames::from_json(&std::fs::read(&frames).unwrap()).unwrap());
		compare(name, &d, &world, &proj, &cases);
	}
}
