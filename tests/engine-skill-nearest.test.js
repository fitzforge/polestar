'use strict';
// `skill <Profession> <N> nearest` in the real Engine (#2529): the goal's places are smart-target `candidates`, so the
// arrow leads to the one nearest the player and of their faction (and race, where a place names one), picked again when
// the player changes zones; the skill rank alone finishes the goal. The compiler side: tests/dsl-skill-nearest.test.js.
// Real Core manifest, stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

// Kalimdor (continent 1): Durotar, Mulgore, Orgrimmar. Eastern Kingdoms (continent 0): Tirisfal Glades, Elwynn Forest.
// The reporter of #2529: an Undead character in Orgrimmar.
const WORLD = `
local w = stub.world
w.addMap(1411, { name = "Durotar", c = 1, left = -1000, right = -3000, top = 0, bottom = -2000 })
w.addMap(1412, { name = "Mulgore", c = 1, left = 1000, right = -1000, top = -2000, bottom = -4000 })
w.addMap(1454, { name = "Orgrimmar", c = 1, left = -1500, right = -2000, top = 2000, bottom = 1500 })
w.addMap(1420, { name = "Tirisfal Glades", c = 0, left = 3000, right = 0, top = 3000, bottom = 1000 })
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = -1000, right = -3000, top = -3000, bottom = -5000 })
w.race, w.raceName, w.faction, w.class, w.className = "Scourge", "Undead", "Horde", "WARLOCK", "Warlock"
w.level = 23
w.moveTo(1454, 68, 36)
w.zone, w.subzone = "Orgrimmar", "Valley of Honor"
w.skills = w.skills or {}
`;

// The fishing guide's 1-50 waters: one per starting area, Zephras Isle's for Skyborne only.
const GUIDE = `
Polestar.RegisterGuide({ id = "test/fishing", pack = "test", title = "Fishing", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Fishing 1-50", goals = { { t = "skill", skill = "Fishing", skillLine = 356, level = 50, candidates = {
		{ map = 1429, x = 47.4, y = 62.2, faction = "A", races = { "Human" } },
		{ map = 1411, x = 53.2, y = 81.5, faction = "H", races = { "Orc", "Troll" } },
		{ map = 1412, x = 44.4, y = 60.6, faction = "H", races = { "Tauren" } },
		{ map = 1420, x = 67.1, y = 50.9, faction = "H", races = { "Scourge" } },
	} } } },
	{ goals = { { t = "level", level = 60 } } },
} })
Polestar.RegisterGuide({ id = "test/anywater", pack = "test", title = "Fishing", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Fishing 1-50", goals = { { t = "skill", skill = "Fishing", skillLine = 356, level = 50, candidates = {
		{ map = 1429, x = 47.4, y = 62.2, faction = "A" },
		{ map = 1411, x = 53.2, y = 81.5, faction = "H" },
		{ map = 1412, x = 44.4, y = 60.6, faction = "H" },
		{ map = 1420, x = 67.1, y = 50.9, faction = "H" },
	} } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;

function run(guide, script) {
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
E.SetGuide("${guide}")
stub.advance(0.6)
local function here() local wp = E.GetWaypoint(); return wp and { wp.map, wp.x, wp.y } or false end
${script}`,
	});
	return emitted[0];
}

test('the places are for their own characters: an Undead in Orgrimmar goes to the Undead water, as before', () => {
	const out = run('test/fishing', 'emit({ wp = here() })');
	assert.deepEqual(out.wp, [1420, 67.1, 50.9]);
});

test('every water of the faction: an Undead in Orgrimmar fishes the Durotar shore, not Tirisfal across the sea (#2529)', () => {
	const out = run('test/anywater', `
local first = here()
local v = E.GetStepView(1).goals[1]
w.moveTo(1420, 60, 50); w.zone, w.subzone = "Tirisfal Glades", "Brill"
stub.fire("ZONE_CHANGED_NEW_AREA"); stub.advance(0.6)
emit({ first = first, alternatives = v.alternatives, text = v.text, home = here() })`);
	assert.deepEqual(out.first, [1411, 53.2, 81.5], 'the nearest Horde water on the same continent');
	assert.equal(out.alternatives, 2, 'the other Horde waters are alternatives; the Alliance one is not');
	assert.equal(out.text, 'Raise Fishing to 50');
	assert.deepEqual(out.home, [1420, 67.1, 50.9], 'back home, the Tirisfal water');
});
