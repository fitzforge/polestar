'use strict';
// `nav eval`'s verdicts: each corpus route's own expectations, a report's
// summary, and two reports (baseline, candidate: run.js evaluate) against the
// walking maps' acceptance checks A1-A8 (below; A9, memory, is read from
// the harness's kb figures and signed off by hand).
//
//   evaluateExpectations(route) -> [{ type, pass: true | false | null (n/a), detail }]
//   summarize(report) -> { style, routes, ok, blockedShare, medianMs, sweep: { <profile>: { zones, targets, reachable } } }
//   compare(base, cand) -> { pass, checks: [{ id: 'A1'..'A8', pass: true | false | null, detail }] }
//
// Expectations (routes.json `expect`):
//   { type: 'ok' }                                  the route is found
//   { type: 'metric', metric: 'hubYards.Horde', op: '<=', value: 0 }   a metric (metrics.js) holds; n/a while null
//     (hubYards.<side> of a route with an end inside a hub hostile to that side reads hubYardsAway.<side>;
//     zoneYards.<uiMapID> reads 0 for a zone the line never enters, n/a on maps without zones)
//   { type: 'hubs', includes: 'Southshore' }        the router reports that hub (n/a while it reports none)
//   { type: 'faceClearance', face: [x, y, z], gt }  the drawn line passes the face's middle further than gt yd
// A check is n/a (pass null) while a measurement it needs is null (a layer not built, a router without hubs):
// false when any part fails, else null when any part is n/a, else true.
//   A1 every `reported` route ok in cand with its expectations; no route ok in base unreachable in cand
//   A2-A4 the expectations of the hub, road and slope routes; A4 also: no route ok in cand climbs a step
//     steeper than CLIMB_LIMIT (the baseline's own over-limit routes are listed, never a pass), and the slope
//     routes' mean steepest climb in cand at most base's
//   A5 the building routes' expectations, and no indoor yards (metrics.js indoorYards) on any other route ok in cand
//     with both ends outdoors (endIndoor false); each route that has some is listed, for a person to judge whether
//     it is the only way
//   A6 sweep: no target reachable in base unreachable in cand
//   A7 weighted blocked share (by drawn length, routes ok in both) cand <= base
//   A8 median cold search ms (routes ok in both) cand <= 1.5 x base

const { lineLength } = require('./metrics');

const CLIMB_LIMIT = 50; // deg: the walk limit no drawn step of any route may climb

const OPS = {
	'<=': (a, b) => a <= b,
	'<': (a, b) => a < b,
	'==': (a, b) => a === b,
	'>=': (a, b) => a >= b,
	'>': (a, b) => a > b,
};

const get = (obj, dotted) => dotted.split('.').reduce((o, k) => (o === null || o === undefined ? null : o[k] === undefined ? null : o[k]), obj);

// Least flat distance from a point to a polyline.
function distToLine(pts, [px, py]) {
	let best = Infinity;
	for (let i = 1; i < pts.length; i++) {
		const [ax, ay] = pts[i - 1];
		const [bx, by] = pts[i];
		const dx = bx - ax;
		const dy = by - ay;
		const l2 = dx * dx + dy * dy;
		const t = l2 ? Math.max(0, Math.min(1, ((px - ax) * dx + (py - ay) * dy) / l2)) : 0;
		best = Math.min(best, Math.hypot(ax + dx * t - px, ay + dy * t - py));
	}
	if (pts.length === 1) best = Math.hypot(pts[0][0] - px, pts[0][1] - py);
	return best;
}

function evaluateExpectations(route) {
	const r = route.result || {};
	const m = route.metrics;
	return (route.expect || []).map((e) => {
		if (e.type === 'ok') return { type: e.type, pass: !!r.ok, detail: r.ok ? 'found' : `not found (${r.reason})` };
		if (!r.ok) return { type: e.type, pass: false, detail: `not found (${r.reason})` };
		if (e.type === 'metric') {
			// A route with an end inside a hub hostile to the side (it goes there on purpose) is held to its yards in
			// the other hostile hubs (hubYardsAway: A2 counts routes with both ends outside).
			const side = /^hubYards\.(Alliance|Horde)$/.exec(e.metric);
			const ends = side && m && m.endHubs ? m.endHubs[side[1]] : [];
			const metric = ends.length ? `hubYardsAway.${side[1]}` : e.metric;
			const zone = /^zoneYards\.(\d+)$/.exec(e.metric);
			const v = zone ? (m && m.zoneYards ? m.zoneYards[zone[1]] || 0 : null) : get(m, metric);
			if (v === null) return { type: e.type, pass: null, detail: `${metric} n/a` };
			const note = ends.length ? ` (an end inside ${ends.join(', ')}; ${get(m, e.metric)} yd in all)` : '';
			return { type: e.type, pass: OPS[e.op](v, e.value), detail: `${metric} ${v} (want ${e.op} ${e.value})${note}` };
		}
		if (e.type === 'hubs') {
			if (!Array.isArray(r.hubs)) return { type: e.type, pass: null, detail: 'hubs n/a' };
			const names = r.hubs.map((h) => String(h.name));
			return { type: e.type, pass: names.some((n) => n.toLowerCase().includes(e.includes.toLowerCase())), detail: `hubs [${names.join(', ')}] (want ${e.includes})` };
		}
		if (e.type === 'faceClearance') {
			const d = distToLine(r.pts || [], e.face);
			return { type: e.type, pass: d > e.gt, detail: `${d.toFixed(1)} yd from the face's middle (want > ${e.gt})` };
		}
		throw new Error(`route ${route.id}: unknown expectation ${e.type}`);
	});
}

// true / false / null from parts (any false: false; any null: n/a).
function verdict(parts) {
	if (parts.some((p) => p === false)) return false;
	if (!parts.length || parts.some((p) => p === null)) return null;
	return true;
}

const median = (xs) => {
	if (!xs.length) return null;
	const s = [...xs].sort((a, b) => a - b);
	return s.length % 2 ? s[(s.length - 1) / 2] : (s[s.length / 2 - 1] + s[s.length / 2]) / 2;
};

// Weighted blocked share over routes (by drawn length); null without measurements.
function blockedOf(routes) {
	let bad = 0;
	let tot = 0;
	for (const r of routes) {
		if (!r.result.ok || !r.metrics || r.metrics.blocked === null) continue;
		const L = lineLength(r.result.pts);
		bad += r.metrics.blocked * L;
		tot += L;
	}
	return tot ? bad / tot : null;
}

function summarize(report) {
	const routes = report.routes || [];
	const sweep = {};
	for (const z of report.sweep || []) {
		const s = (sweep[z.profile] = sweep[z.profile] || { zones: 0, targets: 0, reachable: 0 });
		s.zones++;
		s.targets += z.targets.length;
		s.reachable += (z.costs || []).filter((c) => c !== false && c !== null).length;
	}
	const blocked = blockedOf(routes);
	const ms = median(routes.filter((r) => r.result.ok).map((r) => r.result.ms));
	return {
		style: report.style || 'balanced',
		routes: routes.length,
		ok: routes.filter((r) => r.result.ok).length,
		blockedShare: blocked === null ? null : +blocked.toFixed(4),
		medianMs: ms === null ? null : +ms.toFixed(2),
		sweep,
	};
}

function kindCheck(id, cand, kind, label) {
	const parts = [];
	const notes = [];
	for (const r of cand.routes.filter((x) => x.kind === kind)) {
		for (const v of r.verdicts || evaluateExpectations(r)) {
			if (v.type === 'ok' && kind !== 'reported') continue; // found or not: A1 and A6's business; these judge the ground
			parts.push(v.pass);
			if (v.pass !== true) notes.push(`${r.id}: ${v.detail}`);
		}
	}
	const pass = verdict(parts);
	return { id, pass, detail: parts.length ? `${label}: ${parts.filter((p) => p === true).length}/${parts.length} hold${notes.length ? `; ${notes.join('; ')}` : ''}` : `${label}: no routes` };
}

function compare(base, cand) {
	const baseById = new Map(base.routes.map((r) => [r.id, r]));
	const both = cand.routes.filter((r) => r.result.ok && baseById.get(r.id) && baseById.get(r.id).result.ok);
	const checks = [];

	// A1: reported routes, and nothing lost.
	{
		const parts = [];
		const notes = [];
		for (const r of cand.routes.filter((x) => x.kind === 'reported')) {
			const vs = r.verdicts || evaluateExpectations(r);
			const ok = !!r.result.ok && vs.every((v) => v.pass !== false);
			parts.push(ok);
			if (!ok) notes.push(`${r.id}: ${r.result.ok ? vs.filter((v) => v.pass === false).map((v) => v.detail).join(', ') : `not found (${r.result.reason})`}`);
		}
		for (const r of cand.routes) {
			const b = baseById.get(r.id);
			if (b && b.result.ok && !r.result.ok) {
				parts.push(false);
				notes.push(`${r.id}: found on the baseline, ${r.result.reason} now`);
			}
		}
		checks.push({ id: 'A1', pass: parts.length ? !parts.includes(false) : null, detail: notes.length ? notes.join('; ') : `${cand.routes.filter((x) => x.kind === 'reported').length} reported routes hold, no route lost` });
	}
	checks.push(kindCheck('A2', cand, 'hub', 'hostile hubs'));
	checks.push(kindCheck('A3', cand, 'road', 'roads'));
	{
		const a4 = kindCheck('A4', cand, 'slope', 'slopes');
		const climb = (rep) => {
			const xs = rep.routes.filter((r) => r.kind === 'slope' && r.result.ok && r.metrics).map((r) => r.metrics.maxClimbDeg);
			return xs.length ? xs.reduce((s, x) => s + x, 0) / xs.length : null;
		};
		const over = (rep) => rep.routes.filter((r) => r.result.ok && r.metrics && r.metrics.maxClimbDeg > CLIMB_LIMIT).map((r) => `${r.id} ${r.metrics.maxClimbDeg}`);
		const candOver = over(cand);
		const baseOver = over(base);
		const b = climb(base);
		const c = climb(cand);
		const mean = b === null || c === null ? null : c <= b + 1e-9;
		a4.pass = verdict([a4.pass, candOver.length === 0, mean]);
		a4.detail += `; ${candOver.length} routes climb over ${CLIMB_LIMIT} deg${candOver.length ? ` (${candOver.join(', ')})` : ''}`;
		a4.detail += `; baseline: ${baseOver.length}${baseOver.length ? ` (${baseOver.join(', ')})` : ''}`;
		a4.detail += `; mean steepest climb ${c === null ? 'n/a' : c.toFixed(1)} deg (baseline ${b === null ? 'n/a' : b.toFixed(1)})`;
		checks.push(a4);
	}
	// A5: buildings. As A4's climbs (Ruling 5): each route walking indoors is listed beside its baseline yards, and the
	// baseline's own listed, for a person to judge the only-way ones (a tunnel the baseline walks too); never a pass.
	{
		const parts = [];
		const notes = [];
		const indoorOf = (r) => {
			const m = r && r.result.ok ? r.metrics : null;
			return m && typeof m.indoorYards === 'number' && !m.endIndoor && r.kind !== 'building' ? m.indoorYards : null;
		};
		for (const r of cand.routes) {
			if (r.kind === 'building') {
				for (const v of r.verdicts || evaluateExpectations(r)) {
					if (v.type === 'ok') continue;
					parts.push(v.pass);
					if (v.pass !== true) notes.push(`${r.id}: ${v.detail}`);
				}
				continue;
			}
			const m = r.result.ok ? r.metrics : null;
			if (!m) continue;
			if (m.indoorYards === null || m.indoorYards === undefined) {
				parts.push(null);
				continue;
			}
			if (m.endIndoor) continue;
			parts.push(m.indoorYards === 0);
			if (m.indoorYards === 0) continue;
			const b = baseById.get(r.id);
			const was = !b ? 'not in the baseline' : !b.result.ok ? 'not found there' : indoorOf(b) === null ? 'n/a' : indoorOf(b);
			notes.push(`${r.id}: indoorYards ${m.indoorYards} (both ends outdoors; baseline ${was})`);
		}
		const baseIn = base.routes.filter((r) => indoorOf(r)).map((r) => `${r.id} ${indoorOf(r)}`);
		const nulls = parts.filter((p) => p === null).length;
		const detail = parts.length ? `buildings: ${parts.filter((p) => p === true).length}/${parts.length} hold${nulls ? ` (${nulls} n/a: no indoor layer)` : ''}${notes.length ? `; ${notes.join('; ')}` : ''}; baseline: ${baseIn.length}${baseIn.length ? ` (${baseIn.join(', ')})` : ''}` : 'buildings: no routes';
		checks.push({ id: 'A5', pass: verdict(parts), detail });
	}

	// A6: the goal sweep.
	{
		const baseSweep = new Map((base.sweep || []).map((z) => [z.id, z]));
		let lost = 0;
		let compared = 0;
		const notes = [];
		for (const z of cand.sweep || []) {
			const b = baseSweep.get(z.id);
			if (!b) continue;
			const at = new Map(b.targets.map((t, i) => [t.join(','), b.costs[i]]));
			z.targets.forEach((t, i) => {
				const was = at.get(t.join(','));
				if (was === undefined) return;
				compared++;
				if (was !== false && was !== null && (z.costs[i] === false || z.costs[i] === null)) {
					lost++;
					if (notes.length < 20) notes.push(`${z.id} goal ${t.map((v) => (v === null ? 'nil' : v)).join(',')}`);
				}
			});
		}
		checks.push({ id: 'A6', pass: compared ? lost === 0 : null, detail: compared ? `${lost} of ${compared} goals lost${notes.length ? `: ${notes.join('; ')}` : ''}` : 'no sweep in both' });
	}

	// A7: blocked share on the routes found in both.
	{
		const b = blockedOf(both.map((r) => baseById.get(r.id)));
		const c = blockedOf(both);
		checks.push({ id: 'A7', pass: b === null || c === null ? null : c <= b + 1e-9, detail: b === null || c === null ? 'no blocked share (no grid)' : `${(100 * c).toFixed(1)}% (baseline ${(100 * b).toFixed(1)}%) over ${both.length} routes` });
	}

	// A8: median cold search.
	{
		const b = median(both.map((r) => baseById.get(r.id).result.ms).filter((x) => typeof x === 'number'));
		const c = median(both.map((r) => r.result.ms).filter((x) => typeof x === 'number'));
		checks.push({ id: 'A8', pass: b === null || c === null ? null : c <= 1.5 * b, detail: b === null || c === null ? 'no timings' : `median ${c.toFixed(1)} ms (baseline ${b.toFixed(1)} ms, limit ${(1.5 * b).toFixed(1)})` });
	}
	return { pass: !checks.some((c) => c.pass === false), checks };
}

module.exports = { compare, evaluateExpectations, summarize, distToLine };
