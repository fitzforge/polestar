//! Polestar_QuestDB's memory budget (issue #693): what the quest database costs once loaded, under Lua 5.1 as
//! the client counts it (collectgarbage("count")), with Polestar.QuestDB reading it (addon/Polestar/Quests/
//! QuestDB.lua: the records stay LuaChunks text, decoded when read). Built by `forge data questdb` from
//! data/forever; skipped when that data is absent. Each figure fails the test when it grows past its
//! budget: the figure measured at the release's code freeze plus 3 %, moved only then (docs/CI.md, "Memory budgets").
//!
//!   resident      after loading the files and two full collects
//!   peak          the heap grown while loading, with the collector stopped
//!   read          after reading every quest record once (QuestIds, QuestRecord) and two full collects:
//!                 what the reads leave behind (the id list; the decoded records are collected)
//!
//! The reads run with the collector stopped and a full collect every READ_BATCH records, so the store's weak
//! record cache never holds more than a batch. Left to the collector's own pace, `read` measured how many
//! records the cache had piled up between its cycles (its emptied hash keeps that size), and that pace
//! follows the whole addon's heap: a few lines more in Nav/Travel.lua moved `read` from 1,555 to 1,811 KiB
//! with the quest database unchanged.
//!
//! The id list is built and its garbage collected before the collector stops (the list stays: Polestar.QuestDB
//! keeps it). Lua 5.1's string table doubles its slots (8 bytes each) once it holds as many strings as slots,
//! dead ones counted, and halves them only when fewer than a quarter are live; the addon's strings sit 2,000 to
//! 3,000 below a doubling. Built with the collector stopped, the id list's throwaway strings crossed it and
//! `read` kept 32,768 slots more, 256 KiB exactly (2026-11-20: 1,779 KiB, and 1,770 with 0.4.1.1's own QuestDB;
//! 1,523 and 1,514 with the list built first). The 1,555 -> 1,811 above was the same 256 KiB.

use forge_addontest::questdb::build_db;
use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon};

/// KiB (Lua 5.1, 64-bit), measured on data/forever on 2026-10-23 (5,408 quests, 5,174 NPCs, 977 objects,
/// 2,722 items): resident 1,202, peak 1,250; read 1,333 on 2026-11-06 with the reads batched (the id list and
/// the record cache's emptied hash; 1,555 to 1,811 before, by the collector's pace).
/// The table files of schema 1 cost 6,789 resident and 12,692 at the peak (lua5.1, the same files).
/// Measured on next f5bd74406e with the reference data built 2026-11-24 (2026-11-26, #4143; three runs reading
/// the same): resident 1,420, peak 1,471, read 1,810. Each budget is that figure plus 3 % (docs/CI.md, "Memory
/// budgets").
/// `read` carries one doubling of the string table (256 KiB, the module comment) that the pack alone does not
/// cause: the table is the whole addon's (#3762).
const BUDGET: [(&str, f64); 3] = [("resident", 1470.0), ("peak", 1520.0), ("read", 1870.0)];

/// Records read between full collects while `read` is measured.
const READ_BATCH: usize = 256;

#[test]
fn the_quest_database_stays_within_its_memory_budget_693() {
	let data = root().join("data/forever");
	if !data.join("quests.json").exists() {
		eprintln!("skipped: no data/forever/quests.json");
		return;
	}
	let db = build_db(&data);
	let script = format!(
		r#"
local Q = Polestar.QuestDB
local files = {files}
local function full() collectgarbage("collect"); collectgarbage("collect"); return collectgarbage("count") end
local base = full()
collectgarbage("stop")
for _, f in ipairs(files) do assert(loadfile(f))("Polestar_QuestDB", {{}}) end
local peak = collectgarbage("count") - base
collectgarbage("restart")
local resident = full() - base
local ids = Q.QuestIds()
full()
local n = 0
collectgarbage("stop")
for i, q in ipairs(ids) do
	if Q.QuestRecord(q) then n = n + 1 end
	if i % {batch} == 0 then collectgarbage("collect") end
end
collectgarbage("restart")
local read = full() - base
emit({{ resident = resident, peak = peak, read = read, quests = n, loaded = Q.IsLoaded() }})"#,
		files = db.lua_files(),
		batch = READ_BATCH
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua", "stub_quests.lua"], addons: vec![Addon::name("Polestar")], script, ..Default::default() });
	let m = &out[0];
	assert_eq!(m["quests"], db.out.db.quests.len(), "every quest reads back");
	assert_eq!(m["loaded"], true);
	let mut over = vec![];
	for (k, budget) in BUDGET {
		let v = m[k].as_f64().unwrap();
		eprintln!("{k}: {v:.0} KiB (budget {budget})");
		if v > budget {
			over.push(format!("{k} {v:.0} KiB > {budget}"));
		}
	}
	assert!(over.is_empty(), "over budget: {}", over.join(", "));
}
