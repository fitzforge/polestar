//! Abandon and destroy (addon/Polestar/Core/Engine.lua): an `abandon` goal is done once its quest is out of
//! the log, a `destroy` goal once its item is out of the bags, and both stay done for the rest of the step.
//! Real Core manifest, stub world (a level 1 Human Warrior in Elwynn Forest).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
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
	id = "test/abandon", pack = "test", title = "Abandon", minLevel = 1, maxLevel = 10,
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

fn guide(goals: &str, when: Option<&str>) -> String {
	GUIDE.replace("WHEN", &when.map(|w| format!("when = {w}, ")).unwrap_or_default()).replace("GOALS", goals)
}

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

struct Run<'a> {
	goals: &'a str,
	before: &'a str,
	script: &'a str,
	on_quest: bool,
	shape: fn(String) -> String,
}

impl Default for Run<'_> {
	fn default() -> Self {
		Run { goals: "", before: "", script: "", on_quest: true, shape: |t| t }
	}
}

fn run(r: Run) -> Vec<Value> {
	let before = format!("{WORLD}{}{}", if r.on_quest { "w.onQuest(783, {})\n" } else { "" }, r.before);
	let guide = (r.shape)(guide(r.goals, None));
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before,
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/abandon" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, &guide, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, r.script].join("\n"),
		..Default::default()
	})
}

#[test]
fn an_abandon_goal_is_done_once_its_quest_is_out_of_the_log_and_the_accept_before_it_stays_done() {
	let out = run(Run {
		goals: r#"{ { t = "abandon", quest = 783, title = "A Threat Within" }, { t = "train", npc = 911, npcName = "Llane Beshere" } }"#,
		script: r#"
			emit(state())
			stub.world.abandon(783); flush()
			emit(state())
		"#,
		..Default::default()
	});
	assert_eq!(out[0], json!({ "live": 2, "status": "current", "goals": ["active:Abandon A Threat Within", "active:Train at Llane Beshere"] }));
	assert_eq!(out[1], json!({ "live": 2, "status": "current", "goals": ["done:Abandon A Threat Within", "active:Train at Llane Beshere"] }));
	// Looking ahead past the abandon before taking the quest does not pass the accept.
	let ahead =
		run(Run { goals: r#"{ { t = "abandon", quest = 783, title = "A Threat Within" } }"#, on_quest: false, script: "E.Next(); E.Next(); flush(); emit(E.GetLiveStep())", ..Default::default() });
	assert_eq!(ahead[0], 1);
}

#[test]
fn an_accept_after_the_abandon_taking_the_quest_again_is_not_done_by_it() {
	// Step 3 takes A Threat Within again instead of handing it in.
	let out = run(Run {
		goals: r#"{ { t = "abandon", quest = 783, title = "A Threat Within" } }"#,
		shape: |t| t.replacen(r#"{ t = "turnin", quest = 783"#, r#"{ t = "accept", quest = 783"#, 1),
		script: "stub.world.abandon(783); flush(); emit({ live = E.GetLiveStep(), s1 = E.GetStepView(1).status, s3 = E.GetStepView(3).goals[1].status })",
		..Default::default()
	});
	assert_eq!(out[0], json!({ "live": 3, "s1": "done", "s3": "active" }));
}

#[test]
fn a_destroy_goal_is_done_once_the_item_is_out_of_the_bags_and_stays_done_for_its_step() {
	let out = run(Run {
		goals: r#"{ { t = "destroy", item = 6948, itemName = "Hearthstone" }, { t = "train", npc = 911, npcName = "Llane Beshere" } }"#,
		before: "w.addItem(6948, 1)",
		script: r#"
			emit(state())
			stub.world.removeItem(6948); flush()
			emit(state())
			stub.world.addItem(6948, 1); flush()
			emit(state())
		"#,
		..Default::default()
	});
	assert_eq!(out[0], json!({ "live": 2, "status": "current", "goals": ["active:Destroy Hearthstone", "active:Train at Llane Beshere"] }));
	assert_eq!(out[1]["goals"][0], "done:Destroy Hearthstone");
	assert_eq!(out[2]["goals"][0], "done:Destroy Hearthstone");
}
