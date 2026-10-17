'use strict';
// Performance budgets: the whole addon, every module on, against the stubbed
// world (tests/lua/stub_world.lua) with the local data packs loadable on demand
// when built (Polestar_QuestDB, Polestar_Codex, Polestar_ItemDB). Addon time is
// CPU time inside game event handlers, message listeners, OnUpdate scripts and
// C_Timer callbacks (tests/lua/profile.lua), so harness work does not count.
//
//   - a burst of 50 QUEST_LOG_UPDATE and 50 BAG_UPDATE in one frame, plus the
//     refreshes it schedules: under 4 ms;
//   - a frame while the player walks (OnUpdate scripts and tickers): under 1 ms;
//   - SetGuide, and every step change while a leveling guide plays, with what
//     they schedule: under 8 ms;
//   - a gathering guide plays to the end in under 15 s of wall time.
//
// Budgets are steady-state: the data packs are loaded first (each is a single
// on-demand parse of its data, reported as `packMs`, not a per-step cost), and
// a full garbage collection runs before each measurement so a collector cycle
// owed to earlier work is not charged to it.
//
// Each measurement is taken over 5 rounds (ROUNDS, one Lua process each) and
// the median is held; a regression shows in every round, a hiccup in one.
//
// Every round also times a reference (REFERENCE below) before each
// measurement: 500 events through the same event path to a plain handler
// doing what a Polestar handler does (parses quest objective text, builds and
// sorts rows, formats a line). Its median over every round is refNow. A
// machine busy with other work (the whole suite running in parallel) slows
// the addon and the reference alike, so each budget is scaled by
// max(1, refNow / REF_BASELINE): a figure fails only when it is over its
// budget and over that scaled budget. On a quiet machine the scale is 1 and
// the budgets hold as written; under load the addon keeps its share of the
// reference, so an addon twice as slow still fails. The gathering guide's
// wall time is scaled by the same ratio.
//
// Needs data/forever (node tools/polestar.js data build); skips without it.
// To find what broke a budget: node tests/helpers/profile.js <guide> --packs [--sample=1000]

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { ROOT } = require('./helpers/lua');
const { needs } = require('./helpers/data');
const { buildSimPack, playGuide, luaValue, SIMULATE } = require('../tools/lib/playtest');
const { localPacks } = require('./helpers/profile');

const LEVELING = 'forever/horde/02-the-barrens.guide';
const GATHERING = 'forever/professions/mining.guide';
const skip = needs('quests.json')
	|| ((!fs.existsSync(path.join(ROOT, 'guides', LEVELING)) || !fs.existsSync(path.join(ROOT, 'guides', GATHERING))) && 'budget guides missing');

const BUDGET = { burst: 4, tick: 1, setGuide: 8, stepChange: 8, gatherSeconds: 15 };
const ROUNDS = 5;
// The reference's median on a quiet machine: 5.5 ms (Intel i7-10700K,
// 16 threads, Linux, lua5.1 5.1.5, perf.test.js run alone).
const REF_BASELINE = 5.5;

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
	for i = 1, 500 do stub.fire("POLESTAR_TEST_REFERENCE", i) end
	out.refs[#out.refs + 1] = stub.profile.total() - t
end
`;

let pack;
function simPack() {
	if (!pack) pack = buildSimPack([LEVELING, GATHERING]);
	return pack;
}
process.on('exit', () => pack && pack.dispose());

const median = (list) => [...list].sort((a, b) => a - b)[Math.ceil(list.length / 2) - 1];
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
local function withFrames(fn)
	collectgarbage("collect")
	local t = P.total()
	local direct = P.measure(fn)
	stub.advance(0.5)
	return direct + P.total() - t - idle
end

reference()
out.setGuide = math.max(
	withFrames(function() E.SetGuide(${luaValue(gathering.id)}) end),
	withFrames(function() E.SetGuide(${luaValue(leveling.id)}) end))

reference()
out.burst = 0
for _ = 1, 3 do
	out.burst = math.max(out.burst, withFrames(function()
		for i = 1, 50 do
			stub.fire("QUEST_LOG_UPDATE")
			stub.fire("BAG_UPDATE", i % 5)
		end
		stub.fire("BAG_UPDATE_DELAYED")
	end))
end

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

// The rounds, run once for both tests: the medians of each figure, refNow
// (the median of every reference timing) and the scale it gives the budgets.
let measured;
function measure() {
	if (measured) return measured;
	const p = simPack();
	const leveling = p.guides.find((g) => g._ast && g._ast.source === LEVELING);
	const gathering = p.guides.find((g) => g._ast && g._ast.source === GATHERING);
	const rounds = [];
	for (let i = 0; i < ROUNDS; i++) rounds.push(measureRound(p, leveling, gathering));
	const pick = (k) => median(rounds.map((r) => r[k]));
	const refNow = median(rounds.flatMap((r) => r.refs));
	const scale = Math.max(1, refNow / REF_BASELINE);
	measured = {
		rounds, scale, refNow,
		burst: pick('burst'), tick: pick('tick'), setGuide: pick('setGuide'), stepChange: pick('stepChange'), idle: pick('idle'),
		changes: Math.min(...rounds.map((r) => r.changes)),
		limit: Object.fromEntries(Object.entries(BUDGET).map(([k, v]) => [k, round3(v * scale)])),
	};
	return measured;
}

// A figure fails only when it is over its budget and over the budget scaled
// by the load the reference saw (scale >= 1, so the scaled budget decides).
function within(m, k, value) {
	return value < BUDGET[k] || value < BUDGET[k] * m.scale;
}

test('event bursts, walking frames and step changes stay within budget with every module on', { skip }, () => {
	const m = measure();
	const last = m.rounds[m.rounds.length - 1];
	const report = `budgets (ms) ${JSON.stringify(BUDGET)}; refNow ${round3(m.refNow)} ms, refBaseline ${REF_BASELINE} ms, `
		+ `scale ${round3(m.scale)}, scaled budgets ${JSON.stringify(m.limit)}; measured (median of ${ROUNDS}) ${JSON.stringify({
			burst: round3(m.burst), tick: round3(m.tick), setGuide: round3(m.setGuide), stepChange: round3(m.stepChange),
			changes: m.changes, idle: round3(m.idle), packs: last.packs,
			packMs: Object.fromEntries(Object.entries(last.packMs || {}).map(([k, v]) => [k, +v.toFixed(1)])),
		})}`;
	for (const r of m.rounds) {
		assert.ok(r.result && r.result.done, `the leveling guide did not finish: ${JSON.stringify(r.result && r.result.stuck)}`);
	}
	assert.ok(m.changes > 10, `too few step changes measured (${m.changes})`);
	for (const k of ['burst', 'tick', 'setGuide', 'stepChange']) assert.ok(within(m, k, m[k]), `${k} over budget: ${report}`);
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
	const seconds = median(times);
	const report = `${gathering.id} took ${seconds.toFixed(2)} s (median of ${ROUNDS}); budget ${BUDGET.gatherSeconds} s, `
		+ `scale ${round3(m.scale)} (refNow ${round3(m.refNow)} ms, refBaseline ${REF_BASELINE} ms), scaled budget ${m.limit.gatherSeconds} s`;
	assert.ok(within(m, 'gatherSeconds', seconds), report);
	console.log(report);
});
