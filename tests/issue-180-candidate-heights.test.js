'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, guideText, DATA_DIR } = require('./helpers/dsl');
const { loadData } = require('../tools/lib/dsl/data');
const { worldPoint } = require('../tools/lib/dsl/heights');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

test('smart NPC candidates carry a trusted spawn height through emitted guide data', () => {
	const data = loadData(DATA_DIR);
	const llane = { map: 1429, x: 50.2, y: 42.3, f: 'e' };
	const p = worldPoint(data, llane);
	data.spawnz = {
		npc: {
			911: [[p.c, p.wx + 3, p.wy, 17.5]],
			198: [[p.c, p.wx + 30, p.wy, 99]],
		},
		object: {},
	};
	const r = compile(guideText(['class Warrior,Mage', '', 'step Training', '  train class']), data);
	assert.deepEqual(r.errors, []);
	const candidates = r.guides[0].steps[0].goals[0].candidates;
	const warrior = candidates.find((c) => c.npc === 911);
	const mage = candidates.find((c) => c.npc === 198);
	assert.equal(warrior.z, 17.5, 'the matching trainer spawn supplies the candidate floor');
	assert.equal(mage.z, undefined, 'a spawn farther than the trust radius supplies no floor');

	const lua = emitGuides(r.guides.map((guide) => ({ guide })));
	assert.match(lua, /npc = 911[^}]*map = 1429, x = 50\.2, y = 42\.3, z = 17\.5, f = "e"/);
});

test('the engine waypoint follows the selected smart candidate floor', () => {
	const guide = `
Polestar.RegisterGuide({ id = "test/candidate-z", pack = "test", title = "Candidate floors", category = "Leveling", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "sethome", candidates = {
		{ npc = 1, npcName = "Near", map = 1458, x = 20, y = 20, z = -66, faction = "H" },
		{ npc = 2, npcName = "Far", map = 1458, x = 80, y = 80, z = 12, faction = "H" },
	} } } },
	{ goals = { { t = "level", level = 60 } } },
} })`;
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		before: `
			stub.world.addMap(1458, { name = "Undercity", c = 0, left = 1000, right = 0, top = 2000, bottom = 1000 })
			stub.world.race, stub.world.faction, stub.world.class = "Scourge", "Horde", "ROGUE"
			stub.world.moveTo(1458, 10, 10)`,
		addons: [CORE],
		script: `${TEST_PACK}\n${TEST_SOURCE}\n${guide}
			local E = Polestar.Engine
			stub.login()
			E.SetGuide("test/candidate-z")
			local first = E.GetWaypoint()
			E.CycleCandidate(1, 1)
			local second = E.GetWaypoint()
			emit({ first = { first.label, first.z }, second = { second.label, second.z } })`,
	}).emitted;
	assert.deepEqual(out, {
		first: ['Set your home at Near', -66],
		second: ['Set your home at Far', 12],
	});
});
