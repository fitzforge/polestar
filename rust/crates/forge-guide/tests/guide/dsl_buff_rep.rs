//! The `buff` goal, a `rep` goal's points and the `rep` and `buff` when predicates (docs/GUIDE_FORMAT.md):
//! the parser's predicates and errors, the faction id the resolver gives a `rep` predicate (the engine reads a
//! standing by id), the emitted tables and pack format 11. The addon side is an addon test.

use crate::common;
use common::*;
use forge_guide::format::{format_for, needs, BUFF_REP_FORMAT, FORMAT, MONEY_TASK_FORMAT};
use forge_guide::js::{parse_json, V};
use forge_guide::when::parse_when;
use serde_json::{json, Value};

fn when(rest: &str) -> Value {
	plain(&parse_when(rest).unwrap_or_else(|e| panic!("{rest}: {}", e.error)))
}

fn goals(r: &Compiled) -> Vec<Value> {
	r.steps()[0]["goals"].as_array().unwrap().clone()
}

fn guides(j: Value) -> Vec<V> {
	vec![parse_json(&j.to_string()).unwrap()]
}

#[test]
fn when_rep_reads_a_faction_by_name_or_id_a_standing_by_word_or_number_and_points_inside_it() {
	assert_eq!(when("rep \"Stormwind\" Honored"), json!({ "k": "rep", "name": "Stormwind", "standing": 6 }));
	assert_eq!(when("!rep Stormwind Friendly"), json!({ "k": "rep", "neg": true, "name": "Stormwind", "standing": 5 }));
	assert_eq!(when("rep Argent Dawn Revered+12000"), json!({ "k": "rep", "name": "Argent Dawn", "standing": 7, "points": 12000 }));
	assert_eq!(when("rep 72 7"), json!({ "k": "rep", "faction": 72, "standing": 7 }));
	assert_eq!(when("rep \"72\" Neutral+1"), json!({ "k": "rep", "name": "72", "standing": 4, "points": 1 }), "a quoted number is a name");
	for bad in ["rep", "rep Stormwind", "rep Stormwind Liked", "rep Stormwind 9", "rep Stormwind Honored+0", "rep Stormwind Exalted+1000", "rep Stormwind Hated"] {
		assert!(parse_when(bad).is_err(), "{bad}");
	}
	assert!(parse_when("rep Stormwind Hated+1").is_ok(), "points into Hated can fail to hold");
}

#[test]
fn when_buff_reads_an_aura_by_spell_id() {
	assert_eq!(when("buff 1126"), json!({ "k": "buff", "spell": 1126 }));
	assert_eq!(when("!buff 1126"), json!({ "k": "buff", "neg": true, "spell": 1126 }));
	for bad in ["buff", "buff 0", "buff \"Mark of the Wild\"", "buff 1 2"] {
		assert!(parse_when(bad).is_err(), "{bad}");
	}
}

#[test]
fn a_rep_predicate_compiles_with_the_id_of_its_faction_on_a_step_a_jump_and_a_hand_off() {
	let text = guide_text(&[
		"step One",
		"  when rep Stormwind Honored",
		"  when !rep 72 Revered+500",
		"  when !buff 1126",
		"  skipto end when rep \"Stormwind\" Exalted",
		"  accept 783",
		"step Two",
		"  label end",
		"  turnin 783",
	]);
	let r = compile(&text);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(
		r.steps()[0]["when"],
		json!([
			{ "k": "rep", "name": "Stormwind", "faction": 72, "standing": 6 },
			{ "k": "rep", "neg": true, "name": "Stormwind", "faction": 72, "standing": 7, "points": 500 },
			{ "k": "buff", "neg": true, "spell": 1126 },
		])
	);
	assert_eq!(r.steps()[0]["skipto"], json!([{ "to": "end", "when": { "k": "rep", "name": "Stormwind", "faction": 72, "standing": 8 } }]));
	let out = emit(&r.guides);
	assert!(
		out.contains(
			"\t\t\t\t\twhen = { { k = \"rep\", name = \"Stormwind\", faction = 72, standing = 6 }, { k = \"rep\", neg = true, name = \"Stormwind\", faction = 72, standing = 7, points = 500 }, { k = \"buff\", neg = true, spell = 1126 } },\n"
		),
		"{out}"
	);
	assert!(out.contains("\t\t\t\t\tskipto = { { to = \"end\", when = { k = \"rep\", name = \"Stormwind\", faction = 72, standing = 8 } } },\n"), "{out}");

	let follower = lines(&["guide t/friend", "title Friend", "faction Alliance", "levels 10-20", "zone Elwynn Forest", "pitch For friends of the city.", "", "step Start", "  note Go on.", ""]);
	let main = lines(&["guide t/main", "title Main", "faction Alliance", "levels 1-10", "zone Elwynn Forest", "next t/friend when rep Stormwind Friendly", "", "step Start", "  note Go on.", ""]);
	let n = compile_files(&[("main.guide", &main), ("friend.guide", &follower)], &fixture_data(), None);
	assert!(n.errors.is_empty(), "{}", n.text);
	assert_eq!(plain(&n.guide("t/main").get("nextWhen")), json!({ "t/friend": [{ "k": "rep", "name": "Stormwind", "faction": 72, "standing": 5 }] }));
	assert_eq!(format_for(&n.guides), BUFF_REP_FORMAT);
}

#[test]
fn a_faction_the_data_does_not_know_is_an_error_by_name_and_a_warning_by_id() {
	let unknown = guide_text(&["step One", "  when rep Nobody Honored", "  accept 783"]);
	assert_eq!(compile(&unknown).errors, [format!("test.guide:{}: unknown faction \"Nobody\"; give its id: `rep <factionId> <Standing>`", line_of(&unknown, "when rep Nobody Honored"))]);
	let by_id = compile(&guide_text(&["step One", "  when rep 4242 Honored", "  accept 783"]));
	assert!(by_id.errors.is_empty(), "{}", by_id.text);
	assert_eq!(by_id.steps()[0]["when"], json!([{ "k": "rep", "faction": 4242, "standing": 6 }]));
	assert_eq!(by_id.warned("faction 4242 is not in data").len(), 1);
}

#[test]
fn a_rep_goal_takes_points_inside_its_standing_and_every_standing_by_name() {
	let r = compile(&guide_text(&["step One", "  rep Stormwind Revered+12000", "  rep 72 Honored", "  rep Stormwind Unfriendly"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = goals(&r);
	assert_eq!(json!([g[0]["t"], g[0]["faction"], g[0]["standing"], g[0]["points"]]), json!(["rep", 72, 7, 12000]));
	assert!(g[1].get("points").is_none());
	assert_eq!(g[2]["standing"], 3);
	let out = emit(&r.guides);
	assert!(out.contains("{ t = \"rep\", faction = 72, factionName = \"Stormwind\", standing = 7, points = 12000 },\n"), "{out}");
	assert!(out.contains("{ t = \"rep\", faction = 72, factionName = \"Stormwind\", standing = 6 },\n"), "{out}");
	assert!(compile(&guide_text(&["step One", "  rep Stormwind Revered+0"])).errors.iter().any(|e| e.contains("points inside a standing start at 1")));
	assert!(compile(&guide_text(&["step One", "  rep Stormwind Exalted+1000"])).errors.iter().any(|e| e.contains("Exalted has 999 points at most")));
}

#[test]
fn a_buff_goal_is_the_aura_to_have_or_with_off_to_be_rid_of_and_its_name_is_required() {
	let r = compile(&guide_text(&["step One", "  buff 1126 \"Mark of the Wild\" @47.6,35.1", "  buff 15007 \"Resurrection Sickness\" off optional"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = goals(&r);
	assert_eq!(json!([g[0]["t"], g[0]["spell"], g[0]["spellName"], g[0]["x"], g[0]["y"]]), json!(["buff", 1126, "Mark of the Wild", 47.6, 35.1]));
	assert!(g[0].get("off").is_none());
	assert_eq!(json!([g[1]["t"], g[1]["spell"], g[1]["off"], g[1]["optional"]]), json!(["buff", 15007, true, true]));
	let out = emit(&r.guides);
	assert!(out.contains("{ t = \"buff\", spell = 1126, spellName = \"Mark of the Wild\", map = 1429, x = 47.6, y = 35.1, f = \"e\" },\n"), "{out}");
	assert!(out.contains("{ t = \"buff\", spell = 15007, spellName = \"Resurrection Sickness\", off = true, optional = true },\n"), "{out}");
	let text = guide_text(&["step One", "  buff 999999"]);
	assert_eq!(compile(&text).errors, [format!("test.guide:{}: spell 999999 is not in data; give its name: `buff 999999 \"Name\"`", line_of(&text, "buff 999999"))]);
	assert!(compile(&guide_text(&["step One", "  kill 6 off"])).errors.iter().any(|e| e.contains("`off` does not apply to `kill`")));
}

#[test]
fn a_guide_with_any_of_them_is_written_in_format_11_read_by_polestar_0_4_1_and_later() {
	assert_eq!((BUFF_REP_FORMAT, needs(BUFF_REP_FORMAT)), (11, Some("0.4.1")));
	let step = |extra: Value| {
		let mut s = json!({ "goals": [{ "t": "task", "text": "x" }] });
		for (k, x) in extra.as_object().unwrap() {
			s[k] = x.clone();
		}
		guides(json!({ "steps": [s] }))
	};
	assert_eq!(format_for(&step(json!({}))), MONEY_TASK_FORMAT);
	assert_eq!(format_for(&step(json!({ "when": [{ "k": "rep", "faction": 72, "standing": 6 }] }))), 11);
	assert_eq!(format_for(&step(json!({ "when": [{ "k": "buff", "spell": 1 }] }))), 11);
	assert_eq!(format_for(&step(json!({ "skipto": [{ "to": "end", "when": { "k": "buff", "spell": 1 } }] }))), 11);
	assert_eq!(format_for(&guides(json!({ "steps": [{ "goals": [{ "t": "buff", "spell": 1, "spellName": "A" }] }] }))), 11);
	assert_eq!(format_for(&guides(json!({ "steps": [{ "goals": [{ "t": "rep", "faction": 72, "standing": 6, "points": 100 }] }] }))), 11);
	assert_eq!(format_for(&guides(json!({ "steps": [{ "goals": [{ "t": "rep", "faction": 72, "standing": 6 }] }] }))), FORMAT, "a plain `rep` goal is as old as format 3");
	assert_eq!(format_for(&guides(json!({ "steps": [{ "goals": [{ "t": "accept", "quest": 1 }] }], "nextWhen": { "a/b": [{ "k": "rep", "faction": 72, "standing": 6 }] } }))), 11);
}
