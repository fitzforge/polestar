'use strict';
// Crafting stations (an anvil, a forge, a cooking fire): the world objects a recipe's spell focus asks the player
// to stand by (professions.json `focus`: the client's SpellFocusObject name). stations.json lists, per focus name,
// the world database's spell-focus objects of that kind (gameobject_template type 8, its Data0 the focus id); their
// places come from data/forever objects.json. `profession stations` rewrites the file from the world database and
// the client's SpellFocusObject table. The profession guides (route.js) send a player to the nearest one of their
// faction before the first craft that needs it ("Go to an anvil": `goto … nearest`).

const fs = require('node:fs');
const path = require('node:path');

const FILE = path.join(__dirname, 'stations.json');
const ABOUT = 'Spell-focus objects per crafting station (the world database\'s gameobject_template type 8 by Data0, named by the client\'s SpellFocusObject table). Rewritten by `node tools/polestar.js profession stations`; read by tools/lib/professions/route.js.';

// The client's SpellFocusObject table (ID,Name_lang CSV) -> Map(id -> name).
function focusNames(csvFile) {
	const out = new Map();
	for (const line of fs.readFileSync(csvFile, 'utf8').split(/\r?\n/).slice(1)) {
		const m = /^(\d+),"?([^"]*)"?$/.exec(line.trim());
		if (m) out.set(Number(m[1]), m[2]);
	}
	return out;
}

// { <focus name>: [object entry, ...] } for the focus names `wanted` (a Set), from the world database file.
function derive(tdbFile, names, wanted) {
	const { DatabaseSync } = require('node:sqlite');
	const db = new DatabaseSync(tdbFile, { readOnly: true });
	try {
		const rows = db.prepare('SELECT DISTINCT t.entry, t.Data0 AS focus FROM gameobject_template t JOIN gameobject g ON g.id = t.entry WHERE t.type = 8').all();
		const out = {};
		for (const r of rows) {
			const name = names.get(Number(r.focus));
			if (!name || !wanted.has(name)) continue;
			(out[name] = out[name] || []).push(Number(r.entry));
		}
		for (const k of Object.keys(out)) out[k].sort((a, b) => a - b);
		return Object.fromEntries(Object.keys(out).sort().map((k) => [k, out[k]]));
	} finally {
		db.close();
	}
}

function render(stations) {
	const keys = Object.keys(stations);
	const lines = ['{', `\t"about": ${JSON.stringify(ABOUT)},`, '\t"stations": {'];
	keys.forEach((k, i) => lines.push(`\t\t${JSON.stringify(k)}: ${JSON.stringify(stations[k])}${i < keys.length - 1 ? ',' : ''}`));
	lines.push('\t}', '}', '');
	return lines.join('\n');
}

let cache = null;
// { <focus name>: Set(object entry) } from stations.json.
function load() {
	if (!cache) {
		const j = JSON.parse(fs.readFileSync(FILE, 'utf8'));
		cache = Object.fromEntries(Object.entries(j.stations).map(([k, v]) => [k, new Set(v)]));
	}
	return cache;
}

module.exports = { FILE, ABOUT, focusNames, derive, render, load };
