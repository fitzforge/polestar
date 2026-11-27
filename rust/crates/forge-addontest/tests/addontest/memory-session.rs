//! Memory after real use, not only at login (0.4.0: Polestar showed 93 MB in the game after twenty minutes of
//! clicking round, against about 13 MB at login; garbage, not a leak). A scripted session over the whole addon
//! on the stubbed world, a 30-step guide and the Dungeons fixture's Codex (tests/fixtures/codex/dungeons.json),
//! the same round three times: the settings (every page and tab, the transparency slider dragged through 30
//! values, every look and scheme, closed), the guide menu (its views, categories, each guide's details, a
//! search), the Dungeons hub (every dungeon and each of its tabs) and 50 step changes (25 on, 25 back, so each
//! round starts where the last began). Measured as the client counts it (Lua 5.1 collectgarbage("count")):
//!
//!   kept      the heap after a round and two full collects: what a round leaves held
//!   churn     what a step of the round allocated, collected or not, the addon's share (tests/lua/stub_alloc.lua
//!             takes out what this stub allocates for its frames, which the client keeps in C)
//!
//! Each figure fails the test when it grows past its budget. ONE_TIME is the figure measured at the release's
//! code freeze plus 3 %, moved only then (docs/CI.md, "Memory budgets"); the churn budgets keep their own margin
//! (what one round allocates), and KEPT_GROWTH is a fixed limit, not a figure.
//!
//!   - a round repeated keeps no more (the third round over the second, KEPT_GROWTH: a leak per use);
//!   - what the first two rounds build once (their windows and pages, the looks' art) stays under ONE_TIME;
//!   - the third round's churn: the Dungeons hub under HUB_KIB, the 50 steps under STEPS_KIB, the guide menu
//!     under MENU_KIB. The settings' own churn per change is settings-perf.rs's.
//!
//! The churn budgets are the figures of 2026-11-15 (fix/memory-040: the hub's page plans worked out once per page, the
//! planner's arrays kept from one plan to the next) and about 10 %, in KiB: kept 15,118 at login, 111,653 after
//! the second round, 111,703 after the third (+51; the frames and textures the settings' pages and the looks build
//! are Lua tables in this stub, so "built once" reads far above the client's own figure); the third round's churn:
//! hub 616 (3 dungeons), 50 steps 25,367 (14 MB of it Compat's map-to-world vectors, one pair per position read),
//! guide menu 240. ONE_TIME: two rounds built 72,110 over login on next f5bd74406e (2026-11-26, #4143; three runs
//! reading the same), plus 3 %.

use crate::ui_dungeons::pack;
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;
use std::sync::LazyLock;

const KEPT_GROWTH: f64 = 1024.0;
const ONE_TIME: f64 = 75_000.0;
const HUB_KIB: f64 = 680.0;
const STEPS_KIB: f64 = 28_000.0;
const MENU_KIB: f64 = 265.0;

const SCRIPT: &str = r#"
local A, gc = stub.alloc, collectgarbage
local function full() gc("collect"); gc("collect"); return gc("count") end
stub.advance(1)
local w = stub.world
w.faction, w.race, w.raceName = "Alliance", "Human", "Human"
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
local steps = {}
for k = 1, 30 do
	steps[k] = { title = "Step " .. k, goals = {
		{ t = "goto", map = 1429, x = 40 + (k % 7) * 2, y = 35 + (k % 5) * 3, text = "Go there" },
		{ t = "kill", quest = 7, obj = 1, target = "Kobold Vermin", npc = 6, map = 1429, x = 47, y = 35 },
	} }
end
assert(Polestar.RegisterGuide({ id = "test/session", pack = "test", title = "Session", minLevel = 1, maxLevel = 60, steps = steps }))
local UI, E, O = Polestar.UI, Polestar.Engine, nil
E.SetGuide("test/session")
stub.fire("QUEST_LOG_UPDATE")
stub.advance(3)
if PolestarWelcome and PolestarWelcome:IsShown() then PolestarWelcome:Hide() end
local login = full()

local function settings()
	Polestar.Fire("SHOW_OPTIONS"); stub.advance(0.2)
	O = UI.Options
	for _, p in ipairs(O.Pages()) do
		for _, t in ipairs(#p.tabs > 0 and p.tabs or { "" }) do O.Select(p.key, t); stub.advance(0.1) end
	end
end
local function drag()
	local c = O.ControlByKey("ui.bgOpacity")
	O.Select(c.page.key, c.tab); stub.advance(0.1)
	local s = O.Controls(c.page.key, c.tab)["ui.bgOpacity"].Slider
	stub.RunScript(s, "OnMouseDown", "LeftButton")
	for k = 1, 30 do
		local v = (k % 15) / 15
		s.value = v
		s:GetScript("OnValueChanged")(s, v, true)
		stub.advance(0.016)
	end
	stub.RunScript(s, "OnMouseUp", "LeftButton")
	stub.advance(0.5)
end
local function choices(key)
	local c = O.ControlByKey(key)
	local list = c.choices
	if type(list) == "function" then list = list() end
	return c, list or {}
end
local function looks()
	for _, key in ipairs({ "ui.skin", "ui.scheme" }) do
		local c, list = choices(key)
		O.Select(c.page.key, c.tab); stub.advance(0.1)
		local was = Polestar.Get(key)
		for _, ch in ipairs(list) do Polestar.Set(key, ch.value); stub.advance(0.1) end
		Polestar.Set(key, was); stub.advance(0.1)
	end
end
local function closed()
	if PolestarOptions and PolestarOptions:IsShown() then PolestarOptions:Hide() end
	stub.advance(0.2)
end
local function menu()
	local P = UI.Picker
	Polestar.Fire("SHOW_PICKER"); stub.advance(0.2)
	P.ShowSection("Guides"); stub.advance(0.1)
	for _, v in ipairs({ "home", "browse" }) do P.SetView(v); stub.advance(0.1) end
	local cats = { "All" }
	for _, h in ipairs(Polestar.Guides.List()) do
		local seen = false
		for _, x in ipairs(cats) do if x == h.category then seen = true end end
		if h.category and not seen then cats[#cats + 1] = h.category end
	end
	for _, c in ipairs(cats) do P.SetCategory(c); stub.advance(0.05) end
	for _, h in ipairs(Polestar.Guides.List()) do P.Select(h.id); stub.advance(0.05) end
	for _, q in ipairs({ "elw", "kobold", "" }) do P.SetQuery(q); stub.advance(0.05) end
	PolestarPicker:Hide(); stub.advance(0.2)
end
local dungeons = 0
local function hub()
	local DS, D = UI.DungeonsSection, Polestar.Dungeons
	DS.Show(nil); stub.advance(0.2)
	local list = D.Load() and D.List() or {}
	dungeons = #list
	for _, d in ipairs(list) do
		DS.Open(d.key or d); stub.advance(0.05)
		for _, t in ipairs({ "attune", "bosses", "map", "quests" }) do DS.SetTab(t); stub.advance(0.02) end
	end
	DS.Home(); stub.advance(0.05)
	if PolestarPicker then PolestarPicker:Hide() end
	stub.advance(0.2)
end
local function stepChanges()
	for k = 1, 50 do
		if k <= 25 then E.Next() else E.Prev() end
		stub.advance(0.1)
	end
end

local ROUND = { { "settings", settings }, { "drag", drag }, { "looks", looks }, { "closed", closed }, { "menu", menu }, { "hub", hub }, { "steps", stepChanges } }
local rounds = {}
for r = 1, 3 do
	local row = {}
	for _, s in ipairs(ROUND) do
		local _, addon = A.measure(s[2])
		row[s[1]] = addon
	end
	row.kept = full()
	rounds[r] = row
end
emit({ login = login, rounds = rounds, dungeons = dungeons, step = E.GetStepIndex() })
"#;

static SESSION: LazyLock<Value> = LazyLock::new(|| {
	let codex = pack();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_alloc.lua"],
		before: codex.stub_lua.clone(),
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: SCRIPT.into(),
		..Default::default()
	})
	.remove(0);
	println!("memory session: {out}");
	out
});

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap_or(f64::NAN)
}

#[test]
fn a_session_round_repeated_keeps_no_more_and_what_it_builds_once_stays_within_budget() {
	let out = &*SESSION;
	let r = &out["rounds"];
	assert!(num(&out["dungeons"]) >= 2.0, "the hub browsed the fixture's dungeons: {out}");
	assert_eq!(out["step"], 1, "the step changes end where they began: {out}");
	let growth = num(&r[2]["kept"]) - num(&r[1]["kept"]);
	let once = num(&r[1]["kept"]) - num(&out["login"]);
	eprintln!("memory session: two rounds built {once:.0} KiB over login (budget {ONE_TIME}); the third kept {growth:.0} over the second (budget {KEPT_GROWTH})");
	assert!(growth <= KEPT_GROWTH, "the third round kept {growth:.0} KiB over the second (budget {KEPT_GROWTH}): {out}");
	assert!(once <= ONE_TIME, "two rounds built {once:.0} KiB over login (budget {ONE_TIME}): {out}");
}

#[test]
fn the_dungeons_hub_the_step_changes_and_the_guide_menu_make_garbage_within_budget() {
	let out = &*SESSION;
	let r = &out["rounds"][2];
	for (key, budget) in [("hub", HUB_KIB), ("steps", STEPS_KIB), ("menu", MENU_KIB)] {
		let kib = num(&r[key]);
		assert!(kib <= budget, "{key}: {kib:.0} KiB of garbage a round (budget {budget}): {out}");
	}
}

/// /polestar memory: each loaded Polestar addon's memory as the client counts it, before and after a full
/// collect, and the whole: what was garbage.
#[test]
fn polestar_memory_prints_each_addon_before_and_after_a_full_collect_and_the_garbage() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: r#"
			local reads = 0
			stub.addonMemory.Polestar = function() reads = reads + 1 return reads == 1 and 30720 or 12288 end
			stub.messages = {}
			SlashCmdList.POLESTAR("memory")
			emit(stub.messages)"#
			.into(),
		..Default::default()
	})
	.remove(0);
	let lines: Vec<&str> = out.as_array().unwrap().iter().filter_map(Value::as_str).collect();
	assert!(lines.iter().any(|l| l.contains("Polestar  30.00 MB -> 12.00 MB")), "{lines:?}");
	assert!(lines.iter().any(|l| l.contains("All of Polestar: 30.00 MB -> 12.00 MB (18.00 MB was garbage)")), "{lines:?}");
}
