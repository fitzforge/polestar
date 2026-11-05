'use strict';
// The tests of the addon alone are rust/crates/forge-addontest/tests/addontest/nav-transit.rs;
// these need the travel tools (tools/lib/travel).
// Transport timing (addon/Polestar/Nav/Transit.lua) and its generator
// (tools/lib/travel/timetable.js, cmangos.js), after Shortest Path Forever by
// Cillian Berragan: departure maths (phase, wrap, boarding), untimed average
// waits, sightings and the ride observer correcting a drifted one, the
// guild/group sync's validation, class teleports, lifts; the generator's
// transport model, expected waits, lift tracks, portals and teleports, and a
// deterministic `travel build`. Ids in test names cite
// docs/NAV_QA.md.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { tmpdir } = require('./helpers/tmp');
const { moveTime, boatTimetable, expectedWait, buildTimetables, REFERENCE_PERIODS } = require('../tools/lib/travel/timetable');
const { extractLines, sqlFields, loadClassicDb, DB_REV } = require('../tools/lib/travel/cmangos');
const { buildTravel, luaStr } = require('../tools/lib/travel/build');
const { loadTravelTables } = require('../tools/lib/travel/sources');
const crypto = require('node:crypto');
const zlib = require('node:zlib');
const { Frames } = require('../tools/lib/travel/geo');

const ROOT = path.join(__dirname, '..');
const FIX = path.join(__dirname, 'fixtures', 'travel');

// --- the addon ---------------------------------------------------------------

const TRANSIT = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Nav/Transit.lua'] };

// A boat loop of 100 s: docked at A 0-20 s, at B 50-70 s; and a lift.
const DATA = `
local T = Polestar.Transit
T.Register({
	routes = {
		r = { kind = "boat", period = 100000, fit = { samples = 10, span = 15000, speed = 12 },
			stops = { { 0, 20000, 0, 0, 0 }, { 50000, 70000, 0, 3000, 0 } },
			frames = { { 0, 20000, 0, 0, 0, 0 }, { 50000, 70000, 0, 3000, 0, 0 }, { 100000, 100000, 0, 0, 0, 1 } } },
		lift = { kind = "lift", period = 30000, fit = { samples = 5, span = 4000, speed = 8 },
			stops = { { 0, 5000, 0, 500, 500, 100 }, { 15000, 20000, 0, 500, 500, 0 } },
			frames = { { 0, 5000, 0, 500, 500, 0, 100 }, { 15000, 20000, 0, 500, 500, 0, 0 }, { 30000, 30000, 0, 500, 500, 1, 100 } } },
	},
	services = {
		["boat-x"] = { kind = "boat", name = "A - B", ends = { "A", "B" }, board = 10, pre = 0, post = 0,
			wait = { a = 60, b = 60 }, ride = { a = 30, b = 30 }, routes = { { route = "r", a = { 1 }, b = { 2 } } } },
		["lift-x"] = { kind = "lift", name = "The Test Lift", c = 0, wx = 500, wy = 500, top = 100, bottom = 0, board = 2, pre = 0, post = 0,
			wait = { a = 17, b = 17 }, ride = { a = 10, b = 10 }, routes = { { route = "lift", a = { 1 }, b = { 2 } } } },
	},
	teleports = {
		{ spell = 3567, name = "Teleport: Orgrimmar", cast = 10, reagents = { 17031, 1 }, to = { "Orgrimmar", 1, 1469.9, -4221.5, 1454, 38.57, 85.95, "e" } },
		{ spell = 18960, name = "Teleport: Moonglade", cast = 10, to = { "Moonglade", 1, 7991.9, -2679.8, 1450, 56.26, 32.46, "e" } },
		{ spell = 556, name = "Astral Recall", cast = 10, bind = true },
	},
})
local function nowMs() return T.Now() * 1000 end
-- A sighting putting the loop at phase p (ms) now.
local function at(p, source) return { epoch = nowMs() - p, seen = math.floor(T.Now()), source = source or "you" } end
local function round(v) return v and math.floor(v * 10 + 0.5) / 10 end
-- The sighting held for a route (the store is per realm; there is one here).
local function held(id) for _, s in pairs(Polestar.DB().transit or {}) do return s[id] end end
`;

function lua(script, opts = {}) {
	return runAddon({ addons: [TRANSIT], login: true, ...opts, script: DATA + script }).emitted;
}

// Forever's client gives UnitPosition a height of exactly 0 (Core/Compat.lua
// reads it as no height). Taken as real, a ride on a track up in the air (a
// zeppelin at 120 yd) was 120 yd off its track and never timed.

// --- the generator -------------------------------------------------------------

test('the CMaNGOS transport model: cruising, short hops and acceleration', () => {
	// A long leg: 30 yd/s cruise plus 15 s lost accelerating and braking.
	assert.equal(moveTime(0, 3000), 3000 / 30 + 30);
	assert.equal(moveTime(1500, 1500), 1500 / 30 + 15);
	// Too short to reach cruising speed: accelerate half, brake half.
	assert.ok(Math.abs(moveTime(0, 200) - 2 * Math.sqrt(200)) < 1e-9);
	// A straight loop A -> B -> A with 30 s at each end.
	const row = (i, x, flags = 0, delay = 0) => ({ PathID: '1', NodeIndex: String(i), ContinentID: '0', Loc_0: String(x), Loc_1: '0', Loc_2: '0', Flags: String(flags), Delay: String(delay) });
	const nodes = [row(0, -300)];
	let i = 1;
	nodes.push(row(i++, 0, 2, 30));
	for (let x = 300; x < 3000; x += 300) nodes.push(row(i++, x));
	nodes.push(row(i++, 3000, 2, 30));
	for (let x = 2700; x > 0; x -= 300) nodes.push(row(i++, x));
	nodes.push(row(i++, 0));
	nodes.push(row(i++, 300));
	const { frames, period } = boatTimetable(nodes);
	const stops = frames.filter((f) => f.stop);
	assert.equal(stops.length, 2);
	assert.ok(Math.abs(stops[1].arrive - (30 + 130)) < 0.5, `B reached ${stops[1].arrive} s`);
	assert.ok(Math.abs(period - (2 * 30 + 2 * 130)) < 1, `period ${period} s`);
});

test('expected wait over a uniform phase: half the gap plus boarding, and the sooner of independent loops', () => {
	const loop = (departs, period) => ({ route: { period: period * 1000, stops: departs.map((d) => [0, d * 1000]) }, idx: departs.map((_, k) => k) });
	assert.ok(Math.abs(expectedWait([loop([20], 100)], 10) - 60) < 0.01);
	// Two departures 15 s apart in a 30 s loop (the Great Lift's two cars).
	assert.ok(Math.abs(expectedWait([loop([5, 20], 30)], 2) - 9.5) < 0.01);
	// Two independent loops of 100 s: E[min] = 100 / 3.
	assert.ok(Math.abs(expectedWait([loop([20], 100), loop([20], 100)], 0) - 100 / 3) < 0.05);
});

test('classic-db extraction: spawns, portal and teleport destinations from the SQL dump', async () => {
	assert.deepEqual(sqlFields("1,'It\\'s, (here)',3.5"), ['1', "It's, (here)", '3.5']);
	const spawn = (guid, entry) => `(${guid},${entry},1,1,10,20,30,0.5,0,0,0,0,0,0)`;
	const lines = [
		'INSERT INTO `gameobject` VALUES ' + [4170, 4171, 11898, 11899, 20649, 20652, 20655, 47296, 47297, 176080, 176081, 176082, 176083, 176084, 176085].map((e, k) => spawn(k + 1, e)).join(',') + ',' + spawn(99, 12345) + ';',
		"INSERT INTO `areatrigger_teleport` VALUES (527,'Teldrassil - Ruth Theran',0,0,0,0,1,8785.79,966.983,30.1999,3.5),(542,'Ruth Theran - Teldrassil',0,0,0,0,1,9946.25,2612.97,1316.49,0.1);",
		'INSERT INTO `spell_target_position` VALUES (3567,1,1469.85,-4221.52,58.994,5.9);',
	];
	const db = await extractLines(lines);
	assert.equal(db.spawns[12345], undefined);
	assert.deepEqual(db.spawns[11898], [{ guid: 3, map: 1, x: 10, y: 20, z: 30, o: 0.5 }]);
	assert.deepEqual(db.portals[542], { map: 1, x: 9946.25, y: 2612.97, z: 1316.49 });
	assert.deepEqual(db.positions[3567], { map: 1, x: 1469.85, y: -4221.52, z: 58.994 });
	await assert.rejects(extractLines(lines.slice(1)), /missing 4170/);
});

// Synthetic transit sources: one Undercity-style lift (a car rising 100 yd),
// the two portals and two class teleports.
function transitTables() {
	const anim = [];
	const track = [[0, 0], [5000, 0], [15000, 100], [20000, 100], [30000, 0]];
	track.forEach(([t, z], k) => anim.push({ ID: String(k + 1), TransportID: '20649', TimeIndex: String(t), Pos_0: '0', Pos_1: '0', Pos_2: String(z), SequenceID: '0' }));
	return {
		TransportAnimation: anim,
		SpellEffect: [
			{ SpellID: '3567', DifficultyID: '0', Effect: '252', ImplicitTarget_1: '17' },
			{ SpellID: '556', DifficultyID: '0', Effect: '252', ImplicitTarget_1: '9' },
			{ SpellID: '8690', DifficultyID: '0', Effect: '252', ImplicitTarget_1: '9' },
			{ SpellID: '9999', DifficultyID: '0', Effect: '252', ImplicitTarget_1: '17' },
		],
		SpellName: [{ ID: '3567', Name_lang: 'Teleport: Orgrimmar' }, { ID: '556', Name_lang: 'Astral Recall' }, { ID: '8690', Name_lang: 'Hearthstone' }, { ID: '9999', Name_lang: 'Teleport: Nowhere' }],
		SpellMisc: [{ SpellID: '3567', DifficultyID: '0', CastingTimeIndex: '16' }, { SpellID: '556', DifficultyID: '0', CastingTimeIndex: '16' }],
		SpellCastTimes: [{ ID: '16', Base: '10000' }],
		SpellReagents: [{ SpellID: '3567', Reagent_0: '17031', ReagentCount_0: '1' }],
		SkillLineAbility: [{ Spell: '3567', ClassMask: '128' }, { Spell: '556', ClassMask: '64' }, { Spell: '9999', ClassMask: '128' }, { Spell: '8690', ClassMask: '0' }],
	};
}

test('lift tracks, portals and teleports from TransportAnimation, classic-db and the spell tables', () => {
	const frames = new Frames(
		{ 1454: { c: 1, left: -3000, right: -6000, top: 3000, bottom: 0 }, 1438: { c: 1, left: 3000, right: 0, top: 11000, bottom: 8000 }, 1457: { c: 1, left: 3500, right: 1500, top: 11000, bottom: 9000 } },
		{ 1454: { name: 'Orgrimmar', type: 3 }, 1438: { name: 'Teldrassil', type: 3 }, 1457: { name: 'Darnassus', type: 3 } },
	);
	const db = {
		spawns: { 20649: [{ guid: 44892, map: 0, x: 1596, y: 292, z: -41, o: 0 }] },
		portals: { 527: { map: 1, x: 8785.79, y: 966.983, z: 30.2 }, 542: { map: 1, x: 9946.25, y: 2612.97, z: 1316.49 } },
		positions: { 3567: { map: 1, x: 1469.85, y: -4221.52, z: 58.994 } },
	};
	const tables = {
		TaxiPathNode: [],
		AreaTrigger: [
			{ ID: '527', ContinentID: '1', Pos_0: '9947.48', Pos_1: '2630.04', Pos_2: '1318.6' },
			{ ID: '542', ContinentID: '1', Pos_0: '8799.41', Pos_1: '969.787', Pos_2: '30.241' },
		],
	};
	const out = buildTimetables({ tables, transit: transitTables(), db, transports: [], frames });
	const lift = out.services['lift-undercity-west'];
	assert.deepEqual([lift.kind, lift.c, lift.wx, lift.wy, lift.top, lift.bottom], ['lift', 0, 1596, 292, 59, -41]);
	assert.deepEqual(out.routes['lift-undercity-west'].stops, [[0, 5000, 0, 1596, 292, -41, 1], [15000, 20000, 0, 1596, 292, 59, 1]]);
	assert.deepEqual([lift.wait, lift.ride], [{ a: 17, b: 17 }, { a: 10, b: 10 }]);
	assert.ok(out.warnings.some((w) => /lift-great-lift: classic-db spawn of 11898 \(16874\) missing, skipped/.test(w)));
	assert.deepEqual(out.portals.map((p) => [p.id, p.a.map, p.b.map, p.seconds]), [['portal-ruttheran', 1457, 1438, 5], ['portal-darnassus', 1438, 1457, 5]]);
	assert.deepEqual(out.teleports, [
		{ spell: 556, name: 'Astral Recall', cast: 10, bind: true },
		{ spell: 3567, name: 'Teleport: Orgrimmar', cast: 10, reagents: [17031, 1], to: { name: 'Orgrimmar', area: 1637, c: 1, wx: 1469.9, wy: -4221.5, map: 1454, x: 40.72, y: 51.01, f: 'e' } },
	]);
	assert.ok(out.warnings.some((w) => /Teleport: Nowhere \(9999\): no destination/.test(w)));
});

test('`travel build` with timetable sources: Transit data in TravelData.lua, loaded by the addon, byte-identical on every run', async () => {
	const dir = tmpdir('polestar-transit-');
	try {
		const sources = path.join(dir, 'sources');
		fs.cpSync(path.join(FIX, 'sources'), sources, { recursive: true });
		const csv = (rows) => {
			const cols = Object.keys(rows[0]);
			return `${cols.join(',')}\n${rows.map((r) => cols.map((c) => r[c]).join(',')).join('\n')}\n`;
		};
		const forever = path.join(sources, 'wago', '1.60.0.1');
		fs.mkdirSync(forever, { recursive: true });
		for (const [name, rows] of Object.entries(transitTables())) fs.writeFileSync(path.join(forever, `${name}.csv`), csv(rows));
		const cm = path.join(sources, 'cmangos', DB_REV.slice(0, 12));
		fs.mkdirSync(cm, { recursive: true });
		fs.writeFileSync(path.join(cm, 'transit.json'), JSON.stringify({ spawns: { 20649: [{ guid: 44892, map: 0, x: 1596, y: 292, z: -41, o: 0 }] }, portals: {}, positions: {} }));
		const opts = { dataDir: path.join(FIX, 'data'), recordingsDir: path.join(FIX, 'recordings'), sourcesDir: sources, offline: true, shippedFile: null };
		const one = await buildTravel(opts);
		const two = await buildTravel(opts);
		assert.equal(one.lua, two.lua);
		assert.equal(JSON.stringify(one.travel), JSON.stringify(two.travel));
		assert.equal(one.travel.transitBuild, '1.60.0.1');
		assert.equal(one.travel.cmangosRev, DB_REV);
		assert.match(one.lua, /ns\.Transit\.Register\(\{/);
		assert.match(one.lua, /Shortest Path Forever by Cillian Berragan/);
		const file = path.join(dir, 'TravelData.lua');
		fs.writeFileSync(file, one.lua);
		const [lifts, ferry] = runAddon({
			stubs: ['stub_nav.lua'],
			addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] }],
			script: `
				local chunk = assert(loadfile(${JSON.stringify(file)}))
				chunk("Polestar", Polestar)
				local T = Polestar.Transit
				emit(T.Lifts())
				emit({ T.NextDeparture("boat", "boat-feathermoon", T.Now(), "a") })
			`,
		}).emitted;
		assert.deepEqual(lifts.map((l) => l.id), ['lift-undercity-west']);
		assert.deepEqual(ferry, [168.5, 60.1, false], 'the ferry is timetabled, untimed');
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});

test('the model reproduces every period CMaNGOS classic-db sniffed (local client tables)', { skip: !fs.existsSync(path.join(ROOT, 'data', 'sources', 'wago', '1.15.9.70003', 'TaxiPathNode.csv')) && 'no cached Classic Era TaxiPathNode' }, () => {
	const { parseCsv } = require('../tools/lib/data/csv');
	const rows = parseCsv(fs.readFileSync(path.join(ROOT, 'data', 'sources', 'wago', '1.15.9.70003', 'TaxiPathNode.csv'), 'utf8'));
	for (const [pathId, reference] of Object.entries(REFERENCE_PERIODS)) {
		const nodes = rows.filter((r) => r.PathID === pathId).sort((a, b) => Number(a.NodeIndex) - Number(b.NodeIndex));
		const { period } = boatTimetable(nodes);
		assert.ok(Math.abs(period * 1000 - reference) / reference < 0.005, `TaxiPath ${pathId}: ${Math.round(period * 1000)} ms vs ${reference} ms`);
	}
});

// --- review fixes ---------------------------------------------------------------

const TRAVEL_DATA = path.join(ROOT, 'addon', 'Polestar', 'Nav', 'TravelData.lua');

// Two cars on one lift loop, 20 yd apart: car 1 at x = 0 starts at the top,
// car 2 at x = 20 at the bottom; each rides 10 s and rests 5 s at each end.
const TWO_CARS = `
local T = Polestar.Transit
T.Register({
	routes = {
		duo = { kind = "lift", period = 30000, fit = { samples = 5, span = 4000, speed = 8 },
			stops = { { 0, 5000, 0, 0, 0, 100, 1 }, { 0, 5000, 0, 20, 0, 0, 2 }, { 15000, 20000, 0, 0, 0, 0, 1 }, { 15000, 20000, 0, 20, 0, 100, 2 } },
			frames = {
				{ 0, 5000, 0, 0, 0, 0, 100 }, { 15000, 20000, 0, 0, 0, 0, 0 }, { 30000, 30000, 0, 0, 0, 1, 100 },
				{ 0, 5000, 0, 20, 0, 0, 0 }, { 15000, 20000, 0, 20, 0, 0, 100 }, { 30000, 30000, 0, 20, 0, 1, 0 },
			} },
	},
	services = {
		["lift-duo"] = { kind = "lift", name = "The Duo Lift", c = 0, wx = 10, wy = 0, top = 100, bottom = 0, board = 2, pre = 0, post = 0,
			wait = { a = 9.5, b = 9.5 }, ride = { a = 10, b = 10 }, routes = { { route = "duo", a = { 1, 4 }, b = { 2, 3 } } } },
	},
})
`;

const SHARE = `${DATA}
Polestar.Set("nav.shareTransit", true)
FIRED = {}
Polestar.On("NAV_TRANSIT", function(changed, own)
	local ids = {}
	for id in pairs(changed or {}) do ids[#ids + 1] = id end
	table.sort(ids)
	FIRED[#FIRED + 1] = { table.concat(ids, ","), own or false }
end)
local function msg(text, chatType, sender) stub.fire("CHAT_MSG_ADDON", "PolestarT1", text, chatType or "GUILD", sender or "Friend") end
`;
const SHARE_STUBS = 'SENT = {}; C_ChatInfo = { RegisterAddonMessagePrefix = function() return true end, SendAddonMessage = function(...) SENT[#SENT + 1] = { ... } end }; GetNormalizedRealmName = function() return "TestRealm" end';

function share(script, before = '') {
	return runAddon({ addons: [TRANSIT], login: true, before: `${SHARE_STUBS}; ${before}`, script: SHARE + script }).emitted;
}

test('review P3-16, security L9: the CMaNGOS dump is pinned by hash and size; a corrupt cached copy is fetched again', async () => {
	const dir = tmpdir('polestar-cmangos-');
	try {
		const spawn = (guid, entry) => `(${guid},${entry},1,1,10,20,30,0.5,0,0,0,0,0,0)`;
		const sql = [
			'INSERT INTO `gameobject` VALUES ' + [4170, 4171, 11898, 11899, 20649, 20652, 20655, 47296, 47297, 176080, 176081, 176082, 176083, 176084, 176085].map((e, k) => spawn(k + 1, e)).join(',') + ';',
			"INSERT INTO `areatrigger_teleport` VALUES (527,'a',0,0,0,0,1,1,2,3,0),(542,'b',0,0,0,0,1,4,5,6,0);",
			'INSERT INTO `spell_target_position` VALUES (3567,1,1,2,3,0);',
		].join('\n');
		const gz = zlib.gzipSync(Buffer.from(sql));
		const hash = crypto.createHash('sha256').update(gz).digest('hex');
		let fetched = 0;
		const fetchImpl = async () => { fetched++; return new Response(gz); };
		const cache = path.join(dir, 'cmangos', DB_REV.slice(0, 12));
		fs.mkdirSync(cache, { recursive: true });
		fs.writeFileSync(path.join(cache, 'classicdb.sql.gz'), 'truncated');
		const db = await loadClassicDb({ sourcesDir: dir, fetchImpl, hash });
		assert.equal(fetched, 1, 'the corrupt copy was replaced');
		assert.deepEqual(db.positions[3567], { map: 1, x: 1, y: 2, z: 3 });
		const other = tmpdir('polestar-cmangos-');
		try {
			await assert.rejects(loadClassicDb({ sourcesDir: other, fetchImpl, hash: 'f'.repeat(64) }), /sha256/);
			await assert.rejects(loadClassicDb({ sourcesDir: other, fetchImpl, hash, maxBytes: 10 }), /byte limit/);
			assert.equal(fs.existsSync(path.join(other, 'cmangos', DB_REV.slice(0, 12), 'classicdb.sql.gz')), false, 'nothing kept');
		} finally {
			fs.rmSync(other, { recursive: true, force: true });
		}
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});

test('security L10: only digits-and-dots builds name a cache folder; a carriage return is escaped in generated Lua', async () => {
	const dir = tmpdir('polestar-builds-');
	try {
		const fetchImpl = async () => new Response(JSON.stringify({ wow_classic_beta: [{ version: '1.60.1/../../escape' }] }));
		await assert.rejects(loadTravelTables({ sourcesDir: dir, fetchImpl, product: 'transit' }), /no wow_classic_beta/);
		await assert.rejects(loadTravelTables({ sourcesDir: dir, build: '../1.60.1', fetchImpl, product: 'transit' }), /not a build version/);
		assert.equal(fs.existsSync(path.join(dir, 'escape')), false);
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
	assert.equal(luaStr('a\r\nb'), '"a\\r\\nb"');
});

test('second review L10b: wago.js takes only digits-and-dots builds from wago.tools; crossings Lua escapes a carriage return', async () => {
	const { pickBuild } = require('../tools/lib/data/wago');
	const { crossingsLua } = require('../tools/lib/travel/crossings');
	const dir = tmpdir('polestar-wago-');
	try {
		const listing = (versions) => async () => new Response(JSON.stringify({ wow_classic_beta: versions.map((version) => ({ version })) }));
		const picked = await pickBuild({ sourcesDir: dir, product: 'forever', fetchImpl: listing(['1.60.0', '1.60.1/../../escape']) });
		assert.equal(picked.build, '1.60.0', 'a version with a path in it is never picked');
		await assert.rejects(pickBuild({ sourcesDir: dir, product: 'forever', fetchImpl: listing(['1.60.1/../../escape']) }), /no wow_classic_beta/);
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
	const frames = { frame: () => ({ c: 0, top: 1, bottom: 0, left: 0, right: 1 }), name: () => 'Zone\rName' };
	const set = { crossings: [{ id: 'gate', a: { map: 1, c: 0, wx: 0, wy: 0, r: 5 }, b: { map: 2, c: 0, wx: 1, wy: 1, r: 5 } }], open: [], chains: [] };
	const lua = crossingsLua(set, frames, { complete: false }).join('\n');
	assert.match(lua, /name = "Zone\\rName"/);
	assert.doesNotMatch(lua, /\r/);
});
