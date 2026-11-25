'use strict';
// Engine.ItemGuides: the guides whose steps use an item, the active one with its step, then the
// guides ahead along `next` (at most three, stopping at a repeat), steps for this character only.
// Real Core manifest, stub world; the QoL side: tests/qol-kept-line.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.race, w.faction, w.class, w.className, w.level = "Human", "Alliance", "WARRIOR", "Warrior", 10
`;

const HEAD = 'pack = "test", faction = "Alliance", minLevel = 1, maxLevel = 20, zone = 1429';
const GUIDES = `
Polestar.RegisterGuide({ id = "test/a", title = "A", ${HEAD}, next = "test/b", steps = {
	{ title = "Spare", goals = { { t = "level", level = 11 } } },
	{ title = "Use it", goals = { { t = "use", item = 900, itemName = "Thing 900", map = 1429, x = 30, y = 50 } } },
} })
Polestar.RegisterGuide({ id = "test/b", title = "B", ${HEAD}, next = "test/c", steps = {
	{ goals = { { t = "buy", item = 900, itemName = "Thing 900", npc = 1, npcName = "Vendor", map = 1429, x = 30, y = 50 } } },
	{ goals = { { t = "use", item = 901, itemName = "Thing 901", map = 1429, x = 30, y = 50 } } },
	{ goals = { { t = "use", item = 902, itemName = "Thing 902", only = { classes = { "MAGE" } }, map = 1429, x = 30, y = 50 } } },
	{ only = { classes = { "MAGE" } }, goals = { { t = "use", item = 903, itemName = "Thing 903", map = 1429, x = 30, y = 50 } } },
} })
Polestar.RegisterGuide({ id = "test/c", title = "C", ${HEAD}, next = "test/a", steps = {
	{ goals = { { t = "collect", item = 900, itemName = "Thing 900", map = 1429, x = 30, y = 50 } } },
} })
`;

function run(script) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		script: `${TEST_PACK}
${TEST_SOURCE}
${GUIDES}
E = Polestar.Engine
stub.login()
E.SetGuide("test/a")
stub.advance(0.6)
local function ids(list)
	if not list then return false end
	local t = {}
	for i, e in ipairs(list) do t[i] = e.guide.id .. ":" .. tostring(e.step) end
	return t
end
${script}`,
	}).emitted;
}

test('the active guide with its step, then the guides ahead; a loop back to the active guide stops', () => {
	const [out] = run('emit({ item = ids(E.ItemGuides(900)), later = ids(E.ItemGuides(901)), none = ids(E.ItemGuides(555)) })');
	assert.deepEqual(out.item, ['test/a:2', 'test/b:nil', 'test/c:nil']);
	assert.deepEqual(out.later, ['test/b:nil']);
	assert.equal(out.none, false);
});

test('steps and goals for another class are left out', () => {
	const [out] = run('emit({ goal = ids(E.ItemGuides(902)), step = ids(E.ItemGuides(903)) })');
	assert.equal(out.goal, false);
	assert.equal(out.step, false);
});

test('a second call answers the same from the cached index', () => {
	const [out] = run('emit({ a = ids(E.ItemGuides(901)), b = ids(E.ItemGuides(901)) })');
	assert.deepEqual(out.a, out.b);
});
