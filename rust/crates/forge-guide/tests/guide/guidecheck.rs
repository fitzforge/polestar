//! guidecheck (guidecheck.rs, guidecheck_repair.rs): each rule on the case the 2026-10-21 playable audit
//! quotes, failing as written and passing once the repair has run (travel and continent: once the travel line
//! is there; the writer's travel pass writes it). Fixture data: tests/fixtures/guidecheck/data, cut from the
//! Forever data.

use crate::common::*;
use forge_guide::data::{load_data, Data};
use forge_guide::guidecheck::{check_files, find_chains, Fix, Kb, KbStep, Reported};
use forge_guide::guidecheck_repair::{repair_chain, stable_sort, Repaired};

fn data() -> Data {
	load_data(&repo().join("tests/fixtures/guidecheck/data")).unwrap()
}

fn guide(faction: &str, zone: &str, steps: &[&str]) -> String {
	format!("guide t/gc\ntitle T\nfaction {faction}\nlevels 1-20\nzone {zone}\n\n{}\n", steps.join("\n\n"))
}

fn orc(steps: &[&str]) -> String {
	guide("Horde", "Durotar", steps)
}

const VANQUISH: [&str; 2] = ["step Gar'Thok\n  accept 784", "step Kul Tiras\n  kill 3128 x10 quest 784.1\n  kill 3129 x8 quest 784.2"];

fn files(text: &str) -> Vec<(String, String)> {
	vec![("01-t.guide".into(), text.into())]
}

fn rules(f: &[Reported]) -> Vec<&'static str> {
	f.iter().map(|x| x.rule).collect()
}

fn check(text: &str) -> Vec<Reported> {
	check_files(&files(text), &data(), None).1
}

fn repaired(text: &str, kb: Option<&Kb>) -> (Repaired, String) {
	let r = repair_chain(&files(text), &data(), kb, 4);
	let t = r.texts[0].1.clone();
	(r, t)
}

fn fix(name: &str, args: &[i64]) -> Option<Fix> {
	Some(Fix { name: name.into(), args: args.to_vec() })
}

fn pos(t: &str, s: &str) -> usize {
	t.find(s).unwrap_or_else(|| panic!("no {s} in:\n{t}"))
}

#[test]
fn item_start_the_aged_envelope_accepted_before_the_chest_that_holds_it_the_repair_gets_it_first() {
	let mut steps = VANQUISH.to_vec();
	steps.extend(["step Aged Envelope\n  accept 830", "step Tiragarde Keep\n  kill 3192 quest 784.3", "step Gar'Thok\n  turnin 784\n  turnin 830"]);
	let text = orc(&steps);
	let before = check(&text);
	assert_eq!(rules(&before), ["itemStart"]);
	assert_eq!(before[0].fix.as_ref().unwrap().name, "source");
	let (r, t) = repaired(&text, None);
	assert!(rules(&r.after).is_empty(), "{t}");
	assert!(pos(&t, "collect 4881") < pos(&t, "accept 830"), "{t}");
	assert_match(&t, r"step Aged Envelope \(from Benedict's Chest\)\n {2}collect 4881 @\d");
}

#[test]
fn item_start_lakotamani_accepted_as_required_its_item_from_a_lone_wandering_kodo_the_repair_waits_on_when_has() {
	let text = guide("Horde", "The Barrens", &["step Lakota'mani\n  accept 883", "step Thunder Bluff\n  turnin 883"]);
	let before = check(&text);
	assert_eq!(rules(&before), ["itemStart"]);
	assert_eq!(before[0].fix, fix("whenhas", &[5099]));
	let (r, t) = repaired(&text, None);
	assert!(rules(&r.after).is_empty(), "{t}");
	assert_match(&t, r"when has 5099\n {2}accept 883");
}

#[test]
fn giver_veteran_uzzek_several_givers_and_none_named_the_repair_names_the_one_at_the_routes_point() {
	let text = orc(&["step Razor Hill\n  goto 52.5,43.0 \"Razor Hill\"", "step Torm Ragetotem\n  accept 1505"]);
	assert_eq!(rules(&check(&text)), ["giver"]);
	let (r, t) = repaired(&text, None);
	assert!(rules(&r.after).is_empty(), "{t}");
	assert_match(&t, r"accept 1505 npc 3169\n");
}

#[test]
fn ender_a_quest_two_npcs_take_with_none_named_the_repair_names_one() {
	let text = guide("Alliance", "Stormwind City", &["step Library\n  accept 82208\n  turnin 82208"]);
	assert_eq!(rules(&check(&text)), ["ender"]);
	let (r, t) = repaired(&text, None);
	assert!(rules(&r.after).is_empty(), "{t}");
	assert_match(&t, r"turnin 82208 npc 2110(22|33)");
}

#[test]
fn objective_westfall_stew_turned_in_with_the_murloc_eyes_never_worked_the_repair_adds_the_goal() {
	let text = guide(
		"Alliance",
		"Westfall",
		&["step Salma Saldean\n  accept 38", "step Westfall Stew\n  collect 729 x3 quest 38.1\n  collect 731 x3 quest 38.3\n  collect 732 x3 quest 38.4", "step Salma Saldean\n  turnin 38"],
	);
	let before = check(&text);
	assert_eq!(before.iter().map(|f| (f.rule, f.args[1])).collect::<Vec<_>>(), [("objective", 2)]);
	let (r, t) = repaired(&text, None);
	assert!(rules(&r.after).is_empty(), "{t}");
	assert!(pos(&t, "collect 730 x3 quest 38.2") < pos(&t, "turnin 38"), "{t}");
}

#[test]
fn bag_before_flasks_of_oil_bagged_long_before_keeper_of_the_flame_is_taken_the_repair_puts_them_after_the_accept() {
	let text = guide("Alliance", "Westfall", &["step Coast\n  collect 814 x5 optional", "step Salma Saldean\n  accept 38", "step Captain Grayson\n  accept 103\n  turnin 103"]);
	let before = rules(&check(&text));
	assert!(before.contains(&"bagBefore") && before.contains(&"objective"), "{before:?}");
	let (r, t) = repaired(&text, None);
	assert!(rules(&r.after).is_empty(), "{t}");
	assert!(pos(&t, "accept 103") < pos(&t, "collect 814") && t.rfind("collect 814").unwrap() < pos(&t, "turnin 103"), "{t}");
}

#[test]
fn use_before_an_item_used_before_the_line_that_gets_it_the_repair_copies_the_collect_before_the_use() {
	let text = guide("Alliance", "Westfall", &["step Coast\n  use 730", "step Murlocs\n  collect 730 x3 @40.0,15.0"]);
	let before = check(&text);
	assert_eq!(rules(&before), ["useBefore"]);
	assert_eq!(before[0].fix.as_ref().unwrap().name, "copy");
	let (r, t) = repaired(&text, None);
	assert!(rules(&r.after).is_empty(), "{t}");
	assert!(pos(&t, "collect 730 x3") < pos(&t, "use 730"), "{t}");
}

#[test]
fn unsourced_an_apple_treats_thunder_applejack_nothing_gives_reported_for_the_route_not_written() {
	let text = guide("Alliance", "Elwynn Forest", &["step Elwynn\n  accept 91738", "step Still\n  collect 247824 quest 91738.1", "step Elwynn\n  turnin 91738"]);
	let before = check(&text);
	assert_eq!(rules(&before), ["unsourced"]);
	assert_eq!(before[0].fix.as_ref().unwrap().name, "leaveout");
	assert_eq!(rules(&repaired(&text, None).0.after), ["unsourced"]);
}

#[test]
fn kb_step_a_turnin_whose_knowledge_base_step_has_no_line_the_repair_adds_it() {
	let text = guide(
		"Alliance",
		"Westfall",
		&[
			"step Salma Saldean\n  accept 38",
			"step Westfall Stew\n  collect 729 x3 quest 38.1\n  collect 730 x3 quest 38.2\n  collect 731 x3 quest 38.3\n  collect 732 x3 quest 38.4",
			"step Salma Saldean\n  turnin 38",
		],
	);
	let kb: Kb = [(38, vec![KbStep { n: 1, action: "use-item".into(), kind: Some("item".into()), target: None, item: Some(814) }])].into_iter().collect();
	assert_eq!(rules(&check_files(&files(&text), &data(), Some(&kb)).1), ["kbStep"]);
	let (r, t) = repaired(&text, Some(&kb));
	assert!(rules(&r.after).is_empty(), "{t}");
	assert!(pos(&t, "collect 814") < pos(&t, "use 814") && pos(&t, "use 814") < pos(&t, "turnin 38"), "{t}");
}

#[test]
fn no_accept_a_turnin_of_a_quest_never_taken_the_repair_adds_the_accept_then_the_quests_goals() {
	let text = guide("Alliance", "Westfall", &["step Salma Saldean\n  turnin 38"]);
	assert_eq!(rules(&check(&text)), ["noAccept"]);
	let (r, t) = repaired(&text, None);
	assert!(rules(&r.after).is_empty(), "{t}");
	assert!(pos(&t, "accept 38") < pos(&t, "turnin 38"), "{t}");
}

#[test]
fn travel_and_continent_durotar_to_stormwind_with_no_line_a_ride_line_passes() {
	let mut bare = rules(&check(&orc(&["step Gar'Thok\n  accept 784", "step Library\n  zone Stormwind City\n  accept 82208"])));
	bare.sort();
	assert_eq!(bare, ["continent", "travel"]);
	let rode = orc(&["step Gar'Thok\n  accept 784", "step Zeppelin to Undercity\n  goto 50.8,13.5 \"Orgrimmar zeppelin\"", "step Library\n  zone Stormwind City\n  accept 82208"]);
	assert!(rules(&check(&rode)).is_empty());
}

#[test]
fn order_pass_a_stable_topological_sort_keeps_the_order_where_no_edge_is_broken() {
	assert_eq!(stable_sort(5, &[]).0, [0, 1, 2, 3, 4]);
	// 3 gives what 1 needs: 1 (and only 1) waits for it.
	assert_eq!(stable_sort(5, &[(3, 1)]).0, [0, 2, 3, 1, 4]);
	assert_eq!(stable_sort(3, &[(0, 1), (1, 0)]).1, [0, 1]);
}

#[test]
fn check_chain_every_chain_under_a_folder_catch_up_guides_left_out() {
	let dir = scratch("guidecheck-chain");
	std::fs::write(dir.join("01-t.guide"), orc(&["step Torm Ragetotem\n  accept 1505"])).unwrap();
	std::fs::write(dir.join("02-catchup.guide"), orc(&["step X\n  turnin 38"])).unwrap();
	let chains = find_chains(&dir);
	assert_eq!(chains.len(), 1);
	assert_eq!(chains[0].len(), 1);
	let texts: Vec<(String, String)> = chains[0].iter().map(|f| (f.to_string_lossy().into_owned(), std::fs::read_to_string(f).unwrap())).collect();
	let out = check_files(&texts, &data(), None).1;
	assert_eq!(out.iter().map(|f| (f.rule, f.line)).collect::<Vec<_>>(), [("giver", 8)]);
}
