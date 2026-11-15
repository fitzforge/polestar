//! A setting changed with the settings window open stays smooth: a dragged slider writes each value live
//! (ns.Live), what shows follows on the next frame from a repaint of colours alone (Theme's live repaint), and
//! the layouts, redraws and marks wait for the drag's end, which settles it with one full refresh. Against the
//! whole addon on the stubbed world, a guide open and its window shown, the settings window open on the
//! slider's own tab. Addon time is CPU time inside handlers, OnUpdate scripts and timers plus the drag's own
//! calls (tests/lua/profile.lua); allocations are what the Lua state allocated with the collector stopped.
//!
//!   - the Theme page's Background (ui.bgOpacity) dragged through 30 values, one a frame: each step, with the
//!     frame after it, under STEP_MS and STEP_KIB; one live repaint a frame, no full refresh until the drag
//!     ends and one when it does; the guide window's ground takes each value on the frame it is written;
//!   - three values within one frame repaint once;
//!   - the Guide window page's own Background (guideWindow.bgOpacity) and its Opacity: each step under
//!     GW_STEP_MS and GW_STEP_KIB, the window following each value.
//!
//! Each figure is the median step of a round, the fastest of ROUNDS rounds (other work on the machine only
//! ever adds time). The milliseconds are held where os.clock() is CPU time, scaled as perf.test.js scales its
//! budgets: by max(1, reference / REF_BASELINE), the reference being 500 events through the same event path to
//! a plain handler (its timing on the machine the budgets were set on: REF_BASELINE). Before live writes a
//! Background step cost 50 ms and 3.5 MiB here, a Guide window page step 13 ms and 0.8 MiB (dev-040 on
//! 2026-11-15, the same setup in a quiet moment: 28 ms and 3.2 MiB a Background step).
//!
//! Measured 2026-11-15 with nothing else queued on the machine (reference 6.95 ms): Background 1.98 ms and
//! 151 KiB a step, the Guide window page's own Background 0.43 ms and 20 KiB, its Opacity 0.29 ms and 5 KiB.
//! The KiB are all the Lua state allocated, this stub's frame tables included (the client keeps those in C).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

const ROUNDS: u32 = 3;
const STEP_MS: f64 = 2.5;
const STEP_KIB: f64 = 170.0;
const GW_STEP_MS: f64 = 0.6;
const GW_STEP_KIB: f64 = 24.0;
// The reference's fastest timing where the budgets were set (i7-10700K, Linux, the harness's Lua 5.1).
const REF_BASELINE: f64 = 6.95;
const CPU_CLOCK: bool = !cfg!(windows);

const SCRIPT: &str = r#"
local P = stub.profile
stub.advance(1)
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
assert(Polestar.RegisterGuide({ id = "test/perf", pack = "test", title = "Perf", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Marshal McBride", goals = {
		{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		{ t = "accept", quest = 33, title = "Wolves Across the Border", npc = 196, npcName = "Eagan Peltskinner", map = 1429, x = 48.1, y = 42.6 },
	} },
	{ title = "Kobolds", goals = { { t = "kill", quest = 7, obj = 1, target = "Kobold Vermin", npc = 6, map = 1429, x = 47, y = 35 } } },
} }))
Polestar.Engine.SetGuide("test/perf")
stub.fire("QUEST_LOG_UPDATE")
stub.advance(3)
-- A fresh install opens the install window first; a player changing settings has it closed.
if PolestarWelcome and PolestarWelcome:IsShown() then PolestarWelcome:Hide() end
assert(Polestar.UI.LoadOptions())
local UI, O, T = Polestar.UI, Polestar.UI.Options, Polestar.Theme
local F = PolestarGuideFrame
assert(F and F:IsVisible(), "the guide window is shown")

local out = {}
local c0, c1 = os.clock(), os.clock()
while c1 == c0 do c1 = os.clock() end
out.resolution = math.min((c1 - c0) * 1000, 1)

-- perf.test.js's reference: 500 events through the same event path to a
-- plain handler doing addon-like work (here timed over 5,000).
local refFrame = CreateFrame("Frame")
refFrame:RegisterEvent("POLESTAR_TEST_REFERENCE")
local refText = { "Kobold Vermin slain: 3/10", "Gold Dust: 1/5", "Tough Wolf Meat: 4/8", "Plainstrider Beak: 0/7",
	"Bring the meat to Grull Hawkwind", "Speak with Thrall in Orgrimmar", "Zhevra Hooves: 2/4", "Explore the Crossroads" }
refFrame:SetScript("OnEvent", function(_, _, i)
	local rows = {}
	for k = 1, #refText do
		local text = refText[k]
		local name, have, need = text:match("^(.-): (%d+)/(%d+)$")
		rows[k] = { name = name or text, done = have ~= nil and tonumber(have) >= tonumber(need), key = (text:lower():gsub("%W", "")) }
	end
	table.sort(rows, function(a, b) return a.key < b.key end)
	local dx, dy = i % 100 - 50, i % 37 - 18
	return string.format("%s (%s) %.1f yd", rows[1].name, rows[1].done and "done" or "open", math.sqrt(dx * dx + dy * dy))
end)
out.reference = math.huge
local function reference()
	collectgarbage("collect")
	local t = P.total()
	for i = 1, 5000 do stub.fire("POLESTAR_TEST_REFERENCE", i) end
	out.reference = math.min(out.reference, (P.total() - t) / 10)
end

-- Full refreshes (Theme.Refresh) and live repaints (the listeners told with Theme.LiveChanged).
local fulls, lives = 0, 0
local refresh = T.Refresh
T.Refresh = function(...) fulls = fulls + 1; return refresh(...) end
T.OnChanged(function() if T.LiveChanged() then lives = lives + 1 end end)

-- One step: fn (the drag's own calls and every handler they run) and the
-- frame after it, in addon ms and KiB allocated.
local function step(fn)
	collectgarbage("collect")
	collectgarbage("stop")
	local k0 = collectgarbage("count")
	local t = P.total()
	local ms = P.measure(fn)
	stub.advance(0.016)
	ms = ms + P.total() - t
	local kib = collectgarbage("count") - k0
	collectgarbage("restart")
	return ms, kib
end
local function median(list)
	table.sort(list)
	return list[math.ceil(#list / 2)]
end
local function bounce(lo, hi, st, from, n)
	local list, v, dir = {}, from, -1
	for k = 1, n do
		v = v + dir * st
		if v < lo - 1e-9 then v, dir = lo + st, 1 end
		if v > hi + 1e-9 then v, dir = hi - st, -1 end
		list[k] = math.floor(v / st + 0.5) * st
	end
	return list
end
-- The ground's opacity the guide window shows (its skin's ground texture).
local function groundAlpha() return F.psSkin.bg.vertexColor[4] end

-- Live writes (SETTING_CHANGED heard while Polestar.SettingLive()).
local writes = 0
Polestar.On("SETTING_CHANGED", function() if Polestar.SettingLive() then writes = writes + 1 end end)

-- A drag of row's slider through `values`, one a frame: the median step's ms
-- and KiB (the release aside), the frames it wrote a value in, the full
-- refreshes and live repaints on the way, the full ones its end brought, and
-- the frames where what shows (shows(v)) did not follow the value.
local function drag(row, values, shows)
	local s = row.Slider
	local ms, kib, wrong, written = {}, {}, 0, 0
	local f0, l0 = fulls, lives
	stub.RunScript(s, "OnMouseDown", "LeftButton")
	for k, v in ipairs(values) do
		local w0 = writes
		ms[k], kib[k] = step(function()
			s.value = v
			s:GetScript("OnValueChanged")(s, v, true)
		end)
		if writes > w0 then written = written + 1 end
		if shows and not shows(v) then wrong = wrong + 1 end
	end
	local duringFull, duringLive = fulls - f0, lives - l0
	stub.RunScript(s, "OnMouseUp", "LeftButton")
	stub.advance(0.1)
	return { ms = median(ms), kib = median(kib), written = written, full = duringFull, live = duringLive,
		settled = fulls - f0 - duringFull, wrong = wrong }
end
local function best(key, r)
	local b = out[key]
	if not b or r.ms < b.ms then out[key] = r end
end

UI.ShowOptions("theme")
O.Select("theme", "Colour")
stub.advance(0.5)
local bg = O.Controls("theme", "Colour")["ui.bgOpacity"]
assert(bg and bg.Slider and bg:IsVisible(), "the Background slider is on screen")
for _ = 1, ROUNDS do
	reference()
	best("theme", drag(bg, bounce(0, 1, 0.05, Polestar.Get("ui.bgOpacity"), 30), function() return math.abs(groundAlpha() - T.GroundAlpha()) < 1e-6 end))
end
out.themeValue = Polestar.Get("ui.bgOpacity")

-- Three values within one frame: one live repaint.
do
	local s, l0 = bg.Slider, lives
	stub.RunScript(s, "OnMouseDown", "LeftButton")
	for f = 1, 10 do
		for k = 1, 3 do
			local v = (f * 3 + k) % 20 * 0.05
			s.value = v
			s:GetScript("OnValueChanged")(s, v, true)
		end
		stub.advance(0.016)
	end
	out.coalesced = lives - l0
	stub.RunScript(s, "OnMouseUp", "LeftButton")
	stub.advance(0.1)
end

UI.ShowOptions("guidewindow")
O.Select("guidewindow", "Window")
stub.advance(0.5)
local controls = O.Controls("guidewindow", "Window")
local own, opacity = controls["guideWindow.bgOpacity"], controls["ui.opacity"]
assert(own and own:IsVisible() and opacity and opacity:IsVisible(), "the Guide window page's sliders are on screen")
for _ = 1, ROUNDS do
	reference()
	best("own", drag(own, bounce(0, 1, 0.05, 0.9, 30), function()
		local a = tonumber(Polestar.Get("guideWindow.bgOpacity"))
		return F.psBgAlpha == a and math.abs(groundAlpha() - a) < 1e-6
	end))
	best("opacity", drag(opacity, bounce(0.3, 1, 0.05, 1, 30), function()
		return math.abs(F:GetAlpha() - Polestar.Get("ui.opacity")) < 1e-6
	end))
end
emit(out)
"#;

fn run() -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "profile.lua"],
		addons: vec![Addon::name("Polestar")],
		login: true,
		before: "stub.profile.start()".into(),
		script: SCRIPT.replace("ROUNDS", &ROUNDS.to_string()),
		..Default::default()
	})
	.remove(0)
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap_or(f64::NAN)
}

#[test]
fn a_dragged_slider_repaints_once_a_frame_within_budget_and_lays_out_once_when_it_ends() {
	let out = run();
	let scale = (num(&out["reference"]) / REF_BASELINE).max(1.0);
	let slack = num(&out["resolution"]);
	let report = format!("measured {out}; reference scale {scale:.3}");
	for (key, ms, kib) in [("theme", STEP_MS, STEP_KIB), ("own", GW_STEP_MS, GW_STEP_KIB), ("opacity", GW_STEP_MS, GW_STEP_KIB)] {
		let r = &out[key];
		if CPU_CLOCK {
			assert!(num(&r["ms"]) < ms * scale + slack, "{key}: a drag step over {ms} ms: {report}");
		}
		assert!(num(&r["kib"]) < kib, "{key}: a drag step allocated over {kib} KiB: {report}");
		assert_eq!(r["full"], 0, "{key}: no full refresh while the drag goes on: {report}");
		assert_eq!(r["settled"], if key == "theme" { 1 } else { 0 }, "{key}: one full refresh when a theme drag ends: {report}");
	}
	let written = num(&out["theme"]["written"]);
	assert!(written >= 25.0, "the Background drag wrote its values: {report}");
	assert_eq!(num(&out["theme"]["live"]), written, "one live repaint a frame the drag wrote in: {report}");
	for key in ["theme", "own", "opacity"] {
		assert_eq!(out[key]["wrong"], 0, "{key}: the guide window showed every value on the frame it was written: {report}");
	}
	assert_eq!(out["coalesced"], 10, "three values within a frame repaint once: {report}");
	println!("{report}");
}
