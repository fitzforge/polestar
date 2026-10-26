//! The .guide parser (parse.rs): docs/GUIDE_FORMAT.md syntax, with an error at the right line for every
//! malformed construct. (Port of the JS dsl.test.js; each JS test is one Rust test, the table-driven ones
//! one test over the table.)

use crate::common;
use common::*;
use forge_guide::conditions::{applicable, mask_excludes, race_sides};
use forge_guide::js::parse_json;
use serde_json::{json, Value};

/// parseGuide on `x.guide` -> (ast plain, errors, warnings) as "line: message".
fn parse3(text: &str) -> (Value, Vec<String>, Vec<String>) {
	let (ast, diag) = parse_all(text, "x.guide");
	let sorted = diag.sorted();
	let pick = |sev: &str| sorted.iter().filter(|d| d.severity == sev).map(at_line).collect::<Vec<_>>();
	(plain(&ast), pick("error"), pick("warning"))
}

fn goals(ast: &Value) -> Vec<Value> {
	ast["steps"].as_array().unwrap().iter().flat_map(|s| s["goals"].as_array().cloned().unwrap_or_default()).collect()
}

#[test]
fn the_guide_format_md_example_parses_without_errors_into_the_documented_structure() {
	let doc = std::fs::read_to_string(repo().join("docs/GUIDE_FORMAT.md")).unwrap();
	let example = re(r"```\n(guide [\s\S]*?)```").captures(&doc).unwrap()[1].to_string();
	let (ast, errors, warnings) = parse3(&example);
	assert!(errors.is_empty() && warnings.is_empty(), "{errors:?} {warnings:?}");
	assert_eq!(ast["id"], "joe-routes/northshire");
	assert_eq!(ast["header"]["levels"], json!({ "min": 1, "max": 6 }));
	assert_eq!(ast["header"]["faction"], "Alliance");
	assert_eq!(ast["header"]["races"], json!(["Human"]));
	assert_eq!(ast["header"]["next"], json!(["joe-routes/elwynn"]));
	assert_eq!(ast["header"]["zone"]["name"], "Elwynn Forest");
	let steps: Vec<Value> = ast["steps"].as_array().unwrap().iter().map(|s| json!([s["title"], s["goals"].as_array().unwrap().len()])).collect();
	assert_eq!(steps, [json!(["Deputy Willem", 5]), json!(["Kobold camp", 2]), json!(["Back to the abbey", 3])]);
	assert_eq!(ast["steps"][1]["tip"], "Pull one kobold at a time until level 3.");
	let g = goals(&ast);
	assert_eq!(g.iter().map(|x| x["verb"].as_str().unwrap()).collect::<Vec<_>>(), ["accept", "turnin", "accept", "accept", "accept", "kill", "collect", "turnin", "train", "level"]);
	assert_eq!(g[0]["note"], "He stands at the abbey gate");
	assert_eq!(g[3]["quest"], 33);
	assert_eq!(g[4]["npc"], 196);
	assert_eq!(json!([g[5]["npc"], g[5]["count"], g[5]["quest"], g[5]["oi"]]), json!([6, 10, 7, 1]));
	assert_eq!(json!([g[6]["item"], g[6]["count"], g[6]["quest"], g[6]["oi"], g[6]["optional"]]), json!([750, 8, 33, 1, true]));
	assert_eq!(g[8]["only"], json!({ "classes": ["WARRIOR", "PALADIN"], "races": null, "factions": null }));
	assert_eq!(g[8]["note"], "Llane Beshere is inside the abbey");
	assert_eq!(g[9]["level"], 4);
}

/// Each malformed line is placed inside an otherwise valid guide; the parser must report exactly one error,
/// on that line.
const MALFORMED: [(&str, &str); 34] = [
	("  fight 6", r#"unknown verb "fight""#),
	("  kill 6 loudly", r#"unknown modifier "loudly""#),
	("  accept 78x", r#"malformed quest id "78x""#),
	("  accept 0", r#"malformed quest id "0""#),
	("  goto 47.6;35.1", r#"malformed coordinates "47\.6;35\.1""#),
	("  goto \"Camp\"", r"needs coordinates"),
	("  kill 6 @", r"expected coordinates"),
	("  kill 6 @50", r#"malformed coordinates "50""#),
	("  accept 7 \"Kobold", r"unterminated string"),
	("  accept 7 \"a\\q\"", r"unknown escape \\q"),
	("  accept 7 \"x\"y", r"after closing quote"),
	("  accept 7 ab\"c\"", r"quote must start a new token"),
	("  kill 6 quest 7.x", r#"malformed quest link "7\.x""#),
	("  kill 6 quest 7.0", r#"malformed quest link "7\.0""#),
	("  turnin 7 lvl 3", r"`lvl` does not apply to `turnin`"),
	("  goto 1,2 @3,4", r"`@x,y` does not apply to `goto`"),
	("  kill 6 x3 x4", r"duplicate `xN`"),
	("  kill 6 x0", r#"malformed count "x0""#),
	("  kill 6 npc 7", r"`npc` already given positionally"),
	("  kill 6 r -3", r"malformed radius"),
	("  kill 6 r 0.004", r#"radius "0\.004" rounds to 0 in the pack"#),
	("  kill 6 map abc", r#"malformed map id "abc""#),
	("  train only !Human", r"only classes can be negated"),
	("  train only Warrior,,Mage", r"empty condition"),
	("  level three", r#"malformed level "three""#),
	("  sethome", r#"needs a "Location""#),
	("  note", r"`note` needs text"),
	("  -- a note with no goal", r"note must follow a goal"),
	("  accept 7 -- ", r"empty ` -- ` note"),
	("  zone map x", r"malformed `zone map <uiMapID>`"),
	("  only", r"`only` needs a condition list"),
	("  tip", r"`tip` needs text"),
	("  \"quoted\"", r"expected a verb, found a string"),
	("bogus line", r"unexpected `bogus` in column 0"),
];

#[test]
fn malformed_goal_line_reports_its_line() {
	for (line, pat) in MALFORMED {
		let text = guide_text(&["step One", "  accept 7", line, "  turnin 7"]);
		let (_, errors, _) = parse3(&text);
		let ln = text.split('\n').position(|l| l == line).unwrap() + 1;
		assert_eq!(errors.len(), 1, "{line}: {errors:?}");
		assert!(errors[0].starts_with(&format!("{ln}: ")), "{line}: {}", errors[0]);
		assert_match(&errors[0], pat);
	}
}

const HEADER_ERRORS: [(&[&str], &str, &str); 24] = [
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "title B", "step S", "  level 2"], "title B", r"duplicate header key `title` \(first on line 2\)"),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "colour red", "step S", "  level 2"], "colour red", r#"unknown header key "colour""#),
	(&["guide t/a", "title A", "levels 6-5", "zone Elwynn Forest", "step S", "  level 2"], "levels 6-5", r#"malformed levels "6-5""#),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "faction Scourge", "step S", "  level 2"], "faction Scourge", r"faction must be Alliance or Horde"),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "class Warrior,Human", "step S", "  level 2"], "class Warrior,Human", r#"unknown class "Human""#),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "race Human,Mage", "step S", "  level 2"], "race Human,Mage", r#""Mage" is a class"#),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "version 1.5", "step S", "  level 2"], "version 1.5", r"version must be an integer"),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "next Not A Valid Id", "step S", "  level 2"], "next Not A Valid Id", r"malformed guide id"),
	(&["guide T/Upper", "title A", "levels 1-5", "zone Elwynn Forest", "step S", "  level 2"], "guide T/Upper", r#"malformed guide id "T/Upper""#),
	(&["guide forever/alliance/", "title A", "levels 1-5", "zone Elwynn Forest", "step S", "  level 2"], "guide forever/alliance/", r#"malformed guide id "forever/alliance/""#),
	(&["guide /forever", "title A", "levels 1-5", "zone Elwynn Forest", "step S", "  level 2"], "guide /forever", r#"malformed guide id "/forever""#),
	(&["guide a//b", "title A", "levels 1-5", "zone Elwynn Forest", "step S", "  level 2"], "guide a//b", r#"malformed guide id "a//b""#),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "next t/b/", "step S", "  level 2"], "next t/b/", r#"malformed guide id "t/b/" in `next`"#),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "  level 1", "step S", "  level 2"], "  level 1", r"indented line before the first `step`"),
	(&["guide t/a", "title A -- note", "levels 1-5", "zone Elwynn Forest", "step S", "  level 2"], "title A -- note", r"only allowed on goal lines"),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "step Empty", "step S", "  level 2"], "step Empty", r"step has no goals"),
	(&["title A", "guide t/a", "levels 1-5", "zone Elwynn Forest", "step S", "  level 2"], "title A", r"must start with `guide <id>`"),
	(&["guide t/a", "levels 1-5", "zone Elwynn Forest", "step S", "  level 2"], "guide t/a", r"missing required header `title`"),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest"], "guide t/a", r"guide has no steps"),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "keywords horse, , pinto", "step S", "  level 2"], "keywords horse, , pinto", r"`keywords` has an empty entry"),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "folder", "step S", "  level 2"], "folder", r"`folder` needs a value"),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "folder A", "folder B", "step S", "  level 2"], "folder B", r"duplicate header key `folder`"),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "collects 2414, x5655", "step S", "  level 2"], "collects 2414, x5655", r#"malformed item id "x5655" in `collects`"#),
	(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "collects 2414,2414", "step S", "  level 2"], "collects 2414,2414", r"`collects` names the same item twice"),
];

#[test]
fn header_structure_error_reports_its_line() {
	for (lines, at, pat) in HEADER_ERRORS {
		let text = format!("{}\n", lines.join("\n"));
		let (_, errors, _) = parse3(&text);
		assert_eq!(errors.len(), 1, "{pat}: {errors:?}");
		assert!(errors[0].starts_with(&format!("{}: ", line_of(&text, at))), "{pat}: {}", errors[0]);
		assert_match(&errors[0], pat);
	}
}

#[test]
fn several_errors_in_one_file_are_all_reported_each_at_its_own_line() {
	let text = guide_text(&["step One", "  fight 1", "  accept 7", "  kill 6 x", "  goto 1;2"]);
	let lines: Vec<usize> = parse3(&text).1.iter().map(|e| e.split(':').next().unwrap().parse().unwrap()).collect();
	assert_eq!(lines, [line_of(&text, "  fight 1"), line_of(&text, "  kill 6 x"), line_of(&text, "  goto 1;2")]);
}

#[test]
fn comments_notes_and_quotes_follow_the_lexical_rules() {
	let text = guide_text(&[
		"guide t/a",
		"title C#Sharp is not a comment",
		"levels 1-5",
		"zone Elwynn Forest # comment after a header value",
		"",
		"step One # the step title stops here",
		"  # whole-line comment",
		"  accept 7 # trailing comment",
		"  goto 1,2 \"camp # not a comment\"",
		"  accept 33 -- see #2, it -- stays",
		"  accept 5261 \"Say \\\"hi\\\" \\\\ bye\"",
		"  turnin 7 \"x -- y\"",
	]);
	let (ast, errors, _) = parse3(&text);
	assert!(errors.is_empty(), "{errors:?}");
	assert_eq!(ast["header"]["title"], "C#Sharp is not a comment");
	assert_eq!(ast["header"]["zone"]["name"], "Elwynn Forest");
	assert_eq!(ast["steps"][0]["title"], "One");
	let g = goals(&ast);
	assert_eq!(g.len(), 5);
	assert!(g[0].get("note").is_none());
	assert_eq!(g[1]["text"], "camp # not a comment");
	assert_eq!(g[2]["note"], "see #2, it -- stays");
	assert_eq!(g[3]["title"], "Say \"hi\" \\ bye");
	assert_eq!(g[4]["title"], "x -- y");
	assert!(g[4].get("note").is_none());
}

#[test]
fn keywords_are_case_insensitive_and_coordinates_accept_the_documented_spellings() {
	let (ast, errors, _) =
		parse3(&guide_text(&["STEP One", "  ACCEPT 7 NPC 197 Optional", "  Kill 6 @47.6,35.1", "  kill 6 @ 47.6,35.1", "  kill 6 @47.6, 35.1", "  kill 6 @47.6 ,35.1 map 1453 r 12.5"]));
	assert!(errors.is_empty(), "{errors:?}");
	let g = goals(&ast);
	assert_eq!(json!([g[0]["verb"], g[0]["npc"], g[0]["optional"]]), json!(["accept", 197, true]));
	for k in 1..=4 {
		assert_eq!(json!([g[k]["x"], g[k]["y"]]), json!([47.6, 35.1]));
	}
	assert_eq!(json!([g[4]["coordMap"], g[4]["r"]]), json!([1453, 12.5]));
}

#[test]
fn note_text_is_the_rest_of_the_line_unless_quoted_and_quoted_notes_take_modifiers() {
	let (ast, errors, _) = parse3(&guide_text(&["step One", "  note Watch out for \"Hogger\" here -- really", "  note \"Mind the guards\" only !Hunter @ 42.5,64"]));
	assert!(errors.is_empty(), "{errors:?}");
	let g = goals(&ast);
	assert_eq!(g[0]["text"], "Watch out for \"Hogger\" here");
	assert_eq!(g[0]["note"], "really");
	assert_eq!(g[1]["text"], "Mind the guards");
	assert_eq!(json!([g[1]["x"], g[1]["y"]]), json!([42.5, 64]));
	let classes = g[1]["only"]["classes"].as_array().unwrap();
	assert_eq!(classes.len(), 8);
	assert!(!classes.contains(&json!("HUNTER")));
}

#[test]
fn conditions_classes_races_factions_negation_and_unknown_races() {
	let text = guide_text(&["step One", "  only Warrior, Paladin,Dwarf", "  train only !Hunter,!Mage", "  train only Undead,Horde", "  train only Skyborne", "  train only Haranir"]);
	let (ast, errors, warnings) = parse3(&text);
	assert!(errors.is_empty(), "{errors:?}");
	assert_eq!(ast["steps"][0]["only"], json!({ "classes": ["WARRIOR", "PALADIN"], "races": ["Dwarf"], "factions": null }));
	let g = goals(&ast);
	// Negations OR together: "not Hunter" or "not Mage" admits everyone.
	assert_eq!(g[0]["only"]["classes"].as_array().unwrap().len(), 9);
	assert_eq!(g[1]["only"], json!({ "classes": null, "races": ["Scourge"], "factions": ["Horde"] }));
	assert_eq!(g[2]["only"]["races"], json!(["Skyborne"]));
	assert_eq!(g[3]["only"]["races"], json!(["Haranir"]));
	assert_eq!(warnings.len(), 1);
	assert!(warnings[0].starts_with(&format!("{}: unknown race \"Haranir\"", line_of(&text, "  train only Haranir"))), "{}", warnings[0]);
}

#[test]
fn skyborne_plays_on_both_sides_the_faction_picks_its_quest_mask_bit_era_only_masks_never_exclude_it() {
	assert_eq!(race_sides("Skyborne"), ["Alliance", "Horde"]);
	let set = |j: &str| applicable(&[parse_json(j).unwrap()]);
	let horde = set(r#"{"factions":["Horde"],"races":["Skyborne"]}"#);
	let alliance = set(r#"{"factions":["Alliance"],"races":["Skyborne"]}"#);
	assert_eq!([plain(&horde.get("races")), plain(&alliance.get("races"))], [json!(["Skyborne"]), json!(["Skyborne"])]);
	let q = |races: f64| parse_json(&format!(r#"{{"races":{races},"classes":null,"source":["questie-forever"]}}"#)).unwrap();
	assert_eq!(mask_excludes(&horde, &q(2f64.powi(33))), None);
	assert_eq!(mask_excludes(&horde, &q(2f64.powi(32))), Some("race"));
	assert_eq!(mask_excludes(&alliance, &q(2f64.powi(32) + 1.0)), None);
	assert_eq!(mask_excludes(&alliance, &q(1.0)), Some("race"));
	assert_eq!(mask_excludes(&alliance, &parse_json(r#"{"races":1,"classes":null,"source":["pfquest"]}"#).unwrap()), None, "pfQuest masks are Era masks");
	assert_eq!(mask_excludes(&set(r#"{"races":["Human"]}"#), &q(2f64.powi(32) + 1.0)), None);
}

#[test]
fn the_race_table_agrees_with_the_forever_client() {
	let Some(dir) = reference_data("races.json") else { return };
	let races: Value = serde_json::from_slice(&std::fs::read(dir.join("races.json")).unwrap()).unwrap();
	let from_data: serde_json::Map<String, Value> =
		races.as_object().unwrap().iter().map(|(file, sides)| (file.clone(), Value::Object(sides.as_object().unwrap().iter().map(|(s, v)| (s.clone(), v["bit"].clone())).collect()))).collect();
	let from_table: serde_json::Map<String, Value> = forge_guide::races::RACE_FILES.iter().map(|f| (f.to_string(), plain(&forge_guide::races::race_by_file(f).get("sides")))).collect();
	assert_eq!(Value::Object(from_table), Value::Object(from_data));
}

#[test]
fn zone_directives_are_sticky_across_later_steps_the_header_zone_applies_before_them() {
	let (ast, errors, _) = parse3(&guide_text(&["step One", "  level 2", "  zone Stormwind City", "  level 3", "step Two", "  level 4", "  zone map 1411", "  level 5"]));
	assert!(errors.is_empty(), "{errors:?}");
	let zones: Vec<Value> = goals(&ast).iter().map(|g| g["zone"].get("name").cloned().unwrap_or_else(|| g["zone"]["map"].clone())).collect();
	assert_eq!(zones, [json!("Elwynn Forest"), json!("Stormwind City"), json!("Stormwind City"), json!(1411)]);
}

#[test]
fn folder_and_keywords_the_folder_is_the_rest_of_the_line_keywords_split_on_commas_repeats_warn_and_drop() {
	let text = guide_text(&["guide t/a", "title A", "levels 1-5", "zone Elwynn Forest", "folder Mounts · Level 40", "keywords Pinto Bridle, chestnut mare,pinto bridle", "step S", "  level 2"]);
	let (ast, errors, warnings) = parse3(&text);
	assert!(errors.is_empty(), "{errors:?}");
	assert_eq!(ast["header"]["folder"], "Mounts · Level 40");
	assert_eq!(ast["header"]["keywords"], json!(["Pinto Bridle", "chestnut mare"]));
	assert_eq!(warnings.len(), 1);
	assert!(warnings[0].starts_with(&format!("{}: `keywords` lists \"pinto bridle\" twice", line_of(&text, "keywords Pinto Bridle, chestnut mare,pinto bridle"))), "{}", warnings[0]);
}
