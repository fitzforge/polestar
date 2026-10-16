'use strict';
// Zone crossings in the toolchain (tools/lib/travel/crossings.js, `travel
// build`): validation of the crossings file with errors naming the entry,
// crossings learned from recordings (TravelData.lua), the local data addon
// Polestar_Travel built from the optional local crossings file, and that the
// addon planner routes through them.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
const { buildTravel, writeTravel } = require('../tools/lib/travel/build');
const { validateCrossings, readCrossingsFile } = require('../tools/lib/travel/crossings');
const { Frames } = require('../tools/lib/travel/geo');
const { planRoute } = require('../tools/lib/travel/route');
const { ROOT } = require('./helpers/lua');
const { tmpdir } = require('./helpers/tmp');
const { quiet, fakeAddons } = require('./helpers/cli');
const install = require('../tools/commands/install');

const FIX = path.join(__dirname, 'fixtures', 'travel');
const CROSSINGS = path.join(FIX, 'crossings.json');
const readFix = (f) => JSON.parse(fs.readFileSync(path.join(FIX, 'data', f), 'utf8'));
const frames = new Frames(readFix('map-frames.json').era, readFix('zones.json'));
const opts = (extra = {}) => ({
	dataDir: path.join(FIX, 'data'),
	recordingsDir: path.join(FIX, 'recordings'),
	sourcesDir: path.join(FIX, 'sources'),
	offline: true,
	shippedFile: null, // the fixture maps: no shipped crossings
	...extra,
});

test('validation names every malformed entry', () => {
	const end = (map, x, y, radius = 15, more = {}) => ({ map, x, y, radius, ...more });
	const doc = {
		schema: 1,
		color: 'red',
		crossings: [
			{ id: 'ok', a: end(1429, 32, 50), b: end(1453, 69, 85) },
			{ id: 'ok', a: end(1429, 32, 50), b: end(1453, 69, 85) }, // duplicate id
			{ id: 'no-radius', a: { map: 1429, x: 32, y: 50 }, b: end(1453, 69, 85) },
			{ id: 'huge-radius', a: end(1429, 32, 50, 500), b: end(1453, 69, 85) },
			{ id: 'off-map', a: end(1429, 32, 112), b: end(1453, 69, 85) },
			{ id: 'flagged-off-map', a: end(1429, 32, 50), b: end(1453, 69, 101, 15, { offMap: true }) },
			{ id: 'two-continents', a: end(1429, 32, 50), b: end(1413, 50, 50) },
			{ id: 'one-zone', a: end(1429, 32, 50), b: end(1429, 33, 50) },
			{ id: 'far-apart', a: end(1429, 10, 10), b: end(1453, 90, 90) },
			{ id: 'Bad Id', a: end(1429, 32, 50), b: end(1453, 69, 85) },
			{ id: 'colour-codes', a: end(1429, 32, 50), b: end(1453, 69, 85), ab: '|cffff0000Red|r' },
			{ id: 'unknown-map', a: end(4242, 32, 50), b: end(1453, 69, 85), oneway: true },
		],
		open: [{ a: 1436, b: 1429 }, { a: 1429, b: 1436 }, { a: 1436, b: 1413 }, { a: 1436, b: 1436 }],
		chains: [
			{ id: 'ok', nodes: [end(1436, 40, 75), end(1436, 39, 76)] },
			{ id: 'lonely', nodes: [end(1436, 40, 75)] },
			{ id: 'long-hop', nodes: [end(1436, 40, 75), end(1436, 80, 20)] },
			{ id: 'bad-open', open: 'sideways', nodes: [end(1436, 40, 75), end(1436, 39, 76)] },
		],
	};
	const { errors, crossings, open, chains } = validateCrossings(doc, frames);
	const expect = [
		'crossings file: unknown key "color"',
		'crossings[1] (ok): duplicate id "ok" (also crossings[0] (ok))',
		'crossings[2] (no-radius).a: radius (yards) is required',
		'crossings[3] (huge-radius).a: radius 500 outside 3-100 yd',
		'crossings[4] (off-map).a: y 112 outside 0-100 (set "offMap": true for a point past the map edge)',
		'crossings[6] (two-continents): the ends are on different continents (0, 1)',
		'crossings[7] (one-zone): both ends are in zone 1429; a crossing joins two zones',
		'crossings[9] (Bad Id): id "Bad Id" must be lower-case letters, digits and dashes',
		'crossings[10] (colour-codes).ab: caption has control characters or | escape codes',
		'crossings[11] (unknown-map): unknown key "oneway"',
		'crossings[11] (unknown-map).a: map 4242 is not a known uiMap id with a map frame',
		'open[1]: duplicate open pair 1429 / 1436',
		'open[2]: 1436 and 1413 are on different continents',
		'open[3]: a zone is not a pair with itself',
		'chains[0] (ok): duplicate id "ok" (also crossings[0] (ok))',
		'chains[1] (lonely): a chain needs at least 2 nodes',
		'chains[3] (bad-open): open must be "mouth" or "both"',
	];
	for (const e of expect) assert.ok(errors.includes(e), `missing error: ${e}\n${errors.join('\n')}`);
	assert.ok(errors.some((e) => /^crossings\[8\] \(far-apart\): the ends are \d+ yd apart \(more than 1000\)$/.test(e)), errors.join('\n'));
	assert.ok(errors.some((e) => /^chains\[2\] \(long-hop\): nodes 0 -> 1 are \d+ yd apart \(more than 600\)$/.test(e)), errors.join('\n'));
	assert.ok(!errors.some((e) => e.includes('flagged-off-map')), 'offMap: true allows a point past the edge');
	assert.deepEqual(crossings.map((c) => c.id), ['ok', 'ok', 'flagged-off-map', 'Bad Id', 'colour-codes']);
	assert.deepEqual(open.map((o) => [o.a, o.b]), [[1436, 1429]]);
	assert.deepEqual(chains.map((c) => c.id), ['ok', 'bad-open']);

	assert.deepEqual(validateCrossings({ crossings: {} }, frames).errors, ['crossings file: schema undefined (expected 1)', 'crossings file: crossings must be an array']);
});

test('the crossings file is optional; a broken one stops the build with its errors', async () => {
	assert.equal(readCrossingsFile(path.join(FIX, 'missing.json'), frames), null);
	const dir = tmpdir('polestar-crossings-');
	try {
		const bad = path.join(dir, 'crossings.json');
		fs.writeFileSync(bad, JSON.stringify({ schema: 1, crossings: [{ id: 'x', a: { map: 1429, x: 1, y: 1 }, b: { map: 1453, x: 1, y: 1, radius: 10 } }] }));
		await assert.rejects(buildTravel(opts({ crossingsFile: bad })), /crossings\.json: 1 error\(s\)\n {2}crossings\[0\] \(x\)\.a: radius \(yards\) is required/);
		fs.writeFileSync(bad, '{ not json');
		await assert.rejects(buildTravel(opts({ crossingsFile: bad })), /crossings\.json: .*JSON/);
		const { travelAddon } = await buildTravel(opts());
		assert.equal(travelAddon, null, 'no local file next to the data: no Polestar_Travel');
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});

test('zone changes in recordings become crossings in TravelData.lua, which only refine full crossing data', async () => {
	const { travel, lua } = await buildTravel(opts());
	const rec = travel.crossings.recorded;
	assert.equal(rec.length, 1);
	assert.deepEqual([rec[0].id, rec[0].a.map, rec[0].b.map, rec[0].a.r, rec[0].sessions], ['recorded-1429-1436-1', 1429, 1436, 20, ['fixture-session']]);
	assert.ok(rec[0].a.x >= 0 && rec[0].a.x <= 100 && rec[0].b.y >= 0 && rec[0].b.y <= 100);
	assert.equal(travel.counts.recordedCrossings, 1);
	assert.match(lua, /N\.RegisterCrossings\(\{\n\tcomplete = false,/);
	assert.match(lua, /id = "recorded-1429-1436-1"/);
	assert.match(lua, /learned path nodes: continent, wx, wy, gateway \(1 = zone-border crossing\), uiMap/);
});

test('the local crossings file builds Polestar_Travel (never TravelData.lua), and the planner walks through it', async () => {
	const dir = tmpdir('polestar-crossings-');
	try {
		const result = await buildTravel(opts({ crossingsFile: CROSSINGS }));
		assert.ok(!result.lua.includes('elwynn-stormwind') && !result.lua.includes('Test Cave'), 'local crossings stay out of TravelData.lua');
		const files = result.travelAddon;
		assert.deepEqual(Object.keys(files).sort(), ['Crossings.lua', 'Polestar_Travel.toc']);
		assert.match(files['Polestar_Travel.toc'], /^## Dependencies: Polestar$/m);
		assert.doesNotMatch(files['Polestar_Travel.toc'], /LoadOnDemand/);
		assert.match(files['Crossings.lua'], /local N = Polestar and Polestar\.Nav\nif not \(N and N\.RegisterCrossings\) then return end/);
		assert.match(files['Crossings.lua'], /complete = true,/);
		assert.deepEqual(result.localCounts, { 0: { crossings: 1, open: 1, chains: 1, chainNodes: 3 } });

		writeTravel(result, { jsonOut: path.join(dir, 'travel.json'), luaOut: path.join(dir, 'TravelData.lua'), travelAddonDir: path.join(dir, 'Polestar_Travel') });
		for (const f of ['map-frames.json', 'zones.json']) fs.copyFileSync(path.join(FIX, 'data', f), path.join(dir, f));
		const common = { dataDir: dir, travelLua: path.join(dir, 'TravelData.lua'), from: { map: 1436, x: 56, y: 47 }, to: { map: 1453, x: 60, y: 60 } };
		const plain = planRoute(common);
		const crossed = planRoute({ ...common, crossingsLua: path.join(dir, 'Polestar_Travel', 'Crossings.lua') });
		assert.deepEqual(plain.map((l) => l.label), ['Stormwind City 60, 60']);
		assert.deepEqual(crossed.map((l) => l.label), ['Enter Stormwind City', 'Enter Stormwind City', 'Stormwind City 60, 60'], 'Westfall -> Elwynn is open ground, then the gate');
		assert.deepEqual([crossed[0].radius, crossed[0].waypoint, crossed[0].to.map], [20, true, 1429]);
		const back = planRoute({ ...common, from: common.to, to: common.from, crossingsLua: path.join(dir, 'Polestar_Travel', 'Crossings.lua') });
		assert.deepEqual(back.map((l) => l.label), ['Leave Stormwind City', 'Leave Stormwind City', 'Westfall 56, 47']);
		const cave = planRoute({ ...common, to: { map: 1436, x: 38.3, y: 77.4 }, crossingsLua: path.join(dir, 'Polestar_Travel', 'Crossings.lua') });
		assert.deepEqual(cave.map((l) => l.label), ['Enter the cave', 'Follow the path', 'Westfall 38.3, 77.4']);

		// The CLI writes the addon where it is told and reports the counts.
		const cli = spawnSync(process.execPath, [
			path.join(ROOT, 'tools', 'polestar.js'), 'travel', 'build', '--offline', '--shipped', 'none', '--data', path.join(FIX, 'data'), '--recordings', path.join(FIX, 'recordings'),
			'--sources', path.join(FIX, 'sources'), '--crossings', CROSSINGS, '--json', path.join(dir, 'cli.json'), '--lua', path.join(dir, 'Cli.lua'),
			'--travel-addon', path.join(dir, 'CliTravel'),
		], { encoding: 'utf8' });
		assert.equal(cli.status, 0, cli.stderr + cli.stdout);
		assert.match(cli.stdout, /local crossings, Eastern Kingdoms: 1 crossings, 1 open-ground pairs, 1 approach chains \(3 nodes\)/);
		assert.match(cli.stdout, /wrote .*CliTravel \(2 files, \d+ bytes; local use only, never packaged\)/);
		assert.equal(fs.readFileSync(path.join(dir, 'CliTravel', 'Crossings.lua'), 'utf8'), files['Crossings.lua']);
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});

test('Polestar_Travel installs when built and is never a release addon', async () => {
	const { RELEASE_ADDONS, RELEASE_DATA_ADDONS } = require('../tools/lib/dsl/project');
	assert.ok(![...RELEASE_ADDONS, ...RELEASE_DATA_ADDONS].includes('Polestar_Travel'));
	const src = fakeAddons(tmpdir('polestar-crossings-'));
	const dest = tmpdir('polestar-crossings-');
	try {
		const before = await quiet(() => install.run(['--dest', dest, '--addons', src, '--dry-run'], {}));
		assert.match(before.out, /note: Polestar_Travel not built \(no Polestar_Travel\/Polestar_Travel\.toc\); skipping it/);
		fakeAddons(src, ['Polestar_Travel']);
		const after = await quiet(() => install.run(['--dest', dest, '--addons', src, '--dry-run'], {}));
		assert.match(after.out, /would add Polestar_Travel/);
	} finally {
		fs.rmSync(src, { recursive: true, force: true });
		fs.rmSync(dest, { recursive: true, force: true });
	}
});

// The optional local crossings file, when this checkout has one.
const LOCAL = path.join(ROOT, 'data', 'local', 'crossings.json');
const DATA = path.join(ROOT, 'data', 'forever');
test('the local crossings file passes validation', { skip: !(fs.existsSync(LOCAL) && fs.existsSync(path.join(DATA, 'map-frames.json'))) && 'no local crossings file' }, () => {
	const real = new Frames(JSON.parse(fs.readFileSync(path.join(DATA, 'map-frames.json'), 'utf8')).era, JSON.parse(fs.readFileSync(path.join(DATA, 'zones.json'), 'utf8')));
	const v = validateCrossings(JSON.parse(fs.readFileSync(LOCAL, 'utf8')), real);
	assert.deepEqual(v.errors, []);
	assert.ok(v.crossings.length > 0);
	console.log(`local crossings: ${v.crossings.length} crossings, ${v.open.length} open-ground pairs, ${v.chains.length} approach chains`);
});

test('travel import: Carbonite\'s walks between zones become crossings, both ways unless marked one way; its transports are left out', () => {
	const { carboniteCrossings } = require('../tools/lib/travel/carbonite');
	const lua = [
		'local L = LibStub("AceLocale-3.0"):GetLocale("Carbonite")',
		'Nx.ZoneConnections = {',
		'    "7|1||1429|32.33|49.86||1453|73.34|90.73", -- [1]',
		'    "6|1||1436|56|47||1429|20|80", -- [2] one way',
		'    "7|1||1429|33|50||1453|72|89", -- [3] a second point on the same border',
		'    "7|1||1429|0|0||1436|0|0", -- [4] anywhere along the border: not a crossing point',
		'    "3|2|"..L["Tram to Stormwind City"].."|1429|50|50|"..L["Tram to Ironforge"].."|1453|60|60", -- [5]',
		'}',
	].join('\n');
	const doc = carboniteCrossings(lua, frames, { source: 'test' });
	assert.deepEqual(doc.crossings.map((c) => [c.id, c.oneWay === true, c.a.map, c.b.map, c.a.radius]), [
		['carbonite-elwynn-forest--stormwind-city', false, 1429, 1453, 30],
		['carbonite-westfall--elwynn-forest', true, 1436, 1429, 30],
		['carbonite-elwynn-forest--stormwind-city-2', false, 1429, 1453, 30],
	]);
	assert.deepEqual(validateCrossings(doc, frames).errors, []);
	assert.throws(() => carboniteCrossings('Nx.ZoneConnections = {}', frames, { source: 'test' }), /no walking zone connections/);
});

// The shipped crossings (tools/lib/travel/crossings.json, in TravelData.lua),
// on the real maps when this checkout has them built.
const SHIPPED = require('../tools/lib/travel/build').SHIPPED_CROSSINGS;
const realData = fs.existsSync(path.join(DATA, 'map-frames.json')) || 'data/forever not built (node tools/polestar.js data build)';

// Fitz, 2026-10-16: from the Barrens (61.66,35.46) to his map marker by
// Astranaar (Ashenvale 41.21,47.97), a Horde character who knows Ratchet,
// the Crossroads, Sun Rock Retreat, Camp Taurajo, Orgrimmar and Thunder Bluff
// flew to Sun Rock Retreat and walked straight over the ridge between
// Stonetalon and Ashenvale. The way through is the Talondeep Path.
test('shipped crossings: from the Barrens to Astranaar the walk from Sun Rock Retreat goes through the Talondeep Path, not over the ridge', { skip: realData === true ? false : realData }, () => {
	const real = new Frames(JSON.parse(fs.readFileSync(path.join(DATA, 'map-frames.json'), 'utf8')).era, JSON.parse(fs.readFileSync(path.join(DATA, 'zones.json'), 'utf8')));
	const v = validateCrossings(JSON.parse(fs.readFileSync(SHIPPED, 'utf8')), real);
	assert.deepEqual(v.errors, []);
	const talondeep = v.crossings.find((c) => c.a.map === 1440 && c.b.map === 1442);
	assert.ok(talondeep, 'Ashenvale - Stonetalon Mountains');
	const legs = planRoute({ from: { map: 1413, x: 61.66, y: 35.46 }, to: { map: 1440, x: 41.21, y: 47.97 }, faction: 'Horde', known: ['80', '25', '29', '77', '23', '22'] });
	const at = (p, end) => Math.hypot(p.wx - end.wx, p.wy - end.wy) < 1;
	const through = legs.findIndex((l) => l.kind === 'walk' && at(l.to, talondeep.b));
	assert.ok(through >= 0, `a walk reaches the Stonetalon end of the Talondeep Path: ${legs.map((l) => `${l.kind} ${l.label}`).join(' | ')}`);
	assert.ok(at(legs[through + 1].to, talondeep.a), 'and goes on to its Ashenvale end');
});
