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
	/// The world's zone crossings (the writer's walks go over them).
	crossings: Option<forge_world::world::Crossings>,
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
			crossings: None,
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
	let borders = c.crossings.as_ref().and_then(forge_writer::borders::Borders::of);
	let out = apply_route(&Inputs {
		route: &route,
		guides: &guides,
		world: &world,
		data: &data,
		frames: &frames,
		area_at,
		level_fraction: c.level_fraction,
		route_travel: c.route_travel,
		solo_fallback: true,
		walks: None,
		borders: borders.as_ref(),
		fresh_openers: forge_writer::post::FreshOpeners::Flag,
	})
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
fn a_v1_step_in_its_zone_is_not_walked_to_where_the_data_places_one_of_its_lines() {
	// c15w Horde Arathi: v1's Orgrimmar training step holds the Warriors' The Islander (1718), whose
	// data gives it a giver in Thunder Bluff too. The step is in Orgrimmar (its `zone`): no way to
	// Thunder Bluff for everyone and back (a "Fly to Thunder Bluff" step lost its `fly` to the
	// Druids' and Paladins' own Thunder Bluff step).
	let fr = json!({ "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 });
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Orc,Troll,Tauren,Undead,Skyborne",
				"levels 38-40",
				"zone The Barrens",
				"",
				"step Hub",
				"  accept 1",
				"  accept 2",
				"",
				"step Orgrimmar",
				"  zone Orgrimmar",
				"  train class only Warrior,Hunter,Rogue,Priest,Shaman,Mage,Warlock",
				"  accept 1718 only Warrior",
				"",
				"step Thunder Bluff",
				"  only Druid,Paladin",
				"  zone Thunder Bluff",
				"  fly \"Thunder Bluff\"",
				"  train class",
				"",
				"step Camp",
				"  zone The Barrens",
				"  turnin 1",
				"",
				"step Field",
				"  turnin 2",
				"",
			],
		)],
		world: json!({
			"points": [[1, 1, 0, 0, 1454], [1, 1, 10, 10, 1454], [1, 1, 900, 900, 1456], [1, 1, 890, 890, 1456], [1, 1, -900, 0, 1413]],
			"zones": { "1454": "Orgrimmar", "1456": "Thunder Bluff", "1413": "The Barrens" },
			"quests": [{ "id": 1718, "giver": 2, "ender": 2 }],
			"nodes": [{ "kind": "fp", "name": "Orgrimmar", "pt": 1 }, { "kind": "fp", "name": "Thunder Bluff", "pt": 3 }]
		}),
		frames: json!({ "era": { "1454": fr, "1456": fr, "1413": fr } }),
		quests: json!({ "1": { "title": "One" }, "2": { "title": "Two" }, "1718": { "title": "The Islander", "classes": 1 } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "lvl": 39.9, "from": f("a", 8), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }] },
            { "t": "accept", "q": 2, "pt": 0, "lvl": 39.9, "from": f("a", 9) },
            { "t": "train", "lvl": 40.0, "pt": 0, "from": "train stop" },
            { "t": "turnin", "q": 2, "pt": 4, "lvl": 40.0, "from": f("a", 27) },
            { "t": "turnin", "q": 1, "pt": 4, "lvl": 40.0, "from": f("a", 24) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  accept 1718 only Warrior") >= 0 && idx(&g, "  accept 1718 only Warrior") < idx(&g, "  turnin 2"), "{g:#?}");
	// (Everyone's way to Thunder Bluff before Orgrimmar's step: none.)
	let org = g.iter().position(|l| l == "step Orgrimmar").unwrap();
	assert!(g[..org].iter().all(|l| !(l.contains("Thunder Bluff") && (l.starts_with("step ") || l.starts_with("  goto") || l.starts_with("  fly")))), "{g:#?}");
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
fn a_v1_training_the_step_writes_last_stays_after_the_steps_quest_lines() {
	// thmastin's Kharanos report (32fc6ceac, a recorded Dwarf Hunter run): v1's distillery step trains
	// last, after Ragnar, Tannok and Maxan, since some classes' trainers stand outside. The 0.3.0 Dwarf
	// route put the training before them, and the guide sent the Hunter out to Grif Wildheart and back in.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 1-10", "zone Dun Morogh", "", "step Distillery", "  accept 1", "  accept 2", "  accept 3", "  train class", "", "step Depot", "  turnin 1", ""],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1426], [0, 0, 900, 900, 1426]], "zones": { "1426": "Dun Morogh" }, "quests": [], "inns": [], "nodes": [] }),
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
            { "t": "train", "pt": 0, "from": f("a", 10) },
            { "t": "accept", "q": 2, "pt": 0, "from": f("a", 8) },
            { "t": "accept", "q": 3, "pt": 0, "from": f("a", 9) },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 13) }
        ] }),
		..Case::default()
	};
	assert_eq!(pick(&run(&c, None).read("a"), r"^step|^\s+(accept|turnin|train)"), vec!["step Distillery", "  accept 1", "  accept 2", "  accept 3", "  train class", "step Depot", "  turnin 1"]);
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
fn an_optional_npc_line_goes_after_the_pieces_by_its_npc() {
	// c16 Alliance Stormwind: Clavicus' optional cloth donations went with the step's first piece, at
	// Royal Factor Bathrilor, between his two lines and across the Trade District from Clavicus
	// (dup-trip on every start). Not after a later visit's line there either (Test of Strength's
	// accept after Test of Endurance's hand-in, Ashenvale).
	let c = Case {
		files: vec![
			(
				"a",
				vec![
					"guide t/a",
					"title A",
					"levels 50-60",
					"zone Stormwind City",
					"next t/b",
					"",
					"step Stormwind City",
					"  turnin 1",
					"  accept 2",
					"  turnin 2",
					"  accept 3",
					"  accept 9 optional",
					"  turnin 3",
					"",
				],
			),
			("b", vec!["guide t/b", "title B", "levels 50-60", "zone Stormwind City", "", "step Far", "  accept 4", ""]),
		],
		route: json!({ "diff": {}, "order": [
			{ "t": "turnin", "q": 1, "pt": 1, "from": f("a", 8) }, { "t": "accept", "q": 2, "pt": 1, "from": f("a", 9) },
			{ "t": "turnin", "q": 2, "pt": 0, "from": f("a", 10) }, { "t": "accept", "q": 3, "pt": 0, "from": f("a", 11) },
			{ "t": "accept", "q": 4, "pt": 1, "from": f("b", 7) }, { "t": "turnin", "q": 3, "pt": 0, "from": f("a", 13) }
		] }),
		world: json!({ "points": [[0, 0, 0, 0, 1453], [0, 0, 900, 900, 1453]], "zones": { "1453": "Stormwind City" }, "quests": [] }),
		quests: json!({ "9": { "title": "A Donation of Wool", "start": { "npc": [777] } } }),
		npcs: json!({ "777": { "name": "Clavicus Knavingham", "spawns": { "1453": { "f": "e", "pts": [[50, 50]] } } } }),
		frames: json!({ "era": { "1453": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		..Case::default()
	};
	let r = run(&c, None);
	let all: Vec<String> = [r.read("a"), r.read("b")].concat();
	let lines = pick(&all, r"^\s+(turnin|accept)");
	let at = |s: &str| lines.iter().position(|l| l == s).unwrap();
	assert!(at("  accept 3") < at("  accept 9 optional") && at("  accept 9 optional") < at("  turnin 3") && at("  turnin 2") < at("  accept 3"), "{lines:?}");
}

#[test]
fn no_ride_below_riding_level() {
	let c = Case {
		files: vec![
			("a", vec!["guide t/a", "title A", "levels 30-40", "zone Arathi Highlands", "next t/b", "", "step Biggs", "  accept 1", "", "step Harborage", "  accept 3", ""]),
			(
				"b",
				vec![
					"guide t/b",
					"title B",
					"levels 40-50",
					"zone Arathi Highlands",
					"",
					"step Webb",
					"  tip Ride back west along the road.",
					"  turnin 1",
					"  note Learn to ride: the riding trainer is by the stables.",
					"",
					"step Later",
					"  accept 2",
					"",
				],
			),
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
fn a_flight_path_v1_learns_in_the_step_it_arrives_for_stays_where_v1_has_it() {
	// #727: Sentinel Hill's step learns the flight path after the tower's quests (accept 102); the
	// route's flight path, written first in the step it arrives for, was kept and v1's line dropped
	// as its double: the flight path came first, down the tower and back up.
	for route_travel in [false, true] {
		let c = Case {
			files: vec![(
				"a",
				vec![
					"guide t/a",
					"title A",
					"levels 1-5",
					"zone Durotar",
					"",
					"step Road",
					"  accept 1",
					"",
					"step Hill",
					"  accept 2",
					"  accept 3",
					"  getfp \"Crossroads\"",
					"  turnin 1",
					"  accept 4",
					"",
				],
			)],
			world: travel_world(),
			route: json!({ "diff": {}, "order": [
                { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
                { "t": "accept", "q": 2, "pt": 3, "from": f("a", 10), "items": [{ "t": "getfp", "node": 1 }] },
                { "t": "accept", "q": 3, "pt": 3, "from": f("a", 11) },
                { "t": "turnin", "q": 1, "pt": 3, "from": f("a", 13) },
                { "t": "accept", "q": 4, "pt": 3, "from": f("a", 14) }
            ] }),
			route_travel,
			..Case::default()
		};
		let g = run(&c, None).read("a");
		assert_eq!(pick(&g, r"^\s+(accept|turnin|getfp)"), vec!["  accept 1", "  accept 2", "  accept 3", "  getfp \"Crossroads\"", "  turnin 1", "  accept 4"], "route_travel {route_travel}: {g:#?}");
	}
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
			r#"step Camp\n {2}kill 20 quest 1\.1\n\nstep Level 12\.4\n( {2}zone Durotar\n)? {2}when level<12\.4\n {2}tip Top up here to level 12\.4 before the hand-ins at Razor Hill: they take you to level 13\.\n {2}goto 75\.0,75\.0 map 1411 "Mottled Boar"\n {2}level 12\.4 grind 20 +-- grind on Mottled Boar\n\nstep Hub again"#
		),
		"{text}"
	);
}

// Fitz's grind policy (2026-11-08, final route review): every written grind step keeps its gate and says
// plainly that a dungeon of the player's level will do instead, by faction and level band.
#[test]
fn a_grind_top_up_names_the_dungeons_of_its_level_for_the_routes_faction() {
	let c = |faction: Option<&str>, target: f64| Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 10-30", "zone Durotar", "", "step Hub", "  accept 1", "", "step Camp", "  kill 20 quest 1.1", "", "step Hub again", "  turnin 1", ""])],
		route: {
			let mut r = json!({ "diff": {}, "order": [
				{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
				{ "t": "task", "q": 1, "task": 0, "pt": 1, "from": f("a", 10) },
				{ "t": "level", "lvl": target - 0.2, "target": target, "pt": 1, "from": "inserted" },
				{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 13) },
			] });
			if let Some(fc) = faction {
				r["faction"] = json!(fc);
			}
			r
		},
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, -500, 500, 1411]], "zones": { "1411": "Durotar" }, "quests": [{ "id": 1, "objs": [{ "oi": 0, "type": "kill", "id": 20, "task": 0 }] }] }),
		quests: json!({ "1": { "title": "One", "start": { "npc": [8] }, "end": { "npc": [8] }, "objectives": [{ "type": "kill", "id": 20 }] } }),
		npcs: json!({ "8": { "name": "Eight", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } }, "20": { "name": "Mottled Boar", "spawns": { "1411": { "f": "e", "pts": [[75, 75]] } } } }),
		..Case::default()
	};
	let tip = |faction: Option<&str>, target: f64| {
		let r = run(&c(faction, target), Some(&area("Razor Hill", "Durotar", 1411)));
		r.read("a").into_iter().find(|l| l.starts_with("  tip Top up here")).unwrap_or_default()
	};
	let horde = tip(Some("Horde"), 21.4);
	assert!(horde.ends_with("they take you to level 22. Or, with a group, run the Wailing Caverns dungeon instead."), "{horde}");
	let alliance = tip(Some("Alliance"), 21.4);
	assert!(alliance.ends_with(" Or, with a group, run the Wailing Caverns dungeon or the Deadmines dungeon instead."), "{alliance}");
	let high = tip(Some("Horde"), 28.9);
	assert!(high.ends_with(" Or, with a group, run the Blackfathom Deeps dungeon or the Razorfen Kraul dungeon instead."), "{high}");
	// Below every dungeon's band: no sentence.
	let low = tip(Some("Horde"), 12.4);
	assert!(low.ends_with("they take you to level 13."), "{low}");
}

#[test]
fn a_skipped_group_familys_xp_is_ground_back_after_its_step_for_skippers_only() {
	// Two (2) is a group family the route takes; for a player who skips it, a grind of its own after
	// the step of its work, at the camp of the work before it (not the elites'), never folded into the
	// farm step before it.
	let order = json!([
		{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
		{ "t": "accept", "q": 2, "pt": 0, "from": f("a", 8), "group": 2 },
		{ "t": "task", "q": 1, "task": 0, "pt": 1, "from": f("a", 11) },
		{ "t": "task", "q": 2, "task": 0, "pt": 2, "from": f("a", 14), "group": 2 },
		{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 17) },
		{ "t": "turnin", "q": 2, "pt": 0, "from": f("a", 18), "group": 2 }
	]);
	let groups = json!([{ "q": 2, "title": "Two", "size": 3, "level": 12, "mobs": [{ "npc": 21, "name": "Ogre Brute", "level": 12, "rank": 1 }], "quests": [2], "why": "faster than grinding" }]);
	let c = |route: Value| Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-20",
				"zone Durotar",
				"",
				"step Hub",
				"  accept 1",
				"  accept 2",
				"",
				"step Camp",
				"  kill 20 quest 1.1",
				"",
				"step Elite camp",
				"  kill 21 quest 2.1",
				"",
				"step Hub again",
				"  turnin 1",
				"  turnin 2",
				"",
			],
		)],
		route,
		world: json!({
			"points": [[1, 1, 0, 0, 1411], [1, 1, -500, 500, 1411], [1, 1, -400, 400, 1411]],
			"zones": { "1411": "Durotar" },
			"quests": [{ "id": 1, "objs": [{ "oi": 0, "type": "kill", "id": 20, "task": 0 }] }, { "id": 2, "objs": [{ "oi": 0, "type": "kill", "id": 21, "task": 0 }] }]
		}),
		quests: json!({
			"1": { "title": "One", "start": { "npc": [8] }, "end": { "npc": [8] }, "objectives": [{ "type": "kill", "id": 20 }] },
			"2": { "title": "Two", "start": { "npc": [8] }, "end": { "npc": [8] }, "objectives": [{ "type": "kill", "id": 21 }] }
		}),
		npcs: json!({
			"8": { "name": "Eight", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } },
			"20": { "name": "Mottled Boar", "spawns": { "1411": { "f": "e", "pts": [[75, 75], [76, 75], [75, 76]] } } },
			"21": { "name": "Ogre Brute", "rank": 1, "spawns": { "1411": { "f": "e", "pts": [[70, 70], [71, 70], [70, 71]] } } }
		}),
		route_travel: true,
		..Case::default()
	};
	let plain = run(&c(json!({ "diff": {}, "order": order, "groups": groups })), None).text("a");
	assert!(!plain.contains("when !group"), "{plain}");
	let text = run(&c(json!({ "diff": {}, "order": order, "groups": groups, "soloFallback": [{ "root": 2, "after": 3, "target": 12.4, "min": 3 }] })), None).text("a");
	assert!(
		m(
			&text,
			r#" {2}kill 21 quest 2\.1\n( {2}.*\n)*\nstep Level 12\.4\n( {2}zone Durotar\n)? {2}when !group 2\n {2}when level<12\.4\n {2}tip If you skipped Two, grind here to level 12\.4 to stay on the route's plan\.\n {2}goto 75\.0,75\.0 map 1411 "Mottled Boar"\n {2}level 12\.4 grind 20 +-- grind on Mottled Boar\n\nstep Hub again"#
		),
		"{text}"
	);
	// Its own step, not folded into the farm step before it.
	assert_eq!(text.matches("level 12.4").count(), 2, "{text}");
	// (The route file's group fields, read.)
	let route: Route = serde_json::from_value(json!({ "diff": {}, "order": order, "groups": groups, "soloFallback": [{ "root": 2, "after": 3, "target": 12.4, "min": 3 }] })).unwrap();
	assert_eq!(route.solo_fallback.len(), 1);
	assert_eq!(route.order[3].group, Some(2));
	// A title with quotes (Wanted: "Hogger") is written without them: the pack refused the comma after
	// the tip's quoted part, C14Plan.
	let hogger = json!([{ "q": 2, "title": "Wanted:  \"Hogger\"", "size": 3, "level": 12, "mobs": [{ "npc": 21, "name": "Ogre Brute", "level": 12, "rank": 1 }], "quests": [2], "why": "faster than grinding" }]);
	let text = run(&c(json!({ "diff": {}, "order": order, "groups": hogger, "soloFallback": [{ "root": 2, "after": 3, "target": 12.4, "min": 3 }] })), None).text("a");
	assert!(text.contains("  tip If you skipped Wanted: Hogger, grind here"), "{text}");
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
fn a_v1_flight_path_stop_over_the_sea_with_nothing_else_is_not_sailed_to() {
	// c17 Alliance 40-50/01-stranglethorn-vale:358-422: v1's Ratchet step (its flight path, then the
	// boat to Booty Bay), orphaned by a route that reaches Booty Bay by air, was written as a boat to
	// Ratchet for every character and back, for a flight path alone.
	let mut world = two_zone_world();
	world["zones"]["1434"] = json!("Stranglethorn Vale");
	let mut frames = two_zone_frames();
	frames["era"]["1434"] = json!({ "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 });
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
				"step Booty Bay",
				"  zone Stranglethorn Vale",
				"  getfp \"Booty Bay\"",
				"",
				"step Camp",
				"  turnin 1",
				"",
			],
		)],
		world,
		frames,
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
            { "t": "turnin", "q": 1, "pt": 2, "from": f("a", 14) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l.contains("getfp \"Booty Bay\"")), "{g:#?}");
}

#[test]
fn a_v1_hand_in_the_route_does_not_take_in_a_zone_it_has_left_is_not_written() {
	// c17 02-westfall:175: the Humans' optional The Collector hand-in to Marshal Dughan in Goldshire
	// was written in mid-Westfall, with no way there (R1). Its optional accept goes with it (R10).
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
				"  accept 7 optional",
				"",
				"step Marshal",
				"  zone The Barrens",
				"  turnin 7",
				"",
				"step Camp",
				"  turnin 1",
				"",
			],
		)],
		world: two_zone_world(),
		frames: two_zone_frames(),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
            { "t": "turnin", "q": 1, "pt": 2, "from": f("a", 15) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l.starts_with("  turnin 7") || l.starts_with("  accept 7")), "{g:#?}");
}

#[test]
fn a_flight_path_only_other_races_learn_leaves_the_routes_own_to_write() {
	// c17 50-60/01-burning-steppes:361: the Skyborne's `getfp "Rut'theran Village" only Skyborne` in
	// Darkshore counted as learnt for everyone: the route's own Rut'theran flight path went unwritten.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Hub", "  accept 1", "  getfp \"Crossroads\" only Tauren", "", "step Camp", "  turnin 1", ""])],
		world: two_zone_world(),
		frames: two_zone_frames(),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
            { "t": "turnin", "q": 1, "pt": 2, "from": f("a", 11), "items": [{ "t": "getfp", "node": 1 }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(g.iter().any(|l| l.starts_with("  getfp \"Crossroads\"") && !l.contains("Tauren")), "{g:#?}");
}

#[test]
fn a_starts_way_onto_the_shared_route_takes_its_waiting_class_steps_on_the_way() {
	// c17 Gnome dun-morogh:807-835: the Stormwind class quests were written before the tram, walked to
	// from Kharanos through Loch Modan, Badlands and Redridge; the tram opened the shared Westfall guide.
	let c = Case {
		files: vec![
			(
				"s",
				vec![
					"guide t/s",
					"title S",
					"race Orc",
					"levels 1-5",
					"zone Durotar",
					"next t/w",
					"",
					"step Hub",
					"  accept 1",
					"",
					"step Warrior Quest",
					"  only Warrior",
					"  zone The Barrens",
					"  accept 1500",
					"",
				],
			),
			("w", vec!["guide t/w", "title W", "levels 5-9", "zone The Barrens", "", "step Camp", "  turnin 1", ""]),
		],
		world: two_zone_world(),
		frames: two_zone_frames(),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("s", 9) },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("w", 7), "items": [{ "t": "network", "from": 0, "to": 1, "legs": [{ "k": "walk", "to": 3, "node": 1 }, { "k": "walk", "to": 1 }] }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("s");
	let (way, class) = (idx(&g, "step The Barrens"), idx(&g, "step Warrior Quest"));
	assert!(way >= 0 && class > way, "{g:#?}");
}

#[test]
fn a_finishing_line_in_a_step_written_before_its_accept_goes_with_its_work() {
	// C14Plan Human, Elwynn: v1's "Murlocs and the Collector" holds the Prowlers' required `kill 118
	// quest 52` (finishing the optional kills on the way), and Croaky's 91740. The route took 91740
	// there before accepting 52, so the step came first: a `kill` with no accept before it. The line
	// goes with 52's work.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 8-10",
				"zone Elwynn Forest",
				"",
				"step Hub",
				"  accept 52",
				"",
				"step Woods",
				"  kill 118 quest 52 optional",
				"",
				"step Murlocs",
				"  kill 118 quest 52",
				"  accept 91740",
				"",
				"step Thomas",
				"  turnin 52",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 91740, "from": f("a", 14) },
            { "t": "accept", "q": 52, "from": f("a", 7) },
            { "t": "task", "q": 52, "task": 0, "from": f("a", 10) },
            { "t": "turnin", "q": 52, "from": f("a", 17) }
        ] }),
		quests: json!({ "52": { "title": "Protect the Frontier" }, "91740": { "title": "Croaky" } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let accept = idx(&g, "  accept 52");
	assert!(accept >= 0 && g.iter().enumerate().all(|(i, l)| !l.starts_with("  kill 118 quest 52") || i as i64 > accept), "{g:#?}");
}

#[test]
fn a_complete_line_goes_with_its_quests_work_in_another_guide() {
	// c16 Orc: the own Barrens copy's "Kolkar camps and the Forgotten Pools" step holds `complete 870`
	// (explore the pools); the route takes 870's accept, work and hand-in in the shared Barrens guide.
	// The step's `quest` lines went with their quests' work; the `complete` line stayed, a complete with
	// no accept before it in the own copy (the pack check refused the tree). It goes with its work too.
	let c = Case {
		files: vec![
			(
				"start",
				vec![
					"guide t/start",
					"title S",
					"race Orc,Troll",
					"levels 11-14",
					"zone The Barrens",
					"next t/shared",
					"",
					"step Camp",
					"  accept 1",
					"",
					"step Pools",
					"  goto 45.1,22.5 \"The Forgotten Pools\"",
					"  complete 870",
					"",
					"step Back",
					"  turnin 1",
					"",
				],
			),
			(
				"shared",
				vec![
					"guide t/shared",
					"title Shared",
					"levels 14-17",
					"zone The Barrens",
					"",
					"step Tonga",
					"  accept 870",
					"",
					"step Pools",
					"  complete 870 @45.3,22.8",
					"",
					"step Tonga again",
					"  turnin 870",
					"",
				],
			),
		],
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "from": f("start", 9) },
            { "t": "turnin", "q": 1, "from": f("start", 16) },
            { "t": "accept", "q": 870, "from": f("shared", 7) },
            { "t": "task", "q": 870, "task": 0, "from": f("shared", 10) },
            { "t": "turnin", "q": 870, "from": f("shared", 13) }
        ] }),
		quests: json!({ "1": { "title": "One" }, "870": { "title": "The Forgotten Pools" } }),
		route_travel: true,
		..Case::default()
	};
	let r = run(&c, None);
	assert!(pick(&r.read("start"), r"^\s+complete 870").is_empty(), "{:#?}", r.read("start"));
	let g = r.read("shared");
	assert!(idx(&g, "  accept 870") < g.iter().position(|l| l.starts_with("  complete 870")).map_or(-1, |i| i as i64), "{g:#?}");
}

#[test]
fn a_v1_step_whose_work_all_went_elsewhere_leaves_no_travel_behind() {
	// c15w Horde Barrens: v1's "Kolkar camps" step (a goto and the Kolkar Bandanas, which the route
	// collects at its own camp) was written as its bare goto. With nothing left to do there, no step.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Orc,Troll,Tauren,Undead,Skyborne",
				"levels 15-16",
				"zone The Barrens",
				"",
				"step Hub",
				"  accept 855",
				"",
				"step Far camp",
				"  collect 5030 quest 855.1 @10.0,10.0",
				"",
				"step Kolkar camps",
				"  goto 46.5,31.5 \"Kolkar camps\"",
				"  collect 5030 quest 855.1",
				"",
				"step Regthar",
				"  turnin 855",
				"",
			],
		)],
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 855, "from": f("a", 8) },
            { "t": "task", "q": 855, "task": 0, "from": f("a", 11) },
            { "t": "turnin", "q": 855, "from": f("a", 18) }
        ] }),
		quests: json!({ "855": { "title": "Centaur Bracers" } }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "step Kolkar camps") < 0 && pick(&g, "46.5,31.5").is_empty(), "{g:#?}");
	assert!(idx(&g, "  turnin 855") > 0, "{g:#?}");
}

#[test]
fn a_walk_by_a_flight_master_the_path_only_passes_is_one_walk() {
	// c15w Horde Arathi: the route's way from Camp Taurajo to the Shady Rest Inn walks by Brackenwall
	// Village's flight master (a waypoint of the sim's network, not known yet); the guide walked north
	// to it and back south. One walk to the inn.
	let fr = json!({ "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 });
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Orc,Troll,Tauren,Undead,Skyborne",
				"levels 39-40",
				"zone The Barrens",
				"",
				"step Camp",
				"  accept 1",
				"",
				"step Shady Rest Inn",
				"  zone Dustwallow Marsh",
				"  turnin 1",
				"",
			],
		)],
		world: json!({
			"points": [[1, 1, 0, -800, 1413], [1, 1, 800, 600, 1445], [1, 1, -200, 500, 1445]],
			"zones": { "1413": "The Barrens", "1445": "Dustwallow Marsh" },
			"quests": [],
			"nodes": [{ "kind": "fp", "name": "Brackenwall Village", "pt": 1 }]
		}),
		frames: json!({ "era": { "1413": fr, "1445": fr } }),
		quests: json!({ "1": { "title": "One" } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 8) },
            { "t": "turnin", "q": 1, "pt": 2, "from": f("a", 12), "items": [{ "t": "network", "from": 0, "to": 2, "legs": [{ "k": "walk", "to": 1, "node": 0 }, { "k": "walk", "to": 2 }] }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	// (Brackenwall's master stands at 80.0,10.0.)
	assert!(pick(&g, r"^\s+goto 80\.0,10\.0").is_empty(), "{g:#?}");
	assert!(idx(&g, "  turnin 1") >= 0, "{g:#?}");
}

#[test]
fn a_flight_path_learnt_on_the_way_is_a_stop_at_its_master() {
	// c17 Feralas: the leg from Freewind Post walks by Gadgetzan's master (learning its path) on to
	// Steamwheedle Port; the getfp was written in the port's step, sending the player 1,000 yd back.
	// The walk stops at the master first.
	let fr = json!({ "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 });
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Orc,Troll,Tauren,Undead,Skyborne",
				"levels 39-40",
				"zone The Barrens",
				"",
				"step Camp",
				"  accept 1",
				"",
				"step Shady Rest Inn",
				"  zone Dustwallow Marsh",
				"  turnin 1",
				"",
			],
		)],
		world: json!({
			"points": [[1, 1, 0, -800, 1413], [1, 1, 800, 600, 1445], [1, 1, -200, 500, 1445]],
			"zones": { "1413": "The Barrens", "1445": "Dustwallow Marsh" },
			"quests": [],
			"nodes": [{ "kind": "fp", "name": "Brackenwall Village", "pt": 1 }]
		}),
		frames: json!({ "era": { "1413": fr, "1445": fr } }),
		quests: json!({ "1": { "title": "One" } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 8) },
            { "t": "turnin", "q": 1, "pt": 2, "from": f("a", 12), "items": [{ "t": "network", "from": 0, "to": 2, "legs": [{ "k": "walk", "to": 1, "node": 0 }, { "k": "walk", "to": 2 }] }, { "t": "getfp", "node": 0 }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let stop = idx(&g, "step Brackenwall Village flight master");
	let fp = idx(&g, "  getfp \"Brackenwall Village\"");
	assert!(stop >= 0 && fp > stop, "{g:#?}");
	assert!(g[stop as usize..fp as usize].iter().any(|l| l.starts_with("  goto 80.0,10.0")), "{g:#?}");
	assert!(fp < idx(&g, "  turnin 1"), "{g:#?}");
	assert_eq!(pick(&g, r"^\s+getfp").len(), 1, "{g:#?}");
}

#[test]
fn a_walk_into_another_zone_goes_over_its_zone_crossing() {
	// c15 (27): the Emerald Sanctuary to Everlook is walked through Felwood's Timbermaw tunnel; the
	// arrow straight across the border is no way. The crossing's Winterspring end is written first.
	use forge_world::world::{Crossing, Crossings};
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Human,Dwarf,Gnome,NightElf,Skyborne",
				"levels 53-55",
				"zone Felwood",
				"",
				"step Sanctuary",
				"  accept 1",
				"",
				"step Everlook",
				"  zone Winterspring",
				"  turnin 1",
				"",
			],
		)],
		world: json!({ "points": [[1, 1, 800, -500, 1448], [1, 1, 800, 500, 1452]], "zones": { "1448": "Felwood", "1452": "Winterspring" }, "quests": [] }),
		frames: json!({ "era": { "1448": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1452": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 8) },
            { "t": "turnin", "q": 1, "pt": 1, "from": f("a", 12), "items": [{ "t": "network", "from": 0, "to": 1, "legs": [{ "k": "walk", "to": 1 }] }] }
        ] }),
		route_travel: true,
		crossings: Some(Crossings {
			ways: vec![Crossing { id: "felwood--winterspring".into(), c: 1, a: (1448, -800.0, -10.0, 30.0), b: (1452, -800.0, 10.0, 30.0), one_way: false }],
			open: Vec::new(),
		}),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (cross, walk) = (idx(&g, "step Into Winterspring"), idx(&g, "step Winterspring"));
	assert!(cross >= 0 && walk > cross, "{g:#?}");
	assert_eq!(&g[cross as usize + 1..cross as usize + 3], ["  zone Winterspring", "  goto 50.5,90.0 \"Into Winterspring\""], "{g:#?}");
	// No crossings known: the one goto.
	let g = run(&Case { crossings: None, ..c }, None).read("a");
	assert!(idx(&g, "step Into Winterspring") < 0 && idx(&g, "step Winterspring") >= 0, "{g:#?}");
}

fn sw_hillsbrad_world() -> (Value, Value) {
	(
		json!({
			"points": [[0, 0, 0, 0, 1453], [0, 0, 10, 10, 1453], [0, 0, 900, 900, 1424], [0, 0, 890, 890, 1424], [0, 0, 920, 950, 1424], [0, 0, -900, -900, 1453], [0, 0, 600, 1000, 1424]],
			"zones": { "1453": "Stormwind City", "1424": "Hillsbrad Foothills" }, "quests": [],
			"nodes": [{ "kind": "fp", "name": "Stormwind", "pt": 1 }, { "kind": "fp", "name": "Southshore", "pt": 3 }]
		}),
		json!({ "era": { "1453": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1424": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
	)
}

#[test]
fn an_item_started_accept_moved_to_its_step_leaves_its_travel_for_the_next_event() {
	// c15 (27b), Arathi: the Assassin's Contract (item-started) is taken right after the route's tram
	// and flights to Southshore, and written with its step after Marshal Redpath's; the way there is
	// Redpath's, not a second way of v1's (Menethil's boat) with the route's flights after the boat.
	let (world, frames) = sw_hillsbrad_world();
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Human,Dwarf,Gnome,NightElf,Skyborne",
				"levels 37-38",
				"zone Stormwind City",
				"",
				"step Stormwind",
				"  accept 9",
				"",
				"step Southshore",
				"  zone Hillsbrad Foothills",
				"  accept 6",
				"",
				"step Shadowy Assassin",
				"  kill 2434",
				"  accept 5",
				"  turnin 5",
				"",
			],
		)],
		world,
		frames,
		quests: json!({ "5": { "title": "Contract", "start": { "item": [3668] } }, "6": { "title": "Redpath" }, "9": { "title": "Milton" } }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [
            { "t": "accept", "q": 9, "pt": 0, "from": f("a", 8) },
            { "t": "accept", "q": 5, "pt": 4, "from": f("a", 16), "items": [{ "t": "network", "from": 0, "to": 4, "legs": [{ "k": "walk", "to": 1, "node": 0 }, { "k": "fly", "from": 0, "to": 1 }, { "k": "walk", "to": 4 }] }] },
            { "t": "accept", "q": 6, "pt": 2, "from": f("a", 12) },
            { "t": "turnin", "q": 5, "pt": 6, "from": f("a", 17) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (fly, redpath) = (idx(&g, "  fly \"Southshore\""), idx(&g, "  accept 6"));
	assert!(fly >= 0 && redpath > fly, "{g:#?}");
	assert!(pick(&g, r"^\s+fly\s").len() == 1 && idx(&g, "step Hillsbrad Foothills") < 0, "{g:#?}");
}

#[test]
fn travel_to_a_step_from_elsewhere_than_the_event_before_stays() {
	// c15 (28), Eastern Plaguelands: the cloth hand-ins at Thunder Bluff come after the bag tasks of
	// the same step, which the route does where it stands (their points are the cloth's drop camps);
	// the route's way from the Plaguelands (the Light's Hope flight) is written, not stripped as a hop
	// within the step.
	let (world, frames) = sw_hillsbrad_world();
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Human,Dwarf,Gnome,NightElf,Skyborne",
				"levels 57-58",
				"zone Stormwind City",
				"",
				"step Lodge",
				"  accept 9",
				"",
				"step Rumstag",
				"  zone Hillsbrad Foothills",
				"  turnin 6",
				"  turnin 5",
				"",
			],
		)],
		world,
		frames,
		quests: json!({ "5": { "title": "Wool" }, "6": { "title": "Silk" }, "9": { "title": "Lodge" } }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [
            { "t": "accept", "q": 9, "pt": 0, "from": f("a", 8) },
            { "t": "task", "q": 5, "task": 0, "pt": 5, "from": f("a", 13) },
            { "t": "turnin", "q": 6, "pt": 2, "from": f("a", 12), "items": [{ "t": "network", "from": 0, "to": 2, "legs": [{ "k": "walk", "to": 1, "node": 0 }, { "k": "fly", "from": 0, "to": 1 }, { "k": "walk", "to": 2 }] }] },
            { "t": "turnin", "q": 5, "pt": 2, "from": f("a", 13) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (fly, hand) = (idx(&g, "  fly \"Southshore\""), idx(&g, "  turnin 6"));
	assert!(fly >= 0 && hand > fly, "{g:#?}");
}

#[test]
fn a_leg_from_elsewhere_to_work_where_the_player_already_is_is_not_written() {
	// c15w, Felwood: the route takes the Cursed Oozes (the guide walks there) before its leg from
	// Ironforge to the Tainted Oozes 640 yd on. That leg starts where the player no longer is: not
	// replayed (the guide went back round by Booty Bay, Ironforge, Auberdine and Astranaar), and both
	// jars stay in the Oozes step.
	let (world, frames) = sw_hillsbrad_world();
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Human,Dwarf,Gnome,NightElf,Skyborne",
				"levels 52-53",
				"zone Stormwind City",
				"",
				"step Curator",
				"  accept 3",
				"",
				"step Oozes",
				"  zone Hillsbrad Foothills",
				"  collect 11 quest 4.1",
				"  collect 12 quest 4.2",
				"",
			],
		)],
		world,
		frames,
		quests: json!({ "3": { "title": "Curator" }, "4": { "title": "Slime" } }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [
            { "t": "accept", "q": 3, "pt": 0, "from": f("a", 8) },
            { "t": "task", "q": 4, "task": 0, "pt": 2, "from": f("a", 12) },
            { "t": "task", "q": 4, "task": 1, "pt": 6, "from": f("a", 13), "items": [{ "t": "network", "from": 0, "to": 6, "legs": [{ "k": "walk", "to": 1, "node": 0 }, { "k": "fly", "from": 0, "to": 1 }, { "k": "walk", "to": 6 }] }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(pick(&g, r"^\s+fly\s").is_empty(), "{g:#?}");
	let (cursed, tainted) = (idx(&g, "  collect 11 quest 4.1"), idx(&g, "  collect 12 quest 4.2"));
	assert!(cursed >= 0 && tainted == cursed + 1, "{g:#?}");
}

#[test]
fn a_walk_over_zone_crossings_a_known_flight_beats_is_flown() {
	// c15w, Thousand Needles: the route walks from Stormwind to Menethil for the Lightforge Ingots;
	// over the zone crossings that is Elwynn, Redridge, Riverglades, Loch Modan and the Wetlands, ~40
	// minutes. The flight between the known flight paths is quicker: flown, as c15 did.
	use forge_world::world::{Crossing, Crossings};
	let fr = json!({ "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 });
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Human,Dwarf,Gnome,NightElf,Skyborne",
				"levels 30-31",
				"zone Stormwind City",
				"",
				"step Stormwind",
				"  accept 1",
				"",
				"step Menethil Bay",
				"  zone Wetlands",
				"  turnin 1",
				"",
			],
		)],
		world: json!({
			"points": [[0, 0, 0, -800, 1453], [0, 0, 0, -790, 1453], [0, 0, 0, 790, 1437], [0, 0, 0, 800, 1437]],
			"zones": { "1453": "Stormwind City", "1433": "Redridge Mountains", "1437": "Wetlands" }, "quests": [],
			"nodes": [{ "kind": "fp", "name": "Stormwind", "pt": 1 }, { "kind": "fp", "name": "Menethil Harbor", "pt": 2 }]
		}),
		frames: json!({ "era": { "1453": fr, "1433": fr, "1437": fr } }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 8), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }] },
            { "t": "turnin", "q": 1, "pt": 3, "from": f("a", 12), "items": [{ "t": "network", "from": 0, "to": 3, "legs": [{ "k": "walk", "to": 3 }] }] }
        ] }),
		route_travel: true,
		crossings: Some(Crossings {
			ways: vec![
				Crossing { id: "stormwind--redridge".into(), c: 0, a: (1453, -900.0, -310.0, 30.0), b: (1433, -900.0, -290.0, 30.0), one_way: false },
				Crossing { id: "redridge--wetlands".into(), c: 0, a: (1433, 900.0, 290.0, 30.0), b: (1437, 900.0, 310.0, 30.0), one_way: false },
			],
			open: Vec::new(),
		}),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (fly, hand) = (idx(&g, "  fly \"Menethil Harbor\""), idx(&g, "  turnin 1"));
	assert!(fly >= 0 && hand > fly, "{g:#?}");
	assert!(pick(&g, r"^step Into ").is_empty(), "{g:#?}");
}

#[test]
fn a_bag_hand_in_the_route_does_where_it_stands_is_not_walked_to() {
	// c15w, Silithus: in Stormwind the route takes the Wool Cloth for Ironforge's donation (its point
	// the cloth's drop camp in the Wetlands) and a top-up there, then trams to Ironforge from Stormwind.
	// The guide walked to the Wetlands and back; the hand-in is written in Ironforge, after the way
	// there, and no step stands in the Wetlands.
	let fr = json!({ "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 });
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Human,Dwarf,Gnome,NightElf,Skyborne",
				"levels 59-60",
				"zone Stormwind City",
				"",
				"step Stormwind",
				"  accept 9",
				"",
				"step Ironforge",
				"  zone Ironforge",
				"  collect 2592 x60 quest 7.1 optional @24.2,74.7 map 1455 -- Wool Cloth, from your bags",
				"  turnin 7 optional",
				"",
			],
		)],
		world: json!({
			"points": [[0, 0, 0, 0, 1453], [0, 0, 10, 10, 1453], [0, 0, 900, 900, 1455], [0, 0, 910, 910, 1455], [0, 0, -900, 900, 1437]],
			"zones": { "1453": "Stormwind City", "1455": "Ironforge", "1437": "Wetlands" }, "quests": [],
			"nodes": [{ "kind": "fp", "name": "Stormwind", "pt": 1 }, { "kind": "fp", "name": "Ironforge", "pt": 2 }]
		}),
		frames: json!({ "era": { "1453": fr, "1455": fr, "1437": fr } }),
		quests: json!({ "7": { "title": "Wool" }, "9": { "title": "Flint" } }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [
            { "t": "accept", "q": 9, "pt": 0, "lvl": 59.49, "from": f("a", 8) },
            { "t": "task", "q": 7, "task": 0, "pt": 4, "lvl": 59.49, "from": f("a", 12) },
            { "t": "level", "lvl": 59.49, "target": 59.5, "min": 3.1, "from": "inserted" },
            { "t": "turnin", "q": 7, "pt": 3, "lvl": 59.5, "from": f("a", 13), "items": [{ "t": "network", "from": 0, "to": 3, "legs": [{ "k": "walk", "to": 1, "node": 0 }, { "k": "fly", "from": 0, "to": 1 }, { "k": "walk", "to": 3 }] }] }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(pick(&g, r"Wetlands|^\s+level\s").is_empty(), "{g:#?}");
	let (fly, bag) = (idx(&g, "  fly \"Ironforge\""), g.iter().position(|l| l.starts_with("  collect 2592 x60 quest 7.1")).map_or(-1, |i| i as i64));
	assert!(fly >= 0 && bag > fly, "{g:#?}");
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
fn v1s_travel_step_for_the_routes_ride_goes_with_that_ride() {
	// Rev15A2 (15): v1's Ratchet step (flight path, boat to Booty Bay) went to the route's earlier
	// Barrens pass, before the hearth to Theramore: a walk to Ratchet and a flight back to Theramore,
	// then a flight to Ratchet again for the route's own boat.
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
				"step Camp",
				"  accept 4",
				"",
				"step Theramore",
				"  zone Durotar",
				"  accept 1",
				"  turnin 1",
				"",
				"step Ratchet",
				"  zone The Barrens",
				"  getfp \"Crossroads\"",
				"  goto 75.5,25.5 \"Boat to Stormwind\"",
				"",
				"step Bay",
				"  zone Stormwind City",
				"  accept 2",
				"  accept 3",
				"",
			],
		)],
		world: json!({
			"points": [[1, 1, -500, -500, 1411], [1, 1, 500, 500, 1413], [1, 1, 510, 510, 1413], [0, 0, 0, 0, 1453], [0, 0, 5, 5, 1453], [1, 1, 400, 400, 1413]],
			"zones": { "1411": "Durotar", "1413": "The Barrens", "1453": "Stormwind City" }, "quests": [],
			"nodes": [{ "kind": "fp", "name": "Crossroads", "pt": 1 }, { "kind": "dock", "name": "Ratchet (boat)", "pt": 2 }, { "kind": "dock", "name": "Stormwind Harbor (boat)", "pt": 4 }],
			"rides": [[1, 2, 100, 200, "boat-x"]]
		}),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1453": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 4, "pt": 5, "from": f("a", 8) },
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 12) },
            { "t": "turnin", "q": 1, "pt": 0, "from": f("a", 13) },
            { "t": "accept", "q": 2, "pt": 3, "from": f("a", 22), "items": [{ "t": "network", "from": 0, "to": 3, "legs": [{ "k": "walk", "to": 2, "node": 1 }, { "k": "ride", "ride": 0, "from": 1, "to": 2 }, { "k": "walk", "to": 3 }] }] },
            { "t": "accept", "q": 3, "pt": 3, "from": f("a", 23) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let fp = idx(&g, "  getfp \"Crossroads\"");
	assert!(fp > idx(&g, "  turnin 1") && fp < idx(&g, "  accept 2"), "{g:#?}");
}

#[test]
fn v1s_training_step_over_the_sea_goes_before_the_routes_ride_from_its_town() {
	// c18 Horde Silverpine dup-trip: v1's "To Orgrimmar" (`train class` only) hung on the Sepulcher
	// hand-in after the route had walked from Ratchet to the Orgrimmar zeppelin and crossed: a
	// zeppelin trip back to Orgrimmar and back to the Sepulcher. It goes before the ride from there.
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
				"step Ratchet",
				"  accept 4",
				"  accept 1",
				"",
				"step To Orgrimmar",
				"  zone Orgrimmar",
				"  train class only Warrior",
				"",
				"step The Sepulcher",
				"  zone Silverpine Forest",
				"  turnin 1",
				"  accept 3",
				"",
				"step Sepulcher again",
				"  zone Silverpine Forest",
				"  accept 2",
				"",
			],
		)],
		world: json!({
			"points": [[1, 1, 800, 800, 1413], [1, 1, 300, 300, 1411], [0, 0, 0, 0, 1420], [0, 0, 500, 500, 1421]],
			"zones": { "1411": "Durotar", "1413": "The Barrens", "1454": "Orgrimmar", "1420": "Tirisfal Glades", "1421": "Silverpine Forest" }, "quests": [],
			"nodes": [{ "kind": "dock", "name": "Orgrimmar (zeppelin)", "pt": 1 }, { "kind": "dock", "name": "Undercity (zeppelin)", "pt": 2 }],
			"rides": [[0, 1, 100, 200, "zeppelin-x"]]
		}),
		frames: json!({ "era": {
			"1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 },
			"1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 },
			"1454": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 },
			"1420": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 },
			"1421": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }
		} }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 4, "pt": 0, "from": f("a", 8) },
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 9) },
            { "t": "accept", "q": 2, "pt": 3, "from": f("a", 22), "items": [{ "t": "network", "from": 0, "to": 3, "legs": [{ "k": "walk", "to": 1, "node": 0 }, { "k": "ride", "ride": 0, "from": 0, "to": 1 }, { "k": "walk", "to": 3 }] }] },
            { "t": "accept", "q": 3, "pt": 3, "from": f("a", 18) },
            { "t": "turnin", "q": 1, "pt": 3, "from": f("a", 17) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let tr = idx(&g, "  train class only Warrior");
	assert!(tr > idx(&g, "  accept 1") && tr < idx(&g, "  accept 2"), "{g:#?}");
}

#[test]
fn a_class_step_after_a_training_moved_to_the_dock_walk_does_not_follow_it() {
	// c18 Tauren Silverpine bounce: with v1's "To Orgrimmar" moved before the zeppelin, the Druids'
	// Thunder Bluff step after it in v1 went there too, and the writer split their run (a flight off
	// at Ratchet, the Moonglade trial after the others' way to the Sepulcher, ways back per audience).
	// It stays where it fell before: at the Sepulcher, the Druids' own trip.
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
				"step Ratchet",
				"  accept 4",
				"  accept 1",
				"",
				"step To Orgrimmar",
				"  zone Orgrimmar",
				"  train class only Warrior",
				"",
				"step Thunder Bluff",
				"  only Druid",
				"  zone Thunder Bluff",
				"  train class",
				"  accept 5 only Tauren",
				"",
				"step The Sepulcher",
				"  zone Silverpine Forest",
				"  turnin 1",
				"  accept 3",
				"",
				"step Sepulcher again",
				"  zone Silverpine Forest",
				"  accept 2",
				"",
			],
		)],
		world: json!({
			"points": [[1, 1, 800, 800, 1413], [1, 1, 300, 300, 1411], [0, 0, 0, 0, 1420], [0, 0, 500, 500, 1421]],
			"zones": { "1411": "Durotar", "1413": "The Barrens", "1454": "Orgrimmar", "1456": "Thunder Bluff", "1420": "Tirisfal Glades", "1421": "Silverpine Forest" }, "quests": [],
			"nodes": [{ "kind": "dock", "name": "Orgrimmar (zeppelin)", "pt": 1 }, { "kind": "dock", "name": "Undercity (zeppelin)", "pt": 2 }],
			"rides": [[0, 1, 100, 200, "zeppelin-x"]]
		}),
		frames: json!({ "era": {
			"1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 },
			"1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 },
			"1454": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 },
			"1456": { "top": 3000, "bottom": 1000, "left": -1000, "right": 1000, "c": 1 },
			"1420": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 },
			"1421": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }
		} }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 4, "pt": 0, "from": f("a", 8) },
            { "t": "accept", "q": 1, "pt": 0, "from": f("a", 9) },
            { "t": "accept", "q": 2, "pt": 3, "from": f("a", 28), "items": [{ "t": "network", "from": 0, "to": 3, "legs": [{ "k": "walk", "to": 1, "node": 0 }, { "k": "ride", "ride": 0, "from": 0, "to": 1 }, { "k": "walk", "to": 3 }] }] },
            { "t": "accept", "q": 3, "pt": 3, "from": f("a", 24) },
            { "t": "turnin", "q": 1, "pt": 3, "from": f("a", 23) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let tr = idx(&g, "  train class only Warrior");
	assert!(tr > idx(&g, "  accept 1") && tr < idx(&g, "  accept 2"), "{g:#?}");
	let druid = g.iter().position(|l| l.starts_with("  accept 5")).map_or(-1, |i| i as i64);
	assert!(druid > idx(&g, "  accept 2"), "{g:#?}");
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
			vec![
				"guide t/a",
				"title A",
				"levels 1-5",
				"zone Durotar",
				"",
				"step Kobolds",
				"  collect 100 x1",
				"  accept 10",
				"",
				"step Abbey",
				"  turnin 10",
				"  accept 11",
				"  turnin 11",
				"  accept 12",
				"",
			],
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
	assert_eq!(pick(&g, r"^\s+(collect|accept|turnin)"), vec!["  collect 100 x1 optional", "  accept 10 optional", "  turnin 10", "  accept 11 optional", "  turnin 11", "  accept 12"], "{g:#?}");
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
			lines(
				&START_OT,
				&["", "step Den", "  accept 1", "", "step Riding", "  zone The Barrens", "  only Orc,Skyborne", "  train 4752 optional", "", "step Camp", "  zone The Barrens", "  turnin 1", ""],
			),
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
fn a_repeatable_its_giver_takes_back_at_the_same_stop_is_a_direct_turnin() {
	// #1153: Westfall's The Tome of Divinity (1641, repeatable, Duthorian Rall gives and takes it) was
	// written `accept 1641 only Human` + `turnin 1641`; the client never flags it completed, so after a
	// reload the step reopened. A repeatable not taken back by its giver, or taken and handed in at
	// different stops, keeps its accept.
	let quests: BTreeMap<u32, forge_writer::input::Quest> = serde_json::from_value(json!({
		"1641": { "title": "The Tome of Divinity", "repeatable": true, "start": { "npc": [6171] }, "end": { "npc": [6171] } },
		"5": { "title": "Other ender", "repeatable": true, "start": { "npc": [1] }, "end": { "npc": [2] } },
		"6": { "title": "Two stops", "repeatable": true, "start": { "npc": [3] }, "end": { "npc": [3] } },
		"7": { "title": "Tracked", "repeatable": true, "start": { "npc": [4] }, "end": { "npc": [4] } }
	}))
	.unwrap();
	let data = Data { quests, ..Data::default() };
	let mut files = vec![[
		"step Duthorian Rall",
		"  accept 1641 only Human              -- Duthorian Rall",
		"  turnin 1641                         -- Duthorian Rall",
		"  accept 5",
		"  turnin 5",
		"  accept 6",
		"  accept 7",
		"  complete 7",
		"  turnin 7",
		"",
		"step Later",
		"  turnin 6",
	]
	.join("\n")];
	forge_writer::post::repeatable_direct(&mut files, &data);
	assert_eq!(
		files[0].split('\n').collect::<Vec<_>>(),
		vec![
			"step Duthorian Rall",
			"  turnin 1641 direct only Human -- Duthorian Rall",
			"  accept 5",
			"  turnin 5",
			"  accept 6",
			"  accept 7",
			"  complete 7",
			"  turnin 7",
			"",
			"step Later",
			"  turnin 6"
		]
	);
}

#[test]
fn a_goal_with_two_only_words_gets_one_list() {
	// The 2026-11-07 candidate: Continue to Stormwind's hand-in came out of a step for every class but
	// Rogues into Osric Strang's step and was cut to Humans as well: `turnin 6281 only !Rogue only Human`,
	// which the compiler refuses (duplicate `only`). One list ANDs the class and the race the same way.
	let mut files = vec![["step Osric Strang", "  zone Stormwind City", "  turnin 6281 only !Rogue only Human -- Osric", "  accept 6261 only Human", "  only Human"].join("\n")];
	forge_writer::post::one_only(&mut files);
	assert_eq!(files[0].split('\n').collect::<Vec<_>>(), vec!["step Osric Strang", "  zone Stormwind City", "  turnin 6281 only !Rogue,Human -- Osric", "  accept 6261 only Human", "  only Human"]);
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
fn a_class_way_prices_its_walks_over_the_zone_crossings() {
	// c18 Alliance 07-thousand-needles: the Warlocks' Takar the Seer (the Barrens) is written after the
	// Mirage Raceway; the class way flew them from Auberdine (Ashenvale here), a flight master across a
	// border whose crossing is far off, the straight line to it short. Over the crossings that walk is
	// longer than the walk up the Great Lift: no flight, their walk into the Barrens, theirs alone.
	use forge_world::world::{Crossing, Crossings};
	let fr = json!({ "top": 10000, "bottom": -10000, "left": -10000, "right": 10000, "c": 1 });
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Human,Dwarf,Gnome,NightElf,Skyborne",
				"levels 28-30",
				"zone Thousand Needles",
				"",
				"step Mirage Raceway",
				"  accept 1",
				"",
				"step Takar the Seer",
				"  only Warlock",
				"  zone The Barrens",
				"  accept 9",
				"",
				"step The salt flats",
				"  turnin 1",
				"",
			],
		)],
		world: json!({
			"points": [[1, 1, 0, 0, 1441], [1, 1, 0, 6000, 1413], [1, 1, -1500, 0, 1440], [1, 1, 0, 5800, 1413], [1, 1, 200, 0, 1441]],
			"zones": { "1441": "Thousand Needles", "1413": "The Barrens", "1440": "Ashenvale" },
			"quests": [{ "id": 1, "giver": 0, "ender": 4 }, { "id": 9, "giver": 1, "ender": 1 }],
			"nodes": [{ "kind": "fp", "name": "Auberdine", "pt": 2 }, { "kind": "fp", "name": "Astranaar", "pt": 3 }]
		}),
		frames: json!({ "era": { "1441": fr, "1413": fr, "1440": fr } }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 8), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }] },
			{ "t": "turnin", "q": 1, "pt": 4, "from": f("a", 16) }
		] }),
		route_travel: true,
		crossings: Some(Crossings {
			ways: vec![
				Crossing { id: "thousand-needles--the-barrens".into(), c: 1, a: (1441, 0.0, 2990.0, 30.0), b: (1413, 0.0, 3010.0, 30.0), one_way: false },
				Crossing { id: "thousand-needles--ashenvale".into(), c: 1, a: (1441, 0.0, -2990.0, 30.0), b: (1440, 0.0, -3010.0, 30.0), one_way: false },
			],
			open: Vec::new(),
		}),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(pick(&g, r"^\s+fly\s").is_empty() && pick(&g, r"flight master").is_empty(), "{g:#?}");
	let (into, there, takar) = (idx(&g, "step Into The Barrens"), idx(&g, "step The Barrens"), idx(&g, "step Takar the Seer"));
	assert!(into >= 0 && into < there && there < takar, "{g:#?}");
	assert!(g[into as usize + 1] == "  only Warlock" && g[there as usize + 1] == "  only Warlock", "{g:#?}");
}

#[test]
fn a_class_trip_whose_lines_all_wait_for_a_level_is_not_made() {
	// c17 Barrens: the Rogues flew from Ratchet to Orgrimmar and straight back: Shenthul's quests there
	// wait for level 20 (held for a later pass), so the trip did nothing.
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
		quests: json!({ "7": { "title": "Seven", "minLevel": 20 } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
            { "t": "accept", "q": 1, "lvl": 5.0, "pt": 3, "from": f("a", 8), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }, { "t": "getfp", "node": 2 }] },
            { "t": "turnin", "q": 1, "lvl": 5.2, "pt": 1, "from": f("a", 17) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let fly = idx(&g, "  fly \"Thunder Bluff\"");
	assert!(fly < 0 || fly > idx(&g, "  accept 7 only Shaman"), "{g:#?}");
	assert!(pick(&g, r"^step Back to").is_empty(), "{g:#?}");
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
	let out: Vec<String> =
		["step Auberdine", "  accept 97914", "  goto 30.76,40.92 \"Boat to Stormwind\"", "", "step Auberdine", "  turnin 4763", "", "step Next", "  accept 1"].iter().map(|s| s.to_string()).collect();
	assert_eq!(forge_writer::post::same_place_pieces(out), vec!["step Auberdine", "  accept 97914", "  turnin 4763", "  goto 30.76,40.92 \"Boat to Stormwind\"", "", "step Next", "  accept 1"]);
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
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Hub", "  accept 1", "  accept 2", "", "step Lydon", "  turnin 1 optional", "", "step Camp", "  turnin 2", ""],
		)],
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
			vec![
				"guide t/a",
				"title A",
				"levels 30-35",
				"zone Stranglethorn Vale",
				"",
				"step Hub",
				"  accept 1",
				"",
				"step Orgrimmar",
				"  only Shaman",
				"  zone Orgrimmar",
				"  train class",
				"",
				"step Camp",
				"  zone Stranglethorn Vale",
				"  turnin 1",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 10-15",
				"zone The Barrens",
				"",
				"step Hub",
				"  accept 1",
				"",
				"step Tirisfal",
				"  only Paladin",
				"  zone Tirisfal Glades",
				"  accept 9",
				"",
				"step Camp",
				"  zone The Barrens",
				"  turnin 1",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 50-55",
				"zone Durotar",
				"",
				"step Bulwark",
				"  accept 5 optional",
				"  turnin 5 optional",
				"",
				"step Later",
				"  accept 6",
				"  collect 50 x10 optional",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 10-15",
				"zone Durotar",
				"",
				"step Hub",
				"  accept 1",
				"",
				"step Dughan",
				"  turnin 7",
				"",
				"step Field",
				"  kill 9 quest 1.1",
				"  collect 40 x1 optional",
				"  accept 7 optional",
				"",
				"step Camp",
				"  turnin 1",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 10-15",
				"zone Durotar",
				"",
				"step Hub",
				"  accept 1",
				"  accept 7",
				"",
				"step Field",
				"  kill 9 quest 1.1",
				"  collect 40 quest 7.1",
				"",
				"step Camp",
				"  turnin 1",
				"  turnin 7",
				"",
			],
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
				"guide t/a",
				"title A",
				"levels 38-40",
				"zone The Barrens",
				"",
				"step Hub",
				"  accept 1",
				"  accept 2",
				"",
				"step Orgrimmar",
				"  zone Orgrimmar",
				"  train class only Warrior,Hunter,Rogue,Priest,Shaman,Mage,Warlock",
				"",
				"step Thunder Bluff",
				"  only Druid,Paladin",
				"  zone Thunder Bluff",
				"  train class",
				"",
				"step Thunder Bluff again",
				"  only Druid,Paladin",
				"  zone Thunder Bluff",
				"  getfp \"Thunder Bluff\"",
				"  train class",
				"",
				"step Camp",
				"  zone The Barrens",
				"  turnin 1",
				"",
				"step Field",
				"  turnin 2",
				"",
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
			vec![
				"guide t/a",
				"title A",
				"levels 56-58",
				"zone Stormwind City",
				"",
				"step Royal Factor",
				"  accept 1",
				"",
				"step Ironforge",
				"  zone Ironforge",
				"  train class only Warrior,Mage",
				"",
				"step Ol' Emma",
				"  zone Stormwind City",
				"  turnin 1",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 20-24",
				"zone Orgrimmar",
				"",
				"step Hub",
				"  accept 1",
				"  accept 2",
				"",
				"step Orgrimmar at 23",
				"  fly \"Orgrimmar\"",
				"  train class",
				"",
				"step Camp",
				"  turnin 1",
				"",
				"step Field",
				"  turnin 2",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 9-12",
				"zone Tirisfal Glades",
				"",
				"step Brill",
				"  accept 1",
				"  accept 2",
				"",
				"step Paladin: Whispering Forest",
				"  only Paladin",
				"  accept 9",
				"",
				"step Crossroads",
				"  zone The Barrens",
				"  turnin 1",
				"",
				"step Barrens camp",
				"  turnin 2",
				"",
			],
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
fn a_class_step_of_a_town_the_route_has_left_goes_beside_its_own_place_in_the_visit() {
	// c18 Tauren Druid dup-trip: Elder Rise's accept, Eyahn Eagletalon's hand-in on the central rise
	// (480 yd away), then the Crossroads; the Druids' Turak Runetotem step (Elder Rise, not in the route)
	// went after Eyahn, a walk back to Elder Rise. It goes after the Elder Rise piece.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 11-13",
				"zone Thunder Bluff",
				"",
				"step Elder Rise",
				"  accept 1",
				"  accept 2",
				"",
				"step Eyahn Eagletalon",
				"  turnin 2",
				"",
				"step Turak Runetotem",
				"  only Druid",
				"  accept 3",
				"",
				"step Crossroads",
				"  zone The Barrens",
				"  turnin 1",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 12.0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 0, "lvl": 12.0, "from": f("a", 8) },
			{ "t": "turnin", "q": 2, "pt": 1, "lvl": 12.1, "from": f("a", 11) },
			{ "t": "turnin", "q": 1, "pt": 2, "lvl": 12.2, "from": f("a", 19) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1456], [1, 1, 480, 0, 1456], [1, 1, 5000, 0, 1413]], "zones": { "1456": "Thunder Bluff", "1413": "The Barrens" },
			"quests": [{ "id": 1, "giver": 0, "ender": 2 }, { "id": 2, "giver": 0, "ender": 1 }, { "id": 3, "giver": 0, "ender": 0 }] }),
		quests: json!({ "1": { "title": "One", "minLevel": 10, "level": 12 }, "2": { "title": "Two", "minLevel": 10, "level": 12 }, "3": { "title": "Three", "minLevel": 10, "level": 12 } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let t = idx(&g, "  accept 3");
	assert!(idx(&g, "  accept 2") < t && t < idx(&g, "  turnin 2"), "{g:#?}");
}

#[test]
fn a_class_run_of_a_town_the_route_has_left_stays_beside_its_place_then_goes_on_after_the_town() {
	// c18 Tauren Druid dup-trip: Heeding the Call taken in a line of Elder Rise's step the route does
	// not name, Eyahn Eagletalon's hand-in (added by the route) on the central rise 480 yd away, then the
	// Crossroads. The Druids' Turak step (ready at no piece) went after Eyahn, then back to Elder Rise.
	// Turak goes after the Elder Rise piece; Moonglade and the hearth back after Eyahn, not before him
	// and a walk back from Moonglade.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 11-13",
				"zone Thunder Bluff",
				"",
				"step Elder Rise",
				"  accept 1",
				"  accept 2",
				"  accept 3 only Druid",
				"",
				"step Turak Runetotem",
				"  only Druid",
				"  turnin 3",
				"  accept 4",
				"",
				"step Moonglade",
				"  only Druid",
				"  zone Moonglade",
				"  turnin 4",
				"  accept 5",
				"",
				"step Back to Thunder Bluff",
				"  only Druid",
				"  zone Thunder Bluff",
				"  hearth \"Thunder Bluff\" only Druid",
				"  turnin 5",
				"",
				"step Crossroads",
				"  zone The Barrens",
				"  turnin 1",
				"",
			],
		)],
		route: json!({ "diff": { "added": [2] }, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 12.0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 0, "lvl": 12.0, "from": f("a", 8) },
			{ "t": "turnin", "q": 2, "pt": 1, "lvl": 12.1, "from": "inserted" },
			{ "t": "turnin", "q": 1, "pt": 2, "lvl": 12.2, "from": f("a", 30) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1456], [1, 1, 480, 0, 1456], [1, 1, 5000, 0, 1413], [1, 1, 2000, 3000, 1450]],
			"zones": { "1456": "Thunder Bluff", "1413": "The Barrens", "1450": "Moonglade" },
			"quests": [
				{ "id": 1, "giver": 0, "ender": 2 }, { "id": 2, "giver": 0, "ender": 1 }, { "id": 3, "giver": 0, "ender": 0 },
				{ "id": 4, "giver": 0, "ender": 3 }, { "id": 5, "giver": 3, "ender": 0 }
			] }),
		quests: json!({
			"1": { "title": "One", "minLevel": 10, "level": 12 }, "2": { "title": "Two", "minLevel": 10, "level": 12 }, "3": { "title": "Three", "minLevel": 10, "level": 12 },
			"4": { "title": "Four", "minLevel": 10, "level": 12 }, "5": { "title": "Five", "minLevel": 10, "level": 12 }
		}),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let at = |re: &str| g.iter().position(|l| m(l, re)).map_or(-1, |i| i as i64);
	let (er, turak, moon, back, eyahn) = (at(r"^\s+accept 2\b"), at(r"^\s+turnin 3\b"), at(r"^\s+turnin 4\b"), at(r"^\s+turnin 5\b"), at(r"^\s+turnin 2\b"));
	assert!(er >= 0 && er < turak && turak < eyahn && eyahn < moon && moon < back, "{g:#?}");
}

#[test]
fn a_step_with_nothing_for_everyone_but_some_races_lines_is_theirs() {
	// c9 Orc, Stonetalon: v1's "To the Undercity" (a flight path, the Skyborne's Sylvanas) was written
	// between two Beren's Peril stops with a walk to the Undercity for everyone. It is the Skyborne's.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 20-25",
				"zone Silverpine Forest",
				"",
				"step Beren's Peril",
				"  accept 1",
				"",
				"step To the Undercity",
				"  zone Undercity",
				"  getfp \"Undercity\"",
				"  kill 10181 quest 9.4 \"Talk to Sylvanas\" only Skyborne optional",
				"",
				"step Beren's Peril again",
				"  zone Silverpine Forest",
				"  turnin 1",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 50-52",
				"zone Hillsbrad Foothills",
				"",
				"step Southshore",
				"  accept 1",
				"",
				"step Ironforge",
				"  zone Ironforge",
				"  sethome \"Ironforge\" npc 5111",
				"",
				"step Camp",
				"  zone Hillsbrad Foothills",
				"  turnin 1",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 38-46",
				"zone Orgrimmar",
				"",
				"step Orgrimmar",
				"  accept 1",
				"",
				"step Feralas",
				"  turnin 1",
				"",
				"step Kildar",
				"  train 4752 optional -- Kildar",
				"",
			],
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
				"guide t/a",
				"title A",
				"levels 20-26",
				"zone Orgrimmar",
				"",
				"step Hub",
				"  accept 1",
				"",
				"step Orgrimmar",
				"  train class only Warrior,Hunter,Rogue,Priest,Shaman,Mage,Warlock",
				"",
				"step Thunder Bluff",
				"  only Druid",
				"  zone Thunder Bluff",
				"  fly \"Thunder Bluff\"",
				"  train class",
				"",
				"step The Sepulcher",
				"  zone Silverpine Forest",
				"  turnin 1",
				"",
				"step Silverpine camp",
				"  accept 2",
				"",
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
			vec![
				"guide t/a",
				"title A",
				"levels 28-32",
				"zone Thousand Needles",
				"",
				"step Mirage Raceway",
				"  accept 1",
				"",
				"step The Great Lift",
				"  tip The Great Lift takes you down into Thousand Needles.",
				"  collect 5791 @30.7,24.3",
				"  accept 1100",
				"",
				"step Raceway again",
				"  turnin 1",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 20-24",
				"zone Durotar",
				"",
				"step Hub",
				"  accept 1",
				"  accept 2",
				"",
				"step Brazier",
				"  only Shaman",
				"  zone The Barrens",
				"  accept 9",
				"",
				"step Camp",
				"  zone Durotar",
				"  turnin 1",
				"",
				"step Barrens camp",
				"  zone The Barrens",
				"  turnin 2",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 30-34",
				"zone Durotar",
				"",
				"step Inn",
				"  sethome \"Razor Hill\"",
				"  accept 1",
				"",
				"step Islen",
				"  only Shaman",
				"  accept 9",
				"",
				"step Back home",
				"  only Shaman",
				"  hearth \"Razor Hill\"",
				"",
				"step Camp",
				"  turnin 1",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 9-11",
				"zone Darnassus",
				"",
				"step Hub",
				"  accept 1",
				"  accept 2",
				"",
				"step Kal",
				"  only Druid",
				"  zone Teldrassil",
				"  train class",
				"  accept 5925",
				"",
				"step Camp",
				"  zone Teldrassil",
				"  turnin 1",
				"",
				"step Field",
				"  turnin 2",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 12-14",
				"zone The Barrens",
				"",
				"step Hub",
				"  accept 1",
				"",
				"step Fly to Crossroads",
				"  goto 45.0,60.0 \"Camp Taurajo flight master\"",
				"  fly \"Crossroads\"",
				"",
				"step Mankrik",
				"  tip Walk back west along the road. Mankrik waits by the inn.",
				"  turnin 1",
				"",
			],
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
		files: vec![("a", vec!["guide t/a", "title A", "levels 8-11", "zone Durotar", "", "step Razor Hill", "  accept 1", "", "step Sen'jin", "  turnin 1", ""])],
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
fn a_class_is_not_dropped_for_a_later_training_without_its_trainer() {
	// c14 Horde 40-50 (Rev14H2 B1): Orgrimmar has no Druid trainer, and the route's next training is
	// Orgrimmar again eleven levels on; Druids were dropped from both. With the route's pass by one of
	// theirs within four levels they train there (no trip from Orgrimmar, c15 Rev15H1); with it later,
	// their own trip from the stop.
	let mut c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 39-51", "zone Durotar", "", "step Org", "  accept 1", "", "step Later", "  turnin 1", ""])],
		world: json!({ "points": [[0, 0, 0, 0, 1411], [0, 0, -800, 800, 1411]], "zones": { "1411": "Durotar" }, "quests": [] }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"3169": { "name": "Tarshaw", "subName": "Warrior Trainer", "faction": "H", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } },
			"3033": { "name": "Turak", "subName": "Druid Trainer", "faction": "H", "spawns": { "1411": { "f": "e", "pts": [[90, 90]] } } }
		}),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 39.5, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "lvl": 39.5, "pt": 0, "from": "train stop" },
			{ "t": "turnin", "q": 1, "lvl": 43.0, "pt": 1, "from": f("a", 10) },
			{ "t": "train", "lvl": 51.0, "pt": 0, "from": "train stop" }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let first = g.iter().position(|l| m(l, r"^\s+train class")).unwrap_or_else(|| panic!("{g:#?}"));
	assert!(!g[first].contains("Druid") && g[first].contains("only"), "{g:#?}");
	let druid = g.iter().position(|l| m(l, r"^\s+train class only .*Druid")).unwrap_or_else(|| panic!("{g:#?}")) as i64;
	assert!(druid > idx(&g, "  turnin 1"), "{g:#?}");
	// The pass by the Druid trainer at 45, five and a half levels on: the Druids' own trip from Orgrimmar.
	c.route["order"][2]["lvl"] = json!(45.0);
	let g = run(&c, None).read("a");
	let first = g.iter().position(|l| m(l, r"^\s+train class")).unwrap_or_else(|| panic!("{g:#?}"));
	assert!(!g[first].contains("Druid"), "{g:#?}");
	// (A step of its own at the Druid trainer, not the stop's, c15 Rev15SkyA.)
	let druid = idx(&g, "step Druid trainer");
	assert!(druid >= 0 && druid < idx(&g, "  turnin 1") && g[druid as usize..].iter().any(|l| m(l, r"^\s+train class only Druid -- Turak")), "{g:#?}");
	// (Turak is in Durotar too: the note does not say Durotar has none, c15 Mai'ah in Durotar.)
	assert!(!g.iter().any(|l| l.contains("Durotar has no druid trainer")), "{g:#?}");
}

#[test]
fn objectives_whose_mobs_share_the_ground_are_one_step() {
	// The CurseForge review: Barrens plainstriders, raptors and zhevra one animal at a time. Work the
	// route does back to back where each other's mobs live is one step; a camp elsewhere stays its own.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 12-15",
				"zone The Barrens",
				"",
				"step Crossroads",
				"  accept 1",
				"  accept 2",
				"  accept 3",
				"",
				"step Plainstriders",
				"  tip Plainstriders roam the plains.",
				"  kill 44 quest 1.1",
				"",
				"step Raptors",
				"  tip Raptors hunt among them.",
				"  accept 4",
				"  collect 69 quest 2.1",
				"",
				"step Far camp",
				"  kill 99 quest 3.1",
				"",
				"step Crossroads again",
				"  turnin 1",
				"  turnin 2",
				"  turnin 3",
				"",
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
			vec![
				"guide t/a",
				"title A",
				"levels 9-13",
				"zone Durotar",
				"",
				"step Hub",
				"  accept 1",
				"",
				"step Tome",
				"  only Paladin",
				"  accept 7",
				"",
				"step Camp",
				"  turnin 1",
				"",
				"step Later",
				"  accept 2",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 9-13",
				"zone Durotar",
				"",
				"step Goldshire",
				"  accept 1",
				"  accept 7 only Paladin",
				"",
				"step Camp",
				"  turnin 1",
				"",
				"step Later",
				"  accept 2",
				"",
				"step Stormwind",
				"  turnin 7 only Paladin",
				"  turnin 2",
				"",
			],
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
fn a_held_class_accepts_later_line_elsewhere_keeps_its_own_step() {
	// c17 Barrens: the Warlocks' News of Dogran accept (1510, level 20) waited for the level with its
	// hand-in to Ken'zigla in Stonetalon, both written in one "Gazrog" step at the Crossroads.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 9-13",
				"zone Durotar",
				"",
				"step Goldshire",
				"  accept 1",
				"  accept 7 only Paladin",
				"",
				"step Camp",
				"  turnin 1",
				"",
				"step Trainer",
				"  only Paladin",
				"  turnin 7",
				"",
				"step Later",
				"  accept 2",
				"",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1411]], "zones": { "1411": "Durotar" }, "quests": [] }),
		quests: json!({ "7": { "title": "Tome", "minLevel": 12 } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 9.5, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 1, "lvl": 9.7, "pt": 0, "from": f("a", 11) },
			{ "t": "accept", "q": 2, "lvl": 12.1, "pt": 0, "from": f("a", 18) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (a, t) = (idx(&g, "  accept 7 only Paladin"), idx(&g, "  turnin 7 only Paladin"));
	assert!(a >= 0 && a < t, "{g:#?}");
	let head = g[..t as usize].iter().rev().find(|l| l.starts_with("step ")).unwrap();
	assert_eq!(head, "step Trainer", "{g:#?}");
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
				"guide t/a",
				"title A",
				"levels 12-15",
				"zone The Barrens",
				"",
				"step Crossroads",
				"  accept 1",
				"  accept 2",
				"  accept 4",
				"",
				"step Plainstriders",
				"  label plains",
				"  kill 44 quest 1.1",
				"",
				"step Raptors",
				"  label raptors",
				"  collect 69 quest 2.1",
				"  collect 70 quest 4.1 @50,50 only Orc",
				"",
				"step Grenda",
				"  collect 69 quest 2.1",
				"  turnin 4",
				"",
				"step Crossroads again",
				"  along until raptors",
				"  turnin 1",
				"  turnin 2",
				"",
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
				"guide t/a",
				"title A",
				"levels 12-15",
				"zone The Barrens",
				"",
				"step Crossroads",
				"  accept 1",
				"  accept 2",
				"  accept 3",
				"",
				"step Plainstriders",
				"  kill 44 quest 1.1",
				"",
				"step Champion on the way",
				"  along until back",
				"  kill 99 quest 3.1",
				"",
				"step Raptors",
				"  collect 69 quest 2.1",
				"",
				"step Crossroads again",
				"  label back",
				"  turnin 1",
				"  turnin 2",
				"  turnin 3",
				"",
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
			vec![
				"guide t/a",
				"title A",
				"levels 10-12",
				"zone Ironforge",
				"",
				"step Ironforge",
				"  train class",
				"",
				"step Kharanos",
				"  zone Dun Morogh",
				"  train class",
				"  accept 6064 only Hunter",
				"",
				"step Again",
				"  train class only Hunter,Mage",
				"  accept 2",
				"",
				"step Tram",
				"  accept 1",
				"",
			],
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
				"guide t/a",
				"title A",
				"levels 5-8",
				"zone Durotar",
				"",
				"step Sen'jin Village",
				"  accept 1",
				"",
				"# ---- Sen'jin and Razor Hill",
				"",
				"step Sen'jin Village",
				"  tip Follow the road east out of the valley to Sen'jin Village. Vel'rin stands by the huts.",
				"  accept 2",
				"",
				"step Camp",
				"  turnin 1",
				"  turnin 2",
				"",
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
				"guide t/a",
				"title A",
				"levels 20-25",
				"zone Ashenvale",
				"",
				"step Camp",
				"  accept 1",
				"",
				"step Brine",
				"  zone The Barrens",
				"  turnin 7 only Shaman",
				"",
				"step Alonso",
				"  goto 42.4,70 \"Alonso\"",
				"  turnin 1",
				"",
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
				"guide t/a",
				"title A",
				"levels 1-5",
				"zone Tirisfal Glades",
				"",
				"step Sarvis",
				"  accept 3901",
				"  accept 1470 only Warlock",
				"",
				"step Rattlecages",
				"  kill 1890 quest 3901.1",
				"  collect 6281 quest 1470.1 only Warlock",
				"",
				"step Venya",
				"  turnin 1470 only Warlock",
				"",
				"step Back",
				"  turnin 3901",
				"",
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
			(
				"shared",
				vec![
					"guide t/shared",
					"title Shared",
					"levels 55-60",
					"zone Silithus",
					"",
					"step Early",
					"  accept 2",
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
				"guide t/a",
				"title A",
				"levels 1-5",
				"zone Tirisfal Glades",
				"",
				"step Shadow Priest Sarvis",
				"  accept 364",
				"",
				"step Mindless Zombies",
				"  kill 1501 quest 364.1",
				"",
				"step Back to Sarvis",
				"  turnin 364",
				"",
				"step Aramis and Venya",
				"  only Paladin,Warlock",
				"  accept 1470 only Warlock",
				"",
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

#[test]
fn a_parent_taken_early_is_handed_in_after_the_quests_inside_it() {
	// c16 Alliance Stranglethorn: The Green Hills of Stranglethorn (338, optional, left out of the
	// route) taken early at Nesingwary's camp had its hand-in written right after its accept, before
	// the chapters (339, its `parent` 338) whose books it needs: not-ready on every start.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 30-40",
				"zone Tirisfal Glades",
				"",
				"step Nesingwary's camp",
				"  accept 364",
				"",
				"step Tigers",
				"  kill 1501 quest 364.1",
				"",
				"step Back to camp",
				"  turnin 364",
				"",
				"step Barnil",
				"  accept 338",
				"  accept 339",
				"",
				"step Pages",
				"  complete 339",
				"",
				"step Barnil again",
				"  turnin 339",
				"  turnin 338",
				"",
			],
		)],
		quests: json!({
			"364": { "title": "Tiger Mastery", "start": { "npc": [1569] }, "end": { "npc": [1569] }, "minLevel": 1 },
			"338": { "title": "The Green Hills of Stranglethorn", "start": { "npc": [5667] }, "end": { "npc": [5667] }, "minLevel": 1 },
			"339": { "title": "Chapter I", "start": { "npc": [5667] }, "end": { "npc": [5667] }, "minLevel": 1, "pre": [338], "parent": 338 }
		}),
		npcs: json!({
			"1569": { "name": "Ajeck Rouack", "spawns": { "1420": { "f": "e", "pts": [[30.84, 66.2]] } } },
			"5667": { "name": "Barnil Stonepot", "spawns": { "1420": { "f": "e", "pts": [[30.98, 66.41]] } } },
			"1501": { "name": "Stranglethorn Tiger", "spawns": { "1420": { "f": "e", "pts": [[35, 60], [36, 61], [35, 62]] } } }
		}),
		frames: json!({ "era": { "1420": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 364, "lvl": 30.0, "from": f("a", 7) }, { "t": "task", "q": 364, "task": 0, "lvl": 30.2, "from": f("a", 10) },
			{ "t": "turnin", "q": 364, "lvl": 30.8, "from": f("a", 13) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  accept 338") < idx(&g, "  accept 339") && idx(&g, "  turnin 339") < idx(&g, "  turnin 338"), "{g:#?}");
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
		&[
			"step The Undercity",
			"  only Warlock",
			"  zone Undercity",
			"  accept 1471 only Warlock",
			"  use 6284 @86.6,27.1 only Warlock",
			"  kill 5676 quest 1471.1 only Warlock",
			"  turnin 1471 only Warlock",
			"",
			"step Perrine's Chest",
			"  only Warlock",
			"  zone Tirisfal Glades",
			"  collect 6285 quest 1473.1",
			"",
			"step Back",
			"  only Warlock",
			"  zone Undercity",
			"  turnin 1473 only Warlock",
			"",
			"step Brill",
			"  accept 2",
			"",
		],
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
		&[
			"step Gan'rul",
			"  only Warlock",
			"  zone Orgrimmar",
			"  accept 1504",
			"  kill 5676 quest 1504.1",
			"  turnin 1504",
			"",
			"step Tablet of Verga",
			"  only Warlock",
			"  zone Durotar",
			"  collect 6535 quest 1501.1",
			"",
			"step The Binding",
			"  only Warlock",
			"  zone Orgrimmar",
			"  turnin 1501",
			"",
		],
		json!({ "1504": { "title": "The Binding", "pre": [1501] }, "1501": { "title": "Creature of the Void" } }),
	);
	assert!(idx(&g, "  turnin 1501") < idx(&g, "  accept 1504") && idx(&g, "  accept 1504") < idx(&g, "  turnin 1504"), "{g:#?}");
}

#[test]
fn call_of_fire_follow_ups_move_with_the_late_hand_in() {
	// c12w Troll Shaman: 1526, its ember, its hand-in and 1527's accept before 1525 is handed in.
	let g = class_chain(
		&[
			"step Telf Joolam",
			"  only Shaman",
			"  zone Durotar",
			"  accept 1526",
			"  collect 6655 quest 1526.1",
			"  turnin 1526",
			"  accept 1527",
			"",
			"step Fire Tar",
			"  only Shaman",
			"  zone The Barrens",
			"  collect 5026 quest 1525.1",
			"",
			"step Telf again",
			"  only Shaman",
			"  zone Durotar",
			"  turnin 1525",
			"",
			"step Kranal Fiss",
			"  only Shaman",
			"  zone The Barrens",
			"  turnin 1527",
			"",
		],
		json!({ "1525": { "title": "Call of Fire" }, "1526": { "title": "Call of Fire", "pre": [1525] }, "1527": { "title": "Call of Fire", "pre": [1526] } }),
	);
	let order: Vec<i64> = ["  turnin 1525", "  accept 1526", "  collect 6655 quest 1526.1", "  turnin 1526", "  accept 1527", "  turnin 1527"].iter().map(|l| idx(&g, l)).collect();
	assert!(order.windows(2).all(|w| w[0] < w[1]), "{order:?} {g:#?}");
}

#[test]
fn human_warlock_binding_waits_for_surena() {
	// c12w Human: The Binding (1689) before Surena Caledon (1688) is handed in.
	let g = class_chain(
		&[
			"step The Binding",
			"  only Warlock",
			"  zone Stormwind City",
			"  accept 1689",
			"  complete 1689",
			"  turnin 1689",
			"",
			"step Surena Caledon",
			"  only Warlock",
			"  zone Elwynn Forest",
			"  collect 6810 quest 1688.1",
			"",
			"step Gakin",
			"  only Warlock",
			"  zone Stormwind City",
			"  turnin 1688",
			"",
		],
		json!({ "1689": { "title": "The Binding", "pre": [1688] }, "1688": { "title": "Surena Caledon" } }),
	);
	assert!(idx(&g, "  turnin 1688") < idx(&g, "  accept 1689") && idx(&g, "  accept 1689") < idx(&g, "  complete 1689"), "{g:#?}");
}

#[test]
fn human_paladin_tome_follow_up_waits_and_keeps_its_map() {
	// c12w Westfall: 1787 taken before 1786 is handed in, and Henze's Symbol read on Stormwind's map.
	let g = class_chain(
		&[
			"step Henze Faulk",
			"  only Paladin",
			"  zone Elwynn Forest",
			"  accept 1787",
			"  use 6866 @72.6,51.4",
			"  turnin 1787",
			"",
			"step Stormwind",
			"  only Paladin",
			"  zone Stormwind City",
			"  turnin 1786",
			"",
			"step Westfall",
			"  zone Westfall",
			"  accept 2",
			"",
		],
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
		"guide t/a",
		"title A",
		"levels 1-10",
		"zone Tirisfal Glades",
		"",
		"step Gordo",
		"  accept 5481",
		"",
		"step Brill",
		"  turnin 5481                         -- Junior Apothecary Holland",
		"  accept 5482",
		"  turnin 383                          -- Executor Zygand",
		"  accept 427",
		"",
		"step Discipline",
		"  goto 60.6,52.0 \"Brill\"",
		"  complete 99134",
		"",
		"step Brill",
		"  accept 404                          -- Deathguard Dillinger",
		"",
		"step The fields",
		"  kill 1535 quest 427.1",
		"",
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
fn a_hub_line_that_carries_the_way_back_joins_the_earlier_visit() {
	// c15 Night Elf dup-trip: Auberdine's accepts went to the visit before the flight to Nessa, but
	// Thundris' (the event carrying the flight back) stayed after it: a trip back for one accept.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-12",
				"zone Durotar",
				"",
				"step Town",
				"  accept 1",
				"  accept 5",
				"",
				"step Nessa",
				"  turnin 2",
				"",
				"step Thundris",
				"  accept 3",
				"",
				"step Beach",
				"  accept 4",
				"",
			],
		)],
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 11.0, "from": f("a", 7) },
			{ "t": "accept", "q": 5, "pt": 3, "lvl": 11.0, "from": f("a", 8) },
			{ "t": "turnin", "q": 2, "pt": 1, "lvl": 11.0, "from": f("a", 11), "items": [{ "t": "network", "from": 3, "to": 1, "legs": [{ "k": "walk", "to": 1 }] }] },
			{ "t": "accept", "q": 3, "pt": 4, "lvl": 11.0, "from": f("a", 14), "items": [{ "t": "network", "from": 1, "to": 4, "legs": [{ "k": "walk", "to": 4 }] }] },
			{ "t": "accept", "q": 4, "pt": 2, "lvl": 11.0, "from": f("a", 17) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 3000, 0, 1411], [1, 1, 0, 400, 1411], [1, 1, 30, 0, 1411], [1, 1, 60, 10, 1411]], "zones": { "1411": "Durotar" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 1, "ender": 1 }, { "id": 3, "giver": 4, "ender": 4 }, { "id": 4, "giver": 2, "ender": 2 }, { "id": 5, "giver": 3, "ender": 3 }] }),
		quests: json!({ "1": { "title": "One", "minLevel": 7, "level": 12 }, "2": { "title": "Two", "minLevel": 7, "level": 12 }, "3": { "title": "Three", "minLevel": 7, "level": 12 }, "4": { "title": "Four", "minLevel": 7, "level": 12 }, "5": { "title": "Five", "minLevel": 7, "level": 12 } }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  accept 3") < idx(&g, "  turnin 2") && idx(&g, "  accept 3") >= 0, "{g:#?}");
}

#[test]
fn a_hub_return_ready_before_a_trip_goes_before_it() {
	// c18 Horde Stranglethorn dup-trip: the Elder Tigers south of Nesingwary's camp, on to Nimboya at
	// Grom'gol, then back north to the camp for Ajeck Rouack's hand-in, ready before Grom'gol.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 33-35",
				"zone Durotar",
				"",
				"step Camp",
				"  accept 1",
				"  accept 2",
				"",
				"step Tigers",
				"  complete 1",
				"",
				"step Grom",
				"  turnin 2",
				"",
				"step Camp",
				"  turnin 1",
				"",
				"step Coast",
				"  accept 3",
				"",
			],
		)],
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 34.0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 0, "lvl": 34.0, "from": f("a", 8) },
			{ "t": "task", "q": 1, "task": 0, "pt": 1, "lvl": 34.0, "from": f("a", 11) },
			{ "t": "turnin", "q": 2, "pt": 2, "lvl": 34.1, "from": f("a", 14) },
			{ "t": "turnin", "q": 1, "pt": 0, "lvl": 34.1, "from": f("a", 17) },
			{ "t": "accept", "q": 3, "pt": 3, "lvl": 34.2, "from": f("a", 20) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, -360, 0, 1411], [1, 1, -780, 200, 1411], [1, 1, 0, 780, 1411]], "zones": { "1411": "Durotar" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0, "tasks": [{ "pt": 1 }] }, { "id": 2, "giver": 0, "ender": 2 }, { "id": 3, "giver": 3, "ender": 3 }] }),
		quests: json!({ "1": { "title": "One", "minLevel": 30, "level": 34 }, "2": { "title": "Two", "minLevel": 30, "level": 34 }, "3": { "title": "Three", "minLevel": 30, "level": 34 } }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  complete 1") < idx(&g, "  turnin 1") && idx(&g, "  turnin 1") < idx(&g, "  turnin 2"), "{g:#?}");
}

#[test]
fn a_hub_visit_only_other_starts_make_takes_no_hand_in_of_everyones() {
	// c17 02-westfall:236: Scout Galiaan's hand-in went to the Sentinel Hill stop for Alba's vials,
	// which the Humans (the canonical start) do not take: the Humans walked back to the hill for it.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-12",
				"zone Durotar",
				"",
				"step Town",
				"  accept 1",
				"",
				"step Field",
				"  complete 1",
				"",
				"step Town",
				"  accept 9",
				"",
				"step Far",
				"  accept 5",
				"",
				"step Town",
				"  turnin 1",
				"",
			],
		)],
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 11.0, "from": f("a", 7) },
			{ "t": "task", "q": 1, "task": 0, "pt": 1, "lvl": 11.0, "from": f("a", 10) },
			{ "t": "accept", "q": 9, "pt": 0, "lvl": 11.0, "from": f("a", 13), "extra": true },
			{ "t": "accept", "q": 5, "pt": 2, "lvl": 11.0, "from": f("a", 16) },
			{ "t": "turnin", "q": 1, "pt": 0, "lvl": 11.0, "from": f("a", 19) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 3000, 0, 1411], [1, 1, 0, 3000, 1411]], "zones": { "1411": "Durotar" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0, "tasks": [{ "pt": 1 }] }, { "id": 9, "giver": 0, "ender": 0 }, { "id": 5, "giver": 2, "ender": 2 }] }),
		quests: json!({ "1": { "title": "One", "minLevel": 7, "level": 12 }, "9": { "title": "Nine", "minLevel": 7, "level": 12 }, "5": { "title": "Five", "minLevel": 7, "level": 12 } }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  turnin 1") > idx(&g, "  accept 5") && idx(&g, "  accept 5") >= 0, "{g:#?}");
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
				"guide t/a",
				"title A",
				"levels 3-8",
				"zone Durotar",
				"",
				"step Deathknell",
				"  accept 2",
				"",
				"step Calvin Montague",
				"  tip Walk on west to the farm. Deathguard Simmer stands at the farm; Calvin, by the farmhouse, wants a duel: talk to him.",
				"  accept 1",
				"  accept 3",
				"  turnin 3",
				"",
				"step Brill",
				"  turnin 2",
				"  turnin 1",
				"",
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
	let a = vec![
		"guide t/a",
		"title A",
		"levels 1-5",
		"zone Tirisfal Glades",
		"",
		"step SE",
		"  accept 4",
		"",
		"step NE",
		"  accept 3",
		"",
		"step NW",
		"  accept 2",
		"",
		"step SW",
		"  accept 1",
		"",
		"step Road",
		"  kill 9 quest 1.1",
		"",
	];
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
				"guide t/a",
				"title A",
				"levels 5-8",
				"zone The Barrens",
				"",
				"step Brill",
				"  accept 1",
				"  accept 2",
				"  accept 3",
				"",
				"step Fields",
				"  tip Far Raptors roam the east.",
				"  tip Plainstriders graze by town.",
				"  collect 69 quest 3.1",
				"  kill 44 quest 1.1",
				"  kill 45 quest 2.1",
				"",
				"step Brill again",
				"  turnin 1",
				"  turnin 2",
				"  turnin 3",
				"",
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
		"step A",
		"  accept 1 only Dwarf,Gnome,NightElf,Skyborne",
		"",
		"step B",
		"  collect 5 quest 1.1",
		"  kill 6 quest 1.2 only Dwarf,Gnome,Skyborne",
		"",
		"step C",
		"  only NightElf,Druid",
		"  accept 2",
		"",
		"step D",
		"  turnin 2 only NightElf,Skyborne",
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
		"guide t/a",
		"title A",
		"levels 1-5",
		"zone Tirisfal Glades",
		"",
		"step One",
		"  accept 1",
		"",
		"step Islen",
		"  only Shaman",
		"  accept 9",
		"",
		"step Two",
		"  accept 2",
		"",
		"step Three",
		"  accept 3",
		"",
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
		"guide t/a",
		"title A",
		"levels 1-5",
		"zone Tirisfal Glades",
		"",
		"step One",
		"  accept 1",
		"",
		"step Crates",
		"  accept 8",
		"",
		"step Two",
		"  accept 2",
		"",
		"step Three",
		"  accept 3",
		"",
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
	let a = vec!["guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "", "step One", "  accept 1", "", "step Two", "  accept 2", "", "step Three", "  accept 3", ""];
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
	let a = vec!["guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "", "step Jarl", "  accept 1", "  buy 50 x1", "  turnin 1", ""];
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
	let buy = g.iter().position(|l| l.starts_with("  buy 50")).expect("buy written");
	assert_eq!(g.iter().filter(|l| l.starts_with("  buy 50")).count(), 1, "{g:#?}");
	let title = g[..buy].iter().rev().find(|l| l.starts_with("step ")).unwrap();
	assert_ne!(title, "step Jarl", "{g:#?}");
	assert!((buy as i64) < idx(&g, "  turnin 1"), "{g:#?}");
}

#[test]
fn an_item_bought_from_a_vendor_the_route_just_visited_is_bought_in_that_visit() {
	// c17 Desolace: the Southshore Stout (v1's `buy ... npc` in the Tarren Mill step) was written after the
	// Syndicate camp and an Undercity trip, back at the vendor, because the world puts the item's task
	// by Valik. The vendor stands at the route's Tarren Mill visit: bought there.
	let a = vec![
		"guide t/a",
		"title A",
		"levels 1-5",
		"zone Tirisfal Glades",
		"",
		"step Tarren Mill",
		"  accept 2",
		"  buy 50 x1 npc 9",
		"",
		"step Camp",
		"  accept 1",
		"",
		"step Valik",
		"  turnin 1",
		"",
	];
	let c = Case {
		files: vec![("a", a)],
		world: json!({
			"points": [[0, 0, 0, 0, 1420], [0, 0, 600, 600, 1420]],
			"zones": { "1420": "Tirisfal Glades" },
			"quests": [{ "id": 1, "giver": 1, "ender": 1, "tasks": [{ "pt": 1 }] }, { "id": 2, "giver": 0, "ender": 0 }]
		}),
		quests: json!({ "1": { "title": "Stout", "minLevel": 1, "objectives": [{ "type": "item", "id": 50 }] }, "2": { "title": "Two" } }),
		npcs: json!({ "9": { "name": "Innkeeper", "faction": "H", "spawns": { "1420": { "f": "e", "pts": [[50, 50]] } } } }),
		frames: json!({ "era": { "1420": { "top": 1000, "bottom": -1000, "left": 1000, "right": -1000, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 2, "pt": 0, "lvl": 1.0, "from": f("a", 7) },
			{ "t": "accept", "q": 1, "pt": 1, "lvl": 1.0, "from": f("a", 11) },
			{ "t": "task", "q": 1, "task": 0, "pt": 1, "lvl": 1.0, "from": f("a", 14) },
			{ "t": "turnin", "q": 1, "pt": 1, "lvl": 1.0, "from": f("a", 14) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let buy = g.iter().position(|l| l.starts_with("  buy 50")).unwrap_or_else(|| panic!("{g:#?}")) as i64;
	assert!(buy < idx(&g, "  accept 1"), "{g:#?}");
}

#[test]
fn a_training_stop_where_the_route_stands_reads_the_zone_the_step_before_named() {
	// c17 Tauren: Thunder Bluff's Shaman stop lies on Mulgore's map at the foot of the mesa; the stop,
	// after Eylah's step in Thunder Bluff, said `zone Mulgore`.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 10-13", "zone Mulgore", "", "step Eylah", "  zone Thunder Bluff", "  turnin 1", "", "step Away", "  zone Mulgore", "  accept 2", ""])],
		world: json!({ "points": [[0, 0, 0, 0, 1456], [0, 0, 40, 0, 1412], [0, 0, 900, 900, 1412]], "zones": { "1412": "Mulgore", "1456": "Thunder Bluff" }, "quests": [] }),
		frames: json!({ "era": { "1412": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1456": { "top": 500, "bottom": -500, "left": -500, "right": 500, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Tauren", "diff": {}, "order": [
			{ "t": "turnin", "q": 1, "lvl": 12.0, "pt": 0, "from": f("a", 8) },
			{ "t": "train", "lvl": 12.02, "pt": 1, "from": "train stop" },
			{ "t": "accept", "q": 2, "lvl": 12.5, "pt": 2, "from": f("a", 12) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let s = idx(&g, "step Class trainer");
	assert!(s >= 0 && !g[s as usize..].iter().take_while(|l| !l.is_empty()).any(|l| l == "  zone Mulgore"), "{g:#?}");
}

#[test]
fn the_routes_buy_item_is_written_at_its_stop_and_the_task_makes_no_trip() {
	// Rev15H2 (25): the planner buys Jarl's spices at the Orgrimmar training stop (its `buy` item); the
	// writer ignored the item and still sent the player from the quest's task to a vendor and back.
	let a = vec!["guide t/a", "title A", "levels 1-5", "zone Tirisfal Glades", "", "step Jarl", "  accept 1", "  buy 50 x1", "  turnin 1", "", "step Stop", "  zone The Barrens", "  accept 2", ""];
	let c = Case {
		files: vec![("a", a)],
		world: json!({
			"points": [[0, 0, 0, 0, 1420], [0, 0, 900, 900, 1421], [0, 0, 1500, 1500, 1421]],
			"zones": { "1420": "Tirisfal Glades", "1421": "The Barrens" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0, "tasks": [{ "pt": 1 }] }, { "id": 2, "giver": 2, "ender": 2 }]
		}),
		quests: json!({ "1": { "title": "Spices", "minLevel": 1, "objectives": [{ "type": "item", "id": 50 }] }, "2": { "title": "Two" } }),
		frames: json!({ "era": { "1420": { "top": 1000, "bottom": -1000, "left": 1000, "right": -1000, "c": 0 }, "1421": { "top": 2000, "bottom": 0, "left": 2000, "right": 0, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 1.0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 2, "lvl": 1.0, "from": f("a", 13), "items": [{ "t": "buy", "q": 1, "task": 0, "pt": 2 }] },
			{ "t": "task", "q": 1, "task": 0, "pt": 1, "lvl": 1.0, "from": f("a", 9) },
			{ "t": "turnin", "q": 1, "pt": 0, "lvl": 1.0, "from": f("a", 9) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let buys: Vec<usize> = g.iter().enumerate().filter(|(_, l)| l.starts_with("  buy 50")).map(|(i, _)| i).collect();
	assert!(!buys.is_empty() && (buys[0] as i64) > idx(&g, "  accept 2") && (buys[0] as i64) < idx(&g, "  turnin 1"), "{g:#?}");
	// No vendor trip of the task's own: the other buy line is v1's, asked for again in Jarl's step.
	let title = |i: usize| g[..i].iter().rev().find(|l| l.starts_with("step ")).cloned().unwrap();
	assert_eq!(buys.len(), 2, "{g:#?}");
	assert_eq!(title(buys[1]), "step Jarl", "{g:#?}");
}

#[test]
fn a_task_keyed_to_its_hand_in_line_writes_no_turn_in_ahead_of_the_routes() {
	// Rev15 dup-trip (Un'Goro, Lost!): the task of finding Ringo is keyed to the hand-in line; the hand-in
	// was written at the task, ahead of the Marshal's Refuge work the route does first, then back to Ringo.
	let a = vec!["guide t/a", "title A", "levels 1-5", "zone Durotar", "", "step Refuge", "  accept 1", "  accept 2", "", "step Ringo", "  turnin 1", "", "step Camp", "  turnin 2", ""];
	let c = Case {
		files: vec![("a", a)],
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 900, 900, 1411], [1, 1, -900, -900, 1411]], "zones": { "1411": "Durotar" },
			"quests": [{ "id": 1, "giver": 0, "ender": 1 }, { "id": 2, "giver": 0, "ender": 2 }] }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 0, "from": f("a", 8) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "from": f("a", 11) },
			{ "t": "turnin", "q": 2, "pt": 2, "from": f("a", 14) },
			{ "t": "turnin", "q": 1, "pt": 1, "from": f("a", 11) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "  turnin 1") > idx(&g, "  turnin 2") && idx(&g, "  turnin 2") >= 0, "{g:#?}");
}

#[test]
fn a_class_step_after_v1s_replaced_travel_goes_after_the_town_visit() {
	// c15 Horde (03-arathi, Shady Rest): v1's way from Arathi (hearth, zeppelin, the Crossroads) then
	// the Warriors' Affray, between the route's 1269/1268 and 1251 at the inn: the Warriors left and
	// everyone walked back for 1251.
	let c = Case {
		files: vec![
			(
				"t/a",
				vec![
					"guide forever/t/a",
					"title A",
					"levels 30-35",
					"zone Durotar",
					"next forever/t/b",
					"",
					"step Start",
					"  accept 9",
					"",
					"step Hearth to Razor Hill",
					"  hearth \"Razor Hill\"",
					"",
					"step The Affray",
					"  only Warrior",
					"  zone The Barrens",
					"  turnin 9",
					"",
				],
			),
			("t/b", vec!["guide forever/t/b", "title B", "levels 30-35", "zone Durotar", "", "step Inn", "  accept 3", "  accept 1", "  accept 2", ""]),
		],
		world: json!({
			"points": [[1, 1, 0, 0, 1411], [1, 1, 500, 500, 1413], [1, 1, -500, -500, 1411]],
			"zones": { "1411": "Durotar", "1413": "The Barrens" },
			"quests": [{ "id": 9, "giver": 0, "ender": 1 }, { "id": 1, "giver": 2, "ender": 2 }, { "id": 2, "giver": 2, "ender": 2 }, { "id": 3, "giver": 2, "ender": 2 }],
			"nodes": [{ "kind": "fp", "name": "Razor Hill", "pt": 0 }, { "kind": "fp", "name": "Crossroads", "pt": 1 }],
			"inns": [{ "name": "Razor Hill", "pt": 0 }]
		}),
		frames: two_zone_frames(),
		quests: json!({ "9": { "title": "The Islander", "classes": 1 } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 9, "pt": 0, "from": f("t/a", 8) },
			{ "t": "accept", "q": 1, "pt": 2, "from": f("t/b", 8), "items": [{ "t": "network", "from": 0, "to": 2, "legs": [{ "k": "walk", "to": 2 }] }] },
			{ "t": "accept", "q": 2, "pt": 2, "from": f("t/b", 9) },
			{ "t": "accept", "q": 3, "pt": 2, "from": f("t/b", 7) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let r = run(&c, None);
	let all: Vec<String> = [r.read("t/a"), r.read("t/b")].concat();
	let (affray, last) = (idx(&all, "  turnin 9"), idx(&all, "  accept 3"));
	assert!(affray > last && last >= 0, "{all:#?}");
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
				"guide t/a",
				"title A",
				"levels 5-8",
				"zone The Barrens",
				"",
				"step Brill",
				"  accept 1",
				"  accept 2",
				"",
				"step Fields",
				"  kill 44 quest 1.1",
				"  kill 45 quest 2.1",
				"  accept 4",
				"  collect 70 quest 4.1",
				"",
				"step Brill again",
				"  turnin 1",
				"  turnin 2",
				"  turnin 4",
				"",
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
	for (_, e) in c.npcs.as_object_mut().unwrap() {
		e["spawns"]["1413"]["f"] = json!("l");
	}
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
				"guide t/a",
				"title A",
				"levels 5-8",
				"zone The Barrens",
				"",
				"step Brill",
				"  accept 1",
				"  accept 2",
				"",
				"step Fields",
				"  kill 44 quest 1",
				"  kill 45 quest 2",
				"",
				"step Brill again",
				"  turnin 1",
				"  turnin 2",
				"",
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
				"guide t/a",
				"title A",
				"levels 5-8",
				"zone Mulgore",
				"",
				"step Maur",
				"  accept 1",
				"",
				"step The well",
				"  kill 44 quest 1.1 optional",
				"  kill 45 quest 2.1",
				"",
				"step Finish the parts",
				"  kill 44 quest 1.1                  -- Prairie Wolf",
				"",
				"step Maur again",
				"  turnin 1",
				"  turnin 2",
				"",
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
				"guide t/a",
				"title A",
				"levels 18-26",
				"zone Darkshore",
				"",
				"step The Grove",
				"  accept 1",
				"",
				"step Kerlonian",
				"  collect 50 quest 1.1",
				"  note Escort Kerlonian to Maestra's Post.",
				"",
				"step Far away",
				"  accept 2",
				"  turnin 2",
				"",
				"step Auberdine",
				"  accept 3",
				"",
				"step Maestra's Post",
				"  turnin 1",
				"  turnin 3",
				"",
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
				"guide t/a",
				"title A",
				"levels 18-20",
				"zone Darkshore",
				"",
				"step Auberdine first",
				"  accept 2",
				"",
				"step Field",
				"  kill 44 quest 2.1",
				"",
				"step Auberdine",
				"  turnin 2",
				"  accept 3",
				"  vendor nearest",
				"  goto 30.76,40.92 \"Boat to Stormwind\"",
				"",
				"step Stormwind",
				"  turnin 3",
				"",
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
		files: vec![("a", vec!["guide t/a", "title A", "levels 8-14", "zone Durotar", "", "step Razor Hill", "  accept 1", "", "step Sen'jin", "  turnin 1", "", "step Later", "  accept 2", ""])],
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
fn a_class_trained_at_the_last_stop_gets_no_trip_from_a_town_without_its_trainer() {
	// c17 Ashenvale: at the Thunder Bluff stop (28.7) the Rogues and Warlocks, trained in Orgrimmar at
	// 26.8, were sent to their trainers in Durotar (the next Orgrimmar stop at 33, over four levels after
	// their last). Two levels after their last training: no line.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 26-33",
				"zone Durotar",
				"",
				"step Mage town",
				"  zone Durotar",
				"  accept 1",
				"",
				"step Bluff",
				"  zone Mulgore",
				"  turnin 1",
				"",
				"step Later",
				"  accept 2",
				"",
				"step Back",
				"  zone Durotar",
				"  turnin 2",
				"",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1411], [0, 0, 0, 2000, 1412], [0, 0, 600, 2000, 1412]], "zones": { "1411": "Durotar", "1412": "Mulgore" }, "quests": [] }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1412": { "top": 1000, "bottom": -1000, "left": 1000, "right": 3000, "c": 0 } } }),
		npcs: json!({
			"3173": { "name": "Swart", "subName": "Shaman Trainer", "faction": "H", "spawns": { "1412": { "f": "e", "pts": [[50, 50]] } } },
			"5880": { "name": "Un'Thuwa", "subName": "Mage Trainer", "faction": "H", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } }
		}),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 26.8, "pt": 0, "from": f("a", 8) },
			{ "t": "train", "lvl": 26.8, "pt": 0, "from": "train stop" },
			{ "t": "turnin", "q": 1, "lvl": 28.6, "pt": 2, "from": f("a", 12) },
			{ "t": "train", "lvl": 28.7, "pt": 1, "from": "train stop" },
			{ "t": "accept", "q": 2, "lvl": 30.0, "pt": 1, "from": f("a", 15) },
			{ "t": "turnin", "q": 2, "lvl": 33.0, "pt": 0, "from": f("a", 19) },
			{ "t": "train", "lvl": 33.0, "pt": 0, "from": "train stop" }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (t1, t2) = (idx(&g, "  turnin 1"), idx(&g, "  turnin 2"));
	assert!(t1 >= 0 && t2 > t1 && !g[t1 as usize..t2 as usize].iter().any(|l| m(l, r"^\s+train class only Mage")), "{g:#?}");
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
				"guide t/a",
				"title A",
				"levels 48-52",
				"zone Un'Goro Crater",
				"",
				"step Marshal's Refuge",
				"  accept 1",
				"  level 50",
				"",
				"step Grind to 51",
				"  tip Grind the Wastewander nomads east of Gadgetzan.",
				"  level 51",
				"",
				"step Dire Maul",
				"  note Dire Maul East is a good place for the last levels.",
				"  level 59",
				"",
				"step Ironstone Plateau",
				"  turnin 1",
				"",
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
				"guide t/a",
				"title A",
				"levels 40-45",
				"zone The Hinterlands",
				"",
				"step Rhapsody Shindigger",
				"  turnin 1",
				"  note Rhapsody's cocktail needs parts from Kalimdor: skip it.",
				"  accept 2",
				"  note Garek's next task is an elite hunt: skip it.",
				"",
				"step The beaches",
				"  tip Turtles crawl here. Whiskey Slim's bottles lie on these beaches too, but his quest is not on this route.",
				"  kill 44 quest 2.1",
				"",
				"step Booty Bay",
				"  accept 3",
				"  turnin 2",
				"  turnin 3",
				"",
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
fn a_bare_skip_it_after_the_sentence_naming_the_routes_quest_goes_with_it() {
	// c18 Orc 07-felwood: "Trull's next Wild Guardians would bring you back here from Winterspring.
	// Skip it." right above the route's accept of Wild Guardians; the bare "Skip it." names the quest
	// only with the sentence before. Rabine's note about a quest the route leaves out stays, and so does
	// Chromie's about her Battle of Darrowshire beside the route's accept of her A Matter of Time.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 55-60",
				"zone Felwood",
				"",
				"step Trull Failbane",
				"  turnin 1",
				"  note Trull's next Wild Guardians would bring you back here from Winterspring. Skip it.",
				"  accept 2",
				"",
				"step Rabine Saturna",
				"  turnin 3",
				"  note Rabine's Shards of the Felvine needs Dire Maul. Skip it.",
				"",
				"step Chromie",
				"  accept 5",
				"  note Chromie's Battle of Darrowshire ends against elites. Skip it.",
				"",
				"step Owlbeasts",
				"  kill 44 quest 2.1",
				"",
				"step Trull again",
				"  turnin 2",
				"",
			],
		)],
		quests: json!({
			"1": { "title": "Wild Guardians", "start": { "npc": [10] } }, "2": { "title": "Wild Guardians", "start": { "npc": [10] } },
			"3": { "title": "Uncovering Past Secrets" }, "4": { "title": "Shards of the Felvine", "start": { "npc": [13] } },
			"5": { "title": "A Matter of Time", "start": { "npc": [14] } }, "6": { "title": "The Battle of Darrowshire", "start": { "npc": [14] } }
		}),
		npcs: json!({ "10": { "name": "Trull Failbane" }, "13": { "name": "Rabine Saturna" }, "14": { "name": "Chromie" } }),
		route: json!({ "diff": {}, "order": [
			{ "t": "turnin", "q": 1, "from": f("a", 7) }, { "t": "accept", "q": 2, "from": f("a", 9) }, { "t": "turnin", "q": 3, "from": f("a", 12) },
			{ "t": "accept", "q": 5, "from": f("a", 16) }, { "t": "task", "q": 2, "task": 0, "from": f("a", 20) }, { "t": "turnin", "q": 2, "from": f("a", 23) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l.contains("Trull's next")), "{g:#?}");
	assert!(has(&g, "  note Rabine's Shards of the Felvine needs Dire Maul. Skip it."), "{g:#?}");
	assert!(has(&g, "  note Chromie's Battle of Darrowshire ends against elites. Skip it."), "{g:#?}");
}

#[test]
fn a_route_event_with_two_objective_lines_travels_once() {
	// c13 Arathi (F5): The Hammer May Fall's one task, two objective lines (the ogres, Boulder'gor):
	// the way there (zeppelin, Undercity, flight) was written before each.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 30-40",
				"zone Durotar",
				"",
				"step Hammerfall",
				"  accept 1",
				"",
				"step Boulderfist camp",
				"  kill 44 quest 1.1",
				"  kill 45 quest 1.2",
				"",
				"step Hammerfall again",
				"  turnin 1",
				"",
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
			vec![
				"guide t/a",
				"title A",
				"levels 15-20",
				"zone Durotar",
				"",
				"step Orgrimmar",
				"  accept 1",
				"  accept 2",
				"",
				"step The Crossroads",
				"  turnin 1",
				"  fly \"Crossroads\"",
				"  turnin 2",
				"",
			],
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
			vec![
				"guide t/a",
				"title A",
				"levels 9-13",
				"zone Durotar",
				"",
				"step Razor Hill",
				"  accept 1",
				"  accept 7 only Warrior",
				"",
				"step Camp",
				"  turnin 1",
				"",
				"step Later",
				"  accept 2",
				"",
				"step Orgrimmar",
				"  turnin 7 only Warrior",
				"  turnin 2",
				"",
			],
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
				"guide t/a",
				"title A",
				"levels 3-8",
				"zone Durotar",
				"",
				"step Deathknell",
				"  accept 2",
				"",
				"step Calvin Montague",
				"  tip Walk on west to the farm.",
				"  tip Deathguard Simmer stands at the farm; the farmhouse is by the road.",
				"  accept 3",
				"  accept 1",
				"",
				"step Brill",
				"  turnin 2",
				"  turnin 1",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 2, "pt": 2, "from": f("a", 7) }, { "t": "accept", "q": 3, "pt": 1, "from": f("a", 12) }, { "t": "turnin", "q": 2, "pt": 3, "from": f("a", 16) },
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 13) }, { "t": "turnin", "q": 1, "pt": 4, "from": f("a", 17) }
		] }),
		quests: json!({
			"1": { "title": "Fields of Grief", "start": { "npc": [10] }, "end": { "npc": [30] } },
			"2": { "title": "A Rogue's Deal", "start": { "npc": [40] }, "end": { "npc": [30] } },
			"3": { "title": "Duel", "start": { "npc": [20] }, "end": { "npc": [20] } }
		}),
		npcs: json!({ "10": { "name": "Deathguard Simmer" }, "20": { "name": "Calvin Montague" }, "30": { "name": "Innkeeper Renee" }, "40": { "name": "Novice Elreth" } }),
		// (Fields of Grief handed in elsewhere than A Rogue's Deal: no stop back at Brill to fold.)
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 150, 0, 1411], [1, 1, 900, 900, 1411], [1, 1, -900, 900, 1411], [1, 1, -900, -900, 1411]], "zones": { "1411": "Durotar" }, "quests": [{ "id": 1, "giver": 0, "ender": 4 }, { "id": 2, "giver": 2, "ender": 3 }, { "id": 3, "giver": 1, "ender": 1 }] }),
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
				"guide t/a",
				"title A",
				"levels 1-5",
				"zone Durotar",
				"",
				"step Hub",
				"  accept 1",
				"",
				"step Totem",
				"  only Shaman",
				"  fly \"Orgrimmar\"",
				"  turnin 7",
				"",
				"step Camp",
				"  turnin 1",
				"",
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
				"guide t/a",
				"title A",
				"levels 5-8",
				"zone Elwynn Forest",
				"",
				"step Eagan Peltskinner",
				"  accept 1",
				"  accept 2",
				"",
				"step Marshal",
				"  turnin 3",
				"",
				"step Eagan again",
				"  turnin 1",
				"  turnin 2",
				"",
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
				"guide t/a",
				"title A",
				"levels 5-8",
				"zone The Barrens",
				"",
				"step Elder",
				"  accept 3",
				"",
				"step Hunts",
				"  accept 1",
				"  kill 44 quest 1.1",
				"  turnin 1",
				"  accept 2",
				"  kill 45 quest 2.1",
				"  turnin 2",
				"",
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
		"guide t/a",
		"title A",
		"levels 1-5",
		"zone Tirisfal Glades",
		"",
		"step One",
		"  accept 1",
		"",
		"step Collector",
		"  zone Silverpine Forest",
		"  accept 8 optional",
		"",
		"step Back",
		"  zone Tirisfal Glades",
		"  accept 3",
		"",
		"step Two",
		"  accept 2",
		"",
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
	let dark = vec![
		"guide forever/t/darkshore",
		"title D",
		"levels 10-15",
		"zone Darkshore",
		"next forever/t/redridge",
		"",
		"step Auberdine",
		"  accept 954",
		"  accept 958",
		"",
		"step Beach",
		"  turnin 954",
		"  turnin 958",
		"",
	];
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
		"guide t/a",
		"title A",
		"levels 1-12",
		"zone Dun Morogh",
		"",
		"step Kharanos",
		"  accept 1",
		"",
		"step Honor Students",
		"  only Paladin",
		"  accept 8",
		"  fly \"Ironforge\"",
		"",
		"step Class quests",
		"  only Paladin",
		"  zone Ironforge",
		"  accept 9",
		"",
		"step Ironforge",
		"  zone Ironforge",
		"  accept 2",
		"",
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
		"guide t/a",
		"title A",
		"levels 1-5",
		"zone Tirisfal Glades",
		"",
		"step Faranell",
		"  accept 1",
		"",
		"step Aelthalyste",
		"  only Priest",
		"  accept 9",
		"",
		"step Faranell again",
		"  accept 3",
		"",
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

#[test]
fn a_training_stops_way_goes_before_v1s_training_not_after_it() {
	// c14 04-dustwallow: v1's Orgrimmar training steps took the route's training stop, and its flight
	// and zeppelin from Kargath went with the next event, after the training: written for everyone
	// again once the classes had trained.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 38-40",
				"zone Badlands",
				"",
				"step Kargath",
				"  accept 1",
				"",
				"step Trainers",
				"  zone Orgrimmar",
				"  only Warrior,Rogue",
				"  train class",
				"",
				"step Crossroads",
				"  zone The Barrens",
				"  accept 2",
				"",
			],
		)],
		world: json!({ "points": [[1, 1, 0, 0, 1418], [1, 1, 9000, 9000, 1454], [1, 1, 9500, 8000, 1413]], "zones": { "1418": "Badlands", "1454": "Orgrimmar", "1413": "The Barrens" }, "quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 2, "ender": 2 }] }),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 38.0, "from": f("a", 7) },
			{ "t": "train", "pt": 1, "lvl": 38.1, "from": "train stop", "items": [{ "t": "network", "from": 0, "to": 1 }] },
			{ "t": "accept", "q": 2, "pt": 2, "lvl": 38.2, "from": f("a", 16), "items": [{ "t": "network", "from": 1, "to": 2 }] }
		] }),
		frames: json!({ "era": { "1418": { "top": 20000, "bottom": -20000, "left": -20000, "right": 20000, "c": 1 }, "1454": { "top": 20000, "bottom": -20000, "left": -20000, "right": 20000, "c": 1 }, "1413": { "top": 20000, "bottom": -20000, "left": -20000, "right": 20000, "c": 1 } } }),
		route_travel: true,
		..Case::default()
	};
	let g = pick(&run(&c, None).read("a"), r"^step|^\s+(goto|fly|train|accept)");
	let t = idx(&g, "step Trainers");
	let way = g.iter().position(|l| l.contains("\"Orgrimmar\"")).map_or(-1, |i| i as i64);
	assert!(way >= 0 && way < t, "{g:#?}");
}

#[test]
fn a_training_stop_before_an_added_quest_elsewhere_trains_there_not_after_it() {
	// c19p Horde 30-40/03-arathi-highlands:410: the route trained in Orgrimmar off the zeppelin, then
	// flew to the Crossroads for Korran (added); v1's Orgrimmar training steps, before its Regthar step,
	// took the stop, so the guide flew to the Crossroads, back to Orgrimmar to train, and to the
	// Crossroads again.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 38-40",
				"zone Badlands",
				"",
				"step Kargath",
				"  accept 1",
				"",
				"step Trainers",
				"  zone Orgrimmar",
				"  only Warrior,Rogue",
				"  train class",
				"",
				"step Crossroads",
				"  zone The Barrens",
				"  accept 2",
				"",
			],
		)],
		world: json!({ "points": [[1, 1, 0, 0, 1418], [1, 1, 9000, 9000, 1454], [1, 1, 9500, 8000, 1413]], "zones": { "1418": "Badlands", "1454": "Orgrimmar", "1413": "The Barrens" }, "quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 2, "ender": 2 }, { "id": 3, "giver": 2, "ender": 2 }] }),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 }, "3": { "title": "Three", "minLevel": 1 } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": { "added": [3] }, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 38.0, "from": f("a", 7) },
			{ "t": "train", "pt": 1, "lvl": 38.1, "from": "train stop", "items": [{ "t": "network", "from": 0, "to": 1 }] },
			{ "t": "accept", "q": 3, "pt": 2, "lvl": 38.1, "from": "inserted", "items": [{ "t": "network", "from": 1, "to": 2 }] },
			{ "t": "accept", "q": 2, "pt": 2, "lvl": 38.2, "from": f("a", 16) }
		] }),
		frames: json!({ "era": { "1418": { "top": 20000, "bottom": -20000, "left": -20000, "right": 20000, "c": 1 }, "1454": { "top": 20000, "bottom": -20000, "left": -20000, "right": 20000, "c": 1 }, "1413": { "top": 20000, "bottom": -20000, "left": -20000, "right": 20000, "c": 1 } } }),
		route_travel: true,
		..Case::default()
	};
	let g = pick(&run(&c, None).read("a"), r"^step|^\s+(goto|fly|train|accept)");
	// (v1's Warrior and Rogue step with the stop, the stop's own line for the rest: all before Korran.)
	let last_train = g.iter().rposition(|l| l.contains("train class")).map_or(i64::MAX, |i| i as i64);
	assert!(idx(&g, "  train class") >= 0 && last_train < idx(&g, "  accept 3"), "{g:#?}");
}

#[test]
fn the_druids_thunder_bluff_training_flies_from_the_routes_orgrimmar_stop_on_to_where_it_goes() {
	// c19p Horde 30-40/03-arathi-highlands: off the zeppelin in Orgrimmar the route trains and flies to
	// the Crossroads (Korran, added), then Regthar. The Druids' and Paladins' Thunder Bluff step flew
	// them Orgrimmar -> Crossroads -> Thunder Bluff -> Crossroads; theirs is Orgrimmar -> Thunder Bluff
	// -> Crossroads, one flight to the Crossroads for each class.
	// (Also with no Korran: the route's way on from the stop is its flight to the Crossroads and the
	// walk to Regthar, v1's training steps the stop's, a 200k search's c19p order.)
	let fr = json!({ "top": 20000, "bottom": -20000, "left": -20000, "right": 20000, "c": 1 });
	let korran = json!([
		{ "t": "accept", "q": 1, "pt": 0, "lvl": 38.0, "from": f("a", 8), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }, { "t": "getfp", "node": 2 }] },
		{ "t": "train", "pt": 1, "lvl": 38.1, "from": "train stop", "items": [{ "t": "network", "from": 0, "to": 1 }] },
		{ "t": "accept", "q": 3, "pt": 5, "lvl": 38.1, "from": "inserted", "items": [{ "t": "network", "from": 1, "to": 5, "legs": [{ "k": "walk", "to": 2, "node": 0 }, { "k": "fly", "from": 0, "to": 2 }, { "k": "walk", "to": 5 }] }] },
		{ "t": "turnin", "q": 2, "pt": 6, "lvl": 38.2, "from": f("a", 27) }
	]);
	let no_korran = json!([
		{ "t": "accept", "q": 1, "pt": 0, "lvl": 38.0, "from": f("a", 8), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }, { "t": "getfp", "node": 2 }] },
		{ "t": "train", "pt": 1, "lvl": 38.1, "from": "train stop", "items": [{ "t": "network", "from": 0, "to": 1 }] },
		{ "t": "turnin", "q": 2, "pt": 6, "lvl": 38.2, "from": f("a", 27), "items": [{ "t": "network", "from": 1, "to": 6, "legs": [{ "k": "walk", "to": 2, "node": 0 }, { "k": "fly", "from": 0, "to": 2 }, { "k": "walk", "to": 6 }] }] }
	]);
	for order in [korran, no_korran] {
		let c = Case {
			files: vec![(
				"a",
				vec![
					"guide t/a",
					"title A",
					"race Orc,Troll,Tauren,Undead,Skyborne",
					"levels 38-40",
					"zone Badlands",
					"",
					"step Kargath",
					"  accept 1",
					"",
					"step Orgrimmar",
					"  zone Orgrimmar",
					"  train class only Warrior,Hunter,Rogue,Priest,Shaman,Mage,Warlock",
					"  accept 1718 only Warrior",
					"",
					"step Thunder Bluff",
					"  only Druid,Paladin",
					"  zone Thunder Bluff",
					"  fly \"Thunder Bluff\"",
					"  train class",
					"",
					"step The Crossroads",
					"  zone The Barrens",
					"  fly \"Crossroads\"",
					"",
					"step Regthar",
					"  zone The Barrens",
					"  turnin 2",
					"",
				],
			)],
			world: json!({
				"points": [[1, 1, 0, 0, 1418], [1, 1, 9000, 9000, 1454], [1, 1, 9100, 8900, 1454], [1, 1, 4000, 4000, 1456], [1, 1, 8000, 6000, 1413], [1, 1, 8030, 6000, 1413], [1, 1, 8600, 6200, 1413]],
				"zones": { "1418": "Badlands", "1454": "Orgrimmar", "1456": "Thunder Bluff", "1413": "The Barrens" },
				"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 6, "ender": 6 }, { "id": 3, "giver": 5, "ender": 5 }, { "id": 1718, "giver": 1, "ender": 1 }],
				"nodes": [{ "kind": "fp", "name": "Orgrimmar", "pt": 2 }, { "kind": "fp", "name": "Thunder Bluff", "pt": 3 }, { "kind": "fp", "name": "Crossroads", "pt": 4 }]
			}),
			frames: json!({ "era": { "1418": fr, "1454": fr, "1456": fr, "1413": fr } }),
			quests: json!({ "1": { "title": "One" }, "2": { "title": "Two" }, "3": { "title": "Three" }, "1718": { "title": "The Islander", "classes": 1 } }),
			route: json!({ "faction": "Horde", "start": "Tauren", "diff": { "added": [3] }, "order": order }),
			route_travel: true,
			..Case::default()
		};
		let g = pick(&run(&c, None).read("a"), r"^step|^\s+(only|goto|fly|train|accept|turnin)");
		let last_train = g.iter().rposition(|l| l.contains("train class")).map_or(i64::MAX, |i| i as i64);
		let next = g.iter().position(|l| l == "  accept 3" || l == "  turnin 2").map_or(-1, |i| i as i64);
		assert!(last_train < next, "{g:#?}");
		// (Each Druid flight to the Crossroads: in a step for everyone or for the Druids.)
		let mut only: Option<&str> = None;
		let mut druid_xr = Vec::new();
		for (i, l) in g.iter().enumerate() {
			if l.starts_with("step ") {
				only = None;
			} else if let Some(o) = l.strip_prefix("  only ") {
				only = Some(o);
			} else if l == "  fly \"Crossroads\"" && only.is_none_or(|o| o.split(',').any(|c| c == "Druid")) {
				druid_xr.push(i as i64);
			}
		}
		assert_eq!(druid_xr.len(), 1, "{g:#?}");
		assert!(idx(&g, "  fly \"Thunder Bluff\"") < druid_xr[0], "{g:#?}");
	}
}

#[test]
fn v1s_training_behind_its_level_line_waits_for_the_routes_training_at_that_level() {
	// c14 Orc (Rev14H1 A2): the seed's level-20 training, after its `level 20`, was written with the
	// route's 19.1 training at 04-the-barrens' head; the route's own 20.2 stop trained only Rogues and
	// Warlocks. v1's training of the level-20 ranks goes with the route's training at 20.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 19-21",
				"zone Durotar",
				"",
				"step Hub",
				"  accept 1",
				"",
				"step Camp",
				"  turnin 1",
				"",
				"step Level 20",
				"  level 20",
				"",
				"step Thunder Bluff",
				"  only Druid",
				"  train class",
				"",
				"step Field",
				"  accept 2",
				"",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1411], [0, 0, -800, 800, 1411]], "zones": { "1411": "Durotar" }, "quests": [] }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({ "3169": { "name": "Tarshaw", "subName": "Warrior Trainer", "faction": "H", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 19.0, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "lvl": 19.1, "pt": 0, "from": "train stop" },
			{ "t": "turnin", "q": 1, "lvl": 19.2, "pt": 1, "from": f("a", 10) },
			{ "t": "accept", "q": 2, "lvl": 19.3, "pt": 1, "from": f("a", 20) },
			{ "t": "train", "lvl": 20.2, "pt": 0, "from": "train stop" }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let tb = idx(&g, "step Thunder Bluff");
	assert!(tb > idx(&g, "  accept 2"), "{g:#?}");
	assert_eq!(g.iter().filter(|l| m(l, r"^\s+train class")).count(), 3, "{g:#?}");
}

#[test]
fn a_class_accept_a_top_up_under_its_level_stays_behind_a_level_line() {
	// c14 Night Elf (Rev14A1, (16)): the route leaves Darkshore at 19.7; the Druids' Cat Form (min 20)
	// was held to the route's next pass at 20, the Hinterlands at 45. Within a level: written where it
	// is, behind `level 20 only Druid`.
	let c = Case {
		files: vec![
			("a", vec!["guide t/a", "title A", "levels 19-20", "zone Durotar", "next t/b", "", "step Hub", "  accept 1", "  accept 5 only Druid", "", "step Camp", "  turnin 1", ""]),
			("b", vec!["guide t/b", "title B", "levels 20-45", "zone Durotar", "", "step Far", "  accept 2", "", "step Later", "  turnin 2", ""]),
		],
		quests: json!({ "5": { "title": "Cat Form", "minLevel": 20 } }),
		world: json!({ "points": [[0, 0, 0, 0, 1411]], "zones": { "1411": "Durotar" }, "quests": [] }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 19.6, "pt": 0, "from": f("a", 8) },
			{ "t": "turnin", "q": 1, "lvl": 19.7, "pt": 0, "from": f("a", 12) },
			{ "t": "accept", "q": 2, "lvl": 45.0, "pt": 0, "from": f("b", 7) },
			{ "t": "turnin", "q": 2, "lvl": 45.1, "pt": 0, "from": f("b", 10) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let r = run(&c, None);
	let a = r.read("a");
	let acc = idx(&a, "  accept 5 only Druid");
	assert!(acc >= 0 && idx(&a, "  level 20 only Druid") == acc - 1, "{a:#?}\n{:#?}", r.read("b"));
}

#[test]
fn rare_start_lines_keep_their_gating_and_place() {
	// c14 Human Elwynn (Rev14Human B3, seed test #553): v1's lines for the rare Gold Pickup Schedule
	// (123) and Manhunt (147, `when turnedin 123`) the route leaves out were merged into Forest's Edge
	// and lost their `when`; the Hunters' 94792 from Josephine in Goldshire came with them.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-12",
				"zone Elwynn Forest",
				"",
				"step Westbrook",
				"  accept 11",
				"",
				"step Forest's Edge",
				"  collect 782 quest 11",
				"  collect 1307 x1 optional",
				"  accept 123 optional",
				"",
				"step Westbrook again",
				"  turnin 11",
				"",
				"step Marshal Dughan",
				"  turnin 123",
				"",
				"step Marshal Dughan",
				"  when turnedin 123",
				"  accept 147",
				"",
				"step Murlocs and the Collector",
				"  collect 780 quest 46",
				"  collect 2239 quest 147",
				"  kill 118 quest 52",
				"",
				"step Guard Thomas",
				"  turnin 52",
				"",
				"step Goldshire",
				"  accept 9",
				"",
				"step Marshal Dughan",
				"  when onquest 147",
				"  turnin 147",
				"",
				"step Taming the Beast",
				"  only Hunter",
				"  accept 94792",
				"",
			],
		)],
		world: json!({ "points": [[0, 0, -400, 0, 1429], [0, 0, -500, 50, 1429], [0, 0, 0, 0, 1429], [0, 0, 300, 300, 1429]], "zones": { "1429": "Elwynn Forest" }, "quests": [] }),
		frames: json!({ "era": { "1429": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		quests: json!({
			"94792": { "title": "Taming the Beast", "start": { "npc": [7] } },
			"123": { "title": "The Collector", "end": { "npc": [240] } },
			"147": { "title": "Manhunt", "start": { "npc": [240] }, "end": { "npc": [240] } }
		}),
		npcs: json!({
			"240": { "name": "Marshal Dughan", "spawns": { "1429": { "f": "e", "pts": [[50, 50]] } } },
			"7": { "name": "Josephine", "spawns": { "1429": { "f": "e", "pts": [[50.5, 50]] } } }
		}),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": { "dropped": [46, 147] }, "order": [
			{ "t": "task", "q": 52, "lvl": 9.5, "pt": 3, "from": f("a", 27) },
			{ "t": "accept", "q": 11, "lvl": 10.0, "pt": 0, "from": f("a", 7) },
			{ "t": "task", "q": 11, "lvl": 10.1, "pt": 1, "from": f("a", 10) },
			{ "t": "turnin", "q": 11, "lvl": 10.3, "pt": 0, "from": f("a", 15) },
			{ "t": "turnin", "q": 52, "lvl": 10.7, "pt": 3, "from": f("a", 30) },
			{ "t": "accept", "q": 9, "lvl": 11.0, "pt": 2, "from": f("a", 33) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let fe = idx(&g, "step Forest's Edge");
	let next = g.iter().enumerate().skip(fe as usize + 1).find(|(_, l)| l.starts_with("step ")).map_or(g.len(), |(i, _)| i);
	assert!(!g[fe as usize..next].iter().any(|l| l.starts_with("  turnin 123") || l.contains("94792")), "{g:#?}");
	let a147 = g.iter().position(|l| l.starts_with("  accept 147")).unwrap_or_else(|| panic!("{g:#?}"));
	let head = g[..a147].iter().rposition(|l| l.starts_with("step ")).unwrap();
	assert!(g[head..a147].iter().any(|l| l == "  when turnedin 123"), "{g:#?}");
}

#[test]
fn a_class_way_takes_the_tram_and_only_flight_paths_that_class_learned() {
	// c14 Dwarf: the Warriors' Defensive Stance in Stormwind, from Ironforge, got a flight round about by
	// way of the Paladins' own flight path; the tram between the cities is their way.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Dwarf,Gnome",
				"levels 8-12",
				"zone Ironforge",
				"",
				"step Ironforge",
				"  accept 1",
				"",
				"step Paladin flight",
				"  only Paladin",
				"  zone Stormwind City",
				"  getfp \"Stormwind\"",
				"",
				"step Defensive Stance",
				"  only Warrior",
				"  zone Stormwind City",
				"  accept 7",
				"",
				"step Ironforge again",
				"  zone Ironforge",
				"  turnin 1",
				"",
			],
		)],
		world: json!({
			"points": [[0, 0, 0, 0, 1455], [0, 0, 20, 0, 1455], [0, 0, -3000, 1800, 1453], [0, 0, -3010, 1790, 1453], [0, 0, 30, 30, 1455], [0, 0, -2990, 1790, 1453]],
			"zones": { "1455": "Ironforge", "1453": "Stormwind City" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 7, "giver": 2, "ender": 2 }],
			"nodes": [{ "kind": "fp", "name": "Ironforge", "pt": 1 }, { "kind": "fp", "name": "Stormwind", "pt": 3 }, { "kind": "dock", "name": "Ironforge (tram)", "pt": 4 }, { "kind": "dock", "name": "Stormwind (tram)", "pt": 5 }],
			"rides": [[2, 3, 100, 60, "tram-x"], [3, 2, 100, 60, "tram-x"]]
		}),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "7": { "title": "Seven", "minLevel": 1, "classes": 1 } }),
		frames: json!({ "era": { "1455": { "top": 9000, "bottom": -9000, "left": -9000, "right": 9000, "c": 0 }, "1453": { "top": 9000, "bottom": -9000, "left": -9000, "right": 9000, "c": 0 } } }),
		route: json!({ "faction": "Alliance", "start": "Dwarf", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 8.0, "from": f("a", 8), "items": [{ "t": "getfp", "node": 0 }] },
			{ "t": "turnin", "q": 1, "pt": 0, "lvl": 9.0, "from": f("a", 22) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let s = idx(&g, "step Defensive Stance");
	let tram = g.iter().position(|l| l.contains("\"Tram to Stormwind\"")).map_or(-1, |i| i as i64);
	assert!(tram >= 0 && tram < s, "{g:#?}");
	assert!(!g[..s as usize].iter().any(|l| l.contains("fly \"Stormwind\"")), "{g:#?}");
}

#[test]
fn a_waiting_class_step_goes_before_the_routes_crossing_not_after_it() {
	// c14 Undead: the Warlocks' Undercity step waited for the route's next line, at the Crossroads after
	// the zeppelin: written there, with a zeppelin there and back.
	let c = Case {
		files: vec![
			(
				"a",
				vec![
					"guide t/a",
					"title A",
					"race Undead",
					"levels 10-12",
					"zone Tirisfal Glades",
					"next t/b",
					"",
					"step Brill",
					"  accept 1",
					"",
					"step The Undercity",
					"  only Warlock",
					"  zone Undercity",
					"  accept 9",
					"",
					"step Zeppelin to Orgrimmar",
					"  goto 60.7,58.9 \"Zeppelin to Orgrimmar\"",
					"",
				],
			),
			("b", vec!["guide t/b", "title B", "levels 10-12", "zone The Barrens", "", "step The Crossroads", "  accept 2", ""]),
		],
		world: json!({
			"points": [[0, 0, 0, 0, 1420], [0, 0, 300, 300, 1458], [1, 1, 5000, 5000, 1413], [0, 0, 100, 0, 1420], [1, 1, 4000, 4000, 1411]],
			"zones": { "1420": "Tirisfal Glades", "1458": "Undercity", "1413": "The Barrens", "1411": "Durotar" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 9, "giver": 1, "ender": 1 }, { "id": 2, "giver": 2, "ender": 2 }, { "id": 77, "giver": 2, "ender": 2 }],
			"nodes": [{ "kind": "dock", "name": "Tirisfal Glades (zeppelin)", "pt": 3 }, { "kind": "dock", "name": "Orgrimmar (zeppelin)", "pt": 4 }],
			"rides": [[0, 1, 100, 60, "zep-x"], [1, 0, 100, 60, "zep-x"]]
		}),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 }, "9": { "title": "Nine", "minLevel": 1, "classes": 256 }, "77": { "title": "Added", "minLevel": 1, "start": { "npc": [5] } } }),
		frames: json!({ "era": {
			"1420": { "top": 9000, "bottom": -9000, "left": -9000, "right": 9000, "c": 0 }, "1458": { "top": 9000, "bottom": -9000, "left": -9000, "right": 9000, "c": 0 },
			"1413": { "top": 9000, "bottom": -9000, "left": -9000, "right": 9000, "c": 1 }, "1411": { "top": 9000, "bottom": -9000, "left": -9000, "right": 9000, "c": 1 } } }),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 10.0, "from": f("a", 9) },
			{ "t": "accept", "q": 77, "pt": 2, "lvl": 10.5, "items": [{ "t": "network", "from": 0, "to": 2 }] },
			{ "t": "accept", "q": 2, "pt": 2, "lvl": 10.5, "from": f("b", 7) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let out = run(&c, None);
	let g: Vec<String> = out.read("a").into_iter().chain(out.read("b")).collect();
	let uc = idx(&g, "  accept 9");
	let zep = g.iter().position(|l| l.contains("\"Zeppelin to Orgrimmar\"")).map_or(-1, |i| i as i64);
	assert!(uc >= 0 && zep > uc, "{g:#?}");
	assert_eq!(g.iter().filter(|l| l.starts_with("  goto") && l.contains("Zeppelin to")).count(), 1, "{g:#?}");
}

#[test]
fn a_shared_guide_played_on_both_sides_of_the_join_writes_its_own_part_only() {
	// Night Elves (Rev14NightElf A1): Darkshore's first loop before Westfall, its later quests after it
	// in the shared tail. The start's run writes the first loop (its own copy); the later steps are the
	// shared guide's, the canonical start's writing.
	let c = Case {
		files: vec![
			("start", vec!["guide t/start", "title S", "race NightElf", "levels 1-10", "zone Teldrassil", "next t/shared", "", "step Dolanaar", "  accept 1", "  turnin 1", ""]),
			("shared", vec!["guide t/shared", "title Darkshore", "levels 11-20", "zone Darkshore", "next t/join", "", "step Auberdine", "  accept 2", "", "step Later", "  accept 4", ""]),
			("join", vec!["guide t/join", "title Westfall", "levels 10-20", "zone Westfall", "", "step Sentinel Hill", "  accept 3", ""]),
		],
		world: json!({ "points": [[0, 0, 0, 0, 1438], [0, 0, 100, 0, 1439], [0, 0, 200, 0, 1436], [0, 0, 150, 0, 1439]], "zones": { "1438": "Teldrassil", "1439": "Darkshore", "1436": "Westfall" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 1, "ender": 1 }, { "id": 3, "giver": 2, "ender": 2 }, { "id": 4, "giver": 3, "ender": 3 }] }),
		route: json!({ "faction": "Alliance", "start": "NightElf", "shared": { "joinAt": "join", "joinStep": 3 }, "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("start", 10) },
			{ "t": "accept", "q": 2, "pt": 1, "from": f("shared", 8) },
			{ "t": "accept", "q": 3, "pt": 2, "from": f("join", 7) },
			{ "t": "accept", "q": 4, "pt": 3, "from": f("shared", 11) }
		] }),
		..Case::default()
	};
	let g = run(&c, None).read("shared");
	assert!(has(&g, "  accept 2") && !has(&g, "  accept 4"), "{g:#?}");
}

#[test]
fn the_own_copy_leaves_a_kept_quests_lines_the_route_plays_after_the_join() {
	// c18 NightElf Darkshore (route-fixes pairs[14]): Buzzbox 827 (983) accepted before Westfall, its
	// crawler legs and hand-in after it, in the shared tail. Its accept kept the quest, so the own copy
	// wrote the tail's hand-in too, before the shared tail's Fruit of the Sea accept.
	let c = Case {
		files: vec![
			("start", vec!["guide t/start", "title S", "race NightElf", "levels 1-10", "zone Teldrassil", "next t/shared", "", "step Dolanaar", "  accept 1", "  turnin 1", ""]),
			("shared", vec!["guide t/shared", "title Darkshore", "levels 11-20", "zone Darkshore", "next t/join", "", "step Auberdine", "  accept 2", "", "step Later", "  turnin 2", ""]),
			("join", vec!["guide t/join", "title Westfall", "levels 10-20", "zone Westfall", "", "step Sentinel Hill", "  accept 3", ""]),
		],
		world: json!({ "points": [[0, 0, 0, 0, 1438], [0, 0, 100, 0, 1439], [0, 0, 200, 0, 1436], [0, 0, 150, 0, 1439]], "zones": { "1438": "Teldrassil", "1439": "Darkshore", "1436": "Westfall" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 1, "ender": 3 }, { "id": 3, "giver": 2, "ender": 2 }] }),
		route: json!({ "faction": "Alliance", "start": "NightElf", "shared": { "joinAt": "join", "joinStep": 3 }, "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("start", 10) },
			{ "t": "accept", "q": 2, "pt": 1, "from": f("shared", 8) },
			{ "t": "accept", "q": 3, "pt": 2, "from": f("join", 7) },
			{ "t": "turnin", "q": 2, "pt": 3, "from": f("shared", 11) }
		] }),
		..Case::default()
	};
	let g = run(&c, None).read("shared");
	assert!(has(&g, "  accept 2") && !has(&g, "  turnin 2"), "{g:#?}");
}

#[test]
fn the_own_copy_leaves_a_later_quest_whose_hand_in_is_elsewhere_in_the_tail() {
	// Rev15NightElf (23): Darkshore's later quests (The Sleeper Has Awakened, 5321, handed in at
	// Ashenvale) stayed in the Night Elves' own Darkshore at 14: their hand-ins kept them out of the
	// dropped list.
	let c = Case {
		files: vec![
			("start", vec!["guide t/start", "title S", "race NightElf", "levels 1-10", "zone Teldrassil", "next t/shared", "", "step Dolanaar", "  accept 1", "  turnin 1", ""]),
			("shared", vec!["guide t/shared", "title Darkshore", "levels 11-20", "zone Darkshore", "next t/join", "", "step Auberdine", "  accept 2", "", "step Later", "  accept 4", ""]),
			("join", vec!["guide t/join", "title Westfall", "levels 10-20", "zone Westfall", "", "step Sentinel Hill", "  accept 3", "", "step Astranaar", "  turnin 4", ""]),
		],
		world: json!({ "points": [[0, 0, 0, 0, 1438], [0, 0, 100, 0, 1439], [0, 0, 200, 0, 1436], [0, 0, 150, 0, 1439]], "zones": { "1438": "Teldrassil", "1439": "Darkshore", "1436": "Westfall" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 1, "ender": 1 }, { "id": 3, "giver": 2, "ender": 2 }, { "id": 4, "giver": 3, "ender": 2 }] }),
		route: json!({ "faction": "Alliance", "start": "NightElf", "shared": { "joinAt": "join", "joinStep": 3 }, "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("start", 10) },
			{ "t": "accept", "q": 2, "pt": 1, "from": f("shared", 8) },
			{ "t": "accept", "q": 3, "pt": 2, "from": f("join", 7) },
			{ "t": "accept", "q": 4, "pt": 3, "from": f("shared", 11) },
			{ "t": "turnin", "q": 4, "pt": 2, "from": f("join", 10) }
		] }),
		..Case::default()
	};
	let g = run(&c, None).read("shared");
	assert!(has(&g, "  accept 2") && !g.iter().any(|l| l.starts_with("  accept 4")), "{g:#?}");
}

#[test]
fn the_own_part_of_a_shared_guide_is_played_before_the_join_where_v1_chains_it_after() {
	// Rev14 item 5: v1 chains Teldrassil -> Westfall -> Darkshore, the Night Elves' own run played its
	// Darkshore part from Stormwind, and the travel repair sent every Night Elf on a boat from Stormwind's
	// dock to Rut'theran Village at the start of their Darkshore.
	let c = Case {
		files: vec![
			("start", vec!["guide forever/start", "title S", "race NightElf", "levels 1-10", "zone Teldrassil", "next forever/join", "", "step Dolanaar", "  accept 1", "  turnin 1", ""]),
			("join", vec!["guide forever/join", "title Westfall", "levels 10-20", "zone Westfall", "next forever/shared", "", "step Sentinel Hill", "  accept 3", ""]),
			("shared", vec!["guide forever/shared", "title Darkshore", "levels 11-20", "zone Darkshore", "next forever/after", "", "step Auberdine", "  accept 2", "", "step Later", "  accept 4", ""]),
			("after", vec!["guide forever/after", "title Redridge", "levels 15-25", "zone Redridge Mountains", "", "step Lakeshire", "  accept 5", ""]),
		],
		world: json!({ "points": [[0, 0, 0, 0, 1438], [0, 0, 100, 0, 1439], [0, 0, 200, 0, 1436], [0, 0, 150, 0, 1439], [0, 0, 300, 0, 1433]], "zones": { "1438": "Teldrassil", "1439": "Darkshore", "1436": "Westfall", "1433": "Redridge Mountains" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 1, "ender": 1 }, { "id": 3, "giver": 2, "ender": 2 }, { "id": 4, "giver": 3, "ender": 3 }, { "id": 5, "giver": 4, "ender": 4 }] }),
		route: json!({ "faction": "Alliance", "start": "NightElf", "shared": { "joinAt": "join", "joinStep": 3 }, "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("start", 9) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("start", 10) },
			{ "t": "accept", "q": 2, "pt": 1, "from": f("shared", 8) },
			{ "t": "accept", "q": 3, "pt": 2, "from": f("join", 8) },
			{ "t": "accept", "q": 4, "pt": 3, "from": f("shared", 11) },
			{ "t": "accept", "q": 5, "pt": 4, "from": f("after", 7) }
		] }),
		..Case::default()
	};
	let r = run(&c, None);
	let chain: Vec<&str> = r.out.travel.chain.iter().map(String::as_str).collect();
	assert_eq!(chain, vec!["forever/start.guide", "forever/shared.guide", "forever/join.guide", "forever/after.guide"]);
}

#[test]
fn a_guide_whose_last_steps_all_fly_to_the_next_ones_start_gets_no_way_there() {
	// Rev14 item 5: Teldrassil ends with the Druids' flight to Auberdine and everyone else's (`only Druid`,
	// `only !Druid`; here two races'); Darkshore began with the route's own flight from Rut'theran Village to Auberdine
	// again, for a Night Elf standing in Auberdine (between them, Auberdine's accepts for everyone and the
	// others' flight to Nessa and back; the other starts' Auberdine step first in Darkshore).
	let c = Case {
		files: vec![
			(
				"t/a",
				vec![
					"guide forever/t/a",
					"title A",
					"levels 1-5",
					"zone Durotar",
					"next forever/t/b",
					"",
					"step Hub",
					"  accept 1",
					"  accept 2",
					"  accept 3",
					"",
					"step Bear",
					"  only Troll",
					"  turnin 2",
					"  fly \"Crossroads\"",
					"",
					"step Crossroads",
					"  accept 4",
					"",
					"step Fly back",
					"  only !Troll",
					"  fly \"Razor Hill\"",
					"",
					"step Nessa",
					"  only !Troll",
					"  turnin 3",
					"  fly \"Crossroads\"",
					"",
				],
			),
			("t/b", vec!["guide forever/t/b", "title B", "levels 5-10", "zone The Barrens", "", "step Others", "  only Troll", "  accept 5", "", "step Camp", "  turnin 1", ""]),
		],
		world: two_zone_world(),
		frames: two_zone_frames(),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 2, "from": f("t/a", 8), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }] },
			{ "t": "accept", "q": 2, "pt": 2, "from": f("t/a", 9) },
			{ "t": "accept", "q": 3, "pt": 2, "from": f("t/a", 10) },
			{ "t": "accept", "q": 4, "pt": 2, "from": f("t/a", 18) },
			{ "t": "turnin", "q": 3, "pt": 2, "from": f("t/a", 26) },
			{ "t": "turnin", "q": 1, "pt": 1, "from": f("t/b", 11), "items": [{ "t": "network", "from": 2, "to": 1, "legs": [{ "k": "fly", "from": 0, "to": 1 }, { "k": "walk", "to": 1 }] }] }
		] }),
		route_travel: true,
		..Case::default()
	};
	let r = run(&c, None);
	let (a, b) = (r.read("t/a"), r.read("t/b"));
	assert!(has(&a, "  only !Troll"), "{a:#?}");
	assert!(!b.iter().any(|l| l.starts_with("  fly ")), "{b:#?}");
}

#[test]
fn a_walk_into_riverglades_names_redridge_pass() {
	// Rev14H2 B11: the walks into Riverglades (to the Steamwheedle boat) gave no hint of the way in.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 40-45", "zone Swamp of Sorrows", "", "step Stonard", "  accept 1", "", "step Dock", "  zone Riverglades", "  accept 2", ""])],
		world: json!({ "points": [[0, 0, 0, 0, 1435], [0, 0, 2000, 0, 2001]], "zones": { "1435": "Swamp of Sorrows", "2001": "Riverglades" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 1, "ender": 1 }] }),
		frames: json!({ "era": { "1435": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 }, "2001": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 1, "from": f("a", 11) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(g.iter().any(|l| l.contains("tip") && l.contains("Redridge Pass")), "{g:#?}");
}

#[test]
fn a_walk_out_of_riverglades_names_its_way_out() {
	// Rev15H2 B12: the walks from Powderfuse Port to the Swamp of Sorrows and to Kargath were bare gotos.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 40-45", "zone Riverglades", "", "step Dock", "  accept 1", "", "step Stonard", "  zone Swamp of Sorrows", "  accept 2", ""])],
		world: json!({ "points": [[0, 0, 2000, 0, 2001], [0, 0, 0, 0, 1435]], "zones": { "1435": "Swamp of Sorrows", "2001": "Riverglades" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 1, "ender": 1 }] }),
		frames: json!({ "era": { "1435": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 }, "2001": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 1, "from": f("a", 11) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(g.iter().any(|l| l.contains("tip Leave Riverglades") && l.contains("Redridge Pass")), "{g:#?}");
}

#[test]
fn the_walk_off_the_boat_at_powderfuse_port_names_its_way_out() {
	// Rev15H2 B12 (40-50/03-feralas:71-73): the route sails from Tanaris to Powderfuse Port and walks to
	// Stonard; the walk leaves Riverglades, not Tanaris where the boat left.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 40-45", "zone Tanaris", "", "step Gadgetzan", "  accept 1", "", "step Stonard", "  zone Swamp of Sorrows", "  accept 2", ""])],
		world: json!({ "points": [[0, 0, 0, 0, 1446], [0, 0, 2000, 0, 2001], [0, 0, 2000, 3000, 1435]], "zones": { "1446": "Tanaris", "1435": "Swamp of Sorrows", "2001": "Riverglades" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 2, "ender": 2 }],
			"nodes": [{ "kind": "dock", "name": "Steamwheedle Port (boat)", "pt": 0 }, { "kind": "dock", "name": "Powderfuse Port (boat)", "pt": 1 }],
			"rides": [[0, 1, 100, 60, "boat-powderfuse"]] }),
		frames: json!({ "era": { "1446": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 }, "1435": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 }, "2001": { "top": 5000, "bottom": -5000, "left": -5000, "right": 5000, "c": 0 } } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 2, "from": f("a", 11), "items": [{ "t": "network", "from": 0, "to": 2, "legs": [{ "k": "ride", "ride": 0, "from": 0, "to": 1 }, { "k": "walk", "to": 2 }] }] }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "step Boat to Powderfuse Port") >= 0, "{g:#?}");
	assert!(g.iter().any(|l| l.contains("tip Leave Riverglades") && l.contains("Redridge Pass")), "{g:#?}");
}

#[test]
fn a_top_up_grinds_near_the_player_not_at_a_named_mobs_spot() {
	// Rev14OrcTroll B3: Orc Durotar's "Level 10" went to the Bloodtalon Matriarch on the Echo Isles (the
	// last objective worked, one named mob's claw) from Razor Hill.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 5-12",
				"zone Durotar",
				"",
				"step Hub",
				"  accept 1",
				"  accept 2",
				"",
				"step Boars",
				"  kill 20 quest 1.1",
				"",
				"step Matriarch",
				"  collect 50 quest 2.1",
				"",
				"step Hub again",
				"  turnin 1",
				"  turnin 2",
				"",
			],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 0, "from": f("a", 8) },
			{ "t": "task", "q": 1, "task": 0, "pt": 1, "from": f("a", 11) },
			{ "t": "task", "q": 2, "task": 0, "pt": 2, "from": f("a", 14) },
			{ "t": "turnin", "q": 2, "pt": 0, "from": f("a", 18) },
			{ "t": "level", "lvl": 9.7, "target": 10.0, "pt": 2, "from": "inserted" },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 17) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 300, 0, 1411], [1, 1, 3000, 3000, 1411]], "zones": { "1411": "Durotar" },
			"quests": [{ "id": 1, "objs": [{ "oi": 0, "type": "kill", "id": 20, "task": 0, "count": 10 }] }, { "id": 2, "objs": [{ "oi": 0, "type": "item", "id": 50, "task": 0, "count": 1 }] }] }),
		quests: json!({ "1": { "title": "One", "start": { "npc": [8] }, "end": { "npc": [8] }, "objectives": [{ "type": "kill", "id": 20 }] }, "2": { "title": "Two", "start": { "npc": [8] }, "end": { "npc": [8] }, "objectives": [{ "type": "item", "id": 50 }] } }),
		npcs: json!({ "8": { "name": "Eight", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } }, "20": { "name": "Mottled Boar", "spawns": { "1411": { "f": "e", "pts": [[51, 50], [52, 50], [53, 50]] } } }, "30": { "name": "Bloodtalon Matriarch", "spawns": { "1411": { "f": "e", "pts": [[80, 80]] } } } }),
		items: json!({ "50": { "drops": { "npc": { "30": 100 } } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let s = idx(&g, "step Level 10");
	assert!(s >= 0, "{g:#?}");
	let body: Vec<&String> = g[s as usize..].iter().take_while(|l| !l.is_empty()).collect();
	assert!(!body.iter().any(|l| l.contains("Matriarch")) && body.iter().any(|l| l.contains("Mottled Boar")), "{g:#?}");
}

#[test]
fn a_top_up_goes_to_the_mob_it_names_when_that_mob_is_not_at_the_camp() {
	// #924: Darkshore's level 20 named the Elder Darkshore Thresher (on level) but pointed at the camp of
	// the lower Darkshore Threshers where the route got the Thresher Eyes both drop; the Elders spawn
	// only on the coasts, more than a thousand yards off.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 15-20", "zone Durotar", "", "step Hub", "  accept 1", "", "step Camp", "  collect 50 quest 1.1", "", "step Hub again", "  turnin 1", ""],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 19.0, "from": f("a", 7) },
			{ "t": "task", "q": 1, "task": 0, "pt": 1, "lvl": 19.2, "from": f("a", 10) },
			{ "t": "level", "lvl": 19.6, "target": 20.0, "pt": 1, "from": "inserted" },
			{ "t": "turnin", "q": 1, "pt": 0, "lvl": 20.0, "from": f("a", 13) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 0, 300, 1411]], "zones": { "1411": "Durotar" },
			"quests": [{ "id": 1, "objs": [{ "oi": 0, "type": "item", "id": 50, "task": 0, "count": 8 }] }] }),
		quests: json!({ "1": { "title": "One", "start": { "npc": [8] }, "end": { "npc": [8] }, "objectives": [{ "type": "item", "id": 50 }] } }),
		npcs: json!({
			"8": { "name": "Eight", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } },
			"20": { "name": "Thresher", "level": 12, "spawns": { "1411": { "f": "e", "pts": [[64, 50], [65, 50], [66, 50]] } } },
			"21": { "name": "Elder Thresher", "level": 16, "spawns": { "1411": { "f": "e", "pts": [[10, 90], [80, 20], [90, 10], [20, 85]] } } }
		}),
		items: json!({ "50": { "drops": { "npc": { "20": 30, "21": 30 } } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let s = idx(&g, "step Level 20");
	assert!(s >= 0, "{g:#?}");
	let body: Vec<&String> = g[s as usize..].iter().take_while(|l| !l.is_empty()).collect();
	// (The Elders' spawn nearest the camp, 670 yd off; the camp itself is 65.0,50.0.)
	assert!(body.iter().any(|l| *l == "  goto 80.0,20.0 map 1411 \"Elder Thresher\""), "{g:#?}");
	assert!(body.iter().any(|l| l.ends_with("-- grind on Elder Thresher")), "{g:#?}");
}

#[test]
fn a_top_up_with_no_camp_behind_grinds_at_the_next_camp_near_the_player() {
	// Rev15OrcTroll B3: the Orcs' level 10 was "Grind spot" in the middle of Razor Hill; the Razormane
	// huts the route works next are 300 yd west.
	let c = Case {
		files: vec![(
			"a",
			vec!["guide t/a", "title A", "levels 5-12", "zone Durotar", "", "step Hub", "  accept 1", "  turnin 3", "", "step Huts", "  kill 20 quest 1.1", "", "step Hub again", "  turnin 1", ""],
		)],
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 3, "pt": 0, "from": f("a", 8) },
			{ "t": "level", "lvl": 9.7, "target": 10.0, "pt": 0, "from": "inserted" },
			{ "t": "task", "q": 1, "task": 0, "pt": 1, "from": f("a", 11) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 14) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 300, 0, 1411]], "zones": { "1411": "Durotar" },
			"quests": [{ "id": 1, "objs": [{ "oi": 0, "type": "kill", "id": 20, "task": 0, "count": 10 }] }] }),
		quests: json!({ "1": { "title": "One", "start": { "npc": [8] }, "end": { "npc": [8] }, "objectives": [{ "type": "kill", "id": 20 }] }, "3": { "title": "Three" } }),
		npcs: json!({ "8": { "name": "Eight", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } }, "20": { "name": "Razormane Quilboar", "spawns": { "1411": { "f": "e", "pts": [[51, 50], [52, 50], [53, 50]] } } } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let s = idx(&g, "step Level 10");
	assert!(s >= 0, "{g:#?}");
	let body: Vec<&String> = g[s as usize..].iter().take_while(|l| !l.is_empty()).collect();
	assert!(body.iter().any(|l| l.contains("Razormane Quilboar")) && !body.iter().any(|l| l.contains("Grind spot")), "{g:#?}");
}

fn not_taken_case(dropped: Value, left_out: Value, order: Value) -> Case {
	Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 18-20",
				"zone Durotar",
				"",
				"step Hub",
				"  accept 1",
				"  accept 2",
				"  accept 3",
				"  collect 77                       -- the bowl, filled at the well",
				"  accept 4 optional",
				"",
				"step Camp",
				"  kill 10 quest 1.1",
				"  kill 11 quest 2.1",
				"  kill 12 quest 4.1 optional",
				"",
				"step Blackwood",
				"  collect 78",
				"  use 77 quest 3.1",
				"",
				"step Hub again",
				"  turnin 1",
				"  turnin 2",
				"  turnin 3",
				"  turnin 4 optional",
				"",
			],
		)],
		route: json!({ "faction": "Horde", "diff": { "dropped": dropped }, "leftOut": left_out, "order": order }),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, -500, 500, 1411]], "zones": { "1411": "Durotar" }, "quests": [
			{ "id": 1, "objs": [{ "oi": 0, "type": "kill", "id": 10, "task": 0 }] },
			{ "id": 2, "objs": [{ "oi": 0, "type": "kill", "id": 11, "task": 0 }] },
			{ "id": 3, "objs": [{ "oi": 0, "type": "object", "id": 13, "task": 0 }] },
			{ "id": 4, "objs": [{ "oi": 0, "type": "kill", "id": 12, "task": 0 }] }
		] }),
		quests: json!({ "1": { "title": "One" }, "2": { "title": "Two" }, "3": { "title": "Three" }, "4": { "title": "Four" } }),
		..Case::default()
	}
}

#[test]
fn a_quest_the_planner_left_out_is_not_written() {
	// c17 RevA 5: Swelling Forces (98013), which no start's route takes (low XP for its detour, left out
	// before the seed, so the route's diff does not name it; the skip ledger does), was written in the
	// Night Elves' first Darkshore visit, under level and before its prerequisite, and again on the
	// second. An optional quest stays (the player's luck); so does one the ledger does not leave out.
	let order = json!([
		{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) }, { "t": "accept", "q": 3, "pt": 0, "from": f("a", 9) },
		{ "t": "task", "q": 1, "task": 0, "pt": 1, "from": f("a", 14) }, { "t": "task", "q": 3, "task": 0, "pt": 1, "from": f("a", 20) },
		{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 23) }, { "t": "turnin", "q": 3, "pt": 0, "from": f("a", 25) }
	]);
	let text = run(&not_taken_case(json!([]), json!([2, 4]), order.clone()), None).text("a");
	assert!(!m(&text, r"\n\s+(accept|turnin) 2\b|quest 2\.1"), "{text}");
	assert!(m(&text, r"\n\s+accept 4 optional") && m(&text, r"\n\s+accept 3\b"), "{text}");
	let kept = run(&not_taken_case(json!([]), json!([]), order), None).text("a");
	assert!(m(&kept, r"\n\s+accept 2\b"), "{kept}");
}

#[test]
fn a_class_hand_in_waits_for_the_city_visit_after_its_work() {
	// c17 RevA 2: the Warlocks' Binding at Gakin in Stormwind went with the Arathi accept after it in
	// v1, moved early, to the route's Stormwind stop before the Heartswood in Ashenvale; the hand-in
	// then followed the Heartswood, a boat to Stormwind and back. It waits for the Stormwind visit
	// after the Heartswood, as v1 has it.
	let a = vec![
		"guide t/a",
		"title A",
		"levels 30-40",
		"zone Ashenvale",
		"",
		"step Heartswood",
		"  only Warlock",
		"  zone Ashenvale",
		"  collect 6912 quest 1738.1",
		"",
		"step Tal",
		"  zone Ashenvale",
		"  accept 6",
		"",
		"step Stormwind",
		"  zone Stormwind City",
		"  accept 8",
		"",
		"step The Binding",
		"  only Warlock",
		"  zone Stormwind City",
		"  turnin 1738",
		"",
		"step Arathi",
		"  zone Arathi Highlands",
		"  accept 9",
		"",
		"step Stormwind early",
		"  zone Stormwind City",
		"  turnin 3",
		"",
	];
	let c = Case {
		files: vec![("a", a)],
		route: json!({ "faction": "Alliance", "diff": {}, "order": [
			{ "t": "accept", "q": 9, "pt": 2, "lvl": 31.4, "from": f("a", 26) },
			{ "t": "turnin", "q": 3, "pt": 1, "lvl": 32.4, "from": f("a", 30) },
			{ "t": "accept", "q": 6, "pt": 0, "lvl": 33.0, "from": f("a", 13) },
			{ "t": "accept", "q": 8, "pt": 1, "lvl": 37.0, "from": f("a", 17) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1440], [2, 2, 0, 0, 1453], [2, 2, 3000, 3000, 1417]], "zones": { "1440": "Ashenvale", "1453": "Stormwind City", "1417": "Arathi Highlands" }, "quests": [] }),
		quests: json!({ "1738": { "title": "The Binding", "end": { "npc": [6999] }, "objectives": [{ "type": "item", "id": 6912 }] }, "3": { "title": "Three" }, "6": { "title": "Six" }, "8": { "title": "Eight" }, "9": { "title": "Nine" } }),
		npcs: json!({ "6999": { "name": "Gakin the Darkbinder", "faction": "A", "spawns": { "1453": { "f": "e", "pts": [[50, 50]] } } } }),
		frames: json!({ "era": {
			"1440": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 },
			"1453": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 2 },
			"1417": { "top": 4000, "bottom": 2000, "left": 2000, "right": 4000, "c": 2 }
		} }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (wood, tal, bind, eight) =
		(idx(&g, "  collect 6912 quest 1738.1"), idx(&g, "  accept 6"), g.iter().position(|l| l.starts_with("  turnin 1738")).map_or(-1, |i| i as i64), idx(&g, "  accept 8"));
	assert!(wood >= 0 && tal >= 0 && eight >= 0 && bind > wood && bind > tal && bind > eight, "{g:#?}");
}

#[test]
fn a_class_hand_in_with_no_pass_after_its_work_goes_after_the_work_with_its_run() {
	// c18 Tauren Shaman Call of Fire R5: Telf Joolam's hand-in in Durotar, whose Fire Tar is in the
	// Disruption Ends step the route writes later, went back to the route's earlier Durotar pass,
	// before the tar; Kranal Fiss's `turnin 1527` stayed before Telf's `accept 1527`. With no Durotar
	// pass after the work, both go right after it, in v1's order.
	let a = vec![
		"guide t/a",
		"title A",
		"levels 10-20",
		"zone The Barrens",
		"",
		"step Telf first",
		"  zone Durotar",
		"  accept 1525",
		"",
		"step The Crossroads",
		"  zone The Barrens",
		"  accept 872",
		"",
		"step The Disruption Ends",
		"  zone The Barrens",
		"  kill 3269 quest 872.1",
		"  collect 5026 quest 1525.1 only Tauren,Shaman",
		"",
		"step Telf Joolam",
		"  only Tauren,Shaman",
		"  zone Durotar",
		"  turnin 1525",
		"  accept 1527",
		"",
		"step Kranal Fiss",
		"  only Tauren,Shaman",
		"  zone The Barrens",
		"  turnin 1527",
		"",
		"step Echeyakee",
		"  zone The Barrens",
		"  collect 5100 quest 881.1",
		"",
		"step Back",
		"  zone The Barrens",
		"  turnin 872",
		"",
	];
	let c = Case {
		files: vec![("a", a)],
		route: json!({ "faction": "Horde", "diff": {}, "order": [
			{ "t": "accept", "q": 1525, "pt": 0, "from": f("a", 8) },
			{ "t": "accept", "q": 872, "pt": 1, "from": f("a", 12) },
			{ "t": "task", "q": 881, "task": 0, "pt": 1, "from": f("a", 32) },
			{ "t": "task", "q": 872, "task": 0, "pt": 1, "from": f("a", 16) },
			{ "t": "turnin", "q": 872, "pt": 1, "from": f("a", 36) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 3000, 3000, 1413]], "zones": { "1411": "Durotar", "1413": "The Barrens" }, "quests": [] }),
		quests: json!({ "1525": { "title": "Call of Fire", "classes": 64 }, "1527": { "title": "Call of Fire", "classes": 64 }, "872": { "title": "The Disruption Ends" }, "881": { "title": "Echeyakee" } }),
		frames: json!({ "era": {
			"1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 },
			"1413": { "top": 4000, "bottom": 2000, "left": 2000, "right": 4000, "c": 1 }
		} }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let at = |p: &str| g.iter().position(|l| l.starts_with(p)).map_or(-1, |i| i as i64);
	let (work, telf, accept, kranal) = (at("  kill 3269 quest 872.1"), at("  turnin 1525"), at("  accept 1527"), at("  turnin 1527"));
	assert!(work >= 0 && telf > work && accept > telf && kranal > accept, "{g:#?}");
}

#[test]
fn a_class_run_over_the_sea_starts_before_the_crossing_within_a_top_up() {
	// c17 RevA 1: the Night Elf and Skyborne Druids' Cat Form run (min level 20) went with the
	// Stormwind hand-in after it in v1, as the canonical start is 19.7 at its last Auberdine stop: after
	// the boat and Stormwind's work, a flight to Rut'theran from Stormwind and two more crossings. It
	// starts right after the Auberdine step before it, behind a top-up.
	let a = vec![
		"guide t/a",
		"title A",
		"levels 15-20",
		"zone Darkshore",
		"",
		"step Auberdine",
		"  zone Darkshore",
		"  turnin 1",
		"",
		"step The Great Cat Spirit",
		"  only Druid",
		"  zone Darnassus",
		"  accept 98",
		"",
		"step Stormwind",
		"  zone Stormwind City",
		"  turnin 2",
		"",
		"step Cathedral",
		"  zone Stormwind City",
		"  accept 5",
		"",
	];
	let c = Case {
		files: vec![("a", a)],
		route: json!({ "faction": "Alliance", "diff": {}, "order": [
			{ "t": "turnin", "q": 1, "pt": 0, "lvl": 19.7, "from": f("a", 8) },
			{ "t": "accept", "q": 5, "pt": 1, "lvl": 19.8, "from": f("a", 21) },
			{ "t": "turnin", "q": 2, "pt": 1, "lvl": 20.0, "from": f("a", 17) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1439], [2, 2, 0, 0, 1453]], "zones": { "1439": "Darkshore", "1453": "Stormwind City", "1457": "Darnassus" }, "quests": [] }),
		quests: json!({ "98": { "title": "The Great Cat Spirit", "minLevel": 20, "classes": 1024, "start": { "npc": [3602] } }, "1": { "title": "One" }, "2": { "title": "Two" }, "5": { "title": "Five" } }),
		npcs: json!({ "3602": { "name": "Mathrengyl Bearwalker", "faction": "A", "spawns": { "1457": { "f": "e", "pts": [[50, 50]] } } } }),
		frames: json!({ "era": {
			"1439": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 },
			"1457": { "top": 3000, "bottom": 1000, "left": 1000, "right": 3000, "c": 1 },
			"1453": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 2 }
		} }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (one, cat, five) = (idx(&g, "  turnin 1"), g.iter().position(|l| l.starts_with("  accept 98")).map_or(-1, |i| i as i64), idx(&g, "  accept 5"));
	assert!(one >= 0 && five >= 0 && cat > one && cat < five, "{g:#?}");
}

#[test]
fn an_untagged_bag_line_under_a_dropped_quests_accept_goes_with_it() {
	// c17 RevA 4: the Night Elves' first Darkshore visit had The Blackwood Corrupted's Empty Cleansing
	// Bowl (`collect 12347` right after its accept) and the Blackwood samples (beside the bowl's use)
	// though the quest is taken only on the second visit: collects they could not finish there.
	let order = json!([
		{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) }, { "t": "accept", "q": 2, "pt": 0, "from": f("a", 8) },
		{ "t": "task", "q": 1, "task": 0, "pt": 1, "from": f("a", 14) }, { "t": "task", "q": 2, "task": 0, "pt": 1, "from": f("a", 15) },
		{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 23) }, { "t": "turnin", "q": 2, "pt": 0, "from": f("a", 24) }
	]);
	let text = run(&not_taken_case(json!([3]), json!([]), order), None).text("a");
	assert!(!text.contains("collect 77") && !text.contains("collect 78"), "{text}");
	assert!(m(&text, r"\n\s+kill 11 quest 2\.1"), "{text}");
}

#[test]
fn a_top_up_in_a_city_grinds_at_the_routes_next_hostile_camp() {
	// c17 RevA 3: top-ups in Stormwind and Ironforge were "Grind spot" in the city's streets, and
	// Winterspring's grind was "on General Marcus Jonathan", a friendly Stormwind NPC a quest has you
	// kill credit for. The grind goes to the route's next camp of hostile mobs in the field.
	let c = Case {
		files: vec![
			(
				"a",
				vec!["guide t/a", "title A", "levels 40-45", "zone Stormwind City", "", "step Keep", "  accept 1", "  accept 2", "  kill 30 quest 2.1", "  turnin 2", "", "step Hub", "  turnin 3", ""],
			),
			("b", vec!["guide t/b", "title B", "levels 40-45", "zone Elwynn Forest", "", "step Camp", "  kill 20 quest 1.1", "", "step Back", "  turnin 1", ""]),
		],
		route: json!({ "faction": "Alliance", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 42.0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 0, "lvl": 42.0, "from": f("a", 8) },
			{ "t": "task", "q": 2, "task": 0, "pt": 0, "lvl": 42.0, "from": f("a", 9) },
			{ "t": "turnin", "q": 2, "pt": 0, "lvl": 42.1, "from": f("a", 10) },
			{ "t": "turnin", "q": 3, "pt": 0, "lvl": 42.2, "from": f("a", 13) },
			{ "t": "level", "lvl": 42.2, "target": 42.45, "pt": 0, "from": "inserted" },
			{ "t": "task", "q": 1, "task": 0, "pt": 1, "lvl": 42.5, "from": f("b", 7) },
			{ "t": "turnin", "q": 1, "pt": 2, "lvl": 42.9, "from": f("b", 10) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1453], [1, 1, -800, 800, 1429], [1, 1, -700, 700, 1429]], "zones": { "1453": "Stormwind City", "1429": "Elwynn Forest" },
			"quests": [{ "id": 1, "objs": [{ "oi": 0, "type": "kill", "id": 20, "task": 0, "count": 10 }] }, { "id": 2, "objs": [{ "oi": 0, "type": "kill", "id": 30, "task": 0, "count": 10 }] }] }),
		quests: json!({
			"1": { "title": "One", "start": { "npc": [8] }, "end": { "npc": [9] }, "objectives": [{ "type": "kill", "id": 20 }] },
			"2": { "title": "Two", "start": { "npc": [8] }, "end": { "npc": [8] }, "objectives": [{ "type": "kill", "id": 30 }] },
			"3": { "title": "Three" }
		}),
		npcs: json!({
			"8": { "name": "Eight", "faction": "A", "spawns": { "1453": { "f": "e", "pts": [[50, 50]] } } },
			"9": { "name": "Nine", "faction": "A", "spawns": { "1429": { "f": "e", "pts": [[15, 15]] } } },
			"20": { "name": "Defias Thug", "level": 42, "spawns": { "1429": { "f": "e", "pts": [[10, 10], [11, 10], [10, 11]] } } },
			"30": { "name": "General Marcus Jonathan", "faction": "A", "level": 62, "spawns": { "1453": { "f": "e", "pts": [[51, 50], [52, 50], [53, 50]] } } }
		}),
		frames: json!({ "era": { "1453": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1429": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		..Case::default()
	};
	let text = run(&c, None).text("a") + &run(&c, None).text("b");
	let s = text.find("step Level 42.45").unwrap_or_else(|| panic!("{text}"));
	let body: String = text[s..].split("\n\n").next().unwrap().to_string();
	assert!(body.contains("Defias Thug") && body.contains("map 1429"), "{body}");
	assert!(!body.contains("Marcus") && !body.contains("map 1453") && !body.contains("Grind spot"), "{body}");
}

#[test]
fn a_top_up_for_an_accept_names_it() {
	// Rev15OrcTroll B3: "Top up here to level 10 before the hand-ins at Durotar" when the top-up was for
	// a level 10 quest taken next.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 5-12", "zone Durotar", "", "step Hub", "  turnin 3", "  accept 4", ""])],
		route: json!({ "diff": {}, "order": [
			{ "t": "turnin", "q": 3, "pt": 0, "lvl": 9.7, "from": f("a", 7) },
			{ "t": "level", "lvl": 9.7, "target": 10.0, "pt": 0, "from": "inserted" },
			{ "t": "accept", "q": 4, "pt": 0, "lvl": 10.0, "from": f("a", 8) }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1411]], "zones": { "1411": "Durotar" }, "quests": [] }),
		quests: json!({ "3": { "title": "Three" }, "4": { "title": "Lazy Peons", "minLevel": 10 } }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(g.iter().any(|l| l.starts_with("  tip Top up here to level 10") && l.contains("Lazy Peons") && l.contains("needs level 10")), "{g:#?}");
}

#[test]
fn a_top_up_whose_camp_is_on_the_shore_left_behind_is_done_before_the_crossing() {
	// Rev14A1 (item 13): Level 20 after the Stormwind training, its camp the Darkshore work before the
	// boat: two boats there and back for a grind. Done in Darkshore before the boat.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 15-20",
				"zone Darkshore",
				"",
				"step Auberdine",
				"  accept 1",
				"",
				"step Grove",
				"  kill 20 quest 1.1",
				"",
				"step Auberdine again",
				"  turnin 1",
				"",
				"step Stormwind",
				"  zone Stormwind City",
				"  accept 3",
				"",
			],
		)],
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 19.0, "from": f("a", 7) },
			{ "t": "task", "q": 1, "task": 0, "pt": 1, "lvl": 19.3, "from": f("a", 10) },
			{ "t": "turnin", "q": 1, "pt": 0, "lvl": 19.6, "from": f("a", 13) },
			{ "t": "accept", "q": 3, "pt": 2, "lvl": 19.8, "from": f("a", 17), "items": [{ "t": "network", "from": 0, "to": 2 }] },
			{ "t": "level", "lvl": 19.8, "target": 20.0, "from": "inserted", "items": [{ "t": "network", "from": 2, "to": 1 }] }
		] }),
		world: json!({ "points": [[1, 1, 0, 0, 1439], [1, 1, 400, 0, 1439], [0, 0, 5000, 5000, 1453]], "zones": { "1439": "Darkshore", "1453": "Stormwind City" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0, "objs": [{ "oi": 0, "type": "kill", "id": 20, "task": 0, "count": 10 }] }, { "id": 3, "giver": 2, "ender": 2 }] }),
		quests: json!({ "1": { "title": "One", "objectives": [{ "type": "kill", "id": 20 }] }, "3": { "title": "Three" } }),
		npcs: json!({ "20": { "name": "Grove Bear", "spawns": { "1439": { "f": "e", "pts": [[51, 50], [52, 50], [53, 50]] } } } }),
		frames: json!({ "era": { "1439": { "top": 9000, "bottom": -9000, "left": -9000, "right": 9000, "c": 1 }, "1453": { "top": 9000, "bottom": -9000, "left": -9000, "right": 9000, "c": 0 } } }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let l = idx(&g, "step Level 20");
	assert!(l >= 0 && l < idx(&g, "  accept 3"), "{g:#?}");
}

#[test]
fn a_portal_within_one_zone_is_named_by_where_it_lands_with_one_goto() {
	// Rev14SkyH (item 20): the portal up to the Rohashi Spires, inside Zephras Isle, was "Portal to
	// Zephras Isle", after a walk step to the same spot.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 5-10", "zone Durotar", "", "step Valanaar", "  accept 1", "", "step Lorthuna", "  turnin 1", ""])],
		world: json!({
			"points": [[1, 1, 0, 0, 1411], [1, 1, 600, 600, 1411], [1, 1, 900, 900, 1411], [1, 1, 610, 610, 1411]],
			"zones": { "1411": "Durotar" }, "quests": [{ "id": 1, "giver": 0, "ender": 2 }],
			"nodes": [{ "kind": "portal", "name": "portal-rohashi-spires", "pt": 1 }, { "kind": "portal", "name": "portal-rohashi-spires (arrival)", "pt": 3 }],
			"rides": [[0, 1, 5, 0, "portal-rohashi-spires"]]
		}),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 1, "pt": 2, "from": f("a", 10), "items": [{ "t": "network", "from": 0, "to": 2, "legs": [{ "k": "walk", "to": 1, "node": 0 }, { "k": "ride", "ride": 0, "from": 0, "to": 1 }, { "k": "walk", "to": 2 }] }] }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(has(&g, "step Portal to Rohashi Spires"), "{g:#?}");
	let p = g.iter().position(|l| l.contains("\"Portal to Rohashi Spires\"")).unwrap();
	let at = g[p].split('"').next().unwrap().trim().to_string();
	assert_eq!(g.iter().filter(|l| l.trim().starts_with(&at)).count(), 1, "{g:#?}");
}

#[test]
fn a_training_stop_pulls_no_training_step_away_from_it_and_trains_only_its_trainers_classes() {
	// c15 Horde 02-the-barrens:362-395 (Rev15H1): the route trains at Razor Hill; v1's "To Orgrimmar"
	// (getfp and `train class`) was pulled to it, so everyone walked to Razor Hill for `train class only
	// Paladin,Druid` (no trainer of theirs there), hearthed away and walked back to Orgrimmar. The stop
	// trains its trainers' classes; the Druids train at the route's pass by theirs.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 13-16",
				"zone Durotar",
				"",
				"step Razor Hill",
				"  accept 1",
				"",
				"step To Orgrimmar",
				"  zone Orgrimmar",
				"  getfp \"Orgrimmar\"",
				"  train class",
				"",
				"step Camp",
				"  zone Durotar",
				"  turnin 1",
				"",
				"step Field",
				"  accept 2",
				"",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1411], [0, 0, 800, -800, 1411], [0, 0, -800, 800, 1411]], "zones": { "1411": "Durotar", "1454": "Orgrimmar" }, "quests": [] }),
		frames: json!({ "era": { "1411": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1454": { "top": 3000, "bottom": 2000, "left": -500, "right": 500, "c": 0 } } }),
		npcs: json!({
			"3169": { "name": "Tarshaw", "subName": "Warrior Trainer", "faction": "H", "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } },
			"3033": { "name": "Turak", "subName": "Druid Trainer", "faction": "H", "spawns": { "1411": { "f": "e", "pts": [[90, 90]] } } }
		}),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 14.0, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "lvl": 14.4, "pt": 0, "from": "train stop" },
			{ "t": "turnin", "q": 1, "lvl": 14.6, "pt": 1, "from": f("a", 16) },
			{ "t": "accept", "q": 2, "lvl": 16.5, "pt": 2, "from": f("a", 19) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let first = g.iter().position(|l| m(l, r"^\s+train class")).unwrap_or_else(|| panic!("{g:#?}"));
	assert!(g[first].contains("only") && g[first].contains("Warrior") && !g[first].contains("Druid"), "{g:#?}");
	let to_org = idx(&g, "step To Orgrimmar");
	assert!(to_org < 0 || to_org > idx(&g, "  turnin 1"), "{g:#?}");
	let druid = g.iter().position(|l| m(l, r"^\s+train class only .*Druid")).unwrap_or_else(|| panic!("{g:#?}")) as i64;
	assert!(druid > idx(&g, "  accept 2"), "{g:#?}");
}

#[test]
fn a_riding_step_goes_back_neither_into_an_earlier_guide_by_a_way_piece_nor_under_its_level() {
	// c15 Undead (Rev15H2, #404 again): the 40-50 Feralas guide's "Riding at 40" in Brill went back to
	// the 30-40 guide's Undercity start at 37.4, past the route's own piece there (a way or a training
	// stop, in no guide). It stays in its guide, at 40 or more.
	let c = Case {
		files: vec![
			("a", vec!["guide t/a", "title A", "levels 30-40", "zone Tirisfal Glades", "next t/b", "", "step Undercity", "  accept 1", ""]),
			(
				"b",
				vec![
					"guide t/b",
					"title B",
					"levels 40-50",
					"zone Feralas",
					"",
					"step Riding at 40",
					"  only Undead",
					"  zone Tirisfal Glades",
					"  tip Riding needs level 40.",
					"  train 4773 optional",
					"",
					"step Camp",
					"  zone Feralas",
					"  accept 2",
					"",
				],
			),
		],
		world: json!({ "points": [[0, 0, 0, 0, 1420], [1, 0, 0, 0, 1444]], "zones": { "1420": "Tirisfal Glades", "1444": "Feralas" }, "quests": [] }),
		frames: json!({ "era": { "1420": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1444": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 } } }),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 37.0, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "lvl": 37.4, "pt": 0, "from": "train stop" },
			{ "t": "accept", "q": 2, "lvl": 43.0, "pt": 1, "from": f("b", 14) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let r = run(&c, None);
	let (a, b) = (r.read("a"), r.read("b"));
	assert!(!a.iter().any(|l| l.contains("train 4773")) && b.iter().any(|l| l.contains("train 4773")), "{a:#?}\n{b:#?}");
}

#[test]
fn a_v1_training_step_away_from_the_routes_trainings_goes() {
	// c15 Alliance 40-50/02-badlands (Rev15A2): seed 04-tanaris' "Ironforge ... Train", pulled to Aerie
	// Peak at 43.1 with the accept it waits for, though the route trained in Stormwind at 42.3 (and passed
	// through Ironforge after it): a step with no travel between two Aerie Peak steps. It goes; the
	// Shamans train on the route's Ironforge pass.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 42-45",
				"zone Stormwind City",
				"",
				"step Stormwind",
				"  accept 1",
				"",
				"step Tram",
				"  zone Ironforge",
				"  accept 3",
				"",
				"step Ironforge",
				"  only Warrior,Shaman",
				"  zone Ironforge",
				"  tip Fly from Gadgetzan to Theramore.",
				"  train class only Warrior,Shaman",
				"",
				"step Aerie Peak",
				"  zone The Hinterlands",
				"  accept 2",
				"",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1453], [0, 0, 5000, 0, 1425], [0, 0, 8000, 0, 1455]], "zones": { "1453": "Stormwind City", "1425": "The Hinterlands", "1455": "Ironforge" }, "quests": [] }),
		frames: json!({ "era": { "1453": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1425": { "top": 6000, "bottom": 4000, "left": -1000, "right": 1000, "c": 0 }, "1455": { "top": 9000, "bottom": 7000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"5479": { "name": "Wu Shen", "subName": "Warrior Trainer", "faction": "A", "spawns": { "1453": { "f": "e", "pts": [[50, 50]] } } },
			"258098": { "name": "Eldrun Stormbreaker", "subName": "Shaman Trainer", "faction": "A", "spawns": { "1455": { "f": "e", "pts": [[50, 50]] } } }
		}),
		route: json!({ "faction": "Alliance", "start": "Dwarf", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 42.2, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "lvl": 42.27, "pt": 0, "from": "train stop" },
			{ "t": "accept", "q": 3, "lvl": 42.46, "pt": 2, "from": f("a", 11) },
			{ "t": "accept", "q": 2, "lvl": 43.09, "pt": 1, "from": f("a", 21) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l.contains("Gadgetzan") || l.contains("only Warrior,Shaman")), "{g:#?}");
	let sh = g.iter().position(|l| m(l, r"^\s+train class only .*Shaman")).unwrap_or_else(|| panic!("{g:#?}")) as i64;
	assert!(sh > idx(&g, "  accept 1") && sh < idx(&g, "  accept 2"), "{g:#?}");
}

#[test]
fn a_v1_step_at_where_the_events_leg_leads_goes_after_the_leg() {
	// c15 Gnome (Rev15DwarfGnome B3): the Priests' and Warlocks' Ironforge class quests were written before
	// the route's hearth to Kharanos and walk into Ironforge: a walk into the city, the hearth out, the walk
	// back. They go after the leg, in Ironforge.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-12",
				"zone Dun Morogh",
				"",
				"step North Gate",
				"  accept 1",
				"",
				"step Ironforge class quests",
				"  only Priest,Warlock",
				"  zone Ironforge",
				"  accept 7",
				"",
				"step Ironforge",
				"  zone Ironforge",
				"  turnin 1",
				"",
			],
		)],
		world: json!({
			"points": [[0, 0, 3000, 0, 1426], [0, 0, 0, 0, 1455], [0, 0, 20, 20, 1455], [0, 0, 2000, 500, 1426]],
			"zones": { "1426": "Dun Morogh", "1455": "Ironforge" },
			"quests": [{ "id": 1, "giver": 0, "ender": 1 }, { "id": 7, "giver": 2, "ender": 2 }],
			"inns": [{ "name": "Thunderbrew Distillery", "pt": 3 }]
		}),
		frames: json!({ "era": { "1426": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 }, "1455": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 } } }),
		quests: json!({ "7": { "title": "Seven", "classes": 272 } }),
		route: json!({ "faction": "Alliance", "start": "Gnome", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 10.0, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 1, "lvl": 10.5, "pt": 1, "from": f("a", 16), "items": [{ "t": "network", "from": 0, "to": 1, "legs": [{ "k": "walk", "to": 1 }] }] }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = pick(&run(&c, None).read("a"), r"^step|^\s+(hearth|accept|turnin|goto)");
	let a7 = g.iter().position(|l| l.starts_with("  accept 7")).unwrap_or_else(|| panic!("{g:#?}")) as i64;
	let leg = g.iter().position(|l| l.contains("\"Ironforge\"")).unwrap_or_else(|| panic!("{g:#?}")) as i64;
	assert!(leg < a7 && a7 < idx(&g, "  turnin 1"), "{g:#?}");
}

#[test]
fn a_class_run_of_steps_stays_together() {
	// c15 Alliance 03-darkshore (Rev15A1, Rev15SkyA): the Druids' Cat Form block (Darnassus, Moonglade,
	// back) was split around the route's Stormwind boat: its first step before, the rest after. The run
	// stays together at its first step's place.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 18-21",
				"zone Darkshore",
				"",
				"step Auberdine",
				"  accept 1",
				"",
				"step Cat Spirit",
				"  only Druid",
				"  zone Darnassus",
				"  accept 8",
				"",
				"step Dendrite",
				"  only Druid",
				"  zone Moonglade",
				"  turnin 8",
				"  accept 9",
				"",
				"step Stormwind",
				"  zone Stormwind City",
				"  turnin 1",
				"",
			],
		)],
		world: json!({
			"points": [[1, 0, 0, 0, 1439], [0, 0, 0, 0, 1453], [1, 0, -2000, 1000, 1457], [1, 0, 2000, 3000, 1450]],
			"zones": { "1439": "Darkshore", "1453": "Stormwind City", "1457": "Darnassus", "1450": "Moonglade" },
			"quests": [{ "id": 1, "giver": 0, "ender": 1 }, { "id": 8, "giver": 2, "ender": 3 }, { "id": 9, "giver": 3, "ender": 3 }]
		}),
		frames: json!({ "era": {
			"1439": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 1 }, "1453": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 },
			"1457": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 1 }, "1450": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 1 }
		} }),
		route: json!({ "faction": "Alliance", "start": "NightElf", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 19.0, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 1, "lvl": 19.5, "pt": 1, "from": f("a", 21) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = pick(&run(&c, None).read("a"), r"^step|^\s+(accept|turnin)");
	let (a8, t8, t1) = (idx(&g, "  accept 8"), idx(&g, "  turnin 8"), idx(&g, "  turnin 1"));
	assert!(a8 >= 0 && a8 < t8 && (t8 < t1 || a8 > t1), "{g:#?}");
}

#[test]
fn a_class_step_closes_a_town_visit_past_an_in_town_leg() {
	// c15 Horde 30-40/03-arathi (FlowWriter): Shady Rest's 1269, 1268 and 1251 in one go, with the
	// Warriors' Affray (the Barrens) written between 1268 and 1251, the last with a few yards' walk in
	// town. The class step goes after the visit.
	let a = vec![
		"guide t/a",
		"title A",
		"levels 1-5",
		"zone Tirisfal Glades",
		"",
		"step One",
		"  accept 1",
		"",
		"step Affray",
		"  only Warrior",
		"  accept 9",
		"",
		"step Two",
		"  accept 2",
		"",
		"step Three",
		"  accept 3",
		"",
	];
	let c = Case {
		files: vec![("a", a)],
		world: town_world(json!([{ "id": 9, "giver": 4, "ender": 4 }])),
		quests: json!({ "1": { "title": "One", "minLevel": 1 }, "2": { "title": "Two", "minLevel": 1 }, "3": { "title": "Three", "minLevel": 1 }, "9": { "title": "Nine", "minLevel": 1, "classes": 1 } }),
		frames: town_frames(),
		route: json!({ "faction": "Horde", "start": "Undead", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 1, "lvl": 1.0, "from": f("a", 7) },
			{ "t": "accept", "q": 2, "pt": 2, "lvl": 1.0, "from": f("a", 14), "items": [{ "t": "network", "from": 1, "to": 2, "legs": [{ "k": "walk", "to": 2 }] }] },
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
fn a_class_step_in_a_zone_the_walk_crosses_is_done_at_the_crossing() {
	// c15 Alliance 07-thousand-needles (C14Plan): the Warlocks' Takar the Seer in the Barrens, which the
	// route's walk from Theramore to Thousand Needles crosses, was written as a trip back from the
	// Mirage Raceway via Stonetalon. It is done on the walk, after its crossing into the Barrens.
	use forge_world::world::{Crossing, Crossings};
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Human,Dwarf,Gnome,NightElf,Skyborne",
				"levels 28-30",
				"zone Felwood",
				"",
				"step Start",
				"  accept 1",
				"",
				"step Takar the Seer",
				"  only Warlock",
				"  zone Winterspring",
				"  turnin 9",
				"",
				"step End",
				"  zone Moonglade",
				"  turnin 1",
				"",
			],
		)],
		world: json!({
			"points": [[1, 1, 800, -500, 1448], [1, 1, 800, 1500, 1450], [1, 1, -700, 300, 1452]],
			"zones": { "1448": "Felwood", "1452": "Winterspring", "1450": "Moonglade" },
			"quests": [{ "id": 1, "giver": 0, "ender": 1 }, { "id": 9, "giver": 2, "ender": 2 }]
		}),
		frames: json!({ "era": {
			"1448": { "top": 3000, "bottom": -3000, "left": -3000, "right": 3000, "c": 1 }, "1452": { "top": 3000, "bottom": -3000, "left": -3000, "right": 3000, "c": 1 },
			"1450": { "top": 3000, "bottom": -3000, "left": -3000, "right": 3000, "c": 1 }
		} }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 29.0, "pt": 0, "from": f("a", 8) },
			{ "t": "turnin", "q": 1, "lvl": 29.5, "pt": 1, "from": f("a", 17), "items": [{ "t": "network", "from": 0, "to": 1, "legs": [{ "k": "walk", "to": 1 }] }] }
		] }),
		route_travel: true,
		crossings: Some(Crossings {
			ways: vec![
				Crossing { id: "felwood--winterspring".into(), c: 1, a: (1448, -800.0, -10.0, 30.0), b: (1452, -800.0, 10.0, 30.0), one_way: false },
				Crossing { id: "winterspring--moonglade".into(), c: 1, a: (1452, -800.0, 990.0, 30.0), b: (1450, -800.0, 1010.0, 30.0), one_way: false },
			],
			open: Vec::new(),
		}),
		..Case::default()
	};
	let g = pick(&run(&c, None).read("a"), r"^step|^\s+(accept|turnin)");
	let (into_w, t9, into_m, t1) = (idx(&g, "step Into Winterspring"), idx(&g, "  turnin 9"), idx(&g, "step Into Moonglade"), idx(&g, "  turnin 1"));
	assert!(into_w >= 0 && into_w < t9 && t9 < into_m && into_m < t1, "{g:#?}");
}

#[test]
fn a_class_step_in_town_goes_after_the_step_that_leaves_by_tram() {
	// c15 Dwarf 01-dun-morogh (dup-trip): the Paladins' Ironforge steps were written before "The
	// Deeprun Tram" (flight path, training, Magni), sending them back to Gryth for the flight path.
	// They go after that step's work, the tram goto a step of its own after them.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-12",
				"zone Ironforge",
				"",
				"step Arrive",
				"  accept 1",
				"",
				"step Muiredon",
				"  only Paladin",
				"  turnin 9",
				"",
				"step The Deeprun Tram",
				"  turnin 1",
				"  goto 78.0,51.4 \"Deeprun Tram\"",
				"",
				"step Stormwind",
				"  zone Stormwind City",
				"  accept 2",
				"",
			],
		)],
		world: json!({
			"points": [[1, 0, 0, 0, 1537], [1, 0, 100, 100, 1537], [1, 0, 50, 0, 1537], [0, 0, 0, 0, 1453]],
			"zones": { "1537": "Ironforge", "1453": "Stormwind City" },
			"quests": [{ "id": 1, "giver": 0, "ender": 2 }, { "id": 2, "giver": 3, "ender": 3 }, { "id": 9, "giver": 1, "ender": 1 }]
		}),
		frames: json!({ "era": {
			"1537": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 1 }, "1453": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }
		} }),
		route: json!({ "faction": "Alliance", "start": "Dwarf", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 11.0, "pt": 0, "from": f("a", 7) },
			{ "t": "turnin", "q": 1, "lvl": 11.5, "pt": 2, "from": f("a", 14) },
			{ "t": "accept", "q": 2, "lvl": 12.0, "pt": 3, "from": f("a", 19) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = pick(&run(&c, None).read("a"), r"^step|^\s+(accept|turnin|goto)");
	let (t1, t9, tram) = (idx(&g, "  turnin 1"), idx(&g, "  turnin 9"), idx(&g, "  goto 78.0,51.4 \"Deeprun Tram\""));
	assert!(t1 >= 0 && t1 < t9 && t9 < tram, "{g:#?}");
}

#[test]
fn a_class_step_after_the_routes_last_v1_line_stays_before_its_added_quests() {
	// c15 Alliance 04-redridge (Rev15A1 B1): the Shamans' Ironforge step, v1's right after the Stormwind
	// stop, was written after Theocritus in Elwynn, a quest the route adds there: east Elwynn, back to
	// Stormwind, the tram, Ironforge. It stays right after the Stormwind stop.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 18-21",
				"zone Stormwind City",
				"",
				"step Stormwind",
				"  accept 1",
				"",
				"step Shaman quest",
				"  only Shaman",
				"  zone Ironforge",
				"  accept 9",
				"",
				"step Three Corners",
				"  zone Redridge Mountains",
				"  accept 2",
				"",
			],
		)],
		world: json!({
			"points": [[1, 0, 0, 0, 1453], [1, 0, 3000, 0, 1537], [1, 0, 0, 1500, 1429], [1, 0, 0, 3000, 44]],
			"zones": { "1453": "Stormwind City", "1537": "Ironforge", "1429": "Elwynn Forest", "44": "Redridge Mountains" },
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 2, "giver": 3, "ender": 3 }, { "id": 9, "giver": 1, "ender": 1 }, { "id": 94, "giver": 2, "ender": 2, "objs": [] }]
		}),
		quests: json!({ "94": { "title": "A Watchful Eye" }, "9": { "title": "Nine", "classes": 64 } }),
		frames: json!({ "era": {
			"1453": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 1 }, "1537": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 1 },
			"1429": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 1 }, "44": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 1 }
		} }),
		route: json!({ "faction": "Alliance", "start": "Dwarf", "diff": { "added": [94] }, "order": [
			{ "t": "accept", "q": 1, "lvl": 19.0, "pt": 0, "from": f("a", 7) },
			{ "t": "accept", "q": 94, "lvl": 19.2, "pt": 2, "from": "inserted" },
			{ "t": "accept", "q": 2, "lvl": 19.5, "pt": 3, "from": f("a", 16) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = pick(&run(&c, None).read("a"), r"^step|^\s+(accept|turnin)");
	let (a1, t9, a94) = (idx(&g, "  accept 1"), idx(&g, "  accept 9"), idx(&g, "  accept 94"));
	assert!(a1 >= 0 && a1 < t9 && t9 < a94, "{g:#?}");
}

#[test]
fn a_class_off_in_a_city_with_its_trainer_trains_there_not_at_the_routes_stop() {
	// c15 Alliance 05-duskwood (Rev15A1 B4): the Rogues, off to Shaw in Stormwind, were walked to the
	// route's Goldshire training and back to Stormwind for the boat. A class off in a city with its
	// trainer trains there; the route's way to its stop and its training line leave it out.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 10-12",
				"zone Durotar",
				"",
				"step Hub",
				"  accept 1",
				"",
				"step Thrall",
				"  only Warrior",
				"  fly \"Orgrimmar\"",
				"  accept 9",
				"",
				"step Camp",
				"  turnin 1 only Mage",
				"",
				"step Far",
				"  accept 2",
				"",
			],
		)],
		world: json!({
			"points": [[1, 1, 0, 0, 1411], [1, 1, 3000, 3000, 1411], [1, 1, -2000, -2000, 1454], [1, 1, 10, 10, 1411]],
			"zones": { "1411": "Durotar", "1454": "Orgrimmar" }, "quests": [{ "id": 9, "giver": 2, "ender": 2 }, { "id": 2, "giver": 1, "ender": 1 }],
			"nodes": [{ "kind": "fp", "name": "Orgrimmar", "pt": 2 }, { "kind": "fp", "name": "Razor Hill", "pt": 3 }]
		}),
		frames: json!({ "era": { "1411": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 1 }, "1454": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 1 } } }),
		npcs: json!({
			"3353": { "name": "Grezz", "subName": "Warrior Trainer", "faction": "H", "spawns": { "1454": { "f": "e", "pts": [[50, 50]] } } },
			"3169": { "name": "Tarshaw", "subName": "Warrior Trainer", "faction": "H", "spawns": { "1411": { "f": "e", "pts": [[75, 75]] } } }
		}),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 10.0, "pt": 0, "from": f("a", 7), "items": [{ "t": "getfp", "node": 1 }, { "t": "getfp", "node": 0 }] },
			{ "t": "turnin", "q": 1, "lvl": 10.1, "pt": 0, "from": f("a", 15) },
			{ "t": "train", "lvl": 10.2, "pt": 1, "from": "train stop", "items": [{ "t": "network", "from": 0, "to": 1 }] },
			{ "t": "accept", "q": 2, "lvl": 10.3, "pt": 1, "from": f("a", 18) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let a9 = idx(&g, "  accept 9");
	let own = (a9.max(0) as usize..g.len()).find(|&i| g[i] == "  train class" && g[..i].iter().rev().find(|l| l.starts_with("  only ")).is_some_and(|l| l == "  only Warrior"));
	let stop = g.iter().rfind(|l| m(l, r"^\s+train class\b"));
	assert!(a9 >= 0 && own.is_some() && stop.is_some_and(|l| l.contains(" only ") && !l.contains("Warrior")), "{g:#?}");
}

#[test]
fn a_city_trainer_a_few_hundred_yards_from_the_stop_counts_as_there() {
	// c15 Orc: Orgrimmar's training stop wrote "train class only Hunter -- Xor'juul in Orgrimmar;
	// Orgrimmar has no hunter trainer", a trip of its own to a trainer 300 yd away in the same city.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 20-22", "zone Orgrimmar", "", "step Org", "  accept 1", "", "step Later", "  turnin 1", ""])],
		world: json!({ "points": [[0, 0, 0, 0, 1454], [0, 0, -800, 800, 1454]], "zones": { "1454": "Orgrimmar" }, "quests": [] }),
		frames: json!({ "era": { "1454": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"3169": { "name": "Tarshaw", "subName": "Warrior Trainer", "faction": "H", "spawns": { "1454": { "f": "e", "pts": [[50, 50]] } } },
			"3352": { "name": "Ormak", "subName": "Hunter Trainer", "faction": "H", "spawns": { "1454": { "f": "e", "pts": [[65, 50]] } } }
		}),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 20.0, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "lvl": 20.0, "pt": 0, "from": "train stop" },
			{ "t": "turnin", "q": 1, "lvl": 21.0, "pt": 1, "from": f("a", 10) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(idx(&g, "step Hunter trainer") < 0 && g.iter().any(|l| m(l, r"^\s+train class\b") && (!l.contains(" only ") || l.contains("Hunter"))), "{g:#?}");
}

#[test]
fn a_class_whose_trainer_the_way_to_the_stop_passes_trains_there_before_the_way_leaves_town() {
	// #912, Night Elf 02-darkshore: the boat lands in Stormwind Harbor, a few hundred yards from its
	// Druid trainers, and the route walks on to its Goldshire training, which has none: the Druids were
	// sent back from Goldshire to Stormwind and back. They train in Stormwind, before the walk out.
	let mut c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 12-14", "zone Darkshore", "", "step Hub", "  accept 1", "", "step Later", "  accept 2", ""])],
		world: json!({
			"points": [[0, 1, 0, 0, 1439], [0, 1, 0, 3000, 1453], [0, 1, 0, 3800, 1453], [0, 1, 0, 5000, 1429], [0, 1, 100, 5000, 1429]],
			"zones": { "1439": "Darkshore", "1453": "Stormwind City", "1429": "Elwynn Forest" }, "quests": []
		}),
		frames: json!({ "era": {
			"1439": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 },
			"1453": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 },
			"1429": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 }
		} }),
		npcs: json!({
			"5504": { "name": "Sheldras Moontree", "subName": "Druid Trainer", "faction": "A", "spawns": { "1453": { "f": "e", "pts": [[76.67, 50]] } } },
			"911": { "name": "Llane Beshere", "subName": "Warrior Trainer", "faction": "A", "spawns": { "1429": { "f": "e", "pts": [[91.67, 50]] } } }
		}),
		route: json!({ "faction": "Alliance", "start": "NightElf", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 12.0, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "lvl": 12.2, "pt": 3, "from": "train stop", "items": [{ "t": "network", "from": 0, "to": 3, "legs": [{ "k": "walk", "to": 1 }, { "k": "walk", "to": 2 }, { "k": "walk", "to": 3 }] }] },
			{ "t": "accept", "q": 2, "lvl": 12.3, "pt": 4, "from": f("a", 10) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let druid = idx(&g, "step Druid trainer");
	let into_elwynn = g.iter().position(|l| m(l, r#"^\s+goto .*"Elwynn Forest""#)).map_or(-1, |i| i as i64);
	let stop = idx(&g, "step Class trainer");
	assert!(druid >= 0 && into_elwynn > druid && stop > into_elwynn, "{g:#?}");
	assert!(g[druid as usize..].iter().take_while(|l| !l.is_empty()).any(|l| l == "  zone Stormwind City"), "{g:#?}");
	assert_eq!(g.iter().filter(|l| m(l, r"^\s+train class only Druid\b")).count(), 1, "{g:#?}");
	assert!(g.iter().any(|l| l.starts_with("  train class only Druid -- Sheldras Moontree in Stormwind City")), "{g:#?}");
	// (A trainer in another town nearer the stop, named by the stop's line: the line names the town's.)
	c.world["zones"]["1436"] = json!("Westfall");
	c.frames["era"]["1436"] = json!({ "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 });
	c.npcs["542"] = json!({ "name": "Califex", "subName": "Druid Trainer", "faction": "A", "spawns": { "1436": { "f": "e", "pts": [[100, 41.67]] } } });
	let g = run(&c, None).read("a");
	assert!(g.iter().any(|l| l == "  train class only Druid -- Sheldras Moontree in Stormwind City; Elwynn Forest has no druid trainer"), "{g:#?}");
	// (A trainer 600 yd from where the way stands in the town: the Druids train after the stop, as before.)
	c.npcs.as_object_mut().unwrap().remove("542");
	c.npcs["5504"]["spawns"]["1453"]["pts"] = json!([[76.67, 45]]);
	let g = run(&c, None).read("a");
	assert!(idx(&g, "step Druid trainer") > idx(&g, "step Class trainer") && idx(&g, "step Class trainer") >= 0, "{g:#?}");
}

#[test]
fn a_class_trainer_in_a_citys_live_frame_counts_as_its_nearest() {
	// #912: the Goldshire stop's Druids were sent to Alfina Nightgaze in Alterac, past Stormwind's Druid
	// trainers, whose spawns are on the city's live frame.
	let c = Case {
		files: vec![("a", vec!["guide t/a", "title A", "levels 12-14", "zone Elwynn Forest", "", "step Hub", "  accept 1", "", "step Later", "  accept 2", ""])],
		world: json!({
			"points": [[0, 1, 0, 5000, 1429], [0, 1, 100, 5000, 1429]],
			"zones": { "1453": "Stormwind City", "1429": "Elwynn Forest", "1416": "Alterac Mountains" }, "quests": []
		}),
		frames: json!({
			"era": {
				"1429": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 },
				"1416": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 }
			},
			"forever": { "1453": { "top": 6000, "bottom": -6000, "left": -6000, "right": 6000, "c": 0 } }
		}),
		npcs: json!({
			"5504": { "name": "Sheldras Moontree", "subName": "Druid Trainer", "faction": "A", "spawns": { "1453": { "f": "l", "pts": [[81.67, 50]] } } },
			"270459": { "name": "Alfina Nightgaze", "subName": "Druid Trainer", "faction": "A", "spawns": { "1416": { "f": "e", "pts": [[91.67, 25]] } } },
			"911": { "name": "Llane Beshere", "subName": "Warrior Trainer", "faction": "A", "spawns": { "1429": { "f": "e", "pts": [[91.67, 50]] } } }
		}),
		route: json!({ "faction": "Alliance", "start": "NightElf", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 12.0, "pt": 0, "from": f("a", 7) },
			{ "t": "train", "lvl": 12.2, "pt": 0, "from": "train stop" },
			{ "t": "accept", "q": 2, "lvl": 12.3, "pt": 1, "from": f("a", 10) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(g.iter().any(|l| l.starts_with("  train class only Druid -- Sheldras Moontree in Stormwind City")), "{g:#?}");
}

#[test]
fn a_class_step_closing_a_guide_stays_after_its_last_named_step() {
	// c15 Alliance 50-60 (Rev15A2 A5): the Druids' Darnassus training closing 01-burning-steppes, after
	// Rut'theran Village, was written in Felwood after the Emerald Sanctuary, at the route's later take of
	// 02-felwood's first step. It stays at the end of its guide, after Rut'theran.
	let c = Case {
		files: vec![
			(
				"a",
				vec![
					"guide t/a",
					"title A",
					"levels 50-52",
					"zone Durotar",
					"next t/b",
					"",
					"step Hub",
					"  accept 1",
					"",
					"step Druid training",
					"  only Druid",
					"  zone Thunder Bluff",
					"  train class",
					"",
				],
			),
			("b", vec!["guide t/b", "title B", "levels 52-54", "zone The Barrens", "", "step Grazle", "  accept 3", "", "step Sanctuary", "  accept 4", ""]),
		],
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 400, 400, 1413]], "zones": { "1411": "Durotar", "1413": "The Barrens", "1638": "Thunder Bluff" }, "quests": [] }),
		route: json!({ "faction": "Horde", "start": "Orc", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "lvl": 52.0, "pt": 0, "from": f("a", 8) },
			{ "t": "accept", "q": 4, "lvl": 52.5, "pt": 1, "from": f("b", 10) },
			{ "t": "accept", "q": 3, "lvl": 52.6, "pt": 1, "from": f("b", 7) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let r = run(&c, None);
	let a = r.read("a");
	assert!(a.iter().any(|l| l == "step Druid training") && !r.read("b").iter().any(|l| l == "step Druid training"), "{a:#?}\n{:#?}", r.read("b"));
}

#[test]
fn v1s_training_with_other_quests_taken_elsewhere_trains_at_the_routes_city_for_its_classes() {
	// c15 Alliance 50-60/05-silithus (Rev15A2 B1): the route trains in Stormwind for v1's "Ironforge – Take
	// the Deeprun Tram" step, whose cloth donations it takes at a later Ironforge stop: the step was
	// written in Ironforge before the Stormwind turn-ins. It is a Stormwind training, without the
	// Shamans, who have no trainer there.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 57-58",
				"zone Stormwind City",
				"",
				"step Ironforge",
				"  zone Ironforge",
				"  tip Take the Deeprun Tram to Ironforge.",
				"  train class only Warrior,Shaman",
				"  accept 7 optional",
				"",
				"step Stormwind City",
				"  zone Stormwind City",
				"  accept 1",
				"",
				"step Ironforge again",
				"  zone Ironforge",
				"  accept 7 optional",
				"",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1453], [0, 0, 8000, 0, 1455]], "zones": { "1453": "Stormwind City", "1455": "Ironforge" }, "quests": [] }),
		frames: json!({ "era": { "1453": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 }, "1455": { "top": 9000, "bottom": 7000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"5479": { "name": "Wu Shen", "subName": "Warrior Trainer", "faction": "A", "spawns": { "1453": { "f": "e", "pts": [[50, 50]] } } },
			"258098": { "name": "Eldrun Stormbreaker", "subName": "Shaman Trainer", "faction": "A", "spawns": { "1455": { "f": "e", "pts": [[50, 50]] } } }
		}),
		route: json!({ "faction": "Alliance", "start": "Dwarf", "diff": {}, "order": [
			{ "t": "train", "lvl": 57.9, "pt": 0, "from": f("a", 9) },
			{ "t": "accept", "q": 1, "lvl": 58.0, "pt": 0, "from": f("a", 14) },
			{ "t": "accept", "q": 7, "lvl": 58.2, "pt": 1, "from": f("a", 18) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let t = g.iter().position(|l| m(l, r"^\s+train class")).unwrap_or_else(|| panic!("{g:#?}"));
	let step = g[..t].iter().rev().find(|l| l.starts_with("step ")).unwrap();
	assert!(step == "step Class trainer" && g[t].contains("only Warrior") && !g[t].contains("Shaman") && (t as i64) < idx(&g, "  accept 1"), "{g:#?}");
}

/// c19r's Valley of Trials as the route wrote it: the loop, back to the Den, the Burning Blade Coven
/// (300 yd north of Hana'zua), then back to Hana'zua for Sarkoth's hand-in and 804. `hana`: where
/// Hana'zua stands; `sarkoth`: the spots its claw drops at (Sarkoth's one, or a spread camp).
fn valley_trip_case(hana: [f64; 2], sarkoth: Value) -> Case {
	let lines = vec![
		"guide t/a",
		"title A",
		"levels 1-6",
		"zone Durotar",
		"",
		"step Den",
		"  accept 789",
		"  accept 4402",
		"  accept 792",
		"",
		"step Hana'zua",
		"  accept 790",
		"",
		"step Sarkoth",
		"  collect 4905 quest 790.1",
		"",
		"step Scorpid Workers",
		"  collect 4862 quest 789.1",
		"",
		"step Cactus Apples",
		"  collect 11583 quest 4402.1",
		"",
		"step Vile Familiars",
		"  kill 3101 quest 792.1",
		"",
		"step Back to the Den",
		"  turnin 789",
		"  turnin 4402",
		"  turnin 792",
		"  accept 794",
		"",
		"step Burning Blade Coven",
		"  kill 3198 quest 794.1",
		"",
		"step Hana'zua again",
		"  turnin 790",
		"  accept 804",
		"",
		"step Den again",
		"  turnin 794",
		"  turnin 804",
		"",
	];
	let at = |l: &str| f("a", lines.iter().rposition(|x| *x == l).unwrap() as u32 + 1);
	// (Points: 0 the valley floor at 50,50; 1 the Den, 60,50; 2 the Coven, 52,35; 3 Hana'zua.)
	let ev = |t: &str, q: u32, pt: u32, l: &str| if t == "task" { json!({ "t": t, "q": q, "task": 0, "pt": pt, "from": at(l) }) } else { json!({ "t": t, "q": q, "pt": pt, "from": at(l) }) };
	let order = vec![
		ev("accept", 789, 1, "  accept 789"),
		ev("accept", 4402, 1, "  accept 4402"),
		ev("accept", 792, 1, "  accept 792"),
		ev("accept", 790, 3, "  accept 790"),
		ev("task", 790, 0, "  collect 4905 quest 790.1"),
		ev("task", 789, 0, "  collect 4862 quest 789.1"),
		ev("task", 4402, 0, "  collect 11583 quest 4402.1"),
		ev("task", 792, 0, "  kill 3101 quest 792.1"),
		ev("turnin", 789, 1, "  turnin 789"),
		ev("turnin", 4402, 1, "  turnin 4402"),
		ev("turnin", 792, 1, "  turnin 792"),
		ev("accept", 794, 1, "  accept 794"),
		ev("task", 794, 2, "  kill 3198 quest 794.1"),
		ev("turnin", 790, 3, "  turnin 790"),
		ev("accept", 804, 3, "  accept 804"),
		ev("turnin", 794, 1, "  turnin 794"),
		ev("turnin", 804, 1, "  turnin 804"),
	];
	let w = |x: f64, y: f64| json!([1, 0, 1000.0 - 20.0 * y, -1000.0 + 20.0 * x, 1411]);
	let pt_of = |q: u32, end: bool| if q == 790 || (q == 804 && !end) { 3 } else { 1 };
	let quests: Vec<Value> = [789, 4402, 792, 790, 804, 794].iter().map(|&q| json!({ "id": q, "giver": pt_of(q, false), "ender": pt_of(q, true) })).collect();
	let npc = |name: &str, pts: Value| json!({ "name": name, "level": 3, "spawns": { "1411": { "f": "e", "pts": pts } } });
	let gornek = json!({ "npc": [3143] });
	Case {
		route: json!({ "diff": {}, "order": order }),
		files: vec![("a", lines)],
		world: json!({ "points": [w(50.0, 50.0), w(60.0, 50.0), w(52.0, 35.0), w(hana[0], hana[1])], "zones": { "1411": "Durotar" }, "quests": quests }),
		npcs: json!({
			"3287": npc("Hana'zua", json!([hana])),
			"3143": npc("Gornek", json!([[60, 50]])),
			"3124": npc("Scorpid Worker", json!([[51, 52], [52, 52], [51, 53]])),
			"3281": npc("Sarkoth", sarkoth),
			"3101": npc("Vile Familiar", json!([[51, 45], [52, 44], [53, 45]])),
			"3198": npc("Burning Blade Apprentice", json!([[52, 35], [53, 35], [52, 34]]))
		}),
		objects: json!({ "171938": { "name": "Cactus Apple", "spawns": { "1411": { "f": "e", "pts": [[54, 53], [55, 53], [54, 54]] } } } }),
		items: json!({
			"4905": { "name": "Sarkoth's Mangled Claw", "drops": { "npc": { "3281": 100 } } },
			"4862": { "name": "Scorpid Worker Tail", "drops": { "npc": { "3124": 50 } } },
			"11583": { "name": "Cactus Apple", "drops": { "object": { "171938": 100 } } }
		}),
		quests: json!({
			"789": { "title": "Sting of the Scorpid", "start": gornek, "end": gornek },
			"4402": { "title": "Galgar's Cactus Apple Surprise", "start": gornek, "end": gornek },
			"792": { "title": "Vile Familiars", "start": gornek, "end": gornek },
			"794": { "title": "Burning Blade Medallion", "start": gornek, "end": gornek },
			"790": { "title": "Sarkoth", "start": { "npc": [3287] }, "end": { "npc": [3287] } },
			"804": { "title": "Sarkoth", "start": { "npc": [3287] }, "end": gornek, "pre": [790] }
		}),
		route_travel: true,
		..Case::default()
	}
}

/// The goal lines of a step's lines.
fn goal_lines(b: &[String]) -> Vec<String> {
	b.iter().filter(|l| m(l, r"^\s+(collect|kill|turnin|accept)\s")).cloned().collect()
}

#[test]
fn a_hand_in_the_walk_comes_back_for_goes_into_the_loop_when_its_npc_is_on_the_way() {
	// Fitz, c19r Durotar: Sarkoth's hand-in at Hana'zua was written after the Burning Blade Coven, a
	// trip back; Hana'zua is on the loop's way from Sarkoth to the familiars (Sarkoth -> Hana'zua 150 yd
	// -> familiars 102 yd, against 251 yd straight on: a 1 yd detour here). The valley loop as shipped
	// by hand on talents-soon: scorpids, cactus apples, Sarkoth, Hana'zua's hand-in and 804, familiars.
	let g = run(&valley_trip_case([50.0, 50.0], json!([[50, 57.5]])), None).read("a");
	let b = area_step(&g);
	assert_eq!(goal_lines(&b), vec!["  collect 4862 quest 789.1", "  collect 11583 quest 4402.1", "  collect 4905 quest 790.1", "  turnin 790", "  accept 804", "  kill 3101 quest 792.1"], "{g:#?}");
	// (The trip back is gone; the Den, which the route passes anyway after the loop, keeps its hand-ins.)
	assert_eq!(g.iter().filter(|l| *l == "  turnin 790").count(), 1, "{g:#?}");
	assert!(!has(&g, "step Hana'zua again"), "{g:#?}");
	assert!(idx(&g, "  turnin 789") > idx(&g, &b[0]) + b.len() as i64 - 1, "{g:#?}");
	// (804, taken in the loop now, is handed in to Gornek on the Den return right after it, not after
	// the Coven: no left-ready hand-in at the Den.)
	let den = idx(&g, "step Back to the Den");
	let t804 = idx(&g, "  turnin 804");
	assert!(den < t804 && t804 < idx(&g, "step Burning Blade Coven"), "{g:#?}");
}

#[test]
fn a_hand_in_whose_npc_is_near_but_behind_the_loops_way_stays_where_it_is() {
	// Hana'zua 130 yd from Sarkoth but behind the way the loop goes on (to the scorpids): a 230 yd
	// detour, so the hand-in stays on its own stop (no ping-pong inside the loop).
	let g = run(&valley_trip_case([44.0, 60.0], json!([[50, 57.5]])), None).read("a");
	let b = area_step(&g);
	assert!(!goal_lines(&b).iter().any(|l| l == "  turnin 790"), "{g:#?}");
	assert!(has(&g, "  turnin 790"), "{g:#?}");
}

#[test]
fn a_hand_in_after_a_spread_camp_stays_unless_its_npc_is_on_the_way_from_every_spot() {
	// Fitz: the finish point must be predictable. The claw from a camp spread from Sarkoth's slope east
	// to 62,48: Hana'zua is on the way north from the slope (1 yd) but 170 yd out of the way from the
	// east end, so where the last claw drops decides it: the hand-in stays where it is.
	let g = run(&valley_trip_case([50.0, 50.0], json!([[50, 57.5], [60, 52], [62, 48]])), None).read("a");
	let b = area_step(&g);
	assert!(!goal_lines(&b).iter().any(|l| l == "  turnin 790"), "{g:#?}");
	assert!(has(&g, "  turnin 790"), "{g:#?}");
}

#[test]
fn a_step_never_lists_the_same_goal_twice() {
	// #843, Dun Morogh's "Brewnall Village": v1's optional "on the way" kills for Rejold and the
	// required kills the route works right there came into one step: the boars and the leopards twice.
	// One line each: required, with its own note, else the optional copy's.
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"levels 5-8",
				"zone Durotar",
				"",
				"step Brewnall Village",
				"  accept 319",
				"  kill 1196 quest 319 optional                -- Ice Claw Bear, on the way to the Hold",
				"  kill 1127 quest 319 optional                -- Elder Crag Boar, on the way",
				"  kill 1201 quest 319 optional                -- Snow Leopard, on the way",
				"",
				"step Brewnall Village",
				"  accept 310",
				"  kill 1127 quest 319",
				"  kill 1201 quest 319                         -- Snow Leopard",
				"",
				"step Rejold Barleybrew",
				"  turnin 319",
				"  turnin 310",
				"",
			],
		)],
		// (Rejold and Marleth stand together: givers at points 0 and 1, 10 yd apart.)
		world: json!({ "points": [[1, 1, 0, 0, 1411], [1, 1, 10, 0, 1411], [1, 1, 900, 900, 1411]], "zones": { "1411": "Durotar" }, "quests": [
			{ "id": 319, "giver": 0, "ender": 2, "objs": [{ "oi": 0, "type": "kill", "id": 1196, "task": 0 }, { "oi": 1, "type": "kill", "id": 1127, "task": 1 }, { "oi": 2, "type": "kill", "id": 1201, "task": 2 }] },
			{ "id": 310, "giver": 1, "ender": 2 }
		] }),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 319, "from": f("a", 7) },
			{ "t": "task", "q": 319, "task": 0, "from": f("a", 8) },
			{ "t": "accept", "q": 310, "from": f("a", 13) },
			{ "t": "task", "q": 319, "task": 1, "from": f("a", 14) },
			{ "t": "task", "q": 319, "task": 2, "from": f("a", 15) },
			{ "t": "turnin", "q": 319, "from": f("a", 18) },
			{ "t": "turnin", "q": 310, "from": f("a", 19) }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	// (Each kill once in each step.)
	let mut step = "";
	let mut seen: Vec<(&str, &str)> = Vec::new();
	for l in &g {
		if l.starts_with("step ") {
			step = l;
		} else if let Some(k) = l.strip_prefix("  kill ") {
			let id = k.split_whitespace().next().unwrap_or("");
			assert!(!seen.contains(&(step, id)), "kill {id} twice in {step}: {g:#?}");
			seen.push((step, id));
		}
	}
	assert!(has(&g, "  kill 1127 quest 319                         -- Elder Crag Boar, on the way"), "{g:#?}");
	assert!(has(&g, "  kill 1201 quest 319                         -- Snow Leopard"), "{g:#?}");
}

#[test]
fn a_flight_path_step_in_the_zone_the_player_stands_in_is_not_reached_by_hearthing_out_and_back() {
	// Silithus guide, Moonglade (found by Fitz): the route's way from Umber to Rut'theran Village is the
	// hearth to Cenarion Hold and its flight (it never learns Nighthaven's flight path), but v1's
	// Nighthaven step, 600 yd from Umber in the same zone, learns that flight path and flies on. The
	// guide went Umber, hearth to Silithus, fly to Rut'theran, back into Moonglade for the flight path,
	// fly to Rut'theran. The Nighthaven step comes right after Umber and its flight is the way on.
	let world = json!({
		"points": [
			[1, 1, 0, 0, 1450], [1, 1, 0, 600, 1450],
			[1, 1, 5000, -6000, 1451], [1, 1, 5010, -6000, 1451],
			[1, 1, -6000, 3000, 1438], [1, 1, -6010, 3010, 1438],
			[1, 1, -5000, 2000, 1439]
		],
		"zones": { "1450": "Moonglade", "1451": "Silithus", "1438": "Teldrassil", "1439": "Darkshore" }, "quests": [],
		"inns": [{ "name": "Cenarion Hold", "pt": 2 }],
		"nodes": [
			{ "kind": "fp", "name": "Cenarion Hold", "pt": 3 }, { "kind": "fp", "name": "Rut'theran Village", "pt": 4 },
			{ "kind": "fp", "name": "Moonglade", "pt": 1 }, { "kind": "fp", "name": "Auberdine", "pt": 6 }
		]
	});
	let frame = json!({ "top": 10000, "bottom": -10000, "left": -10000, "right": 10000, "c": 1 });
	let frames = json!({ "era": { "1450": frame, "1451": frame, "1438": frame, "1439": frame } });
	let c = Case {
		files: vec![(
			"a",
			vec![
				"guide t/a",
				"title A",
				"race Human,Dwarf,Gnome,NightElf,Skyborne",
				"levels 58-60",
				"zone Silithus",
				"",
				"step Cenarion Hold",
				"  sethome \"Cenarion Hold\"",
				"  accept 3",
				"",
				"step Umber",
				"  zone Moonglade",
				"  accept 1",
				"  turnin 1",
				"",
				"step Nighthaven",
				"  getfp \"Moonglade\"",
				"  fly \"Auberdine\"",
				"",
				"step Rut'theran Village",
				"  zone Teldrassil",
				"  turnin 3",
				"",
			],
		)],
		world,
		frames,
		quests: json!({ "1": { "title": "Umber's" }, "3": { "title": "Erelas'" } }),
		route: json!({ "faction": "Alliance", "start": "Human", "diff": {}, "order": [
			{ "t": "accept", "q": 3, "pt": 2, "from": f("a", 9), "items": [{ "t": "getfp", "node": 1 }, { "t": "getfp", "node": 0 }, { "t": "bind", "inn": 0, "pt": 2, "used": true, "innPt": 2 }] },
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 13) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 14) },
			{ "t": "turnin", "q": 3, "pt": 5, "from": f("a", 22), "items": [
				{ "t": "hearth", "inn": 0, "to": 5, "innPt": 2 },
				{ "t": "network", "from": 2, "to": 5, "legs": [{ "k": "walk", "to": 3, "node": 0 }, { "k": "fly", "from": 0, "to": 1 }, { "k": "walk", "to": 5 }] }
			] }
		] }),
		route_travel: true,
		..Case::default()
	};
	let g = run(&c, None).read("a");
	let (umber, getfp, hand) = (idx(&g, "  turnin 1"), idx(&g, "  getfp \"Moonglade\""), idx(&g, "  turnin 3"));
	assert!(umber >= 0 && getfp > umber && hand > getfp, "{g:#?}");
	// Nothing takes the player out of Moonglade between Umber and Nighthaven's flight path.
	assert!(!g[umber as usize..getfp as usize].iter().any(|l| m(l, r"^\s+(hearth|fly)\s")), "{g:#?}");
	// The flight from Nighthaven is the way on: no hearth, and the one flight after the flight path.
	assert!(!g.iter().any(|l| l.starts_with("  hearth ")), "{g:#?}");
	let fly = pick(&g, r"^\s+fly\s");
	assert_eq!(fly, vec!["  fly \"Rut'theran Village\""], "{g:#?}");
	let flies = idx(&g, "  fly \"Rut'theran Village\"");
	assert!(flies > getfp && flies < hand, "{g:#?}");
}

#[test]
fn a_class_steps_flight_to_the_flight_path_where_they_stand_goes() {
	// Horde 07-ashenvale:229-239: v1's Druid step "fly to Thunder Bluff and train", written after the
	// route's own training in Thunder Bluff, walked the Druids to Tal and flew them to Thunder Bluff.
	// At Orgrimmar's flight master the Shamans' flight there goes, with the tip's sentence sending them
	// on it, and their training stays; from a camp 1,000 yd off, whose nearest flight master it is, the
	// walk there stays and the flight goes (the Barrens' Orgrimmar training after Boulder Lode Mine).
	let c = |at: u32| Case {
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
				"  tip Fly to Orgrimmar to train. Searn Firewarder is in the Valley of Wisdom.",
				"  fly \"Orgrimmar\"",
				"  train class",
				"",
				"step Camp",
				"  turnin 1",
				"",
			],
		)],
		world: {
			let mut w = travel_world();
			w["points"].as_array_mut().unwrap().push(json!([1, 1, -700, -700, 1411]));
			w
		},
		route: json!({ "diff": {}, "order": [
            { "t": "accept", "q": 1, "pt": at, "from": f("a", 7), "items": [{ "t": "getfp", "node": 0 }, { "t": "getfp", "node": 1 }] },
            { "t": "turnin", "q": 1, "pt": at, "from": f("a", 16) }
        ] }),
		route_travel: true,
		..Case::default()
	};
	for at in [2, 4] {
		let t = run(&c(at), None).read("a");
		assert!(!t.iter().any(|l| l.starts_with("  fly ")), "{t:?}");
		assert_eq!(t.iter().any(|l| l.contains("\"Orgrimmar flight master\"")), at == 4, "{t:?}");
		let s = t.iter().position(|l| l == "step Trainer").unwrap_or_else(|| panic!("{t:?}"));
		assert!(t[s + 1..].iter().take_while(|l| !l.starts_with("step ")).any(|l| l == "  train class"), "{t:?}");
		assert!(t.iter().any(|l| l == "  tip Searn Firewarder is in the Valley of Wisdom."), "{t:?}");
	}
}

/// Level fit (#977): a camp of `n` spawns of `npc` around map point (x, y) on 1411.
fn camp(id: u32, name: &str, lo: u32, hi: u32, x: f64, y: f64, n: usize) -> (String, Value) {
	let pts: Vec<Value> = (0..n).map(|i| json!([x + 0.5 * ((i % 3) as f64 - 1.0), y + 0.5 * ((i / 3) as f64 - 1.0)])).collect();
	(id.to_string(), json!({ "id": id, "name": name, "level": lo, "levelMax": hi, "spawns": { "1411": { "f": "e", "pts": pts } } }))
}

fn level_world(quests: Value) -> Value {
	// Hub (20, 50), camp (70, 50), elsewhere (40, 20) on 1411's frame (1000 yd a side).
	json!({ "points": [[1, 1, 0, -600, 1411], [1, 1, 0, 400, 1411], [1, 1, 600, -200, 1411]], "zones": { "1411": "Durotar" }, "quests": quests })
}

fn kill_quest(id: u32, npc: u32, lvl: u32, pre: &[u32]) -> Value {
	json!({ "id": id, "pre": pre, "objs": [{ "oi": 0, "type": "kill", "id": npc, "task": 0 }], "tasks": [{ "work": [["kill", lvl, 5, 0, 0, npc]] }] })
}

#[test]
fn level_fit_moves_work_to_the_later_visit_where_it_fits() {
	// Quest 1's gnolls (16) at level 10 do not fit; the route is back at the same camp at 14 for the
	// wolves: the gnolls go there, and their hand-in to the hub stop after it.
	let a = vec![
		"guide t/a",
		"title A",
		"levels 10-15",
		"zone Durotar",
		"",
		"step Hub",
		"  accept 1",
		"  accept 2",
		"  accept 3",
		"",
		"step Gnolls",
		"  kill 10 quest 1.1",
		"",
		"step Elsewhere",
		"  kill 13 quest 3.1",
		"",
		"step Hub again",
		"  turnin 1",
		"  turnin 3",
		"",
		"step Wolves",
		"  kill 12 quest 2.1",
		"",
		"step Hub last",
		"  turnin 2",
		"",
	];
	let npcs: serde_json::Map<String, Value> = [camp(10, "Gnoll", 16, 16, 70.0, 50.0, 5), camp(12, "Wolf", 14, 14, 70.0, 51.0, 5), camp(13, "Boar", 11, 11, 40.0, 20.0, 5)].into_iter().collect();
	let c = Case {
		files: vec![("a", a)],
		route: json!({ "faction": "Horde", "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "lvl": 10.0, "from": f("a", 7) }, { "t": "accept", "q": 2, "pt": 0, "lvl": 10.0, "from": f("a", 8) },
			{ "t": "accept", "q": 3, "pt": 0, "lvl": 10.0, "from": f("a", 9) },
			{ "t": "task", "q": 1, "task": 0, "pt": 1, "lvl": 10.2, "from": f("a", 12) },
			{ "t": "task", "q": 3, "task": 0, "pt": 2, "lvl": 10.5, "from": f("a", 15) },
			{ "t": "turnin", "q": 1, "pt": 0, "lvl": 11.0, "from": f("a", 18) }, { "t": "turnin", "q": 3, "pt": 0, "lvl": 11.5, "from": f("a", 19) },
			{ "t": "task", "q": 2, "task": 0, "pt": 1, "lvl": 14.2, "from": f("a", 22) },
			{ "t": "turnin", "q": 2, "pt": 0, "lvl": 15.0, "from": f("a", 25) }
		] }),
		world: level_world(json!([kill_quest(1, 10, 16, &[]), kill_quest(2, 12, 14, &[]), kill_quest(3, 13, 11, &[])])),
		quests: json!({ "1": { "title": "One", "level": 16 }, "2": { "title": "Two", "level": 14 }, "3": { "title": "Three", "level": 11 } }),
		npcs: Value::Object(npcs),
		..Case::default()
	};
	let r = run(&c, None);
	assert_eq!(
		pick(&r.read("a"), r"^\s+(accept|turnin|kill)"),
		vec!["  accept 2", "  accept 3", "  kill 13 quest 3.1", "  turnin 3", "  accept 1", "  kill 12 quest 2.1", "  kill 10 quest 1.1", "  turnin 2", "  turnin 1"],
		"{:#?}",
		r.out.log
	);
	assert!(r.out.log.iter().any(|l| l.starts_with("level fit: One (1) task 1 moved after task two (2)")), "{:#?}", r.out.log);
}

#[test]
fn level_fit_leaves_out_work_no_later_visit_fits() {
	// Fangore's Galardell Valley (#977): Lieutenant Fangore (26) among gnolls of 22-25 at level 21.4, and the
	// route never comes back at a level that fits: the quest, its hand-in and its follow-up go, and the
	// header says why.
	let a = vec![
		"guide t/a",
		"title A",
		"levels 20-24",
		"zone Durotar",
		"",
		"step Town",
		"  accept 4",
		"  accept 7",
		"",
		"step Galardell Valley",
		"  kill 20 quest 4.1",
		"",
		"step Blackrock camps",
		"  kill 13 quest 7.1",
		"",
		"step Back to town",
		"  turnin 4",
		"  accept 5",
		"  turnin 7",
		"",
		"step Follow-up",
		"  kill 13 quest 5.1",
		"  turnin 5",
		"",
	];
	let npcs: serde_json::Map<String, Value> =
		[camp(20, "Lieutenant Fangore", 26, 26, 70.0, 50.0, 1), camp(21, "Shadowhide Gnoll", 22, 25, 70.5, 50.5, 9), camp(13, "Blackrock Grunt", 21, 22, 40.0, 20.0, 6)].into_iter().collect();
	let c = Case {
		files: vec![("a", a)],
		route: json!({ "faction": "Alliance", "diff": {}, "order": [
			{ "t": "accept", "q": 4, "pt": 0, "lvl": 21.0, "from": f("a", 7) }, { "t": "accept", "q": 7, "pt": 0, "lvl": 21.0, "from": f("a", 8) },
			{ "t": "task", "q": 4, "task": 0, "pt": 1, "lvl": 21.46, "from": f("a", 11) },
			{ "t": "task", "q": 7, "task": 0, "pt": 2, "lvl": 23.0, "from": f("a", 14) },
			{ "t": "turnin", "q": 4, "pt": 0, "lvl": 23.2, "from": f("a", 17) }, { "t": "accept", "q": 5, "pt": 0, "lvl": 23.3, "from": f("a", 18) },
			{ "t": "turnin", "q": 7, "pt": 0, "lvl": 23.3, "from": f("a", 19) },
			{ "t": "task", "q": 5, "task": 0, "pt": 2, "lvl": 23.4, "from": f("a", 22) }, { "t": "turnin", "q": 5, "pt": 0, "lvl": 23.6, "from": f("a", 23) }
		] }),
		world: level_world(json!([kill_quest(4, 20, 26, &[]), kill_quest(5, 13, 22, &[4]), kill_quest(7, 13, 22, &[])])),
		quests: json!({ "4": { "title": "WANTED: Lieutenant Fangore", "level": 26 }, "5": { "title": "Five", "level": 23, "pre": [4] }, "7": { "title": "Blackrock Menace", "level": 21 } }),
		npcs: Value::Object(npcs),
		..Case::default()
	};
	let r = run(&c, None);
	let g = r.read("a");
	assert_eq!(pick(&g, r"^\s+(accept|turnin|kill)"), vec!["  accept 7", "  kill 13 quest 7.1", "  turnin 7"], "{g:#?}");
	assert!(has(&g, "# Left out for the level (their targets or ground over level + 2 here, and no later visit that fits): WANTED: Lieutenant Fangore (4), Five (5)."), "{g:#?}");
	assert!(
		r.out.log.iter().any(|l| l.starts_with("level fit: WANTED: Lieutenant Fangore (4) left out (target 26 at 21.5, ground 24; no later visit there at a level that fits)")),
		"{:#?}",
		r.out.log
	);
}

#[test]
fn level_fit_judges_the_ground_not_only_the_target() {
	// A target at the player's level (21) inside a camp of 25s: the ground's median decides. Without
	// a level on the route (an old route) nothing is judged.
	let a = vec![
		"guide t/a",
		"title A",
		"levels 20-24",
		"zone Durotar",
		"",
		"step Town",
		"  accept 6",
		"  accept 8",
		"",
		"step Camp",
		"  kill 31 quest 6.1",
		"",
		"step Town again",
		"  turnin 6",
		"  turnin 8",
		"",
	];
	let npcs: serde_json::Map<String, Value> = [camp(31, "Rabid Gnoll", 21, 21, 70.0, 50.0, 3), camp(32, "Gnoll Darkweaver", 25, 25, 70.2, 50.2, 9)].into_iter().collect();
	let mut c = Case {
		files: vec![("a", a)],
		route: json!({ "faction": "Alliance", "diff": {}, "order": [
			{ "t": "accept", "q": 6, "pt": 0, "lvl": 21.0, "from": f("a", 7) }, { "t": "accept", "q": 8, "pt": 0, "lvl": 21.0, "from": f("a", 8) },
			{ "t": "task", "q": 6, "task": 0, "pt": 1, "lvl": 21.3, "from": f("a", 11) },
			{ "t": "turnin", "q": 6, "pt": 0, "lvl": 21.8, "from": f("a", 14) }, { "t": "turnin", "q": 8, "pt": 0, "lvl": 21.9, "from": f("a", 15) }
		] }),
		world: level_world(json!([kill_quest(6, 31, 21, &[])])),
		quests: json!({ "6": { "title": "Six", "level": 22 }, "8": { "title": "Eight", "level": 21 } }),
		npcs: Value::Object(npcs),
		..Case::default()
	};
	let r = run(&c, None);
	assert_eq!(pick(&r.read("a"), r"^\s+(accept|turnin|kill)"), vec!["  accept 8", "  turnin 8"], "{:#?}", r.out.log);
	for o in c.route["order"].as_array_mut().unwrap() {
		o.as_object_mut().unwrap().remove("lvl");
	}
	assert_eq!(pick(&run(&c, None).read("a"), r"^\s+(accept|turnin|kill)"), vec!["  accept 6", "  accept 8", "  kill 31 quest 6.1", "  turnin 6", "  turnin 8"]);
}
