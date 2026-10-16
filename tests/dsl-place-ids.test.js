'use strict';
// Places by ID (tools/lib/dsl/places.js, docs/GUIDE_FORMAT.md "Places by
// ID"): a goal naming a place gets the AreaTable area it stands for (`area`,
// in the goal's zone, the open world's over Forever's copies), a getfp its
// flight master's taxi node (`node`, for the goal's factions); a name with no
// single match gets nothing; compile says how many got one.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { compile, guideText, DATA_DIR, GUIDES_DIR } = require('./helpers/dsl');
const { loadData } = require('../tools/lib/dsl/data');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { polestar } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');

// Fixture AreaTable rows (real IDs, plus 9000x for the made-up cases):
// Goldshire and Stormwind City also on Forever's continent 2940, a Fargodeep
// Mine in Durotar too, two Crystal Lakes in Elwynn Forest.
const AREA_CSV = `ID,ZoneName,AreaName_lang,ContinentID,ParentAreaID
1,DunMorogh,"Dun Morogh",0,0
12,Elwynn,"Elwynn Forest",0,0
14,Durotar,Durotar,1,0
57,FargodeepMine,"Fargodeep Mine",0,12
87,Goldshire,Goldshire,0,12
1519,StormwindCity,"Stormwind City",0,0
2102,ThunderbrewDistillery,"Thunderbrew Distillery",0,1
16509,StormwindCity,"Stormwind City",2940,0
16524,Goldshire,Goldshire,2940,16510
90001,FargodeepMine,"Fargodeep Mine",1,14
90002,CrystalLake,"Crystal Lake",0,12
90003,CrystalLake,"Crystal Lake",0,12
`;
const NODES = [
	{ id: 2, name: 'Stormwind, Elwynn', short: 'Stormwind', map: 1453, x: 66.3, y: 62.67, faction: 1, npc: 352, npcName: 'Dungar Longdrink' },
	{ id: 18, name: 'Booty Bay, Stranglethorn', short: 'Booty Bay', map: 1434, x: 27.53, y: 77.78, faction: 2, npc: 2858, npcName: 'Gringer' },
	{ id: 19, name: 'Booty Bay, Stranglethorn', short: 'Booty Bay', map: 1434, x: 27.53, y: 77.78, faction: 1, npc: 2859, npcName: 'Gyll' },
];

// The fixture data in <root>/forever with a travel.json (its taxi nodes and
// `inns`), and (areas) the AreaTable cached in <root>/sources/wago/1.60.1.1
// beside it.
function placeData({ areas = true, travel = true, inns = [] } = {}) {
	const root = tmpdir('polestar-place-ids-');
	const dir = path.join(root, 'forever');
	fs.mkdirSync(dir);
	for (const f of fs.readdirSync(DATA_DIR)) fs.copyFileSync(path.join(DATA_DIR, f), path.join(dir, f));
	if (travel) fs.writeFileSync(path.join(dir, 'travel.json'), `${JSON.stringify({ inns, taxi: { nodes: NODES } })}\n`);
	if (areas) {
		const wago = path.join(root, 'sources', 'wago', '1.60.1.1');
		fs.mkdirSync(wago, { recursive: true });
		fs.writeFileSync(path.join(wago, 'AreaTable.csv'), AREA_CSV);
	}
	return { dir, data: loadData(dir) };
}

const SRC = guideText([
	'step Places',
	'  sethome "Goldshire" npc 295',
	'  hearth "Goldshire"',
	'  hearth "Thunderbrew Distillery"',
	'  fly "Stormwind City"',
	'  fly "Stormwind"',
	'  getfp "Stormwind" npc 352',
	'  getfp "Booty Bay"',
	'  goto 41.5,78.2 "Fargodeep Mine"',
	'  goto 42.1,65.9 "Crystal Lake"',
	'  goto 48,42 "Kobold camp"',
]);

const ids = (r) => r.guides[0].steps[0].goals.map((g) => [g.t, g.location || g.text, g.area, g.node]);

test('a place name gets its area: in the goal\'s zone, the open world\'s over a Forever copy, none for no or two matches', () => {
	const r = compile(SRC, placeData().data);
	assert.deepEqual(r.errors, []);
	assert.deepEqual(ids(r), [
		['sethome', 'Goldshire', 87, undefined],
		['hearth', 'Goldshire', 87, undefined],
		['hearth', 'Thunderbrew Distillery', 2102, undefined],
		['fly', 'Stormwind City', 1519, undefined],
		['fly', 'Stormwind', undefined, undefined],
		['getfp', 'Stormwind', undefined, 2],
		['getfp', 'Booty Bay', undefined, 19],
		['goto', 'Fargodeep Mine', 57, undefined],
		['goto', 'Crystal Lake', undefined, undefined],
		['goto', 'Kobold camp', undefined, undefined],
	]);
});

test('a getfp\'s node: its flight master, else the one node of its town for the goal\'s factions; none for a town split by faction on a guide for both', () => {
	const both = ['guide t/both', 'title Both', 'levels 1-10', 'zone Elwynn Forest', '', 'step S', '  getfp "Booty Bay"', '  getfp "Booty Bay" npc 2858'];
	const r = compile(`${both.join('\n')}\n`, placeData().data);
	assert.deepEqual(r.errors, []);
	assert.deepEqual(r.guides[0].steps[0].goals.map((g) => g.node), [undefined, 18]);
});

test('without the cached AreaTable no goal gets an area; without travel.json no getfp gets a node', () => {
	const noAreas = compile(SRC, placeData({ areas: false }).data);
	assert.ok(noAreas.guides[0].steps[0].goals.every((g) => g.area === undefined));
	assert.equal(noAreas.guides[0].steps[0].goals.find((g) => g.t === 'getfp').node, 2);
	const noTravel = compile(SRC, placeData({ travel: false }).data);
	assert.ok(noTravel.guides[0].steps[0].goals.every((g) => g.node === undefined));
});

test('node and area are emitted before map, deterministically', () => {
	const { data } = placeData();
	const a = emitGuides(compile(SRC, data).guides.map((guide) => ({ guide })));
	const b = emitGuides(compile(SRC, data).guides.map((guide) => ({ guide })));
	assert.equal(a, b);
	assert.match(a, /\{ t = "sethome", npc = 295, npcName = "Innkeeper Farley", location = "Goldshire", area = 87, map = 1429, /);
	assert.match(a, /\{ t = "getfp", npc = 352, location = "Stormwind", node = 2 \}/);
	assert.match(a, /\{ t = "goto", text = "Fargodeep Mine", area = 57, map = 1429, x = 41\.5, y = 78\.2/);
});

test('compile reports how many place goals got an area and getfp goals a taxi node', () => {
	const { dir } = placeData();
	const out = tmpdir();
	const some = polestar(['compile', '--guides', GUIDES_DIR, '--data', dir, '--out', out]);
	assert.equal(some.status, 0, some.stderr);
	assert.match(some.stdout, /\nareas: 1 of 2 place goals got an area \(AreaTable 1\.60\.1\.1\)\nnodes: 0 of 0 getfp goals got a taxi node \(travel\.json\)\nheights: /);
	const bare = placeData({ areas: false, travel: false });
	const none = polestar(['compile', '--guides', GUIDES_DIR, '--data', bare.dir, '--out', tmpdir()]);
	assert.equal(none.status, 0, none.stderr);
	assert.match(none.stdout, /\nareas: none \(no cached Forever AreaTable in the sources beside the reference data; `data build` downloads it\)\nnodes: none \(no travel\.json in the reference data; `travel build` writes it\)\nheights: /);
});

// Fixture inns: Goldshire's innkeeper is Alliance, Razor Hill's Horde, Booty
// Bay's a neutral goblin; The Crossroads (Horde) is also reported as
// "Crossroads", as in travel.json; the made-up Crossway has one inn per
// faction. Innkeeper Boorand Plainswind is added to the fixture NPCs.
const INNS = [
	{ location: 'Goldshire', names: ['Goldshire'], npc: 295, npcName: 'Innkeeper Farley', map: 1429, x: 43.77, y: 65.8 },
	{ location: 'Booty Bay', names: ['Booty Bay'], npc: 6807, npcName: 'Innkeeper Skindle', map: 1434, x: 27, y: 77.3 },
	{ location: 'Razor Hill', names: ['Razor Hill'], npc: 6928, npcName: 'Innkeeper Grosk', map: 1411, x: 51.5, y: 41.6 },
	{ location: 'The Crossroads', names: ['The Crossroads', 'Crossroads'], npc: 3934, npcName: 'Innkeeper Boorand Plainswind', map: 1413, x: 51.99, y: 29.89 },
	{ location: 'Crossway', names: ['Crossway'], npc: 295, npcName: 'Innkeeper Farley', map: 1429, x: 43.77, y: 65.8 },
	{ location: 'Crossway', names: ['Crossway'], npc: 6928, npcName: 'Innkeeper Grosk', map: 1411, x: 51.5, y: 41.6 },
];
const BOORAND = { id: 3934, name: 'Innkeeper Boorand Plainswind', level: 30, faction: 'H', roles: ['innkeeper', 'vendor'], spawns: { 1413: { f: 'e', pts: [[51.99, 29.89]] } } };
const keepers = (r) => r.guides[0].steps[0].goals.map((g) => [g.location || 'nearest', g.npc, g.npcName, g.map, g.x, g.y]);

test('a sethome naming no npc gets its inn\'s innkeeper and position, for the factions it applies to; an explicit npc wins', () => {
	const { dir } = placeData({ inns: INNS });
	const npcsFile = path.join(dir, 'npcs.json');
	fs.writeFileSync(npcsFile, JSON.stringify({ ...JSON.parse(fs.readFileSync(npcsFile, 'utf8')), 3934: BOORAND }));
	const data = loadData(dir);
	const alliance = compile(guideText(['step Inns', '  sethome "Goldshire"', '  sethome "booty bay"', '  sethome "Razor Hill"', '  sethome "Crossroads"', '  sethome "Crossway"', '  sethome "Goldshire" npc 6807', '  sethome nearest']), data);
	assert.deepEqual(alliance.errors, []);
	assert.deepEqual(keepers(alliance), [
		['Goldshire', 295, 'Innkeeper Farley', 1429, 43.77, 65.8],
		['booty bay', 6807, 'Innkeeper Skindle', 1434, 27, 77.3],
		['Razor Hill', undefined, undefined, undefined, undefined, undefined],
		['Crossroads', undefined, undefined, undefined, undefined, undefined],
		['Crossway', 295, 'Innkeeper Farley', 1429, 43.77, 65.8],
		['Goldshire', 6807, 'Innkeeper Skindle', 1434, 27, 77.3],
		['nearest', undefined, undefined, undefined, undefined, undefined],
	]);
	const both = ['guide t/both', 'title Both', 'levels 1-10', 'zone Elwynn Forest', '', 'step Inns', '  sethome "Booty Bay"', '  sethome "Goldshire"', '  sethome "Crossway"', '  sethome "Crossway" only Horde', '  sethome "Crossroads" only Horde'];
	const r = compile(`${both.join('\n')}\n`, data);
	assert.deepEqual(r.errors, []);
	assert.deepEqual(keepers(r), [
		['Booty Bay', 6807, 'Innkeeper Skindle', 1434, 27, 77.3],
		['Goldshire', undefined, undefined, undefined, undefined, undefined],
		['Crossway', undefined, undefined, undefined, undefined, undefined],
		['Crossway', 6928, 'Innkeeper Grosk', 1411, 51.5, 41.6],
		['Crossroads', 3934, 'Innkeeper Boorand Plainswind', 1413, 51.99, 29.89],
	]);
});
