//! Polestar_Nav's memory budget (issue #693): what loading the walking maps costs, and what searching them
//! costs, under Lua 5.1 as the client counts it (collectgarbage("count")). The client's decoder
//! (C_EncodingUtil) is tests/lua/stub_encoding.lua here, a decoder in Lua: its own scratch is counted out,
//! so the figures are Polestar_Nav's own (the client decodes in C). Each figure fails the test when it grows
//! past its budget: lower a budget when a change lowers the figure, never raise one to make a change pass.
//!
//!   load resident   after loading the maps and two full collects
//!   load peak       the heap grown while loading, with the collector stopped
//!   live            the most the heap holds, after a full collect, when a search answers (decoded clusters,
//!                   graph and search trees)
//!   allocated       everything the searches allocate, collected or not: the garbage the client's collector
//!                   has to catch up with
//!   at rest         after the searches, once the engine went idle
//!
//! The searches: five walks (Northshire, Goldshire to the Trade District, Loch Modan, Silverpine, Darkshore),
//! Horde, then one batch as Walk.Measure asks when a waypoint is set: from the Trade District to 16 places
//! within 3000 yards.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, Addon, RunAddon};

/// KiB (Lua 5.1, 64-bit), measured on the shipped maps on 2026-10-23 (graph edges read where they lie in the
/// graph string): load 35,137 / 37,695; live 85,961; allocated 160,949; at rest 40,484. On maps format 3
/// (2026-10-24, grid 1.60.1.70532, the named area rows packed): load 35,322 / 38,097; live 84,526; allocated
/// 163,620; at rest 40,702 (with every row packed, as the JS writer did: load 36,005 / 38,936). On Leffe's maps, one
/// continent's part loaded (2026-10-25, decoded clusters as byte strings, endpoint trees pooled, the decoded graph
/// read from its strings, Path.cacheKB 8 MB, Path.graphRestKB 1 MB; the parts guarded against a dropped map),
/// Eastern Kingdoms / Kalimdor: load 18,341 / 22,428 and 20,717 / 25,016; live 39,799 / 29,201; allocated 91,361 /
/// 7,859; at rest 19,846 / 22,480.
const BUDGET: [(&str, f64); 5] = [("loadResident", 22500.0), ("loadPeak", 25100.0), ("live", 40000.0), ("allocated", 92000.0), ("rest", 22500.0)];

const WALKS: [(u32, [f64; 3], [f64; 3]); 5] = [
	(0, [-8911.708, -130.583, 81.024], [-8680.25, -113.229, 91.141]),
	(0, [-9462.579, 16.233, 56.963], [-8821.495, 659.915, 98.351]),
	(0, [-6054.8, -3144.0, f64::NAN], [-6064.0, -3091.6, f64::NAN]),
	(0, [-651.7, 1270.2, f64::NAN], [-635.2, 1186.6, f64::NAN]),
	(1, [6809.4, -739.4, f64::NAN], [6878.8, -655.6, f64::NAN]),
];
const PLACES: [[f64; 3]; 16] = [
	[-8911.708, -130.583, 81.024],
	[-8680.25, -113.229, 91.141],
	[-8633.958, -113.229, 87.412],
	[-9444.062, 77.667, 57.353],
	[-9791.249, 164.438, 27.373],
	[-9462.579, 16.233, 56.963],
	[-8821.495, 659.915, 98.351],
	[-9079.7, -587.0, 62.2],
	[-9099.2, -592.2, f64::NAN],
	[-10985.5, -80.3, 14.9],
	[-10937.1, -130.6, f64::NAN],
	[-6818.9, -1215.6, f64::NAN],
	[-6915.1, -1190.9, f64::NAN],
	[-9587.0, -200.0, f64::NAN],
	[-9648.0, -1300.0, f64::NAN],
	[-10400.0, 990.0, f64::NAN],
];

fn point(p: &[f64; 3]) -> String {
	if p[2].is_nan() {
		format!("{{ x = {}, y = {} }}", p[0], p[1])
	} else {
		format!("{{ x = {}, y = {}, z = {} }}", p[0], p[1], p[2])
	}
}

const BEFORE: &str = r#"
-- The stub decoder's own garbage is not the client's: count it out (all but the string it returns).
EXCLUDED = 0
for _, name in ipairs({ "DecodeBase64", "DecompressString" }) do
	local f = C_EncodingUtil[name]
	C_EncodingUtil[name] = function(s, ...)
		local before = collectgarbage("count")
		local r = f(s, ...)
		local grew = collectgarbage("count") - before - (r and (#r + 25) / 1024 or 0)
		if grew > 0 then EXCLUDED = EXCLUDED + grew end
		return r
	end
end
function FULL() collectgarbage("collect") collectgarbage("collect") return collectgarbage("count") end
BASE = FULL()
EXCLUDED = 0
collectgarbage("stop")"#;

/// One session on continent `map`: its walks (and, on Eastern Kingdoms, the batch). A continent whose maps are a
/// part addon (maps format 5: Polestar_Nav_EK, _Kalimdor) has it loaded first, as the router does at its first
/// search there, so `load` counts Polestar_Nav and that continent's part: what a player on it holds.
fn script(map: u32) -> String {
	let walks: Vec<String> = WALKS.iter().filter(|w| w.0 == map).map(|(m, a, b)| format!("{{ {m}, {}, {} }}", point(a), point(b))).collect();
	let places: Vec<String> = PLACES.iter().map(point).collect();
	let batch = if map == 0 {
		format!("Path.FindMany(0, {}, {{ {} }}, function(costs) answered(costs ~= nil) end, {{ profile = \"Horde\" }})\ndrain()", point(&WALKS[1].2), places.join(", "))
	} else {
		String::new()
	};
	format!(
		r#"
local part = PolestarPathData[{map}] and PolestarPathData[{map}].part
if part then C_AddOns.LoadAddOn(part) end
local loadPeak = collectgarbage("count") - BASE - EXCLUDED
collectgarbage("restart")
local loadResident = FULL() - BASE
local Path = Polestar_NavEngine
local frames = {{}}
Path.after = function(fn) frames[#frames + 1] = fn end
Path.clock = function() return os.clock() * 1000 end
EXCLUDED = 0
collectgarbage("stop")
local allocated, live, last, answers = 0, 0, collectgarbage("count"), 0
local function answered(found)
	if found then answers = answers + 1 end
	allocated = allocated + collectgarbage("count") - last
	local l = FULL() - BASE
	if l > live then live = l end
	collectgarbage("stop")
	last = collectgarbage("count")
end
local function drain() while #frames > 0 do table.remove(frames, 1)() end end
for _, w in ipairs({{ {walks} }}) do
	Path.Find(w[1], w[2], w[3], function(points) answered(points ~= nil) end, {{ profile = "Horde" }})
	drain()
end
{batch}
allocated = allocated + collectgarbage("count") - last - EXCLUDED
collectgarbage("restart")
emit({{ loadResident = loadResident, loadPeak = loadPeak, live = live, allocated = allocated, rest = FULL() - BASE, answers = answers }})"#,
		walks = walks.join(", "),
	)
}

#[test]
fn t_693_polestar_nav_stays_within_its_memory_budget_loading_the_maps_searching_them_live_and_allocated_and_at_rest() {
	if !addons_dir().join("Polestar_Nav/Nav/Nav.xml").exists() {
		eprintln!("skipped: addon/Polestar_Nav has no walking maps");
		return;
	}
	// A session stays on one continent: Polestar_Nav loads at login, a continent's part the first time a walk
	// there is searched, and nothing unloads. The budget holds for each continent's session.
	let mut over = Vec::new();
	for map in [0u32, 1] {
		let got = emitted(&RunAddon { stubs: vec!["stub_encoding.lua"], before: BEFORE.into(), addons: vec![Addon::name("Polestar_Nav")], script: script(map), ..Default::default() }).remove(0);
		let want = WALKS.iter().filter(|w| w.0 == map).count() + usize::from(map == 0);
		assert_eq!(got["answers"], want as i64, "map {map}: every walk and the batch answered: {got}");
		let kib: Vec<(String, f64)> = BUDGET.iter().map(|(k, _)| (k.to_string(), got[*k].as_f64().unwrap().round())).collect();
		eprintln!("nav memory, map {map} (KiB): {kib:?}");
		for ((k, budget), (_, v)) in BUDGET.iter().zip(&kib) {
			if *v > *budget {
				over.push(format!("map {map}, {k}: {v} KiB, budget {budget} KiB"));
			}
		}
	}
	assert!(over.is_empty(), "over budget: {over:?}");
}
