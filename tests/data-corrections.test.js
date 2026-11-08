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
});

test('The State of the Mines waits for both Testing the Wells and Murloc Gills (dungeon pre-quest sweep)', () => {
	const { all, any } = blockingPrereqs({ id: 92745, start: { npc: [253092] }, ...corrections.quests[92745].set });
	assert.deepEqual({ all, any }, { all: [92742, 92744], any: [] });
});

test('the Moonsilver Blade chain before Old Fire-Eye is taken in order (dungeon pre-quest sweep)', () => {
	const chain = [[95036, 259620, 95034], [95111, 248840, 95036], [95125, 3539, 95111], [95126, 3539, 95125]];
	for (const [id, npc, pre] of chain) {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		assert.deepEqual(blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set }), { all: [], any: [pre] }, `${id} after ${pre}`);
	}
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

// Bennistrov (#1354): Highlord Bolvar Fordragon's A Friend of the Family (98191) is offered only once Captain
// Stoutfist's (98190) is handed in to him. Without the prerequisite the guide still sent a player who had skipped
// 98190 to Bolvar for 98191. The follow-up sweep (players' recordings: taken only after the quest before, refused
// before it; a second source agreeing) found the same gap in these chains.
test('Follow-ups wait for the quest before them, so a skipped one takes its follow-up with it (#1354 sweep)', () => {
	const blocks = (id, npc) => {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		return blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set });
	};
	for (const [id, npc, any, who] of [
		[98191, 1748, [98190], 'Highlord Bolvar Fordragon, Stormwind (#1354)'],
		[98394, 11802, [98393], 'Dendrite Starblaze, Moonglade (Druid cat form)'],
		[98396, 11957, [98394], 'the Great Cat Spirit'],
		[98731, 11957, [98396], 'the Great Cat Spirit'],
		[98397, 11802, [98731, 98738], 'Dendrite Starblaze: either blessing'],
		[78089, 3663, [78088], 'Delgren the Purifier (Paladin cloak)'],
		[78090, 5492, [78089], 'Katherine the Pure'],
		[78092, 5495, [78091], 'Ursula Deline'],
		[91859, 248840, [91858], 'Trevan Rol (Lumina Windsinger chain)'],
		[91860, 259611, [91859], 'Deathguard Baldren'],
		[96204, 248755, [91862], 'Lumina Windsinger'],
		[95034, 259620, [96204], 'Lumina Windsinger'],
		[96264, 259023, [94789], 'Veyric Thunderhame (Shaman Call of Air)'],
		[92519, 12920, [97539], 'Doctor Gregory Victor, Hammerfall'],
		[92457, 269127, [92432], 'Image of Archmage Modera (Kirin Tor)'],
	]) assert.deepEqual(blocks(id, npc), { all: [], any }, who);
	const fenris = corrections.quests[91861];
	assert.ok(fenris, 'a correction for 91861');
	assert.deepEqual(blockingPrereqs({ id: 91861, start: { object: [566037] }, ...fenris.set }), { all: [], any: [91860] }, 'the Charred Remains');
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

test('The Glowing Shard\'s one line is to speak with Sputtervalve in Ratchet, so its hand-in guide goes there first (#1326)', () => {
	assert.deepEqual(corrections.quests[6981].set.objectives, [{ type: 'talk', id: 3442, count: 1, text: 'Speak with someone in Ratchet about the Glowing Shard' }]);
});

test('dungeon turn-in NPCs the data placed nowhere stand where players hand in to them (#1326 sweep)', () => {
	assert.deepEqual(corrections.npcs[13155].set.spawns, { 1437: { f: 'e', pts: [[51.41, 59.23]] } }, 'Deathstalker Agent: Dragonmaw Rumors and Open the Maw, Wetlands');
	assert.deepEqual(corrections.npcs[15991].set.spawns, { 1453: { f: 'e', pts: [[68.15, 29], [70.18, 29.86]] } }, 'Lady Dena Kennedy: Crest of Lordaeron, Stormwind City');
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
