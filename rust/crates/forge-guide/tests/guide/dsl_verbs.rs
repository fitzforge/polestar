//! Profession, reputation, exploration and achievement verbs (skill, learn, craft, rep, explore, achieve):
//! parse, resolve from professions.json / factions.json, validation, the emitted Lua, and the fallbacks when
//! those data files are absent. (Loading the goals in the addon is an addon test.)

use crate::common;
use common::*;
use forge_guide::data::{load_data, Data};
use serde_json::{json, Value};

/// Fixture data without these files (as while they are being built).
fn data_without(names: &[&str]) -> Data {
	let dir = scratch("verbs-without");
	for e in std::fs::read_dir(data_dir()).unwrap().flatten() {
		if !names.contains(&e.file_name().to_string_lossy().as_ref()) {
			std::fs::copy(e.path(), dir.join(e.file_name())).unwrap();
		}
	}
	load_data(&dir).unwrap()
}

fn goals(lines: &[&str]) -> (Compiled, Vec<Value>) {
	let r = compile(&guide_text(lines));
	let g = if r.guides.is_empty() { Vec::new() } else { r.steps().iter().flat_map(|s| s["goals"].as_array().cloned().unwrap_or_default()).collect() };
	(r, g)
}

fn only(list: &[String], pat: &str) -> Vec<String> {
	list.iter().filter(|m| re(pat).is_match(m)).cloned().collect()
}

#[test]
fn skill_profession_names_resolve_to_skill_lines() {
	let (r, g) = goals(&["step S", "  skill First Aid 75", "  skill \"first aid\" 150", "  skill mining 50", "  skill \"Jewelcrafting\" 1"]);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(
		g[..3],
		[
			json!({ "t": "skill", "skill": "First Aid", "skillLine": 129, "level": 75 }),
			json!({ "t": "skill", "skill": "First Aid", "skillLine": 129, "level": 150 }),
			// Classic professions resolve from built-in skill lines even when professions.json lacks them.
			json!({ "t": "skill", "skill": "Mining", "skillLine": 186, "level": 50 }),
		]
	);
	assert_eq!(g[3], json!({ "t": "skill", "skill": "Jewelcrafting", "level": 1 }));
	assert_match(&r.warnings.join("\n"), r#"test\.guide:11: profession "Jewelcrafting" is not in data; using the explicit name"#);
}

#[test]
fn skill_unknown_unquoted_professions_and_malformed_ranks_are_errors_at_their_line() {
	let src = guide_text(&["step S", "  skill Basketry 10", "  skill Mining", "  skill Mining 7x", "  skill 75"]);
	let at = |l: &str| line_of(&src, l);
	let usage = "`skill` needs a profession and a rank: skill <Profession> <N>";
	assert_eq!(
		compile(&src).errors,
		vec![
			format!("test.guide:{}: unknown profession \"Basketry\"; quote the name to use it anyway: `skill \"Basketry\" 10`", at("  skill Basketry 10")),
			format!("test.guide:{}: {usage}", at("  skill Mining")),
			format!("test.guide:{}: {usage}", at("  skill Mining 7x")),
			format!("test.guide:{}: {usage}", at("  skill 75")),
		]
	);
}

#[test]
fn learn_names_skill_line_and_recipe_item_from_data_trainer_taught_recipes_get_every_trainer_as_candidates() {
	let (r, g) = goals(&["step S", "  learn 3276", "  learn 7934", "  learn 3275 \"Bandage\" npc 5150"]);
	assert!(r.errors.is_empty(), "{}", r.text);
	// Trainer-taught, no npc: the guide faction's trainers, chosen at runtime (current zone first). Ironforge
	// has no Era bounds in the fixture: the point is emitted live-frame.
	assert_eq!(
		g[0],
		json!({ "t": "learn", "spell": 3276, "spellName": "Heavy Linen Bandage", "skillLine": 129, "candidates": [
			{ "npc": 2329, "npcName": "Michelle Belle", "map": 1429, "x": 43.39, "y": 65.55, "f": "e", "faction": "A" },
			{ "npc": 5150, "npcName": "Nissa Firestone", "map": 1455, "x": 54.8, "y": 58.6, "faction": "A" },
		] })
	);
	// A recipe learned from an item names the item instead of a trainer.
	assert_eq!(g[1], json!({ "t": "learn", "spell": 7934, "spellName": "Anti-Venom", "item": 6454, "itemName": "Manual: Strong Anti-Venom", "skillLine": 129 }));
	// An explicit trainer stays fixed.
	assert_eq!(g[2], json!({ "t": "learn", "spell": 3275, "spellName": "Bandage", "npc": 5150, "npcName": "Nissa Firestone", "skillLine": 129, "map": 1455, "x": 54.8, "y": 58.6 }));
}

#[test]
fn learn_in_a_both_faction_guide_is_not_pinned_to_the_trainer_near_an_earlier_step() {
	// The earlier Durotar step used to pin the Durotar (Horde) trainer for every race.
	let r = compile(&guide_text(&[
		"guide t/b",
		"title Both",
		"levels 1-60",
		"zone Durotar",
		"",
		"step One",
		"  goto 54,41",
		"step Two",
		"  zone Elwynn Forest",
		"  goto 43,65",
		"step Three",
		"  learn 3276",
	]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let goal = r.steps()[2]["goals"][0].clone();
	assert!(goal.get("npc").is_none() && goal.get("map").is_none());
	assert_eq!(goal["candidates"].as_array().unwrap().iter().map(|c| json!([c["npc"], c["faction"]])).collect::<Vec<_>>(), [json!([2329, "A"]), json!([3373, "H"]), json!([5150, "A"])]);
	// Horde-only guides keep only Horde trainers.
	let horde = compile(&guide_text(&["guide t/h", "title H", "faction Horde", "levels 1-5", "zone Durotar", "", "step S", "  learn 3276"]));
	assert_eq!(horde.steps()[0]["goals"][0]["candidates"].as_array().unwrap().iter().map(|c| c["npc"].clone()).collect::<Vec<_>>(), [json!(3373)]);
}

#[test]
fn learn_nearest_recipe_item_learns_go_to_the_nearest_vendor_of_the_recipe_no_source_is_an_error() {
	let (r, g) = goals(&["step S", "  learn 7934 nearest", "  learn 3276 nearest", "  learn 99997 \"Skyborne Weaving\" nearest", "  learn 3276 nearest npc 2329"]);
	let npcs = |x: &Value| x["candidates"].as_array().unwrap().iter().map(|c| c["npc"].clone()).collect::<Vec<_>>();
	assert_eq!(npcs(&g[0]), [json!(2805)]);
	assert_eq!(g[0]["item"], 6454);
	assert_eq!(npcs(&g[1]), [json!(2329), json!(5150)]);
	assert_eq!(
		r.errors,
		[
			"test.guide:10: `learn 99997 nearest`: no trainer or recipe vendor for this spell in data",
			"test.guide:11: `nearest` picks the NPC at runtime; drop `npc`, or drop `nearest` to keep that NPC"
		]
	);
}

#[test]
fn craft_created_item_reagents_x_n_as_crafts_and_until_n() {
	let (r, g) = goals(&["step S", "  learn 3276", "  learn 7934", "  craft 3276 x5", "  craft 7934 x4", "  craft 3276 until 80", "  craft 3276 until 120"]);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(
		g[2],
		json!({ "t": "craft", "spell": 3276, "spellName": "Heavy Linen Bandage", "item": 2581, "itemName": "Heavy Linen Bandage", "count": 5, "skillLine": 129, "reagents": [{ "item": 2589, "itemName": "Linen Cloth", "count": 2 }] })
	);
	// Anti-Venom makes 3 per craft: 4 crafts -> 12 items.
	assert_eq!(g[3]["count"], 12);
	assert_eq!(json!([g[4]["untilSkill"], g[4].get("count"), g[4]["skillLine"]]), json!([80, null, 129]));
	assert_eq!(only(&r.warnings, "grey"), ["test.guide:13: Heavy Linen Bandage turns grey at 100; crafting it gives no skill up to 120"]);
}

#[test]
fn craft_x_n_and_until_together_and_until_on_non_craft_verbs_are_errors() {
	let src = guide_text(&["step S", "  level 2", "  craft 3275 x2 until 30", "  learn 3275 until 30", "  kill 6 criteria 1"]);
	assert_eq!(
		compile(&src).errors,
		vec![
			format!("test.guide:{}: use either `xN` or `until <N>`, not both", line_of(&src, "  craft 3275 x2 until 30")),
			format!("test.guide:{}: `until <N>` does not apply to `learn`", line_of(&src, "  learn 3275 until 30")),
			format!("test.guide:{}: `criteria <n>` does not apply to `kill`", line_of(&src, "  kill 6 criteria 1")),
		]
	);
}

#[test]
fn learn_craft_unknown_spells_need_a_quoted_name_with_one_they_warn() {
	let src = guide_text(&["step S", "  learn 99999", "  craft 99998", "  learn 99997 \"Skyborne Weaving\"", "  craft 99997 \"Skyborne Weaving\" x2 until 10"]);
	let r = compile(&src);
	assert_eq!(
		r.errors,
		vec![
			format!("test.guide:{}: spell 99999 is not in data; give its name: `learn 99999 \"Name\"`", line_of(&src, "  learn 99999")),
			format!("test.guide:{}: spell 99998 is not in data; give its name: `craft 99998 \"Name\"`", line_of(&src, "  craft 99998")),
			format!("test.guide:{}: use either `xN` or `until <N>`, not both", line_of(&src, "  craft 99997 \"Skyborne Weaving\" x2 until 10")),
		]
	);
	assert_match(&r.warnings.join("\n"), &format!(r"test\.guide:{}: spell 99997 is not in data; using the explicit name", line_of(&src, "  learn 99997 \"Skyborne Weaving\"")));
}

#[test]
fn craft_before_its_learn_in_the_chain_warns_an_earlier_learn_or_a_free_starter_recipe_does_not() {
	let src = guide_text(&["step S", "  craft 3276 x1", "  learn 3276", "  craft 3276 x1", "  craft 3275 x1"]);
	assert_eq!(
		only(&compile(&src).warnings, "before any"),
		vec![format!("test.guide:{}: `craft` 3276 (Heavy Linen Bandage) before any `learn 3276` earlier in this guide or a guide chaining into it", line_of(&src, "  craft 3276 x1"))]
	);
	let one = "guide t/one\ntitle t/one\nlevels 1-10\nzone Elwynn Forest\nnext t/two\n\nstep S\n  learn 7934\n";
	let two = "guide t/two\ntitle t/two\nlevels 1-10\nzone Elwynn Forest\n\nstep S\n  craft 7934 x1\n";
	assert!(only(&compile_map(&[("1.guide", one), ("2.guide", two)]).warnings, "before any").is_empty());
}

#[test]
fn rep_faction_by_name_or_id_standing_by_name_or_number() {
	let (r, g) = goals(&["step S", "  rep Stormwind Honored", "  rep \"darnassus\" friendly", "  rep 76 8", "  rep 1234 \"Skyborne Accord\" Revered", "  rep Twin Name Neutral"]);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(
		g[..4],
		[
			json!({ "t": "rep", "faction": 72, "factionName": "Stormwind", "standing": 6 }),
			json!({ "t": "rep", "faction": 69, "factionName": "Darnassus", "standing": 5 }),
			json!({ "t": "rep", "faction": 76, "factionName": "Orgrimmar", "standing": 8 }),
			json!({ "t": "rep", "faction": 1234, "factionName": "Skyborne Accord", "standing": 7 }),
		]
	);
	assert_eq!([&g[4]["faction"], &g[4]["standing"]], [&json!(9001), &json!(4)]);
	let w = r.warnings.join("\n");
	assert_match(&w, r"test\.guide:11: faction 1234 is not in data; using the explicit name");
	assert_match(&w, r#"test\.guide:12: faction "Twin Name" matches ids 9001, 9002; using 9001"#);
}

#[test]
fn rep_unknown_factions_out_of_range_and_unknown_standings_are_errors_at_their_line() {
	let src = guide_text(&["step S", "  rep Gadgetzan Friendly", "  rep Stormwind 9", "  rep Stormwind 0", "  rep 72 Adored", "  rep 4321 Friendly", "  rep Stormwind"]);
	let at = |l: &str| line_of(&src, l);
	assert_eq!(
		compile(&src).errors,
		vec![
			format!("test.guide:{}: unknown faction \"Gadgetzan\"; give its id with the name: `rep <factionId> \"Gadgetzan\" <Standing>`", at("  rep Gadgetzan Friendly")),
			format!("test.guide:{}: standing 9 is out of range (1-8, or Hated..Exalted)", at("  rep Stormwind 9")),
			format!("test.guide:{}: standing 0 is out of range (1-8, or Hated..Exalted)", at("  rep Stormwind 0")),
			format!("test.guide:{}: unknown standing \"Adored\" (Hated, Hostile, Unfriendly, Neutral, Friendly, Honored, Revered, Exalted, or 1-8)", at("  rep 72 Adored")),
			format!("test.guide:{}: faction 4321 is not in data; give its name: `rep 4321 \"Name\" <Standing>`", at("  rep 4321 Friendly")),
			format!("test.guide:{}: `rep` needs a faction and a standing: rep <Faction> <Standing> or rep <factionId> <Standing>", at("  rep Stormwind")),
		]
	);
}

#[test]
fn explore_coordinates_in_the_current_zone_or_a_map_with_the_area_name() {
	let (r, g) = goals(&["step S", "  explore 42.1,65.9 \"Goldshire\"", "  explore 50,50 map 1453 r 30", "  explore 101,5"]);
	assert_eq!(r.errors, ["test.guide:10: coordinates 101,5 are outside 0-100"]);
	assert_eq!(g[0], json!({ "t": "explore", "text": "Goldshire", "map": 1429, "x": 42.1, "y": 65.9, "f": "e" }));
	assert_eq!(g[1], json!({ "t": "explore", "map": 1453, "x": 50, "y": 50, "f": "e", "r": 30 }));
	let bad = guide_text(&["step S", "  level 2", "  explore \"Goldshire\"", "  explore 1,2 @3,4"]);
	assert_eq!(
		compile(&bad).errors,
		vec![
			format!("test.guide:{}: `explore` needs coordinates x,y", line_of(&bad, "  explore \"Goldshire\"")),
			format!("test.guide:{}: `@x,y` does not apply to `explore`", line_of(&bad, "  explore 1,2 @3,4"))
		]
	);
}

#[test]
fn achieve_id_required_name_and_optional_criterion() {
	let (r, g) = goals(&["step S", "  achieve 6 \"Level 10\"", "  achieve 7 \"Legacy: Northshire\" criteria 3 optional"]);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(
		g,
		[
			json!({ "t": "achieve", "achievement": 6, "achievementName": "Level 10" }),
			json!({ "t": "achieve", "achievement": 7, "achievementName": "Legacy: Northshire", "criteria": 3, "optional": true })
		]
	);
	let src = guide_text(&["step S", "  achieve 6", "  achieve x6 \"A\"", "  achieve 6 \"A\" criteria 0"]);
	assert_eq!(
		compile(&src).errors,
		vec![
			format!("test.guide:{}: achievement 6 has no reference data; give its name: `achieve 6 \"Name\"`", line_of(&src, "  achieve 6")),
			format!("test.guide:{}: malformed achievement id \"x6\"", line_of(&src, "  achieve x6 \"A\"")),
			format!("test.guide:{}: malformed criterion index \"0\"", line_of(&src, "  achieve 6 \"A\" criteria 0")),
		]
	);
}

#[test]
fn without_professions_json_and_factions_json_built_in_professions_still_resolve_quoted_names_warn_nothing_crashes() {
	let data = data_without(&["professions.json", "factions.json"]);
	assert_eq!(data.missing, ["professions.json", "factions.json", "trainers.json", "travel.json", "spawnz.json"]);
	let src = guide_text(&[
		"step S",
		"  skill Tailoring 75",
		"  learn 3275 \"Linen Bandage\"",
		"  craft 3275 \"Linen Bandage\" x5",
		"  craft 3275 \"Linen Bandage\" until 40",
		"  rep 72 \"Stormwind\" Friendly",
		"  learn 3276",
		"  rep Stormwind Friendly",
	]);
	let r = compile_with(&src, &data);
	assert_eq!(
		r.errors,
		vec![
			format!("test.guide:{}: spell 3276 is not in data (professions.json missing); give its name: `learn 3276 \"Name\"`", line_of(&src, "  learn 3276")),
			format!(
				"test.guide:{}: unknown faction \"Stormwind\" (factions.json missing); give its id with the name: `rep <factionId> \"Stormwind\" <Standing>`",
				line_of(&src, "  rep Stormwind Friendly")
			),
		]
	);
	let g = r.steps()[0]["goals"].as_array().unwrap().clone();
	assert_eq!(
		g[..5],
		[
			json!({ "t": "skill", "skill": "Tailoring", "skillLine": 197, "level": 75 }),
			json!({ "t": "learn", "spell": 3275, "spellName": "Linen Bandage" }),
			json!({ "t": "craft", "spell": 3275, "spellName": "Linen Bandage", "count": 5 }),
			json!({ "t": "craft", "spell": 3275, "spellName": "Linen Bandage", "untilSkill": 40 }),
			json!({ "t": "rep", "faction": 72, "factionName": "Stormwind", "standing": 5 }),
		]
	);
	let w = r.warnings.join("\n");
	assert_match(&w, r"spell 3275 is not in data \(professions\.json missing\); using the explicit name");
	assert_match(&w, r"`until` needs the recipe's profession, but spell 3275 is not in professions\.json");
	assert_match(&w, r"faction 72 is not in data \(factions\.json missing\); using the explicit name");
	// A corrupt optional file counts as missing instead of failing the build.
	let dir = scratch("verbs-corrupt");
	for e in std::fs::read_dir(data_dir()).unwrap().flatten() {
		std::fs::copy(e.path(), dir.join(e.file_name())).unwrap();
	}
	std::fs::write(dir.join("professions.json"), "{ \"129\": { \"na").unwrap();
	assert!(load_data(&dir).unwrap().missing.contains(&"professions.json".to_string()));
}

#[test]
fn documented_categories_are_accepted_case_insensitively_others_warn_and_pass_through() {
	// A Class guide says what its goal gives and why (a warning without them).
	let base = |cat: &str| {
		let category = format!("category {cat}");
		let mut l = vec!["guide t/c", "title C", "levels 1-5", "zone Elwynn Forest", category.as_str()];
		if cat == "class" {
			l.extend(["reward text Defensive Stance", "why A stance."]);
		}
		l.extend(["", "step S", "  level 2"]);
		guide_text(&l)
	};
	for c in ["Leveling", "Class", "Professions", "Reputation", "Legacy", "Exploration", "Collectibles", "Miscellaneous", "Dungeons"] {
		let r = compile(&base(&c.to_lowercase()));
		assert_eq!(r.guides[0].get("category").to_js_string(), c);
		assert!(r.warnings.is_empty(), "{c}: {:?}", r.warnings);
	}
	let odd = compile(&base("Fishing Tales"));
	assert_eq!(odd.guides[0].get("category").to_js_string(), "Fishing Tales");
	assert_eq!(odd.warnings, ["test.guide:5: unknown category \"Fishing Tales\" (known: Leveling, Class, Professions, Reputation, Legacy, Exploration, Collectibles, Miscellaneous, Dungeons)"]);
}

#[test]
fn new_verbs_emit_reagents_as_nested_tables() {
	let r = compile(&guide_text(&[
		"guide t/prof",
		"title First Aid 1-150",
		"category Professions",
		"levels 1-60",
		"zone Elwynn Forest",
		"",
		"step Train",
		"  learn 3276",
		"  craft 3276 x10 -- \"Linen\" \\ notes",
		"  craft 7934 until 115",
		"  skill First Aid 150",
	]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_match(&emit(&r.guides), r#"reagents = \{ \{ item = 2589, itemName = "Linen Cloth", count = 2 \} \}"#);
}

#[test]
fn prerequisites_are_any_of_one_turned_in_prerequisite_suffices_none_of_them_warns() {
	// 9500 lists 9201 and 783 as prerequisites.
	let pat = "turned in first|none of them";
	assert!(only(&compile(&guide_text(&["step S", "  accept 783", "  turnin 783", "  accept 9500"])).warnings, pat).is_empty());
	assert!(only(&compile(&guide_text(&["step S", "  accept 9201", "  turnin 9201", "  accept 9500"])).warnings, pat).is_empty());
	let src = guide_text(&["step S", "  accept 9500"]);
	assert_eq!(
		only(&compile(&src).warnings, pat),
		vec![format!("test.guide:{}: quest 9500 needs one of 9201 (The First Step), 783 (A Threat Within) turned in first, but the chain turns in none of them", line_of(&src, "  accept 9500"))]
	);
	// Accepting is not turning in.
	assert_eq!(only(&compile(&guide_text(&["step S", "  accept 783", "  accept 9500"])).warnings, "none of them").len(), 1);
	// Through a `next` chain.
	let one = "guide t/one\ntitle One\nlevels 1-5\nzone Elwynn Forest\nnext t/two\n\nstep S\n  accept 9201\n  turnin 9201\n";
	let two = "guide t/two\ntitle Two\nlevels 1-5\nzone Elwynn Forest\n\nstep S\n  accept 9500\n";
	assert!(only(&compile_map(&[("1.guide", one), ("2.guide", two)]).warnings, pat).is_empty());
}
