'use strict';
// pack.json: a guide pack's manifest. readManifest reads and
// validates it; validateManifest checks an already parsed object. Diagnostics
// are { file, line, severity, message, hint } with a 1-based line: the line of
// the key in pack.json when it can be found, else 1.

const fs = require('node:fs');
const path = require('node:path');
const { PACK_ID_RE, FOLDER_RE, RESERVED_IDS, defaultFolder } = require('./format');

const REQUIRED = ['id', 'title', 'author', 'version', 'license'];
const OPTIONAL = ['website', 'source', 'notes', 'folder'];
const KEYS = [...REQUIRED, ...OPTIONAL];
const MAX_LENGTH = { title: 64, author: 64, license: 64, website: 200, source: 200, notes: 200 };
// Shown to players: a `|` there starts an escape sequence in the game's text.
const DISPLAYED = ['title', 'author', 'license', 'website', 'source', 'notes'];
const VERSION_RE = /^[0-9A-Za-z][0-9A-Za-z.+-]{0,31}$/;
const CONTROL_RE = /[\u0000-\u001f\u007f]/;
const OUR_FOLDER_RE = /^polestar($|_)/i;
const ID_HINT = 'pick an id like `<author>-<name>`, e.g. "joe-routes"';
// Polestar shows author text as written (every `|` escaped), so escape codes
// do not work; guide lint (tools/lib/dsl/validate.js) gives the same hint.
const PIPE_HINT = 'drop the `|`: Polestar shows it as written, so colour and link codes like `|cff` do not work';
// A value for each key, for the hints.
const EXAMPLE = {
	id: 'joe-routes',
	title: "Joe's Routes",
	author: 'Joe',
	version: '1.0.0',
	license: 'CC-BY-4.0',
	website: 'https://github.com/joe/joe-routes',
	source: 'https://github.com/joe/joe-routes',
	notes: 'Leveling routes for Elwynn Forest and Westfall',
	folder: 'PolestarPack_JoesRoutes',
};
const example = (key) => `"${key}": ${JSON.stringify(EXAMPLE[key])}`;

// 1-based line of `"key":` in the JSON text, else 1.
function keyLine(text, key) {
	if (!text) return 1;
	const re = new RegExp(`"${key.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}"\\s*:`);
	const m = re.exec(text);
	return m ? text.slice(0, m.index).split('\n').length : 1;
}

function validateManifest(obj, file, { official = false, text = null } = {}) {
	const diags = [];
	const add = (severity, key, message, hint) => diags.push({ file, line: key ? keyLine(text, key) : 1, severity, message, hint });
	const error = (key, message, hint) => add('error', key, message, hint);
	if (obj === null || typeof obj !== 'object' || Array.isArray(obj)) {
		error(null, 'pack.json must hold one JSON object', 'write `{ "id": "...", "title": "...", "author": "...", "version": "...", "license": "..." }`');
		return diags;
	}
	for (const key of Object.keys(obj)) {
		if (!KEYS.includes(key)) add('warning', key, `unknown key \`${key}\` (ignored)`, `pack.json takes ${KEYS.map((k) => `\`${k}\``).join(', ')}`);
	}
	for (const key of KEYS) {
		const v = obj[key];
		if (v === undefined || v === null || v === '') {
			if (REQUIRED.includes(key)) error(key, `missing \`${key}\``, `add ${example(key)} (with your own value) to pack.json`);
			continue;
		}
		if (typeof v !== 'string') {
			error(key, `\`${key}\` must be a string`, `write the value in quotes, like ${example(key)}`);
			continue;
		}
		if (CONTROL_RE.test(v)) {
			error(key, `\`${key}\` contains control characters (line breaks, tabs or other invisible characters)`, `keep \`${key}\` on one line without control characters`);
			continue;
		}
		if (MAX_LENGTH[key] && v.length > MAX_LENGTH[key]) {
			error(key, `\`${key}\` is ${v.length} characters long; at most ${MAX_LENGTH[key]} fit`, `shorten \`${key}\` to ${MAX_LENGTH[key]} characters or fewer`);
			continue;
		}
		if (DISPLAYED.includes(key) && v.includes('|')) {
			add('warning', key, `\`${key}\` contains "|", which prints literally in game`, PIPE_HINT);
		}
		if (key === 'id') {
			if (!PACK_ID_RE.test(v)) {
				error(key, `pack id "${v}" is malformed: 2 to 32 lowercase letters, digits and dashes, starting with a letter or digit`, ID_HINT);
			} else if (RESERVED_IDS.has(v) && !(official && v === 'guides')) {
				error(key, `pack id "${v}" is reserved for Polestar (${[...RESERVED_IDS].map((r) => `"${r}"`).join(', ')} are)`, ID_HINT);
			}
		} else if (key === 'version') {
			if (!VERSION_RE.test(v)) error(key, `version "${v}" is malformed: one word of letters, digits, ".", "+" and "-", at most 32 characters`, 'write a version like "1.2.0"');
		} else if (key === 'website') {
			if (!/^https?:\/\//.test(v)) error(key, `website "${v}" must start with https:// or http://`, 'write the full address, like "https://github.com/you/your-pack"');
		} else if (key === 'folder') {
			if (!FOLDER_RE.test(v)) {
				error(key, `folder "${v}" is malformed: 1 to 64 letters, digits, "_" and "-"`, 'pick a folder like "PolestarPack_JoesRoutes", or leave `folder` out for the default');
			} else if (OUR_FOLDER_RE.test(v) && !(official && v === 'Polestar_Guides')) {
				error(key, `folder "${v}" looks like one of Polestar's own addons`, 'pick a folder that does not start with "Polestar_", like "PolestarPack_JoesRoutes"');
			}
		}
	}
	return diags;
}

// Shows a path the way diagnostics do: relative to the working directory when inside it.
function shown(abs) {
	const rel = path.relative(process.cwd(), abs);
	return rel.startsWith('..') || path.isAbsolute(rel) ? abs : rel.split(path.sep).join('/');
}

// A file the pack folder itself holds (pack.json, LICENSE, retired.json,
// legs.json) -> { text }, {} when there is none, or { error } when it is a
// link, not a plain file, or lies outside the folder once links are
// resolved: a pack handed over as a repository or an archive must not pull
// another file of the machine (a token, a key) into the build or its
// messages.
function readPackFile(dir, name) {
	const file = path.join(dir, name);
	let st;
	try {
		st = fs.lstatSync(file);
	} catch {
		return {};
	}
	if (!st.isFile()) return { error: `${name} is a link or not a plain file; Polestar reads only a plain file in the pack folder` };
	let rel;
	try {
		rel = path.relative(fs.realpathSync(dir), fs.realpathSync(file));
	} catch {
		return {};
	}
	if (rel !== name) return { error: `${name} lies outside the pack folder; Polestar reads only a plain file in the pack folder` };
	try {
		return { text: fs.readFileSync(file, 'utf8') };
	} catch {
		return {};
	}
}

// Where JSON.parse stopped in text, as " (line L, column C)" when V8 says,
// else "": never V8's own message, which quotes the start of the text (a
// file that is no JSON at all would show its contents).
function jsonErrorAt(e, text) {
	const m = /position (\d+)/.exec((e && e.message) || '');
	if (!m) return '';
	const lines = text.slice(0, Number(m[1])).split('\n');
	return ` (line ${lines.length}, column ${lines[lines.length - 1].length + 1})`;
}

// -> { manifest, diags }; manifest is null when there are errors.
function readManifest(dir, { official = false } = {}) {
	const abs = path.join(dir, 'pack.json');
	const file = shown(abs);
	const read = readPackFile(dir, 'pack.json');
	if (read.error) return { manifest: null, diags: [{ file, line: 1, severity: 'error', message: read.error, hint: 'make pack.json a plain file of the pack folder' }] };
	let text = read.text;
	if (text === undefined) {
		return { manifest: null, diags: [{ file, line: 1, severity: 'error', message: `no pack.json in ${shown(dir) || '.'}`, hint: 'create pack.json with id, title, author, version and license' }] };
	}
	// Editors on Windows may save a byte order mark; JSON.parse rejects it.
	if (text.charCodeAt(0) === 0xfeff) text = text.slice(1);
	let obj;
	try {
		obj = JSON.parse(text);
	} catch (e) {
		return { manifest: null, diags: [{ file, line: 1, severity: 'error', message: `pack.json is not valid JSON${jsonErrorAt(e, text)}`, hint: 'check for a missing value, quote or comma; JSON allows no trailing commas or comments' }] };
	}
	const diags = validateManifest(obj, file, { official, text });
	if (diags.some((d) => d.severity === 'error')) return { manifest: null, diags };
	const manifest = {};
	for (const key of KEYS) if (typeof obj[key] === 'string' && obj[key] !== '') manifest[key] = obj[key];
	if (!manifest.folder) manifest.folder = defaultFolder(manifest.title, manifest.id);
	return { manifest, diags };
}

module.exports = { readManifest, validateManifest, readPackFile, jsonErrorAt, PIPE_HINT };
