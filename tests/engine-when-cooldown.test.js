'use strict';
// `when cooldown` during play (addon/Polestar/Core/Engine.lua, Own.onCooldown):
// the step applies while the item (Compat.GetItemCooldown) or spell
// (Compat.GetSpellCooldown) is on cooldown, the global cooldown (1.5 s or
// less) aside. A cooldown starting re-evaluates the guide
// (BAG_UPDATE_COOLDOWN, SPELL_UPDATE_COOLDOWN), and so does its end, which
// has no event (a timer). A step the route has passed keeps its stored
// outcome. Real Core manifest, stub world (a level 1 Human Warrior in Elwynn
// Forest), as tests/engine-when-dungeon.test.js; the cooldowns are faked here
// on the stub clock.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

// CD[6948] = { start, duration } for an item, CD["s" .. id] for a spell.
const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
w.onQuest(783, {})
CD = {}
C_Container = C_Container or {}
function C_Container.GetItemCooldown(id) local c = CD[id]; if not c then return 0, 0, 1 end; return c[1], c[2], 1 end
C_Spell = C_Spell or {}
function C_Spell.GetSpellCooldown(id) local c = CD["s" .. id]; return { startTime = c and c[1] or 0, duration = c and c[2] or 0, isEnabled = true, modRate = 1 } end
`;

// Step 2 is the conditional one, between taking and handing in A Threat
// Within: `when` is Lua for its predicates.
function guide(when) {
	return `
Polestar.RegisterGuide({
	id = "test/cd", pack = "test", title = "Cooldown", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Walk", when = ${when}, goals = {
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

const HEARTH = '{ { k = "cooldown", item = 6948 } }';
const HEARTH_READY = '{ { k = "cooldown", item = 6948, neg = true } }';

function run({ when, login = '', script }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [CORE],
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/cd" }' },
		script: `${TEST_PACK}
${TEST_SOURCE}\n${guide(when)}\n${HELPERS}\nstub.login()\n${login}\nstub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)\n${script}`,
	}).emitted;
}

test('`when cooldown item` applies while the item cools down; `!cooldown` while it is ready; the global cooldown does not count', () => {
	const [ready] = run({ when: HEARTH, script: 'emit(state())' });
	assert.deepEqual(ready, { live: 3, status: 'skipped' });
	const [cooling] = run({ when: HEARTH, login: 'CD[6948] = { GetTime(), 1800 }', script: 'emit(state())' });
	assert.deepEqual(cooling, { live: 2, status: 'current' });
	const [gcd] = run({ when: HEARTH, login: 'CD[6948] = { GetTime(), 1.5 }', script: 'emit(state())' });
	assert.deepEqual(gcd, { live: 3, status: 'skipped' });
	const [notReady] = run({ when: HEARTH_READY, login: 'CD[6948] = { GetTime(), 1800 }', script: 'emit(state())' });
	assert.deepEqual(notReady, { live: 3, status: 'skipped' });
	const [isReady] = run({ when: HEARTH_READY, script: 'emit(state())' });
	assert.deepEqual(isReady, { live: 2, status: 'current' });
});

test('`when cooldown spell` reads the spell\'s cooldown', () => {
	const [cooling] = run({ when: '{ { k = "cooldown", spell = 8690 } }', login: 'CD.s8690 = { GetTime(), 600 }', script: 'emit(state())' });
	assert.deepEqual(cooling, { live: 2, status: 'current' });
	const [other] = run({ when: '{ { k = "cooldown", spell = 8690 } }', login: 'CD.s1234 = { GetTime(), 600 }', script: 'emit(state())' });
	assert.deepEqual(other, { live: 3, status: 'skipped' });
});

test('a cooldown starting re-evaluates the guide, and so does its end, before the route has passed the step', () => {
	// Before the quest log is read nothing is stored, so step 2 is decided live.
	const [before, started, ended] = run({
		when: HEARTH,
		login: `
			flush(); emit(state())
			CD[6948] = { GetTime(), 30 }; stub.fire("BAG_UPDATE_COOLDOWN"); flush(); emit(state())
			stub.advance(31); emit(state())
		`,
		script: '',
	});
	assert.deepEqual(before, { live: 3, status: 'na' });
	assert.deepEqual(started, { live: 2, status: 'current' });
	assert.deepEqual(ended, { live: 3, status: 'na' });
});

test('a step the route has passed keeps its stored outcome when the cooldown starts later', () => {
	const [passed, later] = run({
		when: HEARTH,
		script: 'emit(state()); CD[6948] = { GetTime(), 1800 }; stub.fire("BAG_UPDATE_COOLDOWN"); flush(); emit(state())',
	});
	assert.deepEqual(passed, { live: 3, status: 'skipped' });
	assert.deepEqual(later, { live: 3, status: 'skipped' });
});

test('Guides.Validate takes a cooldown predicate with one item or one spell, and refuses others', () => {
	const [rows] = runAddon({
		stubs: ['stub_world.lua'],
		addons: [CORE],
		script: `
			local V = Polestar.Guides.Validate
			local function g(pred) return { id = "t/v", pack = "test", title = "V", minLevel = 1, maxLevel = 10, steps = { { when = { pred }, goals = { { t = "note", text = "x" } } } } } end
			emit({
				item = V(g({ k = "cooldown", item = 6948 })) or "ok",
				spell = V(g({ k = "cooldown", spell = 8690, neg = true })) or "ok",
				both = V(g({ k = "cooldown", item = 6948, spell = 8690 })) or "ok",
				none = V(g({ k = "cooldown" })) or "ok",
			})
		`,
	}).emitted;
	assert.equal(rows.item, 'ok');
	assert.equal(rows.spell, 'ok');
	assert.match(rows.both, /bad when/);
	assert.match(rows.none, /bad when/);
});
