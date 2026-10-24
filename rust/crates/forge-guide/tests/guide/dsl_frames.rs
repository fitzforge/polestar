//! Where coordinates land and in which map frame: drop-source and spawn ranking by zone/used maps/nearness,
//! the cross-zone warning, the `coords era|live` header and `era`/`live` goal modifiers, the frame-aware
//! 50-yard check, and empty quoted strings.

use crate::common;
use common::*;
use serde_json::{json, Value};

fn dun_morogh(body: &[&str], extra: &[&str]) -> String {
	let mut l = vec!["guide t/dm", "title Coldridge", "faction Alliance", "levels 1-6", "zone Dun Morogh"];
	l.extend_from_slice(extra);
	l.push("");
	l.extend_from_slice(body);
	guide_text(&l)
}

fn only(list: &[String], pat: &str) -> Vec<String> {
	list.iter().filter(|m| re(pat).is_match(m)).cloned().collect()
}

fn goal(r: &Compiled, step: usize, i: usize) -> Value {
	r.steps()[step]["goals"][i].clone()
}

#[test]
fn collect_in_dun_morogh_uses_the_dun_morogh_wolves_not_the_higher_chance_elwynn_ones() {
	// Tough Wolf Meat: Elwynn wolves 80%/40%, Dun Morogh wolves 30%.
	let r = compile(&dun_morogh(&["step S", "  accept 179", "  collect 750 quest 179"], &[]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = goal(&r, 0, 1);
	assert_eq!(g["map"], 1426);
	// Nearest Dun Morogh wolf to Sten Stoutarm (29.71,71.25): the Ragged Timber Wolf at 30,72.
	assert_eq!([&g["x"], &g["y"], &g["f"]], [&json!(30), &json!(72), &json!("e")]);
	assert!(only(&r.warnings, "never sets zone").is_empty());
}

#[test]
fn candidates_on_maps_the_guide_already_used_win_over_the_rest_of_the_world() {
	// The step zone (Durotar) has no wolves; Dun Morogh was used earlier, Elwynn never.
	let r = compile(&dun_morogh(&["step S", "  accept 179", "step T", "  zone Durotar", "  collect 750 quest 179"], &[]));
	assert_eq!(goal(&r, 1, 0)["map"], 1426);
}

#[test]
fn a_coordinate_on_a_map_the_guide_never_sets_as_zone_warns() {
	let src = dun_morogh(&["step S", "  kill 69", "  goto 10,10 map 1453", "  zone Stormwind City", "  talk 823"], &[]);
	let r = compile(&src);
	// `goto … map 1453` is fine (the guide sets zone Stormwind City later); `talk 823` (an Elwynn NPC) under
	// `zone Stormwind City` is not.
	assert_eq!(
		only(&r.warnings, "never sets zone"),
		vec![
			format!("test.guide:{}: coordinates on map 1429 (Elwynn Forest), but this step's zone is 1426 (Dun Morogh) and the guide never sets zone 1429; check the target, or add `zone map 1429` if the route really goes there", line_of(&src, "  kill 69")),
			format!("test.guide:{}: coordinates on map 1429 (Elwynn Forest), but this step's zone is 1453 (Stormwind City) and the guide never sets zone 1429; check the target, or add `zone map 1429` if the route really goes there", line_of(&src, "  talk 823")),
		]
	);
	// Setting the zone anywhere in the guide silences it.
	let ok = compile(&dun_morogh(&["step S", "  kill 69", "step T", "  zone Elwynn Forest", "  level 3"], &[]));
	assert!(only(&ok.warnings, "never sets zone").is_empty());
}

#[test]
fn typed_coordinates_on_a_zone_set_by_a_step_for_some_characters_only_warn_when_the_others_are_elsewhere() {
	let trip = ["step Trip", "  only Paladin", "  zone Stormwind City", "  goto 50,50"];
	let mut body = trip.to_vec();
	body.extend(["step Back", "  goto 30,72 \"Coldridge\"", "  goto 31,72 only Paladin", "  goto 32,72 map 1426"]);
	let src = dun_morogh(&body, &[]);
	let r = compile(&src);
	// The Paladins' own goal and the one with `map` are fine; the goal everyone sees is in Stormwind for the others.
	assert_eq!(
		only(&r.warnings, "sets in a step for"),
		vec![format!(
			"test.guide:{}: coordinates on Stormwind City, the zone line {} sets in a step for Paladin only; the others who see this goal are in Dun Morogh",
			line_of(&src, "  goto 30,72 \"Coldridge\""),
			line_of(&src, "  zone Stormwind City")
		)]
	);
	assert_eq!(goal(&r, 1, 0)["map"], 1453, "the zone in effect still holds (only the warning is new)");
	// A `zone` line after the trip, or a step only the trip's characters see, is fine.
	for extra in [["step Back", "  zone Dun Morogh", "  goto 30,72"], ["step More", "  only Paladin", "  goto 30,72"]] {
		let mut b = trip.to_vec();
		b.extend(extra);
		assert!(only(&compile(&dun_morogh(&b, &[])).warnings, "sets in a step for").is_empty());
	}
}

#[test]
fn hand_typed_coordinates_are_era_frame_by_default_coords_live_and_live_era_modifiers_override() {
	let fs = |src: String| compile(&src).steps()[0]["goals"].as_array().unwrap().iter().map(|g| g.get("f").cloned().unwrap_or(Value::Null)).collect::<Vec<_>>();
	assert_eq!(fs(dun_morogh(&["step S", "  goto 30,72", "  goto 31,72 live", "  kill 704 @30,72", "  explore 29,70 \"Coldridge Valley\""], &[])), [json!("e"), Value::Null, json!("e"), json!("e")]);
	assert_eq!(
		fs(dun_morogh(&["step S", "  goto 30,72", "  goto 31,72 era", "  kill 704", "  talk 9002"], &["coords live"])),
		[Value::Null, json!("e"), json!("e"), Value::Null],
		"data-resolved points keep their source frame"
	);
	assert_eq!(fs(dun_morogh(&["step S", "  goto 30,72"], &["coords era"]))[0], "e");
}

#[test]
fn coordinates_on_maps_without_era_bounds_compile_live_asking_for_era_there_warns() {
	// Durotar (1411) has Era bounds in the fixture; 9999 has none.
	let src = dun_morogh(&["step S", "  goto 50,50 map 9999", "  goto 50,50 map 9999 era"], &[]);
	let r = compile(&src);
	assert!(r.steps()[0]["goals"].as_array().unwrap().iter().all(|g| g.get("f").is_none()));
	assert_eq!(
		only(&r.warnings, "no Era bounds"),
		vec![format!("test.guide:{}: `era` coordinates on map 9999, but map-frames.json has no Era bounds for it; compiling them as live-frame", line_of(&src, "  goto 50,50 map 9999 era"))]
	);
}

#[test]
fn frame_modifiers_errors_for_bad_values_duplicates_and_use_without_explicit_coordinates() {
	let src = dun_morogh(&["step S", "  goto 1,1 era live", "  kill 704 live", "  turnin 179 era", "  level 2"], &["coords mixed"]);
	let at = |l: &str| line_of(&src, l);
	assert_eq!(
		compile(&src).errors,
		vec![
			format!("test.guide:{}: coords must be era or live, not \"mixed\"", at("coords mixed")),
			format!("test.guide:{}: duplicate `era`/`live`", at("  goto 1,1 era live")),
			format!("test.guide:{}: `live` only applies to explicit coordinates (@x,y)", at("  kill 704 live")),
			format!("test.guide:{}: `era` only applies to explicit coordinates (@x,y)", at("  turnin 179 era")),
			format!("test.guide:{}: `turnin` for quest 179 that is never accepted earlier in this guide or a guide chaining into it", at("  turnin 179 era")),
		]
	);
}

#[test]
fn the_50_yard_check_compares_explicit_coordinates_only_with_spawns_in_the_same_frame() {
	// Recorded Lookout (9002) has only a live-frame spawn at 30,30 in Elwynn.
	let elwynn = |body: &[&str], extra: &[&str]| {
		let mut l = vec!["guide t/e", "title E", "levels 1-5", "zone Elwynn Forest"];
		l.extend_from_slice(extra);
		l.push("");
		l.extend_from_slice(body);
		guide_text(&l)
	};
	let far = "  talk 9002 @60,60";
	assert!(only(&compile(&elwynn(&["step S", far], &[])).warnings, "explicit coordinates").is_empty(), "Era coordinates vs a live spawn: not comparable");
	assert_eq!(
		only(&compile(&elwynn(&["step S", far], &["coords live"])).warnings, "explicit coordinates"),
		["test.guide:8: explicit coordinates 60,60 are more than 50 yards from every known spawn of npc 9002"]
	);
	assert!(only(&compile(&elwynn(&["step S", "  talk 9002 @30.2,30.1"], &["coords live"])).warnings, "explicit coordinates").is_empty());
	// Era coordinates against Era spawns still warn when far.
	assert_eq!(only(&compile(&elwynn(&["step S", "  talk 823 @60,60"], &[])).warnings, "more than 50 yards").len(), 1);
}

#[test]
fn empty_quoted_strings_are_errors_at_their_line() {
	let src = guide_text(&["step S", "  kill \"\"", "  note \"\"", "  accept 7 \" \"", "  goto 1,1 \"\"", "  level 2", "step \"\"", "  level 3"]);
	let msg = "empty quoted string (names, titles, labels and notes need text)";
	let at = |l: &str| format!("test.guide:{}: {msg}", line_of(&src, l));
	assert_eq!(compile(&src).errors, vec![at("  kill \"\""), at("  note \"\""), at("  accept 7 \" \""), at("  goto 1,1 \"\""), at("step \"\"")]);
	let header = guide_text(&["guide t/h", "title \"\"", "levels 1-2", "zone Elwynn Forest", "", "step S", "  level 2"]);
	assert!(compile(&header).errors.contains(&format!("test.guide:2: {msg}")));
}

#[test]
fn collect_weighs_drop_chance_on_the_chosen_map_a_0_02_percent_mob_next_to_the_last_goal_loses_to_the_100_percent_node() {
	// Earthroot: Kobold Crate objects 100%, Kobold Vermin 0.02%. The goto stands on a Vermin spawn.
	let g = goal(&compile(&guide_text(&["step S", "  goto 49,32.4", "  collect 2449 x5"])), 0, 1);
	assert_eq!([&g["map"], &g["x"], &g["y"]], [&json!(1429), &json!(47), &json!(32)]);
	// Sources of similar chance still go by nearness (Young Wolf 40% vs Timber Wolf 80%).
	let w = goal(&compile(&guide_text(&["step S", "  goto 46.2,38.1", "  collect 750 x5"])), 0, 1);
	assert_eq!([&w["x"], &w["y"]], [&json!(46), &json!(38)]);
}

#[test]
fn the_50_yard_check_compares_collect_coordinates_with_real_sources_only_2_percent_droppers_and_gathering_nodes() {
	// Shadowgem: Lone Kobold 5% (80,20), Copper Vein 1% per node (30,30), Battered Chest 0.5% (70,70).
	let near = |at: &str| only(&compile(&guide_text(&["step S", &format!("  collect 1210 x1 @{at}")])).warnings, "explicit coordinates");
	assert!(near("30.1,30.1").is_empty(), "at the vein");
	assert!(near("80,20").is_empty(), "at the 5% dropper");
	assert_eq!(near("70,70").len(), 1, "a 0.5% chest is not a source to check against");
	// Any object dropping the item at 2% or more still counts (Earthroot: Kobold Crate at 100%).
	assert_eq!(only(&compile(&guide_text(&["step S", "  collect 2449 x1 @10,90"])).warnings, "explicit coordinates").len(), 1);
}
