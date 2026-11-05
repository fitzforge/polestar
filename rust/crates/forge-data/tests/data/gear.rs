//! `gear build` (Polestar_ItemDB's Forever.lua, TOC and notice, SpecData.lua and its notice,
//! report.json, stdout) against the JavaScript's output on a synthetic MIT ForeverLevelingBiS, an
//! Items.lua cut, Polestar's Weights.lua and a wowsims (MIT) cache slice: rust/tests/golden/gear (README
//! there). A ForeverLevelingBiS that is not MIT-licensed is refused.

use crate::common;

use forge_data::gear::{build, Options};

const BUILT_AT: &str = "2026-10-22T00:00:00.000Z";

fn options(addons: std::path::PathBuf) -> Options {
	let input = common::golden("gear").join("input");
	Options { root: input.join("root"), addons: Some(addons), wowsims_cache: Some(input.join("root/data/sources/wowsims")), built_at: BUILT_AT.into() }
}

#[test]
fn gear_matches_golden() {
	let g = common::golden("gear");
	let out = build(&options(g.join("input/AddOns"))).unwrap();
	let want = g.join("expected");
	let mut check = common::Check::new();
	for (rel, text) in &out.files {
		check.file(rel, text, &want.join(rel));
	}
	check.file("stdout.txt", &out.summary, &want.join("stdout.txt"));
	assert_eq!(out.files.len(), 6, "{:?}", out.files.iter().map(|f| &f.0).collect::<Vec<_>>());
	check.finish("gear build");
}

#[test]
fn gear_refuses_a_foreverlevelingbis_that_is_not_mit() {
	let addons = common::scratch("gear-not-mit");
	common::copy_tree(&common::golden("gear").join("input/AddOns"), &addons);
	std::fs::write(addons.join("ForeverLevelingBiS/LICENSE"), "Copyright (c) 2026 Thunder. All rights reserved.\n\nVersions released before this notice remain available under the MIT License.\n")
		.unwrap();
	let err = build(&options(addons)).err().expect("a non-MIT ForeverLevelingBiS is refused");
	assert_eq!(err, "ForeverLevelingBiS v0.0.1-golden is not MIT-licensed; the gear data stays as last built from an MIT version");
}
