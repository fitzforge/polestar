'use strict';
// Model parameters (docs/legacy/SIMULATION-js.md §2): every one has a prior (mean,
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
	groupSize: [3, 0, 2, 5, 'v2: players in the party an elite quest is done with (Fitz 2026-10-20: elite quests in, grouping advised), an estimate: an elite kill takes eliteTime solo kills split over them'],
	groupShare: [0.389, 0, 0.389, 0.389, 'v2: share of an elite kill\'s (double) XP each member of that party gets (Classic: a 3-player party\'s 1.166 bonus / 3)'],
	groupWait: [600, 300, 120, 1800, 'v2: seconds to find a group, once per elite camp worked (a chain at one camp waits once), an estimate'],
	classFactor: [1, 0.1, 0.6, 1.6, 'kill time multiplier of the class'],
	spacing: [1, 0.25, 0.4, 2.5, 'multiplier on the walk between mobs from spawn density'],
	talkSec: [6, 2, 2, 15, 'seconds per accept or turn-in'],
	interactSec: [8, 3, 2, 25, 'seconds per object use'],
	escortSec: [240, 90, 60, 600, 'seconds per event objective that is no escort (a defend event, an exploration); an escort without a known path or end (v1: every escort/event)'],
	escortFail: [0.15, 0.08, 0, 0.5, 'v2: chance an escort fails once (the NPC dies to its ambush, the player strays), an estimate (QuestMechanics: "fails easily")'],
	escortBusy: [0.1, 0.08, 0, 0.5, 'v2: chance an escort NPC is away on another player\'s escort when the character arrives, an estimate (QuestMechanics: "the NPC is often taken")'],
	escortRespawn: [180, 90, 30, 600, 'v2: seconds an escort NPC takes to come back after a failed or another player\'s run, an estimate'],
	dropMul: [1, 0.2, 0.5, 2, 'real drop rate / data drop rate'],
	extraKill: [0.043, 0.038, 0, 0.8, 'incidental kills per objective kill (mobs in the way; fixed, fitted 2026-10-12 against level checkpoints)'],
	questXpScale: [1, 0.1, 0.5, 1.5, 'Forever quest XP / data quest XP (all rewards)'],
	questEstScale: [1, 0.12, 0.5, 1.6, 'real reward / QuestXP-table estimate (quests without recorded XP)'],
	flightOverhead: [20, 8, 5, 60, 'seconds per flight: talk, take-off, landing'],
	transportWait: [1, 0.3, 0.3, 2, 'multiplier on boat/zeppelin/tram average waits'],
	hearthCast: [10, 0, 10, 10, 'hearthstone cast, seconds'],
	hearthCooldown: [3600, 0, 1800, 3600, 'hearthstone cooldown, seconds'],
	deathskipSec: [60, 20, 30, 120, 'deathskip (die on purpose, release, Spirit Healer), seconds: an estimate, ~30 s pulling mobs to die to plus the healer\'s ~30 s (v2 travel2.js SPIRIT_HEAL_SEC)'],
	deathskipLevel: [60, 0, 0, 60, 'policy: highest level a route deathskips at (CapAudit #5: any level; above 10 resurrection sickness is priced as slower kills, sicknessSlow; was 10, Forever\'s last level without sickness)'],
	sicknessSlow: [0.5, 0.2, 0.2, 1, 'v2: share of each second of resurrection sickness spent working that is lost to slower kills (the debuff cuts stats; walking, flights and talks lose nothing), an estimate'],
	levelOverhead: [60, 40, 0, 300, 'seconds per level-up: training, vendoring, repairs'],
	grindEff: [0.7, 0.12, 0.35, 1.1, 'grinding XP rate / formula rate at the best site (respawns, competition, bag trips)'],
	grindWeight: [2.5, 0, 2.5, 2.5, 'policy, not a measurement: an hour of grinding counts as this many hours when routes are compared, so a route grinds only where no quest is nearly as good (reported times stay real)'],
	escortWeight: [2.5, 0, 2.5, 2.5, 'policy, not a measurement: a second of an escort counts as this many when the accept rule prices it, as grinding\'s do (grindWeight), so an escort is taken when its XP beats grinding outright or it opens a chain that does: players skip escorts (the wait for the NPC, its pace, a failed run; reported times stay real)'],
	zoneChange: [450, 0, 450, 450, 'policy, not a measurement: seconds a move into another zone counts when routes are compared, so a route takes a hub\'s quests and does them in one go and switches zones only when it is clearly worth it (reported times stay real)'],
	zoneReturn: [0, 0, 0, 0, 'policy, not a measurement: seconds a move back into a zone the route was in earlier (and left) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	spotReturn: [0, 0, 0, 0, 'policy, not a measurement: seconds work again at a spot (250 yd cell) worked earlier, after leaving it by more than 600 yd, counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	wastedAccept: [0, 0, 0, 0, 'policy, not a measurement: seconds each quest accepted and never handed in (abandoned for a full log, or still in the log at 60) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	stepCost: [0, 0, 0, 600, 'policy: per-area-visit cost (seconds); 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	// v2 search (M3 objective, v2/search.js): the route audit's findings
	// (v2/audit.js, by check) and the smooth pass's soft time bound.
	deadLeg: [0, 0, 0, 0, 'v2 policy, not a measurement: seconds each dead leg (an arrival where nothing happens; route audit check 6) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	hubSplit: [0, 0, 0, 0, 'v2 policy, not a measurement: seconds each hub split (a hub\'s quests accepted on a later trip; route audit check 5) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	missedAccept: [0, 0, 0, 0, 'v2 policy, not a measurement: seconds each missed accept (a quest the walk passed and the sim would take, not taken then; route audit check 1) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	missedTurnin: [0, 0, 0, 0, 'v2 policy, not a measurement: seconds each missed turn-in (route audit check 2) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	avoidableReturn: [0, 0, 0, 0, 'v2 policy, not a measurement: seconds each avoidable return (back in a zone for work its first visit passed; route audit check 4) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	xpLoss: [0, 0, 0, 0, 'v2 policy, not a measurement: weight on the seconds the XP lost to late turn-ins (the character 6+ levels over the quest) takes at the route\'s average rate, when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	overrunWeight: [0, 0, 0, 0, 'v2 policy, not a measurement: the smooth pass\'s soft time bound (spec §4): a route over (1 + ε) × the fastest route\'s time counts this × the overrun² (seconds) more; 0 in the time objective, see OBJECTIVES'],
	territory: [0, 0, 0, 0, 'v2 policy, not a measurement: each second walked or worked in the other faction\'s territory (v2/territory.js: an AreaTable faction zone weighs 1, a contested zone leaning to it 0.4) counts this many times more when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)'],
	territoryPvp: [1, 0, 1, 1, 'v2 policy: multiplier on territory for the realm (1: normal; a PvP realm\'s heavier weight is a later option)'],
	gateGap: [2, 0, 2, 2, 'levels a character grinds to reach a quest\'s minimum level; further above, the quest is not available yet'],
	dangerGap: [5, 0, 5, 5, 'most levels a quest may be above the character (red quests are not attempted)'],
	deathRisk: [300, 150, 0, 1200, 'seconds lost per walking crossing of a zone whose mobs are 5+ levels above the character (deaths, corpse runs, detours)'],
	dungeonRunLow: [35, 10, 15, 75, 'minutes per dungeon clear at dungeon level 15 (5-player group)'],
	dungeonRunHigh: [60, 15, 25, 120, 'minutes per dungeon clear at dungeon level 55'],
	dungeonFormUp: [15, 8, 2, 45, 'minutes to form a group and reach the instance portal'],
	dungeonTrash: [70, 20, 25, 150, 'elite trash kills per clear (DungeonJournal has no trash counts)'],
	partyShare: [0.28, 0, 0.28, 0.28, 'share of solo kill XP each of 5 party members gets (Classic: 1.4 / 5)'],
	restedShare: [0, 0, 0, 1, 'share of kill XP doubled by rested XP (optional)'],
	trainSec: [60, 0, 60, 60, 'v2: seconds per class trainer visit (v1 levelOverhead, spec §2.6)'],
	vendorSec: [60, 0, 60, 60, 'v2: seconds per vendor visit, repair and sell (estimate, spec §2.6)'],
	// Seconds added to route time when an unconfirmed rule is violated (the route
	// bends the rule): an estimate balancing routing influence vs. noise (spec §6.2).
	ruleSoftPenalty: [600, 0, 0, 3600, 'v2: seconds penalty for bending an unconfirmed rule (spec §6.2)'],
};

// ---- v2 gold (spec §2.6). Copper throughout. ----

// Piecewise-linear table over levels 0..60 from [level, copper] anchors.
function levelTable(anchors) {
	const t = new Float64Array(61);
	for (let l = 0; l <= 60; l++) {
		let k = 0;
		while (k < anchors.length - 2 && anchors[k + 1][0] <= l) k++;
		const [l0, c0] = anchors[k];
		const [l1, c1] = anchors[k + 1];
		const v = l <= l0 ? c0 : l >= l1 ? c1 : c0 + ((c1 - c0) * (l - l0)) / (l1 - l0);
		t[l] = Math.round(v);
	}
	return t;
}

// Mean quest coin per quest by quest level (copper): Forever's quest coin
// rewards (local page data), mean per quest by level ±2, sampled 2026-10-19
// (4,422 quests; 17-42% pay any coin, so the mean is the per-quest
// expectation). Linear between anchors. Per-quest coin (world.questCoin)
// replaces this when the page import lands; until then results mark gold: 'estimate'.
const COIN_EST_ANCHORS = [[1, 7], [5, 29], [10, 83], [15, 221], [20, 362], [25, 997], [30, 677], [35, 1251], [40, 1522], [45, 2020], [50, 3829], [55, 2767], [60, 2415]];
const COIN_EST = levelTable(COIN_EST_ANCHORS);

// Per kill by mob level L (index 0..63, copper), from CMaNGOS classic-db (the
// pinned dump in data/sources/cmangos), derived 2026-10-19 by a one-off script:
// creature_template rows with Rank 0 (non-elite, non-rare) and some loot
// (LootId or MaxLootGold > 0), L = round((MinLevel + MaxLevel) / 2).
// KILL_COIN: mean of (MinLootGold + MaxLootGold) / 2.
// KILL_VENDOR: mean expected vendor value of the loot: over creature_loot_template
// rows of LootId (reference_loot_template one level deep; grouped zero-chance rows
// share the group's remainder; negative chance = quest-only, skipped), chance% / 100
// × mean count × item_template.SellPrice, for Quality 0-2 items that are not class 12
// (quest); vendor price; the auction house is not modelled. Classic loot tables;
// Forever drops may differ. Realised at vendor visits.
const KILL_COIN = Object.freeze([0, 11, 4, 2, 3, 11, 3, 6, 6, 8, 11, 8, 10, 13, 13, 15, 16, 17, 18, 17, 23, 21, 23, 22, 30, 27, 29, 32, 28, 37, 33, 31, 51, 40, 41, 49, 50, 51, 47, 52, 47, 52, 68, 65, 72, 72, 83, 71, 62, 62, 82, 76, 79, 124, 104, 223, 118, 180, 152, 209, 208, 5867, 199, 1]);
const KILL_VENDOR = Object.freeze([0, 5, 6, 5, 5, 5, 12, 12, 17, 18, 19, 34, 38, 39, 40, 35, 91, 57, 69, 75, 62, 125, 108, 121, 122, 125, 169, 164, 165, 163, 105, 259, 255, 320, 301, 238, 329, 329, 405, 384, 327, 524, 435, 436, 510, 481, 465, 545, 557, 620, 482, 778, 614, 726, 780, 529, 818, 707, 785, 887, 386, 641, 51, 0]);

const GOLD = Object.freeze({ COIN_EST, KILL_COIN, KILL_VENDOR });

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
	smooth: { zoneChange: 900, zoneReturn: 1800, spotReturn: 900, grindWeight: 4, escortWeight: 4, wastedAccept: 600 },
	// smooth2 = v1 smooth weights + stepCost: 60 + grindWeight: 6 (plan Task
	// 10; grinding uncapped since 2026-10-20, the weight alone prices it: the
	// no-cap grid at 4/6/8/10, Horde 37.1/30.3/25.2/27.2 h of grinding,
	// 154.0/156.4/161.5/167.2 h, errand trips 56/67/83/93; Alliance
	// 43.1/30.6/35.4/37.8 h, 151.4/155.2/167.8/166.0 h, 55/78/88/87: above 6
	// grinding stops falling while hours and errands rise),
	// and the M3 search's terms (v2/search.js cost; tuned in M4):
	// - each route audit finding (v2/audit.js check in brackets) at the
	//   audit's own clunk-score seconds (audit.js CLUNK_WEIGHTS): deadLeg 60
	//   (check 6), hubSplit 300 (5), missedAccept 300 (1), missedTurnin 120 (2),
	//   avoidableReturn 600 (4);
	// - xpLoss 1: XP lost to late turn-ins counts once more, at the seconds it
	//   takes at the route's average rate (Fitz 2026-10-19: reduced XP is clunky);
	// - overrunWeight 1/600: over the time bound a second's price doubles at 5
	//   minutes over (d/dT of overrunWeight × overrun² is 1 there), small next to
	//   the short list's 4% steps (about 4 h at 100 h);
	// - territory 3: a second walked or worked in the other faction's zone
	//   counts 4 (Fitz 2026-10-20: walking or questing there costs a lot; Luna's
	//   Alliance L28-31 walk down the Barrens road to the Shimmering Flats).
	smooth2: {
		zoneChange: 900, zoneReturn: 1800, spotReturn: 900, grindWeight: 6, escortWeight: 6, wastedAccept: 600, stepCost: 60,
		deadLeg: 60, hubSplit: 300, missedAccept: 300, missedTurnin: 120, avoidableReturn: 600, xpLoss: 1, overrunWeight: 1 / 600,
		territory: 3,
	},
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
	PRIORS, NAMES, CLASS_FACTOR, OBJECTIVES, GOLD, objectiveName, parseOverrides, tagName, priorTable, paramsFile, loadParamsFile, saveParamsFile, effective, means, sample, draws,
};
