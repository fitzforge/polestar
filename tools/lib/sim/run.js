'use strict';
// A world compiled for one character (faction, race, class) into flat typed
// arrays the evaluator walks without allocating, plus the parameter-dependent
// tables (kill time/XP by player and mob level, quest rewards, grind rates).
//
//   const run = compileRun(world, { race: 'Orc', cls: null });
//   const tables = makeTables(run, params);

const { mobXp } = require('../game/xp');
const { CLASSES, ALL_CLASSES, RACE_BY_FILE, FACTION_RACES, SKYBORNE_BIT, hasBit, raceLabel, classLabel } = require('../game/races');
const { planOrder } = require('./tour');
const { ISLE_MAPS, ISLANDS } = require('./world');

// Mask bits by the names runs use ("Undead", "Warrior"): the Era races, every class.
const RACE_BITS = {};
for (const r of Object.values(RACE_BY_FILE)) {
	const bits = Object.values(r.sides);
	if (bits.length === 1 && bits[0] < 2 ** 32) RACE_BITS[raceLabel(r.file)] = bits[0];
}
const CLASS_BITS = Object.fromEntries(Object.values(CLASSES).map((c) => [classLabel(c.file), c.bit]));

const K_ACCEPT = 0;
const K_TASK = 1;
const K_TURNIN = 2;
const K_GRIND = 3; // sequences only: grind to a level checkpoint
const K_DUNGEON = 4; // run a dungeon (quest field = dungeon index)

const W_KILL = 0;
const W_USE = 1;
const W_ESCORT = 2;
const W_BUY = 3;
const W_VISIT = 4;
const W_DUNGEON = 5; // done by the dungeon run, not by visiting
const WORK_KIND = { kill: W_KILL, use: W_USE, escort: W_ESCORT, buy: W_BUY, visit: W_VISIT, dungeon: W_DUNGEON };

const NEAR_K = 3; // transport nodes considered at each end of a leg
const NEAR_HUB = 200; // a flight master / inn this close is learned / bound

const MOBL = 64; // mob level stride in the kill tables

function raceBit(race, raceBits = {}, faction = null) {
	if (race == null) return 0;
	if (raceBits[race] != null) return raceBits[race];
	if (race === 'Skyborne' && faction) return SKYBORNE_BIT[faction];
	return RACE_BITS[race] || 0;
}

// Is a quest open to this character? Masks are Era masks: a race without an
// Era bit (Forever races) is never excluded by them unless given a bit.
// Without a class ("any"), a class mask that still allows 5+ classes (the
// usual "everyone but Paladin/Shaman" masks) is open; real class quests
// (1-4 classes) are not.
function questOpen(q, faction, rbit, cls) {
	if (q.races) {
		const fm = FACTION_RACES[faction];
		if (rbit) {
			if (!hasBit(q.races, rbit)) return false;
		} else if (((q.races % 2 ** 32) & fm) === 0 && !hasBit(q.races, SKYBORNE_BIT[faction])) return false;
	}
	if (q.classes && (q.classes & ALL_CLASSES) !== ALL_CLASSES) {
		if (cls) {
			if (!(q.classes & CLASS_BITS[cls])) return false;
		} else if (popcount(q.classes & ALL_CLASSES) < 5) return false;
	}
	return true;
}

function popcount(v) {
	let n = 0;
	for (let x = v; x; x &= x - 1) n++;
	return n;
}

// Zephras Isle is Skyborne-only: a quest whose giver, ender, quest-starting
// drop or objective sites lie on the isle maps is closed to every other race.
const ISLE = new Set(ISLE_MAPS);
function onIsle(world, q) {
	const W = world.points;
	const at = (pt) => ISLE.has(W[pt][4]);
	if (at(q.giver) || at(q.ender) || (q.accept && at(q.accept.pt))) return true;
	for (const t of q.tasks) if (at(t.pt)) return true;
	return false;
}

// Level below which a character stays on its home continent (and off other
// races' starting islands); see docs/SIMULATION.md "Starts".
const HOME_LEVEL = 10;

// A completionist package is one zone visit over a tier of up to 8 levels
// (world.js), too wide for one tour: Durotar 1-10 toured as one sent a level
// 1 Orc to Razor Hill before the Valley of Trials. So it is walked in slices
// of `width` levels by its quests' minimum levels, each slice toured on its
// own (planOrder); a quest goes no earlier than the slice of a prerequisite or
// parent here, so chains keep their order across slices.
function sliceOrder(sub, worldById, width, dist) {
	const sliceOf = new Map();
	for (const s of sub) {
		const wq = worldById.get(s.q);
		sliceOf.set(s.q, Math.floor((Math.max(1, wq.minLevel || wq.level || 1) - 1) / width));
	}
	for (let pass = 0; pass < 4; pass++) {
		for (const s of sub) {
			let v = sliceOf.get(s.q);
			for (const p of s.quest.pre) if (sliceOf.has(p)) v = Math.max(v, sliceOf.get(p));
			if (s.quest.inLog != null && sliceOf.has(s.quest.inLog)) {
				v = Math.max(v, sliceOf.get(s.quest.inLog));
				sliceOf.set(s.quest.inLog, v);
			}
			sliceOf.set(s.q, v);
		}
	}
	const slices = new Map();
	for (const s of sub) {
		const v = sliceOf.get(s.q);
		if (!slices.has(v)) slices.set(v, []);
		slices.get(v).push(s);
	}
	return [...slices.keys()].sort((a, b) => a - b).flatMap((v) => planOrder(slices.get(v), { dist }));
}

// family: 'solo' (no dungeons), 'dungeons' (dungeon packages and their
// quests allowed) or 'completionist' (every quest open to the character, on
// the completionist world: docs/SIMULATION.md "Completionist"; no dungeons).
function compileRun(world, { race, cls = null, raceBits = {}, family = 'solo' } = {}) {
	const faction = world.faction;
	const rbit = raceBit(race, raceBits, faction);
	const start = world.starts[race];
	if (!start) throw new Error(`no ${faction} start for race ${race} (known: ${Object.keys(world.starts).join(', ')})`);
	const withDungeons = family === 'dungeons';
	const completionist = family === 'completionist';
	if (completionist && world.variant !== 'completionist') throw new Error('the completionist family runs on the completionist world (sim.loadWorld({ variant: "completionist" }))');
	const skyborne = race === 'Skyborne';

	// ---- quests open to this character ----
	const worldById = new Map(world.quests.map((q) => [q.id, q]));
	const excludedIds = new Set(world.excludedIds || []);
	const isOpen = (q) => questOpen(q, faction, rbit, cls) && (skyborne || !onIsle(world, q));
	let open = new Map();
	for (const q of world.quests) if (isOpen(q) && (withDungeons || q.dungeon === undefined)) open.set(q.id, q);
	// Completionist: quests that exclude each other both ways are a real
	// choice (a one-way `excl` is only an order: 526 before 324). Of each
	// such group one is kept: most quests depending on it (transitively),
	// then the higher reward (recorded XP, else the QuestXP estimate), then
	// the lower id; the others are left out as its alternatives (`branches`)
	// and the quests after them go with them (blocked below).
	const branches = [];
	if (completionist) {
		const followers = new Map();
		for (const q of open.values()) {
			for (const p of q.pre.concat(q.preAll || [])) {
				if (!followers.has(p)) followers.set(p, []);
				followers.get(p).push(q.id);
			}
		}
		const depCount = (id) => {
			const seen = new Set();
			const stack = [id];
			while (stack.length) for (const f of followers.get(stack.pop()) || []) if (!seen.has(f)) {
				seen.add(f);
				stack.push(f);
			}
			return seen.size;
		};
		const rows = world.questXp || [];
		const reward = (q) => q.xp || ((rows[Math.max(1, Math.min(rows.length - 1, q.level))] || [])[q.tier] || 0);
		const sym = (a, b) => (a.excl || []).includes(b.id) && (b.excl || []).includes(a.id);
		const partners = (q) => (q.excl || []).filter((e) => open.has(e) && sym(q, open.get(e)));
		const ranked = [...open.values()].filter((q) => partners(q).length).map((q) => ({ q, dep: depCount(q.id), xp: reward(q) }));
		ranked.sort((a, b) => b.dep - a.dep || b.xp - a.xp || a.q.id - b.q.id);
		for (const { q } of ranked) {
			if (!open.has(q.id)) continue;
			const alts = partners(q);
			if (!alts.length) continue;
			for (const a of alts) open.delete(a);
			branches.push({ kept: q.id, dropped: alts.sort((a, b) => a - b) });
		}
	}
	// Quests open to the character but unreachable: id -> the prerequisite
	// (or parent / child) that blocks them.
	const blockedBy = new Map();
	// Prerequisites: any-of (`pre`) and all-of (`preAll`). Open ones count;
	// ones closed to this character do not apply; ones excluded for missing
	// data (or not reachable) make the quest unreachable: any-of when none is
	// left, all-of when any is blocked.
	let changed = true;
	const preOf = new Map();
	const preAllOf = new Map();
	const blocks = (p) => excludedIds.has(p) || (worldById.has(p) && isOpen(worldById.get(p)));
	while (changed) {
		changed = false;
		for (const q of [...open.values()]) {
			const kept = [];
			let blocked = false;
			for (const p of q.pre) {
				if (open.has(p)) kept.push(p);
				else if (blocks(p)) blocked = true;
			}
			const all = [];
			let allBlocked = false;
			for (const p of q.preAll || []) {
				if (open.has(p)) all.push(p);
				else if (blocks(p)) allBlocked = true;
			}
			// Child quests: the parent must be in the log (inLog); a parent
			// whose turn-in waits for children (after) needs them. A missing
			// one closed to this character does not apply; an excluded one
			// blocks.
			const par = q.inLog != null && !open.has(q.inLog) && blocks(q.inLog);
			const kid = (q.after || []).some((c) => !open.has(c) && blocks(c));
			if ((!kept.length && blocked) || allBlocked || par || kid) {
				open.delete(q.id);
				const by = (!kept.length && blocked && q.pre.find((p) => !open.has(p) && blocks(p))) || (allBlocked && (q.preAll || []).find((p) => !open.has(p) && blocks(p))) || (par && q.inLog) || (q.after || []).find((c) => !open.has(c) && blocks(c));
				blockedBy.set(q.id, by);
				changed = true;
			} else {
				preOf.set(q.id, kept);
				preAllOf.set(q.id, all);
			}
		}
	}
	const quests = [...open.values()].sort((a, b) => a.id - b.id);
	const Q = quests.length;
	const qIndex = new Map(quests.map((q, i) => [q.id, i]));

	// ---- points used by the run ----
	const ptIndex = new Map();
	const ptList = [];
	const usePt = (p) => {
		let i = ptIndex.get(p);
		if (i == null) {
			i = ptList.length;
			ptIndex.set(p, i);
			ptList.push(p);
		}
		return i;
	};

	// ---- tasks and work ----
	const taskPt = [];
	const taskW0 = [];
	const taskW1 = [];
	const wKind = [];
	const wLevel = [];
	const wCount = [];
	const wElite = [];
	const wSpacing = [];
	const wDrop = [];
	const addTask = (t) => {
		const ti = taskPt.length;
		taskPt.push(usePt(t.pt));
		taskW0.push(wKind.length);
		for (const w of t.work) {
			const k = WORK_KIND[w[0]];
			wKind.push(k);
			wLevel.push(k === W_KILL ? Math.max(1, Math.min(MOBL - 1, w[1])) : 0);
			wCount.push(k === W_KILL ? w[2] : k === W_USE ? w[1] : 1);
			wElite.push(k === W_KILL ? w[3] : 0);
			wSpacing.push(k === W_KILL ? w[4] || 0 : 0);
			// Fractional counts come from drop chances (scaled by dropMul).
			wDrop.push(k === W_KILL && !Number.isInteger(w[2]) ? 1 : k === W_USE && !Number.isInteger(w[1]) ? 1 : 0);
		}
		taskW1.push(wKind.length);
		return ti;
	};

	const qLevel = new Int32Array(Q);
	const qMinLevel = new Int32Array(Q);
	const qExcl0 = new Int32Array(Q); // exclusive quests (q.excl): any active or done closes this one
	const qExcl1 = new Int32Array(Q);
	const qTier = new Int32Array(Q);
	const qXp = new Float64Array(Q); // recorded full reward, 0 = estimate, -1 = none (repeatable)
	const qGiver = new Int32Array(Q);
	const qEnder = new Int32Array(Q);
	const qAccept = new Int32Array(Q).fill(-1);
	const qTask0 = new Int32Array(Q);
	const qTask1 = new Int32Array(Q);
	const qPre0 = new Int32Array(Q);
	const qPre1 = new Int32Array(Q);
	const qAll0 = new Int32Array(Q);
	const qAll1 = new Int32Array(Q);
	const qParent = new Int32Array(Q).fill(-1); // must be active to accept (child quests)
	const qAfter0 = new Int32Array(Q);
	const qAfter1 = new Int32Array(Q);
	const afterList = [];
	const allList = [];
	const preList = [];
	const exclList = [];
	quests.forEach((q, i) => {
		qLevel[i] = q.level;
		qMinLevel[i] = q.minLevel;
		qExcl0[i] = exclList.length;
		for (const e of q.excl || []) if (qIndex.has(e)) exclList.push(qIndex.get(e));
		qExcl1[i] = exclList.length;
		qTier[i] = q.tier;
		qXp[i] = q.noXp ? -1 : q.xp || 0;
		qGiver[i] = usePt(q.giver);
		qEnder[i] = usePt(q.ender);
		if (q.accept) qAccept[i] = addTask(q.accept);
		qTask0[i] = taskPt.length;
		for (const t of q.tasks) addTask(t);
		qTask1[i] = taskPt.length;
		qPre0[i] = preList.length;
		for (const p of preOf.get(q.id) || []) preList.push(qIndex.get(p));
		qPre1[i] = preList.length;
		qAll0[i] = allList.length;
		for (const p of preAllOf.get(q.id) || []) allList.push(qIndex.get(p));
		qAll1[i] = allList.length;
		if (q.inLog != null && qIndex.has(q.inLog)) qParent[i] = qIndex.get(q.inLog);
		qAfter0[i] = afterList.length;
		for (const c of q.after || []) if (qIndex.has(c)) afterList.push(qIndex.get(c));
		qAfter1[i] = afterList.length;
	});

	// ---- package steps ----
	const packages = [];
	const sKind = [];
	const sQuest = [];
	const sTask = [];
	const sPt = [];
	const pkgStart = [];
	const pkgEnd = [];
	const W = world.points;
	const wdist = (a, b) => (W[a][1] !== W[b][1] ? Infinity : Math.hypot(W[a][2] - W[b][2], W[a][3] - W[b][3]));
	const KIND = ['accept', 'task', 'turnin'];
	const dungeons = withDungeons ? world.dungeons || [] : [];
	const dQuests = dungeons.map(() => []);
	for (const p of world.packages) {
		if (p.dungeon !== undefined) {
			if (!withDungeons) continue;
			// Fixed order: accepts, the run, turn-ins.
			const steps = [];
			for (const [kind, qid, task, pt] of p.steps) {
				if (kind === K_DUNGEON) {
					steps.push([K_DUNGEON, qid, -1, usePt(pt)]);
					continue;
				}
				const qi = qIndex.get(qid);
				if (qi == null) continue;
				if (kind === K_ACCEPT) dQuests[p.dungeon].push(qi);
				steps.push([kind, qi, kind === K_ACCEPT ? qAccept[qi] : -1, usePt(pt)]);
			}
			pkgStart.push(sKind.length);
			for (const s of steps) {
				sKind.push(s[0]);
				sQuest.push(s[1]);
				sTask.push(s[2]);
				sPt.push(s[3]);
			}
			pkgEnd.push(sKind.length);
			packages.push({ key: p.key, zone: p.zone, zoneName: p.zoneName, band: p.band, levels: p.levels, dungeon: p.dungeon, world: world.packages.indexOf(p) });
			continue;
		}
		// The character's own subset, re-ordered (nearest neighbour + 2-opt).
		const sub = [];
		for (const [kind, qid, task, pt] of p.steps) {
			const qi = qIndex.get(qid);
			if (qi == null) continue;
			const wq = worldById.get(qid);
			sub.push({ kind: KIND[kind], q: qid, task, pt, quest: { pre: (preOf.get(qid) || []).concat(preAllOf.get(qid) || []), inLog: wq.inLog, after: wq.after }, k: kind, qi });
		}
		// Nothing earns XP here; a completionist route still needs the accepts.
		if (!sub.length || (!completionist && !sub.some((s) => s.k === K_TURNIN || s.k === K_TASK))) continue;
		const steps = (completionist ? sliceOrder(sub, worldById, world.bandWidth || 5, wdist) : planOrder(sub, { dist: wdist })).map((s) => [s.k, s.qi, s.k === K_TASK ? qTask0[s.qi] + s.task : s.k === K_ACCEPT ? qAccept[s.qi] : -1, usePt(s.pt)]);
		pkgStart.push(sKind.length);
		for (const s of steps) {
			sKind.push(s[0]);
			sQuest.push(s[1]);
			sTask.push(s[2]);
			sPt.push(s[3]);
		}
		pkgEnd.push(sKind.length);
		packages.push({ key: p.key, zone: p.zone, zoneName: p.zoneName, band: p.band, levels: p.levels, world: world.packages.indexOf(p) });
	}
	// Starting area first (docs/SIMULATION.md "Starts"): home packages are the
	// start zone's first band (1-5); for the Skyborne every Zephras Isle
	// package. A package is "away" when it lies on another continent than the
	// start, or on another starting island (Teldrassil, Zephras Isle): below
	// HOME_LEVEL the character grinds to HOME_LEVEL before going there.
	const startW = W[start.pt];
	const pkgHome = new Uint8Array(packages.length);
	const pkgAway = new Uint8Array(packages.length);
	packages.forEach((pk, i) => {
		const wp = W[ptList[sPt[pkgStart[i]]]];
		if (pk.dungeon === undefined) pkgHome[i] = skyborne ? (ISLE.has(pk.zone) ? 1 : 0) : pk.zone === startW[4] && pk.band === 0 ? 1 : 0;
		pkgAway[i] = wp[0] !== startW[0] || (wp[1] !== startW[1] && (ISLANDS[wp[4]] || 0) !== 0) ? 1 : 0;
	});
	let homeCount = 0;
	for (let i = 0; i < pkgHome.length; i++) homeCount += pkgHome[i];
	// Dungeon quests of this character by dungeon (also those accepted elsewhere).
	const qDungeon = new Int32Array(Q).fill(-1);
	quests.forEach((q, i) => {
		if (q.dungeon !== undefined && withDungeons) {
			qDungeon[i] = q.dungeon;
			if (!dQuests[q.dungeon].includes(i)) dQuests[q.dungeon].push(i);
		}
	});
	for (const d of dungeons) usePt(d.pt);
	const startPt = usePt(start.pt);
	const innRunPt = world.inns.map((n) => usePt(n.pt));

	// ---- point geometry, flight masters and inns at points ----
	const N = world.nodes.length;
	const NP = ptList.length;
	const pC = new Int32Array(NP);
	const pR = new Int32Array(NP);
	const pX = new Float64Array(NP);
	const pY = new Float64Array(NP);
	const pFp = new Int32Array(NP).fill(-1);
	const pInn = new Int32Array(NP).fill(-1);
	const pNear = new Int32Array(NP * NEAR_K).fill(-1);
	const pNearD = new Float64Array(NP * NEAR_K);
	const nodePt = world.nodes.map((n) => W[n.pt]);
	const innPt = world.inns.map((n) => W[n.pt]);
	const pMap = new Int32Array(NP);
	const fpBit = new Int32Array(N).fill(-1);
	let fpCount = 0;
	world.nodes.forEach((n, i) => {
		if (n.kind === 'fp') fpBit[i] = fpCount++;
	});
	if (fpCount > 50) throw new Error(`too many flight paths for the known-set key (${fpCount})`);
	for (let i = 0; i < NP; i++) {
		const p = W[ptList[i]];
		pC[i] = p[0];
		pR[i] = p[1];
		pX[i] = p[2];
		pY[i] = p[3];
		pMap[i] = p[4];
		const near = [];
		for (let n = 0; n < N; n++) {
			const q = nodePt[n];
			if (q[1] !== p[1]) continue;
			const d = Math.hypot(q[2] - p[2], q[3] - p[3]);
			near.push([d, n]);
			if (world.nodes[n].kind === 'fp' && d <= NEAR_HUB && (pFp[i] < 0 || d < near.find((x) => x[1] === pFp[i])[0])) pFp[i] = n;
		}
		near.sort((a, b) => a[0] - b[0] || a[1] - b[1]);
		for (let k = 0; k < NEAR_K && k < near.length; k++) {
			pNear[i * NEAR_K + k] = near[k][1];
			pNearD[i * NEAR_K + k] = near[k][0];
		}
		let bd = NEAR_HUB;
		innPt.forEach((q, n) => {
			if (q[1] !== p[1]) return;
			const d = Math.hypot(q[2] - p[2], q[3] - p[3]);
			if (d <= bd) {
				bd = d;
				pInn[i] = n;
			}
		});
	}
	// Travel safety grid: per region, the zone of each cell and the zones'
	// minimum levels (world.danger / world.zoneMin).
	const zoneMin = new Map(Object.entries(world.zoneMin || {}).map(([m, l]) => [Number(m), l]));
	const danger = new Map();
	for (const g of world.danger || []) danger.set(g.region, { gx0: g.gx0, gy0: g.gy0, nx: g.nx, ny: g.ny, cell: g.cell, z: Int32Array.from(g.z) });

	return {
		faction, race, cls, world,
		start: { pt: startPt, zone: start.zone, quest: start.quest },
		quests, qIndex, Q,
		qLevel, qMinLevel, qExcl0, qExcl1, exclList: Int32Array.from(exclList), qTier, qXp, qGiver, qEnder, qAccept, qTask0, qTask1, qPre0, qPre1, qAll0, qAll1, allList: Int32Array.from(allList),
		qParent, qAfter0, qAfter1, afterList: Int32Array.from(afterList),
		preList: Int32Array.from(preList),
		taskPt: Int32Array.from(taskPt), taskW0: Int32Array.from(taskW0), taskW1: Int32Array.from(taskW1),
		wKind: Int32Array.from(wKind), wLevel: Int32Array.from(wLevel), wCount: Float64Array.from(wCount),
		wElite: Int32Array.from(wElite), wSpacing: Float64Array.from(wSpacing), wDrop: Int32Array.from(wDrop),
		packages, P: packages.length,
		pkgStart: Int32Array.from(pkgStart), pkgEnd: Int32Array.from(pkgEnd),
		sKind: Int32Array.from(sKind), sQuest: Int32Array.from(sQuest), sTask: Int32Array.from(sTask), sPt: Int32Array.from(sPt),
		ptList, ptIndex, pC, pR, pX, pY, pMap, pFp, pInn, pNear, pNearD,
		pkgHome, pkgAway, homeCount, homeLevel: HOME_LEVEL, zoneMin, danger,
		innPt: Int32Array.from(innRunPt),
		N, fpBit, fpCount,
		nodes: world.nodes, nodeR: Int32Array.from(nodePt.map((p) => p[1])), nodeC: Int32Array.from(nodePt.map((p) => p[0])),
		nodeX: Float64Array.from(nodePt.map((p) => p[2])), nodeY: Float64Array.from(nodePt.map((p) => p[3])),
		taxi: world.taxi, rides: world.rides,
		grindSpacing: Float64Array.from(world.grind.spacing),
		questXpRows: world.questXp,
		family,
		completionist,
		branches,
		blockedBy,
		dungeons: dungeons.map((d, i) => ({ name: d.name, min: d.min, max: d.max, pt: ptIndex.get(d.pt), bosses: Int32Array.from(d.bosses), bossCount: d.bossCount, quests: Int32Array.from(dQuests[i]) })),
		qDungeon,
	};
}

// Parameter-dependent tables for a run.
function makeTables(run, p) {
	const t = {
		p,
		killT: new Float64Array(61 * MOBL),
		killX: new Float64Array(61 * MOBL),
		qFull: new Float64Array(run.Q),
		grindRate: new Float64Array(62),
		detour: (c) => (c === 0 ? p.detour0 : c === 1 ? p.detour1 : (p.detour0 + p.detour1) / 2),
	};
	for (let L = 1; L <= 60; L++) {
		const base = p.killSec1 + ((p.killSec60 - p.killSec1) * (L - 1)) / 59;
		for (let M = 0; M < MOBL; M++) {
			const d = M - L;
			const f = d >= 0 ? 1 + p.killUp * d : Math.max(0.5, 1 + p.killDown * d);
			t.killT[L * MOBL + M] = base * f * p.classFactor;
			t.killX[L * MOBL + M] = mobXp(L, M) * (1 + p.restedShare);
		}
		// Grinding: best of mobs at Δ = 0..+2, with the camp spacing of that level.
		let best = 0;
		for (let d = 0; d <= 2; d++) {
			const M = Math.min(MOBL - 1, L + d);
			const sec = t.killT[L * MOBL + M] + (run.grindSpacing[Math.min(run.grindSpacing.length - 1, M)] * p.spacing) / p.runSpeed;
			const rate = t.killX[L * MOBL + M] / sec;
			if (rate > best) best = rate;
		}
		t.grindRate[L] = best * p.grindEff;
	}
	const rows = run.questXpRows;
	for (let i = 0; i < run.Q; i++) {
		if (run.qXp[i] < 0) t.qFull[i] = 0; // repeatable without a recorded reward
		else if (run.qXp[i] > 0) t.qFull[i] = run.qXp[i] * p.questXpScale;
		else {
			const row = rows[Math.max(1, Math.min(rows.length - 1, run.qLevel[i]))] || rows[60];
			t.qFull[i] = (row[run.qTier[i]] || 0) * p.questEstScale * p.questXpScale;
		}
	}
	return t;
}

module.exports = {
	compileRun, makeTables, sliceOrder, questOpen, onIsle, raceBit, popcount, K_ACCEPT, K_TASK, K_TURNIN, K_GRIND, K_DUNGEON, W_KILL, W_USE, W_ESCORT, W_BUY, NEAR_K, MOBL,
};
