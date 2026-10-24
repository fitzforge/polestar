'use strict';
// Maps Forever added (Zephras Isle, Riverglades, Mount Hyjal, Shen'dralas)
// have no Era frame in map-frames.json, only a Forever one, and their points
// are in the live frame. Everything that measures yards on them reads that
// frame (data.frame): spawn areas, candidate towns, farm spots and the quest
// database's markers. Before, they fell back to a mid-sized zone (3000 x
// 2000 yd) and Zephras Isle (5562 x 3708 yd) was measured at about half its
// size (#299). Route geometry (route/geo.js) measured them as a 1000-yard
// square and farm spots skipped them as unplaceable (#422). The compiler's
// side (data.frame, spawn areas, farm spots) is forge-guide's
// (rust/crates/forge-guide/tests/dsl_forever_maps.rs), the quest database's
// forge-data's (rust/crates/forge-data/tests/data/questdb.rs); here route geometry.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { makeProjector, dist } = require('../tools/lib/route/geo');

const ZEPHRAS = 2521;
const FRAME = { c: 2991, left: 4231.25, right: -1331.25, top: 4956.25, bottom: 1247.917 };
const SX = Math.abs(FRAME.right - FRAME.left) / 100; // 55.6 yd per x %

test('route geometry measures a Forever-only map in its Forever frame, author points included', () => {
	const warnings = [];
	const p = makeProjector({ era: {}, forever: { [ZEPHRAS]: FRAME } }, (w) => warnings.push(w));
	for (const f of [null, 'e', 'l']) {
		const a = p.point(ZEPHRAS, 0, 0, f);
		const b = p.point(ZEPHRAS, 100, 100, f);
		assert.deepEqual([a.c, a.wx, a.wy, b.wx, b.wy], [FRAME.c, FRAME.top, FRAME.left, FRAME.bottom, FRAME.right], `f ${f}`);
		// 1.5% of the isle east-west: 83 yd (15 yd in a 1000-yard square).
		assert.ok(Math.abs(dist(p.point(ZEPHRAS, 40, 30, f), p.point(ZEPHRAS, 41.5, 30, f)) - 1.5 * SX) < 0.01, `f ${f}`);
	}
	// An author point and a spawn on the same map are on one continent, comparable.
	assert.ok(dist(p.point(ZEPHRAS, 40, 30), p.point(ZEPHRAS, 40, 30, 'l')) < 0.01);
	assert.deepEqual(warnings, []);
	// Neither frame: still the 1000-yard square, with a warning.
	assert.equal(dist(p.point(99999, 0, 0), p.point(99999, 100, 0)), 1000);
	assert.equal(warnings.length, 1);
});
