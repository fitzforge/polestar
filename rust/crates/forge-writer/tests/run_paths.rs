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

/// The refusal names five errors; every error the pack check found is in `<out>.pack-errors.txt`
/// beside the tree (the 0.4.0 round's written check stopped on five of the writer's errors, the rest
/// unseen), and the next run that passes leaves no errors file.
#[test]
fn every_error_of_a_refused_tree_is_in_its_errors_file() {
	let dir = std::env::temp_dir().join(format!("forge-writer-run-paths-all-{}", std::process::id()));
	let tips = case(&dir, |t| t.replacen("  turnin 783\n", &format!("  turnin 783\n{}", "  tip\n".repeat(7)), 1));
	let e = run_paths(&tips, &RunOpts::default(), &SharedCache::default()).map(|_| ()).expect_err("bare tips are refused");
	let file = dir.join("out.pack-errors.txt");
	assert_eq!(e.matches("`tip` needs text").count(), 5, "{e}");
	assert!(e.contains(&format!("7 errors in all, every one in {}", file.display())), "{e}");
	let all = std::fs::read_to_string(&file).expect("the errors file");
	assert_eq!(all.lines().filter(|l| l.contains("forever/a.guide:") && l.ends_with("`tip` needs text")).count(), 7, "{all}");
	let clean = std::fs::read_to_string(repo().join("tests/fixtures/packs/mini/guides/a.guide")).unwrap();
	std::fs::write(dir.join("guides/forever/a.guide"), clean).unwrap();
	run_paths(&tips, &RunOpts::default(), &SharedCache::default()).expect("the clean tree is written");
	assert!(!file.exists(), "a tree the pack check passes leaves no errors file");
	std::fs::remove_dir_all(&dir).unwrap();
}

/// Hearth advice is the arrow's (Polestar 0.3.3): the route still plans its hearth leg, but the
/// written guide has no `hearth` goal; the step it shared with other work keeps that work under the
/// place's name, and a tip's "Hearth to ..." sentence goes. `sethome` stays.
#[test]
fn a_route_hearth_writes_no_hearth_goal() {
	let dir = std::env::temp_dir().join(format!("forge-writer-run-paths-hearth-{}", std::process::id()));
	let p = case(&dir, |t| {
		t.replacen(
			"step Deputy Willem\n  accept 783\n  turnin 783\n",
			"step Deputy Willem\n  sethome \"Goldshire\"\n  accept 783\n\nstep Hearth to Goldshire\n  tip Hearth to Goldshire and walk north. Willem waits by the abbey.\n  hearth \"Goldshire\"\n  turnin 783\n",
			1,
		)
	});
	std::fs::write(
		dir.join("routes/Human.json"),
		r#"{"diff": {}, "order": [
			{ "t": "accept", "q": 783, "pt": 0, "from": "guides/forever/a.guide:11", "items": [{ "t": "bind", "inn": 0, "pt": 0, "used": true }] },
			{ "t": "turnin", "q": 783, "pt": 1, "from": "guides/forever/a.guide:16", "items": [{ "t": "hearth", "inn": 0, "to": 1 }] }
		]}"#,
	)
	.unwrap();
	std::fs::write(
		dir.join("world-alliance.json"),
		r#"{"points": [[1, 1, 0, 0, 1429], [1, 1, 500, 500, 1429]], "zones": { "1429": "Elwynn Forest" }, "quests": [], "inns": [{ "name": "Goldshire", "pt": 0 }]}"#,
	)
	.unwrap();
	let out = run_paths(&p, &RunOpts::default(), &SharedCache::default()).expect("written");
	let a = &out.tree["forever/a.guide"];
	assert!(!a.lines().any(|l| l.trim_start().starts_with("hearth")), "{a}");
	assert!(a.contains("  sethome \"Goldshire\""), "{a}");
	assert!(a.contains("step Goldshire\n  tip Walk north. Willem waits by the abbey.\n"), "{a}");
	assert!(!a.contains("Hearth to"), "{a}");
	std::fs::remove_dir_all(&dir).unwrap();
}
