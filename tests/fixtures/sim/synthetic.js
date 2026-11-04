'use strict';
// A small invented world for the simulator tests: two adjacent 1000-yard
// zones on one continent, a few quest givers, mob camps, a drop, a chain, an
// exclusive pair, a breadcrumb across zones and a class quest. Ids, names and
// numbers are made up.

const fs = require('node:fs');
const path = require('node:path');

const VALE = 99101;
const FIELD = 99102;

function camp(map, cx, cy, n) {
	const pts = [];
	for (let i = 0; i < n; i++) pts.push([cx + (i % 4) * 1.5, cy + Math.floor(i / 4) * 1.5]);
	return { [map]: { f: 'e', pts } };
}

function makeData() {
	const zones = {
		[VALE]: { id: VALE, name: 'Testvale', areaId: null, parent: null, type: 3 },
		[FIELD]: { id: FIELD, name: 'Farfield', areaId: null, parent: null, type: 3 },
	};
	const frames = { era: {
		[VALE]: { c: 1, left: 0, right: -1000, top: 1000, bottom: 0 },
		[FIELD]: { c: 1, left: -1000, right: -2000, top: 1000, bottom: 0 },
	} };
	const npcs = {
		1: { id: 1, name: 'Elder Testa', level: 10, faction: 'AH', spawns: { [VALE]: { f: 'e', pts: [[50, 50]] } } },
		2: { id: 2, name: 'Warden Fieldy', level: 10, faction: 'AH', spawns: { [FIELD]: { f: 'e', pts: [[50, 50]] } } },
		10: { id: 10, name: 'Burrow Rat', level: 2, faction: null, spawns: camp(VALE, 20, 20, 12) },
		11: { id: 11, name: 'Pelt Fox', level: 4, faction: null, spawns: camp(VALE, 75, 75, 12) },
		12: { id: 12, name: 'Field Boar', level: 7, faction: null, spawns: camp(FIELD, 30, 30, 12) },
		13: { id: 13, name: 'Deep Boar', level: 9, faction: null, spawns: camp(FIELD, 70, 70, 12) },
	};
	const items = {
		100: { id: 100, name: 'Fox Pelt', drops: { npc: { 11: 50 }, object: {} }, vendors: [] },
	};
	const q = (id, title, level, minLevel, extra) => ({
		id, title, level, minLevel, races: null, classes: null,
		start: { npc: [1], object: [], item: [] }, end: { npc: [1], object: [] },
		pre: [], excl: [], next: null, objectives: [], objectiveText: '', zone: VALE, xp: null, skill: null, event: null, source: ['test'],
		...extra,
	});
	const quests = {
		501: q(501, 'Rat Trouble', 2, 1, { objectives: [{ type: 'kill', id: 10, count: 8 }] }),
		502: q(502, 'Fox Pelts', 4, 2, { objectives: [{ type: 'item', id: 100, count: 5 }] }),
		503: q(503, 'Word to the Warden', 4, 1, { end: { npc: [2], object: [] } }),
		504: q(504, 'Field Boars', 7, 5, { start: { npc: [2], object: [], item: [] }, end: { npc: [2], object: [] }, objectives: [{ type: 'kill', id: 12, count: 10 }], zone: FIELD }),
		505: q(505, 'Deep Boars', 9, 7, { start: { npc: [2], object: [], item: [] }, end: { npc: [2], object: [] }, objectives: [{ type: 'kill', id: 13, count: 10 }], pre: [504], zone: FIELD }),
		506: q(506, 'Choice One', 3, 1, { objectives: [{ type: 'kill', id: 10, count: 4 }], excl: [507] }),
		507: q(507, 'Choice Two', 3, 1, { objectives: [{ type: 'kill', id: 10, count: 4 }], excl: [506] }),
		508: q(508, 'Mage Lesson', 3, 1, { classes: 128, objectives: [{ type: 'kill', id: 10, count: 2 }] }),
	};
	const travel = { schema: 1, taxi: { nodes: [], legs: [] }, transports: [], inns: [], paths: { nodes: [], edges: [] } };
	return { quests, npcs, objects: {}, items, zones, 'map-frames': frames, travel, trainers: {}, dungeons: dungeonsDoc() };
}

// Invented QuestXP rows: [tier0..tier9] per level.
function questXpRows() {
	const rows = [];
	for (let l = 1; l <= 70; l++) rows[l] = [0, 10 * l, 20 * l, 40 * l, 60 * l, 80 * l, 100 * l, 120 * l, 0, 0];
	return rows;
}

function questXpCsv() {
	const lines = ['ID,Difficulty_0,Difficulty_1,Difficulty_2,Difficulty_3,Difficulty_4,Difficulty_5,Difficulty_6,Difficulty_7,Difficulty_8,Difficulty_9'];
	const rows = questXpRows();
	for (let l = 1; l < rows.length; l++) lines.push([l, ...rows[l]].join(','));
	return `${lines.join('\n')}\n`;
}

// Write the data set as a data/forever-like folder plus a sources folder with
// the QuestXP cache: { dataDir, sourcesDir, simDir }.
function writeDataDir(root) {
	const data = makeData();
	const dataDir = path.join(root, 'forever');
	fs.mkdirSync(dataDir, { recursive: true });
	for (const [k, v] of Object.entries(data)) fs.writeFileSync(path.join(dataDir, `${k}.json`), JSON.stringify(v));
	fs.writeFileSync(path.join(dataDir, 'meta.json'), JSON.stringify({ builtAt: 'test' }));
	const sourcesDir = path.join(root, 'sources');
	const qx = path.join(sourcesDir, 'wago', '1.15.9.70003');
	fs.mkdirSync(qx, { recursive: true });
	fs.writeFileSync(path.join(qx, 'QuestXP.csv'), questXpCsv());
	return { dataDir, sourcesDir, simDir: path.join(root, 'sim') };
}

const START = { Orc: { quest: 501, zone: 'Testvale' } };

// Route-rule additions (docs/legacy/SIMULATION-js.md "Starts", travel safety), kept
// out of the base world so its exhaustive search test stays small:
//   - Zephras Isle (map 2521, its own continent) with a level-1 quest: the
//     Skyborne start; its exit is the one-way Horde airship;
//   - Farcoast, another continent (zeppelin from Testvale), a level-3 quest;
//   - Highcrag, a level-30 zone beyond Farfield, and Beyondvale past it with
//     a level-8 quest: walking Farfield -> Beyondvale crosses Highcrag.
const ISLE = 2521;
const FARCOAST = 99103;
const HIGHCRAG = 99104;
const BEYOND = 99105;

function makeRulesData() {
	const d = makeData();
	Object.assign(d.zones, {
		[ISLE]: { id: ISLE, name: 'Zephras Isle', areaId: null, parent: null, type: 3 },
		[FARCOAST]: { id: FARCOAST, name: 'Farcoast', areaId: null, parent: null, type: 3 },
		[HIGHCRAG]: { id: HIGHCRAG, name: 'Highcrag', areaId: null, parent: null, type: 3 },
		[BEYOND]: { id: BEYOND, name: 'Beyondvale', areaId: null, parent: null, type: 3 },
	});
	Object.assign(d['map-frames'].era, {
		[ISLE]: { c: 7, left: 0, right: -1000, top: 1000, bottom: 0 },
		[FARCOAST]: { c: 0, left: 0, right: -1000, top: 1000, bottom: 0 },
		[HIGHCRAG]: { c: 1, left: -2000, right: -3000, top: 1000, bottom: 0 },
		[BEYOND]: { c: 1, left: -3000, right: -4000, top: 1000, bottom: 0 },
	});
	const crag = [];
	for (let x = 5; x <= 95; x += 9) for (let y = 5; y <= 95; y += 9) crag.push([x, y]);
	Object.assign(d.npcs, {
		3: { id: 3, name: 'Skyguide Aira', level: 10, faction: 'AH', spawns: { [ISLE]: { f: 'e', pts: [[50, 50]] } } },
		4: { id: 4, name: 'Captain Coast', level: 10, faction: 'AH', spawns: { [FARCOAST]: { f: 'e', pts: [[50, 50]] } } },
		5: { id: 5, name: 'Ranger Beyond', level: 10, faction: 'AH', spawns: { [BEYOND]: { f: 'e', pts: [[50, 50]] } } },
		14: { id: 14, name: 'Isle Crab', level: 2, faction: null, spawns: camp(ISLE, 30, 30, 12) },
		15: { id: 15, name: 'Coast Crab', level: 3, faction: null, spawns: camp(FARCOAST, 30, 30, 12) },
		16: { id: 16, name: 'Crag Giant', level: 30, faction: null, spawns: { [HIGHCRAG]: { f: 'e', pts: crag } } },
		17: { id: 17, name: 'Beyond Wolf', level: 8, faction: null, spawns: camp(BEYOND, 30, 30, 12) },
	});
	const at = (npc, zone, mob, level, minLevel) => ({
		start: { npc: [npc], object: [], item: [] }, end: { npc: [npc], object: [] }, objectives: [{ type: 'kill', id: mob, count: 6 }], zone,
		id: null, level, minLevel,
	});
	const base = d.quests[501];
	const add = (id, title, x) => {
		d.quests[id] = { ...base, ...x, id, title };
	};
	add(701, 'Isle Crabs', at(3, ISLE, 14, 1, 1));
	add(702, 'Coast Crabs', at(4, FARCOAST, 15, 3, 1));
	add(703, 'Beyond Wolves', at(5, BEYOND, 17, 8, 4));
	d.travel.transports.push({
		id: 'zeppelin-test', kind: 'zeppelin', faction: 2,
		a: { name: 'Testvale tower', c: 1, wx: 900, wy: -100, map: VALE },
		b: { name: 'Farcoast tower', c: 0, wx: 900, wy: -100, map: FARCOAST },
		ab: 60, ba: 60, waitA: 30, waitB: 30,
	});
	return d;
}

const RULES_START = { ...START, Skyborne: { quest: 701, zone: 'Zephras Isle' } };

module.exports = { makeData, makeRulesData, questXpRows, questXpCsv, writeDataDir, START, RULES_START, VALE, FIELD, ISLE, FARCOAST, HIGHCRAG, BEYOND };

// An invented dungeon: entrance in Farfield, one quest whose objective is
// inside (given by the warden, turned in inside), one boss.
function dungeonsDoc() {
	return {
		source: { name: 'test' },
		dungeons: [{
			key: 'test-hollow', name: 'Test Hollow', levels: { min: 6, max: 10 }, zone: FIELD, zoneName: 'Farfield',
			entrance: { map: FIELD, x: 90, y: 90, f: 'e' }, factions: ['Alliance', 'Horde'],
			bosses: [{ name: 'Hollow King', npc: null, level: 10, rare: false, loot: [] }],
			quests: [{ id: 601, title: 'Into the Hollow', faction: null, level: 9, minLevel: 6, classes: null, xp: 900, xpSource: 'dungeonjournal',
				start: { map: FIELD, x: 50, y: 50, f: 'e', kind: 'npc', id: 2 }, end: { map: FIELD, x: 90, y: 90, f: 'e', inDungeon: true }, chain: [], followUps: [], bosses: ['Hollow King'], inData: false }],
			chainQuests: {},
		}],
	};
}

module.exports.dungeonsDoc = dungeonsDoc;
