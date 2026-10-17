'use strict';
// The wowdev community listfile (github.com/wowdev/wow-listfile, release
// asset community-listfile.csv, ~150 MB, one `fdid;path` per line, paths
// lowercase with forward slashes): FileDataID -> client path, at build time
// only (names as facts; never shipped). Downloaded once to
// <sources>/listfile/community-listfile.csv and read as a stream, keeping
// only the lines asked for.

const fs = require('node:fs');
const path = require('node:path');
const readline = require('node:readline');
const { Readable } = require('node:stream');
const { pipeline } = require('node:stream/promises');

const LISTFILE_URL = 'https://github.com/wowdev/wow-listfile/releases/latest/download/community-listfile.csv';

const listfilePath = (sourcesDir) => path.join(sourcesDir, 'listfile', 'community-listfile.csv');

// -> the cached listfile's path, downloading it first when missing.
async function ensureListfile({ sourcesDir, offline = false, fetchImpl = globalThis.fetch, log = () => {} }) {
	const file = listfilePath(sourcesDir);
	if (fs.existsSync(file)) return file;
	if (offline) throw new Error(`--offline: missing cached ${path.relative(process.cwd(), file)}`);
	log(`fetching ${LISTFILE_URL}`);
	const res = await fetchImpl(LISTFILE_URL, { headers: { 'user-agent': 'polestar-nav' } });
	if (!res.ok || !res.body) throw new Error(`GET ${LISTFILE_URL}: HTTP ${res.status}`);
	fs.mkdirSync(path.dirname(file), { recursive: true });
	const tmp = `${file}.${process.pid}.tmp`;
	try {
		await pipeline(Readable.fromWeb(res.body), fs.createWriteStream(tmp));
		fs.renameSync(tmp, file);
	} finally {
		fs.rmSync(tmp, { force: true });
	}
	return file;
}

// fn(fdid, path) for every line of the listfile at file.
async function scanListfile(file, fn) {
	const lines = readline.createInterface({ input: fs.createReadStream(file, { encoding: 'utf8' }), crlfDelay: Infinity });
	for await (const line of lines) {
		const k = line.indexOf(';');
		if (k <= 0) continue;
		const fdid = Number(line.slice(0, k));
		if (Number.isInteger(fdid)) fn(fdid, line.slice(k + 1).trim().toLowerCase());
	}
}

// -> Map fdid -> path of the fdids asked for (those the listfile names).
async function pathsOf(file, fdids) {
	const out = new Map();
	await scanListfile(file, (fdid, p) => {
		if (fdids.has(fdid)) out.set(fdid, p);
	});
	return out;
}

module.exports = { ensureListfile, scanListfile, pathsOf, listfilePath, LISTFILE_URL };
