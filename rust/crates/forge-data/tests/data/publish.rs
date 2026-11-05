//! `forge data publish` on a synthetic KB and a tiny public data build
//! (rust/tests/golden/publish/data): tier selection, the clean schema, the private sidecar and
//! the --check guard.

use std::path::{Path, PathBuf};

use forge_data::publish::{self, check};
use serde_json::Value;

fn fixture() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden/publish/data")
}

fn scratch(name: &str) -> PathBuf {
	let d = std::env::temp_dir().join(format!("forge-publish-test-{}-{name}", std::process::id()));
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

/// A KB with the tables publish reads.
fn make_kb(p: &Path) {
	let db = rusqlite::Connection::open(p).unwrap();
	db.execute_batch(
		"create table sources(name text primary key, tier real, label text, version text);
		create table facts(kind text, id integer, field text, value text, source text, confidence text, agree integer, total integer, primary key(kind, id, field));
		create table alternatives(kind text, id integer, field text, source text, value text, agrees integer);
		create table quests(id integer primary key, title text, level integer, min_level integer, max_level integer, races text, classes integer, xp integer, next integer, time_limit integer, zone integer, sources text);
		create table npcs(id integer primary key, name text, subname text, level integer, level_max integer, faction text, rank integer, sources text);
		create table objects(id integer primary key, name text, sources text);
		create table items(id integer primary key, name text, quest_item integer, duration integer, sources text);
		create table spawns(kind text, id integer, map integer, frame text, x real, y real);
		create table drops(item integer, kind text, ent integer, chance real);
		create table mechanics(quest integer, kind text, status text, source text, confidence text, drives integer, sources text);
		create table steps(quest integer, n integer, action text, target_kind text, target integer, item integer, count integer, place text, fact text, confidence text, drives integer, source text, evidence text);
		insert into sources values ('correction', 0, '', null), ('tdb', 1, '', null), ('eg', 1.5, '', null), ('page', 2, '', null), ('questie', 4, '', null),
			('factoruide', 6, '', null), ('factoruide.web', 6, '', null), ('pfquest', 8, '', null), ('cmangos', 9, '', null);
		insert into quests(id, title) values (1, 'Alpha'), (2, 'Beta'), (3, '<UNUSED> Gamma');
		insert into npcs(id, name) values (10, 'Gnoll');
		insert into items(id, name) values (20, 'Gnoll Paw');
		insert into drops values (20, 'npc', 10, 25.4567);
		-- quest 1: a site-only title; a site level with an independent alternative; an unbacked and a backed correction
		insert into facts values ('quest', 1, 'title', 'Alpha', 'page', 'high', 1, 1);
		insert into facts values ('quest', 1, 'level', '10', 'page', 'high', 1, 2);
		insert into alternatives values ('quest', 1, 'level', 'eg', '12', 0);
		insert into facts values ('quest', 1, 'min_level', '6', 'correction', 'high', 1, 1);
		insert into alternatives values ('quest', 1, 'min_level', 'page', '6', 1);
		insert into facts values ('quest', 1, 'races', 'alliance', 'correction', 'high', 2, 2);
		insert into alternatives values ('quest', 1, 'races', 'eg', 'alliance', 1);
		insert into facts values ('quest', 1, 'side', 'A', 'factoruide.web', 'low', 1, 1);
		-- quest 2: independent values; xp only from a check-only source (no facts row)
		insert into facts values ('quest', 2, 'title', 'Beta', 'questie', 'high', 1, 1);
		insert into facts values ('quest', 2, 'start', 'npc:10', 'eg', 'high', 1, 1);
		insert into facts values ('quest', 2, 'end', 'npc:10', 'questie', 'high', 1, 1);
		insert into facts values ('quest', 2, 'objectives', 'c:10:3;i:20:5', 'questie', 'high', 1, 1);
		insert into facts values ('quest', 2, 'races', 'any', 'questie', 'high', 1, 1);
		insert into alternatives values ('quest', 2, 'xp', 'cmangos', '400', 0);
		insert into facts values ('quest', 3, 'title', '<UNUSED> Gamma', 'questie', 'high', 1, 1);
		insert into facts values ('npc', 10, 'name', 'Gnoll', 'questie', 'high', 1, 1);
		insert into facts values ('npc', 10, 'npc_level', '5-6', 'questie', 'high', 1, 1);
		insert into mechanics values (2, 'group/elite', 'kept', 'server', 'high', 1, '[\"server\"]');
		insert into mechanics values (2, 'other', 'kept', 'quest-text', 'high', 0, '[\"quest-text\"]');
		-- steps: one shippable (high, structured, no page text); three held
		insert into steps values (2, 1, 'kill', 'npc', 10, null, 3, '{\"name\":\"Gnoll camp\",\"x\":50,\"y\":50,\"zone\":\"Elwynn Forest\"}', 'Kill three gnolls by the camp.', 'high', 1, 'forever-data', '[\"data\"]');
		insert into steps values (2, 2, 'loot', 'item', 20, 20, 5, '', 'Loot five paws.', 'medium', 0, 'forever-data', '[\"data\"]');
		insert into steps values (2, 3, 'turn-in', 'npc', 10, null, null, '', 'Turn in where a player said.', 'high', 0, 'forever-data', '[\"comment\",\"data\"]');
		insert into steps values (2, 4, 'other', null, null, null, null, '', 'A note.', 'high', 0, 'player-notes', '[\"data\"]');
		insert into steps values (2, null, 'gotcha', null, null, null, null, '', 'The quest has a timer.', 'high', 0, 'forever-data', '[\"data\"]');
		-- junk: a broken title without a confirmed turn-in is dropped; an odd title with both is kept
		insert into quests(id, title) values (4, 'The \"Chow\" Quest (123)aa'), (5, 'Odd (2) Title');
		insert into facts values ('quest', 4, 'title', 'The \"Chow\" Quest (123)aa', 'questie', 'high', 1, 1);
		insert into facts values ('quest', 4, 'start', 'item:20', 'factoruide', 'high', 1, 1);
		insert into facts values ('quest', 4, 'level', '1', 'questie', 'high', 1, 1);
		insert into facts values ('quest', 5, 'start', 'npc:10', 'questie', 'high', 1, 1);
		insert into facts values ('quest', 5, 'end', 'npc:10', 'questie', 'high', 1, 1);",
	)
	.unwrap();
}

fn rows(dir: &Path, table: &str) -> Vec<Value> {
	std::fs::read_to_string(dir.join("data").join(format!("{table}.jsonl"))).unwrap().lines().map(|l| serde_json::from_str(l).unwrap()).collect()
}

fn publish_once(name: &str) -> (PathBuf, PathBuf, PathBuf) {
	publish_with(name, "")
}

/// publish on the synthetic KB after `extra` SQL ran on it.
fn publish_with(name: &str, extra: &str) -> (PathBuf, PathBuf, PathBuf) {
	publish_with_evidence(name, extra, None)
}

fn publish_with_evidence(name: &str, extra: &str, evidence: Option<PathBuf>) -> (PathBuf, PathBuf, PathBuf) {
	publish_opts(name, extra, |o| o.evidence = evidence.clone())
}

/// publish on the synthetic KB after `extra` SQL ran on it, with `tweak` applied to the options.
fn publish_opts(name: &str, extra: &str, tweak: impl Fn(&mut publish::Options)) -> (PathBuf, PathBuf, PathBuf) {
	let base = scratch(name);
	let kb = base.join("kb.sqlite");
	make_kb(&kb);
	rusqlite::Connection::open(&kb).unwrap().execute_batch(extra).unwrap();
	let out = base.join("release");
	let side = base.join("private").join("provenance.sqlite");
	let mut o = publish::Options::new(&base, &out);
	o.kb = kb;
	o.public_data = Some(fixture());
	o.public_drops = Some(fixture());
	o.provenance = side.clone();
	o.factoruide = None;
	o.cmangos = None;
	o.tdb = None;
	o.sources = base.join("no-sources");
	o.corrections = base.join("no-corrections.json");
	o.version = Some("2026.10.1".into());
	o.date = Some("2026-10-23".into());
	o.producer_commit = Some("test".into());
	o.evidence = None;
	tweak(&mut o);
	publish::run(&o, &|_| {}).unwrap();
	(base, out, side)
}

/// Every file under `dir` with its bytes, by relative path.
fn snapshot(dir: &Path) -> Vec<(String, Vec<u8>)> {
	publish::release::release_files(dir).unwrap().into_iter().map(|f| (f.strip_prefix(dir).unwrap().display().to_string(), std::fs::read(&f).unwrap())).collect()
}

#[test]
fn publish_is_deterministic_and_keeps_the_hand_written_files() {
	let (base, out, _) = publish_once("determinism");
	let first = snapshot(&out);
	assert!(first.iter().any(|(f, _)| f == "corrections/LEDGER.md"));
	// a hand edit of README.md and NOTICE.md survives; a stray generated file goes
	std::fs::write(out.join("README.md"), "# Our own README\n").unwrap();
	std::fs::write(out.join("NOTICE.md"), "# Our own NOTICE\n").unwrap();
	std::fs::write(out.join("data").join("old.jsonl"), "{}\n").unwrap();
	let mut o = publish::Options::new(&base, &out);
	o.kb = base.join("kb.sqlite");
	o.public_data = Some(fixture());
	o.public_drops = Some(fixture());
	o.provenance = base.join("private").join("provenance.sqlite");
	(o.factoruide, o.cmangos, o.tdb, o.evidence) = (None, None, None, None);
	o.sources = base.join("no-sources");
	o.corrections = base.join("no-corrections.json");
	o.date = Some("2026-10-23".into());
	o.producer_commit = Some("test".into());
	// no --version: the one already in the folder
	publish::run(&o, &|_| {}).unwrap();
	let second = snapshot(&out);
	assert_eq!(std::fs::read_to_string(out.join("README.md")).unwrap(), "# Our own README\n");
	assert_eq!(std::fs::read_to_string(out.join("NOTICE.md")).unwrap(), "# Our own NOTICE\n");
	assert!(!out.join("data").join("old.jsonl").exists());
	let generated = |s: &[(String, Vec<u8>)]| -> Vec<(String, Vec<u8>)> { s.iter().filter(|(f, _)| f != "README.md" && f != "NOTICE.md").cloned().collect() };
	assert_eq!(generated(&first), generated(&second), "the same inputs give the same bytes");
	// a folder holding other files is refused
	std::fs::write(out.join("stray.txt"), "x").unwrap();
	assert!(publish::run(&o, &|_| {}).is_err());
	std::fs::remove_file(out.join("stray.txt")).unwrap();
	// the zip (under forever-db/) and the sqlite export are deterministic too
	let ex = publish::export(&out, true, Some(&base.join("t.sqlite"))).unwrap();
	let (zip, _) = ex.zip.unwrap();
	assert!(zip.ends_with("forever-db-2026.10.1.zip"));
	let a = std::fs::read(&zip).unwrap();
	publish::export(&out, true, None).unwrap();
	assert_eq!(a, std::fs::read(&zip).unwrap());
	assert!(a.windows(b"forever-db/data/quest.jsonl".len()).any(|w| w == b"forever-db/data/quest.jsonl"));
	let db = rusqlite::Connection::open(base.join("t.sqlite")).unwrap();
	let n: i64 = db.query_row("select count(*) from quest", [], |r| r.get(0)).unwrap();
	assert_eq!(n as usize, rows(&out, "quest").len());
	let v: String = db.query_row("select v from meta where k = 'version'", [], |r| r.get(0)).unwrap();
	assert_eq!(v, "2026.10.1");
	let _ = std::fs::remove_dir_all(&base);
}

#[test]
fn publish_quest_notes_and_note_fixes() {
	// --notes: steps and notes from the rewritten quest notes, each with its stable id; a note fix
	// record applies, the ledger lists it, and --check fails on a conflicting one.
	let src = scratch("notes-src");
	let qn = src.join("quest-notes.json");
	std::fs::write(
		&qn,
		r#"{"quests":{"2":{"steps":[
			{"n":1,"action":"kill","targets":[{"type":"npc","id":10}],"items":[],"count":3,"place":null,"fact":"Kill three gnolls.","basis":"game-data"},
			{"n":2,"action":"turn-in","targets":[{"type":"npc","id":10}],"items":[],"count":null,"place":{"kind":"npc","id":10,"map":1429,"x":50,"y":50,"frame":"e"},"fact":"Hand it in.","basis":"community"}],
			"notes":[{"fact":"A timer runs.","kind":"timer","basis":"game-data"},{"fact":"Gnolls hit hard.","kind":"danger","basis":"community"}]},
			"99":{"steps":[{"n":1,"action":"talk","targets":[],"items":[],"fact":"Not published.","basis":"game-data"}],"notes":[]}}}"#,
	)
	.unwrap();
	use publish::notes::{id_stem, note_identity, step_identity};
	let kill = id_stem(2, true, &step_identity("kill", &[("npc".into(), 10)], &[], None));
	let danger = id_stem(2, false, &note_identity("danger", &[], None));
	let timer = id_stem(2, false, &note_identity("timer", &[], None));
	let fixes = src.join("notes.json");
	std::fs::write(
		&fixes,
		serde_json::json!({
			kill.clone(): {"set": {"fact": "Kill three gnolls at the camp."}, "source": {"kind": "in-game-check", "ref": "issue 1"}, "note": "they are at the camp"},
			danger.clone(): {"promote": "game-data", "source": {"kind": "recording", "ref": "session 2"}, "note": "two players confirmed"},
			"2:s:00000000": {"drop": true, "source": {"kind": "in-game-check", "ref": "issue 2"}, "note": "gone"}
		})
		.to_string(),
	)
	.unwrap();
	let (base, out, side) = publish_opts("notes", "", |o| {
		o.notes = Some(qn.clone());
		o.note_fixes = Some(fixes.clone());
	});
	let st = rows(&out, "step");
	assert_eq!(st.len(), 2, "{st:?}");
	assert_eq!(st[0]["id"], kill.as_str());
	assert_eq!(st[0]["text"], "Kill three gnolls at the camp.");
	assert_eq!(st[1]["confidence"], "unconfirmed");
	assert!(st[1]["place"]["map"].is_i64(), "the place in world yards: {}", st[1]);
	let notes = rows(&out, "note");
	let n = |id: &str| notes.iter().find(|r| r["id"] == id).cloned().unwrap();
	assert!(n(&danger).get("confidence").is_none(), "promoted");
	assert_eq!(n(&timer)["kind"], "timer");
	let ledger = std::fs::read_to_string(out.join("corrections").join("LEDGER.md")).unwrap();
	assert!(ledger.contains("Applied 2, stale 1, conflicting 0"), "{ledger}");
	assert_eq!(std::fs::read(out.join("corrections").join("notes.json")).unwrap(), std::fs::read(&fixes).unwrap(), "the records ship beside the ledger");
	let opts = check::CheckOptions { provenance: Some(side.clone()), evidence: None, corrections: None };
	let (find, warn) = check::check(&out, &opts).unwrap();
	assert!(find.is_empty(), "{find:#?}");
	assert!(warn.iter().any(|w| w.contains("2:s:00000000") && w.contains("stale")), "{warn:#?}");
	// a conflicting record fails --check
	std::fs::write(&fixes, serde_json::json!({ timer.clone(): {"set": {"kind": "tip"}, "drop": true, "source": {"kind": "in-game-check", "ref": "issue 3"}, "note": "two things"} }).to_string())
		.unwrap();
	let (_, out2, side2) = publish_opts("notes-conflict", "", |o| {
		o.notes = Some(qn.clone());
		o.note_fixes = Some(fixes.clone());
	});
	let (find, _) = check::check(&out2, &check::CheckOptions { provenance: Some(side2), evidence: None, corrections: None }).unwrap();
	assert!(find.iter().any(|f| f.contains("(g)") && f.contains(&timer)), "{find:#?}");
	let _ = std::fs::remove_dir_all(&src);
	let _ = std::fs::remove_dir_all(&base);
}

#[test]
fn publish_steps_rewritten_notes() {
	// Rewritten notes: game-data ships as is, community ships unconfirmed, even from page-text
	// evidence; a row without a basis keeps the structured-row rule.
	let (base, out, side) = publish_with(
		"basis",
		"alter table steps add column basis text;
		update steps set basis = 'game-data' where n = 2;
		update steps set basis = 'community' where n = 3;",
	);
	let st = rows(&out, "step");
	let ns: Vec<i64> = st.iter().map(|r| r["n"].as_i64().unwrap()).collect();
	assert_eq!(ns, vec![1, 2, 3, 5], "{st:?}");
	assert!(st[1].get("confidence").is_none());
	assert_eq!(st[2]["confidence"], "unconfirmed");
	let (find, _) = check::check(&out, &check::CheckOptions { provenance: Some(side), evidence: None, corrections: None }).unwrap();
	assert!(find.is_empty(), "{find:#?}");
	let _ = std::fs::remove_dir_all(&base);
}

#[test]
fn publish_steps_quoting_page_text_held() {
	// A step whose text runs 8 words of a page-text evidence quote is held; a run of a quote of
	// our own structured data is not page text.
	let src = scratch("evidence-src");
	let ev = src.join("evidence");
	std::fs::create_dir_all(&ev).unwrap();
	std::fs::write(
		ev.join("2.json"),
		r#"{"reading":{"steps":[{"evidence":[{"from":"comment:1","quote":"you must kill three gnolls by the camp near the river"},{"from":"data","quote":"The quest has a timer that runs for twelve whole minutes"}]}]}}"#,
	)
	.unwrap();
	let (base, out, _) = publish_with_evidence(
		"evidence",
		"update steps set fact = 'Kill three gnolls by the camp near the river.' where n = 1;
		update steps set fact = 'The quest has a timer that runs for twelve whole minutes.' where n is null;",
		Some(ev),
	);
	let ns: Vec<i64> = rows(&out, "step").iter().map(|r| r["n"].as_i64().unwrap()).collect();
	assert_eq!(ns, vec![5]);
	let _ = std::fs::remove_dir_all(&src);
	let _ = std::fs::remove_dir_all(&base);
}

#[test]
fn publish_tier_selection_and_schema() {
	let (base, out, side) = publish_once("tier");
	let q = rows(&out, "quest");
	let q1 = q.iter().find(|r| r["id"] == 1).unwrap();
	// site-only title omitted, never kept with its source stripped
	assert!(q1.get("title").is_none(), "{q1}");
	// the independent alternative replaces the site winner
	assert_eq!(q1["level"], 12);
	// a correction only the site agrees with is not published; one an independent source backs is
	assert!(q1.get("min_level").is_none(), "{q1}");
	assert_eq!(q1["races"], 1u64 | 4 | 8 | 64 | (1 << 32));
	// site-sourced Factoruide side is cut; side comes from the published races
	assert_eq!(q1["side"], 1);
	let q2 = q.iter().find(|r| r["id"] == 2).unwrap();
	assert_eq!(q2["title"], "Beta");
	assert_eq!(q2["xp"], 400, "check-only alternative without a facts row is a candidate");
	assert_eq!(q2["zone_area"], 12);
	assert_eq!(q2["repeatable"], true);
	assert!(q.iter().all(|r| r["id"] != 3), "placeholder quest dropped");
	assert!(q.iter().all(|r| r["id"] != 4), "junk title without a confirmed turn-in dropped");
	assert!(q.iter().any(|r| r["id"] == 5), "an odd title with giver and turn-in kept");
	assert!(publish::tables::junk_title("The \"Chow\" Quest (123)aa") && publish::tables::junk_title("Thing aa"));
	assert!(!publish::tables::junk_title("The Burning Inn") && !publish::tables::junk_title("Mazen's Behest"));
	assert_eq!(rows(&out, "quest_start"), vec![serde_json::json!({"id": 10, "kind": "npc", "quest": 2}), serde_json::json!({"id": 10, "kind": "npc", "quest": 5})]);
	// only the high structured step without page text ships; its place in world yards; its id
	// from its identity (action, targets, items, place target), never its text
	use publish::notes::{id_stem, step_identity};
	let kill = id_stem(2, true, &step_identity("kill", &[("npc".into(), 10)], &[], None));
	let gotcha = id_stem(2, true, &step_identity("gotcha", &[], &[], None));
	assert_eq!(
		rows(&out, "step"),
		vec![
			serde_json::json!({"action": "kill", "count": 3, "id": kill, "n": 1, "place": {"map": 0, "x": -9500, "y": -8500}, "quest": 2, "target": 10, "target_kind": "npc", "text": "Kill three gnolls by the camp."}),
			// a gotcha (no step number) numbered after the quest's last step
			serde_json::json!({"action": "gotcha", "id": gotcha, "n": 5, "quest": 2, "text": "The quest has a timer."})
		]
	);
	assert_eq!(rows(&out, "quest_objective").len(), 2);
	assert_eq!(rows(&out, "quest_prereq"), vec![serde_json::json!({"mode": "all", "pre": 1, "quest": 2})]);
	let npc = rows(&out, "npc");
	assert_eq!(npc, vec![serde_json::json!({"id": 10, "level_max": 6, "level_min": 5, "name": "Gnoll", "rank": 1})]);
	// spawns in world yards, deduplicated within a yard, z from CMaNGOS
	let sp = rows(&out, "spawn");
	assert_eq!(sp.len(), 2, "{sp:?}");
	assert!(sp.contains(&serde_json::json!({"id": 10, "kind": "npc", "map": 0, "n": 1, "x": -9500, "y": -8500, "z": 40})));
	// pfQuest chance rounded to 0.1
	assert_eq!(rows(&out, "item_source"), vec![serde_json::json!({"chance": 25.5, "id": 10, "item": 20, "kind": "npc"})]);
	// only own-layer origins in mechanics
	assert_eq!(rows(&out, "mechanic"), vec![serde_json::json!({"kind": "group/elite", "params": {"drives_route": true}, "quest": 2})]);
	// every row validates; keys sorted
	for def in publish::schema::TABLES {
		for r in rows(&out, def.name) {
			publish::schema::validate(def, &r).unwrap();
		}
	}
	let text = |f: &str| std::fs::read_to_string(out.join(f)).unwrap();
	assert!(text("LICENSE").contains("GNU GENERAL PUBLIC LICENSE") && text("LICENSE").contains("Version 3, 29 June 2007"));
	assert!(text("LICENSE-CC-BY-4.0.txt").starts_with("Attribution 4.0 International"));
	assert!(text("README.md").contains("not affiliated with\nor endorsed by Blizzard") && text("README.md").contains("`data/step.jsonl`"));
	// the map frames table: world yards to map percent
	assert!(rows(&out, "ui_map").iter().any(|r| r["ui_map"] == 1429), "{:?}", rows(&out, "ui_map"));
	let pkg: Value = serde_json::from_str(&text("datapackage.json")).unwrap();
	let lic = |name: &str| pkg["resources"].as_array().unwrap().iter().find(|r| r["name"] == name).unwrap()["licenses"][0]["name"].clone();
	assert_eq!(lic("quest"), "GPL-3.0-only");
	assert_eq!(lic("step"), "CC-BY-4.0");
	for f in ["datapackage.json", "index.json", "NOTICE.md", "LICENSE", "LICENSE-CC-BY-4.0.txt", "README.md", "CHANGELOG.md", "schema/quest.schema.json"] {
		assert!(out.join(f).is_file(), "{f}");
	}
	let index: Value = serde_json::from_slice(&std::fs::read(out.join("index.json")).unwrap()).unwrap();
	assert_eq!(index["clientBuild"], "1.60.1.70532");
	assert_eq!(index["counts"]["quest"], 3);
	// the sidecar is outside the release and names the sources
	assert!(side.is_file() && !side.starts_with(&out));
	assert!(!publish::release::release_files(&out).unwrap().iter().any(|f| f.extension().is_some_and(|e| e == "sqlite")));
	let db = rusqlite::Connection::open(&side).unwrap();
	let s: String = db.query_row("select sources from prov where tbl = 'quest' and key = '1' and field = 'level'", [], |r| r.get(0)).unwrap();
	assert_eq!(s, "eg");
	let cuts: i64 = db.query_row("select count(*) from cut where tbl = 'quest' and key = '1' and field in ('title', 'min_level')", [], |r| r.get(0)).unwrap();
	assert_eq!(cuts, 2);
	// a provenance path inside the release is refused
	let mut o = publish::Options::new(&base, &out);
	o.provenance = out.join("p.sqlite");
	assert!(publish::run(&o, &|_| {}).is_err());
	let _ = std::fs::remove_dir_all(&base);
}

#[test]
fn publish_check_catches_planted_findings() {
	let (base, out, side) = publish_once("check");
	let opts = check::CheckOptions { provenance: Some(side.clone()), evidence: None, corrections: None };
	let (find, _) = check::check(&out, &opts).unwrap();
	assert!(find.is_empty(), "{find:#?}");

	let append = |table: &str, line: &str| {
		let p = out.join("data").join(format!("{table}.jsonl"));
		let mut t = std::fs::read_to_string(&p).unwrap();
		t.push_str(line);
		t.push('\n');
		std::fs::write(&p, t).unwrap();
	};
	append("item_source", r#"{"chance":33.5997,"id":11,"item":20,"kind":"npc"}"#);
	append("npc", r#"{"id":11,"level_max":9999,"level_min":9999,"name":"Placeholder"}"#);
	append("object", r#"{"id":12,"name":"A page snapshot"}"#);
	let (find, _) = check::check(&out, &opts).unwrap();
	let has = |s: &str| find.iter().any(|f| f.contains(s));
	assert!(has("more than 2 decimals"), "{find:#?}");
	assert!(has("level_min 9999") && has("level_max 9999"), "{find:#?}");
	assert!(has("guard word 'page snapshot'"), "{find:#?}");
	assert!(has("(a) data/npc.jsonl") && has("no provenance"), "{find:#?}");
	let _ = std::fs::remove_dir_all(&base);
}

#[test]
fn the_library_answers_as_the_release_says() {
	// LibForeverData from a release, loaded under Lua 5.1 by tests/lua/libforeverdata_test.lua,
	// which checks its answers against the release's data/*.jsonl.
	let (base, out, _) = publish_once("library");
	let lib = base.join("addons");
	let (files, bytes) = publish::lua::write(&out, &lib).unwrap();
	assert!(files >= 8 && bytes > 0);
	let toc = std::fs::read_to_string(lib.join("LibForeverData/LibForeverData.toc")).unwrap();
	assert!(toc.starts_with("## Interface: 16001\n") && toc.contains("## X-License: GPL-3.0") && toc.contains("## Version: 1.2026.10.1"));
	let script = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../tests/lua/libforeverdata_test.lua");
	let lua = ["lua5.1", "luajit"].into_iter().find(|l| std::process::Command::new(l).arg("-v").output().is_ok());
	let Some(lua) = lua else {
		eprintln!("no lua5.1 or luajit: the library's Lua test is skipped");
		return;
	};
	let run = std::process::Command::new(lua).arg(&script).arg(&lib).arg(&out).output().unwrap();
	let text = String::from_utf8_lossy(&run.stdout).to_string() + &String::from_utf8_lossy(&run.stderr);
	assert!(run.status.success(), "{text}");
	assert!(text.contains(", 0 failed"), "{text}");
	let _ = std::fs::remove_dir_all(&base);
}

#[test]
fn publish_check_corrections_sources() {
	// The guard holds a corrections file to check-corrections' contract: `source` is one
	// { kind, ref } or a list of them, each kind an independent source.
	let (base, out, side) = publish_once("check-corrections");
	let file = base.join("corrections.json");
	std::fs::write(
		&file,
		r#"{ "quests": {
			"10": { "set": { "pre": [11] }, "source": { "kind": "in-game-check", "ref": "issue 1" }, "note": "checked in game" },
			"11": { "set": { "pre": [12] }, "source": [{ "kind": "questie", "ref": "quest 11" }, { "kind": "cmangos", "ref": "quest_template" }], "note": "two sources" } } }"#,
	)
	.unwrap();
	let opts = check::CheckOptions { provenance: Some(side.clone()), evidence: None, corrections: Some(file.clone()) };
	let (find, _) = check::check(&out, &opts).unwrap();
	assert!(find.is_empty(), "{find:#?}");

	std::fs::write(
		&file,
		r#"{ "quests": { "11": { "set": { "pre": [12] }, "source": [{ "kind": "cmangos", "ref": "quest_template" }, { "kind": "website", "ref": "a page" }], "note": "one bad source" } } }"#,
	)
	.unwrap();
	let (find, _) = check::check(&out, &opts).unwrap();
	assert!(find.iter().any(|f| f.contains("corrections quests.11.source[1].kind") && f.contains("\"website\" is none of")), "{find:#?}");
	let _ = std::fs::remove_dir_all(&base);
}
