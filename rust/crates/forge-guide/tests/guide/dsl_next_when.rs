//! `next <id> when <predicate>` (docs/GUIDE_FORMAT.md, "Conditional hand-offs"): the header line repeats,
//! each line adding its guides in order; an option with `when` is offered only while its predicate holds at
//! the hand-off. The parser, the resolver's `nextChoices`/`nextWhen`, the checks on `next`, the emitted table
//! and import data and the pack format it needs. Fixture data: tests/fixtures/dsl/data.

use crate::common;
use common::*;
use forge_guide::format::{format_for, FORMAT, WHEN_FORMAT};
use serde_json::{json, Value};

/// A guide `t/<id>` for Alliance, levels 1-10, with `head` lines after its header.
fn guide(id: &str, head: &[&str], body: &[&str]) -> String {
	let (g, t) = (format!("guide t/{id}"), format!("title {id}"));
	let mut l = vec![g.as_str(), t.as_str(), "faction Alliance", "levels 1-10", "zone Elwynn Forest"];
	l.extend_from_slice(head);
	l.push("");
	l.extend_from_slice(body);
	format!("{}\n", l.join("\n"))
}

const BODY: [&str; 4] = ["step One", "  accept 783", "step Two", "  turnin 783"];

/// The main guide with `head`, and guides b, c, d to go on to (each with a pitch).
fn chain(head: &[&str]) -> Vec<(String, String)> {
	let other = |id: &str| guide(id, &[&format!("pitch Level in {id}.")], &["step One", "  accept 7", "step Two", "  turnin 7"]);
	vec![("main.guide".into(), guide("main", head, &BODY)), ("b.guide".into(), other("b")), ("c.guide".into(), other("c")), ("d.guide".into(), other("d"))]
}

fn compile_chain(files: &[(String, String)]) -> Compiled {
	let refs: Vec<(&str, &str)> = files.iter().map(|(a, b)| (a.as_str(), b.as_str())).collect();
	compile_map(&refs)
}

fn main_of(r: &Compiled) -> Value {
	plain(&r.guide("t/main"))
}

#[test]
fn next_repeats_each_line_adds_its_guides_in_order_next_id_when_with_its_predicate_and_line() {
	let text = guide("main", &["next t/b when level>=5", "next t/c", "next t/d, t/e when onquest 783", "next t/f when !has 159 x2"], &["step One", "  accept 783"]);
	let (ast, errors) = parse(&text);
	// `when` on a line naming two guides is an error; the other lines stand.
	assert_eq!(errors, vec![format!("{}: `next ... when` names one guide: `next <id> when <predicate>`, one line per guide", line_of(&text, "next t/d, t/e when onquest 783"))]);
	let a = plain(&ast);
	assert_eq!(a["header"]["next"], json!(["t/b", "t/c", "t/f"]));
	assert_eq!(
		a["header"]["nextWhen"],
		json!({
			"t/b": { "k": "level", "op": ">=", "n": 5, "line": line_of(&text, "next t/b when level>=5") },
			"t/f": { "k": "has", "neg": true, "item": 159, "n": 2, "line": line_of(&text, "next t/f when !has 159 x2") },
		})
	);
	assert_eq!(a["lines"]["next"], json!(line_of(&text, "next t/b when level>=5")));
	assert_eq!(a["lines"]["nextOf"], json!({ "t/b": line_of(&text, "next t/b when level>=5"), "t/c": line_of(&text, "next t/c"), "t/f": line_of(&text, "next t/f when !has 159 x2") }));
}

#[test]
fn a_malformed_conditional_next_is_an_error_at_its_line() {
	for (line, message) in [
		("next t/b when", "`when` needs a predicate"),
		("next t/b when weather<1", "unknown `when` predicate \"weather<1\""),
		("next t/b when level<70", "level 70 is out of range (1-60)"),
		("next \"t/b\" when level<5", "malformed guide id \"\"t/b\"\" in `next`"),
		("next T/B when level<5", "malformed guide id \"T/B\" in `next`"),
	] {
		let text = guide("main", &[line], &["step One", "  accept 783"]);
		assert_eq!(parse(&text).1, vec![format!("{}: {message}", line_of(&text, line))], "{line}");
	}
	// One condition per guide: naming it again, with or without `when`, is an error.
	for again in ["next t/b", "next t/b when level<3", "next t/c, t/b"] {
		let text = guide("main", &["next t/b when level>=5", again], &["step One", "  accept 783"]);
		let (ast, errors) = parse(&text);
		assert_eq!(errors, vec![format!("{}: `next` names the same guide twice", line_of(&text, again))], "{again}");
		assert_eq!(plain(&ast.get("header").get("next")), json!(["t/b"]), "{again}");
	}
}

#[test]
fn the_comma_form_and_several_plain_next_lines_compile_alike_with_no_next_when() {
	let one = compile_chain(&chain(&["next t/b, t/c"]));
	let two = compile_chain(&chain(&["next t/b", "next t/c"]));
	assert!(one.errors.is_empty(), "{}", one.text);
	assert!(two.errors.is_empty(), "{}", two.text);
	assert_eq!(main_of(&two), main_of(&one));
	let m = main_of(&one);
	assert_eq!(m["next"], "t/b");
	assert_eq!(m["nextChoices"], json!(["t/b", "t/c"]));
	assert!(m.get("nextWhen").is_none());
	// A single plain `next` stays a plain hand-off.
	let single = main_of(&compile_chain(&chain(&["next t/b"])));
	assert_eq!(single["next"], "t/b");
	assert!(single.get("nextChoices").is_none());
}

#[test]
fn the_resolver_keeps_each_options_predicate_for_the_engine_and_lists_the_options_even_when_there_is_one() {
	let r = compile_chain(&chain(&["next t/b when zone \"Elwynn Forest\"", "next t/c when available 7", "next t/d"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let m = main_of(&r);
	assert_eq!(m["next"], "t/b");
	assert_eq!(m["nextChoices"], json!(["t/b", "t/c", "t/d"]));
	assert_eq!(m["nextWhen"], json!({ "t/b": [{ "k": "zone", "name": "Elwynn Forest", "area": 12 }], "t/c": [{ "k": "available", "q": 7, "minLevel": 1, "pre": [783] }] }));
	let lone = main_of(&compile_chain(&chain(&["next t/b when level<8"])));
	assert_eq!(lone["next"], "t/b");
	assert_eq!(lone["nextChoices"], json!(["t/b"]));
	assert_eq!(lone["nextWhen"], json!({ "t/b": [{ "k": "level", "op": "<", "n": 8 }] }));
}

#[test]
fn the_checks_on_next_point_at_the_line_naming_the_guide_one_option_is_no_route_choice() {
	let sources = chain(&["next t/b when level<8", "next t/zz when level>=8"]);
	let r = compile_chain(&sources);
	let text = &sources[0].1;
	assert_eq!(r.errors, vec![format!("main.guide:{}: `next` points to unknown guide \"t/zz\"", line_of(text, "next t/zz when level>=8"))]);
	// The predicate's own warnings come at its line too.
	let unknown = chain(&["next t/b when onquest 424242"]);
	let warned = compile_chain(&unknown).warnings;
	let want = format!("main.guide:{}: quest 424242 is not in data (new Forever content?)", line_of(&unknown[0].1, "next t/b when onquest 424242"));
	assert!(warned.contains(&want), "{}", warned.join("\n"));
	// A pitch is asked of a route choice's options only when there are two or more.
	let pitchless = |head: &[&str]| {
		let mut s = chain(head);
		s[1].1 = guide("b", &[], &["step One", "  accept 7", "step Two", "  turnin 7"]);
		compile_chain(&s).warned("has no `pitch`").len()
	};
	assert_eq!(pitchless(&["next t/b when level<8"]), 0);
	assert_eq!(pitchless(&["next t/b when level<8", "next t/c"]), 1);
}

#[test]
fn the_emitted_guide_carries_next_when_after_next_choices_in_the_options_order_and_the_predicates_key_order() {
	let r = compile_chain(&chain(&["next t/c", "next t/b when !onquest 783,7", "next t/d when level>=5"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let main = r.guide("t/main");
	assert_match(
		&emit(std::slice::from_ref(&main)),
		r#"\n\t\t\tnextChoices = \{ "t/c", "t/b", "t/d" \},\n\t\t\tnextWhen = \{ \["t/b"\] = \{ \{ k = "onquest", neg = true, q = \{ 783, 7 \} \} \}, \["t/d"\] = \{ \{ k = "level", op = ">=", n = 5 \} \} \},\n\t\t\tauthor = "#,
	);
	// An import string carries the same (Core/Import.lua reads it).
	assert_eq!(plain(&forge_guide::emit::guide_data(&main))["nextWhen"], json!({ "t/b": [{ "k": "onquest", "neg": true, "q": [783, 7] }], "t/d": [{ "k": "level", "op": ">=", "n": 5 }] }));
}

#[test]
fn a_pack_is_written_in_format_4_when_a_next_option_has_when() {
	assert_eq!(format_for(&compile_chain(&chain(&["next t/b, t/c"])).guides), FORMAT);
	assert_eq!(format_for(&compile_chain(&chain(&["next t/b when level<8", "next t/c"])).guides), WHEN_FORMAT);
}
