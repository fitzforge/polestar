// node:fs for the browser planner's worker: an in-memory file tree (the bundle's files under /repo),
// synchronous like the planner's code expects. Writes call the `onWrite` hook (the worker keeps the
// guide files in IndexedDB).

const files = new Map(); // abs -> string | Uint8Array
const dirs = new Set(['/']);
let hook = null;
let clock = 1;
const mtimes = new Map();

const norm = (p) => {
	const parts = [];
	for (const s of String(p).split('/')) {
		if (!s || s === '.') continue;
		if (s === '..') parts.pop();
		else parts.push(s);
	}
	return '/' + parts.join('/');
};
const parent = (p) => p.slice(0, p.lastIndexOf('/')) || '/';

function addDirs(p) {
	for (let d = parent(p); !dirs.has(d); d = parent(d)) dirs.add(d);
}

function enoent(p, op) {
	const e = new Error(`ENOENT: no such file or directory, ${op} '${p}'`);
	e.code = 'ENOENT';
	return e;
}

export function mount(entries) {
	for (const [p, v] of entries) {
		const a = norm(p);
		files.set(a, v);
		mtimes.set(a, clock++);
		addDirs(a);
	}
}

export function onWrite(fn) {
	hook = fn;
}

export function readFileSync(p, opts) {
	const a = norm(p);
	if (!files.has(a)) throw enoent(p, 'open');
	const v = files.get(a);
	const enc = typeof opts === 'string' ? opts : opts && opts.encoding;
	if (enc) return typeof v === 'string' ? v : new TextDecoder().decode(v);
	return typeof v === 'string' ? new TextEncoder().encode(v) : v;
}

export function writeFileSync(p, data) {
	const a = norm(p);
	files.set(a, typeof data === 'string' ? data : data instanceof Uint8Array ? data : String(data));
	mtimes.set(a, clock++);
	addDirs(a);
	if (hook && !a.endsWith('.tmp')) hook(a, files.get(a));
}

export function existsSync(p) {
	const a = norm(p);
	return files.has(a) || dirs.has(a);
}

export function statSync(p, opts) {
	const a = norm(p);
	const isFile = files.has(a);
	if (!isFile && !dirs.has(a)) {
		if (opts && opts.throwIfNoEntry === false) return undefined;
		throw enoent(p, 'stat');
	}
	const v = files.get(a);
	return { isFile: () => isFile, isDirectory: () => !isFile, isSymbolicLink: () => false, mtimeMs: mtimes.get(a) || 0, size: isFile ? (typeof v === 'string' ? v.length : v.byteLength) : 0 };
}
export const lstatSync = statSync;

export function realpathSync(p) {
	const a = norm(p);
	if (!files.has(a) && !dirs.has(a)) throw enoent(p, 'realpath');
	return a;
}
realpathSync.native = realpathSync;

export function readdirSync(p, opts) {
	const a = norm(p);
	if (!dirs.has(a)) throw enoent(p, 'scandir');
	const pre = a === '/' ? '/' : a + '/';
	const names = new Map();
	for (const f of files.keys()) if (f.startsWith(pre) && !f.slice(pre.length).includes('/')) names.set(f.slice(pre.length), true);
	for (const d of dirs) if (d !== a && d.startsWith(pre) && !d.slice(pre.length).includes('/')) names.set(d.slice(pre.length), false);
	const sorted = [...names.keys()].sort();
	if (opts && opts.withFileTypes) return sorted.map((name) => ({ name, isFile: () => names.get(name), isDirectory: () => !names.get(name), isSymbolicLink: () => false }));
	return sorted;
}

export function renameSync(from, to) {
	const a = norm(from);
	const b = norm(to);
	if (!files.has(a)) throw enoent(from, 'rename');
	files.set(b, files.get(a));
	files.delete(a);
	mtimes.set(b, clock++);
	addDirs(b);
	if (hook) hook(b, files.get(b));
}

export function rmSync(p, opts) {
	const a = norm(p);
	if (files.has(a)) {
		files.delete(a);
		if (hook && !a.endsWith('.tmp')) hook(a, null);
		return;
	}
	if (dirs.has(a) && opts && opts.recursive) {
		for (const f of [...files.keys()]) if (f.startsWith(a + '/')) files.delete(f);
		for (const d of [...dirs]) if (d === a || d.startsWith(a + '/')) dirs.delete(d);
		return;
	}
	if (!(opts && opts.force)) throw enoent(p, 'rm');
}
export const unlinkSync = (p) => rmSync(p);

export function mkdirSync(p) {
	const a = norm(p);
	dirs.add(a);
	addDirs(a);
}

export function watch() {
	return { on() {}, close() {} };
}

export const promises = {};
export const constants = { F_OK: 0, R_OK: 4, W_OK: 2 };

export default { mount, onWrite, readFileSync, writeFileSync, existsSync, statSync, lstatSync, realpathSync, readdirSync, renameSync, rmSync, unlinkSync, mkdirSync, watch, promises, constants };
