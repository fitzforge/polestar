'use strict';
// Route evaluation (docs/SIMULATION.md §3). Deterministic for given params.
//
//   const ev = new Evaluator(run, tables);
//   ev.evaluate(route)            -> { seconds, timeTo, levelTimes, xpSplit, travelSeconds, ... }
//   ev.evaluate(route, { detail: true })  adds perPackage[] and the zone visits
//   ev.evaluateSequence(steps)    a baseline sequence (see compileSequence)
//
// A route is an ordered list of run package indices. The character starts at
// level 1 at its race's start. Per step (accept / objective site / turn-in):
//   - travel there (walk, or walk + flights/boats + walk, or hearthstone);
//     walking across zones 5+ levels above the character costs `deathRisk`
//     per zone (travel.js); a place the character cannot reach (e.g. back
//     to Zephras Isle, whose exits are one way) skips the step (counted);
//   - a flight master within 200 yd is learned, an inn within 200 yd becomes
//     the hearthstone's bind point;
//   - accept: needs the quest not done, none of its exclusive quests (its
//     own `excl`, one way) taken or done, one prerequisite (any-of) turned
//     in earlier; below minLevel the character grinds first (counted).
//     Quest-starting items cost their expected kills.
//   - objective site: only for accepted quests; kills give XP at the level
//     they happen; level-ups mid-way switch rates.
//   - turn-in: accepted quest with all its sites done; XP reduced by level.
// A package runs at most MAX_VISITS times (COMPLETIONIST_MAX_VISITS on a
// completionist run: its chains bounce between zones more often, the Western
// Plaguelands cauldrons between the Bulwark and the fields five times); a
// return does only what opened since (quest chains that go to another zone
// and back: Scholomance and the Argent Dawn turn-ins, Loramus in Azshara); a
// home package runs once. More makes the route infeasible. Route
// rules (packages only, not guide sequences; docs/SIMULATION.md "Starts"):
//   - home first: every home package (start zone 1-5; Skyborne: Zephras
//     Isle) before any other package, else the route is infeasible;
//   - an "away" package (other continent / starting island) below level 10:
//     the character grinds to 10 first;
//   - catch-up (opts.catchUp, robustness only): a package where nothing could
//     be done because every available quest was above the level gate: the
//     character grinds to the gate's level and runs it again (a route
//     followed as a plan, under-levelled). Off in search, where it would
//     turn the gate into "grind anywhere".
// After the last package the character grinds to 60 at the best site for its level.
//
// Completionist runs (run.completionist, docs/SIMULATION.md "Completionist"):
// reaching 60 does not end the route (`capped`: no more XP, quests still
// count), nothing is ground after the last package, and the route's cost is
// the time to its last step plus the policies: grinding and zone changes as
// above, `greyWeight` × the time to grind back the XP quests lost by being
// turned in above their level (`greySec`, all of it at 60), `missWeight`
// per quest of the run (the eligible set) left undone, and `returnWeight`
// per return to a package already run (`returns`): a zone visit does what it
// can in one go, and comes back only when that clearly pays.

const { Travel } = require('./travel');
const { MOBL, K_ACCEPT, K_TASK, K_TURNIN, K_GRIND, K_DUNGEON, W_KILL, W_USE, W_ESCORT, W_BUY } = require('./run');
const { LEVEL_XP, mobXp } = require('../game/xp');

const SHARE = new Float64Array(64);
for (let d = 0; d < 64; d++) SHARE[d] = d <= 5 ? 1 : d >= 10 ? 0.1 : [0.8, 0.6, 0.4, 0.2][d - 6];

// Journal array ids
const J_DONE = 0;
const J_ACTIVE = 1;
const J_TASK = 2;
const J_KNOWN = 3;
const J_PKG = 4;
const J_DUNGEON = 5;
const J_VISIT = 6; // a counter (returns to the package), undone by decrement

const MAX_VISITS = 3;
const COMPLETIONIST_MAX_VISITS = 6;
// Runs package p may have on route `run`.
const maxVisits = (run) => (run.completionist ? COMPLETIONIST_MAX_VISITS : MAX_VISITS);

class Evaluator {
	constructor(run, tables, opts = {}) {
		this.run = run;
		this.setTables(tables, opts);
		this.done = new Uint8Array(run.Q);
		this.active = new Uint8Array(run.Q);
		this.taskDone = new Uint8Array(run.taskPt.length);
		this.known = new Uint8Array(run.N);
		this.usedPkg = new Uint8Array(run.P);
		this.returns1 = new Uint8Array(run.P); // returns to the package after its first run
		this.maxReturns = maxVisits(run) - 1;
		this.dungeonDone = new Uint8Array(Math.max(1, (run.dungeons || []).length));
		// Steps of the package being run whose accept (or dungeon) was deferred
		// as too low: sized for the longest package.
		let maxSteps = 0;
		for (let p = 0; p < run.P; p++) if (run.pkgEnd[p] - run.pkgStart[p] > maxSteps) maxSteps = run.pkgEnd[p] - run.pkgStart[p];
		this.pending = new Int32Array(maxSteps);
		this.levelTimes = new Float64Array(61);
		// Undo journal (for trial moves during construction / local search).
		this.jArr = new Int32Array(1 << 16);
		this.jIdx = new Int32Array(1 << 16);
		this.jLen = 0;
		this.journaling = false;
		this.detail = null;
		this.gateNeed = 99;
		this.hook = null;
		this.onEvent = null; // exports: ('grind' | 'fp' | 'bind' | 'hearth', info)
		this.catchUp = !!opts.catchUp;
	}

	setTables(tables, opts = {}) {
		this.t = tables;
		this.p = tables.p;
		this.travel = new Travel(this.run, tables, opts);
	}

	// ---- state ----
	reset() {
		const r = this.run;
		this.done.fill(0);
		this.active.fill(0);
		this.taskDone.fill(0);
		this.known.fill(0);
		this.usedPkg.fill(0);
		this.returns1.fill(0);
		this.dungeonDone.fill(0);
		this.levelTimes.fill(0);
		this.jLen = 0;
		this.time = 0;
		this.level = 1;
		this.xp = 0;
		this.pos = r.start.pt;
		this.mask = 0;
		this.mounted = false;
		this.D = this.travel.base[0];
		this.bind = -1;
		this.hearthReady = 0;
		this.xpQuest = 0;
		this.xpKill = 0;
		this.xpGrind = 0;
		this.travelSec = 0;
		this.grindSec = 0;
		this.questsDone = 0;
		this.finished = false;
		this.infeasible = false;
		this.hearths = 0;
		this.flights = 0;
		this.xpDungeon = 0;
		this.dungeonSec = 0;
		this.dungeonsRun = 0;
		this.homeLeft = r.homeCount || 0;
		this.unreachable = 0;
		this.riskCrossings = 0;
		this.steps = 0;
		this.catchUpSec = 0;
		this.zoneChanges = 0;
		this.returns = 0;
		this.awayPending = false;
		this.capped = false;
		this.xpLost = 0;
		this.greySec = 0;
		this.greyQuests = 0;
	}

	snapshot() {
		return {
			j: this.jLen, time: this.time, level: this.level, xp: this.xp, pos: this.pos, mask: this.mask, mounted: this.mounted, D: this.D,
			bind: this.bind, hearthReady: this.hearthReady, xpQuest: this.xpQuest, xpKill: this.xpKill, xpGrind: this.xpGrind,
			travelSec: this.travelSec, grindSec: this.grindSec, questsDone: this.questsDone, finished: this.finished,
			infeasible: this.infeasible, hearths: this.hearths, flights: this.flights, levelFrom: this.level,
			xpDungeon: this.xpDungeon, dungeonSec: this.dungeonSec, dungeonsRun: this.dungeonsRun,
			homeLeft: this.homeLeft, unreachable: this.unreachable, riskCrossings: this.riskCrossings, steps: this.steps, catchUpSec: this.catchUpSec,
			zoneChanges: this.zoneChanges, returns: this.returns, capped: this.capped, xpLost: this.xpLost, greySec: this.greySec, greyQuests: this.greyQuests,
		};
	}

	restore(s) {
		// Undo journaled writes back to the snapshot.
		const arrs = [this.done, this.active, this.taskDone, this.known, this.usedPkg, this.dungeonDone, this.returns1];
		for (let k = this.jLen - 1; k >= s.j; k--) {
			if (this.jArr[k] === J_VISIT) this.returns1[this.jIdx[k]]--;
			else arrs[this.jArr[k]][this.jIdx[k]] ^= 1;
		}
		this.jLen = s.j;
		for (let l = s.level + 1; l <= 60; l++) this.levelTimes[l] = 0;
		this.time = s.time;
		this.level = s.level;
		this.xp = s.xp;
		this.pos = s.pos;
		this.mask = s.mask;
		this.mounted = s.mounted;
		this.D = s.D;
		this.bind = s.bind;
		this.hearthReady = s.hearthReady;
		this.xpQuest = s.xpQuest;
		this.xpKill = s.xpKill;
		this.xpGrind = s.xpGrind;
		this.travelSec = s.travelSec;
		this.grindSec = s.grindSec;
		this.questsDone = s.questsDone;
		this.finished = s.finished;
		this.infeasible = s.infeasible;
		this.hearths = s.hearths;
		this.flights = s.flights;
		this.xpDungeon = s.xpDungeon;
		this.dungeonSec = s.dungeonSec;
		this.dungeonsRun = s.dungeonsRun;
		this.homeLeft = s.homeLeft;
		this.unreachable = s.unreachable;
		this.riskCrossings = s.riskCrossings;
		this.steps = s.steps;
		this.catchUpSec = s.catchUpSec;
		this.zoneChanges = s.zoneChanges;
		this.returns = s.returns;
		this.capped = s.capped;
		this.xpLost = s.xpLost;
		this.greySec = s.greySec;
		this.greyQuests = s.greyQuests;
	}

	// Flip a 0 flag to 1, journaled when trial moves are active.
	set1(arrId, arr, i) {
		arr[i] = 1;
		if (this.journaling) this.journal(arrId, i);
	}
	journal(arrId, i) {
		if (this.jLen >= this.jArr.length) {
			const a = new Int32Array(this.jArr.length * 2);
			a.set(this.jArr);
			this.jArr = a;
			const b = new Int32Array(this.jIdx.length * 2);
			b.set(this.jIdx);
			this.jIdx = b;
		}
		this.jArr[this.jLen] = arrId;
		this.jIdx[this.jLen++] = i;
	}
	// Turn-off of `active` at turn-in: journaled as a flip too.
	set0Active(i) {
		this.active[i] = 0;
		if (this.journaling) {
			this.jArr[this.jLen] = J_ACTIVE;
			this.jIdx[this.jLen++] = i;
			if (this.jLen >= this.jArr.length - 4) this.set1Grow();
		}
	}
	set1Grow() {
		const a = new Int32Array(this.jArr.length * 2);
		a.set(this.jArr);
		this.jArr = a;
		const b = new Int32Array(this.jIdx.length * 2);
		b.set(this.jIdx);
		this.jIdx = b;
	}

	// ---- XP and levels ----
	levelUp() {
		this.xp -= LEVEL_XP[this.level];
		this.level++;
		this.levelTimes[this.level] = this.time;
		if (this.level >= 60) {
			this.level = 60;
			this.xp = 0;
			// A completionist route goes on at 60 for the quests left.
			if (this.run.completionist) this.capped = true;
			else this.finished = true;
			return;
		}
		this.time += this.p.levelOverhead;
		if (!this.mounted && this.level >= this.p.mountLevel) {
			this.mounted = true;
			this.D = this.travel.matrixFor(this.mask, true);
		}
	}

	gain(amount) {
		if (this.capped) return;
		this.xp += amount;
		while (!this.finished && !this.capped && this.xp >= LEVEL_XP[this.level]) this.levelUp();
	}

	// Grind until `level` (+ xpInto) at the best site for the current level.
	grindTo(level, xpInto = 0) {
		const g = this.t.grindRate;
		const t0 = this.time;
		const l0 = this.level + this.xp / LEVEL_XP[this.level];
		while (!this.finished && (this.level < level || (this.level === level && this.xp < xpInto))) {
			const target = this.level < level ? LEVEL_XP[this.level] : xpInto;
			const need = target - this.xp;
			if (need <= 0) break;
			const sec = need / g[this.level];
			this.time += sec;
			this.grindSec += sec;
			this.xpGrind += need;
			this.gain(need);
		}
		// Exports (onEvent): where and how long the character ground.
		if (this.onEvent && this.time > t0) this.onEvent('grind', { pt: this.pos, from: l0, to: this.level + (this.level < 60 ? this.xp / LEVEL_XP[this.level] : 0), seconds: this.time - t0 });
	}

	// ---- travel ----
	learnAt(pt) {
		const r = this.run;
		const fp = r.pFp[pt];
		if (fp >= 0 && !this.known[fp]) {
			this.set1(J_KNOWN, this.known, fp);
			this.mask += 2 ** r.fpBit[fp];
			this.D = this.travel.matrixFor(this.mask, this.mounted);
			this.time += this.p.talkSec;
			if (this.onEvent) this.onEvent('fp', { node: fp, pt });
		}
		const inn = r.pInn[pt];
		if (inn >= 0) {
			if (this.onEvent && inn !== this.bind) this.onEvent('bind', { inn, pt });
			this.bind = inn;
		}
	}

	// Travel to pt. Returns false (nothing changes) when pt cannot be reached.
	// The first move of an "away" package below level 10 grinds to 10 first.
	moveTo(pt) {
		if (this.awayPending) {
			this.awayPending = false;
			if (this.level < this.run.homeLevel) this.grindTo(this.run.homeLevel);
		}
		if (pt === this.pos) return true;
		const tr = this.travel;
		let c = tr.leg(this.pos, pt, this.D, this.mounted, this.level);
		const mode = tr.lastMode;
		let risk = tr.lastRisk;
		// Hearthstone when ready and clearly cheaper.
		if (this.bind >= 0 && this.time >= this.hearthReady && c > 120) {
			const from = this.run.innPt[this.bind];
			const h = this.p.hearthCast + tr.leg(from, pt, this.D, this.mounted, this.level);
			if (h + 30 < c) {
				c = h;
				risk = tr.lastRisk;
				this.hearthReady = this.time + this.p.hearthCooldown;
				this.hearths++;
				if (this.onEvent) this.onEvent('hearth', { inn: this.bind, pt });
			} else if (mode === 1) this.flights++;
		} else if (mode === 1) this.flights++;
		if (c === Infinity) return false;
		this.riskCrossings += risk;
		this.time += c;
		this.travelSec += c;
		if (this.run.pMap[pt] !== this.run.pMap[this.pos]) this.zoneChanges++;
		this.pos = pt;
		this.learnAt(pt);
		return true;
	}

	// ---- work ----
	doWork(task) {
		const r = this.run;
		const p = this.p;
		const t = this.t;
		const w1 = r.taskW1[task];
		for (let w = r.taskW0[task]; w < w1 && !this.finished; w++) {
			const kind = r.wKind[w];
			if (kind === W_KILL) {
				let n = r.wCount[w] * (1 + p.extraKill);
				if (r.wDrop[w]) n /= p.dropMul;
				const M = r.wLevel[w];
				const elite = r.wElite[w] === 1;
				const walk = (r.wSpacing[w] * p.spacing) / (p.runSpeed * (this.mounted ? 1 : 1));
				while (n > 0 && !this.finished) {
					const L = this.level;
					const xpPer = this.capped ? 0 : t.killX[L * MOBL + M] * (elite ? 2 : 1);
					const tPer = t.killT[L * MOBL + M] * (elite ? p.eliteTime : 1) + walk;
					if (xpPer <= 0) {
						this.time += n * tPer;
						break;
					}
					const k = Math.ceil((LEVEL_XP[L] - this.xp) / xpPer);
					if (k >= n) {
						this.time += n * tPer;
						this.xpKill += n * xpPer;
						this.xp += n * xpPer;
						n = 0;
						if (this.xp >= LEVEL_XP[L]) this.gain(0);
					} else {
						this.time += k * tPer;
						this.xpKill += k * xpPer;
						this.gain(k * xpPer);
						n -= k;
					}
				}
			} else if (kind === W_USE) {
				let n = r.wCount[w];
				if (r.wDrop[w]) n /= p.dropMul;
				this.time += n * p.interactSec;
			} else if (kind === W_ESCORT) this.time += p.escortSec;
			else if (kind === W_BUY) this.time += p.talkSec;
		}
	}

	prereqOk(q) {
		const r = this.run;
		// A child quest is offered only while its parent is in the log.
		if (r.qParent[q] >= 0 && !this.active[r.qParent[q]]) return false;
		// Closed by an exclusive quest taken or done.
		for (let i = r.qExcl0[q]; i < r.qExcl1[q]; i++) if (this.active[r.exclList[i]] || this.done[r.exclList[i]]) return false;
		for (let i = r.qAll0[q]; i < r.qAll1[q]; i++) if (!this.done[r.allList[i]]) return false;
		const a = r.qPre0[q];
		const b = r.qPre1[q];
		if (a === b) return true;
		for (let i = a; i < b; i++) if (this.done[r.preList[i]]) return true;
		return false;
	}

	// One step. With `this.defer`, an accept above the character's level is
	// deferred (runPackage takes it once the level allows) instead of grinding for it.
	step(kind, q, task, pt) {
		const r = this.run;
		if (kind === K_ACCEPT) {
			if (this.done[q] || this.active[q] || !this.prereqOk(q)) return;
			// Too low for the quest (minimum level, or quest level more than
			// `dangerGap` above: red quests whose mobs would kill the character).
			const low = this.level < r.qMinLevel[q] || this.level + this.p.dangerGap < r.qLevel[q];
			if (this.defer && low) {
				this.deferred++;
				return;
			}
			// Grinding fills gaps only: a quest more than `gateGap` levels
			// above the character is not available yet (skipped; the level it
			// opens at is kept for the package's catch-up).
			const opens = Math.max(r.qMinLevel[q] - this.p.gateGap, r.qLevel[q] - this.p.dangerGap - this.p.gateGap);
			if (this.level < opens) {
				if (opens < this.gateNeed) this.gateNeed = opens;
				return;
			}
			if (!this.moveTo(pt)) {
				this.unreachable++;
				return;
			}
			if (this.level < r.qMinLevel[q]) this.grindTo(r.qMinLevel[q]);
			if (this.level + this.p.dangerGap < r.qLevel[q]) this.grindTo(r.qLevel[q] - this.p.dangerGap);
			if (task >= 0) this.doWork(task);
			this.time += this.p.talkSec;
			this.set1(J_ACTIVE, this.active, q);
		} else if (kind === K_TASK) {
			if (!this.active[q] || this.taskDone[task]) return;
			if (!this.moveTo(pt)) {
				this.unreachable++;
				return;
			}
			this.doWork(task);
			this.set1(J_TASK, this.taskDone, task);
		} else if (kind === K_TURNIN) {
			if (!this.active[q]) return;
			for (let i = r.qTask0[q]; i < r.qTask1[q]; i++) if (!this.taskDone[i]) return;
			// A parent whose objective items are its children's rewards.
			for (let i = r.qAfter0[q]; i < r.qAfter1[q]; i++) if (!this.done[r.afterList[i]]) return;
			if (!this.moveTo(pt)) {
				this.unreachable++;
				return;
			}
			this.time += this.p.talkSec;
			const d = this.level - r.qLevel[q];
			const share = this.capped ? 0 : SHARE[d < 0 ? 0 : d > 63 ? 63 : d];
			const xp = this.t.qFull[q] * share;
			if (share < 1 && this.run.completionist) {
				const lost = this.t.qFull[q] - xp;
				this.xpLost += lost;
				this.greySec += lost / this.t.grindRate[Math.max(1, Math.min(60, r.qLevel[q]))];
				this.greyQuests++;
			}
			this.set0Active(q);
			this.set1(J_DONE, this.done, q);
			this.questsDone++;
			this.xpQuest += xp;
			this.gain(xp);
		} else if (kind === K_DUNGEON) {
			if (!this.runDungeon(q, pt)) return;
		}
		this.steps++;
		if (this.hook) this.hook(kind, q, pt);
	}

	// A dungeon run (q = dungeon index): travel to the entrance, form a group,
	// clear it. XP: `dungeonTrash` elite trash kills at the dungeon's middle
	// level plus its bosses, elites ×2, each kill shared by a 5-player party
	// (`partyShare` of the solo value). Completes the objectives of every
	// dungeon quest the character has active there. Once per route.
	runDungeon(d, pt) {
		const r = this.run;
		const dg = r.dungeons[d];
		const p = this.p;
		if (this.dungeonDone[d]) return false;
		if (this.defer && this.level < dg.min) {
			this.deferred++;
			return false;
		}
		if (this.level + p.gateGap < dg.min) {
			if (dg.min - p.gateGap < this.gateNeed) this.gateNeed = dg.min - p.gateGap;
			return false;
		}
		if (!this.moveTo(pt)) {
			this.unreachable++;
			return false;
		}
		if (this.level < dg.min) this.grindTo(dg.min);
		const mid = (dg.min + dg.max) / 2;
		const runMin = p.dungeonRunLow + ((p.dungeonRunHigh - p.dungeonRunLow) * Math.max(0, Math.min(1, (mid - 15) / 40)));
		this.time += (p.dungeonFormUp + runMin) * 60;
		this.dungeonSec += (p.dungeonFormUp + runMin) * 60;
		const trashLevel = Math.max(1, Math.round(mid));
		let xp = p.dungeonTrash * mobXp(this.level, trashLevel, true);
		for (let i = 0; i < dg.bosses.length; i++) xp += mobXp(this.level, dg.bosses[i], true);
		// Bosses without a known level count at the dungeon's top level.
		for (let i = dg.bosses.length; i < dg.bossCount; i++) xp += mobXp(this.level, dg.max, true);
		xp *= p.partyShare;
		this.xpKill += xp;
		this.xpDungeon += xp;
		this.set1(J_DUNGEON, this.dungeonDone, d);
		for (let k = 0; k < dg.quests.length; k++) {
			const qi = dg.quests[k];
			if (!this.active[qi]) continue;
			for (let t = r.qTask0[qi]; t < r.qTask1[qi]; t++) if (!this.taskDone[t]) this.set1(J_TASK, this.taskDone, t);
		}
		this.dungeonsRun++;
		this.gain(xp);
		return true;
	}

	// Whether package p may run next: home packages first, once each; any
	// other package up to maxVisits(run) times (usedPkg, then returns1).
	canVisit(p) {
		const r = this.run;
		if (this.homeLeft > 0 && !r.pkgHome[p]) return false;
		if (!this.usedPkg[p]) return true;
		return !r.pkgHome[p] && this.returns1[p] < this.maxReturns;
	}

	// Run package p: its steps in tour order. An accept (or dungeon) above the
	// character's level is deferred and taken as soon as the level allows it,
	// within the same pass: the tour orders by place, not level, and leaving
	// every deferred step to a second pass walked the whole tour and back for
	// them (Durotar: Razor Hill at level 2, then back into the Valley of
	// Trials). If anything was deferred, a second pass does what is left
	// (still too low: grinding first).
	// Route rules (home first, away below level 10, catch-up): see the top.
	// Returns false when the route is infeasible (a package run more than
	// maxVisits(run) times or a home package twice, or a non-home package while
	// home packages are left).
	runPackage(p) {
		const r = this.run;
		if (!this.canVisit(p)) {
			this.infeasible = true;
			return false;
		}
		if (!this.usedPkg[p]) {
			this.set1(J_PKG, this.usedPkg, p);
			if (r.pkgHome[p]) this.homeLeft--;
		} else {
			this.returns++;
			this.returns1[p]++;
			if (this.journaling) this.journal(J_VISIT, p);
		}
		// Away below level 10: grind to 10 before the package's first move
		// (moveTo), so a package that does nothing grinds nothing.
		this.awayPending = r.pkgAway[p] === 1 && this.level < r.homeLevel;
		const e = r.pkgEnd[p];
		const before = this.steps;
		this.gateNeed = 99;
		this.defer = true;
		this.deferred = 0;
		const pend = this.pending;
		let np = 0;
		for (let s = r.pkgStart[p]; s < e && !this.finished; s++) {
			const d0 = this.deferred;
			this.step(r.sKind[s], r.sQuest[s], r.sTask[s], r.sPt[s]);
			if (this.deferred > d0) pend[np++] = s;
			else if (np) np = this.retryDeferred(np, r.pkgStart[p], s);
		}
		this.defer = false;
		if (this.deferred) for (let s = r.pkgStart[p]; s < e && !this.finished; s++) this.step(r.sKind[s], r.sQuest[s], r.sTask[s], r.sPt[s]);
		if (this.catchUp && this.steps === before && this.gateNeed < 99 && !this.finished) {
			const t0 = this.time;
			this.grindTo(this.gateNeed);
			this.catchUpSec += this.time - t0;
			for (let s = r.pkgStart[p]; s < e && !this.finished; s++) this.step(r.sKind[s], r.sQuest[s], r.sTask[s], r.sPt[s]);
		}
		this.awayPending = false;
		return true;
	}

	// Take the deferred steps (this.pending[0..np)) whose level gate is now
	// open, in tour order; a quest taken this way catches up on the steps the
	// tour already passed (catchUpPassed). -> how many are still deferred
	// (kept in order).
	retryDeferred(np, s0, s) {
		const r = this.run;
		const pend = this.pending;
		let kept = 0;
		for (let i = 0; i < np && !this.finished; i++) {
			const t = pend[i];
			const kind = r.sKind[t];
			const q = r.sQuest[t];
			const open = kind === K_DUNGEON ? this.level >= r.dungeons[q].min : this.level >= r.qMinLevel[q] && this.level + this.p.dangerGap >= r.qLevel[q];
			if (!open) {
				pend[kept++] = t;
				continue;
			}
			this.step(kind, q, r.sTask[t], r.sPt[t]);
			if (kind === K_ACCEPT && this.active[q]) this.catchUpPassed(q, s0, s);
		}
		return kept;
	}

	// Quest q was taken late: its objectives and turn-in that the tour
	// already passed (steps s0..s) are done right away, from its giver, not
	// in a second pass from wherever the tour ends (Durotar 6-10: back to the
	// Razormane camp for Encroachment); so are passed accepts its turn-in
	// opens (Lazy Peons -> Thazz'ril's Pick, same foreman), each in turn.
	catchUpPassed(q, s0, s) {
		const r = this.run;
		for (let u = s0; u <= s && !this.finished; u++) {
			const k = r.sKind[u];
			if (r.sQuest[u] === q && (k === K_TASK || k === K_TURNIN)) this.step(k, q, r.sTask[u], r.sPt[u]);
		}
		if (!this.done[q]) return;
		for (let u = s0; u <= s && !this.finished; u++) {
			if (r.sKind[u] !== K_ACCEPT) continue;
			const n = r.sQuest[u];
			if (this.done[n] || this.active[n] || this.level < r.qMinLevel[n] || this.level + this.p.dangerGap < r.qLevel[n] || !this.prereqOk(n)) continue;
			this.step(K_ACCEPT, n, r.sTask[u], r.sPt[u]);
			if (this.active[n]) this.catchUpPassed(n, s0, s);
		}
	}

	finish() {
		if (!this.finished && !this.run.completionist) this.grindTo(60);
	}

	result(extra = {}) {
		const timeTo = {};
		for (let l = 10; l <= 60; l += 10) timeTo[l] = this.levelTimes[l];
		return {
			seconds: this.run.completionist ? this.time : this.levelTimes[60] || this.time,
			feasible: !this.infeasible,
			timeTo,
			levelTimes: Array.from(this.levelTimes),
			xpSplit: { quest: Math.round(this.xpQuest), kill: Math.round(this.xpKill), grind: Math.round(this.xpGrind) },
			travelSeconds: this.travelSec,
			grindSeconds: this.grindSec,
			questsDone: this.questsDone,
			hearths: this.hearths,
			flights: this.flights,
			dungeonsRun: this.dungeonsRun,
			dungeonSeconds: this.dungeonSec,
			xpDungeon: Math.round(this.xpDungeon),
			unreachable: this.unreachable,
			riskCrossings: this.riskCrossings,
			catchUpSeconds: this.catchUpSec,
			zoneChanges: this.zoneChanges,
			...(this.run.completionist ? { missed: this.run.Q - this.questsDone, xpLost: Math.round(this.xpLost), greySeconds: this.greySec, greyQuests: this.greyQuests } : {}),
			...extra,
		};
	}

	// Full evaluation of a route. opts.detail: per-package records.
	evaluate(route, opts = {}) {
		this.reset();
		const per = opts.detail ? [] : null;
		let used = 0;
		for (let i = 0; i < route.length && !this.finished; i++) {
			const s = per ? this.snapshot() : null;
			if (!this.runPackage(route[i])) break;
			used = i + 1;
			if (per) per.push(this.packageRecord(route[i], s));
		}
		if (this.infeasible) return this.result({ seconds: Infinity, used, perPackage: per || undefined });
		this.finish();
		return this.result({ used, perPackage: per || undefined });
	}

	// Fast path for search: the route's cost (Infinity when infeasible), its
	// time to 60 with every hour of grinding counted `grindWeight` times and
	// every move into another zone counted `zoneChange` seconds more (both
	// policies: routes level by quests, take a hub's quests and do them in one
	// go, and switch zones when it is clearly worth it; with neither, the
	// search ground or flew across continents wherever that saved a minute).
	// Reported times (evaluate) stay real. Completionist runs: see the top
	// (policyCost). The number of packages used is left in this.lastUsed.
	cost(route) {
		this.reset();
		let used = 0;
		for (let i = 0; i < route.length && !this.finished; i++) {
			if (!this.runPackage(route[i])) {
				this.lastUsed = i;
				return Infinity;
			}
			used = i + 1;
		}
		this.finish();
		this.lastUsed = used;
		return this.policyCost();
	}

	// The cost of the state reached (after finish()).
	policyCost() {
		const p = this.p;
		const policy = ((p.grindWeight || 1) - 1) * this.grindSec + (p.zoneChange || 0) * this.zoneChanges;
		if (this.run.completionist) return this.time + policy + (p.greyWeight || 0) * this.greySec + (p.missWeight || 0) * (this.run.Q - this.questsDone) + (p.returnWeight || 0) * this.returns;
		return (this.levelTimes[60] || this.time) + policy;
	}

	packageRecord(p, s) {
		const r = this.run;
		const pk = r.packages[p];
		return {
			pkg: p, key: pk.key, zone: pk.zoneName,
			arrive: s.time, leave: this.time,
			levelIn: s.level + (s.level < 60 ? s.xp / LEVEL_XP[s.level] : 0), levelOut: this.level + (this.level < 60 ? this.xp / LEVEL_XP[this.level] : 0),
			xpQuest: this.xpQuest - s.xpQuest, xpKill: this.xpKill - s.xpKill, grind: this.grindSec - s.grindSec,
			travel: this.travelSec - s.travelSec, quests: this.questsDone - s.questsDone, dungeon: this.dungeonSec - s.dungeonSec,
			catchUp: this.catchUpSec - s.catchUpSec, risk: this.riskCrossings - s.riskCrossings,
		};
	}

	// A compiled sequence: Int32Array quadruples [kind, q, task, pt] (K_GRIND: q = level, task = xp into level).
	// opts: honorCheckpoints (grind to `level` steps); grinds out to 60 after the last step.
	evaluateSequence(seq, opts = {}) {
		this.reset();
		const n = seq.kind.length;
		for (let i = 0; i < n && !this.finished; i++) {
			const k = seq.kind[i];
			if (k === K_GRIND) {
				if (opts.honorCheckpoints) this.grindTo(seq.q[i], seq.task[i]);
				continue;
			}
			this.step(k, seq.q[i], seq.task[i], seq.pt[i]);
		}
		const endLevel = this.level + (this.level < 60 ? this.xp / LEVEL_XP[this.level] : 0);
		const endTime = this.time;
		const endQuests = this.questsDone;
		const endGrind = this.grindSec;
		const endTravel = this.travelSec;
		this.finish();
		return this.result({ endLevel, endTime, endQuests, endGrind, endTravel });
	}
}

module.exports = { Evaluator, SHARE, MAX_VISITS, maxVisits };
