'use strict';
// data build: CSV parsing, Era map frames, zone mapping, pfQuest
// normalization, objective counts, spawn reduction, recording overlay and
// deterministic output, on small fixtures (tests/fixtures/data).

const { test, describe } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const { parseCsv } = require('../tools/lib/data/csv');
const { buildMaps, frameFromAssignment } = require('../tools/lib/data/maps');
const { parseCount, parseProgressText } = require('../tools/lib/data/objectives');
const { reduceSpawns } = require('../tools/lib/data/spawns');
const { buildData } = require('../tools/lib/data/build');
const { checkLicense } = require('../tools/lib/data/pfquest');
const { tmpdir } = require('./helpers/tmp');

const FIX = path.join(__dirname, 'fixtures', 'data');
const WAGO = path.join(FIX, 'sources', 'wago', '1.15.9.11111');
const BUILT_AT = '2026-01-01T00:00:00Z';

function fixtureTables() {
	const read = (t) => parseCsv(fs.readFileSync(path.join(WAGO, `${t}.csv`), 'utf8'));
	return { uiMap: read('UiMap'), assignment: read('UiMapAssignment'), area: read('AreaTable') };
}

// Contract formula (docs/ARCHITECTURE.md, Map frames).
function toWorld(f, x, y) {
	return { wx: f.top + ((f.bottom - f.top) * y) / 100, wy: f.left + ((f.right - f.left) * x) / 100 };
}

async function fixtureBuild(extra = {}) {
	const outDir = extra.outDir || tmpdir('polestar-data-');
	const result = await buildData({
		offline: true,
		pfquestDir: path.join(FIX, 'pfquest'),
		sourcesDir: path.join(FIX, 'sources'),
		recordingsDir: path.join(FIX, 'recordings'),
		outDir,
		builtAt: BUILT_AT,
		...extra,
	});
	const read = (name) => JSON.parse(fs.readFileSync(path.join(outDir, `${name}.json`), 'utf8'));
	return { result, outDir, read };
}

describe('csv', () => {
	test('parses quoted fields, doubled quotes, embedded newlines, CRLF and BOM', () => {
		const rows = parseCsv('\ufeffID,Name,Note\r\n1,"Hills, ""Test""","two\nlines"\r\n2,Plain,\n');
		assert.deepEqual(rows, [
			{ ID: '1', Name: 'Hills, "Test"', Note: 'two\nlines' },
			{ ID: '2', Name: 'Plain', Note: '' },
		]);
	});

	test('rejects rows whose width differs from the header', () => {
		assert.throws(() => parseCsv('A,B\n1,2,3\n'), /row 2 has 3 fields/);
		assert.throws(() => parseCsv('A,B\n"open,2\n'), /unterminated/);
	});
});

describe('map frames', () => {
	test('full-map assignment: edges follow the contract orientation', () => {
		const elwynn = fixtureTables().assignment.find((a) => a.ID === '46739');
		const f = frameFromAssignment(elwynn);
		assert.deepEqual(f, { c: 0, left: 1535.417, right: -1935.417, top: -7939.583, bottom: -10254.166 });
		// map (0,0) is the north-west corner: max world x (north), max world y (west)
		const nw = toWorld(f, 0, 0);
		const se = toWorld(f, 100, 100);
		assert.ok(nw.wx > se.wx && nw.wy > se.wy);
		// Elwynn's map is 1.5 times wider than tall, like every zone map.
		assert.ok(Math.abs((f.left - f.right) / (f.top - f.bottom) - 1.5) < 0.002);
	});

	test('UiMin/UiMax sub-rectangle is extrapolated to the whole map', () => {
		const inset = fixtureTables().assignment.find((a) => a.UiMapID === '2000');
		const f = frameFromAssignment(inset);
		assert.deepEqual(f, { c: 0, left: 875, right: -625, top: 500, bottom: -500 });
		// The region's own corners land on its UI rectangle (u 0.25-0.75, v 0.5-1).
		assert.deepEqual(toWorld(f, 25, 50), { wx: 0, wy: 500 });
		assert.deepEqual(toWorld(f, 75, 100), { wx: -500, wy: -250 });
	});

	test('zones, frame choice and AreaTable -> UiMapID mapping', () => {
		const maps = buildMaps(fixtureTables());
		assert.deepEqual(maps.zones[1429], { id: 1429, name: 'Elwynn Forest', areaId: 12, parent: 1415, type: 3 });
		assert.deepEqual(maps.zones[2000], { id: 2000, name: 'Inset, "Test"', areaId: 5000, parent: 1415, type: 3 });
		assert.equal(maps.zones[947].parent, null);
		// Azeroth spans two continents: no frame, with a warning.
		assert.equal(maps.frames[947], undefined);
		assert.ok(maps.warnings.some((w) => /uiMap 947: spans 2 continents/.test(w)));
		// Elwynn has a quarter-map assignment too; the full one is used and both agree.
		assert.equal(maps.frames[1429].bottom, -10254.166);
		assert.ok(!maps.warnings.some((w) => /1429/.test(w)));
		// Stormwind City lies inside Elwynn Forest.
		const sw = maps.frames[1453];
		const el = maps.frames[1429];
		assert.ok(sw.left <= el.left && sw.right >= el.right && sw.top <= el.top && sw.bottom >= el.bottom);
		assert.equal(maps.resolveArea(12), 1429);
		assert.equal(maps.resolveArea(87), 1429, 'subzone Goldshire walks up to Elwynn');
		assert.equal(maps.resolveArea(1519), 1453);
		assert.equal(maps.resolveArea(9999), null, 'area without a UiMap');
		assert.equal(maps.resolveArea(123456), null, 'unknown area');
	});

	test('implausible frames are rejected; square taxi maps are not', () => {
		const row = (id, system) => ({ Name_lang: `M${id}`, ID: String(id), ParentUiMapID: '0', System: String(system), Type: '2' });
		const asg = (id) => ({
			UiMin_0: '0', UiMin_1: '0', UiMax_0: '1', UiMax_1: '1',
			Region_0: '-1000', Region_1: '-1000', Region_3: '1000', Region_4: '1000',
			ID: String(id + 10), UiMapID: String(id), OrderIndex: '0', MapID: '0', AreaID: '0',
		});
		const maps = buildMaps({ uiMap: [row(1, 0), row(2, 1)], assignment: [asg(1), asg(2)], area: [] });
		assert.equal(maps.frames[1], undefined);
		assert.ok(maps.warnings.some((w) => /uiMap 1: aspect 1\.000/.test(w)));
		assert.deepEqual(maps.frames[2], { c: 0, left: 1000, right: -1000, top: 1000, bottom: -1000 });
	});
});

describe('objective counts', () => {
	const cases = [
		['Kill 10 Kobold Vermin, then return to Marshal McBride.', 'Kobold Vermin', {}, 10],
		['bring him 7 Plainstrider Feathers and 7 pieces of Plainstrider Meat.', 'Plainstrider Feather', {}, 7],
		['bring him 7 Plainstrider Feathers and 7 pieces of Plainstrider Meat.', 'Plainstrider Meat', {}, 7],
		['Bring six Golden Scale Bracers to Hank.', 'Golden Scale Bracers', {}, 6],
		['Kill 5 Mangy Wolves.', 'Mangy Wolf', {}, 5],
		['Bring 2 Idols of Strife and 5 Bone Scarabs.', 'Idol of Strife', {}, 2],
		['Kill 7 Tidehunters, 7 Warriors and 7 Coastrunners.', 'Murloc Tidehunter', { others: ['Murloc Warrior'] }, 7],
		['Kill 8 Dragonmaw Raiders and a Dragonmaw Battlemaster.', 'Dragonmaw Battlemaster', { type: 'kill' }, 1],
		['Retrieve the Warchief\'s Orders.', 'Warchief\'s Orders', { type: 'item' }, 1],
		// Not stated: stays null instead of guessing.
		['Kill Rot Hide Graverobbers and Rot Hide Mongrels.', 'Rot Hide Graverobber', { type: 'kill' }, null],
		['Use Morbent\'s Bane on Morbent Fel, kill Morbent Fel.', 'Morbent Fel', { type: 'kill' }, null],
		['Kill the Murloc Oracle.', 'Murloc Oracle', { type: 'kill' }, null],
		['Gather Lurker Venom.', 'Lurker Venom', { type: 'item' }, null],
		['Kill 10 Wolves.', 'Wolf Rider', {}, null],
	];
	for (const [text, name, opts, want] of cases) {
		test(`${name} in "${text}" -> ${want}`, () => {
			assert.equal(parseCount(text, name, opts).count, want);
		});
	}

	test('a shared trailing name part is not used as an alias', () => {
		// Both end in "Warrior": "7 Warriors" cannot be attributed to either.
		const text = 'Kill 7 Warriors.';
		assert.equal(parseCount(text, 'Murloc Warrior', { others: ['Gnoll Warrior'] }).count, null);
	});

	test('recorded objective text', () => {
		assert.deepEqual(parseProgressText('Kobold Vermin slain: 3/10'), { name: 'Kobold Vermin', slain: true, cur: 3, max: 10 });
		assert.deepEqual(parseProgressText('Sky Shard: 0/5'), { name: 'Sky Shard', slain: false, cur: 0, max: 5 });
		assert.equal(parseProgressText('Explore the ruins'), null);
	});
});

describe('spawn reduction', () => {
	const grid = [];
	for (let i = 0; i < 10; i++) for (let j = 0; j < 6; j++) grid.push([20 + i * 5, 30 + j * 5]);

	test('rounds to two decimals, drops near-duplicates and out-of-range points', () => {
		const { pts, more } = reduceSpawns([[10, 10], [10.05, 10.02], [10, 10], [70.004, 20.006], [101, 5], [-1, 5], ['x', 1]]);
		assert.deepEqual([pts, more], [[[10, 10], [70, 20.01]], []]);
	});

	test('few points are all kept', () => {
		const few = grid.slice(0, 24);
		assert.deepEqual(reduceSpawns(few, { cap: 24 }), { pts: few, more: [] });
	});

	test('many points are capped with an even spread', () => {
		const { pts } = reduceSpawns(grid, { cap: 12 });
		assert.equal(pts.length, 12);
		// Every grid point is close to some kept point (coverage)...
		const nearest = (p) => Math.min(...pts.map((q) => Math.hypot(p[0] - q[0], p[1] - q[1])));
		assert.ok(Math.max(...grid.map(nearest)) <= 10.5, 'kept points cover the whole area');
		// ...and kept points are not clustered.
		let minGap = Infinity;
		for (let a = 0; a < pts.length; a++) for (let b = a + 1; b < pts.length; b++) minGap = Math.min(minGap, Math.hypot(pts[a][0] - pts[b][0], pts[a][1] - pts[b][1]));
		assert.ok(minGap >= 10, `min gap ${minGap}`);
	});

	test('the points the cap leaves out are kept apart: no spawn is lost', () => {
		const { pts, more } = reduceSpawns(grid, { cap: 12 });
		assert.equal(more.length, grid.length - 12);
		const key = (p) => `${p[0]},${p[1]}`;
		assert.deepEqual([...pts, ...more].map(key).sort(), grid.map(key).sort(), 'pts and more together are every distinct point, each once');
		assert.deepEqual(more, more.slice().sort((a, b) => a[0] - b[0] || a[1] - b[1]), 'more is sorted by x then y');
	});

	test('result does not depend on input order', () => {
		const shuffled = grid.slice().reverse();
		assert.deepEqual(reduceSpawns(shuffled, { cap: 12 }), reduceSpawns(grid, { cap: 12 }));
	});
});

describe('fixture build', () => {
	test('normalizes quests', async () => {
		const { read } = await fixtureBuild({ recordingsDir: path.join(tmpdir('polestar-data-'), 'none') });
		const q = read('quests');
		assert.deepEqual(Object.keys(q), ['100', '101', '102', '104'], 'untitled quest 103 is skipped');
		assert.deepEqual(q[101], {
			id: 101,
			title: 'Wolf Trouble',
			level: 3,
			minLevel: 2,
			races: 77,
			classes: 1,
			start: { npc: [2], object: [], item: [] },
			end: { npc: [2], object: [] },
			pre: [100],
			excl: [102],
			next: 104,
			objectives: [
				{ type: 'kill', id: 3, count: 10, text: 'Fixture Wolf' },
				{ type: 'kill', id: 4, count: 4, text: 'Fixture Wolf Alpha' },
				{ type: 'item', id: 50, count: 3, text: 'Wolf Pelt' },
			],
			objectiveText: 'Bring 3 pieces of Wolf Pelt, and kill 10 Fixture Wolves and 4 Fixture Wolf Alphas for Alice.',
			zone: 1429,
			xp: null,
			skill: null,
			event: null,
			source: ['pfquest'],
		});
		assert.equal(q[100].races, null, 'all-races mask means unrestricted');
		assert.equal(q[100].next, null, 'two follow-ups: no single next');
		assert.equal(q[102].classes, null, 'all-classes mask means unrestricted');
		assert.equal(q[102].skill, 186);
		assert.equal(q[102].event, 12);
		assert.equal(q[102].zone, 1429, 'zone from the starting object');
		assert.deepEqual(q[102].objectives, [
			{ type: 'object', id: 500, count: null, text: 'Fixture Altar' },
			{ type: 'event', id: 7, count: null, text: null, map: 1429, f: 'e', x: 61.2, y: 52.9 },
		]);
		assert.deepEqual(q[104].start, { npc: [], object: [], item: [53] });
		assert.deepEqual(q[104].objectives, [{ type: 'item', id: 51, count: 1, text: 'Sealed Letter' }]);
	});

	test('normalizes npcs, objects and items', async () => {
		const { read, result } = await fixtureBuild({ recordingsDir: path.join(tmpdir('polestar-data-'), 'none') });
		const npcs = read('npcs');
		assert.deepEqual(npcs[1], { id: 1, name: 'Bob', level: 20, faction: 'A', roles: ['flightmaster'], spawns: { 1429: { f: 'e', pts: [[48.9, 41.6]] } } });
		assert.deepEqual(npcs[2], {
			id: 2, name: 'Alice', level: 5, levelMax: 6, rank: 1, faction: 'AH', roles: ['vendor'],
			spawns: { 1429: { f: 'e', pts: [[42.1, 65.9]] }, 1453: { f: 'e', pts: [[50, 50]] } },
		});
		assert.equal(npcs[3].spawns[1429].pts.length, 24, '60 spawns capped at the default 24');
		assert.deepEqual(npcs[4].spawns, { 1429: { f: 'e', pts: [[10, 10], [70, 20.01]] } });
		assert.deepEqual(npcs[5].spawns, {}, 'spawns in an area without a UiMap are dropped');
		assert.equal(result.meta.counts.unmappedSpawnPoints, 1);

		const objects = read('objects');
		assert.deepEqual(objects[500], { id: 500, name: 'Fixture Altar', spawns: { 1429: { f: 'e', pts: [[30.12, 40.99]] } } });
		assert.deepEqual(objects[600].roles, ['herb']);

		const items = read('items');
		assert.deepEqual(items[50], { id: 50, name: 'Wolf Pelt', drops: { npc: { 3: 45.5, 4: 80, 5: 2.5 }, object: { 600: 2.5 } }, vendors: [] });
		assert.deepEqual(items[52].vendors, [1, 2], 'vendor ids 1..n stay ids, not an array index');
		assert.deepEqual(items[53].drops, { npc: {}, object: { 500: 100 } });

		const zones = read('zones');
		assert.equal(zones[1453].name, 'Stormwind City');
		const frames = read('map-frames');
		assert.deepEqual(Object.keys(frames.era), ['1415', '1429', '1453', '2000']);
	});

	test('builds factions from the Era Faction table', async () => {
		const { read } = await fixtureBuild({ recordingsDir: path.join(tmpdir('polestar-data-'), 'none') });
		const f = read('factions');
		// Player template factions (ReputationIndex -1) are not reputations.
		assert.equal(f[1], undefined);
		assert.deepEqual(Object.keys(f), ['21', '46', '67', '69', '72', '76', '169', '469', '529', '576', '589', '609', '630', '889', '890', '891', '892', '2586']);
		// Side from the Alliance/Horde header.
		assert.deepEqual(f[72], { id: 72, name: 'Stormwind', side: 'Alliance', parent: 469, source: ['blizzard'] });
		assert.deepEqual(f[76], { id: 76, name: 'Orgrimmar', side: 'Horde', parent: 67, source: ['blizzard'] });
		assert.deepEqual(f[469], { id: 469, name: 'Alliance', side: 'Alliance', parent: null, source: ['blizzard'] });
		// Battleground factions under Alliance Forces / Horde Forces.
		assert.deepEqual(f[890], { id: 890, name: 'Silverwing Sentinels', side: 'Alliance', parent: 891, source: ['blizzard'] });
		assert.deepEqual(f[889], { id: 889, name: 'Warsong Outriders', side: 'Horde', parent: 892, source: ['blizzard'] });
		// Side from a reputation locked to Hated for the other side's races.
		assert.equal(f[589].side, 'Alliance', 'Wintersaber Trainers');
		assert.equal(f[630].side, 'Horde', 'Ravasaur Trainers');
		assert.equal(f[2586].side, 'Alliance', 'Azeroth Commerce Authority (race masks beyond the classic bits)');
		// Neutral: no header, no one-sided lock (Cenarion Circle only differs in starting standing).
		assert.equal(f[529].side, null);
		assert.equal(f[576].side, null);
		assert.equal(f[609].side, null);
		assert.deepEqual(f[21], { id: 21, name: 'Booty Bay', side: null, parent: 169, source: ['blizzard'] });
		assert.equal(f[46].name, 'Blacksmithing - Armorsmithing', 'names are trimmed');
	});

	test('recorded factions: live names, Forever-only factions, gaps filled', async () => {
		const { read, result } = await fixtureBuild();
		const f = read('factions');
		assert.deepEqual(f[529], { id: 529, name: 'The Argent Dawn', side: null, parent: null, source: ['blizzard', 'recorder'] });
		assert.deepEqual(f[2587], { id: 2587, name: 'Durotar Supply and Logistics', side: null, parent: null, source: ['recorder'] });
		// Known parent and side are kept; a recorded parent that would form a cycle is ignored.
		assert.deepEqual(f[72], { id: 72, name: 'Stormwind', side: 'Alliance', parent: 469, source: ['blizzard', 'recorder'] });
		assert.equal(f[469].parent, null);
		// Forever-only factions inherit side from their recorded header.
		assert.deepEqual(f[2700], { id: 2700, name: 'Skyborne Accord', side: 'Alliance', parent: 469, source: ['recorder'] });
		assert.deepEqual(f[2701], { id: 2701, name: 'Fixture Horde Header', side: 'Horde', parent: null, source: ['recorder'] });
		assert.deepEqual(f[2702], { id: 2702, name: 'Fixture Horde Child', side: 'Horde', parent: 2701, source: ['recorder'] });
		assert.deepEqual(f[2703], { id: 2703, name: 'Orphan', side: null, parent: null, source: ['recorder'] }, 'unknown parent dropped');
		assert.equal(f[0], undefined, 'id 0 (client "Inactive" header) ignored');
		assert.equal(result.meta.counts.recorderOnlyFactions, 5);
		assert.equal(result.meta.counts.factions, 23);
		// Keys stay in ascending id order.
		const ids = Object.keys(f).map(Number);
		assert.deepEqual(ids, ids.slice().sort((a, b) => a - b));
	});

	test('recordings override Era data and add recorder-only quests', async () => {
		const { read, result } = await fixtureBuild();
		const q = read('quests');
		const npcs = read('npcs');
		// Live positions replace Era spawns on the recorded map only.
		assert.deepEqual(npcs[1].spawns, { 1429: { f: 'l', pts: [[47.5, 40.25]] } });
		assert.deepEqual(npcs[2].spawns, { 1429: { f: 'l', pts: [[48, 41]] }, 1453: { f: 'e', pts: [[50, 50]] } });
		// Recorded title/level correct; old-style sessions (turn-in xpReward
		// only) still yield xp: both turn-ins are within quest level + 5.
		assert.equal(q[100].title, 'Fixture Calling (Forever)');
		assert.equal(q[100].level, 2);
		assert.equal(q[100].xp, 40, 'largest qualifying xpReward');
		assert.equal(q[100].xpSamples, 2);
		assert.deepEqual(q[100].source, ['pfquest', 'recorder', 'recorder:xp-turnin']);
		// Recorded objective: count and client index (oi 1) win.
		assert.deepEqual(q[101].objectives, [
			{ type: 'kill', id: 3, count: 12, text: 'Fixture Wolf' },
			{ type: 'kill', id: 4, count: 4, text: 'Fixture Wolf Alpha' },
			{ type: 'item', id: 50, count: 3, text: 'Wolf Pelt' },
		]);
		// A quest and npcs that only the recorder saw.
		assert.deepEqual(q[9001], {
			id: 9001, title: 'Skyborne Welcome', level: 1, minLevel: null, races: null, classes: null,
			start: { npc: [70001], object: [], item: [] }, end: { npc: [70001], object: [] },
			pre: [], excl: [], next: null,
			objectives: [{ type: 'item', id: 80001, count: 5, text: 'Sky Shard' }],
			objectiveText: null, zone: 2500, xp: 100, xpSamples: 1, skill: null, event: null, source: ['recorder', 'recorder:xp-turnin'],
		});
		assert.deepEqual(npcs[70001], { id: 70001, name: 'Sky Warden', level: null, faction: null, spawns: { 2500: { f: 'l', pts: [[50, 50]] } } });
		assert.deepEqual(Object.keys(npcs[70002]), ['id', 'name', 'level', 'faction', 'roles', 'spawns']);
		assert.deepEqual(npcs[70002].roles, ['trainer']);
		// Object givers/enders: live object spawns, xp from the turn-in.
		assert.deepEqual(read('objects')[500].spawns, { 1429: { f: 'l', pts: [[31.5, 41.25]] } });
		assert.equal(q[102].xp, 300);
		assert.deepEqual(q[102].start.object, [500]);
		// Looted items unknown to pfQuest get an entry with the recorded name.
		assert.deepEqual(read('items')[80001], { id: 80001, name: 'Sky Shard', drops: { npc: {}, object: {} }, vendors: [] });
		// A Forever-only map from the recording joins zones.json.
		assert.deepEqual(read('zones')[2500], { id: 2500, name: 'Skyreach', areaId: null, parent: 1415, type: 3 });
		assert.equal(result.meta.counts.recorderOnlyQuests, 5);
		assert.equal(result.meta.counts.recordings, 4);
	});

	test('quest xp is the full reward, never an out-levelled one', async () => {
		const { read } = await fixtureBuild();
		const q = read('quests');
		const xp = (id) => ({ xp: q[id].xp, xpSamples: q[id].xpSamples, source: q[id].source });
		// Level 18 on a level 10 quest is reduced, even though it is larger here.
		assert.deepEqual(xp(9101), { xp: 800, xpSamples: 1, source: ['recorder', 'recorder:xp-turnin'] });
		// Only out-levelled observations: no xp at all rather than a reduced one.
		assert.deepEqual(xp(9102), { xp: null, xpSamples: undefined, source: ['recorder'] });
		assert.equal('xpSamples' in q[9102], false);
		// rewardXpBase from the quest log wins over everything, whatever the level.
		assert.deepEqual(xp(9103), { xp: 820, xpSamples: 1, source: ['recorder', 'recorder:xp-base'] });
		// A later `reward` event (reward not cached at accept) is used.
		assert.deepEqual(xp(9104), { xp: 760, xpSamples: 1, source: ['recorder', 'recorder:xp-log'] });
		// Field order stays canonical with xpSamples right after xp.
		assert.deepEqual(Object.keys(q[9101]).slice(14, 17), ['xp', 'xpSamples', 'skill']);
	});

	test('meta records sources, licenses and counts', async () => {
		const { read } = await fixtureBuild();
		const meta = read('meta');
		assert.equal(meta.builtAt, '2026-01-01T00:00:00.000Z');
		const pf = meta.sources.find((s) => s.name === 'pfQuest');
		assert.equal(pf.license, 'MIT');
		assert.equal(pf.copyright, 'Copyright (c) 2020 Fixture Author');
		assert.match(pf.notice, /^MIT License/);
		assert.match(meta.sources[1].revision, /wow_classic_era 1\.15\.9\.11111/);
		assert.equal(meta.counts.quests, 9);
		assert.equal(meta.counts.npcs, 7);
		assert.equal(meta.counts.objects, 2);
		assert.equal(meta.counts.items, 5, 'four pfQuest items plus one recorded loot');
		assert.equal(meta.counts.mapFrames, 4);
	});

	test('meta names a source cache with forward slashes on every system, as LICENSE-DATA.txt shows it', async () => {
		const root = tmpdir('polestar-data-');
		const sourcesDir = path.join(root, 'data', 'sources');
		fs.cpSync(path.join(FIX, 'sources'), sourcesDir, { recursive: true });
		fs.mkdirSync(path.join(sourcesDir, 'webxp'));
		fs.writeFileSync(path.join(sourcesDir, 'webxp', 'quest-xp.json'), JSON.stringify({ 101: { wft: 450, fc: null } }));
		const { read } = await fixtureBuild({ root, sourcesDir, webXp: true });
		const xp = read('meta').sources.find((s) => s.name.startsWith('Quest XP'));
		assert.equal(xp.revision, '1 quests; cache data/sources/webxp/quest-xp.json');
	});

	test('output is byte-for-byte deterministic', async () => {
		const a = await fixtureBuild();
		const b = await fixtureBuild();
		for (const f of fs.readdirSync(a.outDir).sort()) {
			assert.equal(fs.readFileSync(path.join(a.outDir, f), 'utf8'), fs.readFileSync(path.join(b.outDir, f), 'utf8'), f);
		}
		assert.deepEqual(fs.readdirSync(a.outDir).sort(), ['factions.json', 'instances.json', 'items.json', 'map-frames.json', 'meta.json', 'npcs.json', 'objects.json', 'quests.json', 'zones.json']);
	});

	test('refuses a pfQuest checkout that is not MIT licensed', () => {
		const dir = tmpdir('polestar-data-');
		fs.writeFileSync(path.join(dir, 'LICENSE'), 'All rights reserved.\n');
		assert.throws(() => checkLicense(dir), /not the MIT license/);
		assert.equal(checkLicense(path.join(FIX, 'pfquest')).license, 'MIT');
	});
});

describe('wago.tools cache', () => {
	function fakeFetch(calls) {
		return async (url) => {
			calls.push(url);
			let body;
			if (url === 'https://wago.tools/api/builds') {
				body = JSON.stringify({ wow_classic_era: [{ version: '1.15.9.11111' }, { version: '1.15.10.2' }, { version: '1.15.9.99999' }], wow: [{ version: '12.0.0.1' }] });
			} else {
				const m = /db2\/(\w+)\/csv\?build=1\.15\.10\.2$/.exec(url);
				if (!m) return { ok: false, status: 404, text: async () => '' };
				body = fs.readFileSync(path.join(WAGO, `${m[1]}.csv`), 'utf8');
			}
			return { ok: true, status: 200, text: async () => body };
		};
	}

	test('fetches the newest Classic Era build once, then works offline from the cache', async () => {
		const sourcesDir = tmpdir('polestar-data-');
		const calls = [];
		const online = await fixtureBuild({ offline: false, sourcesDir, fetchImpl: fakeFetch(calls) });
		assert.match(online.result.meta.sources[1].revision, /1\.15\.10\.2$/);
		assert.deepEqual(fs.readdirSync(path.join(sourcesDir, 'wago', '1.15.10.2')).sort(), ['AreaTable.csv', 'Faction.csv', 'UiMap.csv', 'UiMapAssignment.csv']);
		assert.equal(calls.filter((u) => u.startsWith('https://wago.tools/')).length, 5);
		assert.match(online.result.meta.warnings.join('\n'), /classic-db spawn heights unavailable \(GET https:\/\/raw\.githubusercontent\.com\/cmangos\/classic-db\/.*HTTP 404\)/, 'the dump it cannot fetch is a warning');

		const offlineCalls = [];
		const offline = await fixtureBuild({ offline: true, sourcesDir, fetchImpl: fakeFetch(offlineCalls) });
		assert.equal(offlineCalls.length, 0, '--offline makes no requests');
		assert.equal(offline.read('map-frames').era[1429].left, 1535.417);
	});

	test('--offline without a cache fails clearly', async () => {
		await assert.rejects(fixtureBuild({ offline: true, sourcesDir: tmpdir('polestar-data-') }), /--offline: no cached wago\.tools build/);
	});
});
