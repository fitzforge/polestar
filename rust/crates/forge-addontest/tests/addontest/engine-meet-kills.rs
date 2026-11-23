//! "Kill these as you meet them" steps (#3598, #3641 E). A step of that title that mixes kill goals with objectives
//! at places (a collect or interact not spread over mobs) tours the place objectives, nearest first, the kills done on
//! the way and named under the arrow; a kill leads only once no place objective is left. Steps of kills alone measure
//! each spawn area to its middle, so one wide area round the player does not read 0 yd from everywhere in it. Real
//! Core manifest, stub world; Elwynn here is 30 yd per map percent across.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
"#;

const HELPERS: &str = r#"
function flush() stub.advance(0.25) end
E = Polestar.Engine
w = stub.world
function at(x) w.moveTo(1429, x, 50); stub.advance(1); local wp = E.GetWaypoint(); return { wp.goalIndex, wp.x } end
function label() local wp = E.GetWaypoint(); return wp and wp.label or "" end
"#;

fn run(guides: &str, before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [TEST_PACK, TEST_SOURCE, guides, HELPERS, "stub.login()", script].join("\n"),
		login: false,
		..Default::default()
	})
	.remove(0)
}

// Tilman's Coldridge Valley (#3598): the Frostmane whelps spawn all over the valley, the player in the middle of
// them; Felix's Chest and his Bucket of Bolts lie at two places.
const COLDRIDGE: &str = r#"
Polestar.RegisterGuide({ id = "test/coldridge", pack = "test", title = "Dun Morogh", zone = 1429, steps = {
	{ title = "Coldridge Valley: kill these as you meet them", goals = {
		{ t = "kill", target = "Frostmane Troll Whelp", npc = 706, count = 14, quest = 182, oi = 1, map = 1429, x = 50, y = 50, spread = true,
			spots = { { x = 50, y = 50, r = 300, n = 10 } } },
		{ t = "collect", item = 16314, itemName = "Felix's Bucket of Bolts", count = 1, quest = 3361, oi = 1, map = 1429, x = 60, y = 50 },
		{ t = "collect", item = 16313, itemName = "Felix's Chest", count = 1, quest = 3361, oi = 2, map = 1429, x = 45, y = 50 },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

#[test]
fn coldridge_the_arrow_tours_felix_s_parts_nearest_first_and_names_the_whelps_then_the_whelps_lead_3598() {
	let out = run(
		COLDRIDGE,
		"w.level = 4; w.onQuest(182, { 14 }); w.onQuest(3361, { 1, 1 }); w.moveTo(1429, 50, 50)",
		r#"
			E.SetGuide("test/coldridge"); flush()
			local r = { first = at(50), note = label() }
			w.progress(3361, 2, 1); flush()
			r.second = at(50)
			w.progress(3361, 1, 1); flush()
			r.last = at(50)
			r.lastNote = label()
			emit(r)
		"#,
	);
	assert_eq!(out["first"], json!([3, 45]), "Felix's Chest, the nearer place, not the whelps round the player: {out}");
	let note = out["note"].as_str().unwrap();
	assert!(note.contains("kill Frostmane Troll Whelp as you meet them"), "the whelps named under the arrow: {note}");
	assert_eq!(out["second"], json!([2, 60]), "then the Bucket of Bolts");
	assert_eq!(out["last"][0], 1, "with Felix's parts done, the whelps lead: {out}");
	assert!(!out["lastNote"].as_str().unwrap().contains("as you meet them"), "{out}");
}

// A step of kills alone with a wide area round the player (its edge 0 yd from everywhere in it) and a small camp
// 90 yd off: measured to each area's middle, the camp is nearer (90 yd, the wide area's middle 150 yd).
const TWO_AREAS: &str = r#"
Polestar.RegisterGuide({ id = "test/two", pack = "test", title = "Two", zone = 1429, steps = {
	{ title = "Elwynn Forest: kill these as you meet them", goals = {
		{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 45, y = 50, spread = true,
			spots = { { x = 45, y = 50, r = 200, n = 10 } } },
		{ t = "kill", target = "Kobold Worker", npc = 257, count = 10, quest = 7, oi = 2, map = 1429, x = 53, y = 50, spread = true,
			spots = { { x = 53, y = 50, r = 10, n = 3 } } },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

#[test]
fn a_step_of_kills_alone_measures_each_spawn_area_to_its_middle_so_the_nearest_camp_wins() {
	let out = run(TWO_AREAS, "w.level = 5; w.onQuest(7, { 10, 10 }); w.moveTo(1429, 50, 50)", r#"E.SetGuide("test/two"); flush(); emit({ at = at(50), note = label() })"#);
	assert_eq!(out["at"], json!([2, 53]), "the Workers' camp 90 yd off, not the Vermin area the player stands in: {out}");
	assert!(!out["note"].as_str().unwrap().contains("as you meet them"), "kills alone: no note");
}

// Hillsbrad Fields (#3641): four kill goals over the farms, the player outside them all: the nearest area leads, as
// before (edge or middle, the same order here).
const HILLSBRAD: &str = r#"
Polestar.RegisterGuide({ id = "test/hills", pack = "test", title = "Hills", zone = 1429, steps = {
	{ title = "Hillsbrad Fields: kill these as you meet them", goals = {
		{ t = "kill", target = "Hillsbrad Farmer", npc = 2266, count = 6, quest = 527, oi = 1, map = 1429, x = 70, y = 50, spread = true, spots = { { x = 70, y = 50, r = 20, n = 4 } } },
		{ t = "kill", target = "Hillsbrad Peasant", npc = 2360, count = 6, quest = 527, oi = 2, map = 1429, x = 60, y = 50, spread = true, spots = { { x = 60, y = 50, r = 20, n = 4 } } },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

#[test]
fn hillsbrad_fields_the_nearest_farm_leads_as_before() {
	let out = run(HILLSBRAD, "w.level = 24; w.onQuest(527, { 6, 6 }); w.moveTo(1429, 50, 50)", r#"E.SetGuide("test/hills"); flush(); emit({ at = at(50) })"#);
	assert_eq!(out["at"], json!([2, 60]));
}
