//! The CMaNGOS classic-db extracts (`forge data extracts`) against the JavaScript extractors' output
//! on the committed dump slice: rust/tests/golden/extracts (README there).

use crate::common;

use forge_data::cmangos;

#[test]
fn extracts_match_golden() {
	let g = common::golden("extracts");
	let dir = common::scratch("extracts");
	cmangos::extract_all(&g.join("input").join("sources"), &dir).unwrap();
	let want = g.join("expected");
	let mut check = common::Check::new();
	let mut names = Vec::new();
	for e in std::fs::read_dir(&dir).unwrap().flatten() {
		let name = e.file_name().to_string_lossy().to_string();
		check.file(&name, &std::fs::read_to_string(e.path()).unwrap(), &want.join(&name));
		names.push(name);
	}
	check.all_of(&want, &names);
	check.finish("extracts");
}

/// extract_text (`forge data extracts` per file, and the builds' cache misses) reads the dump the same way.
#[test]
fn extract_text_matches_golden() {
	let g = common::golden("extracts");
	let sources = g.join("input").join("sources");
	let mut check = common::Check::new();
	for name in ["spawnz.json", "quest_counts.json", "training.json"] {
		check.file(name, &cmangos::extract_text(&sources, name).unwrap(), &g.join("expected").join(name));
	}
	check.finish("extract_text");
}
