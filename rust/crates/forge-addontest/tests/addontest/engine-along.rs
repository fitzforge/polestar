//! `along` steps at runtime (addon/Polestar/Core/Engine.lua; docs/GUIDE_FORMAT.md, "Along the way"): the route
//! passes over an along step at once; while the live step is past it, Engine.GetAlong lists its open goals,
//! until they are done or, with `along = "<label>"`, until the live step reaches the step so labelled.
//! Engine.AimAlong leads the arrow to one of them. Core/Guides.lua checks `label` and `along`. Real Core
//! manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"; w.titles[7] = "Kobold Camp Cleanup"
"#;

// 1 accept 7 · 2 along until "back": kill 10 vermin for quest 7 (placed), hold 2 candles (no place) · 3 along:
// hold 1 linen (placed) · 4 accept 783 · 5 "back": turn in 7 · 6 level 6
const ALONG2: &str = r#"along = "back""#;
const ALONG3: &str = "along = true";

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/along", pack = "test", title = "Along", minLevel = 1, maxLevel = 6,
	steps = {
		{ title = "McBride", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Kobolds on the way", ALONG2, goals = {
			{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 },
			{ t = "collect", item = 750, itemName = "Candle", count = 2 },
		} },
		{ title = "Linen", ALONG3, goals = { { t = "collect", item = 2589, itemName = "Linen Cloth", count = 1, map = 1429, x = 40.0, y = 60.0 } } },
		{ title = "Willem", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
		{ title = "Back to McBride", label = "back", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "End", goals = { { t = "level", level = 6 } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- "<step>:<goal>[:<progress>]" for each goal Engine.GetAlong lists.
function along()
	local out = {}
	for _, s in ipairs(E.GetAlong()) do
		for _, g in ipairs(s.goals) do
			out[#out + 1] = s.index .. ":" .. g.index .. (g.progress and (":" .. g.progress.cur) or "")
		end
	end
	return table.concat(out, " ")
end
function wp()
	local w = E.GetWaypoint()
	return w and (w.stepIndex .. ":" .. w.goalIndex) or "none"
end
"#;

fn run_with(script: &str, along2: &str, along3: &str) -> Vec<Value> {
	let guide = GUIDE.replace("ALONG2", along2).replace("ALONG3", along3);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/along" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, &guide, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, ALONG2, ALONG3)
}

#[test]
fn the_route_passes_over_along_steps_their_open_goals_are_listed_until_done_or_until_the_labelled_step() {
	let out = run(r#"
		local w = stub.world
		emit({ E.GetLiveStep(), along() })              -- before them: nothing along
		w.accept(7, { 10 }); flush()
		emit({ E.GetLiveStep(), along() })              -- live step 4; steps 2 and 3 are along
		w.progress(7, 1, 4); flush()
		emit(along())                                   -- progress shows
		w.progress(7, 1, 10); w.addItem(750, 2); flush()
		emit(along())                                   -- step 2's goals done: gone
		w.addItem(2589, 1); flush()
		emit(along())                                   -- step 3's too
	"#);
	assert_eq!(out, vec![json!([1, ""]), json!([4, "2:1:0 2:2:0 3:1:0"]), json!("2:1:4 2:2:0 3:1:0"), json!("3:1:0"), json!("")]);
}

#[test]
fn reaching_the_step_until_names_ends_the_list_with_goals_still_open_a_plain_along_stays() {
	let out = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush()
		w.accept(783, {}); flush()
		emit({ E.GetLiveStep(), along() })
	"#);
	assert_eq!(out, vec![json!([5, "3:1:0"])]);
}

#[test]
fn an_along_step_that_does_not_apply_when_only_or_that_the_player_skipped_is_not_listed() {
	let out = run_with(
		r#"
		stub.world.accept(7, { 10 }); flush()
		emit({ E.GetLiveStep(), along() })
	"#,
		r#"along = "back", only = { classes = { "MAGE" } }"#,
		r#"along = true, when = { { k = "level", op = ">=", n = 50 } }"#,
	);
	assert_eq!(out, vec![json!([4, ""])]);
	let skipped = run(r#"
		stub.world.accept(7, { 10 }); flush()
		E.Goto(3); E.Skip(); flush()
		emit({ E.GetLiveStep(), along() })
	"#);
	assert_eq!(skipped, vec![json!([4, "2:1:0 2:2:0"])]);
}

#[test]
fn the_step_view_says_which_steps_are_along_and_which_carry_a_label_the_list_carries_the_step_title() {
	let out = run(r#"
		stub.world.accept(7, { 10 }); flush()
		emit({ E.GetStepView(2).along, E.GetStepView(3).along, E.GetStepView(5).label, E.GetStepView(4).along == nil })
		emit(E.GetAlong()[1].title)
	"#);
	assert_eq!(out, vec![json!(["back", true, "back", true]), json!("Kobolds on the way")]);
}

#[test]
fn aimalong_leads_the_arrow_to_a_listed_placed_open_along_goal_and_refuses_anything_else() {
	let out = run(r#"
		local w = stub.world
		emit(E.AimAlong(2, 1))                 -- not behind the live step yet
		w.accept(7, { 10 }); flush()
		emit(wp())                             -- Willem
		emit({ E.AimAlong(2, 2), E.AimAlong(4, 1), E.AimAlong(2, 9) })   -- no place, not along, no goal
		emit(E.AimAlong(2, 1)); flush()
		emit(wp())
		local v = E.GetWaypoint()
		emit({ v.x, v.y, v.kind })
	"#);
	assert_eq!(out, vec![json!(false), json!("4:1"), json!([false, false, false]), json!(true), json!("2:1"), json!([47.6, 35.1, "kill"])]);
}

#[test]
fn the_arrow_s_along_choice_lapses_when_the_goal_is_done_and_holds_while_the_route_moves_on() {
	let done = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush()
		E.AimAlong(2, 1); flush()
		emit(wp())
		w.progress(7, 1, 10); flush()
		emit(wp())
	"#);
	assert_eq!(done, vec![json!("2:1"), json!("4:1")]);
	let moved = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush()
		E.AimAlong(3, 1); flush()
		emit(wp())
		w.accept(783, {}); flush()              -- live step 5; step 3 (no until) is still listed
		emit({ E.GetLiveStep(), wp() })
		emit(E.AimAlong(2, 1))                  -- step 2 ended at its label (step 5)
	"#);
	assert_eq!(moved, vec![json!("3:1"), json!([5, "3:1"]), json!(false)]);
}

#[test]
fn guides_validate_refuses_a_bad_label_or_along() {
	let out = run(r#"
		local function def(steps) return { id = "test/x", pack = "test", title = "X", steps = steps } end
		local G = { { t = "level", level = 2 } }
		emit(Polestar.Guides.Validate(def({ { along = "b", goals = G }, { label = "b", goals = G } })) == nil)
		emit(Polestar.Guides.Validate(def({ { along = true, goals = G } })) == nil)
		emit(Polestar.Guides.Validate(def({ { label = 5, goals = G } })))
		emit(Polestar.Guides.Validate(def({ { label = "a", goals = G }, { label = "a", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { along = "nowhere", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { label = "b", goals = G }, { along = "b", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { along = 3, goals = G } })))
	"#);
	assert_eq!(out, vec![json!(true), json!(true), json!("step 1: bad label"), json!("step 2: duplicate label a"), json!("step 1: bad along"), json!("step 2: bad along"), json!("step 1: bad along")]);
}
