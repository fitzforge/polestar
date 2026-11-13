'use strict';
// The generator behind guides/forever/exploration/*.guide
// (tools/lib/exploration): overlay centres from the Era map tables on
// synthetic rows, the per-goal warnings and step chunking, then (with the
// cached client tables and data/forever) that the real centres sit on known
// places, every zone area is routed for both factions, and the generated
// guides match the files on disk and compile cleanly. Playing them is
// tests/guides.test.js's job (POLESTAR_GUIDES=exploration/).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const A = require('../tools/lib/exploration/areas');
const P = require('../tools/lib/exploration/plan');
const { GUIDES } = require('../tools/lib/exploration/spec');
const { makeProjector, dist } = require('../tools/lib/route/geo');

const ROOT = path.resolve(__dirname, '..');
const DATA = path.join(ROOT, 'data', 'forever');
const SOURCES = path.join(ROOT, 'data', 'sources');
const WAGO = path.join(SOURCES, 'wago');
const hasTables =
	fs.existsSync(WAGO) && fs.readdirSync(WAGO).some((b) => A.TABLES.every((t) => fs.existsSync(path.join(WAGO, b, `${t}.csv`))));
const hasData = ['zones', 'map-frames', 'travel', 'quests'].every((n) => fs.existsSync(path.join(DATA, `${n}.json`)));
const skipReal = !hasTables ? 'Era map tables not cached (node tools/polestar.js exploration build)' : !hasData ? 'data/forever not built' : false;

// Synthetic client tables: Azeroth > Kalimdor > Durotar, plus a battleground
// parented to Azeroth (no continent) whose overlays must drop out.
const ui = [
	{ ID: '947', Name_lang: 'Azeroth', Type: '1', ParentUiMapID: '0' },
	{ ID: '1414', Name_lang: 'Kalimdor', Type: '2', ParentUiMapID: '947' },
	{ ID: '1411', Name_lang: 'Durotar', Type: '3', ParentUiMapID: '1414' },
	{ ID: '1459', Name_lang: 'Alterac Valley', Type: '3', ParentUiMapID: '947' },
];
const xart = [
	{ ID: '1', PhaseID: '0', UiMapArtID: '1194', UiMapID: '1411' },
	{ ID: '2', PhaseID: '0', UiMapArtID: '1274', UiMapID: '1459' },
	{ ID: '3', PhaseID: '7', UiMapArtID: '9999', UiMapID: '1411' },
];
const area = [
	{ ID: '362', AreaName_lang: 'Razor Hill', ExplorationLevel: '5' },
	{ ID: '816', AreaName_lang: 'Razorwind Canyon', ExplorationLevel: '8' },
	{ ID: '817', AreaName_lang: 'Drygulch Ravine ', ExplorationLevel: '8' },
	{ ID: '2597', AreaName_lang: 'Alterac Valley', ExplorationLevel: '0' },
];
const overlay = (id, art, hit, tex, areas) => ({
	ID: String(id),
	UiMapArtID: String(art),
	HitRectLeft: String(hit[0]),
	HitRectRight: String(hit[1]),
	HitRectTop: String(hit[2]),
	HitRectBottom: String(hit[3]),
	OffsetX: String(tex[0]),
	OffsetY: String(tex[1]),
	TextureWidth: String(tex[2]),
	TextureHeight: String(tex[3]),
	AreaID_0: String(areas[0] || 0),
	AreaID_1: String(areas[1] || 0),
	AreaID_2: '0',
	AreaID_3: '0',
});

test('overlay centre: the hit rect centre on the 1002x668 canvas, else the texture centre (flagged)', () => {
	// Razor Hill's real row: hit rect x 500-595, y 245-325.
	assert.deepEqual(A.overlayCentre(overlay(252, 1194, [500, 595, 245, 325], [432, 170, 220, 230], [362])), { x: 54.6, y: 42.7 });
	assert.deepEqual(A.overlayCentre(overlay(1, 1194, [0, 0, 0, 0], [401, 234, 200, 200], [362])), { x: 50, y: 50, fromTexture: true });
	// Kharanos's real row has its hit rect upside down (top 515, bottom 390).
	assert.deepEqual(A.overlayCentre(overlay(113, 1216, [445, 555, 515, 390], [401, 234, 200, 200], [131])), { x: 50, y: 50, fromTexture: true });
});

test('areas per zone map: continent zones only, phase 0, every AreaID of an overlay, names trimmed', () => {
	const out = A.extractAreas({
		WorldMapOverlay: [
			overlay(260, 1194, [480, 570, 120, 210], [0, 0, 10, 10], [817, 816]),
			overlay(252, 1194, [500, 595, 245, 325], [0, 0, 10, 10], [362]),
			overlay(300, 1274, [100, 200, 100, 200], [0, 0, 10, 10], [2597]),
			overlay(301, 9999, [100, 200, 100, 200], [0, 0, 10, 10], [362]),
			overlay(302, 1194, [100, 200, 100, 200], [0, 0, 10, 10], [4242]),
		],
		UiMapXMapArt: xart,
		UiMap: ui,
		AreaTable: area,
	});
	assert.deepEqual(Object.keys(out), ['1411']);
	assert.deepEqual(out[1411].map((o) => o.overlay), [252, 260], 'overlay ID order; unknown areas dropped');
	assert.deepEqual(out[1411][1].areas, [
		{ id: 817, name: 'Drygulch Ravine', level: 8 },
		{ id: 816, name: 'Razorwind Canyon', level: 8 },
	]);
	assert.deepEqual(A.continentOf({ UiMap: ui }), { 1411: 1414, 1459: 947 });
	// An island (a zone map on no continent) is kept when named, as its own continent.
	const isle = A.extractAreas(
		{ WorldMapOverlay: [overlay(300, 1274, [100, 200, 100, 200], [0, 0, 10, 10], [2597])], UiMapXMapArt: xart, UiMap: ui, AreaTable: area },
		{ islands: [1459] },
	);
	assert.deepEqual(Object.keys(isle), ['1459']);
	assert.deepEqual(A.continentOf({ UiMap: ui }, { islands: [1459] }), { 1411: 1414, 1459: 1459 });
});

test('goal notes: the other faction\'s town, hazards, far-above-band levels, several names', () => {
	const o = (names, level = 10) => ({ areas: names.map((name, i) => ({ id: i + 1, name, level })) });
	assert.deepEqual(P.goalNotes(o(['Razor Hill']), 'Horde', 30), []);
	assert.deepEqual(P.goalNotes(o(['Razor Hill']), 'Alliance', 30), ['Horde guards: touch the edge of Razor Hill and move on']);
	assert.deepEqual(P.goalNotes(o(['Goldshire']), null, 30), ['Alliance town: Horde characters only need to touch its edge (guards)']);
	assert.deepEqual(P.goalNotes(o(['Stromgarde Keep'], 36), null, 45), ['elite Syndicate and ogres inside the walls: the discovery triggers at the gate']);
	assert.deepEqual(P.goalNotes(o(['Somewhere'], 34), null, 30), [], 'within 5 levels of the band: no warning');
	assert.deepEqual(P.goalNotes(o(['Somewhere'], 35), null, 30), ["level 35 area, well above this guide's range"]);
	assert.deepEqual(P.goalNotes(o(['The Dark Portal'], 63), null, 60), ["level 63 area, well above this guide's range"]);
	assert.deepEqual(P.goalNotes(o(['Frostwhisper Gorge'], 60), null, 60), []);
	assert.deepEqual(P.goalNotes(o(['Kharanos', "Steelgrill's Depot"], 5), 'Alliance', 30), ['any one of these names counts']);
	// A zone area and its instance area can share a name: one name, no choice.
	assert.deepEqual(P.goalNotes(o(['Darkwhisper Gorge', 'Darkwhisper Gorge'], 55), null, 60), []);
	assert.equal(P.areaLabel(o(['Darkwhisper Gorge', 'Darkwhisper Gorge'])), 'Darkwhisper Gorge');
	assert.equal(P.overlayLevel({ areas: [{ level: 0 }, { level: 26 }, { level: 30 }] }), 26);
});

test('areas 10+ levels above a guide below the cap wait for a step of their own', () => {
	const o = (level) => ({ areas: [{ id: 1, name: 'Somewhere', level }] });
	assert.equal(P.isLater(o(60), 45), true, "Feralas's Oneiros in the 30-45 guide");
	assert.equal(P.isLater(o(54), 45), false);
	assert.equal(P.isLater(o(35), 30), false, 'five above: a warning only');
	assert.equal(P.isLater(o(63), 60), false, 'the 45-60 guides keep everything in the tour');
	assert.equal(P.isLater(o(0), 12), false, 'no known level');
});

test('steps split evenly at no more than 8 explore goals', () => {
	const n = (k) => Array.from({ length: k }, (_, i) => i);
	assert.deepEqual(P.chunks(n(8)).map((c) => c.length), [8]);
	assert.deepEqual(P.chunks(n(9)).map((c) => c.length), [5, 4]);
	assert.deepEqual(P.chunks(n(27)).map((c) => c.length), [7, 7, 7, 6]);
	assert.deepEqual(P.chunks(n(1)).map((c) => c.length), [1]);
});

test('Forever overlay centres sit on known places', { skip: skipReal }, async () => {
	const { areas: raw, continents } = await A.loadAreas({ sourcesDir: SOURCES, offline: true, islands: [2521] });
	const frames = JSON.parse(fs.readFileSync(path.join(DATA, 'map-frames.json'), 'utf8'));
	const travel = JSON.parse(fs.readFileSync(path.join(DATA, 'travel.json'), 'utf8'));
	const zones = JSON.parse(fs.readFileSync(path.join(DATA, 'zones.json'), 'utf8'));
	const { areas, project, live } = P.context({ areas: raw, continents, zones, frames, travel });
	const at = (map, name) => {
		const o = areas[map].find((x) => x.areas.some((a) => a.name === name));
		return o && [o.x, o.y];
	};
	assert.deepEqual(at(1429, 'Goldshire'), [41.2, 64.7]);
	assert.deepEqual(at(1411, 'Razor Hill'), [54.6, 42.7]);
	// Forever moved Mulgore, Eastern Plaguelands and Redridge (their live frame
	// is not the Era one) and added Hyjal, the Riverglades, Shen'dralas and
	// Zephras Isle: those maps' goals are written in the live frame.
	assert.deepEqual([...live].sort((a, b) => a - b), [1412, 1423, 1433, 2482, 2521, 2548, 2652]);
	// Kharanos's overlay has an upside-down hit rect and a texture Forever
	// padded to 256 px, whose centre is 400 yd from the town: it goes to the
	// Kharanos inn instead. Moonglade is one overlay for the whole zone.
	assert.deepEqual(at(1426, 'Kharanos'), [47.4, 52.5]);
	// Every area named like a flight master's town or an inn's location lies
	// within 350 yards of that NPC. Points project through each map's Forever
	// frame (the overlay centres' own); places are world positions.
	// Mount Hyjal (Forever-new) is drawn as nine wide areas, and its two flight
	// masters stand at the edge of theirs: Fayran Elthas inside Summit of
	// Eternity's hit rect at its west side, 397 yd from its centre, and Bluebell
	// about 140 yd west of Tainted Foothills' hit rect, 582 yd from its centre.
	// Players' recordings meet both where travel.json puts them, and log
	// Summit of Eternity at 70.9,51.5, on its hit rect's south edge, and
	// Tainted Foothills 120 yd from its centre: the frame is right, the areas
	// are wide. Hyjal's places may lie 650 yards out.
	const reach = { 2482: 650 };
	const places = [
		...travel.taxi.nodes.map((n) => ({ name: n.short, map: n.map, c: n.c, wx: n.wx, wy: n.wy })),
		...travel.inns.flatMap((i) => i.names.map((name) => ({ name, map: i.map, c: i.c, wx: i.wx, wy: i.wy }))),
	];
	let checked = 0;
	const far = [];
	for (const p of places) {
		// A zone-wide area (Moonglade's one overlay) counts anywhere in the zone.
		if (zones[p.map] && zones[p.map].name === p.name) continue;
		const o = (areas[p.map] || []).find((x) => x.areas.some((a) => a.name === p.name || a.name === `The ${p.name}`));
		if (!o) continue;
		checked++;
		const d = dist(p, project.point(p.map, o.x, o.y));
		if (d > (reach[p.map] || 350)) far.push(`${p.name} (${p.map}): ${Math.round(d)} yd`);
	}
	assert.ok(checked >= 60, `only ${checked} places matched`);
	assert.deepEqual(far, []);
});

test('generated exploration guides cover every zone area for both factions, are up to date and compile', { skip: skipReal }, async () => {
	const { buildAll, OUT_DIR } = require('../tools/lib/exploration/build');
	const { compileSources } = require('../tools/lib/dsl/project');
	const { loadData } = require('../tools/lib/dsl/data');
	const { format } = require('../tools/lib/dsl/diag');
	const { files, counts } = await buildAll({ dataDir: DATA, sourcesDir: SOURCES, offline: true });
	assert.deepEqual(Object.keys(files).sort(), GUIDES.map((g) => `${g.id}.guide`).sort());
	const stale = Object.entries(files)
		.filter(([name, text]) => !fs.existsSync(path.join(OUT_DIR, name)) || fs.readFileSync(path.join(OUT_DIR, name), 'utf8') !== text)
		.map(([name]) => name);
	assert.deepEqual(stale, [], 'run node tools/polestar.js exploration build');

	const sources = Object.entries(files).map(([name, text]) => ({ file: `guides/forever/exploration/${name}`, source: `forever/exploration/${name}`, text }));
	const { guides, diag } = compileSources(sources, loadData(DATA));
	assert.deepEqual(diag.errors.map(format), []);
	assert.deepEqual(diag.warnings.map(format), []);

	// Each faction meets every overlay of a continent (or island) exactly once.
	const continent = { 'eastern-kingdoms': 'Eastern Kingdoms', kalimdor: 'Kalimdor', 'zephras-isle': 'Zephras Isle' };
	const seen = {};
	for (const g of guides) {
		assert.equal(g.category, 'Exploration');
		const cont = continent[g.id.split('/')[2].replace(/-\d+-\d+$/, '')];
		for (const s of g.steps) {
			const sides = s.only && s.only.factions ? s.only.factions : null;
			for (const goal of s.goals) {
				if (goal.t !== 'explore') continue;
				for (const f of ['Alliance', 'Horde']) {
					if (sides && !sides.includes(f)) continue;
					const key = `${cont}:${f}`;
					seen[key] = seen[key] || [];
					seen[key].push(`${goal.map}:${goal.x},${goal.y}`);
				}
			}
		}
	}
	for (const [key, list] of Object.entries(seen)) {
		const cont = key.split(':')[0];
		assert.equal(new Set(list).size, list.length, `${key}: an area twice`);
		assert.equal(list.length, counts[cont], `${key}: ${list.length} of ${counts[cont]} areas`);
	}
	assert.equal(Object.keys(seen).length, 6);
});
