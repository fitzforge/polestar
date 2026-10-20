'use strict';
// Import strings (docs/PACK_FORMAT.md, "Import strings"): one compiled guide
// as one line of text a player pastes into Polestar's Import page, no addon
// to install.
//
//   !PS1!<checksum>!<body>
//
// `PS1` is the string format; a later one gets another number so old strings
// keep their meaning. <checksum> is the Adler-32 of the payload as 8
// lower-case hex digits. <body> is the payload compressed with zlib and
// written in base64 (A-Z a-z 0-9 + / and = padding). The payload is JSON:
//
//   { "format": 3, "license": "CC-BY-4.0", "guide": { ... }, "frames": { "1429": { ... } } }
//
// `guide` is the compiled guide as emit.js writes it into Guides.lua
// (guideData: the same keys, numbers rounded the same way, no `pack`);
// `frames` the Era map frames its goals use (as MapFrames.lua), left out
// when none. The addon reads it as data only: Core/Import.lua parses the JSON
// itself, builds the guide field by field from a fixed set of keys and hands
// it to the registry's checks. Nothing in a string is ever run.

const zlib = require('node:zlib');
const { formatFor, RESERVED_IDS } = require('./format');
const { guideData, framesData } = require('../dsl/emit');
const { referencedFrames } = require('../dsl/project');

const PREFIX = '!PS1!';
// The caps the addon applies too (Core/Import.lua, Import.LIMITS; a test
// holds the two equal): the whole string, the steps of its guide, the
// payload once decompressed (bytes), and any one text or object key in it
// (bytes).
const LIMITS = { length: 500000, steps: 2000, payload: 2097152, text: 4096, names: 128, goals: 100, candidates: 128 };

// The first text or key in v longer than LIMITS.text, as the addon names it
// (`guide.steps[2].note`), or null.
function longText(v, where = '') {
	// names/written map values are capped at LIMITS.names, not LIMITS.text.
	const cap = /^guide\.(names|written)\./.test(where) ? LIMITS.names : LIMITS.text;
	if (typeof v === 'string') return Buffer.byteLength(v) > cap ? where : null;
	if (Array.isArray(v)) {
		for (let i = 0; i < v.length; i++) {
			const hit = longText(v[i], `${where}[${i + 1}]`);
			if (hit !== null) return hit;
		}
		return null;
	}
	if (v && typeof v === 'object') {
		for (const [k, x] of Object.entries(v)) {
			const at = where === '' ? k : `${where}.${k}`;
			if (Buffer.byteLength(k) > LIMITS.text) return where;
			const hit = longText(x, at);
			if (hit !== null) return hit;
		}
	}
	return null;
}

function adler32(buf) {
	let a = 1;
	let b = 0;
	for (let i = 0; i < buf.length; i++) {
		a = (a + buf[i]) % 65521;
		b = (b + a) % 65521;
	}
	return (b * 65536 + a) >>> 0;
}

function hex8(n) {
	return n.toString(16).padStart(8, '0');
}

// payload: { format, license, guide, frames? } -> the string.
function encodeImport(payload) {
	const bytes = Buffer.from(JSON.stringify(payload), 'utf8');
	return `${PREFIX}${hex8(adler32(bytes))}!${zlib.deflateSync(bytes, { level: 9 }).toString('base64')}`;
}

// The string -> its payload; throws an Error saying what is wrong. For the
// tools and tests; the addon has its own reader.
function decodeImport(text) {
	const s = String(text).replace(/\s+/g, '');
	if (!s.startsWith(PREFIX)) throw new Error(`not a Polestar import string: it starts with ${PREFIX}`);
	const m = /^!PS1!([0-9a-f]{8})!([A-Za-z0-9+/]+={0,2})$/.exec(s);
	if (!m) throw new Error('the string is damaged');
	let bytes;
	try {
		bytes = zlib.inflateSync(Buffer.from(m[2], 'base64'), { maxOutputLength: LIMITS.payload });
	} catch {
		throw new Error('the string is damaged or incomplete');
	}
	if (hex8(adler32(bytes)) !== m[1]) throw new Error('the string is damaged: its checksum does not match');
	return JSON.parse(bytes.toString('utf8'));
}

// One compiled guide of a pack (buildPack's guides; manifest its pack.json,
// data its reference data) as an import string. -> { text, steps } or
// { error } when the guide cannot go in one: one of Polestar's own guides,
// too many steps, a text longer than the addon reads, or a string or payload
// bigger than it reads.
function importString(guide, { manifest, data }) {
	const prefix = String(guide.id).split('/')[0];
	if (!manifest || manifest.id === 'guides' || RESERVED_IDS.has(prefix)) {
		return { error: `${guide.id} is one of Polestar's own guides; an import string carries a community guide, under its pack's id` };
	}
	const steps = (guide.steps || []).length;
	if (steps > LIMITS.steps) return { error: `${guide.id} has ${steps} steps; an import string holds a guide of ${LIMITS.steps} steps at most (a longer guide goes in a community addon: polestar pack)` };
	const payload = { format: formatFor([guide]), license: manifest.license, guide: guideData(guide._localised || guide) };
	const frames = data ? framesData(referencedFrames([guide], data)) : {};
	if (Object.keys(frames).length) payload.frames = frames;
	const long = longText(payload);
	if (long !== null) return { error: `${guide.id}: ${long} is longer than ${LIMITS.text} bytes, the most Polestar reads in one text of an import string` };
	const bytes = Buffer.byteLength(JSON.stringify(payload));
	if (bytes > LIMITS.payload) {
		return { error: `${guide.id} holds ${bytes} bytes of guide data; Polestar reads ${LIMITS.payload} at most (a guide this big goes in a community addon: polestar pack)` };
	}
	const text = encodeImport(payload);
	if (text.length > LIMITS.length) {
		return { error: `${guide.id} makes a string of ${text.length} characters; Polestar reads ${LIMITS.length} at most (a guide this big goes in a community addon: polestar pack)` };
	}
	return { text, steps };
}

// buildPack's result -> (guide id) -> importString's result, for the
// playground's Copy import string.
function packImporter(built) {
	return (id) => {
		const guide = (built.guides || []).find((g) => g.id === id);
		if (!guide) return { error: `${id} is not one of the community pack's guides` };
		return importString(guide, { manifest: built.manifest, data: built.data });
	};
}

module.exports = { PREFIX, LIMITS, adler32, encodeImport, decodeImport, importString, packImporter };
