'use strict';
// The levels the route brings a player to each leveling guide, and the check that every leveling guide's `levels`
// header says them (tests/route-levels.test.js). data/route-levels.json holds, per faction and guide, the level model's
// arrival and exit (tools/route-levels.js refreshes it from a level model run; docs/RELEASING.md, step 3).
//
// Arrival: the earliest race's median level at the guide's first step; exit: the latest race's median level when it
// ends (each race's median over its classes). A header `levels <lo>-<hi>` matches when lo reads the arrival and hi
// the exit as a player would: floor or rounded (57.7 may read 57 or 58, 37.5 may read 37 or 38), hi never below lo.

const fs = require('node:fs');

const FACTIONS = ['Alliance', 'Horde'];
const EPS = 1e-9;

function median(values) {
	const v = [...values].sort((a, b) => a - b);
	const m = v.length >> 1;
	return v.length % 2 ? v[m] : (v[m - 1] + v[m]) / 2;
}

const round3 = (x) => Math.round(x * 1000) / 1000;

// files: one level model run per faction, in FACTIONS order (each a list of race/class runs whose `rows` name the
// guide `id` with its `start` and `end` level) -> { Alliance: { [guide]: [arrive, exit] }, Horde: { ... } }, guides
// sorted.
function summarize(files) {
	if (files.length !== FACTIONS.length) throw new Error(`one level model run per faction: ${FACTIONS.join(', ')}`);
	const out = {};
	files.forEach((file, i) => {
		const byGuide = new Map();
		for (const run of JSON.parse(fs.readFileSync(file, 'utf8'))) {
			for (const row of run.rows || []) {
				if (row.start == null || row.end == null) continue;
				if (!byGuide.has(row.id)) byGuide.set(row.id, new Map());
				const byRace = byGuide.get(row.id);
				if (!byRace.has(run.race)) byRace.set(run.race, { start: [], end: [] });
				byRace.get(run.race).start.push(row.start);
				byRace.get(run.race).end.push(row.end);
			}
		}
		const routes = {};
		for (const id of [...byGuide.keys()].sort()) {
			const races = [...byGuide.get(id).values()];
			routes[id] = [round3(Math.min(...races.map((r) => median(r.start)))), round3(Math.max(...races.map((r) => median(r.end))))];
		}
		out[FACTIONS[i]] = routes;
	});
	return out;
}

// The header range the route allows: lo in [floor(arrive), round(arrive)], hi in [max(lo, floor(exit)), round(exit)]
// (round(exit) raised to floor(arrive) for a guide the route ends within its first level).
function allowed([arrive, exit]) {
	const lo = Math.floor(arrive + 0.05 + EPS);
	return { lo: [lo, Math.max(lo, Math.round(arrive))], hiFloor: Math.floor(exit + EPS), hiTop: Math.max(lo, Math.round(exit)) };
}

function matches(range, { min, max }) {
	const a = allowed(range);
	return a.lo[0] <= min && min <= a.lo[1] && Math.max(min, a.hiFloor) <= max && max <= a.hiTop;
}

// headers: { [guide]: { category, levels: { [faction]: { min, max } } } } (tests/helpers/guide-levels.js);
// snapshot: data/route-levels.json -> the problems, one line each: a leveling guide whose header differs from the
// route (unless `keep` holds that exact header for it), one the snapshot lacks, a snapshot guide that's gone.
function check(headers, snapshot) {
	const bad = [];
	const kept = new Map(snapshot.keep.map((k) => [`${k.faction} ${k.guide}`, k.levels]));
	for (const f of FACTIONS) {
		const routes = snapshot.routes[f] || {};
		for (const [id, g] of Object.entries(headers).sort(([a], [b]) => a.localeCompare(b))) {
			const h = g.category === 'Leveling' && g.levels[f];
			if (!h) continue;
			const range = routes[id];
			if (!range) {
				bad.push(`${f} ${id}: no route levels in data/route-levels.json (refresh it: docs/RELEASING.md, step 3)`);
				continue;
			}
			const keep = kept.get(`${f} ${id}`);
			if (keep && keep[0] === h.min && keep[1] === h.max) continue;
			if (!matches(range, h)) {
				const a = allowed(range);
				bad.push(`${f} ${id}: header ${h.min}-${h.max}, route ${a.lo[0]}-${a.hiTop} (${range[0].toFixed(1)} -> ${range[1].toFixed(1)})`);
			}
		}
		for (const id of Object.keys(routes)) {
			if (!headers[id] || !headers[id].levels[f]) bad.push(`${f} ${id}: in data/route-levels.json but no ${f} leveling guide has that id`);
		}
	}
	return bad;
}

module.exports = { FACTIONS, summarize, allowed, matches, check };
