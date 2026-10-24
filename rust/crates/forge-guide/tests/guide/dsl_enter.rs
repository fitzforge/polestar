//! `enter "<Place>"` (docs/GUIDE_FORMAT.md, "Goals"): be in a zone or an area, by the name the game
//! shows. The parser's goal and its error, the area ID the resolver gives the place (as for `hearth`), the
//! warning for a name that is no zone or area, the emitted table and the pack format. Fixture data:
//! tests/fixtures/dsl/data, plus an AreaTable made here (Goldshire is area 87 in Elwynn Forest, 12).

use crate::common;
use common::*;
use forge_guide::data::Data;
use forge_guide::format::{format_for, MONEY_TASK_FORMAT};
use serde_json::{json, Value};

fn area_data() -> Data {
	data_from(&tables(), Value::Null, areas(&[(12, "Elwynn Forest", 0), (87, "Goldshire", 12)]))
}

#[test]
fn enter_takes_a_quoted_place_with_coordinates_for_the_arrow() {
	let text = guide_text(&["step Goldshire", "  enter \"Goldshire\" @42.1,65.9", "step Into the forest", "  enter \"Elwynn Forest\""]);
	let (ast, errors) = parse(&text);
	assert!(errors.is_empty(), "{errors:?}");
	let g = plain(&ast)["steps"].clone();
	assert_eq!(g[0]["goals"][0]["verb"], "enter");
	assert_eq!(g[0]["goals"][0]["location"], "Goldshire");
	assert_eq!(g[0]["goals"][0]["x"], 42.1);
	assert_eq!(g[1]["goals"][0]["location"], "Elwynn Forest");
}

#[test]
fn enter_without_a_place_is_an_error_at_its_line() {
	let text = guide_text(&["step One", "  enter", "  note Go on."]);
	assert_eq!(parse(&text).1, vec![format!("{}: `enter` needs a \"Location\"", line_of(&text, "enter"))]);
}

#[test]
fn the_place_gets_its_area_id_a_zone_or_an_area_one_that_is_neither_warns() {
	let text = guide_text(&["step A", "  enter \"Goldshire\"", "step B", "  enter \"Elwynn Forest\"", "step C", "  enter \"Goldshiree\""]);
	let r = compile_with(&text, &area_data());
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(
		first_goals(&r),
		vec![json!({ "t": "enter", "location": "Goldshire", "area": 87 }), json!({ "t": "enter", "location": "Elwynn Forest", "area": 12 }), json!({ "t": "enter", "location": "Goldshiree" })]
	);
	assert_eq!(
		r.warned("enter"),
		vec![format!("test.guide:{}: enter \"Goldshiree\": no zone or area has that name; the game never reports it, so the goal never checks off by itself", line_of(&text, "enter \"Goldshiree\""))]
	);
	// The fixture data has no AreaTable: the name is not checked, and no area ID.
	let bare = compile(&guide_text(&["step A", "  enter \"Goldshire\""]));
	assert!(bare.warned("enter").is_empty());
	assert_eq!(first_goals(&bare)[0], json!({ "t": "enter", "location": "Goldshire" }));
}

#[test]
fn the_emitted_goal_carries_the_place_and_its_area_and_the_pack_is_written_in_format_5() {
	let r = compile_with(&guide_text(&["step A", "  enter \"Goldshire\""]), &area_data());
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_match(&emit(&r.guides), r#"\{ t = "enter", location = "Goldshire", area = 87 \}"#);
	assert_eq!(format_for(&r.guides), MONEY_TASK_FORMAT);
}
