'use strict';
// Abandon and destroy (addon/Polestar/Core/Engine.lua): an `abandon` goal is
// done once its quest is out of the log, a `destroy` goal once its item is out
// of the bags, and both stay done for the rest of the step. Real Core
// manifest, stub world (a level 1 Human Warrior in Elwynn Forest).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
`;

// Step 2 holds `goals` (Lua) and, when given, `when`; steps 1 and 3 are plain.
function guide(goals, when) {
	return `
Polestar.RegisterGuide({
	id = "test/abandon", pack = "test", title = "Abandon", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Middle", ${when ? `when = ${when}, ` : ''}goals = ${goals} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
`;
}

const HELPERS = `
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- The live step and step 2's goals as status:text.
function state()
	local v = E.GetStepView(2)
	local goals = {}
	for i, g in ipairs(v.goals) do goals[i] = g.status .. ":" .. (g.text or "") end
	return { live = E.GetLiveStep(), status = v.status, goals = goals }
end
`;

function run({ goals, when, before = '', script, onQuest = true, shape = (text) => text }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD + (onQuest ? 'w.onQuest(783, {})\n' : '') + before,
		addons: [CORE],
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/abandon" }' },
		script: `${TEST_PACK}
${TEST_SOURCE}\n${shape(guide(goals, when))}\n${HELPERS}\nstub.login()\nstub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)\n${script}`,
	}).emitted;
}

test('an abandon goal is done once its quest is out of the log, and the accept before it stays done', () => {
	const [inLog, gone] = run({
		goals: '{ { t = "abandon", quest = 783, title = "A Threat Within" }, { t = "train", npc = 911, npcName = "Llane Beshere" } }',
		script: `
			emit(state())
			stub.world.abandon(783); flush()
			emit(state())
		`,
	});
	assert.deepEqual(inLog, { live: 2, status: 'current', goals: ['active:Abandon A Threat Within', 'active:Train at Llane Beshere'] });
	assert.deepEqual(gone, { live: 2, status: 'current', goals: ['done:Abandon A Threat Within', 'active:Train at Llane Beshere'] });
	// Looking ahead past the abandon before taking the quest does not pass the accept.
	const [ahead] = run({
		goals: '{ { t = "abandon", quest = 783, title = "A Threat Within" } }',
		onQuest: false,
		script: 'E.Next(); E.Next(); flush(); emit(E.GetLiveStep())',
	});
	assert.equal(ahead, 1);
});

test('an accept after the abandon (taking the quest again) is not done by it', () => {
	// Step 3 takes A Threat Within again instead of handing it in.
	const [rows] = run({
		goals: '{ { t = "abandon", quest = 783, title = "A Threat Within" } }',
		shape: (text) => text.replace('{ t = "turnin", quest = 783', '{ t = "accept", quest = 783'),
		script: 'stub.world.abandon(783); flush(); emit({ live = E.GetLiveStep(), s1 = E.GetStepView(1).status, s3 = E.GetStepView(3).goals[1].status })',
	});
	assert.deepEqual(rows, { live: 3, s1: 'done', s3: 'active' });
});

test('a destroy goal is done once the item is out of the bags and stays done for its step', () => {
	const [held, destroyed, back] = run({
		goals: '{ { t = "destroy", item = 6948, itemName = "Hearthstone" }, { t = "train", npc = 911, npcName = "Llane Beshere" } }',
		before: 'w.addItem(6948, 1)',
		script: `
			emit(state())
			stub.world.removeItem(6948); flush()
			emit(state())
			stub.world.addItem(6948, 1); flush()
			emit(state())
		`,
	});
	assert.deepEqual(held, { live: 2, status: 'current', goals: ['active:Destroy Hearthstone', 'active:Train at Llane Beshere'] });
	assert.equal(destroyed.goals[0], 'done:Destroy Hearthstone');
	assert.equal(back.goals[0], 'done:Destroy Hearthstone');
});

// Steps of one goal each, as Lua: accept, abandon and turnin of A Threat Within.
const GOAL = {
	accept: '{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 }',
	abandon: '{ t = "abandon", quest = 783, title = "A Threat Within" }',
	turnin: '{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 }',
};
function route(kinds) {
	const steps = kinds.map((k, i) => `{ title = "Step ${i + 1}", goals = { ${GOAL[k]} } }`).join(',\n\t\t');
	return `
Polestar.RegisterGuide({
	id = "test/abandon", pack = "test", title = "Abandon", minLevel = 1, maxLevel = 10,
	steps = {
		${steps}
	},
})
`;
}

test('a passed abandon stays done when the guide takes the quest again', () => {
	// The guide drops the quest, then takes it again and hands it in.
	const [rows] = run({
		shape: () => route(['accept', 'abandon', 'accept', 'turnin']),
		onQuest: false,
		script: `
			stub.world.accept(783, {}); flush()
			stub.world.abandon(783); flush()
			stub.world.accept(783, {}); flush()
			emit({ live = E.GetLiveStep(), s2 = E.GetStepView(2).status })
		`,
	});
	assert.deepEqual(rows, { live: 4, s2: 'done' });
});

test('an abandon of a quest the character never had is done at once and stays done once the guide takes it', () => {
	const [start, taken] = run({
		shape: () => route(['abandon', 'accept', 'turnin']),
		onQuest: false,
		script: `
			emit({ live = E.GetLiveStep(), s1 = E.GetStepView(1).goals[1].status })
			stub.world.accept(783, {}); flush()
			emit({ live = E.GetLiveStep(), s1 = E.GetStepView(1).status })
		`,
	});
	assert.deepEqual(start, { live: 2, s1: 'done' });
	assert.deepEqual(taken, { live: 3, s1: 'done' });
});
