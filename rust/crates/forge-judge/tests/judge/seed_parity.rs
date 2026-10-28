//! The seed tests' pass/fail per test on the guide and data slices, against the committed reference
//! rust/tests/golden/seed/slice.tsv (its README). The reference was first the Node run of the tests these
//! port; with the JS toolchain retired it is the Rust run's own: a seed test added, removed, or passing
//! or failing differently on the slice shows here and is regenerated on purpose:
//!
//! FORGE_REGEN_SEED=1 cargo test --profile quick -p forge-judge --test judge seed_parity

use crate::common;
use forge_judge::seed::{run, Ctx};
use std::collections::BTreeMap;
use std::path::Path;

fn read_tsv(tsv: &Path) -> BTreeMap<String, bool> {
	std::fs::read_to_string(tsv).unwrap().lines().filter_map(|l| l.split_once('\t')).map(|(st, n)| (n.to_string(), st == "ok")).collect()
}

/// The clean guide slice, its data, and a root holding this checkout's corrections and Nav1.lua (no
/// navigation build, no site list cache: those tests skip).
#[test]
fn seed_tests_match_the_reference_on_the_slice() {
	let repo = common::golden().join("../../..").canonicalize().unwrap();
	let root = Path::new(env!("CARGO_TARGET_TMPDIR")).join("seed-root");
	let _ = std::fs::remove_dir_all(&root);
	for f in ["forever-db/corrections/quests.json", "forever-db/corrections/npcs.json", "addon/Polestar_Nav/Nav/Nav1.lua"] {
		std::fs::create_dir_all(root.join(f).parent().unwrap()).unwrap();
		std::fs::copy(repo.join(f), root.join(f)).unwrap();
	}
	let ctx = Ctx::new(&common::clean_slice("seed"), &common::data(), &root).unwrap();
	let have: BTreeMap<String, bool> = run(&ctx, None).into_iter().map(|o| (o.name, o.passed)).collect();
	let tsv = common::golden().join("seed/slice.tsv");
	if std::env::var_os("FORGE_REGEN_SEED").is_some() {
		let body: String = have.iter().map(|(n, ok)| format!("{}\t{n}\n", if *ok { "ok" } else { "not ok" })).collect();
		std::fs::write(&tsv, body).unwrap();
		eprintln!("seed reference: {} tests written to {}", have.len(), tsv.display());
		return;
	}
	let want = read_tsv(&tsv);
	let added: Vec<&String> = have.keys().filter(|k| !want.contains_key(*k)).collect();
	let gone: Vec<&String> = want.keys().filter(|k| !have.contains_key(*k)).collect();
	assert!(added.is_empty() && gone.is_empty(), "seed tests not in the reference: {added:?}; in the reference, gone: {gone:?} (FORGE_REGEN_SEED=1 to accept)");
	let differ: Vec<&String> = want.iter().filter(|(k, v)| have[*k] != **v).map(|(k, _)| k).collect();
	eprintln!("seed reference: {} tests, {} fail on the slice, differ {}", want.len(), want.values().filter(|v| !**v).count(), differ.len());
	assert!(differ.is_empty(), "pass/fail differs from the reference: {differ:?} (FORGE_REGEN_SEED=1 to accept)");
}
