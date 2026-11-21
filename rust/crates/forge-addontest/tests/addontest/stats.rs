//! The Stats section (addon/Polestar_Stats, an addon of its own that Core/StatsPack.lua loads): the per-character totals (what is counted from which events, the
//! sampler, the heat grid, the caps), the off switch, and the hub section's pages, with the one map of every zone
//! (WorldArt.lua) where the client places zones on the world.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const CORE: &[&str] = &["Core/Core.xml", "Theme/Theme.xml"];
const WITH_UI: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

/// Polestar's files, then the Stats addon as the client loads it once asked.
fn addons(files: &[&str]) -> Vec<Addon> {
	vec![Addon::files("Polestar", files), Addon::name("Polestar_Stats")]
}

/// A level 18 Mage in Darkshore with 5 silver, standing at 40, 50 on the zone's map.
const WORLD: &str = r#"
stub.addons[#stub.addons + 1] = { name = "Polestar_Stats", reason = "DEMAND_LOADED" }
local w = stub.world
w.class, w.className, w.race, w.raceName = "MAGE", "Mage", "NightElf", "Night Elf"
w.level, w.xp, w.xpMax = 18, 1000, 4000
w.zone, w.subzone = "Darkshore", ""
w.money = 500
w.addMap(1439, { name = "Darkshore", c = 1, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.moveTo(1439, 40, 50)
local combat, mounted, inside = false, false, false
InCombatLockdown = function() return combat end
IsMounted = function() return mounted end
IsInInstance = function() if inside then return true, "party" end return false end
GetInstanceInfo = function() return "Blackfathom Deeps", "party", 1, "", 5, 0, false, 48 end
function setCombat(v) combat = v; stub.fire(v and "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED") end
function setMounted(v) mounted = v end
function setInside(v) inside = v end
"#;

const PRELUDE: &str = r#"local Stats = Polestar.Stats
local function S() return Stats.Summary() end
"#;

fn run_in(script: &str, files: &[&str], ui: bool) -> Value {
	let mut stubs = vec!["stub_world.lua"];
	if ui {
		stubs.push("stub_ui.lua");
	}
	emitted(&RunAddon { stubs, before: WORLD.into(), addons: addons(files), login: true, script: [PRELUDE, script].concat(), ..Default::default() }).remove(0)
}

fn run(script: &str) -> Value {
	run_in(script, CORE, false)
}

#[test]
fn quests_accepted_turned_in_and_abandoned_with_the_xp_money_and_time_of_a_turn_in() {
	let out = run(r#"
local w = stub.world
w.accept(7, { 10 })
w.accept(8, { 1 })
stub.advance(120)
w.turnIn(7, 450, 250)
w.abandon(8)
local a = S()
local q = a.quests[1]
emit({ counts = { a.accepted, a.turned, a.abandoned }, xp = a.xp.quests, money = a.income.quests,
	quest = { q.q, q.xp, q.m, q.lv }, dur = q.dur, timed = a.timedQuests, open = next(Stats.Store().open) == nil })"#);
	assert_eq!(out["counts"], json!([2, 1, 1]), "a turn-in's QUEST_REMOVED is not an abandon");
	assert_eq!(out["xp"], 450);
	assert_eq!(out["money"], 250);
	assert_eq!(out["quest"], json!([7, 450, 250, 18]));
	assert!((119..=120).contains(&out["dur"].as_i64().unwrap()), "accepted two minutes before: {}", out["dur"]);
	assert_eq!(out["timed"], 1);
	assert_eq!(out["open"], true);
}

#[test]
fn xp_is_split_into_quests_exploring_and_kills_and_a_kill_is_the_clients_xp_line() {
	let out = run(r#"
local w = stub.world
ERR_ZONE_EXPLORED_XP = "Discovered %s: %d experience gained"
w.setXP(1100)                                   -- a kill: the gain, then its line
stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "Moonstalker dies, you gain 100 experience.")
stub.advance(5)
stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "x")       -- a kill: the line, then the gain
w.setXP(1160)
stub.advance(5)
stub.fire("CHAT_MSG_SYSTEM", "Discovered Auberdine: 40 experience gained")
stub.fire("UI_INFO_MESSAGE", 1, "Discovered Auberdine: 40 experience gained")
w.setXP(1200)
stub.advance(5)
w.turnIn(9, 300, 0)
w.setXP(1500)
local a = S()
local h = Stats.Heat(1439)
local cell = Stats.Cell(40, 50)
local _, killXP = Stats.Heat(1439, "x")
local _, questXP = Stats.Heat(1439, "q")
emit({ xp = { a.xp.total, a.xp.quests, a.xp.explore, a.xp.kills }, kills = a.kills,
	heat = { h.k[cell], killXP, questXP }, levels = { h.x[cell] >= 113 and h.x[cell] <= 217, h.q[cell] >= 217 and h.q[cell] <= 417 } })"#);
	assert_eq!(out["xp"], json!([500, 300, 40, 160]), "total, quests, exploring (its line counted once), kills the rest");
	assert_eq!(out["kills"], 2);
	assert_eq!(out["heat"], json!([2, 160, 300]), "kills in the cell the player stands in, and the zone's kill XP and quest XP to the point");
	assert_eq!(out["levels"], json!([true, true]), "the cell holds each as a level: the one under or over the value");
}

#[test]
fn the_sampler_counts_played_combat_and_mounted_time_by_hour_and_into_the_heat_cell() {
	let out = run(r#"
Stats.Tick(2)
setCombat(true)
Stats.Tick(2)
setCombat(false)
setMounted(true)
Stats.Tick(2)
stub.world.onTaxi = true
Stats.Tick(2)
local a = S()
local hours, days = 0, 0
for _, v in pairs(a.hours) do hours = hours + v end
for _, v in pairs(a.weekdays) do days = days + v end
emit({ time = { a.played, a.combat, a.mounted, a.fights }, hours = hours, days = days,
	cell = Stats.Heat(1439).t[Stats.Cell(40, 50)], still = Stats.Heat(1439).s[Stats.Cell(40, 50)], active = Stats.Store().active,
	sessions = a.sessions, zone = Stats.HeatMaps()[1].seconds })"#);
	assert_eq!(out["time"], json!([8, 2, 4, 1]));
	assert_eq!(out["hours"], 8);
	assert_eq!(out["days"], 8);
	assert_eq!(out["cell"], 2, "time spent in a place is time on the move there: the sample that arrived");
	assert_eq!(out["still"], 4, "standing still is kept apart; a flight is played time, not time in a place");
	assert_eq!(out["zone"], 6, "the zones are listed by all the time in them");
	assert_eq!(out["active"], 8);
	assert_eq!(out["sessions"], 1);
}

#[test]
fn gold_looted_a_merchant_visits_net_training_and_the_purse_samples() {
	let out = run(r#"
local w = stub.world
stub.fire("LOOT_OPENED")
w.setMoney(560)                                  -- 60c from a corpse
stub.fire("LOOT_CLOSED")
stub.advance(5)
w.setMoney(600)                                  -- not loot: nothing open
w.merchant(54)
w.setMoney(900)                                  -- sold 3s
w.close()
w.merchant(54)
w.setMoney(700)                                  -- bought 2s
w.close()
w.trainer(911)
w.setMoney(450)
w.close()
local a = S()
emit({ income = { a.income.loot, a.income.vendor }, spent = { a.spent.buy, a.spent.trainer }, first = a.money[1] })"#);
	assert_eq!(out["income"], json!([60, 300]));
	assert_eq!(out["spent"], json!([200, 250]));
	assert_eq!(out["first"][1], 500, "the purse at login is the line's first sample");
}

#[test]
fn level_ups_deaths_and_a_dungeon_run_are_listed() {
	let out = run(r#"
local w = stub.world
Stats.Tick(2)
w.setLevel(19)
stub.fire("PLAYER_DEAD")
stub.fire("PLAYER_DEAD")
setInside(true)
Stats.Tick(2)
stub.advance(600)
Stats.Tick(2)
stub.fire("ENCOUNTER_END", 1, "Boss", 1, 5, 1)
stub.fire("ENCOUNTER_END", 2, "Boss", 1, 5, 0)
setInside(false)
Stats.Tick(2)
local a = S()
local run = a.dungeons[1]
emit({ level = { a.levels[1].l, a.levels[1].p }, deaths = a.deaths, unknown = a.killers[0].n, bosses = a.bosses,
	run = { run.name, run.s >= 600 }, open = Stats.Store().inst == nil, cell = Stats.Heat(1439).d[Stats.Cell(40, 50)] })"#);
	assert_eq!(out["level"], json!([19, 2]), "the level and the time played by then");
	assert_eq!(out["deaths"], 2);
	assert_eq!(out["unknown"], 2, "no foe seen: filed under unknown");
	assert_eq!(out["bosses"], 1, "only a won encounter");
	assert_eq!(out["run"], json!(["Blackfathom Deeps", true]));
	assert_eq!(out["open"], true);
	assert_eq!(out["cell"], 2);
}

#[test]
fn turned_off_nothing_is_counted_and_what_was_saved_stays_reset_forgets_it() {
	let out = run(r#"
local w = stub.world
w.accept(7, { 1 })
Polestar.Set("stats.enabled", false)
w.accept(8, { 1 })
Stats.Tick(2)
local off = { S().accepted, S().played }
Polestar.Set("stats.enabled", true)
w.accept(9, { 1 })
local on = S().accepted
Stats.Reset()
emit({ off = off, on = on, reset = { S().accepted, PolestarStatsCharDB ~= nil } })"#);
	assert_eq!(out["off"], json!([1, 0]));
	assert_eq!(out["on"], 2);
	assert_eq!(out["reset"][0], 0);
}

#[test]
fn days_beyond_the_cap_are_summed_away_and_the_totals_keep_them() {
	let out = run(r#"
local s = Stats.Store()
for i = 1, 400 do s.days[string.format("2020%04d", i)] = { qa = 1 } end
stub.world.accept(7, { 1 })
local n = 0
for _ in pairs(s.days) do n = n + 1 end
emit({ days = n, old = s.old.qa, total = S().accepted })"#);
	assert_eq!(out["days"], 370);
	assert_eq!(out["old"], 31);
	assert_eq!(out["total"], 401);
}

#[test]
fn the_section_draws_each_page_lists_the_zones_played_in_and_a_zones_heat_map() {
	let out = run_in(
		r#"
local w = stub.world
w.accept(7, { 1 })
stub.advance(60)
w.turnIn(7, 450, 250)
Stats.Tick(2)
stub.fire("PLAYER_DEAD")
Polestar.Fire("SHOW_STATS")
local V = Polestar.UI.StatsSection
local pages = {}
for _, key in ipairs({ "activity", "character", "time", "gold", "professions" }) do
	V.OnNav(key)
	local s = V.Shown()
	pages[#pages + 1] = { s.page, s.title, s.fonts > 0 }
end
local nav, active = V.Nav()
local keys = {}
for i, item in ipairs(nav) do keys[i] = item.separator and "-" or item.key end
V.OnNav("character")
local name = { V.Shown().name, UnitName("player") }
V.OnNav("professions")
V.OnNav("map:1439")
local path = { V.Shown().page, V.Shown().cells, V.Shown().total }
V.SetLayer("t")
local m = V.Shown()
local time = { m.page, m.map, m.cells, math.floor(m.total + 0.5) }
local title, subtitle = m.title, m.subtitle
V.SetLayer("d")
local deaths = { V.Shown().cells, V.Shown().total }
Polestar.Set("stats.enabled", false)
V.Render()
emit({ pages = pages, keys = keys, active = active, name = name, path = path, time = time, deaths = deaths, title = title,
	subtitle = subtitle, offSubtitle = V.Shown().subtitle, off = V.Shown().off, section = Polestar.UI.Picker.Section() })"#,
		WITH_UI,
		true,
	);
	assert_eq!(out["section"], "Stats");
	assert_eq!(out["name"][0], out["name"][1], "the Character page's card names the character");
	assert!(text(&out["name"][0]).len() > 1);
	assert_eq!(out["pages"], json!([["activity", "Activity", true], ["character", "Character", true], ["time", "Time", true], ["gold", "Gold", true], ["professions", "Professions", true]]));
	assert_eq!(out["keys"], json!(["activity", "character", "time", "gold", "professions", "completion", "-", "map:1439"]));
	assert_eq!(out["active"], "professions");
	assert_eq!(
		out["time"],
		json!(["map:1439", 1439, 4, 2]),
		"the sample that arrived (the minute standing there is not time on the move): one cell, spread over its neighbours, in blocks of two cells a side"
	);
	assert_eq!(out["deaths"], json!([4, 1]));
	assert_eq!(out["path"], json!(["map:1439", 0, 1]), "the path layer comes first: one point where the player stood, no line yet");
	assert_eq!(out["title"], "Darkshore");
	assert!(is_match(text(&out["subtitle"]), r"^Counting since \S+ \d+  \x{b7}  kept on this computer only$"), "{}", out["subtitle"]);
	assert_eq!(out["off"], true);
	assert_eq!(out["offSubtitle"], "Turned off: showing what was counted");
}

#[test]
fn the_walked_path_is_one_list_for_the_character_broken_at_a_jump_and_capped_the_oldest_going_first() {
	let out = run(r#"
local w = stub.world
w.addMap(1438, { name = "Teldrassil", c = 1, left = 3000, right = 1000, top = 1000, bottom = -1000 })
local function at(x, y, map) w.moveTo(map or 1439, x, y) Stats.Tick(2) end
at(40, 50) at(40.05, 50) at(41, 50) at(42, 51)
at(80, 20) at(81, 20)
local t = Stats.Trail(1439)
local pts = {}
for i, p in ipairs(t) do
	local x, y = Stats.TrailXY(p)
	pts[i] = x and { x, y } or "break"
end
local stored = { unpack(Stats.Store().path) }
for i = 1, 22000 do at(10 + (i % 400) / 5, 10 + (i % 8000) / 100, 1438) end
local path = Stats.Store().path
local last = Stats.Trail(1438)
emit({ pts = pts, stored = stored, kept = { #path >= Stats.MAX_PATH, #path <= Stats.MAX_PATH + 500 }, first = path[1], gone = Stats.Trail(1439) == nil,
	newest = { Stats.TrailXY(last[#last]) } })"#);
	assert_eq!(out["pts"], json!([[40, 50], [41, 50], [42, 51], "break", [80, 20], [81, 20]]), "standing still adds nothing, a jump across the map breaks the line");
	assert_eq!(out["stored"], json!([-1439, 40005001, 41005001, 42005101, -1439, 80002001, 81002001]), "one list: a run starts with its map");
	assert_eq!(out["kept"], json!([true, true]), "no more than the cap, whatever the zones");
	assert_eq!(out["first"], -1438, "what is left starts with its map");
	assert_eq!(out["gone"], true, "the oldest walks went first: Darkshore's");
	assert_eq!(out["newest"], json!([10, 70]));
}

#[test]
fn a_heat_cell_is_a_level_in_its_tiles_string_exact_while_small_and_right_on_average_beyond() {
	let out = run(r#"
local w = stub.world
local seed = 1
Stats.Roll = function() seed = (seed * 16807) % 2147483647 return seed / 2147483647 end
local function kills(x, y, n) w.moveTo(1439, x, y) for _ = 1, n do stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "x") end end
local G = Stats.GRID
local function centre(cx, cy) return (cx + 0.5) / G * 100, (cy + 0.5) / G * 100 end
-- One tile (cells 32..47 each way): its first cell, one past a long gap, its last; and a cell in another tile.
local x, y = centre(32, 32) kills(x, y, 10)
x, y = centre(40, 37) kills(x, y, 3)
x, y = centre(47, 47) kills(x, y, 1)
x, y = centre(100, 200) kills(x, y, 1000)
local layer = Stats.Store().heat[1439].k
local tiles, kinds = 0, {}
for k, v in pairs(layer) do if type(k) == "number" then tiles = tiles + 1 kinds[type(v)] = true end end
local cells, total = Stats.Heat(1439, "k")
local n = 0
for _ in pairs(cells) do n = n + 1 end
local big = cells[200 * G + 100 + 1]
emit({ tiles = tiles, strings = kinds.string == true and next(kinds, "string") == nil, total = total, n = n,
	small = { cells[32 * G + 32 + 1], cells[37 * G + 40 + 1], cells[47 * G + 47 + 1] }, big = big, near = big > 500 and big < 2000,
	levels = { Stats.LEVEL_VALUE[16], Stats.LEVEL_VALUE[17], Stats.LEVEL_VALUE[64] } })"#);
	assert_eq!(out["tiles"], 2, "a tile for each 16 x 16 cells with anything in them");
	assert_eq!(out["strings"], true, "each a string, not a table of cells");
	assert_eq!(out["total"], 1014, "the layer's total is kept to the point");
	assert_eq!(out["n"], 4);
	assert_eq!(out["small"], json!([10, 3, 1]), "up to 16 a cell holds the number itself, wherever it lies in the tile");
	assert_eq!(out["near"], true, "beyond, a level: a thousand kills one at a time land near a thousand ({})", out["big"]);
	assert_eq!(out["levels"], json!([16, 22, 100000000]));
}

#[test]
fn a_tile_walked_all_over_is_no_longer_than_its_cells_and_a_few_digits() {
	let out = run(r#"
local w = stub.world
local G = Stats.GRID
for cy = 16, 31 do
	for cx = 16, 31 do
		w.moveTo(1439, (cx + 0.5) / G * 100, (cy + 0.5) / G * 100)
		stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "x")
	end
end
local layer = Stats.Store().heat[1439].k
local tiles, longest = 0, 0
for k, v in pairs(layer) do if type(k) == "number" then tiles, longest = tiles + 1, math.max(longest, #v) end end
local cells = Stats.Heat(1439, "k")
local n, ones = 0, true
for _, v in pairs(cells) do n = n + 1 if v ~= 1 then ones = false end end
emit({ tiles = tiles, longest = longest, n = n, ones = ones, corners = { cells[16 * G + 16 + 1], cells[31 * G + 31 + 1] } })"#);
	assert_eq!(out["tiles"], 1);
	assert_eq!(out["longest"], 264, "256 cells in four runs of 64: a zone walked all over is 900 such tiles, some 290 KiB a layer, and no more");
	assert_eq!(out["n"], 256);
	assert_eq!(out["ones"], true);
	assert_eq!(out["corners"], json!([1, 1]));
}

#[test]
fn the_map_zooms_in_on_a_point_pans_and_draws_the_path_as_lines() {
	let out = run_in(
		r#"
local w = stub.world
local function at(x, y) w.moveTo(1439, x, y) Stats.Tick(2) end
at(40, 50) at(41, 50) at(42, 51) at(43, 51)
at(90, 90) at(91, 90)
Polestar.Fire("SHOW_STATS")
local V = Polestar.UI.StatsSection
V.OnNav("map:1439")
local s = V.Shown()
local whole = { s.cells, s.total, s.zoom, s.focus[1], s.focus[2] }
for _ = 1, 40 do V.Zoom(1) end
local deep = { V.Shown().zoom, V.Shown().focus[1], V.Shown().focus[2] }
V.ResetView()
V.Zoom(4, 0, 0)
local corner = { V.Shown().zoom > 2.4, V.Shown().focus[1] < 25, V.Shown().focus[2] < 25, V.Shown().cells }
V.Pan(-100000, -100000)
local far = { V.Shown().focus[1] > 75, V.Shown().focus[2] > 75, V.Shown().cells }
V.Zoom(-40)
local out = { V.Shown().zoom, V.Shown().focus[1], V.Shown().focus[2], V.Shown().cells }
V.SetLayer("t")
V.Zoom(3)
local heat = { V.Shown().zoom > 1.9, V.Shown().cells }
emit({ whole = whole, deep = deep, corner = corner, far = far, out = out, heat = heat })"#,
		WITH_UI,
		true,
	);
	assert_eq!(out["whole"], json!([4, 6, 1, 50, 50]), "three segments, a break, one more");
	assert_eq!(out["deep"], json!([12, 50, 50]), "the wheel stops at the deepest zoom");
	assert_eq!(out["corner"], json!([true, true, true, 0]), "zooming on the top left corner leaves the path out of the frame");
	assert_eq!(out["far"], json!([true, true, 1]), "dragged to the bottom right: the last stretch only");
	assert_eq!(out["out"], json!([1, 50, 50, 4]));
	assert_eq!(out["heat"], json!([true, 36]), "the heat cells are culled the same way: four of the six are in the frame, each spread over nine");
}

/// Azeroth (947) with Kalimdor (1414, 20,000 yards a side) on its left half; Darkshore (1439) and Teldrassil (1438) on it, each a
/// twentieth of the world wide, and Darnassus (1457), a city with no overlays, inside Teldrassil. Skyreach (2000)
/// is on no world map. Every map's art is 1002 x 668 in 4 x 3 tiles (file: map * 100 + index); Darkshore has one
/// 300 x 200 overlay (files 501, 502) in its table, Teldrassil one explored by the character (file 601).
const ATLAS: &str = r#"
local w = stub.world
w.addMap(947, { name = "Azeroth", mapType = 1 })
w.addMap(1414, { name = "Kalimdor", mapType = 2, parent = 947, c = 1, left = 10000, right = -10000, top = 10000, bottom = -10000 })
w.addMap(1439, { name = "Darkshore", c = 1, left = 1000, right = -1000, top = 1000, bottom = -1000, parent = 1414 })
w.addMap(1438, { name = "Teldrassil", c = 1, left = 3000, right = 2000, top = 3000, bottom = 2000, parent = 1414 })
w.addMap(1457, { name = "Darnassus", c = 1, left = 2600, right = 2500, top = 2600, bottom = 2500, parent = 1414 })
w.addMap(2000, { name = "Skyreach", c = 5, left = 100, right = -100, top = 100, bottom = -100 })
local RECTS = { [1414] = { 0, 0.5, 0, 1 }, [1439] = { 0.2, 0.25, 0.3, 0.35 }, [1438] = { 0.1, 0.15, 0.2, 0.25 }, [1457] = { 0.12, 0.125, 0.22, 0.225 } }
function C_Map.GetMapRectOnMap(id, top)
	local r = top == 947 and RECTS[id]
	if r then return r[1], r[2], r[3], r[4] end
end
function C_Map.GetMapChildrenInfo(root, kind)
	local out = {}
	for id in pairs(RECTS) do
		if (id == 1414) == (kind == 2) then out[#out + 1] = { mapID = id } end
	end
	return out
end
function C_Map.GetMapArtLayers(id)
	if id == 947 or RECTS[id] or id == 2000 then return { { layerWidth = 1002, layerHeight = 668, tileWidth = 256, tileHeight = 256 } } end
	return {}
end
function C_Map.GetMapArtLayerTextures(id) local t = {}; for i = 1, 12 do t[i] = id * 100 + i end; return t end
function C_Map.GetMapArtID(id) return id + 9000 end
C_MapExplorationInfo = { GetExploredMapTextures = function(id)
	if id == 1438 then return { { textureWidth = 200, textureHeight = 200, offsetX = 400, offsetY = 200, fileDataIDs = { 601 } } } end
	return {}
end }
"#;

const ATLAS_PRELUDE: &str = r#"
Polestar.UI.ZoneArt.RegisterOverlays("test", { [1439 + 9000] = { 256, 256, { 300, 200, 400, 200, 501, 502 } } })
local w = stub.world
local function at(map, x, y) w.moveTo(map, x, y) Stats.Tick(2) end
local V = Polestar.UI.StatsSection
-- The files of the map's textures in sight, as a set; masks: file -> the mask it is drawn through.
local masks = {}
local function files()
	local out = {}
	local art
	for _, f in ipairs(stub.frames or {}) do if f.waPool then art = f end end
	for _, t in ipairs(art and art.waPool or {}) do
		if t:IsShown() then
			local file = tostring(t:GetTexture())
			out[file] = true
			masks[file] = t.waMask and tostring(t.waMask:GetTexture()):match("[%w-]+$") or false
		end
	end
	return setmetatable(out, { __index = function() return false end })
end
"#;

fn run_atlas(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_ui.lua"],
		before: [WORLD, ATLAS].concat(),
		addons: addons(WITH_UI),
		login: true,
		script: [PRELUDE, ATLAS_PRELUDE, script].concat(),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn zones_on_the_world_map_share_one_map_and_picking_one_frames_it_there() {
	let out = run_atlas(
		r#"
at(1439, 40, 50) at(1438, 50, 50) at(2000, 50, 50)
Polestar.Fire("SHOW_STATS")
local nav = V.Nav()
local keys = {}
for i, item in ipairs(nav) do keys[i] = item.separator and "-" or item.key end
V.OnNav("world")
local s = V.Shown()
local opened = { s.page, s.title, s.map == nil, s.zones, s.total, s.zoom, s.focus[1], s.focus[2] }
V.OnNav("map:1439")
s = V.Shown()
local _, active = V.Nav()
local picked = { s.page, active, s.zones, s.zoom, s.focus[1], s.focus[2] }
V.SetLayer("t")
local kept = { V.Shown().zoom, V.Shown().cells }
V.ResetView()
local home = { V.Shown().zoom, V.Shown().zones }
V.OnNav("map:2000")
s = V.Shown()
emit({ keys = keys, opened = opened, picked = picked, kept = kept, home = home, own = { s.page, s.map, s.title, s.zoom } })"#,
	);
	assert_eq!(out["keys"], json!(["activity", "character", "time", "gold", "professions", "completion", "-", "world", "map:2000"]), "the zones on the world map have no entry of their own");
	// Both zones lie in 0.1..0.25 by 0.2..0.35 of the world: nine tenths of the frame, its middle in the middle.
	assert_eq!(out["opened"], json!(["world", "World map", true, 2, 2, 6, 17.5, 27.5]), "the world opens on the zones played in");
	assert_eq!(out["picked"], json!(["world", "world", 1, 18, 22.5, 32.5]), "a zone on the world opens the world's map on it");
	assert_eq!(out["kept"], json!([18, 4]), "another layer keeps the view");
	assert_eq!(out["home"], json!([6, 2]), "a right-click goes back to the zones played in");
	assert_eq!(out["own"], json!(["map:2000", 2000, "Skyreach", 1]), "a zone on no world map keeps its own page");
}

#[test]
fn the_world_art_comes_in_by_zoom_the_world_then_its_continents_then_the_zones_overlays() {
	let out = run_atlas(
		r#"
at(1439, 40, 50) at(1438, 50, 50)
Polestar.Fire("SHOW_STATS")
V.OnNav("world")
V.Zoom(-40)
local a = V.Shown().art
local far = { V.Shown().zoom, a.tiles, a.continents, a.detail, a.zones, V.Shown().painted }
local f = files()
local farFiles = { f["94701"], f["141401"], f["501"] }
V.OnNav("map:1439")
a = V.Shown().art
f = files()
local near = { a.continents, a.detail, a.zones, f["501"], f["502"], f["143901"], f["601"], masks["501"], masks["143901"], false }
for file in pairs(f) do if file:match("^1414") then near[#near] = near[#near] or masks[file] end end
local continent = false
for file in pairs(f) do if file:match("^1414") then continent = true end end
near[#near + 1] = continent
V.OnNav("map:1438")
f = files()
local explored = { V.Shown().art.zones, f["601"], f["501"], f["143801"] }
for _ = 1, 40 do V.Zoom(1) end
local deepest = V.Shown().zoom
emit({ far = far, farFiles = farFiles, near = near, explored = explored, deepest = deepest })"#,
	);
	assert_eq!(out["far"], json!([1, 12, 0, 0, 0, true]), "the whole world: its twelve tiles and nothing over them");
	assert_eq!(out["farFiles"], json!([true, false, false]));
	assert_eq!(
		out["near"],
		json!([1, 1, 1, true, true, true, false, "feather", "feather", false, true]),
		"a zone in close: its base and overlays, faded out at its frame, over the continent's art as it is"
	);
	assert_eq!(out["explored"], json!([1, true, false, true]), "a zone the table has no art for: the overlays the character has explored");
	assert_eq!(out["deepest"], 240, "as far into the narrowest zone played in as a zone's own map goes");
}

#[test]
fn a_city_with_no_overlays_shows_its_own_map_once_it_fills_the_frame() {
	let out = run_atlas(
		r#"
at(1438, 50, 50) at(1457, 50, 50)
Polestar.Fire("SHOW_STATS")
V.OnNav("map:1438")
local f = files()
local zone = { V.Shown().zones, f["601"], f["145701"] }
V.OnNav("map:1457")
f = files()
emit({ zone = zone, city = { V.Shown().zoom, f["145701"], f["145712"], masks["145701"] } })"#,
	);
	assert_eq!(out["zone"], json!([2, true, false]), "from the zone the city is too small for its own map");
	assert_eq!(out["city"], json!([180, true, true, "feather-round"]), "through the rounded mask: its paper border drops away");
}

#[test]
fn far_out_the_heat_is_summed_into_blocks_and_the_path_into_steps_that_show() {
	let out = run_atlas(
		r#"
at(1439, 40, 50) at(1439, 40.5, 50) at(1439, 41, 50) at(1439, 41.5, 50)
at(1438, 50, 50)
Polestar.Fire("SHOW_STATS")
V.OnNav("world")
V.Zoom(-40)
local farPath = V.Shown().cells
V.SetLayer("t")
local farHeat = { V.Shown().cells, V.Shown().zones }
V.OnNav("map:1439")
local nearHeat = V.Shown().cells
V.SetLayer("p")
emit({ farPath = farPath, farHeat = farHeat, nearHeat = nearHeat, nearPath = V.Shown().cells })"#,
	);
	assert_eq!(out["farPath"], 2, "lines a fraction of a pixel long would not show: a dot where each zone's path went");
	assert_eq!(out["farHeat"], json!([3, 2]), "blocks, not cells, which are too small to see apart: Darkshore's four straddle two, Teldrassil's one is one");
	assert_eq!(out["nearHeat"], 12, "in close they come apart");
	assert_eq!(out["nearPath"], 3);
}

/// Two seconds of play at a place: the ticker's own sample, with the clock moving (a ride is told by speed).
const TRAVEL: &str = r#"
local speed = 0
GetUnitSpeed = function() return speed, 7 end
local function step(map, x, y) w.moveTo(map, x, y) stub.advance(2) end
local function points(list)
	local out = {}
	for i, p in ipairs(list or {}) do
		local x, y = Stats.TrailXY(p)
		out[i] = x and { x, y } or "break"
	end
	return out
end
"#;

#[test]
fn a_flight_paths_route_is_kept_on_the_continents_map_and_drawn_on_the_flights_layer() {
	let out = run_atlas(
		&[
			TRAVEL,
			r#"
step(1439, 40, 50)
w.onTaxi = true
step(1439, 50, 50) step(1439, 60, 50) step(1439, 60, 50) step(1439, 70, 50)
w.onTaxi = false
step(1439, 70, 50)
local a = S()
local walked = #Stats.Trail(1439)
Polestar.Fire("SHOW_STATS")
V.OnNav("world")
V.SetLayer("j")
V.Zoom(-40)
local s = V.Shown()
local world = { s.page, s.cells, s.zones, s.total }
V.OnNav("map:2000")
emit({ route = points(Stats.Routes("f")[1414]), counted = { a.flights, a.flightSeconds }, walked = walked, world = world,
	rides = next(Stats.Routes("r")) == nil, jumps = #Stats.Jumps() })"#,
		]
		.concat(),
	);
	// Darkshore is a tenth of Kalimdor across, around its middle: 10% of the zone is 1% of the continent.
	assert_eq!(out["route"], json!([[50, 50], [51, 50], [52, 50]]), "a point where the flight moved, on the continent's map");
	assert_eq!(out["counted"], json!([1, 8]));
	assert_eq!(out["walked"], 3, "the walked path stops for the flight: the take-off, a break, the landing");
	assert_eq!(out["world"], json!(["world", 2, 1, 3]), "two segments on the one continent");
	assert_eq!(out["rides"], true, "a flight is no ride");
	assert_eq!(out["jumps"], 0, "and its landing no jump");
}

#[test]
fn being_carried_faster_than_the_character_moves_is_a_ride_and_a_short_one_is_dropped() {
	let out = run_atlas(
		&[
			TRAVEL,
			r#"
step(1439, 40, 50)
-- Running at 7 yards a second: 14 yards (0.7% of the zone) a sample is the character's own doing.
speed = 7
for i = 1, 5 do step(1439, 40 + i * 0.7, 50) end
local running = { S().rides, next(Stats.Routes("r")) == nil }
-- Standing on a boat that moves 20 yards a sample.
speed = 0
for i = 1, 10 do step(1439, 44 + i, 50) end
for _ = 1, 5 do step(1439, 54, 50) end
local boat = { S().rides, S().rideSeconds > 0, #Stats.Routes("r")[1414] }
local ends = points(Stats.Routes("r")[1414])
-- A lift: carried for three samples, then not.
for i = 1, 3 do step(1439, 54 + i, 50) end
for _ = 1, 5 do step(1439, 57, 50) end
Polestar.Fire("SHOW_STATS")
V.OnNav("world")
V.SetLayer("j")
V.Zoom(-40)
emit({ running = running, boat = boat, first = ends[1], last = ends[#ends], after = { S().rides, #Stats.Routes("r")[1414] },
	drawn = V.Shown().cells > 0, jumps = #Stats.Jumps() })"#,
		]
		.concat(),
	);
	assert_eq!(out["running"], json!([0, true]));
	assert_eq!(out["boat"], json!([1, true, 9]), "the ride begins on its second carried sample");
	assert_eq!(out["first"], json!([49.6, 50]));
	assert_eq!(out["last"], json!([50.4, 50]));
	assert_eq!(out["after"], json!([1, 9]), "too short to be a ride: not counted, not kept");
	assert_eq!(out["drawn"], true);
	assert_eq!(out["jumps"], 0);
}

#[test]
fn arriving_far_from_where_the_character_was_is_a_jump_drawn_as_a_straight_line() {
	let out = run_atlas(
		&[
			TRAVEL,
			r#"
step(1439, 50, 50)
step(1439, 50.5, 50)
step(1438, 50, 50)                      -- a portal: 3,500 yards in one sample
local portal = #Stats.Jumps()
w.inInstance = true                     -- the tram: no position inside, out again somewhere else
for _ = 1, 30 do stub.advance(2) end
w.inInstance = false
step(1439, 20, 20)
local tram = #Stats.Jumps()
w.inInstance = true                     -- a dungeon: out again where the character went in
for _ = 1, 30 do stub.advance(2) end
w.inInstance = false
step(1439, 20.2, 20)
local j = Stats.Jumps()[1]
Polestar.Fire("SHOW_STATS")
V.OnNav("world")
V.SetLayer("j")
V.Zoom(-40)
emit({ portal = portal, tram = tram, dungeon = #Stats.Jumps(), first = { j[1], { Stats.TrailXY(j[2]) }, j[3], { Stats.TrailXY(j[4]) } },
	drawn = V.Shown().jumps, total = V.Shown().total })"#,
		]
		.concat(),
	);
	assert_eq!(out["portal"], 1);
	assert_eq!(out["tram"], 2);
	assert_eq!(out["dungeon"], 2, "back where it went in: no jump");
	assert_eq!(out["first"], json!([1414, [50.05, 50], 1414, [37.5, 37.5]]), "from and to, on the continent's map");
	assert_eq!(out["drawn"], 2);
	assert_eq!(out["total"], 2);
}

#[test]
fn the_map_is_as_tall_as_the_window_has_room_for_and_its_art_fills_the_flatter_frame() {
	let out = run_atlas(
		r#"
at(1439, 40, 50) at(1438, 50, 50)
Polestar.Fire("SHOW_STATS")
V.OnNav("world")
local full = V.Shown().size
-- A short window: 360 pixels of page under the tabs.
for _, f in ipairs(stub.frames) do if f.Child then f:SetHeight(360) end end
V.Render()
local s = V.Shown()
local short = s.size
V.Zoom(-40)
local whole = { V.Shown().zoom, V.Shown().focus[1], V.Shown().art.tiles }
V.Pan(0, 100000)
local top = V.Shown().focus[2]
for _, f in ipairs(stub.frames) do if f.Child then f:SetHeight(120) end end
V.Render()
emit({ ratio = full[2] / full[1], width = short[1] == full[1], short = short[2], fits = short[2] < full[2] and short[2] + 102 <= 360,
	whole = whole, top = top, half = 50 * short[2] / full[2], least = V.Shown().size[2] })"#,
	);
	assert!((f64(&out["ratio"]) - 2.0 / 3.0).abs() < 0.01, "with room, three wide to two high: {}", out["ratio"]);
	assert_eq!(out["width"], true);
	assert_eq!(out["fits"], true, "the frame, the line over it and the scale under it fit the window: {}", out["short"]);
	assert_eq!(out["whole"][0], 1);
	assert_eq!(out["whole"][1], 50, "the world still fills the frame's width");
	assert!((f64(&out["top"]) - f64(&out["half"])).abs() < 0.2, "dragged down as far as it goes, the world's top edge is the frame's: {} / {}", out["top"], out["half"]);
	assert_eq!(out["least"], 160, "never flatter than this");
}

fn f64(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

#[test]
fn heat_is_spread_over_the_neighbouring_cells_and_coloured_against_a_high_percentile() {
	let out = run_in(
		r#"
local w = stub.world
-- A hundred cells with a kill each along a line, and one with 3,600 of them.
local seed = 1
Stats.Roll = function() seed = (seed * 16807) % 2147483647 return seed / 2147483647 end
local function kills(x, y, n) w.moveTo(1439, x, y) for _ = 1, n do stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "x") end end
for i = 0, 99 do kills(20 + i * 0.5, 40, 1) end
kills(97, 97, 3600)
Polestar.Fire("SHOW_STATS")
local V = Polestar.UI.StatsSection
V.OnNav("map:1439")
V.SetLayer("k")
for _ = 1, 40 do V.Zoom(1, 0, 0) end           -- as far in as it goes, on the top left corner: cells, not blocks
V.Pan(-100000, -100000)                        -- then the bottom right, where the 3,600 are
local hot, strongest, n, faintest = 0, 0, 0, nil
for _, f in ipairs(stub.frames) do
	for _, tex in ipairs(f.regions or {}) do
		if tex.IsShown and tex:IsShown() and tex.GetTexture and tostring(tex:GetTexture()):find("blob") then
			n = n + 1
			local r, g, b, a = tex:GetVertexColor()
			strongest = math.max(strongest, a)
			faintest = math.min(faintest or a, a)
			if r == 1 and g < 0.2 then hot = hot + 1 end
		end
	end
end
emit({ total = V.Shown().total, cells = V.Shown().cells, blobs = n, hot = hot, alpha = { faintest, strongest } })"#,
		WITH_UI,
		true,
	);
	assert_eq!(out["total"], 3700, "spreading keeps the layer's total");
	assert_eq!(out["cells"], 9, "the one cell in the corner, over itself and its eight neighbours");
	assert_eq!(out["blobs"], 9);
	assert_eq!(out["hot"], 9, "the line's cells set the scale (the hottest fiftieth), so all of the hour's spot is at the top of it, not alone there");
	assert_eq!(out["alpha"], json!([0.2, 0.2]), "every blob as see-through as the next: only the colour says how hot");
}

/// Polestar alone on the world stub, the Stats addon in the AddOns list or not, logged in by the script.
fn run_core(installed: bool, script: &str) -> Value {
	let before = if installed { "stub.addons[#stub.addons + 1] = { name = \"Polestar_Stats\", reason = \"DEMAND_LOADED\" }\n" } else { "" };
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: before.into(), addons: vec![Addon::files("Polestar", CORE)], login: false, script: script.into(), ..Default::default() }).remove(0)
}

#[test]
fn without_the_stats_addon_nothing_is_loaded_or_offered() {
	let out = run_core(
		false,
		r#"
stub.login()
Polestar.Fire("SHOW_STATS")
emit({ installed = Polestar.StatsPack.Installed(), loaded = Polestar.Stats ~= nil, saved = PolestarStatsCharDB ~= nil })"#,
	);
	assert_eq!(out, json!({ "installed": false, "loaded": false, "saved": false }));
}

#[test]
fn the_stats_addon_loads_at_login_while_stats_is_on_and_else_when_it_is_turned_on_or_its_page_is_opened() {
	let on = run_core(true, "stub.login()\nemit({ loaded = Polestar.Stats ~= nil, counting = PolestarStatsCharDB ~= nil })");
	assert_eq!(on, json!({ "loaded": true, "counting": true }), "on by default: loaded and counting from the login");
	let off = run_core(
		true,
		r#"
Polestar.Set("stats.enabled", false)
stub.login()
local atLogin = Polestar.Stats ~= nil
Polestar.Set("stats.enabled", true)
emit({ atLogin = atLogin, turnedOn = Polestar.Stats ~= nil })"#,
	);
	assert_eq!(off, json!({ "atLogin": false, "turnedOn": true }), "off: not in memory until it is turned on");
	let page = run_core(
		true,
		r#"
Polestar.Set("stats.enabled", false)
stub.login()
Polestar.Fire("SHOW_STATS")
local s = Polestar.Stats
s.Tick(2)
emit({ opened = s ~= nil, counted = s.Store().active })"#,
	);
	assert_eq!(page, json!({ "opened": true, "counted": 0 }), "its page opened while off shows what was counted, and counts nothing");
}

#[test]
fn a_part_turned_off_counts_nothing_the_others_go_on_and_what_it_counted_stays() {
	let out = run(r#"
local w = stub.world
w.accept(7, { 1 })
stub.fire("PLAYER_REGEN_DISABLED")
Stats.Tick(2)
for _, part in ipairs({ "quests", "fights", "heat", "path", "money" }) do Polestar.Set("stats." .. part, false) end
w.accept(8, { 1 })
stub.fire("PLAYER_REGEN_DISABLED")
stub.fire("TRAINER_SHOW") w.money = w.money - 10 stub.fire("TRAINER_CLOSED")
w.moveTo(1439, 60, 60) Stats.Tick(2)
w.moveTo(1439, 62, 60) Stats.Tick(2)
local _, heat = Stats.Heat(1439, "t")
local off = { S().accepted, S().fights, S().spent.trainer, heat, #Stats.Store().path, S().played }
Polestar.Set("stats.quests", true)
Polestar.Set("stats.heat", true)
w.accept(9, { 1 })
w.moveTo(1439, 64, 60) Stats.Tick(2)
_, heat = Stats.Heat(1439, "t")
emit({ off = off, on = { S().accepted, S().fights, heat }, parts = { Stats.Part("quests"), Stats.Part("fights"), Stats.Part("activity") } })"#);
	assert_eq!(out["off"], json!([1, 1, 0, 2, 2, 6]), "quests, fights, gold, heat and the path stop where they were; the time played goes on");
	assert_eq!(out["on"], json!([2, 1, 4]), "a part turned back on counts again");
	assert_eq!(out["parts"], json!([true, false, true]));
}

#[test]
fn what_the_map_was_drawn_from_is_let_go_when_another_page_shows_or_the_hub_closes_and_the_view_stays() {
	let out = run_in(
		r#"
local w = stub.world
for i = 0, 5 do w.moveTo(1439, 40 + i, 50) Stats.Tick(2) end
Polestar.Fire("SHOW_STATS")
local V = Polestar.UI.StatsSection
V.OnNav("map:1439")
V.SetLayer("t")
V.Zoom(3)
local zoom, cells = V.Shown().zoom, V.Shown().cells
local held = V.Holds()
V.OnNav("activity")
local afterPage = V.Holds()
V.OnNav("map:1439")
local back = { V.Holds(), V.Shown().zoom == zoom, V.Shown().cells == cells }
V.Build():Hide()
emit({ zoomed = zoom > 1, cells = cells > 0, held = held, afterPage = afterPage, back = back, afterClose = V.Holds() })"#,
		WITH_UI,
		true,
	);
	assert_eq!(out["zoomed"], true);
	assert_eq!(out["cells"], true);
	assert_eq!(out["held"], true, "held while the map is on screen");
	assert_eq!(out["afterPage"], false, "another page: the cells read out of the tiles are let go");
	assert_eq!(out["back"], json!([true, true, true]), "back on the map it is read again, where the view was");
	assert_eq!(out["afterClose"], false, "the page hidden: let go");
}

#[test]
fn a_zones_quests_done_and_rares_killed_are_shares_of_what_the_codex_knows_there_for_this_character() {
	let pack = forge_addontest::codex::write_codex_pack(&forge_addontest::codex::sample_codex(), &forge_addontest::codex::CodexOpts::default());
	let before = format!("{}\n{WORLD}\nlocal w = stub.world\nw.race, w.raceName, w.faction = \"Human\", \"Human\", \"Alliance\"\nw.addMap(1429, {{ name = \"Elwynn Forest\", c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 }})\nw.moveTo(1429, 40, 50)\nw.addMap(947, {{ name = \"Azeroth\", mapType = 1 }})\nfunction C_Map.GetMapRectOnMap(id, top) if top == 947 and id == 1429 then return 0.4, 0.6, 0.4, 0.6 end end\nfunction C_Map.GetMapChildrenInfo(_, kind) if kind == 2 then return {{}} end return {{ {{ mapID = 1429 }} }} end\n", pack.stub_lua);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_ui.lua"],
		before,
		addons: addons(&["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml", "Lookup/Lookup.xml"]),
		login: true,
		script: [
			PRELUDE,
			r#"
local w = stub.world
local P = Stats.Progress
assert(P.Ready())
local q0, qd0, qt0 = P.Quests()
local r0 = P.Rares()
-- A kill's XP with the rare dead as the target: this character's kill. Another dead target is none.
local dead, class, npc = true, "rare", 61
UnitExists = function(u) return u == "target" end
UnitIsDead = function(u) return u == "target" and dead end
UnitIsPlayer = function() return false end
UnitClassification = function() return class end
Polestar.Compat.GetNpcID = function() return npc end
class, npc = "normal", 448
stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "x")
local plain = next(Stats.Store().rares) == nil
class, npc = "rare", 61
stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "x")
w.completeQuest = w.completeQuest or function(id) local was = Polestar.Compat.IsQuestCompleted Polestar.Compat.IsQuestCompleted = function(q) return q == id or was(q) end end
w.completeQuest(33)
local q1, qd1 = P.Quests()
local r1, rd1, rt1 = P.Rares()
Polestar.Fire("SHOW_STATS")
local V = Polestar.UI.StatsSection
V.OnNav("completion")
V.SetTab("Q")
local quests = { V.Shown().page, V.Shown().total, V.Shown().rows }
V.SetTab("R")
local list = { V.Shown().total, V.Shown().rows, V.Holds() }
Stats.Tick(2)
V.OnNav("world")
V.SetLayer("R")
local rares = { V.Shown().total, V.Shown().cells, V.Shown().page, V.Shown().rows == nil }
V.OnNav("activity")
emit({ start = { q0[1429].done, q0[1429].total, qd0, qt0, r0[1429].done, r0[1429].total }, plain = plain, saved = Stats.Store().rares[61] ~= nil,
	after = { q1[1429].done, qd1, r1[1429].done, rd1, rt1, #r1[1429].spots, r1[1429].spots[1][3] }, quests = quests, list = list, rares = rares })"#,
		]
		.concat(),
		..Default::default()
	})
	.remove(0);
	drop(pack);
	assert_eq!(out["start"], json!([0, 2, 0, 2, 0, 1]), "Elwynn's two quests and its one rare, none done");
	assert_eq!(out["plain"], true, "a kill that is no rare is none");
	assert_eq!(out["saved"], true);
	assert_eq!(out["after"], json!([1, 1, 1, 1, 1, 2, true]), "one quest handed in, the rare killed: its two spawns marked");
	assert_eq!(out["quests"][1], 1);
	assert_eq!(out["quests"][2], 1, "a row for the zone");
	assert_eq!(out["list"], json!([1, 1, false]), "the Rares tab lists the zone too, and the page holds no map");
	assert_eq!(out["rares"][2], "world");
	assert_eq!(out["rares"][3], true, "the world map's tab has no list under it");
	assert_eq!(out["rares"][0], 1);
	assert_eq!(out["rares"][1], 3, "the rare's two spawns and the zone's percentage are drawn on the world map");
	assert_eq!(out["quests"][0], "completion", "both are tabs of the Completion page");
}
