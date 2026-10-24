'use strict';
// The repository's own module graph, read from the source: the files a module
// requires (literal relative specifiers: require('./x'), require("../y")), their
// closure, and content hashes of a set of files. Used by the world builder's
// key (world.js worldKey) and test selection (tools/testsel.js).
//
//   directRequires(file) -> [absolute path] (resolved; built-ins, packages and
//     computed specifiers left out)
//   requireClosure(entries) -> [absolute path], sorted: the entries and every
//     repository file they reach
//   fileHash(file) -> sha1 hex of the file's bytes (memoised by path, size, mtime
//     and inode, so a long-running process re-reads only changed files)
//   hashFiles(files, root) -> sha1 hex over each file's path (relative to root) and bytes

const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');
const { createRequire } = require('node:module');

const REQ_RE = /\brequire\(\s*(['"])(\.{1,2}\/[^'"]*)\1\s*\)/g;

const statKey = (st) => `${st.size}:${st.mtimeMs}:${st.ino}`;
// A file changed in the last 2 s may change again within the file system's
// timestamp step (a few ms on Linux) at the same size: its stat can't vouch for
// its content, so it isn't memoised (git's "racily clean" rule).
const RACY_MS = 2000;
const settled = (st) => Date.now() - st.mtimeMs > RACY_MS;

// file -> { key, deps }
const depsMemo = new Map();
function directRequires(file) {
	const st = fs.statSync(file);
	const key = statKey(st);
	const hit = depsMemo.get(file);
	if (hit && hit.key === key) return hit.deps;
	const text = fs.readFileSync(file, 'utf8');
	const req = createRequire(file);
	const deps = [];
	for (const m of text.matchAll(REQ_RE)) {
		try {
			deps.push(req.resolve(m[2]));
		} catch {
			// a specifier that doesn't resolve (a file not written yet, a comment): nothing to follow
		}
	}
	const out = [...new Set(deps)];
	if (settled(st)) depsMemo.set(file, { key, deps: out });
	return out;
}

function requireClosure(entries) {
	const seen = new Set();
	const stack = entries.map((f) => path.resolve(f));
	while (stack.length) {
		const f = stack.pop();
		if (seen.has(f)) continue;
		seen.add(f);
		if (!/\.(c?js)$/.test(f)) continue;
		for (const d of directRequires(f)) if (!seen.has(d)) stack.push(d);
	}
	return [...seen].sort();
}

// file -> { key, hash }
const hashMemo = new Map();
function fileHash(file) {
	const st = fs.statSync(file);
	const key = statKey(st);
	const hit = hashMemo.get(file);
	if (hit && hit.key === key) return hit.hash;
	const hash = crypto.createHash('sha1').update(fs.readFileSync(file)).digest('hex');
	if (settled(st)) hashMemo.set(file, { key, hash });
	return hash;
}

function hashFiles(files, root) {
	const h = crypto.createHash('sha1');
	for (const f of files) h.update(`${path.relative(root, f)}:${fileHash(f)}\n`);
	return h.digest('hex');
}

module.exports = { directRequires, requireClosure, fileHash, hashFiles };
