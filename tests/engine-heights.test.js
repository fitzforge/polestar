'use strict';
// Floors (docs/NAV_QA.md Z1, Z3): a compiled goal's `z` (the height of the
// NPC or object its point stands for, docs/GUIDE_FORMAT.md) rides on the
// Engine's waypoint while the waypoint is the goal's own point; a smart
// target's chosen candidate and a spawn spot carry their own `z` (#180); a
// goal, spot or candidate without one carries none.

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
		spots = { { x = 40, y = 40, r = 15, n = 1 }, { x = 70, y = 70, r = 15, n = 1 }, { x = 90, y = 90, z = -12, r = 15, n = 1 } } } } },
	{ goals = { { t = "sethome", candidates = {
		{ npc = 6741, npcName = "Innkeeper Norman", map = 1458, x = 67, y = 38, z = -61.5, faction = "H" },
	} } } },
	{ goals = { { t = "vendor", candidates = {
		{ npc = 4555, npcName = "Eleanor Rusk", map = 1458, x = 69, y = 49, faction = "H" },
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

test('Z1, Z3, #180: the waypoint carries the goal\'s z at its own point, a spot\'s or chosen candidate\'s own z', () => {
	const [out] = run(`
		E.SetGuide("test/z")
		local function z() local wp = E.GetWaypoint(); return wp and (wp.z or "none") or "no waypoint" end
		local function view(s) local g = E.GetStepView(s).goals[1]; return g.z or "none" end
		local r = { talk = z(), talkGroup = E.GetStepView(1).groups[1].z or "none" }
		E.Goto(2)
		r.spotHere = z()
		E.CycleSpot(2, 1, 2)
		r.spotElsewhere = z()
		E.CycleSpot(2, 1, 3)
		r.spotOwn = z()
		r.spotView = view(2)
		E.Goto(3)
		r.candidate = z()
		r.candidateView = view(3)
		E.Goto(4)
		r.candidateNone = z()
		E.Goto(5)
		r.goto = z()
		emit(r)`);
	assert.equal(out.talk, -66, 'an NPC goal: its z');
	assert.equal(out.talkGroup, -66, 'the step view\'s group (the header person a click points at) has it too');
	assert.equal(out.spotHere, -40, 'a spawn area at the goal\'s own point keeps it');
	assert.equal(out.spotElsewhere, 'none', 'another spawn area without its own z has none');
	assert.equal(out.spotOwn, -12, 'a spawn area with its own z: that z');
	assert.equal(out.spotView, -12, 'and the step view\'s goal (a click on its row or pin) has it too');
	assert.equal(out.candidate, -61.5, 'a smart target: its chosen candidate\'s z');
	assert.equal(out.candidateView, -61.5);
	assert.equal(out.candidateNone, 'none', 'a candidate without z has none');
	assert.equal(out.goto, 'none', 'a goal without z has none');
});
