//! The play checks (play_rules.rs, docs/GUIDE_FORMAT.md "Play checks"): each fires on the pattern players
//! reported, stays quiet on the steps that are right (gated, gathered in the step, optional, the same `when`),
//! is a warning in another pack, and yields to an entry of data/lint-allow.json; an entry that matches nothing
//! warns and one without a reason is an error.

use crate::common;
use common::*;
use forge_guide::data::Data;
use serde_json::{json, Map, Value};

fn q(id: u32, extra: Value) -> Value {
	let mut base = json!({ "id": id, "title": format!("Quest {id}"), "level": 2, "minLevel": 1, "races": null, "classes": null, "start": { "npc": [823], "object": [], "item": [] }, "end": { "npc": [823], "object": [] }, "pre": [], "excl": [], "objectives": [] });
	for (k, x) in extra.as_object().unwrap() {
		base[k] = x.clone();
	}
	base
}

/// 9600: handed in on the spot for a Linen Cloth (2589), as An Apple Treat for its Thunder Applejack. 9601: talk to
/// Marshal McBride (197), then kill Kobold Vermin (6). 9602: started by a Shadowgem (1210). 9603: needs level 9.
fn play_data() -> Data {
	let mut t: Map<String, Value> = tables();
	let add = json!({
		"9600": q(9600, json!({ "direct": true, "objectives": [{ "type": "item", "id": 2589, "count": 1, "text": "Linen Cloth" }] })),
		"9601": q(9601, json!({ "objectives": [{ "type": "talk", "id": 197, "count": 1, "text": "Speak with Marshal McBride" }, { "type": "kill", "id": 6, "count": 2, "text": "Kobold Vermin slain" }] })),
		"9602": q(9602, json!({ "start": { "npc": [], "object": [], "item": [1210] } })),
		"9603": q(9603, json!({ "minLevel": 9, "level": 10, "xp": 100 })),
		"9604": q(9604, json!({ "sourceItem": 159 })),
	});
	for (k, x) in add.as_object().unwrap() {
		t.get_mut("quests").unwrap()[k] = x.clone();
	}
	data_from(&t, Value::Null, Value::Null)
}

fn with_allow(entries: Value) -> Data {
	let mut d = play_data();
	d.lint_allow = v(&entries);
	d
}

fn run(lines: &[&str], data: &Data) -> Compiled {
	compile_with(&guide_text(lines), data)
}

fn other_pack(lines: &[&str], data: &Data) -> Compiled {
	compile_files(&[("test.guide", &guide_text(lines))], data, Some("other"))
}

#[test]
fn a_required_direct_hand_in_that_takes_items_needs_a_when_has_for_them() {
	let d = play_data();
	let bare = guide_text(&["step De Vries", "  turnin 9600 direct"]);
	assert_eq!(
		compile_with(&bare, &d).erred("from the bags"),
		[format!(
			"test.guide:{}: `turnin 9600 (Quest 9600) direct` takes Linen Cloth (2589) from the bags, but the step has no `when has` for it: a player without it is held at a hand-in the giver never offers",
			line_of(&bare, "  turnin 9600 direct")
		)]
	);
	assert!(compile_with(&bare, &d).diag.errors().iter().any(|e| e.hint.as_deref().is_some_and(|h| h.contains("`when has 2589`") && h.contains("rule `direct-gate`"))));
	// Gated, gathered earlier in the step, or optional: right.
	assert!(run(&["step De Vries", "  when has 2589", "  turnin 9600 direct"], &d).erred("from the bags").is_empty());
	assert!(run(&["step De Vries", "  collect 2589 x1", "  turnin 9600 direct"], &d).erred("from the bags").is_empty());
	assert!(run(&["step De Vries", "  turnin 9600 direct optional"], &d).erred("from the bags").is_empty());
	// Gathered after the hand-in in the same step is no help.
	assert_eq!(run(&["step De Vries", "  turnin 9600 direct", "  collect 2589 x1"], &d).erred("from the bags").len(), 1);
	// Another pack: a warning.
	let o = other_pack(&["step De Vries", "  turnin 9600 direct"], &d);
	assert!(o.erred("from the bags").is_empty());
	assert_eq!(o.warned("from the bags").len(), 1);
}

#[test]
fn a_kill_on_a_talk_line_is_an_error() {
	let d = play_data();
	let text = guide_text(&["step S", "  accept 9601", "  kill 197 quest 9601.1", "  kill 6 quest 9601.2", "  turnin 9601"]);
	assert_eq!(
		compile_with(&text, &d).erred("talking to"),
		[format!(
			"test.guide:{}: `kill` on quest 9601 (Quest 9601)'s line 1, which the game counts by talking to Marshal McBride: the step tells the player to kill an NPC they are meant to speak to",
			line_of(&text, "  kill 197 quest 9601.1")
		)]
	);
	// The line found from the npc alone counts too; `talk` is right.
	assert_eq!(run(&["step S", "  accept 9601", "  kill 197 quest 9601", "  turnin 9601"], &d).erred("talking to").len(), 1);
	assert!(run(&["step S", "  accept 9601", "  talk 197 quest 9601.1", "  kill 6 quest 9601.2", "  turnin 9601"], &d).erred("talking to").is_empty());
}

#[test]
fn an_item_only_skippable_goals_get_holds_the_goal_that_needs_it() {
	let d = play_data();
	let held = |lines: &[&str]| run(lines, &d).erred("in the bags");
	// Only an optional buy gets it.
	let text = guide_text(&["step Buy", "  buy 159 x1 optional", "step Drink", "  use 159"]);
	assert_eq!(
		compile_with(&text, &d).erred("in the bags"),
		[format!(
			"test.guide:{}: `use` needs Refreshing Spring Water (159) in the bags, but every earlier goal that gets it is `optional` or in a step with a `when` this step does not share: a player who passed them is held here",
			line_of(&text, "  use 159")
		)]
	);
	// A step with a `when` the using step does not share; the same `when` is right.
	assert_eq!(held(&["step Buy", "  when level<5", "  buy 159 x1", "step Drink", "  use 159"]).len(), 1);
	assert!(held(&["step Buy", "  when level<5", "  buy 159 x1", "step Drink", "  when level<5", "  use 159"]).is_empty());
	// A buy only when the bags lack it leaves no one without it; a required one is sure; a gate is right.
	assert!(held(&["step Buy", "  when !has 159", "  buy 159 x1", "step Drink", "  use 159"]).is_empty());
	assert!(held(&["step Buy", "  buy 159 x1", "step Drink", "  use 159"]).is_empty());
	assert!(held(&["step Buy", "  buy 159 x1 optional", "step Drink", "  when has 159", "  use 159"]).is_empty());
	// The step holds the quest whose accept hands it over (`when onquest`): that accept ran.
	assert!(held(&["step Take", "  accept 9604 optional", "step Drink", "  when onquest 9604", "  use 159"]).is_empty());
	assert_eq!(held(&["step Take", "  accept 9604 optional", "step Drink", "  use 159"]).len(), 1);
	// No goal gets it at all: not this check's (the item may be the player's own).
	assert!(held(&["step Drink", "  use 159"]).is_empty());
	// A quest only an item starts.
	assert_eq!(held(&["step Loot", "  collect 1210 x1 optional", "step Read", "  accept 9602"]).len(), 1);
	assert!(held(&["step Loot", "  collect 1210 x1", "step Read", "  accept 9602"]).is_empty());
}

#[test]
fn a_required_accept_the_giver_cannot_offer_is_an_error_an_optional_or_waiting_one_a_warning() {
	// 7 needs 783 turned in first.
	let needs = |lines: &[&str]| compile(&guide_text(lines));
	assert_eq!(needs(&["step S", "  accept 7"]).erred("turned in first").len(), 1);
	let opt = needs(&["step S", "  accept 7 optional"]);
	assert!(opt.erred("turned in first").is_empty());
	assert_eq!(opt.warned("turned in first").len(), 1);
	let waits = needs(&["step S", "  when available 7", "  accept 7"]);
	assert!(waits.erred("turned in first").is_empty());
	assert!(needs(&["step S", "  accept 783", "  turnin 783", "  accept 7"]).erred("turned in first").is_empty());
	// A step that waits for the prerequisite holds no gap.
	assert!(needs(&["step S", "  when turnedin 783", "  accept 7"]).erred("turned in first").is_empty());
	// Below the quest's level where the route plausibly is; a step waiting for the level only warns.
	let d = play_data();
	assert_eq!(run(&["step S", "  accept 9603"], &d).erred("needs level 9").len(), 1);
	let wait = run(&["step S", "  when level>=9", "  accept 9603"], &d);
	assert!(wait.erred("needs level 9").is_empty());
	assert_eq!(wait.warned("needs level 9").len(), 1);
}

#[test]
fn an_allow_entry_covers_its_step_and_one_covering_nothing_or_without_a_reason_is_reported() {
	let entry = |reason: &str| json!([{ "rule": "direct-gate", "guide": "t/main", "quest": 9600, "reason": reason }]);
	let bare = ["step De Vries", "  turnin 9600 direct"];
	let ok = run(&bare, &with_allow(entry("the giver takes it any time")));
	assert!(ok.erred("from the bags").is_empty(), "{}", ok.text);
	assert!(ok.warnings.iter().all(|w| !w.contains("lint-allow")), "{}", ok.text);
	// Another rule or guide does not cover it.
	let wrong = json!([{ "rule": "talk-kill", "guide": "t/main", "quest": 9600, "reason": "r" }]);
	let r = run(&bare, &with_allow(wrong));
	assert_eq!(r.erred("from the bags").len(), 1);
	assert_eq!(r.warned("matches no step").len(), 1);
	assert_eq!(r.warned("matches no step")[0], "data/lint-allow.json:0: allow entry talk-kill on t/main (quest 9600) matches no step: drop it");
	// No reason.
	assert_eq!(run(&bare, &with_allow(entry(" "))).erred("has no reason"), ["data/lint-allow.json:0: allow entry direct-gate on t/main (quest 9600) has no reason"]);
	// An entry for a guide this compile does not hold is left alone.
	let elsewhere = json!([{ "rule": "direct-gate", "guide": "t/other", "quest": 9600, "reason": "r" }]);
	assert!(run(&["step S", "  level 2"], &with_allow(elsewhere)).diagnostics().is_empty());
}

#[test]
fn the_allow_list_is_read_from_beside_the_data_folder() {
	let dir = scratch("lint-allow");
	let data = dir.join("forever");
	std::fs::create_dir_all(&data).unwrap();
	for e in std::fs::read_dir(data_dir()).unwrap().flatten() {
		std::fs::copy(e.path(), data.join(e.file_name())).unwrap();
	}
	std::fs::write(dir.join("lint-allow.json"), r#"{ "allow": [{ "rule": "offer", "guide": "t/main", "quest": 7, "reason": "r" }] }"#).unwrap();
	let d = forge_guide::data::load_data(&data).unwrap();
	assert_eq!(d.lint_allow.items().len(), 1);
	assert!(compile_with(&guide_text(&["step S", "  accept 7"]), &d).erred("turned in first").is_empty());
}
