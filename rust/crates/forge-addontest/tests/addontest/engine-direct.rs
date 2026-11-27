//! A `turnin ... direct` (addon/Polestar/Core/Engine.lua): its giver offers the quest and takes it back in one
//! talk, so the step says "Hand in" with a line that the quest never goes in the log, where a plain turn-in says
//! "Turn in"; and a direct hand-in whose giver waits on a quest the guide accepts earlier (its `parent`, or
//! `pre`/`preAll`, compiled onto the goal as for an accept) lets go when the player skipped that accept, as an
//! ordinary turn-in of a skipped quest does, and waits with that accept when the accept itself is passed for a
//! missing prerequisite (#4124). On the shipped Horde Feralas guide (40-50/02, whose Grom'gol stop
//! holds Unbagwa since 0.4.0; compiled from guides/ with the Stranglethorn Vale and Riverglades guides before it and
//! data/forever; skipped with a note without it): Witch Doctor Unbagwa offers Stranglethorn Fever (349) only to one
//! carrying Fin Fizracket's (348, taken at Booty Bay on 40-50/01); at the Mirage Raceway Zamek offers Zamek's
//! Distraction (1191) only to one carrying Pozzik's Keeping Pace (1190), which needs News for Fizzle (1137) from the
//! Badlands first.

use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const GUIDES: [&str; 3] = ["forever/horde/40-50/01-stranglethorn-vale.guide", "forever/horde/40-50/01b-riverglades.guide", "forever/horde/40-50/02-feralas.guide"];

const SCRIPT: &str = r#"
${loads}
stub.login()
stub.fire("QUEST_LOG_UPDATE")
local E, w = Polestar.Engine, stub.world
w.setZone("Stranglethorn Vale", "Grom'gol Base Camp")
E.SetGuide("forever/horde/40-50/02-feralas")
stub.advance(3)
local g = E.GetGuide()
local function stepOf(title)
	for i, st in ipairs(g.steps) do if st.title == title then return i end end
end
-- A step by one of its goals (Booty Bay: the guide has several steps of that name).
local function stepWith(t, q)
	for i, st in ipairs(g.steps) do
		for _, goal in ipairs(st.goals) do if goal.t == t and goal.quest == q then return i end end
	end
end
local unbagwa = stepOf("Witch Doctor Unbagwa")
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
-- A plain turn-in in the same guide: Up to Snuff (587) to Deeg in Booty Bay.
for _, gv in ipairs(goals(stepWith("turnin", 587))) do
	if gv.t == "turnin" and gv.quest == 587 then r.plain = gv end
end
emit(r)
"#;

fn run(log: &str) -> Option<Value> {
	run_script(SCRIPT, log)
}

fn run_script(script: &str, log: &str) -> Option<Value> {
	let data_dir = root().join("data/forever");
	if !data_dir.exists() {
		eprintln!("skipped: no reference data at data/forever");
		return None;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let files: Vec<(String, String)> = GUIDES.iter().map(|g| (format!("guides/{g}"), std::fs::read_to_string(root().join("guides").join(g)).unwrap())).collect();
	let refs: Vec<(&str, &str)> = files.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let compiled = compile_with(&refs, &data, None);
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
	Some(emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script: script.replace("${loads}", &loads), ..Default::default() }).remove(0))
}

/// The goal of `quest` with verb `t` among the step's goals.
fn goal<'a>(out: &'a Value, t: &str, quest: u64) -> &'a Value {
	out["unbagwa"].as_array().unwrap().iter().find(|g| g["t"] == t && g["quest"] == quest).unwrap_or_else(|| panic!("no {t} {quest}: {out}"))
}

#[test]
fn stranglethorn_fever_without_fin_fizrackets_quest_lets_unbagwas_step_go() {
	let Some(out) = run("") else { return };
	assert_eq!(out["compiled"], json!({ "parent": 348, "pre": false }), "the giver's wait compiled onto the direct goal: {out}");
	assert_eq!(goal(&out, "turnin", 349)["status"], "na", "{out}");
	assert_eq!(goal(&out, "collect", 348)["status"], "na", "{out}");
	assert_eq!(out["live"], false, "the route goes on past Unbagwa: {out}");
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

// The Mirage Raceway stop, every step before it skipped: its goals' states and whether it is still the live step.
const RACEWAY: &str = r#"
${loads}
stub.login()
stub.fire("QUEST_LOG_UPDATE")
local E, w = Polestar.Engine, stub.world
w.setZone("Thousand Needles", "Mirage Raceway")
E.SetGuide("forever/horde/40-50/02-feralas")
stub.advance(3)
local g = E.GetGuide()
local raceway
for i, st in ipairs(g.steps) do
	for _, goal in ipairs(st.goals) do if goal.t == "turnin" and goal.quest == 1191 then raceway = raceway or i end end
end
E.SkipUpTo(raceway)
stub.advance(2)
local r = { live = E.GetLiveStep() == raceway, goals = {} }
for _, gv in ipairs(E.GetStepView(raceway).goals) do
	if gv.quest then r.goals[gv.t .. " " .. gv.quest] = gv.status end
end
emit(r)
"#;

// PierreAnken (#4124): an Orc Hunter, 45, at the raceway with Zamek, without News for Fizzle (1137) or Baron
// Revilgaz's word (1183); his log from the report: 2995 0/3, 2981 done, 379 0/1, 992 0/1.
const PIERRE: &str = r#"
w.class, w.className, w.level = "HUNTER", "Hunter", 45
w.moveTo(1441, 79.77, 76.92)
w.onQuest(2995, { { required = 3, fulfilled = 0 } })
w.onQuest(2981, { { required = 1, fulfilled = 1 } })
w.onQuest(379, { { required = 1, fulfilled = 0 } })
w.onQuest(992, { { required = 1, fulfilled = 0 } })
"#;

#[test]
fn t_4124_without_news_for_fizzle_zameks_distraction_is_passed_with_keeping_pace() {
	let Some(out) = run_script(RACEWAY, PIERRE) else { return };
	assert_eq!(out["goals"]["accept 1190"], "skipped", "Keeping Pace waits on News for Fizzle: {out}");
	assert_eq!(out["goals"]["turnin 1191"], "skipped", "Zamek offers nothing without Keeping Pace: {out}");
	assert_eq!(out["live"], false, "the route goes on past the raceway: {out}");
}

#[test]
fn t_4124_with_keeping_pace_in_the_log_zamek_takes_the_distraction() {
	let Some(out) = run_script(RACEWAY, &format!("{PIERRE}\nw.complete({{ 1137 }})\nw.onQuest(1190, {{ {{ required = 1, fulfilled = 0 }} }})")) else { return };
	assert_eq!(out["goals"]["turnin 1191"], "active", "{out}");
	assert_eq!(out["live"], true, "{out}");
}

#[test]
fn t_4124_with_news_for_fizzle_done_the_distraction_waits_on_keeping_pace_s_accept_not_passed() {
	let Some(out) = run_script(RACEWAY, &format!("{PIERRE}\nw.complete({{ 1137 }})")) else { return };
	assert_eq!(out["goals"]["accept 1190"], "active", "{out}");
	assert_eq!(out["goals"]["turnin 1191"], "active", "{out}");
	assert_eq!(out["live"], true, "{out}");
}
