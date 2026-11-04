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
		script: [TEST_PACK, TEST_SOURCE, &GUIDES.replace("@NEXT@", o.next), HELPERS, "stub.login()", r#"E.SetGuide("test/durotar"); flush(); takeLog()"#, o.script].join("\n"),
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
	let cooking = run(Run {
		next: NEXT,
		saved: None,
		script: r#"E.SetGuide("test/cooking"); flush(); takeLog(); w.accept(20, {}); flush(); emit({ log = takeLog(), guide = E.GetGuide().id })"#,
	});
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
