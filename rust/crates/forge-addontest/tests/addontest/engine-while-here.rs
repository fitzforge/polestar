//! "While you're here" (addon/Polestar/Core/Engine.lua, Own.hereBuild / Own.hereTick, Engine.GetWhileHere): while
//! the player works the live step, an open objective of any later step of the guide on the player's map whose
//! quest is already in the log, close by, becomes one line under the step, whatever is left (the player is there
//! already); with the option on, so does a quest ready to hand in whose NPC stands right there. Real Core manifest,
//! stub world.
//!
//! Elwynn here is 3000 yd across (30 yd per map percent on x) and 2000 yd high (20 yd per percent on y).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
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
		{ title = "Maybell", goals = { { t = "accept", quest = 106, title = "Young Lovers", npc = 251, npcName = "Maybell Maclure", map = 1429, x = 47.5, y = 35.5 } } },
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
// (the distances below are measured against it; the default is 150).
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
		{ title = "Maybell", goals = { { t = "accept", quest = 106, title = "Young Lovers", npc = 251, npcName = "Maybell Maclure", map = 1429, x = 47.6, y = 36.0 } } },
		{ title = "Bandits", goals = { { t = "kill", target = "Defias Bandit", npc = 116, count = 2, quest = 88, oi = 1, map = 1429, x = 47.6, y = 36.0 } } },
		{ title = "Fishers", goals = { { t = "kill", target = "Murloc Fisher", npc = 43, count = 1, quest = 40, oi = 1, map = 1429, x = 47.6, y = 36.0 } } },
	},
})
"#;

// The later same-map objective comes after the guide went to Westfall and hearthed back: it counts, measured from
// where the player stands while the live step's wolves (and the arrow) are ~580 yd off. The Westfall murloc never
// counts in Elwynn, and does in Westfall. Never the accept, the bandits (not in the log) or the fishers (ready).
#[test]
fn a_later_objective_after_the_guide_leaves_the_zone_and_comes_back_counts_one_on_another_map_does_not() {
	let out = run_guide(
		AWAY,
		"test/away",
		r#"
		emit(cands())
		at(47.6, 37.6); emit({ here(), wp(), (E.StepNumber(6)) })
		w.progress(7, 1, 10); flush()
		emit({ cands(), here() })                    -- ready to hand in: never
		w.addMap(1436, { name = "Westfall", c = 0, left = -1500, right = -4500, top = -1500, bottom = -3500 })
		w.moveTo(1436, 47.6, 37.6); w.setZone("Westfall"); flush()
		emit(cands())
	"#,
	);
	assert_eq!(out, vec![json!("2:1:work:2 6:1:work:2"), json!(["6:1 Kill Kobold Vermin, 2 more 50", "1:1", 4]), json!(["2:1:work:2", "none"]), json!("4:1:work:1")]);
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
	assert_eq!(out, vec![json!("2:1:work:2 6:1:work:2"), json!([3, "6:1:work:2", [2]])]);
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

// Of two objectives in reach, the one whose target spawns in fewer places wins: spiders found in eight camps all over
// the zone (the player stands in one) wait for another camp; the single murloc 30 yd off is the line. Away from the
// murloc, a spider camp in reach shows. Before: the nearest edge, the spiders (0 yd), always.
const SPREAD: &str = r#"
local camps = {}
for _, p in ipairs({ { 47.6, 37.6 }, { 30, 70 }, { 20, 20 }, { 70, 20 }, { 10, 50 }, { 80, 80 }, { 25, 85 }, { 65, 75 } }) do
	camps[#camps + 1] = { x = p[1], y = p[2], r = 20, n = 2 }
end
Polestar.RegisterGuide({
	id = "test/spread", pack = "test", title = "Spread", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } },
		{ title = "Spiders", goals = { { t = "kill", target = "Spider", npc = 42, count = 1, quest = 52, oi = 1, map = 1429, x = 47.6, y = 37.6, spots = camps } } },
		{ title = "Murlocs", goals = { { t = "kill", target = "Murloc", npc = 40, count = 1, quest = 50, oi = 1, map = 1429, x = 47.6, y = 36.1 } } },
	},
})
"#;

#[test]
fn of_two_objectives_in_reach_the_one_found_in_fewer_places_is_the_line() {
	let out = run_guide(
		SPREAD,
		"test/spread",
		r#"
		at(47.6, 37.6); emit(here())
		E.DismissWhileHere()
		at(30.0, 70.0); emit(here())                    -- another spider camp, the murloc far
	"#,
	);
	assert_eq!(out, vec![json!("3:1 Kill Murloc, 1 more 30"), json!("2:1 Kill Spider, 1 more 0")]);
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
-- At the oasis' north edge both show at once: the spores first (found in fewer places), then the hooves.
w.moveTo(1413, 55.0, 40.5); stub.advance(0.6); stub.advance(0.6)
emit(lines())
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
"#,
		loads.join("\n")
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() });
	assert_eq!(out[0]["live"], 15, "the Razormane camp step is live");
	assert_eq!(out[0]["arrow"], 15, "the arrow stays on the live step");
	assert!(out[0]["arrowYards"].as_f64().unwrap() > 500.0, "the camp is far off: {}", out[0]);
	assert_eq!(out[0]["step"], 39, "the spores' step, The Barrens: kill these as you meet them: {}", out[0]);
	assert_eq!(out[0]["text"], "Collect Fungal Spores from Laden Mushroom, 1 more", "{}", out[0]);
	assert_eq!(out[0]["yards"], 0, "inside the mushrooms' spawn area at the oasis: {}", out[0]);
	assert_eq!(out[0]["zhevra"], true, "the zhevra are a candidate too; the spores, found in fewer places, come first: {}", out[0]);
	let shown = out[0]["report"].as_str().unwrap();
	assert!(shown.starts_with("While here: Collect Fungal Spores from Laden Mushroom, 1 more · quest 848 · step ") && shown.contains("(guide 39) · 0 yd"), "{shown}");
	assert!(shown.contains(" · radius 150 yd · "), "{shown}");
	let both = out[1].as_str().unwrap();
	assert!(both.starts_with("39:3:") && both.split(' ').nth(1).is_some_and(|z| z.starts_with("18:1:")), "spores then hooves at the oasis edge: {both}");
	assert_eq!(out[2], json!("18:1 Collect Zhevra Hooves, 4 more 0"), "Fitz among the runners north of the oasis");
	assert_eq!(out[3], json!("18:1 Collect Zhevra Hooves, 4 more 0"), "at a runner camp the zhevra show");
	assert_eq!(out[4][0], json!("none"), "ready to hand in: no line");
	let none = out[4][1].as_str().unwrap();
	assert!(none.starts_with("While here: none · radius 60 yd · ") && none.contains("nearest quest 845, step ") && none.ends_with("out of radius"), "{none}");
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

#[test]
fn a_dismissed_line_stays_quiet_for_the_zone_stay() {
	let out = run(r#"
		at(47.6, 37.6); emit(here())
		emit(E.DismissWhileHere()); emit(here())
		at(47.6, 45.1); at(47.6, 37.6); emit(here())                 -- away and back: still quiet
		w.setZone("Westfall"); flush(); w.setZone("Elwynn Forest"); flush()
		at(47.6, 37.6); emit(here())                                   -- a new zone stay
	"#);
	assert_eq!(out, vec![json!("2:1 Kill Kobold Vermin, 2 more 50"), json!(true), json!("none"), json!("none"), json!("2:1 Kill Kobold Vermin, 2 more 50")]);
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
			json!("2:1:work:2 3:1:work:2 10:1:work:1"),
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
	let escort = run_edit(r#"at(47.6, 37.6); emit(here())"#, "ESCORT", ", escort = true");
	assert_eq!(escort, vec![json!("none")]);
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

// Fitz, in game: "we can almost 2-3x the distance". 150 yd by default; the line holds to 100/60 of the radius, but
// never past 400 yd (at 250 that would be 417).
#[test]
fn by_default_the_line_shows_within_150_yards_and_never_holds_past_400() {
	let out = run_guide_with(
		GUIDE.replace("ESCORT", "").as_str(),
		"test/here",
		"",
		r#"
		emit({ Polestar.Get("behavior.whileHere"), Polestar.Get("behavior.whileHereRadius"), Polestar.Get("behavior.whileHereTurnins") })
		at(47.6, 43.1); emit(here())    -- 160 yd from the vermin
		at(47.6, 42.6); emit(here())    -- 150 yd
		at(47.6, 47.0); emit(here())    -- 238 yd: it holds
		at(47.6, 48.1); emit(here())    -- 260 yd: gone
		Polestar.Set("behavior.whileHereRadius", 250); flush()
		at(47.6, 47.6); emit(here())    -- 250 yd
		at(47.6, 54.6); emit(here())    -- 390 yd: it holds
		at(47.6, 55.6); emit(here())    -- 410 yd: gone, though 100/60 of 250 is 417
	"#,
	);
	assert_eq!(
		out,
		vec![
			json!([true, 150, true]),
			json!("none"),
			json!("2:1 Kill Kobold Vermin, 2 more 150"),
			json!("2:1 Kill Kobold Vermin, 2 more 240"),
			json!("none"),
			json!("2:1 Kill Kobold Vermin, 2 more 250"),
			json!("2:1 Kill Kobold Vermin, 2 more 390"),
			json!("none")
		]
	);
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
