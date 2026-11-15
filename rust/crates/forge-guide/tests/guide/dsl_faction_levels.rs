//! `levels <min>-<max> Alliance|Horde` (docs/GUIDE_FORMAT.md, "Header"): a guide both factions play gives each the
//! levels its route brings it there at. The parser's checks, the resolver's `factionLevels` (the plain range stands in
//! for a faction without its own; minLevel/maxLevel span them all), the emitted table and import data, and the
//! experimental index. Fixture data: tests/fixtures/dsl/data.

use crate::common;
use common::*;
use serde_json::json;

/// A guide `t/a` with `head` as its header lines after the title (no `levels` of its own).
fn guide(head: &[&str]) -> String {
	let mut l = vec!["guide t/a", "title A"];
	l.extend_from_slice(head);
	l.extend_from_slice(&["zone Elwynn Forest", "", "step One", "  accept 783", "step Two", "  turnin 783"]);
	format!("{}\n", l.join("\n"))
}

#[test]
fn levels_per_faction_compile_to_faction_levels_with_min_and_max_level_spanning_both() {
	let r = compile(&guide(&["levels 45-46 Alliance", "levels 47-48 Horde"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = plain(&r.guides[0]);
	assert_eq!(g["factionLevels"], json!({ "Alliance": { "min": 45, "max": 46 }, "Horde": { "min": 47, "max": 48 } }));
	assert_eq!((g["minLevel"].clone(), g["maxLevel"].clone()), (json!(45), json!(48)), "an older Polestar shows the span");
	assert_match(&emit(&r.guides), r"\n\t\t\tminLevel = 45,\n\t\t\tmaxLevel = 48,\n\t\t\tfactionLevels = \{ Alliance = \{ min = 45, max = 46 \}, Horde = \{ min = 47, max = 48 \} \},\n");
	// An import string carries the same (Core/Import.lua reads it).
	assert_eq!(plain(&forge_guide::emit::guide_data(&r.guides[0]))["factionLevels"], json!({ "Alliance": { "max": 46, "min": 45 }, "Horde": { "max": 48, "min": 47 } }));
}

#[test]
fn a_plain_levels_line_is_the_range_of_the_faction_without_its_own() {
	let r = compile(&guide(&["levels 43-45", "levels 47-48 Horde"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = plain(&r.guides[0]);
	assert_eq!(g["factionLevels"], json!({ "Alliance": { "min": 43, "max": 45 }, "Horde": { "min": 47, "max": 48 } }));
	assert_eq!((g["minLevel"].clone(), g["maxLevel"].clone()), (json!(43), json!(48)));
}

#[test]
fn a_plain_levels_guide_compiles_as_before_without_faction_levels() {
	let r = compile(&guide(&["levels 43-45"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = plain(&r.guides[0]);
	assert_eq!(g.get("factionLevels"), None);
	assert_eq!((g["minLevel"].clone(), g["maxLevel"].clone()), (json!(43), json!(45)));
	assert_no_match(&emit(&r.guides), "factionLevels");
}

#[test]
fn each_misuse_of_faction_levels_is_one_error_on_its_line() {
	let cases: [(&[&str], &str, &str); 7] = [
		(&["levels 45-46 Alliance"], "levels 45-46 Alliance", r"`levels` for one faction only: add `levels <min>-<max> Horde`"),
		(&["levels 47-48 Horde"], "levels 47-48 Horde", r"add `levels <min>-<max> Alliance`"),
		(&["faction Horde", "levels 47-48 Horde"], "levels 47-48 Horde", r"a guide for one faction \(`faction Horde`\) has one level range"),
		(&["levels 45-46 Alliance", "levels 47-48 Horde", "levels 43-45"], "levels 43-45", r"plain `levels` is unused"),
		(&["levels 45-46 Alliance", "levels 47-48 Horde", "levels 44-46 Alliance"], "levels 44-46 Alliance", r"duplicate `levels \.\.\. Alliance` \(first on line 3\)"),
		(&["levels 43-45", "levels 44-46"], "levels 44-46", r"duplicate header key `levels` \(first on line 3\)"),
		(&["levels 45-46 Orcs", "levels 47-48"], "levels 45-46 Orcs", r#"`levels` names a faction: Alliance or Horde, not "Orcs""#),
	];
	for (head, at, pat) in cases {
		let text = guide(head);
		let (_, errors) = parse(&text);
		assert_eq!(errors.len(), 1, "{head:?}: {errors:?}");
		let ln = line_of(&text, at);
		assert!(errors[0].starts_with(&format!("{ln}: ")), "{head:?}: {}", errors[0]);
		assert_match(&errors[0], pat);
	}
	let (_, errors) = parse(&guide(&["levels 46-45 Horde", "levels 1-2"]));
	assert!(errors.iter().any(|e| e.contains(r#"malformed levels "46-45 Horde""#)), "{errors:?}");
}
