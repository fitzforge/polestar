'use strict';
// Experience rules, once for every tool: the route drafter, the simulator,
// the recording report and lint's level checks (docs/legacy/SIMULATION-js.md §2).
//
// - XP to level: the 1.12 table (Forever has not published a different one;
//   recordings will show if it changed).
// - Quest XP: the client's QuestXP table (DB2, one row per quest level, one
//   column per difficulty tier), cached under data/sources/wago/<build>/ like
//   the other wago.tools tables, reduced by how far the player is above the
//   quest: 100% up to quest level + 5, then 80/60/40/20/10%. Without the
//   table, `baseQuestXp` estimates a typical reward.
// - Kill XP: 45 + 5 × player level against an equal-level mob, +5% per level
//   the mob is above (at most +4 levels counted), scaled down by the
//   zero-difference value below, nothing for grey mobs; elites ×2.

const fs = require('node:fs');
const path = require('node:path');
const { parseCsv } = require('../data/csv');
const { tableUrl } = require('../data/wago');

// XP to go from level L to L+1 (index L).
const LEVEL_XP = [
	0, 400, 900, 1400, 2100, 2800, 3600, 4500, 5400, 6500, 7600,
	8800, 10100, 11400, 12900, 14400, 16000, 17700, 19400, 21300, 23200,
	25200, 27300, 29400, 31700, 34000, 36400, 38900, 41400, 44300, 47400,
	50800, 54500, 58600, 62800, 67100, 71600, 76100, 80800, 85700, 90700,
	95800, 101000, 106300, 111800, 117500, 123200, 129100, 135100, 141200, 147500,
	153900, 160400, 167100, 173900, 180800, 187900, 195000, 202300, 209800,
];
const MAX_LEVEL = 60;

// Cumulative XP at the start of `level`.
const CUM_XP = [0, 0];
for (let l = 2; l <= MAX_LEVEL; l++) CUM_XP[l] = CUM_XP[l - 1] + LEVEL_XP[l - 1];

// Player progress: { level, xp } with xp into the current level.
function gain(state, amount) {
	state.xp += amount;
	let ups = 0;
	while (state.level < MAX_LEVEL && state.xp >= LEVEL_XP[state.level]) {
		state.xp -= LEVEL_XP[state.level];
		state.level++;
		ups++;
	}
	if (state.level >= MAX_LEVEL) state.xp = 0;
	return ups;
}

// A point inside a level, as a `level` goal or a `when level` predicate
// writes it (docs/GUIDE_FORMAT.md): "12" is the start of level 12, "12.5"
// halfway through it, "12+2500" 2500 XP into it (this table's XP).
// -> { level, frac?, xp? } or { error }. `frac` is the share of the level done,
// rounded to whole percent as the guide window shows it, and always strictly
// between 0 and 1: "12.0" and "12+0" are plain level 12, and a point that
// rounds to the start or the end of the level is an error. `xp` is the XP as
// written. The level of "12" is not range-checked: callers do that.
function levelPoint(text) {
	const s = String(text);
	if (/^\d+$/.test(s)) return { level: Number(s) };
	const m = /^(\d+)(?:\.(\d+)|\+(\d+))$/.exec(s);
	if (!m) return { error: `malformed level "${s}" (expected N, N.fraction or N+XP)` };
	const level = Number(m[1]);
	if (level < 1 || level >= MAX_LEVEL) return { error: `level ${s}: a point inside a level needs a level from 1 to ${MAX_LEVEL - 1}` };
	const xp = m[3] !== undefined ? Number(m[3]) : undefined;
	if (xp !== undefined && xp >= LEVEL_XP[level]) return { error: `level ${s}: more XP than level ${level} needs (${LEVEL_XP[level]})` };
	const exact = xp !== undefined ? xp / LEVEL_XP[level] : Number(`0.${m[2]}`);
	if (exact === 0) return { level };
	const frac = Math.round(exact * 100) / 100;
	if (frac <= 0) return { error: `level ${s} is less than 1% into level ${level}: write ${level}` };
	if (frac >= 1) return { error: `level ${s} rounds to the end of level ${level}: write ${level + 1}` };
	return xp !== undefined ? { level, frac, xp } : { level, frac };
}

// Whether progress { level, xp } has reached a `level` goal: past its level,
// or at it with `frac` of the level's XP (as the addon counts it:
// XP / XPMax >= frac).
function levelReached(state, level, frac) {
	if (state.level !== level || !frac || level >= MAX_LEVEL) return state.level >= level;
	return state.xp / LEVEL_XP[level] >= frac;
}

// --- Quest XP ---------------------------------------------------------------

const QUESTXP_BUILD = '1.15.9.70003';

function questXpFile(sourcesDir, build = QUESTXP_BUILD) {
	return path.join(sourcesDir, 'wago', build, 'QuestXP.csv');
}

// rows[level] = [tier0..tier9]
function parseQuestXp(text) {
	const rows = [];
	for (const r of parseCsv(text)) {
		const lvl = Number(r.ID);
		if (!Number.isInteger(lvl) || lvl < 1) continue;
		const tiers = [];
		for (let i = 0; i < 10; i++) tiers.push(Number(r[`Difficulty_${i}`]) || 0);
		rows[lvl] = tiers;
	}
	if (!rows[1] || !rows[60]) throw new Error('QuestXP table lacks levels 1-60');
	return rows;
}

// Cached file, else fetched once from wago.tools and cached (immutable per build).
async function loadQuestXp({ sourcesDir, build = QUESTXP_BUILD, offline = false, fetchImpl = globalThis.fetch, log = () => {} }) {
	const file = questXpFile(sourcesDir, build);
	if (!fs.existsSync(file)) {
		if (offline) throw new Error(`--offline: missing cached ${file}`);
		const url = tableUrl('QuestXP', build);
		log(`fetching ${url}`);
		const res = await fetchImpl(url, { headers: { 'user-agent': 'polestar-data-build' } });
		if (!res.ok) throw new Error(`GET ${url}: HTTP ${res.status}`);
		const text = await res.text();
		parseQuestXp(text);
		fs.mkdirSync(path.dirname(file), { recursive: true });
		fs.writeFileSync(`${file}.tmp`, text);
		fs.renameSync(`${file}.tmp`, file);
	}
	return parseQuestXp(fs.readFileSync(file, 'utf8'));
}

// Full reward of a typical quest by quest level, for drafting when quests.json
// has no `xp`. Linear between anchors; roughly the median Classic reward per
// level.
//
//   quest level   1    5   10    15    20    25    30    35    40    45    50    55    60
//   xp          100  400  800  1200  1700  2200  2700  3250  3800  4400  5100  5800  6600
const QUEST_XP_ANCHORS = [
	[1, 100], [5, 400], [10, 800], [15, 1200], [20, 1700], [25, 2200], [30, 2700],
	[35, 3250], [40, 3800], [45, 4400], [50, 5100], [55, 5800], [60, 6600],
];

function baseQuestXp(qlvl) {
	const l = Math.max(1, Math.min(MAX_LEVEL, qlvl || 1));
	for (let i = 1; i < QUEST_XP_ANCHORS.length; i++) {
		const [l1, x1] = QUEST_XP_ANCHORS[i];
		const [l0, x0] = QUEST_XP_ANCHORS[i - 1];
		if (l <= l1) return Math.round(x0 + ((x1 - x0) * (l - l0)) / (l1 - l0));
	}
	return QUEST_XP_ANCHORS[QUEST_XP_ANCHORS.length - 1][1];
}

// Share of a quest's reward by player level − quest level:
//
//   player - quest level   <=5    6    7    8    9   >=10
//   share                 100%  80%  60%  40%  20%   10%
function questXpShare(playerLevel, questLevel) {
	const d = playerLevel - questLevel;
	if (d <= 5) return 1;
	if (d >= 10) return 0.1;
	return [0.8, 0.6, 0.4, 0.2][d - 6];
}

// A reward at a player level (the client's own rounding is ignored: < 5 XP).
function questXpAt(full, playerLevel, questLevel) {
	return full * questXpShare(playerLevel, questLevel);
}

// A quest's reward at a player level, rounded: `xp` from data is the full
// reward (recorded rewards at a known level are close enough to treat the
// same way), else the estimate.
function questXp(quest, playerLevel) {
	const qlvl = quest.level || quest.minLevel || playerLevel;
	const full = typeof quest.xp === 'number' && quest.xp > 0 ? quest.xp : baseQuestXp(qlvl);
	return Math.round(full * questXpShare(playerLevel, qlvl));
}

// --- Kill XP ----------------------------------------------------------------

function zeroDiff(l) {
	if (l <= 7) return 5;
	if (l <= 9) return 6;
	if (l <= 11) return 7;
	if (l <= 15) return 8;
	if (l <= 19) return 9;
	if (l <= 29) return 11;
	if (l <= 39) return 12;
	if (l <= 44) return 13;
	if (l <= 49) return 14;
	if (l <= 54) return 15;
	if (l <= 59) return 16;
	return 17;
}

// Highest mob level that is grey (gives nothing) to a player of level l.
function greyLevel(l) {
	if (l <= 5) return 0;
	if (l <= 39) return l - Math.floor(l / 10) - 5;
	if (l <= 59) return l - Math.floor(l / 5) - 1;
	return l - 9;
}

// Forever (#30): a mob below the player starts from the mob's own level, then
// takes the same level-difference factor. Mobs at or above the player: Classic.
function mobXp(playerLevel, mobLevel, elite = false, { forever = false } = {}) {
	const base = playerLevel * 5 + 45;
	let v;
	if (mobLevel >= playerLevel) v = base * (1 + 0.05 * Math.min(mobLevel - playerLevel, 4));
	else if (mobLevel <= greyLevel(playerLevel)) v = 0;
	else v = Math.max(0, (forever ? mobLevel * 5 + 45 : base) * (1 - (playerLevel - mobLevel) / zeroDiff(playerLevel)));
	return Math.round(v) * (elite ? 2 : 1);
}

module.exports = {
	LEVEL_XP, MAX_LEVEL, CUM_XP, gain, levelPoint, levelReached,
	parseQuestXp, loadQuestXp,
	baseQuestXp, questXpShare, questXpAt, questXp,
	zeroDiff, greyLevel, mobXp,
};
