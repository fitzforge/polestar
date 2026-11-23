'use strict';
// Where each gathering node can spawn, for While you're here's gathering spots (addon/Polestar/Core/Gather.lua,
// the option behavior.whileHereGather):
//
//   node tools/polestar.js profession gathering spots           # rewrite addon/Polestar/Core/GatherData.lua
//   node tools/polestar.js profession gathering spots --check   # exit 1 when it is out of date (writes nothing)
//
// The herb, ore and fishing pool spawns of objects.json (role herb, mine or fishing; Forever's own starting-area
// nodes, which carry no role, by name: FOREVER_NODES), with the skill each kind asks (tables.js; a fishing pool:
// Fishing 1). A kind's points on a map within SPOT_YARDS of a spot already made join it (the spot moves to their
// middle). Ooze-covered nodes (an ooze guards them) and kinds tables.js has no skill for (instance-only veins) are
// left out, as the routes leave them out.

const path = require('node:path');
const { ROOT } = require('../../paths');
const { header } = require('../../generated');
const { MINING_NODES, HERB_NODES, FOREVER_NODES } = require('./tables');
const R = require('./route');
const { dist } = require('../../route/geo');

const OUT_DIR = path.join(ROOT, 'addon', 'Polestar', 'Core');
const OUT_FILE = 'GatherData.lua';
const SPOT_YARDS = 40;
const LINES = { herb: 182, mine: 186, fishing: 356 };
const LINE_ORDER = [182, 186, 356];
// The digits of a spot: base 60, no x or z (so the data never spells a word the wording rule bans).
const DIGITS = '0123456789ABCDEFGHIJKLMNOPQRSTUVWYabcdefghijklmnopqrstuvwy+/';
const STEPS = 3599; // a coordinate in 3599ths of the map, two digits

// A map percent as two base-60 digits.
function enc(v) {
	const n = Math.max(0, Math.min(STEPS, Math.round((v / 100) * STEPS)));
	return DIGITS[Math.floor(n / 60)] + DIGITS[n % 60];
}

// The kinds of node: { name, line, skill, ids, objects } by name, in the order the file lists them (skill line,
// skill, name).
function kindsOf(objects) {
	const byName = new Map();
	for (const o of Object.values(objects)) {
		if (!o || !o.name || /^Ooze Covered /.test(o.name)) continue;
		let role = (o.roles || []).find((r) => LINES[r]);
		if (!role && FOREVER_NODES.has(o.name)) role = MINING_NODES[o.name] !== undefined ? 'mine' : 'herb';
		if (!role) continue;
		const skill = role === 'mine' ? MINING_NODES[o.name] : role === 'herb' ? HERB_NODES[o.name] : 1;
		if (skill === undefined) continue;
		let k = byName.get(o.name);
		if (!k) {
			k = { name: o.name, line: LINES[role], skill, ids: [], objects: [] };
			byName.set(o.name, k);
		}
		k.ids.push(Number(o.id));
		k.objects.push(o);
	}
	const kinds = [...byName.values()].filter((k) => k.objects.some((o) => Object.keys(o.spawns || {}).length));
	for (const k of kinds) k.ids.sort((a, b) => a - b);
	kinds.sort((a, b) => LINE_ORDER.indexOf(a.line) - LINE_ORDER.indexOf(b.line) || a.skill - b.skill || (a.name < b.name ? -1 : a.name > b.name ? 1 : 0));
	return kinds;
}

// Kind k's spots on each map: map -> { f, spots: [{ x, y, wx, wy, c, n }] }. A point joins the first spot made
// (the lowest numbered) whose middle is within SPOT_YARDS; the spots sit in cells of SPOT_YARDS by their middle, so
// only the nine cells around a point are searched.
function spotsOf(k, project) {
	const maps = new Map();
	const cellOf = (p) => `${Math.floor(p.wx / SPOT_YARDS)},${Math.floor(p.wy / SPOT_YARDS)}`;
	for (const o of k.objects) {
		for (const [map, s] of Object.entries(o.spawns || {})) {
			for (const [x, y] of R.allPoints(s)) {
				const pt = project.point(Number(map), x, y, s.f);
				let m = maps.get(pt.map);
				if (!m) {
					m = { f: pt.f === 'l' ? 'l' : 'e', spots: [], cells: new Map() };
					maps.set(pt.map, m);
				}
				const cx = Math.floor(pt.wx / SPOT_YARDS);
				const cy = Math.floor(pt.wy / SPOT_YARDS);
				let near = null;
				for (let dx = -1; dx <= 1; dx++) {
					for (let dy = -1; dy <= 1; dy++) {
						for (const p of m.cells.get(`${cx + dx},${cy + dy}`) || []) {
							if (dist(p, pt) <= SPOT_YARDS && (!near || p.i < near.i)) near = p;
						}
					}
				}
				if (near) {
					const was = cellOf(near);
					near.n += 1;
					near.x += (pt.x - near.x) / near.n;
					near.y += (pt.y - near.y) / near.n;
					near.wx += (pt.wx - near.wx) / near.n;
					near.wy += (pt.wy - near.wy) / near.n;
					const now = cellOf(near);
					if (now !== was) {
						const list = m.cells.get(was);
						list.splice(list.indexOf(near), 1);
						if (!m.cells.has(now)) m.cells.set(now, []);
						m.cells.get(now).push(near);
					}
				} else {
					const p = { i: m.spots.length, x: pt.x, y: pt.y, wx: pt.wx, wy: pt.wy, c: pt.c, n: 1 };
					m.spots.push(p);
					const key = cellOf(p);
					if (!m.cells.has(key)) m.cells.set(key, []);
					m.cells.get(key).push(p);
				}
			}
		}
	}
	for (const m of maps.values()) delete m.cells;
	return maps;
}

// The file's text.
function render(ctx) {
	const kinds = kindsOf(ctx.data.objects || {});
	const maps = new Map(); // map -> { f, parts: ["k:..."] }
	kinds.forEach((k, i) => {
		for (const [map, { f, spots }] of spotsOf(k, ctx.project)) {
			if (!maps.has(map)) maps.set(map, { f, parts: [] });
			maps.get(map).parts.push(`${i + 1}:${spots.map((p) => enc(p.x) + enc(p.y)).join('')}`);
		}
	});
	const L = [
		header('lua', 'profession gathering spots', 'data/forever (the herb, ore and fishing pool spawns in objects.json: pfQuest and Questie Forever) and the node skills of tools/lib/professions/gathering/tables.js'),
		`-- Where each gathering node can spawn, for While you're here's gathering spots (Core/Gather.lua): a kind's points`,
		`-- on a map within ${SPOT_YARDS} yards of each other are one spot.`,
		'',
		'local _, ns = ...',
		'local G = ns.Gather',
		'if not (G and G.Register) then return end',
		'',
		'G.Register({',
		'\t-- name, skill line (182 Herbalism, 186 Mining, 356 Fishing), skill, then its object ids',
		'\tkinds = {',
		...kinds.map((k) => `\t\t{ ${JSON.stringify(k.name)}, ${k.line}, ${k.skill}, ${k.ids.join(', ')} },`),
		'\t},',
		'\t-- uiMapID = its frame ("e" the Era frame, "l" the live one), then each kind\'s spots: the kind\'s number, ":",',
		`\t-- and four digits a spot (x, then y, in ${STEPS}ths of the map, two base-60 digits each: ${DIGITS}); the kinds`,
		'\t-- split by ";"',
		'\tmaps = {',
		...[...maps.keys()].sort((a, b) => a - b).map((m) => `\t\t[${m}] = "${maps.get(m).f};${maps.get(m).parts.join(';')}",`),
		'\t},',
		'})',
		'',
	];
	return L.join('\n');
}

module.exports = { OUT_DIR, OUT_FILE, SPOT_YARDS, DIGITS, kindsOf, spotsOf, render, enc };
