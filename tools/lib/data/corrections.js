'use strict';
// The corrections `data build` applies: forever-db/corrections/<section>.json
// (public, every entry with an independent `source`; sections quests, npcs, objects,
// items, mechanics) with the private overlay merged over them when the maintainer
// has one (data/local/corrections-private.json, not in the repository: fixes whose
// only support is a source we don't publish).

const fs = require('node:fs');
const path = require('node:path');
const { ROOT } = require('../paths');

const PUBLIC_DIR = path.join(ROOT, 'forever-db', 'corrections');
const SECTIONS = ['quests', 'npcs', 'objects', 'items', 'mechanics'];
const PRIVATE_FILE = path.join('data', 'local', 'corrections-private.json');
const SOURCE_KINDS = ['recording', 'in-game-check', 'client', 'eg', 'cmangos', 'tdb', 'questie', 'pfquest', 'factoruide'];

const isObj = (v) => v !== null && typeof v === 'object' && !Array.isArray(v);

function merge(a, b) {
	if (!isObj(a) || !isObj(b)) return b;
	const out = { ...a };
	for (const [k, v] of Object.entries(b)) out[k] = k in out ? merge(out[k], v) : v;
	return out;
}

// Per section (quests, npcs, objects, items) and id: an entry only the overlay
// has is added; one both have is merged key by key, the overlay's object values
// merged into ours and its other values replacing ours. Keys starting with `_`
// (`_about`) stay the public file's. The overlay's mechanics may be nested as `mechanics.quests.<id>`.
function overlayCorrections(pub, priv) {
	const out = structuredClone(pub);
	for (const [section, ids] of Object.entries(priv || {})) {
		if (section.startsWith('_') || !isObj(ids)) continue;
		if (!isObj(out[section])) out[section] = {};
		let entries = Object.entries(ids);
		if (section === 'mechanics') entries = [...entries.filter(([k]) => k !== 'quests'), ...Object.entries(isObj(ids.quests) ? ids.quests : {})];
		for (const [id, entry] of entries) out[section][id] = id in out[section] ? merge(out[section][id], entry) : entry;
	}
	return out;
}

// The private overlay. privateFile: undefined -> <root>/data/local/corrections-private.json
// when it exists; false -> none; a path -> that file (it must exist). -> { file, data } or null.
function loadPrivateCorrections({ root = ROOT, privateFile } = {}) {
	if (privateFile === false) return null;
	const file = privateFile || path.join(root, PRIVATE_FILE);
	if (!privateFile && !fs.existsSync(file)) return null;
	return { file, data: JSON.parse(fs.readFileSync(file, 'utf8')) };
}

// The public corrections as one object { quests, npcs, objects, items, mechanics }: a folder of
// section files (default forever-db/corrections) or one file in the old single-file form.
function loadPublicCorrections(where = PUBLIC_DIR) {
	if (!fs.statSync(where).isDirectory()) return JSON.parse(fs.readFileSync(where, 'utf8'));
	const out = {};
	for (const s of SECTIONS) {
		const f = path.join(where, `${s}.json`);
		out[s] = fs.existsSync(f) ? JSON.parse(fs.readFileSync(f, 'utf8')) : {};
	}
	return out;
}

// The public corrections with the private overlay (loadPrivateCorrections) merged over them.
function loadCorrections(options = {}) {
	const pub = loadPublicCorrections(options.dir);
	const priv = loadPrivateCorrections(options);
	return priv ? overlayCorrections(pub, priv.data) : pub;
}

module.exports = { loadCorrections, loadPublicCorrections, loadPrivateCorrections, overlayCorrections, PUBLIC_DIR, PRIVATE_FILE, SECTIONS, SOURCE_KINDS };
