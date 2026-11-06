//! The dungeon heads-up's memory (#836): what it costs under Lua 5.1 as the client counts it
//! (collectgarbage("count")), on the whole Polestar addon with the shipped table (Dungeons/OpensData.lua) and,
//! when it is built here, the Codex pack (addon/Polestar_Codex) and the quest database (addon/Polestar_QuestDB).
//!
//!   table     the table, resident after two full collects
//!   levelup   the heap after a level-up that opens Blackfathom Deeps to a level 22 Tauren, against before it
//!   codex     (with the packs only) what #869's heads-up loaded at that level-up instead: the Codex and the
//!             quest database (when the quest tracker hadn't), with each dungeon in range's pick-up plan
//!
//! The level-up must not load either pack (the quest database may already be loaded by the quest tracker). A figure past its budget fails the test: lower a budget when a change
//! lowers the figure, never raise one to make a change pass.

use forge_addontest::run::{addons_dir, join};
use forge_addontest::{emitted, Addon, RunAddon};

/// KiB (Lua 5.1, 64-bit), measured on 2026-11-06 with the table from the Codex built that day (23 dungeons, 19.7
/// KiB of text) and that Codex: table 25.8, levelup 1.4 (codex: 7,057.4, what #869's heads-up loaded at that
/// level-up with the quest database already loaded).
const BUDGET: [(&str, f64); 2] = [("table", 32.0), ("levelup", 8.0)];

/// LoadAddOn for a pack folder beside Polestar: its TOC's files, run in order (as the client loads them).
fn pack_loader(name: &str) -> String {
	let dir = addons_dir().join(name);
	let Ok(text) = std::fs::read_to_string(dir.join(format!("{name}.toc"))) else { return String::new() };
	let files: Vec<String> = text.lines().map(|l| l.trim()).filter(|l| !l.is_empty() && !l.starts_with('#')).map(|f| serde_json::to_string(&join(&dir, f).to_string_lossy()).unwrap()).collect();
	format!(
		"do
  local __files, __load = {{ {} }}, C_AddOns.LoadAddOn
  function C_AddOns.LoadAddOn(name)
    if name ~= \"{name}\" then return __load(name) end
    if not stub.addonsLoaded[name] then
      for _, f in ipairs(__files) do assert(loadfile(f))(name, {{}}) end
      stub.addonsLoaded[name] = true
    end
    return true, nil
  end
end
",
		files.join(", ")
	)
}

#[test]
fn a_level_up_heads_up_never_loads_the_codex_and_its_table_stays_within_budget() {
	let packs = addons_dir().join("Polestar_Codex/Polestar_Codex.toc").exists() && addons_dir().join("Polestar_QuestDB/Polestar_QuestDB.toc").exists();
	let before = if packs { format!("{}{}", pack_loader("Polestar_Codex"), pack_loader("Polestar_QuestDB")) } else { String::new() };
	let opens = serde_json::to_string(&addons_dir().join("Polestar/Dungeons/OpensData.lua").to_string_lossy()).unwrap();
	let script = format!(
		r#"
local w = stub.world
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Tauren", "Tauren", "DRUID", "Druid", "Horde", 21
stub.login()
stub.advance(6)
local D, X, Q = Polestar.Dungeons, Polestar.Codex, Polestar.QuestDB
local function full() collectgarbage("collect"); collectgarbage("collect"); return collectgarbage("count") end
local function loaded() return {{ codex = X.IsLoaded(), questdb = (Q and Q.IsLoaded and Q.IsLoaded()) or false }} end
-- The table: dropped, then read again as the addon reads it.
local at = D.Opens.BuiltAt()
D.RegisterOpens(nil, {{}})
local b0 = full()
assert(loadfile({opens}))("Polestar", Polestar)
local tableKiB = full() - b0
local login = full()
local atLogin = loaded()
-- A level-up that opens Blackfathom Deeps (22-28).
w.level = 22
local c = Polestar.UI.DungeonToast.Candidates(22, "levelup")[1]
stub.fire("PLAYER_LEVEL_UP", 22)
stub.advance(2)
local levelup = full() - login
local afterLevelup = loaded()
local out = {{ table = tableKiB, levelup = levelup, login = login, atLogin = atLogin, afterLevelup = afterLevelup,
	builtAt = at or false, due = c and {{ c.key, c.take }} or false }}
if {packs} then
	-- What #869's heads-up did at that level-up: the Codex, the quest database, each dungeon in range's plan.
	local b1 = full()
	X.Load()
	if Q and Q.Load then Q.Load() end
	for _, d in ipairs(D.List()) do
		if d.kind == "dungeon" and d.minLevel and d.minLevel <= 22 and (not d.maxLevel or d.maxLevel >= 22) then D.PickupPlan(d.key) end
	end
	out.codex = full() - b1
	out.after = loaded()
	local plan = D.PickupPlan("blackfathom-deeps")
	out.pickup = plan and #plan.take or false
end
emit(out)"#,
		packs = packs
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua", "stub_quests.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() });
	let m = &out[0];
	for k in ["table", "levelup", "login", "codex"] {
		if let Some(v) = m[k].as_f64() {
			eprintln!("{k}: {v:.1} KiB");
		}
	}
	eprintln!("table from the Codex built {}; due at 22: {}; the pick-up guide's count: {}", m["builtAt"], m["due"], m["pickup"]);
	// The quest database loads at login on its own when a quest feature wants it (Quests/Tracker.lua).
	assert_eq!(m["atLogin"]["codex"], false, "logging in doesn't load the Codex");
	assert_eq!(m["afterLevelup"], m["atLogin"], "the level-up's heads-up loads neither pack");
	assert!(m["due"].is_array(), "Blackfathom Deeps is due at 22 ({})", m["due"]);
	if packs {
		assert_eq!(m["due"][1], m["pickup"], "the card counts what the pick-up guide picks up");
	}
	let mut over = vec![];
	for (k, budget) in BUDGET {
		let v = m[k].as_f64().unwrap_or(f64::MAX);
		if v > budget {
			over.push(format!("{k} {v:.0} KiB > {budget}"));
		}
	}
	assert!(over.is_empty(), "over budget: {}", over.join(", "));
}
