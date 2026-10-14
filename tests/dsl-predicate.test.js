'use strict';
// tools/lib/dsl/predicate.js: the `when` expression language of format-2
// guides, parsed from lexer tokens into the closed predicate AST that
// addon/Polestar/Core/Predicate.lua evaluates (docs/parity plan, Task 1.2).
// Names that need data (professions, factions) stay as strings here; the
// resolver turns them into ids later.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { lexLine } = require('../tools/lib/dsl/lexer');
const { parsePredicate, toLua } = require('../tools/lib/dsl/predicate');
const { CLASS_FILES } = require('../tools/lib/game/races');

const parse = (s) => parsePredicate(lexLine(s).tokens);
const ok = (s) => {
	const r = parse(s);
	assert.deepEqual(r.errors, [], `unexpected errors for "${s}"`);
	return r.value;
};
const bad = (s, re) => {
	const r = parse(s);
	assert.equal(r.value, null, `"${s}" should not parse`);
	assert.ok(r.errors.length > 0, `"${s}" should report an error`);
	assert.match(r.errors[0], re);
};

test('quest atoms', () => {
	assert.deepEqual(ok('onquest 7'), ['onquest', 7]);
	assert.deepEqual(ok('ready 7'), ['ready', 7]);
	assert.deepEqual(ok('turnedin 783'), ['turnedin', 783]);
	assert.deepEqual(ok('OnQuest 7'), ['onquest', 7]);
});

test('has: item count, default 1, xN form', () => {
	assert.deepEqual(ok('has 750'), ['item', 750, '>=', 1]);
	assert.deepEqual(ok('has 750 x8'), ['item', 750, '>=', 8]);
});

test('level, skill and rep comparisons', () => {
	assert.deepEqual(ok('level >= 10'), ['level', '>=', 10]);
	assert.deepEqual(ok('level < 10'), ['level', '<', 10]);
	assert.deepEqual(ok('level == 10'), ['level', '==', 10]);
	assert.deepEqual(ok('level != 10'), ['level', '~=', 10]);
	assert.deepEqual(ok('skill Mining >= 50'), ['skill', 'Mining', '>=', 50]);
	assert.deepEqual(ok('skill "First Aid" >= 40'), ['skill', 'First Aid', '>=', 40]);
	assert.deepEqual(ok('skill 186 >= 50'), ['skill', 186, '>=', 50]);
	assert.deepEqual(ok('rep Stormwind >= Friendly'), ['rep', 'Stormwind', '>=', 5]);
	assert.deepEqual(ok('rep "Darnassus" < Honored'), ['rep', 'Darnassus', '<', 6]);
	assert.deepEqual(ok('rep 72 >= 5'), ['rep', 72, '>=', 5]);
});

test('zone takes a quoted name', () => {
	assert.deepEqual(ok('zone "Elwynn Forest"'), ['zone', 'Elwynn Forest']);
});

test('character names reuse the `only` condition list', () => {
	assert.deepEqual(ok('Warrior'), ['class', ['WARRIOR']]);
	assert.deepEqual(ok('Warrior,Mage'), ['class', ['WARRIOR', 'MAGE']]);
	assert.deepEqual(ok('Undead'), ['race', ['Scourge']]);
	assert.deepEqual(ok('Alliance'), ['faction', 'Alliance']);
	assert.deepEqual(ok('Dwarf,Paladin'), ['all', ['class', ['PALADIN']], ['race', ['Dwarf']]]);
	assert.deepEqual(ok('!Hunter'), ['class', CLASS_FILES.filter((c) => c !== 'HUNTER')]);
});

test('not / and / or precedence: not > and > or', () => {
	assert.deepEqual(ok('not onquest 7'), ['not', ['onquest', 7]]);
	assert.deepEqual(ok('onquest 7 and level >= 5'), ['all', ['onquest', 7], ['level', '>=', 5]]);
	assert.deepEqual(ok('onquest 7 or onquest 8'), ['any', ['onquest', 7], ['onquest', 8]]);
	assert.deepEqual(ok('onquest 1 or onquest 2 and onquest 3'), ['any', ['onquest', 1], ['all', ['onquest', 2], ['onquest', 3]]]);
	assert.deepEqual(ok('onquest 1 and onquest 2 and onquest 3'), ['all', ['onquest', 1], ['onquest', 2], ['onquest', 3]]);
	assert.deepEqual(ok('not onquest 1 and onquest 2'), ['all', ['not', ['onquest', 1]], ['onquest', 2]]);
	assert.deepEqual(ok('NOT turnedin 7 AND has 750'), ['all', ['not', ['turnedin', 7]], ['item', 750, '>=', 1]]);
});

test('parentheses, attached or spaced', () => {
	assert.deepEqual(ok('(onquest 1 or onquest 2) and onquest 3'), ['all', ['any', ['onquest', 1], ['onquest', 2]], ['onquest', 3]]);
	assert.deepEqual(ok('( onquest 1 or onquest 2 ) and onquest 3'), ['all', ['any', ['onquest', 1], ['onquest', 2]], ['onquest', 3]]);
	assert.deepEqual(ok('not (onquest 1 or ready 1)'), ['not', ['any', ['onquest', 1], ['ready', 1]]]);
	assert.deepEqual(ok('((onquest 1))'), ['onquest', 1]);
});

test('errors', () => {
	bad('', /empty/);
	bad('onquest', /quest id/);
	bad('onquest abc', /quest id/);
	bad('onquest 0', /quest id/);
	bad('has', /item id/);
	bad('has 750 x0', /count/);
	bad('level 10', /operator/);
	bad('level >= ten', /number/);
	bad('level => 10', /operator/);
	bad('rep Stormwind >= Buddies', /standing/);
	bad('skill >= 5', /profession/);
	bad('zone', /zone name/);
	bad('Wizard', /unknown|condition/i);
	bad('onquest 7 and', /expected/);
	bad('onquest 7 onquest 8', /unexpected/);
	bad('(onquest 7', /\)/);
	bad('onquest 7)', /unexpected/);
	bad('not', /expected/);
});

test('toLua renders the AST as a Lua table literal', () => {
	assert.equal(toLua(['onquest', 7]), '{ "onquest", 7 }');
	assert.equal(toLua(['class', ['WARRIOR', 'MAGE']]), '{ "class", { "WARRIOR", "MAGE" } }');
	assert.equal(toLua(['all', ['not', ['turnedin', 7]], ['zone', 'Say "hi"']]), '{ "all", { "not", { "turnedin", 7 } }, { "zone", "Say \\"hi\\"" } }');
});
