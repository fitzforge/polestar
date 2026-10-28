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

/// The faction's shared route: the guide after the join is the same order for every start, so it is
/// written for everyone (a plain sethome and hearth, no `only` split), and two starts of the faction
/// write it byte for byte the same.
#[test]
fn shared_route_tail_is_written_for_everyone() {
	let shared = vec!["guide t/shared", "title Shared", "levels 5-9", "zone Durotar", "", "step Inn", "  accept 2", "", "step Far", "  turnin 2", ""];
	let case = |head: [&'static str; 6], joined: bool| {
		let mut route = json!({ "faction": "Horde", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 2, "from": f("start", 9) }, { "t": "turnin", "q": 1, "pt": 2, "from": f("start", 10) },
            { "t": "accept", "q": 2, "pt": 0, "from": f("shared", 7), "items": [{ "t": "bind", "inn": 0, "pt": 0, "used": true }] },
            { "t": "turnin", "q": 2, "pt": 1, "from": f("shared", 10), "items": [{ "t": "hearth", "inn": 0, "to": 1 }] }
        ] });
		if joined {
			route["shared"] = json!({ "canonical": "Orc", "joinAfter": "horde/02-the-barrens" });
		}
		Case { files: vec![("start", lines(&head, &["", "step Den", "  accept 1", "  turnin 1", ""])), ("shared", shared.clone())], world: travel_world(), route, ..Case::default() }
	};
	let split = run(&case(START_OT, false), None).read("shared");
	assert!(split.iter().any(|l| l.contains(" only ")), "without the shared route the tail is split per race: {split:?}");
	let orc = run(&case(START_OT, true), None).read("shared");
	assert_eq!(pick(&orc, r"^\s+(sethome|hearth|only)|\bonly\b"), vec!["  sethome \"Razor Hill\"", "  hearth \"Razor Hill\""]);
	let tauren = ["guide t/start", "title S", "race Tauren", "levels 1-5", "zone Durotar", "next t/shared"];
	assert_eq!(run(&case(tauren, true), None).read("shared"), orc, "two starts write the tail the same");
	// (`joinAt`: the tail starts at the join guide's first step, its own file included.)
	let mut at = case(START_OT, true);
	at.route["shared"] = json!({ "canonical": "Orc", "joinAt": "shared" });
	assert_eq!(run(&at, None).read("shared"), orc);
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

/// A route's deathskip (forge-sim's `deathskip` item, `--deathskips`) is a `die` step at its
/// graveyard's Spirit Healer before the way there, with a tip naming where to die; the way there
/// stays everyone's, so a player without deathskips passes the step and walks.
#[test]
fn route_deathskip_is_a_die_step_before_the_way() {
	let mut world = travel_world();
	world["graveyards"] = json!([{ "id": 32, "name": "Razor Hill", "pt": 3, "loc": [1, 490, 490, 0], "maps": [1411] }]);
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Near", "  accept 1", "", "step Far", "  turnin 1", ""])],
		world,
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 10), "items": [{ "t": "deathskip", "gy": 0, "spot": 2, "npc": 3098, "pt": 3, "to": 1 }] }
        ] }),
		npcs: json!({ "3098": { "id": 3098, "name": "Mottled Boar", "level": 2 } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let die = g.iter().position(|l| l.starts_with("  die \"Razor Hill\" @")).unwrap_or_else(|| panic!("{g:#?}"));
	assert!(g[..die].iter().rev().find(|l| l.starts_with("step ")).is_some_and(|l| l == "step Deathskip to Razor Hill"), "{g:#?}");
	assert!(g[..die].iter().rev().take_while(|l| !l.starts_with("step ")).any(|l| l.starts_with("  tip Die to the mobs at ") && l.contains("(Mottled Boar)")), "{g:#?}");
	assert!(die > g.iter().position(|l| l == "  accept 1").unwrap() && die < g.iter().position(|l| l == "  turnin 1").unwrap(), "{g:#?}");
	// The coordinates are the healer's (point 3), as an arrow there and lint's check read them.
	let at = |p: &str| g.iter().find(|l| l.starts_with(p)).map(|l| l.split('@').nth(1).unwrap_or("").to_string());
	assert!(at("  die ").is_some_and(|c| c.ends_with("map 1411")), "{g:#?}");
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
fn class_quest_line_with_its_own_only_mid_line_gets_no_second() {
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
				"  accept 1535 only Shaman",
				"  turnin 1861 only Mage choose 9513 7508",
				"",
				"step Field",
				"  kill 9 quest 1.1",
				"  turnin 1",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [{ "t": "accept", "q": 1, "from": f("a", 7) }, { "t": "task", "q": 1, "task": 0, "from": f("a", 12) }, { "t": "turnin", "q": 1, "from": f("a", 13) }] }),
		quests: json!({ "1535": { "title": "Brine", "classes": 64 }, "1861": { "title": "Mirror Lake", "classes": 128 } }),
		..Case::default()
	};
	let out = run(&c, None).read("a");
	for l in pick(&out, r"^\s+(accept 1535|turnin 1861)") {
		assert_eq!(l.matches(" only ").count(), 1, "{l}");
	}
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
			"step Lake",
			"  collect 1019 quest 83.1",
			"step Murlocs",
			"  collect 2239 quest 147.1",
			// The head right before the accept it starts, where the route takes it (#221).
			"  collect 247826 x1 optional",
			"  accept 91740 optional"
		]
	);
}

#[test]
fn no_ride_below_riding_level() {
	let c = Case {
		files: vec![
			("a", vec!["guide t/a", "title A", "levels 30-40", "zone Arathi Highlands", "next t/b", "", "step Biggs", "  accept 1", "", "step Harborage", "  accept 3", ""]),
			("b", vec!["guide t/b", "title B", "levels 40-50", "zone Arathi Highlands", "", "step Webb", "  tip Ride back west along the road.", "  turnin 1", "  note Learn to ride: the riding trainer is by the stables.", "", "step Later", "  accept 2", ""]),
		],
		route: json!({ "diff": {}, "order": [{ "t": "accept", "q": 1, "from": f("a", 8) }, { "t": "turnin", "q": 1, "from": f("b", 8) }, { "t": "accept", "q": 3, "from": f("a", 11) }, { "t": "accept", "q": 2, "from": f("b", 12) }] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(has(&g, "  tip Head back west along the road."), "{g:?}");
	// (Learning to ride stays about riding.)
	assert!(has(&g, "  note Learn to ride: the riding trainer is by the stables."), "{g:?}");
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
	assert!(!g.iter().any(|l| m(l, r"3388") && m(l, "collect")), "{g:?}");
	// (The sourceless task is left to the turn-in; its hearth to Booty Bay is the route's way to the
	// turn-in after it.)
	assert!(idx(&g, "  hearth \"Booty Bay\"") >= 0 && idx(&g, "  hearth \"Booty Bay\"") < idx(&g, "  turnin 3"), "{g:?}");
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
		route: json!({ "diff": {}, "order": [{ "t": "level", "lvl": 15.1, "level": 16, "target": 15.55, "from": f("a", 7) }, { "t": "accept", "q": 1, "from": f("a", 10) }] }),
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
	// The target, not the level the grind starts at (c9 Un'Goro: `level 49.09` for v1's grind to 50,
	// then two levels at the next grind).
	let mut whole = c(true);
	whole.route = json!({ "diff": {}, "order": [{ "t": "level", "lvl": 15.09, "level": 16, "target": 16.0, "from": f("a", 7) }, { "t": "accept", "q": 1, "from": f("a", 10) }] });
	assert!(has(&run(&whole, None).read("a"), "  level 16 -- grind on raptors"));
}

#[test]
fn inserted_grind_top_up_is_a_step_of_its_own_at_the_camp_before_the_hand_ins() {
	let accept = json!({ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) });
	let task = json!({ "t": "task", "q": 1, "task": 0, "pt": 1, "from": f("a", 10) });
	let level = json!({ "t": "level", "lvl": 12.2, "target": 12.4, "pt": 1, "from": "inserted" });
	let turnin = json!({ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 13) });
	let c = |order: Vec<Value>| Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 10-20", "zone Durotar", "", "step Hub", "  accept 1", "", "step Camp", "  kill 20 quest 1.1", "", "step Hub again", "  turnin 1", ""])],
		route: json!({ "diff": {}, "order": order }),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, -500, 500, 1411]], "zones": { "1411": "Durotar" }, "quests": [{ "id": 1, "objs": [{ "oi": 0, "type": "kill", "id": 20, "task": 0 }] }] }),
		quests: json!({ "1": { "title": "One", "start": { "npc": [8] }, "end": { "npc": [8] }, "objectives": [{ "type": "kill", "id": 20 }] } }),
		npcs: json!({ "8": { "name": "Eight", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } }, "20": { "name": "Mottled Boar", "spawns": { "1411": { "f": "e", "pts": [[75, 75]] } } } }),
		..Case::default()
	};
	assert!(!run(&c(vec![accept.clone(), task.clone(), turnin.clone()]), None).text("a").contains("level 12"));
	let r = run(&c(vec![accept, task, level, turnin]), Some(&area("Razor Hill", "Durotar", 1411)));
	let text = r.text("a");
	assert!(
		m(
			&text,
			r#"step Camp\n {2}kill 20 quest 1\.1\n\nstep Level 12\.4\n( {2}zone Durotar\n)? {2}when level<12\.4\n {2}tip Top up here to level 12\.4 before the hand-ins at Razor Hill: they take you to level 13\.\n {2}goto 75\.0,75\.0 map 1411 "Mottled Boar"\n {2}level 12\.4 +-- grind on Mottled Boar\n\nstep Hub again"#
		),
		"{text}"
	);
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

#[test]
fn class_step_turnin_of_a_quest_the_route_hands_in_elsewhere_stays() {
	// v1 hands Return to Nessa in twice: in a step for all but Druids, and later in the Druids' own
	// step (#402): the route names the first; the Druids' line stays.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 1-12",
				"zone Teldrassil",
				"",
				"step Auberdine",
				"  accept 6343",
				"",
				"step Return to Nessa",
				"  only !Druid",
				"  turnin 6343",
				"",
				"step Back to Darnassus",
				"  only Druid",
				"  turnin 6343",
				"  turnin 5931",
				"",
				"step After",
				"  accept 7",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 6343, "from": f("a", 7) }, { "t": "turnin", "q": 6343, "from": f("a", 11) },
            { "t": "accept", "q": 7, "from": f("a", 20) }
        ] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert_eq!(g.iter().filter(|l| l.trim_start().starts_with("turnin 6343")).count(), 2, "{g:?}");
}

/// Durotar (Razor Hill flight master at point 2, Thunder Bluff's at point 4) and the Barrens
/// (Crossroads at point 3), one continent.
fn two_zone_world() -> Value {
	json!({
		"points": [[1, 1, 0, 0, 1411], [1, 1, 500, 500, 1413], [1, 1, 10, 10, 1411], [1, 1, 490, 490, 1413], [1, 1, -500, -500, 1411]],
		"zones": { "1411": "Durotar", "1413": "The Barrens" }, "quests": [],
		"nodes": [{ "kind": "fp", "name": "Razor Hill", "pt": 2 }, { "kind": "fp", "name": "Crossroads", "pt": 3 }, { "kind": "fp", "name": "Thunder Bluff", "pt": 4 }]
	})
}

fn two_zone_frames() -> Value {
	json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } })
}

#[test]
fn a_class_detour_comes_back_before_everyones_walk_on() {
	// A9 (Feralas): the Druids fly off to their trainer on the route's way; they fly back before
	// everyone's walk into the next zone, not after it.
	let c = Case {
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
				"step Vendor",
				"  vendor nearest",
				"",
				"step Trainer",
				"  only Druid",
				"  fly \"Thunder Bluff\"",
				"  train class",
				"",
				"step Camp",
				"  zone The Barrens",
				"  turnin 1",
				"",
			],
		)],
		world: two_zone_world(),
		frames: two_zone_frames(),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 2, "from": f("a", 7), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }, { "t": "getfp", "node": 2 }] },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 19), "items": [{ "t": "network", "from": 2, "to": 1, "legs": [{ "k": "walk", "to": 1 }] }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (back, walk) = (idx(&g, "step Back to Durotar"), idx(&g, "step The Barrens"));
	assert!(back >= 0 && walk > back, "{g:#?}");
	assert_eq!(g[back as usize + 1], "  only Druid");
}

#[test]
fn the_routes_boat_is_the_last_thing_at_the_dock_town() {
	// A15 (Auberdine): v1's step ends with its boat goto, the route does more in town after it, then
	// takes the boat itself: one boat goto, after the town's last goal.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Orc,Troll,Tauren,Undead,Skyborne",
				"levels 1-5",
				"zone Durotar",
				"",
				"step Town",
				"  accept 1",
				"  accept 2",
				"  goto 55.0,45.0 \"Boat to Stormwind\"",
				"",
				"step Inn",
				"  turnin 2",
				"",
				"step Stormwind",
				"  zone Stormwind City",
				"  turnin 1",
				"",
			],
		)],
		world: json!({
			"points": [[1, 1, 100, 100, 1411], [1, 1, 500, 500, 1411], [1, 1, 10, 10, 1411], [1, 1, 490, 490, 1411], [0, 0, 0, 0, 1453], [1, 1, 100, 100, 1411], [0, 0, 5, 5, 1453]],
			"zones": { "1411": "Durotar", "1453": "Stormwind City" }, "quests": [],
			"nodes": [{ "kind": "fp", "name": "Razor Hill", "pt": 2 }, { "kind": "fp", "name": "Crossroads", "pt": 3 }, { "kind": "dock", "name": "Razor Hill (boat)", "pt": 5 }, { "kind": "dock", "name": "Stormwind Harbor (boat)", "pt": 6 }],
			"rides": [[2, 3, 100, 200, "boat-x"]]
		}),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1453": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 8) },
            { "t": "accept", "q": 2, "pt": 0, "from": f("a", 9) },
            { "t": "turnin", "q": 2, "pt": 0, "from": f("a", 13) },
            { "t": "turnin", "q": 1, "pt": 4, "from": f("a", 17), "items": [{ "t": "network", "from": 0, "to": 4, "legs": [{ "k": "walk", "to": 5, "node": 2 }, { "k": "ride", "ride": 0, "from": 2, "to": 3 }, { "k": "walk", "to": 4 }] }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let boats: Vec<usize> = g.iter().enumerate().filter(|(_, l)| m(l, r#"^\s+goto .*"Boat to Stormwind"#)).map(|(i, _)| i).collect();
	assert_eq!(boats.len(), 1, "{g:#?}");
	assert!(boats[0] as i64 > idx(&g, "  turnin 2"), "{g:#?}");
}

#[test]
fn a_later_piece_worked_far_from_its_v1_step_is_named_for_its_own_place() {
	// A11 (Mulgore): the route does a line of v1's Thunderhorn well step out on the plains; that piece is
	// named for where it is, not "Thunderhorn Water Well" again.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Well", "  accept 1", "  accept 2", "", "step Plains", "  accept 3", ""])],
		world: travel_world(),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
            { "t": "accept", "q": 3, "pt": 1, "from": f("a", 11) },
            { "t": "accept", "q": 2, "pt": 1, "from": f("a", 8) }
        ] }),
		..Case::default()
	};
	let place = area("Galak Camp", "Durotar", 1411);
	let g = run(&c, Some(&place)).read("a");
	assert_eq!(pick(&g, r"^step"), vec!["step Well", "step Plains", "step Galak Camp"], "{g:#?}");
}

#[test]
fn quests_after_a_rare_drop_start_are_optional_too() {
	// PR322: the Nibbled-On Book drops rarely; Book Inventory (after it) is as optional as the book.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Kobolds", "  collect 100 x1", "  accept 10", "", "step Abbey", "  turnin 10", "  accept 11", "  turnin 11", "  accept 12", ""],
		)],
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 10, "from": f("a", 8) }, { "t": "turnin", "q": 10, "from": f("a", 11) },
            { "t": "accept", "q": 11, "from": f("a", 12) }, { "t": "turnin", "q": 11, "from": f("a", 13) },
            { "t": "accept", "q": 12, "from": f("a", 14) }
        ] }),
		quests: json!({ "10": { "title": "Book", "start": { "item": [100] } }, "11": { "title": "Inventory", "pre": [10], "start": { "npc": [5] } }, "12": { "title": "Other", "start": { "npc": [5] } } }),
		items: json!({ "100": { "name": "Nibbled Book", "drops": { "npc": { "7": 2.0 } } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert_eq!(
		pick(&g, r"^\s+(collect|accept|turnin)"),
		vec!["  collect 100 x1 optional", "  accept 10 optional", "  turnin 10", "  accept 11 optional", "  turnin 11", "  accept 12"],
		"{g:#?}"
	);
}

#[test]
fn consecutive_pieces_of_one_place_are_one_step() {
	// A13 (Auberdine 5 -> 11): two v1 steps at the town, worked one after the other by the route, are
	// written as one step, not two "Town" steps in a row.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Town", "  accept 1", "", "step Field", "  kill 9 quest 1.1", "", "step Town", "  turnin 1", "  accept 2", ""],
		)],
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "from": f("a", 7) }, { "t": "accept", "q": 2, "from": f("a", 14) },
            { "t": "task", "q": 1, "task": 0, "from": f("a", 10) }, { "t": "turnin", "q": 1, "from": f("a", 13) }
        ] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert_eq!(pick(&g, r"^step|^\s+(accept|turnin|kill)"), vec!["step Town", "  accept 1", "  accept 2", "step Field", "  kill 9 quest 1.1", "step Town", "  turnin 1"], "{g:#?}");
}

#[test]
fn a_step_waiting_for_a_zone_further_on_the_path_is_written_there() {
	// The Orgrimmar trainer before the Undead's Tirisfal riding step: at the Tirisfal dock only the
	// Tirisfal step is written; the trainer waits for the path to reach its own zone.
	let c = Case {
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
				"step Barrens trainer",
				"  zone The Barrens",
				"  train class",
				"",
				"step Durotar vendor",
				"  zone Durotar",
				"  vendor nearest",
				"",
				"step Camp",
				"  zone The Barrens",
				"  turnin 1",
				"",
			],
		)],
		world: two_zone_world(),
		frames: two_zone_frames(),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 2, "from": f("a", 7), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }] },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 19), "items": [{ "t": "network", "from": 2, "to": 1, "legs": [{ "k": "fly", "from": 0, "to": 1 }, { "k": "walk", "to": 1 }] }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let fly = idx(&g, "  fly \"Crossroads\"");
	assert!(fly >= 0 && idx(&g, "step Durotar vendor") < fly && idx(&g, "step Barrens trainer") > fly, "{g:#?}");
}

#[test]
fn a_class_flight_off_is_written_at_the_flight_master_the_route_walks_away_from() {
	// Silverpine: the Druids' flight to their trainer waits further on; the route walks from the flight
	// master to the zeppelin dock: the Druids fly from the flight master, before the walk.
	let c = Case {
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
				"step Barrens camp",
				"  zone The Barrens",
				"  vendor nearest",
				"",
				"step Druid trainer",
				"  only Druid",
				"  zone Thunder Bluff",
				"  fly \"Thunder Bluff\"",
				"  train class",
				"",
				"step Camp",
				"  zone The Barrens",
				"  turnin 1",
				"",
			],
		)],
		world: two_zone_world(),
		frames: two_zone_frames(),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 2, "from": f("a", 7), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }, { "t": "getfp", "node": 2 }] },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 21), "items": [{ "t": "network", "from": 2, "to": 1, "legs": [{ "k": "walk", "to": 1 }] }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let walk = idx(&g, "step The Barrens");
	assert!(walk >= 0 && idx(&g, "step Druid trainer") < walk, "{g:#?}");
}

#[test]
fn the_routes_way_to_a_step_for_other_races_is_its_own_races() {
	// Troll on the shared tail: the route's stop is v1's Orc riding line (only Orc,Skyborne); the way
	// there is the route's, a Troll's too, not gated to Orcs and Skyborne.
	let c = Case {
		files: vec![(
			"start",
			lines(&START_OT, &["", "step Den", "  accept 1", "", "step Riding", "  zone The Barrens", "  only Orc,Skyborne", "  train 4752 optional", "", "step Camp", "  zone The Barrens", "  turnin 1", ""]),
		)],
		world: two_zone_world(),
		frames: two_zone_frames(),
		route: json!({ "faction": "Horde", "start": "Troll", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) },
            { "t": "train", "pt": 1, "from": f("start", 14), "items": [{ "t": "network", "from": 0, "to": 1, "legs": [{ "k": "walk", "to": 1 }] }] },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("start", 18) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("start");
	let walk = idx(&g, "step The Barrens");
	assert!(walk >= 0, "{g:#?}");
	assert_ne!(g[walk as usize + 1], "  only Orc,Skyborne", "{g:#?}");
}

#[test]
fn an_added_quest_a_dropped_item_starts_gets_its_collect_and_is_optional() {
	// Message in a Bottle (594): started by a note from a bottle on the shore, one in four. Added by
	// the route, it was a bare `accept 594`: now the note's collect first, all of it optional.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Hub", "  accept 1", ""])],
		route: json!({ "diff": { "added": [7] }, "order": [
			{ "t": "accept", "q": 1, "from": f("a", 7) },
			{ "t": "accept", "q": 7, "pt": 0, "from": "inserted" }, { "t": "turnin", "q": 7, "pt": 0, "from": "inserted" }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411]], "zones": { "1411": "Durotar" }, "quests": [] }),
		quests: json!({ "7": { "title": "Message", "start": { "item": [40] }, "end": { "npc": [8] } } }),
		items: json!({ "40": { "name": "Folded Note", "drops": { "object": { "60": 25 } } } }),
		objects: json!({ "60": { "name": "Bottle", "spawns": { "1411": { "f": "e", "pts": [[52, 49]] } } } }),
		npcs: json!({ "8": { "name": "Poobah", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert_eq!(pick(&g, r"^\s+(collect|accept 7|turnin 7)"), vec!["  collect 40 x1 optional @52.0,49.0 map 1411", "  accept 7 optional", "  turnin 7"], "{g:#?}");
}

#[test]
fn a_class_quest_line_in_a_step_for_everyone_gets_its_classes() {
	// W-01: Ogtinc's Ichor of Undeath hand-in (8256, Priests) written in a step of its own, for everyone.
	let quests: BTreeMap<u32, forge_writer::input::Quest> = serde_json::from_value(json!({ "8256": { "title": "The Ichor of Undeath", "classes": 16 } })).unwrap();
	let data = Data { quests, ..Data::default() };
	let mut files = vec![["step Ogtinc", "  turnin 8256                         -- Ogtinc", "", "step Priests", "  only Priest", "  accept 8256"].join("\n")];
	forge_writer::post::class_only_lines(&mut files, &data);
	assert_eq!(files[0].split('\n').collect::<Vec<_>>(), vec!["step Ogtinc", "  turnin 8256 only Priest -- Ogtinc", "", "step Priests", "  only Priest", "  accept 8256"]);
}

#[test]
fn a_shared_guides_lines_of_a_quest_done_in_the_races_own_guide_are_the_other_races() {
	// The Barrens (Orc, Troll): Stagnant Oasis is taken and handed in in their own guide; the shared
	// guide's accept and turn-in of it are the Tauren's and Undead's, not a second hand-in for Orcs.
	let c = Case {
		files: vec![
			("start", lines(&START_OT, &["", "step Den", "  accept 1", "  turnin 1", ""])),
			("shared", vec!["guide t/shared", "title Shared", "levels 5-9", "zone Durotar", "", "step Camp", "  turnin 1", "  accept 2", "", "step Oasis", "  accept 1", ""]),
		],
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "from": f("start", 9) }, { "t": "turnin", "q": 1, "from": f("start", 10) },
            { "t": "accept", "q": 2, "from": f("shared", 8) }
        ] }),
		..Case::default()
	};
	let g = run(&c, None).read("shared");
	assert_eq!(pick(&g, r"^\s+(accept|turnin) 1\b"), vec!["  turnin 1 only Tauren,Undead,Skyborne", "  accept 1 only Tauren,Undead,Skyborne"], "{g:#?}");
}

#[test]
fn the_classes_left_behind_by_a_class_only_leg_come_on_where_the_route_goes_on() {
	// The Affray: the route flies to Ratchet for the Warriors' quest and goes on from there; the other
	// classes, left at the flight master, fly on to it before the route goes on.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Orc,Troll,Tauren,Undead,Skyborne",
				"levels 1-5",
				"zone Durotar",
				"",
				"step Hub",
				"  accept 1",
				"",
				"step The Affray",
				"  only Warrior",
				"  zone The Barrens",
				"  accept 9",
				"  turnin 9",
				"",
				"step Camp",
				"  zone The Barrens",
				"  turnin 1",
				"",
			],
		)],
		world: two_zone_world(),
		frames: two_zone_frames(),
		quests: json!({ "9": { "title": "The Affray", "classes": 1 } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 2, "from": f("a", 8), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }, { "t": "getfp", "node": 2 }] },
            { "t": "accept", "q": 9, "pt": 3, "from": f("a", 13), "items": [{ "t": "network", "from": 2, "to": 3, "legs": [{ "k": "fly", "from": 0, "to": 1 }] }] },
            { "t": "turnin", "q": 9, "pt": 3, "from": f("a", 14) },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 18), "items": [{ "t": "network", "from": 3, "to": 1, "legs": [{ "k": "walk", "to": 1 }] }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let back = idx(&g, "step Back to Crossroads");
	assert!(back >= 0 && back < idx(&g, "step Camp"), "{g:#?}");
	assert!(g[back as usize + 1].starts_with("  only Paladin,") && !g[back as usize + 1].contains("Warrior"), "{g:#?}");
}

#[test]
fn a_class_step_left_away_from_its_place_gets_that_class_s_way_there() {
	// Mulgore: the Shamans' Spirit Rise step (Thunder Bluff) is written after the route has gone on to
	// the Crossroads; with no travel of its own, the Shamans get their flight there.
	let mut world = two_zone_world();
	world["quests"] = json!([{ "id": 7, "giver": 4, "ender": 4 }]);
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Orc,Troll,Tauren,Undead,Skyborne",
				"levels 1-5",
				"zone The Barrens",
				"",
				"step Hub",
				"  accept 1",
				"",
				"step Spirit Rise",
				"  only Shaman",
				"  zone Durotar",
				"  accept 7",
				"",
				"step Camp",
				"  zone The Barrens",
				"  turnin 1",
				"",
			],
		)],
		world,
		frames: two_zone_frames(),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 3, "from": f("a", 8), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }, { "t": "getfp", "node": 2 }] },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 17) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let fly = idx(&g, "  fly \"Thunder Bluff\"");
	assert!(fly >= 0 && fly < idx(&g, "step Spirit Rise"), "{g:#?}");
	assert!(g[..fly as usize].iter().rev().take_while(|l| !l.starts_with("step ")).any(|l| l == "  only Shaman"), "{g:#?}");
}

#[test]
fn a_class_hand_in_before_the_routes_accept_goes_and_the_routes_hand_in_is_theirs_too() {
	// #402 on a newer route: the accept of Return to Nessa moved on to the Darkshore arrival, after the
	// Druids' own Darnassus step that hands it in; that hand-in goes (no turn-in before its accept) and
	// the route's own hand-in, in the step for everyone but Druids, is the Druids' too.
	let teldrassil = ["step Back to Darnassus", "  only Druid", "  turnin 6343", "  turnin 5931", ""].join("\n");
	let darkshore = ["step Auberdine", "  turnin 6342", "  accept 6343", "", "step Return to Nessa", "  only !Druid", "  fly \"Rut'theran Village\"", "  turnin 6343", ""].join("\n");
	let mut files = vec![teldrassil, darkshore];
	let in_route: rustc_hash::FxHashSet<u32> = [6342, 6343, 5931].into_iter().collect();
	forge_writer::post::premature_class_turnins(&mut files, &in_route);
	assert_eq!(files[0].split('\n').collect::<Vec<_>>(), vec!["step Back to Darnassus", "  only Druid", "  turnin 5931", ""], "{files:#?}");
	assert_eq!(pick(&files[1].split('\n').map(str::to_string).collect::<Vec<_>>(), r"^\s+(only|turnin 6343)"), vec!["  turnin 6343"], "{files:#?}");
}

#[test]
fn the_towns_boat_goto_goes_after_its_last_piece() {
	// A15 on the c4 route: Thundris' Blackwood hand-in came after v1's "Boat to Stormwind" goto, in a
	// piece of its own; the town is one step and the boat goto its last line.
	let out: Vec<String> = ["step Auberdine", "  accept 97914", "  goto 30.76,40.92 \"Boat to Stormwind\"", "", "step Auberdine", "  turnin 4763", "", "step Next", "  accept 1"].iter().map(|s| s.to_string()).collect();
	assert_eq!(
		forge_writer::post::same_place_pieces(out),
		vec!["step Auberdine", "  accept 97914", "  turnin 4763", "  goto 30.76,40.92 \"Boat to Stormwind\"", "", "step Next", "  accept 1"]
	);
}

#[test]
fn a_v1_grind_the_route_does_not_make_is_written_at_the_routes_level() {
	// The free route's Barrens: v1's "level 20" grind step sits where the route is at 13; written as it
	// is, it cost the written walk six hours of grinding ahead of the route. A player behind catches
	// up to the route's level there instead.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 10-20", "zone Durotar", "", "step Hub", "  accept 1", "", "step Level 20", "  level 20", "", "step Camp", "  turnin 1", ""])],
		route: json!({ "diff": {}, "order": [{ "t": "accept", "q": 1, "lvl": 13.4, "from": f("a", 7) }, { "t": "turnin", "q": 1, "lvl": 13.6, "from": f("a", 13) }] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(has(&g, "  level 13.4"), "{g:#?}");
}

#[test]
fn a_shared_guides_copy_of_a_step_the_route_moved_into_its_own_guide_is_the_other_races() {
	// The free route takes Regthar's Kolkar Leaders in the Orcs' own Barrens guide; the copy kept in the
	// shared guide for the other races is theirs, not a second accept for the Orc.
	let c = Case {
		files: vec![
			("start", lines(&START_OT, &["", "step Den", "  accept 1", "", "step Hut", "  accept 3", "", "step Field", "  accept 4", ""])),
			("shared", vec!["guide t/shared", "title Shared", "levels 5-9", "zone Durotar", "", "step Camp", "  turnin 1", "", "step Regthar", "  accept 850", ""]),
		],
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "from": f("start", 9) }, { "t": "accept", "q": 850, "from": f("shared", 10) },
            { "t": "accept", "q": 3, "from": f("start", 12) }, { "t": "accept", "q": 4, "from": f("start", 15) },
            { "t": "turnin", "q": 1, "from": f("shared", 7) }
        ] }),
		..Case::default()
	};
	let out = run(&c, None);
	let start = out.read("start");
	assert!(has(&start, "  accept 850"), "{start:#?}");
	let shared = out.read("shared");
	let at = idx(&shared, "step Regthar");
	assert!(at >= 0 && shared[at as usize + 1].starts_with("  only Tauren,Undead,Skyborne"), "{shared:#?}");
}

#[test]
fn the_travel_of_a_task_left_to_its_turn_in_is_carried_to_the_next_event() {
	// Elixir of Agony on the free route: the potion task is v1's optional bag hand-in, so the guide leaves
	// it to the turn-in; its leg (Crossroads to the far camp) went with it, and the next event had no
	// way there. The leg goes on to the next event.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Hub", "  accept 1", "  accept 2", "", "step Lydon", "  turnin 1 optional", "", "step Camp", "  turnin 2", ""])],
		world: travel_world(),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 2, "from": f("a", 7), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }] },
            { "t": "accept", "q": 2, "pt": 2, "from": f("a", 8) },
            { "t": "task", "q": 1, "task": 0, "pt": 3, "from": f("a", 11), "items": [{ "t": "network", "from": 2, "to": 3, "legs": [{ "k": "fly", "from": 0, "to": 1 }] }] },
            { "t": "turnin", "q": 2, "pt": 3, "from": f("a", 14) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let fly = idx(&g, "  fly \"Crossroads\"");
	assert!(fly >= 0 && fly < idx(&g, "  turnin 2"), "{g:#?}");
}

#[test]
fn a_class_step_over_the_sea_gets_that_class_s_crossing() {
	// Stranglethorn on the free route: the Shamans' Orgrimmar trainer step (v1's hop, its zeppelin only in
	// the tip) is written away from Grom'gol; the Shamans get the zeppelin to Orgrimmar first.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 30-35", "zone Stranglethorn Vale", "", "step Hub", "  accept 1", "", "step Orgrimmar", "  only Shaman", "  zone Orgrimmar", "  train class", "", "step Camp", "  zone Stranglethorn Vale", "  turnin 1", ""],
		)],
		world: json!({
			"points": [[0, 0, 0, 0, 1434], [0, 0, 50, 50, 1434], [1, 1, 0, 0, 1454], [1, 1, 30, 30, 1454]],
			"zones": { "1434": "Stranglethorn Vale", "1454": "Orgrimmar" }, "quests": [],
			"nodes": [{ "kind": "fp", "name": "Orgrimmar", "pt": 3 }, { "kind": "dock", "name": "Grom'gol (zeppelin)", "pt": 1 }, { "kind": "dock", "name": "Orgrimmar (zeppelin)", "pt": 2 }],
			"rides": [[1, 2, 100, 200, "zeppelin-x"]]
		}),
		frames: json!({ "era": { "1434": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1454": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
            { "t": "turnin", "q": 1, "pt": 0, "from": f("a", 16) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let z = g.iter().position(|l| m(l, r#"^\s+goto .*"Zeppelin to Orgrimmar""#)).unwrap_or_else(|| panic!("{g:#?}"));
	assert!((z as i64) < idx(&g, "step Orgrimmar"), "{g:#?}");
	assert!(g[..z].iter().rev().take_while(|l| !l.starts_with("step ")).any(|l| l == "  only Shaman"), "{g:#?}");
}

#[test]
fn a_class_crossing_from_a_dock_out_of_reach_walks_to_its_zone_first() {
	// c6 Undead: the Paladins' Tirisfal class quests after the Crossroads; no flight path toward
	// Orgrimmar's tower is known yet. They walk into Durotar, then take the zeppelin.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 10-15", "zone The Barrens", "", "step Hub", "  accept 1", "", "step Tirisfal", "  only Paladin", "  zone Tirisfal Glades", "  accept 9", "", "step Camp", "  zone The Barrens", "  turnin 1", ""],
		)],
		world: json!({
			"points": [[0, 0, 0, 0, 1413], [0, 0, 2000, 0, 1411], [1, 1, 0, 0, 1420], [1, 1, 30, 30, 1420]],
			"zones": { "1413": "The Barrens", "1411": "Durotar", "1420": "Tirisfal Glades" }, "quests": [],
			"nodes": [{ "kind": "fp", "name": "Undercity", "pt": 3 }, { "kind": "dock", "name": "Orgrimmar (zeppelin)", "pt": 1 }, { "kind": "dock", "name": "Undercity (zeppelin)", "pt": 2 }],
			"rides": [[1, 2, 100, 200, "zeppelin-x"]]
		}),
		frames: json!({ "era": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1411": { "top": 3000, "bottom": 1000, "left": -1000, "right": 1000, "c": 0 }, "1420": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
            { "t": "turnin", "q": 1, "pt": 0, "from": f("a", 16) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let z = idx(&g, "step Zeppelin to Undercity");
	let w = idx(&g, "step Durotar");
	assert!(w < z && z < idx(&g, "step Tirisfal"), "{g:#?}");
	assert_eq!(g[w as usize + 1], "  only Paladin", "{g:#?}");
}

#[test]
fn a_bag_turn_in_the_route_works_stays_where_the_route_makes_it() {
	// The Scourgestones on the free route: handed in at the Bulwark where the route works them; a later
	// guide's line that gets more stones no longer pulls the hand-in after it (17 hours in the written
	// walk, then walks back to the Bulwark from Eastern Plaguelands).
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 50-55", "zone Durotar", "", "step Bulwark", "  accept 5 optional", "  turnin 5 optional", "", "step Later", "  accept 6", "  collect 50 x10 optional", ""],
		)],
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 5, "from": f("a", 7) }, { "t": "task", "q": 5, "task": 0, "from": f("a", 8) },
            { "t": "turnin", "q": 5, "from": f("a", 8) }, { "t": "accept", "q": 6, "from": f("a", 11) }
        ] }),
		quests: json!({ "5": { "title": "Stones", "repeatable": true, "objectives": [{ "type": "item", "id": 50, "count": 10 }] }, "6": { "title": "Six" } }),
		items: json!({ "50": { "name": "Scourgestone", "drops": { "npc": { "7": 20.0 } } } }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  turnin 5 optional") < idx(&g, "step Later"), "{g:#?}");
}

#[test]
fn the_routes_walk_to_an_island_takes_its_boat() {
	// Feathermoon Stronghold: the route walks from Theramore to the island; the guide had a far goto into
	// Feralas and no boat. The walk is written by way of the Forgotten Coast boat.
	let c = Case {
		files: vec![
			("a", vec!["guide t/a", "title A", "levels 40-45", "zone Durotar", "next t/b", "", "step Theramore", "  accept 1", ""]),
			("b", vec!["guide t/b", "title B", "levels 40-45", "zone The Barrens", "", "step Feathermoon Stronghold", "  accept 2", ""]),
		],
		world: json!({
			"points": [[1, 1, 0, 0, 1411], [1, 1, 3000, 0, 1413], [1, 1, 2500, 0, 1413], [1, 1, 3000, 100, 1413]],
			"zones": { "1411": "Durotar", "1413": "The Barrens" }, "quests": [],
			"nodes": [{ "kind": "dock", "name": "The Forgotten Coast (boat)", "pt": 2 }, { "kind": "dock", "name": "Feathermoon Stronghold (boat)", "pt": 3 }],
			"rides": [[0, 1, 30, 60, "boat-feathermoon"], [1, 0, 30, 60, "boat-feathermoon"]]
		}),
		frames: json!({ "era": { "1411": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 1 }, "1413": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 1 } } }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 8) },
            { "t": "accept", "q": 2, "pt": 1, "from": f("b", 7), "items": [{ "t": "walk", "from": 0, "to": 1 }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let out = run(&c, None);
	let all: Vec<String> = out.read("a").into_iter().chain(out.read("b")).collect();
	let boat = all.iter().position(|l| m(l, r#"^\s+goto .*"Boat to Feathermoon Stronghold""#)).unwrap_or_else(|| panic!("{all:#?}"));
	assert!(boat < all.iter().position(|l| l == "  accept 2").unwrap(), "{all:#?}");
}

#[test]
fn a_leg_the_guide_before_already_walks_is_not_walked_again() {
	// Skyborne (Horde): the isle guide ends with v1's walk to the Crossroads; the Barrens guide opened with
	// the route's same leg again, from the Mulgore lift (a bounce). At a guide's start, a leg to where the
	// guide before left everyone is not written.
	let c = Case {
		files: vec![
			("start", lines(&START_OT, &["", "step Hub", "  accept 1", "", "step The Crossroads", "  getfp \"Crossroads\"", ""])),
			("shared", vec!["guide t/shared", "title Shared", "levels 5-9", "zone Durotar", "", "step Camp", "  turnin 1", ""]),
		],
		world: travel_world(),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) },
            { "t": "turnin", "q": 1, "pt": 3, "from": f("shared", 7), "items": [{ "t": "network", "from": 0, "to": 3, "legs": [{ "k": "walk", "to": 1, "node": 1 }, { "k": "walk", "to": 3 }] }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("shared");
	assert!(!g.iter().any(|l| m(l, r"^\s+goto ")), "{g:#?}");
}

#[test]
fn a_drop_started_quest_the_route_inserts_is_taken_once_and_handed_in_when_held() {
	// c7 Human, Gold Pickup Schedule (123): the route inserts its accept and turn-in; v1's own lines were
	// written too, the accept twice and v1's hand-in before it (pack error: turnin never accepted). The
	// route's lines stand alone, and the hand-in is for a player who holds the quest.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 10-15", "zone Durotar", "", "step Hub", "  accept 1", "", "step Dughan", "  turnin 7", "", "step Field", "  kill 9 quest 1.1", "  collect 40 x1 optional", "  accept 7 optional", "", "step Camp", "  turnin 1", ""],
		)],
		route: json!({ "diff": { "added": [7] }, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "from": f("a", 13) },
			{ "t": "accept", "q": 7, "pt": 0, "from": "inserted" },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 18) },
			{ "t": "turnin", "q": 7, "pt": 0, "from": "inserted" }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411]], "zones": { "1411": "Durotar" }, "quests": [] }),
		quests: json!({ "7": { "title": "Schedule", "start": { "item": [40] }, "end": { "npc": [8] } } }),
		items: json!({ "40": { "name": "Gold Pickup Schedule", "drops": { "npc": { "60": null } } } }),
		npcs: json!({ "60": { "name": "Gruff", "spawns": { "1411": { "f": "e", "pts": [[52, 49]] } } }, "8": { "name": "Dughan", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert_eq!(g.iter().filter(|l| m(l, r"^\s+accept 7\b")).count(), 1, "{g:#?}");
	assert_eq!(g.iter().filter(|l| m(l, r"^\s+collect 40\b")).count(), 1, "{g:#?}");
	assert_eq!(g.iter().filter(|l| m(l, r"^\s+turnin 7\b")).count(), 1, "{g:#?}");
	let (a, t) = (g.iter().position(|l| m(l, r"^\s+accept 7\b")).unwrap(), g.iter().position(|l| m(l, r"^\s+turnin 7\b")).unwrap());
	assert!(a < t && g[..t].iter().rev().take_while(|l| !l.starts_with("step ")).any(|l| l == "  when onquest 7"), "{g:#?}");
}

#[test]
fn a_quest_the_route_works_by_its_own_events_drops_v1s_work_lines() {
	// c7 Skyborne-horde, Zephras Isle 93736: the route inserts its accept, task and hand-in later than
	// v1's; v1's collect stayed in v1's place, before the route's accept (pack error: collect for a quest
	// never accepted). The route's own lines stand alone.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 10-15", "zone Durotar", "", "step Hub", "  accept 1", "  accept 7", "", "step Field", "  kill 9 quest 1.1", "  collect 40 quest 7.1", "", "step Camp", "  turnin 1", "  turnin 7", ""],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "from": f("a", 11) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 15) },
			{ "t": "accept", "q": 7, "pt": 0, "from": "inserted" },
			{ "t": "task", "q": 7, "task": 0, "pt": 0, "from": "inserted" },
			{ "t": "turnin", "q": 7, "pt": 0, "from": "inserted" }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411]], "zones": { "1411": "Durotar" }, "quests": [{ "id": 7, "objs": [{ "oi": 0, "type": "item", "id": 40, "task": 0 }] }] }),
		quests: json!({ "7": { "title": "Crate", "start": { "npc": [8] }, "end": { "npc": [8] } } }),
		items: json!({ "40": { "name": "Crate" } }),
		npcs: json!({ "8": { "name": "Endaria", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert_eq!(g.iter().filter(|l| m(l, r"^\s+collect 40\b")).count(), 1, "{g:#?}");
	assert!(idx(&g, "  accept 7") < g.iter().position(|l| m(l, r"^\s+collect 40\b")).unwrap() as i64, "{g:#?}");
}

#[test]
fn v1s_training_steps_go_with_the_routes_training() {
	// c6 Orc, Arathi: the route trains in Orgrimmar, then hands in at Regthar twice; v1's own training
	// steps (Orgrimmar for most classes, Thunder Bluff for Druids and Paladins) were written between the
	// two hand-ins, a second trip. They are the route's training now, and it writes no line of its own.
	// A second v1 Thunder Bluff training for the same classes (c9's Dustwallow one) is not written.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 38-40", "zone The Barrens", "",
				"step Hub", "  accept 1", "  accept 2", "",
				"step Orgrimmar", "  zone Orgrimmar", "  train class only Warrior,Hunter,Rogue,Priest,Shaman,Mage,Warlock", "",
				"step Thunder Bluff", "  only Druid,Paladin", "  zone Thunder Bluff", "  train class", "",
				"step Thunder Bluff again", "  only Druid,Paladin", "  zone Thunder Bluff", "  getfp \"Thunder Bluff\"", "  train class", "",
				"step Camp", "  zone The Barrens", "  turnin 1", "",
				"step Field", "  turnin 2", "",
			],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 39.9, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "lvl": 39.9, "from": f("a", 8) },
			{ "t": "train", "lvl": 40.0, "pt": 0, "from": "train stop" },
			{ "t": "turnin", "q": 2, "lvl": 40.0, "from": f("a", 30) },
			{ "t": "turnin", "q": 1, "lvl": 40.0, "from": f("a", 27) }
		] }),
		world: json!({ "points": [[0, 0, 0, 0, 1454]], "zones": { "1454": "Orgrimmar" }, "quests": [] }),
		frames: json!({ "era": { "1454": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  train class only Warrior,Hunter,Rogue,Priest,Shaman,Mage,Warlock") < idx(&g, "  turnin 2"), "{g:#?}");
	assert!(idx(&g, "step Thunder Bluff") < idx(&g, "  turnin 2"), "{g:#?}");
	assert_eq!(g.iter().filter(|l| m(l, r"^\s+train class")).count(), 2, "{g:#?}");
	assert!(!g.iter().any(|l| l == "step Thunder Bluff again"), "{g:#?}");
}

#[test]
fn a_training_the_route_does_in_another_city_is_written_there() {
	// c6 Human, Silithus: the route trains at Stormwind's trainer by v1's Ironforge training line,
	// between two Stormwind hand-ins; v1's Ironforge step sent everyone to Ironforge and back.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 56-58", "zone Stormwind City", "", "step Royal Factor", "  accept 1", "", "step Ironforge", "  zone Ironforge", "  train class only Warrior,Mage", "", "step Ol' Emma", "  zone Stormwind City", "  turnin 1", ""],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "pt": 0, "from": f("a", 11) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 15) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1453]], "zones": { "1453": "Stormwind City" }, "quests": [] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l == "step Ironforge" || l == "  zone Ironforge"), "{g:#?}");
	let t = idx(&g, "  train class only Warrior,Mage");
	assert!(idx(&g, "  accept 1") < t && t < idx(&g, "  turnin 1"), "{g:#?}");
}

#[test]
fn v1s_training_trip_the_route_does_not_make_goes() {
	// c9 Orc, Barrens: v1's "Orgrimmar at 23" (fly there, train) after Regthar; the route trains
	// elsewhere and has no stop there. The trip goes.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 20-24", "zone Orgrimmar", "", "step Hub", "  accept 1", "  accept 2", "", "step Orgrimmar at 23", "  fly \"Orgrimmar\"", "  train class", "", "step Camp", "  turnin 1", "", "step Field", "  turnin 2", ""],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "train", "lvl": 20.0, "pt": 0, "from": "train stop" },
			{ "t": "accept", "q": 1, "lvl": 20.0, "pt": 0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "lvl": 20.0, "pt": 0, "from": f("a", 8) },
			{ "t": "turnin", "q": 2, "lvl": 23.0, "pt": 0, "from": f("a", 18) },
			{ "t": "turnin", "q": 1, "lvl": 23.0, "pt": 0, "from": f("a", 15) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1454]], "zones": { "1454": "Orgrimmar" }, "quests": [] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l == "step Orgrimmar at 23"), "{g:#?}");
	assert_eq!(g.iter().filter(|l| m(l, r"^\s+train class")).count(), 1, "{g:#?}");
}

#[test]
fn a_class_step_of_a_zone_the_route_has_left_over_the_sea_is_written_there_first() {
	// c6 Undead: the Paladins' Bandarion Keep steps (Whispering Forest, Shadowvale) were written after
	// the Barrens, a crossing back to Tirisfal and back. They go at the route's last pass in Tirisfal.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 9-12", "zone Tirisfal Glades", "", "step Brill", "  accept 1", "  accept 2", "", "step Paladin: Whispering Forest", "  only Paladin", "  accept 9", "", "step Crossroads", "  zone The Barrens", "  turnin 1", "", "step Barrens camp", "  turnin 2", ""],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 0, "from": f("a", 8) },
			{ "t": "turnin", "q": 2, "pt": 1, "from": f("a", 19) },
			{ "t": "turnin", "q": 1, "pt": 1, "from": f("a", 16) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1420], [0, 0, 0, 0, 1413]], "zones": { "1420": "Tirisfal Glades", "1413": "The Barrens" }, "quests": [] }),
		frames: json!({ "era": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1420": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "step Paladin: Whispering Forest") < idx(&g, "  turnin 2"), "{g:#?}");
}

#[test]
fn a_step_with_nothing_for_everyone_but_some_races_lines_is_theirs() {
	// c9 Orc, Stonetalon: v1's "To the Undercity" (a flight path, the Skyborne's Sylvanas) was written
	// between two Beren's Peril stops with a walk to the Undercity for everyone. It is the Skyborne's.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 20-25", "zone Silverpine Forest", "", "step Beren's Peril", "  accept 1", "", "step To the Undercity", "  zone Undercity", "  getfp \"Undercity\"", "  kill 10181 quest 9.4 \"Talk to Sylvanas\" only Skyborne optional", "", "step Beren's Peril again", "  zone Silverpine Forest", "  turnin 1", ""],
		)],
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 16) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1421], [1, 1, 500, 500, 1458]], "zones": { "1421": "Silverpine Forest", "1458": "Undercity" }, "quests": [] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let s = idx(&g, "step To the Undercity") as usize;
	assert_eq!(g[s + 1], "  only Skyborne", "{g:#?}");
	assert!(!g.iter().any(|l| m(l, r#"^\s+goto .*"Undercity""#)), "{g:#?}");
}

#[test]
fn v1s_bind_stop_in_a_town_the_route_has_left_goes() {
	// c9 Human, Burning Steppes: the route flew from Ironforge to Aerie Peak and on to Southshore's boat;
	// v1's opener "Ironforge: sethome, the last guide binds here" then sent the player back to Ironforge.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 50-52", "zone Hillsbrad Foothills", "", "step Southshore", "  accept 1", "", "step Ironforge", "  zone Ironforge", "  sethome \"Ironforge\" npc 5111", "", "step Camp", "  zone Hillsbrad Foothills", "  turnin 1", ""],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 15) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1424]], "zones": { "1424": "Hillsbrad Foothills", "1455": "Ironforge" }, "quests": [] }),
		frames: json!({ "era": { "1424": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1455": { "top": 5000, "bottom": 3000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({ "5111": { "name": "Innkeeper Firebrew", "spawns": { "1455": { "f": "a", "pts": [[50, 50]] } } } }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l == "step Ironforge" || m(l, r"^\s+sethome")), "{g:#?}");
}

#[test]
fn riding_training_goes_where_the_route_places_it() {
	// The planner's `ride` event: v1's Kildar line moved to the route's first Orgrimmar visit at 40, or
	// a trainer step of its own where v1 has no line.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 38-46", "zone Orgrimmar", "", "step Orgrimmar", "  accept 1", "", "step Feralas", "  turnin 1", "", "step Kildar", "  train 4752 optional -- Kildar", ""],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "ride", "npc": 4752, "pt": 0, "lvl": 40.0, "from": f("a", 13) },
			{ "t": "ride", "npc": 4773, "pt": 0, "lvl": 40.0, "from": "inserted" },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 10) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1454]], "zones": { "1454": "Orgrimmar" }, "quests": [] }),
		npcs: json!({ "4773": { "name": "Velma Warnam" } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let k = idx(&g, "  train 4752 optional -- Kildar");
	assert!(idx(&g, "  accept 1") < k && k < idx(&g, "  turnin 1"), "{g:#?}");
	let v = g.iter().position(|l| m(l, r"^\s+train 4773\b.*Velma Warnam")).unwrap_or_else(|| panic!("{g:#?}")) as i64;
	assert!(v < idx(&g, "  turnin 1") && idx(&g, "step Riding trainer") < v, "{g:#?}");
}

#[test]
fn v1s_class_training_right_after_a_moved_training_comes_with_it() {
	// c9 Tauren, Silverpine: the route trains at v1's Orgrimmar step and goes on to the zeppelin; v1's
	// Druid step after it (Thunder Bluff) waited for the Sepulcher, levels later, and flew the Druids
	// from Silverpine. It comes with the Orgrimmar training.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 20-26", "zone Orgrimmar", "",
				"step Hub", "  accept 1", "",
				"step Orgrimmar", "  train class only Warrior,Hunter,Rogue,Priest,Shaman,Mage,Warlock", "",
				"step Thunder Bluff", "  only Druid", "  zone Thunder Bluff", "  fly \"Thunder Bluff\"", "  train class", "",
				"step The Sepulcher", "  zone Silverpine Forest", "  turnin 1", "",
				"step Silverpine camp", "  accept 2", "",
			],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 20.0, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "lvl": 20.0, "pt": 0, "from": f("a", 10) },
			{ "t": "accept", "q": 2, "lvl": 24.0, "pt": 0, "from": f("a", 23) },
			{ "t": "turnin", "q": 1, "lvl": 24.0, "pt": 0, "from": f("a", 20) }
		] }),
		world: json!({ "points": [[0, 0, 0, 0, 1454]], "zones": { "1454": "Orgrimmar" }, "quests": [] }),
		frames: json!({ "era": { "1454": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "step Thunder Bluff") < idx(&g, "  accept 2"), "{g:#?}");
}

#[test]
fn a_way_into_a_zone_the_route_is_already_in_goes() {
	// c10 Alliance, Thousand Needles: v1's Great Lift step (its journal left out) was written between two
	// Mirage Raceway stops; the route was already down in the canyons.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 28-32", "zone Thousand Needles", "", "step Mirage Raceway", "  accept 1", "", "step The Great Lift", "  tip The Great Lift takes you down into Thousand Needles.", "  collect 5791 @30.7,24.3", "  accept 1100", "", "step Raceway again", "  turnin 1", ""],
		)],
		world: json!({ "points": [[1, 1, 0, 0, 1441]], "zones": { "1441": "Thousand Needles" }, "quests": [] }),
		route: json!({ "diff": { "dropped": [1100] }, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 15) }
		] }),
		quests: json!({ "1100": { "title": "Lonebrow's Journal", "start": { "item": [5791] } } }),
		items: json!({ "5791": { "name": "Henrig Lonebrow's Journal" } }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l == "step The Great Lift"), "{g:#?}");
}

#[test]
fn a_v1_step_the_route_left_waits_for_the_routes_pass_through_its_zone() {
	// c10 Horde: v1's class and flight-path steps went with the next route line into another zone
	// (Silverpine -> Orgrimmar -> back). A step of a zone the route comes to soon goes on that visit.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 20-24", "zone Durotar", "", "step Hub", "  accept 1", "  accept 2", "", "step Brazier", "  only Shaman", "  zone The Barrens", "  accept 9", "", "step Camp", "  zone Durotar", "  turnin 1", "", "step Barrens camp", "  zone The Barrens", "  turnin 2", ""],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 20.0, "pt": 0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "lvl": 20.0, "pt": 0, "from": f("a", 8) },
			{ "t": "turnin", "q": 1, "lvl": 20.5, "pt": 0, "from": f("a", 17) },
			{ "t": "turnin", "q": 2, "lvl": 21.0, "pt": 1, "from": f("a", 21) }
		] }),
		world: json!({ "points": [[0, 0, 0, 0, 1411], [0, 0, 500, 500, 1413]], "zones": { "1411": "Durotar", "1413": "The Barrens" }, "quests": [] }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  turnin 2") < idx(&g, "step Brazier"), "{g:#?}");
}

#[test]
fn a_class_steps_hearth_home_is_that_class_s_way_back() {
	// c10 Orc, Stranglethorn: v1's "Back to Grom'gol" (only Shaman, hearth) after Islen Waterseer in
	// Ratchet went to the other races, and the Shamans were left in the Barrens.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 30-34", "zone Durotar", "", "step Inn", "  sethome \"Razor Hill\"", "  accept 1", "", "step Islen", "  only Shaman", "  accept 9", "", "step Back home", "  only Shaman", "  hearth \"Razor Hill\"", "", "step Camp", "  turnin 1", ""],
		)],
		world: travel_world(),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 8), "items": [{ "t": "bind", "inn": 0, "pt": 0, "used": false }] },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 19) }
		] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(has(&g, "  hearth \"Razor Hill\""), "{g:#?}");
}

#[test]
fn a_training_step_with_other_work_elsewhere_stays_with_its_town() {
	// c10 NightElf: the Druids' Dolanaar step (train, Heeding the Call from Kal) came with the route's
	// Darnassus training: Darnassus -> Dolanaar -> Darnassus.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 9-11", "zone Darnassus", "", "step Hub", "  accept 1", "  accept 2", "", "step Kal", "  only Druid", "  zone Teldrassil", "  train class", "  accept 5925", "", "step Camp", "  zone Teldrassil", "  turnin 1", "", "step Field", "  turnin 2", ""],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 10.0, "pt": 0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "lvl": 10.0, "pt": 0, "from": f("a", 8) },
			{ "t": "train", "lvl": 10.0, "pt": 0, "from": "train stop" },
			{ "t": "turnin", "q": 2, "lvl": 10.5, "pt": 0, "from": f("a", 20) },
			{ "t": "turnin", "q": 1, "lvl": 10.5, "pt": 0, "from": f("a", 17) }
		] }),
		world: json!({ "points": [[0, 0, 0, 0, 1457]], "zones": { "1457": "Darnassus", "1438": "Teldrassil" }, "quests": [] }),
		frames: json!({ "era": { "1457": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1438": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  turnin 2") < idx(&g, "step Kal"), "{g:#?}");
}

#[test]
fn no_walk_back_tip_right_after_a_flight() {
	// c10 Horde Barrens: "Walk back west along the road" right after the step that flew the player to
	// the Crossroads.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 12-14", "zone The Barrens", "", "step Hub", "  accept 1", "", "step Fly to Crossroads", "  goto 45.0,60.0 \"Camp Taurajo flight master\"", "  fly \"Crossroads\"", "", "step Mankrik", "  tip Walk back west along the road. Mankrik waits by the inn.", "  turnin 1", ""],
		)],
		route: json!({ "diff": {}, "order": [{ "t": "accept", "q": 1, "from": f("a", 7) }, { "t": "turnin", "q": 1, "from": f("a", 15) }] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(has(&g, "  tip Mankrik waits by the inn."), "{g:#?}");
}

#[test]
fn the_routes_bind_where_v1_binds_is_one_line() {
	// c10 Human Elwynn, Orc Grom'gol: `sethome "Goldshire"` written twice in one step, the route's and
	// v1's with its innkeeper. One line, v1's; a step for others keeps its own.
	let mut f = vec!["guide t/a\n\nstep Inn\n  sethome \"Grom'gol Base Camp\"\n  getfp \"Grom'gol\" npc 1387\n  sethome \"Grom'gol Base Camp\" npc 5814 -- Innkeeper Thulbek\n  getfp \"Grom'gol\"\n\nstep Other\n  sethome \"Grom'gol Base Camp\" only Troll\n  sethome \"Grom'gol Base Camp\" npc 5814\n".to_string()];
	forge_writer::post::one_service_line(&mut f);
	assert_eq!(
		f[0],
		"guide t/a\n\nstep Inn\n  getfp \"Grom'gol\" npc 1387\n  sethome \"Grom'gol Base Camp\" npc 5814 -- Innkeeper Thulbek\n\nstep Other\n  sethome \"Grom'gol Base Camp\" only Troll\n  sethome \"Grom'gol Base Camp\" npc 5814\n"
	);
}

#[test]
fn a_class_with_no_trainer_at_the_stop_trains_at_the_routes_pass_by_its_own() {
	// c10 Orc/Troll: the route trains at Razor Hill, which has no Mage trainer; the addon sent Mages to
	// Sen'jin Village and back. They train when the route passes Sen'jin.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 8-11", "zone Durotar", "", "step Razor Hill", "  accept 1", "", "step Sen'jin", "  turnin 1", ""],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1411], [0, 0, -800, 800, 1411]], "zones": { "1411": "Durotar" }, "quests": [] }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"3169": { "name": "Tarshaw", "subName": "Warrior Trainer", "faction": "H", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } },
			"5880": { "name": "Un'Thuwa", "subName": "Mage Trainer", "faction": "H", "spawns": { "1411": { "f": "e", "pts": [[90, 90]] } } }
		}),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 10.0, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "lvl": 10.0, "pt": 0, "from": "train stop" },
			{ "t": "turnin", "q": 1, "lvl": 10.3, "pt": 1, "from": f("a", 10) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let first = g.iter().position(|l| m(l, r"^\s+train class")).unwrap_or_else(|| panic!("{g:#?}"));
	assert!(!g[first].contains("Mage") && g[first].contains("Warrior"), "{g:#?}");
	let mage = g.iter().position(|l| l == "  train class only Mage").unwrap_or_else(|| panic!("{g:#?}"));
	assert!(idx(&g, "  turnin 1") < mage as i64, "{g:#?}");
}

#[test]
fn objectives_whose_mobs_share_the_ground_are_one_step() {
	// The CurseForge review: Barrens plainstriders, raptors and zhevra one animal at a time. Work the
	// route does back to back where each other's mobs live is one step; a camp elsewhere stays its own.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 12-15", "zone The Barrens", "",
				"step Crossroads", "  accept 1", "  accept 2", "  accept 3", "",
				"step Plainstriders", "  tip Plainstriders roam the plains.", "  kill 44 quest 1.1", "",
				"step Raptors", "  tip Raptors hunt among them.", "  accept 4", "  collect 69 quest 2.1", "",
				"step Far camp", "  kill 99 quest 3.1", "",
				"step Crossroads again", "  turnin 1", "  turnin 2", "  turnin 3", "",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1413], [0, 0, 100, 0, 1413], [0, 0, 900, 900, 1413]], "zones": { "1413": "The Barrens" }, "quests": [] }),
		frames: json!({ "era": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"44": { "name": "Plainstrider", "spawns": { "1413": { "f": "e", "pts": [[50, 50], [50, 45], [51, 50], [60, 60], [60, 61]] } } },
			"68": { "name": "Raptor", "spawns": { "1413": { "f": "e", "pts": [[50, 47], [50, 50], [51, 49], [60, 60.5]] } } },
			"99": { "name": "Far thing", "spawns": { "1413": { "f": "e", "pts": [[95, 95], [94, 95], [95, 94]] } } }
		}),
		items: json!({ "69": { "name": "Raptor Head", "drops": { "npc": { "68": 50.0 } } } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) }, { "t": "accept", "q": 2, "pt": 0, "from": f("a", 8) }, { "t": "accept", "q": 3, "pt": 0, "from": f("a", 9) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "from": f("a", 13) },
			{ "t": "task", "q": 2, "task": 0, "pt": 1, "from": f("a", 18) },
			{ "t": "task", "q": 3, "task": 0, "pt": 2, "from": f("a", 21) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 24) }, { "t": "turnin", "q": 2, "pt": 0, "from": f("a", 25) }, { "t": "turnin", "q": 3, "pt": 0, "from": f("a", 26) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let s = g.iter().position(|l| l.ends_with(": kill these as you meet them")).unwrap_or_else(|| panic!("{g:#?}"));
	let next = g[s + 1..].iter().position(|l| l.starts_with("step ")).map_or(g.len(), |k| s + 1 + k);
	let block = &g[s..next];
	assert!(block.iter().any(|l| l == "  kill 44 quest 1.1") && block.iter().any(|l| l == "  collect 69 quest 2.1"), "{g:#?}");
	assert!(block.iter().any(|l| l == "  tip Plainstriders roam the plains.") && block.iter().any(|l| l == "  tip Raptors hunt among them."), "{g:#?}");
	assert!(!block.iter().any(|l| l.contains("kill 99")), "{g:#?}");
	// (The accept at the camp stays in its place among the goals, and every goal keeps its own place:
	// no search circuit, which would move the compiler's camp for each goal to shared spots.)
	assert!(idx(&g, "  collect 69 quest 2.1") == idx(&g, "  accept 4") + 1 && idx(&g, "  accept 4") > s as i64, "{g:#?}");
	assert!(!block.iter().any(|x| x == "  loop"), "{g:#?}");
}

#[test]
fn a_class_step_waits_for_the_level_its_quests_need() {
	// c10 Dwarf/Human Paladins: Tome of Divinity (level 12) accepted at 9.7. The class step goes on
	// the route's first later pass through its zone at that level.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 9-13", "zone Durotar", "", "step Hub", "  accept 1", "", "step Tome", "  only Paladin", "  accept 7", "", "step Camp", "  turnin 1", "", "step Later", "  accept 2", ""],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1411]], "zones": { "1411": "Durotar" }, "quests": [] }),
		quests: json!({ "7": { "title": "Tome", "minLevel": 12 } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 9.5, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 1, "lvl": 9.7, "pt": 0, "from": f("a", 14) },
			{ "t": "accept", "q": 2, "lvl": 12.1, "pt": 0, "from": f("a", 17) }
		] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  accept 2") < idx(&g, "  accept 7"), "{g:#?}");
}

#[test]
fn a_class_accept_waits_for_its_level_with_its_quests_lines() {
	// c10 Human, Goldshire at 10: `accept 2998 only Paladin` (Tome of Divinity, level 12) among the
	// class accepts of an everyone step. It waits for the route's next step in Elwynn at 12; its
	// hand-in after it stays after it.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 9-13", "zone Durotar", "", "step Goldshire", "  accept 1", "  accept 7 only Paladin", "", "step Camp", "  turnin 1", "", "step Later", "  accept 2", "", "step Stormwind", "  turnin 7 only Paladin", "  turnin 2", ""],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1411]], "zones": { "1411": "Durotar" }, "quests": [] }),
		quests: json!({ "7": { "title": "Tome", "minLevel": 12 } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 9.5, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 1, "lvl": 9.7, "pt": 0, "from": f("a", 11) },
			{ "t": "accept", "q": 2, "lvl": 12.1, "pt": 0, "from": f("a", 14) },
			{ "t": "turnin", "q": 2, "lvl": 12.5, "pt": 0, "from": f("a", 18) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let a = idx(&g, "  accept 7 only Paladin");
	assert!(idx(&g, "  turnin 1") < a && a < idx(&g, "  turnin 7 only Paladin"), "{g:#?}");
}

#[test]
fn steps_at_one_npc_in_a_row_are_one_step() {
	// c10 Skyborne, Zephras Isle: Teeri's accepts and turn-ins written as two steps in a row.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 5-8", "zone Durotar", "", "step Teeri", "  accept 1", "", "step Teeri's hut", "  turnin 2", "  accept 3", "", "step Field", "  turnin 1", ""],
		)],
		quests: json!({ "1": { "title": "One", "start": { "npc": [5] } }, "2": { "title": "Two", "end": { "npc": [5] } }, "3": { "title": "Three", "start": { "npc": [5] } } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "from": f("a", 7) }, { "t": "turnin", "q": 2, "from": f("a", 10) }, { "t": "accept", "q": 3, "from": f("a", 11) }, { "t": "turnin", "q": 1, "from": f("a", 14) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l == "step Teeri's hut"), "{g:#?}");
	assert!(idx(&g, "  accept 1") < idx(&g, "  turnin 2") && idx(&g, "  accept 3") < idx(&g, "step Field"), "{g:#?}");
}

#[test]
fn an_area_step_takes_a_race_objective_along_and_merges_labels() {
	// c10 Westfall: the Dwarf/Gnome well vial rides along in the step at its own point; the second
	// step's label goes to the first's. A step with a hand-in is not merged (#621: the oats stay with
	// Verna's hand-in).
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 12-15", "zone The Barrens", "",
				"step Crossroads", "  accept 1", "  accept 2", "  accept 4", "",
				"step Plainstriders", "  label plains", "  kill 44 quest 1.1", "",
				"step Raptors", "  label raptors", "  collect 69 quest 2.1", "  collect 70 quest 4.1 @50,50 only Orc", "",
				"step Grenda", "  collect 69 quest 2.1", "  turnin 4", "",
				"step Crossroads again", "  along until raptors", "  turnin 1", "  turnin 2", "",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1413], [0, 0, 100, 0, 1413]], "zones": { "1413": "The Barrens" }, "quests": [] }),
		frames: json!({ "era": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"44": { "name": "Plainstrider", "spawns": { "1413": { "f": "e", "pts": [[50, 50], [50, 45], [51, 50], [60, 60], [60, 61]] } } },
			"68": { "name": "Raptor", "spawns": { "1413": { "f": "e", "pts": [[50, 47], [50, 50], [51, 49], [60, 60.5]] } } }
		}),
		items: json!({ "69": { "name": "Raptor Head", "drops": { "npc": { "68": 50.0 } } } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) }, { "t": "accept", "q": 2, "pt": 0, "from": f("a", 8) }, { "t": "accept", "q": 4, "pt": 0, "from": f("a", 9) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "from": f("a", 13) },
			{ "t": "task", "q": 2, "task": 0, "pt": 1, "from": f("a", 17) },
			{ "t": "turnin", "q": 4, "pt": 1, "from": f("a", 22) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 26) }, { "t": "turnin", "q": 2, "pt": 0, "from": f("a", 27) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let s = g.iter().position(|l| l.ends_with(": kill these as you meet them")).unwrap_or_else(|| panic!("{g:#?}"));
	let t = g.iter().position(|l| l == "step Grenda").unwrap_or_else(|| panic!("{g:#?}"));
	let block = &g[s..t];
	assert!(block.iter().any(|l| l == "  collect 70 quest 4.1 @50,50 only Orc") && block.iter().any(|l| l == "  label plains"), "{g:#?}");
	assert!(!g.iter().any(|l| l.contains("label raptors")) && g.iter().any(|l| l == "  along until plains"), "{g:#?}");
	assert!(g[t + 1..].iter().take_while(|l| !l.is_empty()).any(|l| l == "  turnin 4"), "{g:#?}");
}

#[test]
fn an_along_step_between_two_halves_of_a_camp_goes_before_the_area_step() {
	// c10 Redridge: "Blackrock Champion on the way" between two steps of Render's Valley.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 12-15", "zone The Barrens", "",
				"step Crossroads", "  accept 1", "  accept 2", "  accept 3", "",
				"step Plainstriders", "  kill 44 quest 1.1", "",
				"step Champion on the way", "  along until back", "  kill 99 quest 3.1", "",
				"step Raptors", "  collect 69 quest 2.1", "",
				"step Crossroads again", "  label back", "  turnin 1", "  turnin 2", "  turnin 3", "",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1413], [0, 0, 100, 0, 1413]], "zones": { "1413": "The Barrens" }, "quests": [] }),
		frames: json!({ "era": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"44": { "name": "Plainstrider", "spawns": { "1413": { "f": "e", "pts": [[50, 50], [50, 45], [51, 50], [60, 60], [60, 61]] } } },
			"68": { "name": "Raptor", "spawns": { "1413": { "f": "e", "pts": [[50, 47], [50, 50], [51, 49], [60, 60.5]] } } },
			"99": { "name": "Champion", "spawns": { "1413": { "f": "e", "pts": [[55, 55]] } } }
		}),
		items: json!({ "69": { "name": "Raptor Head", "drops": { "npc": { "68": 50.0 } } } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) }, { "t": "accept", "q": 2, "pt": 0, "from": f("a", 8) }, { "t": "accept", "q": 3, "pt": 0, "from": f("a", 9) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "from": f("a", 12) },
			{ "t": "task", "q": 3, "task": 0, "pt": 1, "from": f("a", 16) },
			{ "t": "task", "q": 2, "task": 0, "pt": 1, "from": f("a", 19) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 23) }, { "t": "turnin", "q": 2, "pt": 0, "from": f("a", 24) }, { "t": "turnin", "q": 3, "pt": 0, "from": f("a", 25) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let s = g.iter().position(|l| l.ends_with(": kill these as you meet them")).unwrap_or_else(|| panic!("{g:#?}"));
	assert!(idx(&g, "step Champion on the way") < s as i64 && idx(&g, "  collect 69 quest 2.1") > s as i64 && idx(&g, "  kill 44 quest 1.1") > s as i64, "{g:#?}");
}

#[test]
fn a_second_training_right_after_one_is_left_to_the_classes_with_work_there() {
	// c10 Dwarf: the route trains at Ironforge, then v1's Kharanos step trains again with the Hunter's
	// taming quest: everyone walked back out of the city and in for the tram.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 10-12", "zone Ironforge", "", "step Ironforge", "  train class", "", "step Kharanos", "  zone Dun Morogh", "  train class", "  accept 6064 only Hunter", "", "step Again", "  train class only Hunter,Mage", "  accept 2", "", "step Tram", "  accept 1", ""],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "train", "from": f("a", 7) }, { "t": "accept", "q": 6064, "from": f("a", 12) }, { "t": "accept", "q": 2, "from": f("a", 16) }, { "t": "accept", "q": 1, "from": f("a", 19) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let k = idx(&g, "step Kharanos") as usize;
	assert!(g[k + 1] == "  only Hunter" && !g[k..].iter().take_while(|l| !l.is_empty()).any(|l| l.trim() == "train class"), "{g:#?}");
	// (A class list the training before covers: also gone.)
	assert!(g.iter().any(|l| l == "  accept 2") && !g.iter().any(|l| l.contains("train class only")), "{g:#?}");
}

#[test]
fn a_class_detour_nearer_where_the_route_goes_on_walks_there() {
	// c10 Dwarf Paladins fly from Thelsamar to Ironforge; the route goes on at the gates below it: they
	// walk down, not fly back to Thelsamar first.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Hub", "  accept 1", "", "step Trainer", "  only Shaman", "  fly \"Orgrimmar\"", "  train class", "", "step Camp", "  turnin 1", ""],
		)],
		world: travel_world(),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 3, "from": f("a", 7), "items": [{ "t": "getfp", "node": 1 }] },
            { "t": "turnin", "q": 1, "pt": 0, "from": f("a", 15) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let t = run(&c, None).read("a");
	assert!(!t.iter().any(|l| l == "step Back to Crossroads"), "{t:#?}");
}

#[test]
fn no_bare_goto_for_the_routes_races_within_a_zone_of_a_shared_guide() {
	// c10 Orc: "The Barrens" gotos `only Orc,Troll` between the other races' Crossroads steps, before
	// a step of theirs whose own goals lead there anyway.
	let mut world = travel_world();
	world["quests"] = json!([{ "id": 7, "giver": 1, "ender": 1 }]);
	let c = Case {
		files: vec![
			("start", lines(&START_OT, &["", "step Den", "  accept 1", ""])),
			("shared", vec!["guide t/shared", "title Shared", "levels 5-9", "zone Durotar", "", "step Hub", "  turnin 1", "", "step Far", "  accept 7", "", "step Back", "  accept 2", ""]),
		],
		world,
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) },
            { "t": "turnin", "q": 1, "pt": 0, "from": f("shared", 7) },
            { "t": "accept", "q": 2, "pt": 0, "from": f("shared", 14) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("shared");
	assert!(g.iter().any(|l| l == "step Far") && !g.iter().any(|l| l.starts_with("  goto ")), "{g:#?}");
}

#[test]
fn a_step_right_after_one_at_the_same_place_is_one_step() {
	// c10 Orc Durotar: two "Sen'jin Village" steps around a section comment, the second tipped
	// "Follow the road east out of the valley" though the player stands there.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 5-8", "zone Durotar", "",
				"step Sen'jin Village", "  accept 1", "",
				"# ---- Sen'jin and Razor Hill", "",
				"step Sen'jin Village", "  tip Follow the road east out of the valley to Sen'jin Village. Vel'rin stands by the huts.", "  accept 2", "",
				"step Camp", "  turnin 1", "  turnin 2", "",
			],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "from": f("a", 7) }, { "t": "accept", "q": 2, "from": f("a", 13) }, { "t": "turnin", "q": 1, "from": f("a", 16) }, { "t": "turnin", "q": 2, "from": f("a", 17) }
		] }),
		// (Vel'rin and Pa'zula stand together: quest givers at points 0 and 1, 10 yd apart.)
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 10, 0, 1411], [1, 1, 900, 900, 1411]], "zones": { "1411": "Durotar" }, "quests": [{ "id": 1, "giver": 0, "ender": 2 }, { "id": 2, "giver": 1, "ender": 2 }] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert_eq!(g.iter().filter(|l| *l == "step Sen'jin Village").count(), 1, "{g:#?}");
	let k = idx(&g, "step Sen'jin Village") as usize;
	assert!(g[k + 1] == "  accept 1" && g[k + 2] == "  tip Vel'rin stands by the huts." && g[k + 3] == "  accept 2", "{g:#?}");
}

#[test]
fn a_step_whose_every_goal_is_a_class_s_is_that_class_s_and_the_next_names_its_zone() {
	// c10 Horde Ashenvale: the Shamans' Brine hand-in (`zone The Barrens`, `turnin 1534 only Shaman`)
	// before Alonso: everyone else read Alonso's goto in the Barrens, and the travel repair dropped it.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 20-25", "zone Ashenvale", "",
				"step Camp", "  accept 1", "",
				"step Brine", "  zone The Barrens", "  turnin 7 only Shaman", "",
				"step Alonso", "  goto 42.4,70 \"Alonso\"", "  turnin 1", "",
			],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "from": f("a", 7) }, { "t": "turnin", "q": 7, "from": f("a", 11) }, { "t": "turnin", "q": 1, "from": f("a", 15) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (b, a) = (idx(&g, "step Brine") as usize, idx(&g, "step Alonso") as usize);
	assert!(g[b + 1] == "  only Shaman" && g[a + 1] == "  zone Ashenvale", "{g:#?}");
}

#[test]
fn an_unnamed_collect_goes_with_the_named_kill_of_its_dropper() {
	// #345 (c10 Undead): the Warlocks' Rattlecage skulls went before Venya's hand-in, in her step at the
	// church, not with the Rattlecage kills.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "",
				"step Sarvis", "  accept 3901", "  accept 1470 only Warlock", "",
				"step Rattlecages", "  kill 1890 quest 3901.1", "  collect 6281 quest 1470.1 only Warlock", "",
				"step Venya", "  turnin 1470 only Warlock", "",
				"step Back", "  turnin 3901", "",
			],
		)],
		items: json!({ "6281": { "name": "Rattlecage Skull", "drops": { "npc": { "1890": 40.0 } } } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 3901, "from": f("a", 7) },
			{ "t": "task", "q": 3901, "task": 0, "from": f("a", 11) }, { "t": "turnin", "q": 1470, "from": f("a", 15) }, { "t": "turnin", "q": 3901, "from": f("a", 18) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert_eq!(idx(&g, "  collect 6281 quest 1470.1 only Warlock"), idx(&g, "  kill 1890 quest 3901.1") + 1, "{g:#?}");
}

#[test]
fn with_route_legs_a_cave_mouth_into_the_next_piece_stays() {
	// #328 (c10 NightElf): v1's "Shadowthread Cave" mouth before the eggs went with the gap's travel.
	let c = Case {
		files: vec![
			("start", vec!["guide t/start", "title S", "race Human", "levels 50-55", "zone Silithus", "next t/shared", "", "step Hold", "  accept 1", ""]),
			("shared", vec!["guide t/shared", "title Shared", "levels 55-60", "zone Silithus", "", "step Early", "  accept 2", "", "step Into Silithus", "  goto 10.0,10.0 \"Toward the pass\"", "", "step Cave", "  goto 50.5,50.5 \"Cave mouth\"", "", "step Cenarion Hold", "  turnin 1", ""]),
		],
		world: json!({ "points": [[1, 1, -900, -900, 1451], [1, 1, 10, 10, 1451]], "zones": { "1451": "Silithus" }, "quests": [], "inns": [], "nodes": [] }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [{ "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) }, { "t": "turnin", "q": 1, "pt": 1, "from": f("shared", 16) }, { "t": "accept", "q": 2, "pt": 1, "from": f("shared", 7) }] }),
		frames: json!({ "era": { "1451": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("shared");
	assert!(pick(&g, r"^\s+goto").contains(&"  goto 50.5,50.5 \"Cave mouth\"".to_string()), "{g:#?}");
}

#[test]
fn a_class_accept_is_taken_at_the_first_step_by_its_giver() {
	// c12 Undead Warlock (Fitz): Venya's Piercing the Veil (1470, level 1), 12 yd from Sarvis, was only
	// taken in v1's later "Aramis and Venya" step, after the first Rattlecage pass.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "",
				"step Shadow Priest Sarvis", "  accept 364", "",
				"step Mindless Zombies", "  kill 1501 quest 364.1", "",
				"step Back to Sarvis", "  turnin 364", "",
				"step Aramis and Venya", "  only Paladin,Warlock", "  accept 1470 only Warlock", "",
			],
		)],
		quests: json!({
			"364": { "title": "The Mindless Ones", "start": { "npc": [1569] }, "end": { "npc": [1569] }, "minLevel": 1 },
			"1470": { "title": "Piercing the Veil", "start": { "npc": [5667] }, "end": { "npc": [5667] }, "minLevel": 1 }
		}),
		npcs: json!({
			"1569": { "name": "Shadow Priest Sarvis", "spawns": { "1420": { "f": "e", "pts": [[30.84, 66.2]] } } },
			"5667": { "name": "Venya Marthand", "spawns": { "1420": { "f": "e", "pts": [[30.98, 66.41]] } } },
			"1501": { "name": "Mindless Zombie", "spawns": { "1420": { "f": "e", "pts": [[35, 60], [36, 61], [35, 62]] } } }
		}),
		frames: json!({ "era": { "1420": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 364, "lvl": 1.0, "from": f("a", 7) }, { "t": "task", "q": 364, "task": 0, "lvl": 1.2, "from": f("a", 10) },
			{ "t": "turnin", "q": 364, "lvl": 1.8, "from": f("a", 13) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let s = idx(&g, "step Shadow Priest Sarvis") as usize;
	assert_eq!(g[s + 2], "  accept 1470 only Warlock", "{g:#?}");
	assert!(!g.iter().any(|l| l == "step Aramis and Venya"), "{g:#?}");
}

/// v1 steps around a class chain the route does not take (`steps`, after a route step "Hub" taking
/// quest 1), with `pre` the chain's prerequisites: the written guide.
fn class_chain(steps: &[&'static str], pre: Value) -> Vec<String> {
	let mut lines = vec!["guide t/a", "title A", "levels 1-20", "zone Tirisfal Glades", "", "step Hub", "  accept 1", ""];
	lines.extend_from_slice(steps);
	let c = Case { files: vec![("a", lines)], quests: pre, route: json!({ "diff": {}, "order": [{ "t": "accept", "q": 1, "from": f("a", 7) }] }), route_travel: true, ..Case::default() };
	run(&c, None).read("a")
}

#[test]
fn undead_warlock_binding_waits_for_creature_of_the_void() {
	// c12w: The Binding (1471) in the Undercity before Creature of the Void (1473) is handed in.
	let g = class_chain(
		&["step The Undercity", "  only Warlock", "  zone Undercity", "  accept 1471 only Warlock", "  use 6284 @86.6,27.1 only Warlock", "  kill 5676 quest 1471.1 only Warlock", "  turnin 1471 only Warlock", "", "step Perrine's Chest", "  only Warlock", "  zone Tirisfal Glades", "  collect 6285 quest 1473.1", "", "step Back", "  only Warlock", "  zone Undercity", "  turnin 1473 only Warlock", "", "step Brill", "  accept 2", ""],
		json!({ "1471": { "title": "The Binding", "pre": [1473] }, "1473": { "title": "Creature of the Void", "next": 1471 } }),
	);
	let (t, a) = (idx(&g, "  turnin 1473 only Warlock"), idx(&g, "  accept 1471 only Warlock"));
	assert!(t < a && idx(&g, "  use 6284 @86.6,27.1 only Warlock") > a && idx(&g, "  turnin 1471 only Warlock") > a, "{g:#?}");
	// (Its own step, on its own map, and Brill reads on Tirisfal again... its zone is named.)
	assert!(g[a as usize - 1] == "  zone Undercity", "{g:#?}");
}

#[test]
fn orc_warlock_binding_waits_for_creature_of_the_void() {
	// c12w Orc/Troll: 1504 at Gan'rul before 1501 is handed in.
	let g = class_chain(
		&["step Gan'rul", "  only Warlock", "  zone Orgrimmar", "  accept 1504", "  kill 5676 quest 1504.1", "  turnin 1504", "", "step Tablet of Verga", "  only Warlock", "  zone Durotar", "  collect 6535 quest 1501.1", "", "step The Binding", "  only Warlock", "  zone Orgrimmar", "  turnin 1501", ""],
		json!({ "1504": { "title": "The Binding", "pre": [1501] }, "1501": { "title": "Creature of the Void" } }),
	);
	assert!(idx(&g, "  turnin 1501") < idx(&g, "  accept 1504") && idx(&g, "  accept 1504") < idx(&g, "  turnin 1504"), "{g:#?}");
}

#[test]
fn call_of_fire_follow_ups_move_with_the_late_hand_in() {
	// c12w Troll Shaman: 1526, its ember, its hand-in and 1527's accept before 1525 is handed in.
	let g = class_chain(
		&["step Telf Joolam", "  only Shaman", "  zone Durotar", "  accept 1526", "  collect 6655 quest 1526.1", "  turnin 1526", "  accept 1527", "", "step Fire Tar", "  only Shaman", "  zone The Barrens", "  collect 5026 quest 1525.1", "", "step Telf again", "  only Shaman", "  zone Durotar", "  turnin 1525", "", "step Kranal Fiss", "  only Shaman", "  zone The Barrens", "  turnin 1527", ""],
		json!({ "1525": { "title": "Call of Fire" }, "1526": { "title": "Call of Fire", "pre": [1525] }, "1527": { "title": "Call of Fire", "pre": [1526] } }),
	);
	let order: Vec<i64> = ["  turnin 1525", "  accept 1526", "  collect 6655 quest 1526.1", "  turnin 1526", "  accept 1527", "  turnin 1527"].iter().map(|l| idx(&g, l)).collect();
	assert!(order.windows(2).all(|w| w[0] < w[1]), "{order:?} {g:#?}");
}

#[test]
fn human_warlock_binding_waits_for_surena() {
	// c12w Human: The Binding (1689) before Surena Caledon (1688) is handed in.
	let g = class_chain(
		&["step The Binding", "  only Warlock", "  zone Stormwind City", "  accept 1689", "  complete 1689", "  turnin 1689", "", "step Surena Caledon", "  only Warlock", "  zone Elwynn Forest", "  collect 6810 quest 1688.1", "", "step Gakin", "  only Warlock", "  zone Stormwind City", "  turnin 1688", ""],
		json!({ "1689": { "title": "The Binding", "pre": [1688] }, "1688": { "title": "Surena Caledon" } }),
	);
	assert!(idx(&g, "  turnin 1688") < idx(&g, "  accept 1689") && idx(&g, "  accept 1689") < idx(&g, "  complete 1689"), "{g:#?}");
}

#[test]
fn human_paladin_tome_follow_up_waits_and_keeps_its_map() {
	// c12w Westfall: 1787 taken before 1786 is handed in, and Henze's Symbol read on Stormwind's map.
	let g = class_chain(
		&["step Henze Faulk", "  only Paladin", "  zone Elwynn Forest", "  accept 1787", "  use 6866 @72.6,51.4", "  turnin 1787", "", "step Stormwind", "  only Paladin", "  zone Stormwind City", "  turnin 1786", "", "step Westfall", "  zone Westfall", "  accept 2", ""],
		json!({ "1787": { "title": "The Tome of Divinity", "pre": [1786] }, "1786": { "title": "The Tome of Divinity" } }),
	);
	let a = idx(&g, "  accept 1787") as usize;
	assert!(idx(&g, "  turnin 1786") < a as i64 && idx(&g, "  use 6866 @72.6,51.4") > a as i64, "{g:#?}");
	assert!(g[a - 1] == "  zone Elwynn Forest", "{g:#?}");
}

/// Brill as c12w wrote it (Fitz, #740): Holland, then Zygand, then the Discipline round in town, then
/// Dillinger's A Putrid Task, though the walk from Holland to Zygand passes him. Positions in yards:
/// Holland (0,0) at the north-west edge, Dillinger (35,80), Zygand (140,90); the road in from the
/// west, the field to the east.
fn brill_case() -> Case {
	let a = vec![
		"guide t/a", "title A", "levels 1-10", "zone Tirisfal Glades", "",
		"step Gordo", "  accept 5481", "",
		"step Brill", "  turnin 5481                         -- Junior Apothecary Holland", "  accept 5482", "  turnin 383                          -- Executor Zygand", "  accept 427", "",
		"step Discipline", "  goto 60.6,52.0 \"Brill\"", "  complete 99134", "",
		"step Brill", "  accept 404                          -- Deathguard Dillinger", "",
		"step The fields", "  kill 1535 quest 427.1", "",
	];
	let q = |title: &str, min: f64| json!({ "title": title, "minLevel": min, "level": 6 });
	Case {
		files: vec![("a", a)],
		world: json!({
			"points": [[0, 0, -500, 0, 1420], [0, 0, 0, 0, 1420], [0, 0, 35, 80, 1420], [0, 0, 140, 90, 1420], [0, 0, 120, 95, 1420], [0, 0, 900, 100, 1420]],
			"zones": { "1420": "Tirisfal Glades" },
			"quests": [
				{ "id": 5481, "giver": 0, "ender": 1, "tasks": [] }, { "id": 5482, "giver": 1, "ender": 1, "tasks": [] },
				{ "id": 383, "giver": 5, "ender": 3, "tasks": [] }, { "id": 427, "giver": 3, "ender": 3, "tasks": [{ "pt": 5 }] },
				{ "id": 99134, "giver": 3, "ender": 3, "tasks": [{ "pt": 4 }] }, { "id": 404, "giver": 2, "ender": 2, "tasks": [] }
			]
		}),
		quests: json!({ "5481": q("Gordo's Task", 5.0), "5482": q("Doom Weed", 5.0), "383": q("Vital Intelligence", 2.0), "427": q("At War With The Scarlet Crusade", 4.0), "99134": q("Discipline", 4.0), "404": q("A Putrid Task", 4.0) }),
		frames: json!({ "era": { "1420": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 5481, "pt": 0, "lvl": 6.0, "from": f("a", 7) },
			{ "t": "turnin", "q": 5481, "pt": 1, "lvl": 6.0, "from": f("a", 10) },
			{ "t": "accept", "q": 5482, "pt": 1, "lvl": 6.1, "from": f("a", 11) },
			{ "t": "turnin", "q": 383, "pt": 3, "lvl": 6.1, "from": f("a", 12) },
			{ "t": "accept", "q": 427, "pt": 3, "lvl": 6.2, "from": f("a", 13) },
			{ "t": "task", "q": 99134, "task": 0, "pt": 4, "lvl": 6.2, "from": f("a", 17) },
			{ "t": "accept", "q": 404, "pt": 2, "lvl": 6.2, "from": f("a", 20) },
			{ "t": "task", "q": 427, "task": 0, "pt": 5, "lvl": 6.3, "from": f("a", 23) }
		] }),
		route_travel: true,
		..Case::default()
	}
}

#[test]
fn a_hub_visit_takes_its_ready_lines_in_one_sweep() {
	let g = run(&brill_case(), None).read("a");
	// One Brill step, west to east: Holland, Dillinger (on the way), Zygand.
	let s = idx(&g, "step Brill") as usize;
	let (h, d, z) = (idx(&g, "  accept 5482"), idx(&g, "  accept 404                          -- Deathguard Dillinger"), idx(&g, "  turnin 383                          -- Executor Zygand"));
	assert!(s as i64 + 1 < h && h < d && d < z, "{g:#?}");
	assert!(!g[s + 1..z as usize].iter().any(|l| l.starts_with("step ")), "{g:#?}");
	// Nothing left for a later Brill step.
	assert_eq!(g.iter().filter(|l| *l == "step Brill").count(), 1, "{g:#?}");
}

#[test]
fn without_route_legs_the_route_order_stands() {
	let mut c = brill_case();
	c.route_travel = false;
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  accept 404                          -- Deathguard Dillinger") > idx(&g, "  complete 99134"), "{g:#?}");
}

#[test]
fn a_split_steps_tip_about_an_npc_goes_with_that_npcs_piece() {
	// #742 (c12w Undead l.279): v1's Solliden step takes Simmer's quest and Calvin's duel; the route
	// takes Simmer's early and the duel after Brill. The first piece kept the whole tip, "Calvin ...
	// wants a duel", where only Simmer's quest is.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 3-8", "zone Durotar", "",
				"step Deathknell", "  accept 2", "",
				"step Calvin Montague", "  tip Walk on west to the farm. Deathguard Simmer stands at the farm; Calvin, by the farmhouse, wants a duel: talk to him.", "  accept 1", "  accept 3", "  turnin 3", "",
				"step Brill", "  turnin 2", "  turnin 1", "",
			],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 2, "from": f("a", 7) }, { "t": "accept", "q": 1, "from": f("a", 11) }, { "t": "turnin", "q": 2, "from": f("a", 16) },
			{ "t": "accept", "q": 3, "from": f("a", 12) }, { "t": "turnin", "q": 3, "from": f("a", 13) }, { "t": "turnin", "q": 1, "from": f("a", 17) }
		] }),
		quests: json!({
			"1": { "title": "Fields of Grief", "start": { "npc": [10] }, "end": { "npc": [30] } },
			"2": { "title": "A Rogue's Deal", "start": { "npc": [20] }, "end": { "npc": [30] } },
			"3": { "title": "A Rogue's Deal", "start": { "npc": [20] }, "end": { "npc": [20] }, "pre": [2] }
		}),
		npcs: json!({ "10": { "name": "Deathguard Simmer" }, "20": { "name": "Calvin Montague" }, "30": { "name": "Innkeeper Renee" } }),
		// (Simmer and Calvin 150 yd apart, the inn far off.)
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 150, 0, 1411], [1, 1, 900, 900, 1411]], "zones": { "1411": "Durotar" }, "quests": [{ "id": 1, "giver": 0, "ender": 2 }, { "id": 2, "giver": 1, "ender": 2 }, { "id": 3, "giver": 1, "ender": 1 }] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (first, second) = (idx(&g, "  accept 1") as usize, idx(&g, "  accept 3") as usize);
	assert!(first < second, "{g:#?}");
	assert_eq!(g[first - 1], "  tip Walk on west to the farm. Deathguard Simmer stands at the farm.", "{g:#?}");
	assert_eq!(g[second - 1], "  tip Calvin, by the farmhouse, wants a duel: talk to him.", "{g:#?}");
}

#[test]
fn a_hub_loop_runs_clockwise_when_it_walks_no_farther() {
	// Four quest givers at a square's corners, the road in and out to the south: the loop round the
	// square walks as far either way, and the route lists them counter-clockwise (south-east first).
	// Fitz told players the loops run clockwise: south-west, north-west, north-east, south-east.
	let a = vec!["guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "", "step SE", "  accept 4", "", "step NE", "  accept 3", "", "step NW", "  accept 2", "", "step SW", "  accept 1", "", "step Road", "  kill 9 quest 1.1", ""];
	// World x runs north, y west: SW (0,0), NW (100,0), NE (100,-100), SE (0,-100); the road (-200,-50).
	let c = Case {
		files: vec![("a", a)],
		world: json!({
			"points": [[0, 0, -200, -50, 1420], [0, 0, 0, 0, 1420], [0, 0, 100, 0, 1420], [0, 0, 100, -100, 1420], [0, 0, 0, -100, 1420]],
			"zones": { "1420": "Tirisfal Glades" },
			"quests": [
				{ "id": 1, "giver": 1, "ender": 1, "tasks": [{ "pt": 0 }] }, { "id": 2, "giver": 2, "ender": 2, "tasks": [] },
				{ "id": 3, "giver": 3, "ender": 3, "tasks": [] }, { "id": 4, "giver": 4, "ender": 4, "tasks": [] }
			]
		}),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 }, "3": { "title": "Three", "minLevel": 1 }, "4": { "title": "Four", "minLevel": 1 } }),
		frames: json!({ "era": { "1420": { "top": 1000, "bottom": -1000, "left": 1000, "right": -1000, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 4, "pt": 4, "lvl": 1.0, "from": f("a", 7) },
			{ "t": "accept", "q": 3, "pt": 3, "lvl": 1.0, "from": f("a", 10) },
			{ "t": "accept", "q": 2, "pt": 2, "lvl": 1.0, "from": f("a", 13) },
			{ "t": "accept", "q": 1, "pt": 1, "lvl": 1.0, "from": f("a", 16) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "lvl": 1.2, "from": f("a", 19) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let at: Vec<i64> = (1..=4).map(|q| idx(&g, &format!("  accept {q}"))).collect();
	assert!(at.windows(2).all(|w| w[0] >= 0 && w[0] < w[1]), "{at:?} {g:#?}");
}

#[test]
fn the_same_way_for_several_races_is_one_step() {
	let races: Vec<String> = ["Orc", "Troll", "Undead"].iter().map(|s| s.to_string()).collect();
	let step = |title: &str, only: &str, goal: &str| format!("step {title}\n  only {only}\n  zone Durotar\n  {goal}\n");
	let text = [
		step("Durotar", "Orc", "goto 50.8,13.5 \"Durotar\""),
		step("Zeppelin to Undercity", "Orc", "goto 50.8,13.5 \"Zeppelin to Undercity\""),
		step("Durotar", "Undead", "goto 50.8,13.5 \"Durotar\""),
		step("Zeppelin to Undercity", "Undead", "goto 50.8,13.5 \"Zeppelin to Undercity\""),
		step("Durotar", "Undead,Paladin", "goto 50.8,13.5 \"Durotar\""),
		step("Zeppelin to Undercity", "Troll", "goto 50.8,13.5 \"Zeppelin to Undercity\""),
		step("Durotar", "Troll", "goto 50.8,13.5 \"Durotar\""),
		step("Brill", "Undead", "turnin 1"),
		step("Brill", "Orc", "turnin 1"),
	]
	.join("\n");
	let out = forge_writer::shared::merge_gated_steps(&text, &races);
	let titles: Vec<&str> = out.lines().filter(|l| l.starts_with("step ")).collect();
	assert_eq!(titles, ["step Durotar", "step Zeppelin to Undercity", "step Durotar", "step Brill", "step Brill"], "{out}");
	let onlys: Vec<&str> = out.lines().filter(|l| l.trim_start().starts_with("only ")).collect();
	// (Every race's way is everyone's: no `only`; the Paladins' stays theirs; quest steps stay apart.)
	assert_eq!(onlys, ["  only Undead,Paladin", "  only Undead", "  only Orc"], "{out}");
}

#[test]
fn a_flight_path_learned_twice_in_a_guide_is_learned_once() {
	let mut files = vec![[
		"guide g",
		"",
		"step Darkshire",
		"  getfp \"Darkshire\"",
		"  accept 56",
		"",
		"# ---- Darkshire",
		"",
		"step Darkshire",
		"  zone Duskwood",
		"  getfp \"Darkshire\" npc 2409",
		"",
		"# ---- Tranquil Gardens",
		"",
		"step Darkshire",
		"  only Druid",
		"  getfp \"Darkshire\"",
		"  accept 173",
	]
	.join("\n")];
	forge_writer::post::one_service_line(&mut files);
	let g = &files[0];
	assert_eq!(g.matches("getfp").count(), 1, "{g}");
	assert_eq!(g.matches("step Darkshire").count(), 2, "{g}");
	assert!(g.contains("# ---- Tranquil Gardens") && g.contains("  accept 173"), "{g}");
}

#[test]
fn the_played_chain_passes_a_guide_the_route_has_no_line_in() {
	// (Orc's own Barrens guide: the one shared route writes all its lines in the shared Barrens guide.)
	let a = vec!["guide forever/t/a", "title A", "levels 1-5", "zone Durotar", "next forever/t/b", "", "step A", "  accept 1", ""];
	let b = vec!["guide forever/t/b", "title B", "levels 5-10", "zone Durotar", "next forever/t/c", "", "step B", "  turnin 1", ""];
	let c = vec!["guide forever/t/c", "title C", "levels 10-15", "zone Durotar", "", "step C", "  turnin 1", ""];
	let case = Case {
		files: vec![("t/a", a), ("t/b", b), ("t/c", c)],
		route: json!({ "diff": {}, "order": [{ "t": "accept", "q": 1, "from": f("t/a", 8) }, { "t": "turnin", "q": 1, "from": f("t/c", 7) }] }),
		..Case::default()
	};
	let chain = run(&case, None).out.travel.chain;
	assert_eq!(chain, ["forever/t/a.guide", "forever/t/b.guide", "forever/t/c.guide"]);
}

#[test]
fn an_area_steps_goals_run_nearest_first_with_a_named_higher_level_target_last() {
	// Fitz, Tirisfal "Garren's Haunt: kill these as you meet them": Maggot Eye (level 11, the far hill)
	// was listed first, ahead of the Rot Hides (6-7) just north of Brill. The goals run as a sweep from
	// where the step is entered, the named higher-level target last; the tips follow.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 5-8", "zone The Barrens", "",
				"step Brill", "  accept 1", "  accept 2", "  accept 3", "",
				"step Fields", "  tip Far Raptors roam the east.", "  tip Plainstriders graze by town.", "  collect 69 quest 3.1", "  kill 44 quest 1.1", "  kill 45 quest 2.1", "",
				"step Brill again", "  turnin 1", "  turnin 2", "  turnin 3", "",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1413]], "zones": { "1413": "The Barrens" }, "quests": [] }),
		frames: json!({ "era": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"5": { "name": "Elder", "level": 10, "spawns": { "1413": { "f": "e", "pts": [[50, 50]] } } },
			"44": { "name": "Far Raptor", "level": 7, "spawns": { "1413": { "f": "e", "pts": [[60, 60], [61, 60], [60, 61]] } } },
			"45": { "name": "Plainstrider", "level": 6, "spawns": { "1413": { "f": "e", "pts": [[50, 52], [51, 52], [50, 53]] } } },
			"68": { "name": "Maggot Eye", "level": 11, "spawns": { "1413": { "f": "e", "pts": [[52, 51]] } } }
		}),
		items: json!({ "69": { "name": "Maggot Eye's Paw", "drops": { "npc": { "68": 100.0 } } } }),
		quests: json!({
			"1": { "title": "One", "start": { "npc": [5] }, "end": { "npc": [5] } },
			"2": { "title": "Two", "start": { "npc": [5] }, "end": { "npc": [5] } },
			"3": { "title": "Three", "start": { "npc": [5] }, "end": { "npc": [5] } }
		}),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) }, { "t": "accept", "q": 2, "pt": 0, "from": f("a", 8) }, { "t": "accept", "q": 3, "pt": 0, "from": f("a", 9) },
			{ "t": "task", "q": 3, "task": 0, "pt": 0, "from": f("a", 14) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "from": f("a", 15) },
			{ "t": "task", "q": 2, "task": 0, "pt": 0, "from": f("a", 16) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 19) }, { "t": "turnin", "q": 2, "pt": 0, "from": f("a", 20) }, { "t": "turnin", "q": 3, "pt": 0, "from": f("a", 21) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (near, far, named) = (idx(&g, "  kill 45 quest 2.1"), idx(&g, "  kill 44 quest 1.1"), idx(&g, "  collect 69 quest 3.1"));
	assert!(near >= 0 && near < far && far < named, "{g:#?}");
	assert!(idx(&g, "  tip Plainstriders graze by town.") < idx(&g, "  tip Far Raptors roam the east."), "{g:#?}");
}

#[test]
fn a_shared_quests_lines_take_its_accepts_audience() {
	// RevA (c13 Westfall): Testing the Wells' goals said `only Dwarf,Gnome,Skyborne` while its accept
	// and hand-in took Night Elves too (R5). The Druids' Principal Source hand-in stays theirs: its
	// accept is in a Night Elf Druid step.
	let text = [
		"step A", "  accept 1 only Dwarf,Gnome,NightElf,Skyborne", "",
		"step B", "  collect 5 quest 1.1", "  kill 6 quest 1.2 only Dwarf,Gnome,Skyborne", "",
		"step C", "  only NightElf,Druid", "  accept 2", "",
		"step D", "  turnin 2 only NightElf,Skyborne",
	]
	.join("\n");
	let set = |v: &[&str]| v.iter().map(|s| s.to_string()).collect::<std::collections::BTreeSet<String>>();
	let mut by_quest = rustc_hash::FxHashMap::default();
	by_quest.insert(1u32, set(&["Dwarf", "Gnome", "Skyborne-alliance"]));
	by_quest.insert(2u32, set(&["NightElf", "Skyborne-alliance"]));
	let out = forge_writer::shared::tag_audiences(&text, &by_quest, 5, &|_| None);
	let lines: Vec<&str> = out.lines().collect();
	assert!(lines.contains(&"  collect 5 quest 1.1 only Dwarf,Gnome,NightElf,Skyborne"), "{out}");
	assert!(lines.contains(&"  kill 6 quest 1.2 only Dwarf,Gnome,NightElf,Skyborne"), "{out}");
	assert!(lines.contains(&"  turnin 2 only NightElf"), "{out}");
}

/// Three quest givers in one town (Ratchet) 40 yd apart, the road in from the far south.
fn town_world(extra_quests: serde_json::Value) -> serde_json::Value {
	let mut quests = vec![json!({ "id": 1, "giver": 1, "ender": 1 }), json!({ "id": 2, "giver": 2, "ender": 2 }), json!({ "id": 3, "giver": 3, "ender": 3 })];
	quests.extend(extra_quests.as_array().cloned().unwrap_or_default());
	json!({
		"points": [[0, 0, -900, 0, 1420], [0, 0, 0, 0, 1420], [0, 0, 40, 0, 1420], [0, 0, 80, 0, 1420], [0, 0, 900, 900, 1420], [0, 0, 120, 0, 1420]],
		"zones": { "1420": "Tirisfal Glades" },
		"quests": quests
	})
}

fn town_frames() -> serde_json::Value {
	json!({ "era": { "1420": { "top": 1000, "bottom": -1000, "left": 1000, "right": -1000, "c": 0 } } })
}

#[test]
fn a_class_step_closes_its_town_visit() {
	// FlowDiag 2: the class step goes right before the line it waits for, in the middle of the town
	// visit: the Shamans' trip to Islen between two Ratchet stops. It closes the visit now.
	let a = vec![
		"guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "",
		"step One", "  accept 1", "",
		"step Islen", "  only Shaman", "  accept 9", "",
		"step Two", "  accept 2", "",
		"step Three", "  accept 3", "",
	];
	let c = Case {
		files: vec![("a", a)],
		world: town_world(json!([{ "id": 9, "giver": 4, "ender": 4 }])),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 }, "3": { "title": "Three", "minLevel": 1 }, "9": { "title": "Nine", "minLevel": 1, "classes": 64 } }),
		frames: town_frames(),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 1, "lvl": 1.0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 2, "lvl": 1.0, "from": f("a", 14) },
			{ "t": "accept", "q": 3, "pt": 3, "lvl": 1.0, "from": f("a", 17) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let nine = idx(&g, "  accept 9");
	assert!((1..=3).all(|q| (0..nine).contains(&idx(&g, &format!("  accept {q}")))), "{g:#?}");
}

#[test]
fn a_far_step_the_route_does_not_take_waits_for_the_end_of_the_town_visit() {
	// FlowDiag 7: Dokimi's crates at the Crossroads, a v1 step the route does not take, written
	// between two Ratchet stops (a trip out and back); it goes after the visit.
	let a = vec![
		"guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "",
		"step One", "  accept 1", "",
		"step Crates", "  accept 8", "",
		"step Two", "  accept 2", "",
		"step Three", "  accept 3", "",
	];
	let c = Case {
		files: vec![("a", a)],
		world: town_world(json!([{ "id": 8, "giver": 4, "ender": 4 }])),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 }, "3": { "title": "Three", "minLevel": 1 }, "8": { "title": "Crates", "minLevel": 1 } }),
		frames: town_frames(),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 1, "lvl": 1.0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 2, "lvl": 1.0, "from": f("a", 13) },
			{ "t": "accept", "q": 3, "pt": 3, "lvl": 1.0, "from": f("a", 16) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (eight, three) = (idx(&g, "  accept 8"), idx(&g, "  accept 3"));
	assert!(three >= 0 && eight > three, "{g:#?}");
}

#[test]
fn a_flight_path_learned_on_arrival_goes_to_the_step_at_its_flight_master() {
	// FlowDiag 8: `getfp` written first on arrival in Thunder Bluff, before the walk round the town
	// to the flight master; it goes in the town's loop, at the step nearest the flight master.
	let a = vec![
		"guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "",
		"step One", "  accept 1", "",
		"step Two", "  accept 2", "",
		"step Three", "  accept 3", "",
	];
	let mut world = town_world(json!([]));
	world["nodes"] = json!([{ "kind": "fp", "name": "Town", "pt": 5 }]);
	let c = Case {
		files: vec![("a", a)],
		world,
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 }, "3": { "title": "Three", "minLevel": 1 } }),
		frames: town_frames(),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 1, "lvl": 1.0, "from": f("a", 7), "items": [{ "t": "getfp", "node": 0 }] },
			{ "t": "accept", "q": 2, "pt": 2, "lvl": 1.0, "from": f("a", 10) },
			{ "t": "accept", "q": 3, "pt": 3, "lvl": 1.0, "from": f("a", 13) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let fp = g.iter().position(|l| l.starts_with("  getfp \"Town\"")).unwrap_or_else(|| panic!("{g:#?}")) as i64;
	assert!(fp > idx(&g, "  accept 3") && idx(&g, "  accept 3") >= 0, "{g:#?}");
}

#[test]
fn a_buy_is_written_where_the_route_buys() {
	// FlowDiag 6: the route buys Jarl's spices at the Crossroads on its way (the quest's task, keyed to
	// the hand-in line); v1's buy line stayed in Jarl's step, after the walk back to him.
	let a = vec![
		"guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "",
		"step Jarl", "  accept 1", "  buy 50 x1", "  turnin 1", "",
	];
	let c = Case {
		files: vec![("a", a)],
		world: json!({
			"points": [[0, 0, 0, 0, 1420], [0, 0, 900, 900, 1421]],
			"zones": { "1420": "Tirisfal Glades", "1421": "The Barrens" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0, "tasks": [{ "pt": 1 }] }]
		}),
		quests: json!({ "1": { "title": "Spices", "minLevel": 1, "objectives": [{ "type": "item", "id": 50 }] } }),
		frames: json!({ "era": { "1420": { "top": 1000, "bottom": -1000, "left": 1000, "right": -1000, "c": 0 }, "1421": { "top": 2000, "bottom": 0, "left": 2000, "right": 0, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 1.0, "from": f("a", 7) },
			{ "t": "task", "q": 1, "task": 0, "pt": 1, "lvl": 1.0, "from": f("a", 9) },
			{ "t": "turnin", "q": 1, "pt": 0, "lvl": 1.0, "from": f("a", 9) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let buy = g.iter().position(|l| l.starts_with("  buy 50")).expect("buy written") ;
	assert_eq!(g.iter().filter(|l| l.starts_with("  buy 50")).count(), 1, "{g:#?}");
	let title = g[..buy].iter().rev().find(|l| l.starts_with("step ")).unwrap();
	assert_ne!(title, "step Jarl", "{g:#?}");
	assert!((buy as i64) < idx(&g, "  turnin 1"), "{g:#?}");
}

#[test]
fn a_guide_is_not_cut_inside_one_town_visit() {
	// FlowDiag 6: Shady Rest's 1268 closed one guide and its 1251 and 1269 opened the next.
	let a = vec!["guide forever/t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "next forever/t/b", "", "step Far", "  accept 1", "", "step Inn", "  accept 2", ""];
	let b = vec!["guide forever/t/b", "title B", "levels 5-10", "zone Tirisfal Glades", "", "step Inn", "  accept 3", "", "step Away", "  accept 4", ""];
	let c = Case {
		files: vec![("t/a", a), ("t/b", b)],
		world: json!({
			"points": [[0, 0, -900, 0, 1420], [0, 0, 0, 0, 1420], [0, 0, 20, 0, 1420], [0, 0, 900, 900, 1420]],
			"zones": { "1420": "Tirisfal Glades" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 1, "ender": 1 }, { "id": 3, "giver": 2, "ender": 2 }, { "id": 4, "giver": 3, "ender": 3 }]
		}),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 }, "3": { "title": "Three", "minLevel": 1 }, "4": { "title": "Four", "minLevel": 1 } }),
		frames: town_frames(),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 1.0, "from": f("t/a", 8) },
			{ "t": "accept", "q": 2, "pt": 1, "lvl": 1.0, "from": f("t/a", 11) },
			{ "t": "accept", "q": 3, "pt": 2, "lvl": 1.0, "from": f("t/b", 7) },
			{ "t": "accept", "q": 4, "pt": 3, "lvl": 1.0, "from": f("t/b", 10) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let r = run(&c, None);
	let (ga, gb) = (r.read("t/a"), r.read("t/b"));
	assert!(has(&ga, "  accept 2") == has(&ga, "  accept 3"), "{ga:#?} {gb:#?}");
}

#[test]
fn a_v1_step_that_only_learns_a_flight_path_the_route_does_not_go_for_goes() {
	// FlowDiag 9: everyone took the boat from Booty Bay to Ratchet and back for v1's Ratchet flight
	// path step, with no route event in Ratchet.
	let a = vec!["guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "", "step One", "  accept 1", "", "step Ratchet", "  getfp \"Ratchet\"", "", "step Two", "  accept 2", ""];
	let c = Case {
		files: vec![("a", a)],
		world: town_world(json!([])),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 } }),
		frames: town_frames(),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 1, "lvl": 1.0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 2, "lvl": 1.0, "from": f("a", 13) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l.contains("getfp")), "{g:#?}");
}

#[test]
fn an_under_level_class_step_is_not_deferred_into_a_shared_guide() {
	// RevDwarfGnome3 D1: the Dwarf Paladins' Tome of Divinity (level 12) at 11.6 waited for the route's
	// next Ironforge pass, in the shared guides, and was lost with the canonical start's writing of them.
	let start = lines(&START_OT, &["", "step Hub", "  accept 1", "", "step Tome", "  only Paladin", "  accept 9", "", "step Hub again", "  turnin 1", ""]);
	let shared = vec!["guide t/shared", "title Shared", "levels 5-15", "zone Durotar", "", "step Hub", "  accept 2", ""];
	let c = Case {
		files: vec![("t/start", start), ("t/shared", shared)],
		world: json!({
			"points": [[1, 1, 0, 0, 1411], [1, 1, 30, 0, 1411]],
			"zones": { "1411": "Durotar" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 0, "ender": 0 }, { "id": 9, "giver": 1, "ender": 1 }]
		}),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 }, "9": { "title": "Tome", "minLevel": 12, "classes": 2 } }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": 1000, "right": -1000, "c": 1 } } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 11.0, "from": f("t/start", 9) },
			{ "t": "turnin", "q": 1, "pt": 0, "lvl": 11.6, "from": f("t/start", 16) },
			{ "t": "accept", "q": 2, "pt": 0, "lvl": 12.2, "from": f("t/shared", 7) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let r = run(&c, None);
	let g = r.read("t/start");
	assert!(g.iter().any(|l| l.starts_with("  accept 9")), "{g:#?} {:#?}", r.read("t/shared"));
}

#[test]
fn a_swept_steps_goals_never_go_ahead_of_their_quests_accept_there() {
	// routes-opt Human Felwood: Jadefire Run's sweep put `collect 11674 quest 939.1` (Felbind, every
	// satyr) ahead of `accept 939`, which the Flute of Xavaric starts in the same step. A goal of a quest
	// accepted in the step stays after its accept.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 5-8", "zone The Barrens", "",
				"step Brill", "  accept 1", "  accept 2", "",
				"step Fields", "  kill 44 quest 1.1", "  kill 45 quest 2.1", "  accept 4", "  collect 70 quest 4.1", "",
				"step Brill again", "  turnin 1", "  turnin 2", "  turnin 4", "",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1413]], "zones": { "1413": "The Barrens" }, "quests": [] }),
		frames: json!({ "era": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"5": { "name": "Elder", "level": 10, "spawns": { "1413": { "f": "e", "pts": [[50, 50]] } } },
			"44": { "name": "Far Raptor", "level": 7, "spawns": { "1413": { "f": "e", "pts": [[60, 60], [61, 60], [60, 61]] } } },
			"45": { "name": "Plainstrider", "level": 6, "spawns": { "1413": { "f": "e", "pts": [[50, 52], [51, 52], [50, 53]] } } }
		}),
		items: json!({ "70": { "name": "Plainstrider Scale", "drops": { "npc": { "45": 50.0 } } } }),
		quests: json!({
			"1": { "title": "One", "start": { "npc": [5] }, "end": { "npc": [5] } },
			"2": { "title": "Two", "start": { "npc": [5] }, "end": { "npc": [5] } },
			"4": { "title": "Four", "end": { "npc": [5] } }
		}),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) }, { "t": "accept", "q": 2, "pt": 0, "from": f("a", 8) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "from": f("a", 11) },
			{ "t": "task", "q": 2, "task": 0, "pt": 0, "from": f("a", 12) },
			{ "t": "accept", "q": 4, "pt": 0, "from": f("a", 13) },
			{ "t": "task", "q": 4, "task": 0, "pt": 0, "from": f("a", 14) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 17) }, { "t": "turnin", "q": 2, "pt": 0, "from": f("a", 18) }, { "t": "turnin", "q": 4, "pt": 0, "from": f("a", 19) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  accept 4") >= 0 && idx(&g, "  accept 4") < idx(&g, "  collect 70 quest 4.1"), "{g:#?}");
	assert!(idx(&g, "  kill 45 quest 2.1") < idx(&g, "  kill 44 quest 1.1"), "{g:#?}");
}

/// The Barrens plains (A9): plainstriders and raptors, back to back where each other's mobs live, with
/// `raptors` the second step's lines.
fn plains_case(plains: &[&'static str], raptors: &[&'static str]) -> Case {
	let mut lines = vec!["guide t/a", "title A", "levels 12-15", "zone The Barrens", "", "step Crossroads", "  accept 1", "  accept 2", "", "step Plainstriders"];
	lines.extend_from_slice(plains);
	lines.push("");
	lines.push("step Raptors");
	lines.extend_from_slice(raptors);
	lines.extend_from_slice(&["", "step Crossroads again", "  turnin 1", "  turnin 2", ""]);
	let at = |l: &str| f("a", lines.iter().position(|x| *x == l).unwrap() as u32 + 1);
	let (k1, k2) = (at(plains.last().unwrap()), at(raptors.last().unwrap()));
	Case {
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) }, { "t": "accept", "q": 2, "pt": 0, "from": f("a", 8) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "from": k1 },
			{ "t": "task", "q": 2, "task": 0, "pt": 1, "from": k2 },
			{ "t": "turnin", "q": 1, "pt": 0, "from": at("  turnin 1") }, { "t": "turnin", "q": 2, "pt": 0, "from": at("  turnin 2") }
		] }),
		files: vec![("a", lines)],
		world: json!({ "points": [[0, 0, 0, 0, 1413], [0, 0, 100, 0, 1413], [0, 0, 900, 900, 1413]], "zones": { "1413": "The Barrens" }, "quests": [] }),
		frames: json!({ "era": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"44": { "name": "Plainstrider", "spawns": { "1413": { "f": "e", "pts": [[50, 50], [50, 45], [51, 50], [60, 60], [60, 61]] } } },
			"68": { "name": "Raptor", "spawns": { "1413": { "f": "e", "pts": [[50, 47], [50, 50], [51, 49], [60, 60.5]] } } },
			"99": { "name": "Far thing", "spawns": { "1413": { "f": "e", "pts": [[95, 95], [94, 95], [95, 94]] } } }
		}),
		items: json!({ "69": { "name": "Raptor Head", "drops": { "npc": { "68": 50.0 } } }, "70": { "name": "Far Thing's Horn", "drops": { "npc": { "99": 50.0 } } } }),
		route_travel: true,
		..Case::default()
	}
}

/// Puts `add` before line index `r` of guide `a`, moving the route's later lines down; `ev` (its
/// `from` the last added line) goes into the route at `at`.
fn insert_lines(c: &mut Case, r: usize, add: &[&'static str], at: usize, mut ev: Value) {
	let lines = &mut c.files[0].1;
	let n = add.len() as u32;
	lines.splice(r..r, add.iter().copied());
	let order = c.route["order"].as_array_mut().unwrap();
	for o in order.iter_mut() {
		let from = o["from"].as_str().unwrap().to_string();
		let (file, k) = from.rsplit_once(':').unwrap();
		let k: u32 = k.parse().unwrap();
		if k > r as u32 {
			o["from"] = json!(format!("{file}:{}", k + n));
		}
	}
	let last = add.iter().rposition(|l| !l.is_empty()).unwrap();
	ev["from"] = json!(f("a", (r + last) as u32 + 1));
	order.insert(at, ev);
}

/// Puts `step` (a blank after) before the line `before` of guide `a` (see insert_lines).
fn insert_step(c: &mut Case, before: &str, step: &[&'static str], at: usize, ev: Value) {
	let r = c.files[0].1.iter().position(|l| *l == before).unwrap();
	let add: Vec<&'static str> = step.iter().copied().chain(std::iter::once("")).collect();
	insert_lines(c, r, &add, at, ev);
}

/// The merged step's lines (panics when there is none).
fn area_step(g: &[String]) -> Vec<String> {
	let s = g.iter().position(|l| l.ends_with(": kill these as you meet them")).unwrap_or_else(|| panic!("{g:#?}"));
	let next = g[s + 1..].iter().position(|l| l.starts_with("step ")).map_or(g.len(), |k| s + 1 + k);
	g[s..next].to_vec()
}

#[test]
fn camps_on_the_live_map_share_the_ground_too() {
	// c13 Redridge (A9): the gnolls, thrashers and goretusks east of Three Corners have spawns on the
	// live map only, and were never one step.
	let mut c = plains_case(&["  kill 44 quest 1.1"], &["  collect 69 quest 2.1"]);
	let live = |n: &Value| -> Value {
		let mut n = n.clone();
		for (_, e) in n.as_object_mut().unwrap() {
			e["spawns"]["1413"]["f"] = json!("l");
		}
		n
	};
	c.npcs = live(&c.npcs);
	c.frames = json!({ "era": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } }, "forever": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } });
	let g = run(&c, None).read("a");
	let b = area_step(&g);
	assert!(has(&b, "  kill 44 quest 1.1") && has(&b, "  collect 69 quest 2.1"), "{g:#?}");
}

#[test]
fn a_work_line_without_an_objective_number_is_worked_at_its_targets_task() {
	// c13 Duskwood (A9): `collect 1129 quest 101` (ghoul fangs) was placed at quest 101's first task
	// on the route, the skeleton fingers across the forest, and kept apart from the cemetery's step.
	let mut c = plains_case(&["  kill 44 quest 1"], &["  collect 69 quest 2.1"]);
	c.world["quests"] = json!([{ "id": 1, "objs": [{ "oi": 0, "type": "kill", "id": 44, "task": 0 }, { "oi": 1, "type": "kill", "id": 99, "task": 1 }] }]);
	// (The far camp, the quest's other task, first on the route.)
	insert_step(&mut c, "step Plainstriders", &["step Far camp", "  kill 99 quest 1.2"], 2, json!({ "t": "task", "q": 1, "task": 1, "pt": 2 }));
	// (The Crossroads away from the plains: the far camp keeps its place before them.)
	c.world["points"].as_array_mut().unwrap().push(json!([0, 0, -600, -600, 1413]));
	for o in c.route["order"].as_array_mut().unwrap() {
		if o["t"] != "task" {
			o["pt"] = json!(3);
		}
	}
	let g = run(&c, None).read("a");
	let b = area_step(&g);
	assert!(has(&b, "  kill 44 quest 1") && has(&b, "  collect 69 quest 2.1"), "{g:#?}");
}

#[test]
fn a_step_without_a_zone_line_is_in_its_work_points_zone() {
	// c13 Alterac (A9): the Ruins of Alterac's mages (no zone line) and Strahnbrad's camps (`zone
	// Alterac Mountains`) were two steps.
	let c = plains_case(&["  kill 44 quest 1.1"], &["  zone The Barrens", "  collect 69 quest 2.1"]);
	let g = run(&c, None).read("a");
	let b = area_step(&g);
	assert!(has(&b, "  kill 44 quest 1.1") && has(&b, "  collect 69 quest 2.1"), "{g:#?}");
}

#[test]
fn camps_on_one_ground_merge_past_a_stop_at_an_npc_there() {
	// c13 Redridge and Duskwood (A9): Guard Parker at Three Corners between the gnolls and the
	// thrashers, Abercrombie's shack by Raven Hill between the wolves and the cemetery, kept one ground
	// as two steps. The stop goes first, the camps are one step.
	let mut c = plains_case(&["  kill 44 quest 1.1"], &["  collect 69 quest 2.1"]);
	c.world["quests"] = json!([{ "id": 4, "giver": 1, "ender": 1 }]);
	insert_step(&mut c, "step Raptors", &["step Grenda", "  tip Grenda stands among the plainstriders.", "  accept 4"], 3, json!({ "t": "accept", "q": 4, "pt": 1 }));
	let g = run(&c, None).read("a");
	let b = area_step(&g);
	assert!(has(&b, "  kill 44 quest 1.1") && has(&b, "  collect 69 quest 2.1"), "{g:#?}");
	assert!(idx(&g, "  accept 4") < idx(&g, &b[0]), "{g:#?}");
}

#[test]
fn a_camp_only_some_classes_work_is_area_work_with_its_only() {
	// c13 Durotar (T5): the Vile Familiars, `only !Warlock` and `only Warlock`, broke the valley's
	// merge. They are a camp like any other, each line keeping its `only`.
	let mut c = plains_case(&["  kill 44 quest 1.1"], &["  collect 69 quest 2.1"]);
	insert_lines(&mut c, 8, &["  accept 5"], 2, json!({ "t": "accept", "q": 5, "pt": 0 }));
	insert_step(&mut c, "step Raptors", &["step Familiars", "  collect 69 quest 6.1 only Warlock", "  kill 68 quest 5.1 only !Warlock"], 4, json!({ "t": "task", "q": 5, "task": 0, "pt": 1 }));
	let g = run(&c, None).read("a");
	let b = area_step(&g);
	assert!(has(&b, "  kill 44 quest 1.1") && has(&b, "  collect 69 quest 2.1"), "{g:#?}");
	assert!(has(&b, "  kill 68 quest 5.1 only !Warlock") && has(&b, "  collect 69 quest 6.1 only Warlock"), "{g:#?}");
	assert!(!g.iter().any(|l| l == "step Familiars"), "{g:#?}");
}

#[test]
fn goals_for_a_whole_quest_are_swept_too() {
	// Human c13 Redridge "Lakeridge Highway": `kill 423 quest 246` (no objective number) was left in
	// v1's order, the arrow from the Mongrels south to the Poachers and back north to the Thrashers
	// (dup-trip). A goal for a whole quest is a field goal and is swept like the others.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 5-8", "zone The Barrens", "",
				"step Brill", "  accept 1", "  accept 2", "",
				"step Fields", "  kill 44 quest 1", "  kill 45 quest 2", "",
				"step Brill again", "  turnin 1", "  turnin 2", "",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1413]], "zones": { "1413": "The Barrens" }, "quests": [] }),
		frames: json!({ "era": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"5": { "name": "Elder", "level": 10, "spawns": { "1413": { "f": "e", "pts": [[50, 50]] } } },
			"44": { "name": "Far Raptor", "level": 7, "spawns": { "1413": { "f": "e", "pts": [[70, 70], [71, 70], [70, 71]] } } },
			"45": { "name": "Plainstrider", "level": 6, "spawns": { "1413": { "f": "e", "pts": [[50, 52], [51, 52], [50, 53]] } } }
		}),
		quests: json!({
			"1": { "title": "One", "start": { "npc": [5] }, "end": { "npc": [5] } },
			"2": { "title": "Two", "start": { "npc": [5] }, "end": { "npc": [5] } }
		}),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) }, { "t": "accept", "q": 2, "pt": 0, "from": f("a", 8) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "from": f("a", 11) },
			{ "t": "task", "q": 2, "task": 0, "pt": 0, "from": f("a", 12) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 15) }, { "t": "turnin", "q": 2, "pt": 0, "from": f("a", 16) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (near, far) = (idx(&g, "  kill 45 quest 2"), idx(&g, "  kill 44 quest 1"));
	assert!(near >= 0 && near < far, "{g:#?}");
}

#[test]
fn a_goal_worked_at_v1s_optional_line_is_required_there_when_its_required_line_goes() {
	// c13 Mulgore (M1): the route works Mazzranache (766) at v1's optional "on the way" lines and drops
	// v1's finishing step, so every part was optional and the hand-in could wait on nothing.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 5-8", "zone Mulgore", "",
				"step Maur", "  accept 1", "",
				"step The well", "  kill 44 quest 1.1 optional", "  kill 45 quest 2.1", "",
				"step Finish the parts", "  kill 44 quest 1.1                  -- Prairie Wolf", "",
				"step Maur again", "  turnin 1", "  turnin 2", "",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1412], [0, 0, 100, 0, 1412]], "zones": { "1412": "Mulgore" }, "quests": [
			{ "id": 1, "giver": 0, "ender": 0, "objs": [{ "oi": 0, "type": "kill", "id": 44, "task": 0 }] },
			{ "id": 2, "giver": 0, "ender": 0, "objs": [{ "oi": 0, "type": "kill", "id": 45, "task": 0 }] }
		] }),
		quests: json!({ "1": { "title": "Mazzranache", "objectives": [] }, "2": { "title": "Swoop Hunting" } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "task", "q": 1, "task": 0, "pt": 1, "from": f("a", 10) },
			{ "t": "task", "q": 2, "task": 0, "pt": 1, "from": f("a", 11) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 17) }, { "t": "turnin", "q": 2, "pt": 0, "from": f("a", 18) }
		] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(has(&g, "  kill 44 quest 1.1                  -- Prairie Wolf"), "{g:#?}");
	assert!(!g.iter().any(|l| l.contains("quest 1.1 optional")), "{g:#?}");
	assert_eq!(g.iter().filter(|l| l.contains("kill 44 quest 1.1")).count(), 1, "{g:#?}");
}

#[test]
fn a_timed_items_getter_waits_for_the_spenders_pass_by_its_place() {
	// c13 Darkshore (A2): Kerlonian's chest (the horn lasts 25 minutes) taken at 19, the escort and
	// hand-in at 25 on the way from Auberdine past the Grove to Maestra's Post. The escort and the
	// hand-in were written at 19 with a walk to Maestra's Post and back: the chest goes to 25.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 18-26", "zone Darkshore", "",
				"step The Grove", "  accept 1", "",
				"step Kerlonian", "  collect 50 quest 1.1", "  note Escort Kerlonian to Maestra's Post.", "",
				"step Far away", "  accept 2", "  turnin 2", "",
				"step Auberdine", "  accept 3", "",
				"step Maestra's Post", "  turnin 1", "  turnin 3", "",
			],
		)],
		world: json!({ "points": [[0, 0, 500, 0, 1439], [0, 0, 0, 3000, 1439], [0, 0, 1000, 0, 1439], [0, 0, 0, 0, 1439]], "zones": { "1439": "Darkshore" }, "quests": [
			{ "id": 1, "giver": 0, "ender": 3, "objs": [{ "oi": 0, "type": "item", "id": 50, "task": 0 }, { "oi": 1, "type": "event", "task": 1 }] }
		] }),
		quests: json!({ "1": { "title": "The Sleeper Has Awakened", "objectives": [{ "type": "item", "id": 50, "count": 1 }, { "type": "event" }] }, "2": { "title": "Far" }, "3": { "title": "Letter" } }),
		items: json!({ "50": { "name": "Horn of Awakening", "duration": 1500 } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 18.0, "from": f("a", 7) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "lvl": 19.0, "from": f("a", 10) },
			{ "t": "accept", "q": 2, "pt": 1, "lvl": 20.0, "from": f("a", 14) }, { "t": "turnin", "q": 2, "pt": 1, "lvl": 22.0, "from": f("a", 15) },
			{ "t": "accept", "q": 3, "pt": 2, "lvl": 25.0, "from": f("a", 18) },
			{ "t": "task", "q": 1, "task": 1, "pt": 3, "lvl": 25.5, "from": f("a", 21) },
			{ "t": "turnin", "q": 1, "pt": 3, "lvl": 25.5, "from": f("a", 21) }, { "t": "turnin", "q": 3, "pt": 3, "lvl": 25.5, "from": f("a", 22) }
		] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (chest, far, auberdine, turnin) = (idx(&g, "  collect 50 quest 1.1"), idx(&g, "  turnin 2"), idx(&g, "  accept 3"), idx(&g, "  turnin 1"));
	assert!(far < chest && auberdine < chest && chest < turnin, "{g:#?}");
}

#[test]
fn a_steps_closing_goto_stays_at_its_last_visit_when_a_vendor_line_comes_before_it() {
	// c13 Darkshore (A8): v1's last Auberdine step hands in, takes Expanding Horizons, `vendor
	// nearest`, then the boat goto. The route takes Expanding Horizons on its first Auberdine visit and
	// the boat goto came along, mid-pickup.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 18-20", "zone Darkshore", "",
				"step Auberdine first", "  accept 2", "",
				"step Field", "  kill 44 quest 2.1", "",
				"step Auberdine", "  turnin 2", "  accept 3", "  vendor nearest", "  goto 30.76,40.92 \"Boat to Stormwind\"", "",
				"step Stormwind", "  turnin 3", "",
			],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 2, "from": f("a", 7) }, { "t": "accept", "q": 3, "from": f("a", 14) },
			{ "t": "task", "q": 2, "task": 0, "from": f("a", 10) }, { "t": "turnin", "q": 2, "from": f("a", 13) },
			{ "t": "turnin", "q": 3, "from": f("a", 19) }
		] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (boat, kill, tin) = (idx(&g, "  goto 30.76,40.92 \"Boat to Stormwind\""), idx(&g, "  kill 44 quest 2.1"), idx(&g, "  turnin 2"));
	assert!(kill < boat && tin < boat, "{g:#?}");
}

#[test]
fn a_class_with_no_trainer_in_town_and_none_on_the_way_trains_at_the_routes_next_stop() {
	// c13 Darnassus (A6): Paladins, Shamans, Mages and Warlocks have no trainer there and none on the
	// route's way; the stop's line sent them over the sea to the nearest, half a level after their
	// last training. They train at the route's next stop.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 8-14", "zone Durotar", "", "step Razor Hill", "  accept 1", "", "step Sen'jin", "  turnin 1", "", "step Later", "  accept 2", ""],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1411], [0, 0, -800, 800, 1411], [0, 0, 800, -800, 1411]], "zones": { "1411": "Durotar" }, "quests": [] }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"3169": { "name": "Tarshaw", "subName": "Warrior Trainer", "faction": "H", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } },
			"5880": { "name": "Un'Thuwa", "subName": "Mage Trainer", "faction": "H", "spawns": { "1411": { "f": "e", "pts": [[90, 90]] } } }
		}),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 10.0, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "lvl": 10.0, "pt": 0, "from": "train stop" },
			{ "t": "turnin", "q": 1, "lvl": 10.3, "pt": 1, "from": f("a", 10) },
			{ "t": "accept", "q": 2, "lvl": 13.5, "pt": 2, "from": f("a", 13) },
			{ "t": "train", "lvl": 14.0, "pt": 2, "from": "train stop" }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let first = g.iter().position(|l| m(l, r"^\s+train class")).unwrap_or_else(|| panic!("{g:#?}"));
	assert_eq!(g[first], "  train class only Warrior", "{g:#?}");
}

#[test]
fn one_training_stop_per_town_visit_the_later_one() {
	// c13 Thunder Bluff (M5): the route trains at 11.2 and again at 12 in one visit, with a hand-in
	// between: one stop, the later.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 10-13", "zone Thunder Bluff", "", "step Thunder Bluff", "  turnin 1", "", "step Elder Rise", "  accept 2", "", "step Away", "  turnin 2", ""],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1456], [0, 0, 80, 0, 1456], [0, 0, 900, 900, 1456]], "zones": { "1456": "Thunder Bluff" }, "quests": [] }),
		frames: json!({ "era": { "1456": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Tauren", "diff": {}, "order": [
			{ "t": "turnin", "q": 1, "lvl": 11.1, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "lvl": 11.15, "pt": 0, "from": "train stop" },
			{ "t": "accept", "q": 2, "lvl": 12.0, "pt": 1, "from": f("a", 10) },
			{ "t": "train", "lvl": 12.05, "pt": 1, "from": "train stop" },
			{ "t": "turnin", "q": 2, "lvl": 12.5, "pt": 2, "from": f("a", 13) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let trains: Vec<usize> = g.iter().enumerate().filter(|(_, l)| m(l, r"^\s+train class")).map(|(i, _)| i).collect();
	assert_eq!(trains.len(), 1, "{g:#?}");
	assert!(idx(&g, "  accept 2") < trains[0] as i64, "{g:#?}");
}

#[test]
fn with_route_legs_a_seed_grind_the_route_drops_is_not_written() {
	// c13 Un'Goro and Silithus (A5): v1's "Grind to 51" (a Tanaris tip) and "Grind to 59" (a Dire Maul
	// note) were written re-levelled where the route grinds nothing.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 48-52", "zone Un'Goro Crater", "",
				"step Marshal's Refuge", "  accept 1", "  level 50", "",
				"step Grind to 51", "  tip Grind the Wastewander nomads east of Gadgetzan.", "  level 51", "",
				"step Dire Maul", "  note Dire Maul East is a good place for the last levels.", "  level 59", "",
				"step Ironstone Plateau", "  turnin 1", "",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1449], [0, 0, 100, 0, 1449]], "zones": { "1449": "Un'Goro Crater" }, "quests": [] }),
		frames: json!({ "era": { "1449": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 49.0, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 1, "lvl": 49.1, "pt": 1, "from": f("a", 19) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| m(l, r"^\s+level\s")), "{g:#?}");
	assert!(!g.iter().any(|l| l == "step Grind to 51" || l == "step Dire Maul"), "{g:#?}");
}

#[test]
fn a_seed_note_to_skip_a_quest_goes_where_the_route_takes_it() {
	// c13 Badlands and Hinterlands (A10, H2-7): "Rhapsody's cocktail needs parts from Kalimdor: skip
	// it." right above the route's accept of the cocktail; "his quest is not on this route" for Whiskey
	// Slim's grog, which the route takes. A note about a quest the route leaves out stays.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 40-45", "zone The Hinterlands", "",
				"step Rhapsody Shindigger", "  turnin 1", "  note Rhapsody's cocktail needs parts from Kalimdor: skip it.", "  accept 2", "  note Garek's next task is an elite hunt: skip it.", "",
				"step The beaches", "  tip Turtles crawl here. Whiskey Slim's bottles lie on these beaches too, but his quest is not on this route.", "  kill 44 quest 2.1", "",
				"step Booty Bay", "  accept 3", "  turnin 2", "  turnin 3", "",
			],
		)],
		quests: json!({
			"1": { "title": "Rhapsody's Tale" }, "2": { "title": "Rhapsody's Kalimdor Kocktail", "start": { "npc": [10] } },
			"3": { "title": "Whiskey Slim's Lost Grog", "start": { "npc": [11] } }, "4": { "title": "Garek's Hunt", "start": { "npc": [12] } }
		}),
		npcs: json!({ "10": { "name": "Rhapsody Shindigger" }, "11": { "name": "Whiskey Slim" }, "12": { "name": "Garek" } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "turnin", "q": 1, "from": f("a", 7) }, { "t": "accept", "q": 2, "from": f("a", 9) },
			{ "t": "task", "q": 2, "task": 0, "from": f("a", 14) },
			{ "t": "accept", "q": 3, "from": f("a", 17) }, { "t": "turnin", "q": 2, "from": f("a", 18) }, { "t": "turnin", "q": 3, "from": f("a", 19) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l.contains("Rhapsody's cocktail")), "{g:#?}");
	assert!(has(&g, "  note Garek's next task is an elite hunt: skip it."), "{g:#?}");
	assert!(has(&g, "  tip Turtles crawl here."), "{g:#?}");
}

#[test]
fn a_route_event_with_two_objective_lines_travels_once() {
	// c13 Arathi (F5): The Hammer May Fall's one task, two objective lines (the ogres, Boulder'gor):
	// the way there (zeppelin, Undercity, flight) was written before each.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 30-40", "zone Durotar", "",
				"step Hammerfall", "  accept 1", "",
				"step Boulderfist camp", "  kill 44 quest 1.1", "  kill 45 quest 1.2", "",
				"step Hammerfall again", "  turnin 1", "",
			],
		)],
		world: {
			let mut w = travel_world();
			w["points"].as_array_mut().unwrap().push(json!([1, 1, 3000, 3000, 1411]));
			w["quests"] = json!([{ "id": 1, "giver": 0, "ender": 0, "objs": [{ "oi": 0, "type": "kill", "id": 44, "task": 0 }, { "oi": 1, "type": "kill", "id": 45, "task": 0 }] }]);
			w
		},
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		npcs: json!({
			"44": { "name": "Boulderfist Ogre", "spawns": { "1411": { "f": "e", "pts": [[20, 20], [21, 20], [20, 21]] } } },
			"45": { "name": "Boulder'gor", "spawns": { "1411": { "f": "e", "pts": [[25, 22]] } } }
		}),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }] },
			{ "t": "task", "q": 1, "task": 0, "pt": 4, "from": f("a", 10), "items": [{ "t": "network", "from": 0, "to": 4, "legs": [{ "k": "walk", "to": 2, "node": 0 }, { "k": "fly", "from": 0, "to": 1 }, { "k": "walk", "to": 4 }] }] },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 14) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert_eq!(g.iter().filter(|l| l.starts_with("  fly \"Crossroads\"")).count(), 1, "{g:#?}");
	assert!(idx(&g, "  kill 44 quest 1.1") < idx(&g, "  kill 45 quest 1.2"), "{g:#?}");
}

#[test]
fn no_flight_to_where_the_route_already_is() {
	// c13 Barrens (F8): the route flies to the Crossroads, and v1's Crossroads step there says `fly
	// "Crossroads"` between two hand-ins.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 15-20", "zone Durotar", "", "step Orgrimmar", "  accept 1", "  accept 2", "", "step The Crossroads", "  turnin 1", "  fly \"Crossroads\"", "  turnin 2", ""],
		)],
		world: travel_world(),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 2, "from": f("a", 7) }, { "t": "accept", "q": 2, "pt": 2, "from": f("a", 8) },
			{ "t": "turnin", "q": 1, "pt": 3, "from": f("a", 11), "items": [{ "t": "network", "from": 2, "to": 3, "legs": [{ "k": "fly", "from": 0, "to": 1 }] }] },
			{ "t": "turnin", "q": 2, "pt": 3, "from": f("a", 13) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert_eq!(g.iter().filter(|l| l.starts_with("  fly \"Crossroads\"")).count(), 1, "{g:#?}");
	assert!(idx(&g, "  fly \"Crossroads\"") < idx(&g, "  turnin 1"), "{g:#?}");
}

#[test]
fn a_held_class_step_is_titled_for_its_giver_in_the_zone() {
	// c13 Durotar (T6): 1505 Veteran Uzzek has two givers, Torm Ragetotem in Thunder Bluff and Tarshaw
	// in Razor Hill; the Razor Hill step was titled "Torm Ragetotem".
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 9-13", "zone Durotar", "", "step Razor Hill", "  accept 1", "  accept 7 only Warrior", "", "step Camp", "  turnin 1", "", "step Later", "  accept 2", "", "step Orgrimmar", "  turnin 7 only Warrior", "  turnin 2", ""],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1411]], "zones": { "1411": "Durotar", "1456": "Thunder Bluff" }, "quests": [] }),
		quests: json!({ "7": { "title": "Veteran Uzzek", "minLevel": 12, "start": { "npc": [10, 20] } } }),
		npcs: json!({
			"10": { "name": "Torm Ragetotem", "spawns": { "1456": { "f": "e", "pts": [[50, 50]] } } },
			"20": { "name": "Tarshaw Jaggedscar", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } }
		}),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 9.5, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 1, "lvl": 9.7, "pt": 0, "from": f("a", 11) },
			{ "t": "accept", "q": 2, "lvl": 12.1, "pt": 0, "from": f("a", 14) },
			{ "t": "turnin", "q": 2, "lvl": 12.5, "pt": 0, "from": f("a", 18) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let a = idx(&g, "  accept 7 only Warrior") as usize;
	let title = g[..a].iter().rev().find(|l| l.starts_with("step ")).unwrap();
	assert_eq!(title, "step Tarshaw Jaggedscar", "{g:#?}");
}

#[test]
fn a_split_steps_second_tip_line_goes_with_its_npcs_piece_too() {
	// RevUndead3 U2 (#742): only a step's first tip line was read; Simmer's note on the second stayed
	// with Calvin's duel. Every tip line is read, and a sentence left starts with a capital.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 3-8", "zone Durotar", "",
				"step Deathknell", "  accept 2", "",
				"step Calvin Montague", "  tip Walk on west to the farm.", "  tip Deathguard Simmer stands at the farm; the farmhouse is by the road.", "  accept 3", "  accept 1", "",
				"step Brill", "  turnin 2", "  turnin 1", "",
			],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 2, "pt": 2, "from": f("a", 7) }, { "t": "accept", "q": 3, "pt": 1, "from": f("a", 12) }, { "t": "turnin", "q": 2, "pt": 3, "from": f("a", 16) },
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 13) }, { "t": "turnin", "q": 1, "pt": 3, "from": f("a", 17) }
		] }),
		quests: json!({
			"1": { "title": "Fields of Grief", "start": { "npc": [10] }, "end": { "npc": [30] } },
			"2": { "title": "A Rogue's Deal", "start": { "npc": [40] }, "end": { "npc": [30] } },
			"3": { "title": "Duel", "start": { "npc": [20] }, "end": { "npc": [20] } }
		}),
		npcs: json!({ "10": { "name": "Deathguard Simmer" }, "20": { "name": "Calvin Montague" }, "30": { "name": "Innkeeper Renee" }, "40": { "name": "Novice Elreth" } }),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 150, 0, 1411], [1, 1, 900, 900, 1411], [1, 1, -900, 900, 1411]], "zones": { "1411": "Durotar" }, "quests": [{ "id": 1, "giver": 0, "ender": 3 }, { "id": 2, "giver": 2, "ender": 3 }, { "id": 3, "giver": 1, "ender": 1 }] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (first, second) = (idx(&g, "  accept 3") as usize, idx(&g, "  accept 1") as usize);
	assert!(first < second, "{g:#?}");
	assert!(has(&g, "  tip The farmhouse is by the road."), "{g:#?}");
	assert!(g[first..second - 2].iter().all(|l| !l.contains("Simmer")), "{g:#?}");
	assert!(g[second - 1].contains("Deathguard Simmer stands at the farm."), "{g:#?}");
}

#[test]
fn a_class_away_comes_back_to_where_the_route_goes_on() {
	// RevHuman3 H4: Warlocks back from their Stormwind steps were sent to the route's training stop it
	// had left (Goldshire), then on to Rainer: they come back to where the route goes on. Here the
	// Shamans flew to Orgrimmar after the route's Crossroads training; the route goes on nearer
	// Orgrimmar: no flight back to the Crossroads.
	let mut world = travel_world();
	world["points"].as_array_mut().unwrap().push(json!([1, 1, 0, -900, 1411]));
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 1-5", "zone Durotar", "",
				"step Hub", "  accept 1", "",
				"step Totem", "  only Shaman", "  fly \"Orgrimmar\"", "  turnin 7", "",
				"step Camp", "  turnin 1", "",
			],
		)],
		world,
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 3, "from": f("a", 7), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }] },
            { "t": "train", "pt": 3, "from": "train stop" },
            { "t": "turnin", "q": 1, "pt": 4, "from": f("a", 15) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let t = run(&c, None).read("a");
	assert!(idx(&t, "  turnin 7") >= 0 && t.iter().any(|l| l.starts_with("  train class")), "{t:#?}");
	assert!(!t.iter().any(|l| l == "step Back to Crossroads"), "{t:#?}");
}

#[test]
fn a_piece_holding_only_another_npcs_lines_is_named_for_that_npc() {
	// RevHuman3 H7: the route split v1's "Eagan Peltskinner" step; the piece with only Deputy Willem's
	// accept kept Eagan's name.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 5-8", "zone Elwynn Forest", "",
				"step Eagan Peltskinner", "  accept 1", "  accept 2", "",
				"step Marshal", "  turnin 3", "",
				"step Eagan again", "  turnin 1", "  turnin 2", "",
			],
		)],
		quests: json!({
			"1": { "title": "Wolves", "start": { "npc": [10] }, "end": { "npc": [10] } },
			"2": { "title": "Kobolds", "start": { "npc": [20] }, "end": { "npc": [20] } },
			"3": { "title": "Letter", "start": { "npc": [30] }, "end": { "npc": [30] } }
		}),
		npcs: json!({ "10": { "name": "Eagan Peltskinner" }, "20": { "name": "Deputy Willem" }, "30": { "name": "Marshal McBride" } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "from": f("a", 7) },
			{ "t": "turnin", "q": 3, "from": f("a", 11) },
			{ "t": "accept", "q": 2, "from": f("a", 8) },
			{ "t": "turnin", "q": 1, "from": f("a", 14) }, { "t": "turnin", "q": 2, "from": f("a", 15) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let at = idx(&g, "  accept 2") as usize;
	assert!(g[..at].iter().rev().find(|l| l.starts_with("step ")).is_some_and(|t| t == "step Deputy Willem"), "{g:#?}");
	assert!(g[..idx(&g, "  accept 1") as usize].iter().rev().find(|l| l.starts_with("step ")).is_some_and(|t| t == "step Eagan Peltskinner"), "{g:#?}");
}

#[test]
fn a_sweep_never_moves_a_goal_over_an_accept_or_hand_in() {
	// FlowWriter, Tauren Hunter: Yaw Sharpmane's hunts in turn (accept, kill, hand-in, accept, kill...)
	// came out with the second kill before its accept (pack error).
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a", "title A", "levels 5-8", "zone The Barrens", "",
				"step Elder", "  accept 3", "",
				"step Hunts", "  accept 1", "  kill 44 quest 1.1", "  turnin 1", "  accept 2", "  kill 45 quest 2.1", "  turnin 2", "",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1413]], "zones": { "1413": "The Barrens" }, "quests": [] }),
		frames: json!({ "era": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"5": { "name": "Elder", "level": 10, "spawns": { "1413": { "f": "e", "pts": [[50, 50]] } } },
			"44": { "name": "Far Raptor", "level": 7, "spawns": { "1413": { "f": "e", "pts": [[70, 70], [71, 70], [70, 71]] } } },
			"45": { "name": "Plainstrider", "level": 6, "spawns": { "1413": { "f": "e", "pts": [[50, 52], [51, 52], [50, 53]] } } }
		}),
		quests: json!({
			"1": { "title": "One", "start": { "npc": [5] }, "end": { "npc": [5] } },
			"2": { "title": "Two", "start": { "npc": [5] }, "end": { "npc": [5] } },
			"3": { "title": "Three", "start": { "npc": [5] }, "end": { "npc": [5] } }
		}),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 3, "pt": 0, "from": f("a", 7) },
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 10) }, { "t": "task", "q": 1, "task": 0, "pt": 0, "from": f("a", 11) }, { "t": "turnin", "q": 1, "pt": 0, "from": f("a", 12) },
			{ "t": "accept", "q": 2, "pt": 0, "from": f("a", 13) }, { "t": "task", "q": 2, "task": 0, "pt": 0, "from": f("a", 14) }, { "t": "turnin", "q": 2, "pt": 0, "from": f("a", 15) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (a2, k2) = (idx(&g, "  accept 2"), idx(&g, "  kill 45 quest 2.1"));
	assert!(a2 >= 0 && a2 < k2, "{g:#?}");
	assert!(idx(&g, "  accept 1") < idx(&g, "  kill 44 quest 1.1"), "{g:#?}");
}

#[test]
fn no_walk_is_written_to_a_step_of_optional_lines_only() {
	// RevHuman3 H2: everyone was sent out to The Collector's and Manhunt's steps (all optional, or
	// quests the route does not take) between two route stops.
	let a = vec![
		"guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "",
		"step One", "  accept 1", "",
		"step Collector", "  zone Silverpine Forest", "  accept 8 optional", "",
		"step Back", "  zone Tirisfal Glades", "  accept 3", "",
		"step Two", "  accept 2", "",
	];
	let c = Case {
		files: vec![("a", a)],
		world: json!({
			"points": [[0, 0, 0, 0, 1420], [0, 0, 40, 0, 1420], [0, 0, 2000, 2000, 1421]],
			"zones": { "1420": "Tirisfal Glades", "1421": "Silverpine Forest" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 1, "ender": 1 }, { "id": 8, "giver": 2, "ender": 2 }]
		}),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 }, "8": { "title": "Collector", "minLevel": 1 } }),
		frames: json!({ "era": { "1420": { "top": 1000, "bottom": -1000, "left": 1000, "right": -1000, "c": 0 }, "1421": { "top": 3000, "bottom": 1000, "left": 3000, "right": 1000, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 1.0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 1, "lvl": 1.0, "from": f("a", 13) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l.starts_with("  goto ")), "{g:#?}");
}

#[test]
fn a_shared_guide_a_start_plays_before_its_join_keeps_its_lines() {
	// c14 Night Elf: Teldrassil's `next` is Westfall and Westfall's is Darkshore; the route plays
	// Darkshore in the start's own part, before it joins at Westfall. The chain kept v1's order, so the
	// cut wrote Darkshore's Auberdine accepts into Westfall, the shared guide the start does not keep:
	// their hand-ins in the start's own Darkshore had no accept.
	let tel = vec!["guide forever/t/tel", "title T", "race NightElf", "levels 1-10", "zone Teldrassil", "next forever/t/westfall", "", "step Dolanaar", "  accept 1", ""];
	let dark = vec!["guide forever/t/darkshore", "title D", "levels 10-15", "zone Darkshore", "next forever/t/redridge", "", "step Auberdine", "  accept 954", "  accept 958", "", "step Beach", "  turnin 954", "  turnin 958", ""];
	let west = vec!["guide forever/t/westfall", "title W", "levels 15-20", "zone Westfall", "next forever/t/darkshore", "", "step Sentinel Hill", "  accept 36", ""];
	let c = Case {
		files: vec![("t/tel", tel), ("t/darkshore", dark), ("t/westfall", west)],
		route: json!({ "diff": {}, "shared": { "joinAt": "westfall", "joinStep": 5 }, "order": [
			{ "t": "accept", "q": 1, "from": f("t/tel", 9) },
			{ "t": "accept", "q": 954, "from": f("t/darkshore", 8) },
			{ "t": "accept", "q": 958, "from": f("t/darkshore", 9) },
			{ "t": "turnin", "q": 954, "from": f("t/darkshore", 12) },
			{ "t": "turnin", "q": 958, "from": f("t/darkshore", 13) },
			{ "t": "accept", "q": 36, "from": f("t/westfall", 8) }
		] }),
		..Case::default()
	};
	let r = run(&c, None);
	let (d, w) = (r.read("t/darkshore"), r.read("t/westfall"));
	assert!(has(&d, "  accept 954") && has(&d, "  accept 958") && idx(&d, "  accept 954") < idx(&d, "  turnin 954"), "{d:#?}");
	assert!(!w.iter().any(|l| l.contains("954")), "{w:#?}");
}

#[test]
fn classes_away_rejoin_where_the_route_goes_on_not_where_it_left() {
	// c14 Dwarf: the class steps in Ironforge, then "Back to Dun Morogh" for those classes, then
	// everyone's walk into Ironforge (a bounce); they wait in Ironforge for the route instead.
	let a = vec![
		"guide t/a", "title A", "levels 1-12", "zone Dun Morogh", "",
		"step Kharanos", "  accept 1", "",
		"step Honor Students", "  only Paladin", "  accept 8", "  fly \"Ironforge\"", "",
		"step Class quests", "  only Paladin", "  zone Ironforge", "  accept 9", "",
		"step Ironforge", "  zone Ironforge", "  accept 2", "",
	];
	let c = Case {
		files: vec![("a", a)],
		world: json!({
			"points": [[0, 0, 0, 0, 1426], [0, 0, 1500, 0, 1537], [0, 0, 1550, 0, 1537]],
			"zones": { "1426": "Dun Morogh", "1537": "Ironforge" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 1, "ender": 1 }, { "id": 8, "giver": 0, "ender": 0 }, { "id": 9, "giver": 2, "ender": 2 }],
			"nodes": [{ "kind": "fp", "name": "Kharanos", "pt": 0 }, { "kind": "fp", "name": "Ironforge", "pt": 1 }]
		}),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 }, "8": { "title": "Honor", "minLevel": 1, "classes": 2 }, "9": { "title": "Tome", "minLevel": 1, "classes": 2 } }),
		frames: json!({ "era": { "1426": { "top": 3000, "bottom": -3000, "left": 3000, "right": -3000, "c": 0 }, "1537": { "top": 3000, "bottom": -3000, "left": 3000, "right": -3000, "c": 0 } } }),
		route: json!({ "faction": "Alliance", "start": "Dwarf", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 5.0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 1, "lvl": 5.0, "from": f("a", 21) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(has(&g, "  accept 9") && !g.iter().any(|l| l.starts_with("step Back to")), "{g:#?}");
}

#[test]
fn a_class_step_does_not_split_two_lines_at_one_npc() {
	// c14 Undead: the Priests' Aelthalyste (a few dozen yards off) between Faranell's hand-in and his
	// next quest: Faranell twice.
	let a = vec![
		"guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "",
		"step Faranell", "  accept 1", "",
		"step Aelthalyste", "  only Priest", "  accept 9", "",
		"step Faranell again", "  accept 3", "",
	];
	let c = Case {
		files: vec![("a", a)],
		world: town_world(json!([{ "id": 9, "giver": 2, "ender": 2 }, { "id": 4, "giver": 1, "ender": 1 }])),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "3": { "title": "Three", "minLevel": 1 }, "9": { "title": "Nine", "minLevel": 1, "classes": 16 } }),
		frames: town_frames(),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 1, "lvl": 1.0, "from": f("a", 7) },
			{ "t": "accept", "q": 3, "pt": 1, "lvl": 1.0, "from": f("a", 14) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  accept 3") >= 0 && idx(&g, "  accept 9") > idx(&g, "  accept 3"), "{g:#?}");
}
