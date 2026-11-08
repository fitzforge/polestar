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
	assert_eq!(p["format"], 5, "maps format 5: Leffe's navigation maps (his surfaces, graph and jumps), each surface's WMO group area from the grid");
	let keys: Vec<String> = p["files"].as_object().unwrap().keys().cloned().collect();
	let names: Vec<String> = keys.iter().filter_map(|r| r.strip_prefix("Nav/").map(str::to_string)).collect();
	let ours = Regex::new(r"^Nav(0|1|2991)(_\d+)?\.lua$").unwrap();
	assert_eq!(names.iter().filter(|n| !ours.is_match(n)).collect::<Vec<_>>(), ["Chokepoints.lua"]);
	// Each continent's map parts ship in its part addon (load on demand), its metadata here.
	for (map, part) in forge_nav::pack::PARTS {
		let files: Vec<String> = keys.iter().filter_map(|r| r.strip_prefix(&format!("{part}/")).map(str::to_string)).collect();
		assert!(files.len() > 10 && files.iter().all(|f| f.starts_with(&format!("Nav{map}_"))), "{part}: {files:?}");
		assert!(names.contains(&format!("Nav{map}.lua")) && !names.iter().any(|n| n.starts_with(&format!("Nav{map}_"))), "map {map}: only its metadata in Polestar_Nav");
		let toc = read(&addons_dir().join(part).join(format!("{part}.toc")));
		assert!(toc.lines().any(|l| l == "## LoadOnDemand: 1") && toc.lines().any(|l| l == "## Dependencies: Polestar_Nav"), "{part}: loads on demand after Polestar_Nav");
		assert_eq!(toc_entries(&addons_dir().join(part)).unwrap(), files, "{part}: its TOC loads its parts in order");
		assert_eq!(p["maps"][map.to_string()]["part"], json!(part));
	}
	let scripts: Vec<String> = xml_files(&nav().join("Nav/Nav.xml")).unwrap().iter().map(|f| f.file_name().unwrap().to_string_lossy().into_owned()).collect();
	let mut want: Vec<String> = names.iter().filter(|n| *n != "Chokepoints.lua").cloned().collect();
	want.push("Chokepoints.lua".into());
	assert_eq!(scripts, want, "the maps, then the chokepoints");
	let first = Regex::new(&format!(
		r"^-- Generated by `{} --cells 128 --leffe` from the navigation grid \(\S+ {}, built \d{{4}}-\d\d-\d\d\) and Leffe's navigation maps on {}\.",
		regex::escape(generator),
		regex::escape(build),
		p["date"].as_str().unwrap()
	))
	.unwrap();
	for k in &keys {
		let (dir, n) = k.split_once('/').unwrap();
		let bytes = std::fs::read(if dir == "Nav" { nav().join("Nav").join(n) } else { addons_dir().join(dir).join(n) }).unwrap();
		let text = String::from_utf8_lossy(&bytes);
		assert!(first.is_match(text.lines().next().unwrap()), "{k}");
		assert!(!text.contains("ShortestPathForeverPathData"));
	}
	let meta = read(&nav().join("Nav/Nav0.lua"));
	assert!(meta.lines().any(|l| l == "-- a port of his tools/baker/gen_nav.py and tools/pack_nav.py, used with his permission."));
	for map in [0, 1, 2991] {
		let text = read(&nav().join(format!("Nav/Nav{map}.lua")));
		assert!(text.lines().any(|l| l == "\tformat = 5,"), "map {map}: maps format 5");
		assert!(text.lines().any(|l| l == "\tarea = {},") && text.lines().any(|l| l == "\tareaNames = {"), "map {map}: the area field packed, its rows named");
		assert!(text.lines().any(|l| l == "\tarc = {},"), "map {map}: the jumps and drops packed");
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
	assert_eq!(Regex::new(r"(?m)^Path\.budget = (\d+)").unwrap().captures(&grid).unwrap()[1].to_string(), "3", "the 3 ms frame budget");
	assert_eq!((got["cacheKB"].as_i64().unwrap(), got["graphKB"].as_i64().unwrap()), (8 * 1024, 16 * 1024));
	assert!(Regex::new(r"(?m)^Path\.cacheKB = 8192 ").unwrap().is_match(&grid));
}

// The client's clock here is the VM's instructions (a count hook on every coroutine, 1 ms = 100,000; the stub decoder's
// own are not counted: the client decodes in C), so how much one frame of router work runs is deterministic. Each
// cluster round Orgrimmar, the Valley of Trials and Thunder Bluff is decoded by a surface prefetch (a decode and
// nothing else) at 240 fps: no frame's work runs past Path.budget by more than half of it (0.3.1 grew the budget to
// 8 ms at 100 fps or more, and the end of a decode, after its last slice point, ran 20 times the budget).
#[test]
fn c17_no_frame_of_router_work_runs_past_path_budget_at_any_frame_rate_decoding_included() {
	let got = run(
		r#"
local Path = Polestar_NavEngine
GetFramerate = function() return 240 end
local ticks, STEP = 0, 100
local function hook() ticks = ticks + STEP end
debug.sethook(hook, "", STEP)
local create = coroutine.create
coroutine.create = function(f) local co = create(f) debug.sethook(co, hook, "", STEP) return co end
for _, name in ipairs({ "DecodeBase64", "DecompressString" }) do
	local f = C_EncodingUtil[name]
	C_EncodingUtil[name] = function(...) local t = ticks local r = f(...) ticks = t return r end
end
Path.clock = function() return ticks / 100000 end
local frames, worst, pumps = {}, 0, 0
Path.after = function(fn) frames[#frames + 1] = fn end
local d0 = Path.decodes or 0
for _, c in ipairs({ { 1630, -4400 }, { -607, -4251 }, { -1280, 130 } }) do
	for dx = -2, 2 do
		for dy = -2, 2 do
			Path.Prefetch(1, c[1] + dx * 533, c[2] + dy * 533)
			while #frames > 0 do
				local t = ticks
				table.remove(frames, 1)()
				pumps = pumps + 1
				if ticks - t > worst then worst = ticks - t end
			end
		end
	end
end
debug.sethook()
emit({ worst = worst / 100000, budget = Path.budget, pumps = pumps, decodes = (Path.decodes or 0) - d0 })"#,
		"",
		vec![Addon::name("Polestar_Nav")],
	);
	let (worst, budget) = (got["worst"].as_f64().unwrap(), got["budget"].as_f64().unwrap());
	assert!(got["decodes"].as_i64().unwrap() >= 40, "the clusters decoded: {got}");
	assert!(got["pumps"].as_i64().unwrap() > got["decodes"].as_i64().unwrap(), "decodes sliced over frames: {got}");
	assert!(worst <= budget * 1.5, "a frame ran {worst:.2} ms of router work, budget {budget} ms: {got}");
}

// A search leaves its decoded clusters for the next one (a walk or measure from nearby reads the same clusters): a
// second search over them, once the first is done and the queue empty, decodes nothing. After Path.restSeconds with
// no search they are dropped (but the one the player stands in), and the same search decodes them again.
#[test]
fn a_search_s_clusters_stay_decoded_for_the_next_search_until_the_router_has_rested_path_restseconds() {
	let got = run(
		r#"
local Path = Polestar_NavEngine
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local function drain() while #frames > 0 do table.remove(frames, 1)() end end
local function walk()
	local d0, got = Path.decodes or 0, nil
	Path.Find(1, { x = -607.3, y = -4251.5, z = 39 }, { x = 280, y = -4740 }, function(points) got = points end, { profile = "Horde" })
	drain()
	return { found = got ~= nil and #got > 1, decodes = (Path.decodes or 0) - d0 }
end
local first = walk()
stub.advance(Path.restSeconds - 5)
local again = walk()
stub.advance(Path.restSeconds + 1)
local rested = walk()
emit({ first = first, again = again, rested = rested, restSeconds = Path.restSeconds })"#,
		"",
		vec![Addon::name("Polestar_Nav")],
	);
	assert_eq!(got["restSeconds"], 60);
	for k in ["first", "again", "rested"] {
		assert_eq!(got[k]["found"], true, "{k}: {got}");
	}
	assert!(got["first"]["decodes"].as_i64().unwrap() > 0, "{got}");
	assert_eq!(got["again"]["decodes"], 0, "the same walk again within the rest decodes nothing: {got}");
	assert!(got["rested"]["decodes"].as_i64().unwrap() > 0, "after the rest the clusters were dropped: {got}");
}

#[test]
fn memory_at_rest_a_search_may_decode_graph_up_to_path_graphkb_the_rest_trims_it_to_path_graphrestkb() {
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
-- Tarren Mill to Brill (about 3,900 yd): a walk across many clusters' graphs.
local pts = Path.FindSync(0, { x = -24.96, y = -878.613 }, { x = 2246.1, y = 239.8, z = 34.3 }, { profile = "Horde" })
local searching = kb()
G.Rest()
emit({ found = pts ~= nil, searching = searching, resting = kb(), rest = rest, ceiling = Path.graphKB })"#,
		"",
		vec![Addon::Files("Polestar_Nav".into(), files)],
	);
	assert_eq!(got["found"], true);
	assert_eq!((got["rest"].as_i64().unwrap(), got["ceiling"].as_i64().unwrap()), (1024, 16 * 1024), "API.lua's ceilings");
	assert!(got["searching"].as_f64().unwrap() > 512.0);
	assert!(got["resting"].as_f64().unwrap() <= 512.0);
}

fn keep_ns() -> (TempDir, Addon) {
	let tmp = TempDir::new("polestar-nav-keep-");
	let keep = tmp.path().join("keep-ns.lua");
	std::fs::write(&keep, "local _, ns = ...\nstub.navNs = ns\n").unwrap();
	let mut files = toc_entries(&nav()).unwrap();
	files.push(keep.to_string_lossy().into_owned());
	(tmp, Addon::Files("Polestar_Nav".into(), files))
}

// 0.3.5: a finished search's scratch stays for the next search Path.spareSeconds after the queue emptied, then goes
// (it is ~15 MB after a long walk, and WoW counts what an addon holds). Until 0.3.4 the job delivering the answer took
// it and dropped it, and every emptied queue cleared it.
#[test]
fn a_finished_search_s_scratch_stays_path_spareseconds_after_the_last_search_then_goes() {
	let (_tmp, addon) = keep_ns();
	let got = run(
		r#"local Path, S = Polestar_NavEngine, stub.navNs.PathSearch
local function spare() local i = 1 while true do local k, v = debug.getupvalue(S.Spare, i) if not k then return nil end if k == "spare" then return v end i = i + 1 end end
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local function drain() while #frames > 0 do table.remove(frames, 1)() end end
local got
Path.Find(0, { x = -24.96, y = -878.613 }, { x = 2246.1, y = 239.8, z = 34.3 }, function(points) got = points end, { profile = "Horde" })
drain()
local drained = spare() ~= nil
stub.advance(Path.spareSeconds - 2)
local resting = spare() ~= nil
stub.advance(3)
emit({ found = got ~= nil, drained = drained, resting = resting, gone = spare() == nil, seconds = Path.spareSeconds })"#,
		"",
		vec![addon],
	);
	assert_eq!(got["found"], true);
	assert_eq!(got["seconds"], 15);
	assert_eq!(got["drained"], true, "the queue emptied: the scratch kept for the next search: {got}");
	assert_eq!(got["resting"], true, "within Path.spareSeconds: still kept: {got}");
	assert_eq!(got["gone"], true, "then dropped: {got}");
}

// 0.3.5: the walk asked again 30 yd along fills the last search's tables instead of growing new ones key by key:
// Tarren Mill to Brill allocated 6,196 KiB until 0.3.4, 2,898 KiB now.
#[test]
fn a_walk_asked_again_30_yd_along_reuses_the_last_search_s_scratch() {
	let got = run(
		r#"local Path = Polestar_NavEngine
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local function drain() while #frames > 0 do table.remove(frames, 1)() end end
local function walk(from)
	local got
	collectgarbage("collect")
	collectgarbage("stop")
	EXCLUDED = 0
	local before = collectgarbage("count")
	Path.Find(0, from, { x = 2246.1, y = 239.8, z = 34.3 }, function(points) got = points end, { profile = "Horde" })
	drain()
	local kib = collectgarbage("count") - before - EXCLUDED
	collectgarbage("restart")
	return { found = got ~= nil, kib = kib }
end
local first = walk({ x = -24.96, y = -878.613 })
stub.advance(5)
local again = walk({ x = 1.95, y = -865.3 })
emit({ first = first, again = again })"#,
		r#"
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
end"#,
		vec![Addon::name("Polestar_Nav")],
	);
	eprintln!("re-search KiB: first {} again {}", got["first"]["kib"], got["again"]["kib"]);
	assert_eq!(got["first"]["found"], true, "{got}");
	assert_eq!(got["again"]["found"], true, "{got}");
	let again = got["again"]["kib"].as_f64().unwrap();
	assert!(again < MAX_AGAIN, "the walk asked again 30 yd along allocated {again:.0} KiB (at most {MAX_AGAIN}): {got}");
}
const MAX_AGAIN: f64 = 4000.0;

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

// The terrain buried under Stormwind's Trade District (z 59; tools/lib/nav/eval/acceptance.json's
// stormwind-city-harbor-under, the floor the in-game walk once took) joins the rest of Leffe's maps only far away,
// over the mountains: 20 km to the harbour 590 yd off, a search of most of the continent's graph. Past 8 times the
// straight line plus 2000 yd the search gives up instead; the same walk from the street (z 96) still routes.
#[test]
fn a_walk_from_ground_joined_only_far_away_gives_up_past_8x_the_straight_line_the_street_still_routes() {
	let got = run(
		r#"
local Path = Polestar_NavEngine
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local got = {}
for _, z in ipairs({ 59, false }) do
	Path.Find(0, { x = -8654.925, y = 751.655, z = z or nil }, { x = -8649.5, y = 1337.4, z = 6 }, function(points, cost, job)
		got[z and "buried" or "street"] = { found = points ~= nil, reason = points == nil and cost or nil, yards = job and job.yards }
	end, { profile = "Alliance" })
	while #frames > 0 do table.remove(frames, 1)() end
end
emit(got)"#,
		"",
		vec![Addon::name("Polestar_Nav")],
	);
	assert_eq!(got["buried"]["found"], false, "from the buried terrain: no 20 km walk ({})", got["buried"]);
	assert_eq!(got["street"]["found"], true, "with no height: the walk to the harbour ({})", got["street"]);
	assert!(got["street"]["yards"].as_f64().unwrap() < 1200.0, "through the city ({})", got["street"]);
}

/// The packed graph strings of a map (Nav<map>_*.lua's data.packed.graph[k] blocks: zlib, as base64 or, with the
/// metadata's `blocks = "zlib"`, as the bytes themselves; in Polestar_Nav/Nav or the map's part addon).
fn graph_fields(map: u32) -> Vec<(usize, Vec<u8>)> {
	let zlib = read(&nav().join(format!("Nav/Nav{map}.lua"))).lines().any(|l| l == "\tblocks = \"zlib\",");
	let line = regex::bytes::Regex::new(r#"(?m-u)^data\.packed\.graph\[(\d+)\] = \{(.*)\}$"#).unwrap();
	let part = Regex::new(&format!(r"^Nav{map}_\d+\.lua$")).unwrap();
	let dir = forge_nav::pack::part_of(map).map_or_else(|| nav().join("Nav"), |p| addons_dir().join(p));
	let mut out = Vec::new();
	for e in std::fs::read_dir(dir).unwrap().flatten() {
		let name = e.file_name().to_string_lossy().into_owned();
		if !part.is_match(&name) {
			continue;
		}
		let file = std::fs::read(e.path()).unwrap();
		for c in line.captures_iter(&file) {
			let mut raw = Vec::new();
			for b in literals(&c[2]) {
				let bytes = if zlib { b } else { unbase64(std::str::from_utf8(&b).unwrap()) };
				let mut z = flate2::read::ZlibDecoder::new(&bytes[..]);
				z.read_to_end(&mut raw).unwrap();
			}
			out.push((std::str::from_utf8(&c[1]).unwrap().parse().unwrap(), raw));
		}
	}
	out
}

/// The Lua 5.1 string literals of a table constructor's items, their escapes (\ddd, \\, \") undone.
fn literals(s: &[u8]) -> Vec<Vec<u8>> {
	let mut out = Vec::new();
	let mut i = 0;
	while i < s.len() {
		if s[i] != b'"' {
			i += 1;
			continue;
		}
		let mut lit = Vec::new();
		i += 1;
		while s[i] != b'"' {
			if s[i] == b'\\' {
				if s[i + 1].is_ascii_digit() {
					let n = s[i + 1..].iter().take(3).take_while(|b| b.is_ascii_digit()).count();
					lit.push(std::str::from_utf8(&s[i + 1..i + 1 + n]).unwrap().parse::<u8>().unwrap());
					i += 1 + n;
				} else {
					lit.push(s[i + 1]);
					i += 2;
				}
			} else {
				lit.push(s[i]);
				i += 1;
			}
		}
		out.push(lit);
		i += 1;
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

// A walk inside one cluster, asked again every few steps as the player walks in (Nav/Walk.lua re-asks the arrow's walk
// from a new start): each ask used to flood the whole cluster from the start for its endpoint tree, 15,000 to 60,000
// expansions for a quest objective in the Barrens a few yards away (measured in game, 0.3.5). A direct walk under the
// least any way through the cluster's entrances could cost needs neither: the same walks and costs as the full search
// (Path.direct = false), a small part of the expansions.
#[test]
fn a_walk_inside_one_cluster_asked_again_as_the_player_walks_in_is_the_full_search_s_walk_without_its_flood() {
	let got = run(
		r#"
local Path = Polestar_NavEngine
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local function drain() while #frames > 0 do table.remove(frames, 1)() end end
local goal = { x = 825.397, y = -2686.950, z = 91.6 } -- a Barrens quest objective, east of the Crossroads
local away = { x = 800.107, y = -2717.360 } -- where the player came from
local dx, dy = away.x - goal.x, away.y - goal.y
local len = math.sqrt(dx * dx + dy * dy)
local opts = { profile = "Horde", style = "balanced" }
local function walkIn(direct)
	Path.direct = direct
	local exp, costs, points = 0, {}, {}
	for step = 0, 10 do
		local d = 60 - step * 5
		local from = { x = goal.x + dx / len * d, y = goal.y + dy / len * d, z = 92 }
		local got
		local job = Path.Find(1, from, goal, function(pts, cost) got = { pts = pts, cost = cost } end, opts)
		drain()
		exp = exp + job.expansions
		costs[#costs + 1] = math.floor(got.cost * 1000 + 0.5)
		points[#points + 1] = #got.pts
	end
	return { expansions = exp, costs = costs, points = points }
end
local full = walkIn(false)
local direct = walkIn(true)
Path.direct = nil
emit({ full = full, direct = direct })"#,
		"",
		vec![Addon::name("Polestar_Nav")],
	);
	let (full, direct) = (&got["full"], &got["direct"]);
	assert_eq!(direct["costs"], full["costs"], "the same costs as the full search: {got}");
	assert_eq!(direct["points"], full["points"], "and the same walks: {got}");
	let (f, d) = (full["expansions"].as_i64().unwrap(), direct["expansions"].as_i64().unwrap());
	assert!(f > 100_000, "the full search floods the cluster each time: {f}");
	assert!(d * 20 < f, "the direct walk is a small part of it: {d} against {f}");
}

// The same across a cluster border: the Crossroads sits where four clusters meet, so most walks round its objectives
// cross one, and the start's tree still flooded its whole cluster each ask. It now stops at a cost radius that grows
// only while a cheaper walk could still leave through an entrance beyond it. Three asks the arrow made in game (0.3.5,
// a Horde level 17) toward one objective, with the costs the full search gave them then, at about 58,800 expansions.
#[test]
fn a_walk_across_a_cluster_border_asked_again_as_the_player_moves_floods_only_as_far_as_it_must() {
	let got = run(
		r#"
local Path = Polestar_NavEngine
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local function drain() while #frames > 0 do table.remove(frames, 1)() end end
local goal = { x = -406.9, y = -2645.4, z = 96.3 }
local opts = { profile = "Horde", style = "balanced" }
local exp, costs = 0, {}
for _, from in ipairs({ { x = -335.5, y = -2700.4, z = 94 }, { x = -450.5, y = -2669.5, z = 96 }, { x = -475.6, y = -2670.6, z = 96 } }) do
	local cost
	local job = Path.Find(1, from, goal, function(_, c) cost = c end, opts)
	drain()
	exp = exp + job.expansions
	costs[#costs + 1] = math.floor(cost * 1000 + 0.5) / 1000
end
emit({ expansions = exp, costs = costs })"#,
		"",
		vec![Addon::name("Polestar_Nav")],
	);
	assert_eq!(got["costs"], json!([136.544, 70.594, 85.165]), "the full search's walks: {got}");
	let e = got["expansions"].as_i64().unwrap();
	assert!(e < 25_000, "not three cluster floods ({e} expansions, about 58,800 before)");
}
