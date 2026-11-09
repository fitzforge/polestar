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
-- At the oasis' north edge both show at once: the spores first (found in fewer places), then the hooves.
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
	assert!(both.starts_with("39:3:") && both.split(' ').nth(1).is_some_and(|z| z.starts_with("18:1:")), "spores then hooves at the oasis edge: {both}");
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
const AT_DUGHAN: &str = r#"{ title = "Errand", goals = { { t = "accept", quest = 106, title = "Young Lovers", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 42.0, y = 35.1 } } }"#;
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

// A hand-in the route reaches anyway in its next two steps, without leading away first, is left to it: the arrow
// leads east to the wolves at 44 (60 yd past Dughan, on the way), and his hand-in is the next step, or the step after
// next is at Dughan (an accept). Standing at him (10 yd, within 0.3.5's 30) it shows all the same. A step that leads
// away first (a walk 900 yd south) or a live step that does (the wolves 660 yd west, Fitz walking past Seer
// Graytongue with Grull 530 yd north) leaves it to the detour rule; a step at him three steps on does not count.
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
	assert_eq!(later[0], json!(["5:1:turnin:0", "5:1 Hand in “A Fishy Peril” to Marshal Dughan 60"]), "three steps on");
	// A quest named after its NPC: the plain line does not name him twice.
	let namesake = run_turnins(&turnins(44.0, &[], r#", title = "Marshal Dughan""#), script);
	assert_eq!(namesake[1], json!("2:1 Hand in “Marshal Dughan” to them 10"), "{namesake:?}");
}

// Fitz on 0.3.6 (build f5fbd242a), his /polestar report: a level 3 Tauren Warrior on Mulgore's step 6 of 51 (Grull
// Hawkwind: hand in The Hunt Continues, 750; the arrow 411 yd north at 44.47,77.50), standing at 42.79,87.19 on Red
// Cloud Mesa, 121 yd from Seer Graytongue (2982, 42.54,90.13), with Rites of the Earthmother (755), 750 and 1656 ready:
// "While here: none · 1 candidates · nearest quest 1656". 755's hand-in is the very next step (7), and #1393's
// next-two-steps rule left it to the route, which goes to Grull first and comes back south ("I'm here and you'd
// expect it to send me backwards to grab the dynamic quest behind"). Now the route leading away first makes it no
// "soon" hand-in, and step 7 is the whole Seer visit (755 in, Grace of An'she and Mu'sha and Rite of Strength out):
// doing it now saves the trip back from Grull (93 s against a 43 s detour), so it shows at the shipped 20 s. At the
// Seer, auto turn-in hands 755 in and auto-accept takes both quests of step 7; the live step stays 6, the arrow on
// it, step 7 done. Grace is timed (ten minutes, its `limit`): the walk Seer, Grull, Ritual Fire fits; with a
// two-minute limit it would not, so no visit (no credit: the 43 s detour is too far) and no early accept. On the
// cougar step (5) around the Seer the line shows too; at Grull's tent nothing. The guide as shipped
// (guides/forever/horde/tauren/01-mulgore.guide, compiled with data/forever; skipped with a note without it).
#[test]
fn mulgore_fitz_walking_past_seer_graytongue_with_rites_of_the_earthmother_ready_is_offered_the_whole_visit() {
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
	// pelts: 750's count (10: ready, step 6 live); limit: Grace's seconds (the data's 600 once rebuilt with its
	// correction; set here so the test does not wait for the data build).
	let run = |pelts: u32, limit: u32| {
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
for _, g in ipairs(E.GetGuide().steps[7].goals) do if g.quest == 95805 then g.limit = {limit} end end
stub.fire("QUEST_LOG_UPDATE"); flush()
local function mg(x, y) w.moveTo(1412, x, y); stub.advance(0.6); stub.advance(0.6) end
local function state()
	local st = E.WhileHereState()
	local v = E.GetWhileHere()
	local credit = false
	for _, c in ipairs(E.GetWhileHereCandidates()) do if c.step == 7 and c.credit then credit = math.floor(c.credit + 0.5) end end
	return {{ live = E.GetLiveStep(), arrow = wp(), here = v and (v.step .. ":" .. v.index .. " " .. v.hereText) or "none", why = st.why or false, credit = credit }}
end
mg(44.47, 79.0); local camp = state()
mg(42.79, 87.19); local report = state()
-- At the Seer: his windows, as the game opens them after each hand-in and accept.
mg(42.54, 89.95)
w.calls = {{}}
w.questProgress(2982, 755); flush()
w.questDetail(2982, 95805); flush()
w.questDetail(2982, 757); flush()
local calls = {{}}
for i, x in ipairs(w.calls) do calls[i] = tostring(x[1]) .. " " .. tostring(x[2]) end
local done = {{}}
for g = 1, #E.GetGuide().steps[7].goals do done[g] = E.GoalDone(7, g) end
emit({{ camp = camp, report = report, calls = table.concat(calls, ", "), live = E.GetLiveStep(), arrow = wp(), done = done }})
"#,
			loads.join("\n")
		);
		emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() }).remove(0)
	};
	let visit = "7:1 Hand in “Rites of the Earthmother” to Seer Graytongue, then take “Grace of An'she and Mu'sha”, “Rite of Strength”: saves a trip back";
	let fitz = run(10, 600);
	assert_eq!(fitz["report"]["live"], 6, "Grull Hawkwind's step is live: {fitz}");
	assert_eq!(fitz["report"]["here"], visit, "121 yd from the Seer, the whole visit shows at the shipped settings: {fitz}");
	assert!(fitz["report"]["credit"].as_f64().is_some_and(|c| c > 43.0), "its credit outweighs the 43 s detour: {fitz}");
	assert_eq!(fitz["camp"]["here"], "none", "at Grull's tent, 530 yd off, nothing: {fitz}");
	let calls = fitz["calls"].as_str().unwrap();
	assert!(calls.contains("GetQuestReward 755") && calls.contains("AcceptQuest 95805") && calls.contains("AcceptQuest 757"), "hand-in and both accepts: {calls}");
	assert_eq!(fitz["live"], 6, "the live step stays: {fitz}");
	assert!(fitz["arrow"].as_str().unwrap().starts_with("6:"), "the arrow stays on it: {fitz}");
	assert_eq!(fitz["done"], json!([true, true, true]), "step 7 is done: no trip back: {fitz}");
	let short = run(10, 120);
	assert_eq!(short["report"]["here"], "none", "a two-minute Grace: no visit, the bare hand-in 43 s out of the way: {short}");
	assert_eq!(short["report"]["why"], "out of the way (43 s, over 20 s)", "{short}");
	assert!(!short["calls"].as_str().unwrap().contains("AcceptQuest 95805"), "Grace not taken ahead: {short}");
	let cougars = run(6, 600);
	assert_eq!(cougars["report"]["live"], 5, "the cougar step is live: {cougars}");
	assert_eq!(cougars["report"]["here"], visit, "hunting cougars around the Seer, the visit shows: {cougars}");
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
	"#);
	let v = "2:1 Kill Kobold Vermin, 2 more 50";
	assert_eq!(out, vec![json!(v), json!("none"), json!(v), json!("none"), json!("none"), json!("none"), json!(v)]);
	// The live step escorts someone: nothing for the whole step.
	let escort = run_edit(r#"at(47.6, 37.6); emit(here())"#, "ESCORT", ", escort = true");
	assert_eq!(escort, vec![json!("none")]);
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
		stub.advance(0.6); emit(here())
		C_QuestLog.IsFailed = function() return true end
		stub.advance(0.6); emit(here())
		C_QuestLog.IsFailed = nil
		C_QuestLog.GetTimeAllowed = function() return 0 end
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
		stub.advance(0.6); emit(lines())                -- 305's clock: its line alone
		GetQuestTimers, GetQuestIndexForTimer = nil, nil
		C_QuestLog.GetTimeAllowed = function() return 0 end
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
