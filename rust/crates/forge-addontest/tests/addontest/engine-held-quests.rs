//! Held quests (#3390): a quest an earlier guide takes for a later one to hand in (the Booty Bay quests the
//! Stranglethorn guide takes for the next one's Wild Shore stop). Abandoned while the route still hands it in, the
//! later guide asks as a guide asks for a quest of its own that left the log (Engine.LostQuestion: its goals greyed,
//! the live step held); "back" brings the earlier guide's accept into its route (a carried accept, Own.carryChains),
//! "skip" skips it, behavior.lostQuests answers at once. Auto-accept takes a quest the loaded guide hands in ahead
//! and does not take itself at its giver. While it is carried, the quest log's and the objective tracker's titles say
//! "kept for <guide>" (Quests/KeptFor.lua; the log row's tooltip says it whole), and so does a While-here line
//! (UI.HereStep). Stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1434, { name = "Stranglethorn Vale", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1434, 27, 77)
w.level = 40
w.titles[600] = "Venture Company Mining"
"#;

// test/a takes 600 at Baron Revilgaz in Booty Bay and goes on; test/b, after it, kills the miners on the Wild Shore
// and hands 600 in at Booty Bay.
const GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "First", minLevel = 1, maxLevel = 60, next = "test/b", steps = {
	{ title = "Booty Bay", goals = { { t = "accept", quest = 600, title = "Venture Company Mining", npc = 2496, npcName = "Baron Revilgaz", map = 1434, x = 27, y = 77 } } },
	{ title = "On", goals = { { t = "goto", map = 1434, x = 40, y = 40, text = "On" } } },
} })
Polestar.RegisterGuide({ id = "test/b", pack = "test", title = "Second", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Wild Shore", goals = { { t = "kill", npc = 674, target = "Venture Co. Strip Miner", count = 15, quest = 600, oi = 1, map = 1434, x = 30, y = 80 } } },
	{ title = "Booty Bay", goals = { { t = "turnin", quest = 600, title = "Venture Company Mining", npc = 2496, npcName = "Baron Revilgaz", map = 1434, x = 27, y = 77 } } },
	{ title = "Later", goals = { { t = "goto", map = 1434, x = 50, y = 50, text = "Later" } } },
} })
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25); stub.advance(0.6) end
function state()
	local q, title = E.LostQuestion()
	local live = E.GetLiveStep()
	local g = live and E.GetStepView(live).goals[1]
	return { live = live or false, lost = q or false, title = title or false, skipped = E.IsQuestSkipped(600),
		goal = g and (g.t .. " " .. tostring(g.quest) .. " " .. g.status) or false }
end
"#;

fn run(world: &str, saved: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{world}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), format!(r#"PolestarCharDB = {{ schema = 1, guide = "test/b" }}{saved}"#))],
		script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

// The player carries 600 into test/b, its miners not killed yet.
const CARRIED: &str = r#"w.onQuest(600, { { type = "monster", text = "Venture Co. Strip Miner slain", need = 15 } })"#;

#[test]
fn a_kept_quest_abandoned_in_the_guide_that_hands_it_in_is_asked_about_and_its_goals_wait() {
	let out = run(
		CARRIED,
		"",
		r#"
		emit(state())
		stub.world.abandon(600); flush()
		emit(state())
	"#,
	);
	assert_eq!(out[0], json!({ "live": 1, "lost": false, "title": false, "skipped": false, "goal": "kill 600 active" }));
	assert_eq!(
		out[1],
		json!({ "live": 1, "lost": 600, "title": "Venture Company Mining", "skipped": false, "goal": "kill 600 skipped" }),
		"the live step stays on the miners, greyed, and the window asks (titled from the hand-in: test/b has no accept)"
	);
}

#[test]
fn going_back_for_it_brings_the_earlier_guide_s_accept_into_the_route() {
	let out = run(
		CARRIED,
		"",
		r#"
		stub.world.abandon(600); flush()
		E.AnswerLost(600, "back"); flush(); flush()
		local g = E.GetStepView(E.GetLiveStep()).goals[1]
		emit(state())
		emit({ npc = g.npc, feeder = E.GetGuide().steps[E.GetLiveStep()].feeder or false })
		stub.world.accept(600, { { type = "monster", text = "Venture Co. Strip Miner slain", need = 15 } }); flush()
		emit(state())
	"#,
	);
	assert_eq!(out[0], json!({ "live": 1, "lost": false, "title": false, "skipped": false, "goal": "accept 600 active" }));
	assert_eq!(out[1], json!({ "npc": 2496, "feeder": "test/a" }), "test/a's accept at Baron Revilgaz, put in first");
	assert_eq!(out[2]["goal"], json!("kill 600 active"), "taken again, the miners are next: {}", out[2]);
}

#[test]
fn skipping_it_keeps_the_route_and_skips_the_quest() {
	let out = run(
		CARRIED,
		"",
		r#"
		stub.world.abandon(600); flush()
		E.AnswerLost(600, "skip"); flush()
		emit(state())
	"#,
	);
	assert_eq!(out[0], json!({ "live": 3, "lost": false, "title": false, "skipped": true, "goal": "goto nil active" }));
}

#[test]
fn the_lost_quests_setting_answers_at_once_and_says_so() {
	let out = run(
		CARRIED,
		"",
		r#"
		Polestar.Set("behavior.lostQuests", "back"); flush()
		stub.world.abandon(600); flush(); flush()
		local said = {}
		for _, m in ipairs(stub.messages) do
			if m:find("quest log", 1, true) then said[#said + 1] = m:gsub("^.-: ", "") end
		end
		local s = state()
		s.said = #said
		emit(s)
	"#,
	);
	assert_eq!(out[0], json!({ "live": 1, "lost": false, "title": false, "skipped": false, "goal": "accept 600 active", "said": 1 }));
}

// The player never had 600: test/b's miners and hand-in are not theirs, the route is past them. At Baron Revilgaz,
// auto-accept takes it, and the route comes back for the miners.
#[test]
fn auto_accept_takes_a_quest_the_loaded_guide_hands_in_but_never_took_and_the_route_comes_back_for_it() {
	let out = run(
		"",
		"",
		r#"
		emit({ live = E.GetLiveStep(), wants = E.WantsQuest("accept", 600) })
		stub.world.accept(600, { { type = "monster", text = "Venture Co. Strip Miner slain", need = 15 } }); flush()
		emit(state())
	"#,
	);
	assert_eq!(out[0], json!({ "live": 3, "wants": true }));
	assert_eq!(out[1], json!({ "live": 1, "lost": false, "title": false, "skipped": false, "goal": "kill 600 active" }));
}

#[test]
fn auto_accept_leaves_one_the_player_skipped() {
	let out = run(
		"",
		"",
		r#"
		E.SkipQuest(600, true); flush()
		emit(E.WantsQuest("accept", 600))
	"#,
	);
	assert_eq!(out, vec![json!(false)]);
}

// The full addon in test/a, carrying 600 for test/b (title "B" and quest title "Ore": the stub's string widths count
// colour codes, so these fit). No guide of the route hands in 601.
fn run_labels(script: &str) -> Vec<Value> {
	let guides = GUIDES.replace(r#"title = "Second""#, r#"title = "B""#);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_quests.lua", "stub_questlog.lua"],
		before: format!(
			r#"{WORLD}
w.onQuest(600, {{}}); w.onQuest(601, {{}})
local ql = stub.questlog
ql.quests[600] = {{ title = "Ore", level = 40 }}; ql.quests[601] = {{ title = "Other", level = 40 }}; ql.log = {{ 600, 601 }}
"#
		),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/a" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, &guides, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, "ql = stub.questlog", script].join("\n"),
		..Default::default()
	})
}

#[test]
fn the_quest_log_and_tracker_say_a_carried_quest_is_kept_for_the_guide_that_hands_it_in() {
	let out = run_labels(
		r#"
		-- The guides' own lines (qol.questGuides, Quests/QuestGuides.lua) left out: this reads Kept for alone.
		Polestar.Set("qol.questGuides", false)
		ql.updateLog(); ql.updateTracker(600); ql.updateTracker(601)
		emit({ log = { ql.logText(600), ql.logText(601) }, tracker = { ql.trackerText(600), ql.trackerText(601) },
			tip = ql.hoverLog(600), other = ql.hoverLog(601) })
		ql.updateLog(); emit(ql.logText(600))
		Polestar.SetHidden(true); emit(ql.logText(600))
	"#,
	);
	let dim = "|cffc3cadd";
	assert_eq!(out[0]["log"], json!([format!("[40] Ore{dim} · kept for B|r"), "[40] Other"]), "{}", out[0]);
	assert_eq!(out[0]["tracker"], json!([format!("|cffffd100[40] Ore|r{dim} · kept|r"), "|cffffd100[40] Other|r"]), "the whole would wrap the header: {}", out[0]);
	assert_eq!(out[0]["tip"], json!(["Ore", "Kept for B: the route hands it in there."]));
	assert_eq!(out[0]["other"], json!(["Other"]), "a quest of no later guide of the route says nothing");
	assert_eq!(out[1], json!(format!("[40] Ore{dim} · kept for B|r")), "once, however often the log is drawn");
	assert_eq!(out[2], json!("[40] Ore"), "hidden, the text is put back");
}

// A line of the loaded guide's step (UI.StepNo numbers it as the window does).
#[test]
fn a_while_here_line_of_a_kept_quest_says_so_after_its_step() {
	let out = run_labels(r#"local UI = Polestar.UI; emit({ UI.HereStep({ step = 2, keptFor = "B" }), UI.HereStep({ step = 2 }), "Step " .. UI.StepNo(2) })"#);
	let step = out[0][2].as_str().unwrap();
	assert_eq!(out[0], json!([format!("{step} · kept for B"), step, step]));
}
