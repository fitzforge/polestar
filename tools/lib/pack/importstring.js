'use strict';
// Import strings (docs/PACK_FORMAT.md, "Import strings"): one compiled guide
// as one line of text a player pastes into Polestar's Import page, no addon
// to install.
//
//   !PS1!<checksum>!<body>      a compiled guide
//   !PS2!<checksum>!<body>      a compiled guide and its source, bigger caps
//
// `PS1`/`PS2` is the string format; a later one gets another number so old
// strings keep their meaning. <checksum> is the Adler-32 of the payload as 8
// lower-case hex digits. <body> is the payload compressed with zlib and
// written in base64 (A-Z a-z 0-9 + / and = padding). The payload is JSON:
//
//   { "format": 3, "license": "CC-BY-4.0", "guide": { ... }, "frames": { "1429": { ... } } }
//
// `guide` is the compiled guide as emit.js writes it into Guides.lua
// (guideData: the same keys, numbers rounded the same way, no `pack`);
// `frames` the Era map frames its goals use (as MapFrames.lua), left out
// when none. A v2 payload adds `source`, the guide as written
// (sourcetree.js), for Polestar Studio and `polestar decode`. The addon reads
// it as data only: Core/Import.lua parses the JSON itself, builds the guide
// field by field from a fixed set of keys and hands it to the registry's
// checks. Nothing in a string is ever run.

const zlib = require('node:zlib');
const { formatFor, RESERVED_IDS } = require('./format');
const { guideData, framesData } = require('../dsl/emit');
const { referencedFrames } = require('../dsl/project');
const { toTree } = require('./sourcetree');

const PREFIX = '!PS1!';
const PREFIX_V2 = '!PS2!';
// The caps the addon applies too (Core/Import.lua, Import.LIMITS and
// LIMITS_V2; a test holds them equal): the whole string, the steps of its
// guide, the payload once decompressed (bytes), and any one text or object
// key in it (bytes); then the entries of every list a string could pad to
// freeze the game (crowded). A v2 string holds a bigger guide and its
// source: more characters, payload and steps; every other cap is v1's.
const LIMITS = {
	length: 50000, steps: 60, payload: 262144, text: 4096, names: 128, goals: 100, candidates: 128,
	spots: 1024, when: 16, skipto: 16, reagents: 32, fromNpcs: 32, pre: 64, tokens: 1024, nextWhen: 16,
};
const LIMITS_V2 = { ...LIMITS, length: 300000, steps: 250, payload: 1048576 };

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

// The first list or map of the payload's guide g holding more entries than
// its cap, as the addon names it (Core/Import.lua crowded, plus its goals and
// candidates caps) -> { at, n, cap }, or null.
function crowded(g) {
	const over = (v, cap, at) => {
		const n = v !== null && typeof v === 'object' ? Object.keys(v).length : 0;
		return n > cap ? { at, n, cap } : null;
	};
	const quests = (v, at) => {
		for (const k of ['pre', 'preAll', 'closedBy', 'preTitles', 'q']) {
			const hit = over(v && v[k], LIMITS.pre, `${at}.${k}`);
			if (hit) return hit;
		}
		return null;
	};
	const whens = (list, at) => {
		const hit = over(list, LIMITS.when, at);
		if (hit) return hit;
		for (const [i, w] of (Array.isArray(list) ? list : []).entries()) {
			const q = quests(w, `${at}[${i + 1}]`);
			if (q) return q;
		}
		return null;
	};
	const first = (...checks) => {
		for (const check of checks) {
			const hit = check();
			if (hit) return hit;
		}
		return null;
	};
	const nextWhen = g.nextWhen || {};
	const top = first(
		() => over(g.names, LIMITS.tokens, 'guide.names'),
		() => over(g.written, LIMITS.tokens, 'guide.written'),
		() => over(g.nextChoices, LIMITS.nextWhen, 'guide.nextChoices'),
		() => over(g.nextWhen, LIMITS.nextWhen, 'guide.nextWhen'),
		...Object.keys(nextWhen).map((k) => () => whens(nextWhen[k], `guide.nextWhen.${k}`)),
	);
	if (top) return top;
	for (const [i, step] of (g.steps || []).entries()) {
		const s = `guide.steps[${i + 1}]`;
		const hit = first(
			() => whens(step.when, `${s}.when`),
			() => over(step.skipto, LIMITS.skipto, `${s}.skipto`),
			...(step.skipto || []).map((jump, j) => () => quests(jump.when, `${s}.skipto[${j + 1}].when`)),
			() => over(step.goals, LIMITS.goals, `${s}.goals`),
			...(step.goals || []).map((goal, j) => () => {
				const at = `${s}.goals[${j + 1}]`;
				return first(
					() => over(goal.spots, LIMITS.spots, `${at}.spots`),
					() => over(goal.candidates, LIMITS.candidates, `${at}.candidates`),
					() => over(goal.reagents, LIMITS.reagents, `${at}.reagents`),
					() => over(goal.fromNpcs, LIMITS.fromNpcs, `${at}.fromNpcs`),
					() => quests(goal, at),
				);
			}),
		);
		if (hit) return hit;
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

// payload: { format, license, guide, source?, frames? } -> the string (v2:
// `!PS2!`).
function encodeImport(payload, { v2 = false } = {}) {
	const bytes = Buffer.from(JSON.stringify(payload), 'utf8');
	return `${v2 ? PREFIX_V2 : PREFIX}${hex8(adler32(bytes))}!${zlib.deflateSync(bytes, { level: 9 }).toString('base64')}`;
}

// The string (v1 or v2) -> its payload; throws an Error saying what is
// wrong. For the tools and tests; the addon has its own reader.
function decodeImport(text) {
	const s = String(text).replace(/\s+/g, '');
	if (!s.startsWith(PREFIX) && !s.startsWith(PREFIX_V2)) throw new Error(`not a Polestar import string: it starts with ${PREFIX} or ${PREFIX_V2}`);
	const m = /^!PS([12])!([0-9a-f]{8})!([A-Za-z0-9+/]+={0,2})$/.exec(s);
	if (!m) throw new Error('the string is damaged');
	const caps = m[1] === '2' ? LIMITS_V2 : LIMITS;
	let bytes;
	try {
		bytes = zlib.inflateSync(Buffer.from(m[3], 'base64'), { maxOutputLength: caps.payload });
	} catch {
		throw new Error('the string is damaged or incomplete');
	}
	if (hex8(adler32(bytes)) !== m[2]) throw new Error('the string is damaged: its checksum does not match');
	return JSON.parse(bytes.toString('utf8'));
}

// One compiled guide of a pack (buildPack's guides; manifest its pack.json,
// data its reference data) as an import string. v2: a `!PS2!` string whose
// payload carries `source`, the source tree (toTree) of `source`, the parsed
// guide (parseGuide's result; default the one the compiler keeps as
// `guide._ast`). -> { text, steps } or { error } when the guide cannot go in
// one: one of Polestar's own guides, too many steps, a text longer than the
// addon reads, a source with no tree, or a string or payload bigger than it
// reads.
function importString(guide, { manifest, data, source, v2 = false }) {
	const caps = v2 ? LIMITS_V2 : LIMITS;
	const prefix = String(guide.id).split('/')[0];
	if (!manifest || manifest.id === 'guides' || RESERVED_IDS.has(prefix)) {
		return { error: `${guide.id} is one of Polestar's own guides; an import string carries a community guide, under its pack's id` };
	}
	const steps = (guide.steps || []).length;
	if (steps > caps.steps) return { error: `${guide.id} has ${steps} steps; an import string holds a guide of ${caps.steps} steps at most (a longer guide goes in a community addon: forge release pack)` };
	const payload = { format: formatFor([guide]), license: manifest.license, guide: guideData(guide._localised || guide) };
	if (v2) {
		try {
			payload.source = toTree(source || guide._ast);
		} catch (e) {
			return { error: `${guide.id}: ${e.message}` };
		}
	}
	const frames = data ? framesData(referencedFrames([guide], data)) : {};
	if (Object.keys(frames).length) payload.frames = frames;
	const long = longText(payload);
	if (long !== null) return { error: `${guide.id}: ${long} is longer than ${LIMITS.text} bytes, the most Polestar reads in one text of an import string` };
	const full = crowded(payload.guide);
	if (full) return { error: `${guide.id}: ${full.at} has ${full.n} entries; an import string holds ${full.cap} there at most (a guide this big goes in a community addon: forge release pack)` };
	const bytes = Buffer.byteLength(JSON.stringify(payload));
	if (bytes > caps.payload) {
		return { error: `${guide.id} holds ${bytes} bytes of guide data; Polestar reads ${caps.payload} at most (a guide this big goes in a community addon: forge release pack)` };
	}
	const text = encodeImport(payload, { v2 });
	if (text.length > caps.length) {
		return { error: `${guide.id} makes a string of ${text.length} characters; Polestar reads ${caps.length} at most (a guide this big goes in a community addon: forge release pack)` };
	}
	return { text, steps };
}

// buildPack's result -> (guide id) -> importString's result, for the
// playground's Copy import string: a v2 string, as `polestar export` writes.
function packImporter(built) {
	return (id) => {
		const guide = (built.guides || []).find((g) => g.id === id);
		if (!guide) return { error: `${id} is not one of the community pack's guides` };
		return importString(guide, { manifest: built.manifest, data: built.data, source: guide._ast, v2: true });
	};
}

module.exports = { PREFIX, PREFIX_V2, LIMITS, LIMITS_V2, adler32, encodeImport, decodeImport, importString, packImporter };
