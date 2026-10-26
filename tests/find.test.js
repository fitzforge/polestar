'use strict';
// polestar find: the reference data and our guides searched by id or name,
// each result with a guide line ready to paste.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { quiet } = require('./helpers/cli');
const { loadData } = require('../tools/lib/dsl/data');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics, format } = require('../tools/lib/dsl/diag');
const { find, loadGuideHeaders } = require('../tools/lib/find');
const cmd = require('../tools/commands/find');

const FIXTURE = path.join(__dirname, 'fixtures', 'find');
const DATA = path.join(FIXTURE, 'data');
const GUIDES = path.join(FIXTURE, 'guides');
const data = loadData(DATA);
const guides = loadGuideHeaders(GUIDES);

test('a quest by title: its id, level, starter and ender with zones and coordinates', () => {
	const [r] = find(data, guides, { text: 'westfall stew', kind: 'quest' });
	assert.deepEqual(
		{ kind: r.kind, id: r.id, name: r.name, level: r.level, zone: r.zone, x: r.x, y: r.y },
		{ kind: 'quest', id: 36, name: 'Westfall Stew', level: 10, zone: 'Westfall', x: 59.92, y: 19.42 },
	);
	assert.deepEqual(r.starts, { kind: 'npc', id: 238, name: 'Verna Furlbrow', zone: 'Westfall', x: 59.92, y: 19.42 });
	assert.deepEqual(r.ends, { kind: 'npc', id: 235, name: 'Salma Saldean', zone: 'Westfall', x: 56.42, y: 30.52 });
	assert.equal(r.line, 'accept 36  # Westfall Stew, level 10: Verna Furlbrow, Westfall 59.9,19.4');
});

test('numeric text matches ids exactly, in every kind', () => {
	const rs = find(data, guides, { text: '36' });
	assert.deepEqual(rs.map((r) => `${r.kind} ${r.id}`), ['quest 36']);
	assert.deepEqual(find(data, guides, { text: '33' }).map((r) => `${r.kind} ${r.id}`), ['object 33']);
	assert.deepEqual(find(data, guides, { text: '3' }), []);
});

test('--kind npc limits the search to NPCs', () => {
	const rs = find(data, guides, { text: 'a', kind: 'npc' });
	assert.ok(rs.length > 0);
	assert.ok(rs.every((r) => r.kind === 'npc'));
	const verna = rs.find((r) => r.id === 238);
	assert.equal(verna.line, 'talk 238  # Verna Furlbrow, level 20, Westfall 59.9,19.4');
	assert.equal(find(data, guides, { text: 'kobold', kind: 'npc' })[0].line, 'kill 6  # Kobold Vermin, level 1, Elwynn Forest 47.6,36.4');
});

test('--faction Horde drops Alliance-only quests and NPCs', () => {
	const all = find(data, guides, { text: 'stew' }).map((r) => `${r.kind} ${r.id}`);
	assert.ok(all.includes('quest 36'));
	const horde = find(data, guides, { text: 'stew', faction: 'Horde' }).map((r) => `${r.kind} ${r.id}`);
	assert.ok(!horde.includes('quest 36'));
	assert.ok(horde.includes('quest 900'));
	assert.ok(!find(data, guides, { text: 'verna', faction: 'Horde' }).some((r) => r.kind === 'npc'));
	assert.ok(!find(data, guides, { text: 'conscript', faction: 'Alliance' }).some((r) => r.id === 840));
	assert.ok(!find(data, guides, { text: 'westfall', kind: 'guide', faction: 'Horde' }).length);
});

test('a guide by title: its levels, who it is for and its own next', () => {
	const [g] = find(data, guides, { text: 'Westfall', kind: 'guide' });
	assert.equal(g.id, 'forever/alliance/02-westfall');
	assert.equal(g.name, 'Westfall');
	assert.equal(g.line, 'next forever/alliance/02-westfall  # Westfall (7-16), Alliance');
	assert.deepEqual({ levels: g.levels, faction: g.faction, races: g.races, classes: g.classes, next: g.next }, { levels: { min: 7, max: 16 }, faction: 'Alliance', races: null, classes: null, next: [] });
	const [human] = find(data, guides, { text: 'human/01', kind: 'guide' });
	assert.equal(human.line, 'next forever/alliance/human/01-elwynn-forest  # Elwynn Forest (1-13), Human only');
	assert.deepEqual(human.notes, ['# its next: forever/alliance/02-westfall']);
	const [dg] = find(data, guides, { text: 'dwarf-gnome', kind: 'guide' });
	assert.equal(dg.line, 'next forever/alliance/dwarf-gnome/02-elwynn  # Elwynn for Dwarves and Gnomes (5-12), Dwarf/Gnome only');
	assert.deepEqual(dg.races, ['Dwarf', 'Gnome']);
	assert.deepEqual(dg.next, ['forever/alliance/02-westfall', 'forever/collectibles/paladin-charger']);
	assert.deepEqual(dg.notes, ['# its next: forever/alliance/02-westfall or forever/collectibles/paladin-charger (route choice)']);
	const [pal] = find(data, guides, { text: 'charger', kind: 'guide' });
	assert.equal(pal.line, 'next forever/collectibles/paladin-charger  # Paladin Charger (60-60), Alliance Paladin only');
	assert.deepEqual(pal.classes, ['Paladin']);
});

test('guides match by zone; --race and --class keep the guides such a character can follow', () => {
	const ids = (opts) => find(data, guides, { text: 'elwynn', kind: 'guide', ...opts }).map((r) => r.id);
	assert.deepEqual(ids({}), ['forever/alliance/dwarf-gnome/02-elwynn', 'forever/alliance/human/01-elwynn-forest', 'forever/collectibles/paladin-charger']);
	assert.deepEqual(ids({ race: 'Gnome' }), ['forever/alliance/dwarf-gnome/02-elwynn', 'forever/collectibles/paladin-charger']);
	assert.deepEqual(ids({ race: 'Human', cls: 'WARRIOR' }), ['forever/alliance/human/01-elwynn-forest']);
	assert.deepEqual(ids({ race: 'Orc' }), []);
	assert.deepEqual(ids({ cls: 'PALADIN' }), ['forever/alliance/dwarf-gnome/02-elwynn', 'forever/alliance/human/01-elwynn-forest', 'forever/collectibles/paladin-charger']);
	// --race keeps quests by race mask: 36 is Alliance races only.
	assert.ok(!find(data, guides, { text: 'stew', race: 'Orc' }).some((r) => r.id === 36));
	assert.ok(find(data, guides, { text: 'stew', race: 'Dwarf' }).some((r) => r.id === 36));
});

test('a quest lists its objectives with index, kind, target and count, as `quest Q.O` lines', () => {
	const [r] = find(data, guides, { text: 'Stew for Everyone', kind: 'quest' });
	assert.deepEqual(r.objectives, [
		{ index: 1, kind: 'kill', id: 6, name: 'Kobold Vermin', count: 10 },
		{ index: 2, kind: 'item', id: 2832, name: "Verna's Westfall Stew Recipe", count: null },
		{ index: 3, kind: 'event', id: null, name: 'Taste the stew', count: null },
	]);
	assert.deepEqual(r.notes, ['# 900.1 = kill Kobold Vermin x10', "# 900.2 = collect Verna's Westfall Stew Recipe", '# 900.3 = event Taste the stew']);
	assert.deepEqual(find(data, guides, { text: 'westfall stew', kind: 'quest' })[0].objectives, []);
});

test('--limit caps the results', () => {
	assert.equal(find(data, guides, { text: 'e', limit: 2 }).length, 2);
});

test('every line parses without errors in a minimal guide', () => {
	const rs = find(data, guides, { text: 'e', limit: 100 });
	assert.deepEqual([...new Set(rs.map((r) => r.kind))].sort(), ['guide', 'item', 'npc', 'object', 'quest']);
	for (const r of rs) {
		const header = ['guide t/find', 'title Find', 'levels 1-10', 'zone Elwynn Forest'];
		const lines = r.kind === 'quest' ? [r.line, r.turnin] : [r.line];
		for (const line of lines) {
			const text = r.kind === 'guide' ? [...header, line, '', 'step One', '  goto 50,50'].join('\n') : [...header, '', 'step One', `  ${line}`].join('\n');
			const diag = new Diagnostics();
			parseGuide(`${text}\n`, 'find.guide', diag);
			assert.deepEqual(diag.errors.map(format), [], line);
		}
	}
});

test('find --json prints the results array', async () => {
	const { result, out } = await quiet(() => cmd.run(['Westfall Stew', '--data', DATA, '--guides', GUIDES, '--json']));
	assert.equal(result, 0);
	const rs = JSON.parse(out);
	assert.ok(Array.isArray(rs));
	assert.equal(rs[0].id, 36);
	assert.equal(rs[0].starts.name, 'Verna Furlbrow');
});

test('find prints one line per result; no match exits 1', async () => {
	const { result, out } = await quiet(() => cmd.run(['Westfall Stew', '--data', DATA, '--guides', GUIDES, '--kind', 'quest']));
	assert.equal(result, 0);
	assert.match(out, /accept 36 {2}# Westfall Stew, level 10: Verna Furlbrow, Westfall 59\.9,19\.4/);
	assert.match(out, /^turnin 36 {2}# Westfall Stew: Salma Saldean, Westfall 56\.4,30\.5$/m);
	const none = await quiet(() => cmd.run(['zzzz', '--data', DATA, '--guides', GUIDES]));
	assert.equal(none.result, 1);
	const bad = await quiet(() => cmd.run(['x', '--kind', 'spell', '--data', DATA]));
	assert.equal(bad.result, 2);
});

test('find prints objectives and a guide\'s next under its line; --race and --class take race and class names', async () => {
	const q = await quiet(() => cmd.run(['Stew for Everyone', '--data', DATA, '--guides', GUIDES, '--kind', 'quest']));
	assert.match(q.out, /^# 900\.1 = kill Kobold Vermin x10$/m);
	const g = await quiet(() => cmd.run(['elwynn', '--kind', 'guide', '--race', 'gnome', '--class', 'Warrior', '--data', DATA, '--guides', GUIDES]));
	assert.equal(g.result, 0, g.out);
	assert.deepEqual(g.out.split('\n').filter(Boolean), [
		'next forever/alliance/dwarf-gnome/02-elwynn  # Elwynn for Dwarves and Gnomes (5-12), Dwarf/Gnome only',
		'# its next: forever/alliance/02-westfall or forever/collectibles/paladin-charger (route choice)',
	]);
	const json = await quiet(() => cmd.run(['human/01', '--kind', 'guide', '--json', '--data', DATA, '--guides', GUIDES]));
	assert.deepEqual(JSON.parse(json.out).map((r) => [r.races, r.levels, r.next]), [[['Human'], { min: 1, max: 13 }, ['forever/alliance/02-westfall']]]);
	for (const bad of [['--race', 'Pandaren'], ['--class', 'Monk']]) {
		const r = await quiet(() => cmd.run(['x', ...bad, '--data', DATA]));
		assert.equal(r.result, 2);
		assert.match(r.out, new RegExp(`${bad[0]} must be one of`));
	}
});

test('missing reference data is an error naming the files and data build, not "nothing matches"', async () => {
	const empty = require('./helpers/tmp').tmpdir();
	for (const extra of [[], ['--json']]) {
		const { result, out } = await quiet(() => cmd.run(['Westfall Stew', '--data', empty, '--guides', GUIDES, ...extra]));
		assert.equal(result, 1);
		assert.match(out, /find: the reference data in .* is missing quests\.json, npcs\.json, objects\.json, items\.json, zones\.json; run forge data build/);
		assert.doesNotMatch(out, /nothing matches|^\[\]$/m);
	}
	// Guides need no reference data.
	const g = await quiet(() => cmd.run(['westfall', '--kind', 'guide', '--data', empty, '--guides', GUIDES]));
	assert.equal(g.result, 0, g.out);
});

test('a quest found by its starter takes the starter\'s zone with its coordinates; a level below 1 is not printed', () => {
	const d = loadData(DATA);
	const q = d.quests[36] || d.quests['36'];
	q.zone = 1429; // the quest's own zone says Elwynn Forest; its starter stands in Westfall
	q.level = -1;
	const [r] = find(d, [], { text: 'westfall stew', kind: 'quest' });
	assert.deepEqual({ zone: r.zone, x: r.x, y: r.y, level: r.level }, { zone: 'Westfall', x: 59.92, y: 19.42, level: undefined });
	assert.equal(r.line, 'accept 36  # Westfall Stew: Verna Furlbrow, Westfall 59.9,19.4');
});
