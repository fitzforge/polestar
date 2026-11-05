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

/// Every quest on the release build's dungeon pages: (id, its XP).
fn page_xp(journal: &str) -> Vec<(i64, Option<f64>)> {
	let j: serde_json::Value = serde_json::from_str(journal).unwrap();
	let mut out = Vec::new();
	for d in j["dungeons"].as_object().unwrap().values() {
		for q in d["quests"].as_array().unwrap() {
			out.push((q["id"].as_i64().unwrap(), q["rewards"]["xp"].as_f64()));
		}
	}
	out
}

// #837: Ruins of Lordaeron's pages said 2,200 XP where forever-db says 4,600, because quests.json
// keeps QuestieDB's number. forever-db's XP comes first; a quest it has none for keeps quests.json's.
#[test]
fn dungeon_pages_take_forever_dbs_xp_first() {
	let (root, data) = setup("codex-store-xp");
	let addons = common::golden("gear").join("input/AddOns");
	let golden = std::fs::read_to_string(common::golden("codex").join("expected/codex/journal.json")).unwrap();
	let ids: Vec<i64> = page_xp(&golden).into_iter().map(|(id, _)| id).collect();
	let (in_store, not_in_store, corrected) = (ids[0], ids[1], ids[2]);

	// quests.json has an older number for all three; the store has XP for two, and a correction not
	// published into the store yet changes one of those.
	let file = data.join("quests.json");
	let mut quests: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(&file).unwrap()).unwrap();
	for id in [in_store, not_in_store, corrected] {
		quests[id.to_string()]["xp"] = 2200.into();
	}
	std::fs::write(&file, quests.to_string()).unwrap();
	let db = root.join("forever-db");
	std::fs::create_dir_all(db.join("data")).unwrap();
	std::fs::create_dir_all(db.join("corrections")).unwrap();
	let rows = format!("{{\"id\":{in_store},\"xp\":4600}}\n{{\"id\":{not_in_store},\"title\":\"no xp\"}}\n{{\"id\":{corrected},\"xp\":4600}}\n");
	std::fs::write(db.join("data/quest.jsonl"), rows).unwrap();
	let corrections = format!("{{\"_about\":\"not a quest\",\"{in_store}\":{{\"set\":{{\"pre\":[1]}}}},\"{corrected}\":{{\"set\":{{\"xp\":5000}}}}}}");
	std::fs::write(db.join("corrections/quests.json"), corrections).unwrap();

	let out = codex::build_logged(&options(&root, &data, addons), &|_| {}).unwrap();
	let after = page_xp(&out.json.iter().find(|(n, _)| n == "journal.json").unwrap().1);
	let shows = |quest: i64, want: f64| after.iter().filter(|(id, _)| *id == quest).all(|(_, xp)| *xp == Some(want));
	assert!(shows(in_store, 4600.0), "{in_store} takes forever-db's XP: {after:?}");
	assert!(shows(not_in_store, 2200.0), "{not_in_store} keeps quests.json's XP: {after:?}");
	assert!(shows(corrected, 5000.0), "{corrected} takes the unpublished correction: {after:?}");
}
