//! Travel steps defer to the travel planner (#3922; addon/Polestar/Core/Engine.lua, "Travel steps defer to the
//! travel planner"). A step that is only a way somewhere says where to get to and the planner picks how: the
//! Hearthstone, a flight, a boat. The live step's title and its travel row read the way the planner chose, arriving
//! there by any way finishes the step, and the Hearthstone stays out of the way where the guide wants it later. Runs
//! the real addon on the addon's own travel data (Nav/TravelData.lua) and the client's map frames.

use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

/// Every map frame of data/forever as stub maps, or None without reference data.
fn maps() -> Option<String> {
	let data_dir = root().join("data/forever");
	if !data_dir.join("map-frames.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return None;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let mut maps = String::new();
	for era in ["forever", "era"] {
		for (id, f) in data.map_frames.get(era).as_obj().map(|o| o.entries()).unwrap_or_default() {
			let name = data.zones.get(&id).get("name").to_js_string();
			maps.push_str(&format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})\n",
				serde_json::to_string(if name == "undefined" { "" } else { &name }).unwrap(),
				f.get("c").to_js_string(),
				f.get("left").to_js_string(),
				f.get("right").to_js_string(),
				f.get("top").to_js_string(),
				f.get("bottom").to_js_string()
			));
		}
	}
	Some(maps)
}

/// The real addon: a Night Elf (the Alliance) at `start`, `setup` before login, `guides` and `script` after it.
fn run(start: &str, setup: &str, guides: &str, script: &str) -> Option<Value> {
	let maps = maps()?;
	let before = format!("local w = stub.world\n{maps}w.race, w.raceName, w.faction = \"NightElf\", \"Night Elf\", \"Alliance\"\nw.level = 58\n{start}\n{setup}\n");
	let script = format!(
		r#"{TEST_PACK}
{TEST_SOURCE}
{guides}
E, N = Polestar.Engine, Polestar.Nav
stub.login()
stub.fire("QUEST_LOG_UPDATE")
function known(...)
	local f = Polestar.CharState().flags
	f.taxi, f.taxiSeen = {{}}, {{ [0] = true, [1] = true }}
	for _, id in ipairs({{ ... }}) do f.taxi[id] = true end
end
-- What the player sees: the step, its title, each goal's row, the arrow's waypoint and the route's legs.
function look()
	local v, wp = E.GetStepView(E.GetStepIndex()), E.GetWaypoint()
	local rows, legs = {{}}, {{}}
	for _, g in ipairs(v and v.goals or {{}}) do
		if g.status == "active" or g.status == "pending" then rows[#rows + 1] = g.text end
	end
	local route, ci = N.GetRoute()
	for i = ci or 1, route and #route or 0 do legs[#legs + 1] = route[i].kind end
	return {{ step = E.GetStepIndex(), title = v and v.title or false, rows = rows, map = wp and wp.map or false,
		x = wp and wp.x or false, keep = wp and wp.keepHearth or false, legs = legs }}
end
{script}"#
	);
	// The guide pack's map frames: the taxi nodes and transport ends sit on the Era frames.
	let addons = vec![Addon::name("Polestar"), Addon::files("Polestar_Guides", &["MapFrames.lua"])];
	Some(emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons, script, ..Default::default() }).remove(0))
}

// Soggy's report (#3922): Mount Hyjal's step 49, "Fly to Everlook", from Nighthaven, the Hearthstone bound in
// Everlook since the guide's first step. The flight is written for both factions, and Everlook has a flight master
// per side, so it carries no taxi node: it led nowhere (no arrow), and read "Fly to Everlook" while the next step's
// arrow said "Hearth to Everlook: saves 3 min". Its landing is now the town's flight master for the character's
// side, the planner hearths, and the step says so.
const HYJAL: &str = r#"
Polestar.RegisterGuide({ id = "test/hyjal", pack = "test", title = "Mount Hyjal", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Fly to Everlook", goals = {
		{ t = "getfp", npc = 10897, npcName = "Sindrayl", location = "Moonglade", node = 49, area = 493, map = 1450, x = 48.21, y = 67.24, only = { factions = { "Alliance" } } },
		{ t = "getfp", npc = 12740, npcName = "Faustron", location = "Moonglade", node = 69, area = 493, map = 1450, x = 32.31, y = 66.57, only = { factions = { "Horde" } } },
		{ t = "fly", location = "Everlook", area = 2255 },
	} },
	{ title = "Nami", goals = { { t = "turnin", quest = 92008, title = "Premiere Parts", npc = 228216, npcName = "Nami", map = 1452, x = 61.3, y = 36.93 } } },
	LATER
} })
"#;

// Beside Rabine Saturna in Nighthaven, the step before.
const NIGHTHAVEN: &str = "w.moveTo(1450, 51.64, 44.99)\nw.setZone(\"Moonglade\", \"Nighthaven\")";

fn hyjal(later: &str) -> String {
	HYJAL.replace("LATER", later)
}

#[test]
fn a_flight_to_everlook_with_the_hearthstone_bound_there_says_hearth_and_hearthing_there_ends_it_3922() {
	let Some(out) = run(
		NIGHTHAVEN,
		"w.bind(\"Everlook\")\nw.addItem(6948, 1)",
		&hyjal(""),
		r#"
		known(26, 27, 49, 52, 64, 65)
		stub.world.accept(92008, {}, "Premiere Parts")
		E.SetGuide("test/hyjal"); stub.advance(1)
		local r = { lead = look() }
		-- The Hearthstone lands at Everlook's inn.
		stub.world.moveTo(1452, 61.36, 38.83); stub.world.setZone("Winterspring", "Everlook"); stub.advance(1)
		r.landed = look()
		emit(r)
		"#,
	) else {
		return;
	};
	// The arrow leads to Everlook's Alliance flight master (node 52), the planner hearths, the step says so.
	assert_eq!(out["lead"]["step"], 1, "{out}");
	assert_eq!(json!([out["lead"]["map"], out["lead"]["x"]]), json!([1452, 62.33]), "the arrow leads to Everlook: {out}");
	assert_eq!(out["lead"]["legs"][0], "hearth", "{out}");
	assert_eq!(out["lead"]["title"], "Hearth to Everlook", "{out}");
	assert_eq!(out["lead"]["rows"], json!(["Hearth to Everlook"]), "the flight's row reads the way: {out}");
	assert_eq!(out["landed"]["step"], 2, "landing at Everlook's inn ends the step: {out}");
}

// The same step with the Hearthstone cooling down for 12 more seconds: the planner still hearths (waiting is the
// faster way, p.hearthWait), and the step's title and travel row count the wait down: "Wait 0:11 for your
// Hearthstone, then hearth to Everlook", then "Hearth to Everlook" once it is ready.
#[test]
fn a_hearth_still_on_its_cooldown_counts_down_on_the_travel_step_then_reads_hearth_to() {
	let Some(out) = run(
		NIGHTHAVEN,
		"w.bind(\"Everlook\")\nw.addItem(6948, 1)",
		&hyjal(""),
		r#"
		known(26, 27, 49, 52, 64, 65)
		stub.world.accept(92008, {}, "Premiere Parts")
		stub.advance(10) -- a cooldown starts at a time above 0
		local start = GetTime()
		local f = function(id) if id == 6948 then return start, 12, 1 end return 0, 0, 1 end
		C_Container = C_Container or {}
		C_Container.GetItemCooldown = f
		if C_Item then C_Item.GetItemCooldown = f end
		GetItemCooldown = f
		E.SetGuide("test/hyjal"); stub.advance(1)
		local r = { waiting = look() }
		stub.advance(4)
		r.later = look()
		stub.advance(8)
		r.ready = look()
		emit(r)
		"#,
	) else {
		return;
	};
	assert_eq!(out["waiting"]["legs"][0], "hearth", "{out}");
	assert_eq!(out["waiting"]["title"], "Wait 0:11 for your Hearthstone, then hearth to Everlook", "{out}");
	assert_eq!(out["waiting"]["rows"], json!(["Wait 0:11 for your Hearthstone, then hearth to Everlook"]), "{out}");
	assert_eq!(out["later"]["title"], "Wait 0:07 for your Hearthstone, then hearth to Everlook", "it counts down: {out}");
	assert_eq!(out["ready"]["title"], "Hearth to Everlook", "{out}");
	assert_eq!(out["ready"]["rows"], json!(["Hearth to Everlook"]), "{out}");
}

// Without the planner (nav.travel off) the step holds as written: "Fly to Everlook", no travel waypoint.
#[test]
fn with_the_planner_off_the_flight_to_everlook_reads_as_written_3922() {
	let Some(out) = run(
		NIGHTHAVEN,
		"w.bind(\"Everlook\")\nw.addItem(6948, 1)",
		&hyjal(""),
		r#"
		known(26, 27, 49, 52, 64, 65)
		Polestar.Set("nav.travel", false)
		E.SetGuide("test/hyjal"); stub.advance(1)
		emit(look())
		"#,
	) else {
		return;
	};
	assert_eq!(json!([out["step"], out["title"], out["rows"], out["map"]]), json!([1, "Fly to Everlook", ["Fly to Everlook"], false]), "{out}");
}

// A character who never learned Everlook's flight path, with no Hearthstone: the planner can't fly there, so the
// step reads the road ("Walk to Everlook") and arriving at Everlook's flight master on foot ends it. Before, the
// flight with no node led nowhere.
#[test]
fn a_flight_to_a_landing_never_learned_reads_the_road_and_walking_there_ends_it_3922() {
	let Some(out) = run(
		NIGHTHAVEN,
		"",
		&hyjal(""),
		r#"
		known(26, 27, 49)
		stub.world.accept(92008, {}, "Premiere Parts")
		E.SetGuide("test/hyjal"); stub.advance(1)
		local r = { lead = look() }
		-- On the road, short of Everlook.
		stub.world.moveTo(1452, 55, 40); stub.world.setZone("Winterspring", ""); stub.advance(1)
		r.road = look()
		stub.world.moveTo(1452, 62.33, 36.64); stub.world.setZone("Winterspring", "Everlook"); stub.advance(1)
		r.walked = look()
		emit(r)
		"#,
	) else {
		return;
	};
	assert_eq!(json!([out["lead"]["step"], out["lead"]["map"], out["lead"]["x"]]), json!([1, 1452, 62.33]), "{out}");
	assert!(!out["lead"]["legs"].as_array().unwrap().iter().any(|l| l == "fly" || l == "hearth"), "{out}");
	let title = out["lead"]["title"].as_str().unwrap_or_default();
	assert!(title == "Walk to Everlook" || title == "Ride to Everlook", "the road: {out}");
	assert_eq!(out["road"]["step"], 1, "{out}");
	assert_eq!(out["walked"]["step"], 2, "arriving on foot ends the step: {out}");
}

// The guide hearths later (a `hearth` goal, no `sethome` between): the way to Everlook keeps the Hearthstone and
// flies. So does a way that would only use it to set off from the inn when the guide comes back to the inn later.
#[test]
fn a_travel_step_keeps_the_hearthstone_the_guide_wants_later_3922() {
	let later = r#"{ title = "Back to Everlook", goals = { { t = "hearth", location = "Everlook", area = 2255 } } },"#;
	let Some(out) = run(
		NIGHTHAVEN,
		"w.bind(\"Everlook\")\nw.addItem(6948, 1)",
		&hyjal(later),
		r#"
		known(26, 27, 49, 52, 64, 65)
		stub.world.accept(92008, {}, "Premiere Parts")
		E.SetGuide("test/hyjal"); stub.advance(1)
		emit(look())
		"#,
	) else {
		return;
	};
	assert_eq!(out["keep"], true, "{out}");
	assert!(!out["legs"].as_array().unwrap().iter().any(|l| l == "hearth"), "the Hearthstone is kept: {out}");
	assert_eq!(out["title"], "Fly to Everlook", "{out}");

	// A flight away from the inn (to Talonbranch Glade in Felwood) with work back at Everlook's inn after it: kept;
	// with no such work, not.
	let away = r#"
Polestar.RegisterGuide({ id = "test/away", pack = "test", title = "Felwood", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Fly to Talonbranch Glade", goals = { { t = "fly", location = "Talonbranch Glade" } } },
	{ title = "Talonbranch", goals = { { t = "accept", quest = 9001, title = "A", npc = 1, map = 1448, x = 62.5, y = 24.2 } } },
	BACK
} })
"#;
	let back = r#"{ title = "Everlook", goals = { { t = "accept", quest = 9002, title = "B", npc = 11118, map = 1452, x = 61.36, y = 38.83 } } },"#;
	let keep = |later: &str| {
		run(NIGHTHAVEN, "w.bind(\"Everlook\")\nw.addItem(6948, 1)", &away.replace("BACK", later), "known(26, 27, 49, 52, 64, 65)\nE.SetGuide(\"test/away\"); stub.advance(1)\nemit(look())").unwrap()
	};
	let (with, without) = (keep(back), keep(""));
	assert_eq!(json!([with["map"], with["keep"]]), json!([1448, true]), "{with}");
	assert_eq!(json!([without["map"], without["keep"]]), json!([1448, false]), "{without}");
}

// A walk to a boat (Wetlands' "Boat to Auberdine", Menethil Harbor's pier) leads to the boat's far end, the dock in
// Auberdine nearest the work after it, and reads "Take the boat to Auberdine"; with the Hearthstone bound in
// Auberdine it reads "Hearth to Auberdine", and hearthing there passes the step.
const BOAT: &str = r#"
Polestar.RegisterGuide({ id = "test/boat", pack = "test", title = "Wetlands", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Boat to Auberdine", goals = { { t = "goto", map = 1437, x = 4.6, y = 57.0, text = "Boat to Auberdine" } } },
	{ title = "Auberdine", goals = { { t = "accept", quest = 9003, title = "Darkshore work", npc = 3, map = 1439, x = 37.0, y = 44.0 } } },
} })
"#;

#[test]
fn a_walk_to_a_boat_leads_to_its_far_end_and_reads_the_planners_way_3922() {
	let menethil = "w.moveTo(1437, 10.5, 60.0)\nw.setZone(\"Wetlands\", \"Menethil Harbor\")";
	let script = r#"
		known(7, 26)
		E.SetGuide("test/boat"); stub.advance(1)
		local r = { lead = look() }
		stub.world.moveTo(1439, 37.04, 44.13); stub.world.setZone("Darkshore", "Auberdine"); stub.advance(1)
		r.across = look()
		emit(r)
	"#;
	let Some(sail) = run(menethil, "", BOAT, script) else {
		return;
	};
	let hearth = run(menethil, "w.bind(\"Auberdine\")\nw.addItem(6948, 1)", BOAT, script).unwrap();
	assert_eq!(json!([sail["lead"]["step"], sail["lead"]["map"], sail["lead"]["x"]]), json!([1, 1439, 32.34]), "the arrow leads to Auberdine's dock: {sail}");
	assert!(sail["lead"]["legs"].as_array().unwrap().iter().any(|l| l == "boat"), "{sail}");
	assert_eq!(sail["lead"]["title"], "Take the boat to Auberdine", "{sail}");
	assert_eq!(sail["lead"]["rows"], json!(["Take the boat to Auberdine"]), "{sail}");
	assert_eq!(hearth["lead"]["legs"][0], "hearth", "{hearth}");
	assert_eq!(hearth["lead"]["title"], "Hearth to Auberdine", "{hearth}");
	assert_eq!(hearth["across"]["step"], 2, "across in Auberdine by the Hearthstone: the step is behind: {hearth}");
}
