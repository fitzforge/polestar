//! The hubs layer (`forge nav layers hubs`): parity with the JS layer (tools/lib/nav/layers/hubs.js) on the
//! nav-layers golden's synthetic spawns over the nav-grid golden's grid, and its rules on their own (ported
//! from tests/nav-hubs.test.js).

use super::golden_dir;
use forge_nav::grid::{cell_of, Grid};
use forge_nav::hubs::{build_hubs, csv_rows, guard_name, hubs_doc, role_of, Hostility, HubsIn};
use forge_nav::pack::layers::Frames;
use serde_json::{json, Value};

fn read(p: &std::path::Path) -> String {
	std::fs::read_to_string(p).unwrap_or_else(|e| panic!("{}: {e}", p.display()))
}

#[test]
fn hubs_layer_matches_the_js() {
	let g = golden_dir();
	let inp = g.join("nav-layers/hubs-in");
	let data = g.join("nav-pack/data");
	let spawns: Value = serde_json::from_str(&read(&inp.join("spawns.json"))).unwrap();
	let templates: Value = serde_json::from_str(&read(&inp.join("creature_template.json"))).unwrap();
	let factions = csv_rows(&read(&inp.join("FactionTemplate.csv")));
	let areas = csv_rows(&read(&data.join("AreaTable.csv")));
	let frames = Frames::new(&serde_json::from_str(&read(&data.join("map-frames.json"))).unwrap(), serde_json::from_str(&read(&data.join("zones.json"))).unwrap());
	let grid = Grid::open(&g.join("nav-grid/nav4"), 64).unwrap();
	let area_at = |c: u32, x: f64, y: f64| {
		let (col, row, i, j) = cell_of(x, y);
		grid.tile(c, col, row).map_or(0, |t| t.areas[((j >> 4) * 16 + (i >> 4)) as usize] as u32)
	};
	let zone_at = |c: u32, x: f64, y: f64| frames.zone_area_at(c, x, y);
	let maps = [0, 1, 2991];
	let out = build_hubs(&HubsIn { spawns: &spawns, templates: &templates, faction_templates: &factions, area_table: &areas, area_at: &area_at, zone_at: Some(&zone_at), maps: &maps }).unwrap();
	let doc = hubs_doc(&out, "1.60.0.99999", "22b51464f1625f6ef6275771de1f5466c6f5d19e", &maps);
	assert_eq!(doc, read(&g.join("nav-layers/hubs.json")));
}

fn hostility() -> Hostility {
	let head = "ID,Faction,FactionGroup,EnemyGroup,Enemies_0,Friend_0\n";
	let rows = "1,1,3,12,0,0\n3,3,3,12,0,0\n4,4,3,12,0,0\n115,115,3,12,0,0\n2,2,5,10,0,0\n5,5,5,10,0,0\n6,6,5,10,0,0\n116,116,5,10,0,0\n11,72,2,4,0,0\n85,76,4,2,0,0\n120,21,0,0,0,0\n130,80,0,0,2,0\n140,81,2,4,0,2\n";
	Hostility::new(&csv_rows(&format!("{head}{rows}"))).unwrap()
}

#[test]
fn hostility_from_group_masks_and_enemy_and_friend_factions() {
	let h = hostility();
	assert_eq!(h.of(11), Some((false, true)), "Stormwind attacks Horde players");
	assert_eq!(h.of(85), Some((true, false)));
	assert_eq!(h.of(120), Some((false, false)), "a goblin town attacks no one");
	assert_eq!(h.of(130), Some((false, true)), "an enemy faction entry");
	assert_eq!(h.of(140), Some((false, true)), "a friend entry spares that faction only, the enemy group the rest");
	assert_eq!(h.of(999), None);
	assert!(Hostility::new(&csv_rows("ID,Faction\n1,1\n")).is_err(), "the player templates are required");
}

#[test]
fn guards_by_flag_from_level_10_by_name_from_level_20_and_service_npcs_by_flags() {
	let h = hostility();
	let t = |name: &str, faction: u32, npc: u32, extra: u32, min: u32| json!({ "name": name, "faction": faction, "npcFlags": npc, "extraFlags": extra, "rank": 0, "minLevel": min });
	assert_eq!(role_of(&t("Stormwind Guard", 11, 0, 0x400, 55), &h), Some(("Alliance", true)));
	assert_eq!(role_of(&t("Kul Tiras Marine", 11, 0, 0x400, 6), &h), None, "the flag below level 10");
	assert_eq!(role_of(&t("Southshore Guard", 11, 0, 0, 25), &h), Some(("Alliance", true)));
	assert_eq!(role_of(&t("Pyrewood Watcher", 11, 0, 0, 15), &h), None, "a guard's name below level 20");
	assert_eq!(role_of(&t("Hammerfall Grunt", 85, 0, 0, 30), &h), Some(("Horde", true)));
	assert_eq!(role_of(&t("Innkeeper Gryshka", 85, 0x80, 0, 30), &h), Some(("Horde", false)));
	assert_eq!(role_of(&t("Goblin Guard", 120, 0, 0x400, 60), &h), None, "neutral");
	assert_eq!(role_of(&t("Hidden", 11, 0, 0x480, 60), &h), None, "invisible");
	assert_eq!(role_of(&t("Wanderer", 11, 0x1, 0, 30), &h), None, "no service flag");
	assert!(guard_name("Stormwind City Guard") && guard_name("Deathguard Bartholomew") && !guard_name("Guardian of Blizzard") && !guard_name("Bodyguards"));
}

/// The hubs layer built for this checkout (<repo>/data/local/nav-layers/hubs.json), when there is one.
#[test]
fn the_built_layer_alliance_and_horde_towns_are_hubs_of_their_side_goblin_towns_are_none() {
	let file = golden_dir().join("../../../data/local/nav-layers/hubs.json");
	let Ok(text) = std::fs::read_to_string(&file) else {
		eprintln!("skipped: no hubs layer (forge nav layers hubs)");
		return;
	};
	let hubs: Value = serde_json::from_str(&text).unwrap();
	let named = |c: &str, name: &str| -> Vec<Value> { hubs[c].as_array().into_iter().flatten().filter(|h| h["name"] == name).cloned().collect() };
	let disks = |h: &Value| -> Vec<(f64, f64, f64)> { h["disks"].as_array().unwrap().iter().map(|d| (d[0].as_f64().unwrap(), d[1].as_f64().unwrap(), d[2].as_f64().unwrap())).collect() };
	for (c, name, side) in [
		("0", "Southshore", "Alliance"),
		("1", "Astranaar", "Alliance"),
		("1", "Auberdine", "Alliance"),
		("1", "The Crossroads", "Horde"),
		("0", "Tarren Mill", "Horde"),
		("1", "Splintertree Post", "Horde"),
	] {
		let found = named(c, name);
		assert!(!found.is_empty(), "{name} is a hub");
		assert!(found.iter().all(|h| h["side"] == side), "{name} is {side}");
	}
	let brackenwall: Vec<&Value> = hubs["1"].as_array().unwrap().iter().filter(|h| disks(h).iter().any(|&(x, y, _)| (-3149.0 - x).hypot(-2842.0 - y) <= 100.0)).collect();
	assert!(!brackenwall.is_empty() && brackenwall.iter().all(|h| h["side"] == "Horde"), "Brackenwall Village is a Horde hub");
	for (c, name) in [("0", "Stormwind City"), ("0", "Ironforge"), ("0", "Undercity"), ("1", "Orgrimmar"), ("1", "Thunder Bluff"), ("1", "Darnassus")] {
		assert!(!named(c, name).is_empty(), "{name} is a hub");
	}
	for (c, name) in [("0", "Gates of Ironforge"), ("0", "Ruins of Lordaeron")] {
		assert!(named(c, name).is_empty(), "no hub named {name}");
	}
	for (c, name, x, y) in [("0", "Booty Bay", -14297.0, 530.0), ("1", "Ratchet", -956.0, -3754.0), ("1", "Gadgetzan", -7150.0, -3785.0), ("1", "Everlook", 6724.0, -4610.0)] {
		assert!(named(c, name).is_empty(), "{name} is no hub");
		let over: Vec<&Value> = hubs[c].as_array().unwrap().iter().filter(|h| disks(h).iter().any(|&(hx, hy, r)| (x - hx).hypot(y - hy) <= r + 100.0)).collect();
		assert!(over.is_empty(), "no hub within 100 yd of {name}");
	}
}
