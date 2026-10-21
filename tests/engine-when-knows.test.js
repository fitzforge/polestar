'use strict';
// `when knows` during play (addon/Polestar/Core/Engine.lua,
// Own.predicateHolds): the step applies while the character knows the spell
// (Compat.IsSpellKnown, else Compat.IsPlayerSpell). Learning one re-evaluates
// the guide (SPELLS_CHANGED), and a step the route has passed keeps its
// stored outcome. Real Core manifest, stub world (a level 1 Human Warrior in
// Elwynn Forest), as tests/engine-when-cooldown.test.js.

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
	id = "test/knows", pack = "test", title = "Knows", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Train Charge", when = ${when}, goals = {
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

const KNOWS = '{ { k = "knows", spell = 100 } }';
const NOT_KNOWN = '{ { k = "knows", spell = 100, neg = true } }';

function run({ when, login = '', script }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [CORE],
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/knows" }' },
		script: `${TEST_PACK}
${TEST_SOURCE}\n${guide(when)}\n${HELPERS}\nstub.login()\n${login}\nstub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)\n${script}`,
	}).emitted;
}

test('`when knows` applies while the spell is known; `!knows` while it is not', () => {
	const [unknown] = run({ when: KNOWS, script: 'emit(state())' });
	assert.deepEqual(unknown, { live: 3, status: 'skipped' });
	const [known] = run({ when: KNOWS, login: 'stub.world.spells[100] = true', script: 'emit(state())' });
	assert.deepEqual(known, { live: 2, status: 'current' });
	const [toTrain] = run({ when: NOT_KNOWN, script: 'emit(state())' });
	assert.deepEqual(toTrain, { live: 2, status: 'current' });
	const [trained] = run({ when: NOT_KNOWN, login: 'stub.world.spells[100] = true', script: 'emit(state())' });
	assert.deepEqual(trained, { live: 3, status: 'skipped' });
});

test('a spell the spellbook check does not list but IsPlayerSpell knows counts (a weapon skill)', () => {
	const [known] = run({ when: KNOWS, login: 'C_SpellBook.IsSpellKnown = function() return false end; IsPlayerSpell = function(id) return id == 100 end', script: 'emit(state())' });
	assert.deepEqual(known, { live: 2, status: 'current' });
});

test('learning the spell re-evaluates the guide before the route has passed the step', () => {
	// Before the quest log is read nothing is stored, so step 2 is decided live.
	const [before, learned] = run({
		when: NOT_KNOWN,
		login: 'flush(); emit(state()); stub.world.learnSpell(100); flush(); emit(state())',
		script: '',
	});
	assert.deepEqual(before, { live: 2, status: 'current' });
	assert.deepEqual(learned, { live: 3, status: 'na' });
});

test('a step the route has passed keeps its stored outcome when the spell is learned later', () => {
	const [passed, later] = run({
		when: KNOWS,
		script: 'emit(state()); stub.world.learnSpell(100); flush(); emit(state())',
	});
	assert.deepEqual(passed, { live: 3, status: 'skipped' });
	assert.deepEqual(later, { live: 3, status: 'skipped' });
});

test('Guides.Validate takes a knows predicate with a spell id, and refuses one without', () => {
	const [rows] = runAddon({
		stubs: ['stub_world.lua'],
		addons: [CORE],
		script: `
			local V = Polestar.Guides.Validate
			local function g(pred) return { id = "t/v", pack = "test", title = "V", minLevel = 1, maxLevel = 10, steps = { { when = { pred }, goals = { { t = "note", text = "x" } } } } } end
			emit({
				spell = V(g({ k = "knows", spell = 100, neg = true })) or "ok",
				none = V(g({ k = "knows" })) or "ok",
				name = V(g({ k = "knows", spell = "Charge" })) or "ok",
			})
		`,
	}).emitted;
	assert.equal(rows.spell, 'ok');
	assert.match(rows.none, /bad when/);
	assert.match(rows.name, /bad when/);
});
