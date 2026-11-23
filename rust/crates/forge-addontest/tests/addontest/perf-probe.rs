//! The perf probe (addon/Polestar/Core/Perf.lua, /polestar perf): off, nothing of it runs (the dispatchers are the
//! plain ones and the clock is never read); on, a slow handler is recorded with its event or message, its own
//! time apart from what it ran inside it, many small handlers in one frame as one slow frame, the game's
//! profiler's figures and the addons it names to set Polestar's against; off again, the plain dispatchers come back; the
//! report window carries a compact section that still fits one Discord message; the probe's own cost per call
//! stays far under 0.05 ms.

use forge_addontest::{assert_timing, emitted, Addon, RunAddon};
use serde_json::Value;

const FILES: [&str; 3] = ["Core/Init.lua", "Core/Compat.lua", "Core/Perf.lua"];

// A clock the test moves: a handler "takes" the milliseconds it adds. `reads` counts every look at it.
const CLOCK: &str = r#"
local P = Polestar.Perf
local fake, reads = 0, 0
debugprofilestop = function() reads = reads + 1; return fake end
local function slow(ms) return function() fake = fake + ms end end
"#;

fn run(before: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon { before: before.into(), addons: vec![Addon::files("Polestar", &FILES)], login: true, script: format!("{CLOCK}\n{script}"), ..Default::default() })
}

fn texts(v: &Value) -> Vec<String> {
	v.as_array().map(|a| a.iter().map(|s| s.as_str().unwrap_or("").to_string()).collect()).unwrap_or_default()
}

#[test]
fn off_nothing_runs_and_on_off_puts_the_plain_dispatchers_back() {
	let out = run(
		"",
		r#"
local fire0, safeCall0 = Polestar.Fire, Polestar.SafeCall
Polestar.RegisterEvent("QUEST_LOG_UPDATE", slow(7))
Polestar.On("TEST_MSG", slow(3))
local f = CreateFrame("Frame")
f:SetScript("OnUpdate", Polestar.Safe(slow(1)))
local function play()
	Polestar.After(0, slow(4))
	stub.fire("QUEST_LOG_UPDATE")
	Polestar.Fire("TEST_MSG")
	stub.advance(0.2)
end
play()
emit({ reads = reads, calls = P.Calls(), ran = P.Ran(), on = P.IsOn(), plain = Polestar.Fire == fire0 and Polestar.SafeCall == safeCall0, spikes = #P.Spikes(), lines = P.ReportLines() == nil })
SlashCmdList.POLESTAR("perf")
local wrapped = Polestar.Fire ~= fire0 and Polestar.SafeCall ~= safeCall0
play()
SlashCmdList.POLESTAR("perf")
local calls, readsOff = P.Calls(), reads
play()
emit({ wrapped = wrapped, on = P.IsOn(), plain = Polestar.Fire == fire0 and Polestar.SafeCall == safeCall0, calls = calls, after = P.Calls(), still = reads == readsOff, ran = P.Ran() })
"#,
	);
	assert_eq!(out[0]["reads"], 0, "off, the probe never reads the clock: {}", out[0]);
	assert_eq!(out[0]["calls"], 0, "off, nothing is timed: {}", out[0]);
	assert_eq!(out[0]["ran"], false);
	assert_eq!(out[0]["on"], false, "off by default");
	assert_eq!(out[0]["plain"], true, "off, Fire and SafeCall are the plain ones");
	assert_eq!(out[0]["spikes"], 0);
	assert_eq!(out[0]["lines"], true, "no report section before the probe ran");
	assert_eq!(out[1]["wrapped"], true, "on, the dispatchers are the probe's");
	assert_eq!(out[1]["on"], false, "/polestar perf twice turns it off again");
	assert_eq!(out[1]["plain"], true, "off again, the plain dispatchers are back");
	assert!(out[1]["calls"].as_i64().unwrap_or(0) >= 4, "on, the event, message, OnUpdate and timer handlers were timed: {}", out[1]);
	assert_eq!(out[1]["after"], out[1]["calls"], "off again, nothing more is timed");
	assert_eq!(out[1]["still"], true, "off again, the clock is not read");
	assert_eq!(out[1]["ran"], true, "what it measured stays for the report");
}

#[test]
fn on_a_slow_handler_is_recorded_with_its_event_and_context() {
	let out = run(
		r#"C_Map = { GetBestMapForUnit = function() return 1429 end }"#,
		r##"
Polestar.RegisterEvent("QUEST_LOG_UPDATE", slow(0.1))
local seven = slow(7)
Polestar.RegisterEvent("QUEST_LOG_UPDATE", seven)
Polestar.On("TEST_MSG", slow(3))
-- A handler that fires a message inside it: its own time leaves out the message's.
Polestar.RegisterEvent("PLAYER_TARGET_CHANGED", function() fake = fake + 1; Polestar.Fire("TEST_MSG") end)
-- A unit event asked for the player alone (its own bus).
Polestar.RegisterEvent("UNIT_AURA", slow(2.5), "player")
SlashCmdList.POLESTAR("perf")
-- Made while the probe is on: named by where it was made.
debugstack = function() return '[string "@Interface/AddOns/Polestar/Core/Perf.lua"]:1: in function\n[string "@Interface/AddOns/Polestar/Core/Init.lua"]:2: in function\n[string "@Interface/AddOns/Polestar/Quests/Fake.lua"]:42: in function <x>\n' end
Polestar.After(0, slow(4))
debugstack = nil
stub.inCombat = true
stub.fire("QUEST_LOG_UPDATE")
stub.inCombat = false
stub.fire("PLAYER_TARGET_CHANGED")
stub.fire("UNIT_AURA", "player")
stub.advance(0.1)
local spikes = {}
for _, e in ipairs(P.Spikes()) do
	if not e.slow then spikes[#spikes + 1] = { kind = e.kind, where = e.where, ms = e.ms, own = e.own, depth = e.depth, combat = e.combat, map = e.map } end
end
local stats = {}
for name, s in pairs(P.Stats()) do stats[#stats + 1] = name .. " n=" .. s.n end
table.sort(stats)
local at, of = Polestar.HandlerPlace(1, "QUEST_LOG_UPDATE", seven)
emit({ spikes = spikes, stats = stats, report = P.ReportText(), lines = P.ReportLines(), place = "#" .. at .. "/" .. of, last = at == of })
"##,
	);
	let spikes = out[0]["spikes"].as_array().expect("spikes");
	let find = |kind: i64, ms: f64| spikes.iter().find(|e| e["kind"] == kind && (e["ms"].as_f64().unwrap_or(0.0) - ms).abs() < 1e-6);
	let ev = find(1, 7.0).unwrap_or_else(|| panic!("the 7 ms QUEST_LOG_UPDATE handler is a spike: {spikes:?}"));
	assert_eq!(ev["where"], "QUEST_LOG_UPDATE");
	assert_eq!(ev["combat"], true, "in combat then");
	assert_eq!(ev["map"], 1429);
	assert!(find(1, 0.1).is_none(), "a 0.1 ms call is no spike");
	let msg = spikes.iter().find(|e| e["kind"] == 2 && e["depth"] == 2).unwrap_or_else(|| panic!("the message inside the target handler: {spikes:?}"));
	assert_eq!(msg["where"], "TEST_MSG");
	let outer = find(1, 4.0).unwrap_or_else(|| panic!("the target handler, 1 ms of its own and the 3 ms message: {spikes:?}"));
	assert_eq!(outer["where"], "PLAYER_TARGET_CHANGED");
	assert!((outer["own"].as_f64().unwrap() - 1.0).abs() < 1e-6, "its own time leaves the message out: {outer}");
	assert!(find(3, 4.0).is_some(), "the timer is a spike: {spikes:?}");
	assert!(spikes.iter().any(|e| e["kind"] == 1 && e["where"] == "UNIT_AURA"), "a unit event on its own bus is timed too: {spikes:?}");
	let report = out[0]["report"].as_str().unwrap();
	assert!(report.contains("timer Quests/Fake.lua:42 4.0 ms"), "a timer made while on is named by where it was made: {report}");
	let place = out[0]["place"].as_str().unwrap();
	assert_eq!(out[0]["last"], true, "the 7 ms handler is its event's last: {place}");
	let at = format!("QUEST_LOG_UPDATE {place} 7.0 ms (own 7.0) · ");
	assert!(report.contains(&at) && report.contains("combat map 1429"), "an earlier handler by its place among its event's, with the context: {report}");
	assert!(report.contains("msg TEST_MSG"), "{report}");
	let lines = texts(&out[0]["lines"]);
	assert!(lines[0].starts_with("Perf: on "), "{lines:?}");
	assert!(lines.iter().any(|l| l.starts_with(&format!("  worst call: QUEST_LOG_UPDATE {place} 7.0 ms"))), "{lines:?}");
	assert!(lines.iter().all(|l| !regex::Regex::new(r"^\s+\d+x ").unwrap().is_match(l)), "no line reads as an error line to the Discord bot: {lines:?}");
}

#[test]
fn many_small_handlers_in_one_frame_are_one_slow_frame() {
	let out = run(
		"",
		r#"
for i = 1, 10 do Polestar.RegisterEvent("UNIT_INVENTORY_CHANGED", slow(0.6)) end
SlashCmdList.POLESTAR("perf")
stub.advance(0.05)
stub.fire("UNIT_INVENTORY_CHANGED")
stub.advance(0.05)
local frames, calls = {}, 0
for _, e in ipairs(P.Spikes()) do
	if e.slow then frames[#frames + 1] = { ms = e.ms, calls = e.calls, top = #e.top } else calls = calls + 1 end
end
emit({ frames = frames, calls = calls })
"#,
	);
	assert_eq!(out[0]["calls"], 0, "no single call reached 2 ms: {}", out[0]);
	let frames = out[0]["frames"].as_array().unwrap();
	assert_eq!(frames.len(), 1, "{frames:?}");
	assert!((frames[0]["ms"].as_f64().unwrap() - 6.0).abs() < 1e-6, "{frames:?}");
	assert_eq!(frames[0]["calls"], 10);
	assert_eq!(frames[0]["top"], 3, "its three slowest calls");
}

#[test]
fn coalesced_refreshes_go_by_where_they_were_made_and_the_router_s_slices_are_timed() {
	let out = run(
		r#"Polestar_NavEngine = { after = function(fn) C_Timer.After(0, fn) end }"#,
		r#"
local plainAfter = Polestar_NavEngine.after
-- A QoL.Coalesce made at load, from Buttons.lua (the stack as the client gives it).
debugstack = function() return '[string "@Interface/AddOns/Polestar/Core/Init.lua"]:1: in function\n[string "@Interface/AddOns/Polestar/QoL/QoL.lua"]:333: in function\n[string "@Interface/AddOns/Polestar/QoL/Buttons.lua"]:3580: in main chunk\n' end
local run = Polestar.NoteMadeAt(slow(3), "Polestar/QoL/QoL.lua")
debugstack = function() return '[string "@Interface/AddOns/Polestar_Nav/Routing/PathJobs.lua"]:43: in function\n' end
SlashCmdList.POLESTAR("perf")
local wrapped = Polestar_NavEngine.after ~= plainAfter
C_Timer.After(0, function() Polestar.SafeCall(run) end)
Polestar_NavEngine.after(slow(2.5))
stub.advance(0.05)
SlashCmdList.POLESTAR("perf")
emit({ wrapped = wrapped, back = Polestar_NavEngine.after == plainAfter, report = P.ReportText() })
"#,
	);
	assert_eq!(out[0]["wrapped"], true, "on, the router's Path.after is timed");
	assert_eq!(out[0]["back"], true, "off, the router's own Path.after is back");
	let report = out[0]["report"].as_str().unwrap();
	assert!(report.contains("call QoL/Buttons.lua:3580 3.0 ms"), "a coalesced refresh by the line that made it: {report}");
	assert!(report.contains("timer Polestar_Nav/Routing/PathJobs.lua:43 2.5 ms"), "a router slice: {report}");
}

#[test]
fn the_profiler_s_figures_and_the_addons_it_names_go_in_the_report() {
	let out = run(
		r#"
rawset(Enum, "AddOnProfilerMetric", { SessionAverageTime = 0, RecentAverageTime = 1, EncounterAverageTime = 2, LastTime = 3, PeakTime = 4,
	CountTimeOver1Ms = 5, CountTimeOver5Ms = 6, CountTimeOver10Ms = 7, CountTimeOver50Ms = 8, CountTimeOver100Ms = 9, CountTimeOver500Ms = 10, CountTimeOver1000Ms = 11 })
prof = { last = 0, app = 16, over10 = 2 }
C_AddOnProfiler = {
	IsEnabled = function() return true end,
	GetAddOnMetric = function(name, m) if m == 3 then return prof.last elseif m == 7 then return prof.over10 elseif m == 4 then return 46 end return 0.25 end,
	GetOverallMetric = function(m) if m == 3 then return prof.last + 1 end return 1 end,
	GetApplicationMetric = function(m) if m == 3 then return prof.app end return 2 end,
	GetTopKAddOnsForMetric = function(m, k) return { { addOnName = "OtherAddon", metricValue = 12.5 }, { addOnName = "Polestar", metricValue = 3 } } end,
}"#,
		r#"
SlashCmdList.POLESTAR("perf")
-- One frame where Polestar's own frames took 20 ms outside any handler the probe wraps, in an 80 ms game frame.
prof.last, prof.app = 20, 80
stub.advance(0.05)
prof.last, prof.app, prof.over10 = 0, 16, 9
stub.advance(6)
emit({ report = P.ReportText(), lines = P.ReportLines() })
"#,
	);
	let report = out[0]["report"].as_str().unwrap();
	assert!(report.contains("  Polestar: avg 0.25 peak 46.0 >5ms 0 >10ms 7 >50ms 0 >100ms 0"), "frames over 10 ms since the probe started: {report}");
	assert!(report.contains("top peak: OtherAddon 12.5, Polestar 3.0"), "{report}");
	assert!(report.contains("frame 0.0 ms in 0 calls (profiler: Polestar 20.0, addons 21.0, game 80.0)"), "time outside the wrapped handlers shows: {report}");
	assert!(report.contains("1 game hitches over 50 ms (Polestar in 1)"), "{report}");
	let lines = texts(&out[0]["lines"]);
	assert!(lines.iter().any(|l| l.starts_with("  profiler: Polestar avg 0.25") && l.contains("most >10ms: OtherAddon 12")), "{lines:?}");
}

// #3640 (Fitz's 0.4.2.2 report): "timer ?" x3 and "call ?" with a 126.8 ms max, and a 416 ms frame with no name. The
// OnUpdate scripts and tickers made as the addon loads (before anyone turns the probe on) and every ticker go by
// where they were made; a SafeCall'd function by where it was called; a slow frame no handler accounts for says what
// else happened in it (an addon loaded, a collection).
#[test]
fn handlers_made_before_the_probe_and_safecalled_functions_have_names_and_a_slow_frame_says_what_else_ran() {
	let out = emitted(&RunAddon {
		before: r#"
rawset(Enum, "AddOnProfilerMetric", { SessionAverageTime = 0, RecentAverageTime = 1, EncounterAverageTime = 2, LastTime = 3, PeakTime = 4,
	CountTimeOver1Ms = 5, CountTimeOver5Ms = 6, CountTimeOver10Ms = 7, CountTimeOver50Ms = 8, CountTimeOver100Ms = 9, CountTimeOver500Ms = 10, CountTimeOver1000Ms = 11 })
prof = { last = 0, app = 16 }
C_AddOnProfiler = {
	IsEnabled = function() return true end,
	GetAddOnMetric = function(name, m) if m == 3 then return prof.last end return 0 end,
	GetOverallMetric = function(m) if m == 3 then return prof.last end return 0 end,
	GetApplicationMetric = function(m) if m == 3 then return prof.app end return 0 end,
	GetTopKAddOnsForMetric = function() return {} end,
}"#
		.into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		login: false,
		script: format!(
			"{CLOCK}\n{}",
			r#"
local function at(file, line) return function() return '[string "@Interface/AddOns/Polestar/Core/Init.lua"]:1: in function\n[string "@Interface/AddOns/Polestar/' .. file .. '"]:' .. line .. ': in main chunk\n' end end
-- Made as the addon loads: an OnUpdate script.
debugstack = at("UI/NameTargets.lua", 183)
local f = CreateFrame("Frame")
f:SetScript("OnUpdate", Polestar.Safe(slow(2.5)))
stub.login()
-- After login: a ticker (named), and a plain ns.Safe made while the probe is off (gone soon, not noted).
debugstack = at("Nav/Nav.lua", 322)
Polestar.NewTicker(0.05, slow(2.4))
debugstack = at("QoL/Breath.lua", 98)
local g = CreateFrame("Frame")
g:SetScript("OnUpdate", Polestar.Safe(slow(2.125)))
SlashCmdList.POLESTAR("perf")
-- On: a function made anywhere, run through SafeCall from Nav.lua's module loop.
debugstack = at("Nav/Nav.lua", 211)
Polestar.SafeCall(slow(2.75))
stub.advance(0.05)
f:SetScript("OnUpdate", nil)
g:SetScript("OnUpdate", nil)
stub.advance(0.2)
-- A frame where Polestar took 300 ms outside any handler, a continent pack loading in it.
prof.last, prof.app = 300, 320
stub.fire("ADDON_LOADED", "Polestar_Nav_EK")
stub.advance(0.05)
prof.last, prof.app = 0, 16
SlashCmdList.POLESTAR("perf")
emit({ report = P.ReportText() })
"#
		),
		..Default::default()
	});
	let report = out[0]["report"].as_str().unwrap();
	assert!(report.contains("timer UI/NameTargets.lua:183 2.5 ms"), "an OnUpdate made at load by its line: {report}");
	assert!(report.contains("timer Nav/Nav.lua:322 2.4 ms"), "a ticker by its line: {report}");
	assert!(report.contains("call Nav/Nav.lua:211 2.8 ms"), "a SafeCall'd function by the line that called it: {report}");
	assert!(report.contains("ms outside the handlers; loaded Polestar_Nav_EK"), "a slow frame outside the handlers says what loaded: {report}");
	let unnamed = report.lines().filter(|l| l.contains(" ? ")).collect::<Vec<_>>();
	assert!(!unnamed.is_empty() && unnamed.iter().all(|l| l.contains("timer ? 2.1")), "only the plain ns.Safe made after login with the probe off is unnamed: {unnamed:?}");
}

#[test]
fn the_probe_costs_far_under_a_twentieth_of_a_millisecond_a_call() {
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &FILES)],
		login: true,
		script: r#"
local P = Polestar.Perf
debugprofilestop = function() return os.clock() * 1000 end
local n = 0
for i = 1, 20 do Polestar.RegisterEvent("BAG_UPDATE", function() n = n + 1 end) end
local function burst()
	local t = os.clock()
	for i = 1, 2000 do stub.fire("BAG_UPDATE") end
	return (os.clock() - t) * 1000
end
local plain = burst()
P.Start()
local probed = burst()
emit({ cost = P.Cost(), added = (probed - plain) / 40000, n = n })
"#
		.into(),
		..Default::default()
	});
	assert_eq!(out[0]["n"], 80000);
	let cost = out[0]["cost"].as_f64().unwrap();
	let added = out[0]["added"].as_f64().unwrap();
	println!("perf probe: {cost} ms a call by its own measure, {added} ms a call more than off");
	assert_timing!(cost < 0.05, "the probe's own measure of its cost: {cost} ms a call");
	assert_timing!(added < 0.05, "measured on 40000 handler calls: {added} ms a call more than off");
}

#[test]
fn the_report_window_carries_the_perf_section_and_still_fits_discord() {
	let script = r#"
uistub.install()
stub.login()
local P, R = Polestar.Perf, Polestar.UI.Report
local fake = 0
debugprofilestop = function() return fake end
local before = R.Details()
Polestar.RegisterEvent("QUEST_LOG_UPDATE", function() fake = fake + 41.3 end)
SlashCmdList.POLESTAR("perf")
stub.fire("QUEST_LOG_UPDATE")
stub.advance(0.05)
local d = R.Details()
local perf = {}
for i, line in ipairs(d.lines) do
	if d.kinds[i] == "perf" or d.kinds[i] == "perfhead" then perf[#perf + 1] = line end
end
local beforePerf = 0
for i = 1, #before.lines do if before.kinds[i] == "perf" or before.kinds[i] == "perfhead" then beforePerf = beforePerf + 1 end end
emit({ beforePerf = beforePerf, perf = perf, short = R.Text("Stutters after every kill.", d),
	long = R.Text(string.rep("Stutters after every kill. ", 37), d) })
"#;
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_encoding.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml", "UI/UI.xml"])],
		script: script.into(),
		..Default::default()
	});
	assert_eq!(out[0]["beforePerf"], 0, "no perf lines before the probe ran");
	let perf = texts(&out[0]["perf"]);
	assert!(perf[0].starts_with("Perf: on "), "{perf:?}");
	assert!(perf.iter().any(|l| l.contains("QUEST_LOG_UPDATE") && l.contains("41.3 ms")), "{perf:?}");
	let short = out[0]["short"].as_str().unwrap();
	assert!(short.contains("Perf: on ") && short.contains("41.3 ms"), "a short report keeps the perf section: {short}");
	let long = out[0]["long"].as_str().unwrap();
	assert!(long.chars().count() <= 2000, "the longest report still fits one Discord message: {} characters", long.chars().count());
}
