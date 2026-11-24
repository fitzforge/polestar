'use strict';
// The pin coverage guard (tools/pin-coverage.js): every fixed issue has a pin or a known reason in
// tests/pin-coverage.json, and every route/guide/place record still names a quest some guide has. The
// records half runs here on the tree; the issues half needs GitHub (the release gates run it), so here
// only its rules and the known list's upkeep are checked.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { tmpdir } = require('./helpers/tmp');
const { fixedIssues, pinnedIssues, deadRecords, recordQuests, recordKey, compare, loadBaseline, prune } = require('../tools/pin-coverage');

const baseline = loadBaseline();

test('--prune drops only the known gaps that are closed now', () => {
	const file = path.join(tmpdir(), 'pin-coverage.json');
	fs.writeFileSync(file, JSON.stringify({ about: 'a', issues: { 10: { why: 'w' }, 12: { why: 'w' } }, records: { x: 'gone', y: 'kept' } }));
	prune({ closedIssues: [12], closedRecords: ['x'] }, file);
	assert.deepEqual(loadBaseline(file), { about: 'a', issues: { 10: { why: 'w' } }, records: { y: 'kept' } });
});

test('no data record matches nothing beyond the known ones, and none of those matches again', () => {
	const r = compare({ pinned: new Set(), dead: deadRecords(), baseline });
	assert.deepEqual(r.newRecords.map((d) => `${d.key}: no guide has quest ${d.quests.join(', ')}`), []);
	assert.deepEqual(r.closedRecords, [], 'they match a guide again, or the record is gone: `node tools/pin-coverage.js --offline --prune` drops them from tests/pin-coverage.json');
});

test('every known unpinned issue is still unpinned (a pinned one leaves the list), and says why', () => {
	const pinned = pinnedIssues();
	assert.deepEqual(Object.keys(baseline.issues).filter((n) => pinned.has(Number(n))), [], 'a test names them now: `node tools/pin-coverage.js --offline --prune` drops them from tests/pin-coverage.json');
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

// #3625: a stale report closed as completed because an earlier release fixed it failed the next release's gate
// (#3566, #3611, #3173). Closed with that release's `released:v<X>` label, it is that release's fix, pinned at
// its gates; a fix of the release being gated (labelled after it ships) and a Client release's label still count.
test('a fix labelled with a release out already is not this release\'s to pin', () => {
	const closed = [
		{ number: 1, title: 'older', stateReason: 'COMPLETED', labels: [{ name: 'bug' }, { name: 'released:v0.4.1.1' }] },
		{ number: 2, title: 'the last one', stateReason: 'COMPLETED', labels: ['released:v0.4.2.2'] },
		{ number: 3, title: 'this release', stateReason: 'COMPLETED', labels: [{ name: 'released:v0.4.3' }] },
		{ number: 4, title: 'client', stateReason: 'COMPLETED', labels: [{ name: 'released:client-v0.1.6' }] },
		{ number: 5, title: 'no label', stateReason: 'COMPLETED', labels: [] },
		{ number: 6, title: 'short tag', stateReason: 'COMPLETED', labels: [{ name: 'released:v0.4.2' }] },
	];
	assert.deepEqual(fixedIssues(closed, '0.4.2.2').map((i) => i.number), [3, 4, 5]);
	assert.deepEqual(fixedIssues(closed).map((i) => i.number), [1, 2, 3, 4, 5, 6], 'no version: every completed fix');
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
