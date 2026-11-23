'use strict';
// `levels <min>-<max> Alliance|Horde` (docs/GUIDE_FORMAT.md, "Header"): a guide both factions play gives each the
// levels its route brings it there at. The JS compiler side of forge-guide's dsl_faction_levels.rs test; tests/parity.sh
// keeps the two compilers' output equal.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, plain } = require('./helpers/dsl');
const { emitGuides, guideData } = require('../tools/lib/dsl/emit');

const text = (head) => `${['guide t/a', 'title A', ...head, 'zone Elwynn Forest', '', 'step One', '  accept 783', 'step Two', '  turnin 783'].join('\n')}\n`;

test('levels per faction compile to factionLevels, with minLevel/maxLevel spanning both', () => {
	const r = compile(text(['levels 45-46 Alliance', 'levels 47-48 Horde']));
	assert.deepEqual(r.errors, [], r.text);
	const g = plain(r.guides[0]);
	assert.deepEqual(g.factionLevels, { Alliance: { min: 45, max: 46 }, Horde: { min: 47, max: 48 } });
	assert.deepEqual([g.minLevel, g.maxLevel], [45, 48], 'an older Polestar shows the span');
	const lua = emitGuides(r.guides.map((guide) => ({ guide })));
	assert.match(lua, /\n\t\t\tminLevel = 45,\n\t\t\tmaxLevel = 48,\n\t\t\tfactionLevels = \{ Alliance = \{ min = 45, max = 46 \}, Horde = \{ min = 47, max = 48 \} \},\n/);
	assert.deepEqual(guideData(r.guides[0]).factionLevels, { Alliance: { max: 46, min: 45 }, Horde: { max: 48, min: 47 } });
});

test('a plain levels line is the range of the faction without its own; alone it compiles as before', () => {
	const mixed = plain(compile(text(['levels 43-45', 'levels 47-48 Horde'])).guides[0]);
	assert.deepEqual(mixed.factionLevels, { Alliance: { min: 43, max: 45 }, Horde: { min: 47, max: 48 } });
	assert.deepEqual([mixed.minLevel, mixed.maxLevel], [43, 48]);
	const r = compile(text(['levels 43-45']));
	const g = plain(r.guides[0]);
	assert.equal(g.factionLevels, undefined);
	assert.deepEqual([g.minLevel, g.maxLevel], [43, 45]);
	assert.doesNotMatch(emitGuides(r.guides.map((guide) => ({ guide }))), /factionLevels/);
});

test('each misuse of faction levels is one error on its line', () => {
	for (const [head, line, pat] of [
		[['levels 45-46 Alliance'], 3, /`levels` for one faction only: add `levels <min>-<max> Horde`/],
		[['faction Horde', 'levels 47-48 Horde'], 4, /a guide for one faction \(`faction Horde`\) has one level range/],
		[['levels 45-46 Alliance', 'levels 47-48 Horde', 'levels 43-45'], 5, /plain `levels` is unused/],
		[['levels 45-46 Alliance', 'levels 47-48 Horde', 'levels 44-46 Alliance'], 5, /duplicate `levels \.\.\. Alliance` \(first on line 3\)/],
		[['levels 43-45', 'levels 44-46'], 4, /duplicate header key `levels` \(first on line 3\)/],
		[['levels 45-46 Orcs', 'levels 47-48'], 3, /`levels` names a faction: Alliance or Horde, not "Orcs"/],
	]) {
		const r = compile(text(head));
		assert.equal(r.errors.length, 1, `${head}: ${r.text}`);
		assert.match(r.errors[0], new RegExp(`:${line}: `), `${head}: ${r.errors[0]}`);
		assert.match(r.errors[0], pat);
	}
});
