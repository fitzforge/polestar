'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const { buildLookup } = require('../tools/lib/sim/walklookup');
const { SMOOTH } = require('../tools/lib/sim/walks');

test('lookup returns the same walks as the doc, both directions, with band fallback', () => {
	const doc = { pairs: { 0: [0, 1, 100, 110, 0, 2, 300, 330, 1, 2, 50, 55], 30: [0, 2, 320, 900] } };
	const L = buildLookup(doc, 3);
	assert.deepEqual(L.get(0, 1, 0).map((v) => Math.round(v * 10) / 10), [Math.round(100 * SMOOTH * 10) / 10, 110]);
	assert.deepEqual(L.get(1, 0, 0), L.get(0, 1, 0));
	assert.equal(Math.round(L.get(0, 2, 30)[1]), 900, 'band 30 re-route');
	assert.equal(Math.round(L.get(1, 2, 30)[1]), 55, 'not re-routed in band 30 → band 0');
	assert.equal(L.get(0, 0, 0), null);
	assert.ok(L.bytes > 0);
});

// #579: a pair the document marks unwalkable (a cliff top and its foot, walks.js
// UNWALK_DZ) is no walk on foot: yd is Infinity both ways, in any band; a pair
// merely not walked stays -1 (the straight line × detour).
test('unwalkable pairs: yd Infinity both ways; other misses -1', () => {
	const L = buildLookup({ pairs: { 0: [0, 1, 100, 110, 0], 30: [] }, unwalkable: [1, 2] }, 4);
	assert.equal(L.yd(1, 2, 0), Infinity);
	assert.equal(L.yd(2, 1, 30), Infinity);
	assert.equal(L.yd(0, 3, 0), -1);
	assert.equal(L.get(1, 2, 0), null);
});

test('random doc: every stored pair matches the doc, both directions', () => {
	let s = 7;
	const rnd = () => ((s = (s * 1103515245 + 12345) % 2147483648) / 2147483648);
	const NW = 200;
	const pairs0 = [];
	const seen = new Set();
	for (let i = 0; i < 3000; i++) {
		const a = Math.floor(rnd() * NW);
		const b = Math.floor(rnd() * NW);
		if (a >= b || seen.has(a * NW + b)) continue;
		seen.add(a * NW + b);
		pairs0.push(a, b, Math.round(rnd() * 3000 * 10) / 10, Math.round(rnd() * 4000 * 10) / 10);
	}
	const L = buildLookup({ pairs: { 0: pairs0 } }, NW);
	for (let i = 0; i < pairs0.length; i += 4) {
		for (const g of [L.get(pairs0[i], pairs0[i + 1], 0), L.get(pairs0[i + 1], pairs0[i], 0)]) {
			assert.ok(Math.abs(g[0] - pairs0[i + 2] * SMOOTH) < 0.05 && Math.abs(g[1] - pairs0[i + 3]) < 0.05);
		}
	}
});

test('random doc: yd(a, b, band) equals get()[0] (or -1) for every pair and band, with the band-0 fallback', () => {
	let s = 11;
	const rnd = () => ((s = (s * 1103515245 + 12345) % 2147483648) / 2147483648);
	const NW = 120;
	const pairs = { 0: [], 10: [] };
	for (let i = 0; i < 2000; i++) {
		const a = Math.floor(rnd() * NW);
		const b = Math.floor(rnd() * NW);
		if (a === b) continue;
		pairs[rnd() < 0.3 ? 10 : 0].push(a, b, Math.round(rnd() * 3000 * 10) / 10, Math.round(rnd() * 4000 * 10) / 10);
	}
	const L = buildLookup({ pairs }, NW);
	let hits = 0;
	for (const band of [0, 10, 20]) {
		for (let a = -1; a <= NW; a++) {
			for (let b = 0; b < NW; b++) {
				const g = L.get(a, b, band);
				assert.equal(L.yd(a, b, band), g ? g[0] : -1, `${a}-${b} band ${band}`);
				// has: the band's own entry, no fallback (band 20 has none).
				const own = band !== 20 && a >= 0 && a < NW && pairs[band].some((_, i) => i % 4 === 0 && ((pairs[band][i] === a && pairs[band][i + 1] === b) || (pairs[band][i] === b && pairs[band][i + 1] === a)));
				assert.equal(L.has(a, b, band), own, `has ${a}-${b} band ${band}`);
				if (g) hits++;
			}
		}
	}
	assert.ok(hits > 1000);
});

test("a pair stored twice keeps its last occurrence, as attachWalks' Map does", () => {
	const L = buildLookup({ pairs: { 0: [0, 1, 100, 110, 1, 0, 90, 95] } }, 2);
	for (const g of [L.get(0, 1, 0), L.get(1, 0, 0)]) {
		assert.ok(Math.abs(g[0] - 90 * SMOOTH) < 0.01);
		assert.equal(g[1], 95);
	}
});

test('one-way walks: get(a, b) gives the walk from a to b where there is one, else the both-ways walk', () => {
	// Schema 3: [a, b, yards, cost, oneWay]. 0-1 a descent (down 0->1 200, back up 1->0 500),
	// 0-2 both ways, 1-2 walkable from 2 down to 1 only; band 30 re-routes 0-1 both ways.
	const doc = { schema: 3, pairs: { 0: [0, 1, 200, 210, 1, 1, 0, 500, 520, 1, 0, 2, 300, 330, 0, 2, 1, 80, 90, 1], 30: [0, 1, 700, 900, 0] } };
	const L = buildLookup(doc, 3);
	const near = (g, y, c) => g && Math.abs(g[0] - y * SMOOTH) < 0.05 && Math.abs(g[1] - c) < 0.05;
	assert.ok(near(L.get(0, 1, 0), 200, 210), 'down');
	assert.ok(near(L.get(1, 0, 0), 500, 520), 'back up');
	assert.ok(Math.abs(L.yd(1, 0, 0) - 500 * SMOOTH) < 0.05);
	assert.deepEqual(L.get(0, 2, 0), L.get(2, 0, 0), 'a both-ways pair');
	assert.ok(near(L.get(2, 1, 0), 80, 90));
	assert.equal(L.get(1, 2, 0), null, 'a one-way walk is not used the other way');
	assert.equal(L.yd(1, 2, 0), -1);
	assert.equal(L.has(2, 1, 0), true);
	assert.equal(L.has(1, 2, 0), false);
	assert.ok(near(L.get(1, 0, 30), 700, 900), 'a band\'s re-route both ways');
	assert.ok(near(L.get(1, 0, 20), 500, 520), 'band fallback: band 0\'s walk in its direction');
	assert.ok(near(L.get(2, 1, 30), 80, 90));
	assert.equal(L.get(1, 2, 30), null);
});

test('one-way walks: a one-way walk wins over a both-ways walk of the pair, whatever the order', () => {
	for (const pairs of [[0, 1, 100, 110, 0, 1, 0, 300, 330, 1], [1, 0, 300, 330, 1, 0, 1, 100, 110, 0]]) {
		const L = buildLookup({ schema: 3, pairs: { 0: pairs } }, 2);
		assert.ok(Math.abs(L.get(1, 0, 0)[0] - 300 * SMOOTH) < 0.05);
		assert.ok(Math.abs(L.get(0, 1, 0)[0] - 100 * SMOOTH) < 0.05);
	}
});

test('a schema 2 doc (pairs of 4, both ways) loads as before', () => {
	const pairs = [0, 1, 100, 110, 1, 2, 50, 55];
	const old = buildLookup({ schema: 2, pairs: { 0: pairs } }, 3);
	const now = buildLookup({ schema: 3, pairs: { 0: [0, 1, 100, 110, 0, 1, 2, 50, 55, 0] } }, 3);
	for (const [a, b] of [[0, 1], [1, 0], [1, 2], [2, 1], [0, 2]]) assert.deepEqual(old.get(a, b, 0), now.get(a, b, 0), `${a}-${b}`);
	assert.equal(old.bytes, now.bytes);
});
