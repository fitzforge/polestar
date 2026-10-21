'use strict';
// `when upgrade` during play (addon/Polestar/Core/Engine.lua, Own.isUpgrade):
// the step applies while Polestar's gear advice (Gear.IsUpgrade) rates the
// item an upgrade, `!upgrade` while it does not. When the advice cannot judge
// (turned off, not loaded, the item or the weights unknown) the item counts
// as an upgrade. A new verdict (GEAR_UPDATED) re-evaluates the guide; a step
// the route has passed keeps its stored outcome. Real Core manifest, stub
// world (a level 1 Human Warrior in Elwynn Forest), as
// tests/engine-when-dungeon.test.js; the gear advice is a stub set here.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
w.onQuest(783, {})
`;

// Step 2 is the conditional one, between taking and handing in A Threat
// Within: `when` is Lua for its predicates.
function guide(when) {
	return `
Polestar.RegisterGuide({
	id = "test/upgrade", pack = "test", title = "Upgrade", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Trainer", when = ${when}, goals = {
			{ t = "train", npc = 911, npcName = "Llane Beshere" },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
`;
}

// GEAR = { enabled, judged, up }: the stub gear advice's answers, changed by
// the tests; `asked` records the items it was asked about.
const HELPERS = `
E = Polestar.Engine
function flush() stub.advance(0.25) end
function state() local v = E.GetStepView(2); return { live = E.GetLiveStep(), status = v.status } end
GEAR = { enabled = true, judged = true, up = true }
asked = {}
function stubGear()
	Polestar.Gear = {
		IsEnabled = function() return GEAR.enabled end,
		CompareToEquipped = function(item) asked[#asked + 1] = item; if GEAR.judged then return { usable = true } end end,
		IsUpgrade = function(item) return GEAR.up, GEAR.up and 5 or -5 end,
	}
end
`;

const UP = '{ { k = "upgrade", item = 2488 } }';
const NOT_UP = '{ { k = "upgrade", item = 2488, neg = true } }';

function run({ when, gear = 'stubGear()', login = '', script }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [CORE],
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/upgrade" }' },
		script: `${TEST_PACK}
${TEST_SOURCE}\n${guide(when)}\n${HELPERS}\n${gear}\nstub.login()\n${login}\nstub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)\n${script}`,
	}).emitted;
}

test('an item the gear advice rates an upgrade: `upgrade` applies, `!upgrade` is passed', () => {
	const [up, asked] = run({ when: UP, script: 'emit(state()); emit(asked[1])' });
	assert.deepEqual(up, { live: 2, status: 'current' });
	assert.equal(asked, 'item:2488');
	const [not] = run({ when: NOT_UP, script: 'emit(state())' });
	assert.deepEqual(not, { live: 3, status: 'skipped' });
});

test('an item it rates no upgrade: `upgrade` is passed, `!upgrade` applies', () => {
	const [up] = run({ when: UP, gear: 'stubGear(); GEAR.up = false', script: 'emit(state())' });
	assert.deepEqual(up, { live: 3, status: 'skipped' });
	const [not] = run({ when: NOT_UP, gear: 'stubGear(); GEAR.up = false', script: 'emit(state())' });
	assert.deepEqual(not, { live: 2, status: 'current' });
});

test('when the gear advice cannot judge, the item counts as an upgrade: turned off, not loaded, or the item unknown', () => {
	for (const gear of ['stubGear(); GEAR.enabled = false; GEAR.up = false', '', 'stubGear(); GEAR.judged = false; GEAR.up = false']) {
		const [up] = run({ when: UP, gear, script: 'emit(state())' });
		assert.deepEqual(up, { live: 2, status: 'current' }, gear || 'no gear module');
		const [not] = run({ when: NOT_UP, gear, script: 'emit(state())' });
		assert.deepEqual(not, { live: 3, status: 'skipped' }, gear || 'no gear module');
	}
});

test('a new gear verdict (GEAR_UPDATED) re-evaluates the guide at once', () => {
	// Before the quest log is read nothing is stored, so step 2 is decided
	// live: it applies while the item is an upgrade, and does not (na) once
	// the character wears something better.
	const [on, off] = run({
		when: UP,
		login: 'stub.advance(0.25); emit(state()); GEAR.up = false; Polestar.Fire("GEAR_UPDATED", "equipment"); stub.advance(0.25); emit(state())',
		script: '',
	});
	assert.deepEqual(on, { live: 2, status: 'current' });
	assert.deepEqual(off, { live: 3, status: 'na' });
});

test('a step the route has passed keeps its stored outcome when the verdict changes later', () => {
	const [passed, later, db] = run({
		when: UP,
		gear: 'stubGear(); GEAR.up = false',
		script: `
			emit(state())
			GEAR.up = true; Polestar.Fire("GEAR_UPDATED", "equipment"); flush()
			emit(state())
			stub.fire("PLAYER_LOGOUT")
			emit(PolestarCharDB.skipped)
		`,
	});
	assert.deepEqual(passed, { live: 3, status: 'skipped' });
	assert.deepEqual(later, { live: 3, status: 'skipped' });
	assert.deepEqual(db, { 'test/upgrade': { 2: true } });
});

test('with the real gear advice: a better helm is an upgrade until the character wears it', () => {
	// tests/gear.test.js's fixture mail helms: 9001 (str5 sta3 armor150) and
	// 9002 (str10 sta4 armor170), for a level 30 Warrior wearing 9001.
	const [before, after] = runAddon({
		stubs: ['stub_world.lua', 'stub_gear.lua'],
		before: `${WORLD}
w.class, w.className, w.classID, w.level = "WARRIOR", "Warrior", 1, 30
w.race, w.raceName, w.raceID, w.faction = "Troll", "Troll", 8, "Horde"`,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Gear/Gear.xml'] }],
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/upgrade" }' },
		script: `${TEST_PACK}
${TEST_SOURCE}\n${guide('{ { k = "upgrade", item = 9002 } }')}\n${HELPERS}
Polestar.ItemDB.Register({ schema = 1, build = "test" }, {
	[9001] = "1 20 15 2 4 3 str5 sta3 armor150",
	[9002] = "1 25 20 2 4 3 str10 sta4 armor170",
})
stub.gear.equip(1, "item:9001")
stub.login()
stub.advance(0.25); emit(state())
stub.gear.equip(1, "item:9002"); stub.advance(0.25); emit(state())`,
	}).emitted;
	assert.deepEqual(before, { live: 2, status: 'current' });
	assert.deepEqual(after, { live: 3, status: 'na' });
});
