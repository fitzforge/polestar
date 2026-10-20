'use strict';
// Calibration (docs/SIMULATION.md §4). Two sources, each fitting what it
// can actually inform; only fitted parameter values are kept (params.json).
//
// 1. Quest rewards:
//    - questEstScale: quests.json `xp` (recorded/Questie rewards) against the
//      QuestXP-table estimate the model uses for quests without one;
//    - questXpScale: Forever-observed rewards (ForeverDungeonJournal's
//      FOREVER_QUEST_XP_FALLBACK) against the data reward (recorded or
//      estimated): did Forever retune quest XP?
//    Robust: median of log ratios; sd = 1.4826·MAD/√n, floored at 0.02.
// 2. Recordings (data/recordings): seconds between kills at each level ->
//    killSec1/killSec60 (weighted least squares); dungeon runs (the Recorder's
//    `enter` and `leave`, dungeonRuns) -> dungeonRunLow/dungeonRunHigh and,
//    from parties of 2 or more, premadeFormUp. Without recordings the
//    time parameters keep their priors.
// Every other parameter, extraKill included, keeps its prior (params.js).

const fs = require('node:fs');
const path = require('node:path');
const sim = require('./index');
const { loadParamsFile, saveParamsFile, effective, PRIORS } = require('./params');
const { table } = require('./report');
const { findInstalledAddon } = require('../addons');
const { FOLDER: FDJ_FOLDER } = require('../data/dungeonjournal');

// `[id] = xp` pairs inside FDJ.FOREVER_QUEST_XP_FALLBACK = { ... }.
function parseForeverXp(text) {
	const m = /FOREVER_QUEST_XP_FALLBACK\s*=\s*\{([\s\S]*?)\n\}/.exec(text);
	const out = new Map();
	if (!m) return out;
	const re = /\[(\d+)\]\s*=\s*(\d+)/g;
	let r;
	while ((r = re.exec(m[1]))) out.set(Number(r[1]), Number(r[2]));
	return out;
}

// The installed ForeverDungeonJournal folder (null when not found).
function fdjDir(explicit) {
	if (explicit) return path.resolve(explicit);
	return findInstalledAddon(FDJ_FOLDER);
}

function loadForeverXp(dir) {
	if (!dir) return { file: null, xp: new Map() };
	const file = path.join(dir, 'Data', 'QuestRewards.lua');
	if (!fs.existsSync(file)) return { file, xp: new Map() };
	return { file, xp: parseForeverXp(fs.readFileSync(file, 'utf8')) };
}

function median(a) {
	const s = a.slice().sort((x, y) => x - y);
	const n = s.length;
	return n ? (n % 2 ? s[(n - 1) / 2] : (s[n / 2 - 1] + s[n / 2]) / 2) : NaN;
}

// Robust location/scale of log ratios -> { n, mean (ratio), sd (ratio units) }.
function ratioFit(ratios) {
	const logs = ratios.filter((r) => r > 0 && Number.isFinite(r)).map(Math.log);
	if (logs.length < 3) return null;
	const med = median(logs);
	const mad = median(logs.map((x) => Math.abs(x - med)));
	const spread = 1.4826 * mad;
	return { n: logs.length, mean: Math.exp(med), sd: Math.max(0.02, (Math.exp(med) * spread) / Math.sqrt(logs.length)), spread };
}

function tableEstimate(rows, q) {
	const row = rows[Math.max(1, Math.min(rows.length - 1, q.level))] || rows[60];
	return row[q.tier] || 0;
}

// Quest reward fits from the worlds (both factions' quests, deduplicated).
function questXpFits(worlds, foreverXp) {
	const seen = new Map();
	for (const w of worlds) for (const q of w.quests) if (!seen.has(q.id)) seen.set(q.id, q);
	const rows = worlds[0].questXp;
	const est = [];
	for (const q of seen.values()) if (q.xp > 0) est.push(q.xp / tableEstimate(rows, q));
	const estFit = ratioFit(est);
	const estScale = estFit ? estFit.mean : 1;
	const fv = [];
	const fvRows = [];
	for (const [id, xp] of foreverXp) {
		const q = seen.get(id);
		if (!q) continue;
		const base = q.xp > 0 ? q.xp : tableEstimate(rows, q) * estScale;
		if (base > 0) {
			fv.push(xp / base);
			fvRows.push({ id, title: q.title, level: q.level, forever: xp, data: Math.round(base), recorded: q.xp > 0 });
		}
	}
	return { est: estFit, forever: ratioFit(fv), foreverRows: fvRows, foreverTotal: foreverXp.size };
}

// Recordings: kill cadence per level.
function recordingFits(recDir) {
	if (!fs.existsSync(recDir)) return { sessions: 0 };
	const files = fs.readdirSync(recDir).filter((f) => f.endsWith('.json'));
	const byLevel = new Map();
	const runs = [];
	let sessions = 0;
	for (const f of files) {
		let doc;
		try {
			doc = JSON.parse(fs.readFileSync(path.join(recDir, f), 'utf8'));
		} catch {
			continue;
		}
		if (!doc || !Array.isArray(doc.events)) continue;
		sessions++;
		runs.push(...dungeonRuns(doc.events));
		let lvl = null;
		let lastKill = null;
		for (const e of doc.events) {
			if (e.lvl) lvl = e.lvl;
			if (e.e === 'level') lvl = e.lvl;
			if (e.e === 'kill' && lvl) {
				if (lastKill != null && e.t - lastKill > 2 && e.t - lastKill <= 180) {
					if (!byLevel.has(lvl)) byLevel.set(lvl, []);
					byLevel.get(lvl).push(e.t - lastKill);
				}
				lastKill = e.t;
			}
		}
	}
	const pts = [...byLevel].filter(([, g]) => g.length >= 10).map(([l, g]) => [l, median(g), g.length]);
	const dungeons = dungeonRunFits(runs);
	if (pts.length < 2) return { sessions, levels: pts.length, dungeons };
	// Weighted least squares sec = a + b (L - 1).
	let sw = 0;
	let sx = 0;
	let sy = 0;
	let sxx = 0;
	let sxy = 0;
	for (const [l, s, n] of pts) {
		const x = l - 1;
		sw += n;
		sx += n * x;
		sy += n * s;
		sxx += n * x * x;
		sxy += n * x * s;
	}
	const b = (sw * sxy - sx * sy) / (sw * sxx - sx * sx);
	const a = (sy - b * sx) / sw;
	return { sessions, levels: pts.length, killSec1: a, killSec60: a + 59 * b, points: pts, dungeons };
}

// A dungeon run: from entering a dungeon (instType "party") to leaving it
// for good. A leave and an enter into the same dungeon within RUN_GAP (a
// corpse run, a hearth to sell) are one run; a run with no leave (a logout
// inside), or longer than RUN_MAX, tells nothing. Form-up: from the last
// quest event outside to the first enter, for a party of 2 or more (walking
// to the portal together), when under FORMUP_MAX.
const RUN_GAP = 15 * 60;
const RUN_MAX = 4 * 3600;
const FORMUP_MAX = 45 * 60;
const QUEST_EVENTS = new Set(['accept', 'turnin', 'progress']);

// -> [{ inst, minutes, lvl, party, formUp (minutes) | null }]
function dungeonRuns(events) {
	const runs = [];
	let run = null;
	let lastQuest = null;
	let lvl = null;
	const close = () => {
		if (run && run.left != null && run.left - run.start <= RUN_MAX) {
			runs.push({ inst: run.inst, minutes: (run.left - run.start) / 60, lvl: run.lvl, party: run.party, formUp: run.formUp });
		}
		run = null;
	};
	for (const e of events) {
		if (typeof e.t !== 'number') continue;
		if (e.lvl) lvl = e.lvl;
		if (run && run.left != null && e.t - run.left > RUN_GAP) close();
		if (QUEST_EVENTS.has(e.e) && !run) lastQuest = e.t;
		if (e.e === 'enter' && e.instType === 'party') {
			if (run && run.inst === e.inst && run.left != null) {
				run.left = null;
				run.party = Math.max(run.party, e.party || 1);
				continue;
			}
			close();
			const party = e.party || 1;
			const formUp = party >= 2 && lastQuest != null && e.t - lastQuest <= FORMUP_MAX ? (e.t - lastQuest) / 60 : null;
			run = { inst: e.inst, start: e.t, left: null, lvl: e.lvl || lvl, party, formUp };
		} else if (e.e === 'leave' && run && e.inst === run.inst) {
			run.left = e.t;
		} else if (e.e === 'enter' && run) {
			close();
		}
	}
	close();
	return runs;
}

// The clear-time model of evaluate.js (the dungeon's middle level, here the
// character's level at the run): dungeonRunLow at 15 to dungeonRunHigh at
// 55. Runs -> { runs, low, high } by least squares when the levels spread
// over at least 10, else both priors scaled by the median ratio; and
// premadeFormUp, the median form-up, from 3 runs with one.
function dungeonRunFits(runs) {
	const out = { runs: runs.length };
	const pts = runs.filter((r) => r.lvl).map((r) => [Math.max(0, Math.min(1, (r.lvl - 15) / 40)), r.minutes]);
	if (pts.length) {
		const xs = pts.map(([x]) => x);
		if (pts.length >= 3 && Math.max(...xs) - Math.min(...xs) >= 0.25) {
			const n = pts.length;
			const sx = xs.reduce((a, b) => a + b, 0);
			const sy = pts.reduce((a, [, y]) => a + y, 0);
			const sxx = pts.reduce((a, [x]) => a + x * x, 0);
			const sxy = pts.reduce((a, [x, y]) => a + x * y, 0);
			const b = (n * sxy - sx * sy) / (n * sxx - sx * sx);
			const a = (sy - b * sx) / n;
			out.low = a;
			out.high = a + b;
		} else {
			const prior = (x) => PRIORS.dungeonRunLow[0] + (PRIORS.dungeonRunHigh[0] - PRIORS.dungeonRunLow[0]) * x;
			const k = median(pts.map(([x, y]) => y / prior(x)));
			out.low = PRIORS.dungeonRunLow[0] * k;
			out.high = PRIORS.dungeonRunHigh[0] * k;
		}
	}
	const forms = runs.map((r) => r.formUp).filter((m) => m != null);
	if (forms.length >= 3) out.formUp = median(forms);
	return out;
}

async function calibrate(o) {
	const doc = loadParamsFile(o.simDir);
	doc.calibrated = {};
	const worlds = {};
	for (const f of ['Horde', 'Alliance']) worlds[f] = (await sim.loadWorld({ ...o, faction: f })).world;
	const fit = { at: new Date().toISOString(), sources: {} };

	// 1. Quest rewards.
	const fx = loadForeverXp(o.fdjDir);
	const qx = questXpFits(Object.values(worlds), fx.xp);
	fit.sources.questXp = { questsJsonXp: qx.est ? qx.est.n : 0, forever: { file: fx.file, values: qx.foreverTotal, matched: qx.foreverRows.length } };
	if (qx.est) doc.calibrated.questEstScale = { mean: qx.est.mean, sd: Math.max(qx.est.sd, 0.03) };
	if (qx.forever) doc.calibrated.questXpScale = { mean: qx.forever.mean, sd: Math.max(qx.forever.sd, 0.03) };
	fit.questXp = { est: qx.est, forever: qx.forever };

	// 2. Recordings.
	const rec = recordingFits(path.join(path.dirname(o.simDir), 'recordings'));
	fit.sources.recordings = { sessions: rec.sessions, levels: rec.levels || 0, dungeonRuns: rec.dungeons ? rec.dungeons.runs : 0 };
	if (rec.killSec1 != null && rec.killSec60 != null && rec.killSec1 > 0 && rec.killSec60 > 0) {
		doc.calibrated.killSec1 = { mean: rec.killSec1, sd: PRIORS.killSec1[1] / 2 };
		doc.calibrated.killSec60 = { mean: rec.killSec60, sd: PRIORS.killSec60[1] / 2 };
	}
	// Dungeon runs: few, so the sd stays at half the prior's (a quarter from 10 runs).
	const dr = rec.dungeons;
	if (dr && dr.low != null && dr.low > 0 && dr.high > 0) {
		const k = dr.runs >= 10 ? 4 : 2;
		doc.calibrated.dungeonRunLow = { mean: dr.low, sd: PRIORS.dungeonRunLow[1] / k };
		doc.calibrated.dungeonRunHigh = { mean: dr.high, sd: PRIORS.dungeonRunHigh[1] / k };
	}
	if (dr && dr.formUp != null) doc.calibrated.premadeFormUp = { mean: dr.formUp, sd: PRIORS.premadeFormUp[1] / 2 };

	doc.fit = fit;
	saveParamsFile(o.simDir, doc);
	return { doc, fit, qx };
}

async function command(args, o) {
	const opts = { ...sim.DEFAULTS, ...o, fdjDir: fdjDir(args.fdj) };
	const { doc, fit, qx } = await calibrate(opts);
	const eff = effective(doc, null);
	console.log('Calibrated parameters (prior -> calibrated):');
	console.log(table(['parameter', 'prior mean', 'prior sd', 'calibrated mean', 'calibrated sd', 'source'], Object.entries(doc.calibrated).map(([k, c]) => [
		k, PRIORS[k][0], PRIORS[k][1], c.mean.toFixed(3), c.sd.toFixed(3),
		k === 'questEstScale' ? `quests.json xp (${qx.est.n} quests)` : k === 'questXpScale' ? `Forever observed (${qx.forever.n} quests)` : 'recordings',
	])));
	console.log(`\nquests.json rewards vs QuestXP table: ${qx.est ? `n ${qx.est.n}, median ratio ${qx.est.mean.toFixed(3)}, spread ×${Math.exp(qx.est.spread).toFixed(2)}` : 'no recorded XP'}`);
	console.log(`Forever observed vs data rewards: ${qx.forever ? `n ${qx.forever.n} of ${qx.foreverTotal}, median ratio ${qx.forever.mean.toFixed(3)}, spread ×${Math.exp(qx.forever.spread).toFixed(2)}` : 'none matched'}`);
	console.log(`recordings: ${fit.sources.recordings.sessions} sessions${fit.sources.recordings.sessions ? `, ${fit.sources.recordings.dungeonRuns} dungeon runs` : ' (time parameters keep their priors)'}`);
	console.log(`effective means: ${Object.entries(eff).map(([k, v]) => `${k} ${+v.mean.toFixed(3)}`).join(', ')}`);
	console.log(`wrote ${path.relative(process.cwd(), path.join(opts.simDir, 'params.json'))}`);
	return 0;
}

module.exports = { calibrate, command, parseForeverXp, ratioFit, recordingFits, questXpFits, dungeonRuns, dungeonRunFits };
