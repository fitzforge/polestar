//! The runner itself: what emit() gives back, where print and io.write go, and how a Lua error reads.

use forge_addontest::{run_addon, run_addon_output, Addon, RunAddon};
use serde_json::json;

#[test]
fn emit_gives_json_values_in_order_integers_as_integers_keys_sorted_nil_fields_absent() {
	let out = run_addon(&RunAddon {
		before: "local seen = 3".into(),
		script: r#"emit(seen); emit({ b = 1.5, a = { 1, 2 }, c = nil, [7] = "x", e = {} }); emit(-0.0); emit(0.1 + 0.2)"#.into(),
		..Default::default()
	})
	.unwrap();
	assert_eq!(out, vec![json!(3), json!({ "7": "x", "a": [1, 2], "b": 1.5, "e": {} }), json!(0), json!(0.3)]);
}

#[test]
fn print_and_io_write_go_to_the_output_not_the_process() {
	let out = run_addon_output(&RunAddon { script: r#"print("a", 1); io.write("b", 2, "\n"); emit(true)"#.into(), ..Default::default() }).unwrap();
	assert_eq!(out.stdout, "a\t1\nb2\n@@JSON true\n");
	assert_eq!(out.emitted, vec![json!(true)]);
}

#[test]
fn a_lua_error_is_err_with_its_place_and_the_output_so_far() {
	let e = run_addon(&RunAddon { script: "emit(1)\nerror(\"boom\")".into(), ..Default::default() }).unwrap_err();
	assert!(e.contains("test program:") && e.contains("boom"), "{e}");
	assert!(e.contains("@@JSON 1"), "{e}");
}

#[test]
fn an_addon_loads_by_its_toc_with_its_name_and_namespace_and_is_marked_as_addon_code() {
	let out = run_addon(&RunAddon {
		stubs: vec!["stub_recorder.lua"],
		addons: vec![Addon::name("Polestar_Recorder")],
		script: r#"local n = 0; for src, name in pairs(stub.addonSources) do if name == "Polestar_Recorder" and src:find("/addon/Polestar_Recorder/", 1, true) then n = n + 1 end end; emit(n > 0)"#
			.into(),
		..Default::default()
	})
	.unwrap();
	assert_eq!(out, vec![json!(true)]);
	let missing = run_addon(&RunAddon { addons: vec![Addon::files("Polestar", &["Nope.lua"])], ..Default::default() }).unwrap_err();
	assert!(missing.contains("missing Nope.lua"), "{missing}");
}

#[test]
fn the_bytecode_reader_lists_global_writes_in_every_function_and_reports_compile_errors() {
	let tmp = forge_addontest::tmp::TempDir::new("polestar-luac-");
	let ok = tmp.path().join("ok.lua");
	std::fs::write(&ok, "local x = 1\nFoo = x\nlocal function f() local t = {}; t.y = 2; Bar = 3.5; return function() Baz = 'a' end end\nprint(Qux)").unwrap();
	assert_eq!(forge_addontest::luac::globals_written(&ok).unwrap(), vec!["Foo", "Bar", "Baz"]);
	let bad = tmp.path().join("bad.lua");
	std::fs::write(&bad, "local x = \nend").unwrap();
	let e = forge_addontest::luac::globals_written(&bad).unwrap_err();
	assert!(e.contains("bad.lua:2:"), "{e}");
}
