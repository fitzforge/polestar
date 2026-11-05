'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('./helpers/data');
const { checkRules, rulesFor, KINDS, loadRules, checkShape, dataIds } = require('../tools/lib/sim/rules');

const world = { quests: [{ id: 3364 }, { id: 3365 }, { id: 97277 }], npcs: new Set([1271]), items: new Set([10439]) };
const src = { refs: ['#16'], credit: ['thmastin'] };

test('a valid rule set loads and indexes by quest, npc and item', () => {
	const rules = [
		{ id: 'H01', kind: 'timer', item: 10439, seconds: 300, from: { quest: 3364, step: 'accept' }, to: { quest: 3364, step: 'turnin' }, fact: 'Scalding Mornbrew lasts 5 min', source: src },
		{ id: 'H02', kind: 'notBefore', quest: 97277, level: 4, fact: 'Grund once level 4 spells are trained', source: src },
		{ id: 'H03', kind: 'avoid', npc: 1271, fact: 'Old Icebeard is an elite patrol', source: src },
	];
	const r = checkRules(rules, world);
	assert.equal(r.errors.length, 0);
	const idx = rulesFor(r.ok, world);
	assert.equal(idx.byQuest.get(3364).length, 1);
	assert.equal(idx.byNpc.get(1271)[0].id, 'H03');
	assert.equal(idx.byItem.get(10439)[0].id, 'H01');
});

test('unknown kind, unknown quest and missing provenance are errors with the rule id', () => {
	const r = checkRules([
		{ id: 'X1', kind: 'teleport', quest: 3364, fact: 'x', source: src },
		{ id: 'X2', kind: 'notBefore', quest: 9999999, level: 4, fact: 'x', source: src },
		{ id: 'X3', kind: 'notBefore', quest: 3364, level: 4, fact: 'x', source: { refs: [] } },
	], world);
	assert.deepEqual(r.errors.map((e) => e.id).sort(), ['X1', 'X2', 'X3']);
	assert.ok(KINDS.has('make') && !KINDS.has('teleport'));
});

test('a missing field, a bad ref step, an unknown npc or item are errors; known ids rescue the other faction', () => {
	const r = checkRules([
		{ id: 'Y1', kind: 'at', quest: 3364, map: 1426, x: 1, y: 2, fact: 'x', source: src },
		{ id: 'Y2', kind: 'before', a: { quest: 3364, step: 'pickup' }, b: { quest: 3365, step: 'accept' }, fact: 'x', source: src },
		{ id: 'Y3', kind: 'buy', item: 10439, vendor: 99, fact: 'x', source: src },
		{ id: 'Y4', kind: 'make', item: 10439, from: [{ item: 5, count: 5 }], fact: 'x', source: src },
	], world, null);
	assert.deepEqual(r.errors.map((e) => e.id), ['Y1', 'Y2', 'Y3', 'Y4']);
	assert.deepEqual(r.errors[2].source, src);
	const other = { id: 'Y5', kind: 'notBefore', quest: 42, level: 10, fact: 'x', source: src };
	assert.equal(checkRules([other], world, null).errors.length, 1);
	const known = { quests: new Set([42]), npcs: new Set(), items: new Set() };
	assert.equal(checkRules([other], world, known).ok.length, 1);
});

test('npc and item ids fail closed: with no set to check them against they are errors', () => {
	const bare = { quests: world.quests };
	const r = checkRules([
		{ id: 'Z1', kind: 'avoid', npc: 1271, fact: 'x', source: src },
		{ id: 'Z2', kind: 'timer', item: 10439, seconds: 300, from: { quest: 3364, step: 'accept' }, to: { quest: 3364, step: 'turnin' }, fact: 'x', source: src },
		{ id: 'Z3', kind: 'learn', quest: 3364, trainer: 1699, skill: 'Cooking', fact: 'x', source: src },
		{ id: 'Z4', kind: 'notBefore', quest: 3364, level: 4, fact: 'x', source: src },
	], bare, null);
	assert.deepEqual(r.errors.map((e) => e.id), ['Z1', 'Z2', 'Z3']);
	assert.deepEqual(r.ok.map((x) => x.id), ['Z4']);
});

test('learn is indexed by quest and trainer; bad shapes are errors, never throws', () => {
	const w = { ...world, npcs: new Set([1271, 1699]) };
	const learn = { id: 'L1', kind: 'learn', quest: 3364, trainer: 1699, skill: 'Cooking', fact: 'x', source: src };
	const r = checkRules([
		learn,
		{ id: 'S1', kind: 'exclusive', quest: 3364, closes: 5, fact: 'x', source: src },
		{ id: 'S2', kind: 'classLock', quest: 3364, classes: ['WARIOR'], fact: 'x', source: src },
		{ id: 'S3', kind: 'requires', quest: 3364, item: 10439, place: { map: 1426, x: 'a' }, fact: 'x', source: src },
		{ id: 'S4', kind: 'ride', quest: 3364, from: { map: 1438, x: 1, y: 2 }, to: 7, fact: 'x', source: src },
		{ id: 'S5', kind: 'make', item: 10439, from: [{ item: 10439 }], fact: 'x', source: src },
		{ id: 'S6', kind: 'notBefore', quest: 3364, level: 4, unconfirmed: 7, fact: 'x', source: src },
	], w, null);
	assert.deepEqual(r.errors.map((e) => e.id), ['S1', 'S2', 'S3', 'S4', 'S5', 'S6']);
	assert.match(r.errors[1].message, /classes must be/);
	const idx = rulesFor(r.ok);
	assert.equal(idx.byQuest.get(3364)[0].id, 'L1');
	assert.equal(idx.byNpc.get(1699)[0].id, 'L1');
	assert.equal(checkShape({ ...learn, kind: 'ride', from: { map: 1, x: 1, y: 1 }, to: { map: 2, x: 3, y: 4 } }), null, 'ride seconds is optional');
	assert.equal(checkShape({ ...learn, unconfirmed: 'recorded runs only' }), null);
});

test('handover: an objective\'s item handed over by an NPC; indexed by quest, npc and item', () => {
	const w = { ...world, npcs: new Set([1271]) };
	const hand = { id: 'P1', kind: 'handover', quest: 3364, objective: 0, item: 10439, npc: 1271, fact: 'x', source: src };
	assert.ok(KINDS.has('handover'));
	const r = checkRules([
		hand,
		{ ...hand, id: 'P2', objective: -1 },
		{ ...hand, id: 'P3', objective: 1.5 },
		{ ...hand, id: 'P4', npc: undefined },
	], w, null);
	assert.deepEqual(r.errors.map((e) => e.id), ['P2', 'P3', 'P4']);
	assert.match(r.errors[0].message, /objective must be/);
	const idx = rulesFor(r.ok);
	assert.equal(idx.byQuest.get(3364)[0].id, 'P1');
	assert.equal(idx.byNpc.get(1271)[0].id, 'P1');
	assert.equal(idx.byItem.get(10439)[0].id, 'P1');
});

test('the shipped rules hand over Patience\'s three reports (#337, PR #457)', () => {
	const hand = loadRules().filter((r) => r.kind === 'handover' && r.quest === 99141);
	assert.deepEqual(hand.map((r) => [r.objective, r.item, r.npc]).sort(), [[0, 286200, 1496], [1, 286201, 251001], [2, 286202, 10666]]);
	for (const r of hand) assert.deepEqual([r.source.refs, r.source.credit], [['#337', 'PR #457'], ['Onrevax', 'XrayAlpha']]);
});

test('the shipped rules.json is valid against the synthetic shape check (fields and provenance)', () => {
	const rules = loadRules();
	const bad = rules.map(checkShape).filter(Boolean);
	assert.deepEqual(bad, [], JSON.stringify(bad.slice(0, 3)));
	assert.ok(rules.length >= 25);
	assert.equal(new Set(rules.map((r) => r.id)).size, rules.length, 'rule ids are unique');
});

// The built worlds (POLESTAR_SIM_DIR, default the sim command's data/sim); a rule
// for the other faction is checked against data/forever.
const REAL_SIM = process.env.POLESTAR_SIM_DIR || path.join(__dirname, '..', 'data', 'sim');
for (const faction of ['horde', 'alliance']) {
	const file = path.join(REAL_SIM, `world-${faction}.json`);
	const skip = needs('quests.json', 'npcs.json', 'items.json') || (!fs.existsSync(file) && `no ${file}`);
	test(`the shipped rules check clean against the ${faction} world`, { skip }, () => {
		const w = JSON.parse(fs.readFileSync(file, 'utf8'));
		const r = checkRules(loadRules(), { quests: w.quests }, dataIds());
		assert.deepEqual(r.errors, []);
	});
}
