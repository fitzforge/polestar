//! The `steps` flow flag in the writer (process-wide flags: its own test binary).
#![allow(dead_code)]

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
		gates: &[],
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
fn under_steps_a_seed_along_list_is_a_plain_step_even_when_its_label_moves_before_it() {
	// v2 (2026-11-07): the seed re-cut from the published guides carries next's along lists; the route
	// moved their label step before them and the pack check refused "`along until` must name a later
	// step". Under `steps` (F6) the along line goes and its goals stay at the step's place.
	forge_core::flow_flags::set_for_tests(&["steps"]);
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
				"  accept 3",
				"",
				"step Champion on the way",
				"  along until back",
				"  kill 99 quest 3.1",
				"",
				"step Plainstriders",
				"  kill 44 quest 1.1",
				"",
				"step Crossroads again",
				"  label back",
				"  turnin 1",
				"  turnin 3",
				"",
			],
		)],
		world: json!({ "points": [[0, 0, 0, 0, 1413], [0, 0, 100, 0, 1413]], "zones": { "1413": "The Barrens" }, "quests": [] }),
		frames: json!({ "era": { "1413": { "top": 1000, "bottom": -1000, "left": -1000, "right": 1000, "c": 0 } } }),
		npcs: json!({
			"44": { "name": "Plainstrider", "spawns": { "1413": { "f": "e", "pts": [[50, 50], [50, 45], [51, 50]] } } },
			"99": { "name": "Champion", "spawns": { "1413": { "f": "e", "pts": [[55, 55]] } } }
		}),
		route: json!({ "diff": {}, "order": [
			{ "t": "accept", "q": 1, "pt": 0, "from": f("a", 7) }, { "t": "accept", "q": 3, "pt": 0, "from": f("a", 8) },
			{ "t": "task", "q": 1, "task": 0, "pt": 0, "from": f("a", 15) },
			{ "t": "turnin", "q": 1, "pt": 0, "from": f("a", 19) },
			{ "t": "task", "q": 3, "task": 0, "pt": 1, "from": f("a", 12) },
			{ "t": "turnin", "q": 3, "pt": 0, "from": f("a", 20) }
		] }),
		..Case::default()
	};
	let g = run(&c, None).read("a");
	assert!(!g.iter().any(|l| l.trim_start().starts_with("along")), "{g:#?}");
	assert!(g.iter().any(|l| l.starts_with("  turnin 3")), "{g:#?}");
}
