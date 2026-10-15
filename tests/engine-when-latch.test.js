'use strict';
// Task 7.5: a step the route moves past while its `when` is false stays
// passed (as RestedXP does): it is remembered as skipped for the character,
// so the route does not return to it when the condition turns true later.
// Steps not yet reached are re-checked as before.

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
w.setZone("Elwynn Forest", "")
`;

// 1: fly to Loch Modan unless there; 2: fly to Ironforge; 3: only while on
// quest 999 (never); 4: only in Ironforge, reached later; 5: the end.
const GUIDE = `
Polestar.RegisterGuide({
	id = "test/01-latch", pack = "test", title = "Latch",
	faction = "Alliance", races = { "Human" }, minLevel = 1, maxLevel = 6, zone = 1429,
	steps = {
		{ title = "To Loch", when = { "not", { "zone", "Loch Modan" } }, goals = { { t = "fly", location = "Loch Modan" } } },
		{ title = "To Ironforge", goals = { { t = "fly", location = "Ironforge" } } },
		{ title = "Never", when = { "onquest", 999 }, goals = { { t = "level", level = 5 } } },
		{ title = "In Ironforge", when = { "zone", "Ironforge" }, goals = { { t = "level", level = 2 } } },
		{ title = "End", goals = { { t = "level", level = 6 } } },
	},
})
`;

function run(script) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [CORE],
		script: `${PACK2}\n${TEST_SOURCE}\n${GUIDE}
			E = Polestar.Engine
			local w = stub.world
			function flush() stub.advance(0.25) end
			function zone(z) w.setZone(z, ""); stub.fire("ZONE_CHANGED_NEW_AREA"); stub.fire("ZONE_CHANGED"); flush() end
			stub.login()
			stub.fire("QUEST_LOG_UPDATE")
			flush()
			${script}`,
	}).emitted;
}

test('a step passed while its when is false does not come back', () => {
	const out = run(`
		emit(E.GetStepIndex())
		zone("Loch Modan")
		emit(E.GetStepIndex())
		zone("Ironforge")
		emit(E.GetStepIndex())
		w.setLevel(2); stub.fire("PLAYER_LEVEL_UP", 2); flush()
		emit(E.GetStepIndex())
		zone("Elwynn Forest")
		emit(E.GetStepIndex())`);
	// 1 -> (arrived; its when turns false) 2 -> Ironforge: 3 never applies, 4 applies
	// -> level 2 -> 5; back in Elwynn, step 1's when holds again but it stays passed.
	assert.deepEqual(out, [1, 2, 4, 5, 5]);
});

test('the latch is the skip list: Engine reports the step skipped', () => {
	const out = run(`
		zone("Loch Modan"); zone("Ironforge")
		local sk = Polestar.CharState().skipped["test/01-latch"] or {}
		emit({ one = sk[1] == true, three = sk[3] == true, four = sk[4] == true })`);
	assert.deepEqual(out, [{ one: true, three: true, four: false }]);
});

test('a step ahead of the route is still re-checked', () => {
	const out = run(`
		zone("Ironforge")
		emit(E.GetStepIndex())
		zone("Elwynn Forest")
		emit(E.GetStepIndex())`);
	// In Ironforge first: step 1 still applies (not in Loch Modan) and its fly is open.
	assert.deepEqual(out, [1, 1]);
});
