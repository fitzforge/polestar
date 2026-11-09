//! Quest automation (addon/Polestar/Core/Automation.lua) driven through the stub world's quest, greeting and
//! gossip frames.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const GUIDE_BODY: &str = r#"Polestar.RegisterGuide({
	id = "test/auto", pack = "test", title = "Automation", minLevel = 1, maxLevel = 10,
	steps = {
		{ goals = { { t = "accept", quest = 783, title = "A Threat Within" } } },
		{ goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within" },
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup" },
		} },
		{ goals = { { t = "accept", quest = 33, title = "Wolves Across the Border" } } },
		{ goals = { { t = "level", level = 3 } } },
		{ goals = { { t = "accept", quest = 18, title = "Brotherhood of Thieves" } } },
	},
})
"#;

fn guide() -> String {
	["", TEST_PACK, TEST_SOURCE, GUIDE_BODY].join("\n")
}

const MAP: &str = r#"w = stub.world; w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); w.moveTo(1429, 48, 42)"#;

const CALLS: &str = r#"local c = {}; for i, x in ipairs(w.calls) do c[i] = table.concat({ tostring(x[1]), tostring(x[2]), tostring(x[3]) }, " ") end"#;

// `script` runs after login with `w` = stub.world and `flush()`; `${calls}` in it is CALLS.
fn run(before: &str, guides: &str, script: &str) -> Value {
	let script = script.replace("${calls}", CALLS);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{MAP}\n{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{guides}\nfunction flush() stub.advance(0.25) end\nstub.login()\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn accepts_a_quest_the_current_step_wants_and_nothing_else() {
	let out = run(
		"",
		&guide(),
		r#"
			w.questDetail(823, 999); w.close()
			w.questDetail(823, 783)
			flush()
			${calls}
			emit({ calls = c, onQuest = w.log[783] ~= nil, other = w.log[999] == nil, step = Polestar.Engine.GetStepIndex() })
		"#,
	);
	assert_eq!(out, json!({ "calls": ["AcceptQuest 783 nil"], "onQuest": true, "other": true, "step": 2 }));
}

// A step ahead's accept is taken only at its own NPC (Engine.WantsQuest: Own.aheadWants); these goals name no NPC,
// so only the live step's accept is taken.
#[test]
fn a_step_ahead_whose_accept_names_no_npc_is_never_taken_ahead() {
	let out = run(
		"",
		&guide(),
		r#"
			w.questDetail(1, 33)      -- step 3: two steps ahead
			w.close()
			w.questDetail(2, 7)       -- step 2: the next step
			w.close()
			w.questDetail(823, 783)   -- step 1: the live step
			flush()
			${calls}
			emit(c)
		"#,
	);
	assert_eq!(out, json!(["AcceptQuest 783 nil"]));
}

// Accepts ahead (Fitz, 0.3.6): talking to an NPC, auto-accept also takes the accepts the route takes there in its next
// five steps, so the route need not come back for them. 1 (live) Willem's 783; 2 Kobold Camp Cleanup (7) from Dughan
// (240); 3 Wolves (33) from Dughan for level 10 and up; 4 Candles (60) from Dughan, timed (LIMIT s), handed in to
// Maybell (251) 200 yd south in 5; 6 Brotherhood of Thieves (18) from Dughan, optional; 7 Bandits (88) from Dughan,
// level 9.
const AHEAD: &str = r#"Polestar.RegisterGuide({
	id = "test/ahead", pack = "test", title = "Ahead", minLevel = 1, maxLevel = 10,
	steps = {
		{ goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48, y = 42 } } },
		{ goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 48.5, y = 42 } } },
		{ when = { { k = "level", op = ">=", n = 10 } }, goals = { { t = "accept", quest = 33, title = "Wolves Across the Border", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 48.5, y = 42 } } },
		{ goals = { { t = "accept", quest = 60, title = "Candles", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 48.5, y = 42, limit = LIMIT } } },
		{ goals = { { t = "turnin", quest = 60, title = "Candles", npc = 251, npcName = "Maybell Maclure", map = 1429, x = 48.5, y = 52 } } },
		{ goals = { { t = "accept", quest = 18, title = "Brotherhood of Thieves", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 48.5, y = 42, optional = true } } },
		{ goals = { { t = "accept", quest = 88, title = "Princess Must Die!", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 48.5, y = 42, minLevel = 9 } } },
	},
})
"#;

fn ahead(limit: u32) -> String {
	["", TEST_PACK, TEST_SOURCE, &AHEAD.replace("LIMIT", &limit.to_string())].join("\n")
}

const AT_DUGHAN: &str = r#"
	E = Polestar.Engine
	E.SetGuide("test/ahead"); flush()
	local function wp() local x = E.GetWaypoint(); return x and (x.stepIndex .. ":" .. x.goalIndex) or "none" end
	local before = wp()
	w.questDetail(251, 7); flush(); w.close()   -- another NPC: never
	for _, q in ipairs({ 7, 33, 60, 18, 88 }) do w.questDetail(240, q); flush(); w.close() end
	local c = {}
	for _, x in ipairs(w.calls) do if x[1] == "AcceptQuest" then c[#c + 1] = "AcceptQuest " .. tostring(x[2]) .. " " .. tostring(x[3]) end end
	emit({ calls = table.concat(c, ", "), live = E.GetLiveStep(), arrow = wp(), before = before, done2 = E.GoalDone(2, 1) })
"#;

#[test]
fn talking_to_the_next_steps_giver_takes_its_accepts_the_live_step_and_the_arrow_stay() {
	let out = run("", &ahead(600), AT_DUGHAN);
	// 7 and the timed 60 (a 38 s walk to Maybell and two talks in 600 s); not 33 (level 10 step), 18 (optional) nor 88
	// (level 9), and never 7 at Maybell.
	assert_eq!(out["calls"], "AcceptQuest 7 nil, AcceptQuest 60 nil", "{out}");
	assert_eq!(out["live"], 1, "{out}");
	assert_eq!(out["arrow"], out["before"], "the arrow stays on the live step: {out}");
	assert_eq!(out["done2"], true, "step 2's accept reads done: {out}");
}

#[test]
fn a_timed_accept_whose_walk_does_not_fit_a_full_log_or_auto_accept_off_takes_nothing_ahead() {
	let short = run("", &ahead(60), AT_DUGHAN);
	assert_eq!(short["calls"], "AcceptQuest 7 nil", "60 s for a 38 s walk and two talks is past the 60% margin: {short}");
	let full = run("for q = 1001, 1018 do w.onQuest(q, {}) end", &ahead(600), AT_DUGHAN);
	assert_eq!(full["calls"], "", "18 of 20 slots taken: two stay free: {full}");
	let off = run("", &ahead(600), &format!("Polestar.Set(\"behavior.autoAccept\", false)\n{AT_DUGHAN}"));
	assert_eq!(off["calls"], "", "{off}");
}

#[test]
fn reading_ahead_with_next_accepts_the_quests_of_the_live_step_and_never_the_ones_of_the_step_in_view() {
	let out = run(
		"",
		&guide(),
		r#"
			Polestar.Engine.Next(); Polestar.Engine.Next()
			local viewed, live = Polestar.Engine.GetStepIndex(), Polestar.Engine.GetLiveStep()
			w.questDetail(1, 33)      -- step 3: the step in view
			w.close()
			w.questDetail(823, 783)   -- step 1: the live step, behind the view
			flush()
			${calls}
			emit({ calls = c, viewed = viewed, live = live })
		"#,
	);
	assert_eq!(out, json!({ "calls": ["AcceptQuest 783 nil"], "viewed": 3, "live": 1 }));
}

#[test]
fn holding_shift_or_turning_the_settings_off_suppresses_automation() {
	let out = run(
		"w.complete({ 783 })",
		&guide(),
		r#"
			stub.keys.shift = true
			w.questDetail(197, 7); w.close()
			stub.keys.shift = false
			Polestar.Set("behavior.autoAccept", false)
			w.questDetail(197, 7); w.close()
			Polestar.Set("behavior.autoAccept", true)
			w.onQuest(783, {}) ; w.completed[783] = nil
			Polestar.Set("behavior.autoTurnin", false)
			w.questProgress(197, 783); w.close()
			${calls}
			emit(c)
		"#,
	);
	assert_eq!(out, json!({})); // no calls (Lua encodes an empty list as {})
}

#[test]
fn gossip_turns_in_the_finished_guide_quest_first_then_accepts_the_follow_up() {
	let out = run(
		"w.onQuest(783, {})",
		&guide(),
		r#"
			local opts = {
				active = { { questID = 783, isComplete = true }, { questID = 999, isComplete = true } },
				available = { { questID = 7, objectives = { 10 } } },
			}
			w.gossip(197, opts)
			flush()
			w.gossip(197, { available = opts.available })
			flush()
			${calls}
			emit({ calls = c, done = w.completed[783], on7 = w.log[7] ~= nil, step = Polestar.Engine.GetStepIndex() })
		"#,
	);
	assert_eq!(
		out,
		json!({
			"calls": [
				"C_GossipInfo.SelectActiveQuest 783 nil",
				"CompleteQuest 783 nil",
				"GetQuestReward 783 0",
				"C_GossipInfo.SelectAvailableQuest 7 nil",
				"AcceptQuest 7 nil",
			],
			"done": true,
			"on7": true,
			"step": 3,
		})
	);
}

#[test]
fn never_picks_among_several_rewards_takes_the_only_reward_when_there_is_one() {
	let several = run(
		"w.onQuest(783, {}); w.choices[783] = 3",
		&guide(),
		r#"
			stub.messages = {}
			w.questProgress(197, 783)
			${calls}
			emit({ calls = c, onQuest = w.log[783] ~= nil, frame = w.frame and w.frame.kind, said = stub.messages[1] })
		"#,
	);
	assert_eq!(
		several,
		json!({
			"calls": ["CompleteQuest 783 nil"],
			"onQuest": true,
			"frame": "complete",
			"said": "|cff4fd1c5Polestar|r: Choose a reward to finish the turn-in.",
		})
	);

	let one = run(
		"w.onQuest(783, {}); w.choices[783] = 1",
		&guide(),
		r#"
			w.questProgress(197, 783)
			${calls}
			emit(c)
		"#,
	);
	assert_eq!(one, json!(["CompleteQuest 783 nil", "GetQuestReward 783 1"]));
}

#[test]
fn leaves_unfinished_costly_pvp_and_non_guide_quests_alone() {
	let out = run(
		"w.onQuest(783, { 2 })",
		&guide(),
		r#"
			w.gossip(197, { active = { { questID = 783, isComplete = false } } }); w.close()
			w.questProgress(197, 783); w.close()           -- objectives not done
			w.finish(783)
			w.questComplete(197, 783, { money = 500 }); w.close()
			w.onQuest(999, {})
			w.questProgress(197, 999); w.close()           -- not a turnin goal
			w.questDetail(197, 7, { pvp = true }); w.close()
			${calls}
			emit({ calls = c, onQuest = w.log[783] ~= nil })
		"#,
	);
	assert_eq!(out, json!({ "calls": {}, "onQuest": true }));
}

#[test]
fn auto_accept_quests_are_acknowledged_instead_of_accepted() {
	let out = run(
		"",
		&guide(),
		r#"
			w.questDetail(823, 783, { auto = true })
			${calls}
			emit({ calls = c, onQuest = w.log[783] ~= nil })
		"#,
	);
	assert_eq!(out, json!({ "calls": ["AcknowledgeAutoAcceptQuest 783 nil"], "onQuest": true }));
}

#[test]
fn the_greeting_panel_selects_guide_quests_by_their_index() {
	let out = run(
		"w.complete({ 783 })",
		&guide(),
		r#"
			w.greeting(197, { active = { { questID = 999, isComplete = true } }, available = { { questID = 998 }, { questID = 7, objectives = { 10 } } } })
			${calls}
			emit({ calls = c, on7 = w.log[7] ~= nil })
		"#,
	);
	assert_eq!(out, json!({ "calls": ["SelectAvailableQuest 7 2", "AcceptQuest 7 nil"], "on7": true }));
}

// Issue #108: Distracting Jarven (308) is handed in from Jarven Thunderbrew's window with no accept, so the NPC
// lists it among the quests it offers, not among the ones in the log. `turnin ... direct` is that goal.
const DIRECT_BODY: &str = r#"Polestar.RegisterGuide({
	id = "test/auto", pack = "test", title = "Direct", minLevel = 1, maxLevel = 10,
	steps = {
		{ goals = { { t = "turnin", quest = 308, title = "Distracting Jarven", direct = true, npc = 1373, npcName = "Jarven Thunderbrew" } } },
		{ goals = { { t = "level", level = 3 } } },
	},
})
"#;

fn direct() -> String {
	["", TEST_PACK, TEST_SOURCE, DIRECT_BODY].join("\n")
}

#[test]
fn t_108_a_direct_turn_in_is_taken_from_the_quests_the_giver_offers_and_finished_in_the_progress_window() {
	let out = run(
		"",
		&direct(),
		r#"
			w.gossip(1373, { available = { { questID = 999 }, { questID = 308 } } }); flush()
			-- The client opens the progress window for a quest with no accept: the
			-- window says itself that the hand-in can be made.
			w.questProgress(1373, 308, { completable = true }); flush()
			${calls}
			emit({ calls = c, step = Polestar.Engine.GetStepIndex() })
		"#,
	);
	assert_eq!(out["calls"], json!(["C_GossipInfo.SelectAvailableQuest 308 nil", "CompleteQuest 308 nil", "GetQuestReward 308 0"]));
	assert_eq!(out["step"], 2);
}

#[test]
fn t_108_a_direct_turn_in_follows_autoturnin_not_autoaccept_there_is_no_accept_to_make() {
	let script = r#"
		w.gossip(1373, { available = { { questID = 308 } } }); flush()
		${calls}
		emit(c)
	"#;
	let accept_only = run("", &direct(), &format!("Polestar.Set(\"behavior.autoTurnin\", false)\n{script}"));
	assert_eq!(accept_only, json!({}), "auto-accept alone must not hand anything in"); // no calls (Lua encodes an empty list as {})
	let turnin_only = run("", &direct(), &format!("Polestar.Set(\"behavior.autoAccept\", false)\n{script}"));
	assert_eq!(turnin_only, json!(["C_GossipInfo.SelectAvailableQuest 308 nil"]));
}

// Jarven and the cloth quartermasters keep offering their repeatable quest: a `direct` goal already done must
// not hand in another ale or more cloth.
#[test]
fn t_108_a_direct_turn_in_already_done_is_never_handed_in_again() {
	const BODY: &str = r#"Polestar.RegisterGuide({
	id = "test/auto", pack = "test", title = "Direct", minLevel = 1, maxLevel = 10,
	steps = {
		{ goals = {
			{ t = "turnin", quest = 308, title = "Distracting Jarven", direct = true, npc = 1373, npcName = "Jarven Thunderbrew" },
			{ t = "level", level = 3 },
		} },
	},
})
"#;
	let guide = ["", TEST_PACK, TEST_SOURCE, BODY].join("\n");
	let out = run(
		"w.repeatable[308] = true",
		&guide,
		r#"
			w.gossip(1373, { available = { { questID = 308 } } }); flush()
			w.questProgress(1373, 308, { completable = true }); flush()
			local first = #w.calls
			stub.advance(5) -- a later visit, not the window the game opens after the turn-in (#360)
			w.gossip(1373, { available = { { questID = 308 } } }); flush(); w.close()
			w.questProgress(1373, 308, { completable = true }); flush(); w.close()
			w.greeting(1373, { available = { { questID = 308 } } }); flush(); w.close()
			emit({ first = first, again = #w.calls - first, status = Polestar.Engine.GetStepView(1).goals[1].status })
		"#,
	);
	assert_eq!(out, json!({ "first": 3, "again": 0, "status": "done" }));
}
