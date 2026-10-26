//! Validation rules of docs/GUIDE_FORMAT.md (validate.rs): every error and warning fires on the offending
//! line, and stays quiet on valid input, including across guides chained with `next`. (Lint reading the solo
//! policy from a cached world is forge/tests/guide_cli.rs.)

use crate::common;
use common::*;
use forge_guide::data::Data;
use forge_guide::diag::Diag;
use forge_guide::js::V;
use serde_json::{json, Map, Value};

fn text(id: &str, body: &[&str], extra: &[&str]) -> String {
	let mut l = vec![format!("guide {id}"), format!("title {id}"), "faction Alliance".into(), "levels 1-10".into(), "zone Elwynn Forest".into()];
	l.extend(extra.iter().map(|s| s.to_string()));
	l.push(String::new());
	l.extend(body.iter().map(|s| s.to_string()));
	format!("{}\n", l.join("\n"))
}

fn only(list: &[String], pat: &str) -> Vec<String> {
	list.iter().filter(|m| re(pat).is_match(m)).cloned().collect()
}

fn diags(list: Vec<&Diag>, pat: &str) -> Vec<Diag> {
	list.into_iter().filter(|d| re(pat).is_match(&d.message)).cloned().collect()
}

/// The fixture's core tables with `quests`/`npcs`/`items` entries added (each a JSON object by id).
fn data_plus(quests: Value, npcs: Value, items: Value) -> Data {
	let mut t: Map<String, Value> = tables().into_iter().filter(|(k, _)| ["quests", "npcs", "objects", "items", "zones", "map-frames", "meta"].contains(&k.as_str())).collect();
	for (name, add) in [("quests", quests), ("npcs", npcs), ("items", items)] {
		if let Some(o) = add.as_object() {
			for (k, x) in o {
				t.get_mut(name).unwrap()[k] = x.clone();
			}
		}
	}
	data_from(&t, Value::Null, Value::Null)
}

/// quests[7] of the fixture with these fields over it.
fn like7(more: Value) -> Value {
	let mut q = tables()["quests"]["7"].clone();
	for (k, x) in more.as_object().unwrap() {
		q[k] = x.clone();
	}
	q
}

fn q(id: u32, extra: Value) -> Value {
	let mut base = json!({ "id": id, "title": format!("Quest {id}"), "level": 2, "minLevel": 1, "races": null, "classes": null, "start": { "npc": [823], "object": [], "item": [] }, "end": { "npc": [823], "object": [] }, "pre": [], "excl": [], "objectives": [] });
	for (k, x) in extra.as_object().unwrap() {
		base[k] = x.clone();
	}
	base
}

#[test]
fn duplicate_guide_ids_are_errors_naming_both_files() {
	let r = compile_map(&[("a.guide", &text("t/same", &["step S", "  level 2"], &[])), ("b.guide", &text("t/same", &["step S", "  level 3"], &[]))]);
	assert_eq!(r.errors, ["b.guide:1: duplicate guide id \"t/same\" (also in a.guide:1)"]);
}

#[test]
fn next_must_point_to_a_known_guide() {
	let bad = text("t/a", &["step S", "  level 2"], &["next t/missing"]);
	assert_eq!(compile_map(&[("a.guide", &bad)]).errors, vec![format!("a.guide:{}: `next` points to unknown guide \"t/missing\"", line_of(&bad, "next t/missing"))]);
	let ok = compile_map(&[("a.guide", &text("t/a", &["step S", "  level 2"], &["next t/b"])), ("b.guide", &text("t/b", &["step S", "  level 3"], &[]))]);
	assert!(ok.errors.is_empty(), "{}", ok.text);
}

#[test]
fn next_and_every_route_option_must_be_a_guide_the_characters_can_follow() {
	let errors_of = |from_extra: &[&str], to_extra: &[&str]| {
		let mut fe: Vec<&str> = from_extra.to_vec();
		fe.push("next t/b, t/c");
		let from = text("t/a", &["step S", "  level 2"], &fe);
		let r = compile_map(&[("a.guide", &from), ("b.guide", &text("t/b", &["step S", "  level 3"], &[])), ("c.guide", &text("t/c", &["step S", "  level 3"], to_extra))]);
		let next = line_of(&from, "next t/b, t/c") as f64;
		r.diag
			.errors()
			.iter()
			.map(|d| format!("{}: {}{}", if d.line == next { "next".to_string() } else { d.line.to_string() }, d.message, d.hint.as_ref().map(|h| format!(" | {h}")).unwrap_or_default()))
			.collect::<Vec<_>>()
	};
	assert_eq!(
		errors_of(&["race Human"], &["race Dwarf, Gnome"]),
		["next: no Human character can follow t/c (it is for Dwarf/Gnome only) | pick a guide for the same races: `polestar find --kind guide <zone> --race Human`"]
	);
	// A faction-wide target, or one sharing a race, is fine.
	assert!(errors_of(&["race Human"], &[]).is_empty());
	assert!(errors_of(&["race Human, Dwarf"], &["race Dwarf, Gnome"]).is_empty());
	// Classes alone.
	assert_eq!(
		errors_of(&["class Paladin"], &["class Mage, Warlock"]),
		["next: no Alliance Paladin character can follow t/c (it is for Alliance Mage/Warlock only) | pick a guide for the same classes: `polestar find --kind guide <zone> --class Paladin`"]
	);
	assert!(errors_of(&["class Paladin"], &[]).is_empty());
	assert!(errors_of(&["class Paladin, Mage"], &["class Mage"]).is_empty());
	// A Human cannot be a Shaman (races.json), so a Shaman guide is no option.
	assert_eq!(
		errors_of(&["race Human"], &["class Shaman"]),
		["next: no Human character can follow t/c (it is for Alliance Shaman only) | pick a guide for the same races: `polestar find --kind guide <zone> --race Human`"]
	);
	assert!(errors_of(&["race Dwarf"], &["class Shaman"]).is_empty());
}

#[test]
fn ids_unknown_in_data_are_errors_without_a_name_and_warnings_with_one() {
	let src = guide_text(&[
		"step S",
		"  accept 424242",
		"  accept 424243 \"New Forever Quest\"",
		"  kill 77777",
		"  kill 77778 \"Sky Raider\" @50,50",
		"  collect 88888",
		"  interact 99999 \"Odd Totem\" @1,1",
		"  talk 66666",
	]);
	let r = compile(&src);
	let at = |l: &str| format!("test.guide:{}: ", line_of(&src, l));
	assert_eq!(
		only(&r.errors, "not in data"),
		vec![
			format!("{}quest 424242 is not in data; give its title: `accept 424242 \"Title\"`", at("  accept 424242")),
			format!("{}npc 77777 is not in data; give its name: `kill 77777 \"Target name\"`", at("  kill 77777")),
			format!("{}item 88888 is not in data; give its name: `collect 88888 \"Item name\"`", at("  collect 88888")),
			format!("{}npc 66666 is not in data; give its name: `talk 66666 \"NPC name\"`", at("  talk 66666")),
		]
	);
	assert_eq!(
		only(&r.warnings, "not in data; using the explicit"),
		vec![
			format!("{}quest 424243 is not in data; using the explicit title (new Forever content?)", at("  accept 424243 \"New Forever Quest\"")),
			format!("{}npc 77778 is not in data; using the explicit name (new Forever content?)", at("  kill 77778 \"Sky Raider\" @50,50")),
			format!("{}object 99999 is not in data; using the explicit name (new Forever content?)", at("  interact 99999 \"Odd Totem\" @1,1")),
		]
	);
}

#[test]
fn turnin_complete_and_objective_goals_need_an_earlier_accept_in_the_guide() {
	let src = guide_text(&["step S", "  turnin 783", "  complete 7", "  kill 6 quest 7", "  accept 7", "  turnin 7", "  accept 783"]);
	let at = |l: &str| line_of(&src, l);
	assert_eq!(
		only(&compile(&src).errors, "never accepted"),
		vec![
			format!("test.guide:{}: `turnin` for quest 783 that is never accepted earlier in this guide or a guide chaining into it", at("  turnin 783")),
			format!("test.guide:{}: `complete` for quest 7 that is never accepted earlier in this guide or a guide chaining into it", at("  complete 7")),
			format!("test.guide:{}: `kill` for quest 7 that is never accepted earlier in this guide or a guide chaining into it", at("  kill 6 quest 7")),
		]
	);
}

#[test]
fn direct_turnin_needs_no_accept_and_is_checked_for_availability_and_prerequisites_as_an_accept_is() {
	let ok = compile(&guide_text(&["step S", "  turnin 783 direct"]));
	assert!(ok.errors.is_empty(), "{}", ok.text);
	// Its quest's level, as an accept's, for the engine's grey-quest skipping.
	assert_eq!(ok.steps()[0]["goals"][0]["qlvl"], 1);
	// 9100 is Orc-only, so no character of this Alliance guide can be offered it.
	assert_eq!(
		only(&compile(&guide_text(&["step S", "  turnin 9100 direct"])).errors, "not available"),
		["test.guide:8: quest 9100 (Orcish Errand) is not available to any race this step applies to"]
	);
	// 7 needs 783 turned in first, and the chain never turns it in.
	assert_eq!(
		only(&compile(&guide_text(&["step S", "  turnin 7 direct"])).warnings, "turned in first"),
		["test.guide:8: quest 7 needs 783 (A Threat Within) turned in first, but the chain never turns it in"]
	);
}

#[test]
fn direct_contradicts_an_earlier_accept_and_a_direct_quest_carries_no_objectives() {
	let both = guide_text(&["step S", "  accept 783", "  turnin 783 direct"]);
	assert_eq!(
		only(&compile(&both).errors, "direct"),
		vec![format!("test.guide:{}: `turnin` for quest 783 is marked `direct`, but the chain accepts that quest earlier: drop `direct`", line_of(&both, "  turnin 783 direct"))]
	);
	let tracked = guide_text(&["step S", "  complete 783", "  collect 2589 quest 783", "  turnin 783 direct"]);
	let why =
		"which is handed in directly (`turnin 783 direct`): it is never in the quest log, so nothing tracks its objectives. Get what it asks for with a plain `buy` or `collect`, without `quest`";
	assert_eq!(
		only(&compile(&tracked).errors, "handed in directly"),
		vec![
			format!("test.guide:{}: `complete` for quest 783 (A Threat Within), {why}", line_of(&tracked, "  complete 783")),
			format!("test.guide:{}: `collect` for quest 783 (A Threat Within), {why}", line_of(&tracked, "  collect 2589 quest 783")),
		]
	);
}

/// 9390 is shaped like Distracting Jarven (308): a repeatable quest its giver also takes back; 9391 a
/// repeatable with another ender.
fn repeatable_data() -> Data {
	let mut a = q(9390, json!({ "repeatable": true }));
	a["end"] = json!({ "npc": [823], "object": [] });
	let mut b = q(9391, json!({ "repeatable": true }));
	b["end"] = json!({ "npc": [197], "object": [] });
	data_plus(json!({ "9390": a, "9391": b }), Value::Null, Value::Null)
}

#[test]
fn a_plain_turnin_never_accepted_of_a_repeatable_its_giver_takes_back_hints_at_direct() {
	let hints = |id: u32| compile_with(&guide_text(&["step S", &format!("  turnin {id}")]), &repeatable_data()).diag.errors().iter().map(|d| d.hint.clone()).collect::<Vec<_>>();
	assert_eq!(hints(9390), [Some("a repeatable quest its giver takes back straight from the quest window: write `turnin <id> direct`".to_string())]);
	assert_eq!(hints(9391), [None]);
	assert_eq!(hints(783), [None]);
}

#[test]
fn an_accept_in_a_guide_that_chains_into_this_one_satisfies_a_later_turnin_an_unrelated_guide_does_not() {
	let first = text("t/one", &["step S", "  accept 33"], &["next t/two"]);
	let middle = text("t/two", &["step S", "  level 3"], &["next t/three"]);
	let last = text("t/three", &["step S", "  collect 750 quest 33", "  turnin 33"], &[]);
	assert!(compile_map(&[("1.guide", &first), ("2.guide", &middle), ("3.guide", &last)]).errors.is_empty());
	let r = compile_map(&[("1.guide", &text("t/one", &["step S", "  accept 33"], &[])), ("3.guide", &last)]);
	let strip = re(r":.*?: ");
	assert_eq!(
		r.errors.iter().map(|e| strip.replace(e, ": ").into_owned()).collect::<Vec<_>>(),
		[
			"3.guide: `collect` for quest 33 that is never accepted earlier in this guide or a guide chaining into it",
			"3.guide: `turnin` for quest 33 that is never accepted earlier in this guide or a guide chaining into it"
		]
	);
}

#[test]
fn accepting_a_quest_no_applicable_character_can_take_is_an_error() {
	// 9100 is Orc-only (race mask 2); 9101 is Hunter-only (class mask 4).
	let alliance = guide_text(&["step S", "  accept 9100"]);
	assert_match(
		&compile(&alliance).errors.join("\n"),
		&format!(r"test.guide:{}: quest 9100 \(Orcish Errand\) is not available to any race this step applies to", line_of(&alliance, "  accept 9100")),
	);
	assert!(compile(&text("t/h", &["step S", "  accept 9100"], &[]).replace("faction Alliance", "faction Horde")).errors.is_empty());
	assert_match(&compile(&text("t/w", &["step S", "  accept 9101"], &["class Warrior"])).errors.join("\n"), r"quest 9101 \(Hunter Training\) is not available to any class this step applies to");
	assert_match(&compile(&guide_text(&["step S", "  only !Hunter", "  accept 9101"])).errors.join("\n"), r"quest 9101 .* not available to any class this step applies to");
	assert_match(&compile(&guide_text(&["step S", "  accept 9101 only Warrior"])).errors.join("\n"), r"not available to any class this goal applies to");
	assert!(compile(&guide_text(&["step S", "  accept 9101 only Hunter"])).errors.is_empty());
	assert!(compile(&guide_text(&["step S", "  accept 9101"])).errors.is_empty());
}

/// Quests shaped like the quest database's: 9300 lists only its breadcrumbs in `pre`, 9310 needs both 9311 and
/// 9312 (preAll), 9320 either (preAny). 9330 is like 788 (pre 9331 or its breadcrumb 9332), 9340 like 813
/// (pre = its parent 9341), 9350 like 786 (pre 9351, which nobody can start). 9370 is closed one way by 9371
/// (its `excl`), while 9371 has no `excl`.
fn prereq_data() -> Data {
	let mut nostart = q(9351, json!({}));
	nostart["start"] = json!({ "npc": [], "object": [], "item": [] });
	data_plus(
		json!({
			"9300": q(9300, json!({ "pre": [9301, 9302], "breadcrumbs": [9301] })),
			"9301": q(9301, json!({ "breadcrumbFor": 9300 })),
			"9302": q(9302, json!({ "breadcrumbFor": 9300 })),
			"9310": q(9310, json!({ "pre": [9311, 9312], "preAll": [9311, 9312] })),
			"9311": q(9311, json!({})),
			"9312": q(9312, json!({})),
			"9320": q(9320, json!({ "pre": [9321, 9322], "preAny": [9321, 9322] })),
			"9321": q(9321, json!({})),
			"9322": q(9322, json!({})),
			"9330": q(9330, json!({ "pre": [9331, 9332], "breadcrumbs": [9332] })),
			"9331": q(9331, json!({})),
			"9332": q(9332, json!({})),
			"9340": q(9340, json!({ "pre": [9341], "parent": 9341 })),
			"9341": q(9341, json!({})),
			"9350": q(9350, json!({ "pre": [9351] })),
			"9351": nostart,
			"9360": q(9360, json!({ "excl": [9361] })),
			"9361": q(9361, json!({ "excl": [9360] })),
			"9370": q(9370, json!({ "excl": [9371] })),
			"9371": q(9371, json!({})),
		}),
		Value::Null,
		Value::Null,
	)
}

#[test]
fn prerequisites_breadcrumbs_never_block_pre_all_needs_every_one_pre_any_one() {
	let data = prereq_data();
	let r = compile_with(&guide_text(&["step S", "  accept 9300"]), &data);
	assert!(only(&r.warnings, "needs").is_empty());
	assert!(r.steps()[0]["goals"][0].get("pre").is_none(), "breadcrumbs are not compiled as prerequisites");
	let all = guide_text(&["step S", "  accept 9311", "  turnin 9311", "  accept 9310"]);
	let ra = compile_with(&all, &data);
	assert_eq!(only(&ra.warnings, "needs"), vec![format!("test.guide:{}: quest 9310 needs 9312 (Quest 9312) turned in first, but the chain never turns it in", line_of(&all, "  accept 9310"))]);
	assert_eq!(ra.steps()[0]["goals"][2]["preAll"], json!([9311, 9312]));
	let rn = compile_with(&guide_text(&["step S", "  accept 9321", "  turnin 9321", "  accept 9320"]), &data);
	assert!(only(&rn.warnings, "needs").is_empty());
	assert_eq!(rn.steps()[0]["goals"][2]["pre"], json!([9321, 9322]));
	for id in [9330, 9340, 9350] {
		let r2 = compile_with(&guide_text(&["step S", &format!("  accept {id}")]), &data);
		assert!(only(&r2.warnings, "needs").is_empty(), "quest {id}");
		assert!(r2.steps()[0]["goals"][0].get("pre").is_none(), "quest {id}");
	}
}

#[test]
fn an_accept_compiles_closed_by_the_quest_its_breadcrumb_leads_to_and_its_exclusive_group_titled_for_the_reason_text() {
	let r = compile_with(&guide_text(&["step S", "  accept 9301", "  accept 9360", "  accept 9311", "  accept 9332"]), &prereq_data());
	let g = r.steps()[0]["goals"].as_array().unwrap().clone();
	assert_eq!(json!([g[0]["closedBy"], g[0]["preTitles"]]), json!([[9300], { "9300": "Quest 9300" }]));
	assert_eq!(json!([g[1]["closedBy"], g[1]["preTitles"]]), json!([[9361], { "9361": "Quest 9361" }]));
	assert!(g[2].get("closedBy").is_none());
	// #368: a breadcrumb only its quest's `breadcrumbs` names (no breadcrumbFor of its own).
	assert_eq!(json!([g[3]["closedBy"], g[3]["preTitles"]]), json!([[9330], { "9330": "Quest 9330" }]));
}

#[test]
fn coordinates_outside_0_100_are_errors() {
	let src = guide_text(&["step S", "  goto 101,5", "  kill 6 @-1,50", "  goto 100,0"]);
	assert_eq!(
		compile(&src).errors,
		vec![
			format!("test.guide:{}: coordinates 101,5 are outside 0-100", line_of(&src, "  goto 101,5")),
			format!("test.guide:{}: coordinates -1,50 are outside 0-100", line_of(&src, "  kill 6 @-1,50"))
		]
	);
}

#[test]
fn an_accept_whose_prerequisite_is_never_turned_in_earlier_in_the_chain_warns() {
	let src = guide_text(&["step S", "  accept 9200"]);
	assert_eq!(
		only(&compile(&src).warnings, "needs 9201"),
		vec![format!("test.guide:{}: quest 9200 needs 9201 (The First Step) turned in first, but the chain never turns it in", line_of(&src, "  accept 9200"))]
	);
	let chained = compile_map(&[("1.guide", &text("t/one", &["step S", "  accept 9201", "  turnin 9201"], &["next t/two"])), ("2.guide", &text("t/two", &["step S", "  accept 9200"], &[]))]);
	assert!(only(&chained.warnings, "turned in first").is_empty());
}

#[test]
fn an_accept_above_the_level_the_route_plausibly_reaches_warns_a_level_goal_or_earlier_xp_silences_it() {
	let src = guide_text(&["step S", "  accept 9300"]);
	assert_eq!(
		only(&compile(&src).warnings, "plausibly"),
		vec![format!("test.guide:{}: quest 9300 needs level 20, but the route plausibly reaches only level 1 here", line_of(&src, "  accept 9300"))]
	);
	assert!(only(&compile(&guide_text(&["step S", "  level 20", "  accept 9300"])).warnings, "plausibly").is_empty());
	// 783 + 33 turned in: (80 + 250) quest XP, doubled for kills along the way -> level 2 (400 XP needed).
	assert!(only(&compile(&guide_text(&["step S", "  accept 783", "  turnin 783", "  accept 33", "  turnin 33", "  accept 9400"])).warnings, "plausibly").is_empty());
	assert_eq!(only(&compile(&guide_text(&["step S", "  accept 9400"])).warnings, "plausibly").len(), 1);
	// The entry level of a chained guide is the best exit of its predecessors.
	let chain = compile_map(&[("1.guide", &text("t/one", &["step S", "  level 20"], &["next t/two"])), ("2.guide", &text("t/two", &["step S", "  accept 9300"], &[]))]);
	assert!(only(&chain.warnings, "plausibly").is_empty());
}

#[test]
fn explicit_coordinates_far_from_every_known_spawn_of_the_entity_warn() {
	let src = guide_text(&["step S", "  talk 823 @48.2,42.9", "  talk 823 @60,60", "  kill 1423 @60,70 map 1453", "  kill 1423 @10,10 map 1411"]);
	assert_eq!(
		only(&compile(&src).warnings, "explicit coordinates"),
		vec![
			format!("test.guide:{}: explicit coordinates 60,60 are more than 50 yards from every known spawn of npc 823", line_of(&src, "  talk 823 @60,60")),
			format!("test.guide:{}: explicit coordinates 10,10: npc 1423 has no known spawn on map 1411", line_of(&src, "  kill 1423 @10,10 map 1411")),
		]
	);
}

#[test]
fn objective_capable_goals_without_coordinates_warn() {
	let src = guide_text(&["step S", "  use 6948", "  kill \"Wandering Ghost\"", "  kill \"Placed Ghost\" @20,20", "  kill 6"]);
	assert_eq!(
		only(&compile(&src).warnings, "no coordinates"),
		vec![
			format!("test.guide:{}: `use` has no coordinates (no known spawns; add @x,y)", line_of(&src, "  use 6948")),
			format!("test.guide:{}: `kill` has no coordinates (no known spawns; add @x,y)", line_of(&src, "  kill \"Wandering Ghost\"")),
		]
	);
}

#[test]
fn the_fixture_guide_set_is_valid_no_errors_and_no_warnings_but_its_goto_before_the_kobolds() {
	let dir = fixtures().join("guides");
	let files = forge_guide::project::find_guide_files(&dir, false);
	assert_eq!(files, ["forever/alliance/human/01-northshire.guide", "forever/alliance/human/02-elwynn.guide"]);
	let texts: Vec<(String, String)> = files.iter().map(|f| (f.clone(), std::fs::read_to_string(dir.join(f)).unwrap())).collect();
	let refs: Vec<(&str, &str)> = texts.iter().map(|(a, b)| (a.as_str(), b.as_str())).collect();
	let r = compile_map(&refs);
	// The fixture keeps a `goto` before its kill so the engine's goto steps stay covered.
	assert_eq!(r.warnings.len(), 1, "{}", r.text);
	assert_match(
		&r.warnings[0],
		r#"^forever/alliance/human/01-northshire\.guide:19: `goto 47\.6,35\.1` "Kobold camp" sends the player where `kill Kobold Vermin` \(line 20\) already leads, \d+ yards away$"#,
	);
	assert!(r.errors.is_empty(), "{}", r.text);
}

#[test]
fn a_bare_unknown_npc_id_on_train_or_vendor_is_an_error_a_quoted_name_makes_it_a_warning() {
	let src = guide_text(&["step S", "  train 77777", "  vendor 77778", "  train 77779 \"Sky Trainer\"", "  sethome \"Somewhere\" npc 77780"]);
	let r = compile(&src);
	assert_eq!(
		r.errors,
		vec![
			format!("test.guide:{}: npc 77777 is not in data; give its name: `train 77777 \"NPC name\"`", line_of(&src, "  train 77777")),
			format!("test.guide:{}: npc 77778 is not in data; give its name: `vendor 77778 \"NPC name\"`", line_of(&src, "  vendor 77778")),
		]
	);
	let w = r.warnings.join("\n");
	assert_match(&w, r"test\.guide:10: npc 77779 is not in data; using the explicit name");
	// `npc <id>` modifiers cannot carry a name, so they only warn.
	assert_match(&w, r"test\.guide:11: npc 77780 is not in data; its name and position cannot be filled");
}

#[test]
fn an_accept_closed_by_an_exclusive_quest_taken_earlier_in_the_chain_warns() {
	let data = prereq_data();
	let first = text("t/one", &["step S", "  accept 9371", "  turnin 9371"], &["next t/two"]);
	let second = text("t/two", &["step S", "  accept 9370", "  turnin 9370"], &[]);
	let msg = "quest 9370 (Quest 9370) is not offered once 9371 (Quest 9371) is in the log or done, and the chain takes that quest earlier";
	assert_eq!(only(&compile_files(&[("1.guide", &first), ("2.guide", &second)], &data, None).warnings, "not offered"), vec![format!("2.guide:{}: {msg}", line_of(&second, "  accept 9370"))]);
	let same = guide_text(&["step S", "  accept 9371", "step T", "  accept 9370", "  turnin 9371", "  turnin 9370"]);
	assert_eq!(only(&compile_with(&same, &data).warnings, "not offered"), vec![format!("test.guide:{}: {msg}", line_of(&same, "  accept 9370"))]);
	// Near misses: unrelated guides, the one-way direction, characters that never meet.
	assert!(only(&compile_files(&[("1.guide", &text("t/one", &["step S", "  accept 9371", "  turnin 9371"], &[])), ("2.guide", &second)], &data, None).warnings, "not offered").is_empty());
	assert!(only(&compile_with(&guide_text(&["step S", "  accept 9370", "  accept 9371", "  turnin 9370", "  turnin 9371"]), &data).warnings, "not offered").is_empty());
	let split = guide_text(&["step S", "  accept 9371 only Human", "  turnin 9371 only Human", "  accept 9370 only Dwarf", "  turnin 9370 only Dwarf"]);
	assert!(only(&compile_with(&split, &data).warnings, "not offered").is_empty());
}

#[test]
fn an_accept_that_is_never_turned_in_later_on_the_route_warns_per_route_choice() {
	let start = text("t/one", &["step S", "  accept 33", "  accept 7", "  accept 783 optional"], &["next t/two, t/three"]);
	let two = text("t/two", &["step S", "  turnin 33", "  turnin 7"], &["pitch Two"]);
	let three = text("t/three", &["step S", "  turnin 33"], &["pitch Three"]);
	assert_eq!(
		only(&compile_map(&[("1.guide", &start), ("2.guide", &two), ("3.guide", &three)]).warnings, "never turned in"),
		vec![format!("1.guide:{}: quest 7 (Kobold Camp Cleanup) is accepted but never turned in on the route through \"t/three\"", line_of(&start, "  accept 7"))]
	);
	// A turn-in deeper on the route counts.
	let deep = compile_map(&[
		("1.guide", &text("t/one", &["step S", "  accept 7"], &["next t/two"])),
		("2.guide", &text("t/two", &["step S", "  level 2"], &["next t/three"])),
		("3.guide", &text("t/three", &["step S", "  turnin 7"], &[])),
	]);
	assert!(only(&deep.warnings, "never turned in").is_empty());
	let lone = guide_text(&["step S", "  turnin 33", "  accept 7", "  accept 33"]);
	assert_eq!(
		only(&compile(&lone).warnings, "never turned in"),
		vec![
			format!("test.guide:{}: quest 7 (Kobold Camp Cleanup) is accepted but never turned in later in this guide or a guide after it", line_of(&lone, "  accept 7")),
			format!("test.guide:{}: quest 33 (Wolves Across the Border) is accepted but never turned in later in this guide or a guide after it", line_of(&lone, "  accept 33")),
		]
	);
	// `only`: a turn-in for some of the characters leaves the rest.
	let part = guide_text(&["step S", "  accept 7", "  turnin 7 only Human"]);
	assert_eq!(
		only(&compile(&part).warnings, "never turned in"),
		vec![format!(
			"test.guide:{}: quest 7 (Kobold Camp Cleanup) is accepted but never turned in later in this guide or a guide after it for some of the characters it applies to",
			line_of(&part, "  accept 7")
		)]
	);
	assert!(only(&compile(&guide_text(&["step S", "  accept 7 only Human", "  turnin 7 only Human"])).warnings, "never turned in").is_empty());
}

#[test]
fn a_next_guide_whose_races_leave_out_the_characters_says_why_its_turnins_do_not_count_the_warning_has_a_hint() {
	let one = text("t/one", &["step S", "  accept 7"], &["race Human, Dwarf", "next t/two"]);
	let two = text("t/two", &["step S", "  turnin 7"], &["race Dwarf"]);
	let r = compile_map(&[("1.guide", &one), ("2.guide", &two)]);
	let w = diags(r.diag.warnings(), "never turned in");
	assert_eq!(w.len(), 1);
	assert_eq!(w[0].line as usize, line_of(&one, "  accept 7"));
	assert_eq!(w[0].message, "quest 7 (Kobold Camp Cleanup) is accepted but never turned in later in this guide or a guide after it for some of the characters it applies to (\"t/two\" is for Dwarf only, so its turn-ins do not count)");
	assert_eq!(w[0].hint.as_deref(), Some("turn it in later in this guide, or pick a `next` guide these characters can follow, or make the accept `optional` when the player may leave it"));
	// Per route: the route through a Dwarf guide says so; a plain miss does not.
	let choice = text("t/one", &["step S", "  accept 7"], &["race Human, Dwarf", "next t/two, t/three"]);
	let split = compile_map(&[
		("1.guide", &choice),
		("2.guide", &text("t/two", &["step S", "  turnin 7"], &["race Dwarf", "pitch Two"])),
		("3.guide", &text("t/three", &["step S", "  turnin 7"], &["pitch Three"])),
	]);
	assert_eq!(
		only(&split.warnings, "never turned in"),
		vec![format!("1.guide:{}: quest 7 (Kobold Camp Cleanup) is accepted but never turned in on the route through \"t/two\" for some of the characters it applies to (it is for Dwarf only, so its turn-ins do not count)", line_of(&choice, "  accept 7"))]
	);
	let lone = compile(&guide_text(&["step S", "  accept 7"]));
	assert_eq!(
		diags(lone.diag.warnings(), "never turned in")[0].hint.as_deref(),
		Some("turn it in later in this guide or in a guide after it, or make the accept `optional` when the player may leave it")
	);
}

#[test]
fn an_objective_index_past_the_quests_objectives_names_them_with_a_hint() {
	let src = guide_text(&["step S", "  accept 7", "  kill 6 quest 7.2", "  turnin 7"]);
	let d = diags(compile(&src).diag.warnings(), r"objective\(s\) in data").remove(0);
	assert_eq!(d.line as usize, line_of(&src, "  kill 6 quest 7.2"));
	assert_eq!(d.message, "quest 7 has 1 objective(s) in data, not 2: 7.1 = kill Kobold Vermin x10");
	assert_eq!(d.hint.as_deref(), Some("write `quest 7.<n>` with one of these (`polestar find 7` lists them)"));
}

fn tusks() -> Value {
	json!({
		"95100": { "id": 95100, "name": "Elite Tusk", "drops": { "npc": { "95003": 60 }, "object": {} }, "vendors": [] },
		"95101": { "id": 95101, "name": "Kobold Tusk", "drops": { "npc": { "95003": 60, "95002": 10 }, "object": {} }, "vendors": [] },
	})
}

#[test]
fn an_objective_index_that_names_another_objective_of_the_quest_is_an_error_that_says_which_index_is_the_items() {
	let data = data_plus(
		json!({ "9700": like7(json!({ "id": 9700, "title": "Tusks", "pre": [], "objectives": [{ "type": "item", "id": 95100, "count": 6 }, { "type": "item", "id": 95101, "count": 3 }] })) }),
		Value::Null,
		tusks(),
	);
	let src = guide_text(&["step S", "  accept 9700", "  collect 95101 quest 9700.1", "  collect 95100 quest 9700.1", "  turnin 9700"]);
	let r = compile_with(&src, &data);
	assert!(diags(r.diag.warnings(), r"9700\.1 is").is_empty(), "a swapped index is not only a warning");
	let d = diags(r.diag.errors(), r"9700\.1 is");
	assert_eq!(d.len(), 1, "only the line whose item is not objective 1");
	assert_eq!(d[0].line as usize, line_of(&src, "  collect 95101 quest 9700.1"));
	assert_eq!(d[0].message, "quest 9700.1 is collect Elite Tusk x6, not this item; Kobold Tusk is 9700.2");
	assert_eq!(d[0].hint.as_deref(), Some("write `quest 9700.2`, or `quest 9700` to take the index from the item"));
}

/// A quest whose one line is an object to visit and an item it uses on the way (#538); one whose line is
/// another item; one with an object line and an item line.
fn used_item_data() -> Data {
	let items = json!({
		"95100": { "id": 95100, "name": "Elite Tusk", "drops": { "npc": { "95003": 60 }, "object": {} }, "vendors": [] },
		"95101": { "id": 95101, "name": "Kobold Tusk", "drops": { "npc": { "95003": 60 }, "object": {} }, "vendors": [] },
	});
	let crate_ = json!({ "type": "object", "id": 1617, "count": 1 });
	data_plus(
		json!({
			"9701": like7(json!({ "id": 9701, "title": "Nests", "pre": [], "objectives": [crate_], "requiredItems": [95100] })),
			"9702": like7(json!({ "id": 9702, "title": "Visits", "pre": [], "objectives": [crate_] })),
			"9703": like7(json!({ "id": 9703, "title": "Bait", "pre": [], "objectives": [{ "type": "item", "id": 95101, "count": 1 }], "requiredItems": [95100] })),
			"9704": like7(json!({ "id": 9704, "title": "Crate and tusk", "pre": [], "objectives": [crate_, { "type": "item", "id": 95101, "count": 1 }] })),
		}),
		Value::Null,
		items,
	)
}

fn triples(d: Vec<Diag>) -> Vec<(usize, String, Option<String>)> {
	d.into_iter().map(|x| (x.line as usize, x.message, x.hint)).collect()
}

#[test]
fn a_collect_bound_to_a_quest_line_that_is_not_an_item_warns_for_an_item_the_quest_uses_the_hint_is_to_count_the_bags() {
	let src = guide_text(&["step S", "  accept 9701", "  accept 9702", "  collect 95100 quest 9701.1", "  collect 95100 quest 9702.1", "  collect 95100 quest 9701", "  turnin 9701", "  turnin 9702"]);
	let w = triples(diags(compile_with(&src, &used_item_data()).diag.warnings(), "not an item|no objective for this item"));
	let s = |x: &str| Some(x.to_string());
	assert_eq!(
		w,
		vec![
			(
				line_of(&src, "  collect 95100 quest 9701.1"),
				"quest 9701.1 is interact Kobold Crate x1, not an item".to_string(),
				s("the quest uses item 95100 without counting it: drop `quest 9701.1` so the step counts it in the bags")
			),
			(line_of(&src, "  collect 95100 quest 9702.1"), "quest 9702.1 is interact Kobold Crate x1, not an item".to_string(), s("its objectives: 9702.1 = interact Kobold Crate x1")),
			(
				line_of(&src, "  collect 95100 quest 9701"),
				"quest 9701 has no objective for this item".to_string(),
				s("the quest uses item 95100 without counting it: drop `quest 9701` so the step counts it in the bags")
			),
		]
	);
}

#[test]
fn complete_on_a_quest_without_objectives_warns_the_turnin_is_the_action() {
	let src = guide_text(&["step S", "  accept 783", "  accept 7", "  complete 783", "  complete 7", "  turnin 783", "  turnin 7"]);
	assert_eq!(
		only(&compile(&src).warnings, "no objectives"),
		vec![format!("test.guide:{}: `complete` for quest 783 (A Threat Within), which has no objectives: the action is the turn-in; use `turnin`", line_of(&src, "  complete 783"))]
	);
}

#[test]
fn a_turnin_whose_quest_needs_an_item_no_earlier_goal_gets_warns_naming_the_item_and_its_objective() {
	let turnin = |body: &[&str]| {
		let mut l = vec!["step S", "  accept 33"];
		l.extend_from_slice(body);
		l.push("  turnin 33");
		only(&compile(&guide_text(&l)).warnings, "is turned in, but")
	};
	let src = guide_text(&["step S", "  accept 33", "  turnin 33"]);
	assert_eq!(
		only(&compile(&src).warnings, "is turned in, but"),
		vec![format!(
			"test.guide:{}: quest 33 (Wolves Across the Border) is turned in, but no earlier goal in this guide or a guide chaining into it gets Tough Wolf Meat (750, objective 33.1)",
			line_of(&src, "  turnin 33")
		)]
	);
	// Got by a collect of the item, a kill linked to its objective, or `complete`: quiet.
	for body in [&["  collect 750 x8 quest 33"][..], &["  collect 750 x8"], &["  kill 69 x8 quest 33.1"], &["  complete 33"]] {
		assert!(turnin(body).is_empty(), "{body:?}");
	}
	// Too late: after the turn-in.
	assert_eq!(only(&compile(&guide_text(&["step S", "  accept 33", "  turnin 33", "  collect 750 x8"])).warnings, "is turned in, but").len(), 1);
	// Got in a guide chaining into this one.
	let r = compile_map(&[("a.guide", &text("t/a", &["step S", "  accept 33", "  collect 750 x8 quest 33"], &["next t/b"])), ("b.guide", &text("t/b", &["step S", "  turnin 33"], &[]))]);
	assert!(only(&r.warnings, "is turned in, but").is_empty());
}

#[test]
fn an_item_the_quest_or_an_npc_hands_over_needs_no_goal() {
	let data = data_plus(
		json!({ "9701": like7(json!({ "id": 9701, "title": "Letters", "pre": [], "objectives": [{ "type": "item", "id": 95102, "count": 1 }] })) }),
		Value::Null,
		json!({ "95102": { "id": 95102, "name": "Sealed Letter", "drops": { "npc": {}, "object": {} }, "vendors": [] } }),
	);
	assert!(only(&compile_with(&guide_text(&["step S", "  accept 9701", "  turnin 9701"]), &data).warnings, "is turned in, but").is_empty());
}

#[test]
fn a_complete_with_no_place_on_a_quest_whose_objectives_have_places_warns() {
	let src = guide_text(&["step S", "  accept 7", "  complete 7", "  turnin 7"]);
	assert_eq!(
		triples(diags(compile(&src).diag.warnings(), "has no place")),
		vec![(
			line_of(&src, "  complete 7"),
			"`complete` for quest 7 (Kobold Camp Cleanup) has no place, but its objectives do (7.1 = kill Kobold Vermin x10): the arrow has nowhere to point".to_string(),
			Some("write a goal per objective (`kill <npc> quest 7.<n>`, `collect <item> quest 7.<n>`), or give the `complete` a `goto` or coordinates".to_string())
		)]
	);
	assert!(only(&compile(&guide_text(&["step S", "  accept 7", "  goto 48,31", "  complete 7", "  turnin 7"])).warnings, "has no place").is_empty());
	assert!(only(&compile(&guide_text(&["step S", "  accept 783", "  complete 783", "  turnin 783"])).warnings, "has no place").is_empty());
}

/// Elite work: 95003 Elite Kobold (rank 1, hostile) is already there; 95030 is a friendly rank-1 talk credit;
/// item 95100 drops only from the Elite Kobold, 95101 also from a normal kobold; quest 9380 collects 95100.
fn elite_data() -> Data {
	data_plus(
		json!({ "9380": like7(json!({ "id": 9380, "title": "Tusk Hunt", "objectives": [{ "type": "item", "id": 95100, "count": 3, "text": "Elite Tusk" }] })) }),
		json!({ "95030": { "id": 95030, "name": "Friendly Sage", "level": 55, "rank": 1, "faction": "AH", "spawns": { "1429": { "f": "e", "pts": [[40, 40]] } } } }),
		tusks(),
	)
}

fn elite_tip(target: &str) -> String {
	format!("in a Leveling guide put the goal in a step with `when group <quest>` (the player chooses it) or make it `optional`, with the tip \"{target} is elite: grouping up is advised.\"")
}

#[test]
fn elite_work_in_a_leveling_guide_killing_a_hostile_elite_is_an_error_unless_optional_friendly_or_under_when_group() {
	let data = elite_data();
	let src = guide_text(&["step S", "  kill 95003", "  kill 95003 optional", "  kill 95030", "  kill 95002"]);
	assert_eq!(
		only(&compile_with(&src, &data).errors, "elite"),
		vec![format!("test.guide:{}: `kill` npc 95003 (Elite Kobold) is elite; {}", line_of(&src, "  kill 95003"), elite_tip("Elite Kobold"))]
	);
	let dungeon = guide_text(&["guide t/d", "title D", "faction Alliance", "category Dungeons", "", "step S", "  kill 95003"]);
	assert!(only(&compile_with(&dungeon, &data).errors, "elite").is_empty());
	// A step only the group way follows (`when group`) is fine; `when !group` is the solo way.
	let group = guide_text(&["step S", "  when group 7", "  kill 95003", "", "step T", "  when !group 7", "  kill 95003"]);
	let last = group.split('\n').collect::<Vec<_>>().iter().rposition(|l| *l == "  kill 95003").unwrap() + 1;
	assert_eq!(only(&compile_with(&group, &data).errors, "elite"), vec![format!("test.guide:{last}: `kill` npc 95003 (Elite Kobold) is elite; {}", elite_tip("Elite Kobold"))]);
}

#[test]
fn elite_work_in_a_leveling_guide_collecting_an_item_only_elites_drop_is_an_error() {
	let data = elite_data();
	let src = guide_text(&["step S", "  accept 9380", "  collect 95100 x3", "  collect 95100 x3 quest 9380.1", "  collect 95100 x3 optional", "  collect 95101 x3", "  turnin 9380"]);
	let tip = elite_tip("Elite Kobold");
	assert_eq!(
		only(&compile_with(&src, &data).errors, "elite"),
		vec![
			format!("test.guide:{}: `collect` item 95100 (Elite Tusk) drops only from elites (Elite Kobold); {tip}", line_of(&src, "  collect 95100 x3")),
			format!("test.guide:{}: `collect` item 95100 (Elite Tusk) drops only from elites (Elite Kobold); {tip}", line_of(&src, "  collect 95100 x3 quest 9380.1")),
		]
	);
	let reputation = guide_text(&["guide t/r", "title R", "faction Alliance", "category Reputation", "", "step S", "  collect 95100 x3"]);
	assert!(only(&compile_with(&reputation, &data).errors, "elite").is_empty());
}

/// validate_solo_policy's `{ <Faction>: { <quest id>: entry } }` from (faction, entries).
fn excluded(faction: &str, entries: Value) -> V {
	let m = serde_json::Map::from_iter(entries.as_array().unwrap().iter().map(|e| (e["id"].to_string(), e.clone())));
	v(&json!({ faction: m }))
}

fn solo(r: &mut Compiled, ex: &V, pat: &str) -> Vec<String> {
	forge_guide::validate::validate_solo_policy(&r.guides, ex, &mut r.diag);
	r.diag.sorted().iter().filter(|d| re(pat).is_match(&d.message)).map(|d| format!("{}: {}: {}", d.line, d.severity, d.message)).collect()
}

#[test]
fn solo_policy_goals_on_quests_the_simulator_excludes_are_errors_when_elite_else_warnings_unless_optional() {
	let ex = excluded(
		"Alliance",
		json!([
			{ "id": 7, "title": "Kobold Camp Cleanup", "reason": "elite kill objective npc 95003", "category": "elite" },
			{ "id": 33, "title": "Wolves Across the Border", "reason": "profession" },
			{ "id": 783, "title": "A Threat Within", "reason": "seasonal event" },
		]),
	);
	let src = guide_text(&["step S", "  accept 7", "  kill 95003 quest 7", "  kill 6 quest 7", "  turnin 7 optional", "  accept 33", "  accept 783"]);
	let mut r = compile_with(&src, &elite_data());
	let quest = format!("quest 7 (Kobold Camp Cleanup) is elite (solo filter: elite kill objective npc 95003); {}", elite_tip("Kobold Camp Cleanup"));
	assert_eq!(
		solo(&mut r, &ex, "elite|solo"),
		vec![
			format!("{}: error: {quest}", line_of(&src, "  accept 7")),
			// Reported once: as the elite kill, not again for its quest.
			format!("{}: error: `kill` npc 95003 (Elite Kobold) is elite; {}", line_of(&src, "  kill 95003 quest 7"), elite_tip("Elite Kobold")),
			format!("{}: error: {quest}", line_of(&src, "  kill 6 quest 7")),
			format!("{}: warning: quest 33 (Wolves Across the Border) is excluded from solo leveling (profession: profession); make the goal `optional`", line_of(&src, "  accept 33")),
		]
	);
	// Other categories than Leveling are not solo routes.
	let mut p = compile_with(&guide_text(&["guide t/p", "title P", "faction Alliance", "category Professions", "", "step S", "  accept 7"]), &elite_data());
	assert!(solo(&mut p, &ex, "elite|solo").is_empty());
}

#[test]
fn elite_work_behind_when_group_a_group_step_and_the_quests_accepted_only_in_one_are_a_partys_work_not_solo_leveling() {
	let ex = excluded("Alliance", json!([{ "id": 7, "title": "Kobold Camp Cleanup", "reason": "elite kill objective npc 95003", "category": "elite" }]));
	let check = |lines: &[&str]| {
		let src = guide_text(lines);
		let mut r = compile_with(&src, &elite_data());
		forge_guide::validate::validate_solo_policy(&r.guides, &ex, &mut r.diag);
		let first = line_of(&src, lines[0]) as i64;
		r.diag.sorted().iter().filter(|d| d.message.contains("elite")).map(|d| d.line as i64 - first).collect::<Vec<_>>()
	};
	// The accept in a group step: its objectives elsewhere go with it when the player skips.
	assert_eq!(check(&["step A", "  when group 7", "  accept 7", "", "step B", "  kill 95003 quest 7", "  kill 95003", "  turnin 7"]), [6], "only the kill for no quest");
	// A `!group` step is the solo route: no exemption.
	assert_eq!(check(&["step A", "  when !group 7", "  accept 7", "  kill 95003 quest 7"]), [2, 3]);
	// Accepted outside a group step too: still solo work.
	assert_eq!(check(&["step A", "  when group 7", "  accept 7", "", "step B", "  accept 7", "  kill 95003 quest 7"]), [5, 6]);
}

#[test]
fn solo_policy_a_direct_turnin_of_a_repeatable_is_no_grind_it_does_not_need_optional() {
	let ex = excluded("Alliance", json!([{ "id": 9390, "title": "Quest 9390", "reason": "repeatable without a recorded reward (no XP)", "category": "repeatable" }]));
	let check = |line: &str| {
		let mut r = compile_with(&guide_text(&["step S", line]), &repeatable_data());
		forge_guide::validate::validate_solo_policy(&r.guides, &ex, &mut r.diag);
		r.diag.warnings().iter().filter(|d| d.message.contains("solo")).count()
	};
	assert_eq!(check("  turnin 9390 direct"), 0);
	assert_eq!(check("  accept 9390"), 1, "an accepted repeatable still warns");
}

#[test]
fn a_collect_bound_to_the_line_of_another_item_on_a_quest_that_only_uses_its_item_the_hint_is_to_count_the_bags() {
	let src = guide_text(&["step S", "  accept 9703", "  collect 95100 quest 9703.1", "  turnin 9703"]);
	assert_eq!(
		triples(diags(compile_with(&src, &used_item_data()).diag.warnings(), r"9703\.1 is")),
		vec![(
			line_of(&src, "  collect 95100 quest 9703.1"),
			"quest 9703.1 is collect Kobold Tusk x1, not this item".to_string(),
			Some("the quest uses item 95100 without counting it: drop `quest 9703.1` so the step counts it in the bags".to_string())
		)]
	);
}

#[test]
fn a_collect_bound_to_a_line_that_is_not_an_item_when_the_item_is_another_objective_of_the_quest_the_hint_names_its_index() {
	let src = guide_text(&["step S", "  accept 9704", "  collect 95101 quest 9704.1", "  turnin 9704"]);
	let w = diags(compile_with(&src, &used_item_data()).diag.warnings(), "not an item");
	assert_eq!(
		w.iter().map(|x| (x.message.clone(), x.hint.clone())).collect::<Vec<_>>(),
		[("quest 9704.1 is interact Kobold Crate x1, not an item".to_string(), Some("write `quest 9704.2`, or `quest 9704` to take the index from the item".to_string()))]
	);
}
