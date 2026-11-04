// The planner's Workspace (tools/planner/workspace.js) in the browser: the same class, its files in the
// worker's in-memory tree (shims/fs.js), with the Rust parts from forge-wasm where Rust has them:
// - compiled(): each guide parsed and resolved by the Rust compiler (the JS parse stays for the source
//   model the editor edits: tools/lib/planner/source.js has no Rust equivalent);
// - lint(), compilePack(): the Rust pack compile (lint; the addon files, zipped for download);
// - simHours(): the simulator's hours for a start (forge-judge's walk with forge-sim's evaluator);
// - navRoutes(): the walk store's legs per continent (static files, fetched when a timeline first walks
//   on that continent) instead of the Node route pool; a leg the store lacks plays straight, marked.

import path from 'path';
import { Workspace } from '../../../../../tools/planner/workspace.js';
import { Diagnostics } from '../../../../../tools/lib/dsl/diag.js';
import { parseGuide } from '../../../../../tools/lib/dsl/parse.js';
import { profileKey } from '../../../../../tools/planner/navpool.js';
import { zip } from './zip.js';

// Hidden (non-enumerable) properties come from the Rust JSON as "\u0000<name>" keys.
function unhide(v) {
	if (Array.isArray(v)) {
		for (const x of v) if (x && typeof x === 'object') unhide(x);
		return v;
	}
	for (const k of Object.keys(v)) {
		const x = v[k];
		if (x && typeof x === 'object') unhide(x);
		if (k.charCodeAt(0) === 0) {
			delete v[k];
			Object.defineProperty(v, k.slice(1), { value: x, enumerable: false, configurable: true, writable: true });
		}
	}
	return v;
}

function diagnosticsOf(list) {
	const d = new Diagnostics();
	for (const x of list) (x.severity === 'error' ? d.error : d.warn).call(d, x.file, x.line, x.message, x.hint);
	return d;
}

const q = (v) => Math.round(v);
const endKey = (e) => `${e.c}:${q(e.wx)}:${q(e.wy)}${e.z != null ? `:${q(e.z)}` : ''}`;

// The walk store's legs (nav/legs/<c>.json.gz), fetched per continent; navpool's provider/compute shape.
class StoreLegs {
	constructor(index, fetchJson) {
		this.index = index;
		this.fetchJson = fetchJson;
		this.legs = new Map(); // c -> Map key -> route
		this.loading = new Map(); // c -> promise
		this.missed = new Map(); // key -> { ok: false, reason }
		this.seq = 0;
	}

	info() {
		const cs = this.index ? Object.keys(this.index.continents || {}).map(Number) : [];
		return { available: cs.length > 0, build: cs.length ? this.index.build : null, continents: cs };
	}

	provider() {
		const covered = new Set(this.info().continents);
		const misses = new Map();
		const routes = (a, b, profile) => {
			if (!covered.has(a.c) || a.c !== b.c) return { ok: false, reason: `no navigation grid for continent ${a.c}` };
			const k = `${endKey(a)}>${endKey(b)}|${profileKey(profile)}`;
			const legs = this.legs.get(a.c);
			const hit = (legs && legs.get(k)) || this.missed.get(k);
			if (hit) return hit;
			if (legs) {
				const r = { ok: false, reason: 'not in the walk store (the browser has no router)' };
				this.missed.set(k, r);
				return r;
			}
			if (!misses.has(k)) misses.set(k, { k, c: a.c });
			return null;
		};
		return { routes, misses };
	}

	// The continents the misses lie on, fetched; then every miss has an answer (a stored leg or missed).
	compute(misses) {
		const progress = { id: ++this.seq, pending: misses.size, done: 0 };
		const cs = [...new Set([...misses.values()].map((m) => m.c))];
		const promise = Promise.all(cs.map((c) => this.load(c))).then(() => {
			progress.done = progress.pending;
			progress.pending = 0;
		});
		return { progress, promise };
	}

	load(c) {
		if (this.legs.has(c)) return Promise.resolve();
		if (!this.loading.has(c)) {
			const e = this.index.continents[c];
			this.loading.set(c, this.fetchJson(`nav/legs/${e.file}`).then((obj) => {
				this.legs.set(c, new Map(Object.entries(obj)));
			}).catch((err) => {
				this.legs.set(c, new Map());
				throw err;
			}));
		}
		return this.loading.get(c);
	}

	close() {}
}

export class BrowserWorkspace extends Workspace {
	// rt: { planner (forge-wasm Planner), legsIndex, flights, aids (bool), fetchJson, translations () -> Promise<text> }
	constructor(opts, rt) {
		super({ ...opts, watch: false });
		this.rt = rt;
		this.rtJson = new Map(); // abs -> { hash, json } (the Rust compile's output, parsed when asked)
		this.storeLegs = rt.legsIndex ? new StoreLegs(rt.legsIndex, rt.fetchJson) : null;
	}

	rel(src) {
		return path.relative(src.pack.dir, src.abs);
	}

	// The Rust compile of a source (kept in the WASM planner for the hours, the lint and the addon).
	rustCompile(src) {
		const hit = this.rtJson.get(src.abs);
		if (hit && hit.hash === src.hash) return hit.json;
		const json = this.rt.planner.compileGuide(this.rel(src), src.file, src.text);
		this.rtJson.set(src.abs, { hash: src.hash, json });
		return json;
	}

	// Every source compiled in Rust (the hours read them all); deleted ones dropped.
	syncRust() {
		for (const src of this.sources.values()) this.rustCompile(src);
		for (const abs of [...this.rtJson.keys()]) {
			if (this.sources.has(abs)) continue;
			const pack = this.packOf(abs);
			if (pack) this.rt.planner.removeGuide(path.relative(pack.dir, abs));
			this.rtJson.delete(abs);
		}
	}

	compiled(src) {
		const hit = this.compileCache.get(src.abs);
		if (hit && hit.hash === src.hash) return hit;
		const r = JSON.parse(this.rustCompile(src));
		const ast = parseGuide(src.text, src.file, new Diagnostics());
		if (ast && ast.id) ast.source = this.rel(src);
		const out = { hash: src.hash, guide: r.guide ? unhide(r.guide) : null, diag: diagnosticsOf(r.diagnostics), ast };
		this.compileCache.set(src.abs, out);
		return out;
	}

	shape(list, p) {
		const shown = (f) => (!f ? null : f.includes('/') ? f : `${path.relative('/repo', p.dir)}/${f}`);
		return list.map((d) => {
			const o = { file: shown(d.file), line: d.line || 0, severity: d.severity, message: d.message };
			if (d.hint) o.hint = d.hint;
			return o;
		});
	}

	ours(p) {
		if (!p.official) throw new Error(`pack "${p.id}": the browser planner holds one pack, ours`);
	}

	async lint(packId) {
		const p = this.pack(packId);
		this.ours(p);
		await new Promise((r) => setTimeout(r, 0));
		this.syncRust();
		const diagnostics = this.shape(JSON.parse(this.rt.planner.lint()), p);
		this.lintResults.set(p.id, { diagnostics, at: Date.now() });
		this.lintVersion++;
		return diagnostics;
	}

	// The addon folder as a zip the page downloads (the browser cannot write addon/).
	async compilePack(packId) {
		const p = this.pack(packId);
		this.ours(p);
		if (!this.rt.translationsLoaded) {
			this.rt.planner.setPack(JSON.stringify({ ...this.rt.packFiles, translations: await this.rt.translations() }));
			this.rt.translationsLoaded = true;
		}
		this.syncRust();
		const r = JSON.parse(this.rt.planner.packFiles());
		const diagnostics = this.shape(r.diagnostics, p);
		const errors = diagnostics.filter((d) => d.severity === 'error').length;
		const ok = !errors && !!r.files;
		let download = null;
		if (ok) {
			const folder = p.manifest.folder;
			const entries = r.files.map(([name, c]) => [name.startsWith('../') ? name.slice(3) : `${folder}/${name}`, typeof c === 'string' ? c : Uint8Array.from(atob(c.b64), (ch) => ch.charCodeAt(0))]);
			const blob = new Blob([zip(entries)], { type: 'application/zip' });
			download = { url: URL.createObjectURL(blob), name: `${folder}.zip`, bytes: blob.size, files: entries.length };
		}
		const guides = ok ? [...this.sources.values()].filter((s) => s.id && s.pack === p).length : 0;
		return { ok, errors, warnings: diagnostics.length - errors, outDir: ok ? `${p.manifest.folder}.zip (download)` : null, guides, diagnostics, download };
	}

	// The simulator's hours for the route the timeline plays (forge-wasm: report's numbers).
	async simHours({ start, character, choices = {} }) {
		const faction = character.faction;
		if (!this.rt.planner.hasWorld(faction)) await this.rt.loadWorld(faction);
		this.syncRust();
		const ids = this.route({ start, character, choices });
		const t0 = performance.now();
		const h = JSON.parse(this.rt.planner.hours(faction, character.race, character.cls || '', JSON.stringify(ids)));
		h.ms = Math.round(performance.now() - t0);
		return h;
	}

	navRoutes() {
		return this.storeLegs;
	}

	navInfo() {
		const info = this.storeLegs ? this.storeLegs.info() : { available: false, build: null, continents: [] };
		return { ...info, aids: !!this.rt.aids, store: true };
	}

	flightPaths() {
		const f = this.rt.flights;
		return f ? (id) => f[String(id)] || null : null;
	}

	startWatch() {}
}
