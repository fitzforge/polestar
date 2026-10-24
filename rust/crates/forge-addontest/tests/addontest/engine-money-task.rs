//! Money and tasks (addon/Polestar/Core/Engine.lua): a `money` goal is done once the character holds that much
//! and stays done for the rest of its step; a `when money` step applies by the money held when the route
//! reaches it; a `task` goal is done only when the player ticks it, and holds its step until then unless it is
//! optional. Real Core manifest, stub world (a level 1 Human Warrior in Elwynn Forest, with no money).

use forge_addontest::{emitted, is_match, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
"#;

// Step 2 holds GOALS (Lua) and, when given, WHEN; steps 1 and 3 are plain.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/money", pack = "test", title = "Money", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Middle", WHENgoals = GOALS },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- The live step and step 2's goals as status:text.
function state()
	local v = E.GetStepView(2)
	local goals = {}
	for i, g in ipairs(v.goals) do goals[i] = g.status .. ":" .. (g.text or "") end
	return { live = E.GetLiveStep(), status = v.status, goals = goals }
end
"#;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

fn run(goals: &str, when: Option<&str>, before: &str, script: &str) -> Vec<Value> {
	let guide = GUIDE.replace("WHEN", &when.map(|w| format!("when = {w}, ")).unwrap_or_default()).replace("GOALS", goals);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}w.onQuest(783, {{}})\n{before}"),
		addons: vec![core()],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/money" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, &guide, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

#[test]
fn a_money_goal_is_done_once_the_character_holds_that_much_and_stays_done_for_the_rest_of_its_step() {
	let out = run(
		r#"{ { t = "money", money = 150 }, { t = "train", npc = 911, npcName = "Llane Beshere" } }"#,
		None,
		"",
		r#"
			emit(state())
			stub.world.setMoney(150); flush()
			emit(state())
			stub.world.setMoney(20); flush()
			emit(state())
		"#,
	);
	assert_eq!(out[0], json!({ "live": 2, "status": "current", "goals": ["active:Have at least 1s 50c", "active:Train at Llane Beshere"] }));
	assert_eq!(out[1]["goals"][0], "done:Have at least 1s 50c");
	// Spending it before the step ends does not undo the goal (the trainer is still to visit).
	assert_eq!(out[2], json!({ "live": 2, "status": "current", "goals": ["done:Have at least 1s 50c", "active:Train at Llane Beshere"] }));
}

#[test]
fn a_step_with_when_money_applies_by_the_money_held_when_the_route_reaches_it() {
	let train = r#"{ { t = "train", npc = 911, npcName = "Llane Beshere" } }"#;
	let enough = &run(train, Some(r#"{ { k = "money", op = ">=", n = 100 } }"#), "w.setMoney(100)", "emit(state())")[0];
	assert_eq!(enough["live"], 2);
	assert_eq!(enough["status"], "current");
	let out = run(
		train,
		Some(r#"{ { k = "money", op = ">=", n = 100 } }"#),
		"w.setMoney(99)",
		r#"
			emit(state())
			stub.world.setMoney(500); flush()
			emit(state())
		"#,
	);
	let (short, later) = (&out[0], &out[1]);
	assert_eq!(short["live"], 3);
	assert_eq!(short["status"], "skipped");
	// Passed for want of money, it does not come back once the money is there.
	assert_eq!(later["live"], 3);
	let below = &run(train, Some(r#"{ { k = "money", op = "<", n = 100 } }"#), "w.setMoney(99)", "emit(state())")[0];
	assert_eq!(below["live"], 2);
}

#[test]
fn a_task_holds_its_step_until_the_player_ticks_it_an_optional_task_never_holds_it() {
	let out = run(
		r#"{ { t = "task", text = "Tame a Venomtail Scorpid" } }"#,
		None,
		"",
		r#"
			stub.world.setMoney(5000); stub.world.setLevel(5); flush()
			emit(state())
			E.ToggleGoal(2, 1); flush()
			emit(state())
		"#,
	);
	assert_eq!(out[0], json!({ "live": 2, "status": "current", "goals": ["active:Tame a Venomtail Scorpid"] }));
	assert_eq!(out[1]["live"], 3);
	assert_eq!(out[1]["goals"], json!(["done:Tame a Venomtail Scorpid"]));

	let optional = &run(
		r#"{ { t = "task", text = "Buy a green weapon if it is cheaper", optional = true }, { t = "train", npc = 911, npcName = "Llane Beshere" } }"#,
		None,
		"",
		r#"
			stub.world.trainer(911); flush(); stub.world.close(); flush()
			emit(state())
		"#,
	)[0];
	assert_eq!(optional["live"], 3, "the optional task did not hold the step");
}

#[test]
fn a_guide_whose_money_or_task_goal_lacks_its_field_is_refused() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![core()],
		script: r#"
local V = Polestar.Guides.Validate
local function with(goal) return { id = "test/x", title = "X", steps = { { goals = { goal } } } } end
emit({
	ok = V(with({ t = "money", money = 100 })) or V(with({ t = "task", text = "Do it" })) or false,
	money = V(with({ t = "money" })),
	task = V(with({ t = "task" })),
})
"#
		.into(),
		..Default::default()
	});
	assert_eq!(out[0]["ok"], false);
	assert!(is_match(text(&out[0]["money"]), "money"));
	assert!(is_match(text(&out[0]["task"]), "text"));
}
