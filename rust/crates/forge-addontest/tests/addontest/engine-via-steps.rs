//! Steps of places only (#4467; addon/Polestar/Core/Engine.lua, "Steps of places only"). In a leveling guide the
//! compiler marks a step whose goals are only gotos, a flight or `enter` `via = true`: no step of its own (no number,
//! never the live step), a hint of the way to the step after it. The arrow goes by the first via still ahead unless
//! the player is past it, came another way or has a faster way (Nav.ViaPick); the live step reads "<title> · <zone>"
//! with the planner's way as its travel line; a step kept as written (`keep`) passes once the step it leads to is done.
//! Runs the real addon on the addon's own travel data (Nav/TravelData.lua) and the client's map frames.

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

/// The real addon: a Human Mage (the Alliance) at `start`, `setup` before login, `guides` and `script` after it.
fn run(start: &str, setup: &str, guides: &str, script: &str) -> Option<Value> {
	let maps = maps()?;
	let before = format!("local w = stub.world\n{maps}w.race, w.raceName, w.faction = \"Human\", \"Human\", \"Alliance\"\nw.class, w.className = \"MAGE\", \"Mage\"\nw.level = 56\n{start}\n{setup}\n");
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
-- What the player sees: the live step and its number, its title and travel line, the arrow's waypoint, the
-- route's legs, and how many steps the counter shows.
function look()
	local s = E.GetStepIndex()
	local v, wp = s and E.GetStepView(s), E.GetWaypoint()
	local legs = {{}}
	local route, ci = N.GetRoute()
	for i = ci or 1, route and #route or 0 do legs[#legs + 1] = route[i].kind end
	local g = E.GetGuide()
	local numbers = {{}}
	for i = 1, #g.steps do
		local n, hidden = E.StepNumber(i)
		numbers[i] = hidden and "-" or n
	end
	return {{ step = s or false, number = s and (E.StepNumber(s)) or false, total = E.StepTotalOf(g), numbers = numbers,
		title = v and v.title or false, travel = v and v.travel or false,
		map = wp and wp.map or false, x = wp and wp.x or false, via = wp and wp.via or false, legs = legs }}
end
{script}"#
	);
	let addons = vec![Addon::name("Polestar"), Addon::files("Polestar_Guides", &["MapFrames.lua"])];
	Some(emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons, script, ..Default::default() }).remove(0))
}

// uNBEx's report (#4467): the Western & Eastern Plaguelands guide, Marlene Redpath's Little Pamela (5142) on Sorrow
// Hill, then "Into Eastern Plaguelands", a goto at the Thondroril River crossing (8.8,66.2), then Pamela Redpath in
// Darrowshire. 0.4.3.1 led him to the crossing as a step of its own before the arrow turned to Pamela. The steps as
// the compiler writes them now: the crossing is a via.
const WPL: &str = r#"
Polestar.RegisterGuide({ id = "test/wpl", pack = "test", title = "Western & Eastern Plaguelands", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Marlene Redpath", goals = { { t = "accept", quest = 5142, title = "Little Pamela", npc = 10927, npcName = "Marlene Redpath", map = 1422, x = 49.05, y = 78.6 } } },
	{ title = "Into Eastern Plaguelands", via = true, note = "Follow the southern road east out of the Western Plaguelands.", goals = {
		{ t = "goto", text = "Into Eastern Plaguelands", map = 1423, x = 8.8, y = 66.2, f = "e" },
	} },
	{ title = "Pamela Redpath", goals = { { t = "turnin", quest = 5142, title = "Little Pamela", npc = 10926, npcName = "Pamela Redpath", map = 1423, x = 31.09, y = 77.99 } } },
	{ title = "Pamela's doll", goals = { { t = "goto", text = "Darrowshire", map = 1423, x = 36.4, y = 90.8 } , { t = "accept", quest = 5149, title = "Pamela's Doll", npc = 10926, npcName = "Pamela Redpath", map = 1423, x = 31.09, y = 77.99 } } },
} })
"#;

const AT_THE_RIVER: &str = "w.moveTo(1422, 68.94, 45.44)\nw.setZone(\"Western Plaguelands\", \"Thondroril River\")";
const SORROW_HILL: &str = "w.moveTo(1422, 49.2, 78.4)\nw.setZone(\"Western Plaguelands\", \"Sorrow Hill\")";

#[test]
fn his_case_no_step_for_the_crossing_and_the_arrow_goes_straight_to_pamela_4467() {
	let Some(out) = run(
		AT_THE_RIVER,
		"",
		WPL,
		r#"
		stub.world.accept(5142, {}, "Little Pamela")
		E.SetGuide("test/wpl"); stub.advance(1)
		emit(look())
		"#,
	) else {
		return;
	};
	// Standing at the crossing, as he did: Pamela's step is the live one, the crossing has no number of its own,
	// and the arrow leads to Pamela.
	assert_eq!(out["step"], 3, "{out}");
	assert_eq!(out["numbers"], json!([1, "-", 2, 3]), "the counter counts the steps of their own: {out}");
	assert_eq!(out["total"], 3, "{out}");
	assert_eq!(json!([out["map"], out["x"], out["via"]]), json!([1423, 31.09, false]), "the arrow leads to Pamela: {out}");
	assert_eq!(out["title"], "Pamela Redpath · Eastern Plaguelands", "the step says what and where: {out}");
}

#[test]
fn a_via_is_honoured_by_a_player_coming_from_behind_it_and_reaching_it_turns_the_arrow_to_the_work_4467() {
	let Some(out) = run(
		SORROW_HILL,
		"",
		WPL,
		r#"
		stub.world.accept(5142, {}, "Little Pamela")
		E.SetGuide("test/wpl"); stub.advance(1)
		local r = { behind = look() }
		-- At the crossing (within its reach): the arrow turns to Pamela.
		stub.world.moveTo(1423, 8.8, 66.3); stub.world.setZone("Eastern Plaguelands", "Thondroril River"); stub.advance(1)
		r.reached = look()
		emit(r)
		"#,
	) else {
		return;
	};
	// From Sorrow Hill the crossing lies on the way (about 1.3 times the straight line): the arrow goes by it, on
	// Pamela's step and in her name.
	assert_eq!(out["behind"]["step"], 3, "{out}");
	assert_eq!(json!([out["behind"]["map"], out["behind"]["x"], out["behind"]["via"]]), json!([1423, 8.8, 2]), "the arrow goes by the crossing: {out}");
	assert_eq!(json!([out["reached"]["step"], out["reached"]["map"], out["reached"]["x"], out["reached"]["via"]]), json!([3, 1423, 31.09, false]), "{out}");
}

#[test]
fn with_the_planner_off_a_via_is_a_plain_waypoint_and_still_no_step_4467() {
	let Some(out) = run(
		SORROW_HILL,
		"",
		WPL,
		r#"
		Polestar.Set("nav.travel", false)
		stub.world.accept(5142, {}, "Little Pamela")
		E.SetGuide("test/wpl"); stub.advance(1)
		local r = { behind = look() }
		stub.world.moveTo(1423, 8.8, 66.3); stub.world.setZone("Eastern Plaguelands", "Thondroril River"); stub.advance(1)
		r.reached = look()
		emit(r)
		"#,
	) else {
		return;
	};
	assert_eq!(json!([out["behind"]["step"], out["behind"]["numbers"]]), json!([3, [1, "-", 2, 3]]), "{out}");
	assert_eq!(json!([out["behind"]["map"], out["behind"]["x"], out["behind"]["via"]]), json!([1423, 8.8, 2]), "{out}");
	assert_eq!(json!([out["reached"]["step"], out["reached"]["x"], out["reached"]["via"]]), json!([3, 31.09, false]), "arriving passes it: {out}");
}

#[test]
fn a_via_is_dropped_once_the_player_is_past_it_4467() {
	let Some(out) = run(
		"w.moveTo(1423, 24.0, 74.0)\nw.setZone(\"Eastern Plaguelands\", \"Darrowshire\")",
		"",
		WPL,
		r#"
		stub.world.accept(5142, {}, "Little Pamela")
		E.SetGuide("test/wpl"); stub.advance(1)
		emit(look())
		"#,
	) else {
		return;
	};
	// Nearer Pamela than the crossing is: never pulled back to it.
	assert_eq!(json!([out["step"], out["map"], out["x"], out["via"]]), json!([3, 1423, 31.09, false]), "{out}");
}

// A Mage's Teleport: Ironforge (3562) beats the walk by the gates: the via is dropped, the arrow leads to the work.
// Without the teleport the same walk goes by the gates.
const IRONFORGE: &str = r#"
Polestar.RegisterGuide({ id = "test/if", pack = "test", title = "Loch Modan", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Thelsamar", goals = { { t = "accept", quest = 9001, title = "Letter", npc = 1, npcName = "Mountaineer", map = 1432, x = 35.0, y = 47.0 } } },
	{ title = "To Ironforge", via = true, goals = { { t = "goto", text = "Ironforge's gates", map = 1426, x = 53.5, y = 34.6, f = "e" } } },
	{ title = "Royal Historian", goals = { { t = "turnin", quest = 9001, title = "Letter", npc = 2, npcName = "Royal Historian", map = 1455, x = 38.0, y = 55.0 } } },
} })
"#;
const THELSAMAR: &str = "w.moveTo(1432, 35.5, 47.5)\nw.setZone(\"Loch Modan\", \"Thelsamar\")";

#[test]
fn a_via_is_dropped_when_a_mage_teleport_is_faster_and_kept_without_it_4467() {
	let script = r#"
		stub.world.accept(9001, {}, "Letter")
		E.SetGuide("test/if"); stub.advance(1)
		emit(look())
		"#;
	let Some(mage) = run(THELSAMAR, "w.spells[3562] = true\nw.addItem(17031, 5)", IRONFORGE, script) else {
		return;
	};
	let Some(walker) = run(THELSAMAR, "", IRONFORGE, script) else {
		return;
	};
	assert_eq!(mage["step"], 3, "{mage}");
	assert_eq!(json!([mage["map"], mage["via"]]), json!([1455, false]), "the teleport is faster: no pull to the gates: {mage}");
	assert_eq!(mage["legs"][0], "teleport", "{mage}");
	// The via dropped, the step still says what and where, and its travel line is the teleport.
	assert_eq!(mage["title"], "Royal Historian · Ironforge", "{mage}");
	assert!(mage["travel"].as_str().is_some_and(|t| t.contains("Teleport: Ironforge")), "{mage}");
	assert_eq!(json!([walker["map"], walker["x"], walker["via"]]), json!([1426, 53.5, 2]), "on foot the walk goes by the gates: {walker}");
}

// A step kept as written (`keep door`) is a step of its own; done out of order, the step it leads to takes the door
// with it. So does a via run: its step done, the arrow goes on to the next unfinished step.
const DOOR: &str = r#"
Polestar.RegisterGuide({ id = "test/door", pack = "test", title = "Darnassus", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Herald Moonstalker", goals = { { t = "accept", quest = 1047, title = "The New Frontier", npc = 10878, npcName = "Herald Moonstalker", map = 1457, x = 38.4, y = 21.6 } } },
	{ title = "Cenarion Enclave", keep = "door", goals = { { t = "goto", text = "Cenarion Enclave", map = 1457, x = 35.8, y = 11.6, f = "e" } } },
	{ title = "Arch Druid Fandral Staghelm", goals = { { t = "turnin", quest = 1047, title = "The New Frontier", npc = 3516, npcName = "Arch Druid Fandral Staghelm", map = 1457, x = 34.8, y = 7.6 } } },
	{ title = "Into Teldrassil", via = true, goals = { { t = "goto", text = "Portal to Teldrassil", map = 1457, x = 29.1, y = 41.2, f = "e" } } },
	{ title = "Moon Priestess Amara", goals = { { t = "turnin", quest = 9002, title = "Errand", npc = 2151, npcName = "Moon Priestess Amara", map = 1438, x = 55.0, y = 88.0 } } },
	{ title = "Dolanaar", goals = { { t = "accept", quest = 9003, title = "Later", npc = 3, npcName = "Elder", map = 1438, x = 55.6, y = 52.0 } } },
} })
"#;

#[test]
fn a_kept_step_shows_and_passes_with_its_step_and_a_via_run_before_a_done_step_is_skipped_4467() {
	let Some(out) = run(
		"w.moveTo(1457, 38.0, 22.0)\nw.setZone(\"Darnassus\", \"Darnassus\")",
		"",
		DOOR,
		r#"
		E.SetGuide("test/door"); stub.advance(10)
		-- The quests taken during play: the route reaches the door.
		stub.world.accept(9002, {}, "Errand")
		stub.world.accept(1047, {}, "The New Frontier"); stub.advance(1)
		local r = { door = look() }
		-- Fandral's hand-in done out of order: the door goes with it.
		stub.world.turnIn(1047); stub.advance(1)
		r.fandral = look()
		-- Amara's errand done out of order too: no way by the portal; the arrow goes on to Dolanaar.
		stub.world.turnIn(9002); stub.advance(1)
		r.amara = look()
		emit(r)
		"#,
	) else {
		return;
	};
	assert_eq!(json!([out["door"]["step"], out["door"]["number"], out["door"]["x"]]), json!([2, 2, 35.8]), "the door is a step of its own: {out}");
	assert_eq!(out["door"]["numbers"], json!([1, 2, 3, "-", 4, 5]), "{out}");
	assert_eq!(json!([out["fandral"]["step"], out["fandral"]["number"]]), json!([5, 4]), "the door passed with Fandral; on to Amara: {out}");
	assert_eq!(json!([out["amara"]["step"], out["amara"]["map"], out["amara"]["x"], out["amara"]["via"]]), json!([6, 1438, 55.6, false]), "{out}");
}

#[test]
fn a_save_on_a_step_that_became_a_via_lands_on_the_next_step_with_its_ticks_kept_4467() {
	let Some(out) = run(
		SORROW_HILL,
		"",
		WPL,
		r#"
		stub.world.accept(5142, {}, "Little Pamela")
		-- A save from before: the window pinned to the crossing's step, Pamela's doll's goto ticked.
		local cs = Polestar.CharState()
		cs.pins = cs.pins or {}; cs.pins["test/wpl"] = { step = 2 }
		cs.manual = cs.manual or {}; cs.manual["test/wpl"] = { ["4:1"] = true }
		E.SetGuide("test/wpl"); stub.advance(1)
		local r = look()
		r.tick = Polestar.CharState().manual["test/wpl"]["4:1"] or false
		emit(r)
		"#,
	) else {
		return;
	};
	assert_eq!(out["step"], 3, "never on the via: {out}");
	assert_eq!(out["tick"], true, "{out}");
}

// #4486: Loch Modan's "Westfall" step, a goto at the road in from Elwynn (59.9,19.4, labelled Sentinel Hill), held a
// Gnome Warrior who had flown to Sentinel Hill: the arrow sent him north to the road and back. As a via it is
// behind a player who lands at Sentinel Hill's flight master: the arrow leads straight to Gryan Stoutmantle.
const WESTFALL: &str = r#"
Polestar.RegisterGuide({ id = "test/westfall", pack = "test", title = "Loch Modan, Redridge Mountains & Westfall", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Lakeshire", goals = { { t = "accept", quest = 9005, title = "Errand", npc = 4, npcName = "Courier", map = 1433, x = 26.5, y = 44.9 } } },
	{ title = "Westfall", via = true, note = "West through Westbrook into Westfall.", goals = { { t = "goto", text = "Sentinel Hill", map = 1436, x = 59.9, y = 19.4, f = "e" } } },
	{ title = "Sentinel Hill", goals = { { t = "turnin", quest = 132, title = "The Defias Brotherhood", npc = 234, npcName = "Gryan Stoutmantle", map = 1436, x = 56.18, y = 47.48 } } },
} })
"#;

#[test]
fn flown_to_sentinel_hill_the_road_in_from_elwynn_is_behind_and_the_arrow_goes_to_gryan_4486() {
	let Some(out) = run(
		"w.moveTo(1436, 56.55, 52.65)\nw.setZone(\"Westfall\", \"Sentinel Hill\")",
		"",
		WESTFALL,
		r#"
		stub.world.complete({ 9005 })
		stub.world.accept(132, {}, "The Defias Brotherhood")
		E.SetGuide("test/westfall"); stub.advance(1)
		emit(look())
		"#,
	) else {
		return;
	};
	assert_eq!(json!([out["step"], out["numbers"]]), json!([3, [1, "-", 2]]), "{out}");
	assert_eq!(json!([out["map"], out["x"], out["via"]]), json!([1436, 56.18, false]), "straight to Gryan, not north to the road: {out}");
}

// Hyjal: "Fly to Everlook" (a via now, its landing the town's flight master for the character's side), then Nami
// in Everlook. From Nighthaven, the Hearthstone bound in Everlook: Nami's step says what and where, and its travel
// line is the planner's way.
const HYJAL: &str = r#"
Polestar.RegisterGuide({ id = "test/hyjal", pack = "test", title = "Mount Hyjal", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Rabine Saturna", goals = { { t = "accept", quest = 9004, title = "Errand", npc = 11801, npcName = "Rabine Saturna", map = 1450, x = 51.6, y = 45.0 } } },
	{ title = "Fly to Everlook", via = true, goals = { { t = "fly", location = "Everlook", area = 2255 } } },
	{ title = "Nami", goals = { { t = "turnin", quest = 92008, title = "Premiere Parts", npc = 228216, npcName = "Nami", map = 1452, x = 61.3, y = 36.93 } } },
} })
"#;

#[test]
fn the_step_after_a_flight_via_says_what_and_where_and_its_travel_line_is_the_way_4467() {
	let Some(out) = run(
		"w.moveTo(1450, 51.64, 44.99)\nw.setZone(\"Moonglade\", \"Nighthaven\")",
		"w.bind(\"Everlook\")\nw.addItem(6948, 1)",
		HYJAL,
		r#"
		known(26, 27, 49, 52, 64, 65)
		stub.world.complete({ 9004 })
		stub.world.accept(92008, {}, "Premiere Parts")
		E.SetGuide("test/hyjal"); stub.advance(1)
		emit(look())
		"#,
	) else {
		return;
	};
	assert_eq!(json!([out["step"], out["number"], out["total"]]), json!([3, 2, 2]), "{out}");
	assert_eq!(out["title"], "Nami · Winterspring", "{out}");
	assert_eq!(out["legs"][0], "hearth", "{out}");
	assert_eq!(out["travel"], "Hearth to Everlook", "{out}");
}

// The Ashenvale guide's step 44 (07-ashenvale, "The Earthen Ring"), as the compiler writes it: walking north from
// Camp Taurajo, the vias "North of Thunder Bluff" (no height) and "Skywatcher Plateau" at the plateau's north end
// (30.5,8.2, up on it: z 188.6), then Yorn Grimtotem in the camp on top (32.43,20.03, z 188.6). Going on to the
// plateau's north end is a detour (about 2.6 times the way from the first via straight to Yorn): the way round
// the cliffs and up.
const SKYWATCHER: &str = r#"
Polestar.RegisterGuide({ id = "test/sky", pack = "test", title = "Ashenvale", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Camp Taurajo", goals = { { t = "accept", quest = 9001, title = "Letter", npc = 1, npcName = "Grunt", map = 1413, x = 44.9, y = 59.1 } } },
	{ title = "Skywatcher Plateau", via = true, goals = { { t = "goto", text = "North of Thunder Bluff", map = 1412, x = 40.6, y = 22.2, f = "e" } } },
	{ title = "Skywatcher Plateau", via = true, goals = { { t = "goto", text = "Skywatcher Plateau", map = 1412, x = 30.5, y = 8.2, z = 188.6, f = "e" } } },
	{ title = "The Earthen Ring", goals = { { t = "accept", quest = 96260, title = "Stronger than Steel", npc = 264072, npcName = "Yorn Grimtotem", map = 1412, x = 32.43, y = 20.03, z = 188.6 } } },
} })
"#;
const TAUREN: &str = "w.race, w.raceName, w.faction = \"Tauren\", \"Tauren\", \"Horde\"\nw.class, w.className = \"WARLOCK\", \"Warlock\"\nw.level = 28";
// East of Thunder Bluff, on the ground, walking north.
const EAST_OF_THE_BLUFFS: &str = "w.moveTo(1412, 46.0, 33.0, 0)\nw.setZone(\"Mulgore\", \"Red Rocks\")";
// Yards between two Mulgore points, the arrow's state and number, and the via steps' arrival chime counted.
const SKY_HELPERS: &str = r#"
	local C = Polestar.Compat
	function yd(x1, y1, x2, y2)
		local _, a, b = C.MapToWorld(1412, x1, y1)
		local _, c, d = C.MapToWorld(1412, x2, y2)
		return math.sqrt((a - c) ^ 2 + (b - d) ^ 2)
	end
	function arrow()
		local state, d = N.Sample()
		return { state = state, yards = d and math.floor(d + 0.5) or false }
	end
	PING = (SOUNDKIT and SOUNDKIT.MAP_PING) or 3175
	function chimes()
		local n = 0
		for _, s in ipairs(stub.sounds) do if s == PING then n = n + 1 end end
		return n
	end
	Polestar.Set("nav.arrivalSound", true)
	-- The planner's estimates: how many in all, and the most one via verdict made in one refresh.
	local T, est = N.travel, N.EstimateTravel
	CALLS, WORST, VIA_CALLS = 0, 0, 0
	N.EstimateTravel = function(...) CALLS = CALLS + 1; return est(...) end
	local faster = T.ViaFaster
	T.ViaFaster = function(...)
		local before = CALLS
		local a, b = faster(...)
		WORST, VIA_CALLS = math.max(WORST, CALLS - before), VIA_CALLS + CALLS - before
		return a, b
	end
	stub.world.accept(9001, {}, "Letter")
	E.SetGuide("test/sky"); stub.advance(1)
"#;

#[test]
fn skywatcher_no_chime_at_a_via_the_yards_count_to_yorn_the_way_round_is_kept_and_the_plateau_is_reached_on_top_4467() {
	let script = format!(
		r#"{SKY_HELPERS}
		local r = {{ start = look(), arrow = arrow(), toVia = yd(46, 33, 40.6, 22.2), rest = yd(40.6, 22.2, 32.43, 20.03) }}
		-- Within reach of the first via: never "arrived", no chime; Nav tells the Engine this frame.
		stub.sounds = {{}}
		stub.world.moveTo(1412, 40.7, 22.3, 1)
		r.atFirst = arrow()
		stub.advance(0.3)
		r.afterFirst = look()
		-- Under the plateau's north end, on the ground: not reached from below.
		stub.world.moveTo(1412, 30.5, 8.25, 120); stub.advance(1)
		r.below = look()
		r.belowArrow = arrow()
		-- Up on it: reached, the arrow turns to Yorn.
		stub.world.moveTo(1412, 30.5, 8.25, 188); stub.advance(1)
		r.onTop = look()
		r.chimes = chimes()
		r.worst = WORST
		-- The chime itself works here: a point of the player's own, reached.
		N.SetTarget(1412, 31.0, 9.0, "Here"); stub.world.moveTo(1412, 31.0, 9.0, 188); N.Sample(); stub.advance(0.2)
		r.control = chimes()
		emit(r)
		"#
	);
	let Some(out) = run(EAST_OF_THE_BLUFFS, TAUREN, SKYWATCHER, &script) else {
		return;
	};
	assert_eq!(json!([out["start"]["step"], out["start"]["x"], out["start"]["via"]]), json!([4, 40.6, 2]), "the arrow goes by north of Thunder Bluff: {out}");
	// The number is the way left to Yorn: to the via and on from it, never the via's own yards.
	let (to_via, rest) = (out["toVia"].as_f64().unwrap(), out["rest"].as_f64().unwrap());
	if let Some(yards) = out["arrow"]["yards"].as_f64() {
		assert!(yards >= to_via + rest - 1.0, "the yards count to Yorn ({to_via:.0} + {rest:.0}): {out}");
	}
	assert_ne!(out["atFirst"]["state"], "arrived", "a via is never 'arrived': {out}");
	assert_eq!(json!([out["afterFirst"]["step"], out["afterFirst"]["x"], out["afterFirst"]["via"]]), json!([4, 30.5, 3]), "the way round to the plateau's north end is kept: {out}");
	assert_eq!(out["below"]["via"], 3, "under the plateau it is still ahead: {out}");
	assert_ne!(out["belowArrow"]["state"], "arrived", "{out}");
	assert_eq!(json!([out["onTop"]["step"], out["onTop"]["x"], out["onTop"]["via"]]), json!([4, 32.43, false]), "on top, the arrow turns to Yorn: {out}");
	assert_eq!(out["chimes"], 0, "no chime at a via: {out}");
	assert!(out["worst"].as_u64().unwrap() <= 1, "one estimate a refresh at most: {out}");
	assert_eq!(out["control"], 1, "the arrival chime plays at a real arrival: {out}");
}

#[test]
fn skywatcher_standing_beside_a_via_in_a_fight_and_over_ten_second_ticks_the_arrow_never_swings_back_4467() {
	let script = format!(
		r#"{SKY_HELPERS}
		-- 70 yd beside the first via: on the far side (still ahead) and on Yorn's side (past it).
		local per = yd(40, 22.2, 41, 22.2)
		local KEEP, PAST = {{ 40.6 + 70 / per, 22.2 }}, {{ 40.6 - 70 / per, 22.2 }}
		local function stand(p) stub.world.moveTo(1412, p[1], p[2], 1); stub.advance(1); return look().via end
		local r = {{ start = look().via, keep = stand(KEEP), past = stand(PAST), back = stand(KEEP), seen = {{}} }}
		for i = 1, 6 do
			stub.world.moveTo(1412, (i % 2 == 0 and KEEP or PAST)[1], 22.2, 1)
			stub.fire("PLAYER_REGEN_DISABLED"); stub.fire("UNIT_COMBAT", "player", "WOUND", "", 10, 1)
			stub.advance(0.2)
			r.seen[#r.seen + 1] = look().via
			stub.fire("PLAYER_REGEN_ENABLED")
			stub.advance(10)
			r.seen[#r.seen + 1] = look().via
		end
		-- Standing still once the verdict here is made (the first refresh at this place): no more estimates.
		E.RequestUpdate(); stub.advance(1)
		local calls = VIA_CALLS
		for _ = 1, 5 do E.RequestUpdate(); stub.advance(10) end
		r.still = VIA_CALLS - calls
		r.worst = WORST
		emit(r)
		"#
	);
	let Some(out) = run(EAST_OF_THE_BLUFFS, TAUREN, SKYWATCHER, &script) else {
		return;
	};
	assert_eq!(json!([out["start"], out["keep"]]), json!([2, 2]), "{out}");
	assert_eq!(out["past"], 3, "past the first via: on to the plateau's north end: {out}");
	assert_eq!(out["back"], 3, "a via passed stays passed: {out}");
	assert_eq!(out["seen"], json!([3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3]), "no swing back in a fight or over the ticks: {out}");
	assert_eq!(out["still"], 0, "estimates are reused while the player stays: {out}");
	assert!(out["worst"].as_u64().unwrap() <= 1, "{out}");
}
