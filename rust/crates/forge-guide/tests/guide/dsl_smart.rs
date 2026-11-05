//! Smart targets: `train <Profession> [Rank]`, `train class`, `buy … nearest`, `vendor nearest`, `sethome
//! nearest` compile to candidate sets (docs/ARCHITECTURE.md "Smart logic"); `qlvl`/`pre` on accepts for the
//! engine's grey-quest skipping; a quest's profession on its goals for the engine's profession gate. (The
//! engine registry reading them, and trainers.json's build, are tested where those live.)

use crate::common;
use common::*;
use forge_guide::data::{load_data, Data};
use serde_json::{json, Map, Value};

fn head(faction: Option<&str>, extra: &[&str]) -> Vec<String> {
	let mut l = vec!["guide t/s".to_string(), "title S".into()];
	if let Some(f) = faction {
		l.push(format!("faction {f}"));
	}
	l.extend(["levels 1-60".to_string(), "zone Elwynn Forest".into()]);
	l.extend(extra.iter().map(|s| s.to_string()));
	l.push(String::new());
	l
}

fn text(head: Vec<String>, body: &[&str]) -> String {
	let mut l = head;
	l.extend(body.iter().map(|s| s.to_string()));
	format!("{}\n", l.join("\n"))
}

/// Every goal of the guide, in order (plain).
fn goals_of(r: &Compiled) -> Vec<Value> {
	if r.guides.is_empty() {
		return Vec::new();
	}
	r.steps().iter().flat_map(|s| s["goals"].as_array().cloned().unwrap_or_default()).collect()
}

fn goals(src: &str, data: Option<&Data>) -> (Compiled, Vec<Value>) {
	let r = match data {
		Some(d) => compile_with(src, d),
		None => compile(src),
	};
	let g = goals_of(&r);
	(r, g)
}

fn only(list: &[String], pat: &str) -> Vec<String> {
	list.iter().filter(|m| re(pat).is_match(m)).cloned().collect()
}

fn cands(g: &Value, f: impl Fn(&Value) -> Value) -> Vec<Value> {
	g["candidates"].as_array().unwrap().iter().map(f).collect()
}

/// A copy of the fixture data folder with edits applied (by file name).
fn data_with(name: &str, edit: impl FnOnce(&mut Map<String, Value>)) -> Data {
	load_data(&data_dir_with(&format!("smart-{name}"), &data_dir(), edit)).unwrap()
}

#[test]
fn train_profession_rank_trainers_of_the_guide_factions_with_skill_line_rank_and_cap() {
	let (r, g) = goals(&text(head(Some("Alliance"), &[]), &["step S", "  train Mining", "  train Mining Expert"]), None);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(
		g[0],
		json!({ "t": "train", "skill": "Mining", "skillLine": 186, "rank": 1, "rankMax": 75, "candidates": [{ "npc": 1681, "npcName": "Brock Stoneseeker", "map": 1426, "x": 37, "y": 47.8, "f": "e", "faction": "A" }] })
	);
	assert_eq!(json!([g[1]["rank"], g[1]["rankMax"], cands(&g[1], |c| c["npc"].clone())]), json!([3, 225, [1681]]));
	// No faction: both sides' trainers, each tagged.
	let both = goals(&text(head(None, &[]), &["step S", "  train Mining"]), None).1;
	assert_eq!(cands(&both[0], |c| json!([c["npc"], c["faction"]])), [json!([1681, "A"]), json!([3175, "H"])]);
}

#[test]
fn train_profession_book_and_quest_ranks_point_at_the_book_vendor_and_quest_giver() {
	let (r, g) = goals(&text(head(None, &[]), &["step S", "  train First Aid Expert", "  train Mining Artisan"]), None);
	// The Expert First Aid book is only sold to the Alliance in this data.
	assert_eq!(only(&r.warnings, "no vendor of the First Aid Expert book for Horde").len(), 1);
	assert_eq!(cands(&g[0], |c| json!([c["npc"], c["faction"]])), [json!([2805, "A"])]);
	// Listed as quest giver for both factions: tagged for both even though npcs.json says Alliance.
	assert_eq!(cands(&g[1], |c| json!([c["npc"], c["faction"]])), [json!([8125, "AH"])]);
	assert!(r.errors.is_empty(), "{}", r.text);
}

#[test]
fn train_profession_the_default_rank_follows_earlier_skill_targets_and_never_repeats_a_trained_rank() {
	let body = [
		"step S",
		"  train Mining",
		"  skill Mining 50",
		"  train Mining",
		"  skill Mining 75",
		"  train Mining",
		"  skill Mining 150",
		"  train Mining",
		"  craft 3276 until 230",
		"  train First Aid",
	];
	let src = text(head(Some("Alliance"), &[]), &body);
	let (r, g) = goals(&src, None);
	let trains: Vec<Value> = g.iter().filter(|x| x["t"] == "train").map(|x| json!([x["skill"], x["rank"]])).collect();
	// skill 75 alone still means Journeyman, which is already trained: next is Expert; that one was trained
	// early, so 150 moves on to Artisan; `craft … until 230` counts as a First Aid target (Artisan; 225).
	assert_eq!(trains, [json!(["Mining", 1]), json!(["Mining", 2]), json!(["Mining", 3]), json!(["Mining", 4]), json!(["First Aid", 4])]);
	assert_eq!(
		only(&r.warnings, "means"),
		vec![
			format!(
				"test.guide:{}: `train Mining` means Expert here (needs skill 125), but no earlier `skill Mining` target reaches 125; name the rank or add the skill goal",
				line_of(&src, "  skill Mining 75") + 1
			),
			format!(
				"test.guide:{}: `train Mining` means Artisan here (needs skill 225), but no earlier `skill Mining` target reaches 225; name the rank or add the skill goal",
				line_of(&src, "  skill Mining 150") + 1
			),
		]
	);
	let done = compile(&text(head(Some("Alliance"), &[]), &["step S", "  train Mining Artisan", "  train Mining"]));
	assert_eq!(done.errors, ["test.guide:9: `train Mining`: Artisan is already trained earlier in this guide"]);
}

#[test]
fn train_profession_npc_id_keeps_the_trainer_errors_for_unknown_professions_and_coordinates() {
	let g = goals(&text(head(Some("Alliance"), &[]), &["step S", "  train Mining npc 1681"]), None).1;
	assert_eq!(g[0], json!({ "t": "train", "npc": 1681, "npcName": "Brock Stoneseeker", "skill": "Mining", "skillLine": 186, "rank": 1, "rankMax": 75, "map": 1426, "x": 37, "y": 47.8, "f": "e" }));
	let r = compile(&text(head(Some("Alliance"), &[]), &["step S", "  train Basket Weaving", "  train Mining @50,50", "  train only Warrior", "  train 911"]));
	assert_eq!(
		r.errors,
		[
			"test.guide:8: unknown profession \"Basket Weaving\" (write `train <Profession> [Apprentice|Journeyman|Expert|Artisan]`, `train class` or `train <npcId>`)",
			"test.guide:9: smart targets pick their NPC and position at runtime; drop the coordinates, or name an npc id",
		]
	);
	// The plain forms still compile as before.
	let goals = r.steps()[0]["goals"].as_array().unwrap().clone();
	assert_eq!(goals[2..].iter().map(|x| x.get("npc").cloned().unwrap_or(Value::Null)).collect::<Vec<_>>(), [Value::Null, json!(911)]);
}

#[test]
fn train_class_class_trainers_of_the_classes_and_factions_the_goal_applies_to() {
	// Without trainers.json the curated list is used, resolved by name and map in npcs.json.
	let (r, g) = goals(&text(head(Some("Alliance"), &["class Warrior,Mage"]), &["step S", "  train class"]), None);
	assert!(r.errors.is_empty() && r.warnings.is_empty(), "{}", r.text);
	assert_eq!(g[0]["class"], true);
	assert_eq!(
		cands(&g[0], |c| json!([c["npc"], c["npcName"], c["faction"], c["classes"]])),
		[json!([911, "Llane Beshere", "A", ["WARRIOR"]]), json!([198, "Khelden Bremen", "A", ["MAGE"]]), json!([5479, "Wu Shen", "A", ["WARRIOR"]])]
	);
	// "Lyria Du Lac" is curated for Elwynn, but the fixture has her only in Durotar: not trusted.
	assert!(!g[0]["candidates"].as_array().unwrap().iter().any(|c| c["npc"] == 913));
	// A goal-level `only` narrows the classes.
	let mage = goals(&text(head(Some("Alliance"), &[]), &["step S", "  train class only Mage"]), None).1;
	assert_eq!(cands(&mage[0], |c| c["npc"].clone()), [json!(198)]);
}

#[test]
fn train_class_missing_coverage_warns_per_faction_and_class_no_candidate_at_all_is_an_error() {
	// Horde Mage: the fixture has no Horde mage trainer (Frang is a warrior).
	let horde = compile(&text(head(Some("Horde"), &["class Warrior,Mage"]), &["step S", "  train class"]));
	assert!(horde.errors.is_empty(), "{}", horde.text);
	assert_eq!(horde.warnings, ["test.guide:9: no Mage trainer for Horde in data (trainers.json)"]);
	let none = compile(&text(head(Some("Horde"), &["class Druid"]), &["step S", "  train class"]));
	assert_eq!(none.errors, ["test.guide:9: `train` found no class trainer in data for Horde characters; name one with an npc id instead"]);
	let npc = compile(&text(head(Some("Alliance"), &[]), &["step S", "  level 2", "  train class npc 911"]));
	assert_eq!(npc.errors, ["test.guide:9: `train class` picks the trainer at runtime; drop `npc`"]);
}

#[test]
fn train_class_reads_trainers_json_when_present() {
	let data = data_with("trainers", |raw| {
		raw.insert("trainers.json".into(), json!({ "3153": { "id": 3153, "name": "Frang", "classes": ["MAGE"], "sources": ["guide"] } }));
	});
	let (r, g) = goals(&text(head(Some("Horde"), &["class Mage"]), &["step S", "  train class"]), Some(&data));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(cands(&g[0], |c| json!([c["npc"], c["classes"]])), [json!([3153, ["MAGE"]])]);
}

#[test]
fn buy_nearest_vendor_nearest_and_sethome_nearest_vendors_repairers_and_innkeepers_with_faction_tags() {
	let (r, g) = goals(&text(head(None, &[]), &["step S", "  buy 159 x5 nearest", "  vendor nearest", "  sethome nearest", "  sethome \"nearest\""]), None);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(cands(&g[0], |c| json!([c["npc"], c["faction"]])), [json!([152, "A"]), json!([295, "A"])]);
	assert_eq!(g[0]["count"], 5);
	assert!(g[0].get("npc").is_none());
	// Sell junk and repair: only NPCs that repair (Brother Danil and Jark only sell).
	assert_eq!(
		g[1],
		json!({ "t": "vendor", "candidates": [
			{ "npc": 190, "npcName": "Dermot Johns", "map": 1429, "x": 47.6, "y": 41.4, "f": "e", "faction": "A" },
			{ "npc": 54, "npcName": "Corina Steele", "map": 1429, "x": 41.5, "y": 65.9, "f": "e", "faction": "A" },
			{ "npc": 3163, "npcName": "Uhgar", "map": 1411, "x": 52, "y": 40.5, "f": "e", "faction": "H" },
		] })
	);
	// The goblin innkeeper has no faction in npcs.json: a neutral town serves both. Stranglethorn shares the
	// continent with Elwynn, so the goblin inn ranks before Durotar's.
	assert_eq!(cands(&g[2], |c| json!([c["npc"], c["faction"]])), [json!([295, "A"]), json!([6807, "AH"]), json!([6928, "H"])]);
	assert!(g[2].get("location").is_none());
	assert_eq!(g[3], json!({ "t": "sethome", "location": "nearest" }));
	// Spring Water has no Horde vendor here, but this guide also serves Horde.
	assert_eq!(only(&r.warnings, "no vendor of item 159 for Horde"), ["test.guide:7: no vendor of item 159 for Horde in data, but this goal applies to Horde characters"]);
}

#[test]
fn nearest_the_guide_faction_and_race_filters_candidates_nothing_usable_is_an_error() {
	let alliance = goals(&text(head(Some("Alliance"), &[]), &["step S", "  vendor nearest"]), None).1;
	assert_eq!(cands(&alliance[0], |c| c["npc"].clone()), [json!(190), json!(54)]);
	let humans = goals(&text(head(None, &["race Human"]), &["step S", "  vendor nearest"]), None).1;
	assert_eq!(cands(&humans[0], |c| c["npc"].clone()), [json!(190), json!(54)]);
	let r = compile(&text(head(Some("Horde"), &[]), &["step S", "  buy 159 nearest", "  buy 6948 nearest", "  vendor nearest npc 3164", "  sethome nearest @1,1"]));
	assert_eq!(
		r.errors,
		[
			"test.guide:8: `buy` found no vendor of item 159 in data for Horde characters; name one with an npc id instead",
			"test.guide:9: `buy` found no vendor of item 6948 in data for Horde characters; name one with an npc id instead",
			"test.guide:10: `nearest` picks the NPC at runtime; drop `npc`, or drop `nearest` to keep that NPC",
			"test.guide:11: smart targets pick their NPC and position at runtime; drop the coordinates, or name an npc id",
		]
	);
}

fn smith(npcs: &mut Value, id: u32, name: &str, map: u32, x: f64, y: f64, frame: bool) {
	let pts = if frame { json!({ "f": "e", "pts": [[x, y]] }) } else { json!({ "pts": [[x, y]] }) };
	npcs[id.to_string()] = json!({ "id": id, "name": name, "level": 5, "faction": "A", "roles": ["repair", "vendor"], "spawns": { map.to_string(): pts } });
}

#[test]
fn candidate_sets_keep_one_candidate_per_town_on_every_map_nearest_to_the_previous_goal_first() {
	let data = data_with("towns", |raw| {
		let npcs = raw.get_mut("npcs.json").unwrap();
		// Four smiths a few yards apart in one town, three in a village far west, one in Stormwind.
		for i in 0..4 {
			smith(npcs, 90000 + i, &format!("Town Smith {i}"), 1429, 80.0 + i as f64 * 0.3, 50.0, true);
		}
		for i in 0..3 {
			smith(npcs, 90010 + i, &format!("Village Smith {i}"), 1429, 20.0 + i as f64 * 0.3, 50.0, true);
		}
		smith(npcs, 90100, "City Smith", 1453, 50.0, 50.0, true);
	});
	let g = goals(&text(head(Some("Alliance"), &[]), &["step S", "  goto 95,50", "  vendor nearest"]), Some(&data)).1;
	let ids: Vec<u64> = cands(&g[1], |c| c["npc"].clone()).iter().map(|v| v.as_u64().unwrap()).collect();
	// One per town, the town's smith nearest the previous goal first; no town is dropped for a cap.
	assert_eq!(ids[0], 90003, "{ids:?}");
	assert_eq!(ids.iter().filter(|&&i| (90000..=90003).contains(&i)).count(), 1, "{ids:?}");
	assert_eq!(ids.iter().filter(|&&i| (90010..=90012).contains(&i)).count(), 1, "{ids:?}");
	for id in [90100, 190, 54] {
		assert!(ids.contains(&id), "{id} missing from {ids:?}");
	}
}

#[test]
fn a_map_with_only_a_forever_frame_keeps_one_candidate_per_town_too_not_one_per_map() {
	let data = data_with("zephras", |raw| {
		// Zephras Isle: a map Forever added, so map-frames.json has only its Forever frame.
		raw.get_mut("map-frames.json").unwrap()["forever"] = json!({ "2521": { "c": 2991, "left": 4231.25, "right": -1331.25, "top": 4956.25, "bottom": 1247.917 } });
		let npcs = raw.get_mut("npcs.json").unwrap();
		// Two smiths a few yards apart in one village, one in another village 20% of the map south.
		smith(npcs, 91000, "Isle Smith A", 2521, 42.8, 23.6, false);
		smith(npcs, 91001, "Isle Smith B", 2521, 42.9, 23.6, false);
		smith(npcs, 91002, "Shen Smith", 2521, 42.0, 44.9, false);
	});
	let g = goals(&text(head(Some("Alliance"), &[]), &["step S", "  vendor nearest"]), Some(&data)).1;
	let mut isle: Vec<u64> = g[0]["candidates"].as_array().unwrap().iter().filter(|c| c["map"] == 2521).map(|c| c["npc"].as_u64().unwrap()).collect();
	isle.sort();
	// Both villages stay, so the engine can send a player in the southern one to its own smith.
	assert_eq!(isle, [91000, 91002]);
}

#[test]
fn accept_goals_carry_the_quest_level_and_prerequisites_for_grey_quest_skipping() {
	let g = goals(&text(head(Some("Alliance"), &[]), &["step S", "  accept 9500", "  accept 783 lvl 3"]), None).1;
	let get = |x: &Value, k: &str| x.get(k).cloned().unwrap_or(Value::Null);
	assert_eq!(json!([get(&g[0], "qlvl"), get(&g[0], "pre"), get(&g[1], "qlvl"), get(&g[1], "pre"), get(&g[1], "minLevel")]), json!([3, [9201, 783], 1, null, 3]));
	let unknown = goals(&text(head(Some("Alliance"), &[]), &["step S", "  accept 424242 \"New\""]), None).1;
	assert!(unknown[0].get("qlvl").is_none() && unknown[0].get("pre").is_none());
}

#[test]
fn every_goal_of_a_quest_that_needs_a_profession_carries_it_a_leveling_guide_warns_on_its_non_optional_goals_unless_it_trains_the_profession_first() {
	// Kobold Camp Cleanup (7) needs Mining 50, Wolves Across the Border (33) Mining with no level (rank 1).
	let data = data_with("prof", |raw| {
		let q = raw.get_mut("quests.json").unwrap();
		q["7"]["skill"] = json!(186);
		q["7"]["skillLevel"] = json!(50);
		q["7"]["pre"] = json!([]);
		q["33"]["skill"] = json!(186);
	});
	let src = |category: &str, lines: &[&str]| text(head(Some("Alliance"), &[&format!("category {category}")]), &[&["step S"], lines].concat());
	let steps = ["  accept 7", "  kill 6 quest 7", "  turnin 7 optional", "  accept 33 optional", "  accept 9500"];
	let t = src("Leveling", &steps);
	let (r, g) = goals(&t, Some(&data));
	let get = |x: &Value, k: &str| x.get(k).cloned().unwrap_or(Value::Null);
	assert_eq!(
		g.iter().map(|x| json!([x["t"], get(x, "profLine"), get(x, "profName"), get(x, "profRank")])).collect::<Vec<_>>(),
		[json!(["accept", 186, "Mining", 50]), json!(["kill", 186, "Mining", 50]), json!(["turnin", 186, "Mining", 50]), json!(["accept", 186, "Mining", 1]), json!(["accept", null, null, null])]
	);
	let msg = "quest 7 (Kobold Camp Cleanup) needs Mining 50, and the guide does not train it before here: characters without it never see this goal";
	assert_eq!(only(&r.warnings, "needs Mining"), vec![format!("test.guide:{}: {msg}", line_of(&t, "accept 7")), format!("test.guide:{}: {msg}", line_of(&t, "kill 6 quest 7"))]);
	// Trained earlier in the guide (levelled to the quest's rank above 1), or another category: no warning.
	let warns = |category: &str, lines: &[&str]| only(&goals(&src(category, lines), Some(&data)).0.warnings, "needs Mining").len();
	assert_eq!(warns("Leveling", &["  train Mining", "  accept 33"]), 0);
	assert_eq!(warns("Leveling", &["  train Mining", "  accept 7"]), 1);
	assert_eq!(warns("Leveling", &["  skill Mining 50", "  accept 7"]), 0);
	assert_eq!(warns("Class", &steps), 0);
	// Guides.lua carries the new fields.
	let pack = compile_files(&[("test.guide", &t.replacen("guide t/", "guide test/", 1))], &data, Some("test"));
	assert_match(&emit(&pack.guides), r#"profLine = 186, profName = "Mining", profRank = 50"#);
}

#[test]
fn smart_goals_emit_the_lua_the_engine_reads() {
	let src =
		text(head(None, &[]), &["step S", "  train Mining", "  train class", "  buy 159 nearest", "  vendor nearest", "  sethome nearest", "  accept 9500"]).replacen("guide t/", "guide test/", 1);
	let r = compile_files(&[("test.guide", &src)], &fixture_data(), Some("test"));
	assert!(r.errors.is_empty(), "{}", r.text);
	let lua = emit(&r.guides);
	assert_match(
		&lua,
		r#"\{ t = "train", class = true, candidates = \{ \{ npc = 911, npcName = "Llane Beshere", map = 1429, x = 50\.2, y = 42\.3, f = "e", faction = "A", classes = \{ "WARRIOR" \} \}"#,
	);
	assert_match(&lua, r#"\{ t = "accept", quest = 9500, title = "Either Way", npc = 823, npcName = "Deputy Willem", minLevel = 1, qlvl = 3, pre = \{ 9201, 783 \},"#);
}
