//! A character in each capital of its faction, with the city's people around it: every NPC the shipped Codex
//! places in that city on the player's side (guards, vendors, trainers, elites, the faction leaders), every leader
//! of the faction in each of its capitals (Jaina, Mekkatorque and Vol'jin included), one elite the client calls
//! "rare", and a minimap vignette for each of them the client calls rare or the Codex lists as a rare (the data
//! build lists none on a player faction's side since 0.4.2, so the elite's vignette is the one shown). Each is
//! seen the four ways the rare detector listens to (nameplate, target, mouseover, minimap vignette), then two
//! minutes pass. Nothing of it may reach the player: no rare alert or card, no sound, no chat line, no
//! raid-warning, error-frame line or flash (#2929, #2942: 0.4.1 alerted Thrall, Magni and the other leaders). The
//! same run ends outside the cities with a hostile rare on a nameplate, which alerts once: the detector was live
//! all along. In each city the Rares section opens on the full list and the city's map pins only the rares
//! that spawn there (none in most capitals; the Sewer Beast in Stormwind, Soboz in the Undercity).

use crate::common::{play, release_or_skip, Play};
use forge_addontest::assert_timing;
use serde_json::Value;

/// The capitals (map, name, continent and the map's bounds in world yards), the faction leaders shown in them
/// whatever the Codex says of their spawns, and the city crowd read from the Codex.
const CROWD: &str = r#"
local CAPITALS = {
	Horde = {
		{ 1454, "Orgrimmar", 1, -3680.601, -5083.206, 2273.877, 1338.461 },
		{ 1456, "Thunder Bluff", 1, 516.667, -527.083, -849.999, -1545.833 },
		{ 1458, "Undercity", 0, 873.193, -86.182, 1877.945, 1237.841 },
	},
	Alliance = {
		{ 1453, "Stormwind City", 0, 1380.971, 36.701, -8278.851, -9175.205 },
		{ 1455, "Ironforge", 0, -713.591, -1504.216, -4569.241, -5096.846 },
		{ 1457, "Darnassus", 1, 2938.36, 1880.03, 10238.32, 9532.59 },
	},
}
-- Thrall, Cairne, Sylvanas, Varimathras, Vol'jin; Bolvar, Katrana Prestor, Magni, Tyrande, Fandral, Jaina,
-- Mekkatorque, Benedictus.
local LEADERS = { Horde = { 4949, 3057, 10181, 2425, 10540 }, Alliance = { 1748, 1749, 2784, 7999, 3516, 4968, 7937, 1284 } }
local C = Polestar.Codex
assert(C and C.Load and C.Each and C.Npc, "Polestar.Codex: no Load, Each or Npc")
assert(C.Load(), "the shipped Codex did not load")
local w, U = stub.world, stub.rares
local mine = w.faction == "Alliance" and "A" or "H"

local function unitOf(id, r)
	local class = r.boss and "worldboss" or r.elite and "elite" or r.rare and "rare" or "normal"
	return { npc = id, name = r.name, level = r.level or 60, class = class, friendly = true, codexRare = r.rare or nil }
end

-- Every NPC with a spawn on `map` whose Codex faction is the player's (on the player's side: the client says
-- UnitCanAttack false), then the leaders not among them, then one elite again under its own GUID, classed rare.
function crowdOf(map)
	local out, seen = {}, {}
	local function walk(id)
		if seen[id] then return end
		local r = C.Npc(id)
		if not (r and (r.faction or ""):find(mine, 1, true)) then return end
		for _, s in ipairs(r.spawns or {}) do
			if s.map == map then
				seen[id] = true
				out[#out + 1] = unitOf(id, r)
				return
			end
		end
	end
	C.Each("npc", walk)
	C.Each("rare", walk)
	for _, id in ipairs(LEADERS[w.faction]) do
		local r = C.Npc(id)
		if r and not seen[id] then
			seen[id] = true
			local u = unitOf(id, r)
			u.class = "worldboss"
			out[#out + 1] = u
		end
	end
	for _, u in ipairs(out) do
		if u.class == "elite" then
			out[#out + 1] = { guid = "Creature-0-1-0-1-" .. u.npc .. "-0000FFF" .. u.npc, npc = u.npc, name = u.name, level = u.level, class = "rare", friendly = true }
			break
		end
	end
	return out
end

-- A rare the Codex puts on no side, spawning outside the capitals: the control.
function hostileRare()
	local found
	C.Each("rare", function(id)
		local r = C.Npc(id)
		local s = r and not r.faction and r.spawns and r.spawns[1]
		if s and s.map and not (s.map >= 1453 and s.map <= 1458) and not (Polestar.Rares.NOT_RARE or {})[id] then
			found = { npc = id, name = r.name, level = r.level or 30, class = "rare", map = s.map, x = s.x, y = s.y }
			return false
		end
	end)
	return found
end
"#;

const SCENE: &str = r#"
local spotted = {}
Polestar.On("RARE_SPOTTED", function(a) spotted[#spotted + 1] = a.name or "?" end)
local out = { capitals = {} }
for _, cap in ipairs(CAPITALS[w.faction]) do
	local map = cap[1]
	w.addMap(map, { name = cap[2], c = cap[3], left = cap[4], right = cap[5], top = cap[6], bottom = cap[7] })
	w.moveTo(map, 50, 50)
	w.resting = true
	w.setZone(cap[2], "")
	-- Arriving may bring what the city itself offers (the dungeon heads-up): not the crowd's doing.
	stub.advance(10)
	local crowd = crowdOf(map)
	local s, n0 = Scene.snap(), #spotted
	local total, worst = 0, 0
	for i, u in ipairs(crowd) do
		local t = Scene.work(function()
			U.unit("nameplate" .. i, u)
			stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate" .. i)
		end).ms
		total = total + t
		if t > worst then worst = t end
	end
	-- Past the detector's per-unit pause before the next way of seeing them.
	stub.advance(4)
	for _, u in ipairs(crowd) do
		U.unit("target", u)
		stub.fire("PLAYER_TARGET_CHANGED")
	end
	U.clear("target")
	stub.fire("PLAYER_TARGET_CHANGED")
	stub.advance(4)
	for _, u in ipairs(crowd) do
		U.unit("mouseover", u)
		stub.fire("UPDATE_MOUSEOVER_UNIT")
	end
	U.clear("mouseover")
	stub.advance(4)
	local vignettes, codexRares = {}, 0
	for _, u in ipairs(crowd) do
		if u.codexRare then codexRares = codexRares + 1 end
		if u.codexRare or u.class == "rare" then
			local g = "Vignette-" .. map .. "-" .. u.npc
			U.vignette(g, { npc = u.npc, name = u.name, map = map, x = 50, y = 50 })
			stub.fire("VIGNETTE_MINIMAP_UPDATED", g, true)
			vignettes[#vignettes + 1] = u.name
		end
	end
	stub.fire("VIGNETTES_UPDATED")
	stub.advance(120)
	for i = 1, #crowd do
		U.clear("nameplate" .. i)
		stub.fire("NAME_PLATE_UNIT_REMOVED", "nameplate" .. i)
	end
	while #U.order > 0 do U.vignetteGone(U.order[1]) end
	stub.fire("VIGNETTES_UPDATED")
	local d = Scene.since(s)
	d.alerted = {}
	for i = n0 + 1, #spotted do d.alerted[#d.alerted + 1] = spotted[i] end
	local classes, leaders = {}, {}
	for _, u in ipairs(crowd) do
		classes[u.class] = (classes[u.class] or 0) + 1
		if u.class == "worldboss" then leaders[#leaders + 1] = u.name end
	end
	-- The Rares section and the rare pins, opened in the city (after the counts above): with no friendly rare in the
	-- Codex the section still lists every rare (the hostile ones of the city too: the Sewer Beast, Soboz) and the
	-- city's map pins as many rares as spawn on it.
	local RV = assert(Polestar.UI.RaresSection, "no Rares section")
	RV.Show("rare")
	local shown = RV.Shown()
	local here, pins = 0, 0
	local list = Polestar.Rares.ListOf("rare") or {}
	for _, rec in ipairs(list) do
		for _, sp in ipairs(rec.spawns) do
			if sp.map == map then here = here + 1 break end
		end
	end
	for _, p in ipairs(Polestar.Rares.BuildPins({ kind = "rare", list = list, level = w.level })) do
		if p.map == map then pins = pins + 1 end
	end
	out.capitals[#out.capitals + 1] = { name = cap[2], units = #crowd, classes = classes, leaders = leaders, leaderCount = #leaders,
		vignettes = vignettes, vignetteCount = #vignettes, codexRares = codexRares, seen = d, meanMs = total / #crowd, worstMs = worst,
		section = { tab = shown.tab, listed = shown.list or 0, empty = shown.empty or false, selected = shown.selected or false, here = here, pins = pins } }
end
-- The control: out of the cities, a hostile rare on a nameplate.
local r = assert(hostileRare(), "the Codex has no rare on no side")
w.resting = false
w.addMap(r.map, { name = "Zone " .. r.map })
w.moveTo(r.map, r.x or 50, r.y or 50)
w.setZone("Zone " .. r.map, "")
stub.advance(10)
local s, n0 = Scene.snap(), #spotted
U.unit("nameplate1", r)
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
stub.advance(5)
out.control = Scene.since(s)
out.control.name = r.name
out.control.alerted = {}
for i = n0 + 1, #spotted do out.control.alerted[#out.control.alerted + 1] = spotted[i] end
emit(out)
"#;

fn side(faction: &str, race: &str, race_id: u32) -> Value {
	play(&Play {
		stubs: vec!["stub_rares.lua"],
		before: format!(
			"local w = stub.world\nw.faction, w.race, w.raceName, w.raceID, w.class, w.className, w.classID = {faction:?}, {race:?}, {race:?}, {race_id}, \"WARRIOR\", \"Warrior\", 1\nw.level = 60"
		),
		script: format!("{CROWD}\n{SCENE}"),
		..Default::default()
	})
	.remove(0)
}

fn check(faction: &str, out: &Value) {
	let caps = out["capitals"].as_array().expect("capitals");
	assert_eq!(caps.len(), 3, "{faction}: three capitals");
	for c in caps {
		let name = c["name"].as_str().unwrap();
		let seen = &c["seen"];
		let units = c["units"].as_u64().unwrap();
		assert!(units >= 100, "{name}: only {units} people in the city from the Codex");
		assert!(c["classes"]["rare"].as_u64().unwrap_or(0) >= 1, "{name}: no friendly NPC the client calls rare among {}", c["classes"]);
		// Counts, not lists: an empty Lua table comes out as `{}`, not `[]`.
		let leaders = c["leaderCount"].as_u64().unwrap();
		let vignettes = c["vignetteCount"].as_u64().unwrap();
		let codex_rares = c["codexRares"].as_u64().unwrap();
		assert!(leaders >= 1, "{name}: no faction leader shown");
		assert!(vignettes >= 1, "{name}: no vignette of a friendly NPC shown");
		assert_eq!(codex_rares, 0, "{name}: the Codex lists {codex_rares} friendly NPCs in the city as rares (the data build leaves them out, #2929 #2942)");
		let sec = &c["section"];
		assert_eq!(sec["tab"], "rare", "{name}: the Rares section opened on {}", sec["tab"]);
		assert_eq!(sec["empty"], false, "{name}: the Rares section is empty ({})", sec["empty"]);
		assert!(sec["listed"].as_u64().unwrap() >= 100, "{name}: the Rares section lists {} rares", sec["listed"]);
		assert!(sec["selected"].is_string(), "{name}: the Rares section selected nothing");
		let (pins, here) = (sec["pins"].as_u64().unwrap(), sec["here"].as_u64().unwrap());
		assert!(pins >= here && (here > 0 || pins == 0), "{name}: {pins} rare pins (one a spawn spot) on the city's map for {here} rares spawning there");
		let said = format!("{faction} in {name}, {units} friendly NPCs (leaders {}, vignettes {}) on nameplate, target, mouseover and the minimap, then 2 minutes", c["leaders"], c["vignettes"]);
		assert_eq!(seen["rares"], 0, "{said}: {} rare alerts for {}", seen["rares"], seen["alerted"]);
		assert_eq!(seen["cards"], 0, "{said}: {} rare cards shown", seen["cards"]);
		assert_eq!(seen["sounds"], 0, "{said}: {} sounds played: {}", seen["sounds"], seen["soundIds"]);
		assert_eq!(seen["chat"], 0, "{said}: {} chat lines: {}", seen["chat"], seen["lines"]);
		assert_eq!(seen["alertTotal"], 0, "{said}: raid-warning, error-frame lines or flashes: {}", seen["alerts"]);
		assert_eq!(seen["autoTotal"], 0, "{said}: automatic actions taken: {}", seen["actions"]);
		// 0.4.1.1 measured 0.04-0.09 ms on average a nameplate, at worst 1 ms (the first one of the session): a
		// nameplate comes for every unit that walks into view, dozens a second in a city.
		let mean = c["meanMs"].as_f64().unwrap();
		let worst = c["worstMs"].as_f64().unwrap();
		assert_timing!(mean <= 0.3, "{faction} in {name}: a nameplate took {mean:.3} ms on average (budget 0.3 ms, {units} nameplates)");
		assert_timing!(worst <= 5.0, "{faction} in {name}: the slowest nameplate took {worst:.2} ms (budget 5 ms)");
	}
	let c = &out["control"];
	assert_eq!(c["rares"], 1, "{faction}: a hostile rare ({}) on a nameplate outside the cities alerted {} times: {}", c["name"], c["rares"], c["alerted"]);
	assert_eq!(c["cards"], 1, "{faction}: the hostile rare's card showed {} times", c["cards"]);
	assert_eq!(c["sounds"], 1, "{faction}: the hostile rare's alert played {} sounds", c["sounds"]);
	assert_eq!(c["chat"], 0, "{faction}: the hostile rare's alert said in chat: {}", c["lines"]);
}

#[test]
fn a_horde_character_in_orgrimmar_thunder_bluff_and_undercity_gets_no_rare_alert_2929_2942() {
	let Some(_) = release_or_skip() else { return };
	check("Horde", &side("Horde", "Orc", 2));
}

#[test]
fn an_alliance_character_in_stormwind_ironforge_and_darnassus_gets_no_rare_alert_2929_2942() {
	let Some(_) = release_or_skip() else { return };
	check("Alliance", &side("Alliance", "Human", 1));
}
