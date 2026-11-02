//! run_paths (the guides stage and forge build's written check): the tree it writes is checked as the
//! pack, and a tree the pack check refuses is an error, not handed on. c14 wrote a bare `tip` into
//! the Night Elf Teldrassil guide, and the build failed on it in its report, 45 minutes after the
//! write.

use forge_writer::native::{run_paths, PathInputs, SharedCache};
use forge_writer::RunOpts;
use std::path::{Path, PathBuf};

fn repo() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

/// The mini pack's two guides as v1's (`a.guide` with `edit` applied), an empty route and world, the
/// guide compiler's fixture data.
fn case(dir: &Path, edit: impl Fn(String) -> String) -> PathInputs {
	let _ = std::fs::remove_dir_all(dir);
	let guides = dir.join("guides");
	std::fs::create_dir_all(guides.join("forever")).unwrap();
	for f in ["a", "b"] {
		let text = std::fs::read_to_string(repo().join(format!("tests/fixtures/packs/mini/guides/{f}.guide"))).unwrap();
		std::fs::write(guides.join(format!("forever/{f}.guide")), if f == "a" { edit(text) } else { text }).unwrap();
	}
	std::fs::create_dir_all(dir.join("routes")).unwrap();
	std::fs::write(dir.join("routes/Human.json"), r#"{"diff": {}, "order": []}"#).unwrap();
	std::fs::write(dir.join("world-alliance.json"), r#"{"points": [], "quests": []}"#).unwrap();
	PathInputs {
		route: dir.join("routes/Human.json"),
		world: dir.join("world-alliance.json"),
		walks: None,
		guides,
		root: dir.to_path_buf(),
		data_dir: Some(repo().join("tests/fixtures/dsl/data")),
		out: dir.join("out"),
		checkout: Some(dir.to_path_buf()),
	}
}

#[test]
fn a_tree_the_pack_check_refuses_is_an_error() {
	let dir = std::env::temp_dir().join(format!("forge-writer-run-paths-{}", std::process::id()));
	let clean = case(&dir, |t| t);
	run_paths(&clean, &RunOpts::default(), &SharedCache::default()).expect("a clean tree is written");
	let bare_tip = case(&dir, |t| t.replacen("  turnin 783\n", "  turnin 783\n  tip\n", 1));
	let e = run_paths(&bare_tip, &RunOpts::default(), &SharedCache::default()).map(|_| ()).expect_err("a bare tip is refused");
	assert!(e.contains("the pack has errors:\n"), "{e}");
	assert!(e.contains("forever/a.guide:") && e.contains("`tip` needs text"), "{e}");
	std::fs::remove_dir_all(&dir).unwrap();
}
