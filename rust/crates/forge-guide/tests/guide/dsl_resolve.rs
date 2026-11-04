//! The resolver (resolve.rs): what the compiler fills in from reference data, per docs/GUIDE_FORMAT.md
//! "What the compiler fills in". Fixture data: tests/fixtures/dsl/data (Elwynn Forest, uiMapID 1429).

use crate::common;
use common::*;
use forge_guide::data::Data;
use forge_guide::js::V;
use serde_json::{json, Map, Value};

fn goals_of(lines: &[&str]) -> (Vec<Value>, Compiled) {
	let r = compile(&guide_text(lines));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = r.steps().iter().flat_map(|s| s["goals"].as_array().cloned().unwrap_or_default()).collect();
	(g, r)
}

fn get(g: &Value, k: &str) -> Value {
	g.get(k).cloned().unwrap_or(Value::Null)
}

/// Spawns of an npc or object on Elwynn (1429) that lie outside every spot of `goal`, in yards through the
/// map's Era frame.
fn outside_spots(goal: &Value, kind: &str, id: u32) -> Vec<(f64, f64)> {
	let data = fixture_data();
	let fr = data.era_frame(&V::from(1429));
	let sx = (fr.get("right").num() - fr.get("left").num()).abs() / 100.0;
	let sy = (fr.get("bottom").num() - fr.get("top").num()).abs() / 100.0;
	let s = data.spawns(kind, &V::from(id)).into_iter().find(|sp| sp.get("map").num() == 1429.0).unwrap();
	let pts: Vec<(f64, f64)> = s.get("pts").items().iter().chain(s.get("more").items().iter()).map(|p| (p.at(0).num(), p.at(1).num())).collect();
	let spots = goal.get("spots").and_then(Value::as_array).cloned().unwrap_or_default();
	pts.into_iter().filter(|(x, y)| !spots.iter().any(|s| ((x - s["x"].as_f64().unwrap()) * sx).hypot((y - s["y"].as_f64().unwrap()) * sy) <= s["r"].as_f64().unwrap())).collect()
}

#[test]
fn quest_titles_quest_givers_and_their_positions_come_from_data_era_sourced_points_carry_f_e() {
	let (g, _) = goals_of(&["step One", "  accept 783", "  turnin 783", "  accept 7 \"My Own Title\""]);
	assert_eq!(
		g[0],
		json!({ "t": "accept", "quest": 783, "title": "A Threat Within", "npc": 823, "npcName": "Deputy Willem", "minLevel": 1, "qlvl": 1, "map": 1429, "x": 48.17, "y": 42.94, "f": "e" })
	);
	assert_eq!(g[1], json!({ "t": "turnin", "quest": 783, "title": "A Threat Within", "npc": 197, "npcName": "Marshal McBride", "map": 1429, "x": 48.92, "y": 41.61, "f": "e" }));
	assert_eq!(g[2]["title"], "My Own Title", "explicit title wins over data");
}

#[test]
fn the_spawn_nearest_the_previous_goal_on_the_same_map_is_chosen_measured_in_yards() {
	// From 47.6,35.1 the nearest Kobold Vermin in map percent is 47.6,31.2, but Elwynn is wider than tall: in
	// yards 49.0,32.4 is closer.
	let a = goals_of(&["step One", "  goto 47.6,35.1", "  kill 6"]).0;
	assert_eq!(json!([a[1]["x"], a[1]["y"], a[1]["f"]]), json!([49, 32.4, "e"]));
	let b = goals_of(&["step One", "  goto 52,27", "  kill 6"]).0;
	assert_eq!(json!([b[1]["x"], b[1]["y"]]), json!([52.3, 26.8]));
	// The previous goal can be in an earlier step.
	let c = goals_of(&["step One", "  goto 45,34", "step Two", "  kill 6"]).0;
	assert_eq!(json!([c[1]["x"], c[1]["y"]]), json!([45.1, 33.9]));
}

#[test]
fn among_several_quest_enders_the_one_nearest_the_previous_goal_wins_npc_picks_one_explicitly() {
	let n197 = goals_of(&["step One", "  accept 5261", "  goto 48.9,41.7", "  turnin 5261"]).0[2].clone();
	assert_eq!(json!([n197["npc"], n197["npcName"]]), json!([197, "Marshal McBride"]));
	let n196 = goals_of(&["step One", "  accept 5261", "  goto 48.9,40.0", "  turnin 5261"]).0[2].clone();
	assert_eq!(json!([n196["npc"], n196["npcName"]]), json!([196, "Eagan Peltskinner"]));
	let ex = goals_of(&["step One", "  accept 5261", "  goto 48.9,40.0", "  turnin 5261 npc 197"]).0[2].clone();
	assert_eq!(json!([ex["npc"], ex["x"], ex["y"]]), json!([197, 48.92, 41.61]));
}

#[test]
fn without_previous_coordinates_the_spawn_centroid_in_the_current_zone_is_used() {
	let e = goals_of(&["step One", "  kill 1423"]).0[0].clone();
	assert_eq!(json!([e["map"], e["x"], e["y"]]), json!([1429, 50, 60]));
	let c = goals_of(&["step One", "  zone Stormwind City", "  kill 1423"]).0[0].clone();
	assert_eq!(json!([c["map"], c["x"], c["y"], c["f"]]), json!([1453, 60, 70, "e"]));
}

#[test]
fn collect_positions_at_the_item_drop_sources_preferring_the_current_zone_then_nearness_then_drop_chance() {
	// Both droppers' spawns make the spawn areas: a pack of two and the lone one; nearest to the point first.
	// The dominant source (50% or more) is named; `fromNpcs` names both droppers, the point's own first.
	let pack = json!({ "x": 45.5, "y": 39, "r": 30, "n": 2 });
	let lone = json!({ "x": 44, "y": 45, "r": 15, "n": 1 });
	let timber = json!({ "npc": 69, "npcName": "Timber Wolf" });
	let young = json!({ "npc": 299, "npcName": "Diseased Young Wolf" });
	let alone = goals_of(&["step One", "  collect 750 x4"]).0[0].clone();
	assert_eq!(
		alone,
		json!({ "t": "collect", "item": 750, "itemName": "Tough Wolf Meat", "from": "Timber Wolf", "fromId": 69, "fromKind": "npc", "fromFaction": "A", "count": 4, "map": 1429, "x": 44.5, "y": 42.5, "f": "e", "spots": [lone, pack], "fromNpcs": [timber, young] })
	);
	// After meeting Eagan (48.94,40.17) the nearest spawn of any source wins: a Young Wolf at 46,38.
	let linked = goals_of(&["step One", "  accept 33", "  collect 750 quest 33"]).0[1].clone();
	assert_eq!(
		linked,
		json!({ "t": "collect", "quest": 33, "title": "Wolves Across the Border", "item": 750, "itemName": "Tough Wolf Meat", "from": "Timber Wolf", "fromId": 69, "fromKind": "npc", "fromFaction": "A", "count": 8, "oi": 1, "map": 1429, "x": 46, "y": 38, "f": "e", "spots": [pack, lone], "fromNpcs": [young, timber] })
	);
}

#[test]
fn a_collect_names_the_sources_its_point_and_spawn_areas_belong_to_the_points_own_first() {
	let timber = json!({ "npc": 69, "npcName": "Timber Wolf" });
	let young = json!({ "npc": 299, "npcName": "Diseased Young Wolf" });
	let from = |lines: &[&str], i: usize| goals_of(lines).0[i].get("fromNpcs").cloned().unwrap_or(Value::Null);
	assert_eq!(from(&["step One", "  collect 750 x4"], 0), json!([timber, young]));
	// The point's own source comes first, whatever its drop chance.
	assert_eq!(from(&["step One", "  accept 33", "  collect 750 quest 33"], 1), json!([young, timber]));
	// Hand-placed coordinates name the sources standing by the point, the one it belongs to first.
	assert_eq!(from(&["step One", "  collect 750 x4 @45.5,39"], 0), json!([timber, young]));
	assert_eq!(from(&["step One", "  collect 750 x4 @46,38"], 0), json!([young, timber]));
	// A source that spawns nowhere near the point is not one of its mobs.
	assert_eq!(from(&["step One", "  collect 750 x4 @43,50"], 0), json!([timber]));
	// Only a `collect` carries them: a kill goal already names its target.
	assert_eq!(from(&["step One", "  kill 6"], 0), Value::Null);
}

#[test]
fn a_collect_whose_item_nothing_drops_names_the_npc_who_hands_it_over() {
	// Dillinger's Report: no droppers, a quest item, Brother Danil its "vendor": he hands it over.
	let handed = goals_of(&["step One", "  accept 99141", "  collect 286200 quest 99141.1 @48,42"]).0[1].clone();
	assert_eq!(handed["fromNpcs"], json!([{ "npc": 152, "npcName": "Brother Danil" }]));
	assert!(handed.get("npc").is_none(), "a hand-over NPC is named, never placed");
	// `npc <id>` names one outright; nothing else is then named.
	let named = goals_of(&["step One", "  accept 99141", "  collect 286200 quest 99141.1 npc 295 @48,42"]).0[1].clone();
	assert_eq!(named["npc"], 295);
	assert_eq!(named["npcName"], "Innkeeper Farley");
	assert!(named.get("fromNpcs").is_none(), "the named NPC stands alone");
	// A trade good a vendor happens to stock is no hand-over.
	assert!(goals_of(&["step One", "  collect 159 x2 @48,42"]).0[0].get("fromNpcs").is_none());
	// An item with droppers is untouched.
	assert_eq!(goals_of(&["step One", "  collect 750 x4"]).0[0]["fromNpcs"], json!([{ "npc": 69, "npcName": "Timber Wolf" }, { "npc": 299, "npcName": "Diseased Young Wolf" }]));
}

#[test]
fn a_second_source_dropping_the_item_at_50_percent_or_more_is_named_beside_the_first_both_carry_their_ids() {
	// Fractured Canine: Timber Wolf 70%, Diseased Young Wolf (299) 60%.
	let g = goals_of(&["step One", "  collect 3299 x2"]).0[0].clone();
	assert_eq!(json!([g["from"], g["fromId"], g["fromAlso"], g["fromAlsoId"], g["fromKind"]]), json!(["Timber Wolf", 69, "Diseased Young Wolf", 299, "npc"]));
	assert!(goals_of(&["step One", "  collect 750 x4"]).0[0].get("fromAlso").is_none());
}

fn camp(x: f64, y: f64) -> Value {
	json!([[x, y], [x + 0.3, y + 0.2], [x - 0.2, y + 0.3]])
}

fn item(id: u32, name: &str, npc: Value) -> Value {
	json!({ "id": id, "name": name, "drops": { "npc": npc, "object": {} }, "vendors": [] })
}

/// The fixture's core tables, edited.
fn core_with(edit: impl FnOnce(&mut Map<String, Value>)) -> Map<String, Value> {
	let mut t: Map<String, Value> = tables().into_iter().filter(|(k, _)| ["quests", "npcs", "objects", "items", "zones", "map-frames", "meta"].contains(&k.as_str())).collect();
	edit(&mut t);
	t
}

/// An orc camp on Elwynn: elite Blackrock Sentries (rank 1) at 30,30 and normal Blackrock Grunts at 70,70, one
/// Grunt among the Sentries. 95110 drops from the Sentry at 100% and the Grunt at 37%, 95111 from both at 50%,
/// 95112 only from the Sentry.
fn elite_camp(t: &mut Map<String, Value>) {
	let mut grunt = camp(70.0, 70.0);
	grunt.as_array_mut().unwrap().push(json!([30.4, 29.8]));
	t.get_mut("npcs").unwrap()["95050"] = json!({ "id": 95050, "name": "Blackrock Sentry", "level": 25, "rank": 1, "faction": null, "spawns": { "1429": { "f": "e", "pts": camp(30.0, 30.0) } } });
	t.get_mut("npcs").unwrap()["95051"] = json!({ "id": 95051, "name": "Blackrock Grunt", "level": 24, "faction": null, "spawns": { "1429": { "f": "e", "pts": grunt } } });
	let items = t.get_mut("items").unwrap();
	items["95110"] = item(95110, "Orc Skull", json!({ "95050": 100, "95051": 37 }));
	items["95111"] = item(95111, "Orc Axe", json!({ "95050": 50, "95051": 50 }));
	items["95112"] = item(95112, "Sentry Badge", json!({ "95050": 100 }));
}

fn last_goal(data: &Data, lines: &[&str]) -> Value {
	let mut l = vec!["step One"];
	l.extend_from_slice(lines);
	let r = compile_with(&guide_text(&l), data);
	assert!(r.errors.is_empty(), "{}", r.text);
	r.steps()[0]["goals"].as_array().unwrap().last().unwrap().clone()
}

fn near(s: &Value, x: f64, y: f64) -> bool {
	(s["x"].as_f64().unwrap() - x).abs() < 2.0 && (s["y"].as_f64().unwrap() - y).abs() < 2.0
}

fn spot_list(g: &Value) -> Vec<Value> {
	g.get("spots").and_then(Value::as_array).cloned().unwrap_or_default()
}

fn arrow(g: &Value) -> Vec<Value> {
	spot_list(g).into_iter().filter(|s| s.get("alt").is_none()).collect()
}

fn alts_n(g: &Value) -> Vec<Value> {
	spot_list(g).into_iter().filter(|s| s.get("alt").is_some()).map(|s| s["n"].clone()).collect()
}

#[test]
fn a_collect_that_normal_mobs_drop_leads_to_them_not_into_the_camp_of_elites_that_drop_it_too() {
	let data = data_from(&core_with(elite_camp), Value::Null, Value::Null);
	// The Sentry's 100% would leave out the Grunt's 37%: the Grunts are still where to farm it.
	let skull = last_goal(&data, &["  collect 95110 x5"]);
	assert!(!near(&skull, 30.0, 30.0), "the point is not at the Sentries: {skull}");
	assert!(!arrow(&skull).is_empty() && arrow(&skull).iter().all(|s| near(s, 70.0, 70.0)), "{skull}");
	assert_eq!(alts_n(&skull), [json!(1)]);
	// Equal chances, coming from the Sentries' camp: the point leaves it for the Grunts' camp.
	let axe = last_goal(&data, &["  goto 30,31", "  collect 95111 x10"]);
	assert!(near(&axe, 70.0, 70.0), "{axe}");
	assert!(arrow(&axe).iter().all(|s| near(s, 70.0, 70.0)), "{axe}");
	assert_eq!(alts_n(&axe), [json!(1)]);
	// The goal line names the Grunts it leads to, not the elites.
	assert_eq!(json!([get(&axe, "from"), get(&axe, "fromAlso"), get(&axe, "fromRank")]), json!(["Blackrock Grunt", null, null]));
	assert!(skull.get("from").is_none(), "the Grunt drops it at 37%: nothing to name");
	// Hand-placed at the Grunts: the Sentries' spawns make no alternative.
	assert_eq!(alts_n(&last_goal(&data, &["  collect 95111 x10 @70,70"])), [json!(1)]);
	// An item only the elites drop still leads to them.
	let badge = last_goal(&data, &["  collect 95112 x1 optional"]);
	assert!(near(&badge, 30.0, 30.0), "{badge}");
	assert!(spot_list(&badge).iter().all(|s| near(s, 30.0, 30.0)), "{badge}");
	assert_eq!(json!([badge["from"], badge["fromRank"]]), json!(["Blackrock Sentry", 1]));
}

#[test]
fn a_collect_that_common_mobs_drop_leads_to_them_not_to_the_rare_beside_them_that_drops_it_at_a_higher_chance() {
	// A rare (rank 4) Blackrock Stalker at 50,50 beside the camp: 95113 from the Stalker at 80% and the Grunt
	// at 65%, 95114 only from the Stalker, 95115 from the Stalker at 80% and the Grunt at 0.5%.
	let t = core_with(|t| {
		elite_camp(t);
		t.get_mut("npcs").unwrap()["95052"] = json!({ "id": 95052, "name": "Blackrock Stalker", "level": 25, "rank": 4, "faction": null, "spawns": { "1429": { "f": "e", "pts": camp(50.0, 50.0) } } });
		let items = t.get_mut("items").unwrap();
		items["95113"] = item(95113, "Orc Pike", json!({ "95052": 80, "95051": 65 }));
		items["95114"] = item(95114, "Stalker Fang", json!({ "95052": 80 }));
		items["95115"] = item(95115, "Orc Rivet", json!({ "95052": 80, "95051": 0.5 }));
	});
	let data = data_from(&t, Value::Null, Value::Null);
	let pike = last_goal(&data, &["  goto 50,51", "  collect 95113 x5"]);
	assert!(near(&pike, 70.0, 70.0), "{pike}");
	assert!(!spot_list(&pike).is_empty() && spot_list(&pike).iter().all(|s| !near(s, 50.0, 50.0)), "{pike}");
	assert_eq!(json!([get(&pike, "from"), get(&pike, "fromAlso"), get(&pike, "fromRank")]), json!(["Blackrock Grunt", null, null]));
	let fang = last_goal(&data, &["  collect 95114 x1 optional"]);
	assert!(near(&fang, 50.0, 50.0), "{fang}");
	assert_eq!(json!([fang["from"], fang["fromRank"]]), json!(["Blackrock Stalker", 4]));
	// A common dropper under 1% does not count: the rare stays the source.
	let rivet = last_goal(&data, &["  collect 95115 x1 optional"]);
	assert!(near(&rivet, 50.0, 50.0), "{rivet}");
	assert_eq!(rivet["from"], "Blackrock Stalker");
}

#[test]
fn a_quest_collect_leads_to_the_droppers_near_the_quests_level_not_to_ones_3_or_more_levels_above_that_drop_it_at_more_than_twice_their_chance() {
	// Two groves: level 5 Grove Saplings at 70,70 and level 10 Grove Elders at 30,30. 95116 drops from the Elder
	// at 100% and the Sapling at 37%, 95117 from the Elder at 40% and the Sapling at 37%; quests 95300 and
	// 95301 (level 7) ask for them.
	let t = core_with(|t| {
		t.get_mut("npcs").unwrap()["95060"] = json!({ "id": 95060, "name": "Grove Elder", "level": 10, "levelMax": 11, "faction": null, "spawns": { "1429": { "f": "e", "pts": camp(30.0, 30.0) } } });
		t.get_mut("npcs").unwrap()["95061"] = json!({ "id": 95061, "name": "Grove Sapling", "level": 5, "levelMax": 6, "faction": null, "spawns": { "1429": { "f": "e", "pts": camp(70.0, 70.0) } } });
		let mut seed = item(95116, "Grove Seed", json!({ "95060": 100, "95061": 37 }));
		seed["questItem"] = json!(true);
		let mut bark = item(95117, "Grove Bark", json!({ "95060": 40, "95061": 37 }));
		bark["questItem"] = json!(true);
		t.get_mut("items").unwrap()["95116"] = seed;
		t.get_mut("items").unwrap()["95117"] = bark;
		let base = t["quests"]["33"].clone();
		for (id, title, it, name) in [(95300, "Grove Seeds", 95116, "Grove Seed"), (95301, "Grove Bark", 95117, "Grove Bark")] {
			let mut q = base.clone();
			q["id"] = json!(id);
			q["title"] = json!(title);
			q["level"] = json!(7);
			q["minLevel"] = json!(4);
			q["objectives"] = json!([{ "count": 8, "id": it, "text": name, "type": "item" }]);
			t.get_mut("quests").unwrap()[id.to_string()] = q;
		}
	});
	let data = data_from(&t, Value::Null, Value::Null);
	let seed = last_goal(&data, &["  accept 95300", "  collect 95116 quest 95300"]);
	assert!(near(&seed, 70.0, 70.0), "{seed}");
	assert!(spot_list(&seed).iter().all(|s| near(s, 70.0, 70.0)), "{seed}");
	assert_eq!(seed["fromNpcs"], json!([{ "npc": 95061, "npcName": "Grove Sapling" }]));
	assert!(seed.get("from").is_none(), "the Sapling drops it at 37%: nothing to name");
	// Without a quest there is no level to go by: the Elder's 100% leads, as before.
	let loose = last_goal(&data, &["  collect 95116 x8"]);
	assert!(near(&loose, 30.0, 30.0), "{loose}");
	assert_eq!(loose["from"], "Grove Elder");
	// An Elder that crowds nobody out stays a source: 40% and 37% are both likely.
	let bark = last_goal(&data, &["  accept 95301", "  collect 95117 quest 95301"]);
	let mut ids: Vec<u64> = bark["fromNpcs"].as_array().unwrap().iter().map(|n| n["npc"].as_u64().unwrap()).collect();
	ids.sort();
	assert_eq!(ids, [95060, 95061]);
}

#[test]
fn kill_goals_carry_the_spawn_areas_of_their_mob_nearest_to_the_chosen_point_first_every_other_place_as_an_alternative_single_spawns_get_none() {
	let (g, _) = goals_of(&["step One", "  goto 41,71", "  kill 95021", "  goto 44,70", "  kill 95021", "  kill 823"]);
	let west = json!({ "x": 40, "y": 70.2, "r": 15, "n": 3 });
	let east = json!({ "x": 44.1, "y": 70, "r": 15, "n": 3 });
	let lone = json!({ "x": 42, "y": 74, "r": 15, "n": 1, "alt": true });
	assert_eq!(json!([g[1]["x"], g[1]["y"], g[1]["spots"], get(&g[1], "spread")]), json!([40.3, 70.3, [west, east, lone], null]), "from the west camp: west first");
	assert_eq!(json!([g[3]["x"], g[3]["y"], g[3]["spots"]]), json!([44, 70, [east, west, lone]]), "from the east camp: east first");
	assert!(g[4].get("spots").is_none(), "a single-spawn npc stays a point");
}

#[test]
fn a_hand_placed_point_stays_the_spot_the_arrow_takes_the_other_places_the_data_knows_are_alternatives() {
	let (g, _) = goals_of(&["step One", "  kill 95021 @40,70", "  kill 95023 @20,20"]);
	assert_eq!(g[0]["spots"][0], json!({ "x": 40, "y": 70, "r": 20, "n": 3 }), "the author point, wide enough for the camp it stands in");
	assert_eq!(g[0]["spots"].as_array().unwrap()[1..], [json!({ "x": 42, "y": 74, "r": 15, "n": 1, "alt": true }), json!({ "x": 44.1, "y": 70, "r": 15, "n": 3, "alt": true })]);
	assert!(outside_spots(&g[0], "npc", 95021).is_empty());
	// Baron Testshore at 20,20: more than a thousand yards from every known spawn.
	assert!(g[1].get("spots").is_none());
}

#[test]
fn a_hand_placed_collect_whose_droppers_all_have_unknown_odds_lists_the_other_places_of_the_droppers_at_its_point() {
	let t = core_with(|t| {
		t.get_mut("items").unwrap()["95130"] = json!({ "id": 95130, "name": "Gnoll Note", "drops": { "npc": { "95021": null, "95023": null }, "object": {} }, "vendors": [] });
	});
	let data = data_from(&t, Value::Null, Value::Null);
	let pinned = last_goal(&data, &["  collect 95130 x3 @40,70"]);
	assert_eq!(spot_list(&pinned).iter().map(|s| json!([s["x"], s["y"], s.get("alt").is_some()])).collect::<Vec<_>>(), [json!([40, 70, false]), json!([42, 74, true]), json!([44.1, 70, true])]);
}

#[test]
fn an_npc_to_talk_to_accept_from_or_hand_in_to_that_stands_at_several_places_gets_every_one() {
	let g = goals_of(&["step One", "  talk 95023"]).0[0].clone();
	assert!(outside_spots(&g, "npc", 95023).is_empty());
	assert_eq!(spot_list(&g).len(), 2);
	assert!(spot_list(&g).iter().all(|s| s.get("alt").is_none()), "a handful of places: the arrow may take any of them");
	assert!(g.get("spread").is_none());
}

#[test]
fn a_target_with_six_spawns_or_fewer_keeps_a_spot_at_every_one() {
	let g = goals_of(&["step One", "  goto 66.5,43.5", "  kill 95023"]).0[1].clone();
	assert_eq!(json!([g["x"], g["y"]]), json!([66, 44]));
	assert!(outside_spots(&g, "npc", 95023).is_empty());
	assert_eq!(json!([g["spots"][0]["x"], g["spots"][0]["y"], spot_list(&g).len()]), json!([66, 44, 2]));
}

#[test]
fn spawn_areas_include_the_points_the_reference_data_left_out_past_its_cap() {
	let (g, _) = goals_of(&["step One", "  goto 20,60", "  kill 95024", "  kill 95024 @20.5,60"]);
	for x in [&g[1], &g[2]] {
		assert!(outside_spots(x, "npc", 95024).is_empty(), "{x}");
	}
	assert!(spot_list(&g[1]).iter().any(|s| s["x"] == 27 && s["y"] == 66), "the left-out point is a place of its own");
}

#[test]
fn object_targets_get_spawn_areas_too_interact_goals_and_collects_from_objects() {
	let (g, _) = goals_of(&["step One", "  accept 9400", "  interact 1617 quest 9400", "  collect 2449 x5"]);
	for x in [&g[1], &g[2]] {
		assert!(outside_spots(x, "object", 1617).is_empty(), "{}", x["t"]);
		let mut pts: Vec<(f64, f64)> = spot_list(x).iter().map(|s| (s["x"].as_f64().unwrap(), s["y"].as_f64().unwrap())).collect();
		pts.sort_by(|a, b| a.partial_cmp(b).unwrap());
		assert_eq!(pts, [(47.0, 32.0), (51.0, 28.0)], "{}: two crates are two places", x["t"]);
	}
}

#[test]
fn mobs_spread_over_a_wide_area_make_an_area_objective_every_cluster_lone_spawns_too_as_a_walk_from_the_chosen_point() {
	let g = goals_of(&["step One", "  goto 58,32", "  kill 95020"]).0[1].clone();
	assert_eq!(g["spread"], true);
	assert_eq!(g["spots"], json!([{ "x": 60.3, "y": 29.9, "r": 40, "n": 3 }, { "x": 30, "y": 30.4, "r": 40, "n": 3 }, { "x": 80, "y": 80, "r": 40, "n": 1 }]));
}

#[test]
fn an_area_objective_with_more_clusters_than_the_cap_searches_spots_spread_evenly_over_the_whole_area_every_other_place_is_an_alternative() {
	let g = goals_of(&["step One", "  goto 12,22", "  kill 95022"]).0[1].clone();
	assert_eq!(g["spread"], true);
	let spots = spot_list(&g);
	let searched: Vec<Value> = spots.iter().filter(|s| s.get("alt").is_none()).cloned().collect();
	assert_eq!(searched.len(), 12);
	assert_eq!(spots[..12], searched[..], "the searched spots come first");
	assert_eq!(json!([spots[0]["x"], spots[0]["y"]]), json!([10, 20]), "the walk starts at the chosen point");
	let uniq: std::collections::BTreeSet<String> = spots.iter().map(|s| format!("{},{}", s["x"], s["y"])).collect();
	assert_eq!(uniq.len(), 20, "all twenty places, each once");
	assert!(outside_spots(&g, "npc", 95022).is_empty());
	let xs: Vec<f64> = searched.iter().map(|s| s["x"].as_f64().unwrap()).collect();
	let ys: Vec<f64> = searched.iter().map(|s| s["y"].as_f64().unwrap()).collect();
	let mn = |v: &[f64]| v.iter().cloned().fold(f64::INFINITY, f64::min);
	let mx = |v: &[f64]| v.iter().cloned().fold(f64::NEG_INFINITY, f64::max);
	assert_eq!([mn(&xs), mx(&xs), mn(&ys), mx(&ys)], [10.0, 90.0, 20.0, 80.0], "the searched picks reach every edge of the area");
	for (x0, x1, y0, y1) in [(10.0, 50.0, 20.0, 50.0), (50.0, 90.0, 20.0, 50.0), (10.0, 50.0, 50.0, 80.0), (50.0, 90.0, 50.0, 80.0)] {
		assert!(xs.iter().zip(&ys).any(|(&x, &y)| x >= x0 && x <= x1 && y >= y0 && y <= y1), "a spot in {x0}-{x1}, {y0}-{y1}");
	}
}

#[test]
fn a_spawn_or_two_far_from_the_camp_that_holds_most_of_a_target_are_strays() {
	let g = goals_of(&["step One", "  goto 42,47", "  kill 95025"]).0[1].clone();
	let near_camp = |s: &Value| (s["x"].as_f64().unwrap() - 25.0).abs() < 1.5 && (s["y"].as_f64().unwrap() - 50.0).abs() < 1.5;
	assert!(near_camp(&g), "{g}");
	assert!(!arrow(&g).is_empty() && arrow(&g).iter().all(near_camp), "{g}");
	assert_eq!(
		spot_list(&g).iter().filter(|s| s.get("alt").is_some()).map(|s| json!([s["x"], s["y"], s["n"]])).collect::<Vec<_>>(),
		[json!([41, 44, 1]), json!([40, 36, 1])],
		"the strays follow, nearest first"
	);
	assert!(outside_spots(&g, "npc", 95025).is_empty());
	// Trail Raider: a camp of twelve and a trail of three spawns: a sparse stretch to search, not strays.
	let t = goals_of(&["step One", "  goto 45,22", "  kill 95026"]).0[1].clone();
	assert_eq!(json!([t["x"], t["y"], t["spread"]]), json!([47, 20, true]));
	assert_eq!(arrow(&t)[..3].iter().map(|s| json!([s["x"], s["y"]])).collect::<Vec<_>>(), [json!([47, 20]), json!([51, 20]), json!([55, 20])]);
}

#[test]
fn objective_index_and_count_come_from_the_linked_objective_explicit_values_win() {
	let (g, r) = goals_of(&["step One", "  accept 7", "  kill 6 quest 7", "  kill 6 x3 quest 7", "  accept 9400", "  interact 1617 quest 9400", "  kill 6 quest 7.1 x2"]);
	assert_eq!(json!([g[1]["oi"], g[1]["count"], g[1]["title"]]), json!([1, 10, "Kobold Camp Cleanup"]));
	assert_eq!(json!([g[2]["oi"], g[2]["count"]]), json!([1, 3]));
	assert_eq!(json!([g[4]["oi"], get(&g[4], "count"), g[4]["objName"]]), json!([1, null, "Kobold Crate"]));
	assert_eq!(json!([g[5]["oi"], g[5]["count"]]), json!([1, 2]));
	assert!(r.warned("objective").is_empty());
}

#[test]
fn a_quest_link_with_no_matching_objective_warns_and_leaves_the_index_unset() {
	let (g, r) = goals_of(&["step One", "  accept 7", "  kill 69 quest 7"]);
	assert!(g[1].get("oi").is_none());
	assert_match(&r.warnings.join("\n"), r"test\.guide:9: quest 7 has no objective for this npc");
}

#[test]
fn live_frame_recorded_spawns_carry_no_frame_flag_hand_typed_coordinates_are_era_frame_by_default() {
	let (g, _) = goals_of(&["step One", "  talk 9001", "  talk 823 @48.2,42.9"]);
	assert_eq!(g[0], json!({ "t": "talk", "npc": 9001, "npcName": "Skyborne Herald", "map": 1429, "x": 40, "y": 60 }));
	assert_eq!(g[1], json!({ "t": "talk", "npc": 823, "npcName": "Deputy Willem", "map": 1429, "x": 48.2, "y": 42.9, "f": "e" }));
}

#[test]
fn buy_without_an_npc_picks_a_vendor_of_the_item_map_modifiers_and_zone_directives_place_coordinates() {
	let (g, _) = goals_of(&["step One", "  buy 159 x5", "  goto 50,50 map 1453 \"Trade District\"", "  zone map 1411", "  note \"Durotar now\" @10,20"]);
	assert_eq!(json!([g[0]["npc"], g[0]["npcName"], g[0]["count"], g[0]["x"], g[0]["y"]]), json!([152, "Brother Danil", 5, 47.5, 41.6]));
	assert_eq!(json!([g[1]["map"], g[1]["text"]]), json!([1453, "Trade District"]));
	assert_eq!(json!([g[2]["map"], g[2]["x"], g[2]["y"]]), json!([1411, 10, 20]));
}

#[test]
fn header_fields_compile_to_the_guide_schema_with_defaults() {
	let r = compile(&guide_text(&[
		"guide t/full",
		"title Full",
		"faction Horde",
		"race Orc,Undead",
		"class !Hunter",
		"levels 3-9",
		"zone map 1411",
		"next t/other",
		"category Dungeons",
		"author Someone",
		"version 4",
		"",
		"step S",
		"  level 4",
	]));
	let mut g = plain(&r.guides[0]);
	g.as_object_mut().unwrap().remove("steps");
	assert_eq!(
		g,
		json!({ "id": "t/full", "pack": "guides", "title": "Full", "faction": "Horde", "races": ["Orc", "Scourge"], "classes": ["WARRIOR", "PALADIN", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID"], "minLevel": 3, "maxLevel": 9, "category": "Dungeons", "zone": 1411, "zoneName": "Durotar", "next": "t/other", "author": "Someone", "version": 4 })
	);
	let d = plain(&compile(&guide_text(&["step S", "  level 2"])).guides[0]);
	assert_eq!(json!([d["category"], d["author"], d["version"], d["pack"], d["zone"], d["zoneName"]]), json!(["Leveling", "Polestar", 1, "guides", 1429, "Elwynn Forest"]));
}

#[test]
fn step_titles_tips_and_only_conditions_compile_onto_the_step() {
	let r = compile(&guide_text(&["step Camp", "  tip First line.", "  tip Second line.", "  only Warrior,Dwarf", "  level 2"]));
	assert_eq!(r.steps()[0], json!({ "title": "Camp", "note": "First line.\nSecond line.", "only": { "classes": ["WARRIOR"], "races": ["Dwarf"] }, "goals": [{ "t": "level", "level": 2 }] }));
}

#[test]
fn unknown_zone_names_are_errors_at_the_zone_line() {
	assert_eq!(compile(&guide_text(&["step S", "  zone Atlantis", "  level 2"])).errors, ["test.guide:8: unknown zone \"Atlantis\" (not in zones.json; use `zone map <uiMapID>`)"]);
}
