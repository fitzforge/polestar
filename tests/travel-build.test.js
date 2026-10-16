'use strict';
// `travel build` (tools/lib/travel, tools/commands/travel.js) on fixture
// Blizzard CSVs, data/forever-shaped JSON and one recording: what it keeps,
// where it puts docks and inns, learned paths, determinism, and that the
// generated TravelData.lua loads and plans under Lua 5.1.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
const { buildTravel, writeTravel } = require('../tools/lib/travel/build');
const { planRoute } = require('../tools/lib/travel/route');
const { runAddon, ROOT } = require('./helpers/lua');
const { parseCsv } = require('../tools/lib/data/csv');
const { tmpdir } = require('./helpers/tmp');

const FIX = path.join(__dirname, 'fixtures', 'travel');
const opts = (extra = {}) => ({
	dataDir: path.join(FIX, 'data'),
	recordingsDir: path.join(FIX, 'recordings'),
	sourcesDir: path.join(FIX, 'sources'),
	offline: true,
	shippedFile: null, // the fixture maps: no shipped crossings
	...extra,
});

function tmp() {
	return tmpdir('polestar-travel-');
}

test('flight masters, flights, transports and inns come from the client tables and spawn data', async () => {
	const { travel, warnings } = await buildTravel(opts());
	assert.equal(travel.build, '1.15.0.1');
	// Transport anchors and the zeppelin "world target" are not flight masters.
	assert.deepEqual(
		travel.taxi.nodes.map((n) => [n.id, n.short, n.map, n.faction, n.npcName]),
		[
			[2, 'Stormwind', 1453, 1, 'Dungar Longdrink'],
			[4, 'Sentinel Hill', 1436, 1, 'Thor'],
		],
	);
	const sentinel = travel.taxi.nodes[1];
	assert.ok(Math.abs(sentinel.x - 56.57) < 0.01 && Math.abs(sentinel.y - 52.67) < 0.01, 'world position converted to Era map percent');
	// Leg length is the flown path: 3D, through the TaxiPathNode points of its TaxiPath.
	const rows = parseCsv(fs.readFileSync(path.join(FIX, 'sources', 'wago', '1.15.0.1', 'TaxiPathNode.csv'), 'utf8'));
	const flown = (pathId) => {
		const pts = rows.filter((r) => r.PathID === String(pathId)).sort((a, b) => a.NodeIndex - b.NodeIndex);
		let sum = 0;
		for (let i = 1; i < pts.length; i++) sum += Math.hypot(pts[i].Loc_0 - pts[i - 1].Loc_0, pts[i].Loc_1 - pts[i - 1].Loc_1, pts[i].Loc_2 - pts[i - 1].Loc_2);
		return Math.round(sum);
	};
	assert.deepEqual(travel.taxi.legs.map((l) => [l.from, l.to]), [[2, 4], [4, 2]]);
	assert.deepEqual(travel.taxi.legs.map((l) => l.yards), [flown(6), flown(7)]);

	const boat = travel.transports.find((t) => t.id === 'boat-bootybay-ratchet');
	assert.deepEqual([boat.kind, boat.faction, boat.a.map, boat.a.x, boat.a.y, boat.b.map, boat.b.c], ['boat', 3, 1434, 26.3, 73.6, 1413, 1]);
	assert.match(boat.a.source, /Wharfmaster Lozgil/);
	assert.ok(boat.waitA > 60 && boat.ab > 0 && boat.ba > 0);
	const tram = travel.transports.find((t) => t.id === 'tram-stormwind-ironforge');
	assert.deepEqual([tram.a.map, tram.b.map, tram.faction], [1453, 1455, 1]);
	assert.equal(travel.transports.length, 3);
	assert.ok(warnings.some((w) => /zeppelin-orgrimmar-undercity: TaxiPath 302 has no points/.test(w)));

	// TaxiPath 303 lists its first stretch twice (points 0-2 again as 19-21): the
	// return trip takes the shorter way to the merged stop and that stop's 30 s
	// counts once (60 s at the far end + 30 s = 90 s docked per loop).
	const ferry = travel.transports.find((t) => t.id === 'boat-feathermoon');
	assert.match(ferry.source, /899 yd \/ 3188 yd between stops, 90 s docked per loop/);
	// The real loop matches its sniffed period, so the CMaNGOS timetable
	// replaces the estimate (accelerating, docked dwell, 10 s to board); the
	// toy Booty Bay loop does not, and keeps its estimate.
	assert.match(ferry.source, /timetable: path-303/);
	assert.deepEqual([ferry.ab, ferry.ba, ferry.waitA], [60, 137, 169]);
	assert.ok(warnings.some((w) => /boat-bootybay-ratchet: TaxiPath 241 modelled period \d+ ms is not the sniffed 350818 ms; estimate kept/.test(w)));

	assert.deepEqual(travel.inns.map((i) => [i.location, i.npc, i.map]), [['Goldshire', 295, 1429], ['Sentinel Hill', 8931, 1436]]);
	assert.ok(warnings.some((w) => /Booty Bay: Innkeeper Skindle \(6807\) does not spawn on map 1434/.test(w)), 'an innkeeper on the wrong map is dropped');
});

test('learned walking paths follow recorded breadcrumbs, mark zone borders and break at flights', async () => {
	const { travel } = await buildTravel(opts());
	const { nodes, edges, sessions } = travel.paths;
	assert.deepEqual(sessions, ['fixture-session']);
	const gateways = nodes.filter((n) => n.gateway);
	assert.equal(gateways.length, 2);
	for (const g of gateways) assert.deepEqual(g.gateway, [1429, 1436]);
	// Westfall -> Elwynn chain and the Stormwind stretch after the flight are not connected.
	const sw = new Set(nodes.filter((n) => n.map === 1453).map((n) => n.id));
	for (const e of edges) assert.equal(sw.has(e.a), sw.has(e.b), `edge ${e.a}-${e.b} crosses the flight`);
	assert.ok(edges.every((e) => e.sessions.includes('fixture-session') && e.yards > 0));
	// Plain breadcrumbs collapse: far fewer nodes than the 21 recorded points.
	assert.ok(nodes.length <= 8, `${nodes.length} nodes`);
});

test('works with no recordings at all', async () => {
	const empty = tmp();
	try {
		const { travel, lua } = await buildTravel(opts({ recordingsDir: empty }));
		assert.deepEqual([travel.counts.pathNodes, travel.counts.pathEdges], [0, 0]);
		assert.ok(!lua.includes('AddTravelPaths'));
	} finally {
		fs.rmSync(empty, { recursive: true, force: true });
	}
});

test('the CLI writes byte-identical travel.json, TravelData.lua and FlightPaths.lua on every run', async () => {
	const dirs = [tmp(), tmp()];
	try {
		for (const dir of dirs) {
			const r = spawnSync(
				process.execPath,
				[
					path.join(ROOT, 'tools', 'polestar.js'), 'travel', 'build', '--offline', '--shipped', 'none',
					'--data', path.join(FIX, 'data'), '--recordings', path.join(FIX, 'recordings'), '--sources', path.join(FIX, 'sources'),
					'--json', path.join(dir, 'travel.json'), '--lua', path.join(dir, 'TravelData.lua'), '--flight-lua', path.join(dir, 'FlightPaths.lua'),
				],
				{ encoding: 'utf8' },
			);
			assert.equal(r.status, 0, r.stderr + r.stdout);
			assert.match(r.stdout, /2 flight masters, 2 flights, 3 transports, 2 inns/);
		}
		for (const f of ['travel.json', 'TravelData.lua', 'FlightPaths.lua']) {
			assert.equal(fs.readFileSync(path.join(dirs[0], f), 'utf8'), fs.readFileSync(path.join(dirs[1], f), 'utf8'), f);
		}
		const lib = await buildTravel(opts());
		assert.equal(fs.readFileSync(path.join(dirs[0], 'TravelData.lua'), 'utf8'), lib.lua);
		assert.equal(fs.readFileSync(path.join(dirs[0], 'FlightPaths.lua'), 'utf8'), lib.flightLua);
	} finally {
		for (const d of dirs) fs.rmSync(d, { recursive: true, force: true });
	}
});

test('with --lua and no --flight-lua the CLI writes FlightPaths.lua beside it, never into the addon', () => {
	const dir = tmp();
	const committed = path.join(ROOT, 'addon', 'Polestar', 'Maps', 'FlightPaths.lua');
	const before = fs.readFileSync(committed, 'utf8');
	try {
		const r = spawnSync(process.execPath, [
			path.join(ROOT, 'tools', 'polestar.js'), 'travel', 'build', '--offline', '--shipped', 'none',
			'--data', path.join(FIX, 'data'), '--recordings', path.join(FIX, 'recordings'), '--sources', path.join(FIX, 'sources'),
			'--json', path.join(dir, 'travel.json'), '--lua', path.join(dir, 'TravelData.lua'), '--travel-addon', path.join(dir, 'PT'),
		], { encoding: 'utf8' });
		assert.equal(r.status, 0, r.stderr + r.stdout);
		assert.ok(fs.existsSync(path.join(dir, 'FlightPaths.lua')));
		assert.equal(fs.readFileSync(committed, 'utf8'), before, 'the committed file is untouched');
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});

test('generated TravelData.lua loads under Lua 5.1 and the addon planner routes with it', async () => {
	const dir = tmp();
	try {
		const result = await buildTravel(opts());
		writeTravel(result, { jsonOut: path.join(dir, 'travel.json'), luaOut: path.join(dir, 'TravelData.lua') });
		for (const f of ['map-frames.json', 'zones.json']) fs.copyFileSync(path.join(FIX, 'data', f), path.join(dir, f));
		const common = { dataDir: dir, travelLua: path.join(dir, 'TravelData.lua'), from: { map: 1436, x: 56, y: 47 }, to: { map: 1453, x: 60, y: 60 } };
		const flying = planRoute({ ...common, known: ['Sentinel Hill', 'Stormwind'] });
		assert.deepEqual(flying.map((l) => [l.kind, l.label]), [
			['walk', 'Walk to the flight master'],
			['fly', 'Fly to Stormwind'],
			['walk', 'Stormwind City 60, 60'],
		]);
		const walking = planRoute({ ...common, known: [] });
		assert.deepEqual(walking.map((l) => l.kind), ['walk']);
		const horde = () => planRoute({ ...common, faction: 'Horde', known: ['Stormwind'] });
		assert.throws(horde, /no Horde flight master matches "Stormwind"/);
		// Full node names with a comma, comma lists, and unknown factions.
		const full = planRoute({ ...common, known: ['Sentinel Hill, Westfall', 'Stormwind, Elwynn'] });
		assert.deepEqual(full.map((l) => l.kind), ['walk', 'fly', 'walk']);
		const list = planRoute({ ...common, known: ['Sentinel Hill,Stormwind'] });
		assert.deepEqual(list.map((l) => l.kind), ['walk', 'fly', 'walk']);
		assert.throws(() => planRoute({ ...common, faction: 'Scourge' }), /unknown faction "Scourge"/);
		// The CLI: repeatable --known, --json exits 1 without a route, bad factions fail.
		const cli = (...args) =>
			spawnSync(process.execPath, [path.join(ROOT, 'tools', 'polestar.js'), 'travel', 'route', '--data', dir, '--lua', common.travelLua, ...args], { encoding: 'utf8' });
		const ends = ['--from', '1436,56,47', '--to', '1453,60,60'];
		const ok = cli(...ends, '--known', 'Sentinel Hill, Westfall', '--known', 'Stormwind', '--json');
		assert.equal(ok.status, 0, ok.stderr);
		assert.deepEqual(JSON.parse(ok.stdout).map((l) => l.kind), ['walk', 'fly', 'walk']);
		// No network at all: Kalimdor cannot be reached from Westfall.
		const empty = path.join(dir, 'Empty.lua');
		fs.writeFileSync(empty, '-- no travel data\n');
		const nowhere = cli('--lua', empty, '--from', '1436,56,47', '--to', '1444,50,50', '--json');
		assert.equal(nowhere.status, 1, `no route exits 1 with --json too: ${nowhere.stderr}`);
		assert.equal(nowhere.stdout.trim(), 'null');
		const bad = cli(...ends, '--faction', 'Neutral');
		assert.equal(bad.status, 1);
		assert.match(bad.stderr, /unknown faction "Neutral"/);
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});

test('the committed TravelData.lua is loaded by the addon with the real network', () => {
	const [counts] = runAddon({
		stubs: ['stub_nav.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] }],
		script: 'emit({ Polestar.Nav.travel.Counts() })',
	}).emitted;
	const [taxi, transports, inns] = counts;
	assert.ok(taxi >= 50, `${taxi} flight masters`);
	assert.ok(transports >= 8, `${transports} transports`);
	assert.ok(inns >= 40, `${inns} inns`);
	// Inns with their own area answer to both names (GetBindLocation may report either).
	const [names] = runAddon({
		stubs: ['stub_nav.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] }],
		script: `
			local out = {}
			for _, inn in ipairs(Polestar.Nav.GetTravelData().inns) do
				if inn.npc == 6734 then out = inn.names end
			end
			emit(out)`,
	}).emitted;
	assert.deepEqual(names, ['Stoutlager Inn', 'Thelsamar']);
});

test('a Forever ship calling at three docks: one transport per dock pair, following the loop', () => {
	const { buildTransports } = require('../tools/lib/travel/transports');
	const { Frames } = require('../tools/lib/travel/geo');
	// 1000 x 1000 yd squares: Wetlands and Hillsbrad on continent 0, Darkshore on 1.
	const square = (c, wx, wy) => ({ c, left: wy + 1000, right: wy, top: wx + 1000, bottom: wx });
	const frames = new Frames({ 1437: square(0, 0, 0), 1424: square(0, 2000, 0), 1439: square(1, 0, 0) }, {});
	// Forever redrew Hillsbrad (live frame differs): Southshore is placed on it.
	const liveFrames = new Map([[1437, square(0, 0, 0)], [1424, square(0, 2000, -200)]]);
	const row = (i, c, wx, wy, delay = 0) => ({ PathID: '11167', NodeIndex: String(i), ContinentID: String(c), Loc_0: String(wx), Loc_1: String(wy), Loc_2: '0', Flags: delay ? '2' : '0', Delay: String(delay) });
	const loop = [
		row(0, 0, 500, 500, 60), // Menethil Harbor
		row(1, 0, 1500, 500),
		row(2, 0, 2500, 500, 60), // Southshore
		row(3, 0, 2500, 900),
		row(4, 1, 500, 900), // continent change
		row(5, 1, 500, 500, 60), // Auberdine
		row(6, 1, 300, 300),
		row(7, 0, 500, 100), // continent change, then back to Menethil
	];
	const empty = { TaxiPathNode: [], AreaTrigger: [] };
	const { transports, warnings } = buildTransports({
		tables: empty,
		foreverTables: { TaxiPathNode: loop },
		foreverBuild: '1.60.0.1',
		frames,
		npcs: {},
		objects: {},
		liveFrames,
	});
	const byId = Object.fromEntries(transports.map((t) => [t.id, t]));
	// M->S 2000 yd; S->M sails on past Auberdine (1483 yd, 2 continent changes, 60 s docked there).
	assert.deepEqual(
		['boat-menethil-southshore', 'boat-southshore-auberdine', 'boat-menethil-auberdine'].map((id) => {
			const t = byId[id];
			return [t.a.map, t.a.f, t.b.map, t.b.f, t.ab, t.ba, t.waitA, t.faction];
		}),
		[
			[1437, 'e', 1424, 'l', 67, 129, 158, 1],
			[1424, 'l', 1439, 'e', 37, 159, 158, 1],
			[1437, 'e', 1439, 'e', 163, 33, 158, 1],
		],
	);
	assert.deepEqual([byId['boat-menethil-southshore'].b.x, byId['boat-menethil-southshore'].b.y], [30, 50], 'Southshore on the live frame');
	assert.match(byId['boat-menethil-southshore'].source, /^TaxiPath 11167 \(WoW Forever client 1\.60\.0\.1\): 2000 yd \/ 1483 yd between stops, 0 s \/ 60 s docked at stops on the way, 180 s docked per loop/);
	assert.ok(warnings.some((w) => /boat-stormwind-auberdine: TaxiPath 11616 \(WoW Forever client 1\.60\.0\.1\) has no points, skipped/.test(w)));
	assert.ok(!byId['boat-bootybay-ratchet'], 'Era loops come from the Era tables only');

	// Without the Forever client tables the Forever ships are skipped, saying why.
	const none = buildTransports({ tables: empty, foreverError: 'offline', frames, npcs: {}, objects: {}, liveFrames });
	assert.equal(none.transports.length, 0);
	assert.ok(none.warnings.includes('boat-tanaris-powderfuse: no WoW Forever client tables (offline), skipped'));
});

test('the committed TravelData.lua has the Forever ships on their dock maps', () => {
	const [ships] = runAddon({
		stubs: ['stub_nav.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] }],
		script: `
			local out = {}
			for _, t in ipairs(Polestar.Nav.GetTravelData().transports) do
				out[t.id] = { t.faction, t.a.map, t.a.f, t.b.map, t.b.f, t.ab, t.ba, t.waitA, t.waitB }
			end
			emit(out)`,
	}).emitted;
	const expect = {
		'boat-stormwind-auberdine': [1, 1453, 'l', 1439, 'e'], // Stormwind Harbor is on Forever's redrawn Stormwind map
		'boat-menethil-southshore': [1, 1437, 'e', 1424, 'e'],
		'boat-southshore-auberdine': [1, 1424, 'e', 1439, 'e'],
		'boat-menethil-auberdine': [1, 1437, 'e', 1439, 'e'],
		'boat-tanaris-powderfuse': [3, 1446, 'e', 2548, 'l'], // Riverglades: a Forever-only map
	};
	for (const [id, ends] of Object.entries(expect)) {
		const t = ships[id];
		assert.ok(t, `${id} present`);
		assert.deepEqual(t.slice(0, 5), ends, id);
		for (const secs of t.slice(5)) assert.ok(secs > 20 && secs < 600, `${id}: ${t.slice(5)} s`);
	}
});
