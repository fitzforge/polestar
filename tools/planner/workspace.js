'use strict';
// The planner's workspace: the guide packs it edits, their .guide sources,
// compiled guides, timelines, edits with undo/redo, the full lint and the
// file watch (docs/ARCHITECTURE.md, "Route planner").
// The .guide files stay the only source of truth: every edit is written at
// once, and an external change (an editor, git) is read back and pushed.
//
// Events: 'changed' { files, guides, external, timeline, routed (the routing
// id of a timeline whose walks are all routed now) }, 'diagnostics' { pack },
// 'routing' { id, pending, done } (walks being routed, each second), 'focus',
// 'seek', 'play' (the page's view_* commands).

const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const { EventEmitter } = require('node:events');
const { Worker } = require('node:worker_threads');
const { Diagnostics } = require('../lib/dsl/diag');
const { parseGuide } = require('../lib/dsl/parse');
const { resolveGuide } = require('../lib/dsl/resolve');
const { loadData } = require('../lib/dsl/data');
const { findGuideFiles, writePackDir, OFFICIAL_DIR } = require('../lib/dsl/project');
const { readManifest } = require('../lib/pack/manifest');
const { buildPack, folderIn } = require('../lib/pack/build');
const { Geo } = require('../lib/planner/geo');
const { ROOT, DATA, SOURCES } = require('../lib/paths');

const sha1 = (text) => crypto.createHash('sha1').update(text).digest('hex');
const toPosix = (p) => p.split(path.sep).join('/');

// Writes a guide file whole or not at all: a temporary file beside it (not
// .guide, so the watcher passes it by), renamed over it; through a symlink to
// its target.
function writeAtomic(abs, text) {
	let file = abs;
	try {
		file = fs.realpathSync(abs);
	} catch {
		fs.mkdirSync(path.dirname(abs), { recursive: true });
	}
	const tmp = `${file}.${process.pid}.tmp`;
	try {
		fs.writeFileSync(tmp, text);
		fs.renameSync(tmp, file);
	} catch (err) {
		fs.rmSync(tmp, { force: true });
		throw err;
	}
}

// A file as the planner names it: relative to the repository when inside it, else absolute.
function shownFile(abs) {
	const rel = path.relative(ROOT, abs);
	return rel.startsWith('..') || path.isAbsolute(rel) ? toPosix(abs) : toPosix(rel);
}

function samePath(a, b) {
	const real = (p) => {
		try {
			return fs.realpathSync(p);
		} catch {
			return path.resolve(p);
		}
	};
	return real(a) === real(b);
}

// An error a command reports as { ok: false, error, code }.
class PlannerError extends Error {
	constructor(message, code = 'error') {
		super(message);
		this.code = code;
	}
}

// Lines added and removed from a to b (an LCS over the lines between the
// common head and tail; a count difference when that would be too large).
function lineDiff(a, b) {
	const x = a.split('\n');
	const y = b.split('\n');
	let s = 0;
	while (s < x.length && s < y.length && x[s] === y[s]) s++;
	let ex = x.length;
	let ey = y.length;
	while (ex > s && ey > s && x[ex - 1] === y[ey - 1]) {
		ex--;
		ey--;
	}
	const n = ex - s;
	const m = ey - s;
	if (!n || !m) return { added: m, removed: n };
	if (n * m > 4e7) {
		const count = new Map();
		for (let i = s; i < ex; i++) count.set(x[i], (count.get(x[i]) || 0) + 1);
		let common = 0;
		for (let j = s; j < ey; j++) {
			const c = count.get(y[j]) || 0;
			if (c) {
				common++;
				count.set(y[j], c - 1);
			}
		}
		return { added: m - common, removed: n - common };
	}
	let prev = new Uint32Array(m + 1);
	let cur = new Uint32Array(m + 1);
	for (let i = 1; i <= n; i++) {
		const xi = x[s + i - 1];
		for (let j = 1; j <= m; j++) cur[j] = xi === y[s + j - 1] ? prev[j - 1] + 1 : Math.max(prev[j], cur[j - 1]);
		[prev, cur] = [cur, prev];
	}
	return { added: m - prev[m], removed: n - prev[m] };
}

// Guides by id for routeOf/buildTimeline, compiled when first asked for.
class LazyGuides extends Map {
	constructor(ws) {
		super();
		this.ws = ws;
	}

	get(id) {
		const src = this.ws.byId.get(id);
		return src ? this.ws.compiled(src).guide || undefined : undefined;
	}

	has(id) {
		return this.ws.byId.has(id);
	}
}

const COMPILED_KEYS = ['map', 'x', 'y', 'f', 'r', 'spots', 'spread', 'candidates'];
const TIMELINE_CACHE = 16;

// The lint worker: loads the reference data once, then lints a pack per message.
const LINT_WORKER = `
const { parentPort, workerData } = require('node:worker_threads');
const { buildPack } = require(workerData.build);
const { loadData } = require(workerData.data);
const data = loadData(workerData.dataDir);
parentPort.on('message', ({ seq, target }) => {
	try {
		const built = buildPack(target, { dataDir: workerData.dataDir, cache: { data, contextData: data, diags: [] }, files: false });
		parentPort.postMessage({ seq, diagnostics: built.diag.sorted() });
	} catch (err) {
		parentPort.postMessage({ seq, error: String((err && err.stack) || err) });
	}
});
`;

function shapeDiag(d) {
	const o = { file: d.file ? shownFile(path.resolve(d.file)) : null, line: d.line || 0, severity: d.severity, message: d.message };
	if (d.hint) o.hint = d.hint;
	return o;
}

class Workspace extends EventEmitter {
	// opts: { dataDir, packs: [dir] (other packs, after ours), official (ours,
	// guides/, first; default true), officialDir, simDir, artDir, navDir (the
	// navigation grid, data/local/nav: walks are routed on it; default none),
	// watch, lintDelay, log }
	constructor(opts = {}) {
		super();
		const { dataDir = DATA, packs = [], official = true, officialDir = OFFICIAL_DIR, simDir = path.join(ROOT, 'data', 'sim'), artDir = null, navDir = null, watch = true, lintDelay = 600, log = () => {} } = opts;
		this.dataDir = dataDir;
		this.simDir = simDir;
		this.artDir = artDir;
		this.navDir = navDir ? path.resolve(navDir) : null;
		this.nav = null;
		this.aidsCache = null;
		this.log = log;
		this.lintDelay = lintDelay;
		this.data = loadData(dataDir);
		this.travel = this.data.travel;
		this.sourcesDir = opts.sourcesDir || SOURCES;
		this.flights = undefined; // Map path id -> [[wx, wy], ...] (flightPaths), null when unavailable
		this.geo = new Geo(this.data.mapFrames, this.data.zones);
		this.packs = [];
		const dirs = [...(official ? [officialDir] : []), ...packs];
		for (const dir of dirs) this.addPack(path.resolve(dir));
		if (!this.packs.length) throw new Error('no pack to plan');
		this.sources = new Map(); // abs -> { abs, file, pack, text, hash, id, header }
		this.byId = new Map();
		this.initial = new Map(); // abs -> the text when the planner started (null: no file then)
		for (const p of this.packs) for (const rel of findGuideFiles(p.dir)) this.load(p, path.join(p.dir, rel), true);
		this.reindex();
		this.compileCache = new Map(); // abs -> { hash, guide, diag, ast }
		this.viewCache = new Map(); // abs -> { key, view }
		this.timelines = new Map(); // key -> timeline (insertion order = age)
		this.paramsCache = new Map();
		this.undoStack = [];
		this.redoStack = [];
		this.lintResults = new Map(); // pack id -> { diagnostics, at }
		this.lintVersion = 0;
		this.lintSeq = 0;
		this.lintPending = new Map();
		this.worker = null;
		this.closed = false;
		this.dirtyPacks = new Set();
		this.lintTimer = null;
		this.viewState = null;
		this.watchers = [];
		this.watchTimer = null;
		this.watchPending = new Set();
		if (watch) this.startWatch();
	}

	addPack(dir) {
		if (this.packs.some((p) => samePath(p.dir, dir))) return;
		const official = samePath(dir, OFFICIAL_DIR);
		const { manifest, diags } = readManifest(dir, { official });
		if (!manifest) throw new Error(`${shownFile(dir)}: ${diags.filter((d) => d.severity === 'error').map((d) => d.message).join('; ')}`);
		if (this.packs.some((p) => p.id === manifest.id)) throw new Error(`two packs with the id "${manifest.id}"`);
		this.packs.push({ id: manifest.id, title: manifest.title, dir, official, manifest, diags });
	}

	pack(id) {
		const p = id === undefined || id === null ? this.packs[0] : this.packs.find((x) => x.id === id);
		if (!p) throw new PlannerError(`no pack "${id}" (packs: ${this.packs.map((x) => x.id).join(', ')})`, 'not_found');
		return p;
	}

	// Read one source (its text and header); `start` records it as the starting text.
	load(pack, abs, start = false) {
		const text = fs.readFileSync(abs, 'utf8');
		const src = { abs, file: shownFile(abs), pack, text, hash: sha1(text), id: null, header: {} };
		this.readHeader(src);
		this.sources.set(abs, src);
		if (start) this.initial.set(abs, text);
		else if (!this.initial.has(abs)) this.initial.set(abs, null);
		return src;
	}

	readHeader(src) {
		const ast = parseGuide(src.text, src.file, new Diagnostics());
		src.id = ast && ast.id ? ast.id : null;
		src.header = (ast && ast.header) || {};
	}

	reindex() {
		this.byId = new Map();
		for (const src of this.sources.values()) if (src.id && !this.byId.has(src.id)) this.byId.set(src.id, src);
	}

	source(id) {
		const src = this.byId.get(id);
		if (!src) throw new PlannerError(`no guide "${id}"`, 'not_found');
		return src;
	}

	sourceByFile(file) {
		const abs = path.resolve(ROOT, file);
		const src = this.sources.get(abs) || [...this.sources.values()].find((s) => s.file === file);
		if (src) return src;
		if (this.initial.has(abs)) return { abs, file: shownFile(abs), pack: this.packOf(abs), text: null, hash: null, id: null };
		throw new PlannerError(`no guide file "${file}"`, 'not_found');
	}

	packOf(abs) {
		return this.packs.find((p) => abs.startsWith(p.dir + path.sep)) || null;
	}

	// -> { hash, guide (null when the source has no guide id), diag, ast }, cached by text.
	compiled(src) {
		const hit = this.compileCache.get(src.abs);
		if (hit && hit.hash === src.hash) return hit;
		const diag = new Diagnostics();
		const ast = parseGuide(src.text, src.file, diag);
		let guide = null;
		if (ast && ast.id) {
			ast.source = path.relative(src.pack.dir, src.abs);
			guide = resolveGuide(ast, this.data, diag, { pack: src.pack.id, author: src.pack.manifest.author });
		}
		const out = { hash: src.hash, guide, diag, ast };
		this.compileCache.set(src.abs, out);
		return out;
	}

	// The guides' headers for guides_list.
	list(packId) {
		const pack = packId === undefined || packId === null ? null : this.pack(packId);
		const out = [];
		for (const src of this.sources.values()) {
			if (!src.id || (pack && src.pack !== pack)) continue;
			const h = src.header;
			out.push({
				id: src.id,
				pack: src.pack.id,
				file: src.file,
				title: h.title || src.id,
				faction: h.faction || null,
				races: h.races || null,
				classes: h.classes || null,
				levels: h.levels ? { min: h.levels.min, max: h.levels.max } : null,
				zone: h.zone ? (h.zone.name !== undefined ? h.zone.name : this.geo.zoneName(h.zone.map)) : null,
				category: h.category || 'Leveling',
				folder: h.folder || null,
				next: h.next && h.next.length ? h.next[0] : null,
				nextChoices: h.next && h.next.length > 1 ? h.next.slice() : null,
			});
		}
		return out.sort((a, b) => (a.pack === b.pack ? (a.file < b.file ? -1 : a.file > b.file ? 1 : 0) : this.packs.findIndex((p) => p.id === a.pack) - this.packs.findIndex((p) => p.id === b.pack)));
	}

	// The diagnostics of one file: its own compile's, then the last full lint's (deduplicated).
	diagnosticsOf(src, compiled) {
		const out = [];
		const seen = new Set();
		const add = (d) => {
			const key = `${d.severity}|${d.line}|${d.message}`;
			if (seen.has(key)) return;
			seen.add(key);
			const o = { severity: d.severity, line: d.line || 0, message: d.message };
			if (d.hint) o.hint = d.hint;
			out.push(o);
		};
		for (const d of compiled.diag.sorted()) add(d);
		const lint = this.lintResults.get(src.pack.id);
		if (lint) for (const d of lint.diagnostics) if (d.file === src.file) add(d);
		return out.sort((a, b) => a.line - b.line || (a.severity === b.severity ? 0 : a.severity === 'error' ? -1 : 1));
	}

	// GuideView: the source model with each goal's compiled place, world
	// point and label, and the file's diagnostics.
	view(id) {
		const src = this.source(id);
		const key = `${src.hash}|${this.lintVersion}`;
		const hit = this.viewCache.get(src.abs);
		if (hit && hit.key === key) return hit.view;
		const { model } = require('../lib/planner/source');
		const { goalLabel } = require('../lib/planner/timeline');
		const c = this.compiled(src);
		const m = model(src.text, src.file);
		const byLine = new Map();
		if (c.guide) for (const st of c.guide.steps) for (const g of st.goals) byLine.set(g._line, g);
		const header = {};
		for (const [k, v] of Object.entries(m.header || {})) header[k] = v;
		const view = {
			id: src.id,
			pack: src.pack.id,
			file: src.file,
			hash: src.hash,
			coords: m.coords,
			header,
			steps: m.steps.map((st) => ({
				index: st.index,
				line: st.line,
				end: st.end,
				title: st.title === undefined ? null : st.title,
				tip: st.tip === undefined ? null : st.tip,
				only: st.only === undefined ? null : st.only,
				zone: st.zone || null,
				directives: st.directives || [],
				goals: st.goals.map((g) => {
					const cg = byLine.get(g.line) || null;
					let compiled = null;
					let world = null;
					if (cg) {
						compiled = {};
						for (const k of COMPILED_KEYS) if (cg[k] !== undefined) compiled[k] = cg[k];
						if (cg.x !== undefined && cg.map !== undefined) {
							const w = this.geo.toWorld(cg.map, cg.x, cg.y, cg.f === 'e' ? 'e' : 'l');
							if (w) world = w;
						}
					}
					return {
						line: g.line,
						verb: g.verb,
						raw: g.raw,
						fields: g.fields,
						label: cg ? goalLabel(cg, this.geo) : g.raw.trim(),
						explicit: !!(g.fields && g.fields.explicitCoords),
						compiled,
						world,
					};
				}),
			})),
			diagnostics: this.diagnosticsOf(src, c),
		};
		this.viewCache.set(src.abs, { key, view });
		return view;
	}

	params(cls) {
		const key = String(cls || '').toUpperCase();
		if (!this.paramsCache.has(key)) {
			const { loadParams } = require('../lib/planner/timeline');
			this.paramsCache.set(key, loadParams({ simDir: this.simDir, cls: key }));
		}
		return this.paramsCache.get(key);
	}

	route({ start, character, choices = {} }) {
		const { routeOf } = require('../lib/planner/timeline');
		this.source(start);
		return routeOf({ guides: new LazyGuides(this), start, character, choices: choices || {} });
	}

	// The points each taxi leg of travel.json flies through (buildTimeline
	// flightPaths): the Era client's TaxiPathNode of the build travel.json was
	// made from (data/sources/wago/<build>/TaxiPathNode.csv, cached by
	// `travel build`), read once; a path with a teleport or a continent change
	// is left out (drawn straight). null when the table is not cached.
	flightPaths() {
		if (this.flights !== undefined) return this.flights;
		this.flights = null;
		const build = this.travel && this.travel.build;
		const file = build ? path.join(this.sourcesDir, 'wago', String(build), 'TaxiPathNode.csv') : null;
		if (!file || !fs.existsSync(file)) return null;
		try {
			const { parseCsv } = require('../lib/data/csv');
			const { pathPoints } = require('../lib/travel/taxi');
			const { isJump } = require('../lib/travel/geo');
			const wanted = new Set(((this.travel.taxi && this.travel.taxi.legs) || []).map((l) => Number(l.path)));
			const all = pathPoints(parseCsv(fs.readFileSync(file, 'utf8')).filter((r) => wanted.has(Number(r.PathID))));
			const out = new Map();
			for (const [id, pts] of all) {
				if (pts.length < 2 || pts.some((q, i) => i > 0 && isJump(pts[i - 1], q))) continue;
				out.set(id, pts.map((q) => [Math.round(q.wx * 10) / 10, Math.round(q.wy * 10) / 10]));
			}
			this.flights = out;
		} catch (err) {
			this.log(`flight paths from ${file}: ${err.message || err}`);
		}
		return this.flights;
	}

	// The terrain routes (tools/planner/navpool.js), opened when first asked
	// for; null without a nav directory.
	navRoutes() {
		if (!this.navDir || this.closed) return null;
		if (!this.nav) {
			const { NavRoutes } = require('./navpool');
			this.nav = new NavRoutes({ dir: this.navDir, log: this.log });
		}
		return this.nav;
	}

	// { available, build, continents, aids (an aids.json is there) }
	navInfo() {
		const nav = this.navRoutes();
		const info = nav ? nav.info() : { available: false, build: null, continents: [] };
		return { ...info, aids: !!(this.navDir && fs.existsSync(path.join(this.navDir, 'aids.json'))) };
	}

	// The arrow aids (nav aids: crossings schema 1, Era map percent) as world
	// points: { source, build, crossings: [{ id, a, b, ab, ba, oneWay }],
	// open: [{ a, b, aName, bName, c, oneWay }], chains: [{ id, name, open, c,
	// nodes: [{ c, wx, wy, r, caption, back }] }] } (ends { map, x, y, c, wx,
	// wy, r }); null without the file. Points without a map frame are left out.
	navAids() {
		if (!this.navDir) return null;
		const file = path.join(this.navDir, 'aids.json');
		let stat;
		try {
			stat = fs.statSync(file);
		} catch {
			return null;
		}
		if (this.aidsCache && this.aidsCache.mtime === stat.mtimeMs) return this.aidsCache.value;
		const doc = JSON.parse(fs.readFileSync(file, 'utf8'));
		const pt = (p) => {
			const w = p && Number.isFinite(p.x) && Number.isFinite(p.y) ? this.geo.toWorld(p.map, p.x, p.y, 'e') : null;
			return w ? { map: p.map, x: p.x, y: p.y, c: w.c, wx: Math.round(w.wx * 10) / 10, wy: Math.round(w.wy * 10) / 10, r: p.radius || null } : null;
		};
		const value = { source: doc.source || null, build: doc.build || null, crossings: [], open: [], chains: [] };
		for (const e of doc.crossings || []) {
			const a = pt(e.a);
			const b = pt(e.b);
			if (a && b) value.crossings.push({ id: e.id || null, a, b, ab: e.ab || null, ba: e.ba || null, oneWay: e.oneWay === true });
		}
		for (const e of doc.open || []) {
			const f = this.geo.frame(e.a, 'e');
			value.open.push({ a: e.a, b: e.b, aName: this.geo.zoneName(e.a), bName: this.geo.zoneName(e.b), c: f ? f.c : null, oneWay: e.oneWay === true });
		}
		for (const ch of doc.chains || []) {
			const nodes = (ch.nodes || []).map((n) => {
				const w = pt(n);
				return w ? { c: w.c, wx: w.wx, wy: w.wy, r: w.r, caption: n.caption || null, back: n.back || null } : null;
			}).filter(Boolean);
			if (nodes.length >= 2) value.chains.push({ id: ch.id || null, name: ch.name || null, open: ch.open || 'mouth', c: nodes[0].c, nodes });
		}
		this.aidsCache = { mtime: stat.mtimeMs, value };
		return value;
	}

	// The Timeline of the route from `start`, cached by the chain's texts, the
	// arguments and the nav build. Walk legs are routed on the grid
	// (navpool.js): a build with legs not in the route cache yet plays them
	// as straight lines (marked, `routing: { pending, done }` counting them
	// live) and has the pool compute them; when they are all answered the
	// entry is dropped and 'changed' { timeline: true, routed: id } tells the
	// page to ask again (that build finds them all).
	// optional: play optional goals too (false: buildTimeline skips them).
	timeline({ start, character, choices = {}, startLevel = null, optional = false }) {
		const { buildTimeline } = require('../lib/planner/timeline');
		const ids = this.route({ start, character, choices });
		const nav = this.navRoutes();
		const info = nav ? nav.info() : null;
		const build = info && info.available ? info.build : null;
		const key = JSON.stringify([ids.map((id) => (this.byId.get(id) || {}).hash || null), character, choices || {}, startLevel, !!optional, build]);
		if (this.timelines.has(key)) {
			const t = this.timelines.get(key);
			this.timelines.delete(key);
			this.timelines.set(key, t);
			return t;
		}
		const provider = build ? nav.provider() : null;
		const t0 = Date.now();
		const t = buildTimeline({
			guides: new LazyGuides(this), data: this.data, geo: this.geo, params: this.params(character.cls), travel: this.travel,
			start, character, choices: choices || {}, startLevel: startLevel === undefined ? null : startLevel, optional: !!optional,
			routes: provider ? provider.routes : null, nav: build ? { build } : null, flightPaths: this.flightPaths(),
		});
		const ms = Date.now() - t0;
		if (provider && provider.misses.size) {
			const job = nav.compute(provider.misses);
			t.routing = job.progress;
			this.log(`timeline ${start}: ${ms} ms; routing ${job.progress.pending} legs`);
			const tick = setInterval(() => this.emit('routing', { ...job.progress }), 1000);
			tick.unref();
			job.promise.then(() => {
				clearInterval(tick);
				if (this.timelines.get(key) === t) this.timelines.delete(key);
				if (!this.closed) {
					this.emit('routing', { ...job.progress });
					this.emit('changed', { files: [], guides: [], external: false, timeline: true, routed: job.progress.id });
				}
			});
		} else if (build) this.log(`timeline ${start}: ${ms} ms; routed ${t.totals.routed} of ${t.totals.legs} legs`);
		this.timelines.set(key, t);
		while (this.timelines.size > TIMELINE_CACHE) this.timelines.delete(this.timelines.keys().next().value);
		return t;
	}

	// Write a source's new text (ours: the watcher ignores it by hash).
	write(src, text) {
		writeAtomic(src.abs, text);
		src.text = text;
		src.hash = sha1(text);
		this.readHeader(src);
		this.reindex();
	}

	changed(srcs, external = false) {
		const files = [...new Set(srcs.map((s) => s.file))];
		const guides = [...new Set(srcs.map((s) => s.id).filter(Boolean))];
		for (const s of srcs) if (s.pack) this.markDirty(s.pack);
		this.emit('changed', { files, guides, external });
	}

	// Apply source edit operations to a guide; refused when `hash` is not the file's.
	// Each op's `line` and `step` name goals and steps of the text at `hash`:
	// they are followed through the earlier ops of the batch.
	edit({ id, hash, ops, label = null }) {
		const { apply, EditError } = require('../lib/planner/source');
		const src = this.source(id);
		this.syncFromDisk(src);
		if (hash !== src.hash) throw new PlannerError(`${src.file} changed since hash ${hash} (now ${src.hash}): reload the guide and edit again`, 'stale');
		const before = src.text;
		let text = before;
		let select = null;
		// Goal lines the ops name (as at `hash`) and where each is now (null: deleted).
		const named = [...new Set(ops.map((op) => op && op.line).filter((ln) => Number.isInteger(ln)))];
		let track = named.slice();
		// Step index at `hash` -> now (null: deleted); null while no step op changed them.
		let steps = null;
		ops.forEach((op0, k) => {
			const op = op0 && typeof op0 === 'object' ? { ...op0 } : op0;
			const what = `op ${k + 1} (${op && op.op})`;
			if (op && Number.isInteger(op.line)) {
				op.line = track[named.indexOf(op.line)];
				if (op.line === null) throw new PlannerError(`${what}: the goal on line ${op0.line} was deleted by an earlier op of the batch`, 'bad_args');
			}
			if (op && steps && op.step !== undefined && op.op !== 'insertStep') {
				if (!Number.isInteger(op.step) || op.step < 0 || op.step >= steps.length) throw new PlannerError(`${what}: no step ${op0.step} (the guide had ${steps.length})`, 'bad_args');
				op.step = steps[op0.step];
				if (op.step === null) throw new PlannerError(`${what}: step ${op0.step} was deleted by an earlier op of the batch`, 'bad_args');
			}
			let r;
			try {
				r = apply(text, op, src.file, track);
			} catch (err) {
				if (err instanceof EditError) throw new PlannerError(ops.length > 1 ? `${what}: ${err.message}` : err.message, 'edit');
				throw err;
			}
			text = r.text;
			track = r.track;
			if (r.steps) steps = steps ? steps.map((s) => (s === null ? null : r.steps[s])) : r.steps.slice();
			if (r.select) select = r.select;
		});
		if (text !== before) {
			this.write(src, text);
			this.undoStack.push({ abs: src.abs, file: src.file, before, after: text, label: label || describeOps(ops) });
			this.redoStack = [];
			this.changed([src]);
		}
		return { guide: this.view(src.id), select };
	}

	// The disk text wins over the cached one (an external change not yet seen by the watcher).
	syncFromDisk(src) {
		let text;
		try {
			text = fs.readFileSync(src.abs, 'utf8');
		} catch {
			throw new PlannerError(`${src.file} no longer exists`, 'not_found');
		}
		if (sha1(text) === src.hash) return false;
		src.text = text;
		src.hash = sha1(text);
		this.readHeader(src);
		this.reindex();
		this.changed([src], true);
		return true;
	}

	// opts.drop: a conflicting top entry is dropped instead of refused.
	undo({ drop = false } = {}) {
		return this.step(this.undoStack, this.redoStack, 'before', 'after', 'undo', drop);
	}

	redo({ drop = false } = {}) {
		return this.step(this.redoStack, this.undoStack, 'after', 'before', 'redo', drop);
	}

	// An entry's text null = no file (a deleted guide written back by revert).
	step(from, to, want, expect, what, drop = false) {
		const e = from[from.length - 1];
		if (!e) throw new PlannerError(`nothing to ${what}`, 'empty');
		let disk = null;
		try {
			disk = fs.readFileSync(e.abs, 'utf8');
		} catch {
			disk = null;
		}
		if (disk !== e[expect]) {
			if (!drop) throw new PlannerError(`cannot ${what} "${e.label}": ${e.file} changed since (it no longer holds the text the edit left); edit_${what} with drop: true drops it from the history`, 'conflict');
			from.pop();
			return { file: e.file, label: e.label, dropped: true, guide: null };
		}
		if (e[want] === null) {
			fs.rmSync(e.abs);
			from.pop();
			to.push(e);
			const gone = this.sources.get(e.abs) || { abs: e.abs, file: e.file, pack: this.packOf(e.abs), id: null };
			this.sources.delete(e.abs);
			this.reindex();
			this.changed([{ ...gone, text: null }]);
			return { file: e.file, label: e.label, dropped: false, guide: null };
		}
		if (disk === null) writeAtomic(e.abs, e[want]);
		const src = this.sources.get(e.abs) || this.load(this.packOf(e.abs), e.abs);
		this.write(src, e[want]);
		from.pop();
		to.push(e);
		this.changed([src]);
		return { file: src.file, label: e.label, dropped: false, guide: src.id ? this.view(src.id) : null };
	}

	changes() {
		const out = [];
		for (const [abs, start] of this.initial) {
			const src = this.sources.get(abs);
			const now = src ? src.text : null;
			if (now === start) continue;
			const d = lineDiff(start === null ? '' : start, now === null ? '' : now);
			out.push({ file: src ? src.file : shownFile(abs), guide: src ? src.id : null, added: d.added, removed: d.removed });
		}
		return out.sort((a, b) => (a.file < b.file ? -1 : a.file > b.file ? 1 : 0));
	}

	// Put a file back to its starting text (an undoable edit); a guide deleted
	// since is written back (undo deletes it again).
	revert(file) {
		const found = this.sourceByFile(file);
		const start = this.initial.get(found.abs);
		if (start === undefined) throw new PlannerError(`no guide file "${file}"`, 'not_found');
		if (start === null) throw new PlannerError(`${found.file} did not exist when the planner started; delete it yourself`, 'conflict');
		const label = `Revert ${found.file}`;
		if (!fs.existsSync(found.abs)) {
			writeAtomic(found.abs, start);
			const src = this.load(found.pack, found.abs);
			this.reindex();
			this.undoStack.push({ abs: src.abs, file: src.file, before: null, after: start, label });
			this.redoStack = [];
			this.changed([src]);
			return { file: src.file, guide: src.id ? this.view(src.id) : null };
		}
		const src = this.sources.get(found.abs) || this.load(found.pack, found.abs);
		this.syncFromDisk(src);
		if (src.text === start) return { file: src.file, guide: src.id ? this.view(src.id) : null };
		const before = src.text;
		this.write(src, start);
		this.undoStack.push({ abs: src.abs, file: src.file, before, after: start, label });
		this.redoStack = [];
		this.changed([src]);
		return { file: src.file, guide: src.id ? this.view(src.id) : null };
	}

	// buildPack's pack: another pack reads ours as context.
	buildTarget(p) {
		const ours = this.packs.find((x) => x.official);
		return {
			dir: p.dir, manifest: p.manifest, official: p.official, diags: p.diags,
			contextDir: p.official ? null : ours ? ours.dir : null,
			contextDataDir: p.official ? null : this.dataDir,
		};
	}

	build(p, files) {
		return buildPack(this.buildTarget(p), { dataDir: this.dataDir, cache: { data: this.data, contextData: this.data, diags: [] }, files });
	}

	// The full lint of a pack in the lint worker (a full compile blocks for
	// seconds): -> [{ file, line, severity, message, hint }], files named like GuideView.
	lint(packId) {
		const p = this.pack(packId);
		const worker = this.lintWorker();
		const seq = ++this.lintSeq;
		return new Promise((resolve, reject) => {
			this.lintPending.set(seq, { resolve, reject });
			worker.postMessage({ seq, target: this.buildTarget(p) });
		}).then((list) => {
			const diagnostics = list.map(shapeDiag);
			this.lintResults.set(p.id, { diagnostics, at: Date.now() });
			this.lintVersion++;
			return diagnostics;
		});
	}

	lintWorker() {
		if (this.worker) return this.worker;
		const w = new Worker(LINT_WORKER, { eval: true, workerData: { build: require.resolve('../lib/pack/build'), data: require.resolve('../lib/dsl/data'), dataDir: this.dataDir } });
		w.unref();
		w.on('message', (m) => {
			const p = this.lintPending.get(m.seq);
			if (!p) return;
			this.lintPending.delete(m.seq);
			if (m.error) p.reject(new Error(m.error));
			else p.resolve(m.diagnostics);
		});
		const fail = (err) => {
			if (this.worker === w) this.worker = null;
			for (const p of this.lintPending.values()) p.reject(err);
			this.lintPending.clear();
		};
		w.on('error', fail);
		w.on('exit', (code) => fail(new Error(`the lint worker stopped (exit ${code})`)));
		this.worker = w;
		return w;
	}

	// pack_compile: the addon folder, like `compile` (ours -> addon/<folder>, another -> <pack>/dist/<folder>).
	compilePack(packId) {
		const p = this.pack(packId);
		const outDir = p.official ? folderIn(path.join(ROOT, 'addon'), p.manifest.folder) : folderIn(path.join(p.dir, 'dist'), p.manifest.folder);
		const built = this.build(p, true);
		if (!built.diag.hasErrors()) {
			try {
				writePackDir(outDir, built.files);
			} catch (e) {
				built.diag.error(shownFile(outDir), 0, e.message);
			}
		}
		const ok = !built.diag.hasErrors();
		const diagnostics = built.diag.sorted().map(shapeDiag);
		return { ok, errors: built.diag.errors.length, warnings: built.diag.warnings.length, outDir: ok ? shownFile(outDir) : null, guides: ok ? built.guides.length : 0, diagnostics };
	}

	// The full lint of a pack after edits, debounced; another pack reads ours, so it follows.
	markDirty(pack) {
		this.dirtyPacks.add(pack.id);
		if (pack.official) for (const p of this.packs) this.dirtyPacks.add(p.id);
		this.scheduleLint();
	}

	scheduleLint() {
		clearTimeout(this.lintTimer);
		this.lintTimer = setTimeout(async () => {
			this.lintTimer = null;
			const ids = [...this.dirtyPacks];
			this.dirtyPacks.clear();
			for (const id of ids) {
				if (!this.packs.some((p) => p.id === id)) continue;
				try {
					await this.lint(id);
					this.emit('diagnostics', { pack: id });
				} catch (err) {
					if (!this.closed) this.log(`lint of ${id} failed: ${err.message || err}`);
				}
			}
		}, this.lintDelay);
		this.lintTimer.unref();
	}

	// Lint every pack soon (the planner's start).
	lintAll() {
		for (const p of this.packs) this.dirtyPacks.add(p.id);
		this.scheduleLint();
	}

	startWatch() {
		for (const p of this.packs) {
			try {
				const w = fs.watch(p.dir, { recursive: true }, (type, name) => {
					if (!name) return;
					const rel = toPosix(String(name));
					if (!rel.endsWith('.guide') || rel.startsWith('dist/') || rel.startsWith('drafts/') || rel.split('/').some((part) => part.startsWith('.'))) return;
					this.watchPending.add(path.join(p.dir, rel));
					clearTimeout(this.watchTimer);
					this.watchTimer = setTimeout(() => this.flushWatch(), 120);
				});
				w.on('error', (err) => this.log(`watching ${p.dir} failed: ${err.message}`));
				this.watchers.push(w);
			} catch (err) {
				this.log(`cannot watch ${p.dir}: ${err.message}`);
			}
		}
	}

	// External changes: re-read each named file; ours (same hash) are ignored.
	flushWatch() {
		this.watchTimer = null;
		const touched = [];
		for (const abs of this.watchPending) {
			const pack = this.packOf(abs);
			if (!pack) continue;
			const src = this.sources.get(abs);
			let text = null;
			try {
				text = fs.readFileSync(abs, 'utf8');
			} catch {
				text = null;
			}
			if (text === null) {
				if (src) {
					this.sources.delete(abs);
					touched.push({ ...src, text: null });
				}
				continue;
			}
			if (src && sha1(text) === src.hash) continue;
			if (src) {
				src.text = text;
				src.hash = sha1(text);
				this.readHeader(src);
				touched.push(src);
			} else touched.push(this.load(pack, abs));
		}
		this.watchPending.clear();
		if (!touched.length) return;
		this.reindex();
		this.changed(touched, true);
	}

	setView(state) {
		this.viewState = { ...state, at: Date.now() };
		return this.viewState;
	}

	close() {
		this.closed = true;
		if (this.worker) this.worker.terminate();
		this.worker = null;
		if (this.nav) this.nav.close();
		this.nav = null;
		clearTimeout(this.lintTimer);
		clearTimeout(this.watchTimer);
		for (const w of this.watchers) w.close();
		this.watchers = [];
	}
}

const OP_LABELS = {
	setCoords: 'Move waypoint', setRadius: 'Set radius', setGoal: 'Edit goal', insertGoal: 'Add goal', deleteGoal: 'Delete goal', moveGoal: 'Move goal',
	setStep: 'Edit step', insertStep: 'Add step', deleteStep: 'Delete step', moveStep: 'Move step', setHeader: 'Edit header',
};

function describeOps(ops) {
	const names = [...new Set(ops.map((o) => OP_LABELS[o.op] || o.op))];
	return names.join(', ') || 'Edit';
}

module.exports = { Workspace, PlannerError, lineDiff, shownFile, sha1 };
