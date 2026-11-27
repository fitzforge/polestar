'use strict';
// `goto … nearest` in the real Engine: a "Go to an anvil" step's places are smart-target `candidates`. The arrow leads
// to the nearest of the character's faction, and arriving at any of them (the one the arrow picked or another)
// finishes the step. The compiler side: tests/dsl-goto-nearest.test.js. Real Core manifest, stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const WORLD = `
local w = stub.world
w.addMap(1411, { name = "Durotar", c = 1, left = -1000, right = -3000, top = 0, bottom = -2000 })
w.addMap(1454, { name = "Orgrimmar", c = 1, left = -1500, right = -2000, top = 2000, bottom = 1500 })
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = -1000, right = -3000, top = -3000, bottom = -5000 })
w.race, w.raceName, w.faction, w.class, w.className = "Orc", "Orc", "Horde", "WARRIOR", "Warrior"
w.level = 20
w.moveTo(1411, 50, 50)
w.zone, w.subzone = "Durotar", "Razor Hill"
`;

// Anvils: Orgrimmar and Razor Hill (Horde), Goldshire (Alliance).
const GUIDE = `
Polestar.RegisterGuide({ id = "test/anvil", pack = "test", title = "Blacksmithing", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Go to an anvil", goals = { { t = "goto", text = "Anvil", candidates = {
		{ map = 1454, x = 80, y = 23, faction = "H" },
		{ map = 1411, x = 52, y = 41, faction = "H" },
		{ map = 1429, x = 41, y = 65, faction = "A" },
	} } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;

function run(script) {
	const { emitted } = runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		script: `${TEST_PACK}
${TEST_SOURCE}
${GUIDE}
E = Polestar.Engine
local w = stub.world
stub.login()
E.SetGuide("test/anvil")
stub.advance(0.6)
local function here() local wp = E.GetWaypoint(); return wp and { wp.map, wp.x, wp.y } or false end
${script}`,
	});
	return emitted[0];
}

test('the arrow takes the nearest anvil of the faction: Razor Hill for an Orc in Durotar', () => {
	const out = run('emit({ wp = here(), step = E.GetStepIndex() })');
	assert.deepEqual(out.wp, [1411, 52, 41]);
	assert.equal(out.step, 1);
});

test('arriving at any of the places finishes the step, the one the arrow picked or another', () => {
	const picked = run(`
w.moveTo(1411, 52, 41); stub.advance(1.2)
emit({ step = E.GetStepIndex() })`);
	assert.equal(picked.step, 2, 'at Razor Hill');
	const other = run(`
w.moveTo(1454, 80, 23); w.zone, w.subzone = "Orgrimmar", "Valley of Honor"
stub.fire("ZONE_CHANGED_NEW_AREA"); stub.advance(1.2)
emit({ step = E.GetStepIndex() })`);
	assert.equal(other.step, 2, 'at Orgrimmar, which the arrow did not pick first');
});

test("another faction's anvil does not count", () => {
	const out = run(`
w.moveTo(1429, 41, 65); w.zone, w.subzone = "Elwynn Forest", "Goldshire"
stub.fire("ZONE_CHANGED_NEW_AREA"); stub.advance(1.2)
emit({ step = E.GetStepIndex() })`);
	assert.equal(out.step, 1);
});
