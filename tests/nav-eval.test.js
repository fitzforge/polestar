'use strict';
// `nav eval` (tools/lib/nav/eval): the walking router run standalone by the
// Lua harness on a synthetic two-cluster map folder (pack.js on a tiny
// CellGrid), the per-route metrics, the acceptance comparison, and the route
// corpus against our grid (data/local/nav3; skipped without it).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { tmpdir } = require('./helpers/tmp');
const { needs, DATA } = require('./helpers/data');
const { CellGrid, buildHpa, encodeMaps, packFiles } = require('../tools/lib/nav/pack');

const ROOT = path.join(__dirname, '..');
const T = 1600 / 3;
const lua = ['luajit', 'lua5.1'].find((b) => spawnSync(b, ['-e', 'io.write(_VERSION)'], { encoding: 'utf8' }).status === 0);
const noLua = lua ? false : 'no luajit or lua5.1';

// Map 0 with two clusters side by side (x 0..T, y 0..2T), every cell open
// ground joined to its neighbours; only the maps (Nav/): the router comes
// from the repository's addon/Polestar_Nav.
function twoClusterFolder() {
	const C = 16;
	const cg = new CellGrid({ C, NX: 1, NY: 2, CX0: 0, CY0: 0 });
	for (const k of [0, 1]) cg.cluster(k).val.fill(1);
	for (let gx = 0; gx < cg.GW; gx++) {
		for (let gy = 0; gy < cg.GH; gy++) {
			for (const [dx, dy] of [[1, 0], [0, 1], [1, 1], [1, -1]]) {
				const x = gx + dx;
				const y = gy + dy;
				if (x < cg.GW && y >= 0 && y < cg.GH) cg.join(gx * cg.GH + gy, x * cg.GH + y);
			}
		}
	}
	cg.finish();
	const maps = encodeMaps(cg, buildHpa(cg));
	const { files } = packFiles({ map: 0, cg, maps, global: 'PolestarPathData', gen: '-- nav-eval test map' });
	const dir = tmpdir('polestar-eval-');
	fs.mkdirSync(path.join(dir, 'Nav'));
	for (const [name, text] of files) fs.writeFileSync(path.join(dir, 'Nav', name), text);
	fs.writeFileSync(path.join(dir, 'Nav', 'Nav.xml'), `<Ui>\n${files.map(([name]) => `\t<Script file="${name}"/>`).join('\n')}\n</Ui>\n`);
	return dir;
}

test('eval harness: a route query on a two-cluster map returns ok with points, the router\'s yards (the drawn line\'s length) and no hubs', { skip: noLua }, () => {
	const { runRoutes } = require('../tools/lib/nav/eval/run');
	const navDir = twoClusterFolder();
	const [r] = runRoutes({ navDir, lua, routes: [{ id: 'across', map: 0, from: [200, 200, null], to: [300, 800, null] }] });
	assert.equal(r.id, 'across');
	assert.equal(r.ok, true, `routed (${r.reason})`);
	assert.ok(r.pts.length >= 2, 'points');
	assert.ok(Math.hypot(r.pts[0][0] - 200, r.pts[0][1] - 200) < 40, 'starts near the start');
	assert.ok(Math.hypot(r.pts.at(-1)[0] - 300, r.pts.at(-1)[1] - 800) < 40, 'ends near the end');
	assert.ok(r.cost >= Math.hypot(100, 600) * 0.9, `cost ${r.cost}`);
	// The router returns job.yards, the drawn polyline's length (Routing/Path.lua), and job.hubs, the hostile hubs it enters: none here.
	const drawn = r.pts.slice(1).reduce((s, p, i) => s + Math.hypot(p[0] - r.pts[i][0], p[1] - r.pts[i][1]), 0);
	assert.equal(typeof r.yards, 'number');
	assert.ok(Math.abs(r.yards - drawn) <= Math.max(1, drawn * 0.01), `yards ${r.yards} vs drawn ${drawn}`);
	assert.deepEqual(r.hubs, []);
	assert.ok(r.ms >= 0);
});

test('eval harness: a many query returns one cost per target (false off the map) and the router\'s yards beside them', { skip: noLua }, () => {
	const { runQueries } = require('../tools/lib/nav/eval/run');
	const navDir = twoClusterFolder();
	const { results } = runQueries({ navDir, lua, queries: [{ type: 'many', id: 'm', map: 0, from: [200, 200, null], targets: [[250, 250, null], [300, 800, null], [5000, 5000, null]] }] });
	const [m] = results;
	assert.equal(m.type, 'many');
	assert.equal(m.costs.length, 3);
	assert.ok(m.costs[0] > 0 && m.costs[1] > m.costs[0], `costs ${m.costs}`);
	assert.equal(m.costs[2], false);
	// On format 1 maps (no ground classes) a step's cost is its yards: FindMany's yards[i] equals costs[i].
	assert.deepEqual(m.yards, m.costs);
});

test('eval harness: an error reported during a query makes that query not ok and never reaches the next one', { skip: noLua }, () => {
	const { runRoutes } = require('../tools/lib/nav/eval/run');
	const navDir = twoClusterFolder();
	// The folder's own .toc: the repository's files, then Boom.lua, which reports an error through the client's
	// error handler on a route from x 111 (answered all the same) and from x 222 (never answered).
	const toc = fs.readFileSync(path.join(ROOT, 'addon', 'Polestar_Nav', 'Polestar_Nav.toc'), 'utf8');
	fs.writeFileSync(path.join(navDir, 'Polestar_Nav.toc'), `${toc.trimEnd()}\nBoom.lua\n`);
	fs.writeFileSync(
		path.join(navDir, 'Boom.lua'),
		[
			'local Path = Polestar_NavEngine',
			'local find = Path.Find',
			'Path.Find = function(map, from, to, cb, opts)',
			'\tif from.x == 111 or from.x == 222 then geterrorhandler()("boom " .. from.x) end',
			'\tif from.x == 222 then return end',
			'\treturn find(map, from, to, cb, opts)',
			'end',
			'',
		].join('\n'),
	);
	const q = (id, x) => ({ id, map: 0, from: [x, 200, null], to: [300, 800, null] });
	const [answered, after, unanswered, next] = runRoutes({ navDir, lua, routes: [q('answered', 111), q('after', 200), q('unanswered', 222), q('next', 200)] });
	assert.equal(answered.ok, false, 'an error during the query: not ok');
	assert.match(answered.reason, /^error: .*boom 111/);
	assert.equal(after.ok, true, `the next query is clean (${after.reason})`);
	assert.equal(after.reason, null);
	assert.equal(unanswered.ok, false);
	assert.match(unanswered.reason, /boom 222/);
	assert.equal(next.ok, true, `no error left over from an unanswered query (${next.reason})`);
	assert.equal(next.reason, null);
});

// Map 0 of 2 x 3 clusters (x 0..2T, y 0..3T), every cell open ground joined to its neighbours, each cluster in one
// zone: the left column Tirisfal (1420), Western Plaguelands (1422), Tirisfal again; the right column Silverpine (1421).
function zonedFolder() {
	const C = 16;
	const cg = new CellGrid({ C, NX: 2, NY: 3, CX0: 0, CY0: 0 });
	const zoneOf = [1420, 1422, 1420, 1421, 1421, 1421]; // by cluster k = cx * 3 + cy
	for (let k = 0; k < 6; k++) {
		const cl = cg.cluster(k);
		cl.val.fill(1);
		cl.zone = new Uint16Array(256).fill(zoneOf[k]);
	}
	for (let gx = 0; gx < cg.GW; gx++) {
		for (let gy = 0; gy < cg.GH; gy++) {
			for (const [dx, dy] of [[1, 0], [0, 1], [1, 1], [1, -1]]) {
				const x = gx + dx;
				const y = gy + dy;
				if (x < cg.GW && y >= 0 && y < cg.GH) cg.join(gx * cg.GH + gy, x * cg.GH + y);
			}
		}
	}
	cg.finish();
	const maps = encodeMaps(cg, buildHpa(cg));
	assert.ok(maps.zone && maps.zone.size === 6, 'the zone field');
	const { files } = packFiles({ map: 0, cg, maps, global: 'PolestarPathData', gen: '-- nav-eval test map' });
	const dir = tmpdir('polestar-eval-');
	fs.mkdirSync(path.join(dir, 'Nav'));
	for (const [name, text] of files) fs.writeFileSync(path.join(dir, 'Nav', name), text);
	fs.writeFileSync(path.join(dir, 'Nav', 'Nav.xml'), `<Ui>\n${files.map(([name]) => `\t<Script file="${name}"/>`).join('\n')}\n</Ui>\n`);
	return dir;
}

test('eval harness: a route with a level is priced with the zone danger table (the start\'s and the goal\'s zones exempt); its yards per zone come from Path.ZoneAt', { skip: noLua }, () => {
	const { runRoutes } = require('../tools/lib/nav/eval/run');
	const navDir = zonedFolder();
	// zonelevels.js's shape: at level 20 Western Plaguelands (51+) is far above (20x, Ruling 35), Silverpine (11+) safe.
	const zoneLevels = { 1420: { min: 1 }, 1421: { min: 11 }, 1422: { min: 51 } };
	const down = { map: 0, from: [150, 150, null], to: [150, 3 * T - 150, null] };
	const into = { map: 0, from: [150, 150, null], to: [150, 1.5 * T, null] };
	const out = { map: 0, from: [150, 1.5 * T, null], to: [150, 3 * T - 150, null] };
	const [plain, danger, goal, goalPlain, start, startPlain, extra, cleared, forced, forced20, forced10] = runRoutes({
		navDir,
		lua,
		zoneLevels,
		routes: [
			{ id: 'plain', ...down },
			{ id: 'danger', ...down, level: 20 },
			{ id: 'goal', ...into, level: 20 },
			{ id: 'goalPlain', ...into },
			{ id: 'start', ...out, level: 20 },
			{ id: 'startPlain', ...out },
			// A route's own danger: laid over the level's table (or none), adding a zone or replacing its multiplier.
			{ id: 'extra', ...down, danger: { 1422: 10 } },
			{ id: 'cleared', ...down, level: 20, danger: { 1422: 1 } },
			// Silverpine all but closed: the walk must cross Western Plaguelands, at the level's far-above price.
			{ id: 'forced', ...down, level: 20, danger: { 1421: 1000 } },
			{ id: 'forced20', ...down, danger: { 1421: 1000, 1422: 20 } },
			{ id: 'forced10', ...down, danger: { 1421: 1000, 1422: 10 } },
		],
	});
	for (const r of [plain, danger, goal, goalPlain, start, startPlain, extra, cleared, forced, forced20, forced10]) assert.equal(r.ok, true, `${r.id} routed (${r.reason})`);
	assert.ok(plain.zones[1422] > 400, `without a level the walk goes straight through Western Plaguelands: ${JSON.stringify(plain.zones)}`);
	assert.ok(plain.zones[1420] > 0 && !plain.zones[1421], `and never into Silverpine: ${JSON.stringify(plain.zones)}`);
	assert.ok(!(danger.zones[1422] > 10), `at level 20 it goes round through Silverpine: ${JSON.stringify(danger.zones)}`);
	assert.ok(danger.zones[1421] > 400, `through Silverpine: ${JSON.stringify(danger.zones)}`);
	assert.deepEqual(goal.pts, goalPlain.pts, 'a goal inside Western Plaguelands: its zone is exempt, the walk is the plain one');
	assert.equal(goal.cost, goalPlain.cost);
	assert.deepEqual(start.pts, startPlain.pts, 'a start inside Western Plaguelands at level 20: its zone is exempt, the walk is the plain one');
	assert.equal(start.cost, startPlain.cost);
	assert.deepEqual([plain.endZones, start.endZones, goal.endZones], [[1420, 1420], [1422, 1420], [1420, 1422]], 'endZones: Path.ZoneAt at each end');
	assert.ok(!(extra.zones[1422] > 10) && extra.zones[1421] > 400, `a route's danger without a level goes round: ${JSON.stringify(extra.zones)}`);
	assert.ok(extra.cost > plain.cost);
	assert.deepEqual([cleared.pts, cleared.cost], [plain.pts, plain.cost], 'a route\'s danger of 1 takes the level\'s zone out');
	assert.ok(forced.zones[1422] > 400, `the only way crosses Western Plaguelands: ${JSON.stringify(forced.zones)}`);
	assert.deepEqual([forced.pts, forced.cost], [forced20.pts, forced20.cost], 'the far-above tier is priced 20x (Danger.lua\'s FAR_MULT)');
	assert.ok(forced.cost > forced10.cost, `20x, not 10x: ${forced.cost} vs ${forced10.cost}`);
});

test('eval harness: on maps without the zone field a route\'s zones are null and its level changes nothing', { skip: noLua }, () => {
	const { runRoutes } = require('../tools/lib/nav/eval/run');
	const navDir = twoClusterFolder();
	const [a, b] = runRoutes({ navDir, lua, zoneLevels: { 1422: { min: 51 } }, routes: [{ id: 'a', map: 0, from: [200, 200, null], to: [300, 800, null] }, { id: 'b', map: 0, from: [200, 200, null], to: [300, 800, null], level: 20 }] });
	assert.deepEqual([a.zones, a.endZones], [null, null]);
	assert.deepEqual([b.pts, b.cost, b.zones], [a.pts, a.cost, null]);
});

test('metrics and compare: zoneYards.<uiMapID> reads the harness\'s yards in that zone, 0 for a zone the line never enters, n/a without zones', () => {
	const { metrics } = require('../tools/lib/nav/eval/metrics');
	const { evaluateExpectations } = require('../tools/lib/nav/eval/compare');
	const m = metrics({ ok: true, cost: 100, pts: [[0, 0, 0], [100, 0, 0]], zones: { 1420: 60, 1424: 40 } }, { grid: null, layers: {}, map: 0 });
	assert.deepEqual(m.zoneYards, { 1420: 60, 1424: 40 });
	assert.equal(metrics({ ok: true, cost: 1, pts: [[0, 0, 0], [1, 0, 0]], zones: null }, {}).zoneYards, null);
	const expect = [{ type: 'metric', metric: 'zoneYards.1422', op: '==', value: 0 }];
	const [none] = evaluateExpectations({ expect, result: { ok: true }, metrics: m });
	assert.deepEqual([none.pass, none.detail], [true, 'zoneYards.1422 0 (want == 0)']);
	const [through] = evaluateExpectations({ expect, result: { ok: true }, metrics: { zoneYards: { 1422: 120.5 } } });
	assert.equal(through.pass, false);
	const [na] = evaluateExpectations({ expect, result: { ok: true }, metrics: { zoneYards: null } });
	assert.equal(na.pass, null);
});

test('metrics and compare: swumYards is the router\'s drawn yards over water (the harness\'s wet), null when it gives none', () => {
	const { metrics } = require('../tools/lib/nav/eval/metrics');
	const { evaluateExpectations } = require('../tools/lib/nav/eval/compare');
	const m = metrics({ ok: true, cost: 100, pts: [[0, 0, 0], [100, 0, 0]], wet: 21.46 }, { grid: null, layers: {}, map: 0 });
	assert.equal(m.swumYards, 21.5);
	assert.equal(metrics({ ok: true, cost: 1, pts: [[0, 0, 0], [1, 0, 0]], wet: null }, {}).swumYards, null);
	const expect = [{ type: 'metric', metric: 'swumYards', op: '==', value: 0 }];
	const [wet] = evaluateExpectations({ expect, result: { ok: true }, metrics: m });
	assert.deepEqual([wet.pass, wet.detail], [false, 'swumYards 21.5 (want == 0)']);
	const [dry] = evaluateExpectations({ expect, result: { ok: true }, metrics: { swumYards: 0 } });
	assert.equal(dry.pass, true);
});

test('the route corpus: a zone-map end in the Era frame (f "e") converts by that frame; a route\'s level and danger reach its query', () => {
	const { resolveRoutes } = require('../tools/lib/nav/eval/run');
	const calls = [];
	const geo = { toWorld: (m, x, y, f) => (calls.push(f), { c: 0, wx: x * 10, wy: y * 10 }) };
	const [r, bare] = resolveRoutes([{ id: 'r', kind: 'reported', from: { uiMap: 1420, x: 1, y: 2 }, to: { uiMap: 1424, x: 3, y: 4, f: 'e' }, profile: 'Horde', level: 20, danger: { 1416: 1000 }, expect: [] }, { id: 'bare', kind: 'reference', map: 0, from: [0, 0], to: [1, 1] }], geo);
	assert.deepEqual(calls, ['l', 'e']);
	assert.deepEqual([r.map, r.from, r.to, r.level, r.danger], [0, [10, 20, null], [30, 40, null], 20, { 1416: 1000 }]);
	assert.deepEqual([bare.level, bare.danger], [null, null]);
});

test('metrics: yards from the drawn line, the steepest climb between points; blocked, roads, hubs and indoor null without grid and layers', () => {
	const { metrics } = require('../tools/lib/nav/eval/metrics');
	const m = metrics({ ok: true, cost: 70, yards: null, pts: [[0, 0, 0], [30, 40, 0], [30, 50, 10], [30, 60, 0]] }, { grid: null, layers: {} });
	assert.equal(m.yards, 70);
	assert.equal(m.seconds, 10);
	assert.equal(m.maxClimbDeg, 45);
	assert.deepEqual([m.blocked, m.offRoad, m.hubYards, m.indoorYards, m.endIndoor], [null, null, null, null, null]);
	// hubYards.<side>: yards a player of that side walks in hubs hostile to it (a hub's side is its owner).
	const hubsLayer = { hubs: { 0: [{ id: 1, side: 'Alliance', name: 'Southshore', disks: [[50, 0, 10]] }, { id: 2, side: 'Horde', name: 'Tarren Mill', disks: [[0, 0, 10]] }] } };
	const through = metrics({ ok: true, cost: 100, pts: [[20, 0, 0], [100, 0, 0]] }, { grid: null, layers: hubsLayer, map: 0 });
	assert.ok(Math.abs(through.hubYards.Horde - 20) <= 1, `a Horde player through the Alliance hub: ${through.hubYards.Horde}`);
	assert.equal(through.hubYards.Alliance, 0, 'an Alliance player in its own hub counts nothing');
	const home = metrics({ ok: true, cost: 30, pts: [[0, 0, 0], [30, 0, 0]] }, { grid: null, layers: hubsLayer, map: 0 });
	assert.equal(home.hubYards.Horde, 0, 'a Horde walk out of its own hub counts 0');
	assert.ok(Math.abs(home.hubYards.Alliance - 10) <= 1, `an Alliance player in the Horde hub: ${home.hubYards.Alliance}`);
	// hubYardsAway: the same without the hubs an end lies in (endHubs, by the side they are hostile to).
	assert.deepEqual(through.endHubs, { Alliance: [], Horde: [] });
	assert.equal(through.hubYardsAway.Horde, through.hubYards.Horde, 'both ends outside: every hostile yard counts');
	assert.deepEqual(home.endHubs, { Alliance: ['Tarren Mill'], Horde: [] });
	assert.equal(home.hubYardsAway.Alliance, 0, 'an Alliance walk out of the Horde hub it starts in');
	const into = metrics({ ok: true, cost: 70, pts: [[-30, 0, 0], [50, 0, 0]] }, { grid: null, layers: hubsLayer, map: 0 });
	assert.deepEqual(into.endHubs, { Alliance: [], Horde: ['Southshore'] });
	assert.ok(Math.abs(into.hubYards.Horde - 10) <= 1 && into.hubYardsAway.Horde === 0, `into Southshore: ${into.hubYards.Horde} in all, ${into.hubYardsAway.Horde} away`);
});

test('metrics: offRoad counts a piece of the line with a road column within 8 yd as on the road', () => {
	const { metrics } = require('../tools/lib/nav/eval/metrics');
	// A road 2 yd wide along y = 0 (weight 200), plain ground (0) elsewhere.
	const layers = { roads: (c, x, y) => (Math.abs(y) < 1 ? 200 : 0) };
	const at = (y) => metrics({ ok: true, cost: 100, pts: [[0, y, 0], [100, y, 0]] }, { grid: null, layers, map: 0 }).offRoad;
	assert.equal(at(0), 0, 'on the road');
	assert.equal(at(7), 0, '7 yd beside it: on it');
	assert.equal(at(12), 1, '12 yd beside it: off it');
	const half = metrics({ ok: true, cost: 100, pts: [[0, 0, 0], [50, 0, 0], [50, 50, 0]] }, { grid: null, layers, map: 0 }).offRoad;
	assert.ok(Math.abs(half - 0.42) < 0.03, `the second half leaves the road: ${half}`);
});

test('compare: a hub route with an end inside a hostile hub is held to its yards in the other hostile hubs (A2)', () => {
	const { evaluateExpectations } = require('../tools/lib/nav/eval/compare');
	const expect = [{ type: 'metric', metric: 'hubYards.Horde', op: '==', value: 0 }];
	const route = (away, ends) => ({ expect, result: { ok: true }, metrics: { hubYards: { Alliance: 0, Horde: 48.2 }, hubYardsAway: { Alliance: 0, Horde: away }, endHubs: { Alliance: [], Horde: ends } } });
	const [inside] = evaluateExpectations(route(0, ['Southshore']));
	assert.equal(inside.pass, true);
	assert.match(inside.detail, /^hubYardsAway\.Horde 0 \(want == 0\) \(an end inside Southshore; 48\.2 yd in all\)$/);
	assert.equal(evaluateExpectations(route(5, ['Southshore']))[0].pass, false, 'another hostile hub on the way fails');
	assert.equal(evaluateExpectations(route(0, []))[0].pass, false, 'both ends outside: every hostile yard fails');
});

test('compare: A1 fails when a route that was ok becomes unreachable; the same maps pass; checks without data are n/a', () => {
	const { compare } = require('../tools/lib/nav/eval/compare');
	const route = (ok) => ({ id: 'raptor-horns', kind: 'reported', profile: null, expect: [{ type: 'ok' }], result: { ok, reason: ok ? null : 'unreachable', cost: ok ? 140 : null, ms: 10, pts: ok ? [[0, 0, 0], [140, 0, 0]] : [] }, metrics: ok ? { yards: 140, seconds: 20, blocked: 0.05, offRoad: null, hubYards: null, maxClimbDeg: 10, indoorYards: null } : null });
	const report = (ok) => ({ routes: [route(ok)], sweep: [] });
	const same = compare(report(true), report(true));
	assert.equal(same.pass, true, JSON.stringify(same.checks));
	assert.deepEqual(same.checks.map((c) => c.id), ['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8']);
	assert.equal(same.checks.find((c) => c.id === 'A2').pass, null, 'no hub layer: n/a');
	const lost = compare(report(true), report(false));
	assert.equal(lost.pass, false);
	assert.equal(lost.checks.find((c) => c.id === 'A1').pass, false);
	const sweep = (costs) => ({ routes: [], sweep: [{ id: '0|1429|Alliance', zone: 1429, profile: 'Alliance', targets: [[1, 2, null], [3, 4, null]], costs }] });
	assert.equal(compare(sweep([10, 20]), sweep([10, false])).checks.find((c) => c.id === 'A6').pass, false);
	assert.equal(compare(sweep([10, false]), sweep([12, 30])).checks.find((c) => c.id === 'A6').pass, true);
});

test('compare: A4 fails when any route found on the candidate climbs a step over 50 deg, and lists it beside the baseline\'s own', () => {
	const { compare } = require('../tools/lib/nav/eval/compare');
	const route = (id, kind, climb) => ({ id, kind, profile: null, expect: [], result: { ok: true, cost: 70, ms: 10, pts: [[0, 0, 0], [70, 0, 0]] }, metrics: { yards: 70, seconds: 10, blocked: 0, offRoad: null, hubYards: null, maxClimbDeg: climb, indoorYards: null } });
	const base = { routes: [route('ref-a', 'reference', 55), route('ref-b', 'reference', 20)], sweep: [] };
	const cand = { routes: [route('ref-a', 'reference', 30), route('ref-b', 'reference', 52.5)], sweep: [] };
	const a4 = compare(base, cand).checks.find((c) => c.id === 'A4');
	assert.equal(a4.pass, false);
	assert.match(a4.detail, /1 routes climb over 50 deg \(ref-b 52\.5\)/);
	assert.match(a4.detail, /baseline: 1 \(ref-a 55\)/);
	const fixed = { routes: [route('ref-a', 'reference', 30), route('ref-b', 'reference', 20)], sweep: [] };
	assert.notEqual(compare(base, fixed).checks.find((c) => c.id === 'A4').pass, false, 'the baseline over the limit never fails a candidate under it');
});

test('metrics: the indoor layer from a grid reads the surface nearest the point\'s height (FLAG.INDOOR), never a capital\'s interiors', () => {
	const { indoorLayer } = require('../tools/lib/nav/eval/metrics');
	const { cellOf, cellCentre, FLAG, TILE_CELLS } = require('../tools/lib/nav/grid/format');
	// Tile 32_32 of map 0: column k0 holds terrain at z 0, a blocked indoor ledge at z 5 and a building's floor at
	// z 10; column k1 (another chunk, in the capital area 1519) an indoor floor at z 0; every other column is empty.
	const P = cellCentre(32, 32, 20, 20);
	const Q = cellCentre(32, 32, 100, 100);
	const k0 = 20 * TILE_CELLS + 20;
	const k1 = 100 * TILE_CELLS + 100;
	const first = new Uint32Array(TILE_CELLS * TILE_CELLS + 1);
	for (let k = 0; k <= TILE_CELLS * TILE_CELLS; k++) first[k] = k <= k0 ? 0 : k <= k1 ? 3 : 4;
	const areas = new Uint16Array(256);
	areas[(100 >> 4) * 16 + (100 >> 4)] = 1519;
	const tile = { first, z: Float32Array.of(0, 5, 10, 0), flags: Uint8Array.of(FLAG.TERRAIN, FLAG.WMO | FLAG.INDOOR | FLAG.BLOCKED, FLAG.WMO | FLAG.INDOOR, FLAG.WMO | FLAG.INDOOR), areas };
	const grid = { tile: (c, col, row) => (c === 0 && col === 32 && row === 32 ? tile : null) };
	assert.deepEqual([cellOf(P.wx, P.wy).i, cellOf(P.wx, P.wy).j], [20, 20]);
	const indoor = indoorLayer(grid, (c, x, y, areaId) => areaId === 1519);
	assert.equal(indoor(0, P.wx, P.wy, 1), false, 'on the terrain');
	assert.equal(indoor(0, P.wx, P.wy, 6), true, 'the floor, not the blocked ledge');
	assert.equal(indoor(0, P.wx, P.wy, null), true, 'without a height: the highest walkable surface');
	assert.equal(indoor(0, Q.wx, Q.wy, 0), false, 'a capital\'s interior is no building cut through');
	assert.equal(indoorLayer(grid)(0, Q.wx, Q.wy, 0), true, 'without capitals it is indoors');
	assert.equal(indoor(0, P.wx + 10, P.wy, 0), null, 'a column with no surface');
	assert.equal(indoor(1, P.wx, P.wy, 0), null, 'no tile');
});

test('compare: A5 fails an ok route with both ends outdoors that walks indoors, passes one that goes round, skips one that ends indoors', () => {
	const { metrics } = require('../tools/lib/nav/eval/metrics');
	const { compare } = require('../tools/lib/nav/eval/compare');
	// A building over x 40..60, y -10..10.
	const layers = { indoor: (c, x, y) => x >= 40 && x <= 60 && Math.abs(y) <= 10 };
	const route = (id, pts) => {
		const result = { ok: true, cost: 100, ms: 10, pts };
		return { id, kind: 'reference', profile: null, expect: [], result, metrics: metrics(result, { grid: null, layers, map: 0 }) };
	};
	const through = route('ref-through', [[0, 0, 0], [100, 0, 0]]);
	const round = route('ref-round', [[0, 0, 0], [50, 20, 0], [100, 0, 0]]);
	const inside = route('ref-inside', [[0, 0, 0], [50, 0, 0]]);
	assert.ok(Math.abs(through.metrics.indoorYards - 20) <= 2, `through: ${through.metrics.indoorYards}`);
	assert.equal(through.metrics.endIndoor, false);
	assert.equal(round.metrics.indoorYards, 0);
	assert.equal(inside.metrics.endIndoor, true);
	const a5 = (routes) => compare({ routes, sweep: [] }, { routes, sweep: [] }).checks.find((c) => c.id === 'A5');
	const failed = a5([through, round, inside]);
	assert.equal(failed.pass, false);
	assert.match(failed.detail, /ref-through: indoorYards 2\d(\.\d)? \(both ends outdoors; baseline 2\d(\.\d)?\)/);
	assert.match(failed.detail, /baseline: 1 \(ref-through 2\d(\.\d)?\)/);
	assert.doesNotMatch(failed.detail, /ref-inside/);
	const passed = a5([round, inside]);
	assert.equal(passed.pass, true, passed.detail);
	assert.match(passed.detail, /1\/1 hold/);
	assert.equal(a5([{ ...round, metrics: { ...round.metrics, indoorYards: null, endIndoor: null } }]).pass, null, 'no indoor layer: n/a');
	// Ruling 29 (as Ruling 5's A4): each listed route beside its baseline yards, and the baseline's own listed.
	const tunnel = a5([through]);
	const was = compare({ routes: [round], sweep: [] }, { routes: [{ ...through, id: 'ref-round' }], sweep: [] }).checks.find((c) => c.id === 'A5');
	assert.match(was.detail, /ref-round: indoorYards 2\d(\.\d)? \(both ends outdoors; baseline 0\); baseline: 0$/);
	assert.match(tunnel.detail, /baseline: 1 \(ref-through/);
	// A baseline read from an earlier report gets its indoor yards from the layer now (measureIndoor).
	const { measureIndoor } = require('../tools/lib/nav/eval/metrics');
	const old = { routes: [{ ...through, metrics: { ...through.metrics, indoorYards: null, endIndoor: null, blocked: 0.5 } }, { ...through, id: 'lost', result: { ok: false }, metrics: null }] };
	measureIndoor(old, layers);
	assert.deepEqual([old.routes[0].metrics.indoorYards, old.routes[0].metrics.endIndoor, old.routes[0].metrics.blocked], [through.metrics.indoorYards, false, 0.5]);
	assert.equal(old.routes[1].metrics, null);
});

const noGrid = needs('map-frames.json', 'zones.json') || (fs.existsSync(path.join(ROOT, 'data', 'local', 'nav3', 'index.json')) ? false : 'no grid at data/local/nav3');

test('the route corpus: ids unique, every kind present, 20+ reference routes; every zone-map end converts and snaps to a walkable surface of our grid within 10 yd', { skip: noGrid }, () => {
	const { loadCorpus, resolveRoutes } = require('../tools/lib/nav/eval/run');
	const { Geo } = require('../tools/lib/planner/geo');
	const { openNav } = require('../tools/lib/nav/path');
	const corpus = loadCorpus();
	const ids = corpus.routes.map((r) => r.id);
	assert.equal(new Set(ids).size, ids.length, 'unique ids');
	for (const kind of ['reference', 'reported', 'hub', 'road', 'building', 'slope']) assert.ok(corpus.routes.some((r) => r.kind === kind), kind);
	assert.ok(corpus.routes.filter((r) => r.kind === 'reference').length >= 20);
	const geo = new Geo(JSON.parse(fs.readFileSync(path.join(DATA, 'map-frames.json'), 'utf8')), JSON.parse(fs.readFileSync(path.join(DATA, 'zones.json'), 'utf8')));
	const nav = openNav({ dir: path.join(ROOT, 'data', 'local', 'nav3') });
	const resolved = resolveRoutes(corpus.routes, geo);
	const far = [];
	let converted = 0;
	for (const [i, r] of resolved.entries()) {
		for (const end of ['from', 'to']) {
			if (Array.isArray(corpus.routes[i][end])) continue;
			converted++;
			const [wx, wy] = r[end];
			const s = nav.snap({ c: r.map, wx, wy, radius: 10 });
			if (!s || Math.hypot(s.wx - wx, s.wy - wy) > 10) far.push(`${r.id} ${end}`);
		}
	}
	assert.ok(converted >= 16, `${converted} zone-map ends`);
	assert.deepEqual(far, [], 'every converted end within 10 yd of a walkable surface');
});

test('the route corpus: a hub route marked `outside` has both ends at least that far outside every hub hostile to its profile', { skip: needs('map-frames.json', 'zones.json') || (fs.existsSync(path.join(ROOT, 'data', 'local', 'nav-layers', 'hubs.json')) ? false : 'no hubs layer (nav layers hubs)') }, () => {
	const { loadCorpus, resolveRoutes } = require('../tools/lib/nav/eval/run');
	const { Geo } = require('../tools/lib/planner/geo');
	const hubs = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'local', 'nav-layers', 'hubs.json'), 'utf8'));
	const geo = new Geo(JSON.parse(fs.readFileSync(path.join(DATA, 'map-frames.json'), 'utf8')), JSON.parse(fs.readFileSync(path.join(DATA, 'zones.json'), 'utf8')));
	const corpus = loadCorpus();
	const marked = corpus.routes.filter((r) => r.outside);
	assert.ok(marked.length >= 2, 'strict twins of the hub routes');
	for (const [i, r] of resolveRoutes(marked, geo).entries()) {
		const want = marked[i].outside;
		const hostile = (hubs[r.map] || []).filter((h) => h.side !== r.profile);
		for (const end of ['from', 'to']) {
			const [wx, wy] = r[end];
			const gap = Math.min(...hostile.flatMap((h) => h.disks.map(([x, y, rad]) => Math.hypot(wx - x, wy - y) - rad)));
			assert.ok(gap >= want, `${r.id} ${end}: ${gap.toFixed(1)} yd outside the nearest hostile hub disk (want >= ${want})`);
		}
	}
});

test('nav eval refuses a route style that is none of the three', () => {
	const r = spawnSync(process.execPath, [path.join(ROOT, 'tools/polestar.js'), 'nav', 'eval', '--style', 'sideways'], { encoding: 'utf8' });
	assert.equal(r.status, 2);
	assert.match(r.stderr, /--style: fastest, balanced or roads/);
});

test('nav eval refuses a saved baseline report in another route style', () => {
	const dir = tmpdir('nav-eval-style-');
	const file = path.join(dir, 'base.json');
	fs.writeFileSync(file, JSON.stringify({ summary: { style: 'balanced' }, routes: [], sweep: [] }));
	const r = spawnSync(process.execPath, [path.join(ROOT, 'tools/polestar.js'), 'nav', 'eval', '--style', 'roads', '--baseline', file], { encoding: 'utf8' });
	assert.equal(r.status, 2);
	assert.match(r.stderr, /--baseline: the report is balanced, this run is roads/);
});
