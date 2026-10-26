//! Farm spots for `collect <item> xN nearest` (docs/ARCHITECTURE.md, Smart logic, Farm spots) and quest
//! prerequisite titles on accepts. Fixture: Silk Cloth (4306) drops from mobs in Elwynn, Durotar and
//! Stranglethorn, plus an elite, a mob standing in Goldshire and a 1% dropper. (The engine registry reading
//! the emitted goals is an addon test.)

use crate::common;
use common::*;
use forge_guide::farmspots::farm_spots;
use forge_guide::js::{parse_json, V};
use serde_json::json;

fn src(faction: Option<&str>, body: &[&str]) -> String {
	let mut l = vec!["guide t/f".to_string(), "title F".into()];
	if let Some(f) = faction {
		l.push(format!("faction {f}"));
	}
	l.extend(["levels 1-60", "zone Elwynn Forest", "", "step S"].map(String::from));
	l.extend(body.iter().map(|b| b.to_string()));
	format!("{}\n", l.join("\n"))
}

#[test]
fn farm_spots_clustered_droppers_with_zone_safety_level_range_rate_and_spawn_count() {
	let spots = plain(&farm_spots(&fixture_data(), &V::from(4306)));
	let list = spots.as_array().unwrap();
	let by = |n: &str| list.iter().find(|s| s["npcName"] == n).cloned();
	assert_eq!(
		by("Cloth Kobold").unwrap(),
		json!({ "map": 1429, "x": 65.4, "y": 75.3, "f": "e", "faction": "A", "npc": 95001, "npcName": "Cloth Kobold", "lvl": { "min": 5, "max": 5 }, "rate": 0.3, "spawns": 4 })
	);
	let harpy = by("Cloth Harpy").unwrap();
	assert_eq!([&harpy["faction"], &harpy["spawns"]], [&json!("H"), &json!(3)]);
	let troll = by("Cloth Troll").unwrap();
	assert_eq!([&troll["faction"], &troll["lvl"]], [&json!("AH"), &json!({ "min": 35, "max": 35 })]);
	assert_eq!(by("Lone Kobold").unwrap()["spawns"], 1);
	// Not farm spots: the elite, the rat inside Goldshire, the kobold at the guard post, Kobold Vermin at 1%.
	for name in ["Elite Kobold", "Goldshire Rat", "Guardpost Kobold", "Kobold Vermin"] {
		assert!(by(name).is_none(), "{name}");
	}
	// Per continent (Kalimdor, then Eastern Kingdoms), best rate x spawns first: the 5-spawn camp at 35% (1.75)
	// beats the 4-spawn camp at 30% (1.2).
	assert_eq!(list.iter().map(|s| s["npcName"].as_str().unwrap()).collect::<Vec<_>>(), ["Cloth Harpy", "Ancient Kobold", "Cloth Kobold", "Cloth Troll", "Lone Kobold"]);
	// Deterministic.
	assert_eq!(plain(&farm_spots(&fixture_data(), &V::from(4306))), spots);
}

#[test]
fn collect_item_xn_nearest_compiles_to_farm_spot_candidates_for_the_factions_the_goal_serves() {
	let r = compile(&src(Some("Alliance"), &["  collect 4306 x20 nearest"]));
	assert!(r.errors.is_empty() && r.warnings.is_empty(), "{}", r.text);
	let g = r.steps()[0]["goals"][0].clone();
	assert_eq!(json!([g["t"], g["item"], g["itemName"], g["count"], g.get("map"), g.get("x")]), json!(["collect", 4306, "Silk Cloth", 20, null, null]));
	// Alliance: Elwynn and contested spots, never Durotar.
	let mut f: Vec<&str> = g["candidates"].as_array().unwrap().iter().map(|c| c["faction"].as_str().unwrap()).collect();
	f.sort();
	assert_eq!(f, ["A", "A", "A", "AH"]);
	assert!(!g["candidates"].as_array().unwrap().iter().any(|c| c["npcName"] == "Cloth Harpy"));
	let both = compile(&src(None, &["  collect 4306 x20 nearest"])).steps()[0]["goals"][0].clone();
	assert!(both["candidates"].as_array().unwrap().iter().any(|c| c["faction"] == "H"));
}

#[test]
fn collect_nearest_no_spots_no_count_a_quest_link_or_coordinates_are_errors() {
	let r = compile(&src(None, &["  collect 750 x5 nearest", "  collect 4306 nearest", "  accept 33", "  collect 4306 x2 quest 33 nearest", "  collect 4306 x2 nearest @1,1"]));
	assert_eq!(
		r.errors,
		[
			"test.guide:7: `collect 750 nearest` found no farm spot (normal mobs dropping it at 2% or more, outside towns) for Alliance or Horde characters; give @x,y or a gathering step instead",
			"test.guide:8: `collect … nearest` needs a count: `collect <item> xN nearest`",
			"test.guide:10: `collect … nearest` farms by bag count; drop `quest` (quest objectives use the quest’s own targets)",
			"test.guide:11: smart targets pick their NPC and position at runtime; drop the coordinates, or name an npc id",
		]
	);
	// Tough Wolf Meat drops at 80% in Elwynn and 30% in Dun Morogh: Alliance zones only.
	let horde = compile(&src(Some("Horde"), &["  collect 750 x5 nearest"]));
	assert_eq!(
		horde.errors,
		["test.guide:8: `collect 750 nearest` found no farm spot (normal mobs dropping it at 2% or more, outside towns) for Horde characters; give @x,y or a gathering step instead"]
	);
}

#[test]
fn a_faction_with_no_safe_farm_spot_gets_a_warning_when_the_goal_serves_it() {
	let r = compile(&src(None, &["  collect 4306 x5 nearest only Alliance", "  collect 4306 x5 nearest"]));
	assert!(r.errors.is_empty() && r.warnings.is_empty(), "{}", r.text);
	// With Elwynn as the only source, a both-faction goal lacks a Horde-safe spot.
	let data = fixture_data();
	data.items.get("4306").set("drops", parse_json(r#"{"npc":{"95001":30},"object":{}}"#).unwrap());
	let w = compile_with(&src(None, &["  collect 4306 x5 nearest"]), &data);
	assert_eq!(w.warnings, ["test.guide:7: no farm spot for item 4306 that is safe for Horde, but this goal applies to Horde characters"]);
}

#[test]
fn farm_spots_and_prerequisite_titles_emit_lua_the_engine_reads() {
	let text = src(None, &["  collect 4306 x20 nearest", "  accept 9500"]).replacen("guide t/", "guide test/", 1);
	let r = compile_files(&[("test.guide", &text)], &fixture_data(), Some("test"));
	assert!(r.errors.is_empty(), "{}", r.text);
	let lua = emit(&r.guides);
	assert_match(&lua, r#"\{ npc = 95001, npcName = "Cloth Kobold", map = 1429, x = 65\.4, y = 75\.3, f = "e", faction = "A", lvl = \{ min = 5, max = 5 \}, rate = 0\.3, spawns = 4 \}"#);
	assert_match(&lua, r#"pre = \{ 9201, 783 \}, preTitles = \{ \[783\] = "A Threat Within", \[9201\] = "The First Step" \}"#);
}
