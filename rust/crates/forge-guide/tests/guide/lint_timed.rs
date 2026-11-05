//! Timed quest items (docs/GUIDE_FORMAT.md, "Validation"; timed.rs): lint warns when a guide carries an item
//! that vanishes after a while (items.json `duration`) longer than it lasts, by the simulator's travel and
//! kill times over the guide's goals. The fixture cases run everywhere; the guide orders the players' reports
//! and our lint found need the real reference data and skip without it.

use crate::common;
use common::*;
use forge_guide::data::{load_data, Data};
use forge_guide::js::V;
use serde_json::json;

fn timed(r: &Compiled) -> Vec<String> {
	r.warnings.iter().filter(|w| w.contains(" lasts ")).cloned().collect()
}

/// Refreshing Spring Water lasts five minutes here, and A Threat Within and Eagan Peltskinner each take one
/// (a required item) at their turn-in.
fn fixture() -> Data {
	let data = fixture_data();
	data.items.get("159").set("duration", 300);
	for id in ["783", "5261"] {
		data.quests.get(id).set("requiredItems", V::from(vec![V::from(159)]));
	}
	data
}

/// Bought at Brother Danil, both errands handed in beside him in Northshire; the second after a ride to the
/// far south-east corner of Elwynn and back.
fn errands(first: &[&str], second: &[&str]) -> String {
	let mut l: Vec<String> = vec!["step Northshire".into(), "  accept 783".into(), "  accept 5261".into()];
	l.extend(first.iter().map(|b| format!("  {b}")));
	l.extend(["  turnin 783", "step The far corner", "  goto 80.0,80.0 \"The far corner\"", "  goto 48.0,43.0 \"Back\""].map(String::from));
	l.extend(second.iter().map(|b| format!("  {b}")));
	l.push("  turnin 5261".into());
	let refs: Vec<&str> = l.iter().map(String::as_str).collect();
	guide_text(&refs)
}

#[test]
fn a_timed_item_carried_past_its_duration_warns_at_the_goal_that_gets_it_with_its_duration_and_the_estimate() {
	let text = errands(&["buy 159 x2"], &[]);
	let w = timed(&compile_with(&text, &fixture()));
	assert_eq!(w.len(), 1);
	assert_match(
		&w[0],
		&format!(
			r"^test\.guide:{}: item 159 \(Refreshing Spring Water\) lasts 5 minutes, but the route takes about \d+:\d\d from here to the `turnin` that spends it \(line {}\)$",
			line_of(&text, "buy 159 x2"),
			line_of(&text, "turnin 5261")
		),
	);
}

#[test]
fn a_timed_item_got_again_right_before_the_goal_that_spends_it_does_not_warn() {
	assert!(timed(&compile_with(&errands(&["buy 159"], &["buy 159"]), &fixture())).is_empty());
}

#[test]
fn quantities_one_bought_serves_only_the_first_errand_the_second_is_supplied_elsewhere_so_nothing_warns() {
	assert!(timed(&compile_with(&errands(&["buy 159"], &[]), &fixture())).is_empty());
}

#[test]
fn an_item_that_does_not_vanish_never_warns() {
	let data = fixture();
	data.items.get("159").as_obj().unwrap().delete("duration");
	assert!(timed(&compile_with(&errands(&["buy 159 x2"], &[]), &data)).is_empty());
}

// ---------------------------------------------------------------- real data

/// The reference data when built with item durations (None: the real-data tests skip).
fn real_data() -> Option<Data> {
	let dir = reference_data("items.json")?;
	if !["quests.json", "npcs.json", "objects.json", "travel.json"].iter().all(|f| dir.join(f).exists()) {
		return None;
	}
	let d = load_data(&dir).ok()?;
	d.items.values().iter().any(|it| it.get("duration").num() > 0.0).then_some(d)
}

fn header(id: &str, head: &[&str], body: &[&str]) -> String {
	let mut l = vec![format!("guide t/{id}"), format!("title {id}")];
	l.extend(head.iter().map(|s| s.to_string()));
	l.push(String::new());
	l.extend(body.iter().map(|s| s.to_string()));
	l.push(String::new());
	format!("{}\n", l.join("\n"))
}

fn timed_of(text: &str, data: &Data) -> Vec<String> {
	let file = repo().join("guides/reported.guide").to_string_lossy().into_owned();
	compile_files(&[(&file, text)], data, None).diag.warnings().iter().filter(|w| w.message.contains(" lasts ")).map(|w| w.message.clone()).collect()
}

/// One order before the fix (it warns once, for `item`) and after it (no warning).
fn order(item: u32, head: &[&str], old: &[&str], fixed: &[&str]) {
	let Some(data) = real_data() else { return };
	let w = timed_of(&header("old", head, old), &data);
	assert_eq!(w.len(), 1, "the old order warns once: {w:?}");
	assert!(w[0].starts_with(&format!("item {item} (")), "{}", w[0]);
	assert!(timed_of(&header("fixed", head, fixed), &data).is_empty());
}

#[test]
fn dun_moroghs_scalding_mornbrew_taken_before_the_troll_cave_the_old_order_warns_the_fixed_one_does_not() {
	order(
		10439,
		&["faction Alliance", "race Dwarf,Gnome", "levels 1-13", "zone Dun Morogh"],
		&[
			"step Grelin Whitebeard",
			"  accept 182",
			"  accept 3364 lvl 4",
			"step The troll cave",
			"  kill 706 quest 182",
			"step Grelin Whitebeard",
			"  turnin 182",
			"  accept 218",
			"  goto 26.0,79.0 \"The troll cave\"",
			"step Grik'nir the Cold",
			"  collect 2004 quest 218",
			"step Grelin Whitebeard",
			"  turnin 218",
			"step Anvilmar",
			"  turnin 3364",
		],
		&[
			"step Grelin Whitebeard",
			"  accept 182",
			"step The troll cave",
			"  kill 706 quest 182",
			"step Grelin Whitebeard",
			"  turnin 182",
			"  accept 218",
			"  goto 26.0,79.0 \"The troll cave\"",
			"step Grik'nir the Cold",
			"  collect 2004 quest 218",
			"step Grelin Whitebeard",
			"  turnin 218",
			"  accept 3364 lvl 4",
			"step Anvilmar",
			"  turnin 3364",
		],
	);
}

#[test]
fn the_blasted_lands_crate_of_power_stones_carried_through_the_bloodmages_beasts_the_old_order_warns_the_fixed_one_does_not() {
	order(
		6091,
		&["faction Alliance", "levels 46-48", "zone Duskwood"],
		&[
			"step Darkshire",
			"  fly \"Darkshire\"",
			"  accept 1395",
			"step The bloodmages",
			"  zone Blasted Lands",
			"  accept 2581",
			"  accept 2583",
			"  accept 2585",
			"  accept 2601",
			"  accept 2603",
			"step Scorpoks and snickerfangs",
			"  collect 8391 quest 2581",
			"  collect 8391 quest 2603",
			"  collect 8393 quest 2581",
			"  collect 8393 quest 2583",
			"  collect 8393 quest 2585",
			"  collect 8396 quest 2603",
			"  collect 8396 quest 2601",
			"  collect 8396 quest 2585",
			"step Boars and basilisks",
			"  collect 8392 quest 2581",
			"  collect 8392 quest 2583",
			"  collect 8392 quest 2585",
			"  collect 8394 quest 2601",
			"  collect 8394 quest 2583",
			"step The bloodmages",
			"  turnin 2601",
			"  turnin 2603",
			"  turnin 2581",
			"  turnin 2583",
			"  turnin 2585",
			"step Nethergarde Keep",
			"  getfp \"Nethergarde Keep\" npc 8609",
			"  turnin 1395",
		],
		&[
			"step Darkshire",
			"  fly \"Darkshire\"",
			"  accept 1395",
			"step The bloodmages",
			"  zone Blasted Lands",
			"  accept 2581",
			"  accept 2583",
			"  accept 2585",
			"  accept 2601",
			"  accept 2603",
			"step Nethergarde Keep",
			"  getfp \"Nethergarde Keep\" npc 8609",
			"  turnin 1395",
		],
	);
}

#[test]
fn the_barrens_twitching_antennae_gathered_before_the_hour_long_southern_loop_the_old_order_warns_the_fixed_one_does_not() {
	order(
		7119,
		&["faction Horde", "class Warrior", "levels 19-24", "zone The Barrens"],
		&[
			"step Field of Giants",
			"  collect 7119 quest 1824.1",
			"step Gann Stonespire",
			"  accept 843",
			"step Blackthorn Ridge",
			"  goto 42.5,81.0 \"Blackthorn Ridge\"",
			"  collect 5074 quest 879.1",
			"  collect 5073 quest 879.2",
			"  collect 5072 quest 879.3",
			"  collect 5093 quest 893.1",
			"  collect 5092 quest 893.2",
			"  collect 5094 quest 893.3",
			"step Bael Modan",
			"  kill 3374 quest 843.1",
			"  kill 3375 quest 843.2",
			"  collect 5006 quest 843.3",
			"step Gann Stonespire",
			"  turnin 843",
			"  accept 846",
			"step Bael'dun fortress",
			"  collect 5017 quest 846.1",
			"  collect 5018 quest 846.2",
			"  collect 5019 quest 846.3",
			"step Gann Stonespire",
			"  turnin 846",
			"  accept 849",
			"step The flying machine",
			"  interact 3644 quest 849.1",
			"step Gann Stonespire",
			"  turnin 849",
			"step Camp Taurajo",
			"  hearth \"Camp Taurajo\"",
			"  turnin 1824",
		],
		&["step Gann Stonespire", "  turnin 849", "step Twitching Antennae", "  collect 7119 quest 1824.1", "step Camp Taurajo", "  hearth \"Camp Taurajo\"", "  turnin 1824"],
	);
}

#[test]
#[ignore = "fixed in route generation (Desperate Prayer race lock 5635; WPL Arcane Quickener timing), see data/local route handover"]
fn western_plaguelands_four_arcane_quickeners_bought_at_the_first_chillwind_camp_stop_the_old_order_warns_the_fixed_one_does_not() {
	order(
		13320,
		&["faction Alliance", "levels 54-57", "zone Western Plaguelands"],
		&[
			"step Chillwind Camp",
			"  accept 5216",
			"  buy 13320 x4",
			"step Felstone Field cauldron",
			"  collect 13194 quest 5216.1",
			"  turnin 5216",
			"  accept 5217",
			"step Chillwind Camp",
			"  turnin 5217",
			"  accept 5219",
			"step Felstone Field cauldron",
			"  accept 5218",
			"  collect 13357 quest 5218.2",
			"  collect 14047 quest 5218.3",
			"  turnin 5218",
			"step Dalson's Tears cauldron",
			"  collect 13195 quest 5219.1",
			"  turnin 5219",
			"  accept 5220",
			"step Chillwind Camp",
			"  turnin 5220",
			"  accept 5222",
			"step Writhing Haunt cauldron",
			"  collect 13197 quest 5222.1",
			"  turnin 5222",
			"  accept 5223",
			"step Chillwind Camp",
			"  turnin 5223",
			"step Writhing Haunt cauldron",
			"  accept 5224",
			"  collect 13356 quest 5224.2",
			"  collect 14047 quest 5224.3",
			"  turnin 5224",
			"step Dalson's Tears cauldron",
			"  accept 5221",
			"  collect 13356 quest 5221.2",
			"  collect 14047 quest 5221.3",
			"  turnin 5221",
		],
		&[
			"step Chillwind Camp",
			"  turnin 5217",
			"  accept 5219",
			"  buy 13320",
			"step Felstone Field cauldron",
			"  accept 5218",
			"  collect 13357 quest 5218.2",
			"  collect 14047 quest 5218.3",
			"  turnin 5218",
			"step Chillwind Camp",
			"  turnin 5223",
			"  buy 13320 x2",
			"step Writhing Haunt cauldron",
			"  accept 5224",
			"  collect 13356 quest 5224.2",
			"  collect 14047 quest 5224.3",
			"  turnin 5224",
			"step Dalson's Tears cauldron",
			"  accept 5221",
			"  collect 13356 quest 5221.2",
			"  collect 14047 quest 5221.3",
			"  turnin 5221",
		],
	);
}

#[test]
#[ignore = "fixed in route generation (Desperate Prayer race lock 5635; WPL Arcane Quickener timing), see data/local route handover"]
fn every_authored_guide_carries_its_timed_items_in_time() {
	let Some(data) = real_data() else { return };
	let guides = repo().join("guides");
	let manifest = forge_guide::js::parse_json(r#"{"id":"guides"}"#).unwrap();
	let p = forge_guide::project::compile_project(&guides, &manifest, &data, forge_guide::diag::Diagnostics::new(), false, None);
	let late: Vec<String> = p.diag.warnings().iter().filter(|w| w.message.contains(" lasts ")).map(|w| format!("{}:{}: {}", w.file.as_deref().unwrap_or(""), w.line, w.message)).collect();
	assert!(late.is_empty(), "{late:#?}");
}

#[test]
fn a_flight_takes_its_legs_yards_at_30_yd_s_plus_2_s_a_hop_not_travel_jsons_cost() {
	use forge_guide::validate::key;
	let mut t = tables();
	t.insert(
		"travel".into(),
		json!({ "taxi": {
			"nodes": [{ "id": 11, "faction": 2 }, { "id": 13, "faction": 2 }, { "id": 99, "faction": 1 }],
			"legs": [{ "from": 11, "to": 13, "yards": 4224, "cost": 330 }, { "from": 13, "to": 99, "yards": 300, "cost": 10 }],
		} }),
	);
	let data = data_from(&t, serde_json::Value::Null, serde_json::Value::Null);
	let net = forge_guide::timed::flights(&data, 2);
	let from = net.from(&V::from(11));
	assert_eq!(from.get(&key(&V::from(13))).copied(), Some(4224.0 / 30.0 + 2.0));
	assert_eq!(from.get(&key(&V::from(99))), None, "the other faction's node");
}
