'use strict';
// `nav eval`'s runner: the route corpus and the per-zone goal sweep on one
// Polestar_Nav folder's maps, through the walking router run standalone by
// harness.lua (LuaJIT, else Lua 5.1).
//
//   runQueries({ navDir, queries, lua?, zoneLevels? }) -> { init, results }   raw harness lines (harness.lua's header)
//     zoneLevels: tools/lib/maps/zonelevels.js's { [uiMapID]: { min, ... } }, for the routes with a level
//   runRoutes({ navDir, routes, profile?, lua?, zoneLevels? })
//     routes: [{ id, map, from: [x, y, z|null], to, profile?, level?, danger? }] (world, UnitPosition's frame)
//     -> [{ id, ok, reason, cost, yards, pts: [[x, y, z]], hubs, ms, warmMs, kb, wet, zones, endZones }]
//   loadCorpus(file = routes.json) -> { routes: [{ id, kind, map?, from, to, profile, level?, danger?, expect }] }
//   resolveRoutes(routes, geo) -> the routes with world ends: an end [x, y, z] is kept (on `map`), an end
//     { uiMap, x, y, f? } (map percent in the live frame, as the player sees it; f "e" the Era frame, as Guides.lua's
//     goals) becomes world yards by map-frames.json (planner/geo.js, as tests/nav-e2e.test.js's every-zone walk);
//     map is its continent; level (the character's, null for none) prices the route with zone danger (harness.lua),
//     danger ({ "<uiMapID>": multiplier }, null for none) is laid over that table (adds zones or replaces them)
//   sweepQueries({ geo, taxi, guides, profiles }) -> one `many` query per zone with located guide goals
//     and profile: from the zone's flight master open to that side (else its first goal) to every goal
//   evaluate({ navDir, corpus, sweep, geo, taxi, guides, grid, layers, lua, zoneLevels, log }) -> the eval report
//     { navDir, lua, init, routes: [{ ...route, result, metrics, expect }], sweep: [...], summary }
//
// A folder without its own Polestar_Nav.toc, Routing or API.lua (a `nav pack --out` folder holds only Nav/ and
// PACK.json) takes them from the repository's addon/Polestar_Nav; its Nav/Nav.xml is always its own.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { ROOT } = require('../../paths');
const { metrics } = require('./metrics');
const { evaluateExpectations, summarize } = require('./compare');

const HARNESS = path.join(__dirname, 'harness.lua');
const ENCODING = path.join(ROOT, 'tests', 'lua', 'stub_encoding.lua');
const REPO_NAV = path.join(ROOT, 'addon', 'Polestar_Nav');
const CORPUS = path.join(__dirname, 'routes.json');
const PROFILES = ['Alliance', 'Horde'];
// TaxiNodes' faction (travel.json): 1 Alliance, 2 Horde, 3 both.
const TAXI_SIDES = { Alliance: [1, 3], Horde: [2, 3] };

let interpreter;
function findInterpreter() {
	if (interpreter) return interpreter;
	for (const bin of [process.env.LUA_EVAL, 'luajit', 'lua5.1'].filter(Boolean)) {
		const r = spawnSync(bin, ['-e', 'io.write(_VERSION)'], { encoding: 'utf8' });
		if (r.status === 0 && /5\.1/.test(r.stdout)) return (interpreter = bin);
	}
	throw Object.assign(new Error('nav eval needs luajit or lua5.1 (or LUA_EVAL=/path/to/lua5.1)'), { exit: 1 });
}

// The folder's files in the client's load order: its .toc (else the repository's), the Script files of its
// Nav/Nav.xml, its own Routing/API files where it has them.
function navFiles(navDir) {
	const own = path.join(navDir, 'Polestar_Nav.toc');
	const toc = fs.readFileSync(fs.existsSync(own) ? own : path.join(REPO_NAV, 'Polestar_Nav.toc'), 'utf8');
	const files = [];
	for (const raw of toc.split(/\r?\n/)) {
		const entry = raw.trim().replace(/\\/g, '/');
		if (!entry || entry.startsWith('#')) continue;
		if (entry.endsWith('.xml')) {
			const xml = path.join(navDir, entry);
			if (!fs.existsSync(xml)) throw Object.assign(new Error(`${xml} not found: not a Polestar_Nav folder`), { exit: 1 });
			for (const m of fs.readFileSync(xml, 'utf8').matchAll(/<Script file="([^"]+)"/g)) files.push(path.join(path.dirname(xml), m[1].replace(/\\/g, '/')));
		} else {
			const mine = path.join(navDir, entry);
			files.push(fs.existsSync(mine) ? mine : path.join(REPO_NAV, entry));
		}
	}
	return files;
}

function runQueries({ navDir, queries, lua = findInterpreter(), zoneLevels = null }) {
	const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-eval-'));
	try {
		const list = path.join(tmp, 'files.txt');
		const qfile = path.join(tmp, 'queries.jsonl');
		const out = path.join(tmp, 'out.jsonl');
		const args = [HARNESS, ENCODING, list, qfile, out];
		fs.writeFileSync(list, navFiles(path.resolve(navDir)).join('\n') + '\n');
		fs.writeFileSync(qfile, queries.map((q) => JSON.stringify(q)).join('\n') + '\n');
		if (zoneLevels) {
			const zfile = path.join(tmp, 'zones.json');
			fs.writeFileSync(zfile, JSON.stringify(Object.fromEntries(Object.entries(zoneLevels).map(([id, z]) => [id, z.min]))));
			args.push(zfile);
		}
		const r = spawnSync(lua, args, { encoding: 'utf8', stdio: ['ignore', 'ignore', 'pipe'], maxBuffer: 64 * 1024 * 1024 });
		if (r.error) throw r.error;
		if (r.status !== 0) throw new Error(`nav eval harness (${lua}) failed: ${(r.stderr || '').trim()}`);
		const lines = fs.readFileSync(out, 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l));
		return { init: lines[0], results: lines.slice(1) };
	} finally {
		fs.rmSync(tmp, { recursive: true, force: true });
	}
}

const routeQuery = (r, profile, style = 'balanced') => ({ type: 'route', id: r.id, map: r.map, from: r.from, to: r.to, profile: r.profile !== undefined ? r.profile : profile, style, level: r.level === undefined ? null : r.level, danger: r.danger || null });

function runRoutes({ navDir, routes, profile = null, style = 'balanced', lua, zoneLevels = null }) {
	const { results } = runQueries({ navDir, lua, zoneLevels, queries: routes.map((r) => routeQuery(r, profile, style)) });
	return results.map(({ type, ...r }) => r);
}

function loadCorpus(file = CORPUS) {
	return JSON.parse(fs.readFileSync(file, 'utf8'));
}

function resolveRoutes(routes, geo) {
	return routes.map((r) => {
		let map = r.map;
		const end = (e, which) => {
			if (Array.isArray(e)) return [e[0], e[1], e[2] === undefined ? null : e[2]];
			const w = geo.toWorld(e.uiMap, e.x, e.y, e.f || 'l');
			if (!w) throw new Error(`route ${r.id}: map ${e.uiMap} has no frame in map-frames.json`);
			if (map !== undefined && map !== w.c) throw new Error(`route ${r.id}: its ${which} end is on map ${w.c}, the route on ${map}`);
			map = w.c;
			return [+w.wx.toFixed(3), +w.wy.toFixed(3), null];
		};
		const from = end(r.from, 'from');
		const to = end(r.to, 'to');
		return { id: r.id, kind: r.kind, map, from, to, profile: r.profile === undefined ? null : r.profile, level: r.level === undefined ? null : r.level, danger: r.danger || null, expect: r.expect || [] };
	});
}

// Located goals of the guides per zone (Guides.lua: map, x, y, optional z, f = "e" for the Era frame), on maps 0
// and 1, in guide order, each world point once.
function guideGoals(src, geo) {
	const byZone = new Map();
	const seen = new Set();
	for (const m of src.matchAll(/map = (\d+), x = ([\d.]+), y = ([\d.]+)(?:, z = (-?[\d.]+))?(, f = "e")?/g)) {
		const w = geo.toWorld(+m[1], +m[2], +m[3], m[5] ? 'e' : 'l');
		if (!w || ![0, 1].includes(w.c)) continue;
		const z = m[4] === undefined ? null : +m[4];
		const key = `${m[1]}|${w.wx.toFixed(1)}|${w.wy.toFixed(1)}|${z}`;
		if (seen.has(key)) continue;
		seen.add(key);
		if (!byZone.has(+m[1])) byZone.set(+m[1], []);
		byZone.get(+m[1]).push({ c: w.c, wx: +w.wx.toFixed(2), wy: +w.wy.toFixed(2), z });
	}
	return byZone;
}

function sweepQueries({ geo, taxi, guides, profiles = PROFILES, style = 'balanced' }) {
	const byZone = guideGoals(guides, geo);
	const queries = [];
	for (const [zone, goals] of [...byZone].sort((a, b) => a[0] - b[0])) {
		// A zone's goals on its own continent (a zone map spans one).
		const c = goals[0].c;
		const targets = goals.filter((g) => g.c === c).map((g) => [g.wx, g.wy, g.z]);
		for (const profile of profiles) {
			const fm = (taxi || []).find((n) => n.map === zone && n.c === c && TAXI_SIDES[profile].includes(n.faction));
			const from = fm ? [fm.wx, fm.wy, null] : targets[0];
			queries.push({ type: 'many', id: `${c}|${zone}|${profile}`, map: c, zone, profile, style, hub: fm ? fm.name : 'first goal', from, targets });
		}
	}
	return queries;
}

function evaluate({ navDir, corpus, sweep = false, style = 'balanced', geo, taxi, guides, grid = null, layers = {}, lua = findInterpreter(), zoneLevels = null, log = () => {} }) {
	const routes = resolveRoutes(corpus.routes, geo);
	const many = sweep ? sweepQueries({ geo, taxi, guides, style }) : [];
	log(`nav eval: ${routes.length} routes${sweep ? `, ${many.length} zone sweeps` : ''} on ${navDir} (${lua})`);
	const t0 = Date.now();
	const { init, results } = runQueries({ navDir, lua, zoneLevels, queries: [...routes.map((r) => routeQuery(r, null, style)), ...many.map(({ hub, zone, ...q }) => q)] });
	log(`nav eval: harness done in ${((Date.now() - t0) / 1000).toFixed(1)} s`);
	const byId = new Map(results.map((r) => [`${r.type}|${r.id}`, r]));
	const out = routes.map((r) => {
		const { type, id, ...result } = byId.get(`route|${r.id}`);
		const m = result.ok ? metrics(result, { grid, layers, map: r.map }) : null;
		const route = { ...r, result, metrics: m };
		return { ...route, verdicts: evaluateExpectations(route) };
	});
	const sw = many.map((q) => {
		const r = byId.get(`many|${q.id}`);
		return { id: q.id, map: q.map, zone: q.zone, profile: q.profile, hub: q.hub, from: q.from, targets: q.targets, ok: r.ok, reason: r.reason, costs: r.costs, yards: r.yards, ms: r.ms };
	});
	const report = { navDir: path.resolve(navDir), lua, init, style, routes: out, sweep: sw };
	report.summary = summarize(report);
	return report;
}

module.exports = { runQueries, runRoutes, loadCorpus, resolveRoutes, guideGoals, sweepQueries, evaluate, navFiles, findInterpreter, PROFILES, CORPUS };
