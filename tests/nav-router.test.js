'use strict';
// Polestar's walking router (addon/Polestar_Nav/Routing) prices a step by
// the ground class of the node it enters and the player's faction
// (Routing/Costs.lua): on synthetic one-tile maps written by pack.js
// (encodeMaps + packFiles) with a hand-made `class` field (maps format 2),
// a road is taken while it is at most 1/0.8 = 1.25 times the straight way,
// a hostile hub is gone round and one's own crossed, and a map without the
// field (format 1, 0.2.4's) routes exactly as the router did before it
// priced classes (the base commit's Routing files, from git). The fifth
// argument of Find, FindCost and FindMany is today's waterWalking flag or an
// opts table { waterWalking, profile }. Every result carries yards beside its
// cost (Find: the drawn line's length; FindCost, FindMany: a label along the
// cost-best path, the cost itself on format 1), a format 2 graph edge is
// priced per profile (hand-made edge records), Find reports the hostile hubs
// of the map's `hubs` metadata its drawn line enters, the drawn line
// straightens only over ground no costlier than the path it replaces (a
// road's bend, a hostile hub's rim), and ReuseMany keeps a batch to the
// profile it was priced for. With the maps' `zone` field, opts.danger
// multiplies a step into a dangerous zone (round it, never closed, graph edges
// by their ends, straightening too, caches and ReuseMany by its signature);
// without it every result is today's; Path.ZoneAt reads a point's zone.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');
const { spawnSync } = require('node:child_process');
const { runAddon, tocEntries, ADDONS, ROOT } = require('./helpers/lua');
const { tmpdir } = require('./helpers/tmp');
const { encodeMaps, packFiles, encodeZones, B64 } = require('../tools/lib/nav/pack');

const NAV = path.join(ADDONS, 'Polestar_Nav');
// The router before it priced classes: pathing-v2's base (origin/next, 0.2.4's router).
const BASE = 'f537d1d';
const C = 128;
const CS = 1600 / 3 / C; // 4.17 yd cells
const MAP = 7;
// The straight strip: row Y0 from X0 to X1, 24 cells (100 yd); the way round
// is a U of depth d above it, sharing the strip's end cells.
const X0 = 20;
const S = 24;
const X1 = X0 + S;
const Y0 = 64;
const at = (x, y) => ({ x: (x + 0.5) * CS, y: (y + 0.5) * CS, z: 0 });
const FROM = at(X0, Y0);
const TO = at(X1, Y0);
// Grid lengths in cells: the strip is S orthogonal steps; the U is d - 1 up,
// a diagonal round each corner, S - 2 across and d - 1 down.
const STRAIGHT = S * CS;
const ROUND = (d) => (S + 2 * d - 4 + 2 * Math.SQRT2) * CS;
// Priced with the U at `mult` except the last step, into the strip's end cell (class 0).
const ROUND_AT = (d, mult) => (mult * (S + 2 * d - 5 + 2 * Math.SQRT2) + 1) * CS;

// Cells of the two ways: { val, cls } by local cell (x * C + y); the strip's
// inner cells take `strip`, the U's cells `round`, the two end cells are plain ground.
function layout(d, strip = {}, round = {}) {
	const cells = new Map();
	const set = (x, y, c) => cells.set(x * C + y, { val: c.val ?? 1, cls: c.cls ?? 0 });
	for (let x = X0; x <= X1; x++) set(x, Y0, x === X0 || x === X1 ? {} : strip);
	for (let y = Y0 - d; y < Y0; y++) {
		set(X0, y, round);
		set(X1, y, round);
	}
	for (let x = X0 + 1; x < X1; x++) set(x, Y0 - d, round);
	return cells;
}

// pack.js's run-length symbols (the grid field's): a symbol >= 48 repeats the previous value.
function runLength(vals) {
	let out = '';
	for (let i = 0; i < vals.length; ) {
		let j = i + 1;
		while (j < vals.length && vals[j] === vals[i]) j++;
		out += B64[vals[i]];
		for (let r = j - i - 1; r > 0; r -= 16) out += B64[48 + Math.min(r, 16) - 1];
		i = j;
	}
	return out;
}

// A map of `cells` (by cell gx * C + gy: one tile, or `nx` tiles along x; no
// floors), written by pack.js as `nav pack` writes a map; with `classes` it
// carries the format 2 `class` field (one byte per node, run-length, zlib,
// base64). `graph` holds a cluster's hand-made graph string by cluster
// (index k + 1; Routing/PathGrid.lua's adjacent defines the records), `hubs`
// the metadata's `hubs` list as Lua, `zones(k, q)` the uiMapID of cluster k's
// chunk q ((cx // 8) * 16 + (cy // 8)) for the metadata's `zone` field, as
// pack.js encodes it (encodeZones; a cluster of all 0 gets none). -> the Lua
// files, in load order.
function mapFiles(cells, classes, { nx = 1, graph = null, hubs = null, zones = null } = {}) {
	const tiles = [];
	for (let k = 0; k < nx; k++) {
		tiles.push({
			cl: { val: new Uint8Array(C * C), flags: new Uint8Array(C * C), zq: new Int32Array(C * C), floorStart: 0, floorEnd: 0 },
			cls: new Array(C * C).fill(0),
		});
	}
	for (const [g, c] of cells) {
		const t = tiles[Math.floor(g / (C * C))];
		const l = g % (C * C);
		t.cl.val[l] = c.val;
		t.cls[l] = c.cls;
	}
	const cg = { C, NX: nx, NY: 1, GW: nx * C, GH: C, CX0: 0, CY0: 0, clusters: new Map(tiles.map((t, k) => [k, t.cl])), linkedOf: new Map() };
	const maps = encodeMaps(cg, { nodes: new Map(), edges: new Map() });
	const { files } = packFiles({ map: MAP, cg, maps, global: 'PolestarPathData', gen: '-- tests/nav-router.test.js' });
	const block = (s) => zlib.deflateSync(Buffer.from(s, 'ascii'), { level: 9 }).toString('base64');
	const meta = files[0][1];
	let edited = meta;
	const lines = [];
	if (classes) {
		edited = edited.replace('\tfloor = {},\n', '\tfloor = {},\n\tclass = {},\n').replace(/(\tcounts = \{ [^}]*?) \},/, `$1, class = ${nx} },`).replace('floor = {} },', 'floor = {}, class = {} },');
		tiles.forEach((t, k) => lines.push(`data.packed.class[${k + 1}] = {"${block(runLength(t.cls))}"}`));
	}
	if (graph) {
		edited = edited.replace('counts = { graph = 0,', `counts = { graph = ${graph.filter(Boolean).length},`);
		graph.forEach((s, i) => s && lines.push(`data.packed.graph[${i + 1}] = {"${block(s)}"}`));
	}
	if (hubs) edited = edited.replace('\tcounts = {', `\thubs = ${hubs},\n\tcounts = {`);
	if (zones) {
		const rows = [];
		for (let k = 0; k < nx; k++) {
			const z = Array.from({ length: 256 }, (_, q) => zones(k, q));
			if (z.some(Boolean)) rows.push(`\t\t[${k + 1}] = "${encodeZones(z)}",`);
		}
		edited = edited.replace('\tcounts = {', `\tzone = {\n${rows.join('\n')}\n\t},\n\tcounts = {`);
	}
	assert.equal(edited === meta, !classes && !graph && !hubs && !zones);
	files[0][1] = edited;
	const last = files[files.length - 1];
	last[1] = last[1].replace('-- stylua: ignore end\n', `${lines.map((l) => `${l}\n`).join('')}-- stylua: ignore end\n`);
	const dir = tmpdir('polestar-router-');
	return files.map(([name, text]) => {
		const file = path.join(dir, name);
		fs.writeFileSync(file, text);
		return file;
	});
}

// pack.js's base64 number of `width` symbols.
const enc = (v, width) => {
	let s = '';
	for (let i = 0; i < width; i++) s = B64[Math.floor(v / 64 ** i) % 64] + s;
	return s;
};

const lua = (p) => `{ x = ${p.x}, y = ${p.y}, z = ${p.z} }`;
// One query: kind find (points and cost), cost (FindCost) or many (FindMany's one target); opts the fifth argument, Lua.
const q = (id, kind, opts = 'nil') => ({ id, kind, opts });
// Each result keeps the job's yards (FindMany's for its one target) and hubs when the router gives them.
const CALL = {
	find: (id, opts) => `Path.Find(${MAP}, A, B, function(points, cost, job) out[${JSON.stringify(id)}] = { cost = str(cost), points = flat(points), yards = job and str(job.yards), hubs = job and job.hubs } end, ${opts})`,
	cost: (id, opts) => `Path.FindCost(${MAP}, A, B, function(cost, reason, job) out[${JSON.stringify(id)}] = { cost = str(cost or reason), yards = job and str(job.yards) } end, ${opts})`,
	many: (id, opts) => `Path.FindMany(${MAP}, A, { B }, function(costs, reason, job) out[${JSON.stringify(id)}] = { cost = str(costs[1] or reason), yards = job and job.yards and str(job.yards[1]) } end, ${opts})`,
};

// Runs the queries on the map files with the router `addon` (a runAddon entry) -> { [id]: { cost, points?, yards?,
// hubs? } }, costs, yards and coordinates as %.17g strings so two routers compare exactly; then `tail` (Lua, may
// add to out).
function route(addon, files, queries, { from = FROM, to = TO, tail = '' } = {}) {
	const script = `
local Path = Polestar_NavEngine
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local function str(v) return type(v) == "number" and string.format("%.17g", v) or (v ~= nil and tostring(v) or nil) end
local function flat(points)
	if not points then return nil end
	local out = {}
	for i, p in ipairs(points) do out[i] = { str(p.x), str(p.y) } end
	return out
end
local A, B = ${lua(from)}, ${lua(to)}
local out = {}
${queries.map((x) => CALL[x.kind](x.id, x.opts)).join('\n')}
while #frames > 0 do table.remove(frames, 1)() end
${tail}
emit(out)`;
	const before = files.map((f) => `dofile(${JSON.stringify(f)})`).join('\n');
	const [out] = runAddon({ stubs: ['stub_encoding.lua'], before, addons: [addon], script }).emitted;
	return out;
}

// Polestar_Nav without its maps: the TOC's Routing files and API.lua.
const OURS = { name: 'Polestar_Nav', files: tocEntries(NAV).filter((f) => !f.endsWith('.xml')) };

const num = (r) => Number(r.cost);
const close = (r, want, what) => assert.ok(Math.abs(num(r) - want) < 1e-9, `${what}: cost ${r.cost}, want ${want}`);
// Straight: every drawn point on the strip's row; round: some point up on the U.
const straight = (r) => r.points.every(([, y]) => Math.abs(Number(y) - FROM.y) < 1e-9);
const round = (r) => r.points.some(([, y]) => Number(y) < FROM.y - 2 * CS);
// The drawn line's flat length.
const drawn = (r) => r.points.reduce((sum, [x, y], i) => (i ? sum + Math.hypot(Number(x) - Number(r.points[i - 1][0]), Number(y) - Number(r.points[i - 1][1])) : 0), 0);
const yardsNear = (got, want, what, tol = 0.5) => assert.ok(Math.abs(Number(got) - want) <= tol, `${what}: yards ${got}, want ${want} (within ${tol})`);

test('Costs.lua: the ground classes, the multipliers and the faction profiles', () => {
	const [got] = runAddon({
		addons: [OURS],
		script: `
local K = Polestar_NavCosts
local function m(c, p) return K.Mult(c, p) end
emit({
	class = K.CLASS, hubs = { K.HUB_ALLIANCE, K.HUB_HORDE }, hub = K.HUB, min = K.MIN,
	mult = { K.MULT[0], K.MULT[1], K.MULT[2], K.MULT[3], K.MULT[4], K.MULT[5] },
	profiles = { K.Profile("Alliance"), K.Profile("Horde"), K.Profile("Neutral") or "nil", K.Profile(nil) or "nil" },
	m = {
		m(0), m(1, "Horde"), m(3, "Alliance"), m(4), m(5, "Horde"),
		m(8 + 1, "Horde"), m(8 + 1, "Alliance"), m(8 + 1), m(16 + 3, "Alliance"), m(16 + 3, "Horde"), m(16 + 3),
		m(8 + 16, "Horde"), m(8 + 16, "Alliance"),
	},
	style = { K.Style(nil), K.Style("fastest"), K.Style("roads"), K.Style("Sideways"), K.Style("balanced") },
	styles = {
		fastest = { mult = { K.STYLES.fastest.MULT[0], K.STYLES.fastest.MULT[1], K.STYLES.fastest.MULT[2], K.STYLES.fastest.MULT[3], K.STYLES.fastest.MULT[4], K.STYLES.fastest.MULT[5] }, min = K.STYLES.fastest.MIN, min2 = K.Min("fastest") },
		balanced = { mult = { K.STYLES.balanced.MULT[0], K.STYLES.balanced.MULT[1], K.STYLES.balanced.MULT[2], K.STYLES.balanced.MULT[3], K.STYLES.balanced.MULT[4], K.STYLES.balanced.MULT[5] }, min = K.STYLES.balanced.MIN, min2 = K.Min(nil) },
		roads = { mult = { K.STYLES.roads.MULT[0], K.STYLES.roads.MULT[1], K.STYLES.roads.MULT[2], K.STYLES.roads.MULT[3], K.STYLES.roads.MULT[4], K.STYLES.roads.MULT[5] }, min = K.STYLES.roads.MIN, min2 = K.Min("roads") },
	},
	ms = { K.Mult(3, nil, "fastest"), K.Mult(1, nil, "roads"), K.Mult(8, "Horde", "roads"), K.Mult(1, "Horde", "Sideways") },
})`,
	}).emitted;
	assert.deepEqual(got.class, { NORMAL: 0, ROAD: 1, GENTLE: 2, STEEP: 3, INDOOR: 4, CITY: 5 });
	assert.deepEqual(got.hubs, [8, 16]);
	assert.equal(got.hub, 20);
	assert.deepEqual(got.mult, [1, 0.8, 1.3, 2.5, 2, 1]);
	assert.equal(got.min, Math.min(...got.mult), 'MIN is the smallest multiplier: the heuristic stays admissible');
	assert.deepEqual(got.profiles, ['Alliance', 'Horde', 'nil', 'nil']);
	assert.deepEqual(got.m, [1, 0.8, 2.5, 2, 1, 16, 0.8, 0.8, 50, 2.5, 2.5, 20, 20]);
	assert.deepEqual(got.style, ['balanced', 'fastest', 'roads', 'balanced', 'balanced'], 'Costs.Style: anything not a style is balanced');
	assert.deepEqual(got.styles.fastest, { mult: [1, 1, 1, 1.2, 2, 1], min: 1, min2: 1 });
	assert.deepEqual(got.styles.balanced, { mult: [1, 0.8, 1.3, 2.5, 2, 1], min: 0.8, min2: 0.8 });
	assert.deepEqual(got.styles.roads, { mult: [1, 0.5, 1.6, 4, 2, 1], min: 0.5, min2: 0.5 });
	for (const [s, v] of Object.entries(got.styles)) assert.ok(v.mult.every((m) => v.min <= m), `${s}: MIN is at most every multiplier`);
	assert.deepEqual(got.ms, [1.2, 0.5, 20, 0.8]);
	const toc = tocEntries(NAV).map((f) => f.replace(/\\/g, '/'));
	assert.ok(toc.indexOf('Routing/Costs.lua') >= 0 && toc.indexOf('Routing/Costs.lua') < toc.indexOf('Routing/PathGrid.lua'), 'Costs.lua loads before the other Routing files');
});

test('format 2: a road is taken while it is at most 1.25 times the straight way (120 yd x 0.8 = 96 < 100), not at 128 yd', () => {
	const road = { cls: 1 };
	const r120 = route(OURS, mapFiles(layout(3, {}, road), true), [q('none', 'find'), q('horde', 'find', '{ profile = "Horde" }'), q('cost', 'cost'), q('many', 'many', '{ profile = "Alliance" }')]);
	assert.ok(ROUND(3) > 1.19 * STRAIGHT && ROUND(3) < 1.21 * STRAIGHT, 'the road is 120 yd');
	for (const id of ['none', 'horde']) {
		assert.ok(round(r120[id]), `${id}: by the road`);
		close(r120[id], ROUND_AT(3, 0.8), id);
	}
	close(r120.cost, ROUND_AT(3, 0.8), 'FindCost');
	close(r120.many, ROUND_AT(3, 0.8), 'FindMany');
	const r130 = route(OURS, mapFiles(layout(4, {}, road), true), [q('none', 'find'), q('alliance', 'find', '{ profile = "Alliance" }')]);
	assert.ok(ROUND(4) > 1.28 * STRAIGHT, 'the road is 128 yd');
	assert.ok(ROUND_AT(4, 0.8) > STRAIGHT);
	for (const id of ['none', 'alliance']) {
		assert.ok(straight(r130[id]), `${id}: the straight strip`);
		close(r130[id], STRAIGHT, id);
	}
});

test('format 2: a Horde player goes round an Alliance hub the Alliance player and no profile cross, and the other way round', () => {
	const queries = [q('none', 'find'), q('alliance', 'find', '{ profile = "Alliance" }'), q('horde', 'find', '{ profile = "Horde" }'), q('hordeMany', 'many', '{ profile = "Horde" }')];
	const alliance = route(OURS, mapFiles(layout(4, { cls: 8 }), true), queries);
	assert.ok(round(alliance.horde), 'Horde: round the Alliance hub');
	close(alliance.horde, ROUND(4), 'Horde');
	close(alliance.hordeMany, ROUND(4), 'Horde, FindMany');
	for (const id of ['alliance', 'none']) {
		assert.ok(straight(alliance[id]), `${id}: through it`);
		close(alliance[id], STRAIGHT, id);
	}
	const horde = route(OURS, mapFiles(layout(4, { cls: 16 }), true), queries);
	assert.ok(round(horde.alliance), 'Alliance: round the Horde hub');
	close(horde.alliance, ROUND(4), 'Alliance');
	for (const id of ['horde', 'none']) {
		assert.ok(straight(horde[id]), `${id}: through it`);
		close(horde[id], STRAIGHT, id);
	}
	// Crossing a hostile hub is still a route when it is the only way: x 20, never closed.
	const strip = new Map([...layout(4, { cls: 8 })].filter(([l]) => l % C === Y0));
	const only = route(OURS, mapFiles(strip, true), [q('horde', 'find', '{ profile = "Horde" }')]);
	close(only.horde, (20 * (S - 1) + 1) * CS, 'Horde through the only way');
});

test('the fifth argument: a boolean is waterWalking (every caller today), a table is opts { waterWalking, profile }', () => {
	const files = mapFiles(layout(4, { val: 2 }), true);
	const got = route(OURS, files, [
		q('swim', 'find'), q('swimHorde', 'find', '{ profile = "Horde" }'), q('walk', 'find', 'true'), q('walkOpts', 'find', '{ waterWalking = true, profile = "Horde" }'),
		q('walkCost', 'cost', 'true'), q('walkCostOpts', 'cost', '{ waterWalking = true }'), q('walkMany', 'many', 'true'), q('walkManyOpts', 'many', '{ waterWalking = true, profile = "Alliance" }'),
	]);
	for (const id of ['swim', 'swimHorde']) {
		assert.ok(round(got[id]), `${id}: round the water`);
		close(got[id], ROUND(4), id);
	}
	for (const id of ['walk', 'walkOpts', 'walkCost', 'walkCostOpts', 'walkMany', 'walkManyOpts']) close(got[id], STRAIGHT, `${id}: on the water`);
});

test('format 1 (no class field): the same points and costs as the router before classes, for any profile', (t) => {
	const show = (rel) => spawnSync('git', ['-C', ROOT, 'show', `${BASE}:addon/Polestar_Nav/${rel}`], { encoding: 'utf8', maxBuffer: 16 * 1024 * 1024 });
	if (show('API.lua').status !== 0) {
		t.skip(`no git history with ${BASE} (not a checkout of the repository)`);
		return;
	}
	const dir = path.join(tmpdir('polestar-router-base-'), 'Polestar_Nav');
	const rels = ['Routing/PathGrid.lua', 'Routing/Path.lua', 'Routing/PathJobs.lua', 'API.lua'];
	fs.mkdirSync(path.join(dir, 'Routing'), { recursive: true });
	for (const rel of rels) {
		const r = show(rel);
		assert.equal(r.status, 0, r.stderr);
		fs.writeFileSync(path.join(dir, rel), r.stdout);
	}
	fs.writeFileSync(path.join(dir, 'Polestar_Nav.toc'), `${rels.join('\n')}\n`);
	const BEFORE = { name: 'Polestar_Nav', dir };
	// The new router's queries, with profiles; the old router takes no opts (a table would be its waterWalking flag).
	const ours = [q('none', 'find'), q('horde', 'find', '{ profile = "Horde" }'), q('alliance', 'find', '{ profile = "Alliance" }'), q('walk', 'find', 'true'), q('walkOpts', 'find', '{ waterWalking = true, profile = "Horde" }'),
		q('cost', 'cost', '{ profile = "Alliance" }'), q('many', 'many', '{ profile = "Horde" }'), q('manyWalk', 'many', 'true')];
	const theirs = [q('none', 'find'), q('horde', 'find'), q('alliance', 'find'), q('walk', 'find', 'true'), q('walkOpts', 'find', 'true'), q('cost', 'cost'), q('many', 'many'), q('manyWalk', 'many', 'true')];
	for (const [what, cells] of [['road', layout(3, {}, { cls: 1 })], ['hub', layout(4, { cls: 8 })], ['water', layout(4, { val: 2 })]]) {
		const files = mapFiles(cells, false);
		const got = route(OURS, files, ours);
		const want = route(BEFORE, files, theirs);
		// Yards and hubs are new; the rest is the old router's.
		for (const r of Object.values(got)) {
			assert.ok(r.yards !== undefined, `${what}: yards present`);
			delete r.yards;
			delete r.hubs;
		}
		assert.deepEqual(got, want, `${what}: identical to the router before classes`);
		close(got.none, what === 'water' ? ROUND(4) : STRAIGHT, `${what}: no classes on format 1`);
	}
	// Straightening across the bends and the hub's rim (the class field dropped): the same drawn points.
	const bends = [bend(12, 12, 0, 2), bend(10, 10, 1, 0)];
	for (const [what, cells, to] of [['90 degree bend', bends[0].cells, bends[0].to], ['45 degree bend', bends[1].cells, bends[1].to], ['rim', rim().cells, at(X0 + 20, Y0 + 8)]]) {
		const files = mapFiles(cells, false);
		const got = route(OURS, files, ours, { to });
		const want = route(BEFORE, files, theirs, { to });
		for (const r of Object.values(got)) {
			delete r.yards;
			delete r.hubs;
		}
		assert.deepEqual(got, want, `${what}: identical to the router before classes`);
		assert.equal(got.none.points.length, 2, `${what}: no classes on format 1, one straight segment`);
	}
});

test('format 1: Find\'s yards are the drawn line\'s length, FindCost\'s and FindMany\'s the cost (no per-step classes), and no hubs', () => {
	for (const [what, cells] of [['road', layout(3, {}, { cls: 1 })], ['water', layout(4, { val: 2 })]]) {
		const got = route(OURS, mapFiles(cells, false), [q('none', 'find'), q('horde', 'find', '{ profile = "Horde" }'), q('walk', 'find', 'true'),
			q('cost', 'cost', '{ profile = "Alliance" }'), q('many', 'many', '{ profile = "Horde" }'), q('manyWalk', 'many', 'true')]);
		for (const id of ['none', 'horde', 'walk']) {
			yardsNear(got[id].yards, drawn(got[id]), `${what} ${id}`, 1e-9);
			assert.deepEqual(got[id].hubs, {}, `${what} ${id}: no hubs`);
		}
		for (const id of ['cost', 'many', 'manyWalk']) assert.equal(got[id].yards, got[id].cost, `${what} ${id}: yards = cost`);
	}
});

test('format 2: yards are the drawn line\'s length under every profile, and FindMany\'s yards (a second label along the cost-best path) match Find\'s', () => {
	const profiles = [['none', 'nil'], ['alliance', '{ profile = "Alliance" }'], ['horde', '{ profile = "Horde" }']];
	for (const [what, cells, want] of [
		['road', layout(3, {}, { cls: 1 }), { none: ROUND(3), alliance: ROUND(3), horde: ROUND(3) }],
		['hub', layout(4, { cls: 8 }), { none: STRAIGHT, alliance: STRAIGHT, horde: ROUND(4) }],
	]) {
		const got = route(OURS, mapFiles(cells, true), profiles.flatMap(([id, opts]) => [q(id, 'find', opts), q(`${id}Many`, 'many', opts), q(`${id}Cost`, 'cost', opts)]));
		for (const [id] of profiles) {
			yardsNear(got[id].yards, drawn(got[id]), `${what} ${id}: the drawn length`);
			yardsNear(got[id].yards, want[id], `${what} ${id}: the way walked`);
			yardsNear(got[`${id}Many`].yards, Number(got[id].yards), `${what} ${id}: FindMany's yards`);
			yardsNear(got[`${id}Cost`].yards, Number(got[id].yards), `${what} ${id}: FindCost's yards`);
		}
		if (what === 'road') assert.ok(Math.abs(num(got.none) - Number(got.none.yards)) > 10, 'road: the cost is not the yards');
	}
});

// Two tiles along x, one strip across their border on row Y0 from gx = C - 12 to C + 12; entrance 0 of each
// cluster at the border (cluster 0's last row, cluster 1's first), one hand-made format 2 edge each way priced
// per profile (costAlliance, costHorde, costNone) with its yards; zone(k), when given, the uiMapID of all cluster k.
const BORDER = { from: at(C - 12, Y0), to: at(C + 12, Y0) };
function borderFiles(costs, yards, zone = null) {
	const cells = new Map();
	for (let x = C - 12; x <= C + 12; x++) cells.set(x * C + Y0, { val: 1, cls: 0 });
	// One entrance: cell(3) layer(1) component(2) degree(1), then its edge: offset(1) node(2) costs 3 x (3) yards(2).
	const cluster = (lx, offset) => enc(1, 2) + enc(lx * C + Y0, 3) + enc(0, 1) + enc(0, 2) + enc(1, 1) + enc(offset, 1) + enc(0, 2) + costs.map((c) => enc(c, 3)).join('') + enc(yards, 2);
	// Offsets (dx + 1) * 3 + dy + 1: +x from cluster 0 is 7, -x from cluster 1 is 1.
	return mapFiles(cells, true, { nx: 2, graph: [cluster(C - 1, 7), cluster(0, 1)], zones: zone && ((k) => zone(k)) });
}

test('format 2: the graph prices an edge per profile (no profile reads costNone) and adds its yards', () => {
	const [A, H, N, Y] = [4, 84, 5, 4];
	const local = 23 * CS; // 11 cells to cluster 0's entrance, 12 from cluster 1's
	const profiles = [['none', 'nil', N], ['alliance', '{ profile = "Alliance" }', A], ['horde', '{ profile = "Horde" }', H], ['walk', 'true', N]];
	const got = route(OURS, borderFiles([A, H, N], Y), profiles.flatMap(([id, opts]) => [q(id, 'find', opts), q(`${id}Many`, 'many', opts), q(`${id}Cost`, 'cost', opts)]), BORDER);
	for (const [id, , edge] of profiles) {
		for (const kind of ['', 'Many', 'Cost']) {
			close(got[id + kind], local + edge, `${id}${kind}`);
		}
		yardsNear(got[`${id}Many`].yards, local + Y, `${id}Many: the label's yards`, 1e-9);
		yardsNear(got[`${id}Cost`].yards, local + Y, `${id}Cost: the label's yards`, 1e-9);
		yardsNear(got[id].yards, 24 * CS, `${id}: the drawn line`, 1e-6);
		yardsNear(got[`${id}Many`].yards, Number(got[id].yards), `${id}: FindMany's yards match Find's`);
	}
});

test('hubs: a Horde route into an Alliance hub reports it (each hub once, in path order), the Alliance and no profile report none', () => {
	// The strip alone (the only way), its middle and its end inside two Alliance hubs listed end first, a Horde hub
	// at the start; the hub bits on the strip's cells as the packer would set them.
	const strip = new Map([...layout(4, { cls: 8 })].filter(([l]) => l % C === Y0));
	const mid = at(X0 + S / 2, Y0);
	const hubs = `{
		{ id = 11, side = "Alliance", name = "Astranaar", disks = { { ${TO.x}, ${TO.y}, 12 }, { ${TO.x - 3}, ${TO.y}, 12 } } },
		{ id = 12, side = "Alliance", name = "Maestra's Post", disks = { { ${mid.x}, ${mid.y + 6}, 8 } } },
		{ id = 13, side = "Horde", name = "Splintertree Post", disks = { { ${FROM.x}, ${FROM.y}, 6 } } },
		{ id = 14, side = "Alliance", name = "Far away", disks = { { ${FROM.x}, ${FROM.y + 60}, 10 } } },
	}`;
	const got = route(OURS, mapFiles(strip, true, { hubs }), [q('horde', 'find', '{ profile = "Horde" }'), q('alliance', 'find', '{ profile = "Alliance" }'), q('none', 'find')]);
	assert.deepEqual(got.horde.hubs, [{ id: 12, name: "Maestra's Post" }, { id: 11, name: 'Astranaar' }], 'Horde: the Alliance hubs entered, in path order, once each');
	assert.deepEqual(got.alliance.hubs, [{ id: 13, name: 'Splintertree Post' }], 'Alliance: only the Horde hub at the start');
	assert.deepEqual(got.none.hubs, {}, 'no profile: no hub is hostile');
	// The same route with only the Alliance hubs: the Alliance player enters none.
	const own = route(OURS, mapFiles(strip, true, { hubs: hubs.replace(/\n\t\t\{ id = 13[^\n]*/, '') }), [q('alliance', 'find', '{ profile = "Alliance" }'), q('horde', 'find', '{ profile = "Horde" }')]);
	assert.deepEqual(own.alliance.hubs, {}, 'Alliance: no hub on the same route');
	assert.equal(own.horde.hubs.length, 2);
});

// Straightening (PathGrid.lua's smooth): a drawn segment replaces the path between two of its entries only over
// ground no costlier than the path there, and never into a hostile hub the path kept out of.
// The cells (gx * C + gy) a drawn line passes, sampled at 997 steps a segment: a segment runs between cell
// centres, so no sample falls on a cell corner (997 is odd and prime).
function crossed(r) {
	const out = new Set();
	const pts = r.points.map(([x, y]) => [Number(x) / CS, Number(y) / CS]);
	for (let i = 1; i < pts.length; i++) {
		const [[ax, ay], [bx, by]] = [pts[i - 1], pts[i]];
		for (let s = 0; s <= 997; s++) out.add(Math.floor(ax + ((bx - ax) * s) / 997) * C + Math.floor(ay + ((by - ay) * s) / 997));
	}
	return out;
}
// Ground of class `cls` (walkable) on every cell of the box x0..x1, y0..y1 not yet set.
function fill(cells, x0, x1, y0, y1, cls) {
	for (let x = x0; x <= x1; x++) for (let y = y0; y <= y1; y++) if (!cells.has(x * C + y)) cells.set(x * C + y, { val: 1, cls });
	return cells;
}
// A road (class 1) east along row Y0 from X0 for `east` cells, then `rise` cells on by (1, dy) each; then `inside`
// (the class of the ground in the bend) and normal ground round it, three cells wide. -> { cells, to }
function bend(east, rise, dy, inside) {
	const cells = new Map();
	const road = (x, y) => cells.set(x * C + y, { val: 1, cls: 1 });
	for (let x = X0; x <= X0 + east; x++) road(x, Y0);
	for (let i = 1; i <= rise; i++) road(X0 + east + (dy ? i : 0), Y0 + i);
	const [ex, ey] = [X0 + east + (dy ? rise : 0), Y0 + rise];
	for (let y = Y0 + 1; y <= ey; y++) fill(cells, X0, X0 + east + (dy ? y - Y0 - 1 : -1), y, y, inside);
	return { cells: fill(cells, X0 - 3, ex + 3, Y0 - 3, ey + 3, 0), to: at(ex, ey) };
}
// Open normal ground with an Alliance hub's disk below the straight line from FROM to HUB_TO, that line clipping
// the disk: the hub bit on every cell the disk touches. -> { cells, hubs (metadata, Lua), hub (the hub cells) }
const HUB_TO = at(X0 + 20, Y0 + 8);
function rim() {
	const [cx, cy, r] = [X0 + 13, Y0 + 3.5, 2.5]; // in cells
	const cells = new Map();
	const hub = new Set();
	for (let x = X0 - 3; x <= X0 + 23; x++) {
		for (let y = Y0 - 3; y <= Y0 + 11; y++) {
			const [nx, ny] = [Math.min(Math.max(cx, x), x + 1), Math.min(Math.max(cy, y), y + 1)];
			const inside = Math.hypot(nx - cx, ny - cy) < r;
			if (inside) hub.add(x * C + y);
			cells.set(x * C + y, { val: 1, cls: inside ? 8 : 0 });
		}
	}
	const hubs = `{ { id = 21, side = "Alliance", name = "Rim", disks = { { ${cx * CS}, ${cy * CS}, ${r * CS} } } } }`;
	return { cells, hubs, hub };
}

test('straightening keeps a drawn line on the road round a bend: a 90 degree bend beside gentle ground, a 45 degree one beside normal ground', () => {
	for (const [what, east, rise, dy, inside, want] of [
		['90 degree bend, gentle inside', 12, 12, 0, 2, 0.8 * (22 + Math.SQRT2) * CS],
		['45 degree bend, normal inside', 10, 10, 1, 0, 0.8 * (10 + 10 * Math.SQRT2) * CS],
	]) {
		const { cells, to } = bend(east, rise, dy, inside);
		const got = route(OURS, mapFiles(cells, true), [q('none', 'find'), q('horde', 'find', '{ profile = "Horde" }')], { to });
		for (const id of ['none', 'horde']) {
			close(got[id], want, `${what} ${id}: the cost-best path is the road`);
			const off = [...crossed(got[id])].filter((g) => cells.get(g).cls !== 1);
			assert.deepEqual(off, [], `${what} ${id}: every cell the drawn line passes is road`);
			assert.ok(got[id].points.length >= 3, `${what} ${id}: the bend is drawn`);
		}
	}
});

test('straightening prices a segment by the path after its anchor: a start on steep ground does not let the line cut the steep ground inside a road\'s bend', () => {
	const { cells, to } = bend(12, 12, 0, 3);
	cells.set(X0 * C + Y0, { val: 1, cls: 3 }); // the start, the first anchor, on steep ground
	const got = route(OURS, mapFiles(cells, true), [q('none', 'find'), q('horde', 'find', '{ profile = "Horde" }')], { to });
	for (const id of ['none', 'horde']) {
		const off = [...crossed(got[id])].filter((g) => g !== X0 * C + Y0 && cells.get(g).cls !== 1);
		assert.deepEqual(off, [], `${id}: past the start, every cell the drawn line passes is road`);
		assert.ok(got[id].points.length >= 3, `${id}: the bend is drawn`);
	}
});

test('straightening never cuts into a hostile hub the path went round; a profile it is not hostile to straightens the same corner', () => {
	const { cells, hubs, hub } = rim();
	const got = route(OURS, mapFiles(cells, true, { hubs }), [q('horde', 'find', '{ profile = "Horde" }'), q('alliance', 'find', '{ profile = "Alliance" }'), q('none', 'find')], { to: HUB_TO });
	const octile = (12 + 8 * Math.SQRT2) * CS;
	close(got.horde, octile, 'Horde: round the rim at no extra length');
	assert.deepEqual([...crossed(got.horde)].filter((g) => hub.has(g)), [], 'Horde: no drawn segment crosses a hub cell');
	assert.deepEqual(got.horde.hubs, {}, 'Horde: the drawn line enters no hostile hub');
	for (const id of ['alliance', 'none']) {
		close(got[id], octile, id);
		assert.equal(got[id].points.length, 2, `${id}: the corner is straightened`);
		assert.ok([...crossed(got[id])].some((g) => hub.has(g)), `${id}: the straight line crosses the hub's cells`);
		assert.deepEqual(got[id].hubs, {}, `${id}: the hub is not hostile`);
	}
});

test('ReuseMany reuses a batch only for the profile it was priced for', () => {
	const tail = `
local job = Path.FindMany(${MAP}, { map = ${MAP}, x = A.x, y = A.y, z = A.z }, { B }, function() end, { profile = "Horde" })
while #frames > 0 do table.remove(frames, 1)() end
local here = { map = ${MAP}, x = A.x + 1, y = A.y, z = A.z }
out.reuse = { horde = Path.ReuseMany(job, here, "Horde"), alliance = Path.ReuseMany(job, here, "Alliance"), none = Path.ReuseMany(job, here), neutral = Path.ReuseMany(job, here, "Neutral") }
local nojob = Path.FindMany(${MAP}, { map = ${MAP}, x = A.x, y = A.y, z = A.z }, { B }, function() end)
while #frames > 0 do table.remove(frames, 1)() end
out.reuseNone = { none = Path.ReuseMany(nojob, here), neutral = Path.ReuseMany(nojob, here, "Neutral"), horde = Path.ReuseMany(nojob, here, "Horde") }`;
	const got = route(OURS, mapFiles(layout(4), true), [], { tail });
	assert.deepEqual(got.reuse, { horde: true, alliance: false, none: false, neutral: false });
	assert.deepEqual(got.reuseNone, { none: true, neutral: true, horde: false });
});

test('styles: Roads takes a road 1.45 times the straight way that Balanced and Fastest do not; not one 2.12 times; no style or an unknown one is Balanced', () => {
	const road = { cls: 1 };
	const styles = [['fastest', '"fastest"'], ['balanced', '"balanced"'], ['roads', '"roads"'], ['none', 'nil'], ['odd', '"Sideways"']];
	const queries = [...styles.map(([id, s]) => q(id, 'find', `{ profile = "Horde", style = ${s} }`)), q('roadsMany', 'many', '{ style = "roads" }')];
	assert.ok(ROUND(6) > 1.44 * STRAIGHT && ROUND(6) < 1.46 * STRAIGHT, 'the road is about 145 yd');
	const near = route(OURS, mapFiles(layout(6, {}, road), true), queries);
	assert.ok(round(near.roads), 'Roads: the road');
	close(near.roads, ROUND_AT(6, 0.5), 'Roads prices the road at 0.5');
	close(near.roadsMany, ROUND_AT(6, 0.5), 'FindMany prices it the same');
	for (const id of ['fastest', 'balanced', 'none', 'odd']) assert.ok(straight(near[id]), `${id}: straight across`);
	assert.deepEqual(near.none, near.balanced, 'no style is Balanced');
	assert.deepEqual(near.odd, near.balanced, 'an unknown style is Balanced');
	const far = route(OURS, mapFiles(layout(14, {}, road), true), queries);
	assert.ok(straight(far.roads), 'Roads: not a road 2.12 times as long');
});

test('styles: Fastest crosses a steep strip that Balanced and Roads go round', () => {
	const got = route(OURS, mapFiles(layout(4, { cls: 3 }, {}), true), ['fastest', 'balanced', 'roads'].map((s) => q(s, 'find', `{ style = "${s}" }`)));
	assert.ok(straight(got.fastest), 'Fastest: across');
	close(got.fastest, (23 * 1.2 + 1) * CS, 'Fastest prices steep ground at 1.2');
	assert.ok(round(got.balanced), 'Balanced: round');
	close(got.balanced, ROUND(4), 'round the plain U');
	assert.ok(round(got.roads), 'Roads: round');
});

test('styles: a Horde player goes round an Alliance hub in every style', () => {
	const got = route(OURS, mapFiles(layout(4, { cls: 8 }), true), ['fastest', 'balanced', 'roads'].map((s) => q(s, 'find', `{ profile = "Horde", style = "${s}" }`)));
	for (const s of ['fastest', 'balanced', 'roads']) assert.ok(round(got[s]), `${s}: round the hostile hub`);
});

test('styles: a map without classes (format 1) routes the same in every style', () => {
	const files = mapFiles(layout(3, {}, { cls: 1 }), false);
	const got = route(OURS, files, ['fastest', 'balanced', 'roads'].map((s) => q(s, 'find', `{ style = "${s}" }`)));
	assert.deepEqual(got.fastest, got.balanced);
	assert.deepEqual(got.roads, got.balanced);
});

test('ReuseMany reuses a batch only for the style it was priced for', () => {
	const tail = `
local job = Path.FindMany(${MAP}, { map = ${MAP}, x = A.x, y = A.y, z = A.z }, { B }, function() end, { profile = "Horde", style = "roads" })
while #frames > 0 do table.remove(frames, 1)() end
local here = { map = ${MAP}, x = A.x + 1, y = A.y, z = A.z }
out.reuse = { roads = Path.ReuseMany(job, here, "Horde", "roads"), balanced = Path.ReuseMany(job, here, "Horde", "balanced"), none = Path.ReuseMany(job, here, "Horde") }
local plain = Path.FindMany(${MAP}, { map = ${MAP}, x = A.x, y = A.y, z = A.z }, { B }, function() end, { profile = "Horde" })
while #frames > 0 do table.remove(frames, 1)() end
out.reusePlain = { none = Path.ReuseMany(plain, here, "Horde"), balanced = Path.ReuseMany(plain, here, "Horde", "balanced"), fastest = Path.ReuseMany(plain, here, "Horde", "fastest") }`;
	const got = route(OURS, mapFiles(layout(4), true), [], { tail });
	assert.deepEqual(got.reuse, { roads: true, balanced: false, none: false });
	assert.deepEqual(got.reusePlain, { none: true, balanced: true, fastest: false });
});

// Zone danger (opts.danger = { [uiMapID] = multiplier }): on the strip-and-U maps the strip's row (cells y >= 64:
// chunk rows cy >= 8) lies in Western Plaguelands (1422), the U above it in Silverpine (1421).
const WPL = 1422;
const SILVERPINE = 1421;
const zonesByRow = (k, q) => (q % 16 >= 8 ? WPL : SILVERPINE);
const danger = (t) => `{ danger = ${t} }`;

test('danger: a step into a dangerous zone costs its multiplier: round a dangerous strip, straight across a safe one, and the costs in every API', () => {
	assert.ok(ROUND(4) < 3 * STRAIGHT, 'the U is shorter than three strips');
	const files = mapFiles(layout(4), true, { zones: zonesByRow });
	// No danger first, then two tables in one session: the path and endpoint caches must not mix them.
	const got = route(OURS, files, [
		q('none', 'find'), q('wpl', 'find', danger(`{ [${WPL}] = 3 }`)), q('silver', 'find', danger(`{ [${SILVERPINE}] = 3 }`)),
		q('wplCost', 'cost', danger(`{ [${WPL}] = 3 }`)), q('wplMany', 'many', danger(`{ [${WPL}] = 3 }`)), q('silverCost', 'cost', danger(`{ [${SILVERPINE}] = 3 }`)),
		q('wplHorde', 'find', `{ profile = "Horde", style = "roads", danger = { [${WPL}] = 3 } }`), q('noneAgain', 'find'),
	]);
	assert.ok(straight(got.none), 'no danger: straight');
	close(got.none, STRAIGHT, 'no danger');
	// Round the U, the last step into the goal's cell (in 1422) at x 3.
	const roundWpl = (S + 2 * 4 - 5 + 2 * Math.SQRT2 + 3) * CS;
	for (const id of ['wpl', 'wplHorde']) {
		assert.ok(round(got[id]), `${id}: round the dangerous strip`);
		close(got[id], roundWpl, id);
	}
	close(got.wplCost, roundWpl, 'FindCost');
	close(got.wplMany, roundWpl, 'FindMany');
	assert.ok(straight(got.silver), 'a dangerous U: straight');
	close(got.silver, STRAIGHT, 'the strip is not dangerous');
	close(got.silverCost, STRAIGHT, 'FindCost: the strip');
	assert.deepEqual(got.noneAgain, got.none, 'no danger after danger: today\'s route again');
});

test('danger: no zone is closed: the only way through a zone ten times over still routes, at ten times the cost', () => {
	const strip = new Map([...layout(4)].filter(([l]) => l % C === Y0));
	const got = route(OURS, mapFiles(strip, true, { zones: zonesByRow }), [q('far', 'find', danger(`{ [${WPL}] = 10 }`)), q('farMany', 'many', danger(`{ [${WPL}] = 10 }`)), q('farCost', 'cost', danger(`{ [${WPL}] = 10 }`))]);
	for (const id of ['far', 'farMany', 'farCost']) close(got[id], 10 * STRAIGHT, `${id}: through, x 10`);
	assert.ok(straight(got.far), 'drawn along the strip');
});

test('danger: a graph edge costs its baked cost times the larger of its two ends\' multipliers', () => {
	const [A, H, N, Y] = [4, 84, 5, 4];
	// Cluster 0 (the start's side) in Silverpine, cluster 1 in Western Plaguelands.
	const files = borderFiles([A, H, N], Y, (k) => (k === 0 ? SILVERPINE : WPL));
	const tables = [['wpl3', `{ [${WPL}] = 3 }`, 11 + 3 * 12, 3], ['silver2', `{ [${SILVERPINE}] = 2 }`, 2 * 11 + 12, 2], ['both', `{ [${SILVERPINE}] = 2, [${WPL}] = 3 }`, 2 * 11 + 3 * 12, 3]];
	const got = route(OURS, files, tables.flatMap(([id, t]) => [q(id, 'find', danger(t)), q(`${id}Many`, 'many', danger(t)), q(`${id}Cost`, 'cost', danger(t))]), BORDER);
	for (const [id, , cells, edge] of tables) {
		for (const kind of ['', 'Many', 'Cost']) close(got[id + kind], cells * CS + edge * N, `${id}${kind}`);
	}
});

test('danger: straightening never cuts into a dangerous zone the path went round', () => {
	// Open ground; the chunk at cells x 32-39, y 64-71 is Western Plaguelands, the rest Silverpine. The straight line
	// from (20, 64) to (40, 72) clips that chunk; an octile path of the same length goes round it (diagonals first).
	const cells = fill(new Map(), X0 - 3, X0 + 23, Y0 - 3, Y0 + 11, 0);
	const zones = (k, q) => (q === 4 * 16 + 8 ? WPL : SILVERPINE);
	const to = at(X0 + 20, Y0 + 8);
	const got = route(OURS, mapFiles(cells, true, { zones }), [q('none', 'find'), q('wpl', 'find', danger(`{ [${WPL}] = 3 }`))], { to });
	const octile = (12 + 8 * Math.SQRT2) * CS;
	const inChunk = (g) => Math.floor(g / C) >= 32 && Math.floor(g / C) <= 39 && g % C >= 64 && g % C <= 71;
	close(got.none, octile, 'no danger');
	assert.equal(got.none.points.length, 2, 'no danger: one straight segment');
	assert.ok([...crossed(got.none)].some(inChunk), 'the straight line crosses the chunk');
	close(got.wpl, octile, 'danger: round the chunk at no extra length');
	assert.deepEqual([...crossed(got.wpl)].filter(inChunk), [], 'danger: no drawn segment crosses the dangerous chunk');
});

test('danger: without it (nil, {}, or only zones the map lacks), and on a map without the zone field, points, costs and yards are today\'s router\'s', (t) => {
	const REV = 'c84f3b89'; // the router before zone danger
	const show = (rel) => spawnSync('git', ['-C', ROOT, 'show', `${REV}:addon/Polestar_Nav/${rel}`], { encoding: 'utf8', maxBuffer: 16 * 1024 * 1024 });
	if (show('API.lua').status !== 0) {
		t.skip(`no git history with ${REV} (not a checkout of the repository)`);
		return;
	}
	const dir = path.join(tmpdir('polestar-router-today-'), 'Polestar_Nav');
	const rels = ['Routing/Costs.lua', 'Routing/PathGrid.lua', 'Routing/Path.lua', 'Routing/PathJobs.lua', 'API.lua'];
	fs.mkdirSync(path.join(dir, 'Routing'), { recursive: true });
	for (const rel of rels) {
		const r = show(rel);
		assert.equal(r.status, 0, r.stderr);
		fs.writeFileSync(path.join(dir, rel), r.stdout);
	}
	fs.writeFileSync(path.join(dir, 'Polestar_Nav.toc'), `${rels.join('\n')}\n`);
	const TODAY = { name: 'Polestar_Nav', dir };
	const base = [['none', 'nil'], ['horde', '{ profile = "Horde" }'], ['roads', '{ profile = "Alliance", style = "roads" }'], ['walk', 'true']];
	const kinds = ['find', 'cost', 'many'];
	const theirs = base.flatMap(([id, o]) => kinds.map((k) => q(`${id}-${k}`, k, o)));
	// Ours: the same queries with no danger, an empty table and a table of zones the map does not hold.
	const withDanger = (o, d) => (o === 'nil' ? `{ danger = ${d} }` : o === 'true' ? `{ waterWalking = true, danger = ${d} }` : o.replace(/ \}$/, `, danger = ${d} }`));
	for (const [what, files, opts] of [
		['zoned strip and U', mapFiles(layout(4, {}, { cls: 1 }), true, { zones: zonesByRow }), {}],
		['zoned border graph', borderFiles([4, 84, 5], 4, (k) => (k === 0 ? SILVERPINE : WPL)), BORDER],
		['no zone field', mapFiles(layout(4, { cls: 8 }), true), {}],
	]) {
		const want = route(TODAY, files, theirs, opts);
		for (const d of [null, '{}', '{ [9999] = 3 }', ...(what === 'no zone field' ? [`{ [${WPL}] = 10 }`] : [])]) {
			const ours = base.flatMap(([id, o]) => kinds.map((k) => q(`${id}-${k}`, k, d === null ? o : withDanger(o, d))));
			assert.deepEqual(route(OURS, files, ours, opts), want, `${what}, danger ${d}: today's results`);
		}
	}
});

test('ReuseMany reuses a batch only for the danger table it was priced for (its signature, not the table)', () => {
	const tail = `
local job = Path.FindMany(${MAP}, { map = ${MAP}, x = A.x, y = A.y, z = A.z }, { B }, function() end, { profile = "Horde", danger = { [${WPL}] = 3 } })
while #frames > 0 do table.remove(frames, 1)() end
local here = { map = ${MAP}, x = A.x + 1, y = A.y, z = A.z }
out.reuse = { same = Path.ReuseMany(job, here, "Horde", nil, { [${WPL}] = 3 }), other = Path.ReuseMany(job, here, "Horde", nil, { [${WPL}] = 10 }),
	more = Path.ReuseMany(job, here, "Horde", nil, { [${WPL}] = 3, [${SILVERPINE}] = 3 }), none = Path.ReuseMany(job, here, "Horde") }
local plain = Path.FindMany(${MAP}, { map = ${MAP}, x = A.x, y = A.y, z = A.z }, { B }, function() end, { profile = "Horde" })
while #frames > 0 do table.remove(frames, 1)() end
out.reusePlain = { none = Path.ReuseMany(plain, here, "Horde"), empty = Path.ReuseMany(plain, here, "Horde", nil, {}), wpl = Path.ReuseMany(plain, here, "Horde", nil, { [${WPL}] = 3 }) }`;
	const got = route(OURS, mapFiles(layout(4), true, { zones: zonesByRow }), [], { tail });
	assert.deepEqual(got.reuse, { same: true, other: false, more: false, none: false });
	assert.deepEqual(got.reusePlain, { none: true, empty: true, wpl: false });
});

test('ReuseMany on a map without the zone field reuses a batch across danger tables (danger prices nothing there)', () => {
	const tail = `
local job = Path.FindMany(${MAP}, { map = ${MAP}, x = A.x, y = A.y, z = A.z }, { B }, function() end, { profile = "Horde", danger = { [${WPL}] = 3 } })
while #frames > 0 do table.remove(frames, 1)() end
local here = { map = ${MAP}, x = A.x + 1, y = A.y, z = A.z }
out.reuse = { other = Path.ReuseMany(job, here, "Horde", nil, { [${WPL}] = 10 }), none = Path.ReuseMany(job, here, "Horde"), alliance = Path.ReuseMany(job, here, "Alliance", nil, { [${WPL}] = 3 }) }`;
	const got = route(OURS, mapFiles(layout(4), true), [], { tail });
	assert.deepEqual(got.reuse, { other: true, none: true, alliance: false });
});

test('Path.ZoneAt reads the uiMapID of a point\'s chunk; nil outside the maps, on a map without the zone field and in a chunk of no zone', () => {
	const tail = `
local function z(m, p) return Path.ZoneAt(m, p.x, p.y) or "nil" end
out.zones = { strip = z(${MAP}, ${lua(at(X0, Y0))}), u = z(${MAP}, ${lua(at(X0, Y0 - 4))}), corner = z(${MAP}, ${lua(at(127, 0))}), last = z(${MAP}, ${lua(at(127, 127))}),
	outside = z(${MAP}, { x = -10, y = 5 }), nomap = z(99, ${lua(at(X0, Y0))}) }`;
	const zones = (k, q) => (q === 0 ? 0 : zonesByRow(k, q));
	const got = route(OURS, mapFiles(layout(4), true, { zones }), [], { tail });
	assert.deepEqual(got.zones, { strip: WPL, u: SILVERPINE, corner: SILVERPINE, last: WPL, outside: 'nil', nomap: 'nil' });
	const none = route(OURS, mapFiles(layout(4), true), [], { tail });
	assert.equal(none.zones.strip, 'nil', 'a map without the zone field');
	// Chunk 0 (cells x 0-7, y 0-7) is no zone.
	const zero = route(OURS, mapFiles(layout(4), true, { zones }), [], { tail: `out.zero = Path.ZoneAt(${MAP}, ${at(3, 3).x}, ${at(3, 3).y}) or "nil"` });
	assert.equal(zero.zero, 'nil');
});

test('Path.SurfacesAt: the heights and marks (water 1, indoor 2) of a cell\'s surfaces into the caller\'s table; 0 off the data; never decodes: nil and one Path.Prefetch job, which decodes under the frame budget; one cluster kept, through Idle, until Path.ReleaseSurfaces', () => {
	const cells = new Map();
	for (let k = 0; k < 2; k++) {
		cells.set(k * C * C + 10 * C + 10, { val: 1, cls: 0 });
		cells.set(k * C * C + 10 * C + 11, { val: 2, cls: 0 });
		cells.set(k * C * C + 10 * C + 12, { val: 1, cls: 4 });
		cells.set(k * C * C + 10 * C + 13, { val: 1, cls: 5 + 8 });
	}
	const files = mapFiles(cells, true, { nx: 2 });
	const tail = `
local t = { 99, 99, [-1] = 99 }
local function read(gx, gy)
	local n = Path.SurfacesAt(${MAP}, (gx + 0.5) * ${CS}, (gy + 0.5) * ${CS}, t)
	return { n = n or "nil", z = n and n > 0 and t[1] or "-", marks = n and n > 0 and t[-1] or "-" }
end
-- Frames run until none is left, each under budget ms, on a clock that moves 0.01 ms a reading; -> how many.
local function pump(budget)
	local was, clock, now, n = Path.budget, Path.clock, 0, 0
	Path.budget = budget or was
	Path.clock = function() now = now + 0.01 return now end
	while #frames > 0 do n = n + 1 table.remove(frames, 1)() end
	Path.budget, Path.clock = was, clock
	return n
end
local d0 = Path.decodes or 0
out.cold = read(10, 10)
out.sync = (Path.decodes or 0) - d0
local x, y = 10.5 * ${CS}, 10.5 * ${CS}
local job = Path.Prefetch(${MAP}, x, y)
out.oneJob = job ~= nil and job.prefetch == true and Path.Prefetch(${MAP}, x, y) == job and read(10, 10).n == "nil"
out.frames = pump(0)
out.decoded = Path.decodes - d0
out.ground = read(10, 10)
out.water = read(10, 11)
out.indoor = read(10, 12)
out.city = read(10, 13)
out.none = read(10, 20)
out.kept = t[2]
out.done = Path.Prefetch(${MAP}, x, y) == nil
-- Off the data: 0, and the cluster read before goes.
out.outside = { n = Path.SurfacesAt(${MAP}, -50, 5, t), nomap = Path.SurfacesAt(99, 5, 5, t) }
-- The next cluster: the first goes (the reader keeps one).
read(${C} + 10, 10)
pump()
out.next = read(${C} + 10, 10).n
out.left = read(10, 10).n
pump()
-- A search in cluster 0, then Idle: the reader's cluster stays, the other goes.
Path.Find(${MAP}, A, B, function() end)
pump()
out.idle = { read(10, 10).n, read(${C} + 10, 10).n }
pump()
out.decodes = Path.decodes - d0
read(10, 10)
Path.ReleaseSurfaces()
out.released = read(10, 10).n`;
	const got = route(OURS, files, [], { tail });
	assert.deepEqual(got.cold, { n: 'nil', z: '-', marks: '-' }, 'not decoded: nil');
	assert.equal(got.sync, 0, 'the read itself decodes nothing');
	assert.equal(got.oneJob, true, 'it queued one Path.Prefetch job; asking again is that job');
	assert.ok(got.frames > 1, `the job decodes in slices under the frame budget (${got.frames} frames at a 0 ms budget)`);
	assert.equal(got.decoded, 1);
	assert.equal(got.ground.n, 1);
	assert.equal(got.ground.marks, 0);
	assert.equal(typeof got.ground.z, 'number');
	assert.equal(got.water.marks, 1);
	assert.equal(got.indoor.marks, 2);
	assert.equal(got.city.marks, 2, 'an indoor city (class 5, here inside a hub) is indoor');
	assert.equal(got.none.n, 0, 'a cell with no walkable surface');
	assert.deepEqual(got.outside, { n: 0, nomap: 0 });
	assert.equal(got.kept, 99, 'entries past n are left as they were');
	assert.equal(got.done, true, 'a decoded cluster needs no job');
	assert.equal(got.next, 1);
	assert.equal(got.left, 'nil', 'reading the next cluster dropped the one before');
	assert.deepEqual(got.idle, [1, 'nil'], 'Idle keeps the reader\'s cluster and drops the rest');
	assert.equal(got.decodes, 4, 'cluster 0, 1, 0 again, 1 again');
	assert.equal(got.released, 'nil', 'Path.ReleaseSurfaces drops it');
});

// Two clusters, cell (10, 10) walkable in each, for the reader's slot.
function readerRoute(tail) {
	const cells = new Map([[10 * C + 10, { val: 1, cls: 0 }], [C * C + 10 * C + 10, { val: 1, cls: 0 }]]);
	return route(OURS, mapFiles(cells, true, { nx: 2 }), [], {
		tail: `
local t = {}
local function read(gx) return Path.SurfacesAt(${MAP}, (gx + 0.5) * ${CS}, 10.5 * ${CS}, t) or "nil" end
local function pump(budget, once)
	local was, clock, now = Path.budget, Path.clock, 0
	Path.budget = budget or was
	Path.clock = function() now = now + 0.01 return now end
	while #frames > 0 do
		table.remove(frames, 1)()
		if once then break end
	end
	Path.budget, Path.clock = was, clock
end
${tail}`,
	});
}

test('Path.ReleaseSurfaces cancels a Prefetch queued or mid-decode: nothing lands after it, nothing is held', () => {
	const got = readerRoute(`
local d0 = Path.decodes or 0
read(10)
Path.ReleaseSurfaces()
pump()
out.queued = { decodes = (Path.decodes or 0) - d0, loaded = Path.IsLoaded(${MAP}) }
read(10)
pump(0, true)
out.started = (Path.decodes or 0) - d0
Path.ReleaseSurfaces()
pump()
out.running = Path.IsLoaded(${MAP})`);
	assert.deepEqual(got.queued, { decodes: 0, loaded: false }, 'a queued Prefetch never runs');
	assert.equal(got.started, 1, 'the second one had begun decoding');
	assert.equal(got.running, false, 'and its decode never lands');
});

test('Path.SurfacesAt at a cluster edge: A, then B (not decoded), then back in A before B lands keeps A, and B goes at Idle', () => {
	const got = readerRoute(`
read(10)
pump()
out.a = read(10)
out.b = read(${C} + 10)
out.back = read(10)
pump()
out.kept = read(10)
out.bAfter = read(${C} + 10)`);
	assert.deepEqual(got, { a: 1, b: 'nil', back: 1, kept: 1, bAfter: 'nil' });
});

test('Path.SurfacesAt off the data (another map, outside the map) drops the cluster read before: none is held at rest', () => {
	const got = readerRoute(`
local function held(f)
	read(10)
	pump()
	local was = read(10)
	local n = f()
	return { was, n, Path.IsLoaded(${MAP}) }
end
out.nomap = held(function() return Path.SurfacesAt(99, 5, 5, t) end)
out.outside = held(function() return Path.SurfacesAt(${MAP}, -50, 5, t) end)`);
	assert.deepEqual(got.nomap, [1, 0, false], 'a map without data');
	assert.deepEqual(got.outside, [1, 0, false], 'a point outside the map\'s data');
});
