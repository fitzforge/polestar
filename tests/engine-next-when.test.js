'use strict';
// conditional hand-offs at runtime. A route option whose
// `nextWhen` predicate is false is not offered; with one option left the
// guide continues there without asking; Guides.Validate checks nextWhen.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };
const PACK2 = 'Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 2, title = "Test", author = "Test", version = "1", license = "MIT" })';

const WORLD = `
local w = stub.world
w.addMap(1411, { name = "Durotar", c = 1, left = -3000, right = -6000, top = 1000, bottom = -2000 })
w.addMap(1413, { name = "The Barrens", c = 1, left = 0, right = -3000, top = 1000, bottom = -2000 })
w.race, w.raceName, w.faction, w.class = "Orc", "Orc", "Horde", "WARRIOR"
w.moveTo(1411, 52, 43)
`;

// Durotar hands over to the mage route (only for mages), the Barrens (only
// while quest 99 is not turned in) or the Valley (always).
const GUIDES = `
Polestar.RegisterGuide({ id = "test/durotar", pack = "test", title = "Durotar", faction = "Horde", minLevel = 1, maxLevel = 10,
	next = "test/mage", nextChoices = { "test/mage", "test/barrens", "test/valley" },
	nextWhen = { ["test/mage"] = { "class", { "MAGE" } }, ["test/barrens"] = { "not", { "turnedin", 99 } } },
	steps = {
		{ goals = { { t = "accept", quest = 1, title = "Your Place In The World", map = 1411, x = 42, y = 68 } } },
		{ goals = { { t = "turnin", quest = 1, title = "Your Place In The World", map = 1411, x = 52, y = 43 } } },
} })
Polestar.RegisterGuide({ id = "test/mage", pack = "test", title = "Mage road", faction = "Horde", minLevel = 10, maxLevel = 20, steps = { { goals = { { t = "level", level = 20 } } } } })
Polestar.RegisterGuide({ id = "test/barrens", pack = "test", title = "The Barrens", faction = "Horde", minLevel = 10, maxLevel = 20, zone = 1413, steps = { { goals = { { t = "level", level = 20 } } } } })
Polestar.RegisterGuide({ id = "test/valley", pack = "test", title = "The Valley", faction = "Horde", minLevel = 10, maxLevel = 20, steps = { { goals = { { t = "level", level = 20 } } } } })
`;

const HELPERS = `
E = Polestar.Engine
w = stub.world
function flush() stub.advance(0.25) end
LOG = {}
for _, m in ipairs({ "ROUTE_CHOICE", "GUIDE_CHANGED" }) do
	Polestar.On(m, function(a) LOG[#LOG + 1] = m .. " " .. tostring(a) end)
end
function takeLog() local l = LOG; LOG = {}; return l end
function finish()
	w.accept(1, {}); flush()
	w.finish(1); w.turnIn(1); flush()
end
function optionIds(c)
	local out = {}
	for i, o in ipairs(c and c.options or {}) do out[i] = o.id end
	return out
end
`;

function run(script, before = '') {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD + before,
		addons: [CORE],
		script: `${PACK2}\n${TEST_SOURCE}\n${GUIDES}\n${HELPERS}\nstub.login()\n${script}`,
	}).emitted;
}

test('options whose condition is false are not offered; two left: the player is asked', () => {
	const [out] = run(`
		E.SetGuide("test/durotar"); flush(); takeLog()
		finish()
		emit({ log = takeLog(), options = optionIds(E.GetRouteChoice("test/durotar")) })
	`);
	assert.deepEqual(out.options, ['test/barrens', 'test/valley']);
	assert.ok(out.log.includes('ROUTE_CHOICE test/durotar'), JSON.stringify(out.log));
});

test('one option left: the guide continues there without asking', () => {
	const [out] = run(`
		E.SetGuide("test/durotar"); flush(); takeLog()
		finish()
		emit({ log = takeLog(), guide = E.GetGuide().id })
	`, 'stub.world.completed[99] = true');
	assert.equal(out.guide, 'test/valley');
	assert.ok(!out.log.includes('ROUTE_CHOICE test/durotar'), JSON.stringify(out.log));
});

test('a mage gets the mage road among the options', () => {
	const [out] = run(`
		E.SetGuide("test/durotar"); flush()
		finish()
		emit(optionIds(E.GetRouteChoice("test/durotar")))
	`, 'stub.world.class, stub.world.className = "MAGE", "Mage"');
	assert.deepEqual(out, ['test/mage', 'test/barrens', 'test/valley']);
});

test('Guides.Validate checks nextWhen', () => {
	const out = run(`
		local function def(nc, nw) return { id = "test/x", pack = "test", title = "X", next = nc and nc[1], nextChoices = nc, nextWhen = nw, steps = { { goals = { { t = "level", level = 2 } } } } } end
		emit(Polestar.Guides.Validate(def({ "test/a", "test/b" }, { ["test/a"] = { "level", ">=", 5 } })) == nil)
		emit(Polestar.Guides.Validate(def({ "test/a", "test/b" }, { ["test/c"] = { "level", ">=", 5 } })))
		emit(Polestar.Guides.Validate(def({ "test/a", "test/b" }, { ["test/a"] = { "bogus" } })))
		emit(Polestar.Guides.Validate(def({ "test/a", "test/b" }, "x")))
		emit(Polestar.Guides.Validate(def(nil, { ["test/a"] = { "level", ">=", 5 } })))
	`);
	assert.equal(out[0], true);
	for (let i = 1; i < out.length; i++) assert.match(out[i], /^bad nextWhen/, `case ${i}: ${out[i]}`);
});
