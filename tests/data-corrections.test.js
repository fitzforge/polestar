'use strict';
// forever-db/corrections: a correction that gives a quest its
// prerequisites must leave the quest blocked by them. QuestieDB's split
// fields win over pfQuest's `pre` once either is present (prereqs.js), so a
// `set` with `pre` and an empty `preAny` but no `preAll` blocks nothing.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

const { loadCorrections, loadPublicCorrections, overlayCorrections, PUBLIC_DIR, SECTIONS, SOURCE_KINDS } = require('../tools/lib/data/corrections');

const corrections = loadPublicCorrections();
const { blockingPrereqs, closedByOf } = require('../tools/lib/data/prereqs');

test('every public correction names an independent source, and its note cites no web page', () => {
	const bad = [];
	for (const section of SECTIONS) {
		for (const [id, entry] of Object.entries(corrections[section] || {})) {
			const sources = [].concat(entry.source || []);
			if (!sources.length || !sources.every((s) => SOURCE_KINDS.includes(s.kind) && typeof s.ref === 'string' && s.ref)) bad.push(`${section} ${id}: source`);
			if (typeof entry.note !== 'string' || /https?:|\[race=|snapshot/i.test(entry.note)) bad.push(`${section} ${id}: note`);
		}
	}
	assert.deepEqual(bad, []);
});

test('the corrections are one file per section in forever-db/corrections', () => {
	for (const s of SECTIONS) assert.ok(fs.existsSync(path.join(PUBLIC_DIR, `${s}.json`)), `${s}.json`);
	assert.ok(!fs.existsSync(path.join(__dirname, '..', 'tools', 'lib', 'data', 'corrections.json')), 'the old single file is gone');
});

test('the overlay takes mechanics flat or under quests; mechanics 603 and 1064 stay private', () => {
	const out = overlayCorrections({ mechanics: {} }, { mechanics: { quests: { 603: { note: 'nested' } }, 1064: { note: 'flat' } } });
	assert.deepEqual(Object.keys(out.mechanics).sort(), ['1064', '603']);
	assert.ok(!('603' in corrections.mechanics) && !('1064' in corrections.mechanics));
});

test('the private overlay adds its entries and merges shared ones field by field', () => {
	const pub = { _about: 'public', quests: { 1: { set: { start: { npc: [2] } }, source: { kind: 'tdb', ref: 'x' }, note: 'a' } }, npcs: {} };
	const priv = { _about: 'private', quests: { 1: { set: { races: 8 }, note: 'b' }, 3: { set: { xp: 10 }, note: 'c' } }, objects: { 4: { addSpawns: {}, note: 'd' } } };
	assert.deepEqual(overlayCorrections(pub, priv), {
		_about: 'public',
		quests: { 1: { set: { start: { npc: [2] }, races: 8 }, source: { kind: 'tdb', ref: 'x' }, note: 'b' }, 3: { set: { xp: 10 }, note: 'c' } },
		npcs: {},
		objects: { 4: { addSpawns: {}, note: 'd' } },
	});
	assert.deepEqual(pub.quests[1].set, { start: { npc: [2] } }, 'the public corrections stay as they were');
});

test('data build reads the overlay from data/local only when it is there, or the file it is given', () => {
	const root = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-corr-'));
	assert.deepEqual(loadCorrections({ root }), corrections, 'no overlay: the public corrections alone');
	fs.mkdirSync(path.join(root, 'data', 'local'), { recursive: true });
	const file = path.join(root, 'data', 'local', 'corrections-private.json');
	fs.writeFileSync(file, JSON.stringify({ quests: { 1: { set: { xp: 1 }, note: 'private' } } }));
	assert.deepEqual(loadCorrections({ root }).quests[1], { set: { xp: 1 }, note: 'private' });
	assert.deepEqual(loadCorrections({ root, privateFile: false }), corrections, '--no-corrections-private');
	assert.deepEqual(loadCorrections({ privateFile: file }).quests[1].note, 'private', '--corrections-private <file>');
	fs.rmSync(root, { recursive: true, force: true });
});

test('every prerequisite correction blocks the quest until its prerequisites are turned in', () => {
	const dead = [];
	for (const [id, entry] of Object.entries(corrections.quests || {})) {
		const set = entry && entry.set;
		if (!set || !['pre', 'preAll', 'preAny'].some((k) => Array.isArray(set[k]) && set[k].length > 0)) continue;
		const { all, any } = blockingPrereqs({ id: Number(id), start: { npc: [1] }, ...set });
		if (all.length === 0 && any.length === 0) dead.push(id);
	}
	assert.deepEqual(dead, [], `corrections that set prerequisites but block nothing: ${dead.join(', ')}`);
});

test('Highland Hides waits for Young Crocolisk Skins, not Daily Delivery (#533)', () => {
	const { all, any } = blockingPrereqs({ id: 98815, start: { npc: [2094] }, ...corrections.quests[98815].set });
	assert.deepEqual({ all, any }, { all: [], any: [484] });
});

test('The Wrath of Rath\'mael waits for the second Rear Guard Patrol, which waits for the first (#849)', () => {
	const { all, any } = blockingPrereqs({ id: 92422, start: { npc: [251001] }, ...corrections.quests[92422].set });
	assert.deepEqual({ all, any }, { all: [], any: [99156] });
	assert.deepEqual(corrections.quests[99156].set.preAny, [356]);
});

test('A Void Path waits for Never Coming Back, handed in to the same giver (#1002, #984)', () => {
	const entry = corrections.quests[98252];
	assert.ok(entry, 'a correction for A Void Path');
	const { all, any } = blockingPrereqs({ id: 98252, start: { npc: [267214] }, ...entry.set });
	assert.deepEqual({ all, any }, { all: [], any: [98251] });
});

test('Moonbrook Espionage waits for Murloc Gills as well as The State of the Mines (#991)', () => {
	const { all, any } = blockingPrereqs({ id: 92747, start: { npc: [253092] }, ...corrections.quests[92747].set });
	assert.deepEqual({ all, any }, { all: [92744], any: [92745] });
	assert.ok(!(corrections.quests[92745].set.preAll || []).includes(92744), 'The State of the Mines does not wait for Murloc Gills (#918)');
});

test('The New Plague waits for the A Recipe For Death chain, handed in to its last part (#867)', () => {
	const entry = corrections.quests[95216];
	assert.ok(entry, 'a correction for The New Plague');
	const { all, any } = blockingPrereqs({ id: 95216, start: { npc: [11835] }, ...entry.set });
	assert.deepEqual({ all, any }, { all: [], any: [451] });
});

test('Crocs of the Sky waits for Apprentice\'s Duties, and The Shamed Lieutenant for A Friend of the Family (#872 sweep)', () => {
	const blocks = (id, npc) => {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		return blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set });
	};
	assert.deepEqual(blocks(98072, 2094), { all: [], any: [471] }, 'James Halloran, Menethil Harbor');
	assert.deepEqual(blocks(98219, 928), { all: [], any: [98191] }, 'Lord Grayson Shadowbreaker, Stormwind');
});

test('Seeking Caitlin is closed by Lost in the Thicket Things, its breadcrumb target (#533)', () => {
	const quests = { 95737: { id: 95737, ...corrections.quests[95737].set }, 95647: { id: 95647 } };
	assert.deepEqual(closedByOf(95737, quests), [95647]);
});

test('Daily Delivery is closed by Young Crocolisk Skins, its breadcrumb target (#615)', () => {
	const quests = { 469: { id: 469, ...corrections.quests[469].set }, 484: { id: 484 } };
	assert.deepEqual(closedByOf(469, quests), [484]);
});

test('Benedict\'s Chest opens with Benedict\'s Key (#467)', () => {
	assert.deepEqual(corrections.objects[3239].set.lock, { item: 4882 });
});

test('class quests the data left open are locked to their class, and Magma or Lava? is open to everyone (class-quest card)', () => {
	const classes = (id) => corrections.quests[id] && corrections.quests[id].set.classes;
	assert.deepEqual([78261, 78307].map(classes), [8, 8], 'The Horn of Xelthos: Rogue');
	assert.equal(classes(93797), 128, 'Boughs in the Wind: Mage');
	assert.deepEqual([98341, 98404, 98738].map(classes), [1024, 1024, 1024], 'the Great Windborne Cat Spirit chain: Druid');
	const lava = corrections.quests[84396].set;
	assert.ok('classes' in lava && lava.classes === null, 'Magma or Lava?: no class limit');
	assert.ok('races' in lava && lava.races === null, 'Magma or Lava?: no race limit');
	assert.deepEqual(lava.end, { npc: [5497, 7825], object: [] }, 'its enders stay');
});
