//! The names packs' memory budget (issue #693): what the committed Names.lua of a language folder Polestar_<locale> costs once loaded,
//! under Lua 5.1 as the client counts it (collectgarbage("count")), on a client of that language with
//! Polestar.Names reading it (addon/Polestar/Core/Names.lua: the names stay LuaChunks text, cut out when
//! asked). deDE and ruRU (the largest pack). Each figure fails the test when it grows past its budget:
//! lower a budget when a change lowers the figure, never raise one to make a change pass.
//!
//!   resident      after loading Names.lua and two full collects
//!   peak          the heap grown while loading it, with the collector stopped

use forge_addontest::run::{lua_string, root};
use forge_addontest::{emitted, Addon, RunAddon};

/// KiB (Lua 5.1, 64-bit), measured here on the committed packs on 2026-10-24 (deDE 34,534 names, ruRU 38,223):
/// deDE resident 1,022, peak 1,041; ruRU resident 1,789, peak 1,818. The packs of Names.Add tables cost deDE
/// 3,199 resident and 9,385 at the peak, ruRU 4,364 and 10,867 (namesequal.lua, lua5.1).
const BUDGET: [(&str, f64, f64); 2] = [("deDE", 1065.0, 1085.0), ("ruRU", 1860.0, 1890.0)];

const NO_INTERFACE_FILE: &str = r#"
do
	local load = loadfile
	function loadfile(file)
		if file:match("[/\\]Locales[/\\]%a%a%u%u%.lua$") then return function() end end
		return load(file)
	end
end"#;

#[test]
fn the_names_packs_stay_within_their_memory_budget_693() {
	let mut over = vec![];
	for (locale, resident_budget, peak_budget) in BUDGET {
		let file = root().join(format!("addon/Polestar_{locale}/Names.lua"));
		let script = format!(
			r#"
local N = Polestar.Names
local function full() collectgarbage("collect"); collectgarbage("collect"); return collectgarbage("count") end
local base = full()
collectgarbage("stop")
assert(loadfile({file}))("Polestar_{locale}", {{}})
local peak = collectgarbage("count") - base
collectgarbage("restart")
local resident = full() - base
emit({{ resident = resident, peak = peak, npc = N.Cached("npc", 6) or false }})"#,
			file = lua_string(&file.to_string_lossy())
		);
		let out = emitted(&RunAddon {
			// The client's language without its interface file: the pack is what is measured.
			before: format!("function GetLocale() return {} end\n{NO_INTERFACE_FILE}", lua_string(locale)),
			stubs: vec!["stub_world.lua"],
			addons: vec![Addon::name("Polestar")],
			script,
			..Default::default()
		});
		let m = &out[0];
		assert!(m["npc"].is_string(), "{locale}: the Kobold Vermin's name reads back");
		for (k, budget) in [("resident", resident_budget), ("peak", peak_budget)] {
			let v = m[k].as_f64().unwrap();
			eprintln!("{locale} {k}: {v:.0} KiB (budget {budget})");
			if v > budget {
				over.push(format!("{locale} {k} {v:.0} KiB > {budget}"));
			}
		}
	}
	assert!(over.is_empty(), "over budget: {}", over.join(", "));
}
