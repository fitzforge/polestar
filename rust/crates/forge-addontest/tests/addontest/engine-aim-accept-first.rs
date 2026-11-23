//! #1385: a goal picked for the arrow (a row click, Engine.AimGoal; the waypoint keys, Engine.CycleWaypoint)
//! whose quest waits for its accept in the step is not where the arrow goes: it stays on the accept, the click says
//! "Take <quest> first", and the keys pass the goal. Once the quest is taken the pick holds, and the report marks
//! both the window's current goal (`[>]`) and the arrow's (`[→]`). The whole addon, the stub world, a Scourge
//! Priest at General Twinbraid's Strongbox in Bael Modan, as in the report.

use forge_addontest::{emitted, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 2622.917, right = -7510.417, top = 1612.5, bottom = -5143.75 })
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Scourge", "Undead", "PRIEST", "Priest", "Horde", 27
w.zone, w.subzone = "The Barrens", "Bael Modan"
w.moveTo(1413, 49.04, 84.32)
"#;

// The Tear of the Moons as 0.3.5's Barrens guide wrote it: Feegly's accept, the strongbox, Feegly's turn-in.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/tear", pack = "test", title = "Barrens", faction = "Horde", minLevel = 24, maxLevel = 27, zone = 1413, steps = {
	{ title = "Tear of the Moons", goals = {
		{ t = "accept", quest = 857, title = "The Tear of the Moons", npc = 3421, npcName = "Feegly the Exiled", minLevel = 22, map = 1413, x = 48.97, y = 86.31 },
		{ t = "collect", quest = 857, title = "The Tear of the Moons", item = 5038, itemName = "Tear of the Moons", count = 1, oi = 1, map = 1413, x = 49.1, y = 84.3,
			from = "General Twinbraid's Strongbox", fromKind = "object", fromId = 3646 },
		{ t = "turnin", quest = 857, title = "The Tear of the Moons", npc = 3421, npcName = "Feegly the Exiled", map = 1413, x = 48.97, y = 86.31 },
	} },
	{ title = "Gann Stonespire", goals = {
		{ t = "turnin", quest = 849, title = "Revenge of Gann", npc = 3341, npcName = "Gann Stonespire", map = 1413, x = 45.89, y = 77 },
	} },
} })
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
GF = Polestar.UI.GuideFrame
function wpGoal() local wp = E.GetWaypoint(); return wp and wp.goalIndex or false end
-- The report's goal lines, up to their first fact.
function goalLines()
	local out = {}
	for _, l in ipairs(Polestar.UI.Report.Details().lines) do
		if l:find("^%[") then out[#out + 1] = l:match("^(.-) \194\183 ") or l end
	end
	return out
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/tear" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_goal_picked_before_its_quest_is_taken_leaves_the_arrow_on_the_accept_and_the_waypoint_keys_pass_it() {
	let out = run(r#"
		local r = { start = wpGoal() }
		r.click = { E.AimGoal(1, 2) }; stub.advance(0.6)
		r.afterClick = wpGoal()
		r.override = Polestar.Nav.IsOverride() or false
		r.turnin = { E.AimGoal(1, 3) }; stub.advance(0.6)
		r.afterTurnin = wpGoal()
		r.key = Polestar.Engine.CycleWaypoint(1); stub.advance(0.6)
		r.afterKey = wpGoal()
		r.report = goalLines()
		emit(r)"#);
	assert_eq!(out["start"], 1, "the arrow starts on Feegly's accept");
	assert_eq!(out["click"], json!([false, "accept", "The Tear of the Moons"]), "the pick is refused, with the quest to take first");
	assert_eq!(out["afterClick"], 1, "the arrow stays on the accept, not the strongbox (#1385)");
	assert_eq!(out["override"], false);
	assert_eq!(out["turnin"], json!([false, "accept", "The Tear of the Moons"]), "a turn-in waits for the accept too");
	assert_eq!(out["afterTurnin"], 1);
	assert_eq!(out["key"], false, "the waypoint keys find nothing else to lead to: both other goals wait for the accept");
	assert_eq!(out["afterKey"], 1);
	assert_eq!(
		out["report"],
		json!(["[>] Accept “The Tear of the Moons”", "[ ] Collect Tear of the Moons from General Twinbraid's Strongbox", "[ ] Turn in “The Tear of the Moons”"]),
		"the window's current goal and the arrow's are one"
	);
}

#[test]
fn once_the_quest_is_taken_a_pick_holds_and_the_report_marks_the_current_goal_and_the_arrows_apart() {
	let out = run(r#"
		w.accept(857, { { text = "Tear of the Moons: 0/1", type = "item", required = 1, fulfilled = 0 } }, "The Tear of the Moons"); stub.advance(0.6)
		local r = { taken = wpGoal() }
		r.click = { E.AimGoal(1, 3) }; stub.advance(0.6)
		r.picked = wpGoal()
		r.current = E.GetStepView(1).current
		r.report = goalLines()
		emit(r)"#);
	assert_eq!(out["taken"], 2, "with the quest taken the arrow goes on to the strongbox");
	assert_eq!(out["click"], json!([true]));
	assert_eq!(out["picked"], 3, "the turn-in the player picked");
	assert_eq!(out["current"], 2, "the window's current goal is still the strongbox");
	let report: Vec<&str> = out["report"].as_array().unwrap().iter().map(text).collect();
	assert_eq!(
		report,
		["[x] Accept “The Tear of the Moons”", "[>] Collect Tear of the Moons from General Twinbraid's Strongbox 0/1", "[\u{2192}] Turn in “The Tear of the Moons”"],
		"[>] the window's current goal, [→] the arrow's"
	);
}
