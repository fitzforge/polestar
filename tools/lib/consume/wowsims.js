'use strict';
// WoWSims (github.com/wowsims, MIT, "Copyright (c) 2024 wowsims team"): stat
// weights (EP) and BiS gear presets from the sims' UI sources. Facts only:
// numbers and item ids, never code or prose. Attribution: the sims ask for a
// user-visible link back to https://github.com/wowsims.
//
//   const { readWowsims } = require('./wowsims');
//   const ws = await readWowsims();                  // cache only (data/sources/wowsims)
//   const ws = await readWowsims({ fetch: true });   // download the pinned files first
//   ws.weights.WARRIOR.fury -> [{ level, phase, season, weights: { str: 1, ap: 0.3984, ... }, normalizedTo: 'str', ... }]
//   ws.gearSets.WARRIOR.fury['P3 BiS'] -> { level: 60, phase: 3, items: { head: 12640, ... }, file, commit }
//
// Two repos, read at pinned commits:
//   wowsims/sod      Season of Discovery (forked from the WotLK sim in 2023).
//                    ui/<sim>/sim.ts `epWeights` at the last commit of each
//                    level band: P1 (25), P2 (40), P3 (50) and the latest (60).
//   wowsims/classic  Forked from sod on 2024-11-19, converted to Classic Era
//                    level 60 (CLASSIC_CUTOVER). HEAD supplies Era weights and
//                    Era raid-phase BiS gear sets (ui/<sim>/gear_sets/*.json,
//                    named by ui/<sim>/presets.ts).
// Season matters for Forever (Era items, no runes): SoD weights and any Era
// weights left untouched since the cutover (`origin: 'sod-carryover'`) were
// tuned with SoD runes and set bonuses; only `origin: 'era'` sets were
// re-derived for Era.
//
// Units: Classic sims count hit/crit/dodge/parry/block as straight percent
// (sim/core/base_stats_auto_gen.go: *RatingPer*Chance = 1), so their EP is
// already per 1%, as Polestar wants. Defense is per point. Many specs still
// carry the WotLK sim's per-rating defaults (hit/crit worth ~1 AP); those sets
// are rejected (see `rejected`), not converted: they were never Classic EP.
//
// Spell power: a wowsims StatSpellPower item raises damage and healing, which
// Polestar items carry as both `sp` and `heal` (the ForeverLevelingBiS reader, rust/crates/forge-data/src/gear/flb.rs),
// so its weight lands on `heal` for healers and on `sp` for everyone else;
// StatHealingPower is `heal`. StatSpellDamage (damage-only, a SoD item stat)
// is not mapped.

const fs = require('node:fs');
const path = require('node:path');

const RAW = 'https://raw.githubusercontent.com';
const REPOS = { classic: 'wowsims/classic', sod: 'wowsims/sod' };
const LICENCE_URL = 'https://github.com/wowsims/classic/blob/master/LICENSE';

const CLASSIC_HEAD = '7779ebbf79dc7f1341e6ab939b28a3402c9a730a'; // 2026-07-24
// "Replace all gear presets with blank ones, remove all but one lvl 60 test
// case for specs" (2024-11-21): the Era fork's first commit; its weights are
// the SoD weights as carried over.
const CLASSIC_CUTOVER = '5634c852d47acfcc5b6b62a6472a536df64634dc';

// One weight snapshot per level band. SoD bands end where the next phase's
// sim work began (CURRENT_PHASE in ui/core/constants/other.ts confirms 1/2/3).
const SNAPSHOTS = [
	{ repo: 'sod', commit: '19c880c1a8a8f87ecf8b96d6d6aaf6fca9bfb06a', date: '2024-01-30', level: 25, phase: 'sod-p1', season: 'sod' },
	{ repo: 'sod', commit: '6f19e7806cccdc2e215bbf9c4ae7a07c26cd6ee3', date: '2024-03-25', level: 40, phase: 'sod-p2', season: 'sod' },
	{ repo: 'sod', commit: '9568974bd605da01a973c0173c491d40371eedec', date: '2024-06-28', level: 50, phase: 'sod-p3', season: 'sod' },
	{ repo: 'sod', commit: '0e3f6eff5fa3ad356664a1c2abbd02903d4cc97e', date: '2026-07-24', level: 60, phase: 'sod-latest', season: 'sod' },
	{ repo: 'classic', commit: CLASSIC_HEAD, date: '2026-07-24', level: 60, phase: 'era', season: 'era' },
];

// wowsims sim directory -> Polestar class/spec targets. One sim per class
// covers every talent tree for hunters, mages, warlocks and rogues, so its
// numbers are shared (`sim` on each entry says which). `dirs` lists the
// directory names in the order tried (protection_warrior became tank_warrior
// in July 2024).
const SIMS = {
	warrior: { dirs: ['warrior'], targets: [['WARRIOR', 'arms'], ['WARRIOR', 'fury']] },
	tank_warrior: { dirs: ['tank_warrior', 'protection_warrior'], targets: [['WARRIOR', 'protection']] },
	holy_paladin: { dirs: ['holy_paladin'], targets: [['PALADIN', 'holy']] },
	protection_paladin: { dirs: ['protection_paladin'], targets: [['PALADIN', 'protection']] },
	retribution_paladin: { dirs: ['retribution_paladin'], targets: [['PALADIN', 'retribution']] },
	hunter: { dirs: ['hunter'], targets: [['HUNTER', 'beastmastery'], ['HUNTER', 'marksmanship'], ['HUNTER', 'survival']] },
	rogue: { dirs: ['rogue'], targets: [['ROGUE', 'assassination'], ['ROGUE', 'combat'], ['ROGUE', 'subtlety']] },
	healing_priest: { dirs: ['healing_priest'], targets: [['PRIEST', 'discipline'], ['PRIEST', 'holy']] },
	shadow_priest: { dirs: ['shadow_priest'], targets: [['PRIEST', 'shadow']] },
	elemental_shaman: { dirs: ['elemental_shaman'], targets: [['SHAMAN', 'elemental']] },
	enhancement_shaman: { dirs: ['enhancement_shaman'], targets: [['SHAMAN', 'enhancement']] },
	restoration_shaman: { dirs: ['restoration_shaman'], targets: [['SHAMAN', 'restoration']] },
	mage: { dirs: ['mage'], targets: [['MAGE', 'arcane'], ['MAGE', 'fire'], ['MAGE', 'frost']] },
	warlock: { dirs: ['warlock'], targets: [['WARLOCK', 'affliction'], ['WARLOCK', 'demonology'], ['WARLOCK', 'destruction']] },
	balance_druid: { dirs: ['balance_druid'], targets: [['DRUID', 'balance']] },
	feral_druid: { dirs: ['feral_druid'], targets: [['DRUID', 'feral']] },
	feral_tank_druid: { dirs: ['feral_tank_druid'], targets: [['DRUID', 'feraltank']] },
	restoration_druid: { dirs: ['restoration_druid'], targets: [['DRUID', 'restoration']] },
};
// SoD-only roles with no Era/Forever counterpart: not read.
const SKIPPED_SIMS = { warden_shaman: 'SoD-only tank shaman', tank_rogue: 'SoD-only tank rogue', tank_warlock: 'SoD-only tank warlock' };

// Each spec's main stat, set to 1 by normalization. Falls back to the sim's
// EP reference stat when the main stat has no positive weight.
const MAIN_STAT = {
	WARRIOR: { arms: 'str', fury: 'str', protection: 'str' },
	PALADIN: { holy: 'heal', protection: 'str', retribution: 'str' },
	HUNTER: { beastmastery: 'agi', marksmanship: 'agi', survival: 'agi' },
	ROGUE: { assassination: 'agi', combat: 'agi', subtlety: 'agi' },
	PRIEST: { discipline: 'heal', holy: 'heal', shadow: 'sp' },
	SHAMAN: { elemental: 'sp', enhancement: 'str', restoration: 'heal' },
	MAGE: { arcane: 'sp', fire: 'sp', frost: 'sp' },
	WARLOCK: { affliction: 'sp', demonology: 'sp', destruction: 'sp' },
	DRUID: { balance: 'sp', feral: 'agi', feraltank: 'agi', restoration: 'heal' },
};
const HEALER_SIMS = new Set(['holy_paladin', 'healing_priest', 'restoration_shaman', 'restoration_druid']);

// wowsims Stat / PseudoStat enum names (proto/common.proto) -> Polestar keys.
const STAT_MAP = {
	StatStrength: 'str', StatAgility: 'agi', StatStamina: 'sta', StatIntellect: 'int', StatSpirit: 'spi',
	StatArmor: 'armor', StatHealth: 'health', StatMana: 'mana',
	StatAttackPower: 'ap', StatRangedAttackPower: 'rap',
	StatHealingPower: 'heal',
	StatArcanePower: 'spArcane', StatFirePower: 'spFire', StatFrostPower: 'spFrost',
	StatHolyPower: 'spHoly', StatNaturePower: 'spNature', StatShadowPower: 'spShadow',
	StatMP5: 'mp5',
	StatMeleeHit: 'hit', StatMeleeCrit: 'crit', StatSpellHit: 'spellHit', StatSpellCrit: 'spellCrit',
	StatDefense: 'defense', StatDodge: 'dodge', StatParry: 'parry', StatBlock: 'block', StatBlockValue: 'blockValue',
	PseudoStatMainHandDps: 'dps', PseudoStatRangedDps: 'rdps',
};
// Stats with no Polestar key, and why (others: "no Polestar key").
const UNMAPPED_REASON = {
	StatSpellDamage: 'damage-only spell power (SoD item stat); Polestar sp is damage+healing power',
	StatBonusArmor: 'non-base armor; Polestar armor takes the StatArmor weight',
	StatFeralAttackPower: 'feral-form attack power; no Polestar key',
	StatExpertise: 'expertise/weapon skill; no Polestar key',
	StatMeleeHaste: 'haste %: SoD-only item stat',
	StatSpellHaste: 'haste %: SoD-only item stat',
	StatArmorPenetration: 'armor penetration; no Polestar key',
	StatSpellPenetration: 'spell penetration; no Polestar key',
	StatArcaneResistance: 'resistances are not scored',
	StatFireResistance: 'resistances are not scored',
	StatFrostResistance: 'resistances are not scored',
	StatNatureResistance: 'resistances are not scored',
	StatShadowResistance: 'resistances are not scored',
	PseudoStatOffHandDps: 'off-hand weapon DPS; Polestar dps takes the main-hand weight',
	PseudoStatMeleeSpeedMultiplier: 'attack-speed multiplier pseudo-stat',
	PseudoStatRangedSpeedMultiplier: 'attack-speed multiplier pseudo-stat',
	PseudoStatCastSpeedMultiplier: 'cast-speed multiplier pseudo-stat',
	BonusPhysicalDamage: 'flat physical damage pseudo-stat; no Polestar key',
	PseudoStatBonusPhysicalDamage: 'flat physical damage pseudo-stat; no Polestar key',
	PseudoStatTimewornBonus: 'SoD Timeworn item bonus pseudo-stat',
	PseudoStatSanctifiedBonus: 'SoD Sanctified item bonus pseudo-stat',
};
const SCALE_STATS = ['StatMeleeHit', 'StatMeleeCrit', 'StatSpellHit', 'StatSpellCrit'];
// A Classic-scale EP set values 1% hit or crit at several reference points;
// the inherited WotLK defaults value one rating point at ~1 (all below 3).
const MIN_PERCENT_EP = 3;

// wowsims ItemSlot order (proto/common.proto) -> Polestar slot names.
const SLOTS = ['head', 'neck', 'shoulder', 'back', 'chest', 'wrist', 'hands', 'waist', 'legs', 'feet',
	'finger1', 'finger2', 'trinket1', 'trinket2', 'mainhand', 'offhand', 'ranged'];

function round(n) {
	return Math.round(n * 10000) / 10000;
}

// `epWeights: Stats.fromMap({ [Stat.X]: n, ... }, { [PseudoStat.Y]: n })` and
// `epReferenceStat: Stat.X` out of a sim.ts. Returns null without epWeights.
function parseSimTs(src) {
	const start = src.indexOf('epWeights: Stats.fromMap(');
	if (start < 0) return null;
	let depth = 0;
	let end = start + 'epWeights: Stats.fromMap'.length;
	for (; end < src.length; end++) {
		if (src[end] === '(') depth++;
		else if (src[end] === ')' && --depth === 0) break;
	}
	const body = src.slice(start, end).replace(/\/\/[^\n]*/g, '');
	const raw = {};
	for (const m of body.matchAll(/\[(?:Stat|PseudoStat)\.(\w+)\]\s*:\s*(-?\d+(?:\.\d+)?|-?\.\d+)\s*[,}\n]/g)) raw[m[1]] = Number(m[2]);
	const ref = /epReferenceStat:\s*Stat\.(\w+)/.exec(src);
	return { raw, reference: ref ? ref[1] : null };
}

// Hit/crit EP per reference point; null when no such weight exists. Sets are
// normally scaled to reference = 1; a reference below 1 (tank sets scaled to
// stamina) is not divided out, which would inflate per-rating values.
function percentScale(raw, reference) {
	const refWeight = reference && raw[reference] > 1 ? raw[reference] : 1;
	let max = null;
	for (const s of SCALE_STATS) if (raw[s] > 0) max = Math.max(max ?? 0, raw[s] / refWeight);
	return max;
}

function referenceKey(reference, healer) {
	if (reference === 'StatSpellPower') return healer ? 'heal' : 'sp';
	if (reference === 'StatSpellDamage') return 'sp';
	return STAT_MAP[reference] || null;
}

// wowsims raw EP -> { weights (Polestar keys, zeroes dropped), dropped (raw
// names with no key -> value) }.
function mapWeights(raw, { healer = false } = {}) {
	const weights = {};
	const dropped = {};
	for (const [name, value] of Object.entries(raw)) {
		if (!value) continue;
		let key = STAT_MAP[name];
		if (name === 'StatSpellPower') key = healer ? 'heal' : 'sp';
		if (!key) {
			dropped[name] = value;
			continue;
		}
		weights[key] = (weights[key] || 0) + value;
	}
	return { weights, dropped };
}

// Scale so `main` (or the fallback) is 1; returns null when neither has a
// positive weight.
function normalize(weights, main, fallback) {
	const to = weights[main] > 0 ? main : weights[fallback] > 0 ? fallback : null;
	if (!to) return null;
	const div = weights[to];
	const out = {};
	for (const [k, v] of Object.entries(weights)) out[k] = round(v / div);
	return { weights: out, normalizedTo: to };
}

// presets.ts -> [{ label, file }] for each makePresetGear over a gear_sets JSON.
function parseGearPresets(src) {
	const files = {};
	for (const m of src.matchAll(/import\s+(\w+)\s+from\s+['"]\.\/gear_sets\/([\w.\-]+\.gear\.json)['"]/g)) files[m[1]] = m[2];
	const out = [];
	for (const m of src.matchAll(/makePresetGear\(\s*['"]([^'"]+)['"]\s*,\s*(\w+)/g)) {
		if (files[m[2]]) out.push({ label: m[1], file: files[m[2]] });
	}
	return out;
}

// Era raid phase of a preset label: "P3 BiS"/"Phase 3" -> 3, "Pre-BiS" -> 0,
// "MC" -> 1; null when unknown.
function gearPhase(label) {
	const m = /\bP(?:hase\s*)?(\d)\b/i.exec(label);
	if (m) return Number(m[1]);
	if (/pre-?bis/i.test(label)) return 0;
	if (/^MC$/i.test(label.trim())) return 1;
	return null;
}

// Gear-set JSON ({ items: [{ id, enchant? }, ...] } in ItemSlot order) ->
// { slot: itemId }.
function parseGearSet(json) {
	const data = typeof json === 'string' ? JSON.parse(json) : json;
	const items = {};
	(data.items || []).forEach((it, i) => {
		if (it && it.id > 0 && SLOTS[i]) items[SLOTS[i]] = it.id;
	});
	return items;
}

function cachePath(cacheDir, repo, commit, file) {
	return path.join(cacheDir, repo, commit, ...file.split('/'));
}

// File source over the cache, downloading misses when `fetch` is set. A
// missing upstream file (404) is recorded so later reads skip it.
function makeSource({ cacheDir, fetch, log }) {
	const manifestFile = path.join(cacheDir, 'manifest.json');
	let manifest = { fetched: null, files: {} };
	if (fs.existsSync(manifestFile)) manifest = JSON.parse(fs.readFileSync(manifestFile, 'utf8'));
	else if (!fetch) throw new Error(`wowsims: no cache at ${cacheDir}; run with { fetch: true }`);
	let downloads = 0;
	return {
		manifest,
		async get(repo, commit, file) {
			const key = `${repo}@${commit}:${file}`;
			const local = cachePath(cacheDir, repo, commit, file);
			if (fs.existsSync(local)) return fs.readFileSync(local, 'utf8');
			if (!fetch || manifest.files[key] === 404) return null;
			const url = `${RAW}/${REPOS[repo]}/${commit}/${file}`;
			const res = await globalThis.fetch(url);
			downloads++;
			if (res.status === 404) {
				manifest.files[key] = 404;
				return null;
			}
			if (!res.ok) throw new Error(`wowsims: ${url} -> HTTP ${res.status}`);
			const text = await res.text();
			fs.mkdirSync(path.dirname(local), { recursive: true });
			fs.writeFileSync(local, text);
			manifest.files[key] = 200;
			if (log) log(`wowsims: ${repo}@${commit.slice(0, 9)} ${file}`);
			return text;
		},
		save() {
			if (!fetch) return;
			manifest.fetched = new Date().toISOString();
			manifest.downloads = downloads;
			fs.mkdirSync(cacheDir, { recursive: true });
			fs.writeFileSync(manifestFile, JSON.stringify(manifest, null, '\t') + '\n');
		},
	};
}

async function simTs(src, snap, sim) {
	for (const dir of SIMS[sim].dirs) {
		const file = `ui/${dir}/sim.ts`;
		const text = await src.get(snap.repo, snap.commit, file);
		if (text != null) return { file, parsed: parseSimTs(text) };
	}
	return null;
}

function put(tree, cls, spec, value) {
	tree[cls] = tree[cls] || {};
	return (tree[cls][spec] = tree[cls][spec] || value);
}

async function readWowsims({ cacheDir = 'data/sources/wowsims', fetch = false, log } = {}) {
	const src = makeSource({ cacheDir, fetch, log });
	const weights = {};
	const gearSets = {};
	const rejected = [];
	const unmapped = {};
	const lastRaw = {};

	for (const snap of SNAPSHOTS) {
		for (const sim of Object.keys(SIMS)) {
			const got = await simTs(src, snap, sim);
			if (!got || !got.parsed) continue;
			const { raw, reference } = got.parsed;
			const healer = HEALER_SIMS.has(sim);
			const base = { level: snap.level, phase: snap.phase, season: snap.season, sim, repo: REPOS[snap.repo], file: got.file, commit: snap.commit };
			const scale = percentScale(raw, reference);
			if (scale == null || scale < MIN_PERCENT_EP) {
				rejected.push({ ...base, targets: SIMS[sim].targets.map(t => t.join('.')), reason: scale == null ? 'no hit/crit weight to check the scale' : `hit/crit EP ${round(scale)} per reference point: WotLK per-rating default, not Classic per-% EP` });
				continue;
			}
			let origin = snap.season;
			if (snap.season === 'era') {
				// Carried over when every mapped weight Era kept still has its SoD
				// value (the fork later deleted SoD-only stats and added pseudo-stats
				// without retuning the rest).
				const cut = await simTs(src, { repo: 'classic', commit: CLASSIC_CUTOVER }, sim);
				const kept = cut && cut.parsed && Object.entries(raw)
					.filter(([k]) => STAT_MAP[k] || k === 'StatSpellPower')
					.every(([k, v]) => cut.parsed.raw[k] === v);
				origin = kept ? 'sod-carryover' : 'era';
			}
			const key = JSON.stringify(raw);
			const sameAs = lastRaw[sim] && lastRaw[sim].key === key ? lastRaw[sim].phase : undefined;
			lastRaw[sim] = { key, phase: snap.phase };
			const { weights: mapped, dropped } = mapWeights(raw, { healer });
			for (const [name, value] of Object.entries(dropped)) {
				const u = (unmapped[name] = unmapped[name] || { stat: name, reason: UNMAPPED_REASON[name] || 'no Polestar key', sets: 0, examples: [] });
				u.sets++;
				if (u.examples.length < 3) u.examples.push({ sim, phase: snap.phase, value });
			}
			for (const [cls, spec] of SIMS[sim].targets) {
				const norm = normalize(mapped, MAIN_STAT[cls][spec], referenceKey(reference, healer));
				if (!norm) {
					rejected.push({ ...base, class: cls, spec, reason: 'neither main stat nor reference stat has a weight' });
					continue;
				}
				const entry = { ...base, origin, runeInfluenced: origin !== 'era', weights: norm.weights, normalizedTo: norm.normalizedTo };
				if (sameAs) entry.sameAs = sameAs;
				if (Object.keys(dropped).length) entry.dropped = dropped;
				put(weights, cls, spec, []).push(entry);
			}
		}
	}

	// Era gear sets: classic HEAD presets.ts names each gear_sets JSON.
	for (const sim of Object.keys(SIMS)) {
		const dir = SIMS[sim].dirs[0];
		const presets = await src.get('classic', CLASSIC_HEAD, `ui/${dir}/presets.ts`);
		if (presets == null) continue;
		for (const { label, file } of parseGearPresets(presets)) {
			if (/^blank$/i.test(label)) continue;
			const rel = `ui/${dir}/gear_sets/${file}`;
			const json = await src.get('classic', CLASSIC_HEAD, rel);
			if (json == null) continue;
			const items = parseGearSet(json);
			if (!Object.keys(items).length) continue;
			for (const [cls, spec] of SIMS[sim].targets) {
				put(gearSets, cls, spec, {})[label] = { level: 60, phase: gearPhase(label), season: 'era', sim, items, file: rel, commit: CLASSIC_HEAD };
			}
		}
	}

	const licence = await src.get('classic', CLASSIC_HEAD, 'LICENSE');
	src.save();
	return {
		meta: {
			source: 'wowsims',
			url: 'https://github.com/wowsims',
			licence: licence && /MIT License/.test(licence) ? 'MIT' : 'MIT (LICENSE not cached)',
			licenceUrl: LICENCE_URL,
			version: SNAPSHOTS.map(s => `${REPOS[s.repo]}@${s.commit} (${s.phase}, ${s.date})`).concat(`${REPOS.classic}@${CLASSIC_CUTOVER} (era cutover baseline)`),
			commits: { classic: CLASSIC_HEAD, classicCutover: CLASSIC_CUTOVER, sod: Object.fromEntries(SNAPSHOTS.filter(s => s.repo === 'sod').map(s => [s.phase, s.commit])) },
			fetched: src.manifest.fetched,
			notes: [
				'Weights: wowsims default EP (ui/<sim>/sim.ts epWeights), mapped to Polestar keys, zero weights dropped, scaled so the spec main stat (normalizedTo) is 1.',
				'Hit/crit/dodge/parry/block weights are per 1% (Classic sims count these stats in percent); defense per point.',
				'season sod / origin sod-carryover: tuned with SoD runes and set bonuses. origin era: re-derived in the Era fork after 2024-11-21.',
				'Sets still holding the WotLK per-rating defaults are listed in rejected, not converted.',
				'sameAs: identical raw weights to an earlier band (not retuned for this level).',
				`Not read (SoD-only roles): ${Object.entries(SKIPPED_SIMS).map(([k, v]) => `${k} (${v})`).join(', ')}.`,
				'Gear sets: Classic Era level 60 raid-phase presets (phase 0 = pre-raid), item ids by Polestar slot; one-sim classes share sets across specs.',
			],
		},
		weights,
		gearSets,
		rejected,
		unmapped: Object.values(unmapped),
	};
}

module.exports = {
	readWowsims, parseSimTs, mapWeights, normalize, percentScale, parseGearPresets, parseGearSet, gearPhase,
	STAT_MAP, CLASSIC_HEAD, SLOTS,
};
