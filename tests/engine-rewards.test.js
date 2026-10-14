'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK } = require('./helpers/packs');

const GUIDE = `
Polestar.RegisterGuide({ id = "test/earth", pack = "test", title = "Earth",
 steps = {
  { goals = { { t = "accept", quest = 94373, title = "Call of Earth", doneItem = 5175 } } },
  { goals = { { t = "collect", item = 264356, itemName = "Iceclaw Bear Pendant", quest = 94373, oi = 1, doneItem = 5175 } } },
  { goals = {
   { t = "turnin", quest = 94373, title = "Call of Earth", doneItem = 5175 },
   { t = "accept", quest = 94374, title = "Call of Earth", doneItem = 5175 },
   { t = "use", item = 6635, itemName = "Earth Sapta", doneItem = 5175 },
   { t = "turnin", quest = 94374, title = "Call of Earth", doneItem = 5175 },
   { t = "accept", quest = 94375, title = "Call of Earth", doneItem = 5175 },
   { t = "turnin", quest = 94375, title = "Call of Earth", doneItem = 5175 },
  } },
  { goals = { { t = "accept", quest = 60, title = "Kobold Candles" } } },
 } })
`;

function run(before, script = '') {
	return runAddon({
		stubs: ['stub_world.lua'],
		before,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		script: `${TEST_PACK}\n${GUIDE}
stub.login()
E = Polestar.Engine
E.SetGuide("test/earth")
function snapshot()
 local goals = {}
 for s = 1, 3 do
  for _, g in ipairs(E.GetStepView(s).goals) do goals[#goals + 1] = g.status end
 end
 return { step = E.GetStepIndex(), goals = goals,
  flag = Polestar.Compat.IsQuestCompleted(94373),
  unrelated = E.GetStepView(4).goals[1].status }
end
${script || 'emit(snapshot())'}`,
	}).emitted;
}

const satisfied = { step: 4, goals: Array(8).fill('done'), flag: false, unrelated: 'active' };

test('Earth Totem satisfies the entire chain at login without inventing quest flags or completing unrelated work', () => {
	const [out] = run('stub.world.items[5175] = 1');
	assert.deepEqual(out, satisfied);
});

test('without the authored end reward, accepting a quest only completes its accept goal', () => {
	const [fresh, accepted] = run('', `
emit(snapshot())
stub.world.accept(94373, { 2 }); stub.advance(0.25)
emit(snapshot())
`);
	assert.equal(fresh.step, 1);
	assert.equal(fresh.goals.filter((s) => s === 'done').length, 0);
	assert.equal(accepted.step, 2);
	assert.deepEqual(accepted.goals.slice(0, 2), ['done', 'active']);
});

test('a new reward updates existing guide progress on a bag event', () => {
	const [before, after] = run('', `
emit(snapshot())
stub.world.addItem(5175, 1); stub.advance(0.25)
emit(snapshot())
`);
	assert.equal(before.step, 1);
	assert.deepEqual(after, satisfied);
});

test('login reads an accepted quest at 3/5; objective completion still requires a turn-in', () => {
	const [partial, ready, turnedIn] = run(`
stub.world.onQuest(94373, { { type = "item", required = 5, fulfilled = 3 } })
stub.world.items[264356] = 3`, `
local function progress()
 return { accept = E.GetStepView(1).goals[1].status,
  collect = E.GetStepView(2).goals[1], turnin = E.GetStepView(3).goals[1].status }
end
emit(progress())
stub.world.finish(94373); stub.advance(0.25); emit(progress())
stub.world.turnIn(94373); stub.advance(0.25); emit(progress())
`);
	assert.equal(partial.accept, 'done');
	assert.equal(partial.collect.status, 'active');
	assert.deepEqual(partial.collect.progress, { cur: 3, max: 5, kind: 'count' });
	assert.equal(partial.turnin, 'pending');
	assert.equal(ready.collect.status, 'done');
	assert.deepEqual(ready.collect.progress, { cur: 5, max: 5, kind: 'count' });
	assert.equal(ready.turnin, 'active');
	assert.equal(turnedIn.turnin, 'done');
});

test('reward checks include only the personal bank; ordinary bag counts retain their old scope', () => {
	const [out, bagCount] = run(`
C_Item.GetItemCount = function(id, bank, uses, reagentBank, accountBank)
 assert(not accountBank, "another character's items must not satisfy a guide")
 return id == 5175 and bank and 1 or 0
end`, 'emit(snapshot()); emit(Polestar.Compat.GetItemCount(5175))');
	assert.deepEqual(out, satisfied);
	assert.equal(bagCount, 0);
});

test('an unavailable item API cannot satisfy a goal', () => {
	const [out] = run('C_Item.GetItemCount = nil; GetItemCount = nil');
	assert.equal(out.step, 1);
	assert.equal(out.goals.filter((s) => s === 'done').length, 0);
});
