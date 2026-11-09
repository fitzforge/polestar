'use strict';
// The source tree (tools/lib/pack/sourcetree.js): a guide's source as data,
// written back to .guide text that compiles to the same guide, for every
// guide under guides/; and `polestar decode`, which writes a pack from a
// payload's source.
//
// The round trip compiles with data/forever when it is built, else with the
// compiler's fixture data (both sides the same, so the check holds either way).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs, DATA } = require('./helpers/data');
const { fixtureData, guideText, compile } = require('./helpers/dsl');
const { quiet } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');
const { main } = require('../tools/polestar');
const { loadData } = require('../tools/lib/dsl/data');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { compileSources, findGuideFiles, OFFICIAL_DIR } = require('../tools/lib/dsl/project');
const { guideData } = require('../tools/lib/dsl/emit');
const { encodeImport, importString } = require('../tools/lib/pack/importstring');
const { toTree, toText, TREE_KEYS } = require('../tools/lib/pack/sourcetree');
const { writeDecoded } = require('../tools/commands/decode');

const parse = (text) => parseGuide(text, 'test.guide', new Diagnostics());
const roundTrip = (text) => toText(toTree(parse(text)));
// Each guide's emitted data by id.
const emitted = (guides) => new Map(guides.map((g) => [g.id, JSON.parse(JSON.stringify(guideData(g._localised || g)))]));

test('every guide under guides/ compiles to the same guide from its source tree', () => {
	const files = findGuideFiles(OFFICIAL_DIR);
	assert.ok(files.length > 200, `found ${files.length} guides`);
	const data = needs('quests.json') ? fixtureData() : loadData(DATA);
	const original = files.map((rel) => ({ source: rel, file: rel, text: fs.readFileSync(path.join(OFFICIAL_DIR, rel), 'utf8') }));
	const written = original.map((s) => ({ ...s, text: roundTrip(s.text) }));
	const a = emitted(compileSources(original, data).guides);
	const b = emitted(compileSources(written, data).guides);
	assert.equal(b.size, a.size);
	for (const [id, g] of a) assert.deepEqual(b.get(id), g, `${id} compiles differently from its source tree`);
});

test('the tree keeps values as written, drops comments and keeps notes', () => {
	const text = guideText([
		'# a comment line',
		'step "Deputy # Willem"   # trailing comment',
		'  id abc123',
		'  label camp',
		'  zone "Elwynn Forest"',
		'  only Human, Dwarf',
		'  when level >= 2',
		'  tip First line.',
		'  accept 783 "A Threat Within"  npc 823 @47.6, 35.1   -- Deputy Willem',
		'  note go  there',
		'  tip Second line.',
		'  zone Westfall',
		'  kill 6 x10 quest 7.1 optional era',
		'',
		'step',
		'  along until camp',
		'  loop',
		'  turnin 783 reward 1 "Bag" rare 2',
	]);
	const tree = toTree(parse(text));
	assert.equal(tree.v, 1);
	assert.deepEqual(tree.header, { guide: 't/main', title: 'Test', faction: 'Alliance', levels: '1-10', zone: 'Elwynn Forest' });
	const [s1, s2] = tree.steps;
	assert.deepEqual(
		{ ...s1, goals: undefined },
		{ title: 'Deputy # Willem', id: 'abc123', label: 'camp', zone: 'Elwynn Forest', only: 'Human, Dwarf', when: ['level >= 2'], tip: 'First line.\nSecond line.', goals: undefined },
	);
	assert.deepEqual(s1.goals, [
		{ verb: 'accept', args: ['783', '"A Threat Within"'], mods: [['npc', '823'], ['at', '@47.6,', '35.1']], note: 'Deputy Willem' },
		{ verb: 'note', args: ['go  there'], mods: [] },
		{ verb: 'kill', args: ['6'], mods: [['count', 'x10'], ['quest', '7.1'], ['optional'], ['frame', 'era']], zone: 'Westfall' },
	]);
	assert.deepEqual(s2, { title: '', along: 'until camp', loop: '', goals: [{ verb: 'turnin', args: ['783'], mods: [['reward', '1', '"Bag"', 'rare', '2']] }] });
	const out = toText(tree);
	assert.ok(!out.includes('comment'), out);
	assert.match(out, /^step "Deputy # Willem"$/m);
	assert.match(out, /^ {2}accept 783 "A Threat Within" npc 823 @47\.6, 35\.1 -- Deputy Willem$/m);
	assert.match(out, /^ {2}zone Westfall\n {2}kill 6 x10 quest 7\.1 optional era$/m);
	assert.deepEqual(toTree(parse(out)), tree, 'the written text reads back to the same tree');
});

test('every header key and step directive survives the round trip', () => {
	const text = [
		'guide t/all',
		'title All keys',
		'levels 1-10',
		'zone Elwynn Forest',
		'faction Alliance',
		'race Human',
		'class Warrior, Mage',
		'next t/b',
		'next t/c when level >= 9',
		'category Leveling',
		'folder Tests',
		'keywords one, two',
		'collects 2414',
		'reward item 2414 "Bag" rare',
		'reward text a good time',
		'why Because',
		'author Joe',
		'credits Yendi',
		'credits Ann: maps',
		'forked-from t/old 2',
		'version 3',
		'coords era',
		'pitch Short',
		'pro Fast',
		'pro Safe',
		'con Long',
		'',
		'step One',
		'  image media/one.tga 512x256',
		'  skipto two when level >= 5',
		'  skipto two when level >= 6',
		'  when level >= 2',
		'  when level <= 9',
		'  goto 40,50',
		'step Two',
		'  label two',
		'  goto 41,51',
		'',
	].join('\n');
	const tree = toTree(parse(text));
	assert.deepEqual(tree.header.next, ['t/b', 't/c when level >= 9']);
	assert.deepEqual(tree.header.credits, ['Yendi', 'Ann: maps']);
	assert.deepEqual(tree.header.pro, ['Fast', 'Safe']);
	assert.deepEqual(tree.header.reward, ['item 2414 "Bag" rare', 'text a good time']);
	assert.equal(tree.header['forked-from'], 't/old 2');
	assert.deepEqual(tree.steps[0].skipto, ['two when level >= 5', 'two when level >= 6']);
	assert.equal(tree.steps[0].image, 'media/one.tga 512x256');
	const diag = new Diagnostics();
	const a = parseGuide(text, 'a.guide', diag);
	const b = parseGuide(toText(tree), 'b.guide', diag);
	assert.deepEqual(diag.errors, []);
	// Same guide apart from line numbers (`loop` holds its line too).
	const strip = (v) => JSON.parse(JSON.stringify(v, (k, x) => (/line$|Line$|^lines$|^file$|^loop$/i.test(k) ? undefined : x)));
	assert.deepEqual(strip(b), strip(a));
});

test('TREE_KEYS names every key a tree can hold', () => {
	assert.deepEqual(TREE_KEYS.tree, ['v', 'header', 'steps']);
	assert.ok(TREE_KEYS.header.includes('credits') && TREE_KEYS.header.includes('forked-from'));
	assert.deepEqual(TREE_KEYS.headerLists, ['next', 'reward', 'credits', 'pro', 'con']);
	assert.deepEqual(TREE_KEYS.step, ['title', 'id', 'label', 'along', 'background', 'zone', 'only', 'when', 'skipto', 'image', 'loop', 'tip', 'goals', 'zoneEnd']);
	assert.deepEqual(TREE_KEYS.stepLists, ['when', 'skipto']);
	assert.deepEqual(TREE_KEYS.goal, ['verb', 'args', 'mods', 'note', 'zone']);
});

test('toText refuses a tree whose text would not read back as that tree', () => {
	const ok = { v: 1, header: { guide: 't/x', title: 'X', levels: '1-2', zone: 'Elwynn Forest' }, steps: [{ title: 'A', goals: [{ verb: 'goto', args: ['40,50'], mods: [] }] }] };
	assert.match(toText(ok), /^guide t\/x\ntitle X\n/);
	const bad = (mutate, re) => {
		const t = JSON.parse(JSON.stringify(ok));
		mutate(t);
		assert.throws(() => toText(t), re);
	};
	bad((t) => (t.v = 2), /version/);
	bad((t) => (t.header.title = 'X\nstep Evil'), /line break/);
	bad((t) => (t.header.evil = 'x'), /header key "evil"/);
	bad((t) => (t.steps[0].goals[0].verb = 'evil'), /verb "evil"/);
	bad((t) => (t.steps[0].goals[0].args = ['40,50\n  kill 1']), /line break/);
	bad((t) => (t.steps[0].goals[0].mods = [['evil']]), /modifier "evil"/);
	bad((t) => (t.steps[0].wat = 'x'), /step key "wat"/);
	bad((t) => (t.steps[0].when = 'level >= 2'), /list/);
	// Tokens that would write as something else, caught by reading the text back.
	const note = { verb: 'note', args: ['go # there'], mods: [] };
	bad((t) => t.steps[0].goals.push(note), /steps\[1\]\.goals\[2\] does not read back the same/); // a comment
	bad((t) => (t.steps[0].goals[0].args = ['40,50 -- sneaky']), /steps\[1\]\.goals\[1\] does not read back the same/); // a note
	bad((t) => t.steps[0].goals.push({ verb: 'accept', args: ['783', 'A Threat Within'], mods: [] }), /steps\[1\]\.goals\[2\] does not write as a line that parses/); // an unquoted name
	bad((t) => t.steps[0].goals.push({ verb: 'kill', args: ['"Kobold"'], mods: [['npc', '823 quest 7']] }), /steps\[1\]\.goals\[2\] does not read back the same/); // two modifiers in one
	bad((t) => (t.steps[0].goals[0].note = ''), /steps\[1\]\.goals\[1\] does not write as a line that parses: empty/);
	bad((t) => (t.steps[0].tip = 'First.\n\nThird.'), /steps\[1\]\.tip does not write as a line that parses: `tip` needs text/);
	bad((t) => (t.steps[0].goals[0].zone = 'Westfall'), /steps\[1\]\.zone does not read back the same/); // a first goal's zone is the step's
});

test('a zone line after a step\'s last goal is the step\'s zoneEnd, written after its goals', () => {
	const text = guideText(['step A', '  goto 40,50', '  zone Westfall', 'step B', '  goto 41,51']);
	const tree = toTree(parse(text));
	assert.equal(tree.steps[0].zoneEnd, 'Westfall');
	assert.equal(tree.steps[1].zone, undefined);
	const out = toText(tree);
	assert.match(out, /^ {2}goto 40,50\n {2}zone Westfall\n\nstep B$/m);
	assert.deepEqual(toTree(parse(out)), tree);
});

test('a zone name that reads as `map <id>` keeps its quotes, and the map form stays the map', () => {
	const text = guideText(['step A', '  zone "Map 5"', '  goto 40,50', '  zone map 1429', '  goto 41,51']);
	const tree = toTree(parse(text));
	assert.equal(tree.steps[0].zone, '"Map 5"');
	assert.equal(tree.steps[0].goals[1].zone, 'map 1429');
	const [g1, g2] = parse(toText(tree)).steps[0].goals;
	assert.deepEqual(g1.zone, { name: 'Map 5', line: g1.zone.line });
	assert.deepEqual(g2.zone, { map: 1429, line: g2.zone.line });
});

test('decode writes a pack from a payload with source', async () => {
	const text = guideText(['step A', '  goto 40,50 -- here']).replace('guide t/main', 'guide joe-routes/elwynn/intro').replace('zone Elwynn Forest', 'zone Elwynn Forest\nauthor Joe');
	const payload = { format: 3, license: 'CC-BY-4.0', guide: { id: 'joe-routes/elwynn/intro', title: 'Test', author: 'Joe', version: 2 }, source: toTree(parse(text)) };
	const dir = path.join(tmpdir(), 'out');
	const r = writeDecoded(payload, dir);
	assert.equal(r.file, path.join(dir, 'guides', 'elwynn-intro.guide'));
	assert.deepEqual(JSON.parse(fs.readFileSync(path.join(dir, 'pack.json'), 'utf8')), { id: 'joe-routes', title: 'Test', author: 'Joe', version: '2', license: 'CC-BY-4.0' });
	assert.equal(fs.readFileSync(r.file, 'utf8'), toText(payload.source));

	// From the command line, a JSON payload file.
	const json = path.join(tmpdir(), 'payload.json');
	fs.writeFileSync(json, JSON.stringify(payload));
	const out2 = path.join(tmpdir(), 'out2');
	const run = await quiet(() => main(['decode', json, '--out', out2]));
	assert.equal(run.result, 0, run.out);
	assert.ok(fs.existsSync(path.join(out2, 'guides', 'elwynn-intro.guide')));
	// A folder that already holds files is never written into.
	const again = await quiet(() => main(['decode', json, '--out', out2]));
	assert.equal(again.result, 1);
	assert.match(again.out, /not empty/);
});

test('decode refuses a v1 string: it has no source', async () => {
	const s = encodeImport({ format: 3, license: 'CC-BY-4.0', guide: { id: 'joe/x', title: 'X', steps: [] } });
	const r = await quiet(() => main(['decode', s, '--out', path.join(tmpdir(), 'v1')]));
	assert.equal(r.result, 1);
	assert.match(r.out, /no source in a v1 string/);
});

test('decode reads a v2 string: a guide exported as v2 and decoded compiles to the same guide', async () => {
	const text = [
		'guide yendi/northshire', 'title Northshire Valley', 'faction Alliance', 'levels 1-6', 'zone Elwynn Forest', 'author Yendi', 'version 2',
		'credits Bob the Builder', 'credits Ann', 'forked-from bob/northshire 3', 'pro Short', 'pro Quiet',
		'', 'step Deputy Willem', '  id k3x9qa', '  skipto camp when level >= 5', '  tip Talk first.', '  accept 783 "A Threat Within" -- Deputy Willem', '  note "Then wait"',
		'', 'step Marshal McBride', '  turnin 783', '  accept 7',
		'', 'step Kobold camp', '  label camp', '  goto 47.6,35.1 "Kobold camp"', '  kill 6 x10 quest 7.1 optional',
	].join('\n');
	const data = fixtureData();
	const first = compile({ 'northshire.guide': text }, data, { pack: 'yendi' });
	assert.deepEqual(first.errors, []);
	const r = importString(first.guides[0], { manifest: { id: 'yendi', license: 'CC-BY-4.0' }, data, source: first.guides[0]._ast, v2: true });
	assert.equal(r.error, undefined);
	assert.match(r.text, /^!PS2!/);
	const out = path.join(tmpdir(), 'v2');
	const run = await quiet(() => main(['decode', r.text, '--out', out]));
	assert.equal(run.result, 0, run.out);
	const written = fs.readFileSync(path.join(out, 'guides', 'northshire.guide'), 'utf8');
	const again = compile({ 'northshire.guide': written }, data, { pack: 'yendi' });
	assert.deepEqual(again.errors, []);
	assert.deepEqual(emitted(again.guides), emitted(first.guides));
});
