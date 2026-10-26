'use strict';
// Values a long-running process keeps between requests (`sim serve`), by a key
// that names everything they were made from (content hashes, never a path
// alone), and file bytes its worker threads share. In any other process
// memo(key, make) is make() and fileBytes(file) reads the file: nothing is kept.
//
//   memo(key, make) -> make()'s value, made once per key while a store is installed
//   installStore(store) -> the process-wide store ({ get(key, make) }), shared by every
//     copy of this module (a server serves several code trees), or null to remove it
//   remember(key, value) -> notes what was set up (the starts a server loads again on a hot
//     swap: serve.js); nothing without a store
//   fileBytes(file) -> the file's bytes: a shared copy (installFiles) while its size, mtime
//     and inode are the ones it was read at, else read from disk
//   installFiles(map) -> the thread's shared files: Map(realpath -> { key: 'size:mtime:ino', buf })
//   sizeOf(value) -> its estimated heap bytes (a store's budget): typed arrays by their bytes
//     (none for a SharedArrayBuffer's: shared by every thread, counted once by the server),
//     arrays and objects by their slots, strings by their length; functions not followed

const fs = require('node:fs');

const SLOT = Symbol.for('polestar.sim.memo');
const FILES = Symbol.for('polestar.sim.files');

function memo(key, make) {
	const store = globalThis[SLOT];
	return store ? store.get(key, make) : make();
}

function installStore(store) {
	if (store) globalThis[SLOT] = store;
	else delete globalThis[SLOT];
}

function remember(key, value) {
	const store = globalThis[SLOT];
	if (store && store.remember) store.remember(key, value);
}

// What this thread's store remembered: [{ key, value }].
function remembered() {
	const store = globalThis[SLOT];
	return store && store.recent ? [...store.recent].map(([key, value]) => ({ key, value })) : [];
}

const statKey = (st) => `${st.size}:${st.mtimeMs}:${st.ino}`;

function fileBytes(file) {
	const shared = globalThis[FILES];
	if (shared) {
		const real = fs.realpathSync(file);
		const s = shared.get(real);
		if (s && s.key === statKey(fs.statSync(real))) return s.buf;
	}
	return fs.readFileSync(file);
}

function installFiles(map) {
	if (map) globalThis[FILES] = map;
	else delete globalThis[FILES];
}

function sizeOf(value) {
	const seen = new Set();
	const stack = [value];
	let bytes = 0;
	while (stack.length) {
		const v = stack.pop();
		if (typeof v === 'string') {
			bytes += 16 + v.length;
			continue;
		}
		if (v === null || typeof v !== 'object' || seen.has(v)) continue;
		seen.add(v);
		if (ArrayBuffer.isView(v)) {
			if (!(v.buffer instanceof SharedArrayBuffer)) bytes += 64 + v.byteLength;
			continue;
		}
		if (v instanceof ArrayBuffer) {
			bytes += v.byteLength;
			continue;
		}
		if (v instanceof SharedArrayBuffer) continue;
		if (v instanceof Map || v instanceof Set) {
			bytes += 32 + v.size * 24;
			for (const e of v) stack.push(e);
			continue;
		}
		if (Array.isArray(v)) {
			bytes += 16 + v.length * 8;
			for (const e of v) if (e !== null && (typeof e === 'object' || typeof e === 'string')) stack.push(e);
			continue;
		}
		const keys = Object.keys(v);
		bytes += 24 + keys.length * 16;
		for (const k of keys) {
			const e = v[k];
			if (e !== null && (typeof e === 'object' || typeof e === 'string')) stack.push(e);
		}
	}
	return bytes;
}

module.exports = { memo, installStore, remember, remembered, fileBytes, installFiles, statKey, sizeOf };
