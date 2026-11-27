//! Polestar's API for other addons (docs/API.md, Core/API.lua): every call the doc lists is there, takes the
//! arguments it says and answers and fires what it says; Polestar.API.ReplaceSteps gives a guide new steps in
//! its own tab, keeping the player's place, done steps, ticks and skips by the steps' goals. Only Core and
//! Lookup load: none of these calls may need the guide window. The progress snapshot is a detached read
//! of the settled engine state, even while the player views a different step.

use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 20, 80)
"#;

fn run(login: bool, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Lookup/Lookup.xml"])],
		login,
		script: script.into(),
		..Default::default()
	})
	.remove(0)
}

// The calls docs/API.md lists: each line of its code block that starts with `Polestar.` and calls something.
fn documented() -> Vec<String> {
	let doc = std::fs::read_to_string(root().join("docs/API.md")).unwrap();
	doc.lines()
		.filter_map(|l| l.strip_prefix("Polestar."))
		.filter_map(|l| l.split_once('(').map(|(name, _)| name.to_string()))
		.filter(|n| n.chars().all(|c| c.is_ascii_alphanumeric() || c == '.'))
		.collect()
}

const LISTED: &str = r#"
local function at(path)
	local t = Polestar
	for part in path:gmatch("[^.]+") do t = type(t) == "table" and t[part] or nil end
	return t
end
local kinds = {}
for _, name in ipairs({ @LIST@ }) do kinds[name] = type(at(name)) end
local api = {}
for k, v in pairs(Polestar.API) do if type(v) == "function" then api[#api + 1] = "API." .. k end end
table.sort(api)
emit({ kinds = kinds, api = api, version = Polestar.API.version })
"#;

#[test]
fn docs_api_md_lists_every_call_of_polestar_api_and_every_call_it_lists_is_a_function() {
	let calls = documented();
	assert!(calls.len() >= 10, "docs/API.md's call list: {calls:?}");
	let list = calls.iter().map(|c| format!("\"{c}\"")).collect::<Vec<_>>().join(", ");
	let out = run(false, &LISTED.replace("@LIST@", &list));
	for c in &calls {
		assert_eq!(out["kinds"][c.as_str()], "function", "{c} is listed in docs/API.md");
	}
	for f in out["api"].as_array().unwrap() {
		let f = f.as_str().unwrap();
		assert!(calls.iter().any(|c| c == f), "docs/API.md lists Polestar.{f}");
	}
	assert_eq!(out["version"], 1);
}

const CALLS: &str = r##"
local w = stub.world
w.onQuest(201, { 1 })
w.onQuest(202, { { required = 1, fulfilled = 1 } })
w.complete({ 203 })
local P = Polestar
local API, Lk, E, C = P.API, P.Lookup, P.Engine, P.Compat
local r = { version = API.version, integer = API.version == math.floor(API.version) }
local function story(id)
	if id == 404 then return nil, "nostory" end
	if id == 405 then return { title = "Empty", steps = {} } end
	return { title = "Chapter " .. id, steps = { { title = "Meet Bob", goals = { { t = "talk", npc = 601, npcName = "Bob", map = 1429, x = 41, y = 60 } } } } }
end
r.planner = select("#", Lk.RegisterPlanner("story", story))
local def = Lk.BuildGuide("story", 7)
r.def = { id = def.id, pack = def.pack, category = def.category, title = def.title, steps = #def.steps, lookup = def.lookup }
local a, b = Lk.BuildGuide("story", 404)
r.refused = { a == nil, b }
a, b = Lk.BuildGuide("story", 405)
r.empty = { a == nil, b }
a, b = Lk.BuildGuide("story", nil)
r.noId = { a == nil, b }
r.register = { P.RegisterGuide(def) }
r.badRegister = { P.RegisterGuide({ id = "lookup/story/8", pack = "lookup", steps = {} }) }
local heard = {}
local h = P.On("GUIDE_CHANGED", function(id) heard[#heard + 1] = id end)
r.set = E.SetGuide(def.id)
r.again = E.SetGuide(def.id)
r.active = E.GetGuide().id
r.unknownSet = E.SetGuide("lookup/story/999")
P.Off(h)
E.SetGuide(nil)
r.heard = heard
r.compat = {}
for _, q in ipairs({ 201, 202, 203, 204 }) do
	r.compat[#r.compat + 1] = { C.IsOnQuest(q), C.IsQuestCompleted(q), C.IsQuestReadyForTurnIn(q) }
end
emit(r)
"##;

#[test]
fn the_documented_calls_take_their_arguments_and_answer_and_fire_as_docs_api_md_says() {
	let out = run(true, CALLS);
	assert_eq!(out["version"], 1);
	assert_eq!(out["integer"], true, "Polestar.API.version is an integer");
	assert_eq!(out["planner"], 0, "RegisterPlanner returns nothing");
	assert_eq!(out["def"], json!({ "id": "lookup/story/7", "pack": "lookup", "category": "Lookup", "title": "Chapter 7", "steps": 1, "lookup": { "kind": "story", "id": 7 } }));
	assert_eq!(out["refused"], json!([true, "nostory"]), "build's own reason");
	assert_eq!(out["empty"], json!([true, "noguide"]));
	assert_eq!(out["noId"], json!([true, "unknown"]));
	assert_eq!(out["register"], json!([true]));
	assert_eq!(out["badRegister"], json!([false, "missing title"]));
	assert_eq!(out["set"], true);
	assert_eq!(out["again"], true);
	assert_eq!(out["active"], "lookup/story/7");
	assert_eq!(out["unknownSet"], false);
	assert_eq!(out["heard"], json!(["lookup/story/7"]), "GUIDE_CHANGED(guideId) once: not for the guide already shown, nor for an unknown id");
	// { IsOnQuest, IsQuestCompleted, IsQuestReadyForTurnIn }: in the log, ready to hand in, handed in, never seen.
	assert_eq!(out["compat"], json!([[true, false, false], [true, false, true], [false, true, false], [false, false, false]]));
}

// A story guide built by a Lookup planner: the player is on quest A (Take A done), has ticked Bob off and
// skipped Take B, so the live step is Take C. Each S.<name>() is a fresh step table, as a planner makes them.
const STORY: &str = r#"
API, Lk, E = Polestar.API, Polestar.Lookup, Polestar.Engine
local function step(title, goal) return { title = title, goals = { goal } } end
local function A(q, x) return { t = "accept", quest = q, title = "Q" .. q, npc = 500 + q, map = 1429, x = x, y = 40 } end
local function T(q, x) return { t = "turnin", quest = q, title = "Q" .. q, npc = 500 + q, map = 1429, x = x, y = 50 } end
S = {
	takeA = function() return step("Take A", A(101, 40)) end,
	bob = function() return step("Talk to Bob", { t = "talk", npc = 601, npcName = "Bob", map = 1429, x = 41, y = 60 }) end,
	takeB = function() return step("Take B", A(102, 42)) end,
	takeC = function() return step("Take C", A(103, 43)) end,
	takeD = function() return step("Take D", A(104, 44)) end,
	handA = function() return step("Turn in A", T(101, 45)) end,
	takeX = function() return step("Take X", A(105, 46)) end,
}
function steps(list) local out = {} for i, s in ipairs(list) do out[i] = s() end return out end
PLAN = { S.takeA, S.bob, S.takeB, S.takeC, S.takeD, S.handA }
Lk.RegisterPlanner("story", function(id) return { title = "Story " .. id, steps = steps(PLAN) } end)
function flush() stub.advance(0.25) end
function views()
	local out = {}
	for i = 1, E.GetStepCount() do local v = E.GetStepView(i); out[i] = v.title .. ": " .. v.status end
	return out
end
function tabs()
	local list, active = E.GetTabs()
	local out = {}
	for i, t in ipairs(list) do out[i] = t.guideId end
	return { ids = out, active = active }
end
HEARD = {}
for _, m in ipairs({ "GUIDE_CHANGED", "STEP_CHANGED", "TABS_CHANGED" }) do
	Polestar.On(m, function() HEARD[m] = (HEARD[m] or 0) + 1 end)
end
function heard() local h = HEARD; HEARD = {}; return h end
stub.world.onQuest(101, { 1 })
stub.login()
stub.fire("QUEST_LOG_UPDATE")
DEF = Lk.BuildGuide("story", 1)
Polestar.RegisterGuide(DEF)
E.SetGuide(DEF.id)
flush()
"#;

const PLAYED: &str = r#"
E.ToggleGoal(2, 1)
flush()
E.Skip()
flush()
"#;

fn story(played: bool, script: &str) -> Value {
	run(false, &[STORY, if played { PLAYED } else { "" }, script].join("\n"))
}

#[test]
fn replace_steps_keeps_ticked_and_skipped_steps_by_their_goals_wherever_the_new_list_puts_them() {
	let out = story(
		true,
		r#"
		local r = { before = views() }
		r.ok = { API.ReplaceSteps(DEF.id, steps({ S.bob, S.takeA, S.takeC, S.takeB, S.takeX, S.handA })) }
		flush()
		r.after, r.live = views(), E.GetLiveStep()
		-- Take C taken: the skipped Take B, now after it, is passed.
		stub.world.accept(103, { 1 })
		flush()
		r.next = E.GetStepView(E.GetLiveStep()).title
		emit(r)
	"#,
	);
	assert_eq!(out["before"], json!(["Take A: done", "Talk to Bob: done", "Take B: skipped", "Take C: current", "Take D: upcoming", "Turn in A: upcoming"]));
	assert_eq!(out["ok"], json!([true]));
	assert_eq!(out["after"], json!(["Talk to Bob: done", "Take A: done", "Take C: current", "Take B: upcoming", "Take X: upcoming", "Turn in A: upcoming"]));
	assert_eq!(out["live"], 3, "Take C, the step the player was on");
	assert_eq!(out["next"], "Take X", "Take B keeps its skip at its new place");
}

#[test]
fn a_step_the_new_list_leaves_out_is_gone_a_new_one_comes_in_where_the_list_puts_it_and_done_steps_stay_in_front() {
	let out = story(
		true,
		r#"
		local r = {}
		r.ok = { API.ReplaceSteps(DEF.id, steps({ S.takeC, S.takeX, S.handA })) }
		flush()
		r.after, r.live = views(), E.GetLiveStep()
		emit(r)
	"#,
	);
	assert_eq!(out["ok"], json!([true]));
	// Only what is left was sent: the done and skipped steps before Take C stay; Take D is gone; Take X comes in.
	assert_eq!(out["after"], json!(["Take A: done", "Talk to Bob: done", "Take B: skipped", "Take C: current", "Take X: upcoming", "Turn in A: upcoming"]));
	assert_eq!(out["live"], 4);
}

#[test]
fn replace_steps_keeps_the_player_on_their_step_where_placing_the_guide_afresh_would_move_them_on() {
	let out = story(
		false,
		r#"
		local r = { first = E.GetLiveStep() }
		-- Quest B taken out of order: Bob's talk still holds the route.
		stub.world.accept(102, { 1 })
		flush()
		r.taken = E.GetLiveStep()
		API.ReplaceSteps(DEF.id, steps({ S.takeA, S.bob, S.takeB, S.takeC, S.takeX }))
		flush()
		r.replaced = E.GetLiveStep()
		-- The way it was done before: a new guide id, put into the tab, is placed from the quest log.
		PLAN = { S.takeA, S.bob, S.takeB, S.takeC, S.takeX }
		local again = Lk.BuildGuide("story", 2)
		Polestar.RegisterGuide(again)
		E.SetGuide(again.id)
		stub.advance(11)
		r.newId = E.GetLiveStep()
		emit(r)
	"#,
	);
	assert_eq!(out["first"], 2);
	assert_eq!(out["taken"], 2);
	assert_eq!(out["replaced"], 2, "still Talk to Bob");
	assert_eq!(out["newId"], 4, "a new guide is placed past Bob");
}

#[test]
fn the_step_the_player_looks_at_stays_in_view_at_its_new_place() {
	let out = story(
		true,
		r#"
		E.Goto(6)
		flush()
		local r = { before = E.GetStepView(E.GetStepIndex()).title }
		API.ReplaceSteps(DEF.id, steps({ S.bob, S.takeA, S.takeC, S.takeX, S.handA, S.takeB }))
		flush()
		r.shown, r.live = E.GetStepIndex(), E.GetLiveStep()
		r.title = E.GetStepView(r.shown).title
		emit(r)
	"#,
	);
	assert_eq!(out["before"], "Turn in A");
	assert_eq!(out["shown"], 5);
	assert_eq!(out["title"], "Turn in A");
	assert_eq!(out["live"], 3);
}

#[test]
fn replace_steps_fires_guide_changed_once_in_the_same_tab_and_none_for_a_guide_in_another_tab() {
	let out = story(
		true,
		r#"
		local r = {}
		heard()
		r.before = tabs()
		API.ReplaceSteps(DEF.id, steps({ S.takeA, S.bob, S.takeB, S.takeC, S.takeX, S.handA }))
		r.heard = heard()
		flush()
		r.after, r.id = tabs(), E.GetGuide().id
		-- In a tab not the active one: the tab bar hears of it, the guide shown did not change.
		Polestar.RegisterGuide(Lk.BuildGuide("story", 2))
		E.OpenTab("lookup/story/2")
		flush()
		heard()
		API.ReplaceSteps(DEF.id, steps({ S.takeC, S.handA }))
		flush()
		r.background, r.tabs = heard(), tabs()
		emit(r)
	"#,
	);
	assert_eq!(out["before"], json!({ "ids": ["lookup/story/1"], "active": 1 }));
	assert_eq!(out["heard"]["GUIDE_CHANGED"], 1);
	assert_eq!(out["after"], json!({ "ids": ["lookup/story/1"], "active": 1 }));
	assert_eq!(out["id"], "lookup/story/1", "no new guide id");
	assert_eq!(out["background"], json!({ "TABS_CHANGED": 1 }));
	assert_eq!(out["tabs"], json!({ "ids": ["lookup/story/1", "lookup/story/2"], "active": 2 }));
}

#[test]
fn replace_steps_refuses_an_unknown_guide_polestar_s_own_guides_bad_steps_and_calls_from_a_message_handler() {
	let out = story(
		true,
		r#"
		Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar", author = "Polestar", version = "1", license = "GPL-3.0" })
		Polestar.RegisterGuide({ id = "forever/test", pack = "guides", title = "T", steps = steps({ S.takeA }) })
		heard()
		local r = {}
		r.unknown = { API.ReplaceSteps("lookup/story/404", steps({ S.takeA })) }
		r.own = { API.ReplaceSteps("forever/test", steps({ S.takeA })) }
		r.bad = { API.ReplaceSteps(DEF.id, { { title = "No goals", goals = {} } }) }
		r.empty = { API.ReplaceSteps(DEF.id, {}) }
		local h = Polestar.On("STEP_UPDATED", function() r.busy = { API.ReplaceSteps(DEF.id, steps({ S.takeA })) } end)
		Polestar.Fire("STEP_UPDATED", 4)
		Polestar.Off(h)
		r.heard, r.views = heard(), views()
		emit(r)
	"#,
	);
	assert_eq!(out["unknown"], json!([false, "unknown guide"]));
	assert_eq!(out["own"], json!([false, "Polestar's own guide"]));
	assert_eq!(out["bad"], json!([false, "step 1 has no goals"]));
	assert_eq!(out["empty"], json!([false, "no steps"]));
	assert_eq!(out["busy"], json!([false, "busy"]));
	assert_eq!(out["heard"], json!({}), "nothing fired");
	assert_eq!(out["views"], json!(["Take A: done", "Talk to Bob: done", "Take B: skipped", "Take C: current", "Take D: upcoming", "Turn in A: upcoming"]), "nothing changed");
}

#[test]
fn progress_snapshot_distinguishes_unready_no_guide_and_no_live_step() {
	let out = run(
		false,
		r#"
		local P = Polestar
		local E, read = P.Engine, P.API.GetProgressSnapshot
		local r = { beforeLogin = read() }
		stub.login()
		r.noGuide = read()
		local during
		P.On("GUIDE_CHANGED", function(id) if id then during = read() end end)
		assert(P.RegisterGuide({ id = "lookup/snapshot/1", pack = "lookup", title = "Finish",
			steps = { { goals = { { t = "task", text = "Check this" } } } } }))
		assert(E.SetGuide("lookup/snapshot/1"))
		r.placing, r.during = read(), during
		stub.fire("QUEST_LOG_UPDATE")
		r.queued = read()
		stub.advance(0.25)
		r.active = read()
		E.ToggleGoal(1, 1)
		stub.advance(0.25)
		r.finished = read()
		E.SetGuide(nil)
		r.closed = read()
		emit(r)
		"#,
	);
	let waiting = json!({ "schemaVersion": 1, "state": "not_ready" });
	for phase in ["beforeLogin", "placing", "during", "queued"] {
		assert_eq!(out[phase], waiting, "{phase}");
	}
	for phase in ["noGuide", "closed"] {
		assert_eq!(out[phase], json!({ "schemaVersion": 1, "state": "no_guide" }), "{phase}");
	}
	assert_eq!(out["active"]["state"], "active");
	assert_eq!(out["active"]["live"]["index"], 1);
	assert_eq!(out["active"]["upcomingComplete"], true);
	assert_eq!(out["finished"]["state"], "no_live_step");
	assert_eq!(out["finished"]["guide"]["id"], "lookup/snapshot/1");
	assert!(out["finished"].get("live").is_none());
	assert!(out["finished"].get("upcoming").is_none());
}

#[test]
fn progress_snapshot_uses_live_step_and_returns_detached_data_without_side_effects() {
	let out = run(
		false,
		r#"
		local P, w = Polestar, stub.world
		local E, read = P.Engine, P.API.GetProgressSnapshot
		w.onQuest(101, { { required = 5, fulfilled = 0 } })
		stub.login()
		stub.fire("QUEST_LOG_UPDATE")
		assert(P.RegisterGuide({ id = "lookup/snapshot/2", pack = "lookup", title = "Route", zone = 1429,
			minLevel = 1, maxLevel = 10, steps = {
				{ title = "Work", goals = {
					{ t = "kill", target = "Wolf", quest = 101, oi = 1, npc = 601, map = 1429, x = 0, y = 60 },
					{ t = "task", text = "Check this", optional = true },
					{ t = "task", text = "Set aside", optional = true },
				} },
				{ title = "Wrong faction", only = { factions = { "Horde" } }, goals = { { t = "task", text = "Other" } } },
				{ title = "Side task", along = true, goals = { { t = "task", text = "Aside" } } },
				{ title = "Skipped", goals = { { t = "task", text = "Skip it" } } },
				{ title = "Done", goals = { { t = "task", text = "Do it early" } } },
				{ title = "Next", goals = { { t = "task", text = "Up next" } } },
				{ title = "Later", goals = { { t = "task", text = "Later" } } },
				{ title = "Last", goals = { { t = "task", text = "Last" } } },
				{ title = "Beyond horizon", goals = { { t = "task", text = "Beyond" } } },
			} }))
		E.SetGuide("lookup/snapshot/2")
		stub.advance(0.25)
		E.ToggleGoal(1, 2)
		E.SkipGoal(1, 3)
		E.Goto(4)
		E.Skip()
		E.ToggleGoal(5, 1)
		E.Goto(7)
		stub.advance(0.25)
		local function same(a, b)
			if type(a) ~= "table" then return a == b end
			if type(b) ~= "table" then return false end
			for k, v in pairs(a) do if not same(v, b[k]) then return false end end
			for k in pairs(b) do if a[k] == nil then return false end end
			return true
		end
		local function copy(a)
			if type(a) ~= "table" then return a end
			local b = {}; for k, v in pairs(a) do b[k] = copy(v) end; return b
		end
		local saved, account = copy(PolestarCharDB), copy(PolestarDB)
		local guide, waypoint, moment = E.GetGuide(), E.GetWaypoint(), P.Moment()
		local before = read()
		for _ = 1, 5 do
			local other = read()
			assert(same(other, before))
			other.guide.title = "changed"
			other.live.goals[1].location.y = 0
			other.live.goals[1].progress.required = 1
			other.upcoming[1].title = "changed"
			other.viewed.index = 1
		end
		local stable = same(before, read()) and same(saved, PolestarCharDB)
			and same(account, PolestarDB) and E.GetGuide() == guide and E.GetWaypoint() == waypoint
			and P.Moment() == moment and E.GetStepIndex() == 7 and E.GetLiveStep() == 1
		w.progress(101, 1, 2)
		local pending = read().state
		stub.advance(0.25)
		emit({ snapshot = before, stable = stable, headless = PolestarGuideFrame == nil,
			pending = pending, nextCount = read().live.goals[1].progress.current })
		"#,
	);
	assert_eq!(out["stable"], true);
	assert_eq!(out["headless"], true);
	assert_eq!(out["pending"], "not_ready");
	assert_eq!(out["nextCount"], 2);
	let snapshot = &out["snapshot"];
	assert_eq!(snapshot["state"], "active");
	assert_eq!(
		snapshot["guide"],
		json!({
			"id": "lookup/snapshot/2", "title": "Route", "zoneMapID": 1429,
			"minLevel": 1, "maxLevel": 10, "stepTotal": 7,
		})
	);
	assert_eq!(snapshot["live"]["index"], 1);
	assert_eq!(snapshot["viewed"]["index"], 7);
	assert_eq!(snapshot["viewed"]["number"], 5);
	assert_eq!(
		snapshot["live"]["goals"][0],
		json!({
			"index": 1, "action": "kill", "status": "open", "text": "Wolf", "questID": 101, "npcID": 601,
			"optional": false, "manualTick": false, "manuallySkipped": false,
			"location": { "uiMapID": 1429, "x": 0, "y": 0.6 },
			"progress": { "current": 0, "required": 5 },
		})
	);
	assert_eq!(snapshot["live"]["goals"][1]["manualTick"], true);
	assert_eq!(snapshot["live"]["goals"][1]["optional"], true);
	assert_eq!(snapshot["live"]["goals"][1]["status"], "done");
	assert_eq!(snapshot["live"]["goals"][2]["manuallySkipped"], true);
	assert_eq!(snapshot["live"]["goals"][2]["status"], "skipped");
	let indexes: Vec<_> = snapshot["upcoming"].as_array().unwrap().iter().map(|s| &s["index"]).collect();
	assert_eq!(indexes, vec![&json!(6), &json!(7), &json!(8)]);
	assert_eq!(snapshot["upcomingComplete"], true);
}

#[test]
fn progress_snapshot_bounds_goals_and_lookahead_and_omits_missing_fields() {
	let out = run(
		false,
		r#"
		local P = Polestar
		local E, read = P.Engine, P.API.GetProgressSnapshot
		stub.login()
		stub.fire("QUEST_LOG_UPDATE")
		local goals = {}
		for i = 1, 10 do goals[i] = { t = "task", text = "Task " .. i } end
		local steps = { { goals = goals } }
		for i = 2, 33 do
			steps[i] = { only = { factions = { "Horde" } }, goals = { { t = "task", text = "Other" } } }
		end
		steps[33].only = nil  -- last candidate inside the scan
		steps[34] = { goals = { { t = "task", text = "Beyond" } } }
		assert(P.RegisterGuide({ id = "lookup/snapshot/3", pack = "lookup", title = "Long gap", steps = steps }))
		P.CharState().manual["lookup/snapshot/3"] = { ["1:2"] = true }
		E.SetGuide("lookup/snapshot/3")
		stub.advance(0.25)
		emit(read())
		"#,
	);
	assert_eq!(out["live"]["goalsTruncated"], true);
	assert_eq!(out["live"]["goals"].as_array().unwrap().len(), 8);
	assert!(out["live"].get("title").is_none());
	assert!(out["live"]["goals"][0].get("location").is_none());
	assert!(out["live"]["goals"][0].get("questID").is_none());
	assert_eq!(out["live"]["goals"][0]["manualTick"], false);
	assert!(out["live"]["goals"][1].get("manualTick").is_none());
	assert!(out.get("viewed").is_none());
	assert_eq!(out["upcoming"].as_array().unwrap().len(), 1);
	assert_eq!(out["upcoming"][0]["index"], 33);
	assert_eq!(out["upcomingComplete"], false);
}
