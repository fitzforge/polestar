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

#[test]
fn inactive_highlights_skip_guide_reads_and_resume_on_the_current_item() {
	let out = run(r#"
		local Q = Polestar.QoL
		g.bag(0, 2, "item:10338"); g.bag(0, 5, "item:5101"); g.openBag(0)
		Polestar.Set("qol.bagGlow", false); stub.advance(0.1)
		local current, reads = Q.CurrentStep, 0
		Q.CurrentStep = function(...) reads = reads + 1; return current(...) end
		local function inactive()
			reads = 0
			Q.BagGlow.Refresh()
			local n = reads
			return { n, #glowing(0) }
		end
		emit(inactive())
		Polestar.SetHidden(true)
		Polestar.Set("qol.bagGlow", true)
		Polestar.Engine.Goto(2); stub.advance(0.1)
		emit(inactive())
		Polestar.SetHidden(false); stub.advance(0.1)
		emit(glowing(0))
	"#);
	assert_eq!(out[0], json!([0, 0]), "disabled");
	assert_eq!(out[1], json!([0, 0]), "enabled but hidden");
	assert_eq!(out[2], json!([5]), "show the new step's item, not the one visible before hiding");
}

// The client sends QUEST_LOG_UPDATE for much that leaves the log as it was (several per kill, some per loot). The
// bag glow and the quest buttons each read the step's view on it (about half a millisecond each, #2537): now only
// when what they read of the log (the step's quests, the While-here line's, how many quests the log holds) changed.
// A count of the step's quest that moves still refreshes them on the next frame; so does an accept.
#[test]
fn a_quest_log_update_that_changes_nothing_the_step_reads_refreshes_no_step_item() {
	let out = run(r#"
		w.onQuest(882, { { required = 3 } }); w.onQuest(999, { { required = 5 } })
		stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
		local n = 0
		local current = Polestar.QoL.CurrentStep
		Polestar.QoL.CurrentStep = function(...) n = n + 1; return current(...) end
		-- Each phase from rest (the Engine's evaluation of the phase before and its STEP_UPDATED behind it), counted
		-- over the frame after it.
		local function after(fn) stub.advance(0.6); n = 0; fn(); stub.advance(0.05); return n end
		emit({
			quiet = after(function() for _ = 1, 3 do stub.fire("QUEST_LOG_UPDATE") end end),
			elsewhere = after(function() w.progress(999, 1, 2) end),
			counted = after(function() w.progress(882, 1, 1) end),
			again = after(function() stub.fire("QUEST_LOG_UPDATE") end),
			accepted = after(function() w.onQuest(1000, { { required = 1 } }); stub.fire("QUEST_LOG_UPDATE") end),
		})
	"#);
	let out = &out[0];
	assert_eq!(out["quiet"], 0, "three updates that change nothing: no refresh");
	assert_eq!(out["elsewhere"], 0, "a quest the step doesn't name: no refresh");
	assert!(out["counted"].as_i64().unwrap() >= 1, "the step's count moved: refreshed next frame ({})", out["counted"]);
	assert_eq!(out["again"], 0, "the same count once more: no refresh");
	assert!(out["accepted"].as_i64().unwrap() >= 1, "a quest more in the log: refreshed ({})", out["accepted"]);
}
