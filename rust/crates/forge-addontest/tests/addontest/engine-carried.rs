//! Quest work a later guide hands in (the compiled `carriedTo`, addon/Polestar/Core/Engine.lua): the step view
//! carries it once per quest and step, for goals that are this character's, and UI.CarriedLine says to keep it;
//! Engine.CarriedQuests lists the quests of a guide still in the log that a later guide hands in, for the
//! guide-end window and "Continue automatically". Real Core + Theme + UI manifests, stub world (a level 1 Human
//! Warrior in Elwynn Forest).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[7] = "Kobold Camp Cleanup"
w.titles[33] = "Wolves Across the Border"
w.titles[60] = "Kobold Candles"
"#;

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/carry", pack = "test", title = "Carry", minLevel = 1, maxLevel = 10, next = "test/later",
	steps = {
		{ title = "Kobolds", goals = {
			{ t = "kill", target = "Kobold Vermin", npc = 6, quest = 7, title = "Kobold Camp Cleanup", oi = 1, count = 10, map = 1429, x = 40, y = 80, carriedTo = "test/later" },
			{ t = "collect", item = 772, itemName = "Large Candle", quest = 7, title = "Kobold Camp Cleanup", oi = 2, count = 8, map = 1429, x = 41, y = 80, carriedTo = "test/later" },
			{ t = "collect", item = 750, itemName = "Tough Wolf Meat", quest = 33, title = "Wolves Across the Border", oi = 1, count = 8, map = 1429, x = 42, y = 80, carriedTo = "test/later", only = { classes = { "MAGE" } } },
			{ t = "kill", target = "Kobold Vermin", npc = 6, quest = 60, title = "Kobold Candles", oi = 1, count = 5, map = 1429, x = 43, y = 80, carriedTo = "test/gone" },
		} },
		{ title = "Done", goals = { { t = "level", level = 10 } } },
	},
})
Polestar.RegisterGuide({
	id = "test/later", pack = "test", title = "Westfall", minLevel = 10, maxLevel = 12,
	steps = { { title = "Hand in", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48, y = 42 } } } },
})
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/carry" }"#.into())],
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
{GUIDE}
E, UI = Polestar.Engine, Polestar.UI
w = stub.world
function flush() stub.advance(1.1) end
stub.login(); stub.fire("QUEST_LOG_UPDATE"); flush()
{script}"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn quest_work_a_later_guide_hands_in_says_keep_it_once_per_step_and_the_guide_lists_what_is_still_in_the_log() {
	let out = run(r#"
		w.accept(7, { 10, 8 }); w.accept(33, { 8 }); w.accept(60, { 5 }); flush()
		local v = E.GetStepView(1)
		-- Each goal of the view by what it is: "kill 7", "collect 7", "collect 33", "kill 60".
		local to, lines = {}, {}
		for _, g in ipairs(v and v.goals or {}) do
			local k = tostring(g.t) .. " " .. tostring(g.quest)
			to[k] = g.carriedTo or false
			lines[k] = UI.CarriedLine(g) or false
		end
		local function titles(list) local out = {} for i, c in ipairs(list) do out[i] = c.title .. " > " .. c.guideId end return out end
		local before = titles(E.CarriedQuests("test/carry"))
		w.abandon(60); flush()
		emit({ to = to, lines = lines, before = before, after = titles(E.CarriedQuests("test/carry")) })
	"#);
	// The kill's line is left to the quest's last goal in the step; Wolf Meat is a Mage's.
	assert_eq!(out["to"]["kill 7"], false);
	assert_eq!(out["to"]["collect 7"], "test/later");
	assert!(!out["to"]["collect 33"].as_str().is_some(), "{}", out["to"]);
	assert_eq!(out["lines"]["collect 7"], "Keep this: you hand it in later in Westfall");
	assert_eq!(out["lines"]["kill 60"], "Keep this: a later guide hands it in");
	assert_eq!(out["before"], json!(["Kobold Camp Cleanup > test/later", "Kobold Candles > test/gone"]), "Wolves (a Mage's goal) is not this character's");
	assert_eq!(out["after"], json!(["Kobold Camp Cleanup > test/later"]), "abandoned: no longer carried");
}
