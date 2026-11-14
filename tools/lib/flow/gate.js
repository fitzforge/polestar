'use strict';
// The route-feel gate (docs/ROUTE-FEEL.md): a candidate's flow audit against the shipped guides' audit, in the same
// mode (the same faction, route choices and dungeons). It fails when a guide or a branch got worse than shipped and
// data/flow-gate.json gives no reason for it.
//   The solo route (dungeons off, any route choice): per guide, the mean over the branches that play it: the flow
//     score, avoidable backtracks, givers passed within 40 yd and taken later; per branch, the whole chain:
//     back-and-forth (avoidable backtracks and hub revisits; wasted walking minutes), carried quests (carried far:
//     held through a whole guide or 2+ hours; hours carried) and quests never handed in.
//   Dungeons on (either style): the route takes the dungeon quests it can, so its extra travel and detours are expected and only
//     reported. It fails on avoidable backtracks and hub revisits, givers and enders walked past, and quests never
//     handed in.
//   Every mode: a quest log over the game's 40 at any point fails, whatever the shipped guides did.

const { WALK_YPS } = require('./data');
const { score, IRRITATIONS } = require('./audit');

// How much worse counts: small knock-on changes (a branch arriving a little higher or lower) stay under these.
const TOL = {
	score: 0.3,                 // flow score per 10 quests
	backtracks_avoidable: 0.25, // a guide's mean: a quarter of its branches with one more
	passed_givers_near: 0.25,
	passed_enders: 0.25,
	wasted_min: 5,              // a branch's wasted walking minutes: 5 min, or 3% when more
	wasted_share: 0.03,
	carried_hours_share: 0.05,  // a branch's hours carried: 5% plus an hour
	carried_hours: 1,
};
// The game's quest log holds 40 quests.
const LOG_CAP = 40;
// A guide whose quests changed by more than this share (split, merged) is compared through the branches only.
const RESTRUCTURED = 0.25;

// [check, value, tolerance, what, modes]: "solo" (dungeons off), "run" (dungeons on) or both.
const GUIDE_CHECKS = [
	['score', (m) => score(m), TOL.score, 'flow score per 10 quests', ['solo']],
	['backtracks_avoidable', (m) => m.backtracks_avoidable, TOL.backtracks_avoidable, 'avoidable backtracks', ['solo', 'run']],
	['passed_givers_near', (m) => m.passed_givers_near, TOL.passed_givers_near, 'givers passed within 40 yd, taken later', ['solo', 'run']],
	['passed_enders', (m) => m.passed_enders, TOL.passed_enders, 'enders passed with the quest done, handed in later', ['run']],
];

// One branch's chain-wide numbers, from its zone rows (the guide score's formula over the whole chain).
function branchMetrics(b) {
	const z = Object.values(b.zones || {});
	const s = (k) => z.reduce((t, r) => t + (r[k] || 0), 0);
	const quests = s('quests');
	const retraceMin = s('retrace_km') * 1000 / WALK_YPS / 60;
	const wasted = s('flow_cost_min') + retraceMin + s('hub_zigzag_yd') / WALK_YPS / 60;
	const irrit = IRRITATIONS.reduce((t, k) => t + s(k), 0);
	const hubVisits = s('hub_visits');
	return {
		hours: b.hours, quests, score: 10 * (wasted + irrit) / Math.max(quests, 5), wasted_min: wasted, retrace_min: retraceMin,
		zigzag_yd: s('hub_zigzag_yd'), backtracks_avoidable: s('backtracks_avoidable'), backtracks: s('backtracks'), reversals: s('reversals'),
		hub_revisits_avoidable: s('hub_revisits_avoidable'), passed_givers_near: s('passed_givers_near'), passed_givers_hub: s('passed_givers_hub'),
		passed_enders: s('passed_enders'), deferred: s('deferred'), missed_merges: s('missed_merges'), thin_hub_visits: s('thin_hub_visits'),
		hub_visits: hubVisits, handins_per_visit: s('hub_interactions') / Math.max(hubVisits, 1), walk_km: s('walk_km'),
		log_max: b.log_max, log_mean: b.log_mean || 0, carried: b.carried || 0, carried_far: b.carried_far || 0,
		carried_hours: b.carried_hours || 0, early_pickups: b.early_pickups || 0, never_handed: b.never_handed || 0,
		dng_trips: b.dng_trips || 0, dng_trip_min: b.dng_trip_min || 0, dng_door_min: b.dng_door_min || 0,
	};
}

const BRANCH_CHECKS = [
	['back_and_forth', (m) => m.backtracks_avoidable + m.hub_revisits_avoidable, () => 0, 'avoidable backtracks and hub revisits', ['solo', 'run']],
	['wasted_min', (m) => m.wasted_min, (b) => Math.max(TOL.wasted_min, b * TOL.wasted_share), 'wasted walking minutes', ['solo']],
	['carried_far', (m) => m.carried_far, () => 0, 'quests carried far (through a whole guide, or 2+ hours)', ['solo']],
	['carried_hours', (m) => m.carried_hours, (b) => b * TOL.carried_hours_share + TOL.carried_hours, 'hours of quests carried into later guides', ['solo']],
	['never_handed', (m) => m.never_handed, () => 0, 'quests picked up and never handed in', ['solo', 'run']],
];

// A reason's mode or faction: left out or "*" holds in all; "run*" in every mode that starts with run.
const matches = (want, v) => want == null || want === '*' || want === v || (want.endsWith('*') && String(v ?? '').startsWith(want.slice(0, -1)));

// The reason (data/flow-gate.json `reasons`) that accepts a failure: the same check, mode and faction where the reason
// names them, and the failing guide (a guide check) or branch (a branch check) by name, or "*" for all of them.
function reasonFor(f, reasons, ctx) {
	const target = (r) => (f.guide != null ? r.guide === f.guide || r.guide === '*' : r.branch === f.branch || r.branch === '*');
	return reasons.find((r) => r.check === f.check && matches(r.mode, ctx.mode) && matches(r.faction, ctx.faction) && target(r)) || null;
}

// before / after: runAudit's output. ctx: { mode, faction } for the reasons; `run` (dungeons on) picks the run
// mode's checks (default: the audit's own `dungeons`). A guide new to the candidate, or one whose quests changed by more
// than RESTRUCTURED (split, merged, content moved), is compared through the branches only: its own numbers measure a
// different guide. -> { fail, accepted, notCompared, restructured, checked, kind }
function compare(before, after, reasons = [], ctx = {}) {
	const kind = (ctx.run ?? Boolean(after.dungeons)) ? 'run' : 'solo';
	const fail = [], accepted = [];
	const add = (f) => {
		const r = reasonFor(f, reasons, ctx);
		if (r) accepted.push({ ...f, reason: r.reason });
		else fail.push(f);
	};
	let checked = 0;
	const notCompared = [], restructured = [];
	for (const [gid, ga] of Object.entries(after.guides)) {
		const gb = before.guides[gid];
		if (!gb) {
			notCompared.push(gid);
			continue;
		}
		if (Math.abs(ga.mean.quests - gb.mean.quests) > RESTRUCTURED * Math.max(gb.mean.quests, 1)) {
			restructured.push({ guide: gid, before: gb.mean.quests, after: ga.mean.quests });
			continue;
		}
		for (const [check, get, tol, what, modes] of GUIDE_CHECKS) {
			if (!modes.includes(kind)) continue;
			checked += 1;
			const b = get(gb.mean), a = get(ga.mean);
			if (a > b + tol + 1e-9) add({ check, guide: gid, before: b, after: a, what });
		}
	}
	const bb = new Map(before.branches.map((b) => [b.branch, branchMetrics(b)]));
	for (const br of after.branches) {
		const ma = branchMetrics(br);
		checked += 1;
		if (ma.log_max > LOG_CAP) add({ check: 'log_cap', branch: br.branch, before: bb.has(br.branch) ? bb.get(br.branch).log_max : 0, after: ma.log_max, what: `quests in the log at once (the game holds ${LOG_CAP})` });
		const mb = bb.get(br.branch);
		if (!mb) {
			notCompared.push(br.branch);
			continue;
		}
		for (const [check, get, tol, what, modes] of BRANCH_CHECKS) {
			if (!modes.includes(kind)) continue;
			checked += 1;
			const b = get(mb), a = get(ma);
			if (a > b + tol(b) + 1e-9) add({ check, branch: br.branch, before: b, after: a, what });
		}
	}
	return { fail, accepted, notCompared, restructured, checked, kind };
}

// label, key, format digits, lower is better: the before/after table per faction (mean per branch).
const TABLE_ROWS = [
	['model hours to the end', 'hours', 1, true],
	['flow score per 10 quests', 'score', 2, true],
	['wasted walking, minutes', 'wasted_min', 1, true],
	['ground walked twice, minutes', 'retrace_min', 1, true],
	['backtracks, avoidable', 'backtracks_avoidable', 1, true],
	['backtracks, all', 'backtracks', 0, true],
	['direction reversals', 'reversals', 0, true],
	['hub revisits, avoidable', 'hub_revisits_avoidable', 1, true],
	['hub zigzag, yards', 'zigzag_yd', 0, true],
	['givers passed within 40 yd, taken later', 'passed_givers_near', 1, true],
	['enders passed with the quest done', 'passed_enders', 1, true],
	['work passed, done on a later trip', 'deferred', 1, true],
	['missed merges', 'missed_merges', 1, true],
	['town visits with one quest', 'thin_hub_visits', 1, true],
	['accepts and hand-ins per town visit', 'handins_per_visit', 2, false],
	['quests handed in', 'quests', 0, false],
	['quest log, peak', 'log_max', 0, true],
	['quest log, time-weighted mean', 'log_mean', 1, true],
	['quests carried into a later guide', 'carried', 1, true],
	['carried far (a whole guide, or 2+ hours)', 'carried_far', 1, true],
	['hours of quests carried, summed', 'carried_hours', 0, true],
	['pick-ups an hour or more before their work', 'early_pickups', 1, true],
	['picked up, never handed in', 'never_handed', 1, true],
];
const DUNGEON_ROWS = [
	['trips only for dungeon quests', 'dng_trips', 1, true],
	['their minutes', 'dng_trip_min', 1, true],
	['the runs\' door detours, minutes', 'dng_door_min', 1, true],
];

function table(before, after, { dungeons = false } = {}) {
	const bb = new Map(before.branches.map((b) => [b.branch, branchMetrics(b)]));
	const aa = new Map(after.branches.map((b) => [b.branch, branchMetrics(b)]));
	const keys = [...aa.keys()].filter((k) => bb.has(k));
	const out = [`Mean per branch over ${keys.length} start x class branches; worse / better: how many branches got worse or better.`, '',
		'| | before | after | change | branches worse / better |', '|---|---|---|---|---|'];
	for (const [label, k, digits, low] of [...TABLE_ROWS, ...(dungeons ? DUNGEON_ROWS : [])]) {
		const mean = (m) => keys.reduce((s, x) => s + m.get(x)[k], 0) / Math.max(keys.length, 1);
		const b = mean(bb), a = mean(aa);
		const worse = keys.filter((x) => (low ? aa.get(x)[k] - bb.get(x)[k] : bb.get(x)[k] - aa.get(x)[k]) > 1e-9).length;
		const better = keys.filter((x) => (low ? bb.get(x)[k] - aa.get(x)[k] : aa.get(x)[k] - bb.get(x)[k]) > 1e-9).length;
		const d = a - b;
		const ch = Math.abs(d) < 10 ** -digits / 2 ? '=' : `${d > 0 ? '+' : ''}${d.toFixed(digits)}`;
		out.push(`| ${label} | ${b.toFixed(digits)} | ${a.toFixed(digits)} | ${ch} | ${worse} / ${better} |`);
	}
	return out.join('\n');
}

function formatResult(res, title) {
	const num = (v) => (Number.isInteger(v) ? String(v) : v.toFixed(2));
	const line = (f) => `  ${f.guide ? f.guide.replace(/^forever\//, '') : f.branch}: ${f.what} ${num(f.before)} -> ${num(f.after)}${f.reason ? ` (reason: ${f.reason})` : ''}`;
	const out = [`${title} (${res.kind === 'run' ? 'dungeons on: detours reported, not gated' : 'solo route'}): ${res.fail.length ? 'FAIL' : 'pass'} (${res.checked} checks, ${res.fail.length} worse than before, ${res.accepted.length} accepted with a reason)`];
	for (const f of res.fail) out.push(line(f));
	if (res.accepted.length) {
		out.push(' accepted:');
		for (const f of res.accepted) out.push(line(f));
	}
	if (res.notCompared.length) out.push(` not in the earlier run (compared through the branches only): ${res.notCompared.map((g) => g.replace(/^forever\//, '')).join(', ')}`);
	if (res.restructured && res.restructured.length) out.push(` restructured, quests changed by more than a quarter (compared through the branches only): ${res.restructured.map((r) => `${r.guide.replace(/^forever\//, '')} ${r.before} -> ${r.after}`).join(', ')}`);
	return out.join('\n');
}

module.exports = { compare, table, formatResult, branchMetrics, reasonFor, TOL, LOG_CAP, RESTRUCTURED, GUIDE_CHECKS, BRANCH_CHECKS };
