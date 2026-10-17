'use strict';
// Floors (docs/NAV_QA.md Z1, Z3): a compiled goal's `z` (the height of the
// NPC or object its point stands for, docs/GUIDE_FORMAT.md) rides on the
// Engine's waypoint while the waypoint is the goal's own point, or when a
// smart candidate carries its own `z`; a candidate without its own `z`, a
// spawn area elsewhere and a goal without `z` remain heightless.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

const WORLD = `
local w = stub.world
w.addMap(1458, { name = "Undercity", c = 0, left = 1000, right = 0, top = 2000, bottom = 1000 })
w.race, w.raceName, w.faction, w.class, w.className = "Scourge", "Undead", "Horde", "ROGUE", "Rogue"
w.level = 50
w.moveTo(1458, 10, 10)
w.zone, w.subzone = "Undercity", "Undercity"
`;

const GUIDE = `
Polestar.RegisterGuide({ id = "test/z", pack = "test", title = "Heights", category = "Leveling", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "talk", npc = 6522, npcName = "Andron Gant", map = 1458, x = 54.81, y = 76.33, z = -66 } } },
	{ goals = { { t = "kill", npc = 1, target = "Rat", count = 99, map = 1458, x = 40, y = 40, z = -40,
		spots = { { x = 40, y = 40, r = 15, n = 1 }, { x = 70, y = 70, r = 15, n = 1 } } } } },
	{ goals = { { t = "sethome", candidates = {
		{ npc = 6741, npcName = "Innkeeper Norman", map = 1458, x = 67, y = 38, faction = "H" },
	} } } },
	{ goals = { { t = "goto", map = 1458, x = 30, y = 30 } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;

function run(script) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [CORE],
		script: `${TEST_PACK}
${TEST_SOURCE}
${GUIDE}
			E = Polestar.Engine
			stub.login()
			${script}`,
	}).emitted;
}

test('Z1, Z3: the waypoint carries the goal\'s z at the goal\'s own point, or a candidate\'s own z', () => {
	const [out] = run(`
		E.SetGuide("test/z")
		local function z() local wp = E.GetWaypoint(); return wp and (wp.z or "none") or "no waypoint" end
		local r = { talk = z() }
		E.Goto(2)
		r.spotHere = z()
		E.CycleSpot(2, 1, 2)
		r.spotElsewhere = z()
		E.Goto(3)
		r.candidate = z()
		E.Goto(4)
		r.goto = z()
		emit(r)`);
	assert.equal(out.talk, -66, 'an NPC goal: its z');
	assert.equal(out.spotHere, -40, 'a spawn area at the goal\'s own point keeps it');
	assert.equal(out.spotElsewhere, 'none', 'another spawn area has none');
	assert.equal(out.candidate, 'none', 'a smart candidate without its own z remains heightless');
	assert.equal(out.goto, 'none', 'a goal without z has none');
});
