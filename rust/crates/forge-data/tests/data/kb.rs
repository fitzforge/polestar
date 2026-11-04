//! `data build` with the knowledge base (the sim-v2 pipeline) against the JavaScript's (m2a's
//! tools/lib/data) on the data golden's slice plus a Forever TDB extract slice, an EG Link slice,
//! synthetic mechanics layers and world quest lists: the data files, verify-in-game.json and every row
//! of the KB sqlite. rust/tests/golden/kb (README there).

use crate::common;

use forge_data::build::KbOptions;
use forge_data::{run, Options};
use std::path::Path;

/// One line per row: `<table>\t<JSON array of the row>`, tables in creation order, rows by rowid (as
/// regen.js dumps the JavaScript's KB with node:sqlite).
fn dump(file: &Path) -> String {
	use rusqlite::types::Value;
	let db = rusqlite::Connection::open_with_flags(file, rusqlite::OpenFlags::SQLITE_OPEN_READ_ONLY).unwrap();
	let tables: Vec<String> = db.prepare("select name from sqlite_master where type = 'table' order by rowid").unwrap().query_map([], |r| r.get(0)).unwrap().map(Result::unwrap).collect();
	let mut out = String::new();
	for t in tables {
		let mut st = db.prepare(&format!("select * from \"{t}\" order by rowid")).unwrap();
		let n = st.column_count();
		let mut rows = st.query([]).unwrap();
		while let Some(r) = rows.next().unwrap() {
			let cells: Vec<String> = (0..n)
				.map(|i| match r.get::<_, Value>(i).unwrap() {
					Value::Null => "null".into(),
					Value::Integer(v) => v.to_string(),
					Value::Real(v) => forge_guide::js::num_str(v),
					Value::Text(s) => serde_json::to_string(&s).unwrap(),
					Value::Blob(_) => panic!("{t}: a blob"),
				})
				.collect();
			out.push_str(&format!("{t}\t[{}]\n", cells.join(",")));
		}
	}
	out
}

#[test]
fn kb_build_matches_golden() {
	let g = common::golden("kb");
	let data = common::golden("data").join("input");
	// The root regen.js builds the JavaScript in (without its tools/ copy); data/corrections.json from
	// the data golden's input/data.
	let root = common::scratch("kb");
	common::copy_tree(&data.join("forever-db"), &root.join("forever-db"));
	let sources = root.join("data/sources");
	common::copy_tree(&data.join("sources"), &sources);
	common::copy_tree(&g.join("input/sources"), &sources);
	common::copy_tree(&common::golden("extracts").join("expected"), &sources.join("cmangos/22b51464f162"));
	common::copy_tree(&data.join("data"), &root.join("data"));
	common::copy_tree(&data.join("recordings"), &root.join("data/recordings"));
	common::copy_tree(&g.join("input/local"), &root.join("data/local"));
	common::copy_tree(&g.join("input/sim"), &root.join("data/sim"));
	let out_dir = root.join("out");
	std::fs::create_dir_all(&out_dir).unwrap();
	std::fs::copy(common::golden("trainers").join("expected/trainers.json"), out_dir.join("trainers.json")).unwrap();

	let mut o = Options::new(&root);
	o.sources = sources;
	o.recordings = root.join("data/recordings");
	o.pfquest = Some(data.join("pfQuest"));
	o.questie = None;
	o.forever = true;
	o.web_xp = false;
	o.web_zones = false;
	o.built_at = "2026-10-22T00:00:00.000Z".into();
	let mut kb = KbOptions::new(&root, &out_dir);
	kb.tdb_db = root.join("data/local/forever-tdb/world.sqlite");
	let kb_file = root.join("data/local/kb/forever-kb.sqlite");
	let verify_file = root.join("data/local/kb/verify-in-game.json");
	kb.kb_file = Some(kb_file.clone());
	kb.verify_file = Some(verify_file.clone());
	o.kb = Some(kb);
	let out = run(&o, &|_| {}).unwrap();

	let unroot = |t: &str| t.replace(&root.display().to_string(), "<root>").replace(&data.display().to_string(), "<data>");
	let want = g.join("expected");
	let mut check = common::Check::new();
	let mut names = Vec::new();
	for (name, text) in &out.files {
		let file = format!("{name}.json");
		check.file(&file, &unroot(text), &want.join(&file));
		names.push(file);
	}
	check.file("verify-in-game.json", &unroot(&std::fs::read_to_string(&verify_file).unwrap()), &want.join("verify-in-game.json"));
	check.file("kb-rows.txt", &dump(&kb_file), &want.join("kb-rows.txt"));
	names.extend(["verify-in-game.json".into(), "kb-rows.txt".into()]);
	check.all_of(&want, &names);
	check.finish("data build --kb");
}
