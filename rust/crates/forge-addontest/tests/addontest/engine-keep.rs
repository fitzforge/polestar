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
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/keep" }"#.into())],
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
{GUIDE}
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
