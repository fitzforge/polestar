'use strict';
// A closing parenthesis may follow a quoted name directly in a `when`
// expression: `(zone "Duskwood" or zone "Westfall")`.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { lexLine } = require('../tools/lib/dsl/lexer');
const { parsePredicate } = require('../tools/lib/dsl/predicate');

const parse = (s) => parsePredicate(lexLine(s).tokens);

test('quoted names close a group directly', () => {
	assert.deepEqual(parse('(zone "Duskwood")').value, ['zone', 'Duskwood']);
	assert.deepEqual(parse('not (zone "Duskwood" or zone "Loch Modan") and level >= 5').value,
		['all', ['not', ['any', ['zone', 'Duskwood'], ['zone', 'Loch Modan']]], ['level', '>=', 5]]);
	assert.deepEqual(parse('((zone "Duskwood"))').value, ['zone', 'Duskwood']);
	assert.deepEqual(parse('(skill "First Aid" < 75)').value, ['skill', 'First Aid', '<', 75]);
});

test('other characters after a closing quote are still an error', () => {
	assert.match(lexLine('zone "Duskwood"x').error, /unexpected "x" after closing quote/);
	assert.match(lexLine('zone "Duskwood")x').error, /unexpected "x" after closing quote/);
	assert.equal(lexLine('note "a")').tokens.length, 3);
});
