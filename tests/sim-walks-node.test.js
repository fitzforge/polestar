'use strict';
// sim walks on the node router (tools/lib/nav/router.js; docs/legacy/SIMULATION-js.md §1 "Walks"): the
// binary walks and cache files and a band walk's danger signature.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const walks = require('../tools/lib/sim/walks');
const { writeBin, readBin, readBinHeader } = require('../tools/lib/sim/binfile');
const { buildLookup } = require('../tools/lib/sim/walklookup');
const { tmpdir } = require('./helpers/tmp');

test('binfile: typed sections and the header round-trip; the content id follows the content', () => {
	const dir = tmpdir('walks-bin-');
	const file = path.join(dir, 'x.bin');
	const sections = { a: Float32Array.from([1.5, -2, 3]), b: Int32Array.from([7, -8]), c: new Uint8Array([1, 0, 1, 1, 0]), d: Float64Array.from([Math.PI]) };
	const id = writeBin(file, { schema: 1, name: 'x' }, sections);
	const { header, sections: s } = readBin(file);
	assert.equal(header.name, 'x');
	assert.equal(header.contentId, id);
	assert.equal(readBinHeader(file).contentId, id);
	for (const [k, v] of Object.entries(sections)) {
		assert.equal(s[k].constructor, v.constructor, k);
		assert.deepEqual(Array.from(s[k]), Array.from(v), k);
	}
	assert.equal(writeBin(file, { schema: 1, name: 'x' }, sections), id, 'same content, same id');
	assert.notEqual(writeBin(file, { schema: 1, name: 'x' }, { ...sections, b: Int32Array.from([7, -9]) }), id);
});

test('writeWalks / readWalks: the binary walks price as the JSON document did, with the prebuilt lookup', () => {
	const dir = tmpdir('walks-doc-');
	const NW = 6;
	const doc = {
		schema: 4, faction: 'Horde', dataHash: 'w', router: 'node', nav: 'n', smooth: 0.961, style: 'balanced', radius: 4000, anchorRadius: 12000, bands: [0, 20], oneWayDz: 15, points: 5,
		pairs: { 0: [0, 1, 100, 700, 0, 1, 2, 50.5, 360, 0, 2, 3, 80, 600, 1, 3, 2, 120, 900, 1], 20: [0, 1, 140, 1500, 0] },
		zones: [[12, 60, 14, 40], null, [12, 80], [12, 120]],
		unwalkable: [4, 5],
	};
	walks.writeWalks(dir, doc, { nw: NW, json: true });
	const bin = walks.readWalks(dir, 'Horde');
	assert.equal(bin.schema, 5);
	assert.equal(bin.contentId, walks.walksContentId(dir, 'Horde'));
	const json = JSON.parse(fs.readFileSync(walks.walksJsonFile(dir, 'Horde'), 'utf8'));
	const L = buildLookup(bin, NW);
	const J = buildLookup(json, NW);
	for (const band of [0, 20]) {
		for (let a = 0; a < NW; a++) {
			for (let b = 0; b < NW; b++) {
				const x = L.get(a, b, band);
				const y = J.get(a, b, band);
				assert.deepEqual(x && Array.from(x, (v) => Math.round(v * 100) / 100), y && Array.from(y, (v) => Math.round(v * 100) / 100), `${a} -> ${b} band ${band}`);
				assert.deepEqual(Array.from(L.zones(a, b) || []), Array.from(J.zones(a, b) || []).map(Math.fround), `${a} -> ${b} zones`);
			}
		}
	}
	assert.equal(L.yd(4, 5, 0), Infinity, 'an unwalkable pair');
	assert.equal(walks.smoothOf(bin), 0.961);
	fs.writeFileSync(walks.walksFile(dir, 'Horde'), '{}');
	assert.match(walks.loadWalks({ faction: 'Horde', dataHash: 'w' }, dir).why, /^unreadable/);
});

test('the node walk cache round-trips, and a band walk stands while the zones it could enter cost what they did', () => {
	const dir = tmpdir('walks-cache-');
	const file = walks.cacheFile(dir, 'Horde', 'node');
	assert.match(path.basename(file), /^walkcache-node-horde\.bin$/);
	const sig = Float32Array.from([10, 11, 10, 1, 11, 1, 12, 3, 13, 1]); // ends 10, 11; zone 12 at 3x, 13 at 1x
	const m = new Map([
		['a|b|0', [100, 700, Float32Array.from([5, 60, 6, 40])]],
		['a|b|20', [140, 1500, sig]],
		['a|c|20', [-1, -1, null]],
	]);
	walks.writeNodeCache(file, 'nav', 'balanced', m);
	const back = walks.readNodeCache(file, 'nav', 'balanced');
	assert.deepEqual([...back.keys()], [...m.keys()]);
	for (const [k, v] of m) {
		assert.deepEqual(back.get(k).slice(0, 2), v.slice(0, 2), k);
		assert.deepEqual(back.get(k)[2] && Array.from(back.get(k)[2]), v[2] && Array.from(v[2]), k);
	}
	assert.equal(walks.readNodeCache(file, 'other nav', 'balanced').size, 0, 'another grid: nothing');
	const v = back.get('a|b|20');
	// Band 20: a zone of lowest level 24..30 costs 3x, above 30 20x, below 24 nothing.
	assert.ok(walks.bandValid(v, 20, { 10: 40, 11: 40, 12: 25, 13: 15 }), 'same multipliers (the ends exempt)');
	assert.ok(!walks.bandValid(v, 20, { 12: 35, 13: 15 }), 'zone 12 now 20x');
	assert.ok(!walks.bandValid(v, 20, { 12: 25, 13: 24 }), 'zone 13 now dangerous');
	assert.ok(walks.bandValid(v, 20, { 12: 25, 13: 15, 99: 60 }), 'a zone it could not enter changed');
	assert.ok(walks.bandValid(back.get('a|c|20'), 20, {}), 'a failure stands');
	assert.ok(walks.bandValid(back.get('a|b|0'), 0, {}), 'a base walk stands');
});
