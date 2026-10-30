//! The Rares module: the decision every sighting goes through (Rares.Decide), the live detection paths
//! (nameplates, target, mouseover, vignettes) with their throttles, combat hold and alert cooldown, the "last
//! seen" history, and the map pin selection (Rares.BuildPins) and layers. Real Core, Theme, Nav, Lookup and
//! Rares files over tests/lua/stub_world.lua and stub_rares.lua; the Codex is the sample pack
//! (tests/fixtures/codex/sample.json), loaded the way the client loads it.

use forge_addontest::codex::{sample_codex, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 5] = ["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Lookup/Lookup.xml", "Rares/Rares.xml"];

fn maps(codex: &Value) -> String {
	let mut frames: Vec<(&String, &Value)> = codex["frames"].as_object().unwrap().iter().collect();
	frames.sort_by_key(|(id, _)| id.parse::<u64>().unwrap_or(u64::MAX));
	frames
		.iter()
		.map(|(id, f)| {
			format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})",
				serde_json::to_string(&codex["zones"][id.as_str()]["name"]).unwrap(),
				f["c"],
				f["left"],
				f["right"],
				f["top"],
				f["bottom"]
			)
		})
		.collect::<Vec<_>>()
		.join("\n")
}

fn pack() -> CodexPack {
	write_codex_pack(&sample_codex(), &CodexOpts { ..Default::default() })
}

const PRELUDE: &str = r#"local R = Polestar.Rares
local got = {}
Polestar.On("RARE_SPOTTED", function(a) got[#got + 1] = a end)
local function names() local out = {} for i, a in ipairs(got) do out[i] = a.name end return out end
"#;

fn run_with(script: &str, at: [i32; 3], settings: Option<&str>) -> Vec<Value> {
	let codex = sample_codex();
	let pack = pack();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_rares.lua"],
		before: format!("{}\nlocal w = stub.world\n{}\nw.moveTo({}, {}, {})\nw.setLevel(10)\n", pack.stub_lua, maps(&codex), at[0], at[1], at[2]),
		addons: vec![Addon::files("Polestar", &FILES)],
		saved: settings.map(|s| ("Polestar".to_string(), format!("PolestarDB = {{ schema = 1, settings = {{ rares = {s} }} }}"))).into_iter().collect(),
		login: true,
		script: format!("{PRELUDE}{script}"),
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, [1429, 88, 78], None)
}

// ------------------------------------------------------------- the decision

#[test]
fn decide_every_reason_a_sighting_is_skipped_recorded_held_or_alerted() {
	let out = run(r#"
local defaults = { enabled = true, vignettes = true, nameplates = true, target = true, mouseover = true, alerts = true,
	treasureAlerts = true, cooldown = 10, combatAlerts = false, ignored = false }
local function ctx(over, extra)
	local cfg = {}
	for k, v in pairs(defaults) do cfg[k] = v end
	for k, v in pairs(over or {}) do cfg[k] = v end
	local c = { get = function(k) return cfg[k] end, now = 100000, history = {}, inCombat = false, inInstance = false,
		known = function(kind, id) return id == 61 end }
	for k, v in pairs(extra or {}) do c[k] = v end
	return c
end
local function d(s, over, extra) local a, r = R.Decide(s, ctx(over, extra)); return { a, r } end
local rare = { source = "nameplate", kind = "rare", id = 99, name = "Morgaine the Sly", classification = "rare" }
local function with(t) local s = {} for k, v in pairs(rare) do s[k] = v end for k, v in pairs(t) do s[k] = v end return s end
emit({
	alert = d(rare),
	rareElite = d(with({ classification = "rareelite" })),
	off = d(rare, { enabled = false }),
	instance = d(rare, nil, { inInstance = true }),
	sourceOff = d(rare, { nameplates = false }),
	targetOff = d(with({ source = "target" }), { target = false }),
	player = d(with({ player = true })),
	elite = d(with({ classification = "elite" })),
	normalKnown = d(with({ classification = "normal", id = 61 })),
	vignette = d(with({ source = "vignette", classification = nil })),
	noKey = d({ source = "nameplate", kind = "rare", classification = "rare" }),
	ignored = d(rare, { ignored = { ["rare:99"] = true } }),
	dead = d(with({ dead = true })),
	alertsOff = d(rare, { alerts = false }),
	treasure = d({ source = "vignette", kind = "treasure", id = 2843, name = "Battered Chest" }),
	treasuresOff = d({ source = "vignette", kind = "treasure", id = 2843 }, { treasureAlerts = false }),
	cooling = d(rare, nil, { history = { ["rare:99"] = { alerted = 100000 - 5 * 60 } } }),
	cooled = d(rare, nil, { history = { ["rare:99"] = { alerted = 100000 - 11 * 60 } } }),
	combat = d(rare, nil, { inCombat = true }),
	combatOn = d(rare, { combatAlerts = true }, { inCombat = true }),
	keys = { R.Key("rare", 61), R.Key("treasure", 2843), R.Key("rare", nil, "Some Name"), R.Key("rare") },
})"#);
	let out = &out[0];
	assert_eq!(out["alert"], json!(["alert"]));
	assert_eq!(out["rareElite"], json!(["alert"]));
	assert_eq!(out["off"], json!(["skip", "off"]));
	assert_eq!(out["instance"], json!(["skip", "instance"]));
	assert_eq!(out["sourceOff"], json!(["skip", "source"]));
	assert_eq!(out["targetOff"], json!(["skip", "source"]));
	assert_eq!(out["player"], json!(["skip", "player"]));
	assert_eq!(out["elite"], json!(["skip", "notRare"]), "an elite that is not a rare is passed over");
	assert_eq!(out["normalKnown"], json!(["alert"]), "a Codex rare counts even when the client calls it normal");
	assert_eq!(out["vignette"], json!(["alert"]), "a creature vignette is a rare by the client's word");
	assert_eq!(out["noKey"], json!(["skip", "unknown"]));
	assert_eq!(out["ignored"], json!(["skip", "ignored"]));
	assert_eq!(out["dead"], json!(["record", "dead"]));
	assert_eq!(out["alertsOff"], json!(["record", "alertsOff"]));
	assert_eq!(out["treasure"], json!(["alert"]));
	assert_eq!(out["treasuresOff"], json!(["record", "treasuresOff"]));
	assert_eq!(out["cooling"], json!(["record", "cooldown"]));
	assert_eq!(out["cooled"], json!(["alert"]));
	assert_eq!(out["combat"], json!(["hold", "combat"]));
	assert_eq!(out["combatOn"], json!(["alert"]));
	assert_eq!(out["keys"], json!(["rare:61", "treasure:2843", "name:Some Name"]));
}

// ---------------------------------------------------- detection and cooldown

#[test]
fn a_rare_nameplate_alerts_once_sound_history_debounce_then_the_per_rare_cooldown() {
	let out = run(r#"
local U = stub.rares
U.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
local a = got[1]
emit({ n = #got, name = a.name, level = a.level, kind = a.kind, inSight = a.inSight, zone = a.zone, sounds = #stub.sounds })
local e = R.History()["rare:61"]
emit({ name = e.name, n = e.n, src = e.src, map = e.map, x = e.x, alerted = e.alerted == e.t })
-- The same plate again at once: the GUID was just looked at.
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
emit({ n = #got, seen = R.History()["rare:61"].n })
-- A few seconds on, targeted: seen again, but inside the cooldown.
stub.advance(4)
stub.fire("PLAYER_TARGET_CHANGED")
U.unit("target", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.advance(4)
stub.fire("PLAYER_TARGET_CHANGED")
emit({ n = #got, seen = R.History()["rare:61"].n })
-- Past the 10 minute cooldown it alerts again.
stub.advance(11 * 60)
stub.fire("PLAYER_TARGET_CHANGED")
emit({ n = #got, source = got[#got].source, sounds = #stub.sounds })"#);
	assert_eq!(out[0], json!({ "n": 1, "name": "Thuros Lightfingers", "level": 11, "kind": "rare", "inSight": true, "zone": "Elwynn Forest", "sounds": 1 }));
	assert_eq!(out[1], json!({ "name": "Thuros Lightfingers", "n": 1, "src": "nameplate", "map": 1429, "x": 88, "alerted": true }));
	assert_eq!(out[2], json!({ "n": 1, "seen": 1 }));
	assert_eq!(out[3], json!({ "n": 1, "seen": 2 }));
	assert_eq!(out[4], json!({ "n": 2, "source": "target", "sounds": 2 }));
}

#[test]
fn nearby_a_spotted_rare_stays_while_the_client_shows_it_goes_when_it_dies_or_is_out_of_sight() {
	let out = run(r#"
local U = stub.rares
local fired = 0
Polestar.On("RARE_NEARBY", function() fired = fired + 1 end)
emit(#R.Nearby())
U.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
emit({ R.Nearby()[1], #R.Nearby(), fired })
-- Past the time a sighting is trusted, the plate still shows it: it stays.
stub.advance(60)
emit(#R.Nearby())
-- Dead on the plate and seen again: gone at once.
U.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare", dead = true })
stub.advance(4)
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
emit(#R.Nearby())
-- Alive again, then out of sight for good.
U.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.advance(4)
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
emit(#R.Nearby())
U.clear("nameplate1")
stub.advance(60)
emit(#R.Nearby())
-- A treasure and an ordinary mob never list.
U.unit("nameplate2", { npc = 257, name = "Kobold Worker", level = 3, class = "normal" })
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate2")
emit(#R.Nearby())"#);
	assert_eq!(out[0], 0);
	assert_eq!(out[1], json!(["Thuros Lightfingers", 1, 1]));
	assert_eq!(out[2], 1);
	assert_eq!(out[3], 0);
	assert_eq!(out[4], 1);
	assert_eq!(out[5], 0);
	assert_eq!(out[6], 0);
}

#[test]
fn ordinary_mobs_players_pets_secret_guids_and_turned_off_paths_raise_nothing() {
	let out = run(r#"
local U = stub.rares
U.unit("nameplate1", { npc = 257, name = "Kobold Worker", level = 3, class = "normal" })
U.unit("nameplate2", { npc = 300, name = "Elite Guard", level = 30, class = "elite" })
U.unit("nameplate3", { guid = "Player-1-0000BEEF", name = "Someone", level = 10, class = "rare", player = true })
U.unit("nameplate4", { npc = 99, name = "Tamed Rare", level = 10, class = "rare", controlled = true })
U.unit("nameplate5", { npc = 100, name = "Hidden", level = 10, class = "rare", secret = true })
for i = 1, 5 do stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate" .. i) end
Polestar.Set("rares.mouseover", false)
U.unit("mouseover", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("UPDATE_MOUSEOVER_UNIT")
local n = 0
for _ in pairs(R.History()) do n = n + 1 end
emit({ alerts = #got, history = n, paths = R.Detect.Paths() })"#);
	let out = &out[0];
	assert_eq!(out["alerts"], 0);
	assert_eq!(out["history"], 0);
	assert_eq!(out["paths"], json!({ "vignettes": true, "nameplates": true, "target": true }));
}

#[test]
fn a_codex_rare_the_client_calls_normal_is_caught_once_the_codex_is_loaded() {
	let out = run(r#"
local U = stub.rares
U.unit("target", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "normal" })
stub.fire("PLAYER_TARGET_CHANGED")
local before = #got
Polestar.Codex.Load()
stub.advance(4)
stub.fire("PLAYER_TARGET_CHANGED")
local a = got[1]
emit({ before = before, after = #got, loot = a.loot, map = a.map, x = a.x, f = a.f })"#);
	// The rare is in sight, so the waypoint is where it was seen, not a spawn; its loot is counted.
	assert_eq!(out[0], json!({ "before": 0, "after": 1, "loot": 2, "map": 1429, "x": 88 }));
}

#[test]
fn a_rare_in_sight_sets_its_waypoint_where_it_was_seen_not_at_a_known_spawn_across_the_zone() {
	// Thuros's spawns are at 89.4 and 69.6; the player meets it walking at 75, 60.
	let out = run_with(
		r#"
local U = stub.rares
Polestar.Codex.Load()
U.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
local a = got[1]
local distance = R.Toast.Distance(a)
PolestarRareToast.Waypoint:Click()
local t = Polestar.Nav.GetTarget()
emit({ map = a.map, x = a.x, y = a.y, spawn = a.spawnYards or false, distance = distance, target = { t.map, t.x, t.y } })"#,
		[1429, 75, 60],
		None,
	);
	assert_eq!(out[0], json!({ "map": 1429, "x": 75, "y": 60, "spawn": false, "distance": "In sight", "target": [1429, 75, 60] }));
}

#[test]
fn a_vignette_without_a_position_its_nearest_known_spawn_said_so_and_the_live_position_once_the_vignette_has_one() {
	let out = run(r#"
local U = stub.rares
Polestar.Codex.Load()
-- On the minimap, but no position on the player's map yet.
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers" })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
local a = got[1]
emit({ map = a.map, x = a.x, f = a.f, spawn = a.spawnYards and math.floor(a.spawnYards + 0.5), inSight = a.inSight or false, distance = R.Toast.Distance(a) })
-- By the click it has one: the waypoint goes there, not to the spawn.
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers", map = 1429, x = 80, y = 70 })
PolestarRareToast.Waypoint:Click()
local t = Polestar.Nav.GetTarget()
emit({ t.map, t.x, t.y, t.f or false })"#);
	assert_eq!(out[0], json!({ "map": 1429, "x": 89.4, "f": "e", "spawn": 57, "inSight": false, "distance": "Known spawn 55 yd" }));
	assert_eq!(out[1], json!([1429, 80, 70, false]));
}

#[test]
fn a_vignette_without_a_position_and_no_spawn_on_this_continent_offers_no_waypoint_never_a_spawn_it_cannot_measure() {
	let out = run_with(
		r#"
local U = stub.rares
Polestar.Codex.Load()
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers" })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
local a = got[1]
emit({ n = #got, map = a.map or false, button = PolestarRareToast.Waypoint:IsShown() })"#,
		[1438, 50, 50],
		None,
	);
	assert_eq!(out[0], json!({ "n": 1, "map": false, "button": false }));
}

#[test]
fn a_vignette_the_player_s_subzone_map_lacks_is_placed_on_its_parent_map() {
	let out = run(r#"
local U = stub.rares
local z = stub.world.maps[1429]
stub.world.addMap(9001, { name = "Fargodeep Mine", c = z.c, left = z.left, right = z.right, top = z.top, bottom = z.bottom, parent = 1429, mapType = 5 })
stub.world.moveTo(9001, 88, 78)
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers", map = 1429, x = 90, y = 78 })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
local a = got[1]
emit({ map = a.map, x = a.x, y = a.y, spawn = a.spawnYards or false })"#);
	assert_eq!(out[0], json!({ "map": 1429, "x": 90, "y": 78, "spawn": false }));
}

#[test]
fn in_combat_an_alert_waits_for_the_fight_to_end_and_is_dropped_when_stale() {
	let out = run(r#"
local U = stub.rares
stub.inCombat = true
U.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
emit({ during = #got, seen = R.History()["rare:61"] ~= nil, held = R.Held() ~= nil })
stub.advance(10)
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
emit({ after = #got, name = got[1] and got[1].name, alerted = R.History()["rare:61"].alerted ~= nil })
-- A second fight, with the rare met over a minute before it ends: no alert.
stub.advance(11 * 60)
stub.inCombat = true
U.unit("nameplate2", { npc = 79, name = "Narg the Taskmaster", level = 10, class = "rareelite" })
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate2")
stub.advance(90)
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
emit({ after = #got })"#);
	assert_eq!(out[0], json!({ "during": 0, "seen": true, "held": true }));
	assert_eq!(out[1], json!({ "after": 1, "name": "Thuros Lightfingers", "alerted": true }));
	assert_eq!(out[2], json!({ "after": 1 }));
}

#[test]
fn vignettes_a_creature_is_a_rare_at_its_exact_distance_a_game_object_a_treasure_the_scan_waits_out_combat() {
	let out = run(r#"
local U = stub.rares
-- 2 map percent east of the player on Elwynn: about 69 yards.
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers", map = 1429, x = 90, y = 78 })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
local a = got[1]
emit({ kind = a.kind, yards = math.floor(a.yards + 0.5), map = a.map, x = a.x, inSight = a.inSight or false })
U.vignette("V2", { object = 2843, name = "Battered Chest", map = 1429, x = 88, y = 80 })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V2", false)
emit({ n = #got })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V2", true)
emit({ n = #got, kind = got[2].kind, name = got[2].name, key = got[2].key })
-- VIGNETTES_UPDATED scans the list two seconds later, never in combat.
U.vignette("V3", { npc = 79, name = "Narg the Taskmaster", map = 1429, x = 70, y = 70 })
stub.inCombat = true
stub.fire("VIGNETTES_UPDATED")
stub.advance(3)
emit({ n = #got })
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
stub.advance(3)
emit({ n = #got, last = got[#got].name })"#);
	assert_eq!(out[0], json!({ "kind": "rare", "yards": 69, "map": 1429, "x": 90, "inSight": false }));
	assert_eq!(out[1], json!({ "n": 1 }), "a vignette leaving the minimap is not a sighting");
	assert_eq!(out[2], json!({ "n": 2, "kind": "treasure", "name": "Battered Chest", "key": "treasure:2843" }));
	assert_eq!(out[3], json!({ "n": 2 }));
	assert_eq!(out[4], json!({ "n": 3, "last": "Narg the Taskmaster" }));
}

#[test]
fn nothing_is_detected_inside_an_instance_and_rares_off_unwires_every_path() {
	let out = run(r#"
local U = stub.rares
stub.world.inInstance = true
U.unit("target", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("PLAYER_TARGET_CHANGED")
emit({ n = #got })
stub.world.inInstance = false
Polestar.Set("rares.enabled", false)
stub.advance(4)
stub.fire("PLAYER_TARGET_CHANGED")
emit({ n = #got, paths = R.Detect.Paths() })"#);
	assert_eq!(out[0], json!({ "n": 0 }));
	assert_eq!(out[1], json!({ "n": 0, "paths": {} }));
}

#[test]
fn the_toast_shows_the_alert_name_facts_line_distance_actions_show_rare_opens_the_section_event() {
	let out = run(r#"
local U = stub.rares
local opened
Polestar.On("SHOW_RARES", function(kind, id) opened = { kind, id } end)
Polestar.Codex.Load()
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers", map = 1429, x = 90, y = 78 })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
local f = PolestarRareToast
local shown = f:IsShown()
local facts, distance = f.Facts:GetText(), f.Distance:IsShown() and f.Distance:GetText()
local name = f.Name:GetText()
local label = f.Open.Label:GetText()
f.Open:Click()
emit({ shown = shown, name = name, facts = facts, distance = distance, label = label, opened = opened, hidden = not f:IsShown() })"#);
	let out = &out[0];
	assert_eq!(out["shown"], true);
	assert_eq!(out["name"], "Thuros Lightfingers");
	assert_eq!(out["facts"], "Level 11 Rare  \u{b7}  Elwynn Forest");
	assert_eq!(out["distance"], "70 yd");
	assert_eq!(out["label"], "Show rare");
	assert_eq!(out["opened"], json!(["rare", 61]));
	assert_eq!(out["hidden"], true);
}

#[test]
fn the_treasure_toast_names_what_it_opens_show_treasure() {
	let out = run(r#"
Polestar.Codex.Load()
Polestar.Fire("RARE_SPOTTED", R.AlertOf({ source = "vignette", kind = "treasure", id = 2843, name = "Battered Chest" }, { map = 1429, x = 79.6, y = 55.7 }, true))
emit({ label = PolestarRareToast.Open.Label:GetText() })"#);
	assert_eq!(out[0]["label"], "Show treasure");
}

// ------------------------------------------------------------ the section

#[test]
fn signature_drop_one_the_codex_knows_only_from_this_rare_first_then_quality_then_item_level() {
	let pack = pack();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_rares.lua"],
		before: pack.stub_lua.clone(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Lookup/Lookup.xml", "UI/UI.xml", "Rares/Rares.xml"])],
		login: true,
		script: r#"Polestar.Codex.Load()
local R, sig = Polestar.Rares, Polestar.UI.RaresSection.Signature
local rec = R.Info("rare", 61)
local real = sig(rec, R.Codex(false))
-- Fakes: a better green from a quest beats nothing exclusive; an exclusive white beats it.
local items = {
	[1] = { quality = 2, reqLevel = 12, sources = { { type = "quest", quest = 9 } } },
	[2] = { quality = 2, reqLevel = 8, sources = { { type = "drop", npc = 7 }, { type = "vendor", npc = 3 } } },
	[3] = { quality = 1, reqLevel = 1, sources = { { type = "drop", npc = 7 } } },
	[4] = { quality = 4, reqLevel = 60, sources = {} },
}
local C = { Item = function(id) return items[id] end }
emit({ loot = rec.loot, real = real,
	shared = sig({ kind = "rare", id = 7, loot = { 2, 1 } }, C),
	exclusive = sig({ kind = "rare", id = 7, loot = { 1, 2, 3 } }, C),
	unknown = sig({ kind = "rare", id = 7, loot = { 1, 4 } }, C) })"#
			.into(),
		..Default::default()
	});
	let out = &out[0];
	assert_eq!(out["loot"], json!([1933, 2933]));
	assert_eq!(out["real"], 1933, "Thuros: Staff of Conjuring (his alone), not Seal of Wrynn (a quest reward)");
	assert_eq!(out["shared"], 1, "no exclusive drop: the higher item level");
	assert_eq!(out["exclusive"], 3, "its own drop first, whatever its quality");
	assert_eq!(out["unknown"], 4, "no known source is not exclusive: quality decides");
}

// ------------------------------------------------------------ pin selection

#[test]
fn buildpins_one_pin_per_distinct_spawn_grey_and_placeless_rares_left_out_recent_and_elite_marked() {
	let out = run(r#"
local list = {
	{ kind = "rare", id = 1, name = "Low", level = 3, spawns = { { map = 1429, x = 10, y = 10 } } },
	{ kind = "rare", id = 2, name = "Twice", level = 15, spawns = { { map = 1429, x = 20, y = 20, f = "e" }, { map = 1429, x = 20.8, y = 20.5 }, { map = 1429, x = 40, y = 40 }, { map = 1436, x = 20, y = 20 } } },
	{ kind = "rare", id = 3, name = "Third", level = 12, levelMax = 14, spawns = { { map = 1429, x = 50, y = 50 } } },
	{ kind = "rare", id = 4, name = "Big", level = 14, elite = true, spawns = { { map = 1429, x = 60, y = 60 } } },
	{ kind = "rare", id = 5, name = "Nowhere", level = 14, spawns = {} },
	{ kind = "rare", id = 6, name = "Seen", level = 16, spawns = { { map = 1429, x = 70, y = 70 } } },
}
local function sum(pins)
	local out = {}
	for i, p in ipairs(pins) do out[i] = { p.id, p.map, p.x, p.f or false, p.icon, p.ring and true or false, p.glow or false, p.priority } end
	return out
end
local base = { kind = "rare", list = list, level = 20, now = 100000,
	history = { ["rare:6"] = { t = 100000 - 600 }, ["rare:4"] = { t = 100000 - 3 * 86400 } } }
local all = R.BuildPins(base)
base.hideGrey = true
local grey = R.BuildPins(base)
local tre = R.BuildPins({ kind = "treasure", list = { { kind = "treasure", id = 2843, name = "Battered Chest", spawns = { { map = 1429, x = 63.5, y = 56.1, f = "e" } } } } })
emit({ all = sum(all), grey = sum(grey), greyLevel = { R.GreyLevel(5), R.GreyLevel(20), R.GreyLevel(45), R.GreyLevel(60) },
	treasure = { tre[1].icon, tre[1].kind, tre[1].key, tre[1].size }, color = all[1].color, tip = type(all[1].tooltip) })"#);
	let out = &out[0];
	assert_eq!(
		out["all"],
		json!([
			[1, 1429, 10, false, "qol-target", false, false, 2],
			[2, 1429, 20, "e", "qol-target", false, false, 2],
			[2, 1429, 40, false, "qol-target", false, false, 2],
			[2, 1436, 20, false, "qol-target", false, false, 2],
			[3, 1429, 50, false, "qol-target", false, false, 2],
			[4, 1429, 60, false, "qol-target", true, false, 3],
			[6, 1429, 70, false, "qol-target", false, true, 4],
		])
	);
	let grey: Vec<Value> = out["grey"].as_array().unwrap().iter().map(|p| p[0].clone()).collect();
	assert_eq!(json!(grey), json!([2, 2, 2, 3, 4, 6]), "level 3 is grey at 20 (grey up to 13)");
	assert_eq!(out["greyLevel"], json!([0, 13, 35, 51]));
	assert_eq!(out["treasure"], json!(["icon-treasure", "treasure", "treasure:2843", 13]));
	assert_eq!(out["tip"], "function");
}

#[test]
fn pin_layers_follow_the_settings_minimap_kinds_load_the_codex_after_login_world_kinds_wait_for_the_world_map() {
	let off = run_with(
		r#"
stub.advance(6)
emit({ codex = Polestar.Codex.IsLoaded(), rare = Polestar.Pins.GetLayer("rares.rare") ~= nil })"#,
		[1429, 88, 78],
		Some("{ worldRares = true, worldTreasures = true }"),
	);
	// World-map pins alone wait for the world map: nothing loads at login.
	assert_eq!(off[0], json!({ "codex": false, "rare": false }));

	let on = run_with(
		r#"
local opts, calls = {}, 0
local set = Polestar.Pins.SetLayer
Polestar.Pins.SetLayer = function(name, pins, o) calls = calls + 1; opts[name] = { n = #pins, world = o.world, minimap = o.minimap } return set(name, pins, o) end
stub.advance(6)
emit({ codex = Polestar.Codex.IsLoaded(), rare = opts["rares.rare"], treasure = opts["rares.treasure"] })
WorldMapFrame:Show()
stub.advance(0.1)
emit({ treasure = opts["rares.treasure"] })
Polestar.Set("rares.worldTreasures", false)
emit({ treasure = Polestar.Pins.GetLayer("rares.treasure") ~= nil, rare = opts["rares.rare"] })
Polestar.Set("rares.ignored", { ["rare:61"] = true })
emit({ rare = opts["rares.rare"] })"#,
		[1429, 88, 78],
		Some("{ worldRares = true, worldTreasures = true, minimapRares = true }"),
	);
	assert_eq!(on[0]["codex"], true);
	// The sample Codex: 1 placed rare (2 spawns), 1 treasure (2 spawns). The treasure layer is world-map only,
	// so it waits for the map to open.
	assert_eq!(on[0]["rare"], json!({ "n": 2, "world": true, "minimap": true }));
	assert!(on[0]["treasure"].is_null());
	assert_eq!(on[1]["treasure"], json!({ "n": 2, "world": true, "minimap": false }));
	assert_eq!(on[2], json!({ "treasure": false, "rare": { "n": 2, "world": true, "minimap": true } }));
	assert_eq!(on[3]["rare"]["n"], 2, "muting alerts keeps the rare on the map");
}

#[test]
fn loading_the_codex_decodes_nothing_for_the_pins_until_a_layer_is_due_and_never_inside_the_load() {
	let out = run(r#"
local decoded = 0
local info = R.Info
R.Info = function(...) decoded = decoded + 1 return info(...) end
Polestar.Codex.Load()
local during = decoded
stub.advance(1)
local idle = decoded
-- A minimap kind turned on: the build starts on the next frame, in batches.
Polestar.Set("rares.minimapRares", true)
local sync = decoded
stub.advance(0.1)
emit({ during = during, idle = idle, sync = sync, built = decoded > 0, layer = Polestar.Pins.GetLayer("rares.rare") ~= nil })"#);
	assert_eq!(out[0], json!({ "during": 0, "idle": 0, "sync": 0, "built": true, "layer": true }));
}
