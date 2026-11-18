//! Generated turn-ins can represent the current quest-log attempt without changing quest history.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(9001, {name='Errand Vale',c=0,left=1000,right=-1000,top=1000,bottom=-1000})
w.moveTo(9001,50,50)
w.repeatable[7110] = true
w.complete({7110})
w.onQuest(7110,{})
"#;

const HELPERS: &str = r#"
local E = Polestar.Engine
local function settle() stub.fire('QUEST_LOG_UPDATE'); stub.advance(1) end
local function register(flag, when)
	local goal = {t='turnin',quest=7110,title='Repeatable Parcel',npc=5001,npcName='Courier',map=9001,x=60,y=60,currentLog=flag}
	assert(Polestar.RegisterGuide({id='test/current-log',pack='test',title='Current errands',category='Test',steps={
		{when=when,goals={goal}},
		{goals={{t='level',level=60}}}
	}}))
	assert(E.OpenTab('test/current-log',true))
	settle()
end
local function action()
	local live = E.GetLiveStep()
	local view = live and E.GetStepView(live)
	local goal = view and view.goals and view.goals[1]
	return {step=live or false,quest=goal and goal.quest or false,status=goal and goal.status or false,wants=E.WantsQuest('turnin',7110)}
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		login: true,
		script: format!("{TEST_PACK}\n{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn current_log_turnins_are_actionable_under_any_guide_id_and_on_repeat_acceptance() {
	let out = run(r#"
register(true)
local first = action()
w.turnIn(7110); settle()
local delivered = action()
w.accept(7110,{}); settle()
emit({first=first,delivered=delivered,again=action()})
"#);
	let active = json!({"step":1,"quest":7110,"status":"active","wants":true});
	assert_eq!(out["first"], active);
	assert_eq!(out["again"], active, "a previous attempt's check-off and session history cannot finish the new attempt");
	assert_eq!(out["delivered"]["step"], 2);
	assert_eq!(out["delivered"]["wants"], false);
}

#[test]
fn current_log_goals_do_not_erase_completion_history_used_by_step_conditions() {
	let out = run(r#"
register(true,{{k='turnedin',q=7110}})
emit(action())
"#);
	assert_eq!(out, json!({"step":1,"quest":7110,"status":"active","wants":true}), "the previous hand-in still satisfies a turnedin condition while the new turn-in remains open");
}

#[test]
fn current_log_turnins_honor_either_alternatives_without_latching_the_other_attempt() {
	let out = run(r#"
w.repeatable[7111] = true
w.onQuest(7111,{})
assert(Polestar.RegisterGuide({id='test/current-log-either',pack='test',title='Alternative errands',steps={
	{goals={
		{t='turnin',quest=7110,title='Repeatable Parcel',currentLog=true,either=true},
		{t='turnin',quest=7111,title='Alternative Parcel',currentLog=true,either=true}
	}},
	{goals={{t='level',level=60}}}
}}))
assert(E.OpenTab('test/current-log-either',true))
settle()
local function state()
	local view = E.GetStepView(1)
	return {live=E.GetLiveStep(),done=E.GoalDone(1,1),viewDone=view.goals[1].status=='done',held=Polestar.Compat.IsOnQuest(7110)}
end
local first = state()
w.turnIn(7111); settle()
local delivered = state()
w.accept(7111,{}); settle()
emit({first=first,delivered=delivered,again=state()})
"#);
	let open = json!({"live":1,"done":false,"viewDone":false,"held":true});
	assert_eq!(out["first"], open, "completion history cannot finish either current attempt");
	assert_eq!(out["delivered"], json!({"live":2,"done":true,"viewDone":true,"held":true}), "handing in the alternative completes the set while the other quest remains held");
	assert_eq!(out["again"], open, "accepting the alternative again reopens both current attempts");
}

#[test]
fn ordinary_turnins_keep_their_existing_completion_history_semantics() {
	let out = run("register(nil); emit(action())");
	assert_eq!(out["step"], 2);
	assert_eq!(out["wants"], false);
}

#[test]
fn current_log_is_only_valid_as_a_true_flag_on_a_turnin_goal() {
	let out = run(r#"
local rejected = {}
for i,g in ipairs({
	{t='turnin',quest=7110,title='Repeatable Parcel',currentLog='yes'},
	{t='accept',quest=7110,title='Repeatable Parcel',currentLog=true},
	{t='level',level=60,currentLog=true}
}) do
	local ok,why = Polestar.RegisterGuide({id='test/invalid-'..i,pack='test',title='Invalid flag',steps={{goals={g}}}})
	rejected[i] = not ok and type(why)=='string' and why:find('currentLog',1,true) ~= nil
end
emit(rejected)
"#);
	assert_eq!(out, json!([true, true, true]));
}
