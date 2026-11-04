//! Escort quests (docs/GUIDE_FORMAT.md, "Escort quests"): the compiled `escort` of a goal (escort.rs), from
//! the quest's own words or a quests.json `escort` that the corrections set.

use crate::common;
use common::*;
use serde_json::{json, Value};

fn guide(body: &[&str]) -> String {
	let mut l = vec!["guide t/escort", "title Escort", "faction Alliance", "category Class", "levels 1-60", "zone Elwynn Forest", ""];
	l.extend_from_slice(body);
	format!("{}\n", l.join("\n"))
}

/// The compiled `escort` of the first step's goals (null: none).
fn escorts(body: &[&str]) -> Vec<Value> {
	let r = compile_with(&guide(body), &escort_data());
	assert!(r.errors.is_empty(), "{}", r.text);
	r.steps()[0]["goals"].as_array().unwrap().iter().map(|g| g.get("escort").cloned().unwrap_or(Value::Null)).collect()
}

#[test]
fn an_escort_quests_accept_objective_and_complete_goals_are_escort_its_turnin_is_not() {
	assert_eq!(escorts(&["step S", "  accept 9700", "  kill 6 quest 9700.2", "  complete 9700", "  turnin 9700"]), [json!(true), json!(true), json!(true), Value::Null]);
}

#[test]
fn a_quest_with_no_objectives_whose_objective_text_says_escort_is_one() {
	assert_eq!(escorts(&["step S", "  accept 9701", "  complete 9701", "  turnin 9701"]), [json!(true), json!(true), Value::Null]);
}

#[test]
fn an_event_objective_that_says_nothing_of_an_escort_a_kill_quest_and_a_goal_with_no_quest_are_not_escort() {
	assert_eq!(escorts(&["step S", "  accept 9704", "  complete 9704", "  accept 7", "  kill 6 quest 7", "  kill 6"]), vec![Value::Null; 5]);
}

#[test]
fn a_quests_json_escort_wins_over_the_quests_words_both_ways() {
	assert_eq!(escorts(&["step S", "  accept 9702", "  complete 9702", "  accept 9703", "  turnin 9703"]), [json!(true), json!(true), Value::Null, Value::Null]);
}

#[test]
fn the_compiled_escort_reaches_the_pack_escort_true_on_the_goal_in_guides_lua() {
	let r = compile_with(&guide(&["step S", "  accept 9700", "  turnin 9700"]), &escort_data());
	let lua = emit_sourced(&r.guides);
	assert_match(&lua, r#"t = "accept", quest = 9700, [^\n]*escort = true \},"#);
	assert_no_match(&lua, r#"t = "turnin", [^\n]*escort"#);
}

/// The reference data (built on the contributor's machine) with the corrections applied as the data build
/// applies them: the escorts the guides route by text, the ones worded otherwise, and Lost! (4492), whose
/// copied objective says escort. Skipped without the reference data.
#[test]
fn the_reference_data_escorts_by_their_words_and_by_corrections_lost_is_not_one() {
	let Some(dir) = reference_data("quests.json") else { return };
	let quests: Value = serde_json::from_slice(&std::fs::read(dir.join("quests.json")).unwrap()).unwrap();
	let corrections: Value = serde_json::from_slice(&std::fs::read(repo().join("forever-db/corrections/quests.json")).unwrap()).unwrap();
	let corrections = &corrections;
	let corrected = |id: &str| {
		let mut q = quests[id].clone();
		if let Some(set) = corrections[id]["set"].as_object() {
			for (k, x) in set {
				q[k] = x.clone();
			}
		}
		q
	};
	let is_escort = |q: &Value| forge_guide::escort::is_escort(&v(q));
	for id in ["155", "309", "2845", "87491", "99053", "99144"] {
		assert!(is_escort(&corrected(id)), "{id} {}", quests[id]["title"]);
	}
	for id in ["7", "1651", "4492"] {
		assert!(!is_escort(&corrected(id)), "{id} {}", quests[id]["title"]);
	}
	// Every escort correction says what the quest's words do not.
	for (id, c) in corrections.as_object().unwrap() {
		let Some(want) = c["set"]["escort"].as_bool() else { continue };
		if quests.get(id).is_none() {
			continue;
		}
		let mut uncorrected = corrected(id);
		uncorrected.as_object_mut().unwrap().remove("escort");
		assert_ne!(is_escort(&uncorrected), want, "{id}: the correction repeats what the text says");
	}
}
