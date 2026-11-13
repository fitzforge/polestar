//! "While you're here" (addon/Polestar/Core/Engine.lua, Own.hereBuild / Own.hereTick, Engine.GetWhileHere): while
//! the player works the live step, an open objective of any later step of the guide on the player's map whose
//! quest is already in the log, close by, becomes one line under the step, whatever is left (the player is there
//! already); with the option on, so does a quest ready to hand in whose NPC is little out of the way. Real Core manifest,
//! stub world.
//!
//! Elwynn here is 3000 yd across (30 yd per map percent on x) and 2000 yd high (20 yd per percent on y).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.addMap(1436, { name = "Westfall", c = 0, left = -1500, right = -4500, top = -1500, bottom = -3500 })
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
// · 10 a spider for 52 at 20,60, far from the rest.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/here", pack = "test", title = "Here", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 ESCORT } } },
		{ title = "Vermin", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
		{ title = "Candles", goals = { { t = "collect", item = 772, itemName = "Large Candle", count = 3, quest = 60, oi = 1, npc = 476, map = 1429, x = 52.0, y = 35.1,
			spots = { { x = 52.0, y = 35.1, r = 15, n = 3 }, { x = 53.0, y = 36.0, r = 10, n = 2 } } } } },
		{ title = "Bandits", goals = { { t = "kill", target = "Defias Bandit", npc = 116, count = 2, quest = 88, oi = 1, map = 1429, x = 47.6, y = 36.0 } } },
		{ title = "Maybell", goals = { { t = "accept", quest = 106, title = "Young Lovers", npc = 251, npcName = "Maybell Maclure", qlvl = 9, map = 1429, x = 47.5, y = 35.5 } } },
		{ title = "Murlocs", when = { { k = "level", op = ">=", n = 10 } }, goals = { { t = "kill", target = "Murloc", npc = 40, count = 1, quest = 50, oi = 1, map = 1429, x = 47.7, y = 35.1 } } },
		{ title = "Ogres", goals = { { t = "kill", target = "Ogre", npc = 41, count = 1, quest = 51, oi = 1, lvl = 9, map = 1429, x = 47.5, y = 35.1 } } },
		{ title = "Dughan", goals = { { t = "turnin", quest = 40, title = "A Fishy Peril", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 42.0, y = 35.1 } } },
		{ title = "Home", goals = { { t = "hearth", location = "Goldshire" } } },
		{ title = "Spiders", goals = { { t = "kill", target = "Spider", npc = 42, count = 1, quest = 52, oi = 1, map = 1429, x = 20.0, y = 60.0 } } },
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
-- Every line shown, in order: "step:index:yards ...".
function lines()
	local out = {}
	for _, v in ipairs(E.GetWhileHereList()) do out[#out + 1] = v.step .. ":" .. v.index .. ":" .. (v.yards or "-") end
	return table.concat(out, " ")
end
"#;

// The guide with `from` replaced by `to` (the escort test: "ESCORT").
fn run_edit(script: &str, from: &str, to: &str) -> Vec<Value> {
	run_guide(&GUIDE.replace(from, to).replace("ESCORT", ""), "test/here", script)
}

// Guide source `guide` (registering guide `id`) in the world above, the player on it, the line's radius at 60 yd
// (the distances below are measured against it; the default is 250).
fn run_guide(guide: &str, id: &str, script: &str) -> Vec<Value> {
	run_guide_with(guide, id, r#"Polestar.Set("behavior.whileHereRadius", 60); stub.advance(0.6)"#, script)
}

fn run_guide_with(guide: &str, id: &str, setup: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), format!("PolestarCharDB = {{ schema = 1, guide = {id:?} }}"))],
		script: [TEST_PACK, TEST_SOURCE, guide, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, setup, script].join("\n"),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_edit(script, "ESCORT", "")
}

#[test]
fn open_work_of_every_later_step_for_quests_in_the_log_qualifies_whatever_is_left() {
	let out = run(r#"
		emit({ E.GetLiveStep(), cands() })
		w.progress(7, 1, 0); flush()
		emit(cands())                                -- 10 vermin left: still one, the player is there already
		E.PinQuest(7); flush()
		emit(cands())                                -- pinned: Along the way lists it already
		E.SkipQuest(60); flush()
		emit(cands())                                -- skipped: never
	"#);
	// 2: the vermin. 3: two candles. 8: quest 40 is ready, Dughan takes it. 10: the spider, after the hearth: the
	// player is here now. Never 4 (88 is not in the log), 5 (a pickup), 6 (its `when` fails at level 5), 7 (level 9
	// mobs at level 5), nor the live step's own wolves.
	assert_eq!(
		out,
		vec![
			json!([1, "2:1:work:2 3:1:work:2 8:1:turnin:0 10:1:work:1"]),
			json!("2:1:work:10 3:1:work:2 8:1:turnin:0 10:1:work:1"),
			json!("3:1:work:2 8:1:turnin:0 10:1:work:1"),
			json!("8:1:turnin:0 10:1:work:1")
		]
	);
}

// A guide that leaves Elwynn and comes back: 1 (live) the wolves far off at 60,60 · 2 candles as you go (an along
// step, not listed yet) · 3 to Westfall · 4 a murloc for 50 in Westfall at the same map coordinates as the player
// stands in Elwynn · 5 hearth · 6 the vermin, back in Elwynn · 7 accept 106 · 8 bandits for 88 (not in the log) ·
// 9 a murloc fisher for 40 (ready to hand in).
const AWAY: &str = r#"
Polestar.RegisterGuide({
	id = "test/away", pack = "test", title = "Away", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } },
		{ title = "Candles as you go", along = true, goals = { { t = "collect", item = 772, itemName = "Large Candle", count = 3, quest = 60, oi = 1, npc = 476, map = 1429, x = 52.0, y = 35.1 } } },
		{ title = "Westfall", goals = { { t = "goto", map = 1436, x = 50.0, y = 50.0 } } },
		{ title = "Murlocs", goals = { { t = "kill", target = "Murloc", npc = 40, count = 1, quest = 50, oi = 1, map = 1436, x = 47.6, y = 37.6 } } },
		{ title = "Home", goals = { { t = "hearth", location = "Goldshire" } } },
		{ title = "Vermin", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
		{ title = "Maybell", goals = { { t = "accept", quest = 106, title = "Young Lovers", npc = 251, npcName = "Maybell Maclure", qlvl = 9, map = 1429, x = 47.6, y = 36.0 } } },
		{ title = "Bandits", goals = { { t = "kill", target = "Defias Bandit", npc = 116, count = 2, quest = 88, oi = 1, map = 1429, x = 47.6, y = 36.0 } } },
		{ title = "Fishers", goals = { { t = "kill", target = "Murloc Fisher", npc = 43, count = 1, quest = 40, oi = 1, map = 1429, x = 47.6, y = 36.0 } } },
	},
})
"#;

// The later same-map objective comes after the guide went to Westfall and hearthed back: it counts, measured from
// where the player stands while the live step's wolves (and the arrow) are ~580 yd off. The Westfall murloc counts in
// Elwynn too (Fitz, 0.3.6: no zone of the guide stops While you're here; the same continent, measured in world yards,
// 3000 yd off: no line), and shows in Westfall. Never the accept, the bandits (not in the log) or the fishers (ready).
#[test]
fn a_later_objective_after_the_guide_leaves_the_zone_and_comes_back_counts_and_one_on_another_map_by_world_distance() {
	let out = run_guide(
		AWAY,
		"test/away",
		r#"
		emit(cands())
		at(47.6, 37.6); emit({ here(), wp(), (E.StepNumber(6)) })
		w.progress(7, 1, 10); flush()
		emit({ cands(), here() })                    -- ready to hand in: never
		w.moveTo(1436, 47.6, 37.6); w.setZone("Westfall"); flush(); stub.advance(0.6)
		emit({ cands(), here() })
	"#,
	);
	assert_eq!(out[0], json!("2:1:work:2 4:1:work:1 6:1:work:2"));
	assert_eq!(out[1], json!(["6:1 Kill Kobold Vermin, 2 more 50", "1:1", 4]));
	assert_eq!(out[2], json!(["2:1:work:2 4:1:work:1", "none"]));
	assert_eq!(out[3][0], json!("2:1:work:2 4:1:work:1"));
	assert!(out[3][1].as_str().unwrap().starts_with("4:1 "), "the Westfall murloc shows in Westfall: {}", out[3]);
}

// Background goals (slow drops spread over the zone) are along steps. Listed (behind the live step), Along the way
// shows them and this line never does; a later one not listed yet counts like any step.
#[test]
fn a_later_along_step_counts_until_along_the_way_lists_it() {
	let out = run_guide(
		AWAY,
		"test/away",
		r#"
		emit(cands())
		w.progress(33, 1, 8); flush()               -- the wolves done: live step 3, the candles listed
		local along = {}
		for _, s in ipairs(E.GetAlong()) do along[#along + 1] = s.index end
		emit({ E.GetLiveStep(), cands(), along })
	"#,
	);
	assert_eq!(out, vec![json!("2:1:work:2 4:1:work:1 6:1:work:2"), json!([3, "4:1:work:1 6:1:work:2", [2]])]);
}

// More candidates than the poll measures (HERE_MAX, 10): the nearest to the player, picked again as they move, so
// the one close by shows even when it comes last in route order. Picking again leaves nothing for the collector.
const MANY: &str = r#"
local steps = { { title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } } }
for i = 1, 12 do
	local q = 200 + i
	stub.world.onQuest(q, { 1 }, "Mob " .. i)
	steps[#steps + 1] = { title = "Mob " .. i, goals = { { t = "kill", target = "Mob " .. i, npc = 500 + i, count = 1, quest = q, oi = 1, map = 1429,
		x = i < 12 and 10 + i * 2 or 47.6, y = i < 12 and 80 or 35.1 } } }
end
Polestar.RegisterGuide({ id = "test/many", pack = "test", title = "Many", minLevel = 1, maxLevel = 10, steps = steps })
"#;

#[test]
fn with_more_candidates_than_the_poll_measures_the_nearest_are_measured() {
	let out = run_guide(
		MANY,
		"test/many",
		r#"
		local function measured()
			local n, all = 0, E.GetWhileHereCandidates()
			for _, c in ipairs(all) do if c.measured then n = n + 1 end end
			return { #all, n }
		end
		at(47.6, 37.6); emit({ here(), measured() })
		at(12.0, 78.0); at(12.0, 78.0); emit(here())   -- the line goes past 100 yd, then mob 1 is the nearest
		E.DismissWhileHere()
		at(47.6, 60.0)                                  -- nothing in reach
		local c, px, py = Polestar.Compat.GetPlayerWorldPosition()
		for i = 1, 20 do E.WhileHereTick(c, px + (i % 2) * 40, py) end
		collectgarbage("collect"); collectgarbage("collect")
		collectgarbage("stop")
		local base = collectgarbage("count")
		for i = 1, 2000 do E.WhileHereTick(c, px + (i % 2) * 40, py) end   -- 40 yd each poll: picked again every time
		local kib = collectgarbage("count") - base
		collectgarbage("restart")
		emit({ kib = kib, line = here() })
	"#,
	);
	assert_eq!(out[0], json!(["13:1 Kill Mob 12, 1 more 50", [12, 10]]));
	assert_eq!(out[1], json!("2:1 Kill Mob 1, 1 more 40"));
	assert_eq!(out[2]["line"], "none");
	let kib = out[2]["kib"].as_f64().unwrap();
	assert!(kib < 0.5, "2000 polls picking the nearest again allocated {kib:.2} KiB");
}

// The ranking picks which lines show: of four in reach for three places, spiders found in eight camps all over the
// zone (the player stands in one, 0 yd) wait while the single murloc, kobold and gnoll places show, nearest first.
// Dismissing one frees a place for the spiders, which read first (nearest). Away from the rest, a spider camp
// in reach shows alone.
const SPREAD: &str = r#"
local camps = {}
for _, p in ipairs({ { 47.6, 37.6 }, { 30, 70 }, { 20, 20 }, { 70, 20 }, { 10, 50 }, { 80, 80 }, { 25, 85 }, { 65, 75 } }) do
	camps[#camps + 1] = { x = p[1], y = p[2], r = 20, n = 2 }
end
stub.world.onQuest(401, { 1 }, "Kobolds"); stub.world.onQuest(402, { 1 }, "Gnolls")
Polestar.RegisterGuide({
	id = "test/spread", pack = "test", title = "Spread", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } },
		{ title = "Spiders", goals = { { t = "kill", target = "Spider", npc = 42, count = 1, quest = 52, oi = 1, map = 1429, x = 47.6, y = 37.6, spots = camps } } },
		{ title = "Murlocs", goals = { { t = "kill", target = "Murloc", npc = 40, count = 1, quest = 50, oi = 1, map = 1429, x = 47.6, y = 36.1 } } },
		{ title = "Kobolds", goals = { { t = "kill", target = "Kobold", npc = 44, count = 1, quest = 401, oi = 1, map = 1429, x = 47.6, y = 35.6 } } },
		{ title = "Gnolls", goals = { { t = "kill", target = "Gnoll", npc = 45, count = 1, quest = 402, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
	},
})
"#;

#[test]
fn the_ranking_picks_which_lines_show_the_rows_read_nearest_first() {
	let out = run_guide(
		SPREAD,
		"test/spread",
		r#"
		at(47.6, 37.6); emit(lines())
		E.DismissWhileHere(1); stub.advance(0.6); emit(lines())
		at(30.0, 70.0); emit(lines())                   -- another spider camp, the rest far
	"#,
	);
	assert_eq!(out, vec![json!("3:1:30 4:1:40 5:1:50"), json!("2:1:0 4:1:40 5:1:50"), json!("2:1:0")]);
}

// Fitz: rows nearest first, but no jumping: two shown swap only once the lower is 30 yd nearer (HERE_ORDER).
const PAIR: &str = r#"
Polestar.RegisterGuide({
	id = "test/pair", pack = "test", title = "Pair", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } },
		{ title = "Murlocs", goals = { { t = "kill", target = "Murloc", npc = 40, count = 1, quest = 50, oi = 1, map = 1429, x = 47.6, y = 36.6 } } },
		{ title = "Spiders", goals = { { t = "kill", target = "Spider", npc = 42, count = 1, quest = 52, oi = 1, map = 1429, x = 47.6, y = 38.6 } } },
	},
})
"#;

#[test]
fn shown_rows_keep_their_places_until_one_is_30_yards_nearer() {
	let out = run_guide(
		PAIR,
		"test/pair",
		r#"
		at(47.6, 37.1); emit(lines())                   -- murloc 10, spider 30
		at(47.6, 38.1); emit(lines())                   -- murloc 30, spider 10: 20 nearer, they stay
		at(47.6, 38.6); emit(lines())                   -- murloc 40, spider 0: they swap
	"#,
	);
	assert_eq!(out, vec![json!("2:1:10 3:1:30"), json!("2:1:30 3:1:10"), json!("3:1:0 2:1:40")]);
}

// Fitz, 0.3.5 preview: an Undead Warlock, level 13, on The Barrens guide's Razormane camp step (15), Fungal Spores
// (848) in the log at 0/1, chasing plainstriders and raptors for the slow beak and head drops (background goals)
// out to the Stagnant Oasis, the arrow 946 yd off on the camp. The spores' Laden Mushrooms grow there, yet no line
// came: the spores' step (39, after the flight back from Ratchet and the trips to Durotar for other classes) lay
// past where the scan stopped at the flight. The Zhevra (845) are a candidate too; no runner spawns within reach of
// the oasis, and at a runner camp they show. The guide as shipped (guides/forever/horde/02-the-barrens.guide,
// compiled with data/forever; skipped with a note without it).
#[test]
fn barrens_chasing_slow_drops_to_the_stagnant_oasis_the_fungal_spores_line_shows_and_the_zhevra_at_a_runner_camp() {
	use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
	use forge_addontest::run::root;
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let file = "guides/forever/horde/02-the-barrens.guide";
	let text = std::fs::read_to_string(root().join(file)).unwrap();
	let compiled = compile_with(&[(file, &text)], &data, None);
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let loads: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let f = data.map_frames.get("forever").get("1413");
	let before = format!(
		r#"local w = stub.world
w.addMap(1413, {{ name = "The Barrens", c = {}, left = {}, right = {}, top = {}, bottom = {} }})
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Scourge", "Undead", "WARLOCK", "WARLOCK", "Horde", 13
w.zone, w.subzone = "The Barrens", ""
w.moveTo(1413, 52.0, 30.0)
w.complete({{ 1358 }})
w.onQuest(844, {{ {{ text = "Plainstrider Beak: 3/7", type = "item", required = 7, fulfilled = 3 }} }})
w.onQuest(869, {{ {{ text = "Raptor Head: 4/12", type = "item", required = 12, fulfilled = 4 }} }})
w.onQuest(1492, {{}})
w.onQuest(848, {{ {{ text = "Fungal Spores: 0/1", type = "item", required = 1, fulfilled = 0 }} }})
w.onQuest(5041, {{ {{ text = "Supplies for the Crossroads: 0/1", type = "item", required = 1, fulfilled = 0 }} }})
w.onQuest(871, {{ 12, 12, 12 }})
w.onQuest(867, {{ {{ text = "Witchwing Talon: 0/8", type = "item", required = 8, fulfilled = 0 }} }})
w.onQuest(870, {{ 1 }})
w.onQuest(845, {{ {{ text = "Zhevra Hooves: 0/4", type = "item", required = 4, fulfilled = 0 }} }})
w.bindLocation = "The Crossroads"
"#,
		f.get("c").to_js_string(),
		f.get("left").to_js_string(),
		f.get("right").to_js_string(),
		f.get("top").to_js_string(),
		f.get("bottom").to_js_string()
	);
	let script = format!(
		r#"do local ns = {{}}
{}
end
stub.login()
stub.fire("QUEST_LOG_UPDATE")
{HELPERS}
E.SetGuide("forever/horde/02-the-barrens"); flush()
-- The Crossroads step's flight path (step 12) is the only thing between: skip it as he had it.
for _ = 1, 3 do if E.GetLiveStep() < 15 then E.Skip(); flush() end end
w.moveTo(1413, 55.08, 41.61); stub.advance(0.6); stub.advance(0.6)
local v, x = E.GetWhileHere(), E.GetWaypoint()
local c, px, py = Polestar.Compat.GetPlayerWorldPosition()
local wc, wx, wy = Polestar.Compat.MapToWorld(x.map, x.x, x.y, x.f)
local function report()
	for _, l in ipairs(Polestar.UI.Report.Details().lines) do if l:find("^While here: ") then return l end end
	return false
end
emit({{ live = E.GetLiveStep(), arrow = x.stepIndex, arrowYards = wc == c and math.floor(((wx - px) ^ 2 + (wy - py) ^ 2) ^ 0.5) or false,
	step = v and v.step or false, index = v and v.index or false, text = v and v.hereText or false, yards = v and v.yards or false,
	zhevra = cands():find("18:1:work", 1, true) ~= nil, report = report() }})
-- At the oasis' north edge both show at once: the hooves first (the route's next steps), then the spores.
w.moveTo(1413, 55.0, 40.5); stub.advance(0.6); stub.advance(0.6)
emit(lines())
-- Fitz on 9b61fa91c: he dismissed the spores at the pool, left, came back, and they stayed away. Dismissed, 120 yd
-- off (past HERE_DISMISS_AWAY, 100), two minutes, back at the same mushrooms: they come again, chiming.
local function chimes()
	local n = 0
	for _, s in ipairs(stub.sounds or {{}}) do if type(s) == "string" and s:find("while%-here%.ogg$") then n = n + 1 end end
	return n
end
local function rowOf(step)
	for i, v in ipairs(E.GetWhileHereList()) do if v.step == step then return i end end
	return nil
end
local before = chimes()
E.DismissWhileHere(rowOf(39)); flush()
local gone = rowOf(39) == nil
w.moveTo(1413, 55.0, 38.7); stub.advance(0.6); stub.advance(121)
w.moveTo(1413, 55.0, 40.5); stub.advance(0.6); stub.advance(0.6)
emit({{ gone = gone, back = rowOf(39) ~= nil, chimed = chimes() > before }})
-- Fitz on 0.3.5 at 60 yd: among four Zhevra Runners just north of the oasis, no line. Their camp there is an
-- alternative spot (54.5,38, 59 yd across) 33 yd off; the nearest of the guide's picked spots is 94 yd off.
Polestar.Set("behavior.whileHereRadius", 60); flush()
w.moveTo(1413, 54.30, 38.38); stub.advance(0.6); stub.advance(0.6)
emit(here())
-- A Zhevra Runner camp on the road south of the Crossroads, the spores 600 yd off.
w.moveTo(1413, 56.3, 32.6); stub.advance(0.6); stub.advance(0.6)
emit(here())
w.moveTo(1413, 55.08, 41.61); stub.advance(0.6); stub.advance(0.6)
w.progress(848, 1, 1); flush(); stub.advance(0.6)
emit({{ here(), report() }})
-- Fitz at the Razormane camp, 180 yd: "Collect Zhevra Hooves · 180 yd" with no runner near, and the arrow then said
-- 393 yd: the row measured to a zone-wide area's edge. Now the row, the reach and the arrow use the spot's centre.
Polestar.Set("behavior.whileHereRadius", 180); flush()
local function zhevra()
	for i, v in ipairs(E.GetWhileHereList()) do if v.step == 18 then return i, v end end
	return nil
end
local function nearest()
	local goal = E.AlongGoal(18, 1)
	local c, px, py = Polestar.Compat.GetPlayerWorldPosition()
	local best
	for _, s in ipairs(goal.spots) do
		local sc, sx, sy = Polestar.Compat.MapToWorld(goal.map, s.x, s.y, goal.f)
		if sc == c then
			local d = ((sx - px) ^ 2 + (sy - py) ^ 2) ^ 0.5
			if not best or d < best then best = d end
		end
	end
	return best
end
w.moveTo(1413, 55.0, 26.5); stub.advance(0.6); stub.advance(0.6)
emit({{ nearest = math.floor(nearest()), shown = zhevra() ~= nil }})
-- 95 yd south of the runner camp on the Ratchet road: the row and, once clicked, the arrow agree.
w.moveTo(1413, 56.3, 34.0); stub.advance(0.6); stub.advance(0.6)
local i, v = zhevra()
local row = v and v.yards or false
if i then E.AimWhileHere(i); flush(); stub.advance(0.6) end
local x = E.GetWaypoint()
local c, px, py = Polestar.Compat.GetPlayerWorldPosition()
local wc, wx, wy = Polestar.Compat.MapToWorld(x.map, x.x, x.y, x.f)
local _, after = zhevra()
emit({{ nearest = math.floor(nearest()), row = row, after = after and after.yards or false, arrow = wc == c and math.floor(((wx - px) ^ 2 + (wy - py) ^ 2) ^ 0.5 + 0.5) or false, step = x.stepIndex }})
"#,
		loads.join("\n")
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() });
	assert_eq!(out[0]["live"], 15, "the Razormane camp step is live");
	assert_eq!(out[0]["arrow"], 15, "the arrow stays on the live step");
	assert!(out[0]["arrowYards"].as_f64().unwrap() > 500.0, "the camp is far off: {}", out[0]);
	assert_eq!(out[0]["step"], 39, "the spores' step, The Barrens: kill these as you meet them: {}", out[0]);
	assert_eq!(out[0]["text"], "Collect Fungal Spores from Laden Mushroom, 1 more", "{}", out[0]);
	assert_eq!(out[0]["yards"], 55, "to the centre of the mushrooms' spawn spot at the oasis: {}", out[0]);
	assert_eq!(out[0]["zhevra"], true, "the zhevra are a candidate too; the spores, found in fewer places, come first: {}", out[0]);
	let shown = out[0]["report"].as_str().unwrap();
	assert!(shown.starts_with("While here: Collect Fungal Spores from Laden Mushroom, 1 more · quest 848 · step ") && shown.contains("(guide 39) · 55 yd"), "{shown}");
	assert!(shown.contains(" · radius 180 yd · "), "{shown}");
	let both = out[1].as_str().unwrap();
	assert!(both.starts_with("18:1:") && both.split(' ').nth(1).is_some_and(|z| z.starts_with("39:3:")), "hooves (the route's next steps) then spores (later in the guide) at the oasis edge: {both}");
	assert_eq!(out[2], json!({ "gone": true, "back": true, "chimed": true }), "dismissed, 120 yd off, back at the same pool after two minutes: {}", out[2]);
	assert_eq!(out[3], json!("18:1 Collect Zhevra Hooves, 4 more 35"), "Fitz among the runners north of the oasis, their camp's centre 33 yd off");
	assert_eq!(out[4], json!("18:1 Collect Zhevra Hooves, 4 more 0"), "at a runner camp the zhevra show");
	assert_eq!(out[5][0], json!("none"), "ready to hand in: no line");
	let none = out[5][1].as_str().unwrap();
	assert!(none.starts_with("While here: none · radius 60 yd · ") && none.contains("nearest quest 845, step ") && none.ends_with("out of radius"), "{none}");
	let camp = &out[6];
	assert!(camp["nearest"].as_f64().unwrap() > 180.0, "no Zhevra spot within 180 yd of the camp: {camp}");
	assert_eq!(camp["shown"], false, "so no hooves row at the camp: {camp}");
	let road = &out[7];
	assert_eq!(road["step"], 18, "the arrow leads to the hooves: {road}");
	let (row, after, arrow) = (road["row"].as_f64().unwrap(), road["after"].as_f64().unwrap(), road["arrow"].as_f64().unwrap());
	assert!((row - arrow).abs() <= 5.0 && (after - arrow).abs() <= 5.0, "the row and the arrow say the same yards: {road}");
}

// Fitz: chasing one step's mobs through another step's objective, "I just do it, I'm here already". A big count
// shows, and a line in reach never expires, worked or not ("it shouldn't expire unless I move away from those
// areas").
#[test]
fn a_big_objective_shows_and_stays_while_the_player_stays_in_reach() {
	let out = run(r#"
		w.progress(7, 1, 0); flush()
		at(47.6, 37.6); emit(here())
		stub.advance(120); w.progress(7, 1, 4); flush()
		stub.advance(120); emit(here())              -- four minutes in, worked two minutes ago
		stub.advance(300); emit(here())              -- five more minutes with nothing, still in reach
	"#);
	assert_eq!(out, vec![json!("2:1 Kill Kobold Vermin, 10 more 50"), json!("2:1 Kill Kobold Vermin, 6 more 50"), json!("2:1 Kill Kobold Vermin, 6 more 50")]);
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
		vec![json!("none"), json!("2:1 Kill Kobold Vermin, 2 more 50"), json!("2:1 Kill Kobold Vermin, 2 more 90"), json!("none"), json!("none"), json!("2:1 Kill Kobold Vermin, 2 more 40")]
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

// Fitz: a dismiss mutes the objective, not for the whole zone. Staying there it never comes back, nor within 80 yd of
// that spot however long. Once the player has been 100 yd from it (HERE_DISMISS_AWAY) and two minutes have passed,
// it comes back in reach anywhere, the very spot it was dismissed at too (the spores grow at one pool).
#[test]
fn a_dismissed_line_stays_away_until_the_player_leaves_and_comes_back() {
	let out = run(r#"
		at(47.6, 37.6); emit(here())                     -- 50 yd south of the vermin
		emit(E.DismissWhileHere()); emit(here())
		stub.advance(300); emit(here())                  -- five minutes there
		at(47.6, 33.6); stub.advance(300); emit(here())  -- 80 yd north of that spot, the vermin 30 yd off: five more
		at(47.6, 43.6); at(47.6, 37.6); emit(here())     -- 120 yd off and back where it was dismissed
	"#);
	assert_eq!(out, vec![json!("2:1 Kill Kobold Vermin, 2 more 50"), json!(true), json!("none"), json!("none"), json!("none"), json!("2:1 Kill Kobold Vermin, 2 more 50")]);
}

// It comes back two minutes on at the earliest; dismissed a second time it stays away for the rest of the zone stay.
#[test]
fn a_dismissed_line_comes_back_two_minutes_on_and_dismissed_twice_stays_away_for_the_zone_stay() {
	let out = run(r#"
		at(47.6, 37.6); E.DismissWhileHere()
		at(47.6, 57.6); at(47.6, 32.6); emit(here())     -- away and back elsewhere at once: not yet
		stub.advance(121); emit(here())                  -- two minutes on: back
		emit(E.DismissWhileHere())
		at(47.6, 57.6); stub.advance(121); at(47.6, 32.6); emit(here())
		w.setZone("Westfall"); flush(); w.setZone("Elwynn Forest"); flush()
		at(47.6, 37.6); emit(here())                     -- a new zone stay
	"#);
	assert_eq!(out, vec![json!("none"), json!("2:1 Kill Kobold Vermin, 2 more 50"), json!(true), json!("none"), json!("2:1 Kill Kobold Vermin, 2 more 50")]);
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
	assert_eq!(out, vec![json!(["2:1 Kill Kobold Vermin, 2 more 50", "1:1"]), json!(true), json!("2:1"), json!(["none", "1:1"]), json!("none"), json!("8:1"), json!(["none", "1:1"])]);
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

// Hand-ins (Fitz: "the While-you're-here range for hand-ins shouldn't be the same as for objectives"). A hand-in costs
// a short walk to one NPC and a click, so it is weighed by its detour: the seconds of extra walking to visit the NPC
// and go on to where the arrow leads (straight lines 1.25 times longer at 7 yd/s, as the walking router counts open
// ground), at most behavior.whileHereTurninSeconds (20 by default), or any detour in the town the player rests in.
//
// The guide: 1 (live) the wolves at WOLVES,35.1 (where the arrow leads), the steps `between`, then Marshal Dughan's
// turn-in of 40 (ready) at 42,35.1 with `dughan` added to the goal. His step also hands in Kobold Camp Cleanup (7), not
// done yet: the route comes back to him whatever happens, so handing 40 in now saves no trip (no Own.hereVisit).
fn turnins(wolves: f64, between: &[&str], dughan: &str) -> String {
	let mut steps = vec![format!(r#"{{ title = "Wolves", goals = {{ {{ t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = {wolves}, y = 35.1 }} }} }}"#)];
	steps.extend(between.iter().map(|s| s.to_string()));
	steps.push(format!(
		r#"{{ title = "Dughan", goals = {{ {{ t = "turnin", quest = 40, title = "A Fishy Peril", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 42.0, y = 35.1{dughan} }},
			{{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 42.0, y = 35.1 }} }} }}"#
	));
	format!(
		r#"Polestar.RegisterGuide({{ id = "test/turnins", pack = "test", title = "Turnins", minLevel = 1, maxLevel = 10, steps = {{
{}
}} }})"#,
		steps.join(",\n")
	)
}

// A step with nothing to do around here (88 is not in the log), one at Marshal Dughan (an accept of 106), and a walk
// far south (900 yd from Dughan).
const ELSEWHERE: &str = r#"{ title = "Bandits", goals = { { t = "kill", target = "Defias Bandit", npc = 116, count = 2, quest = 88, oi = 1, map = 1429, x = 30.0, y = 80.0 } } }"#;
const AT_DUGHAN: &str = r#"{ title = "Errand", goals = { { t = "accept", quest = 106, title = "Young Lovers", npc = 240, npcName = "Marshal Dughan", qlvl = 9, map = 1429, x = 42.0, y = 35.1 } } }"#;
const FAR: &str = r#"{ title = "South", goals = { { t = "goto", map = 1429, x = 30.0, y = 80.0 } } }"#;

fn run_turnins(guide: &str, script: &str) -> Vec<Value> {
	run_guide_with(guide, "test/turnins", "", script)
}

// 60 yd west of Dughan with the arrow leading west to the wolves (20,35.1): he is behind, 120 yd there and back,
// 21 s out of the way. Out of town that is over the 20 s; in town (the inn's rest area) he shows. The old rule showed
// a hand-in only within 30 yd of its NPC.
#[test]
fn an_npc_60_yards_off_in_town_shows_out_of_town_its_detour_decides() {
	let out = run_turnins(
		&turnins(20.0, &[ELSEWHERE, ELSEWHERE], ""),
		r#"
		emit({ wp(), cands() })
		at(40.0, 35.1); emit({ here(), E.WhileHereState().why, E.WhileHereState().nearest.detour })
		w.resting = true; at(40.0, 35.1); emit(here())
		w.resting = false; at(44.0, 35.1); emit(here())    -- 60 yd east of him: on the way west, nothing out of it
	"#,
	);
	assert_eq!(
		out,
		vec![
			json!(["1:1", "4:1:turnin:0"]),
			json!(["none", "out of the way (21 s, over 20 s)", 21]),
			json!("4:1 Hand in “A Fishy Peril” to Marshal Dughan 60"),
			json!("4:1 Hand in “A Fishy Peril” to Marshal Dughan 60")
		]
	);
}

// "Hand-ins: how far out of your way": 0 to 60 s, 20 by default. At 25 the 21 s detour shows; at 0 only one in town
// does (it goes once its detour is past 10 s); hand-ins off, none is a candidate.
#[test]
fn the_setting_sets_how_far_out_of_the_way_a_hand_in_may_be() {
	let out = run_turnins(
		&turnins(20.0, &[ELSEWHERE, ELSEWHERE], ""),
		r#"
		emit(Polestar.Get("behavior.whileHereTurninSeconds"))
		at(40.0, 35.1); emit(here())
		Polestar.Set("behavior.whileHereTurninSeconds", 25); flush()
		at(40.0, 35.1); emit(here())
		Polestar.Set("behavior.whileHereTurninSeconds", 0); flush()
		at(40.0, 35.1); emit(here())                     -- 21 s: past 0 and 10 more, it goes
		at(41.7, 35.1); emit(here())                     -- 9 yd behind him, 3 s: not at 0
		w.resting = true; at(41.7, 35.1); emit(here())   -- in town: it shows at 0 too
		Polestar.Set("behavior.whileHereTurnins", false); flush()
		emit({ cands(), here() })
	"#,
	);
	assert_eq!(
		out,
		vec![
			json!(20),
			json!("none"),
			json!("4:1 Hand in “A Fishy Peril” to Marshal Dughan 60"),
			json!("none"),
			json!("none"),
			json!("4:1 Hand in “A Fishy Peril” to Marshal Dughan 10"),
			json!(["", "none"])
		]
	);
}

// A river at x = 43 (the router's stand-in: crossing it is a 2-minute walk round). The arrow leads east to the wolves
// (60,35.1). 45 yd east of Dughan, across the river from him: 16 s out of the way in straight lines, but there, back
// over the river and on is 256 s more than going straight on: no line, and the walk is not asked again until the
// player has moved. Over the bridge, 15 yd from him, the way east crosses the river anyway: 5 s, it shows.
const RIVER: &str = r#"
Polestar.Nav = { EstimateTravel = function(from, to)
	local ax, ay
	if from then ax, ay = from.x, from.y else local _; _, ax, ay = Polestar.Compat.GetPlayerMapPosition() end
	ASKED = (ASKED or 0) + 1
	local s = (((to.x - ax) * 30) ^ 2 + ((to.y - ay) * 20) ^ 2) ^ 0.5 * 1.25 / 7
	if (ax < 43) ~= (to.x < 43) then s = s + 120 end
	return s
end }
"#;

#[test]
fn an_npc_across_a_river_with_a_two_minute_walk_does_not_show() {
	let out = run_turnins(
		&turnins(60.0, &[ELSEWHERE, ELSEWHERE], ""),
		&format!(
			"{RIVER}{}",
			r#"
		at(43.5, 35.1); emit({ here(), E.WhileHereState().why })
		local asked = ASKED
		stub.advance(5); emit(ASKED == asked)              -- standing there: not asked again
		at(42.5, 35.1); emit(here())
	"#
		),
	);
	assert_eq!(out, vec![json!(["none", "turned away (the walk is too far out of the way; checked again in 15 s or 25 yd)"]), json!(true), json!("4:1 Hand in “A Fishy Peril” to Marshal Dughan 15")]);
}

// Never on another floor: the NPC's height (`z`, 40) against the player's floor (Nav's walking engine) more than 8 yd
// apart is Undercity's level below or a Thunder Bluff rise up a lift.
#[test]
fn never_a_hand_in_on_another_floor() {
	let out = run_turnins(
		&turnins(20.0, &[ELSEWHERE, ELSEWHERE], ", z = 40"),
		r#"
		FLOOR = 0
		Polestar.Nav = { walk = { Floor = function() return FLOOR end } }
		at(42.0, 35.6); emit({ here(), E.WhileHereState().why })
		FLOOR = 38; stub.advance(15); at(42.0, 35.6); emit(here())
	"#,
	);
	assert_eq!(out, vec![json!(["none", "turned away (another floor; checked again in 15 s or 25 yd)"]), json!("4:1 Hand in “A Fishy Peril” to Marshal Dughan 10")]);
}

// A hand-in the route walks to about now, without leading away first, is left to it: the arrow leads east to the
// wolves at 44 (60 yd past Dughan, on the way), and his hand-in is the next step, or the step after next is at Dughan
// (an accept), or a step at him comes after two with nothing for this character (88 is not in the log: the route
// passes them; 0.3.7 counts the walk, not the steps). Standing at him (10 yd, within 0.3.5's 30) it shows all the
// same. A step that leads away first (a walk 900 yd south) or a live step that does (the wolves 660 yd west, Fitz
// walking past Seer Graytongue with Grull 530 yd north) leaves it to the detour rule.
#[test]
fn a_hand_in_the_route_reaches_next_without_leading_away_shows_only_at_its_npc() {
	let script = r#"
		at(40.0, 35.1); emit({ cands(), here(), E.WhileHereState().why })
		at(42.0, 35.6); emit(here())
	"#;
	let next = run_turnins(&turnins(44.0, &[], ""), script);
	let errand = run_turnins(&turnins(44.0, &[AT_DUGHAN, ELSEWHERE], ""), script);
	let away = run_turnins(&turnins(44.0, &[FAR, AT_DUGHAN], ""), script);
	let behind = run_turnins(&turnins(20.0, &[], ""), script);
	let later = run_turnins(&turnins(44.0, &[ELSEWHERE, ELSEWHERE, AT_DUGHAN], ""), script);
	let left = "left to the route (it goes there next; shows within 30 yd)";
	assert_eq!(next, vec![json!(["2:1:turnin:0", "none", left]), json!("2:1 Hand in “A Fishy Peril” to Marshal Dughan 10")], "his hand-in is the next step");
	assert_eq!(errand, vec![json!(["4:1:turnin:0", "none", left]), json!("4:1 Hand in “A Fishy Peril” to Marshal Dughan 10")], "the step after next is at Dughan");
	assert_eq!(away[0], json!(["4:1:turnin:0", "4:1 Hand in “A Fishy Peril” to Marshal Dughan 60"]), "the walk south first");
	assert_eq!(behind, vec![json!(["2:1:turnin:0", "none", "out of the way (21 s, over 20 s)"]), json!("2:1 Hand in “A Fishy Peril” to Marshal Dughan 10")], "the wolves 660 yd west first");
	assert_eq!(later[0], json!(["5:1:turnin:0", "none", left]), "two steps with nothing to do, then a step at him");
	// A quest named after its NPC: the plain line does not name him twice.
	let namesake = run_turnins(&turnins(44.0, &[], r#", title = "Marshal Dughan""#), script);
	assert_eq!(namesake[1], json!("2:1 Hand in “Marshal Dughan” to them 10"), "{namesake:?}");
}

// 0.3.7 (the Dynamic Questing audits): "soon" is measured by walking, not by "the next 2 steps" (27 hand-ins waited
// while the route walked 150 yd and more away first and came back). The wolves at 47 are 150 yd east of Dughan: the
// route walks there and then back to his hand-in (the very next step), so from 60 yd west of him, on the way east,
// the hand-in shows now. Three errands 30 yd from him (another NPC's accepts) before his hand-in keep the route by
// him: it is left to the guide, three steps on or not.
const NEAR_ERRAND: &str = r#"{ title = "Errand", goals = { { t = "accept", quest = 107, title = "Errand", npc = 241, npcName = "Errand Giver", map = 1429, x = 43.0, y = 35.1 } } }"#;

#[test]
fn a_hand_in_waits_for_the_route_by_its_walk_not_by_its_steps() {
	let script = r#"
		at(40.0, 35.1)
		local soon = "none"
		for _, c in ipairs(E.GetWhileHereCandidates()) do if c.kind == "turnin" then soon = c.soon end end
		emit({ soon, here() })
	"#;
	let away = run_turnins(&turnins(47.0, &[], ""), script);
	assert_eq!(away, vec![json!([false, "2:1 Hand in “A Fishy Peril” to Marshal Dughan 60"])], "the route walks 150 yd away first");
	let town = run_turnins(&turnins(44.0, &[NEAR_ERRAND, NEAR_ERRAND, NEAR_ERRAND], ""), script);
	assert_eq!(town, vec![json!([true, "none"])], "the route stays by him for three steps");
}

// Fitz on 0.3.6 (build f5fbd242a), his /polestar report: a level 3 Tauren Warrior on Mulgore's Grull Hawkwind step
// (hand in The Hunt Continues, 750; the arrow 411 yd north at 44.47,77.50), standing at 42.79,87.19 on Red Cloud Mesa,
// 121 yd from Seer Graytongue (2982, 42.54,90.13), with Rites of the Earthmother (755), 750 and 1656 ready: "While
// here: none" while the route went to Grull first and came back south ("I'm here and you'd expect it to send me
// backwards to grab the dynamic quest behind"). Since 0.3.7 the route itself goes there: the Seer's visit (755 in,
// Grace of An'she and Mu'sha and Rite of Strength out) and the shrine's Ritual Fire come at the end of the cougar
// hunt, then Grull. With the pelts done the live step is the Seer's, its arrow on her, from his spot and from
// Grull's tent alike; at her window auto turn-in hands 755 in and auto-accept takes both quests, and the route goes
// on to the shrine. Still hunting cougars beside her tent (6 pelts of 10), the hunt leads on away from her, so the
// whole visit shows, as on Fitz's 0.3.6 report: at her window the hand-in and both accepts are taken ahead, the live
// step stays the hunt and her step reads done. Grace is timed (ten minutes, its `limit`): the walk on to the Ritual
// Fire fits; with a two-minute limit it would not, so Grace is not taken ahead; nor is an escort (#1618).
// The guide as shipped (guides/forever/horde/tauren/01-mulgore.guide, compiled with data/forever; skipped with a
// note without it).
#[test]
fn mulgore_fitz_walking_past_seer_graytongue_with_rites_of_the_earthmother_ready_is_led_to_her_by_the_route() {
	use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
	use forge_addontest::run::root;
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let file = "guides/forever/horde/tauren/01-mulgore.guide";
	let text = std::fs::read_to_string(root().join(file)).unwrap();
	let compiled = compile_with(&[(file, &text)], &data, None);
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let loads: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let f = data.map_frames.get("forever").get("1412");
	// pelts: 750's count (10: ready, the hunt done); limit: Grace's seconds (the data's 600 once rebuilt with its
	// correction; set here so the test does not wait for the data build).
	let run = |pelts: u32, limit: u32, escort: bool| {
		let escort = if escort { "true" } else { "nil" };
		let before = format!(
			r#"local w = stub.world
w.addMap(1412, {{ name = "Mulgore", c = {}, left = {}, right = {}, top = {}, bottom = {} }})
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Tauren", "Tauren", "WARRIOR", "WARRIOR", "Horde", 3
w.zone, w.subzone = "Mulgore", "Red Cloud Mesa"
w.moveTo(1412, 44.47, 79.0)
w.complete({{ 752, 747, 753, 3091 }})
w.onQuest(755, {{}}); w.onQuest(1656, {{}})
w.onQuest(750, {{ {{ text = "Mountain Cougar Pelt: {pelts}/10", type = "item", required = 10, fulfilled = {pelts} }} }})
w.addItem(4742, {pelts})
"#,
			f.get("c").to_js_string(),
			f.get("left").to_js_string(),
			f.get("right").to_js_string(),
			f.get("top").to_js_string(),
			f.get("bottom").to_js_string()
		);
		let script = format!(
			r#"do local ns = {{}}
{}
end
stub.login()
stub.fire("QUEST_LOG_UPDATE")
{HELPERS}
E.SetGuide("forever/horde/tauren/01-mulgore"); flush()
stub.fire("QUEST_LOG_UPDATE"); flush()
local steps = E.GetGuide().steps
local seer
for i, st in ipairs(steps) do if not seer then for _, g in ipairs(st.goals) do if g.t == "turnin" and g.quest == 755 then seer = i end end end end
for _, g in ipairs(steps[seer].goals) do if g.quest == 95805 then g.limit = {limit}; g.escort = {escort} end end
stub.fire("QUEST_LOG_UPDATE"); flush()
local function mg(x, y) w.moveTo(1412, x, y); stub.advance(0.6); stub.advance(0.6) end
local function state()
	local st = E.WhileHereState()
	local v = E.GetWhileHere()
	local live = E.GetLiveStep()
	return {{ live = live, title = steps[live] and steps[live].title or false, arrow = wp(), here = v and (v.step .. ":" .. v.index .. " " .. v.hereText) or "none", why = st.why or false }}
end
mg(44.47, 79.0); local camp = state()
mg(42.79, 87.19); local report = state()
-- At the Seer: her windows, as the game opens them after each hand-in and accept.
mg(42.54, 89.95)
w.calls = {{}}
w.questProgress(2982, 755); flush()
w.questDetail(2982, 95805); flush()
w.questDetail(2982, 757); flush()
local calls = {{}}
for i, x in ipairs(w.calls) do calls[i] = tostring(x[1]) .. " " .. tostring(x[2]) end
local done = {{}}
for g = 1, #steps[seer].goals do done[g] = E.GoalDone(seer, g) end
local after = state()
emit({{ seer = seer, camp = camp, report = report, calls = table.concat(calls, ", "), after = after, done = done }})
"#,
			loads.join("\n")
		);
		emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() }).remove(0)
	};
	let fitz = run(10, 600, false);
	let seer = fitz["seer"].as_u64().expect("a step hands 755 in");
	assert_eq!(fitz["report"]["live"], seer, "121 yd from the Seer, her step is live: {fitz}");
	assert_eq!(fitz["report"]["title"], "Seer Graytongue", "{fitz}");
	assert!(fitz["report"]["arrow"].as_str().unwrap().starts_with(&format!("{seer}:")), "the arrow on the Seer, not 411 yd north at Grull: {fitz}");
	assert_eq!(fitz["report"]["here"], "none", "the route itself is there: no While-here line: {fitz}");
	assert_eq!(fitz["camp"]["live"], seer, "from Grull's tent the route sends him south to the Seer before Grull: {fitz}");
	let calls = fitz["calls"].as_str().unwrap();
	assert!(calls.contains("GetQuestReward 755") && calls.contains("AcceptQuest 95805") && calls.contains("AcceptQuest 757"), "hand-in and both accepts: {calls}");
	assert_eq!(fitz["done"], json!([true, true, true]), "her step is done: {fitz}");
	assert_eq!(fitz["after"]["live"], seer + 1, "on to the next step: {fitz}");
	assert_eq!(fitz["after"]["title"], "The shrine of An'she and Mu'sha", "the shrine next, not back north to Grull: {fitz}");
	let visit = format!("{seer}:1 Hand in “Rites of the Earthmother” to Seer Graytongue, then take “Grace of An'she and Mu'sha”, “Rite of Strength”: saves a trip back");
	let cougars = run(6, 600, false);
	assert_eq!(cougars["report"]["live"], seer - 1, "the cougar step is live: {cougars}");
	assert_eq!(cougars["report"]["title"], "The Hunt Continues", "{cougars}");
	assert_eq!(cougars["report"]["here"], visit.as_str(), "hunting cougars around her tent, the whole visit shows: {cougars}");
	let calls = cougars["calls"].as_str().unwrap();
	assert!(calls.contains("GetQuestReward 755") && calls.contains("AcceptQuest 95805") && calls.contains("AcceptQuest 757"), "hand-in and both accepts ahead: {calls}");
	assert_eq!(cougars["after"]["live"], seer - 1, "the hunt stays live: {cougars}");
	assert_eq!(cougars["done"], json!([true, true, true]), "her step is done: no trip back: {cougars}");
	let short = run(6, 120, false);
	assert_eq!(short["report"]["here"], "none", "a two-minute Grace: no visit, the bare hand-in out of the way: {short}");
	assert_eq!(short["report"]["why"], "out of the way (37 s, over 20 s)", "{short}");
	let calls = short["calls"].as_str().unwrap();
	assert!(!calls.contains("AcceptQuest 95805") && calls.contains("AcceptQuest 757"), "Grace not taken ahead, Rite of Strength is: {calls}");
	// #1618 (MattMer, Protect Kaya): an escort is never taken ahead, like a timed quest whose walk does not fit: it
	// starts walking the moment it is taken, so only its own step, with its warning, takes it.
	let escort = run(6, 600, true);
	assert_eq!(escort["report"]["here"], "none", "an escort Grace: no visit offering it: {escort}");
	assert!(!escort["calls"].as_str().unwrap().contains("AcceptQuest 95805"), "the escort not taken ahead: {escort}");
}

// The Barrens as shipped: an Orc Warrior at 14, in from Far Watch Post on the road west, 60 yd past Thun'grim Firegaze
// (5878) with his breadcrumb (1502, "Thun'grim Firegaze") ready, while the guide's step 3 sends him 449 yd on to the
// Crossroads and step 4 brings him back east. The whole visit shows, and the quest named after its NPC is not said
// twice ("… to them"). At his window 1502 is handed in and Forged Steel (1503) taken ahead; step 4 reads done.
#[test]
fn barrens_thungrim_firegaze_a_quest_named_after_its_npc_is_handed_in_to_them() {
	use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
	use forge_addontest::run::root;
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let file = "guides/forever/horde/02-the-barrens.guide";
	let text = std::fs::read_to_string(root().join(file)).unwrap();
	let compiled = compile_with(&[(file, &text)], &data, None);
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let loads: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let f = data.map_frames.get("forever").get("1413");
	let before = format!(
		r#"local w = stub.world
w.addMap(1413, {{ name = "The Barrens", c = {}, left = {}, right = {}, top = {}, bottom = {} }})
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Orc", "Orc", "WARRIOR", "WARRIOR", "Horde", 14
w.zone, w.subzone = "The Barrens", ""
w.moveTo(1413, 52.2, 31.0)
w.complete({{ 1498 }})
w.onQuest(842, {{}}); w.onQuest(1502, {{}})
"#,
		f.get("c").to_js_string(),
		f.get("left").to_js_string(),
		f.get("right").to_js_string(),
		f.get("top").to_js_string(),
		f.get("bottom").to_js_string()
	);
	let script = format!(
		r#"do local ns = {{}}
{}
end
stub.login()
stub.fire("QUEST_LOG_UPDATE")
{HELPERS}
E.SetGuide("forever/horde/02-the-barrens"); flush()
w.moveTo(1413, 56.64, 30.42); stub.advance(0.6); stub.advance(0.6)
local rows = {{}}
for _, v in ipairs(E.GetWhileHereList()) do rows[#rows + 1] = v.step .. ":" .. v.index .. " " .. v.hereText end
local live = E.GetLiveStep()
-- The guide window's row for step 4's hand-in: the quest, no "at Thun'grim Firegaze" after it.
local g4 = E.GetStepView(4).goals[1]
local row4 = {{ verb = g4.verb, subject = g4.subject, detail = g4.detail or false }}
w.moveTo(1413, 57.2, 30.35); stub.advance(0.6); stub.advance(0.6)
w.calls = {{}}
w.questProgress(5878, 1502); flush()
w.questDetail(5878, 1503); flush()
local calls = {{}}
for _, x in ipairs(w.calls) do if x[1] == "AcceptQuest" or x[1] == "GetQuestReward" then calls[#calls + 1] = x[1] .. " " .. tostring(x[2]) end end
emit({{ live = live, rows = rows, row4 = row4, calls = table.concat(calls, ", "), after = E.GetLiveStep(), done = {{ E.GoalDone(4, 1), E.GoalDone(4, 2) }} }})
"#,
		loads.join("\n")
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() }).remove(0);
	assert_eq!(out["live"], 3, "the Crossroads step is live: {out}");
	let visit = "4:1 Hand in “Thun'grim Firegaze” to them, then take “Forged Steel”: saves a trip back";
	assert!(out["rows"].as_array().unwrap().iter().any(|r| r == visit), "{out}");
	assert_eq!(out["calls"], "GetQuestReward 1502, AcceptQuest 1503", "{out}");
	assert_eq!(out["after"], 3, "{out}");
	assert_eq!(out["done"], json!([true, true]), "{out}");
	assert_eq!(out["row4"], json!({ "verb": "Turn in", "subject": "Thun'grim Firegaze", "detail": false }), "{out}");
}

// Fitz on the 0.3.6 build: an Undead Warlock at 13 on The Barrens' "Razormane camp" step, Disrupt the Attacks (871)
// done, went to the Crossroads. While-here offered 871's hand-in to Thork (3429), auto turn-in handed it in, and the
// window the game then opened with the follow-up The Disruption Ends (872), which the route's Crossroads step takes
// at Thork, closed without it. Now auto-accept takes it there (the route's next steps' accept at that NPC), the live
// step stays, and the Crossroads step's accept reads done. With auto-accept off, While-here offers it as a line
// while the player stands at Thork. The guide as shipped (compiled with data/forever; skipped without it).
#[test]
fn barrens_thork_after_handing_in_disrupt_the_attacks_the_follow_up_is_taken_there() {
	use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
	use forge_addontest::run::root;
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let file = "guides/forever/horde/02-the-barrens.guide";
	let text = std::fs::read_to_string(root().join(file)).unwrap();
	let compiled = compile_with(&[(file, &text)], &data, None);
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let loads: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let f = data.map_frames.get("forever").get("1413");
	let run = |auto: bool| {
		let before = format!(
			r#"local w = stub.world
w.addMap(1413, {{ name = "The Barrens", c = {}, left = {}, right = {}, top = {}, bottom = {} }})
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Scourge", "Undead", "WARLOCK", "WARLOCK", "Horde", 13
w.zone, w.subzone = "The Barrens", "The Crossroads"
w.moveTo(1413, 51.5, 30.9)
w.complete({{ 1358 }})
w.onQuest(844, {{ {{ text = "Plainstrider Beak: 3/7", type = "item", required = 7, fulfilled = 3 }} }})
w.onQuest(869, {{ {{ text = "Raptor Head: 4/12", type = "item", required = 12, fulfilled = 4 }} }})
w.onQuest(1492, {{}})
w.onQuest(848, {{ {{ text = "Fungal Spores: 0/1", type = "item", required = 1, fulfilled = 0 }} }})
w.onQuest(5041, {{ {{ text = "Supplies for the Crossroads: 0/1", type = "item", required = 1, fulfilled = 0 }} }})
w.onQuest(871, {{ {{ required = 8, fulfilled = 8 }}, {{ required = 8, fulfilled = 8 }}, {{ required = 3, fulfilled = 3 }} }})
w.onQuest(867, {{ {{ text = "Witchwing Talon: 0/8", type = "item", required = 8, fulfilled = 0 }} }})
w.onQuest(870, {{ 1 }})
w.bindLocation = "The Crossroads"
"#,
			f.get("c").to_js_string(),
			f.get("left").to_js_string(),
			f.get("right").to_js_string(),
			f.get("top").to_js_string(),
			f.get("bottom").to_js_string()
		);
		let script = format!(
			r#"do local ns = {{}}
{}
end
stub.login()
stub.fire("QUEST_LOG_UPDATE")
{HELPERS}
Polestar.Set("behavior.autoAccept", {auto})
E.SetGuide("forever/horde/02-the-barrens"); flush()
local G = E.GetGuide()
local cross
for s, step in ipairs(G.steps) do
	for g, goal in ipairs(step.goals) do if goal.t == "accept" and goal.quest == 872 then cross = {{ s, g }} end end
end
local live = E.GetLiveStep()
local liveTitle = G.steps[live].title
-- At Thork (51.5, 30.9): his hand-in, then the window the game opens with the follow-up.
w.moveTo(1413, 51.5, 30.95); stub.advance(0.6); stub.advance(0.6)
local shown = here()
w.calls = {{}}
-- The server's order: the follow-up's window opens on the reward before the quest log and the completed flag
-- catch up (QUEST_TURNED_IN, then the log, a moment later).
function GetQuestReward(choice)
	local f = w.frame
	w.calls[#w.calls + 1] = {{ "GetQuestReward", f and f.questID, choice }}
	w.questDetail(3429, 872)
	stub.advance(0.1)
	w.turnIn(f.questID)
end
w.questProgress(3429, 871); flush()
local calls = {{}}
for _, x in ipairs(w.calls) do calls[#calls + 1] = tostring(x[1]) .. " " .. tostring(x[2]) end
local open = w.frame and w.frame.kind == "detail" and w.frame.questID or false
w.close(); stub.advance(0.6); stub.advance(0.6)
local lines = {{}}
for _, v in ipairs(E.GetWhileHereList()) do lines[#lines + 1] = v.step .. ":" .. v.index .. " " .. v.hereText end
emit({{ live = live, liveTitle = liveTitle, shown = shown, calls = table.concat(calls, ", "), open = open, after = E.GetLiveStep(),
	crossDone = E.GoalDone(cross[1], cross[2]), on872 = w.log[872] ~= nil, lines = lines, cross = cross[1] }})
"#,
			loads.join("\n")
		);
		emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() }).remove(0)
	};
	let on = run(true);
	assert_eq!(on["liveTitle"], "Razormane camp", "{on}");
	assert!(on["calls"].as_str().unwrap().contains("GetQuestReward 871"), "871 handed in: {on}");
	assert!(on["calls"].as_str().unwrap().contains("AcceptQuest 872"), "872 taken at Thork: {on}");
	assert_eq!(on["after"], on["live"], "the live step stays: {on}");
	assert_eq!(on["crossDone"], true, "the Crossroads step's accept of 872 reads done: {on}");
	let off = run(false);
	assert_eq!(off["on872"], false, "{off}");
	let line = format!("{}:", off["cross"]);
	assert!(
		off["lines"].as_array().is_some_and(|a| a.iter().any(|l| l.as_str().is_some_and(|l| l.starts_with(&line) && l.contains("Take “The Disruption Ends” from Thork: saves a trip back")))),
		"the take-it-here line: {off}"
	);
}

// Pick-ups (Fitz on 0.3.6, d73f48ac6): the same Undead Warlock at 14 on The Barrens' "Razormane camp" step (15),
// Disrupt the Attacks (871) handed in before the session, Plainstrider Menace (844) handed in and The Zhevra (845)
// taken ahead of the route, the Supply Crates for 5041 still to find. Walking up to Thork (3429), While you're here
// shows the quest the route takes from him two steps on (17), The Disruption Ends (872): "Take “The Disruption Ends”
// from Thork: saves a trip back", with auto-accept on or off, before he talks to anyone. A click points the arrow at
// Thork; taken (from his gossip by auto-accept, or by hand), the line goes, step 17's accept reads done, the live
// step stays, 872's objectives at the Razormane camp come up as lines and its hand-in stays where the guide has it;
// the crates handed in at 17, the route goes on past it, never back to the accept. The guide as shipped (compiled
// with data/forever; skipped without it).
// A list the addon emitted (an empty Lua table comes out as {}).
fn list(v: &Value) -> Vec<Value> {
	v.as_array().cloned().unwrap_or_default()
}

fn thork(completed: &str, extra: &str, script: &str) -> Option<Value> {
	use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
	use forge_addontest::run::root;
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return None;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let file = "guides/forever/horde/02-the-barrens.guide";
	let text = std::fs::read_to_string(root().join(file)).unwrap();
	let compiled = compile_with(&[(file, &text)], &data, None);
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let loads: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let f = data.map_frames.get("forever").get("1413");
	let before = format!(
		r#"local w = stub.world
w.addMap(1413, {{ name = "The Barrens", c = {}, left = {}, right = {}, top = {}, bottom = {} }})
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Scourge", "Undead", "WARLOCK", "WARLOCK", "Horde", 14
w.zone, w.subzone = "The Barrens", "The Crossroads"
w.moveTo(1413, 56.0, 30.87)
w.complete({{ 1358, 844, {completed} }})
w.onQuest(845, {{ {{ text = "Zhevra Hooves: 2/4", type = "item", required = 4, fulfilled = 2 }} }})
w.onQuest(869, {{ {{ text = "Raptor Head: 4/12", type = "item", required = 12, fulfilled = 4 }} }})
w.onQuest(1492, {{}})
w.onQuest(848, {{ {{ text = "Fungal Spores: 0/1", type = "item", required = 1, fulfilled = 0 }} }})
w.onQuest(5041, {{ {{ text = "Supplies for the Crossroads: 0/1", type = "item", required = 1, fulfilled = 0 }} }})
w.onQuest(867, {{ {{ text = "Witchwing Talon: 0/8", type = "item", required = 8, fulfilled = 0 }} }})
w.onQuest(870, {{ 1 }})
w.bindLocation = "The Crossroads"
{extra}
"#,
		f.get("c").to_js_string(),
		f.get("left").to_js_string(),
		f.get("right").to_js_string(),
		f.get("top").to_js_string(),
		f.get("bottom").to_js_string()
	);
	let script = format!(
		r#"do local ns = {{}}
{}
end
stub.login()
stub.fire("QUEST_LOG_UPDATE")
{HELPERS}
C_QuestLog.GetMaxNumQuestsCanAccept = function() return 0 end
E.SetGuide("forever/horde/02-the-barrens"); flush()
G = E.GetGuide()
for s, step in ipairs(G.steps) do
	for g, goal in ipairs(step.goals) do
		if goal.t == "accept" and goal.quest == 872 and not cross then cross = {{ s, g }} end
		if goal.t == "turnin" and goal.quest == 872 and not handin then handin = {{ s, g }} end
	end
end
function go(x, y) w.moveTo(1413, x, y); stub.advance(0.6); stub.advance(0.6) end
-- Every line shown: "step:index text" (later: "… [later]").
function rows()
	local out = {{}}
	for _, v in ipairs(E.GetWhileHereList()) do out[#out + 1] = v.step .. ":" .. v.index .. " " .. v.hereText .. (v.later and " [later]" or "") end
	return out
end
function takeRow()
	for i, v in ipairs(E.GetWhileHereList()) do if v.here == "take" and v.quest == 872 then return i, v end end
	return nil
end
OBJ872 = {{ {{ text = "Razormane Geomancer slain: 0/8", type = "monster", required = 8, fulfilled = 0 }},
	{{ text = "Razormane Defender slain: 0/8", type = "monster", required = 8, fulfilled = 0 }},
	{{ text = "Kreenig Snarlsnout's Tusk: 0/1", type = "item", required = 1, fulfilled = 0 }} }}
{script}
"#,
		loads.join("\n")
	);
	Some(emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() }).remove(0))
}

const THORK_TAKE: &str = r#"
Polestar.Set("behavior.autoAccept", AUTO)
local live = E.GetLiveStep()
local far = rows()
go(51.75, 30.95)
local near = rows()
local i = takeRow()
local arrow = false
if i then E.AimWhileHere(i); flush(); local x = E.GetWaypoint(); arrow = x and (x.stepIndex .. ":" .. x.goalIndex) or false end
w.calls = {}
if AUTO then
	w.gossip(3429, { available = { { questID = 872, objectives = OBJ872 } }, active = { { questID = 5041 } } }); flush(); flush()
else
	w.questDetail(3429, 872, { objectives = OBJ872 }); AcceptQuest(); flush()
end
stub.advance(0.6); stub.advance(0.6)
local after = { rows = rows(), live = E.GetLiveStep(), crossDone = E.GoalDone(cross[1], cross[2]), on872 = w.log[872] ~= nil,
	handinDone = E.GoalDone(handin[1], handin[2]) }
-- 872's objectives at the Razormane camp's western half, the crates (the live step) further east.
go(56.8, 24.6)
local camp = rows()
-- The crates found: the route goes to Thork for their hand-in (17), and on past it once handed in.
w.progress(5041, 1, 1); flush(); stub.advance(0.6)
local atCross = E.GetLiveStep()
w.turnIn(5041); flush(); stub.advance(0.6)
emit({ cross = cross[1], handin = handin[1], live = live, far = far, near = near, arrow = arrow, after = after, camp = camp,
	atCross = atCross, past = E.GetLiveStep() })
"#;

#[test]
fn barrens_walking_up_to_thork_the_disruption_ends_is_a_pick_up_line_with_auto_accept_on_or_off() {
	for auto in [true, false] {
		let Some(out) = thork("871", "", &THORK_TAKE.replace("AUTO", if auto { "true" } else { "false" })) else { return };
		let take = format!("{}:", out["cross"]);
		let is_take = |l: &Value| l.as_str().is_some_and(|l| l.starts_with(&take) && l.contains("Take “The Disruption Ends” from Thork: saves a trip back"));
		assert_eq!(out["live"], 15, "the Razormane camp step is live: {out}");
		assert!(!list(&out["far"]).iter().any(is_take), "450 yd east: no pick-up: {out}");
		assert!(list(&out["near"]).iter().any(is_take), "at Thork, auto-accept {auto}: the pick-up line: {out}");
		assert_eq!(out["arrow"], format!("{}:{}", out["cross"], 5), "a click points the arrow at Thork's accept: {out}");
		let after = &out["after"];
		assert_eq!(after["on872"], true, "taken: {out}");
		assert!(!list(&after["rows"]).iter().any(is_take), "the line goes once it is taken: {out}");
		assert_eq!(after["live"], 15, "the live step stays: {out}");
		assert_eq!(after["crossDone"], true, "step 17's accept reads done: {out}");
		assert_eq!(after["handinDone"], false, "the hand-in stays where the guide has it: {out}");
		assert!(out["handin"].as_u64().unwrap() > out["cross"].as_u64().unwrap() + 5, "{out}");
		assert!(list(&out["camp"]).iter().any(|l| l.as_str().is_some_and(|l| l.contains("Razormane Geomancer") || l.contains("Razormane Defender"))), "872's kills come up at the camp: {out}");
		assert_eq!(out["atCross"], out["cross"], "the crates found: on to Thork for their hand-in: {out}");
		assert!(out["past"].as_u64().unwrap() > out["cross"].as_u64().unwrap(), "handed in: on past the accept, never back to it: {out}");
	}
}

// The pick-up comes the moment its prerequisite is handed in, standing at Thork: no move needed; walked 450 yd away
// it goes, and back at Thork it comes again. Never while 871 is still in the log, nor for a quest the player left
// out, more than 2 levels over them (872 is level 15: not at 12), or with the log within LOG_SPARE of its 40.
#[test]
fn barrens_the_disruption_ends_comes_with_its_prerequisite_and_never_when_left_out_too_high_or_the_log_full() {
	let ready = "w.onQuest(871, { { required = 8, fulfilled = 8 }, { required = 8, fulfilled = 8 }, { required = 3, fulfilled = 3 } })";
	let script = r#"
Polestar.Set("behavior.autoAccept", false)
go(51.75, 30.95)
local before = rows()
w.turnIn(871); stub.advance(0.6); stub.advance(0.6)
local handed = rows()
go(56.0, 30.87)
local away = rows()
go(51.75, 30.95)
emit({ cross = cross[1], before = before, handed = handed, away = away, back = rows() })
"#;
	let Some(out) = thork("0", ready, script) else { return };
	let take = format!("{}:", out["cross"]);
	let has = |k: &str| list(&out[k]).iter().any(|l| l.as_str().is_some_and(|l| l.starts_with(&take) && l.contains("The Disruption Ends")));
	assert!(!has("before"), "871 still in the log: no pick-up: {out}");
	assert!(has("handed"), "871 handed in at Thork: the pick-up, without a step: {out}");
	assert!(!has("away"), "450 yd off: gone: {out}");
	assert!(has("back"), "back at Thork: again: {out}");
	let near = r#"
Polestar.Set("behavior.autoAccept", false)
PRE
go(51.75, 30.95)
emit({ cross = cross[1], rows = rows() })
"#;
	for (why, pre, extra) in
		[("left out", "E.SkipQuest(872); flush()", ""), ("two levels under 872's 15, minus one", "", "w.level = 12"), ("38 of the 40 slots", "", "for q = 1001, 1031 do w.onQuest(q, {}) end")]
	{
		let Some(out) = thork("871", extra, &near.replace("PRE", pre)) else { return };
		let take = format!("{}:", out["cross"]);
		assert!(!list(&out["rows"]).iter().any(|l| l.as_str().is_some_and(|l| l.starts_with(&take) && l.contains("The Disruption Ends"))), "{why}: no pick-up: {out}");
	}
}

// #1705: the Tattered Spellbook offers Old Habits only while Nek'rosh's Gambit (465) or Defeat Nek'rosh (474) is in
// the log, and the guide's step for it says so (`when onquest 465,474`, before the catapult that takes 465). While
// you're here and auto-accept read that step: with 465 in the log the book is a pick-up on the way; with 465 handed
// in and 474 never taken (a solo player), it is neither offered nor taken. Only the book's row is read: the catapult
// stands in reach of the book too, and what its own steps offer there is theirs.
#[test]
fn old_habits_is_offered_only_while_its_steps_gate_holds() {
	let guide = r#"
Polestar.RegisterGuide({
	id = "test/here", pack = "test", title = "Angerfang Encampment", minLevel = 1, maxLevel = 40,
	steps = {
		{ title = "To Deepwater Tavern", goals = { { t = "goto", map = 1429, x = 10.7, y = 61 } } },
		{ title = "Tattered Spellbook", when = { { k = "onquest", q = { 465, 474 } } }, goals = { { t = "accept", quest = 98223, object = 671518, title = "Old Habits", map = 1429, x = 53.48, y = 54.53 } } },
		{ title = "Catapult", goals = { { t = "turnin", quest = 465, title = "Nek'rosh's Gambit", object = 630696, map = 1429, x = 47.5, y = 47 } } },
		{ title = "Defeat Nek'rosh", goals = { { t = "accept", quest = 474, title = "Defeat Nek'rosh", object = 630696, pre = { 465 }, map = 1429, x = 47.5, y = 47 } } },
		{ title = "Chieftain Nek'rosh", goals = { { t = "collect", quest = 474, oi = 1, item = 3625, itemName = "Nek'rosh's Head", count = 1, map = 1429, x = 53.5, y = 54.7 } } },
	},
})
"#;
	let out = run_guide_with(
		guide,
		"test/here",
		r#"
w.accept(465, {})
w.setLevel(31)
Polestar.Set("behavior.whileHereRadius", 180)
flush()
"#,
		r#"
at(53.48, 54.53)
w.units.npc = "GameObject-0-1-0-1-671518-000001"
local function book() return (" " .. cands() .. " "):find(" 2:1:take:", 1, true) ~= nil end
emit({ step = E.GetLiveStep(), book = book(), wants = E.WantsQuest("accept", 98223) })
w.turnIn(465); flush()
emit({ step = E.GetLiveStep(), book = book(), wants = E.WantsQuest("accept", 98223) })
"#,
	);
	assert_eq!(out[0], json!({ "step": 1, "book": true, "wants": true }), "465 in the log: the book is a pick-up on the way");
	// Handed in at the catapult, 465's step is done and the guide follows on to Defeat Nek'rosh (step 4).
	assert_eq!(out[1], json!({ "step": 4, "book": false, "wants": false }), "465 handed in, 474 never taken: the book is neither offered nor taken");
}

#[test]
fn early_pickups_respect_active_parents_and_the_footlockers_hand_in_order() {
	let guide = r#"
Polestar.RegisterGuide({
	id = "test/here", pack = "test", title = "Pickup prerequisites", minLevel = 1, maxLevel = 40,
	steps = {
		{ title = "Live", goals = { { t = "kill", quest = 7, oi = 1, target = "Kobold Vermin", npc = 6, count = 10, map = 1429, x = 60, y = 60 } } },
		{ title = "Krusk", goals = { { t = "accept", quest = 533, title = "Infiltration", npc = 2229, map = 1429, x = 70, y = 70 } } },
		{ title = "Valik", goals = { { t = "accept", quest = 535, title = "Valik", parent = 533, npc = 2333, map = 1429, x = 47.5, y = 45 } } },
		{ title = "Syndicate Footlocker", goals = {
			{ t = "turnin", quest = 96783, title = "A Way In", object = 656157, map = 1429, x = 47.5, y = 45 },
			{ t = "accept", quest = 96784, title = "Master of Disguise", object = 656157, map = 1429, x = 47.5, y = 45 },
		} },
		{ title = "Shards of Myzrael", goals = {
			{ t = "turnin", quest = 635, title = "Crystal in the Mountains", object = 138492, map = 1429, x = 47.5, y = 45, optional = true },
			{ t = "accept", quest = 642, title = "The Princess Trapped", object = 138492, map = 1429, x = 47.5, y = 45 },
		} },
		{ title = "Back to Krusk", goals = { { t = "turnin", quest = 533, title = "Infiltration", npc = 2229, map = 1429, x = 70, y = 70 } } },
	},
})
"#;
	let out = run_guide(
		guide,
		"test/here",
		r#"
at(47.5, 45)
emit(cands())
w.accept(533, { 1 }); w.accept(96783, {}); flush()
emit(cands())
w.turnIn(533); w.turnIn(96783); flush()
emit(cands())
"#,
	);
	assert_eq!(out, vec![json!("2:1:take:0 5:2:take:0"), json!("3:1:take:0 4:1:turnin:0 5:2:take:0"), json!("4:2:take:0 5:2:take:0"),]);
}

// No zone stops While you're here (Fitz, 0.3.6): a guide whose live step is in Elwynn shows a pick-up of its
// Westfall section 21 steps on, standing at its giver in Westfall ("later in this guide"), and one whose giver stands
// just over the border on Westfall's map while the player is on Elwynn's, measured in world yards as the arrow does.
const ZONES: &str = r#"
local steps = { { title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } } }
for i = 1, 20 do steps[#steps + 1] = { title = "Walk " .. i, goals = { { t = "goto", map = 1436, x = 20 + i, y = 70 } } } end
steps[#steps + 1] = { title = "Saldean", goals = { { t = "accept", quest = 9, title = "The Killing Fields", npc = 233, npcName = "Farmer Saldean", map = 1436, x = 50, y = 50 } } }
steps[#steps + 1] = { title = "Border", goals = { { t = "accept", quest = 12, title = "The People's Militia", npc = 234, npcName = "Gryan Stoutmantle", map = 1436, x = 0.2, y = 0.5 } } }
Polestar.RegisterGuide({ id = "test/zones", pack = "test", title = "Zones", minLevel = 1, maxLevel = 10, steps = steps })
"#;

#[test]
fn a_pick_up_in_another_zone_of_the_guide_and_one_over_the_border_show() {
	let out = run_guide_with(
		ZONES,
		"test/zones",
		"",
		r#"
		w.moveTo(1436, 50.3, 50.0); w.setZone("Westfall"); stub.advance(0.6); stub.advance(0.6)
		local westfall = {}
		for _, v in ipairs(E.GetWhileHereList()) do westfall[#westfall + 1] = v.step .. ":" .. v.index .. " " .. v.hereText .. (v.later and " [later]" or "") end
		w.moveTo(1429, 99.8, 99.6); w.setZone("Elwynn Forest"); stub.advance(0.6); stub.advance(0.6)
		local border = {}
		for _, v in ipairs(E.GetWhileHereList()) do border[#border + 1] = v.step .. ":" .. v.index .. " " .. v.hereText end
		emit({ live = E.GetLiveStep(), westfall = westfall, border = border })
	"#,
	);
	assert_eq!(out[0]["live"], 1, "{}", out[0]);
	assert_eq!(out[0]["westfall"], json!(["22:1 Take “The Killing Fields” from Farmer Saldean: saves a trip back [later]"]), "{}", out[0]);
	assert_eq!(out[0]["border"], json!(["23:1 Take “The People's Militia” from Gryan Stoutmantle: saves a trip back"]), "{}", out[0]);
}

// The XP rule: a quest's full reward lasts until the player is 5 levels over it. When the guide's hand-in comes at a
// level past that (a `level 8` goal on the way, the quest level 1, the player 5: 60% then), waiting costs XP, and
// the hand-in may be twice the seconds out of the way: the 21 s detour shows at 20. Quest level 3 keeps its full
// reward at 8: no line.
#[test]
fn a_hand_in_whose_xp_waiting_would_cut_may_be_twice_as_far_out_of_the_way() {
	let level8 = r#"{ title = "Level 8", goals = { { t = "level", level = 8 } } }"#;
	let script = r#"at(40.0, 35.1); emit(here())"#;
	let cut = run_turnins(&turnins(20.0, &[ELSEWHERE, level8], ", qlvl = 1"), script);
	let full = run_turnins(&turnins(20.0, &[ELSEWHERE, level8], ", qlvl = 3"), script);
	let none = run_turnins(&turnins(20.0, &[ELSEWHERE, ELSEWHERE], ", qlvl = 1"), script);
	assert_eq!(cut, vec![json!("4:1 Hand in “A Fishy Peril” to Marshal Dughan 60")]);
	assert_eq!(full, vec![json!("none")]);
	assert_eq!(none, vec![json!("none")]);
}

// #1408 (Emil): a hand-in the panel shows is handed in at its NPC's window as the live step's are, by the same rules:
// behavior.autoTurnin, the only reward taken, several rewards left to the player. One the panel does not show (too far
// out of the way) is the player's, as is everything with the setting off.
#[test]
fn a_shown_hand_in_is_handed_in_at_its_npc_as_the_guide_steps_are() {
	let calls = r#"
		function calls()
			local c = {}
			for i, x in ipairs(w.calls) do c[i] = table.concat({ tostring(x[1]), tostring(x[2]), tostring(x[3]) }, " ") end
			return table.concat(c, ", ")
		end
	"#;
	// The progress window; Polestar's CompleteQuest opens the reward window (the stub's), where it takes the reward.
	let talk = r#"w.calls = {}; w.questProgress(240, 40); flush()"#;
	let shown = run(&format!("{calls}at(42.0, 36.1); emit(here()); {talk}; emit({{ calls(), w.log[40] == nil }})"));
	assert_eq!(shown, vec![json!("8:1 Hand in “A Fishy Peril” to Marshal Dughan 20"), json!(["CompleteQuest 40 nil, GetQuestReward 40 0", true])]);
	let choose = run(&format!("{calls}w.choices[40] = 3; at(42.0, 36.1); {talk}; emit({{ calls(), w.log[40] ~= nil }})"));
	assert_eq!(choose, vec![json!(["CompleteQuest 40 nil", true])], "several rewards: the player chooses");
	let one = run(&format!("{calls}w.choices[40] = 1; at(42.0, 36.1); {talk}; emit(calls())"));
	assert_eq!(one, vec![json!("CompleteQuest 40 nil, GetQuestReward 40 1")], "the only reward is taken");
	let off = run(&format!(r#"{calls}Polestar.Set("behavior.autoTurnin", false); at(42.0, 36.1); {talk}; emit(calls())"#));
	assert_eq!(off, vec![json!("")], "auto turn-in off: the player hands it in");
	// Far enough out of the way that #1393's detour rule leaves it out (the start, ~200 yd south-east).
	let away = run(&format!("{calls}at(47.6, 45.1); emit(here()); {talk}; emit(calls())"));
	assert_eq!(away, vec![json!("none"), json!("")], "not shown: the player's");
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
		-- Dead or a ghost (Fitz, 0.3.7.1: hand-ins at the Crossroads offered to a ghost by its graveyard): nothing,
		-- and the line is back on being revived.
		function UnitIsDeadOrGhost(unit) return unit == "player" end
		stub.advance(0.6); emit(here())
		UnitIsDeadOrGhost = nil
		stub.advance(0.6); emit(here())
	"#);
	let v = "2:1 Kill Kobold Vermin, 2 more 50";
	assert_eq!(out, vec![json!(v), json!("none"), json!(v), json!("none"), json!("none"), json!("none"), json!(v), json!("none"), json!(v)]);
	// The live step escorts someone: nothing for the whole step.
	let escort = run_edit(r#"at(47.6, 37.6); emit(here())"#, "ESCORT", ", escort = true");
	assert_eq!(escort, vec![json!("none")]);
	// Barrens, Ignition then The Escape (Fitz, 0.3.7.1): the live step's escort is only taken at its end, after
	// other work; until it is taken, lines show as usual (the Nugget Slugs' tool buckets beside Lugwizzle).
	let not_taken =
		run_edit(r#"at(47.6, 37.6); emit(here())"#, "ESCORT", r#" }, { t = "accept", quest = 99, title = "The Escape", npc = 5, npcName = "Shredder", map = 1429, x = 60, y = 60, escort = true"#);
	assert_eq!(not_taken, vec![json!(v)]);
}

// T1327: Forever's client may have no GetQuestTimers, only the quest log's time allowed. A quest of the log with a
// running timer (Compat.QuestTimerRunning) offers no detour to another quest's work; one whose time ran out
// (failed), or none timed, changes nothing.
#[test]
fn a_timer_the_quest_log_reports_without_the_old_timer_list_offers_no_detour_either() {
	let out = run(r#"
		GetQuestTimers = nil
		at(47.6, 37.6); emit(here())
		C_QuestLog.GetTimeAllowed = function(q) if q == 33 then return 900, 600 end return 0 end
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.6); emit(here())
		C_QuestLog.IsFailed = function(q) return q == 33 end -- only the timed quest's time ran out
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.6); emit(here())
		C_QuestLog.IsFailed = nil
		C_QuestLog.GetTimeAllowed = function() return 0 end
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.6); emit(here())
	"#);
	let v = "2:1 Kill Kobold Vermin, 2 more 50";
	assert_eq!(out, vec![json!(v), json!("none"), json!(v), json!(v)]);
}

// 0.3.7 (timed quests first in While-here): a timed quest's clock holds the other quests' lines, parked as they were,
// but not its own, which come (first: Own.hereBefore) while it runs; once the clock stops the parked lines show again
// in their places by distance, up to three with the timed one. The old timer list names its quest through
// GetQuestIndexForTimer.
#[test]
fn a_running_timer_keeps_its_own_quests_lines_and_parks_the_rest_until_it_stops() {
	let script = r#"
		GetQuestTimers = nil
		at(47.6, 37.6); emit(lines())                   -- rows 10, 20, 30 yd; row 5 (quest 305) at 50 waits
		TIMER
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.6); emit(lines())                -- 305's clock: its line alone
		GetQuestTimers, GetQuestIndexForTimer = nil, nil
		C_QuestLog.GetTimeAllowed = function() return 0 end
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.6); emit(lines())
	"#;
	let log = r#"C_QuestLog.GetTimeAllowed = function(q) if q == 305 then return 600, 10 end return 0 end"#;
	let old = r#"
		local at305
		for i = 1, C_QuestLog.GetNumQuestLogEntries() do if C_QuestLog.GetInfo(i).questID == 305 then at305 = i end end
		function GetQuestTimers() return 590 end
		function GetQuestIndexForTimer(i) return i == 1 and at305 or nil end"#;
	for timer in [log, old] {
		let out = run_guide(ROW, "test/row", &script.replace("TIMER", timer));
		assert_eq!(out, vec![json!("2:1:10 3:1:20 4:1:30"), json!("6:1:50"), json!("2:1:10 3:1:20 6:1:50")], "{timer}");
	}
}

#[test]
fn the_options_turn_it_off_and_set_how_close() {
	let out = run(r#"
		Polestar.Set("behavior.whileHere", false); flush()
		at(47.6, 37.6); emit({ cands(), here() })
		Polestar.Set("behavior.whileHere", true); Polestar.Set("behavior.whileHereRadius", 40); flush()
		at(47.6, 37.6); emit(here())    -- 50 yd: past 40
		at(47.6, 37.0); emit(here())    -- 38 yd
		E.DismissWhileHere()
		Polestar.Set("behavior.whileHereRadius", 120); flush()
		at(47.6, 40.1); emit(here())    -- 100 yd, within 120 (the vermin stay quiet: the candles are 150 yd off)
	"#);
	assert_eq!(out, vec![json!(["", "none"]), json!("none"), json!("2:1 Kill Kobold Vermin, 2 more 40"), json!("none")]);
	let wide = run(r#"Polestar.Set("behavior.whileHereRadius", 120); flush(); at(47.6, 40.1); emit(here())"#);
	assert_eq!(wide, vec![json!("2:1 Kill Kobold Vermin, 2 more 100")]);
}

// Fitz, in game: "we can almost 2-3x the distance", then settled on 180 yd by default; the line holds to 100/60 of
// the radius (300 at 180), but never past 600 yd (at 400 that would be 667).
#[test]
fn by_default_the_line_shows_within_180_yards_and_never_holds_past_600() {
	let out = run_guide_with(
		GUIDE.replace("ESCORT", "").as_str(),
		"test/here",
		"",
		r#"
		emit({ Polestar.Get("behavior.whileHere"), Polestar.Get("behavior.whileHereRadius"), Polestar.Get("behavior.whileHereTurnins") })
		at(47.6, 70.0); at(47.6, 44.6); emit(here())    -- from 700 yd off to 190
		at(47.6, 44.1); emit(here())    -- 180 yd
		at(47.6, 49.6); emit(here())    -- 290 yd: it holds
		at(47.6, 50.6); emit(here())    -- 310 yd: gone
		Polestar.Set("behavior.whileHereRadius", 400); flush()
		at(47.6, 55.1); emit(here())    -- 400 yd
		at(47.6, 64.6); emit(here())    -- 590 yd: it holds
		at(47.6, 65.6); emit(here())    -- 610 yd: gone, though 100/60 of 400 is 667
	"#,
	);
	assert_eq!(
		out,
		vec![
			json!([true, 180, true]),
			json!("none"),
			json!("2:1 Kill Kobold Vermin, 2 more 180"),
			json!("2:1 Kill Kobold Vermin, 2 more 290"),
			json!("none"),
			json!("2:1 Kill Kobold Vermin, 2 more 400"),
			json!("2:1 Kill Kobold Vermin, 2 more 590"),
			json!("none")
		]
	);
}

// At 400 yd, with twelve candidates, eleven of them in reach, the poll still measures the nearest ten (picked again
// every 25 yd moved), shows three, and leaves nothing for the collector.
#[test]
fn at_400_yards_many_candidates_in_reach_cost_nothing_per_poll() {
	let out = run_guide_with(
		MANY,
		"test/many",
		r#"Polestar.Set("behavior.whileHereRadius", 400); stub.advance(0.6)"#,
		r#"
		at(22.0, 80.0)
		local n, all = 0, E.GetWhileHereCandidates()
		for _, c in ipairs(all) do if c.measured then n = n + 1 end end
		local c, px, py = Polestar.Compat.GetPlayerWorldPosition()
		for i = 1, 20 do E.WhileHereTick(c, px + (i % 2) * 40, py) end
		collectgarbage("collect"); collectgarbage("collect")
		collectgarbage("stop")
		local base = collectgarbage("count")
		for i = 1, 2000 do E.WhileHereTick(c, px + (i % 2) * 40, py) end
		local kib = collectgarbage("count") - base
		collectgarbage("restart")
		emit({ all = #all, measured = n, shown = #E.GetWhileHereList(), kib = kib })
	"#,
	);
	assert_eq!(out[0]["all"], 12);
	assert_eq!(out[0]["measured"], 10);
	assert_eq!(out[0]["shown"], 3);
	let kib = out[0]["kib"].as_f64().unwrap();
	assert!(kib < 0.5, "2000 polls at 400 yd allocated {kib:.2} KiB");
}

// A mob of a later step seen around the player (a nameplate, the target) makes its objective a candidate at 30 yd,
// whatever the spawn data says: the spiders' only spawn place is far off. The plate gone, the line goes with it.
#[test]
fn a_mob_in_sight_counts_whatever_the_spawn_data_says() {
	let out = run(r#"
		at(30.0, 60.0); emit(here())                                 -- 300 yd from the spiders' place (20,60)
		w.units.nameplate3 = "Creature-0-1-0-1-42-0000AAAA"
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate3"); stub.advance(0.6)
		emit(here())
		w.units.nameplate3 = nil; stub.fire("NAME_PLATE_UNIT_REMOVED", "nameplate3"); stub.advance(0.6)
		emit(here())
		w.units.target = "Creature-0-1-0-1-42-0000BBBB"
		stub.fire("PLAYER_TARGET_CHANGED"); stub.advance(0.6)
		emit(here())
	"#);
	assert_eq!(out, vec![json!("none"), json!("10:1 Kill Spider, 1 more 30"), json!("none"), json!("10:1 Kill Spider, 1 more 30")]);
}

// Several lines at once, at most three (HERE_SHOW), in rank order (all here spawn in one place: the nearest first).
// Dismissing one keeps the others; the next in reach takes the free place at the next poll.
const ROW: &str = r#"
local steps = { { title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } } }
for i = 1, 5 do
	local q = 300 + i
	stub.world.onQuest(q, { 1 }, "Row " .. i)
	steps[#steps + 1] = { title = "Row " .. i, goals = { { t = "kill", target = "Row " .. i, npc = 600 + i, count = 1, quest = q, oi = 1, map = 1429,
		x = 47.6, y = 37.6 - i * 0.5 } } }
end
Polestar.RegisterGuide({ id = "test/row", pack = "test", title = "Row", minLevel = 1, maxLevel = 10, steps = steps })
"#;

#[test]
fn up_to_three_lines_show_at_once_and_dismissing_one_keeps_the_others() {
	let out = run_guide(
		ROW,
		"test/row",
		r#"
		at(47.6, 37.6); emit({ lines(), here() })        -- rows 10, 20, 30 yd; 40 and 50 wait
		emit(E.DismissWhileHere(1)); emit(lines())
		stub.advance(0.6); emit(lines())                 -- the fourth takes the free place
		emit(E.DismissWhileHere(2)); stub.advance(0.6); emit(lines())
		emit(E.AimWhileHere(2)); flush(); emit(wp())
	"#,
	);
	assert_eq!(
		out,
		vec![
			json!(["2:1:10 3:1:20 4:1:30", "2:1 Kill Row 1, 1 more 10"]),
			json!(true),
			json!("3:1:20 4:1:30"),
			json!("3:1:20 4:1:30 5:1:40"),
			json!(true),
			json!("3:1:20 5:1:40 6:1:50"),
			json!(true),
			json!("5:1")
		]
	);
}

// Fitz went AFK among the Zhevra Runners, one in sight, and the line went. In reach (a mob in sight counts) it never
// expires; walked away past its clear distance it goes, and back among them it comes again. Only the × keeps it
// away for the zone.
#[test]
fn afk_among_its_mobs_the_line_stays_walked_away_it_goes_and_comes_back() {
	let out = run(r#"
		local function plate(n) w.units["nameplate" .. n] = "Creature-0-1-0-1-42-0000" .. n; stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate" .. n); stub.advance(0.6) end
		local function gone(n) w.units["nameplate" .. n] = nil; stub.fire("NAME_PLATE_UNIT_REMOVED", "nameplate" .. n); stub.advance(0.6) end
		at(30.0, 60.0); plate(3); emit(here())
		stub.advance(300); emit(here())                 -- five minutes AFK, the spider in sight
		gone(3); at(30.0, 80.0); emit(here())           -- 400 yd off, none in sight: gone
		at(30.0, 60.0); plate(3); emit(here())          -- back among them
		E.DismissWhileHere(); stub.advance(0.6)
		plate(5); stub.advance(61); emit(here())        -- dismissed: quiet for the zone
	"#);
	let v = "10:1 Kill Spider, 1 more 30";
	assert_eq!(out, vec![json!(v), json!(v), json!("none"), json!(v), json!("none")]);
}

// Out of reach yet inside its clear distance (90 yd at 60) for three minutes, a line goes; back in reach it comes
// again, a minute on at the earliest.
#[test]
fn out_of_reach_for_three_minutes_a_line_expires_and_comes_again_in_reach() {
	let out = run(r#"
		at(47.6, 37.6); emit(here())
		at(47.6, 39.6); stub.advance(120); emit(here())   -- 90 yd, two minutes: it holds
		stub.advance(61); emit(here())                     -- three: gone
		at(47.6, 37.6); emit(here())                       -- back in reach at once: not yet
		stub.advance(61); emit(here())                     -- a minute on: back
	"#);
	assert_eq!(out, vec![json!("2:1 Kill Kobold Vermin, 2 more 50"), json!("2:1 Kill Kobold Vermin, 2 more 90"), json!("none"), json!("none"), json!("2:1 Kill Kobold Vermin, 2 more 50"),]);
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
	assert_eq!(out["cands"], "2:1:work:2 3:1:work:2 8:1:turnin:0 10:1:work:1");
	let (shown, idle) = (out["shown"].as_f64().unwrap(), out["idle"].as_f64().unwrap());
	assert!(shown < 0.5, "2000 polls with the line shown allocated {shown:.2} KiB");
	assert!(idle < 0.5, "2000 polls measuring every candidate allocated {idle:.2} KiB");
}

// #1316, end to end: the whole addon (QoL with the real Engine). The step key targets the live step's wolves; once
// the vermin's line shows it targets them after the wolves; with the option off only the wolves again. The option
// is on by default.
#[test]
fn the_step_key_targets_a_line_s_mobs_after_the_live_step_s_own_1316() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/here" }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			&GUIDE.replace("ESCORT", ""),
			HELPERS,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			r#"Polestar.Set("behavior.whileHereRadius", 60); stub.advance(0.6)"#,
			r#"
			local function key() return PolestarStepButton:GetAttribute("macrotext") or "nil" end
			emit({ Polestar.GetDefault("behavior.whileHereStepKey"), lines(), key() })
			at(47.6, 37.6); flush()
			emit({ lines(), key() })
			Polestar.Set("behavior.whileHereStepKey", false); flush()
			emit(key())
			"#,
		]
		.join("\n"),
		..Default::default()
	});
	let wolves = "/cleartarget [nocombat]\n/targetexact Young Wolf\n/cleartarget [dead]";
	assert_eq!(out[0], json!([true, "", wolves]));
	assert_eq!(out[1], json!(["2:1:50", format!("{wolves}\n/targetexact [noexists] Kobold Vermin\n/cleartarget [dead]")]));
	assert_eq!(out[2], wolves);
}

// One objective on several steps (Fitz, 0.3.6, the Barrens: "Collect Intact Raptor Horn 0/5" three times, from steps
// 21, 34 and 45, one per raptor camp visit). 1 (live) the wolves far off · 2, 4, 6 the same candles for 60 (1 of 3),
// at 20,80 (far), 47.6,34.1 and 47.6,39.1 · 3 and 5 quest 61's two objectives: spiders at 47.0,36.1 and eggs at
// 48.4,36.1 · 7 and 8 hand in 40 (ready) to Dughan, far off.
const DUPES: &str = r#"
stub.world.onQuest(61, { { required = 4, fulfilled = 0 }, { text = "Spider Egg: 0/3", type = "item", required = 3, fulfilled = 0 } }, "Spiders and Eggs")
local function candles(title, x, y)
	return { title = title, goals = { { t = "collect", item = 772, itemName = "Large Candle", count = 3, quest = 60, oi = 1, npc = 476, map = 1429, x = x, y = y } } }
end
local dughan = { t = "turnin", quest = 40, title = "A Fishy Peril", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 20.0, y = 20.0 }
Polestar.RegisterGuide({
	id = "test/dupes", pack = "test", title = "Dupes", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } },
		candles("Candles west", 20.0, 80.0),
		{ title = "Spiders", goals = { { t = "kill", target = "Forest Spider", npc = 43, count = 4, quest = 61, oi = 1, map = 1429, x = 47.0, y = 36.1 } } },
		candles("Candles north", 47.6, 34.1),
		{ title = "Eggs", goals = { { t = "collect", item = 773, itemName = "Spider Egg", count = 3, quest = 61, oi = 2, map = 1429, x = 48.4, y = 36.1 } } },
		candles("Candles south", 47.6, 39.1),
		{ title = "Dughan", goals = { dughan } },
		{ title = "Dughan again", goals = { dughan } },
	},
})
function dupes()
	local out = {}
	for _, c in ipairs(E.GetWhileHereCandidates()) do out[#out + 1] = c.step .. ":" .. c.index .. ":" .. c.kind .. ":" .. c.left .. ":" .. (c.first or "-") end
	return table.concat(out, " ")
end
-- Every line shown: "step:named step:yards ...".
function named()
	local out = {}
	for _, v in ipairs(E.GetWhileHereList()) do out[#out + 1] = v.step .. ":" .. v.firstStep .. ":" .. (v.yards or "-") end
	return table.concat(out, " ")
end
"#;

// The candles are one line, naming step 2 (the earliest, the one the route reaches first) and measured to the copy
// nearest the player: step 4's camp, then step 6's once the player walks there (the same line: no new chime). The
// two objectives of quest 61 are two lines. The hand-in is one candidate, step 7's.
#[test]
fn an_objective_several_steps_hold_is_one_line_naming_the_earliest_step_two_objectives_of_a_quest_are_two() {
	let out = run_guide(
		DUPES,
		"test/dupes",
		r#"
		emit(dupes())
		at(47.6, 35.6); emit(named())
		local before = E.GetWhileHereList()[3].appeared
		at(47.6, 38.1); emit(named())
		emit(E.GetWhileHereList()[3].appeared == before)
	"#,
	);
	assert_eq!(out, vec![json!("2:1:work:2:2 3:1:work:4:- 4:1:work:2:2 5:1:work:3:- 6:1:work:2:2 7:1:turnin:0:-"), json!("3:3:20 5:5:25 4:2:30"), json!("3:3:45 5:5:45 6:2:20"), json!(true)]);
}

// Dismissing the line dismisses the objective: step 6's copy, 10 yd off, stays away as step 4's does.
#[test]
fn dismissing_an_objective_several_steps_hold_hides_every_copy() {
	let out = run_guide(
		DUPES,
		"test/dupes",
		r#"
		at(47.6, 35.6); emit(named())
		emit(E.DismissWhileHere(3)); emit(named())
		at(47.6, 38.6); emit(named())
		stub.advance(300); emit(named())
	"#,
	);
	assert_eq!(out, vec![json!("3:3:20 5:5:25 4:2:30"), json!(true), json!("3:3:20 5:5:25"), json!("3:3:55 5:5:55"), json!("3:3:55 5:5:55")]);
}

// Flight paths you pass (Fitz, 2026-11-10): a friendly flight master within the radius whose flight path the
// character hasn't learned is a line of its own, "Learn the flight path at Goldshire", under it the later step that
// learns it; a click leads the arrow there. Not one of the other faction (Horde Camp), of another class (a Druid
// grove for this Warrior), already known, or out of reach (Neutral Post, 1,200 yd off). Learning it ("New flight path
// discovered") ends the line and ticks the guide's later getfp goal for it while the live step stays; the setting
// turns the lines off. Nav as the addon loads it, its taxi nodes the test's.
const FLY_GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/fly", pack = "test", title = "Fly", minLevel = 1, maxLevel = 10, steps = {
	{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } },
	{ title = "Goldshire flight path", goals = { { t = "getfp", location = "Goldshire", node = 2, npc = 352, npcName = "Dungar Longdrink", map = 1429, x = 50, y = 40 } } },
} })
"#;

const FLY_NODES: &str = r#"
ERR_NEWTAXIPATH = "New flight path discovered!"
Polestar.Nav.RegisterTravelData({ build = "test", taxi = {
	{ 2, 0, -300, 0, 1429, 50, 40, 1, "Goldshire, Elwynn Forest" },
	{ 3, 0, -320, 30, 1429, 49, 41, 2, "Horde Camp, Elwynn Forest" },
	{ 4, 0, -1100, 900, 1429, 20, 80, 3, "Neutral Post, Elwynn Forest" },
	{ 5, 0, -300, 60, 1429, 48, 40, 3, "Grove, Elwynn Forest", "DRUID" },
} }, true)
Polestar.Set("behavior.whileHereRadius", 60)
-- The travel data's points are on the game's frame ("e"): this world's Elwynn is that frame too.
Polestar.MapFrames.era[1429] = { c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
-- The flight path lines shown: { row, step, index, t, text, sub } each, or "none".
function fly()
	local out = {}
	for i, v in ipairs(E.GetWhileHereList()) do
		if v.here == "flight" then out[#out + 1] = { i, v.step, v.index, v.t, v.hereText, v.hereSub } end
	end
	return #out > 0 and out or "none"
end
"#;

fn run_fly(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/fly" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, FLY_GUIDE, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, FLY_NODES, script].join("\n"),
		..Default::default()
	})
}

#[test]
fn a_flight_master_passed_whose_flight_path_is_not_learned_is_a_line_and_learning_it_ticks_the_guides_step() {
	let out = run_fly(
		r#"
		at(49.6, 40.6)                                  -- 17 yd from Goldshire's flight master
		local rows = fly()
		local first = type(rows) == "table" and rows[1] or nil
		emit({ rows = rows, aim = first and E.AimWhileHere(first[1]) or false, wp = wp(), tip = first and E.GetWhileHereList()[first[1]].hereTip or false })
		stub.fire("UI_INFO_MESSAGE", 0, ERR_NEWTAXIPATH); flush(); at(49.6, 40.6)
		emit({ rows = fly(), done = E.GoalDone(2, 1), live = E.GetLiveStep(), wp = wp() })
		at(20.4, 80.4)                                  -- the Neutral Post: no later step learns it
		emit(fly())
		Polestar.Set("behavior.whileHereFlights", false); flush(); at(20.4, 80.6)
		emit(fly())
	"#,
	);
	assert_eq!(
		out[0],
		json!({
			"rows": [[1, -2, 2, "getfp", "Learn the flight path at Goldshire", "Step 2"]],
			"aim": true,
			"wp": "-2:2",
			"tip": "Step 2 learns this flight path later; learned now, that step is done when you get there."
		}),
		"not the Horde Camp's, not the Druids' grove"
	);
	assert_eq!(out[1], json!({ "rows": "none", "done": true, "live": 1, "wp": "1:1" }), "learned: the line goes, step 2 is done, the arrow back on the guide");
	assert_eq!(out[2], json!([[1, -2, 4, "getfp", "Learn the flight path at Neutral Post", "Flight path"]]));
	assert_eq!(out[3], json!("none"), "the setting off");
}

// A flight path already learned (the flight map, or the world map's nodes after a login: Nav's known set) never
// shows; nor in a fight.
#[test]
fn a_known_flight_path_never_shows_nor_one_in_a_fight() {
	let out = run_fly(
		r#"
		stub.inCombat = true; at(49.6, 40.6); emit(fly())
		stub.inCombat = false; at(49.6, 40.6); emit(fly())
		Polestar.CharState().flags.taxi[2] = true
		stub.fire("TAXIMAP_OPENED"); flush(); at(49.6, 40.6)
		emit(fly())
	"#,
	);
	assert_eq!(out, vec![json!("none"), json!([[1, -2, 2, "getfp", "Learn the flight path at Goldshire", "Step 2"]]), json!("none")]);
}

// Fitz-style, on the addon's own travel data (Nav/TravelData.lua): a Dwarf walking through Thelsamar on Loch Modan's
// way in, its flight path not learned, sees "Learn the flight path at Thelsamar", the guide's later getfp step under
// it; a Tauren passing Sun Rock Retreat in Stonetalon sees Sun Rock's; neither sees the other side's. The maps'
// frames are the game's (data/forever/map-frames.json).
fn run_real_fly(race: &str, faction: &str, map: u32, x: f64, y: f64, node: u32, place: &str) -> Vec<Value> {
	let before = format!(
		r#"{WORLD}
w.addMap(1432, {{ name = "Loch Modan", c = 0, left = -1993.75, right = -4752.083, top = -4487.5, bottom = -6327.083 }})
w.addMap(1442, {{ name = "Stonetalon Mountains", c = 1, left = 3245.833, right = -1637.5, top = 2916.667, bottom = -339.583 }})
w.race, w.raceName, w.faction, w.level = "{race}", "{race}", "{faction}", 20
w.moveTo({map}, {x}, {y})
"#
	);
	let guide = format!(
		r#"Polestar.RegisterGuide({{ id = "test/real", pack = "test", title = "Real", minLevel = 1, maxLevel = 60, steps = {{
	{{ title = "Wolves", goals = {{ {{ t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 }} }} }},
	{{ title = "{place}", goals = {{ {{ t = "getfp", location = "{place}", node = {node}, map = {map}, x = {x}, y = {y} }} }} }},
}} }})"#
	);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before,
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/real" }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			&guide,
			HELPERS,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			&format!(
				r#"w.moveTo({map}, {x} + 0.2, {y} + 0.2); stub.advance(0.6); stub.advance(0.6)
local out = {{}}
for _, v in ipairs(E.GetWhileHereList()) do if v.here == "flight" then out[#out + 1] = v.hereText .. " | " .. v.hereSub end end
emit(#out > 0 and out or "none")"#
			),
		]
		.join("\n"),
		..Default::default()
	})
}

#[test]
fn a_dwarf_through_thelsamar_and_a_tauren_past_sun_rock_retreat_are_told_to_learn_the_flight_path() {
	let dwarf = run_real_fly("Dwarf", "Alliance", 1432, 33.94, 50.79, 8, "Thelsamar");
	assert_eq!(dwarf, vec![json!(["Learn the flight path at Thelsamar | Step 2"])]);
	let tauren = run_real_fly("Tauren", "Horde", 1442, 45.16, 59.89, 29, "Sun Rock Retreat");
	assert_eq!(tauren, vec![json!(["Learn the flight path at Sun Rock Retreat | Step 2"])]);
	let dwarf_at_sun_rock = run_real_fly("Dwarf", "Alliance", 1442, 45.16, 59.89, 29, "Sun Rock Retreat");
	assert_eq!(dwarf_at_sun_rock, vec![json!("none")], "the Horde's flight master");
}

// #1540: a click an item must be carried for (Marla's Grave takes Samuel's Remains, from the farm) is no line
// until the bags hold it. The quest database says which items a quest uses without asking for them; 9100 uses item
// 90001, which the farm step collects, at its grave right beside the player; 9101 uses nothing, at its grave beside
// it. Without the database nothing says what a click needs: both graves count, as before. 9102 (Clam Bait's shape:
// the Giant Softshell Clam gives the Soft-shelled Clam a use goal then opens) uses item 90005 too, but a later use
// goal of 9102 names it: the guide brings it, from that very click, so the click is a line without it.
const REMAINS_WORLD: &str = r#"
w.onQuest(9100, { 1 }, "A Last Wish")
w.onQuest(9101, { 1 }, "Another Grave")
w.onQuest(9102, { 1 }, "A Clam")
"#;
const REMAINS: &str = r#"
Polestar.RegisterGuide({
	id = "test/remains", pack = "test", title = "Remains", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } },
		{ title = "The farm", goals = { { t = "collect", item = 90001, itemName = "Remains", map = 1429, x = 70, y = 70 } } },
		{ title = "The grave", goals = { { t = "interact", quest = 9100, title = "A Last Wish", object = 90002, objName = "A Grave", oi = 1, map = 1429, x = 47.6, y = 45.5 } } },
		{ title = "The other grave", goals = { { t = "interact", quest = 9101, title = "Another Grave", object = 90003, objName = "Another Grave", oi = 1, map = 1429, x = 47.7, y = 45.1 } } },
		{ title = "The clam", goals = {
			{ t = "interact", quest = 9102, title = "A Clam", object = 90004, objName = "A Clam Bed", oi = 1, map = 1429, x = 47.5, y = 45.3 },
			{ t = "use", quest = 9102, title = "A Clam", item = 90005, itemName = "A Clam", oi = 1, map = 1429, x = 47.5, y = 45.3 },
		} },
	},
})
"#;
const REMAINS_DB: &str = r#"
Polestar.QuestDB.SetMeta({ schema = 2 })
AddRecords("quests", {
	[9100] = { "A Last Wish", 5, 3, nil, nil, 2, 9200, 9200, nil, nil, nil, { 3, 90002, nil }, 1429, nil, nil, nil, nil, nil, 90001 },
	[9101] = { "Another Grave", 5, 3, nil, nil, 2, 9200, 9200, nil, nil, nil, { 3, 90003, nil }, 1429 },
	[9102] = { "A Clam", 5, 3, nil, nil, 2, 9200, 9200, nil, nil, nil, { 3, 90004, nil }, 1429, nil, nil, nil, nil, nil, 90005 },
})
"#;
const REMAINS_SCRIPT: &str = r#"
emit(cands())
w.addItem(90001, 1); flush()
emit(cands())
w.removeItem(90001); flush()
emit(cands())
"#;

fn run_remains(db: bool) -> Vec<Value> {
	let db = if db { format!("{}{REMAINS_DB}", forge_addontest::questdb::ADD_RECORDS_LUA) } else { String::new() };
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{REMAINS_WORLD}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Quests/QuestDB.lua"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/remains" }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			REMAINS,
			HELPERS,
			&db,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			r#"Polestar.Set("behavior.whileHereRadius", 60); stub.advance(0.6)"#,
			REMAINS_SCRIPT,
		]
		.join("\n"),
		..Default::default()
	})
}

#[test]
fn a_click_that_needs_an_item_the_bags_lack_is_no_line_until_the_item_is_there_1540() {
	let rest = json!("4:1:work:1 5:1:work:1");
	assert_eq!(run_remains(true), vec![rest.clone(), json!("3:1:work:1 4:1:work:1 5:1:work:1"), rest]);
	let all = json!("3:1:work:1 4:1:work:1 5:1:work:1");
	assert_eq!(run_remains(false), vec![all.clone(), all.clone(), all]);
}
