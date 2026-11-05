'use strict';
// Simulator orchestration shared by the `sim` subcommands
// (docs/legacy/SIMULATION-js.md): world loading, character runs, search on workers,
// result files and route descriptions.

const fs = require('node:fs');
const path = require('node:path');
const { getWorld, worldFile } = require('./world');
const { attachWalks } = require('./walks');
const { loadQuestXp } = require('../game/xp');
const { compileRun, makeTables } = require('./run');
const { loadObjectFacts, loadGraveyards } = require('../travel/cmangos');
const { loadEscortFacts, attachEscortRuns } = require('./escorts');
const { graveyardsFor } = require('./graveyards');
const { Evaluator } = require('./evaluate');
const { loadParamsFile, effective, means, objectiveName, tagName } = require('./params');
const { CLASSES, classLabel } = require('../game/races');

const { ROOT, DATA, SOURCES } = require('../paths');
const DEFAULTS = {
	dataDir: DATA,
	simDir: path.join(ROOT, 'data', 'sim'),
	sourcesDir: SOURCES,
	benchDir: path.join(ROOT, 'data', 'bench'),
};

const FACTIONS = { alliance: 'Alliance', horde: 'Horde' };
// Start races the runs cover (one per starting area, plus Forever's own).
const START_RACES = { Horde: ['Orc', 'Tauren', 'Undead', 'Skyborne'], Alliance: ['Human', 'Dwarf', 'NightElf', 'Skyborne'] };

// Class names as the rest of the model writes them (title case: the keys of
// CLASS_FACTOR in params.js and of CLASS_BITS in run.js), from any case. An
// unknown name fails here: left alone it is a silent wrong answer, because
// `q.classes & CLASS_BITS[undefined]` is 0, so every class quest drops out.
function normClass(c) {
	if (c == null || c === '') return null;
	const k = String(c).toLowerCase();
	if (!CLASSES[k]) throw new Error(`--class must be one of ${Object.values(CLASSES).map((x) => classLabel(x.file)).join(', ')} (got ${c})`);
	return classLabel(CLASSES[k].file);
}

function normFaction(f) {
	const v = FACTIONS[String(f || '').toLowerCase()];
	if (!v) throw new Error(`--faction must be Alliance or Horde (got ${f})`);
	return v;
}

// What the escort facts and the graveyards (loadWorld; not in the world file or its hash)
// are made from, for a long-running process to keep them by (memo.js): the data files they
// read by content, the CMaNGOS extracts, the Forever world database and its scripts' checkout.
function sidecarKey(opts) {
	const { fileHash } = require('../requires');
	const { TDB_DIR } = require('./escorts');
	const { DB_REV } = require('../travel/cmangos');
	const content = (f) => (fs.existsSync(f) ? fileHash(f) : '-');
	const stat = (f) => {
		try {
			const st = fs.statSync(f);
			return `${st.size}:${st.mtimeMs}`;
		} catch {
			return '-';
		}
	};
	const cm = path.join(opts.sourcesDir, 'cmangos', DB_REV.slice(0, 12));
	return [
		...['quests.json', 'npcs.json', 'zones.json', 'map-frames.json'].map((f) => content(path.join(opts.dataDir, f))),
		content(path.join(cm, 'escort_paths.json')), content(path.join(cm, 'graveyards.json')),
		stat(path.join(TDB_DIR, 'world.sqlite')), content(path.join(TDB_DIR, 'repo', '.git', 'HEAD')),
	].join(':');
}

async function loadWorld(o) {
	const opts = { ...DEFAULTS, ...o };
	const questXp = await loadQuestXp({ sourcesDir: opts.sourcesDir, offline: opts.offline, log: opts.log });
	// Gameobject types, respawns and loot for the world's object camps (cached
	// beside the classic-db dump; getWorld reads the cache). Without them the
	// world's object camps take its estimates.
	try {
		await loadObjectFacts({ sourcesDir: opts.sourcesDir, offline: opts.offline, log: opts.log || (() => {}) });
	} catch (err) {
		if (opts.log) opts.log(`  warning: CMaNGOS gameobject facts unavailable (${err.message}): object camps take estimated chances and respawns`);
	}
	const world = getWorld({ dataDir: opts.dataDir, sourcesDir: opts.sourcesDir, simDir: opts.simDir, faction: opts.faction, rebuild: opts.rebuild, questXp, log: opts.log, bandWidth: opts.bandWidth, maxOpen: opts.maxOpen, extraStarts: opts.extraStarts });
	// The escort NPCs' walks (escorts.js; kept beside the sources; not part of the
	// world file or its hash): without them every escort takes the straight line to its end.
	// A long-running process keeps them and the graveyards by their inputs (sidecarKey).
	const { memo } = require('./memo');
	const sk = sidecarKey(opts);
	const side = memo(`sidecar:${opts.dataDir}:${opts.sourcesDir}|${sk}`, () => ({}));
	let escorts = null;
	try {
		if (!('escorts' in side)) side.escorts = await loadEscortFacts({ dataDir: opts.dataDir, sourcesDir: opts.sourcesDir, offline: opts.offline, log: opts.log || (() => {}) });
		escorts = side.escorts;
	} catch (err) {
		if (opts.log) opts.log(`  warning: escort facts unavailable (${err.message}): escorts take the straight line`);
	}
	attachEscortRuns(world, escorts);
	// The faction's graveyards for the deathskip (cached beside the classic-db dump; not
	// part of the world file or its hash): none without them, and no deathskip.
	world.graveyards = null;
	try {
		const k = `graveyards${world.faction}`;
		if (!(k in side)) {
			const gy = await loadGraveyards({ sourcesDir: opts.sourcesDir, offline: opts.offline, log: opts.log || (() => {}) });
			const read = (f) => JSON.parse(fs.readFileSync(path.join(opts.dataDir, f), 'utf8'));
			side[k] = graveyardsFor(gy, world.faction, { zones: read('zones.json'), npcs: read('npcs.json'), frames: read('map-frames.json') });
		}
		world.graveyards = side[k];
	} catch (err) {
		if (opts.log) opts.log(`  warning: CMaNGOS graveyards unavailable (${err.message}): no deathskip`);
	}
	world.sidecar = sk; // what the escort runs and graveyards were made from (v2Setup keys the compiled run by it)
	// Routed walks (sim walks), unless --no-walks: the straight line × detour then.
	if (opts.walks !== false) attachWalks(world, opts.simDir, { log: opts.log });
	else world.walks = null;
	// A sim server loads this world again when its inputs change (serve.js hot swap).
	const keep = Object.fromEntries(['dataDir', 'simDir', 'sourcesDir', 'offline', 'bandWidth', 'extraStarts'].filter((k) => o[k] !== undefined).map((k) => [k, o[k]]));
	require('./memo').remember(`world:${ROOT}:${opts.simDir}:${opts.faction}`, { root: ROOT, kind: 'world', o: keep, faction: opts.faction });
	return { world, worldFile: worldFile(opts.simDir, opts.faction) };
}

// Parameters for a class under an objective (params.js OBJECTIVES) and
// `--param` overrides ({ key: value }, applied last).
function paramsFor(simDir, cls, objective = 'time', overrides = {}) {
	const doc = loadParamsFile(simDir);
	const eff = effective(doc, cls, objective, overrides);
	return { doc, eff, mean: means(eff) };
}

function makeRun(world, { race, cls, params, family = 'solo' }) {
	const run = compileRun(world, { race, cls, family });
	const tables = makeTables(run, params);
	return { run, tables, ev: new Evaluator(run, tables) };
}

function className(cls) {
	return cls ? String(cls) : 'any';
}

// File name suffix of a search variant: the time objective without a tag
// keeps the plain name; another objective and a `--tag` get their own
// (horde-orc-any-smooth.json, horde-orc-any-smooth-g6.json), so variants
// never overwrite each other.
function variantSuffix(objective = 'time', tag = null) {
	const obj = objectiveName(objective);
	const t = tagName(tag);
	return `${obj === 'time' ? '' : `-${obj}`}${t ? `-${t}` : ''}`;
}

function resultFile(simDir, faction, race, cls, family = 'solo', objective = 'time', tag = null) {
	return path.join(simDir, 'results', `${faction.toLowerCase()}-${race.toLowerCase()}-${className(cls).toLowerCase()}${family === 'solo' ? '' : `-${family}`}${variantSuffix(objective, tag)}.json`);
}

// Smoothness counters of an evaluation (evaluate.js result()).
function smoothness(r) {
	return {
		zoneChanges: r.zoneChanges, zoneReturns: r.zoneReturns, spotReturns: r.spotReturns, sharedKills: r.sharedKills,
		logPeak: r.logPeak, logDeferred: r.logDeferred, logSkipped: r.logSkipped, logAbandoned: r.logAbandoned, acceptedNeverTurnedIn: r.acceptedNeverTurnedIn,
	};
}

// Package keys -> run indices (unknown keys are dropped).
function routeFromKeys(run, keys) {
	const idx = new Map(run.packages.map((p, i) => [p.key, i]));
	return keys.map((k) => idx.get(k)).filter((i) => i != null);
}

// A result replays only on the world it was searched on (same data, by
// content, and builder: world.js worldInputs); anything else would silently
// replay a different route. The message names the inputs that changed when
// the result recorded them.
function assertFresh(res, world, file) {
	if (res.dataHash !== world.dataHash) {
		const { changedInputs } = require('./world');
		const what = res.inputs && world.inputs ? changedInputs(res.inputs, world.inputs).join(', ') : 'data or builder';
		throw new Error(`${file || 'result'} was searched on world ${String(res.dataHash).slice(0, 12)}, the current ${world.faction} world is ${String(world.dataHash).slice(0, 12)} (${what} changed; results of the retired \`sim run\` are not replayed)`);
	}
	if ((res.walks || null) !== (world.walksId || null)) {
		throw new Error(`${file || 'result'} was searched ${res.walks ? 'with other routed walks' : 'without routed walks'}, the current ${world.faction} world walks ${world.walksId ? 'routed (forge walks walks)' : 'the straight line × detour'} (results of the retired \`sim run\` are not replayed)`);
	}
}

module.exports = {
	DEFAULTS, START_RACES, normFaction, normClass, loadWorld, paramsFor, makeRun, className, resultFile, assertFresh,
	routeFromKeys, smoothness, variantSuffix,
};
