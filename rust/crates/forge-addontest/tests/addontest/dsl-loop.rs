//! `loop` steps (docs/GUIDE_FORMAT.md, "Spawn areas"): in a step with a `loop` line, the `goto` points (in
//! order) are the places to search. Each kill, collect or interact goal of the step without its own `@x,y` gets
//! them as its spawn areas (`spots`, searched one after another: `spread`), its point at the first; the gotos
//! leave the step. The runtime keys are ones every Polestar reads, so a loop changes no pack format. The
//! compiler's side is forge-guide's (rust/crates/forge-guide/tests/dsl_loop.rs); this is the addon's.

use forge_addontest::dsl::{compile, guide_text, plain, Compiled};
use forge_addontest::{emitted, lua_value, Addon, RunAddon};
use serde_json::json;

const LOOP: [&str; 9] = [
	"step Kobold circuit",
	"  loop",
	r#"  goto 47.6,35.1 "North camp""#,
	"  goto 49.0,32.4 r 20",
	"  goto 52.3,26.8",
	"  kill 6 x10 quest 7.1",
	"  collect 750 x2",
	"  interact 1617",
	"  note Pull one at a time.",
];

fn compiled(lines: &[&str]) -> Compiled {
	let mut all: Vec<&str> = vec!["step Accept", "  accept 7"];
	all.extend_from_slice(lines);
	all.extend_from_slice(&["step Hand in", "  turnin 7"]);
	compile(&guide_text(&all))
}

#[test]
fn the_addon_accepts_a_compiled_loop_step_guides_validate() {
	let r = compiled(&LOOP);
	assert_eq!(r.errors, Vec::<String>::new(), "{}", r.text);
	let guide = plain(&r.guides[0]);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: r#"stub.world.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })"#.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: "emit({ err = Polestar.Guides.Validate(".to_string() + &lua_value(&guide) + ") or false })",
		..Default::default()
	});
	assert_eq!(out[0], json!({ "err": false }));
}
