'use strict';
// `kind <leveling|profession|reputation|dungeon|class|collectible|exploration|misc>` (docs/GUIDE_FORMAT.md, "Guide
// kind"): what the guide window shows for a guide. Written into the pack only when the header sets it (the addon takes
// it from the category otherwise); any other value is an error. The JS compiler side of forge-guide's dsl_verbs.rs
// kind test; tests/parity.sh keeps the two compilers' output equal.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, plain } = require('./helpers/dsl');
const { emitGuides } = require('../tools/lib/dsl/emit');

const text = (head) => `${['guide t/k', 'title K', 'levels 1-5', 'zone Elwynn Forest', 'category Professions', ...head, '', 'step S', '  level 2'].join('\n')}\n`;

test('kind: written after the category when set, absent otherwise', () => {
	const none = compile(text([]));
	assert.deepEqual(none.errors, [], none.text);
	assert.equal(plain(none.guides[0]).kind, undefined);
	assert.doesNotMatch(emitGuides(none.guides.map((guide) => ({ guide }))), /kind =/);
	for (const k of ['leveling', 'profession', 'reputation', 'dungeon', 'class', 'collectible', 'exploration', 'misc']) {
		const r = compile(text([`kind ${k}`]));
		assert.deepEqual(r.errors, [], `${k}: ${r.text}`);
		assert.equal(plain(r.guides[0]).kind, k);
	}
	const lua = emitGuides(compile(text(['kind profession'])).guides.map((guide) => ({ guide })));
	assert.match(lua, /\n\t\t\tcategory = "Professions",\n\t\t\tkind = "profession",\n/);
});

test('an unknown kind is an error naming the known ones', () => {
	const r = compile(text(['kind fishing']));
	assert.equal(r.errors.length, 1, r.text);
	assert.match(r.errors[0], /:6: unknown kind "fishing" \(known: leveling, profession, reputation, dungeon, class, collectible, exploration, misc\)/);
});
