//! behavior.rareDrops (addon/Polestar/Core/Engine.lua, Own.itemStart, Own.chased, Own.rareHidden): a quest an
//! item starts is optional in the guides. "optional" leaves it as written, "chase" leads the arrow to the
//! item's spots with the rest of the step, "hide" leaves the start, its item and the quest's hand-in out until
//! the item is in the bags. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[337] = "An Old History Book"
"#;

// Step 1: a required kill, then the item start (the collect of the book, then its accept) and the hand-in.
// Step 2: an accept from an NPC marked optional, which the setting leaves alone.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/drops", pack = "test", title = "Drops", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "Woods", goals = {
			{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, map = 1429, x = 47.6, y = 35.1 },
			{ t = "collect", item = 2794, itemName = "An Old History Book", count = 1, optional = true, map = 1429, x = 48.5, y = 40.5 },
			{ t = "accept", quest = 337, title = "An Old History Book", item = 2794, itemName = "An Old History Book", optional = true },
			{ t = "turnin", quest = 337, title = "An Old History Book", npc = 1440, npcName = "Milton Sheaf", map = 1429, x = 76.9, y = 30.4, optional = true },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6, optional = true },
		} },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- The statuses of step 1's goals and of step 2's accept, and the goal the arrow leads to.
function view()
	local v1, v2 = E.GetStepView(1), E.GetStepView(2)
	local out = {}
	for i, g in ipairs(v1.goals) do out[i] = g.status end
	out[#out + 1] = v2.goals[1].status
	return { out, v1.current or false }
end
"#;

fn run(setting: Option<&str>, before: &str, script: &str) -> Value {
	let set = setting.map(|s| format!(r#"Polestar.Set("behavior.rareDrops", "{s}"); flush()"#)).unwrap_or_default();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: [("Polestar".to_string(), r#"PolestarCharDB = { schema = 1, guide = "test/drops" }"#.to_string())].into_iter().collect(),
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, "flush()", &set, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_default_leaves_the_start_optional_and_the_arrow_on_the_required_goal() {
	let out = run(None, "", "emit(view())");
	assert_eq!(out, json!([["active", "active", "active", "na", "pending"], 1]));
}

#[test]
fn chase_leads_the_arrow_to_the_item_while_the_step_never_waits_for_it() {
	// The book's spot is nearer than the kobolds: the arrow goes there first.
	let out = run(Some("chase"), "", "emit(view())");
	assert_eq!(out, json!([["active", "active", "active", "na", "pending"], 2]));
}

#[test]
fn hide_leaves_out_the_start_its_item_and_the_hand_in_but_not_other_optional_goals() {
	let out = run(Some("hide"), "", "emit(view())");
	assert_eq!(out, json!([["active", "na", "na", "na", "pending"], 1]));
}

#[test]
fn hide_brings_the_start_back_when_the_item_drops() {
	let out = run(Some("hide"), "", "stub.world.addItem(2794, 1); stub.fire(\"BAG_UPDATE\"); flush(); emit(view())");
	assert_eq!(out[0][1], json!("done"), "the book is in the bags");
	assert_ne!(out[0][2], json!("na"), "its accept is offered");
}

#[test]
fn hide_keeps_a_quest_taken_from_the_item() {
	let out = run(Some("hide"), "stub.world.onQuest(337, {})", "emit(view())");
	assert_ne!(out[0][2], json!("na"), "the quest in the log keeps its accept");
	assert_ne!(out[0][3], json!("na"), "and its hand-in");
}
