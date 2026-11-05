// The browser planner's backend: a module Web Worker that does what the Node planner server did
// (tools/planner/server.js: the commands of tools/planner/commands.js over one Workspace, the events),
// from static files: the bundle (www/bundle/, src/bin/bundle.rs), the walk store's legs (www/nav/legs/)
// and forge-wasm (www/pkg/). Guide edits stay in this browser (IndexedDB), downloadable as a zip.
//
// Page -> worker: { type: 'init', set } | { type: 'cmd', id, name, args } | { type: 'view', state }
// Worker -> page: { type: 'progress', text } | { type: 'ready', info } | { type: 'failed', error }
//   | { type: 'result', id, ok, result | error, code } | { type: 'event', name, data }

import * as vfs from './shims/fs.js';
import path from 'path';
import * as commands from '../../../../../tools/planner/commands.js';
import { PlannerError } from '../../../../../tools/planner/workspace.js';
import { BrowserWorkspace } from './ws.js';
import { zip } from './zip.js';

const ROOT = '/repo';
const base = new URL('./', self.location.href);
const post = (m) => self.postMessage(m);
const progress = (text) => post({ type: 'progress', text });
const timings = {};
const bytes = {};

async function fetchBytes(rel) {
	const t0 = performance.now();
	const res = await fetch(new URL(rel, base));
	if (!res.ok) throw new Error(`${rel}: HTTP ${res.status}`);
	let buf = await res.arrayBuffer();
	bytes[rel] = buf.byteLength;
	const u = new Uint8Array(buf, 0, 2);
	if (u[0] === 0x1f && u[1] === 0x8b) buf = await new Response(new Blob([buf]).stream().pipeThrough(new DecompressionStream('gzip'))).arrayBuffer();
	timings[rel] = Math.round(performance.now() - t0);
	return new Uint8Array(buf);
}
const fetchText = async (rel) => new TextDecoder().decode(await fetchBytes(rel));
const fetchJson = async (rel) => JSON.parse(await fetchText(rel));
const optional = (p) => p.catch(() => null);

// ---------------------------------------------------------------- edits kept in the browser (IndexedDB)

function idb() {
	return new Promise((resolve, reject) => {
		const r = indexedDB.open('polestar-planner', 1);
		r.onupgradeneeded = () => r.result.createObjectStore('files');
		r.onsuccess = () => resolve(r.result);
		r.onerror = () => reject(r.error);
	});
}
async function idbAll(db, prefix) {
	return new Promise((resolve, reject) => {
		const out = [];
		const tx = db.transaction('files').objectStore('files').openCursor(IDBKeyRange.bound(prefix, prefix + '\uffff'));
		tx.onsuccess = () => {
			const c = tx.result;
			if (!c) return resolve(out);
			out.push([c.key.slice(prefix.length), c.value]);
			c.continue();
		};
		tx.onerror = () => reject(tx.error);
	});
}
function idbPut(db, key, value) {
	const tx = db.transaction('files', 'readwrite');
	if (value === undefined) tx.objectStore('files').delete(key);
	else tx.objectStore('files').put(value, key);
}

// ---------------------------------------------------------------- boot

let ws = null;
let rt = null;
let setName = null;
let ready = null;
let lastPlay = null;
let hoursTimer = null;
let busy = Promise.resolve();
const shipped = new Map(); // abs -> the bundle's text (null: the file is not in the bundle)

async function boot(set) {
	const t0 = performance.now();
	setName = set;
	progress('Loading the planner…');
	const manifest = await fetchJson('bundle/manifest.json');
	if (!manifest.sets.some((s) => s.name === set)) throw new Error(`no guide set "${set}" in the bundle (${manifest.sets.map((s) => s.name).join(', ')})`);
	const wasm = import(new URL('pkg/forge_wasm.js', base).href).then(async (m) => {
		const tw = performance.now();
		await m.default(new URL('pkg/forge_wasm_bg.wasm', base));
		timings.wasm = Math.round(performance.now() - tw);
		return m;
	});
	const [data, instances, areas, repo, setDoc, params, flights, legsIndex, art, aids, wasmMod, spells] = await Promise.all([
		fetchText('bundle/data.json.gz'), fetchText('bundle/instances.json.gz'), fetchText('bundle/areas.json.gz'), fetchJson('bundle/repo.json.gz'),
		fetchJson(`bundle/set-${set}.json.gz`), fetchText('bundle/params.json'), optional(fetchJson('bundle/flights.json.gz')),
		optional(fetchJson('nav/legs/index.json')), optional(fetchText('art/index.json')), optional(fetchText('nav/aids.json')), wasm, optional(fetchText('bundle/spell-names.json.gz')),
	]);
	timings.fetch = Math.round(performance.now() - t0);

	progress('Reading the reference data…');
	const tr = performance.now();
	const texts = JSON.parse(data);
	const entries = [];
	for (const [name, text] of Object.entries(texts)) entries.push([`${ROOT}/data/forever/${name}.json`, text]);
	for (const [rel, text] of Object.entries(repo)) entries.push([`${ROOT}/${rel}`, text]);
	entries.push([`${ROOT}/data/sim/params.json`, params]);
	if (art) entries.push([`${ROOT}/art/index.json`, art]);
	const pack = `${ROOT}/guides`;
	const packFiles = setDoc.pack;
	entries.push([`${pack}/pack.json`, packFiles.manifest]);
	for (const f of ['legs', 'retired']) if (packFiles[f] != null) entries.push([`${pack}/${f}.json`, packFiles[f]]);
	if (packFiles.license != null) entries.push([`${pack}/LICENSE`, packFiles.license]);
	for (const [rel, text] of setDoc.files) {
		entries.push([`${pack}/${rel}`, text]);
		shipped.set(`${pack}/${rel}`, text);
	}
	vfs.mount(entries);
	// The edits this browser keeps for the set, over the bundle's texts.
	const db = await optional(idb());
	const prefix = `${set}:`;
	const kept = db ? await idbAll(db, prefix) : [];
	for (const [abs, text] of kept) {
		if (!shipped.has(abs)) shipped.set(abs, null);
		if (text === null) vfs.rmSync(abs, { force: true });
		else vfs.mount([[abs, text]]);
	}
	vfs.onWrite((abs, text) => {
		if (!abs.startsWith(pack + '/') || !db) return;
		if (!shipped.has(abs)) shipped.set(abs, null);
		idbPut(db, prefix + abs, text === shipped.get(abs) ? undefined : text);
	});

	const planner = new wasmMod.Planner(data, instances, areas);
	if (spells) planner.setSpellNames(spells);
	planner.setPack(JSON.stringify(packFiles));
	rt = {
		planner, packFiles, legsIndex, flights, aids: !!aids, fetchJson, translationsLoaded: false,
		translations: () => fetchText(`bundle/set-${set}-translations.json.gz`),
		loadWorld: async (faction) => {
			const w = await fetchBytes(`bundle/world-${faction.toLowerCase()}.json.gz`);
			planner.setWorld(faction, w, params);
		},
	};
	timings.data = Math.round(performance.now() - tr);

	progress('Compiling the guides…');
	const tc = performance.now();
	ws = new BrowserWorkspace({ dataDir: `${ROOT}/data/forever`, simDir: `${ROOT}/data/sim`, artDir: art ? `${ROOT}/art` : null, sourcesDir: `${ROOT}/data/sources`, log: (m) => console.log(`[planner] ${m}`) }, rt);
	// What the planner started from is the bundle's text: a kept edit shows in changes_list.
	for (const [abs, text] of kept) ws.initial.set(abs, shipped.get(abs) === undefined ? null : shipped.get(abs));
	ws.syncRust();
	timings.compile = Math.round(performance.now() - tc);
	for (const event of ['changed', 'diagnostics', 'routing', 'focus', 'seek', 'play']) ws.on(event, (d) => post({ type: 'event', name: event, data: d }));
	ws.on('changed', () => scheduleHours());
	ws.lintAll();
	timings.boot = Math.round(performance.now() - t0);
	const info = { set, sets: manifest.sets, version: commands.run ? JSON.parse(vfs.readFileSync(`${ROOT}/package.json`, 'utf8')).version : null, packs: ws.packs.map((p) => p.id), kept: kept.length, timings: { ...timings }, bytes: { ...bytes } };
	progress(null);
	return info;
}

// ---------------------------------------------------------------- the simulator's hours, live

function scheduleHours() {
	if (!lastPlay) return;
	clearTimeout(hoursTimer);
	hoursTimer = setTimeout(() => {
		serial(() => ws.simHours(lastPlay))
			.then((h) => post({ type: 'event', name: 'hours', data: { ...h, play: lastPlay } }))
			.catch((err) => post({ type: 'event', name: 'hours', data: { error: String(err.message || err), play: lastPlay } }));
	}, 300);
}

// ---------------------------------------------------------------- commands

// The browser's own commands besides tools/planner/commands.js.
const EXTRA = [
	{
		name: 'sim_hours',
		description: 'The simulator\'s hours for the route from `start` (forge-sim\'s evaluator over forge-judge\'s walk, as `forge judge report` counts them): { chain, hours30, hours60, endLevel, guides: [{ id, start, end, levelStart, levelEnd }], ... }.',
		input: { type: 'object', required: ['start', 'character'], properties: { start: { type: 'string' }, character: { type: 'object' }, choices: { type: 'object' } } },
		mutates: false,
		handler: (a) => ws.simHours(a),
	},
	{
		name: 'changes_export',
		description: 'The guide files this browser changed, zipped (paths as in the pack), with the deleted ones listed: { download: { url, name }, files, deleted }.',
		input: { type: 'object', properties: {} },
		mutates: false,
		handler: () => exportChanges(),
	},
	{
		name: 'bundle_info',
		description: 'The static bundle the planner runs from: the guide sets, the files fetched and their sizes, the load timings (ms).',
		input: { type: 'object', properties: {} },
		mutates: false,
		handler: () => ({ set: setName, timings: { ...timings }, bytes: { ...bytes } }),
	},
];

function exportChanges() {
	const files = [];
	const deleted = [];
	for (const c of ws.changes()) {
		const abs = path.join(ROOT, c.file);
		if (vfs.existsSync(abs)) files.push([c.file, vfs.readFileSync(abs, 'utf8')]);
		else deleted.push(c.file);
	}
	if (deleted.length) files.push(['DELETED.txt', deleted.join('\n') + '\n']);
	const blob = new Blob([zip(files)], { type: 'application/zip' });
	return { download: { url: URL.createObjectURL(blob), name: `polestar-${setName}-changes.zip`, bytes: blob.size }, files: files.length - (deleted.length ? 1 : 0), deleted };
}

function serial(fn) {
	const p = busy.then(fn, fn);
	busy = p.catch(() => {});
	return p;
}

const ctx = {
	clients: () => 1,
	icons: { info: () => ({ ui: rt && rt.iconUi ? rt.iconUi : [], kinds: ['item', 'spell', 'npc', 'ui'], available: true }) },
};

async function run(name, args) {
	const extra = EXTRA.find((c) => c.name === name);
	if (extra) return extra.handler(args || {});
	const c = commands.command(name);
	const call = () => commands.run(ws, name, args, ctx);
	const result = await (c.mutates ? serial(call) : call());
	if (name === 'timeline_get' && args && args.start) {
		lastPlay = { start: args.start, character: args.character, choices: args.choices || {} };
		scheduleHours();
	}
	return result;
}

self.onmessage = async (ev) => {
	const m = ev.data || {};
	if (m.type === 'init') {
		ready = boot(m.set || 'v1');
		ready.then((info) => post({ type: 'ready', info }), (err) => post({ type: 'failed', error: String((err && err.stack) || err) }));
		return;
	}
	if (m.type === 'view') {
		if (ws) ws.setView(m.state);
		return;
	}
	if (m.type === 'describe') {
		post({ type: 'result', id: m.id, ok: true, result: [...commands.describe(), ...EXTRA.map(({ name, description, input, mutates }) => ({ name, description, input, mutates }))] });
		return;
	}
	if (m.type !== 'cmd') return;
	try {
		await ready;
		const result = await run(m.name, m.args);
		post({ type: 'result', id: m.id, ok: true, result: result === undefined ? null : result });
	} catch (err) {
		const known = err instanceof PlannerError;
		if (!known) console.error(`${m.name}:`, err);
		post({ type: 'result', id: m.id, ok: false, error: String((err && err.message) || err), code: known ? err.code : 'error' });
	}
};
