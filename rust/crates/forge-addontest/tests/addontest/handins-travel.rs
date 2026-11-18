//! The hand-in planner against real Nav/Travel.lua, including its shipped transport graph.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files(
			"Polestar",
			&["Core/Init.lua", "Core/LuaChunks.lua", "Core/Names.lua", "Core/Guides.lua", "Nav/Nav.xml", "Dungeons/Dungeons.lua", "Dungeons/Pickup.lua", "Lookup/HandinRoute.lua"],
		)],
		login: true,
		script: script.into(),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_real_transport_estimate_resumes_without_charging_suspended_time_or_the_public_budget() {
	let out = run(r#"
local N, nav = Polestar.Nav, stub.nav
nav.faction = 'Alliance'; nav.useTravelWorld(); nav.place(0, 790)
local goal = {map=9001,x=50,y=50}
local expected = N.EstimateTravel(nil, goal)
local wall, cpu, since, calls = 0, 0, 0, 0
debugprofilestop = function() return wall end
local function work()
	wall, cpu, calls = wall + 0.2, cpu + 0.2, calls + 1
	if cpu - since >= 3 then coroutine.yield(); since = cpu end
	return cpu
end
local answer
local worker = coroutine.create(function() answer = N.EstimateTravelCooperative(nil, goal, work) end)
local frames, interleaved = 0, false
while coroutine.status(worker) ~= 'dead' and frames < 100 do
	frames = frames + 1
	local ok, err = coroutine.resume(worker); assert(ok, err)
	if frames == 1 and coroutine.status(worker) ~= 'dead' then
		local public, reason = N.EstimateTravel(nil, {map=9000,x=15,y=30}, true)
		assert(type(public) == 'number' and reason == nil, 'an interleaved foreground plan remains available')
		interleaved = true
	end
	wall = wall + 100 -- the game renders between slices; this is not planner CPU time
end
local public, reason = N.EstimateTravel(nil, {map=9000,x=20,y=20}, true)
emit({answer=answer, expected=expected, frames=frames, checkpoints=calls, public=public, reason=reason or false, interleaved=interleaved})
"#);
	assert!(out["frames"].as_u64().unwrap() > 1, "the real graph search suspended and resumed");
	assert!(out["checkpoints"].as_u64().unwrap() > 15);
	assert_eq!(out["answer"], out["expected"], "suspended wall time must not consume the planner's 40 ms CPU cap");
	assert!(out["public"].is_number(), "background work must leave the public estimate budget available");
	assert_eq!(out["reason"], false);
	assert_eq!(out["interleaved"], true, "another real foreground search ran while the background search was suspended");
}

#[test]
fn forty_stops_on_the_shipped_network_use_sparse_plans_and_bounded_real_search_slices() {
	let out = run(r#"
local N, nav, R = Polestar.Nav, stub.nav, Polestar.HandinRoute
nav.faction = 'Alliance'; nav.place(-10500,1046,0)
local flags, stops = Polestar.CharState().flags, {}
flags.taxi = {}
for _,node in ipairs(N.GetTravelData().taxi) do
	flags.taxi[node.id] = true
	if #stops < 40 then
		local map=10000+#stops
		Polestar.RegisterMapFrames({era={[map]={c=node.c,left=node.wy+1000,right=node.wy-1000,top=node.wx+1000,bottom=node.wx-1000}}})
		local point={c=node.c,wx=node.wx,wy=node.wy,map=map,x=50,y=50,f='e'}
		stops[#stops+1]={key=tostring(node.id),inP=point,outP=point,deps={}}
	end
end
assert(#stops == 40, 'the shipped network must supply forty fixture destinations')
local count, simulated = 0, 0
local estimate = N.EstimateTravelCooperative
assert(type(estimate) == 'function', 'a private cooperative estimator is required')
N.EstimateTravelCooperative = function(...) count=count+1; return estimate(...) end
debugprofilestop = function() simulated=simulated+0.005; return simulated end
local from={map=9000,x=50,y=50}
local order, partial
R.Refine(stops,from,function() return true end,function(o,_,p) order,partial=o,p end)
local maximum, wallMaximum, frames, started = 0, 0, 0, os.clock()
while not order and frames < 620 do
	local before, at = simulated, os.clock()
	stub.advance(0.05)
	maximum=math.max(maximum,simulated-before)
	wallMaximum=math.max(wallMaximum,(os.clock()-at)*1000)
	frames=frames+1
end
local seen={}; for _,i in ipairs(order or {}) do seen[i]=true end
local unique=0; for _ in pairs(seen) do unique=unique+1 end
emit({count=count,maximum=maximum,wallMaximum=wallMaximum,wall=(os.clock()-started)*1000,frames=frames,
	complete=order and #order or 0,unique=unique,partial=partial or false})
"#);
	eprintln!("real hand-in travel planning: {out}");
	assert_eq!(out["complete"], 40);
	assert_eq!(out["unique"], 40);
	assert_eq!(out["partial"], false, "the sparse real-network pass completes before its deadline");
	assert!(out["count"].as_u64().unwrap() <= 160, "at most player + two neighbors + successor per stop");
	assert!(out["maximum"].as_f64().unwrap() < 4.0, "actual planner checkpoints bound work within a frame");
	forge_addontest::assert_timing!(out["wallMaximum"].as_f64().unwrap() < 20.0, "recorded wall-clock slices must remain bounded on the test host");
}

#[test]
fn changing_travel_data_discards_a_suspended_search_without_losing_stops() {
	let out = run(r#"
local N, nav, R = Polestar.Nav, stub.nav, Polestar.HandinRoute
nav.faction='Alliance'; nav.useTravelWorld(); nav.place(0,790)
local stops={}
for i,p in ipairs({{map=9000,x=10,y=40},{map=9000,x=85,y=50},{map=9001,x=50,y=50}}) do
	stops[i]={key=tostring(i),inP=p,outP=p,deps={}}
end
local clock, checkpoints, calls=0,0,0
debugprofilestop=function() clock=clock+4; return clock end
local estimate=N.EstimateTravelCooperative
N.EstimateTravelCooperative=function(a,b,work)
	calls=calls+1
	return estimate(a,b,function() checkpoints=checkpoints+1; return work() end)
end
local order, partial
R.Refine(stops,{map=9000,x=10.5,y=50},function() return true end,function(o,_,p) order,partial=o,p end)
for _=1,40 do if calls>0 then break end; stub.advance(0.05) end
assert(calls>0 and not order, 'the real estimator must be suspended before replacement')
local before=checkpoints
N.RegisterTravelData({taxi={},flights={},transports={},inns={}},true)
stub.advance(10)
emit({before=before,after=checkpoints,count=order and #order or 0,partial=partial or false})
"#);
	assert!(out["before"].as_u64().unwrap() > 0);
	assert_eq!(out["after"], out["before"], "the obsolete search must never resume against replacement graph data");
	assert_eq!(out["count"], 3);
	assert_eq!(out["partial"], true);
}
