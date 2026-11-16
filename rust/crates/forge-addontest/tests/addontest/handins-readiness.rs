//! Delivery readiness and unchanged-log event handling for the live hand-in route.

use super::{codex, run, run_with};
use serde_json::json;

#[test]
fn a_new_unknown_recipient_does_not_inherit_an_earlier_manual_steps_checkoff() {
	let out = run(
		"w.onQuest(7106,{})",
		None,
		r#"
H.Start(); settle()
E.ToggleGoal(1,1); settle()
local checked = E.GetTabs()[1].complete == true
w.abandon(7106); w.onQuest(7105,{}); stub.fire('QUEST_LOG_UPDATE'); settle()
emit({checked=checked, live=E.GetLiveStep() or false, complete=E.GetTabs()[1].complete == true, notes=notes(E.GetGuide())})
"#,
	);
	assert_eq!(out["checked"], false, "unknown hand-ins remain active until the quest leaves the log, like known hand-ins");
	assert_eq!(out["live"], 1, "a different unknown hand-in must be visible again");
	assert_eq!(out["complete"], false);
	assert!(out["notes"].as_str().unwrap().contains("Hostile Recipient"));
}

#[test]
fn an_unknown_recipient_repeatable_stays_active_after_a_rapid_new_attempt() {
	let out = run(
		"w.repeatable[7106]=true; w.onQuest(7106,{})",
		None,
		r#"
H.Start(); settle()
E.ToggleGoal(1,1); settle()
-- The same delivery is accepted before the hand-in guide's refresh runs.
w.turnIn(7106); w.accept(7106,{}); settle()
local live, complete = E.GetLiveStep() or false, E.GetTabs()[1].complete == true
H.Start(); settle()
emit({ready=H.Ready(), live=live, complete=complete,
	reopenedLive=E.GetLiveStep() or false, reopenedComplete=E.GetTabs()[1].complete == true})
"#,
	);
	assert_eq!(out["ready"], json!([7106]));
	assert_eq!(out["live"], 1, "a new quest-log attempt must not inherit the manual check-off");
	assert_eq!(out["complete"], false);
	assert_eq!(out["reopenedLive"], 1, "opening the existing guide again still shows the new attempt");
	assert_eq!(out["reopenedComplete"], false);
}

#[test]
fn unflagged_deliveries_need_no_client_or_codex_objectives_and_must_not_be_failed() {
	let mut data = codex();
	data["quests"]["7108"]["objectives"] = json!([{ "type":"kill", "id":5001, "count":1 }]);
	let out = run_with(
		&data,
		"w.onQuest(7101,{}); w.onQuest(7102,{1}); w.onQuest(7108,{}); w.onQuest(7109,{}); w.onQuest(7120,{})\nfunction C_QuestLog.ReadyForTurnIn() return false end\nfunction C_QuestLog.IsComplete() return false end",
		None,
		r#"
local ready = H.Ready()
local id = H.Start(); settle()
emit({ready=ready, quests=ids(Polestar.Guides.Get(id)), wants=E.WantsQuest('turnin',7101)})
"#,
	);
	assert_eq!(out["ready"], json!([7101]), "only the known delivery with no remaining work is eligible");
	assert_eq!(out["quests"], json!([7101]));
	assert_eq!(out["wants"], true);
}

#[test]
fn an_empty_or_unfinished_log_does_not_load_codex_to_inspect_readiness() {
	for before in ["", "w.onQuest(7108,{1})"] {
		let out = run(
			before,
			None,
			r#"
local loads, load = 0, C_AddOns.LoadAddOn
C_AddOns.LoadAddOn = function(name) if name == 'Polestar_Codex' then loads = loads + 1 end; return load(name) end
emit({ready=H.Ready(), loads=loads})
"#,
		);
		assert_eq!(out, json!({"ready":{}, "loads":0}));
	}
}

#[test]
fn ordinary_progress_without_a_new_ready_quest_does_not_republish_the_guide() {
	let out = run(
		"w.onQuest(7101,{}); w.onQuest(7108,{10})",
		None,
		r#"
local id = H.Start(); settle()
local initial, publishes = Polestar.Guides.Get(id), 0
Polestar.On('PACKS_CHANGED', function() publishes = publishes + 1 end)
for progress=1,4 do w.progress(7108,1,progress); settle() end
emit({publishes=publishes, same=initial==Polestar.Guides.Get(id), quests=ids(E.GetGuide())})
"#,
	);
	assert_eq!(out, json!({"publishes":0, "same":true, "quests":[7101]}));
}
