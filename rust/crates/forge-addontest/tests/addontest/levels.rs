//! What a list of quests is worth in levels (addon/Polestar/Core/Levels.lua): the quests still to do in turn-in
//! order, with the client's reduction for quests far below, against the tools' own XP rules
//! (tools/lib/game/xp.js); and a guide's turn-ins for this character, their XP from the Codex.
//! ui-dungeons.rs and ui-picker-levels.rs cover the chips and their tooltip.

use forge_addontest::run::{addons_dir, join};
use forge_addontest::{emitted, lua_value, truthy, Addon, RunAddon};
use forge_guide::xp::{mob_xp, quest_xp_share, LEVEL_XP, MAX_LEVEL};
use serde_json::{json, Value};
use std::path::{Path, PathBuf};

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
	// At 26 the level 17 quest is 9 below: half, Forever's floor from 8 below (players' recordings,
	// forge-sim's xp::SHARE test). The level 20 one is 6 below: 80%.
	let s = run(
		json!({ "level": 26, "xp": 0, "class": "MAGE", "faction": "Alliance" }),
		json!([
			{ "id": 1, "level": 17, "xp": 1000 },
			{ "id": 2, "level": 20, "xp": 1000 },
			{ "id": 3, "level": 25, "xp": 1000 }
		]),
		&[],
	);
	assert_eq!(s["xp"], 500 + 800 + 1000);
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

// A quest the character may not take by class or race (Dungeons.QuestFor's verdict, which reads the Codex
// masks the page greys it out by) is left out like another class's, not counted in the dungeon's XP.
#[test]
fn a_blocked_quest_is_left_out_like_another_class_s() {
	let s = run(
		json!({ "level": 20, "xp": 0, "class": "DRUID", "faction": "Horde" }),
		json!([
			{ "id": 1, "level": 20, "xp": 1000 },
			{ "id": 2, "level": 20, "xp": 1000, "blocked": true }
		]),
		&[],
	);
	assert_eq!(s["xp"], 1000);
	assert_eq!(json!([s["quests"], s["other"]]), json!([1, 1]));
}

#[test]
fn quests_named_a_group_are_summed_per_group_with_the_highest_min_level() {
	let s = run(
		json!({ "level": 20, "xp": 0, "class": "DRUID", "faction": "Horde" }),
		json!([
			{ "id": 1, "level": 20, "xp": 1000, "group": "ready" },
			{ "id": 2, "level": 22, "xp": 700, "group": "level", "minLevel": 21 },
			{ "id": 3, "level": 23, "xp": 800, "group": "level", "minLevel": 22 },
			{ "id": 4, "level": 20, "xp": null, "group": "ready" }
		]),
		&[],
	);
	assert_eq!(s["groups"], json!({ "ready": { "n": 1, "xp": 1000 }, "level": { "n": 2, "xp": 1500, "need": 22 } }));
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

// #1697: Surgical Spidersilk (12 for Silky Sutures) had one dropper at 0.01% (a quest's loot counted over every
// kill of the mob) beside the Plains Creepers, no chance known, that drop it on almost every kill: "120,188 kills
// the guide asks for", +12 levels on a 29-33 guide. A chance under 5% beside a dropper with none known counts as no
// chance known (no kills, as loot with no drop chance at all); alone, or with every dropper's chance known, it still
// counts; the goal's own mob's chance always does.
const STRAYS: &str = r#"
local guide = { id = "silk", minLevel = 30, steps = {
	{ goals = { { t = "collect", quest = 30, oi = 1, item = 600, count = 12 } } },
	{ goals = { { t = "collect", quest = 31, oi = 1, item = 601, count = 1 } } },
	{ goals = { { t = "collect", quest = 32, oi = 1, item = 602, count = 2 } } },
	{ goals = { { t = "collect", quest = 33, oi = 1, item = 603, count = 1, fromKind = "npc", fromId = 201 } } },
	{ goals = { { t = "collect", quest = 34, oi = 1, item = 604, count = 4 } } },
} }
Polestar.Guides.Get = function(id) return id == "silk" and guide or nil end
local NPCS = { [200] = { level = 30 }, [201] = { level = 30 }, [202] = { level = 30 } }
local ITEMS = {
	[600] = { sources = { { type = "drop", npc = 200, chance = 0.01 }, { type = "drop", npc = 201 } } },
	[601] = { sources = { { type = "drop", npc = 200, chance = 2 } } },
	[602] = { sources = { { type = "drop", npc = 200, chance = 4 }, { type = "drop", npc = 201, chance = 1 } } },
	[603] = { sources = { { type = "drop", npc = 202 }, { type = "drop", npc = 201, chance = 2 } } },
	[604] = { sources = { { type = "drop", npc = 202 }, { type = "drop", npc = 200, chance = 40 } } },
}
Polestar.Codex = { IsLoaded = function() return true end, Quest = function() return nil end,
	Npc = function(id) return NPCS[id] end, Item = function(id) return ITEMS[id] end }
"#;

#[test]
fn a_stray_drop_chance_beside_a_dropper_with_none_known_is_not_estimated_1697() {
	let s = lua(&[STRAYS, r#"emit(Lv.ForGuide("silk", { level = 30, xp = 0, class = "MAGE", race = "Orc", faction = "Horde" }))"#].join("\n")).remove(0);
	// 600: 0.01% beside 201 (none known): no kills, not 120,000. 601: 1 / 2% = 50, the only dropper. 602: 2 / 4% =
	// 50, every chance known. 603: 1 / 2% = 50, its own mob. 604: 4 / 40% = 10, not a stray.
	assert_eq!(s["killsUnknown"], 0);
	assert_eq!(s["kills"], 50 + 50 + 50 + 10);
}

// A step change moves every span's start (the pace line, its hard-quest look, While-here's planned levels): the
// steps' Codex records are read once per guide and character, and a span from any start sums the same as one
// worked out afresh. A quest done since still counts when the span is asked again.
#[test]
fn spans_from_a_later_start_read_no_codex_record_again_and_sum_as_a_fresh_one() {
	let out = lua(&[
		KILLS,
		r#"local reads = 0
local npc, item = Polestar.Codex.Npc, Polestar.Codex.Item
Polestar.Codex.Npc = function(id) reads = reads + 1; return npc(id) end
Polestar.Codex.Item = function(id) reads = reads + 1; return item(id) end
local p = { level = 10, xp = 0, class = "MAGE", race = "Human", faction = "Alliance" }
local function sum(s) return { s.kills, s.killXP, s.killsUnknown, s.to.level, s.to.xp } end
local first = sum(Lv.ForGuide("hunt", p, 1, nil))
local r1 = reads
local later = { sum(Lv.ForGuide("hunt", p, 2, nil)), sum(Lv.ForGuide("hunt", p, 3, 5)), sum(Lv.ForGuide("hunt", p, 1, 3)) }
local r2 = reads - r1
-- Quest 20 done now: the spans go (QUEST_TURNED_IN), the rows stay; and the same spans from nothing.
Polestar.Compat.IsQuestCompleted = function(id) return id == 21 or id == 20 end
stub.fire("QUEST_TURNED_IN", 20)
local again = sum(Lv.ForGuide("hunt", p, 1, nil))
local r3 = reads - r1 - r2
Polestar.Fire("CODEX_LOADED")
local fresh = { sum(Lv.ForGuide("hunt", p, 1, nil)) }
Polestar.Compat.IsQuestCompleted = function(id) return id == 21 end
Polestar.Fire("CODEX_LOADED")
for _, span in ipairs({ { 2 }, { 3, 5 }, { 1, 3 } }) do fresh[#fresh + 1] = sum(Lv.ForGuide("hunt", p, span[1], span[2])) end
emit({ first = first, reads = { r1, r2, r3 }, later = later, again = again, fresh = fresh })"#,
	]
	.join("\n"))
	.remove(0);
	assert!(out["reads"][0].as_i64().unwrap() > 0, "the first span reads the records: {out}");
	assert_eq!(out["reads"][1], 0, "later spans read none again: {out}");
	assert_eq!(out["reads"][2], 0, "a hand-in drops the sums, not the records: {out}");
	assert_eq!(out["fresh"][0], out["again"], "quest 20 done: its kills drop out, as in a fresh span");
	assert_eq!(out["fresh"][1], out["later"][0]);
	assert_eq!(out["fresh"][2], out["later"][1]);
	assert_eq!(out["fresh"][3], out["later"][2]);
	assert_ne!(out["again"], out["first"], "the hand-in changed the sums");
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

// The guide window asks for the pace line on every PLAYER_XP_UPDATE. The route's quests and kills only change with
// a turn-in, a level, or the guide itself: a kill's XP reruns the sums, not the scan of every step left. A turn-in or
// a level sums the route again from the records already read (each step's are kept until the guide or the Codex
// changes), and says what a fresh read says.
#[test]
fn pace_a_kill_s_xp_reruns_the_sums_a_turn_in_or_a_level_sums_again_from_the_records_read_once() {
	let out = lua(&[
		RIDGE,
		r#"local reads = 0
local quest = Polestar.Codex.Quest
Polestar.Codex.Quest = function(id) reads = reads + 1 return quest(id) end
local function line(s) return { s.reach, s.short, s.xp, s.hard and s.hard.quest or false } end
local first = Lv.Pace(p)
local scan = reads
p.xp = p.xp + 300
local kill0 = reads
local second = Lv.Pace(p)
local kill = reads - kill0
local before = reads
done[11] = true
stub.fire("QUEST_TURNED_IN", 11, 0, 0)
local afterTurnin = line(Lv.Pace(p))
local turnin = reads - before
before = reads
p.level, p.xp, p.xpMax = 20, 100, 20800
stub.fire("PLAYER_LEVEL_UP", 20)
local afterLevel = line(Lv.Pace(p))
local levelup = reads - before
Polestar.Fire("CODEX_LOADED")
local fresh = line(Lv.Pace(p))
emit({ scan = scan, kill = kill, turnin = turnin, levelup = levelup, moved = second.reach > first.reach,
	afterLevel = afterLevel, fresh = fresh, freshReads = reads - before - levelup, turnedIn = afterTurnin[1] ~= line(second)[1] })"#,
	]
	.join("\n"))
	.remove(0);
	assert!(out["scan"].as_i64().unwrap() > 0, "the first pace line reads the route's quests");
	assert_eq!(out["kill"], 0, "a kill's XP reads none of them again");
	assert_eq!(out["moved"], true, "and the line still moves with the XP");
	assert_eq!(out["turnin"], 0, "a turn-in sums again from the records read: {out}");
	assert_eq!(out["turnedIn"], true, "and the line follows the hand-in: {out}");
	assert_eq!(out["levelup"], 0, "so does a level: {out}");
	assert!(out["freshReads"].as_i64().unwrap() > 0, "a Codex change reads them again");
	assert_eq!(out["afterLevel"], out["fresh"], "what the kept records say is what a fresh read says");
}

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
	// Taken earlier (an accept alone at step 2): the line still points at step 4, which does it; step 2 says no
	// quest level (Fitz, 0.3.6: taking a quest above your level early is normal).
	let early = lua(&[
		RIDGE,
		r#"table.insert(guide.steps[2].goals, { t = "accept", quest = 25, qlvl = 25, title = "Missing In Action" })
local s = Lv.Pace(p)
local h = Lv.StepHint(2, p)
emit({ step = s.hard.step, hint = h and h.level or false })"#,
	]
	.join("\n"))
	.remove(0);
	assert_eq!(early, json!({ "step": 4, "hint": false }));
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
// Codex) never counts as hard; one whose work the Codex lists (done in another guide) does for the pace line,
// though its accept-only step says no quest level (Fitz, 0.3.6).
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
local pace = Lv.Pace(p).hard.quest
-- Its work on step 3 (as the Codex has it elsewhere): that step hints.
table.insert(guide.steps[3].goals, { t = "kill", target = "Raider", count = 8, quest = 27, oi = 1 })
local k = Lv.StepHint(3, p)
emit({ delivery = d and d.quest or false, elsewhere = w and w.quest or false, work = k and k.quest or false, pace = pace })"#,
	]
	.join("\n"))
	.remove(0);
	assert_eq!(
		out,
		json!({ "delivery": false, "elsewhere": false, "work": 27, "pace": 25 }),
		"no hint for the delivery or an accept; work on the quest hints; the pace line still points at the escort"
	);
}

#[test]
fn pace_at_or_past_the_guide_s_top_is_on_pace_and_reaches_beyond_it() {
	// Level 24 in the 20-24 guide (a Barrens 15-21 at 21): no `level` goal, the end target is the top the character
	// already has, so on pace; the route's XP takes it past 24, which the guide window shows (ui.rs).
	let out = lua(&[RIDGE, "p.level, p.xp, p.xpMax = 24, 0, 30000\nlocal s = Lv.Pace(p)\nemit({ kind = s.kind, target = s.target, bars = s.bars, past = s.reach > 24 })"].join("\n")).remove(0);
	assert_eq!(out, json!({ "kind": "end", "target": 24, "bars": 0, "past": true }));
}

/// The Codex: $POLESTAR_CODEX_DIR (a Polestar_Codex folder), else addon/Polestar_Codex (`forge data codex`).
fn codex_dir() -> PathBuf {
	std::env::var_os("POLESTAR_CODEX_DIR").map_or_else(|| addons_dir().join("Polestar_Codex"), PathBuf::from)
}

/// A pack folder's TOC files, as absolute paths.
fn toc_files(dir: &Path, toc: &str) -> Vec<String> {
	let Ok(text) = std::fs::read_to_string(dir.join(toc)) else { return Vec::new() };
	text.lines().map(str::trim).filter(|l| !l.is_empty() && !l.starts_with('#')).map(|f| join(dir, f).to_string_lossy().into_owned()).collect()
}

// Every leveling guide the addon ships, on the real Codex, for a character of its faction (its first race when it
// names races) at its start level: the "If you finish this guide" card's kills and the level it ends at.
const SHIPPED: &str = r#"
assert(loadfile(@CODEX_LUA@))("Polestar", Polestar)
for _, f in ipairs(@CODEX@) do assert(loadfile(f))("Polestar_Codex", {}) end
local guides, order = {}, {}
Polestar.RegisterGuide = function(g)
	if not guides[g.id] then order[#order + 1] = g.id end
	guides[g.id] = g
	return true
end
Polestar.RetireGuides = function() end
for _, f in ipairs(@GUIDES@) do assert(loadfile(f))("Polestar_Guides", {}) end
Polestar.Guides.Get = function(id) return guides[id] end
Polestar.Compat.IsQuestCompleted = function() return false end
local out = {}
for _, id in ipairs(order) do
	local g = guides[id]
	if g.category == "Leveling" and g.minLevel and g.maxLevel then
		local faction = g.faction or "Horde"
		local race = type(g.races) == "table" and g.races[1] or (faction == "Alliance" and "Human" or "Orc")
		local s = Lv.ForGuide(id, { level = g.minLevel, xp = 0, class = "WARRIOR", race = race, faction = faction })
		if s then
			out[#out + 1] = { id = id, top = g.maxLevel, kills = s.kills, to = s.to.level + (s.to.need > 0 and s.to.xp / s.to.need or 0) }
		end
	end
end
emit({ loaded = Polestar.Codex.IsLoaded(), guides = out })
"#;

/// #1697: 120,188 kills and +12 levels on the 29-33 Hillsbrad guide, from one stray drop chance. No leveling guide
/// may ask for more than 2,000 kills or end more than 3 levels past its top. Skips without a Codex pack.
#[test]
fn every_shipped_leveling_guide_s_estimate_stays_sane_on_the_real_codex_1697() {
	let dir = codex_dir();
	if !dir.join("Polestar_Codex.toc").exists() {
		eprintln!("skipped: no Codex pack at {} (forge data codex, or POLESTAR_CODEX_DIR)", dir.display());
		return;
	}
	let mut guides = Vec::new();
	for pack in std::fs::read_dir(addons_dir()).unwrap().flatten() {
		let name = pack.file_name().to_string_lossy().into_owned();
		if name.starts_with("Polestar_Guides") {
			guides.extend(toc_files(&pack.path(), &format!("{name}.toc")).into_iter().filter(|f| f.ends_with("Guides.lua")));
		}
	}
	guides.sort();
	let script = SHIPPED
		.replace("@CODEX_LUA@", &lua_value(&json!(addons_dir().join("Polestar/Lookup/Codex.lua").to_string_lossy())))
		.replace("@CODEX@", &lua_value(&json!(toc_files(&dir, "Polestar_Codex.toc"))))
		.replace("@GUIDES@", &lua_value(&json!(guides)));
	let out = lua(&script).remove(0);
	assert_eq!(out["loaded"], true, "the Codex pack at {} loads", dir.display());
	let list = out["guides"].as_array().cloned().unwrap_or_default();
	assert!(list.len() > 40, "every leveling guide estimated: {}", list.len());
	let bad: Vec<String> = list
		.iter()
		.filter(|g| g["kills"].as_f64().unwrap_or(0.0) > 2000.0 || g["to"].as_f64().unwrap_or(0.0) > g["top"].as_f64().unwrap_or(0.0) + 3.0)
		.map(|g| format!("{}: {} kills, ends at {:.1} (top {})", g["id"].as_str().unwrap_or(""), g["kills"], g["to"].as_f64().unwrap_or(0.0), g["top"]))
		.collect();
	assert!(bad.is_empty(), "estimates past any sense:\n{}", bad.join("\n"));
}
