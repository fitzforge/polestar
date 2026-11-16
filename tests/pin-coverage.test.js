'use strict';
// The pin coverage guard (tools/pin-coverage.js): every fixed issue has a pin or a known reason in
// tests/pin-coverage.json, and every route/guide/place record still names a quest some guide has. The
// records half runs here on the tree; the issues half needs GitHub (the release gates run it), so here
// only its rules and the known list's upkeep are checked.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { fixedIssues, pinnedIssues, deadRecords, recordQuests, recordKey, compare, loadBaseline } = require('../tools/pin-coverage');

const baseline = loadBaseline();

test('no data record matches nothing beyond the known ones, and none of those matches again', () => {
	const r = compare({ pinned: new Set(), dead: deadRecords(), baseline });
	assert.deepEqual(r.newRecords.map((d) => `${d.key}: no guide has quest ${d.quests.join(', ')}`), []);
	assert.deepEqual(r.closedRecords, [], 'drop these entries from tests/pin-coverage.json: they match a guide again, or the record is gone');
});

test('every known unpinned issue is still unpinned (a pinned one leaves the list), and says why', () => {
	const pinned = pinnedIssues();
	assert.deepEqual(Object.keys(baseline.issues).filter((n) => pinned.has(Number(n))), [], 'pinned now: drop from tests/pin-coverage.json');
	const bare = [...Object.entries(baseline.issues), ...Object.entries(baseline.records).map(([k, why]) => [k, { why }])].filter(([, v]) => !(v && typeof v.why === 'string' && v.why.length > 10));
	assert.deepEqual(bare, []);
});

test('fixed means closed as completed, without a label saying nothing changed', () => {
	const closed = [
		{ number: 3, title: 'c', stateReason: 'COMPLETED', labels: [{ name: 'bug' }] },
		{ number: 1, title: 'a', stateReason: 'COMPLETED', labels: [] },
		{ number: 2, title: 'b', stateReason: 'NOT_PLANNED', labels: [] },
		{ number: 4, title: 'd', stateReason: 'COMPLETED', labels: [{ name: 'resolution:no-action' }] },
		{ number: 5, title: 'e', stateReason: 'COMPLETED', labels: [{ name: 'duplicate' }] },
	];
	assert.deepEqual(
		fixedIssues(closed).map((i) => i.number),
		[1, 3],
	);
});

test('a new unpinned fix or a dead record fails; a known one passes; one closed since is named', () => {
	const fixed = [
		{ number: 10, title: 'known' },
		{ number: 11, title: 'new' },
		{ number: 12, title: 'pinned' },
	];
	const known = { issues: { 10: { why: 'known gap' }, 12: { why: 'pinned since' } }, records: { 'data/places.json places x': 'gone' } };
	const r = compare({ fixed, pinned: new Set([12]), dead: [{ key: 'data/places.json places y', quests: [7] }], baseline: known });
	assert.deepEqual(r.newIssues.map((i) => i.number), [11]);
	assert.deepEqual(r.closedIssues, [12]);
	assert.deepEqual(r.newRecords.map((d) => d.key), ['data/places.json places y']);
	assert.deepEqual(r.closedRecords, ['data/places.json places x']);
});

test('a record names its quests and keeps a key that survives edits elsewhere in its file', () => {
	assert.deepEqual(recordQuests({ a: ['turnin', 606], b: ['accept', 348] }), [606, 348]);
	assert.deepEqual(recordQuests({ q: 98299 }), [98299]);
	assert.deepEqual(recordQuests({ at: { quest: 5147 } }), [5147]);
	assert.deepEqual(recordQuests({ quest: 151 }), [151]);
	assert.deepEqual(recordQuests({ map: 1436 }), []);
	assert.equal(recordKey('data/route-fixes.json', 'deliberate.pairs', { a: ['turnin', 606], b: ['accept', 348], faction: 'Horde' }), 'data/route-fixes.json deliberate.pairs a=turnin 606 b=accept 348 Horde');
	assert.equal(recordKey('data/places.json', 'places', { id: 'x-y', quest: 1 }), 'data/places.json places x-y');
});
