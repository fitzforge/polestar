//! A compiled pack folder loads in the addon through its TOC and registers its guides. Its files, the
//! generated-folder guard and the build are forge-guide's tests (rust/crates/forge-guide/tests/compile_pack.rs).

use forge_addontest::dsl::{fixture_data, write_test_pack, TestPack};
use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon};
use forge_guide::diag::Diagnostics;
use forge_guide::js::V;
use forge_guide::project::{compile_sources, find_guide_files, read_sources, CompileOpts};
use serde_json::json;
use std::path::PathBuf;

fn mini() -> PathBuf {
	root().join("tests/fixtures/packs/mini")
}

fn build() -> (V, TestPack) {
	let dir = mini();
	let (manifest, diags) = forge_guide::manifest::read_manifest(&dir, false);
	assert!(diags.is_empty(), "{diags:?}");
	let manifest = manifest.expect("mini pack.json");
	let files = find_guide_files(&dir, false);
	let sources = read_sources(&dir, &files);
	let data = fixture_data();
	let mut diag = Diagnostics::new();
	let opts = CompileOpts { pack: Some(manifest.get("id").to_js_string()), author: manifest.get("author").as_str().map(String::from), context: None, pack_dir: Some(dir.clone()) };
	let compiled = compile_sources(&sources, &data, &mut diag, &opts);
	assert!(!diag.has_errors());
	let pack = write_test_pack(&compiled.guides, &data, &manifest);
	(manifest, pack)
}

#[test]
fn the_built_folder_loads_through_its_toc_and_registers_both_guides() {
	let (manifest, pack) = build();
	let folder = manifest.get("folder").to_js_string();
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"]), Addon::dir(&folder, &pack.dir)],
		script: r#"emit({ a = Polestar.Guides.Get("mini/a") ~= nil, b = Polestar.Guides.Get("mini/b") ~= nil, next = Polestar.Guides.Get("mini/a").next })"#.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "a": true, "b": true, "next": "mini/b" }));
}
