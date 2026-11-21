//! A hover in the settings window is instant: the pointer on a card, a row or a part of the preview only lights
//! it (a highlight, a border, the preview's lights for that setting, its tooltip); nothing is laid out or redrawn,
//! nothing is left running and nothing is allocated. Against the whole addon on the stubbed world, a guide open
//! and its window shown, the settings window on Theme > Colour, the pointer crossing in turn:
//!
//!   - the skin cards, one after another as along their row;
//!   - every row of the tab, the accent's and the class colour's among them (they light every part of the
//!     settings window drawn in the accent too: the window's accent parts are found once for the tab on screen);
//!   - the preview's parts that a click finds the setting of (its hotspots);
//!
//! each widget entered and left in the frame the next is entered. A hover's figure is its OnEnter and OnLeave and
//! every handler they run, in addon ms (the median hover of a sweep and its worst, the fastest of ROUNDS rounds,
//! the milliseconds scaled by the reference as settings-perf.rs scales them) and the addon's KiB (a run with
//! tests/lua/stub_alloc.lua, whose wrappers would slow every call, so apart from the timed run).
//!
//! Then: crossing the gap from one row to the next keeps the preview's lights on, and off every row they go out
//! a moment later; Install's look cards, crossed one after another, draw each look once in the large preview and
//! never the look in use between them, which comes back once the pointer is off them.
//!
//! Before (release/040-data on 2026-11-15, same setup): an accent row's hover 2.7 ms and 168 KiB (it walked the
//! whole settings window and gave every lit part a new border), a hotspot's 0.64 ms and 139 KiB (it searched every
//! page's settings for its own), Install's looks drew the look in use again between every two cards.
//! Measured after (reference 6.6-7.3 ms; lua5.1 and this harness): cards 0.04 ms, rows 0.07-0.09 ms (the accent's
//! 0.42-0.67 under load), hotspots 0.04 ms; cards and hotspots 0 KiB a hover, rows 0 KiB under the lua5.1
//! interpreter (tests/helpers/lua.js) and 0.6 KiB in this harness's in-process Lua.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

const ROUNDS: u32 = 3;
// Every hover's median, and the worst card and hotspot.
const HOVER_MS: f64 = 0.12;
// A row's worst: the accent's lights its ~70 parts in the preview and the window.
const ROW_WORST_MS: f64 = 0.8;
const HOVER_KIB: f64 = 1.0;
const WORST_KIB: f64 = 1.0;
// The reference's fastest timing where the budgets were set (as settings-perf.rs).
const REF_BASELINE: f64 = 6.95;
const CPU_CLOCK: bool = !cfg!(windows);

const SCRIPT: &str = r#"
local P, A = stub.profile, stub.alloc or { measure = function(fn) fn() return 0, 0 end }
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
-- A fresh install opens the install window first; a player in the settings has it closed.
if PolestarWelcome and PolestarWelcome:IsShown() then PolestarWelcome:Hide() end
assert(Polestar.UI.LoadOptions())
local UI, O, T, Anim = Polestar.UI, Polestar.UI.Options, Polestar.Theme, Polestar.Anim

local out = {}
local c0, c1 = os.clock(), os.clock()
while c1 == c0 do c1 = os.clock() end
out.resolution = math.min((c1 - c0) * 1000, 1)

-- perf.test.js's reference (as settings-perf.rs): 500 events to a plain handler doing addon-like work.
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

-- The pointer across `list` as it crosses a row of them: each one entered and
-- left in the frame the next is entered (adjacent widgets hand over without
-- a frame between). Per hover: addon ms (its OnEnter and OnLeave, every
-- handler they run) or, with the allocation stub loaded (its wrappers would
-- slow every call), the addon's KiB; the median hover and the worst. The
-- frames between hovers are not counted.
local function median(t)
	table.sort(t)
	return t[math.ceil(#t / 2)] or 0
end
local cur
local function hover()
	stub.RunScript(cur, "OnEnter")
	stub.RunScript(cur, "OnLeave")
end
local ALLOC = stub.alloc ~= nil
-- The stub's game tooltip keeps its lines in Lua tables (the client's in C):
-- the stub's share, as its frame methods are.
if ALLOC then
	for _, name in ipairs({ "SetOwner", "ClearLines", "AddLine", "AddDoubleLine", "SetText" }) do
		local fn = GameTooltip[name]
		GameTooltip[name] = function(...)
			local c = collectgarbage("count")
			fn(...)
			A.stub = A.stub + collectgarbage("count") - c
		end
	end
end
local function sweep(list)
	local vals = {}
	for k, f in ipairs(list) do
		cur = f
		collectgarbage("collect")
		if ALLOC then
			local _, own = A.measure(hover)
			vals[k] = own
		else
			local t0 = P.total()
			vals[k] = P.measure(hover) + P.total() - t0
		end
		stub.advance(0.016)
	end
	local worst = 0
	for k = 1, #vals do worst = math.max(worst, vals[k]) end
	return { n = #vals, median = median(vals), worst = worst }
end
-- The fastest of the rounds (other work on the machine only adds time; in
-- the allocation run every round alike).
local function best(key, r)
	local b = out[key]
	if not b then out[key] = r return end
	b.median, b.worst = math.min(b.median, r.median), math.min(b.worst, r.worst)
end

UI.ShowOptions("theme")
O.Select("theme", "Colour")
stub.advance(0.5)
local controls = O.Controls("theme", "Colour")
-- The skin cards, in their row's order.
local skin = controls["ui.skin"]
assert(skin and skin.psCardBy and skin:IsVisible(), "the skin cards are on screen")
local cards = {}
for _, ch in ipairs(T.SkinChoices()) do
	local c = skin.psCardBy[ch.value]
	if c and c:IsVisible() then cards[#cards + 1] = c end
end
-- Every row of the tab, the accent's (which lights every accent part of the settings window too) among them.
local rows = {}
for _, row in pairs(controls) do
	if row ~= skin and row:IsVisible() and (row.scripts.OnEnter or row.hooks.OnEnter) then rows[#rows + 1] = row end
end
table.sort(rows, function(a, b) return (a:GetTop() or 0) > (b:GetTop() or 0) end)
-- The preview's parts a click finds the setting of (its hotspots).
local spots = {}
for _, f in ipairs(stub.frames) do
	if rawget(f, "psSpot") and f:IsVisible() then spots[#spots + 1] = f end
end
out.counts = { cards = #cards, rows = #rows, spots = #spots }
assert(#cards >= 6 and #rows >= 8 and #spots >= 4, "the tab's widgets found")

-- Warm-up: first-time builds (the lights' frames, the tooltip) out of the way.
sweep(cards); sweep(rows); sweep(spots)
for _ = 1, ROUNDS do
	reference()
	best("cards", sweep(cards))
	best("rows", sweep(rows))
	best("spots", sweep(spots))
end
-- No motion left behind: a hover starts no tween or OnUpdate of its own.
stub.advance(0.5)
out.tweens = Anim.Active()

-- Hand-over: the pointer off the accent's row and onto the next across a
-- gap of a few frames, the preview's lights stay on and move to the next
-- setting's parts; off every row they go out a moment later.
local host = rawget(O.view, "PreviewHost")
local function litCount()
	local n = 0
	for _, l in ipairs(rawget(host, "psLitList") or {}) do if rawget(l, "psLit") then n = n + 1 end end
	return n
end
stub.RunScript(controls["ui.accent"], "OnEnter")
local onAccent = litCount()
stub.RunScript(controls["ui.accent"], "OnLeave")
stub.advance(0.05)
local inGap = litCount()
stub.RunScript(controls["ui.bgOpacity"], "OnEnter")
local onNext = litCount()
stub.RunScript(controls["ui.bgOpacity"], "OnLeave")
stub.advance(0.05)
local soon = litCount()
stub.advance(0.3)
out.handover = { onAccent = onAccent > 0, inGap = inGap == onAccent, onNext = onNext > 0, soon = soon == onNext, after = litCount() }

-- Install's looks: the pointer across the look cards, each one's gap crossed
-- in a few frames, draws each look under it once and never the look in use
-- between them; off the cards, the look in use comes back.
O.frame:Hide()
UI.Welcome.Show("look")
stub.advance(0.5)
local page = PolestarWelcome.pages.look.Body
local looks = {}
for _, r in ipairs(PolestarWelcome.Skins) do if r:IsShown() then looks[#looks + 1] = r end end
local draws, drawn = 0, {}
local draw = T.DrawSkinCard
T.DrawSkinCard = function(card, id, ...)
	if card == page.Preview.Art then
		draws = draws + 1
		drawn[#drawn + 1] = id
	end
	return draw(card, id, ...)
end
local inUse = T.SkinId()
local passed = 0
for _, r in ipairs(looks) do
	if r.psLook ~= inUse then
		stub.RunScript(r, "OnEnter")
		stub.advance(0.016)
		stub.RunScript(r, "OnLeave")
		stub.advance(0.05)
		passed = passed + 1
	end
end
local between = draws
stub.advance(0.3)
T.DrawSkinCard = draw
out.looks = { passed = passed, draws = between, back = page.PreviewName:GetText() == T.SkinInfo(inUse).name, inUseDrawn = drawn[#drawn] == inUse }
emit(out)
"#;

fn run(alloc: bool) -> Value {
	let mut stubs = vec!["stub_world.lua", "profile.lua"];
	if alloc {
		stubs.push("stub_alloc.lua");
	}
	emitted(&RunAddon { stubs, addons: vec![Addon::name("Polestar")], login: true, before: "stub.profile.start()".into(), script: SCRIPT.replace("ROUNDS", &ROUNDS.to_string()), ..Default::default() })
		.remove(0)
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap_or(f64::NAN)
}

#[test]
fn a_hover_in_the_settings_window_only_lights_what_it_is_on_in_budget_and_hands_over_without_blinking() {
	let out = run(false);
	let scale = (num(&out["reference"]) / REF_BASELINE).max(1.0);
	let slack = num(&out["resolution"]);
	let report = format!("measured {out}; reference scale {scale:.3}");
	if CPU_CLOCK {
		for key in ["cards", "rows", "spots"] {
			forge_addontest::assert_timing!(num(&out[key]["median"]) < HOVER_MS * scale + slack, "{key}: a hover over {HOVER_MS} ms: {report}");
		}
		for key in ["cards", "spots"] {
			forge_addontest::assert_timing!(num(&out[key]["worst"]) < HOVER_MS * scale + slack, "{key}: the slowest hover over {HOVER_MS} ms: {report}");
		}
		forge_addontest::assert_timing!(num(&out["rows"]["worst"]) < ROW_WORST_MS * scale + slack, "rows: the slowest hover over {ROW_WORST_MS} ms: {report}");
	}
	assert_eq!(out["tweens"], 0, "no motion left running after the hovers: {report}");
	let h = &out["handover"];
	assert_eq!((h["onAccent"].as_bool(), h["onNext"].as_bool()), (Some(true), Some(true)), "the rows light their parts: {report}");
	assert_eq!(h["inGap"], true, "the lights stay on while the pointer crosses to the next row: {report}");
	assert_eq!(h["soon"], true, "and just off a row: {report}");
	assert_eq!(h["after"], 0, "off every row they go out: {report}");
	let l = &out["looks"];
	assert!(num(&l["passed"]) >= 5.0, "Install's look cards crossed: {report}");
	assert_eq!(l["draws"], l["passed"], "each look drawn once, the look in use never between them: {report}");
	assert_eq!((l["back"].as_bool(), l["inUseDrawn"].as_bool()), (Some(true), Some(true)), "off the cards the look in use comes back: {report}");
	println!("{report}");

	let alloc = run(true);
	let report = format!("allocated {alloc}");
	for key in ["cards", "rows", "spots"] {
		assert!(num(&alloc[key]["median"]) <= HOVER_KIB, "{key}: a hover allocated: {report}");
		assert!(num(&alloc[key]["worst"]) <= WORST_KIB, "{key}: the worst hover allocated over {WORST_KIB} KiB: {report}");
	}
	println!("{report}");
}
