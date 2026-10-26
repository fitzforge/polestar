//! Engine scenarios (addon/Polestar/Core/Engine.lua + Guides.lua + Commands.lua) against the stub world in
//! tests/lua/stub_world.lua, loading the real Core manifest.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.addMap(1453, { name = "Stormwind City", c = 0, left = 3000, right = 1500, top = 1500, bottom = 500 })
w.addMap(1411, { name = "Durotar", c = 1, left = 0, right = -3000, top = 0, bottom = -3000 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"; w.titles[7] = "Kobold Camp Cleanup"
"#;

// A Northshire-shaped route: accept -> turn in -> accept -> goto + kill -> class training (one step per class)
// -> turn in + level.
const NORTHSHIRE: &str = r#"
Polestar.RegisterGuide({
	id = "test/01-northshire", pack = "test", title = "Northshire Valley",
	faction = "Alliance", races = { "Human" }, minLevel = 1, maxLevel = 6,
	zone = 1429, next = "test/02-elwynn",
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Kobold camp", note = "Pull one at a time.", goals = {
			{ t = "goto", map = 1429, x = 47.6, y = 35.1, text = "Kobold camp", r = 10 },
			{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 },
		} },
		{ title = "Warrior training", only = { classes = { "WARRIOR" } }, goals = {
			{ t = "train", npc = 911, npcName = "Llane Beshere" },
		} },
		{ title = "Mage training", only = { classes = { "MAGE" } }, goals = {
			{ t = "train", npc = 198, npcName = "Khelden Bremen" },
		} },
		{ title = "Back to the abbey", goals = {
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
			{ t = "note", text = "Dwarves: talk to Grelin.", only = { races = { "Dwarf" } } },
			{ t = "level", level = 5, only = { races = { "Gnome" } } },
			{ t = "level", level = 4 },
		} },
	},
})
"#;

const ELWYNN: &str = r#"
Polestar.RegisterGuide({
	id = "test/02-elwynn", pack = "test", title = "Elwynn Forest",
	faction = "Alliance", minLevel = 5, maxLevel = 12, zone = 1429,
	steps = {
		{ goals = { { t = "accept", quest = 60, title = "Kobold Candles", npc = 253, npcName = "William Pestle" } } },
		{ goals = { { t = "level", level = 12 } } },
	},
})
"#;

// Records the Engine's messages as "NAME arg" strings, in order.
const RECORDER: &str = r#"
LOG = {}
for _, m in ipairs({ "GUIDE_CHANGED", "STEP_CHANGED", "STEP_UPDATED", "WAYPOINT_CHANGED", "GUIDE_COMPLETED" }) do
	Polestar.On(m, function(a)
		local v = a
		if m == "WAYPOINT_CHANGED" then v = a and (a.stepIndex .. ":" .. a.goalIndex) or "nil" end
		LOG[#LOG + 1] = m .. " " .. tostring(v)
	end)
end
function flush() stub.advance(0.25) end
function takeLog() local l = LOG; LOG = {}; return l end
function activeTickers()
	local n = 0
	for _, t in ipairs(stub.timers) do if t.handle and not t.cancelled then n = n + 1 end end
	return n
end
E = Polestar.Engine
"#;

struct Run<'a> {
	guides: &'a str,
	before: &'a str,
	saved: Option<&'a str>,
	script: &'a str,
	login: bool,
	/// Load addon/Polestar by its TOC instead of the Core manifest alone.
	full: bool,
}

impl Default for Run<'_> {
	fn default() -> Self {
		Run { guides: NORTHSHIRE, before: "", saved: None, script: "", login: true, full: false }
	}
}

fn run(o: Run) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{}", o.before),
		addons: vec![if o.full { Addon::name("Polestar") } else { Addon::files("Polestar", &["Core/Core.xml"]) }],
		saved: o.saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		login: false,
		script: [TEST_PACK, TEST_SOURCE, o.guides, RECORDER, if o.login { "stub.login()" } else { "" }, o.script].join("\n"),
	})
}

fn run1(o: Run) -> Value {
	run(o).remove(0)
}

#[test]
fn accept_objectives_and_turn_in_advance_the_steps_and_fire_messages_in_order() {
	let out = run(Run {
		script: r#"
			local w = stub.world
			w.accept(783, {}); flush()
			w.turnIn(783); flush()
			w.accept(7, { 10 }); flush()
			w.progress(7, 1, 3); flush()
			local v = E.GetStepView(3)
			local wp = E.GetWaypoint()
			w.progress(7, 1, 10); flush()
			w.trainer(911); flush()
			w.close()
			w.turnIn(7); flush()
			w.setLevel(4); flush()
			emit(takeLog())
			emit(v)
			emit(wp)
		"#,
		..Default::default()
	});
	let (log, view3, wp) = (&out[0], &out[1], &out[2]);
	assert_eq!(
		*log,
		json!([
			"GUIDE_CHANGED test/01-northshire",
			"STEP_CHANGED 1",
			"WAYPOINT_CHANGED 1:1",
			"STEP_CHANGED 2",
			"WAYPOINT_CHANGED 2:1",
			"STEP_UPDATED 2",
			"WAYPOINT_CHANGED 2:2",
			"STEP_CHANGED 3",
			"WAYPOINT_CHANGED 3:2",
			"STEP_UPDATED 3",
			"STEP_CHANGED 4",
			"WAYPOINT_CHANGED nil",
			"STEP_CHANGED 6",
			"WAYPOINT_CHANGED 6:1",
			"STEP_UPDATED 6",
			"WAYPOINT_CHANGED nil",
			"STEP_CHANGED nil",
			"GUIDE_COMPLETED test/01-northshire",
		])
	);
	assert_eq!(view3["status"], "current");
	assert_eq!(view3["note"], "Pull one at a time.");
	let goals: Vec<Value> = view3["goals"].as_array().unwrap().iter().map(|g| json!([g["status"], g["text"], g["verb"], g["subject"], g["subjectKind"], g["detail"], g["manual"]])).collect();
	assert_eq!(
		json!(goals),
		json!([
			["active", "Go to Kobold camp", "Go to", "Kobold camp", "place", "Elwynn Forest", false],
			["active", "Kill Kobold Vermin", "Kill", "Kobold Vermin", "npc", "for Kobold Camp Cleanup", false],
		])
	);
	assert_eq!(view3["goals"][1]["progress"], json!({ "cur": 3, "max": 10, "kind": "count" }));
	assert_eq!(view3["goals"][1]["quest"], 7);
	// Which objective of the quest it is (the party line reads it).
	assert_eq!(view3["goals"][1]["oi"], 1);
	assert_eq!(view3["goals"][1]["npc"], 6);
	// The camp's Go to names the step (its header): the arrow leads to the kobolds.
	assert_eq!(*wp, json!({ "map": 1429, "x": 47.6, "y": 35.1, "label": "Kill Kobold Vermin", "stepIndex": 3, "goalIndex": 2, "kind": "kill", "r": 8 }));
}

#[test]
fn an_alt_with_quests_already_done_starts_at_the_first_step_that_is_not_done() {
	let out = run1(Run {
		before: "w.complete({ 783 }); w.onQuest(7, { { required = 10, fulfilled = 4 } })",
		script: r#"
			local s = {}
			for i = 1, E.GetStepCount() do s[i] = E.GetStepView(i).status end
			local done, total = E.GetProgress()
			emit({ index = E.GetStepIndex(), statuses = s, progress = E.GetStepView(3).goals[2].progress, done = done, total = total,
				log = takeLog() })
		"#,
		..Default::default()
	});
	assert_eq!(
		out,
		json!({
			"index": 3,
			"statuses": ["done", "done", "current", "upcoming", "na", "upcoming"],
			"progress": { "cur": 4, "max": 10, "kind": "count" },
			"done": 2,
			"total": 5,
			"log": ["GUIDE_CHANGED test/01-northshire", "STEP_CHANGED 3", "WAYPOINT_CHANGED 3:2"],
		})
	);
}

#[test]
fn only_on_steps_and_goals_filters_by_class_and_race() {
	let out = run1(Run {
		before: r#"w.class = "MAGE"; w.className = "Mage"; w.level = 4
			w.complete({ 783 }); w.onQuest(7, { { required = 10, fulfilled = 10 } })"#,
		script: r#"
			local at = E.GetStepIndex()
			local v4, v6 = E.GetStepView(4), E.GetStepView(6)
			stub.world.trainer(198); flush()
			local g = {}
			for i, goal in ipairs(v6.goals) do g[i] = goal.status end
			emit({ at = at, s4 = v4.status, s4goal = v4.goals[1].status, s6 = v6.status, goals6 = g,
				after = E.GetStepIndex(), total = select(2, E.GetProgress()) })
		"#,
		..Default::default()
	});
	assert_eq!(
		out,
		json!({
			"at": 5,
			"s4": "na",
			"s4goal": "na",
			"s6": "upcoming",
			"goals6": ["pending", "na", "na", "done"],
			"after": 6,
			"total": 5,
		})
	);
}

// The XP bar's guide mark (QoL/XPMark) reads the level the guide expects next.
#[test]
fn leveltarget_the_first_level_goal_for_this_character_from_the_step_shown_above_their_level_not_skipped() {
	let [human, gnome] = [false, true].map(|is_gnome| {
		run1(Run {
			before: if is_gnome { r#"w.race = "Gnome"; w.raceName = "Gnome"; w.raceID = 7"# } else { "" },
			script: r#"
			E.SetGuide("test/01-northshire"); flush()
			local out = {}
			out.start = { E.LevelTarget() }
			out.at4 = { E.LevelTarget(4) }
			out.at3 = { E.LevelTarget(3) }
			E.Goto(6); flush()
			E.Skip(); flush()
			E.Goto(3); flush()
			out.skipped = { E.LevelTarget() }
			out.shown = E.GetStepIndex()
			emit(out)
		"#,
			..Default::default()
		})
	});
	assert_eq!(human, json!({ "start": [4, 6], "at4": {}, "at3": [4, 6], "skipped": {}, "shown": 3 }), "the Gnomes' level 5 is not a Human's");
	assert_eq!(gnome, json!({ "start": [5, 6], "at4": [5, 6], "at3": [5, 6], "skipped": {}, "shown": 3 }));
}

#[test]
fn goto_completes_on_arrival_via_the_ticker_which_runs_only_while_a_goto_is_active() {
	let out = run1(Run {
		before: "w.complete({ 783 }); w.onQuest(7, { 10 })",
		script: r#"
			local w = stub.world
			takeLog()
			local before = activeTickers()
			stub.advance(2)
			local stillActive = E.GetStepView(3).goals[1].status
			w.moveTo(1429, 47.7, 35.3) -- about 5 yards from the camp, r = 10
			stub.advance(0.6)
			emit({ before = before, stillActive = stillActive, after = E.GetStepView(3).goals[1].status,
				wp = E.GetWaypoint().goalIndex, tickers = activeTickers(), log = takeLog() })
		"#,
		..Default::default()
	});
	// The arrow is on the kobolds from the start (the camp's Go to is the step's header), so arriving moves
	// nothing.
	assert_eq!(
		out,
		json!({
			"before": 1,
			"stillActive": "active",
			"after": "done",
			"wp": 2,
			"tickers": 0,
			"log": ["STEP_UPDATED 3"],
		})
	);
}

#[test]
fn goto_is_done_once_a_later_goal_in_its_step_is_done_without_arriving() {
	let out = run1(Run {
		before: "w.complete({ 783 }); w.onQuest(7, { { required = 10, fulfilled = 9 } })",
		script: r#"
			stub.world.progress(7, 1, 10); flush()
			emit({ index = E.GetStepIndex(), goto = E.GetStepView(3).goals[1].status, s3 = E.GetStepView(3).status })
		"#,
		..Default::default()
	});
	assert_eq!(out, json!({ "index": 4, "goto": "done", "s3": "done" }));
}

#[test]
fn a_goto_that_leads_into_the_next_step_is_done_once_that_step_s_quest_work_is_so_work_done_ahead_never_sends_the_player_back_to_the_cave_mouth_240() {
	// Durotar's Burning Blade Coven: the mouth in a step of its own, then the Medallion inside. Gruko had the
	// Medallion already and was sent back to the mouth. A mouth ending a step of other work counts the same
	// way; a goto ahead of a step with no quest work (training, a level) still holds, and so does one with
	// optional work after it in its own step (the Wailing Caverns mound), which is where that work is.
	const COVEN: &str = r#"
Polestar.RegisterGuide({ id = "test/coven", pack = "test", title = "Coven", zone = 1429, steps = {
	{ title = "Zureetha", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
	{ title = "Burning Blade Coven", goals = { { t = "goto", map = 1429, x = 20, y = 20, text = "Burning Blade Coven" } } },
	{ title = "Yarrog", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 22, y = 18 } } },
	{ title = "Familiars", goals = {
		{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, map = 1429, x = 48.2, y = 42.0 },
		{ t = "goto", map = 1429, x = 20, y = 20, text = "Burning Blade Coven" },
	} },
	{ title = "Pick", goals = { { t = "turnin", quest = 783, title = "A Threat Within", npc = 197, map = 1429, x = 22, y = 18 } } },
	{ title = "Trainer", goals = { { t = "goto", map = 1429, x = 80, y = 80, text = "Trainer" } } },
	{ title = "Level", goals = { { t = "level", level = 1 } } },
	{ title = "Mound", goals = {
		{ t = "goto", map = 1429, x = 60, y = 60, text = "Mound" },
		{ t = "kill", target = "Defias Bandit", npc = 116, map = 1429, x = 60, y = 60, optional = true },
	} },
	{ title = "Regthar", goals = { { t = "turnin", quest = 783, title = "A Threat Within", npc = 197, map = 1429, x = 62, y = 60 } } },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;
	let out = run1(Run {
		guides: COVEN,
		script: r#"
			local w = stub.world
			E.SetGuide("test/coven"); flush()
			w.accept(7, { 10 }); flush()
			local mouth = E.GetStepIndex()
			w.progress(7, 1, 10); flush()
			local medallion = { index = E.GetStepIndex(), goto = E.GetStepView(2).goals[1].status }
			w.accept(783, {}); flush()
			local familiars = E.GetStepIndex()
			w.turnIn(783); flush()
			emit({ mouth = mouth, medallion = medallion, familiars = familiars, trainer = E.GetStepIndex(),
				mound = E.GetStepView(8).goals[1].status })
		"#,
		..Default::default()
	});
	assert_eq!(
		out,
		json!({
			"mouth": 2, // the Medallion not yet in the bags: the mouth holds
			"medallion": { "index": 4, "goto": "done" },
			"familiars": 4,
			"trainer": 6,
			"mound": "pending",
		})
	);
}

#[test]
fn a_goto_ahead_of_a_step_done_only_through_class_quests_a_skipped_step_or_unavailable_quests_still_holds_240() {
	// What counts as the player having been through the next step is what placement counts (anchorStep): its
	// own quest work. A Warrior who took The Islander anywhere is not in Orgrimmar (Arathi's zeppelin, Sorek's
	// accept `only Warrior`); a step the player skipped or one whose only quest the giver will never offer
	// proves nothing either. The last pair is the control.
	const STEPS: &str = r#"
Polestar.RegisterGuide({ id = "test/evidence", pack = "test", title = "Evidence", zone = 1429, steps = {
	{ title = "Hold", goals = { { t = "level", level = 60 } } },
	{ title = "Zeppelin", goals = { { t = "goto", map = 1429, x = 20, y = 20, text = "Zeppelin" } } },
	{ title = "Sorek", goals = { { t = "turnin", quest = 783, title = "A Threat Within", npc = 197, map = 1429, x = 22, y = 20, only = { classes = { "WARRIOR" } } } } },
	{ title = "Path", goals = { { t = "goto", map = 1429, x = 30, y = 20, text = "Path" } } },
	{ title = "Warrior trainer", only = { classes = { "WARRIOR" } }, goals = { { t = "turnin", quest = 783, title = "A Threat Within", npc = 197, map = 1429, x = 32, y = 20 } } },
	{ title = "Cave", goals = { { t = "goto", map = 1429, x = 40, y = 20, text = "Cave" } } },
	{ title = "Skipped", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 42, y = 20 } } },
	{ title = "Dock", goals = { { t = "goto", map = 1429, x = 50, y = 20, text = "Dock" } } },
	{ title = "Closed", goals = { { t = "accept", quest = 60, title = "Kobold Candles", npc = 253, map = 1429, x = 52, y = 20, closedBy = { 783 } } } },
	{ title = "Mouth", goals = { { t = "goto", map = 1429, x = 60, y = 20, text = "Mouth" } } },
	{ title = "Inside", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 62, y = 20 } } },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;
	let out = run1(Run {
		guides: STEPS,
		script: r#"
			local w = stub.world
			E.SetGuide("test/evidence"); flush()
			E.Goto(7); E.Skip(); flush()
			w.accept(783, {}); w.turnIn(783); w.accept(7, {}); w.turnIn(7); flush()
			emit({ skipped = PolestarCharDB.skipped["test/evidence"][7] == true,
				gotos = { E.GetStepView(2).goals[1].status, E.GetStepView(4).goals[1].status, E.GetStepView(6).goals[1].status,
				E.GetStepView(8).goals[1].status, E.GetStepView(10).goals[1].status } })
		"#,
		..Default::default()
	});
	assert_eq!(out["skipped"], true, "the turn-in after the cave was skipped");
	let done: Vec<bool> = out["gotos"].as_array().unwrap().iter().map(|st| st == "done").collect();
	assert_eq!(done, vec![false, false, false, false, true], "only the goto ahead of quest work everyone does is done");
}

#[test]
fn a_kill_goal_with_spawn_areas_points_at_the_area_nearest_the_player_switching_only_once_another_is_clearly_nearer() {
	// Elwynn here is 30 yd per map percent across: the two areas are 600 yd apart, radius 30.
	const SPOTS: &str = r#"
Polestar.RegisterGuide({ id = "test/spots", pack = "test", title = "Spots", zone = 1429, steps = {
	{ goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 40, y = 50,
		spots = { { x = 40, y = 50, r = 30, n = 5 }, { x = 60, y = 50, r = 30, n = 4 } } } } },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;
	let out = run1(Run {
		guides: SPOTS,
		before: "w.onQuest(7, { 10 }); w.moveTo(1429, 38, 50)",
		script: r#"
			local w = stub.world
			E.SetGuide("test/spots"); flush()
			local seen = {}
			local function snap()
				local wp = E.GetWaypoint()
				seen[#seen + 1] = { wp.x, wp.area, wp.r, E.GetStepView(1).goals[1].x }
			end
			snap()
			takeLog()
			-- midpoint, just past it (30 yd nearer the east edge), well past it, back just past the midpoint, home
			for _, x in ipairs({ 50, 50.5, 52, 49.5, 38 }) do
				w.moveTo(1429, x, 50)
				stub.advance(1)
				snap()
			end
			emit({ seen = seen, log = takeLog() })
		"#,
		..Default::default()
	});
	assert_eq!(
		out["seen"],
		json!([
			[40, 30, 8, 40], // inside the west area
			[40, 30, 8, 40], // midpoint: both edges 270 yd away
			[40, 30, 8, 40], // east edge 30 yd nearer: not enough to switch
			[60, 30, 8, 60], // east edge 120 yd nearer: switched
			[60, 30, 8, 60], // back past the midpoint by 15 yd: no flap
			[40, 30, 8, 40],
		])
	);
	let wps: Vec<Value> = out["log"].as_array().unwrap().iter().filter(|l| l.as_str().unwrap().starts_with("WAYPOINT_CHANGED")).cloned().collect();
	assert_eq!(json!(wps), json!(["WAYPOINT_CHANGED 1:1", "WAYPOINT_CHANGED 1:1"]));
}

// An area objective: three spots along y = 50 (Elwynn here: 30 yd per map percent across), radius 30 each.
const SEARCH: &str = r#"
Polestar.RegisterGuide({ id = "test/search", pack = "test", title = "Search", zone = 1429, steps = {
	{ goals = { { t = "collect", item = 5062, itemName = "Raptor Head", count = 12, quest = 7, oi = 1, map = 1429, x = 20, y = 50, spread = true,
		spots = { { x = 20, y = 50, r = 30, n = 3 }, { x = 40, y = 50, r = 30, n = 2 }, { x = 80, y = 50, r = 30, n = 1 } } } } },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

#[test]
fn an_area_objective_walks_a_circuit_a_visited_spot_is_skipped_for_a_while_the_next_is_the_nearest_not_visited() {
	let out = run1(Run {
		guides: SEARCH,
		before: "w.onQuest(7, { 12 }); w.moveTo(1429, 20, 50)",
		script: r#"
			local w = stub.world
			E.SetGuide("test/search"); flush()
			local seen = {}
			local function at(x)
				w.moveTo(1429, x, 50)
				stub.advance(1)
				local wp = E.GetWaypoint()
				seen[#seen + 1] = { x, wp.x, wp.spot }
			end
			local wp = E.GetWaypoint()
			local first = { wp.x, wp.search, #wp.spots, wp.spot, wp.area }
			at(20.8) -- still inside the first spot (24 yd from its centre)
			at(30)   -- left it: the nearest not visited
			at(40)   -- searching the second
			at(60)   -- left it: the third (the first was visited)
			at(80)   -- searching the third
			at(50)   -- all visited: the one visited longest ago
			stub.advance(400)
			at(55)   -- visits forgotten: the nearest again
			local v = E.GetStepView(1).goals[1]
			emit({ first = first, seen = seen, view = { v.spots, v.spread, v.x } })
		"#,
		..Default::default()
	});
	assert_eq!(out["first"], json!([20, true, 3, 1, 30]));
	assert_eq!(out["seen"], json!([[20.8, 20, 1], [30, 40, 2], [40, 40, 2], [60, 80, 3], [80, 80, 3], [50, 20, 1], [55, 40, 2]]));
	assert_eq!(out["view"], json!([3, true, 40]));
}

#[test]
fn cyclespot_moves_an_area_objective_on_by_hand_to_the_next_spot_or_a_chosen_one_which_holds_until_reached() {
	let out = run1(Run {
		guides: SEARCH,
		before: "w.onQuest(7, { 12 }); w.moveTo(1429, 20, 50)",
		script: r#"
			E.SetGuide("test/search"); flush()
			local r = {}
			r.next = E.CycleSpot(1, 1)
			r.afterNext = E.GetWaypoint().x
			stub.advance(2)
			r.held = E.GetWaypoint().x       -- standing in the first spot: the pick holds
			r.chosen = E.CycleSpot(1, 1, 3)
			stub.advance(2)
			r.afterChosen = E.GetWaypoint().x
			r.none = E.CycleSpot(1, 2) or false
			emit(r)
		"#,
		..Default::default()
	});
	assert_eq!(out, json!({ "next": 2, "afterNext": 40, "held": 40, "chosen": 3, "afterChosen": 80, "none": false }));
}

#[test]
fn another_place_the_target_spawns_alt_is_never_picked_on_its_own_moving_on_by_hand_reaches_it_and_every_other_place() {
	// Camps at 40 and 60 along y = 50, and another place at 30 (alt), radius 30 each. The player stands inside
	// the alt.
	const ALT: &str = r#"
Polestar.RegisterGuide({ id = "test/alt", pack = "test", title = "Alt", zone = 1429, steps = {
	{ goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 40, y = 50,
		spots = { { x = 40, y = 50, r = 30, n = 5 }, { x = 60, y = 50, r = 30, n = 4 }, { x = 30, y = 50, r = 30, n = 1, alt = true } } } } },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;
	let out = run1(Run {
		guides: ALT,
		before: "w.onQuest(7, { 10 }); w.moveTo(1429, 29, 50)",
		script: r#"
			local w = stub.world
			E.SetGuide("test/alt"); flush()
			local r = {}
			r.start = E.GetWaypoint().x
			stub.advance(1)
			r.still = E.GetWaypoint().x
			r.walk = {}
			for i = 1, 3 do
				local index = E.CycleSpot(1, 1)
				r.walk[i] = { index, E.GetWaypoint().x }
			end
			E.CycleSpot(1, 1, 3)
			stub.advance(2)
			r.held = E.GetWaypoint().x
			w.moveTo(1429, 40, 50)
			stub.advance(1)
			r.back = E.GetWaypoint().x
			r.count = E.GetStepView(1).goals[1].spots
			emit(r)
		"#,
		..Default::default()
	});
	assert_eq!(out["start"], 40, "the nearest camp, though the player stands in the alt");
	assert_eq!(out["still"], 40);
	assert_eq!(out["walk"], json!([[3, 30], [2, 60], [1, 40]]), "by hand: the alt (nearest), the far camp, then the one visited longest ago");
	assert_eq!(out["held"], 30, "a place picked by hand holds while the player is there");
	assert_eq!(out["back"], 40, "walking on, the arrow returns to the camps");
	assert_eq!(out["count"], 3);
}

#[test]
fn a_circuit_of_waypoints_in_one_step_costs_one_pass_over_the_step_and_a_later_arrival_covers_the_earlier_ones() {
	// Gathering guides loop a dozen or more waypoints in one step until a skill rank: checking each goto
	// against the goals after it once (not through their own later goals again) keeps that linear.
	let n = 22;
	let gotos = (0..n).map(|i| format!("{{ t = \"goto\", map = 1429, x = {}, y = 70, r = 5 }}", 10 + i * 3)).collect::<Vec<_>>().join(",\n");
	let guide = r#"
		Polestar.RegisterGuide({ id = "test/circuit", pack = "test", title = "Circuit", minLevel = 1, maxLevel = 60, steps = {
			{ goals = { {GOTOS}, { t = "level", level = 3 } } },
			{ goals = { { t = "level", level = 60 } } },
		} })
	"#
	.replace("{GOTOS}", &gotos);
	let script = r#"
			local t0 = os.clock()
			E.SetGuide("test/circuit")
			stub.advance(1)
			local open = 0
			for _, g in ipairs(E.GetStepView(1).goals) do if g.status == "active" then open = open + 1 end end
			stub.world.moveTo(1429, {WP10}, 70) -- waypoint 10
			stub.advance(1)
			local view = E.GetStepView(1)
			local s = {}
			for i = 1, {N} do s[i] = view.goals[i].status end
			stub.world.setLevel(3)
			stub.advance(1)
			emit({ open = open, early = s[9], at = s[10], late = s[11], step = E.GetStepIndex(), seconds = os.clock() - t0 })
		"#
	.replace("{WP10}", &(10 + 9 * 3).to_string())
	.replace("{N}", &n.to_string());
	let out = run1(Run { guides: &guide, before: "w.moveTo(1429, 90, 90)", script: &script, ..Default::default() });
	assert_eq!(out["open"], n + 1, "every waypoint and the level are open at the start");
	assert_eq!(json!({ "early": out["early"], "at": out["at"], "late": out["late"], "step": out["step"] }), json!({ "early": "done", "at": "done", "late": "active", "step": 2 }));
	let seconds = out["seconds"].as_f64().unwrap();
	assert!(seconds < 0.5, "took {seconds:.2} s of CPU");
}

#[test]
fn era_frame_goto_coordinates_convert_through_the_registered_era_bounds() {
	let guide = r#"
		Polestar.RegisterMapFrames({ era = { [1429] = { c = 0, left = 1600, right = -1400, top = 600, bottom = -1400 } } }, "guides")
		Polestar.RegisterGuide({ id = "test/era", pack = "test", title = "Era", minLevel = 1, maxLevel = 60, steps = {
			{ goals = { { t = "goto", map = 1429, x = 50, y = 50, f = "e" } } },
			{ goals = { { t = "level", level = 60 } } },
		} })
	"#;
	let out = run1(Run {
		guides: guide,
		before: "w.moveTo(1429, 50, 50)",
		script: r#"
			stub.advance(1)
			local atSamePercent = E.GetStepIndex()
			stub.world.moveTo(1429, 46.67, 45) -- the same world spot in the live frame
			stub.advance(1)
			emit({ atSamePercent = atSamePercent, after = E.GetStepIndex() })
		"#,
		..Default::default()
	});
	assert_eq!(out, json!({ "atSamePercent": 1, "after": 2 }));
}

#[test]
fn check_offs_are_stored_per_guide_survive_recomputes_and_a_reload_and_toggle_off_any_goal_ticks_not_only_manual_ones() {
	let guide = r#"
		Polestar.RegisterGuide({ id = "test/manual", pack = "test", title = "Manual", minLevel = 1, maxLevel = 10, steps = {
			{ goals = { { t = "talk", npc = 197, npcName = "Marshal McBride" } } },
			{ goals = { { t = "kill", target = "Young Wolf", count = 5 }, { t = "level", level = 2 } } },
			{ goals = { { t = "hearth", location = "Goldshire" } } },
		} })
	"#;
	let first = run1(Run {
		guides: guide,
		script: r#"
			local w = stub.world
			local levelTick = E.ToggleGoal(2, 2)
			local ok = E.ToggleGoal(1, 1)
			local afterTalk = E.GetStepIndex()
			local view = E.GetStepView(2)
			E.ToggleGoal(2, 1)
			w.setLevel(2); flush()
			w.accept(5, { 1 }); w.addItem(1, 1); flush() -- unrelated recomputes
			emit({ levelTick = levelTick, ok = ok, afterTalk = afterTalk, manualFlags = { view.goals[1].manual, view.goals[2].manual },
				index = E.GetStepIndex(), saved = PolestarCharDB.manual["test/manual"] })
		"#,
		..Default::default()
	});
	assert_eq!(
		first,
		json!({
			"levelTick": true, // a level goal ticks like any other
			"ok": true,
			"afterTalk": 2,
			"manualFlags": [true, false],
			"index": 3,
			"saved": { "1:1": "tick", "2:1": "tick", "2:2": "tick" },
		})
	);

	let second = run1(Run {
		guides: guide,
		before: "w.level = 2",
		saved: Some(r#"PolestarCharDB = { schema = 1, guide = "test/manual", manual = { ["test/manual"] = { ["1:1"] = true, ["2:1"] = true } } }"#),
		script: r#"
			local resumed = E.GetStepIndex()
			E.ToggleGoal(1, 1)
			emit({ resumed = resumed, untoggled = E.GetStepIndex(), saved = PolestarCharDB.manual["test/manual"] })
		"#,
		..Default::default()
	});
	assert_eq!(second, json!({ "resumed": 3, "untoggled": 1, "saved": { "2:1": true } }));
}

#[test]
fn nil_savedvariables_at_login_still_resume_the_right_step_from_live_quest_state() {
	let both = format!("{NORTHSHIRE}{ELWYNN}");
	let cold = run1(Run {
		guides: &both,
		before: "w.level = 2; w.complete({ 783 }); w.onQuest(7, { 10 })",
		saved: Some("PolestarDB = nil; PolestarCharDB = nil"),
		script: "emit({ guide = E.GetGuide().id, index = E.GetStepIndex(), stored = PolestarCharDB.guide })",
		..Default::default()
	});
	assert_eq!(cold, json!({ "guide": "test/01-northshire", "index": 3, "stored": "test/01-northshire" }));

	let warm = run1(Run {
		guides: &both,
		before: "w.level = 2",
		saved: Some(r#"PolestarCharDB = { schema = 1, guide = "test/02-elwynn" }"#),
		script: "emit({ guide = E.GetGuide().id, index = E.GetStepIndex() })",
		..Default::default()
	});
	assert_eq!(warm, json!({ "guide": "test/02-elwynn", "index": 1 }));

	let off = run1(Run {
		guides: NORTHSHIRE,
		saved: Some("PolestarDB = { schema = 1, settings = { behavior = { autoSelectGuide = false } } }"),
		script: "emit({ guide = E.GetGuide() == nil, index = E.GetStepIndex() == nil })",
		..Default::default()
	});
	assert_eq!(off, json!({ "guide": true, "index": true }));
}

#[test]
fn suggest_matches_faction_race_and_class_then_level_preferring_specific_and_narrow_guides() {
	let guides = r#"
		local function g(id, t) t.id = "test/" .. id; t.pack = "test"; t.title = id; t.steps = { { goals = { { t = "level", level = 60 } } } }; Polestar.RegisterGuide(t) end
		g("human-1", { faction = "Alliance", races = { "Human" }, minLevel = 1, maxLevel = 6 })
		g("dwarf-1", { faction = "Alliance", races = { "Dwarf", "Gnome" }, minLevel = 1, maxLevel = 6 })
		g("alliance-5", { faction = "Alliance", minLevel = 5, maxLevel = 12 })
		g("alliance-10", { faction = "Alliance", minLevel = 10, maxLevel = 20 })
		g("warrior-10", { faction = "Alliance", classes = { "WARRIOR" }, minLevel = 10, maxLevel = 30 })
		g("horde-1", { faction = "Horde", minLevel = 1, maxLevel = 10 })
		g("profession", { minLevel = 1, maxLevel = 60, category = "Professions" })
	"#;
	let out = run1(Run {
		guides,
		login: false,
		script: r#"
			local w = stub.world
			local function s(race, class, faction, level)
				w.race, w.class, w.faction, w.level = race, class, faction, level
				return Polestar.Guides.Suggest()
			end
			emit({
				s("Human", "MAGE", "Alliance", 1), s("Dwarf", "MAGE", "Alliance", 3), s("Human", "MAGE", "Alliance", 6),
				s("Human", "MAGE", "Alliance", 7), s("Human", "MAGE", "Alliance", 11), s("Human", "WARRIOR", "Alliance", 11),
				s("Orc", "WARRIOR", "Horde", 4), s("Human", "MAGE", "Alliance", 25), s("Orc", "WARRIOR", "Horde", 40),
			})
		"#,
		..Default::default()
	});
	assert_eq!(out, json!(["test/human-1", "test/dwarf-1", "test/human-1", "test/alliance-5", "test/alliance-5", "test/warrior-10", "test/horde-1", "test/alliance-10", "test/horde-1"]));
}

// The Home tab lists Suggestions(): every guide that fits the character's level, best first, never a guide for
// another faction, race or class or a non-leveling one; when nothing fits, the nearest upcoming guide alone.
#[test]
fn suggestions_lists_every_leveling_guide_for_the_level_best_first_else_the_nearest_upcoming_one() {
	let guides = r#"
		local function g(id, t) t.id = "test/" .. id; t.pack = "test"; t.title = id; t.steps = { { goals = { { t = "level", level = 60 } } } }; Polestar.RegisterGuide(t) end
		g("human-1", { faction = "Alliance", races = { "Human" }, minLevel = 1, maxLevel = 6 })
		g("alliance-5", { faction = "Alliance", minLevel = 5, maxLevel = 12 })
		g("alliance-wide", { faction = "Alliance", minLevel = 1, maxLevel = 20 })
		g("dwarf-1", { faction = "Alliance", races = { "Dwarf" }, minLevel = 1, maxLevel = 6 })
		g("horde-1", { faction = "Horde", minLevel = 1, maxLevel = 10 })
		g("profession", { minLevel = 1, maxLevel = 60, category = "Professions" })
		g("alliance-30", { faction = "Alliance", minLevel = 30, maxLevel = 40 })
	"#;
	let out = run1(Run {
		guides,
		login: false,
		script: r#"
			local w = stub.world
			local function s(level)
				w.race, w.class, w.faction, w.level = "Human", "MAGE", "Alliance", level
				return Polestar.Guides.Suggestions()
			end
			emit({ s(5), s(25) })
		"#,
		..Default::default()
	});
	assert_eq!(out, json!([["test/human-1", "test/alliance-5", "test/alliance-wide"], ["test/alliance-30"]]));
}

// A quest that starts from an item the player must first get (here a rare elite's drop) reads as the quest, not
// as "Collect" + "Accept": the view says which of the two rows stands for both, and how the item is got.
#[test]
fn a_quest_started_by_a_dropped_item_is_one_line_the_collect_stands_for_it_then_the_accept_a_go_to_naming_the_step_is_its_header() {
	let guides = r#"
		Polestar.RegisterGuide({ id = "test/fog", pack = "test", title = "Field", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
			{ title = "Field of Giants", goals = {
				{ t = "goto", text = "Field of Giants", map = 1429, x = 44.7, y = 70.7 },
				{ t = "collect", item = 10621, itemName = "Runed Scroll", count = 1, map = 1429, x = 46, y = 70, note = "Aean Swiftriver",
					from = "Aean Swiftriver", fromKind = "npc", fromRank = 2, fromFaction = "A" },
				{ t = "accept", quest = 3513, title = "The Runed Scroll", item = 10621, itemName = "Runed Scroll", note = "Keep it" },
				{ t = "level", level = 20 },
			} },
		} })
	"#;
	let out = run1(Run {
		guides,
		before: r#"stub.world.faction = "Horde"; stub.world.race = "Undead"; stub.world.class = "WARLOCK"; stub.world.level = 18"#,
		script: r#"
			E.SetGuide("test/fog"); flush()
			local function shape()
				local v = E.GetStepView(1)
				local c, a = v.goals[2], v.goals[3]
				local s = c.starter or a.starter
				return { header = v.goals[1].header or false, cFolded = c.folded or false, aFolded = a.folded or false,
					starterOf = c.starterOf or false, cT = c.t, held = s and s.held or false, item = s and s.item,
					source = s and s.source and { s.source.name, s.source.rank, s.source.enemy } or false }
			end
			local r = { fresh = shape() }
			stub.world.addItem(10621, 1); flush()
			r.held = shape()
			stub.world.accept(3513, {}); flush()
			r.taken = shape()
			emit(r)
		"#,
		..Default::default()
	});
	assert_eq!(
		out["fresh"],
		json!({ "header": true, "cFolded": false, "aFolded": true, "starterOf": 3, "cT": "collect", "held": false, "item": "Runed Scroll", "source": ["Aean Swiftriver", 2, true] }),
		"the collect row stands for the quest; an Alliance NPC is one to kill"
	);
	assert_eq!(
		out["held"],
		json!({ "header": true, "cFolded": true, "aFolded": false, "starterOf": false, "cT": "collect", "held": true, "item": "Runed Scroll", "source": ["Aean Swiftriver", 2, true] }),
		"with the item in the bags the accept stands alone"
	);
	assert_eq!(out["taken"]["held"], false, "taken: nothing left to right-click");
	assert_eq!(out["taken"]["cFolded"], true);
}

// Accepting an item-started quest uses up the item. A player who took the quest before the guide reached its
// step (Ursangous met early, #309) never had the item in the bags during that step, so nothing latched the
// collect.
#[test]
fn the_collect_of_a_quest_s_starting_item_is_done_once_the_quest_is_taken_though_the_item_is_gone() {
	let guides = r#"
		Polestar.RegisterGuide({ id = "test/paw", pack = "test", title = "Paw", faction = "Horde", minLevel = 20, maxLevel = 30, steps = {
			{ title = "Ursangous", goals = {
				{ t = "collect", item = 16303, itemName = "Ursangous's Paw", count = 1, map = 1429, x = 40, y = 65 },
				{ t = "accept", quest = 23, title = "Ursangous's Paw", item = 16303, itemName = "Ursangous's Paw" },
			} },
			{ title = "Splintertree Post", goals = {
				{ t = "turnin", quest = 23, title = "Ursangous's Paw", npc = 12696, npcName = "Senani Thunderheart", map = 1429, x = 73, y = 61 },
			} },
		} })
	"#;
	let out = run1(Run {
		guides,
		before: r#"stub.world.faction = "Horde"; stub.world.race = "Orc"; stub.world.class = "HUNTER"; stub.world.level = 27"#,
		script: r#"
			E.SetGuide("test/paw"); flush()
			local r = { fresh = { E.GetStepIndex(), E.GetStepView(1).goals[1].status } }
			stub.world.accept(23, {}); flush()
			r.taken = { E.GetStepIndex(), E.GetStepView(1).goals[1].status }
			emit(r)
		"#,
		..Default::default()
	});
	assert_eq!(out["fresh"], json!([1, "active"]), "neither the item nor the quest: get the item");
	assert_eq!(out["taken"], json!([2, "done"]), "the quest in the log: on to its turn-in");
}

#[test]
fn a_taken_quest_does_not_count_for_other_collects_of_its_item() {
	const PAW: &str = r#"item = 16303, itemName = "Paw""#;
	let cases = [
		("two of the item", format!(r#"{{ t = "collect", {PAW}, count = 2 }}, {{ t = "accept", quest = 23, title = "Q", {PAW} }}"#)),
		("a collect after the accept", format!(r#"{{ t = "accept", quest = 23, title = "Q", {PAW} }}, {{ t = "collect", {PAW}, count = 1 }}"#)),
		(
			"another class's accept",
			format!(
				r#"{{ t = "accept", quest = 23, title = "Q", {PAW}, only = {{ classes = {{ "MAGE" }} }} }}, {{ t = "collect", {PAW}, count = 1 }}, {{ t = "accept", quest = 2, title = "Q2", {PAW} }}"#
			),
		),
	];
	for (name, goals) in cases {
		let guides = r#"Polestar.RegisterGuide({ id = "test/paws", pack = "test", title = "Paws", faction = "Horde", minLevel = 20, maxLevel = 30, steps = {
				{ title = "Paws", goals = { {GOALS} } },
				{ title = "Later", goals = { { t = "level", level = 60 } } },
			} })"#
			.replace("{GOALS}", &goals);
		let out = run1(Run {
			guides: &guides,
			before: r#"stub.world.faction = "Horde"; stub.world.race = "Orc"; stub.world.class = "HUNTER"; stub.world.level = 27"#,
			script: r#"
				E.SetGuide("test/paws"); flush()
				stub.world.accept(23, {}); flush()
				local v = E.GetStepView(1)
				for _, gv in ipairs(v.goals) do if gv.t == "collect" then emit({ E.GetStepIndex(), gv.status }) end end
			"#,
			..Default::default()
		});
		assert_eq!(out, json!([1, "active"]), "{name}");
	}
}

// The game's objective names only the item ("Fel Moss: 0/8"); the goal line says where it comes from.
#[test]
fn a_collect_with_a_known_source_names_it_kill_an_enemy_for_the_item_collect_from_a_friend_or_an_object() {
	let guides = r#"
		Polestar.RegisterGuide({ id = "test/src", pack = "test", title = "Src", faction = "Alliance", minLevel = 1, maxLevel = 10, steps = {
			{ title = "Woods", goals = {
				{ t = "collect", quest = 459, title = "The Woodland Protector", item = 3297, itemName = "Fel Moss", count = 8, oi = 1, map = 1438, x = 56, y = 45,
					from = "Grell", fromAlso = "Grellkin", fromKind = "npc", fromFaction = "H" },
				{ t = "collect", item = 159, itemName = "Refreshing Spring Water", count = 2, map = 1429, x = 40, y = 40,
					from = "Innkeeper Farley", fromKind = "npc", fromFaction = "A" },
				{ t = "collect", quest = 36, title = "Westfall Stew", item = 1, itemName = "Oats", count = 1, oi = 1, map = 1436, x = 50, y = 30,
					from = "Sack of Oats", fromKind = "object" },
				{ t = "collect", quest = 36, title = "Westfall Stew", item = 2, itemName = "Peacebloom", count = 1, oi = 2, map = 1436, x = 50, y = 30,
					from = "Peacebloom", fromKind = "object" },
				{ t = "collect", quest = 36, title = "Westfall Stew", item = 3, itemName = "Runed Scroll", count = 1, oi = 3, map = 1436, x = 50, y = 30,
					from = "Aean Swiftriver", fromKind = "npc", fromRank = 2, fromFaction = "A", text = "Get the scroll" },
			} },
		} })
	"#;
	let out = run1(Run {
		guides,
		before: r#"stub.world.faction = "Alliance"; stub.world.race = "NightElf"; stub.world.class = "DRUID"; stub.world.level = 5"#,
		script: r#"
			E.SetGuide("test/src"); flush()
			local v = E.GetStepView(1)
			local r = {}
			for i = 1, 5 do local g = v.goals[i]; r[i] = { g.text, g.source and g.source.inText or false } end
			emit(r)
		"#,
		..Default::default()
	});
	assert_eq!(
		out,
		json!([
			["Kill Grell or Grellkin for Fel Moss", true],
			["Collect Refreshing Spring Water from Innkeeper Farley", true],
			["Collect Oats from Sack of Oats", true],
			["Collect Peacebloom", false],
			["Get the scroll", false],
		])
	);
}

#[test]
fn registerguide_rejects_malformed_guides_with_a_debug_message_instead_of_erroring() {
	let out = run1(Run {
		guides: "",
		login: false,
		script: r#"
			Polestar.debug = true
			local results = {}
			local function try(def) local ok, err = Polestar.RegisterGuide(def); results[#results + 1] = ok and "ok" or err end
			try("nope")
			try({ title = "No id", steps = { { goals = { { t = "level", level = 2 } } } } })
			try({ id = "test/a", pack = "test", title = "No steps", steps = {} })
			try({ id = "test/b", pack = "test", title = "Empty step", steps = { { goals = {} } } })
			try({ id = "test/c", pack = "test", title = "Bad verb", steps = { { goals = { { t = "dance" } } } } })
			try({ id = "test/d", pack = "test", title = "Missing quest", steps = { { goals = { { t = "accept", title = "X" } } } } })
			try({ id = "test/e", pack = "test", title = "Bad coords", steps = { { goals = { { t = "goto", map = 1, x = 120, y = 5 } } } } })
			try({ id = "test/f", pack = "test", title = "Good", minLevel = 1, maxLevel = 2, steps = { { goals = { { t = "note", text = "hi", extra = 1 } } } } })
			local ids = {}
			for i, h in ipairs(Polestar.Guides.List()) do ids[i] = h.id .. ":" .. h.stepCount .. ":" .. tostring(h.steps) end
			emit({ results = results, ids = ids, debugLines = #stub.messages })
		"#,
		..Default::default()
	});
	assert_eq!(
		out["results"],
		json!([
			"guide is not a table",
			"missing id",
			"no steps",
			"step 1 has no goals",
			"step 1 goal 1: unknown verb dance",
			"step 1 goal 1: accept needs quest",
			"step 1 goal 1: coordinates outside 0-100",
			"ok",
		])
	);
	assert_eq!(out["ids"], json!(["test/f:1:nil"]));
	assert_eq!(out["debugLines"], 7);
}

#[test]
fn completing_a_guide_chains_to_next_when_autonextguide_is_on_and_not_when_it_is_off() {
	let guides = r#"
		Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", minLevel = 1, maxLevel = 2, next = "test/b", steps = { { goals = { { t = "level", level = 2 } } } } })
		Polestar.RegisterGuide({ id = "test/b", pack = "test", title = "B", minLevel = 2, maxLevel = 3, steps = { { goals = { { t = "level", level = 3 } } } } })
	"#;
	let on = run1(Run {
		guides,
		script: r#"takeLog(); stub.world.setLevel(2); flush()
			emit({ log = takeLog(), guide = E.GetGuide().id, stored = PolestarCharDB.guide, index = E.GetStepIndex() })"#,
		..Default::default()
	});
	assert_eq!(
		on,
		json!({
			"log": ["STEP_CHANGED nil", "GUIDE_COMPLETED test/a", "GUIDE_CHANGED test/b", "STEP_CHANGED 1"],
			"guide": "test/b",
			"stored": "test/b",
			"index": 1,
		})
	);

	let off = run1(Run {
		guides,
		saved: Some("PolestarDB = { schema = 1, settings = { behavior = { autoNextGuide = false } } }"),
		script: r#"takeLog(); stub.world.setLevel(2); flush()
			emit({ log = takeLog(), guide = E.GetGuide().id })"#,
		..Default::default()
	});
	assert_eq!(off, json!({ "log": ["STEP_CHANGED nil", "GUIDE_COMPLETED test/a"], "guide": "test/a" }));

	let at_login = run1(Run {
		guides,
		before: "w.level = 2",
		saved: Some(r#"PolestarCharDB = { schema = 1, guide = "test/a" }"#),
		script: "emit({ log = takeLog(), guide = E.GetGuide().id })",
		..Default::default()
	});
	assert_eq!(
		at_login,
		json!({
			"log": ["GUIDE_CHANGED test/a", "GUIDE_COMPLETED test/a", "GUIDE_CHANGED test/b", "STEP_CHANGED 1"],
			"guide": "test/b",
		})
	);

	// Picking a finished guide by hand reports it complete but stays on it.
	let picked = run1(Run {
		guides,
		before: "w.level = 2",
		saved: Some("PolestarDB = { schema = 1, settings = { behavior = { autoSelectGuide = false } } }"),
		script: r#"takeLog(); E.SetGuide("test/a")
			emit({ log = takeLog(), guide = E.GetGuide().id })"#,
		..Default::default()
	});
	assert_eq!(picked, json!({ "log": ["GUIDE_CHANGED test/a", "GUIDE_COMPLETED test/a"], "guide": "test/a" }));
}

#[test]
fn prev_next_skip_and_goto_move_the_current_step_only_skip_saves_a_skip_goto_ahead_looks_without_skipping() {
	let out = run1(Run {
		before: "w.complete({ 783 }); w.onQuest(7, { 10 })",
		script: r#"
			local trail = {}
			local function mark(label) trail[#trail + 1] = label .. "=" .. tostring(E.GetStepIndex()) end
			mark("start")
			E.Prev(); mark("prev")
			local pinnedStatus = E.GetStepView(2).status
			E.Next(); mark("next")
			E.Skip(); mark("skip")
			local skippedStatus = E.GetStepView(3).status
			local stored = PolestarCharDB.skipped["test/01-northshire"][3]
			E.Goto(3); mark("goto3")
			E.Goto(6); mark("goto6")
			local jumped = { E.GetStepView(3).status, E.GetStepView(4).status, E.GetStepView(5).status, E.GetLiveStep() }
			E.Prev(); mark("prev")
			E.Next(); mark("next")
			SlashCmdList.POLESTAR("reset")
			mark("reset")
			emit({ trail = trail, pinnedStatus = pinnedStatus, skippedStatus = skippedStatus, stored = stored, jumped = jumped,
				skipped = PolestarCharDB.skipped["test/01-northshire"] == nil })
		"#,
		..Default::default()
	});
	assert_eq!(
		out,
		json!({
			"trail": ["start=3", "prev=2", "next=3", "skip=4", "goto3=3", "goto6=6", "prev=4", "next=6", "reset=3"],
			"pinnedStatus": "current",
			"skippedStatus": "skipped",
			"stored": true,
			"jumped": ["upcoming", "upcoming", "na", 3],
			"skipped": true,
		})
	);
}

#[test]
fn prev_walks_back_over_every_applicable_step_done_or_skipped_and_next_walks_the_same_steps_forward_without_touching_skips() {
	let guides = r#"
		local function accept(q, extra)
			local goal = { t = "accept", quest = q, title = "Quest " .. q }
			local step = { goals = { goal } }
			for k, v in pairs(extra or {}) do step[k] = v end
			return step
		end
		Polestar.RegisterGuide({ id = "test/walk", pack = "test", title = "Walk", minLevel = 1, maxLevel = 60, steps = {
			accept(901),                                 -- done (turned in)
			accept(902),                                 -- open, skipped earlier
			accept(903, { only = { classes = { "MAGE" } } }), -- not for a Warrior
			accept(904),                                 -- done (in the log)
			accept(905),                                 -- open: the computed step
			accept(906),
		} })
	"#;
	let out = run1(Run {
		guides,
		before: "w.complete({ 901 }); w.onQuest(904, {})",
		saved: Some(r#"PolestarCharDB = { schema = 1, guide = "test/walk", skipped = { ["test/walk"] = { [2] = true } } }"#),
		script: r#"
			local back, forward = {}, {}
			local start = E.GetStepIndex()
			for k = 1, 4 do E.Prev(); flush(); back[k] = E.GetStepIndex() .. ":" .. E.GetStepView(E.GetStepIndex()).goals[1].status end
			for k = 1, 3 do E.Next(); flush(); forward[k] = E.GetStepIndex() end
			local skips = {}
			for s in pairs(PolestarCharDB.skipped["test/walk"]) do skips[#skips + 1] = s end
			table.sort(skips)
			E.Next(); flush()
			local after = {}
			for s in pairs(PolestarCharDB.skipped["test/walk"]) do after[#after + 1] = s end
			emit({ start = start, back = back, forward = forward, skips = skips, skipNext = E.GetStepIndex(), live = E.GetLiveStep(), after = after })
		"#,
		..Default::default()
	});
	assert_eq!(
		out,
		json!({
			"start": 5,
			// Step 3 is Mage-only; the skipped step 2 is shown, not un-skipped.
			"back": ["4:done", "2:active", "1:done", "1:done"],
			"forward": [2, 4, 5],
			"skips": [2],
			"skipNext": 6, // Next on the live step looks ahead...
			"live": 5,
			"after": [2], // ...and skips nothing
		})
	);
}

#[test]
fn talk_sethome_getfp_fly_vendor_buy_collect_and_hearth_complete_from_interactions() {
	let guide = r#"
		Polestar.RegisterGuide({ id = "test/actions", pack = "test", title = "Actions", minLevel = 1, maxLevel = 10, steps = {
			{ goals = { { t = "talk", npc = 197, npcName = "Marshal McBride" } } },
			{ goals = { { t = "sethome", location = "Goldshire", npc = 295, npcName = "Innkeeper Farley" } } },
			{ goals = { { t = "getfp", location = "Stormwind", npc = 352, npcName = "Dungar Longdrink" } } },
			{ goals = { { t = "fly", location = "Stormwind City" } } },
			{ goals = { { t = "vendor", npc = 54, npcName = "Corina Steele" } } },
			{ goals = { { t = "buy", item = 159, itemName = "Refreshing Spring Water", count = 5 } } },
			{ goals = { { t = "collect", item = 750, itemName = "Tough Wolf Meat", count = 3 } } },
			{ goals = { { t = "hearth", location = "Goldshire" } } },
			{ goals = { { t = "level", level = 99 } } },
		} })
	"#;
	let out = run1(Run {
		guides: guide,
		script: r#"
			local w = stub.world
			local trail = {}
			local function mark(label) trail[#trail + 1] = label .. "=" .. tostring(E.GetStepIndex()) end
			w.merchant(54); w.close(); flush(); mark("early-vendor")
			w.gossip(198); w.close(); flush(); mark("wrong-npc")
			w.gossip(197); flush(); w.close(); mark("talk")
			w.bind("Goldshire"); flush(); mark("bind")
			w.taxi(352, "Stormwind, Elwynn", { "Sentinel Hill, Westfall" }); w.close(); flush(); mark("fp")
			w.setZone("Stormwind City", "Trade District"); flush(); mark("fly")
			w.merchant(54); w.close(); flush(); mark("vendor")
			w.addItem(159, 5); flush(); mark("buy")
			w.addItem(750, 2); flush(); mark("collect-2")
			local progress = E.GetStepView(7).goals[1].progress
			w.addItem(750, 1); flush(); mark("collect-3")
			w.setZone("Elwynn Forest", "Goldshire"); flush(); mark("hearth")
			-- Conditions that stop holding later do not reopen passed steps.
			w.bind("Stormwind City"); w.items[159] = 0; w.items[750] = 0; w.addItem(1, 1)
			w.setZone("Westfall", "Sentinel Hill"); flush(); mark("moved-on")
			local texts = {}
			for i = 1, 8 do texts[i] = E.GetStepView(i).goals[1].text end
			emit({ trail = trail, fp = PolestarCharDB.flags.fp, progress = progress, texts = texts })
		"#,
		..Default::default()
	});
	assert_eq!(out["trail"], json!(["early-vendor=1", "wrong-npc=1", "talk=2", "bind=3", "fp=4", "fly=5", "vendor=6", "buy=7", "collect-2=7", "collect-3=8", "hearth=9", "moved-on=9"]));
	assert_eq!(out["fp"], json!({ "Stormwind, Elwynn": true }));
	assert_eq!(out["progress"], json!({ "cur": 2, "max": 3, "kind": "count" }));
	assert_eq!(
		out["texts"],
		json!([
			"Talk to Marshal McBride",
			"Set your home to Goldshire",
			"Get the flight path at Stormwind",
			"Fly to Stormwind City",
			"Sell and repair at Corina Steele",
			"Buy Refreshing Spring Water",
			"Collect Tough Wolf Meat",
			"Hearth to Goldshire",
		])
	);
}

#[test]
fn a_step_that_hearths_and_then_flies_completes_when_the_flight_lands_the_hearth_counts_as_done_once_a_later_goal_is() {
	let guide = r#"
		Polestar.RegisterGuide({ id = "test/travel", pack = "test", title = "Travel", minLevel = 1, maxLevel = 10, steps = {
			{ goals = { { t = "hearth", location = "Goldshire" }, { t = "fly", location = "Stormwind City" } } },
			{ goals = { { t = "level", level = 99 } } },
		} })
	"#;
	let out = run1(Run {
		guides: guide,
		script: r#"
			local w = stub.world
			w.setZone("Elwynn Forest", "Goldshire"); flush()
			local atInn = { E.GetStepIndex(), E.GetStepView(1).goals[1].status, E.GetStepView(1).goals[2].status }
			w.setZone("Stormwind City", "Trade District"); flush()
			emit({ atInn = atInn, landed = E.GetStepIndex() })
		"#,
		..Default::default()
	});
	// At the inn the flight is still to do; once it lands the inn is behind the player, yet the step is done
	// and the guide moves on.
	assert_eq!(out, json!({ "atInn": [1, "done", "active"], "landed": 2 }));
}

// #362: Body and Heart's Darkshore leg, `fly Auberdine` -> work outside the town; Goldshire stands in for
// Auberdine.
const LANDED: &str = r#"
	Polestar.RegisterGuide({ id = "test/landed", pack = "test", title = "Landed", minLevel = 1, maxLevel = 10, steps = {
		{ goals = {
			{ t = "fly", location = "Goldshire", npc = 352, npcName = "Dungar Longdrink", map = 1453, x = 66, y = 62 },
			{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 },
		} },
		{ goals = { { t = "level", level = 99 } } },
	} })
"#;

#[test]
fn a_flight_that_landed_stays_done_when_the_player_walks_out_of_the_town_and_across_a_reload_while_the_step_goes_on_362() {
	let first = run1(Run {
		guides: LANDED,
		before: r#"w.onQuest(7, { { required = 10, fulfilled = 0 } }); w.setZone("Stormwind City", "Trade District")"#,
		script: r#"
			local w = stub.world
			E.SetGuide("test/landed"); flush()
			local function state() return { E.GetStepIndex(), E.GetStepView(1).goals[1].status, E.GetWaypoint().goalIndex } end
			local r = { before = state() }
			w.setZone("Elwynn Forest", "Goldshire"); flush()
			r.landed = state()
			w.setZone("Elwynn Forest", ""); flush()
			r.left = state()
			emit(r)
		"#,
		..Default::default()
	});
	assert_eq!(first, json!({ "before": [1, "active", 1], "landed": [1, "done", 2], "left": [1, "done", 2] }));

	let reloaded = run1(Run {
		guides: LANDED,
		before: r#"w.onQuest(7, { { required = 10, fulfilled = 3 } }); w.setZone("Elwynn Forest", "")"#,
		saved: Some(r#"PolestarCharDB = { schema = 1, tabs = { "test/landed" }, activeTab = 1, manual = { ["test/landed"] = { ["1:1"] = true } } }"#),
		script: "emit({ E.GetStepIndex(), E.GetStepView(1).goals[1].status, E.GetWaypoint().goalIndex })",
		..Default::default()
	});
	assert_eq!(reloaded, json!([1, "done", 2]));
}

#[test]
fn a_flight_looked_at_ahead_while_standing_at_its_end_is_not_latched_362() {
	let out = run1(Run {
		guides: r#"
			Polestar.RegisterGuide({ id = "test/ahead", pack = "test", title = "Ahead", minLevel = 1, maxLevel = 10, steps = {
				{ goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
				{ goals = { { t = "fly", location = "Goldshire" }, { t = "level", level = 99 } } },
			} })
		"#,
		before: r#"w.onQuest(7, { { required = 10, fulfilled = 0 } }); w.setZone("Elwynn Forest", "Goldshire")"#,
		script: r#"
			E.SetGuide("test/ahead"); flush()
			E.Goto(2); flush()
			local looked = { E.GetStepIndex(), E.GetStepView(2).goals[1].status }
			stub.world.setZone("Elwynn Forest", ""); flush()
			emit({ looked = looked, latches = PolestarCharDB.manual["test/ahead"] or {} })
		"#,
		..Default::default()
	});
	assert_eq!(out, json!({ "looked": [2, "done"], "latches": {} }));
}

#[test]
fn a_hearth_that_landed_stays_done_when_the_player_walks_out_of_the_inn_s_town_while_the_step_goes_on_362() {
	let out = run1(Run {
		guides: r#"
			Polestar.RegisterGuide({ id = "test/hearthed", pack = "test", title = "Hearthed", minLevel = 1, maxLevel = 10, steps = {
				{ goals = {
					{ t = "hearth", location = "Goldshire" },
					{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 },
				} },
				{ goals = { { t = "level", level = 99 } } },
			} })
		"#,
		before: r#"w.onQuest(7, { { required = 10, fulfilled = 0 } }); w.setZone("Stormwind City", "Trade District")"#,
		script: r#"
			local w = stub.world
			E.SetGuide("test/hearthed"); flush()
			local function state() return { E.GetStepIndex(), E.GetStepView(1).goals[1].status, E.GetWaypoint().goalIndex } end
			local r = { before = state() }
			w.setZone("Elwynn Forest", "Goldshire"); flush()
			r.landed = state()
			w.setZone("Elwynn Forest", ""); flush()
			r.left = state()
			emit(r)
		"#,
		..Default::default()
	});
	assert_eq!(out, json!({ "before": [1, "active", 2], "landed": [1, "done", 2], "left": [1, "done", 2] }));
}

#[test]
fn hotline_s_report_576_a_hearth_step_while_the_hearthstone_waits_says_how_long_and_walks_the_arrow_to_the_inn_once_it_is_ready_both_go() {
	let out = run1(Run {
		guides: r#"
			Polestar.RegisterGuide({ id = "test/hearth-cd", pack = "test", title = "Hearth", minLevel = 1, maxLevel = 10, steps = {
				{ goals = { { t = "hearth", location = "Goldshire" } } },
				{ goals = { { t = "hearth", location = "Nowhere Inn" } } },
				{ goals = { { t = "level", level = 99 } } },
			} })
		"#,
		before: r#"w.setZone("Stormwind City", "Trade District")"#,
		script: r#"
			local w = stub.world
			-- The Hearthstone (QoL/Hearth.lua) and the inns (Nav/Travel.lua), as the test sets them.
			local hs = { have = true, remaining = 23 * 60 - 20 }
			Polestar.QoL = Polestar.QoL or {}
			Polestar.QoL.GetHearth = function() return hs end
			Polestar.Nav = Polestar.Nav or {}
			Polestar.Nav.FindInn = function(npc, name)
				if name == "Goldshire" then return { map = 1429, x = 43.8, y = 65.8, f = "e", npc = 295 } end
			end
			local function changed() Polestar.Fire("QOL_HEARTH_CHANGED"); flush() end
			local function state()
				local g, wp = E.GetStepView(E.GetStepIndex()).goals[1], E.GetWaypoint()
				return { line = g.hearthText or false, arrow = wp and { wp.map, wp.x, wp.y, wp.label } or false }
			end
			E.SetGuide("test/hearth-cd"); flush()
			local r = { waiting = state() }
			hs.remaining = 30; changed()
			r.soon = state()
			hs.remaining = 0; changed()
			r.ready = state()
			hs.have = false; changed()
			r.none = state()
			-- walking into the inn's town checks the step off, as hearthing does
			hs.have, hs.remaining = true, 600; changed()
			w.setZone("Elwynn Forest", "Goldshire"); flush()
			r.walked = E.GetStepIndex()
			-- an inn the data does not know: the time left, no arrow
			r.unknown = state()
			emit(r)
		"#,
		..Default::default()
	});
	assert_eq!(out["waiting"], json!({ "line": "Hearthstone ready in 23 min: walk to the inn, or wait for it", "arrow": [1429, 43.8, 65.8, "Walk to Goldshire"] }));
	assert_eq!(out["soon"], json!({ "line": "Hearthstone ready in under a minute: walk to the inn, or wait for it", "arrow": [1429, 43.8, 65.8, "Walk to Goldshire"] }));
	assert_eq!(out["ready"], json!({ "line": false, "arrow": false }), "ready: the hearth step as before");
	assert_eq!(out["none"], json!({ "line": "No Hearthstone in your bags: walk to the inn", "arrow": [1429, 43.8, 65.8, "Walk to Goldshire"] }));
	assert_eq!(out["walked"], 2, "arriving in Goldshire on foot checks the hearth off");
	assert_eq!(out["unknown"], json!({ "line": "Hearthstone ready in 10 min", "arrow": false }));
}

#[test]
fn a_hearth_step_whose_hearthstone_is_bound_at_another_inn_says_so_and_walks_the_arrow_to_its_inn_bound_there_it_is_as_before_667() {
	let out = run1(Run {
		guides: r#"
			Polestar.RegisterGuide({ id = "test/hearth-bound", pack = "test", title = "Hearth", minLevel = 1, maxLevel = 10, steps = {
				{ goals = { { t = "hearth", location = "Goldshire" } } },
				{ goals = { { t = "hearth", location = "Nowhere Inn" } } },
				{ goals = { { t = "level", level = 99 } } },
			} })
		"#,
		before: r#"w.setZone("Stormwind City", "Trade District"); w.bind("Kharanos")"#,
		script: r#"
			local w = stub.world
			-- The Hearthstone (QoL/Hearth.lua) and the inns (Nav/Travel.lua), as the test sets them.
			local hs = { have = true, remaining = 0 }
			local goldshire = { map = 1429, x = 43.8, y = 65.8, f = "e", npc = 295 }
			local kharanos = { map = 1426, x = 47.4, y = 52.4, f = "w", npc = 1247 }
			local bound = kharanos
			Polestar.QoL = Polestar.QoL or {}
			Polestar.QoL.GetHearth = function() return hs end
			Polestar.Nav = Polestar.Nav or {}
			Polestar.Nav.FindInn = function(npc, name)
				if name == "Goldshire" then return goldshire end
			end
			Polestar.Nav.BoundInn = function() return bound end
			local function changed() Polestar.Fire("QOL_HEARTH_CHANGED"); flush() end
			local function state()
				local g, wp = E.GetStepView(E.GetStepIndex()).goals[1], E.GetWaypoint()
				return { line = g.hearthText or false, arrow = wp and { wp.map, wp.x, wp.y, wp.label } or false }
			end
			E.SetGuide("test/hearth-bound"); flush()
			local r = { elsewhere = state() }
			-- on cooldown too: where it is bound comes first
			hs.remaining = 600; changed()
			r.cooling = state()
			-- bound at the step's inn: the cooldown as before, then nothing
			bound = goldshire; w.bind("Goldshire"); stub.fire("HEARTHSTONE_BOUND"); flush()
			r.rebound = state()
			hs.remaining = 0; changed()
			r.ready = state()
			-- the bound inn unknown to the data: never reads as elsewhere
			bound = nil; w.bind("Kharanos"); changed()
			r.unknownBound = state()
			-- bound elsewhere, walking into the inn's town checks the step off
			bound = kharanos; changed()
			w.setZone("Elwynn Forest", "Goldshire"); flush()
			r.walked = E.GetStepIndex()
			-- a step inn the data does not know: nothing
			r.unknownInn = state()
			emit(r)
		"#,
		..Default::default()
	});
	let walk = json!([1429, 43.8, 65.8, "Walk to Goldshire"]);
	assert_eq!(out["elsewhere"], json!({ "line": "Your Hearthstone is bound to Kharanos, not Goldshire: walk to the inn", "arrow": walk }));
	assert_eq!(out["cooling"], json!({ "line": "Your Hearthstone is bound to Kharanos, not Goldshire: walk to the inn", "arrow": walk }));
	assert_eq!(out["rebound"], json!({ "line": "Hearthstone ready in 10 min: walk to the inn, or wait for it", "arrow": walk }));
	assert_eq!(out["ready"], json!({ "line": false, "arrow": false }), "bound at its inn and ready: the hearth step as before");
	assert_eq!(out["unknownBound"], json!({ "line": false, "arrow": false }));
	assert_eq!(out["walked"], 2, "arriving in Goldshire on foot checks the hearth off");
	assert_eq!(out["unknownInn"], json!({ "line": false, "arrow": false }));
}

#[test]
fn a_flight_that_lands_while_the_player_looks_ahead_at_another_step_still_counts_for_its_own_step_362() {
	let out = run1(Run {
		guides: LANDED,
		before: r#"w.onQuest(7, { { required = 10, fulfilled = 0 } }); w.setZone("Stormwind City", "Trade District")"#,
		script: r#"
			local w = stub.world
			E.SetGuide("test/landed"); flush()
			E.Goto(2); flush()
			w.setZone("Elwynn Forest", "Goldshire"); flush()
			w.setZone("Elwynn Forest", ""); flush()
			local ahead = { E.GetStepIndex(), E.GetStepView(1).goals[1].status }
			E.Goto(1); flush()
			emit({ ahead = ahead, back = { E.GetStepIndex(), E.GetStepView(1).goals[1].status, E.GetWaypoint().goalIndex } })
		"#,
		..Default::default()
	});
	assert_eq!(out, json!({ "ahead": [2, "done"], "back": [1, "done", 2] }));
}

#[test]
fn bursts_of_quest_events_are_coalesced_to_at_most_10_evaluations_per_second() {
	let out = run1(Run {
		script: r#"
			local n = 0
			local real = Polestar.Compat.GetPlayerInfo
			Polestar.Compat.GetPlayerInfo = function() n = n + 1; return real() end
			for i = 1, 100 do
				stub.fire("QUEST_LOG_UPDATE")
				stub.advance(0.01)
			end
			emit(n)
		"#,
		..Default::default()
	});
	let n = out.as_f64().unwrap();
	assert!((5.0..=11.0).contains(&n), "evaluations: {out}");
}

#[test]
fn slash_commands_drive_the_engine_and_report_status() {
	let both = format!("{NORTHSHIRE}{ELWYNN}");
	let out = run1(Run {
		guides: &both,
		before: "w.complete({ 783 }); w.onQuest(7, { { required = 10, fulfilled = 4 } })",
		script: r#"
			stub.messages = {}
			SlashCmdList.POLESTAR("status")
			local status = stub.messages
			stub.messages = {}
			SlashCmdList.POLESTAR("skip")
			local afterSkip = E.GetStepIndex()
			SlashCmdList.POLESTAR("prev")
			local afterPrev = E.GetStepIndex()
			SlashCmdList.POLESTAR("guide nope")
			SlashCmdList.POLESTAR("guide test/02-elwynn")
			local exact = E.GetGuide().id
			SlashCmdList.POLESTAR("guide test/01-northshire")
			SlashCmdList.POLESTAR("guide Test/02-Elwynn")
			emit({ status = status, afterSkip = afterSkip, afterPrev = afterPrev, exact = exact, guide = E.GetGuide().id, msgs = stub.messages,
				header = BINDING_HEADER_POLESTAR, binding = BINDING_NAME_POLESTAR_NEXT })
		"#,
		..Default::default()
	});
	assert_eq!(out["status"], json!(["|cff4fd1c5Polestar|r: Northshire Valley: step 3 of 6 (2/5 done)", "  [ ] Go to Kobold camp", "  [ ] Kill Kobold Vermin (4/10)"]));
	assert_eq!(out["afterSkip"], 4);
	assert_eq!(out["afterPrev"], 3);
	assert_eq!(out["exact"], "test/02-elwynn");
	// A mixed-case id finds the lower-case guide.
	assert_eq!(out["guide"], "test/02-elwynn");
	assert_eq!(
		out["msgs"],
		json!([
			"|cff4fd1c5Polestar|r: Unknown guide 'nope'.",
			"|cff4fd1c5Polestar|r: Guide: Elwynn Forest",
			"|cff4fd1c5Polestar|r: Guide: Northshire Valley",
			"|cff4fd1c5Polestar|r: Guide: Elwynn Forest",
		])
	);
	assert_eq!(out["header"], "Polestar");
	assert_eq!(out["binding"], "Next step");
}

// A `complete` goal counts its quest's objectives from the log (summed, so the window redraws on every loot or
// kill) and, for a quest with several, lists the open ones in the game's words under the goal (a player's
// report: The Hunt Begins showed no x of y).
const HUNT: &str = r#"
Polestar.RegisterGuide({
	id = "test/hunt", pack = "test", title = "Camp Narache", faction = "Alliance", minLevel = 1, maxLevel = 4, zone = 1429,
	steps = {
		{ title = "The Hunt Begins", goals = {
			{ t = "complete", quest = 747, title = "The Hunt Begins" },
			{ t = "complete", quest = 752, title = "A Humble Task" },
		} },
		{ title = "Grull Hawkwind", goals = {
			{ t = "turnin", quest = 747, title = "The Hunt Begins", npc = 2980, npcName = "Grull Hawkwind" },
		} },
	},
})
"#;

#[test]
fn a_quest_to_complete_shows_its_objectives_count_and_the_open_ones_when_it_has_several() {
	let guides = format!("{NORTHSHIRE}{HUNT}");
	let out = run(Run {
		guides: &guides,
		before: r#"w.onQuest(747, { { text = "Plainstrider Meat", required = 7 }, { text = "Plainstrider Feathers: 0/7", required = 7, type = "item" } })
			w.onQuest(752, { { text = "Water Pitcher", required = 1, type = "item" } })"#,
		script: r#"
			local w = stub.world
			E.SetGuide("test/hunt"); flush(); takeLog()
			local function goals()
				local v = E.GetStepView(1)
				return { v.goals[1].progress, v.goals[1].objectives or false, v.goals[2].progress or false, v.goals[2].objectives or false }
			end
			local start = goals()
			w.progress(747, 1, 3); flush()
			local meat = goals()
			w.progress(747, 1, 9); flush()
			local fed = goals()
			emit(takeLog()); emit(start); emit(meat); emit(fed)
		"#,
		..Default::default()
	});
	let (log, start, meat, fed) = (&out[0], &out[1], &out[2], &out[3]);
	assert_eq!(*start, json!([{ "cur": 0, "max": 14, "kind": "count" }, ["Plainstrider Meat 0/7", "Plainstrider Feathers: 0/7"], { "cur": 0, "max": 1, "kind": "count" }, false]));
	assert_eq!(*meat, json!([{ "cur": 3, "max": 14, "kind": "count" }, ["Plainstrider Meat 3/7", "Plainstrider Feathers: 0/7"], { "cur": 0, "max": 1, "kind": "count" }, false]));
	// Looting past the need counts the need; a finished objective leaves the list.
	assert_eq!(*fed, json!([{ "cur": 7, "max": 14, "kind": "count" }, ["Plainstrider Feathers: 0/7"], { "cur": 0, "max": 1, "kind": "count" }, false]));
	assert_eq!(*log, json!(["STEP_UPDATED 1", "STEP_UPDATED 1"]), "each count change redraws the step");
}

// An objective goal reads the quest-log line named after its target, not the position it was compiled with
// (#223, #279, #335): the game lists Slimy Menace's objectives Murloc first, where the quest data (and so `oi`)
// has Murloc Streamrunner first, and An Enticing Offer's Vial of Animal Blood first, where the data has Duskweed
// Petal. By position, each line read the other's count ("Kill Murloc 1/4") and ticked the other line.
const MURLOCS: &str = r#"
Polestar.RegisterGuide({
	id = "test/murlocs", pack = "test", title = "Crystal Lake", faction = "Alliance", minLevel = 1, maxLevel = 10, zone = 1429,
	steps = {
		{ title = "The murloc camp", goals = {
			{ t = "kill", quest = 99128, title = "Slimy Menace", target = "Murloc", npc = 285, oi = 2, map = 1429, x = 49.8, y = 66.4 },
			{ t = "kill", quest = 99128, title = "Slimy Menace", target = "Murloc Streamrunner", npc = 735, oi = 1, map = 1429, x = 50.5, y = 66.3 },
		} },
		{ title = "Bait ingredients", goals = {
			{ t = "collect", quest = 99130, title = "An Enticing Offer", item = 286214, itemName = "Duskweed Petal", oi = 1, map = 1429, x = 41.4, y = 84.4 },
			{ t = "collect", quest = 99130, title = "An Enticing Offer", item = 286215, itemName = "Vial of Animal Blood", oi = 2, map = 1429, x = 41.0, y = 85.0 },
		} },
		{ title = "Turn in", goals = {
			{ t = "turnin", quest = 99128, title = "Slimy Menace", npc = 1, npcName = "Somebody" },
		} },
	},
})
"#;

/// The first two columns of each row (`rows.map((g) => g.slice(0, 2))`).
fn first_two(rows: &Value) -> Value {
	json!(rows.as_array().unwrap().iter().map(|g| json!([g[0], g[1]])).collect::<Vec<_>>())
}

#[test]
fn an_objective_goal_reads_the_quest_log_line_named_after_its_target_not_the_position_it_was_compiled_with_223_279_335() {
	let guides = format!("{NORTHSHIRE}{MURLOCS}");
	let out = run(Run {
		guides: &guides,
		before: r#"w.onQuest(99128, { { text = "Murloc slain: 0/7", required = 7, type = "monster" }, { text = "Murloc Streamrunner slain: 0/4", required = 4, type = "monster" } })
			w.onQuest(99130, { { text = "Vial of Animal Blood: 0/6", required = 6, type = "item" }, { text = "Duskweed Petal: 0/18", required = 18, type = "item" } })"#,
		script: r#"
			local w = stub.world
			E.SetGuide("test/murlocs"); flush()
			local function view(s)
				local v = E.GetStepView(s)
				local out = {}
				for i, g in ipairs(v.goals) do out[i] = { g.progress and g.progress.cur, g.progress and g.progress.max, g.status } end
				return out
			end
			w.progress(99128, 1, 3); w.progress(99128, 2, 1); flush()
			emit(view(1))
			w.progress(99128, 2, 4); flush()
			emit(view(1))
			w.progress(99130, 1, 2); w.progress(99130, 2, 5); flush()
			emit(view(2))
		"#,
		..Default::default()
	});
	let (murlocs, streamrunners_done, bait) = (&out[0], &out[1], &out[2]);
	// 3 Murlocs and 1 Streamrunner killed: each line its own count.
	assert_eq!(first_two(murlocs), json!([[3, 7], [1, 4]]));
	// The 4 Streamrunners done: the Streamrunner line ticks, the Murloc line stays open.
	let statuses: Vec<Value> = streamrunners_done.as_array().unwrap().iter().map(|g| g[2].clone()).collect();
	assert_eq!(json!(statuses), json!(["active", "done"]), "{streamrunners_done}");
	assert_eq!(first_two(bait), json!([[5, 18], [2, 6]]));
}

// A pack's `collect` of an item its quest uses without asking for it, bound to one of the quest's lines (#538):
// the Sunscale Feather goes on the Scytheclaw nests (quest 905's lines are the three visits), the Fresh Zhevra
// Carcass lures Ishamuhale (quest 882's one line is his Fang). No line counts either item, so the bags do; the
// Fang still reads its line.
const USED_ITEMS: &str = r#"
Polestar.RegisterGuide({
	id = "test/used", pack = "test", title = "The Barrens", faction = "Horde", minLevel = 10, maxLevel = 20, zone = 1413,
	steps = {
		{ title = "A feather", goals = {
			{ t = "accept", quest = 905, title = "The Angry Scytheclaws", npc = 3338, npcName = "Sergra Darkthorn", map = 1413, x = 52.23, y = 31.01 },
			{ t = "collect", quest = 905, title = "The Angry Scytheclaws", item = 5165, itemName = "Sunscale Feather", oi = 1, map = 1413, x = 59.48, y = 45.18 },
		} },
		{ title = "Ishamuhale", goals = {
			{ t = "accept", quest = 882, title = "Ishamuhale", npc = 3387, npcName = "Jorn Skyseer", map = 1413, x = 44.86, y = 59.14 },
			{ t = "collect", quest = 882, title = "Ishamuhale", item = 10338, itemName = "Fresh Zhevra Carcass", oi = 1, map = 1413, x = 46.83, y = 63.16 },
			{ t = "collect", quest = 882, title = "Ishamuhale", item = 5101, itemName = "Ishamuhale's Fang", oi = 1, map = 1413, x = 60.0, y = 32.0 },
		} },
		{ title = "The nests", goals = {
			{ t = "interact", quest = 905, title = "The Angry Scytheclaws", object = 6907, objName = "Blue Raptor Nest", oi = 1, map = 1413, x = 52.6, y = 46.11 },
		} },
	},
})
"#;
const USED_DB: &str = r#"
Polestar.QuestDB.SetMeta({ schema = 2 })
AddRecords("quests", {
	[905] = { "The Angry Scytheclaws", 17, 10, nil, nil, 2, 3338, 3338, nil, 881, nil, { 3, 6907, nil, 3, 6908, nil, 3, 6906 }, 1413, nil, nil, nil, nil, 2, 5165 },
	[882] = { "Ishamuhale", 19, 10, nil, nil, 2, 3387, 3387, nil, nil, nil, { 2, 5101 }, 1413, nil, nil, nil, nil, 2, 10338 },
})
"#;
const NESTS: &str =
	r#"{ { text = "Blue Raptor Nest visited: 0/1", type = "object" }, { text = "Yellow Raptor Nest visited: 0/1", type = "object" }, { text = "Red Raptor Nest visited: 0/1", type = "object" } }"#;

#[test]
fn a_quest_collect_of_an_item_the_quest_uses_without_asking_for_it_counts_the_bags_once_the_quest_is_taken_and_stays_done_once_the_item_is_used_538() {
	let guides = format!("{NORTHSHIRE}{USED_ITEMS}");
	let script = r#"
			local w = stub.world
			{USED_DB}
			E.SetGuide("test/used"); flush()
			local steps = E.GetGuide().steps
			local feather, carcass, fang = steps[1].goals[2], steps[2].goals[2], steps[2].goals[3]
			local function state(s, g, goal)
				return { E.GetStepIndex(), E.GetStepView(s).goals[g].status, E.ObjectiveLine(goal) or false }
			end
			w.addItem(5165, 1); flush()
			emit(state(1, 2, feather))
			w.accept(905, {NESTS}); flush()
			emit(state(1, 2, feather))
			w.addItem(5165, -1); flush()
			emit(state(1, 2, feather))
			w.accept(882, { { text = "Ishamuhale's Fang: 0/1", type = "item" } }); w.addItem(10338, 1); flush()
			emit(state(2, 2, carcass))
			emit(state(2, 3, fang))
			w.progress(882, 1, 1); flush()
			emit(state(2, 3, fang))
		"#
	.replace("{USED_DB}", &format!("{}{USED_DB}", forge_addontest::questdb::ADD_RECORDS_LUA))
	.replace("{NESTS}", NESTS);
	let out = run(Run { guides: &guides, full: true, script: &script, ..Default::default() });
	assert_eq!(
		json!(out),
		json!([
			// The quest not taken: the feather waits on it, though it is in the bags.
			[1, "active", false],
			// Taken: the feather in the bags does it, and party counts have no line to read.
			[2, "done", false],
			// The feather used on a nest: the step stays done.
			[2, "done", false],
			// The carcass counts the bags, though its line is an item line (the Fang's).
			[2, "done", false],
			// The Fang, an objective, reads its line.
			[2, "active", 1],
			[3, "done", 1],
		])
	);
}

#[test]
fn without_the_quest_database_a_quest_collect_reads_its_quest_log_line_as_before() {
	let guides = format!("{NORTHSHIRE}{USED_ITEMS}");
	let script = r#"
			local w = stub.world
			E.SetGuide("test/used"); flush()
			w.addItem(5165, 1); w.accept(905, {NESTS}); flush()
			emit({ E.GetStepIndex(), E.GetStepView(1).goals[2].status })
		"#
	.replace("{NESTS}", NESTS);
	let out = run(Run { guides: &guides, full: true, script: &script, ..Default::default() });
	assert_eq!(json!(out), json!([[1, "active"]]));
}

#[test]
fn an_objective_goal_keeps_its_compiled_position_when_no_line_names_its_target() {
	let guides = format!("{NORTHSHIRE}{MURLOCS}");
	let counts = run1(Run {
		guides: &guides,
		// Labels not filled in yet (counts alone), then lines in a language the guide's names are not in.
		before: r#"w.onQuest(99128, { { text = " slain: 0/7", required = 7, type = "monster" }, { text = " slain: 0/4", required = 4, type = "monster" } })"#,
		script: r#"
			local w = stub.world
			E.SetGuide("test/murlocs"); flush()
			w.progress(99128, 1, 3); flush()
			local v = E.GetStepView(1)
			emit({ { v.goals[1].progress.cur, v.goals[1].progress.max }, { v.goals[2].progress.cur, v.goals[2].progress.max } })
		"#,
		..Default::default()
	});
	// Murloc (oi 2) reads line 2, Murloc Streamrunner (oi 1) line 1, as compiled.
	assert_eq!(counts, json!([[0, 4], [3, 7]]));
}
