//! The step's item in the bags (addon/Polestar/QoL/BagGlow.lua): the bag slot holding the current step's `use`
//! item, or a quest item it collects, glows (the action button border, pulsing, in the theme accent), in the
//! client's bags; the glow moves with the step and goes with qol.bagGlow off.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/glow", pack = "test", title = "Glow", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "Use the carcass", goals = {
			{ t = "use", item = 10338, itemName = "Fresh Zhevra Carcass", quest = 882, oi = 1, map = 1413, x = 60, y = 30.2 },
		} },
		{ title = "The fang", goals = {
			{ t = "collect", item = 5101, itemName = "Ishamuhale's Fang", quest = 882, oi = 1, count = 1, map = 1413, x = 60, y = 30.2 },
		} },
	},
})
"#;

const HELPERS: &str = r#"
local function glowing(bag)
	local out = {}
	for slot = 1, 16 do
		local b = g.bagButton(bag, slot)
		for _, r in ipairs(b.regions or {}) do
			if r.texture == "Interface\\Buttons\\UI-ActionButton-Border" and r:IsShown() then out[#out + 1] = slot end
		end
	end
	return out
end
"#;

const BEFORE: &str = r#"w = stub.world; g = stub.gear
w.class, w.className, w.classID, w.level = "WARRIOR", "Warrior", 1, 19
w.race, w.raceName, w.raceID, w.faction = "Orc", "Orc", 2, "Horde"
w.addMap(1413, { name = "The Barrens", c = 1, left = 2622.9, right = -2697.9, top = 2524.4, bottom = -1206.2 })
w.moveTo(1413, 60, 30)
w.titles[882] = "Ishamuhale"
w.onQuest(882, { { required = 1 } })"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before: BEFORE.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "QoL/QoL.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/glow" }"#.into())],
		login: false,
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
	})
}

fn is_empty(v: &Value) -> bool {
	match v {
		Value::Array(a) => a.is_empty(),
		Value::Object(o) => o.is_empty(),
		_ => false,
	}
}

#[test]
fn the_step_s_use_item_glows_in_the_bags_the_next_step_s_quest_item_takes_over_off_with_qol_bagglow() {
	let out = run(r#"
		g.bag(0, 2, "item:10338"); g.bag(0, 5, "item:5101"); g.bag(0, 7, "item:2589")
		g.openBag(0); stub.advance(0.1)
		emit(glowing(0))
		Polestar.Engine.Goto(2); stub.advance(0.1); g.openBag(0)
		emit(glowing(0))
		Polestar.Set("qol.bagGlow", false); stub.advance(0.1); g.openBag(0)
		emit(glowing(0))
	"#);
	assert_eq!(out[0], json!([2]), "the carcass, not the fang or the cloth");
	assert_eq!(out[1], json!([5]), "the fang the step collects");
	assert!(is_empty(&out[2]), "nothing glows");
}
