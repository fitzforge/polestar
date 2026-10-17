'use strict';
// The .guide parser (tools/lib/dsl/parse.js): docs/GUIDE_FORMAT.md syntax,
// with an error at the right line for every malformed construct.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { guideText, lineOf, compile } = require('./helpers/dsl');
const { needs } = require('./helpers/data');

function parse(text) {
	const diag = new Diagnostics();
	const ast = parseGuide(text, 'x.guide', diag);
	return {
		ast,
		errors: diag.sorted().filter((d) => d.severity === 'error').map((d) => `${d.line}: ${d.message}`),
		warnings: diag.sorted().filter((d) => d.severity === 'warning').map((d) => `${d.line}: ${d.message}`),
	};
}

function goals(ast) {
	return ast.steps.flatMap((s) => s.goals);
}

test('the GUIDE_FORMAT.md example parses without errors into the documented structure', () => {
	const doc = fs.readFileSync(path.join(__dirname, '..', 'docs', 'GUIDE_FORMAT.md'), 'utf8');
	const example = /```\n(guide [\s\S]*?)```/.exec(doc)[1];
	const { ast, errors, warnings } = parse(example);
	assert.deepEqual(errors, []);
	assert.deepEqual(warnings, []);
	assert.equal(ast.id, 'joe-routes/northshire');
	assert.deepEqual(ast.header.levels, { min: 1, max: 6 });
	assert.equal(ast.header.faction, 'Alliance');
	assert.deepEqual(ast.header.races, ['Human']);
	assert.deepEqual(ast.header.next, ['joe-routes/elwynn']);
	assert.deepEqual(ast.header.zone.name, 'Elwynn Forest');
	assert.deepEqual(
		ast.steps.map((s) => [s.title, s.goals.length]),
		[
			['Deputy Willem', 5],
			['Kobold camp', 2],
			['Back to the abbey', 3],
		],
	);
	assert.equal(ast.steps[1].tip, 'Pull one kobold at a time until level 3.');
	const g = goals(ast);
	assert.deepEqual(
		g.map((x) => x.verb),
		['accept', 'turnin', 'accept', 'accept', 'accept', 'kill', 'collect', 'turnin', 'train', 'level'],
	);
	assert.equal(g[0].note, 'He stands at the abbey gate');
	assert.equal(g[3].quest, 33);
	assert.equal(g[4].npc, 196);
	assert.deepEqual([g[5].npc, g[5].count, g[5].quest, g[5].oi], [6, 10, 7, 1]);
	assert.deepEqual([g[6].item, g[6].count, g[6].quest, g[6].oi, g[6].optional], [750, 8, 33, 1, true]);
	assert.deepEqual(g[8].only, { classes: ['WARRIOR', 'PALADIN'], races: null, factions: null });
	assert.equal(g[8].note, 'Llane Beshere is inside the abbey');
	assert.equal(g[9].level, 4);
});

// Each malformed line is placed inside an otherwise valid guide; the parser must
// report exactly one error, on that line.
const MALFORMED = [
	['  fight 6', /unknown verb "fight"/],
	['  kill 6 loudly', /unknown modifier "loudly"/],
	['  accept 78x', /malformed quest id "78x"/],
	['  accept 0', /malformed quest id "0"/],
	['  goto 47.6;35.1', /malformed coordinates "47\.6;35\.1"/],
	['  goto "Camp"', /needs coordinates/],
	['  kill 6 @', /expected coordinates/],
	['  kill 6 @50', /malformed coordinates "50"/],
	['  accept 7 "Kobold', /unterminated string/],
	['  accept 7 "a\\q"', /unknown escape \\q/],
	['  accept 7 "x"y', /after closing quote/],
	['  accept 7 ab"c"', /quote must start a new token/],
	['  kill 6 quest 7.x', /malformed quest link "7\.x"/],
	['  kill 6 quest 7.0', /malformed quest link "7\.0"/],
	['  turnin 7 lvl 3', /`lvl` does not apply to `turnin`/],
	['  goto 1,2 @3,4', /`@x,y` does not apply to `goto`/],
	['  kill 6 x3 x4', /duplicate `xN`/],
	['  kill 6 x0', /malformed count "x0"/],
	['  kill 6 npc 7', /`npc` already given positionally/],
	['  kill 6 r -3', /malformed radius/],
	['  kill 6 map abc', /malformed map id "abc"/],
	['  train only !Human', /only classes can be negated/],
	['  train only Warrior,,Mage', /empty condition/],
	['  level three', /malformed level "three"/],
	['  sethome', /needs a "Location"/],
	['  note', /`note` needs text/],
	['  -- a note with no goal', /note must follow a goal/],
	['  accept 7 -- ', /empty ` -- ` note/],
	['  zone map x', /malformed `zone map <uiMapID>`/],
	['  only', /`only` needs a condition list/],
	['  tip', /`tip` needs text/],
	['  "quoted"', /expected a verb, found a string/],
	['bogus line', /unexpected `bogus` in column 0/],
];

for (const [line, re] of MALFORMED) {
	test(`malformed goal line reports its line: ${line.trim()}`, () => {
		const text = guideText(['step One', '  accept 7', line, '  turnin 7']);
		const { errors } = parse(text);
		const ln = text.split('\n').indexOf(line) + 1;
		assert.equal(errors.length, 1, errors.join('\n'));
		assert.match(errors[0], new RegExp(`^${ln}: `));
		assert.match(errors[0], re);
	});
}

const HEADER_ERRORS = [
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'title B', 'step S', '  level 2'], 'title B', /duplicate header key `title` \(first on line 2\)/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'colour red', 'step S', '  level 2'], 'colour red', /unknown header key "colour"/],
	[['guide t/a', 'title A', 'levels 6-5', 'zone Elwynn Forest', 'step S', '  level 2'], 'levels 6-5', /malformed levels "6-5"/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'faction Scourge', 'step S', '  level 2'], 'faction Scourge', /faction must be Alliance or Horde/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'class Warrior,Human', 'step S', '  level 2'], 'class Warrior,Human', /unknown class "Human"/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'race Human,Mage', 'step S', '  level 2'], 'race Human,Mage', /"Mage" is a class/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'version 1.5', 'step S', '  level 2'], 'version 1.5', /version must be an integer/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'next Not A Valid Id', 'step S', '  level 2'], 'next Not A Valid Id', /malformed guide id/],
	[['guide T/Upper', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'step S', '  level 2'], 'guide T/Upper', /malformed guide id "T\/Upper"/],
	[['guide forever/alliance/', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'step S', '  level 2'], 'guide forever/alliance/', /malformed guide id "forever\/alliance\/"/],
	[['guide /forever', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'step S', '  level 2'], 'guide /forever', /malformed guide id "\/forever"/],
	[['guide a//b', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'step S', '  level 2'], 'guide a//b', /malformed guide id "a\/\/b"/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'next t/b/', 'step S', '  level 2'], 'next t/b/', /malformed guide id "t\/b\/" in `next`/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', '  level 1', 'step S', '  level 2'], '  level 1', /indented line before the first `step`/],
	[['guide t/a', 'title A -- note', 'levels 1-5', 'zone Elwynn Forest', 'step S', '  level 2'], 'title A -- note', /only allowed on goal lines/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'step Empty', 'step S', '  level 2'], 'step Empty', /step has no goals/],
	[['title A', 'guide t/a', 'levels 1-5', 'zone Elwynn Forest', 'step S', '  level 2'], 'title A', /must start with `guide <id>`/],
	[['guide t/a', 'levels 1-5', 'zone Elwynn Forest', 'step S', '  level 2'], 'guide t/a', /missing required header `title`/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest'], 'guide t/a', /guide has no steps/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'keywords horse, , pinto', 'step S', '  level 2'], 'keywords horse, , pinto', /`keywords` has an empty entry/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'folder', 'step S', '  level 2'], 'folder', /`folder` needs a value/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'folder A', 'folder B', 'step S', '  level 2'], 'folder B', /duplicate header key `folder`/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'collects 2414, x5655', 'step S', '  level 2'], 'collects 2414, x5655', /malformed item id "x5655" in `collects`/],
	[['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'collects 2414,2414', 'step S', '  level 2'], 'collects 2414,2414', /`collects` names the same item twice/],
];

for (const [lines, at, re] of HEADER_ERRORS) {
	test(`header/structure error reports its line: ${re.source}`, () => {
		const text = `${lines.join('\n')}\n`;
		const { errors } = parse(text);
		assert.equal(errors.length, 1, errors.join('\n'));
		assert.match(errors[0], new RegExp(`^${lineOf(text, at)}: `));
		assert.match(errors[0], re);
	});
}

test('several errors in one file are all reported, each at its own line', () => {
	const text = guideText(['step One', '  fight 1', '  accept 7', '  kill 6 x', '  goto 1;2']);
	const { errors } = parse(text);
	assert.deepEqual(
		errors.map((e) => Number(e.split(':')[0])),
		[lineOf(text, '  fight 1'), lineOf(text, '  kill 6 x'), lineOf(text, '  goto 1;2')],
	);
});

test('comments, notes and quotes follow the lexical rules', () => {
	const text = guideText([
		'guide t/a',
		'title C#Sharp is not a comment',
		'levels 1-5',
		'zone Elwynn Forest # comment after a header value',
		'',
		'step One # the step title stops here',
		'  # whole-line comment',
		'  accept 7 # trailing comment',
		'  goto 1,2 "camp # not a comment"',
		'  accept 33 -- see #2, it -- stays',
		'  accept 5261 "Say \\"hi\\" \\\\ bye"',
		'  turnin 7 "x -- y"',
	]);
	const { ast, errors } = parse(text);
	assert.deepEqual(errors, []);
	assert.equal(ast.header.title, 'C#Sharp is not a comment');
	assert.equal(ast.header.zone.name, 'Elwynn Forest');
	assert.equal(ast.steps[0].title, 'One');
	const g = goals(ast);
	assert.equal(g.length, 5);
	assert.equal(g[0].note, undefined);
	assert.equal(g[1].text, 'camp # not a comment');
	assert.equal(g[2].note, 'see #2, it -- stays');
	assert.equal(g[3].title, 'Say "hi" \\ bye');
	assert.equal(g[4].title, 'x -- y');
	assert.equal(g[4].note, undefined);
});

test('keywords are case-insensitive and coordinates accept the documented spellings', () => {
	const text = guideText(['STEP One', '  ACCEPT 7 NPC 197 Optional', '  Kill 6 @47.6,35.1', '  kill 6 @ 47.6,35.1', '  kill 6 @47.6, 35.1', '  kill 6 @47.6 ,35.1 map 1453 r 12.5']);
	const { ast, errors } = parse(text);
	assert.deepEqual(errors, []);
	const g = goals(ast);
	assert.deepEqual([g[0].verb, g[0].npc, g[0].optional], ['accept', 197, true]);
	for (const k of [1, 2, 3, 4]) assert.deepEqual([g[k].x, g[k].y], [47.6, 35.1]);
	assert.deepEqual([g[4].coordMap, g[4].r], [1453, 12.5]);
});

test('note text is the rest of the line unless quoted, and quoted notes take modifiers', () => {
	const text = guideText(['step One', '  note Watch out for "Hogger" here -- really', '  note "Mind the guards" only !Hunter @ 42.5,64']);
	const { ast, errors } = parse(text);
	assert.deepEqual(errors, []);
	const g = goals(ast);
	assert.equal(g[0].text, 'Watch out for "Hogger" here');
	assert.equal(g[0].note, 'really');
	assert.equal(g[1].text, 'Mind the guards');
	assert.deepEqual([g[1].x, g[1].y], [42.5, 64]);
	assert.equal(g[1].only.classes.length, 8);
	assert.ok(!g[1].only.classes.includes('HUNTER'));
});

test('conditions: classes, races (Undead -> Scourge, Skyborne), factions, negation and unknown races', () => {
	const text = guideText([
		'step One',
		'only Warrior, Paladin,Dwarf',
		'  train only !Hunter,!Mage',
		'  train only Undead,Horde',
		'  train only Skyborne',
		'  train only Haranir',
	].map((l, i) => (i === 1 ? `  ${l}` : l)));
	const { ast, errors, warnings } = parse(text);
	assert.deepEqual(errors, []);
	assert.deepEqual(ast.steps[0].only, { classes: ['WARRIOR', 'PALADIN'], races: ['Dwarf'], factions: null });
	const g = goals(ast);
	// Negations OR together: "not Hunter" or "not Mage" admits everyone.
	assert.equal(g[0].only.classes.length, 9);
	assert.deepEqual(g[1].only, { classes: null, races: ['Scourge'], factions: ['Horde'] });
	assert.deepEqual(g[2].only.races, ['Skyborne']);
	assert.deepEqual(g[3].only.races, ['Haranir']);
	assert.equal(warnings.length, 1);
	assert.match(warnings[0], new RegExp(`^${lineOf(text, '  train only Haranir')}: unknown race "Haranir"`));
});

test('Skyborne plays on both sides: the faction picks its quest-mask bit, Era-only masks never exclude it', () => {
	const { applicable, maskExcludes, raceSides } = require('../tools/lib/dsl/conditions');
	assert.deepEqual(raceSides('Skyborne'), ['Alliance', 'Horde']);
	const horde = applicable([{ factions: ['Horde'], races: ['Skyborne'] }]);
	const alliance = applicable([{ factions: ['Alliance'], races: ['Skyborne'] }]);
	assert.deepEqual([horde.races, alliance.races], [['Skyborne'], ['Skyborne']]);
	const q = (races) => ({ races, classes: null, source: ['questie-forever'] });
	assert.equal(maskExcludes(horde, q(2 ** 33)), null);
	assert.equal(maskExcludes(horde, q(2 ** 32)), 'race');
	assert.equal(maskExcludes(alliance, q(2 ** 32 + 1)), null);
	assert.equal(maskExcludes(alliance, q(1)), 'race');
	assert.equal(maskExcludes(alliance, { races: 1, classes: null, source: ['pfquest'] }), null, 'pfQuest masks are Era masks');
	assert.equal(maskExcludes(applicable([{ races: ['Human'] }]), q(2 ** 32 + 1)), null);
});

test('the race table agrees with the Forever client (data/forever/races.json)', { skip: needs('races.json') }, () => {
	const { RACE_BY_FILE } = require('../tools/lib/game/races');
	const races = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'forever', 'races.json'), 'utf8'));
	const fromData = Object.fromEntries(Object.entries(races).map(([file, sides]) => [file, Object.fromEntries(Object.entries(sides).map(([s, v]) => [s, v.bit]))]));
	const fromTable = Object.fromEntries(Object.values(RACE_BY_FILE).map((r) => [r.file, r.sides]));
	assert.deepEqual(fromTable, fromData);
});

test('zone directives are sticky across later steps; the header zone applies before them', () => {
	const text = guideText(['step One', '  level 2', '  zone Stormwind City', '  level 3', 'step Two', '  level 4', '  zone map 1411', '  level 5']);
	const { ast, errors } = parse(text);
	assert.deepEqual(errors, []);
	assert.deepEqual(
		goals(ast).map((g) => g.zone.name || g.zone.map),
		['Elwynn Forest', 'Stormwind City', 'Stormwind City', 1411],
	);
});

test('skip none: a leveling guide does every step (everyStep); another word is an error, another category a warning', () => {
	const ok = compile(guideText(['skip none', '', 'step S', '  level 2']));
	assert.deepEqual(ok.errors, []);
	assert.deepEqual(ok.warnings, []);
	assert.equal(ok.guides[0].everyStep, true);
	assert.equal(compile(guideText(['step S', '  level 2'])).guides[0].everyStep, undefined);

	const bad = guideText(['skip grey', '', 'step S', '  level 2']);
	assert.deepEqual(parse(bad).errors, [`${lineOf(bad, 'skip grey')}: skip takes none (\`skip none\`: every step is done), not "grey"`]);

	const item = guideText(['category Collectibles', 'skip none', '', 'step S', '  level 2']);
	const { warnings } = compile(item);
	assert.deepEqual(warnings, [`test.guide:${lineOf(item, 'skip none')}: \`skip none\` is for leveling guides: a Collectibles guide already does every step`]);
});

test('folder and keywords: the folder is the rest of the line; keywords split on commas, repeats warn and drop', () => {
	const text = guideText(['guide t/a', 'title A', 'levels 1-5', 'zone Elwynn Forest', 'folder Mounts · Level 40', 'keywords Pinto Bridle, chestnut mare,pinto bridle', 'step S', '  level 2']);
	const { ast, errors, warnings } = parse(text);
	assert.deepEqual(errors, []);
	assert.equal(ast.header.folder, 'Mounts · Level 40');
	assert.deepEqual(ast.header.keywords, ['Pinto Bridle', 'chestnut mare']);
	assert.equal(warnings.length, 1);
	assert.match(warnings[0], new RegExp(`^${lineOf(text, 'keywords Pinto Bridle, chestnut mare,pinto bridle')}: \`keywords\` lists "pinto bridle" twice`));
});
