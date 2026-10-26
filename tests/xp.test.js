'use strict';
const test = require('node:test');
const assert = require('node:assert');
const { mobXp, zeroDiff, greyLevel } = require('../tools/lib/game/xp');

test('Forever: a mob below the player uses its own level, then the level-difference factor', () => {
	assert.strictEqual(mobXp(20, 15, false, { forever: true }), Math.round((45 + 75) * (1 - 5 / zeroDiff(20))));
});

test('Classic: a mob below the player uses the player level', () => {
	assert.strictEqual(mobXp(20, 15), Math.round((45 + 100) * (1 - 5 / zeroDiff(20))));
	assert.strictEqual(mobXp(20, 15, false, { forever: false }), mobXp(20, 15));
});

test('Forever: mobs at or above the player are unchanged', () => {
	assert.strictEqual(mobXp(20, 20, false, { forever: true }), mobXp(20, 20));
	assert.strictEqual(mobXp(20, 23, false, { forever: true }), mobXp(20, 23));
});

test('grey mobs give 0 in both modes', () => {
	const g = greyLevel(20);
	assert.strictEqual(mobXp(20, g), 0);
	assert.strictEqual(mobXp(20, g, false, { forever: true }), 0);
	assert.strictEqual(mobXp(20, g - 3, true, { forever: true }), 0);
});

test('elites double', () => {
	assert.strictEqual(mobXp(20, 15, true, { forever: true }), 2 * mobXp(20, 15, false, { forever: true }));
	assert.strictEqual(mobXp(20, 15, true), 2 * mobXp(20, 15));
});
