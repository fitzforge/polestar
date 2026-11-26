//! The hand-in planner's code is paid for on first use, including saved-tab restoration.

use super::{run, ID};
use forge_addontest::lua_value;
use serde_json::json;

#[test]
fn login_and_readiness_checks_leave_the_handin_planner_unloaded() {
	let out = run(
		"w.onQuest(7101, {})",
		None,
		r#"
local ready = H.Ready()
stub.fire('QUEST_LOG_UPDATE'); stub.fire('PLAYER_ENTERING_WORLD'); settle()
emit({ready=ready, loaded=C_AddOns.IsAddOnLoaded('Polestar_FreeMode'),
	route=Polestar.HandinRoute ~= nil, refresh=H.Refresh ~= nil})
"#,
	);
	assert_eq!(out, json!({"ready":[7101],"loaded":false,"route":false,"refresh":false}));
}

#[test]
fn the_first_open_loads_the_shipped_planner_once_and_retains_its_public_table() {
	let out = run(
		"w.onQuest(7101, {})",
		None,
		r#"
local loads, load = 0, C_AddOns.LoadAddOn
function C_AddOns.LoadAddOn(name, ...)
	if name == 'Polestar_FreeMode' then loads=loads+1 end
	return load(name, ...)
end
local first = H.Start(); settle()
local second = H.Start(); settle()
w.onQuest(7103, {}); stub.fire('QUEST_LOG_UPDATE'); settle()
emit({first=first, second=second, loads=loads, same=H==Polestar.Handins,
	loaded=C_AddOns.IsAddOnLoaded('Polestar_FreeMode'), route=type(Polestar.HandinRoute and Polestar.HandinRoute.Refine),
	ids=ids(Polestar.Guides.Get('lookup/carried/log')), tabs=tabIds()})
"#,
	);
	assert_eq!(out, json!({"first":ID,"second":ID,"loads":1,"same":true,"loaded":true,"route":"function","ids":[7101,7103],"tabs":[ID]}));
}

#[test]
fn an_empty_log_does_not_load_the_planner() {
	let out = run(
		"",
		None,
		r#"
local id, why = H.Start()
emit({id=id or false, why=why, loaded=C_AddOns.IsAddOnLoaded('Polestar_FreeMode'), route=Polestar.HandinRoute ~= nil})
"#,
	);
	assert_eq!(out, json!({"id":false,"why":"nothing","loaded":false,"route":false}));
}

#[test]
fn a_combat_refusal_can_load_the_planner_on_a_later_open() {
	let out = run(
		"w.onQuest(7101, {})",
		None,
		r#"
stub.inCombat = true
local first, why = H.Start()
local loaded = C_AddOns.IsAddOnLoaded('Polestar_FreeMode')
stub.inCombat = false
local second = H.Start(); settle()
emit({first=first or false, why=why, before=loaded, after=C_AddOns.IsAddOnLoaded('Polestar_FreeMode'), second=second})
"#,
	);
	assert_eq!(out, json!({"first":false,"why":"combat","before":false,"after":true,"second":ID}));
}

#[test]
fn a_missing_planner_folder_explains_the_failure_and_keeps_the_current_tab() {
	let out = run(
		"w.onQuest(7101, {})",
		None,
		r#"
openOther('test/current')
local load = C_AddOns.LoadAddOn
function C_AddOns.LoadAddOn(name, ...)
	if name == 'Polestar_FreeMode' then return false, 'MISSING' end
	return load(name, ...)
end
local count = #stub.messages
local id, why = H.Start(); settle()
emit({id=id or false, why=why or false, active=E.GetGuide().id, tabs=tabIds(),
	explained=#stub.messages>count, route=Polestar.HandinRoute ~= nil})
"#,
	);
	assert_eq!(out, json!({"id":false,"why":"missing","active":"test/current","tabs":["test/current"],"explained":true,"route":false}));
}

#[test]
fn a_partial_planner_load_is_reported_without_calling_the_loader_again() {
	let out = run(
		"w.onQuest(7101, {})",
		None,
		r#"
local load = C_AddOns.LoadAddOn
function C_AddOns.LoadAddOn(name, ...)
	if name == 'Polestar_FreeMode' then
		H.BuildGuide = function() error('the incomplete runtime must not be called') end
		return true
	end
	return load(name, ...)
end
local count = #stub.messages
local id, why = H.Start()
emit({id=id or false, why=why, explained=#stub.messages>count, route=Polestar.HandinRoute ~= nil})
"#,
	);
	assert_eq!(out, json!({"id":false,"why":"error","explained":true,"route":false}));
}

#[test]
fn restoring_a_handin_tab_loads_the_planner_before_quest_events_arrive() {
	let saved = run("w.onQuest(7101, {})", None, "H.Start(); settle(); emit(Polestar.CharState())");
	let out = run(
		"",
		Some(format!("PolestarCharDB = {}", lua_value(&saved))),
		r#"
local before = C_AddOns.IsAddOnLoaded('Polestar_FreeMode')
w.onQuest(7101, {}); stub.fire('QUEST_LOG_UPDATE'); settle()
emit({loaded=before, ids=ids(Polestar.Guides.Get('lookup/carried/log')), tabs=tabIds()})
"#,
	);
	assert_eq!(out, json!({"loaded":true,"ids":[7101],"tabs":[ID]}));
}
