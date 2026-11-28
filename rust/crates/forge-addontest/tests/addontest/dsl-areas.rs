//! Gathering areas (`area <zone> "<name>" … at <x,y> … dots <x,y> …`, docs/GUIDE_FORMAT.md "Gathering areas"): the
//! compiler turns each line into a candidate of the step's skill or collect goal, its outline and node spots packed
//! as strings, and the engine registry accepts what it emits (tests/engine-area-choice.test.js plays them).

use forge_addontest::dsl::{compile_with, fixture_data, write_our_test_pack};
use forge_addontest::{emitted, is_match, Addon, RunAddon, TEST_PACK};

fn src(body: &[&str]) -> String {
	let mut all: Vec<String> = ["guide test/areas", "title A", "category Professions", "levels 1-60", "zone Elwynn Forest", "", "step Copper (1-65)"].iter().map(|s| s.to_string()).collect();
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
			emit({ res = res, n = #goal.candidates, spots = goal.spots and #goal.spots or false, c1 = goal.candidates[1], c2 = goal.candidates[2] })"#;

#[test]
fn area_lines_compile_to_the_skill_goal_s_area_candidates_that_the_engine_registry_accepts() {
	let text = src(&[
		"  area Elwynn Forest \"Fargodeep Mine\" near lvl 3 count 12 lap 300 gain 2.5 levels 2-5 items 2770,2835 only Alliance starter respawn 300 at 40,80 42,80 41,83 dots 40.5,80.5 41.2,81",
		"  area map 1429 \"Jasperlode Mine\" lvl 6 count 8 lap 250 gain 3 at 60,50 62,50 61,53",
		"  skill Mining 65",
	]);
	let r = compile_with(&[("test.guide", &text)], &fixture_data(), Some("test"));
	assert_eq!(r.errors, Vec::<String>::new());
	let pack = write_our_test_pack(&r.guides);
	let at = pack.guides_of("test/areas");
	let lua = pack.text(at);
	assert!(is_match(lua, r#"area = \\?"Fargodeep Mine\\?""#), "{lua}");
	assert!(is_match(lua, r#"poly = \\?"40,80;42,80;41,83\\?""#), "{lua}");
	assert!(is_match(lua, r#"dots = \\?"40\.5,80\.5;41\.2,81\\?""#), "{lua}");
	assert!(is_match(lua, r#"items = \\?"2770,2835\\?""#), "{lua}");
	let file = serde_json::to_string(&pack.dir.join(at)).unwrap();
	let out = emitted(&RunAddon { addons: vec![Addon::files("Polestar", &["Core/Core.xml"])], script: SCRIPT.replace("${TEST_PACK}", TEST_PACK).replace("${FILE}", &file), ..Default::default() });
	let out = &out[0];
	assert_eq!(out["res"], "ok");
	assert_eq!(out["n"], 2);
	assert_eq!(out["spots"], false, "an area goal has no spawn areas");
	let c1 = &out["c1"];
	assert_eq!(c1["x"], 41, "the middle of the outline's box");
	assert_eq!(c1["y"], 81.5);
	assert_eq!(c1["count"], 12);
	assert_eq!(c1["near"], true);
	assert_eq!(c1["starter"], true);
	assert_eq!(c1["respawn"], 300);
	assert_eq!(c1["faction"], "A");
	assert_eq!(c1["levels"]["min"], 2);
	assert_eq!(out["c2"]["lap"], 250);
	assert_eq!(out["c2"]["faction"], "AH");
}

#[test]
fn an_area_line_without_its_name_numbers_or_outline_or_beside_gotos_or_loops_is_an_error() {
	let errors = |body: &[&str]| compile_with(&[("test.guide", &src(body))], &fixture_data(), Some("test")).errors.join("\n");
	assert!(errors(&["  area Elwynn Forest lvl 3 count 2 lap 3 gain 1 at 1,1 2,2 3,3", "  skill Mining 65"]).contains("needs its name in quotes"));
	assert!(errors(&["  area Elwynn Forest \"X\" lvl 3 lap 3 gain 1 at 1,1 2,2 3,3", "  skill Mining 65"]).contains("`area` needs `count`"));
	assert!(errors(&["  area Elwynn Forest \"X\" lvl 3 count 1 lap 3 gain 1 at 1,1 2,2", "  skill Mining 65"]).contains("three points or more"));
	assert!(errors(&["  area Elwynn Forest \"X\" lvl 3 count 1 lap 3 yield 1 at 1,1 2,2 3,3", "  skill Mining 65"]).contains("takes `gain`, not `yield`"));
	assert!(errors(&["  goto 40,40", "  area Elwynn Forest \"X\" lvl 3 count 1 lap 3 gain 1 at 1,1 2,2 3,3", "  skill Mining 65"]).contains("drop the step's `goto` lines"));
	assert!(errors(&["  loop Elwynn Forest lvl 6 lap 300 gain 2.5 at 40,40 45,45", "  area Elwynn Forest \"X\" lvl 3 count 1 lap 3 gain 1 at 1,1 2,2 3,3", "  skill Mining 65"]).contains("two kinds of place"));
}
