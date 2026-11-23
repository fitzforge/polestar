'use strict';
// A route choice ahead (a guide's nextChoices, not made yet) only holds back
// the hand-ins one of its options makes (RoutePlan.GetTurnIn "choice"). A
// finished quest no guide of the chain hands in, whichever option is taken,
// is one no route hands in, and the one that waits on the choice no longer
// hides the others from RoutePlan.Carried (the guide window's "finished
// quests to hand in elsewhere" row, the Quest room's carried list).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const run = (extra = '') => runAddon({
	stubs: ['stub_world.lua'],
	addons: ['Polestar'],
	script: `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(19)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
-- The active guide, then a guide that offers two ways on.
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", category = "Leveling", minLevel = 1, maxLevel = 20, next = "test/b",
	steps = { { goals = { { t = "note", text = "Here" } } }, { goals = { { t = "turnin", quest = 70, title = "Ahead" } } } } })
Polestar.RegisterGuide({ id = "test/b", pack = "test", title = "B", category = "Leveling", minLevel = 1, maxLevel = 30,
	next = "test/c1", nextChoices = { "test/c1", "test/c2" },
	steps = { { goals = { { t = "note", text = "Fork" } } } } })
Polestar.RegisterGuide({ id = "test/c1", pack = "test", title = "C1", category = "Leveling", minLevel = 1, maxLevel = 40,
	steps = { { goals = { { t = "turnin", quest = 50, title = "Branch quest" } } } } })
Polestar.RegisterGuide({ id = "test/c2", pack = "test", title = "C2", category = "Leveling", minLevel = 1, maxLevel = 40,
	steps = { { goals = { { t = "note", text = "Other way" } } } } })
-- 50: only option C1 hands it in. 60: no guide of the chain does. 70: A, ahead.
for _, q in ipairs({ 50, 60, 70 }) do
	w.accept(q, { { type = "monster", text = "Kill", need = 1 } }, "Quest " .. q)
	w.finish(q)
end
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
local E, P = Polestar.Engine, Polestar.RoutePlan
E.OpenTab("test/a", true)
stub.advance(0.6)
${extra}
P.Invalidate()
local list, waiting = P.Carried()
local ids = {}
for _, c in ipairs(list or {}) do ids[#ids + 1] = c.quest end
emit({ active = E.GetGuide().id, carried = list and ids or "nil", waiting = waiting,
	s50 = P.GetTurnIn(50).status, s60 = P.GetTurnIn(60).status, s70 = P.GetTurnIn(70).status })`,
}).emitted[0];

test('with a route choice ahead, a quest no option hands in is carried and the one an option hands in waits', () => {
	const out = run();
	assert.equal(out.active, 'test/a');
	assert.ok(['now', 'future'].includes(out.s70), 'handed in ahead in A: ' + out.s70);
	assert.equal(out.s50, 'choice', 'only option C1 hands it in: the choice decides');
	assert.equal(out.s60, 'unplanned', 'no option hands it in: not on the route, whichever is taken');
	assert.deepEqual(out.carried, [60], 'the list is not held back by 50: ' + JSON.stringify(out));
	assert.equal(out.waiting, 1, 'one quest waits on the choice');
});

test('once the choice is made, the quest its option hands in is on the route and the other stays carried', () => {
	const c1 = run('Polestar.CharState().routes = { ["test/b"] = "test/c1" }');
	assert.equal(c1.s50, 'later', JSON.stringify(c1));
	assert.deepEqual(c1.carried, [60]);
	assert.equal(c1.waiting, 0);
	const c2 = run('Polestar.CharState().routes = { ["test/b"] = "test/c2" }');
	assert.equal(c2.s50, 'unplanned', JSON.stringify(c2));
	assert.deepEqual(c2.carried, [50, 60]);
	assert.equal(c2.waiting, 0);
});
