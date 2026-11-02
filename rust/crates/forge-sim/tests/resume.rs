//! Resumable route searches (resume.rs): a search killed mid-way and run again under the same key ends
//! where the uninterrupted search does, a start finished before the kill is not searched again, and
//! checkpoints of another key are not read. A finished search reused under the written check (forge
//! build's search cache: the writer changed, the search did not) undoes the hub batches the search
//! made, as the search itself does.
//!
//! A kill is played by what it leaves on disk: the free search's checkpoint after round k of n is the
//! state a search of fewer tries ends in (a round is `share_every * members` tries whatever the total,
//! so its first k rounds are the same), and the descent's after edit k is a descent capped at k.

mod common;

use common::stage::{inputs, outputs, starts};
use forge_sim::flow::{Finding, FlowCheck};
use forge_sim::order::Order;
use forge_sim::resume::{Resume, DESCENT, DONE, FREE};
use forge_sim::run::{K_ACCEPT, K_TASK, K_TURNIN};
use forge_sim::search::edits::{descend, Cut};
use forge_sim::search::{pool, search, Mode, Problem, SearchOpts};
use forge_sim::stage::{run, RoutesIn};
use serde_json::Value;
use std::path::{Path, PathBuf};
use std::time::Duration;

fn problem<'a>(o: &'a common::Orc, m: &'a forge_sim::Model, seed: &Order) -> Problem<'a> {
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	Problem::single(m, &o.walks, common::pairs(&m.run, seed), pool(&m.run, &rules, seed, &m.tables))
}

fn tmp(name: &str) -> PathBuf {
	let d = Path::new(env!("CARGO_TARGET_TMPDIR")).join(name);
	let _ = std::fs::remove_dir_all(&d);
	d
}

/// Checkpoints in `dir` for `key`, saved at every meeting and edit.
fn resume(dir: &Path, key: &str) -> Resume {
	let mut r = Resume::open(dir, key).unwrap();
	r.every = Duration::ZERO;
	r
}

#[test]
fn an_interrupted_free_search_resumes_and_ends_as_the_uninterrupted_one() {
	let o = common::orc();
	let m = o.model(&[]);
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let opts = |tries: u64| SearchOpts { tries, members: 3, share_every: 100, seed: 7, ..Default::default() };
	let whole = search(&p, &seed, &opts(3000), None);
	assert!(whole.stats.kept > 0, "the search keeps moves");
	let dir = tmp("resume-free");
	// Killed after 5 of its 10 rounds.
	let half = search(&p, &seed, &opts(1500), Some(&resume(&dir, "k").unit("Orc")));
	assert!(dir.join(format!("Orc.{FREE}.json")).is_file());
	let r = resume(&dir, "k");
	let again = search(&p, &seed, &opts(3000), Some(&r.unit("Orc")));
	assert_eq!(r.notes(), vec![format!("resuming Orc from checkpoint ({} tries done)", half.stats.tries)]);
	assert_eq!(again.best, whole.best, "the same order");
	assert_eq!(again.totals.iter().map(|t| t.to_bits()).collect::<Vec<_>>(), whole.totals.iter().map(|t| t.to_bits()).collect::<Vec<_>>(), "the same seconds to 60");
	assert_eq!(format!("{:?}", again.stats), format!("{:?}", whole.stats), "the same counters");
	// Run again once finished: the last round's checkpoint, nothing left to search.
	let r = resume(&dir, "k");
	let done = search(&p, &seed, &opts(3000), Some(&r.unit("Orc")));
	assert_eq!(r.notes(), vec![format!("resuming Orc from checkpoint ({} tries done)", whole.stats.tries)]);
	assert_eq!(done.best, whole.best);
}

#[test]
fn an_interrupted_descent_resumes_and_ends_as_the_uninterrupted_one() {
	let o = common::orc();
	let m = o.model(&[]);
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let whole = descend(&p, &seed, 6, 2, false, &mut |_, _, _| {}, None);
	assert!(whole.edits.len() > 3, "edits to resume from: {}", whole.edits.len());
	let dir = tmp("resume-descent");
	// Killed after its 3rd edit.
	descend(&p, &seed, 3, 2, false, &mut |_, _, _| {}, Some(&resume(&dir, "k").unit("Orc")));
	assert!(dir.join(format!("Orc.{DESCENT}.json")).is_file());
	let r = resume(&dir, "k");
	let mut logged = Vec::new();
	let again = descend(&p, &seed, 6, 2, false, &mut |k, _, _| logged.push(k), Some(&r.unit("Orc")));
	assert_eq!(r.notes(), vec!["resuming Orc edit descent from checkpoint (3 edits done)".to_string()]);
	assert_eq!(logged, (4..=whole.edits.len()).collect::<Vec<_>>(), "only the edits after the checkpoint are searched");
	assert_eq!(again.orders, whole.orders, "the same order after each edit");
	assert_eq!(again.capped, whole.capped);
	for (a, b) in again.edits.iter().zip(&whole.edits) {
		assert_eq!(format!("{:?}", a.mv), format!("{:?}", b.mv));
		assert_eq!((a.saved.to_bits(), a.hours.to_bits()), (b.saved.to_bits(), b.hours.to_bits()));
		assert_eq!(a.before, b.before);
		assert_eq!(a.lv, b.lv);
	}
}

/// The routes stage on the golden starts in `out`, hybrid search, checkpoints `ck`, written check `flow`.
fn stage_with(root: &Path, sim: &Path, out: &Path, ck: Option<&Resume>, flow: Option<&FlowCheck>) -> (Vec<(String, Vec<u8>)>, String) {
	let search = SearchOpts::forge(Mode::Hybrid, Cut::All, Some(1500), Some(3));
	let r = run(&RoutesIn { root, world_dir: sim, starts: starts(), out, threads: 4, search, deathskips: false, resume: ck, flow }).unwrap();
	(outputs(out, &r.files), serde_json::to_string(&r.rows).unwrap())
}

/// The routes stage on the golden starts in `out`, hybrid search, checkpoints `ck`.
fn stage(root: &Path, sim: &Path, out: &Path, ck: Option<&Resume>) -> (Vec<(String, Vec<u8>)>, String) {
	stage_with(root, sim, out, ck, None)
}

/// The kind of a ledger step (`{"t": "accept", "q": ...}`).
fn kind(t: &str) -> Option<u8> {
	match t {
		"accept" => Some(K_ACCEPT),
		"task" => Some(K_TASK),
		"turnin" => Some(K_TURNIN),
		_ => None,
	}
}

/// A written check that finds every hub batch of the routes written in `dir` walked past (the
/// steps of each `hub batch` row of each start's edit list), and nothing once it is undone.
fn batch_check(dir: &Path, names: &[String]) -> Result<Vec<Finding>, String> {
	let mut out = Vec::new();
	for name in names {
		let doc: Value = serde_json::from_slice(&std::fs::read(dir.join(format!("{name}.json"))).map_err(|e| e.to_string())?).map_err(|e| e.to_string())?;
		let rows = doc["edits"]["list"].as_array().cloned().unwrap_or_default();
		let undone: Vec<&Value> = rows.iter().filter(|r| r["kind"] == "hub batch undone").flat_map(|r| r["steps"].as_array().into_iter().flatten()).collect();
		for r in rows.iter().filter(|r| r["kind"] == "hub batch") {
			let lines: Vec<(u8, u32)> = r["steps"].as_array().into_iter().flatten().filter(|s| !undone.contains(s)).filter_map(|s| Some((kind(s["t"].as_str()?)?, s["q"].as_u64()? as u32))).collect();
			if !lines.is_empty() {
				out.push(Finding { start: name.clone(), rule: "walked-past".into(), text: format!("{name}: hub batch walked past"), lines, after: None, before: None });
			}
		}
	}
	Ok(out)
}

#[test]
fn a_finished_search_reused_under_the_written_check_undoes_its_hub_batches_as_the_search_did() {
	let t = tmp("resume-flow");
	let (root, sim) = inputs(&t);
	let check: &FlowCheck = &batch_check;
	let whole = stage_with(&root, &sim, &t.join("out-whole"), None, Some(check));
	let undone = whole.0.iter().filter(|(f, _)| f.ends_with(".json")).any(|(_, b)| String::from_utf8_lossy(b).contains("\"hub batch undone\""));
	assert!(undone, "the check undoes a hub batch (else this test reads nothing)");
	let dir = t.join("ck");
	let first = stage_with(&root, &sim, &t.join("out-1"), Some(&resume(&dir, "k")), Some(check));
	assert_eq!(first, whole, "checkpointing changes no route");
	// The next build (another writer, the same search): every search reused, the check run again.
	let r = resume(&dir, "k");
	let again = stage_with(&root, &sim, &t.join("out-2"), Some(&r), Some(check));
	let notes = r.notes();
	assert_eq!(notes.len(), 4, "{notes:?}");
	assert!(notes.iter().all(|n| n.contains("(search done")), "{notes:?}");
	assert_eq!(again, whole, "the reused search writes what the search itself does, its hub batches undone");
}

#[test]
fn a_start_finished_before_a_kill_is_reused_and_another_key_starts_afresh() {
	let t = tmp("resume-stage");
	let (root, sim) = inputs(&t);
	let whole = stage(&root, &sim, &t.join("out-whole"), None);
	let dir = t.join("ck");
	let first = stage(&root, &sim, &t.join("out-1"), Some(&resume(&dir, "k1")));
	assert_eq!(first, whole, "checkpointing changes no route");
	for u in ["Human", "own-Orc", "own-Troll", "shared-horde"] {
		assert!(dir.join(format!("{u}.{DONE}.json")).is_file(), "{u} done");
	}
	// Killed while the Horde searched: Human and Orc's own cut finished, Troll's own cut in its
	// descent, the shared tail not begun.
	for f in ["own-Troll.done.json", "shared-horde.done.json", "shared-horde.free.json", "shared-horde.descent.json"] {
		std::fs::remove_file(dir.join(f)).unwrap();
	}
	let r = resume(&dir, "k1");
	let again = stage(&root, &sim, &t.join("out-2"), Some(&r));
	let mut notes = r.notes();
	notes.sort();
	assert_eq!(notes.len(), 4, "{notes:?}");
	assert!(notes[0].starts_with("resuming Human from checkpoint (search done"), "{notes:?}");
	assert!(notes[1].starts_with("resuming own-Orc from checkpoint (search done"), "{notes:?}");
	assert!(notes[2].starts_with("resuming own-Troll edit descent from checkpoint ("), "{notes:?}");
	assert!(notes[3].starts_with("resuming own-Troll from checkpoint ("), "{notes:?}");
	assert_eq!(again, whole, "the resumed stage writes what the uninterrupted one does");
	// Another key (changed inputs or forge binary): the checkpoints are not read, and go.
	let r = resume(&dir, "k2");
	assert!(!dir.join("Human.done.json").exists(), "another key's checkpoints are cleared");
	let other = stage(&root, &sim, &t.join("out-3"), Some(&r));
	assert!(r.notes().is_empty(), "nothing resumed: {:?}", r.notes());
	assert_eq!(other, whole);
}
