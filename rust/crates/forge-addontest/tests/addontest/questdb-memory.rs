//! Polestar_QuestDB's memory budget (issue #693): what the quest database costs once loaded, under Lua 5.1 as
//! the client counts it (collectgarbage("count")), with Polestar.QuestDB reading it (addon/Polestar/Quests/
//! QuestDB.lua: the records stay LuaChunks text, decoded when read). Built by `forge data questdb` from
//! data/forever; skipped when that data is absent. Each figure fails the test when it grows past its
//! budget: lower a budget when a change lowers the figure, never raise one to make a change pass.
//!
//!   resident      after loading the files and two full collects
//!   peak          the heap grown while loading, with the collector stopped
//!   read          after reading every quest record once (QuestIds, QuestRecord) and two full collects:
//!                 what the reads leave behind (the id list; the decoded records are collected)

use forge_addontest::questdb::build_db;
use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon};

/// KiB (Lua 5.1, 64-bit), measured on data/forever on 2026-10-23 (5,408 quests, 5,174 NPCs, 977 objects,
/// 2,722 items): resident 1,202, peak 1,250, read 1,684 (the id list and the record cache's emptied hash).
/// The table files of schema 1 cost 6,789 resident and 12,692 at the peak (lua5.1, the same files).
const BUDGET: [(&str, f64); 3] = [("resident", 1250.0), ("peak", 1300.0), ("read", 1750.0)];

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
local n = 0
for _, q in ipairs(Q.QuestIds()) do if Q.QuestRecord(q) then n = n + 1 end end
local read = full() - base
emit({{ resident = resident, peak = peak, read = read, quests = n, loaded = Q.IsLoaded() }})"#,
		files = db.lua_files()
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
