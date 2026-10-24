//! Parity of `forge judge seed-tests` with `node --test tests/guides-reported.test.js
//! tests/guides-caves.test.js`: the same pass/fail per test, by name (the TAP's `ok`/`not ok` per test; a
//! `# SKIP` test passes).
//!
//! Default: rust/tests/golden/seed/slice.tsv (its README and regen.sh): v1's two test files, run in a copy
//! of this checkout, on the clean guide slice (common::clean_slice) and the data slice. Optional extra: v1's guides and the r8 Orc and Human written guides
//! ($POLESTAR_V1, $POLESTAR_JSREF/r8e-{orc,human}-read, references $POLESTAR_JSREF/seedref/{v1,orc,human}.tsv);
//! variables unset or inputs absent: skipped with a note.
//!
//! cargo test --release -p forge-judge --test seed_parity -- --nocapture

use crate::common;
use forge_judge::seed::{run, Ctx};
use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

fn read_tsv(tsv: &Path) -> BTreeMap<String, bool> {
	std::fs::read_to_string(tsv).unwrap().lines().filter_map(|l| l.split_once('\t')).map(|(st, n)| (n.replace("\\#", "#").split(" # SKIP").next().unwrap().to_string(), st == "ok")).collect()
}

fn compare(name: &str, want: &BTreeMap<String, bool>, ctx: &Ctx) {
	let have: BTreeMap<String, bool> = run(ctx, None).into_iter().map(|o| (o.name, o.passed)).collect();
	assert_eq!(have.keys().collect::<Vec<_>>(), want.keys().collect::<Vec<_>>(), "{name}: the same tests");
	let differ: Vec<&String> = want.iter().filter(|(k, v)| have[*k] != **v).map(|(k, _)| k).collect();
	eprintln!("seed parity {name}: {} tests, {} fail in node, differ {}", want.len(), want.values().filter(|v| !**v).count(), differ.len());
	assert!(differ.is_empty(), "{name}: {differ:?}");
}

/// The clean guide slice, its data, and a root as the JS tree had it: this checkout's corrections and
/// Nav1.lua, no navigation build, no site list cache.
#[test]
fn seed_tests_equal_node_on_the_slice() {
	let repo = common::golden().join("../../..").canonicalize().unwrap();
	let root = Path::new(env!("CARGO_TARGET_TMPDIR")).join("seed-root");
	let _ = std::fs::remove_dir_all(&root);
	for f in ["forever-db/corrections/quests.json", "forever-db/corrections/npcs.json", "addon/Polestar_Nav/Nav/Nav1.lua"] {
		std::fs::create_dir_all(root.join(f).parent().unwrap()).unwrap();
		std::fs::copy(repo.join(f), root.join(f)).unwrap();
	}
	let ctx = Ctx::new(&common::clean_slice("seed"), &common::data(), &root).unwrap();
	compare("slice", &read_tsv(&common::golden().join("seed/slice.tsv")), &ctx);
}

#[test]
#[ignore = "needs POLESTAR_V1 (guides, data/forever) and POLESTAR_JSREF (seedref/)"]
fn seed_tests_equal_node_on_v1_and_r8() {
	let seed = std::env::var_os("POLESTAR_V1").map(PathBuf::from).expect("seed parity needs POLESTAR_V1");
	let jsref = std::env::var_os("POLESTAR_JSREF").map(PathBuf::from).expect("seed parity needs POLESTAR_JSREF");
	for (name, guides) in [("v1", seed.join("guides")), ("orc", jsref.join("r8e-orc-read")), ("human", jsref.join("r8e-human-read"))] {
		let tsv = jsref.join(format!("seedref/{name}.tsv"));
		if !tsv.exists() || !guides.join("forever").is_dir() {
			eprintln!("seed parity {name}: POLESTAR_V1/POLESTAR_JSREF lack inputs, skipped");
			continue;
		}
		let ctx = Ctx::new(&guides, &seed.join("data/forever"), &seed).unwrap();
		compare(name, &read_tsv(&tsv), &ctx);
	}
}
