'use strict';
// The shared artifact store (PipelinePlan F2 item 7; Nix store, Bazel's cache): built worlds, the
// world build's floors and walks files, kept by the hash of what they were built from and shared by
// every worktree, so a new worktree, a rebase or a gate snapshot with the same inputs reuses them
// instead of building again (the 1.2 h cold rebuild after the rebase).
//
//   dir: $POLESTAR_CAS, else ~/.cache/polestar/cas ($POLESTAR_CAS=off: no store); one directory
//     per kind (world, floors, walks), a file per key. $POLESTAR_CAS_SKIP=kind,...: those kinds
//     are neither read nor written (the rest shared)
//   enabled(simDir): only for a worktree's own data/sim (a test's or a scratch sim dir keeps its
//     artifacts to itself)
//   fetch(kind, key, dest) -> bool: the stored file copied to dest (a reflink where the filesystem
//     has them: no bytes copied), its mtime refreshed (gc's "last used")
//   store(kind, key, src): src copied in, when the key isn't there yet
//   file(kind, key, ext): a stored file's path (for a file used in place: floors)
//   status() -> { dir, kinds: { kind: { files, bytes } } }
//   gc({ maxAgeDays = 30, maxGb = 20 }) -> { removed, bytes, kept }: files unused for maxAgeDays,
//     then the least recently used until the store is under maxGb
//
// A key names everything the artifact was made from: a world's is its dataHash (the data, sources,
// rules and grid, worldInputs) with the faction, band width, open cap and the world builder's code;
// walks' the world's dataHash, the faction, the router and its walking maps (walksUsable's checks).

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

const EXT = { world: 'json', floors: 'json', walks: 'bin' };

function dir() {
	const env = process.env.POLESTAR_CAS;
	if (env === 'off') return null;
	return env || path.join(os.homedir(), '.cache', 'polestar', 'cas');
}

function enabled(simDir) {
	if (!dir() || !simDir) return false;
	const p = path.resolve(simDir);
	return path.basename(p) === 'sim' && path.basename(path.dirname(p)) === 'data';
}

const safe = (key) => String(key).replace(/[^A-Za-z0-9._-]/g, '_');

const skipped = (kind) => String(process.env.POLESTAR_CAS_SKIP || '').split(',').includes(kind);

// A skipped kind's files are looked for where none are (a directory never made).
function file(kind, key, ext = EXT[kind] || 'bin') {
	return path.join(dir(), skipped(kind) ? '.skipped' : '', kind, `${safe(key)}.${ext}`);
}

// A copy that shares the bytes where it can (btrfs, xfs: FICLONE), else a plain copy.
function copy(src, dest) {
	fs.mkdirSync(path.dirname(dest), { recursive: true });
	const tmp = `${dest}.${process.pid}.tmp`;
	fs.copyFileSync(src, tmp, fs.constants.COPYFILE_FICLONE);
	fs.renameSync(tmp, dest);
}

function fetch(kind, key, dest) {
	if (!dir() || skipped(kind)) return false;
	const f = file(kind, key);
	if (!fs.existsSync(f)) return false;
	copy(f, dest);
	const now = new Date();
	try {
		fs.utimesSync(f, now, now);
	} catch {
		// read-only store: still served
	}
	return true;
}

function store(kind, key, src) {
	if (!dir() || skipped(kind) || !fs.existsSync(src)) return false;
	const f = file(kind, key);
	if (fs.existsSync(f)) return false;
	try {
		copy(src, f);
		return true;
	} catch {
		return false; // a full or read-only store: the artifact stays local
	}
}

function entries() {
	const out = [];
	const root = dir();
	if (!root || !fs.existsSync(root)) return out;
	for (const kind of fs.readdirSync(root)) {
		const d = path.join(root, kind);
		if (!fs.statSync(d).isDirectory()) continue;
		for (const f of fs.readdirSync(d)) {
			if (f.endsWith('.tmp')) continue;
			const p = path.join(d, f);
			const st = fs.statSync(p);
			out.push({ kind, file: p, bytes: st.size, used: st.mtimeMs });
		}
	}
	return out;
}

function status() {
	const kinds = {};
	for (const e of entries()) {
		const k = (kinds[e.kind] = kinds[e.kind] || { files: 0, bytes: 0 });
		k.files++;
		k.bytes += e.bytes;
	}
	return { dir: dir(), kinds };
}

function gc({ maxAgeDays = 30, maxGb = 20, now = Date.now() } = {}) {
	const all = entries().sort((a, b) => a.used - b.used);
	let total = all.reduce((s, e) => s + e.bytes, 0);
	let removed = 0;
	let freed = 0;
	for (const e of all) {
		const old = now - e.used > maxAgeDays * 86400e3;
		if (!old && total <= maxGb * 2 ** 30) continue;
		fs.rmSync(e.file, { force: true });
		removed++;
		freed += e.bytes;
		total -= e.bytes;
	}
	return { removed, bytes: freed, kept: all.length - removed, total };
}

module.exports = { dir, enabled, file, fetch, store, status, gc, copy };
