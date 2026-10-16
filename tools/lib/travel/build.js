'use strict';
// `travel build`: the flight network, transports, inns, learned walking
// paths and zone crossings -> data/forever/travel.json (full detail, with
// sources and warnings) and addon/Polestar/Nav/TravelData.lua (what the
// in-game planner needs, with the timetables, walk-in portals and class
// teleports Nav/Transit.lua reads: tools/lib/travel/timetable.js); the
// flights' tracks -> addon/Polestar/Maps/FlightPaths.lua (what the map's
// route lines draw).
// Crossings: the shipped crossings file (tools/lib/travel/crossings.json, from
// `travel import`: Carbonite's zone connections, GPL-3.0) goes into
// TravelData.lua as the full crossing data; the optional local crossings
// file (data/local/crossings.json) goes into the local data addon
// Polestar_Travel, never into TravelData.lua, and adds to it in game.
// Same inputs give byte-identical outputs.

const fs = require('node:fs');
const path = require('node:path');
const { Frames } = require('./geo');
const { header } = require('../generated');
const { loadTravelTables } = require('./sources');
const { buildTaxi, TRACK_TOLERANCE } = require('./taxi');
const { buildTransports } = require('./transports');
const { buildTimetables } = require('./timetable');
const { loadClassicDb } = require('./cmangos');
const { buildInns } = require('./inns');
const { buildPaths, liveFramesOf } = require('./paths');
const { readCrossingsFile, recordedCrossings, crossingsLua, emitTravelAddon, crossingCounts, TRAVEL_ADDON } = require('./crossings');
const { readRecordings } = require('../data/recordings');

const { ROOT, DATA, SOURCES } = require('../paths');
const PATH_CHUNK = 1000; // records per Lua function (keeps each under Lua 5.1's constant limits)
const SHIPPED_CROSSINGS = path.join(__dirname, 'crossings.json'); // committed, from `travel import`

function readJson(file) {
	if (!fs.existsSync(file)) throw new Error(`missing ${file} (run: node tools/polestar.js data build)`);
	return JSON.parse(fs.readFileSync(file, 'utf8'));
}

// --- Lua emission -----------------------------------------------------------

function luaStr(s) {
	return `"${String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '\\n').replace(/\r/g, '\\r')}"`;
}

function luaNum(n) {
	if (!Number.isFinite(n)) throw new Error(`non-finite number in travel data: ${n}`);
	return String(Object.is(n, -0) ? 0 : n);
}

function luaVal(v) {
	if (typeof v === 'number') return luaNum(v);
	if (typeof v === 'string') return luaStr(v);
	if (typeof v === 'boolean') return v ? 'true' : 'false';
	if (v === null || v === undefined) return 'nil';
	if (Array.isArray(v)) return `{${v.map(luaVal).join(',')}}`;
	const keys = Object.keys(v).sort();
	return `{${keys.map((k) => `${/^[A-Za-z_]\w*$/.test(k) ? k : `[${luaStr(k)}]`}=${luaVal(v[k])}`).join(',')}}`;
}

function emitLua(t) {
	const lines = [];
	lines.push(header('lua', 'travel build', 'the client tables, CMaNGOS classic-db, data/forever and data/recordings'));
	lines.push(`-- Blizzard Classic Era client tables (wago.tools build ${t.build}): TaxiNodes, TaxiPath,`);
	lines.push('-- TaxiPathNode, AreaTrigger; WoW Forever client TaxiPathNode (wago.tools build');
	lines.push(`-- ${t.foreverBuild || 'none'}) for the ships Forever added; docks and inns placed from data/forever (pfQuest, MIT);`);
	lines.push(`-- learned walking paths from ${t.paths.sessions.length} recorded session(s).`);
	lines.push('-- Timetables, portals and teleports: WoW Forever TransportAnimation and spell tables (wago.tools build');
	lines.push(`-- ${t.transitBuild || 'none'}), CMaNGOS classic-db ${t.cmangosRev ? t.cmangosRev.slice(0, 7) : 'none'} (spawns, areatrigger_teleport,`);
	lines.push('-- spell_target_position, sniffed transport periods) and the CMaNGOS transport model, after');
	lines.push('-- Shortest Path Forever by Cillian Berragan (GPL-3.0-or-later, used with permission).');
	lines.push('-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.');
	lines.push('');
	lines.push('local ADDON, ns = ...');
	lines.push('local N = ns.Nav');
	lines.push('if not (N and N.RegisterTravelData) then return end');
	lines.push('');
	lines.push('N.RegisterTravelData({');
	lines.push(`\tbuild = ${luaStr(t.build)},`);
	lines.push('\t-- id, continent, wx, wy, uiMapID, x, y (Era frame), faction mask (1 Alliance, 2 Horde), name');
	lines.push('\ttaxi = {');
	for (const n of t.taxi.nodes) lines.push(`\t\t${luaVal([n.id, n.c, n.wx, n.wy, n.map, n.x, n.y, n.faction, n.name])},`);
	lines.push('\t},');
	lines.push('\t-- one-way flights: from, to, yards flown');
	lines.push('\tflights = {');
	for (const l of t.taxi.legs) lines.push(`\t\t${l.from},${l.to},${l.yards},`);
	lines.push('\t},');
	lines.push('\t-- ends: name, continent, wx, wy, uiMapID, x, y, frame ("e" Era, "l" live); seconds riding a->b, b->a and waiting at a, b');
	lines.push('\ttransports = {');
	for (const tr of t.transports) {
		const end = (e) => [e.name, e.c, e.wx, e.wy, e.map, e.x, e.y, e.f];
		lines.push(`\t\t${luaVal({ id: tr.id, kind: tr.kind, faction: tr.faction, a: end(tr.a), b: end(tr.b), ab: tr.ab, ba: tr.ba, waitA: tr.waitA, waitB: tr.waitB })},`);
	}
	lines.push('\t},');
	lines.push('\t-- walk-in portals, one way a -> b: id, destination name, ends as transports, seconds (the loading screen)');
	lines.push('\tportals = {');
	for (const p of t.transit.portals) {
		const end = (e) => [e.name, e.c, e.wx, e.wy, e.map, e.x, e.y, e.f];
		lines.push(`\t\t${luaVal({ id: p.id, name: p.name, a: end(p.a), b: end(p.b), seconds: p.seconds })},`);
	}
	lines.push('\t},');
	lines.push('\t-- bind location names (as GetBindLocation reports them), innkeeper NPC, position');
	lines.push('\tinns = {');
	for (const i of t.inns) lines.push(`\t\t${luaVal({ names: i.names, npc: i.npc, c: i.c, wx: i.wx, wy: i.wy, map: i.map, x: i.x, y: i.y, f: i.f })},`);
	lines.push('\t},');
	lines.push('})');
	lines.push(...transitLua(t.transit));
	if (t.crossings.shipped) {
		lines.push(`-- zone crossings: ${t.crossings.shippedSource}`);
		lines.push(...crossingsLua(t.crossings.shipped, t.frames, { complete: true, live: t.live }));
	}
	if (t.crossings.recorded.length) {
		lines.push(`-- zone crossings learned from recorded play (used where a continent has full crossing data)`);
		lines.push(...crossingsLua({ crossings: t.crossings.recorded, open: [], chains: [] }, t.frames, { complete: false, live: t.live }));
	}
	const pn = t.paths.nodes;
	for (let i = 0; i < pn.length; i += PATH_CHUNK) {
		const part = pn.slice(i, i + PATH_CHUNK);
		lines.push('-- learned path nodes: continent, wx, wy, gateway (1 = zone-border crossing), uiMap');
		lines.push('N.AddTravelPaths((function() return { nodes = {');
		for (const n of part) lines.push(`\t${n.c},${n.wx},${n.wy},${n.gateway ? 1 : 0},${n.map},`);
		lines.push('} } end)())');
	}
	const pe = t.paths.edges;
	for (let i = 0; i < pe.length; i += PATH_CHUNK) {
		const part = pe.slice(i, i + PATH_CHUNK);
		lines.push('-- learned path edges: node, node, yards');
		lines.push('N.AddTravelPaths((function() return { edges = {');
		for (const e of part) lines.push(`\t${e.a},${e.b},${e.yards},`);
		lines.push('} } end)())');
	}
	return `${lines.join('\n')}\n`;
}

// The trailing ns.Transit.Register call (Transit.lua loads before this file).
function transitLua(tr) {
	if (!Object.keys(tr.routes).length && !tr.teleports.length) return [];
	const lines = [
		'',
		'-- Timetables (Nav/Transit.lua). routes[id] = { kind, period (ms), fit = observer thresholds,',
		'--   stops = { { arrive, depart (ms into the loop; depart < arrive spans its start), continent, wx, wy[, z, car] } },',
		'--   frames = { { arrive, depart, continent, wx, wy, jump (1: the next frame is reached by teleport)[, z] } } }',
		'-- services[transport or lift id] = { kind, name, board (s at the dock before it leaves), pre/post (s outside',
		'--   the ride), wait/ride = { a, b } expected s while untimed, routes = { { route, a = stops, b = stops } } }',
		'--   (a, b: indices into the route\'s stops, from 1)',
		'--   (ends = the a and b names; lifts: a = top, b = bottom, with c, wx, wy and the top and bottom z)',
		'-- teleports: class teleports { spell, name, cast (s), reagents = { item, count, ... }, to = end | bind = true }',
		'if ns.Transit and ns.Transit.Register then',
		'\tns.Transit.Register({',
		'\t\troutes = {',
	];
	for (const [id, r] of Object.entries(tr.routes)) {
		lines.push(`\t\t\t[${luaStr(id)}] = { kind = ${luaStr(r.kind)}, period = ${luaNum(r.period)}, fit = ${luaVal(r.fit)},`);
		lines.push(`\t\t\t\tstops = ${luaVal(r.stops)},`);
		lines.push('\t\t\t\tframes = {');
		for (const f of r.frames) lines.push(`\t\t\t\t\t${luaVal(f)},`);
		lines.push('\t\t\t\t},');
		lines.push('\t\t\t},');
	}
	lines.push('\t\t},', '\t\tservices = {');
	// travel.json keeps JavaScript's 0-based stop indices; Lua's start at 1.
	const oneBased = (s) => ({ ...s, routes: s.routes.map((p) => ({ ...p, a: p.a.map((i) => i + 1), b: p.b.map((i) => i + 1) })) });
	for (const [id, s] of Object.entries(tr.services)) lines.push(`\t\t\t[${luaStr(id)}] = ${luaVal(oneBased(s))},`);
	lines.push('\t\t},', '\t\tteleports = {');
	for (const { to, ...rest } of tr.teleports) {
		lines.push(`\t\t\t${luaVal(to ? { ...rest, to: [to.name, to.c, to.wx, to.wy, to.map, to.x, to.y, to.f] } : rest)},`);
	}
	lines.push('\t\t},', '\t})', 'end');
	return lines;
}

// The flights' tracks, from TaxiPathNode: ns.FlightTracks[from][to] = { wx, wy, ... }.
function emitFlightLua(build, legs) {
	const lines = [];
	lines.push(header('lua', 'travel build', 'the client tables'));
	lines.push(`-- What each flight in TravelData.lua flies: Blizzard Classic Era TaxiPathNode (wago.tools build`);
	lines.push(`-- ${build}), on the ground plane, simplified to ${TRACK_TOLERANCE} yards and rounded to the yard.`);
	lines.push('-- ns.FlightTracks[from][to] = { wx, wy, wx, wy, ... } (taxi node ids, world yards: wx north, wy west).');
	lines.push('-- Drawn by Maps/RouteLines.lua.');
	lines.push('');
	lines.push('local ADDON, ns = ...');
	lines.push('');
	lines.push('ns.FlightTracks = {');
	let from = null;
	for (const l of legs) {
		if (!l.track) continue;
		if (l.from !== from) {
			if (from !== null) lines.push('\t},');
			from = l.from;
			lines.push(`\t[${l.from}] = {`);
		}
		lines.push(`\t\t[${l.to}] = {${l.track.map(luaNum).join(',')}},`);
	}
	if (from !== null) lines.push('\t},');
	lines.push('}');
	return `${lines.join('\n')}\n`;
}

// --- build ------------------------------------------------------------------

// shippedFile: the shipped crossings file (default SHIPPED_CROSSINGS,
// committed); absent -> no shipped crossings. crossingsFile: the optional
// local crossings file (default data/local/crossings.json next to dataDir);
// absent -> no Polestar_Travel output.
async function buildTravel({
	dataDir = DATA,
	recordingsDir = path.join(ROOT, 'data', 'recordings'),
	sourcesDir = SOURCES,
	shippedFile = SHIPPED_CROSSINGS,
	crossingsFile = path.join(dataDir, '..', 'local', 'crossings.json'),
	build,
	foreverBuild,
	offline = false,
	fetchImpl,
	log = () => {},
} = {}) {
	const mapFrames = readJson(path.join(dataDir, 'map-frames.json'));
	const frames = new Frames(mapFrames.era, readJson(path.join(dataDir, 'zones.json')));
	const npcs = readJson(path.join(dataDir, 'npcs.json'));
	const objects = readJson(path.join(dataDir, 'objects.json'));
	const recordings = readRecordings(recordingsDir);
	// Live ("l") map frames: what recordings measured, else the Forever client's
	// (map-frames.json `forever`).
	const liveFrames = liveFramesOf(recordings);
	for (const [id, b] of Object.entries(mapFrames.forever || {})) if (!liveFrames.has(Number(id))) liveFrames.set(Number(id), b);
	const src = await loadTravelTables({ sourcesDir, build, offline, fetchImpl, log });
	let forever = null;
	let foreverError = null;
	try {
		forever = await loadTravelTables({ sourcesDir, build: foreverBuild, offline, fetchImpl, log, product: 'forever' });
	} catch (err) {
		foreverError = err.message;
	}
	// Timetable sources (lifts, tram, portals, teleports); without them only
	// the boats' and zeppelins' timetables are built.
	let transitTables = null;
	let db = null;
	const transitWarnings = [];
	try {
		transitTables = await loadTravelTables({ sourcesDir, build: forever ? forever.build : foreverBuild, offline, fetchImpl, log, product: 'transit' });
	} catch (err) {
		transitWarnings.push(`timetable client tables: ${err.message}`);
	}
	try {
		db = await loadClassicDb({ sourcesDir, offline, fetchImpl, log });
	} catch (err) {
		transitWarnings.push(`CMaNGOS classic-db: ${err.message}`);
	}

	const taxi = buildTaxi({ tables: src.tables, frames, npcs, liveFrames });
	const tr = buildTransports({
		tables: src.tables,
		foreverTables: forever && forever.tables,
		foreverBuild: forever && forever.build,
		foreverError,
		frames,
		npcs,
		objects,
		liveFrames,
	});
	const transit = buildTimetables({
		tables: src.tables,
		foreverTables: forever && forever.tables,
		transit: transitTables && transitTables.tables,
		db,
		transports: tr.transports,
		frames,
		liveFrames,
	});
	const inns = buildInns({ frames, npcs, liveFrames });
	const paths = buildPaths({ recordings, frames });
	const recorded = recordedCrossings(paths.zoneSteps, frames);
	const local = readCrossingsFile(crossingsFile, frames);
	const shipped = readCrossingsFile(shippedFile, frames);
	const shippedSource = shipped ? JSON.parse(fs.readFileSync(shippedFile, 'utf8')).source || path.basename(shippedFile) : null;
	const warnings = [...src.warnings, ...(forever ? forever.warnings : []), ...(transitTables ? transitTables.warnings : []), ...transitWarnings, ...taxi.warnings, ...tr.warnings, ...transit.warnings, ...inns.warnings, ...paths.warnings];

	const sources = [{ name: 'Blizzard Classic Era client tables (wago.tools)', build: src.build, tables: Object.keys(src.urls), urls: src.urls }];
	if (forever) sources.push({ name: 'WoW Forever client tables (wago.tools)', build: forever.build, tables: Object.keys(forever.urls), urls: forever.urls, use: 'ship loops Forever added' });
	if (transitTables) sources.push({ name: 'WoW Forever client tables (wago.tools)', build: transitTables.build, tables: Object.keys(transitTables.urls), urls: transitTables.urls, use: 'lift and tram tracks, class teleports' });
	if (db) sources.push({ name: 'CMaNGOS classic-db (GPL-3.0)', rev: db.rev, url: db.url, use: 'lift and tram spawns, portal and teleport destinations; sniffed transport periods' });
	sources.push({ name: 'Shortest Path Forever by Cillian Berragan (GPL-3.0-or-later, used with permission)', use: 'the timetable model, observer and data choices, ported' });
	sources.push(
		{ name: 'data/forever npcs.json / objects.json (pfQuest, MIT)', use: 'flight masters, dock NPCs/objects, innkeepers' },
		{ name: 'data/forever map-frames.json', use: 'Era map frames; Forever (live) frames for maps Forever added or redrew' },
		{ name: 'data/recordings', use: 'learned walking paths and recorded zone crossings', sessions: paths.sessions },
	);
	if (shipped) sources.push({ name: 'Carbonite (github.com/IrcDirk/Carbonite-Classic, GPL-3.0)', source: shippedSource, use: 'zone crossings (tools/lib/travel/crossings.json)' });
	const result = {
		schema: 1,
		build: src.build,
		foreverBuild: forever ? forever.build : null,
		transitBuild: transitTables ? transitTables.build : null,
		cmangosRev: db ? db.rev : null,
		sources,
		counts: {
			taxiNodes: taxi.nodes.length,
			flights: taxi.legs.length,
			transports: tr.transports.length,
			inns: inns.inns.length,
			pathNodes: paths.nodes.length,
			pathEdges: paths.edges.length,
			recordedCrossings: recorded.length,
			shippedCrossings: shipped ? shipped.crossings.length : 0,
			timetables: Object.keys(transit.services).length,
			portals: transit.portals.length,
			teleports: transit.teleports.length,
		},
		// Tracks go to FlightPaths.lua only.
		taxi: { nodes: taxi.nodes, legs: taxi.legs.map(({ track, ...leg }) => leg) },
		transports: tr.transports,
		inns: inns.inns,
		paths: { nodes: paths.nodes, edges: paths.edges, sessions: paths.sessions },
		crossings: { recorded, shipped: shipped ? { crossings: shipped.crossings, open: shipped.open, chains: shipped.chains } : null, shippedSource },
		transit: { routes: transit.routes, services: transit.services, portals: transit.portals, teleports: transit.teleports },
		warnings,
	};
	const live = mapFrames.forever || {};
	const lua = emitLua({ ...result, frames, live });
	const flightLua = emitFlightLua(src.build, taxi.legs);
	const localCounts = local && crossingCounts(local);
	return { travel: result, lua, flightLua, warnings, travelAddon: local ? emitTravelAddon(local, frames, live) : null, localCounts };
}

// travelAddonDir: where Polestar_Travel goes (written only when the build read a local crossings file).
// flightOut: FlightPaths.lua (skipped when not given).
function writeTravel({ travel, lua, flightLua, travelAddon }, { jsonOut, luaOut, flightOut, travelAddonDir }) {
	fs.mkdirSync(path.dirname(jsonOut), { recursive: true });
	fs.writeFileSync(jsonOut, `${JSON.stringify(travel, null, '\t')}\n`);
	fs.mkdirSync(path.dirname(luaOut), { recursive: true });
	fs.writeFileSync(luaOut, lua);
	if (flightLua && flightOut) {
		fs.mkdirSync(path.dirname(flightOut), { recursive: true });
		fs.writeFileSync(flightOut, flightLua);
	}
	if (travelAddon && travelAddonDir) {
		fs.mkdirSync(travelAddonDir, { recursive: true });
		for (const [name, text] of Object.entries(travelAddon)) fs.writeFileSync(path.join(travelAddonDir, name), text);
	}
}

module.exports = { buildTravel, writeTravel, emitLua, luaStr, TRAVEL_ADDON, SHIPPED_CROSSINGS };
