//! Quests/QuestLogLink.lua: "Show in quest log" opens the game's quest log at a quest (Compat.OpenQuestLog, the
//! client's QuestMapFrame_OpenToQuestDetails), against the fake client (tests/lua/stub_world.lua for the quest log).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

// The client's opener, recorded: the quest it opened the log at.
const OPENER: &str = r#"
opened = {}
function QuestMapFrame_OpenToQuestDetails(q) opened[#opened + 1] = q end
"#;

fn run(script: &str, before: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: before.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Quests/QuestLogLink.lua"])],
		login: true,
		script: format!("local w = stub.world\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_quest_in_the_log_opens_the_quest_log_at_that_quest() {
	let out = run(
		r#"
		w.onQuest(33, { 10 }, "Wolves Across the Border")
		local shown = Polestar.ShowInQuestLog(33)
		emit({ shown = shown, opened = opened, chat = #stub.messages })"#,
		OPENER,
	);
	assert_eq!(out, json!({ "shown": true, "opened": [33], "chat": 0 }));
}

#[test]
fn a_quest_not_in_the_log_is_named_in_chat_and_nothing_opens() {
	let out = run(
		r#"
		w.titles[47] = "Gold Dust Exchange"
		local named = Polestar.ShowInQuestLog(47)
		local unnamed = Polestar.ShowInQuestLog(99999)
		emit({ named = named, unnamed = unnamed, opened = #opened, chat = stub.messages })"#,
		OPENER,
	);
	assert_eq!(out["named"], false);
	assert_eq!(out["unnamed"], false);
	assert_eq!(out["opened"], 0, "nothing opens");
	let chat: Vec<&str> = out["chat"].as_array().unwrap().iter().map(|m| m.as_str().unwrap()).collect();
	assert_eq!(chat.len(), 2, "{chat:?}");
	assert!(chat[0].contains("Gold Dust Exchange") && chat[0].contains("isn't in your quest log."), "{}", chat[0]);
	assert!(chat[1].contains("That quest isn't in your quest log."), "{}", chat[1]);
}

// The client keeps the map (and its quest log) shut to addon code in combat: the request waits for the fight to
// end, the last quest asked for opening once.
#[test]
fn in_combat_the_quest_log_opens_when_combat_ends() {
	let out = run(
		r#"
		w.onQuest(33, { 10 })
		w.onQuest(40, { 1 })
		stub.inCombat = true
		local first = Polestar.ShowInQuestLog(33)
		Polestar.ShowInQuestLog(40)
		local during = #opened
		local chat = stub.messages[1]
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ first = first, during = during, chat = chat, lines = #stub.messages, opened = opened })"#,
		OPENER,
	);
	assert_eq!(out["first"], false);
	assert_eq!(out["during"], 0, "nothing opens in combat");
	assert!(out["chat"].as_str().unwrap().contains("The quest log opens when combat ends."), "{}", out["chat"]);
	assert_eq!(out["lines"], 2, "one chat line per request");
	assert_eq!(out["opened"], json!([40]), "the last quest asked for, once, when combat ends");
}

#[test]
fn the_menu_entry_shows_in_quest_log_through_the_helper() {
	let out = run(
		r#"
		w.onQuest(33, { 10 })
		local item = Polestar.QuestLogMenuItem(33)
		local away = Polestar.QuestLogMenuItem(47)
		local real, asked = Polestar.ShowInQuestLog, {}
		Polestar.ShowInQuestLog = function(q) asked[#asked + 1] = q; return real(q) end
		item.onClick(item)
		QuestMapFrame_OpenToQuestDetails = nil
		emit({ text = item.text, disabled = item.disabled or false, awayDisabled = away.disabled, asked = asked, opened = opened,
			noOpener = Polestar.QuestLogMenuItem(33) == nil })"#,
		OPENER,
	);
	assert_eq!(out, json!({ "text": "Show in quest log", "disabled": false, "awayDisabled": true, "asked": [33], "opened": [33], "noOpener": true }));
}
