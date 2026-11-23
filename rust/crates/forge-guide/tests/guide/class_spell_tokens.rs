//! A class guide's own spells in its texts (docs/GUIDE_FORMAT.md, "Names in texts"): a spell of the
//! guide's class is its token even where an NPC, object or item has its name ("Cold Snap" is the Mage
//! talent in a Mage guide, not the staff), still behind the guide's own names and still words where a
//! one-word spell owns something; every other guide reads the name as before.
//! (tests/guide-texts-class-spells.test.js is the JS side.)

use crate::common;
use common::*;
use forge_guide::data::{Data, Raw};
use forge_guide::js::V;
use serde_json::json;

/// The fixture data with the Forever client's names for Cold Snap (item 19130), Ice Block (object 181247)
/// and Frostbite (item 19103), and the client's spell tables of build 1.60.1.70862 beside it: the Mage's
/// Cold Snap (12472), Ice Block (11958) and Frostbite (11071, its proc 12494), ClassMask 128.
fn class_data() -> Data {
	let root = scratch("class-spells");
	let wago = root.join("sources/wago/1.60.1.70862");
	std::fs::create_dir_all(&wago).unwrap();
	std::fs::write(wago.join("SpellName.csv"), "ID,Name_lang\n11071,Frostbite\n11958,\"Ice Block\"\n12472,\"Cold Snap\"\n12494,Frostbite\n").unwrap();
	std::fs::write(wago.join("SkillLineAbility.csv"), "ID,SkillLine,Spell,ClassMask\n6356,6,11958,128\n6742,6,12472,128\n6760,6,11071,128\n").unwrap();
	let mut t = tables();
	t["items"]["19103"] = json!({ "id": 19103, "name": "Frostbite", "drops": { "npc": {}, "object": {} }, "vendors": [] });
	t["items"]["19130"] = json!({ "id": 19130, "name": "Cold Snap", "drops": { "npc": {}, "object": {} }, "vendors": [] });
	t["objects"]["181247"] = json!({ "id": 181247, "name": "Ice Block", "spawns": {} });
	t["meta"]["sources"].as_array_mut().unwrap().push(json!({ "name": "World of Warcraft: Forever client tables (SpellName) via wago.tools", "revision": "wow_classic_beta 1.60.1.70862" }));
	let raw = Raw { tables: t.iter().map(|(k, x)| (k.clone(), v(x))).collect(), instances: V::Null, areas: V::Null };
	// The data folder as forward slashes: its client tables are found at <dir>/../sources.
	Data::new(raw, Some(root.join("forever").to_string_lossy().replace('\\', "/")), Vec::new())
}

/// A Class guide `t/<id>` with these header lines (each ending in "\n").
fn guide(id: &str, header: &str) -> String {
	let tip = "Cold Snap resets Ice Block, and Frostbite roots the target. Frostbite's chance grows.";
	format!("guide t/{id}\ntitle Test\ncategory Class\n{header}faction Alliance\nlevels 1-10\nzone Elwynn Forest\n\nstep Level 46: Cold Snap\n  tip {tip}\n  accept 7\n")
}

#[test]
fn a_class_guides_own_spells_are_their_tokens_where_an_npc_object_or_item_has_the_name_too_other_guides_read_them_as_before() {
	let mut files = [("mage", "class Mage\n"), ("notwarrior", "class !Warrior\n"), ("warrior", "class Warrior\n"), ("none", ""), ("staff", "class Mage\nreward item 19130\n")]
		.map(|(id, h)| (format!("{id}.guide"), guide(id, h)))
		.to_vec();
	let leveling = guide("leveling", "class Mage\n").replace("category Class", "category Leveling").replace("Frostbite's chance grows.", "Your Frostbite procs more often.");
	files.push(("leveling.guide".to_string(), leveling));
	let files: Vec<(&str, &str)> = files.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let r = compile_files(&files, &class_data(), None);
	assert!(r.errors.is_empty(), "{}", r.text);
	let step = |id: &str| {
		let s = r.guide(&format!("t/{id}")).hidden("_localised").get("steps").at(0);
		(s.get("title").to_js_string(), s.get("note").to_js_string())
	};
	let pair = |a: &str, b: &str| (a.to_string(), b.to_string());
	assert_eq!(step("mage"), pair("Level 46: {spell:12472}", "{spell:12472} resets {spell:11958}, and {spell:11071} roots the target. Frostbite's chance grows."));
	// Every class but the Warrior: the Mage's too.
	assert_eq!(step("notwarrior"), step("mage"));
	let before = pair("Level 46: {item:19130}", "{item:19130} resets {object:181247}, and Frostbite roots the target. Frostbite's chance grows.");
	assert_eq!(step("warrior"), before);
	assert_eq!(step("none"), before);
	// The guide's own names come first: its reward is the staff.
	assert_eq!(step("staff"), pair("Level 46: {item:19130}", "{item:19130} resets {spell:11958}, and {spell:11071} roots the target. Frostbite's chance grows."));
	// Outside a Class guide a one-word one only after "cast" or "your".
	assert_eq!(step("leveling"), pair("Level 46: {spell:12472}", "{spell:12472} resets {spell:11958}, and Frostbite roots the target. Your {spell:11071} procs more often."));
}
