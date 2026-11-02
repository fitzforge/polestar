//! Engine "Focus: one person at a time": a step's goals grouped by who they are done with, the focus on the first
//! open group, the waypoint following it, and Engine.GuideFocus. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 1000, right = -1000, top = 1000, bottom = -3000 })
w.moveTo(1413, 52, 31)
w.race, w.faction, w.class, w.className, w.level = "Orc", "Horde", "WARRIOR", "Warrior", 12
"#;

// The Crossroads: Thork (3429) twice, Gazrog (3464), Zargh (3489), then a field step, then accept/kill/turn-in
// at one NPC.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", faction = "Horde", minLevel = 10, maxLevel = 20, zone = 1413, steps = {
	{ title = "The Crossroads", goals = {
		{ t = "turnin", quest = 840, title = "Conscript of the Horde", npc = 3429, npcName = "Thork", map = 1413, x = 51.5, y = 30.3 },
		{ t = "accept", quest = 842, title = "Crossroads Conscription", npc = 3429, npcName = "Thork", map = 1413, x = 51.5, y = 30.3 },
		{ t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog", map = 1413, x = 51.9, y = 30.8 },
		{ t = "accept", quest = 845, title = "The Zhevra", npc = 3489, npcName = "Zargh", map = 1413, x = 52.2, y = 31.0 },
		{ t = "note", text = "Mages: talk to someone else.", only = { classes = { "MAGE" } }, npc = 9999 },
		{ t = "accept", quest = 871, title = "Disrupt the Attacks", npc = 3489, npcName = "Zargh", map = 1413, x = 52.2, y = 31.0 },
	} },
	{ title = "Field", goals = {
		{ t = "goto", map = 1413, x = 45, y = 20, text = "Raptor grounds" },
		{ t = "kill", target = "Sunscale Lashtail", count = 7, quest = 869, oi = 1 },
		{ t = "collect", item = 5062, itemName = "Raptor Head", count = 12, quest = 869, oi = 2 },
	} },
	{ title = "Gazrog", goals = {
		{ t = "accept", quest = 870, title = "The Forgotten Pools", npc = 3464, npcName = "Gazrog", map = 1413, x = 51.9, y = 30.8 },
		{ t = "kill", target = "Bristleback Quilboar", count = 4, quest = 870, oi = 1, map = 1413, x = 55, y = 40 },
		{ t = "turnin", quest = 870, title = "The Forgotten Pools", npc = 3464, npcName = "Gazrog", map = 1413, x = 51.9, y = 30.8 },
	} },
} })
"#;

const HELPERS: &str = r#"
			E = Polestar.Engine
			function flush() stub.advance(0.25) end
			function groups(i)
				local v = E.GetStepView(i)
				local out = {}
				for k, g in ipairs(v.groups) do
					out[k] = table.concat({ g.kind, tostring(g.name), table.concat(g.goals, "+"), g.done and "done" or ("open" .. g.pending) }, " ")
				end
				return { groups = out, focus = v.focus or false }
			end
			stub.login()
			E.SetGuide("test/xr")
			Polestar.Set("behavior.autoAccept", false)
			Polestar.Set("behavior.autoTurnin", false)
			"#;

fn run(before: &str, guides: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n\t\t\t{guides}{HELPERS}{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_hub_step_reads_person_by_person_and_the_focus_walks_them_in_order() {
	let out = run(
		"stub.world.onQuest(840, {})",
		GUIDE,
		r#"
			local w = stub.world
			local r = { start = groups(1), goalGroups = {} }
			for g, v in ipairs(E.GetStepView(1).goals) do r.goalGroups[g] = v.group end
			r.wp = { E.GetWaypoint().goalIndex }
			w.turnIn(840); flush()
			r.afterTurnin = groups(1).focus
			w.accept(842, {}); flush()
			r.thorkDone = groups(1).focus
			r.wp[2] = E.GetWaypoint().goalIndex
			w.accept(869, { 7, 12 }); flush()
			r.gazrogDone = groups(1).focus
			r.wp[3] = E.GetWaypoint().goalIndex
			w.accept(845, {}); flush()
			r.zarghHalf = groups(1).focus
			w.accept(871, {}); flush()
			r.stepAfter = E.GetStepIndex()
			emit(r)
		"#,
	);
	assert_eq!(
		out["start"],
		json!({
			"groups": ["npc Thork 1+2 open2", "npc Gazrog 3 open1", "npc Zargh 4+5+6 open2"],
			"focus": 1,
		})
	);
	assert_eq!(out["goalGroups"], json!([1, 1, 2, 3, 3, 3]));
	assert_eq!(out["wp"], json!([1, 3, 4]));
	assert_eq!(out["afterTurnin"], 1);
	assert_eq!(out["thorkDone"], 2);
	assert_eq!(out["gazrogDone"], 3);
	assert_eq!(out["zarghHalf"], 3);
	assert_eq!(out["stepAfter"], 2);
}

#[test]
fn a_field_step_stays_one_group_accept_kill_and_turn_in_at_one_npc_make_three_groups_in_order() {
	let out = run("", GUIDE, "emit({ field = groups(2), gazrog = groups(3) })");
	assert_eq!(out["field"], json!({ "groups": ["here nil 1+2+3 open3"], "focus": 1 }));
	assert_eq!(
		out["gazrog"],
		json!({
			"groups": ["npc Gazrog 1 open1", "here nil 2 open1", "npc Gazrog 3 open1"],
			"focus": 1,
		})
	);
}

// Teldrassil "The Balance of Nature" (#102), Badlands' cages, Silithus' braziers: objects clicked for a quest
// objective are field work beside the kills, not a person met after them. A plain click (no quest) is a visit.
#[test]
fn a_quest_interact_stays_in_the_field_group_a_plain_interact_is_its_own_group() {
	const FIELD: &str = r#"
Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Woods", faction = "Horde", minLevel = 10, maxLevel = 20, zone = 1413, steps = {
	{ title = "Woods", goals = {
		{ t = "kill", target = "Gnarlpine Ursa", count = 4, quest = 456, oi = 1, map = 1413, x = 55, y = 44 },
		{ t = "collect", item = 3297, itemName = "Fel Moss", count = 8, quest = 459, oi = 1, map = 1413, x = 55, y = 45 },
		{ t = "interact", quest = 97977, object = 668482, objName = "Gnarlpine Totem", oi = 1, map = 1413, x = 56, y = 46,
			spots = { { x = 56, y = 46, r = 15, n = 1 }, { x = 55.2, y = 44.2, r = 36, n = 2 } } },
	} },
	{ title = "Shrine", goals = {
		{ t = "kill", target = "Gnarlpine Ursa", count = 4, quest = 456, oi = 1, map = 1413, x = 55, y = 44 },
		{ t = "interact", quest = 97978, object = 668499, objName = "Old Shrine", oi = 1, map = 1413, x = 57, y = 47 },
		{ t = "interact", object = 668500, objName = "Moonwell", map = 1413, x = 58, y = 47 },
	} },
} })
"#;
	let out = run(
		"stub.world.onQuest(456, { 4 }); stub.world.onQuest(459, { 8 }); stub.world.onQuest(97977, { 4 }); stub.world.onQuest(97978, { 1 })",
		FIELD,
		"emit({ woods = groups(1), shrine = groups(2) })",
	);
	assert_eq!(out["woods"], json!({ "groups": ["here nil 1+2+3 open3"], "focus": 1 }));
	assert_eq!(out["shrine"], json!({ "groups": ["here nil 1+2 open2", "object Moonwell 3 open1"], "focus": 1 }));
}

#[test]
fn doing_a_later_person_first_marks_that_group_done_but_leaves_the_focus_on_the_first() {
	let out = run(
		"stub.world.onQuest(840, {})",
		GUIDE,
		r#"
			local w = stub.world
			w.accept(869, { 7, 12 }); w.accept(845, {}); flush()
			local r = groups(1)
			r.wp = E.GetWaypoint().goalIndex
			emit(r)
		"#,
	);
	assert_eq!(
		out,
		json!({
			"groups": ["npc Thork 1+2 open2", "npc Gazrog 3 done", "npc Zargh 4+5+6 open1"],
			"focus": 1,
			"wp": 1,
		})
	);
}

#[test]
fn the_focus_move_fires_step_updated_and_waypoint_changed() {
	let out = run(
		"stub.world.complete({ 840 })",
		GUIDE,
		r#"
			local log = {}
			Polestar.On("STEP_UPDATED", function(i) log[#log + 1] = "U" .. i end)
			Polestar.On("WAYPOINT_CHANGED", function(wp) log[#log + 1] = "W" .. (wp and wp.goalIndex or "nil") end)
			stub.world.accept(842, {}); flush()
			emit(log)
		"#,
	);
	assert_eq!(out, json!(["U1", "W3"]));
}

#[test]
fn skipped_and_unavailable_goals_do_not_hold_the_focus() {
	let out = run(
		"stub.world.onQuest(840, {})",
		GUIDE,
		r#"
			local w = stub.world
			-- The player skipped 842 (Skip this quest), and the turn-in is done: Thork's group is done.
			w.turnIn(840); flush()
			E.SkipQuest(842, true); flush()
			local r = groups(1)
			r.status = E.GetStepView(1).goals[2].status
			emit(r)
		"#,
	);
	assert_eq!(
		out,
		json!({
			"groups": ["npc Thork 1+2 done", "npc Gazrog 3 open1", "npc Zargh 4+5+6 open2"],
			"focus": 2,
			"status": "skipped",
		})
	);
}

// Camp Taurajo after the Bristleback camps (04-the-barrens step 31): Mangletooth's chain, then optional item
// quests, then a note.
const TAURAJO: &str = r#"
	Polestar.RegisterGuide({ id = "test/tj", pack = "test", title = "Taurajo", faction = "Horde", minLevel = 10, maxLevel = 30, steps = {
		{ title = "Camp Taurajo", goals = {
			{ t = "turnin", quest = 878, title = "Tribes at War", npc = 3430, npcName = "Mangletooth", map = 1413, x = 44.8, y = 59.1 },
			{ t = "accept", quest = 879, title = "Betrayal from Within", npc = 3430, npcName = "Mangletooth", map = 1413, x = 44.8, y = 59.1 },
			{ t = "collect", item = 5102, itemName = "Owatanka's Tailspike", count = 1, optional = true, map = 1413, x = 49, y = 60 },
			{ t = "note", text = "Mangletooth trades more Blood Shards for blessings." },
		} },
		{ title = "Field of Giants", goals = {
			{ t = "level", level = 25 },
			{ t = "goto", map = 1413, x = 44.7, y = 70.7, text = "Field of Giants" },
		} },
		{ title = "Blackthorn Ridge", goals = { { t = "accept", quest = 900, title = "Later", npc = 3431, npcName = "Someone", map = 1413, x = 40, y = 80 } } },
	} })
"#;

#[test]
fn a_done_step_viewed_with_prev_has_no_focus_and_no_waypoint_even_with_an_optional_goal_left_open() {
	let out = run(
		"stub.world.complete({ 878 }); stub.world.onQuest(879, { 1 })",
		TAURAJO,
		r#"
			E.SetGuide("test/tj")
			local r = { at = E.GetStepIndex() }
			E.Prev(); flush()
			local v = E.GetStepView(E.GetStepIndex())
			r.prev = { E.GetStepIndex(), v.focus or false, E.GetWaypoint() or false }
			emit(r)
		"#,
	);
	assert_eq!(out, json!({ "at": 2, "prev": [1, false, false] }));
}

#[test]
fn the_waypoint_never_leaves_the_focus_group_an_unlocated_focus_points_nowhere() {
	let out = run(
		"stub.world.complete({ 878 }); stub.world.onQuest(879, { 1 })",
		TAURAJO,
		r#"
			E.SetGuide("test/tj")
			local r = { at = E.GetStepIndex() }
			r.wp = E.GetWaypoint() or false
			emit(r)
		"#,
	);
	// "here" holds the level goal and the goto: the goto is in the focus.
	assert_eq!(out["at"], 2);
	assert_eq!(out["wp"]["goalIndex"], 2);

	let split = run(
		"stub.world.onQuest(840, {})",
		r#"
			Polestar.RegisterGuide({ id = "test/sp", pack = "test", title = "Split", faction = "Horde", minLevel = 1, maxLevel = 60, steps = { { goals = {
				{ t = "turnin", quest = 840, title = "Conscript of the Horde", npc = 3429, npcName = "Thork" },
				{ t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog", map = 1413, x = 51.9, y = 30.8 },
			} } } })
		"#,
		r#"E.SetGuide("test/sp"); emit({ focus = groups(1).focus, wp = E.GetWaypoint() or false })"#,
	);
	// Thork has no location here: the arrow must not jump to Gazrog, whom the window does not show yet.
	assert_eq!(split, json!({ "focus": 1, "wp": false }));
}

// #256: a bare `complete` after its giver's goals is a group of its own with no place. The arrow leads to the
// place of its group's work (a goto already reached), else to the group before it for the same quest (the
// giver), and never to a later group (the turn-in).
#[test]
fn a_bare_complete_leads_to_its_group_s_place_else_to_its_giver_before_it_never_to_the_turn_in() {
	let guides = r#"
		Polestar.RegisterGuide({ id = "test/cp", pack = "test", title = "Complete", faction = "Horde", minLevel = 1, maxLevel = 60, steps = {
			{ title = "Shenthul", goals = {
				{ t = "accept", quest = 2460, title = "The Shattered Salute", npc = 3401, npcName = "Shenthul", map = 1413, x = 43.0, y = 53.0 },
				{ t = "complete", quest = 2460, title = "The Shattered Salute" },
				{ t = "turnin", quest = 2460, title = "The Shattered Salute", npc = 3401, npcName = "Shenthul", map = 1413, x = 43.0, y = 53.0 },
			} },
			{ title = "Eastern Pylon", goals = {
				{ t = "goto", map = 1413, x = 60.0, y = 40.0, text = "Eastern Pylon" },
				{ t = "complete", quest = 4287, title = "The Eastern Pylon" },
				{ t = "turnin", quest = 4287, title = "The Eastern Pylon", npc = 9117, npcName = "J.D. Collie", map = 1413, x = 70.0, y = 70.0 },
			} },
			{ title = "Elsewhere", goals = {
				{ t = "accept", quest = 4289, title = "The Northern Pylon", npc = 9117, npcName = "J.D. Collie", map = 1413, x = 70.0, y = 70.0 },
				{ t = "complete", quest = 4288, title = "The Western Pylon" },
				{ t = "turnin", quest = 4288, title = "The Western Pylon", npc = 9117, npcName = "J.D. Collie", map = 1413, x = 70.0, y = 70.0 },
			} },
		} })
	"#;
	let out = run(
		"stub.world.onQuest(2460, { 1 }); stub.world.onQuest(4287, { 1 }); stub.world.onQuest(4288, { 1 }); stub.world.onQuest(4289, {})",
		guides,
		r#"
			E.SetGuide("test/cp")
			local function wp()
				local p = E.GetWaypoint()
				return p and { p.stepIndex, p.goalIndex, p.kind, p.x, p.y } or false
			end
			local r = { salute = wp() }
			E.Skip(); flush()
			r.pylon = wp()
			stub.world.moveTo(1413, 60, 40); flush()
			r.reached = wp()
			E.Skip(); flush()
			r.elsewhere = wp()
			emit(r)
		"#,
	);
	// The salute is done beside Shenthul: the arrow stays on him.
	assert_eq!(out["salute"], json!([1, 2, "complete", 43, 53]));
	// The goto leads first; once reached, the pylon's complete keeps its place.
	assert_eq!(out["pylon"], json!([2, 1, "goto", 60, 40]));
	assert_eq!(out["reached"], json!([2, 2, "complete", 60, 40]));
	// Only another quest's giver before the complete: no arrow, rather than that giver or the turn-in.
	assert_eq!(out["elsewhere"], false);
}

#[test]
fn smart_candidates_group_by_the_chosen_npc() {
	let guides = r#"
		Polestar.RegisterGuide({ id = "test/sm", pack = "test", title = "Smart", faction = "Horde", minLevel = 1, maxLevel = 60, steps = { { goals = {
			{ t = "train", skill = "First Aid", skillLine = 129, rank = 1, candidates = {
				{ npc = 3373, npcName = "Arnok", map = 1413, x = 52, y = 31, faction = "H" },
				{ npc = 5943, npcName = "Rawrk", map = 1413, x = 20, y = 80, faction = "H" },
			} },
			{ t = "learn", spell = 3275, spellName = "Linen Bandage", candidates = {
				{ npc = 3373, npcName = "Arnok", map = 1413, x = 52, y = 31, faction = "H" },
				{ npc = 5943, npcName = "Rawrk", map = 1413, x = 20, y = 80, faction = "H" },
			} },
			{ t = "buy", item = 159, itemName = "Water", candidates = {
				{ npc = 3934, npcName = "Innkeeper Boorand", map = 1413, x = 52, y = 30, faction = "H" },
			} },
		} } } })
	"#;
	let out = run(
		"",
		guides,
		r#"
			E.SetGuide("test/sm")
			local r = { near = groups(1) }
			E.CycleCandidate(1, 2) -- the learn goes to Rawrk now
			r.cycled = groups(1)
			emit(r)
		"#,
	);
	assert_eq!(
		out["near"],
		json!({
			"groups": ["npc Arnok 1+2 open2", "npc Innkeeper Boorand 3 open1"],
			"focus": 1,
		})
	);
	assert_eq!(
		out["cycled"],
		json!({
			"groups": ["npc Arnok 1 open1", "npc Rawrk 2 open1", "npc Innkeeper Boorand 3 open1"],
			"focus": 1,
		})
	);
}

#[test]
fn guidefocus_gives_the_live_frame_position_of_the_first_goal_on_the_guide_zone() {
	let guides = [
		GUIDE,
		r#"
			stub.world.addMap(1441, { name = "Thousand Needles", c = 1, left = 1000, right = -1000, top = 1000, bottom = -3000 })
			Polestar.RegisterMapFrames({ era = { [1441] = { c = 1, left = 1100, right = -900, top = 1100, bottom = -2900 } } }, "test")
			Polestar.RegisterGuide({ id = "test/era", pack = "test", title = "Era", faction = "Horde", minLevel = 1, maxLevel = 60, zone = 1441, steps = {
				{ goals = { { t = "goto", map = 1411, x = 10, y = 10 }, { t = "goto", map = 1441, x = 50, y = 50, f = "e" } } } } })
		"#,
	]
	.concat();
	let out = run(
		"",
		&guides,
		r#"
			local x, y = E.GuideFocus("test/xr")
			local ex, ey = E.GuideFocus("test/era")
			emit({ { x, y }, { math.floor(ex * 100 + 0.5) / 100, math.floor(ey * 100 + 0.5) / 100 }, E.GuideFocus("nope") or false })
		"#,
	);
	assert_eq!(out, json!([[51.5, 30.3], [45, 47.5], false]));
}

#[test]
fn guidefocus_follows_the_current_step_of_a_guide_open_in_a_tab_and_its_start_otherwise() {
	let guides = [
		GUIDE,
		r#"
			Polestar.RegisterGuide({ id = "test/away", pack = "test", title = "Away", faction = "Horde", minLevel = 10, maxLevel = 20, zone = 1413, steps = {
				{ goals = { { t = "goto", map = 1413, x = 40, y = 60 } } },
				{ goals = { { t = "goto", map = 1411, x = 10, y = 10 } } },
			} })
		"#,
	]
	.concat();
	let out = run(
		"",
		&guides,
		r#"
			local function at(id) local x, y = E.GuideFocus(id); return { x or false, y or false } end
			local r = { first = at("test/xr") }
			E.Goto(2); flush()
			r.field = at("test/xr")
			E.Goto(3); flush()
			r.gazrog = at("test/xr")
			E.OpenTab("test/away")
			E.Goto(2); flush()
			r.awayElsewhere = at("test/away")
			E.CloseTab(1); flush()
			r.closed = at("test/xr")
			emit(r)
		"#,
	);
	assert_eq!(
		out,
		json!({
			"first": [51.5, 30.3], "field": [45, 20], "gazrog": [51.9, 30.8],
			// The current step is on another map: where the guide starts.
			"awayElsewhere": [40, 60],
			"closed": [51.5, 30.3],
		})
	);
}
