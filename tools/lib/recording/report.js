'use strict';
// Route measurement: how long each guide step really takes, from recorded
// play (data/recordings/*.json, `step` snapshots written by the recorder
// while Polestar runs).
//
//   const { buildReport, formatReport } = require('./recording/report');
//   const report = buildReport(sessions, { guide: 'elwynn' });
//   console.log(formatReport(report));
//
// How the event stream becomes step passes:
//
// - A `step` snapshot (reason step/guide/login) starts a segment: from then
//   on, until the next snapshot or the session's last event, play time counts
//   for that guide and step. `complete` snapshots only close a guide.
// - Play time is the sum of the gaps between consecutive events, each capped
//   at IDLE_CAP (5 min), and gaps while flagged AFK count zero. So a /reload
//   costs its few seconds, an AFK break at most 5 minutes, and time between
//   sessions nothing.
// - Passes follow a per-character, per-guide frontier: entering a step past
//   the frontier closes the previous frontier step's pass and opens a new
//   one; returning to the frontier step (after a tab switch, a reload, a
//   Prev/Next or a new session) continues its pass; a step behind the
//   frontier (Prev, Goto back, a step un-done) is a revisit, reported apart
//   and kept out of the step's passes. Completing the guide closes the last
//   pass and resets the frontier. Passes still open at the end are counted
//   as `open` and kept out of the statistics. Only the active tab is ever
//   recorded, so background tabs never count.
// - XP comes from the snapshots (level, XP), converted to cumulative XP with
//   the recorded XP-per-level (falling back to the 1.12 table), so level-ups
//   inside a step are counted in full.

const { LEVEL_XP } = require('../game/xp');

const IDLE_CAP = 300; // seconds of no events counted at most
const TELEPORT_SPEED = 40; // yd/s: faster jumps between positions are hearths/ports, not travel
const FALLBACK_W = 3500; // map size when a session has no bounds for a map (as draft.js)
const FALLBACK_H = 2333;

// Ranking thresholds.
const MIN_STEP_TIME = 60; // seconds of pass time before a step is ranked by XP/hr
const OVER_RATIO = 2; // "far over": median at least twice the baseline ...
const OVER_EXCESS = 120; // ... and at least this many seconds over it
const DETOUR_YARDS = 600; // median travel of a detour step
const DETOUR_FACTOR = 3; // XP per yard this many times below the guide's

function charKey(s) {
	const c = s.char || {};
	return c.name ? `${c.name}-${c.realm || ''}` : c.id ? `char:${c.id}` : `session:${s.session}`;
}

function num(v) {
	return typeof v === 'number' && Number.isFinite(v) ? v : null;
}

function median(sorted) {
	if (!sorted.length) return null;
	const m = Math.floor(sorted.length / 2);
	return sorted.length % 2 ? sorted[m] : (sorted[m - 1] + sorted[m]) / 2;
}

function percentile(sorted, p) {
	if (!sorted.length) return null;
	return sorted[Math.min(sorted.length - 1, Math.max(0, Math.ceil(p * sorted.length) - 1))];
}

function sortNum(list) {
	return [...list].sort((a, b) => a - b);
}

function perHour(xp, seconds) {
	return seconds > 0 ? Math.round((xp * 3600) / seconds) : null;
}

// XP needed to finish each level: recorded xpMax wins over the 1.12 table.
function levelTable(sessions) {
	const seen = {};
	for (const s of sessions) {
		for (const ev of s.events || []) {
			if (ev.e === 'step' && Number.isInteger(ev.lvl) && num(ev.xpMax) > 0) seen[ev.lvl] = ev.xpMax;
		}
	}
	const maxOf = (l) => seen[l] || LEVEL_XP[l] || 0;
	const cum = (lvl, xp) => {
		let c = 0;
		for (let l = 1; l < lvl; l++) c += maxOf(l);
		return c + (num(xp) || 0);
	};
	const levelOf = (total) => {
		let l = 1;
		let c = 0;
		while (l < 100 && maxOf(l) > 0 && c + maxOf(l) <= total) {
			c += maxOf(l);
			l++;
		}
		return l + (maxOf(l) > 0 ? (total - c) / maxOf(l) : 0);
	};
	return { cum, levelOf };
}

function mapSize(maps, map) {
	const m = maps && maps[String(map)];
	if (m && [m.left, m.right, m.top, m.bottom].every((v) => typeof v === 'number')) {
		const w = Math.abs(m.right - m.left);
		const h = Math.abs(m.bottom - m.top);
		if (w > 0 && h > 0) return [w, h];
	}
	return [FALLBACK_W, FALLBACK_H];
}

// One session -> ordered items: segments and guide completions.
function sessionItems(s, xpModel) {
	const events = [...(s.events || [])].filter((e) => e && typeof e.e === 'string' && typeof e.t === 'number');
	events.sort((a, b) => a.t - b.t);
	const items = [];
	let cur = null;
	let combat = false;
	let afk = false;
	let lastPos = null;
	const snapCum = (e) => (Number.isInteger(e.lvl) ? xpModel.cum(e.lvl, e.xp) : null);
	const close = (t, endCum) => {
		if (!cur) return;
		cur.end = t;
		cur.endCum = endCum;
		cur = null;
	};
	for (let k = 0; k < events.length; k++) {
		const e = events[k];
		if (k > 0 && cur) {
			const dt = Math.max(0, e.t - events[k - 1].t);
			const d = afk ? 0 : Math.min(dt, IDLE_CAP);
			cur.time += d;
			if (combat) cur.combat += d;
			if (afk) cur.afk += dt;
			else if (dt > IDLE_CAP) cur.idle += dt - IDLE_CAP;
		}
		switch (e.e) {
			case 'step': {
				const c = snapCum(e);
				if (e.reason === 'complete') {
					if (cur && c !== null) cur.obsCum = c;
					items.push({ type: 'complete', guide: e.guide, t: e.t });
					break;
				}
				close(e.t, c);
				combat = e.combat === true;
				cur = {
					type: 'segment', guide: typeof e.guide === 'string' ? e.guide : null, step: Number.isInteger(e.step) ? e.step : null,
					title: e.title || null, guideTitle: e.guideTitle || null, reason: e.reason || null,
					start: e.t, end: e.t, startCum: c, obsCum: c, endCum: null,
					time: 0, combat: 0, afk: 0, idle: 0, yards: 0, deaths: 0, turnins: 0, quests: [],
				};
				items.push(cur);
				break;
			}
			case 'combat':
				combat = e.on === true;
				break;
			case 'afk':
				afk = e.on === true;
				break;
			case 'death':
				if (cur) cur.deaths++;
				break;
			case 'turnin':
				if (cur) {
					cur.turnins++;
					if (Number.isInteger(e.q)) cur.quests.push(e.q);
				}
				break;
			case 'accept':
				if (cur && Number.isInteger(e.lvl) && num(e.xp) !== null) cur.obsCum = xpModel.cum(e.lvl, e.xp);
				break;
			case 'taxi':
				lastPos = null;
				break;
			default:
				break;
		}
		if (typeof e.map === 'number' && num(e.x) !== null && num(e.y) !== null) {
			if (lastPos && lastPos.map === e.map && cur) {
				const [w, h] = mapSize(s.maps, e.map);
				const d = Math.hypot(((e.x - lastPos.x) * w) / 100, ((e.y - lastPos.y) * h) / 100);
				const dt = e.t - lastPos.t;
				if (dt > 0 ? d / dt <= TELEPORT_SPEED : d < TELEPORT_SPEED) cur.yards += d;
			}
			lastPos = { map: e.map, x: e.x, y: e.y, t: e.t };
		}
	}
	if (cur) close(events.length ? events[events.length - 1].t : cur.start, null);
	return items;
}

function newStat(guide, step) {
	return { guide, step, title: null, passes: [], open: 0, revisits: 0, revisitTime: 0, chars: new Set() };
}

function newPass(char) {
	return { char, time: 0, combat: 0, xp: 0, yards: 0, deaths: 0, turnins: 0, idle: 0, afk: 0, segments: 0 };
}

function addTo(target, seg) {
	target.time += seg.time;
	target.combat += seg.combat;
	target.xp += seg.xp;
	target.yards += seg.yards;
	target.deaths += seg.deaths;
	target.turnins += seg.turnins;
	target.idle += seg.idle;
	target.afk += seg.afk;
	target.segments++;
}

function buildReport(sessions, { guide: filter = null, top = 10 } = {}) {
	const xpModel = levelTable(sessions);
	const byChar = new Map();
	for (const s of sessions) {
		const key = charKey(s);
		if (!byChar.has(key)) byChar.set(key, []);
		byChar.get(key).push(s);
	}

	const steps = new Map(); // "guide\0step" -> stat
	const guides = new Map(); // guide -> { id, title, runs: Map(char -> run), steps: Set }
	const statOf = (g, i) => {
		const k = `${g}\u0000${i}`;
		if (!steps.has(k)) steps.set(k, newStat(g, i));
		return steps.get(k);
	};
	const guideOf = (g) => {
		if (!guides.has(g)) guides.set(g, { id: g, title: null, runs: new Map() });
		return guides.get(g);
	};
	let segmentsSeen = 0;
	let unattributed = 0;

	for (const [char, list] of byChar) {
		list.sort((a, b) => (a.started || 0) - (b.started || 0));
		const items = [];
		list.forEach((s, i) => {
			for (const it of sessionItems(s, xpModel)) {
				it.sessionIdx = i;
				items.push(it);
			}
		});
		// XP at each segment's end: the next snapshot (the next segment in this
		// session, or the first of the next session: offline time earns none).
		const segs = items.filter((it) => it.type === 'segment');
		segs.forEach((seg, i) => {
			if (seg.endCum === null) {
				const next = segs[i + 1];
				if (next && next.startCum !== null && (next.sessionIdx === seg.sessionIdx || next.sessionIdx === seg.sessionIdx + 1)) {
					seg.endCum = next.startCum;
				} else {
					seg.endCum = seg.obsCum;
				}
			}
			seg.xp = seg.startCum !== null && seg.endCum !== null ? Math.max(0, seg.endCum - seg.startCum) : 0;
		});

		const front = new Map(); // guide -> { step, pass, stat }
		const finish = (f) => {
			if (f && f.pass) f.stat.passes.push(f.pass);
		};
		for (const it of items) {
			if (it.type === 'complete') {
				if (!it.guide) continue;
				finish(front.get(it.guide));
				front.delete(it.guide);
				const run = guideOf(it.guide).runs.get(char);
				if (run) run.completed = true;
				continue;
			}
			segmentsSeen++;
			if (!it.guide) {
				unattributed += it.time;
				continue;
			}
			const g = guideOf(it.guide);
			if (it.guideTitle && !g.title) g.title = it.guideTitle;
			if (!g.runs.has(char)) {
				g.runs.set(char, { char, time: 0, combat: 0, xp: 0, revisitTime: 0, fromCum: it.startCum, toCum: it.startCum, completed: false });
			}
			const run = g.runs.get(char);
			run.time += it.time;
			run.combat += it.combat;
			run.xp += it.xp;
			if (run.fromCum === null) run.fromCum = it.startCum;
			if (it.endCum !== null) run.toCum = it.endCum;
			if (it.step === null) continue;
			const stat = statOf(it.guide, it.step);
			if (it.title && !stat.title) stat.title = it.title;
			stat.chars.add(char);
			const f = front.get(it.guide);
			if (!f || it.step > f.step) {
				finish(f);
				const pass = newPass(char);
				addTo(pass, it);
				front.set(it.guide, { step: it.step, pass, stat });
			} else if (it.step === f.step) {
				addTo(f.pass, it);
			} else {
				stat.revisits++;
				stat.revisitTime += it.time;
				run.revisitTime += it.time;
			}
		}
		for (const f of front.values()) f.stat.open++;
	}

	// Per-step statistics.
	const stepRows = [...steps.values()].map((st) => {
		const times = sortNum(st.passes.map((p) => p.time));
		const xps = sortNum(st.passes.map((p) => p.xp));
		const yards = sortNum(st.passes.map((p) => p.yards));
		const sum = (k) => st.passes.reduce((a, p) => a + p[k], 0);
		const time = sum('time');
		return {
			guide: st.guide, step: st.step, title: st.title,
			passes: st.passes.length, open: st.open, chars: st.chars.size,
			medianTime: median(times), p75Time: percentile(times, 0.75), totalTime: time,
			xp: sum('xp'), medianXp: median(xps), xpPerHour: perHour(sum('xp'), time),
			combatShare: time > 0 ? sum('combat') / time : null,
			deaths: sum('deaths'), turnins: sum('turnins'),
			medianYards: yards.length ? Math.round(median(yards)) : null,
			revisits: st.revisits, revisitTime: st.revisitTime,
		};
	});
	stepRows.sort((a, b) => (a.guide < b.guide ? -1 : a.guide > b.guide ? 1 : a.step - b.step));

	// Per-guide statistics and baselines.
	const guideRows = [...guides.values()].map((g) => {
		const runs = [...g.runs.values()].map((r) => ({
			char: r.char, time: r.time, xp: r.xp, completed: r.completed, revisitTime: r.revisitTime,
			levelFrom: r.fromCum !== null ? Math.round(xpModel.levelOf(r.fromCum) * 100) / 100 : null,
			levelTo: r.toCum !== null ? Math.round(xpModel.levelOf(r.toCum) * 100) / 100 : null,
			combatShare: r.time > 0 ? r.combat / r.time : null,
		}));
		runs.sort((a, b) => (a.char < b.char ? -1 : 1));
		const done = runs.filter((r) => r.completed);
		const basis = done.length ? done : runs;
		const own = stepRows.filter((r) => r.guide === g.id && r.passes > 0);
		const totalTime = runs.reduce((a, r) => a + r.time, 0);
		const totalXp = runs.reduce((a, r) => a + r.xp, 0);
		const yards = own.reduce((a, r) => a + (r.medianYards || 0) * r.passes, 0);
		const xp = own.reduce((a, r) => a + r.xp, 0);
		return {
			id: g.id, title: g.title, runs, completedRuns: done.length,
			medianTime: median(sortNum(basis.map((r) => r.time))),
			levelsGained: median(sortNum(basis.filter((r) => r.levelFrom !== null && r.levelTo !== null).map((r) => Math.round((r.levelTo - r.levelFrom) * 100) / 100))),
			xpPerHour: perHour(totalXp, totalTime),
			revisitTime: runs.reduce((a, r) => a + r.revisitTime, 0),
			stepBaseline: median(sortNum(own.map((r) => r.medianTime))),
			xpPerYard: yards > 0 ? xp / yards : null,
		};
	});
	guideRows.sort((a, b) => (a.id < b.id ? -1 : 1));

	const wanted = (id, title) => !filter || [id, title].some((v) => typeof v === 'string' && v.toLowerCase().includes(filter.toLowerCase()));
	const shownGuides = guideRows.filter((g) => wanted(g.id, g.title));
	const shownIds = new Set(shownGuides.map((g) => g.id));
	const shownSteps = stepRows.filter((r) => shownIds.has(r.guide));
	const guideById = new Map(guideRows.map((g) => [g.id, g]));

	const slowest = shownSteps
		.filter((r) => r.passes > 0 && r.totalTime >= MIN_STEP_TIME)
		.sort((a, b) => a.xpPerHour - b.xpPerHour || b.medianTime - a.medianTime)
		.slice(0, top)
		.map((r) => ({ guide: r.guide, step: r.step, title: r.title, xpPerHour: r.xpPerHour, medianTime: r.medianTime, passes: r.passes }));

	const overBaseline = shownSteps
		.filter((r) => r.passes > 0)
		.map((r) => {
			const baseline = guideById.get(r.guide).stepBaseline;
			return { guide: r.guide, step: r.step, title: r.title, medianTime: r.medianTime, baseline, baselineKind: 'guide-median', excess: r.medianTime - baseline, ratio: baseline > 0 ? r.medianTime / baseline : null, passes: r.passes };
		})
		.filter((r) => r.ratio !== null && r.ratio >= OVER_RATIO && r.excess >= OVER_EXCESS)
		.sort((a, b) => b.excess - a.excess)
		.slice(0, top);

	const detours = shownSteps
		.filter((r) => r.passes > 0 && r.medianYards !== null && r.medianYards >= DETOUR_YARDS)
		.filter((r) => {
			const ref = guideById.get(r.guide).xpPerYard;
			if (!r.medianXp) return true;
			return ref !== null && r.medianXp / r.medianYards < ref / DETOUR_FACTOR;
		})
		.sort((a, b) => b.medianYards - a.medianYards)
		.slice(0, top)
		.map((r) => ({ guide: r.guide, step: r.step, title: r.title, medianYards: r.medianYards, medianXp: r.medianXp, medianTime: r.medianTime, passes: r.passes }));

	return {
		sessions: sessions.length,
		characters: byChar.size,
		segments: segmentsSeen,
		unattributedTime: unattributed,
		baseline: 'guide-median',
		guides: shownGuides,
		steps: shownSteps,
		slowest,
		overBaseline,
		detours,
	};
}

// ---------------------------------------------------------------------------
// Text output
// ---------------------------------------------------------------------------

function dur(s) {
	if (s === null || s === undefined) return '-';
	s = Math.round(s);
	const h = Math.floor(s / 3600);
	const m = Math.floor((s % 3600) / 60);
	const sec = s % 60;
	if (h) return `${h}h${String(m).padStart(2, '0')}m`;
	if (m) return `${m}m${String(sec).padStart(2, '0')}s`;
	return `${sec}s`;
}

function int(n) {
	return n === null || n === undefined ? '-' : Math.round(n).toLocaleString('en-US');
}

function pct(f) {
	return f === null || f === undefined ? '-' : `${Math.round(f * 100)}%`;
}

function table(rows, columns) {
	const widths = columns.map((c) => Math.max(c.head.length, ...rows.map((r) => String(c.get(r)).length)));
	const line = (cells) => cells.map((v, i) => (columns[i].left ? String(v).padEnd(widths[i]) : String(v).padStart(widths[i]))).join('  ').trimEnd();
	return [line(columns.map((c) => c.head)), ...rows.map((r) => line(columns.map((c) => c.get(r))))].map((l) => `  ${l}`);
}

function stepLabel(r) {
	return `${r.step}${r.title ? ` ${r.title}` : ''}`;
}

function formatReport(report) {
	const out = [];
	out.push(`Route report: ${report.sessions} session(s), ${report.characters} character(s), ${report.guides.length} guide(s)`);
	if (!report.guides.length) {
		out.push('', 'No guide steps recorded. Play with Polestar and Polestar Recorder enabled, then run "forge record import".');
		return `${out.join('\n')}\n`;
	}
	for (const g of report.guides) {
		out.push('', `${g.id}${g.title ? `  ${g.title}` : ''}`);
		out.push(
			`  runs ${g.runs.length} (${g.completedRuns} completed)  time ${dur(g.medianTime)} median${g.completedRuns ? ' (completed runs)' : ''}  levels +${g.levelsGained ?? '-'}  XP/hr ${int(g.xpPerHour)}${g.revisitTime ? `  revisits ${dur(g.revisitTime)}` : ''}`,
		);
		const rows = report.steps.filter((r) => r.guide === g.id);
		out.push(
			...table(rows, [
				{ head: 'step', get: stepLabel, left: true },
				{ head: 'passes', get: (r) => (r.open ? `${r.passes}+${r.open} open` : r.passes) },
				{ head: 'median', get: (r) => dur(r.medianTime) },
				{ head: 'p75', get: (r) => dur(r.p75Time) },
				{ head: 'XP', get: (r) => int(r.medianXp) },
				{ head: 'XP/hr', get: (r) => int(r.xpPerHour) },
				{ head: 'combat', get: (r) => pct(r.combatShare) },
				{ head: 'deaths', get: (r) => r.deaths },
				{ head: 'turnins', get: (r) => r.turnins },
				{ head: 'travel', get: (r) => (r.medianYards === null ? '-' : `${int(r.medianYards)} yd`) },
				{ head: 'revisits', get: (r) => (r.revisits ? `${r.revisits} (${dur(r.revisitTime)})` : '') },
			]),
		);
	}
	const list = (title, rows, columns, empty) => {
		out.push('', title);
		if (!rows.length) out.push(`  ${empty}`);
		else out.push(...table(rows, columns));
	};
	const where = { head: 'guide / step', get: (r) => `${r.guide} #${stepLabel(r)}`, left: true };
	list('Slowest steps by XP/hr', report.slowest, [where, { head: 'XP/hr', get: (r) => int(r.xpPerHour) }, { head: 'median', get: (r) => dur(r.medianTime) }, { head: 'passes', get: (r) => r.passes }], 'none with enough time recorded');
	list(
		'Steps far over the estimate (baseline: the guide\'s median step; the pack exposes no time estimate)',
		report.overBaseline,
		[where, { head: 'median', get: (r) => dur(r.medianTime) }, { head: 'baseline', get: (r) => dur(r.baseline) }, { head: 'over', get: (r) => `+${dur(r.excess)}` }, { head: 'passes', get: (r) => r.passes }],
		'none',
	);
	list(
		'Detours (far travel for little XP)',
		report.detours,
		[where, { head: 'travel', get: (r) => `${int(r.medianYards)} yd` }, { head: 'XP', get: (r) => int(r.medianXp) }, { head: 'median', get: (r) => dur(r.medianTime) }, { head: 'passes', get: (r) => r.passes }],
		'none',
	);
	return `${out.join('\n')}\n`;
}

module.exports = { buildReport, formatReport, IDLE_CAP };
