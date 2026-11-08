//! What a list of quests is worth in levels (addon/Polestar/Core/Levels.lua): the quests still to do in turn-in
//! order, with the client's reduction for quests far below, against the tools' own XP rules
//! (tools/lib/game/xp.js); and a guide's turn-ins for this character, their XP from the Codex.
//! ui-dungeons.rs and ui-picker-levels.rs cover the chips and their tooltip.

use forge_addontest::{emitted, lua_value, truthy, Addon, RunAddon};
use forge_guide::xp::{mob_xp, quest_xp_share, LEVEL_XP, MAX_LEVEL};
use serde_json::{json, Value};

const FILES: &[&str] = &["Core/Core.xml"];

fn lua(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec![Addon::files("Polestar", FILES)], script: format!("stub.login()\nlocal Lv = Polestar.Levels\n{script}"), ..Default::default() })
}

// quests: { id, level, xp (null: none known), classes } in turn-in order; done: the ids done.
fn run(player: Value, quests: Value, done: &[i64]) -> Value {
	let script = format!(
		"local done = {{}}\nfor _, id in ipairs({}) do done[id] = true end\nPolestar.Compat.IsQuestCompleted = function(id) return done[id] or false end\nemit(Lv.Run({}, {}))",
		lua_value(&json!(done)),
		lua_value(&quests),
		lua_value(&player)
	);
	lua(&script).remove(0)
}

/// A number as the Lua side emits it: integral values as integers.
fn num(f: f64) -> Value {
	if f.fract() == 0.0 {
		json!(f as i64)
	} else {
		json!(f)
	}
}

#[test]
fn the_level_table_and_the_reduction_are_the_tools_own() {
	let out = lua(r#"local shares = {}
for p = 1, 60 do for q = 1, 60 do shares[#shares + 1] = Lv.Share(p, q) end end
emit({ table = Lv.LEVEL_XP, max = Lv.MAX_LEVEL, shares = shares })"#)
	.remove(0);
	let table: Vec<Value> = LEVEL_XP[1..].iter().map(|&x| num(x)).collect();
	assert_eq!(out["table"], Value::Array(table), "Levels.LEVEL_XP is tools/lib/game/xp.js LEVEL_XP");
	assert_eq!(out["max"], json!(MAX_LEVEL));
	let mut shares = Vec::new();
	for p in 1..=60 {
		for q in 1..=60 {
			shares.push(num(quest_xp_share(p as f64, q as f64)));
		}
	}
	assert_eq!(out["shares"], Value::Array(shares));
}

#[test]
fn quests_in_turn_in_order_carry_the_character_over_a_level_the_client_s_xp_to_level_counts_for_the_level_it_is_at() {
	let s = run(
		json!({ "level": 20, "xp": 19800, "xpMax": 23000, "class": "DRUID", "faction": "Horde" }),
		json!([
			{ "id": 1, "level": 18, "xp": 2000 },
			{ "id": 2, "level": 22, "xp": 2400 }
		]),
		&[],
	);
	assert_eq!(s["quests"], 2);
	assert_eq!(s["xp"], 4400);
	assert_eq!(s["from"], json!({ "level": 20, "xp": 19800, "need": 23000 }));
	// 19,800 + 4,400 = 24,200: 23,000 (the client's) to 21, 1,200 into 21 of 25,200.
	assert_eq!(s["to"], json!({ "level": 21, "xp": 1200, "need": 25200 }));
	assert!((s["levels"].as_f64().unwrap() - (21.0 + 1200.0 / 25200.0 - (20.0 + 19800.0 / 23000.0))).abs() < 1e-9);
	assert_eq!(s["maxed"], false);
}

#[test]
fn a_quest_far_below_gives_its_share_at_the_level_reached_when_it_is_turned_in() {
	// At 26 the level 17 quest is 9 below: 20%. The level 20 one is 6 below: 80%.
	let s = run(
		json!({ "level": 26, "xp": 0, "class": "MAGE", "faction": "Alliance" }),
		json!([
			{ "id": 1, "level": 17, "xp": 1000 },
			{ "id": 2, "level": 20, "xp": 1000 },
			{ "id": 3, "level": 25, "xp": 1000 }
		]),
		&[],
	);
	assert_eq!(s["xp"], 200 + 800 + 1000);
	assert_eq!(s["reduced"], 2);
	assert_eq!(s["quests"], 3);
	// The order counts: a level gained on the way reduces what comes after.
	let late = run(
		json!({ "level": 25, "xp": 36000, "class": "MAGE", "faction": "Alliance" }),
		json!([
			{ "id": 1, "level": 25, "xp": 1000 },
			{ "id": 2, "level": 20, "xp": 1000 }
		]),
		&[],
	);
	assert_eq!(late["to"]["level"], 26);
	assert_eq!(late["xp"], 1000 + 800, "turned in at 26, the level 20 quest is 6 below");
}

#[test]
fn done_quests_another_class_s_and_those_with_no_xp_known_are_left_out_and_counted_apart() {
	let s = run(
		json!({ "level": 20, "xp": 0, "class": "DRUID", "faction": "Horde" }),
		json!([
			{ "id": 1, "level": 20, "xp": 1000 },
			{ "id": 2, "level": 20, "xp": 1000 },
			{ "id": 3, "level": 20, "xp": 1000, "classes": ["WARRIOR"] },
			{ "id": 4, "level": 20, "xp": null }
		]),
		&[2],
	);
	assert_eq!(s["xp"], 1000);
	assert_eq!(json!([s["quests"], s["done"], s["other"], s["unknown"]]), json!([1, 1, 1, 1]));
}

#[test]
fn at_60_nothing_counts_the_summary_says_maxed_the_xp_stops_at_60() {
	let s = run(json!({ "level": 60, "xp": 0, "class": "DRUID", "faction": "Horde" }), json!([{ "id": 1, "level": 58, "xp": 9000 }]), &[]);
	assert_eq!(s["maxed"], true);
	assert_eq!(s["xp"], 0);
	assert_eq!(s["levels"], 0);
	let last = run(json!({ "level": 59, "xp": 209000, "class": "DRUID", "faction": "Horde" }), json!([{ "id": 1, "level": 59, "xp": 9000 }]), &[]);
	assert_eq!(last["to"]["level"], 60);
	assert_eq!(last["to"]["xp"], 0);
}

// A guide of turn-ins, some for one race or class only, one quest twice; the Codex gives each quest's level and
// XP (9 none known).
const GUIDE: &str = r#"
local guide = { id = "sample", steps = {
	{ goals = { { t = "accept", quest = 1 }, { t = "turnin", quest = 1 }, { t = "turnin", quest = 2, only = { races = { "Tauren" } } } } },
	{ only = { classes = { "WARRIOR" } }, goals = { { t = "turnin", quest = 3 } } },
	{ goals = { { t = "turnin", quest = 4 }, { t = "turnin", quest = 1 }, { t = "turnin", quest = 9 } } },
} }
Polestar.Guides.Get = function(id) return id == "sample" and guide or nil end
local CODEX = { [1] = { level = 10, xp = 1000 }, [2] = { level = 10, xp = 2000 }, [3] = { level = 10, xp = 4000 }, [4] = { level = 12, xp = 500 }, [9] = { level = 12 } }
Polestar.Codex = { IsLoaded = function() return true end, Load = function() return true end, Quest = function(id) return CODEX[id] end }
"#;

#[test]
fn a_guide_its_turn_ins_for_this_character_in_route_order_each_once_the_xp_from_the_codex() {
	let out = lua(&[
		GUIDE,
		r#"local function p(race, class) return { level = 10, xp = 0, class = class, race = race, faction = "Horde" } end
local function brief(s) return s and { xp = s.xp, quests = s.quests, unknown = s.unknown, to = s.to.level } or false end
emit(brief(Lv.ForGuide("sample", p("Orc", "SHAMAN"))))
emit(brief(Lv.ForGuide("sample", p("Tauren", "DRUID"))))
emit(brief(Lv.ForGuide("sample", p("Orc", "WARRIOR"))))
emit(Lv.ForGuide("nowhere", p("Orc", "SHAMAN")) == nil)
Polestar.Codex.IsLoaded = function() return false end
Polestar.Codex.Load = function() return false, "missing" end
emit(Lv.ForGuide("sample", p("Orc", "SHAMAN")) == nil)"#,
	]
	.join("\n"));
	let (orc, tauren, warrior, none, no_codex) = (&out[0], &out[1], &out[2], &out[3], &out[4]);
	assert_eq!(*orc, json!({ "xp": 1500, "quests": 2, "unknown": 1, "to": 10 }));
	assert_eq!(*tauren, json!({ "xp": 3500, "quests": 3, "unknown": 1, "to": 10 }), "the Tauren-only turn-in counts for a Tauren");
	assert_eq!(*warrior, json!({ "xp": 5500, "quests": 3, "unknown": 1, "to": 10 }), "the Warrior step counts for a Warrior");
	assert_eq!(*none, true, "an unknown guide has no summary");
	assert_eq!(*no_codex, true, "without the Codex there is nothing to count");
}

#[test]
fn a_kill_is_worth_what_the_tools_say_every_player_level_mob_level_and_elite() {
	let got = lua(r#"local out = {}
for p = 1, 60 do for m = 1, 63 do out[#out + 1] = Lv.MobXP(p, m, false); out[#out + 1] = Lv.MobXP(p, m, true) end end
emit(out)"#)
	.remove(0);
	let mut want = Vec::new();
	for p in 1..=60 {
		for m in 1..=63 {
			want.push(num(mob_xp(p as f64, m as f64, false, false)));
			want.push(num(mob_xp(p as f64, m as f64, true, false)));
		}
	}
	assert_eq!(got, Value::Array(want));
}

#[test]
fn kills_in_route_order_each_at_the_level_reached_nothing_for_grey_mobs_summed_apart_from_the_quests() {
	// At 10, 380 of 7,600: a level 10 mob is 95 a kill; a level 3 mob is grey.
	let s = run(
		json!({ "level": 10, "xp": 7400, "class": "MAGE", "faction": "Alliance" }),
		json!([
			{ "kind": "kill", "n": 2, "mob": 10 },
			{ "kind": "kill", "n": 1, "mob": 3 },
			{ "id": 1, "level": 10, "xp": 500 },
			{ "kind": "kill" }
		]),
		&[],
	);
	// 7,400 + 95 + 95 = 7,590; then 500: 7,600 to 11, 490 in.
	assert_eq!(json!([s["kills"], s["killXP"], s["questXP"], s["xp"], s["killsUnknown"]]), json!([3, 190, 500, 690, 1]));
	assert_eq!(s["to"], json!({ "level": 11, "xp": 490, "need": 8800 }));
	// A level gained on the way: the level 10 mob is worth less at 11.
	let up = run(json!({ "level": 10, "xp": 7550, "class": "MAGE", "faction": "Alliance" }), json!([{ "kind": "kill", "n": 2, "mob": 10 }]), &[]);
	assert_eq!(up["killXP"], 95.0 + (100.0 * (1.0 - 1.0 / 7.0_f64)).round());
}

#[test]
fn below_the_start_level_the_sums_run_from_it_at_none_of_its_xp_the_character_is_kept_as_now() {
	let s = run(json!({ "level": 8, "xp": 300, "xpMax": 5400, "class": "MAGE", "faction": "Alliance" }), json!([{ "id": 1, "level": 12, "xp": 1000 }]), &[]);
	assert!(s["below"].is_null(), "no start given: from where the character is");
	let b = lua(r#"emit(Lv.Run({ { id = 1, level = 12, xp = 1000 } }, { level = 8, xp = 300, xpMax = 5400, class = "MAGE" }, 12))"#).remove(0);
	assert_eq!(b["below"], 12);
	assert_eq!(b["now"], json!({ "level": 8, "xp": 300, "need": 5400 }));
	assert_eq!(b["from"], json!({ "level": 12, "xp": 0, "need": 10100 }));
	assert_eq!(b["to"], json!({ "level": 12, "xp": 1000, "need": 10100 }));
	let same = lua(r#"emit(Lv.Run({}, { level = 12, xp = 50, class = "MAGE" }, 12).below == nil)"#).remove(0);
	assert_eq!(same, true, "at the start level: not below");
	assert!(truthy(&same));
}

// A guide of kill and loot goals: an objective split over two steps, a done quest's objective, loot from its own
// mob, loot also picked up from an object, a mob the Codex does not know.
const KILLS: &str = r#"
local guide = { id = "hunt", minLevel = 10, steps = {
	{ goals = { { t = "kill", quest = 20, oi = 1, npc = 100, count = 4 } } },
	{ goals = { { t = "kill", quest = 20, oi = 1, npc = 100, count = 4 }, { t = "kill", quest = 21, oi = 1, npc = 100, count = 5 } } },
	{ goals = { { t = "collect", quest = 22, oi = 1, item = 500, count = 3, fromKind = "npc", fromId = 101 } } },
	{ goals = { { t = "collect", quest = 23, oi = 1, item = 501, count = 6 } } },
	{ goals = { { t = "kill", quest = 24, oi = 1, npc = 999, count = 2 } } },
} }
Polestar.Guides.Get = function(id) return id == "hunt" and guide or nil end
local NPCS = { [100] = { level = 10, levelMax = 12 }, [101] = { level = 10, elite = true }, [102] = { level = 10 } }
local ITEMS = {
	[500] = { sources = { { type = "drop", npc = 102, chance = 90 }, { type = "drop", npc = 101, chance = 50 } } },
	[501] = { sources = { { type = "drop", npc = 102, chance = 50 }, { type = "object", object = 7 } } },
}
Polestar.Codex = { IsLoaded = function() return true end, Quest = function() return nil end,
	Npc = function(id) return NPCS[id] end, Item = function(id) return ITEMS[id] end }
Polestar.Compat.IsQuestCompleted = function(id) return id == 21 end
"#;

#[test]
fn a_guide_s_kills_kill_goals_and_loot_from_mobs_an_objective_once_none_for_done_quests_or_gathered_loot() {
	let s = lua(&[KILLS, r#"emit(Lv.ForGuide("hunt", { level = 10, xp = 0, class = "MAGE", race = "Human", faction = "Alliance" }))"#].join("\n")).remove(0);
	// Quest 20: 4 kills of the level 11 mob (10-12) once; quest 21 done; quest 22: 3 / 50% = 6 kills of its own
	// elite mob; 23 is also an object: none; mob 999 unknown.
	assert_eq!(s["kills"], 4 + 6);
	assert_eq!(s["killsUnknown"], 1);
	assert!(s["below"].is_null());
	let at10 = |mob: f64, elite: bool| mob_xp(10.0, mob, elite, false);
	assert_eq!(s["killXP"], 4.0 * at10(11.0, false) + 6.0 * at10(10.0, true));
	let low = lua(&[
		KILLS,
		r#"local s = Lv.ForGuide("hunt", { level = 7, xp = 100, class = "MAGE", race = "Human", faction = "Alliance" })
emit({ below = s.below, from = s.from.level, now = s.now.level })"#,
	]
	.join("\n"))
	.remove(0);
	assert_eq!(low, json!({ "below": 10, "from": 10, "now": 7 }), "below the guide's minLevel: from there");
}

#[test]
fn pace_the_route_from_the_live_step_to_the_next_level_target_says_how_many_bars_short_or_on_pace() {
	let out = lua(&[
		GUIDE,
		r#"local E = Polestar.Engine
local target, frac = 11, nil
E.GetGuide = function() return { id = "sample" } end
E.GetLiveStep = function() return 1 end
E.LevelTarget = function() return target, 3, frac end
local p = { level = 10, xp = 0, xpMax = 2000, class = "SHAMAN", race = "Orc", faction = "Horde" }
local short = Lv.Pace(p)
target, frac = 10, 0.4
local onPace = Lv.Pace(p)
E.LevelTarget = function() return nil end
emit({ short = short, onPace = onPace, none = Lv.Pace(p) == nil })"#,
	]
	.join("\n"));
	// Steps 1 and 2 for an Orc Shaman: quest 1's 1000 XP of the 2000 to level, so level 10.5 by step 3.
	let short = &out[0]["short"];
	assert_eq!(json!([short["target"], short["step"], short["reach"], short["bars"], short["kind"]]), json!([11, 3, 10.5, 10, "goal"]));
	assert_eq!(short["xp"], 1000, "half of the 2000 to level 11");
	assert_eq!(out[0]["onPace"]["bars"], 0, "a target of 10.4 is met");
	assert_eq!(out[0]["none"], true);
}

// A Redridge-shaped leveling guide (levels 20-24, no `level` goal of its own) for a level 19 character three quarters
// of the way to 20: two quests at 20 and 21, then a level 25 escort (accept and complete) and its hand-in. The
// guide's accepts carry their quest levels (`qlvl`); the Codex the XP.
const RIDGE: &str = r#"
local guide = { id = "ridge", category = "Leveling", minLevel = 20, maxLevel = 24, steps = {
	{ goals = { { t = "accept", quest = 11, qlvl = 20 }, { t = "turnin", quest = 11 } } },
	{ goals = { { t = "accept", quest = 12, qlvl = 21 } } },
	{ goals = { { t = "turnin", quest = 12 } } },
	{ goals = { { t = "accept", quest = 25, qlvl = 25, title = "Missing In Action" }, { t = "complete", quest = 25, title = "Missing In Action" } } },
	{ goals = { { t = "turnin", quest = 25 } } },
} }
Polestar.Guides.Get = function(id) return id == "ridge" and guide or nil end
local CODEX = { [11] = { level = 20, xp = 2000 }, [12] = { level = 21, xp = 2500 }, [25] = { level = 25, xp = 3000 } }
Polestar.Codex = { IsLoaded = function() return true end, Load = function() return true end, Quest = function(id) return CODEX[id] end }
local E = Polestar.Engine
local target, frac
E.GetGuide = function() return guide end
E.GetLiveStep = function() return 1 end
E.LevelTarget = function() if target then return target, 4, frac end end
E.Applies = function() return true end
E.StepNumber = function(i) return i, false end
local done = {}
Polestar.Compat.IsQuestCompleted = function(id) return done[id] or false end
local p = { level = 19, xp = 14550, xpMax = 19400, class = "WARRIOR", race = "Human", faction = "Alliance" }
"#;

/// Levels 19 to `to`, from 19,050 of 19,400 into 19: what is left of 19, then each whole level's XP.
fn xp_from_19_050(to: usize) -> i64 {
	(19400 - 19050) + (20..to).map(|l| LEVEL_XP[l] as i64).sum::<i64>()
}

#[test]
fn pace_on_target_for_a_level_goal_ahead_nothing_hard_before_it() {
	// The guide holds you at step 4 until 19.9; steps 1-3's 4,500 XP take 19.75 to 19,050 of 19,400: 19.98.
	let out = lua(&[RIDGE, "target, frac = 19, 0.9\nemit(Lv.Pace(p))"].join("\n")).remove(0);
	assert_eq!(out["kind"], "goal");
	assert_eq!(out["bars"], 0, "on pace");
	assert_eq!(out["short"], 0);
	assert_eq!(out["xp"], 0);
	assert!(out["hard"].is_null(), "quests at 20 and 21 before step 4 are not hard for a level 19");
	assert!((out["reach"].as_f64().unwrap() - (19.0 + 19050.0 / 19400.0)).abs() < 1e-9);
}

#[test]
fn pace_behind_with_a_level_goal_coming_says_how_far_and_that_its_step_grinds_it() {
	let out = lua(&[RIDGE, "target = 21\nemit(Lv.Pace(p))"].join("\n")).remove(0);
	assert_eq!(out["kind"], "goal", "a `level` goal ahead: the guide grinds the gap at its step");
	assert_eq!(out["target"], 21);
	assert_eq!(out["step"], 4);
	assert_eq!(out["live"], 1);
	assert_eq!(out["bars"], 21, "1.02 levels short: 21 bars, rounded up");
	assert!((out["short"].as_f64().unwrap() - (21.0 - 19.0 - 19050.0 / 19400.0)).abs() < 1e-9);
	assert_eq!(out["xp"], xp_from_19_050(21));
	assert!(out["hard"].is_null());
}

#[test]
fn pace_behind_with_no_grind_step_measures_against_the_guide_s_end_level_and_names_the_quest_that_will_be_too_hard() {
	let out = lua(&[RIDGE, "emit(Lv.Pace(p))"].join("\n")).remove(0);
	// No `level` goal: the guide's own end, level 24 (its `levels` top) at its last step. All three quests'
	// 7,500 XP: 14,550 + 7,500 = 22,050, over the 19,400 of 19 into 20 by 2,650 of 23,200.
	assert_eq!(out["kind"], "end");
	assert_eq!(out["target"], 24);
	assert_eq!(out["step"], 5);
	let reach = 20.0 + 2650.0 / 23200.0;
	assert!((out["reach"].as_f64().unwrap() - reach).abs() < 1e-9);
	assert!((out["short"].as_f64().unwrap() - (24.0 - reach)).abs() < 1e-9);
	assert_eq!(out["xp"], (23200 - 2650) + LEVEL_XP[21] as i64 + LEVEL_XP[22] as i64 + LEVEL_XP[23] as i64);
	// Step 4's level 25 escort: the route has you at 19.98 there, 6 levels under it; 23 makes it doable.
	let hard = &out["hard"];
	assert_eq!(hard["quest"], 25);
	assert_eq!(hard["title"], "Missing In Action");
	assert_eq!(hard["level"], 25);
	assert_eq!(hard["step"], 4);
	assert_eq!(hard["need"], 23);
	assert_eq!(hard["xp"], xp_from_19_050(23));
	assert!((hard["reach"].as_f64().unwrap() - (19.0 + 19050.0 / 19400.0)).abs() < 1e-9);
	// Taken earlier (an accept alone at step 2): the line still points at step 4, which does it; step 2 hints.
	let early = lua(&[
		RIDGE,
		r#"table.insert(guide.steps[2].goals, { t = "accept", quest = 25, qlvl = 25, title = "Missing In Action" })
local s = Lv.Pace(p)
emit({ step = s.hard.step, hint = Lv.StepHint(2, p).level })"#,
	]
	.join("\n"))
	.remove(0);
	assert_eq!(early, json!({ "step": 4, "hint": 25 }));
	// Done already: nothing hard is left, the gap to 24 still shows.
	let left = lua(&[RIDGE, "done[25] = true\nlocal s = Lv.Pace(p)\nemit({ hard = s.hard == nil, kind = s.kind, bars = s.bars })"].join("\n")).remove(0);
	assert_eq!(left, json!({ "hard": true, "kind": "end", "bars": 81 }), "19.98 to 24: 4.02 levels, 81 bars");
	// Not a leveling guide, no `level` goal ahead: no target, no line.
	let other = lua(&[RIDGE, "guide.category = \"Professions\"\nemit(Lv.Pace(p) == nil)"].join("\n")).remove(0);
	assert_eq!(other, true);
}

#[test]
fn a_step_whose_quest_is_three_or_more_levels_over_the_character_says_so() {
	let out = lua(&[
		RIDGE,
		r#"emit({ escort = Lv.StepHint(4, p), two = Lv.StepHint(2, p) == nil, handIn = Lv.StepHint(5, p) == nil })
done[25] = true
emit(Lv.StepHint(4, p) == nil)"#,
	]
	.join("\n"));
	assert_eq!(out[0]["escort"]["level"], 25);
	assert_eq!(out[0]["escort"]["quest"], 25);
	assert_eq!(out[0]["escort"]["title"], "Missing In Action");
	assert_eq!(out[0]["escort"]["you"], 19.75);
	assert_eq!(out[0]["two"], true, "a level 21 quest is 2 over a level 19: no hint");
	assert_eq!(out[0]["handIn"], true, "handing a quest in is never hard");
	assert_eq!(out[1], true, "a done quest: no hint");
}

// #1333: Calling in the Reserves (level 28) is a delivery: taken at Sun Rock, handed in at the Great Lift. Its step
// said "Level 28 quest" in red to everyone. A quest with no work (no objective goal in the guide, none in the
// Codex) gives no hint; one taken here whose work the Codex lists (done in another guide) still does.
#[test]
fn a_delivery_s_level_gives_no_hint_a_quest_with_work_elsewhere_still_does_1333() {
	let out = lua(&[
		RIDGE,
		r#"table.insert(guide.steps[2].goals, { t = "accept", quest = 26, qlvl = 28, title = "Calling in the Reserves" })
table.insert(guide.steps[5].goals, { t = "turnin", quest = 26 })
table.insert(guide.steps[3].goals, { t = "accept", quest = 27, qlvl = 23, title = "Work Elsewhere" })
CODEX[26] = { level = 28, xp = 1000, objectives = {} }
CODEX[27] = { level = 23, xp = 1000, objectives = { { type = "monster", id = 1, count = 8 } } }
local d, w = Lv.StepHint(2, p), Lv.StepHint(3, p)
emit({ delivery = d and d.quest or false, elsewhere = w and w.quest or false, pace = Lv.Pace(p).hard.quest })"#,
	]
	.join("\n"))
	.remove(0);
	assert_eq!(out, json!({ "delivery": false, "elsewhere": 27, "pace": 25 }), "no hint for the delivery; the quest with work hints; the pace line still points at the escort");
}

#[test]
fn pace_at_or_past_the_guide_s_top_is_on_pace_and_reaches_beyond_it() {
	// Level 24 in the 20-24 guide (a Barrens 15-21 at 21): no `level` goal, the end target is the top the character
	// already has, so on pace; the route's XP takes it past 24, which the guide window shows (ui.rs).
	let out = lua(&[RIDGE, "p.level, p.xp, p.xpMax = 24, 0, 30000\nlocal s = Lv.Pace(p)\nemit({ kind = s.kind, target = s.target, bars = s.bars, past = s.reach > 24 })"].join("\n")).remove(0);
	assert_eq!(out, json!({ "kind": "end", "target": 24, "bars": 0, "past": true }));
}
