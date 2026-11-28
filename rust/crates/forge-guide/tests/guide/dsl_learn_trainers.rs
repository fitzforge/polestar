//! `learn <spell> npc <id>,<id>…`: the trainers who teach a recipe, when that is fewer than its rank's (the trainer a
//! player started with teaches only the first recipes of a profession). They become the goal's smart-target
//! `candidates`, so the arrow takes the nearest of the character's faction. The JS twin is
//! tests/dsl-learn-trainers.test.js.

use crate::common;
use common::*;
use serde_json::json;

const BOTH: [&str; 5] = ["guide t/both", "title Both", "levels 1-10", "zone Elwynn Forest", ""];

#[test]
fn a_learn_names_several_trainers_each_a_candidate_of_its_own_faction() {
	let mut l = BOTH.to_vec();
	l.extend(["step Learn Heavy Linen Bandage", "  learn 3276 npc 5150,3373"]);
	let r = compile(&guide_text(&l));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = r.steps()[0]["goals"][0].clone();
	let mut got: Vec<String> = g["candidates"].as_array().unwrap().iter().map(|c| format!("{} {}", c["npc"], c["faction"])).collect();
	got.sort();
	assert_eq!(got, vec!["3373 \"H\"".to_string(), "5150 \"A\"".to_string()]);
}

#[test]
fn one_npc_still_pins_the_learn_to_that_trainer() {
	let mut l = BOTH.to_vec();
	l.extend(["step Learn Heavy Linen Bandage", "  learn 3276 npc 5150"]);
	let r = compile(&guide_text(&l));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = r.steps()[0]["goals"][0].clone();
	assert_eq!(g["npc"], json!(5150));
	assert!(g.get("candidates").is_none());
}
