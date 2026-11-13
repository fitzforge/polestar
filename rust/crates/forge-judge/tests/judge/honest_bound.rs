//! Bound predicates use the compiler's place name and the bind established by prior played goals.

use forge_guide::data::load_data;
use forge_guide::diag::Diagnostics;
use forge_guide::project::{compile_sources, CompileOpts, Source};
use forge_judge::honest::{play_chain, HonestOpts, Persona};
use std::path::Path;

const BIND: &str = "step Bind\n  sethome \"Goldshire\"\n";

// Quest 33 in the public DSL fixture requires work. A premature hand-in reports R5 only if
// its conditional step was played; compile real source so a wrong predicate field cannot hide.
fn broken_step(condition: &str) -> String {
	format!("step Conditional work\n  when {condition}\n  accept 33\n  turnin 33\n")
}

fn assert_played(bodies: &[&str], expected: bool) {
	let data = load_data(&Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../tests/fixtures/dsl/data")).expect("public DSL fixture");
	let sources: Vec<Source> = bodies
		.iter()
		.enumerate()
		.map(|(i, body)| {
			let file = format!("bound-{i}.guide");
			let text = format!("guide test/bound-{i}\ntitle Bound\nfaction Alliance\nrace Human\nlevels 1-60\nzone Elwynn Forest\n\n{body}");
			Source { source: file.clone(), file, text }
		})
		.collect();
	let mut diag = Diagnostics::new();
	let compiled = compile_sources(&sources, &data, &mut diag, &CompileOpts { pack: None, author: None, context: None, pack_dir: None });
	assert!(!diag.has_errors(), "{:?}", diag.list);
	assert_eq!(compiled.guides.len(), bodies.len());
	let chain: Vec<_> = compiled.guides.iter().collect();
	let persona = Persona { race: "Human".into(), faction: "Alliance".into(), cls: "WARRIOR".into() };
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		let findings = play_chain(&chain, &data, &persona, None, None, &opts);
		assert_eq!(findings.iter().any(|f| f.rule == "R5"), expected, "legacy={}: {bodies:?}\n{findings:#?}", opts.legacy);
	}
}

#[test]
fn matching_bind_holds_and_its_negation_does_not() {
	assert_played(&[&format!("{BIND}{}", broken_step("bound \"Goldshire\""))], true);
	assert_played(&[&format!("{BIND}{}", broken_step("!bound \"Goldshire\""))], false);
}

#[test]
fn another_bind_does_not_hold() {
	assert_played(&[&format!("{BIND}{}", broken_step("bound \"Moonbrook\""))], false);
}

#[test]
fn another_bind_negation_holds() {
	assert_played(&[&format!("{BIND}{}", broken_step("!bound \"Moonbrook\""))], true);
}

#[test]
fn bind_names_match_without_case() {
	assert_played(&[&format!("{BIND}{}", broken_step("bound \"gOLDSHIRE\""))], true);
	assert_played(&[&format!("{BIND}{}", broken_step("!bound \"gOLDSHIRE\""))], false);
}

#[test]
fn unknown_initial_bind_keeps_the_existing_assumption() {
	assert_played(&[&broken_step("bound \"Goldshire\"")], true);
	assert_played(&[&broken_step("!bound \"Goldshire\"")], false);
}

#[test]
fn only_a_played_sethome_changes_the_bind() {
	let rebind = "step Rebind\n  when bound \"Goldshire\"\n  sethome \"Moonbrook\"\n";
	assert_played(&[&format!("{BIND}{rebind}{}", broken_step("!bound \"Goldshire\""))], true);
	let skipped = "step Do not rebind\n  when bound \"Moonbrook\"\n  sethome \"Moonbrook\"\n";
	assert_played(&[&format!("{BIND}{skipped}{}", broken_step("!bound \"Moonbrook\""))], true);
}

#[test]
fn the_bind_carries_to_the_next_guide() {
	assert_played(&[BIND, &broken_step("bound \"Moonbrook\"")], false);
	assert_played(&[BIND, &broken_step("!bound \"Moonbrook\"")], true);
}
