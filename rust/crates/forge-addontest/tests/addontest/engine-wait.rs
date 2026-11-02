//! The `wait` goal (addon/Polestar/Core/Engine.lua): its countdown starts once the goals before it in the step
//! are done, its view carries the seconds left as a "wait" bar, and it is done (and latched) when they run out.
//! Real Core manifest, stub world (a level 1 Human Warrior in Elwynn Forest).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::json;

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
"#;

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/wait", pack = "test", title = "Wait", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "The boat", goals = {
			{ t = "task", text = "Stand on the pier" },
			{ t = "wait", seconds = 20, text = "the boat docks" },
		} },
		{ title = "After", goals = { { t = "task", text = "Board" } } },
	},
})
"#;

#[test]
fn a_wait_counts_down_once_the_goals_before_it_are_done_and_then_the_step_moves_on() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/wait" }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDE,
			"E = Polestar.Engine",
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			r#"
			local function wait() local g = E.GetStepView(1).goals[2]; return { g.status, g.progress and g.progress.cur, g.progress and g.progress.kind, g.verb, g.subject } end
			stub.advance(30)
			local before = wait()
			E.ToggleGoal(1, 1); stub.advance(0.3)
			local started = wait()
			stub.advance(12)
			local mid = wait()
			stub.advance(9)
			emit({ before = before, started = started, mid = mid, live = E.GetLiveStep() })
			"#,
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(out[0]["before"], json!(["active", 20, "wait", "Wait", "the boat docks"]), "nothing counts while the goal before it is open");
	assert_eq!(out[0]["started"][1], 20);
	assert_eq!(out[0]["mid"][1], 8);
	assert_eq!(out[0]["live"], 2, "done when the time is up, and the route moves on");
}
