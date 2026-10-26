//! `data build` (release pipeline, no QuestieDB, web XP or web zone lists) against the JavaScript's output on
//! the committed slice: rust/tests/golden/data (README there).

use crate::common;

use forge_data::{run, Options};

#[test]
fn data_build_matches_golden() {
	let g = common::golden("data");
	let input = g.join("input");
	let mut o = Options::new(&input);
	o.sources = input.join("sources");
	o.recordings = input.join("recordings");
	o.pfquest = Some(input.join("pfQuest"));
	o.questie = None;
	o.forever = true;
	o.web_xp = false;
	o.web_zones = false;
	o.built_at = "2026-10-22T00:00:00.000Z".into();
	let out = run(&o, &|_| {}).unwrap();
	let want = g.join("expected");
	let mut check = common::Check::new();
	let mut names = Vec::new();
	for (name, text) in &out.files {
		let file = format!("{name}.json");
		check.file(&file, &common::unroot(text, &input), &want.join(&file));
		names.push(file);
	}
	check.all_of(&want, &names);
	check.finish("data build");
}
