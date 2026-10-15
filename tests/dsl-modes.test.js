'use strict';
// compiler side of the play-mode and XP atoms in `when`
// expressions: `mode <key>`, `xprate <op> <number>`, `xp <op> <L>[.<frac>]`
// and `xp <op> <L>+<N>` (N XP into level L, turned into a fraction of the
// level with the XP table in tools/lib/game/xp.js).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { lexLine } = require('../tools/lib/dsl/lexer');
const { parsePredicate } = require('../tools/lib/dsl/predicate');
const { compile, guideText, plain } = require('./helpers/dsl');

const parse = (s) => parsePredicate(lexLine(s).tokens);
const ok = (s) => {
	const r = parse(s);
	assert.deepEqual(r.errors, [], s);
	return r.value;
};

test('mode atoms', () => {
	assert.deepEqual(ok('mode hardcore'), ['mode', 'hardcore']);
	assert.deepEqual(ok('MODE SSF'), ['mode', 'ssf']);
	assert.deepEqual(ok('not mode ah'), ['not', ['mode', 'ah']]);
	assert.deepEqual(ok('mode group or level >= 20'), ['any', ['mode', 'group'], ['level', '>=', 20]]);
	assert.match(parse('mode season').errors[0], /mode must be one of hardcore, ssf, ah, group/);
	assert.match(parse('mode').errors[0], /mode/);
});

test('xprate takes a decimal', () => {
	assert.deepEqual(ok('xprate >= 1.5'), ['xprate', '>=', 1.5]);
	assert.deepEqual(ok('xprate < 2'), ['xprate', '<', 2]);
	assert.match(parse('xprate >= fast').errors[0], /number/);
	assert.match(parse('xprate 2').errors[0], /operator/);
});

test('xp: a level, a level with a fraction, or a level plus XP', () => {
	assert.deepEqual(ok('xp >= 12'), ['xp', '>=', 12]);
	assert.deepEqual(ok('xp >= 12.5'), ['xp', '>=', 12.5]);
	// 12+5050: 5050 of the 10100 XP level 12 needs -> 12.5
	assert.deepEqual(ok('xp >= 12+5050'), ['xp', '>=', 12.5]);
	// rounded to 4 decimals: 1300 / 10100 = 0.12871...
	assert.deepEqual(ok('xp < 12+1300'), ['xp', '<', 12.1287]);
	assert.match(parse('xp >= 12+99999').errors[0], /more XP than level 12 needs/);
	assert.match(parse('xp >= 61').errors[0], /level/);
	assert.match(parse('xp >= twelve').errors[0], /number|level/);
	assert.match(parse('xp 12').errors[0], /operator/);
});

test('the atoms compile in a step `when` and make the pack format 3', () => {
	const r = compile(guideText(['step One', '  when mode hardcore and xp >= 3.5 and xprate < 2', '  accept 783']));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(plain(r.guides[0].steps[0].when), ['all', ['mode', 'hardcore'], ['xp', '>=', 3.5], ['xprate', '<', 2]]);
});
