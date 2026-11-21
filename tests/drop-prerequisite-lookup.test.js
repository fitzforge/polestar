'use strict';
// Synthetic quest-gated drops: the Lookup and dungeon pickup routes must
// obtain the quest that enables a source before telling the player to farm.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { writeCodexPack } = require('./helpers/codex');
const { luaValue } = require('../tools/lib/playtest');

const ITEM = 9900;
const PRE = 9901;
const UNLOCK = 9902;
const STARTED = 9903;

function fixture() {
	const codex = JSON.parse(fs.readFileSync(path.join(__dirname, 'fixtures/codex/lookup.json'), 'utf8'));
	const quest = (id, title, pre, objectives) => ({
		id, title, level: 18, minLevel: 10, faction: 'A', races: null, classes: null,
		start: { npc: [5008], object: [], item: [] }, end: { npc: [5009], object: [] },
		pre, preAny: [], objectives, zone: 9001, rewards: [], choices: [],
	});
	codex.quests[PRE] = quest(PRE, 'First Errand', [], [{ type: 'kill', id: 5012, count: 1, text: 'Kobold Digger' }]);
	codex.quests[UNLOCK] = quest(UNLOCK, 'Enable the Drop', [PRE], [{ type: 'kill', id: 5005, count: 5, text: 'Thornback Boar' }]);
	codex.quests[STARTED] = quest(STARTED, 'Read the Note', [], [{ type: 'kill', id: 5013, count: 1, text: 'Lord Ashcroft' }]);
	codex.quests[STARTED].start = { npc: [], object: [], item: [ITEM] };
	codex.items[ITEM] = { id: ITEM, name: 'Conditional Note', quality: 1, kind: 'item', sources: [
		{ type: 'drop', npc: 5004, chance: 50, requiresQuests: [UNLOCK], from: ['curated'] },
	] };
	return codex;
}

const DESCRIBE = `
local function goalsOf(def)
	local out = {}
	for i, s in ipairs(def and def.steps or {}) do
		for _, g in ipairs(s.goals or {}) do
			out[#out + 1] = { t = g.t, quest = g.quest or false, item = g.item or false, npc = g.npc or false, object = g.object or false, step = i }
		end
	end
	return out
end
local function built(def, reason)
	return { built = def ~= nil, reason = reason or false, goals = goalsOf(def) }
end
`;

function run(codex, script, setup = '') {
	const pack = writeCodexPack(codex);
	const maps = Object.entries(codex.frames).map(([id, frame]) => `w.addMap(${id}, ${luaValue({ name: codex.zones[id].name, ...frame })})`).join('\n');
	// These are runtime tests. Apply the synthetic source requirements to
	// decoded records; the pack's new field has separate round-trip tests.
	const requirements = codex.items[ITEM].sources.map((src, index) => src.requiresQuests ? `Polestar.Codex.Item(${ITEM}).sources[${index + 1}].requiresQuests = ${luaValue(src.requiresQuests)}` : '').join('\n');
	try {
		return runAddon({
			stubs: ['stub_world.lua'],
			before: `${pack.stubLua}\nlocal w = stub.world\n${maps}\nw.level = 20\nw.race, w.raceName, w.faction = "Human", "Human", "Alliance"\nw.class, w.className = "WARRIOR", "Warrior"\nw.moveTo(9001, 50, 50)\n${setup}`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml'] }],
			login: true,
			script: `assert(Polestar.Codex.Load())\n${requirements}\nlocal L = Polestar.Lookup\n${DESCRIBE}\n${script}`,
		}).emitted;
	} finally {
		pack.cleanup();
	}
}

const LOOKUP = `
local rows = L.Sources("item", ${ITEM})
local r = rows[1]
local def, reason = L.BuildGuide("item", ${ITEM})
local out = built(def, reason)
out.available, out.guideable = r and r.available or false, r and r.guideable or false
out.why = r and r.whyText or false
emit(out)
`;

function assertUnlockBeforeFarm(result) {
	assert.equal(result.built, true, JSON.stringify(result));
	const goals = result.goals;
	const farm = goals.findIndex((g) => g.t === 'collect' && g.item === ITEM);
	const unlock = goals.findIndex((g) => g.t === 'accept' && g.quest === UNLOCK);
	const preTurnin = goals.findIndex((g) => g.t === 'turnin' && g.quest === PRE);
	assert.ok(unlock >= 0 && unlock < farm, `accept the enabling quest before farming: ${JSON.stringify(goals)}`);
	assert.ok(preTurnin >= 0 && preTurnin < unlock, 'finish ordinary prerequisites before the enabling quest');
	assert.deepEqual(goals.filter((g) => g.quest === PRE).map((g) => g.t), ['accept', 'kill', 'turnin']);
	assert.deepEqual(goals.filter((g) => g.quest === UNLOCK).map((g) => g.t), ['accept'], 'holding the enabling quest is enough; do not do its objectives or turn it in');
}

test('Lookup finishes ordinary prerequisites and accepts the drop-enabling quest before farming', () => {
	const [r] = run(fixture(), LOOKUP);
	assert.equal(r.available, true, 'an obtainable prerequisite can be guided');
	assert.equal(r.guideable, true);
	assertUnlockBeforeFarm(r);
});

for (const [state, setup] of [['held', `w.onQuest(${UNLOCK}, { 5 })`], ['completed', `w.complete({ ${UNLOCK} })`]]) {
	test(`Lookup farms directly when the enabling quest is ${state}`, () => {
		const [r] = run(fixture(), LOOKUP, setup);
		assert.equal(r.built, true, JSON.stringify(r));
		assert.ok(r.goals.some((g) => g.t === 'collect' && g.item === ITEM));
		assert.deepEqual(r.goals.filter((g) => g.quest === PRE), []);
		assert.deepEqual(r.goals.filter((g) => g.quest === UNLOCK).map((g) => g.t), state === 'held' ? ['accept'] : []);
	});
}

for (const blocked of ['faction', 'level', 'missing']) {
	test(`Lookup blocks a drop whose enabling quest is unavailable (${blocked})`, () => {
		const codex = fixture();
		if (blocked === 'faction') codex.quests[UNLOCK].faction = 'H';
		if (blocked === 'level') codex.quests[UNLOCK].minLevel = 40;
		if (blocked === 'missing') delete codex.quests[UNLOCK];
		const [r] = run(codex, LOOKUP);
		assert.equal(r.available, false, JSON.stringify(r));
		assert.equal(r.guideable, false);
		assert.ok(r.why, 'the source explains why its requirement cannot be obtained');
		assert.equal(r.built, false, 'do not produce an impossible farm route');
		assert.ok(r.reason);
	});
}

test('a blocked gated source does not prevent guiding to an alternate ungated source', () => {
	const codex = fixture();
	delete codex.quests[UNLOCK];
	codex.items[ITEM].sources.push({ type: 'drop', npc: 5005, chance: 10, from: ['curated'] });
	const [r] = run(codex, LOOKUP);
	assert.equal(r.built, true, JSON.stringify(r));
	assert.ok(r.goals.some((g) => g.t === 'kill' && g.npc === 5005));
	assert.ok(!r.goals.some((g) => g.t === 'kill' && g.npc === 5004));
	assert.ok(!r.goals.some((g) => g.t === 'accept'));
});

test('Lookup cannot silently omit an incompatible ordinary prerequisite of the enabling quest', () => {
	const codex = fixture();
	codex.quests[PRE].faction = 'H';
	const [r] = run(codex, LOOKUP);
	assert.equal(r.available, false, JSON.stringify(r));
	assert.equal(r.built, false, 'the enabling quest still requires its impossible prerequisite');
	assert.ok(r.why);
});

test('every source-specific enabling quest is obtained before farming', () => {
	const codex = fixture();
	codex.quests[9904] = { ...codex.quests[UNLOCK], id: 9904, title: 'Second Drop Condition', pre: [] };
	codex.items[ITEM].sources[0].requiresQuests.push(9904);
	const [r] = run(codex, LOOKUP);
	assertUnlockBeforeFarm(r);
	const farm = r.goals.findIndex((g) => g.t === 'collect' && g.item === ITEM);
	const second = r.goals.findIndex((g) => g.t === 'accept' && g.quest === 9904);
	assert.ok(second >= 0 && second < farm);
	assert.deepEqual(r.goals.filter((g) => g.quest === 9904).map((g) => g.t), ['accept']);
});

const dungeon = { name: 'Ashen Crypt', minLevel: 18, maxLevel: 26, entrance: { map: 9001, x: 30, y: 70, f: 'e' }, quests: { A: 1, H: 0 } };
const page = { quests: [{ id: STARTED, title: 'Read the Note', faction: 'A', level: 18, minLevel: 10, startItem: ITEM, start: { kind: 'item', id: ITEM }, bosses: [] }], chain: {} };
function registerPage(value = page) {
	return `
local D = Polestar.Dungeons
D.Register("meta", { schema = 1 })
D.Register("dungeon", { ashen_crypt = ${luaValue(dungeon)} }, { ashen_crypt = ${JSON.stringify(`return ${luaValue(value)}`)} })
`;
}
const PICKUP = `${registerPage()}
local def, reason = D.PickupGuide("ashen_crypt")
emit(built(def, reason))
`;

test('dungeon pickup obtains the drop prerequisite before collecting the quest-starting item', () => {
	const [r] = run(fixture(), PICKUP);
	assertUnlockBeforeFarm(r);
	const farm = r.goals.findIndex((g) => g.t === 'collect' && g.item === ITEM);
	assert.ok(r.goals.findIndex((g) => g.t === 'accept' && g.quest === STARTED) > farm);
});

for (const [state, setup] of [['held', `w.onQuest(${UNLOCK}, { 5 })`], ['completed', `w.complete({ ${UNLOCK} })`]]) {
	test(`dungeon pickup skips the prerequisite detour when the enabling quest is ${state}`, () => {
		const [r] = run(fixture(), PICKUP, setup);
		assert.equal(r.built, true, JSON.stringify(r));
		assert.ok(r.goals.some((g) => g.t === 'collect' && g.item === ITEM));
		assert.deepEqual(r.goals.filter((g) => g.quest === PRE), []);
		assert.deepEqual(r.goals.filter((g) => g.quest === UNLOCK).map((g) => g.t), state === 'held' ? ['accept'] : []);
	});
}

for (const blocked of ['faction', 'level', 'missing']) {
	test(`dungeon pickup never farms an item whose enabling quest is unavailable (${blocked})`, () => {
		const codex = fixture();
		if (blocked === 'faction') codex.quests[UNLOCK].faction = 'H';
		if (blocked === 'level') codex.quests[UNLOCK].minLevel = 40;
		if (blocked === 'missing') delete codex.quests[UNLOCK];
		const [r] = run(codex, PICKUP);
		assert.equal(r.built, false, JSON.stringify(r));
		assert.ok(r.reason);
	});
}

test('a quest-starting item already in the bags needs no drop-enabling quest', () => {
	const codex = fixture();
	delete codex.quests[UNLOCK];
	const [r] = run(codex, PICKUP, `w.addItem(${ITEM}, 1)`);
	assert.equal(r.built, true, JSON.stringify(r));
	assert.ok(r.goals.some((g) => g.t === 'accept' && g.quest === STARTED));
	assert.deepEqual(r.goals.filter((g) => g.quest === PRE || g.quest === UNLOCK), []);
});

test('abandoning the enabling quest on the farm step offers a return to its giver', () => {
	const [r] = run(fixture(), `
local id, reason = L.Guide("item", ${ITEM})
assert(id, reason)
local E = Polestar.Engine
stub.advance(0.6)
local acceptStep = E.GetLiveStep()
stub.world.accept(${UNLOCK}, { 5 }, "Enable the Drop")
stub.advance(0.6)
local farmStep = E.GetLiveStep()
stub.world.abandon(${UNLOCK})
stub.advance(0.6)
local lost = E.LostQuestion()
E.AnswerLost(${UNLOCK}, "back")
stub.advance(0.6)
emit({ accept = acceptStep, farm = farmStep, lost = lost or false, back = E.GetLiveStep() })
`, `w.complete({ ${PRE} })`);
	assert.ok(r.farm > r.accept, 'taking the enabling quest advances to the farm');
	assert.equal(r.lost, UNLOCK, 'abandoning the requirement cannot leave farming silently enabled');
	assert.equal(r.back, r.accept);
});

function followupFixture() {
	const codex = fixture();
	const next = 9904;
	codex.quests[STARTED].objectives = [];
	codex.quests[next] = { ...codex.quests[UNLOCK], id: next, title: 'Into the Crypt', pre: [STARTED], start: { npc: [5009], object: [], item: [] } };
	const followup = { id: next, title: 'Into the Crypt', faction: 'A', level: 18, minLevel: 10, start: { kind: 'npc', id: 5009 }, chain: [STARTED], bosses: [] };
	return { codex, next, page: { ...page, quests: [...page.quests, followup] } };
}

test('dungeon pickup completes the gated item errand before accepting its later page quest (#1380)', () => {
	const f = followupFixture();
	const [r] = run(f.codex, `${registerPage(f.page)}
local def, reason = D.PickupGuide("ashen_crypt")
emit(built(def, reason))`);
	assertUnlockBeforeFarm(r);
	const at = (t, quest) => r.goals.findIndex((g) => g.t === t && g.quest === quest);
	const farm = r.goals.findIndex((g) => g.t === 'collect' && g.item === ITEM);
	assert.ok(farm < at('accept', STARTED));
	assert.ok(at('accept', STARTED) < at('turnin', STARTED));
	assert.ok(at('turnin', STARTED) < at('accept', f.next));
	assert.equal(r.goals.filter((g) => g.t === 'accept' && g.quest === STARTED).length, 1);
	assert.equal(r.goals.filter((g) => g.t === 'collect' && g.item === ITEM).length, 1);
});

test('shared ordinary prerequisites appear once before the gated drop and other pickup quests', () => {
	const codex = fixture();
	const next = 9904;
	codex.quests[next] = { ...codex.quests[UNLOCK], id: next, title: 'Another Task', pre: [PRE] };
	const both = { ...page, quests: [...page.quests, { id: next, title: 'Another Task', faction: 'A', level: 18, minLevel: 10, start: { kind: 'npc', id: 5008 }, chain: [PRE], bosses: [] }] };
	const [r] = run(codex, `${registerPage(both)}
local def, reason = D.PickupGuide("ashen_crypt")
emit(built(def, reason))`);
	assertUnlockBeforeFarm(r);
	const preTurnin = r.goals.findIndex((g) => g.t === 'turnin' && g.quest === PRE);
	assert.ok(r.goals.findIndex((g) => g.t === 'accept' && g.quest === next) > preTurnin);
	assert.equal(r.goals.filter((g) => g.t === 'turnin' && g.quest === PRE).length, 1);
});

for (const [kind, script] of [['Lookup', LOOKUP], ['dungeon pickup', PICKUP]]) {
	test(`${kind} obtains the requirement before collecting from a gated object`, () => {
		const codex = fixture();
		codex.items[ITEM].sources[0] = { type: 'object', object: 6001, chance: 50, requiresQuests: [UNLOCK], from: ['curated'] };
		const [r] = run(codex, script);
		assertUnlockBeforeFarm(r);
		assert.ok(r.goals.some((g) => g.object === 6001 && (g.t === 'interact' || g.t === 'collect')));
	});
}

for (const [state, setup, id, title, turnIn] of [
	['unstarted', '', 5008, 'First Errand', false],
	['ordinary prerequisite held', `w.onQuest(${PRE}, { 1 })`, 5009, 'First Errand', true],
	['ordinary prerequisite completed', `w.complete({ ${PRE} })`, 5008, 'Enable the Drop', false],
	['enabling quest held', `w.onQuest(${UNLOCK}, { 5 })`, 5004, false, false],
]) {
	test(`GiverTarget points to the next obtainable drop requirement (${state})`, () => {
		const f = followupFixture();
		const [r] = run(f.codex, `${registerPage(f.page)}
local pt, label, first, turnIn = D.GiverTarget("ashen_crypt", ${f.next})
emit({ id = pt and pt.id or false, title = first or false, turnIn = turnIn or false })`, setup);
		assert.equal(r.id, id, JSON.stringify(r));
		// When no extra requirement remains, the ordinary chain names the item errand.
		assert.equal(r.title, title || 'Read the Note');
		assert.equal(r.turnIn, turnIn);
	});
}

test('a pickup rebuild without a position preserves the gated errand route and dependency order', () => {
	const f = followupFixture();
	const [r] = run(f.codex, `${registerPage(f.page)}
local before, reason = D.PickupGuide("ashen_crypt")
assert(before, reason)
Polestar.PlayerPoint = function() return nil end
local after, err = D.PickupGuide("ashen_crypt")
emit({ before = built(before), after = built(after, err) })`);
	assertUnlockBeforeFarm(r.after);
	assert.deepEqual(r.after.goals, r.before.goals);
});

test('a reachable preAny alternative keeps the drop source obtainable when the first branch is blocked', () => {
	const codex = fixture();
	codex.quests[UNLOCK].pre = [];
	codex.quests[UNLOCK].preAny = [PRE, 9904];
	codex.quests[PRE].pre = [9906, 9905];
	codex.quests[9904] = { ...codex.quests[PRE], id: 9904, title: 'Reachable Alternative', pre: [] };
	codex.quests[9905] = { ...codex.quests[PRE], id: 9905, title: 'Wrong Faction Ancestor', pre: [], faction: 'H' };
	codex.quests[9906] = { ...codex.quests[PRE], id: 9906, title: 'Unused Branch Errand', pre: [] };
	const [r] = run(codex, LOOKUP);
	assert.equal(r.available, true, JSON.stringify(r));
	assert.equal(r.built, true);
	const alternative = r.goals.findIndex((g) => g.t === 'turnin' && g.quest === 9904);
	const unlock = r.goals.findIndex((g) => g.t === 'accept' && g.quest === UNLOCK);
	const farm = r.goals.findIndex((g) => g.t === 'collect' && g.item === ITEM);
	assert.ok(alternative >= 0 && alternative < unlock && unlock < farm);
	assert.ok(!r.goals.some((g) => [PRE, 9905, 9906].includes(g.quest)), 'failed alternatives leave no partial route behind');
});

test('direct tooltip source lookup never routes the enabling quest or its ordinary prerequisites', () => {
	const [r] = run(fixture(), `
Polestar.TravelCost = function() error("tooltip source lookup called the route planner") end
local rows = L.Sources("item", ${ITEM}, true)
emit({ available = rows[1].available, guideable = rows[1].guideable })`);
	assert.equal(r.available, true);
	assert.equal(r.guideable, true);
});

for (const [kind, open] of [
	['Lookup', `local id, reason = L.Guide("item", ${ITEM})`],
	['dungeon pickup', `${registerPage()}\nlocal id, reason = D.PickUp("ashen_crypt")`],
]) {
	test(`${kind} skips an initially held enabling quest but recovers its accept after abandonment`, () => {
		const [r] = run(fixture(), `
${open}
assert(id, reason)
local E = Polestar.Engine
stub.advance(0.6)
local goals = goalsOf(E.GetGuide())
local before = E.GetLiveStep()
stub.world.abandon(${UNLOCK})
stub.advance(0.6)
local lost = E.LostQuestion()
E.AnswerLost(${UNLOCK}, "back")
stub.advance(0.6)
emit({ goals = goals, before = before, lost = lost or false, after = E.GetLiveStep() })`, `w.complete({ ${PRE} })\nw.onQuest(${UNLOCK}, { 5 })`);
		const accept = r.goals.find((g) => g.t === 'accept' && g.quest === UNLOCK);
		const farm = r.goals.find((g) => g.t === 'collect' && g.item === ITEM);
		assert.ok(accept, 'retain a satisfied accept for the engine to recover if the quest is lost');
		assert.equal(r.before, farm.step, 'holding the enabling quest must not send the player back to its giver');
		assert.equal(r.after, accept.step);
	});
}

for (const metadata of ['incompatible', 'missing']) {
	for (const [kind, script] of [['Lookup', LOOKUP], ['dungeon pickup', PICKUP]]) {
		test(`${kind} honors an already-held enabling quest despite ${metadata} quest metadata`, () => {
			const codex = fixture();
			if (metadata === 'missing') delete codex.quests[UNLOCK];
			else codex.quests[UNLOCK].faction = 'H';
			const [r] = run(codex, script, `w.onQuest(${UNLOCK}, { 5 })`);
			assert.equal(r.built, true, JSON.stringify(r));
			assert.ok(r.goals.some((g) => g.t === 'collect' && g.item === ITEM));
			assert.deepEqual(r.goals.filter((g) => g.quest === PRE), []);
			assert.ok(!r.goals.some((g) => g.quest === UNLOCK && g.t !== 'accept'));
		});
	}
}

test('GiverTarget does not offer a later quest whose item prerequisite has a blocked drop requirement', () => {
	const f = followupFixture();
	delete f.codex.quests[UNLOCK];
	const [r] = run(f.codex, `${registerPage(f.page)}
local pt = D.GiverTarget("ashen_crypt", ${f.next})
emit({ target = pt and pt.id or false })`);
	assert.equal(r.target, false, 'the later giver cannot offer the quest until its blocked item errand is done');
});
