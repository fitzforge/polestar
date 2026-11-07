//! "While you're here" (addon/Polestar/Core/Engine.lua, Own.hereBuild / Own.hereTick, Engine.GetWhileHere): while
//! the player works the live step, a quick open objective of a later step whose quest is already in the log, close
//! by, becomes one line under the step; with the option on, so does a quest ready to hand in whose NPC stands right
//! there. Real Core manifest and quest database module, stub world.
//!
//! Elwynn here is 3000 yd across (30 yd per map percent on x) and 2000 yd high (20 yd per percent on y).

use forge_addontest::{emitted, questdb::ADD_RECORDS_LUA, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.level = 5
w.zone, w.subzone = "Elwynn Forest", ""
w.moveTo(1429, 47.6, 45.1)
w.onQuest(33, { 8 }, "Wolves Across the Border")
w.onQuest(7, { { required = 10, fulfilled = 8 } }, "Kobold Camp Cleanup")
w.onQuest(60, { { text = "Large Candle: 1/3", type = "item", required = 3, fulfilled = 1 } }, "Candles")
w.onQuest(50, { 1 }, "Murlocs")
w.onQuest(51, { 1 }, "Ogres")
w.onQuest(40, {}, "A Fishy Peril")
w.onQuest(52, { 1 }, "Spiders")
"#;

// 1 (live) kill 8 wolves for 33, far away · 2 kill 10 vermin for 7 (8 done) at 47.6,35.1 · 3 collect 3 candles for
// 60 (1 done), two spawn areas around 52,35 · 4 kill bandits for 88 (not in the log) · 5 accept 106 · 6 `when level
// >= 10`: a murloc for 50 · 7 an ogre for 51, level 9 · 8 turn in 40 (ready) to Marshal Dughan at 42,35.1 · 9 hearth
// (the guide leaves the zone) · 10 a spider for 52.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/here", pack = "test", title = "Here", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 ESCORT } } },
		{ title = "Vermin", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
		{ title = "Candles", goals = { { t = "collect", item = 772, itemName = "Large Candle", count = 3, quest = 60, oi = 1, npc = 476, map = 1429, x = 52.0, y = 35.1,
			spots = { { x = 52.0, y = 35.1, r = 15, n = 3 }, { x = 53.0, y = 36.0, r = 10, n = 2 } } } } },
		{ title = "Bandits", goals = { { t = "kill", target = "Defias Bandit", npc = 116, count = 2, quest = 88, oi = 1, map = 1429, x = 47.6, y = 36.0 } } },
		{ title = "Maybell", goals = { { t = "accept", quest = 106, title = "Young Lovers", npc = 251, npcName = "Maybell Maclure", map = 1429, x = 47.5, y = 35.5 } } },
		{ title = "Murlocs", when = { { k = "level", op = ">=", n = 10 } }, goals = { { t = "kill", target = "Murloc", npc = 40, count = 1, quest = 50, oi = 1, map = 1429, x = 47.7, y = 35.1 } } },
		{ title = "Ogres", goals = { { t = "kill", target = "Ogre", npc = 41, count = 1, quest = 51, oi = 1, lvl = 9, map = 1429, x = 47.5, y = 35.1 } } },
		{ title = "Dughan", goals = { { t = "turnin", quest = 40, title = "A Fishy Peril", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 42.0, y = 35.1 } } },
		{ title = "Home", goals = { { t = "hearth", location = "Goldshire" } } },
		{ title = "Spiders", goals = { { t = "kill", target = "Spider", npc = 42, count = 1, quest = 52, oi = 1, map = 1429, x = 47.6, y = 35.2 } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
function flush() stub.advance(0.25) end
-- Move, then let the arrival poll (every 0.5 s) measure.
function at(x, y) w.moveTo(1429, x, y); stub.advance(0.6) end
function cands()
	local out = {}
	for _, c in ipairs(E.GetWhileHereCandidates()) do out[#out + 1] = c.step .. ":" .. c.index .. ":" .. c.kind .. ":" .. c.left end
	return table.concat(out, " ")
end
function here()
	local v = E.GetWhileHere()
	return v and (v.step .. ":" .. v.index .. " " .. v.hereText .. " " .. (v.yards or "-")) or "none"
end
function wp()
	local x = E.GetWaypoint()
	return x and (x.stepIndex .. ":" .. x.goalIndex) or "none"
end
"#;

fn items(chance: u32) -> String {
	format!(
		r#"{ADD_RECORDS_LUA}
Polestar.QuestDB.SetMeta({{ schema = 2 }})
AddRecords("items", {{ [772] = {{ "Large Candle", 1, 476, {chance}, 0 }} }})
"#
	)
}

fn run_full(script: &str, chance: u32, escort: bool) -> Vec<Value> {
	let guide = GUIDE.replace("ESCORT", if escort { ", escort = true" } else { "" });
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Quests/QuestDB.lua"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/here" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, &guide, HELPERS, &items(chance), "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_full(script, 50, false)
}

#[test]
fn only_quick_open_work_of_later_steps_for_quests_in_the_log_qualifies_up_to_where_the_guide_leaves_the_zone() {
	let out = run(r#"
		emit({ E.GetLiveStep(), cands() })
		w.progress(7, 1, 0); flush()
		emit(cands())                                -- 10 vermin left: too many kills
		w.progress(7, 1, 8); E.PinQuest(7); flush()
		emit(cands())                                -- pinned: Along the way lists it already
	"#);
	// 2: two vermin left. 3: two candles at 50 % (four kills). 8: quest 40 is ready, Dughan takes it. Never 4 (88
	// is not in the log), 5 (a pickup), 6 (its `when` fails at level 5), 7 (level 9 mobs at level 5), 10 (after the
	// hearth: another zone stay), nor the live step's own wolves.
	assert_eq!(out, vec![json!([1, "2:1:work:2 3:1:work:2 8:1:turnin:0"]), json!("3:1:work:2 8:1:turnin:0"), json!("3:1:work:2 8:1:turnin:0")]);
}

// Background goals: a slow drop spread over the zone (the Barrens' beaks, about one in four) is never "grab it now".
#[test]
fn a_low_drop_collect_is_left_out_two_items_at_26_percent_take_about_eight_kills() {
	let out = run_full("emit(cands())", 26, false);
	assert_eq!(out, vec![json!("2:1:work:2 8:1:turnin:0")]);
}

#[test]
fn the_line_appears_within_60_yards_holds_to_100_and_clears_past_it() {
	let out = run(r#"
		emit(here())                    -- 200 yd from the vermin
		at(47.6, 37.6); emit(here())    -- 50 yd: it shows
		at(47.6, 39.6); emit(here())    -- 90 yd: it holds
		at(47.6, 41.1); emit(here())    -- 120 yd: gone
		at(47.6, 39.6); emit(here())    -- 90 yd: not back yet
		at(47.6, 37.1); emit(here())    -- 40 yd: back
	"#);
	assert_eq!(
		out,
		vec![
			json!("none"),
			json!("2:1 Kill Kobold Vermin, 2 more 50"),
			json!("2:1 Kill Kobold Vermin, 2 more 90"),
			json!("none"),
			json!("none"),
			json!("2:1 Kill Kobold Vermin, 2 more 40")
		]
	);
}

#[test]
fn nothing_appears_or_goes_by_distance_during_a_fight() {
	let out = run(r#"
		stub.inCombat = true
		at(47.6, 37.6); emit(here())    -- in reach, but fighting
		stub.inCombat = false
		at(47.6, 37.6); emit(here())
		stub.inCombat = true
		at(47.6, 41.1); emit(here())    -- out of reach, still fighting: it stays
		stub.inCombat = false
		at(47.6, 41.1); emit(here())
	"#);
	assert_eq!(out, vec![json!("none"), json!("2:1 Kill Kobold Vermin, 2 more 50"), json!("2:1 Kill Kobold Vermin, 2 more 50"), json!("none")]);
}

#[test]
fn a_dismissed_or_expired_line_stays_quiet_for_the_zone_stay() {
	let out = run(r#"
		at(47.6, 37.6); emit(here())
		emit(E.DismissWhileHere()); emit(here())
		at(47.6, 45.1); at(47.6, 37.6); emit(here())                 -- away and back: still quiet
		w.setZone("Westfall"); flush(); w.setZone("Elwynn Forest"); flush()
		at(47.6, 37.6); emit(here())                                   -- a new zone stay
		stub.advance(181); emit(here())                                -- three minutes unused: it goes
		at(47.6, 45.1); at(47.6, 37.6); emit(here())                 -- and stays quiet
	"#);
	assert_eq!(
		out,
		vec![
			json!("2:1 Kill Kobold Vermin, 2 more 50"),
			json!(true),
			json!("none"),
			json!("none"),
			json!("2:1 Kill Kobold Vermin, 2 more 50"),
			json!("none"),
			json!("none")
		]
	);
}

#[test]
fn the_line_never_takes_the_arrow_a_click_does_and_the_arrow_comes_back_when_it_is_done() {
	let out = run(r#"
		at(47.6, 37.6); emit({ here(), wp() })        -- shown, the arrow stays on the wolves
		emit(E.AimWhileHere()); flush(); emit(wp())
		w.progress(7, 1, 10); flush(); emit({ here(), wp() })
		at(47.6, 37.6); emit(here())
		at(42.0, 36.1); E.AimWhileHere(); flush(); emit(wp())
		E.DismissWhileHere(); flush(); emit({ here(), wp() })
	"#);
	assert_eq!(
		out,
		vec![
			json!(["2:1 Kill Kobold Vermin, 2 more 50", "1:1"]),
			json!(true),
			json!("2:1"),
			json!(["none", "1:1"]),
			json!("none"),
			json!("8:1"),
			json!(["none", "1:1"])
		]
	);
}

// Nothing new happens later: objectives done early count as ever, so the vermin step is passed and the candles step
// is shorter when the route gets there.
#[test]
fn the_later_step_is_done_or_shorter_after_an_early_grab() {
	let out = run(r#"
		at(47.6, 37.6)
		w.progress(7, 1, 10); w.progress(60, 1, 2); flush()
		w.progress(33, 1, 8); flush()
		local v = E.GetStepView(E.GetLiveStep())
		emit({ E.GetLiveStep(), v.goals[1].progress.cur, v.goals[1].progress.max })
	"#);
	assert_eq!(out, vec![json!([3, 2, 3])]);
}

#[test]
fn a_quest_ready_to_hand_in_whose_npc_stands_within_30_yards_is_the_line_when_the_guide_hands_it_in_later() {
	let out = run(r#"
		at(42.0, 37.1); emit(here())    -- 40 yd from Dughan: not yet
		at(42.0, 36.1); emit(here())    -- 20 yd
		at(42.0, 37.4); emit(here())    -- 46 yd: it holds
		at(42.0, 38.1); emit(here())    -- 60 yd: gone
		Polestar.Set("behavior.whileHereTurnins", false); flush()
		emit(cands())
		at(42.0, 36.1); emit(here())
	"#);
	assert_eq!(
		out,
		vec![
			json!("none"),
			json!("8:1 Hand in A Fishy Peril to Marshal Dughan 20"),
			json!("8:1 Hand in A Fishy Peril to Marshal Dughan 45"),
			json!("none"),
			json!("2:1:work:2 3:1:work:2"),
			json!("none")
		]
	);
}

#[test]
fn never_in_an_instance_on_a_taxi_while_hearthing_or_during_a_timed_or_escort_quest() {
	let out = run(r#"
		at(47.6, 37.6); emit(here())
		w.inInstance = true; stub.advance(0.6); emit(here())
		w.inInstance = false; stub.advance(0.6); emit(here())
		w.onTaxi = true; stub.advance(0.6); emit(here())
		w.onTaxi = false
		function UnitCastingInfo(unit) return "Hearthstone", "", 0, 0, 10000, false, "Cast-1", false, 8690 end
		stub.advance(0.6); emit(here())
		UnitCastingInfo = nil
		function GetQuestTimers() return 900 end
		stub.advance(0.6); emit(here())
		GetQuestTimers = nil
		stub.advance(0.6); emit(here())
	"#);
	let v = "2:1 Kill Kobold Vermin, 2 more 50";
	assert_eq!(out, vec![json!(v), json!("none"), json!(v), json!("none"), json!("none"), json!("none"), json!(v)]);
	// The live step escorts someone: nothing for the whole step.
	let escort = run_full(r#"at(47.6, 37.6); emit(here())"#, 50, true);
	assert_eq!(escort, vec![json!("none")]);
}

#[test]
fn the_options_turn_it_off_and_set_how_close() {
	let out = run(r#"
		emit({ Polestar.Get("behavior.whileHere"), Polestar.Get("behavior.whileHereRadius"), Polestar.Get("behavior.whileHereTurnins") })
		Polestar.Set("behavior.whileHere", false); flush()
		at(47.6, 37.6); emit({ cands(), here() })
		Polestar.Set("behavior.whileHere", true); Polestar.Set("behavior.whileHereRadius", 40); flush()
		at(47.6, 37.6); emit(here())    -- 50 yd: past 40
		at(47.6, 37.0); emit(here())    -- 38 yd
		E.DismissWhileHere()
		Polestar.Set("behavior.whileHereRadius", 120); flush()
		at(47.6, 40.1); emit(here())    -- 100 yd, within 120 (the vermin stay quiet: the candles are 150 yd off)
	"#);
	assert_eq!(
		out,
		vec![json!([true, 60, true]), json!(["", "none"]), json!("none"), json!("2:1 Kill Kobold Vermin, 2 more 40"), json!("none")]
	);
	let wide = run(r#"Polestar.Set("behavior.whileHereRadius", 120); flush(); at(47.6, 40.1); emit(here())"#);
	assert_eq!(wide, vec![json!("2:1 Kill Kobold Vermin, 2 more 100")]);
}

// The poll measures the candidates every half second: it must leave nothing for the collector, with a line shown
// (its distance to keep) and without one (every candidate measured, spawn areas included).
#[test]
fn the_position_poll_allocates_nothing_per_tick() {
	let out = run(r#"
		local function ticks(n)
			local c, px, py = Polestar.Compat.GetPlayerWorldPosition()
			for _ = 1, 20 do E.WhileHereTick(c, px, py) end
			collectgarbage("collect"); collectgarbage("collect")
			collectgarbage("stop")
			local base = collectgarbage("count")
			for i = 1, n do E.WhileHereTick(c, px + (i % 2) * 0.4, py) end
			local kib = collectgarbage("count") - base
			collectgarbage("restart")
			return kib
		end
		at(47.6, 37.6)
		local shown = ticks(2000)
		local line = here()
		at(47.6, 45.1)
		local idle = ticks(2000)
		emit({ shown = shown, idle = idle, line = line, cands = cands(), after = here() })
	"#)
	.remove(0);
	assert_eq!(out["line"], "2:1 Kill Kobold Vermin, 2 more 50");
	assert_eq!(out["after"], "none");
	assert_eq!(out["cands"], "2:1:work:2 3:1:work:2 8:1:turnin:0");
	let (shown, idle) = (out["shown"].as_f64().unwrap(), out["idle"].as_f64().unwrap());
	assert!(shown < 0.5, "2000 polls with the line shown allocated {shown:.2} KiB");
	assert!(idle < 0.5, "2000 polls measuring every candidate allocated {idle:.2} KiB");
}
