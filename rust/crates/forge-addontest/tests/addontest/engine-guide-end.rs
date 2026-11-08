//! The end of a leveling guide (Engine, Own.noteEnd; behavior.guideEnd): reaching the last step asks once per
//! guide per character (GUIDE_END), Engine.StartNext loads the next guide in the same tab, "continue" hands off
//! by itself with GUIDE_CONTINUED, other guides keep going on. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1411, { name = "Durotar", c = 1, left = -3000, right = -6000, top = 1000, bottom = -2000 })
w.addMap(1413, { name = "The Barrens", c = 1, left = 0, right = -3000, top = 1000, bottom = -2000 })
w.race, w.raceName, w.faction, w.class = "Orc", "Orc", "Horde", "WARRIOR"
w.moveTo(1411, 52, 43)
"#;

// Durotar's shape: four quests, the last the hand-off to the next zone. @NEXT@ is its `next` (and choices).
const GUIDES: &str = r#"
local function q(id, title) return { goals = { { t = "accept", quest = id, title = title, map = 1411, x = 50, y = 50 } } } end
Polestar.RegisterGuide({ id = "test/durotar", pack = "test", title = "Durotar", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411,
	@NEXT@ steps = { q(10, "Your Place"), q(11, "Cutting Teeth"), q(12, "Sarkoth"), q(13, "Far Watch Post") } })
Polestar.RegisterGuide({ id = "test/barrens", pack = "test", title = "The Barrens", faction = "Horde", minLevel = 12, maxLevel = 16, zone = 1413,
	steps = { { goals = { { t = "level", level = 16 } } } } })
Polestar.RegisterGuide({ id = "test/silverpine", pack = "test", title = "Silverpine Forest", faction = "Horde", minLevel = 10, maxLevel = 18,
	steps = { { goals = { { t = "level", level = 18 } } } } })
Polestar.RegisterGuide({ id = "test/cooking", pack = "test", title = "Cooking", category = "Professions", next = "test/cooking2",
	steps = { q(20, "Cooking 1") } })
Polestar.RegisterGuide({ id = "test/cooking2", pack = "test", title = "Cooking 2", category = "Professions",
	steps = { { goals = { { t = "level", level = 30 } } } } })
-- Dun Morogh's shape: the last step is the walk on to the next zone. The second also has work in that zone
-- before it (as Darkshore visits Elwynn before it ends there).
local walk = { title = "The Barrens", goals = { { t = "goto", map = 1413, x = 50, y = 50, text = "The Barrens" } } }
Polestar.RegisterGuide({ id = "test/walk", pack = "test", title = "Walk", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
	steps = { q(30, "One"), q(31, "Two"), q(32, "Three"), walk } })
Polestar.RegisterGuide({ id = "test/visit", pack = "test", title = "Visit", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
	steps = { q(40, "One"), { goals = { { t = "accept", quest = 41, title = "In the Barrens", map = 1413, x = 20, y = 20 } } }, q(42, "Three"), walk } })
-- Stranglethorn's shape: trailing steps that only offer (riding at a level, all optional; a note), and one
-- ending at any class trainer.
Polestar.RegisterGuide({ id = "test/offer", pack = "test", title = "Offer", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
	steps = { q(50, "One"), q(51, "Two"), q(52, "Last quest"),
		{ title = "Riding", when = { { k = "level", op = ">=", n = 5 } }, goals = { { t = "train", npc = 7954, optional = true }, { t = "vendor", npc = 7955, optional = true } } },
		{ goals = { { t = "note", text = "Next: the Barrens." } } } } })
Polestar.RegisterGuide({ id = "test/trainer", pack = "test", title = "Trainer", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
	steps = { q(60, "One"), q(61, "Two"), { title = "Class trainer", goals = { { t = "train", class = true } } } } })
-- The Barrens' Kolkar chain at Regthar Deathgate (#998): each hand-in opens the next quest, and the last
-- step is the chain's last hand-in.
local function at(t, id, pre)
	return { t = t, quest = id, title = "Kolkar " .. id, npc = 3389, npcName = "Regthar Deathgate", map = 1413, x = 45, y = 28, pre = pre }
end
Polestar.RegisterGuide({ id = "test/kolkar", pack = "test", title = "Kolkar", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1413, next = "test/barrens",
	steps = { { goals = { at("accept", 850) } }, { goals = { at("turnin", 850), at("accept", 851, { 850 }) } }, q(70, "Elsewhere"),
		{ goals = { at("turnin", 851), at("accept", 852, { 851 }) } }, q(71, "Elsewhere too"), { goals = { at("turnin", 852) } } } })
-- The end of The Barrens (19-23) for a Druid: the last step for everyone (Regthar), then the class's own trip
-- (Cat Form, done in its class guide as well), here for the character's class (Warrior).
local mine = { classes = { "WARRIOR" } }
Polestar.RegisterGuide({ id = "test/catform", pack = "test", title = "Cat Form", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
	steps = { q(90, "One"), q(91, "Two"), q(92, "Regthar"),
		{ title = "Moonglade", only = mine, goals = { { t = "accept", quest = 93, title = "To Thunder Bluff", map = 1413, x = 60, y = 60 } } },
		{ title = "Turak Runetotem", only = mine, goals = { { t = "turnin", quest = 93, title = "To Thunder Bluff", map = 1413, x = 61, y = 61 } } } } })
-- Stranglethorn's end for a Dwarf: the last step for everyone, then a trip home only that race takes.
Polestar.RegisterGuide({ id = "test/home", pack = "test", title = "Home", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
	steps = { q(94, "One"), q(95, "Two"), q(96, "Last for everyone"),
		{ title = "Home", goals = { { t = "goto", map = 1413, x = 70, y = 70, text = "Home", only = { races = { "Orc" } } } } } } })
"#;

const NEXT: &str = r#"next = "test/barrens","#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
function flush() stub.advance(0.25) end
LOG = {}
Polestar.On("GUIDE_END", function(id, i)
	LOG[#LOG + 1] = "GUIDE_END " .. id .. " undone=" .. i.undone .. " live=" .. tostring(i.live) .. " next=" .. tostring(i.next) .. " choose=" .. tostring(i.choose)
end)
for _, m in ipairs({ "GUIDE_COMPLETED", "GUIDE_CHANGED", "ROUTE_CHOICE", "GUIDE_CONTINUED" }) do
	Polestar.On(m, function(a, b) LOG[#LOG + 1] = m .. " " .. tostring(a) .. (b and (" " .. tostring(b)) or "") end)
end
function takeLog() local l = LOG; LOG = {}; return l end
-- The player's way through: Your Place skipped, Far Watch Post looked up and taken; two quests left.
function farWatchFirst()
	E.Skip(); flush()
	E.Goto(4); flush()
	w.accept(13, {}); flush()
end
function tabs() local out = {}; for i, t in ipairs(E.GetTabs()) do out[i] = t.guideId end; return out end
"#;

struct Run<'a> {
	next: &'a str,
	saved: Option<&'a str>,
	script: &'a str,
}

fn run(o: Run) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: o.saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: [TEST_PACK, TEST_SOURCE, &GUIDES.replace("@NEXT@", o.next), HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE")"#, r#"E.SetGuide("test/durotar"); flush(); takeLog()"#, o.script]
			.join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_last_step_done_with_steps_left_open_ends_the_guide_once_it_stays_on_the_live_step_and_a_reload_does_not_ask_again() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			farWatchFirst()
			local r = { log = takeLog(), guide = E.GetGuide().id, step = E.GetStepIndex(), ended = E.GuideEnded("test/durotar"),
				saved = PolestarCharDB.guideEnds["test/durotar"], next = E.NextGuide("test/durotar") }
			-- The rest done later: complete, no second ask, no hand-off.
			w.accept(11, {}); flush(); w.accept(12, {}); flush()
			r.later = { log = takeLog(), guide = E.GetGuide().id }
			emit(r)"#,
	});
	assert_eq!(out["log"], json!(["GUIDE_END test/durotar undone=2 live=2 next=test/barrens choose=nil"]));
	assert_eq!(out["guide"], "test/durotar");
	assert_eq!(out["step"], 2, "back on the live step");
	assert_eq!(out["ended"], true);
	assert_eq!(out["saved"], true);
	assert_eq!(out["next"], "test/barrens");
	assert_eq!(out["later"], json!({ "log": ["GUIDE_COMPLETED test/durotar"], "guide": "test/durotar" }));

	// The same character after a reload (its end saved): placed, then the last step again, nothing asks.
	let reload = run(Run {
		next: NEXT,
		saved: Some(r#"PolestarCharDB = { schema = 1, guideEnds = { ["test/durotar"] = true } }"#),
		script: "farWatchFirst(); emit({ log = takeLog(), ended = E.GuideEnded(\"test/durotar\") })",
	});
	assert_eq!(reload, json!({ "log": {}, "ended": true }));
}

// A screenshot report after 0.3.5: 0.3.5 reused guide ids for new content (forever/horde/04-the-barrens was The
// Barrens 19-23, now The Barrens & Stonetalon Mountains 24-26). A character that reached the end of the old guide
// kept its end flag, and the guide window said "You've reached the end of this guide" on every step of the new one
// (GF.EndOffer reads E.GuideEnded). A pack update that changes the guide's steps forgets that end; the same steps
// keep it.
#[test]
fn a_guide_whose_steps_changed_in_an_update_forgets_the_old_guide_s_end_the_same_steps_keep_it() {
	let saved = |shape: &str| format!(r#"PolestarCharDB = {{ schema = 1, shapes = {{ ["test/durotar"] = {shape} }}, guideEnds = {{ ["test/durotar"] = true }} }}"#);
	let script = r#"emit({ ended = E.GuideEnded("test/durotar"), saved = PolestarCharDB.guideEnds["test/durotar"] or false, step = E.GetStepIndex(), shape = PolestarCharDB.shapes["test/durotar"] })"#;
	let changed = run(Run { next: NEXT, saved: Some(&saved(r#""7-12345""#)), script });
	assert_eq!(json!([changed["ended"], changed["saved"], changed["step"]]), json!([false, false, 1]), "the old guide's end is forgotten on an open step");
	let same = run(Run { next: NEXT, saved: Some(&saved(&serde_json::to_string(&changed["shape"]).unwrap())), script });
	assert_eq!(json!([same["ended"], same["saved"]]), json!([true, true]), "the same steps: the end stays");
}

// guides_end_early after #1320 (0.3.6's Loch Modan, Human Warrior; Hillsbrad Foothills, Orcs): the last Lakeshire
// stop's Murloc Poachers needs level 20, which the character has not reached. Played to the end, the guide ends at
// its last step, with no live step left; it never says "end" while waiting on the accept the level holds back.
#[test]
fn an_accept_held_back_by_its_level_never_ends_the_guide_with_a_live_step_the_end_comes_with_the_last_step_1320() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			Polestar.RegisterGuide({ id = "test/lakeshire", pack = "test", title = "Lakeshire", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411,
				steps = { { goals = { { t = "accept", quest = 80, title = "One", map = 1411, x = 50, y = 50 } } },
					{ goals = { { t = "accept", quest = 81, title = "Two", map = 1411, x = 50, y = 50 },
						{ t = "accept", quest = 82, title = "Murloc Poachers", minLevel = 20, map = 1411, x = 50, y = 50 } } },
					{ title = "The Barrens", goals = { { t = "goto", map = 1413, x = 50, y = 50, text = "The Barrens" } } } } })
			E.SetGuide("test/lakeshire"); flush(); takeLog()
			w.accept(80, {}); flush()
			w.accept(81, {}); flush()
			local r = { at = E.GetStepIndex(), held = E.GetStepView(2).goals[2].unavailable or false }
			w.moveTo(1413, 50, 50); stub.advance(1)
			r.log, r.step = takeLog(), E.GetStepIndex() or false
			emit(r)"#,
	});
	assert_eq!(out["at"], 3, "the accept held back by its level: on to the last step");
	assert_eq!(out["held"], "level");
	assert_eq!(out["step"], false, "the last step done: the guide is finished");
	let ends: Vec<&str> = out["log"].as_array().unwrap().iter().filter_map(|l| l.as_str()).filter(|l| l.starts_with("GUIDE_END")).collect();
	assert_eq!(ends, vec!["GUIDE_END test/lakeshire undone=0 live=nil next=nil choose=nil"], "the end with no live step");
}

#[test]
fn playing_it_through_ends_it_complete_and_start_next_loads_the_next_guide_in_the_same_tab() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			for q = 10, 13 do w.accept(q, {}); flush() end
			local r = { log = takeLog(), guide = E.GetGuide().id }
			r.started = E.StartNext("test/durotar")
			r.after = { log = takeLog(), guide = E.GetGuide().id, tabs = tabs(), stored = PolestarCharDB.guide }
			emit(r)"#,
	});
	assert_eq!(out["log"], json!(["GUIDE_COMPLETED test/durotar", "GUIDE_END test/durotar undone=0 live=nil next=test/barrens choose=nil"]));
	assert_eq!(out["guide"], "test/durotar", "nothing loads by itself");
	assert_eq!(out["started"], true);
	assert_eq!(out["after"], json!({ "log": ["GUIDE_CHANGED test/barrens"], "guide": "test/barrens", "tabs": ["test/barrens"], "stored": "test/barrens" }));
}

#[test]
fn going_back_to_the_live_step_keeps_the_guide_and_its_next_guide_can_still_be_started() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			farWatchFirst(); takeLog()
			E.Goto(2); flush()
			local r = { guide = E.GetGuide().id, step = E.GetStepIndex(), log = takeLog() }
			r.started = E.StartNext("test/durotar")
			r.after = { guide = E.GetGuide().id, tabs = tabs() }
			emit(r)"#,
	});
	assert_eq!(out, json!({ "guide": "test/durotar", "step": 2, "log": {}, "started": true, "after": { "guide": "test/barrens", "tabs": ["test/barrens"] } }));
}

#[test]
fn a_route_choice_at_the_end_is_left_to_the_window_and_no_next_guide_ends_the_line() {
	let choice = run(Run {
		next: r#"next = "test/barrens", nextChoices = { "test/barrens", "test/silverpine" },"#,
		saved: None,
		script: r#"farWatchFirst(); emit({ log = takeLog(), start = E.StartNext("test/durotar"), guide = E.GetGuide().id, options = #E.GetRouteChoice("test/durotar").options })"#,
	});
	assert_eq!(choice["log"], json!(["GUIDE_END test/durotar undone=2 live=2 next=nil choose=true"]), "no ROUTE_CHOICE by itself");
	assert_eq!(choice["start"], false, "the player chooses first");
	assert_eq!(choice["guide"], "test/durotar");
	assert_eq!(choice["options"], 2);

	let none = run(Run { next: "", saved: None, script: "farWatchFirst(); emit(takeLog())" });
	assert_eq!(none, json!(["GUIDE_END test/durotar undone=2 live=2 next=nil choose=nil"]));
}

#[test]
fn other_guides_keep_handing_off_by_themselves_and_a_guide_opened_at_its_end_does_not_ask() {
	let cooking = run(Run { next: NEXT, saved: None, script: r#"E.SetGuide("test/cooking"); flush(); takeLog(); w.accept(20, {}); flush(); emit({ log = takeLog(), guide = E.GetGuide().id })"# });
	assert_eq!(cooking, json!({ "log": ["GUIDE_COMPLETED test/cooking", "GUIDE_CHANGED test/cooking2"], "guide": "test/cooking2" }));

	// Durotar opened with its last quest already taken: placed at its end, no ask.
	let opened = run(Run {
		next: NEXT,
		saved: None,
		script: r#"E.SetGuide(nil); flush(); w.accept(13, {}); flush(); takeLog()
			E.SetGuide("test/durotar"); stub.advance(3)
			emit({ log = takeLog(), guide = E.GetGuide().id })"#,
	});
	assert_eq!(opened, json!({ "log": ["GUIDE_CHANGED test/durotar"], "guide": "test/durotar" }));
}

#[test]
fn continue_automatically_hands_off_at_completion_and_says_so() {
	let out = run(Run {
		next: NEXT,
		saved: Some(r#"PolestarDB = { schema = 1, settings = { behavior = { guideEnd = "continue" } } }"#),
		script: r#"for q = 10, 13 do w.accept(q, {}); flush() end
			emit({ log = takeLog(), guide = E.GetGuide().id })"#,
	});
	assert_eq!(
		out,
		json!({
			"log": ["GUIDE_COMPLETED test/durotar", "GUIDE_CHANGED test/barrens", "GUIDE_CONTINUED test/durotar test/barrens"],
			"guide": "test/barrens",
		})
	);
}

#[test]
fn the_old_continue_to_the_next_guide_toggle_is_dropped_and_both_values_start_on_ask() {
	for old in ["false", "true"] {
		let saved = format!("PolestarDB = {{ schema = 1, settings = {{ behavior = {{ autoNextGuide = {old}, autoAccept = false }} }} }}");
		let out = run(Run {
			next: NEXT,
			saved: Some(&saved),
			script: r#"emit({ old = PolestarDB.settings.behavior.autoNextGuide or "gone", now = Polestar.Get("behavior.guideEnd"), kept = Polestar.Get("behavior.autoAccept") })"#,
		});
		assert_eq!(out, json!({ "old": "gone", "now": "ask", "kept": false }), "autoNextGuide = {old}");
	}
}

// Dun Morogh's shape: the last step is the walk on to the next zone, watched for arrival out of turn.
#[test]
fn arriving_at_a_last_step_s_spot_ahead_of_the_live_step_ends_the_guide_and_it_stays_until_start() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			E.SetGuide("test/walk"); stub.advance(1); takeLog()
			-- Somewhere else on the way: nothing.
			w.moveTo(1413, 20, 20); stub.advance(1.5)
			local r = { passing = takeLog() }
			w.moveTo(1413, 50, 50); stub.advance(1.5)
			r.arrived, r.guide, r.step = takeLog(), E.GetGuide().id, E.GetStepIndex()
			r.started = E.StartNext("test/walk")
			r.now = E.GetGuide().id
			emit(r)"#,
	});
	assert_eq!(out["passing"], json!({}));
	assert_eq!(out["arrived"], json!(["GUIDE_END test/walk undone=3 live=1 next=test/barrens choose=nil"]));
	assert_eq!(out["guide"], "test/walk");
	assert_eq!(out["step"], 1);
	assert_eq!(out["started"], true);
	assert_eq!(out["now"], "test/barrens");
}

// Darkshore's shape: the route still has open work on the last step's map, so being at its spot is passing by.
#[test]
fn a_last_spot_on_a_map_with_open_work_before_it_does_not_end_the_guide_until_that_work_is_behind() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			E.SetGuide("test/visit"); stub.advance(1); takeLog()
			w.moveTo(1413, 50, 50); stub.advance(1.5)
			local r = { passing = takeLog() }
			w.accept(41, {}); flush()
			w.moveTo(1413, 49, 50); stub.advance(1.5)
			w.moveTo(1413, 50, 50); stub.advance(1.5)
			r.after = takeLog()
			emit(r)"#,
	});
	assert_eq!(out["passing"], json!({}));
	assert_eq!(out["after"], json!(["GUIDE_END test/visit undone=2 live=1 next=test/barrens choose=nil"]));
}

// Stranglethorn's shape: a trailing step of only optional goals (riding at a level) and a note are offered,
// not the end; a step at any class trainer cannot end it out of turn.
#[test]
fn trailing_optional_or_note_steps_are_not_the_end_and_a_class_trainer_visit_ahead_does_not_end_it() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			E.SetGuide("test/offer"); stub.advance(1); takeLog()
			w.setLevel(5); flush()
			local r = { ding = takeLog() }
			w.accept(52, {}); flush()
			r.lastQuest = takeLog()
			emit(r)"#,
	});
	assert_eq!(out["ding"], json!({}), "the riding step applies at 5 and is all optional");
	assert_eq!(out["lastQuest"], json!(["GUIDE_END test/offer undone=2 live=1 next=test/barrens choose=nil"]));

	let trainer = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			E.SetGuide("test/trainer"); stub.advance(1); takeLog()
			w.trainer(3031); w.close(); flush()
			emit(takeLog())"#,
	});
	assert_eq!(trainer, json!({}));
}

// #998: Regthar Deathgate's window, opened to hand in Kolkar Leaders, does not offer Verog the Dervish yet (it
// opens with the hand-in). That refusal is no mark: the chain after it, up to the guide's last step, stays open
// and the guide does not end.
#[test]
fn a_giver_s_window_before_the_hand_in_that_opens_the_follow_up_does_not_end_the_guide() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			E.SetGuide("test/kolkar"); flush(); takeLog()
			w.accept(850, {}); flush()
			w.gossip(3389, { active = { { questID = 850, isComplete = true } }, available = {} }); flush()
			local r = { window = takeLog(), live = E.GetLiveStep(), follow = E.GetStepView(2).goals[2].status,
				chain = E.GetStepView(4).goals[1].status, last = E.GetStepView(6).goals[1].status, ended = E.GuideEnded("test/kolkar") }
			w.turnIn(850); w.close(); flush()
			w.questDetail(3389, 851); flush(); w.accept(851, {}); w.close(); flush()
			r.after = { log = takeLog(), live = E.GetLiveStep() }
			emit(r)"#,
	});
	assert_eq!(out["window"], json!({}), "no GUIDE_END at Regthar's window");
	assert_eq!(out["ended"], false);
	assert_eq!(out["live"], 2);
	assert_eq!(out["follow"], "active", "Verog the Dervish waits for the hand-in, not passed over");
	assert_eq!(out["chain"], "pending");
	assert_eq!(out["last"], "pending");
	assert_eq!(out["after"], json!({ "log": {}, "live": 3 }));
}

// A last step that only reads done because its quest is unavailable for now is no end. Here Regthar's window
// comes before Barak's head is in the bag: Verog the Dervish is passed over (its prerequisite missing, as
// before), which carries down the chain to the last hand-in. That comes back with the hand-in.
#[test]
fn a_last_step_that_only_reads_done_as_unavailable_for_now_does_not_end_the_guide() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			E.SetGuide("test/kolkar"); flush(); takeLog()
			w.accept(850, { 1 }); flush()
			w.gossip(3389, { active = { { questID = 850 } }, available = {} }); w.close(); flush()
			local r = { refused = takeLog(), follow = E.GetStepView(2).goals[2].status, last = E.GetStepView(6).goals[1].status, ended = E.GuideEnded("test/kolkar") }
			w.finish(850); w.turnIn(850); flush()
			w.accept(851, {}); flush()
			r.after = { log = takeLog(), live = E.GetLiveStep(), last = E.GetStepView(6).goals[1].status }
			emit(r)"#,
	});
	assert_eq!(out["refused"], json!({}), "no GUIDE_END while the chain waits for Kolkar Leaders");
	assert_eq!(out["ended"], false);
	assert_eq!(out["follow"], "skipped", "Verog the Dervish is passed over for now, as before");
	assert_eq!(out["last"], "skipped");
	assert_eq!(out["after"], json!({ "log": {}, "live": 3, "last": "pending" }));
}

// The Skyborne Druid's Barrens (recorded on 0.3.2): Cat Form, the guide's last hand-in for a Druid, done early
// in the class guide ended The Barrens at step 48 of 107. A class's own last steps are never the end done
// ahead: the last step for everyone is. Done ahead, it ends the guide as before; played in order, the class's
// steps after it still come first, and the end comes with them.
#[test]
fn a_class_quest_done_elsewhere_never_ends_a_leveling_guide_the_last_step_for_everyone_does() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			E.SetGuide("test/catform"); flush(); takeLog()
			w.accept(93, {}); flush(); w.turnIn(93); flush()
			local r = { classQuest = takeLog(), live = E.GetLiveStep() }
			w.accept(92, {}); flush()
			r.lastForEveryone = takeLog()
			emit(r)"#,
	});
	assert_eq!(out["classQuest"], json!({}), "Cat Form done in the class guide is no end");
	assert_eq!(out["live"], 1);
	assert_eq!(out["lastForEveryone"], json!(["GUIDE_END test/catform undone=2 live=1 next=test/barrens choose=nil"]));

	let in_order = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			E.SetGuide("test/catform"); flush(); takeLog()
			for q = 90, 92 do w.accept(q, {}); flush() end
			local r = { atTheTrip = takeLog(), live = E.GetLiveStep() }
			w.accept(93, {}); flush(); w.turnIn(93); flush()
			r.done = takeLog()
			emit(r)"#,
	});
	assert_eq!(in_order["atTheTrip"], json!({}), "the class's own steps after the last step for everyone still come");
	assert_eq!(in_order["live"], 4);
	assert_eq!(in_order["done"], json!(["GUIDE_COMPLETED test/catform", "GUIDE_END test/catform undone=0 live=nil next=test/barrens choose=nil"]));
}

// The same for a race's own last step (Stranglethorn's trips home for Dwarves and Gnomes at 40): being there
// ahead of the live step is no end; the last step for everyone done ahead is.
#[test]
fn a_race_s_own_last_step_reached_ahead_is_no_end_either() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			E.SetGuide("test/home"); flush(); takeLog()
			w.moveTo(1413, 60, 60); stub.advance(1.5)
			w.moveTo(1413, 70, 70); stub.advance(1.5)
			local r = { home = takeLog() }
			w.accept(96, {}); flush()
			r.lastForEveryone = takeLog()
			emit(r)"#,
	});
	assert_eq!(out["home"], json!({}));
	assert_eq!(out["lastForEveryone"], json!(["GUIDE_END test/home undone=3 live=1 next=test/barrens choose=nil"]));
}
