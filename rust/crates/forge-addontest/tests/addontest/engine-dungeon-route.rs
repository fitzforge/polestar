//! Dungeons in the route (addon/Polestar/Core/Engine.lua; docs/GUIDE_FORMAT.md, "Dungeon steps"): a leveling
//! guide carries a dungeon's pick-ups, its run and its hand-ins as steps behind `when dungeon` (hand-ins behind
//! `when complete`), compiled into the one route. "Dungeons in my route" (the behavior.dungeons setting: Skip / Ask
//! me / Run them; Skip until the player picks another, so the solo route is the default) answers every dungeon the
//! character has not answered one by one (CharState().dungeons[map], Engine.ChooseDungeon). Ask: the first dungeon
//! step with something to do now holds the route and the window asks. At the run, "No group? Skip it"
//! (Engine.SkipDungeon) answers Skip and the route goes on. An answer given mid-guide never moves the live step
//! back, never re-opens a pick-up the route passed, and the run is guarded (`when onquest`). Real Core manifest,
//! stub world (a level 10 Human Warrior in Elwynn Forest), as engine-when-dungeon.rs.
//!
//! Dungeons in the route are held back while Core/Init.lua's switch (`ns.dungeonRoute`) is off, as it ships:
//! these tests turn it on (`run`, `run_with`), and the `held_back_*` ones leave it off: every dungeon reads Skip
//! whatever is saved, the route is the solo route's, nothing asks, and the saved answers are kept.

use forge_addontest::{emitted, lua_value, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(10)
w.titles[214] = "Red Silk Bandanas"
w.titles[167] = "Oh Brother. . ."
w.titles[7] = "Kobold Camp Cleanup"
w.titles[15] = "Investigate Echo Ridge"
"#;

// The injection pattern on a small route: (1) a pick-up on a stop the route makes, (2, 3) solo steps, (4) the
// run's own stop repeating the pick-ups, (5) the guarded run, (6) the hand-in behind `when dungeon` and `when
// complete`, (7) solo. A second guide shares a stop with the solo route, after an escort that finishes its
// prerequisite (Loch Modan's traitor and Sentinel Hill): the dungeon's step hands that quest in and takes the
// dungeon's, the solo way of that stop is behind `when !dungeon`.
const GUIDE: &str = r#"
local DM = { k = "dungeon", name = "The Deadmines", map = 36 }
Polestar.RegisterGuide({
	id = "test/route", pack = "test", title = "Route", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "Scout Riell", when = { DM }, goals = {
			{ t = "accept", quest = 214, title = "Red Silk Bandanas", npc = 6670, npcName = "Scout Riell", map = 1429, x = 48.0, y = 42.0 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Echo Ridge", goals = {
			{ t = "accept", quest = 15, title = "Investigate Echo Ridge", npc = 197, npcName = "Marshal McBride", map = 1429, x = 47.5, y = 40.0 },
		} },
		{ title = "Sentinel Hill", when = { DM }, goals = {
			{ t = "accept", quest = 214, title = "Red Silk Bandanas", npc = 6670, npcName = "Scout Riell", map = 1429, x = 48.0, y = 42.0 },
			{ t = "accept", quest = 167, title = "Oh Brother. . .", npc = 6670, npcName = "Scout Riell", map = 1429, x = 48.0, y = 42.0 },
		} },
		{ title = "The Deadmines", when = { DM, { k = "onquest", q = { 214, 167 } } }, goals = {
			{ t = "enter", location = "The Deadmines", map = 1429, x = 42.0, y = 70.0 },
			{ t = "complete", quest = 214, title = "Red Silk Bandanas" },
		} },
		{ title = "Scout Riell", when = { DM, { k = "complete", q = 214 } }, goals = {
			{ t = "turnin", quest = 214, title = "Red Silk Bandanas", npc = 6670, npcName = "Scout Riell", map = 1429, x = 48.0, y = 42.0 },
		} },
		{ title = "Goldshire", goals = {
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
Polestar.RegisterGuide({
	id = "test/shared", pack = "test", title = "Shared stop", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "The Defias Traitor", goals = {
			{ t = "complete", quest = 155, title = "The Defias Brotherhood", map = 1429, x = 45.0, y = 50.0 },
		} },
		{ title = "Gryan Stoutmantle", when = { DM }, goals = {
			{ t = "turnin", quest = 155, title = "The Defias Brotherhood", npc = 234, npcName = "Gryan Stoutmantle", map = 1429, x = 48.0, y = 42.0 },
			{ t = "accept", quest = 166, title = "The Defias Brotherhood", npc = 234, npcName = "Gryan Stoutmantle", map = 1429, x = 48.0, y = 42.0, pre = { 155 } },
		} },
		{ title = "Sentinel Hill", when = { { k = "dungeon", name = "The Deadmines", map = 36, neg = true } }, goals = {
			{ t = "turnin", quest = 155, title = "The Defias Brotherhood", npc = 234, npcName = "Gryan Stoutmantle", map = 1429, x = 48.0, y = 42.0 },
		} },
		{ title = "Goldshire", goals = {
			{ t = "goto", map = 1429, x = 42.1, y = 65.9, label = "Goldshire" },
		} },
	},
})
Polestar.RegisterGuide({
	id = "test/gated", pack = "test", title = "Gated", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "Scout Riell", when = { DM, { k = "level", op = ">=", n = 12 } }, goals = {
			{ t = "accept", quest = 214, title = "Red Silk Bandanas", npc = 6670, npcName = "Scout Riell", map = 1429, x = 48.0, y = 42.0 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "The Deadmines", when = { DM, { k = "onquest", q = { 214 } }, { k = "level", op = ">=", n = 13, frac = 0.5 } }, goals = {
			{ t = "enter", location = "The Deadmines", map = 1429, x = 42.0, y = 70.0 },
			{ t = "complete", quest = 214, title = "Red Silk Bandanas" },
		} },
		{ title = "Goldshire", goals = {
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
local RFC = { k = "dungeon", name = "Ragefire Chasm", map = 389 }
Polestar.RegisterGuide({
	id = "test/city", pack = "test", title = "City", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "Orgrimmar", when = { RFC }, goals = {
			{ t = "accept", quest = 5761, title = "Slaying the Beast", npc = 3216, npcName = "Neeru Fireblade", map = 1429, x = 50.0, y = 50.0 },
		} },
		{ title = "Ragefire Chasm", when = { RFC, { k = "onquest", q = { 5761 } } }, goals = {
			{ t = "enter", location = "Ragefire Chasm", map = 1429, x = 51.0, y = 51.0 },
		} },
		{ title = "Goldshire", goals = {
			{ t = "goto", map = 1429, x = 42.1, y = 65.9, label = "Goldshire" },
		} },
	},
})
"#;

// `trace` records the live step after each action; `take(q)` accepts quest q (its objective open) and settles.
const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
function flush() stub.advance(0.25) end
function at() return E.GetLiveStep() end
function st(i) return E.GetStepView(i).status end
trace = {}
function mark() trace[#trace + 1] = at() or false end
function take(q) w.accept(q, { 1 }); flush(); mark() end
function aim() local p = E.GetWaypoint(); return p and p.x and (p.x .. "," .. p.y) or false end
function asked() local d = E.DungeonQuestion(); return d and { map = d.map, name = d.name, quests = d.quests, runIn = d.runIn } or false end
"#;

/// `saved`: the character's saved PolestarCharDB (None: a character Polestar never saw, whose tab is opened
/// after login); its `_route`, when given, is "Dungeons in my route" (behavior.dungeons), saved in PolestarDB.
fn run(saved: Option<Value>, script: &str) -> Vec<Value> {
	run_with("", saved, script)
}

/// As `run`, with `world` (Lua, after the stub world is made and before login: quests already in the log).
fn run_with(world: &str, saved: Option<Value>, script: &str) -> Vec<Value> {
	run_switch(true, world, saved, script)
}

/// As `run_with`, with dungeons in the route turned on (`on`) or left as they ship (Core/Init.lua's switch).
fn run_switch(on: bool, world: &str, saved: Option<Value>, script: &str) -> Vec<Value> {
	let open = if saved.is_none() { r#"E.SetGuide("test/route")"# } else { "" };
	let switch = if on { "Polestar.dungeonRoute = true" } else { "" };
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\n{world}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: saved.map(saved_lua).unwrap_or_default(),
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, switch, "stub.login()", open, r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6); mark()"#, script].join("\n"),
		..Default::default()
	})
}

/// The saved variables: PolestarCharDB, and PolestarDB's behavior.dungeons from `_route`.
fn saved_lua(mut s: Value) -> Vec<(String, String)> {
	let route = s.as_object_mut().and_then(|o| o.remove("_route"));
	let mut lua = format!("PolestarCharDB = {}", lua_value(&s));
	if let Some(r) = route {
		lua += &format!("\nPolestarDB = {{ schema = 1, settings = {{ behavior = {{ dungeons = {} }} }} }}", lua_value(&r));
	}
	vec![("Polestar".into(), lua)]
}

fn char(route: &str) -> Option<Value> {
	Some(json!({ "schema": 1, "guide": "test/route", "_route": route }))
}

fn non_decreasing(trace: &Value) {
	let steps: Vec<i64> = trace.as_array().unwrap().iter().map(|v| v.as_i64().expect("a live step")).collect();
	assert!(steps.windows(2).all(|w| w[0] <= w[1]), "the live step never goes back: {steps:?}");
}

#[test]
fn dungeon_route_skip_by_default_ask_holds_the_route_at_the_first_pick_up() {
	let new = run(None, r#"emit({ route = Polestar.Get("behavior.dungeons"), saved = (PolestarDB.settings.behavior or {}).dungeons or false, at = at(), asked = asked(), s1 = st(1) })"#);
	assert_eq!(new[0], json!({ "route": "skip", "saved": false, "at": 2, "asked": false, "s1": "skipped" }), "no answer given: Skip, the solo route, and nothing is written");
	let seen = run(Some(json!({ "schema": 1, "guide": "test/route" })), r#"emit({ route = Polestar.Get("behavior.dungeons"), at = at(), asked = asked(), s1 = st(1) })"#);
	assert_eq!(seen[0], json!({ "route": "skip", "at": 2, "asked": false, "s1": "skipped" }), "a character Polestar had seen: Skip, no surprise stop");
	let ask = run(char("ask"), r#"emit({ route = Polestar.Get("behavior.dungeons"), at = at(), asked = asked(), wants = E.WantsQuest("accept", 214) })"#);
	assert_eq!(
		ask[0],
		json!({ "route": "ask", "at": 1, "asked": { "map": 36, "name": "The Deadmines", "quests": 2, "runIn": 4 }, "wants": false }),
		"Ask me: the route holds at the pick-up and automation leaves the quest alone"
	);
}

#[test]
fn dungeon_route_ask_answered_run_keeps_the_pick_up_answered_skip_goes_on_and_is_remembered() {
	let out = run(
		char("ask"),
		r#"
		emit({ at = at(), asked = asked() ~= false })
		E.ChooseDungeon(36, true); flush(); mark()
		emit({ at = at(), asked = asked(), wants = E.WantsQuest("accept", 214), trace = trace })"#,
	);
	assert_eq!(out[0], json!({ "at": 1, "asked": true }));
	assert_eq!(out[1], json!({ "at": 1, "asked": false, "wants": true, "trace": [1, 1] }));
	let skip = run(
		char("ask"),
		r#"
		E.ChooseDungeon(36, false); flush(); mark()
		emit({ at = at(), asked = asked(), s1 = st(1), s4 = st(4), trace = trace })
		stub.fire("PLAYER_LOGOUT"); emit(PolestarCharDB.dungeons)"#,
	);
	assert_eq!(skip[0], json!({ "at": 2, "asked": false, "s1": "skipped", "s4": "na", "trace": [1, 2] }));
	assert_eq!(skip[1], json!({ "36": false }), "the answer is per dungeon and per character");
}

#[test]
fn dungeon_route_run_picks_up_says_when_to_look_for_a_group_and_reaches_the_run() {
	let out = run(
		char("run"),
		r#"
		emit({ at = at(), asked = asked() })
		take(214); take(7)
		local soon = E.DungeonSoon()
		emit({ at = at(), soon = soon and { map = soon.map, steps = soon.steps } or false, run = E.DungeonRun() or false })
		take(15); take(167)
		local r = E.DungeonRun()
		emit({ at = at(), run = r and r.map or false, soon = E.DungeonSoon() or false, trace = trace })"#,
	);
	assert_eq!(out[0], json!({ "at": 1, "asked": false }));
	assert_eq!(out[1], json!({ "at": 3, "soon": { "map": 36, "steps": 2 }, "run": false }), "the run is two open steps ahead");
	assert_eq!(out[2], json!({ "at": 5, "run": 36, "soon": false, "trace": [1, 2, 3, 4, 5] }));
}

#[test]
fn dungeon_route_skip_keeps_to_the_solo_route_an_answer_for_one_dungeon_wins() {
	let out = run(char("skip"), r#"take(7); take(15); emit({ at = at(), s1 = st(1), s4 = st(4), s5 = st(5), asked = asked(), soon = E.DungeonSoon() or false })"#);
	assert_eq!(out[0], json!({ "at": 7, "s1": "skipped", "s4": "skipped", "s5": "skipped", "asked": false, "soon": false }));
	let one = run(Some(json!({ "schema": 1, "guide": "test/route", "_route": "skip", "dungeons": { "36": true } })), "emit(at())");
	assert_eq!(one[0], 1);
}

// DESIGN §4: opting in mid-guide never moves the live step back nor re-opens a passed pick-up; the run's own stop
// offers the pick-ups again and the run is guarded. Opting in after the run's stop changes nothing. Opting out
// after the pick-ups drops the run; the quest stays in the log and its hand-in passes.
#[test]
fn dungeon_route_mid_guide_opt_in_and_out_never_moves_the_live_step_back() {
	let before_run = run(
		char("skip"),
		r#"
		take(7)
		local before = aim()
		Polestar.Set("behavior.dungeons", "run"); flush(); mark()
		emit({ at = at(), s1 = st(1), s4 = st(4), s5 = st(5), arrow = aim(), before = before })
		take(15); take(214); take(167)
		emit({ at = at(), run = E.DungeonRun() and true or false, trace = trace })"#,
	);
	assert_eq!(before_run[0]["at"], 3, "the live step stays");
	assert_eq!(before_run[0]["s1"], "skipped", "the passed pick-up stays passed");
	assert_eq!(before_run[0]["s4"], "upcoming", "the run's own stop offers the pick-ups");
	assert_eq!(before_run[0]["s5"], "na", "no quest of it held: no trip to the door");
	assert_eq!(before_run[0]["arrow"], before_run[0]["before"], "the arrow keeps its target");
	assert_ne!(before_run[0]["arrow"], false, "the arrow has a target");
	assert_eq!(before_run[1]["at"], 5);
	assert_eq!(before_run[1]["run"], true);
	non_decreasing(&before_run[1]["trace"]);

	let after_run = run(char("skip"), r#"take(7); take(15); Polestar.Set("behavior.dungeons", "run"); flush(); mark(); emit({ at = at(), s4 = st(4), s5 = st(5), trace = trace })"#);
	assert_eq!(after_run[0]["at"], 7, "after the run's stop nothing changes");
	assert_eq!(after_run[0]["s4"], "skipped");
	assert_eq!(after_run[0]["s5"], "skipped");
	non_decreasing(&after_run[0]["trace"]);

	let out = run(
		char("run"),
		r#"
		take(214); take(7)
		Polestar.Set("behavior.dungeons", "skip"); flush(); mark()
		emit({ at = at() })
		take(15)
		emit({ at = at(), s4 = st(4), s5 = st(5), s6 = st(6), kept = w.log[214] ~= nil, trace = trace })"#,
	);
	assert_eq!(out[0], json!({ "at": 3 }));
	assert_eq!(out[1], json!({ "at": 7, "s4": "skipped", "s5": "skipped", "s6": "skipped", "kept": true, "trace": [1, 2, 3, 3, 7] }));
}

#[test]
fn dungeon_route_no_group_skip_it_at_the_run_goes_on_with_the_solo_route_and_keeps_the_quests() {
	let out = run(
		char("run"),
		r#"
		take(214); take(7); take(15); take(167)
		emit({ at = at(), run = E.DungeonRun() and E.DungeonRun().map or false })
		local kept = E.SkipDungeon(36); flush(); mark()
		emit({ kept = kept, at = at(), run = E.DungeonRun() or false, s5 = st(5), s6 = st(6), log = { w.log[214] ~= nil, w.log[167] ~= nil }, trace = trace })
		stub.fire("PLAYER_LOGOUT")
		emit({ dungeons = PolestarCharDB.dungeons, route = Polestar.Get("behavior.dungeons"), skipped = PolestarCharDB.skipped["test/route"] })"#,
	);
	assert_eq!(out[0], json!({ "at": 5, "run": 36 }));
	assert_eq!(out[1], json!({ "kept": ["Oh Brother. . .", "Red Silk Bandanas"], "at": 7, "run": false, "s5": "skipped", "s6": "skipped", "log": [true, true], "trace": [1, 2, 3, 4, 5, 7] }));
	assert_eq!(out[2]["dungeons"], json!({ "36": false }), "answered Skip for this dungeon only");
	assert_eq!(out[2]["route"], "run", "the answer for every dungeon stays");
	assert_eq!(out[2]["skipped"], json!({ "5": true, "6": true }), "the run and its hand-in are passed, nothing stranded");
}

// Skip is the default, so a Skip player's step numbers and totals must stay those of the guide without the dungeon
// (Own.numbersOf, Own.dungeonHidden): the Deadmines' steps (1, 4, 5, 6) have no number; Run gives them theirs at
// once (the numbers are counted again on every answer), and Skip for that one dungeon takes them away again.
#[test]
fn dungeon_route_steps_of_a_skipped_dungeon_have_no_number_so_the_totals_stay_the_solo_routes() {
	let out = run(
		char("skip"),
		r#"
		local n1, h1 = E.StepNumber(1)
		emit({ total = E.StepTotal(), n1 = n1, h1 = h1, n2 = E.StepNumber(2), n7 = E.StepNumber(7) })
		Polestar.Set("behavior.dungeons", "run"); flush()
		local r1, rh1 = E.StepNumber(1)
		emit({ total = E.StepTotal(), n1 = r1, h1 = rh1, n2 = E.StepNumber(2), n7 = E.StepNumber(7) })
		E.ChooseDungeon(36, false); flush()
		emit({ total = E.StepTotal(), n7 = E.StepNumber(7) })"#,
	);
	assert_eq!(out[0], json!({ "total": 3, "n1": 1, "h1": true, "n2": 1, "n7": 3 }), "Skip: the solo route's numbers");
	assert_eq!(out[1], json!({ "total": 7, "n1": 1, "h1": false, "n2": 2, "n7": 7 }), "Run: every step counts");
	assert_eq!(out[2], json!({ "total": 3, "n7": 3 }), "Skip for that dungeon: its steps lose their numbers again");
}

// A stop the solo route shares with the dungeon (Loch Modan's Sentinel Hill, after the traitor's escort): the
// dungeon's step hands in the prerequisite and takes the dungeon's quest, the solo way is behind `when !dungeon`.
// The question comes when the escort is done and the route reaches that stop, not before. Ask: the route holds at
// the dungeon's step and asks, though its accept waits for that hand-in (the step hands it in itself), with no
// loop while it is judged; Skip: only the solo step applies and counts; Run: only the dungeon's.
#[test]
fn dungeon_route_a_stop_shared_with_the_solo_route_asks_before_the_prerequisite_is_handed_in() {
	let saved = |route: &str| Some(json!({ "schema": 1, "guide": "test/shared", "_route": route }));
	let script = r#"emit({ at = at(), asked = asked() })
		w.finish(155); flush()
		emit({ at = at(), asked = asked(), total = E.StepTotal(), s2 = st(2), s3 = st(3) })"#;
	let escort = "w.onQuest(155, { 1 })";
	let ask = run_with(escort, saved("ask"), script);
	assert_eq!(ask[0], json!({ "at": 1, "asked": false }), "the escort first: nothing is asked before the stop");
	assert_eq!(ask[1]["at"], 2, "Ask: the route holds at the dungeon's step");
	assert_eq!(ask[1]["asked"]["map"], 36);
	assert_eq!(ask[1]["total"], 4, "not answered: every step keeps its number");
	let skip = run_with(escort, saved("skip"), script);
	assert_eq!(skip[1], json!({ "at": 3, "asked": false, "total": 3, "s2": "skipped", "s3": "current" }));
	let go = run_with(escort, saved("run"), script);
	assert_eq!(go[1], json!({ "at": 2, "asked": false, "total": 3, "s2": "current", "s3": "na" }));
}

/// Fitz, 2026-11-13: never send a player to a dungeon too low. A dungeon's steps carry its floor (`when
/// level>=`, a point inside a level allowed): below it a pick-up doesn't apply and Ask doesn't ask, and the run
/// is passed for the solo route, in Run mode too (Own.dungeonOpenNow reads the step's own conditions first).
#[test]
fn dungeon_route_a_level_gate_holds_back_the_pick_up_the_question_and_the_run() {
	let saved = |route: &str| Some(json!({ "schema": 1, "guide": "test/gated", "_route": route }));
	let low = run(saved("ask"), "emit({ at = at(), asked = asked(), s1 = st(1) })");
	assert_eq!(low[0], json!({ "at": 2, "asked": false, "s1": "skipped" }), "level 10 under the pick-up's 12: nothing asked, the solo step is live");
	let at_gate = run_with("w.setLevel(12)", saved("ask"), "emit({ at = at(), asked = asked() })");
	assert_eq!(at_gate[0]["at"], 1, "at the gate the pick-up holds the route");
	assert_eq!(at_gate[0]["asked"]["map"], 36, "and asks");
	let run_low = run_with("w.setLevel(13); w.setXP(100, 1000); w.onQuest(214, { 1 })", saved("run"), r#"take(7); emit({ at = at(), s3 = st(3) })"#);
	assert_eq!(run_low[0], json!({ "at": 4, "s3": "skipped" }), "Run mode, 13.1 under the run's 13.5: the run is passed for the solo route");
	let run_at = run_with("w.setLevel(13); w.setXP(600, 1000); w.onQuest(214, { 1 })", saved("run"), r#"take(7); emit({ at = at(), s3 = st(3) })"#);
	assert_eq!(run_at[0], json!({ "at": 3, "s3": "current" }), "13.6: the run applies");
}

// Fitz, 2026-11-14: a city dungeon is its faction's only (Engine.EnemyCityDungeon). The stub's Human Warrior
// (Alliance) on a guide with Ragefire Chasm's steps (Orgrimmar's): on Run them nothing of it applies, on Ask me
// nothing is asked, Run it for it is refused and Dungeons in my route never lists it; the Stockade (Stormwind's)
// is the Alliance's own.
#[test]
fn dungeon_route_a_city_dungeon_of_the_other_faction_is_never_run_asked_listed_or_offered() {
	let saved = |route: &str| Some(json!({ "schema": 1, "guide": "test/city", "_route": route }));
	let script = r#"
		local before = { at = at(), asked = asked(), answer = E.DungeonAnswer(389),
			listed = E.GuideDungeons()[389] or false, enemy = E.EnemyCityDungeon(389), own = E.EnemyCityDungeon(34), key = E.EnemyCityDungeon("ragefire-chasm") }
		E.ChooseDungeon(389, true); flush()
		emit({ before = before, chosen = E.DungeonChosen(389), at = at() })"#;
	let run_them = run(saved("run"), script);
	assert_eq!(
		run_them[0]["before"],
		json!({ "at": 3, "asked": false, "answer": false, "listed": false, "enemy": true, "own": false, "key": true }),
		"Run them: none of Ragefire Chasm's steps applies, nothing is asked or listed"
	);
	assert_eq!((run_them[0]["chosen"].clone(), run_them[0]["at"].clone()), (json!(false), json!(3)), "Run it for it is refused");
	let ask = run(saved("ask"), "emit({ at = at(), asked = asked() })");
	assert_eq!(ask[0], json!({ "at": 3, "asked": false }), "Ask me never asks about it");
}

// Held back (the switch off, as it ships): Run them saved for every dungeon and Run it for the Deadmines, yet the
// route is the solo route's (steps 2, 3 and 7, numbered 1 to 3), nothing asks, no run comes, automation leaves the
// dungeon's quests alone, no dungeon is listed for the settings, a choice changes nothing, and the saved answers are
// kept as they were, for the release that turns it on.
#[test]
fn held_back_every_dungeon_reads_skip_whatever_is_saved_the_route_is_the_solo_routes_and_the_answers_are_kept() {
	let saved = Some(json!({ "schema": 1, "guide": "test/route", "_route": "run", "dungeons": { "36": true } }));
	let out = run_switch(
		false,
		"",
		saved,
		r#"
		local n1, h1 = E.StepNumber(1)
		emit({ on = Polestar.dungeonRoute, routeOn = E.DungeonRouteOn(), route = Polestar.Get("behavior.dungeons"), at = at(), asked = asked(),
			answer = E.DungeonAnswer(36), chosen = E.DungeonChosen(36), listed = next(E.GuideDungeons()) or false, total = E.StepTotal(),
			n1 = n1, h1 = h1, n7 = E.StepNumber(7), wants = E.WantsQuest("accept", 214), s1 = st(1) })
		E.ChooseDungeon(36, false); flush()
		take(7)
		emit({ at = at(), soon = E.DungeonSoon() or false, run = E.DungeonRun() or false })
		take(15)
		emit({ at = at(), s4 = st(4), s5 = st(5), s6 = st(6), trace = trace })
		stub.fire("PLAYER_LOGOUT")
		emit({ route = PolestarDB.settings.behavior.dungeons, dungeons = PolestarCharDB.dungeons })"#,
	);
	assert_eq!(
		out[0],
		json!({ "on": false, "routeOn": false, "route": "run", "at": 2, "asked": false, "answer": false, "chosen": false, "listed": false,
			"total": 3, "n1": 1, "h1": true, "n7": 3, "wants": false, "s1": "skipped" }),
		"the solo route's first step and numbers"
	);
	assert_eq!(out[1], json!({ "at": 3, "soon": false, "run": false }));
	assert_eq!(out[2], json!({ "at": 7, "s4": "skipped", "s5": "skipped", "s6": "skipped", "trace": [2, 3, 7] }));
	assert_eq!(out[3], json!({ "route": "run", "dungeons": { "36": true } }), "the saved answers are kept, the choice wrote nothing");
}

// Held back, Ask me saved: nothing asks at the stop shared with the solo route; the solo way applies, as Skip.
#[test]
fn held_back_ask_me_saved_never_asks_and_a_shared_stop_takes_the_solo_way() {
	let saved = Some(json!({ "schema": 1, "guide": "test/shared", "_route": "ask" }));
	let out = run_switch(
		false,
		"w.onQuest(155, { 1 })",
		saved,
		r#"w.finish(155); flush()
		emit({ at = at(), asked = asked(), total = E.StepTotal(), s2 = st(2), s3 = st(3) })"#,
	);
	assert_eq!(out[0], json!({ "at": 3, "asked": false, "total": 3, "s2": "skipped", "s3": "current" }));
}
