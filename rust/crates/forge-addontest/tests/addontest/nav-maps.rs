//! addon/Polestar_Nav: Polestar's walking router (Routing/, started from Shortest Path Forever v1.16.0 by
//! Cillian Berragan, GPL-3.0-or-later, and Polestar's since 2026-10-16) and Polestar's walking maps of Eastern
//! Kingdoms, Kalimdor and Zephras Isle (maps format 3, `forge nav pack`). The maps match PACK.json, the router
//! keeps his copyright and the GPL notice, and the addon loads and finds real walking routes on its own
//! PolestarPathData. Checks from docs/NAV_QA.md name their row (C2, C6, C17, and the shared-tables hazard at
//! its top). (Ported from tests/nav-maps.test.js.)

use std::io::Read;
use std::path::{Path, PathBuf};

use forge_addontest::run::{addons_dir, root, toc_entries, xml_files};
use forge_addontest::tmp::TempDir;
use forge_addontest::{emitted, lua_string, Addon, RunAddon};
use regex::Regex;
use serde_json::{json, Value};

fn nav() -> PathBuf {
	addons_dir().join("Polestar_Nav")
}
fn read(p: &Path) -> String {
	std::fs::read_to_string(p).unwrap_or_else(|e| panic!("{}: {e}", p.display()))
}
fn pack_manifest() -> Value {
	serde_json::from_str(&read(&nav().join("PACK.json"))).unwrap()
}
fn ws(s: &str) -> String {
	Regex::new(r"\s+").unwrap().replace_all(s, " ").into_owned()
}
fn run(script: &str, before: &str, addons: Vec<Addon>) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_encoding.lua"], before: before.into(), addons, script: script.into(), ..Default::default() }).remove(0)
}

#[test]
fn the_walking_router_is_polestars_started_from_his_his_three_files_keep_his_copyright_and_the_gpl_notice() {
	let header = "Polestar's walking router. Started from Shortest Path Forever v1.16.0 (b1ad5bd) by Cillian Berragan (GPL-3.0-or-later); modified for Polestar since 2026-10-16.";
	for name in ["PathGrid.lua", "Path.lua", "PathJobs.lua"] {
		let text = read(&nav().join("Routing").join(name));
		let lines: Vec<&str> = text.split('\n').collect();
		assert_eq!(lines[0], format!("-- {header}"), "{name}: the header");
		let notice = lines[1..6].iter().map(|l| l.strip_prefix("-- ").unwrap_or(l)).collect::<Vec<_>>().join(" ");
		assert!(notice.starts_with(&format!("Routing/{name}: Copyright (C) 2026 Cillian Berragan (https://github.com/cjber/shortest-path-forever)")), "{name}: his copyright");
		assert!(
			notice.contains("GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version."),
			"{name}: the GPL notice"
		);
		assert!(!text.contains("ShortestPathForeverPathData"), "{name}: reads only PolestarPathData");
	}
	assert!(Regex::new(r"(?m)^-- Copyright \(c\) 2026 The Polestar authors\. GPL-3\.0-or-later").unwrap().is_match(&read(&nav().join("Routing/Costs.lua"))));
	let license = ws(&read(&nav().join("LICENSE")));
	assert!(license.contains("Polestar's walking router started from Shortest Path Forever v1.16.0 by Cillian Berragan, with thanks; Polestar maintains it since 2026-10-16"));
	assert!(Regex::new(r"Routing/PathGrid\.lua, Routing/Path\.lua and Routing/PathJobs\.lua .*Copyright \(C\) 2026 Cillian Berragan").unwrap().is_match(&license));
	for doc in [nav().join("CREDITS.md"), root().join("LICENSE"), root().join("THIRD_PARTY.md"), root().join("README.md")] {
		assert!(
			ws(&read(&doc)).contains("Polestar's walking router started from Shortest Path Forever v1.16.0 by Cillian Berragan, with thanks; Polestar maintains it since 2026-10-16"),
			"{}",
			doc.display()
		);
	}
}

#[test]
fn nav_check_passes_on_the_committed_folder_and_nothing_of_his_maps_is_left() {
	assert_eq!(forge_nav::pack::check_pack(&nav()), Vec::<String>::new());
	assert!(!nav().join("UPSTREAM.json").exists(), "no vendored maps to track");
	assert_eq!(read(&nav().join("Nav/Nav.xml")), forge_nav::pack::nav_xml(&nav()));
}

#[test]
fn the_walking_maps_pack_json_names_the_grid_the_cells_the_format_and_every_file_their_headers_name_the_command_the_grid_and_the_date() {
	let p = pack_manifest();
	let generator = p["generator"].as_str().unwrap();
	assert!(["forge nav pack", "node tools/polestar.js nav pack"].contains(&generator), "{generator}");
	assert_eq!(p["cells"], 128);
	assert!(Regex::new(r"^\d{4}-\d\d-\d\d$").unwrap().is_match(p["date"].as_str().unwrap()));
	let build = p["grid"]["build"].as_str().unwrap();
	assert!(Regex::new(r"^\d+\.\d+\.\d+\.\d+$").unwrap().is_match(build));
	assert_eq!(p["maps"].as_object().unwrap().keys().cloned().collect::<Vec<_>>(), ["0", "1", "2991"]);
	assert_eq!(p["format"], 3, "maps format 3: each surface's WMO group area (the grid's area sidecars)");
	let names: Vec<String> = p["files"].as_object().unwrap().keys().map(|r| r[4..].to_string()).collect();
	let ours = Regex::new(r"^Nav(0|1|2991)(_\d+)?\.lua$").unwrap();
	assert_eq!(names.iter().filter(|n| !ours.is_match(n)).collect::<Vec<_>>(), ["Chokepoints.lua"]);
	let scripts: Vec<String> = xml_files(&nav().join("Nav/Nav.xml")).unwrap().iter().map(|f| f.file_name().unwrap().to_string_lossy().into_owned()).collect();
	let mut want: Vec<String> = names.iter().filter(|n| *n != "Chokepoints.lua").cloned().collect();
	want.push("Chokepoints.lua".into());
	assert_eq!(scripts, want, "the maps, then the chokepoints");
	let first = Regex::new(&format!(
		r"^-- Generated by `{} --cells 128` from the navigation grid \(\S+ {}, built \d{{4}}-\d\d-\d\d\) on {}\.",
		regex::escape(generator),
		regex::escape(build),
		p["date"].as_str().unwrap()
	))
	.unwrap();
	for n in &names {
		let text = read(&nav().join("Nav").join(n));
		assert!(first.is_match(text.lines().next().unwrap()), "{n}");
		assert!(!text.contains("ShortestPathForeverPathData"));
	}
	let meta = read(&nav().join("Nav/Nav0.lua"));
	assert!(meta.lines().any(|l| l == "-- a port of his tools/baker/gen_nav.py and tools/pack_nav.py, used with his permission."));
	for map in [0, 1, 2991] {
		let text = read(&nav().join(format!("Nav/Nav{map}.lua")));
		assert!(text.lines().any(|l| l == "\tformat = 3,"), "map {map}: maps format 3");
		assert!(text.lines().any(|l| l == "\tarea = {},") && text.lines().any(|l| l == "\tareaNames = {"), "map {map}: the area field packed, its rows named");
	}
	assert!(meta.lines().any(|l| l == "-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15."), "his notice on one line");
	assert!(meta.lines().any(|l| l == "\tcells = 128,"));
}

#[test]
fn security_l12_the_license_names_cillian_berragans_copyright_and_every_file_that_says_it_adapts_his_code() {
	let license = read(&root().join("LICENSE"));
	let start = license.find("Portions Copyright (C) 2026 Cillian Berragan").unwrap();
	let para = &license[start..start + license[start..].find("-----").unwrap()];
	assert!(para.starts_with("Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever,"));
	assert!(para.contains("version 3 or (at your option) any later version"));
	let flat = ws(para).replace("/ ", "/");
	let named: Vec<String> = Regex::new(r"([\w/]+\.lua|[\w/-]+\.js|[\w/-]+\.rs)\b").unwrap().captures_iter(&flat).map(|c| c[1].to_string()).collect();
	let repo_rel = Regex::new(r"^(tools|tests|rust)/").unwrap();
	for rel in &named {
		let file = if repo_rel.is_match(rel) { root().join(rel) } else { addons_dir().join("Polestar").join(rel) };
		assert!(file.exists(), "LICENSE names {rel}, which does not exist");
	}
	// Every file carrying the dated notice as its own comment is named.
	let marked = Regex::new(r"(?m)^[ \t]*(?:--|//!?)[ \t]*Portions Copyright \(C\) 2026 Cillian Berragan").unwrap();
	let mut found = Vec::new();
	fn walk(dir: &Path, re: &Regex, out: &mut Vec<PathBuf>) {
		for e in std::fs::read_dir(dir).into_iter().flatten().flatten() {
			let p = e.path();
			if p.is_dir() {
				walk(&p, re, out);
			} else if p.extension().is_some_and(|x| x == "lua" || x == "js" || x == "rs") && std::fs::read_to_string(&p).is_ok_and(|t| re.is_match(&t)) {
				out.push(p);
			}
		}
	}
	let polestar = addons_dir().join("Polestar");
	for d in [polestar.clone(), root().join("tools/lib"), root().join("tests/helpers"), root().join("rust/crates")] {
		walk(&d, &marked, &mut found);
	}
	for p in found {
		let rel = p.strip_prefix(&polestar).or_else(|_| p.strip_prefix(root())).unwrap().to_string_lossy().replace('\\', "/");
		assert!(named.contains(&rel), "{rel} carries the notice but LICENSE does not name it");
	}
}

#[test]
fn second_review_l13b_timetable_keeps_the_cmangos_notice_it_ports_under_and_the_root_license_names_it() {
	let notice = "Portions Copyright (C) the CMaNGOS project (see its AUTHORS file), GPL-2.0-or-later, used under GPL-3.0.";
	let src = read(&root().join("tools/lib/travel/timetable.js"));
	assert!(src.split('\n').take(12).any(|l| l == format!("// {notice}")), "in the header, next to the Shortest Path Forever line");
	let license = read(&root().join("LICENSE"));
	let start = license.find("Portions Copyright (C) the CMaNGOS project").unwrap();
	let para = ws(&license[start..start + license[start..].find("-----").unwrap()]);
	assert!(Regex::new(r"^Portions Copyright \(C\) the CMaNGOS project .*version 2 or \(at your option\) any later version, and used under version 3: .*tools/lib/travel/timetable\.js")
		.unwrap()
		.is_match(&para));
}

const GOLDSHIRE: &str = "{ x = -9444.062, y = 77.667, z = 57.353 }";
const FARGODEEP: &str = "{ x = -9791.249, y = 164.438, z = 27.373 }";

fn route_script() -> String {
	format!(
		r#"
local Path = Polestar_NavEngine
local frames = {{}}
Path.after = function(fn) frames[#frames + 1] = fn end
local function drain() while #frames > 0 do table.remove(frames, 1)() end end
local got = {{}}
Path.Find(0, {GOLDSHIRE}, {FARGODEEP}, function(points, cost) got.points, got.cost = points, cost end)
Path.FindCost(0, {GOLDSHIRE}, {FARGODEEP}, function(cost) got.costOnly = cost end)
Path.FindMany(0, {GOLDSHIRE}, {{ {FARGODEEP}, {{ x = 0, y = 6000 }} }}, function(costs) got.many = costs end)
drain()
local len = 0
for i = 2, #got.points do
	local a, b = got.points[i - 1], got.points[i]
	len = len + math.sqrt((a.x - b.x) ^ 2 + (a.y - b.y) ^ 2)
end
local first, last = got.points[1], got.points[#got.points]
emit({{
	cost = got.cost, costOnly = got.costOnly, many = got.many, length = len, n = #got.points,
	first = {{ first.x, first.y }}, last = {{ last.x, last.y }}, map = first.map,
	available = {{ Path.Available(0), Path.Available(1), Path.Available(2991), Path.Available(530) }},
	api = {{ type(Path.Cancel), type(Path.Busy), type(Path.FindCost), type(Path.FindMany) }},
	decoded = stub.decompressed,
}})"#
	)
}

#[test]
fn polestar_nav_loads_its_own_maps_and_walks_goldshire_to_the_fargodeep_mine_mouth() {
	let got = run(&route_script(), "", vec![Addon::name("Polestar_Nav")]);
	let cost = got["cost"].as_f64().unwrap();
	assert!(cost > 400.0 && cost < 700.0, "cost {cost}");
	let len = got["length"].as_f64().unwrap();
	assert!(len > 358.0 && len < 700.0, "drawn length {len}");
	assert!(got["n"].as_i64().unwrap() >= 3, "the route bends round the hill");
	assert!((got["costOnly"].as_f64().unwrap() - cost).abs() < 1e-6, "FindCost gives the same cost");
	assert!((got["many"][0].as_f64().unwrap() - cost).abs() < 1e-6 && got["many"][1] == false, "FindMany: the same cost, and false off the map");
	assert_eq!(got["first"], json!([-9444.062, 77.667]));
	assert_eq!(got["last"], json!([-9791.249, 164.438]));
	assert_eq!(got["map"], 0);
	assert_eq!(got["available"], json!([true, true, true, false]));
	assert_eq!(got["api"], json!(["function", "function", "function", "function"]));
	assert!(got["decoded"].as_f64().unwrap() > 0.0);
}

#[test]
fn shared_tables_hazard_with_shortest_path_forever_installed_our_engine_reads_only_polestarpathdata() {
	let files = xml_files(&nav().join("Nav/Nav.xml")).unwrap();
	let spf_copy = format!(
		"local spf = {{}}\n{}\nShortestPathForeverPathData, PolestarPathData = PolestarPathData, nil",
		files.iter().map(|f| format!("assert(loadfile({}))(\"ShortestPathForever\", spf)", lua_string(&f.to_string_lossy()))).collect::<Vec<_>>().join("\n")
	);
	let got = run(
		&format!(
			r#"
local Path = Polestar_NavEngine
Path.clock = function() return os.clock() * 1000 end
Path.budget = 0.05
local frames = {{}}
Path.after = function(fn) frames[#frames + 1] = fn end
local function trimTheirs()
	for _, D in pairs(ShortestPathForeverPathData) do
		D.graph, D.grid, D.height, D.floor = {{}}, {{}}, {{}}, {{}}
	end
end
local got, n = {{}}, 0
Path.Find(0, {GOLDSHIRE}, {FARGODEEP}, function(points, cost) got.points, got.cost = points, cost end)
while #frames > 0 do
	n = n + 1
	table.remove(frames, 1)()
	trimTheirs()
end
local distinct = true
for map, D in pairs(PolestarPathData) do
	if D == ShortestPathForeverPathData[map] then distinct = false end
end
emit({{ cost = got.cost, n = got.points and #got.points, frames = n, distinct = distinct, maps = (function() local k = {{}} for m in pairs(PolestarPathData) do k[#k + 1] = m end table.sort(k) return k end)() }})"#
		),
		&spf_copy,
		vec![Addon::name("Polestar_Nav")],
	);
	let cost = got["cost"].as_f64().unwrap();
	assert!(cost > 400.0 && cost < 700.0, "cost {cost}");
	assert!(got["frames"].as_i64().unwrap() > 1);
	assert_eq!(got["distinct"], true, "no map table is shared");
	assert_eq!(got["maps"], json!([0, 1, 2991]));
}

#[test]
fn c2_a_search_cancelled_mid_way_never_calls_back_and_the_queue_empties() {
	let got = run(
		&format!(
			r#"
local Path = Polestar_NavEngine
Path.clock = function() return os.clock() * 1000 end
Path.budget = 0.05
local frames = {{}}
Path.after = function(fn) frames[#frames + 1] = fn end
local called, kept = 0, 0
local job = Path.Find(0, {GOLDSHIRE}, {FARGODEEP}, function() called = called + 1 end)
local many = Path.FindMany(0, {GOLDSHIRE}, {{ {FARGODEEP} }}, function() called = called + 1 end, nil, nil, function() kept = kept + 1 end)
table.remove(frames, 1)()
local started = not job.done
Path.Cancel(job)
Path.Cancel(many)
local n = 0
while #frames > 0 and n < 1000 do n = n + 1; table.remove(frames, 1)() end
Path.Busy()
emit({{ called = called, started = started, cancelled = job.cancelled == true, busy = Path.Busy(), left = #frames }})"#
		),
		"",
		vec![Addon::name("Polestar_Nav")],
	);
	assert_eq!(got["started"], true, "cancelled while the search was under way");
	assert_eq!(got["called"], 0);
	assert_eq!(got["cancelled"], true);
	assert_eq!(got["left"], 0);
	assert_eq!(got["busy"], false);
}

#[test]
fn c6_stormwind_flight_master_to_the_mage_quarter_never_doubles_back_and_a_rooftop_endpoint_still_routes() {
	let got = run(
		r#"
local Path = Polestar_NavEngine
local pts = Path.FindSync(0, { x = -8840.56, y = 489.7, z = 109.61 }, { x = -9100, y = 1200 })
local reversals = {}
for i = 2, #pts - 1 do
	local a, b, c = pts[i - 1], pts[i], pts[i + 1]
	local level = a.z and c.z and math.abs(a.z - b.z) < 5 and math.abs(c.z - b.z) < 5
	local ux, uy, vx, vy = b.x - a.x, b.y - a.y, c.x - b.x, c.y - b.y
	local lu, lv = math.sqrt(ux * ux + uy * uy), math.sqrt(vx * vx + vy * vy)
	if level and lu > 0 and lv > 0 and (ux * vx + uy * vy) / (lu * lv) < -0.95 then reversals[#reversals + 1] = string.format("%.0f,%.0f", b.x, b.y) end
end
local roof = Path.FindSync(0, { x = -9010, y = 870 }, { x = -8840.56, y = 489.7 })
emit({ n = #pts, reversals = table.concat(reversals, " "), roof = roof ~= nil })"#,
		"",
		vec![Addon::name("Polestar_Nav")],
	);
	assert!(got["n"].as_i64().unwrap() >= 2);
	assert_eq!(got["reversals"], "");
	assert_eq!(got["roof"], true);
}

#[test]
fn c17_searches_are_sliced_over_frames_within_path_budget_and_give_the_synchronous_result_the_maps_load_on_demand() {
	let got = run(
		&format!(
			r#"
local Path = Polestar_NavEngine
local sync, syncCost = Path.FindSync(0, {GOLDSHIRE}, {FARGODEEP})
Path.ClearCaches()
Path.clock = function() return os.clock() * 1000 end
Path.budget = 0.05
local frames = {{}}
Path.after = function(fn) frames[#frames + 1] = fn end
local got = {{}}
Path.Find(0, {GOLDSHIRE}, {FARGODEEP}, function(points, cost) got.points, got.cost = points, cost end)
local n = 0
while #frames > 0 do n = n + 1; table.remove(frames, 1)() end
emit({{ frames = n, cost = got.cost, syncCost = syncCost, points = #got.points, syncPoints = #sync, cacheKB = Path.cacheKB, graphKB = Path.graphKB }})"#
		),
		"",
		vec![Addon::name("Polestar_Nav")],
	);
	assert!(got["frames"].as_i64().unwrap() > 1);
	assert!((got["cost"].as_f64().unwrap() - got["syncCost"].as_f64().unwrap()).abs() < 1e-6);
	assert_eq!(got["points"], got["syncPoints"]);
	let toc = read(&nav().join("Polestar_Nav.toc"));
	assert!(toc.lines().any(|l| l == "## LoadOnDemand: 1"), "not loaded at startup");
	let grid = read(&nav().join("Routing/PathGrid.lua"));
	assert_eq!(Regex::new(r"(?m)^Path\.budget = (\d+)").unwrap().captures(&grid).unwrap()[1].to_string(), "2", "the 2 ms frame budget");
	assert_eq!((got["cacheKB"].as_i64().unwrap(), got["graphKB"].as_i64().unwrap()), (48 * 1024, 16 * 1024));
	assert!(Regex::new(r"(?m)^Path\.cacheKB = 24576 ").unwrap().is_match(&grid));
}

#[test]
fn c17_the_frame_budget_grows_with_the_frame_rate_out_of_a_slow_frame_never_past_path_budgetmax_and_keeps_2_ms_after_a_hitch() {
	let got = run(
		r#"
local Path = Polestar_NavEngine
local out = {}
for _, fps in ipairs({ 0, 20, 40, 60, 100, 240 }) do out[#out + 1] = Path.FrameBudget(fps, 16) end
out.hitch = Path.FrameBudget(120, 80)
out.first = Path.FrameBudget(120, nil)
local was = Path.budget
Path.budget = math.huge
out.huge = Path.FrameBudget(120, 16) == math.huge
Path.budget = 0.05
out.small = Path.FrameBudget(100, 16)
Path.budget = was
emit(out)"#,
		"",
		vec![Addon::name("Polestar_Nav")],
	);
	// A table with both array and hash parts emits as an object keyed "1".."6".
	let budgets: Vec<Value> = (1..=6).map(|i| got[i.to_string()].clone()).collect();
	assert_eq!(json!(budgets), json!([2, 2, 2, 4, 8, 8]));
	assert_eq!(got["hitch"], 2, "a pump 80 ms after the last keeps the base budget");
	assert_eq!(got["first"], 8, "the first pump of a search is not a slow frame");
	assert_eq!(got["huge"], true, "a harness budget of math.huge stays unsliced");
	assert!((got["small"].as_f64().unwrap() - 0.2).abs() < 1e-9, "a test budget scales the same way (x4)");
}

#[test]
fn memory_at_rest_a_search_may_decode_graph_up_to_path_graphkb_idle_trims_it_to_path_graphrestkb() {
	let tmp = TempDir::new("polestar-nav-rest-");
	let keep = tmp.path().join("keep-ns.lua");
	std::fs::write(&keep, "local _, ns = ...\nstub.navNs = ns\n").unwrap();
	let mut files = toc_entries(&nav()).unwrap();
	files.push(keep.to_string_lossy().into_owned());
	let got = run(
		r#"local Path, G = Polestar_NavEngine, stub.navNs.PathGrid
local function kb() local i = 1 while true do local k, v = debug.getupvalue(G.Reset, i) if k == "graphKB" then return v end i = i + 1 end end
local rest = Path.graphRestKB
Path.graphRestKB = 512
local pts = Path.FindSync(0, { x = 3089.7, y = -2647.7 }, { x = 3079.3, y = -2755.7 })
local searching = kb()
G.Idle()
emit({ found = pts ~= nil, searching = searching, resting = kb(), rest = rest, ceiling = Path.graphKB })"#,
		"",
		vec![Addon::Files("Polestar_Nav".into(), files)],
	);
	assert_eq!(got["found"], true);
	assert_eq!((got["rest"].as_i64().unwrap(), got["ceiling"].as_i64().unwrap()), (6 * 1024, 16 * 1024), "API.lua's ceilings");
	assert!(got["searching"].as_f64().unwrap() > 512.0);
	assert!(got["resting"].as_f64().unwrap() <= 512.0);
}

#[test]
fn polestar_nav_ships_in_the_release_credits_shortest_path_forever_and_carries_the_gpl() {
	assert!(forge_release::addons::release_addons(&addons_dir()).names.iter().any(|n| n == "Polestar_Nav"));
	let toc = read(&nav().join("Polestar_Nav.toc"));
	for line in ["## LoadOnDemand: 1", "## Dependencies: Polestar", "## X-License: GPL-3.0-or-later"] {
		assert!(toc.lines().any(|l| l == line), "{line}");
	}
	assert!(Regex::new(r"(?m)^## Notes: .*Shortest Path Forever.*Cillian Berragan").unwrap().is_match(&toc));
	let license = read(&nav().join("LICENSE"));
	assert!(license.contains("Copyright (C) 2026 Cillian Berragan") && license.contains("https://github.com/cjber/shortest-path-forever"));
	assert!(Regex::new(r"GNU GENERAL PUBLIC LICENSE\s+Version 3, 29 June 2007").unwrap().is_match(&license));
	let credits = read(&nav().join("CREDITS.md"));
	assert!(credits.contains("b1ad5bd") && credits.contains("Version 1.16.0"));
}

const ENGINE: &str = r#"
local Path = Polestar_NavEngine
local function d(ax, ay, bx, by) return math.sqrt((ax - bx) ^ 2 + (ay - by) ^ 2) end
local function near(p, x, y, upto)
	local best, walked = math.huge, 0
	for i = 2, #p do
		local a, b = p[i - 1], p[i]
		local L = d(a.x, a.y, b.x, b.y)
		for s = 0, 20 do
			local t = s / 20
			if walked + t * L <= upto then best = math.min(best, d(a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t, x, y)) end
		end
		walked = walked + L
	end
	return best
end
local r = {}
local inn = Path.FindSync(1, { x = 340.523, y = -4686.091, z = 16.458 }, { x = 1633.959, y = -4439.410, z = 15.480 })
r.door = inn and near(inn, 333.7, -4700.3, 30)
local _, top = Path.FindSync(0, { x = 1713.688, y = 231.708, z = 62.598 }, { x = 1596.150, y = 291.800, z = 55.718 })
local _, bottom = Path.FindSync(0, { x = 1596.150, y = 291.800, z = -40.784 }, { x = 1567.110, y = 266.388, z = -59.285 })
local _, walk = Path.FindSync(0, { x = 1713.688, y = 231.708, z = 62.598 }, { x = 1567.110, y = 266.388, z = -59.285 })
r.lift = { top = top, bottom = bottom, walk = walk }
local sea, why = Path.FindSync(1, { x = 6398.9, y = 531.267, z = 8.663 }, { x = 8797.237, y = 968.342, z = 30.265 })
r.sea = { found = sea ~= nil, why = why }
local coast, cost = Path.FindSync(1, { x = -846.775, y = -3720.55, z = 20.524 }, { x = -1502.131, y = -4024.55, z = 0 })
r.coast = { found = coast ~= nil, cost = cost }
emit(r)"#;

#[test]
fn polestars_maps_on_the_engine_the_inn_is_left_by_its_door_the_undercity_by_an_undervator_open_sea_never_swum() {
	let got = run(ENGINE, "", vec![Addon::name("Polestar_Nav")]);
	let door = got["door"].as_f64().unwrap();
	assert!(door < 3.0, "the walk out of the inn passes {door:.1} yd from the door");
	let (top, bottom, walk) = (got["lift"]["top"].as_f64().unwrap(), got["lift"]["bottom"].as_f64().unwrap(), got["lift"]["walk"].as_f64().unwrap());
	assert!(top > 0.0 && bottom > 0.0, "both Undervator landings are reached on foot");
	assert!((top + bottom) / 7.0 + 12.0 < walk / 7.0, "by the lift, not walking round");
	assert_eq!(got["sea"], json!({ "found": false, "why": "unreachable" }), "fatigue water is no surface");
	assert!(got["coast"]["found"] == true && got["coast"]["cost"].as_f64().unwrap() > 0.0);
}

#[test]
fn a_horde_walk_into_southshore_on_the_shipped_maps_reports_the_town_with_its_area_id() {
	let got = run(
		r#"
local Path = Polestar_NavEngine
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local got = {}
Path.Find(0, { x = -500, y = -560 }, { x = -850, y = -540 }, function(points, cost, job) got.found, got.hubs = points ~= nil, job and job.hubs end, { profile = "Horde" })
while #frames > 0 do table.remove(frames, 1)() end
emit(got)"#,
		"",
		vec![Addon::name("Polestar_Nav")],
	);
	assert_eq!(got["found"], true);
	assert_eq!(got["hubs"], json!([{ "id": "alliance-southshore", "name": "Southshore", "areaId": 271 }]));
}

/// The packed graph strings of a map (Nav<map>_*.lua's data.packed.graph[k] blocks: base64 of zlib).
fn graph_fields(map: u32) -> Vec<(usize, Vec<u8>)> {
	let line = Regex::new(r#"(?m)^data\.packed\.graph\[(\d+)\] = \{(.*)\}$"#).unwrap();
	let block = Regex::new(r#""([A-Za-z0-9+/=]+)""#).unwrap();
	let part = Regex::new(&format!(r"^Nav{map}_\d+\.lua$")).unwrap();
	let mut out = Vec::new();
	for e in std::fs::read_dir(nav().join("Nav")).unwrap().flatten() {
		let name = e.file_name().to_string_lossy().into_owned();
		if !part.is_match(&name) {
			continue;
		}
		for c in line.captures_iter(&read(&e.path())) {
			let mut raw = Vec::new();
			for b in block.captures_iter(&c[2]) {
				let bytes = unbase64(&b[1]);
				let mut z = flate2::read::ZlibDecoder::new(&bytes[..]);
				z.read_to_end(&mut raw).unwrap();
			}
			out.push((c[1].parse().unwrap(), raw));
		}
	}
	out
}

fn unbase64(s: &str) -> Vec<u8> {
	let mut out = Vec::new();
	let (mut acc, mut bits) = (0u32, 0);
	for b in s.bytes().filter(|&b| b != b'=') {
		acc = (acc << 6) | forge_nav::pack::B64.iter().position(|&x| x == b).unwrap() as u32;
		bits += 6;
		if bits >= 8 {
			bits -= 8;
			out.push((acc >> bits) as u8);
		}
	}
	out
}

#[test]
fn the_packed_maps_decode_every_entrance_names_a_cell_of_its_cluster() {
	let num = |s: &[u8], o: usize, w: usize| -> usize { (0..w).fold(0, |a, i| a * 64 + forge_nav::pack::B64.iter().position(|&x| x == s[o + i]).unwrap()) };
	for map in [0, 1] {
		let mut n = 0;
		for (k, g) in graph_fields(map) {
			let count = num(&g, 0, 2);
			for i in 0..count {
				let cell = num(&g, 2 + i * 7, 3);
				assert!(cell < 128 * 128, "map {map} cluster {}: entrance cell {cell}", k - 1);
				n += 1;
			}
		}
		assert!(n > 30000, "map {map}: {n} entrances");
	}
}
