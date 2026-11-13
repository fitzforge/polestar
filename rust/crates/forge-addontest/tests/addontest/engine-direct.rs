//! A `turnin ... direct` (addon/Polestar/Core/Engine.lua): its giver offers the quest and takes it back in one
//! talk, so the step says "Hand in" with a line that the quest never goes in the log, where a plain turn-in says
//! "Turn in". On the shipped Horde Stranglethorn Vale guide (40-50/01, compiled
//! from guides/ with data/forever; skipped with a note without it): Witch Doctor Unbagwa offers Stranglethorn
//! Fever (349) only to one carrying Fin Fizracket's (348, taken at Booty Bay).

use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const GUIDE: &str = "forever/horde/40-50/01-stranglethorn-vale.guide";

const SCRIPT: &str = r#"
${loads}
stub.login()
stub.fire("QUEST_LOG_UPDATE")
local E, w = Polestar.Engine, stub.world
w.setZone("Stranglethorn Vale", "Grom'gol Base Camp")
E.SetGuide("forever/horde/40-50/01-stranglethorn-vale")
stub.advance(3)
local g = E.GetGuide()
local function stepOf(title)
	for i, st in ipairs(g.steps) do if st.title == title then return i end end
end
-- Booty Bay, where Fin Fizracket gives 348 (the guide has several steps of that name).
local function stepWith(t, q)
	for i, st in ipairs(g.steps) do
		for _, goal in ipairs(st.goals) do if goal.t == t and goal.quest == q then return i end end
	end
end
local unbagwa, booty = stepOf("Witch Doctor Unbagwa"), stepWith("accept", 348)
-- Every step before Unbagwa skipped (Booty Bay's accept of 348 with them).
E.SkipUpTo(unbagwa)
stub.advance(2)
local function goals(s)
	local out = {}
	for _, gv in ipairs(E.GetStepView(s).goals) do
		out[#out + 1] = { t = gv.t, quest = gv.quest or false, status = gv.status, verb = gv.verb or false, text = gv.text or false,
			direct = gv.directText or false, sub = Polestar.UI.GoalSubline(gv) or false }
	end
	return out
end
local r = { compiled = {}, live = E.GetLiveStep() == unbagwa, unbagwa = goals(unbagwa) }
for _, goal in ipairs(g.steps[unbagwa].goals) do
	if goal.direct then r.compiled = { parent = goal.parent or false, pre = goal.pre or false } end
end
for _, gv in ipairs(goals(booty)) do
	if gv.t == "turnin" and gv.quest == 587 then r.plain = gv end
end
emit(r)
"#;

fn run(log: &str) -> Option<Value> {
	let data_dir = root().join("data/forever");
	if !data_dir.exists() {
		eprintln!("skipped: no reference data at data/forever");
		return None;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let text = std::fs::read_to_string(root().join("guides").join(GUIDE)).unwrap();
	let file = format!("guides/{GUIDE}");
	let compiled = compile_with(&[(file.as_str(), text.as_str())], &data, None);
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	let mut maps = String::new();
	for (id, f) in data.map_frames.get("forever").as_obj().map(|o| o.entries()).unwrap_or_default() {
		let id = id.to_string();
		let name = data.zones.get(&id).get("name").to_js_string();
		maps.push_str(&format!(
			"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})\n",
			serde_json::to_string(if name == "undefined" { "" } else { &name }).unwrap(),
			f.get("c").to_js_string(),
			f.get("left").to_js_string(),
			f.get("right").to_js_string(),
			f.get("top").to_js_string(),
			f.get("bottom").to_js_string()
		));
	}
	let before = format!(
		"local w = stub.world\n{maps}w.race, w.raceName = \"Orc\", \"Orc\"\nw.class, w.className = \"WARRIOR\", \"WARRIOR\"\nw.faction = \"Horde\"\nw.level = 41\nw.moveTo(1434, 32.5, 29.0)\n{log}\n"
	);
	Some(emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script: SCRIPT.replace("${loads}", &loads), ..Default::default() }).remove(0))
}

/// The goal of `quest` with verb `t` among the step's goals.
fn goal<'a>(out: &'a Value, t: &str, quest: u64) -> &'a Value {
	out["unbagwa"].as_array().unwrap().iter().find(|g| g["t"] == t && g["quest"] == quest).unwrap_or_else(|| panic!("no {t} {quest}: {out}"))
}

#[test]
fn with_fin_fizrackets_quest_in_the_log_unbagwa_hands_it_in_in_one_talk() {
	let Some(out) = run(r#"w.onQuest(348, { 1 }, "Stranglethorn Fever")"#) else { return };
	assert_eq!(out["live"], true, "{out}");
	let direct = goal(&out, "turnin", 349);
	assert_ne!(direct["status"], "na", "{out}");
	assert_eq!(direct["verb"], "Hand in", "{out}");
	assert_eq!(direct["text"], "Hand in “Stranglethorn Fever”", "{out}");
	assert_eq!(direct["direct"], "Witch Doctor Unbagwa offers it and takes it back in one talk: it never goes in your quest log", "{out}");
	assert!(direct["sub"].as_str().unwrap_or("").contains("offers it and takes it back in one talk"), "on the goal's sub-line: {out}");
	assert_ne!(goal(&out, "collect", 348)["status"], "na", "{out}");
	// A plain turn-in keeps "Turn in" and no such line.
	assert_eq!(out["plain"]["verb"], "Turn in", "{out}");
	assert_eq!(out["plain"]["direct"], false, "{out}");
	assert!(!out["plain"]["sub"].as_str().unwrap_or("").contains("one talk"), "{out}");
}
