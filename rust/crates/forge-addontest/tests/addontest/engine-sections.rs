//! Profession guides start where the player is (Thomas, Discord 2026-11-09; 0.3.7): a guide's `section <Profession>
//! <from>-<to>` skill ranges (docs/GUIDE_FORMAT.md, "Sections"). The steps of a range the player's skill has passed
//! are done, a rank the player lacks still holds its step, a range's materials shrink by what its crafts already
//! used, all recomputed on skill-ups and trainer ranks; the guide window's heading reads the range ("First Aid
//! 1-40"), the current one in the accent colour. Then every shipped profession guide at skill 0, mid-way and
//! near the cap.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const REGISTER: &str = r#"Polestar.RegisterGuide({
	id = "test/first-aid", pack = "test", title = "First Aid 1-75", category = "Professions", minLevel = 5, maxLevel = 60,
	sections = {
		{ skill = "First Aid", skillLine = 129, from = 1, to = 40 },
		{ skill = "First Aid", skillLine = 129, from = 40, to = 50 },
		{ skill = "First Aid", skillLine = 129, from = 50, to = 75 },
	},
	steps = {
		{ title = "Learn First Aid", section = 1, goals = { { t = "train", skill = "First Aid", skillLine = 129, rank = 1, rankMax = 75 } } },
		{ title = "Linen Bandage: cloth", section = 1, goals = { { t = "collect", item = 2589, itemName = "Linen Cloth", count = 41 } } },
		{ title = "Linen Bandage (1-40)", section = 1, goals = { { t = "craft", spell = 3275, spellName = "Linen Bandage", item = 1251, itemName = "Linen Bandage",
			skillLine = 129, untilSkill = 40, yellow = 30, grey = 60, reagents = { { item = 2589, itemName = "Linen Cloth", count = 1 } } } } },
		{ title = "Heavy Linen Bandage: cloth", section = 2, goals = { { t = "collect", item = 2589, itemName = "Linen Cloth", count = 20 } } },
		{ title = "Heavy Linen Bandage (40-50)", section = 2, goals = { { t = "craft", spell = 3276, spellName = "Heavy Linen Bandage", item = 2581,
			itemName = "Heavy Linen Bandage", skillLine = 129, untilSkill = 50, yellow = 50, grey = 100, reagents = { { item = 2589, itemName = "Linen Cloth", count = 2 } } } } },
		{ title = "Journeyman First Aid", section = 3, goals = { { t = "train", skill = "First Aid", skillLine = 129, rank = 2, rankMax = 150 } } },
		{ title = "Heavy Linen Bandage: more cloth", section = 3, goals = { { t = "collect", item = 2589, itemName = "Linen Cloth", count = 76 } } },
		{ title = "Heavy Linen Bandage (50-75)", section = 3, goals = { { t = "craft", spell = 3276, spellName = "Heavy Linen Bandage", item = 2581,
			itemName = "Heavy Linen Bandage", skillLine = 129, untilSkill = 75, yellow = 50, grey = 100, reagents = { { item = 2589, itemName = "Linen Cloth", count = 2 } } } } },
	},
})
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!(
			r#"
{TEST_PACK}
{TEST_SOURCE}
{REGISTER}
stub.login()
E = Polestar.Engine
E.SetGuide("test/first-aid")
function flush() stub.advance(0.25) end
function snap()
	local at = E.GetStepIndex()
	local v = at and E.GetStepView(at)
	local g = v and v.goals[1]
	local s = v and v.section
	return {{ at = at or false, text = g and g.text or false, max = g and g.progress and g.progress.max or false,
		section = s and s.title or false, state = s and s.state or false }}
end
local w = stub.world
local r = {{}}
{script}
emit(r)
"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_profession_guide_starts_at_the_player_s_skill_asks_only_for_what_is_still_needed_and_keeps_a_missing_rank() {
	let out = run(r#"
		r.new = snap()
		-- Learned elsewhere, 20 points in: the cloth still needed to 40 (41 for 1-40, less the 19 crafts made).
		w.learnSkill(129, "First Aid", 20, 75); flush(); r.at20 = snap()
		w.addItem(2589, 22); flush(); r.cloth = snap()
		-- 45: 1-40 is passed; 40-50 needs 10 more cloth for 5 crafts, and the 22 in the bags cover it.
		w.skillUp(129, 45); flush(); r.at45 = snap()
		r.passed = { E.GetStepView(2).status, E.GetStepView(3).status }
		-- 75 of 75: 50-75 is passed, but Journeyman (cap 150) is not trained: its step holds the route.
		w.skillUp(129, 75); flush(); r.capped = snap()
		-- Trained: the guide is done.
		w.skillUp(129, 75, 150); flush(); r.trained = snap()
		r.heading = { E.GetSection(1).title, E.GetSection(1).state, E.GetSection(8).state }
	"#);
	assert_eq!(out["new"], json!({ "at": 1, "text": "Learn First Aid", "max": false, "section": "First Aid 1-40", "state": "current" }));
	// The count is the progress's max (a tracked collect names no count in its text).
	assert_eq!(out["at20"], json!({ "at": 2, "text": "Collect Linen Cloth", "max": 22, "section": "First Aid 1-40", "state": "current" }));
	assert_eq!(out["cloth"]["at"], 3);
	assert_eq!(out["at45"], json!({ "at": 5, "text": "Craft Heavy Linen Bandage", "max": 50, "section": "First Aid 40-50", "state": "current" }));
	assert_eq!(out["passed"], json!(["done", "done"]));
	assert_eq!(out["capped"], json!({ "at": 6, "text": "Learn First Aid", "max": false, "section": "First Aid 50-75", "state": "done" }));
	assert_eq!(out["trained"]["at"], false);
	assert_eq!(out["heading"], json!(["First Aid 1-40", "done", "done"]));
}

#[test]
fn materials_shrink_with_each_skill_up_and_a_later_range_reads_ahead() {
	let out = run(r#"
		w.learnSkill(129, "First Aid", 50, 150); flush(); r.at50 = snap()
		r.ahead = E.GetSection(2).state
		w.skillUp(129, 60); flush(); r.at60 = snap()
		w.skillUp(129, 70); flush(); r.at70 = snap()
	"#);
	// 50-75 with Heavy Linen Bandage (yellow 50, grey 100): 2 cloth a craft, 76 for the range.
	assert_eq!(out["at50"]["text"], "Collect Linen Cloth");
	assert_eq!(out["at50"]["max"], 76);
	assert_eq!(out["at50"]["section"], "First Aid 50-75");
	assert_eq!(out["ahead"], "done");
	let at60 = out["at60"]["max"].as_f64().unwrap();
	let at70 = out["at70"]["max"].as_f64().unwrap();
	assert!(at60 < 76.0 && at70 < at60 && at70 > 0.0, "{out}");
}

// Every shipped profession guide, for a Horde Orc at level 60.
const GUIDES: [(&str, u32, &str); 12] = [
	("alchemy", 171, "Alchemy"),
	("blacksmithing", 164, "Blacksmithing"),
	("enchanting", 333, "Enchanting"),
	("engineering", 202, "Engineering"),
	("leatherworking", 165, "Leatherworking"),
	("tailoring", 197, "Tailoring"),
	("cooking", 185, "Cooking"),
	("first-aid", 129, "First Aid"),
	("fishing", 356, "Fishing"),
	("herbalism", 182, "Herbalism"),
	("mining", 186, "Mining"),
	("skinning", 393, "Skinning"),
];

// The live step of the shipped guide `file` at (rank, max) (rank 0: not learned): its index, its section.
fn shipped(file: &str, line: u32, name: &str, rank: u32, max: u32) -> Value {
	let dir = forge_addontest::run::addons_dir();
	let learn = if rank > 0 { format!("w.learnSkill({line}, \"{name}\", {rank}, {max})") } else { String::new() };
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("local w = stub.world\nw.race, w.faction, w.class, w.className, w.level = \"Orc\", \"Horde\", \"WARRIOR\", \"Warrior\", 60\n{learn}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"]), Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")), Addon::dir("Polestar_Guides_Horde", dir.join("Polestar_Guides_Horde"))],
		script: format!(
			r#"
E = Polestar.Engine
for id, b in pairs(Polestar.MapFrames.era) do stub.world.addMap(id, b) end
stub.login(); stub.advance(0.25)
E.SetGuide("forever/professions/{file}"); stub.advance(1)
local at = E.GetStepIndex()
local s = at and E.GetSection(at)
local first
for i = 1, E.GetStepCount() do if E.GetSection(i) then first = E.GetSection(i) break end end
emit({{ at = at or false, from = s and s.from or false, to = s and s.to or false, state = s and s.state or false,
	title = s and s.title or false, first = first and first.title or false, sections = #(E.GetGuide().sections or {{}}) }})"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn every_profession_guide_starts_at_the_range_the_skill_is_in_at_0_mid_way_and_near_the_cap() {
	for (file, line, name) in GUIDES {
		let new = shipped(file, line, name, 0, 0);
		assert!(new["sections"].as_u64().unwrap() >= 4, "{file}: {new}");
		assert_eq!(new["at"], 1, "{file} at 0: {new}");
		assert_eq!(new["title"], new["first"], "{file} at 0: {new}");
		assert_eq!(new["state"], "current", "{file} at 0: {new}");
		// 60 of 75: Journeyman (from 50) not trained yet; its step, where the guide holds, is under the
		// range 60 is in, not the one the skill has passed.
		for (rank, max) in [(60, 75), (140, 150), (290, 300)] {
			let v = shipped(file, line, name, rank, max);
			let (from, to) = (v["from"].as_f64().unwrap_or(-1.0), v["to"].as_f64().unwrap_or(-1.0));
			assert!(from <= rank as f64 && (rank as f64) < to, "{file} at {rank}: the live step is under {v}");
			assert_eq!(v["state"], "current", "{file} at {rank}: {v}");
		}
	}
}
