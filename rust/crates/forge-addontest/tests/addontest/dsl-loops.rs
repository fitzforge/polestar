//! Farming loops (`loop <zone> lvl <n> lap <s> gain|yield <n> … at <x,y> …`, docs/GUIDE_FORMAT.md "Farming
//! loops"): the compiler turns each line into a candidate of the step's skill or collect goal, its stops
//! packed as spawn areas, and the engine registry accepts what it emits (engine-loops.rs plays them).

use forge_addontest::dsl::{compile_with, fixture_data, write_our_test_pack};
use forge_addontest::{emitted, is_match, Addon, RunAddon, TEST_PACK};

fn src(body: &[&str]) -> String {
	let mut all: Vec<String> = ["guide test/loops", "title L", "category Professions", "levels 1-60", "zone Elwynn Forest", "", "step Copper (1-65)"].iter().map(|s| s.to_string()).collect();
	all.extend(body.iter().map(|s| s.to_string()));
	format!("{}\n", all.join("\n"))
}

const SCRIPT: &str = r#"
			${TEST_PACK}
			local got, res
			local real = Polestar.RegisterGuide
			Polestar.RegisterGuide = function(g) got = g; local ok, e = real(g); res = ok and "ok" or e; return ok, e end
			assert(loadfile(${FILE}))("Polestar_Guides", {})
			local goal = got.steps[1].goals[1]
			emit({ res = res, n = #goal.candidates, spots = #goal.spots, spread = goal.spread, c2 = goal.candidates[2] })"#;

#[test]
fn loop_lines_compile_to_the_skill_goal_s_loop_candidates_that_the_engine_registry_accepts() {
	let text = src(&[
		"  loop Elwynn Forest lvl 6 lap 300 gain 2.5 r 60 at 40,40 45,45",
		"  loop map 1429 lvl 9 lap 420 gain 4 only Horde at 60,60 62,64 58,66",
		"  skill Mining 65",
	]);
	let r = compile_with(&[("test.guide", &text)], &fixture_data(), Some("test"));
	assert_eq!(r.errors, Vec::<String>::new());
	let pack = write_our_test_pack(&r.guides);
	let at = pack.guides_of("test/loops");
	let lua = pack.text(at);
	// The steps sit in a deferred source string: quotes come escaped.
	assert!(is_match(lua, r#"map = 1429, x = 40, y = 40, f = \\?"e\\?", faction = \\?"AH\\?", lvl = \{ min = 6, max = 6 \}, lap = 300, gain = 2\.5, spotsPacked = \\?"40,40,,60;45,45,,60\\?""#), "{lua}");
	assert!(is_match(lua, r#"f = \\?"e\\?", faction = \\?"H\\?", lvl = \{ min = 9, max = 9 \}, lap = 420, gain = 4, spotsPacked = \\?"60,60,,30;62,64,,30;58,66,,30\\?""#), "{lua}");
	let file = serde_json::to_string(&pack.dir.join(at)).unwrap();
	let out = emitted(&RunAddon { addons: vec![Addon::files("Polestar", &["Core/Core.xml"])], script: SCRIPT.replace("${TEST_PACK}", TEST_PACK).replace("${FILE}", &file), ..Default::default() });
	let out = &out[0];
	assert_eq!(out["res"], "ok");
	assert_eq!(out["n"], 2);
	assert_eq!(out["spots"], 2, "the goal's own spawn areas are the first loop's until the engine picks");
	assert_eq!(out["spread"], true);
	assert_eq!(out["c2"]["lap"], 420);
}

#[test]
fn a_loop_line_without_its_numbers_or_beside_gotos_or_a_bare_loop_is_an_error() {
	let errors = |body: &[&str]| compile_with(&[("test.guide", &src(body))], &fixture_data(), Some("test")).errors.join("\n");
	assert!(errors(&["  loop Elwynn Forest lvl 6 gain 2 at 40,40 45,45", "  skill Mining 65"]).contains("`loop` needs `lap`"));
	assert!(errors(&["  loop Elwynn Forest lvl 6 lap 300 at 40,40 45,45", "  skill Mining 65"]).contains("one of `gain`"));
	assert!(errors(&["  loop Elwynn Forest lvl 6 lap 300 gain 2 at 40,40", "  skill Mining 65"]).contains("at least two points"));
	assert!(errors(&["  loop Elwynn Forest lvl 6 lap 300 yield 2 at 40,40 45,45", "  skill Mining 65"]).contains("takes `gain`, not `yield`"));
	assert!(errors(&["  loop Elwynn Forest lvl 6 lap 300 gain 2 at 40,40 45,45", "  goto 41,41", "  skill Mining 65"]).contains("drop the step's `goto` lines"));
	assert!(errors(&["  loop", "  loop Elwynn Forest lvl 6 lap 300 gain 2 at 40,40 45,45", "  skill Mining 65"]).contains("use one kind"));
}
