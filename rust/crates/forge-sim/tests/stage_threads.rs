//! Metamorphic check of the parallel routes stage (RouteArchitecture rec. 6): the same inputs and seed
//! give the same routes whatever the thread count. `forge build`'s routes stage runs the factions, each
//! start's own cut and every search's members in one rayon pool of `--threads`; the routes must not
//! depend on how that pool schedules them. Run on the golden slice worlds (the Horde as a shared route of
//! two starts, Orc and Troll on v1's Orc chain; the Alliance as Human's own cut), an empty walk table and
//! an empty knowledge base, at 4 and at 12 threads: every file byte-identical but the search's wall
//! time (`search.seconds` and the per-second rates).

mod common;

use common::stage::{inputs, outputs, starts};
use forge_sim::search::edits::Cut;
use forge_sim::search::{Mode, SearchOpts};
use forge_sim::stage::{run, RoutesIn};
use std::path::{Path, PathBuf};

/// The routes stage at 4 and at 12 threads under `search`, in `<tmp>/<name>`: (files, rows) of each.
fn at_4_and_12(name: &str, search: &SearchOpts) -> (PathBuf, Vec<(Vec<(String, Vec<u8>)>, String)>) {
	let tmp = Path::new(env!("CARGO_TARGET_TMPDIR")).join(name);
	let _ = std::fs::remove_dir_all(&tmp);
	let (root, sim) = inputs(&tmp);
	let mut runs = Vec::new();
	for threads in [4, 12] {
		let out = tmp.join(format!("out-{threads}"));
		let r = run(&RoutesIn { root: &root, world_dir: &sim, starts: starts(), out: &out, threads, search: search.clone(), deathskips: false, resume: None, flow: None }).unwrap();
		runs.push((outputs(&out, &r.files), serde_json::to_string(&r.rows).unwrap()));
	}
	(tmp, runs)
}

fn same(runs: &[(Vec<(String, Vec<u8>)>, String)]) {
	let ((a, ra), (b, rb)) = (&runs[0], &runs[1]);
	assert_eq!(a.iter().map(|x| &x.0).collect::<Vec<_>>(), b.iter().map(|x| &x.0).collect::<Vec<_>>(), "the same files");
	assert!(a.len() >= 3 * 7, "every start's files: {}", a.len());
	let differ: Vec<&String> = a.iter().zip(b).filter(|(x, y)| x.1 != y.1).map(|(x, _)| &x.0).collect();
	assert!(differ.is_empty(), "differ at 4 vs 12 threads: {differ:?}");
	assert_eq!(ra, rb, "the summary rows");
}

#[test]
fn routes_stage_is_the_same_at_4_and_12_threads() {
	let (tmp, runs) = at_4_and_12("stage-threads", &SearchOpts::forge(Mode::Edits, Cut::All, None, None));
	// --cut all (forge build's default): Human's own cut keeps every edit its descent made, each saving at
	// least EDIT_MIN_GAIN (the pickups and hub pickups after them are other passes); the knee is still
	// reported.
	let human: serde_json::Value = serde_json::from_slice(&std::fs::read(tmp.join("out-4/Human.json")).unwrap()).unwrap();
	let e = &human["edits"];
	let made = e["curve"].as_array().unwrap().len();
	assert_eq!(human["cut"], "all");
	assert_eq!(e["budget"].as_u64(), Some(made as u64));
	assert!(e["knee"].as_u64().is_some_and(|k| k as usize <= made));
	let passes = ["pickup", "stay on continent", "hub pickup", "bag tie", "camp gather", "hub batch", "hub sweep", "on the way", "hub loop", "train at the hub", "defer hard work", "grind top-up"];
	let descent: Vec<&serde_json::Value> = e["list"].as_array().unwrap().iter().filter(|x| !passes.iter().any(|k| x["kind"] == *k)).collect();
	assert_eq!(descent.len(), made);
	assert!(made > 0 && descent.iter().all(|x| x["kept"] == true && x["savedMin"].as_f64().unwrap() >= forge_sim::search::edits::EDIT_MIN_GAIN / 60.0 - 0.005), "{e}");
	// No start's route plans a hearth while the stone cools down (c11: the shared tail's later
	// passes left Tauren and NightElf one each).
	for s in ["Orc", "Troll", "Human"] {
		let r: serde_json::Value = serde_json::from_slice(&std::fs::read(tmp.join(format!("out-4/{s}.json"))).unwrap()).unwrap();
		assert_eq!(r["improved"]["planHearthsOnCooldown"], 0, "{s}");
	}
	same(&runs);
}

#[test]
fn free_and_hybrid_routes_are_the_same_at_4_and_12_threads_with_a_free_edit_ledger() {
	// --search free / hybrid: the members' rounds are counted in tries, not time, so the threads do
	// not change the routes; the edit list is the free search's diff against the seed (inserts,
	// drops, `free move`s), then (hybrid) the descent's edits from its order.
	for mode in [Mode::Free, Mode::Hybrid] {
		let (tmp, runs) = at_4_and_12(&format!("stage-threads-{}", mode.name()), &SearchOpts::forge(mode, Cut::All, Some(3000), Some(3)));
		same(&runs);
		let human: serde_json::Value = serde_json::from_slice(&std::fs::read(tmp.join("out-4/Human.json")).unwrap()).unwrap();
		assert_eq!(human["searchMode"], mode.name());
		let list = human["edits"]["list"].as_array().unwrap();
		let free = list.iter().filter(|x| matches!(x["kind"].as_str(), Some("free move" | "insert" | "drop")) && x["savedMin"].is_null()).count();
		assert!(free > 0, "{mode:?}: the free search's moves are listed: {}", human["edits"]);
		assert!(human["edits"]["free"]["endHours"].as_f64().unwrap() < human["edits"]["free"]["startHours"].as_f64().unwrap());
		if mode == Mode::Hybrid {
			assert!(human["edits"]["curve"].is_array(), "the descent's curve after the free search");
		}
		let ledger = std::fs::read_to_string(tmp.join("out-4/Human-ledger.md")).unwrap();
		assert!(ledger.contains("free search"), "the edit ledger names them");
	}
}
