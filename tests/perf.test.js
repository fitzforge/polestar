'use strict';
// Performance budgets: the whole addon, every module on, against the stubbed
// world (tests/lua/stub_world.lua) with the local data packs loadable on demand
// when built (Polestar_QuestDB, Polestar_Codex, Polestar_ItemDB). Only game
// event handlers, message listeners, OnUpdate scripts and C_Timer callbacks
// are timed (tests/lua/profile.lua). os.clock is elapsed time on Windows,
// CPU time elsewhere; harness work is excluded in either case.
//
//   - a burst of 50 QUEST_LOG_UPDATE and 50 BAG_UPDATE in one frame, plus the
//     refreshes it schedules, once the guide is open and its catch-up has ended:
//     the median of BURSTS bursts, under 5 ms;
//   - a frame while the player walks (OnUpdate scripts and tickers): under 1 ms;
//   - SetGuide with its first 0.5 s of frames, under 28 ms; the worst single
//     frame from SetGuide to the end of the guide window's catch-up, under 24 ms;
//     every step change while a leveling guide plays, with what it schedules,
//     under 21 ms;
//   - a gathering guide plays to the end in under 15 s of wall time.
//
// Budgets are steady-state: the data packs are loaded first (each is a single
// on-demand parse of its data, reported as `packMs`, not a per-step cost), and
// a full garbage collection runs before each measurement so a collector cycle
// owed to earlier work is not charged to it.
//
// Each measurement is taken over 5 rounds (ROUNDS, one Lua process each) and
// the fastest round is held. Other work on the machine (the whole suite in
// parallel, a build) only ever adds time to a round, never takes it away, so
// the minimum is what the addon costs, and load that comes and goes cannot
// fail it; a regression is in every round, so it shows in the minimum too.
//
// Every round also times a reference (REFERENCE below) before each
// measurement: 500 events through the same event path to a plain handler
// doing what a Polestar handler does (parses quest objective text, builds and
// sorts rows, formats a line). Its fastest timing over every round is refNow.
// A slower computer than the one the budgets were set on, or one busy through
// every round, runs the addon and the reference alike slower, so each budget
// is scaled by max(1, refNow / REF_BASELINE): a figure fails only when it is
// over its budget and over that scaled budget. On a computer as fast as the
// reference one the scale is 1 and the budgets hold as written; otherwise the
// addon keeps its share of the reference, so an addon twice as slow still
// fails. The gathering guide's wall time (fastest round too) is scaled by the
// same ratio.
// Like recorder-perf.test.js, allow one measured clock step (at most 1 ms)
// for quantization. A whole-ms clock cannot resolve a sub-ms walking frame.
//
// Needs data/forever (forge data build); skips without it.
// To find what broke a budget: node tests/helpers/profile.js <guide> --packs [--sample=1000]

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { ROOT } = require('./helpers/lua');
const { needs } = require('./helpers/data');
const { buildSimPack, playGuide, luaValue, SIMULATE } = require('../tools/lib/playtest');
const { localPacks, withinBudget } = require('./helpers/profile');

const LEVELING = 'forever/horde/02-the-barrens.guide';
const GATHERING = 'forever/professions/mining.guide';
const skip = needs('quests.json')
	|| ((!fs.existsSync(path.join(ROOT, 'guides', LEVELING)) || !fs.existsSync(path.join(ROOT, 'guides', GATHERING))) && 'budget guides missing');

// The budgets are 0.3.7's figures with a fifth of headroom (Nov 11, i7-10700K at refNow
// 5.28 ms, a quiet machine, two runs alike: burst 4.21-4.23, tick 0.14, setGuide 23.3-23.5,
// catchUp 19.8-19.9, stepChange 17.1-17.4). Before 0.3.7 the burst budget (4 ms) was "over
// and accepted" each release: the bursts began 0.5 s after SetGuide, inside the guide
// window's catch-up (up to 2.5 s), so the worst of three always held its last frame, the
// step placed drawn in full (5.3-5.6 ms), and read 9-10 ms. The catch-up now ends before the
// bursts and is measured on its own (catchUp), and a burst is the median of BURSTS, not the
// worst of three. setGuide is the guide's first open in the process (the mining guide plans
// a travel route to every trainer/vendor candidate once, cached after); the Barrens guide's
// opening is the larger. On origin/next before 0.3.7's engine work these read setGuide 32.7,
// catchUp 29.2, stepChange 20.7-21.1, tick 3.8 (the 1 ms tick budget was over then too).
const BUDGET = { burst: 5, tick: 1, setGuide: 28, catchUp: 24, stepChange: 21, gatherSeconds: 15 };
const ROUNDS = 5;
const BURSTS = 10; // bursts per round; the median counts
// The reference's fastest timing: 5.3 ms (Intel i7-10700K, 16 threads, Linux,
// lua5.1 5.1.5; the same with other work on the machine).
const REF_BASELINE = 5.3;

// Settings that are off by default, switched on so every module runs.
const ALL_ON = {
	'qol.nameplateIcons': true, 'qol.guideDim': true, 'maps.minimapCoords': true, 'maps.minimapButton': true, 'maps.travelMinimap': true,
	'rares.minimapRares': true, 'rares.minimapTreasures': true, 'rares.combatAlerts': true,
};

// The reference: 500 events through the same event path (stub.fire and the
// profiler's timing) to a plain handler doing addon-like work, in addon ms as
// P.total counts them. Defines reference(), which appends one timing to
// out.refs.
const REFERENCE = `
local refFrame = CreateFrame("Frame")
refFrame:RegisterEvent("POLESTAR_TEST_REFERENCE")
local refText = {
	"Kobold Vermin slain: 3/10", "Gold Dust: 1/5", "Tough Wolf Meat: 4/8", "Plainstrider Beak: 0/7",
	"Bring the meat to Grull Hawkwind", "Speak with Thrall in Orgrimmar", "Zhevra Hooves: 2/4", "Explore the Crossroads",
}
local refLine
refFrame:SetScript("OnEvent", function(_, _, i)
	local rows = {}
	for k = 1, #refText do
		local text = refText[k]
		local name, have, need = text:match("^(.-): (%d+)/(%d+)$")
		rows[k] = { name = name or text, done = have ~= nil and tonumber(have) >= tonumber(need),
			key = (text:lower():gsub("%W", "")) }
	end
	table.sort(rows, function(a, b) return a.key < b.key end)
	local dx, dy = i % 100 - 50, i % 37 - 18
	refLine = string.format("%s (%s) %.1f yd", rows[1].name, rows[1].done and "done" or "open", math.sqrt(dx * dx + dy * dy))
end)
out.refs = {}
local function reference()
	collectgarbage("collect")
	local t = stub.profile.total()
	-- Keep the 500-event unit; a longer sample reduces whole-ms rounding.
	for i = 1, 5000 do stub.fire("POLESTAR_TEST_REFERENCE", i) end
	out.refs[#out.refs + 1] = (stub.profile.total() - t) / 10
end
`;

let pack;
function simPack() {
	if (!pack) pack = buildSimPack([LEVELING, GATHERING]);
	return pack;
}
process.on('exit', () => pack && pack.dispose());

const fastest = (list) => Math.min(...list);
const round3 = (v) => +v.toFixed(3);

// One round: a Lua process playing the leveling guide, emitting each figure
// and the reference timed before each measurement.
function measureRound(p, leveling, gathering) {
	const packs = localPacks();
	const [r] = playGuide(p, leveling, {
		race: 'Orc', faction: 'Horde', cls: 'WARRIOR',
		stubs: [...packs.stubs, 'profile.lua'],
		before: `${packs.before}\nstub.profile.start()`,
		script: `
local P, E, w = stub.profile, Polestar.Engine, stub.world
for k, v in pairs(${luaValue(ALL_ON)}) do Polestar.Set(k, v) end
-- Every pack present, loaded once (what a session pays the first time a
-- feature needs one), then the delayed work after login.
local out = { packs = {}, packMs = {} }
local c0, c1 = os.clock(), os.clock()
while c1 == c0 do c1 = os.clock() end
out.resolution = math.min((c1 - c0) * 1000, 1)
for _, name in ipairs(${luaValue(packs.present)}) do
	out.packMs[name] = P.measure(function() Polestar.Data.Pack(name) end)
end
for name in pairs(stub.packLoads) do out.packs[#out.packs + 1] = name end
table.sort(out.packs)
stub.advance(6) -- delayed work (Rares' minimap layers wait 5 s)
${REFERENCE}

-- Addon time of fn plus the frames that follow it (deferred refreshes), less
-- what those frames cost when nothing happens.
local function idleFrames(seconds)
	local t = P.total()
	stub.advance(seconds)
	return P.total() - t
end
local idle = math.huge
for _ = 1, 5 do idle = math.min(idle, idleFrames(0.5)) end
out.idle = idle
-- The guide window's catch-up (GUIDE_PLACED: the window goes over the steps
-- before the one placed, up to 2.5 s, CATCH_UP true ... false).
local catching = false
Polestar.On("CATCH_UP", function(on) catching = on and true or false end)
local function withFrames(fn)
	collectgarbage("collect")
	local t = P.total()
	local direct = P.measure(fn)
	stub.advance(0.5)
	return direct + P.total() - t - idle
end
-- Opening a guide: SetGuide and its first 0.5 s of frames (setGuide), then
-- the frames on to the catch-up's end (at most 3 s more), so nothing of it
-- runs into what is measured next; catchUp is the worst single frame from
-- SetGuide to that end (its last one draws the step placed in full).
out.catchUp = 0
local function open(id)
	collectgarbage("collect")
	local t = P.total()
	local worst = P.measure(function() E.SetGuide(id) end)
	local spent = worst
	for _ = 1, 10 do
		local f = P.total()
		stub.advance(0.05)
		local d = P.total() - f
		spent = spent + d
		if d > worst then worst = d end
	end
	local waited = 0
	while catching and waited < 3 do
		local f = P.total()
		stub.advance(0.05)
		waited = waited + 0.05
		local d = P.total() - f
		if d > worst then worst = d end
	end
	out.catchUp = math.max(out.catchUp, worst)
	return spent - idle
end

reference()
out.setGuide = math.max(open(${luaValue(gathering.id)}), open(${luaValue(leveling.id)}))
out.caughtUp = not catching

-- A burst of 50 quest-log and 50 bag updates in one frame and the frames
-- that follow; the median of BURSTS, as the window and the engine are at rest.
reference()
local bursts = {}
for b = 1, ${BURSTS} do
	bursts[b] = withFrames(function()
		for i = 1, 50 do
			stub.fire("QUEST_LOG_UPDATE")
			stub.fire("BAG_UPDATE", i % 5)
		end
		stub.fire("BAG_UPDATE_DELAYED")
	end)
end
table.sort(bursts)
out.burst = bursts[math.ceil(#bursts / 2)]
out.burstMax = bursts[#bursts]

-- Walking: one frame at a time, a few yards per second, for 10 s.
reference()
out.tick = 0
local map, x, y = w.map, w.x, w.y
collectgarbage("collect")
for i = 1, 200 do
	w.moveTo(map, x + i * 0.01, y + i * 0.005)
	local t = P.total()
	stub.advance(0.05)
	out.tick = math.max(out.tick, P.total() - t)
end
w.moveTo(map, x, y)
stub.advance(0.6)

-- Every step change while the guide plays: what the action and the frames
-- after it cost (the simulator's own reads are not addon time). The
-- collector is held for the playthrough, the reference timed either side.
reference()
out.stepChange, out.changes = 0, 0
local advance = stub.advance
local lastStep, lastTotal = E.GetStepIndex(), P.total()
stub.advance = function(s)
	advance(s)
	local now, step = P.total(), E.GetStepIndex()
	if step ~= lastStep then
		out.changes = out.changes + 1
		out.stepChange = math.max(out.stepChange, now - lastTotal)
	end
	lastStep, lastTotal = step, now
end
collectgarbage("collect")
collectgarbage("stop")
local __emit = emit
emit = function(v) out.result = v end
${SIMULATE}
emit = __emit
collectgarbage("restart")
stub.advance = advance
reference()
emit(out)`,
	});
	return r;
}

// The rounds, run once for both tests: the fastest round of each figure, refNow
// (the fastest reference timing) and the scale it gives the budgets.
let measured;
function measure() {
	if (measured) return measured;
	const p = simPack();
	const leveling = p.guides.find((g) => g._ast && g._ast.source === LEVELING);
	const gathering = p.guides.find((g) => g._ast && g._ast.source === GATHERING);
	const rounds = [];
	for (let i = 0; i < ROUNDS; i++) rounds.push(measureRound(p, leveling, gathering));
	const pick = (k) => fastest(rounds.map((r) => r[k]));
	const refNow = fastest(rounds.flatMap((r) => r.refs));
	const scale = Math.max(1, refNow / REF_BASELINE);
	measured = {
		rounds, scale, refNow,
		resolution: Math.max(...rounds.map((r) => r.resolution)),
		burst: pick('burst'), tick: pick('tick'), setGuide: pick('setGuide'), catchUp: pick('catchUp'), stepChange: pick('stepChange'), idle: pick('idle'),
		changes: Math.min(...rounds.map((r) => r.changes)),
		limit: Object.fromEntries(Object.entries(BUDGET).map(([k, v]) => [k, round3(v * scale)])),
	};
	return measured;
}

// A figure fails only when it is over its budget and over the budget scaled
// by the load the reference saw (scale >= 1, so the scaled budget decides).
function within(m, k, value) {
	return withinBudget(value, BUDGET[k], m.scale, k === 'gatherSeconds' ? m.resolution / 1000 : m.resolution);
}

test('event bursts, walking frames and step changes stay within budget with every module on', { skip }, () => {
	const m = measure();
	const last = m.rounds[m.rounds.length - 1];
	const report = `budgets (ms) ${JSON.stringify(BUDGET)}; refNow ${round3(m.refNow)} ms, refBaseline ${REF_BASELINE} ms, `
		+ `scale ${round3(m.scale)}, clock step ${round3(m.resolution)} ms, scaled budgets ${JSON.stringify(m.limit)}; measured (fastest of ${ROUNDS}) ${JSON.stringify({
			burst: round3(m.burst), tick: round3(m.tick), setGuide: round3(m.setGuide), catchUp: round3(m.catchUp), stepChange: round3(m.stepChange),
			changes: m.changes, idle: round3(m.idle), packs: last.packs,
			packMs: Object.fromEntries(Object.entries(last.packMs || {}).map(([k, v]) => [k, +v.toFixed(1)])),
		})}`;
	for (const r of m.rounds) {
		assert.ok(r.result && r.result.done, `the leveling guide did not finish: ${JSON.stringify(r.result && r.result.stuck)}`);
	}
	assert.ok(m.changes > 10, `too few step changes measured (${m.changes})`);
	for (const r of m.rounds) assert.ok(r.caughtUp, 'the catch-up ended before the bursts');
	for (const k of ['burst', 'tick', 'setGuide', 'catchUp', 'stepChange']) assert.ok(within(m, k, m[k]), `${k} over budget: ${report}`);
	console.log(report);
});

test(`a gathering guide plays to the end in under ${BUDGET.gatherSeconds} s`, { skip }, () => {
	const m = measure();
	const p = simPack();
	const gathering = p.guides.find((g) => g._ast && g._ast.source === GATHERING);
	const packs = localPacks();
	const times = [];
	for (let i = 0; i < ROUNDS; i++) {
		const t0 = Date.now();
		const [out] = playGuide(p, gathering, { race: 'Orc', faction: 'Horde', cls: 'WARRIOR', stubs: packs.stubs, before: packs.before });
		times.push((Date.now() - t0) / 1000);
		assert.ok(out.done, `stuck at ${JSON.stringify(out.stuck)}`);
	}
	const seconds = fastest(times);
	const report = `${gathering.id} took ${seconds.toFixed(2)} s (fastest of ${ROUNDS}); budget ${BUDGET.gatherSeconds} s, `
		+ `scale ${round3(m.scale)} (refNow ${round3(m.refNow)} ms, refBaseline ${REF_BASELINE} ms), scaled budget ${m.limit.gatherSeconds} s`;
	assert.ok(within(m, 'gatherSeconds', seconds), report);
	console.log(report);
});
