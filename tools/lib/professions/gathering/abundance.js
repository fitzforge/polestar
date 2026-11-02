'use strict';
// How many nodes of each kind a zone holds at once (tools/lib/professions/
// gathering/node-abundance.json), from the Forever TrinityCore world database's
// spawn pools.
//
// The node spawns in objects.json list every point a node can appear at, once
// per node kind that may appear there: an Arathi Highlands vein point is listed
// as Tin, Silver, Iron, Gold, Mithril and Truesilver at once, while the server
// puts one node on it, mostly Iron, and keeps only part of a zone's points
// filled. Counting spawns overstates rare nodes and pooled zones; this table
// gives each zone and node kind the expected number of nodes up at a time
// (`up`), from the pools' sizes and chances:
//
//   node tools/polestar.js profession gathering abundance   # rewrite node-abundance.json
//
// A spawn outside every pool is always up. A pool keeps max_limit of its
// members up (all of them when 0); a member with a chance takes that share of
// the pool's slots, the members without one split the rest; a pool inside a
// pool is up as often as its parent picks it. Each spawn counts for the zone of
// the nearest gathering node of objects.json (the zone map the guides use).

const fs = require('node:fs');
const path = require('node:path');
const { MINING_NODES, HERB_NODES } = require('./tables');

const FILE = path.join(__dirname, 'node-abundance.json');
const ABOUT = 'Gathering nodes a zone holds at once, per node kind (up), and their spawn points (spawns), from the spawn pools of the Forever TrinityCore world database; keyed by the zone map of objects.json. Written by `node tools/polestar.js profession gathering abundance` (tools/lib/professions/gathering/abundance.js); read by the gathering guides to weigh node spawns.';
const NEAR_YARDS = 200;
const CELL = 100;

// Spawn -> chance it is up, from pool_template and pool_members rows.
function poolOdds(templates, members) {
	const limit = new Map(templates.map((t) => [t.entry, t.max_limit]));
	const inPool = new Map(); // pool -> members [{ type, id, chance }]
	const parentOf = new Map(); // child pool -> parent pool
	const poolOfSpawn = new Map(); // gameobject guid -> pool
	for (const m of members) {
		if (!inPool.has(m.poolSpawnId)) inPool.set(m.poolSpawnId, []);
		inPool.get(m.poolSpawnId).push(m);
		if (m.type === 2) parentOf.set(m.spawnId, m.poolSpawnId);
		if (m.type === 1) poolOfSpawn.set(m.spawnId, m.poolSpawnId);
	}
	// Share of `pool`'s slots that member `m` (one of `type`) holds.
	function share(pool, m, type) {
		const list = (inPool.get(pool) || []).filter((x) => x.type === type);
		const lim = limit.get(pool) || list.length;
		const fixed = list.reduce((s, x) => s + (x.chance > 0 ? x.chance : 0), 0);
		const free = list.filter((x) => !(x.chance > 0)).length;
		const p = m.chance > 0 ? (lim * m.chance) / 100 : free ? (lim * Math.max(0, 100 - fixed)) / 100 / free : 0;
		return Math.min(1, p);
	}
	const upMemo = new Map();
	function poolUp(pool) {
		if (upMemo.has(pool)) return upMemo.get(pool);
		const parent = parentOf.get(pool);
		let p = 1;
		if (parent !== undefined) {
			const m = inPool.get(parent).find((x) => x.type === 2 && x.spawnId === pool);
			p = share(parent, m, 2) * poolUp(parent);
		}
		upMemo.set(pool, p);
		return p;
	}
	return (guid) => {
		const pool = poolOfSpawn.get(guid);
		if (pool === undefined) return 1;
		const m = inPool.get(pool).find((x) => x.type === 1 && x.spawnId === guid);
		return share(pool, m, 1) * poolUp(pool);
	};
}

// Grid of every gathering node point of objects.json, in world yards per continent.
function nodeGrid(objects, project, names) {
	const grid = new Map();
	for (const o of Object.values(objects)) {
		if (!names.has(o.name)) continue;
		for (const [map, s] of Object.entries(o.spawns || {})) {
			for (const [x, y] of [...(s.pts || []), ...(s.more || [])]) {
				const p = project.point(Number(map), x, y, s.f);
				const key = `${p.c}|${Math.floor(p.wx / CELL)}|${Math.floor(p.wy / CELL)}`;
				if (!grid.has(key)) grid.set(key, []);
				grid.get(key).push(p);
			}
		}
	}
	return grid;
}

function nearestMap(grid, c, wx, wy) {
	let best = null;
	let bestD = NEAR_YARDS * NEAR_YARDS;
	const gx = Math.floor(wx / CELL);
	const gy = Math.floor(wy / CELL);
	for (let dx = -2; dx <= 2; dx++) {
		for (let dy = -2; dy <= 2; dy++) {
			for (const p of grid.get(`${c}|${gx + dx}|${gy + dy}`) || []) {
				const d = (p.wx - wx) ** 2 + (p.wy - wy) ** 2;
				if (d < bestD) {
					bestD = d;
					best = p.map;
				}
			}
		}
	}
	return best;
}

// { maps: { <uiMap>: { <node name>: { spawns, up } } } } from the world DB file.
function derive(tdbFile, objects, project) {
	const { DatabaseSync } = require('node:sqlite');
	const db = new DatabaseSync(tdbFile, { readOnly: true });
	const names = new Set([...Object.keys(MINING_NODES), ...Object.keys(HERB_NODES)]);
	try {
		const odds = poolOdds(db.prepare('SELECT entry, max_limit FROM pool_template').all(), db.prepare('SELECT type, spawnId, poolSpawnId, chance FROM pool_members WHERE type IN (1, 2)').all());
		const grid = nodeGrid(objects, project, names);
		const rows = db.prepare('SELECT g.guid, g.map, g.position_x AS x, g.position_y AS y, t.name FROM gameobject g JOIN gameobject_template t ON t.entry = g.id WHERE t.type = 3').all();
		const maps = {};
		for (const r of rows) {
			if (!names.has(r.name)) continue;
			const map = nearestMap(grid, r.map, r.x, r.y);
			if (map === null) continue;
			const z = (maps[map] = maps[map] || {});
			const e = (z[r.name] = z[r.name] || { spawns: 0, up: 0 });
			e.spawns++;
			e.up += odds(r.guid);
		}
		const out = {};
		for (const map of Object.keys(maps).sort((a, b) => a - b)) {
			out[map] = {};
			for (const name of Object.keys(maps[map]).sort()) {
				const e = maps[map][name];
				out[map][name] = { spawns: e.spawns, up: Math.round(e.up * 10) / 10 };
			}
		}
		return { maps: out };
	} finally {
		db.close();
	}
}

let cached = null;
// The committed table: { <uiMap>: { <node name>: { spawns, up } } }.
function load() {
	if (!cached) cached = fs.existsSync(FILE) ? JSON.parse(fs.readFileSync(FILE, 'utf8')).maps : {};
	return cached;
}

module.exports = { FILE, ABOUT, poolOdds, derive, load };
