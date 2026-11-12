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
	run_saved(script, at, settings.map(|s| format!("PolestarDB = {{ schema = 1, settings = {{ rares = {s} }} }}")))
}

/// `saved`: the Lua restoring PolestarDB before ADDON_LOADED (a /reload or relog into that state).
fn run_saved(script: &str, at: [i32; 3], saved: Option<String>) -> Vec<Value> {
	let codex = sample_codex();
	let pack = pack();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_rares.lua"],
		before: format!("{}\nlocal w = stub.world\n{}\nw.moveTo({}, {}, {})\nw.setLevel(10)\n", pack.stub_lua, maps(&codex), at[0], at[1], at[2]),
		addons: vec![Addon::files("Polestar", &FILES)],
		saved: saved.map(|s| ("Polestar".to_string(), s)).into_iter().collect(),
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

// Start with a real detection event, not a manually populated hold. The GUID
// is a synthetic creature instance of the existing Thuros fixture.
const HELD_RARE: &str = r#"
local U = stub.rares
stub.inCombat = true
U.unit("target", { guid = "Creature-0-1-0-1-61-000000000001", name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("PLAYER_TARGET_CHANGED")
assert(R.Held() ~= nil, "the sighting must be held during combat")
assert(#got == 0 and #stub.sounds == 0 and not R.Toast.Current(), "nothing alerts during the hold")
local function finishCombat()
	stub.inCombat = false
	stub.fire("PLAYER_REGEN_ENABLED")
	stub.runTimers()
end
local function notificationState()
	local e = R.History()["rare:61"]
	return { alerts = #got, sounds = #stub.sounds,
		toast = PolestarRareToast and PolestarRareToast:IsShown() or false,
		alerted = e ~= nil and e.alerted ~= nil }
end
"#;

fn run_held(script: &str) -> Vec<Value> {
	run(&[HELD_RARE, script].concat())
}

fn quiet() -> Value {
	json!({ "alerts": 0, "sounds": 0, "toast": false, "alerted": false })
}

fn alerted() -> Value {
	json!({ "alerts": 1, "sounds": 1, "toast": true, "alerted": true })
}

#[test]
fn held_rare_alert_observing_the_same_creature_dead_cancels_its_notification_without_starting_a_cooldown() {
	let out = run_held(
		r#"
-- The rare died, but another enemy keeps the player in combat. Moving the
-- cursor over the corpse delivers a fresh observation of the same GUID.
stub.advance(4)
U.units.target.dead = true
U.unit("mouseover", U.units.target)
stub.fire("UPDATE_MOUSEOVER_UNIT")
emit({ recorded = R.History()["rare:61"].dead ~= nil, sightings = R.History()["rare:61"].n })
finishCombat()
emit(notificationState())"#,
	);
	assert_eq!(out[0], json!({ "recorded": true, "sightings": 2 }), "the death observation reached the addon");
	assert_eq!(out[1], quiet());
}

#[test]
fn held_rare_alert_a_death_observed_one_second_after_detection_is_recorded_and_cancels_the_pending_notification() {
	let out = run_held(
		r#"
stub.advance(1)
U.units.target.dead = true
U.unit("mouseover", U.units.target)
stub.fire("UPDATE_MOUSEOVER_UNIT")
emit({ recorded = R.History()["rare:61"].dead ~= nil, sightings = R.History()["rare:61"].n, held = R.Held() ~= nil })
stub.fire("UPDATE_MOUSEOVER_UNIT")
emit(R.History()["rare:61"].n)
finishCombat()
emit(notificationState())"#,
	);
	assert_eq!(out[0], json!({ "recorded": true, "sightings": 2, "held": false }), "the alive-to-dead transition must bypass the GUID debounce");
	assert_eq!(out[1], 2, "an unchanged dead sighting remains throttled");
	assert_eq!(out[2], quiet());
}

#[test]
fn held_rare_alert_unchanged_alive_sightings_stay_throttled_across_unit_sources() {
	let out = run_held(
		r#"
stub.advance(1)
U.unit("mouseover", U.units.target)
stub.fire("UPDATE_MOUSEOVER_UNIT")
stub.fire("PLAYER_TARGET_CHANGED")
emit({ sightings = R.History()["rare:61"].n, held = R.Held() ~= nil, notification = notificationState() })
finishCombat()
emit(notificationState())"#,
	);
	assert_eq!(out[0], json!({ "sightings": 1, "held": true, "notification": quiet() }));
	assert_eq!(out[1], alerted());
}

fn held_then(change: &str) -> Value {
	run_held(&[change, "\nfinishCombat()\nemit(notificationState())"].concat()).remove(0)
}

#[test]
fn held_rare_alert_no_notification_or_cooldown_when_alerts_are_disabled() {
	assert_eq!(held_then(r#"Polestar.Set("rares.alerts", false)"#), quiet());
}

#[test]
fn held_rare_alert_no_notification_or_cooldown_when_the_rare_is_ignored() {
	assert_eq!(held_then(r#"R.Ignore("rare:61", true)"#), quiet());
}

#[test]
fn held_rare_alert_no_notification_or_cooldown_when_its_detection_source_is_disabled() {
	assert_eq!(held_then(r#"Polestar.Set("rares.target", false)"#), quiet());
}

#[test]
fn held_rare_alert_a_different_guid_with_the_same_npc_id_dying_leaves_the_valid_notification_intact() {
	let out = run_held(
		r#"
-- Both GUIDs identify NPC 61, but only the second creature is dead.
U.unit("mouseover", { guid = "Creature-0-1-0-1-61-000000000002", name = "Thuros Lightfingers", level = 11, class = "rare", dead = true })
stub.fire("UPDATE_MOUSEOVER_UNIT")
emit({ recorded = R.History()["rare:61"].dead ~= nil, sightings = R.History()["rare:61"].n,
	other = UnitGUID("target") ~= UnitGUID("mouseover"), alive = not UnitIsDead("target") })
finishCombat()
emit({ notification = notificationState(), name = got[1] and got[1].name })"#,
	);
	assert_eq!(out[0], json!({ "recorded": true, "sightings": 2, "other": true, "alive": true }));
	assert_eq!(out[1], json!({ "notification": alerted(), "name": "Thuros Lightfingers" }));
}

// Exercise the public sighting API: the unit detector itself rejects missing
// GUIDs, but callers must not conflate two unknown identities.
fn uncertain_death(pending_guid: &str, death_guid: &str) {
	let out = run_held(&format!(
		r#"
R.Sighting({{ source = "target", kind = "rare", id = 61, name = "Thuros Lightfingers", classification = "rare", guid = {pending_guid} }})
R.Sighting({{ source = "mouseover", kind = "rare", id = 61, name = "Thuros Lightfingers", classification = "rare", guid = {death_guid}, dead = true }})
emit({{ recorded = R.History()["rare:61"].dead ~= nil, held = R.Held() ~= nil }})
finishCombat()
emit(notificationState())"#
	));
	assert_eq!(out[0], json!({ "recorded": true, "held": true }));
	assert_eq!(out[1], alerted());
}

#[test]
fn held_rare_alert_an_uncertain_death_does_not_cancel_a_sighting_death_guid_unavailable() {
	uncertain_death(r#""Creature-0-1-0-1-61-000000000001""#, "nil");
}

#[test]
fn held_rare_alert_an_uncertain_death_does_not_cancel_a_sighting_pending_guid_unavailable() {
	uncertain_death("nil", r#""Creature-0-1-0-1-61-000000000001""#);
}

#[test]
fn held_rare_alert_an_uncertain_death_does_not_cancel_a_sighting_both_guids_unavailable() {
	uncertain_death("nil", "nil");
}

#[test]
fn held_rare_alert_release_respects_a_newer_alert_cooldown_without_changing_its_timestamp() {
	let out = run_held(
		r#"
Polestar.Set("rares.combatAlerts", true)
stub.advance(4)
stub.fire("PLAYER_TARGET_CHANGED")
local alerted = R.History()["rare:61"].alerted
emit(notificationState())
stub.advance(2)
finishCombat()
emit({ notification = notificationState(), unchanged = R.History()["rare:61"].alerted == alerted })"#,
	);
	assert_eq!(out[0], alerted());
	assert_eq!(out[1], json!({ "notification": alerted(), "unchanged": true }));
}

#[test]
fn held_rare_alert_a_vignette_death_within_one_second_bypasses_debounce_once() {
	let out = run(r#"
local U = stub.rares
stub.inCombat = true
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers", map = 1429, x = 90, y = 78 })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
assert(R.Held() ~= nil and #got == 0, "the vignette alert must start held")
stub.advance(1)
U.vignettes.V1.dead = true
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
emit({ recorded = R.History()["rare:61"].dead ~= nil, sightings = R.History()["rare:61"].n, held = R.Held() ~= nil })
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
emit({ alerts = #got, sounds = #stub.sounds, toast = PolestarRareToast and PolestarRareToast:IsShown() or false,
	alerted = R.History()["rare:61"].alerted ~= nil })"#);
	assert_eq!(out[0], json!({ "recorded": true, "sightings": 2, "held": false }));
	assert_eq!(out[1], quiet());
}

#[test]
fn held_rare_alert_clearing_history_drops_the_pending_notification_and_keeps_history_empty() {
	let out = run_held(
		r#"
R.ClearHistory()
finishCombat()
emit({ notification = notificationState(), empty = next(R.History()) == nil })"#,
	);
	assert_eq!(out[0], json!({ "notification": quiet(), "empty": true }));
}

#[test]
fn held_rare_alert_disabling_the_module_prevents_a_notification_after_combat() {
	let out = run_held(
		r#"
Polestar.Set("rares.enabled", false)
finishCombat()
emit({ notification = notificationState(), paths = R.Detect.Paths(), recorded = R.History()["rare:61"] ~= nil })"#,
	);
	assert_eq!(out[0], json!({ "notification": quiet(), "paths": {}, "recorded": true }));
}

#[test]
fn held_rare_alert_a_later_respawn_can_alert_despite_an_earlier_death_in_history() {
	let out = run(r#"
local U = stub.rares
U.unit("target", { guid = "Creature-0-1-0-1-61-000000000001", name = "Thuros Lightfingers", level = 11, class = "rare", dead = true })
stub.fire("PLAYER_TARGET_CHANGED")
emit({ recorded = R.History()["rare:61"].dead ~= nil, alerted = R.History()["rare:61"].alerted ~= nil,
	alerts = #got, sounds = #stub.sounds })
-- A later spawn of the same NPC is a new creature instance. Keep the
-- earlier death in history: it must not suppress this fresh, live sighting.
stub.advance(11 * 60)
stub.inCombat = true
U.unit("target", { guid = "Creature-0-1-0-1-61-000000000002", name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("PLAYER_TARGET_CHANGED")
emit({ held = R.Held() ~= nil, alerts = #got, sounds = #stub.sounds })
stub.advance(4)
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
emit({ alerts = #got, sounds = #stub.sounds, toast = PolestarRareToast and PolestarRareToast:IsShown() or false,
	name = got[1] and got[1].name, alerted = R.History()["rare:61"].alerted ~= nil })"#);
	assert_eq!(out[0], json!({ "recorded": true, "alerted": false, "alerts": 0, "sounds": 0 }));
	assert_eq!(out[1], json!({ "held": true, "alerts": 0, "sounds": 0 }));
	assert_eq!(out[2], json!({ "alerts": 1, "sounds": 1, "toast": true, "name": "Thuros Lightfingers", "alerted": true }));
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

// The card's Target button needs QoL's macro (QoL/Buttons.lua): these runs add QoL and stub_qol.lua, whose
// secure frames refuse SetAttribute, Show, Hide, SetPoint and ClearAllPoints while stub.inCombat is true.
fn run_card(before: &str, script: &str) -> Vec<Value> {
	let codex = sample_codex();
	let pack = pack();
	let mut files: Vec<&str> = FILES.to_vec();
	files.push("QoL/QoL.xml");
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_rares.lua", "stub_qol.lua"],
		before: format!("{}\nlocal w = stub.world\n{}\nw.moveTo(1429, 88, 78)\nw.setLevel(10)\n{before}\n", pack.stub_lua, maps(&codex)),
		addons: vec![Addon::files("Polestar", &files)],
		saved: vec![],
		login: true,
		script: format!("{PRELUDE}{script}"),
	})
}

const SPOT_THUROS: &str = r#"
Polestar.Codex.Load()
-- stub_qol.lua answers UnitName for its own units, so the alert comes as the nameplate path builds it.
Polestar.Fire("RARE_SPOTTED", R.AlertOf({ source = "nameplate", kind = "rare", id = 61, name = "Thuros Lightfingers" }, { map = 1429, x = 88, y = 78 }, true))
local f, s = PolestarRareToast, PolestarRareCardTarget
local function card()
	local p = s and { s:GetPoint(1) } or {}
	return { shown = f.Target:IsShown(), enabled = f.Target:IsEnabled() and true or false, secure = s and s:IsShown() or false,
		over = p[2] == f.Target, macro = s and s:GetAttribute("macrotext") or false, tip = f.Target.psTipLines and f.Target.psTipLines[1][1] or false }
end
"#;

#[test]
fn rare_card_target_button_targets_the_rare_by_its_full_name_and_pings_it_where_the_client_has_ping() {
	let plain = "/cleartarget [nocombat]\n/targetexact Thuros Lightfingers\n/cleartarget [dead]";
	let out = run_card("SLASH_PING1 = \"/ping\"", &format!("{SPOT_THUROS}emit(card())\nemit(R.Toast.TargetMacro({{ kind = \"rare\", name = \"Bad\\n/run X()\" }}) or false)"));
	assert_eq!(out[0], json!({ "shown": true, "enabled": true, "secure": true, "over": true, "tip": false, "macro": format!("{plain}\n/ping [@target]") }));
	assert_eq!(out[1], json!(false), "a name with a line break never becomes a macro");
	// A client without the command: no ping line.
	let out = run_card("SLASH_PING1 = nil", &format!("{SPOT_THUROS}emit(card().macro)"));
	assert_eq!(out[0], json!(plain));
}

#[test]
fn rare_card_target_button_marks_the_rare_only_with_mark_what_they_target_on_and_its_group_etiquette() {
	let out = run_card(
		"SLASH_PING1 = \"/ping\"",
		&format!(
			r#"{SPOT_THUROS}
emit(card().macro)
R.Toast.Hide()
Polestar.Set("qol.markTarget", true)
R.Toast.Show(R.AlertOf({{ source = "nameplate", kind = "rare", id = 61, name = "Thuros Lightfingers" }}, {{ map = 1429, x = 88, y = 78 }}, true))
emit(card().macro)
-- A party member who doesn't lead: only a unit with no icon gets one.
function IsInGroup() return true end
function IsInRaid() return false end
function UnitIsGroupLeader() return false end
R.Toast.Show(R.AlertOf({{ source = "nameplate", kind = "rare", id = 61, name = "Thuros Lightfingers" }}, {{ map = 1429, x = 88, y = 78 }}, true))
emit(card().macro)
-- A raid member without lead or assist: no icon.
function IsInRaid() return true end
function UnitIsGroupAssistant() return false end
R.Toast.Show(R.AlertOf({{ source = "nameplate", kind = "rare", id = 61, name = "Thuros Lightfingers" }}, {{ map = 1429, x = 88, y = 78 }}, true))
emit(card().macro)"#
		),
	);
	let ping = "/cleartarget [nocombat]\n/targetexact Thuros Lightfingers\n/cleartarget [dead]\n/ping [@target]";
	assert_eq!(out[0], json!(ping), "marking is off by default");
	assert_eq!(out[1], json!(format!("{ping}\n/tm [@target,harm,nodead] !8")));
	assert_eq!(out[2], json!(format!("{ping}\n/tm [@target,harm,nodead] ~8")));
	assert_eq!(out[3], json!(ping));
}

#[test]
fn rare_card_target_button_lets_go_before_a_fight_shows_disabled_with_the_rare_button_s_key_and_comes_back_after() {
	let out = run_card(
		"SLASH_PING1 = \"/ping\"\nstub.qol.bindings[\"CLICK PolestarRareButton:LeftButton\"] = { \"SHIFT-T\" }",
		&format!(
			r#"{SPOT_THUROS}
-- PLAYER_REGEN_DISABLED fires before the lockdown starts.
stub.fire("PLAYER_REGEN_DISABLED")
stub.inCombat = true
local c = card()
c.points = s:GetNumPoints()
emit(c)
-- The card still closes and comes back in the fight: nothing secure is touched.
R.Toast.Hide()
R.Toast.Show(R.AlertOf({{ source = "nameplate", kind = "rare", id = 79, name = "Narg the Taskmaster" }}, {{ map = 1429, x = 88, y = 78 }}, true))
emit(card())
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
emit(card())
stub.qol.bindings["CLICK PolestarRareButton:LeftButton"] = nil
stub.fire("PLAYER_REGEN_DISABLED")
stub.inCombat = true
emit(card().tip)"#
		),
	);
	let thuros = "/cleartarget [nocombat]\n/targetexact Thuros Lightfingers\n/cleartarget [dead]\n/ping [@target]";
	let narg = "/cleartarget [nocombat]\n/targetexact Narg the Taskmaster\n/cleartarget [dead]\n/ping [@target]";
	let keyed = "The card can't target during a fight. Use the rare button or its key (sT).";
	assert_eq!(out[0], json!({ "shown": true, "enabled": false, "secure": false, "over": false, "points": 0, "macro": thuros, "tip": keyed }));
	assert_eq!(out[1], json!({ "shown": true, "enabled": false, "secure": false, "over": false, "macro": thuros, "tip": keyed }), "a card that appears in a fight keeps the old macro, unarmed");
	assert_eq!(out[2], json!({ "shown": true, "enabled": true, "secure": true, "over": true, "macro": narg, "tip": false }));
	assert_eq!(out[3], json!("The card can't target during a fight. Use the rare button."));
}

#[test]
fn rare_card_a_treasure_or_the_options_sample_without_a_rare_has_no_target_button() {
	let out = run_card(
		"",
		r#"
Polestar.Codex.Load()
Polestar.Fire("RARE_SPOTTED", R.AlertOf({ source = "vignette", kind = "treasure", id = 2843, name = "Battered Chest" }, { map = 1429, x = 79.6, y = 55.7 }, true))
emit({ PolestarRareToast.Target:IsShown(), PolestarRareCardTarget:IsShown() })
Polestar.Fire("RARE_SPOTTED", { kind = "rare", name = "A rare", source = "sample", inSight = true })
emit({ PolestarRareToast.Target:IsShown(), PolestarRareCardTarget:IsShown() })"#,
	);
	assert_eq!(out[0], json!([false, false]));
	assert_eq!(out[1], json!([false, false]));
}

// Where a frame is on screen, from its anchors (stub frames keep them, the stub lays nothing out): offsets and
// sizes in the frame's effective scale, UIParent at its own; two anchors span, one places by size. Then what the
// mouse hits at a point: the shown, mouse-enabled candidate highest by strata (inherited from the parents, as
// the client does) and frame level.
const HIT: &str = r#"
local STRATA = { BACKGROUND = 1, LOW = 2, MEDIUM = 3, HIGH = 4, DIALOG = 5, FULLSCREEN = 6, TOOLTIP = 8 }
local function strata(fr) while fr do if fr.strata then return STRATA[fr.strata] end fr = fr.parent end return 3 end
local function at(r, p)
	local x = p:find("LEFT") and r.l or p:find("RIGHT") and r.r or (r.l + r.r) / 2
	local y = p:find("TOP") and r.t or p:find("BOTTOM") and r.b or (r.t + r.b) / 2
	return x, y
end
local function rect(fr)
	local es = fr:GetEffectiveScale()
	if fr == UIParent then return { l = 0, b = 0, r = 1920 * es, t = 1080 * es } end
	local pts = fr.points or {}
	if #pts == 0 then return nil end
	local l, r, t, b, cx, cy
	for _, p in ipairs(pts) do
		local x, y = at(rect(p.rel or fr.parent or UIParent), p.relPoint)
		x, y = x + p.x * es, y + p.y * es
		if p.point:find("LEFT") then l = x elseif p.point:find("RIGHT") then r = x else cx = x end
		if p.point:find("TOP") then t = y elseif p.point:find("BOTTOM") then b = y else cy = y end
	end
	local w, h = fr:GetWidth() * es, fr:GetHeight() * es
	if not l and not r then l = cx - w / 2; r = l + w end
	if not t and not b then b = cy - h / 2; t = b + h end
	l = l or r - w; r = r or l + w; t = t or b + h; b = b or t - h
	return { l = l, r = r, t = t, b = b }
end
local function hit(x, y, ...)
	local best, bs, bl
	for _, fr in ipairs({ ... }) do
		local r = fr:IsVisible() and rect(fr)
		if r and x >= r.l and x <= r.r and y >= r.b and y <= r.t then
			local st, lv = strata(fr), fr:GetFrameLevel()
			if not best or st > bs or (st == bs and lv > bl) then best, bs, bl = fr, st, lv end
		end
	end
	return best
end
"#;

#[test]
fn rare_card_a_mouse_click_on_the_target_button_where_it_shows_targets_the_rare_at_any_ui_scale_and_either_key_down_setting() {
	// Fitz, the installed 0.3.6: the card for Rocklance (in sight, out of combat) showed Target, and a click on it
	// targeted nothing. The overlay was registered for the release only, and with ActionButtonUseKeyDown on (the
	// client's default) SecureActionButton_OnClick acts only on the press.
	let out = run_card(
		"SLASH_PING1 = \"/ping\"",
		&format!(
			r#"{HIT}
local out = {{}}
for _, case in ipairs({{ {{ 1, "1" }}, {{ 0.64, "1" }}, {{ 1.15, "0" }}, {{ 0.8, "0" }} }}) do
	UIParent:SetScale(case[1])
	stub.cvars.ActionButtonUseKeyDown = case[2]
	R.Toast.Hide()
	stub.qol.ran = {{}}
	Polestar.Fire("RARE_SPOTTED", R.AlertOf({{ source = "nameplate", kind = "rare", id = 900001, name = "Rocklance", level = 17, class = "rareelite" }}, {{ map = 1429, x = 88, y = 78 }}, true))
	-- The slide-in runs to its end, then the card is dragged somewhere else.
	stub.advance(1)
	local f, s = PolestarRareToast, PolestarRareCardTarget
	local r1 = rect(f.Target)
	local x, y = (r1.l + r1.r) / 2, (r1.t + r1.b) / 2
	local first = hit(x, y, f, f.Target, s)
	stub.qol.mouseClick(first)
	local ran1 = stub.qol.ran
	stub.qol.ran = {{}}
	f:ClearAllPoints()
	f:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 40, 60)
	local r2 = rect(f.Target)
	local moved = hit((r2.l + r2.r) / 2, (r2.t + r2.b) / 2, f, f.Target, s)
	stub.qol.mouseClick(moved)
	out[#out + 1] = {{ first = first == s, moved = moved == s, ran = ran1, ranMoved = stub.qol.ran, printed = #stub.messages }}
end
emit(out)"#
		),
	);
	let macro_ = "/cleartarget [nocombat]\n/targetexact Rocklance\n/cleartarget [dead]\n/ping [@target]";
	for (i, case) in out[0].as_array().unwrap().iter().enumerate() {
		assert_eq!(case["first"], true, "case {i}: the click lands on the secure overlay where the card's Target button shows");
		assert_eq!(case["moved"], true, "case {i}: and still after the card moved");
		assert_eq!(case["ran"], json!([["macro", macro_]]), "case {i}: one click runs the macro once");
		assert_eq!(case["ranMoved"], json!([["macro", macro_]]), "case {i}");
	}
}

#[test]
fn rare_card_a_click_the_overlay_missed_lays_it_over_and_says_how_to_target() {
	let out = run_card(
		"SLASH_PING1 = \"/ping\"",
		&format!(
			r#"{SPOT_THUROS}
s:Hide()
s:ClearAllPoints()
local before = #stub.messages
stub.qol.mouseClick(f.Target)
emit({{ card(), stub.messages[#stub.messages] or false, #stub.messages - before }})"#
		),
	);
	assert_eq!(out[0][0]["secure"], true);
	assert_eq!(out[0][0]["over"], true);
	assert!(out[0][1].as_str().unwrap().contains("Click Target again to target the rare, or use the rare button."));
	assert_eq!(out[0][2], 1);
}

#[test]
fn rare_card_the_founder_s_card_waves_with_its_button_never_pings_or_marks() {
	let out = run_card(
		"SLASH_PING1 = \"/ping\"",
		r#"
Polestar.Set("qol.markTarget", true)
Polestar.Fire("RARE_SPOTTED", { kind = "founder", name = "Fitz Polestar", zone = "Elwynn Forest", button = true })
local f, s = PolestarRareToast, PolestarRareCardTarget
emit({ f.Target:IsShown(), f.Target.Label:GetText(), s:IsShown(), s:GetAttribute("macrotext") })"#,
	);
	assert_eq!(out[0], json!([true, "Wave", true, "/cleartarget [nocombat]\n/targetexact Fitz Polestar\n/targetexact [noexists] Fitz\n/wave"]));
}

#[test]
fn rare_card_the_founder_s_card_shows_his_crest_alone_and_bigger_other_cards_their_tinted_glyph_in_the_ring() {
	let out = run_card(
		"",
		r#"
Polestar.Codex.Load()
-- The card is built on its first alert, so look it up each time.
local function glyph()
	local f = PolestarRareToast
	local r, g, b, a = f.Glyph:GetVertexColor()
	local tr, tg, tb = Polestar.Theme.Color(R.ColorName("rare"))
	local w, h = f.Glyph:GetSize()
	local _, rel, _, x = f.Name:GetPoint(1)
	return { f.Glyph:GetTexture(), r == 1 and g == 1 and b == 1 and a == 1, r == tr and g == tg and b == tb,
		w, h, f.Ring:IsShown() and true or false, rel == f.Ring and x }
end
Polestar.Fire("RARE_SPOTTED", { kind = "founder", name = "Fitz Polestar", zone = "Elwynn Forest", button = true })
emit(glyph())
-- A rare after him: its own glyph, tinted again.
Polestar.Fire("RARE_SPOTTED", R.AlertOf({ source = "nameplate", kind = "rare", id = 61, name = "Thuros Lightfingers" }, { map = 1429, x = 88, y = 78 }, true))
emit(glyph())
Polestar.Fire("RARE_SPOTTED", { kind = "founder", name = "Fitz Polestar", zone = "Elwynn Forest", button = true })
-- A theme repaint leaves his emblem untinted.
Polestar.Theme.Refresh()
emit(glyph())"#,
	);
	let media = |name: &str| format!("Interface\\AddOns\\Polestar\\Media\\UI\\{name}");
	assert_eq!(out[0], json!([media("founder-emblem"), true, false, 40, 40, false, 12]), "the founder: his crest alone, 40 px, untinted, the text still off the ring's slot");
	assert_eq!(out[1], json!([media("qol-target"), false, true, 16, 16, true, 12]), "a rare: the crosshair in the ring, in the rare colour");
	assert_eq!(out[2], json!([media("founder-emblem"), true, false, 40, 40, false, 12]), "still untinted after a theme change");
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
	for i, p in ipairs(pins) do out[i] = { p.id, p.map, p.x, p.f or false, p.icon, p.ring and true or false, p.ring2 and true or false, p.glow or false, p.priority } end
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
			[1, 1429, 10, false, "map:rare", false, false, false, 2],
			[2, 1429, 20, "e", "map:rare", false, false, false, 2],
			[2, 1429, 40, false, "map:rare", false, false, false, 2],
			[2, 1436, 20, false, "map:rare", false, false, false, 2],
			[3, 1429, 50, false, "map:rare", false, false, false, 2],
			[4, 1429, 60, false, "map:rare", true, false, false, 3],
			[6, 1429, 70, false, "map:rare", false, true, false, 4],
		])
	);
	let grey: Vec<Value> = out["grey"].as_array().unwrap().iter().map(|p| p[0].clone()).collect();
	assert_eq!(json!(grey), json!([2, 2, 2, 3, 4, 6]), "level 3 is grey at 20 (grey up to 13)");
	assert_eq!(out["greyLevel"], json!([0, 13, 35, 51]));
	assert_eq!(out["treasure"], json!(["map:treasure", "treasure", "treasure:2843", 13]));
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

// ------------------------------------------------------------ the founder

#[test]
fn decide_founder_every_reason_it_stays_quiet_and_the_day() {
	let out = run(r#"
local function d(over, extra)
	local cfg = { enabled = true, founder = true }
	for k, v in pairs(over or {}) do cfg[k] = v end
	local c = { get = function(k) return cfg[k] end, now = 5000, inCombat = false, inInstance = false, self = false, present = false }
	for k, v in pairs(extra or {}) do c[k] = v end
	local a, r = R.DecideFounder(c)
	return { a, r }
end
emit({
	alert = d(),
	off = d({ founder = false }),
	raresOff = d({ enabled = false }),
	self = d(nil, { self = true }),
	instance = d(nil, { inInstance = true }),
	combat = d(nil, { inCombat = true }),
	stillHere = d(nil, { alerted = 5000 - 40 * 60, present = true }),
	cooldown = d(nil, { alerted = 5000 - 29 * 60 }),
	sessionDay = d(nil, { now = 90000, alerted = 90000 - 23 * 3600 }),
	again = d(nil, { now = 90000, alerted = 90000 - 25 * 3600 }),
	savedDay = d(nil, { last = 1e9 - 23 * 3600, time = 1e9 }),
	savedAgain = d(nil, { last = 1e9 - 24 * 3600, time = 1e9 }),
	savedFuture = d(nil, { last = 1e9 + 3600, time = 1e9 }),
	noTime = d(nil, { last = 1e9 }),
	name = R.FOUNDER,
	is = { R.IsFounder("Fitz Polestar"), R.IsFounder("Fitz Polestar-CAMWOW EU5 Realm 8 PvP"), R.IsFounder("Fitz Poletsar"),
		R.IsFounder("Fitz"), R.IsFounder("fitz polestar"), R.IsFounder("Fitz Polestar Jr"), R.IsFounder(nil) },
})"#);
	let out = &out[0];
	assert_eq!(out["alert"], json!(["alert"]));
	assert_eq!(out["off"], json!(["skip", "off"]));
	assert_eq!(out["raresOff"], json!(["skip", "off"]));
	assert_eq!(out["self"], json!(["skip", "self"]));
	assert_eq!(out["instance"], json!(["skip", "instance"]));
	assert_eq!(out["combat"], json!(["skip", "combat"]));
	assert_eq!(out["stillHere"], json!(["skip", "stillHere"]), "he never left");
	assert_eq!(out["cooldown"], json!(["skip", "cooldown"]));
	assert_eq!(out["sessionDay"], json!(["skip", "cooldown"]), "this session's alert, 23 h ago");
	assert_eq!(out["again"], json!(["alert"]));
	assert_eq!(out["savedDay"], json!(["skip", "cooldown"]), "the account's saved alert, 23 h ago");
	assert_eq!(out["savedAgain"], json!(["alert"]), "a day after the saved alert");
	assert_eq!(out["savedFuture"], json!(["alert"]), "a saved time in the future holds nothing");
	assert_eq!(out["noTime"], json!(["alert"]));
	assert_eq!(out["name"], "Fitz Polestar");
	assert_eq!(out["is"], json!([true, true, false, false, false, false, false]));
}

/// The observer is a Forever character (a surname); `scene` runs after it, with `fitz(token, o)` showing a player
/// named Fitz Polestar (o: guid, faction, name, surname) and `founders()` the founder alerts so far.
fn founder_run(scene: &str) -> Vec<Value> {
	founder_run_saved(scene, None)
}

/// `founder_run` after a /reload or relog into `saved` (PolestarDB Lua).
fn founder_run_saved(scene: &str, saved: Option<String>) -> Vec<Value> {
	run_saved(
		&format!(
			r#"local U = stub.rares
U.me = {{ "Ana", "Smith" }}
local function fitz(token, o)
	o = o or {{}}
	U.unit(token, {{ guid = o.guid or "Player-1-0000F175", name = o.name or "Fitz", surname = o.surname == nil and "Polestar" or o.surname or nil,
		player = true, faction = o.faction or "Alliance", level = 13 }})
end
local function founders()
	local n = 0
	for _, a in ipairs(got) do if a.kind == "founder" then n = n + 1 end end
	return n
end
{scene}"#
		),
		[1429, 88, 78],
		saved,
	)
}

#[test]
fn founder_a_player_named_fitz_polestar_alerts_once_with_the_card_and_the_rare_button_list_near_matches_never() {
	let out = founder_run(
		r#"
-- Near matches: the other surname, the first name alone, another player.
fitz("nameplate1", { guid = "Player-1-0000AAAA", surname = "Poletsar" })
fitz("nameplate2", { guid = "Player-1-0000BBBB", surname = false })
U.unit("nameplate3", { guid = "Player-1-0000CCCC", name = "Polestar", surname = "Fitz", player = true })
for i = 1, 3 do stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate" .. i) end
emit({ n = #got, nearby = #R.Nearby() })
-- The founder, on the player's own side.
fitz("nameplate4")
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate4")
local a = got[1]
local f = PolestarRareToast
emit({ n = founders(), kind = a.kind, name = a.name, enemy = a.enemy, zone = a.zone, sounds = #stub.sounds,
	shown = f:IsShown(), title = f.Name:GetText(), facts = f.Facts:GetText(), row = f.Distance:GetText(),
	waypoint = f.Waypoint:IsShown(), open = f.Open:IsShown(), nearby = R.Nearby()[1] })
local h = 0
for _ in pairs(R.History()) do h = h + 1 end
emit({ history = h })
-- The combined form ("Fitz Polestar" in one string) is the same character.
U.clear("nameplate4")
stub.advance(120)
U.unit("target", { guid = "Player-1-0000F175", name = "Fitz Polestar", player = true, faction = "Alliance" })
emit({ nearby = #R.Nearby(), action = { R.FounderSighting("target", "target", "Player-1-0000F175") } })"#,
	);
	assert_eq!(out[0], json!({ "n": 0, "nearby": 0 }), "Fitz Poletsar, Fitz and Polestar Fitz are not him");
	assert_eq!(
		out[1],
		json!({
			"n": 1, "kind": "founder", "name": "Fitz Polestar", "enemy": false, "zone": "Elwynn Forest", "sounds": 1,
			"shown": true, "title": "The Polestar founder is nearby!", "facts": "Fitz Polestar  \u{b7}  Elwynn Forest",
			"row": "Go say hi", "waypoint": false, "open": false, "nearby": "Fitz Polestar"
		})
	);
	assert_eq!(out[2], json!({ "history": 0 }), "the founder never enters the rares history");
	assert_eq!(out[3], json!({ "nearby": 0, "action": ["skip", "cooldown"] }), "the one-string name matches too (inside the day)");
}

#[test]
fn founder_the_other_faction_gets_the_alert_with_its_own_line() {
	let out = founder_run(
		r#"
fitz("mouseover", { faction = "Horde" })
stub.fire("UPDATE_MOUSEOVER_UNIT")
emit({ n = founders(), enemy = got[1] and got[1].enemy, row = PolestarRareToast.Distance:GetText() })"#,
	);
	assert_eq!(out[0], json!({ "n": 1, "enemy": true, "row": "Other faction: wave from a safe distance" }));
}

#[test]
fn founder_once_a_day_never_while_he_stays_again_after_he_left_and_the_day_is_up() {
	let out = founder_run(
		r#"
fitz("nameplate1")
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
emit({ founders(), type(PolestarDB.rares.founderAt) == "number" and PolestarDB.rares.founderAt == time() })
-- Still in range, seen by other paths: no second alert.
stub.advance(4)
fitz("target")
stub.fire("PLAYER_TARGET_CHANGED")
emit(founders())
-- 31 minutes with his nameplate up the whole time: he never left.
U.clear("target")
stub.advance(31 * 60)
fitz("mouseover")
stub.fire("UPDATE_MOUSEOVER_UNIT")
emit({ founders(), R.Nearby()[1] })
-- He leaves: off the list within a minute. Back after that, inside the day: quiet.
U.clear("nameplate1")
U.clear("mouseover")
stub.advance(120)
emit(#R.Nearby())
fitz("nameplate2")
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate2")
emit(founders())
-- Leaves, back more than a day after the alert: due again.
U.clear("nameplate2")
stub.advance(24 * 3600)
fitz("nameplate3")
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate3")
emit(founders())
-- Leaves again and comes back ten minutes later: inside the new day.
U.clear("nameplate3")
stub.advance(10 * 60)
fitz("nameplate4")
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate4")
emit(founders())"#,
	);
	assert_eq!(out[0], json!([1, true]), "alerted once, the time saved account-wide");
	assert_eq!(out[1], 1, "seen again while in range");
	assert_eq!(out[2], json!([1, "Fitz Polestar"]), "half an hour passed, but he stayed in range");
	assert_eq!(out[3], 0, "out of sight: off the rare button");
	assert_eq!(out[4], 1, "left and came back inside the day");
	assert_eq!(out[5], 2, "back after the day");
	assert_eq!(out[6], 2, "back inside the new day");
}

#[test]
fn founder_a_reload_or_relog_keeps_the_day() {
	let saved = |ago: i64| Some(format!("PolestarDB = {{ schema = 1, rares = {{ founderAt = time() - {ago} }} }}"));
	let scene = r#"
fitz("target")
stub.fire("PLAYER_TARGET_CHANGED")
emit(founders())"#;
	// Alerted an hour before the /reload: this new session stays quiet.
	assert_eq!(founder_run_saved(scene, saved(3600))[0], 0, "a /reload inside the day");
	assert_eq!(founder_run_saved(scene, saved(23 * 3600 + 59 * 60))[0], 0, "a relog a minute short of the day");
	// A day or more since: alerts, and saves the new time.
	let after = founder_run_saved(&format!("{scene}\nemit(PolestarDB.rares.founderAt == time())"), saved(24 * 3600 + 60));
	assert_eq!(after, vec![json!(1), json!(true)], "a day after the saved alert");
	// Due again, but still never in an instance or in combat.
	let instance = founder_run_saved(&format!("stub.world.inInstance = true\n{scene}"), saved(2 * 24 * 3600));
	assert_eq!(instance[0], 0, "due, but inside an instance");
	let combat = founder_run_saved(&format!("stub.inCombat = true\n{scene}"), saved(2 * 24 * 3600));
	assert_eq!(combat[0], 0, "due, but in combat");
}

#[test]
fn founder_never_on_his_own_client_in_an_instance_in_combat_or_with_the_option_off() {
	let quiet = |setup: &str, after: &str| -> Vec<Value> {
		founder_run(&format!(
			r#"{setup}
fitz("target")
stub.fire("PLAYER_TARGET_CHANGED")
emit({{ n = founders(), nearby = #R.Nearby() }})
{after}"#
		))
	};
	let own = quiet(r#"U.me = { "Fitz", "Polestar" }"#, "");
	assert_eq!(own[0], json!({ "n": 0, "nearby": 0 }), "his own client");
	let instance = quiet("stub.world.inInstance = true", "");
	assert_eq!(instance[0], json!({ "n": 0, "nearby": 0 }), "inside an instance, battleground or arena");
	let off = quiet(r#"Polestar.Set("rares.founder", false)"#, "");
	assert_eq!(off[0], json!({ "n": 0, "nearby": 0 }), "the option off");
	// Combat: nothing then; a later sighting after the fight still alerts (combat used up nothing).
	let combat = quiet(
		"stub.inCombat = true",
		r#"stub.inCombat = false
stub.advance(4)
stub.fire("PLAYER_TARGET_CHANGED")
emit({ n = founders() })"#,
	);
	assert_eq!(combat[0], json!({ "n": 0, "nearby": 0 }), "in combat");
	assert_eq!(combat[1], json!({ "n": 1 }));
	// Turning the option off takes him off the rare button at once.
	let later = founder_run(
		r#"
fitz("target")
stub.fire("PLAYER_TARGET_CHANGED")
local before = #R.Nearby()
Polestar.Set("rares.founder", false)
emit({ before, #R.Nearby() })"#,
	);
	assert_eq!(later[0], json!([1, 0]));
}
