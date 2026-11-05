//! The public data pack on a made-up checkout that holds every kind of private data next to the
//! public sources: the pack leaves the private files out, the knowledge base keeps only its
//! public part, the guard finds a planted private file, and `fetch` takes the pack from a local
//! path, checks it and refuses a tampered archive.

use forge::{fetch, pack};
use rusqlite::Connection;
use std::path::{Path, PathBuf};

fn put(root: &Path, rel: &str, text: &str) {
	let p = root.join(rel);
	std::fs::create_dir_all(p.parent().unwrap()).unwrap();
	std::fs::write(p, text).unwrap();
}

fn scratch(name: &str) -> PathBuf {
	let d = std::env::temp_dir().join(format!("forge-pack-{name}-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

fn kb(path: &Path) {
	std::fs::create_dir_all(path.parent().unwrap()).unwrap();
	let c = Connection::open(path).unwrap();
	c.execute_batch(
		"create table facts(kind text, id integer, field text, value text, source text, confidence text, agree integer, total integer, primary key(kind, id, field));
         create table alternatives(kind text, id integer, field text, source text, value text, agrees integer);
         create table mechanics(quest integer, kind text, status text, source text, confidence text, drives integer, sources text);
         create table steps(quest integer, n integer, action text, target_kind text, target integer, item integer, count integer, place text, fact text, confidence text, drives integer);
         create table verify_in_game(rank integer, kind text, id integer, name text, yards integer, conflicts text);
         create table sources(name text primary key, tier real, label text, version text);
         insert into facts values ('quest', 1, 'objectives', 'kill 8 boars', 'eg', 'high', 1, 1);
         insert into facts values ('quest', 2, 'objectives', 'from the page', 'page', 'high', 1, 2);
         insert into facts values ('quest', 3, 'objectives', 'secret value', 'foreverdb', 'medium', 1, 3);
         insert into facts values ('quest', 4, 'xp', '450', 'factoruide', 'low', 1, 2);
         insert into facts values ('quest', 5, 'start', '123', 'questie', 'medium', 2, 3);
         insert into alternatives values ('quest', 2, 'objectives', 'page', 'from the page', 1);
         insert into mechanics values (1, 'escort', 'confirmed', 'server', 'high', 1, '[\"server\",\"player-notes\"]');
         insert into mechanics values (2, 'use-item', 'read', 'player-notes', 'high', 1, '[\"player-notes\"]');
         insert into mechanics values (3, 'event', 'read', 'quest-text', 'medium', 1, '[\"quest-text\",\"player-notes\"]');
         insert into mechanics values (4, 'escort', 'confirmed', 'server', 'high', 1, '[\"server\",\"forever-data\"]');
         insert into mechanics values (5, 'event', 'read', 'forever-data', 'medium', 1, '[\"forever-data\"]');
         insert into mechanics values (6, 'event', 'read', 'server-forever', 'high', 1, '[\"server-forever\"]');
         insert into steps values (1, 1, 'kill', 'npc', 10, null, 8, null, 'Kill the boars by the farm.', 'high', 1);
         insert into steps values (1, 2, 'use', 'object', 11, null, 1, null, 'A medium guess.', 'medium', 1);
         insert into verify_in_game values (1, 'quest', 3, 'Some Quest', 120, '[{\"field\":\"objectives\",\"ours\":\"x\",\"others\":[{\"source\":\"foreverdb\",\"value\":\"secret value\"}]}]');
         insert into sources values ('eg', 1.5, 'EG Link output', 'd98f');
         insert into sources values ('page', 2.0, 'web quest-database pages', '2026-10-17');
         insert into sources values ('foreverdb', 3.1, 'ForeverDB: game cache', '0.39');",
	)
	.unwrap();
}

/// A checkout with every file the spec packs (tiny), plus private files beside them.
fn checkout(root: &Path) {
	for f in [
		"LICENSE",
		"db/quests.lua",
		"db/units.lua",
		"db/objects.lua",
		"db/items.lua",
		"db/refloot.lua",
		"db/areatrigger.lua",
		"db/meta.lua",
		"db/enUS/quests.lua",
		"db/enUS/units.lua",
		"db/enUS/objects.lua",
		"db/enUS/items.lua",
	] {
		put(root, &format!("data/sources/pfQuest/{f}"), "-- pfQuest\n");
	}
	for b in ["1.15.9.70003", "1.15.8.60000"] {
		put(root, &format!("data/sources/wago/{b}/UiMap.csv"), "ID\n1\n");
	}
	put(root, "data/sources/wago/1.15.9.70003/QuestXP.csv", "ID\n1\n");
	put(root, "data/sources/wago/1.15.9.70003/enUS/UiMap.csv", "locale\n");
	put(root, "data/sources/wago/1.60.1.70450/AreaTable.csv", "ID\n1\n");
	put(root, "data/sources/wago/1.60.1.70425/AreaTable.csv", "ID\n0\n");
	for f in ["LICENSE.md", "manifest.json", "definitions/Map.dbd"] {
		put(root, &format!("data/sources/wowdbdefs/{f}"), "defs\n");
	}
	for f in ["spawnz.json", "spawnz.2.json", "quest_counts.json", "gameobject_facts.json", "graveyards.json", "escort_paths.json", "training.json", "transit.json", "classicdb.sql.gz"] {
		put(root, &format!("data/sources/cmangos/22b51464f162/{f}"), "{}\n");
	}
	put(root, "data/sources/eg-link/d98f/index.json", "{}\n");
	put(root, "data/sources/eg-link/d98f/wow_classic_beta/1.60.1.70450/quests.enUS.json", "{\"quests\":{}}\n");
	for f in ["forever-db/corrections/quests.json", "data/rules.json", "data/sim/params.json", "addon/Polestar_Nav/PACK.json", "data/crossings.json", "data/forever/travel.json"] {
		put(root, f, "{}\n");
	}
	kb(&root.join("data/local/kb/forever-kb.sqlite"));
	// Private: none of these may reach the pack.
	put(root, "data/sources/web/zones.json", "{\"page\":1}\n");
	put(root, "data/sources/webxp/quest-xp.json", "{}\n");
	put(root, "data/local/mechanics/evidence/1.json", "{\"snippet\":\"from a comment\"}\n");
	put(root, "data/local/mechanics/quest-steps.json", "{}\n");
	put(root, "data/forever/dungeons.json", "{}\n");
	put(root, "data/forever/codex/x.json", "{}\n");
}

fn packed(name: &str) -> (PathBuf, pack::Packed) {
	let d = scratch(name);
	let root = d.join("checkout");
	checkout(&root);
	let p = pack::pack(&pack::PackOpts { root, walks_from: None, grid: None, nav_fp: None, out: d.join("out") }, &mut |_| {}).unwrap();
	(d, p)
}

#[test]
fn pack_leaves_private_data_out() {
	let (d, p) = packed("private");
	assert!(pack::scan_private(&p.dir).unwrap().is_empty());
	for gone in [
		"data/forever/travel.json",
		"data/sources/web",
		"data/sources/webxp",
		"data/local/mechanics",
		"data/forever/dungeons.json",
		"data/forever/codex",
		"data/sources/cmangos/22b51464f162/classicdb.sql.gz",
		"data/sources/wago/1.15.9.70003/enUS",
	] {
		assert!(!p.dir.join(gone).exists(), "{gone} packed");
	}
	// Newest builds only.
	assert!(p.dir.join("data/sources/wago/1.15.9.70003/UiMap.csv").exists());
	assert!(!p.dir.join("data/sources/wago/1.15.8.60000").exists());
	assert!(!p.dir.join("data/sources/wago/1.60.1.70425").exists());
	let c = Connection::open(p.dir.join("data/local/kb/forever-kb.sqlite")).unwrap();
	let facts: Vec<(i64, String, String, String)> =
		c.prepare("select id, value, source, confidence from facts order by id").unwrap().query_map([], |r| Ok((r.get(0)?, r.get(1)?, r.get(2)?, r.get(3)?))).unwrap().map(Result::unwrap).collect();
	// 1: public and high, kept; 2: page, out; 3, 4: uncertain, kept as markers without their
	// values; 5: QuestieDB's (not redistributable yet), so only its uncertainty is kept.
	assert_eq!(
		facts,
		vec![
			(1, "kill 8 boars".into(), "eg".into(), "high".into()),
			(3, "".into(), "kb".into(), "medium".into()),
			(4, "".into(), "kb".into(), "low".into()),
			(5, "".into(), "kb".into(), "medium".into())
		]
	);
	let mech: Vec<(i64, Option<String>, String)> =
		c.prepare("select quest, status, sources from mechanics order by quest").unwrap().query_map([], |r| Ok((r.get(0)?, r.get(1)?, r.get(2)?))).unwrap().map(Result::unwrap).collect();
	// Public sources only: 1 keeps its status on one public source (at medium), 4 on two; 5 as it
	// is; 2, 3, 6 (site or ForeverDB only, driving) as markers without their status.
	assert_eq!(
		mech,
		vec![
			(1, Some("confirmed".into()), "[\"server\"]".into()),
			(2, None, "[]".into()),
			(3, None, "[]".into()),
			(4, Some("confirmed".into()), "[\"server\",\"forever-data\"]".into()),
			(5, Some("read".into()), "[\"forever-data\"]".into()),
			(6, None, "[]".into())
		]
	);
	let conf: Vec<String> = c.prepare("select confidence from mechanics order by quest").unwrap().query_map([], |r| r.get(0)).unwrap().map(Result::unwrap).collect();
	assert_eq!(conf, vec!["medium", "low", "low", "high", "medium", "low"]);
	// No quest steps: this KB has no step sources (every step a reading of the page snapshot).
	let steps: i64 = c.query_row("select count(*) from steps", [], |r| r.get(0)).unwrap();
	assert_eq!(steps, 0);
	let conflicts: String = c.query_row("select conflicts from verify_in_game", [], |r| r.get(0)).unwrap();
	assert_eq!(conflicts, "[{\"field\":\"objectives\"}]");
	let alt: i64 = c.query_row("select count(*) from sqlite_master where name = 'alternatives'", [], |r| r.get(0)).unwrap();
	assert_eq!(alt, 0);
	let srcs: Vec<String> = c.prepare("select name from sources order by name").unwrap().query_map([], |r| r.get(0)).unwrap().map(Result::unwrap).collect();
	assert_eq!(srcs, vec!["eg", "kb"]);
	// The manifest credits every source and names what is not in the pack.
	let m: serde_json::Value = serde_json::from_slice(&std::fs::read(p.dir.join("manifest.json")).unwrap()).unwrap();
	for s in m["sources"].as_array().unwrap() {
		assert!(s["licence"].is_string() && s["credit"].is_string(), "{s}");
	}
	assert!(m["files"].as_array().unwrap().iter().all(|f| f["source"].is_string() && f["blake3"].as_str().unwrap().len() == 64));
	// Leffe's maps are private: no source, no asset.
	assert!(m["sources"].as_array().unwrap().iter().all(|s| s["id"] != "leffe-nav" && s["asset"].is_null()));
	assert!(p.assets.is_empty());
	assert_eq!(m["requires"][0]["id"], "grid");
	let _ = std::fs::remove_dir_all(d);
}

#[test]
fn guard_finds_a_planted_private_file() {
	let (d, p) = packed("guard");
	put(&p.dir, "data/sources/notes.txt", "copied from ForeverDB\n");
	put(&p.dir, "data/local/mechanics/evidence/2.json", "{}\n");
	let found = pack::scan_private(&p.dir).unwrap();
	assert!(found.iter().any(|f| f.contains("notes.txt") && f.contains("foreverdb")), "{found:?}");
	assert!(found.iter().any(|f| f.contains("evidence/2.json")), "{found:?}");
	// Leffe's maps are private: his Nav folder makes the pack refuse.
	put(&p.dir, "leffe-nav/Nav/Nav.xml", "<Ui/>\n");
	let found = pack::scan_private(&p.dir).unwrap();
	assert!(found.iter().any(|f| f.contains("leffe-nav/Nav/Nav.xml")), "{found:?}");
	std::fs::remove_dir_all(p.dir.join("leffe-nav")).unwrap();
	let c = Connection::open(p.dir.join("data/local/kb/forever-kb.sqlite")).unwrap();
	c.execute("insert into facts values ('quest', 9, 'xp', '1', 'page', 'high', 1, 1)", []).unwrap();
	drop(c);
	let found = pack::scan_private(&p.dir).unwrap();
	assert!(found.iter().any(|f| f.contains("facts.source names a private source")), "{found:?}");
	let c = Connection::open(p.dir.join("data/local/kb/forever-kb.sqlite")).unwrap();
	c.execute("delete from facts where source = 'page'", []).unwrap();
	c.execute("insert into facts values ('quest', 10, 'xp', '1', 'questie', 'high', 1, 1)", []).unwrap();
	drop(c);
	let found = pack::scan_private(&p.dir).unwrap();
	assert!(found.iter().any(|f| f.contains("facts.source names a private source in 1 rows")), "{found:?}");
	// A quest step, or a mechanic read from the site's quest text or ForeverDB, makes the pack refuse.
	let c = Connection::open(p.dir.join("data/local/kb/forever-kb.sqlite")).unwrap();
	c.execute("delete from facts where source = 'questie'", []).unwrap();
	c.execute("insert into steps values (1, 1, 'kill', 'npc', 10, null, 8, null, 'Kill the boars.', 'high', 1)", []).unwrap();
	c.execute("insert into mechanics values (7, 'event', 'read', 'quest-text', 'high', 1, '[\"quest-text\"]')", []).unwrap();
	c.execute("insert into mechanics values (8, 'event', 'read', 'server', 'high', 1, '[\"server\",\"server-forever\"]')", []).unwrap();
	drop(c);
	let found = pack::scan_private(&p.dir).unwrap();
	assert!(found.iter().any(|f| f.contains("steps holds 1 rows with no source column")), "{found:?}");
	assert!(found.iter().any(|f| f.contains("`quest-text` in 1 rows")), "{found:?}");
	assert!(found.iter().any(|f| f.contains("`server-forever` in 1 rows")), "{found:?}");
	let _ = std::fs::remove_dir_all(d);
}

#[test]
fn fetch_verifies_and_unpacks() {
	let (d, p) = packed("fetch");
	let dest = d.join("user/data-pack");
	let f = fetch::fetch(p.index.to_str().unwrap(), &dest, &mut |_| {}).unwrap();
	assert_eq!(f.files, p.files);
	assert_eq!(fetch::verify(&dest).unwrap().0, p.files);
	assert!(dest.join("data/local/kb/forever-kb.sqlite").is_file());
	// One archive: Leffe's maps are private and never an asset.
	assert!(p.assets.is_empty());
	assert!(!dest.join("leffe-nav").exists());
	// A file changed after unpacking fails verification.
	put(&dest, "data/rules.json", "{\"changed\":1}\n");
	assert!(fetch::verify(&dest).is_err());
	// A tampered archive is refused and the pack in place stays.
	let mut bytes = std::fs::read(&p.archive).unwrap();
	let k = bytes.len() / 2;
	bytes[k] ^= 0xff;
	std::fs::write(&p.archive, bytes).unwrap();
	let e = fetch::fetch(p.index.to_str().unwrap(), &dest, &mut |_| {}).err().unwrap();
	assert!(e.contains("not the published pack"), "{e}");
	assert!(dest.join("manifest.json").is_file());
	let _ = std::fs::remove_dir_all(d);
}

/// Once the KB records each quest step's source and evidence (kb.rs), the public part keeps the
/// high-confidence steps from a public source that quote none of the site's text, with the evidence
/// left empty; a step read from comments or the site's quest text stays out.
#[test]
fn steps_with_sources_keep_only_public_ones() {
	let d = scratch("steps");
	let from = d.join("kb.sqlite");
	kb(&from);
	let c = Connection::open(&from).unwrap();
	c.execute_batch(
        "drop table steps;
         create table steps(quest integer, n integer, action text, target_kind text, target integer, item integer, count integer, place text, fact text, confidence text, drives integer, source text, evidence text);
         insert into steps values (1, 1, 'kill', 'npc', 10, null, 8, null, 'Kill 8 boars.', 'high', 1, 'server', '[\"data\"]');
         insert into steps values (1, 2, 'use', 'object', 11, null, 1, null, 'Use the totem.', 'high', 1, 'server', '[\"data\",\"comment\"]');
         insert into steps values (1, 3, 'talk', 'npc', 12, null, 1, null, 'Talk to him.', 'high', 1, 'quest-text', '[]');
         insert into steps values (1, 4, 'loot', 'object', 13, null, 1, null, 'A guess.', 'medium', 1, 'server', '[]');
         insert into steps values (1, 5, 'loot', 'object', 14, null, 1, null, 'From the comments.', 'high', 1, 'player-notes', '[]');
         insert into steps values (1, 6, 'loot', 'object', 15, null, 1, null, 'Corrected.', 'high', 1, 'correction', null);",
    )
    .unwrap();
	drop(c);
	let to = d.join("public.sqlite");
	let s = |v: &[&str]| v.iter().map(|x| x.to_string()).collect::<Vec<_>>();
	pack::public_kb(&from, &to, &s(&["eg"]), &s(&["forever-data", "server", "correction"]), &s(&["player-notes", "quest-text", "server-forever"])).unwrap();
	let c = Connection::open(&to).unwrap();
	let kept: Vec<(i64, Option<String>)> = c.prepare("select n, evidence from steps order by n").unwrap().query_map([], |r| Ok((r.get(0)?, r.get(1)?))).unwrap().map(Result::unwrap).collect();
	assert_eq!(kept, vec![(1, None), (6, None)]);
	drop(c);
	// The guard: a planted step from the comments makes the pack refuse.
	let c = Connection::open(&to).unwrap();
	c.execute("insert into steps values (2, 1, 'kill', 'npc', 10, null, 8, null, 'x', 'high', 1, 'player-notes', null)", []).unwrap();
	drop(c);
	let dir = d.join("p/data/local/kb");
	std::fs::create_dir_all(&dir).unwrap();
	std::fs::copy(&to, dir.join("forever-kb.sqlite")).unwrap();
	let found = pack::scan_private(&d.join("p")).unwrap();
	assert!(found.iter().any(|f| f.contains("steps holds 1 rows from a private or unknown source")), "{found:?}");
	let _ = std::fs::remove_dir_all(d);
}
