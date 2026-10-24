//! Pinned quests at runtime (#644; addon/Polestar/Core/Engine.lua, "Pinned quests"): the player pins a quest of
//! the log as along the way (Engine.PinQuest); its open objectives join Engine.GetAlong under whatever step is
//! current, the guide's own goal for a line when it has one, else one built from the quest log; the arrow can
//! lead to one (Engine.AimAlong); a step that turns the quest in while they are open marks its turn-in
//! (`pinOpen`); pins are saved per character and a turn-in drops them. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"; w.titles[7] = "Kobold Camp Cleanup"; w.titles[33] = "Wolves Across the Border"
"#;

// 1 accept 7 · 2 accept 783 · 3 kill 10 vermin for 7 (placed) · 4 turn in 7 · 5 turn in 783.
// Quest 33 is in no step.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/pin", pack = "test", title = "Pin", minLevel = 1, maxLevel = 6,
	steps = {
		{ title = "McBride", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Willem", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
		{ title = "Kobolds", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
		{ title = "Back to McBride", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Back to Willem", goals = { { t = "turnin", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- "<pin or step>|<step>:<goal>[:<progress>]" for each goal Engine.GetAlong lists.
function along()
	local out = {}
	for _, s in ipairs(E.GetAlong()) do
		for _, g in ipairs(s.goals) do
			out[#out + 1] = (s.pin or s.index) .. "|" .. g.step .. ":" .. g.index .. (g.progress and (":" .. g.progress.cur) or "")
		end
	end
	return table.concat(out, " ")
end
function wp()
	local w = E.GetWaypoint()
	return w and (w.stepIndex .. ":" .. w.goalIndex) or "none"
end
function pins()
	local out = {}
	for q in pairs(PolestarCharDB.pinnedQuests or {}) do out[#out + 1] = q end
	table.sort(out)
	return table.concat(out, ",")
end
"#;

fn run_saved(script: &str, saved: &str) -> Value {
	json!(emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), format!("PolestarCharDB = {saved}"))],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	}))
}

fn run(script: &str) -> Value {
	run_saved(script, r#"{ schema = 1, guide = "test/pin" }"#)
}

#[test]
fn a_pinned_quest_s_open_objectives_are_listed_along_the_way_beside_the_current_step_until_done_or_unpinned() {
	let out = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush()
		emit({ E.GetLiveStep(), along() })              -- step 2, nothing pinned
		emit(E.PinQuest(7)); flush()
		emit({ along(), E.IsPinned(7), pins() })        -- step 3's kill, the guide's own goal
		w.accept(33, { { required = 8, text = "Prowler slain: 0/8" } }); flush()
		E.PinQuest(33); flush()
		emit(along())                                   -- quest 33: a goal built from the log
		emit(E.GetAlong()[2].goals[1].text)
		w.progress(7, 1, 4); flush()
		emit(along())
		E.PinQuest(33, false); flush()
		emit({ along(), pins() })
		w.progress(7, 1, 10); flush()
		emit(along())                                   -- done: gone, still pinned until turned in
	"#);
	assert_eq!(out, json!([[2, ""], true, ["7|3:1:0", true, "7"], "7|3:1:0 33|0:3301:0", "Kill Prowler", "7|3:1:4 33|0:3301:0", ["7|3:1:4", "7"], ""]));
}

#[test]
fn the_arrow_leads_to_a_pinned_goal_a_turn_in_ahead_of_a_pinned_quest_still_open_is_marked_a_turn_in_drops_the_pin() {
	let out = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush()
		emit(E.AimAlong(3, 1))                          -- not pinned: no along goal
		E.PinQuest(7); flush()
		emit(E.AimAlong(3, 1)); flush()
		emit(wp())
		emit({ E.GetStepView(4).goals[1].pinOpen or false, E.GetStepView(5).goals[1].pinOpen or false })
		w.progress(7, 1, 10); flush()
		emit({ E.GetStepView(4).goals[1].pinOpen or false, wp() })
		w.turnIn(7); flush()
		emit({ along(), pins() })
	"#);
	assert_eq!(out, json!([false, true, "3:1", [true, false], [false, "2:1"], ["", ""]]));
}

#[test]
fn pins_are_saved_per_character_and_come_back_at_login() {
	let out = run_saved(
		r#"
		stub.world.accept(7, { 10 }); flush()
		emit({ E.IsPinned(7), along() })
	"#,
		r#"{ schema = 1, guide = "test/pin", pinnedQuests = { [7] = true } }"#,
	);
	assert_eq!(out, json!([[true, "7|3:1:0"]]));
}
