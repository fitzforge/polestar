//! A class's own spells in its guides (#1504, #1505; tests/dsl-class-spells.test.js): a guide whose header
//! names the class tokenises them as that class's spells even where an item or object has the name ("Cold
//! Snap", "Ice Block") or the name is one word ("Frostbite"); `learn` of a class spell the client's
//! SkillLineAbility knows takes its name from SpellName, without the "not in data" warning.

use crate::common;
use common::*;
use forge_guide::data::load_data;
use serde_json::{json, Value};

const BUILD: &str = "1.60.1.1";

/// The fixture data with an item "Cold Snap" and an object "Ice Block", built from a Forever client build with
/// the Mage's spells.
fn class_data() -> forge_guide::data::Data {
	let root = scratch("class-spells");
	let dir = root.join("data");
	std::fs::create_dir_all(&dir).unwrap();
	for e in std::fs::read_dir(data_dir()).unwrap().flatten() {
		let name = e.file_name().to_string_lossy().into_owned();
		let mut x: Value = serde_json::from_slice(&std::fs::read(e.path()).unwrap()).unwrap();
		match name.as_str() {
			"items.json" => {
				x["19130"] = json!({ "id": 19130, "name": "Cold Snap", "drops": { "npc": {}, "object": {} }, "vendors": [] });
				x["19103"] = json!({ "id": 19103, "name": "Frostbite", "drops": { "npc": {}, "object": {} }, "vendors": [] });
			}
			"objects.json" => x["181247"] = json!({ "id": 181247, "name": "Ice Block", "spawns": {} }),
			"meta.json" => x["sources"].as_array_mut().unwrap().push(json!({ "name": "World of Warcraft: Forever client tables", "revision": BUILD, "url": "https://wago.tools" })),
			_ => {}
		}
		std::fs::write(dir.join(&name), x.to_string()).unwrap();
	}
	let wago = root.join("sources").join("wago").join(BUILD);
	std::fs::create_dir_all(&wago).unwrap();
	std::fs::write(wago.join("SpellName.csv"), "ID,Name_lang\n116,Frostbolt\n205,Frostbolt\n11958,Ice Block\n12472,Cold Snap\n11071,Frostbite\n100,Charge\n2259,Alchemy\n").unwrap();
	std::fs::write(wago.join("SkillLineAbility.csv"), "ID,SkillLine,Spell,ClassMask\n1,6,116,128\n2,6,205,128\n3,6,11958,128\n4,6,12472,128\n5,6,11071,128\n6,26,100,1\n7,171,2259,0\n").unwrap();
	load_data(&dir).unwrap()
}

fn header(cls: Option<&str>) -> Vec<String> {
	let mut h = vec!["guide t/mage".to_string(), "title Mage".into(), "category Class".into()];
	if let Some(c) = cls {
		h.push(format!("class {c}"));
	}
	h.extend(["faction Alliance".into(), "levels 40-50".into(), "zone Elwynn Forest".into(), String::new()]);
	h
}

const STEPS: [&str; 7] = ["step Level 44: Ice Block", "  tip Take Ice Block now, then Frostbite.", "  level 45", "", "step Level 46: Cold Snap", "  tip Cold Snap resets your Frost cooldowns.", "  level 47"];

fn text(cls: Option<&str>, body: &[&str]) -> String {
	let mut l = header(cls);
	l.extend(body.iter().map(|s| s.to_string()));
	format!("{}\n", l.join("\n"))
}

#[test]
fn a_mage_guide_tokenises_its_spells_not_the_item_or_object_of_that_name() {
	let data = class_data();
	let r = compile_with(&text(Some("Mage"), &STEPS), &data);
	assert!(r.errors.is_empty(), "{}", r.text);
	let loc = r.guides[0].hidden("_localised");
	let s: Vec<Value> = plain(&loc.get("steps")).as_array().unwrap().clone();
	assert_eq!(s[0]["title"], json!("Level 44: {spell:11958}"));
	assert_eq!(s[1]["title"], json!("Level 46: {spell:12472}"));
	let all = serde_json::to_string(&s).unwrap();
	assert!(all.contains("Take {spell:11958} now, then {spell:11071}."), "{all}");
	assert!(all.contains("{spell:12472} resets your Frost cooldowns."), "{all}");
	let names = plain(&loc.get("names"));
	assert_eq!([&names["spell:12472"], &names["spell:11071"]], [&json!("Cold Snap"), &json!("Frostbite")]);
}

#[test]
fn another_class_or_no_class_keeps_the_worlds_names() {
	let data = class_data();
	for cls in [Some("Warrior"), None] {
		let r = compile_with(&text(cls, &STEPS), &data);
		let s: Vec<Value> = plain(&r.guides[0].hidden("_localised").get("steps")).as_array().unwrap().clone();
		assert_eq!(s[1]["title"], json!("Level 46: {item:19130}"), "{cls:?}");
		let all = serde_json::to_string(&s).unwrap();
		assert!(!["{spell:11958}", "{spell:12472}", "{spell:11071}"].iter().any(|t| all.contains(t)), "{cls:?}: {all}");
	}
}

#[test]
fn learn_of_a_class_spell_takes_the_clients_name_without_the_not_in_data_warning() {
	let data = class_data();
	let ok = compile_with(&text(Some("Mage"), &["step Train", "  learn 116 optional", "  learn 205 \"Frostbolt\" optional"]), &data);
	assert!(ok.errors.is_empty(), "{}", ok.text);
	assert!(ok.warned("not in data").is_empty(), "{}", ok.text);
	assert_eq!(ok.steps()[0]["goals"][0]["spellName"], json!("Frostbolt"));
	let unknown = compile_with(&text(Some("Mage"), &["step Train", "  learn 99999 \"Made Up\" optional"]), &data);
	assert_eq!(unknown.warned("spell 99999 is not in data").len(), 1, "{}", unknown.text);
}
