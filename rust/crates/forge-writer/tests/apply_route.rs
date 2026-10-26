//! apply_route (port of tests/apply-route.test.js): a simulator route written into v1's guides in
//! v1's own lines.

use forge_core::frames::MapFrames;
use forge_world::atlas::{Subzone, SubzoneOf};
use forge_writer::{apply_route, Data, Inputs, Output, Route, World};
use serde_json::{json, Value};
use std::collections::BTreeMap;

fn f(file: &str, n: u32) -> String {
	format!("guides/forever/{file}.guide:{n}")
}

fn frames1() -> Value {
	json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } })
}

struct Case {
	files: Vec<(&'static str, Vec<&'static str>)>,
	route: Value,
	world: Value,
	quests: Value,
	npcs: Value,
	objects: Value,
	items: Value,
	zones: Value,
	frames: Value,
	level_fraction: bool,
	route_travel: bool,
}

impl Default for Case {
	fn default() -> Self {
		Case {
			files: Vec::new(),
			route: json!({ "diff": {}, "order": [] }),
			world: json!({ "points": [], "quests": [] }),
			quests: json!({}),
			npcs: json!({}),
			objects: json!({}),
			items: json!({}),
			zones: json!({}),
			frames: frames1(),
			level_fraction: false,
			route_travel: false,
		}
	}
}

struct Area(Option<Subzone>);
impl SubzoneOf for Area {
	fn at(&self, _c: i64, _wx: f64, _wy: f64) -> Option<Subzone> {
		self.0.clone()
	}
}

fn area(name: &str, zone: &str, zone_id: u32) -> Area {
	Area(Some(Subzone { id: 1, name: name.into(), zone_id, zone: zone.into() }))
}

struct Run {
	out: Output,
	guides: BTreeMap<String, String>,
}

impl Run {
	fn read(&self, name: &str) -> Vec<String> {
		let rel = format!("forever/{name}.guide");
		let text = self.out.files.iter().find(|(r, _)| *r == rel).map_or_else(|| self.guides[&rel].clone(), |(_, t)| t.clone());
		text.split('\n').map(str::to_string).collect()
	}
	fn text(&self, name: &str) -> String {
		self.read(name).join("\n")
	}
}

fn run(c: &Case, area_at: Option<&dyn SubzoneOf>) -> Run {
	let guides: BTreeMap<String, String> = c.files.iter().map(|(n, lines)| (format!("forever/{n}.guide"), lines.join("\n"))).collect();
	let route: Route = serde_json::from_value(c.route.clone()).unwrap();
	let world: World = serde_json::from_value(c.world.clone()).unwrap();
	let data = Data {
		quests: serde_json::from_value(c.quests.clone()).unwrap(),
		npcs: serde_json::from_value(c.npcs.clone()).unwrap(),
		objects: serde_json::from_value(c.objects.clone()).unwrap(),
		items: serde_json::from_value(c.items.clone()).unwrap(),
		zones: serde_json::from_value(c.zones.clone()).unwrap(),
	};
	let frames = MapFrames::from_json(c.frames.to_string().as_bytes()).unwrap();
	let out =
		apply_route(&Inputs { route: &route, guides: &guides, world: &world, data: &data, frames: &frames, area_at, level_fraction: c.level_fraction, route_travel: c.route_travel, walks: None })
			.unwrap();
	Run { out, guides }
}

fn pick(lines: &[String], re: &str) -> Vec<String> {
	let r = regex::Regex::new(re).unwrap();
	lines.iter().filter(|l| r.is_match(l)).cloned().collect()
}

fn idx(lines: &[String], l: &str) -> i64 {
	lines.iter().position(|x| x == l).map_or(-1, |i| i as i64)
}

fn has(lines: &[String], l: &str) -> bool {
	lines.iter().any(|x| x == l)
}

fn m(text: &str, re: &str) -> bool {
	regex::Regex::new(re).unwrap().is_match(text)
}

const START_OT: [&str; 6] = ["guide t/start", "title S", "race Orc,Troll", "levels 1-5", "zone Durotar", "next t/shared"];

fn lines(head: &[&'static str], rest: &[&'static str]) -> Vec<&'static str> {
	head.iter().chain(rest.iter()).copied().collect()
}

#[test]
fn order_quest_lines_class_lines_dropped_and_added() {
	let a = vec![
		"guide t/a",
		"title A",
		"levels 1-5",
		"zone Durotar",
		"next t/b",
		"",
		"step Hub",
		"  tip At the hub.",
		"  accept 1",
		"  accept 2",
		"  accept 9 only Orc,Warrior",
		"",
		"step Camp",
		"  goto 50,50",
		"  kill 10 quest 1.1",
		"  kill 11 quest 1.2",
		"",
		"step Hub again",
		"  turnin 1",
		"  accept 3",
		"",
	];
	let b = vec!["guide t/b", "title B", "levels 5-9", "zone The Barrens", "", "step Town", "  turnin 2", "  accept 4", "", "step Field", "  kill 12 quest 4.1", "  turnin 4", ""];
	let c = Case {
		files: vec![("a", a), ("b", b)],
		route: json!({
			"faction": "Horde", "start": "Orc", "tries": 1, "v1": { "hours60": 10 }, "improved": { "hours60": 9 },
			"diff": { "added": [5], "dropped": [3] },
			"order": [
				{ "t": "accept", "q": 1, "from": f("a", 9) }, { "t": "accept", "q": 2, "from": f("a", 10) },
				{ "t": "accept", "q": 5, "pt": 0, "from": "inserted" }, { "t": "task", "q": 5, "task": 0, "pt": 1, "from": "inserted" },
				{ "t": "task", "q": 1, "task": 0, "from": f("a", 15) }, { "t": "turnin", "q": 1, "from": f("a", 19) },
				{ "t": "turnin", "q": 5, "pt": 0, "from": "inserted" },
				{ "t": "turnin", "q": 2, "from": f("b", 7) }, { "t": "accept", "q": 4, "from": f("b", 8) }, { "t": "task", "q": 4, "task": 0, "from": f("b", 11) }, { "t": "turnin", "q": 4, "from": f("b", 12) }
			]
		}),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, -500, 500, 1411]], "zones": { "1411": "Durotar" }, "quests": [{ "id": 5, "objs": [{ "oi": 0, "type": "kill", "id": 20, "task": 0 }] }] }),
		quests: json!({ "1": { "title": "One" }, "3": { "title": "Three" }, "5": { "title": "Five", "start": { "npc": [7] }, "end": { "npc": [7] }, "objectives": [{ "type": "kill", "id": 20 }] }, "9": { "title": "Letter", "classes": 1 } }),
		npcs: json!({ "7": { "name": "Seven" } }),
		..Case::default()
	};
	let r = run(&c, None);
	assert_eq!(
		pick(&r.read("a"), r"^step|^\s+(accept|turnin|kill|goto|tip)"),
		vec![
			"step Hub",
			"  tip At the hub.",
			"  accept 1",
			"  accept 2",
			"  accept 9 only Orc,Warrior",
			"step Seven",
			"  accept 5",
			"step Five",
			"  kill 20 quest 5.1 @75.0,75.0 map 1411",
			"step Camp",
			"  goto 50,50",
			"  kill 10 quest 1.1",
			"  kill 11 quest 1.2",
			"step Hub again",
			"  turnin 1",
			"step Seven",
			"  turnin 5",
		]
	);
	assert!(m(&r.text("b"), r"step Field\n {2}kill 12 quest 4\.1\n {2}turnin 4"));
	assert!(m(&r.text("a"), r"# Added here: Five \(5\)\.\n# Left out: Three \(3\)\."));
}

#[test]
fn trailing_gotos_lead_to_the_next_step() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 1-5",
				"zone Durotar",
				"",
				"step Boars",
				"  kill 10 quest 1.1",
				"  goto 42.4,68.6 \"The Den\"",
				"",
				"step The Den",
				"  turnin 1",
				"",
				"step Hana",
				"  accept 2",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [{ "t": "task", "q": 1, "task": 0, "from": f("a", 7) }, { "t": "accept", "q": 2, "from": f("a", 14) }, { "t": "turnin", "q": 1, "from": f("a", 11) }] }),
		..Case::default()
	};
	let r = run(&c, None);
	assert_eq!(pick(&r.read("a"), r"^\s+(kill|accept|turnin|goto)"), vec!["  kill 10 quest 1.1", "  accept 2", "  goto 42.4,68.6 \"The Den\"", "  turnin 1"]);
}

#[test]
fn timed_item_and_item_turnin_wait() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 1-5",
				"zone Durotar",
				"",
				"step Camp",
				"  accept 1",
				"  buy 50",
				"",
				"step Cauldron",
				"  turnin 1",
				"",
				"step Far",
				"  accept 2",
				"  kill 9 quest 2.1",
				"",
				"step Hand in",
				"  accept 3",
				"  turnin 3",
				"",
				"step Drops",
				"  collect 60 x5",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "from": f("a", 7) }, { "t": "accept", "q": 2, "from": f("a", 14) }, { "t": "task", "q": 2, "task": 0, "from": f("a", 15) },
            { "t": "turnin", "q": 1, "from": f("a", 11) }, { "t": "accept", "q": 3, "from": f("a", 18) }, { "t": "turnin", "q": 3, "from": f("a", 19) }, { "t": "turnin", "q": 2, "from": f("a", 22) }
        ] }),
		quests: json!({ "1": { "objectives": [{ "type": "item", "id": 50 }] }, "3": { "objectives": [{ "type": "item", "id": 60 }] } }),
		items: json!({ "50": { "duration": 1800 } }),
		..Case::default()
	};
	let r = run(&c, None);
	let goals = pick(&r.read("a"), r"^\s+(kill|accept|turnin|buy|collect)");
	assert_eq!(goals[..4], ["  accept 1", "  buy 50", "  turnin 1", "  accept 2"]);
	assert!(idx(&goals, "  turnin 3") > idx(&goals, "  collect 60 x5"));
}

#[test]
fn added_quest_spawns_events_and_unwritable() {
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Hub", "  accept 1", ""])],
		route: json!({ "diff": { "added": [5, 6, 7] }, "order": [
            { "t": "accept", "q": 1, "from": f("a", 7) },
            { "t": "accept", "q": 5, "pt": 0, "from": "inserted" }, { "t": "task", "q": 5, "task": 0, "pt": 0, "from": "inserted" }, { "t": "turnin", "q": 5, "pt": 0, "from": "inserted" },
            { "t": "accept", "q": 6, "pt": 0, "from": "inserted" }, { "t": "task", "q": 6, "task": 0, "pt": 1, "from": "inserted" },
            { "t": "accept", "q": 7, "pt": 0, "from": "inserted" }, { "t": "turnin", "q": 7, "pt": 0, "from": "inserted" }
        ] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, -500, 500, 1411]], "zones": { "1411": "Durotar", "1413": "The Barrens" },
            "quests": [{ "id": 5, "objs": [{ "oi": 0, "type": "kill", "id": 20, "task": 0 }] }, { "id": 6, "objs": [{ "oi": 0, "type": "event", "task": 0 }] }, { "id": 7, "objs": [] }] }),
		quests: json!({ "5": { "title": "Five", "start": { "object": [70] }, "end": { "npc": [8] }, "objectives": [{ "type": "kill", "id": 20 }] }, "6": { "title": "Six", "start": { "npc": [8] }, "objectives": [{ "type": "event" }] }, "7": { "title": "Seven", "start": { "npc": [8] }, "objectives": [{ "type": "item", "id": 99 }] } }),
		npcs: json!({ "8": { "name": "Eight", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } }, "20": { "spawns": { "1411": { "f": "e", "pts": [[10, 10], [52, 49]] } } } }),
		objects: json!({ "70": { "spawns": { "1413": { "f": "e", "pts": [[50, 50]] } } } }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		..Case::default()
	};
	let r = run(&c, None);
	let text = r.text("a");
	assert!(m(&text, r"zone The Barrens\n {2}accept 5"), "the object giver's own zone");
	assert!(m(&text, r"kill 20 quest 5\.1 @52\.0,49\.0 map 1411"), "the boar nearest the route point");
	assert!(m(&text, r"step Six\n( {2}zone Durotar\n)? {2}goto 75\.0,75\.0\n {2}complete 6"));
	assert!(!text.contains("accept 7"));
	assert_eq!(r.out.unwritable, vec![7]);
}

#[test]
fn hearth_before_its_bind_goes() {
	let a = vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Inn", "  sethome \"Razor Hill\"", "  accept 1", "", "step Home", "  hearth \"Razor Hill\"", "  turnin 1", ""];
	let c =
		Case { files: vec![("a", a.clone())], route: json!({ "diff": {}, "order": [{ "t": "turnin", "q": 1, "from": f("a", 12) }, { "t": "accept", "q": 1, "from": f("a", 8) }] }), ..Case::default() };
	assert!(!run(&c, None).read("a").iter().any(|l| l.contains("hearth")), "the hearth came before the bind: gone");
	let c = Case { files: vec![("a", a)], route: json!({ "diff": {}, "order": [{ "t": "accept", "q": 1, "from": f("a", 8) }, { "t": "turnin", "q": 1, "from": f("a", 12) }] }), ..Case::default() };
	assert!(run(&c, None).read("a").iter().any(|l| l.contains("hearth \"Razor Hill\"")));
}

#[test]
fn twin_spawns_on_two_maps() {
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Hub", "  accept 1", ""])],
		route: json!({ "diff": { "added": [5] }, "order": [{ "t": "accept", "q": 1, "from": f("a", 7) }, { "t": "accept", "q": 5, "pt": 0, "from": "inserted" }] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411]], "zones": { "1411": "Durotar", "1413": "The Barrens", "1454": "Orgrimmar" }, "quests": [{ "id": 5, "objs": [] }] }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1454": { "top": 100, "bottom": -100, "left": -100, "right": 100, "c": 1 } } }),
		npcs: json!({ "8": { "name": "Eight", "spawns": { "1413": { "f": "e", "pts": [[50, 50]] }, "1454": { "f": "e", "pts": [[50, 50]] } } } }),
		quests: json!({ "5": { "title": "Five", "start": { "npc": [8] } } }),
		zones: json!({ "1413": { "areaId": 17 }, "1454": { "areaId": 1637 } }),
		..Case::default()
	};
	let barrens = area("", "", 17);
	assert!(m(&run(&c, Some(&barrens)).text("a"), r"zone The Barrens\n {2}accept 5"), "the client says the Barrens");
	assert!(m(&run(&c, None).text("a"), r"zone Orgrimmar\n {2}accept 5"), "no client areas: the smaller map");
}

#[test]
fn zone_move_gets_a_goto_and_item_accept_follows_item() {
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Hub", "  accept 1", "  accept 3", "", "step Pendant", "  collect 50", "  turnin 1", ""])],
		route: json!({ "diff": { "added": [2] }, "order": [{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) }, { "t": "accept", "q": 2, "pt": 1, "from": "inserted" }, { "t": "turnin", "q": 1, "pt": 0, "from": f("a", 12) }] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, -900, 900, 1413]], "zones": { "1411": "Durotar", "1413": "The Barrens" }, "quests": [{ "id": 2, "objs": [] }] }),
		quests: json!({ "2": { "title": "Two" }, "3": { "title": "Three", "start": { "item": [50] } } }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		..Case::default()
	};
	let text = run(&c, None).text("a");
	assert!(m(&text, r#"step The Barrens\n {2}zone The Barrens\n {2}goto 95\.0,95\.0 "The Barrens""#));
	assert!(m(&text, r"collect 50\n {2}accept 3"));
}

#[test]
fn shared_and_start_guide_lines() {
	let c = Case {
		files: vec![
			("start", lines(&START_OT, &["", "step Den", "  accept 1", "  accept 3", "  turnin 1", "  turnin 3", "", "step Valley", "  accept 4", "  turnin 4", ""])),
			("shared", vec!["guide t/shared", "title Shared", "levels 5-9", "zone The Barrens", "", "step Crossroads", "  accept 2", "", "step Plains", "  kill 9 quest 2.1", "  turnin 2", ""]),
		],
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "from": f("start", 9) }, { "t": "accept", "q": 3, "from": f("start", 10) }, { "t": "accept", "q": 2, "from": f("shared", 7) },
            { "t": "turnin", "q": 1, "from": f("start", 11) }, { "t": "turnin", "q": 3, "from": f("start", 12) },
            { "t": "task", "q": 2, "task": 0, "from": f("shared", 10) }, { "t": "accept", "q": 4, "from": f("start", 15) }, { "t": "turnin", "q": 2, "from": f("shared", 11) }, { "t": "turnin", "q": 4, "from": f("start", 16) }
        ] }),
		..Case::default()
	};
	let r = run(&c, None);
	let re = r"^\s+(accept|kill|turnin|only)";
	assert_eq!(pick(&r.read("start"), re), vec!["  accept 1", "  accept 3", "  accept 2", "  turnin 1", "  turnin 3", "  kill 9 quest 2.1", "  accept 4"]);
	assert_eq!(pick(&r.read("shared"), re), vec!["  accept 2", "  kill 9 quest 2.1", "  turnin 2", "  only Orc,Troll", "  turnin 4"]);
}

fn travel_world() -> Value {
	json!({
		"points": [[1, 1, 0, 0, 1411], [1, 1, 500, 500, 1411], [1, 1, 10, 10, 1411], [1, 1, 490, 490, 1411]],
		"zones": { "1411": "Durotar" }, "quests": [],
		"inns": [{ "name": "Razor Hill", "pt": 0 }], "nodes": [{ "kind": "fp", "name": "Orgrimmar", "pt": 2 }, { "kind": "fp", "name": "Crossroads", "pt": 3 }]
	})
}

#[test]
fn route_binds_hearths_flights_and_paths() {
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Inn", "  sethome \"Razor Hill\"", "  accept 1", "", "step Far", "  hearth \"Razor Hill\"", "  turnin 1", ""],
		)],
		world: travel_world(),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 8), "items": [{ "t": "getfp", "node": 1 }, { "t": "getfp", "node": 0 }, { "t": "bind", "inn": 0, "pt": 0, "used": true }] },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 12), "items": [{ "t": "hearth", "inn": 0, "to": 1 }, { "t": "network", "from": 0, "to": 1 }] }
        ] }),
		..Case::default()
	};
	assert_eq!(
		pick(&run(&c, None).read("a"), r"^\s+(accept|turnin|sethome|hearth|fly|getfp|goto)"),
		vec![
			"  getfp \"Crossroads\"",
			"  getfp \"Orgrimmar\"",
			"  sethome \"Razor Hill\"",
			"  accept 1",
			"  hearth \"Razor Hill\"",
			"  goto 50.5,49.5 \"Orgrimmar flight master\"",
			"  fly \"Crossroads\"",
			"  turnin 1"
		]
	);
}

#[test]
fn no_flight_unlearned_and_shared_travel_for_others() {
	let c = Case {
		files: vec![
			("start", lines(&START_OT, &["", "step Den", "  accept 1", ""])),
			("shared", vec!["guide t/shared", "title Shared", "levels 5-9", "zone Durotar", "", "step Inn", "  sethome \"Razor Hill\"", "  turnin 1", ""]),
		],
		world: travel_world(),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("shared", 8), "items": [{ "t": "network", "from": 0, "to": 1 }, { "t": "bind", "inn": 0, "pt": 1, "used": true }] }
        ] }),
		..Case::default()
	};
	assert_eq!(pick(&run(&c, None).read("shared"), r"^\s+(turnin|sethome|fly|only)"), vec!["  only Orc,Troll", "  sethome \"Razor Hill\"", "  turnin 1"]);
}

#[test]
fn class_step_stays_at_its_v1_place() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 1-12",
				"zone The Barrens",
				"",
				"step Camp",
				"  accept 1",
				"",
				"step Far Watch",
				"  only Warrior",
				"  accept 1498",
				"  turnin 1498",
				"  accept 1502",
				"",
				"step Field",
				"  kill 9 quest 1.1",
				"  turnin 1",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [{ "t": "accept", "q": 1, "from": f("a", 7) }, { "t": "task", "q": 1, "task": 0, "from": f("a", 16) }, { "t": "turnin", "q": 1, "from": f("a", 17) }] }),
		quests: json!({ "1498": { "title": "Path of Defense", "classes": 1 }, "1502": { "title": "Thun'grim Firegaze", "classes": 1 } }),
		..Case::default()
	};
	assert_eq!(
		pick(&run(&c, None).read("a"), r"^step|^\s+(only|accept|turnin|kill)"),
		vec!["step Camp", "  accept 1", "step Far Watch", "  only Warrior", "  accept 1498", "  turnin 1498", "  accept 1502", "step Field", "  kill 9 quest 1.1", "  turnin 1"]
	);
}

#[test]
fn escort_step_dropped_bag_count_and_v1_flight_paths() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 1-30",
				"zone Ashenvale",
				"",
				"step Grove",
				"  accept 5",
				"  getfp \"Crossroads\"",
				"",
				"step Kerlonian",
				"  goto 44.4,76.4 \"Kerlonian\"",
				"  note Escort him to the post.",
				"",
				"step Post",
				"  turnin 5",
				"",
				"step Lift",
				"  collect 5791 @30.7,24.3",
				"",
			],
		)],
		world: json!({ "points": [[1, 1, 0, 0, 1440], [1, 1, 500, 500, 1440], [1, 1, 10, 10, 1440], [1, 1, 490, 490, 1440]], "zones": { "1440": "Ashenvale" }, "quests": [{ "id": 5, "objs": [{ "oi": 0, "type": "event", "task": 0 }] }], "inns": [], "nodes": [{ "kind": "fp", "name": "Orgrimmar", "pt": 2 }, { "kind": "fp", "name": "Crossroads", "pt": 3 }] }),
		route: json!({ "faction": "Horde", "diff": { "dropped": [1100] }, "order": [
            { "t": "accept", "q": 5, "pt": 0, "from": f("a", 7), "items": [{ "t": "getfp", "node": 0 }] },
            { "t": "task", "q": 5, "task": 0, "pt": 1, "from": f("a", 15), "items": [{ "t": "network", "from": 0, "to": 1 }] },
            { "t": "turnin", "q": 5, "pt": 1, "from": f("a", 15) }
        ] }),
		quests: json!({ "5": { "title": "Sleeper", "objectives": [{ "type": "event" }] }, "1100": { "title": "Lonebrow's Journal", "start": { "item": [5791] } } }),
		..Case::default()
	};
	let g = pick(&run(&c, None).read("a"), r"^\s+(accept|turnin|goto|complete|collect|getfp|fly|note)");
	assert!(!g.iter().any(|l| l.contains("collect 5791")));
	assert!(!g.iter().any(|l| l.contains("complete 5")));
	assert!(idx(&g, "  note Escort him to the post.") < idx(&g, "  turnin 5"));
	assert!(has(&g, "  getfp \"Crossroads\"") && has(&g, "  fly \"Crossroads\""));
}

#[test]
fn bind_returned_to_twice_and_bought_item_is_the_work() {
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 20-30", "zone Duskwood", "", "step Darkshire", "  accept 174", "  buy 4371 x1 npc 3133 optional", "", "step Viktori", "  turnin 174", ""],
		)],
		world: json!({ "points": [[1, 1, 0, 0, 1431], [1, 1, 5000, 5000, 1442]], "zones": { "1431": "Duskwood", "1442": "Stonetalon Mountains" }, "quests": [{ "id": 174, "objs": [{ "oi": 0, "type": "item", "id": 4371, "task": 0 }] }], "inns": [{ "name": "Darkshire", "pt": 0 }], "nodes": [] }),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 174, "pt": 0, "from": f("a", 7), "items": [{ "t": "bind", "inn": 0, "pt": 0, "used": false, "returns": 2 }] },
            { "t": "task", "q": 174, "task": 0, "pt": 1, "from": f("a", 11), "items": [{ "t": "network", "from": 0, "to": 1 }] },
            { "t": "turnin", "q": 174, "pt": 0, "from": f("a", 11) }
        ] }),
		quests: json!({ "174": { "title": "Look to the Stars", "objectives": [{ "type": "item", "id": 4371 }] } }),
		..Case::default()
	};
	assert_eq!(pick(&run(&c, None).read("a"), r"^\s+(accept|turnin|buy|collect|sethome|goto|fly)"), vec!["  sethome \"Darkshire\"", "  accept 174", "  buy 4371 x1 npc 3133 optional", "  turnin 174"]);
}

#[test]
fn zone_again_after_some_only_step_and_one_flight_path_line() {
	let c = Case {
		files: vec![
			("start", lines(&START_OT, &["", "step Den", "  accept 1", ""])),
			(
				"shared",
				vec!["guide t/shared", "title Shared", "levels 5-9", "zone Durotar", "", "step Post", "  getfp \"Crossroads\"", "  turnin 1", "", "step Altar", "  goto 49,68.7", "  accept 2", ""],
			),
		],
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 500, 500, 1413], [1, 1, 10, 10, 1411], [1, 1, 490, 490, 1413]], "zones": { "1411": "Durotar", "1413": "The Barrens" }, "quests": [], "inns": [], "nodes": [{ "kind": "fp", "name": "Orgrimmar", "pt": 2 }, { "kind": "fp", "name": "Crossroads", "pt": 3 }] }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("start", 9), "items": [{ "t": "getfp", "node": 0 }] },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("shared", 8), "items": [{ "t": "getfp", "node": 1 }] },
            { "t": "accept", "q": 2, "pt": 0, "from": f("shared", 12), "items": [{ "t": "network", "from": 1, "to": 0 }] }
        ] }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		..Case::default()
	};
	let t = run(&c, None).read("shared");
	assert_eq!(t.iter().filter(|l| l.contains("getfp \"Crossroads\"")).count(), 1);
	assert!(idx(&t, "  fly \"Orgrimmar\"") > 0);
	let altar = idx(&t, "step Altar") as usize;
	assert_eq!(t[altar + 1], "  zone Durotar");
}

#[test]
fn no_route_travel_inside_one_v1_step() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-20",
				"zone Darkshore",
				"",
				"step Auberdine",
				"  accept 1003",
				"  sethome \"Auberdine\"",
				"",
				"step The Grove",
				"  collect 5414 quest 1003",
				"  turnin 1003",
				"",
			],
		)],
		world: json!({ "points": [[1, 1, 0, 0, 1439], [1, 1, 2000, 0, 1439], [1, 1, 10, 0, 1439]], "zones": { "1439": "Darkshore" }, "quests": [{ "id": 1003, "objs": [{ "oi": 0, "type": "item", "id": 5414, "task": 0 }] }], "inns": [{ "name": "Auberdine", "pt": 0 }], "nodes": [] }),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1003, "pt": 0, "from": f("a", 6), "items": [{ "t": "bind", "inn": 0, "pt": 0, "used": true }] },
            { "t": "task", "q": 1003, "task": 0, "pt": 1, "from": f("a", 11) },
            { "t": "turnin", "q": 1003, "pt": 2, "from": f("a", 12), "items": [{ "t": "hearth", "inn": 0, "to": 2, "innPt": 0 }] }
        ] }),
		quests: json!({ "1003": { "title": "Buzzbox 525", "objectives": [{ "type": "item", "id": 5414 }] } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| m(l, r"^\s+hearth\b")));
	let (c0, u) = (idx(&g, "  collect 5414 quest 1003"), idx(&g, "  turnin 1003"));
	assert!(c0 > 0 && u == c0 + 1);
}

#[test]
fn goal_handed_in_in_its_step_at_the_ender_camp() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-20",
				"zone Durotar",
				"",
				"step Furbolgs",
				"  kill 9 quest 985.1",
				"",
				"step Beaches",
				"  accept 4728",
				"",
				"step The Grove",
				"  collect 5414 quest 1003",
				"  turnin 1003",
				"",
			],
		)],
		world: json!({ "points": [[1, 1, -800, -800, 1411], [1, 1, 800, 800, 1411], [1, 1, 0, 0, 1411]], "zones": { "1411": "Durotar" }, "quests": [], "inns": [], "nodes": [] }),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 4728, "pt": 1, "from": f("a", 10) }, { "t": "task", "q": 985, "task": 0, "pt": 0, "from": f("a", 7) },
            { "t": "task", "q": 1003, "task": 0, "pt": 0, "from": f("a", 13) }, { "t": "turnin", "q": 1003, "pt": 2, "from": f("a", 14) }
        ] }),
		npcs: json!({ "30": { "spawns": { "1411": { "f": "e", "pts": [[10, 10], [52, 50]] } } } }),
		items: json!({ "5414": { "drops": { "npc": { "30": 0.5 } } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "step Beaches") < idx(&g, "step Furbolgs"));
	assert!(has(&g, "  collect 5414 quest 1003 @52.0,50.0 map 1411"), "{g:?}");
}

#[test]
fn v1_hearth_is_the_others_and_v1_pier() {
	let c = Case {
		files: vec![
			("start", lines(&START_OT, &["", "step Den", "  accept 1", ""])),
			(
				"shared",
				vec![
					"guide t/shared",
					"title Shared",
					"levels 5-9",
					"zone Durotar",
					"",
					"step Inn",
					"  sethome \"Razor Hill\"",
					"  getfp \"Razor Hill\"",
					"  getfp \"Crossroads\"",
					"  turnin 1",
					"",
					"step Back",
					"  hearth \"Razor Hill\"",
					"  fly \"Crossroads\"",
					"  accept 2",
					"",
					"step Dock",
					"  goto 30.8,40.9 \"Boat to Stormwind\"",
					"  turnin 2",
					"",
				],
			),
		],
		world: json!({
			"points": [[1, 1, 0, 0, 1411], [1, 1, 500, 500, 1411], [1, 1, 10, 10, 1411], [1, 1, 490, 490, 1411], [0, 0, 0, 0, 1453], [1, 1, 100, 100, 1411], [0, 0, 5, 5, 1453]],
			"zones": { "1411": "Durotar", "1453": "Stormwind City" }, "quests": [],
			"inns": [{ "name": "Razor Hill", "pt": 0 }],
			"nodes": [{ "kind": "fp", "name": "Razor Hill", "pt": 2 }, { "kind": "fp", "name": "Crossroads", "pt": 3 }, { "kind": "dock", "name": "Razor Hill (boat)", "pt": 5 }, { "kind": "dock", "name": "Stormwind Harbor (boat)", "pt": 6 }],
			"rides": [[2, 3, 100, 200, "boat-x"]]
		}),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) },
            { "t": "turnin", "q": 1, "pt": 0, "from": f("shared", 10), "items": [{ "t": "bind", "inn": 0, "pt": 0, "used": true }, { "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }] },
            { "t": "accept", "q": 2, "pt": 1, "from": f("shared", 15) },
            { "t": "turnin", "q": 2, "pt": 4, "from": f("shared", 19), "items": [{ "t": "network", "from": 1, "to": 4 }] }
        ] }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1453": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		..Case::default()
	};
	let g = run(&c, None).read("shared");
	assert!(has(&g, "  hearth \"Razor Hill\" only Tauren,Undead,Skyborne"), "{g:?}");
	let boats: Vec<&String> = g.iter().filter(|x| x.contains("\"Boat to Stormwind")).collect();
	assert!(g.iter().any(|l| m(l, r#"^\s+goto 30\.8,40\.9 "Boat to Stormwind"#)) && boats.iter().all(|x| x.contains("30.8,40.9")), "{g:?}");
}

#[test]
fn v1_pier_on_the_live_map_stays_live() {
	let c = Case {
		files: vec![
			("start", lines(&START_OT, &["", "step Den", "  accept 1", ""])),
			(
				"shared",
				vec![
					"guide t/shared",
					"title Shared",
					"levels 5-9",
					"zone Durotar",
					"",
					"step Inn",
					"  sethome \"Razor Hill\"",
					"  getfp \"Razor Hill\"",
					"  getfp \"Crossroads\"",
					"  turnin 1",
					"",
					"step Back",
					"  hearth \"Razor Hill\"",
					"  fly \"Crossroads\"",
					"  accept 2",
					"",
					"step Dock",
					"  goto 30.8,40.9 \"Boat to Stormwind\" live",
					"  turnin 2",
					"",
				],
			),
		],
		world: json!({
			"points": [[1, 1, 0, 0, 1411], [1, 1, 500, 500, 1411], [1, 1, 10, 10, 1411], [1, 1, 490, 490, 1411], [0, 0, 0, 0, 1453], [1, 1, 100, 100, 1411], [0, 0, 5, 5, 1453]],
			"zones": { "1411": "Durotar", "1453": "Stormwind City" }, "quests": [],
			"inns": [{ "name": "Razor Hill", "pt": 0 }],
			"nodes": [{ "kind": "fp", "name": "Razor Hill", "pt": 2 }, { "kind": "fp", "name": "Crossroads", "pt": 3 }, { "kind": "dock", "name": "Razor Hill (boat)", "pt": 5 }, { "kind": "dock", "name": "Stormwind Harbor (boat)", "pt": 6 }],
			"rides": [[2, 3, 100, 200, "boat-x"]]
		}),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) },
            { "t": "turnin", "q": 1, "pt": 0, "from": f("shared", 10), "items": [{ "t": "bind", "inn": 0, "pt": 0, "used": true }, { "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }] },
            { "t": "accept", "q": 2, "pt": 1, "from": f("shared", 15) },
            { "t": "turnin", "q": 2, "pt": 4, "from": f("shared", 19), "items": [{ "t": "network", "from": 1, "to": 4 }] }
        ] }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1453": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		..Case::default()
	};
	let g = run(&c, None).read("shared");
	// The Darkshore boat step at v1's Stormwind pier (22.71,56.69 live) read on the Era map was 286 yd inside the city.
	let boats: Vec<&String> = g.iter().filter(|x| x.contains("30.8,40.9")).collect();
	assert!(!boats.is_empty() && boats.iter().all(|x| x.contains(" live")), "{g:?}");
}

#[test]
fn flight_from_where_the_zeppelin_lands() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-20",
				"zone Tirisfal Glades",
				"",
				"step Brill",
				"  accept 1",
				"  getfp \"Sepulcher\"",
				"  getfp \"Orgrimmar\"",
				"  getfp \"Crossroads\"",
				"",
				"step Zeppelin to Orgrimmar",
				"  goto 60.7,58.9 \"Zeppelin tower\"",
				"  goto 60.7,58.9 \"Zeppelin to Orgrimmar\"",
				"",
				"step Camp",
				"  turnin 1",
				"  accept 2",
				"",
				"step Crossroads",
				"  getfp \"Crossroads\"",
				"",
				"step Field",
				"  turnin 2",
				"",
			],
		)],
		world: json!({
			"points": [[0, 0, 0, 0, 1420], [1, 1, 500, 500, 1411], [0, 0, 10, 10, 1420], [1, 1, 0, 0, 1411], [1, 1, 900, 900, 1411], [0, 0, 20, 20, 1420], [1, 1, 5, 5, 1411], [1, 1, 880, 880, 1411]],
			"zones": { "1411": "Durotar", "1420": "Tirisfal Glades" }, "quests": [], "inns": [],
			"nodes": [{ "kind": "fp", "name": "Sepulcher", "pt": 2 }, { "kind": "fp", "name": "Orgrimmar", "pt": 6 }, { "kind": "fp", "name": "Crossroads", "pt": 7 }, { "kind": "dock", "name": "Tirisfal Glades (zeppelin)", "pt": 5 }, { "kind": "dock", "name": "Orgrimmar (zeppelin)", "pt": 3 }],
			"rides": [[3, 4, 100, 200, "zeppelin-x"]]
		}),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 17), "items": [{ "t": "network", "from": 0, "to": 1 }] },
            { "t": "accept", "q": 2, "pt": 1, "from": f("a", 18) },
            { "t": "turnin", "q": 2, "pt": 4, "from": f("a", 24), "items": [{ "t": "network", "from": 1, "to": 7 }] }
        ] }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1420": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l.contains("\"Sepulcher flight master\"")), "{g:?}");
	assert!(g.iter().any(|l| l.contains("\"Orgrimmar flight master\"")), "{g:?}");
	assert_eq!(g.iter().filter(|l| m(l, r#"^\s+fly "Crossroads""#)).count(), 1);
}

#[test]
fn bind_at_a_train_event_goes_to_the_inn_step() {
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "", "step Abbey", "  accept 1", "  train class", "", "step Goldshire", "  turnin 1", ""])],
		world: json!({ "points": [[0, 0, 0, 0, 1429], [0, 0, 900, 900, 1429]], "zones": { "1429": "Elwynn Forest" }, "quests": [], "inns": [{ "name": "Goldshire", "pt": 1 }], "nodes": [] }),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
            { "t": "train", "pt": 1, "from": f("a", 8), "items": [{ "t": "bind", "inn": 0, "pt": 1, "innPt": 1, "used": true }] },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 11) }
        ] }),
		..Case::default()
	};
	assert_eq!(
		pick(&run(&c, None).read("a"), r"^step|^\s+(accept|turnin|train|sethome)"),
		vec!["step Abbey", "  accept 1", "  train class", "step Goldshire", "  sethome \"Goldshire\"", "  turnin 1"]
	);
}

#[test]
fn route_hearth_for_its_races_v1_for_the_others() {
	let c = Case {
		files: vec![
			("start", lines(&START_OT, &["", "step Den", "  accept 1", ""])),
			(
				"shared",
				vec![
					"guide t/shared",
					"title Shared",
					"levels 5-9",
					"zone Durotar",
					"",
					"step Inn",
					"  sethome \"Razor Hill\"",
					"  turnin 1",
					"  accept 2",
					"",
					"step Back",
					"  hearth \"Razor Hill\"",
					"  turnin 2",
					"",
				],
			),
		],
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 900, 900, 1411]], "zones": { "1411": "Durotar" }, "quests": [], "inns": [{ "name": "Razor Hill", "pt": 0 }], "nodes": [] }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) },
            { "t": "turnin", "q": 1, "pt": 0, "from": f("shared", 8), "items": [{ "t": "bind", "inn": 0, "pt": 0, "used": true }] },
            { "t": "accept", "q": 2, "pt": 1, "from": f("shared", 9) },
            { "t": "turnin", "q": 2, "pt": 0, "from": f("shared", 13), "items": [{ "t": "hearth", "inn": 0, "to": 0 }] }
        ] }),
		..Case::default()
	};
	assert_eq!(pick(&run(&c, None).read("shared"), r"^\s+hearth"), vec!["  hearth \"Razor Hill\"", "  hearth \"Razor Hill\" only Tauren,Undead,Skyborne"]);
}

#[test]
fn optional_extra_with_the_first_piece_and_its_quest_taken_there() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 1-10",
				"zone Elwynn Forest",
				"",
				"step Murlocs",
				"  tip Croaky roams the shore.",
				"  collect 780 quest 46.1",
				"  collect 2239 quest 147.1",
				"  collect 247826 x1 optional",
				"  accept 91740 optional",
				"",
				"step Lake",
				"  collect 1019 quest 83.1",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [
            { "t": "task", "q": 46, "task": 0, "from": f("a", 8) }, { "t": "task", "q": 83, "task": 0, "from": f("a", 14) },
            { "t": "task", "q": 147, "task": 0, "from": f("a", 9) }, { "t": "accept", "q": 91740, "from": f("a", 11) }
        ] }),
		quests: json!({ "91740": { "title": "Croaky's Head", "start": { "item": [247826] } } }),
		..Case::default()
	};
	assert_eq!(
		pick(&run(&c, None).read("a"), r"^step|^\s+(collect|accept)"),
		vec![
			"step Murlocs",
			"  collect 780 quest 46.1",
			"  collect 247826 x1 optional",
			"  accept 91740 optional",
			"step Lake",
			"  collect 1019 quest 83.1",
			"step Murlocs",
			"  collect 2239 quest 147.1"
		]
	);
}

#[test]
fn no_ride_below_riding_level() {
	let c = Case {
		files: vec![
			("a", vec!["guide t/a", "title A", "levels 30-40", "zone Arathi Highlands", "next t/b", "", "step Biggs", "  accept 1", "", "step Harborage", "  accept 3", ""]),
			("b", vec!["guide t/b", "title B", "levels 40-50", "zone Arathi Highlands", "", "step Webb", "  tip Ride back west along the road.", "  turnin 1", "", "step Later", "  accept 2", ""]),
		],
		route: json!({ "diff": {}, "order": [{ "t": "accept", "q": 1, "from": f("a", 8) }, { "t": "turnin", "q": 1, "from": f("b", 8) }, { "t": "accept", "q": 3, "from": f("a", 11) }, { "t": "accept", "q": 2, "from": f("b", 11) }] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(has(&g, "  tip Head back west along the road."), "{g:?}");
}

#[test]
fn dropped_quests_step_keeps_the_way() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 20-30",
				"zone Wetlands",
				"",
				"step To Theramore",
				"  accept 1",
				"",
				"step The Great Lift",
				"  zone Thousand Needles",
				"  tip From Theramore follow the road west. The lift takes you down. The journal lies at the foot of the lift.",
				"  collect 5791 @30.7,24.3",
				"  accept 1100",
				"",
				"step Mirage Raceway",
				"  turnin 1",
				"",
			],
		)],
		world: json!({
			"points": [[0, 0, 0, 0, 1437], [1, 1, 500, 500, 1441], [0, 0, 10, 10, 1437], [1, 1, 400, 400, 1441]],
			"zones": { "1437": "Wetlands", "1441": "Thousand Needles" }, "quests": [], "inns": [], "nodes": [{ "kind": "dock", "name": "Menethil Harbor (boat)", "pt": 2 }, { "kind": "dock", "name": "Theramore (boat)", "pt": 3 }],
			"rides": [[0, 1, 100, 200, "boat-menethil-theramore"]]
		}),
		route: json!({ "diff": { "dropped": [1100] }, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 16), "items": [{ "t": "network", "from": 0, "to": 1 }] }
        ] }),
		quests: json!({ "1100": { "title": "Lonebrow's Journal", "start": { "item": [5791] } } }),
		items: json!({ "5791": { "name": "Henrig Lonebrow's Journal" } }),
		frames: json!({ "era": { "1437": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1441": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		..Case::default()
	};
	let g = pick(&run(&c, None).read("a"), r"^step|^\s+(goto|tip|collect|accept|turnin)");
	let boat = g.iter().position(|l| l.contains("\"Boat to Theramore\"")).map_or(-1, |i| i as i64);
	let lift = idx(&g, "step The Great Lift");
	assert!(boat > 0 && lift > boat, "{g:?}");
	assert_eq!(g[lift as usize + 1], "  tip From Theramore follow the road west. The lift takes you down.");
	assert_eq!(g[lift as usize + 2], "  goto 30.7,24.3 \"The Great Lift\"");
	assert!(!g.iter().any(|l| m(l, r#"collect 5791|accept 1100|"Thousand Needles""#)), "{g:?}");
}

#[test]
fn quest_line_without_work_stays_after_the_accept() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 20-30",
				"zone Thousand Needles",
				"",
				"step Dorn",
				"  accept 1150",
				"  accept 98070",
				"",
				"step Roguefeather Den",
				"  collect 5843 quest 1150",
				"  kill 4100 quest 98070.1",
				"",
				"step Freewind Post",
				"  turnin 98070",
				"",
				"step Test of Endurance",
				"  turnin 1150",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1150, "from": f("a", 7) }, { "t": "accept", "q": 98070, "from": f("a", 8) },
            { "t": "task", "q": 98070, "task": 0, "from": f("a", 12) }, { "t": "turnin", "q": 98070, "from": f("a", 15) }, { "t": "turnin", "q": 1150, "from": f("a", 18) }
        ] }),
		..Case::default()
	};
	assert_eq!(
		pick(&run(&c, None).read("a"), r"^step|^\s+(collect|kill|turnin)"),
		vec!["step Dorn", "step Roguefeather Den", "  collect 5843 quest 1150", "  kill 4100 quest 98070.1", "step Freewind Post", "  turnin 98070", "step Test of Endurance", "  turnin 1150"]
	);
}

#[test]
fn optional_extra_goes_with_the_piece_worked_first() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-20",
				"zone Westfall",
				"",
				"step Molsen Farm",
				"  kill 114 quest 9.1",
				"  collect 255007 quest 92909.1",
				"  collect 255155 optional",
				"",
				"step Mine",
				"  kill 504 quest 12.1",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [{ "t": "task", "q": 92909, "task": 0, "from": f("a", 8) }, { "t": "task", "q": 12, "task": 0, "from": f("a", 12) }, { "t": "task", "q": 9, "task": 0, "from": f("a", 7) }] }),
		..Case::default()
	};
	assert_eq!(
		pick(&run(&c, None).read("a"), r"^step|^\s+(collect|kill)"),
		vec!["step Molsen Farm", "  collect 255007 quest 92909.1", "  collect 255155 optional", "step Mine", "  kill 504 quest 12.1", "step Molsen Farm", "  kill 114 quest 9.1"]
	);
}

#[test]
fn work_line_hearthed_to_goes_to_the_camp_under_its_place_name() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-20",
				"zone Westfall",
				"",
				"step Sentinel Hill",
				"  sethome \"Sentinel Hill\"",
				"  accept 153",
				"",
				"step Jangolode Mine",
				"  kill 504 quest 12.1",
				"  collect 829 quest 153",
				"",
				"step Back",
				"  turnin 153",
				"",
				"step Farm",
				"  kill 114 quest 9.1",
				"",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1436], [0, 0, 900, 900, 1436], [0, 0, 100, -100, 1436]], "zones": { "1436": "Westfall" }, "quests": [], "inns": [{ "name": "Sentinel Hill", "pt": 0 }], "nodes": [] }),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 153, "pt": 0, "from": f("a", 8), "items": [{ "t": "bind", "inn": 0, "pt": 0, "used": true }] },
            { "t": "task", "q": 12, "task": 0, "pt": 1, "from": f("a", 11) }, { "t": "task", "q": 9, "task": 0, "pt": 1, "from": f("a", 18) },
            { "t": "task", "q": 153, "task": 0, "pt": 2, "from": f("a", 12), "items": [{ "t": "hearth", "inn": 0, "to": 2, "innPt": 0 }] },
            { "t": "turnin", "q": 153, "pt": 0, "from": f("a", 15) }
        ] }),
		npcs: json!({ "6": { "spawns": { "1436": { "f": "e", "pts": [[90, 90], [45, 55]] } } } }),
		items: json!({ "829": { "drops": { "npc": { "6": 0.5 } } } }),
		frames: json!({ "era": { "1436": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		..Case::default()
	};
	let hills = area("The Dagger Hills", "Westfall", 0);
	let g = pick(&run(&c, Some(&hills)).read("a"), r"^step|^\s+(collect|kill|hearth)");
	let h = idx(&g, "  hearth \"Sentinel Hill\"");
	assert!(h > 0, "{g:?}");
	assert_eq!(g[h as usize + 1], "step The Dagger Hills", "{g:?}");
	assert!(m(&g[h as usize + 2], r"^  collect 829 quest 153 @\d"), "{g:?}");
}

#[test]
fn second_line_for_the_same_goal_not_carried() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-20",
				"zone Westfall",
				"",
				"step Hill",
				"  accept 153",
				"",
				"step Mine",
				"  collect 829 quest 153 -- Bandanas",
				"",
				"step Later",
				"  accept 5",
				"  collect 829 quest 153",
				"",
				"step Back",
				"  turnin 153",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [{ "t": "accept", "q": 153, "from": f("a", 7) }, { "t": "task", "q": 153, "task": 0, "from": f("a", 10) }, { "t": "accept", "q": 5, "from": f("a", 13) }, { "t": "turnin", "q": 153, "from": f("a", 17) }] }),
		..Case::default()
	};
	assert_eq!(run(&c, None).read("a").iter().filter(|l| l.contains("collect 829")).count(), 1);
}

#[test]
fn ender_camp_and_no_hearth_to_the_model_point() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-20",
				"zone Durotar",
				"",
				"step Inn",
				"  sethome \"Auberdine\"",
				"  accept 1003",
				"",
				"step Far",
				"  kill 9 quest 985.1",
				"",
				"step The Grove",
				"  collect 5414 quest 1003",
				"  turnin 1003",
				"",
			],
		)],
		world: json!({ "points": [[1, 1, -800, -800, 1411], [1, 1, 800, 800, 1411], [1, 1, 0, 0, 1411]], "zones": { "1411": "Durotar" }, "quests": [], "inns": [{ "name": "Auberdine", "pt": 0 }], "nodes": [] }),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1003, "pt": 0, "from": f("a", 8), "items": [{ "t": "bind", "inn": 0, "pt": 0, "used": true }] },
            { "t": "task", "q": 985, "task": 0, "pt": 1, "from": f("a", 11) },
            { "t": "task", "q": 1003, "task": 0, "pt": 0, "from": f("a", 14), "items": [{ "t": "hearth", "inn": 0, "to": 0, "innPt": 0 }] },
            { "t": "turnin", "q": 1003, "pt": 2, "from": f("a", 15) }
        ] }),
		npcs: json!({ "30": { "spawns": { "1411": { "f": "e", "pts": [[10, 10], [52, 50]] } } } }),
		items: json!({ "5414": { "drops": { "npc": { "30": 0.5 } } } }),
		..Case::default()
	};
	let elsewhere = area("Elsewhere", "Durotar", 0);
	let g = run(&c, Some(&elsewhere)).read("a");
	assert!(has(&g, "  collect 5414 quest 1003 @52.0,50.0 map 1411"), "{g:?}");
	assert!(!g.iter().any(|l| m(l, r"^\s+hearth\b")), "{g:?}");
}

#[test]
fn v1_travel_first_and_sourceless_items_and_level_lines() {
	let c = Case {
		files: vec![
			("start", vec!["guide t/start", "title S", "race Orc,Troll", "levels 30-35", "zone Durotar", "next t/shared", "", "step Den", "  accept 1", ""]),
			(
				"shared",
				vec![
					"guide t/shared",
					"title Shared",
					"levels 35-40",
					"zone Durotar",
					"",
					"step Inn",
					"  sethome \"Razor Hill\"",
					"  turnin 1",
					"  accept 2",
					"",
					"step Grind",
					"  level 36",
					"",
					"step Back",
					"  hearth \"Razor Hill\"",
					"  accept 3",
					"",
					"step Boat to Booty Bay",
					"  goto 10.0,10.0 \"Boat to Booty Bay\"",
					"",
					"step Bay",
					"  turnin 3",
					"  turnin 2",
					"",
				],
			),
		],
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 900, 900, 1411], [1, 1, 905, 905, 1411]], "zones": { "1411": "Durotar" }, "quests": [{ "id": 2, "objs": [{ "oi": 0, "type": "item", "id": 3388, "task": 0 }] }], "inns": [{ "name": "Razor Hill", "pt": 0 }, { "name": "Booty Bay", "pt": 1 }], "nodes": [] }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) },
            { "t": "turnin", "q": 1, "pt": 0, "from": f("shared", 8) },
            { "t": "accept", "q": 2, "pt": 0, "from": f("shared", 9), "items": [{ "t": "bind", "inn": 1, "pt": 1, "used": true }] },
            { "t": "accept", "q": 3, "pt": 1, "from": f("shared", 16) },
            { "t": "task", "q": 2, "task": 0, "pt": 2, "from": f("shared", 23), "items": [{ "t": "hearth", "inn": 1, "to": 2, "innPt": 1 }] },
            { "t": "turnin", "q": 3, "pt": 2, "from": f("shared", 22) },
            { "t": "turnin", "q": 2, "pt": 2, "from": f("shared", 23) }
        ] }),
		quests: json!({ "2": { "title": "Elixir", "objectives": [{ "type": "item", "id": 3388 }] } }),
		items: json!({ "3388": { "name": "Potion", "drops": {}, "vendors": [] } }),
		..Case::default()
	};
	let g = run(&c, None).read("shared");
	assert!(has(&g, "  level 36"));
	assert!(has(&g, "  hearth \"Razor Hill\" only Tauren,Undead,Skyborne"), "{g:?}");
	assert!(has(&g, "  goto 10.0,10.0 \"Boat to Booty Bay\" only Tauren,Undead,Skyborne"), "{g:?}");
	assert!(!g.iter().any(|l| m(l, r#"3388|"Booty Bay"$"#) && m(l, "collect|hearth")), "{g:?}");
}

#[test]
fn v1_flight_in_the_arrival_step_is_flown_for_everyone() {
	let c = Case {
		files: vec![
			("start", vec!["guide t/start", "title S", "race Orc,Troll", "levels 20-25", "zone Hillsbrad Foothills", "next t/shared", "", "step Den", "  accept 1", ""]),
			(
				"shared",
				vec![
					"guide t/shared",
					"title Shared",
					"levels 25-30",
					"zone Hillsbrad Foothills",
					"",
					"step Tarren Mill",
					"  turnin 1",
					"",
					"step Faranell",
					"  zone Undercity",
					"  fly \"Undercity\"",
					"  turnin 2",
					"",
					"step Trainer",
					"  accept 3",
					"",
				],
			),
		],
		world: json!({ "points": [[0, 0, 0, 0, 1424], [0, 0, 5, 5, 1424], [0, 0, 3000, 3000, 1458], [0, 0, 3010, 3010, 1458]], "zones": { "1424": "Hillsbrad Foothills", "1458": "Undercity" }, "quests": [], "inns": [], "nodes": [{ "kind": "fp", "name": "Tarren Mill", "pt": 1 }, { "kind": "fp", "name": "Undercity", "pt": 3 }] }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) }, { "t": "turnin", "q": 1, "pt": 0, "from": f("shared", 7) },
            { "t": "turnin", "q": 2, "pt": 2, "from": f("shared", 12), "items": [{ "t": "network", "from": 0, "to": 2 }] }, { "t": "accept", "q": 3, "pt": 2, "from": f("shared", 15) }
        ] }),
		frames: json!({ "era": { "1424": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 }, "1458": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 } } }),
		..Case::default()
	};
	let g = run(&c, None).read("shared");
	assert_eq!(g.iter().filter(|l| l.contains("fly \"Undercity\"")).cloned().collect::<Vec<_>>().join("|"), "  fly \"Undercity\"", "{g:?}");
}

#[test]
fn bought_or_bag_turnin_task_puts_no_step_at_the_model_place() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 20-30",
				"zone Duskwood",
				"",
				"step Darkshire",
				"  accept 174",
				"  buy 4371 x1 npc 3133",
				"",
				"step Stonetalon",
				"  zone Stonetalon Mountains",
				"  accept 1093",
				"  turnin 1093",
				"",
				"step Darkshire again",
				"  zone Duskwood",
				"  turnin 174",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 174, "from": f("a", 7) }, { "t": "accept", "q": 1093, "from": f("a", 12) },
            { "t": "task", "q": 174, "task": 0, "from": f("a", 17), "items": [{ "t": "network", "from": 0, "to": 1 }] },
            { "t": "turnin", "q": 1093, "from": f("a", 13) }, { "t": "turnin", "q": 174, "from": f("a", 17) }
        ] }),
		world: json!({ "points": [[0, 0, 0, 0, 1431], [1, 1, 0, 0, 1442]], "quests": [{ "id": 174, "objs": [{ "oi": 0, "type": "item", "id": 4371, "task": 0 }] }] }),
		quests: json!({ "174": { "objectives": [{ "type": "item", "id": 4371 }] } }),
		items: json!({ "4371": { "drops": { "npc": { "4073": 0.02 } }, "vendors": [3133] } }),
		..Case::default()
	};
	assert_eq!(
		pick(&run(&c, None).read("a"), r"^step|^\s+(accept|turnin)"),
		vec!["step Darkshire", "  accept 174", "step Stonetalon", "  accept 1093", "  turnin 1093", "step Darkshire again", "  turnin 174"]
	);
}

#[test]
fn item_started_accept_written_with_its_steps_next_event() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 20-30",
				"zone Duskwood",
				"",
				"step Calor",
				"  accept 173",
				"",
				"step Worgen",
				"  kill 533 quest 173.1",
				"",
				"step Calor back",
				"  turnin 173",
				"",
				"step Vul'Gol",
				"  accept 96138 optional",
				"  kill 212 quest 96138.1 optional",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 173, "from": f("a", 7) }, { "t": "task", "q": 173, "task": 0, "from": f("a", 10) }, { "t": "accept", "q": 96138, "from": f("a", 16) },
            { "t": "turnin", "q": 173, "from": f("a", 13) }, { "t": "task", "q": 96138, "task": 0, "from": f("a", 17) }
        ] }),
		world: json!({ "points": [], "quests": [{ "id": 96138, "objs": [{ "oi": 0, "type": "kill", "id": 212, "task": 0 }] }] }),
		quests: json!({ "96138": { "title": "Merrick's Bow", "start": { "item": [1] } } }),
		..Case::default()
	};
	assert_eq!(
		pick(&run(&c, None).read("a"), r"^step|^\s+(accept|turnin|kill)"),
		vec!["step Calor", "  accept 173", "step Worgen", "  kill 533 quest 173.1", "step Calor back", "  turnin 173", "step Vul'Gol", "  accept 96138 optional", "  kill 212 quest 96138.1 optional"]
	);
}

#[test]
fn hearth_before_v1_steps_flight_after_zeppelin_and_training_stop_travel() {
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 30-40",
				"zone Stranglethorn Vale",
				"",
				"step Venture camp",
				"  collect 4106 quest 213",
				"",
				"step Fly to Grom'gol",
				"  fly \"Grom'gol\"",
				"  goto 50.2,49.8 \"Zeppelin to the Undercity\"",
				"",
				"step Trainers",
				"  only Warrior,Rogue",
				"  train class",
				"",
				"step Fly to Tarren Mill",
				"  fly \"Tarren Mill\"",
				"",
				"step Arathi",
				"  accept 676",
				"",
			],
		)],
		world: json!({ "points": [[0, 0, -1000, -1000, 1434], [0, 0, 20, 20, 1434], [0, 0, 3000, 3000, 1417], [0, 0, 5000, 5000, 1424]], "zones": { "1434": "Stranglethorn Vale", "1417": "Arathi Highlands", "1424": "Hillsbrad Foothills" }, "quests": [], "inns": [{ "name": "Grom'gol Base Camp", "pt": 1 }], "nodes": [{ "kind": "fp", "name": "Grom'gol", "pt": 1 }, { "kind": "fp", "name": "Tarren Mill", "pt": 3 }] }),
		route: json!({ "diff": {}, "order": [
            { "t": "task", "q": 213, "task": 0, "pt": 0, "from": f("a", 7), "items": [{ "t": "bind", "inn": 0, "pt": 0, "used": true }] },
            { "t": "train", "pt": 3, "from": "train stop", "items": [{ "t": "network", "from": 0, "to": 3 }] },
            { "t": "accept", "q": 676, "pt": 2, "from": f("a", 21), "items": [{ "t": "hearth", "inn": 0, "to": 1, "innPt": 1 }, { "t": "network", "from": 1, "to": 2 }] }
        ] }),
		frames: json!({ "era": { "1434": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 }, "1417": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 }, "1424": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 } } }),
		..Case::default()
	};
	let g = pick(&run(&c, None).read("a"), r"^step|^\s+(hearth|fly|goto|train|accept|collect)");
	let h = idx(&g, "  hearth \"Grom'gol Base Camp\"");
	let z = g.iter().position(|l| l.contains("Zeppelin to the Undercity")).map_or(-1, |i| i as i64);
	assert!(h > 0 && h < z, "{g:?}");
	assert!(has(&g, "  fly \"Tarren Mill\""), "{g:?}");
	assert_eq!(g.iter().filter(|l| l.contains("train class")).count(), 1, "{g:?}");
	assert!(!g.iter().any(|l| m(l, r#""Arathi Highlands"|Grom'gol flight master"#)), "{g:?}");
}

#[test]
fn far_goto_only_step_is_the_others_and_cave_mouth_stays() {
	let c = Case {
		files: vec![
			("start", vec!["guide t/start", "title S", "race Human", "levels 50-55", "zone Silithus", "next t/shared", "", "step Hold", "  accept 1", ""]),
			(
				"shared",
				vec![
					"guide t/shared",
					"title Shared",
					"levels 55-60",
					"zone Silithus",
					"",
					"step Into Silithus",
					"  goto 10.0,10.0 \"Toward the pass\"",
					"",
					"step Cave",
					"  goto 50.5,50.5 \"Cave mouth\"",
					"",
					"step Cenarion Hold",
					"  turnin 1",
					"",
				],
			),
		],
		world: json!({ "points": [[1, 1, 0, 0, 1451], [1, 1, 10, 10, 1451]], "zones": { "1451": "Silithus" }, "quests": [], "inns": [], "nodes": [] }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [{ "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) }, { "t": "turnin", "q": 1, "pt": 1, "from": f("shared", 13) }] }),
		frames: json!({ "era": { "1451": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		..Case::default()
	};
	assert_eq!(pick(&run(&c, None).read("shared"), r"^\s+goto"), vec!["  goto 10.0,10.0 \"Toward the pass\" only Dwarf,Gnome,NightElf,Skyborne", "  goto 50.5,50.5 \"Cave mouth\""]);
}

#[test]
fn v1_flight_not_at_the_master_becomes_their_own_flight_step() {
	let c = Case {
		files: vec![
			(
				"start",
				vec![
					"guide t/start",
					"title S",
					"race Human",
					"levels 30-35",
					"zone Duskwood",
					"next t/shared",
					"",
					"step Den",
					"  accept 1",
					"  getfp \"Darkshire\"",
					"  getfp \"Stormwind\"",
					"  getfp \"Southshore\"",
					"",
				],
			),
			("shared", vec!["guide t/shared", "title Shared", "levels 35-40", "zone Duskwood", "", "step Field", "  turnin 1", "", "step Darkshire", "  fly \"Southshore\"", "  accept 2", ""]),
		],
		world: json!({ "points": [[0, 0, -900, -900, 1431], [0, 0, 0, 0, 1431], [0, 0, 3000, 3000, 1424], [0, 0, 3005, 3005, 1424], [0, 0, 1500, 1500, 1453]], "zones": { "1431": "Duskwood", "1424": "Hillsbrad Foothills", "1453": "Stormwind City" }, "quests": [], "inns": [], "nodes": [{ "kind": "fp", "name": "Darkshire", "pt": 1 }, { "kind": "fp", "name": "Southshore", "pt": 3 }, { "kind": "fp", "name": "Stormwind", "pt": 4 }] }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [{ "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) }, { "t": "turnin", "q": 1, "pt": 0, "from": f("shared", 7) }, { "t": "accept", "q": 2, "pt": 2, "from": f("shared", 11) }] }),
		frames: json!({ "era": { "1431": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 }, "1424": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 }, "1453": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 } } }),
		..Case::default()
	};
	let g = pick(&run(&c, None).read("shared"), r"^step|^\s+(fly|goto|only|accept)");
	assert!(has(&g, "  fly \"Southshore\" only Dwarf,Gnome,NightElf,Skyborne"), "{g:?}");
	let fi = idx(&g, "step Fly to Southshore");
	assert!(fi > 0, "{g:?}");
	let fi = fi as usize;
	assert!(g[fi + 1] == "  only Human" && g[fi + 2].contains("\"Darkshire flight master\"") && g[fi + 3] == "  fly \"Southshore\"", "{g:?}");
	assert!(idx(&g, "  accept 2") > fi as i64, "{g:?}");
}

#[test]
fn far_boat_goto_is_the_others_and_no_flight_to_where_they_are() {
	let c = Case {
		files: vec![
			("start", vec!["guide t/start", "title S", "race Orc,Troll", "levels 35-40", "zone Stranglethorn Vale", "next t/shared", "", "step Bay", "  accept 1", ""]),
			(
				"shared",
				vec![
					"guide t/shared",
					"title Shared",
					"levels 40-45",
					"zone The Barrens",
					"",
					"step Boat to Booty Bay",
					"  goto 10.0,10.0 \"Boat to Booty Bay\"",
					"",
					"step Fly to Booty Bay",
					"  zone Stranglethorn Vale",
					"  fly \"Booty Bay\"",
					"",
					"step Booty Bay",
					"  turnin 1",
					"",
				],
			),
		],
		world: json!({ "points": [[0, 0, 0, 0, 1434], [0, 0, 10, 10, 1434], [0, 0, 900, 900, 1434]], "zones": { "1434": "Stranglethorn Vale", "1413": "The Barrens" }, "quests": [], "inns": [], "nodes": [{ "kind": "fp", "name": "Booty Bay", "pt": 1 }] }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [{ "t": "accept", "q": 1, "pt": 2, "from": f("start", 9) }, { "t": "turnin", "q": 1, "pt": 0, "from": f("shared", 14), "items": [{ "t": "network", "from": 2, "to": 0 }] }] }),
		frames: json!({ "era": { "1434": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		..Case::default()
	};
	assert_eq!(
		pick(&run(&c, None).read("shared"), r"^\s+(goto|fly)"),
		vec!["  goto 10.0,10.0 \"Boat to Booty Bay\" only Tauren,Undead,Skyborne", "  fly \"Booty Bay\" only Tauren,Undead,Skyborne", "  goto 50.0,50.0 \"Stranglethorn Vale\""]
	);
}

#[test]
fn v1_flight_in_a_step_for_some_stays() {
	let c = Case {
		files: vec![
			(
				"start",
				vec![
					"guide t/start",
					"title S",
					"race Human",
					"levels 20-25",
					"zone Stormwind City",
					"next t/shared",
					"",
					"step Den",
					"  accept 1",
					"  getfp \"Stormwind\"",
					"  getfp \"Sentinel Hill\"",
					"",
				],
			),
			(
				"shared",
				vec![
					"guide t/shared",
					"title Shared",
					"levels 25-30",
					"zone Westfall",
					"",
					"step Pendant",
					"  only NightElf,Druid",
					"  fly \"Sentinel Hill\"",
					"  collect 15882 x1",
					"",
					"step Field",
					"  turnin 1",
					"",
				],
			),
		],
		world: json!({ "points": [[0, 0, -2000, -2000, 1436], [0, 0, 0, 0, 1453], [0, 0, 900, 900, 1436]], "zones": { "1436": "Westfall", "1453": "Stormwind City" }, "quests": [], "inns": [], "nodes": [{ "kind": "fp", "name": "Stormwind", "pt": 1 }, { "kind": "fp", "name": "Sentinel Hill", "pt": 2 }] }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [{ "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) }, { "t": "turnin", "q": 1, "pt": 0, "from": f("shared", 12) }] }),
		frames: json!({ "era": { "1436": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 }, "1453": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 } } }),
		..Case::default()
	};
	let g = run(&c, None).read("shared");
	let i = idx(&g, "step Pendant") as usize;
	assert_eq!(g[i..i + 4], ["step Pendant", "  only NightElf,Druid", "  fly \"Sentinel Hill\"", "  collect 15882 x1"], "{g:?}");
}

#[test]
fn flight_path_learnt_by_v1_not_written_again() {
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 20-30", "zone Thunder Bluff", "", "step Thunder Bluff", "  getfp \"Thunder Bluff\" npc 2995", "", "step Earthen Ring", "  accept 96241", ""],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1456]], "zones": { "1456": "Thunder Bluff" }, "quests": [], "inns": [], "nodes": [{ "kind": "fp", "name": "Thunder Bluff", "pt": 0 }] }),
		route: json!({ "diff": {}, "order": [{ "t": "accept", "q": 96241, "pt": 0, "from": f("a", 10), "items": [{ "t": "getfp", "node": 0 }] }] }),
		..Case::default()
	};
	assert_eq!(run(&c, None).read("a").iter().filter(|l| l.contains("getfp")).count(), 1);
}

#[test]
fn reminder_of_an_objective_stays_in_its_step_before_the_turn_in() {
	// The Raptor Horns among the Dry Hills lions (#274): the route works the horns later, but the
	// Dry Hills step, visited before the turn-in, keeps v1's reminder, beside Vrang's hides.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-20",
				"zone Durotar",
				"",
				"step Mebok",
				"  accept 865",
				"",
				"step Raptors",
				"  collect 5055 quest 865.1",
				"",
				"step The Dry Hills",
				"  accept 95494",
				"  collect 269715 quest 95494.1",
				"  collect 5055 quest 865.1 @44.7,14.3 -- if still open",
				"  turnin 95494",
				"",
				"step Other",
				"  accept 7",
				"",
				"step Ratchet",
				"  turnin 865",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [{ "t": "accept", "q": 865, "from": f("a", 7) }, { "t": "accept", "q": 95494, "from": f("a", 13) }, { "t": "task", "q": 95494, "task": 0, "from": f("a", 14) }, { "t": "accept", "q": 7, "from": f("a", 19) }, { "t": "turnin", "q": 95494, "from": f("a", 16) }, { "t": "task", "q": 865, "task": 0, "from": f("a", 10) }, { "t": "turnin", "q": 865, "from": f("a", 22) }] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let hides = g.iter().position(|l| l == "  collect 269715 quest 95494.1").unwrap();
	assert!(g[hides + 1].starts_with("  collect 5055 quest 865.1 @44.7,14.3 optional"), "{g:?}");
}

#[test]
fn follow_up_of_an_optional_start_the_route_leaves_out_stays() {
	// Manhunt (147) after the rare Gold Pickup Schedule (123, not in the route): #553.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 1-12",
				"zone Elwynn Forest",
				"",
				"step Edge",
				"  accept 11",
				"  accept 123 optional",
				"",
				"step Dughan",
				"  turnin 11",
				"",
				"step Manhunt",
				"  when turnedin 123",
				"  accept 147",
				"",
			],
		)],
		route: json!({ "diff": { "dropped": [147] }, "order": [{ "t": "accept", "q": 11, "from": f("a", 7) }, { "t": "turnin", "q": 11, "from": f("a", 11) }] }),
		..Case::default()
	};
	assert!(run(&c, None).read("a").iter().any(|l| l == "  accept 147"));
}

#[test]
fn level_grind_keeps_the_routes_fraction() {
	let c = |on: bool| Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 10-20", "zone The Barrens", "", "step Grind", "  level 16 -- grind on raptors", "", "step Hub", "  accept 1", ""])],
		route: json!({ "diff": {}, "order": [{ "t": "level", "lvl": 15.55, "level": 16, "from": f("a", 7) }, { "t": "accept", "q": 1, "from": f("a", 10) }] }),
		quests: json!({ "1": { "title": "One", "minLevel": 15 } }),
		level_fraction: on,
		..Case::default()
	};
	assert!(has(&run(&c(false), None).read("a"), "  level 16 -- grind on raptors"));
	assert!(has(&run(&c(true), None).read("a"), "  level 15.55 -- grind on raptors"));
	// Not below the level an accept after it needs.
	let mut hard = c(true);
	hard.quests = json!({ "1": { "title": "One", "minLevel": 16 } });
	assert!(has(&run(&hard, None).read("a"), "  level 16 -- grind on raptors"));
}

#[test]
fn level_line_whole_percent() {
	use forge_writer::apply::level_line;
	// At least a tenth of a level early; whole percent; 0% and 100% are whole levels.
	assert_eq!(level_line("  level 16", 15.85), "  level 15.85");
	assert_eq!(level_line("  level 28", 27.5), "  level 27.5");
	assert_eq!(level_line("  level 16 -- grind", 15.003), "  level 15 -- grind");
	assert_eq!(level_line("  level 16", 15.91), "  level 16");
	assert_eq!(level_line("  level 16", 14.2), "  level 16");
}

#[test]
fn route_legs_write_the_sims_own_path() {
	// The sim flew Crossroads -> Orgrimmar for this leg: that flight, not the writer's guess.
	let c = |legs: bool| Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Inn", "  accept 1", "", "step Far", "  turnin 1", ""])],
		world: travel_world(),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7), "items": [{ "t": "getfp", "node": 1 }, { "t": "getfp", "node": 0 }] },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 10), "items": [if legs { json!({ "t": "network", "from": 0, "to": 1, "legs": [{ "k": "fly", "from": 1, "to": 0 }] }) } else { json!({ "t": "network", "from": 0, "to": 1 }) }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let without = pick(&run(&c(false), None).read("a"), r"^\s+fly");
	assert_ne!(without, vec!["  fly \"Orgrimmar\""]);
	assert_eq!(pick(&run(&c(true), None).read("a"), r"^\s+fly"), vec!["  fly \"Orgrimmar\""]);
}

#[test]
fn route_legs_drop_v1_travel_the_route_does_not_make() {
	// v1 flies to Ratchet before the turn-in; the route flies Orgrimmar -> Crossroads for it: the route's
	// flight is written and v1's is the other races'.
	let mut world = travel_world();
	world["nodes"].as_array_mut().unwrap().push(json!({ "kind": "fp", "name": "Ratchet", "pt": 1 }));
	let c = |on: bool| Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Hub", "  accept 1", "", "step Fly", "  fly \"Ratchet\"", "", "step Camp", "  turnin 1", ""])],
		world: world.clone(),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 2, "from": f("a", 7), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }, { "t": "getfp", "node": 2 }] },
            { "t": "turnin", "q": 1, "pt": 3, "from": f("a", 13), "items": [{ "t": "network", "from": 2, "to": 3 }] }
        ] }),
		route_travel: on,
		..Case::default()
	};
	let old = pick(&run(&c(false), None).read("a"), r"^\s+fly");
	assert_eq!(old, vec!["  fly \"Ratchet\""], "{old:?}");
	let new = pick(&run(&c(true), None).read("a"), r"^\s+fly");
	assert_eq!(new, vec!["  fly \"Crossroads\"", "  fly \"Ratchet\" only Troll,Tauren,Undead,Skyborne"], "{new:?}");
}

#[test]
fn route_legs_bring_a_class_detour_back() {
	// v1's Shamans fly to their Orgrimmar trainer between two route items at the Crossroads: they fly
	// back before the route goes on.
	let c = |on: bool| Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 1-5",
				"zone Durotar",
				"",
				"step Hub",
				"  accept 1",
				"",
				"step Trainer",
				"  only Shaman",
				"  fly \"Orgrimmar\"",
				"  train class",
				"",
				"step Camp",
				"  turnin 1",
				"",
			],
		)],
		world: travel_world(),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 3, "from": f("a", 7), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }] },
            { "t": "turnin", "q": 1, "pt": 3, "from": f("a", 15) }
        ] }),
		route_travel: on,
		..Case::default()
	};
	let back = |t: &[String]| t.iter().position(|l| l == "step Back to Crossroads");
	assert_eq!(back(&run(&c(false), None).read("a")), None);
	let t = run(&c(true), None).read("a");
	let i = back(&t).unwrap_or_else(|| panic!("{t:?}"));
	assert_eq!(t[i + 1..i + 4], ["  only Shaman", "  zone Durotar", "  goto 50.5,49.5 \"Orgrimmar flight master\""]);
	assert_eq!(t[i + 4], "  fly \"Crossroads\"");
	assert!(i < t.iter().position(|l| l.starts_with("  turnin 1")).unwrap());
}

#[test]
fn a_comment_line_inside_a_step_keeps_the_step_whole() {
	// A commented-out line (`# dropped: ...` at column 0) inside a step: the step goes on past it,
	// as the compiler reads it. Before, the rest of the step (accept 2) fell out of it as loose text
	// and followed the next step, so the step that works quest 2 came before its accept.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 1-5",
				"zone Durotar",
				"",
				"step Town",
				"  accept 1",
				"# dropped:   accept 9",
				"  accept 2",
				"",
				"step Camp",
				"  turnin 1",
				"",
				"step Mine",
				"  complete 2",
				"  turnin 2",
				"",
			],
		)],
		world: travel_world(),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 0, "from": f("a", 9) },
			{ "t": "complete", "q": 2, "pt": 1, "from": f("a", 15) },
			{ "t": "turnin", "q": 2, "pt": 1, "from": f("a", 16) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 12) }
		] }),
		..Case::default()
	};
	let out = run(&c, None).read("a");
	let at = |l: &str| idx(&out, l);
	assert!(at("  accept 2") >= 0 && at("  accept 2") < at("  complete 2"), "{out:#?}");
	// The comment stays in its step, indented (a column-0 comment would end the step for the passes
	// over the written text).
	assert!(at("step Town") < at("  # dropped:   accept 9") && at("  # dropped:   accept 9") < at("step Mine"), "{out:#?}");
}

#[test]
fn a_live_spawn_is_written_in_its_own_frame() {
	// A target that spawns in the live frame on a map with both frames: its pin keeps the spawn's own
	// coordinates and `live`. Converted to Era coordinates it matched none of the target's spawns in the
	// compiler (spawns are looked up in the pin's frame), and the goal showed one pin instead of the pin
	// with every other place the target spawns.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Hub", "  accept 1", ""])],
		route: json!({ "diff": { "added": [5] }, "order": [
			{ "t": "accept", "q": 1, "from": f("a", 7) },
			{ "t": "accept", "q": 5, "pt": 0, "from": "inserted" }, { "t": "task", "q": 5, "task": 0, "pt": 0, "from": "inserted" }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411]], "zones": { "1411": "Durotar" }, "quests": [{ "id": 5, "objs": [{ "oi": 0, "type": "kill", "id": 20, "task": 0 }] }] }),
		quests: json!({ "5": { "title": "Five", "start": { "npc": [8] }, "objectives": [{ "type": "kill", "id": 20 }] } }),
		npcs: json!({ "8": { "name": "Eight", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } }, "20": { "spawns": { "1411": { "f": "l", "pts": [[10, 10], [52, 49]] } } } }),
		frames: json!({
			"era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } },
			"forever": { "1411": { "top": 500, "bottom": -500, "left": -500, "right": 500, "c": 1 } }
		}),
		..Case::default()
	};
	let text = run(&c, None).text("a");
	assert!(m(&text, r"kill 20 quest 5\.1 @52\.0,49\.0 map 1411 live"), "{text}");
}
