'use strict';
// The danger-at-the-spot gate's rules and its check against the reviewed baseline (tools/lib/danger.js, #1575), on
// made-up mobs and a made-up recordings archive: no reference data needed. The gate itself runs on the release
// candidate (tools/danger-gate.js, gate 10).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { flagGoal, flagGrind, compare, threatTo, readCensus, GATE_MARGIN, CENSUS_MIN, KINDS } = require('../tools/lib/danger');

const npcs = {
	1: { name: 'Cave Yeti', level: 30, levelMax: 31, spawns: { 1424: { pts: [[1, 1], [2, 2]] } } },
	2: { name: 'Giant Yeti', level: 33, levelMax: 34, spawns: { 1424: { pts: [[3, 3], [4, 4]] } } },
	3: { name: 'Frostmaw', level: 37, rank: 4, spawns: {} },
	4: { name: 'Halikor', level: 12, rank: 1, spawns: {} },
	5: { name: 'Syndicate Footpad', level: 32, levelMax: 33, spawns: {} },
};
const kinds = (flags) => flags.map((f) => f.kind).sort();

test('a collect whose tour reaches droppers 4+ over while ones at your level drop it too is flagged mixed (#1695)', () => {
	const goal = { t: 'collect', quest: 552, oi: 1, fromNpcs: [{ npc: 1 }, { npc: 2 }], spots: [{ x: 1, y: 1 }, { x: 3, y: 3 }] };
	assert.deepEqual(kinds(flagGoal({ goal, level: 29.4, near: [], npcs })), ['mixed']);
	// Pinned to the caverns (one target, no tour): nothing.
	assert.deepEqual(flagGoal({ goal: { ...goal, fromNpcs: [{ npc: 1 }], spots: [] }, level: 29.4, near: [], npcs }), []);
});

test('mobs over the level around a goal, an elite, a rare and a pack are flagged; a group goal is not flagged for its elite', () => {
	const goal = { t: 'use', quest: 553, oi: 3 };
	const near = [{ id: 2, count: 4, dmin: 5 }, { id: 3, count: 1, dmin: 30 }, { id: 5, count: 3, dmin: 20 }];
	assert.deepEqual(kinds(flagGoal({ goal, level: 30.2, near, npcs })), ['over', 'pack', 'rare']);
	const elite = { t: 'collect', quest: 1498, oi: 1, fromNpcs: [] };
	assert.deepEqual(kinds(flagGoal({ goal: elite, level: 11.7, near: [{ id: 4, count: 3, dmin: 10 }], npcs })), ['elite']);
	assert.deepEqual(flagGoal({ goal: elite, level: 11.7, near: [{ id: 4, count: 3, dmin: 10 }], npcs, group: true }), []);
	// A kill of its own mob more than 3 over.
	assert.deepEqual(kinds(flagGoal({ goal: { t: 'kill', quest: 1, oi: 1, npc: 2 }, level: 29.5, near: [], npcs })), ['target']);
});

// #2207: Tanaris's Dunemaul Compound step grinds to 47 (6%) on Dunemaul Brutes (46-48), from 46 (11%) where the
// reporter stood after the step's kills; Warlocks (47-48), Enforcers and Ogre Mages (46-47) and Ogres (45-46) share it.
const dunemaul = {
	5471: { name: 'Dunemaul Ogre', level: 45, levelMax: 46 },
	5472: { name: 'Dunemaul Enforcer', level: 46, levelMax: 47 },
	5473: { name: 'Dunemaul Ogre Mage', level: 46, levelMax: 47 },
	5474: { name: 'Dunemaul Brute', level: 46, levelMax: 48 },
	5475: { name: 'Dunemaul Warlock', level: 47, levelMax: 48 },
};
const compound = [{ id: 5474, count: 9, dmin: 3 }, { id: 5472, count: 8, dmin: 5 }, { id: 5475, count: 6, dmin: 8 }, { id: 5473, count: 3, dmin: 12 }, { id: 5471, count: 4, dmin: 20 }];

test('a grind on a camp whose mobs stand 2+ levels over the player when it starts is flagged grind and fails the gate (#2207)', () => {
	const goal = { t: 'level', level: 47, frac: 0.06, grind: 5474 };
	const [flag, ...more] = flagGrind({ goal, start: 46.11, end: 47.06, near: compound, npcs: dunemaul });
	assert.equal(more.length, 0);
	assert.equal(flag.kind, 'grind');
	assert.deepEqual(flag.mobs, ['Dunemaul Brute 46-48 x9 (the grind mob)', 'Dunemaul Warlock 47-48 x6']);
	// 48s at level 46 for the 0.89 of a level from 46.11 to 47: past the margin, so a new flag fails the gate.
	assert.equal(+flag.margin.toFixed(2), 0.89);
	assert.deepEqual(compare([{ key: 'tanaris|level 47.06 grind 5474|grind', margin: flag.margin }], []).fail.length, 1);
	// Started late in 46, the grind spends a tenth of a level on 48s: borderline. From 47 the camp is one over: nothing.
	assert.ok(flagGrind({ goal, start: 46.9, end: 47.06, near: compound, npcs: dunemaul })[0].margin < GATE_MARGIN);
	assert.deepEqual(flagGrind({ goal, start: 47.0, end: 47.06, near: compound, npcs: dunemaul }), []);
	// Each share of a level ground three over counts twice: half a level at 45, then all of 46. A top-up of a hundredth
	// of a level on mobs three over stays borderline; a goal the route already reached is no grind.
	assert.equal(+flagGrind({ goal, start: 45.5, end: 47.06, near: compound, npcs: dunemaul })[0].margin.toFixed(2), 2);
	assert.ok(flagGrind({ goal, start: 45.99, end: 46, near: compound, npcs: dunemaul })[0].margin < GATE_MARGIN);
	assert.deepEqual(flagGrind({ goal, start: 47.2, end: 47.06, near: compound, npcs: dunemaul }), []);
});

test('a grind without a named mob is judged by its camp\'s spawn-weighted middle level, elites and rares apart', () => {
	const goal = { t: 'level', level: 47 };
	// The compound's middle spawn is a 47 (Enforcers, Ogre Mages): one over at 46, no flag.
	assert.deepEqual(flagGrind({ goal, start: 46.11, end: 47, near: compound, npcs: dunemaul }), []);
	// Brutes and Warlocks only: 48s, two over.
	const high = compound.filter((m) => m.id === 5474 || m.id === 5475);
	assert.deepEqual(flagGrind({ goal, start: 46.11, end: 47, near: high, npcs: dunemaul })[0].mobs, ['Dunemaul Brute 46-48 x9', 'Dunemaul Warlock 47-48 x6']);
	// A lone spawn is no camp.
	assert.deepEqual(flagGrind({ goal, start: 46.11, end: 47, near: [{ id: 5474, count: 1, dmin: 3 }], npcs: dunemaul }), []);
});

test('compare fails a new flag past the margin, lists a borderline one and baseline rows no longer flagged', () => {
	const flags = [
		{ key: 'a|kill 1.1|target', margin: 2 },
		{ key: 'b|use 2.1|over', margin: GATE_MARGIN / 2 },
		{ key: 'c|collect 3.1|elite', margin: 4 },
	];
	const baseline = [{ key: 'c|collect 3.1|elite' }, { key: 'd|kill 4.1|pack' }];
	const r = compare(flags, baseline);
	assert.deepEqual(r.fail.map((f) => f.key), ['a|kill 1.1|target']);
	assert.deepEqual(r.borderline.map((f) => f.key), ['b|use 2.1|over']);
	assert.deepEqual(r.stale.map((f) => f.key), ['d|kill 4.1|pack']);
});

// A recordings archive of made-up sessions: map 1's percent is 10 yd (world x = 10 * map x).
function archive(t, sessions, exclude = []) {
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'danger-census-'));
	t.after(() => fs.rmSync(dir, { recursive: true, force: true }));
	fs.writeFileSync(path.join(dir, 'config.json'), JSON.stringify({ exclude }));
	sessions.forEach((s, i) => fs.writeFileSync(path.join(dir, `s${String(i).padStart(3, '0')}.json`), JSON.stringify({ schema: 2, ...s })));
	return dir;
}
const world = (map, x, y) => ({ c: map, x: x * 10, y: y * 10 });
const unit = (npc, react, x = 50, y = 50) => ({ e: 'unit', npc, react, map: 1, x, y });
const mobs = {
	11: { id: 11, name: 'Pack Mule', level: 60 },
	12: { id: 12, name: 'Territorial Terran', level: 60 },
	13: { id: 13, name: 'Snapjaw', level: 30, rank: 4 },
	14: { id: 14, name: 'Lone Sentinel', level: 60 },
	15: { id: 15, name: 'Kirin Tor Guard', level: 55, faction: 'A' },
	16: { id: 16, name: 'Dermot', level: 33 },
	17: { id: 17, name: 'Calvin Montague', level: 5, faction: 'AH' },
	18: { id: 18, name: 'Highperch Soarer', level: 29 },
	20: { id: 20, name: 'Restless Spirit', level: 23 },
};

test('the census settles who is a threat: met friendly, never met where CENSUS_MIN people passed, met hostile or killing one; else the data', (t) => {
	// CENSUS_MIN Horde players pass the den (one of them twice, under one cohort) and meet only its Restless Spirits;
	// Alliance players meet the Pack Mule as friendly, a Kirin Tor Guard as hostile and Dermot as neutral; Calvin Montague
	// kills a Horde player; a Soarer no census logged is killed by the den; a flight's sightings over the lone spot and
	// an excluded contributor's session (the Terran as friendly) do not count.
	const cohort = 'aaaaaaaaaaaaaaaa';
	const passers = Array.from({ length: CENSUS_MIN }, (_, i) => ({ contributor: `h${i}`, cohort: i === 0 ? cohort : undefined, char: { faction: 'Horde' }, events: [unit(20, 'hostile')] }));
	const dir = archive(t, [
		...passers,
		{ contributor: 'h-alt', cohort, char: { faction: 'Horde' }, events: [unit(20, 'hostile')] },
		{ contributor: 'a1', char: { faction: 'Alliance' }, events: [unit(11, 'friendly', 70, 70), unit(15, 'hostile', 70, 70), unit(16, 'neutral', 70, 70)] },
		{ contributor: 'a2', char: { faction: 'Alliance' }, events: [unit(20, 'hostile', 90, 90), unit(20, 'hostile', 91, 91)] },
		{ contributor: 'h-dead', char: { faction: 'Horde' }, events: [{ e: 'death', killer: 17, map: 1, x: 20, y: 20 }] },
		{ contributor: 'h-kill', char: { faction: 'Horde' }, events: [{ e: 'kill', npc: 18, map: 1, x: 50, y: 50 }] },
		{ contributor: 'h-fly', char: { faction: 'Horde' }, events: [{ e: 'taxi' }, unit(20, 'hostile', 90, 90), { e: 'land' }] },
		{ contributor: 'bad', char: { faction: 'Horde' }, events: [unit(12, 'friendly')] },
	], ['bad']);
	const den = [{ c: 1, x: 505, y: 500 }];
	const census = readCensus(dir, { world, targets: new Map([[12, den], [13, den], [18, den], [14, [{ c: 1, x: 900, y: 900 }]]]) });
	assert.equal(census.sessions, CENSUS_MIN + 6);
	assert.equal(census.near.get(12), CENSUS_MIN, 'one cohort is one person; the excluded session is left out');
	assert.equal(census.near.get(14), 1, 'a flight saw from high above');
	const threat = (id, side) => threatTo(mobs[id], side, census);
	// Met as friendly by the Alliance: no threat to it; the Horde never met it, so the data (no side) decides.
	assert.equal(threat(11, 'A'), false);
	assert.equal(threat(11, 'H'), true);
	// Never met by anyone though CENSUS_MIN people's census ran by its spawns: not there, for either side.
	assert.equal(threat(12, 'A'), false);
	assert.equal(threat(12, 'H'), false);
	// A rare never met is still counted (seldom up), and so is a template too few people passed, or one killed where no
	// census logged it.
	assert.equal(threat(13, 'H'), true);
	assert.equal(threat(14, 'H'), true);
	assert.equal(threat(18, 'H'), true);
	// Met as hostile, or killing one of the side's players, is a threat even where the data has it friendly.
	assert.equal(threatTo(mobs[15], 'A'), false);
	assert.equal(threat(15, 'A'), true);
	assert.equal(threatTo(mobs[17], 'H'), false);
	assert.equal(threat(17, 'H'), true);
	// Met only as neutral: the data decides (players fight neutral mobs; quest targets are neutral until attacked).
	assert.equal(threat(16, 'A'), true);
});

test('a level-60 template players meet as friendly, or never meet, raises no flag at a level-20 goal; without the census it does', (t) => {
	const passers = Array.from({ length: CENSUS_MIN }, (_, i) => ({ contributor: `p${i}`, char: { faction: 'Alliance' }, events: [unit(20, 'hostile'), unit(11, 'friendly')] }));
	const census = readCensus(archive(t, passers), { world, targets: new Map([[12, [{ c: 1, x: 510, y: 500 }]]]) });
	const goal = { t: 'collect', quest: 98396, oi: 3, fromNpcs: [] };
	const near = [{ id: 11, count: 6, dmin: 10 }, { id: 12, count: 12, dmin: 15 }];
	const keep = (c) => near.filter((m) => threatTo(mobs[m.id], 'A', c));
	assert.deepEqual(kinds(flagGoal({ goal, level: 20.6, near: keep(null), npcs: mobs, side: 'A' })), ['over', 'pack']);
	assert.deepEqual(flagGoal({ goal, level: 20.6, near: keep(census), npcs: mobs, side: 'A' }), []);
});

test('the committed baseline: every row is a known kind with its guide, goal, reason and evidence, keys unique', () => {
	const file = path.join(__dirname, '..', 'data', 'danger-baseline.json');
	const { flags } = JSON.parse(fs.readFileSync(file, 'utf8'));
	assert.ok(flags.length > 0);
	const keys = new Set();
	for (const r of flags) {
		assert.ok(!keys.has(r.key), `${r.key}: listed once`);
		keys.add(r.key);
		assert.ok(KINDS.includes(r.kind), `${r.key}: kind ${r.kind}`);
		assert.equal(r.key, `${r.guide}|${r.goal}|${r.kind}`, `${r.key}: key is guide|goal|kind`);
		assert.ok(r.reason && r.reason.length > 10, `${r.key}: a reason`);
		assert.ok(r.evidence && r.evidence.length > 5, `${r.key}: evidence`);
	}
});
