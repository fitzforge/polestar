//! Items the guide keeps for later (addon/Polestar/Core/Engine.lua, Engine.KeptItems): from the live step on, a
//! `use` item, a `collect`'s, a `buy`'s, a `craft`'s reagents and the item an `accept` starts from; before it, a quest
//! `collect` whose quest is in the log, kept for the step that hands it in. Goals for another class are not this
//! character's. Real Core manifest, stub world (a level 1 Human Warrior in Elwynn Forest).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[7] = "Kobold Camp Cleanup"
w.titles[8] = "A Letter"
"#;

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/keep", pack = "test", title = "Keep", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Candles", goals = {
			{ t = "collect", item = 772, itemName = "Large Candle", quest = 7, title = "Kobold Camp Cleanup", oi = 1, count = 8, map = 1429, x = 40, y = 80 },
		} },
		{ title = "Hand in", goals = {
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.2, y = 42.1 },
		} },
		{ title = "The letter", goals = {
			{ t = "accept", quest = 8, title = "A Letter", item = 1972, itemName = "Westfall Deed" },
			{ t = "use", item = 6948, itemName = "Hearthstone", only = { classes = { "MAGE" } } },
		} },
		{ title = "Bandages", goals = {
			{ t = "craft", spell = 3275, spellName = "Linen Bandage", count = 2, reagents = { { item = 2589, count = 1 } } },
			{ t = "buy", item = 159, itemName = "Refreshing Spring Water", count = 5, npc = 1, map = 1429, x = 43, y = 65 },
		} },
	},
})
"#;

fn run(script: &str) -> Vec<Value> {
	run_guide(GUIDE, script)
}

fn run_guide(guide: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/keep" }"#.into())],
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
{guide}
E = Polestar.Engine
w = stub.world
function flush() stub.advance(1.1) end
function kept() local out = {{}}; for id, s in pairs(E.KeptItems()) do out[tostring(id)] = s end; return out end
stub.login(); stub.fire("QUEST_LOG_UPDATE"); flush()
{script}"#
		),
		..Default::default()
	})
}

#[test]
fn later_steps_keep_their_items_and_a_quest_s_collected_items_stay_kept_until_the_step_that_hands_it_in() {
	let out = run(r#"
		w.accept(7, { 8 }); flush()
		emit({ step = E.GetLiveStep(), kept = kept() })
		w.progress(7, 1, 8); flush()
		emit({ step = E.GetLiveStep(), kept = kept() })
		w.turnIn(7); flush()
		emit({ step = E.GetLiveStep(), kept = kept() })
	"#);
	let later = json!({ "1972": 3, "2589": 4, "159": 4 });
	assert_eq!(out[0], json!({ "step": 1, "kept": { "772": 1, "1972": 3, "2589": 4, "159": 4 } }), "the Hearthstone `use` is a Mage's");
	assert_eq!(out[1], json!({ "step": 2, "kept": { "772": 2, "1972": 3, "2589": 4, "159": 4 } }), "the candles, for the hand-in");
	assert_eq!(out[2]["kept"], later, "handed in: the candles are free to go");
}

// The quest log's bursts (fifty QUEST_LOG_UPDATE at a time) each run an evaluation, and the bag glow reads the kept
// items after it: a goal that can add no item (a goto, a kill, an accept with no item, a turn-in of a quest not
// collected earlier) is not asked whether it applies, nor is its step.
const ROAD: &str = r#"
local steps = {}
for i = 1, 20 do
	steps[i] = { title = "Road " .. i, goals = {
		{ t = "goto", map = 1429, x = 40 + i, y = 50 },
		{ t = "kill", target = "Kobold Vermin", quest = 7, npc = 6, map = 1429, x = 40, y = 80 },
		{ t = "accept", quest = 100 + i, title = "Errand " .. i, npc = 197, map = 1429, x = 48.2, y = 42.1 },
		{ t = "turnin", quest = 100 + i, title = "Errand " .. i, npc = 197, map = 1429, x = 48.2, y = 42.1 },
	} }
end
steps[21] = { title = "Water", goals = {
	{ t = "buy", item = 159, itemName = "Refreshing Spring Water", count = 5, npc = 1, map = 1429, x = 43, y = 65 },
} }
Polestar.RegisterGuide({ id = "test/keep", pack = "test", title = "Keep", minLevel = 1, maxLevel = 10, steps = steps })
"#;

#[test]
fn the_kept_items_ask_only_the_goals_that_can_add_an_item_whether_they_apply() {
	let script = r#"
		local G, n, counting = Polestar.Guides, 0, false
		local matches = G.Matches
		G.Matches = function(...) if counting then n = n + 1 end return matches(...) end
		E.RequestUpdate(); flush()
		counting = true
		local k = kept()
		counting = false
		G.Matches = matches
		emit({ step = E.GetLiveStep(), kept = k, asked = n })
	"#;
	let out = run_guide(ROAD, script);
	assert_eq!(out[0]["step"], json!(1));
	assert_eq!(out[0]["kept"], json!({ "159": 21 }), "the water a later step buys");
	// The Water step and its buy goal; before, every step and goal from the live one on: 142 reads.
	assert_eq!(out[0]["asked"], json!(2), "only the buy goal and its step are asked");
}
