//! The `deposit` and `equip` goals and the `equipped` and `indoors` when predicates (docs/GUIDE_FORMAT.md):
//! the verbs and the `off` modifier, the parser's predicates and errors, the emitted tables and pack format
//! 11. The addon side is an addon test.

use crate::common;
use common::*;
use forge_guide::format::{format_for, needs, DEPOSIT_EQUIP_FORMAT, FORMAT};
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
fn deposit_is_an_item_into_the_bank_until_the_bags_hold_none_or_the_bank_holds_a_count() {
	let r = compile(&guide_text(&["step Bank", "  deposit 750", "  deposit 750 x15 @47.6,35.1"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = goals(&r);
	assert_eq!(json!([g[0]["t"], g[0]["item"], g[0]["itemName"]]), json!(["deposit", 750, "Tough Wolf Meat"]));
	assert!(g[0].get("count").is_none());
	assert_eq!(json!([g[1]["count"], g[1]["x"], g[1]["y"]]), json!([15, 47.6, 35.1]));
	let out = emit(&r.guides);
	assert!(out.contains("{ t = \"deposit\", item = 750, itemName = \"Tough Wolf Meat\" },\n"), "{out}");
	assert!(out.contains("{ t = \"deposit\", item = 750, itemName = \"Tough Wolf Meat\", count = 15, map = 1429, x = 47.6, y = 35.1, f = \"e\" },\n"), "{out}");
	assert!(!compile(&guide_text(&["step Bank", "  deposit 999999"])).errors.is_empty(), "an item the data lacks needs its name");
	assert!(compile(&guide_text(&["step Bank", "  deposit 999999 \"New Thing\""])).errors.is_empty());
	assert!(compile(&guide_text(&["step Bank", "  deposit 750 quest 33.1"])).errors.iter().any(|e| e.contains("`quest` does not apply to `deposit`")));
	assert!(compile(&guide_text(&["step Bank", "  deposit"])).errors.iter().any(|e| e.contains("`deposit` needs an item id")));
}

#[test]
fn equip_is_an_item_to_wear_or_with_off_to_take_off() {
	let r = compile(&guide_text(&["step Gear", "  equip 750", "  equip 750 off optional"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = goals(&r);
	assert_eq!(json!([g[0]["t"], g[0]["item"]]), json!(["equip", 750]));
	assert!(g[0].get("off").is_none());
	assert_eq!(json!([g[1]["off"], g[1]["optional"]]), json!([true, true]));
	let out = emit(&r.guides);
	assert!(out.contains("{ t = \"equip\", item = 750, itemName = \"Tough Wolf Meat\" },\n"), "{out}");
	assert!(out.contains("{ t = \"equip\", off = true, item = 750, itemName = \"Tough Wolf Meat\", optional = true },\n"), "{out}");
	assert!(compile(&guide_text(&["step Gear", "  kill 6 off"])).errors.iter().any(|e| e.contains("`off` does not apply to `kill`")));
	assert!(compile(&guide_text(&["step Gear", "  deposit 750 off"])).errors.iter().any(|e| e.contains("`off` does not apply to `deposit`")));
}

#[test]
fn when_equipped_and_when_indoors() {
	assert_eq!(when("equipped 750"), json!({ "k": "equipped", "item": 750 }));
	assert_eq!(when("!equipped 750"), json!({ "k": "equipped", "neg": true, "item": 750 }));
	assert_eq!(when("indoors"), json!({ "k": "indoors" }));
	assert_eq!(when("!indoors"), json!({ "k": "indoors", "neg": true }));
	for bad in ["equipped", "equipped Sword", "equipped 0", "indoors now"] {
		assert!(parse_when(bad).is_err(), "{bad}");
	}
	let text = guide_text(&["step One", "  when !equipped 750", "  when indoors", "  skipto end when equipped 750", "  accept 783", "step Two", "  label end", "  turnin 783"]);
	let r = compile(&text);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(r.steps()[0]["when"], json!([{ "k": "equipped", "neg": true, "item": 750 }, { "k": "indoors" }]));
	assert_eq!(r.steps()[0]["skipto"], json!([{ "to": "end", "when": { "k": "equipped", "item": 750 } }]));
	let out = emit(&r.guides);
	assert!(out.contains("\t\t\t\t\twhen = { { k = \"equipped\", neg = true, item = 750 }, { k = \"indoors\" } },\n"), "{out}");
	assert!(out.contains("\t\t\t\t\tskipto = { { to = \"end\", when = { k = \"equipped\", item = 750 } } },\n"), "{out}");
	let unknown = guide_text(&["step One", "  when equipped 999999", "  accept 783"]);
	assert_eq!(compile(&unknown).warned("item 999999"), [format!("test.guide:{}: item 999999 is not in data (new Forever content?)", line_of(&unknown, "when equipped 999999"))]);
}

#[test]
fn a_guide_with_either_goal_or_either_predicate_is_written_in_format_11_read_by_polestar_0_4_1_and_later() {
	assert_eq!((DEPOSIT_EQUIP_FORMAT, needs(DEPOSIT_EQUIP_FORMAT)), (11, Some("0.4.1")));
	let step = |extra: Value| {
		let mut s = json!({ "goals": [{ "t": "accept", "quest": 1 }] });
		for (k, x) in extra.as_object().unwrap() {
			s[k] = x.clone();
		}
		guides(json!({ "steps": [s] }))
	};
	assert_eq!(format_for(&step(json!({}))), FORMAT);
	assert_eq!(format_for(&guides(json!({ "steps": [{ "goals": [{ "t": "deposit", "item": 1 }] }] }))), 11);
	assert_eq!(format_for(&guides(json!({ "steps": [{ "goals": [{ "t": "equip", "item": 1 }] }] }))), 11);
	assert_eq!(format_for(&step(json!({ "when": [{ "k": "equipped", "item": 1 }] }))), 11);
	assert_eq!(format_for(&step(json!({ "when": [{ "k": "indoors" }] }))), 11);
	assert_eq!(format_for(&step(json!({ "skipto": [{ "to": "end", "when": { "k": "indoors", "neg": true } }] }))), 11);
	assert_eq!(format_for(&guides(json!({ "steps": [{ "goals": [{ "t": "accept", "quest": 1 }] }], "nextWhen": { "a/b": [{ "k": "equipped", "item": 1 }] } }))), 11);
}
