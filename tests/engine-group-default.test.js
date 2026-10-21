'use strict';
// The answer for every group quest (behavior.groupQuests, Options, Guide,
// Automation, Quests): "ask" (the default) asks at each `when group` step,
// "do" and "skip" answer every quest the player has not answered one by one,
// so the route never waits. An answer given for one quest (Engine.AnswerGroup,
// the banner, Discovery > Group quests) wins over it. Same world and guides as
// tests/engine-when-group.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');
const { luaValue } = require('../tools/lib/playtest');

const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
w.titles[7] = "Kobold Camp Cleanup"
w.onQuest(783, {})
`;

const GROUP_GUIDE = `
Polestar.RegisterGuide({
	id = "test/group", pack = "test", title = "Group", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Group quest", when = { { k = "group", q = 7 } }, goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "The solo way", when = { { k = "group", q = 7, neg = true } }, goals = { { t = "task", text = "Pull one at a time" } } },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
`;

function run({ all, answers, script }) {
	const char = { schema: 1, guide: 'test/group', ...(answers ? { groupQuests: answers } : {}) };
	const account = all ? `PolestarDB = { schema = 1, settings = { behavior = { groupQuests = ${luaValue(all)} } } }\n` : '';
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		saved: { Polestar: `${account}PolestarCharDB = ${luaValue(char)}` },
		script: `${TEST_PACK}
${TEST_SOURCE}\n${GROUP_GUIDE}
E = Polestar.Engine
function flush() stub.advance(0.25) end
stub.login()\nstub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)\n${script}`,
	}).emitted;
}

const STATE = 'emit({ at = E.GetLiveStep(), q = E.GroupQuestion() or false, answer = E.GroupAnswer(7) or false, s1 = E.GetStepView(1).status, s2 = E.GetStepView(2).status })';

test('group quests: "ask" (the default) waits at the step and asks', () => {
	const [rows] = run({ script: STATE });
	assert.deepEqual(rows, { at: 1, q: 7, answer: false, s1: 'current', s2: 'upcoming' });
});

test('group quests: "skip" takes the solo way without asking; "do" the group way', () => {
	const [skip] = run({ all: 'skip', script: STATE });
	assert.equal(skip.q, false, 'nothing to ask');
	assert.equal(skip.answer, 'skip');
	assert.equal(skip.s1, 'skipped');
	assert.equal(skip.at, 2, 'the solo step');
	const [doIt] = run({ all: 'do', script: STATE });
	assert.deepEqual(doIt, { at: 1, q: false, answer: 'do', s1: 'current', s2: 'na' });
});

test('group quests: an answer for one quest wins over the answer for all', () => {
	const [rows] = run({ all: 'skip', answers: { 7: 'do' }, script: STATE });
	assert.deepEqual(rows, { at: 1, q: false, answer: 'do', s1: 'current', s2: 'na' });
});

test('group quests: changing the answer for all re-evaluates the route', () => {
	const [asked, skipped] = run({ script: `${STATE}\nPolestar.Set("behavior.groupQuests", "skip"); flush()\n${STATE}` });
	assert.equal(asked.q, 7);
	assert.equal(skipped.q, false);
	assert.equal(skipped.at, 2);
});
