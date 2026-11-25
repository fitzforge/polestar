//! A guide that is no leveling guide (a Lookup pick-up guide, a class or dungeon guide) asks on every evaluation
//! whether an accept before the current step waits for a level (Engine Own.levelHold, Own.holdsBefore). Each
//! accept's prerequisites are followed down their chains (unavailableFor -> Own.preBlocked -> Own.coming ->
//! unavailableFor of the turn-in ...). Krol'dok Stronghold's pick-up guide with the 0.4.1 Codex (a Scourge Rogue
//! 43, Riverglades; a player's stutter "in combat", 17 Nov) has chains whose quests need several of the
//! earlier ones (`preAll`), so every chain was followed again from each accept: ~2,900 calls and 20-25 ms in the
//! frame of every kill. Within one pass nothing it reads changes, so each quest's Own.coming is worked out once.
//! The guide below is that pick-up guide's shape (its quests, prerequisites and levels as the Codex gave them).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::Value;

const WORLD: &str = r#"
local w = stub.world
w.addMap(2548, { name = "Riverglades", c = 0, left = -1891.666, right = -6741.666, top = -6466.666, bottom = -9700 })
w.moveTo(2548, 76.72, 59.69)
w.race, w.raceName, w.faction, w.class, w.className = "Scourge", "Undead", "Horde", "ROGUE", "Rogue"
"#;

// Krol'dok Stronghold: pick up the quests (lookup/pickup/kroldok-stronghold, 0.4.1 Codex), and two more shapes:
// the same chain as a dungeon guide with a quest of it in the log, and a class guide whose quests each need the
// two before them.
const GUIDES: &str = r#"
local n = 0
local function A(q, min, pre, preAll) n = n + 1; return { t = "accept", quest = q, title = "Quest " .. q, npc = 260000 + n, npcName = "Giver " .. n, minLevel = min, pre = pre, preAll = preAll, map = 2548, x = 40 + n % 30, y = 30 + n % 20 } end
local function T(q) n = n + 1; return { t = "turnin", quest = q, title = "Quest " .. q, npc = 260000 + n, npcName = "Ender " .. n, map = 2548, x = 41 + n % 30, y = 31 + n % 20 } end
local function K(q, oi) return { t = "kill", target = "Mob " .. q, count = 6, quest = q, oi = oi or 1, map = 2548, x = 50, y = 50 } end
local function C(q, oi) return { t = "collect", item = 900000 + q, itemName = "Item " .. q, count = 6, quest = q, oi = oi or 1, map = 2548, x = 52, y = 52 } end
local function S(q) return { t = "talk", npc = 270000 + q, npcName = "Talker", quest = q, oi = 1, map = 2548, x = 55, y = 55 } end
local function D(q) return { t = "complete", quest = q, title = "Quest " .. q, map = 2548, x = 56, y = 56 } end
local function kroldok(id, category)
	n = 0
	return { id = id, pack = "test", title = "Krol'dok Stronghold: pick up the quests", category = category, faction = "Horde", minLevel = 35, maxLevel = 47, steps = {
		{ goals = { A(93787, 36), C(93787) } },
		{ goals = { A(93786, 35), K(93786), T(93786) } },
		{ goals = { T(93787) } },
		{ goals = { A(94483, 36, nil, { 93786, 93787 }), K(94483), K(94483, 2), T(94483) } },
		{ goals = { A(94672, 36, { 94483 }), K(94672), K(94672, 2), K(94672, 3) } },
		{ goals = { A(94680, 36, { 94483 }), C(94680) } },
		{ goals = { T(94672), T(94680) } },
		{ goals = { A(94727, 36, { 94680 }, { 94672, 94680 }), S(94727), T(94727) } },
		{ goals = { A(95417, 36, { 94727 }) } },
		{ goals = { A(95602, 36, { 94727 }), D(95602), T(95602) } },
		{ goals = { T(95417) } },
		{ goals = { A(95601, 36, { 95417 }), K(95601), K(95601, 2), T(95601) } },
		{ goals = { A(95427, 36, { 95601 }, { 95601, 95602 }), C(95427), C(95427, 2), T(95427) } },
		{ goals = { A(95418, 36, { 95427 }), T(95418) } },
		{ goals = { A(95420, 36, nil, { 95418, 94672, 94680, 94727, 95417, 95427, 95601, 95602 }), T(95420) } },
		{ goals = { A(95424, 36, { 95420 }), A(95425, 36, { 95420 }) } },
		{ goals = { K(95424), K(95424, 2) } },
		{ goals = { C(95425) } },
		{ goals = { T(95424), T(95425) } },
		{ goals = { A(95428, 36, { 95424 }, { 95424, 95425 }), T(95428) } },
		{ goals = { A(94744, 38, { 95428 }), T(94744) } },
		{ goals = { A(94745, 38, { 94744 }) } },
		{ goals = { A(94748, 38, { 94744 }), D(94748), T(94748) } },
		{ goals = { K(94745), K(94745, 2), K(94745, 3), T(94745) } },
		{ goals = { A(94768, 38, nil, { 94745, 94748 }), C(94768), T(94768) } },
		{ goals = { A(94975, 38, nil, { 94768, 94745, 94748 }) } },
		{ goals = { A(95278, 38, nil, { 94768, 94745, 94748 }), T(95278) } },
		{ goals = { A(94968, 40, { 95278 }) } },
		{ goals = { A(94972, 39, { 95278 }) } },
		{ title = "Krol'dok Stronghold", goals = { { t = "goto", text = "Krol'dok Stronghold", map = 2548, x = 37.5, y = 38.2 } } },
	} }
end
assert(Polestar.RegisterGuide(kroldok("test/kroldok", "Lookup")))
assert(Polestar.RegisterGuide(kroldok("test/kroldok-dungeon", "Dungeons")))
do
	n = 0
	local steps = {}
	for k = 1, 14 do
		local q = 96000 + k
		local preAll = k > 2 and { q - 1, q - 2 } or k == 2 and { q - 1 } or nil
		steps[#steps + 1] = { goals = { A(q, 30 + k, nil, preAll), K(q), T(q) } }
	end
	assert(Polestar.RegisterGuide({ id = "test/class", pack = "test", title = "Class quests", category = "Class", faction = "Horde", minLevel = 30, maxLevel = 50, steps = steps }))
end
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
-- The Engine's private table (Own), as its functions see it.
local function findOwn()
	for _, fn in pairs(E) do
		if type(fn) == "function" then
			local i = 1
			while true do
				local name, v = debug.getupvalue(fn, i)
				if not name then break end
				if name == "Own" and type(v) == "table" then return v end
				i = i + 1
			end
		end
	end
end
Own = findOwn()
assert(Own and Own.levelHold and Own.coming, "the Engine's Own table")
-- Each quest worked out (Own.comingNow; Own.coming itself where nothing caches it).
CALLS = 0
local key = Own.comingNow and "comingNow" or "coming"
local count = Own[key]
Own[key] = function(...) CALLS = CALLS + 1; return count(...) end
function settle() for _ = 1, 4 do stub.advance(0.25) end end
stub.login()
Polestar.Set("behavior.autoAccept", false)
Polestar.Set("behavior.autoTurnin", false)
"#;

fn run(script: &str, profile: bool, level: u32) -> Value {
	emitted(&RunAddon {
		stubs: if profile { vec!["stub_world.lua", "profile.lua"] } else { vec!["stub_world.lua"] },
		before: format!("{WORLD}stub.world.level = {level}\n{}", if profile { "stub.profile.start()" } else { "" }),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{GUIDES}\n{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

// Every state below, read with the pass's memo and again with every quest followed on its own (Own.levelHoldNow
// as Own.levelHold, as before): the step, each step's goal statuses and reasons, the level hold, and the hold
// before each step.
const COMPARE: &str = r#"
local w = stub.world
local function read()
	local out = { at = E.GetStepIndex(), hold = Own.levelHold() or false, before = {}, goals = {} }
	local G = E.GetGuide()
	for s = 1, #G.steps do
		out.before[s] = Own.holdsBefore(s) or false
		local row = {}
		for g, v in ipairs(E.GetStepView(s).goals) do row[g] = v.status .. ":" .. tostring(v.unavailable) .. ":" .. tostring(v.unavailableText) end
		out.goals[s] = table.concat(row, "|")
	end
	return out
end
local function both()
	local memo = Own.levelHold
	E.RequestUpdate(); settle()
	CALLS = 0
	local withMemo = read()
	withMemo.calls = CALLS
	Own.levelHold = Own.levelHoldNow
	E.RequestUpdate(); settle()
	CALLS = 0
	local without = read()
	without.calls = CALLS
	Own.levelHold = memo
	return { memo = withMemo, plain = without }
end
-- Each state adds to the one before: the character levels from 35 up (the level waits come and go), takes and
-- finishes the guide's first quests, skips one and finishes one out of order.
local G = Polestar.Guides.Get("GUIDE_ID")
local accepts = {}
for _, st in ipairs(G.steps) do
	for _, g in ipairs(st.goals) do if g.t == "accept" then accepts[#accepts + 1] = g.quest end end
end
local function level(l) w.level = l; stub.fire("PLAYER_LEVEL_UP", l) end
local states = {
	{ "level 35", function() end },
	{ "level 37", function() level(37) end },
	{ "level 43", function() level(43) end },
	{ "the first three done, the fourth in the log", function()
		w.complete({ accepts[1], accepts[2], accepts[3] })
		w.accept(accepts[4], { 6, 6, 6 })
	end },
	{ "the sixth skipped", function() E.SkipQuest(accepts[6], true) end },
	{ "the tenth done out of order", function() w.complete({ accepts[10] }) end },
}
E.SetGuide("GUIDE_ID")
settle()
local out = {}
for _, st in ipairs(states) do
	st[2]()
	stub.fire("QUEST_LOG_UPDATE")
	settle()
	out[#out + 1] = { state = st[1], r = both() }
end
emit(out)
"#;

#[test]
fn the_level_hold_reads_the_same_with_each_quest_worked_out_once_per_pass() {
	let mut holds = Vec::new();
	for guide in ["test/kroldok", "test/kroldok-dungeon", "test/class"] {
		let out = run(&COMPARE.replace("GUIDE_ID", guide), false, 35);
		let list = out.as_array().expect("cases");
		assert_eq!(list.len(), 6, "{guide}");
		for case in list {
			let state = &case["state"];
			let (memo, plain) = (&case["r"]["memo"], &case["r"]["plain"]);
			for key in ["at", "hold", "before", "goals"] {
				assert_eq!(memo[key], plain[key], "{guide} {state}: {key} differs with the memo");
			}
			let (m, p) = (memo["calls"].as_u64().unwrap(), plain["calls"].as_u64().unwrap());
			assert!(m <= p, "{guide} {state}: the memo never works out more ({m} > {p})");
			holds.push(memo["hold"].clone());
		}
	}
	// The cases hold different things: a level wait, and the whole guide open.
	assert!(holds.iter().any(|h| h.is_number()) && holds.iter().any(|h| h == &Value::Bool(false)), "{holds:?}");
}

// #2827: every step's view read at one moment (the step list, the route plan, the picker's progress, search)
// followed each prerequisite chain again from every step: Krol'dok's 30 steps, 19,352 Own.coming calls and 129 ms
// at once on 0.4.1. Own.coming is kept for the views of one moment now (Own.momentComing). Every state below is
// read with it and again with every quest followed on its own (Own.comingSeen false), and once more after a skip
// asked in the same frame (an evaluation of its own, a new moment): the same step, goal statuses, reasons and why.
const VIEWS: &str = r#"
local w = stub.world
local function views()
	local out, G = {}, E.GetGuide()
	for s = 1, #G.steps do
		local v = E.GetStepView(s)
		local row = { tostring(v.status), tostring(v.why), tostring(v.skipped) }
		for _, gv in ipairs(v.goals) do row[#row + 1] = gv.status .. ":" .. tostring(gv.unavailable) .. ":" .. tostring(gv.unavailableText) end
		out[s] = table.concat(row, "|")
	end
	return out
end
local function both()
	CALLS = 0
	local memo = views()
	local m = CALLS
	Own.comingSeen = false
	CALLS = 0
	local plain = views()
	local p = CALLS
	Own.comingSeen = nil
	return { memo = memo, plain = plain, mcalls = m, pcalls = p, at = E.GetStepIndex() }
end
local G = Polestar.Guides.Get("GUIDE_ID")
local accepts = {}
for _, st in ipairs(G.steps) do
	for _, g in ipairs(st.goals) do if g.t == "accept" then accepts[#accepts + 1] = g.quest end end
end
local function level(l) w.level = l; stub.fire("PLAYER_LEVEL_UP", l) end
local states = {
	{ "level 35", function() end },
	{ "level 43", function() level(43) end },
	{ "the first three done, the fourth in the log", function()
		w.complete({ accepts[1], accepts[2], accepts[3] })
		w.accept(accepts[4], { 6, 6, 6 })
	end },
	{ "the sixth skipped", function() E.SkipQuest(accepts[6], true) end },
	{ "the tenth done out of order", function() w.complete({ accepts[10] }) end },
}
E.SetGuide("GUIDE_ID")
settle()
local out = {}
for _, st in ipairs(states) do
	st[2]()
	stub.fire("QUEST_LOG_UPDATE")
	settle()
	out[#out + 1] = { state = st[1], r = both() }
end
-- Read at a moment, then a skip in the same frame: its evaluation starts the memo again.
views()
E.SkipQuest(accepts[5], true)
out[#out + 1] = { state = "the fifth skipped in the same frame", r = both() }
emit(out)
"#;

#[test]
fn every_step_s_view_at_one_moment_reads_the_same_with_each_quest_worked_out_once_2827() {
	for guide in ["test/kroldok", "test/kroldok-dungeon", "test/class"] {
		let out = run(&VIEWS.replace("GUIDE_ID", guide), false, 35);
		let list = out.as_array().expect("cases");
		assert_eq!(list.len(), 6, "{guide}");
		for case in list {
			let (state, r) = (&case["state"], &case["r"]);
			assert_eq!(r["memo"], r["plain"], "{guide} {state}: the views differ with the memo");
			let (m, p) = (r["mcalls"].as_u64().unwrap(), r["pcalls"].as_u64().unwrap());
			assert!(m <= p, "{guide} {state}: the memo never works out more ({m} > {p})");
			if guide == "test/kroldok" {
				assert!(m * 5 <= p, "{guide} {state}: the memo saves most of the chains ({m} against {p})");
			}
		}
	}
}

// The reference's fastest timing where the budget was set (i7-10700K, Linux, the harness's Lua 5.1), as
// settings-perf.rs: the budget scales by max(1, reference / REF_BASELINE).
const REF_BASELINE: f64 = 6.95;
// One evaluation of the pick-up guide (a quest-log update, as a kill brings) and the frame after it, the Engine
// alone. Measured 2026-11-17 (reference 9.9-10.9 ms, a busy machine): release/0.4.1 before this 46 ms and 4,485
// Own.coming calls; with the memo 2.3 ms and 135.
const EVAL_MS: f64 = 6.0;
const EVAL_CALLS: u64 = 400;

const PERF: &str = r#"
local P = stub.profile
local out = {}
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
E.SetGuide("test/kroldok")
settle()
reference()
local ms, calls = {}, {}
for k = 1, 9 do
	collectgarbage("collect")
	CALLS = 0
	local t = P.total()
	local m = P.measure(function() stub.fire("QUEST_LOG_UPDATE") end)
	stub.advance(0.2)
	ms[k], calls[k] = m + P.total() - t, CALLS
end
reference()
table.sort(ms); table.sort(calls)
out.ms, out.calls, out.at = ms[5], calls[5], E.GetStepIndex()
emit(out)
"#;

#[test]
fn an_evaluation_of_the_kroldok_pick_up_guide_stays_within_budget() {
	let out = run(PERF, true, 43);
	let num = |v: &Value| v.as_f64().unwrap_or(f64::NAN);
	assert_eq!(out["at"], 1, "{out}");
	let calls = out["calls"].as_u64().unwrap();
	assert!(calls > 0 && calls <= EVAL_CALLS, "Own.coming worked out {calls} times in one evaluation (budget {EVAL_CALLS}): {out}");
	let scale = (num(&out["reference"]) / REF_BASELINE).max(1.0);
	forge_addontest::assert_timing!(num(&out["ms"]) < EVAL_MS * scale, "an evaluation over {EVAL_MS} ms: {out}; reference scale {scale:.3}");
}
