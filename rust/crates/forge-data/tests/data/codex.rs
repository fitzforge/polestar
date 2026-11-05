//! `codex build --offline` (release build: data/forever/codex/*.json, the Polestar_Codex pack and the
//! warnings) against the JavaScript's output on the world slice (+ the professions golden's
//! professions.json), client table slices, the guide slice and the gear golden's synthetic MIT
//! ForeverLevelingBiS: rust/tests/golden/codex (README there). Without an MIT ForeverLevelingBiS the
//! build goes on without its facts.

use crate::common;

use forge_data::codex::{self, Options};
use std::path::{Path, PathBuf};

/// The checkout the build reads (data/codex/*.json, guides/) and its data folder, in scratch.
fn setup(name: &str) -> (PathBuf, PathBuf) {
	let root = common::scratch(name);
	let g = common::golden("codex");
	common::copy_tree(&g.join("input/root"), &root);
	common::copy_tree(&common::golden("guide").join("slice/forever"), &root.join("guides/forever"));
	let data = root.join("data/forever");
	common::copy_tree(&common::golden("world").join("root/data/forever"), &data);
	std::fs::copy(common::golden("professions").join("expected/professions.json"), data.join("professions.json")).unwrap();
	(root, data)
}

fn options(root: &Path, data: &Path, addons: PathBuf) -> Options {
	let mut o = Options::new(root);
	o.data_dir = data.to_path_buf();
	o.sources_dir = common::golden("codex").join("input/sources");
	o.addons = Some(addons);
	o.version = Some("0.2.6".into());
	o.parity_against = None;
	o.measure = false;
	o.cwd = root.to_path_buf();
	o
}

#[test]
fn codex_matches_golden() {
	let (root, data) = setup("codex");
	let out = codex::build_logged(&options(&root, &data, common::golden("gear").join("input/AddOns")), &|_| {}).unwrap();
	let want = common::golden("codex").join("expected");
	let mut check = common::Check::new();
	for (dir, files) in [("codex", &out.json), (codex::pack::ADDON, &out.pack)] {
		let mut names = Vec::new();
		for (n, t) in files {
			check.file(&format!("{dir}/{n}"), t, &want.join(dir).join(n));
			names.push(n.clone());
		}
		check.all_of(&want.join(dir), &names);
	}
	let warnings: String = out.warnings.iter().map(|w| format!("warning: {w}\n")).collect();
	check.file("warnings.txt", &warnings, &want.join("warnings.txt"));
	check.finish("codex build");
}

#[test]
fn codex_refuses_a_foreverlevelingbis_that_is_not_mit() {
	let (root, data) = setup("codex-not-mit");
	let addons = root.join("AddOns");
	common::copy_tree(&common::golden("gear").join("input/AddOns"), &addons);
	std::fs::write(addons.join("ForeverLevelingBiS/LICENSE"), "Copyright (c) 2026 Thunder. All rights reserved.\n").unwrap();
	let err = codex::build_logged(&options(&root, &data, addons), &|_| {}).err().expect("a non-MIT ForeverLevelingBiS is refused");
	assert_eq!(err, "ForeverLevelingBiS v0.0.1-golden is not MIT-licensed; the gear data stays as last built from an MIT version");
}
