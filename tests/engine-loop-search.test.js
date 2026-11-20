'use strict';
// A `loop` step's points under a goal that is no kill, collect or interact (docs/GUIDE_FORMAT.md,
// "Spawn areas", Loop), in the real Engine: a `skill` goal on a gathering round and the accept of
// a quest giver who walks are searched point by point. Standing at a point for Spots.DWELL seconds
// with nothing found moves the arrow to the next, as for a kill. The compiler side:
// tests/dsl-loop-search.test.js. Real Core manifest, stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

// Elwynn here: 30 yd per map percent across (x), 20 down (y).
const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.race, w.faction, w.class, w.className, w.level = "Human", "Alliance", "WARRIOR", "Warrior", 10
w.titles[783] = "A Threat Within"
`;

// Three points along y = 50, at 30, 50 and 75, each 30 yd wide.
const SPOTS = 'map = 1429, x = 30, y = 50, spread = true, spots = { { x = 30, y = 50, r = 30 }, { x = 50, y = 50, r = 30 }, { x = 75, y = 50, r = 30 } }';
// test/patrol: the accept of an NPC who walks the three points. test/veins: a Mining round over
// them. test/post: the same accept at one place, no loop.
const GUIDES = `
Polestar.RegisterGuide({ id = "test/patrol", pack = "test", title = "patrol", faction = "Alliance", minLevel = 1, maxLevel = 20, zone = 1429, steps = {
	{ title = "Willem on his rounds", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", ${SPOTS} } } },
	{ goals = { { t = "level", level = 60 } } },
} })
Polestar.RegisterGuide({ id = "test/veins", pack = "test", title = "veins", faction = "Alliance", minLevel = 1, maxLevel = 20, zone = 1429, steps = {
	{ title = "Copper", goals = { { t = "skill", skill = "Mining", skillLine = 186, level = 50, ${SPOTS} } } },
	{ goals = { { t = "level", level = 60 } } },
} })
Polestar.RegisterGuide({ id = "test/post", pack = "test", title = "post", faction = "Alliance", minLevel = 1, maxLevel = 20, zone = 1429, steps = {
	{ title = "Willem at his post", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 30, y = 50 } } },
	{ goals = { { t = "level", level = 60 } } },
} })
Polestar.RegisterGuide({ id = "test/rifts", pack = "test", title = "Rifts", faction = "Alliance", minLevel = 1, maxLevel = 60, zone = 1429, steps = {
	{ goals = {
		{ t = "use", item = 12627, itemName = "Temporal Displacer", quest = 4971, oi = 1, ${SPOTS} },
		{ t = "kill", npc = 10717, target = "Temporal Parasite", quest = 4971, oi = 1, ${SPOTS} },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
`;

function run(guide, script, setup = '') {
	const { emitted } = runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		script: `${TEST_PACK}
${TEST_SOURCE}
${GUIDES}
E = Polestar.Engine
local w = stub.world
function at(x) w.moveTo(1429, x, 50) end
function wait(s) for _ = 1, s * 2 do stub.advance(0.5) end end
function arrow() local wp = E.GetWaypoint(); return wp and wp.x end
${setup}
stub.login()
Polestar.Set("behavior.autoAccept", false)
E.SetGuide("${guide}")
stub.advance(0.6)
${script}`,
	});
	return emitted[0];
}

const SEARCH = `at(30)
local first = arrow()
local goal = E.GetWaypoint() and E.GetWaypoint().goalIndex
wait(4)
local early = arrow()
wait(5)
local second = arrow()
at(50)
wait(9)
emit({ goal = goal, first = first, early = early, second = second, third = arrow() })`;

test('the accept of an NPC who walks: a dwell at a point with nobody there moves the arrow to the next', () => {
	const out = run('test/patrol', SEARCH);
	assert.deepEqual([out.first, out.early], [30, 30], 'the first point, and still it before the dwell is over');
	assert.equal(out.second, 50);
	assert.equal(out.third, 75);
});

test('a `skill` goal on a gathering round is searched the same way', () => {
	const out = run('test/veins', SEARCH);
	assert.deepEqual([out.first, out.second, out.third], [30, 50, 75]);
});

test('a quest item before its kill leads the arrow through each search point', () => {
	const out = run('test/rifts', SEARCH, 'w.onQuest(4971, { { required = 15, fulfilled = 10 } })');
	assert.equal(out.goal, 1, 'the quest item leads');
	assert.deepEqual([out.first, out.early, out.second, out.third], [30, 30, 50, 75]);
});

test('an accept without a loop stays at its place however long the player stands there', () => {
	const out = run('test/post', SEARCH);
	assert.deepEqual([out.first, out.second, out.third], [30, 30, 30]);
});
