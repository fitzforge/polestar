'use strict';
// The flow audit's walk (docs/ROUTE-FEEL.md): one start x class branch played through the compiled guides, start to
// end, as a list of goal entries with positions, clock and level. The strict walk does exactly the guide's lines; the
// dynamic walk (Dynamic Questing, `dyn` "036" or "037") is a player who also takes the "While you're here" lines the
// addon shows (addon/Polestar/Core/Engine.lua, Own.hereBuild / hereFits / hereTick / hereBlocked, with its radius and
// rules).
//
// `along` lists get no special treatment: each along goal is pending work, done where the walk first passes it (its
// nearest spawn spot, or its NPC within the spot's radius, on a later walked leg before its label step), as a step
// with that goal at that spot placed right before the step whose walk passed it. Work the walk never passes is done
// right before its label step (or the quest's turn-in, or at the guide's end), nearest first. So an along list and the
// same goals written as a step where the walk passes them score the same.

const { WALK_YPS, FLY_YPS, XP_TO_LEVEL, KILL_XP_FACTOR, dist, decodeLeg, mobXp, questXp, parseSpots, pyRound } = require('./data');

const NEAR = 40.0;          // a giver or ender "ran past"
const HUB = 120.0;          // a hub's span
const STOP_YD = 50.0;       // consecutive goals within this are one stop
const SAMPLE_YD = 8.0;
const OBJ_TYPES = new Set(['kill', 'collect', 'interact', 'use', 'talk', 'complete', 'escort']);
const NEUTRAL = new Set(['goto', 'note', 'fly', 'level', 'die', 'vendor', 'buy', 'getfp', 'sethome', 'hearth']);

// Dynamic Questing, as addon/Polestar/Core/Engine.lua (Own.HERE_*; behavior.whileHere* defaults)
const WH_RADIUS = 180.0;                 // behavior.whileHereRadius, to a spawn spot's centre
const WH_ABOVE = 2;                      // Own.HERE_ABOVE
const WH_VERBS = new Set(['kill', 'collect', 'interact', 'use']);
const WH_TURNIN_036 = 30.0;              // 0.3.6 Own.HERE_TURNIN
const WH_TOWN = 100.0, WH_FAR = 250.0, WH_SOON = 2, WH_XP = 2;         // 0.3.7 (#1393)
const WH_SECONDS = 20.0, WH_WINDING = 1.25, WH_SPEED = 7.0;           // behavior.whileHereTurninSeconds, HERE_WINDING, HERE_SPEED
const WH_INN_YD = 50.0;                  // an inn's rest area (estimate)
const CAPITALS = new Set([1453, 1454, 1455, 1456, 1457, 1458]);   // resting anywhere in a capital
const WH_CHEAP = 30.0;                   // work this close is taken on a town hop or before a flight

// Python-style truthiness for the compiled guides' lists and tables (an empty one is false).
function truthy(v) {
	if (v == null || v === false || v === 0 || v === '') return false;
	if (Array.isArray(v)) return v.length > 0;
	if (typeof v === 'object') return Object.keys(v).length > 0;
	return Boolean(v);
}

const list = (v) => (Array.isArray(v) ? v : []);

class Counter extends Map {
	get(k) {
		return super.has(k) ? super.get(k) : 0;
	}

	add(k, v = 1) {
		this.set(k, this.get(k) + v);
	}
}

function applies(only, race, cls) {
	if (!truthy(only)) return true;
	if (truthy(only.races) && !list(only.races).includes(race)) return false;
	if (truthy(only.classes) && !list(only.classes).includes(cls)) return false;
	return true;
}

// A `when` list as the walk reads it: levels, and dungeons by `dungeons` ("all", or map ids "36,34": the dungeons the
// player runs; "" none) in the style `dungeonQuests` ("all": every quest of a dungeon run, "way": only the quests on the
// way): `when dungeon "<X>"` holds when X is run, `when dungeon "<X>" all` (compiled `all = true`) only when it is run
// with every quest. With `walk`, the character's state as the Engine reads it: onquest / complete (accepted and not
// handed in), turnedin, available (not yet taken or handed in), `done <label>`, taxi (a flight path learnt on the walk:
// its getfp lines, the flights taken), bound (the inn of the walk's last sethome), has (an item the walk got: collected,
// bought, a quest's starting item, with its count), zone (the zone of the walk's last goal); so a `taxi`/`!taxi` or
// `bound`/`!bound` pair plays one side, not both. knows never holds (the walk learns no spells: a fresh character does
// the training steps); group, money, skill, profession, item and reputation conditions never hold (the solo route, no
// optional purchases).
function whenOk(when, level, walk = null, dungeons = '', dungeonQuests = 'all') {
	for (const c of list(when)) {
		const k = c.k;
		let ok = true;
		if (walk && k === 'done') ok = walk.labelsPlayed.has(c.label);
		if (walk && (k === 'onquest' || k === 'complete' || k === 'turnedin' || k === 'available')) {
			const qs = Array.isArray(c.q) ? c.q : [c.q];
			const turned = (q) => walk.turninAt.has(q) || walk.dynTurned.has(q);
			if (k === 'turnedin') ok = qs.every(turned);
			else if (k === 'available') ok = qs.some((q) => !walk.acceptAt.has(q) && !turned(q));
			else ok = qs.some((q) => walk.acceptAt.has(q) && !turned(q));
		}
		if (walk && k === 'taxi') ok = walk.taxiKnown.has(c.node);
		if (walk && k === 'bound') {
			const b = walk.boundTo;
			ok = b != null && ((c.area != null && c.area === b.area) || c.name === b.location);
		}
		if (walk && k === 'has') ok = walk.itemN.get(c.item) >= (c.n || 1);
		if (walk && k === 'zone') ok = c.name === walk.zone;
		if (k === 'knows') ok = false;
		if (k === 'level') {
			const n = c.n ?? 0;
			const op = c.op ?? '>=';
			ok = op === '>=' ? level >= n : op === '<' ? level < n : op === '<=' ? level <= n : op === '>' ? level > n : level === n;
		} else if (k === 'dungeon') {
			ok = dungeons === 'all' || dungeons.split(',').includes(String(c.map));
			if (c.all) ok = ok && dungeonQuests === 'all';
		} else if (['group', 'money', 'skill', 'prof', 'item', 'rep'].includes(k)) {
			ok = false;
		}
		if (c.neg) ok = !ok;
		if (!ok) return false;
	}
	return true;
}

// A chain played as the addon hands over at each guide's end: the guide's `next` choices (nextChoices, the first the
// default) whose `nextWhen` holds at the walk's level, and of those the first one a wanted route choice names (`route`:
// substrings of guide ids: "riverglades", "shendralas", "hyjal"), else the first.
class Router {
	constructor(start, route = [], dungeons = '', dungeonQuests = 'all') {
		this.start = start;
		this.route = route;
		this.dungeons = dungeons;
		this.dungeonQuests = dungeonQuests;
	}

	nextOf(g, level) {
		const choices = (truthy(g.nextChoices) ? list(g.nextChoices) : [g.next]).filter(Boolean);
		const nw = g.nextWhen || {};
		const ok0 = choices.filter((c) => whenOk(nw[c], level, null, this.dungeons, this.dungeonQuests));
		const ok = ok0.length ? ok0 : choices;
		for (const want of this.route) for (const c of ok) if (c.includes(want)) return c;
		return ok.length ? ok[0] : null;
	}
}

// The dungeon a step is for (its `when dungeon` clause: the dungeon's name, else its map), or null.
function dungeonOf(when) {
	for (const c of list(when)) if (c.k === 'dungeon' && !c.neg) return c.name || String(c.map);
	return null;
}

// One objective of a quest: the walk's key for the same objective written twice.
function okeyOf(go) {
	return `${go.quest}:${go.oi || go.item || go.npc || go.object || go.t}`;
}

const itemQuestsCache = new WeakMap();
function itemQuestsOf(quests) {
	let m = itemQuestsCache.get(quests);
	if (!m) {
		m = new Map();
		for (const [qid, qd] of Object.entries(quests)) {
			for (const ob of list(qd.objectives)) {
				if (ob.type === 'item' && ob.id) {
					if (!m.has(ob.id)) m.set(ob.id, []);
					m.get(ob.id).push(Number(qid));
				}
			}
		}
		itemQuestsCache.set(quests, m);
	}
	return m;
}

// The first u in [0, 1] where segment a->b is within r of (cx, cy), or null.
function circleEnter(ax, ay, bx, by, cx, cy, r) {
	const dx = bx - ax, dy = by - ay;
	const fx = ax - cx, fy = ay - cy;
	const c2 = fx * fx + fy * fy - r * r;
	if (c2 <= 0) return 0.0;
	const a2 = dx * dx + dy * dy;
	if (a2 === 0) return null;
	const b2 = 2 * (fx * dx + fy * dy);
	const disc = b2 * b2 - 4 * a2 * c2;
	if (disc < 0) return null;
	const u = (-b2 - Math.sqrt(disc)) / (2 * a2);
	return u >= 0 && u <= 1 ? u : null;
}

function segDist(ax, ay, bx, by, cx, cy) {
	const dx = bx - ax, dy = by - ay;
	const a2 = dx * dx + dy * dy;
	const u = a2 === 0 ? 0.0 : Math.max(0.0, Math.min(1.0, ((cx - ax) * dx + (cy - ay) * dy) / a2));
	return Math.hypot(ax + dx * u - cx, ay + dy * u - cy);
}

const pathLen = (path) => {
	let s = 0;
	for (let i = 0; i < path.length - 1; i++) s += Math.hypot(path[i + 1][0] - path[i][0], path[i + 1][1] - path[i][1]);
	return s;
};

// The element of `items` with the smallest key, the first of equals (Python's min with a key).
function minBy(items, key) {
	let best = null, bk = Infinity, first = true;
	for (const it of items) {
		const k = key(it);
		if (first || k < bk) {
			best = it;
			bk = k;
			first = false;
		}
	}
	return best;
}

class Walk {
	// chain: a guide id list, or a Router (the strict walk hands over as it goes; the dynamic walk replays the strict
	// walk's `chain`). data: loadData's. dyn: null (strict), "036" or "037". future: quest -> level at the guide's own
	// hand-in on the strict walk (the XP rule). timed: quest -> timer seconds. take: "near" (lines taken where nearly
	// free, as players do) or "all". followups: accept the follow-ups an early hand-in's NPC gives (players do).
	constructor({ chain, race, cls, guides, legs, data, longFly = 0, dyn = null, future = null, timed = null, take = 'near', followups = true, dungeons = '', dungeonQuests = 'all' }) {
		this.race = race;
		this.cls = cls;
		this.proj = data.proj;
		this.quests = data.quests;
		this.nodes = data.nodes;
		this.longFly = longFly;
		this.zones = data.zones || {};
		this.entries = [];
		this.acceptAt = new Map();
		this.turninAt = new Map();
		this.readyAt = new Map();
		this.objLast = new Map();
		this.alongSteps = new Counter();
		this.alongGoals = new Counter();
		this.walkYd = new Counter();
		this.itemQuests = itemQuestsOf(this.quests);
		this.walkYdZone = new Counter();
		this.homeYd = new Counter();
		this.flightCount = new Counter();
		this.xp = 0.0;
		this.t = 0.0;
		this.L = 1;
		this.pos = null;
		this.bind = null;
		this.zone = null;
		this.pending = [];
		this.dyn = dyn;
		this.take = take;
		this.followups = followups;
		this.future = future || new Map();
		this.timed = timed || new Map();
		this.inns = data.inns || [];
		this.doneObj = new Set();
		this.played = new Set();
		this.itemsGot = new Set();
		this.itemN = new Counter();      // items got on the walk (collected, bought, a quest's starting item)
		this.taxiKnown = new Set();      // flight paths learnt (getfp lines of the steps played, flights taken)
		this.boundTo = null;             // the last sethome's { area, location }
		this.acceptT = new Map();
		this.dynDone = new Map();
		this.dynTurned = new Map();
		this.dynMoves = [];
		this.liveEscort = false;
		this.liveTurnins = new Set();
		this.curGi = null;
		this.dungeons = dungeons;
		this.dungeonQuests = dungeonQuests;
		this.chain = [];
		this.stepDng = new Map();
		this.labelsPlayed = new Set();
		if (dyn) this.dynPrepare(chain, guides);
		const doneObj = this.doneObj;
		for (const gid of this.chainIter(chain, guides)) {
			this.chain.push(gid);
			const g = guides.get(gid);
			const glegs = legs[gid] || {};
			g.steps.forEach((step, k) => {
				const dz = dungeonOf(step.when);
				if (dz) this.stepDng.set(`${gid}#${k + 1}`, dz);
			});
			this.labelsPlayed = new Set();
			for (let si = 1; si <= g.steps.length; si++) {
				const step = g.steps[si - 1];
				if (!applies(step.only, race, cls) || !whenOk(step.when, this.L, this, dungeons, dungeonQuests)) continue;
				if (step.label) this.labelsPlayed.add(step.label);
				if (dyn) {
					const gl = list(step.goals).filter((go) => !go.optional && applies(go.only, race, cls));
					this.liveEscort = gl.some((go) => truthy(go.escort) || go.t === 'escort');
					this.liveTurnins = new Set(gl.filter((go) => go.t === 'turnin').map((go) => go.quest));
				}
				const along = step.along;
				if (truthy(along)) this.alongSteps.add(gid);
				if (step.label) this.flush((p) => p.label === `${gid}#${step.label}`, g, gid, si);
				const leg = glegs[String(si)];
				let legUsed = false;
				const goals = list(step.goals);
				for (let gi = 0; gi < goals.length; gi++) {
					const go = goals[gi];
					const tt = go.t;
					if (tt === 'getfp' && go.node != null && applies(go.only, race, cls)) this.taxiKnown.add(go.node);   // learnt at its step, optional or not
					if (go.optional || !applies(go.only, race, cls)) continue;
					this.curGi = gi;
					if (tt === 'turnin' && this.dynTurned.has(go.quest)) continue;   // handed in already, on a While-here line
					if (tt === 'accept' && this.acceptAt.has(go.quest)) continue;
					if (OBJ_TYPES.has(tt) && go.quest != null) {
						const okey = okeyOf(go);
						if (doneObj.has(okey)) continue;   // the same objective written again later: already complete
						doneObj.add(okey);
					}
					if (truthy(along)) {
						this.alongGoals.add(gid);
						this.pending.push({ go, gid, step: si, label: typeof along === 'string' ? `${gid}#${along}` : `${gid}#`, targets: this.targets(go) });
						continue;
					}
					const q = go.quest;
					// the quest's along work must be done before it is handed in
					if (q != null && tt === 'turnin') this.flush((p) => p.go.quest === q, g, gid, si);
					legUsed = this.play(go, g, gid, si, leg, legUsed);
				}
			}
			this.flush((p) => p.gid === gid, g, gid, g.steps.length);
		}
		for (const [q, ia] of this.acceptAt) {
			const last = this.objLast.get(q);
			let r = ia;
			if (last != null) r = Math.max(r, last.i);
			else if (truthy((this.quests[String(q)] || {}).objectives) && this.turninAt.has(q)) r = this.turninAt.get(q) - 1;   // work the guide doesn't place: unknown
			this.readyAt.set(q, r);
		}
		this.endLevel = this.L + this.xp / XP_TO_LEVEL[Math.min(this.L, 59)];
		this.endT = this.t;
	}

	* chainIter(chain, guides) {
		if (!(chain instanceof Router)) {
			yield* chain;
			return;
		}
		let gid = chain.start;
		const seen = new Set();
		while (gid && guides.has(gid) && !seen.has(gid)) {
			seen.add(gid);
			yield gid;
			gid = chain.nextOf(guides.get(gid), this.L);
		}
	}

	// --- along work

	targets(go) {
		if (OBJ_TYPES.has(go.t) && go.spotsPacked) return parseSpots(go, this.proj).map((sp) => [sp[0], sp[1]]);
		if (go.x != null) {
			const p = this.proj.at(go.map, go.x, go.y);
			if (p) return [[p, NEAR]];
		}
		return [];
	}

	eligible(p) {
		const go = p.go;
		const q = go.quest;
		if (go.t === 'accept') return q == null || !this.acceptAt.has(q);
		if (q == null) return true;
		if (!this.acceptAt.has(q)) return false;
		if (go.t === 'turnin') return !this.pending.some((o) => o !== p && o.go.quest === q && o.go.t !== 'turnin');
		return true;
	}

	// The pending along work this walked path passes first: [distance along the path, item, spot], or null.
	firstPass(path, c) {
		let best = null;
		let run = 0.0;
		for (let k = 0; k < path.length - 1; k++) {
			const [ax, ay] = path[k];
			const [bx, by] = path[k + 1];
			const seg = Math.hypot(bx - ax, by - ay);
			for (const p of this.pending) {
				if (!this.eligible(p)) continue;
				for (const [pt, r] of p.targets) {
					if (pt[0] !== c) continue;
					// the first point of the segment within r of pt
					const dx = bx - ax, dy = by - ay;
					const fx = ax - pt[1], fy = ay - pt[2];
					const a2 = dx * dx + dy * dy;
					const b2 = 2 * (fx * dx + fy * dy);
					const c2 = fx * fx + fy * fy - r * r;
					let u;
					if (c2 <= 0) {
						u = 0.0;
					} else if (a2 === 0) {
						continue;
					} else {
						const disc = b2 * b2 - 4 * a2 * c2;
						if (disc < 0) continue;
						u = (-b2 - Math.sqrt(disc)) / (2 * a2);
						if (u < 0 || u > 1) continue;
					}
					const d = run + u * seg;
					if (best === null || d < best[0]) best = [d, p, pt];
				}
			}
			if (best !== null && best[0] <= run + seg) return best;
			run += seg;
		}
		return best;
	}

	// Do the pending along work matching pred now, as steps would: accepts, then work, then turn-ins, each time the
	// nearest one.
	flush(pred, g, gid, si) {
		const order = { accept: 0, turnin: 2 };
		const rankOf = (p) => order[p.go.t] ?? 1;
		for (;;) {
			let cand = this.pending.filter((p) => pred(p) && this.eligible(p));
			if (!cand.length) break;
			const rank = Math.min(...cand.map(rankOf));
			cand = cand.filter((p) => rankOf(p) === rank);
			const near = (p) => Math.min(Infinity, ...p.targets.map(([pt]) => dist(this.pos, pt)));
			const p = minBy(cand, near);
			this.pending.splice(this.pending.indexOf(p), 1);
			const spot = p.targets.length ? minBy(p.targets, (tr) => dist(this.pos, tr[0]))[0] : null;
			this.play(p.go, g, gid, si, null, true, { at: spot, fromAlong: p.step });
		}
		// work that can never be done (its quest was never taken on this branch) is dropped with its list, and an
		// along accept already taken by a later step is done
		const dead = (p) => {
			const q = p.go.quest;
			if (p.go.t === 'accept') return q != null && this.acceptAt.has(q);
			return q != null && !this.acceptAt.has(q);
		};
		this.pending = this.pending.filter((p) => !(pred(p) && dead(p)));
	}

	// --- one goal

	// Play one goal (walk to it, do it); returns legUsed. via: the walked path's start (points) up to where a
	// While-here line was taken (the rest goes straight to `at`); dynFrom: that line's step.
	play(go, g, gid, si, leg, legUsed, { at = null, fromAlong = null, via = null, dynFrom = null } = {}) {
		const proj = this.proj;
		const tt = go.t;
		const q = go.quest;
		const ownSi = fromAlong != null ? fromAlong : dynFrom != null ? dynFrom : si;
		if (this.dyn && at == null && this.pos != null && (tt === 'fly' || tt === 'hearth' || tt === 'die')) {
			// a line in reach before a flight, hearth or deathskip is taken first
			const here = [[this.pos[1], this.pos[2]], [this.pos[1], this.pos[2]]];
			const hit = this.dynFirst(here, this.pos[0], null, gid, si);
			if (hit != null) {
				this.dynTake(hit, g, gid, si, here);
				return this.play(go, g, gid, si, leg, legUsed);
			}
		}
		if (go.map != null) {
			const z = this.zones[String(go.map)];
			this.zone = z && 'name' in z ? z.name : String(go.map);
		}
		let newpos = null;
		let e;
		if (tt === 'fly') {
			const nd = this.nodes.get(go.node);
			e = this.newEntry(go, gid, si, fromAlong, ownSi);
			if (nd) {
				newpos = nd;
				const d = dist(this.pos, nd);
				this.t += (d < Infinity ? d * 1.25 : 3000) / FLY_YPS + 30;
				this.flightCount.add(gid);
				this.taxiKnown.add(go.node);
			}
			e.pos = newpos;
			e.mode = 'fly';
			this.pos = newpos || this.pos;
		} else if (tt === 'hearth') {
			e = this.newEntry(go, gid, si, fromAlong, ownSi);
			if (this.bind) this.pos = this.bind;
			this.t += 12;
			e.pos = this.pos;
			e.mode = 'tele';
		} else {
			if (at != null) {
				newpos = at;
			} else {
				if (go.x != null) newpos = proj.at(go.map, go.x, go.y);
				if (OBJ_TYPES.has(tt) && go.spotsPacked && this.pos != null) {
					// the arrow leads to the nearest spawn spot of a field goal, not its first
					let best = null;
					for (const sp of parseSpots(go, proj)) {
						const dd = dist(this.pos, sp[0]);
						if (best === null || dd < best[0]) best = [dd, sp[0]];
					}
					if (best !== null && best[0] < Infinity) newpos = best[1];
				}
			}
			if (newpos != null) {
				const pos = this.pos;
				const walking = pos != null && newpos[0] === pos[0] && tt !== 'die' && !(this.longFly && dist(pos, newpos) > this.longFly);
				let path = null;
				if (walking) {
					if (via != null) {
						path = [...via, [newpos[1], newpos[2]]];
					} else if (leg && !legUsed) {
						const pts = decodeLeg(leg);
						if (pts && Math.hypot(pts[0][0] - pos[1], pts[0][1] - pos[2]) < 120 && Math.hypot(pts[pts.length - 1][0] - newpos[1], pts[pts.length - 1][1] - newpos[2]) < 80) {
							path = [[pos[1], pos[2]], ...pts, [newpos[1], newpos[2]]];
						}
					}
					if (path === null) path = [[pos[1], pos[2]], [newpos[1], newpos[2]]];
					// along work this walk passes is done where it passes, as a step placed before this one; a While-here
					// line in reach first is taken first
					const fp = this.pending.length && at == null ? this.firstPass(path, newpos[0]) : null;
					const hit = this.dyn && at == null ? this.dynFirst(path, newpos[0], newpos, gid, si) : null;
					if (hit != null && (fp == null || hit[0] <= fp[0])) {
						this.dynTake(hit, g, gid, si, path);
						return this.play(go, g, gid, si, null, true);
					}
					if (fp != null) {
						const [, p, spot] = fp;
						this.pending.splice(this.pending.indexOf(p), 1);
						this.play(p.go, g, gid, si, null, true, { at: spot, fromAlong: p.step });
						return this.play(go, g, gid, si, null, true);
					}
				} else if (this.dyn && at == null && pos != null) {
					// a boat, zeppelin, portal or long ride: a line in reach here is taken first
					const here = [[pos[1], pos[2]], [pos[1], pos[2]]];
					const hit = this.dynFirst(here, pos[0], null, gid, si);
					if (hit != null) {
						this.dynTake(hit, g, gid, si, here);
						return this.play(go, g, gid, si, null, true);
					}
				}
				e = this.newEntry(go, gid, si, fromAlong, ownSi);
				if (walking) {
					const yd = pathLen(path);
					this.t += yd / WALK_YPS;
					this.walkYd.add(gid, yd);
					this.walkYdZone.add(this.zone, yd);
					if (this.zone === g.zoneName) this.homeYd.add(gid, yd);
					e.path = [newpos[0], path];
					e.mode = 'walk';
				} else {
					e.mode = 'tele';
					if (pos != null) this.t += 240;   // boat, zeppelin, portal or a deathskip
				}
				legUsed = true;
				this.pos = newpos;
				e.pos = newpos;
			} else {
				e = this.newEntry(go, gid, si, fromAlong, ownSi);
			}
		}
		e.move_s = this.t - e.t0;   // the travel to this goal (walk, flight, boat, hearth), before its work
		if (tt === 'sethome') {
			this.bind = this.pos;
			this.boundTo = { area: go.area, location: go.location };
		}
		// work time and XP
		let L = this.L, xp = this.xp;
		const cnt = go.count || 1;
		if (tt === 'accept' || tt === 'turnin') {
			this.t += 10;
		} else if (tt === 'kill') {
			this.t += 20 * cnt + 30;
			xp += KILL_XP_FACTOR * cnt * mobXp(go.lvl, L);
		} else if (tt === 'collect') {
			this.t += 25 * cnt + 30;
			if (go.lvl || go.fromKind === 'npc') xp += KILL_XP_FACTOR * cnt * 1.3 * mobXp(go.lvl, L);
		} else if (tt === 'interact' || tt === 'use' || tt === 'talk') {
			this.t += 15 * cnt;
		} else if (tt === 'complete') {
			this.t += 120;
			xp += KILL_XP_FACTOR * 3 * mobXp(null, L);
		} else if (['train', 'vendor', 'buy', 'getfp', 'sethome'].includes(tt)) {
			this.t += 20;
		}
		if (tt === 'turnin' && q != null) {
			const qd = this.quests[String(q)] || {};
			xp += questXp(qd.xp, qd.level, L);
		}
		if (tt === 'level') {
			const tgt = (go.level || 0) + (go.frac || 0);
			const cur = L + xp / XP_TO_LEVEL[Math.min(L, 59)];
			if (tgt > cur) {
				// grind: time at ~2 mobs a minute
				let need = 0.0;
				let l2 = L, x2 = xp;
				while (l2 + x2 / XP_TO_LEVEL[Math.min(l2, 59)] < tgt && l2 < 60) {
					const per = XP_TO_LEVEL[Math.min(l2, 59)];
					const part = Math.min(per - x2, (tgt - l2 - x2 / per) * per);
					need += part / Math.max(mobXp(l2, l2), 1);
					x2 += part;
					if (x2 >= per - 1e-6) {
						x2 -= per;
						l2 += 1;
					}
				}
				this.t += need * 35;
				L = l2;
				xp = x2;
			}
		}
		while (L < 60 && xp >= XP_TO_LEVEL[L]) {
			xp -= XP_TO_LEVEL[L];
			L += 1;
		}
		this.L = L;
		this.xp = xp;
		e.t1 = this.t;
		e.level = L;
		e.lv = pyRound(L + xp / XP_TO_LEVEL[Math.min(L, 59)], 2);
		e.i = this.entries.length;
		if (dynFrom != null) e.dyn_from = dynFrom;
		this.entries.push(e);
		if (tt === 'accept' && q != null) {
			if (!this.acceptAt.has(q)) this.acceptAt.set(q, e.i);
			if (!this.acceptT.has(q)) this.acceptT.set(q, this.t);
			const src = (this.quests[String(q)] || {}).sourceItem;
			if (src) {
				this.itemsGot.add(src);
				this.itemN.set(src, Math.max(this.itemN.get(src), 1));
			}
		}
		if (tt === 'turnin' && q != null && !this.turninAt.has(q)) this.turninAt.set(q, e.i);
		if (OBJ_TYPES.has(tt) && q != null) {
			this.objLast.set(q, e);
			this.played.add(okeyOf(go));
		} else if ((tt === 'collect' || tt === 'buy') && q == null && this.itemQuests.has(go.item)) {
			for (const q2 of this.itemQuests.get(go.item)) if (this.acceptAt.has(q2)) this.objLast.set(q2, e);
		}
		if ((tt === 'collect' || tt === 'buy') && go.item) {
			this.itemsGot.add(go.item);
			this.itemN.add(go.item, go.count || 1);
		}
		return legUsed;
	}

	// ownSi: the step the goal is written in (an along list's, a While-here line's), for its dungeon mark.
	newEntry(go, gid, si, fromAlong, ownSi = null) {
		return {
			i: null, gid, step: si, goal: go, pos: null, path: null, zone: this.zone, along: false, from_along: fromAlong,
			t0: this.t, level: this.L, dng: this.stepDng.get(`${gid}#${ownSi == null ? si : ownSi}`) || null,
		};
	}

	// --- Dynamic Questing (While you're here)

	// Per guide, the goals that may become lines (Own.hereGoalsOn: a quest, a place, work or a hand-in), and per quest
	// every objective goal the chain writes (for `ready`).
	dynPrepare(chain, guides) {
		this.whGoals = new Map();
		this.need = new Map();
		this.whSteps = new Map();
		for (const gid of chain) {
			const g = guides.get(gid);
			const lst = [];
			const steps = [];
			g.steps.forEach((step, k) => {
				const si = k + 1;
				if (!applies(step.only, this.race, this.cls)) return;
				const gl = list(step.goals).map((go, gi) => [gi, go]).filter(([, go]) => !go.optional && applies(go.only, this.race, this.cls));
				steps.push([si, step, gl]);
				for (const [gi, go] of gl) {
					const q = go.quest, tt = go.t;
					if (q != null && OBJ_TYPES.has(tt)) {
						if (!this.need.has(q)) this.need.set(q, new Set());
						this.need.get(q).add(okeyOf(go));
					}
					if (truthy(step.along) || q == null || go.map == null || go.x == null || truthy(go.candidates)) continue;
					if (WH_VERBS.has(tt)) {
						lst.push({ si, gi, go, step, okey: okeyOf(go), spots: parseSpots(go, this.proj) });
					} else if (tt === 'turnin') {
						const p = this.proj.at(go.map, go.x, go.y);
						if (p) lst.push({ si, gi, go, step, okey: null, npc_pt: p, capital: CAPITALS.has(go.map) });
					}
				}
			});
			this.whGoals.set(gid, lst);
			this.whSteps.set(gid, steps);
		}
	}

	// IsQuestReadyForTurnIn: every objective goal the chain writes for q played; a quest whose data has objectives the
	// guide never writes (a bought or carried item) is not known to be ready.
	ready(q) {
		const need = this.need.get(q);
		if (!need || !need.size) return !truthy((this.quests[String(q)] || {}).objectives);
		for (const k of need) if (!this.played.has(k)) return false;
		return true;
	}

	// Own.hereSoon (0.3.7): the route reaches the hand-in anyway in its next WH_SOON steps.
	soon(gid, si, c) {
		let k = 0;
		const npc = c.go.npc, obj = c.go.object;
		for (const [s2, step, gl] of this.whSteps.get(gid)) {
			if (s2 <= si || !whenOk(step.when, this.L, null, this.dungeons, this.dungeonQuests)) continue;
			if (s2 === c.si) return true;
			for (const [, o] of gl) {
				if ((npc != null && o.npc === npc) || (obj != null && o.object === obj)) {
					const q2 = o.quest, t2 = o.t;
					const done = (t2 === 'accept' && this.acceptAt.has(q2)) || (t2 === 'turnin' && this.turninAt.has(q2)) ||
						(OBJ_TYPES.has(t2) && q2 != null && this.doneObj.has(okeyOf(o)));
					if (!done) return true;
				}
			}
			k += 1;
			if (k >= WH_SOON) return false;
		}
		return false;
	}

	// Own.hereBlocked: the live step's escort, or a timed quest's timer running.
	dynBlocked() {
		if (this.liveEscort) return true;
		for (const [q, lim] of this.timed) {
			if (this.acceptAt.has(q) && !this.turninAt.has(q) && this.t - (this.acceptT.has(q) ? this.acceptT.get(q) : -1e9) < lim) return true;
		}
		return false;
	}

	// The lines that may show while the live step is (gid, si) (Own.hereBuild + Own.hereFits).
	dynCands(gid, si) {
		if (this.dynBlocked()) return [];
		const out = [];
		const L = this.L;
		const top = L + WH_ABOVE;
		for (const c of this.whGoals.get(gid) || []) {
			if (c.si <= si) continue;
			const go = c.go;
			const q = go.quest;
			if (!this.acceptAt.has(q) || this.turninAt.has(q)) continue;
			if (!whenOk(c.step.when, L, null, this.dungeons, this.dungeonQuests)) continue;
			if (go.t === 'turnin') {
				if (this.dynTurned.has(q) || this.liveTurnins.has(q) || !this.ready(q)) continue;
				let budget = WH_SECONDS;
				if (this.dyn === '037') {
					if (this.soon(gid, si, c)) continue;
					const fut = this.future.get(q);
					const qd = this.quests[String(q)] || {};
					if (fut != null && questXp(qd.xp || 1, qd.level, Math.trunc(fut)) < questXp(qd.xp || 1, qd.level, L)) budget = WH_SECONDS * WH_XP;
				}
				out.push({ c, kind: 'turnin', pts: [c.npc_pt], budget });
			} else {
				if (this.doneObj.has(c.okey) || this.ready(q)) continue;
				if (go.t === 'use' && go.item && !this.itemsGot.has(go.item)) continue;
				const spots = c.spots.filter((sp) => !(sp[3] && sp[3] > top)).map((sp) => [sp[0], sp[1]]);
				if (spots.length) out.push({ c, kind: 'work', pts: spots.map((s) => s[0]), r: spots.map((s) => s[1]) });
			}
		}
		return out;
	}

	// IsResting at world point P (estimate): an inn's rest area, or a capital (the NPC's map).
	resting(P, cand) {
		if (cand.c.capital) return true;
		return this.inns.some((ip) => dist(P, ip) <= WH_INN_YD);
	}

	// Whether line cd shows with the player at P (headed to dest), and what taking it from P costs (yards to its
	// nearest spawn area's edge, 0 inside one; yards to a hand-in's NPC).
	dynReach(cd, P, dest) {
		if (cd.kind === 'work') {
			let ok = false, cost = Infinity;
			for (let i = 0; i < cd.pts.length; i++) {
				const d = dist(P, cd.pts[i]);
				if (d <= WH_RADIUS) {
					ok = true;
					cost = Math.min(cost, Math.max(0.0, d - cd.r[i]));
				}
			}
			return [ok, cost];
		}
		const pt = cd.pts[0];
		const d = dist(P, pt);
		if (this.dyn === '036') return [d <= WH_TURNIN_036, d];
		if (d > WH_FAR) return [false, d];
		if (d <= WH_TOWN && this.resting(P, cd)) return [true, d];
		const extra = dest != null && dest[0] === P[0] ? d + dist(pt, dest) - dist(P, dest) : 2 * d;
		return [Math.max(extra, 0.0) * WH_WINDING / WH_SPEED <= cd.budget, d];
	}

	// Where the player goes for line cd from P: into its nearest spawn area (its edge; where they stand when inside
	// it), or the hand-in's NPC.
	dynTarget(cd, P) {
		if (cd.kind !== 'work') return cd.pts[0];
		let j = 0;
		for (let i = 1; i < cd.pts.length; i++) if (dist(P, cd.pts[i]) - cd.r[i] < dist(P, cd.pts[j]) - cd.r[j]) j = i;
		const pt = cd.pts[j], rr = cd.r[j];
		const d = dist(P, pt);
		return d <= rr ? P : [P[0], pt[1] + (P[1] - pt[1]) * rr / d, pt[2] + (P[2] - pt[2]) * rr / d];
	}

	// The first line to show on this walked path, and where the player takes it: [yards along the path, segment k,
	// point P, cand, where the player goes for it], or null. The line shows where the walk first comes in reach; the
	// player takes it at the cheapest point while it stays in reach. dest: where the live step leads. On a short hop
	// (under HUB yards, NPC to NPC in a town) and before a flight, hearth, boat or deathskip (a path of one point), only
	// what is nearly free is taken: a hand-in in reach, or work whose spawn area is within WH_CHEAP yards.
	dynFirst(path, c, dest, gid, si) {
		const cands = this.dynCands(gid, si);
		if (!cands.length) return null;
		const plen = pathLen(path);
		if (plen < HUB || this.take === 'near') {
			// the first point of the walk where a line is nearly free: inside (or within WH_CHEAP yards of) its spawn
			// area, or a hand-in in reach; the cheapest of those there
			let run = 0.0;
			for (let k = 0; k < path.length - 1; k++) {
				const [ax, ay] = path[k];
				const [bx, by] = path[k + 1];
				const seg = Math.hypot(bx - ax, by - ay);
				const near = [];
				for (const cd of cands) {
					if (cd.kind === 'work') {
						const lim = WH_RADIUS;
						if (cd.pts.some((pt, i) => pt[0] === c && segDist(ax, ay, bx, by, pt[1], pt[2]) <= Math.min(lim, cd.r[i] + WH_CHEAP))) near.push(cd);
					} else if (cd.pts[0][0] === c && segDist(ax, ay, bx, by, cd.pts[0][1], cd.pts[0][2]) <= (this.dyn === '036' ? WH_TURNIN_036 : WH_FAR)) {
						near.push(cd);
					}
				}
				if (near.length) {
					const n = Math.max(1, Math.trunc(seg / SAMPLE_YD));
					for (let s = 0; s <= n; s++) {
						const u = s / n;
						const P = [c, ax + (bx - ax) * u, ay + (by - ay) * u];
						let best = null;
						for (const cd of near) {
							const [ok, cost] = this.dynReach(cd, P, dest);
							if (ok && (cd.kind === 'turnin' || cost <= WH_CHEAP) && (best === null || cost < best[0])) best = [cost, cd];
						}
						if (best !== null) return [run + u * seg, k, P, best[1], this.dynTarget(best[1], P)];
					}
				}
				run += seg;
			}
			return null;
		}
		let first = null;   // [k, u, cd]
		for (let k = 0; k < path.length - 1; k++) {
			const [ax, ay] = path[k];
			const [bx, by] = path[k + 1];
			const seg = Math.hypot(bx - ax, by - ay);
			for (const cd of cands) {
				if (cd.kind === 'work' || this.dyn === '036') {
					const r = cd.kind === 'work' ? WH_RADIUS : WH_TURNIN_036;
					for (const pt of cd.pts) {
						if (pt[0] !== c) continue;
						const u = circleEnter(ax, ay, bx, by, pt[1], pt[2], r);
						if (u !== null && (first === null || u < first[1])) first = [k, u, cd];
					}
				} else {
					const pt = cd.pts[0];
					if (pt[0] !== c || segDist(ax, ay, bx, by, pt[1], pt[2]) > WH_FAR) continue;
					const n = Math.max(1, Math.trunc(seg / SAMPLE_YD));
					for (let s = 0; s <= n; s++) {
						const u = s / n;
						if (first !== null && u >= first[1]) break;
						if (this.dynReach(cd, [c, ax + (bx - ax) * u, ay + (by - ay) * u], dest)[0]) {
							first = [k, u, cd];
							break;
						}
					}
				}
			}
			if (first !== null) break;
		}
		if (first === null) return null;
		const [k0, u0, cd] = first;
		// walk on while it stays in reach, to the cheapest point
		let run0 = 0;
		for (let i = 0; i < k0; i++) run0 += Math.hypot(path[i + 1][0] - path[i][0], path[i + 1][1] - path[i][1]);
		let best = null;   // [cost, run, k, u, P]
		let run = run0;
		for (let k = k0; k < path.length - 1; k++) {
			const [ax, ay] = path[k];
			const [bx, by] = path[k + 1];
			const seg = Math.hypot(bx - ax, by - ay);
			const n = Math.max(1, Math.trunc(seg / SAMPLE_YD));
			const uFrom = k === k0 ? u0 : 0.0;
			let left = false;
			for (let s = 0; s <= n; s++) {
				const u = s / n;
				if (u < uFrom) continue;
				const P = [c, ax + (bx - ax) * u, ay + (by - ay) * u];
				const [ok, cost] = this.dynReach(cd, P, dest);
				if (!ok) {
					if (best !== null) {
						left = true;
						break;
					}
					continue;
				}
				if (best === null || cost < best[0] - 1e-6) best = [cost, run + u * seg, k, u, P];
				if (cost <= 0) {
					left = true;
					break;
				}
			}
			if (left) break;
			run += seg;
		}
		if (best === null) {
			const segLen = Math.hypot(path[k0 + 1][0] - path[k0][0], path[k0 + 1][1] - path[k0][1]);
			best = [0.0, run0 + u0 * segLen, k0, u0, [c, path[k0][0] + (path[k0 + 1][0] - path[k0][0]) * u0, path[k0][1] + (path[k0 + 1][1] - path[k0][1]) * u0]];
		}
		const [, sAlong, k, , P] = best;
		const end = path[path.length - 1];
		// cheapest where the live goal is, and not free: the player does the live goal first; the line is taken on the
		// walk out from there
		if (Math.hypot(P[1] - end[0], P[2] - end[1]) <= STOP_YD && best[0] > WH_CHEAP) return null;
		return [sAlong, k, P, cd, this.dynTarget(cd, P)];
	}

	// Take the line: walk the path to where it showed, then to its spot or NPC, and do it there.
	dynTake(hit, g, gid, si, path) {
		const [, k, P, cd, tgt] = hit;
		const c = cd.c;
		const go = c.go;
		const q = go.quest;
		const move = {
			gid, step: c.si, gi: c.gi, t: go.t, quest: q, oi: go.oi ?? null, at_gid: gid, at_step: si, at_gi: this.curGi,
			yd: pyRound(dist(P, tgt)), lv: pyRound(this.L + this.xp / XP_TO_LEVEL[Math.min(this.L, 59)], 2),
		};
		if (cd.kind === 'work') {
			this.doneObj.add(c.okey);
			this.dynDone.set(c.okey, move);
		} else {
			this.dynTurned.set(q, move);
		}
		this.dynMoves.push(move);
		const via = [...path.slice(0, k + 1), [P[1], P[2]]];
		this.play(go, g, gid, si, null, true, { at: tgt, via, dynFrom: c.si });
		move.i = this.entries.length - 1;
		if (cd.kind === 'turnin' && this.followups) this.dynFollowups(g, gid, si, go, q, tgt);
	}

	// After a While-here hand-in, the follow-ups the same NPC gives that this guide takes later, accepted there
	// (players do: about 4 in 5 within 2 minutes of an early hand-in, players' recordings).
	dynFollowups(g, gid, si, go, q, at) {
		const npc = go.npc;
		if (npc == null) return;
		for (const [s2, step, gl] of this.whSteps.get(gid)) {
			if (s2 <= si || !whenOk(step.when, this.L, null, this.dungeons, this.dungeonQuests)) continue;
			for (const [gi2, o] of gl) {
				const q2 = o.quest;
				if (o.t !== 'accept' || o.npc !== npc || q2 == null || this.acceptAt.has(q2)) continue;
				const qd = this.quests[String(q2)] || {};
				const preAny = new Set([...list(o.pre), ...list(qd.pre), ...list(qd.preAny)]);
				const preAll = new Set([...list(o.preAll), ...list(qd.preAll)]);
				if (!preAny.has(q) && !preAll.has(q)) continue;
				if (preAny.size && ![...preAny].some((p) => this.turninAt.has(p))) continue;
				if ([...preAll].some((p) => !this.turninAt.has(p))) continue;
				if (o.minLevel && this.L < o.minLevel) continue;
				const move = {
					gid, step: s2, gi: gi2, t: 'accept', quest: q2, oi: null, followup: true, at_gid: gid, at_step: si, at_gi: this.curGi,
					yd: 0, lv: pyRound(this.L + this.xp / XP_TO_LEVEL[Math.min(this.L, 59)], 2),
				};
				this.dynMoves.push(move);
				this.play(o, g, gid, si, null, true, { at, dynFrom: s2 });
				move.i = this.entries.length - 1;
			}
		}
	}
}

module.exports = {
	NEAR, HUB, STOP_YD, SAMPLE_YD, OBJ_TYPES, NEUTRAL, truthy, list, Counter, applies, whenOk, Router, dungeonOf, okeyOf,
	circleEnter, segDist, minBy, Walk,
};
