'use strict';
// The walking router that tools call (sim walks, the guide bake): one interface over the
// native routers that read the build-time maps, never the shipped Lua (docs/legacy/SIMULATION-js.md,
// "Walks"; data/local/research/NavArchitecture.md §4.4).
//
//   open(dir = GRID_DIR, { format = 2, shared, zones, hubs }) -> router
//     format 2: path.js over the navigation grid in dir (data/local/nav4). format 4: Leffe's
//       format-4 maps read in Node (tools/lib/nav/nav4, when present), with this same shape.
//     shared: share()'s store; a worker thread then reads every tile and graph from the one
//       decoded copy in shared memory.
//     zones: [{ c, gx0, gy0, nx, ny, cell, z }] (the sim world's danger grids with their
//       continent): the zones danger reads where the AreaTable is not cached; with it a chunk's
//       zone is its area's, up its parents, as the walking maps' zone field has it (areaZones).
//     hubs: the hubs layer (data/local/nav-layers/hubs.json, { [c]: [{ side, disks: [[wx, wy, r]] }] }),
//       read from HUBS_FILE when not given (none when it is not there).
//   router.route(a, b, profile) -> path.js route's result (ok, reason, pts, cls, yards, seconds,
//     ...) plus cost and hubs (the hubs hostile to the profile's faction that the drawn line
//     enters, [{ id, name, areaId }] in path order, as Routing/Path.lua's job.hubs)
//   router.routeMany(from, targets, profile, { limit, cells }) -> { yards, costs, cells }
//     (Float64Array per target, -1 where none): the cell path's yards (path.js routeMany;
//     router.smooth turns them into the walked line's); cells (with `cells`): per target its
//     yards per zone cell, flat [cellKey, yards, ...]
//   router.distanceTable(sources, targets, profile, { cells = false }) -> { costs, seconds, yards,
//     cells }: every source to every target, Float64Array S × T row-major (k = i * T + j), -1 where
//     none (another continent or region, or no way); yards and costs as routeMany's; cells (with
//     `cells`): Array(S × T) of routeMany's flat cell lists, null where none: one routeMany per
//     source.
//   router.distanceRows(rows, profile, { cells = false }) -> per row { costs, seconds, yards, cells }:
//     rows [{ source, targets }], each row as routeMany answers it (Float64Array per target, -1
//     none; cells as distanceTable's, null without). One call for many sources.
//   router.metricKey(profile) -> the name of the weights a profile routes on (edgecost.js MODEL,
//     the road mask, hubs and faction: groundKey, the danger table, the move profile): two
//     profiles with one key get the same answers on the same maps
//   router.backend -> 'js' (path.js)
//   cellKey(wx, wy) -> the ZONE_CELL yd cell's key; cellXY(key) -> [gx, gy] (floor(wx / ZONE_CELL), ...)
//   router.heightAt(c, wx, wy, nearZ) -> the height of the walkable surface nearest (wx, wy,
//     nearZ), or NaN
//   router.zoneAt(c, wx, wy) -> the zone (uiMapID) of the chunk there, 0 for none
//   router.fingerprint -> sha1 of the maps (index.json, lifts.json, the graphs' sizes), the hubs
//     layer, the zones and the router's code: changes whenever a walk could (fingerprint(dir)
//     alone, unopened)
//   router.smooth -> walked yards per yard routeMany reports (SMOOTH: the drawn line ÷ the cell path)
//   router.format
//   share(dir, continents, { format = 2 }) -> the store open's `shared` takes (path.js
//     shareNav, with the walk graphs)
//   prepare(dir, continents, { workers, log }) -> builds the road masks and walk graphs that are
//     missing (one walk graph per faction: none, Alliance, Horde); prepared(dir, continents) ->
//     whether none is missing
//   router.edgeCosts(c, profile) -> Float64Array: every coarse edge's cost (graph/<c>.bin.gz's
//     CSR order, its first graph) for the profile's metric, as the abstract search prices it
//     (seconds × RUN; Infinity where closed): the weights a contraction hierarchy customizes
//   router.profile(profile) -> the path.js profile route and routeMany search with
//   dangerOf(level, zoneMins, za, zb) -> the zone danger of a walk at a character's level, as the
//     addon's Nav.danger builds it (harness.lua dangerOf): every zone whose lowest level is at
//     least level + 4 costs 3 times, over level + 10 20 times, except the ends' zones za and zb;
//     null when none
//
// Points: { c, wx, wy, z } (or { c, x, y, z }) in world coordinates (UnitPosition's x, y), z null
// when unknown, snapped to the surface under their feet (path.js snap's `under`). A profile:
// { faction: 'Alliance' | 'Horde' | null, style, danger: { [uiMapID]: multiplier } | null, move:
// a move.js profile (default: on foot) }. What a step costs for it is edgecost.js's model (time,
// faces, roads, hostile hubs, zone danger: the one place it is written down); here are its data:
// the road mask (roadmask.js over the roads layer, kept per continent in <dir>/walk/), the hubs
// layer's disks and the zones. Format 2 has no route styles (path.js prices time by slope and
// faces, and roads at Balanced's multiplier): `style` is taken and ignored. cost: seconds × RUN
// with those multipliers, so yards on open flat ground.

const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const { Worker, isMainThread, parentPort, workerData } = require('node:worker_threads');
const { ROOT } = require('../paths');
const { ADT, CELL, TILE_CELLS, tileKey } = require('./grid/format');
const { profileFor, RUN } = require('./move');
const Costs = require('./costs');
const { MODEL, HUB, FACE, CLIMB, WALK, MIN_MULT, ROAD_BIT, stepMult, metricKey } = require('./edgecost');

// The walking grid: $POLESTAR_GRID (another grid, until it becomes data/local/nav4), else data/local/nav4.
const GRID_DIR = process.env.POLESTAR_GRID ? path.resolve(process.env.POLESTAR_GRID) : path.join(ROOT, 'data', 'local', 'nav4');
const HUBS_FILE = path.join(ROOT, 'data', 'local', 'nav-layers', 'hubs.json');
const ROADS_DIR = path.join(ROOT, 'data', 'local', 'nav-layers', 'roads');
// Walked yards per cell-path yard for format 2: the drawn line (route's smoothing) ÷ the searched
// cell path (routeMany's yards). Measured on 558 base walks of both factions (walks --parity 2000:
// p10 0.941, median 0.961, p90 1.028; WalksNode.md).
const SMOOTH = 0.961;
const CODE = ['router.js', 'edgecost.js', 'costs.js', 'roadmask.js', 'path.js', 'move.js', 'grid/search.js', 'grid/format.js'];
const FACTIONS = [null, 'Alliance', 'Horde'];
// Zone cells: the sim world's danger grid cells (world.danger: 200 yd, at whole multiples), keyed
// by their absolute indices.
const ZONE_CELL = 200;
const cellKey = (wx, wy) => (Math.floor(wx / ZONE_CELL) + 512) * 1024 + Math.floor(wy / ZONE_CELL) + 512;
const cellXY = (key) => [Math.floor(key / 1024) - 512, (key % 1024) - 512];

// A point in path.js's shape, snapped to the surface under its feet (path.js snap's `under`)
// and standing on one at its height within reach (snap's `stand`, as Routing/PathGrid.lua
// snaps an end; edgecost.js "Ends") unless it says otherwise or is snapped already.
const asPoint = (p) => {
	if (!p || p.entry !== undefined) return p;
	const q = p.wx === undefined && p.x !== undefined ? { c: p.c, wx: p.x, wy: p.y, z: p.z } : { ...p };
	if (q.under === undefined) q.under = true;
	if (q.stand === undefined) q.stand = true;
	return q;
};

function dangerOf(level, zoneMins, za, zb) {
	if (typeof level !== 'number' || !zoneMins) return null;
	let out = null;
	for (const [id, min] of Object.entries(zoneMins)) {
		const z = Number(id);
		const m = min > level + 10 ? 20 : min >= level + 4 ? 3 : 0;
		if (m && z !== za && z !== zb) (out || (out = {}))[z] = m;
	}
	return out;
}

// A danger table's multipliers (path.js profile.area; edgecost.js danger): a step into a chunk of
// a zone in it costs that many times. zs: the router's zones (chunks(t): the zone of each of tile
// t's 16 x 16 chunks; at(c, wx, wy)). null without danger.
function makeArea(danger, zs) {
	const dz = danger && Object.keys(danger).length ? danger : null;
	if (!dz) return null;
	const key = metricKey({ danger: dz });
	// A tile's danger per chunk (Float32Array(256)), or null where none is above 1; kept on the tile per key.
	const tileDanger = (t) => {
		if (!t.danger) t.danger = new Map();
		let v = t.danger.get(key);
		if (v !== undefined) return v;
		const zones = zs.chunks(t);
		const m = Float32Array.from(zones, (z) => dz[z] || 1);
		v = m.some((x) => x > 1) ? m : null;
		if (t.danger.size > 32) t.danger.clear();
		t.danger.set(key, v);
		return v;
	};
	return {
		key,
		mult(t, k) {
			const g = tileDanger(t);
			return g ? g[((k >> 12) << 4) + ((k & 255) >> 4)] : 1;
		},
		touches(t) {
			return !!tileDanger(t);
		},
		// path.js coarseDanger: a zone's multiplier.
		zoneMult: (z) => dz[z] || 1,
	};
}

// The class byte of every column of tile t (edgecost.js: the road bit, Costs.HUB_ALLIANCE,
// Costs.HUB_HORDE), kept on the tile: road where the continent's road mask has it, a side's hub bit
// where one of its hubs' disks reaches the column's square (pack.js markHubs counts a cell so).
function groundOf(t, roadMask, hubSet) {
	if (t.ground) return t.ground;
	const g = new Uint8Array(TILE_CELLS * TILE_CELLS);
	const m = roadMask(t.c, t.col, t.row);
	if (m) for (let k = 0; k < g.length; k++) if (m[k >> 3] & (1 << (k & 7))) g[k] = ROAD_BIT;
	const x1 = (32 - t.row) * ADT;
	const y1 = (32 - t.col) * ADT;
	for (const [side, bit] of [['Alliance', Costs.HUB_ALLIANCE], ['Horde', Costs.HUB_HORDE]]) {
		const d = hubSet.near(side, t.c, t.col, t.row);
		for (let q = 0; d && q < d.length; q += 3) {
			const [hx, hy, r] = [d[q], d[q + 1], d[q + 2]];
			const j0 = Math.max(0, Math.floor((x1 - hx - r) / CELL) - 1);
			const j1 = Math.min(TILE_CELLS - 1, Math.ceil((x1 - hx + r) / CELL) + 1);
			const i0 = Math.max(0, Math.floor((y1 - hy - r) / CELL) - 1);
			const i1 = Math.min(TILE_CELLS - 1, Math.ceil((y1 - hy + r) / CELL) + 1);
			for (let j = j0; j <= j1; j++) {
				const dx = Math.max(Math.abs(hx - (x1 - (j + 0.5) * CELL)) - CELL / 2, 0);
				for (let i = i0; i <= i1; i++) {
					const dy = Math.max(Math.abs(hy - (y1 - (i + 0.5) * CELL)) - CELL / 2, 0);
					if (dx * dx + dy * dy <= r * r) g[j * TILE_CELLS + i] |= bit;
				}
			}
		}
	}
	t.ground = g;
	return g;
}

// The road mask of continent c (roadmask.js over the roads layer: the columns the walking maps
// call road), kept in <dir>/walk/roads-<c>-<tag>.bin: per tile with a road its col and row
// (uint16 each) and 8192 bytes, one bit per column (k = j * 256 + i). The tag names the layer, the
// grid's build and roadmask.js; no layer, no file and no road.
function roadsTag(dir, roadsDir = ROADS_DIR) {
	const idx = path.join(roadsDir, 'index.json');
	if (!fs.existsSync(idx)) return 'none';
	let built = '';
	try {
		built = JSON.parse(fs.readFileSync(path.join(dir, 'index.json'), 'utf8')).builtAt;
	} catch {
		built = '';
	}
	return crypto.createHash('sha1').update(fs.readFileSync(idx)).update(`\n${built}\n`).update(fs.readFileSync(path.join(__dirname, 'roadmask.js'))).digest('hex').slice(0, 16);
}

const roadsFile = (dir, c, tag) => path.join(dir, 'walk', `roads-${c}-${tag}.bin`);

// Builds continent c's road mask file when missing -> { file, built, seconds, stats }.
function buildRoads(dir, c, { log, roadsDir = ROADS_DIR } = {}) {
	const tag = roadsTag(dir, roadsDir);
	const file = roadsFile(dir, c, tag);
	if (tag === 'none' || fs.existsSync(file)) return { file, built: false, seconds: 0 };
	const t0 = Date.now();
	const { roadMask } = require('./roadmask');
	const { openNav } = require('./path');
	const index = JSON.parse(fs.readFileSync(path.join(dir, 'index.json'), 'utf8'));
	const tiles = (index.continents[c] && index.continents[c].tiles) || [];
	const weights = (col, row) => {
		const f = path.join(roadsDir, String(c), `${tileKey(col, row)}.bin`);
		return fs.existsSync(f) ? fs.readFileSync(f) : null;
	};
	const mask = roadMask({ c, tiles, weights, nav: openNav({ dir, cacheTiles: 16 }), log: log || (() => {}) });
	const parts = [];
	for (const [key, m] of mask) {
		const bits = Buffer.alloc(4 + TILE_CELLS * TILE_CELLS / 8);
		let any = false;
		for (let k = 0; k < m.length; k++) {
			if (!m[k]) continue;
			bits[4 + (k >> 3)] |= 1 << (k & 7);
			any = true;
		}
		if (!any) continue;
		const [col, row] = key.split('_').map(Number);
		bits.writeUInt16LE(col, 0);
		bits.writeUInt16LE(row, 2);
		parts.push(bits);
	}
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(`${file}.tmp`, Buffer.concat(parts));
	fs.renameSync(`${file}.tmp`, file);
	const seconds = (Date.now() - t0) / 1000;
	if (log) log(`  router: road mask of continent ${c}: ${parts.length} tiles, ${seconds.toFixed(0)} s: ${path.relative(ROOT, file)}`);
	return { file, built: true, seconds, stats: mask.stats };
}

// (c, col, row) -> the tile's road bits (Uint8Array(8192)) or null, read once per continent from
// its road mask file (none built yet: no road, until prepare builds it).
function readRoads(dir, tag) {
	const byC = new Map();
	return (c, col, row) => {
		let m = byC.get(c);
		if (!m) {
			m = new Map();
			const file = roadsFile(dir, c, tag);
			if (tag !== 'none' && fs.existsSync(file)) {
				const b = fs.readFileSync(file);
				const n = 4 + TILE_CELLS * TILE_CELLS / 8;
				for (let o = 0; o + n <= b.length; o += n) m.set(b.readUInt16LE(o) * 65536 + b.readUInt16LE(o + 2), new Uint8Array(b.buffer, b.byteOffset + o + 4, n - 4));
			}
			byC.set(c, m);
		}
		return m.get(col * 65536 + row) || null;
	};
}

// (c, areaId) -> uiMapID as the walking maps' zone field has it (pack.js zoneAreas over the newest
// cached AreaTable and data/forever/zones.json), or null without them.
function areaZones() {
	const { loadAreas } = require('../data/areas');
	const { DATA, SOURCES } = require('../paths');
	const file = path.join(DATA, 'zones.json');
	const areas = fs.existsSync(file) ? loadAreas(SOURCES) : null;
	if (!areas) return null;
	const { zoneAreas } = require('./pack');
	const rows = [...areas.byId.values()].map((a) => ({ ID: a.id, ParentAreaID: a.parent }));
	return { build: areas.build, zone: zoneAreas({ areaTable: rows, zones: JSON.parse(fs.readFileSync(file, 'utf8')) }), file };
}

// The router's zones as a table (the Rust walk store's input): { tag (router.js zonesTag), zones:
// { areaId: uiMapID } for every AreaTable area with a zone }, or null without the AreaTable.
function areaZoneTable() {
	const { loadAreas } = require('../data/areas');
	const { DATA, SOURCES } = require('../paths');
	const az = areaZones();
	if (!az) return null;
	const zones = {};
	for (const id of loadAreas(SOURCES).byId.keys()) {
		const z = az.zone(0, id);
		if (z) zones[id] = z;
	}
	const tag = crypto.createHash('sha1').update(`${az.build}\n`).update(fs.readFileSync(path.join(DATA, 'zones.json'))).digest('hex').slice(0, 12);
	return { tag, zones };
}

function readHubs(hubs) {
	let doc = hubs;
	if (doc === undefined) doc = fs.existsSync(HUBS_FILE) ? JSON.parse(fs.readFileSync(HUBS_FILE, 'utf8')) : null;
	const disks = new Map([['Alliance', new Map()], ['Horde', new Map()]]);
	const byC = new Map(); // c -> [{ id, name, areaId, side, disks }] (route's hub report)
	for (const [c, list] of Object.entries(doc || {})) {
		if (!Array.isArray(list)) continue;
		for (const hub of list) {
			const m = disks.get(hub.side);
			if (!m) continue;
			if (!m.has(Number(c))) m.set(Number(c), []);
			m.get(Number(c)).push(...hub.disks);
			if (!byC.has(Number(c))) byC.set(Number(c), []);
			byC.get(Number(c)).push(hub);
		}
	}
	// A side's disks reaching tile (col, row) of continent c: flat [wx, wy, r, ...] or null, kept.
	const nearMemo = new Map();
	const near = (side, c, col, row) => {
		const k = `${side}|${c}|${col}|${row}`;
		if (nearMemo.has(k)) return nearMemo.get(k);
		const xHi = (32 - row) * ADT;
		const yHi = (32 - col) * ADT;
		const out = [];
		for (const [hx, hy, r] of disks.get(side).get(Number(c)) || []) if (hx + r >= xHi - ADT && hx - r <= xHi && hy + r >= yHi - ADT && hy - r <= yHi) out.push(hx, hy, r);
		const v = out.length ? out : null;
		nearMemo.set(k, v);
		return v;
	};
	// The hubs of `side` on continent c that the drawn line pts (Float32Array x, y, z per point)
	// enters: a piece of it inside one of the hub's disks -> [{ id, name, areaId }], each hub once,
	// in path order (Routing/Path.lua hubsOn).
	const entered = (side, c, pts) => {
		const out = [];
		const listed = new Set();
		const hubs = (byC.get(Number(c)) || []).filter((h) => h.side === side);
		for (let p = 3; p < pts.length && listed.size < hubs.length; p += 3) {
			const ax = pts[p - 3];
			const ay = pts[p - 2];
			const dx = pts[p] - ax;
			const dy = pts[p + 1] - ay;
			const L2 = dx * dx + dy * dy;
			for (const h of hubs) {
				if (listed.has(h)) continue;
				for (const [hx, hy, r] of h.disks) {
					const f = L2 > 0 ? Math.max(0, Math.min(1, ((hx - ax) * dx + (hy - ay) * dy) / L2)) : 0;
					if (Math.hypot(ax + dx * f - hx, ay + dy * f - hy) > r) continue;
					listed.add(h);
					out.push({ id: h.id, name: h.name, areaId: h.areaId });
					break;
				}
			}
		}
		return out;
	};
	return { doc, disks, near, entered };
}

function fingerprintOf(dir, hubDoc, az, roads) {
	const h = crypto.createHash('sha1');
	for (const f of ['index.json', 'lifts.json']) {
		const file = path.join(dir, f);
		h.update(`\n${f}\n`).update(fs.existsSync(file) ? fs.readFileSync(file) : '');
	}
	const gdir = path.join(dir, 'graph');
	for (const f of fs.existsSync(gdir) ? fs.readdirSync(gdir).sort() : []) h.update(`\n${f}:${fs.statSync(path.join(gdir, f)).size}`);
	h.update(`\nhubs\n${JSON.stringify(hubDoc || null)}`);
	h.update(`\nroads\n${roads}`);
	h.update(`\nzones\n${az ? `${az.build}\n${fs.readFileSync(az.file, 'utf8')}` : ''}`);
	for (const f of CODE) h.update(`\n${f}\n`).update(fs.readFileSync(path.join(__dirname, f)));
	return h.digest('hex');
}

function open(dir = GRID_DIR, { format = 2, shared = null, zones = null, hubs, roadsDir = ROADS_DIR, fingerprint = true } = {}) {
	if (format === 4) return require('./nav4').open(dir, { shared, zones, hubs });
	if (format !== 2) throw new Error(`router: no router for format ${format}`);
	const { openNav } = require('./path');
	const nav = openNav({ dir, shared, cacheTiles: shared ? 64 : 256 });
	const hubSet = readHubs(hubs);
	const roads = roadsTag(dir, roadsDir);
	const roadMask = readRoads(dir, roads);
	const hubsTag = crypto.createHash('sha1').update(JSON.stringify(hubSet.doc || null)).digest('hex').slice(0, 12);
	// Zones: a chunk's AreaTable area up to its zone, as the walking maps' zone field (areaZones);
	// without the AreaTable, `zones` (the sim world's 200 yd danger grids).
	const az = areaZones();
	// The zones the zone mix (path.js zoneMix) was measured with: the AreaTable's build and zones.json.
	const zonesTag = az ? crypto.createHash('sha1').update(`${az.build}\n`).update(fs.readFileSync(az.file)).digest('hex').slice(0, 12) : 'grid';
	const byC = new Map();
	for (const g of zones || []) {
		if (!byC.has(g.c)) byC.set(g.c, []);
		byC.get(g.c).push(g);
	}
	const gridZone = (c, wx, wy) => {
		for (const g of byC.get(c) || []) {
			const gx = Math.floor(wx / g.cell) - g.gx0;
			const gy = Math.floor(wy / g.cell) - g.gy0;
			if (gx >= 0 && gy >= 0 && gx < g.nx && gy < g.ny && g.z[gx * g.ny + gy]) return g.z[gx * g.ny + gy];
		}
		return 0;
	};
	const zs = {
		// The zone of each of tile t's 16 x 16 chunks (chunk (j >> 4) * 16 + (i >> 4)), kept on the tile.
		chunks(t) {
			if (t.chunkZone) return t.chunkZone;
			const z = new Uint16Array(256);
			for (let ch = 0; ch < 256; ch++) {
				z[ch] = az && t.areas ? az.zone(t.c, t.areas[ch]) : gridZone(t.c, (32 - t.row) * ADT - ((ch >> 4) * 16 + 8) * CELL, (32 - t.col) * ADT - ((ch & 15) * 16 + 8) * CELL);
			}
			t.chunkZone = z;
			return z;
		},
		at(c, wx, wy) {
			const col = Math.floor(32 - wy / ADT);
			const row = Math.floor(32 - wx / ADT);
			const t = nav.tile(c, col, row);
			if (!t) return gridZone(c, wx, wy);
			const j = Math.floor(((32 - row) * ADT - wx) / CELL);
			const i = Math.floor(((32 - col) * ADT - wy) / CELL);
			return this.chunks(t)[((j >> 4) << 4) + (i >> 4)];
		},
	};
	// Profiles by faction, danger and move profile, built once each (the area's caches live on
	// them): the move profile with the walk graphs' face prices, the ground term (edgecost.js
	// stepMult over groundOf's class bytes: road, the faction's hostile hubs) and the danger area.
	const profiles = new Map();
	const profileOf = (pr = {}) => {
		const move = pr.move || null;
		const faction = pr.faction === 'Alliance' || pr.faction === 'Horde' ? pr.faction : null;
		const k = `${metricKey({ faction, danger: pr.danger || null })}|${move ? move.name : 'foot'}`;
		let p = profiles.get(k);
		if (p) return p;
		const ground = (t, kk, flags) => stepMult((t.ground || groundOf(t, roadMask, hubSet))[kk], flags, faction);
		const zoneOf = (t, kk) => zs.chunks(t)[((kk >> 12) << 4) + ((kk & 255) >> 4)];
		const base = {
			...(move || profileFor({})), ...WALK, ground, groundKey: `${MODEL}|${roads}|${hubsTag}|${faction || '-'}`, minMult: MIN_MULT, faction,
			zoneOf, mixKey: `${MODEL}|${roads}|${hubsTag}|${move ? move.name : 'foot'}|${zonesTag}`,
		};
		const area = makeArea(pr.danger || null, zs);
		p = area ? { ...base, area } : base;
		profiles.set(k, p);
		if (profiles.size > 256) profiles.delete(profiles.keys().next().value);
		return p;
	};
	const run = (p) => (p.run || RUN);
	// Points snapped once each (a walk point is many searches' end); a snapped point as it is.
	const snaps = new Map();
	const snapOf = (pt) => {
		const q = asPoint(pt);
		if (!q || q.entry !== undefined) return q;
		const k = `${q.c}|${q.wx}|${q.wy}|${q.z}|${q.under}|${q.stand}|${q.prefer || ''}`;
		let s = snaps.get(k);
		if (s === undefined) {
			s = nav.snap(q);
			snaps.set(k, s);
			if (snaps.size > 200000) snaps.delete(snaps.keys().next().value);
		}
		return s;
	};
	const router = {
		format: 2,
		backend: 'js',
		available: nav.available,
		nav,
		smooth: SMOOTH,
		fingerprint: fingerprint ? fingerprintOf(dir, hubSet.doc, az, roads) : null,
		profile: profileOf,
		metricKey(profile = {}) {
			const p = profileOf(profile);
			return `${p.groundKey}|${metricKey({ danger: profile.danger || null })}|${p.name}`;
		},
		distanceRows(rows, profile, { cells = false } = {}) {
			const p = profileOf(profile);
			return rows.map(({ source, targets }) => {
				const r = nav.routeMany(snapOf(source), targets.map(snapOf), p, { cellOf: cells ? cellKey : null });
				const costs = new Float64Array(targets.length);
				const seconds = new Float64Array(targets.length);
				for (let j = 0; j < targets.length; j++) {
					seconds[j] = r.seconds[j] < 0 ? -1 : r.seconds[j];
					costs[j] = r.seconds[j] < 0 ? -1 : r.seconds[j] * run(p);
				}
				return { costs, seconds, yards: r.yards, cells: cells ? r.cells : null };
			});
		},
		distanceTable(sources, targets, profile, { cells = false } = {}) {
			const S = sources.length;
			const T = targets.length;
			const p = profileOf(profile);
			const out = { costs: new Float64Array(S * T).fill(-1), seconds: new Float64Array(S * T).fill(-1), yards: new Float64Array(S * T).fill(-1), cells: cells ? new Array(S * T).fill(null) : null };
			const tg = targets.map(snapOf);
			for (let i = 0; i < S; i++) {
				const r = nav.routeMany(snapOf(sources[i]), tg, p, { cellOf: cells ? cellKey : null });
				for (let j = 0; j < T; j++) {
					if (r.seconds[j] < 0) continue;
					const k = i * T + j;
					out.seconds[k] = r.seconds[j];
					out.costs[k] = r.seconds[j] * run(p);
					out.yards[k] = r.yards[j];
					if (cells) out.cells[k] = r.cells[j];
				}
			}
			return out;
		},
		route(a, b, profile) {
			const p = profileOf(profile);
			const r = nav.route(snapOf(a), snapOf(b), p);
			r.cost = r.ok ? r.seconds * run(p) : -1;
			const hostile = p.faction === 'Horde' ? 'Alliance' : p.faction === 'Alliance' ? 'Horde' : null;
			r.hubs = r.ok && hostile ? hubSet.entered(hostile, r.from.c, r.pts) : [];
			return r;
		},
		edgeCosts(c, profile) {
			const p = profileOf(profile);
			const g = nav.graph(c);
			if (!g) return null;
			const { off, to } = g.graphs[0];
			const secs = nav.edgeSecs(c, g, 0, p);
			const dm = nav.coarseDanger(c, g, 0, p);
			const out = new Float64Array(to.length);
			for (let u = 0; u + 1 < off.length; u++) {
				for (let x = off[u]; x < off[u + 1]; x++) {
					out[x] = secs[x] * (dm ? dm(x, u) : 1) * run(p);
				}
			}
			return out;
		},
		routeMany(from, targets, profile, { limit, cells = false } = {}) {
			const p = profileOf(profile);
			const r = nav.routeMany(snapOf(from), targets.map(snapOf), p, { limit, cellOf: cells ? cellKey : null });
			const costs = new Float64Array(r.seconds.length);
			for (let i = 0; i < costs.length; i++) costs[i] = r.seconds[i] < 0 ? -1 : r.seconds[i] * run(p);
			return { yards: r.yards, costs, cells: r.cells };
		},
		heightAt(c, wx, wy, nearZ = null) {
			const s = nav.snap({ c, wx, wy, z: nearZ });
			return s ? s.z : NaN;
		},
		zoneAt(c, wx, wy) {
			return zs.at(c, wx, wy);
		},
		// Every zone with a chunk in a tile that reaches into the ellipse of points whose distances
		// to a and b add up to at most D (a superset: whole tiles): the zones a way of at most D
		// yards from a to b can enter. a, b: { wx, wy }. -> sorted zone ids
		zonesNear(c, a, b, D) {
			const out = new Set();
			const cMin = Math.floor(32 - (Math.max(a.wy, b.wy) + D) / ADT);
			const cMax = Math.floor(32 - (Math.min(a.wy, b.wy) - D) / ADT);
			const rMin = Math.floor(32 - (Math.max(a.wx, b.wx) + D) / ADT);
			const rMax = Math.floor(32 - (Math.min(a.wx, b.wx) - D) / ADT);
			const rectDist = (x0, x1, y0, y1, p) => Math.hypot(Math.max(x0 - p.wx, 0, p.wx - x1), Math.max(y0 - p.wy, 0, p.wy - y1));
			for (let col = Math.max(0, cMin); col <= Math.min(63, cMax); col++) {
				for (let row = Math.max(0, rMin); row <= Math.min(63, rMax); row++) {
					const x1 = (32 - row) * ADT;
					const y1 = (32 - col) * ADT;
					if (rectDist(x1 - ADT, x1, y1 - ADT, y1, a) + rectDist(x1 - ADT, x1, y1 - ADT, y1, b) > D) continue;
					const t = nav.tile(c, col, row);
					if (!t) continue;
					if (!t.zoneList) t.zoneList = [...new Set(zs.chunks(t))].filter((z) => z);
					for (const z of t.zoneList) out.add(z);
				}
			}
			return [...out].sort((x, y) => x - y);
		},
	};
	return router;
}

// The walk graphs prepare built (one per faction) and each graph's zone mix go into the store
// too: one copy for every worker.
function share(dir = GRID_DIR, continents, { format = 2 } = {}) {
	if (format === 4) return require('./nav4').share(dir, continents);
	const { shareNav, edgeKey, decodeMix } = require('./path');
	const store = shareNav(dir, continents);
	const r = open(dir, { shared: store, fingerprint: false });
	for (const c of store.continents) {
		if (!store.graphs[c]) continue;
		store.graphs[c].walk = {};
		for (const faction of FACTIONS) {
			const p = r.profile({ faction });
			const file = r.nav.walkGraphFile(c, 0, p);
			if (!fs.existsSync(file)) continue;
			const buf = fs.readFileSync(file);
			const s = new Float32Array(new SharedArrayBuffer(buf.byteLength));
			s.set(new Float32Array(buf.buffer, buf.byteOffset, buf.byteLength / 4));
			store.graphs[c].walk[edgeKey(0, p)] = s;
		}
		const mix = r.nav.walkMixFile(c, 0, r.profile({}));
		if (fs.existsSync(mix)) store.graphs[c].mix = { 0: decodeMix(fs.readFileSync(mix), true) };
	}
	return store;
}

// The bytes a share() store holds in shared memory.
function sharedBytes(store) {
	const seen = new Set();
	let n = 0;
	const walk = (o) => {
		for (const v of Object.values(o)) {
			if (ArrayBuffer.isView(v)) {
				if (!seen.has(v.buffer)) {
					seen.add(v.buffer);
					n += v.buffer.byteLength;
				}
			} else if (v && typeof v === 'object') walk(v);
		}
	};
	walk(store);
	return n;
}

// The fingerprint open(dir) would give, without opening the maps.
function fingerprint(dir = GRID_DIR, { format = 2, hubs, roadsDir = ROADS_DIR } = {}) {
	if (format === 4) return require('./nav4').fingerprint(dir);
	return fingerprintOf(dir, readHubs(hubs).doc, areaZones(), roadsTag(dir, roadsDir));
}

// Whether prepare(dir, continents) has nothing left to build (every road mask, walk graph and zone
// mix of this router's cost model is there).
function prepared(dir = GRID_DIR, continents, { hubs, roadsDir = ROADS_DIR } = {}) {
	const tag = roadsTag(dir, roadsDir);
	const r = open(dir, { fingerprint: false, hubs, roadsDir });
	const has = (c) => (tag === 'none' || fs.existsSync(roadsFile(dir, c, tag))) && fs.existsSync(r.nav.walkMixFile(c, 0, r.profile({})))
		&& FACTIONS.every((faction) => fs.existsSync(r.nav.walkGraphFile(c, 0, r.profile({ faction }))));
	return continents.every((c) => !fs.existsSync(path.join(dir, 'graph', `${c}.bin.gz`)) || has(c));
}

// Tile batches ([t0, t1) of a graph's tiles) on `workers` threads of this file (workerData: the
// job, repriceWorker set) -> Promise; onDone(msg, done) after each batch.
function runBatches(todo, workers, data, onDone) {
	let next = 0;
	let done = 0;
	return new Promise((resolve, reject) => {
		const W = Math.max(1, Math.min(workers, todo.length));
		let live = W;
		const threads = Array.from({ length: W }, () => new Worker(__filename, { workerData: { repriceWorker: true, ...data } }));
		const feed = (w) => {
			if (next >= todo.length) {
				w.terminate();
				if (--live === 0) resolve();
				return;
			}
			const job = todo[next++];
			w.once('message', (msg) => {
				if (msg.error) {
					threads.forEach((x) => x.terminate());
					reject(new Error(msg.error));
					return;
				}
				onDone(msg, ++done);
				feed(w);
			});
			w.postMessage(job);
		};
		for (const w of threads) {
			w.once('error', reject);
			feed(w);
		}
	});
}

// The road masks (buildRoads), walk graphs and zone mixes the router routes on (path.js edgeSecs,
// zoneMix), built where missing for the continents, into <dir>/walk/. A walk graph holds every
// coarse edge's seconds for one faction (edgecost.js: time, faces, roads and that faction's
// hostile hubs): each tile's edges searched again with those prices (repriceTiles), on `workers`
// threads over the graph in shared memory (the tiles read as reached). The factionless one first;
// a faction's is a copy of it with only the tiles a hostile hub's disk reaches, and their
// neighbours, searched again. The zone mix: the shares of each edge's way's seconds per zone, on
// the factionless walk graph's ways (mixTiles).
// -> [{ c, faction, file, built, seconds }] (faction 'mix': the zone mix)
async function prepare(dir = GRID_DIR, continents, { workers = 4, log, hubs, roadsDir = ROADS_DIR } = {}) {
	const { shareNav } = require('./path');
	for (const c of continents) buildRoads(dir, c, { log, roadsDir });
	const r = open(dir, { fingerprint: false, hubs, roadsDir });
	const { nav } = r;
	const gi = 0;
	const out = [];
	for (const c of continents) {
		const g = nav.graph(c);
		if (!g) continue;
		let base = null;
		let store = null;
		for (const faction of FACTIONS) {
			const p = r.profile({ faction });
			const file = nav.walkGraphFile(c, gi, p);
			if (fs.existsSync(file)) {
				out.push({ c, faction, file, built: false, seconds: 0 });
				continue;
			}
			const t0 = Date.now();
			if (!store) store = shareNav(dir, [c], { tiles: false });
			const T = g.tiles.length;
			const secs = new Float32Array(new SharedArrayBuffer(g.graphs[gi].to.length * 4));
			let only = null;
			if (faction) {
				if (!base) {
					const b = fs.readFileSync(nav.walkGraphFile(c, gi, r.profile({ faction: null })));
					base = new Float32Array(b.buffer, b.byteOffset, b.byteLength / 4);
				}
				secs.set(base);
				const hostile = faction === 'Horde' ? 'Alliance' : 'Horde';
				const hubSet = readHubs(hubs);
				only = new Uint8Array(new SharedArrayBuffer(T));
				const at = new Map(g.tiles.map((t, i) => [t.col * 65536 + t.row, i]));
				for (const t of g.tiles) {
					if (!hubSet.near(hostile, c, t.col, t.row)) continue;
					for (let dc = -1; dc <= 1; dc++) for (let dr = -1; dr <= 1; dr++) if (at.has((t.col + dc) * 65536 + t.row + dr)) only[at.get((t.col + dc) * 65536 + t.row + dr)] = 1;
				}
			}
			const todo = [];
			for (let t = 0; t < T; t += 8) if (!only || only.subarray(t, t + 8).some((x) => x)) todo.push([t, Math.min(T, t + 8)]);
			await runBatches(todo, workers, { dir, store, c, gi, secs, faction, only, hubs, roadsDir }, (msg, done) => {
				if (log && done % 25 === 0) log(`  router: walk graph of continent ${c} (${faction || 'no faction'}): ${done}/${todo.length} tile batches, ${((Date.now() - t0) / 1000).toFixed(0)} s`);
			});
			fs.mkdirSync(path.dirname(file), { recursive: true });
			fs.writeFileSync(`${file}.tmp`, Buffer.from(secs.buffer));
			fs.renameSync(`${file}.tmp`, file);
			if (!faction) base = secs;
			const seconds = (Date.now() - t0) / 1000;
			if (log) log(`  router: walk graph of continent ${c} (${faction || 'no faction'}) built in ${seconds.toFixed(0)} s: ${path.relative(ROOT, file)}`);
			out.push({ c, faction, file, built: true, seconds });
		}
		const mixFile = nav.walkMixFile(c, gi, r.profile({}));
		if (fs.existsSync(mixFile)) {
			out.push({ c, faction: 'mix', file: mixFile, built: false, seconds: 0 });
			continue;
		}
		const t0 = Date.now();
		if (!store) store = shareNav(dir, [c], { tiles: false });
		const { to } = g.graphs[gi];
		const nodeZone = new Uint16Array(new SharedArrayBuffer(2 * g.nodeEntry.length));
		const parts = [];
		const todo = [];
		for (let t = 0; t < g.tiles.length; t += 8) todo.push([t, Math.min(g.tiles.length, t + 8)]);
		await runBatches(todo, workers, { dir, store, c, gi, mix: nodeZone, hubs, roadsDir }, (msg, done) => {
			parts.push(msg);
			if (log && done % 25 === 0) log(`  router: zone mix of continent ${c}: ${done}/${todo.length} tile batches, ${((Date.now() - t0) / 1000).toFixed(0)} s`);
		});
		const off = new Uint32Array(to.length + 1);
		for (const m of parts) for (const x of m.x) off[x + 1]++;
		for (let x = 0; x < to.length; x++) off[x + 1] += off[x];
		const fill = off.slice(0, to.length);
		const zone = new Uint16Array(off[to.length]);
		const frac = new Float32Array(off[to.length]);
		for (const m of parts) {
			for (let i = 0; i < m.x.length; i++) {
				const y = fill[m.x[i]]++;
				zone[y] = m.z[i];
				frac[y] = m.f[i];
			}
		}
		const { encodeMix } = require('./path');
		fs.writeFileSync(`${mixFile}.tmp`, encodeMix({ nodeZone, off, zone, frac }));
		fs.renameSync(`${mixFile}.tmp`, mixFile);
		const seconds = (Date.now() - t0) / 1000;
		if (log) log(`  router: zone mix of continent ${c} built in ${seconds.toFixed(0)} s (${zone.length} entries on ${to.length} edges): ${path.relative(ROOT, mixFile)}`);
		out.push({ c, faction: 'mix', file: mixFile, built: true, seconds });
	}
	return out;
}

if (!isMainThread && workerData && workerData.repriceWorker) {
	const { dir, store, c, gi, secs, faction, only, mix, hubs, roadsDir } = workerData;
	const r = open(dir, { shared: store, fingerprint: false, hubs, roadsDir });
	const g = r.nav.graph(c);
	const p = r.profile({ faction });
	const keep = only ? (ti) => only[ti] === 1 : null;
	parentPort.on('message', ([t0, t1]) => {
		try {
			if (!mix) {
				r.nav.repriceTiles(c, g, gi, p, t0, t1, secs, keep);
				parentPort.postMessage({ ok: true });
				return;
			}
			const xs = [];
			const zs = [];
			const fs_ = [];
			r.nav.mixTiles(c, g, gi, p, t0, t1, mix, (x, z, f) => {
				xs.push(x);
				zs.push(z);
				fs_.push(f);
			});
			parentPort.postMessage({ x: Uint32Array.from(xs), z: Uint16Array.from(zs), f: Float32Array.from(fs_) });
		} catch (err) {
			parentPort.postMessage({ error: err && err.stack ? err.stack : String(err) });
		}
	});
}

module.exports = { open, share, sharedBytes, fingerprint, prepare, prepared, buildRoads, dangerOf, cellKey, cellXY, ZONE_CELL, GRID_DIR, HUBS_FILE, HUB, SMOOTH, FACE, CLIMB, WALK, roadsTag, areaZoneTable };
