'use strict';
// Pointing the arrow at an along goal:
// Engine.AimAlong(step, goal) makes an open, located goal of a listed along
// step the waypoint; the choice survives the route moving on while the goal
// is still listed, and lapses when the goal is done or no longer listed.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };
const PACK2 = 'Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 2, title = "Test", author = "Test", version = "1", license = "MIT" })';

const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"; w.titles[7] = "Kobold Camp Cleanup"
`;

// 1 accept 7 · 2 along until "back": kill vermin (located), candles (no place)
// · 3 along: linen at a place · 4 accept 783 · 5 "back": turn in 7 · 6 level 6
const GUIDE = `
Polestar.RegisterGuide({
	id = "test/01-aim", pack = "test", title = "Aim",
	faction = "Alliance", races = { "Human" }, minLevel = 1, maxLevel = 6, zone = 1429,
	steps = {
		{ title = "McBride", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Kobolds on the way", along = "back", goals = {
			{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 },
			{ t = "collect", item = 750, itemName = "Candle", count = 2 },
		} },
		{ title = "Linen", along = true, goals = { { t = "collect", item = 2589, itemName = "Linen Cloth", count = 1, map = 1429, x = 40.0, y = 60.0 } } },
		{ title = "Willem", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
		{ title = "Back to McBride", label = "back", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "End", goals = { { t = "level", level = 6 } } },
	},
})
`;

const HELPERS = `
function flush() stub.advance(0.25) end
E = Polestar.Engine
function wp()
	local w = E.GetWaypoint()
	return w and (w.stepIndex .. ":" .. w.goalIndex) or "none"
end
`;

function run(script) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [CORE],
		script: `${PACK2}\n${TEST_SOURCE}\n${GUIDE}\n${HELPERS}\nstub.login()\n${script}`,
	}).emitted;
}

test('AimAlong points the arrow at a listed, located, open along goal and refuses anything else', () => {
	const out = run(`
		local w = stub.world
		flush()
		emit(E.AimAlong(2, 1))                 -- step 2 is not along yet (route at step 1)
		w.accept(7, { 10 }); flush()
		emit(E.GetStepIndex()); emit(wp())     -- 4, Willem
		emit(E.AimAlong(2, 2))                 -- candles: no place
		emit(E.AimAlong(4, 1))                 -- not an along step
		emit(E.AimAlong(2, 9))                 -- no such goal
		emit(E.AimAlong(2, 1)); flush()
		emit(wp())                             -- the kobolds
		local v = E.GetWaypoint()
		emit({ v.x, v.y, v.kind })
	`);
	assert.deepEqual(out, [false, 4, '4:1', false, false, false, true, '2:1', [47.6, 35.1, 'kill']]);
});

test('the choice lapses when the along goal is done', () => {
	const out = run(`
		local w = stub.world
		flush()
		w.accept(7, { 10 }); flush()
		E.AimAlong(2, 1); flush()
		emit(wp())
		w.progress(7, 1, 10); flush()
		emit(wp())
	`);
	assert.deepEqual(out, ['2:1', '4:1']);
});

test('the choice survives the route moving on while the goal is listed, and lapses when it is not', () => {
	const out = run(`
		local w = stub.world
		flush()
		w.accept(7, { 10 }); flush()
		E.AimAlong(3, 1); flush()
		emit(wp())
		w.accept(783, {}); flush()               -- route moves to step 5; step 3 (along, no until) is still listed
		emit(E.GetStepIndex()); emit(wp())
		E.AimAlong(2, 1); flush()               -- step 2 ended at its label (step 5): refused
		emit(wp())
	`);
	assert.deepEqual(out, ['3:1', 5, '3:1', '3:1']);
});
