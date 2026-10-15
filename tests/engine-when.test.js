'use strict';
// Format-2 `when` predicates at runtime: Core/Guides.lua accepts format-2
// packs and validates each step's `when`; Core/Engine.lua treats a step whose
// `when` is false as not applicable, re-checking on quest, bag, level and
// zone events.

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

// Step 2 only while on quest 999 (never); step 4 only while holding item 750;
// step 5 only below level 3.
const GUIDE = `
Polestar.RegisterGuide({
	id = "test/01-when", pack = "test", title = "When",
	faction = "Alliance", races = { "Human" }, minLevel = 1, maxLevel = 6, zone = 1429,
	steps = {
		{ title = "Willem", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
		{ title = "Never", when = { "onquest", 999 }, goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } },
		{ title = "McBride", goals = { { t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Candle", when = { "item", 750, ">=", 1 }, goals = { { t = "level", level = 5 } } },
		{ title = "Low", when = { "level", "<", 3 }, goals = { { t = "level", level = 3 } } },
		{ title = "End", goals = { { t = "level", level = 6 } } },
	},
})
`;

const RECORDER = `
function flush() stub.advance(0.25) end
E = Polestar.Engine
`;

function run(script, { pack = PACK2, guides = GUIDE } = {}) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [CORE],
		script: `${pack}\n${TEST_SOURCE}\n${guides}\n${RECORDER}\nstub.login()\n${script}`,
	}).emitted;
}

test('format-2 and format-3 packs are accepted; format 4 is still too new', () => {
	const [two] = run('emit(Polestar.Guides.Pack("test").status)');
	assert.equal(two, 'on');
	const [three] = run('emit(Polestar.Guides.Pack("test").status)', { pack: PACK2.replace('format = 2', 'format = 3') });
	assert.equal(three, 'on');
	const [four] = run('emit(Polestar.Guides.Pack("test").status)', { pack: PACK2.replace('format = 2', 'format = 4') });
	assert.equal(four, 'too-new');
});

test('Guides.Validate checks `when` with Predicate.Validate', () => {
	const out = run(`
		local function def(when)
			return { id = "test/x", pack = "test", title = "X", steps = { { when = when, goals = { { t = "level", level = 2 } } } } }
		end
		emit(Polestar.Guides.Validate(def({ "onquest", 7 })) == nil)
		emit(Polestar.Guides.Validate(def({ "bogus", 1 })))
		emit(Polestar.Guides.Validate(def("onquest 7")))
	`);
	assert.equal(out[0], true);
	assert.match(out[1], /^step 1: bad when/);
	assert.match(out[2], /^step 1: bad when/);
});

test('a step whose `when` is false is passed over; it comes back when the condition turns true', () => {
	const out = run(`
		local w = stub.world
		flush()
		emit(E.GetStepIndex())              -- 1: accept 783
		w.accept(783, {}); flush()
		emit(E.GetStepIndex())              -- 3: step 2 needs quest 999
		w.turnIn(783); flush()
		emit(E.GetStepIndex())              -- 5: no item 750, level 1 < 3
		w.addItem(750, 1); flush()
		emit(E.GetStepIndex())              -- 4: holding the item now
		w.setLevel(5); flush()
		emit(E.GetStepIndex())              -- 6: step 4 done (level 5), step 5 no longer applies
	`);
	assert.deepEqual(out, [1, 3, 5, 4, 6]);
});

test('a step without `when` behaves exactly as before', () => {
	const plain = GUIDE.replace(/when = \{[^}]*\}, /g, '');
	assert.doesNotMatch(plain, /when =/);
	const out = run(`
		local w = stub.world
		flush()
		w.accept(783, {}); flush()
		emit(E.GetStepIndex())
	`, { guides: plain, pack: PACK2.replace('format = 2', 'format = 1') });
	assert.deepEqual(out, [2]);
});
