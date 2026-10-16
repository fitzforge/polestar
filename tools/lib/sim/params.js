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
	greyWeight: [1, 0, 0, 4, 'policy, completionist routes only: XP a quest loses by being turned in above its level (all of it at 60) counts as the time to earn it by grinding at the quest\'s level, times this, so the route does quests before they go grey unless a late cleanup pass is clearly cheaper (reported times stay real)'],
	missWeight: [7200, 0, 7200, 7200, 'policy, completionist routes only: seconds each quest of the eligible set left undone counts, far above any quest\'s time, so the route never trades quests for time'],
	returnWeight: [3600, 0, 3600, 3600, 'policy, completionist routes only: seconds each return to a zone package already run counts, so a zone visit does every quest it can in one go (arriving a little later if need be) and a zone is left with work only when coming back clearly pays (reported times stay real)'],
	gateGap: [2, 0, 2, 2, 'levels a character grinds to reach a quest\'s minimum level; further above, the quest is not available yet'],
	dangerGap: [5, 0, 5, 5, 'most levels a quest may be above the character (red quests are not attempted)'],
	deathRisk: [300, 150, 0, 1200, 'seconds lost per walking crossing of a zone whose mobs are 5+ levels above the character (deaths, corpse runs, detours)'],
	dungeonRunLow: [35, 10, 15, 75, 'minutes per dungeon clear at dungeon level 15 (5-player group)'],
	dungeonRunHigh: [60, 15, 25, 120, 'minutes per dungeon clear at dungeon level 55'],
	dungeonFormUp: [15, 8, 2, 45, 'minutes to form a group and reach the instance portal'],
	dungeonTrash: [70, 20, 25, 150, 'elite trash kills per clear (DungeonJournal has no trash counts)'],
	partyShare: [0.28, 0, 0.28, 0.28, 'share of solo kill XP each of 5 party members gets (Classic: 1.4 / 5)'],
	restedShare: [0, 0, 0, 1, 'share of kill XP doubled by rested XP (optional)'],
};

// Kill-speed priors by class (a multiplier on kill time; lower is faster).
const CLASS_FACTOR = {
	Warrior: 1.15, Paladin: 1.1, Hunter: 0.8, Rogue: 1.0, Priest: 1.05,
	Shaman: 1.0, Mage: 0.9, Warlock: 0.85, Druid: 1.0,
};

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

// Priors with calibration applied and the class prior: { name: { mean, sd, lo, hi } }.
function effective(doc, cls = null) {
	const out = {};
	const cal = (doc && doc.calibrated) || {};
	for (const [k, [mean, sd, lo, hi]] of Object.entries(PRIORS)) {
		const c = cal[k];
		out[k] = { mean: c && Number.isFinite(c.mean) ? c.mean : mean, sd: c && Number.isFinite(c.sd) ? c.sd : sd, lo, hi };
	}
	if (cls && CLASS_FACTOR[cls] != null) out.classFactor = { ...out.classFactor, mean: CLASS_FACTOR[cls] };
	return out;
}

function means(eff) {
	const p = {};
	for (const k of NAMES) p[k] = eff[k].mean;
	return p;
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
	PRIORS, NAMES, CLASS_FACTOR, priorTable, paramsFile, loadParamsFile, saveParamsFile, effective, means, sample, draws,
};
