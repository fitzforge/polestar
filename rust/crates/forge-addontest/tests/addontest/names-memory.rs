//! The names packs' memory budget (issue #693): what the committed Names.lua of a language folder Polestar_<locale> costs once loaded,
//! under Lua 5.1 as the client counts it (collectgarbage("count")), on a client of that language with
//! Polestar.Names reading it (addon/Polestar/Core/Names.lua: the names stay LuaChunks text, cut out when
//! asked). deDE and ruRU (the largest pack); the folder's Subzones.lua (the walking maps' subzone names,
//! #2244) alike. Each figure fails the test when it grows past its budget: lower a budget when a change
//! lowers the figure, never raise one to make a change pass.
//!
//!   resident      after loading the file and two full collects
//!   peak          the heap grown while loading it, with the collector stopped

use forge_addontest::run::{lua_string, root, toc_files};
use forge_addontest::{emitted, Addon, RunAddon};

/// KiB (Lua 5.1, 64-bit), measured here on the committed packs on 2026-10-24 (deDE 34,534 names, ruRU 38,223):
/// deDE resident 1,022, peak 1,041; ruRU resident 1,789, peak 1,818. The packs of Names.Add tables cost deDE
/// 3,199 resident and 9,385 at the peak, ruRU 4,364 and 10,867 (namesequal.lua, lua5.1).
const BUDGET: [(&str, f64, f64); 2] = [("deDE", 1065.0, 1085.0), ("ruRU", 1860.0, 1890.0)];

/// KiB, as BUDGET, measured here on the committed Subzones.lua on 2026-11-14 (built at 1.60.1.70888; deDE 2,665
/// areas, ruRU 3,073): deDE resident 65, peak 69; ruRU resident 109, peak 113. The budgets are those and about 5 %.
const SUBZONE_BUDGET: [(&str, f64, f64); 2] = [("deDE", 68.0, 73.0), ("ruRU", 115.0, 119.0)];
/// KiB a German client holds at login for its folder's Subzones.lua (the whole addon at login with the folder
/// and without that file), measured here on 2026-11-14: 15,946 with it, 15,881 without, +66; the budget is that
/// and about 5 %.
const SUBZONE_LOGIN: f64 = 70.0;

/// Loads the committed `file` of locale's language folder on a client of that language, as its TOC does, and
/// emits { resident, peak, probe } (`probe`: a Lua expression read after the load).
fn cost(locale: &str, file: &str, probe: &str) -> serde_json::Value {
	let path = root().join(format!("addon/Polestar_{locale}/{file}"));
	let script = format!(
		r#"
local N = Polestar.Names
local function full() collectgarbage("collect"); collectgarbage("collect"); return collectgarbage("count") end
local base = full()
collectgarbage("stop")
assert(loadfile({path}))("Polestar_{locale}", {{}})
local peak = collectgarbage("count") - base
collectgarbage("restart")
local resident = full() - base
emit({{ resident = resident, peak = peak, probe = {probe} or false }})"#,
		path = lua_string(&path.to_string_lossy())
	);
	emitted(&RunAddon {
		// The client's language without its interface file: the pack is what is measured.
		before: format!("function GetLocale() return {} end", lua_string(locale)),
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		script,
		..Default::default()
	})
	.remove(0)
}

fn over_budget(locale: &str, m: &serde_json::Value, resident_budget: f64, peak_budget: f64, over: &mut Vec<String>) {
	for (k, budget) in [("resident", resident_budget), ("peak", peak_budget)] {
		let v = m[k].as_f64().unwrap();
		eprintln!("{locale} {k}: {v:.0} KiB (budget {budget})");
		if v > budget {
			over.push(format!("{locale} {k} {v:.0} KiB > {budget}"));
		}
	}
}

#[test]
fn the_names_packs_stay_within_their_memory_budget_693() {
	let mut over = vec![];
	for (locale, resident_budget, peak_budget) in BUDGET {
		let m = cost(locale, "Names.lua", r#"N.Cached("npc", 6)"#);
		assert!(m["probe"].is_string(), "{locale}: the Kobold Vermin's name reads back");
		over_budget(locale, &m, resident_budget, peak_budget, &mut over);
	}
	assert!(over.is_empty(), "over budget: {}", over.join(", "));
}

#[test]
fn the_subzone_names_stay_within_their_memory_budget_2244() {
	let mut over = vec![];
	for (locale, resident_budget, peak_budget) in SUBZONE_BUDGET {
		let m = cost(locale, "Subzones.lua", r#"N.Get("subzone", 141154)"#);
		assert!(m["probe"].is_string(), "{locale}: the Apothecarium's name reads back");
		over_budget(locale, &m, resident_budget, peak_budget, &mut over);
	}
	assert!(over.is_empty(), "over budget: {}", over.join(", "));
}

/// A German client's whole addon at login, its language folder loaded as Core/Locale.lua loads it (the folder's
/// `files`, in TOC order): { kib (two full collects), loads (the folder's), apothecarium (Names.Get of a row) }.
fn german_login(files: &[std::path::PathBuf]) -> serde_json::Value {
	let list = files.iter().map(|f| lua_string(&f.to_string_lossy())).collect::<Vec<_>>().join(", ");
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: format!("function GetLocale() return \"deDE\" end\nstub.packs.Polestar_deDE = {{ {list} }}"),
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: r#"
stub.advance(1)
local function full() collectgarbage("collect"); collectgarbage("collect"); return collectgarbage("count") end
emit({ kib = full(), loads = stub.packLoads.Polestar_deDE or 0, apothecarium = Polestar.Names.Get("subzone", 141154) or false })"#
			.into(),
		..Default::default()
	})
	.remove(0)
}

// #2244: the subzone names load with the client's own language folder only (an English client loads none, the
// folder no other language's), at login with it: a load-on-demand part of their own would take an addon per
// language. Their cost at login on a German client, held to SUBZONE_LOGIN.
#[test]
fn a_german_client_s_subzone_names_cost_at_most_their_budget_at_login_2244() {
	let all = toc_files("Polestar_deDE").unwrap();
	assert!(all.iter().any(|f| f.ends_with("Subzones.lua")), "the folder's TOC lists Subzones.lua");
	let without: Vec<std::path::PathBuf> = all.iter().filter(|f| !f.ends_with("Subzones.lua")).cloned().collect();
	let (with, none) = (german_login(&all), german_login(&without));
	assert_eq!((&with["loads"], &none["loads"]), (&serde_json::json!(1), &serde_json::json!(1)), "the folder loads once at login");
	assert_eq!(with["apothecarium"], "Das Apothekarium");
	assert_eq!(none["apothecarium"], false);
	let (w, n) = (with["kib"].as_f64().unwrap(), none["kib"].as_f64().unwrap());
	eprintln!("deDE at login: {w:.0} KiB with Subzones.lua, {n:.0} without: {:+.0} (budget {SUBZONE_LOGIN})", w - n);
	assert!(w - n <= SUBZONE_LOGIN, "a German client's subzone names at login: {:.0} KiB, over {SUBZONE_LOGIN}", w - n);
}
