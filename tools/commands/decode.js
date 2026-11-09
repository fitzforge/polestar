'use strict';
// decode: an import string's source (tools/lib/pack/sourcetree.js) written
// back as a pack: pack.json and the guide's .guide file.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { parseArgs } = require('../lib/cli');
const { ID_RE } = require('../lib/dsl/parse');
const { decodeImport } = require('../lib/pack/importstring');
const { toText } = require('../lib/pack/sourcetree');

const usage = `usage: node tools/polestar.js decode <string-or-file> [--out <dir>]

Writes the guide an import string carries back as a pack: <dir>/pack.json
(id the guide id's first segment; title, author, version and license from
the string) and <dir>/guides/<name>.guide from the string's source (its
guide as written; comments are not kept). <string-or-file> is the string
itself, or a file holding it or its JSON payload. Only a string that carries
its source can be decoded: a v1 string (!PS1!) holds the compiled guide
alone.

options:
  --out <dir>   the folder to write, new or empty (default: a new temp folder)`;

// The argument -> { payload, v1 } (v1: a !PS1! string); throws an Error saying what is wrong.
function readPayload(arg) {
	let text = arg;
	if (!/^\s*!PS\d+!/.test(arg)) {
		if (!fs.existsSync(arg) || !fs.statSync(arg).isFile()) throw new Error(`no file ${arg} (and it is no import string)`);
		text = fs.readFileSync(arg, 'utf8');
	}
	if (text.trim().startsWith('{')) return { payload: JSON.parse(text), v1: false };
	return { payload: decodeImport(text), v1: /^!PS1!/.test(text.replace(/\s+/g, '')) };
}

// A payload with `source` -> pack.json and guides/<name>.guide written into
// `dir` (absent or empty; null: a new temp folder). -> { dir, file, manifest };
// throws an Error saying what is wrong, before anything is written.
function writeDecoded(payload, dir = null) {
	if (!payload || typeof payload !== 'object' || payload.source === undefined) throw new Error('the payload has no source');
	const text = toText(payload.source);
	const header = payload.source.header;
	const guide = payload.guide && typeof payload.guide === 'object' ? payload.guide : {};
	const id = header.guide;
	if (typeof id !== 'string' || !ID_RE.test(id)) throw new Error(`malformed guide id ${JSON.stringify(id)} in the source`);
	const [prefix, ...rest] = id.split('/');
	const manifest = {
		id: prefix,
		title: String(guide.title ?? header.title ?? id),
		author: String(guide.author ?? header.author ?? ''),
		version: String(guide.version ?? header.version ?? 1),
		license: String(payload.license ?? ''),
	};
	if (dir && fs.existsSync(dir) && (!fs.statSync(dir).isDirectory() || fs.readdirSync(dir).length)) throw new Error(`${dir} is not empty`);
	if (!dir) dir = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-decode-'));
	const file = path.join(dir, 'guides', `${rest.length ? rest.join('-') : prefix}.guide`);
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(path.join(dir, 'pack.json'), `${JSON.stringify(manifest, null, '\t')}\n`);
	fs.writeFileSync(file, text);
	return { dir, file, manifest };
}

async function run(argv) {
	const { opts, positional, error } = parseArgs(argv, { options: ['--out'] });
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	const usageError = error || (positional.length !== 1 ? 'name one import string or file' : null);
	if (usageError) {
		console.error(`${usageError}\n\n${usage}`);
		return 2;
	}
	let read;
	try {
		read = readPayload(positional[0]);
	} catch (e) {
		console.error(`decode failed: ${e.message}`);
		return 1;
	}
	if (read.v1 && (!read.payload || read.payload.source === undefined)) {
		console.error('decode failed: no source in a v1 string (only a v2 string carries the guide as written)');
		return 1;
	}
	try {
		const r = writeDecoded(read.payload, opts.out ? path.resolve(opts.out) : null);
		console.log(`wrote ${path.join(r.dir, 'pack.json')}\nwrote ${r.file}`);
	} catch (e) {
		console.error(`decode failed: ${e.message}`);
		return 1;
	}
	return 0;
}

module.exports = { name: 'decode', summary: "Writes an import string's guide source back as a pack (pack.json and the .guide)", usage, run, readPayload, writeDecoded };
