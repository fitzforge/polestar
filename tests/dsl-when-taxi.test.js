'use strict';
// `when taxi "<Flight point>"` (docs/GUIDE_FORMAT.md, "Conditions checked during play"): the JS compiler side
// of forge-guide's dsl_when_taxi.rs test (rust/crates/forge-guide/tests/parity.sh keeps the two compilers'
// output equal). The predicate, its errors, the taxi node it gets for the step's factions, the warning for a
// name no flight point has, the emitted table and pack format 10.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { DATA_DIR, guideText, lineOf, compile, plain } = require('./helpers/dsl');
const { tmpdir } = require('./helpers/tmp');
const { loadData } = require('../tools/lib/dsl/data');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { formatFor, NEEDS, TAXI_FORMAT } = require('../tools/lib/pack/format');

// The fixture data with a travel.json holding Ironforge, Thelsamar and both factions' Booty Bay flight masters.
const DATA = (() => {
	const dir = tmpdir();
	for (const f of fs.readdirSync(DATA_DIR)) fs.copyFileSync(path.join(DATA_DIR, f), path.join(dir, f));
	const nodes = [
		{ id: 6, name: 'Ironforge, Dun Morogh', short: 'Ironforge', map: 1455, x: 55.89, y: 47.87, faction: 1, npc: 1573, npcName: 'Gryth Thurden' },
		{ id: 8, name: 'Thelsamar, Loch Modan', short: 'Thelsamar', map: 1432, x: 33.94, y: 50.79, faction: 1, npc: 1572, npcName: 'Thorgrum Borrelson' },
		{ id: 18, name: 'Booty Bay, Stranglethorn', short: 'Booty Bay', map: 1434, x: 26.82, y: 77, faction: 2, npc: 2858, npcName: 'Gringer' },
		{ id: 19, name: 'Booty Bay, Stranglethorn', short: 'Booty Bay', map: 1434, x: 27.53, y: 77.67, faction: 1, npc: 2859, npcName: 'Gyll' },
	];
	fs.writeFileSync(path.join(dir, 'travel.json'), `${JSON.stringify({ inns: [], taxi: { nodes } })}\n`);
	return loadData(dir);
})();

const parse = (text) => {
	const diag = new Diagnostics();
	const ast = parseGuide(text, 'x.guide', diag);
	return { ast, errors: diag.sorted().filter((d) => d.severity === 'error').map((d) => `${d.line}: ${d.message}`) };
};
const whens = (r) => plain(r.guides[0].steps).map((s) => s.when);

test('when taxi parses a flight point quoted or bare, with or without !', () => {
	const text = guideText(['step One', '  when taxi "Ironforge"', '  when !taxi Thelsamar', '  accept 783']);
	const { ast, errors } = parse(text);
	assert.deepEqual(errors, []);
	assert.deepEqual(plain(ast.steps[0].when), [
		{ k: 'taxi', name: 'Ironforge', line: lineOf(text, 'when taxi "Ironforge"') },
		{ k: 'taxi', neg: true, name: 'Thelsamar', line: lineOf(text, 'when !taxi Thelsamar') },
	]);
});

test('when taxi without a name is an error at its line', () => {
	for (const line of ['  when taxi', '  when !taxi']) {
		const text = guideText(['step One', line, '  accept 783']);
		assert.deepEqual(parse(text).errors, [`${lineOf(text, line)}: \`taxi\` needs a name: taxi "<Flight point>"`], line);
	}
});

test('the predicate gets the taxi node of the flight master for the factions the step is for', () => {
	const r = compile(guideText(['step One', '  when taxi "Ironforge"', '  note Fly.', 'step Two', '  when !taxi "Booty Bay"', '  note Walk.']), DATA);
	assert.deepEqual([r.errors, r.warnings], [[], []], r.text);
	assert.deepEqual(whens(r), [[{ k: 'taxi', name: 'Ironforge', node: 6 }], [{ k: 'taxi', neg: true, name: 'Booty Bay', node: 19 }]]);
	// A guide for both factions: Booty Bay names a flight master of each, so only a step for one side gets its node.
	const both = ['guide t/both', 'title Both', 'levels 1-10', 'zone Elwynn Forest', '', 'step One', '  when taxi "Booty Bay"', '  note Fly.', 'step Two', '  only Horde', '  when taxi "Booty Bay"', '  note Fly.', ''].join('\n');
	const b = compile(both, DATA);
	assert.deepEqual(b.errors, [], b.text);
	assert.deepEqual(whens(b), [[{ k: 'taxi', name: 'Booty Bay' }], [{ k: 'taxi', name: 'Booty Bay', node: 18 }]]);
});

test('a name no flight point has warns and keeps the name alone', () => {
	const text = guideText(['step One', '  when !taxi "Ironforgee"', '  accept 783']);
	const r = compile(text, DATA);
	const line = lineOf(text, 'when !taxi "Ironforgee"');
	assert.deepEqual(r.warnings.filter((w) => w.includes('no flight point has that name')), [`test.guide:${line}: taxi "Ironforgee": no flight point has that name, so Polestar never counts its flight path as known`]);
	assert.ok(r.text.includes('did you mean "Ironforge"?'), r.text);
	assert.deepEqual(whens(r), [[{ k: 'taxi', neg: true, name: 'Ironforgee' }]]);
});

test('a step that asks for a flight path and its ! warns that no character sees it', () => {
	const text = guideText(['step One', '  when taxi Ironforge', '  when !taxi Ironforge', '  accept 783']);
	const r = compile(text, DATA);
	assert.ok(r.warnings.includes(`test.guide:${lineOf(text, 'when taxi Ironforge')}: the step asks for \`taxi\` and \`!taxi\` of the same flight path: no character sees it`), r.text);
});

test('the emitted predicate carries name and node on a step, a skipto or a next option, and the pack is written in format 10', () => {
	const r = compile(guideText(['step One', '  when !taxi "Ironforge"', '  accept 783']), DATA);
	assert.deepEqual(r.errors, [], r.text);
	assert.match(emitGuides(r.guides.map((guide) => ({ guide }))), /\n\t\t\t\t\twhen = \{ \{ k = "taxi", neg = true, name = "Ironforge", node = 6 \} \},\n/);
	assert.equal(formatFor(r.guides), TAXI_FORMAT);
	assert.deepEqual([TAXI_FORMAT, NEEDS[TAXI_FORMAT]], [10, '0.4.0']);
	const jump = compile(guideText(['step One', '  skipto fly when taxi "Ironforge"', '  accept 783', 'step Walk', '  turnin 783', 'step Fly', '  label fly', '  note Fly.']), DATA);
	assert.deepEqual(jump.errors, [], jump.text);
	assert.deepEqual(plain(jump.guides[0].steps)[0].skipto, [{ to: 'fly', when: { k: 'taxi', name: 'Ironforge', node: 6 } }]);
	assert.equal(formatFor(jump.guides), TAXI_FORMAT);
	const follower = ['guide t/flyer', 'title Flyer', 'faction Alliance', 'levels 10-20', 'zone Elwynn Forest', 'pitch For flyers.', '', 'step Start', '  note Go on.', ''].join('\n');
	const main = ['guide t/main', 'title Main', 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', 'next t/flyer when taxi "Ironforge"', '', 'step Start', '  note Go on.', ''].join('\n');
	const n = compile({ 'main.guide': main, 'flyer.guide': follower }, DATA);
	assert.deepEqual(n.errors, [], n.text);
	assert.deepEqual(plain(n.guides.find((g) => g.id === 't/main').nextWhen), { 't/flyer': [{ k: 'taxi', name: 'Ironforge', node: 6 }] });
	assert.equal(formatFor(n.guides), TAXI_FORMAT);
});
