'use strict';
// The hub view (the planner's "Quest marks" layer, command hub_view): at a
// step of a timeline, the quest marks the game shows the character around it
// and how the walk moves through the hub there, to see why a route goes back
// and forth in a town (Fitz in Brill, c12w).
//
// Marks, as the game shows them at the step's start:
//   yellow !  a quest the character can take now: level reached, its
//             prerequisites handed in, not taken or done, nothing that closes
//             it taken (its breadcrumb's quest, its exclusive group), its
//             parent in the log, the character's side, race and class;
//   grey !    the same, its level GREY_LEVELS or fewer levels away;
//   yellow ?  a hand-in whose quest is in the log with its work done;
//   grey ?    a hand-in whose quest is in the log, work not done yet;
//   faint !   (tone 'locked', not a game mark) a quest that would show but
//             for a prerequisite not handed in yet (`after`): what the hub
//             offers next. Never a problem.
// Every mark has a tooltip (`tip`): the NPC and each quest's line.
// Quests the game never offers here are left out: unused/test titles (the
// world builder's), seasonal events, professions, repeatables, reputation
// gates; givers and enders are friendly NPCs (npcs.json faction) and objects.
//
// The walk, with the rules of forge-sim hubs.rs and forge-judge check/hub.rs,
// so the view and the check agree:
//   hub      the route's NPC places (accept, turnin, train, sethome, getfp,
//            vendor, talk, buy) linked within HUB_YD, single linkage;
//   visit    a run of goals at one hub: its NPC goals and other work within
//            HUB_YD of one of its places; a flight, hearth, death or entrance
//            ends it, goals without a place neither join nor break it;
//   left     at the first goal LEAVE_YD from every place of the hub;
//   passed   a walked leg (the timeline's track in walking modes) within
//            PAST_YD of the NPC;
//   ready    for the problems an accept also needs the quest's level less
//            READY_UNDER (the model's dangerGap, hubs.rs READY_UNDER).
// Problems of a visit: walked past (passed a ready mark, then left it
// LEAVE_YD behind before the route does it, or never does), left ready (the
// visit ended with ready marks at the hub's NPCs the route comes back for)
// and the hub's other visits. The ideal loop: the shortest straight walk from
// where the walk arrives through the visit's stops and the marks it left
// ready to where it goes on, each quest's own order kept (accept, work,
// hand-in; a prerequisite's hand-in before its follow-up), clockwise on the
// map preferred.

const fs = require('node:fs');
const path = require('node:path');
const { blockingPrereqs, closedByOf } = require('../lib/data/prereqs');
const { questAdmits } = require('../lib/planner/timeline');
const roads = require('../lib/nav/layers/roads');

// The hubs layer (forge nav layers hubs) beside the roads layer: data/local/nav-layers/hubs.json.
const HUBS_FILE = path.join(path.dirname(roads.ROADS_DIR), 'hubs.json');

const HUB_YD = 120;
const LEAVE_YD = 200;
const PAST_YD = 50;
const READY_UNDER = 5;
const GREY_LEVELS = 2;
// Marks within this of the hub's places (of the step's place outside a hub) are shown.
const AREA_YD = 320;
// A route goal this close to an NPC's spawn stands at that NPC (wanderers: the route's own point).
const AT_NPC_YD = 40;
// Goals this close are one place (one stop).
const SAME_YD = 6;
// Stops ordered exactly up to this many (Held-Karp); more: nearest first.
const LOOP_EXACT = 12;
// A step against the clock (on the map, around the stops' centre) costs this much more.
const CCW_COST = 0.12;

const NPC_VERBS = new Set(['accept', 'turnin', 'train', 'sethome', 'getfp', 'vendor', 'talk', 'buy']);
// Travel that ends a visit (forge-judge check.rs MOVES, goto aside: a goto inside a hub stays in it).
const TRAVEL = new Set(['fly', 'hearth', 'die', 'enter']);
const WORK = new Set(['kill', 'collect', 'interact', 'use', 'complete']);
// Timeline track modes a leg is walked in (timeline.js MODES: walk, ride, swim, climb, lift, indoor).
const WALKED = new Set([1, 6, 7, 9, 10, 11]);
// The world builder's unused/test quest titles (forge-world build.rs `unused`).
const UNUSED_RE = /\b(UNUSED|NYI|TEST|DEPRECATED)\b|^\[|<.*>|\(123\)/i;

const r1 = (v) => Math.round(v * 10) / 10;
const ids = (v) => (Array.isArray(v) ? v.map(Number).filter((n) => Number.isInteger(n) && n > 0) : []);
const d2 = (a, b) => Math.hypot(a.wx - b.wx, a.wy - b.wy);
const dist = (a, b) => (a.c === b.c ? d2(a, b) : Infinity);

// Yards from p to the segment a-b (one continent).
function segDist(p, ax, ay, bx, by) {
	const dx = bx - ax, dy = by - ay;
	const l2 = dx * dx + dy * dy;
	const t = l2 > 0 ? Math.max(0, Math.min(1, ((p.wx - ax) * dx + (p.wy - ay) * dy) / l2)) : 0;
	return Math.hypot(p.wx - ax - t * dx, p.wy - ay - t * dy);
}

// Every place an NPC or object spawns, as world points.
function spawnPoints(ws, kind, id) {
	const out = [];
	for (const s of ws.data.spawns(kind, id)) {
		const f = s.f === 'e' ? 'e' : 'l';
		for (const [x, y] of [...s.pts, ...s.more]) {
			const w = ws.geo.toWorld(s.map, x, y, f);
			if (w) out.push({ c: w.c, wx: w.wx, wy: w.wy, map: s.map, x, y });
		}
	}
	return out;
}

// A quest the game offers at all (character aside).
function offered(q) {
	if (!q || q.repeatable || q.minRep || q.reputation) return false;
	if (UNUSED_RE.test(String(q.title || ''))) return false;
	return !Number(q.event) && !Number(q.skill);
}

// --- the quest NPCs of one side, once per workspace -------------------------

const CELL = 256;
const cellKey = (c, wx, wy) => `${c}:${Math.floor(wx / CELL)}:${Math.floor(wy / CELL)}`;

function siteIndex(ws, side) {
	if (!ws.hubSites) ws.hubSites = new Map();
	if (ws.hubSites.has(side)) return ws.hubSites.get(side);
	const letter = side === 'Alliance' ? 'A' : 'H';
	const sites = new Map();
	const add = (kind, id, qid, role) => {
		const e = kind === 'npc' ? ws.data.npc(id) : ws.data.object(id);
		if (!e) return;
		if (kind === 'npc' && !String(e.faction || '').includes(letter)) return;
		const key = `${kind}:${id}`;
		let s = sites.get(key);
		if (!s) {
			s = { key, kind, id, name: String(e.name || key), pts: spawnPoints(ws, kind, id), gives: [], ends: [] };
			sites.set(key, s);
		}
		if (!s[role].includes(qid)) s[role].push(qid);
	};
	for (const q of Object.values(ws.data.quests)) {
		if (!offered(q)) continue;
		const st = q.start || {};
		const en = q.end || {};
		for (const id of ids(st.npc)) add('npc', id, q.id, 'gives');
		for (const id of ids(st.object)) add('object', id, q.id, 'gives');
		for (const id of ids(en.npc)) add('npc', id, q.id, 'ends');
		for (const id of ids(en.object)) add('object', id, q.id, 'ends');
	}
	const list = [...sites.values()].filter((s) => s.pts.length);
	const grid = new Map();
	list.forEach((s, i) => {
		for (const p of s.pts) {
			const k = cellKey(p.c, p.wx, p.wy);
			const cell = grid.get(k) || [];
			if (cell[cell.length - 1] !== i) cell.push(i);
			grid.set(k, cell);
		}
	});
	const index = { list, grid };
	ws.hubSites.set(side, index);
	return index;
}

// Sites with a spawn within r of one of `around` ([{ c, wx, wy }]).
function sitesNear(index, around, r) {
	const out = new Set();
	for (const p of around) {
		const n = Math.ceil(r / CELL);
		const cx = Math.floor(p.wx / CELL), cy = Math.floor(p.wy / CELL);
		for (let x = cx - n; x <= cx + n; x++) {
			for (let y = cy - n; y <= cy + n; y++) {
				for (const i of index.grid.get(`${p.c}:${x}:${y}`) || []) {
					if (!out.has(i) && index.list[i].pts.some((q) => dist(q, p) <= r)) out.add(i);
				}
			}
		}
	}
	return [...out].map((i) => index.list[i]);
}

// --- a timeline's walk, once per timeline ------------------------------------

const analyses = new WeakMap();

function analyse(tl) {
	if (analyses.has(tl)) return analyses.get(tl);
	const goals = [];
	const firstOf = [];
	for (const s of tl.steps) {
		firstOf[s.i] = goals.length;
		s.goals.forEach((g, gi) => goals.push({ s: s.i, gi, g, live: !!g.applies && !g.skip, at: g.applies && !g.skip && g.at ? g.at : null }));
	}
	firstOf[tl.steps.length] = goals.length;
	// An event's place in the goal order: in goal k at k, between a step's goals before its first.
	const posOf = (e) => (e.g == null ? firstOf[e.s] - 0.5 : firstOf[e.s] + e.g);
	const acceptAt = new Map();
	const turninAt = new Map();
	const readyAt = new Map();
	goals.forEach((x, k) => {
		if (!x.live || !x.g.quest) return;
		const q = x.g.quest.id;
		if (x.g.verb === 'accept' && !acceptAt.has(q)) acceptAt.set(q, k);
		else if (x.g.verb === 'turnin' && !turninAt.has(q)) turninAt.set(q, k);
	});
	const dings = [];
	for (const e of tl.events) {
		if (e.s == null || e.s < 0) continue;
		const p = posOf(e);
		if (e.type === 'ding') dings.push([p, e.level]);
		else if (e.type === 'ready' && !readyAt.has(e.quest)) readyAt.set(e.quest, p);
		else if (e.type === 'accept' && !(e.objectives || []).length && !readyAt.has(e.quest.id)) readyAt.set(e.quest.id, p);
	}
	const startLevel = tl.character.startLevel || 1;
	const levelBefore = (k) => {
		let lo = 0, hi = dings.length;
		while (lo < hi) {
			const m = (lo + hi) >> 1;
			if (dings[m][0] < k) lo = m + 1;
			else hi = m;
		}
		return lo ? dings[lo - 1][1] : startLevel;
	};

	// Hubs: the NPC places linked within HUB_YD (union-find over a grid).
	const places = [];
	const placeIx = new Map();
	const pkey = (at) => `${at.c}:${Math.round(at.wx)}:${Math.round(at.wy)}`;
	for (const x of goals) {
		if (!x.at || !NPC_VERBS.has(x.g.verb)) continue;
		const key = pkey(x.at);
		if (!placeIx.has(key)) {
			placeIx.set(key, places.length);
			places.push({ c: x.at.c, wx: x.at.wx, wy: x.at.wy });
		}
	}
	const pgrid = new Map();
	const hcell = (c, wx, wy) => `${c}:${Math.floor(wx / HUB_YD)}:${Math.floor(wy / HUB_YD)}`;
	places.forEach((p, i) => {
		const k = hcell(p.c, p.wx, p.wy);
		if (!pgrid.has(k)) pgrid.set(k, []);
		pgrid.get(k).push(i);
	});
	const placesNear = (p) => {
		const out = [];
		const cx = Math.floor(p.wx / HUB_YD), cy = Math.floor(p.wy / HUB_YD);
		for (let x = cx - 1; x <= cx + 1; x++) for (let y = cy - 1; y <= cy + 1; y++) for (const i of pgrid.get(`${p.c}:${x}:${y}`) || []) if (dist(places[i], p) <= HUB_YD) out.push(i);
		return out.sort((a, b) => a - b);
	};
	const parent = places.map((_, i) => i);
	const root = (x) => {
		while (parent[x] !== x) x = parent[x] = parent[parent[x]];
		return x;
	};
	places.forEach((p, a) => {
		for (const b of placesNear(p)) {
			const ra = root(a), rb = root(b);
			if (ra !== rb) parent[Math.max(ra, rb)] = Math.min(ra, rb);
		}
	});
	const hubOfRoot = new Map();
	const hubs = [];
	const hubOfPlace = places.map((p, i) => {
		const r = root(i);
		if (!hubOfRoot.has(r)) {
			hubOfRoot.set(r, hubs.length);
			hubs.push({ c: p.c, places: [] });
		}
		const h = hubOfRoot.get(r);
		hubs[h].places.push(p);
		return h;
	});

	// Visits: runs of goals at one hub.
	const visitOf = new Int32Array(goals.length).fill(-1);
	const visits = [];
	let open = -1;
	goals.forEach((x, k) => {
		if (!x.at) return;
		if (TRAVEL.has(x.g.verb)) {
			open = -1;
			return;
		}
		const cur = open >= 0 ? visits[open].hub : -1;
		let hub = -1;
		if (NPC_VERBS.has(x.g.verb)) hub = hubOfPlace[placeIx.get(pkey(x.at))];
		else {
			const near = [...new Set(placesNear(x.at).map((i) => hubOfPlace[i]))];
			hub = near.includes(cur) ? cur : near.length ? near[0] : -1;
		}
		if (hub < 0) {
			open = -1;
			return;
		}
		if (cur === hub) visits[open].g1 = k;
		else {
			visits.push({ hub, g0: k, g1: k, leave: goals.length });
			open = visits.length - 1;
		}
		visitOf[k] = open;
	});
	const farFrom = (at, pts) => pts.every((p) => !(dist(p, at) <= LEAVE_YD));
	for (const v of visits) {
		const pts = hubs[v.hub].places;
		for (let k = v.g1 + 1; k < goals.length; k++) {
			if (goals[k].at && farFrom(goals[k].at, pts)) {
				v.leave = k;
				break;
			}
		}
	}

	// Each goal's track samples: from the one before its start to its end.
	const T = tl.track.t;
	const trackOf = (k) => {
		const g = goals[k].g;
		let lo = 0, hi = T.length;
		while (lo < hi) {
			const m = (lo + hi) >> 1;
			if (T[m] < g.start) lo = m + 1;
			else hi = m;
		}
		let end = lo;
		while (end < T.length && T[end] <= g.end) end++;
		return [Math.max(0, lo - 1), end - 1];
	};

	const a = { goals, firstOf, acceptAt, turninAt, readyAt, levelBefore, hubs, visits, visitOf, trackOf };
	analyses.set(tl, a);
	return a;
}

// --- the hub view at a step -------------------------------------------------

let hubNames = null;
function hubNamesOf(file) {
	try {
		const stat = fs.statSync(file);
		if (!hubNames || hubNames.file !== file || hubNames.mtime !== stat.mtimeMs) hubNames = { file, mtime: stat.mtimeMs, doc: JSON.parse(fs.readFileSync(file, 'utf8')) };
		return hubNames.doc;
	} catch {
		return null;
	}
}

// The name of the hubs layer's hub with a disk nearest the places (within 150 yd);
// else, with `faction`, the hub's first quest NPC's name; else the zone's.
function hubName(ws, places, hubsFile, faction = null) {
	const doc = hubNamesOf(hubsFile);
	let best = null;
	let bd = 150;
	for (const h of (doc && doc[places[0].c]) || []) {
		for (const [x, y] of h.disks || []) {
			for (const p of places) {
				const d = Math.hypot(p.wx - x, p.wy - y);
				if (d < bd) {
					bd = d;
					best = h.name;
				}
			}
		}
	}
	if (best) return best;
	if (faction) {
		const npc = npcNear(sitesNear(siteIndex(ws, faction), places.slice(0, 1), AT_NPC_YD), places[0]);
		if (npc) return npc.name;
	}
	const z = ws.geo.containing(places[0].c, places[0].wx, places[0].wy, 'e')[0];
	return z ? ws.geo.zoneName(z.map) || null : null;
}

// opts: { hubsFile } -> the view (see the command's description in commands.js).
function hubView(ws, tl, character, step, opts = {}) {
	const A = analyse(tl);
	const { goals, firstOf, acceptAt, turninAt, readyAt, levelBefore, hubs, visits, visitOf } = A;
	// opts.visit: that hub visit (reviewScreens' index), at its first goal; else the step's.
	const forced = opts.visit != null && visits[opts.visit] ? opts.visit : -1;
	if (forced >= 0) step = goals[visits[forced].g0].s;
	const st = tl.steps[step];
	if (!st) return null;
	const data = ws.data;
	const index = siteIndex(ws, character.faction);

	// The goal the step stands at: its first live goal with a place (the visit's first goal).
	let k = forced >= 0 ? visits[forced].g0 : -1;
	for (let i = firstOf[step]; k < 0 && i < firstOf[step + 1]; i++) if (goals[i].at) k = i;
	let vi = forced;
	for (let i = firstOf[step]; i < firstOf[step + 1] && vi < 0; i++) vi = visitOf[i];
	const k0 = k >= 0 ? k : firstOf[step];
	const v = vi >= 0 ? visits[vi] : null;
	const hub = v ? hubs[v.hub] : null;
	let here = k >= 0 ? goals[k].at : null;
	if (!here && tl.track.t.length) {
		const j = Math.min(st.k0, tl.track.t.length - 1);
		here = { c: tl.track.c[j], wx: tl.track.x[j], wy: tl.track.y[j] };
	}
	if (!here) return null;
	const around = hub ? hub.places : [here];
	const c = around[0].c;

	// The character's quests before goal i.
	const done = (q, i) => turninAt.has(q) && turninAt.get(q) < i;
	const inLog = (q, i) => acceptAt.has(q) && acceptAt.get(q) < i && !done(q, i);
	const readyQ = (q, i) => inLog(q, i) && readyAt.has(q) && readyAt.get(q) < i;
	const gates = new Map();
	const gateOf = (q) => {
		if (!gates.has(q)) {
			const Q = data.quest(q);
			const b = blockingPrereqs(Q, (id) => data.quest(id));
			gates.set(q, { Q, all: b.all, any: b.any, closedBy: closedByOf(q, data.quests), admits: questAdmits(character, Q) });
		}
		return gates.get(q);
	};
	// The prerequisites of q not handed in before goal i (all of `all`; `any` when none of it is).
	const missingPre = (q, i) => {
		const gt = gateOf(q);
		const out = gt.all.filter((p) => !done(p, i));
		if (gt.any.length && !gt.any.some((p) => done(p, i))) out.push(...gt.any);
		return out;
	};
	// 'ready' | 'grey' | 'locked' | null: what the game shows for taking q before goal i
	// ('locked': it would show, but a prerequisite is not handed in yet: a faint ! of what comes next).
	const offer = (q, i) => {
		const gt = gateOf(q);
		if (!gt.Q || !gt.admits || done(q, i) || inLog(q, i)) return null;
		const lvl = levelBefore(i);
		if (gt.Q.maxLevel > 0 && lvl > gt.Q.maxLevel) return null;
		if (gt.closedBy.some((x) => done(x, i) || inLog(x, i))) return null;
		if (Number(gt.Q.parent) > 0 && !inLog(Number(gt.Q.parent), i)) return null;
		const min = gt.Q.minLevel > 0 ? gt.Q.minLevel : 1;
		if (min - lvl > GREY_LEVELS) return null;
		if (missingPre(q, i).length) return 'locked';
		return lvl >= min ? 'ready' : 'grey';
	};
	// Ready for the problems: a ready hand-in, or an accept offered at the model's level.
	const due = (q, mark, i) => {
		if (mark === '?') return readyQ(q, i);
		if (offer(q, i) !== 'ready') return false;
		const Q = gateOf(q).Q;
		return !(Q.level > 0) || levelBefore(i) >= Q.level - READY_UNDER;
	};
	const actionAt = (q, mark) => (mark === '?' ? turninAt.get(q) : acceptAt.get(q));

	// The marks' sites: each NPC at the route's own point for it when the route stands by one of its spawns, else at its spawn nearest the hub.
	const routePts = new Map();
	const routePt = (site) => {
		if (routePts.has(site.key)) return routePts.get(site.key);
		let at = null;
		for (const q of site.gives.concat(site.ends)) {
			for (const r of [acceptAt.get(q), turninAt.get(q)]) {
				if (r === undefined || !goals[r].at) continue;
				const g = goals[r].at;
				if (site.pts.some((p) => dist(p, g) <= AT_NPC_YD) && around.some((p) => dist(p, g) <= AREA_YD)) {
					at = { c: g.c, wx: g.wx, wy: g.wy };
					break;
				}
			}
			if (at) break;
		}
		if (!at) {
			let bd = Infinity;
			for (const p of site.pts) {
				for (const a of around) {
					const d = dist(p, a);
					if (d < bd) {
						bd = d;
						at = { c: p.c, wx: p.wx, wy: p.wy };
					}
				}
			}
		}
		routePts.set(site.key, at);
		return at;
	};
	const sites = sitesNear(index, around, AREA_YD).map((s) => ({ s, at: routePt(s) })).filter((x) => x.at && around.some((a) => dist(a, x.at) <= AREA_YD));

	const routeOf = (q, mark, i) => {
		const r = actionAt(q, mark);
		if (r === undefined) return { route: 'never', step: null };
		return { route: r < i ? 'past' : goals[r].s === step ? 'here' : 'later', step: goals[r].s };
	};
	const title = (q) => {
		const Q = data.quest(q);
		return Q && Q.title ? String(Q.title) : `quest ${q}`;
	};
	const RANK = { '?ready': 5, '!ready': 4, '?grey': 3, '!grey': 2, '!locked': 1 };
	const marks = [];
	for (const { s, at } of sites) {
		const quests = [];
		for (const q of s.ends) if (inLog(q, k0)) quests.push({ id: q, title: title(q), mark: '?', tone: readyQ(q, k0) ? 'ready' : 'grey', ...routeOf(q, '?', k0) });
		for (const q of s.gives) {
			const o = offer(q, k0);
			if (!o) continue;
			const row = { id: q, title: title(q), mark: '!', tone: o, level: gateOf(q).Q.minLevel || null, ...routeOf(q, '!', k0) };
			if (o === 'locked') {
				const gt = gateOf(q);
				const all = gt.all.filter((p) => !done(p, k0)).map(title);
				const any = gt.any.length && !gt.any.some((p) => done(p, k0)) ? [gt.any.map(title).join(' or ')] : [];
				row.after = [...all, ...any].join(' and ');
			}
			quests.push(row);
		}
		if (!quests.length) continue;
		quests.sort((a, b) => RANK[b.mark + b.tone] - RANK[a.mark + a.tone] || a.id - b.id);
		const top = quests[0];
		const topQuests = quests.filter((x) => x.mark === top.mark && x.tone === top.tone);
		const tipOf = (x) => `${x.mark} ${x.title}${x.after ? ` (after ${x.after})` : x.tone === 'grey' && x.mark === '!' && x.level ? ` (level ${x.level})` : x.tone === 'grey' ? ' (in progress)' : ''}`;
		marks.push({
			key: s.key, kind: s.kind, id: s.id, name: s.name, c: at.c, wx: r1(at.wx), wy: r1(at.wy),
			mark: top.mark, tone: top.tone, inRoute: topQuests.some((x) => x.route !== 'never'), quests, flags: [],
			tip: [s.name, ...quests.map(tipOf)].join('\n'),
		});
	}
	const markByKey = new Map(marks.map((m) => [m.key, m]));

	const out = {
		step, level: levelBefore(k0), c, here: { c: here.c, wx: r1(here.wx), wy: r1(here.wy) },
		rules: { hubYd: HUB_YD, leaveYd: LEAVE_YD, pastYd: PAST_YD, readyUnder: READY_UNDER, greyLevels: GREY_LEVELS, areaYd: AREA_YD },
		hub: null, marks, counts: null, path: [], stops: [], walkedPast: [], passedSkipped: [], leftReady: [], leftSkipped: [], loop: null,
	};
	const count = (list) => ({ '!': list.filter((m) => m.mark === '!').length, '?': list.filter((m) => m.mark === '?').length });
	out.counts = {
		ready: count(marks.filter((m) => m.tone === 'ready')),
		grey: count(marks.filter((m) => m.tone === 'grey')),
		locked: count(marks.filter((m) => m.tone === 'locked')),
	};
	if (!v) return out;

	// --- the visit --------------------------------------------------------
	const name = hubName(ws, hub.places, opts.hubsFile || HUBS_FILE, character.faction);
	const ofHub = visits.map((x, i) => ({ x, i })).filter(({ x }) => x.hub === v.hub);
	out.hub = {
		name, c: hub.c, places: hub.places.map((p) => [r1(p.wx), r1(p.wy)]),
		visit: ofHub.findIndex(({ i }) => i === vi) + 1,
		visits: ofHub.map(({ x, i }) => ({ s0: goals[x.g0].s, s1: goals[x.g1].s, leave: x.leave < goals.length ? goals[x.leave].s : null, current: i === vi })),
		steps: [goals[v.g0].s, goals[v.g1].s],
	};
	const nearHub = (p) => hub.places.some((q) => dist(q, p) <= AREA_YD);
	// Where the walk from q to p crosses the area's edge (one of them inside), with p's mode.
	const edge = (q, p) => {
		const inside = nearHub(p);
		const at = (t) => ({ c: p.c, wx: q.wx + (p.wx - q.wx) * t, wy: q.wy + (p.wy - q.wy) * t, m: p.m });
		let lo = 0, hi = 1;
		for (let n = 0; n < 24; n++) {
			const mid = (lo + hi) / 2;
			if (nearHub(at(mid)) === inside) hi = mid;
			else lo = mid;
		}
		return at(inside ? hi : lo);
	};

	// The walk through it: the leg in (from where it comes within AREA_YD), the visit, the leg out (while within AREA_YD).
	let outK = -1;
	for (let i = v.g1 + 1; i < goals.length; i++) {
		if (goals[i].at) {
			outK = i;
			break;
		}
	}
	const legs = legsOf(tl, A, v.g0, outK >= 0 ? outK : v.g1); // the walk of each goal, clipped to the area
	for (const leg of legs) {
		const i = leg.k;
		let pts = leg.pts;
		if (i === v.g0) {
			const first = pts.findIndex((p) => nearHub(p));
			if (first < 0) pts = pts.slice(-1);
			else if (first > 0) pts = [pts[first - 1].c === pts[first].c ? edge(pts[first - 1], pts[first]) : pts[first], ...pts.slice(first)];
		}
		if (i === outK) {
			const last = pts.findIndex((p) => !nearHub(p));
			if (last === 0) pts = [];
			else if (last > 0) pts = [...pts.slice(0, last), ...(pts[last - 1].c === pts[last].c ? [edge(pts[last - 1], pts[last])] : [])];
		}
		leg.pts = pts;
	}
	out.path = runsOf(legs.filter((l) => l.pts.length), goals);

	// Our stops, numbered in order (a place's consecutive goals one stop).
	const stopGoals = [];
	for (let i = v.g0; i <= v.g1; i++) if (goals[i].at) stopGoals.push(i);
	out.stops = stopsOf(tl, goals, stopGoals, (at) => npcNear(sites, at));

	// Walked past: a walked segment within PAST_YD of a mark due then, the walk not at that NPC, and the route does it only after leaving it LEAVE_YD behind, or never.
	const seen = new Set();
	for (const leg of legs) {
		const j = leg.k;
		const gat = goals[j].at;
		for (const { s, at } of sites) {
			if (gat && dist(gat, at) <= SAME_YD) continue;
			let near = Infinity;
			for (let x = 1; x < leg.pts.length; x++) {
				const p = leg.pts[x], q = leg.pts[x - 1];
				if (!WALKED.has(p.m) || p.c !== at.c || q.c !== at.c) continue;
				near = Math.min(near, segDist(at, q.wx, q.wy, p.wx, p.wy));
			}
			if (!(near <= PAST_YD)) continue;
			for (const [mark, list] of [['?', s.ends], ['!', s.gives]]) {
				for (const q of list) {
					const key = `${s.key}|${mark}|${q}`;
					if (seen.has(key) || !due(q, mark, j)) continue;
					const r = actionAt(q, mark);
					if (r !== undefined && r < j) continue;
					let left = r === undefined;
					if (!left) for (let x = j + 1; x < r; x++) if (goals[x].at && !(dist(goals[x].at, at) <= LEAVE_YD)) {
						left = true;
						break;
					}
					if (!left) continue;
					seen.add(key);
					const row = { key: s.key, name: s.name, c: at.c, wx: r1(at.wx), wy: r1(at.wy), quest: q, title: title(q), mark, yd: Math.round(near), passStep: goals[j].s, doneStep: r === undefined ? null : goals[r].s };
					(r === undefined ? out.passedSkipped : out.walkedPast).push(row);
					const m = markByKey.get(s.key);
					if (m && r !== undefined && !m.flags.includes('walked')) m.flags.push('walked');
				}
			}
		}
	}

	// Left ready: at the visit's end, marks due at the hub's NPCs the route does only after leaving.
	const kEnd = v.g1 + 1;
	for (const { s, at } of sites) {
		if (!hub.places.some((p) => dist(p, at) <= HUB_YD)) continue;
		for (const [mark, list] of [['?', s.ends], ['!', s.gives]]) {
			for (const q of list) {
				if (!due(q, mark, kEnd)) continue;
				const r = actionAt(q, mark);
				if (r !== undefined && r < v.leave) continue;
				const row = { key: s.key, name: s.name, c: at.c, wx: r1(at.wx), wy: r1(at.wy), quest: q, title: title(q), mark, doneStep: r === undefined ? null : goals[r].s };
				(r === undefined ? out.leftSkipped : out.leftReady).push(row);
				const m = markByKey.get(s.key);
				if (m && r !== undefined && !m.flags.includes('left')) m.flags.push('left');
			}
		}
	}

	out.loop = idealLoop({ goals, v, legs, stopGoals, leftReady: out.leftReady, gateOf });
	return out;
}

// --- shared by the hub view and the review screens -------------------------

// The track of goals g0..g1 (live ones), one leg per goal: [{ k, pts: [{ c, wx, wy, m }] }].
function legsOf(tl, A, g0, g1) {
	const tr = tl.track;
	const legs = [];
	for (let i = g0; i <= g1; i++) {
		if (!A.goals[i].live) continue;
		const [a, b] = A.trackOf(i);
		const pts = [];
		for (let j = a; j <= b; j++) pts.push({ c: tr.c[j], wx: tr.x[j], wy: tr.y[j], m: tr.m[j] });
		if (pts.length) legs.push({ k: i, pts });
	}
	return legs;
}

// Legs drawn as runs of one mode (a sample's mode is the segment's into it; standing is walking).
function runsOf(legs, goals) {
	const out = [];
	for (const leg of legs) {
		let run = null;
		for (let j = 1; j < leg.pts.length; j++) {
			const p = leg.pts[j], q = leg.pts[j - 1];
			if (p.c !== q.c) {
				run = null;
				continue;
			}
			if (d2(p, q) < 0.5) continue;
			const mode = p.m === 0 ? 1 : p.m;
			if (!run || run.mode !== mode) {
				run = { c: p.c, mode, step: goals[leg.k].s, pts: [r1(q.wx), r1(q.wy)] };
				out.push(run);
			}
			run.pts.push(r1(p.wx), r1(p.wy));
		}
	}
	return out;
}

// Numbered stops of goals `idx` (a place's consecutive goals one stop): each
// goal as an item { verb, label, quest, title, step, file, line }, and the
// stop's NPC (npcAt(point) -> { kind, id, name } | null).
function stopsOf(tl, goals, idx, npcAt) {
	const out = [];
	let lastAt = null;
	for (const i of idx) {
		const x = goals[i];
		const at = x.at;
		const st = tl.steps[x.s];
		const item = {
			verb: x.g.verb, label: x.g.label, quest: x.g.quest ? x.g.quest.id : null, title: x.g.quest ? x.g.quest.title : null,
			step: x.s, file: tl.guides[st.gi] ? tl.guides[st.gi].file : null, line: x.g.line,
		};
		if (lastAt && dist(lastAt, at) <= SAME_YD) {
			const s = out[out.length - 1];
			s.goals.push(item.label);
			s.items.push(item);
			s.s1 = x.s;
			continue;
		}
		out.push({ n: out.length + 1, c: at.c, wx: r1(at.wx), wy: r1(at.wy), step: x.s, s1: x.s, goals: [item.label], items: [item], npc: npcAt(at) });
		lastAt = at;
	}
	return out;
}

// The quest NPC standing at a point (within AT_NPC_YD, the nearest), of a site list [{ s, at }].
function npcNear(list, at) {
	let best = null;
	let bd = AT_NPC_YD;
	for (const x of list) {
		const d = dist(x.at || x.pts.find((p) => dist(p, at) <= AT_NPC_YD) || { c: -1 }, at);
		if (d <= bd) {
			bd = d;
			best = x.s || x;
		}
	}
	return best ? { kind: best.kind, id: best.id, name: best.name } : null;
}

// --- the review screens -------------------------------------------------------

// The route as review screens (the planner's review mode), in order: one per
// visit to a town ({ kind: 'hub', visits: [hub visit indices], n of `of`
// visits to it }: consecutive visits to route hubs of one name, Deathknell's
// crypt and church, are one) and, between them, one per run of located goals
// in one zone ({ kind: 'out' }, the field work), each with its goals g0..g1.
// Cached per timeline.
const screenCache = new WeakMap();
function screensOf(ws, tl, opts = {}) {
	if (screenCache.has(tl)) return screenCache.get(tl);
	const A = analyse(tl);
	const { goals, visits, hubs } = A;
	const names = new Map();
	const nameOf = (h) => {
		if (!names.has(h)) names.set(h, hubName(ws, hubs[h].places, opts.hubsFile || HUBS_FILE, tl.character.faction) || 'Hub');
		return names.get(h);
	};
	const list = [];
	const out = (from, to) => {
		let cur = null;
		for (let i = from; i <= to; i++) {
			const at = goals[i].at;
			if (!at) continue;
			const name = ws.geo.zoneName(at.map) || 'Away';
			if (!cur || cur.name !== name || cur.c !== at.c) {
				cur = { kind: 'out', name, c: at.c, g0: i, g1: i };
				list.push(cur);
			} else cur.g1 = i;
		}
	};
	let prev = -1;
	visits.forEach((v, vi) => {
		out(prev + 1, v.g0 - 1);
		const name = nameOf(v.hub);
		const last = list[list.length - 1];
		if (last && last.kind === 'hub' && last.name === name) {
			last.visits.push(vi);
			last.g1 = v.g1;
		} else list.push({ kind: 'hub', name, c: hubs[v.hub].c, g0: v.g0, g1: v.g1, visits: [vi] });
		prev = v.g1;
	});
	out(prev + 1, goals.length - 1);
	// A town visit the walk never left (LEAVE_YD from its places) before coming back is one
	// screen with the next, the errands between included; then field work runs of one zone
	// that end up side by side are one.
	for (let i = 0; i < list.length; i++) {
		const x = list[i];
		if (x.kind !== 'hub') continue;
		for (;;) {
			let j = i + 1;
			while (j < list.length && list[j].kind === 'out') j++;
			const y = list[j];
			if (!y || y.name !== x.name || visits[x.visits[x.visits.length - 1]].leave < y.g0) break;
			x.visits.push(...y.visits);
			x.g1 = y.g1;
			list.splice(i + 1, j - i);
		}
	}
	for (let i = list.length - 1; i > 0; i--) {
		const a = list[i - 1], b = list[i];
		if (a.kind === 'out' && b.kind === 'out' && a.name === b.name && a.c === b.c) {
			a.g1 = b.g1;
			list.splice(i, 1);
		}
	}
	const total = new Map();
	for (const x of list) if (x.kind === 'hub') total.set(x.name, (total.get(x.name) || 0) + 1);
	const seen = new Map();
	const screens = list.map((x, i) => {
		const st = tl.steps[goals[x.g0].s];
		const sc = { ...x, i, s0: goals[x.g0].s, s1: goals[x.g1].s, guide: tl.guides[st.gi] ? tl.guides[st.gi].id : null, level: A.levelBefore(x.g0) };
		if (x.kind === 'hub') {
			seen.set(x.name, (seen.get(x.name) || 0) + 1);
			sc.n = seen.get(x.name);
			sc.of = total.get(x.name);
		}
		return sc;
	});
	screenCache.set(tl, screens);
	return screens;
}

// One review screen's view: a town visit's hub view (its route visits' joined),
// or the field work's path and stops.
function screenView(ws, tl, character, i, opts = {}) {
	const screens = screensOf(ws, tl, opts);
	const sc = screens[i];
	if (!sc) return null;
	const A = analyse(tl);
	const { goals } = A;
	// every located goal of the screen a numbered stop, the NPC there named
	const rangeStops = () => {
		const idx = [];
		for (let k = sc.g0; k <= sc.g1; k++) if (goals[k].at) idx.push(k);
		const near = sitesNear(siteIndex(ws, character.faction), idx.map((k) => goals[k].at), AT_NPC_YD);
		return stopsOf(tl, goals, idx, (at) => npcNear(near, at));
	};
	if (sc.kind === 'hub') {
		const views = sc.visits.map((vi) => hubView(ws, tl, character, sc.s0, { ...opts, visit: vi }));
		const v = views[0];
		v.hub = { ...v.hub, name: sc.name, visit: sc.n, visits: Array.from({ length: sc.of }), steps: [sc.s0, sc.s1] };
		if (views.length === 1) return v;
		const keyed = (rows) => [...new Map(rows.map((w) => [`${w.key}|${w.mark}|${w.quest}`, w])).values()];
		// a problem the screen itself fixes (done in a later part of the visit) is none
		const later = (w) => w.doneStep == null || w.doneStep > sc.s1;
		const marks = new Map(v.marks.map((m) => [m.key, m]));
		for (const x of views.slice(1)) for (const m of x.marks) if (!marks.has(m.key)) marks.set(m.key, m);
		v.marks = [...marks.values()];
		v.path = views.flatMap((x) => x.path);
		v.stops = rangeStops();
		v.walkedPast = keyed(views.flatMap((x) => x.walkedPast)).filter(later);
		v.passedSkipped = keyed(views.flatMap((x) => x.passedSkipped));
		v.leftReady = keyed(views.flatMap((x) => x.leftReady)).filter(later);
		v.leftSkipped = keyed(views.flatMap((x) => x.leftSkipped));
		const loops = views.map((x) => x.loop);
		v.loop = loops.every(Boolean)
			? { c: loops[0].c, mode: 'joined', yards: loops.reduce((s, l) => s + l.yards, 0), ours: loops.reduce((s, l) => s + l.ours, 0), pts: loops.flatMap((l) => l.pts), stops: loops.flatMap((l) => l.stops), entry: loops[0].entry, exit: loops[loops.length - 1].exit }
			: null;
		const flagged = new Set([...v.walkedPast, ...v.leftReady].map((w) => w.key));
		for (const m of v.marks) m.flags = m.flags.filter((f) => flagged.has(m.key));
		return v;
	}
	return {
		step: sc.s0, level: sc.level, c: sc.c, here: null,
		rules: { hubYd: HUB_YD, leaveYd: LEAVE_YD, pastYd: PAST_YD, readyUnder: READY_UNDER, greyLevels: GREY_LEVELS, areaYd: AREA_YD },
		hub: null, marks: [], counts: { ready: { '!': 0, '?': 0 }, grey: { '!': 0, '?': 0 }, locked: { '!': 0, '?': 0 } },
		path: runsOf(legsOf(tl, A, sc.g0, sc.g1), goals),
		stops: rangeStops(),
		walkedPast: [], passedSkipped: [], leftReady: [], leftSkipped: [], loop: null,
	};
}

// Share of a view's walk over its ideal loop (0.17: 17% longer), null without a loop.
const overLoop = (v) => (v && v.loop && v.loop.yards > 0 ? Math.max(0, v.loop.ours / v.loop.yards - 1) : null);

// Each screen's problems { walked, left, over } (over: overLoop), for the review
// mode's "only screens with problems" filter. Cached per timeline and character.
const problemCache = new WeakMap();
function screenProblems(ws, tl, character, opts = {}) {
	const key = `${character.race}|${character.cls}`;
	if (!problemCache.has(tl)) problemCache.set(tl, new Map());
	const cache = problemCache.get(tl);
	if (!cache.has(key)) {
		cache.set(key, screensOf(ws, tl, opts).map((sc, i) => {
			if (sc.kind !== 'hub') return { walked: 0, left: 0, over: null };
			const v = screenView(ws, tl, character, i, opts);
			return { walked: v.walkedPast.length, left: v.leftReady.length, over: overLoop(v) };
		}));
	}
	return cache.get(key);
}

// --- the ideal loop -----------------------------------------------------------

// Goal b must come after goal a: one quest's accept, work, hand-in in that order; a prerequisite's (or the parent's) hand-in or accept before the follow-up's accept.
function mustFollow(a, b, gateOf) {
	const qa = a.quest ? a.quest.id : null;
	const qb = b.quest ? b.quest.id : null;
	const rank = (g) => (g.verb === 'accept' ? 0 : g.verb === 'turnin' ? 2 : WORK.has(g.verb) || g.verb === 'goto' ? 1 : -1);
	if (qa != null && qa === qb) return rank(a) >= 0 && rank(b) >= 0 && rank(a) < rank(b);
	if (b.verb === 'accept' && qa != null) {
		const gt = gateOf(qb);
		if (a.verb === 'turnin' && (gt.all.includes(qa) || gt.any.includes(qa))) return true;
		if (a.verb === 'accept' && gt.Q && Number(gt.Q.parent) === qa) return true;
	}
	return false;
}

function idealLoop({ goals, v, legs, stopGoals, leftReady, gateOf }) {
	if (!stopGoals.length) return null;
	const c = goals[stopGoals[0]].at.c;
	const inLeg = legs.find((l) => l.k === v.g0);
	const outLeg = legs.find((l) => l.k > v.g1);
	const entry = inLeg && inLeg.pts.length && inLeg.pts[0].c === c ? inLeg.pts[0] : goals[stopGoals[0]].at;
	const exitP = outLeg && outLeg.pts.length && outLeg.pts[outLeg.pts.length - 1].c === c ? outLeg.pts[outLeg.pts.length - 1] : null;
	const build = (byRun) => {
		const nodes = [];
		for (const i of stopGoals) {
			const at = goals[i].at;
			let n = byRun ? (nodes.length && dist(nodes[nodes.length - 1], at) <= SAME_YD ? nodes[nodes.length - 1] : null) : nodes.find((x) => !x.extra && dist(x, at) <= SAME_YD);
			if (!n) {
				n = { c: at.c, wx: at.wx, wy: at.wy, goals: [], extra: false, label: goals[i].g.label };
				nodes.push(n);
			}
			n.goals.push(i);
		}
		for (const m of leftReady) {
			if (nodes.some((x) => dist(x, m) <= SAME_YD)) continue;
			nodes.push({ c: m.c, wx: m.wx, wy: m.wy, goals: [], extra: true, label: `${m.name} (${m.mark} ${m.title})` });
		}
		const nodeOf = new Map();
		nodes.forEach((n, x) => n.goals.forEach((i) => nodeOf.set(i, x)));
		const pred = nodes.map(() => 0);
		for (let x = 0; x < stopGoals.length; x++) {
			for (let y = x + 1; y < stopGoals.length; y++) {
				const a = stopGoals[x], b = stopGoals[y];
				const u = nodeOf.get(a), w = nodeOf.get(b);
				if (u !== w && mustFollow(goals[a].g, goals[b].g, gateOf)) pred[w] |= 1 << u;
			}
		}
		return { nodes, pred };
	};
	// A cycle between places (A, B, back to A): stops by run instead.
	const acyclic = ({ nodes, pred }) => {
		const seen = new Array(nodes.length).fill(0);
		const visit = (x) => {
			if (seen[x] === 1) return false;
			if (seen[x] === 2) return true;
			seen[x] = 1;
			for (let u = 0; u < nodes.length; u++) if (pred[x] & (1 << u) && !visit(u)) return false;
			seen[x] = 2;
			return true;
		};
		return nodes.every((_, x) => visit(x));
	};
	let g = build(false);
	let mode = 'place';
	if (g.nodes.length > 30 || !acyclic(g)) {
		g = build(true);
		mode = 'run';
	}
	const { nodes, pred } = g;
	const n = nodes.length;
	if (n > 30 || !acyclic(g)) return null;
	const cx = nodes.reduce((s, p) => s + -p.wy, 0) / n;
	const cy = nodes.reduce((s, p) => s + -p.wx, 0) / n;
	const D = (a, b) => d2(a, b);
	// On the map (X = -wy east, Y = -wx south, y down): a step turning clockwise about the centre has a positive cross product.
	const cost = (a, b) => {
		const ax = -a.wy - cx, ay = -a.wx - cy, bx = -b.wy - cx, by = -b.wx - cy;
		const cross = ax * by - ay * bx;
		return D(a, b) * (cross < 0 ? 1 + CCW_COST : 1);
	};
	let order = null;
	if (n <= LOOP_EXACT) {
		const full = (1 << n) - 1;
		const dp = new Float64Array((full + 1) * n).fill(Infinity);
		const from = new Int8Array((full + 1) * n).fill(-1);
		for (let x = 0; x < n; x++) if (!pred[x]) dp[(1 << x) * n + x] = D(entry, nodes[x]);
		for (let mask = 1; mask <= full; mask++) {
			for (let x = 0; x < n; x++) {
				const cur = dp[mask * n + x];
				if (!Number.isFinite(cur)) continue;
				for (let y = 0; y < n; y++) {
					if (mask & (1 << y) || (pred[y] & ~mask) !== 0) continue;
					const m2 = mask | (1 << y);
					const c2 = cur + cost(nodes[x], nodes[y]);
					if (c2 < dp[m2 * n + y] - 1e-9) {
						dp[m2 * n + y] = c2;
						from[m2 * n + y] = x;
					}
				}
			}
		}
		let last = -1;
		let best = Infinity;
		for (let x = 0; x < n; x++) {
			const e = dp[full * n + x] + (exitP ? D(nodes[x], exitP) : 0);
			if (e < best) {
				best = e;
				last = x;
			}
		}
		if (last >= 0) {
			order = [];
			let mask = full;
			let x = last;
			while (x >= 0) {
				order.push(x);
				const u = from[mask * n + x];
				mask &= ~(1 << x);
				x = u;
			}
			order.reverse();
		}
	} else {
		mode = 'nearest';
		order = [];
		let done = 0;
		let at = entry;
		while (order.length < n) {
			let pick = -1;
			let bd = Infinity;
			for (let x = 0; x < n; x++) {
				if (done & (1 << x) || (pred[x] & ~done) !== 0) continue;
				const d = cost(at, nodes[x]);
				if (d < bd) {
					bd = d;
					pick = x;
				}
			}
			if (pick < 0) return null;
			order.push(pick);
			done |= 1 << pick;
			at = nodes[pick];
		}
	}
	if (!order) return null;
	const seq = [entry, ...order.map((x) => nodes[x]), ...(exitP ? [exitP] : [])];
	const yards = seq.slice(1).reduce((s, p, i) => s + D(seq[i], p), 0);
	const ours = [entry, ...stopGoals.map((i) => goals[i].at), ...(exitP ? [exitP] : [])];
	const oursYd = ours.slice(1).reduce((s, p, i) => s + D(ours[i], p), 0);
	return {
		c, mode, yards: Math.round(yards), ours: Math.round(oursYd),
		pts: seq.flatMap((p) => [r1(p.wx), r1(p.wy)]),
		stops: order.map((x) => ({ wx: r1(nodes[x].wx), wy: r1(nodes[x].wy), label: nodes[x].label, extra: nodes[x].extra })),
		entry: { wx: r1(entry.wx), wy: r1(entry.wy) }, exit: exitP ? { wx: r1(exitP.wx), wy: r1(exitP.wy) } : null,
	};
}

module.exports = { hubView, screensOf, screenView, screenProblems, spawnPoints, HUBS_FILE, HUB_YD, LEAVE_YD, PAST_YD, READY_UNDER, GREY_LEVELS };
