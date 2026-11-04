//! `skipto` jumps and the `done <label>` predicate at runtime (addon/Polestar/Core/Engine.lua, Own.jump and
//! Own.labelDone; docs/GUIDE_FORMAT.md, "Jumps"). When the route reaches a step whose jump holds, that step and
//! every step up to the labelled one are skipped for the character, saved as "jump" in CharState().skipped, so
//! the jump does not undo itself when the predicate turns false later. `done <label>` holds once the labelled
//! step is done and was not skipped. Core/Guides.lua checks both. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"; w.titles[7] = "Kobold Camp Cleanup"
"#;

// 1 accept 7, jump to "end" while holding a candle · 2 kill 10 vermin for 7 · 3 "mid": accept 783 ·
// 4 "end": level 4 · 5 only when "mid" is done: level 5 · 6 level 6
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/jump", pack = "test", title = "Jump", minLevel = 1, maxLevel = 6,
	steps = {
		{ title = "McBride", skipto = { { to = "end", when = { k = "has", item = 750, n = 1 } } },
			goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Kobolds", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
		{ title = "Willem", label = "mid", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
		{ title = "Level 4", label = "end", goals = { { t = "level", level = 4 } } },
		{ title = "If Willem", when = { { k = "done", label = "mid" } }, goals = { { t = "level", level = 5 } } },
		{ title = "End", goals = { { t = "level", level = 6 } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- The saved skips of steps 1-6, "nil" where none.
function jumps()
	local sk = Polestar.CharState().skipped["test/jump"] or {}
	local out = {}
	for s = 1, 6 do out[#out + 1] = tostring(sk[s]) end
	return table.concat(out, " ")
end
"#;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

fn run_with(script: &str, before: &str, log: bool) -> Value {
	json!(emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![core()],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/jump" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, "stub.login()", if log { r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"# } else { "" }, script].join("\n"),
		..Default::default()
	}))
}

fn run(script: &str) -> Value {
	run_with(script, "", true)
}

#[test]
fn no_jump_the_route_runs_in_order_and_done_mid_lets_step_5_apply() {
	let out = run(r#"
		local w = stub.world
		emit(E.GetLiveStep())
		w.accept(7, { 10 }); flush(); emit(E.GetLiveStep())
		w.progress(7, 1, 10); flush(); emit(E.GetLiveStep())
		w.accept(783, {}); flush(); emit(E.GetLiveStep())
		w.setLevel(4); flush(); emit(E.GetLiveStep())
		emit(jumps())
	"#);
	assert_eq!(out, json!([1, 2, 3, 4, 5, "nil nil nil nil nil nil"]));
}

#[test]
fn a_step_the_player_skipped_keeps_its_skip_through_a_jump() {
	let out = run(r#"
		local w = stub.world
		E.Goto(3); E.Skip(); E.Goto(1); flush()
		w.addItem(750, 1); flush()
		emit({ E.GetLiveStep(), jumps() })
	"#);
	assert_eq!(out, json!([[4, "jump jump true nil nil nil"]]));
}

#[test]
fn a_jump_that_holds_when_the_route_arrives_skips_its_step_and_those_up_to_the_label_saved_as_jump_a_jumped_label_is_not_done() {
	let out = run_with(
		r#"
		emit(E.GetLiveStep())
		emit(jumps())
		emit({ E.GetStepView(1).skipped, E.GetStepView(2).skipped, E.GetStepView(4).skipped })
		stub.world.setLevel(4); flush(); emit(E.GetLiveStep())     -- step 5 needs "mid" done: passed over
	"#,
		"stub.world.addItem(750, 1)",
		true,
	);
	assert_eq!(out, json!([4, "jump jump jump nil nil nil", [true, true, false], 6]));
}

#[test]
fn a_jump_fires_only_once_the_route_reaches_its_step_and_stays_when_the_predicate_turns_false() {
	let out = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush(); emit(E.GetLiveStep())
		w.addItem(750, 1); flush(); emit(E.GetLiveStep())    -- past step 1 already: no jump
		emit(jumps())
	"#);
	assert_eq!(out, json!([2, 2, "nil nil nil nil nil nil"]));
	let stays = run(r#"
		local w = stub.world
		emit(E.GetLiveStep())
		w.addItem(750, 1); flush(); emit(E.GetLiveStep())    -- at step 1: it jumps now
		w.items[750] = nil; stub.fire("BAG_UPDATE_DELAYED"); flush()
		emit(E.GetLiveStep())                                 -- still 4: the jump is saved
	"#);
	assert_eq!(stays, json!([1, 4, 4]));
}

#[test]
fn no_jump_before_the_quest_log_can_be_read() {
	let out = run_with(
		r#"
		flush(); emit(E.GetLiveStep())
		stub.fire("QUEST_LOG_UPDATE"); flush(); emit(E.GetLiveStep())
	"#,
		"stub.world.addItem(750, 1)",
		false,
	);
	assert_eq!(out, json!([1, 4]));
}

#[test]
fn unskip_or_goto_on_the_jumped_step_brings_it_back_for_good_it_takes_no_second_jump() {
	let unskip = run_with(
		r#"
		emit(E.GetLiveStep())
		emit(E.Unskip(1)); flush()
		emit({ E.GetLiveStep(), jumps() })
	"#,
		"stub.world.addItem(750, 1)",
		true,
	);
	assert_eq!(unskip, json!([4, true, [1, "nil jump jump nil nil nil"]]));
	let goto = run_with(
		r#"
		E.Goto(1); flush()
		emit({ E.GetStepIndex(), E.GetLiveStep(), jumps() })
	"#,
		"stub.world.addItem(750, 1)",
		true,
	);
	assert_eq!(goto, json!([[1, 1, "nil jump jump nil nil nil"]]));
}

#[test]
fn steps_whose_when_done_ask_about_each_other_or_a_step_about_itself_are_not_done_and_do_not_loop() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![core()],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/loop" }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			r#"
Polestar.RegisterGuide({
	id = "test/loop", pack = "test", title = "Loop", minLevel = 1, maxLevel = 6,
	steps = {
		{ title = "A", label = "a", when = { { k = "done", label = "b" } }, goals = { { t = "level", level = 2 } } },
		{ title = "B", label = "b", when = { { k = "done", label = "a" } }, goals = { { t = "level", level = 3 } } },
		{ title = "C", label = "c", when = { { k = "done", label = "c", neg = true } }, goals = { { t = "level", level = 4 } } },
	},
})
stub.login(); stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
emit(Polestar.Engine.GetLiveStep())"#,
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(json!(out), json!([3]));
}

#[test]
fn guides_validate_checks_skipto_and_done() {
	let out = run(r#"
		local function def(steps, extra)
			local d = { id = "test/x", pack = "test", title = "X", steps = steps }
			for k, v in pairs(extra or {}) do d[k] = v end
			return d
		end
		local G = { { t = "level", level = 2 } }
		local ok = { k = "level", op = ">=", n = 2 }
		emit(Polestar.Guides.Validate(def({ { skipto = { { to = "b", when = ok } }, goals = G }, { label = "b", goals = G } })) == nil)
		emit(Polestar.Guides.Validate(def({ { label = "b", goals = G }, { when = { { k = "done", label = "b" } }, goals = G } })) == nil)
		emit(Polestar.Guides.Validate(def({ { skipto = { { to = "b", when = { k = "bogus" } } }, goals = G }, { label = "b", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { skipto = { { to = "nowhere", when = ok } }, goals = G } })))
		emit(Polestar.Guides.Validate(def({ { label = "b", goals = G }, { skipto = { { to = "b", when = ok } }, goals = G } })))
		emit(Polestar.Guides.Validate(def({ { skipto = "b", goals = G }, { label = "b", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { skipto = { { to = "b" } }, goals = G }, { label = "b", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { skipto = { { to = "b", when = { k = "done", label = "x" } } }, goals = G }, { label = "b", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { when = { { k = "done", label = "x" } }, goals = G } })))
		emit(Polestar.Guides.Validate(def({ { when = { { k = "done" } }, goals = G } })))
		emit(Polestar.Guides.Validate(def({ { label = "b", goals = G } }, { next = "test/y", nextChoices = { "test/y" }, nextWhen = { ["test/y"] = { { k = "done", label = "b" } } } })))
	"#);
	assert_eq!(
		out,
		json!([
			true,
			true,
			"step 1: bad skipto",
			"step 1: bad skipto",
			"step 2: bad skipto",
			"step 1: bad skipto",
			"step 1: bad skipto",
			"step 1: bad skipto",
			"step 1: bad when",
			"step 1: bad when",
			"bad nextWhen"
		])
	);
}
