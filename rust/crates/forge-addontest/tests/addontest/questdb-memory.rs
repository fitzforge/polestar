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
// Raised for 0.3.8 (Fitz, 2026-11-12: "raise memory budgets, it's fine; we can always compress and review
// later"): QuestieDB 1.0.16, EG Link and the recordings bring +658 quests (Riverglades, Mount Hyjal,
// Shen'dralas); measured resident 1334, peak 1385, read 1474 KiB; about 5 % headroom on each.
// `read` raised by the string table's one doubling (256 KiB, the module comment) for 0.4.3 (Main, 2026-11-23):
// the settings set (#3730) adds enough interface strings that the reads' strings cross a doubling even with
// the id list built first: next read 1,523, #3730 1,778 on the 0.4.3 data (resident 1,382 and peak 1,434,
// within theirs). The table is the whole addon's, not the quest database's: since #3762 the test pre-grows it
// (BALLAST), so no figure holds a doubling.
// Raised for the 0.4.3 data build on QuestieDB 1.1.5 (Main, 2026-11-24, reported to Fitz): +163 quests; measured
// resident 1,422, peak 1,473, read 1,813 KiB (1,382 / 1,433 / 1,778 on the data before); about 1 % headroom on each.
// `read` back down to the pack's own figure with the string table pre-grown (#3762, 2026-11-25): measured 1,555
// KiB on the 0.4.3 data (resident 1,420 and peak 1,471, as before); 1,600, about 3 % headroom.
const BUDGET: [(&str, f64); 3] = [("resident", 1440.0), ("peak", 1490.0), ("read", 1600.0)];

/// Records read between full collects while `read` is measured.
const READ_BATCH: usize = 256;

/// The string table pre-grown before `base` (#3762), so no figure holds one of its doublings (the module
/// comment): strings are interned one by one, with the collector stopped, until the memory count jumps by more
/// than a string's worth, the table's doubling to twice the slots it had (8 bytes a slot). The interned strings
/// then fill half the new table and stay alive (`ballast`) through the measurement: a collect never halves the
/// table (that needs under a quarter live), and the pack's strings have half the slots to grow into before
/// the next doubling. The ballast's own array grows when its count passes a power of two; those steps are
/// passed over. `slots`: the table's size found, for the log.
const BALLAST: &str = r#"
local ballast, slots = {}, nil
do
	full()
	collectgarbage("stop")
	local last, cap, i = collectgarbage("count"), 1, 0
	while not slots and i < 4000000 do
		i = i + 1
		ballast[i] = "polestar ballast " .. i
		local now = collectgarbage("count")
		if i - 1 == cap then
			cap = cap * 2
		elseif i > 1 and now - last > 32 then
			-- The jump is the old slots' 8 bytes each, and the string's own few: the power of two under it.
			local old = 1
			while old * 2 * 8 <= (now - last) * 1024 do old = old * 2 end
			slots = old * 2
		end
		last = now
	end
	collectgarbage("restart")
	assert(slots, "the string table never doubled")
end"#;

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
{ballast}
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
emit({{ resident = resident, peak = peak, read = read, quests = n, loaded = Q.IsLoaded(), slots = slots, kept = #ballast }})"#,
		files = db.lua_files(),
		batch = READ_BATCH,
		ballast = BALLAST
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua", "stub_quests.lua"], addons: vec![Addon::name("Polestar")], script, ..Default::default() });
	let m = &out[0];
	assert_eq!(m["quests"], db.out.db.quests.len(), "every quest reads back");
	assert_eq!(m["loaded"], true);
	eprintln!("string table: {} slots, {} ballast strings", m["slots"], m["kept"]);
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
