'use strict';
// `when skill` during play (addon/Polestar/Core/Engine.lua): the step applies
// while the character's rank in the profession (Compat.GetSkillRank, by skill
// line, else by name) is N or more; one not learned is rank 0, so `!skill X 1`
// is "has no X". A skill-up re-evaluates the guide (SKILL_LINES_CHANGED,
// CHAT_MSG_SKILL); a step the route has passed keeps its stored outcome. Real
// Core manifest, stub world (a level 1 Human Warrior in Elwynn Forest), as
// tests/engine-when-dungeon.test.js.

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
w.onQuest(783, {})
`;

// Step 2 is the conditional one, between taking and handing in A Threat
// Within: `when` is Lua for its predicates.
function guide(when) {
	return `
Polestar.RegisterGuide({
	id = "test/skill", pack = "test", title = "Skill", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Trainer", when = ${when}, goals = {
			{ t = "train", npc = 911, npcName = "Llane Beshere" },
		} },
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
function state() local v = E.GetStepView(2); return { live = E.GetLiveStep(), status = v.status } end
`;

const COOKING_50 = '{ { k = "skill", name = "Cooking", skillLine = 185, n = 50 } }';
const NO_HERBALISM = '{ { k = "skill", name = "Herbalism", skillLine = 182, n = 1, neg = true } }';

function run({ when, login = '', script }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [CORE],
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/skill" }' },
		script: `${TEST_PACK}
${TEST_SOURCE}\n${guide(when)}\n${HELPERS}\nstub.login()\n${login}\nstub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)\n${script}`,
	}).emitted;
}

test('`when skill` applies at the rank or above, not below or unlearned; `!skill X 1` applies while X is not learned', () => {
	const [none] = run({ when: COOKING_50, script: 'emit(state())' });
	assert.deepEqual(none, { live: 3, status: 'skipped' });
	const [below] = run({ when: COOKING_50, login: 'stub.world.learnSkill(185, "Cooking", 49, 75)', script: 'emit(state())' });
	assert.deepEqual(below, { live: 3, status: 'skipped' });
	const [at] = run({ when: COOKING_50, login: 'stub.world.learnSkill(185, "Cooking", 50, 75)', script: 'emit(state())' });
	assert.deepEqual(at, { live: 2, status: 'current' });
	const [unlearned] = run({ when: NO_HERBALISM, script: 'emit(state())' });
	assert.deepEqual(unlearned, { live: 2, status: 'current' });
	const [learned] = run({ when: NO_HERBALISM, login: 'stub.world.learnSkill(182, "Herbalism", 1, 75)', script: 'emit(state())' });
	assert.deepEqual(learned, { live: 3, status: 'skipped' });
});

test('without a skill line the profession is read by its name', () => {
	const [view] = run({ when: '{ { k = "skill", name = "Cooking", n = 50 } }', login: 'stub.world.learnSkill(185, "Cooking", 60, 75)', script: 'emit(state())' });
	assert.deepEqual(view, { live: 2, status: 'current' });
});

test('a skill-up re-evaluates the guide before the route has passed the step', () => {
	// Before the quest log is read nothing is stored, so step 2 is decided live.
	const [before, after] = run({
		when: COOKING_50,
		login: 'stub.world.learnSkill(185, "Cooking", 49, 75); stub.advance(0.25); emit(state()); stub.world.skillUp(185, 50); stub.advance(0.25); emit(state())',
		script: '',
	});
	assert.deepEqual(before, { live: 3, status: 'na' });
	assert.deepEqual(after, { live: 2, status: 'current' });
});

test('a step the route has passed keeps its stored outcome when the rank rises later', () => {
	const [passed, later] = run({
		when: COOKING_50,
		login: 'stub.world.learnSkill(185, "Cooking", 1, 75)',
		script: 'emit(state()); stub.world.skillUp(185, 50); flush(); emit(state())',
	});
	assert.deepEqual(passed, { live: 3, status: 'skipped' });
	assert.deepEqual(later, { live: 3, status: 'skipped' });
});

test('Guides.Validate takes a skill predicate with a name and rank, and refuses one without', () => {
	const [rows] = runAddon({
		stubs: ['stub_world.lua'],
		addons: [CORE],
		script: `
			local V = Polestar.Guides.Validate
			local function g(pred) return { id = "t/v", pack = "test", title = "V", minLevel = 1, maxLevel = 10, steps = { { when = { pred }, goals = { { t = "note", text = "x" } } } } } end
			emit({
				ok = V(g({ k = "skill", name = "Cooking", skillLine = 185, n = 50 })) or "ok",
				byName = V(g({ k = "skill", name = "Cooking", n = 50 })) or "ok",
				noRank = V(g({ k = "skill", name = "Cooking" })) or "ok",
				noName = V(g({ k = "skill", skillLine = 185, n = 50 })) or "ok",
			})
		`,
	}).emitted;
	assert.equal(rows.ok, 'ok');
	assert.equal(rows.byName, 'ok');
	assert.match(rows.noRank, /bad when/);
	assert.match(rows.noName, /bad when/);
});
