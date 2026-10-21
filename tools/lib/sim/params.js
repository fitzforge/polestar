'use strict';
// Model parameters (docs/SIMULATION.md §2): every one has a prior (mean,
// spread, bounds). data/sim/params.json keeps the priors and, after `sim
// calibrate`, the calibrated mean/sd of the fitted ones; `effective()` merges
// the two. Robustness draws sample each parameter from a normal around its
// mean, truncated to its bounds; sd 0 = fixed.

const fs = require('node:fs');
const path = require('node:path');
const { Rng } = require('./rng');

// name: [mean, sd, lo, hi, description]
const PRIORS = {
	runSpeed: [7, 0.15, 6.5, 7.5, 'run speed, yd/s'],
	mountLevel: [40, 0, 40, 40, 'level the mount is bought'],
	mountMul: [1.6, 0, 1.6, 1.6, 'mounted speed multiplier'],
	detour0: [1.35, 0.12, 1.05, 2, 'walking detour factor, Eastern Kingdoms (path / straight line)'],
	detour1: [1.3, 0.12, 1.05, 2, 'walking detour factor, Kalimdor'],
	routeMul: [1, 0.05, 0.9, 1.3, 'routed walk (sim walks) / the walking router\'s yards: a player strays a little from the drawn line'],
	killSec1: [11, 3, 6, 30, 'seconds per kill incl. downtime at level 1 (equal-level mob)'],
	killSec60: [30, 6, 15, 60, 'seconds per kill incl. downtime at level 60'],
	killUp: [0.1, 0.04, 0, 0.3, 'kill time +share per mob level above the player'],
	killDown: [0.05, 0.02, 0, 0.12, 'kill time -share per mob level below the player (floor 0.5)'],
	eliteTime: [3.5, 1, 1.5, 8, 'kill time multiplier for elites'],
	classFactor: [1, 0.1, 0.6, 1.6, 'kill time multiplier of the class'],
	spacing: [1, 0.25, 0.4, 2.5, 'multiplier on the walk between mobs from spawn density'],
	talkSec: [6, 2, 2, 15, 'seconds per accept or turn-in'],
	interactSec: [8, 3, 2, 25, 'seconds per object use'],
	escortSec: [240, 90, 60, 600, 'seconds per escort/event objective'],
	dropMul: [1, 0.2, 0.5, 2, 'real drop rate / data drop rate'],
	extraKill: [0.043, 0.038, 0, 0.8, 'incidental kills per objective kill (mobs in the way; fixed, fitted 2026-10-12 against level checkpoints)'],
	questXpScale: [1, 0.1, 0.5, 1.5, 'Forever quest XP / data quest XP (all rewards)'],
	questEstScale: [1, 0.12, 0.5, 1.6, 'real reward / QuestXP-table estimate (quests without recorded XP)'],
	flightOverhead: [20, 8, 5, 60, 'seconds per flight: talk, take-off, landing'],
	transportWait: [1, 0.3, 0.3, 2, 'multiplier on boat/zeppelin/tram average waits'],
	hearthCast: [10, 0, 10, 10, 'hearthstone cast, seconds'],
	hearthCooldown: [3600, 0, 1800, 3600, 'hearthstone cooldown, seconds'],
	levelOverhead: [60, 40, 0, 300, 'seconds per level-up: training, vendoring, repairs'],
	grindEff: [0.7, 0.12, 0.35, 1.1, 'grinding XP rate / formula rate at the best site (respawns, competition, bag trips)'],
	grindWeight: [2.5, 0, 2.5, 2.5, 'policy, not a measurement: an hour of grinding counts as this many hours when routes are compared, so a route grinds only where no quest is nearly as good (reported times stay real)'],
	zoneChange: [450, 0, 450, 450, 'policy, not a measurement: seconds a move into another zone counts when routes are compared, so a route takes a hub\'s quests and does them in one go and switches zones only when it is clearly worth it (reported times stay real)'],
	zoneReturn: [0, 0, 0, 0, 'policy, not a measurement: seconds a move back into a zone the route was in earlier (and left) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	spotReturn: [0, 0, 0, 0, 'policy, not a measurement: seconds work again at a spot (250 yd cell) worked earlier, after leaving it by more than 600 yd, counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	wastedAccept: [0, 0, 0, 0, 'policy, not a measurement: seconds each quest accepted and never handed in (abandoned for a full log, or still in the log at 60) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	gateGap: [2, 0, 2, 2, 'levels a character grinds to reach a quest\'s minimum level; further above, the quest is not available yet'],
	dangerGap: [5, 0, 5, 5, 'most levels a quest may be above the character (red quests are not attempted)'],
	deathRisk: [300, 150, 0, 1200, 'seconds lost per walking crossing of a zone whose mobs are 5+ levels above the character (deaths, corpse runs, detours)'],
	dungeonRunLow: [35, 10, 15, 75, 'minutes per dungeon clear at dungeon level 15 (5-player group)'],
	dungeonRunHigh: [60, 15, 25, 120, 'minutes per dungeon clear at dungeon level 55'],
	dungeonFormUp: [15, 8, 2, 45, 'minutes to form a group and reach the instance portal'],
	dungeonTrash: [70, 20, 25, 150, 'elite trash kills per clear (DungeonJournal has no trash counts)'],
	dungeonMobXp: [0.6, 0.2, 0.2, 1, 'share of Classic\'s XP a dungeon mob gives in Forever (cut sharply in the beta, then raised about 20% on 8 Oct 2026; no figure published)'],
	partyShare: [0.28, 0, 0.28, 0.28, 'share of solo kill XP each of 5 party members gets (Classic: 1.4 / 5)'],
	// A party levelling together (`sim run --party N`, docs/SIMULATION.md "Party").
	partySize: [1, 0, 1, 5, 'players levelling together, all doing the route (set by --party; 1 = solo)'],
	partyDps: [0.8, 0.12, 0.4, 1, 'kill speed each party member past the first adds, as a share of one player\'s (overkill, tagging, pulling)'],
	partyDrops: [0.5, 0.3, 0, 1, 'share of a quest\'s objective drops each member loots for themselves from a kill (1: every member gets one per kill, 0: one per kill for the party)'],
	// Dungeon gear (docs/SIMULATION.md, "Dungeon gear"): from Polestar's gear
	// scores of boss loot against quest rewards; wide, as loot coverage is low.
	dungeonGear: [0.05, 0.04, 0, 0.2, 'share of kill time a dungeon run\'s gear (boss loot, quest rewards) takes off'],
	gearLife: [3, 2, 1, 7, 'levels past the dungeon\'s top level until questing\'s rewards catch up with its gear'],
	premadeFormUp: [5, 3, 1, 20, 'minutes a premade party needs to reach a dungeon portal together (no group finding)'],
	restedShare: [0, 0, 0, 1, 'share of kill XP doubled by rested XP (optional)'],
};

// Kill-speed priors by class (a multiplier on kill time; lower is faster).
const CLASS_FACTOR = {
	Warrior: 1.15, Paladin: 1.1, Hunter: 0.8, Rogue: 1.0, Priest: 1.05,
	Shaman: 1.0, Mage: 0.9, Warlock: 0.85, Druid: 1.0,
};

// What the search optimises (`sim run --objective`): overrides of the policy
// parameters above (mean = lo = hi). time: the fastest route to 60 as the
// priors have it. smooth: fewer zone switches, returns into zones left
// earlier and returns to spots already worked, at some cost in time.
// smooth also counts grinding more (4 instead of 2.5): grinding never moves,
// so with the return penalties alone the search ground instead of questing
// (Horde Orc, 200k routes: 52 h of grinding against 9 h under time, 131 h
// to 60; at 4, 29 h and 127 h, with a third of the zone returns). smooth
// also counts each quest accepted and never handed in (abandoned for a full
// log or left in it at 60): taking a quest only to drop it is not smooth
// (Horde Orc, 100k routes with walks: 42 abandoned, 63 never handed in).
const OBJECTIVES = {
	time: {},
	smooth: { zoneChange: 900, zoneReturn: 1800, spotReturn: 900, grindWeight: 4, wastedAccept: 600 },
};

function objectiveName(o) {
	const k = o == null || o === '' ? 'time' : String(o).toLowerCase();
	if (!OBJECTIVES[k]) throw new Error(`--objective must be ${Object.keys(OBJECTIVES).join(' or ')} (got ${o})`);
	return k;
}

// `--param key=value` (repeatable) -> { key: number }; unknown keys and
// non-numbers are errors.
function parseOverrides(list) {
	const out = {};
	for (const s of [].concat(list || [])) {
		const m = /^([A-Za-z0-9]+)=(.+)$/.exec(String(s));
		if (!m) throw new Error(`--param must be key=value (got ${s})`);
		if (!PRIORS[m[1]]) throw new Error(`--param: unknown parameter ${m[1]} (known: ${Object.keys(PRIORS).join(', ')})`);
		const v = Number(m[2]);
		if (!Number.isFinite(v)) throw new Error(`--param ${m[1]}: ${m[2]} is not a number`);
		out[m[1]] = v;
	}
	return out;
}

// `--tag <name>`: a suffix for result file names (variants of one search).
function tagName(t) {
	if (t == null || t === '') return null;
	if (!/^[A-Za-z0-9_-]+$/.test(String(t))) throw new Error(`--tag must be letters, digits, - or _ (got ${t})`);
	return String(t);
}

const NAMES = Object.keys(PRIORS);

function priorTable() {
	const out = {};
	for (const [k, [mean, sd, lo, hi, desc]] of Object.entries(PRIORS)) out[k] = { mean, sd, lo, hi, desc };
	return out;
}

function paramsFile(simDir) {
	return path.join(simDir, 'params.json');
}

// data/sim/params.json: { schema, priors, calibrated: { name: { mean, sd } }, fit }
function loadParamsFile(simDir) {
	const file = paramsFile(simDir);
	if (!fs.existsSync(file)) return { schema: 1, priors: priorTable(), calibrated: {}, fit: null };
	const doc = JSON.parse(fs.readFileSync(file, 'utf8'));
	return { schema: 1, priors: priorTable(), calibrated: doc.calibrated || {}, fit: doc.fit || null };
}

function saveParamsFile(simDir, doc) {
	fs.mkdirSync(simDir, { recursive: true });
	const file = paramsFile(simDir);
	const out = { schema: 1, priors: priorTable(), calibrated: doc.calibrated || {}, fit: doc.fit || null };
	fs.writeFileSync(`${file}.tmp`, `${JSON.stringify(out, null, '\t')}\n`);
	fs.renameSync(`${file}.tmp`, file);
}

// Priors with calibration applied, the class prior, the objective's policy
// overrides and then `--param` overrides (each fixed: mean = lo = hi, sd 0):
// { name: { mean, sd, lo, hi } }.
function effective(doc, cls = null, objective = 'time', overrides = {}) {
	const out = {};
	const cal = (doc && doc.calibrated) || {};
	for (const [k, [mean, sd, lo, hi]] of Object.entries(PRIORS)) {
		const c = cal[k];
		out[k] = { mean: c && Number.isFinite(c.mean) ? c.mean : mean, sd: c && Number.isFinite(c.sd) ? c.sd : sd, lo, hi };
	}
	if (cls && CLASS_FACTOR[cls] != null) out.classFactor = { ...out.classFactor, mean: CLASS_FACTOR[cls] };
	for (const [k, v] of Object.entries(OBJECTIVES[objectiveName(objective)])) out[k] = { mean: v, sd: 0, lo: v, hi: v };
	for (const [k, v] of Object.entries(overrides || {})) {
		if (!out[k]) throw new Error(`unknown parameter ${k}`);
		out[k] = { mean: v, sd: 0, lo: v, hi: v };
	}
	return out;
}

function means(eff) {
	const p = {};
	for (const k of NAMES) p[k] = eff[k].mean;
	return p;
}

// p with every parameter it lacks at its prior's mean: a result saved before
// a parameter was added still evaluates (a missing one would be NaN).
function complete(p) {
	let out = p;
	for (const k of NAMES) {
		if (p[k] != null) continue;
		if (out === p) out = { ...p };
		out[k] = PRIORS[k][0];
	}
	return out;
}

// One draw from the (calibrated) priors.
function sample(eff, rng) {
	const p = {};
	for (const k of NAMES) {
		const { mean, sd, lo, hi } = eff[k];
		let v = sd > 0 ? mean + sd * rng.normal() : mean;
		if (v < lo) v = lo;
		if (v > hi) v = hi;
		p[k] = v;
	}
	return p;
}

function draws(eff, k, seed) {
	const rng = new Rng(seed);
	const out = [];
	for (let i = 0; i < k; i++) out.push(sample(eff, rng));
	return out;
}

module.exports = {
	PRIORS, NAMES, CLASS_FACTOR, OBJECTIVES, objectiveName, parseOverrides, tagName, priorTable, paramsFile, loadParamsFile, saveParamsFile, effective, means, complete, sample, draws,
};
