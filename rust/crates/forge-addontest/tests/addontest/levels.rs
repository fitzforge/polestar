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
