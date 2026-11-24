//! The end of a leveling guide (Engine, Own.noteEnd; behavior.guideEnd): reaching the last step asks once per
//! guide per character (GUIDE_END), Engine.StartNext loads the next guide in the same tab, "continue" hands off
//! by itself with GUIDE_CONTINUED, other guides keep going on. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1411, { name = "Durotar", c = 1, left = -3000, right = -6000, top = 1000, bottom = -2000 })
w.addMap(1413, { name = "The Barrens", c = 1, left = 0, right = -3000, top = 1000, bottom = -2000 })
w.addMap(1458, { name = "Undercity", c = 0, left = 1500, right = 1000, top = 500, bottom = 0 })
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
-- Dun Morogh's shape: the last step is the walk on to the next zone.
local walk = { title = "The Barrens", goals = { { t = "goto", map = 1413, x = 50, y = 50, text = "The Barrens" } } }
Polestar.RegisterGuide({ id = "test/walk", pack = "test", title = "Walk", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
	steps = { q(30, "One"), q(31, "Two"), q(32, "Three"), walk } })
-- Hillsbrad Foothills & Arathi Highlands (30-32)'s shape: an early stop in the Undercity (its flight master, a
-- goto on the city's map) and the flight back there at the end (a fly goal naming the city's area).
Polestar.RegisterGuide({ id = "test/undercity", pack = "test", title = "Undercity", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
	steps = { q(100, "Korran"), { title = "Fly to Tarren Mill", goals = { { t = "goto", map = 1458, x = 63.1, y = 48.3, text = "Undercity flight master" } } },
		q(101, "Tarren Mill"), q(102, "Hammerfall"),
		{ title = "Fly to Undercity", goals = { { t = "goto", map = 1413, x = 73.1, y = 32.7, text = "Hammerfall flight master" },
			{ t = "fly", location = "Undercity", area = 1497 } } } } })
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
Polestar.On("GUIDE_STEPS_LEFT", function(id, i) LOG[#LOG + 1] = "GUIDE_STEPS_LEFT " .. id .. " left=" .. i.left .. " live=" .. tostring(i.live) end)
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

// The last step done with steps before it still open (#3517: "37/39 of Hinterlands"): no end yet, the steps left are
// told and the guide stays on the live step; the end with the next guide comes once they are done, once.
#[test]
fn the_last_step_done_with_steps_left_open_tells_them_and_ends_the_guide_once_they_are_done_a_reload_does_not_ask_again() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			farWatchFirst()
			local r = { log = takeLog(), guide = E.GetGuide().id, step = E.GetStepIndex(), ended = E.GuideEnded("test/durotar"),
				saved = PolestarCharDB.guideEnds["test/durotar"] or false, next = E.NextGuide("test/durotar") }
			w.accept(11, {}); flush(); w.accept(12, {}); flush()
			r.later = { log = takeLog(), guide = E.GetGuide().id, ended = E.GuideEnded("test/durotar") }
			emit(r)"#,
	});
	assert_eq!(out["log"], json!(["GUIDE_STEPS_LEFT test/durotar left=2 live=2"]));
	assert_eq!(out["guide"], "test/durotar");
	assert_eq!(out["step"], 2, "back on the live step");
	assert_eq!(out["ended"], false);
	assert_eq!(out["saved"], false);
	assert_eq!(out["next"], "test/barrens");
	assert_eq!(out["later"], json!({ "log": ["GUIDE_COMPLETED test/durotar", "GUIDE_END test/durotar undone=0 live=nil next=test/barrens choose=nil"], "guide": "test/durotar", "ended": true }));

	// The same character after a reload with the rest skipped (Far Watch Post in the log, the end saved): placed
	// with the end still there, nothing asks and the end stands.
	let reload = run(Run {
		next: NEXT,
		saved: Some(&format!("{}\nstub.world.onQuest(13)", saved_end(None, SKIPPED_REST))),
		script: "flush(); emit({ log = takeLog(), ended = E.GuideEnded(\"test/durotar\") })",
	});
	assert_eq!(reload, json!({ "log": {}, "ended": true }));

	// A player updating from a version that ended the guide with steps left (step 1 skipped, Far Watch Post in the
	// log, the end saved): that end no longer holds and is forgotten, untold; the end comes once the rest is done.
	let updated = run(Run {
		next: NEXT,
		saved: Some(&format!("{}\nstub.world.onQuest(13)", saved_end(None, r#"skipped = { ["test/durotar"] = { [1] = true } },"#))),
		script: r#"flush(); local r = { log = takeLog(), ended = E.GuideEnded("test/durotar"), live = E.GetLiveStep() }
			w.accept(11, {}); flush(); w.accept(12, {}); flush()
			r.rest = takeLog()
			emit(r)"#,
	});
	assert_eq!(updated["log"], json!({}));
	assert_eq!(updated["ended"], false);
	assert_eq!(updated["live"], 2);
	assert_eq!(updated["rest"], json!(["GUIDE_COMPLETED test/durotar", "GUIDE_END test/durotar undone=0 live=nil next=test/barrens choose=nil"]));

	// The same with "Continue automatically": that end is forgotten too, so the guide window's banner does not
	// offer the next guide.
	let continuing = run(Run {
		next: NEXT,
		saved: Some(&format!(
			"{}\nPolestarDB = {{ schema = 1, settings = {{ behavior = {{ guideEnd = \"continue\" }} }} }}\nstub.world.onQuest(13)",
			saved_end(None, r#"skipped = { ["test/durotar"] = { [1] = true } },"#)
		)),
		script: r#"flush(); emit({ log = takeLog(), ended = E.GuideEnded("test/durotar") })"#,
	});
	assert_eq!(continuing, json!({ "log": {}, "ended": false }));
}

/// Durotar's steps before Far Watch Post skipped, as a save has them.
const SKIPPED_REST: &str = r#"skipped = { ["test/durotar"] = { [1] = true, [2] = true, [3] = true } },"#;

/// A character's save with Durotar's end recorded the 0.3.6 way (`guideEndsV = 2`), its stored shape when given,
/// and `more` fields.
fn saved_end(shape: Option<&str>, more: &str) -> String {
	let shape = shape.map(|s| format!(r#"shapes = {{ ["test/durotar"] = {s} }},"#)).unwrap_or_default();
	format!(r#"PolestarCharDB = {{ schema = 1, {shape} {more} guideEndsV = 2, guideEnds = {{ ["test/durotar"] = true }} }}"#)
}

// state(): Durotar's end as the engine and the save have it, the live step, and what was fired since the last look.
const STATE: &str = r#"function state() return { ended = E.GuideEnded("test/durotar"), saved = PolestarCharDB.guideEnds["test/durotar"] or false,
	step = E.GetStepIndex(), live = E.GetLiveStep() or false, shape = PolestarCharDB.shapes["test/durotar"], log = takeLog() } end"#;

fn with_state(script: &str) -> String {
	format!("{STATE}\n{script}")
}

/// Durotar's shape as the addon stores it.
fn durotar_shape() -> String {
	serde_json::to_string(&run(Run { next: NEXT, saved: None, script: &with_state("emit(state())") })["shape"]).unwrap()
}

// A screenshot report after 0.3.5: 0.3.5 reused guide ids for new content (forever/horde/04-the-barrens was The
// Barrens 19-23, now The Barrens & Stonetalon Mountains 24-26). A character that reached the end of the old guide
// kept its end flag, and the guide window said "You've reached the end of this guide" on every step of the new one
// (GF.EndOffer reads E.GuideEnded). A pack update that changes the guide's steps forgets that end; the same steps
// keep it while it holds (Far Watch Post still in the log).
#[test]
fn a_guide_whose_steps_changed_in_an_update_forgets_the_old_guide_s_end_the_same_steps_keep_it() {
	let saved = |shape: &str| format!("{}\nstub.world.onQuest(13)", saved_end(Some(shape), SKIPPED_REST));
	let script = with_state("emit(state())");
	let changed = run(Run { next: NEXT, saved: Some(&saved(r#""7-12345""#)), script: &script });
	assert_eq!(json!([changed["ended"], changed["saved"], changed["step"]]), json!([false, false, 1]), "the old guide's end is forgotten on an open step");
	let same = run(Run { next: NEXT, saved: Some(&saved(&durotar_shape())), script: &script });
	assert_eq!(json!([same["ended"], same["saved"]]), json!([true, true]), "the same steps: the end stays");
}

// The 0.3.5 reports ("You've reached the end of this guide" at step 2 of Hillsbrad, "26-30 finished even with
// resetting", "similar at 20/21"): an end saved before 0.3.6 can be another guide's (0.3.5 reused ids; a guide
// 0.3.5 had already stored the new shape of keeps it through checkShape) or one 0.3.5 told by where the player
// stood. It is dropped once on the first load, even with the same steps and the last step reading done (the 26-30
// guide's last quest in a 0.3.4 character's history), and nothing asks: that step reads done from the start.
#[test]
fn an_end_saved_before_0_3_6_is_dropped_on_the_first_load_even_with_the_same_steps_and_its_last_step_done() {
	let legacy = format!(
		r#"PolestarCharDB = {{ schema = 1, shapes = {{ ["test/durotar"] = {} }}, guideEnds = {{ ["test/durotar"] = true }} }}
stub.world.onQuest(13)"#,
		durotar_shape()
	);
	let out = run(Run { next: NEXT, saved: Some(&legacy), script: &with_state("flush(); local r = state(); r.v = PolestarCharDB.guideEndsV; emit(r)") });
	assert_eq!(json!([out["ended"], out["saved"], out["live"], out["log"], out["v"]]), json!([false, false, 1, {}, 3]));
}

// An end recorded is not the end itself: with the same steps, once it no longer holds (Far Watch Post gone from
// the log) it is forgotten, and reached again it asks again (here with steps left: those are told first).
#[test]
fn an_end_that_no_longer_holds_is_forgotten_and_reached_again_asks_again() {
	let out = run(Run { next: NEXT, saved: Some(&saved_end(Some(&durotar_shape()), "")), script: &with_state("flush(); local r = { gone = state() }; farWatchFirst(); r.again = state(); emit(r)") });
	assert_eq!(json!([out["gone"]["ended"], out["gone"]["saved"], out["gone"]["live"]]), json!([false, false, 1]), "the end does not hold: forgotten");
	assert_eq!(out["again"]["log"], json!(["GUIDE_STEPS_LEFT test/durotar left=2 live=2"]), "reached again with steps left: told");
	assert_eq!(out["again"]["ended"], false);
}

// "Even with resetting": Reset guide progress (Engine.ResetProgress) forgets the end with the check-offs and
// skips. The guide is placed again as if just opened, so with its last step done from the start nothing asks.
// The skips before Far Watch Post stay: they are behind it, taken (the game's own progress), so the guide is not
// back at Your Place (#1764).
#[test]
fn reset_guide_progress_forgets_the_end() {
	let saved = format!("{}\nstub.world.onQuest(13)", saved_end(None, SKIPPED_REST));
	let out = run(Run { next: NEXT, saved: Some(&saved), script: &with_state("flush(); local r = { before = state() }; E.ResetProgress(); stub.advance(3); r.after = state(); emit(r)") });
	assert_eq!(out["before"]["ended"], true);
	assert_eq!(json!([out["after"]["ended"], out["after"]["saved"], out["after"]["live"], out["after"]["log"]]), json!([false, false, false, {}]));
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
			local v = E.GetStepView(2).goals[2]
			local r = { at = E.GetStepIndex(), held = v.status == "na" and not v.unavailableText and "level" or false }
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
		script: r#"for q = 10, 13 do w.accept(q, {}); flush() end; emit({ log = takeLog(), start = E.StartNext("test/durotar"), guide = E.GetGuide().id, options = #E.GetRouteChoice("test/durotar").options })"#,
	});
	assert_eq!(choice["log"], json!(["GUIDE_COMPLETED test/durotar", "GUIDE_END test/durotar undone=0 live=nil next=nil choose=true"]), "no ROUTE_CHOICE by itself");
	assert_eq!(choice["start"], false, "the player chooses first");
	assert_eq!(choice["guide"], "test/durotar");
	assert_eq!(choice["options"], 2);

	let none = run(Run { next: "", saved: None, script: "for q = 10, 13 do w.accept(q, {}); flush() end; emit(takeLog())" });
	assert_eq!(none, json!(["GUIDE_COMPLETED test/durotar", "GUIDE_END test/durotar undone=0 live=nil next=nil choose=nil"]));
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

// Dun Morogh's shape: the last step is the walk on to the next zone. Being at its spot ahead of the live step is
// no end (where the player stands is not the guide done); on screen, the walk ends it.
#[test]
fn arriving_at_a_last_step_s_spot_ahead_of_the_live_step_is_no_end_the_walk_on_screen_is() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			E.SetGuide("test/walk"); stub.advance(1); takeLog()
			w.moveTo(1413, 50, 50); stub.advance(1.5)
			local r = { ahead = takeLog(), ended = E.GuideEnded("test/walk"), live = E.GetLiveStep() }
			w.moveTo(1411, 52, 43); stub.advance(1.5)
			for q = 30, 32 do w.accept(q, {}); flush() end
			r.onScreen = E.GetLiveStep()
			w.moveTo(1413, 50, 50); stub.advance(1.5)
			r.done = takeLog()
			emit(r)"#,
	});
	assert_eq!(json!([out["ahead"], out["ended"], out["live"]]), json!([{}, false, 1]));
	assert_eq!(out["onScreen"], 4);
	assert_eq!(out["done"], json!(["GUIDE_COMPLETED test/walk", "GUIDE_END test/walk undone=0 live=nil next=test/barrens choose=nil"]));
}

// The 0.3.5 report "You've reached the end of this guide" at step 2 of Hillsbrad Foothills & Arathi Highlands
// (30-32): its last step flies back to the Undercity (a fly goal naming the city's area), and the player walked
// into the Undercity near the start. The guide's own stop there (a goto on the city's map) did not count as work
// in that place, so the flight read done ahead and the guide ended for good. A flight's landing, like any place,
// is no end ahead of the live step: not at the start, not on a visit to train once the guide's own stop there is
// behind. Flown on screen, it ends the guide.
#[test]
fn being_in_the_last_flight_s_city_ahead_of_the_live_step_never_ends_the_guide_hillsbrad_undercity() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			E.SetGuide("test/undercity"); flush(); takeLog()
			local function city() w.moveTo(1458, 60, 50); w.setZone("Undercity", "Undercity"); stub.advance(1.5) end
			local function away(map, x, y, zone) w.moveTo(map, x, y); w.setZone(zone, ""); stub.advance(1.5) end
			city()
			local r = { start = takeLog(), ended = E.GuideEnded("test/undercity"), live = E.GetLiveStep() }
			away(1411, 52, 43, "Durotar"); w.accept(100, {}); flush()
			w.moveTo(1458, 63.1, 48.3); w.setZone("Undercity", "Undercity"); stub.advance(1.5)
			away(1413, 10, 10, "Hillsbrad Foothills"); w.accept(101, {}); flush()
			city()
			r.midGuide, r.live2 = takeLog(), E.GetLiveStep()
			away(1413, 20, 20, "Arathi Highlands"); w.accept(102, {}); flush()
			away(1413, 73.1, 32.7, "Arathi Highlands")
			city()
			r.done = takeLog()
			emit(r)"#,
	});
	assert_eq!(json!([out["start"], out["ended"], out["live"]]), json!([{}, false, 1]), "in the Undercity at the start");
	assert_eq!(json!([out["midGuide"], out["live2"]]), json!([{}, 4]), "back in the Undercity mid-guide");
	assert_eq!(out["done"], json!(["GUIDE_COMPLETED test/undercity", "GUIDE_END test/undercity undone=0 live=nil next=test/barrens choose=nil"]));
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
			w.accept(50, {}); flush(); w.accept(51, {}); flush()
			r.rest = takeLog()
			emit(r)"#,
	});
	assert_eq!(out["ding"], json!({}), "the riding step applies at 5 and is all optional");
	assert_eq!(out["lastQuest"], json!(["GUIDE_STEPS_LEFT test/offer left=2 live=1"]));
	assert_eq!(out["rest"], json!(["GUIDE_COMPLETED test/offer", "GUIDE_END test/offer undone=0 live=nil next=test/barrens choose=nil"]), "the trailing offers are no steps left");

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
// ahead: the last step for everyone is. Done ahead, it tells the steps left; played in order, the class's
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
	assert_eq!(out["lastForEveryone"], json!(["GUIDE_STEPS_LEFT test/catform left=2 live=1"]));

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
// ahead of the live step is no end; the last step for everyone done ahead tells the steps left, the trip home
// among them.
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
	assert_eq!(out["lastForEveryone"], json!(["GUIDE_STEPS_LEFT test/home left=3 live=1"]));
}

// #2715 (Horde Riverglades, 0.4.0.1): the guide starts from Kargath and its last step walks back there, `enter
// Badlands` and `getfp Kargath`. A player who flew in to Kargath at the start (its flight path known before the
// guide) read that step done ahead and got "You've reached the end of this guide" at step 2. A flight path known
// is no proof of the guide's work: on screen, the step ends the guide as before.
#[test]
fn a_last_step_at_the_hub_the_guide_starts_from_with_its_flight_path_known_is_no_end_ahead_2715() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			w.addMap(1418, { name = "Badlands", c = 0, left = 3000, right = 0, top = 1000, bottom = -2000 })
			Polestar.RegisterGuide({ id = "test/kargath", pack = "test", title = "Riverglades", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
				steps = { { title = "Into the valley", goals = { { t = "goto", map = 1411, x = 60, y = 60, text = "The valley" } } },
					q(120, "One"), q(121, "Two"), q(122, "Three"),
					{ title = "Kargath", goals = { { t = "enter", location = "Badlands" },
						{ t = "getfp", location = "Kargath", node = 21, map = 1418, x = 4, y = 44.8, f = "e" } } } } })
			Polestar.CharState().flags.taxi = { [21] = true }
			E.SetGuide("test/kargath"); flush(); takeLog()
			local function kargath() w.moveTo(1418, 4, 44.8); w.setZone("Badlands", "Kargath"); stub.advance(1.5) end
			kargath()
			local r = { landed = takeLog(), ended = E.GuideEnded("test/kargath"), live = E.GetLiveStep() }
			w.moveTo(1411, 60, 60); w.setZone("Durotar", ""); stub.advance(1.5)
			w.accept(120, {}); flush(); w.accept(121, {}); flush(); w.accept(122, {}); flush()
			kargath()
			r.done = takeLog()
			emit(r)"#,
	});
	assert_eq!(json!([out["landed"], out["ended"], out["live"]]), json!([{}, false, 1]), "landing at Kargath at the start is no end");
	assert_eq!(out["done"], json!(["GUIDE_COMPLETED test/kargath", "GUIDE_END test/kargath undone=0 live=nil next=test/barrens choose=nil"]));
}

// The guide's last step hands in a quest taken at its start. With the live step at 3, the player stands at that
// quest's NPC and hands it in: from a "While you're here" line, or gone there on purpose. Either way the last step
// is done before the rest of the guide (#3501, #3517).
const ON_THE_WAY: &str = r#"
	local function at(t, id, x, y) return { goals = { { t = t, quest = id, title = "Errand " .. id, npc = 9000 + id, npcName = "Giver " .. id, map = 1411, x = x, y = y } } } end
	Polestar.RegisterGuide({ id = "test/onway", pack = "test", title = "On the way", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
		steps = { at("accept", 300, 52, 43), at("accept", 301, 52, 43), at("turnin", 301, 70, 70), at("accept", 302, 70, 70), at("turnin", 302, 70, 70),
			{ goals = { { t = "turnin", quest = 300, title = "Errand 300", npc = 9300, npcName = "Giver 300", map = 1411, x = 52, y = 43 } } } } })
	E.SetGuide("test/onway"); flush(); takeLog()
	w.accept(300, { 1 }); flush(); w.accept(301, {}); flush()
	w.finish(300); stub.advance(1.5)
"#;

// The last step done while earlier steps still hold work is no end: GUIDE_STEPS_LEFT says how many are left (the
// window's "Back to step 3"), nothing is recorded, and the end with the next guide comes once the rest is done.
// Whether "While you're here" offered the hand-in makes no difference.
#[test]
fn the_last_hand_in_done_before_the_rest_says_how_many_steps_are_left_and_the_end_comes_with_the_rest() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: &format!(
			r#"{ON_THE_WAY}
			local line = E.GetWhileHere()
			local r = {{ live = E.GetLiveStep(), line = line and (line.step .. " " .. line.hereText) or "none" }}
			w.turnIn(300); flush()
			r.handedIn = {{ log = takeLog(), live = E.GetLiveStep(), ended = E.GuideEnded("test/onway"), saved = PolestarCharDB.guideEnds["test/onway"] or false }}
			w.turnIn(301); flush()
			r.oneDone = takeLog()
			w.accept(302, {{}}); flush(); w.turnIn(302); flush()
			r.rest = takeLog()
			emit(r)"#
		),
	});
	assert_eq!(out["live"], 3);
	assert_eq!(out["line"], "6 Hand in “Errand 300” to Giver 300: saves a trip back", "the hand-in is offered on the way");
	assert_eq!(out["handedIn"], json!({ "log": ["GUIDE_STEPS_LEFT test/onway left=3 live=3"], "live": 3, "ended": false, "saved": false }));
	assert_eq!(out["oneDone"], json!({}), "told once");
	assert_eq!(out["rest"], json!(["GUIDE_COMPLETED test/onway", "GUIDE_END test/onway undone=0 live=nil next=test/barrens choose=nil"]));

	let gone_ahead = run(Run {
		next: NEXT,
		saved: None,
		script: &format!(
			r#"Polestar.Set("behavior.whileHere", false)
			{ON_THE_WAY}
			local r = {{ line = E.GetWhileHere() or "none" }}
			w.turnIn(300); flush()
			r.log = takeLog()
			emit(r)"#
		),
	});
	assert_eq!(gone_ahead, json!({ "line": "none", "log": ["GUIDE_STEPS_LEFT test/onway left=3 live=3"] }));
}

// A player who leaves the steps behind for good skips them: the end comes with the skip.
#[test]
fn skipping_the_steps_left_ends_the_guide_at_once() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: &format!(
			r#"{ON_THE_WAY}
			w.turnIn(300); flush(); takeLog()
			local r = {{}}
			for i = 1, 2 do E.Skip(); flush(); r[i] = {{ log = takeLog(), live = E.GetLiveStep() or false }} end
			emit(r)"#
		),
	});
	assert_eq!(out[0], json!({ "log": {}, "live": 4 }), "one step still left");
	// The accept of Errand 302 skipped, its hand-in goes with it: nothing is left.
	assert_eq!(out[1], json!({ "log": ["GUIDE_COMPLETED test/onway", "GUIDE_END test/onway undone=0 live=nil next=test/barrens choose=nil"], "live": false }));
}

// Brought back with its last step already done and steps left (opened again, a login): nothing is told then, and
// the end still comes with the rest.
#[test]
fn a_guide_opened_again_with_steps_left_says_nothing_and_ends_with_the_rest() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: &format!(
			r#"{ON_THE_WAY}
			w.turnIn(300); flush(); takeLog()
			E.SetGuide(nil); flush(); E.SetGuide("test/onway"); stub.advance(3)
			local r = {{ opened = takeLog(), live = E.GetLiveStep() }}
			w.turnIn(301); flush(); w.accept(302, {{}}); flush(); w.turnIn(302); flush()
			r.rest = takeLog()
			emit(r)"#
		),
	});
	assert_eq!(out["opened"], json!(["GUIDE_CHANGED nil", "GUIDE_CHANGED test/onway"]));
	assert_eq!(out["live"], 3);
	assert_eq!(out["rest"], json!(["GUIDE_COMPLETED test/onway", "GUIDE_END test/onway undone=0 live=nil next=test/barrens choose=nil"]));
}

// Work a later guide of the chain hands in (the compiled `carriedTo`) holds no end: with only that left, the last
// step done ahead ends the guide, the step left counted as undone.
#[test]
fn work_carried_to_a_later_guide_does_not_hold_the_end() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			Polestar.RegisterGuide({ id = "test/carry", pack = "test", title = "Carry", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
				steps = { { goals = { { t = "accept", quest = 330, title = "Carried", map = 1411, x = 50, y = 50 } } },
					{ goals = { { t = "complete", quest = 330, title = "Carried", carriedTo = "test/barrens", map = 1411, x = 60, y = 60 } } },
					{ goals = { { t = "accept", quest = 331, title = "Last", map = 1411, x = 50, y = 50 } } },
					{ goals = { { t = "turnin", quest = 331, title = "Last", map = 1411, x = 50, y = 50 } } } } })
			E.SetGuide("test/carry"); flush(); takeLog()
			w.accept(330, { 1 }); flush()
			local r = { live = E.GetLiveStep() }
			w.accept(331, {}); flush(); w.turnIn(331); flush()
			r.log = takeLog()
			emit(r)"#,
	});
	assert_eq!(out["live"], 2);
	assert_eq!(out["log"], json!(["GUIDE_END test/carry undone=1 live=2 next=test/barrens choose=nil"]));

	// Carried work as the guide's very last step is no last step: the hand-in before it is, and the end comes once
	// the rest is done.
	let carried_last = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			Polestar.RegisterGuide({ id = "test/carrylast", pack = "test", title = "Carry last", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
				steps = { { goals = { { t = "accept", quest = 340, title = "Carried", map = 1411, x = 50, y = 50 } } },
					{ goals = { { t = "accept", quest = 342, title = "Open", map = 1411, x = 55, y = 55 } } },
					{ goals = { { t = "accept", quest = 341, title = "Last", map = 1411, x = 50, y = 50 } } },
					{ goals = { { t = "turnin", quest = 341, title = "Last", map = 1411, x = 50, y = 50 } } },
					{ goals = { { t = "complete", quest = 340, title = "Carried", carriedTo = "test/barrens", map = 1411, x = 60, y = 60 } } } } })
			E.SetGuide("test/carrylast"); flush(); takeLog()
			w.accept(340, { 1 }); flush()
			w.accept(341, {}); flush(); w.turnIn(341); flush()
			local r = { ahead = takeLog() }
			w.accept(342, {}); flush()
			r.rest = takeLog()
			emit(r)"#,
	});
	assert_eq!(carried_last["ahead"], json!(["GUIDE_STEPS_LEFT test/carrylast left=1 live=2"]));
	assert_eq!(carried_last["rest"], json!(["GUIDE_END test/carrylast undone=1 live=5 next=test/barrens choose=nil"]));

	// With the live step at carried work, a class's own step after the last one for everyone is still a step left:
	// no end until it is done.
	let class_after = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			Polestar.RegisterGuide({ id = "test/carryclass", pack = "test", title = "Carry class", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
				steps = { { goals = { { t = "accept", quest = 350, title = "Carried", map = 1411, x = 50, y = 50 } } },
					{ goals = { { t = "complete", quest = 350, title = "Carried", carriedTo = "test/barrens", map = 1411, x = 60, y = 60 } } },
					{ goals = { { t = "accept", quest = 351, title = "Last", map = 1411, x = 50, y = 50 } } },
					{ goals = { { t = "turnin", quest = 351, title = "Last", map = 1411, x = 50, y = 50 } } },
					{ title = "Warriors", only = { classes = { "WARRIOR" } }, goals = { { t = "accept", quest = 352, title = "Class", map = 1411, x = 70, y = 70 } } } } })
			E.SetGuide("test/carryclass"); flush(); takeLog()
			w.accept(350, { 1 }); flush()
			w.accept(351, {}); flush(); w.turnIn(351); flush()
			local r = { ahead = takeLog() }
			w.accept(352, {}); flush()
			r.rest = takeLog()
			emit(r)"#,
	});
	assert_eq!(class_after["ahead"], json!(["GUIDE_STEPS_LEFT test/carryclass left=1 live=2"]));
	assert_eq!(class_after["rest"], json!(["GUIDE_END test/carryclass undone=1 live=2 next=test/barrens choose=nil"]));
}

// The last step for everyone done early, then a class's own step after it: the route goes on to that step past a
// hand-in the player ticked and back to it when they clear the tick. Told once; the end comes with the rest.
#[test]
fn a_class_s_own_trailing_step_tells_the_steps_left_once_and_the_end_comes_with_the_rest() {
	let trailing = r#"{ title = "Warriors", only = { classes = { "WARRIOR" } }, goals = { { t = "accept", quest = 320, title = "Errand 320", map = 1411, x = 80, y = 80 } } } } })"#;
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: &format!(
			r#"{way}
			w.turnIn(300); flush()
			local r = {{ handedIn = takeLog() }}
			w.turnIn(301); flush(); w.accept(302, {{}}); flush(); E.ToggleGoal(5, 1); flush()
			r.trailing = {{ log = takeLog(), live = E.GetLiveStep() }}
			E.ToggleGoal(5, 1); flush()
			r.back = {{ log = takeLog(), live = E.GetLiveStep() }}
			w.turnIn(302); flush(); w.accept(320, {{}}); flush()
			r.rest = takeLog()
			emit(r)"#,
			way = ON_THE_WAY.replace("x = 52, y = 43 } } } } })", &format!("x = 52, y = 43 }} }} }}, {trailing}"))
		),
	});
	assert_eq!(out["handedIn"], json!(["GUIDE_STEPS_LEFT test/onway left=4 live=3"]), "the class's own step among them");
	assert_eq!(out["trailing"], json!({ "log": {}, "live": 7 }));
	assert_eq!(out["back"], json!({ "log": {}, "live": 5 }), "no end when the route goes back");
	assert_eq!(out["rest"], json!(["GUIDE_COMPLETED test/onway", "GUIDE_END test/onway undone=0 live=nil next=test/barrens choose=nil"]));
}

// Dungeons in the route: the live step waits on a level (an accept for level 5, a dungeon run after it). The last
// step done meanwhile tells the steps left, the waiting one among them, at once; nothing more when the level comes.
#[test]
fn the_last_step_done_during_a_level_wait_tells_the_steps_left_at_once() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			Polestar.dungeonRoute = true
			Polestar.Set("behavior.dungeons", "run")
			local function at(t, id, x, y) return { goals = { { t = t, quest = id, title = "Errand " .. id, npc = 9000 + id, npcName = "Giver " .. id, map = 1411, x = x, y = y } } } end
			Polestar.RegisterGuide({ id = "test/wait", pack = "test", title = "Wait", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
				steps = { at("accept", 300, 52, 43), at("accept", 301, 52, 43),
					{ goals = { { t = "accept", quest = 360, title = "Errand 360", npc = 9360, npcName = "Giver 360", minLevel = 5, map = 1411, x = 70, y = 70 } } },
					{ title = "Deadmines", when = { { k = "dungeon", name = "The Deadmines", map = 36 } }, goals = { { t = "accept", quest = 361, title = "Errand 361", map = 1411, x = 75, y = 75 } } },
					at("turnin", 301, 70, 70),
					{ goals = { { t = "turnin", quest = 300, title = "Errand 300", npc = 9300, npcName = "Giver 300", map = 1411, x = 52, y = 43 } } } } })
			E.SetGuide("test/wait"); flush(); takeLog()
			w.accept(300, { 1 }); flush(); w.accept(301, {}); flush()
			w.finish(300); stub.advance(1.5)
			local r = { live = E.GetLiveStep() }
			w.turnIn(300); flush()
			r.handedIn = takeLog()
			stub.advance(90); w.setLevel(5); flush()
			r.level = { log = takeLog(), live = E.GetLiveStep() }
			emit(r)"#,
	});
	assert_eq!(out["live"], 3, "waiting on the level");
	assert_eq!(out["handedIn"], json!(["GUIDE_STEPS_LEFT test/wait left=3 live=3"]));
	assert_eq!(out["level"]["log"], json!({}), "nothing more when the level comes");
}

// A step waiting for the player's answer (a group quest) is a step left, its quest taken already: no end while it
// asks.
#[test]
fn a_group_quest_waiting_for_its_answer_is_a_step_left() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			Polestar.RegisterGuide({ id = "test/askgroup", pack = "test", title = "Ask group", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
				steps = { { goals = { { t = "accept", quest = 300, title = "Errand 300", map = 1411, x = 50, y = 50 } } },
					{ title = "Group quest", when = { { k = "group", q = 400 } }, goals = { { t = "accept", quest = 400, title = "Group 400", map = 1411, x = 55, y = 55 } } },
					{ along = true, goals = { { t = "complete", quest = 400, title = "Group 400", map = 1411, x = 56, y = 56 } } },
					{ goals = { { t = "turnin", quest = 300, title = "Errand 300", map = 1411, x = 50, y = 50 } } } } })
			E.SetGuide("test/askgroup"); flush(); takeLog()
			w.accept(300, {}); flush(); w.accept(400, { 1 }); flush()
			local r = { live = E.GetLiveStep(), asks = E.GroupQuestion() or false }
			w.turnIn(300); flush()
			r.log = takeLog()
			emit(r)"#,
	});
	assert_eq!(out["live"], 2);
	assert_eq!(out["asks"], 400);
	assert_eq!(out["log"], json!(["GUIDE_STEPS_LEFT test/askgroup left=1 live=2"]));
}

// The last step done in turn, the live step on a class's own step after it: a step the player brings back then
// (Unskip) is their own going back, no steps-left window.
#[test]
fn bringing_a_skipped_step_back_after_the_last_step_done_in_turn_tells_nothing() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			Polestar.RegisterGuide({ id = "test/unskip", pack = "test", title = "Unskip", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411, next = "test/barrens",
				steps = { { goals = { { t = "accept", quest = 300, title = "Errand 300", map = 1411, x = 50, y = 50 } } },
					{ goals = { { t = "accept", quest = 301, title = "Errand 301", map = 1411, x = 55, y = 55 } } },
					{ goals = { { t = "turnin", quest = 300, title = "Errand 300", map = 1411, x = 50, y = 50 } } },
					{ title = "Warriors", only = { classes = { "WARRIOR" } }, goals = { { t = "accept", quest = 320, title = "Errand 320", map = 1411, x = 80, y = 80 } } } } })
			E.SetGuide("test/unskip"); flush(); takeLog()
			w.accept(300, {}); flush(); E.Skip(); flush(); w.turnIn(300); flush()
			local r = { inTurn = takeLog(), live = E.GetLiveStep() }
			E.Unskip(2); flush()
			r.back = { log = takeLog(), live = E.GetLiveStep() }
			w.accept(301, {}); flush(); w.accept(320, {}); flush()
			r.rest = takeLog()
			emit(r)"#,
	});
	assert_eq!(out["inTurn"], json!({}));
	assert_eq!(out["live"], 4);
	assert_eq!(out["back"], json!({ "log": {}, "live": 2 }));
	assert_eq!(out["rest"], json!(["GUIDE_COMPLETED test/unskip", "GUIDE_END test/unskip undone=0 live=nil next=test/barrens choose=nil"]));
}

// A guide finished in turn keeps its end when a skipped step is brought back later (Unskip): the end is not told a
// second time once that step is done. Only an end still listed in guideEndsOld (one an older version recorded) is
// forgotten when steps are left.
#[test]
fn an_end_told_in_turn_stands_when_a_skipped_step_is_brought_back() {
	let out = run(Run {
		next: NEXT,
		saved: None,
		script: r#"
			E.Skip(); flush()
			for q = 11, 13 do w.accept(q, {}); flush() end
			local r = { done = takeLog(), ended = E.GuideEnded("test/durotar") }
			E.Unskip(1); flush()
			r.back = { log = takeLog(), ended = E.GuideEnded("test/durotar"), live = E.GetLiveStep() or false }
			w.accept(10, {}); flush()
			r.again = takeLog()
			emit(r)"#,
	});
	assert_eq!(out["ended"], true);
	assert_eq!(out["back"], json!({ "log": {}, "ended": true, "live": 1 }));
	assert_eq!(out["again"], json!({}), "no second end");
}

// The same after a reload before the step brought back is done: an end this version told is no older one, so the
// save keeps it and nothing is told again (CharState().guideEndsOld lists only those Init.lua found from 0.4.2.2
// and before).
#[test]
fn an_end_told_in_turn_stands_over_a_reload_after_a_step_is_brought_back() {
	let saved = r#"PolestarCharDB = { schema = 1, guideEndsV = 3, guideEnds = { ["test/durotar"] = true } }
stub.world.onQuest(11); stub.world.onQuest(12); stub.world.onQuest(13)"#;
	let out = run(Run {
		next: NEXT,
		saved: Some(saved),
		script: r#"flush(); local r = { log = takeLog(), ended = E.GuideEnded("test/durotar"), live = E.GetLiveStep() or false }
			w.accept(10, {}); flush()
			r.done = takeLog()
			emit(r)"#,
	});
	assert_eq!(out["log"], json!({}));
	assert_eq!(out["ended"], true);
	assert_eq!(out["live"], 1);
	assert!(!out["done"].as_array().is_some_and(|l| l.iter().any(|x| x.as_str().is_some_and(|s| s.starts_with("GUIDE_END")))), "no second end: {}", out["done"]);
}
