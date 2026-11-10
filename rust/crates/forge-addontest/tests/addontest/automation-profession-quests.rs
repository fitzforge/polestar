//! Issue #1559 (NightTriage036b): a start campfire offers, after its rest quest, a Camping 101 for each profession
//! the character has (Brakk's Skinning one, 97908, for Thuwd in Orgrimmar). Written as an `optional` accept beside
//! the required Cooking one (96655), Automation took Cooking, the step read done, the optional accept was no longer
//! wanted and behavior.closeSkipped closed the window the game showed next. The guides now write it as a step of its
//! own gated `when skill <Prof> 1` with a plain accept (the goal carries the quest's profession, so only holders
//! see it), and each hand-in as a step gated `when onquest <quest>`, at a start-zone trainer or on the next guide's Orgrimmar walk. Automation takes it at the campfire, keeps the
//! window open for it, and hands it in at the trainer; a character without the profession is not held by it.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const BRAKK: i32 = 265809;
const KRUNN: i32 = 3171;
const THUWD: i32 = 7088;

// As the guides write them: the campfire step (Cooking), one step per profession gated `when skill <Prof> 1` with a
// plain accept carrying the quest's profession, the start-zone trainer's hand-in on a carrier-only step
// (tauren/orc/troll/undead starts), the rest of the route, and the next guide's Orgrimmar trainer on a carrier-only
// step (03-silverpine-forest, BrHorde1230's bd9c102cc).
fn guide() -> String {
	let skinning = r#"profLine = 393, profName = "Skinning", profRank = 1"#;
	let mining = r#"profLine = 186, profName = "Mining", profRank = 1"#;
	let steps = [
		r#"{ title = "Brakk's campfire", goals = { { t = "accept", quest = 96655, title = "Camping 101: Cooking" } } }"#.to_string(),
		format!(r#"{{ title = "Camping 101: Skinning", when = {{ {{ k = "skill", name = "Skinning", n = 1, skillLine = 393 }} }}, goals = {{ {{ t = "accept", quest = 97908, title = "Camping 101: Skinning", {skinning} }} }} }}"#),
		format!(r#"{{ title = "Camping 101: Mining", when = {{ {{ k = "skill", name = "Mining", n = 1, skillLine = 186 }} }}, goals = {{ {{ t = "accept", quest = 97907, title = "Camping 101: Mining", {mining} }} }} }}"#),
		format!(r#"{{ title = "Krunn", when = {{ {{ k = "onquest", q = {{ 97907 }} }} }}, goals = {{ {{ t = "complete", quest = 97907, title = "Camping 101", {mining} }}, {{ t = "turnin", quest = 97907, title = "Camping 101: Mining", {mining} }} }} }}"#),
		r#"{ title = "Away", goals = { { t = "accept", quest = 33, title = "Quest 33" } } }"#.to_string(),
		format!(r#"{{ title = "Thuwd", when = {{ {{ k = "onquest", q = {{ 97908 }} }} }}, goals = {{ {{ t = "complete", quest = 97908, title = "Camping 101", {skinning} }}, {{ t = "turnin", quest = 97908, title = "Camping 101: Skinning", {skinning} }} }} }}"#),
		r#"{ title = "Onward", goals = { { t = "accept", quest = 34, title = "Quest 34" } } }"#.to_string(),
	];
	format!(
		"\n{TEST_PACK}\n{TEST_SOURCE}\nPolestar.RegisterGuide({{\n\tid = \"test/camping\", pack = \"test\", title = \"Camping\", minLevel = 1, maxLevel = 20,\n\tsteps = {{ {} }},\n}})",
		steps.join(",\n")
	)
}

const TAIL: &str = r#"
			local c = {}
			for i, x in ipairs(w.calls) do c[i] = table.concat({ tostring(x[1]), tostring(x[2]), tostring(x[3]) }, " ") end
			emit({ calls = c, open = w.frame and (w.frame.kind .. " " .. tostring(w.frame.questID)) or "none" })"#;

fn run(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("w = stub.world; w.addMap(1412, {{ name = \"Mulgore\", c = 1, left = 2000, right = -2000, top = 1000, bottom = -2000 }}); w.moveTo(1412, 46, 67)\n{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{}\nstub.login()\n{script}{TAIL}", guide()),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn t_1559_a_skinner_and_miner_takes_both_camping_101s_at_the_campfire_and_hands_them_in_at_razor_hill_and_orgrimmar() {
	let out = run(
		r#"w.learnSkill(393, "Skinning", 1, 75); w.learnSkill(186, "Mining", 1, 75)"#,
		&format!(
			r#"
			w.gossip({BRAKK}, {{ available = {{ {{ questID = 96655 }}, {{ questID = 97908 }}, {{ questID = 97907 }} }} }})
			-- after each accept the game shows his quests again
			w.gossip({BRAKK}, {{ available = {{ {{ questID = 97908 }}, {{ questID = 97907 }} }} }})
			w.gossip({BRAKK}, {{ available = {{ {{ questID = 97907 }} }} }})
			stub.runTimers()
			w.close(); stub.advance(2); stub.runTimers()
			w.onQuest(97907, {{}}); w.onQuest(97908, {{}})
			w.gossip({KRUNN}, {{ active = {{ {{ questID = 97907, isComplete = true }} }} }})
			stub.runTimers()
			w.close(); stub.advance(2); stub.runTimers()
			w.accept(33, {{}}, "Quest 33"); stub.advance(2); stub.runTimers()
			w.gossip({THUWD}, {{ active = {{ {{ questID = 97908, isComplete = true }} }} }})
			stub.runTimers()"#
		),
	);
	let calls = out["calls"].as_array().unwrap().iter().map(|c| c.as_str().unwrap().to_string()).collect::<Vec<_>>();
	let at = |s: &str| calls.iter().position(|c| c == s).unwrap_or_else(|| panic!("{s} in {calls:?}"));
	let accepts = [at("AcceptQuest 96655 nil"), at("AcceptQuest 97908 nil"), at("AcceptQuest 97907 nil")];
	let closed = calls.iter().position(|c| c.starts_with("CloseQuest") || c.contains("CloseGossip")).unwrap_or(usize::MAX);
	assert!(accepts.iter().all(|&i| i < closed), "Cooking and both profession quests taken before the window closes: {calls:?}");
	assert!(at("C_GossipInfo.SelectActiveQuest 97907 nil") < at("GetQuestReward 97907 0"), "Mining handed in at Krunn in Razor Hill: {calls:?}");
	assert!(at("GetQuestReward 97907 0") < at("C_GossipInfo.SelectActiveQuest 97908 nil") && at("C_GossipInfo.SelectActiveQuest 97908 nil") < at("GetQuestReward 97908 0"), "Skinning handed in at Thuwd in Orgrimmar: {calls:?}");
}

#[test]
fn t_1559_a_character_without_the_profession_is_not_held_by_it() {
	let out = run(
		"",
		&format!(
			r#"
			w.gossip({BRAKK}, {{ available = {{ {{ questID = 96655 }} }} }})
			stub.runTimers()
			w.close()
			stub.advance(2)
			stub.runTimers()
			w.calls[#w.calls + 1] = {{ "live", Polestar.Engine.GetLiveStep() }}"#
		),
	);
	assert_eq!(out["calls"], json!(["C_GossipInfo.SelectAvailableQuest 96655 nil", "AcceptQuest 96655 nil", "live 5 nil"]), "past the profession steps, on Away: {out}");
}
