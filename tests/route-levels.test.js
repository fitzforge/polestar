'use strict';
// Every leveling guide's `levels` header says the levels the route brings a player there (per faction where a guide
// is shared): its first level reads the route's arrival and its last the route's exit, floor or rounded, from
// data/route-levels.json (the level model run on the release candidate; tools/lib/route-levels.js). A header the route
// disagrees with is kept only with a `keep` row and its reason. Reads the guides' headers only.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { guideHeaders } = require('./helpers/guide-levels');
const { check, matches } = require('../tools/lib/route-levels');

const snapshot = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-levels.json'), 'utf8'));
const headers = guideHeaders(path.join(__dirname, '..', 'guides'));

test('every leveling guide\'s levels header matches the route\'s levels in data/route-levels.json', () => {
	assert.deepEqual(check(headers, snapshot), []);
});

test('every kept header has its reason and names a leveling guide of its faction', () => {
	for (const k of snapshot.keep) {
		assert.ok(k.reason && k.reason.length > 20, `${k.faction} ${k.guide}: a reason`);
		assert.ok(headers[k.guide] && headers[k.guide].levels[k.faction], `${k.faction} ${k.guide}: a guide of that faction`);
		assert.ok(snapshot.routes[k.faction][k.guide], `${k.faction} ${k.guide}: in the route`);
	}
});

// A copy of the headers with one guide's range changed for one faction.
function withHeader(id, faction, min, max) {
	const copy = structuredClone(headers);
	copy[id].levels[faction] = { min, max };
	return copy;
}

test('a header the route disagrees with fails, naming the guide and the route\'s range', () => {
	const [id, [arrive, exit]] = Object.entries(snapshot.routes.Alliance).find(([g]) => !snapshot.keep.some((k) => k.guide === g));
	const lo = Math.floor(arrive);
	const bad = check(withHeader(id, 'Alliance', lo, Math.round(exit) + 2), snapshot);
	assert.equal(bad.length, 1, bad.join('\n'));
	assert.match(bad[0], new RegExp(`^Alliance ${id}: header ${lo}-${Math.round(exit) + 2}, route `));
	assert.equal(check(withHeader(id, 'Alliance', lo + 2, Math.round(exit) + 2), snapshot).length, 1, 'a late first level fails too');
});

test('the kept header holds only at its exact range', () => {
	const k = snapshot.keep[0];
	assert.deepEqual(check(withHeader(k.guide, k.faction, ...k.levels), snapshot), []);
	const bad = check(withHeader(k.guide, k.faction, k.levels[0], k.levels[1] + 1), snapshot);
	assert.equal(bad.length, 1, bad.join('\n'));
	assert.match(bad[0], new RegExp(`^${k.faction} ${k.guide}: header `));
});

test('a leveling guide the snapshot lacks, or a snapshot guide that is gone, fails until it is refreshed', () => {
	const [id] = Object.entries(snapshot.routes.Horde).find(([g]) => !snapshot.keep.some((k) => k.guide === g));
	const missing = structuredClone(snapshot);
	delete missing.routes.Horde[id];
	assert.deepEqual(check(headers, missing), [`Horde ${id}: no route levels in data/route-levels.json (refresh it: docs/RELEASING.md, step 3)`]);
	const extra = structuredClone(snapshot);
	extra.routes.Horde['forever/horde/99-nowhere'] = [59, 60];
	assert.deepEqual(check(headers, extra), ['Horde forever/horde/99-nowhere: in data/route-levels.json but no Horde leveling guide has that id']);
});

test('the first level reads the arrival floor or rounded, the last the exit, never below the first', () => {
	const ok = (range, min, max) => matches(range, { min, max });
	assert.ok(ok([57.7, 59.4], 57, 59) && ok([57.7, 59.4], 58, 59), '57.7 reads 57 or 58');
	assert.ok(!ok([57.7, 59.4], 56, 59) && !ok([57.7, 59.4], 59, 59), 'but not 56 or 59');
	assert.ok(ok([35.9, 37.5], 35, 37) && ok([35.9, 37.5], 36, 38), '37.5 reads 37 or 38');
	assert.ok(!ok([35.9, 37.5], 36, 36) && !ok([35.9, 37.5], 36, 39), 'but not 36 or 39');
	assert.ok(ok([29.96, 30.4], 30, 30), '29.96 is read as 30');
	assert.ok(!ok([29.96, 30.4], 29, 30), 'not 29');
	assert.ok(ok([45.55, 45.9], 45, 46) && ok([45.55, 45.9], 46, 46), 'a guide inside one level');
});
