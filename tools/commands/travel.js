'use strict';
// node tools/polestar.js travel build | route | chain | import

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs } = require('node:util');
const { buildTravel, writeTravel, TRAVEL_ADDON, SHIPPED_CROSSINGS } = require('../lib/travel/build');
const { ROOT, DATA, SOURCES } = require('../lib/paths');
const { planRoute } = require('../lib/travel/route');
const { recordedChain, validateCrossings } = require('../lib/travel/crossings');
const { carboniteCrossings } = require('../lib/travel/carbonite');
const { recordedWalks } = require('../lib/travel/paths');
const { Frames } = require('../lib/travel/geo');
const { readRecordings } = require('../lib/data/recordings');

const usage = `usage: node tools/polestar.js travel build [options]
       node tools/polestar.js travel route --from <map,x,y> --to <map,x,y> [options]
       node tools/polestar.js travel chain --to <map,x,y> [options]
       node tools/polestar.js travel import --carbonite <ZoneConnections.lua> --source <text> [options]

build: the flight network (Blizzard Classic Era TaxiNodes/TaxiPath/TaxiPathNode
via wago.tools), boats/zeppelins/tram (plus the ships WoW Forever added, from
the Forever client's TaxiPathNode), inns, learned walking paths and zone
crossings learned from recordings -> data/forever/travel.json,
addon/Polestar/Nav/TravelData.lua and the flights' tracks in
addon/Polestar/Maps/FlightPaths.lua. The shipped crossings file
(tools/lib/travel/crossings.json, from "travel import") goes into TravelData.lua.
With the optional local crossings file (data/local/crossings.json, validated)
it also writes the local data addon addon/Polestar_Travel (installed when
built, never packaged).

  --offline            use cached wago.tools tables only
  --build <version>    Classic Era build (default: newest listed)
  --forever-build <v>  WoW Forever build (default: newest 1.60+ listed)
  --data <dir>         data/forever (map-frames, zones, npcs, objects)
  --recordings <dir>   data/recordings
  --sources <dir>      data/sources (wago cache)
  --shipped <file>     the shipped crossings file (default: tools/lib/travel/crossings.json; "none" to leave it out)
  --grid <dir>         the navigation grid (default: data/local/nav4; "none" to leave it out): a ship's end
                       lying in the water gets a board point, the nearest dry deck within 30 yd; without a grid, none
  --crossings <file>   the local crossings file (default: <data>/../local/crossings.json)
  --travel-addon <dir> Polestar_Travel output (default: addon/Polestar_Travel)
  --json <file>        travel.json output (default: <data>/travel.json)
  --lua <file>         TravelData.lua output (default: addon/Polestar/Nav/TravelData.lua)
  --flight-lua <file>  FlightPaths.lua output (default: addon/Polestar/Maps/FlightPaths.lua;
                       with --lua, FlightPaths.lua beside that file)

route: run the addon's own planner (Nav/Travel.lua + TravelData.lua, plus
Polestar_Travel when built) under Lua 5.1 between two Era-frame map points
and print the legs.

  --from <map,x,y>     start (uiMapID, map percent)
  --to <map,x,y>       target
  --faction <name>     Alliance | Horde (default Alliance)
  --known <ids|names>  flight master node ids or names; repeatable, or separated by ";" or ","
                       ("Sentinel Hill, Westfall" matches the full node name first)
  --speed <yd/s>       run speed (default 7)
  --hearth <location>  bind location, Hearthstone ready
  --data <dir>         data/forever (map-frames, zones, travel.json)
  --lua <file>         TravelData.lua (default: addon/Polestar/Nav/TravelData.lua)
  --crossings-lua <f>  Polestar_Travel's Crossings.lua (default: addon/Polestar_Travel/Crossings.lua when built; "none" to skip)
  --json               print the legs as JSON

chain: a candidate approach chain (a cave, a climb) for the local crossings
file, from the recorded walks that reach a target: where each walk leaves the
straight line to the target, and the walked path from there simplified into
nodes with radii and a first caption. Walks from several sides meet at the
mouth, so the shortest chain is printed. A walk that keeps to the straight
line is reported but does not stop the draft (recordings have no height: it
may have followed the arrow onto the hill above a cave). Check it in game
before using it.

  --to <map,x,y>       the target (uiMapID, Era map percent)
  --name <text>        the place ("Fargodeep Mine"): the chain's name, id and first caption
  --id <id>            the chain's id (default: from --name, else recorded-chain-<map>-<x>-<y>)
  --within <yd>        how far back from the target a walk is followed; shorter walks
                       do not count (default 300)
  --tolerance <yd>     how far the walk may stray from the line between two nodes (default 8)
  --session <id>       draft from this session's walks only (repeatable)
  --reverse            count each walk's way out, reversed, as a way in too
  --data <dir>         data/forever (map-frames, zones)
  --recordings <dir>   data/recordings
  --json               print only the chain entry

import: the shipped crossings file from Carbonite's Classic Era zone
connections (Carbonite/Data/classic/ZoneConnections.lua in
github.com/IrcDirk/Carbonite-Classic, GPL-3.0): its walks between zones
(two-way unless marked one way), validated, with the arrival radius given.

  --carbonite <file>   Carbonite's ZoneConnections.lua
  --source <text>      where it came from (repository and commit), kept in the file
  --radius <yd>        arrival radius of every end (default 30)
  --data <dir>         data/forever (map-frames, zones)
  --out <file>         output (default: tools/lib/travel/crossings.json)`;

async function build(rest) {
	const { values } = parseArgs({
		args: rest,
		options: {
			offline: { type: 'boolean' },
			build: { type: 'string' },
			'forever-build': { type: 'string' },
			data: { type: 'string' },
			recordings: { type: 'string' },
			sources: { type: 'string' },
			shipped: { type: 'string' },
			grid: { type: 'string' },
			crossings: { type: 'string' },
			'travel-addon': { type: 'string' },
			json: { type: 'string' },
			lua: { type: 'string' },
			'flight-lua': { type: 'string' },
		},
	});
	const dataDir = path.resolve(values.data || DATA);
	const result = await buildTravel({
		dataDir,
		recordingsDir: path.resolve(values.recordings || path.join(ROOT, 'data', 'recordings')),
		sourcesDir: path.resolve(values.sources || SOURCES),
		...(values.shipped ? { shippedFile: values.shipped === 'none' ? null : path.resolve(values.shipped) } : {}),
		...(values.crossings ? { crossingsFile: path.resolve(values.crossings) } : {}),
		gridDir: values.grid === 'none' ? null : path.resolve(values.grid || path.join(ROOT, 'data', 'local', 'nav4')),
		build: values.build,
		foreverBuild: values['forever-build'],
		offline: values.offline,
		log: (m) => console.log(m),
	});
	const jsonOut = path.resolve(values.json || path.join(dataDir, 'travel.json'));
	const luaOut = path.resolve(values.lua || path.join(ROOT, 'addon', 'Polestar', 'Nav', 'TravelData.lua'));
	// A named TravelData.lua (tests, trial builds) keeps the flights' tracks beside it, never in the addon.
	const flightOut = path.resolve(values['flight-lua'] || (values.lua ? path.join(path.dirname(luaOut), 'FlightPaths.lua') : path.join(ROOT, 'addon', 'Polestar', 'Maps', 'FlightPaths.lua')));
	const travelAddonDir = path.resolve(values['travel-addon'] || path.join(ROOT, 'addon', TRAVEL_ADDON));
	writeTravel(result, { jsonOut, luaOut, flightOut, travelAddonDir });
	const c = result.travel.counts;
	console.log(`travel: build ${result.travel.build}: ${c.taxiNodes} flight masters, ${c.flights} flights, ${c.transports} transports, ${c.inns} inns, ${c.pathNodes} learned path nodes / ${c.pathEdges} edges, ${c.recordedCrossings} recorded crossings, ${c.shippedCrossings} shipped crossings`);
	for (const w of result.warnings) console.log(`warning: ${w}`);
	console.log(`wrote ${path.relative(process.cwd(), jsonOut)}`);
	console.log(`wrote ${path.relative(process.cwd(), luaOut)}`);
	console.log(`wrote ${path.relative(process.cwd(), flightOut)}`);
	if (result.travelAddon) {
		const names = { 0: 'Eastern Kingdoms', 1: 'Kalimdor' };
		for (const [cont, n] of Object.entries(result.localCounts)) {
			console.log(`local crossings, ${names[cont] || `continent ${cont}`}: ${n.crossings} crossings, ${n.open} open-ground pairs, ${n.chains} approach chains (${n.chainNodes} nodes)`);
		}
		const bytes = Object.values(result.travelAddon).reduce((s, t) => s + Buffer.byteLength(t), 0);
		console.log(`wrote ${path.relative(process.cwd(), travelAddonDir)} (${Object.keys(result.travelAddon).length} files, ${bytes} bytes; local use only, never packaged)`);
	} else if (fs.existsSync(path.join(travelAddonDir, `${TRAVEL_ADDON}.toc`))) {
		console.log(`note: no local crossings file; ${path.relative(process.cwd(), travelAddonDir)} left as it was`);
	}
	return 0;
}

function importCrossings(rest) {
	const { values } = parseArgs({
		args: rest,
		options: {
			carbonite: { type: 'string' },
			source: { type: 'string' },
			radius: { type: 'string' },
			data: { type: 'string' },
			out: { type: 'string' },
		},
	});
	if (!values.carbonite) throw new Error('--carbonite <ZoneConnections.lua> is required');
	if (!values.source) throw new Error('--source <text> is required (the repository and commit it came from)');
	const dataDir = path.resolve(values.data || DATA);
	const read = (f) => JSON.parse(fs.readFileSync(path.join(dataDir, f), 'utf8'));
	const frames = new Frames(read('map-frames.json').era, read('zones.json'));
	const doc = carboniteCrossings(fs.readFileSync(path.resolve(values.carbonite), 'utf8'), frames, { source: values.source, radius: yardsOption(values.radius, '--radius', undefined) });
	const v = validateCrossings(doc, frames);
	if (v.errors.length) throw new Error(`${v.errors.length} error(s)\n  ${v.errors.join('\n  ')}`);
	const out = path.resolve(values.out || SHIPPED_CROSSINGS);
	fs.writeFileSync(out, `${JSON.stringify(doc, null, '\t')}\n`);
	console.log(`wrote ${path.relative(process.cwd(), out)}: ${doc.crossings.length} crossings (${doc.crossings.filter((c) => c.oneWay).length} one way)`);
	return 0;
}

function parsePoint(s, flag) {
	const parts = String(s || '').split(/[,\s]+/).map(Number);
	if (parts.length !== 3 || parts.some((n) => !Number.isFinite(n))) throw new Error(`${flag} expects map,x,y`);
	return { map: parts[0], x: parts[1], y: parts[2] };
}

function route(rest) {
	const { values } = parseArgs({
		args: rest,
		options: {
			from: { type: 'string' },
			to: { type: 'string' },
			faction: { type: 'string' },
			known: { type: 'string', multiple: true },
			speed: { type: 'string' },
			hearth: { type: 'string' },
			data: { type: 'string' },
			lua: { type: 'string' },
			'crossings-lua': { type: 'string' },
			json: { type: 'boolean' },
		},
	});
	// Polestar_Travel joins by default when built, unless a TravelData.lua was named.
	let crossingsLua = values['crossings-lua'];
	if (crossingsLua === undefined && !values.lua) {
		const built = path.join(ROOT, 'addon', TRAVEL_ADDON, 'Crossings.lua');
		if (fs.existsSync(built)) crossingsLua = built;
	}
	const legs = planRoute({
		from: parsePoint(values.from, '--from'),
		to: parsePoint(values.to, '--to'),
		faction: values.faction || 'Alliance',
		known: (values.known || []).flatMap((v) => v.split(';')).map((s) => s.trim()).filter(Boolean),
		speed: values.speed ? Number(values.speed) : undefined,
		hearth: values.hearth,
		...(values.data ? { dataDir: path.resolve(values.data) } : {}),
		...(values.lua ? { travelLua: path.resolve(values.lua) } : {}),
		...(crossingsLua && crossingsLua !== 'none' ? { crossingsLua: path.resolve(crossingsLua) } : {}),
	});
	if (values.json) {
		console.log(JSON.stringify(legs, null, 2));
		return legs ? 0 : 1;
	}
	if (!legs) {
		console.log('no route');
		return 1;
	}
	let total = 0;
	legs.forEach((leg, i) => {
		total += leg.seconds;
		const where = (p) => (p.map && p.x != null ? `${p.name || ''} (${p.map} ${p.x},${p.y})`.trim() : `${p.map ? `${p.map} ` : ''}(${Math.round(p.wx)}, ${Math.round(p.wy)})`);
		console.log(`${i + 1}. [${leg.kind}] ${leg.label}  ${Math.floor(leg.seconds / 60)}:${String(leg.seconds % 60).padStart(2, '0')}  ${where(leg.from)} -> ${where(leg.to)}`);
	});
	console.log(`total ${Math.floor(total / 60)}:${String(total % 60).padStart(2, '0')}`);
	return 0;
}

function yardsOption(v, flag, fallback) {
	if (v === undefined) return fallback;
	const n = Number(v);
	if (!(n > 0)) throw new Error(`${flag} expects a number of yards`);
	return n;
}

// One chain entry as the crossings file writes it: a node per line.
function chainJson(chain) {
	const flat = (o) => `{ ${Object.entries(o).map(([k, v]) => `${JSON.stringify(k)}: ${JSON.stringify(v)}`).join(', ')} }`;
	const head = Object.entries(chain).filter(([k]) => k !== 'nodes').map(([k, v]) => `\t${JSON.stringify(k)}: ${JSON.stringify(v)},`);
	return ['{', ...head, '\t"nodes": [', chain.nodes.map((n) => `\t\t${flat(n)}`).join(',\n'), '\t]', '}'].join('\n');
}

function chain(rest) {
	const { values } = parseArgs({
		args: rest,
		options: {
			to: { type: 'string' },
			name: { type: 'string' },
			id: { type: 'string' },
			within: { type: 'string' },
			tolerance: { type: 'string' },
			data: { type: 'string' },
			recordings: { type: 'string' },
			json: { type: 'boolean' },
			session: { type: 'string', multiple: true },
			reverse: { type: 'boolean' },
		},
	});
	const to = parsePoint(values.to, '--to');
	const dataDir = path.resolve(values.data || DATA);
	const read = (f) => {
		const file = path.join(dataDir, f);
		if (!fs.existsSync(file)) throw new Error(`missing ${file} (run: node tools/polestar.js data build)`);
		return JSON.parse(fs.readFileSync(file, 'utf8'));
	};
	const frames = new Frames(read('map-frames.json').era, read('zones.json'));
	const recordings = readRecordings(path.resolve(values.recordings || path.join(ROOT, 'data', 'recordings')));
	const within = yardsOption(values.within, '--within', 300);
	const { walks } = recordedWalks({ recordings, frames });
	const result = recordedChain({ walks, target: to, frames, within, tolerance: yardsOption(values.tolerance, '--tolerance', 8), id: values.id, name: values.name, sessions: values.session, reverse: values.reverse });
	const where = `${frames.name(to.map) || to.map} ${to.x}, ${to.y}`;
	if (!result.approaches.length) {
		const near = result.nearest === null ? 'none is on its continent' : `the nearest passes ${Math.round(result.nearest)} yd away`;
		console.log(`no recorded walk reaches ${where} from ${within} yd or more (${near})`);
		return 1;
	}
	if (!result.chain) {
		const open = [...new Set(result.approaches.filter((a) => !a.mouth).map((a) => a.session))].sort();
		console.log(`no chain needed for ${where}: every recorded walk reaches it on the straight line (${open.join(', ')})`);
		return 0;
	}
	const straight = [...new Set(result.approaches.filter((a) => !a.mouth).map((a) => a.session))].sort();
	if (straight.length) {
		console.warn(`warning: ${straight.join(', ')} reach ${where} on the straight line; drafting from the walks that detour (pick sessions with --session)`);
	}
	if (values.json) {
		console.log(chainJson(result.chain));
		return 0;
	}
	const sessions = [...new Set(result.approaches.map((a) => a.session))].sort();
	console.log(`approach chain candidate for ${where}: review it in game before use`);
	console.log(`  ${result.approaches.length} walk(s) reach the target from ${within} yd or more (${sessions.join(', ')}); where each leaves the straight line:`);
	const sorted = [...result.approaches].sort((a, b) => (a.mouth ? a.yards : Infinity) - (b.mouth ? b.yards : Infinity));
	for (const a of sorted) {
		const how = a.mouth ? `${a.mouth.map} ${a.mouth.x}, ${a.mouth.y}, then ${a.yards} yd of path to the target` : 'never (straight to the target)';
		console.log(`    ${a.session}, walking ${a.direction === 'in' ? 'in' : 'out (reversed)'}: ${how}`);
	}
	console.log('  the shortest is below; check in game: the mouth, each radius and the captions');
	console.log(chainJson(result.chain));
	return 0;
}

module.exports = {
	name: 'travel',
	summary: 'Build the travel network (flights, boats, inns, learned paths, zone crossings), import zone crossings, test routes and draft approach chains from recordings',
	usage,
	async run(argv) {
		const [sub, ...rest] = argv;
		try {
			if (sub === 'build') return await build(rest);
			if (sub === 'route') return route(rest);
			if (sub === 'chain') return chain(rest);
			if (sub === 'import') return importCrossings(rest);
		} catch (err) {
			console.error(err.message);
			return 1;
		}
		console.error(sub ? `unknown subcommand "${sub}"\n\n${usage}` : usage);
		return 2;
	},
};
